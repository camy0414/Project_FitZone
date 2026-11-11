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

import co.edu.unbosque.backFitZone.dto.RutinaDTO;
import co.edu.unbosque.backFitZone.service.RutinaService;

@RestController
@RequestMapping("/rutina")
public class RutinaController {

	@Autowired
	private RutinaService rutinaServ;

	@GetMapping("/getall")
	public ResponseEntity<List<RutinaDTO>> getAll() {
		return ResponseEntity.ok(rutinaServ.getAll());
	}

	@GetMapping("/get/{idRutina}")
	public ResponseEntity<RutinaDTO> getById(@PathVariable String idRutina) {
		return ResponseEntity.ok(rutinaServ.getById(idRutina));
	}

	@GetMapping("/getbymiembro/{idMiembro}")
	public ResponseEntity<List<RutinaDTO>> getByMiembro(@PathVariable Long idMiembro) {
		return ResponseEntity.ok(rutinaServ.getByMiembro(idMiembro));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody RutinaDTO nuevaRutina) {
		return ResponseEntity.status(HttpStatus.CREATED).body(rutinaServ.create(nuevaRutina));
	}

	@PutMapping(path = "/update/{idRutina}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable String idRutina, @RequestBody RutinaDTO rutinaDTO) {
		return ResponseEntity.ok(rutinaServ.update(idRutina, rutinaDTO));
	}

	@PutMapping(path = "/updateestado/{idRutina}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> updateEstado(@PathVariable String idRutina, @RequestBody RutinaDTO rutinaDTO) {
		return ResponseEntity.ok(rutinaServ.updateEstado(idRutina, rutinaDTO));
	}
}