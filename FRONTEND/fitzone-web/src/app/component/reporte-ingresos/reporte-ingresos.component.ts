import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { ReporteIngreso } from '../../model/reporte';

/** Ingresos por sede y método de pago (pago ⨝ metodo_pago ⨝ miembro ⨝ sede). */
@Component({
  selector: 'app-reporte-ingresos',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-ingresos.component.html',
  styleUrl: './reporte-ingresos.component.css',
})
export class ReporteIngresosComponent {
  readonly filas = input.required<ReporteIngreso[]>();

  readonly total = computed(() => this.filas().reduce((a, f) => a + f.total, 0));
  readonly pagos = computed(() => this.filas().reduce((a, f) => a + f.numPagos, 0));
  readonly promedio = computed(() => (this.pagos() ? Math.round(this.total() / this.pagos()) : 0));
  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.total)));
  /** Total por método de pago (suma de todas las sedes). */
  readonly porMetodo = computed(() => {
    const m = new Map<string, number>();
    for (const f of this.filas()) m.set(f.metodo, (m.get(f.metodo) ?? 0) + f.total);
    return [...m.entries()].map(([metodo, total]) => ({ metodo, total })).sort((a, b) => b.total - a.total);
  });
}
