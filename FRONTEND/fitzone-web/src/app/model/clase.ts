// Tabla clase.
export interface Clase {
  idClase: number;
  nombre: string;
  /** clase.descripcion es opcional en el modelo. */
  descripcion: string | null;
  cupoMaximo: number;
  idSede: number;
  sede: string;
  idEmpleado: number;
  entrenador: string;
}

export interface NuevaClase {
  nombre: string; descripcion?: string; cupoMaximo: number; idSede: number; idEmpleado: number;
}

export type EdicionClase = NuevaClase;
