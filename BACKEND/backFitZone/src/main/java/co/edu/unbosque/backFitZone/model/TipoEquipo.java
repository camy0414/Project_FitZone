package co.edu.unbosque.backFitZone.model;

public class TipoEquipo {

	private Long idTipoEquipo;
	private String nombre;

	public TipoEquipo() {
		
	}
	
	public TipoEquipo(Long idTipoEquipo, String nombre) {
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
