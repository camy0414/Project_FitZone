package co.edu.unbosque.backFitZone.dto;

public class RolEmpleadoDTO {

	private Long idRolEmpleado;
	private String nombre;

	public RolEmpleadoDTO() {
		
	}

	public RolEmpleadoDTO(Long idRolEmpleado, String nombre) {
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
