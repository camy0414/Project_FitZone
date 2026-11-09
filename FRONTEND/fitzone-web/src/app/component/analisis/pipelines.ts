/**
 * Pipelines de agregación de MongoDB que respaldan la vista de análisis.
 * Se muestran en pantalla (botón «Ver consulta») para la sustentación y sirven de
 * guía al backend. Los nombres de campo deben coincidir con el modelo documental
 * definitivo de las colecciones `rutinas` y `progreso`.
 * `$$SEDE` lo reemplaza el backend por la sede del token (el administrador ve todas).
 */
export const PIPELINES = {
  tendencias: `db.progreso.aggregate([
  { $match: { idSede: $$SEDE } },
  { $sort: { idMiembro: 1, fecha: 1 } },
  { $group: {
      _id: "$idMiembro",
      miembro:      { $first: "$miembro" },
      mediciones:   { $sum: 1 },
      pesoInicial:  { $first: "$pesoKg" },
      pesoActual:   { $last: "$pesoKg" },
      grasaInicial: { $first: "$grasaPct" },
      grasaActual:  { $last: "$grasaPct" }
  } },
  { $addFields: { variacionKg: { $round: [{ $subtract: ["$pesoActual", "$pesoInicial"] }, 1] } } },
  { $sort: { variacionKg: 1 } }
])`,

  promediosSede: `db.progreso.aggregate([
  { $sort: { idMiembro: 1, fecha: -1 } },
  { $group: {                       // última medición de cada miembro
      _id: "$idMiembro",
      idSede: { $first: "$idSede" },
      peso:   { $first: "$pesoKg" },
      grasa:  { $first: "$grasaPct" }
  } },
  { $group: {
      _id: "$idSede",
      miembros:      { $sum: 1 },
      pesoPromedio:  { $avg: "$peso" },
      grasaPromedio: { $avg: "$grasa" }
  } },
  { $sort: { _id: 1 } }
])`,

  ejercicios: `db.rutinas.aggregate([
  { $match: { activa: true, idSede: $$SEDE } },
  { $unwind: "$ejercicios" },
  { $group: {
      _id: { $toLower: "$ejercicios.nombre" },
      nombre:  { $first: "$ejercicios.nombre" },
      tipo:    { $first: "$ejercicios.tipo" },
      rutinas: { $sum: 1 }
  } },
  { $sort: { rutinas: -1, nombre: 1 } },
  { $limit: 8 }
])`,

  rutinasEntrenador: `db.rutinas.aggregate([
  { $match: { idSede: $$SEDE } },
  { $group: {
      _id: "$idEmpleado",
      entrenador: { $first: "$entrenador" },
      activas:    { $sum: { $cond: ["$activa", 1, 0] } },
      inactivas:  { $sum: { $cond: ["$activa", 0, 1] } }
  } },
  { $sort: { activas: -1 } }
])`,
} as const;

export type ClavePipeline = keyof typeof PIPELINES;
