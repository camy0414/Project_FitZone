// Reportes de rutinas (resultados de las agregaciones de MongoDB sobre la colección de rutinas).
import { TipoEjercicio } from './rutina';

/** $match activa + $unwind de ejercicios + $group por nombre: en cuántas rutinas activas aparece cada ejercicio. */
export interface EjercicioFrecuente {
  nombre: string;
  tipo: TipoEjercicio;
  rutinas: number;
}

/** $group por entrenador con $sum condicional: rutinas activas e inactivas de cada uno. */
export interface RutinasEntrenador {
  idEmpleado: number;
  entrenador: string;
  activas: number;
  inactivas: number;
}

/** Respuesta de GET /rutina/analisis (filtrada por la sede del token; el administrador ve todas). */
export interface AnalisisMongo {
  ejercicios: EjercicioFrecuente[];
  rutinasEntrenador: RutinasEntrenador[];
}
