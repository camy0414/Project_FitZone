import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { Inscripcion, Sesion } from '../../model/sesion';
import { NotificacionService } from '../../service/notificacion';
import { estadoInscripcion, hoyISO, mensajeError, porFechaHora } from '../../service/util';

@Component({
  selector: 'app-asistencia',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './asistencia.component.html',
  styleUrl: './asistencia.component.css',
})
export class AsistenciaComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);

  readonly estado = estadoInscripcion;
  readonly cargando = signal(true);
  readonly sesiones = signal<Sesion[]>([]);
  readonly inscritos = signal<Inscripcion[]>([]);
  readonly numero = signal(0);
  /** La asistencia se registra desde el día de la sesión (las futuras no aparecen). */
  readonly disponibles = computed(() => this.sesiones().filter((s) => s.fecha <= hoyISO()));
  readonly sesion = computed(() => this.sesiones().find((s) => s.numeroSesion === this.numero()));
  readonly presentes = computed(() => this.inscritos().filter((i) => i.asistio === true).length);
  readonly pendientes = computed(() => this.inscritos().filter((i) => i.asistio === null).length);

  ngOnInit() {
    this.data.sesiones().subscribe((l) => { this.sesiones.set(porFechaHora(l, true)); this.cargando.set(false); });
  }
  elegir(n: number) {
    this.numero.set(+n); this.inscritos.set([]);
    if (+n) this.data.inscripciones(+n).subscribe((l) => this.inscritos.set(l));
  }
  marcar(i: Inscripcion, asistio: boolean) {
    if (i.asistio === asistio) return;
    this.data.marcarAsistencia(i.numeroSesion, i.idMiembro, asistio).subscribe({
      next: () => this.inscritos.update((l) => l.map((x) => (x.idMiembro === i.idMiembro ? { ...x, asistio } : x))),
      error: (e) => this.toast.error(mensajeError(e)),
    });
  }
}
