package co.edu.unbosque.backFitZone.controller;

import java.time.LocalDate;
import java.util.List;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.MembresiaPorVencerDTO;
import co.edu.unbosque.backFitZone.dto.ReporteIngresoDTO;
import co.edu.unbosque.backFitZone.dto.ReporteMantenimientoDTO;
import co.edu.unbosque.backFitZone.dto.ReporteOcupacionDTO;
import co.edu.unbosque.backFitZone.service.ReportesMongoService;
import co.edu.unbosque.backFitZone.service.ReportesService;

@RestController
@RequestMapping("/reporte")
public class ReportesController {

	@Autowired
	private ReportesService reporteServ;
	
	@Autowired
	private ReportesMongoService reporteMongoServ;

	//Reportes PosgreSQl
	@GetMapping("/ocupacionsedesesion")
	public ResponseEntity<List<ReporteOcupacionDTO>> getOcupacion(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
			@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta, @RequestParam(required = false) Long idSede) {
		return ResponseEntity.ok(reporteServ.getOcupacion(desde, hasta, idSede));
	}

	@GetMapping("/membresiasporvencer")
	public ResponseEntity<List<MembresiaPorVencerDTO>> getMembresiasPorVencer(
			@RequestParam(required = false) Integer dias, @RequestParam(required = false) Long idSede) {
		return ResponseEntity.ok(reporteServ.getMembresiasPorVencer(dias, idSede));
	}

	@GetMapping("/ingresos")
	public ResponseEntity<List<ReporteIngresoDTO>> getIngresos(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
			@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta, @RequestParam(required = false) Long idSede) {
		return ResponseEntity.ok(reporteServ.getIngresos(desde, hasta, idSede));
	}

	@GetMapping("/mantenimientos")
	public ResponseEntity<List<ReporteMantenimientoDTO>> getMantenimientos(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
			@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta, @RequestParam(required = false) Long idSede) {
		return ResponseEntity.ok(reporteServ.getMantenimientos(desde, hasta, idSede));
	}
	
	//Reportes de MongoDB
		@GetMapping("/ejerciciosmasasignados")
		public ResponseEntity<List<Document>> getEjerciciosMasAsignados(@RequestParam(required = false) Long idSede) {
			return ResponseEntity.ok(reporteMongoServ.ejerciciosMasAsignados(idSede));
		}
	 
		@GetMapping("/rutinasentrenador")
		public ResponseEntity<List<Document>> getRutinasPorEntrenador(@RequestParam(required = false) Long idSede) {
			return ResponseEntity.ok(reporteMongoServ.rutinasPorEntrenador(idSede));
		}
}
