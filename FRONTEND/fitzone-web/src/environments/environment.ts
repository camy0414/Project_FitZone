// Configuración de la aplicación.
// useMock = true  -> usa datos de ejemplo en memoria (no necesita el backend).
// useMock = false -> consume la API REST de Spring Boot en apiUrl.
export const environment = {
  useMock: true,
  apiUrl: 'http://192.168.56.13:8080/api',
};
