import { ChangeDetectionStrategy, Component, input } from '@angular/core';

@Component({
  selector: 'app-vacio',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './vacio.component.html',
  styleUrl: './vacio.component.css',
})
export class VacioComponent {
  mensaje = input('No hay registros para mostrar.');
  detalle = input('Prueba con otra búsqueda.');
}
