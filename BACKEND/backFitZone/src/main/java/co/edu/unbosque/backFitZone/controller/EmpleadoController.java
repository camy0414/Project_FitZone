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

import co.edu.unbosque.backFitZone.dto.EmpleadoDTO;
import co.edu.unbosque.backFitZone.service.EmpleadoService;

@RestController
@RequestMapping("/empleado")
public class EmpleadoController {

	@Autowired
	private EmpleadoService empleadoServ;

	@GetMapping("/getall")
	public ResponseEntity<List<EmpleadoDTO>> getAll() {
		return ResponseEntity.ok(empleadoServ.getAll());
	}

	@GetMapping("/get/{idEmpleado}")
	public ResponseEntity<EmpleadoDTO> getById(@PathVariable Long idEmpleado) {
		return ResponseEntity.ok(empleadoServ.getById(idEmpleado));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody EmpleadoDTO nuevoEmpleado) {
		return ResponseEntity.status(HttpStatus.CREATED).body(empleadoServ.create(nuevoEmpleado));
	}

	@PutMapping(path = "/update/{idEmpleado}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable Long idEmpleado, @RequestBody EmpleadoDTO empleadoDTO) {
		return ResponseEntity.ok(empleadoServ.update(idEmpleado, empleadoDTO));
	}

	@PutMapping(path = "/updateestado/{idEmpleado}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> updateEstado(@PathVariable Long idEmpleado, @RequestBody EmpleadoDTO empleadoDTO) {
		return ResponseEntity.ok(empleadoServ.updateEstado(idEmpleado, empleadoDTO));
	}
}
