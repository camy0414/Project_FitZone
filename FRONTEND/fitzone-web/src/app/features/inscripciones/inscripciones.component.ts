import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DataService } from '../../core/data.service';
import { Inscripcion, Miembro, Sesion } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-inscripciones',
  imports: [FormsModule, PanelComponent, FilaComponent, VacioComponent, FechaPipe],
  templateUrl: './inscripciones.component.html',
})
export class InscripcionesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);

  readonly cargando = signal(true);
  readonly sesiones = signal<Sesion[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly inscritos = signal<Inscripcion[]>([]);
  readonly numero = signal(0);
  readonly idMiembro = signal(0);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly sesion = computed(() => this.sesiones().find((s) => s.numeroSesion === this.numero()));
  /** Miembros de la misma sede de la sesión que aún no están inscritos. */
  readonly candidatos = computed(() => {
    const s = this.sesion();
    if (!s) return [];
    const ya = new Set(this.inscritos().map((i) => i.idMiembro));
    return this.miembros().filter((m) => m.idSede === s.idSede && !ya.has(m.idMiembro));
  });

  ngOnInit() {
    this.data.sesiones().subscribe((l) => {
      this.sesiones.set([...l].sort((a, b) => (b.fecha + b.horaInicio).localeCompare(a.fecha + a.horaInicio)));
      this.cargando.set(false);
    });
    this.data.miembros().subscribe((l) => this.miembros.set(l));
  }
  elegir(n: number) {
    this.numero.set(+n); this.idMiembro.set(0); this.error.set('');
    this.inscritos.set([]);
    if (+n) this.recargar();
  }
  recargar() { this.data.inscripciones(this.numero()).subscribe((l) => this.inscritos.set(l)); }
  inscribir() {
    if (!this.numero() || !this.idMiembro()) { this.error.set('Selecciona una sesión y un miembro.'); return; }
    this.enviando.set(true); this.error.set('');
    this.data.inscribir(this.numero(), +this.idMiembro()).subscribe({
      next: (m) => {
        this.enviando.set(false); this.idMiembro.set(0); this.toast.ok(m);
        this.recargar();
        this.data.sesiones().subscribe((l) => this.sesiones.set([...l].sort((a, b) => (b.fecha + b.horaInicio).localeCompare(a.fecha + a.horaInicio))));
      },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
