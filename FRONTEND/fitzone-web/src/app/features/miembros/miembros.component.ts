import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Miembro } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { MiembroFormComponent } from './miembro-form/miembro-form.component';

@Component({
  selector: 'app-miembros',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterLink, PanelComponent, FilaComponent, VacioComponent, FechaPipe, MiembroFormComponent],
  templateUrl: './miembros.component.html',
})
export class MiembrosComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private buscador = inject(SearchService);
  readonly usuario = inject(AuthService).usuario;

  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly cargando = signal(true);
  readonly lista = signal<Miembro[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.nombreCompleto} ${m.correo} ${m.sede} ${m.planActual ?? ''}`.toLowerCase().includes(t));
  });
  readonly abierto = signal(false);

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
  }
  cargar() { this.data.miembros().subscribe((l) => { this.lista.set(l); this.cargando.set(false); }); }
  alGuardar(mensaje: string) {
    this.abierto.set(false);
    this.toast.ok(mensaje);
    this.cargar();
  }
}
