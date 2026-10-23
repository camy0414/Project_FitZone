import { Injectable, signal } from '@angular/core';
import { Usuario } from './models';

const KEY = 'fitzone.sesion';

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
        this.usuario.set(s.usuario);
        this.token = s.token;
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
