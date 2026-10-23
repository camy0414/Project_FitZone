import { Component, input } from '@angular/core';

@Component({
  selector: 'app-vacio',
  templateUrl: './vacio.component.html',
})
export class VacioComponent {
  mensaje = input('No hay registros para mostrar.');
  detalle = input('Prueba con otra búsqueda.');
}
