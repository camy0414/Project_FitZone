// Tablas equipo y mantenimiento_equipo.
export interface Equipo {
  idEquipo: number;
  nombre: string;
  tipo: string;
  idSede: number;
  sede: string;
  fechaAdquisicion: string;
  /**
   * Dato derivado de mantenimiento_equipo: fecha del mantenimiento más reciente
   * (null si nunca ha tenido). El modelo no guarda un estado del equipo.
   */
  ultimoMantenimiento: string | null;
}

export interface NuevoEquipo {
  nombre: string; idTipoEquipo: number; idSede: number; fechaAdquisicion: string;
}

export type EdicionEquipo = NuevoEquipo;

export interface Mantenimiento {
  numeroMantenimiento: number;
  idEquipo: number;
  equipo: string;
  idSede: number;
  sede: string;
  /** mantenimiento_equipo.descripcion es opcional en el modelo. */
  descripcion: string | null;
  costo: number;
  fechaMantenimiento: string;
}

export interface NuevoMantenimiento {
  idEquipo: number; costo: number; descripcion?: string; fechaMantenimiento: string;
}
