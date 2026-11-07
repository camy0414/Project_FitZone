import { ChangeDetectionStrategy, Component, input } from '@angular/core';

/** Tarjeta pequeña con un número destacado y su etiqueta. */
@Component({
  selector: 'app-indicador',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './indicador.component.html',
  styleUrl: './indicador.component.css',
})
export class IndicadorComponent {
  readonly etiqueta = input.required<string>();
  readonly valor = input.required<string | number>();
  readonly detalle = input('');
}
