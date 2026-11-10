import { Injectable, inject } from '@angular/core';
import { Observable, delay, of, throwError } from 'rxjs';
import { DataService } from './data.service';
import { Auditoria } from '../model/auditoria';
import { AnalisisMongo, EjercicioFrecuente, PromedioSede, RutinasEntrenador, TendenciaMiembro } from '../model/analisis';
import { Clase, EdicionClase, NuevaClase } from '../model/clase';
import { EdicionEmpleado, Empleado, NuevoEmpleado } from '../model/empleado';
import { EdicionEquipo, NuevoEquipo, NuevoMantenimiento } from '../model/equipo';
import { RenovarMembresia } from '../model/membresia';
import { EdicionMiembro, InfoMedica, Miembro, MiembroDetalle, NuevoMiembro } from '../model/miembro';
import { NombrePersona } from '../model/persona';
import { EdicionProgreso, NuevoProgreso } from '../model/progreso';
import { FiltroReporte, MembresiaPorVencer, ReporteIngreso, ReporteMantenimiento, ReporteOcupacion } from '../model/reporte';
import { EdicionRutina, Ejercicio, NuevaRutina } from '../model/rutina';
import { EdicionSede, NuevaSede, Sede } from '../model/sede';
import { Inscripcion, NuevaSesion } from '../model/sesion';
import { LoginRespuesta, RolNombre } from '../model/usuario';
import {
  CLASES, CLAVE_DEMO, EMPLEADOS, EQUIPOS, INFO_MEDICA, INSCRIPCIONES, MANTENIMIENTOS, MEMBRESIAS,
  MESES_PLAN, METODOS, MIEMBROS, PAGOS, PLANES, PROGRESOS, ROLES, RUTINAS, SEDES, SESIONES, TIPOS, d,
  nombreCompleto,
} from './datos-ejemplo';
import { seCruzan, validarHorarioSesion } from './validaciones';
import { SessionStore } from './sesion.store';

const EMAIL = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
const limpio = (x?: string | null) => (x && x.trim() ? x.trim() : null);
const persona = (x: { primerNombre: string; segundoNombre?: string; primerApellido: string; segundoApellido?: string }): NombrePersona => ({
  primerNombre: x.primerNombre.trim(), segundoNombre: limpio(x.segundoNombre),
  primerApellido: x.primerApellido.trim(), segundoApellido: limpio(x.segundoApellido),
});
const redondear = (n: number, dec = 1) => Math.round(n * 10 ** dec) / 10 ** dec;

/**
 * Implementación en memoria para el modo visual (environment.useMock = true).
 * Replica las reglas de los supuestos para que los formularios muestren errores reales,
 * y el filtro por sede/rol que en producción hace el backend: el administrador ve todo,
 * los demás solo su sede y el entrenador solo sus clases. Los cambios se pierden al recargar.
 */
@Injectable()
export class MockDataService extends DataService {
  private store = inject(SessionStore);

  private lSedes = [...SEDES];
  private lEmpleados = [...EMPLEADOS];
  private lMiembros = [...MIEMBROS];
  private lInfoMedica = new Map<number, InfoMedica>(Object.entries(INFO_MEDICA).map(([k, v]) => [+k, v]));
  private lMembresias = [...MEMBRESIAS];
  private lPagos = [...PAGOS];
  private lClases = [...CLASES];
  private lSesiones = [...SESIONES];
  private lEquipos = [...EQUIPOS];
  private lMant = [...MANTENIMIENTOS];
  private lRutinas = [...RUTINAS];
  private lProgresos = [...PROGRESOS];
  private lIns: Inscripcion[] = INSCRIPCIONES.map(([m, n, f, a]) => ({
    numeroSesion: n, idMiembro: m, miembro: MIEMBROS.find((x) => x.idMiembro === m)!.nombreCompleto,
    fechaInscripcion: d(f), asistio: SESIONES.find((s) => s.numeroSesion === n)!.fecha > d(0) ? null : a,
  }));

  constructor() {
    super();
    this.recalcularInscritos();
    this.recalcularPlanes();
  }

  /**
   * Modo mixto: cuando los miembros vienen del backend, se copian aquí para que los módulos que
   * siguen con datos de ejemplo (membresías, inscripciones, rutinas…) reconozcan a esos miembros.
   */
  sincronizarMiembros(reales: Miembro[]) {
    const porId = new Map(this.lMiembros.map((m) => [m.idMiembro, m]));
    for (const r of reales) porId.set(r.idMiembro, { ...porId.get(r.idMiembro), ...r });
    this.lMiembros = [...porId.values()];
  }

  // ---------- utilidades ----------
  private ok<T>(datos: T): Observable<T> {
    return of(datos).pipe(delay(250));
  }
  private fail(msg: string): Observable<never> {
    return throwError(() => new Error(msg)).pipe(delay(250));
  }
  private get usuario() { return this.store.usuario(); }
  private porSede<T extends { idSede: number }>(lista: T[]): T[] {
    const u = this.usuario;
    return !u || u.rol === 'ADMIN_SISTEMA' ? [...lista] : lista.filter((x) => x.idSede === u.idSede);
  }
  /** Para reportes: el administrador puede elegir sede; los demás siempre ven la suya. */
  private enSede<T extends { idSede: number }>(lista: T[], idSede: number | null): T[] {
    const l = this.porSede(lista);
    return idSede === null ? l : l.filter((x) => x.idSede === idSede);
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
      planActual: this.lMembresias.find((x) => x.idMiembro === m.idMiembro && x.estado === 'ACTIVA' && x.fechaFin >= d(0))?.plan ?? null,
    }));
  }
  private sumarDias(f: string, n: number) {
    const [a, m, dd] = f.split('-').map(Number);
    const x = new Date(a, m - 1, dd + n);
    return `${x.getFullYear()}-${String(x.getMonth() + 1).padStart(2, '0')}-${String(x.getDate()).padStart(2, '0')}`;
  }
  /** Último día de un plan de n meses que empieza en f (mensual del 22-oct vence el 21-nov). */
  private finDePlan(f: string, meses: number) {
    const [a, m, dd] = f.split('-').map(Number);
    const x = new Date(a, m - 1 + meses, dd - 1);
    return `${x.getFullYear()}-${String(x.getMonth() + 1).padStart(2, '0')}-${String(x.getDate()).padStart(2, '0')}`;
  }
  private diasEntre(desde: string, hasta: string) {
    const [a1, m1, d1] = desde.split('-').map(Number);
    const [a2, m2, d2] = hasta.split('-').map(Number);
    return Math.round((Date.UTC(a2, m2 - 1, d2) - Date.UTC(a1, m1 - 1, d1)) / 86_400_000);
  }
  private sesionesVisibles() {
    const u = this.usuario;
    const l = this.porSede(this.lSesiones);
    return u?.rol === 'ENTRENADOR_SEDE' ? l.filter((s) => s.idEmpleado === u.idEmpleado) : l;
  }
  private validarInfoMedica(i?: { contactoEmergencia: string; tipoSangre: string }): string | null {
    if (!i) return null;
    if (!i.contactoEmergencia?.trim() || !i.tipoSangre) return 'La información médica requiere contacto de emergencia y tipo de sangre.';
    return null;
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
  miembrosCadena() { return this.ok([...this.lMiembros]); }
  detalleMiembro(id: number): Observable<MiembroDetalle> {
    const miembro = this.porSede(this.lMiembros).find((m) => m.idMiembro === id);
    if (!miembro) return this.fail(`El miembro ${id} no existe o pertenece a otra sede.`);
    const inscripciones = this.lIns
      .filter((i) => i.idMiembro === id)
      .map((i) => {
        const s = this.lSesiones.find((x) => x.numeroSesion === i.numeroSesion)!;
        return { numeroSesion: s.numeroSesion, clase: s.clase, sede: s.sede, fecha: s.fecha, horaInicio: s.horaInicio, fechaInscripcion: i.fechaInscripcion, asistio: i.asistio };
      })
      .sort((a, b) => (b.fecha + b.horaInicio).localeCompare(a.fecha + a.horaInicio));
    return this.ok({
      miembro,
      infoMedica: this.lInfoMedica.get(id) ?? null,
      membresias: this.lMembresias.filter((m) => m.idMiembro === id).sort((a, b) => b.fechaInicio.localeCompare(a.fechaInicio)),
      pagos: this.lPagos.filter((p) => p.idMiembro === id).sort((a, b) => b.fechaPago.localeCompare(a.fechaPago)),
      inscripciones,
    });
  }
  membresias() { return this.ok(this.porSede(this.lMembresias)); }
  pagos() { return this.ok(this.porSede(this.lPagos)); }
  clases() {
    const u = this.usuario;
    const l = this.porSede(this.lClases);
    return this.ok(u?.rol === 'ENTRENADOR_SEDE' ? l.filter((c) => c.idEmpleado === u.idEmpleado) : l);
  }
  sesiones() { return this.ok(this.sesionesVisibles()); }
  equipos() { return this.ok(this.porSede(this.lEquipos)); }
  mantenimientos() { return this.ok(this.porSede(this.lMant)); }
  inscripciones(n: number) { return this.ok(this.lIns.filter((i) => i.numeroSesion === n)); }
  planes() { return this.ok(PLANES); }
  metodosPago() { return this.ok(METODOS); }
  tiposEquipo() { return this.ok(TIPOS); }
  roles() { return this.ok(ROLES); }

  // ---------- reportes ----------
  reporteIngresos(f: FiltroReporte) {
    const grupos = new Map<string, ReporteIngreso>();
    for (const p of this.enSede(this.lPagos, f.idSede)) {
      if (p.fechaPago < f.desde || p.fechaPago > f.hasta) continue;
      const k = `${p.idSede}|${p.metodo}`;
      const g = grupos.get(k) ?? { idSede: p.idSede, sede: this.lSedes.find((s) => s.idSede === p.idSede)!.nombre, metodo: p.metodo, numPagos: 0, total: 0 };
      g.numPagos++; g.total += p.monto;
      grupos.set(k, g);
    }
    return this.ok([...grupos.values()].sort((a, b) => a.sede.localeCompare(b.sede) || b.total - a.total));
  }
  reporteOcupacion(f: FiltroReporte) {
    const filas: ReporteOcupacion[] = this.sesionesVisibles()
      .filter((s) => (f.idSede === null || s.idSede === f.idSede) && s.fecha >= f.desde && s.fecha <= f.hasta)
      .map((s) => {
        const ins = this.lIns.filter((i) => i.numeroSesion === s.numeroSesion);
        return {
          numeroSesion: s.numeroSesion, clase: s.clase, idSede: s.idSede, sede: s.sede, entrenador: s.entrenador,
          fecha: s.fecha, horaInicio: s.horaInicio, cupoMaximo: s.cupoMaximo,
          inscritos: ins.length, asistentes: ins.filter((i) => i.asistio === true).length,
        };
      })
      .sort((a, b) => (a.fecha + a.horaInicio).localeCompare(b.fecha + b.horaInicio));
    return this.ok(filas);
  }
  membresiasPorVencer(dias: number, idSede: number | null) {
    const hasta = d(dias);
    const filas: MembresiaPorVencer[] = this.enSede(this.lMembresias, idSede)
      .filter((m) => m.estado === 'ACTIVA' && m.fechaFin >= d(0) && m.fechaFin <= hasta)
      .map((m) => {
        const mi = this.lMiembros.find((x) => x.idMiembro === m.idMiembro)!;
        return {
          idMembresia: m.idMembresia, idMiembro: m.idMiembro, miembro: mi.nombreCompleto, telefono: mi.telefono,
          correo: mi.correo, idSede: mi.idSede, sede: mi.sede, plan: m.plan, fechaFin: m.fechaFin,
          diasRestantes: this.diasEntre(d(0), m.fechaFin),
        };
      })
      .sort((a, b) => a.fechaFin.localeCompare(b.fechaFin));
    return this.ok(filas);
  }
  reporteMantenimientos(f: FiltroReporte) {
    const grupos = new Map<string, ReporteMantenimiento>();
    for (const m of this.enSede(this.lMant, f.idSede)) {
      if (m.fechaMantenimiento < f.desde || m.fechaMantenimiento > f.hasta) continue;
      const tipo = this.lEquipos.find((e) => e.idEquipo === m.idEquipo)!.tipo;
      const k = `${m.idSede}|${tipo}`;
      const g = grupos.get(k) ?? { idSede: m.idSede, sede: m.sede, tipo, numMantenimientos: 0, costoTotal: 0 };
      g.numMantenimientos++; g.costoTotal += m.costo;
      grupos.set(k, g);
    }
    return this.ok([...grupos.values()].sort((a, b) => a.sede.localeCompare(b.sede) || b.costoTotal - a.costoTotal));
  }

  // ---------- sedes ----------
  private validarSede(x: NuevaSede, idActual?: number): string | null {
    const otras = this.lSedes.filter((s) => s.idSede !== idActual);
    if (otras.some((s) => s.nombre.toLowerCase() === x.nombre.trim().toLowerCase())) return 'Ya existe una sede con ese nombre.';
    if (otras.some((s) => s.direccion.toLowerCase() === x.direccion.trim().toLowerCase())) return 'Ya existe una sede con esa dirección.';
    return null;
  }
  crearSede(x: NuevaSede) {
    const err = this.validarSede(x);
    if (err) return this.fail(err);
    this.lSedes.push({ idSede: this.sigId(this.lSedes.map((s) => s.idSede)), nombre: x.nombre.trim(), direccion: x.direccion.trim(), telefono: x.telefono.trim() });
    return this.ok(`OK: sede «${x.nombre.trim()}» creada.`);
  }
  editarSede(id: number, x: EdicionSede) {
    if (!this.lSedes.some((s) => s.idSede === id)) return this.fail(`La sede ${id} no existe.`);
    const err = this.validarSede(x, id);
    if (err) return this.fail(err);
    const sede: Sede = { idSede: id, nombre: x.nombre.trim(), direccion: x.direccion.trim(), telefono: x.telefono.trim() };
    this.lSedes = this.lSedes.map((s) => (s.idSede === id ? sede : s));
    // Las listas guardan el nombre de la sede para mostrarlo: se actualiza en todas.
    const r = <T extends { idSede: number; sede: string }>(l: T[]) => l.map((v) => (v.idSede === id ? { ...v, sede: sede.nombre } : v));
    this.lEmpleados = r(this.lEmpleados); this.lMiembros = r(this.lMiembros); this.lClases = r(this.lClases);
    this.lSesiones = r(this.lSesiones); this.lEquipos = r(this.lEquipos); this.lMant = r(this.lMant); this.lRutinas = r(this.lRutinas);
    return this.ok(`OK: sede «${sede.nombre}» actualizada.`);
  }

  // ---------- empleados ----------
  crearEmpleado(x: NuevoEmpleado) {
    if (!x.clave || x.clave.length < 8) return this.fail('La contraseña debe tener al menos 8 caracteres.');
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lEmpleados.some((e) => e.correo === correo)) return this.fail(`Ya existe un empleado con el correo ${correo}.`);
    const rol = ROLES.find((r) => r.id === x.idRolEmpleado);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!rol || !sede) return this.fail('El rol o la sede indicados no existen.');
    const id = this.sigId(this.lEmpleados.map((e) => e.idEmpleado));
    const p = persona(x);
    this.lEmpleados.push({
      idEmpleado: id, ...p, nombreCompleto: nombreCompleto(p), correo, telefono: x.telefono.trim(),
      rol: rol.nombre as RolNombre, idSede: sede.idSede, sede: sede.nombre, activo: true,
    });
    return this.ok(`OK: empleado #${id} creado.`);
  }
  editarEmpleado(id: number, x: EdicionEmpleado) {
    const e = this.lEmpleados.find((v) => v.idEmpleado === id);
    if (!e) return this.fail(`El empleado ${id} no existe.`);
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lEmpleados.some((v) => v.correo === correo && v.idEmpleado !== id)) return this.fail(`Ya existe un empleado con el correo ${correo}.`);
    const rol = ROLES.find((r) => r.id === x.idRolEmpleado);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!rol || !sede) return this.fail('El rol o la sede indicados no existen.');
    const nuevoRol = rol.nombre as RolNombre;
    const otrosAdmins = this.lEmpleados.filter((v) => v.rol === 'ADMIN_SISTEMA' && v.activo && v.idEmpleado !== id).length;
    if (e.rol === 'ADMIN_SISTEMA' && nuevoRol !== 'ADMIN_SISTEMA' && e.activo && otrosAdmins === 0) return this.fail('No se puede quitar el rol al último administrador.');
    const clases = this.lClases.filter((c) => c.idEmpleado === id);
    if (clases.length && (nuevoRol !== 'ENTRENADOR_SEDE' || sede.idSede !== e.idSede)) {
      return this.fail(`El entrenador dicta ${clases.length} clase(s) en su sede: reasígnalas antes de cambiarle el rol o la sede.`);
    }
    const p = persona(x);
    const nombre = nombreCompleto(p);
    this.lEmpleados = this.lEmpleados.map((v) => (v.idEmpleado === id
      ? { ...v, ...p, nombreCompleto: nombre, correo, telefono: x.telefono.trim(), rol: nuevoRol, idSede: sede.idSede, sede: sede.nombre }
      : v));
    this.lClases = this.lClases.map((c) => (c.idEmpleado === id ? { ...c, entrenador: nombre } : c));
    this.lSesiones = this.lSesiones.map((s) => (s.idEmpleado === id ? { ...s, entrenador: nombre } : s));
    this.lRutinas = this.lRutinas.map((r) => (r.idEmpleado === id ? { ...r, entrenador: nombre } : r));
    return this.ok(`OK: empleado #${id} actualizado.`);
  }
  cambiarEstadoEmpleado(id: number, activo: boolean) {
    const e = this.lEmpleados.find((x) => x.idEmpleado === id);
    if (!e) return this.fail(`El empleado ${id} no existe.`);
    const otrosAdmins = this.lEmpleados.filter((x) => x.rol === 'ADMIN_SISTEMA' && x.activo && x.idEmpleado !== id).length;
    if (!activo && e.rol === 'ADMIN_SISTEMA' && otrosAdmins === 0) return this.fail('No se puede desactivar al último administrador.');
    this.lEmpleados = this.lEmpleados.map((x) => (x.idEmpleado === id ? { ...x, activo } : x));
    return this.ok(`OK: empleado ${id} ${activo ? 'activado' : 'desactivado'}.`);
  }

  // ---------- miembros ----------
  crearMiembro(x: NuevoMiembro) {
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lMiembros.some((m) => m.correo === correo)) return this.fail(`Ya existe un miembro con el correo ${correo}.`);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!sede) return this.fail('La sede indicada no existe.');
    const errMed = this.validarInfoMedica(x.infoMedica);
    if (errMed) return this.fail(errMed);
    const id = this.sigId(this.lMiembros.map((m) => m.idMiembro));
    const p = persona(x);
    this.lMiembros.push({
      idMiembro: id, ...p, nombreCompleto: nombreCompleto(p), correo, telefono: x.telefono.trim(),
      idSede: sede.idSede, sede: sede.nombre, fechaRegistro: d(0), planActual: null,
    });
    if (x.infoMedica) this.lInfoMedica.set(id, { ...x.infoMedica, condicionMedica: limpio(x.infoMedica.condicionMedica) });
    return this.ok(`OK: miembro #${id} registrado${x.infoMedica ? ' con su información médica' : ''}.`);
  }
  editarMiembro(id: number, x: EdicionMiembro) {
    const m = this.lMiembros.find((v) => v.idMiembro === id);
    if (!m) return this.fail(`El miembro ${id} no existe.`);
    const correo = x.correo.trim().toLowerCase();
    if (!EMAIL.test(correo)) return this.fail('El correo no tiene un formato válido.');
    if (this.lMiembros.some((v) => v.correo === correo && v.idMiembro !== id)) return this.fail(`Ya existe un miembro con el correo ${correo}.`);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!sede) return this.fail('La sede indicada no existe.');
    const errMed = this.validarInfoMedica(x.infoMedica);
    if (errMed) return this.fail(errMed);
    const p = persona(x);
    const nombre = nombreCompleto(p);
    this.lMiembros = this.lMiembros.map((v) => (v.idMiembro === id
      ? { ...v, ...p, nombreCompleto: nombre, correo, telefono: x.telefono.trim(), idSede: sede.idSede, sede: sede.nombre }
      : v));
    // info_medica: se crea o se actualiza (igual que el backend, no se elimina al editar).
    if (x.infoMedica) this.lInfoMedica.set(id, { ...x.infoMedica, condicionMedica: limpio(x.infoMedica.condicionMedica) });
    const r = <T extends { idMiembro: number; miembro: string }>(l: T[]) => l.map((v) => (v.idMiembro === id ? { ...v, miembro: nombre } : v));
    this.lMembresias = r(this.lMembresias).map((v) => (v.idMiembro === id ? { ...v, idSede: sede.idSede } : v));
    this.lPagos = r(this.lPagos).map((v) => (v.idMiembro === id ? { ...v, idSede: sede.idSede } : v));
    this.lIns = r(this.lIns); this.lRutinas = r(this.lRutinas); this.lProgresos = r(this.lProgresos);
    return this.ok(`OK: miembro #${id} actualizado.`);
  }

  // ---------- membresías ----------
  renovarMembresia(x: RenovarMembresia) {
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail(`El miembro ${x.idMiembro} no existe.`);
    const plan = PLANES.find((p) => p.id === x.idTipoPlan);
    if (!plan) return this.fail(`El tipo de plan ${x.idTipoPlan} no existe.`);
    if (!(x.monto > 0)) return this.fail('El monto debe ser mayor que cero.');
    const metodo = METODOS.find((p) => p.id === x.idMetodoPago);
    if (!metodo) return this.fail('El método de pago no existe.');
    // Solo una membresía activa a la vez (supuesto 5): la anterior pasa a VENCIDA y
    // la nueva empieza hoy o el día siguiente a que termine la anterior (no se pierden días pagados).
    const activa = this.lMembresias.find((v) => v.idMiembro === m.idMiembro && v.estado === 'ACTIVA');
    const siguiente = activa ? this.sumarDias(activa.fechaFin, 1) : d(0);
    const inicio = siguiente > d(0) ? siguiente : d(0);
    const fin = this.finDePlan(inicio, MESES_PLAN[plan.nombre]);
    if (activa) this.lMembresias = this.lMembresias.map((v) => (v === activa ? { ...v, estado: 'VENCIDA' as const } : v));
    const idM = this.sigId(this.lMembresias.map((v) => v.idMembresia));
    this.lMembresias.push({ idMembresia: idM, idMiembro: m.idMiembro, miembro: m.nombreCompleto, idSede: m.idSede, plan: plan.nombre, estado: 'ACTIVA', fechaInicio: inicio, fechaFin: fin });
    this.lPagos.push({ idPago: this.sigId(this.lPagos.map((p) => p.idPago)), idMiembro: m.idMiembro, miembro: m.nombreCompleto, idSede: m.idSede, metodo: metodo.nombre, monto: x.monto, fechaPago: d(0) });
    this.recalcularPlanes();
    return this.ok(`OK: membresía #${idM} creada (${inicio} a ${fin}) y pago registrado.`);
  }

  // ---------- clases y sesiones ----------
  private validarClase(x: NuevaClase): { error: string } | { entrenador: Empleado; sede: Sede } {
    if (!(x.cupoMaximo > 0)) return { error: 'El cupo máximo debe ser mayor que cero.' };
    const e = this.lEmpleados.find((v) => v.idEmpleado === x.idEmpleado);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!e) return { error: `El empleado ${x.idEmpleado} no existe.` };
    if (!sede) return { error: 'La sede indicada no existe.' };
    if (e.rol !== 'ENTRENADOR_SEDE') return { error: `El empleado ${e.idEmpleado} no es entrenador.` };
    if (!e.activo) return { error: `El entrenador ${e.nombreCompleto} está inactivo.` };
    if (e.idSede !== x.idSede) return { error: `${e.nombreCompleto} pertenece a ${e.sede}, no a la sede de la clase.` };
    return { entrenador: e, sede };
  }
  crearClase(x: NuevaClase) {
    const v = this.validarClase(x);
    if ('error' in v) return this.fail(v.error);
    const id = this.sigId(this.lClases.map((c) => c.idClase));
    this.lClases.push({ idClase: id, nombre: x.nombre.trim(), descripcion: limpio(x.descripcion), cupoMaximo: x.cupoMaximo, idSede: v.sede.idSede, sede: v.sede.nombre, idEmpleado: v.entrenador.idEmpleado, entrenador: v.entrenador.nombreCompleto });
    return this.ok(`OK: clase #${id} creada.`);
  }
  editarClase(id: number, x: EdicionClase) {
    if (!this.lClases.some((c) => c.idClase === id)) return this.fail(`La clase ${id} no existe.`);
    const v = this.validarClase(x);
    if ('error' in v) return this.fail(v.error);
    const futuras = this.lSesiones.filter((s) => s.idClase === id && s.fecha >= d(0));
    const llena = futuras.find((s) => s.inscritos > x.cupoMaximo);
    if (llena) return this.fail(`La sesión ${llena.numeroSesion} ya tiene ${llena.inscritos} inscritos: el cupo no puede ser menor.`);
    // Si cambia el entrenador, sus sesiones futuras no pueden chocar con las que ya dicta.
    for (const s of futuras) {
      const cruce = this.cruceEntrenador(v.entrenador.idEmpleado, s, id);
      if (cruce) return this.fail(`${v.entrenador.nombreCompleto} ya dicta «${cruce.clase}» el ${cruce.fecha} de ${cruce.horaInicio} a ${cruce.horaFin}, que se cruza con la sesión ${s.numeroSesion}.`);
    }
    const clase: Clase = { idClase: id, nombre: x.nombre.trim(), descripcion: limpio(x.descripcion), cupoMaximo: x.cupoMaximo, idSede: v.sede.idSede, sede: v.sede.nombre, idEmpleado: v.entrenador.idEmpleado, entrenador: v.entrenador.nombreCompleto };
    this.lClases = this.lClases.map((c) => (c.idClase === id ? clase : c));
    // La sesión hereda nombre, sede, entrenador y cupo de su clase (supuesto 10).
    this.lSesiones = this.lSesiones.map((s) => (s.idClase === id
      ? { ...s, clase: clase.nombre, idSede: clase.idSede, sede: clase.sede, idEmpleado: clase.idEmpleado, entrenador: clase.entrenador, cupoMaximo: clase.cupoMaximo }
      : s));
    return this.ok(`OK: clase «${clase.nombre}» actualizada.`);
  }
  /** Primera sesión del entrenador que se cruza con la franja dada (excluye las de `excluirClase`). */
  private cruceEntrenador(idEmpleado: number, franja: { fecha: string; horaInicio: string; horaFin: string }, excluirClase?: number) {
    return this.lSesiones.find((s) => s.idEmpleado === idEmpleado && s.idClase !== excluirClase && s.fecha === franja.fecha && seCruzan(s, franja));
  }
  crearSesion(x: NuevaSesion) {
    const c = this.lClases.find((v) => v.idClase === x.idClase);
    if (!c) return this.fail('La clase indicada no existe.');
    const errHorario = validarHorarioSesion(x.fecha, x.horaInicio, x.horaFin, d(0));
    if (errHorario) return this.fail(errHorario);
    // Un entrenador no puede estar en dos sesiones a la vez (incluye otra sesión de la misma clase).
    const cruce = this.cruceEntrenador(c.idEmpleado, x);
    if (cruce) {
      return this.fail(`${c.entrenador} ya tiene «${cruce.clase}» ese día de ${cruce.horaInicio} a ${cruce.horaFin}: las sesiones no se pueden cruzar.`);
    }
    const n = this.sigId(this.lSesiones.map((s) => s.numeroSesion));
    this.lSesiones.push({ numeroSesion: n, idClase: c.idClase, clase: c.nombre, idSede: c.idSede, sede: c.sede, idEmpleado: c.idEmpleado, entrenador: c.entrenador, fecha: x.fecha, horaInicio: x.horaInicio, horaFin: x.horaFin, cupoMaximo: c.cupoMaximo, inscritos: 0 });
    return this.ok(`OK: sesión #${n} programada.`);
  }
  inscribir(n: number, idMiembro: number) {
    const m = this.lMiembros.find((v) => v.idMiembro === idMiembro);
    if (!m) return this.fail(`El miembro ${idMiembro} no existe.`);
    const s = this.lSesiones.find((v) => v.numeroSesion === n);
    if (!s) return this.fail(`La sesión ${n} no existe.`);
    if (this.lIns.some((i) => i.numeroSesion === n && i.idMiembro === idMiembro)) return this.fail(`${m.nombreCompleto} ya está inscrito en esta sesión.`);
    if (s.fecha < d(0)) return this.fail(`La sesión ${n} ya finalizó.`);
    const vigente = this.lMembresias.some((v) => v.idMiembro === idMiembro && v.estado === 'ACTIVA' && v.fechaFin >= d(0));
    if (!vigente) return this.fail(`${m.nombreCompleto} no tiene una membresía activa y vigente.`);
    const inscritos = this.lIns.filter((i) => i.numeroSesion === n).length;
    if (inscritos >= s.cupoMaximo) return this.fail(`La sesión ${n} está llena (cupo máximo: ${s.cupoMaximo}).`);
    this.lIns.push({ numeroSesion: n, idMiembro, miembro: m.nombreCompleto, fechaInscripcion: d(0), asistio: null });
    this.recalcularInscritos();
    return this.ok(`OK: ${m.nombreCompleto} inscrito en la sesión ${n}.`);
  }
  marcarAsistencia(n: number, idMiembro: number, asistio: boolean) {
    const s = this.lSesiones.find((v) => v.numeroSesion === n);
    if (!s) return this.fail(`La sesión ${n} no existe.`);
    if (s.fecha > d(0)) return this.fail('No se puede registrar asistencia antes del día de la sesión.');
    if (!this.lIns.some((i) => i.numeroSesion === n && i.idMiembro === idMiembro)) return this.fail(`El miembro ${idMiembro} no está inscrito en la sesión ${n}.`);
    this.lIns = this.lIns.map((i) => (i.numeroSesion === n && i.idMiembro === idMiembro ? { ...i, asistio } : i));
    return this.ok('OK: asistencia actualizada.');
  }

  // ---------- equipos y mantenimiento ----------
  crearEquipo(x: NuevoEquipo) {
    const tipo = TIPOS.find((t) => t.id === x.idTipoEquipo);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!tipo || !sede) return this.fail('El tipo de equipo o la sede no existen.');
    if (x.fechaAdquisicion > d(0)) return this.fail('La fecha de adquisición no puede ser futura.');
    const id = this.sigId(this.lEquipos.map((e) => e.idEquipo));
    this.lEquipos.push({ idEquipo: id, nombre: x.nombre.trim(), tipo: tipo.nombre, idSede: sede.idSede, sede: sede.nombre, fechaAdquisicion: x.fechaAdquisicion, ultimoMantenimiento: null });
    return this.ok(`OK: equipo #${id} registrado.`);
  }
  editarEquipo(id: number, x: EdicionEquipo) {
    const e = this.lEquipos.find((v) => v.idEquipo === id);
    if (!e) return this.fail(`El equipo ${id} no existe.`);
    const tipo = TIPOS.find((t) => t.id === x.idTipoEquipo);
    const sede = this.lSedes.find((s) => s.idSede === x.idSede);
    if (!tipo || !sede) return this.fail('El tipo de equipo o la sede no existen.');
    if (x.fechaAdquisicion > d(0)) return this.fail('La fecha de adquisición no puede ser futura.');
    const primero = this.lMant.filter((m) => m.idEquipo === id).map((m) => m.fechaMantenimiento).sort()[0];
    if (primero && x.fechaAdquisicion > primero) return this.fail(`El equipo tiene un mantenimiento del ${primero}: la adquisición no puede ser posterior.`);
    this.lEquipos = this.lEquipos.map((v) => (v.idEquipo === id
      ? { ...v, nombre: x.nombre.trim(), tipo: tipo.nombre, idSede: sede.idSede, sede: sede.nombre, fechaAdquisicion: x.fechaAdquisicion }
      : v));
    this.lMant = this.lMant.map((m) => (m.idEquipo === id ? { ...m, equipo: x.nombre.trim(), idSede: sede.idSede, sede: sede.nombre } : m));
    return this.ok(`OK: equipo «${x.nombre.trim()}» actualizado.`);
  }
  crearMantenimiento(x: NuevoMantenimiento) {
    const e = this.lEquipos.find((v) => v.idEquipo === x.idEquipo);
    if (!e) return this.fail('El equipo indicado no existe.');
    if (x.costo < 0) return this.fail('El costo no puede ser negativo.');
    const f = x.fechaMantenimiento;
    if (f > d(0)) return this.fail(`La fecha de mantenimiento (${f}) no puede ser futura.`);
    if (f < e.fechaAdquisicion) return this.fail(`El mantenimiento (${f}) no puede ser anterior a la adquisición del equipo (${e.fechaAdquisicion}).`);
    const n = this.sigId(this.lMant.map((v) => v.numeroMantenimiento));
    this.lMant.push({ numeroMantenimiento: n, idEquipo: e.idEquipo, equipo: e.nombre, idSede: e.idSede, sede: e.sede, descripcion: limpio(x.descripcion), costo: x.costo, fechaMantenimiento: f });
    this.lEquipos = this.lEquipos.map((v) =>
      v.idEquipo === e.idEquipo && (!v.ultimoMantenimiento || f > v.ultimoMantenimiento) ? { ...v, ultimoMantenimiento: f } : v);
    return this.ok(`OK: mantenimiento #${n} registrado.`);
  }

  // ---------- MongoDB: rutinas ----------
  rutinas() { return this.ok(this.porSede(this.lRutinas)); }
  private validarEjercicios(nombre: string, ejercicios: Ejercicio[]): string | null {
    if (!nombre.trim()) return 'La rutina necesita un nombre.';
    if (!ejercicios.length) return 'La rutina debe tener al menos un ejercicio.';
    for (const e of ejercicios) {
      const falta = e.tipo === 'fuerza' ? !e.series || !e.repeticiones
        : e.tipo === 'cardio' ? !e.duracionMin
        : !e.series || !e.duracionSeg;
      if (falta) return `Al ejercicio «${e.nombre}» le faltan datos obligatorios para el tipo ${e.tipo}.`;
    }
    return null;
  }
  /** Solo el entrenador que creó la rutina (o el administrador) la modifica. */
  private puedeModificarRutina(idRutina: string): string | null {
    const u = this.usuario;
    const r = this.lRutinas.find((v) => v.idRutina === idRutina);
    if (!r) return 'La rutina no existe.';
    if (!u || (u.rol !== 'ADMIN_SISTEMA' && r.idEmpleado !== u.idEmpleado)) return 'Solo el entrenador que creó la rutina puede modificarla.';
    return null;
  }
  crearRutina(x: NuevaRutina) {
    const u = this.usuario;
    if (!u || u.rol !== 'ENTRENADOR_SEDE') return this.fail('Solo un entrenador puede crear rutinas.');
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail('El miembro indicado no existe.');
    if (m.idSede !== u.idSede) return this.fail('El miembro pertenece a otra sede.');
    const err = this.validarEjercicios(x.nombreRutina, x.ejercicios);
    if (err) return this.fail(err);
    const id = 'r' + Date.now().toString(36);
    this.lRutinas.push({
      idRutina: id, idMiembro: m.idMiembro, miembro: m.nombreCompleto, idEmpleado: u.idEmpleado, entrenador: u.nombre,
      idSede: u.idSede, sede: u.sede, nombreRutina: x.nombreRutina.trim(), objetivo: x.objetivo ?? '', fechaCreacion: d(0), activa: true,
      ejercicios: x.ejercicios, notasEntrenador: x.notasEntrenador,
    });
    return this.ok(`OK: rutina «${x.nombreRutina.trim()}» creada para ${m.nombreCompleto}.`);
  }
  editarRutina(id: string, x: EdicionRutina) {
    const permiso = this.puedeModificarRutina(id);
    if (permiso) return this.fail(permiso);
    const err = this.validarEjercicios(x.nombreRutina, x.ejercicios);
    if (err) return this.fail(err);
    this.lRutinas = this.lRutinas.map((r) => (r.idRutina === id
      ? { ...r, nombreRutina: x.nombreRutina.trim(), objetivo: x.objetivo ?? '', ejercicios: x.ejercicios, notasEntrenador: x.notasEntrenador }
      : r));
    return this.ok(`OK: rutina «${x.nombreRutina.trim()}» actualizada.`);
  }
  cambiarEstadoRutina(id: string, activa: boolean) {
    const permiso = this.puedeModificarRutina(id);
    if (permiso) return this.fail(permiso);
    this.lRutinas = this.lRutinas.map((v) => (v.idRutina === id ? { ...v, activa } : v));
    return this.ok(`OK: rutina ${activa ? 'activada' : 'desactivada'}.`);
  }
  eliminarRutina(id: string) {
    const permiso = this.puedeModificarRutina(id);
    if (permiso) return this.fail(permiso);
    this.lRutinas = this.lRutinas.filter((r) => r.idRutina !== id);
    return this.ok('OK: rutina eliminada.');
  }

  // ---------- MongoDB: progreso ----------
  progresos() { return this.ok(this.porSede(this.lProgresos)); }
  private validarMedicion(x: EdicionProgreso): string | null {
    if (x.pesoKg < 20 || x.pesoKg > 400) return 'El peso debe estar entre 20 y 400 kg.';
    if (x.grasaPct !== undefined && (x.grasaPct < 2 || x.grasaPct > 70)) return 'El porcentaje de grasa debe estar entre 2 y 70.';
    if (x.fecha > d(0)) return 'La fecha de la medición no puede ser futura.';
    return null;
  }
  private puedeModificarProgreso(id: string): string | null {
    const u = this.usuario;
    const p = this.lProgresos.find((v) => v.idProgreso === id);
    if (!p) return 'La medición no existe.';
    if (!u || (u.rol !== 'ADMIN_SISTEMA' && !(u.rol === 'ENTRENADOR_SEDE' && p.idSede === u.idSede))) return 'Solo un entrenador de la sede puede modificar mediciones.';
    return null;
  }
  crearProgreso(x: NuevoProgreso) {
    const u = this.usuario;
    if (!u || u.rol !== 'ENTRENADOR_SEDE') return this.fail('Solo un entrenador puede registrar mediciones.');
    const m = this.lMiembros.find((v) => v.idMiembro === x.idMiembro);
    if (!m) return this.fail('El miembro indicado no existe.');
    if (m.idSede !== u.idSede) return this.fail('El miembro pertenece a otra sede.');
    const err = this.validarMedicion(x);
    if (err) return this.fail(err);
    this.lProgresos.push({
      idProgreso: 'p' + Date.now().toString(36), idMiembro: m.idMiembro, miembro: m.nombreCompleto,
      idSede: m.idSede, fecha: x.fecha, pesoKg: x.pesoKg, grasaPct: x.grasaPct, medidas: x.medidas, notas: x.notas,
    });
    return this.ok(`OK: medición registrada para ${m.nombreCompleto}.`);
  }
  editarProgreso(id: string, x: EdicionProgreso) {
    const permiso = this.puedeModificarProgreso(id);
    if (permiso) return this.fail(permiso);
    const err = this.validarMedicion(x);
    if (err) return this.fail(err);
    this.lProgresos = this.lProgresos.map((p) => (p.idProgreso === id
      ? { ...p, fecha: x.fecha, pesoKg: x.pesoKg, grasaPct: x.grasaPct, medidas: x.medidas, notas: x.notas }
      : p));
    return this.ok('OK: medición actualizada.');
  }
  eliminarProgreso(id: string) {
    const permiso = this.puedeModificarProgreso(id);
    if (permiso) return this.fail(permiso);
    this.lProgresos = this.lProgresos.filter((p) => p.idProgreso !== id);
    return this.ok('OK: medición eliminada.');
  }

  // ---------- MongoDB: agregaciones ----------
  /** Simula en memoria los pipelines documentados en component/analisis/pipelines.ts. */
  analisisMongo(): Observable<AnalisisMongo> {
    const progresos = this.porSede(this.lProgresos);
    const rutinas = this.porSede(this.lRutinas);
    const sedeDe = (id: number) => this.lSedes.find((s) => s.idSede === id)!.nombre;

    // 1) $sort fecha + $group por miembro con $first / $last
    const porMiembro = new Map<number, typeof progresos>();
    for (const p of [...progresos].sort((a, b) => a.fecha.localeCompare(b.fecha))) {
      porMiembro.set(p.idMiembro, [...(porMiembro.get(p.idMiembro) ?? []), p]);
    }
    const tendencias: TendenciaMiembro[] = [...porMiembro.values()].map((l) => {
      const ini = l[0], fin = l[l.length - 1];
      return {
        idMiembro: ini.idMiembro, miembro: ini.miembro, sede: sedeDe(ini.idSede), mediciones: l.length,
        pesoInicial: ini.pesoKg, pesoActual: fin.pesoKg, variacionKg: redondear(fin.pesoKg - ini.pesoKg),
        grasaInicial: ini.grasaPct ?? null, grasaActual: fin.grasaPct ?? null,
      };
    }).sort((a, b) => a.variacionKg - b.variacionKg);

    // 2) último registro por miembro + $group por sede con $avg
    const porSede = new Map<number, { pesos: number[]; grasas: number[] }>();
    for (const l of porMiembro.values()) {
      const ult = l[l.length - 1];
      const g = porSede.get(ult.idSede) ?? { pesos: [], grasas: [] };
      g.pesos.push(ult.pesoKg);
      if (ult.grasaPct !== undefined) g.grasas.push(ult.grasaPct);
      porSede.set(ult.idSede, g);
    }
    const prom = (l: number[]) => redondear(l.reduce((a, b) => a + b, 0) / l.length);
    const promediosSede: PromedioSede[] = [...porSede.entries()].map(([idSede, g]) => ({
      idSede, sede: sedeDe(idSede), miembros: g.pesos.length, pesoPromedio: prom(g.pesos),
      grasaPromedio: g.grasas.length ? prom(g.grasas) : null,
    })).sort((a, b) => a.sede.localeCompare(b.sede));

    // 3) $match activa + $unwind ejercicios + $group por nombre
    const ej = new Map<string, EjercicioFrecuente>();
    for (const r of rutinas.filter((v) => v.activa)) {
      for (const e of r.ejercicios) {
        const k = e.nombre.toLowerCase();
        const g = ej.get(k) ?? { nombre: e.nombre, tipo: e.tipo, rutinas: 0 };
        g.rutinas++;
        ej.set(k, g);
      }
    }
    const ejercicios = [...ej.values()].sort((a, b) => b.rutinas - a.rutinas || a.nombre.localeCompare(b.nombre)).slice(0, 8);

    // 4) $group por entrenador con $sum condicional
    const ent = new Map<number, RutinasEntrenador>();
    for (const r of rutinas) {
      const g = ent.get(r.idEmpleado) ?? { idEmpleado: r.idEmpleado, entrenador: r.entrenador, activas: 0, inactivas: 0 };
      if (r.activa) g.activas++; else g.inactivas++;
      ent.set(r.idEmpleado, g);
    }
    const rutinasEntrenador = [...ent.values()].sort((a, b) => b.activas + b.inactivas - (a.activas + a.inactivas));

    return this.ok({ tendencias, promediosSede, ejercicios, rutinasEntrenador });
  }

  // ---------- Auditoría ----------
  /**
   * Simula lo que dejan los triggers del script 03: cada pago y cada membresía registrados
   * quedan como INSERT, hechos por un recepcionista de la sede.
   */
  auditoria(): Observable<Auditoria[]> {
    const recepcion = (idSede: number) =>
      this.lEmpleados.find((e) => e.idSede === idSede && e.rol === 'RECEPCIONISTA_SEDE') ?? null;
    const fila = (tabla: string, id: number, idSede: number, fecha: string, hora: string) => {
      const e = recepcion(idSede);
      return {
        tabla, operacion: 'INSERT', idRegistro: String(id), rolBd: 'rol_recepcionista_sede',
        idEmpleado: e?.idEmpleado ?? null, empleado: e?.nombreCompleto ?? null, fecha: `${fecha}T${hora}`,
      };
    };
    const filas = [
      ...this.lPagos.map((p) => fila('pago', p.idPago, p.idSede, p.fechaPago, '10:15:00')),
      ...this.lMembresias.map((m) => fila('membresia', m.idMembresia, m.idSede, m.fechaInicio, '10:14:00')),
    ].sort((a, b) => b.fecha.localeCompare(a.fecha));
    return this.ok(filas.map((f, i): Auditoria => ({ idAuditoria: filas.length - i, ...f })));
  }
}