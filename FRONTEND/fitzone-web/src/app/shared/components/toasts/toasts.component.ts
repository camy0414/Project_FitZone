import { Component, inject } from '@angular/core';
import { ToastService } from '../../services/toast.service';

@Component({
  selector: 'app-toasts',
  templateUrl: './toasts.component.html',
})
export class ToastsComponent {
  toast = inject(ToastService);
}
