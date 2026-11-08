package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import co.edu.unbosque.backFitZone.dto.InscripcionDTO;
import co.edu.unbosque.backFitZone.model.MiembroSesion;

public interface MiembroSesionRepository {

	List<InscripcionDTO> findByNumeroSesion(Long numeroSesion);

	List<InscripcionDTO> findByIdMiembro(Long idMiembro);

	//sp_registrar_inscripcion
	void inscribir(MiembroSesion inscripcion);

	// sp_marcar_asistencia
	void marcarAsistencia(MiembroSesion inscripcion);
}
