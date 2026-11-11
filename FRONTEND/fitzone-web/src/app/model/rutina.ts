//colección rutinas.
export type TipoEjercicio = 'fuerza' | 'cardio' | 'movilidad';

/** Polimórfico*/
export interface Ejercicio {
  nombre: string;
  tipo: TipoEjercicio;
  series?: number;
  repeticiones?: number;
  pesoKg?: number;
  duracionMin?: number;
  duracionSeg?: number;
  distanciaKm?: number;
  videoUrl?: string;
  notas?: string;
}

export interface Rutina {
  idRutina: string;
  idMiembro: number;
  miembro: string;
  idEmpleado: number;
  entrenador: string;
  idSede: number;
  sede: string;
  nombreRutina: string;
  objetivo: string;
  fechaCreacion: string;
  activa: boolean;
  ejercicios: Ejercicio[];
  notasEntrenador?: string;
}

/** El entrenador y la sede los toma el backend del token. */
export interface NuevaRutina {
  idMiembro: number;
  nombreRutina: string;
  objetivo?: string;
  ejercicios: Ejercicio[];
  notasEntrenador?: string;
}

export type EdicionRutina = Omit<NuevaRutina, 'idMiembro'>;