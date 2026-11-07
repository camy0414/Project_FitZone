import { FechaPipe } from './fecha.pipe';

describe('FechaPipe', () => {
  const pipe = new FechaPipe();

  it('muestra día y mes sin correr la fecha por la zona horaria', () => {
    expect(pipe.transform('2026-10-20')).toMatch(/^20 oct/);
  });

  it('agrega el año cuando se pide', () => {
    expect(pipe.transform('2026-10-20', true)).toContain('2026');
  });

  it('devuelve texto vacío si no hay fecha', () => {
    expect(pipe.transform(null)).toBe('');
  });
});
