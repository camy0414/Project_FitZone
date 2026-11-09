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

import co.edu.unbosque.backFitZone.dto.MantenimientoDTO;
import co.edu.unbosque.backFitZone.service.MantenimientoService;

@RestController
@RequestMapping("/mantenimiento")
public class MantenimientoController {

	@Autowired
	private MantenimientoService mantenimientoServ;

	@GetMapping("/getall")
	public ResponseEntity<List<MantenimientoDTO>> getAll() {
		return ResponseEntity.ok(mantenimientoServ.getAll());
	}

	@GetMapping("/getbyequipo/{idEquipo}")
	public ResponseEntity<List<MantenimientoDTO>> getByEquipo(@PathVariable Long idEquipo) {
		return ResponseEntity.ok(mantenimientoServ.getByEquipo(idEquipo));
	}

	@GetMapping("/get/{numeroMantenimiento}")
	public ResponseEntity<MantenimientoDTO> getById(@PathVariable Long numeroMantenimiento) {
		return ResponseEntity.ok(mantenimientoServ.getById(numeroMantenimiento));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody MantenimientoDTO nuevoMantenimiento) {
		return ResponseEntity.status(HttpStatus.CREATED).body(mantenimientoServ.create(nuevoMantenimiento));
	}
}
