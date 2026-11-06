package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class PagoDTO {

	private Long idPago;
	private Long idMiembro;
	private String miembro;
	private Long idSede;
	private String metodo;
	private BigDecimal monto;
	private LocalDate fechaPago;

	public PagoDTO() {
		
	}

	public PagoDTO(Long idPago, Long idMiembro, String miembro, Long idSede, String metodo, BigDecimal monto, LocalDate fechaPago) {
		super();
		this.idPago = idPago;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idSede = idSede;
		this.metodo = metodo;
		this.monto = monto;
		this.fechaPago = fechaPago;
	}

	public Long getIdPago() {
		return idPago;
	}

	public void setIdPago(Long idPago) {
		this.idPago = idPago;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public String getMiembro() {
		return miembro;
	}

	public void setMiembro(String miembro) {
		this.miembro = miembro;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getMetodo() {
		return metodo;
	}

	public void setMetodo(String metodo) {
		this.metodo = metodo;
	}

	public BigDecimal getMonto() {
		return monto;
	}

	public void setMonto(BigDecimal monto) {
		this.monto = monto;
	}

	public LocalDate getFechaPago() {
		return fechaPago;
	}

	public void setFechaPago(LocalDate fechaPago) {
		this.fechaPago = fechaPago;
	}
}
