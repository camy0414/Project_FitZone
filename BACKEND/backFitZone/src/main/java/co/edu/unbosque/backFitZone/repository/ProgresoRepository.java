package co.edu.unbosque.backFitZone.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.model.ProgresoFisico;

public interface ProgresoRepository {

	List<ProgresoFisico> findAll();

	List<ProgresoFisico> findByIdSede(Long idSede);

	List<ProgresoFisico> findByIdMiembro(Long idMiembro);

	Optional<ProgresoFisico> findById(String idProgreso);

	//Para revisar que el miembro no tenga otra medicion ese dia (idExcluir es la que se esta editando)
	boolean existsByMiembroAndFecha(Long idMiembro, LocalDate fecha, String idExcluir);

	String save(ProgresoFisico progreso);

	void update(ProgresoFisico progreso);
}
