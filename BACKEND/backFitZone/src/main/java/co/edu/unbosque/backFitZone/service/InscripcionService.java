package co.edu.unbosque.backFitZone.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.InscripcionDTO;
import co.edu.unbosque.backFitZone.exception.AccesoDenegadoException;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Clase;
import co.edu.unbosque.backFitZone.model.MiembroSesion;
import co.edu.unbosque.backFitZone.model.Sesion;
import co.edu.unbosque.backFitZone.repository.ClaseRepository;
import co.edu.unbosque.backFitZone.repository.MiembroSesionRepository;
import co.edu.unbosque.backFitZone.repository.SesionRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class InscripcionService implements MiembroSesionRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private SesionRepository sesionRepo;

	@Autowired
	private ClaseRepository claseRepo;

	// Miembros inscritos en una sesion
	@Transactional(readOnly = true)
	public List<InscripcionDTO> getBySesion(Long numeroSesion) {
		rolBd.activarRol();
		Clase clase = claseDeSesion(numeroSesion);
		UsuarioActual.sedePropia(clase.getIdSede());
		if (UsuarioActual.esEntrenador()
				&& !clase.getIdEmpleado().equals(UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado())) {
			throw new AccesoDenegadoException("Solo puede ver las incripciones a su propia clase");
		}
		return findByNumeroSesion(numeroSesion);
	}

	@Transactional
	public String create(Long numeroSesion, InscripcionDTO dto) {
		rolBd.activarRol();
		if (dto == null || dto.getIdMiembro() == null) {
			throw new NegocioException("Seleccione el miembro a inscribir");
		}
		Clase clase = claseDeSesion(numeroSesion);
		UsuarioActual.sedePropia(clase.getIdSede());

		MiembroSesion inscripcion = new MiembroSesion();
		inscripcion.setNumeroSesion(numeroSesion);
		inscripcion.setIdMiembro(dto.getIdMiembro());
		inscribir(inscripcion);
		return "miembro #" + dto.getIdMiembro() + " inscrito en la sesión #" + numeroSesion + " para la clase "
				+ clase.getNombre();
	}

	@Transactional
	public String updateAsistencia(Long numeroSesion, InscripcionDTO dto) {
		rolBd.activarRol();
		if (dto == null || dto.getIdMiembro() == null || dto.getAsistio() == null) {
			throw new NegocioException("Seleccione el miembro y/o indique si asistió o no");
		}
		Clase clase = claseDeSesion(numeroSesion);
		if (UsuarioActual.esEntrenador()
				&& !clase.getIdEmpleado().equals(UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado())) {
			throw new AccesoDenegadoException("Solo puede marcar la asistencia de sus clases");
		}

		MiembroSesion inscripcion = new MiembroSesion();
		inscripcion.setNumeroSesion(numeroSesion);
		inscripcion.setIdMiembro(dto.getIdMiembro());
		inscripcion.setAsistio(dto.getAsistio());
		marcarAsistencia(inscripcion);
		return "asistencia del miembro #" + dto.getIdMiembro() + " en la sesión #" + numeroSesion
				+ (dto.getAsistio() ? " marcada" : " desmarcada");
	}

	private Clase claseDeSesion(Long numeroSesion) {
		Optional<Sesion> sesion = sesionRepo.findById(numeroSesion);
		if (sesion.isEmpty()) {
			throw new RecursoNoEncontradoException("La sesión no existe");
		}
		return claseRepo.findById(sesion.get().getIdClase()).get();
	}

	@Override
	public List<InscripcionDTO> findByNumeroSesion(Long numeroSesion) {
		return jdbc.query(
				"""
						SELECT
							ms.numero_sesion, ms.id_miembro,
							fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido) AS miembro,
							ms.fecha_inscripcion, ms.asistio
						FROM miembro_sesion ms
						JOIN miembro m ON m.id_miembro = ms.id_miembro
						WHERE ms.numero_sesion = ?
						ORDER BY miembro""",
				new BeanPropertyRowMapper<>(InscripcionDTO.class), numeroSesion);
	}

	@Override
	public List<InscripcionDTO> findByIdMiembro(Long idMiembro) {
		return jdbc.query("""
				SELECT
					ms.numero_sesion, ms.id_miembro, ms.fecha_inscripcion, ms.asistio,
				  	v.clase, v.sede, v.fecha,
				    to_char(v.hora_inicio, 'HH24:MI') AS hora_inicio,
				    to_char(v.hora_fin, 'HH24:MI') AS hora_fin
				FROM miembro_sesion ms
				JOIN v_sesion v ON v.numero_sesion = ms.numero_sesion
				WHERE ms.id_miembro = ?
				ORDER BY v.fecha DESC, v.hora_inicio DESC""", new BeanPropertyRowMapper<>(InscripcionDTO.class),
				idMiembro);
	}

	@Override
	public void inscribir(MiembroSesion inscripcion) {
		jdbc.update("CALL sp_registrar_inscripcion(?::numeric, ?::numeric)", inscripcion.getNumeroSesion(),
				inscripcion.getIdMiembro());
	}

	@Override
	public void marcarAsistencia(MiembroSesion inscripcion) {
		jdbc.update("CALL sp_marcar_asistencia(?::numeric, ?::numeric, ?::boolean)", inscripcion.getNumeroSesion(),
				inscripcion.getIdMiembro(), inscripcion.getAsistio());
	}
}