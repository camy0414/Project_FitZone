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

import co.edu.unbosque.backFitZone.dto.InfoMedicaDTO;
import co.edu.unbosque.backFitZone.dto.MiembroDTO;
import co.edu.unbosque.backFitZone.dto.MiembroDetalleDTO;
import co.edu.unbosque.backFitZone.exception.ConflictoException;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.InfoMedica;
import co.edu.unbosque.backFitZone.model.Miembro;
import co.edu.unbosque.backFitZone.repository.MembresiaRepository;
import co.edu.unbosque.backFitZone.repository.MiembroRepository;
import co.edu.unbosque.backFitZone.repository.MiembroSesionRepository;
import co.edu.unbosque.backFitZone.repository.PagoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class MiembroService implements MiembroRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private MembresiaRepository membresiaRepo;

	@Autowired
	private PagoRepository pagoRepo;

	@Autowired
	private MiembroSesionRepository miembroSesionRepo;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	//Todos los miembros de una sede
	@Transactional(readOnly = true)
	public List<MiembroDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (UsuarioActual.esEntrenador()) {
			return findBasicoByIdSede(idSede);
		}
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	//Todos los miembros de todas las sedes
	@Transactional(readOnly = true)
	public List<MiembroDTO> getMiembrosCadena() {
		rolBd.activarRol();
		return findAll();
	}

	@Transactional(readOnly = true)
	public MiembroDetalleDTO getDetalle(Long idMiembro) {
		rolBd.activarRol();
		Optional<Miembro> found = findById(idMiembro);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro no existe");
		}
		Miembro miembro = found.get();
		UsuarioActual.sedePropia(miembro.getIdSede());

		MiembroDTO miembroDTO = modelMapper.map(miembro, MiembroDTO.class);
		Optional<MiembroDTO> vista = findVistaById(idMiembro);
		if (vista.isPresent()) {
			miembroDTO.setNombreCompleto(vista.get().getNombreCompleto());
			miembroDTO.setSede(vista.get().getSede());
			miembroDTO.setPlanActual(vista.get().getPlanActual());
		}

		MiembroDetalleDTO detalle = new MiembroDetalleDTO();
		detalle.setMiembro(miembroDTO);
		Optional<InfoMedica> info = findInfoMedica(idMiembro);
		if (info.isPresent()) {
			detalle.setInfoMedica(modelMapper.map(info.get(), InfoMedicaDTO.class));
		}
		detalle.setMembresias(membresiaRepo.findByIdMiembro(idMiembro));
		detalle.setPagos(pagoRepo.findByIdMiembro(idMiembro));
		detalle.setInscripciones(miembroSesionRepo.findByIdMiembro(idMiembro));
		return detalle;
	}

	//utiliza sp_registrar_miembro para crear miembro con info medica opcional
	@Transactional
	public String create(MiembroDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos del nuevo miembro");
		}
		if (dto.getPrimerNombre() == null || dto.getPrimerNombre().isBlank() || dto.getPrimerApellido() == null 
			|| dto.getPrimerApellido().isBlank() || dto.getTelefono() == null || dto.getTelefono().isBlank()
			|| dto.getCorreo() == null || dto.getCorreo().isBlank() || dto.getIdSede() == null) {
			throw new NegocioException("Datos obligatorios no incluidos (primer nombre, primer apellido, teléfono, correo y sede)");
		}
		UsuarioActual.sedePropia(dto.getIdSede());

		Miembro miembro = modelMapper.map(dto, Miembro.class);
		Long id;
		try {
			id = save(miembro, dto.getInfoMedica());
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("miembro_correo_ck")) {
				throw new NegocioException("El correo no tiene un formato válido");
			}
			if (sql.getMessage().contains("info_medica_tipo_sangre_ck")) {
				throw new NegocioException("Tipo de sangre inválido (A+, A-, B+, B-, AB+, AB-, O+ u O-)");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno o varios datos superan la cantidad de caracteres");
			}
			throw e;
		}
		return "miembro #" + id + " registrado" + (dto.getInfoMedica() != null ? " con su información médica" : "");
	}

	@Transactional
	public String update(Long idMiembro, MiembroDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Ingrese los datos a actualizar");
		}
		if (dto.getPrimerNombre() == null || dto.getPrimerNombre().isBlank()
				|| dto.getPrimerApellido() == null || dto.getPrimerApellido().isBlank()
				|| dto.getTelefono() == null || dto.getTelefono().isBlank()
				|| dto.getCorreo() == null || dto.getCorreo().isBlank()) {
			throw new NegocioException("Datos obligatorios no incluidos (primer nombre, primer apellido, teléfono y correo)");
		}
		InfoMedicaDTO info = dto.getInfoMedica();
		if (info != null && (info.getContactoEmergencia() == null || info.getContactoEmergencia().isBlank()
				|| info.getTipoSangre() == null || info.getTipoSangre().isBlank())) {
			throw new NegocioException("La información médica necesita contacto de emergencia y tipo de sangre");
		}

		Optional<Miembro> found = findById(idMiembro);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro no existe");
		}
		Miembro miembro = found.get();
		UsuarioActual.sedePropia(miembro.getIdSede());

		miembro.setPrimerNombre(dto.getPrimerNombre());
		miembro.setSegundoNombre(dto.getSegundoNombre());
		miembro.setPrimerApellido(dto.getPrimerApellido());
		miembro.setSegundoApellido(dto.getSegundoApellido());
		miembro.setTelefono(dto.getTelefono());
		miembro.setCorreo(dto.getCorreo());
		if (UsuarioActual.esAdmin() && dto.getIdSede() != null) {
			miembro.setIdSede(dto.getIdSede());
		}

		try {
			update(miembro);
			if (info != null) {
				saveInfoMedica(idMiembro, info);
			}
		} catch (DataIntegrityViolationException e) {
			SQLException sql = (SQLException) e.getMostSpecificCause();
			if (sql.getMessage().contains("miembro_correo_u")) {
				throw new ConflictoException("Ya existe un miembro con ese correo");
			}
			if (sql.getMessage().contains("miembro_correo_ck")) {
				throw new NegocioException("El correo no tiene un formato valido");
			}
			if (sql.getMessage().contains("miembro_sede_fk")) {
				throw new NegocioException("Seleccione una sede valida");
			}
			if (sql.getMessage().contains("info_medica_tipo_sangre_ck")) {
				throw new NegocioException("Tipo de sangre invalido (A+, A-, B+, B-, AB+, AB-, O+ u O-)");
			}
			if ("22001".equals(sql.getSQLState())) {
				throw new NegocioException("Uno o varios datos superan la cantidad de caracteres");
			}
			throw e;
		}
		return "miembro #" + idMiembro + " actualizado.";
	}



	@Override
	public Optional<Miembro> findById(Long idMiembro) {
		return jdbc.query("""
				SELECT 
					id_miembro, telefono, correo, primer_nombre, segundo_nombre, primer_apellido,
					segundo_apellido, id_sede, fecha_registro
				FROM miembro
				WHERE id_miembro = ?""",
				new BeanPropertyRowMapper<>(Miembro.class), idMiembro).stream().findFirst();
	}

	@Override
	public Optional<InfoMedica> findInfoMedica(Long idMiembro) {
		return jdbc.query("""
				SELECT id_miembro, contacto_emergencia, condicion_medica, tipo_sangre
				  FROM info_medica
				 WHERE id_miembro = ?""",
				new BeanPropertyRowMapper<>(InfoMedica.class), idMiembro).stream().findFirst();
	}

	@Override
	public List<MiembroDTO> findAll() {
		return jdbc.query("""
				SELECT 
					id_miembro, nombre_completo, correo, 
					telefono, id_sede, sede, fecha_registro, plan_actual
				FROM v_miembro
				ORDER BY nombre_completo""",
				new BeanPropertyRowMapper<>(MiembroDTO.class));
	}

	@Override
	public List<MiembroDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT 
				id_miembro, nombre_completo, correo, 
				telefono, id_sede, sede, fecha_registro, plan_actual
				FROM v_miembro
				WHERE id_sede = ?
				ORDER BY nombre_completo""",
				new BeanPropertyRowMapper<>(MiembroDTO.class), idSede);
	}

	@Override
	public Optional<MiembroDTO> findVistaById(Long idMiembro) {
		return jdbc.query("""
				SELECT 
					id_miembro, nombre_completo, correo, telefono, 
					id_sede, sede, fecha_registro, plan_actual
				FROM v_miembro
				WHERE id_miembro = ?""",
				new BeanPropertyRowMapper<>(MiembroDTO.class), idMiembro).stream().findFirst();
	}

	@Override
	public List<MiembroDTO> findBasicoByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT m.id_miembro,
				       fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido)
				           AS nombre_completo,
				       m.id_sede, s.nombre AS sede
				  FROM miembro m
				  JOIN sede s ON s.id_sede = m.id_sede
				 WHERE m.id_sede = ?
				 ORDER BY nombre_completo""",
				new BeanPropertyRowMapper<>(MiembroDTO.class), idSede);
	}

	@Override
	public Optional<MiembroDTO> findBasicoById(Long idMiembro) {
		return jdbc.query("""
				SELECT m.id_miembro,
				       fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido)
				           AS nombre_completo,
				       m.id_sede, s.nombre AS sede
				  FROM miembro m
				  JOIN sede s ON s.id_sede = m.id_sede
				 WHERE m.id_miembro = ?""",
				new BeanPropertyRowMapper<>(MiembroDTO.class), idMiembro).stream().findFirst();
	}

	/** El tipo de sangre se pasa a mayusculas en el SQL (upper). */
	@Override
	public Long save(Miembro m, InfoMedicaDTO info) {
		return jdbc.queryForObject("""
				CALL sp_registrar_miembro(?::varchar, ?::varchar, ?::varchar, ?::varchar, ?::varchar, ?::varchar,
				                          ?::numeric, ?::varchar, upper(?::varchar), ?::varchar, NULL)""", Long.class,
				m.getPrimerNombre(), m.getSegundoNombre(), m.getPrimerApellido(), m.getSegundoApellido(),
				m.getTelefono(), m.getCorreo(), m.getIdSede(),
				info == null ? null : info.getContactoEmergencia(),
				info == null ? null : info.getTipoSangre(),
				info == null ? null : info.getCondicionMedica());
	}

	@Override
	public int update(Miembro m) {
		return jdbc.update("""
				UPDATE miembro
				   SET primer_nombre = ?, segundo_nombre = ?, primer_apellido = ?, segundo_apellido = ?,
				       telefono = ?, correo = lower(?), id_sede = ?
				 WHERE id_miembro = ?""",
				m.getPrimerNombre(), m.getSegundoNombre(), m.getPrimerApellido(), m.getSegundoApellido(),
				m.getTelefono(), m.getCorreo(), m.getIdSede(), m.getIdMiembro());
	}

	@Override
	public void saveInfoMedica(Long idMiembro, InfoMedicaDTO info) {
		jdbc.update("""
				INSERT INTO info_medica (id_miembro, contacto_emergencia, tipo_sangre, condicion_medica)
				VALUES (?, ?, upper(?), ?)
				ON CONFLICT (id_miembro) DO UPDATE
				   SET contacto_emergencia = EXCLUDED.contacto_emergencia,
				       tipo_sangre         = EXCLUDED.tipo_sangre,
				       condicion_medica    = EXCLUDED.condicion_medica""",
				idMiembro, info.getContactoEmergencia(), info.getTipoSangre(), info.getCondicionMedica());
	}
}