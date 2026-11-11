package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;

public class ProgresoFisico {

	private String idProgreso;
	private Long idMiembro;
	private Long idSede;
	private Long registradoPor;
	private LocalDate fecha;
	private Double pesoKg;
	private Double grasaCorporalPct;
	private Medidas medidas;
	private String notas;

	public ProgresoFisico() {
		
	}

	public ProgresoFisico(String idProgreso, Long idMiembro, Long idSede, Long registradoPor, LocalDate fecha, Double pesoKg, Double grasaCorporalPct, Medidas medidas, String notas) {
		super();
		this.idProgreso = idProgreso;
		this.idMiembro = idMiembro;
		this.idSede = idSede;
		this.registradoPor = registradoPor;
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

	public static class Medidas {

		private Double cinturaCm;
		private Double pechoCm;
		private Double brazoCm;
		private Double caderaCm;

		public Medidas() {
		}

		public Medidas(Double cinturaCm, Double pechoCm, Double brazoCm, Double caderaCm) {
			super();
			this.cinturaCm = cinturaCm;
			this.pechoCm = pechoCm;
			this.brazoCm = brazoCm;
			this.caderaCm = caderaCm;
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