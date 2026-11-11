package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class MantenimientoDTO {

	private Long numeroMantenimiento;
	private Long idEquipo;
	private String equipo;
	private Long idSede;
	private String sede;
	private String descripcion;
	private BigDecimal costo;
	private LocalDate fechaMantenimiento;

	public MantenimientoDTO() {
	}

	public MantenimientoDTO(Long numeroMantenimiento, Long idEquipo, String equipo, Long idSede, String sede, String descripcion, BigDecimal costo, LocalDate fechaMantenimiento) {
		super();
		this.numeroMantenimiento = numeroMantenimiento;
		this.idEquipo = idEquipo;
		this.equipo = equipo;
		this.idSede = idSede;
		this.sede = sede;
		this.descripcion = descripcion;
		this.costo = costo;
		this.fechaMantenimiento = fechaMantenimiento;
	}

	public Long getNumeroMantenimiento() {
		return numeroMantenimiento;
	}

	public void setNumeroMantenimiento(Long numeroMantenimiento) {
		this.numeroMantenimiento = numeroMantenimiento;
	}

	public Long getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(Long idEquipo) {
		this.idEquipo = idEquipo;
	}

	public String getEquipo() {
		return equipo;
	}

	public void setEquipo(String equipo) {
		this.equipo = equipo;
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

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public BigDecimal getCosto() {
		return costo;
	}

	public void setCosto(BigDecimal costo) {
		this.costo = costo;
	}

	public LocalDate getFechaMantenimiento() {
		return fechaMantenimiento;
	}

	public void setFechaMantenimiento(LocalDate fechaMantenimiento) {
		this.fechaMantenimiento = fechaMantenimiento;
	}
}
