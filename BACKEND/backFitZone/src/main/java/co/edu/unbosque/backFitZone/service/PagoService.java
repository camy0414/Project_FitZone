package co.edu.unbosque.backFitZone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.PagoDTO;
import co.edu.unbosque.backFitZone.repository.PagoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class PagoService implements PagoRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	//Todos los pagos 
	@Transactional(readOnly = true)
	public List<PagoDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		if (idSede == null) {
			return findAll();
		}
		return findByIdSede(idSede);
	}

	@Override
	public List<PagoDTO> findAll() {
		return jdbc.query("""
				SELECT id_pago, id_miembro, miembro, id_sede, metodo, monto, fecha_pago
				  FROM v_pago
				 ORDER BY fecha_pago DESC, id_pago DESC""",
				new BeanPropertyRowMapper<>(PagoDTO.class));
	}

	@Override
	public List<PagoDTO> findByIdSede(Long idSede) {
		return jdbc.query("""
				SELECT id_pago, id_miembro, miembro, id_sede, metodo, monto, fecha_pago
				  FROM v_pago
				 WHERE id_sede = ?
				 ORDER BY fecha_pago DESC, id_pago DESC""",
				new BeanPropertyRowMapper<>(PagoDTO.class), idSede);
	}

	@Override
	public List<PagoDTO> findByIdMiembro(Long idMiembro) {
		return jdbc.query("""
				SELECT id_pago, id_miembro, miembro, id_sede, metodo, monto, fecha_pago
				  FROM v_pago
				 WHERE id_miembro = ?
				 ORDER BY fecha_pago DESC, id_pago DESC""",
				new BeanPropertyRowMapper<>(PagoDTO.class), idMiembro);
	}
}
