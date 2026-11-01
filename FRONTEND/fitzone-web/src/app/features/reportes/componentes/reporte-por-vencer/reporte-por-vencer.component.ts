import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { RouterLink } from '@angular/router';
import { MembresiaPorVencer } from '../../../../core/models';
import { VacioComponent } from '../../../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../../../shared/pipes/fecha.pipe';

@Component({
  selector: 'app-reporte-por-vencer',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterLink, VacioComponent, FechaPipe],
  templateUrl: './reporte-por-vencer.component.html',
})
export class ReportePorVencerComponent {
  readonly filas = input.required<MembresiaPorVencer[]>();

  urgencia(dias: number): string {
    return dias <= 3 ? 'bg-red-500/10 text-red-600' : dias <= 7 ? 'bg-amber-500/10 text-amber-700' : 'bg-sky-500/10 text-sky-600';
  }
  texto(dias: number): string {
    return dias === 0 ? 'Vence hoy' : dias === 1 ? 'Vence mañana' : `${dias} días`;
  }
}
