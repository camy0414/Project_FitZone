import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Catalogo, Equipo, Sede } from '../../core/models';
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
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, FechaPipe],
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
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((e) => `${e.nombre} ${e.tipo} ${e.sede} ${e.estado}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [Validators.required, Validators.maxLength(50)]],
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
    this.form.reset({ idTipoEquipo: 0, idSede: this.esAdmin() ? 0 : (this.usuario()?.idSede ?? 0), fechaAdquisicion: hoyISO() });
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.crearEquipo({ nombre: v.nombre, idTipoEquipo: +v.idTipoEquipo, idSede: +v.idSede, fechaAdquisicion: v.fechaAdquisicion }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
