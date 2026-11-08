package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.InfoMedicaDTO;
import co.edu.unbosque.backFitZone.dto.MiembroDTO;
import co.edu.unbosque.backFitZone.model.InfoMedica;
import co.edu.unbosque.backFitZone.model.Miembro;


public interface MiembroRepository {

	//para llamar v_miembro (todos los miembros con su sede y su plan actual)
	List<MiembroDTO> findAll();

	List<MiembroDTO> findByIdSede(Long idSede);
	
	List<MiembroDTO> findBasicoBySede(Long idSede);
	
	Optional<MiembroDTO> findVistaById(Long idMiembro);

	// nombre y sede de un miembro. 
	Optional<MiembroDTO> findBasicoById(Long idMiembro);
	//nombre y sede de todos los miembros de una sede
	List<MiembroDTO> findBasicoByIdSede(Long idSede);

	//fila completa de un miembro por id
	Optional<Miembro> findById(Long idMiembro);

	Optional<InfoMedica> findInfoMedica(Long idMiembro);

	//Usara sp_registrar_miembro
	Long save(Miembro miembro, InfoMedicaDTO infoMedica);

	
	int update(Miembro miembro);

	//crear y actualizar infoMedica de un miembro
	void saveInfoMedica(Long idMiembro, InfoMedicaDTO infoMedica);
	
	
}

