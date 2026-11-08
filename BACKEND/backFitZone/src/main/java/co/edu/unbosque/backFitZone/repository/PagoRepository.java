package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import co.edu.unbosque.backFitZone.dto.PagoDTO;

public interface PagoRepository {

	List<PagoDTO> findAll();

	List<PagoDTO> findByIdSede(Long idSede);

	List<PagoDTO> findByIdMiembro(Long idMiembro);
	
}
