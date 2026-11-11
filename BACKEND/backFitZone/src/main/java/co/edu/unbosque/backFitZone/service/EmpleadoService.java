package co.edu.unbosque.backFitZone.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.EmpleadoDTO;
import co.edu.unbosque.backFitZone.exception.ConflictoException;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Empleado;
import co.edu.unbosque.backFitZone.repository.EmpleadoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class EmpleadoService implements EmpleadoRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// Administrador puede ver todos los empleados, el gerente solo puede los de su  propia sede
	@Transactional(readOnly = true)
	public List<EmpleadoDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	@Transactional(readOnly = true)
	public EmpleadoDTO getById(Long idEmpleado) {
		rolBd.activarRol();
		Optional<Empleado> found = findById(idEmpleado);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("No existe el empleado");
		}
		Empleado empleado = found.get();
		UsuarioActual.sedePropia(empleado.getIdSede());
		return modelMapper.map(empleado, EmpleadoDTO.class);
	}

	//Se cifra la contraseña desde aqui
	@Transactional
	public String create(EmpleadoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del empleado");
		}
		if (dto.getPrimerNombre() == null || dto.getPrimerNombre().isBlank() || dto.getPrimerApellido() == null
				|| dto.getPrimerApellido().isBlank() || dto.getTelefono() == null || dto.getTelefono().isBlank()
				|| dto.getCorreo() == null || dto.getCorreo().isBlank() || dto.getIdRolEmpleado() == null
				|| dto.getIdSede() == null) {
			throw new NegocioException("Datos obligatorios no incluidos");
		}
		if (dto.getClave() == null || dto.getClave().length() < 8 || dto.getClave().length() > 72) {
			throw new NegocioException("La contraseña debe tener entre 8 y 72 caracteres");
		}

		Empleado empleado = modelMapper.map(dto, Empleado.class);
		empleado.setContrasena(passwordEncoder.encode(dto.getClave()));
		Long id;

		try {
			id = save(empleado);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("empleado_correo_u")) {
				throw new ConflictoException("Ya existe un empleado con ese correo");
			}
			if (sql.getMessage().contains("empleado_correo_ck")) {
				throw new NegocioException("Formato de correo no valido");
			}
			if (sql.getMessage().contains("empleado_rol_empleado_fk")) {
				throw new NegocioException("El rol seleccionado no existe");
			}
			if (sql.getMessage().contains("empleado_sede_fk")) {
				throw new NegocioException("La sede seleccionada no existe");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno de los datos supera la longitud permitida");
			}
			throw e;
		}
		return "empleado #" + id + " creado";
	}

	@Transactional
	public String update(Long idEmpleado, EmpleadoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del empleado");
		}
		if (dto.getPrimerNombre() == null || dto.getPrimerNombre().isBlank() || dto.getPrimerApellido() == null
				|| dto.getPrimerApellido().isBlank() || dto.getTelefono() == null || dto.getTelefono().isBlank()
				|| dto.getCorreo() == null || dto.getCorreo().isBlank() || dto.getIdRolEmpleado() == null
				|| dto.getIdSede() == null) {
			throw new NegocioException(
					"Datos obligatorios no incluidos (primer nombre, primer apellido, teléfono, correo, rol y sede)");
		}

		Optional<Empleado> found = findById(idEmpleado);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El empleado que desea actualizar no existe");
		}
		Empleado empleado = found.get();
		empleado.setPrimerNombre(dto.getPrimerNombre());
		empleado.setSegundoNombre(dto.getSegundoNombre());
		empleado.setPrimerApellido(dto.getPrimerApellido());
		empleado.setSegundoApellido(dto.getSegundoApellido());
		empleado.setTelefono(dto.getTelefono());
		empleado.setCorreo(dto.getCorreo());
		empleado.setIdRolEmpleado(dto.getIdRolEmpleado());
		empleado.setIdSede(dto.getIdSede());

		try {
			update(empleado);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("empleado_correo_u")) {
				throw new ConflictoException("Ya existe un empleado con ese correo");
			}
			if (sql.getMessage().contains("empleado_correo_ck")) {
				throw new NegocioException("Formato de correo no valido");
			}
			if (sql.getMessage().contains("empleado_rol_empleado_fk")) {
				throw new NegocioException("El rol seleccionado no existe");
			}
			if (sql.getMessage().contains("empleado_sede_fk")) {
				throw new NegocioException("La sede seleccionada no existe");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno de los datos supera la longitud permitida");
			}
			throw e;
		}
		return "empleado #" + idEmpleado + " actualizado";
	}

	// sp_cambiar_estado_empleado
	@Transactional
	public String updateEstado(Long idEmpleado, EmpleadoDTO dto) {
		rolBd.activarRol();
		if (dto == null || dto.getActivo() == null) {
			throw new NegocioException("Se debe indicar si el empleado queda activo o inactivo");
		}

		if (!dto.getActivo() && UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado().equals(idEmpleado)) {
			throw new ConflictoException("No puede desactivar su propia cuenta");
		}

		Empleado empleado = new Empleado();
		empleado.setIdEmpleado(idEmpleado);
		empleado.setActivo(dto.getActivo());
		updateEstado(empleado);
		return "empleado #" + idEmpleado + (dto.getActivo() ? " activado" : " desactivado");
	}

	@Override
	public List<EmpleadoDTO> findAll() {
		return jdbc.query(
				"""
						SELECT
							e.id_empleado, e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS nombre_completo,
							e.correo, e.telefono, e.activo, e.id_rol_empleado, r.nombre AS rol, e.id_sede, s.nombre AS sede
						FROM empleado e
						INNER JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
						INNER JOIN sede s ON s.id_sede = e.id_sede
						ORDER BY nombre_completo""",
				new BeanPropertyRowMapper<>(EmpleadoDTO.class));
	}

	@Override
	public List<EmpleadoDTO> findByIdSede(Long idSede) {
		return jdbc.query(
				"""
						SELECT
							e.id_empleado, e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido)  AS nombre_completo,
							e.correo, e.telefono, e.activo, e.id_rol_empleado, r.nombre AS rol, e.id_sede, s.nombre AS sede
						FROM empleado e
						JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
						JOIN sede s ON s.id_sede = e.id_sede
						WHERE e.id_sede = ?
						ORDER BY nombre_completo""",
				new BeanPropertyRowMapper<>(EmpleadoDTO.class), idSede);
	}

	@Override
	public Optional<Empleado> findById(Long idEmpleado) {
		return jdbc
				.query("""
						SELECT
							e.id_empleado, e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS nombre_completo,
							e.telefono, e.correo, e.activo, e.id_rol_empleado, r.nombre AS rol, e.id_sede, s.nombre AS sede
						FROM empleado e
						JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
						JOIN sede s ON s.id_sede = e.id_sede
						WHERE e.id_empleado = ?""",
						new BeanPropertyRowMapper<>(Empleado.class), idEmpleado)
				.stream().findFirst();
	}

	//sp_crear_empleado
	@Override
	public Long save(Empleado empleado) {
		return jdbc.queryForObject("""
				CALL sp_crear_empleado(?::varchar, ?::varchar, ?::varchar, ?::varchar, ?::varchar, ?::varchar,
					?::varchar, ?::numeric, ?::numeric, NULL)""", Long.class,
				empleado.getPrimerNombre(), empleado.getSegundoNombre(), empleado.getPrimerApellido(),
				empleado.getSegundoApellido(), empleado.getTelefono(), empleado.getCorreo(), empleado.getContrasena(),
				empleado.getIdRolEmpleado(), empleado.getIdSede());
	}

	@Override
	public int update(Empleado empleado) {
		return jdbc.update("""
				UPDATE empleado SET primer_nombre = ?, segundo_nombre = ?, primer_apellido = ?, segundo_apellido = ?,
					telefono = ?, correo = lower(?), id_rol_empleado = ?, id_sede = ?
				WHERE id_empleado = ?""", empleado.getPrimerNombre(), empleado.getSegundoNombre(),
				empleado.getPrimerApellido(), empleado.getSegundoApellido(), empleado.getTelefono(),
				empleado.getCorreo(), empleado.getIdRolEmpleado(), empleado.getIdSede(), empleado.getIdEmpleado());
	}

	@Override
	public void updateEstado(Empleado empleado) {
		jdbc.update("CALL sp_cambiar_estado_empleado(?::numeric, ?::boolean)", empleado.getIdEmpleado(),
				empleado.getActivo());
	}
}