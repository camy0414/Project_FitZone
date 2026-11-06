package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class ProgresoDTO {

	private String idProgreso;
	private Long idMiembro;
	private String miembro;
	private Long idSede;
	private LocalDate fecha;
	private Double pesoKg;
	private Double grasaPct;
	private MedidasDTO medidas;
	private String notas;

	public ProgresoDTO() {
		
	}

	public ProgresoDTO(String idProgreso, Long idMiembro, String miembro, Long idSede, LocalDate fecha, Double pesoKg, Double grasaPct, MedidasDTO medidas, String notas) {
		super();
		this.idProgreso = idProgreso;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idSede = idSede;
		this.fecha = fecha;
		this.pesoKg = pesoKg;
		this.grasaPct = grasaPct;
		this.medidas = medidas;
		this.notas = notas;
	}

	public String getIdProgreso() {
		return idProgreso;
	}

	public void setIdProgreso(String idProgreso) {
		this.idProgreso = idProgreso;
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

	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}

	public Double getPesoKg() {
		return pesoKg;
	}

	public void setPesoKg(Double pesoKg) {
		this.pesoKg = pesoKg;
	}

	public Double getGrasaPct() {
		return grasaPct;
	}

	public void setGrasaPct(Double grasaPct) {
		this.grasaPct = grasaPct;
	}

	public MedidasDTO getMedidas() {
		return medidas;
	}

	public void setMedidas(MedidasDTO medidas) {
		this.medidas = medidas;
	}

	public String getNotas() {
		return notas;
	}

	public void setNotas(String notas) {
		this.notas = notas;
	}
}
