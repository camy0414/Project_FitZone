export interface Auditoria {
  idAuditoria: number;
  tabla: string; 
  operacion: string; 
  idRegistro: string;
  rolBd: string;
  idEmpleado: number | null;
  empleado: string | null;
  fecha: string;
}