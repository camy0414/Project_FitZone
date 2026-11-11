package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;

public class ReporteMantenimientoDTO {

	private Long idSede;
	private String sede;
	private String tipo;
	private Long numMantenimientos;
	private BigDecimal costoTotal;

	public ReporteMantenimientoDTO() {

	}

	public ReporteMantenimientoDTO(Long idSede, String sede, String tipo, Long numMantenimientos, BigDecimal costoTotal) {
		super();
		this.idSede = idSede;
		this.sede = sede;
		this.tipo = tipo;
		this.numMantenimientos = numMantenimientos;
		this.costoTotal = costoTotal;
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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Long getNumMantenimientos() {
		return numMantenimientos;
	}

	public void setNumMantenimientos(Long numMantenimientos) {
		this.numMantenimientos = numMantenimientos;
	}

	public BigDecimal getCostoTotal() {
		return costoTotal;
	}

	public void setCostoTotal(BigDecimal costoTotal) {
		this.costoTotal = costoTotal;
	}
}
