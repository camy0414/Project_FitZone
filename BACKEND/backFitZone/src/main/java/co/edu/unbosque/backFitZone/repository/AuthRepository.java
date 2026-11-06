package co.edu.unbosque.backFitZone.repository;

import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.CredencialDTO;

public interface AuthRepository {

	Optional<CredencialDTO> findByCorreo(String correo);
}
