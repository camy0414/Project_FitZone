import { Observable } from 'rxjs';
import {
  AnalisisMongo, Catalogo, Clase, EdicionClase, EdicionEmpleado, EdicionEquipo, EdicionMiembro,
  EdicionProgreso, EdicionRutina, EdicionSede, Empleado, Equipo, FiltroReporte, Inscripcion,
  LoginRespuesta, Mantenimiento, Membresia, MembresiaPorVencer, Miembro, MiembroDetalle, NuevaClase,
  NuevaRutina, NuevaSede, NuevaSesion, NuevoEmpleado, NuevoEquipo, NuevoMantenimiento, NuevoMiembro,
  NuevoProgreso, Pago, Progreso, RenovarMembresia, ReporteIngreso, ReporteMantenimiento,
  ReporteOcupacion, Rutina, Sede, Sesion,
} from './models';

/**
 * Contrato de datos de la aplicación. Tiene dos implementaciones:
 *  - MockDataService: datos de ejemplo en memoria (environment.useMock = true).
 *  - HttpDataService: API REST de Spring Boot.
 *
 * Las operaciones de escritura devuelven un mensaje de confirmación (string) y,
 * si una regla falla, el Observable emite un error cuyo `message` se muestra tal
 * cual al usuario (el backend debe devolver el mensaje de la regla que falló).
 */
export abstract class DataService {
  abstract login(correo: string, clave: string): Observable<LoginRespuesta>;

  // Lecturas
  abstract sedes(): Observable<Sede[]>;
  abstract empleados(): Observable<Empleado[]>;
  abstract miembros(): Observable<Miembro[]>;
  /**
   * Miembros de todas las sedes. Lo usa recepción al inscribir, porque un miembro
   * puede asistir a clases de cualquier sede de la cadena (supuesto 5).
   */
  abstract miembrosCadena(): Observable<Miembro[]>;
  abstract detalleMiembro(idMiembro: number): Observable<MiembroDetalle>;
  abstract membresias(): Observable<Membresia[]>;
  abstract pagos(): Observable<Pago[]>;
  abstract clases(): Observable<Clase[]>;
  abstract sesiones(): Observable<Sesion[]>;
  abstract equipos(): Observable<Equipo[]>;
  abstract mantenimientos(): Observable<Mantenimiento[]>;
  abstract inscripciones(numeroSesion: number): Observable<Inscripcion[]>;

  // Catálogos
  abstract planes(): Observable<Catalogo[]>;
  abstract metodosPago(): Observable<Catalogo[]>;
  abstract tiposEquipo(): Observable<Catalogo[]>;
  abstract roles(): Observable<Catalogo[]>;

  // Reportes
  abstract reporteIngresos(f: FiltroReporte): Observable<ReporteIngreso[]>;
  abstract reporteOcupacion(f: FiltroReporte): Observable<ReporteOcupacion[]>;
  abstract membresiasPorVencer(dias: number, idSede: number | null): Observable<MembresiaPorVencer[]>;
  abstract reporteMantenimientos(f: FiltroReporte): Observable<ReporteMantenimiento[]>;

  // Escrituras
  abstract crearSede(d: NuevaSede): Observable<string>;
  abstract editarSede(idSede: number, d: EdicionSede): Observable<string>;
  abstract crearEmpleado(d: NuevoEmpleado): Observable<string>;
  abstract editarEmpleado(idEmpleado: number, d: EdicionEmpleado): Observable<string>;
  abstract cambiarEstadoEmpleado(idEmpleado: number, activo: boolean): Observable<string>;
  abstract crearMiembro(d: NuevoMiembro): Observable<string>;
  abstract editarMiembro(idMiembro: number, d: EdicionMiembro): Observable<string>;
  abstract renovarMembresia(d: RenovarMembresia): Observable<string>;
  abstract crearClase(d: NuevaClase): Observable<string>;
  abstract editarClase(idClase: number, d: EdicionClase): Observable<string>;
  abstract crearSesion(d: NuevaSesion): Observable<string>;
  abstract inscribir(numeroSesion: number, idMiembro: number): Observable<string>;
  abstract marcarAsistencia(numeroSesion: number, idMiembro: number, asistio: boolean): Observable<string>;
  abstract crearEquipo(d: NuevoEquipo): Observable<string>;
  abstract editarEquipo(idEquipo: number, d: EdicionEquipo): Observable<string>;
  abstract crearMantenimiento(d: NuevoMantenimiento): Observable<string>;

  // MongoDB (fitzone_nosql): CRUD de rutinas y progreso + agregaciones
  abstract rutinas(): Observable<Rutina[]>;
  abstract crearRutina(d: NuevaRutina): Observable<string>;
  abstract editarRutina(idRutina: string, d: EdicionRutina): Observable<string>;
  abstract cambiarEstadoRutina(idRutina: string, activa: boolean): Observable<string>;
  abstract eliminarRutina(idRutina: string): Observable<string>;
  abstract progresos(): Observable<Progreso[]>;
  abstract crearProgreso(d: NuevoProgreso): Observable<string>;
  abstract editarProgreso(idProgreso: string, d: EdicionProgreso): Observable<string>;
  abstract eliminarProgreso(idProgreso: string): Observable<string>;
  abstract analisisMongo(): Observable<AnalisisMongo>;
}
