import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { SessionStore } from './sesion.store';

/** Le pone el token de la sesión a todas las peticiones al backend (Authorization: Bearer ...). */
@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  private sesion = inject(SessionStore);

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const token = this.sesion.token;
    return next.handle(token ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } }) : req);
  }
}
