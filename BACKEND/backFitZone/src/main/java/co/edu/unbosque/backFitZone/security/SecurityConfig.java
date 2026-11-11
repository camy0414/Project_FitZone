package co.edu.unbosque.backFitZone.security;

import java.util.Arrays;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

	@Autowired
	private JwtAuthenticationFilter jwtAuthFilter;

	@Autowired
	private UserDetailsService userDetailsService;

	@Value("${fitzone.cors.origenes}")
	private String origenes;

	public SecurityConfig() {
	}

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.csrf(csrf -> csrf.disable()).cors(cors -> cors.configurationSource(corsConfigurationSource()))
				.authorizeHttpRequests(auth -> auth.requestMatchers("/auth/login").permitAll()
						.requestMatchers("/swagger-ui.html", "/swagger-ui/**", "/v3/api-docs/**", "/error").permitAll()
						.requestMatchers("/auth/me").authenticated()
						// Ajustar al crear controllers
						// Empleados
						.requestMatchers("/empleado/getall", "/empleado/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						.requestMatchers("/empleado/create", "/empleado/update/**", "/empleado/updateestado/**")
						.hasRole("ADMIN_SISTEMA")
						// Sedes
						.requestMatchers("/sede/getall", "/sede/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/sede/create", "/sede/update/**").hasRole("ADMIN_SISTEMA")
						// Miembros
						.requestMatchers("/miembro/getall")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/miembro/getmiembroscadena", "/miembro/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE")
						.requestMatchers("/miembro/create", "/miembro/update/**")
						.hasAnyRole("ADMIN_SISTEMA", "RECEPCIONISTA_SEDE")
						// Membresias
						.requestMatchers("/membresia/getall")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE")
						.requestMatchers("/membresia/renovar").hasAnyRole("ADMIN_SISTEMA", "RECEPCIONISTA_SEDE")
						// Pagos
						.requestMatchers("/pago/getall")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE")
						// Clases
						.requestMatchers("/clase/getall", "/clase/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/clase/create", "/clase/update/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						// Sesiones
						.requestMatchers("/sesion/getall", "/sesion/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/sesion/create").hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						// Inscripciones
						.requestMatchers("/inscripcion/get/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/inscripcion/create/**").hasAnyRole("ADMIN_SISTEMA", "RECEPCIONISTA_SEDE")
						.requestMatchers("/inscripcion/updateasistencia/**")
						.hasAnyRole("ADMIN_SISTEMA", "ENTRENADOR_SEDE")
						// Equipos y mantenimientos
						.requestMatchers("/equipo/getall", "/equipo/get/**", "/equipo/create", "/equipo/update/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						.requestMatchers("/mantenimiento/getall", "/mantenimiento/getbyequipo/**",
								"/mantenimiento/get/**", "/mantenimiento/create")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						// Catalogos
						.requestMatchers("/catalogo/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						// Reportes
						.requestMatchers("/reporte/ocupacionsedesesion")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/reporte/membresiasporvencer")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE")
						.requestMatchers("/reporte/ingresos")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "RECEPCIONISTA_SEDE")
						.requestMatchers("/reporte/mantenimientos").hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE")
						.requestMatchers("/reporte/ejerciciosmasasignados", "/reporte/rutinasentrenador")
						  .hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "ENTRENADOR_SEDE")
						// Auditoria
						.requestMatchers("/auditoria/getall").hasRole("ADMIN_SISTEMA")
						// Rutinas (mongo)
						.requestMatchers("/rutina/getall", "/rutina/get/**", "/rutina/getbymiembro/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/rutina/create", "/rutina/update/**", "/rutina/updateestado/**")
						.hasRole("ENTRENADOR_SEDE")
						// Progreso fisico (mongo)
						.requestMatchers("/progreso/getall", "/progreso/get/**", "/progreso/getbymiembro/**")
						.hasAnyRole("ADMIN_SISTEMA", "GERENTE_SEDE", "ENTRENADOR_SEDE")
						.requestMatchers("/progreso/create", "/progreso/update/**").hasRole("ENTRENADOR_SEDE")
						.anyRequest().authenticated())
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
				.authenticationProvider(authenticationProvider())
				.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	@Bean
	public CorsConfigurationSource corsConfigurationSource() {
		CorsConfiguration configuration = new CorsConfiguration();
		configuration.setAllowedOriginPatterns(Arrays.stream(origenes.split(",")).map(String::trim).toList());
		configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"));
		configuration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
		configuration.setExposedHeaders(List.of("Authorization"));
		configuration.setAllowCredentials(false);

		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/**", configuration);
		return source;
	}

	@Bean
	public AuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider(userDetailsService);
		authProvider.setPasswordEncoder(passwordEncoder());
		return authProvider;
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
		return config.getAuthenticationManager();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}