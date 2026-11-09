import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';

/** Barra horizontal proporcional (valor / máximo) para tablas de reportes. */
@Component({
  selector: 'app-barra',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './barra.component.html',
  styleUrl: './barra.component.css',
})
export class BarraComponent {
  readonly valor = input.required<number>();
  readonly maximo = input.required<number>();
  readonly color = input('bg-orange-500');
  readonly porcentaje = computed(() => {
    const m = this.maximo();
    return m > 0 ? Math.min(100, Math.max(0, (this.valor() * 100) / m)) : 0;
  });
}
