package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;
import java.time.LocalTime;


public class Sesion {

	private Long numeroSesion;
	private LocalTime horaInicio;
	private LocalTime horaFin;
	private LocalDate fecha;
	private Long idClase;

	public Sesion() {
		
	}
	
	public Sesion(Long numeroSesion, LocalTime horaInicio, LocalTime horaFin, LocalDate fecha, Long idClase) {
		super();
		this.numeroSesion = numeroSesion;
		this.horaInicio = horaInicio;
		this.horaFin = horaFin;
		this.fecha = fecha;
		this.idClase = idClase;
	}

	public Long getNumeroSesion() {
		return numeroSesion;
	}

	public void setNumeroSesion(Long numeroSesion) {
		this.numeroSesion = numeroSesion;
	}

	public LocalTime getHoraInicio() {
		return horaInicio;
	}

	public void setHoraInicio(LocalTime horaInicio) {
		this.horaInicio = horaInicio;
	}

	public LocalTime getHoraFin() {
		return horaFin;
	}

	public void setHoraFin(LocalTime horaFin) {
		this.horaFin = horaFin;
	}

	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}

	public Long getIdClase() {
		return idClase;
	}

	public void setIdClase(Long idClase) {
		this.idClase = idClase;
	}
}
