package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.MembresiaDTO;
import co.edu.unbosque.backFitZone.service.MembresiaService;

@RestController
@RequestMapping("/membresia")
public class MembresiaController {

	@Autowired
	private MembresiaService membresiaServ;

	@GetMapping("/getall")
	public ResponseEntity<List<MembresiaDTO>> getAll() {
		return ResponseEntity.ok(membresiaServ.getAll());
	}

	@PostMapping(path = "/renovar", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> renovar(@RequestBody MembresiaDTO renovacion) {
		return ResponseEntity.status(HttpStatus.CREATED).body(membresiaServ.renovar(renovacion));
	}
}
