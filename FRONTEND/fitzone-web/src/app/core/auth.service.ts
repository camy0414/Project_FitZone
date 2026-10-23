import { Injectable, computed, inject } from '@angular/core';
import { Router } from '@angular/router';
import { tap } from 'rxjs';
import { DataService } from './data.service';
import { SessionStore } from './session.store';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private data = inject(DataService);
  private store = inject(SessionStore);
  private router = inject(Router);

  readonly usuario = this.store.usuario;
  readonly autenticado = computed(() => this.store.usuario() !== null);
  readonly esAdmin = computed(() => this.store.usuario()?.rol === 'ADMIN_SISTEMA');

  login(correo: string, clave: string) {
    return this.data
      .login(correo, clave)
      .pipe(tap((r) => this.store.guardar(r.usuario, r.token)));
  }

  logout() {
    this.store.limpiar();
    this.router.navigateByUrl('/login');
  }
}
