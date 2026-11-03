package co.edu.unbosque.backFitZone.model;


public class InfoMedica {

	private Long idMiembro;
	private String contactoEmergencia;
	private String condicionMedica;
	private String tipoSangre;

	public InfoMedica() {
		
	}

	public InfoMedica(Long idMiembro, String contactoEmergencia, String condicionMedica, String tipoSangre) {
		super();
		this.idMiembro = idMiembro;
		this.contactoEmergencia = contactoEmergencia;
		this.condicionMedica = condicionMedica;
		this.tipoSangre = tipoSangre;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public String getContactoEmergencia() {
		return contactoEmergencia;
	}

	public void setContactoEmergencia(String contactoEmergencia) {
		this.contactoEmergencia = contactoEmergencia;
	}

	public String getCondicionMedica() {
		return condicionMedica;
	}

	public void setCondicionMedica(String condicionMedica) {
		this.condicionMedica = condicionMedica;
	}

	public String getTipoSangre() {
		return tipoSangre;
	}

	public void setTipoSangre(String tipoSangre) {
		this.tipoSangre = tipoSangre;
	}
}
