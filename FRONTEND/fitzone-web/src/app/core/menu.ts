import { RolNombre } from './models';

export interface ItemMenu {
  etiqueta: string;
  ruta: string;
  icono: string;
}

/** Menú lateral por rol (cada cargo ve solo lo que corresponde a su trabajo). */
export const MENU: Record<RolNombre, ItemMenu[]> = {
  ADMIN_SISTEMA: [
    { etiqueta: 'Resumen', ruta: '/resumen', icono: 'layout-dashboard' },
    { etiqueta: 'Sedes', ruta: '/sedes', icono: 'building' },
    { etiqueta: 'Empleados', ruta: '/empleados', icono: 'user-cog' },
    { etiqueta: 'Miembros', ruta: '/miembros', icono: 'users' },
    { etiqueta: 'Membresías', ruta: '/membresias', icono: 'shield' },
    { etiqueta: 'Pagos', ruta: '/pagos', icono: 'dollar' },
    { etiqueta: 'Clases', ruta: '/clases', icono: 'dumbbell' },
    { etiqueta: 'Sesiones', ruta: '/sesiones', icono: 'calendar' },
    { etiqueta: 'Equipos', ruta: '/equipos', icono: 'dumbbell' },
    { etiqueta: 'Mantenimiento', ruta: '/mantenimiento', icono: 'wrench' },
    { etiqueta: 'Rutinas', ruta: '/rutinas', icono: 'activity' },
    { etiqueta: 'Progreso físico', ruta: '/progreso', icono: 'trending-up' },
  ],
  GERENTE_SEDE: [
    { etiqueta: 'Resumen', ruta: '/resumen', icono: 'layout-dashboard' },
    { etiqueta: 'Clases', ruta: '/clases', icono: 'dumbbell' },
    { etiqueta: 'Sesiones', ruta: '/sesiones', icono: 'calendar' },
    { etiqueta: 'Equipos', ruta: '/equipos', icono: 'dumbbell' },
    { etiqueta: 'Mantenimiento', ruta: '/mantenimiento', icono: 'wrench' },
    { etiqueta: 'Miembros', ruta: '/miembros', icono: 'users' },
    { etiqueta: 'Membresías', ruta: '/membresias', icono: 'shield' },
    { etiqueta: 'Pagos', ruta: '/pagos', icono: 'dollar' },
    { etiqueta: 'Personal', ruta: '/empleados', icono: 'user-cog' },
    { etiqueta: 'Rutinas', ruta: '/rutinas', icono: 'activity' },
    { etiqueta: 'Progreso físico', ruta: '/progreso', icono: 'trending-up' },
  ],
  RECEPCIONISTA_SEDE: [
    { etiqueta: 'Resumen', ruta: '/resumen', icono: 'layout-dashboard' },
    { etiqueta: 'Miembros', ruta: '/miembros', icono: 'users' },
    { etiqueta: 'Membresías', ruta: '/membresias', icono: 'shield' },
    { etiqueta: 'Pagos', ruta: '/pagos', icono: 'dollar' },
    { etiqueta: 'Inscripciones', ruta: '/inscripciones', icono: 'clipboard' },
    { etiqueta: 'Agenda', ruta: '/sesiones', icono: 'calendar' },
  ],
  ENTRENADOR_SEDE: [
    { etiqueta: 'Mi jornada', ruta: '/resumen', icono: 'layout-dashboard' },
    { etiqueta: 'Mis clases', ruta: '/clases', icono: 'dumbbell' },
    { etiqueta: 'Sesiones', ruta: '/sesiones', icono: 'calendar' },
    { etiqueta: 'Asistencia', ruta: '/asistencia', icono: 'clipboard' },
    { etiqueta: 'Rutinas', ruta: '/rutinas', icono: 'activity' },
    { etiqueta: 'Progreso físico', ruta: '/progreso', icono: 'trending-up' },
  ],
};

export const primeraRuta = (rol: RolNombre) => MENU[rol][0].ruta;

/** Roles con acceso a cada módulo (debe coincidir con los permisos de la BD). */
export const ACCESO: Record<string, RolNombre[]> = {
  sedes: ['ADMIN_SISTEMA'],
  empleados: ['ADMIN_SISTEMA', 'GERENTE_SEDE'],
  miembros: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'],
  membresias: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'],
  pagos: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE'],
  clases: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'ENTRENADOR_SEDE'],
  sesiones: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'RECEPCIONISTA_SEDE', 'ENTRENADOR_SEDE'],
  inscripciones: ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'],
  asistencia: ['ADMIN_SISTEMA', 'ENTRENADOR_SEDE'],
  equipos: ['ADMIN_SISTEMA', 'GERENTE_SEDE'],
  mantenimiento: ['ADMIN_SISTEMA', 'GERENTE_SEDE'],
  rutinas: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'ENTRENADOR_SEDE'],
  progreso: ['ADMIN_SISTEMA', 'GERENTE_SEDE', 'ENTRENADOR_SEDE'],
};
