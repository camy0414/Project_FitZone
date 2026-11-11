package co.edu.unbosque.backFitZone.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import co.edu.unbosque.backFitZone.exception.AccesoDenegadoException;
import co.edu.unbosque.backFitZone.exception.NoAutenticadoException;
import co.edu.unbosque.backFitZone.model.Empleado;

public final class UsuarioActual {

	private UsuarioActual() {
	}

	public static Empleado obtenerEmpleadoAutenticado() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.getPrincipal() instanceof Empleado e) {
			return e;
		}
		throw new NoAutenticadoException();
	}

	public static boolean esAdmin() {
		return "ADMIN_SISTEMA".equals(obtenerEmpleadoAutenticado().getRol());
	}

	public static boolean esEntrenador() {
		return "ENTRENADOR_SEDE".equals(obtenerEmpleadoAutenticado().getRol());
	}

	// Si es admin tiene todas las sedes
	public static Long sedeFiltro() {
		return esAdmin() ? null : obtenerEmpleadoAutenticado().getIdSede();
	}

	//verifica si a la sede que se accede es la propia del empleado
	public static void sedePropia(Long idSedeDato) {
		Empleado empleado = obtenerEmpleadoAutenticado();
		if (!esAdmin() && !empleado.getIdSede().equals(idSedeDato)) {
			throw new AccesoDenegadoException("Solo puede gestionar datos de su sede (" + empleado.getSede() + ").");
		}
	}
}
