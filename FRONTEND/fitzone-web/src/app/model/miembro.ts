// Tablas miembro e info_medica (1:1 opcional) y la ficha del miembro.
import { Membresia } from './membresia';
import { Pago } from './pago';
import { NombrePersona } from './persona';

export interface Miembro extends NombrePersona {
  idMiembro: number;
  nombreCompleto: string;
  correo: string;
  telefono: string;
  idSede: number;
  sede: string;
  /** miembro.fecha_registro (YYYY-MM-DD). */
  fechaRegistro: string;
  /** Plan de la membresía activa y vigente; null si no tiene. */
  planActual: string | null;
}

export interface NuevoMiembro {
  primerNombre: string; segundoNombre?: string;
  primerApellido: string; segundoApellido?: string;
  telefono: string; correo: string; idSede: number;
  infoMedica?: { contactoEmergencia: string; tipoSangre: string; condicionMedica?: string };
}

export type EdicionMiembro = NuevoMiembro;

export interface InfoMedica {
  contactoEmergencia: string;
  tipoSangre: string;
  condicionMedica: string | null;
}

/** Inscripción vista desde el miembro: la sesión y si asistió. */
export interface InscripcionMiembro {
  numeroSesion: number;
  clase: string;
  sede: string;
  fecha: string;
  horaInicio: string;
  fechaInscripcion: string;
  asistio: boolean | null;
}

export interface MiembroDetalle {
  miembro: Miembro;
  infoMedica: InfoMedica | null;
  membresias: Membresia[];
  pagos: Pago[];
  inscripciones: InscripcionMiembro[];
}
