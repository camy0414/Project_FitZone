// Validaciones del front: mismas reglas del modelo y de los supuestos, para avisar antes de enviar.
// El backend y la base de datos vuelven a validar todo.

// ---------- Longitudes y valores del modelo relacional ----------
/**
 * Longitudes máximas de las columnas VARCHAR del modelo relacional (Data Modeler).
 * Los formularios las usan en `Validators.maxLength` y en el atributo `maxlength`,
 * así un dato que la base de datos rechazaría no sale del front.
 */
export const LIMITES = {
  sede: { nombre: 50, direccion: 100, telefono: 20 },
  persona: { nombre: 30, apellido: 30, telefono: 15, correo: 60 },
  infoMedica: { contactoEmergencia: 20, condicionMedica: 100 },
  clase: { nombre: 50, descripcion: 100 },
  equipo: { nombre: 30 },
  mantenimiento: { descripcion: 100 },
} as const;

/**
 * Formatos de texto. Validators.email de Angular acepta correos sin dominio (ana@gmail),
 * por eso el correo también lleva su propio patrón.
 */
export const PATRONES = {
  /** Letras (con tildes y ñ); varias palabras separadas por un espacio, apóstrofo o guion. */
  nombre: /^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?:[ '-][A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*$/,
  /** Solo dígitos, de 7 a 15, con + opcional al inicio para el indicativo. */
  telefono: /^\+?\d{7,15}$/,
  /** usuario@dominio.ext */
  correo: /^[^\s@]+@[^\s@]+\.[A-Za-z]{2,}$/,
} as const;

/** Mensaje para mostrar debajo de un campo según el error que tenga. */
export const MENSAJE_FORMATO = {
  nombre: 'Solo letras, sin números ni símbolos.',
  telefono: 'Solo números (7 a 15 dígitos).',
  correo: 'Escribe un correo válido.',
} as const;

/** Valores permitidos para info_medica.tipo_sangre (VARCHAR(5)). */
export const TIPOS_SANGRE = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'] as const;

/** Duración máxima de una sesión, en minutos (supuesto 10). */
export const DURACION_MAX_SESION_MIN = 180;

// ---------- Reglas de horario de una sesión (supuesto 10) ----------

/** 'HH:MM' -> minutos desde la medianoche. */
export const aMinutos = (hora: string): number => {
  const [h, m] = hora.split(':').map(Number);
  return h * 60 + m;
};

/** Texto legible de una duración en minutos: 90 -> "1 h 30 min". */
export const textoDuracion = (min: number): string => {
  const h = Math.floor(min / 60), m = min % 60;
  return [h ? `${h} h` : '', m ? `${m} min` : ''].filter(Boolean).join(' ') || '0 min';
};

/** Hora local actual en formato HH:MM. */
const horaActual = (): string => {
  const f = new Date();
  return `${String(f.getHours()).padStart(2, '0')}:${String(f.getMinutes()).padStart(2, '0')}`;
};

/**
 * Valida fecha y horas de una sesión nueva. Devuelve el mensaje del primer error o null.
 * `hoy` en formato YYYY-MM-DD (hora local).
 */
export function validarHorarioSesion(fecha: string, horaInicio: string, horaFin: string, hoy: string): string | null {
  if (fecha < hoy) return `No se puede programar una sesión en una fecha pasada (${fecha}).`;
  if (fecha === hoy && horaInicio <= horaActual()) return 'La hora de inicio ya pasó: elige una hora posterior a la actual.';
  const duracion = aMinutos(horaFin) - aMinutos(horaInicio);
  if (duracion <= 0) return 'La hora de fin debe ser posterior a la hora de inicio.';
  if (duracion > DURACION_MAX_SESION_MIN) {
    return `Una sesión no puede durar más de ${textoDuracion(DURACION_MAX_SESION_MIN)} (esta dura ${textoDuracion(duracion)}).`;
  }
  return null;
}

/** ¿Se cruzan dos franjas del mismo día? (Terminar 10:00 y empezar 10:00 no es cruce.) */
export const seCruzan = (
  a: { horaInicio: string; horaFin: string },
  b: { horaInicio: string; horaFin: string },
): boolean => a.horaInicio < b.horaFin && b.horaInicio < a.horaFin;