import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { ReporteMantenimiento } from '../../model/reporte';

/** Costo de mantenimiento por sede y tipo de equipo. */
@Component({
  selector: 'app-reporte-mantenimientos',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-mantenimientos.component.html',
  styleUrl: './reporte-mantenimientos.component.css',
})
export class ReporteMantenimientosComponent {
  readonly filas = input.required<ReporteMantenimiento[]>();

  readonly costo = computed(() => this.filas().reduce((a, f) => a + f.costoTotal, 0));
  readonly cantidad = computed(() => this.filas().reduce((a, f) => a + f.numMantenimientos, 0));
  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.costoTotal)));
}
