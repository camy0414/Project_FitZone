package co.edu.unbosque.backFitZone.exception;

public class NoAutenticadoException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public NoAutenticadoException() {
		super("Debe iniciar sesión o su sesión expiró.");
	}
}
