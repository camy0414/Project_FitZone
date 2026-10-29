import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { ReporteIngreso } from '../../../../core/models';
import { BarraComponent } from '../../../../shared/components/barra/barra.component';
import { IndicadorComponent } from '../../../../shared/components/indicador/indicador.component';
import { VacioComponent } from '../../../../shared/components/vacio/vacio.component';
import { CopPipe } from '../../../../shared/pipes/cop.pipe';

@Component({
  selector: 'app-reporte-ingresos',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [BarraComponent, IndicadorComponent, VacioComponent, CopPipe],
  templateUrl: './reporte-ingresos.component.html',
})
export class ReporteIngresosComponent {
  readonly filas = input.required<ReporteIngreso[]>();

  readonly total = computed(() => this.filas().reduce((a, f) => a + f.total, 0));
  readonly pagos = computed(() => this.filas().reduce((a, f) => a + f.numPagos, 0));
  readonly promedio = computed(() => (this.pagos() ? Math.round(this.total() / this.pagos()) : 0));
  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.total)));

  readonly porMetodo = computed(() => {
    const m = new Map<string, number>();
    for (const f of this.filas()) m.set(f.metodo, (m.get(f.metodo) ?? 0) + f.total);
    return [...m.entries()].map(([metodo, total]) => ({ metodo, total })).sort((a, b) => b.total - a.total);
  });
}
