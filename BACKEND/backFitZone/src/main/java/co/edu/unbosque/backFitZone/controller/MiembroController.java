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

import co.edu.unbosque.backFitZone.dto.MiembroDTO;
import co.edu.unbosque.backFitZone.dto.MiembroDetalleDTO;
import co.edu.unbosque.backFitZone.service.MiembroService;

@RestController
@RequestMapping("/miembro")
public class MiembroController {

	@Autowired
	private MiembroService miembroServ;

	@GetMapping("/getall")
	public ResponseEntity<List<MiembroDTO>> getAll() {
		return ResponseEntity.ok(miembroServ.getAll());
	}

	@GetMapping("/getmiembroscadena")
	public ResponseEntity<List<MiembroDTO>> getMiembrosCadena() {
		return ResponseEntity.ok(miembroServ.getMiembrosCadena());
	}

	@GetMapping("/get/{idMiembro}")
	public ResponseEntity<MiembroDetalleDTO> getDetalle(@PathVariable Long idMiembro) {
		return ResponseEntity.ok(miembroServ.getDetalle(idMiembro));
	}

	@PostMapping(path = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody MiembroDTO nuevoMiembro) {
		return ResponseEntity.status(HttpStatus.CREATED).body(miembroServ.create(nuevoMiembro));
	}

	@PutMapping(path = "/update/{idMiembro}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> update(@PathVariable Long idMiembro, @RequestBody MiembroDTO miembroDTO) {
		return ResponseEntity.ok(miembroServ.update(idMiembro, miembroDTO));
	}
}