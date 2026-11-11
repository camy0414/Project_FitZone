import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { RutinasEntrenador } from '../../model/analisis';
import { paginar } from '../../service/paginacion';

/** Rutinas activas e inactivas que ha creado cada entrenador. */
@Component({
  selector: 'app-reporte-entrenadores',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-entrenadores.component.html',
  styleUrl: './reporte-entrenadores.component.css',
})
export class ReporteEntrenadoresComponent {
  readonly filas = input.required<RutinasEntrenador[]>();
  readonly pag = paginar(this.filas);

  readonly activas = computed(() => this.filas().reduce((a, f) => a + f.activas, 0));
  readonly inactivas = computed(() => this.filas().reduce((a, f) => a + f.inactivas, 0));
  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.activas + f.inactivas)));
}
