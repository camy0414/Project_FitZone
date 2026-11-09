// Reportes: consultas sobre las tablas del modelo relacional.
export interface FiltroReporte {
  desde: string; // YYYY-MM-DD
  hasta: string;
  /** null = todas las sedes visibles para el usuario. */
  idSede: number | null;
}

/** Ingresos: pago ⨝ metodo_pago ⨝ miembro ⨝ sede, agrupado por sede y método. */
export interface ReporteIngreso {
  idSede: number;
  sede: string;
  metodo: string;
  numPagos: number;
  total: number;
}

/** Ocupación y asistencia: sesion ⨝ clase ⟕ miembro_sesion, por sesión. */
export interface ReporteOcupacion {
  numeroSesion: number;
  clase: string;
  idSede: number;
  sede: string;
  entrenador: string;
  fecha: string;
  horaInicio: string;
  cupoMaximo: number;
  inscritos: number;
  asistentes: number;
}

/** Membresías ACTIVA cuya fecha_fin cae en los próximos días. */
export interface MembresiaPorVencer {
  idMembresia: number;
  idMiembro: number;
  miembro: string;
  telefono: string;
  correo: string;
  idSede: number;
  sede: string;
  plan: string;
  fechaFin: string;
  diasRestantes: number;
}

/** Mantenimientos: mantenimiento_equipo ⨝ equipo ⨝ tipo_equipo, por sede y tipo. */
export interface ReporteMantenimiento {
  idSede: number;
  sede: string;
  tipo: string;
  numMantenimientos: number;
  costoTotal: number;
}
