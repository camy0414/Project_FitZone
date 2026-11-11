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

import co.edu.unbosque.backFitZone.dto.EquipoDTO;
import co.edu.unbosque.backFitZone.service.EquipoService;

@RestController
@RequestMapping("/equipo")
public class EquipoController {

	@Autowired
	private EquipoService equipoServ;

	@GetMapping("/getall")
	public ResponseEntity<List<EquipoDTO>> getAll() {
		return ResponseEntity.ok(equipoServ.getAll());
	}

	@GetMapping("/get/{idEquipo}")
	public ResponseEntity<EquipoDTO> getById(@PathVariable Long idEquipo) {
		return ResponseEntity.ok(equipoServ.getById(idEquipo));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody EquipoDTO nuevoEquipo) {
		return ResponseEntity.status(HttpStatus.CREATED).body(equipoServ.create(nuevoEquipo));
	}

	@PutMapping(path = "/update/{idEquipo}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable Long idEquipo, @RequestBody EquipoDTO equipoDTO) {
		return ResponseEntity.ok(equipoServ.update(idEquipo, equipoDTO));
	}
}