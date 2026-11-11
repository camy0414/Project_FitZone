// Tablas sesion y miembro_sesion (inscripciones).
export interface Sesion {
  numeroSesion: number;
  idClase: number;
  clase: string;
  idSede: number;
  sede: string;
  idEmpleado: number;
  entrenador: string;
  fecha: string; // YYYY-MM-DD
  horaInicio: string; // HH:MM
  horaFin: string;
  cupoMaximo: number;
  inscritos: number;
}

export interface NuevaSesion { idClase: number; fecha: string; horaInicio: string; horaFin: string }

export interface Inscripcion {
  numeroSesion: number;
  idMiembro: number;
  miembro: string;
  fechaInscripcion: string;
  /** miembro_sesion.asistio: FALSE hasta que el entrenador marca la asistencia. */
  asistio: boolean | null;
  /** Fecha y hora de la sesión (las envía el backend; sirven para saber si ya empezó). */
  fecha?: string;
  horaInicio?: string;
}
