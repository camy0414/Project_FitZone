package co.edu.unbosque.backFitZone.security;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import co.edu.unbosque.backFitZone.dto.CredencialDTO;
import co.edu.unbosque.backFitZone.repository.AuthRepository;


@Service
public class EmpleadoDetailsServiceImpl implements UserDetailsService, AuthRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Override
	public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {
		return findByCorreo(correo)
				.orElseThrow(() -> new UsernameNotFoundException("No existe un empleado activo con correo: " + correo));
	}

	@Override
	public Optional<CredencialDTO> findByCorreo(String correo) {
		return jdbc.query("""
				SELECT id_empleado, nombre, correo, contrasena, rol, id_sede, sede
				  FROM v_credenciales_login
				 WHERE correo = lower(trim(?))""",
				(rs, i) -> new CredencialDTO(
						rs.getLong("id_empleado"),
						rs.getString("nombre"),
						rs.getString("correo"),
						rs.getString("contrasena"),
						rs.getString("rol"),
						rs.getLong("id_sede"),
						rs.getString("sede")),
				correo).stream().findFirst();
	}
}
