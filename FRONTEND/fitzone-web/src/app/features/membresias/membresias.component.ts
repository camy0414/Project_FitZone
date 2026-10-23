import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Catalogo, Membresia, Miembro } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

const SUGERIDO: Record<string, number> = { mensual: 90000, trimestral: 240000, anual: 850000 };

@Component({
  selector: 'app-membresias',
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, FechaPipe],
  templateUrl: './membresias.component.html',
})
export class MembresiasComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  private usuario = inject(AuthService).usuario;

  readonly puedeRenovar = computed(() => ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly cargando = signal(true);
  readonly lista = signal<Membresia[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly planes = signal<Catalogo[]>([]);
  readonly metodos = signal<Catalogo[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.miembro} ${m.plan} ${m.estado}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idMiembro: [0, Validators.min(1)],
    idTipoPlan: [0, Validators.min(1)],
    idMetodoPago: [0, Validators.min(1)],
    monto: [0, Validators.min(1)],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.puedeRenovar()) {
      this.data.miembros().subscribe((l) => this.miembros.set(l));
      this.data.planes().subscribe((l) => this.planes.set(l));
      this.data.metodosPago().subscribe((l) => this.metodos.set(l));
    }
  }
  cargar() { this.data.membresias().subscribe((l) => { this.lista.set(l); this.cargando.set(false); }); }
  nueva() { this.form.reset({ idMiembro: 0, idTipoPlan: 0, idMetodoPago: 0, monto: 0 }); this.error.set(''); this.abierto.set(true); }
  /** Al elegir el plan se sugiere el monto (editable). */
  alElegirPlan() {
    const plan = this.planes().find((p) => p.id === +this.form.controls.idTipoPlan.value);
    const s = plan ? SUGERIDO[plan.nombre.toLowerCase()] : undefined;
    if (s) this.form.controls.monto.setValue(s);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.renovarMembresia({ idMiembro: +v.idMiembro, idTipoPlan: +v.idTipoPlan, idMetodoPago: +v.idMetodoPago, monto: +v.monto }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
