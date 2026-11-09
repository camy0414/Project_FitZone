package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.AuditoriaDTO;
import co.edu.unbosque.backFitZone.service.AuditoriaService;

@RestController
@RequestMapping("/auditoria")
public class AuditoriaController {

	@Autowired
	private AuditoriaService auditoriaServ;

	@GetMapping("/getall")
	public ResponseEntity<List<AuditoriaDTO>> getAll() {
		return ResponseEntity.ok(auditoriaServ.getAll());
	}
}