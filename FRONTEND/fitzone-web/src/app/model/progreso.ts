// MongoDB: colección progreso.
export interface Medidas { cinturaCm?: number; pechoCm?: number; brazoCm?: number; caderaCm?: number }

export interface Progreso {
  idProgreso: string;
  idMiembro: number;
  miembro: string;
  idSede: number;
  fecha: string;
  pesoKg: number;
  grasaPct?: number;
  medidas?: Medidas;
  notas?: string;
}

export interface NuevoProgreso {
  idMiembro: number;
  fecha: string;
  pesoKg: number;
  grasaPct?: number;
  medidas?: Medidas;
  notas?: string;
}

export type EdicionProgreso = Omit<NuevoProgreso, 'idMiembro'>;
