// Usuario que inicia sesión y roles del sistema (tabla empleado + rol_empleado).
export type RolNombre =
  | 'ADMIN_SISTEMA'
  | 'GERENTE_SEDE'
  | 'RECEPCIONISTA_SEDE'
  | 'ENTRENADOR_SEDE';

export const ROL_LABEL: Record<RolNombre, string> = {
  ADMIN_SISTEMA: 'Administrador de sistema',
  GERENTE_SEDE: 'Gerente de sede',
  RECEPCIONISTA_SEDE: 'Recepcionista de sede',
  ENTRENADOR_SEDE: 'Entrenador de sede',
};

/** Usuario en sesión (viene de fn_login + token del backend). */
export interface Usuario {
  idEmpleado: number;
  nombre: string;
  correo: string;
  rol: RolNombre;
  idSede: number;
  sede: string;
}

export interface LoginRespuesta {
  token: string;
  usuario: Usuario;
}
