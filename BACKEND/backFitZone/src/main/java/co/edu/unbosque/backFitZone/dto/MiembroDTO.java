package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MiembroDTO {

	private Long idMiembro;
	private String nombreCompleto;
	private String correo;
	private String telefono;
	private Long idSede;
	private String sede;
	private LocalDate fechaRegistro;
	private String planActual;
	//Solo al registrar
	private String primerNombre;
	//Solo al registrar
	private String segundoNombre;
	//Solo al registrar
	private String primerApellido;
	//Solo al registrar
	private String segundoApellido;
	//Solo al registrar
	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
	private InfoMedicaDTO infoMedica;

	public MiembroDTO() {
		
	}

	public MiembroDTO(Long idMiembro, String nombreCompleto, String correo, String telefono, Long idSede, String sede, LocalDate fechaRegistro, String planActual, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, InfoMedicaDTO infoMedica) {
		super();
		this.idMiembro = idMiembro;
		this.nombreCompleto = nombreCompleto;
		this.correo = correo;
		this.telefono = telefono;
		this.idSede = idSede;
		this.sede = sede;
		this.fechaRegistro = fechaRegistro;
		this.planActual = planActual;
		this.primerNombre = primerNombre;
		this.segundoNombre = segundoNombre;
		this.primerApellido = primerApellido;
		this.segundoApellido = segundoApellido;
		this.infoMedica = infoMedica;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getSede() {
		return sede;
	}

	public void setSede(String sede) {
		this.sede = sede;
	}

	public LocalDate getFechaRegistro() {
		return fechaRegistro;
	}

	public void setFechaRegistro(LocalDate fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}

	public String getPlanActual() {
		return planActual;
	}

	public void setPlanActual(String planActual) {
		this.planActual = planActual;
	}

	public String getPrimerNombre() {
		return primerNombre;
	}

	public void setPrimerNombre(String primerNombre) {
		this.primerNombre = primerNombre;
	}

	public String getSegundoNombre() {
		return segundoNombre;
	}

	public void setSegundoNombre(String segundoNombre) {
		this.segundoNombre = segundoNombre;
	}

	public String getPrimerApellido() {
		return primerApellido;
	}

	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}

	public String getSegundoApellido() {
		return segundoApellido;
	}

	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}

	public InfoMedicaDTO getInfoMedica() {
		return infoMedica;
	}

	public void setInfoMedica(InfoMedicaDTO infoMedica) {
		this.infoMedica = infoMedica;
	}
}
