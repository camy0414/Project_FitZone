package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;


public class MiembroSesion {

	private Long idMiembro;
	private Long numeroSesion;
	private LocalDate fechaInscripcion;
	private Boolean asistio;

	public MiembroSesion() {
	}

	public MiembroSesion(Long idMiembro, Long numeroSesion, LocalDate fechaInscripcion, Boolean asistio) {
		super();
		this.idMiembro = idMiembro;
		this.numeroSesion = numeroSesion;
		this.fechaInscripcion = fechaInscripcion;
		this.asistio = asistio;
	}


	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public Long getNumeroSesion() {
		return numeroSesion;
	}

	public void setNumeroSesion(Long numeroSesion) {
		this.numeroSesion = numeroSesion;
	}

	public LocalDate getFechaInscripcion() {
		return fechaInscripcion;
	}

	public void setFechaInscripcion(LocalDate fechaInscripcion) {
		this.fechaInscripcion = fechaInscripcion;
	}

	public Boolean getAsistio() {
		return asistio;
	}

	public void setAsistio(Boolean asistio) {
		this.asistio = asistio;
	}
}
