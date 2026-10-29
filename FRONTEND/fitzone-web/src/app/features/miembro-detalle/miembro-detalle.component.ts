import { ChangeDetectionStrategy, Component, OnInit, computed, inject, input, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { MiembroDetalle } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { IndicadorComponent } from '../../shared/components/indicador/indicador.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { StatusPillComponent } from '../../shared/components/status-pill/status-pill.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { CopPipe } from '../../shared/pipes/cop.pipe';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { ToastService } from '../../shared/services/toast.service';
import { estadoInscripcion, hoyISO, mensajeError } from '../../shared/utils/util';
import { MiembroFormComponent } from '../miembros/miembro-form/miembro-form.component';

type Seccion = 'membresias' | 'pagos' | 'inscripciones';

@Component({
  selector: 'app-miembro-detalle',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [
    RouterLink, PanelComponent, FilaComponent, IndicadorComponent, StatusPillComponent, VacioComponent,
    CopPipe, FechaPipe, MiembroFormComponent,
  ],
  templateUrl: './miembro-detalle.component.html',
})
export class MiembroDetalleComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private usuario = inject(AuthService).usuario;

  readonly id = input.required<string>();

  readonly puedeEditar = computed(() => ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly cargando = signal(true);
  readonly error = signal('');
  readonly detalle = signal<MiembroDetalle | null>(null);
  readonly secciones: { id: Seccion; etiqueta: string }[] = [
    { id: 'membresias', etiqueta: 'Membresías' }, { id: 'pagos', etiqueta: 'Pagos' }, { id: 'inscripciones', etiqueta: 'Clases' },
  ];
  readonly seccion = signal<Seccion>('membresias');
  readonly editando = signal(false);
  readonly estado = estadoInscripcion;

  readonly totalPagado = computed(() => this.detalle()?.pagos.reduce((a, p) => a + p.monto, 0) ?? 0);
  readonly asistencia = computed(() => {
    const pasadas = this.detalle()?.inscripciones.filter((i) => i.fecha <= hoyISO() && i.asistio !== null) ?? [];
    return pasadas.length ? Math.round((pasadas.filter((i) => i.asistio).length * 100) / pasadas.length) : null;
  });
  readonly membresiaActiva = computed(() => this.detalle()?.membresias.find((m) => m.estado === 'ACTIVA') ?? null);

  ngOnInit() { this.cargar(); }

  cargar() {
    this.data.detalleMiembro(+this.id()).subscribe({
      next: (d) => { this.detalle.set(d); this.cargando.set(false); },
      error: (e) => { this.error.set(mensajeError(e)); this.cargando.set(false); },
    });
  }
  alGuardar(mensaje: string) {
    this.editando.set(false);
    this.toast.ok(mensaje);
    this.cargar();
  }
}
