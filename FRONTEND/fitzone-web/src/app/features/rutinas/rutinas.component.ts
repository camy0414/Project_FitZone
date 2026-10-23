import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormArray, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Ejercicio, Miembro, Rutina, TipoEjercicio } from '../../core/models';
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
  imports: [ReactiveFormsModule, PanelComponent, VacioComponent, ModalComponent, StatusPillComponent, FechaPipe],
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
  alternar(r: Rutina) {
    this.data.cambiarEstadoRutina(r.idRutina, !r.activa).subscribe({
      next: (m) => { this.toast.ok(m); this.cargar(); },
      error: (e) => this.toast.error(mensajeError(e)),
    });
  }

  private nuevoEjercicio() {
    return this.fb.nonNullable.group({
      nombre: ['', Validators.required],
      tipo: ['fuerza' as TipoEjercicio],
      series: [null as number | null],
      repeticiones: [null as number | null],
      pesoKg: [null as number | null],
      duracionMin: [null as number | null],
      duracionSeg: [null as number | null],
      distanciaKm: [null as number | null],
      notas: [''],
    });
  }
  tipoDe(i: number): TipoEjercicio { return this.ejercicios.at(i).get('tipo')!.value; }
  agregarEjercicio() { this.ejercicios.push(this.nuevoEjercicio()); }
  quitarEjercicio(i: number) { if (this.ejercicios.length > 1) this.ejercicios.removeAt(i); }

  nueva() {
    this.form.reset({ idMiembro: 0, nombreRutina: '', objetivo: '', notasEntrenador: '' });
    this.ejercicios.clear(); this.ejercicios.push(this.nuevoEjercicio());
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const num = (x: unknown) => (x === null || x === '' || x === undefined ? undefined : +(x as number));
    const ejercicios: Ejercicio[] = v.ejercicios.map((e: any) => ({
      nombre: e.nombre.trim(), tipo: e.tipo,
      series: num(e.series), repeticiones: num(e.repeticiones), pesoKg: num(e.pesoKg),
      duracionMin: num(e.duracionMin), duracionSeg: num(e.duracionSeg), distanciaKm: num(e.distanciaKm),
      notas: e.notas?.trim() || undefined,
    }));
    this.enviando.set(true); this.error.set('');
    this.data.crearRutina({
      idMiembro: +v.idMiembro, nombreRutina: v.nombreRutina, objetivo: v.objetivo || undefined,
      notasEntrenador: v.notasEntrenador || undefined, ejercicios,
    }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
