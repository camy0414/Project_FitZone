package co.edu.unbosque.backFitZone.model;

import java.math.BigDecimal;
import java.time.LocalDate;


public class MantenimientoEquipo {

	private Long numeroMantenimiento;
	private BigDecimal costo;
	private String descripcion;
	private LocalDate fechaMantenimiento;
	private Long idEquipo;

	public MantenimientoEquipo() {
		
	}

	public MantenimientoEquipo(Long numeroMantenimiento, BigDecimal costo, String descripcion,
			LocalDate fechaMantenimiento, Long idEquipo) {
		super();
		this.numeroMantenimiento = numeroMantenimiento;
		this.costo = costo;
		this.descripcion = descripcion;
		this.fechaMantenimiento = fechaMantenimiento;
		this.idEquipo = idEquipo;
	}

	public Long getNumeroMantenimiento() {
		return numeroMantenimiento;
	}

	public void setNumeroMantenimiento(Long numeroMantenimiento) {
		this.numeroMantenimiento = numeroMantenimiento;
	}

	public BigDecimal getCosto() {
		return costo;
	}

	public void setCosto(BigDecimal costo) {
		this.costo = costo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public LocalDate getFechaMantenimiento() {
		return fechaMantenimiento;
	}

	public void setFechaMantenimiento(LocalDate fechaMantenimiento) {
		this.fechaMantenimiento = fechaMantenimiento;
	}

	public Long getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(Long idEquipo) {
		this.idEquipo = idEquipo;
	}
}
