package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import co.edu.unbosque.backFitZone.dto.MembresiaDTO;
import co.edu.unbosque.backFitZone.dto.RenovacionDTO;
import co.edu.unbosque.backFitZone.model.Membresia;
import co.edu.unbosque.backFitZone.model.Pago;


public interface MembresiaRepository {

	List<MembresiaDTO> findAll();

	List<MembresiaDTO> findByIdSede(Long idSede);

	//Todas las membresias de un miembro 
	List<MembresiaDTO> findByIdMiembro(Long idMiembro);

	//sp_renovar_membresia
	RenovacionDTO renovar(Membresia membresia, Pago pago);
}
