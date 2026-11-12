import { ChangeDetectionStrategy, Component, input, output } from '@angular/core';

/** Diálogo de confirmación para acciones importantes (p. ej. desactivar un empleado). */
@Component({
  selector: 'app-confirmar',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './confirmar.component.html',
  styleUrl: './confirmar.component.css',
})
export class ConfirmarComponent {
  readonly titulo = input('¿Confirmas la acción?');
  readonly mensaje = input.required<string>();
  readonly accion = input('Confirmar');
  readonly enviando = input(false);
  readonly confirmar = output<void>();
  readonly cancelar = output<void>();
}
