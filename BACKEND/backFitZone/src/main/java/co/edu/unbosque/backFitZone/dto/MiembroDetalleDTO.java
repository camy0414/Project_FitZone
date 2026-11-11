package co.edu.unbosque.backFitZone.dto;

import java.util.List;

public class MiembroDetalleDTO {

	private MiembroDTO miembro;
	private InfoMedicaDTO infoMedica;
	private List<MembresiaDTO> membresias;
	private List<PagoDTO> pagos;
	private List<InscripcionDTO> inscripciones;

	public MiembroDetalleDTO() {
	}

	public MiembroDetalleDTO(MiembroDTO miembro, InfoMedicaDTO infoMedica, List<MembresiaDTO> membresias, List<PagoDTO> pagos, List<InscripcionDTO> inscripciones) {
		super();
		this.miembro = miembro;
		this.infoMedica = infoMedica;
		this.membresias = membresias;
		this.pagos = pagos;
		this.inscripciones = inscripciones;
	}

	public MiembroDTO getMiembro() {
		return miembro;
	}

	public void setMiembro(MiembroDTO miembro) {
		this.miembro = miembro;
	}

	public InfoMedicaDTO getInfoMedica() {
		return infoMedica;
	}

	public void setInfoMedica(InfoMedicaDTO infoMedica) {
		this.infoMedica = infoMedica;
	}

	public List<MembresiaDTO> getMembresias() {
		return membresias;
	}

	public void setMembresias(List<MembresiaDTO> membresias) {
		this.membresias = membresias;
	}

	public List<PagoDTO> getPagos() {
		return pagos;
	}

	public void setPagos(List<PagoDTO> pagos) {
		this.pagos = pagos;
	}

	public List<InscripcionDTO> getInscripciones() {
		return inscripciones;
	}

	public void setInscripciones(List<InscripcionDTO> inscripciones) {
		this.inscripciones = inscripciones;
	}
}
