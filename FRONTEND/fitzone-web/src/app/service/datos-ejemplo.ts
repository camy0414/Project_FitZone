/**
 * Datos de ejemplo del modo visual (environment.useMock = true).
 * Siguen las tablas del modelo relacional y las colecciones de MongoDB.
 * Las fechas son relativas a hoy para que la demo siempre tenga sesiones
 * pasadas, de hoy y futuras.
 */
import { Catalogo } from '../model/catalogo';
import { Clase } from '../model/clase';
import { Empleado } from '../model/empleado';
import { Equipo, Mantenimiento } from '../model/equipo';
import { Membresia } from '../model/membresia';
import { InfoMedica, Miembro } from '../model/miembro';
import { Pago } from '../model/pago';
import { NombrePersona } from '../model/persona';
import { Progreso } from '../model/progreso';
import { Rutina } from '../model/rutina';
import { Sede } from '../model/sede';
import { Sesion } from '../model/sesion';
import { RolNombre } from '../model/usuario';

/** Fecha YYYY-MM-DD desplazada n días respecto a hoy. */
export const d = (n: number) => {
  const f = new Date();
  f.setDate(f.getDate() + n);
  return `${f.getFullYear()}-${String(f.getMonth() + 1).padStart(2, '0')}-${String(f.getDate()).padStart(2, '0')}`;
};

export const nombreCompleto = (p: NombrePersona) =>
  [p.primerNombre, p.segundoNombre, p.primerApellido, p.segundoApellido].filter((x) => x && x.trim()).join(' ');

type Nombre = [string, string | null, string, string | null];
const persona = ([pn, sn, pa, sa]: Nombre): NombrePersona =>
  ({ primerNombre: pn, segundoNombre: sn, primerApellido: pa, segundoApellido: sa });

export const CLAVE_DEMO = 'Fitzone2026*';

// ---- Catálogos ----
export const PLANES: Catalogo[] = [{ id: 1, nombre: 'mensual' }, { id: 2, nombre: 'trimestral' }, { id: 3, nombre: 'anual' }];
/** Duración fija de cada plan en meses (supuesto 7). */
export const MESES_PLAN: Record<string, number> = { mensual: 1, trimestral: 3, anual: 12 };
export const METODOS: Catalogo[] = [{ id: 1, nombre: 'efectivo' }, { id: 2, nombre: 'tarjeta' }, { id: 3, nombre: 'transferencia' }];
export const TIPOS: Catalogo[] = [{ id: 1, nombre: 'Cardio' }, { id: 2, nombre: 'Fuerza' }, { id: 3, nombre: 'Peso libre' }, { id: 4, nombre: 'Funcional' }];
export const ROLES: Catalogo[] = [
  { id: 1, nombre: 'ADMIN_SISTEMA' }, { id: 2, nombre: 'GERENTE_SEDE' },
  { id: 3, nombre: 'RECEPCIONISTA_SEDE' }, { id: 4, nombre: 'ENTRENADOR_SEDE' },
];

// ---- Sedes ----
export const SEDES: Sede[] = [
  { idSede: 1, nombre: 'FitZone Chapinero', direccion: 'Carrera 13 # 59-20, Bogotá', telefono: '6011234567' },
  { idSede: 2, nombre: 'FitZone Usaquén', direccion: 'Calle 119 # 6-45, Bogotá', telefono: '6017654321' },
  { idSede: 3, nombre: 'FitZone Suba', direccion: 'Avenida Suba # 115-30, Bogotá', telefono: '6019876543' },
];
const sedeNombre = (id: number) => SEDES.find((s) => s.idSede === id)!.nombre;

// ---- Empleados: [id, nombre, correo, teléfono, rol, idSede] ----
const EMP: [number, Nombre, string, string, RolNombre, number][] = [
  [1, ['Camyla', null, 'Poveda', null], 'admin@fitzone.example.com', '3200000001', 'ADMIN_SISTEMA', 1],
  [2, ['Sandra', null, 'Ríos', null], 'gerente.chapinero@fitzone.example.com', '3200000002', 'GERENTE_SEDE', 1],
  [3, ['Jorge', null, 'Mendoza', null], 'gerente.usaquen@fitzone.example.com', '3200000003', 'GERENTE_SEDE', 2],
  [4, ['Marcela', null, 'Ospina', null], 'gerente.suba@fitzone.example.com', '3200000004', 'GERENTE_SEDE', 3],
  [5, ['Diana', null, 'Pardo', null], 'recepcion.chapinero@fitzone.example.com', '3200000005', 'RECEPCIONISTA_SEDE', 1],
  [6, ['Julio', null, 'Cano', null], 'recepcion.usaquen@fitzone.example.com', '3200000006', 'RECEPCIONISTA_SEDE', 2],
  [7, ['Paula', null, 'Arias', null], 'recepcion.suba@fitzone.example.com', '3200000007', 'RECEPCIONISTA_SEDE', 3],
  [8, ['Mateo', null, 'Alvarado', null], 'mateo.alvarado@fitzone.example.com', '3201110001', 'ENTRENADOR_SEDE', 1],
  [9, ['Natalia', null, 'Cárdenas', null], 'natalia.cardenas@fitzone.example.com', '3201110002', 'ENTRENADOR_SEDE', 1],
  [10, ['Ricardo', null, 'Beltrán', null], 'ricardo.beltran@fitzone.example.com', '3201110003', 'ENTRENADOR_SEDE', 2],
  [11, ['Paola', null, 'Jiménez', null], 'paola.jimenez@fitzone.example.com', '3201110004', 'ENTRENADOR_SEDE', 2],
  [12, ['Héctor', null, 'Quintero', null], 'hector.quintero@fitzone.example.com', '3201110005', 'ENTRENADOR_SEDE', 3],
  [13, ['Laura', null, 'Sánchez', null], 'laura.sanchez@fitzone.example.com', '3201110006', 'ENTRENADOR_SEDE', 3],
];
export const EMPLEADOS: Empleado[] = EMP.map(([id, n, c, t, r, s]) => {
  const p = persona(n);
  return { idEmpleado: id, ...p, nombreCompleto: nombreCompleto(p), correo: c, telefono: t, rol: r, idSede: s, sede: sedeNombre(s), activo: true };
});
const empNombre = (id: number) => EMPLEADOS.find((e) => e.idEmpleado === id)!.nombreCompleto;

// ---- Miembros: [id, nombre, correo, teléfono, idSede] ----
const MIE: [number, Nombre, string, string, number][] = [
  [1, ['Laura', null, 'Gómez', 'Ríos'], 'laura.gomez@example.com', '3001112233', 1],
  [2, ['Andrés', 'Felipe', 'Martínez', null], 'andres.martinez@example.com', '3012223344', 1],
  [3, ['Valentina', null, 'Rojas', 'Pardo'], 'valentina.rojas@example.com', '3023334455', 1],
  [4, ['Carlos', 'Eduardo', 'Herrera', 'Silva'], 'carlos.herrera@example.com', '3034445566', 1],
  [5, ['Daniela', null, 'Vargas', null], 'daniela.vargas@example.com', '3045556677', 1],
  [6, ['Santiago', null, 'Ortiz', 'Mejía'], 'santiago.ortiz@example.com', '3056667788', 2],
  [7, ['Camila', 'Andrea', 'Torres', 'León'], 'camila.torres@example.com', '3067778899', 2],
  [8, ['Julián', null, 'Castro', 'Nieto'], 'julian.castro@example.com', '3078889900', 2],
  [9, ['Mariana', null, 'Díaz', 'Salazar'], 'mariana.diaz@example.com', '3089990011', 2],
  [10, ['Felipe', null, 'Ramírez', 'Vega'], 'felipe.ramirez@example.com', '3101112233', 3],
  [11, ['Sofía', 'Isabel', 'Moreno', 'Duarte'], 'sofia.moreno@example.com', '3112223344', 3],
  [12, ['David', null, 'Suárez', 'Peña'], 'david.suarez@example.com', '3123334455', 3],
];
const mieNombre = (id: number) => nombreCompleto(persona(MIE.find((m) => m[0] === id)![1]));
const mieSede = (id: number) => MIE.find((m) => m[0] === id)![4];

/** info_medica (opcional, máximo una por miembro). */
export const INFO_MEDICA: Record<number, InfoMedica> = {
  1: { contactoEmergencia: '3109998877', tipoSangre: 'O+', condicionMedica: null },
  3: { contactoEmergencia: '3157776655', tipoSangre: 'A-', condicionMedica: 'Asma leve' },
  4: { contactoEmergencia: '3186665544', tipoSangre: 'B+', condicionMedica: 'Lesión previa de rodilla derecha' },
  6: { contactoEmergencia: '3005554433', tipoSangre: 'O-', condicionMedica: null },
  10: { contactoEmergencia: '3014443322', tipoSangre: 'AB+', condicionMedica: 'Hipertensión controlada' },
};

// ---- Membresías: [id, estado, inicio, fin, plan, idMiembro] ----
const MEM: [number, Membresia['estado'], number, number, string, number][] = [
  [1, 'ACTIVA', -10, 20, 'mensual', 1], [2, 'ACTIVA', -100, 265, 'anual', 2],
  [3, 'ACTIVA', -40, 50, 'trimestral', 3], [4, 'VENCIDA', -75, -45, 'mensual', 4],
  [5, 'ACTIVA', -5, 25, 'mensual', 5], [6, 'ACTIVA', -30, 60, 'trimestral', 6],
  [7, 'ACTIVA', -200, 165, 'anual', 7], [8, 'VENCIDA', -50, -20, 'mensual', 8],
  [9, 'ACTIVA', -25, 5, 'mensual', 9], [10, 'ACTIVA', -87, 3, 'trimestral', 10],
  [11, 'VENCIDA', -45, -15, 'mensual', 11], [12, 'ACTIVA', -24, 6, 'mensual', 12],
  [13, 'VENCIDA', -41, -11, 'mensual', 1],
];
export const MEMBRESIAS: Membresia[] = MEM.map(([id, e, i, f, p, m]) => ({
  idMembresia: id, idMiembro: m, miembro: mieNombre(m), idSede: mieSede(m),
  plan: p, estado: e, fechaInicio: d(i), fechaFin: d(f),
}));

// ---- Pagos: [id, díasRel, monto, método, idMiembro] ----
const PAG: [number, number, number, string, number][] = [
  [1, -10, 90000, 'tarjeta', 1], [2, -100, 850000, 'transferencia', 2], [3, -40, 240000, 'tarjeta', 3],
  [4, -75, 90000, 'efectivo', 4], [5, -5, 90000, 'efectivo', 5], [6, -30, 240000, 'transferencia', 6],
  [7, -200, 850000, 'tarjeta', 7], [8, -50, 90000, 'efectivo', 8], [9, -25, 90000, 'tarjeta', 9],
  [10, -87, 240000, 'transferencia', 10], [11, -45, 90000, 'efectivo', 11], [12, -24, 90000, 'tarjeta', 12],
  [13, -41, 90000, 'tarjeta', 1],
];
export const PAGOS: Pago[] = PAG.map(([id, f, monto, met, m]) => ({
  idPago: id, idMiembro: m, miembro: mieNombre(m), idSede: mieSede(m), metodo: met, monto, fechaPago: d(f),
}));

// ---- Clases: [id, cupo, nombre, descripción, idSede, idEmpleado] ----
const CLA: [number, number, string, string | null, number, number][] = [
  [1, 15, 'Yoga Matutino', 'Yoga de nivel básico para empezar el día', 1, 8],
  [2, 20, 'Spinning Intenso', 'Ciclismo indoor de alta intensidad', 1, 9],
  [3, 12, 'Funcional Express', 'Circuito funcional de cuerpo completo', 2, 10],
  [4, 10, 'Pilates Mat', 'Pilates en colchoneta para fortalecer el core', 2, 11],
  [5, 3, 'Crossfit Básico', 'Introducción al crossfit en grupo reducido', 3, 12],
  [6, 15, 'Yoga Restaurativo', null, 3, 13],
  [7, 25, 'Zumba', 'Baile aeróbico de ritmos latinos', 1, 9],
  [8, 2, 'HIIT 30 min', 'Intervalos de alta intensidad, cupo reducido', 2, 10],
];
export const CLASES: Clase[] = CLA.map(([id, cupo, n, desc, s, e]) => ({
  idClase: id, cupoMaximo: cupo, nombre: n, descripcion: desc, idSede: s,
  sede: sedeNombre(s), idEmpleado: e, entrenador: empNombre(e),
}));

// ---- Sesiones: [nº, inicio, fin, díasRel, idClase] (inscritos se calcula) ----
const SES: [number, string, string, number, number][] = [
  [1, '06:00', '07:00', -7, 1], [2, '18:00', '19:00', -5, 2], [3, '07:00', '08:00', -3, 3],
  [4, '17:30', '18:30', -2, 4], [5, '06:00', '07:00', -1, 1], [6, '19:00', '20:00', -1, 5],
  [7, '18:00', '19:00', 1, 2], [8, '06:00', '07:00', 1, 1], [9, '07:00', '08:00', 2, 3],
  [10, '12:00', '12:30', 2, 8], [11, '19:00', '20:00', 3, 5], [12, '08:00', '09:00', 3, 6],
  [13, '10:00', '11:00', 5, 7], [14, '17:30', '18:30', 7, 4],
];
export const SESIONES: Sesion[] = SES.map(([n, hi, hf, f, c]) => {
  const cl = CLASES.find((x) => x.idClase === c)!;
  return {
    numeroSesion: n, idClase: c, clase: cl.nombre, idSede: cl.idSede, sede: cl.sede,
    idEmpleado: cl.idEmpleado, entrenador: cl.entrenador, fecha: d(f),
    horaInicio: hi, horaFin: hf, cupoMaximo: cl.cupoMaximo, inscritos: 0,
  };
});

// ---- miembro_sesion: [idMiembro, nºSesión, díasRel, asistió] ----
// En sesiones futuras la asistencia queda sin registrar (NULL).
export const INSCRIPCIONES: [number, number, number, boolean][] = [
  [1, 1, -9, true], [2, 1, -9, true], [3, 1, -8, false], [1, 2, -7, true], [5, 2, -6, true],
  [6, 2, -6, true], [6, 3, -5, true], [7, 3, -5, true], [9, 3, -4, false], [7, 4, -4, true],
  [9, 4, -3, true], [1, 5, -3, true], [2, 5, -2, true], [10, 6, -3, true], [12, 6, -2, true],
  [3, 6, -2, false], [1, 7, -1, false], [5, 7, 0, false], [2, 8, 0, false], [3, 8, 0, false],
  [6, 9, 0, false], [9, 9, 0, false], [6, 10, 0, false], [7, 10, 0, false], [10, 11, 0, false],
  [12, 11, 0, false], [10, 12, 0, false], [1, 13, 0, false], [2, 13, 0, false], [5, 13, 0, false],
];

// ---- Equipos: [id, díasAdq, nombre, tipo, idSede] ----
const EQ: [number, number, string, string, number][] = [
  [1, -900, 'Cinta de correr Pro', 'Cardio', 1], [2, -850, 'Bicicleta estática', 'Cardio', 1],
  [3, -800, 'Prensa de piernas', 'Fuerza', 1], [4, -700, 'Mancuernas 5-30 kg', 'Peso libre', 1],
  [5, -600, 'Elíptica', 'Cardio', 2], [6, -580, 'Máquina de poleas', 'Fuerza', 2],
  [7, -500, 'Kettlebells', 'Funcional', 2], [8, -450, 'Bicicleta de spinning', 'Cardio', 2],
  [9, -420, 'Cinta de correr', 'Cardio', 3], [10, -400, 'Rack de sentadillas', 'Fuerza', 3],
  [11, -380, 'Barras olímpicas', 'Peso libre', 3], [12, -350, 'Cuerdas de batalla', 'Funcional', 3],
];
// ---- mantenimiento_equipo: [nº, costo, descripción, díasRel, idEquipo] ----
const MAN: [number, number, string | null, number, number][] = [
  [1, 250000, 'Cambio de banda', -120, 1], [2, 80000, 'Lubricación y calibración', -30, 1],
  [3, 120000, 'Cambio de pedales', -60, 2], [4, 150000, 'Revisión de cables', -200, 3],
  [5, 95000, 'Ajuste de resistencia', -90, 5], [6, 300000, 'Cambio de poleas', -45, 6],
  [7, 1200000, 'Reemplazo de motor', -150, 9], [8, 60000, null, -20, 10],
];
export const EQUIPOS: Equipo[] = EQ.map(([id, f, n, t, s]) => {
  const dias = MAN.filter((m) => m[4] === id).map((m) => m[3]);
  return {
    idEquipo: id, nombre: n, tipo: t, idSede: s, sede: sedeNombre(s),
    fechaAdquisicion: d(f), ultimoMantenimiento: dias.length ? d(Math.max(...dias)) : null,
  };
});
export const MANTENIMIENTOS: Mantenimiento[] = MAN.map(([n, c, desc, f, e]) => {
  const eq = EQUIPOS.find((x) => x.idEquipo === e)!;
  return {
    numeroMantenimiento: n, idEquipo: e, equipo: eq.nombre, idSede: eq.idSede,
    sede: eq.sede, descripcion: desc, costo: c, fechaMantenimiento: d(f),
  };
});

/** Fecha de registro: el día de su primera membresía. */
const fechaRegistro = (id: number) =>
  MEMBRESIAS.filter((m) => m.idMiembro === id).map((m) => m.fechaInicio).sort()[0] ?? d(0);
export const MIEMBROS: Miembro[] = MIE.map(([id, n, c, t, s]) => {
  const p = persona(n);
  return {
    idMiembro: id, ...p, nombreCompleto: nombreCompleto(p), correo: c, telefono: t, idSede: s,
    sede: sedeNombre(s), fechaRegistro: fechaRegistro(id), planActual: null,
  };
});

// ---- MongoDB: colección rutinas ----
export const RUTINAS: Rutina[] = [
  { idRutina: 'r1', idMiembro: 1, idEmpleado: 8, idSede: 1, nombreRutina: 'Fuerza - Fase 1', objetivo: 'Ganancia de masa muscular', fechaCreacion: d(-55), activa: true,
    ejercicios: [
      { nombre: 'Sentadilla', tipo: 'fuerza', series: 4, repeticiones: 10, pesoKg: 40, notas: 'Enfoque en profundidad' },
      { nombre: 'Press banca', tipo: 'fuerza', series: 4, repeticiones: 8, pesoKg: 35 },
      { nombre: 'Peso muerto', tipo: 'fuerza', series: 3, repeticiones: 8, pesoKg: 50 },
      { nombre: 'Caminadora', tipo: 'cardio', duracionMin: 10, distanciaKm: 1.2, notas: 'Calentamiento' }],
    notasEntrenador: 'Aumentar peso progresivamente cada 2 semanas.' },
  { idRutina: 'r2', idMiembro: 3, idEmpleado: 9, idSede: 1, nombreRutina: 'Yoga - Flexibilidad', objetivo: 'Mejorar movilidad y reducir estrés', fechaCreacion: d(-200), activa: true,
    ejercicios: [
      { nombre: 'Saludo al sol', tipo: 'movilidad', series: 3, duracionSeg: 90, notas: 'Respiración profunda' },
      { nombre: 'Postura del guerrero', tipo: 'movilidad', series: 2, duracionSeg: 60 },
      { nombre: 'Postura del niño', tipo: 'movilidad', series: 1, duracionSeg: 120 }] },
  { idRutina: 'r3', idMiembro: 4, idEmpleado: 9, idSede: 1, nombreRutina: 'Funcional - Resistencia', objetivo: 'Mejorar resistencia cardiovascular', fechaCreacion: d(-80), activa: false,
    ejercicios: [
      { nombre: 'Burpees', tipo: 'fuerza', series: 4, repeticiones: 15 },
      { nombre: 'Mountain climbers', tipo: 'fuerza', series: 4, repeticiones: 20 },
      { nombre: 'Kettlebell swing', tipo: 'fuerza', series: 3, repeticiones: 12, pesoKg: 16 },
      { nombre: 'Bicicleta estática', tipo: 'cardio', duracionMin: 20 }],
    notasEntrenador: 'Rutina pausada por lesión leve en rodilla; retomar tras evaluación.' },
  { idRutina: 'r4', idMiembro: 6, idEmpleado: 10, idSede: 2, nombreRutina: 'Cardio - Pérdida de grasa', objetivo: 'Reducir porcentaje de grasa corporal', fechaCreacion: d(-48), activa: true,
    ejercicios: [
      { nombre: 'Trote', tipo: 'cardio', duracionMin: 30, distanciaKm: 4.5 },
      { nombre: 'Elíptica', tipo: 'cardio', duracionMin: 20 },
      { nombre: 'Sentadilla', tipo: 'fuerza', series: 3, repeticiones: 15 },
      { nombre: 'Plancha', tipo: 'fuerza', series: 3, repeticiones: 1, notas: 'Mantener 45 segundos' }] },
  { idRutina: 'r5', idMiembro: 10, idEmpleado: 12, idSede: 3, nombreRutina: 'Fuerza - Tren superior', objetivo: 'Ganancia de masa muscular', fechaCreacion: d(-38), activa: true,
    ejercicios: [
      { nombre: 'Press militar', tipo: 'fuerza', series: 4, repeticiones: 8, pesoKg: 30 },
      { nombre: 'Press banca', tipo: 'fuerza', series: 4, repeticiones: 10, pesoKg: 45 },
      { nombre: 'Remo con barra', tipo: 'fuerza', series: 4, repeticiones: 10, pesoKg: 35 },
      { nombre: 'Dominadas', tipo: 'fuerza', series: 3, repeticiones: 6 }] },
].map((r) => ({ ...r, miembro: mieNombre(r.idMiembro), entrenador: empNombre(r.idEmpleado), sede: sedeNombre(r.idSede) } as Rutina));

// ---- MongoDB: colección progreso. [miembro, díasRel, peso, grasa, medidas, notas] ----
const PRO: [number, number, number, number | undefined, Progreso['medidas'], string | undefined][] = [
  [1, -88, 82.5, 22.0, { cinturaCm: 92, pechoCm: 102, brazoCm: 34 }, undefined],
  [1, -58, 80.8, 20.5, { cinturaCm: 89, pechoCm: 103, brazoCm: 34.5 }, 'Mejora notable en cintura tras 4 semanas de rutina.'],
  [1, -28, 79.9, 19.4, { cinturaCm: 87, pechoCm: 104, brazoCm: 35 }, undefined],
  [3, -200, 61.0, 24.0, { cinturaCm: 70, caderaCm: 95 }, undefined],
  [3, -110, 59.5, 22.8, { cinturaCm: 68, caderaCm: 94 }, undefined],
  [4, -84, 90.2, 27.5, { cinturaCm: 100, pechoCm: 108, brazoCm: 36 }, undefined],
  [6, -48, 88.0, 26.0, { cinturaCm: 98 }, undefined],
  [6, -20, 85.9, 24.7, { cinturaCm: 95 }, undefined],
  [10, -38, 72.0, 18.0, { pechoCm: 98, brazoCm: 33 }, undefined],
  [10, -8, 73.1, 17.6, { pechoCm: 99.5, brazoCm: 34 }, 'Sube masa magra, baja grasa.'],
];
export const PROGRESOS: Progreso[] = PRO.map(([m, f, peso, g, med, n], i) => ({
  idProgreso: 'p' + (i + 1), idMiembro: m, miembro: mieNombre(m), idSede: mieSede(m),
  fecha: d(f), pesoKg: peso, grasaPct: g, medidas: med, notas: n,
}));
