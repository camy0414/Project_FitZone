import { enlaceReproductor, idYoutube } from './video';

describe('idYoutube', () => {
  it('reconoce los formatos de enlace de YouTube', () => {
    expect(idYoutube('https://www.youtube.com/watch?v=dQw4w9WgXcQ')).toBe('dQw4w9WgXcQ');
    expect(idYoutube('https://youtu.be/dQw4w9WgXcQ?t=30')).toBe('dQw4w9WgXcQ');
    expect(idYoutube('https://m.youtube.com/watch?v=dQw4w9WgXcQ&list=x')).toBe('dQw4w9WgXcQ');
    expect(idYoutube('https://youtube.com/shorts/dQw4w9WgXcQ')).toBe('dQw4w9WgXcQ');
  });

  it('devuelve null si el enlace no es de un video de YouTube', () => {
    expect(idYoutube('https://fitzone.example.com/videos/peso-muerto')).toBeNull();
    expect(idYoutube('https://www.youtube.com/@canal')).toBeNull();
    expect(idYoutube('no es un enlace')).toBeNull();
    expect(idYoutube(undefined)).toBeNull();
  });

  it('arma la dirección del reproductor', () => {
    expect(enlaceReproductor('dQw4w9WgXcQ')).toContain('youtube-nocookie.com/embed/dQw4w9WgXcQ');
  });
});
