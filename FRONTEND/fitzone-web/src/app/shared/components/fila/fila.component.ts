import { Component, input } from '@angular/core';
import { StatusPillComponent } from '../status-pill/status-pill.component';

@Component({
  selector: 'app-fila',
  imports: [StatusPillComponent],
  templateUrl: './fila.component.html',
})
export class FilaComponent {
  principal = input.required<string>();
  secundario = input('');
  meta = input('');
  estado = input('');
}
