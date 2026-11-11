-- =====================================================================
-- FitZone - Sistema de gestión para una cadena de gimnasios
-- Script 01: Creacion
-- Proyecto Final Bases de Datos 2 - Universidad El Bosque
-- =====================================================================

-- elimina las tablas en orden inverso de dependencia

DROP TABLE IF EXISTS miembro_sesion, mantenimiento_equipo, equipo, tipo_equipo,
                     sesion, clase, empleado, rol_empleado, entrenador, pago,
                     metodo_pago, membresia, tipo_plan, info_medica, miembro,
                     sede CASCADE;
DROP SEQUENCE IF EXISTS seq_tipo_plan, seq_metodo_pago, seq_rol_empleado, seq_tipo_equipo,
                        seq_sede, seq_empleado, seq_miembro, seq_membresia, seq_pago,
                        seq_clase, seq_sesion, seq_equipo, seq_mantenimiento_equipo;

-- ---------------------------------------------------------------------
-- CATÁLOGOS
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_tipo_plan;
CREATE TABLE tipo_plan (
    id_tipo_plan  NUMERIC(10) DEFAULT nextval('seq_tipo_plan'),
    nombre        VARCHAR(20) NOT NULL,
    CONSTRAINT tipo_plan_pk        PRIMARY KEY (id_tipo_plan),
    CONSTRAINT tipo_plan_nombre_u UNIQUE (nombre)
);

CREATE SEQUENCE seq_metodo_pago;
CREATE TABLE metodo_pago (
    id_metodo_pago  NUMERIC(10) DEFAULT nextval('seq_metodo_pago'),
    nombre          VARCHAR(30) NOT NULL,
    CONSTRAINT metodo_pago_pk        PRIMARY KEY (id_metodo_pago),
    CONSTRAINT metodo_pago_nombre_u UNIQUE (nombre)
);

CREATE SEQUENCE seq_rol_empleado;
CREATE TABLE rol_empleado (
    id_rol_empleado  NUMERIC(10) DEFAULT nextval('seq_rol_empleado'),
    nombre           VARCHAR(30) NOT NULL,
    CONSTRAINT rol_empleado_pk        PRIMARY KEY (id_rol_empleado),
    CONSTRAINT rol_empleado_nombre_u UNIQUE (nombre)
);

CREATE SEQUENCE seq_tipo_equipo;
CREATE TABLE tipo_equipo (
    id_tipo_equipo  NUMERIC(10) DEFAULT nextval('seq_tipo_equipo'),
    nombre          VARCHAR(40) NOT NULL,
    CONSTRAINT tipo_equipo_pk        PRIMARY KEY (id_tipo_equipo),
    CONSTRAINT tipo_equipo_nombre_u UNIQUE (nombre)
);

-- ---------------------------------------------------------------------
-- SEDE
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_sede;
CREATE TABLE sede (
    id_sede    NUMERIC(10) DEFAULT nextval('seq_sede'),
    telefono   VARCHAR(20)  NOT NULL,
    nombre     VARCHAR(50)  NOT NULL,
    direccion  VARCHAR(100) NOT NULL,
    CONSTRAINT sede_pk           PRIMARY KEY (id_sede),
    CONSTRAINT sede_nombre_u    UNIQUE (nombre),
    CONSTRAINT sede_direccion_u UNIQUE (direccion)
);

-- ---------------------------------------------------------------------
-- EMPLEADO 
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_empleado;
CREATE TABLE empleado (
    id_empleado       NUMERIC(10) DEFAULT nextval('seq_empleado'),
    primer_nombre     VARCHAR(30)  NOT NULL,
    segundo_nombre    VARCHAR(30),
    primer_apellido   VARCHAR(30)  NOT NULL,
    segundo_apellido  VARCHAR(30),
    telefono          VARCHAR(15)  NOT NULL,
    correo            VARCHAR(60)  NOT NULL,
    contrasena        VARCHAR(100) NOT NULL,   
    activo            BOOLEAN      NOT NULL DEFAULT TRUE,  
    id_rol_empleado   NUMERIC(10)      NOT NULL,
    id_sede           NUMERIC(10)      NOT NULL,
    CONSTRAINT empleado_pk        PRIMARY KEY (id_empleado),
    CONSTRAINT empleado_correo_u UNIQUE (correo),
    CONSTRAINT empleado_correo_ck CHECK (correo LIKE '%_@_%._%'),
    CONSTRAINT empleado_rol_empleado_fk FOREIGN KEY (id_rol_empleado)
        REFERENCES rol_empleado (id_rol_empleado) ON DELETE RESTRICT,
    CONSTRAINT empleado_sede_fk FOREIGN KEY (id_sede)
        REFERENCES sede (id_sede) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- MIEMBRO
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_miembro;
CREATE TABLE miembro (
    id_miembro        NUMERIC(10) DEFAULT nextval('seq_miembro'),
    telefono          VARCHAR(15) NOT NULL,
    correo            VARCHAR(60) NOT NULL,
    primer_nombre     VARCHAR(30) NOT NULL,
    segundo_nombre    VARCHAR(30),
    primer_apellido   VARCHAR(30) NOT NULL,
    segundo_apellido  VARCHAR(30),
    id_sede           NUMERIC(10)     NOT NULL,
    fecha_registro    DATE        NOT NULL DEFAULT CURRENT_DATE,   
    CONSTRAINT miembro_pk        PRIMARY KEY (id_miembro),
    CONSTRAINT miembro_correo_u UNIQUE (correo),
    CONSTRAINT miembro_correo_ck CHECK (correo LIKE '%_@_%._%'),
    CONSTRAINT miembro_sede_fk   FOREIGN KEY (id_sede)
        REFERENCES sede (id_sede) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- INFO_MEDICA
-- ---------------------------------------------------------------------

CREATE TABLE info_medica (
    id_miembro          NUMERIC(10)     NOT NULL,
    contacto_emergencia VARCHAR(20) NOT NULL,
    condicion_medica    VARCHAR(100),
    tipo_sangre         VARCHAR(5)  NOT NULL,
    CONSTRAINT info_medica_pk PRIMARY KEY (id_miembro),
    CONSTRAINT info_medica_tipo_sangre_ck
        CHECK (tipo_sangre IN ('A+','A-','B+','B-','AB+','AB-','O+','O-')),
    CONSTRAINT info_medica_miembro_fk FOREIGN KEY (id_miembro)
        REFERENCES miembro (id_miembro) ON DELETE RESTRICT 
);

-- ---------------------------------------------------------------------
-- MEMBRESIA
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_membresia;
CREATE TABLE membresia (
    id_membresia  NUMERIC(10) DEFAULT nextval('seq_membresia'),
    estado        VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
    fecha_inicio  DATE        NOT NULL,
    fecha_fin     DATE        NOT NULL,
    id_tipo_plan  NUMERIC(10)     NOT NULL,
    id_miembro    NUMERIC(10)     NOT NULL,
    CONSTRAINT membresia_pk         PRIMARY KEY (id_membresia),
    CONSTRAINT membresia_estado_ck  CHECK (estado IN ('ACTIVA','VENCIDA')),
    CONSTRAINT membresia_fechas_ck  CHECK (fecha_fin > fecha_inicio),
    CONSTRAINT membresia_miembro_fk FOREIGN KEY (id_miembro)
        REFERENCES miembro (id_miembro) ON DELETE RESTRICT,
    CONSTRAINT membresia_tipo_plan_fk FOREIGN KEY (id_tipo_plan)
        REFERENCES tipo_plan (id_tipo_plan) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
--PAGO
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_pago;
CREATE TABLE pago (
    id_pago         NUMERIC(10) DEFAULT nextval('seq_pago'),
    fecha_pago      DATE          NOT NULL DEFAULT current_date,  
    monto           NUMERIC(10,2) NOT NULL,
    id_metodo_pago  NUMERIC(10)       NOT NULL,
    id_miembro      NUMERIC(10)       NOT NULL,
    CONSTRAINT pago_pk             PRIMARY KEY (id_pago),
    CONSTRAINT pago_monto_ck       CHECK (monto > 0),
    CONSTRAINT pago_miembro_fk     FOREIGN KEY (id_miembro)
        REFERENCES miembro (id_miembro) ON DELETE RESTRICT,
    CONSTRAINT pago_metodo_pago_fk FOREIGN KEY (id_metodo_pago)
        REFERENCES metodo_pago (id_metodo_pago) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- CLASE
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_clase;
CREATE TABLE clase (
    id_clase       NUMERIC(10) DEFAULT nextval('seq_clase'),
    cupo_maximo    INTEGER     NOT NULL,
    nombre         VARCHAR(50) NOT NULL,
    descripcion    VARCHAR(100),
    id_sede        NUMERIC(10)     NOT NULL,
    id_empleado    NUMERIC(10)     NOT NULL,   
    CONSTRAINT clase_pk            PRIMARY KEY (id_clase),
    CONSTRAINT clase_cupo_ck       CHECK (cupo_maximo > 0),
    CONSTRAINT clase_sede_fk       FOREIGN KEY (id_sede)
        REFERENCES sede (id_sede) ON DELETE RESTRICT,
    CONSTRAINT clase_empleado_fk   FOREIGN KEY (id_empleado)
        REFERENCES empleado (id_empleado) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- SESION
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_sesion;
CREATE TABLE sesion (
    numero_sesion  NUMERIC(10) DEFAULT nextval('seq_sesion'),
    hora_inicio    TIME    NOT NULL,
    hora_fin       TIME    NOT NULL,
    fecha          DATE    NOT NULL,
    id_clase       NUMERIC(10) NOT NULL,
    CONSTRAINT sesion_pk       PRIMARY KEY (numero_sesion),
    CONSTRAINT sesion_horas_ck CHECK (hora_fin > hora_inicio),
    CONSTRAINT sesion_clase_fk FOREIGN KEY (id_clase)
        REFERENCES clase (id_clase) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- MIEMBRO_SESION (Tabla M:M)
-- ---------------------------------------------------------------------
CREATE TABLE miembro_sesion (
    id_miembro        NUMERIC(10) NOT NULL,
    numero_sesion     NUMERIC(10) NOT NULL,
    fecha_inscripcion DATE    NOT NULL DEFAULT CURRENT_DATE,   
    asistio           BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT miembro_sesion_pk PRIMARY KEY (id_miembro, numero_sesion),
    CONSTRAINT miembro_sesion_miembro_fk FOREIGN KEY (id_miembro)
        REFERENCES miembro (id_miembro) ON DELETE RESTRICT,
    CONSTRAINT miembro_sesion_sesion_fk FOREIGN KEY (numero_sesion)
        REFERENCES sesion (numero_sesion) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- EQUIPO
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_equipo;
CREATE TABLE equipo (
    id_equipo          NUMERIC(10) DEFAULT nextval('seq_equipo'),
    fecha_adquisicion  DATE        NOT NULL ,
    nombre             VARCHAR(30) NOT NULL,
    id_tipo_equipo     NUMERIC(10)     NOT NULL,
    id_sede            NUMERIC(10)     NOT NULL,
    CONSTRAINT equipo_pk PRIMARY KEY (id_equipo),
    CONSTRAINT equipo_sede_fk FOREIGN KEY (id_sede)
        REFERENCES sede (id_sede) ON DELETE RESTRICT,
    CONSTRAINT equipo_tipo_equipo_fk FOREIGN KEY (id_tipo_equipo)
        REFERENCES tipo_equipo (id_tipo_equipo) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
--MANTENIMIENTO_EQUIPO
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_mantenimiento_equipo;
CREATE TABLE mantenimiento_equipo (
    numero_mantenimiento  NUMERIC(10) DEFAULT nextval('seq_mantenimiento_equipo'),
    costo                 NUMERIC(10,2) NOT NULL,
    descripcion           VARCHAR(100),
    fecha_mantenimiento   DATE NOT NULL,                     
    id_equipo             NUMERIC(10)   NOT NULL,
    CONSTRAINT mantenimiento_equipo_pk       PRIMARY KEY (numero_mantenimiento),
    CONSTRAINT mantenimiento_equipo_costo_ck CHECK (costo >= 0),
    CONSTRAINT mantenimiento_equipo_equipo_fk FOREIGN KEY (id_equipo)
        REFERENCES equipo (id_equipo) ON DELETE RESTRICT
);

-- -----------------------------------------------------------------
-- ÍNDICES 
-- -----------------------------------------------------------------
CREATE INDEX idx_empleado_sede            ON empleado (id_sede);
CREATE INDEX idx_empleado_rol             ON empleado (id_rol_empleado);
CREATE INDEX idx_miembro_sede             ON miembro (id_sede);
CREATE INDEX idx_membresia_miembro_estado ON membresia (id_miembro, estado);
CREATE INDEX idx_membresia_activa_fin     ON membresia (fecha_fin)  WHERE estado = 'ACTIVA';
CREATE INDEX idx_pago_miembro_fecha       ON pago (id_miembro, fecha_pago);
CREATE INDEX idx_pago_fecha               ON pago (fecha_pago);
CREATE INDEX idx_clase_sede               ON clase (id_sede);
CREATE INDEX idx_clase_empleado          ON clase (id_empleado);
CREATE INDEX idx_sesion_clase_horario ON sesion (id_clase, fecha, hora_inicio);
CREATE INDEX idx_sesion_fecha_horas       ON sesion (fecha, hora_inicio, hora_fin);
CREATE INDEX idx_miembro_sesion_sesion    ON miembro_sesion (numero_sesion);
CREATE INDEX idx_equipo_sede_fecha        ON equipo (id_sede, fecha_adquisicion);
CREATE INDEX idx_mantenimiento_equipo     ON mantenimiento_equipo (id_equipo, fecha_mantenimiento);


CREATE USER fitzone_app LOGIN NOINHERIT PASSWORD '123456' ;
CREATE ROLE rol_admin_sistema;
CREATE ROLE rol_gerente_sede;
CREATE ROLE rol_recepcionista_sede;
CREATE ROLE rol_entrenador_sede;


-- 0. limpieza de permisos sobre esquema public
GRANT CONNECT ON DATABASE "fitzoneDB" TO fitzone_app;
REVOKE ALL ON ALL TABLES    IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL TABLES    IN SCHEMA public
    FROM rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede, fitzone_app;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public
    FROM rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede, fitzone_app;

GRANT USAGE ON SCHEMA public
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede, fitzone_app;


-- actuar después de hacer SET ROLE a uno de estos cargos.
GRANT rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede
    TO fitzone_app;

-- 1. Catálogos: todos pueden leer
GRANT SELECT ON tipo_plan, metodo_pago, rol_empleado, tipo_equipo
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;

-- 2. Sede: todos pueden leer, solo el admin crea y actualiza
GRANT SELECT ON sede
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;
GRANT INSERT ON sede TO rol_admin_sistema;
GRANT USAGE  ON SEQUENCE seq_sede TO rol_admin_sistema;
GRANT UPDATE (nombre, direccion, telefono) ON sede TO rol_admin_sistema;


-- 3. Empleado   lectura de todas las columnas menos contrasena
GRANT SELECT (id_empleado, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
              telefono, correo, activo, id_rol_empleado, id_sede)
    ON empleado TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;


GRANT INSERT ON empleado TO rol_admin_sistema;
GRANT UPDATE (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
              telefono, correo, id_rol_empleado, id_sede)
    ON empleado TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;

GRANT UPDATE (activo) ON empleado TO rol_admin_sistema;
GRANT USAGE ON SEQUENCE seq_empleado TO rol_admin_sistema;

-- 4. Miembro e info médica
GRANT SELECT ON miembro TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede;
GRANT UPDATE (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, correo, id_sede)
    ON miembro TO rol_admin_sistema, rol_recepcionista_sede;

-- Información médica
GRANT SELECT ON info_medica TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede;
GRANT UPDATE (contacto_emergencia, condicion_medica, tipo_sangre)
    ON info_medica TO rol_admin_sistema, rol_recepcionista_sede;    

GRANT SELECT (id_miembro, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, id_sede)
    ON miembro TO rol_entrenador_sede;
GRANT INSERT ON miembro, info_medica TO rol_admin_sistema, rol_recepcionista_sede;
GRANT USAGE  ON SEQUENCE seq_miembro TO rol_admin_sistema, rol_recepcionista_sede;

-- 5. Membresía y pago
GRANT SELECT ON membresia, pago TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede;
GRANT INSERT ON membresia, pago TO rol_admin_sistema, rol_recepcionista_sede;

-- estado cambia al renovar la membresia
GRANT UPDATE (estado) ON membresia TO rol_admin_sistema, rol_recepcionista_sede;
GRANT USAGE ON SEQUENCE seq_membresia, seq_pago TO rol_admin_sistema, rol_recepcionista_sede;

-- pago     No se puede actualizar ni eliminar un pago
REVOKE UPDATE, DELETE ON pago FROM rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;

-- 6. Clase y sesión    gerente crea, recepcionista y entrenador consultan
GRANT SELECT ON clase, sesion
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;
GRANT INSERT ON clase, sesion TO rol_admin_sistema, rol_gerente_sede;
GRANT USAGE  ON SEQUENCE seq_clase, seq_sesion TO rol_admin_sistema, rol_gerente_sede;
GRANT UPDATE (nombre, descripcion, cupo_maximo, id_sede, id_empleado)
    ON clase TO rol_admin_sistema, rol_gerente_sede;


-- 7. Inscripciones y asistencia
GRANT SELECT ON miembro_sesion
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;
GRANT INSERT ON miembro_sesion TO rol_admin_sistema, rol_recepcionista_sede;
GRANT UPDATE (asistio) ON miembro_sesion TO rol_admin_sistema, rol_entrenador_sede;

-- 8. Equipos y mantenimiento: solo admin y gerente
GRANT SELECT, INSERT ON equipo, mantenimiento_equipo TO rol_admin_sistema, rol_gerente_sede;
GRANT USAGE ON SEQUENCE seq_equipo, seq_mantenimiento_equipo TO rol_admin_sistema, rol_gerente_sede;
GRANT UPDATE (nombre, id_tipo_equipo, id_sede, fecha_adquisicion)
    ON equipo TO rol_admin_sistema, rol_gerente_sede;

--No permite la creacion de tablas temporales
REVOKE TEMPORARY ON DATABASE "fitzoneDB" FROM PUBLIC;




