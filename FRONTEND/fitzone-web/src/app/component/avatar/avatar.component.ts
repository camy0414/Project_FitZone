import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';

/** Círculo con las iniciales del nombre. */
@Component({
  selector: 'app-avatar',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './avatar.component.html',
  styleUrl: './avatar.component.css',
})
export class AvatarComponent {
  readonly nombre = input.required<string>();
  readonly iniciales = computed(() =>
    this.nombre().split(' ').filter(Boolean).slice(0, 2).map((p) => p[0]).join('').toUpperCase());
}
