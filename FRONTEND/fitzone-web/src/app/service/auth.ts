import { HttpClient } from '@angular/common/http';
import { Injectable, computed, inject } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, map, switchMap, tap } from 'rxjs';
import { environment } from '../../environments/environment';
import { LoginRespuesta, RolNombre, Usuario } from '../model/usuario';
import { DataService } from './data.service';
import { SessionStore } from './sesion.store';

/** El login va al backend si está activado loginReal o si las pantallas ya usan la API. */
const LOGIN_REAL = environment.loginReal || !environment.useMock;

/** Respuesta de POST /auth/login en el backend. */
interface RespuestaLoginApi { token: string; rol: string }

/** Respuesta de GET /auth/me en el backend. */
interface UsuarioApi {
  idEmpleado: number;
  nombreCompleto: string;
  correo: string;
  rol: string;
  idSede: number;
  sede: string;
}

/** Convierte la respuesta de /auth/me al usuario que guarda la sesión. */
const aUsuario = (u: UsuarioApi): Usuario => ({
  idEmpleado: u.idEmpleado,
  nombre: u.nombreCompleto,
  correo: u.correo,
  rol: u.rol.trim().toUpperCase() as RolNombre,
  idSede: u.idSede,
  sede: u.sede,
});

@Injectable({ providedIn: 'root' })
export class AuthService {
  private data = inject(DataService);
  private http = inject(HttpClient);
  private store = inject(SessionStore);
  private router = inject(Router);

  readonly usuario = this.store.usuario;
  readonly autenticado = computed(() => this.store.usuario() !== null);
  readonly esAdmin = computed(() => this.store.usuario()?.rol === 'ADMIN_SISTEMA');

  readonly loginReal = LOGIN_REAL;

  /**
   * Inicia sesión.
   * Con el backend son dos pasos:
   *  1. POST {apiUrl}/auth/login  { correo, clave }  ->  { token, rol }
   *  2. GET  {apiUrl}/auth/me     (con ese token)    ->  { idEmpleado, nombreCompleto, correo, rol, idSede, sede }
   */
  login(correo: string, clave: string): Observable<LoginRespuesta> {
    const peticion = LOGIN_REAL ? this.loginBackend(correo, clave) : this.data.login(correo, clave);
    return peticion.pipe(tap((r) => this.store.guardar(r.usuario, r.token)));
  }

  private loginBackend(correo: string, clave: string): Observable<LoginRespuesta> {
    const api = environment.apiUrl;
    return this.http
      .post<RespuestaLoginApi>(`${api}/auth/login`, { correo: correo.trim().toLowerCase(), clave })
      .pipe(
        switchMap(({ token }) =>
          // la sesión aún no tiene el token, así que se envía a mano en esta petición
          this.http
            .get<UsuarioApi>(`${api}/auth/me`, { headers: { Authorization: `Bearer ${token}` } })
            .pipe(map((u) => ({ token, usuario: aUsuario(u) }))),
        ),
      );
  }

  logout() {
    this.store.limpiar();
    this.router.navigateByUrl('/login');
  }
}