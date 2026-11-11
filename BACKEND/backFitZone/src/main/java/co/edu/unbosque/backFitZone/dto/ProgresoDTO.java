package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class ProgresoDTO {

	private String idProgreso;
	private Long idMiembro;
	private String miembro;
	private Long idSede;
	private Long registradoPor;
	private String entrenador;
	private LocalDate fecha;
	private Double pesoKg;
	private Double grasaCorporalPct;
	private MedidasDTO medidas;
	private String notas;

	public ProgresoDTO() {
		
	}

	public ProgresoDTO(String idProgreso, Long idMiembro, String miembro, Long idSede, Long registradoPor, String entrenador, LocalDate fecha, Double pesoKg, Double grasaCorporalPct, MedidasDTO medidas, String notas) {
		super();
		this.idProgreso = idProgreso;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idSede = idSede;
		this.registradoPor = registradoPor;
		this.entrenador = entrenador;
		this.fecha = fecha;
		this.pesoKg = pesoKg;
		this.grasaCorporalPct = grasaCorporalPct;
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

	public Long getRegistradoPor() {
		return registradoPor;
	}

	public void setRegistradoPor(Long registradoPor) {
		this.registradoPor = registradoPor;
	}

	public String getEntrenador() {
		return entrenador;
	}

	public void setEntrenador(String entrenador) {
		this.entrenador = entrenador;
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

	public Double getGrasaCorporalPct() {
		return grasaCorporalPct;
	}

	public void setGrasaCorporalPct(Double grasaCorporalPct) {
		this.grasaCorporalPct = grasaCorporalPct;
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