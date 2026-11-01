import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { LIMITES } from '../../core/limites';
import { Catalogo, Equipo, Sede } from '../../core/models';
import { IconComponent } from '../../shared/components/icon/icon.component';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { hoyISO, mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-equipos',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, IconComponent, FechaPipe],
  templateUrl: './equipos.component.html',
})
export class EquiposComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly cargando = signal(true);
  readonly lista = signal<Equipo[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly tipos = signal<Catalogo[]>([]);
  readonly hoy = hoyISO();
  readonly max = LIMITES.equipo;
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((e) => `${e.nombre} ${e.tipo} ${e.sede}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly editando = signal<Equipo | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [Validators.required, Validators.maxLength(LIMITES.equipo.nombre)]],
    idTipoEquipo: [0, Validators.min(1)],
    idSede: [0, Validators.min(1)],
    fechaAdquisicion: [hoyISO(), Validators.required],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    this.data.tiposEquipo().subscribe((l) => this.tipos.set(l));
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
  }
  cargar() { this.data.equipos().subscribe((l) => { this.lista.set(l); this.cargando.set(false); }); }
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
