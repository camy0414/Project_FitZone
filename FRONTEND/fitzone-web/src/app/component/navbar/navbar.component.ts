import { ChangeDetectionStrategy, Component, computed, inject, output } from '@angular/core';
import { AuthService } from '../../service/auth';
import { BuscadorService } from '../../service/buscador';

/** Barra superior: botón de menú (celular), buscador del módulo y sede activa. */
@Component({
  selector: 'app-navbar',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  // sin caja propia: así el header "sticky" y el aside "fixed" se ubican respecto al layout
  host: { style: 'display: contents' },
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class NavbarComponent {
  private auth = inject(AuthService);
  readonly buscador = inject(BuscadorService);
  readonly abrirMenu = output<void>();

  readonly sedeLabel = computed(() => {
    const u = this.auth.usuario();
    return !u ? '' : u.rol === 'ADMIN_SISTEMA' ? 'Todas las sedes' : u.sede;
  });

  /** Fecha de hoy, por ejemplo «martes, 11 de noviembre». */
  readonly hoy = new Intl.DateTimeFormat('es-CO', { weekday: 'long', day: 'numeric', month: 'long' }).format(new Date());

  buscar(e: Event) {
    this.buscador.texto.set((e.target as HTMLInputElement).value);
  }
}
