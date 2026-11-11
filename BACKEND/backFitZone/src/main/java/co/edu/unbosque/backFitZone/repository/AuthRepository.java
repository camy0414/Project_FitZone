package co.edu.unbosque.backFitZone.repository;

import java.util.Optional;

import co.edu.unbosque.backFitZone.model.Empleado;

public interface AuthRepository {

	public Optional<Empleado> findByCorreo(String correo);
}
