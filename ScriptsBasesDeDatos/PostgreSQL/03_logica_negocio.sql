-- =====================================================================
-- FitZone - Sistema de gestión para una cadena de gimnasios
-- Script 03: lógica de negocio (PL/pgSQL) 
--
-- Errores establecidos que lee el backend
--  E0400 dato inválido o regla de negocio
--  E0401 credenciales inválidas 
--  E0403 operación prohibida
--  E0404 el registro no existe
--  E0409 conflicto (duplicado, cupo lleno,etc)
-- =====================================================================

-- ---------------------------------------------------------------------
-- AUDITORÍA (se llena sola con triggers)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auditoria (
    id_auditoria  INT GENERATED ALWAYS AS IDENTITY,
    tabla         VARCHAR(40) NOT NULL,
    operacion     VARCHAR(10) NOT NULL,
    id_registro   VARCHAR(40),
    rol_bd        VARCHAR(60) NOT NULL,   -- rol activo (SET ROLE)
    id_empleado   NUMERIC(10),            -- empleado que inició sesión
    fecha         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT auditoria_pk PRIMARY KEY (id_auditoria)
);

-- ---------------------------------------------------------------------
-- FUNCIONES
-- ---------------------------------------------------------------------

-- Une nombres y apellidos ignorando los vacíos
CREATE OR REPLACE FUNCTION fn_nombre_completo(p_nombre1 VARCHAR, p_nombre2 VARCHAR,
                                   p_apellido1 VARCHAR, p_apellido2 VARCHAR)
RETURNS VARCHAR LANGUAGE sql IMMUTABLE AS $$
    SELECT concat_ws(' ', nullif(trim(p_nombre1), ''), nullif(trim(p_nombre2), ''),
                          nullif(trim(p_apellido1), ''), nullif(trim(p_apellido2), ''));
$$;

-- ---------------------------------------------------------------------
-- TRIGGERS
-- ---------------------------------------------------------------------

-- No deja desactivar o cambiar de rol al último administrador activo
CREATE OR REPLACE FUNCTION fn_tg_empleado_ultimo_admin()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_id_admin NUMERIC;
    v_otros    INTEGER;
BEGIN
    SELECT id_rol_empleado INTO v_id_admin FROM rol_empleado WHERE upper(nombre) = 'ADMIN_SISTEMA';

    IF OLD.activo = TRUE AND OLD.id_rol_empleado = v_id_admin THEN
        IF NEW.activo = FALSE OR NEW.id_rol_empleado <> v_id_admin THEN
            -- bloquea a los admins activos para que dos no se desactiven a la vez
            PERFORM 1 FROM empleado WHERE id_rol_empleado = v_id_admin AND activo = TRUE FOR UPDATE;

            SELECT count(*) INTO v_otros
              FROM empleado
             WHERE id_rol_empleado = v_id_admin
               AND activo = TRUE
               AND id_empleado <> OLD.id_empleado;

            IF v_otros = 0 THEN
                RAISE EXCEPTION 'No se puede desactivar al último administrador.' USING ERRCODE = 'E0409';
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_empleado_ultimo_admin BEFORE UPDATE ON empleado
    FOR EACH ROW EXECUTE FUNCTION fn_tg_empleado_ultimo_admin();


-- Revisa que el empleado de la clase sea un entrenador activo de la misma sede
CREATE OR REPLACE FUNCTION fn_tg_clase_validar_entrenador()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_activo BOOLEAN;
    v_sede   NUMERIC;
    v_rol    VARCHAR;
BEGIN
    SELECT e.activo, e.id_sede, r.nombre
      INTO v_activo, v_sede, v_rol
      FROM empleado e
      JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
     WHERE e.id_empleado = NEW.id_empleado;

    IF v_rol IS NULL THEN
        RAISE EXCEPTION 'El empleado no existe.' USING ERRCODE = 'E0404';
    END IF;
    IF upper(v_rol) <> 'ENTRENADOR_SEDE' THEN
        RAISE EXCEPTION 'El empleado no es entrenador.' USING ERRCODE = 'E0400';
    END IF;
    IF v_activo = FALSE THEN
        RAISE EXCEPTION 'El entrenador está inactivo.' USING ERRCODE = 'E0400';
    END IF;
    IF v_sede <> NEW.id_sede THEN
        RAISE EXCEPTION 'El entrenador pertenece a otra sede.' USING ERRCODE = 'E0400';
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_clase_validar_entrenador BEFORE INSERT OR UPDATE ON clase
    FOR EACH ROW EXECUTE FUNCTION fn_tg_clase_validar_entrenador();


-- Revisa que la sesión no sea en el pasado y que el entrenador no tenga otra a la misma hora
CREATE OR REPLACE FUNCTION fn_tg_sesion_validar()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_entrenador NUMERIC;
    v_cruces     INTEGER;
BEGIN
    IF TG_OP = 'INSERT' AND NEW.fecha < current_date THEN
        RAISE EXCEPTION 'No se puede programar una sesión en una fecha pasada.' USING ERRCODE = 'E0400';
    END IF;

    SELECT id_empleado INTO v_entrenador FROM clase WHERE id_clase = NEW.id_clase;

    SELECT count(*) INTO v_cruces
      FROM sesion s
      JOIN clase c ON c.id_clase = s.id_clase
     WHERE c.id_empleado = v_entrenador
       AND s.fecha = NEW.fecha
       AND s.numero_sesion <> NEW.numero_sesion
       AND s.hora_inicio < NEW.hora_fin
       AND s.hora_fin > NEW.hora_inicio;

    IF v_cruces > 0 THEN
        RAISE EXCEPTION 'El entrenador ya tiene otra sesión en ese horario.' USING ERRCODE = 'E0409';
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_sesion_validar BEFORE INSERT OR UPDATE ON sesion
    FOR EACH ROW EXECUTE FUNCTION fn_tg_sesion_validar();


-- Revisa la inscripción: no repetida, sesión futura, membresía vigente y que haya cupo
CREATE OR REPLACE FUNCTION fn_tg_inscripcion_validar()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp AS $$
DECLARE
    v_fecha     DATE;
    v_hora      TIME;
    v_cupo      INTEGER;
    v_inscritos INTEGER;
BEGIN
    SELECT s.fecha, s.hora_inicio, c.cupo_maximo
      INTO v_fecha, v_hora, v_cupo
      FROM sesion s
      JOIN clase c ON c.id_clase = s.id_clase
     WHERE s.numero_sesion = NEW.numero_sesion
       FOR UPDATE OF s;   -- bloquea la sesión para que dos personas no llenen el último cupo a la vez

    IF v_fecha IS NULL THEN
        RAISE EXCEPTION 'La sesión no existe.' USING ERRCODE = 'E0404';
    END IF;

    IF EXISTS (SELECT 1 FROM miembro_sesion
                WHERE id_miembro = NEW.id_miembro AND numero_sesion = NEW.numero_sesion) THEN
        RAISE EXCEPTION 'El miembro ya está inscrito en esta sesión.' USING ERRCODE = 'E0409';
    END IF;

    IF v_fecha + v_hora <= localtimestamp THEN
        RAISE EXCEPTION 'La sesión ya comenzó o ya terminó.' USING ERRCODE = 'E0400';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM membresia
                    WHERE id_miembro = NEW.id_miembro
                      AND estado = 'ACTIVA'
                      AND fecha_fin >= current_date) THEN
        RAISE EXCEPTION 'El miembro no tiene una membresía activa.' USING ERRCODE = 'E0400';
    END IF;

    SELECT count(*) INTO v_inscritos FROM miembro_sesion WHERE numero_sesion = NEW.numero_sesion;
    IF v_inscritos >= v_cupo THEN
        RAISE EXCEPTION 'La sesión está llena.' USING ERRCODE = 'E0409';
    END IF;

    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_inscripcion_validar BEFORE INSERT ON miembro_sesion
    FOR EACH ROW EXECUTE FUNCTION fn_tg_inscripcion_validar();


-- No deja marcar asistencia antes de que empiece la sesión
CREATE OR REPLACE FUNCTION fn_tg_asistencia_validar()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_inicio TIMESTAMP;
BEGIN
    SELECT fecha + hora_inicio INTO v_inicio FROM sesion WHERE numero_sesion = NEW.numero_sesion;

    IF v_inicio > localtimestamp THEN
        RAISE EXCEPTION 'No se puede marcar asistencia antes de que inicie la sesión.' USING ERRCODE = 'E0400';
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_asistencia_validar BEFORE UPDATE ON miembro_sesion
    FOR EACH ROW EXECUTE FUNCTION fn_tg_asistencia_validar();


-- No deja modificar ni borrar pagos
CREATE OR REPLACE FUNCTION fn_tg_pago_inmutable()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION 'Los pagos no se pueden modificar ni eliminar.' USING ERRCODE = 'E0403';
END $$;

CREATE OR REPLACE TRIGGER trg_pago_inmutable BEFORE UPDATE OR DELETE ON pago
    FOR EACH ROW EXECUTE FUNCTION fn_tg_pago_inmutable();


-- Un miembro solo puede tener una membresía activa y una vencida no se puede reactivar
CREATE OR REPLACE FUNCTION fn_tg_membresia_validar()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.estado = 'ACTIVA' THEN
        IF EXISTS (SELECT 1 FROM membresia WHERE id_miembro = NEW.id_miembro AND estado = 'ACTIVA') THEN
            RAISE EXCEPTION 'El miembro ya tiene una membresía activa.' USING ERRCODE = 'E0409';
        END IF;
    END IF;

    IF TG_OP = 'UPDATE' AND OLD.estado = 'VENCIDA' AND NEW.estado = 'ACTIVA' THEN
        RAISE EXCEPTION 'La membresía está vencida, debe renovarla.' USING ERRCODE = 'E0400';
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_membresia_validar BEFORE INSERT OR UPDATE ON membresia
    FOR EACH ROW EXECUTE FUNCTION fn_tg_membresia_validar();


-- La fecha del mantenimiento no puede ser futura ni anterior a la compra del equipo
CREATE OR REPLACE FUNCTION fn_tg_mantenimiento_validar()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_fecha_compra DATE;
BEGIN
    IF NEW.fecha_mantenimiento > current_date THEN
        RAISE EXCEPTION 'La fecha de mantenimiento no puede ser futura.' USING ERRCODE = 'E0400';
    END IF;

    SELECT fecha_adquisicion INTO v_fecha_compra FROM equipo WHERE id_equipo = NEW.id_equipo;
    IF NEW.fecha_mantenimiento < v_fecha_compra THEN
        RAISE EXCEPTION 'El mantenimiento no puede ser antes de la compra del equipo.' USING ERRCODE = 'E0400';
    END IF;
    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER trg_mantenimiento_validar BEFORE INSERT OR UPDATE ON mantenimiento_equipo
    FOR EACH ROW EXECUTE FUNCTION fn_tg_mantenimiento_validar();


-- Registra en auditoria cada creación o actualizacion
CREATE OR REPLACE FUNCTION fn_tg_auditoria()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp AS $$
DECLARE
    v_id VARCHAR;
BEGIN
    v_id := to_jsonb(NEW) ->> TG_ARGV[0];
    IF TG_NARGS > 1 THEN
        v_id := v_id || '-' || (to_jsonb(NEW) ->> TG_ARGV[1]);
    END IF;

    INSERT INTO auditoria (tabla, operacion, id_registro, rol_bd, id_empleado)
    VALUES (TG_TABLE_NAME, TG_OP, v_id, current_setting('role'),
            nullif(current_setting('fitzone.id_empleado', true), '')::NUMERIC);
    RETURN NULL;
END $$;

CREATE OR REPLACE TRIGGER trg_auditoria_sede AFTER INSERT OR UPDATE ON sede
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_sede');
CREATE OR REPLACE TRIGGER trg_auditoria_empleado AFTER INSERT OR UPDATE ON empleado
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_empleado');
CREATE OR REPLACE TRIGGER trg_auditoria_miembro AFTER INSERT OR UPDATE ON miembro
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_miembro');
CREATE OR REPLACE TRIGGER trg_auditoria_info_medica AFTER INSERT OR UPDATE ON info_medica
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_miembro');
CREATE OR REPLACE TRIGGER trg_auditoria_membresia AFTER INSERT OR UPDATE ON membresia
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_membresia');
CREATE OR REPLACE TRIGGER trg_auditoria_pago AFTER INSERT ON pago
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_pago');
CREATE OR REPLACE TRIGGER trg_auditoria_clase AFTER INSERT OR UPDATE ON clase
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_clase');
CREATE OR REPLACE TRIGGER trg_auditoria_sesion AFTER INSERT OR UPDATE ON sesion
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('numero_sesion');
CREATE OR REPLACE TRIGGER trg_auditoria_miembro_sesion AFTER INSERT OR UPDATE ON miembro_sesion
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_miembro', 'numero_sesion');
CREATE OR REPLACE TRIGGER trg_auditoria_equipo AFTER INSERT OR UPDATE ON equipo
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('id_equipo');
CREATE OR REPLACE TRIGGER trg_auditoria_mantenimiento AFTER INSERT ON mantenimiento_equipo
    FOR EACH ROW EXECUTE FUNCTION fn_tg_auditoria('numero_mantenimiento');

-- ---------------------------------------------------------------------
-- PROCEDIMIENTOS
-- ---------------------------------------------------------------------

-- Crea una sede nueva
CREATE OR REPLACE PROCEDURE sp_crear_sede(p_nombre VARCHAR, p_direccion VARCHAR, p_telefono VARCHAR,
                               OUT p_id_sede NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM sede WHERE nombre = p_nombre OR direccion = p_direccion) THEN
        RAISE EXCEPTION 'Ya existe una sede con ese nombre o dirección.' USING ERRCODE = 'E0409';
    END IF;

    INSERT INTO sede (nombre, direccion, telefono)
    VALUES (p_nombre, p_direccion, p_telefono)
    RETURNING id_sede INTO p_id_sede;
END $$;


-- Crea un empleado nuevo (la contraseña ya llega cifrada desde el backend)
CREATE OR REPLACE PROCEDURE sp_crear_empleado(
    p_primer_nombre VARCHAR, p_segundo_nombre VARCHAR, p_primer_apellido VARCHAR, p_segundo_apellido VARCHAR,
    p_telefono VARCHAR, p_correo VARCHAR, p_contrasena VARCHAR, p_id_rol_empleado NUMERIC, p_id_sede NUMERIC,
    OUT p_id_empleado NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    IF p_contrasena IS NULL OR p_contrasena = '' THEN
        RAISE EXCEPTION 'La contraseña es obligatoria.' USING ERRCODE = 'E0400';
    END IF;
    IF EXISTS (SELECT 1 FROM empleado WHERE correo = lower(p_correo)) THEN
        RAISE EXCEPTION 'Ya existe un empleado con ese correo.' USING ERRCODE = 'E0409';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM rol_empleado WHERE id_rol_empleado = p_id_rol_empleado) THEN
        RAISE EXCEPTION 'El rol no existe.' USING ERRCODE = 'E0404';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM sede WHERE id_sede = p_id_sede) THEN
        RAISE EXCEPTION 'La sede no existe.' USING ERRCODE = 'E0404';
    END IF;

    INSERT INTO empleado (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
                          telefono, correo, contrasena, id_rol_empleado, id_sede)
    VALUES (p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido,
            p_telefono, lower(p_correo), p_contrasena, p_id_rol_empleado, p_id_sede)
    RETURNING id_empleado INTO p_id_empleado;
END $$;


-- Activa o desactiva un empleado
CREATE OR REPLACE PROCEDURE sp_cambiar_estado_empleado(p_id_empleado NUMERIC, p_activo BOOLEAN)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE empleado SET activo = p_activo WHERE id_empleado = p_id_empleado;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El empleado no existe.' USING ERRCODE = 'E0404';
    END IF;
END $$;


-- Registra un miembro y, si se envía, su información médica
CREATE OR REPLACE PROCEDURE sp_registrar_miembro(
    p_primer_nombre VARCHAR, p_segundo_nombre VARCHAR, p_primer_apellido VARCHAR, p_segundo_apellido VARCHAR,
    p_telefono VARCHAR, p_correo VARCHAR, p_id_sede NUMERIC,
    p_contacto_emergencia VARCHAR, p_tipo_sangre VARCHAR, p_condicion_medica VARCHAR,
    OUT p_id_miembro NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    IF (p_contacto_emergencia IS NULL AND p_tipo_sangre IS NOT NULL)
       OR (p_contacto_emergencia IS NOT NULL AND p_tipo_sangre IS NULL) THEN
        RAISE EXCEPTION 'La información médica necesita contacto de emergencia y tipo de sangre.' USING ERRCODE = 'E0400';
    END IF;
    IF p_condicion_medica IS NOT NULL AND p_contacto_emergencia IS NULL THEN
        RAISE EXCEPTION 'La información médica necesita contacto de emergencia y tipo de sangre.' USING ERRCODE = 'E0400';
    END IF;
    IF EXISTS (SELECT 1 FROM miembro WHERE correo = lower(p_correo)) THEN
        RAISE EXCEPTION 'Ya existe un miembro con ese correo.' USING ERRCODE = 'E0409';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM sede WHERE id_sede = p_id_sede) THEN
        RAISE EXCEPTION 'La sede no existe.' USING ERRCODE = 'E0404';
    END IF;

    INSERT INTO miembro (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
                         telefono, correo, id_sede)
    VALUES (p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido,
            p_telefono, lower(p_correo), p_id_sede)
    RETURNING id_miembro INTO p_id_miembro;

    IF p_contacto_emergencia IS NOT NULL AND p_tipo_sangre IS NOT NULL THEN
        INSERT INTO info_medica (id_miembro, contacto_emergencia, tipo_sangre, condicion_medica)
        VALUES (p_id_miembro, p_contacto_emergencia, upper(p_tipo_sangre), p_condicion_medica);
    END IF;
END $$;


-- Renueva la membresía de un miembro y registra el pago
CREATE OR REPLACE PROCEDURE sp_renovar_membresia(
    p_id_miembro NUMERIC, p_id_tipo_plan NUMERIC, p_monto NUMERIC, p_id_metodo_pago NUMERIC,
    OUT p_id_membresia NUMERIC, OUT p_id_pago NUMERIC,
    OUT p_fecha_inicio DATE, OUT p_fecha_fin DATE)
LANGUAGE plpgsql AS $$
DECLARE
    v_plan       VARCHAR;
    v_fin_actual DATE;
BEGIN
    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser mayor que cero.' USING ERRCODE = 'E0400';
    END IF;
    -- bloquea al miembro para que dos renovaciones suyas no se hagan al mismo tiempo
    PERFORM 1 FROM miembro WHERE id_miembro = p_id_miembro FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El miembro no existe.' USING ERRCODE = 'E0404';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM metodo_pago WHERE id_metodo_pago = p_id_metodo_pago) THEN
        RAISE EXCEPTION 'El método de pago no existe.' USING ERRCODE = 'E0404';
    END IF;

    SELECT upper(nombre) INTO v_plan FROM tipo_plan WHERE id_tipo_plan = p_id_tipo_plan;
    IF v_plan IS NULL THEN
        RAISE EXCEPTION 'El tipo de plan no existe.' USING ERRCODE = 'E0404';
    END IF;

    -- la membresía activa anterior pasa a vencida
    UPDATE membresia SET estado = 'VENCIDA'
     WHERE id_miembro = p_id_miembro AND estado = 'ACTIVA'
    RETURNING fecha_fin INTO v_fin_actual;

    IF v_fin_actual IS NOT NULL AND v_fin_actual >= current_date THEN
        p_fecha_inicio := v_fin_actual + 1;
    ELSE
        p_fecha_inicio := current_date;
    END IF;

    IF v_plan = 'MENSUAL' THEN
        p_fecha_fin := p_fecha_inicio + INTERVAL '1 month' - INTERVAL '1 day';
    ELSIF v_plan = 'TRIMESTRAL' THEN
        p_fecha_fin := p_fecha_inicio + INTERVAL '3 months' - INTERVAL '1 day';
    ELSIF v_plan = 'ANUAL' THEN
        p_fecha_fin := p_fecha_inicio + INTERVAL '1 year' - INTERVAL '1 day';
    ELSE
        RAISE EXCEPTION 'El plan no tiene una duración conocida.' USING ERRCODE = 'E0400';
    END IF;

    INSERT INTO membresia (estado, fecha_inicio, fecha_fin, id_tipo_plan, id_miembro)
    VALUES ('ACTIVA', p_fecha_inicio, p_fecha_fin, p_id_tipo_plan, p_id_miembro)
    RETURNING id_membresia INTO p_id_membresia;

    INSERT INTO pago (monto, id_metodo_pago, id_miembro)
    VALUES (p_monto, p_id_metodo_pago, p_id_miembro)
    RETURNING id_pago INTO p_id_pago;
END $$;


-- Inscribe un miembro en una sesión
CREATE OR REPLACE PROCEDURE sp_registrar_inscripcion(p_numero_sesion NUMERIC, p_id_miembro NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM miembro WHERE id_miembro = p_id_miembro) THEN
        RAISE EXCEPTION 'El miembro no existe.' USING ERRCODE = 'E0404';
    END IF;

    INSERT INTO miembro_sesion (id_miembro, numero_sesion) VALUES (p_id_miembro, p_numero_sesion);
END $$;


-- Marca si un miembro asistió o no a una sesión
CREATE OR REPLACE PROCEDURE sp_marcar_asistencia(p_numero_sesion NUMERIC, p_id_miembro NUMERIC, p_asistio BOOLEAN)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE miembro_sesion SET asistio = p_asistio
     WHERE numero_sesion = p_numero_sesion AND id_miembro = p_id_miembro;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El miembro no está inscrito en esa sesión.' USING ERRCODE = 'E0404';
    END IF;
END $$;

-- ---------------------------------------------------------------------
-- VISTAS
-- ---------------------------------------------------------------------

-- Datos para el login de los empleados activos (incluye la contraseña cifrada)
CREATE OR REPLACE VIEW v_credenciales_login AS
SELECT e.id_empleado,
       fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS nombre,
       e.correo, e.contrasena, r.nombre AS rol, e.id_sede, s.nombre AS sede
  FROM empleado e
  JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
  JOIN sede s         ON s.id_sede = e.id_sede
 WHERE e.activo = TRUE;

-- Lista de empleados con su rol y sede
CREATE OR REPLACE VIEW v_empleado AS
SELECT e.id_empleado,
       fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS nombre_completo,
       e.correo, e.telefono, r.nombre AS rol, e.id_sede, s.nombre AS sede, e.activo
  FROM empleado e
  JOIN rol_empleado r ON r.id_rol_empleado = e.id_rol_empleado
  JOIN sede s         ON s.id_sede = e.id_sede;

-- Lista de miembros con su sede y su plan actual
CREATE OR REPLACE VIEW v_miembro AS
SELECT m.id_miembro,
       fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido) AS nombre_completo,
       m.correo, m.telefono, m.id_sede, s.nombre AS sede, m.fecha_registro,
       (SELECT tp.nombre
          FROM membresia mb
          JOIN tipo_plan tp ON tp.id_tipo_plan = mb.id_tipo_plan
         WHERE mb.id_miembro = m.id_miembro
           AND mb.estado = 'ACTIVA'
           AND mb.fecha_fin >= current_date) AS plan_actual
  FROM miembro m
  JOIN sede s ON s.id_sede = m.id_sede;

-- Lista de membresías (si ya pasó la fecha de fin se muestra como VENCIDA)
CREATE OR REPLACE VIEW v_membresia AS
SELECT mb.id_membresia, mb.id_miembro,
       fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido) AS miembro,
       m.id_sede, tp.nombre AS plan,
       CASE WHEN mb.fecha_fin < current_date THEN 'VENCIDA' ELSE mb.estado END AS estado,
       mb.fecha_inicio, mb.fecha_fin
  FROM membresia mb
  JOIN miembro m    ON m.id_miembro = mb.id_miembro
  JOIN tipo_plan tp ON tp.id_tipo_plan = mb.id_tipo_plan;

-- Lista de pagos con el miembro y el método de pago
CREATE OR REPLACE VIEW v_pago AS
SELECT p.id_pago, p.id_miembro,
       fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido) AS miembro,
       m.id_sede, mp.nombre AS metodo, p.monto, p.fecha_pago
  FROM pago p
  JOIN miembro m      ON m.id_miembro = p.id_miembro
  JOIN metodo_pago mp ON mp.id_metodo_pago = p.id_metodo_pago;

-- Lista de sesiones con su clase, entrenador y cantidad de inscritos
CREATE OR REPLACE VIEW v_sesion AS
SELECT s.numero_sesion, s.id_clase, c.nombre AS clase, c.id_sede, se.nombre AS sede,
       c.id_empleado,
       fn_nombre_completo(e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido) AS entrenador,
       s.fecha, s.hora_inicio, s.hora_fin, c.cupo_maximo,
       (SELECT count(*) FROM miembro_sesion ms WHERE ms.numero_sesion = s.numero_sesion) AS inscritos
  FROM sesion s
  JOIN clase c    ON c.id_clase = s.id_clase
  JOIN sede se    ON se.id_sede = c.id_sede
  JOIN empleado e ON e.id_empleado = c.id_empleado;

-- Lista de equipos (está en MANTENIMIENTO si tuvo uno en los últimos 30 días)
CREATE OR REPLACE VIEW v_equipo AS
SELECT eq.id_equipo, eq.nombre, te.nombre AS tipo, eq.id_sede, s.nombre AS sede, eq.fecha_adquisicion,
       CASE WHEN EXISTS (SELECT 1 FROM mantenimiento_equipo mt
                          WHERE mt.id_equipo = eq.id_equipo
                            AND mt.fecha_mantenimiento >= current_date - 30)
            THEN 'MANTENIMIENTO' ELSE 'OPERATIVO' END AS estado
  FROM equipo eq
  JOIN tipo_equipo te ON te.id_tipo_equipo = eq.id_tipo_equipo
  JOIN sede s         ON s.id_sede = eq.id_sede;

-- Lista de mantenimientos con el equipo y la sede
CREATE OR REPLACE VIEW v_mantenimiento AS
SELECT mt.numero_mantenimiento, mt.id_equipo, eq.nombre AS equipo, eq.id_sede, s.nombre AS sede,
       mt.descripcion, mt.costo, mt.fecha_mantenimiento
  FROM mantenimiento_equipo mt
  JOIN equipo eq ON eq.id_equipo = mt.id_equipo
  JOIN sede s    ON s.id_sede = eq.id_sede;


-- ---------------------------------------------------------------------
-- REPORTES 
-- ---------------------------------------------------------------------

DROP FUNCTION IF EXISTS fn_reporte_ocupacion(DATE, DATE, NUMERIC);
DROP FUNCTION IF EXISTS fn_membresias_por_vencer(INTEGER, NUMERIC);

-- Muestra inscritos, asistentes y porcentaje de ocupación de cada sesión entre dos fechas
CREATE OR REPLACE FUNCTION fn_reporte_ocupacion(p_desde DATE, p_hasta DATE, p_id_sede NUMERIC DEFAULT NULL)
RETURNS TABLE (numero_sesion NUMERIC, clase VARCHAR, id_sede NUMERIC, sede VARCHAR, entrenador VARCHAR,
               fecha DATE, hora_inicio TIME, cupo_maximo INTEGER,
               inscritos BIGINT, asistentes BIGINT, pct_ocupacion NUMERIC)
LANGUAGE sql AS $$
    SELECT s.numero_sesion, s.clase, s.id_sede, s.sede, s.entrenador, s.fecha, s.hora_inicio, s.cupo_maximo,
           count(ms.id_miembro),
           sum(CASE WHEN ms.asistio = TRUE THEN 1 ELSE 0 END),
           round(count(ms.id_miembro) * 100.0 / s.cupo_maximo, 2)
      FROM v_sesion s
      LEFT JOIN miembro_sesion ms ON ms.numero_sesion = s.numero_sesion
     WHERE s.fecha BETWEEN p_desde AND p_hasta AND (p_id_sede IS NULL OR s.id_sede = p_id_sede)
     GROUP BY s.numero_sesion, s.clase, s.id_sede, s.sede, s.entrenador, s.fecha, s.hora_inicio, s.cupo_maximo
     ORDER BY s.fecha, s.hora_inicio;
$$;


-- Muestra las membresías activas que ya casi van a vencer
CREATE OR REPLACE FUNCTION fn_membresias_por_vencer(p_dias INTEGER DEFAULT 7, p_id_sede NUMERIC DEFAULT NULL)
RETURNS TABLE (id_membresia NUMERIC, id_miembro NUMERIC, miembro VARCHAR, telefono VARCHAR,
               correo VARCHAR, id_sede NUMERIC, sede VARCHAR, plan VARCHAR, fecha_fin DATE, dias_restantes INTEGER)
LANGUAGE sql AS $$
    SELECT mb.id_membresia, m.id_miembro,
           fn_nombre_completo(m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido),
           m.telefono, m.correo, m.id_sede, se.nombre, tp.nombre, mb.fecha_fin, mb.fecha_fin - current_date
      FROM membresia mb
      JOIN miembro m    ON m.id_miembro = mb.id_miembro
      JOIN sede se      ON se.id_sede = m.id_sede
      JOIN tipo_plan tp ON tp.id_tipo_plan = mb.id_tipo_plan
     WHERE mb.estado = 'ACTIVA'
       AND mb.fecha_fin BETWEEN current_date AND current_date + p_dias
       AND (p_id_sede IS NULL OR m.id_sede = p_id_sede)
     ORDER BY mb.fecha_fin;
$$;


-- Suma los pagos de cada sede por método de pago entre dos fechas
CREATE OR REPLACE FUNCTION fn_reporte_ingresos(p_desde DATE, p_hasta DATE, p_id_sede NUMERIC DEFAULT NULL)
RETURNS TABLE (id_sede NUMERIC, sede VARCHAR, metodo VARCHAR, num_pagos BIGINT, total NUMERIC)
LANGUAGE sql AS $$
    SELECT p.id_sede, se.nombre, p.metodo, count(p.id_pago), sum(p.monto)
      FROM v_pago p
      JOIN sede se ON se.id_sede = p.id_sede
     WHERE p.fecha_pago::DATE BETWEEN p_desde AND p_hasta AND (p_id_sede IS NULL OR p.id_sede = p_id_sede)
     GROUP BY p.id_sede, se.nombre, p.metodo
     ORDER BY se.nombre, sum(p.monto) DESC;
$$;


-- Suma el costo de los mantenimientos de cada sede por tipo de equipo entre dos fechas
CREATE OR REPLACE FUNCTION fn_reporte_mantenimientos(p_desde DATE, p_hasta DATE, p_id_sede NUMERIC DEFAULT NULL)
RETURNS TABLE (id_sede NUMERIC, sede VARCHAR, tipo VARCHAR, num_mantenimientos BIGINT, costo_total NUMERIC)
LANGUAGE sql AS $$
    SELECT mt.id_sede, mt.sede, eq.tipo, count(mt.numero_mantenimiento), sum(mt.costo)
      FROM v_mantenimiento mt
      JOIN v_equipo eq ON eq.id_equipo = mt.id_equipo
     WHERE mt.fecha_mantenimiento BETWEEN p_desde AND p_hasta AND (p_id_sede IS NULL OR mt.id_sede = p_id_sede)
     GROUP BY mt.id_sede, mt.sede, eq.tipo
     ORDER BY mt.sede, sum(mt.costo) DESC;
$$;


-- ---------------------------------------------------------------------
-- PERMISOS
-- ---------------------------------------------------------------------

REVOKE ALL ON ALL FUNCTIONS  IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL PROCEDURES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON v_credenciales_login, auditoria FROM PUBLIC;

-- Login
GRANT SELECT ON v_credenciales_login TO fitzone_app;

--funcion
GRANT EXECUTE ON FUNCTION fn_nombre_completo
    TO fitzone_app, rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;

-- Procedimientos
GRANT EXECUTE ON PROCEDURE sp_crear_sede, sp_crear_empleado, sp_cambiar_estado_empleado
    TO rol_admin_sistema;
GRANT EXECUTE ON PROCEDURE sp_registrar_miembro, sp_renovar_membresia, sp_registrar_inscripcion
    TO rol_admin_sistema, rol_recepcionista_sede;
GRANT EXECUTE ON PROCEDURE sp_marcar_asistencia
    TO rol_admin_sistema, rol_entrenador_sede;

-- Funciones de reportes
GRANT EXECUTE ON FUNCTION fn_membresias_por_vencer, fn_reporte_ingresos
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede;
GRANT EXECUTE ON FUNCTION fn_reporte_ocupacion
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;
GRANT EXECUTE ON FUNCTION fn_reporte_mantenimientos
    TO rol_admin_sistema, rol_gerente_sede;

-- Vistas
GRANT SELECT ON v_empleado, v_equipo, v_mantenimiento
    TO rol_admin_sistema, rol_gerente_sede;
GRANT SELECT ON v_miembro, v_membresia, v_pago
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede;
GRANT SELECT ON v_sesion
    TO rol_admin_sistema, rol_gerente_sede, rol_recepcionista_sede, rol_entrenador_sede;

-- Auditoria
GRANT SELECT ON auditoria TO rol_admin_sistema;
