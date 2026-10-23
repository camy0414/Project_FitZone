import { Component, input } from '@angular/core';

/** Círculo con las iniciales del nombre. */
@Component({
  selector: 'app-avatar',
  templateUrl: './avatar.component.html',
})
export class AvatarComponent {
  nombre = input.required<string>();
  iniciales = () =>
    this.nombre().split(' ').slice(0, 2).map((p) => p[0]).join('').toUpperCase();
}
