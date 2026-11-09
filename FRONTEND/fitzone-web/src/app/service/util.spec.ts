import { estadoInscripcion, mensajeError } from './util';

describe('util', () => {
  it('usa primero el mensaje que manda el backend', () => {
    expect(mensajeError({ status: 403, error: { mensaje: 'Los pagos son inmutables.' } })).toBe('Los pagos son inmutables.');
  });

  it('da un mensaje genérico para 403 sin mensaje', () => {
    expect(mensajeError({ status: 403 })).toContain('permiso');
  });

  it('traduce la asistencia a estado', () => {
    expect(estadoInscripcion({ asistio: null })).toBe('pendiente');
    expect(estadoInscripcion({ asistio: true })).toBe('asistió');
    expect(estadoInscripcion({ asistio: false })).toBe('no asistió');
  });
});
