package co.edu.unbosque.backFitZone.exception;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(NegocioException.class)
	public ResponseEntity<String> negocio(NegocioException e) {
		return responder(HttpStatus.BAD_REQUEST, e.getMessage());
	}

	@ExceptionHandler(NoAutenticadoException.class)
	public ResponseEntity<String> noAutenticado(NoAutenticadoException e) {
		return responder(HttpStatus.UNAUTHORIZED, e.getMessage());
	}

	@ExceptionHandler(AccesoDenegadoException.class)
	public ResponseEntity<String> accesoDenegado(AccesoDenegadoException e) {
		return responder(HttpStatus.FORBIDDEN, e.getMessage());
	}

	@ExceptionHandler(RecursoNoEncontradoException.class)
	public ResponseEntity<String> noEncontrado(RecursoNoEncontradoException e) {
		return responder(HttpStatus.NOT_FOUND, e.getMessage());
	}

	@ExceptionHandler(ConflictoException.class)
	public ResponseEntity<String> conflicto(ConflictoException e) {
		return responder(HttpStatus.CONFLICT, e.getMessage());
	}

	@ExceptionHandler(DataAccessException.class)
	public ResponseEntity<String> excepcionBaseDeDatos(DataAccessException e) {
		if (e.getMostSpecificCause() instanceof SQLException sql && sql.getSQLState() != null) {
			String mensaje = sql.getMessage().split("\n")[0];
			int separador = mensaje.indexOf(": ");
			if (separador >= 0) {
				mensaje = mensaje.substring(separador + 2);
			}
			switch (sql.getSQLState()) {
			case "E0400":
				return responder(HttpStatus.BAD_REQUEST, mensaje);
			case "E0401":
				return responder(HttpStatus.UNAUTHORIZED, mensaje);
			case "E0403":
				return responder(HttpStatus.FORBIDDEN, mensaje);
			case "E0404":
				return responder(HttpStatus.NOT_FOUND, mensaje);
			case "E0409":
				return responder(HttpStatus.CONFLICT, mensaje);
			case "42501":
				return responder(HttpStatus.FORBIDDEN, "El rol no tiene permiso para esta accion");
			default:
				break;
			}
		}
		e.printStackTrace();
		return responder(HttpStatus.INTERNAL_SERVER_ERROR, "Error al acceder a la base de datos");
	}

	private ResponseEntity<String> responder(HttpStatus estado, String mensaje) {
		return ResponseEntity.status(estado).body(mensaje);
	}
}