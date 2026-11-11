import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { fechaDesde, fechaHasta, LIMITES, requerido } from '../../service/validaciones';
import { Catalogo } from '../../model/catalogo';
import { Equipo } from '../../model/equipo';
import { Sede } from '../../model/sede';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { hoyISO, mensajeError } from '../../service/util';
import { paginar } from '../../service/paginacion';

/** Fecha mínima aceptada para la compra de un equipo. */
const FECHA_MINIMA = '1990-01-01';

@Component({
  selector: 'app-equipos',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './equipos.component.html',
  styleUrl: './equipos.component.css',
})
export class EquiposComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly cargando = signal(true);
  readonly lista = signal<Equipo[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly tipos = signal<Catalogo[]>([]);
  readonly hoy = hoyISO();
  readonly max = LIMITES.equipo;
  readonly fechaMinima = FECHA_MINIMA;
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((e) => `${e.nombre} ${e.tipo} ${e.sede}`.toLowerCase().includes(t));
  });
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);

  readonly abierto = signal(false);
  /** Equipo en edición; null cuando se registra uno nuevo. */
  readonly editando = signal<Equipo | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [requerido, Validators.maxLength(LIMITES.equipo.nombre)]],
    idTipoEquipo: [0, Validators.min(1)],
    idSede: [0, Validators.min(1)],
    // no puede ser futura; el mínimo evita años mal escritos (p. ej. 0202)
    fechaAdquisicion: [hoyISO(), [requerido, fechaHasta(hoyISO), fechaDesde(() => FECHA_MINIMA)]],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    this.data.tiposEquipo().subscribe((l) => this.tipos.set(l));
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
  }
  cargar() { this.data.equipos().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) }); }
  nuevo() {
    this.editando.set(null);
    this.form.reset({ idTipoEquipo: 0, idSede: this.esAdmin() ? 0 : (this.usuario()?.idSede ?? 0), fechaAdquisicion: hoyISO() });
    this.error.set(''); this.abierto.set(true);
  }
  editar(e: Equipo) {
    this.editando.set(e);
    this.form.reset({
      nombre: e.nombre, idTipoEquipo: this.tipos().find((t) => t.nombre === e.tipo)?.id ?? 0,
      idSede: e.idSede, fechaAdquisicion: e.fechaAdquisicion,
    });
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    const datos = { nombre: v.nombre, idTipoEquipo: +v.idTipoEquipo, idSede: +v.idSede, fechaAdquisicion: v.fechaAdquisicion };
    const e = this.editando();
    (e ? this.data.editarEquipo(e.idEquipo, datos) : this.data.crearEquipo(datos)).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
