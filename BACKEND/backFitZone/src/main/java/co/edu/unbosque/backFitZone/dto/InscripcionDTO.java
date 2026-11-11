package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class InscripcionDTO {

	private Long numeroSesion;
	private Long idMiembro;
	private String miembro;
	private LocalDate fechaInscripcion;
	private Boolean asistio;
	private String clase;
	private String sede;
	private LocalDate fecha;
	private String horaInicio;
	private String horaFin;

	public InscripcionDTO() {
		
	}

	public InscripcionDTO(Long numeroSesion, Long idMiembro, String miembro, LocalDate fechaInscripcion, Boolean asistio, String clase, String sede, LocalDate fecha, String horaInicio, String horaFin) {
		super();
		this.numeroSesion = numeroSesion;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.fechaInscripcion = fechaInscripcion;
		this.asistio = asistio;
		this.clase = clase;
		this.sede = sede;
		this.fecha = fecha;
		this.horaInicio = horaInicio;
		this.horaFin = horaFin;
	}

	public Long getNumeroSesion() {
		return numeroSesion;
	}

	public void setNumeroSesion(Long numeroSesion) {
		this.numeroSesion = numeroSesion;
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

	public String getClase() {
		return clase;
	}

	public void setClase(String clase) {
		this.clase = clase;
	}

	public String getSede() {
		return sede;
	}

	public void setSede(String sede) {
		this.sede = sede;
	}

	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}

	public String getHoraInicio() {
		return horaInicio;
	}

	public void setHoraInicio(String horaInicio) {
		this.horaInicio = horaInicio;
	}

	public String getHoraFin() {
		return horaFin;
	}

	public void setHoraFin(String horaFin) {
		this.horaFin = horaFin;
	}
}
