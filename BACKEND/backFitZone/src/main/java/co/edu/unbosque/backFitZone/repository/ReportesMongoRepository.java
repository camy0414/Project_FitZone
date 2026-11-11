package co.edu.unbosque.backFitZone.repository;

import java.util.List;

import org.bson.Document;

public interface ReportesMongoRepository {

	List<Document> ejerciciosMasAsignados(Long idSede);

	List<Document> rutinasPorEntrenador(Long idSede);
}
