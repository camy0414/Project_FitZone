import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';
import { environment } from '../../environments/environment';
import { DataService } from './data.service';
import { AnalisisMongo } from '../model/analisis';
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

type Respuesta = { mensaje: string };

/** Consume la API REST de Spring Boot (ver README para la lista de endpoints). */
@Injectable()
export class HttpDataService extends DataService {
  private http = inject(HttpClient);
  private base = environment.apiUrl;

  private get<T>(ruta: string, params?: HttpParams) { return this.http.get<T>(`${this.base}${ruta}`, { params }); }
  /** El backend responde { mensaje: '...' } en las escrituras. */
  private post(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.post<Respuesta>(`${this.base}${ruta}`, cuerpo).pipe(map((r) => r.mensaje));
  }
  private put(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.put<Respuesta>(`${this.base}${ruta}`, cuerpo).pipe(map((r) => r.mensaje));
  }
  private patch(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.patch<Respuesta>(`${this.base}${ruta}`, cuerpo).pipe(map((r) => r.mensaje));
  }
  private delete(ruta: string): Observable<string> {
    return this.http.delete<Respuesta>(`${this.base}${ruta}`).pipe(map((r) => r.mensaje));
  }
  private filtro(f: FiltroReporte) {
    let p = new HttpParams().set('desde', f.desde).set('hasta', f.hasta);
    if (f.idSede !== null) p = p.set('idSede', f.idSede);
    return p;
  }

  login(correo: string, clave: string): Observable<LoginRespuesta> {
    return this.http.post<LoginRespuesta>(`${this.base}/auth/login`, { correo, clave });
  }
  sedes() { return this.get<Sede[]>('/sedes'); }
  empleados() { return this.get<Empleado[]>('/empleados'); }
  miembros() { return this.get<Miembro[]>('/miembros'); }
  miembrosCadena() { return this.get<Miembro[]>('/miembros', new HttpParams().set('alcance', 'cadena')); }
  detalleMiembro(id: number) { return this.get<MiembroDetalle>(`/miembros/${id}`); }
  membresias() { return this.get<Membresia[]>('/membresias'); }
  pagos() { return this.get<Pago[]>('/pagos'); }
  clases() { return this.get<Clase[]>('/clases'); }
  sesiones() { return this.get<Sesion[]>('/sesiones'); }
  equipos() { return this.get<Equipo[]>('/equipos'); }
  mantenimientos() { return this.get<Mantenimiento[]>('/mantenimientos'); }
  inscripciones(n: number) { return this.get<Inscripcion[]>(`/sesiones/${n}/inscripciones`); }

  planes() { return this.get<Catalogo[]>('/catalogos/planes'); }
  metodosPago() { return this.get<Catalogo[]>('/catalogos/metodos-pago'); }
  tiposEquipo() { return this.get<Catalogo[]>('/catalogos/tipos-equipo'); }
  roles() { return this.get<Catalogo[]>('/catalogos/roles'); }

  reporteIngresos(f: FiltroReporte) { return this.get<ReporteIngreso[]>('/reportes/ingresos', this.filtro(f)); }
  reporteOcupacion(f: FiltroReporte) { return this.get<ReporteOcupacion[]>('/reportes/ocupacion', this.filtro(f)); }
  membresiasPorVencer(dias: number, idSede: number | null) {
    let p = new HttpParams().set('dias', dias);
    if (idSede !== null) p = p.set('idSede', idSede);
    return this.get<MembresiaPorVencer[]>('/reportes/membresias-por-vencer', p);
  }
  reporteMantenimientos(f: FiltroReporte) { return this.get<ReporteMantenimiento[]>('/reportes/mantenimientos', this.filtro(f)); }

  crearSede(d: NuevaSede) { return this.post('/sedes', d); }
  editarSede(id: number, d: EdicionSede) { return this.put(`/sedes/${id}`, d); }
  crearEmpleado(d: NuevoEmpleado) { return this.post('/empleados', d); }
  editarEmpleado(id: number, d: EdicionEmpleado) { return this.put(`/empleados/${id}`, d); }
  cambiarEstadoEmpleado(id: number, activo: boolean) { return this.patch(`/empleados/${id}/estado`, { activo }); }
  crearMiembro(d: NuevoMiembro) { return this.post('/miembros', d); }
  editarMiembro(id: number, d: EdicionMiembro) { return this.put(`/miembros/${id}`, d); }
  renovarMembresia(d: RenovarMembresia) { return this.post('/membresias/renovar', d); }
  crearClase(d: NuevaClase) { return this.post('/clases', d); }
  editarClase(id: number, d: EdicionClase) { return this.put(`/clases/${id}`, d); }
  crearSesion(d: NuevaSesion) { return this.post('/sesiones', d); }
  inscribir(n: number, idMiembro: number) { return this.post(`/sesiones/${n}/inscripciones`, { idMiembro }); }
  marcarAsistencia(n: number, idMiembro: number, asistio: boolean) {
    return this.patch(`/sesiones/${n}/inscripciones/${idMiembro}`, { asistio });
  }
  crearEquipo(d: NuevoEquipo) { return this.post('/equipos', d); }
  editarEquipo(id: number, d: EdicionEquipo) { return this.put(`/equipos/${id}`, d); }
  crearMantenimiento(d: NuevoMantenimiento) { return this.post('/mantenimientos', d); }

  rutinas() { return this.get<Rutina[]>('/rutinas'); }
  crearRutina(d: NuevaRutina) { return this.post('/rutinas', d); }
  editarRutina(id: string, d: EdicionRutina) { return this.put(`/rutinas/${id}`, d); }
  cambiarEstadoRutina(id: string, activa: boolean) { return this.patch(`/rutinas/${id}/estado`, { activa }); }
  eliminarRutina(id: string) { return this.delete(`/rutinas/${id}`); }
  progresos() { return this.get<Progreso[]>('/progreso'); }
  crearProgreso(d: NuevoProgreso) { return this.post('/progreso', d); }
  editarProgreso(id: string, d: EdicionProgreso) { return this.put(`/progreso/${id}`, d); }
  eliminarProgreso(id: string) { return this.delete(`/progreso/${id}`); }
  analisisMongo() { return this.get<AnalisisMongo>('/rutinas/analisis'); }
}
