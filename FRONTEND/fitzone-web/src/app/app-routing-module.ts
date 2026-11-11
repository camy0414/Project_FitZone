import { NgModule } from '@angular/core';
import { Route, RouterModule, Routes } from '@angular/router';
import { AuditoriaComponent } from './component/auditoria/auditoria.component';
import { AsistenciaComponent } from './component/asistencia/asistencia.component';
import { ClasesComponent } from './component/clases/clases.component';
import { EmpleadosComponent } from './component/empleados/empleados.component';
import { EquiposComponent } from './component/equipos/equipos.component';
import { InscripcionesComponent } from './component/inscripciones/inscripciones.component';
import { LayoutComponent } from './component/layout/layout.component';
import { LoginComponent } from './component/login/login.component';
import { MantenimientoComponent } from './component/mantenimiento/mantenimiento.component';
import { MembresiasComponent } from './component/membresias/membresias.component';
import { MiembroDetalleComponent } from './component/miembro-detalle/miembro-detalle.component';
import { MiembrosComponent } from './component/miembros/miembros.component';
import { PagosComponent } from './component/pagos/pagos.component';
import { ProgresoComponent } from './component/progreso/progreso.component';
import { ReportesComponent } from './component/reportes/reportes.component';
import { ResumenComponent } from './component/resumen/resumen.component';
import { RutinasComponent } from './component/rutinas/rutinas.component';
import { SedesComponent } from './component/sedes/sedes.component';
import { SesionesComponent } from './component/sesiones/sesiones.component';
import { authGuard, loginGuard, roleGuard } from './service/guards';
import { ACCESO } from './service/menu';

/** Ruta protegida por rol; los roles permitidos salen de ACCESO (service/menu.ts). */
const vista = (path: string, component: Route['component'], modulo = path): Route => ({
  path,
  component,
  canActivate: [roleGuard],
  data: { roles: ACCESO[modulo] },
});

const routes: Routes = [
  { path: 'login', component: LoginComponent, canActivate: [loginGuard] },
  {
    path: '',
    component: LayoutComponent,
    canActivate: [authGuard],
    children: [
      { path: '', pathMatch: 'full', redirectTo: 'resumen' },
      { path: 'resumen', component: ResumenComponent },
      vista('sedes', SedesComponent),
      vista('empleados', EmpleadosComponent),
      vista('miembros', MiembrosComponent),
      vista('miembros/:id', MiembroDetalleComponent, 'miembros'),
      vista('membresias', MembresiasComponent),
      vista('pagos', PagosComponent),
      vista('clases', ClasesComponent),
      vista('sesiones', SesionesComponent),
      vista('inscripciones', InscripcionesComponent),
      vista('asistencia', AsistenciaComponent),
      vista('equipos', EquiposComponent),
      vista('mantenimiento', MantenimientoComponent),
      vista('rutinas', RutinasComponent),
      vista('progreso', ProgresoComponent),
      vista('reportes', ReportesComponent),
      vista('auditoria', AuditoriaComponent),
    ],
  },
  { path: '**', redirectTo: '' },
];

@NgModule({
  // bindToComponentInputs: el :id de la ruta llega como input() al componente (miembro-detalle)
  imports: [RouterModule.forRoot(routes, { bindToComponentInputs: true })],
  exports: [RouterModule],
})
export class AppRoutingModule {}