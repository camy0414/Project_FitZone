import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { Miembro } from '../../model/miembro';
import { Inscripcion, Sesion } from '../../model/sesion';
import { NotificacionService } from '../../service/notificacion';
import { estadoInscripcion, mensajeError, porFechaHora } from '../../service/util';
import { sesionIniciada } from '../../service/validaciones';

@Component({
  selector: 'app-inscripciones',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './inscripciones.component.html',
  styleUrl: './inscripciones.component.css',
})
export class InscripcionesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);

  readonly estado = estadoInscripcion;
  readonly cargando = signal(true);
  readonly sesiones = signal<Sesion[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly inscritos = signal<Inscripcion[]>([]);
  readonly numero = signal(0);
  readonly idMiembro = signal(0);
  readonly enviando = signal(false);
  readonly error = signal('');

  /** Solo se inscribe en sesiones que aún no han empezado (regla del trigger de inscripción). */
  readonly proximas = computed(() => this.sesiones().filter((s) => !sesionIniciada(s.fecha, s.horaInicio)));
  readonly sesion = computed(() => this.sesiones().find((s) => s.numeroSesion === this.numero()));
  readonly llena = computed(() => { const s = this.sesion(); return !!s && s.inscritos >= s.cupoMaximo; });
  /**
   * Miembros de cualquier sede que aún no están inscritos: un miembro se inscribe en
   * una sede pero puede asistir a clases de toda la cadena (supuesto 5).
   */
  readonly candidatos = computed(() => {
    if (!this.sesion()) return [];
    const ya = new Set(this.inscritos().map((i) => i.idMiembro));
    return this.miembros().filter((m) => !ya.has(m.idMiembro));
  });

  ngOnInit() {
    this.cargarSesiones();
    this.data.miembrosCadena().subscribe((l) =>
      this.miembros.set([...l].sort((a, b) => a.nombreCompleto.localeCompare(b.nombreCompleto))));
  }
  private cargarSesiones() {
    this.data.sesiones().subscribe({ next: (l) => { this.sesiones.set(porFechaHora(l)); this.cargando.set(false); }, error: () => this.cargando.set(false) });
  }
  elegir(n: number) {
    this.numero.set(+n); this.idMiembro.set(0); this.error.set('');
    this.inscritos.set([]);
    if (+n) this.recargar();
  }
  private recargar() {
    const s = this.sesion();
    // la sesión elegida aún no empieza: sus inscritos se muestran como «inscrito»
    this.data.inscripciones(this.numero()).subscribe((l) =>
      this.inscritos.set(l.map((i) => ({ ...i, fecha: i.fecha ?? s?.fecha, horaInicio: i.horaInicio ?? s?.horaInicio }))));
  }
  inscribir() {
    if (!this.numero() || !this.idMiembro()) { this.error.set('Selecciona una sesión y un miembro.'); return; }
    this.enviando.set(true); this.error.set('');
    this.data.inscribir(this.numero(), this.idMiembro()).subscribe({
      next: (m) => {
        this.enviando.set(false); this.idMiembro.set(0); this.toast.ok(m);
        this.recargar();
        this.cargarSesiones();
      },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
