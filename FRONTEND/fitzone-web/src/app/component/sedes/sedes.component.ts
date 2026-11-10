import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { DataService } from '../../service/data.service';
import { LIMITES, MENSAJE_FORMATO, PATRONES } from '../../service/validaciones';
import { Sede } from '../../model/sede';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { mensajeError } from '../../service/util';

@Component({
  selector: 'app-sedes',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './sedes.component.html',
  styleUrl: './sedes.component.css',
})
export class SedesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);

  readonly max = LIMITES.sede;
  readonly msg = MENSAJE_FORMATO;
  readonly cargando = signal(true);
  readonly lista = signal<Sede[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((s) => `${s.nombre} ${s.direccion} ${s.telefono}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  /** Sede en edición; null cuando el formulario crea una nueva. */
  readonly editando = signal<Sede | null>(null);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    nombre: ['', [Validators.required, Validators.maxLength(LIMITES.sede.nombre)]],
    direccion: ['', [Validators.required, Validators.maxLength(LIMITES.sede.direccion)]],
    telefono: ['', [Validators.required, Validators.maxLength(LIMITES.sede.telefono), Validators.pattern(PATRONES.telefono)]],
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