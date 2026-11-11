package co.edu.unbosque.backFitZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.MetodoPagoDTO;
import co.edu.unbosque.backFitZone.dto.RolEmpleadoDTO;
import co.edu.unbosque.backFitZone.dto.TipoEquipoDTO;
import co.edu.unbosque.backFitZone.dto.TipoPlanDTO;
import co.edu.unbosque.backFitZone.service.CatalogosService;

@RestController
@RequestMapping("/catalogo")
public class CatalogosController {

	@Autowired
	private CatalogosService catalogosServ;

	@GetMapping("/tipoplan/getall")
	public ResponseEntity<List<TipoPlanDTO>> getAllTipoPlan() {
		return ResponseEntity.ok(catalogosServ.getAllTipoPlan());
	}

	@GetMapping("/metodopago/getall")
	public ResponseEntity<List<MetodoPagoDTO>> getAllMetodoPago() {
		return ResponseEntity.ok(catalogosServ.getAllMetodoPago());
	}

	@GetMapping("/rolempleado/getall")
	public ResponseEntity<List<RolEmpleadoDTO>> getAllRolEmpleado() {
		return ResponseEntity.ok(catalogosServ.getAllRolEmpleado());
	}

	@GetMapping("/tipoequipo/getall")
	public ResponseEntity<List<TipoEquipoDTO>> getAllTipoEquipo() {
		return ResponseEntity.ok(catalogosServ.getAllTipoEquipo());
	}
}