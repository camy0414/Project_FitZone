package co.edu.unbosque.backFitZone.model;


public class MetodoPago {

	private Long idMetodoPago;
	private String nombre;

	public MetodoPago() {
		
	}

	public MetodoPago(Long idMetodoPago, String nombre) {
		super();
		this.idMetodoPago = idMetodoPago;
		this.nombre = nombre;
	}

	public Long getIdMetodoPago() {
		return idMetodoPago;
	}

	public void setIdMetodoPago(Long idMetodoPago) {
		this.idMetodoPago = idMetodoPago;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
