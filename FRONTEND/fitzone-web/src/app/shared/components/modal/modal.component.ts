import { Component, input, output } from '@angular/core';
import { IconComponent } from '../icon/icon.component';

@Component({
  selector: 'app-modal',
  imports: [IconComponent],
  templateUrl: './modal.component.html',
})
export class ModalComponent {
  titulo = input.required<string>();
  cerrar = output<void>();
}
