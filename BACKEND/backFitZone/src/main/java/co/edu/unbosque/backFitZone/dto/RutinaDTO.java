package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;
import java.util.List;

public class RutinaDTO {

	private String idRutina;
	private Long idMiembro;
	private String miembro;
	private Long idEmpleado;
	private String entrenador;
	private Long idSede;
	private String sede;
	private String nombreRutina;
	private String objetivo;
	private LocalDate fechaCreacion;
	private Boolean activa;
	private List<EjercicioDTO> ejercicios;
	private String notasEntrenador;

	public RutinaDTO() {
		
	}

	public RutinaDTO(String idRutina, Long idMiembro, String miembro, Long idEmpleado, String entrenador, Long idSede, String sede, String nombreRutina, String objetivo, LocalDate fechaCreacion, Boolean activa, List<EjercicioDTO> ejercicios, String notasEntrenador) {
		super();
		this.idRutina = idRutina;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idEmpleado = idEmpleado;
		this.entrenador = entrenador;
		this.idSede = idSede;
		this.sede = sede;
		this.nombreRutina = nombreRutina;
		this.objetivo = objetivo;
		this.fechaCreacion = fechaCreacion;
		this.activa = activa;
		this.ejercicios = ejercicios;
		this.notasEntrenador = notasEntrenador;
	}

	public String getIdRutina() {
		return idRutina;
	}

	public void setIdRutina(String idRutina) {
		this.idRutina = idRutina;
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

	public String getNombreRutina() {
		return nombreRutina;
	}

	public void setNombreRutina(String nombreRutina) {
		this.nombreRutina = nombreRutina;
	}

	public String getObjetivo() {
		return objetivo;
	}

	public void setObjetivo(String objetivo) {
		this.objetivo = objetivo;
	}

	public LocalDate getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(LocalDate fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public Boolean getActiva() {
		return activa;
	}

	public void setActiva(Boolean activa) {
		this.activa = activa;
	}

	public List<EjercicioDTO> getEjercicios() {
		return ejercicios;
	}

	public void setEjercicios(List<EjercicioDTO> ejercicios) {
		this.ejercicios = ejercicios;
	}

	public String getNotasEntrenador() {
		return notasEntrenador;
	}

	public void setNotasEntrenador(String notasEntrenador) {
		this.notasEntrenador = notasEntrenador;
	}
}
