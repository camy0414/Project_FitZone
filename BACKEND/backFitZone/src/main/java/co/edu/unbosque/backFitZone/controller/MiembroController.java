package co.edu.unbosque.backFitZone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.service.MiembroService;

@RestController
@RequestMapping("/miembro")
public class MiembroController {

	@Autowired
	private MiembroService miembroServ;
	
	
}
