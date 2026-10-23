import { Injectable, signal } from '@angular/core';

/** Texto de la barra de búsqueda superior; lo usan las listas de cada módulo. */
@Injectable({ providedIn: 'root' })
export class SearchService {
  readonly texto = signal('');
}
