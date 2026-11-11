package co.edu.unbosque.backFitZone.model;

import java.time.LocalDate;

public class Equipo {

	private Long idEquipo;
	private LocalDate fechaAdquisicion;
	private String nombre;
	private Long idTipoEquipo;
	private Long idSede;

	public Equipo() {
	
	}
	
	public Equipo(Long idEquipo, LocalDate fechaAdquisicion, String nombre, Long idTipoEquipo, Long idSede) {
		super();
		this.idEquipo = idEquipo;
		this.fechaAdquisicion = fechaAdquisicion;
		this.nombre = nombre;
		this.idTipoEquipo = idTipoEquipo;
		this.idSede = idSede;
	}

	public Long getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(Long idEquipo) {
		this.idEquipo = idEquipo;
	}

	public LocalDate getFechaAdquisicion() {
		return fechaAdquisicion;
	}

	public void setFechaAdquisicion(LocalDate fechaAdquisicion) {
		this.fechaAdquisicion = fechaAdquisicion;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Long getIdTipoEquipo() {
		return idTipoEquipo;
	}

	public void setIdTipoEquipo(Long idTipoEquipo) {
		this.idTipoEquipo = idTipoEquipo;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}
}
