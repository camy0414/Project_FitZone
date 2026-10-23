import { Component, input } from '@angular/core';

@Component({
  selector: 'app-panel',
  templateUrl: './panel.component.html',
})
export class PanelComponent {
  titulo = input.required<string>();
  descripcion = input('');
  cargando = input(false);
}
