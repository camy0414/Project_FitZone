import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { Miembro } from '../../model/miembro';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { paginar } from '../../service/paginacion';

@Component({
  selector: 'app-miembros',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './miembros.component.html',
  styleUrl: './miembros.component.css',
})
export class MiembrosComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private buscador = inject(BuscadorService);
  readonly usuario = inject(AuthService).usuario;

  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly cargando = signal(true);
  readonly lista = signal<Miembro[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.nombreCompleto} ${m.correo} ${m.sede} ${m.planActual ?? ''}`.toLowerCase().includes(t));
  });
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);
  readonly abierto = signal(false);

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
  }
  cargar() { this.data.miembros().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) }); }
  alGuardar(mensaje: string) {
    this.abierto.set(false);
    this.toast.ok(mensaje);
    this.cargar();
  }
}
