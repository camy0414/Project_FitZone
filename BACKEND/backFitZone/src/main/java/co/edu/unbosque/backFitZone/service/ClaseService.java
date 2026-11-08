package co.edu.unbosque.backFitZone.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.ClaseDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Clase;
import co.edu.unbosque.backFitZone.repository.ClaseRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class ClaseService implements ClaseRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	// Administrador puede ver todas las clases, Gerente y recepcionista solo las de
	// su sede. Entrenador solo las que dicta
	@Transactional(readOnly = true)
	public List<ClaseDTO> getAll() {
		rolBd.activarRol();
		if (UsuarioActual.esEntrenador()) {
			return findByIdEmpleado(UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado());
		}
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	@Transactional(readOnly = true)
	public ClaseDTO getById(Long idClase) {
		rolBd.activarRol();
		Optional<Clase> found = findById(idClase);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La clase no existe");
		}
		Clase clase = found.get();
		UsuarioActual.sedePropia(clase.getIdSede());
		return modelMapper.map(clase, ClaseDTO.class);
	}

	@Transactional
	public String create(ClaseDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Ingrese los datos de la clase");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getCupoMaximo() == null
				|| dto.getIdSede() == null || dto.getIdEmpleado() == null) {
			throw new NegocioException("Datos obligatorios no ingresados");
		}
		UsuarioActual.sedePropia(dto.getIdSede());

		Clase clase = modelMapper.map(dto, Clase.class);
		Long id;
		try {
			id = save(clase);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("clase_cupo_ck")) {
				throw new NegocioException("El cupo máximo debe ser mayor que cero");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno de los datos supera la longitud permitida");
			}
			throw e;
		}
		return "clase #" + id + " creada";
	}

	@Transactional
	public String update(Long idClase, ClaseDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la clase");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getCupoMaximo() == null
				|| dto.getIdSede() == null || dto.getIdEmpleado() == null) {
			throw new NegocioException("Datos obligatorios no ingresados");
		}

		Optional<Clase> found = findById(idClase);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La clase que desea actualizar no existe");
		}
		Clase clase = found.get();
		UsuarioActual.sedePropia(clase.getIdSede());
		UsuarioActual.sedePropia(dto.getIdSede());

		clase.setNombre(dto.getNombre());
		clase.setDescripcion(dto.getDescripcion());
		clase.setCupoMaximo(dto.getCupoMaximo());
		clase.setIdSede(dto.getIdSede());
		clase.setIdEmpleado(dto.getIdEmpleado());

		try {
			update(clase);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("clase_cupo_ck")) {
				throw new NegocioException("El cupo máximo debe ser mayor que cero");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno de los datos supera la longitud permitida");
			}
			throw e;
		}
		return "clase #" + idClase + " actualizada";
	}

	@Override
	public List<ClaseDTO> findAll() {
		return jdbc.query(
				"""
						SELECT
							c.id_clase, c.nombre, c.descripcion, c.cupo_maximo, c.id_sede, s.nombre AS sede, c.id_empleado,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS entrenador
						FROM clase c
						JOIN sede s ON s.id_sede = c.id_sede
						JOIN empleado e ON e.id_empleado = c.id_empleado
						ORDER BY c.nombre""",
				new BeanPropertyRowMapper<>(ClaseDTO.class));
	}

	@Override
	public List<ClaseDTO> findByIdSede(Long idSede) {
		return jdbc.query(
				"""
						SELECT
							c.id_clase, c.nombre, c.descripcion, c.cupo_maximo, c.id_sede, s.nombre AS sede, c.id_empleado,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS entrenador
						FROM clase c
						JOIN sede s ON s.id_sede = c.id_sede
						JOIN empleado e ON e.id_empleado = c.id_empleado
						WHERE c.id_sede = ?
						ORDER BY c.nombre""",
				new BeanPropertyRowMapper<>(ClaseDTO.class), idSede);
	}

	@Override
	public List<ClaseDTO> findByIdEmpleado(Long idEmpleado) {
		return jdbc.query(
				"""
						SELECT
							c.id_clase, c.nombre, c.descripcion, c.cupo_maximo, c.id_sede, s.nombre AS sede, c.id_empleado,
							fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS entrenador
						FROM clase c
						JOIN sede s ON s.id_sede = c.id_sede
						JOIN empleado e ON e.id_empleado = c.id_empleado
						WHERE c.id_empleado = ?
						ORDER BY c.nombre""",
				new BeanPropertyRowMapper<>(ClaseDTO.class), idEmpleado);
	}

	@Override
	public Optional<Clase> findById(Long idClase) {
		return jdbc.query("""
				SELECT
					id_clase, cupo_maximo, nombre, descripcion, id_sede, id_empleado
				FROM clase
				WHERE id_clase = ?""", new BeanPropertyRowMapper<>(Clase.class), idClase).stream().findFirst();
	}

	@Override
	public Long save(Clase clase) {
		return jdbc.queryForObject("""
				INSERT INTO clase (nombre, descripcion, cupo_maximo, id_sede, id_empleado)
				VALUES (?, ?, ?, ?, ?)
				RETURNING id_clase""", Long.class, clase.getNombre(), clase.getDescripcion(), clase.getCupoMaximo(),
				clase.getIdSede(), clase.getIdEmpleado());
	}

	@Override
	public int update(Clase clase) {
		return jdbc.update("""
				UPDATE clase SET nombre = ?, descripcion = ?, cupo_maximo = ?, id_sede = ?, id_empleado = ?
				 WHERE id_clase = ?""", clase.getNombre(), clase.getDescripcion(), clase.getCupoMaximo(),
				clase.getIdSede(), clase.getIdEmpleado(), clase.getIdClase());
	}
}