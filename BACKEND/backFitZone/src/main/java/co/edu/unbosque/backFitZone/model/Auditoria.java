package co.edu.unbosque.backFitZone.model;

import java.time.LocalDateTime;

public class Auditoria {

	private Long idAuditoria;
	private String tabla;
	private String operacion;
	private String idRegistro;
	private String rolBd;
	private Long idEmpleado;
	private LocalDateTime fecha;

	public Auditoria() {
		
	}

	public Auditoria(Long idAuditoria, String tabla, String operacion, String idRegistro, String rolBd, Long idEmpleado,
			LocalDateTime fecha) {
		super();
		this.idAuditoria = idAuditoria;
		this.tabla = tabla;
		this.operacion = operacion;
		this.idRegistro = idRegistro;
		this.rolBd = rolBd;
		this.idEmpleado = idEmpleado;
		this.fecha = fecha;
	}


	public Long getIdAuditoria() {
		return idAuditoria;
	}

	public void setIdAuditoria(Long idAuditoria) {
		this.idAuditoria = idAuditoria;
	}

	public String getTabla() {
		return tabla;
	}

	public void setTabla(String tabla) {
		this.tabla = tabla;
	}

	public String getOperacion() {
		return operacion;
	}

	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}

	public String getIdRegistro() {
		return idRegistro;
	}

	public void setIdRegistro(String idRegistro) {
		this.idRegistro = idRegistro;
	}

	public String getRolBd() {
		return rolBd;
	}

	public void setRolBd(String rolBd) {
		this.rolBd = rolBd;
	}

	public Long getIdEmpleado() {
		return idEmpleado;
	}

	public void setIdEmpleado(Long idEmpleado) {
		this.idEmpleado = idEmpleado;
	}

	public LocalDateTime getFecha() {
		return fecha;
	}

	public void setFecha(LocalDateTime fecha) {
		this.fecha = fecha;
	}
}
