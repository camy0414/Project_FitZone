// Tabla membresia.
/** membresia.estado: una membresía está activa o vencida (supuesto 7). */
export type EstadoMembresia = 'ACTIVA' | 'VENCIDA';

export interface Membresia {
  idMembresia: number;
  idMiembro: number;
  miembro: string;
  idSede: number;
  plan: string;
  estado: EstadoMembresia;
  fechaInicio: string; // YYYY-MM-DD
  fechaFin: string;
}

export interface RenovarMembresia {
  idMiembro: number; idTipoPlan: number; monto: number; idMetodoPago: number;
}
