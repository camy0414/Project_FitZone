import { AnalisisMongo, EjercicioFrecuente, RutinasEntrenador } from '../model/analisis';
import { Rutina } from '../model/rutina';

/**
 * Calcula en el front las dos agregaciones de los reportes de rutinas, con el mismo resultado
 * que darían los pipelines de MongoDB. Se usa mientras el backend no tenga GET /rutina/analisis.
 */
export function calcularAnalisis(rutinas: Rutina[]): AnalisisMongo {
  // 1) $match activa + $unwind ejercicios + $group por nombre
  const ej = new Map<string, EjercicioFrecuente>();
  for (const r of rutinas.filter((v) => v.activa)) {
    for (const e of r.ejercicios) {
      const k = e.nombre.trim().toLowerCase();
      const g = ej.get(k) ?? { nombre: e.nombre.trim(), tipo: e.tipo, rutinas: 0 };
      g.rutinas++;
      ej.set(k, g);
    }
  }
  const ejercicios = [...ej.values()].sort((a, b) => b.rutinas - a.rutinas || a.nombre.localeCompare(b.nombre));

  // 2) $group por entrenador con $sum condicional
  const ent = new Map<number, RutinasEntrenador>();
  for (const r of rutinas) {
    const g = ent.get(r.idEmpleado) ?? { idEmpleado: r.idEmpleado, entrenador: r.entrenador, activas: 0, inactivas: 0 };
    if (r.activa) g.activas++; else g.inactivas++;
    ent.set(r.idEmpleado, g);
  }
  const rutinasEntrenador = [...ent.values()].sort((a, b) => b.activas + b.inactivas - (a.activas + a.inactivas));

  return { ejercicios, rutinasEntrenador };
}
