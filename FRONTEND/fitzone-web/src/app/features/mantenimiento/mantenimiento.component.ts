import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { DataService } from '../../core/data.service';
import { Equipo, Mantenimiento } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { CopPipe } from '../../shared/pipes/cop.pipe';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { hoyISO, mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-mantenimiento',
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, CopPipe, FechaPipe],
  templateUrl: './mantenimiento.component.html',
})
export class MantenimientoComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);

  readonly cargando = signal(true);
  readonly lista = signal<Mantenimiento[]>([]);
  readonly equipos = signal<Equipo[]>([]);
  readonly hoy = hoyISO();
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.equipo} ${m.sede} ${m.descripcion}`.toLowerCase().includes(t));
  });
  readonly total = computed(() => this.visibles().reduce((a, m) => a + m.costo, 0));

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idEquipo: [0, Validators.min(1)],
    costo: [0, Validators.min(0)],
    descripcion: ['', Validators.maxLength(200)],
    fecha: [hoyISO(), Validators.required],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    this.data.equipos().subscribe((l) => this.equipos.set(l));
  }
  cargar() {
    this.data.mantenimientos().subscribe((l) => {
      this.lista.set([...l].sort((a, b) => b.fecha.localeCompare(a.fecha)));
      this.cargando.set(false);
    });
  }
  nuevo() { this.form.reset({ idEquipo: 0, costo: 0, descripcion: '', fecha: hoyISO() }); this.error.set(''); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.crearMantenimiento({ idEquipo: +v.idEquipo, costo: +v.costo, descripcion: v.descripcion || undefined, fecha: v.fecha }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
