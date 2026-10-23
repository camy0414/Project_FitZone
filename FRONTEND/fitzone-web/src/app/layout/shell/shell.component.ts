import { Component, computed, inject, signal } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { AuthService } from '../../core/auth.service';
import { MENU } from '../../core/menu';
import { ROL_LABEL } from '../../core/models';
import { AvatarComponent } from '../../shared/components/avatar/avatar.component';
import { IconComponent } from '../../shared/components/icon/icon.component';
import { ToastsComponent } from '../../shared/components/toasts/toasts.component';
import { SearchService } from '../../shared/services/search.service';

@Component({
  selector: 'app-shell',
  imports: [RouterOutlet, RouterLink, RouterLinkActive, IconComponent, AvatarComponent, ToastsComponent],
  templateUrl: './shell.component.html',
})
export class ShellComponent {
  private auth = inject(AuthService);
  readonly buscador = inject(SearchService);
  readonly usuario = this.auth.usuario;
  readonly menu = computed(() => { const u = this.usuario(); return u ? MENU[u.rol] : []; });
  readonly rolLabel = computed(() => { const u = this.usuario(); return u ? ROL_LABEL[u.rol] : ''; });
  readonly sedeLabel = computed(() => {
    const u = this.usuario();
    return !u ? '' : u.rol === 'ADMIN_SISTEMA' ? 'Todas las sedes' : u.sede;
  });
  readonly menuAbierto = signal(false);

  buscar(e: Event) {
    this.buscador.texto.set((e.target as HTMLInputElement).value);
  }
  salir() {
    this.buscador.texto.set('');
    this.auth.logout();
  }
}
