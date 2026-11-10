// Configuración de la aplicación.
export const environment = {
  // Dirección del backend Spring Boot (server.port=8095 en application.properties).
  apiUrl: 'http://localhost:8095',

  // true  -> el login se hace contra el backend (POST /auth/login, usuarios de la base de datos).
  // false -> login con los usuarios de ejemplo (no necesita el backend).
  loginReal: true,

  // false -> las pantallas consumen el backend. Lo que aún no tiene endpoint (rutinas, progreso,
  //          análisis MongoDB y los reportes de ingresos y mantenimientos) sigue con datos de ejemplo.
  // true  -> todas las pantallas usan datos de ejemplo (para mostrar el front sin backend).
  useMock: false,
};