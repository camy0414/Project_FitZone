import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { SessionStore } from './session.store';

/** Agrega el token a cada petición hacia la API. */
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = inject(SessionStore).token;
  return token ? next(req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })) : next(req);
};
