package co.edu.unbosque.backFitZone.service;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.AuditoriaDTO;
import co.edu.unbosque.backFitZone.model.Auditoria;
import co.edu.unbosque.backFitZone.repository.AuditoriaRepository;
import co.edu.unbosque.backFitZone.security.RolBd;

@Service
public class AuditoriaService implements AuditoriaRepository {

	@Autowired
	private JdbcTemplate jdbc;
	@Autowired
	private RolBd rolBd;
	@Autowired
	private ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public List<AuditoriaDTO> getAll() {
		rolBd.activarRol();
		List<AuditoriaDTO> dtoList = new ArrayList<AuditoriaDTO>();
		
		for (Auditoria au : findAll()) {
			dtoList.add(modelMapper.map(au, AuditoriaDTO.class));
		}	
		return dtoList;
	}

	@Override
	public List<Auditoria> findAll() {
		return jdbc.query("""
				SELECT 
					a.id_auditoria, a.tabla, a.operacion, a.id_registro, a.rol_bd, a.id_empleado,
					fn_nombre_completo(e.primer_nombre, e.segundo_nombre, 
						e.primer_apellido, e.segundo_apellido) AS empleado,
					a.fecha
				FROM auditoria a
				LEFT JOIN empleado e ON e.id_empleado = a.id_empleado
				ORDER BY a.id_auditoria DESC
				LIMIT 1000""",
				new BeanPropertyRowMapper<>(Auditoria.class));
	}
}