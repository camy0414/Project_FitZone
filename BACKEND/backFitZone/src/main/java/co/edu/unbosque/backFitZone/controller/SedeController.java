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

import co.edu.unbosque.backFitZone.dto.SedeDTO;
import co.edu.unbosque.backFitZone.service.SedeService;

@RestController
@RequestMapping("/sede")
public class SedeController {

	@Autowired
	private SedeService sedeServ;

	@GetMapping("/getall")
	public ResponseEntity<List<SedeDTO>> getAll() {
		return ResponseEntity.ok(sedeServ.getAll());
	}

	@GetMapping("/get/{idSede}")
	public ResponseEntity<SedeDTO> getById(@PathVariable Long idSede) {
		return ResponseEntity.ok(sedeServ.getById(idSede));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody SedeDTO nuevaSede) {
		return ResponseEntity.status(HttpStatus.CREATED).body(sedeServ.create(nuevaSede));
	}

	@PutMapping(path = "/update/{idSede}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable Long idSede, @RequestBody SedeDTO sedeDTO) {
		return ResponseEntity.ok(sedeServ.update(idSede, sedeDTO));
	}
}
