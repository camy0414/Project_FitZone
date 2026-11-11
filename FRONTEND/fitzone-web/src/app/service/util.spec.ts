import { estadoInscripcion, mensajeError, nombrePropio } from './util';

describe('util', () => {
  it('usa primero el mensaje que manda el backend', () => {
    expect(mensajeError({ status: 403, error: { mensaje: 'Los pagos son inmutables.' } })).toBe('Los pagos son inmutables.');
  });

  it('da un mensaje genérico para 403 sin mensaje', () => {
    expect(mensajeError({ status: 403 })).toContain('permiso');
  });

  it('no muestra los errores internos del servidor', () => {
    expect(mensajeError({ status: 500, error: 'Error al acceder a la base de datos' })).toContain('problema en el servidor');
  });

  it('muestra los errores del modo de ejemplo', () => {
    expect(mensajeError(new Error('Correo o contraseña incorrectos.'))).toBe('Correo o contraseña incorrectos.');
  });

  it('una sesión futura aparece como inscrito', () => {
    expect(estadoInscripcion({ asistio: false, fecha: '2099-01-01', horaInicio: '08:00' })).toBe('inscrito');
  });

  it('escribe los nombres de catálogo con mayúscula inicial', () => {
    expect(nombrePropio('TARJETA')).toBe('Tarjeta');
  });

  it('traduce la asistencia a estado', () => {
    expect(estadoInscripcion({ asistio: null })).toBe('pendiente');
    expect(estadoInscripcion({ asistio: true })).toBe('asistió');
    expect(estadoInscripcion({ asistio: false })).toBe('no asistió');
  });
});
