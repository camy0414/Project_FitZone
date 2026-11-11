package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import co.edu.unbosque.backFitZone.dto.AuditoriaDTO;

public interface AuditoriaRepository {

	List<AuditoriaDTO> findAll();
}