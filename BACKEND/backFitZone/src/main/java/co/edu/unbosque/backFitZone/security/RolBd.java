package co.edu.unbosque.backFitZone.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import co.edu.unbosque.backFitZone.exception.AccesoDenegadoException;
import co.edu.unbosque.backFitZone.model.Empleado;

@Component
public class RolBd {

	private static final String[] CARGOS = { "ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE" };

	@Autowired
	private JdbcTemplate jdbc;

	public void activarRol() {
		Empleado empleado = UsuarioActual.obtenerEmpleadoAutenticado();

		boolean cargoExiste = false;
		for (String cargo : CARGOS) {
			if (cargo.equals(empleado.getRol())) {
				cargoExiste = true;
				break;
			}
		}
		if (!cargoExiste) {
			throw new AccesoDenegadoException("Rol no existente: " + empleado.getRol());
		}

		jdbc.execute("SET LOCAL ROLE rol_" + empleado.getRol().toLowerCase());

		jdbc.queryForObject("SELECT set_config('fitzone.id_empleado', ?, true)", String.class,
				Long.toString(empleado.getIdEmpleado()));
	}
}
