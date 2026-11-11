import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { Auditoria } from '../../model/auditoria';
import { ROL_LABEL, RolNombre } from '../../model/usuario';
import { BuscadorService } from '../../service/buscador';
import { mensajeError } from '../../service/util';
import { paginar } from '../../service/paginacion';

/** Nombre para mostrar de cada tabla que tiene trigger de auditoría (script 03). */
const TABLAS: Record<string, string> = {
  sede: 'Sede',
  empleado: 'Empleado',
  miembro: 'Miembro',
  info_medica: 'Información médica',
  membresia: 'Membresía',
  pago: 'Pago',
  clase: 'Clase',
  sesion: 'Sesión',
  miembro_sesion: 'Inscripción',
  equipo: 'Equipo',
  mantenimiento_equipo: 'Mantenimiento',
};

/** Registro de lo que se crea o modifica en el sistema (tabla auditoria). Solo el administrador. */
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
      `${this.registro(a.tabla)} ${this.accion(a.operacion)} ${a.idRegistro} ${a.empleado ?? ''} ${this.cargo(a.rolBd)}`.toLowerCase().includes(t));
  });
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);

  ngOnInit() {
    this.buscador.texto.set('');
    this.data.auditoria().subscribe({
      next: (l) => { this.lista.set(l); this.cargando.set(false); },
      error: (e) => { this.error.set(mensajeError(e)); this.cargando.set(false); },
    });
  }

  /** 'INSERT' -> 'Registro', 'UPDATE' -> 'Modificación'. */
  accion(op: string) {
    return ({ INSERT: 'Registro', UPDATE: 'Modificación', DELETE: 'Eliminación' } as Record<string, string>)[op] ?? op;
  }
  /** 'membresia' -> 'Membresía'. */
  registro(tabla: string) { return TABLAS[tabla] ?? tabla; }
  /** 'rol_recepcionista_sede' -> 'Recepcionista de sede'. */
  cargo(rolBd: string) {
    const rol = (rolBd ?? '').replace(/^rol_/, '').toUpperCase() as RolNombre;
    return ROL_LABEL[rol] ?? 'Sistema';
  }
  /** Texto de la fila: «Registro de pago n.º 12». */
  titulo(a: Auditoria) {
    const id = a.idRegistro ?? '';
    if (a.tabla === 'miembro_sesion') {
      // id_registro llega como 'idMiembro-numeroSesion' (el trigger une las dos llaves)
      const [miembro, sesion] = id.split('-');
      return a.operacion === 'INSERT'
        ? `Inscripción del miembro n.º ${miembro} en la sesión n.º ${sesion}`
        : `Asistencia del miembro n.º ${miembro} en la sesión n.º ${sesion}`;
    }
    if (a.tabla === 'info_medica') return `${this.accion(a.operacion)} de información médica del miembro n.º ${id}`;
    return `${this.accion(a.operacion)} de ${this.registro(a.tabla).toLowerCase()} n.º ${id}`;
  }

  hora(fecha: string) { return fecha.slice(11, 16); }
}