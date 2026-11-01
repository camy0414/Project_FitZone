import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DataService } from '../../core/data.service';
import { Inscripcion, Miembro, Sesion } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { ToastService } from '../../shared/services/toast.service';
import { estadoInscripcion, hoyISO, mensajeError, porFechaHora } from '../../shared/utils/util';

@Component({
  selector: 'app-inscripciones',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, PanelComponent, FilaComponent, VacioComponent, FechaPipe],
  templateUrl: './inscripciones.component.html',
})
export class InscripcionesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);

  readonly estado = estadoInscripcion;
  readonly cargando = signal(true);
  readonly sesiones = signal<Sesion[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly inscritos = signal<Inscripcion[]>([]);
  readonly numero = signal(0);
  readonly idMiembro = signal(0);
  readonly enviando = signal(false);
  readonly error = signal('');

  readonly proximas = computed(() => this.sesiones().filter((s) => s.fecha >= hoyISO()));
  readonly sesion = computed(() => this.sesiones().find((s) => s.numeroSesion === this.numero()));
  readonly llena = computed(() => { const s = this.sesion(); return !!s && s.inscritos >= s.cupoMaximo; });

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
    this.data.sesiones().subscribe((l) => { this.sesiones.set(porFechaHora(l)); this.cargando.set(false); });
  }
  elegir(n: number) {
    this.numero.set(+n); this.idMiembro.set(0); this.error.set('');
    this.inscritos.set([]);
    if (+n) this.recargar();
  }
  private recargar() { this.data.inscripciones(this.numero()).subscribe((l) => this.inscritos.set(l)); }
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
