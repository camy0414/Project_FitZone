import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { Observable, forkJoin } from 'rxjs';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Equipo, Membresia, Miembro, Pago, Sede, Sesion } from '../../core/models';
import { AvatarComponent } from '../../shared/components/avatar/avatar.component';
import { IconComponent } from '../../shared/components/icon/icon.component';
import { CopPipe } from '../../shared/pipes/cop.pipe';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { isoDesplazada as isoHoy, porFechaHora } from '../../shared/utils/util';
const DIAS = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

@Component({
  selector: 'app-resumen',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterLink, IconComponent, AvatarComponent, CopPipe, FechaPipe],
  templateUrl: './resumen.component.html',
})
export class ResumenComponent implements OnInit {
  private data = inject(DataService);
  readonly usuario = inject(AuthService).usuario;

  readonly cargando = signal(true);
  readonly sedes = signal<Sede[]>([]);
  readonly miembros = signal<Miembro[]>([]);
  readonly membresias = signal<Membresia[]>([]);
  readonly pagos = signal<Pago[]>([]);
  readonly sesiones = signal<Sesion[]>([]);
  readonly equipos = signal<Equipo[]>([]);

  readonly rol = computed(() => this.usuario()?.rol ?? 'ENTRENADOR_SEDE');
  readonly esEntrenador = computed(() => this.rol() === 'ENTRENADOR_SEDE');
  readonly esAdmin = computed(() => this.rol() === 'ADMIN_SISTEMA');
  readonly verEquipos = computed(() => ['ADMIN_SISTEMA', 'GERENTE_SEDE'].includes(this.rol()));
  readonly primerNombre = computed(() => this.usuario()?.nombre.split(' ')[0] ?? '');

  readonly columnas = computed(() =>
    this.esEntrenador() ? 'xl:grid-cols-3' : this.verEquipos() ? 'xl:grid-cols-6' : 'xl:grid-cols-5',
  );

  readonly hoy = isoHoy();
  readonly activas = computed(
    () => this.membresias().filter((m) => m.estado === 'ACTIVA' && m.fechaFin >= this.hoy).length,
  );
  readonly ingresos30 = computed(() =>
    this.pagos().filter((p) => p.fechaPago >= isoHoy(-30)).reduce((s, p) => s + p.monto, 0),
  );
  readonly sesionesHoy = computed(() => this.sesiones().filter((s) => s.fecha === this.hoy).length);
  readonly proximas = computed(() =>
    porFechaHora(this.sesiones().filter((s) => s.fecha >= this.hoy)).slice(0, 4),
  );

  readonly mantenidos30 = computed(() =>
    this.equipos().filter((e) => e.ultimoMantenimiento !== null && e.ultimoMantenimiento >= isoHoy(-30)).length);
 
  readonly equiposPorRevisar = computed(() =>
    [...this.equipos()].sort((a, b) => (a.ultimoMantenimiento ?? '').localeCompare(b.ultimoMantenimiento ?? '')).slice(0, 4));
  readonly inscripcionesProx = computed(() =>
    this.sesiones().filter((s) => s.fecha >= this.hoy).reduce((a, s) => a + s.inscritos, 0),
  );
  readonly ocupacion = computed(() => {
    const cupo = this.sesiones().reduce((a, s) => a + s.cupoMaximo, 0);
    const ins = this.sesiones().reduce((a, s) => a + s.inscritos, 0);
    return cupo ? Math.round((ins * 100) / cupo) : 0;
  });
  readonly pagosRecientes = computed(() =>
    [...this.pagos()].sort((a, b) => b.fechaPago.localeCompare(a.fechaPago)).slice(0, 5),
  );

  readonly barras = computed(() => {
    const dias = Array.from({ length: 7 }, (_, i) => isoHoy(i - 6));
    const valores = dias.map((f) =>
      this.sesiones().filter((s) => s.fecha === f).reduce((a, s) => a + s.inscritos, 0),
    );
    const max = Math.max(1, ...valores);
    return dias.map((f, i) => {
      const [a, m, d] = f.split('-').map(Number);
      return { etiqueta: DIAS[new Date(a, m - 1, d).getDay()], valor: valores[i], alto: Math.max(4, (valores[i] * 100) / max), hoy: i === 6 };
    });
  });

  pct = (s: Sesion) => Math.min(100, Math.round((s.inscritos * 100) / s.cupoMaximo));
  diaMes = (f: string) => {
    const [a, m, d] = f.split('-').map(Number);
    return { mes: new Intl.DateTimeFormat('es-CO', { month: 'short' }).format(new Date(a, m - 1, d)), dia: d };
  };

  ngOnInit() {
    const r: Record<string, Observable<unknown>> = { sesiones: this.data.sesiones() };
    if (!this.esEntrenador()) {
      r['miembros'] = this.data.miembros();
      r['membresias'] = this.data.membresias();
      r['pagos'] = this.data.pagos();
    }
    if (this.verEquipos()) r['equipos'] = this.data.equipos();
    if (this.esAdmin()) r['sedes'] = this.data.sedes();

    forkJoin(r).subscribe((res: any) => {
      this.sesiones.set(res.sesiones ?? []);
      this.miembros.set(res.miembros ?? []);
      this.membresias.set(res.membresias ?? []);
      this.pagos.set(res.pagos ?? []);
      this.equipos.set(res.equipos ?? []);
      this.sedes.set(res.sedes ?? []);
      this.cargando.set(false);
    });
  }
}
