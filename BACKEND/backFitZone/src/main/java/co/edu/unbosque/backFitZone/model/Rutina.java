package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;
import java.util.List;


public class Rutina {

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
	private String notasEntrenador;
	private List<Ejercicio> ejercicios;

	public Rutina() {
		
	}

	public Rutina(String idRutina, Long idMiembro, String miembro, Long idEmpleado, String entrenador, Long idSede,
			String sede, String nombreRutina, String objetivo, LocalDate fechaCreacion, Boolean activa,
			String notasEntrenador, List<Ejercicio> ejercicios) {
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
		this.notasEntrenador = notasEntrenador;
		this.ejercicios = ejercicios;
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

	public String getNotasEntrenador() {
		return notasEntrenador;
	}

	public void setNotasEntrenador(String notasEntrenador) {
		this.notasEntrenador = notasEntrenador;
	}

	public List<Ejercicio> getEjercicios() {
		return ejercicios;
	}

	public void setEjercicios(List<Ejercicio> ejercicios) {
		this.ejercicios = ejercicios;
	}

	/** Subdocumento del arreglo ejercicios. Los campos con valor dependen del tipo (fuerza, cardio o movilidad). */
	public static class Ejercicio {

		private String nombre;
		/** fuerza | cardio | movilidad */
		private String tipo;
		private Integer series;
		private Integer repeticiones;
		private Double pesoKg;
		private Integer duracionMin;
		private Integer duracionSeg;
		private Double distanciaKm;
		private String notas;

		public Ejercicio() {
		}

		public String getNombre() {
			return nombre;
		}

		public void setNombre(String nombre) {
			this.nombre = nombre;
		}

		public String getTipo() {
			return tipo;
		}

		public void setTipo(String tipo) {
			this.tipo = tipo;
		}

		public Integer getSeries() {
			return series;
		}

		public void setSeries(Integer series) {
			this.series = series;
		}

		public Integer getRepeticiones() {
			return repeticiones;
		}

		public void setRepeticiones(Integer repeticiones) {
			this.repeticiones = repeticiones;
		}

		public Double getPesoKg() {
			return pesoKg;
		}

		public void setPesoKg(Double pesoKg) {
			this.pesoKg = pesoKg;
		}

		public Integer getDuracionMin() {
			return duracionMin;
		}

		public void setDuracionMin(Integer duracionMin) {
			this.duracionMin = duracionMin;
		}

		public Integer getDuracionSeg() {
			return duracionSeg;
		}

		public void setDuracionSeg(Integer duracionSeg) {
			this.duracionSeg = duracionSeg;
		}

		public Double getDistanciaKm() {
			return distanciaKm;
		}

		public void setDistanciaKm(Double distanciaKm) {
			this.distanciaKm = distanciaKm;
		}

		public String getNotas() {
			return notas;
		}

		public void setNotas(String notas) {
			this.notas = notas;
		}
	}
}
