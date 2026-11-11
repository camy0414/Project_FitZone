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

import co.edu.unbosque.backFitZone.dto.ProgresoDTO;
import co.edu.unbosque.backFitZone.service.ProgresoService;

@RestController
@RequestMapping("/progreso")
public class ProgresoController {

	@Autowired
	private ProgresoService progresoServ;

	@GetMapping("/getall")
	public ResponseEntity<List<ProgresoDTO>> getAll() {
		return ResponseEntity.ok(progresoServ.getAll());
	}

	@GetMapping("/get/{idProgreso}")
	public ResponseEntity<ProgresoDTO> getById(@PathVariable String idProgreso) {
		return ResponseEntity.ok(progresoServ.getById(idProgreso));
	}

	@GetMapping("/getbymiembro/{idMiembro}")
	public ResponseEntity<List<ProgresoDTO>> getByMiembro(@PathVariable Long idMiembro) {
		return ResponseEntity.ok(progresoServ.getByMiembro(idMiembro));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody ProgresoDTO nuevaMedicion) {
		return ResponseEntity.status(HttpStatus.CREATED).body(progresoServ.create(nuevaMedicion));
	}

	@PutMapping(path = "/update/{idProgreso}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable String idProgreso, @RequestBody ProgresoDTO progresoDTO) {
		return ResponseEntity.ok(progresoServ.update(idProgreso, progresoDTO));
	}
}
