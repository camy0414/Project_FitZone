package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class RenovacionDTO {

	private Long idMembresia;
	private Long idPago;
	private LocalDate fechaInicio;
	private LocalDate fechaFin;

	public RenovacionDTO() {
		
	}

	public RenovacionDTO(Long idMembresia, Long idPago, LocalDate fechaInicio, LocalDate fechaFin) {
		super();
		this.idMembresia = idMembresia;
		this.idPago = idPago;
		this.fechaInicio = fechaInicio;
		this.fechaFin = fechaFin;
	}

	public Long getIdMembresia() {
		return idMembresia;
	}

	public void setIdMembresia(Long idMembresia) {
		this.idMembresia = idMembresia;
	}

	public Long getIdPago() {
		return idPago;
	}

	public void setIdPago(Long idPago) {
		this.idPago = idPago;
	}

	public LocalDate getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(LocalDate fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public LocalDate getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(LocalDate fechaFin) {
		this.fechaFin = fechaFin;
	}
}
