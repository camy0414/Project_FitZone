import { Observable } from 'rxjs';
import {
  Catalogo, Clase, Empleado, Equipo, Inscripcion, LoginRespuesta, Mantenimiento,
  Membresia, Miembro, NuevaClase, NuevaSede, NuevaSesion, NuevoEmpleado, NuevoEquipo,
  NuevoMantenimiento, NuevoMiembro, NuevoProgreso, NuevaRutina, Pago, Progreso, RenovarMembresia, Rutina, Sede, Sesion,
} from './models';

/**
 * Contrato de datos de la aplicación. Tiene dos implementaciones:
 *  - MockDataService: datos de ejemplo en memoria (environment.useMock = true).
 *  - HttpDataService: API REST de Spring Boot.
 *
 * Las operaciones de escritura devuelven un mensaje de confirmación (string) y,
 * si una regla falla, el Observable emite un error cuyo `message` se muestra tal
 * cual al usuario (el backend debe devolver el mensaje del trigger/procedimiento).
 */
export abstract class DataService {
  abstract login(correo: string, clave: string): Observable<LoginRespuesta>;

  // Lecturas
  abstract sedes(): Observable<Sede[]>;
  abstract empleados(): Observable<Empleado[]>;
  abstract miembros(): Observable<Miembro[]>;
  abstract membresias(): Observable<Membresia[]>;
  abstract pagos(): Observable<Pago[]>;
  abstract clases(): Observable<Clase[]>;
  abstract sesiones(): Observable<Sesion[]>;
  abstract equipos(): Observable<Equipo[]>;
  abstract mantenimientos(): Observable<Mantenimiento[]>;
  abstract inscripciones(numeroSesion: number): Observable<Inscripcion[]>;
  // MongoDB
  abstract rutinas(): Observable<Rutina[]>;
  abstract progresos(): Observable<Progreso[]>;

  // Catálogos
  abstract planes(): Observable<Catalogo[]>;
  abstract metodosPago(): Observable<Catalogo[]>;
  abstract tiposEquipo(): Observable<Catalogo[]>;
  abstract roles(): Observable<Catalogo[]>;

  // Escrituras
  abstract crearSede(d: NuevaSede): Observable<string>;
  abstract crearEmpleado(d: NuevoEmpleado): Observable<string>;
  abstract cambiarEstadoEmpleado(idEmpleado: number, activo: boolean): Observable<string>;
  abstract crearMiembro(d: NuevoMiembro): Observable<string>;
  abstract renovarMembresia(d: RenovarMembresia): Observable<string>;
  abstract crearClase(d: NuevaClase): Observable<string>;
  abstract crearSesion(d: NuevaSesion): Observable<string>;
  abstract inscribir(numeroSesion: number, idMiembro: number): Observable<string>;
  abstract marcarAsistencia(numeroSesion: number, idMiembro: number, asistio: boolean): Observable<string>;
  abstract crearEquipo(d: NuevoEquipo): Observable<string>;
  abstract crearMantenimiento(d: NuevoMantenimiento): Observable<string>;
  abstract crearRutina(d: NuevaRutina): Observable<string>;
  abstract cambiarEstadoRutina(idRutina: string, activa: boolean): Observable<string>;
  abstract crearProgreso(d: NuevoProgreso): Observable<string>;
}
