import { Injectable, signal } from '@angular/core';
import { Usuario } from '../model/usuario';

const KEY = 'fitzone.sesion';

/**
 * ¿El token sigue vigente? Lee la fecha de expiración (exp) del JWT del backend.
 * Los tokens del modo de ejemplo no son JWT y se consideran vigentes.
 */
export function tokenVigente(token: string | null): boolean {
  if (!token) return false;
  const partes = token.split('.');
  if (partes.length !== 3) return true;
  try {
    const json = atob(partes[1].replace(/-/g, '+').replace(/_/g, '/'));
    const exp = JSON.parse(json).exp as number | undefined;
    return !exp || exp * 1000 > Date.now();
  } catch {
    return false;
  }
}

/** Guarda el usuario y el token de la sesión (persiste al recargar la página). */
@Injectable({ providedIn: 'root' })
export class SessionStore {
  readonly usuario = signal<Usuario | null>(null);
  token: string | null = null;

  constructor() {
    try {
      const raw = localStorage.getItem(KEY);
      if (raw) {
        const s = JSON.parse(raw);
        // una sesión con el token vencido (1 hora en el backend) obliga a ingresar de nuevo
        if (tokenVigente(s.token)) {
          this.usuario.set(s.usuario);
          this.token = s.token;
        } else {
          localStorage.removeItem(KEY);
        }
      }
    } catch {
      /* sin almacenamiento: la sesión vive solo en memoria */
    }
  }

  guardar(usuario: Usuario, token: string) {
    this.usuario.set(usuario);
    this.token = token;
    try {
      localStorage.setItem(KEY, JSON.stringify({ usuario, token }));
    } catch {}
  }

  limpiar() {
    this.usuario.set(null);
    this.token = null;
    try {
      localStorage.removeItem(KEY);
    } catch {}
  }
}