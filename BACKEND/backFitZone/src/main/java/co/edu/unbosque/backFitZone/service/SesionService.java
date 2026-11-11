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

import co.edu.unbosque.backFitZone.dto.SesionDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Clase;
import co.edu.unbosque.backFitZone.model.Sesion;
import co.edu.unbosque.backFitZone.repository.ClaseRepository;
import co.edu.unbosque.backFitZone.repository.SesionRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class SesionService implements SesionRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private ClaseRepository claseRepo;

	// Administrador puede ver todas las clases, Gerente y recepcionista solo las de
	// su sede. Entrenador solo las que dicta
	@Transactional(readOnly = true)
	public List<SesionDTO> getAll() {
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
	public SesionDTO getById(Long numeroSesion) {
		rolBd.activarRol();
		Optional<Sesion> found = findById(numeroSesion);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La sesión no existe");
		}
		Sesion sesion = found.get();
		Clase clase = claseRepo.findById(sesion.getIdClase()).get();
		UsuarioActual.sedePropia(clase.getIdSede());

		SesionDTO dto = modelMapper.map(sesion, SesionDTO.class);
		dto.setClase(clase.getNombre());
		dto.setIdSede(clase.getIdSede());
		dto.setIdEmpleado(clase.getIdEmpleado());
		dto.setCupoMaximo(clase.getCupoMaximo());
		return dto;
	}

	@Transactional
	public String create(SesionDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la sesión");
		}
		if (dto.getIdClase() == null || dto.getFecha() == null || dto.getHoraInicio() == null
				|| dto.getHoraFin() == null) {
			throw new NegocioException("Datos obligatorios no incluidos");
		}

		Optional<Clase> clase = claseRepo.findById(dto.getIdClase());
		if (clase.isEmpty()) {
			throw new RecursoNoEncontradoException("La clase seleccionada no existe");
		}
		UsuarioActual.sedePropia(clase.get().getIdSede());

		Sesion sesion = modelMapper.map(dto, Sesion.class);
		Long id;
		try {
			id = save(sesion);
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("sesion_horas_ck")) {
				throw new NegocioException("La hora de fin debe ser mayor que la hora de inicio");
			}
			throw e;
		}
		return "sesión #" + id + " creada";
	}

	@Override
	public List<SesionDTO> findAll() {
		return jdbc.query("""
				SELECT
					numero_sesion, id_clase, clase, id_sede, sede, id_empleado, entrenador,
					fecha, hora_inicio, hora_fin, cupo_maximo, inscritos
				FROM v_sesion
				ORDER BY fecha DESC, hora_inicio""", new BeanPropertyRowMapper<>(SesionDTO.class));
	}

	@Override
	public List<SesionDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT
					numero_sesion, id_clase, clase, id_sede, sede, id_empleado, entrenador,
					fecha, hora_inicio, hora_fin, cupo_maximo, inscritos
				FROM v_sesion
				WHERE id_sede = ?
				ORDER BY fecha DESC, hora_inicio""", new BeanPropertyRowMapper<>(SesionDTO.class), idSede);
	}

	@Override
	public List<SesionDTO> findByIdEmpleado(Long idEmpleado) {
		return jdbc.query("""
				SELECT
					numero_sesion, id_clase, clase, id_sede, sede, id_empleado, entrenador,
					fecha, hora_inicio, hora_fin, cupo_maximo, inscritos
				FROM v_sesion
				WHERE id_empleado = ?
				ORDER BY fecha DESC, hora_inicio""", new BeanPropertyRowMapper<>(SesionDTO.class), idEmpleado);
	}

	@Override
	public Optional<Sesion> findById(Long numeroSesion) {
		return jdbc.query("""
				SELECT
					numero_sesion,
					hora_inicio, hora_fin,
					fecha, id_clase
				FROM sesion
				WHERE numero_sesion = ?""", new BeanPropertyRowMapper<>(Sesion.class), numeroSesion).stream()
				.findFirst();
	}

	@Override
	public Long save(Sesion sesion) {
		return jdbc.queryForObject("""
				INSERT INTO sesion (hora_inicio, hora_fin, fecha, id_clase)
					VALUES (?, ?, ?, ?)
				RETURNING numero_sesion""", Long.class, sesion.getHoraInicio(), sesion.getHoraFin(), sesion.getFecha(),
				sesion.getIdClase());
	}
}
