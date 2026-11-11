import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { entero, LIMITES, requerido } from '../../service/validaciones';
import { Clase } from '../../model/clase';
import { Empleado } from '../../model/empleado';
import { Sede } from '../../model/sede';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { mensajeError } from '../../service/util';
import { paginar } from '../../service/paginacion';

/** Tope razonable de cupos por clase (evita errores de digitación). */
const CUPO_MAXIMO = 500;

@Component({
  selector: 'app-clases',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './clases.component.html',
  styleUrl: './clases.component.css',
})
export class ClasesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'GERENTE_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly esEntrenador = computed(() => this.usuario()?.rol === 'ENTRENADOR_SEDE');
  readonly max = LIMITES.clase;
  readonly cupoMaximo = CUPO_MAXIMO;
  readonly cargando = signal(true);
  readonly lista = signal<Clase[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly empleados = signal<Empleado[]>([]);
  readonly sedeElegida = signal(0);
  /** Solo entrenadores activos de la sede elegida (misma regla que el trigger de la BD). */
  readonly entrenadores = computed(() =>
    this.empleados().filter((e) => e.rol === 'ENTRENADOR_SEDE' && e.activo && e.idSede === this.sedeElegida()));
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((c) => `${c.nombre} ${c.descripcion ?? ''} ${c.entrenador} ${c.sede}`.toLowerCase().includes(t));
  });
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);

  readonly abierto = signal(false);
  /** Clase en edición; null cuando se crea una nueva. */
  readonly editando = signal<Clase | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [requerido, Validators.maxLength(LIMITES.clase.nombre)]],
    descripcion: ['', Validators.maxLength(LIMITES.clase.descripcion)],
    cupoMaximo: [15, [requerido, entero, Validators.min(1), Validators.max(CUPO_MAXIMO)]],
    idSede: [0, Validators.min(1)],
    idEmpleado: [0, Validators.min(1)],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.puedeCrear()) {
      this.data.empleados().subscribe((l) => this.empleados.set(l));
      if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
    }
  }
  cargar() { this.data.clases().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) }); }
  nueva() {
    this.editando.set(null);
    const sede = this.esAdmin() ? 0 : (this.usuario()?.idSede ?? 0);
    this.form.reset({ cupoMaximo: 15, idSede: sede, idEmpleado: 0 });
    this.sedeElegida.set(sede);
    this.error.set(''); this.abierto.set(true);
  }
  editar(c: Clase) {
    this.editando.set(c);
    this.form.reset({ nombre: c.nombre, descripcion: c.descripcion ?? '', cupoMaximo: c.cupoMaximo, idSede: c.idSede, idEmpleado: c.idEmpleado });
    this.sedeElegida.set(c.idSede);
    this.error.set(''); this.abierto.set(true);
  }
  alCambiarSede() {
    this.sedeElegida.set(+this.form.controls.idSede.value);
    this.form.controls.idEmpleado.setValue(0);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    const datos = { nombre: v.nombre, descripcion: v.descripcion || undefined, cupoMaximo: +v.cupoMaximo, idSede: +v.idSede, idEmpleado: +v.idEmpleado };
    const c = this.editando();
    (c ? this.data.editarClase(c.idClase, datos) : this.data.crearClase(datos)).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
