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

import co.edu.unbosque.backFitZone.dto.MantenimientoDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Equipo;
import co.edu.unbosque.backFitZone.model.MantenimientoEquipo;
import co.edu.unbosque.backFitZone.repository.EquipoRepository;
import co.edu.unbosque.backFitZone.repository.MantenimientoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class MantenimientoService implements MantenimientoRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private EquipoRepository equipoRepo;

	// El admin ve todos los mantenimientos, el gerente solo los de su sede
	@Transactional(readOnly = true)
	public List<MantenimientoDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	// Todos los mantenimientos de un equipo
	@Transactional(readOnly = true)
	public List<MantenimientoDTO> getByEquipo(Long idEquipo) {
		rolBd.activarRol();
		Optional<Equipo> equipo = equipoRepo.findById(idEquipo);
		if (equipo.isEmpty()) {
			throw new RecursoNoEncontradoException("El equipo no existe");
		}
		UsuarioActual.sedePropia(equipo.get().getIdSede());
		return findByIdEquipo(idEquipo);
	}

	@Transactional(readOnly = true)
	public MantenimientoDTO getById(Long numeroMantenimiento) {
		rolBd.activarRol();
		Optional<MantenimientoEquipo> found = findById(numeroMantenimiento);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El mantenimiento no existe");
		}
		MantenimientoEquipo mantenimiento = found.get();
		Equipo equipo = equipoRepo.findById(mantenimiento.getIdEquipo()).get();
		UsuarioActual.sedePropia(equipo.getIdSede());

		MantenimientoDTO dto = modelMapper.map(mantenimiento, MantenimientoDTO.class);
		dto.setEquipo(equipo.getNombre());
		dto.setIdSede(equipo.getIdSede());
		return dto;
	}

	@Transactional
	public String create(MantenimientoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del mantenimiento");
		}
		if (dto.getIdEquipo() == null || dto.getCosto() == null || dto.getFechaMantenimiento() == null) {
			throw new NegocioException("Datos obligatorios no incluidos ");
		}

		Optional<Equipo> equipo = equipoRepo.findById(dto.getIdEquipo());
		if (equipo.isEmpty()) {
			throw new RecursoNoEncontradoException("El equipo seleccionado no existe");
		}
		UsuarioActual.sedePropia(equipo.get().getIdSede());

		MantenimientoEquipo mantenimiento = modelMapper.map(dto, MantenimientoEquipo.class);
		Long id;
		try {
			id = save(mantenimiento);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("mantenimiento_equipo_costo_ck")) {
				throw new NegocioException("El costo no puede ser negativo");
			}
			if ("22003".equals(sql.getSQLState())) {
				throw new NegocioException("El costo supera el valor permitido");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("La descripción supera la longitud permitida de 100 caracteres");
			}
			throw e;
		}
		return "mantenimiento #" + id + " registrado";
	}

	@Override
	public List<MantenimientoDTO> findAll() {
		return jdbc.query("""
				SELECT
					numero_mantenimiento, id_equipo,
					equipo, id_sede,
					sede, descripcion,
					costo, fecha_mantenimiento
				FROM v_mantenimiento
				ORDER BY fecha_mantenimiento DESC""", new BeanPropertyRowMapper<>(MantenimientoDTO.class));
	}

	@Override
	public List<MantenimientoDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT
					numero_mantenimiento, id_equipo,
					equipo, id_sede,
					sede, descripcion,
					costo, fecha_mantenimiento
				FROM v_mantenimiento
				WHERE id_sede = ?
				ORDER BY fecha_mantenimiento DESC""", new BeanPropertyRowMapper<>(MantenimientoDTO.class), idSede);
	}

	@Override
	public List<MantenimientoDTO> findByIdEquipo(Long idEquipo) {
		return jdbc.query("""
				SELECT
					numero_mantenimiento, id_equipo,
					equipo, id_sede,
					sede, descripcion,
					costo, fecha_mantenimiento
				FROM v_mantenimiento
				WHERE id_equipo = ?
				ORDER BY fecha_mantenimiento DESC""", new BeanPropertyRowMapper<>(MantenimientoDTO.class), idEquipo);
	}

	@Override
	public Optional<MantenimientoEquipo> findById(Long numeroMantenimiento) {
		return jdbc.query("""
				SELECT
					numero_mantenimiento, costo,
					descripcion, fecha_mantenimiento,
					id_equipo
				FROM mantenimiento_equipo
				WHERE numero_mantenimiento = ?""", new BeanPropertyRowMapper<>(MantenimientoEquipo.class),
				numeroMantenimiento).stream().findFirst();
	}

	@Override
	public Long save(MantenimientoEquipo mantenimiento) {
		return jdbc.queryForObject("""
				INSERT INTO mantenimiento_equipo (costo, descripcion, fecha_mantenimiento, id_equipo)
					VALUES (?, ?, ?, ?)
				RETURNING numero_mantenimiento""", Long.class, mantenimiento.getCosto(), mantenimiento.getDescripcion(),
				mantenimiento.getFechaMantenimiento(), mantenimiento.getIdEquipo());
	}
}