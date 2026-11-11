package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class SesionDTO {

	private Long numeroSesion;
	private Long idClase;
	private String clase;
	private Long idSede;
	private String sede;
	private Long idEmpleado;
	private String entrenador;
	private LocalDate fecha;
	private LocalTime horaInicio;
	private LocalTime horaFin;
	private Integer cupoMaximo;
	private Integer inscritos;

	public SesionDTO() {
		
	}

	public SesionDTO(Long numeroSesion, Long idClase, String clase, Long idSede, String sede, Long idEmpleado, String entrenador, LocalDate fecha, LocalTime horaInicio, LocalTime horaFin, Integer cupoMaximo, Integer inscritos) {
		super();
		this.numeroSesion = numeroSesion;
		this.idClase = idClase;
		this.clase = clase;
		this.idSede = idSede;
		this.sede = sede;
		this.idEmpleado = idEmpleado;
		this.entrenador = entrenador;
		this.fecha = fecha;
		this.horaInicio = horaInicio;
		this.horaFin = horaFin;
		this.cupoMaximo = cupoMaximo;
		this.inscritos = inscritos;
	}

	public Long getNumeroSesion() {
		return numeroSesion;
	}

	public void setNumeroSesion(Long numeroSesion) {
		this.numeroSesion = numeroSesion;
	}

	public Long getIdClase() {
		return idClase;
	}

	public void setIdClase(Long idClase) {
		this.idClase = idClase;
	}

	public String getClase() {
		return clase;
	}

	public void setClase(String clase) {
		this.clase = clase;
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

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
	}

	public String getEntrenador() {
		return entrenador;
	}

	public void setEntrenador(String entrenador) {
		this.entrenador = entrenador;
	}

	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
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

	public Integer getCupoMaximo() {
		return cupoMaximo;
	}

	public void setCupoMaximo(Integer cupoMaximo) {
		this.cupoMaximo = cupoMaximo;
	}

	public Integer getInscritos() {
		return inscritos;
	}

	public void setInscritos(Integer inscritos) {
		this.inscritos = inscritos;
	}
}
