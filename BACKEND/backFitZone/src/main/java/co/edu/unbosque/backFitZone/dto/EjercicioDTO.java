package co.edu.unbosque.backFitZone.dto;

public class EjercicioDTO {

	private String nombre;
	private String tipo;
	private Integer series;
	private Integer repeticiones;
	private Double pesoKg;
	private Integer duracionMin;
	private Integer duracionSeg;
	private Double distanciaKm;
	private String videoUrl;
	private String notas;

	public EjercicioDTO() {
		
	}

	public EjercicioDTO(String nombre, String tipo, Integer series, Integer repeticiones, Double pesoKg, Integer duracionMin, Integer duracionSeg, Double distanciaKm, String videoUrl, String notas) {
		super();
		this.nombre = nombre;
		this.tipo = tipo;
		this.series = series;
		this.repeticiones = repeticiones;
		this.pesoKg = pesoKg;
		this.duracionMin = duracionMin;
		this.duracionSeg = duracionSeg;
		this.distanciaKm = distanciaKm;
		this.videoUrl = videoUrl;
		this.notas = notas;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Integer getSeries() {
		return series;
	}

	public void setSeries(Integer series) {
		this.series = series;
	}

	public Integer getRepeticiones() {
		return repeticiones;
	}

	public void setRepeticiones(Integer repeticiones) {
		this.repeticiones = repeticiones;
	}

	public Double getPesoKg() {
		return pesoKg;
	}

	public void setPesoKg(Double pesoKg) {
		this.pesoKg = pesoKg;
	}

	public Integer getDuracionMin() {
		return duracionMin;
	}

	public void setDuracionMin(Integer duracionMin) {
		this.duracionMin = duracionMin;
	}

	public Integer getDuracionSeg() {
		return duracionSeg;
	}

	public void setDuracionSeg(Integer duracionSeg) {
		this.duracionSeg = duracionSeg;
	}

	public Double getDistanciaKm() {
		return distanciaKm;
	}

	public void setDistanciaKm(Double distanciaKm) {
		this.distanciaKm = distanciaKm;
	}

	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}

	public String getNotas() {
		return notas;
	}

	public void setNotas(String notas) {
		this.notas = notas;
	}
}