package co.edu.unbosque.backFitZone.service;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.unbosque.backFitZone.dto.MetodoPagoDTO;
import co.edu.unbosque.backFitZone.dto.RolEmpleadoDTO;
import co.edu.unbosque.backFitZone.dto.TipoEquipoDTO;
import co.edu.unbosque.backFitZone.dto.TipoPlanDTO;
import co.edu.unbosque.backFitZone.model.MetodoPago;
import co.edu.unbosque.backFitZone.model.RolEmpleado;
import co.edu.unbosque.backFitZone.model.TipoEquipo;
import co.edu.unbosque.backFitZone.model.TipoPlan;
import co.edu.unbosque.backFitZone.repository.CatalogosRepository;
import co.edu.unbosque.backFitZone.security.RolBd;

@Service
public class CatalogosService implements CatalogosRepository {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RolBd rolBd;
	
	@Autowired
	private ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public List<TipoPlanDTO> getAllTipoPlan() {
		rolBd.activarRol();
		List<TipoPlanDTO> dtoList = new ArrayList<>();
		
		for (TipoPlan tipoPlan : findAllTipoPlan()) {
			dtoList.add(modelMapper.map(tipoPlan, TipoPlanDTO.class));
		}
		return dtoList;
	}

	@Transactional(readOnly = true)
	public List<MetodoPagoDTO> getAllMetodoPago() {
		rolBd.activarRol();
		List<MetodoPagoDTO> dtoList = new ArrayList<>();
		
		for (MetodoPago mp : findAllMetodoPago()) {
			dtoList.add(modelMapper.map(mp, MetodoPagoDTO.class));
		}
		
		return dtoList;
	}

	@Transactional(readOnly = true)
	public List<RolEmpleadoDTO> getAllRolEmpleado() {
		rolBd.activarRol();
		List<RolEmpleadoDTO> dtoList = new ArrayList<>();
		
		for (RolEmpleado re : findAllRolEmpleado()) {
			dtoList.add(modelMapper.map(re, RolEmpleadoDTO.class));
		}
		return dtoList;
	}

	@Transactional(readOnly = true)
	public List<TipoEquipoDTO> getAllTipoEquipo() {
		rolBd.activarRol();
		List<TipoEquipoDTO> dtoList = new ArrayList<>();
		
		for (TipoEquipo te : findAllTipoEquipo()) {
			dtoList.add(modelMapper.map(te, TipoEquipoDTO.class));
		}
		return dtoList;
	}

	@Override
	public List<TipoPlan> findAllTipoPlan() {
		return jdbc.query("SELECT id_tipo_plan, nombre FROM tipo_plan ORDER BY id_tipo_plan",
				new BeanPropertyRowMapper<>(TipoPlan.class));
	}

	@Override
	public List<MetodoPago> findAllMetodoPago() {
		return jdbc.query("SELECT id_metodo_pago, nombre FROM metodo_pago ORDER BY nombre",
				new BeanPropertyRowMapper<>(MetodoPago.class));
	}

	@Override
	public List<RolEmpleado> findAllRolEmpleado() {
		return jdbc.query("SELECT id_rol_empleado, nombre FROM rol_empleado",
				new BeanPropertyRowMapper<>(RolEmpleado.class));
	}

	@Override
	public List<TipoEquipo> findAllTipoEquipo() {
		return jdbc.query("SELECT id_tipo_equipo, nombre FROM tipo_equipo ORDER BY nombre",
				new BeanPropertyRowMapper<>(TipoEquipo.class));
	}
}