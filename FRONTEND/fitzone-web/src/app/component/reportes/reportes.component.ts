import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { EjercicioFrecuente, RutinasEntrenador } from '../../model/analisis';
import { FiltroReporte, MembresiaPorVencer, ReporteIngreso, ReporteMantenimiento, ReporteOcupacion } from '../../model/reporte';
import { Sede } from '../../model/sede';
import { RolNombre } from '../../model/usuario';
import { isoDesplazada } from '../../service/util';

type Pestana = 'ingresos' | 'ocupacion' | 'vencer' | 'mantenimiento' | 'ejercicios' | 'entrenadores';

/** sinFechas: reportes que no dependen de un rango de fechas (rutinas activas de hoy). */
interface DefPestana { id: Pestana; etiqueta: string; descripcion: string; roles: RolNombre[]; sinFechas?: boolean }

/** Qué reportes ve cada rol (mismo criterio que los permisos de lectura de cada tabla). */
const PESTANAS: DefPestana[] = [
  { id: 'ingresos', etiqueta: 'Ingresos', descripcion: 'Pagos agrupados por sede y método de pago.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'] },
  { id: 'ocupacion', etiqueta: 'Ocupación y asistencia', descripcion: 'Inscritos frente al cupo y asistencia de cada sesión.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE', 'ENTRENADOR_SEDE'] },
  { id: 'vencer', etiqueta: 'Por vencer', descripcion: 'Membresías activas que terminan pronto, para llamar a renovar.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'] },
  { id: 'mantenimiento', etiqueta: 'Mantenimiento', descripcion: 'Costo de mantenimiento por sede y tipo de equipo.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE'] },
  { id: 'ejercicios', etiqueta: 'Ejercicios más asignados', descripcion: 'Ejercicios que aparecen en más rutinas activas.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'ENTRENADOR_SEDE'], sinFechas: true },
  { id: 'entrenadores', etiqueta: 'Rutinas por entrenador', descripcion: 'Rutinas activas e inactivas que ha creado cada entrenador.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'ENTRENADOR_SEDE'], sinFechas: true },
];

@Component({
  selector: 'app-reportes',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './reportes.component.html',
  styleUrl: './reportes.component.css',
})
export class ReportesComponent implements OnInit {
  private data = inject(DataService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly pestanas = computed(() => PESTANAS.filter((p) => p.roles.includes(this.usuario()!.rol)));
  readonly pestana = signal<Pestana>('ocupacion');
  readonly actual = computed(() => this.pestanas().find((p) => p.id === this.pestana())!);

  // Filtros
  readonly sedes = signal<Sede[]>([]);
  readonly desde = signal(isoDesplazada(-30));
  readonly hasta = signal(isoDesplazada(0));
  readonly idSede = signal<number | null>(null);
  readonly dias = signal(7);
  readonly opcionesDias = [7, 15, 30];
  readonly rangoValido = computed(() => !!this.desde() && !!this.hasta() && this.desde() <= this.hasta());

  // Resultados
  readonly cargando = signal(false);
  readonly ingresos = signal<ReporteIngreso[]>([]);
  readonly ocupacion = signal<ReporteOcupacion[]>([]);
  readonly porVencer = signal<MembresiaPorVencer[]>([]);
  readonly mantenimientos = signal<ReporteMantenimiento[]>([]);
  readonly ejercicios = signal<EjercicioFrecuente[]>([]);
  readonly rutinasEntrenador = signal<RutinasEntrenador[]>([]);

  ngOnInit() {
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
    this.elegir(this.pestanas()[0].id);
  }

  elegir(p: Pestana) {
    this.pestana.set(p);
    // La ocupación incluye la próxima semana; el resto mira hacia atrás.
    if (p === 'ocupacion' && this.hasta() === isoDesplazada(0)) this.hasta.set(isoDesplazada(7));
    if (p !== 'ocupacion' && this.hasta() === isoDesplazada(7)) this.hasta.set(isoDesplazada(0));
    this.cargar();
  }

  cargar() {
    if (!this.actual().sinFechas && !this.rangoValido()) return;
    const f: FiltroReporte = { desde: this.desde(), hasta: this.hasta(), idSede: this.idSede() };
    // el motivo del error lo muestra el interceptor en un aviso
    const error = () => this.cargando.set(false);
    this.cargando.set(true);
    switch (this.pestana()) {
      case 'ingresos':
        this.data.reporteIngresos(f).subscribe({ next: (l) => { this.ingresos.set(l); this.cargando.set(false); }, error });
        break;
      case 'ocupacion':
        this.data.reporteOcupacion(f).subscribe({ next: (l) => { this.ocupacion.set(l); this.cargando.set(false); }, error });
        break;
      case 'vencer':
        this.data.membresiasPorVencer(this.dias(), this.idSede()).subscribe({ next: (l) => { this.porVencer.set(l); this.cargando.set(false); }, error });
        break;
      case 'mantenimiento':
        this.data.reporteMantenimientos(f).subscribe({ next: (l) => { this.mantenimientos.set(l); this.cargando.set(false); }, error });
        break;
      case 'ejercicios':
      case 'entrenadores':
        // las dos pestañas de rutinas salen de la misma consulta
        this.data.analisisMongo().subscribe({
          next: (d) => { this.ejercicios.set(d.ejercicios); this.rutinasEntrenador.set(d.rutinasEntrenador); this.cargando.set(false); },
          error,
        });
        break;
    }
  }
}
