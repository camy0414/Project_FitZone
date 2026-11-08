package co.edu.unbosque.backFitZone.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.MembresiaDTO;
import co.edu.unbosque.backFitZone.dto.RenovacionDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.model.Membresia;
import co.edu.unbosque.backFitZone.model.Pago;
import co.edu.unbosque.backFitZone.repository.MembresiaRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class MembresiaService implements MembresiaRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Transactional(readOnly = true)
	public List<MembresiaDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	//sp_renovar_membresia crea la membresia y el pago
	@Transactional
	public String renovar(MembresiaDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la renovación");
		}
		if (dto.getIdMiembro() == null || dto.getIdTipoPlan() == null || dto.getIdMetodoPago() == null
				|| dto.getMonto() == null) {
			throw new NegocioException("Datos obligatorios no incluidos (miembro, plan, método de pago y monto)");
		}

		Membresia membresia = new Membresia();
		membresia.setIdMiembro(dto.getIdMiembro());
		membresia.setIdTipoPlan(dto.getIdTipoPlan());

		Pago pago = new Pago();
		pago.setIdMiembro(dto.getIdMiembro());
		pago.setIdMetodoPago(dto.getIdMetodoPago());
		pago.setMonto(dto.getMonto());

		RenovacionDTO renovacion = renovar(membresia, pago);
		return "membresía #" + renovacion.getIdMembresia() + " creada (" + renovacion.getFechaInicio() + " a "
				+ renovacion.getFechaFin() + ") y pago #" + renovacion.getIdPago() + " registrado";
	}

	@Override
	public List<MembresiaDTO> findAll() {
		return jdbc.query("""
				SELECT id_membresia, id_miembro, miembro, id_sede, plan, estado, fecha_inicio, fecha_fin
				  FROM v_membresia
				 ORDER BY fecha_inicio DESC, id_membresia DESC""",
				new BeanPropertyRowMapper<>(MembresiaDTO.class));
	}

	@Override
	public List<MembresiaDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT id_membresia, id_miembro, miembro, id_sede, plan, estado, fecha_inicio, fecha_fin
				  FROM v_membresia
				 WHERE id_sede = ?
				 ORDER BY fecha_inicio DESC, id_membresia DESC""",
				new BeanPropertyRowMapper<>(MembresiaDTO.class), idSede);
	}

	@Override
	public List<MembresiaDTO> findByIdMiembro(Long idMiembro) {
		return jdbc.query("""
				SELECT id_membresia, id_miembro, miembro, id_sede, plan, estado, fecha_inicio, fecha_fin
				  FROM v_membresia
				 WHERE id_miembro = ?
				 ORDER BY fecha_inicio DESC, id_membresia DESC""",
				new BeanPropertyRowMapper<>(MembresiaDTO.class), idMiembro);
	}

	
	@Override
	public RenovacionDTO renovar(Membresia membresia, Pago pago) {
		return jdbc.queryForObject("""
				CALL sp_renovar_membresia(?::numeric, ?::numeric, ?::numeric, ?::numeric, NULL, NULL, NULL, NULL)""",
				(rs, fila) -> new RenovacionDTO(
						rs.getLong("p_id_membresia"),
						rs.getLong("p_id_pago"),
						rs.getObject("p_fecha_inicio", LocalDate.class),
						rs.getObject("p_fecha_fin", LocalDate.class)),
				membresia.getIdMiembro(), membresia.getIdTipoPlan(), pago.getMonto(), pago.getIdMetodoPago());
	}
}
