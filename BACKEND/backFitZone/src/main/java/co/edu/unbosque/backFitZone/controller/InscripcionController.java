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

import co.edu.unbosque.backFitZone.dto.InscripcionDTO;
import co.edu.unbosque.backFitZone.service.InscripcionService;

@RestController
@RequestMapping("/inscripcion")
public class InscripcionController {

	@Autowired
	private InscripcionService inscripcionServ;

	@GetMapping("/get/{numeroSesion}")
	public ResponseEntity<List<InscripcionDTO>> getBySesion(@PathVariable Long numeroSesion) {
		return ResponseEntity.ok(inscripcionServ.getBySesion(numeroSesion));
	}

	@PostMapping(path = "/create/{numeroSesion}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@PathVariable Long numeroSesion, @RequestBody InscripcionDTO inscripcionDTO) {
		return ResponseEntity.status(HttpStatus.CREATED).body(inscripcionServ.create(numeroSesion, inscripcionDTO));
	}

	@PutMapping(path = "/updateasistencia/{numeroSesion}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> updateAsistencia(@PathVariable Long numeroSesion,
			@RequestBody InscripcionDTO inscripcionDTO) {
		return ResponseEntity.ok(inscripcionServ.updateAsistencia(numeroSesion, inscripcionDTO));
	}
}