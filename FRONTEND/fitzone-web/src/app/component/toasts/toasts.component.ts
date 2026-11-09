import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { NotificacionService } from '../../service/notificacion';

@Component({
  selector: 'app-toasts',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './toasts.component.html',
  styleUrl: './toasts.component.css',
})
export class ToastsComponent {
  toast = inject(NotificacionService);
}
