package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import co.edu.unbosque.backFitZone.model.MetodoPago;
import co.edu.unbosque.backFitZone.model.RolEmpleado;
import co.edu.unbosque.backFitZone.model.TipoEquipo;
import co.edu.unbosque.backFitZone.model.TipoPlan;



public interface CatalogosRepository {

	List<TipoPlan> findAllTipoPlan();
	 
	List<MetodoPago> findAllMetodoPago();
 
	List<RolEmpleado> findAllRolEmpleado();
 
	List<TipoEquipo> findAllTipoEquipo();
}
