/** Mensaje legible de un error (de la API o de una regla de negocio). */
export function mensajeError(e: any): string {
  if (e?.status === 0) return 'No se pudo conectar con el servidor.';
  if (e?.status === 403) return 'No tienes permiso para realizar esta acción.';
  return e?.error?.mensaje ?? e?.error?.message ?? e?.message ?? 'No se pudo completar la operación.';
}

/** Fecha de hoy en formato YYYY-MM-DD (hora local). */
export function hoyISO(): string {
  const f = new Date();
  return `${f.getFullYear()}-${String(f.getMonth() + 1).padStart(2, '0')}-${String(f.getDate()).padStart(2, '0')}`;
}
