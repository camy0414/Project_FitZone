package co.edu.unbosque.backFitZone.dto;

import java.util.Collection;
import java.util.List;
import java.util.Locale;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


public class CredencialDTO implements UserDetails {

	private static final long serialVersionUID = 1L;

	private Long idEmpleado;
	private String nombre;
	private String correo;
	private String contrasena;
	private String rol;
	private Long idSede;
	private String sede;

	public CredencialDTO() {
	}

	public CredencialDTO(Long idEmpleado, String nombre, String correo, String contrasena, String rol, Long idSede,
			String sede) {
		super();
		this.idEmpleado = idEmpleado;
		this.nombre = nombre;
		this.correo = correo;
		this.contrasena = contrasena;
		this.rol = rol;
		this.idSede = idSede;
		this.sede = sede;
	}

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
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

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (rol == null) {
			return List.of();
		}
		return List.of(new SimpleGrantedAuthority("ROLE_" + rol.trim().toUpperCase(Locale.ROOT)));
	}

	@Override
	public String getPassword() {
		return contrasena;
	}

	@Override
	public String getUsername() {
		return correo;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	/** La vista solo devuelve empleados activos. */
	@Override
	public boolean isEnabled() {
		return true;
	}
}
