package co.edu.unbosque.backFitZone.dto;

public class MedidasDTO {

	private Double cinturaCm;
	private Double pechoCm;
	private Double brazoCm;
	private Double caderaCm;

	public MedidasDTO() {
		
	}

	public MedidasDTO(Double cinturaCm, Double pechoCm, Double brazoCm, Double caderaCm) {
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
