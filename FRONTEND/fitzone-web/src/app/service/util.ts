/**
 * Mensaje legible de un error. Primero el mensaje que envía el backend (texto de la
 * regla de negocio que falló); los genéricos solo si no hay mensaje.
 */
export function mensajeError(e: any): string {
  // el backend puede responder { mensaje } o un texto plano
  const propio = typeof e?.error === 'string' && e.error.trim() ? e.error : e?.error?.mensaje ?? e?.error?.message;
  if (propio) return propio;
  if (e?.status === 0) return 'No se pudo conectar con el servidor.';
  if (e?.status === 401) return 'Tu sesión expiró. Vuelve a ingresar.';
  if (e?.status === 403) return 'No tienes permiso para realizar esta acción.';
  return e?.message ?? 'No se pudo completar la operación.';
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

/** Estado de una inscripción según miembro_sesion.asistio (NULL = aún sin registrar). */
export function estadoInscripcion(i: { asistio: boolean | null }): string {
  return i.asistio === null ? 'pendiente' : i.asistio ? 'asistió' : 'no asistió';
}