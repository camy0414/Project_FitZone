package co.edu.unbosque.backFitZone.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MembresiaDTO {

	private Long idMembresia;
	private Long idMiembro;
	private String miembro;
	private Long idSede;
	private String plan;
	private String estado;
	private LocalDate fechaInicio;
	private LocalDate fechaFin;
	private Long idTipoPlan;
	 //Solo al renovar
	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
	private BigDecimal monto;
	//Solo al renovar
	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
	private Long idMetodoPago;

	public MembresiaDTO() {
		
	}

	public MembresiaDTO(Long idMembresia, Long idMiembro, String miembro, Long idSede, String plan, String estado, LocalDate fechaInicio, LocalDate fechaFin, Long idTipoPlan, BigDecimal monto, Long idMetodoPago) {
		super();
		this.idMembresia = idMembresia;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idSede = idSede;
		this.plan = plan;
		this.estado = estado;
		this.fechaInicio = fechaInicio;
		this.fechaFin = fechaFin;
		this.idTipoPlan = idTipoPlan;
		this.monto = monto;
		this.idMetodoPago = idMetodoPago;
	}

	public Long getIdMembresia() {
		return idMembresia;
	}

	public void setIdMembresia(Long idMembresia) {
		this.idMembresia = idMembresia;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public String getMiembro() {
		return miembro;
	}

	public void setMiembro(String miembro) {
		this.miembro = miembro;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
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

	public Long getIdTipoPlan() {
		return idTipoPlan;
	}

	public void setIdTipoPlan(Long idTipoPlan) {
		this.idTipoPlan = idTipoPlan;
	}

	public BigDecimal getMonto() {
		return monto;
	}

	public void setMonto(BigDecimal monto) {
		this.monto = monto;
	}

	public Long getIdMetodoPago() {
		return idMetodoPago;
	}

	public void setIdMetodoPago(Long idMetodoPago) {
		this.idMetodoPago = idMetodoPago;
	}
}
