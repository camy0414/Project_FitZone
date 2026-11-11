package co.edu.unbosque.backFitZone.dto;

import java.time.LocalDate;

public class EquipoDTO {

	private Long idEquipo;
	private String nombre;
	private Long idTipoEquipo;
	private String tipo;
	private Long idSede;
	private String sede;
	private LocalDate fechaAdquisicion;
	private String estado;

	public EquipoDTO() {
		
	}

	public EquipoDTO(Long idEquipo, String nombre, Long idTipoEquipo, String tipo, Long idSede, String sede,
			LocalDate fechaAdquisicion, String estado) {
		super();
		this.idEquipo = idEquipo;
		this.nombre = nombre;
		this.idTipoEquipo = idTipoEquipo;
		this.tipo = tipo;
		this.idSede = idSede;
		this.sede = sede;
		this.fechaAdquisicion = fechaAdquisicion;
		this.estado = estado;
	}

	public Long getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(Long idEquipo) {
		this.idEquipo = idEquipo;
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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Long getIdSede() {
		return idSede;
	}

	public void setIdSede(Long idSede) {
		this.idSede = idSede;
	}

	public String getSede() {
		return sede;
	}

	public void setSede(String sede) {
		this.sede = sede;
	}

	public LocalDate getFechaAdquisicion() {
		return fechaAdquisicion;
	}

	public void setFechaAdquisicion(LocalDate fechaAdquisicion) {
		this.fechaAdquisicion = fechaAdquisicion;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
}
