package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.model.Rutina;

public interface RutinaRepository {

	List<Rutina> findAll();

	List<Rutina> findByIdSede(Long idSede);

	List<Rutina> findByIdMiembro(Long idMiembro);

	Optional<Rutina> findById(String idRutina);

	String save(Rutina rutina);

	void update(Rutina rutina);

	void updateEstado(Rutina rutina);
}