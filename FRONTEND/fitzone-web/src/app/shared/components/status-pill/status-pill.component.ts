import { Component, input } from '@angular/core';

const positivos = ['activa', 'activo', 'operativo', 'pagado', 'disponible', 'completado'];
const alertas = ['mantenimiento', 'pendiente', 'completa'];
const informativos = ['programada', 'inscrito'];

/** Pastilla de color según el estado (verde, ámbar o rojo). */
@Component({
  selector: 'app-status-pill',
  templateUrl: './status-pill.component.html',
})
export class StatusPillComponent {
  status = input.required<string>();
  private tipo = () =>
    positivos.includes(this.status()) ? 'ok'
      : informativos.includes(this.status()) ? 'info'
      : alertas.includes(this.status()) ? 'warn' : 'bad';
  clase = () =>
    ({ ok: 'bg-emerald-500/10 text-emerald-600', info: 'bg-sky-500/10 text-sky-600', warn: 'bg-amber-500/10 text-amber-600', bad: 'bg-red-500/10 text-red-600' })[this.tipo()];
  punto = () => ({ ok: 'bg-emerald-500', info: 'bg-sky-500', warn: 'bg-amber-500', bad: 'bg-red-500' })[this.tipo()];
}
