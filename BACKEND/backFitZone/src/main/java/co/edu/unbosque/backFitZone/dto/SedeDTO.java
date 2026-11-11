package co.edu.unbosque.backFitZone.dto;

public class SedeDTO {

	private Long idSede;
	private String nombre;
	private String direccion;
	private String telefono;

	public SedeDTO() {
		
	}

	public SedeDTO(Long idSede, String nombre, String direccion, String telefono) {
		super();
		this.idSede = idSede;
		this.nombre = nombre;
		this.direccion = direccion;
		this.telefono = telefono;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
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

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
}
