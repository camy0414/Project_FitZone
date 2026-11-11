package co.edu.unbosque.backFitZone.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.EquipoDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Equipo;
import co.edu.unbosque.backFitZone.repository.EquipoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class EquipoService implements EquipoRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	// El admin ve todos los equipos, el gerente solo los de su sede
	@Transactional(readOnly = true)
	public List<EquipoDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	@Transactional(readOnly = true)
	public EquipoDTO getById(Long idEquipo) {
		rolBd.activarRol();
		Optional<Equipo> found = findById(idEquipo);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El equipo no existe");
		}
		Equipo equipo = found.get();
		UsuarioActual.sedePropia(equipo.getIdSede());
		return modelMapper.map(equipo, EquipoDTO.class);
	}

	@Transactional
	public String create(EquipoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del equipo");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getIdTipoEquipo() == null
				|| dto.getIdSede() == null || dto.getFechaAdquisicion() == null) {
			throw new NegocioException("Datos obligatorios no incluidos");
		}
		if (dto.getFechaAdquisicion().isAfter(LocalDate.now())) {
			throw new NegocioException("La fecha de adquisición no puede ser futura");
		}
		UsuarioActual.sedePropia(dto.getIdSede());

		Equipo equipo = modelMapper.map(dto, Equipo.class);
		Long id;
		try {
			id = save(equipo);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("equipo_tipo_equipo_fk")) {
				throw new NegocioException("El tipo de equipo seleccionado no existe");
			}
			if (sql.getMessage().contains("equipo_sede_fk")) {
				throw new NegocioException("La sede seleccionada no existe");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("El nombre del equipo supera la longitud permitida");
			}
			throw e;
		}
		return "equipo #" + id + " creado";
	}

	@Transactional
	public String update(Long idEquipo, EquipoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del equipo");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getIdTipoEquipo() == null
				|| dto.getIdSede() == null || dto.getFechaAdquisicion() == null) {
			throw new NegocioException("Datos obligatorios no incluidos");
		}
		if (dto.getFechaAdquisicion().isAfter(LocalDate.now())) {
			throw new NegocioException("La fecha de adquisición no puede ser futura");
		}

		Optional<Equipo> found = findById(idEquipo);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El equipo que desea actualizar no existe");
		}
		Equipo equipo = found.get();
		UsuarioActual.sedePropia(equipo.getIdSede());
		UsuarioActual.sedePropia(dto.getIdSede());
		LocalDate primerMantenimiento = findPrimerMantenimiento(idEquipo);
		if (primerMantenimiento != null && dto.getFechaAdquisicion().isAfter(primerMantenimiento)) {
			throw new NegocioException("La fecha de adquisición no puede ser posterior al primer mantenimiento ("
					+ primerMantenimiento + ")");
		}

		equipo.setNombre(dto.getNombre());
		equipo.setIdTipoEquipo(dto.getIdTipoEquipo());
		equipo.setIdSede(dto.getIdSede());
		equipo.setFechaAdquisicion(dto.getFechaAdquisicion());

		try {
			update(equipo);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("equipo_tipo_equipo_fk")) {
				throw new NegocioException("El tipo de equipo seleccionado no existe");
			}
			if (sql.getMessage().contains("equipo_sede_fk")) {
				throw new NegocioException("La sede seleccionada no existe");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("El nombre del equipo supera la longitud permitida");
			}
			throw e;
		}
		return "equipo #" + idEquipo + " actualizado";
	}

	@Override
	public List<EquipoDTO> findAll() {
		return jdbc.query("""
				SELECT
					id_equipo, nombre,
					tipo, id_sede,
					sede, fecha_adquisicion,
					estado
				FROM v_equipo
				ORDER BY sede, nombre""", new BeanPropertyRowMapper<>(EquipoDTO.class));
	}

	@Override
	public List<EquipoDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT
					id_equipo, nombre,
					tipo, id_sede,
					sede, fecha_adquisicion,
					estado
				FROM v_equipo
				WHERE id_sede = ?
				ORDER BY nombre""", new BeanPropertyRowMapper<>(EquipoDTO.class), idSede);
	}

	@Override
	public Optional<Equipo> findById(Long idEquipo) {
		return jdbc.query("""
				SELECT
					id_equipo,
					fecha_adquisicion,
					nombre,
					id_tipo_equipo,
					id_sede
				FROM equipo
				WHERE id_equipo = ?""", new BeanPropertyRowMapper<>(Equipo.class), idEquipo).stream().findFirst();
	}

	@Override
	public Long save(Equipo equipo) {
		return jdbc.queryForObject("""
				INSERT INTO equipo (fecha_adquisicion, nombre, id_tipo_equipo, id_sede)
					VALUES (?, ?, ?, ?)
				RETURNING id_equipo""", Long.class, equipo.getFechaAdquisicion(), equipo.getNombre(),
				equipo.getIdTipoEquipo(), equipo.getIdSede());
	}

	@Override
	public int update(Equipo equipo) {
		return jdbc.update("""
				UPDATE equipo SET nombre = ?, id_tipo_equipo = ?, id_sede = ?, fecha_adquisicion = ?
					WHERE id_equipo = ?""", equipo.getNombre(), equipo.getIdTipoEquipo(), equipo.getIdSede(),
				equipo.getFechaAdquisicion(), equipo.getIdEquipo());
	}

	@Override
	public LocalDate findPrimerMantenimiento(Long idEquipo) {
		return jdbc.queryForObject("""
				SELECT MIN(fecha_mantenimiento)
				FROM mantenimiento_equipo
				WHERE id_equipo = ?""", LocalDate.class, idEquipo);
	}
}