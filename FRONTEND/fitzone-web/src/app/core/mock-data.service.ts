import { Injectable, inject } from '@angular/core';
import { Observable, delay, of, throwError } from 'rxjs';
import { DataService } from './data.service';
import {
  Catalogo, Clase, Empleado, Equipo, Inscripcion, LoginRespuesta, Mantenimiento,
  Membresia, Miembro, NuevaClase, NuevaSede, NuevaSesion, NuevoEmpleado, NuevoEquipo,
  NuevoMantenimiento, NuevoMiembro, NuevoProgreso, NuevaRutina, Pago, Progreso, RenovarMembresia, Rutina, RolNombre, Sede, Sesion,
} from './models';
import { SessionStore } from './session.store';

/** Fecha YYYY-MM-DD desplazada n días respecto a hoy (como los scripts SQL). */
const d = (n: number) => {
  const f = new Date();
  f.setDate(f.getDate() + n);
  const m = String(f.getMonth() + 1).padStart(2, '0');
  const day = String(f.getDate()).padStart(2, '0');
  return `${f.getFullYear()}-${m}-${day}`;
};

const CLAVE_DEMO = 'Fitzone2026*';
const SEDES: Sede[] = [
  { idSede: 1, nombre: 'FitZone Chapinero', direccion: 'Carrera 13 # 59-20, Bogotá', telefono: '6011234567' },
  { idSede: 2, nombre: 'FitZone Usaquén', direccion: 'Calle 119 # 6-45, Bogotá', telefono: '6017654321' },
  { idSede: 3, nombre: 'FitZone Suba', direccion: 'Avenida Suba # 115-30, Bogotá', telefono: '6019876543' },
];
const sedeNombre = (id: number) => SEDES.find((s) => s.idSede === id)!.nombre;

// [id, nombre, correo, teléfono, rol, idSede]
const EMP: [number, string, string, string, RolNombre, number][] = [
  [1, 'Camyla Poveda', 'admin@fitzone.example.com', '3200000001', 'ADMIN_SISTEMA', 1],
  [2, 'Sandra Ríos', 'gerente.chapinero@fitzone.example.com', '3200000002', 'GERENTE_SEDE', 1],
  [3, 'Jorge Mendoza', 'gerente.usaquen@fitzone.example.com', '3200000003', 'GERENTE_SEDE', 2],
  [4, 'Marcela Ospina', 'gerente.suba@fitzone.example.com', '3200000004', 'GERENTE_SEDE', 3],
  [5, 'Diana Pardo', 'recepcion.chapinero@fitzone.example.com', '3200000005', 'RECEPCIONISTA_SEDE', 1],
  [6, 'Julio Cano', 'recepcion.usaquen@fitzone.example.com', '3200000006', 'RECEPCIONISTA_SEDE', 2],
  [7, 'Paula Arias', 'recepcion.suba@fitzone.example.com', '3200000007', 'RECEPCIONISTA_SEDE', 3],
  [8, 'Mateo Alvarado', 'mateo.alvarado@fitzone.example.com', '3201110001', 'ENTRENADOR_SEDE', 1],
  [9, 'Natalia Cárdenas', 'natalia.cardenas@fitzone.example.com', '3201110002', 'ENTRENADOR_SEDE', 1],
  [10, 'Ricardo Beltrán', 'ricardo.beltran@fitzone.example.com', '3201110003', 'ENTRENADOR_SEDE', 2],
  [11, 'Paola Jiménez', 'paola.jimenez@fitzone.example.com', '3201110004', 'ENTRENADOR_SEDE', 2],
  [12, 'Héctor Quintero', 'hector.quintero@fitzone.example.com', '3201110005', 'ENTRENADOR_SEDE', 3],
  [13, 'Laura Sánchez', 'laura.sanchez@fitzone.example.com', '3201110006', 'ENTRENADOR_SEDE', 3],
];
const EMPLEADOS: Empleado[] = EMP.map(([id, n, c, t, r, s]) => ({
  idEmpleado: id, nombreCompleto: n, correo: c, telefono: t, rol: r,
  idSede: s, sede: sedeNombre(s), activo: true,
}));
const empNombre = (id: number) => EMPLEADOS.find((e) => e.idEmpleado === id)!.nombreCompleto;

// [id, nombre, correo, teléfono, idSede]
const MIE: [number, string, string, string, number][] = [
  [1, 'Laura Gómez Ríos', 'laura.gomez@example.com', '3001112233', 1],
  [2, 'Andrés Felipe Martínez', 'andres.martinez@example.com', '3012223344', 1],
  [3, 'Valentina Rojas Pardo', 'valentina.rojas@example.com', '3023334455', 1],
  [4, 'Carlos Eduardo Herrera Silva', 'carlos.herrera@example.com', '3034445566', 1],
  [5, 'Daniela Vargas', 'daniela.vargas@example.com', '3045556677', 1],
  [6, 'Santiago Ortiz Mejía', 'santiago.ortiz@example.com', '3056667788', 2],
  [7, 'Camila Andrea Torres León', 'camila.torres@example.com', '3067778899', 2],
  [8, 'Julián Castro Nieto', 'julian.castro@example.com', '3078889900', 2],
  [9, 'Mariana Díaz Salazar', 'mariana.diaz@example.com', '3089990011', 2],
  [10, 'Felipe Ramírez Vega', 'felipe.ramirez@example.com', '3101112233', 3],
  [11, 'Sofía Isabel Moreno Duarte', 'sofia.moreno@example.com', '3112223344', 3],
  [12, 'David Suárez Peña', 'david.suarez@example.com', '3123334455', 3],
];
const mieNombre = (id: number) => MIE.find((m) => m[0] === id)![1];
const mieSede = (id: number) => MIE.find((m) => m[0] === id)![4];

// [id, estado, inicio, fin, plan, idMiembro]
const MEM: [number, Membresia['estado'], number, number, string, number][] = [
  [1, 'activa', -10, 20, 'mensual', 1], [2, 'activa', -100, 265, 'anual', 2],
  [3, 'activa', -40, 50, 'trimestral', 3], [4, 'vencida', -75, -45, 'mensual', 4],
  [5, 'activa', -5, 25, 'mensual', 5], [6, 'activa', -30, 60, 'trimestral', 6],
  [7, 'activa', -200, 165, 'anual', 7], [8, 'vencida', -50, -20, 'mensual', 8],
  [9, 'activa', -15, 15, 'mensual', 9], [10, 'activa', -60, 30, 'trimestral', 10],
  [11, 'cancelada', -45, -15, 'mensual', 11], [12, 'activa', -10, 20, 'mensual', 12],
  [13, 'vencida', -40, -10, 'mensual', 1],
];
const MEMBRESIAS: Membresia[] = MEM.map(([id, e, i, f, p, m]) => ({
  idMembresia: id, idMiembro: m, miembro: mieNombre(m), idSede: mieSede(m),
  plan: p, estado: e, fechaInicio: d(i), fechaFin: d(f),
}));

// [id, díasAtrás, monto, método, idMiembro]
const PAG: [number, number, number, string, number][] = [
  [1, -10, 90000, 'tarjeta', 1], [2, -100, 850000, 'transferencia', 2], [3, -40, 240000, 'tarjeta', 3],
  [4, -75, 90000, 'efectivo', 4], [5, -5, 90000, 'efectivo', 5], [6, -30, 240000, 'transferencia', 6],
  [7, -200, 850000, 'tarjeta', 7], [8, -50, 90000, 'efectivo', 8], [9, -15, 90000, 'tarjeta', 9],
  [10, -60, 240000, 'transferencia', 10], [11, -45, 90000, 'efectivo', 11], [12, -10, 90000, 'tarjeta', 12],
  [13, -40, 90000, 'tarjeta', 1],
];
const PAGOS: Pago[] = PAG.map(([id, f, monto, met, m]) => ({
  idPago: id, idMiembro: m, miembro: mieNombre(m), idSede: mieSede(m),
  metodo: met, monto, fechaPago: d(f),
}));

// [id, cupo, nombre, descripción, idSede, idEmpleado]
const CLA: [number, number, string, string, number, number][] = [
  [1, 15, 'Yoga Matutino', 'Yoga de nivel básico para empezar el día', 1, 8],
  [2, 20, 'Spinning Intenso', 'Ciclismo indoor de alta intensidad', 1, 9],
  [3, 12, 'Funcional Express', 'Circuito funcional de cuerpo completo', 2, 10],
  [4, 10, 'Pilates Mat', 'Pilates en colchoneta para fortalecer el core', 2, 11],
  [5, 3, 'Crossfit Básico', 'Introducción al crossfit en grupo reducido', 3, 12],
  [6, 15, 'Yoga Restaurativo', 'Estiramiento y relajación guiada', 3, 13],
  [7, 25, 'Zumba', 'Baile aeróbico de ritmos latinos', 1, 9],
  [8, 2, 'HIIT 30 min', 'Intervalos de alta intensidad, cupo reducido', 2, 10],
];
const CLASES: Clase[] = CLA.map(([id, cupo, n, desc, s, e]) => ({
  idClase: id, cupoMaximo: cupo, nombre: n, descripcion: desc, idSede: s,
  sede: sedeNombre(s), idEmpleado: e, entrenador: empNombre(e),
}));

// [nº, inicio, fin, díasRel, idClase, inscritos]
const SES: [number, string, string, number, number, number][] = [
  [1, '06:00', '07:00', -7, 1, 3], [2, '18:00', '19:00', -5, 2, 3], [3, '07:00', '08:00', -3, 3, 3],
  [4, '17:30', '18:30', -2, 4, 2], [5, '06:00', '07:00', -1, 1, 2], [6, '19:00', '20:00', -1, 5, 3],
  [7, '18:00', '19:00', 1, 2, 2], [8, '06:00', '07:00', 1, 1, 2], [9, '07:00', '08:00', 2, 3, 2],
  [10, '12:00', '12:30', 2, 8, 2], [11, '19:00', '20:00', 3, 5, 2], [12, '08:00', '09:00', 3, 6, 1],
  [13, '10:00', '11:00', 5, 7, 3], [14, '17:30', '18:30', 7, 4, 0],
];
const SESIONES: Sesion[] = SES.map(([n, hi, hf, f, c, ins]) => {
  const cl = CLASES.find((x) => x.idClase === c)!;
  return {
    numeroSesion: n, idClase: c, clase: cl.nombre, idSede: cl.idSede, sede: cl.sede,
    idEmpleado: cl.idEmpleado, entrenador: cl.entrenador, fecha: d(f),
    horaInicio: hi, horaFin: hf, cupoMaximo: cl.cupoMaximo, inscritos: ins,
  };
});

// [id, díasAdq, nombre, tipo, idSede]
const EQ: [number, number, string, string, number][] = [
  [1, -900, 'Cinta de correr Pro', 'Cardio', 1], [2, -850, 'Bicicleta estática', 'Cardio', 1],
  [3, -800, 'Prensa de piernas', 'Fuerza', 1], [4, -700, 'Mancuernas 5-30 kg', 'Peso libre', 1],
  [5, -600, 'Elíptica', 'Cardio', 2], [6, -580, 'Máquina de poleas', 'Fuerza', 2],
  [7, -500, 'Kettlebells', 'Funcional', 2], [8, -450, 'Bicicleta de spinning', 'Cardio', 2],
  [9, -420, 'Cinta de correr', 'Cardio', 3], [10, -400, 'Rack de sentadillas', 'Fuerza', 3],
  [11, -380, 'Barras olímpicas', 'Peso libre', 3], [12, -350, 'Cuerdas de batalla', 'Funcional', 3],
];
// [nº, costo, descripción, díasRel, idEquipo]
const MAN: [number, number, string, number, number][] = [
  [1, 250000, 'Cambio de banda', -120, 1], [2, 80000, 'Lubricación y calibración', -30, 1],
  [3, 120000, 'Cambio de pedales', -60, 2], [4, 150000, 'Revisión de cables', -200, 3],
  [5, 95000, 'Ajuste de resistencia', -90, 5], [6, 300000, 'Cambio de poleas', -45, 6],
  [7, 1200000, 'Reemplazo de motor', -150, 9], [8, 60000, 'Revisión de soldaduras', -20, 10],
];
const EQUIPOS: Equipo[] = EQ.map(([id, f, n, t, s]) => {
  const reciente = MAN.some((m) => m[4] === id && m[3] >= -30);
  return {
    idEquipo: id, nombre: n, tipo: t, idSede: s, sede: sedeNombre(s),
    fechaAdquisicion: d(f), estado: reciente ? 'mantenimiento' : 'operativo',
  };
});
const MANTENIMIENTOS: Mantenimiento[] = MAN.map(([n, c, desc, f, e]) => {
  const eq = EQUIPOS.find((x) => x.idEquipo === e)!;
  return {
    numeroMantenimiento: n, idEquipo: e, equipo: eq.nombre, idSede: eq.idSede,
    sede: eq.sede, descripcion: desc, costo: c, fecha: d(f),
  };
});
const planActual = (id: number) =>
  MEMBRESIAS.find((m) => m.idMiembro === id && m.estado === 'activa' && m.fechaFin >= d(0))?.plan ?? null;
const MIEMBROS: Miembro[] = MIE.map(([id, n, c, t, s]) => ({
  idMiembro: id, nombreCompleto: n, correo: c, telefono: t, idSede: s,
  sede: sedeNombre(s), planActual: planActual(id),
}));


const PLANES: Catalogo[] = [{ id: 1, nombre: 'mensual' }, { id: 2, nombre: 'trimestral' }, { id: 3, nombre: 'anual' }];
const DIAS_PLAN: Record<string, number> = { mensual: 30, trimestral: 90, anual: 365 };
const METODOS: Catalogo[] = [{ id: 1, nombre: 'efectivo' }, { id: 2, nombre: 'tarjeta' }, { id: 3, nombre: 'transferencia' }];
const TIPOS: Catalogo[] = [{ id: 1, nombre: 'Cardio' }, { id: 2, nombre: 'Fuerza' }, { id: 3, nombre: 'Peso libre' }, { id: 4, nombre: 'Funcional' }];
const ROLES: Catalogo[] = [
  { id: 1, nombre: 'ADMIN_SISTEMA' }, { id: 2, nombre: 'GERENTE_SEDE' },
  { id: 3, nombre: 'RECEPCIONISTA_SEDE' }, { id: 4, nombre: 'ENTRENADOR_SEDE' },
];
const EMAIL = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

// [idMiembro, nºSesión, díasRel, asistió] (mismas filas del script 02)
const INS: [number, number, number, boolean][] = [
  [1, 1, -9, true], [2, 1, -9, true], [3, 1, -8, false], [1, 2, -7, true], [5, 2, -6, true],
  [6, 2, -6, true], [6, 3, -5, true], [7, 3, -5, true], [9, 3, -4, false], [7, 4, -4, true],
  [9, 4, -3, true], [1, 5, -3, true], [2, 5, -2, true], [10, 6, -3, true], [12, 6, -2, true],
  [3, 6, -2, false], [1, 7, -1, false], [5, 7, 0, false], [2, 8, 0, false], [3, 8, 0, false],
  [6, 9, 0, false], [9, 9, 0, false], [6, 10, 0, false], [7, 10, 0, false], [10, 11, 0, false],
  [12, 11, 0, false], [10, 12, 0, false], [1, 13, 0, false], [2, 13, 0, false], [5, 13, 0, false],
];

/**
 * Datos de ejemplo (los mismos del script 02_insercion.sql) en memoria.
 * Replica las reglas de la base de datos: triggers y procedimientos almacenados.
 * Aplica el filtro por sede/rol que en producción hace el backend:
 * el administrador ve todo; los demás solo su sede; el entrenador solo sus clases.
 * Los cambios se pierden al recargar la página.
 */
// ---- MongoDB (datos como en 02_insercion_mongo.js) ----
const RUT: Rutina[] = [
  { idRutina: 'r1', idMiembro: 1, idEmpleado: 8, idSede: 1, nombreRutina: 'Fuerza - Fase 1', objetivo: 'Ganancia de masa muscular', fechaCreacion: '2026-09-01', activa: true,
    ejercicios: [
      { nombre: 'Sentadilla', tipo: 'fuerza', series: 4, repeticiones: 10, pesoKg: 40, notas: 'Enfoque en profundidad' },
      { nombre: 'Press banca', tipo: 'fuerza', series: 4, repeticiones: 8, pesoKg: 35 },
      { nombre: 'Peso muerto', tipo: 'fuerza', series: 3, repeticiones: 8, pesoKg: 50 },
      { nombre: 'Caminadora', tipo: 'cardio', duracionMin: 10, distanciaKm: 1.2, notas: 'Calentamiento' }],
    notasEntrenador: 'Aumentar peso progresivamente cada 2 semanas.' },
  { idRutina: 'r2', idMiembro: 3, idEmpleado: 9, idSede: 1, nombreRutina: 'Yoga - Flexibilidad', objetivo: 'Mejorar movilidad y reducir estrés', fechaCreacion: '2026-03-15', activa: true,
    ejercicios: [
      { nombre: 'Saludo al sol', tipo: 'movilidad', series: 3, duracionSeg: 90, notas: 'Respiración profunda' },
      { nombre: 'Postura del guerrero', tipo: 'movilidad', series: 2, duracionSeg: 60 },
      { nombre: 'Postura del niño', tipo: 'movilidad', series: 1, duracionSeg: 120 }] },
  { idRutina: 'r3', idMiembro: 4, idEmpleado: 9, idSede: 1, nombreRutina: 'Funcional - Resistencia', objetivo: 'Mejorar resistencia cardiovascular', fechaCreacion: '2026-08-10', activa: false,
    ejercicios: [
      { nombre: 'Burpees', tipo: 'fuerza', series: 4, repeticiones: 15 },
      { nombre: 'Mountain climbers', tipo: 'fuerza', series: 4, repeticiones: 20 },
      { nombre: 'Kettlebell swing', tipo: 'fuerza', series: 3, repeticiones: 12, pesoKg: 16 },
      { nombre: 'Bicicleta estática', tipo: 'cardio', duracionMin: 20 }],
    notasEntrenador: 'Rutina pausada por lesión leve en rodilla; retomar tras evaluación.' },
  { idRutina: 'r4', idMiembro: 6, idEmpleado: 10, idSede: 2, nombreRutina: 'Cardio - Pérdida de grasa', objetivo: 'Reducir porcentaje de grasa corporal', fechaCreacion: '2026-09-10', activa: true,
    ejercicios: [
      { nombre: 'Trote', tipo: 'cardio', duracionMin: 30, distanciaKm: 4.5 },
      { nombre: 'Elíptica', tipo: 'cardio', duracionMin: 20 },
      { nombre: 'Plancha', tipo: 'fuerza', series: 3, repeticiones: 1, notas: 'Mantener 45 segundos' }] },
  { idRutina: 'r5', idMiembro: 10, idEmpleado: 12, idSede: 3, nombreRutina: 'Fuerza - Tren superior', objetivo: 'Ganancia de masa muscular', fechaCreacion: '2026-09-20', activa: true,
    ejercicios: [
      { nombre: 'Press militar', tipo: 'fuerza', series: 4, repeticiones: 8, pesoKg: 30 },
      { nombre: 'Remo con barra', tipo: 'fuerza', series: 4, repeticiones: 10, pesoKg: 35 },
      { nombre: 'Dominadas', tipo: 'fuerza', series: 3, repeticiones: 6 }] },
].map((r) => ({ ...r, miembro: mieNombre(r.idMiembro), entrenador: empNombre(r.idEmpleado), sede: sedeNombre(r.idSede) } as Rutina));

// [miembro, sede, fecha, peso, grasa, medidas, notas]
const PRO: [number, number, string, number, number | undefined, Progreso['medidas'], string | undefined][] = [
  [1, 1, '2026-08-01', 82.5, 22.0, { cinturaCm: 92, pechoCm: 102, brazoCm: 34 }, undefined],
  [1, 1, '2026-09-01', 80.8, 20.5, { cinturaCm: 89, pechoCm: 103, brazoCm: 34.5 }, 'Mejora notable en cintura tras 4 semanas de rutina.'],
  [1, 1, '2026-10-01', 79.9, 19.4, { cinturaCm: 87, pechoCm: 104, brazoCm: 35 }, undefined],
  [3, 1, '2026-03-20', 61.0, 24.0, { cinturaCm: 70, caderaCm: 95 }, undefined],
  [3, 1, '2026-06-20', 59.5, 22.8, { cinturaCm: 68, caderaCm: 94 }, undefined],
  [4, 1, '2026-08-05', 90.2, 27.5, { cinturaCm: 100, pechoCm: 108, brazoCm: 36 }, undefined],
  [6, 2, '2026-09-10', 88.0, 26.0, { cinturaCm: 98 }, undefined],
  [6, 2, '2026-10-08', 85.9, 24.7, { cinturaCm: 95 }, undefined],
  [10, 3, '2026-09-20', 72.0, 18.0, { pechoCm: 98, brazoCm: 33 }, undefined],
];
const PROGRESOS: Progreso[] = PRO.map(([m, s, f, peso, g, med, n], i) => ({
  idProgreso: 'p' + (i + 1), idMiembro: m, miembro: mieNombre(m), idSede: s, fecha: f, pesoKg: peso, grasaPct: g, medidas: med, notas: n,
}));

@Injectable()
export class MockDataService extends DataService {
  private store = inject(SessionStore);

  private lSedes = [...SEDES];
  private lEmpleados = [...EMPLEADOS];
  private lMiembros = [...MIEMBROS];
  private lMembresias = [...MEMBRESIAS];
  private lPagos = [...PAGOS];
  private lClases = [...CLASES];
  private lSesiones = [...SESIONES];
  private lEquipos = [...EQUIPOS];
  private lMant = [...MANTENIMIENTOS];
  private lRutinas = [...RUT];
  private lProgresos = [...PROGRESOS];
  private lIns: Inscripcion[] = INS.map(([m, n, f, a]) => ({
    numeroSesion: n, idMiembro: m, miembro: mieNombre(m), fechaInscripcion: d(f), asistio: a,
  }));

  constructor() {
    super();
    this.recalcularInscritos();
  }

  // ---------- utilidades ----------
  private ok<T>(datos: T): Observable<T> {
    return of(datos).pipe(delay(250));
  }
  private fail(msg: string): Observable<never> {
    return throwError(() => new Error(msg)).pipe(delay(250));
  }
  private porSede<T extends { idSede: number }>(lista: T[]): T[] {
    const u = this.store.usuario();
    return !u || u.rol === 'ADMIN_SISTEMA' ? [...lista] : lista.filter((x) => x.idSede === u.idSede);
  }
  private sigId = (ids: number[]) => (ids.length ? Math.max(...ids) : 0) + 1;
  private recalcularInscritos() {
    this.lSesiones = this.lSesiones.map((s) => ({
      ...s, inscritos: this.lIns.filter((i) => i.numeroSesion === s.numeroSesion).length,
    }));
  }
  private recalcularPlanes() {
    this.lMiembros = this.lMiembros.map((m) => ({
      ...m,
      planActual: this.lMembresias.find((x) => x.idMiembro === m.idMiembro && x.estado === 'activa' && x.fechaFin >= d(0))?.plan ?? null,
    }));
  }
  private sumarDias(f: string, n: number) {
    const [a, m, dd] = f.split('-').map(Number);
    const x = new Date(a, m - 1, dd + n);
    return `${x.getFullYear()}-${String(x.getMonth() + 1).padStart(2, '0')}-${String(x.getDate()).padStart(2, '0')}`;
  }
  private nombreCompleto(a: string, b: string | undefined, c: string, e: string | undefined) {
    return [a, b, c, e].filter((x) => x && x.trim()).join(' ');
  }

  // ---------- login ----------
  login(correo: string, clave: string): Observable<LoginRespuesta> {
    const e = this.lEmpleados.find((x) => x.correo === correo.trim().toLowerCase() && x.activo);
    if (!e || clave !== CLAVE_DEMO) return this.fail('Correo o contraseña incorrectos.');
    return this.ok({
      token: 'token-demo-' + e.idEmpleado,
      usuario: { idEmpleado: e.idEmpleado, nombre: e.nombreCompleto, correo: e.correo, rol: e.rol, idSede: e.idSede, sede: e.sede },
    });
  }

  // ---------- lecturas ----------
  sedes() { return this.ok(this.porSede(this.lSedes)); }
  empleados() { return this.ok(this.porSede(this.lEmpleados)); }
  miembros() { return this.ok(this.porSede(this.lMiembros)); }
  membresias() { return this.ok(this.porSede(this.lMembresias)); }
  pagos() { return this.ok(this.porSede(this.lPagos)); }
  clases() {
    const u = this.store.usuario();
    const l = this.porSede(this.lClases);
    return this.ok(u?.rol === 'ENTRENADOR_SEDE' ? l.filter((c) => c.idEmpleado === u.idEmpleado) : l);
  }
  sesiones() {
    const u = this.store.usuario();
    const l = this.porSede(this.lSesiones);
    return this.ok(u?.rol === 'ENTRENADOR_SEDE' ? l.filter((s) => s.idEmpleado === u.idEmpleado) : l);
  }
  equipos() { return this.ok(this.porSede(this.lEquipos)); }
  mantenimientos() { return this.ok(this.porSede(this.lMant)); }
  rutinas() { return this.ok(this.porSede(this.lRutinas)); }
  progresos() { return this.ok(this.porSede(this.lProgresos)); }
  inscripciones(n: number) { return this.ok(this.lIns.filter((i) => i.numeroSesion === n)); }
  planes() { return this.ok(PLANES); }
  metodosPago() { return this.ok(METODOS); }
  tiposEquipo() { return this.ok(TIPOS); }
  roles() { return this.ok(ROLES); }

  // ---------- escrituras (reglas iguales a los scripts SQL) ----------
  crearSede(x: NuevaSede) {
    if (this.lSedes.some((s) => s.nombre.toLowerCase() === x.nombre.trim().toLowerCase())) return this.fail('Ya existe una sede con ese nombre.');
    if (this.lSedes.some((s) => s.direccion.toLowerCase() === x.direccion.trim().toLowerCase())) return this.fail('Ya existe una sede con esa dirección.');
    this.lSedes.push({ idSede: this.sigId(this.lSedes.map((s) => s.idSede)), nombre: x.nombre.trim(), direccion: x.direccion.trim(), telefono: x.telefono.trim() });
    return this.ok(`OK: sede «${x.nombre.trim()}» creada.`);
  }

  crearEmpleado(x: NuevoEmpleado) {
    if (!x.clave || x.clave.length < 8) return this.fail('La contraseña debe tener al menos 8 caracteres.');
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lEmpleados.some((e) => e.correo === correo)) return this.fail(`Ya existe un empleado con el correo ${correo}.`);
    const rol = ROLES.find((r) => r.id === x.idRolEmpleado);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!rol || !sede) return this.fail('El rol o la sede indicados no existen.');
    const id = this.sigId(this.lEmpleados.map((e) => e.idEmpleado));
    this.lEmpleados.push({
      idEmpleado: id, nombreCompleto: this.nombreCompleto(x.primerNombre, x.segundoNombre, x.primerApellido, x.segundoApellido),
      correo, telefono: x.telefono, rol: rol.nombre as RolNombre, idSede: sede.idSede, sede: sede.nombre, activo: true,
    });
    return this.ok(`OK: empleado #${id} creado.`);
  }

  cambiarEstadoEmpleado(id: number, activo: boolean) {
    const e = this.lEmpleados.find((x) => x.idEmpleado === id);
    if (!e) return this.fail(`El empleado ${id} no existe.`);
    const otrosAdmins = this.lEmpleados.filter((x) => x.rol === 'ADMIN_SISTEMA' && x.activo && x.idEmpleado !== id).length;
    if (!activo && e.rol === 'ADMIN_SISTEMA' && otrosAdmins === 0) return this.fail('No se puede desactivar al último administrador.');
    this.lEmpleados = this.lEmpleados.map((x) => (x.idEmpleado === id ? { ...x, activo } : x));
    return this.ok(`OK: empleado ${id} ${activo ? 'activado' : 'desactivado'}.`);
  }

  crearMiembro(x: NuevoMiembro) {
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lMiembros.some((m) => m.correo === correo)) return this.fail(`Ya existe un miembro con el correo ${correo}.`);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!sede) return this.fail('La sede indicada no existe.');
    const id = this.sigId(this.lMiembros.map((m) => m.idMiembro));
    this.lMiembros.push({
      idMiembro: id, nombreCompleto: this.nombreCompleto(x.primerNombre, x.segundoNombre, x.primerApellido, x.segundoApellido),
      correo, telefono: x.telefono, idSede: sede.idSede, sede: sede.nombre, planActual: null,
    });
    return this.ok(`OK: miembro #${id} registrado${x.infoMedica ? ' con su información médica' : ''}.`);
  }

  renovarMembresia(x: RenovarMembresia) {
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail(`El miembro ${x.idMiembro} no existe.`);
    const plan = PLANES.find((p) => p.id === x.idTipoPlan);
    if (!plan) return this.fail(`El tipo de plan ${x.idTipoPlan} no existe.`);
    if (!(x.monto > 0)) return this.fail('El monto debe ser mayor que cero.');
    const metodo = METODOS.find((p) => p.id === x.idMetodoPago);
    if (!metodo) return this.fail('El método de pago no existe.');
    const dias = DIAS_PLAN[plan.nombre];
    // La nueva membresía empieza hoy o el día siguiente a que termine la activa.
    const finActivas = this.lMembresias.filter((v) => v.idMiembro === m.idMiembro && v.estado === 'activa').map((v) => v.fechaFin);
    const inicio = [d(0), ...finActivas.map((f) => this.sumarDias(f, 1))].sort().pop()!;
    const fin = this.sumarDias(inicio, dias);
    const idM = this.sigId(this.lMembresias.map((v) => v.idMembresia));
    this.lMembresias.push({ idMembresia: idM, idMiembro: m.idMiembro, miembro: m.nombreCompleto, idSede: m.idSede, plan: plan.nombre, estado: 'activa', fechaInicio: inicio, fechaFin: fin });
    this.lPagos.push({ idPago: this.sigId(this.lPagos.map((p) => p.idPago)), idMiembro: m.idMiembro, miembro: m.nombreCompleto, idSede: m.idSede, metodo: metodo.nombre, monto: x.monto, fechaPago: d(0) });
    this.recalcularPlanes();
    return this.ok(`OK: membresía #${idM} creada (${inicio} a ${fin}) y pago registrado.`);
  }

  crearClase(x: NuevaClase) {
    if (!(x.cupoMaximo > 0)) return this.fail('El cupo máximo debe ser mayor que cero.');
    const e = this.lEmpleados.find((v) => v.idEmpleado === x.idEmpleado);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!e) return this.fail(`El empleado ${x.idEmpleado} no existe.`);
    if (!sede) return this.fail('La sede indicada no existe.');
    if (e.rol !== 'ENTRENADOR_SEDE') return this.fail(`El empleado ${e.idEmpleado} no es entrenador (rol: ${e.rol}).`);
    if (!e.activo) return this.fail(`El entrenador ${e.idEmpleado} está inactivo.`);
    if (e.idSede !== x.idSede) return this.fail(`El entrenador ${e.idEmpleado} pertenece a otra sede (${e.idSede}), no a la sede ${x.idSede} de la clase.`);
    const id = this.sigId(this.lClases.map((c) => c.idClase));
    this.lClases.push({ idClase: id, nombre: x.nombre.trim(), descripcion: (x.descripcion ?? '').trim(), cupoMaximo: x.cupoMaximo, idSede: sede.idSede, sede: sede.nombre, idEmpleado: e.idEmpleado, entrenador: e.nombreCompleto });
    return this.ok(`OK: clase #${id} creada.`);
  }

  crearSesion(x: NuevaSesion) {
    const c = this.lClases.find((v) => v.idClase === x.idClase);
    if (!c) return this.fail('La clase indicada no existe.');
    if (x.fecha < d(0)) return this.fail(`No se puede programar una sesión en una fecha pasada (${x.fecha}).`);
    if (x.horaFin <= x.horaInicio) return this.fail('La hora de fin debe ser posterior a la hora de inicio.');
    const n = this.sigId(this.lSesiones.map((s) => s.numeroSesion));
    this.lSesiones.push({ numeroSesion: n, idClase: c.idClase, clase: c.nombre, idSede: c.idSede, sede: c.sede, idEmpleado: c.idEmpleado, entrenador: c.entrenador, fecha: x.fecha, horaInicio: x.horaInicio, horaFin: x.horaFin, cupoMaximo: c.cupoMaximo, inscritos: 0 });
    return this.ok(`OK: sesión #${n} programada.`);
  }

  inscribir(n: number, idMiembro: number) {
    const m = this.lMiembros.find((v) => v.idMiembro === idMiembro);
    if (!m) return this.fail(`El miembro ${idMiembro} no existe.`);
    const s = this.lSesiones.find((v) => v.numeroSesion === n);
    if (!s) return this.fail(`La sesión ${n} no existe.`);
    if (this.lIns.some((i) => i.numeroSesion === n && i.idMiembro === idMiembro)) return this.fail(`El miembro ${idMiembro} ya está inscrito en la sesión ${n}.`);
    const vigente = this.lMembresias.some((v) => v.idMiembro === idMiembro && v.estado === 'activa' && v.fechaFin >= d(0));
    if (!vigente) return this.fail(`El miembro ${idMiembro} no tiene una membresía activa y vigente.`);
    const inscritos = this.lIns.filter((i) => i.numeroSesion === n).length;
    if (inscritos >= s.cupoMaximo) return this.fail(`La sesión ${n} está llena (cupo máximo: ${s.cupoMaximo}).`);
    this.lIns.push({ numeroSesion: n, idMiembro, miembro: m.nombreCompleto, fechaInscripcion: d(0), asistio: false });
    this.recalcularInscritos();
    return this.ok(`OK: miembro ${idMiembro} inscrito en la sesión ${n}.`);
  }

  marcarAsistencia(n: number, idMiembro: number, asistio: boolean) {
    this.lIns = this.lIns.map((i) => (i.numeroSesion === n && i.idMiembro === idMiembro ? { ...i, asistio } : i));
    return this.ok('OK: asistencia actualizada.');
  }

  crearEquipo(x: NuevoEquipo) {
    const tipo = TIPOS.find((t) => t.id === x.idTipoEquipo);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!tipo || !sede) return this.fail('El tipo de equipo o la sede no existen.');
    const id = this.sigId(this.lEquipos.map((e) => e.idEquipo));
    this.lEquipos.push({ idEquipo: id, nombre: x.nombre.trim(), tipo: tipo.nombre, idSede: sede.idSede, sede: sede.nombre, fechaAdquisicion: x.fechaAdquisicion, estado: 'operativo' });
    return this.ok(`OK: equipo #${id} registrado.`);
  }

  crearMantenimiento(x: NuevoMantenimiento) {
    const e = this.lEquipos.find((v) => v.idEquipo === x.idEquipo);
    if (!e) return this.fail('El equipo indicado no existe.');
    if (x.costo < 0) return this.fail('El costo no puede ser negativo.');
    if (x.fecha > d(0)) return this.fail(`La fecha de mantenimiento (${x.fecha}) no puede ser futura.`);
    if (x.fecha < e.fechaAdquisicion) return this.fail(`El mantenimiento (${x.fecha}) no puede ser anterior a la adquisición del equipo (${e.fechaAdquisicion}).`);
    const n = this.sigId(this.lMant.map((v) => v.numeroMantenimiento));
    this.lMant.push({ numeroMantenimiento: n, idEquipo: e.idEquipo, equipo: e.nombre, idSede: e.idSede, sede: e.sede, descripcion: (x.descripcion ?? '').trim(), costo: x.costo, fecha: x.fecha });
    if (x.fecha >= d(-30)) this.lEquipos = this.lEquipos.map((v) => (v.idEquipo === e.idEquipo ? { ...v, estado: 'mantenimiento' as const } : v));
    return this.ok(`OK: mantenimiento #${n} registrado.`);
  }

  crearRutina(x: NuevaRutina) {
    const u = this.store.usuario();
    if (!u || u.rol !== 'ENTRENADOR_SEDE') return this.fail('Solo un entrenador puede crear rutinas.');
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail('El miembro indicado no existe.');
    if (m.idSede !== u.idSede) return this.fail('El miembro pertenece a otra sede.');
    if (!x.nombreRutina.trim()) return this.fail('La rutina necesita un nombre.');
    if (!x.ejercicios.length) return this.fail('La rutina debe tener al menos un ejercicio.');
    for (const e of x.ejercicios) {
      const falta = e.tipo === 'fuerza' ? !e.series || !e.repeticiones
        : e.tipo === 'cardio' ? !e.duracionMin
        : !e.series || !e.duracionSeg;
      if (falta) return this.fail(`Al ejercicio «${e.nombre}» le faltan datos obligatorios para el tipo ${e.tipo}.`);
    }
    const id = 'r' + (this.lRutinas.length + 1 + Math.floor(Math.random() * 1000));
    this.lRutinas.push({
      idRutina: id, idMiembro: m.idMiembro, miembro: m.nombreCompleto, idEmpleado: u.idEmpleado, entrenador: u.nombre,
      idSede: u.idSede, sede: u.sede, nombreRutina: x.nombreRutina.trim(), objetivo: x.objetivo ?? '', fechaCreacion: d(0), activa: true,
      ejercicios: x.ejercicios, notasEntrenador: x.notasEntrenador,
    });
    return this.ok(`OK: rutina «${x.nombreRutina.trim()}» creada para ${m.nombreCompleto}.`);
  }
  cambiarEstadoRutina(id: string, activa: boolean) {
    const r = this.lRutinas.find((v) => v.idRutina === id);
    if (!r) return this.fail('La rutina no existe.');
    this.lRutinas = this.lRutinas.map((v) => (v.idRutina === id ? { ...v, activa } : v));
    return this.ok(`OK: rutina ${activa ? 'activada' : 'desactivada'}.`);
  }
  crearProgreso(x: NuevoProgreso) {
    const u = this.store.usuario();
    if (!u || u.rol !== 'ENTRENADOR_SEDE') return this.fail('Solo un entrenador puede registrar mediciones.');
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail('El miembro indicado no existe.');
    if (m.idSede !== u.idSede) return this.fail('El miembro pertenece a otra sede.');
    if (x.pesoKg < 20 || x.pesoKg > 400) return this.fail('El peso debe estar entre 20 y 400 kg.');
    if (x.grasaPct !== undefined && (x.grasaPct < 2 || x.grasaPct > 70)) return this.fail('El porcentaje de grasa debe estar entre 2 y 70.');
    if (x.fecha > d(0)) return this.fail('La fecha de la medición no puede ser futura.');
    this.lProgresos.push({
      idProgreso: 'p' + (this.lProgresos.length + 1 + Math.floor(Math.random() * 1000)), idMiembro: m.idMiembro, miembro: m.nombreCompleto,
      idSede: m.idSede, fecha: x.fecha, pesoKg: x.pesoKg, grasaPct: x.grasaPct, medidas: x.medidas, notas: x.notas,
    });
    return this.ok(`OK: medición registrada para ${m.nombreCompleto}.`);
  }
}
