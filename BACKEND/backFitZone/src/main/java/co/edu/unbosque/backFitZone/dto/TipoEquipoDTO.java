package co.edu.unbosque.backFitZone.dto;

public class TipoEquipoDTO {

	private Long idTipoEquipo;
	private String nombre;

	public TipoEquipoDTO() {
	}

	public TipoEquipoDTO(Long idTipoEquipo, String nombre) {
		super();
		this.idTipoEquipo = idTipoEquipo;
		this.nombre = nombre;
	}

	public Long getIdTipoEquipo() {
		return idTipoEquipo;
	}

	public void setIdTipoEquipo(Long idTipoEquipo) {
		this.idTipoEquipo = idTipoEquipo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
