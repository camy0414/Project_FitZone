package co.edu.unbosque.backFitZone.exception;

public class NegocioException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public NegocioException(String mensaje) {
		super(mensaje);
	}
}
