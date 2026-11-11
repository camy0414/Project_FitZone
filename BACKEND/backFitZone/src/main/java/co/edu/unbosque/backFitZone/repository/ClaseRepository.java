package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.ClaseDTO;
import co.edu.unbosque.backFitZone.model.Clase;

public interface ClaseRepository {

	List<ClaseDTO> findAll();

	List<ClaseDTO> findByIdSede(Long idSede);

	List<ClaseDTO> findByIdEmpleado(Long idEmpleado);

	Optional<Clase> findById(Long idClase);

	Long save(Clase clase);

	int update(Clase clase);
}