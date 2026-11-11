package co.edu.unbosque.backFitZone.service;

import static com.mongodb.client.model.Accumulators.first;
import static com.mongodb.client.model.Accumulators.sum;
import static com.mongodb.client.model.Aggregates.group;
import static com.mongodb.client.model.Aggregates.match;
import static com.mongodb.client.model.Aggregates.project;
import static com.mongodb.client.model.Aggregates.sort;
import static com.mongodb.client.model.Aggregates.unwind;
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Projections.excludeId;
import static com.mongodb.client.model.Projections.fields;
import static com.mongodb.client.model.Projections.include;
import static com.mongodb.client.model.Sorts.ascending;
import static com.mongodb.client.model.Sorts.descending;
import static com.mongodb.client.model.Sorts.orderBy;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mongodb.client.MongoDatabase;

import co.edu.unbosque.backFitZone.model.Empleado;
import co.edu.unbosque.backFitZone.repository.EmpleadoRepository;
import co.edu.unbosque.backFitZone.repository.ReportesMongoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;


@Service
public class ReportesMongoService implements ReportesMongoRepository {


	@Autowired
	private MongoDatabase mongo;
 
	@Autowired
	private EmpleadoRepository empleadoRepo;
 
	@Autowired
	private RolBd rolBd;
 
	@Override
	public List<Document> ejerciciosMasAsignados(Long idSede) {
		if (!UsuarioActual.esAdmin()) {
			idSede = UsuarioActual.sedeFiltro();
		}
 
		List<Bson> pipeline = new ArrayList<>();
		if (idSede != null) {
			pipeline.add(match(eq("id_sede", idSede)));
		}
		
		pipeline.add(match(eq("activa", true)));
		pipeline.add(unwind("$ejercicios"));
		pipeline.add(group(new Document("$toLower", "$ejercicios.nombre"),
				first("nombre", "$ejercicios.nombre"),
				first("tipo", "$ejercicios.tipo"),
				sum("rutinas", 1)));
		pipeline.add(sort(orderBy(ascending("nombre"))));
		pipeline.add(project(fields(excludeId(), include("nombre", "tipo", "rutinas"))));
		return mongo.getCollection("rutinas_entrenamiento").aggregate(pipeline).into(new ArrayList<>());
	}
 
	@Override
	@Transactional(readOnly = true)
	public List<Document> rutinasPorEntrenador(Long idSede) {
		rolBd.activarRol();
		if (!UsuarioActual.esAdmin()) {
			idSede = UsuarioActual.sedeFiltro();
		}

		List<Bson> pipeline = new ArrayList<>();
		if (idSede != null) {
			pipeline.add(match(eq("id_sede", idSede)));
		}
		pipeline.add(group("$id_empleado",
				sum("activas", new Document("$cond", List.of("$activa", 1, 0))),
				sum("inactivas", new Document("$cond", List.of("$activa", 0, 1)))));
		pipeline.add(project(new Document("_id", 0)
				.append("id_empleado", "$_id")
				.append("activas", 1)
				.append("inactivas", 1)
				.append("total", new Document("$add", List.of("$activas", "$inactivas")))));
		pipeline.add(sort(descending("total")));
		List<Document> resultado = mongo.getCollection("rutinas_entrenamiento").aggregate(pipeline)
				.into(new ArrayList<>());

		for (Document doc : resultado) {
			Optional<Empleado> entrenador = empleadoRepo.findById(((Number) doc.get("id_empleado")).longValue());
			if (entrenador.isPresent()) {
				doc.append("entrenador", entrenador.get().getNombreCompleto());
			}
		}
		return resultado;
	}
}