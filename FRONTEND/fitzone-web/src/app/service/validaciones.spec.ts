import { PATRONES, aMinutos, seCruzan, textoDuracion, validarHorarioSesion } from './validaciones';

describe('validaciones de sesión', () => {
  const futuro = '2099-01-01';
  const hoy = '2026-10-28';

  it('convierte horas a minutos', () => {
    expect(aMinutos('01:30')).toBe(90);
  });

  it('escribe la duración en horas y minutos', () => {
    expect(textoDuracion(90)).toBe('1 h 30 min');
    expect(textoDuracion(180)).toBe('3 h');
  });

  it('acepta una sesión válida', () => {
    expect(validarHorarioSesion(futuro, '09:00', '12:00', hoy)).toBeNull();
  });

  it('rechaza una sesión de más de 3 horas', () => {
    expect(validarHorarioSesion(futuro, '12:05', '16:50', hoy)).toContain('más de 3 h');
  });

  it('rechaza fin antes del inicio', () => {
    expect(validarHorarioSesion(futuro, '15:00', '14:00', hoy)).toContain('posterior');
  });

  it('rechaza fechas pasadas', () => {
    expect(validarHorarioSesion('2020-01-01', '09:00', '10:00', hoy)).toContain('fecha pasada');
  });

  it('detecta cruces de horario', () => {
    expect(seCruzan({ horaInicio: '12:05', horaFin: '16:50' }, { horaInicio: '14:20', horaFin: '15:00' })).toBe(true);
    expect(seCruzan({ horaInicio: '09:00', horaFin: '10:00' }, { horaInicio: '10:00', horaFin: '11:00' })).toBe(false);
  });
});

describe('PATRONES', () => {
  it('nombre: acepta letras con tildes y varias palabras; rechaza números', () => {
    for (const ok of ['Martínez', 'María José', "D'Angelo", 'Peña-Gómez']) expect(PATRONES.nombre.test(ok)).toBe(true);
    for (const mal of ['Suare7', 'Ana!', ' Ana', 'Ana  Luz']) expect(PATRONES.nombre.test(mal)).toBe(false);
  });

  it('teléfono: solo dígitos (7 a 15) con + opcional', () => {
    for (const ok of ['3001234567', '+573001234567', '6012345']) expect(PATRONES.telefono.test(ok)).toBe(true);
    for (const mal of ['dfsdv', '300 123 4567', '123']) expect(PATRONES.telefono.test(mal)).toBe(false);
  });

  it('correo: exige dominio completo', () => {
    expect(PATRONES.correo.test('ana@gmail.com')).toBe(true);
    expect(PATRONES.correo.test('ana@gmail')).toBe(false);
  });
});