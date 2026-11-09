package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class MembresiaPorVencerDTO {

	private Long idMembresia;
	private Long idMiembro;
	private String miembro;
	private String telefono;
	private String correo;
	private String plan;
	private LocalDate fechaFin;
	private Integer diasRestantes;

	public MembresiaPorVencerDTO() {
		
	}

	public MembresiaPorVencerDTO(Long idMembresia, Long idMiembro, String miembro, String telefono, String correo, String plan, LocalDate fechaFin, Integer diasRestantes) {
		super();
		this.idMembresia = idMembresia;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.telefono = telefono;
		this.correo = correo;
		this.plan = plan;
		this.fechaFin = fechaFin;
		this.diasRestantes = diasRestantes;
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

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}

	public LocalDate getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(LocalDate fechaFin) {
		this.fechaFin = fechaFin;
	}

	public Integer getDiasRestantes() {
		return diasRestantes;
	}

	public void setDiasRestantes(Integer diasRestantes) {
		this.diasRestantes = diasRestantes;
	}
}
