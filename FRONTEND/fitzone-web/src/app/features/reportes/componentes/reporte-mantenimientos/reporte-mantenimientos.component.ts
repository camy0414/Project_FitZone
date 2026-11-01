import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { ReporteMantenimiento } from '../../../../core/models';
import { BarraComponent } from '../../../../shared/components/barra/barra.component';
import { IndicadorComponent } from '../../../../shared/components/indicador/indicador.component';
import { VacioComponent } from '../../../../shared/components/vacio/vacio.component';
import { CopPipe } from '../../../../shared/pipes/cop.pipe';

@Component({
  selector: 'app-reporte-mantenimientos',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [BarraComponent, IndicadorComponent, VacioComponent, CopPipe],
  templateUrl: './reporte-mantenimientos.component.html',
})
export class ReporteMantenimientosComponent {
  readonly filas = input.required<ReporteMantenimiento[]>();

  readonly costo = computed(() => this.filas().reduce((a, f) => a + f.costoTotal, 0));
  readonly cantidad = computed(() => this.filas().reduce((a, f) => a + f.numMantenimientos, 0));
  readonly maximo = computed(() => Math.max(0, ...this.filas().map((f) => f.costoTotal)));
}
