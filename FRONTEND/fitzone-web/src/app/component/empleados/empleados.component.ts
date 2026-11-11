import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { LIMITES, MENSAJE_FORMATO, PATRONES, requerido } from '../../service/validaciones';
import { Catalogo } from '../../model/catalogo';
import { Empleado } from '../../model/empleado';
import { Sede } from '../../model/sede';
import { ROL_LABEL, RolNombre } from '../../model/usuario';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { mensajeError } from '../../service/util';

@Component({
  selector: 'app-empleados',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './empleados.component.html',
  styleUrl: './empleados.component.css',
})
export class EmpleadosComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly max = LIMITES.persona;
  readonly msg = MENSAJE_FORMATO;
  readonly cargando = signal(true);
  readonly lista = signal<Empleado[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly roles = signal<Catalogo[]>([]);
  readonly rolLabel = (r: RolNombre) => ROL_LABEL[r];
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((e) => `${e.nombreCompleto} ${e.correo} ${e.rol} ${e.sede}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  /** Empleado en edición; null cuando se crea uno nuevo (la contraseña solo se fija al crear). */
  readonly editando = signal<Empleado | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly verClave = signal(false);
  /** Empleado que se va a desactivar (pide confirmación). */
  readonly porDesactivar = signal<Empleado | null>(null);
  readonly cambiando = signal(false);
  readonly form = this.fb.nonNullable.group({
    primerNombre: ['', [requerido, Validators.maxLength(LIMITES.persona.nombre), Validators.pattern(PATRONES.nombre)]],
    segundoNombre: ['', [Validators.maxLength(LIMITES.persona.nombre), Validators.pattern(PATRONES.nombre)]],
    primerApellido: ['', [requerido, Validators.maxLength(LIMITES.persona.apellido), Validators.pattern(PATRONES.nombre)]],
    segundoApellido: ['', [Validators.maxLength(LIMITES.persona.apellido), Validators.pattern(PATRONES.nombre)]],
    telefono: ['', [requerido, Validators.maxLength(LIMITES.persona.telefono), Validators.pattern(PATRONES.telefono)]],
    correo: ['', [requerido, Validators.maxLength(LIMITES.persona.correo), Validators.pattern(PATRONES.correo)]],
    clave: ['', [requerido, Validators.minLength(8), Validators.maxLength(72)]],
    idRolEmpleado: [0, Validators.min(1)],
    idSede: [0, Validators.min(1)],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.esAdmin()) {
      this.data.sedes().subscribe((l) => this.sedes.set(l));
      this.data.roles().subscribe((l) => this.roles.set(l));
    }
  }
  cargar() {
    this.data.empleados().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) });
  }
  nuevo() {
    this.editando.set(null);
    this.form.controls.clave.enable();
    this.form.reset({ idRolEmpleado: 0, idSede: 0 });
    this.error.set(''); this.verClave.set(false); this.abierto.set(true);
  }
  editar(e: Empleado) {
    this.editando.set(e);
    this.form.reset({
      primerNombre: e.primerNombre, segundoNombre: e.segundoNombre ?? '', primerApellido: e.primerApellido,
      segundoApellido: e.segundoApellido ?? '', telefono: e.telefono, correo: e.correo, clave: '',
      idRolEmpleado: this.roles().find((r) => r.nombre === e.rol)?.id ?? 0, idSede: e.idSede,
    });
    this.form.controls.clave.disable();
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    const datos = {
      primerNombre: v.primerNombre, segundoNombre: v.segundoNombre || undefined,
      primerApellido: v.primerApellido, segundoApellido: v.segundoApellido || undefined,
      telefono: v.telefono, correo: v.correo, idRolEmpleado: +v.idRolEmpleado, idSede: +v.idSede,
    };
    const e = this.editando();
    (e ? this.data.editarEmpleado(e.idEmpleado, datos) : this.data.crearEmpleado({ ...datos, clave: v.clave })).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
  /** Nadie puede desactivar su propia cuenta (el backend también lo impide). */
  esYo(e: Empleado) { return e.idEmpleado === this.usuario()?.idEmpleado; }
  /** Activar es inmediato; desactivar pide confirmación porque el empleado pierde el acceso. */
  alternar(e: Empleado) {
    if (e.activo) { this.porDesactivar.set(e); return; }
    this.cambiarEstado(e, true);
  }
  cambiarEstado(e: Empleado, activo: boolean) {
    this.cambiando.set(true);
    this.data.cambiarEstadoEmpleado(e.idEmpleado, activo).subscribe({
      next: (m) => { this.cambiando.set(false); this.porDesactivar.set(null); this.toast.ok(m); this.cargar(); },
      error: (err) => { this.cambiando.set(false); this.porDesactivar.set(null); this.toast.error(mensajeError(err)); },
    });
  }
}