package co.edu.unbosque.backFitZone.model;


public class Sede {

	private Long idSede;
	private String telefono;
	private String nombre;
	private String direccion;

	public Sede() {
	}

	public Sede(Long idSede, String telefono, String nombre, String direccion) {
		super();
		this.idSede = idSede;
		this.telefono = telefono;
		this.nombre = nombre;
		this.direccion = direccion;
	}


	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
}
