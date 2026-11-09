package co.edu.unbosque.backFitZone.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.MembresiaPorVencerDTO;
import co.edu.unbosque.backFitZone.dto.ReporteOcupacionDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.repository.ReporteRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class ReportesService implements ReporteRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;

	@Transactional(readOnly = true)
	public List<ReporteOcupacionDTO> getOcupacion(LocalDate desde, LocalDate hasta, Long idSede) {
		rolBd.activarRol();
		if (desde == null || hasta == null) {
			throw new NegocioException("Indique el rango de fechas que se quiere consultar");
		}
		if (desde.isAfter(hasta)) {
			throw new NegocioException("La fecha inicial no puede ser mayor que la fecha final");
		}
		if (!UsuarioActual.esAdmin()) {
			idSede = UsuarioActual.sedeFiltro();
		}
		return findOcupacion(desde, hasta, idSede);
	}

	@Transactional(readOnly = true)
	public List<MembresiaPorVencerDTO> getMembresiasPorVencer(Integer dias, Long idSede) {
		rolBd.activarRol();
		if (dias == null) {
			dias = 7;
		}
		if (dias < 0 || dias > 365) {
			throw new NegocioException("SEleccione el numero de dias que desea consultar");
		}
		if (!UsuarioActual.esAdmin()) {
			idSede = UsuarioActual.sedeFiltro();
		}
		return findMembresiasPorVencer(dias, idSede);
	}

	@Override
	public List<ReporteOcupacionDTO> findOcupacion(LocalDate desde, LocalDate hasta, Long idSede) {
		return jdbc.query("""
				SELECT 
					numero_sesion, clase, 
					sede, fecha, hora_inicio, 
					cupo_maximo, inscritos, 
					asistentes, pct_ocupacion
				FROM fn_reporte_ocupacion(?::date, ?::date, ?::numeric)""",
				new BeanPropertyRowMapper<>(ReporteOcupacionDTO.class), desde, hasta, idSede);
	}

	@Override
	public List<MembresiaPorVencerDTO> findMembresiasPorVencer(Integer dias, Long idSede) {
		return jdbc.query("""
				SELECT 
					id_membresia, id_miembro, 
					miembro, telefono, 
					correo, plan, 
					fecha_fin, dias_restantes
				FROM fn_membresias_por_vencer(?::integer, ?::numeric)""",
				new BeanPropertyRowMapper<>(MembresiaPorVencerDTO.class), dias, idSede);
	}
}