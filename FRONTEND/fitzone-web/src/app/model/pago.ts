// Tabla pago.
export interface Pago {
  idPago: number;
  idMiembro: number;
  miembro: string;
  idSede: number;
  metodo: string;
  monto: number;
  fechaPago: string;
}
