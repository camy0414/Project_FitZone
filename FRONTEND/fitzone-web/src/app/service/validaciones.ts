import { AbstractControl, ValidationErrors, ValidatorFn, Validators } from '@angular/forms';

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
  // Los espacios al inicio o al final se aceptan: se quitan antes de enviar.
  nombre: /^\s*[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?:[ '-][A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*\s*$/,
  /** Solo dígitos, de 7 a 15, con + opcional al inicio para el indicativo. */
  telefono: /^\s*\+?\d{7,15}\s*$/,
  /** usuario@dominio.ext */
  correo: /^\s*[^\s@]+@[^\s@]+\.[A-Za-z]{2,}\s*$/,
} as const;

/** Mensaje para mostrar debajo de un campo según el error que tenga. */
export const MENSAJE_FORMATO = {
  nombre: 'Solo letras, sin números ni símbolos.',
  telefono: 'Solo números (7 a 15 dígitos).',
  correo: 'Escribe un correo válido.',
} as const;

/** Valor máximo de las columnas NUMERIC(10,2) (pago.monto y mantenimiento_equipo.costo). */
export const MONTO_MAXIMO = 99_999_999;

/** Días máximos hacia adelante para programar una sesión (evita fechas mal escritas, como el año 20261). */
export const DIAS_MAX_PROGRAMACION = 365;

// ---------- Validadores reutilizables de los formularios ----------

/** Obligatorio que además rechaza los textos con solo espacios. Devuelve el error `required`. */
export const requerido: ValidatorFn = (c: AbstractControl): ValidationErrors | null =>
  typeof c.value === 'string' && !c.value.trim() ? { required: true } : Validators.required(c);

/** Número entero (sin decimales). Error `entero`. */
export const entero: ValidatorFn = (c: AbstractControl): ValidationErrors | null =>
  c.value === null || c.value === '' || Number.isInteger(+c.value) ? null : { entero: true };

/** Fecha YYYY-MM-DD que no supere `max` (por defecto, hoy). Error `futura`. */
export const fechaHasta = (max: () => string): ValidatorFn => (c: AbstractControl): ValidationErrors | null =>
  c.value && c.value > max() ? { futura: true } : null;

/** Fecha YYYY-MM-DD que no sea anterior a `min`. Error `antigua`. */
export const fechaDesde = (min: () => string): ValidatorFn => (c: AbstractControl): ValidationErrors | null =>
  c.value && c.value < min() ? { antigua: true } : null;

/** ¿Ya empezó una sesión (fecha + hora de inicio) respecto al momento actual? */
export function sesionIniciada(fecha: string, horaInicio: string, ahora = new Date()): boolean {
  const hoy = `${ahora.getFullYear()}-${String(ahora.getMonth() + 1).padStart(2, '0')}-${String(ahora.getDate()).padStart(2, '0')}`;
  if (fecha !== hoy) return fecha < hoy;
  const hora = `${String(ahora.getHours()).padStart(2, '0')}:${String(ahora.getMinutes()).padStart(2, '0')}`;
  return (horaInicio ?? '').slice(0, 5) <= hora;
}

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
  if (!fecha) return 'Elige la fecha de la sesión.';
  if (fecha < hoy) return 'No se puede programar una sesión en una fecha pasada.';
  const [a, m, d] = hoy.split('-').map(Number);
  const limite = new Date(a, m - 1, d + DIAS_MAX_PROGRAMACION);
  const max = `${limite.getFullYear()}-${String(limite.getMonth() + 1).padStart(2, '0')}-${String(limite.getDate()).padStart(2, '0')}`;
  if (fecha > max) return 'Solo se pueden programar sesiones hasta con un año de anticipación.';
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