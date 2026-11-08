package co.edu.unbosque.backFitZone.repository;

import java.util.List;
import java.util.Optional;

import co.edu.unbosque.backFitZone.dto.EmpleadoDTO;
import co.edu.unbosque.backFitZone.model.Empleado;

public interface EmpleadoRepository {

	List<EmpleadoDTO> findAll();

	List<EmpleadoDTO> findByIdSede(Long idSede);

	Optional<Empleado> findById(Long idEmpleado);

	Long save(Empleado empleado);

	int update(Empleado empleado);

	void updateEstado(Empleado empleado);
}
