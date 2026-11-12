import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, forkJoin, map } from 'rxjs';
import { environment } from '../../environments/environment';
import { DataService } from './data.service';
import { nombrePropio } from './util';
import { AnalisisMongo, EjercicioFrecuente, RutinasEntrenador } from '../model/analisis';
import { Auditoria } from '../model/auditoria';
import { Catalogo } from '../model/catalogo';
import { Clase, EdicionClase, NuevaClase } from '../model/clase';
import { EdicionEmpleado, Empleado, NuevoEmpleado } from '../model/empleado';
import { EdicionEquipo, Equipo, Mantenimiento, NuevoEquipo, NuevoMantenimiento } from '../model/equipo';
import { Membresia, RenovarMembresia } from '../model/membresia';
import { EdicionMiembro, Miembro, MiembroDetalle, NuevoMiembro } from '../model/miembro';
import { Pago } from '../model/pago';
import { EdicionProgreso, NuevoProgreso, Progreso } from '../model/progreso';
import { FiltroReporte, MembresiaPorVencer, ReporteIngreso, ReporteMantenimiento, ReporteOcupacion } from '../model/reporte';
import { EdicionRutina, NuevaRutina, Rutina } from '../model/rutina';
import { EdicionSede, NuevaSede, Sede } from '../model/sede';
import { Inscripcion, NuevaSesion, Sesion } from '../model/sesion';
import { LoginRespuesta } from '../model/usuario';


function textoRespuesta(cuerpo: string | null): string {
  let t = (cuerpo ?? '').trim();
  try {
    const json = JSON.parse(t);
    if (json && typeof json.mensaje === 'string') t = json.mensaje;
  } catch {
  }
  return t ? t[0].toUpperCase() + t.slice(1) : 'Operación realizada.';
}

/**
 * Limpia lo que se envía: quita espacios al inicio y al final de cada texto y
 * convierte los textos vacíos en null (campos opcionales sin llenar).
 */
function limpiar(valor: unknown): unknown {
  if (typeof valor === 'string') return valor.trim() || null;
  if (Array.isArray(valor)) return valor.map(limpiar);
  if (valor && typeof valor === 'object') {
    return Object.fromEntries(Object.entries(valor).map(([k, v]) => [k, limpiar(v)]));
  }
  return valor;
}

/** Los planes llegan en mayúscula desde tipo_plan (MENSUAL); el front los muestra en minúscula. */
const plan = (p: string | null | undefined) => (p ? p.toLowerCase() : null);
const miembroDesdeApi = (m: Miembro): Miembro => ({ ...m, planActual: plan(m.planActual) });
const membresiaDesdeApi = (m: Membresia): Membresia => ({ ...m, plan: plan(m.plan) ?? m.plan });
/** Los métodos de pago llegan en mayúscula (TARJETA); se muestran como «Tarjeta». */
const pagoDesdeApi = (p: Pago): Pago => ({ ...p, metodo: nombrePropio(p.metodo) });
const hora = (h: string | null | undefined) => (h ? h.slice(0, 5) : '');

const catalogo = (campoId: string, minuscula = false) =>
  map((l: Record<string, unknown>[]) =>
    l.map((x): Catalogo => ({ id: Number(x[campoId]), nombre: minuscula ? String(x['nombre']).toLowerCase() : String(x['nombre']) })),
  );

type EquipoApi = Omit<Equipo, 'ultimoMantenimiento'>;

/** En el backend el campo se llama grasaCorporalPct; en el front, grasaPct. */
type ProgresoApi = Omit<Progreso, 'grasaPct'> & { grasaCorporalPct?: number | null };
const progresoDesdeApi = ({ grasaCorporalPct, ...p }: ProgresoApi): Progreso => ({ ...p, grasaPct: grasaCorporalPct ?? undefined });
const progresoHaciaApi = ({ grasaPct, ...d }: EdicionProgreso) => ({ ...d, grasaCorporalPct: grasaPct });

/** /reporte/rutinasentrenador responde id_empleado (como en Mongo) y puede no traer el nombre. */
type RutinasEntrenadorApi = { id_empleado: number; entrenador?: string; activas: number; inactivas: number };
const ultimoMantenimiento = (l: Mantenimiento[], idEquipo: number): string | null =>
  l.filter((m) => m.idEquipo === idEquipo).reduce<string | null>((max, m) => (!max || m.fechaMantenimiento > max ? m.fechaMantenimiento : max), null);

@Injectable()
export class HttpDataService extends DataService {
  protected http = inject(HttpClient);
  protected base = environment.apiUrl;

  protected get<T>(ruta: string, params?: HttpParams) { return this.http.get<T>(`${this.base}${ruta}`, { params }); }
  protected post(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.post(`${this.base}${ruta}`, limpiar(cuerpo), { responseType: 'text' }).pipe(map(textoRespuesta));
  }
  protected put(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.put(`${this.base}${ruta}`, limpiar(cuerpo), { responseType: 'text' }).pipe(map(textoRespuesta));
  }
  protected patch(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.patch(`${this.base}${ruta}`, limpiar(cuerpo), { responseType: 'text' }).pipe(map(textoRespuesta));
  }
  private filtro(f: FiltroReporte) {
    let p = new HttpParams().set('desde', f.desde).set('hasta', f.hasta);
    if (f.idSede !== null) p = p.set('idSede', f.idSede);
    return p;
  }
  login(correo: string, clave: string): Observable<LoginRespuesta> {
    return this.http.post<LoginRespuesta>(`${this.base}/auth/login`, { correo, clave });
  }
  sedes() { return this.get<Sede[]>('/sede/getall'); }
  crearSede(d: NuevaSede) { return this.post('/sede/create', d); }
  editarSede(id: number, d: EdicionSede) { return this.put(`/sede/update/${id}`, d); }

  empleados() { return this.get<Empleado[]>('/empleado/getall'); }
  crearEmpleado(d: NuevoEmpleado) { return this.post('/empleado/create', d); }
  editarEmpleado(id: number, d: EdicionEmpleado) { return this.put(`/empleado/update/${id}`, d); }
  cambiarEstadoEmpleado(id: number, activo: boolean) { return this.put(`/empleado/updateestado/${id}`, { activo }); }

  miembros() { return this.get<Miembro[]>('/miembro/getall').pipe(map((l) => l.map(miembroDesdeApi))); }
  miembrosCadena() { return this.get<Miembro[]>('/miembro/getmiembroscadena').pipe(map((l) => l.map(miembroDesdeApi))); }
  detalleMiembro(id: number) {
    return this.get<MiembroDetalle>(`/miembro/get/${id}`).pipe(
      map((d) => ({
        ...d,
        miembro: miembroDesdeApi(d.miembro),
        membresias: (d.membresias ?? []).map(membresiaDesdeApi),
        pagos: (d.pagos ?? []).map(pagoDesdeApi),
        inscripciones: (d.inscripciones ?? []).map((i) => ({ ...i, horaInicio: hora(i.horaInicio) })),
      })),
    );
  }
  crearMiembro(d: NuevoMiembro) { return this.post('/miembro/create', d); }
  editarMiembro(id: number, d: EdicionMiembro) { return this.put(`/miembro/update/${id}`, d); }

  membresias() { return this.get<Membresia[]>('/membresia/getall').pipe(map((l) => l.map(membresiaDesdeApi))); }
  renovarMembresia(d: RenovarMembresia) { return this.post('/membresia/renovar', d); }
  pagos() { return this.get<Pago[]>('/pago/getall').pipe(map((l) => l.map(pagoDesdeApi))); }
  clases() { return this.get<Clase[]>('/clase/getall'); }
  crearClase(d: NuevaClase) { return this.post('/clase/create', d); }
  editarClase(id: number, d: EdicionClase) { return this.put(`/clase/update/${id}`, d); }
  sesiones() {
    return this.get<Sesion[]>('/sesion/getall').pipe(
      map((l) => l.map((s) => ({ ...s, horaInicio: hora(s.horaInicio), horaFin: hora(s.horaFin) }))),
    );
  }
  crearSesion(d: NuevaSesion) { return this.post('/sesion/create', d); }
  inscripciones(n: number) {
    return this.get<Inscripcion[]>(`/inscripcion/get/${n}`).pipe(map((l) => l.map((i) => ({ ...i, horaInicio: hora(i.horaInicio) }))));
  }
  inscribir(n: number, idMiembro: number) { return this.post(`/inscripcion/create/${n}`, { idMiembro }); }
  marcarAsistencia(n: number, idMiembro: number, asistio: boolean) {
    return this.put(`/inscripcion/updateasistencia/${n}`, { idMiembro, asistio });
  }
  equipos() {
    return forkJoin({ equipos: this.get<EquipoApi[]>('/equipo/getall'), mant: this.mantenimientos() }).pipe(
      map(({ equipos, mant }) => equipos.map((e) => ({ ...e, ultimoMantenimiento: ultimoMantenimiento(mant, e.idEquipo) }))),
    );
  }
  crearEquipo(d: NuevoEquipo) { return this.post('/equipo/create', d); }
  editarEquipo(id: number, d: EdicionEquipo) { return this.put(`/equipo/update/${id}`, d); }
  mantenimientos() { return this.get<Mantenimiento[]>('/mantenimiento/getall'); }
  crearMantenimiento(d: NuevoMantenimiento) { return this.post('/mantenimiento/create', d); }
  planes() { return this.get<Record<string, unknown>[]>('/catalogo/tipoplan/getall').pipe(catalogo('idTipoPlan', true)); }
  metodosPago() {
    return this.get<Record<string, unknown>[]>('/catalogo/metodopago/getall').pipe(
      catalogo('idMetodoPago'), map((l) => l.map((c) => ({ ...c, nombre: nombrePropio(c.nombre) }))));
  }
  tiposEquipo() { return this.get<Record<string, unknown>[]>('/catalogo/tipoequipo/getall').pipe(catalogo('idTipoEquipo')); }
  roles() { return this.get<Record<string, unknown>[]>('/catalogo/rolempleado/getall').pipe(catalogo('idRolEmpleado')); }
  auditoria() { return this.get<Auditoria[]>('/auditoria/getall'); }
  reporteOcupacion(f: FiltroReporte) {
    return this.get<ReporteOcupacion[]>('/reporte/ocupacionsedesesion', this.filtro(f)).pipe(
      map((l) => l.map((r) => ({ ...r, idSede: r.idSede ?? 0, entrenador: r.entrenador ?? '', horaInicio: hora(r.horaInicio) }))),
    );
  }
  membresiasPorVencer(dias: number, idSede: number | null) {
    let p = new HttpParams().set('dias', dias);
    if (idSede !== null) p = p.set('idSede', idSede);
    return this.get<MembresiaPorVencer[]>('/reporte/membresiasporvencer', p).pipe(
      map((l) => l.map((r) => ({ ...r, plan: plan(r.plan) ?? r.plan, idSede: r.idSede ?? 0, sede: r.sede ?? '' }))),
    );
  }
  reporteIngresos(f: FiltroReporte) {
    return this.get<ReporteIngreso[]>('/reporte/ingresos', this.filtro(f)).pipe(map((l) => l.map((r) => ({ ...r, metodo: nombrePropio(r.metodo) }))));
  }
  reporteMantenimientos(f: FiltroReporte) { return this.get<ReporteMantenimiento[]>('/reporte/mantenimientos', this.filtro(f)); }
  rutinas() { return this.get<Rutina[]>('/rutina/getall'); }
  crearRutina(d: NuevaRutina) { return this.post('/rutina/create', d); }
  editarRutina(id: string, d: EdicionRutina) { return this.put(`/rutina/update/${id}`, d); }
  cambiarEstadoRutina(id: string, activa: boolean) { return this.put(`/rutina/updateestado/${id}`, { activa }); }
  progresos() { return this.get<ProgresoApi[]>('/progreso/getall').pipe(map((l) => l.map(progresoDesdeApi))); }
  crearProgreso({ idMiembro, ...d }: NuevoProgreso) { return this.post('/progreso/create', { idMiembro, ...progresoHaciaApi(d) }); }
  editarProgreso(id: string, d: EdicionProgreso) { return this.put(`/progreso/update/${id}`, progresoHaciaApi(d)); }
  analisisMongo(): Observable<AnalisisMongo> {
    return forkJoin({
      ejercicios: this.get<EjercicioFrecuente[]>('/reporte/ejerciciosmasasignados'),
      entrenadores: this.get<RutinasEntrenadorApi[]>('/reporte/rutinasentrenador'),
    }).pipe(
      map(({ ejercicios, entrenadores }) => ({
        // de más asignado a menos (el backend los ordena por nombre)
        ejercicios: [...ejercicios].sort((a, b) => b.rutinas - a.rutinas || a.nombre.localeCompare(b.nombre)),
        rutinasEntrenador: entrenadores.map((e): RutinasEntrenador => ({
          idEmpleado: e.id_empleado, entrenador: e.entrenador ?? `Entrenador n.º ${e.id_empleado}`, activas: e.activas, inactivas: e.inactivas,
        })),
      })),
    );
  }
}