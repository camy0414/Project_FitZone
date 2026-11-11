package co.edu.unbosque.backFitZone.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.SedeDTO;
import co.edu.unbosque.backFitZone.exception.ConflictoException;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Sede;
import co.edu.unbosque.backFitZone.repository.SedeRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class SedeService implements SedeRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	// El admin ve todas las sedes, los demas cargos solo la suya
	@Transactional(readOnly = true)
	public List<SedeDTO> getAll() {
		rolBd.activarRol();
		List<SedeDTO> dtoList = new ArrayList<>();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			for (Sede sede : findAll()) {
				dtoList.add(modelMapper.map(sede, SedeDTO.class));
			}
			return dtoList;
		}
		Optional<Sede> found = findById(idSede);
		if (found.isPresent()) {
			dtoList.add(modelMapper.map(found.get(), SedeDTO.class));
		}
		return dtoList;
	}

	@Transactional(readOnly = true)
	public SedeDTO getById(Long idSede) {
		rolBd.activarRol();
		Optional<Sede> found = findById(idSede);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La sede no existe");
		}
		return modelMapper.map(found.get(), SedeDTO.class);
	}

	// sp_crear_sede
	@Transactional
	public String create(SedeDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la sede");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getDireccion() == null
				|| dto.getDireccion().isBlank() || dto.getTelefono() == null || dto.getTelefono().isBlank()) {
			throw new NegocioException("Datos obligatorios no incluidos (nombre, dirección y teléfono)");
		}

		Sede sede = modelMapper.map(dto, Sede.class);
		Long id;
		try {
			id = save(sede);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException(
						"Uno de los datos supera la longitud permitida (nombre 50, dirección 100, teléfono 20)");
			}
			throw e;
		}
		return "sede #" + id + " creada";
	}

	@Transactional
	public String update(Long idSede, SedeDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la sede");
		}
		if (dto.getNombre() == null || dto.getNombre().isBlank() || dto.getDireccion() == null
				|| dto.getDireccion().isBlank() || dto.getTelefono() == null || dto.getTelefono().isBlank()) {
			throw new NegocioException("Datos obligatorios no incluidos (nombre, dirección y teléfono)");
		}

		Optional<Sede> found = findById(idSede);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La sede que desea actualizar no existe");
		}
		Sede sede = found.get();
		sede.setNombre(dto.getNombre());
		sede.setDireccion(dto.getDireccion());
		sede.setTelefono(dto.getTelefono());

		try {
			update(sede);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("sede_nombre_u")) {
				throw new ConflictoException("Ya existe una sede con ese nombre");
			}
			if (sql.getMessage().contains("sede_direccion_u")) {
				throw new ConflictoException("Ya existe una sede con esa dirección");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException(
						"Uno de los datos supera la longitud permitida (nombre 50, dirección 100, teléfono 20)");
			}
			throw e;
		}
		return "sede #" + idSede + " actualizada";
	}

	@Override
	public List<Sede> findAll() {
		return jdbc.query("""
				SELECT
					id_sede, telefono, nombre, direccion
				FROM sede ORDER BY nombre""", new BeanPropertyRowMapper<>(Sede.class));
	}

	@Override
	public Optional<Sede> findById(Long idSede) {
		return jdbc.query("""
				SELECT
					id_sede, telefono, nombre, direccion
				FROM sede
				WHERE id_sede = ?""", new BeanPropertyRowMapper<>(Sede.class), idSede).stream().findFirst();
	}

	@Override
	public Long save(Sede sede) {
		return jdbc.queryForObject("CALL sp_crear_sede(?::varchar, ?::varchar, ?::varchar, NULL)", Long.class,
				sede.getNombre(), sede.getDireccion(), sede.getTelefono());
	}

	@Override
	public int update(Sede sede) {
		return jdbc.update("UPDATE sede SET nombre = ?, direccion = ?, telefono = ? WHERE id_sede = ?",
				sede.getNombre(), sede.getDireccion(), sede.getTelefono(), sede.getIdSede());
	}
}