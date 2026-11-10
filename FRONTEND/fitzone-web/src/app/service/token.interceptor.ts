import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, catchError, throwError } from 'rxjs';
import { SessionStore } from './sesion.store';

/**
 * Le pone el token de la sesión a todas las peticiones al backend (Authorization: Bearer ...).
 * Si el backend responde 401 en cualquier petición que no sea el login (token vencido o
 * inválido), cierra la sesión y vuelve al login.
 */
@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  private sesion = inject(SessionStore);
  private router = inject(Router);

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const token = this.sesion.token;
    // si la petición ya trae su token (p. ej. /auth/me justo después del login) se respeta
    const peticion = token && !req.headers.has('Authorization')
      ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
      : req;
    return next.handle(peticion).pipe(
      catchError((e: unknown) => {
        if (e instanceof HttpErrorResponse && e.status === 401 && !req.url.endsWith('/auth/login')) {
          this.sesion.limpiar();
          this.router.navigateByUrl('/login');
        }
        return throwError(() => e);
      }),
    );
  }
}