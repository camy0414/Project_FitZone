package co.edu.unbosque.backFitZone.dto;

public class MetodoPagoDTO {

	private Long idMetodoPago;
	private String nombre;

	public MetodoPagoDTO() {
		
	}

	public MetodoPagoDTO(Long idMetodoPago, String nombre) {
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
