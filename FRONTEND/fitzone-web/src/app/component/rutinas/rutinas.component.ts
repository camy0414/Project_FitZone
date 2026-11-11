import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormArray, FormBuilder, Validators } from '@angular/forms';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { requerido } from '../../service/validaciones';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { Miembro } from '../../model/miembro';
import { Ejercicio, Rutina, TipoEjercicio } from '../../model/rutina';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { mensajeError } from '../../service/util';
import { paginar } from '../../service/paginacion';
import { enlaceReproductor, idYoutube } from '../../service/video';

/** Número entero mayor o igual a 1. */
const positivo = (x?: number) => x !== undefined && Number.isInteger(x) && x >= 1;

/**
 * Revisa un ejercicio con las mismas reglas del backend. Devuelve el mensaje del problema o null.
 * Fuerza: series y repeticiones. Cardio: minutos. Movilidad: series y segundos.
 */
function revisarEjercicio(e: Ejercicio): string | null {
  const n = e.nombre || 'sin nombre';
  if (e.tipo === 'fuerza' && !(positivo(e.series) && positivo(e.repeticiones))) {
    return `El ejercicio de fuerza «${n}» necesita series y repeticiones (números enteros desde 1).`;
  }
  if (e.tipo === 'cardio' && !positivo(e.duracionMin)) return `El ejercicio de cardio «${n}» necesita la duración en minutos.`;
  if (e.tipo === 'movilidad' && !(positivo(e.series) && positivo(e.duracionSeg))) {
    return `El ejercicio de movilidad «${n}» necesita series y duración en segundos.`;
  }
  if ((e.pesoKg ?? 0) < 0 || (e.distanciaKm ?? 0) < 0) return `El peso y la distancia de «${n}» no pueden ser negativos.`;
  if (e.videoUrl && !/^https?:\/\/\S+$/.test(e.videoUrl)) return `El enlace del video de «${n}» debe empezar por http:// o https://.`;
  return null;
}

@Component({
  selector: 'app-rutinas',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './rutinas.component.html',
  styleUrl: './rutinas.component.css',
})
export class RutinasComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
  private sanitizer = inject(DomSanitizer);
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
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);

  /** Video de YouTube que se está reproduciendo en la ventana; null si no hay ninguno. */
  readonly video = signal<{ titulo: string; url: SafeResourceUrl } | null>(null);

  readonly abierto = signal(false);
  /** Rutina en edición; null cuando el formulario crea una nueva. */
  readonly editando = signal<Rutina | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idMiembro: [0, Validators.min(1)],
    nombreRutina: ['', [requerido, Validators.maxLength(100)]],
    objetivo: ['', Validators.maxLength(100)],
    notasEntrenador: ['', Validators.maxLength(300)],
    ejercicios: this.fb.array([this.nuevoEjercicio()]),
  });
  get ejercicios() { return this.form.controls.ejercicios as FormArray; }

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.esEntrenador()) this.data.miembros().subscribe((l) => this.miembros.set(l));
  }
  cargar() {
    this.data.rutinas().subscribe({
      next: (l) => { this.lista.set(l); this.cargando.set(false); },
      error: () => this.cargando.set(false),
    });
  }

  alternarDetalle(id: string) {
    this.abiertas.update((s) => { const n = new Set(s); n.has(id) ? n.delete(id) : n.add(id); return n; });
  }
  /** Resumen legible de un ejercicio según su tipo. */
  detalle(e: Ejercicio): string {
    if (e.tipo === 'fuerza') return `${e.series} × ${e.repeticiones}${e.pesoKg ? ' · ' + e.pesoKg + ' kg' : ''}`;
    if (e.tipo === 'cardio') return `${e.duracionMin} min${e.distanciaKm ? ' · ' + e.distanciaKm + ' km' : ''}`;
    return `${e.series} × ${e.duracionSeg} s`;
  }
  /** true si el enlace es de YouTube: se reproduce dentro de la app. */
  esYoutube(e: Ejercicio): boolean { return idYoutube(e.videoUrl) !== null; }
  verVideo(e: Ejercicio) {
    const id = idYoutube(e.videoUrl);
    if (!id) return;
    // la dirección se arma solo con el código del video (11 caracteres revisados), por eso es segura
    this.video.set({ titulo: e.nombre, url: this.sanitizer.bypassSecurityTrustResourceUrl(enlaceReproductor(id)) });
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
      nombre: [e?.nombre ?? '', [requerido, Validators.maxLength(60)]],
      tipo: [e?.tipo ?? ('fuerza' as TipoEjercicio)],
      series: [e?.series ?? (null as number | null)],
      repeticiones: [e?.repeticiones ?? (null as number | null)],
      pesoKg: [e?.pesoKg ?? (null as number | null)],
      duracionMin: [e?.duracionMin ?? (null as number | null)],
      duracionSeg: [e?.duracionSeg ?? (null as number | null)],
      distanciaKm: [e?.distanciaKm ?? (null as number | null)],
      videoUrl: [e?.videoUrl ?? ''],
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
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const num = (x: unknown) => (x === null || x === '' || x === undefined ? undefined : +(x as number));
    // solo se envían los campos del tipo elegido (si se cambió el tipo, no quedan datos del anterior)
    const ejercicios: Ejercicio[] = v.ejercicios.map((e) => ({
      nombre: e.nombre.trim(), tipo: e.tipo,
      series: e.tipo !== 'cardio' ? num(e.series) : undefined,
      repeticiones: e.tipo === 'fuerza' ? num(e.repeticiones) : undefined,
      pesoKg: e.tipo === 'fuerza' ? num(e.pesoKg) : undefined,
      duracionMin: e.tipo === 'cardio' ? num(e.duracionMin) : undefined,
      duracionSeg: e.tipo === 'movilidad' ? num(e.duracionSeg) : undefined,
      distanciaKm: e.tipo === 'cardio' ? num(e.distanciaKm) : undefined,
      videoUrl: e.videoUrl?.trim() || undefined,
      notas: e.notas?.trim() || undefined,
    }));
    const problema = ejercicios.map(revisarEjercicio).find((m) => m !== null);
    if (problema) { this.error.set(problema); return; }
    this.enviando.set(true); this.error.set('');
    const datos = { nombreRutina: v.nombreRutina, objetivo: v.objetivo || undefined, notasEntrenador: v.notasEntrenador || undefined, ejercicios };
    const r = this.editando();
    (r ? this.data.editarRutina(r.idRutina, datos) : this.data.crearRutina({ ...datos, idMiembro: +v.idMiembro })).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}