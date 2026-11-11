// Análisis de rutinas y progreso (resultados de las agregaciones de MongoDB).
import { TipoEjercicio } from './rutina';

/** $sort por fecha + $group por miembro con $first / $last. */
export interface TendenciaMiembro {
  idMiembro: number;
  miembro: string;
  sede: string;
  mediciones: number;
  pesoInicial: number;
  pesoActual: number;
  variacionKg: number;
  grasaInicial: number | null;
  grasaActual: number | null;
}

/** Último registro de cada miembro, agrupado por sede con $avg. */
export interface PromedioSede {
  idSede: number;
  sede: string;
  miembros: number;
  pesoPromedio: number;
  grasaPromedio: number | null;
}

/** $unwind de ejercicios en rutinas activas + $group por nombre. */
export interface EjercicioFrecuente {
  nombre: string;
  tipo: TipoEjercicio;
  rutinas: number;
}

/** $group por entrenador: rutinas activas e inactivas. */
export interface RutinasEntrenador {
  idEmpleado: number;
  entrenador: string;
  activas: number;
  inactivas: number;
}

export interface AnalisisMongo {
  tendencias: TendenciaMiembro[];
  promediosSede: PromedioSede[];
  ejercicios: EjercicioFrecuente[];
  rutinasEntrenador: RutinasEntrenador[];
}
