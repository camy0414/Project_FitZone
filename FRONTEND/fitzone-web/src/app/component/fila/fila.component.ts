import { ChangeDetectionStrategy, Component, input } from '@angular/core';

@Component({
  selector: 'app-fila',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './fila.component.html',
  styleUrl: './fila.component.css',
})
export class FilaComponent {
  principal = input.required<string>();
  secundario = input('');
  meta = input('');
  estado = input('');
}
