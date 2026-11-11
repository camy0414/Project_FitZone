/**
 * Saca el código de un video de YouTube a partir del enlace que pegó el entrenador.
 * Acepta youtube.com/watch?v=…, youtu.be/…, youtube.com/shorts/… y youtube.com/embed/….
 * Devuelve null si el enlace no es de YouTube (entonces se abre en otra pestaña).
 */
export function idYoutube(enlace: string | null | undefined): string | null {
  if (!enlace) return null;
  let url: URL;
  try {
    url = new URL(enlace.trim());
  } catch {
    return null;
  }
  const host = url.hostname.replace(/^(www\.|m\.)/, '');
  let id: string | null = null;
  if (host === 'youtu.be') id = url.pathname.slice(1);
  else if (host === 'youtube.com' || host === 'youtube-nocookie.com') {
    if (url.pathname === '/watch') id = url.searchParams.get('v');
    else {
      const partes = url.pathname.split('/');
      if (['shorts', 'embed', 'live'].includes(partes[1])) id = partes[2] ?? null;
    }
  }
  // los códigos de YouTube tienen 11 caracteres: letras, números, - y _
  return id && /^[A-Za-z0-9_-]{11}$/.test(id) ? id : null;
}

/** Dirección para reproducir el video dentro de la página (versión sin cookies de YouTube). */
export function enlaceReproductor(id: string): string {
  return `https://www.youtube-nocookie.com/embed/${id}?autoplay=1&rel=0`;
}
