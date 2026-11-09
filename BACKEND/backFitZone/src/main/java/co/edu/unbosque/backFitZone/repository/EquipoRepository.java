package co.edu.unbosque.backFitZone.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.EquipoDTO;
import co.edu.unbosque.backFitZone.model.Equipo;

public interface EquipoRepository {

	List<EquipoDTO> findAll();

	List<EquipoDTO> findByIdSede(Long idSede);

	Optional<Equipo> findById(Long idEquipo);

	Long save(Equipo equipo);

	int update(Equipo equipo);

	LocalDate findPrimerMantenimiento(Long idEquipo);
}
