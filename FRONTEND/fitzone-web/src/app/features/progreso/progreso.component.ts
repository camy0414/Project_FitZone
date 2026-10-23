import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Miembro, Progreso } from '../../core/models';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { ToastService } from '../../shared/services/toast.service';
import { hoyISO, mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-progreso',
  imports: [ReactiveFormsModule, PanelComponent, VacioComponent, ModalComponent, FechaPipe],
  templateUrl: './progreso.component.html',
})
export class ProgresoComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  readonly usuario = inject(AuthService).usuario;

  readonly esEntrenador = computed(() => this.usuario()?.rol === 'ENTRENADOR_SEDE');
  readonly cargando = signal(true);
  readonly todos = signal<Progreso[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly seleccionado = signal(0);
  readonly hoy = hoyISO();

  /** Miembros que tienen al menos una medición (para el selector de la vista). */
  readonly conDatos = computed(() => {
    const ids = new Map<number, string>();
    for (const p of this.todos()) ids.set(p.idMiembro, p.miembro);
    return [...ids].map(([id, nombre]) => ({ id, nombre })).sort((a, b) => a.nombre.localeCompare(b.nombre));
  });
  /** Mediciones del miembro elegido, de la más antigua a la más reciente. */
  readonly serie = computed(() =>
    this.todos().filter((p) => p.idMiembro === this.seleccionado()).sort((a, b) => a.fecha.localeCompare(b.fecha)));
  readonly resumen = computed(() => {
    const s = this.serie();
    if (!s.length) return null;
    const ini = s[0], fin = s[s.length - 1];
    return { inicial: ini.pesoKg, actual: fin.pesoKg, variacion: Math.round((fin.pesoKg - ini.pesoKg) * 10) / 10, registros: s.length };
  });
  /** Puntos del gráfico de peso (SVG 320 × 90). */
  readonly grafico = computed(() => {
    const s = this.serie();
    if (s.length < 2) return null;
    const pesos = s.map((p) => p.pesoKg);
    const min = Math.min(...pesos), max = Math.max(...pesos), rango = max - min || 1;
    const pts = s.map((p, i) => ({
      x: 12 + (i * 296) / (s.length - 1),
      y: 12 + (1 - (p.pesoKg - min) / rango) * 66,
      peso: p.pesoKg,
    }));
    return { linea: pts.map((p) => `${p.x},${p.y}`).join(' '), pts };
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idMiembro: [0, Validators.min(1)],
    fecha: [hoyISO(), Validators.required],
    pesoKg: [null as number | null, [Validators.required, Validators.min(20), Validators.max(400)]],
    grasaPct: [null as number | null, [Validators.min(2), Validators.max(70)]],
    cinturaCm: [null as number | null],
    pechoCm: [null as number | null],
    brazoCm: [null as number | null],
    caderaCm: [null as number | null],
    notas: [''],
  });

  ngOnInit() {
    this.cargar();
    if (this.esEntrenador()) this.data.miembros().subscribe((l) => this.miembros.set(l));
  }
  cargar() {
    this.data.progresos().subscribe((l) => {
      this.todos.set(l);
      if (!this.seleccionado() || !l.some((p) => p.idMiembro === this.seleccionado())) this.seleccionado.set(this.conDatos()[0]?.id ?? 0);
      this.cargando.set(false);
    });
  }
  elegir(id: number) { this.seleccionado.set(+id); }

  nueva() {
    this.form.reset({ idMiembro: this.seleccionado() || 0, fecha: hoyISO(), notas: '' });
    this.error.set(''); this.abierto.set(true);
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const n = (x: number | null) => (x === null || (x as unknown) === '' ? undefined : +x);
    const medidas = { cinturaCm: n(v.cinturaCm), pechoCm: n(v.pechoCm), brazoCm: n(v.brazoCm), caderaCm: n(v.caderaCm) };
    const hayMedidas = Object.values(medidas).some((x) => x !== undefined);
    this.enviando.set(true); this.error.set('');
    this.data.crearProgreso({
      idMiembro: +v.idMiembro, fecha: v.fecha, pesoKg: +v.pesoKg!, grasaPct: n(v.grasaPct),
      medidas: hayMedidas ? medidas : undefined, notas: v.notas || undefined,
    }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.seleccionado.set(+v.idMiembro); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
  medidasTexto(p: Progreso): string {
    const m = p.medidas;
    if (!m) return '—';
    return [m.cinturaCm && `cintura ${m.cinturaCm}`, m.pechoCm && `pecho ${m.pechoCm}`, m.brazoCm && `brazo ${m.brazoCm}`, m.caderaCm && `cadera ${m.caderaCm}`]
      .filter(Boolean).join(' · ') + ' cm';
  }
}
