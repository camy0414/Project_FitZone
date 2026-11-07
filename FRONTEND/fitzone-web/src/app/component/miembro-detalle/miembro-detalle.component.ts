import { ChangeDetectionStrategy, Component, OnInit, computed, inject, input, signal } from '@angular/core';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { MiembroDetalle } from '../../model/miembro';
import { NotificacionService } from '../../service/notificacion';
import { estadoInscripcion, hoyISO, mensajeError } from '../../service/util';

type Seccion = 'membresias' | 'pagos' | 'inscripciones';

/** Ficha del miembro: datos, info médica (1:1) e historial de membresías, pagos e inscripciones. */
@Component({
  selector: 'app-miembro-detalle',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './miembro-detalle.component.html',
  styleUrl: './miembro-detalle.component.css',
})
export class MiembroDetalleComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private usuario = inject(AuthService).usuario;

  /** Parámetro :id de la ruta (bindToComponentInputs en AppRoutingModule). */
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
