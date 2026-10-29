import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { DataService } from '../../core/data.service';
import { LIMITES } from '../../core/limites';
import { Sede } from '../../core/models';
import { IconComponent } from '../../shared/components/icon/icon.component';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-sedes',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, IconComponent],
  templateUrl: './sedes.component.html',
})
export class SedesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);

  readonly max = LIMITES.sede;
  readonly cargando = signal(true);
  readonly lista = signal<Sede[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((s) => `${s.nombre} ${s.direccion} ${s.telefono}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);

  readonly editando = signal<Sede | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [Validators.required, Validators.maxLength(LIMITES.sede.nombre)]],
    direccion: ['', [Validators.required, Validators.maxLength(LIMITES.sede.direccion)]],
    telefono: ['', [Validators.required, Validators.maxLength(LIMITES.sede.telefono)]],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
  }
  cargar() {
    this.data.sedes().subscribe((l) => { this.lista.set(l); this.cargando.set(false); });
  }
  nueva() { this.editando.set(null); this.form.reset(); this.error.set(''); this.abierto.set(true); }
  editar(s: Sede) {
    this.editando.set(s);
    this.form.reset({ nombre: s.nombre, direccion: s.direccion, telefono: s.telefono });
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    const s = this.editando();
    (s ? this.data.editarSede(s.idSede, v) : this.data.crearSede(v)).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
