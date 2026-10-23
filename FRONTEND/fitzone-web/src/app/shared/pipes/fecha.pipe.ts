import { Pipe, PipeTransform } from '@angular/core';

/** 2026-10-20 -> 20 oct 2026 (sin desfase de zona horaria) */
@Pipe({ name: 'fecha' })
export class FechaPipe implements PipeTransform {
  transform(v: string, conAnio = false): string {
    const [a, m, d] = v.split('-').map(Number);
    return new Intl.DateTimeFormat('es-CO', {
      day: 'numeric', month: 'short', ...(conAnio ? { year: 'numeric' } : {}),
    }).format(new Date(a, m - 1, d));
  }
}
