import { Pipe, PipeTransform } from '@angular/core';

/** 90000 -> $ 90.000 */
@Pipe({ name: 'cop' })
export class CopPipe implements PipeTransform {
  transform(v: number): string {
    return new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', maximumFractionDigits: 0 }).format(v);
  }
}
