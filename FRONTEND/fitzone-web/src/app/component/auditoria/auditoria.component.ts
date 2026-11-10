import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { Auditoria } from '../../model/auditoria';
import { BuscadorService } from '../../service/buscador';
import { mensajeError } from '../../service/util';

/** Registro de cambios en pagos, membresías y empleados (tabla auditoria). Solo el administrador. */
@Component({
  selector: 'app-auditoria',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './auditoria.component.html',
  styleUrl: './auditoria.component.css',
})
export class AuditoriaComponent implements OnInit {
  private data = inject(DataService);
  private buscador = inject(BuscadorService);

  readonly cargando = signal(true);
  readonly error = signal('');
  readonly lista = signal<Auditoria[]>([]);
  readonly tabla = signal('');
  readonly operacion = signal('');
  readonly tablas = computed(() => [...new Set(this.lista().map((a) => a.tabla))].sort());
  readonly operaciones = computed(() => [...new Set(this.lista().map((a) => a.operacion))].sort());

  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((a) =>
      (!this.tabla() || a.tabla === this.tabla()) &&
      (!this.operacion() || a.operacion === this.operacion()) &&
      `${a.tabla} ${a.operacion} ${a.idRegistro} ${a.empleado ?? ''} ${a.rolBd}`.toLowerCase().includes(t));
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.data.auditoria().subscribe({
      next: (l) => { this.lista.set(l); this.cargando.set(false); },
      error: (e) => { this.error.set(mensajeError(e)); this.cargando.set(false); },
    });
  }

  accion(op: string) {
    return ({ INSERT: 'Creación', UPDATE: 'Modificación', DELETE: 'Eliminación' } as Record<string, string>)[op] ?? op;
  }

  hora(fecha: string) { return fecha.slice(11, 16); }
}