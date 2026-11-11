import { sesionIniciada } from './validaciones';

/**
 * Mensaje legible de un error. Primero el mensaje que envía el backend (texto de la
 * regla de negocio que falló); los genéricos solo si no hay mensaje.
 */
export function mensajeError(e: any): string {
  if (e?.status === 0) return 'No se pudo conectar con el servidor. Revisa tu conexión e inténtalo de nuevo.';
  // los errores internos del servidor (5xx) no se muestran tal cual: no le dicen nada al usuario
  if (e?.status >= 500) return 'Ocurrió un problema en el servidor. Inténtalo de nuevo en unos minutos.';
  // el backend puede responder { mensaje } o un texto plano con la regla que no se cumplió
  const propio = typeof e?.error === 'string' && e.error.trim() ? e.error : e?.error?.mensaje;
  if (propio && !propio.trim().startsWith('<')) return propio;
  if (e?.status === 401) return 'Tu sesión expiró. Vuelve a ingresar.';
  if (e?.status === 403) return 'No tienes permiso para realizar esta acción.';
  if (e?.status === 404) return 'No se encontró la información solicitada.';
  // errores del propio front (datos de ejemplo) traen su mensaje en e.message
  return e?.status ? 'No se pudo completar la operación.' : e?.message ?? 'No se pudo completar la operación.';
}

/** Fecha de hoy en formato YYYY-MM-DD (hora local). */
export function hoyISO(): string {
  return isoDesplazada(0);
}

/** Fecha YYYY-MM-DD desplazada n días respecto a hoy (hora local). */
export function isoDesplazada(dias = 0): string {
  const f = new Date();
  f.setDate(f.getDate() + dias);
  return `${f.getFullYear()}-${String(f.getMonth() + 1).padStart(2, '0')}-${String(f.getDate()).padStart(2, '0')}`;
}

/** Ordena sesiones por fecha y hora (ascendente por defecto). */
export function porFechaHora<T extends { fecha: string; horaInicio: string }>(lista: T[], desc = false): T[] {
  const k = (s: T) => s.fecha + s.horaInicio;
  return [...lista].sort((a, b) => (desc ? k(b).localeCompare(k(a)) : k(a).localeCompare(k(b))));
}

/**
 * Estado de una inscripción. Antes de que empiece la sesión el miembro solo está «inscrito»;
 * después, asistió o no asistió (la columna asistio es FALSE hasta que el entrenador la marca).
 */
export function estadoInscripcion(i: { asistio: boolean | null; fecha?: string; horaInicio?: string }): string {
  if (i.fecha && !sesionIniciada(i.fecha, i.horaInicio ?? '00:00')) return 'inscrito';
  if (i.asistio === null) return 'pendiente';
  return i.asistio ? 'asistió' : 'no asistió';
}

/** 'TARJETA' -> 'Tarjeta': para mostrar los nombres de los catálogos. */
export function nombrePropio(texto: string | null | undefined): string {
  const t = (texto ?? '').trim().toLowerCase();
  return t ? t[0].toUpperCase() + t.slice(1) : '';
}