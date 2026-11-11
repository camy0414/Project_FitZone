package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;

public class ReporteIngresoDTO {

	private Long idSede;
	private String sede;
	private String metodo;
	private Long numPagos;
	private BigDecimal total;

	public ReporteIngresoDTO() {

	}

	public ReporteIngresoDTO(Long idSede, String sede, String metodo, Long numPagos, BigDecimal total) {
		super();
		this.idSede = idSede;
		this.sede = sede;
		this.metodo = metodo;
		this.numPagos = numPagos;
		this.total = total;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getSede() {
		return sede;
	}

	public void setSede(String sede) {
		this.sede = sede;
	}

	public String getMetodo() {
		return metodo;
	}

	public void setMetodo(String metodo) {
		this.metodo = metodo;
	}

	public Long getNumPagos() {
		return numPagos;
	}

	public void setNumPagos(Long numPagos) {
		this.numPagos = numPagos;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}
}
