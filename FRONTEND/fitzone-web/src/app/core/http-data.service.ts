import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';
import { environment } from '../../environments/environment';
import { DataService } from './data.service';
import {
  Catalogo, Clase, Empleado, Equipo, Inscripcion, LoginRespuesta, Mantenimiento,
  Membresia, Miembro, NuevaClase, NuevaSede, NuevaSesion, NuevoEmpleado, NuevoEquipo,
  NuevoMantenimiento, NuevoMiembro, NuevoProgreso, NuevaRutina, Pago, Progreso, RenovarMembresia, Rutina, Sede, Sesion,
} from './models';

/** Consume la API REST de Spring Boot (ver README para la lista de endpoints). */
@Injectable()
export class HttpDataService extends DataService {
  private http = inject(HttpClient);
  private base = environment.apiUrl;

  private get<T>(ruta: string) { return this.http.get<T>(`${this.base}${ruta}`); }
  /** El backend responde { mensaje: '...' } en las escrituras. */
  private post(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.post<{ mensaje: string }>(`${this.base}${ruta}`, cuerpo).pipe(map((r) => r.mensaje));
  }
  private patch(ruta: string, cuerpo: unknown): Observable<string> {
    return this.http.patch<{ mensaje: string }>(`${this.base}${ruta}`, cuerpo).pipe(map((r) => r.mensaje));
  }

  login(correo: string, clave: string): Observable<LoginRespuesta> {
    return this.http.post<LoginRespuesta>(`${this.base}/auth/login`, { correo, clave });
  }
  sedes() { return this.get<Sede[]>('/sedes'); }
  empleados() { return this.get<Empleado[]>('/empleados'); }
  miembros() { return this.get<Miembro[]>('/miembros'); }
  membresias() { return this.get<Membresia[]>('/membresias'); }
  pagos() { return this.get<Pago[]>('/pagos'); }
  clases() { return this.get<Clase[]>('/clases'); }
  sesiones() { return this.get<Sesion[]>('/sesiones'); }
  equipos() { return this.get<Equipo[]>('/equipos'); }
  mantenimientos() { return this.get<Mantenimiento[]>('/mantenimientos'); }
  inscripciones(n: number) { return this.get<Inscripcion[]>(`/sesiones/${n}/inscripciones`); }
  rutinas() { return this.get<Rutina[]>('/rutinas'); }
  progresos() { return this.get<Progreso[]>('/progreso'); }

  planes() { return this.get<Catalogo[]>('/catalogos/planes'); }
  metodosPago() { return this.get<Catalogo[]>('/catalogos/metodos-pago'); }
  tiposEquipo() { return this.get<Catalogo[]>('/catalogos/tipos-equipo'); }
  roles() { return this.get<Catalogo[]>('/catalogos/roles'); }

  crearSede(d: NuevaSede) { return this.post('/sedes', d); }
  crearEmpleado(d: NuevoEmpleado) { return this.post('/empleados', d); }
  cambiarEstadoEmpleado(id: number, activo: boolean) { return this.patch(`/empleados/${id}/estado`, { activo }); }
  crearMiembro(d: NuevoMiembro) { return this.post('/miembros', d); }
  renovarMembresia(d: RenovarMembresia) { return this.post('/membresias/renovar', d); }
  crearClase(d: NuevaClase) { return this.post('/clases', d); }
  crearSesion(d: NuevaSesion) { return this.post('/sesiones', d); }
  inscribir(n: number, idMiembro: number) { return this.post(`/sesiones/${n}/inscripciones`, { idMiembro }); }
  marcarAsistencia(n: number, idMiembro: number, asistio: boolean) {
    return this.patch(`/sesiones/${n}/inscripciones/${idMiembro}`, { asistio });
  }
  crearEquipo(d: NuevoEquipo) { return this.post('/equipos', d); }
  crearMantenimiento(d: NuevoMantenimiento) { return this.post('/mantenimientos', d); }
  crearRutina(d: NuevaRutina) { return this.post('/rutinas', d); }
  cambiarEstadoRutina(id: string, activa: boolean) { return this.patch(`/rutinas/${id}/estado`, { activa }); }
  crearProgreso(d: NuevoProgreso) { return this.post('/progreso', d); }
}
