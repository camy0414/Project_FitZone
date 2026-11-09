package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.SesionDTO;
import co.edu.unbosque.backFitZone.model.Sesion;

public interface SesionRepository {

	List<SesionDTO> findAll();

	List<SesionDTO> findByIdSede(Long idSede);

	List<SesionDTO> findByIdEmpleado(Long idEmpleado);

	Optional<Sesion> findById(Long numeroSesion);

	Long save(Sesion sesion);
}
