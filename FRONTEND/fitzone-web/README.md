# FitZone Web (Angular 21)

Front del proyecto FitZone (Bases de Datos 2). Es la versión Angular del boceto de Figma
(Next.js + Payload), con el mismo diseño y alineada con el modelo final:
acceso solo para el personal, cuatro roles y filtro por sede.

## Cómo correrlo en Visual Studio Code

Requisitos: Node.js 20.19+ o 22.12+ (recomendado 22) y VS Code.

```bash
cd fitzone-web
npm install          # el archivo .npmrc ya trae legacy-peer-deps=true
npm start            # abre http://localhost:4200
```

En el modo demostración (por defecto) no necesita el backend. Para entrar: en la pantalla de login
toca uno de los botones de rol (Administrador, Gerente, Recepción o Entrenador); llenan el correo y la
contraseña solos, y luego pulsa **Ingresar**. Contraseña de todos los usuarios de ejemplo: `Fitzone2026*`
(administrador: `admin@fitzone.example.com`). Los botones solo aparecen con `useMock: true`.

Extensiones útiles: *Angular Language Service*, *Tailwind CSS IntelliSense*, *Prettier*.

## Conectarlo al backend (Spring Boot)

1. Abrir `src/environments/environment.ts`.
2. Poner `useMock: false` y la URL del backend en `apiUrl` (por ejemplo `http://192.168.56.13:8080/api`).
3. En Spring Boot habilitar CORS para `http://localhost:4200`.

No hay que tocar ningún componente: `DataService` tiene dos implementaciones
(`MockDataService` y `HttpDataService`) y `app.config.ts` elige una según `useMock`.

### Contrato de la API que espera el front

Todas las respuestas son JSON en camelCase. Las peticiones llevan `Authorization: Bearer <token>`.
El **backend** debe filtrar por sede según el empleado del token (el administrador ve todas)
y ejecutar `SET ROLE` del rol de BD correspondiente.

| Método y ruta | Respuesta / efecto |
|---|---|
| `POST /auth/login` `{correo, clave}` | `{token, usuario:{idEmpleado, nombre, correo, rol, idSede, sede}}` (usa `fn_login`) |
| `GET /sedes`, `/empleados`, `/miembros`, `/membresias`, `/pagos`, `/clases`, `/sesiones`, `/equipos`, `/mantenimientos` | Listas (`Sede[]`, `Empleado[]`…). Filtradas por sede según el token; el entrenador solo ve sus clases/sesiones. `Empleado` nunca incluye la contraseña. |
| `GET /sesiones/{n}/inscripciones` | `Inscripcion[]` de la sesión |
| `GET /catalogos/planes`, `/metodos-pago`, `/tipos-equipo`, `/roles` | `{id, nombre}[]` |
| `POST /sedes` | crea sede |
| `POST /empleados` | `sp_crear_empleado` (hash de la clave con pgcrypto, mínimo 8 caracteres) |
| `PATCH /empleados/{id}/estado` `{activo}` | `sp_cambiar_estado_empleado` |
| `POST /miembros` | crea miembro (+ `infoMedica` opcional) |
| `POST /membresias/renovar` `{idMiembro, idTipoPlan, monto, idMetodoPago}` | `sp_renovar_membresia` (membresía + pago en una transacción) |
| `POST /clases`, `POST /sesiones`, `POST /equipos`, `POST /mantenimientos` | crean el registro (los triggers validan las reglas) |
| `POST /sesiones/{n}/inscripciones` `{idMiembro}` | `sp_registrar_inscripcion` |
| `PATCH /sesiones/{n}/inscripciones/{idMiembro}` `{asistio}` | marca asistencia |
| `GET /rutinas`, `GET /progreso` | MongoDB. `Rutina[]` y `Progreso[]`, filtrados por sede del token (el admin ve todas) |
| `POST /rutinas` `{idMiembro, nombreRutina, objetivo?, ejercicios[], notasEntrenador?}` | solo ENTRENADOR_SEDE. El backend toma `idEmpleado` e `idSede` del token, comprueba en PostgreSQL que el miembro existe y es de la misma sede, y escribe en MongoDB |
| `PATCH /rutinas/{id}/estado` `{activa}` | activa o desactiva una rutina |
| `POST /progreso` `{idMiembro, fecha, pesoKg, grasaPct?, medidas?, notas?}` | solo ENTRENADOR_SEDE; mismas comprobaciones que la rutina |

Nota: el entrenador necesita `GET /miembros` (solo id y nombre, de su sede) para elegir el miembro en los formularios de rutinas y progreso.

Las escrituras responden `{mensaje}`. Si una regla de la BD falla, el backend debe responder 4xx con
`{mensaje}` = el texto del `RAISE EXCEPTION`; el front lo muestra tal cual al usuario.

Los tipos exactos están en `src/app/core/models.ts`.

## Roles y pantallas

| Rol | Pantallas |
|---|---|
| `ADMIN_SISTEMA` | Todas las vistas |
| `GERENTE_SEDE` | Resumen, Clases, Sesiones, Equipos, Mantenimiento, Miembros, Membresías, Pagos, Personal, Rutinas y Progreso (solo lectura) |
| `RECEPCIONISTA_SEDE` | Resumen, Miembros, Membresías, Pagos, Inscripciones, Agenda |
| `ENTRENADOR_SEDE` | Mi jornada, Mis clases, Sesiones, Asistencia, Rutinas (crea y activa/desactiva), Progreso físico (registra mediciones) |

El menú está en `core/menu.ts` (`MENU`) y los permisos por ruta en `ACCESO` (mismo archivo).
Si un rol abre una ruta que no le corresponde, vuelve a su pantalla inicial.
Estos permisos deben coincidir con los `GRANT` de la base de datos (script 01).

## Estructura

Un componente por carpeta, cada uno con su `.ts` y su `.html`:

```
src/app/
  core/                 modelos, DataService (mock/http), auth, guards, interceptor, menú por rol
  layout/shell/         estructura de la app: barra lateral + barra superior
  shared/
    components/         icon, panel, fila, vacio, modal, status-pill, avatar, toasts
    pipes/              cop (moneda), fecha
    services/           search (buscador superior), toast (avisos)
    utils/              util.ts (mensajeError, hoyISO)
  features/             una carpeta por vista (componente + plantilla + formulario):
                        login, resumen, sedes, empleados, miembros, membresias, pagos,
                        clases, sesiones, inscripciones, asistencia, equipos, mantenimiento,
                        rutinas, progreso (MongoDB)
```

Cada vista se carga por separado (lazy loading) en `app.routes.ts`, protegida por `roleGuard`.
Los formularios son reactivos, validan en el front y muestran el mensaje de la BD si una regla falla
(mismas reglas en `MockDataService`: clave ≥ 8, correo único, cupo, membresía vigente, entrenador de la misma sede…).

## Qué falta (siguientes pasos)

- Backend Spring Boot (JDBC + MongoDB) que implemente el contrato de arriba.
- Edición de registros existentes (hoy solo se crean) y paginación para listas grandes.
- Manejo de 401 contra el backend real (cerrar sesión si el token expira).
