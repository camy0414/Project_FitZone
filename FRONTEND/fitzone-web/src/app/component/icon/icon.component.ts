import { ChangeDetectionStrategy, Component, input } from '@angular/core';

/** Envoltorio de íconos Lucide: <app-icon name="users" cls="size-5" /> */
@Component({
  selector: 'app-icon',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  host: { style: 'display: contents' },
  templateUrl: './icon.component.html',
  styleUrl: './icon.component.css',
})
export class IconComponent {
  name = input.required<string>();
  cls = input('size-5');
  sw = input<number>(2);
}
