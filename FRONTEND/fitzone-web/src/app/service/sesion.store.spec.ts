import { tokenVigente } from './sesion.store';

const jwt = (exp: number) => `x.${btoa(JSON.stringify({ sub: 'a@b.co', exp }))}.y`;

describe('tokenVigente', () => {
  const ahora = Math.floor(Date.now() / 1000);

  it('acepta un token que vence en el futuro', () => {
    expect(tokenVigente(jwt(ahora + 3600))).toBe(true);
  });

  it('rechaza un token vencido', () => {
    expect(tokenVigente(jwt(ahora - 10))).toBe(false);
  });

  it('rechaza cuando no hay token', () => {
    expect(tokenVigente(null)).toBe(false);
  });

  it('acepta los tokens del modo de ejemplo (no son JWT)', () => {
    expect(tokenVigente('token-demo-1')).toBe(true);
  });
});