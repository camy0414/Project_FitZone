package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;

public class ProgresoFisico {

	private String idProgreso;
	private Long idMiembro;
	private String miembro;
	private Long idSede;
	private Long idEmpleado;
	private LocalDate fecha;
	private Double pesoKg;
	private Double grasaPct;
	private Medidas medidas;
	private String notas;

	public ProgresoFisico() {
		
	}
	
	public ProgresoFisico(String idProgreso, Long idMiembro, String miembro, Long idSede, Long idEmpleado,
			LocalDate fecha, Double pesoKg, Double grasaPct, Medidas medidas, String notas) {
		super();
		this.idProgreso = idProgreso;
		this.idMiembro = idMiembro;
		this.miembro = miembro;
		this.idSede = idSede;
		this.idEmpleado = idEmpleado;
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

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
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

	public Medidas getMedidas() {
		return medidas;
	}

	public void setMedidas(Medidas medidas) {
		this.medidas = medidas;
	}

	public String getNotas() {
		return notas;
	}

	public void setNotas(String notas) {
		this.notas = notas;
	}

	/** Subdocumento medidas (opcional). */
	public static class Medidas {

		private Double cinturaCm;
		private Double pechoCm;
		private Double brazoCm;
		private Double caderaCm;

		public Medidas() {
		}

		public Double getCinturaCm() {
			return cinturaCm;
		}

		public void setCinturaCm(Double cinturaCm) {
			this.cinturaCm = cinturaCm;
		}

		public Double getPechoCm() {
			return pechoCm;
		}

		public void setPechoCm(Double pechoCm) {
			this.pechoCm = pechoCm;
		}

		public Double getBrazoCm() {
			return brazoCm;
		}

		public void setBrazoCm(Double brazoCm) {
			this.brazoCm = brazoCm;
		}

		public Double getCaderaCm() {
			return caderaCm;
		}

		public void setCaderaCm(Double caderaCm) {
			this.caderaCm = caderaCm;
		}
	}
}
