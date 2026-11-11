package co.edu.unbosque.backFitZone.model;

import java.math.BigDecimal;
import java.time.LocalDate;


public class Pago {

	private Long idPago;
	private LocalDate fechaPago;
	private BigDecimal monto;
	private Long idMetodoPago;
	private Long idMiembro;

	public Pago() {
	
	}
	
	public Pago(Long idPago, LocalDate fechaPago, BigDecimal monto, Long idMetodoPago, Long idMiembro) {
		super();
		this.idPago = idPago;
		this.fechaPago = fechaPago;
		this.monto = monto;
		this.idMetodoPago = idMetodoPago;
		this.idMiembro = idMiembro;
	}


	public Long getIdPago() {
		return idPago;
	}

	public void setIdPago(Long idPago) {
		this.idPago = idPago;
	}

	public LocalDate getFechaPago() {
		return fechaPago;
	}

	public void setFechaPago(LocalDate fechaPago) {
		this.fechaPago = fechaPago;
	}

	public BigDecimal getMonto() {
		return monto;
	}

	public void setMonto(BigDecimal monto) {
		this.monto = monto;
	}

	public Long getIdMetodoPago() {
		return idMetodoPago;
	}

	public void setIdMetodoPago(Long idMetodoPago) {
		this.idMetodoPago = idMetodoPago;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}
}
