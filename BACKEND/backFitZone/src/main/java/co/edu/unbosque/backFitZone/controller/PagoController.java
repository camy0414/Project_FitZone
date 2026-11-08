package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.PagoDTO;
import co.edu.unbosque.backFitZone.service.PagoService;

@RestController
@RequestMapping("/pago")
public class PagoController {

	@Autowired
	private PagoService pagoServ;

	@GetMapping("/getall")
	public ResponseEntity<List<PagoDTO>> getAll() {
		return ResponseEntity.ok(pagoServ.getAll());
	}
}
