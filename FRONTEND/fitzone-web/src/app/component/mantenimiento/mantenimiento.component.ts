import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { DataService } from '../../service/data.service';
import { LIMITES } from '../../service/validaciones';
import { Equipo, Mantenimiento } from '../../model/equipo';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { hoyISO, mensajeError } from '../../service/util';

@Component({
  selector: 'app-mantenimiento',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './mantenimiento.component.html',
  styleUrl: './mantenimiento.component.css',
})
export class MantenimientoComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);

  readonly cargando = signal(true);
  readonly lista = signal<Mantenimiento[]>([]);
  readonly equipos = signal<Equipo[]>([]);
  readonly hoy = hoyISO();
  readonly max = LIMITES.mantenimiento;
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.equipo} ${m.sede} ${m.descripcion ?? ''}`.toLowerCase().includes(t));
  });
  readonly total = computed(() => this.visibles().reduce((a, m) => a + m.costo, 0));

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idEquipo: [0, Validators.min(1)],
    costo: [0, [Validators.required, Validators.min(0)]],
    descripcion: ['', Validators.maxLength(LIMITES.mantenimiento.descripcion)],
    fechaMantenimiento: [hoyISO(), Validators.required],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    this.data.equipos().subscribe((l) => this.equipos.set(l));
  }
  cargar() {
    this.data.mantenimientos().subscribe((l) => {
      this.lista.set([...l].sort((a, b) => b.fechaMantenimiento.localeCompare(a.fechaMantenimiento)));
      this.cargando.set(false);
    });
  }
  nuevo() { this.form.reset({ idEquipo: 0, costo: 0, descripcion: '', fechaMantenimiento: hoyISO() }); this.error.set(''); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.crearMantenimiento({ idEquipo: +v.idEquipo, costo: +v.costo, descripcion: v.descripcion || undefined, fechaMantenimiento: v.fechaMantenimiento }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
