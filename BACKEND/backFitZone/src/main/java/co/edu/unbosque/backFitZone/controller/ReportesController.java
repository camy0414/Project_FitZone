package co.edu.unbosque.backFitZone.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.MembresiaPorVencerDTO;
import co.edu.unbosque.backFitZone.dto.ReporteOcupacionDTO;
import co.edu.unbosque.backFitZone.service.ReportesService;

@RestController
@RequestMapping("/reporte")
public class ReportesController {

	@Autowired
	private ReportesService reporteServ;

	@GetMapping("/ocupacion")
	public ResponseEntity<List<ReporteOcupacionDTO>> getOcupacion(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
			@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta, @RequestParam Long idSede) {
		return ResponseEntity.ok(reporteServ.getOcupacion(desde, hasta, idSede));
	}

	@GetMapping("/membresiasporvencer")
	public ResponseEntity<List<MembresiaPorVencerDTO>> getMembresiasPorVencer(
			@RequestParam Integer dias, @RequestParam Long idSede) {
		return ResponseEntity.ok(reporteServ.getMembresiasPorVencer(dias, idSede));
	}
}