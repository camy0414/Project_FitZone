import { Routes } from '@angular/router';
import { ACCESO } from './core/menu';
import { authGuard, loginGuard, roleGuard } from './core/guards';
import { ShellComponent } from './layout/shell/shell.component';

const vista = (ruta: string, cargar: () => Promise<any>) => ({
  path: ruta,
  canActivate: [roleGuard],
  data: { roles: ACCESO[ruta] },
  loadComponent: cargar,
});

export const routes: Routes = [
  {
    path: 'login',
    canActivate: [loginGuard],
    loadComponent: () => import('./features/login/login.component').then((m) => m.LoginComponent),
  },
  {
    path: '',
    component: ShellComponent,
    canActivate: [authGuard],
    children: [
      { path: '', pathMatch: 'full', redirectTo: 'resumen' },
      {
        path: 'resumen',
        loadComponent: () => import('./features/resumen/resumen.component').then((m) => m.ResumenComponent),
      },
      vista('sedes', () => import('./features/sedes/sedes.component').then((m) => m.SedesComponent)),
      vista('empleados', () => import('./features/empleados/empleados.component').then((m) => m.EmpleadosComponent)),
      vista('miembros', () => import('./features/miembros/miembros.component').then((m) => m.MiembrosComponent)),
      vista('membresias', () => import('./features/membresias/membresias.component').then((m) => m.MembresiasComponent)),
      vista('pagos', () => import('./features/pagos/pagos.component').then((m) => m.PagosComponent)),
      vista('clases', () => import('./features/clases/clases.component').then((m) => m.ClasesComponent)),
      vista('sesiones', () => import('./features/sesiones/sesiones.component').then((m) => m.SesionesComponent)),
      vista('inscripciones', () => import('./features/inscripciones/inscripciones.component').then((m) => m.InscripcionesComponent)),
      vista('asistencia', () => import('./features/asistencia/asistencia.component').then((m) => m.AsistenciaComponent)),
      vista('equipos', () => import('./features/equipos/equipos.component').then((m) => m.EquiposComponent)),
      vista('rutinas', () => import('./features/rutinas/rutinas.component').then((m) => m.RutinasComponent)),
      vista('progreso', () => import('./features/progreso/progreso.component').then((m) => m.ProgresoComponent)),
      vista('mantenimiento', () => import('./features/mantenimiento/mantenimiento.component').then((m) => m.MantenimientoComponent)),
    ],
  },
  { path: '**', redirectTo: '' },
];
