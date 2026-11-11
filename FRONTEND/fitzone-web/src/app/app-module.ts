import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { NgModule, provideBrowserGlobalErrorListeners, provideZonelessChangeDetection } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import {
  LucideActivity, LucideArrowRight, LucideBell, LucideBuilding, LucideCalendarDays,
  LucideChartColumn, LucideChevronRight, LucideCircleDollarSign, LucideClipboardCheck, LucideDatabase, LucideDumbbell,
  LucideLayoutDashboard, LucideLockKeyhole, LucideLogOut, LucideMail, LucideMenu, LucidePencil,
  LucideSearch, LucideSettings, LucideShieldCheck, LucideTrendingUp, LucideUserRoundCog,
  LucideTrash2, LucideUsers, LucideWrench, LucideX, LucideZap,
} from '@lucide/angular';
import { environment } from '../environments/environment';
import { AppRoutingModule } from './app-routing-module';
import { AppComponent } from './app';

// Estructura
import { LayoutComponent } from './component/layout/layout.component';
import { NavbarComponent } from './component/navbar/navbar.component';
import { SidebarComponent } from './component/sidebar/sidebar.component';
import { LoginComponent } from './component/login/login.component';
// Pantallas
import { ResumenComponent } from './component/resumen/resumen.component';
import { SedesComponent } from './component/sedes/sedes.component';
import { EmpleadosComponent } from './component/empleados/empleados.component';
import { MiembrosComponent } from './component/miembros/miembros.component';
import { MiembroFormComponent } from './component/miembro-form/miembro-form.component';
import { MiembroDetalleComponent } from './component/miembro-detalle/miembro-detalle.component';
import { MembresiasComponent } from './component/membresias/membresias.component';
import { PagosComponent } from './component/pagos/pagos.component';
import { ClasesComponent } from './component/clases/clases.component';
import { SesionesComponent } from './component/sesiones/sesiones.component';
import { InscripcionesComponent } from './component/inscripciones/inscripciones.component';
import { AsistenciaComponent } from './component/asistencia/asistencia.component';
import { EquiposComponent } from './component/equipos/equipos.component';
import { MantenimientoComponent } from './component/mantenimiento/mantenimiento.component';
import { RutinasComponent } from './component/rutinas/rutinas.component';
import { ProgresoComponent } from './component/progreso/progreso.component';
import { AuditoriaComponent } from './component/auditoria/auditoria.component';
import { ReportesComponent } from './component/reportes/reportes.component';
import { ReporteIngresosComponent } from './component/reporte-ingresos/reporte-ingresos.component';
import { ReporteOcupacionComponent } from './component/reporte-ocupacion/reporte-ocupacion.component';
import { ReportePorVencerComponent } from './component/reporte-por-vencer/reporte-por-vencer.component';
import { ReporteEjerciciosComponent } from './component/reporte-ejercicios/reporte-ejercicios.component';
import { ReporteEntrenadoresComponent } from './component/reporte-entrenadores/reporte-entrenadores.component';
import { ReporteMantenimientosComponent } from './component/reporte-mantenimientos/reporte-mantenimientos.component';
// Piezas reutilizables
import { AvatarComponent } from './component/avatar/avatar.component';
import { BarraComponent } from './component/barra/barra.component';
import { ConfirmarComponent } from './component/confirmar/confirmar.component';
import { FilaComponent } from './component/fila/fila.component';
import { IconComponent } from './component/icon/icon.component';
import { IndicadorComponent } from './component/indicador/indicador.component';
import { ModalComponent } from './component/modal/modal.component';
import { PanelComponent } from './component/panel/panel.component';
import { StatusPillComponent } from './component/status-pill/status-pill.component';
import { ToastsComponent } from './component/toasts/toasts.component';
import { PaginadorComponent } from './component/paginador/paginador.component';
import { VacioComponent } from './component/vacio/vacio.component';
// Pipes
import { CopPipe } from './pipe/cop.pipe';
import { FechaPipe } from './pipe/fecha.pipe';
// Servicios
import { DataService } from './service/data.service';
import { HttpDataService } from './service/http-data.service';
import { MockDataService } from './service/mock-data.service';
import { TokenInterceptor } from './service/token.interceptor';

@NgModule({
  declarations: [
    AppComponent,
    LayoutComponent, NavbarComponent, SidebarComponent, LoginComponent,
    ResumenComponent, SedesComponent, EmpleadosComponent,
    MiembrosComponent, MiembroFormComponent, MiembroDetalleComponent, MembresiasComponent, PagosComponent,
    ClasesComponent, SesionesComponent, InscripcionesComponent, AsistenciaComponent,
    EquiposComponent, MantenimientoComponent,
    RutinasComponent, ProgresoComponent,
    ReportesComponent, ReporteIngresosComponent, ReporteOcupacionComponent, ReportePorVencerComponent, ReporteMantenimientosComponent,
    ReporteEjerciciosComponent, ReporteEntrenadoresComponent,
    AuditoriaComponent,
    AvatarComponent, BarraComponent, ConfirmarComponent, FilaComponent, IconComponent, IndicadorComponent,
    ModalComponent, PaginadorComponent, PanelComponent, StatusPillComponent, ToastsComponent, VacioComponent,
    CopPipe, FechaPipe,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    // íconos que usa <app-icon>
    LucideActivity, LucideArrowRight, LucideBell, LucideBuilding, LucideCalendarDays,
    LucideChartColumn, LucideChevronRight, LucideCircleDollarSign, LucideClipboardCheck, LucideDatabase, LucideDumbbell,
    LucideLayoutDashboard, LucideLockKeyhole, LucideLogOut, LucideMail, LucideMenu, LucidePencil,
    LucideSearch, LucideSettings, LucideShieldCheck, LucideTrendingUp, LucideUserRoundCog,
    LucideTrash2, LucideUsers, LucideWrench, LucideX, LucideZap,
  ],
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideZonelessChangeDetection(),
    provideHttpClient(withInterceptorsFromDi()),
    // le pone el token de la sesión a todas las peticiones al backend
    { provide: HTTP_INTERCEPTORS, useClass: TokenInterceptor, multi: true },
    // useMock: false -> todo con el backend (PostgreSQL y MongoDB)
    // useMock: true  -> todo con datos de ejemplo, sin backend
    MockDataService,
    HttpDataService,
    { provide: DataService, useExisting: environment.useMock ? MockDataService : HttpDataService },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}