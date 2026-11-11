package co.edu.unbosque.backFitZone.repository;

import java.time.LocalDate;
import java.util.List;

import co.edu.unbosque.backFitZone.dto.MembresiaPorVencerDTO;
import co.edu.unbosque.backFitZone.dto.ReporteIngresoDTO;
import co.edu.unbosque.backFitZone.dto.ReporteMantenimientoDTO;
import co.edu.unbosque.backFitZone.dto.ReporteOcupacionDTO;

public interface ReporteRepository {

	//fn_reporte_ocupacion
	List<ReporteOcupacionDTO> findOcupacion(LocalDate desde, LocalDate hasta, Long idSede);

	//fn_membresias_por_vencer
	List<MembresiaPorVencerDTO> findMembresiasPorVencer(Integer dias, Long idSede);

	//fn_reporte_ingresos
	List<ReporteIngresoDTO> findIngresos(LocalDate desde, LocalDate hasta, Long idSede);

	//fn_reporte_mantenimientos
	List<ReporteMantenimientoDTO> findMantenimientos(LocalDate desde, LocalDate hasta, Long idSede);
}
