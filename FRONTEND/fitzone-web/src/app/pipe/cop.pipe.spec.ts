import { CopPipe } from './cop.pipe';

describe('CopPipe', () => {
  const pipe = new CopPipe();

  it('formatea pesos colombianos sin decimales', () => {
    const texto = pipe.transform(90000);
    expect(texto).toContain('90.000');
    expect(texto).toContain('$');
  });
});
