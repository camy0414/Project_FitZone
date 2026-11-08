package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.model.Sede;

public interface SedeRepository {

	List<Sede> findAll();

	Optional<Sede> findById(Long idSede);

	Long save(Sede sede);

	int update(Sede sede);
}
