export type RolNombre =
  | 'ADMIN_SISTEMA'
  | 'GERENTE_SEDE'
  | 'RECEPCIONISTA_SEDE'
  | 'ENTRENADOR_SEDE';

export const ROL_LABEL: Record<RolNombre, string> = {
  ADMIN_SISTEMA: 'Administrador de sistema',
  GERENTE_SEDE: 'Gerente de sede',
  RECEPCIONISTA_SEDE: 'Recepcionista de sede',
  ENTRENADOR_SEDE: 'Entrenador de sede',
};

/** Usuario en sesión (viene de fn_login + token del backend). */
export interface Usuario {
  idEmpleado: number;
  nombre: string;
  correo: string;
  rol: RolNombre;
  idSede: number;
  sede: string;
}

export interface LoginRespuesta {
  token: string;
  usuario: Usuario;
}

export interface Sede {
  idSede: number;
  nombre: string;
  direccion: string;
  telefono: string;
}

export interface Empleado {
  idEmpleado: number;
  nombreCompleto: string;
  correo: string;
  telefono: string;
  rol: RolNombre;
  idSede: number;
  sede: string;
  activo: boolean;
}

export interface Miembro {
  idMiembro: number;
  nombreCompleto: string;
  correo: string;
  telefono: string;
  idSede: number;
  sede: string;
  /** Plan de la membresía activa y vigente; null si no tiene. */
  planActual: string | null;
}

export interface Membresia {
  idMembresia: number;
  idMiembro: number;
  miembro: string;
  idSede: number;
  plan: string;
  estado: 'activa' | 'vencida' | 'cancelada';
  fechaInicio: string; // YYYY-MM-DD
  fechaFin: string;
}

export interface Pago {
  idPago: number;
  idMiembro: number;
  miembro: string;
  idSede: number;
  metodo: string;
  monto: number;
  fechaPago: string;
}

export interface Clase {
  idClase: number;
  nombre: string;
  descripcion: string;
  cupoMaximo: number;
  idSede: number;
  sede: string;
  idEmpleado: number;
  entrenador: string;
}

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

export interface Equipo {
  idEquipo: number;
  nombre: string;
  tipo: string;
  idSede: number;
  sede: string;
  fechaAdquisicion: string;
  /** Derivado: 'mantenimiento' si tuvo un mantenimiento en los últimos 30 días. */
  estado: 'operativo' | 'mantenimiento';
}

export interface Mantenimiento {
  numeroMantenimiento: number;
  idEquipo: number;
  equipo: string;
  idSede: number;
  sede: string;
  descripcion: string;
  costo: number;
  fecha: string;
}

/** Fila de un catálogo (tipo_plan, metodo_pago, tipo_equipo, rol_empleado). */
export interface Catalogo {
  id: number;
  nombre: string;
}

export interface Inscripcion {
  numeroSesion: number;
  idMiembro: number;
  miembro: string;
  fechaInscripcion: string;
  asistio: boolean;
}

// ---- Datos que envía cada formulario (los valida también el backend / la BD) ----
export interface NuevaSede { nombre: string; direccion: string; telefono: string }

export interface NuevoEmpleado {
  primerNombre: string; segundoNombre?: string;
  primerApellido: string; segundoApellido?: string;
  telefono: string; correo: string; clave: string;
  idRolEmpleado: number; idSede: number;
}

export interface NuevoMiembro {
  primerNombre: string; segundoNombre?: string;
  primerApellido: string; segundoApellido?: string;
  telefono: string; correo: string; idSede: number;
  infoMedica?: { contactoEmergencia: string; tipoSangre: string; condicionMedica?: string };
}

export interface RenovarMembresia {
  idMiembro: number; idTipoPlan: number; monto: number; idMetodoPago: number;
}

export interface NuevaClase {
  nombre: string; descripcion?: string; cupoMaximo: number; idSede: number; idEmpleado: number;
}

export interface NuevaSesion { idClase: number; fecha: string; horaInicio: string; horaFin: string }

export interface NuevoEquipo {
  nombre: string; idTipoEquipo: number; idSede: number; fechaAdquisicion: string;
}

export interface NuevoMantenimiento {
  idEquipo: number; costo: number; descripcion?: string; fecha: string;
}

// ---- MongoDB (fitzone_nosql): rutinas y progreso físico ----
export type TipoEjercicio = 'fuerza' | 'cardio' | 'movilidad';

/** Ejercicio polimórfico: los campos obligatorios dependen del tipo. */
export interface Ejercicio {
  nombre: string;
  tipo: TipoEjercicio;
  series?: number;
  repeticiones?: number;
  pesoKg?: number;
  duracionMin?: number;
  duracionSeg?: number;
  distanciaKm?: number;
  notas?: string;
}

export interface Rutina {
  idRutina: string;
  idMiembro: number;
  miembro: string;
  idEmpleado: number;
  entrenador: string;
  idSede: number;
  sede: string;
  nombreRutina: string;
  objetivo: string;
  fechaCreacion: string;
  activa: boolean;
  ejercicios: Ejercicio[];
  notasEntrenador?: string;
}

/** El entrenador y la sede los toma el backend del token. */
export interface NuevaRutina {
  idMiembro: number;
  nombreRutina: string;
  objetivo?: string;
  ejercicios: Ejercicio[];
  notasEntrenador?: string;
}

export interface Medidas { cinturaCm?: number; pechoCm?: number; brazoCm?: number; caderaCm?: number }

export interface Progreso {
  idProgreso: string;
  idMiembro: number;
  miembro: string;
  idSede: number;
  fecha: string;
  pesoKg: number;
  grasaPct?: number;
  medidas?: Medidas;
  notas?: string;
}

export interface NuevoProgreso {
  idMiembro: number;
  fecha: string;
  pesoKg: number;
  grasaPct?: number;
  medidas?: Medidas;
  notas?: string;
}
