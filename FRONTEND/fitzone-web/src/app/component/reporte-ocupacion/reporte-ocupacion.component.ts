import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';
import { ReporteOcupacion } from '../../model/reporte';
import { hoyISO } from '../../service/util';
import { paginar } from '../../service/paginacion';

/** Ocupación (inscritos / cupo) y asistencia (asistentes / inscritos) por sesión. */
@Component({
  selector: 'app-reporte-ocupacion',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reporte-ocupacion.component.html',
  styleUrl: './reporte-ocupacion.component.css',
})
export class ReporteOcupacionComponent {
  readonly filas = input.required<ReporteOcupacion[]>();
  readonly pag = paginar(this.filas);
  readonly hoy = hoyISO();

  readonly ocupacion = computed(() => {
    const cupo = this.filas().reduce((a, f) => a + f.cupoMaximo, 0);
    return cupo ? Math.round((this.filas().reduce((a, f) => a + f.inscritos, 0) * 100) / cupo) : 0;
  });
  /** La asistencia solo cuenta en sesiones que ya ocurrieron. */
  readonly asistencia = computed(() => {
    const pasadas = this.filas().filter((f) => f.fecha <= this.hoy);
    const ins = pasadas.reduce((a, f) => a + f.inscritos, 0);
    return ins ? Math.round((pasadas.reduce((a, f) => a + f.asistentes, 0) * 100) / ins) : null;
  });
  readonly llenas = computed(() => this.filas().filter((f) => f.inscritos >= f.cupoMaximo).length);

  pctAsistencia(f: ReporteOcupacion): string {
    if (f.fecha > this.hoy) return 'Próxima';
    return f.inscritos ? `${Math.round((f.asistentes * 100) / f.inscritos)} %` : '—';
  }
}
