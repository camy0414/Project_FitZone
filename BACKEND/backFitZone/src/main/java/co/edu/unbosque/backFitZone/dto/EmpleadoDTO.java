package co.edu.unbosque.backFitZone.dto;

public class EmpleadoDTO {

	private Long idEmpleado;
	private String nombreCompleto;
	private String correo;
	private String telefono;
	private String rol;
	private Long idSede;
	private String sede;
	private Boolean activo;
	private String primerNombre;
	private String segundoNombre;
	private String primerApellido;
	private String segundoApellido;
	private Long idRolEmpleado;
	private String clave;

	public EmpleadoDTO() {
		
	}

	public EmpleadoDTO(Long idEmpleado, String nombreCompleto, String correo, String telefono, String rol, Long idSede, String sede, Boolean activo, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, Long idRolEmpleado, String clave) {
		super();
		this.idEmpleado = idEmpleado;
		this.nombreCompleto = nombreCompleto;
		this.correo = correo;
		this.telefono = telefono;
		this.rol = rol;
		this.idSede = idSede;
		this.sede = sede;
		this.activo = activo;
		this.primerNombre = primerNombre;
		this.segundoNombre = segundoNombre;
		this.primerApellido = primerApellido;
		this.segundoApellido = segundoApellido;
		this.idRolEmpleado = idRolEmpleado;
		this.clave = clave;
	}

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
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

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
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

	public Boolean getActivo() {
		return activo;
	}

	public void setActivo(Boolean activo) {
		this.activo = activo;
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

	public Long getIdRolEmpleado() {
		return idRolEmpleado;
	}

	public void setIdRolEmpleado(Long idRolEmpleado) {
		this.idRolEmpleado = idRolEmpleado;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}
}
