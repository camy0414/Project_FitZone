package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.SesionDTO;
import co.edu.unbosque.backFitZone.service.SesionService;

@RestController
@RequestMapping("/sesion")
public class SesionController {

	@Autowired
	private SesionService sesionServ;

	@GetMapping("/getall")
	public ResponseEntity<List<SesionDTO>> getAll() {
		return ResponseEntity.ok(sesionServ.getAll());
	}

	@GetMapping("/get/{numeroSesion}")
	public ResponseEntity<SesionDTO> getById(@PathVariable Long numeroSesion) {
		return ResponseEntity.ok(sesionServ.getById(numeroSesion));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody SesionDTO nuevaSesion) {
		return ResponseEntity.status(HttpStatus.CREATED).body(sesionServ.create(nuevaSesion));
	}
}
