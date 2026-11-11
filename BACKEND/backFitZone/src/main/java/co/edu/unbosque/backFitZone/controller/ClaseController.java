package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.ClaseDTO;
import co.edu.unbosque.backFitZone.service.ClaseService;

@RestController
@RequestMapping("/clase")
public class ClaseController {

	@Autowired
	private ClaseService claseServ;

	@GetMapping("/getall")
	public ResponseEntity<List<ClaseDTO>> getAll() {
		return ResponseEntity.ok(claseServ.getAll());
	}

	@GetMapping("/get/{idClase}")
	public ResponseEntity<ClaseDTO> getById(@PathVariable Long idClase) {
		return ResponseEntity.ok(claseServ.getById(idClase));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody ClaseDTO nuevaClase) {
		return ResponseEntity.status(HttpStatus.CREATED).body(claseServ.create(nuevaClase));
	}

	@PutMapping(path = "/update/{idClase}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable Long idClase, @RequestBody ClaseDTO claseDTO) {
		return ResponseEntity.ok(claseServ.update(idClase, claseDTO));
	}
}