import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { AnalisisMongo } from '../../model/analisis';
import { mensajeError } from '../../service/util';

/** Análisis de rutinas y progreso físico (agregaciones sobre MongoDB). */
@Component({
  selector: 'app-analisis',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './analisis.component.html',
  styleUrl: './analisis.component.css',
})
export class AnalisisComponent implements OnInit {
  private data = inject(DataService);

  readonly cargando = signal(true);
  readonly error = signal('');
  readonly datos = signal<AnalisisMongo | null>(null);

  readonly maxEjercicio = computed(() => Math.max(0, ...(this.datos()?.ejercicios.map((e) => e.rutinas) ?? [])));
  readonly maxRutinas = computed(() => Math.max(0, ...(this.datos()?.rutinasEntrenador.map((r) => r.activas + r.inactivas) ?? [])));

  ngOnInit() {
    this.data.analisisMongo().subscribe({
      next: (d) => { this.datos.set(d); this.cargando.set(false); },
      error: (e) => { this.error.set(mensajeError(e)); this.cargando.set(false); },
    });
  }

  signo(n: number) { return n > 0 ? `+${n}` : `${n}`; }
}
