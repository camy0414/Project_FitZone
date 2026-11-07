import { ChangeDetectionStrategy, Component, signal } from '@angular/core';

/**
 * Estructura de las pantallas internas: barra lateral (sidebar), barra superior (navbar)
 * y el contenido de la ruta activa. El login queda por fuera.
 */
@Component({
  selector: 'app-layout',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './layout.component.html',
  styleUrl: './layout.component.css',
})
export class LayoutComponent {
  /** Menú lateral abierto en pantallas pequeñas. */
  readonly menuAbierto = signal(false);
}
