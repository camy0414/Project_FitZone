import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, catchError, throwError } from 'rxjs';
import { NotificacionService } from './notificacion';
import { SessionStore, tokenVigente } from './sesion.store';
import { mensajeError } from './util';

/**
 * Le pone el token de la sesión a todas las peticiones al backend (Authorization: Bearer ...).
 * - Si la sesión venció (401, o 403 con el token ya expirado), la cierra y vuelve al login.
 * - Si falla una consulta (GET), muestra el motivo en un aviso: así ninguna pantalla queda
 *   cargando o vacía sin explicación. Los errores al guardar los muestra cada formulario.
 */
@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  private sesion = inject(SessionStore);
  private router = inject(Router);
  private avisos = inject(NotificacionService);

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const token = this.sesion.token;
    // si la petición ya trae su token (p. ej. /auth/me justo después del login) se respeta
    const peticion = token && !req.headers.has('Authorization')
      ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
      : req;
    return next.handle(peticion).pipe(
      catchError((e: unknown) => {
        if (e instanceof HttpErrorResponse && !req.url.includes('/auth/')) {
          const vencida = e.status === 401 || (e.status === 403 && !!this.sesion.token && !tokenVigente(this.sesion.token));
          if (vencida) {
            this.sesion.limpiar();
            this.router.navigateByUrl('/login');
            this.avisos.error('Tu sesión expiró. Vuelve a ingresar.');
          } else if (req.method === 'GET') {
            this.avisos.error(mensajeError(e));
          }
        }
        return throwError(() => e);
      }),
    );
  }
}
