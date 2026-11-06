package co.edu.unbosque.backFitZone.dto;

public class InfoMedicaDTO {

	private String contactoEmergencia;
	private String tipoSangre;
	private String condicionMedica;

	public InfoMedicaDTO() {
		
	}

	public InfoMedicaDTO(String contactoEmergencia, String tipoSangre, String condicionMedica) {
		super();
		this.contactoEmergencia = contactoEmergencia;
		this.tipoSangre = tipoSangre;
		this.condicionMedica = condicionMedica;
	}

	public String getContactoEmergencia() {
		return contactoEmergencia;
	}

	public void setContactoEmergencia(String contactoEmergencia) {
		this.contactoEmergencia = contactoEmergencia;
	}

	public String getTipoSangre() {
		return tipoSangre;
	}

	public void setTipoSangre(String tipoSangre) {
		this.tipoSangre = tipoSangre;
	}

	public String getCondicionMedica() {
		return condicionMedica;
	}

	public void setCondicionMedica(String condicionMedica) {
		this.condicionMedica = condicionMedica;
	}
}
