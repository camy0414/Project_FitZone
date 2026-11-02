package co.edu.unbosque.backFitZone.model;


public class TipoPlan {

	private Long idTipoPlan;
	private String nombre;

	public TipoPlan() {
		
	}

	public TipoPlan(Long idTipoPlan, String nombre) {
		super();
		this.idTipoPlan = idTipoPlan;
		this.nombre = nombre;
	}

	public Long getIdTipoPlan() {
		return idTipoPlan;
	}

	public void setIdTipoPlan(Long idTipoPlan) {
		this.idTipoPlan = idTipoPlan;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
