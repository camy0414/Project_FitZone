import { Injectable, signal } from '@angular/core';

export interface Aviso { id: number; texto: string; tipo: 'ok' | 'error' }

/** Avisos temporales (confirmaciones de las operaciones). */
@Injectable({ providedIn: 'root' })
export class ToastService {
  readonly avisos = signal<Aviso[]>([]);
  private n = 0;

  ok(texto: string) { this.agregar(texto, 'ok'); }
  error(texto: string) { this.agregar(texto, 'error'); }

  private agregar(texto: string, tipo: Aviso['tipo']) {
    const id = ++this.n;
    this.avisos.update((l) => [...l, { id, texto, tipo }]);
    setTimeout(() => this.avisos.update((l) => l.filter((a) => a.id !== id)), 4500);
  }
}
