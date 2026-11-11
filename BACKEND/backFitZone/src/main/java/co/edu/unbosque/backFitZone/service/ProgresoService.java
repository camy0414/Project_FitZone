package co.edu.unbosque.backFitZone.service;

import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Filters.ne;
import static com.mongodb.client.model.Sorts.descending;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import co.edu.unbosque.backFitZone.dto.MiembroDTO;
import co.edu.unbosque.backFitZone.dto.ProgresoDTO;
import co.edu.unbosque.backFitZone.exception.ConflictoException;
import co.edu.unbosque.backFitZone.exception.NegocioException;
import co.edu.unbosque.backFitZone.exception.RecursoNoEncontradoException;
import co.edu.unbosque.backFitZone.model.Empleado;
import co.edu.unbosque.backFitZone.model.ProgresoFisico;
import co.edu.unbosque.backFitZone.repository.EmpleadoRepository;
import co.edu.unbosque.backFitZone.repository.MiembroRepository;
import co.edu.unbosque.backFitZone.repository.ProgresoRepository;
import co.edu.unbosque.backFitZone.security.RolBd;
import co.edu.unbosque.backFitZone.security.UsuarioActual;

@Service
public class ProgresoService implements ProgresoRepository {

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
	public List<ProgresoDTO> getAll() {
		rolBd.activarRol();
		Long idSede = UsuarioActual.sedeFiltro();
		return ProgresoToDTO(idSede == null ? findAll() : findByIdSede(idSede));
	}

	@Transactional(readOnly = true)
	public ProgresoDTO getById(String idProgreso) {
		rolBd.activarRol();
		Optional<ProgresoFisico> found = findById(idProgreso);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La medición no existe");
		}
		UsuarioActual.sedePropia(found.get().getIdSede());
		return ProgresoToDTO(List.of(found.get())).get(0);
	}

	//Todas las mediciones de un miembro (historial)
	@Transactional(readOnly = true)
	public List<ProgresoDTO> getByMiembro(Long idMiembro) {
		rolBd.activarRol();
		Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(idMiembro);
		if (miembro.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro no existe");
		}
		UsuarioActual.sedePropia(miembro.get().getIdSede());
		return ProgresoToDTO(findByIdMiembro(idMiembro));
	}

	@Transactional(readOnly = true)
	public String create(ProgresoDTO dto) {
		rolBd.activarRol();
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la medición");
		}
		if (dto.getIdMiembro() == null || dto.getFecha() == null || dto.getPesoKg() == null) {
			throw new NegocioException("Datos obligatorios no incluidos (miembro, fecha y peso)");
		}
		if (dto.getFecha().isAfter(LocalDate.now())) {
			throw new NegocioException("La fecha de la medición no puede ser futura");
		}
		if (dto.getPesoKg() < 20 || dto.getPesoKg() > 400) {
			throw new NegocioException("El peso debe estar entre 20 y 400 kg");
		}
		if (dto.getGrasaCorporalPct() != null && (dto.getGrasaCorporalPct() < 2 || dto.getGrasaCorporalPct() > 70)) {
			throw new NegocioException("El porcentaje de grasa debe estar entre 2 y 70");
		}
		if (dto.getMedidas() != null && ((dto.getMedidas().getCinturaCm() != null && dto.getMedidas().getCinturaCm() < 1)
				|| (dto.getMedidas().getPechoCm() != null && dto.getMedidas().getPechoCm() < 1)
				|| (dto.getMedidas().getBrazoCm() != null && dto.getMedidas().getBrazoCm() < 1)
				|| (dto.getMedidas().getCaderaCm() != null && dto.getMedidas().getCaderaCm() < 1))) {
			throw new NegocioException("Las medidas deben ser mayores o iguales a 1 cm");
		}

		Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(dto.getIdMiembro());
		if (miembro.isEmpty()) {
			throw new RecursoNoEncontradoException("El miembro seleccionado no existe");
		}
		UsuarioActual.sedePropia(miembro.get().getIdSede());
		if (existsByMiembroAndFecha(dto.getIdMiembro(), dto.getFecha(), null)) {
			throw new ConflictoException("El miembro ya tiene una medición registrada en esa fecha");
		}

		ProgresoFisico progreso = modelMapper.map(dto, ProgresoFisico.class);
		progreso.setIdSede(miembro.get().getIdSede());
		progreso.setRegistradoPor(UsuarioActual.obtenerEmpleadoAutenticado().getIdEmpleado());
		String id = save(progreso);
		return "medición " + id + " registrada para " + miembro.get().getNombreCompleto();
	}

	//Solo cambian los datos de la medicion, el miembro, la sede y quien la registro se mantienen
	public String update(String idProgreso, ProgresoDTO dto) {
		if (dto == null) {
			throw new NegocioException("Se debe ingresar los datos de la medición");
		}
		if (dto.getFecha() == null || dto.getPesoKg() == null) {
			throw new NegocioException("Datos obligatorios no incluidos (fecha y peso)");
		}
		if (dto.getFecha().isAfter(LocalDate.now())) {
			throw new NegocioException("La fecha de la medición no puede ser futura");
		}
		if (dto.getPesoKg() < 20 || dto.getPesoKg() > 400) {
			throw new NegocioException("El peso debe estar entre 20 y 400 kg");
		}
		if (dto.getGrasaCorporalPct() != null && (dto.getGrasaCorporalPct() < 2 || dto.getGrasaCorporalPct() > 70)) {
			throw new NegocioException("El porcentaje de grasa debe estar entre 2 y 70");
		}
		if (dto.getMedidas() != null && ((dto.getMedidas().getCinturaCm() != null && dto.getMedidas().getCinturaCm() < 1)
				|| (dto.getMedidas().getPechoCm() != null && dto.getMedidas().getPechoCm() < 1)
				|| (dto.getMedidas().getBrazoCm() != null && dto.getMedidas().getBrazoCm() < 1)
				|| (dto.getMedidas().getCaderaCm() != null && dto.getMedidas().getCaderaCm() < 1))) {
			throw new NegocioException("Las medidas deben ser mayores o iguales a 1 cm");
		}

		Optional<ProgresoFisico> found = findById(idProgreso);
		if (found.isEmpty()) {
			throw new RecursoNoEncontradoException("La medición que desea actualizar no existe");
		}
		ProgresoFisico progreso = found.get();
		UsuarioActual.sedePropia(progreso.getIdSede());
		if (existsByMiembroAndFecha(progreso.getIdMiembro(), dto.getFecha(), idProgreso)) {
			throw new ConflictoException("El miembro ya tiene otra medición registrada en esa fecha");
		}

		progreso.setFecha(dto.getFecha());
		progreso.setPesoKg(dto.getPesoKg());
		progreso.setGrasaCorporalPct(dto.getGrasaCorporalPct());
		progreso.setMedidas(dto.getMedidas() == null ? null : modelMapper.map(dto.getMedidas(), ProgresoFisico.Medidas.class));
		progreso.setNotas(dto.getNotas());
		update(progreso);
		return "medición " + idProgreso + " actualizada";
	}

	@Override
	public List<ProgresoFisico> findAll() {
		List<ProgresoFisico> mediciones = new ArrayList<ProgresoFisico>();
		FindIterable<Document> documentos = coleccion().find().sort(descending("fecha"));

		for (Document doc : documentos) {
			mediciones.add(DocumentoToProgreso(doc));
		}
		return mediciones;
	}

	@Override
	public List<ProgresoFisico> findByIdSede(Long idSede) {
		List<ProgresoFisico> mediciones = new ArrayList<ProgresoFisico>();
		FindIterable<Document> documentos = coleccion().find(eq("id_sede", idSede)).sort(descending("fecha"));

		for (Document doc : documentos) {
			mediciones.add(DocumentoToProgreso(doc));
		}
		return mediciones;
	}

	@Override
	public List<ProgresoFisico> findByIdMiembro(Long idMiembro) {
		List<ProgresoFisico> mediciones = new ArrayList<ProgresoFisico>();
		FindIterable<Document> documentos = coleccion().find(eq("id_miembro", idMiembro)).sort(descending("fecha"));

		for (Document doc : documentos) {
			mediciones.add(DocumentoToProgreso(doc));
		}
		return mediciones;
	}

	@Override
	public Optional<ProgresoFisico> findById(String idProgreso) {
		if (idProgreso == null || !ObjectId.isValid(idProgreso)) {
			return Optional.empty();
		}
		Document doc = coleccion().find(eq("_id", new ObjectId(idProgreso))).first();
		return doc == null ? Optional.empty() : Optional.of(DocumentoToProgreso(doc));
	}

	@Override
	public boolean existsByMiembroAndFecha(Long idMiembro, LocalDate fecha, String idExcluir) {
		Bson filtro = and(eq("id_miembro", idMiembro), eq("fecha", Date.from(fecha.atStartOfDay(ZoneOffset.UTC).toInstant())));
		if (idExcluir != null) {
			filtro = and(filtro, ne("_id", new ObjectId(idExcluir)));
		}
		return coleccion().countDocuments(filtro) > 0;
	}

	@Override
	public String save(ProgresoFisico progreso) {
		Document doc = ProgresoToDocumento(progreso);
		coleccion().insertOne(doc);
		return doc.getObjectId("_id").toHexString();
	}

	@Override
	public void update(ProgresoFisico progreso) {
		coleccion().replaceOne(eq("_id", new ObjectId(progreso.getIdProgreso())), ProgresoToDocumento(progreso));
	}

	private Document ProgresoToDocumento(ProgresoFisico progreso) {
		Document doc = new Document("id_miembro", progreso.getIdMiembro())
				.append("id_sede", progreso.getIdSede())
				.append("registrado_por", progreso.getRegistradoPor())
				.append("fecha", Date.from(progreso.getFecha().atStartOfDay(ZoneOffset.UTC).toInstant()))
				.append("peso_kg", progreso.getPesoKg());
		if (progreso.getGrasaCorporalPct() != null) {
			doc.append("grasa_corporal_pct", progreso.getGrasaCorporalPct());
		}
		ProgresoFisico.Medidas m = progreso.getMedidas();
		if (m != null) {
			Document medidas = new Document();
			if (m.getCinturaCm() != null)
				medidas.append("cintura_cm", m.getCinturaCm());
			if (m.getPechoCm() != null)
				medidas.append("pecho_cm", m.getPechoCm());
			if (m.getBrazoCm() != null)
				medidas.append("brazo_cm", m.getBrazoCm());
			if (m.getCaderaCm() != null)
				medidas.append("cadera_cm", m.getCaderaCm());
			if (!medidas.isEmpty()) {
				doc.append("medidas", medidas);
			}
		}
		if (progreso.getNotas() != null && !progreso.getNotas().isBlank()) {
			doc.append("notas", progreso.getNotas());
		}
		return doc;
	}

	private ProgresoFisico DocumentoToProgreso(Document doc) {
		ProgresoFisico progreso = new ProgresoFisico();
		
		progreso.setIdProgreso(doc.getObjectId("_id").toString());
		progreso.setIdMiembro(((Number) doc.get("id_miembro")).longValue());
		progreso.setIdSede(((Number) doc.get("id_sede")).longValue());
		progreso.setRegistradoPor(((Number) doc.get("registrado_por")).longValue());
		progreso.setFecha(doc.getDate("fecha").toInstant().atZone(ZoneOffset.UTC).toLocalDate());
		progreso.setPesoKg(((Number) doc.get("peso_kg")).doubleValue());
		progreso.setGrasaCorporalPct(doc.get("grasa_corporal_pct") == null ? null : ((Number) doc.get("grasa_corporal_pct")).doubleValue());

		Document m = doc.get("medidas", Document.class);
		if (m != null) {
			ProgresoFisico.Medidas medidas = new ProgresoFisico.Medidas();
			medidas.setCinturaCm(m.get("cintura_cm") == null ? null : ((Number) m.get("cintura_cm")).doubleValue());
			medidas.setPechoCm(m.get("pecho_cm") == null ? null : ((Number) m.get("pecho_cm")).doubleValue());
			medidas.setBrazoCm(m.get("brazo_cm") == null ? null : ((Number) m.get("brazo_cm")).doubleValue());
			medidas.setCaderaCm(m.get("cadera_cm") == null ? null : ((Number) m.get("cadera_cm")).doubleValue());
			progreso.setMedidas(medidas);
		}
		progreso.setNotas(doc.getString("notas"));
		return progreso;
	}

	private List<ProgresoDTO> ProgresoToDTO(List<ProgresoFisico> mediciones) {
		List<ProgresoDTO> dtoList = new ArrayList<>();
		for (ProgresoFisico progreso : mediciones) {
			ProgresoDTO dto = modelMapper.map(progreso, ProgresoDTO.class);

			Optional<MiembroDTO> miembro = miembroRepo.findBasicoById(progreso.getIdMiembro());
			if (miembro.isPresent()) {
				dto.setMiembro(miembro.get().getNombreCompleto());
			}

			Optional<Empleado> entrenador = empleadoRepo.findById(progreso.getRegistradoPor());
			if (entrenador.isPresent()) {
				dto.setEntrenador(entrenador.get().getNombreCompleto());
			}
			dtoList.add(dto);
		}
		return dtoList;
	}

	private MongoCollection<Document> coleccion() {
		return mongo.getCollection("progreso_fisico");
	}
}
