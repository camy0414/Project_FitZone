import { ChangeDetectionStrategy, Component, ElementRef, computed, inject, input } from '@angular/core';
import { Paginacion } from '../../service/paginacion';

/**
 * Controles de paginación al pie de una lista: «Mostrando 1–15 de 194», anterior / siguiente
 * y los números de página. Al cambiar de página sube al inicio de la lista.
 */
@Component({
  selector: 'app-paginador',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './paginador.component.html',
  styleUrl: './paginador.component.css',
})
export class PaginadorComponent {
  private host = inject(ElementRef<HTMLElement>);
  readonly pag = input.required<Paginacion<unknown>>();

  readonly desde = computed(() => (this.pag().totalRegistros() ? this.pag().pagina() * this.pag().porPagina + 1 : 0));
  readonly hasta = computed(() => Math.min((this.pag().pagina() + 1) * this.pag().porPagina, this.pag().totalRegistros()));

  /** Números de página a mostrar: la primera, la última y las vecinas de la actual (con «…» entre medio). */
  readonly numeros = computed<(number | null)[]>(() => {
    const total = this.pag().totalPaginas(), actual = this.pag().pagina();
    const set = new Set([0, total - 1, actual - 1, actual, actual + 1].filter((p) => p >= 0 && p < total));
    const orden = [...set].sort((a, b) => a - b);
    const res: (number | null)[] = [];
    orden.forEach((p, i) => { if (i && p - orden[i - 1] > 1) res.push(null); res.push(p); });
    return res;
  });

  ir(p: number) {
    this.pag().irA(p);
    // vuelve al inicio del panel para no quedar al final de la página nueva
    this.host.nativeElement.closest('app-panel')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}
