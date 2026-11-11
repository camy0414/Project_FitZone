import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { EjercicioFrecuente } from '../../model/analisis';
import { paginar } from '../../service/paginacion';

/** Ejercicios que aparecen en más rutinas activas. */
@Component({
  selector: 'app-reporte-ejercicios',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-ejercicios.component.html',
  styleUrl: './reporte-ejercicios.component.css',
})
export class ReporteEjerciciosComponent {
  readonly filas = input.required<EjercicioFrecuente[]>();
  readonly pag = paginar(this.filas);

  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.rutinas)));
  readonly masUsado = computed(() => this.filas()[0]?.nombre ?? '—');
  /** Cuántos ejercicios distintos hay de cada tipo. */
  readonly porTipo = computed(() => {
    const m = new Map<string, number>();
    for (const f of this.filas()) m.set(f.tipo, (m.get(f.tipo) ?? 0) + 1);
    return [...m.entries()].map(([tipo, cantidad]) => ({ tipo, cantidad }));
  });
}
