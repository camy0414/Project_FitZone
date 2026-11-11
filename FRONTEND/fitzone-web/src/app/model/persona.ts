// Columnas de nombre que comparten empleado y miembro.
/** Columnas de nombre que comparten empleado y miembro en el modelo. */
export interface NombrePersona {
  primerNombre: string;
  segundoNombre: string | null;
  primerApellido: string;
  segundoApellido: string | null;
}
