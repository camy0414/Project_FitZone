package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.MantenimientoDTO;
import co.edu.unbosque.backFitZone.model.MantenimientoEquipo;

public interface MantenimientoRepository {

	List<MantenimientoDTO> findAll();

	List<MantenimientoDTO> findByIdSede(Long idSede);

	List<MantenimientoDTO> findByIdEquipo(Long idEquipo);

	Optional<MantenimientoEquipo> findById(Long numeroMantenimiento);

	Long save(MantenimientoEquipo mantenimiento);
}
