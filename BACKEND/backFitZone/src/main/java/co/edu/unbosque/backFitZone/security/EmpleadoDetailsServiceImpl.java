package co.edu.unbosque.backFitZone.security;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import co.edu.unbosque.backFitZone.dto.CredencialDTO;
import co.edu.unbosque.backFitZone.model.Empleado;
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
	public Optional<Empleado> findByCorreo(String correo) {
		
		 try {
		        CredencialDTO credencial = jdbc.queryForObject("""
		                SELECT id_empleado, nombre, correo, contrasena, rol, id_sede, sede
		                  FROM v_credenciales_login
		                 WHERE correo = lower(trim(?))""",
		                new BeanPropertyRowMapper<>(CredencialDTO.class),
		                correo);
		        
		        Empleado empleado = new Empleado();
		        empleado.setIdEmpleado(credencial.getIdEmpleado());
		        empleado.setNombreCompleto(credencial.getNombre());
		        empleado.setCorreo(credencial.getCorreo());
		        empleado.setContrasena(credencial.getContrasena());
		        empleado.setRol(credencial.getRol());
		        empleado.setIdSede(credencial.getIdSede());
		        empleado.setSede(credencial.getSede());
		        
		        return Optional.of(empleado);

		    } catch (EmptyResultDataAccessException e) {
		        return Optional.empty();
		    }
	}
}
