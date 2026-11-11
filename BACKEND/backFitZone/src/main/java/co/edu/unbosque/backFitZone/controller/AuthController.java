package co.edu.unbosque.backFitZone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.unbosque.backFitZone.dto.LoginDTO;
import co.edu.unbosque.backFitZone.model.Empleado;
import co.edu.unbosque.backFitZone.repository.AuthRepository;
import co.edu.unbosque.backFitZone.security.JwtUtil;

@RestController
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private AuthRepository authRepository;

	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtUtil jwtUtil;
 
	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody LoginDTO loginRequest) {
		try {
			Authentication authentication = authenticationManager.authenticate(
					new UsernamePasswordAuthenticationToken(loginRequest.getCorreo(), loginRequest.getClave()));
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			String jwt = jwtUtil.generateToken(userDetails);
			String rol = userDetails.getAuthorities().stream()
					.findFirst()
					.map(a -> a.getAuthority().replace("ROLE_", ""))
					.orElse(null);

			return ResponseEntity.ok(new AuthResponse(jwt, rol));
		} catch (AuthenticationException e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body("Correo o contraseña incorrectos.");
		}
	}

	@GetMapping("/me")
	public ResponseEntity<?> me(Authentication authentication) {
		String correo = authentication.getName();
		Empleado empleado = authRepository.findByCorreo(correo).orElse(null);
		if (empleado == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuario no encontrado.");
		}
		String rol = authentication.getAuthorities().stream()
				.findFirst()
				.map(a -> a.getAuthority().replace("ROLE_", ""))
				.orElse(null);
		return ResponseEntity.ok(new UsuarioActual(empleado.getIdEmpleado(), empleado.getNombreCompleto(),empleado.getCorreo(), rol, empleado.getIdSede(),empleado.getSede()));
	}
	
	
	
	private static class AuthResponse {

		private final String token;
		private final String rol;

		public AuthResponse(String token, String rol) {
			this.token = token;
			this.rol = rol;
		}

		public String getToken() {
			return token;
		}

		public String getRol() {
			return rol;
		}
	}
	
	private static class UsuarioActual {
		private final Long idEmpleado;
		private final String nombreCompleto;
		private final String correo;
		private final String rol;
		private final Long idSede;
		private final String sede;
		
		public UsuarioActual(Long idEmpleado, String nombreCompleto, String correo, String rol, Long idSede,
				String sede) {
			super();
			this.idEmpleado = idEmpleado;
			this.nombreCompleto = nombreCompleto;
			this.correo = correo;
			this.rol = rol;
			this.idSede = idSede;
			this.sede = sede;
		}

		public Long getIdEmpleado() {
			return idEmpleado;
		}

		public String getNombreCompleto() {
			return nombreCompleto;
		}

		public String getCorreo() {
			return correo;
		}

		public String getRol() {
			return rol;
		}

		public Long getIdSede() {
			return idSede;
		}

		public String getSede() {
			return sede;
		}
		
	}

}
