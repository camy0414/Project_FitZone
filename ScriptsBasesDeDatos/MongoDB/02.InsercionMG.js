// ============================================================
// FitZone - MongoDB - 02 Inserción de datos de ejemplo
// ============================================================

use("fitzone_nosql");

// Vaciar
db.rutinas_entrenamiento.deleteMany({});
db.progreso_fisico.deleteMany({});

db.rutinas_entrenamiento.insertMany([
  {
    id_miembro: 97, id_empleado: 7, id_sede: 1,
    nombre_rutina: "Fuerza - Fase 1", objetivo: "Ganancia de masa muscular",
    fecha_creacion: ISODate("2026-09-01"), activa: true,
    ejercicios: [
      { nombre: "Sentadilla", tipo: "fuerza", series: 4, repeticiones: 10, peso_kg: 40, notas: "Enfoque en profundidad" },
      { nombre: "Press banca", tipo: "fuerza", series: 4, repeticiones: 8, peso_kg: 35 },
      { nombre: "Peso muerto", tipo: "fuerza", series: 3, repeticiones: 8, peso_kg: 50, video_url: "https://fitzone.example.com/videos/peso-muerto" },
      { nombre: "Caminadora", tipo: "cardio", duracion_min: 10, distancia_km: 1.2, notas: "Calentamiento" }
    ],
    notas_entrenador: "Aumentar peso progresivamente cada 2 semanas."
  },
  {
    id_miembro: 101, id_empleado: 8, id_sede: 1,
    nombre_rutina: "Yoga - Flexibilidad", objetivo: "Mejorar movilidad y reducir estrés",
    fecha_creacion: ISODate("2026-03-15"), activa: true,
    ejercicios: [
      { nombre: "Saludo al sol", tipo: "movilidad", series: 3, duracion_seg: 90, notas: "Respiración profunda" },
      { nombre: "Postura del guerrero", tipo: "movilidad", series: 2, duracion_seg: 60 },
      { nombre: "Postura del niño", tipo: "movilidad", series: 1, duracion_seg: 120 }
    ]
  },
  {
    id_miembro: 131, id_empleado: 8, id_sede: 1,
    nombre_rutina: "Funcional - Resistencia", objetivo: "Mejorar resistencia cardiovascular",
    fecha_creacion: ISODate("2026-08-10"), activa: false,
    ejercicios: [
      { nombre: "Burpees", tipo: "fuerza", series: 4, repeticiones: 15 },
      { nombre: "Mountain climbers", tipo: "fuerza", series: 4, repeticiones: 20 },
      { nombre: "Kettlebell swing", tipo: "fuerza", series: 3, repeticiones: 12, peso_kg: 16 },
      { nombre: "Bicicleta estática", tipo: "cardio", duracion_min: 20 }
    ],
    notas_entrenador: "Rutina pausada por lesión leve en rodilla; retomar tras evaluación."
  },
  {
    id_miembro: 20, id_empleado: 11, id_sede: 2,
    nombre_rutina: "Cardio - Pérdida de grasa", objetivo: "Reducir porcentaje de grasa corporal",
    fecha_creacion: ISODate("2026-09-10"), activa: true,
    ejercicios: [
      { nombre: "Trote", tipo: "cardio", duracion_min: 30, distancia_km: 4.5 },
      { nombre: "Elíptica", tipo: "cardio", duracion_min: 20 },
      { nombre: "Plancha", tipo: "fuerza", series: 3, repeticiones: 1, notas: "Mantener 45 segundos" }
    ]
  },
  {
    id_miembro: 24, id_empleado: 15, id_sede: 3,
    nombre_rutina: "Fuerza - Tren superior", objetivo: "Ganancia de masa muscular",
    fecha_creacion: ISODate("2026-09-20"), activa: true,
    ejercicios: [
      { nombre: "Press militar", tipo: "fuerza", series: 4, repeticiones: 8, peso_kg: 30 },
      { nombre: "Remo con barra", tipo: "fuerza", series: 4, repeticiones: 10, peso_kg: 35 },
      { nombre: "Dominadas", tipo: "fuerza", series: 3, repeticiones: 6 }
    ]
  }
]);

db.progreso_fisico.insertMany([
  { id_miembro: 97, id_sede: 1, registrado_por: 7, fecha: ISODate("2026-08-01"), peso_kg: 82.5, grasa_corporal_pct: 22.0,
    medidas: { cintura_cm: 92, pecho_cm: 102, brazo_cm: 34 } },
  { id_miembro: 97, id_sede: 1, registrado_por: 7, fecha: ISODate("2026-09-01"), peso_kg: 80.8, grasa_corporal_pct: 20.5,
    medidas: { cintura_cm: 89, pecho_cm: 103, brazo_cm: 34.5 }, notas: "Mejora notable en cintura tras 4 semanas de rutina." },
  { id_miembro: 97, id_sede: 1, registrado_por: 7, fecha: ISODate("2026-10-01"), peso_kg: 79.9, grasa_corporal_pct: 19.4,
    medidas: { cintura_cm: 87, pecho_cm: 104, brazo_cm: 35 } },
  { id_miembro: 101, id_sede: 1, registrado_por: 8, fecha: ISODate("2026-03-20"), peso_kg: 61.0, grasa_corporal_pct: 24.0,
    medidas: { cintura_cm: 70, cadera_cm: 95 } },
  { id_miembro: 101, id_sede: 1, registrado_por: 8, fecha: ISODate("2026-06-20"), peso_kg: 59.5, grasa_corporal_pct: 22.8,
    medidas: { cintura_cm: 68, cadera_cm: 94 } },
  { id_miembro: 131, id_sede: 1, registrado_por: 8, fecha: ISODate("2026-08-05"), peso_kg: 90.2, grasa_corporal_pct: 27.5,
    medidas: { cintura_cm: 100, pecho_cm: 108, brazo_cm: 36 } },
  { id_miembro: 20, id_sede: 2, registrado_por: 11, fecha: ISODate("2026-09-10"), peso_kg: 88.0, grasa_corporal_pct: 26.0,
    medidas: { cintura_cm: 98 } },
  { id_miembro: 20, id_sede: 2, registrado_por: 11, fecha: ISODate("2026-10-08"), peso_kg: 85.9, grasa_corporal_pct: 24.7,
    medidas: { cintura_cm: 95 } },
  { id_miembro: 24, id_sede: 3, registrado_por: 15, fecha: ISODate("2026-09-20"), peso_kg: 72.0, grasa_corporal_pct: 18.0,
    medidas: { pecho_cm: 98, brazo_cm: 33 } }
]);

print("Datos de ejemplo insertados en fitzone_nosql: " +
      db.rutinas_entrenamiento.countDocuments() + " rutinas, " +
      db.progreso_fisico.countDocuments() + " registros de progreso.");