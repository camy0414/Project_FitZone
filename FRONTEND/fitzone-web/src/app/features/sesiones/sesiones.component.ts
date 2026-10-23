import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Clase, Sesion } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { hoyISO, mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-sesiones',
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent, FechaPipe],
  templateUrl: './sesiones.component.html',
})
export class SesionesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  readonly usuario = inject(AuthService).usuario;

  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'GERENTE_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly titulo = computed(() => ({
    RECEPCIONISTA_SEDE: 'Agenda', ENTRENADOR_SEDE: 'Mis sesiones',
  } as Record<string, string>)[this.usuario()?.rol ?? ''] ?? 'Sesiones');
  readonly cargando = signal(true);
  readonly lista = signal<Sesion[]>([]);
  readonly clases = signal<Clase[]>([]);
  readonly hoy = hoyISO();
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((s) => `${s.clase} ${s.entrenador} ${s.sede} ${s.fecha}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idClase: [0, Validators.min(1)],
    fecha: [hoyISO(), Validators.required],
    horaInicio: ['', Validators.required],
    horaFin: ['', Validators.required],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.puedeCrear()) this.data.clases().subscribe((l) => this.clases.set(l));
  }
  cargar() {
    this.data.sesiones().subscribe((l) => {
      this.lista.set([...l].sort((a, b) => (a.fecha + a.horaInicio).localeCompare(b.fecha + b.horaInicio)));
      this.cargando.set(false);
    });
  }
  nueva() { this.form.reset({ idClase: 0, fecha: hoyISO(), horaInicio: '', horaFin: '' }); this.error.set(''); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    if (v.fecha < this.hoy) { this.error.set(`No se puede programar una sesión en una fecha pasada (${v.fecha}).`); return; }
    if (v.horaFin <= v.horaInicio) { this.error.set('La hora de fin debe ser posterior a la hora de inicio.'); return; }
    this.enviando.set(true); this.error.set('');
    this.data.crearSesion({ idClase: +v.idClase, fecha: v.fecha, horaInicio: v.horaInicio, horaFin: v.horaFin }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
