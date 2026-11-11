package co.edu.unbosque.backFitZone.service;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Sorts.descending;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Updates;

import co.edu.unbosque.backFitZone.dto.EjercicioDTO;
import co.edu.unbosque.backFitZone.dto.MiembroDTO;
import co.edu.unbosque.backFitZone.dto.RutinaDTO;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Empleado;
import co.edu.unbosque.backFitZone.model.Rutina;
import co.edu.unbosque.backFitZone.repository.EmpleadoRepository;
import co.edu.unbosque.backFitZone.repository.MiembroRepository;
import co.edu.unbosque.backFitZone.repository.RutinaRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class RutinaService implements RutinaRepository {

	@Autowired
	private MongoDatabase mongo;

	@Autowired
	private MiembroRepository miembroRepo;

	@Autowired
	private EmpleadoRepository empleadoRepo;

	@Autowired
	private RolBd rolBd;

	@Autowired
	private ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public List<RutinaDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		return RutinaToDTO(idSede == null ? findAll() : findByIdSede(idSede));
	}

	@Transactional(readOnly = true)
	public RutinaDTO getById(String idRutina) {
		rolBd.activarRol();
		Optional<Rutina> found = findById(idRutina);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La rutina no existe");
		}
		UsuarioActual.sedePropia(found.get().getIdSede());
		
		return RutinaToDTO(List.of(found.get())).get(0);
	}

	@Transactional(readOnly = true)
	public List<RutinaDTO> getByMiembro(Long idMiembro) {
		rolBd.activarRol();
		Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(idMiembro);
		if (miembro.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro no existe");
		}
		UsuarioActual.sedePropia(miembro.get().getIdSede());
		return RutinaToDTO(findByIdMiembro(idMiembro));
	}


	@Transactional(readOnly = true)
	public String create(RutinaDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la rutina");
		}
		if (dto.getIdMiembro() == null || dto.getNombreRutina() == null || dto.getNombreRutina().isBlank()) {
			throw new NegocioException("Datos obligatorios no incluidos ");
		}
		if (dto.getNombreRutina().length() > 100 || (dto.getObjetivo() != null && dto.getObjetivo().length() > 100)) {
			throw new NegocioException("El nombre y el objetivo de la rutina no pueden superar 100 caracteres");
		}
		if (dto.getEjercicios() == null || dto.getEjercicios().isEmpty()) {
			throw new NegocioException("La rutina debe tener al menos un ejercicio");
		}
		for (EjercicioDTO e : dto.getEjercicios()) {
			if (e == null || e.getNombre() == null || e.getNombre().isBlank()) {
				throw new NegocioException("Todos los ejercicios deben tener nombre");
			}
			if (!"fuerza".equals(e.getTipo()) && !"cardio".equals(e.getTipo()) && !"movilidad".equals(e.getTipo())) {
				throw new NegocioException(
						"El tipo del ejercicio " + e.getNombre() + " debe ser fuerza, cardio o movilidad");
			}
			if ("fuerza".equals(e.getTipo()) && (e.getSeries() == null || e.getSeries() < 1
					|| e.getRepeticiones() == null || e.getRepeticiones() < 1)) {
				throw new NegocioException(
						"El ejercicio de fuerza " + e.getNombre() + " necesita series y repeticiones");
			}
			if ("cardio".equals(e.getTipo()) && (e.getDuracionMin() == null || e.getDuracionMin() < 1)) {
				throw new NegocioException(
						"El ejercicio de cardio " + e.getNombre() + " necesita la duración en minutos");
			}
			if ("movilidad".equals(e.getTipo()) && (e.getSeries() == null || e.getSeries() < 1
					|| e.getDuracionSeg() == null || e.getDuracionSeg() < 1)) {
				throw new NegocioException(
						"El ejercicio de movilidad " + e.getNombre() + " necesita series y duración en segundos");
			}
			if ((e.getPesoKg() != null && e.getPesoKg() < 0)
					|| (e.getDistanciaKm() != null && e.getDistanciaKm() < 0)) {
				throw new NegocioException("El peso y la distancia no pueden ser negativos");
			}
		}

		Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(dto.getIdMiembro());
		if (miembro.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro seleccionado no existe");
		}
		UsuarioActual.sedePropia(miembro.get().getIdSede());

		Rutina rutina = modelMapper.map(dto, Rutina.class);
		rutina.setIdEmpleado(UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado());
		rutina.setIdSede(miembro.get().getIdSede());
		rutina.setFechaCreacion(LocalDate.now());
		rutina.setActiva(true);
		String id = save(rutina);
		return "rutina " + id + " creada para " + miembro.get().getNombreCompleto();
	}

	public String update(String idRutina, RutinaDTO dto) {
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la rutina");
		}
		if (dto.getNombreRutina() == null || dto.getNombreRutina().isBlank()) {
			throw new NegocioException("Datos obligatorios no incluidos");
		}
		if (dto.getNombreRutina().length() > 100 || (dto.getObjetivo() != null && dto.getObjetivo().length() > 100)) {
			throw new NegocioException("El nombre y el objetivo de la rutina no pueden superar 100 caracteres");
		}
		if (dto.getEjercicios() == null || dto.getEjercicios().isEmpty()) {
			throw new NegocioException("La rutina debe tener al menos un ejercicio");
		}
		for (EjercicioDTO e : dto.getEjercicios()) {
			if (e == null || e.getNombre() == null || e.getNombre().isBlank()) {
				throw new NegocioException("Todos los ejercicios deben tener nombre");
			}
			if (!"fuerza".equals(e.getTipo()) && !"cardio".equals(e.getTipo()) && !"movilidad".equals(e.getTipo())) {
				throw new NegocioException(
						"El tipo del ejercicio " + e.getNombre() + " debe ser fuerza, cardio o movilidad");
			}
			if ("fuerza".equals(e.getTipo()) && (e.getSeries() == null || e.getSeries() < 1
					|| e.getRepeticiones() == null || e.getRepeticiones() < 1)) {
				throw new NegocioException(
						"El ejercicio de fuerza " + e.getNombre() + " necesita series y repeticiones");
			}
			if ("cardio".equals(e.getTipo()) && (e.getDuracionMin() == null || e.getDuracionMin() < 1)) {
				throw new NegocioException(
						"El ejercicio de cardio " + e.getNombre() + " necesita la duración en minutos");
			}
			if ("movilidad".equals(e.getTipo()) && (e.getSeries() == null || e.getSeries() < 1
					|| e.getDuracionSeg() == null || e.getDuracionSeg() < 1)) {
				throw new NegocioException(
						"El ejercicio de movilidad " + e.getNombre() + " necesita series y duración en segundos");
			}
			if ((e.getPesoKg() != null && e.getPesoKg() < 0)
					|| (e.getDistanciaKm() != null && e.getDistanciaKm() < 0)) {
				throw new NegocioException("El peso y la distancia no pueden ser negativos");
			}
		}

		Optional<Rutina> found = findById(idRutina);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La rutina que desea actualizar no existe");
		}
		Rutina rutina = found.get();
		UsuarioActual.sedePropia(rutina.getIdSede());

		List<Rutina.Ejercicio> ejercicios = new ArrayList<>();
		for (EjercicioDTO ejercicio : dto.getEjercicios()) {
			ejercicios.add(modelMapper.map(ejercicio, Rutina.Ejercicio.class));
		}
		rutina.setNombreRutina(dto.getNombreRutina());
		rutina.setObjetivo(dto.getObjetivo());
		rutina.setNotasEntrenador(dto.getNotasEntrenador());
		rutina.setEjercicios(ejercicios);
		update(rutina);
		return "rutina " + idRutina + " actualizada";
	}

	public String updateEstado(String idRutina, RutinaDTO dto) {
		if (dto == null || dto.getActiva() == null) {
			throw new NegocioException("Se debe indicar si la rutina queda activa o inactiva");
		}
		Optional<Rutina> found = findById(idRutina);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La rutina no existe");
		}
		Rutina rutina = found.get();
		UsuarioActual.sedePropia(rutina.getIdSede());
		rutina.setActiva(dto.getActiva());
		updateEstado(rutina);
		return "rutina " + idRutina + (dto.getActiva() ? " activada" : " desactivada");
	}

	@Override
	public List<Rutina> findAll() {
		List<Rutina> rutinas = new ArrayList<Rutina>();
		FindIterable<Document> documentos = coleccion().find().sort(descending("fecha_creacion"));

		for (Document doc : documentos) {
			rutinas.add(DocumentoToRutina(doc));
		}
		return rutinas;
	}

	@Override
	public List<Rutina> findByIdSede(Long idSede) {
		List<Rutina> rutinas = new ArrayList<Rutina>();
		FindIterable<Document> documentos = coleccion().find(eq("id_sede", idSede)).sort(descending("fecha_creacion"));

		for (Document doc : documentos) {
			rutinas.add(DocumentoToRutina(doc));
		}
		return rutinas;
	}

	@Override
	public List<Rutina> findByIdMiembro(Long idMiembro) {
		List<Rutina> rutinas = new ArrayList<Rutina>();
		FindIterable<Document> documentos = coleccion().find(eq("id_miembro", idMiembro))
				.sort(descending("fecha_creacion"));

		for (Document doc : documentos) {
			rutinas.add(DocumentoToRutina(doc));
		}
		return rutinas;
	}

	@Override
	public Optional<Rutina> findById(String idRutina) {
		if (idRutina == null || !ObjectId.isValid(idRutina)) {
			return Optional.empty();
		}
		Document doc = coleccion().find(eq("_id", new ObjectId(idRutina))).first();
		return doc == null ? Optional.empty() : Optional.of(DocumentoToRutina(doc));
	}

	@Override
	public String save(Rutina rutina) {
		Document doc = RutinaToDocumento(rutina);
		coleccion().insertOne(doc);
		return doc.getObjectId("_id").toHexString();
	}

	@Override
	public void update(Rutina rutina) {
		coleccion().replaceOne(eq("_id", new ObjectId(rutina.getIdRutina())), RutinaToDocumento(rutina));
	}

	@Override
	public void updateEstado(Rutina rutina) {
		coleccion().updateOne(eq("_id", new ObjectId(rutina.getIdRutina())), Updates.set("activa", rutina.getActiva()));
	}

	private Document RutinaToDocumento(Rutina rutina) {
		List<Document> ejercicios = new ArrayList<>();

		for (Rutina.Ejercicio e : rutina.getEjercicios()) {
			Document ej = new Document("nombre", e.getNombre()).append("tipo", e.getTipo());
			if (e.getSeries() != null)
				ej.append("series", e.getSeries());
			if (e.getRepeticiones() != null)
				ej.append("repeticiones", e.getRepeticiones());
			if (e.getPesoKg() != null)
				ej.append("peso_kg", e.getPesoKg());
			if (e.getDuracionMin() != null)
				ej.append("duracion_min", e.getDuracionMin());
			if (e.getDuracionSeg() != null)
				ej.append("duracion_seg", e.getDuracionSeg());
			if (e.getDistanciaKm() != null)
				ej.append("distancia_km", e.getDistanciaKm());
			if (e.getVideoUrl() != null && !e.getVideoUrl().isBlank())
				ej.append("video_url", e.getVideoUrl());
			if (e.getNotas() != null && !e.getNotas().isBlank())
				ej.append("notas", e.getNotas());
			ejercicios.add(ej);
		}
		Document doc = new Document("id_miembro", rutina.getIdMiembro()).append("id_empleado", rutina.getIdEmpleado())
				.append("id_sede", rutina.getIdSede()).append("nombre_rutina", rutina.getNombreRutina());
		if (rutina.getObjetivo() != null && !rutina.getObjetivo().isBlank()) {
			doc.append("objetivo", rutina.getObjetivo());
		}
		doc.append("fecha_creacion", Date.from(rutina.getFechaCreacion().atStartOfDay(ZoneOffset.UTC).toInstant()))
				.append("activa", rutina.getActiva()).append("ejercicios", ejercicios);
		if (rutina.getNotasEntrenador() != null && !rutina.getNotasEntrenador().isBlank()) {
			doc.append("notas_entrenador", rutina.getNotasEntrenador());
		}
		return doc;
	}

	private Rutina DocumentoToRutina(Document doc) {
		Rutina rutina = new Rutina();
		List<Rutina.Ejercicio> ejercicios = new ArrayList<>();
		List<Document> ArrayEjercicios = doc.getList("ejercicios", Document.class, new ArrayList<>());

		for (Document ej : ArrayEjercicios) {

			Rutina.Ejercicio e = new Rutina.Ejercicio();
			e.setNombre(ej.getString("nombre"));
			e.setTipo(ej.getString("tipo"));
			e.setSeries(ej.get("series") == null ? null : ((Number) ej.get("series")).intValue());
			e.setRepeticiones(ej.get("repeticiones") == null ? null : ((Number) ej.get("repeticiones")).intValue());
			e.setPesoKg(ej.get("peso_kg") == null ? null : ((Number) ej.get("peso_kg")).doubleValue());
			e.setDuracionMin(ej.get("duracion_min") == null ? null : ((Number) ej.get("duracion_min")).intValue());
			e.setDuracionSeg(ej.get("duracion_seg") == null ? null : ((Number) ej.get("duracion_seg")).intValue());
			e.setDistanciaKm(ej.get("distancia_km") == null ? null : ((Number) ej.get("distancia_km")).doubleValue());
			e.setVideoUrl(ej.getString("video_url"));
			e.setNotas(ej.getString("notas"));
			ejercicios.add(e);
		}

		rutina.setIdRutina(doc.getObjectId("_id").toString());
		rutina.setIdMiembro(((Number) doc.get("id_miembro")).longValue());
		rutina.setIdEmpleado(((Number) doc.get("id_empleado")).longValue());
		rutina.setIdSede(((Number) doc.get("id_sede")).longValue());
		rutina.setNombreRutina(doc.getString("nombre_rutina"));
		rutina.setObjetivo(doc.getString("objetivo"));
		rutina.setFechaCreacion(doc.getDate("fecha_creacion").toInstant().atZone(ZoneOffset.UTC).toLocalDate());

		rutina.setActiva(doc.getBoolean("activa"));
		rutina.setNotasEntrenador(doc.getString("notas_entrenador"));
		rutina.setEjercicios(ejercicios);
		return rutina;
	}

	private List<RutinaDTO> RutinaToDTO(List<Rutina> rutinas) {
		List<RutinaDTO> dtoList = new ArrayList<>();
		for (Rutina rutina : rutinas) {
			RutinaDTO dto = modelMapper.map(rutina, RutinaDTO.class);

			Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(rutina.getIdMiembro());
			if (miembro.isPresent()) {
				dto.setMiembro(miembro.get().getNombreCompleto());
				dto.setSede(miembro.get().getSede());
			}

			Optional<Empleado> entrenador = empleadoRepo.findById(rutina.getIdEmpleado());
			if (entrenador.isPresent()) {
				dto.setEntrenador(entrenador.get().getNombreCompleto());
			}
			dtoList.add(dto);
		}
		return dtoList;
	}

	private MongoCollection<Document> coleccion() {
		return mongo.getCollection("rutinas_entrenamiento");
	}
}