package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;


public class Miembro {

	private Long idMiembro;
	private String telefono;
	private String correo;
	private String primerNombre;
	private String segundoNombre;
	private String primerApellido;
	private String segundoApellido;
	private Long idSede;
	private LocalDate fechaRegistro;

	public Miembro() {
	
	}

	public Miembro(Long idMiembro, String telefono, String correo, String primerNombre, String segundoNombre,
			String primerApellido, String segundoApellido, Long idSede, LocalDate fechaRegistro) {
		super();
		this.idMiembro = idMiembro;
		this.telefono = telefono;
		this.correo = correo;
		this.primerNombre = primerNombre;
		this.segundoNombre = segundoNombre;
		this.primerApellido = primerApellido;
		this.segundoApellido = segundoApellido;
		this.idSede = idSede;
		this.fechaRegistro = fechaRegistro;
	}

	public Long getIdMiembro() {
		return idMiembro;
	}

	public void setIdMiembro(Long idMiembro) {
		this.idMiembro = idMiembro;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
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

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public LocalDate getFechaRegistro() {
		return fechaRegistro;
	}

	public void setFechaRegistro(LocalDate fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
}
