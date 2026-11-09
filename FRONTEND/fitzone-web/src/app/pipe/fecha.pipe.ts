import { Pipe, PipeTransform } from '@angular/core';

/** 2026-10-20 -> 20 oct (o 20 oct 2026 con conAnio), sin desfase de zona horaria. Vacío si no hay fecha. */
@Pipe({ name: 'fecha', standalone: false })
export class FechaPipe implements PipeTransform {
  private static readonly corta = new Intl.DateTimeFormat('es-CO', { day: 'numeric', month: 'short' });
  private static readonly larga = new Intl.DateTimeFormat('es-CO', { day: 'numeric', month: 'short', year: 'numeric' });

  transform(v: string | null | undefined, conAnio = false): string {
    if (!v) return '';
    const [a, m, d] = v.split('-').map(Number);
    return (conAnio ? FechaPipe.larga : FechaPipe.corta).format(new Date(a, m - 1, d));
  }
}
