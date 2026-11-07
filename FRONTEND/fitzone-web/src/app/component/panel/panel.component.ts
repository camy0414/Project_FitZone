import { ChangeDetectionStrategy, Component, input } from '@angular/core';

@Component({
  selector: 'app-panel',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './panel.component.html',
  styleUrl: './panel.component.css',
})
export class PanelComponent {
  titulo = input.required<string>();
  descripcion = input('');
  cargando = input(false);
}
