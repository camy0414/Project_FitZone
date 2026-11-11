package co.edu.unbosque.backFitZone.dto;


public class ClaseDTO {

	private Long idClase;
	private String nombre;
	private String descripcion;
	private Integer cupoMaximo;
	private Long idSede;
	private String sede;
	private Long idEmpleado;
	private String entrenador;

	public ClaseDTO() {
	}

	public ClaseDTO(Long idClase, String nombre, String descripcion, Integer cupoMaximo, Long idSede, String sede, Long idEmpleado, String entrenador) {
		super();
		this.idClase = idClase;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.cupoMaximo = cupoMaximo;
		this.idSede = idSede;
		this.sede = sede;
		this.idEmpleado = idEmpleado;
		this.entrenador = entrenador;
	}

	public Long getIdClase() {
		return idClase;
	}

	public void setIdClase(Long idClase) {
		this.idClase = idClase;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Integer getCupoMaximo() {
		return cupoMaximo;
	}

	public void setCupoMaximo(Integer cupoMaximo) {
		this.cupoMaximo = cupoMaximo;
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
}
