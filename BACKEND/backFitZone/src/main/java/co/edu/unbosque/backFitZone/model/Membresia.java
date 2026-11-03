package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;


public class Membresia {

	private Long idMembresia;
	private String estado;
	private LocalDate fechaInicio;
	private LocalDate fechaFin;
	private Long idTipoPlan;
	private Long idMiembro;

	public Membresia() {
		
	}

	public Membresia(Long idMembresia, String estado, LocalDate fechaInicio, LocalDate fechaFin, Long idTipoPlan,
			Long idMiembro) {
		super();
		this.idMembresia = idMembresia;
		this.estado = estado;
		this.fechaInicio = fechaInicio;
		this.fechaFin = fechaFin;
		this.idTipoPlan = idTipoPlan;
		this.idMiembro = idMiembro;
	}


	public Long getIdMembresia() {
		return idMembresia;
	}

	public void setIdMembresia(Long idMembresia) {
		this.idMembresia = idMembresia;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public LocalDate getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(LocalDate fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public LocalDate getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(LocalDate fechaFin) {
		this.fechaFin = fechaFin;
	}

	public Long getIdTipoPlan() {
		return idTipoPlan;
	}

	public void setIdTipoPlan(Long idTipoPlan) {
		this.idTipoPlan = idTipoPlan;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}
}
