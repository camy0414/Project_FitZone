import { signal } from '@angular/core';
import { paginar } from './paginacion';

describe('paginar', () => {
  const lista = signal(Array.from({ length: 40 }, (_, i) => i + 1));

  it('muestra 15 registros por página', () => {
    const pag = paginar(lista);
    expect(pag.totalPaginas()).toBe(3);
    expect(pag.items()).toEqual(Array.from({ length: 15 }, (_, i) => i + 1));
  });

  it('no se sale de las páginas que existen', () => {
    const pag = paginar(lista);
    pag.irA(9);
    expect(pag.pagina()).toBe(2);
    expect(pag.items()).toEqual([31, 32, 33, 34, 35, 36, 37, 38, 39, 40]);
    pag.irA(-1);
    expect(pag.pagina()).toBe(0);
  });

  it('si la lista cambia (búsqueda), vuelve a la primera página', () => {
    const filtrada = signal(Array.from({ length: 40 }, (_, i) => i));
    const pag = paginar(filtrada);
    pag.irA(2);
    filtrada.set([1, 2, 3]);
    expect(pag.pagina()).toBe(0);
    expect(pag.items()).toEqual([1, 2, 3]);
  });
});
