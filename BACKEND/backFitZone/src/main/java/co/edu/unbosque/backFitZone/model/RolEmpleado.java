package co.edu.unbosque.backFitZone.model;

public class RolEmpleado {

	private Long idRolEmpleado;

	private String nombre;

	public RolEmpleado() {
	}

	public RolEmpleado(Long idRolEmpleado, String nombre) {
		super();
		this.idRolEmpleado = idRolEmpleado;
		this.nombre = nombre;
	}

	public Long getIdRolEmpleado() {
		return idRolEmpleado;
	}

	public void setIdRolEmpleado(Long idRolEmpleado) {
		this.idRolEmpleado = idRolEmpleado;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
