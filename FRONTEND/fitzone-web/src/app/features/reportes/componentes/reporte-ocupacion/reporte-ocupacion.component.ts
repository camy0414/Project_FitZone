import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import {
  FiltroReporte, MembresiaPorVencer, ReporteIngreso, ReporteMantenimiento, ReporteOcupacion, RolNombre, Sede,
} from '../../core/models';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { ToastService } from '../../shared/services/toast.service';
import { isoDesplazada, mensajeError } from '../../shared/utils/util';
import { ReporteIngresosComponent } from './componentes/reporte-ingresos/reporte-ingresos.component';
import { ReporteMantenimientosComponent } from './componentes/reporte-mantenimientos/reporte-mantenimientos.component';
import { ReporteOcupacionComponent } from './componentes/reporte-ocupacion/reporte-ocupacion.component';
import { ReportePorVencerComponent } from './componentes/reporte-por-vencer/reporte-por-vencer.component';

type Pestana = 'ingresos' | 'ocupacion' | 'vencer' | 'mantenimiento';

interface DefPestana { id: Pestana; etiqueta: string; descripcion: string; roles: RolNombre[] }
const PESTANAS: DefPestana[] = [
  { id: 'ingresos', etiqueta: 'Ingresos', descripcion: 'Pagos agrupados por sede y método de pago.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'] },
  { id: 'ocupacion', etiqueta: 'Ocupación y asistencia', descripcion: 'Inscritos frente al cupo y asistencia de cada sesión.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE', 'ENTRENADOR_SEDE'] },
  { id: 'vencer', etiqueta: 'Por vencer', descripcion: 'Membresías activas que terminan pronto, para llamar a renovar.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'] },
  { id: 'mantenimiento', etiqueta: 'Mantenimiento', descripcion: 'Costo de mantenimiento por sede y tipo de equipo.', roles: ['ADMIN_SISTEMA', 'GERENTE_SEDE'] },
];

@Component({
  selector: 'app-reportes',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [
    FormsModule, PanelComponent, ReporteIngresosComponent, ReporteOcupacionComponent,
    ReportePorVencerComponent, ReporteMantenimientosComponent,
  ],
  templateUrl: './reportes.component.html',
})
export class ReportesComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly pestanas = computed(() => PESTANAS.filter((p) => p.roles.includes(this.usuario()!.rol)));
  readonly pestana = signal<Pestana>('ocupacion');
  readonly actual = computed(() => this.pestanas().find((p) => p.id === this.pestana())!);

  readonly sedes = signal<Sede[]>([]);
  readonly desde = signal(isoDesplazada(-30));
  readonly hasta = signal(isoDesplazada(0));
  readonly idSede = signal<number | null>(null);
  readonly dias = signal(7);
  readonly opcionesDias = [7, 15, 30];
  readonly rangoValido = computed(() => this.desde() <= this.hasta());

  readonly cargando = signal(false);
  readonly ingresos = signal<ReporteIngreso[]>([]);
  readonly ocupacion = signal<ReporteOcupacion[]>([]);
  readonly porVencer = signal<MembresiaPorVencer[]>([]);
  readonly mantenimientos = signal<ReporteMantenimiento[]>([]);

  ngOnInit() {
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
    this.elegir(this.pestanas()[0].id);
  }

  elegir(p: Pestana) {
    this.pestana.set(p);

    if (p === 'ocupacion' && this.hasta() === isoDesplazada(0)) this.hasta.set(isoDesplazada(7));
    if (p !== 'ocupacion' && this.hasta() === isoDesplazada(7)) this.hasta.set(isoDesplazada(0));
    this.cargar();
  }

  cargar() {
    if (!this.rangoValido()) return;
    const f: FiltroReporte = { desde: this.desde(), hasta: this.hasta(), idSede: this.idSede() };
    const error = (e: unknown) => { this.cargando.set(false); this.toast.error(mensajeError(e)); };
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
    }
  }
}
