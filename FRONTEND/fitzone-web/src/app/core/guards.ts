import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from './auth.service';
import { RolNombre } from './models';
import { primeraRuta } from './menu';

export const authGuard: CanActivateFn = () => {
  const auth = inject(AuthService);
  return auth.autenticado() ? true : inject(Router).createUrlTree(['/login']);
};

export const loginGuard: CanActivateFn = () => {
  const auth = inject(AuthService);
  const u = auth.usuario();
  return u ? inject(Router).createUrlTree([primeraRuta(u.rol)]) : true;
};

/** Restringe una ruta a los roles indicados en route.data['roles']. */
export const roleGuard: CanActivateFn = (route) => {
  const auth = inject(AuthService);
  const roles = route.data['roles'] as RolNombre[] | undefined;
  const u = auth.usuario();
  if (!u) return inject(Router).createUrlTree(['/login']);
  if (!roles || roles.includes(u.rol)) return true;
  return inject(Router).createUrlTree([primeraRuta(u.rol)]);
};
