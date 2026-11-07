import { ChangeDetectionStrategy, Component, computed, inject, input, output } from '@angular/core';
import { AuthService } from '../../service/auth';
import { BuscadorService } from '../../service/buscador';
import { MENU } from '../../service/menu';
import { ROL_LABEL } from '../../model/usuario';

/** Barra lateral: marca, usuario en sesión, menú según el rol y cerrar sesión. */
@Component({
  selector: 'app-sidebar',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  // sin caja propia: así el header "sticky" y el aside "fixed" se ubican respecto al layout
  host: { style: 'display: contents' },
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent {
  private auth = inject(AuthService);
  private buscador = inject(BuscadorService);

  /** Visible en celular cuando el usuario abre el menú (en escritorio siempre se ve). */
  readonly abierto = input(false);
  readonly cerrar = output<void>();

  readonly usuario = this.auth.usuario;
  readonly menu = computed(() => { const u = this.usuario(); return u ? MENU[u.rol] : []; });
  readonly rolLabel = computed(() => { const u = this.usuario(); return u ? ROL_LABEL[u.rol] : ''; });
  readonly sedeLabel = computed(() => {
    const u = this.usuario();
    return !u ? '' : u.rol === 'ADMIN_SISTEMA' ? 'Todas las sedes' : u.sede;
  });

  salir() {
    this.buscador.texto.set('');
    this.auth.logout();
  }
}
