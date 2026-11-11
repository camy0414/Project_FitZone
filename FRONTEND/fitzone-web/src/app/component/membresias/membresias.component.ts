import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { Catalogo } from '../../model/catalogo';
import { Membresia } from '../../model/membresia';
import { Miembro } from '../../model/miembro';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { mensajeError } from '../../service/util';
import { MONTO_MAXIMO, requerido } from '../../service/validaciones';

@Component({
  selector: 'app-membresias',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './membresias.component.html',
  styleUrl: './membresias.component.css',
})
export class MembresiasComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
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
    monto: [null as number | null, [requerido, Validators.min(1), Validators.max(MONTO_MAXIMO)]],
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
  cargar() { this.data.membresias().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) }); }
  nueva() { this.form.reset({ idMiembro: 0, idTipoPlan: 0, idMetodoPago: 0, monto: null }); this.error.set(''); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.renovarMembresia({ idMiembro: +v.idMiembro, idTipoPlan: +v.idTipoPlan, idMetodoPago: +v.idMetodoPago, monto: +v.monto! }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
