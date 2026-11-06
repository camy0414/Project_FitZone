package co.edu.unbosque.backFitZone.model;

import java.util.Collection;
import java.util.List;
import org.jspecify.annotations.Nullable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
public class Empleado implements UserDetails {

	private static final long serialVersionUID = 1L;
	private Long idEmpleado;
	private String primerNombre;
	private String segundoNombre;
	private String primerApellido;
	private String segundoApellido;
	private String telefono;
	private String correo;
	private String contrasena;
	private Boolean activo;
	private Long idRolEmpleado;
	private Long idSede;
	private String nombreCompleto;
	private String rol;
	private String sede;

	public Empleado() {
		
	}
	

	public Empleado(Long idEmpleado, String primerNombre, String segundoNombre, String primerApellido,
			String segundoApellido, String telefono, String correo, String contrasena, Boolean activo,
			Long idRolEmpleado, Long idSede, String nombreCompleto, String rol, String sede) {
		super();
		this.idEmpleado = idEmpleado;
		this.primerNombre = primerNombre;
		this.segundoNombre = segundoNombre;
		this.primerApellido = primerApellido;
		this.segundoApellido = segundoApellido;
		this.telefono = telefono;
		this.correo = correo;
		this.contrasena = contrasena;
		this.activo = activo;
		this.idRolEmpleado = idRolEmpleado;
		this.idSede = idSede;
		this.nombreCompleto = nombreCompleto;
		this.rol = rol;
		this.sede = sede;
	}


	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
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

	public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public Boolean getActivo() {
		return activo;
	}

	public void setActivo(Boolean activo) {
		this.activo = activo;
	}

	public Long getIdRolEmpleado() {
		return idRolEmpleado;
	}

	public void setIdRolEmpleado(Long idRolEmpleado) {
		this.idRolEmpleado = idRolEmpleado;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getSede() {
		return sede;
	}

	public void setSede(String sede) {
		this.sede = sede;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (rol == null || rol.isBlank()) {
			return List.of();
		}
		return List.of(new SimpleGrantedAuthority("ROLE_" + rol.trim().toUpperCase()));
	}


	@Override
	public @Nullable String getPassword() {
		// TODO Auto-generated method stub
		return contrasena;
	}


	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return correo;
	}
	@Override
	public boolean isEnabled() {
		return activo == null || activo;
	}
}
