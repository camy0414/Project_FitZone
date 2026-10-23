import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DataService } from '../../core/data.service';
import { Inscripcion, Sesion } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-asistencia',
  imports: [FormsModule, PanelComponent, FilaComponent, VacioComponent, FechaPipe],
  templateUrl: './asistencia.component.html',
})
export class AsistenciaComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);

  readonly cargando = signal(true);
  readonly sesiones = signal<Sesion[]>([]);
  readonly inscritos = signal<Inscripcion[]>([]);
  readonly numero = signal(0);
  readonly sesion = computed(() => this.sesiones().find((s) => s.numeroSesion === this.numero()));
  readonly presentes = computed(() => this.inscritos().filter((i) => i.asistio).length);

  ngOnInit() {
    this.data.sesiones().subscribe((l) => {
      this.sesiones.set([...l].sort((a, b) => (b.fecha + b.horaInicio).localeCompare(a.fecha + a.horaInicio)));
      this.cargando.set(false);
    });
  }
  elegir(n: number) {
    this.numero.set(+n); this.inscritos.set([]);
    if (+n) this.data.inscripciones(+n).subscribe((l) => this.inscritos.set(l));
  }
  marcar(i: Inscripcion) {
    const nuevo = !i.asistio;
    this.data.marcarAsistencia(i.numeroSesion, i.idMiembro, nuevo).subscribe({
      next: () => this.inscritos.update((l) => l.map((x) => (x.idMiembro === i.idMiembro ? { ...x, asistio: nuevo } : x))),
      error: (e) => this.toast.error(mensajeError(e)),
    });
  }
}
