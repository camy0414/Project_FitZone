import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { Clase } from '../../model/clase';
import { Sesion } from '../../model/sesion';
import { BuscadorService } from '../../service/buscador';
import { NotificacionService } from '../../service/notificacion';
import { toSignal } from '@angular/core/rxjs-interop';
import { aMinutos, DURACION_MAX_SESION_MIN, requerido, sesionIniciada, textoDuracion, validarHorarioSesion } from '../../service/validaciones';
import { hoyISO, mensajeError, porFechaHora, isoDesplazada } from '../../service/util';
import { paginar } from '../../service/paginacion';

@Component({
  selector: 'app-sesiones',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './sesiones.component.html',
  styleUrl: './sesiones.component.css',
})
export class SesionesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(NotificacionService);
  private fb = inject(FormBuilder);
  private buscador = inject(BuscadorService);
  readonly usuario = inject(AuthService).usuario;

  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'GERENTE_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly titulo = computed(() => ({
    RECEPCIONISTA_SEDE: 'Agenda', ENTRENADOR_SEDE: 'Mis sesiones',
  } as Record<string, string>)[this.usuario()?.rol ?? ''] ?? 'Sesiones');
  readonly cargando = signal(true);
  readonly lista = signal<Sesion[]>([]);
  readonly clases = signal<Clase[]>([]);
  readonly hoy = hoyISO();
  readonly hasta = isoDesplazada(365);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((s) => `${s.clase} ${s.entrenador} ${s.sede} ${s.fecha}`.toLowerCase().includes(t));
  });
  /** 15 registros por página (ver <app-paginador> al final de la lista). */
  readonly pag = paginar(this.visibles);

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    idClase: [0, Validators.min(1)],
    fecha: [hoyISO(), requerido],
    horaInicio: ['', requerido],
    horaFin: ['', requerido],
  });

  /** Duración mientras se llenan las horas, para avisar antes de enviar. */
  private readonly valores = toSignal(this.form.valueChanges, { initialValue: this.form.getRawValue() });
  readonly maxDuracion = textoDuracion(DURACION_MAX_SESION_MIN);
  readonly duracion = computed(() => {
    const { horaInicio, horaFin } = this.valores();
    if (!horaInicio || !horaFin) return null;
    const min = aMinutos(horaFin) - aMinutos(horaInicio);
    return { min, texto: min > 0 ? textoDuracion(min) : '', valida: min > 0 && min <= DURACION_MAX_SESION_MIN };
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.puedeCrear()) this.data.clases().subscribe((l) => this.clases.set(l));
  }
  cargar() {
    this.data.sesiones().subscribe({
      next: (l) => {
        const ordenadas = porFechaHora(l);
        this.lista.set(ordenadas);
        // abre en la página de las sesiones de hoy en adelante (las anteriores quedan en las páginas previas)
        const hoy = ordenadas.findIndex((s) => s.fecha >= hoyISO());
        this.pag.irA(hoy < 0 ? this.pag.totalPaginas() - 1 : Math.floor(hoy / this.pag.porPagina));
        this.cargando.set(false);
      },
      error: () => this.cargando.set(false),
    });
  }
  /** Estado de cada sesión: realizada, en curso, llena o programada. */
  estado(s: Sesion): string {
    if (!sesionIniciada(s.fecha, s.horaInicio)) return s.inscritos >= s.cupoMaximo ? 'llena' : 'programada';
    return sesionIniciada(s.fecha, s.horaFin) ? 'realizada' : 'en curso';
  }
  nueva() { this.form.reset({ idClase: 0, fecha: hoyISO(), horaInicio: '', horaFin: '' }); this.error.set(''); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const errHorario = validarHorarioSesion(v.fecha, v.horaInicio, v.horaFin, hoyISO());
    if (errHorario) { this.error.set(errHorario); return; }
    this.enviando.set(true); this.error.set('');
    this.data.crearSesion({ idClase: +v.idClase, fecha: v.fecha, horaInicio: v.horaInicio, horaFin: v.horaFin }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
