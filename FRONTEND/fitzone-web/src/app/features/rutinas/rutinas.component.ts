import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormArray, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Ejercicio, Miembro, Rutina, TipoEjercicio } from '../../core/models';
import { ConfirmarComponent } from '../../shared/components/confirmar/confirmar.component';
import { IconComponent } from '../../shared/components/icon/icon.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { StatusPillComponent } from '../../shared/components/status-pill/status-pill.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-rutinas',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule, PanelComponent, VacioComponent, ModalComponent, StatusPillComponent, ConfirmarComponent, IconComponent, FechaPipe],
  templateUrl: './rutinas.component.html',
})
export class RutinasComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  readonly usuario = inject(AuthService).usuario;

  readonly esEntrenador = computed(() => this.usuario()?.rol === 'ENTRENADOR_SEDE');
  readonly cargando = signal(true);
  readonly lista = signal<Rutina[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly abiertas = signal<Set<string>>(new Set());
  readonly tipos: TipoEjercicio[] = ['fuerza', 'cardio', 'movilidad'];
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((r) => `${r.nombreRutina} ${r.miembro} ${r.entrenador} ${r.objetivo}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  /** Rutina en edición; null cuando el formulario crea una nueva. */
  readonly editando = signal<Rutina | null>(null);
  readonly porEliminar = signal<Rutina | null>(null);
  readonly eliminando = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idMiembro: [0, Validators.min(1)],
    nombreRutina: ['', [Validators.required, Validators.maxLength(100)]],
    objetivo: ['', Validators.maxLength(100)],
    notasEntrenador: [''],
    ejercicios: this.fb.array([this.nuevoEjercicio()]),
  });
  get ejercicios() { return this.form.controls.ejercicios as FormArray; }

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.esEntrenador()) this.data.miembros().subscribe((l) => this.miembros.set(l));
  }
  cargar() { this.data.rutinas().subscribe((l) => { this.lista.set(l); this.cargando.set(false); }); }

  alternarDetalle(id: string) {
    this.abiertas.update((s) => { const n = new Set(s); n.has(id) ? n.delete(id) : n.add(id); return n; });
  }
  /** Resumen legible de un ejercicio según su tipo. */
  detalle(e: Ejercicio): string {
    if (e.tipo === 'fuerza') return `${e.series} × ${e.repeticiones}${e.pesoKg ? ' · ' + e.pesoKg + ' kg' : ''}`;
    if (e.tipo === 'cardio') return `${e.duracionMin} min${e.distanciaKm ? ' · ' + e.distanciaKm + ' km' : ''}`;
    return `${e.series} × ${e.duracionSeg} s`;
  }
  /** Solo el entrenador que creó la rutina la modifica (el documento guarda su idEmpleado). */
  puedeModificar(r: Rutina): boolean {
    const u = this.usuario();
    return u?.rol === 'ENTRENADOR_SEDE' && r.idEmpleado === u.idEmpleado;
  }
  alternar(r: Rutina) {
    this.data.cambiarEstadoRutina(r.idRutina, !r.activa).subscribe({
      next: (m) => { this.toast.ok(m); this.cargar(); },
      error: (e) => this.toast.error(mensajeError(e)),
    });
  }

  private nuevoEjercicio(e?: Ejercicio) {
    return this.fb.nonNullable.group({
      nombre: [e?.nombre ?? '', Validators.required],
      tipo: [e?.tipo ?? ('fuerza' as TipoEjercicio)],
      series: [e?.series ?? (null as number | null)],
      repeticiones: [e?.repeticiones ?? (null as number | null)],
      pesoKg: [e?.pesoKg ?? (null as number | null)],
      duracionMin: [e?.duracionMin ?? (null as number | null)],
      duracionSeg: [e?.duracionSeg ?? (null as number | null)],
      distanciaKm: [e?.distanciaKm ?? (null as number | null)],
      notas: [e?.notas ?? ''],
    });
  }
  tipoDe(i: number): TipoEjercicio { return this.ejercicios.at(i).get('tipo')!.value; }
  agregarEjercicio() { this.ejercicios.push(this.nuevoEjercicio()); }
  quitarEjercicio(i: number) { if (this.ejercicios.length > 1) this.ejercicios.removeAt(i); }

  nueva() {
    this.editando.set(null);
    this.form.controls.idMiembro.enable();
    this.form.reset({ idMiembro: 0, nombreRutina: '', objetivo: '', notasEntrenador: '' });
    this.ejercicios.clear(); this.ejercicios.push(this.nuevoEjercicio());
    this.error.set(''); this.abierto.set(true);
  }
  editar(r: Rutina) {
    this.editando.set(r);
    this.form.reset({ idMiembro: r.idMiembro, nombreRutina: r.nombreRutina, objetivo: r.objetivo, notasEntrenador: r.notasEntrenador ?? '' });
    // La rutina pertenece a un miembro: no se reasigna, se crea otra.
    this.form.controls.idMiembro.disable();
    this.ejercicios.clear();
    for (const e of r.ejercicios) this.ejercicios.push(this.nuevoEjercicio(e));
    this.error.set(''); this.abierto.set(true);
  }
  eliminar() {
    const r = this.porEliminar();
    if (!r) return;
    this.eliminando.set(true);
    this.data.eliminarRutina(r.idRutina).subscribe({
      next: (m) => { this.eliminando.set(false); this.porEliminar.set(null); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.eliminando.set(false); this.porEliminar.set(null); this.toast.error(mensajeError(e)); },
    });
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const num = (x: unknown) => (x === null || x === '' || x === undefined ? undefined : +(x as number));
    const ejercicios: Ejercicio[] = v.ejercicios.map((e) => ({
      nombre: e.nombre.trim(), tipo: e.tipo,
      series: num(e.series), repeticiones: num(e.repeticiones), pesoKg: num(e.pesoKg),
      duracionMin: num(e.duracionMin), duracionSeg: num(e.duracionSeg), distanciaKm: num(e.distanciaKm),
      notas: e.notas?.trim() || undefined,
    }));
    this.enviando.set(true); this.error.set('');
    const datos = { nombreRutina: v.nombreRutina, objetivo: v.objetivo || undefined, notasEntrenador: v.notasEntrenador || undefined, ejercicios };
    const r = this.editando();
    (r ? this.data.editarRutina(r.idRutina, datos) : this.data.crearRutina({ ...datos, idMiembro: +v.idMiembro })).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
