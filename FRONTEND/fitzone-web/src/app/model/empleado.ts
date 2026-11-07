// Tabla empleado.
import { NombrePersona } from './persona';
import { RolNombre } from './usuario';

export interface Empleado extends NombrePersona {
  idEmpleado: number;
  nombreCompleto: string;
  correo: string;
  telefono: string;
  rol: RolNombre;
  idSede: number;
  sede: string;
  activo: boolean;
}

export interface NuevoEmpleado {
  primerNombre: string; segundoNombre?: string;
  primerApellido: string; segundoApellido?: string;
  telefono: string; correo: string; clave: string;
  idRolEmpleado: number; idSede: number;
}

export type EdicionEmpleado = Omit<NuevoEmpleado, 'clave'>;
