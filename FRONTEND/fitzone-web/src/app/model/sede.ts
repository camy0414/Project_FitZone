// Tabla sede.
export interface Sede {
  idSede: number;
  nombre: string;
  direccion: string;
  telefono: string;
}

export interface NuevaSede { nombre: string; direccion: string; telefono: string }

export type EdicionSede = NuevaSede;
