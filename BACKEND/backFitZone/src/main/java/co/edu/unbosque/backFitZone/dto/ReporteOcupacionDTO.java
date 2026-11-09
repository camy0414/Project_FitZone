package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

public class ReporteOcupacionDTO {

	private Long numeroSesion;
	private String clase;
	private String sede;
	private LocalDate fecha;
	private LocalTime horaInicio;
	private Integer cupoMaximo;
	private Long inscritos;
	private Long asistentes;
	private BigDecimal pctOcupacion;

	public ReporteOcupacionDTO() {
		
	}

	public ReporteOcupacionDTO(Long numeroSesion, String clase, String sede, LocalDate fecha, LocalTime horaInicio, Integer cupoMaximo, Long inscritos, Long asistentes, BigDecimal pctOcupacion) {
		super();
		this.numeroSesion = numeroSesion;
		this.clase = clase;
		this.sede = sede;
		this.fecha = fecha;
		this.horaInicio = horaInicio;
		this.cupoMaximo = cupoMaximo;
		this.inscritos = inscritos;
		this.asistentes = asistentes;
		this.pctOcupacion = pctOcupacion;
	}

	public Long getNumeroSesion() {
		return numeroSesion;
	}

	public void setNumeroSesion(Long numeroSesion) {
		this.numeroSesion = numeroSesion;
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

	public LocalTime getHoraInicio() {
		return horaInicio;
	}

	public void setHoraInicio(LocalTime horaInicio) {
		this.horaInicio = horaInicio;
	}

	public Integer getCupoMaximo() {
		return cupoMaximo;
	}

	public void setCupoMaximo(Integer cupoMaximo) {
		this.cupoMaximo = cupoMaximo;
	}

	public Long getInscritos() {
		return inscritos;
	}

	public void setInscritos(Long inscritos) {
		this.inscritos = inscritos;
	}

	public Long getAsistentes() {
		return asistentes;
	}

	public void setAsistentes(Long asistentes) {
		this.asistentes = asistentes;
	}

	public BigDecimal getPctOcupacion() {
		return pctOcupacion;
	}

	public void setPctOcupacion(BigDecimal pctOcupacion) {
		this.pctOcupacion = pctOcupacion;
	}
}
