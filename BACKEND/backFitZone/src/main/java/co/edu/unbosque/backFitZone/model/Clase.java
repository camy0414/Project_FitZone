package co.edu.unbosque.backFitZone.model;


public class Clase {

	private Long idClase;
	private Integer cupoMaximo;
	private String nombre;
	private String descripcion;
	private Long idSede;
	private Long idEmpleado;

	public Clase() {
	
	}
	
	public Clase(Long idClase, Integer cupoMaximo, String nombre, String descripcion, Long idSede, Long idEmpleado) {
		super();
		this.idClase = idClase;
		this.cupoMaximo = cupoMaximo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.idSede = idSede;
		this.idEmpleado = idEmpleado;
	}

	public Long getIdClase() {
		return idClase;
	}

	public void setIdClase(Long idClase) {
		this.idClase = idClase;
	}

	public Integer getCupoMaximo() {
		return cupoMaximo;
	}

	public void setCupoMaximo(Integer cupoMaximo) {
		this.cupoMaximo = cupoMaximo;
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

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
	}
}
