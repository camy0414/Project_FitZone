import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';

type Tono = 'ok' | 'info' | 'warn' | 'bad';

const TONOS: Record<string, Tono> = {
  activa: 'ok', activo: 'ok', 'asistió': 'ok', completado: 'ok', realizada: 'ok',
  programada: 'info', inscrito: 'info', pendiente: 'info', 'en curso': 'info',
  llena: 'warn', 'sin membresía': 'warn',
};
const CLASES: Record<Tono, string> = {
  ok: 'bg-emerald-500/10 text-emerald-600', info: 'bg-sky-500/10 text-sky-600',
  warn: 'bg-amber-500/10 text-amber-600', bad: 'bg-red-500/10 text-red-600',
};
const PUNTOS: Record<Tono, string> = { ok: 'bg-emerald-500', info: 'bg-sky-500', warn: 'bg-amber-500', bad: 'bg-red-500' };

/**
 * Pastilla de color según el estado. Acepta el valor tal como viene del modelo
 * ('ACTIVA', 'VENCIDA'…) o un texto de la vista; se muestra en minúscula capitalizada.
 */
@Component({
  selector: 'app-status-pill',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './status-pill.component.html',
  styleUrl: './status-pill.component.css',
})
export class StatusPillComponent {
  readonly status = input.required<string>();
  readonly texto = computed(() => this.status().toLowerCase());
  private readonly tono = computed<Tono>(() => TONOS[this.texto()] ?? 'bad');
  readonly clase = computed(() => CLASES[this.tono()]);
  readonly punto = computed(() => PUNTOS[this.tono()]);
}
