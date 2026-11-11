import { Signal, computed, linkedSignal } from '@angular/core';

/** Registros por página en todas las listas. */
export const POR_PAGINA = 15;

/** Estado de la paginación de una lista (lo usa <app-paginador>). */
export interface Paginacion<T> {
  /** Registros de la página actual. */
  readonly items: Signal<T[]>;
  /** Página actual, desde 0. Vuelve a la primera cuando cambia la cantidad de registros (al buscar o filtrar). */
  readonly pagina: Signal<number>;
  readonly totalPaginas: Signal<number>;
  readonly totalRegistros: Signal<number>;
  readonly porPagina: number;
  irA(pagina: number): void;
}

/**
 * Divide una lista en páginas. Ejemplo en un componente:
 *   readonly pag = paginar(this.visibles);
 * y en la plantilla: @for (x of pag.items(); ...) y <app-paginador [pag]="pag" />
 */
export function paginar<T>(lista: Signal<T[]>, porPagina = POR_PAGINA): Paginacion<T> {
  const totalRegistros = computed(() => lista().length);
  // vuelve a la página 1 cuando cambia la cantidad de registros (búsqueda, otro filtro, otra consulta)
  const elegida = linkedSignal({ source: totalRegistros, computation: () => 0 });
  const totalPaginas = computed(() => Math.max(1, Math.ceil(totalRegistros() / porPagina)));
  const pagina = computed(() => Math.min(elegida(), totalPaginas() - 1));
  const items = computed(() => lista().slice(pagina() * porPagina, (pagina() + 1) * porPagina));
  return {
    items, pagina, totalPaginas, totalRegistros, porPagina,
    irA: (p: number) => {
      elegida(); // se lee antes para que tome en cuenta un cambio reciente de la lista
      elegida.set(Math.min(totalPaginas() - 1, Math.max(0, p)));
    },
  };
}
