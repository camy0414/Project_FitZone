import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { MembresiaPorVencer } from '../../model/reporte';
import { paginar } from '../../service/paginacion';

/** Membresías ACTIVA que vencen pronto: lista de llamadas para recepción. */
@Component({
  selector: 'app-reporte-por-vencer',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-por-vencer.component.html',
  styleUrl: './reporte-por-vencer.component.css',
})
export class ReportePorVencerComponent {
  readonly filas = input.required<MembresiaPorVencer[]>();
  readonly pag = paginar(this.filas);

  urgencia(dias: number): string {
    return dias <= 3 ? 'bg-red-500/10 text-red-600' : dias <= 7 ? 'bg-amber-500/10 text-amber-700' : 'bg-sky-500/10 text-sky-600';
  }
  texto(dias: number): string {
    return dias === 0 ? 'Vence hoy' : dias === 1 ? 'Vence mañana' : `${dias} días`;
  }
}
