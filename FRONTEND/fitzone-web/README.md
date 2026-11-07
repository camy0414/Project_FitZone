# FitZone Web (Angular 21)

Front del proyecto FitZone (Bases de Datos 2). Es la versión Angular del boceto de Figma
(Next.js + Payload), con el mismo diseño y alineada con el modelo final:
acceso solo para el personal, cuatro roles y filtro por sede.

## Cómo correrlo en Visual Studio Code

Requisitos: Node.js 20.19+ o 22.12+ (recomendado 22) y VS Code.

```bash
cd fitzone-web
npm install          # (no npm ci: package.json cambió y el lock se actualiza al instalar)
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
(`MockDataService` y `HttpDataService`) y `app-module.ts` elige una según `useMock`.

### Contrato de la API que espera el front

Todas las respuestas son JSON en camelCase. Las peticiones llevan `Authorization: Bearer <token>`.
El **backend** debe filtrar por sede según el empleado del token (el administrador ve todas)
y ejecutar `SET ROLE` del rol de BD correspondiente.

| Método y ruta | Respuesta / efecto |
|---|---|
| `POST /auth/login` `{correo, clave}` | `{token, usuario:{idEmpleado, nombre, correo, rol, idSede, sede}}` |
| `GET /sedes`, `/empleados`, `/miembros`, `/membresias`, `/pagos`, `/clases`, `/sesiones`, `/equipos`, `/mantenimientos` | Listas (`Sede[]`, `Empleado[]`…). Filtradas por sede según el token; el entrenador solo ve sus clases/sesiones. `Empleado` nunca incluye la contraseña. `Empleado` y `Miembro` traen los cuatro campos de nombre además de `nombreCompleto`. |
| `GET /miembros?alcance=cadena` | `Miembro[]` de todas las sedes (recepción inscribe miembros de cualquier sede, supuesto 5) |
| `GET /miembros/{id}` | `MiembroDetalle`: miembro, `infoMedica` (o `null`), membresías, pagos e inscripciones |
| `GET /sesiones/{n}/inscripciones` | `Inscripcion[]` de la sesión (`asistio` puede ser `null` = sin registrar) |
| `GET /catalogos/planes`, `/metodos-pago`, `/tipos-equipo`, `/roles` | `{id, nombre}[]` |
| `POST /sedes` · `PUT /sedes/{id}` | crea / edita sede (solo administrador) |
| `POST /empleados` · `PUT /empleados/{id}` | crea (con clave inicial, mínimo 8 caracteres, guardada como hash) / edita datos, rol y sede (sin clave) |
| `PATCH /empleados/{id}/estado` `{activo}` | activa o desactiva (nunca el último administrador) |
| `POST /miembros` · `PUT /miembros/{id}` | crea / edita miembro con `infoMedica` opcional; en la edición, `infoMedica` ausente = se elimina |
| `POST /membresias/renovar` `{idMiembro, idTipoPlan, monto, idMetodoPago}` | membresía + pago en una sola transacción |
| `POST /clases` · `PUT /clases/{id}`, `POST /sesiones`, `POST /equipos` · `PUT /equipos/{id}`, `POST /mantenimientos` | crean o editan el registro |
| `POST /sesiones/{n}/inscripciones` `{idMiembro}` | inscribe (membresía vigente, cupo, sesión futura) |
| `PATCH /sesiones/{n}/inscripciones/{idMiembro}` `{asistio}` | marca asistencia |
| `GET /reportes/ingresos?desde&hasta&idSede?` | `ReporteIngreso[]` (pagos por sede y método) |
| `GET /reportes/ocupacion?desde&hasta&idSede?` | `ReporteOcupacion[]` (inscritos, cupo y asistentes por sesión) |
| `GET /reportes/membresias-por-vencer?dias&idSede?` | `MembresiaPorVencer[]` |
| `GET /reportes/mantenimientos?desde&hasta&idSede?` | `ReporteMantenimiento[]` (costo por sede y tipo de equipo) |
| `GET /rutinas`, `GET /progreso` | MongoDB. `Rutina[]` y `Progreso[]`, filtrados por sede del token (el admin ve todas) |
| `POST /rutinas` · `PUT /rutinas/{id}` · `DELETE /rutinas/{id}` | CRUD de rutinas. Solo el entrenador que la creó la edita o elimina; el backend toma `idEmpleado` e `idSede` del token y comprueba en PostgreSQL que el miembro es de su sede |
| `PATCH /rutinas/{id}/estado` `{activa}` | activa o desactiva una rutina |
| `POST /progreso` · `PUT /progreso/{id}` · `DELETE /progreso/{id}` | CRUD de mediciones (entrenador de la sede) |
| `GET /rutinas/analisis` | `AnalisisMongo`: resultado de los pipelines de `component/analisis/pipelines.ts` |

`idSede` en los reportes es opcional y solo lo envía el administrador; para los demás roles el backend usa la sede del token.

Nota: el entrenador necesita `GET /miembros` (solo id y nombre, de su sede) para elegir el miembro en los formularios de rutinas y progreso.

Las escrituras responden `{mensaje}`. Si una regla de la BD falla, el backend debe responder 4xx con
`{mensaje}` = el texto del `RAISE EXCEPTION`; el front lo muestra tal cual al usuario.

Los tipos exactos están en `src/app/model/` y siguen el **modelo relacional de Data Modeler**
(no los scripts, que siguen en revisión). Algunos valores a tener en cuenta en el backend:

- `Membresia.estado`: `'ACTIVA' | 'VENCIDA'`.
- `Equipo.ultimoMantenimiento`: fecha del mantenimiento más reciente o `null` (el modelo no guarda estado del equipo).
- `Mantenimiento.fechaMantenimiento` (columna `fecha_mantenimiento`); `descripcion` y `Clase.descripcion` pueden ser `null`.
- `Miembro.fechaRegistro` (columna `fecha_registro`).
- Longitudes máximas de los campos de texto: `src/app/service/validaciones.ts` (mismas del modelo).

## Roles y pantallas

| Rol | Pantallas |
|---|---|
| `ADMIN_SISTEMA` | Todas las vistas; edita sedes, empleados, miembros, clases y equipos |
| `GERENTE_SEDE` | Resumen, Clases, Sesiones, Equipos, Mantenimiento, Miembros, Membresías, Pagos, Personal, Rutinas y Progreso (solo lectura), Análisis, Reportes |
| `RECEPCIONISTA_SEDE` | Resumen, Miembros (crea y edita), Membresías, Pagos, Inscripciones, Agenda, Reportes (ingresos, ocupación, por vencer) |
| `ENTRENADOR_SEDE` | Mi jornada, Mis clases, Sesiones, Asistencia, Rutinas y Progreso físico (CRUD), Análisis, Mis reportes (ocupación) |

El menú está en `service/menu.ts` (`MENU`) y los permisos por ruta en `ACCESO` (mismo archivo).
Si un rol abre una ruta que no le corresponde, vuelve a su pantalla inicial.
Estos permisos deben coincidir con los `GRANT` de la base de datos (script 01).

## Estructura

Organizado como los proyectos Angular con módulos: un `AppModule` que declara todos los
componentes (`standalone: false`) y un `AppRoutingModule` con las rutas.

```
src/app/
  app-module.ts          declara componentes y pipes; importa formularios, rutas e íconos; registra servicios
  app-routing-module.ts  rutas (login, layout con las pantallas internas) y permisos por rol
  app.ts / app.html      componente raíz (solo <router-outlet />)
  component/             un componente por carpeta: .ts, .html, .css y .spec.ts
    layout, sidebar, navbar          estructura de las pantallas internas
    login, resumen, sedes, empleados, miembros, miembro-form, miembro-detalle, membresias, pagos,
    clases, sesiones, inscripciones, asistencia, equipos, mantenimiento,
    rutinas, progreso, analisis (MongoDB),
    reportes, reporte-ingresos, reporte-ocupacion, reporte-por-vencer, reporte-mantenimientos
    avatar, barra, confirmar, fila, icon, indicador, modal, panel, status-pill, toasts, vacio   (piezas reutilizables)
  model/                 un archivo por tabla o colección: sede, empleado, miembro, membresia, pago, clase,
                         sesion, equipo, catalogo, usuario, persona, rutina, progreso, reporte, analisis
  service/               auth, guards, token.interceptor, sesion.store, menu (menú y permisos por rol),
                         data.service (contrato) + http-data.service (API) + mock-data.service y datos-ejemplo (modo visual),
                         validaciones (longitudes del modelo y reglas de sesión), notificacion (avisos), buscador, util
  pipe/                  cop (moneda), fecha
```

Para crear un componente nuevo: `ng generate component component/nombre` (ya sale con `standalone: false`)
y declararlo en `app-module.ts`; si es una pantalla, agregar su ruta en `app-routing-module.ts` y su
permiso en `ACCESO` (`service/menu.ts`).

Los formularios son reactivos, validan en el front y muestran el mensaje de la BD si una regla falla
(mismas reglas en `MockDataService`: clave ≥ 8, correo único, cupo, membresía vigente, entrenador de la misma sede,
sesiones sin cruces y de máximo 3 horas…).

## Pruebas

`npm test` corre las pruebas con Vitest (`ng test`). Cada componente tiene su `.spec.ts`
(comprueba que se crea con `AppModule`), y hay pruebas de las reglas en `service/validaciones.spec.ts`,
`service/util.spec.ts` y los pipes.

## Qué falta (siguientes pasos)

- Backend Spring Boot (JDBC + MongoDB) que implemente el contrato de arriba.
- Paginación para listas grandes.
- Manejo de 401 contra el backend real (cerrar sesión si el token expira).
