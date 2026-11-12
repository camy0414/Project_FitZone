-- =====================================================================
-- FitZone - Sistema de gestión para una cadena de gimnasios
-- Script 02: inserción de datos de prueba
-- Proyecto Final Bases de Datos 2 - Universidad El Bosque
-- =====================================================================

BEGIN;
-- ---------------------------------------------------------------------
-- CATÁLOGOS (valores fijos definidos en los supuestos)
-- ---------------------------------------------------------------------
INSERT INTO rol_empleado (id_rol_empleado, nombre) VALUES
    (1, 'ADMIN_SISTEMA'),
    (2, 'GERENTE_SEDE'),
    (3, 'RECEPCIONISTA_SEDE'),
    (4, 'ENTRENADOR_SEDE');
INSERT INTO tipo_plan (id_tipo_plan, nombre) VALUES
    (1, 'MENSUAL'),
    (2, 'TRIMESTRAL'),
    (3, 'ANUAL');
INSERT INTO metodo_pago (id_metodo_pago, nombre) VALUES
    (1, 'TARJETA'),
    (2, 'EFECTIVO'),
    (3, 'TRANSFERENCIA');

INSERT INTO tipo_equipo (id_tipo_equipo, nombre) VALUES
    (1, 'Cardio'),
    (2, 'Fuerza'),
    (3, 'Peso libre'),
    (4, 'Funcional');

-- ---------------------------------------------------------------------
-- SEDE (50)
-- ---------------------------------------------------------------------
INSERT INTO sede (id_sede, nombre, direccion, telefono) VALUES
    (1, 'FitZone Chapinero', 'Diagonal 57 # 72-52, Bogotá', '6015454668'),
    (2, 'FitZone Usaquén', 'Calle 133 # 76-43, Bogotá', '6017323334'),
    (3, 'FitZone Cedritos', 'Avenida Calle 32 # 44-46, Bogotá', '6015460547'),
    (4, 'FitZone Suba', 'Carrera 38 # 21-20, Bogotá', '6012210051'),
    (5, 'FitZone Kennedy', 'Avenida Calle 37 # 87-54, Bogotá', '6015701176'),
    (6, 'FitZone Teusaquillo', 'Diagonal 107 # 119-51, Bogotá', '6012766053'),
    (7, 'FitZone Salitre', 'Calle 124 # 44-60, Bogotá', '6016149501'),
    (8, 'FitZone Fontibón', 'Carrera 62 # 39-97, Bogotá', '6015157670'),
    (9, 'FitZone Galerías', 'Diagonal 40 # 82-33, Bogotá', '6012041225'),
    (10, 'FitZone Modelia', 'Avenida Carrera 19 # 24-43, Bogotá', '6016011283'),
    (11, 'FitZone Colina', 'Diagonal 52 # 93-26, Bogotá', '6016788157'),
    (12, 'FitZone Chicó', 'Transversal 22 # 13-71, Bogotá', '6014031806'),
    (13, 'FitZone Restrepo', 'Calle 128 # 51-73, Bogotá', '6016940156'),
    (14, 'FitZone Engativá', 'Calle 40 # 31-21, Bogotá', '6012718111'),
    (15, 'FitZone Bosa', 'Avenida Carrera 96 # 10-98, Bogotá', '6017457335'),
    (16, 'FitZone El Poblado', 'Calle 54 # 56-88, Medellín', '6044257144'),
    (17, 'FitZone Laureles', 'Carrera 81 # 13-44, Medellín', '6046970175'),
    (18, 'FitZone Belén', 'Avenida Calle 134 # 35-35, Medellín', '6046386953'),
    (19, 'FitZone Envigado', 'Diagonal 12 # 34-55, Medellín', '6047559271'),
    (20, 'FitZone Sabaneta', 'Carrera 21 # 6-99, Medellín', '6047148448'),
    (21, 'FitZone Robledo', 'Avenida Calle 121 # 59-29, Medellín', '6044753877'),
    (22, 'FitZone La América', 'Calle 11 # 49-47, Medellín', '6047890428'),
    (23, 'FitZone Granada', 'Avenida Calle 109 # 12-56, Cali', '6024679104'),
    (24, 'FitZone San Fernando', 'Carrera 50 # 49-89, Cali', '6023571357'),
    (25, 'FitZone Ciudad Jardín', 'Transversal 18 # 26-20, Cali', '6024427917'),
    (26, 'FitZone Chipichape', 'Transversal 77 # 53-84, Cali', '6023453681'),
    (27, 'FitZone El Ingenio', 'Avenida Calle 94 # 109-40, Cali', '6026145190'),
    (28, 'FitZone Pance', 'Transversal 73 # 117-93, Cali', '6024426889'),
    (29, 'FitZone El Prado', 'Avenida Calle 31 # 24-41, Barranquilla', '6054846409'),
    (30, 'FitZone Alto Prado', 'Calle 131 # 41-95, Barranquilla', '6057984889'),
    (31, 'FitZone Riomar', 'Avenida Calle 33 # 58-26, Barranquilla', '6054697556'),
    (32, 'FitZone Villa Country', 'Carrera 65 # 23-21, Barranquilla', '6052404091'),
    (33, 'FitZone Cabecera', 'Avenida Carrera 10 # 6-79, Bucaramanga', '6075120961'),
    (34, 'FitZone Cañaveral', 'Avenida Calle 64 # 13-41, Bucaramanga', '6073126111'),
    (35, 'FitZone Provenza', 'Calle 17 # 15-91, Bucaramanga', '6073392467'),
    (36, 'FitZone Bocagrande', 'Transversal 35 # 64-80, Cartagena', '6053866089'),
    (37, 'FitZone Manga', 'Avenida Carrera 120 # 94-48, Cartagena', '6053664179'),
    (38, 'FitZone Castillogrande', 'Diagonal 147 # 76-37, Cartagena', '6056303410'),
    (39, 'FitZone Pinares', 'Avenida Calle 12 # 105-13, Pereira', '6067299172'),
    (40, 'FitZone Circunvalar', 'Calle 42 # 81-41, Pereira', '6063073845'),
    (41, 'FitZone Cable', 'Calle 147 # 120-18, Manizales', '6064238663'),
    (42, 'FitZone Palermo', 'Avenida Calle 135 # 106-40, Manizales', '6064444162'),
    (43, 'FitZone Piedrapintada', 'Carrera 12 # 62-88, Ibagué', '6085888170'),
    (44, 'FitZone Ambalá', 'Avenida Carrera 144 # 47-56, Ibagué', '6087146472'),
    (45, 'FitZone Barzal', 'Transversal 63 # 22-98, Villavicencio', '6085589531'),
    (46, 'FitZone Esperanza', 'Transversal 146 # 43-30, Villavicencio', '6085499151'),
    (47, 'FitZone Rodadero', 'Transversal 123 # 108-54, Santa Marta', '6052105864'),
    (48, 'FitZone Caobos', 'Calle 35 # 2-35, Cúcuta', '6072502964'),
    (49, 'FitZone Altico', 'Avenida Calle 12 # 2-16, Neiva', '6084565975'),
    (50, 'FitZone Palermo Pasto', 'Calle 132 # 88-42, Pasto', '6025310370');

-- ---------------------------------------------------------------------
-- EMPLEADO (194)  rol: 1 admin, 2 gerente, 3 recepcionista, 4 entrenador
-- ---------------------------------------------------------------------

INSERT INTO empleado (id_empleado, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, correo, contrasena, activo, id_rol_empleado, id_sede) VALUES
    (1, 'Sebastián', NULL, 'Pérez', 'Herrera', '3161812452', 'sebastian.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 1, 1),
    (2, 'Jhonatan', 'Camilo', 'Lozano', 'Buitrago', '3055867170', 'jhonatan.lozano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 1, 1),
    (3, 'Einny', 'Camyla', 'Poveda', 'García', '3169342767', 'einny.poveda@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 1, 2),
    (4, 'Diana', NULL, 'Valencia', 'Castro', '3045872366', 'diana.valencia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 1, 16),
    (5, 'Sofía', NULL, 'Sánchez', 'González', '3106005681', 'sofia.sanchez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 1),
    (6, 'Viviana', NULL, 'Ospina', 'Díaz', '3508530810', 'viviana.ospina@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 1),
    (7, 'Nicolás', 'Tomás', 'Mendoza', 'García', '3508028804', 'nicolas.mendoza@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 1),
    (8, 'Paula', NULL, 'Jiménez', 'Montoya', '3181508997', 'paula.jimenez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 1),
    (9, 'Laura', 'Luisa', 'Montoya', 'Hernández', '3147684127', 'laura.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 2),
    (10, 'David', 'Esteban', 'Romero', 'Vargas', '3054959001', 'david.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 2),
    (11, 'Luisa', 'Yuliana', 'Ospina', NULL, '3172141788', 'luisa.ospina@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 2),
    (12, 'Sofía', 'Paula', 'Herrera', 'Torres', '3156914175', 'sofia.herrera@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 2),
    (13, 'Alejandro', 'Gabriel', 'Rojas', 'Álvarez', '3201363500', 'alejandro.rojas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 3),
    (14, 'Daniela', NULL, 'Cortés', 'Gutiérrez', '3203889103', 'daniela.cortes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 3),
    (15, 'Ricardo', NULL, 'Rincón', 'Vargas', '3022802898', 'ricardo.rincon@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 3),
    (16, 'Andrea', NULL, 'Arango', 'Poveda', '3216536964', 'andrea.arango@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 3),
    (17, 'Lorena', NULL, 'Rodríguez', 'Ruiz', '3119895816', 'lorena.rodriguez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 4),
    (18, 'Carlos', 'Santiago', 'Álvarez', 'Cifuentes', '3104015936', 'carlos.alvarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 4),
    (19, 'Diana', NULL, 'Acosta', 'García', '3236446685', 'diana.acosta@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 4),
    (20, 'Daniel', NULL, 'Londoño', NULL, '3182704941', 'daniel.londono@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 4),
    (21, 'Nicolás', 'Jorge', 'Ramírez', 'Ruiz', '3236797675', 'nicolas.ramirez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 5),
    (22, 'Sofía', 'Mariana', 'Rojas', 'González', '3047574413', 'sofia.rojas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 5),
    (23, 'Carolina', 'Isabella', 'Gómez', 'Lozano', '3203344208', 'carolina.gomez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 5),
    (24, 'Mateo', NULL, 'Ruiz', 'Lozano', '3148494398', 'mateo.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 5),
    (25, 'Héctor', 'Camilo', 'Pérez', NULL, '3115753122', 'hector.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 6),
    (26, 'Nicolás', 'Brayan', 'Jiménez', 'Rodríguez', '3043350199', 'nicolas.jimenez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 6),
    (27, 'Lorena', 'Viviana', 'Torres', 'Londoño', '3174470868', 'lorena.torres@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 6),
    (28, 'Viviana', NULL, 'Ramírez', 'Mendoza', '3002560787', 'viviana.ramirez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 6),
    (29, 'Viviana', 'Ángela', 'Zapata', 'Castro', '3206667601', 'viviana.zapata@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 7),
    (30, 'Kevin', 'Diego', 'Lozano', 'Ruiz', '3014138959', 'kevin.lozano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 7),
    (31, 'Jhonatan', 'Santiago', 'Torres', 'Ramírez', '3165449745', 'jhonatan.torres@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 7),
    (32, 'Lina', 'Luisa', 'Rincón', 'Arango', '3156849011', 'lina.rincon@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 7),
    (33, 'Felipe', NULL, 'Gómez', 'Muñoz', '3106038677', 'felipe.gomez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 7),
    (34, 'Tomás', 'Sebastián', 'Romero', 'Salazar', '3052177847', 'tomas.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 8),
    (35, 'Juan', 'Iván', 'García', 'Salazar', '3118126987', 'juan.garcia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 8),
    (36, 'Paula', 'Sofía', 'Pérez', NULL, '3182036457', 'paula.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 8),
    (37, 'Juan', NULL, 'Moreno', 'Mejía', '3155131432', 'juan.moreno@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 8),
    (38, 'Gabriela', 'Manuela', 'Buitrago', 'Moreno', '3053621824', 'gabriela.buitrago@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 9),
    (39, 'Manuela', NULL, 'Castro', 'Hernández', '3042988223', 'manuela.castro@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 9),
    (40, 'Sebastián', NULL, 'Suárez', 'Torres', '3189871016', 'sebastian.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 9),
    (41, 'Tomás', NULL, 'Poveda', 'Rodríguez', '3111497961', 'tomas.poveda@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 9),
    (42, 'Brayan', NULL, 'Romero', 'Buitrago', '3026864884', 'brayan.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 10),
    (43, 'Gabriel', 'Carlos', 'Acosta', 'Restrepo', '3219640425', 'gabriel.acosta@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 10),
    (44, 'Andrea', NULL, 'Díaz', 'Herrera', '3123552438', 'andrea.diaz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 10),
    (45, 'Mauricio', 'Esteban', 'Castaño', 'Rojas', '3107060897', 'mauricio.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 10),
    (46, 'Óscar', 'Kevin', 'Becerra', 'Suárez', '3174310297', 'oscar.becerra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 4, 10),
    (47, 'Camilo', NULL, 'Martínez', 'Moreno', '3027597486', 'camilo.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 11),
    (48, 'Viviana', 'Marcela', 'Castaño', 'Herrera', '3165164853', 'viviana.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 11),
    (49, 'Diego', NULL, 'Poveda', 'Zapata', '3166198115', 'diego.poveda@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 11),
    (50, 'Catalina', 'Andrea', 'Romero', 'Arango', '3103286212', 'catalina.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 11),
    (51, 'Manuela', NULL, 'González', 'Rincón', '3237108621', 'manuela.gonzalez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 12),
    (52, 'Catalina', NULL, 'Quintero', NULL, '3203438818', 'catalina.quintero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 12),
    (53, 'Carlos', 'Mauricio', 'Gómez', 'Lozano', '3204682844', 'carlos.gomez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 12),
    (54, 'Daniel', NULL, 'Peña', 'Zapata', '3201332234', 'daniel.pena@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 12),
    (55, 'Mauricio', NULL, 'Cortés', 'Torres', '3169606038', 'mauricio.cortes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 13),
    (56, 'Brayan', NULL, 'Ruiz', 'Cifuentes', '3057882785', 'brayan.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 13),
    (57, 'Mateo', NULL, 'Londoño', 'Díaz', '3162731534', 'mateo.londono@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 13),
    (58, 'Natalia', NULL, 'Pérez', 'Muñoz', '3134067020', 'natalia.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 13),
    (59, 'Carlos', NULL, 'López', 'Herrera', '3218799267', 'carlos.lopez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 14),
    (60, 'Tomás', NULL, 'Díaz', NULL, '3105298856', 'tomas.diaz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 14),
    (61, 'Luis', NULL, 'Díaz', 'Cárdenas', '3144394815', 'luis.diaz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 14),
    (62, 'Carolina', NULL, 'Quintero', 'Restrepo', '3134341436', 'carolina.quintero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 14),
    (63, 'Felipe', 'Camilo', 'Gutiérrez', 'Jiménez', '3181039134', 'felipe.gutierrez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 14),
    (64, 'Lina', NULL, 'Torres', 'Jiménez', '3177544669', 'lina.torres@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 15),
    (65, 'Miguel', NULL, 'Ospina', 'Ruiz', '3041514459', 'miguel.ospina@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 15),
    (66, 'Valentina', NULL, 'Arango', 'Mendoza', '3121741641', 'valentina.arango@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 15),
    (67, 'Samuel', NULL, 'Martínez', 'Restrepo', '3053959599', 'samuel.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 15),
    (68, 'Marcela', NULL, 'Suárez', 'Torres', '3052929402', 'marcela.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 16),
    (69, 'Lorena', NULL, 'Buitrago', 'Zapata', '3126212837', 'lorena.buitrago@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 16),
    (70, 'Fernando', NULL, 'Vargas', 'Torres', '3045996444', 'fernando.vargas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 16),
    (71, 'Mateo', NULL, 'Álvarez', 'Peña', '3022952178', 'mateo.alvarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 17),
    (72, 'Esteban', NULL, 'Acosta', 'López', '3051364693', 'esteban.acosta@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 17),
    (73, 'Daniel', 'Luis', 'Muñoz', NULL, '3053042433', 'daniel.munoz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 17),
    (74, 'Paula', NULL, 'Castaño', NULL, '3132714198', 'paula.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 3, 17),
    (75, 'Mateo', NULL, 'Rincón', 'García', '3162013374', 'mateo.rincon@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 18),
    (76, 'Andrea', NULL, 'Álvarez', 'Rojas', '3156508387', 'andrea.alvarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 18),
    (77, 'Miguel', 'Andrés', 'Mejía', 'Lozano', '3202658665', 'miguel.mejia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 18),
    (78, 'Gabriela', NULL, 'Ruiz', 'Poveda', '3059175738', 'gabriela.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 18),
    (79, 'Nicolás', NULL, 'Vargas', 'Jiménez', '3052338284', 'nicolas.vargas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 19),
    (80, 'Manuela', 'Luisa', 'Quintero', NULL, '3126319669', 'manuela.quintero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 19),
    (81, 'Jorge', NULL, 'Poveda', 'Ortiz', '3024594970', 'jorge.poveda@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 19),
    (82, 'Jhonatan', NULL, 'Sánchez', NULL, '3045408295', 'jhonatan.sanchez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 20),
    (83, 'Marcela', 'Lina', 'Arango', 'Torres', '3131077427', 'marcela.arango@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 20),
    (84, 'Jhonatan', 'Alejandro', 'Martínez', 'Zapata', '3131915374', 'jhonatan.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 20),
    (85, 'Óscar', 'Brayan', 'Vargas', 'Rodríguez', '3185153500', 'oscar.vargas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 4, 20),
    (86, 'Paola', 'Gabriela', 'Cortés', 'Cifuentes', '3236340392', 'paola.cortes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 21),
    (87, 'Alejandro', 'Mateo', 'Moreno', NULL, '3114806457', 'alejandro.moreno@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 21),
    (88, 'Lina', 'Mariana', 'García', 'Parra', '3239741317', 'lina.garcia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 21),
    (89, 'Manuela', NULL, 'Zapata', 'Buitrago', '3239200099', 'manuela.zapata@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 21),
    (90, 'Miguel', NULL, 'Buitrago', NULL, '3016237702', 'miguel.buitrago@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 21),
    (91, 'Ángela', NULL, 'Ospina', 'Montoya', '3165725963', 'angela.ospina@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 22),
    (92, 'Carolina', NULL, 'Mejía', 'Rojas', '3232363958', 'carolina.mejia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 22),
    (93, 'Julián', 'Santiago', 'Gutiérrez', 'Ramírez', '3129303868', 'julian.gutierrez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 22),
    (94, 'Alejandra', NULL, 'Cárdenas', 'Restrepo', '3502463495', 'alejandra.cardenas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 23),
    (95, 'Ángela', NULL, 'Sánchez', 'Jiménez', '3145618833', 'angela.sanchez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 23),
    (96, 'Camila', 'Tatiana', 'Ruiz', NULL, '3053296574', 'camila.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 23),
    (97, 'Héctor', 'Luis', 'Suárez', NULL, '3028043602', 'hector.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 24),
    (98, 'Miguel', 'Nicolás', 'Hernández', 'Becerra', '3158624927', 'miguel.hernandez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 24),
    (99, 'Brayan', 'Héctor', 'Jiménez', 'Hernández', '3502112358', 'brayan.jimenez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 24),
    (100, 'Ricardo', 'Diego', 'Moreno', 'Parra', '3105971679', 'ricardo.moreno@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 24),
    (101, 'Andrea', NULL, 'Acosta', NULL, '3114607436', 'andrea.acosta@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 25),
    (102, 'Miguel', 'Mauricio', 'Ortiz', NULL, '3143510323', 'miguel.ortiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 25),
    (103, 'Daniela', NULL, 'Castro', 'Parra', '3041819119', 'daniela.castro@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 25),
    (104, 'Sebastián', NULL, 'Ruiz', 'Ospina', '3128714795', 'sebastian.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 26),
    (105, 'Sebastián', NULL, 'García', 'Ramírez', '3055976442', 'sebastian.garcia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 26),
    (106, 'Nicolás', NULL, 'Rojas', 'Arango', '3151750764', 'nicolas.rojas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 26),
    (107, 'Marcela', NULL, 'Rojas', NULL, '3055280159', 'marcela.rojas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 27),
    (108, 'Sara', 'Sofía', 'Restrepo', 'Gutiérrez', '3151540715', 'sara.restrepo@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 27),
    (109, 'David', 'Óscar', 'Sánchez', NULL, '3184671716', 'david.sanchez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 27),
    (110, 'Alejandra', NULL, 'Martínez', 'Quintero', '3009562347', 'alejandra.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 27),
    (111, 'Valentina', NULL, 'Castro', 'Salazar', '3186040897', 'valentina.castro@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 28),
    (112, 'Carolina', NULL, 'Suárez', 'Londoño', '3012995651', 'carolina.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 28),
    (113, 'Luis', 'Julián', 'Zapata', 'Buitrago', '3504998172', 'luis.zapata@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 28),
    (114, 'Marcela', NULL, 'Montoya', 'García', '3167922158', 'marcela.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 28),
    (115, 'Camila', NULL, 'Martínez', NULL, '3161722170', 'camila.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 29),
    (116, 'Felipe', 'Kevin', 'Lozano', 'Rojas', '3052427601', 'felipe.lozano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 29),
    (117, 'Óscar', NULL, 'Álvarez', 'Moreno', '3186226535', 'oscar.alvarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 29),
    (118, 'Brayan', 'Felipe', 'Castaño', 'Jiménez', '3106523485', 'brayan.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 30),
    (119, 'Valentina', NULL, 'López', 'Rincón', '3209883941', 'valentina.lopez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 30),
    (120, 'Natalia', NULL, 'Vargas', NULL, '3122874423', 'natalia.vargas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 30),
    (121, 'Daniela', NULL, 'Montoya', 'García', '3132698971', 'daniela.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 30),
    (122, 'Tatiana', NULL, 'Ortiz', 'Rincón', '3013340774', 'tatiana.ortiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 4, 30),
    (123, 'Daniela', 'Valentina', 'Romero', 'Ortiz', '3504050937', 'daniela.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 31),
    (124, 'Diego', NULL, 'Romero', 'Ruiz', '3003082677', 'diego.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 31),
    (125, 'Carolina', 'Lina', 'Romero', 'Suárez', '3122234276', 'carolina.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 31),
    (126, 'Andrea', NULL, 'Pérez', 'Rojas', '3158785615', 'andrea.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 32),
    (127, 'Laura', NULL, 'Cifuentes', 'Gómez', '3121270363', 'laura.cifuentes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 32),
    (128, 'Andrea', NULL, 'Cifuentes', 'Restrepo', '3167046922', 'andrea.cifuentes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 32),
    (129, 'Yuliana', NULL, 'Herrera', 'Vargas', '3146243017', 'yuliana.herrera@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 33),
    (130, 'Luis', 'Iván', 'Suárez', 'Poveda', '3111657145', 'luis.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 33),
    (131, 'Catalina', 'Daniela', 'Becerra', 'Londoño', '3058030629', 'catalina.becerra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 33),
    (132, 'Yuliana', NULL, 'Moreno', NULL, '3178468825', 'yuliana.moreno@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 33),
    (133, 'Tatiana', NULL, 'Rojas', 'Rincón', '3049205087', 'tatiana.rojas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 34),
    (134, 'Camilo', NULL, 'Peña', 'Díaz', '3109329880', 'camilo.pena@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 34),
    (135, 'Iván', NULL, 'Ortiz', 'Díaz', '3131326202', 'ivan.ortiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 34),
    (136, 'Daniela', NULL, 'Peña', 'Sánchez', '3135604452', 'daniela.pena@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 3, 34),
    (137, 'Lorena', NULL, 'Salazar', 'Pérez', '3153177482', 'lorena.salazar@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 35),
    (138, 'Sebastián', NULL, 'Zapata', 'Cárdenas', '3187613031', 'sebastian.zapata@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 35),
    (139, 'Camilo', 'Jorge', 'Montoya', 'Ospina', '3008798345', 'camilo.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 35),
    (140, 'Jhonatan', NULL, 'Torres', 'Mejía', '3123591159', 'jhonatan.torres2@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 35),
    (141, 'Natalia', 'Lorena', 'Londoño', 'Montoya', '3182080709', 'natalia.londono@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 36),
    (142, 'Laura', NULL, 'Herrera', 'Castro', '3028810476', 'laura.herrera@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 36),
    (143, 'Daniel', 'Iván', 'Suárez', 'Álvarez', '3018768481', 'daniel.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 36),
    (144, 'Andrés', NULL, 'Hernández', 'García', '3239436131', 'andres.hernandez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 36),
    (145, 'Ángela', NULL, 'Vargas', 'Gutiérrez', '3214037374', 'angela.vargas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 37),
    (146, 'Nicolás', NULL, 'Quintero', 'Rojas', '3175812993', 'nicolas.quintero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 37),
    (147, 'Lorena', 'Laura', 'Castaño', 'Cárdenas', '3045217923', 'lorena.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 37),
    (148, 'Marcela', 'Camila', 'Rodríguez', 'Suárez', '3052469532', 'marcela.rodriguez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 38),
    (149, 'Miguel', NULL, 'Rincón', 'Ruiz', '3206035563', 'miguel.rincon@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 38),
    (150, 'Juan', NULL, 'Ortiz', NULL, '3131325702', 'juan.ortiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 38),
    (151, 'Yuliana', NULL, 'Becerra', NULL, '3026866607', 'yuliana.becerra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 39),
    (152, 'Diana', 'Sofía', 'García', 'Londoño', '3113709992', 'diana.garcia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 39),
    (153, 'Fernando', 'Andrés', 'López', 'Londoño', '3177651040', 'fernando.lopez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 39),
    (154, 'Catalina', 'Sofía', 'Romero', 'Pérez', '3135886145', 'catalina.romero2@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 39),
    (155, 'Samuel', NULL, 'Pérez', 'Romero', '3103790522', 'samuel.perez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 40),
    (156, 'Alejandra', NULL, 'Moreno', 'González', '3007383270', 'alejandra.moreno@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 40),
    (157, 'Juliana', NULL, 'Buitrago', 'Mendoza', '3173355493', 'juliana.buitrago@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 40),
    (158, 'Felipe', 'Julián', 'Cifuentes', 'Torres', '3231858789', 'felipe.cifuentes@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 4, 40),
    (159, 'Tatiana', 'Paula', 'Parra', NULL, '3013708020', 'tatiana.parra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 41),
    (160, 'Alejandra', NULL, 'Moreno', 'García', '3171043070', 'alejandra.moreno2@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 41),
    (161, 'Yuliana', 'Tatiana', 'Salazar', NULL, '3234908948', 'yuliana.salazar@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 41),
    (162, 'David', NULL, 'Ramírez', NULL, '3237842195', 'david.ramirez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 42),
    (163, 'Mariana', NULL, 'Castaño', NULL, '3054923378', 'mariana.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 42),
    (164, 'Felipe', 'Jhonatan', 'García', 'Ospina', '3027860625', 'felipe.garcia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 42),
    (165, 'Sofía', NULL, 'Parra', 'Restrepo', '3105933664', 'sofia.parra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 42),
    (166, 'Daniel', NULL, 'Parra', 'Herrera', '3505272614', 'daniel.parra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 42),
    (167, 'Juliana', NULL, 'Martínez', 'Díaz', '3044480628', 'juliana.martinez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 43),
    (168, 'Fernando', NULL, 'Zapata', 'Gómez', '3165289025', 'fernando.zapata@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 43),
    (169, 'Sofía', 'Laura', 'Castaño', 'Rincón', '3057707889', 'sofia.castano@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 43),
    (170, 'Isabella', 'Natalia', 'Ruiz', 'García', '3201755077', 'isabella.ruiz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 44),
    (171, 'Andrés', NULL, 'Becerra', NULL, '3141985817', 'andres.becerra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 44),
    (172, 'Ángela', 'Mariana', 'Muñoz', NULL, '3014552697', 'angela.munoz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 44),
    (173, 'Óscar', 'Carlos', 'Arango', NULL, '3048588795', 'oscar.arango@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 45),
    (174, 'Sofía', 'Diana', 'Sánchez', 'Peña', '3171006558', 'sofia.sanchez2@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 45),
    (175, 'Julián', 'Camilo', 'Herrera', 'Becerra', '3211156617', 'julian.herrera@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 45),
    (176, 'Paola', 'Alejandra', 'Romero', 'Rojas', '3042174298', 'paola.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 45),
    (177, 'Daniela', 'Sofía', 'Hernández', 'López', '3138849696', 'daniela.hernandez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 46),
    (178, 'Diana', NULL, 'Buitrago', 'Sánchez', '3213689368', 'diana.buitrago@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 46),
    (179, 'Santiago', NULL, 'Quintero', 'Cortés', '3164871941', 'santiago.quintero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 46),
    (180, 'Yuliana', 'Diana', 'Restrepo', 'Castaño', '3023955981', 'yuliana.restrepo@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 47),
    (181, 'Sara', 'Camila', 'Montoya', 'Rojas', '3056044438', 'sara.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 47),
    (182, 'Fernando', 'Esteban', 'Cárdenas', 'Sánchez', '3168055593', 'fernando.cardenas@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 47),
    (183, 'Juliana', NULL, 'Poveda', 'Lozano', '3043730253', 'juliana.poveda@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 48),
    (184, 'Esteban', NULL, 'Muñoz', 'Herrera', '3156876624', 'esteban.munoz@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 48),
    (185, 'Diana', NULL, 'Rodríguez', 'Ruiz', '3165211544', 'diana.rodriguez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 48),
    (186, 'Sofía', NULL, 'Montoya', 'Herrera', '3117609659', 'sofia.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 48),
    (187, 'Esteban', 'Juan', 'Rodríguez', NULL, '3127306727', 'esteban.rodriguez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 49),
    (188, 'Lorena', NULL, 'Gómez', 'Moreno', '3509299318', 'lorena.gomez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 49),
    (189, 'Juliana', NULL, 'Romero', 'Cárdenas', '3207012806', 'juliana.romero@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 49),
    (190, 'Julián', 'Gabriel', 'Suárez', 'Zapata', '3188540551', 'julian.suarez@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 49),
    (191, 'Luis', 'Gabriel', 'Montoya', 'Peña', '3231384149', 'luis.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 2, 50),
    (192, 'Manuela', 'Paula', 'Valencia', 'González', '3209655968', 'manuela.valencia@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 3, 50),
    (193, 'Alejandra', NULL, 'Montoya', 'Salazar', '3142741480', 'alejandra.montoya@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', TRUE, 4, 50),
    (194, 'Isabella', NULL, 'Parra', 'Valencia', '3111238531', 'isabella.parra@fitzone.com.co', '$2a$10$19tq4Sm0CVkrC8AFBIaETumPVOIksJq44eIEm7ntsm5.0XUHM4qR6', FALSE, 4, 50);

-- ---------------------------------------------------------------------
-- MIEMBRO (350)
-- ---------------------------------------------------------------------
INSERT INTO miembro (id_miembro, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, correo, id_sede, fecha_registro) VALUES
    (1, 'Marcela', 'Sara', 'Álvarez', 'Ortiz', '3164986637', 'marcela.alvarez@hotmail.com', 9, current_date - 6),
    (2, 'Luisa', NULL, 'Suárez', 'Valencia', '3006905094', 'luisa.suarez@hotmail.com', 47, current_date - 1),
    (3, 'Carolina', NULL, 'Becerra', 'Parra', '3508074946', 'carolina.becerra@gmail.com', 13, current_date - 2),
    (4, 'Mariana', 'Laura', 'López', 'Cifuentes', '3135490197', 'mariana.lopez@hotmail.com', 28, current_date - 5),
    (5, 'Diego', NULL, 'Martínez', NULL, '3023428870', 'diego.martinez@yahoo.com', 19, current_date - 4),
    (6, 'Ricardo', NULL, 'Montoya', 'Díaz', '3209382989', 'ricardo.montoya@yahoo.com', 4, current_date - 1),
    (7, 'Alejandro', 'Gabriel', 'Valencia', 'Castro', '3046340915', 'alejandro.valencia@yahoo.com', 20, current_date - 171),
    (8, 'Esteban', 'Nicolás', 'López', 'Cifuentes', '3109822279', 'esteban.lopez@hotmail.com', 25, current_date - 319),
    (9, 'Paola', NULL, 'Parra', 'Quintero', '3115175933', 'paola.parra@hotmail.com', 31, current_date - 484),
    (10, 'Fernando', 'Kevin', 'Álvarez', 'Rodríguez', '3127188892', 'fernando.alvarez@outlook.com', 23, current_date - 355),
    (11, 'Isabella', NULL, 'Cárdenas', 'Pérez', '3137026879', 'isabella.cardenas@outlook.com', 17, current_date - 343),
    (12, 'Lucía', NULL, 'Rodríguez', 'Montoya', '3019985395', 'lucia.rodriguez@hotmail.com', 37, current_date - 8),
    (13, 'Esteban', 'Héctor', 'Hernández', 'Romero', '3102715277', 'esteban.hernandez@yahoo.com', 17, current_date - 264),
    (14, 'Mariana', 'Juliana', 'Buitrago', 'Castro', '3137107275', 'mariana.buitrago@hotmail.com', 48, current_date - 280),
    (15, 'Isabella', NULL, 'Cortés', 'Gómez', '3505573091', 'isabella.cortes@unbosque.edu.co', 22, current_date - 325),
    (16, 'Paula', NULL, 'Lozano', 'Álvarez', '3028699383', 'paula.lozano@hotmail.com', 13, current_date - 461),
    (17, 'Santiago', 'Tomás', 'Gutiérrez', 'Londoño', '3239276988', 'santiago.gutierrez@hotmail.com', 43, current_date - 293),
    (18, 'David', 'Mauricio', 'Montoya', 'Muñoz', '3002182987', 'david.montoya@outlook.com', 25, current_date - 504),
    (19, 'Nicolás', 'Brayan', 'Ospina', 'Rojas', '3211370318', 'nicolas.ospina@hotmail.com', 38, current_date - 495),
    (20, 'Iván', 'Kevin', 'Castro', 'Sánchez', '3025061789', 'ivan.castro@gmail.com', 2, current_date - 8),
    (21, 'Mauricio', NULL, 'Muñoz', 'Cifuentes', '3154538296', 'mauricio.munoz@yahoo.com', 49, current_date - 171),
    (22, 'Yuliana', NULL, 'Castaño', 'Álvarez', '3057869233', 'yuliana.castano@yahoo.com', 23, current_date - 143),
    (23, 'Luisa', NULL, 'Montoya', 'Jiménez', '3181478166', 'luisa.montoya@hotmail.com', 23, current_date - 435),
    (24, 'Daniela', NULL, 'Romero', 'Castaño', '3219939527', 'daniela.romero@hotmail.com', 3, current_date - 218),
    (25, 'Isabella', 'Camila', 'Becerra', NULL, '3047718680', 'isabella.becerra@outlook.com', 31, current_date - 47),
    (26, 'Andrés', NULL, 'Mejía', 'Salazar', '3208862751', 'andres.mejia@outlook.com', 40, current_date - 155),
    (27, 'Esteban', NULL, 'Ortiz', 'Ruiz', '3171865210', 'esteban.ortiz@gmail.com', 43, current_date - 47),
    (28, 'Paola', 'Daniela', 'Mejía', NULL, '3188181249', 'paola.mejia@gmail.com', 10, current_date - 191),
    (29, 'Tomás', 'Camilo', 'Peña', 'Herrera', '3164467733', 'tomas.pena@gmail.com', 7, current_date - 410),
    (30, 'Natalia', 'Sara', 'Valencia', 'Herrera', '3207348286', 'natalia.valencia@outlook.com', 29, current_date - 409),
    (31, 'Felipe', 'Gabriel', 'Álvarez', 'Rincón', '3045207545', 'felipe.alvarez@outlook.com', 23, current_date - 171),
    (32, 'David', NULL, 'Acosta', 'Herrera', '3105828611', 'david.acosta@hotmail.com', 26, current_date - 45),
    (33, 'Iván', NULL, 'González', 'Sánchez', '3118609195', 'ivan.gonzalez@hotmail.com', 16, current_date - 509),
    (34, 'Marcela', NULL, 'Cifuentes', 'Rincón', '3022616900', 'marcela.cifuentes@outlook.com', 32, current_date - 52),
    (35, 'Héctor', 'Miguel', 'Peña', 'Londoño', '3045779613', 'hector.pena@hotmail.com', 29, current_date - 199),
    (36, 'Mauricio', NULL, 'Rodríguez', 'Romero', '3118854233', 'mauricio.rodriguez@yahoo.com', 50, current_date - 120),
    (37, 'Camilo', NULL, 'García', 'Ramírez', '3028899966', 'camilo.garcia@yahoo.com', 48, current_date - 144),
    (38, 'Daniela', NULL, 'Londoño', 'Ramírez', '3129464988', 'daniela.londono@gmail.com', 10, current_date - 14),
    (39, 'Natalia', NULL, 'Herrera', 'Cárdenas', '3211360009', 'natalia.herrera@hotmail.com', 29, current_date - 245),
    (40, 'Sofía', NULL, 'Arango', 'Gómez', '3173975976', 'sofia.arango@gmail.com', 19, current_date - 447),
    (41, 'Daniela', NULL, 'Zapata', NULL, '3104504571', 'daniela.zapata@yahoo.com', 37, current_date - 146),
    (42, 'Samuel', 'Jorge', 'Torres', 'Rodríguez', '3056309165', 'samuel.torres@hotmail.com', 3, current_date - 146),
    (43, 'Yuliana', NULL, 'Pérez', 'Lozano', '3156781258', 'yuliana.perez@unbosque.edu.co', 36, current_date - 236),
    (44, 'Ángela', 'Manuela', 'García', NULL, '3103317841', 'angela.garcia@outlook.com', 25, current_date - 277),
    (45, 'Juliana', NULL, 'Rincón', 'Gómez', '3023140586', 'juliana.rincon@hotmail.com', 11, current_date - 424),
    (46, 'Juliana', 'Diana', 'Peña', NULL, '3134429981', 'juliana.pena@gmail.com', 35, current_date - 387),
    (47, 'Ricardo', NULL, 'Arango', 'Cortés', '3152854979', 'ricardo.arango@outlook.com', 44, current_date - 368),
    (48, 'Sofía', NULL, 'Londoño', 'Romero', '3113342550', 'sofia.londono@unbosque.edu.co', 22, current_date - 368),
    (49, 'Mateo', NULL, 'García', 'Torres', '3127818689', 'mateo.garcia@yahoo.com', 37, current_date - 310),
    (50, 'Carlos', NULL, 'Suárez', 'Quintero', '3117989802', 'carlos.suarez@outlook.com', 33, current_date - 522),
    (51, 'Nicolás', NULL, 'Quintero', 'Rincón', '3045131630', 'nicolas.quintero@gmail.com', 48, current_date - 410),
    (52, 'Nicolás', NULL, 'López', NULL, '3164857332', 'nicolas.lopez@outlook.com', 15, current_date - 91),
    (53, 'Viviana', 'María', 'Mejía', 'Castro', '3182586698', 'viviana.mejia@unbosque.edu.co', 30, current_date - 333),
    (54, 'Iván', NULL, 'Cárdenas', 'Poveda', '3175824227', 'ivan.cardenas@yahoo.com', 12, current_date - 491),
    (55, 'Isabella', 'Alejandra', 'Buitrago', 'Rincón', '3504800450', 'isabella.buitrago@outlook.com', 41, current_date - 401),
    (56, 'Nicolás', 'Alejandro', 'Londoño', 'Buitrago', '3501256027', 'nicolas.londono@hotmail.com', 23, current_date - 382),
    (57, 'Alejandra', 'Yuliana', 'Cárdenas', 'Acosta', '3146741086', 'alejandra.cardenas@yahoo.com', 36, current_date - 6),
    (58, 'Diego', NULL, 'Londoño', 'Gómez', '3179869043', 'diego.londono@unbosque.edu.co', 40, current_date - 282),
    (59, 'Mariana', NULL, 'Mejía', 'Vargas', '3056511297', 'mariana.mejia@gmail.com', 26, current_date - 188),
    (60, 'Tatiana', 'Valentina', 'Rojas', 'Pérez', '3509398484', 'tatiana.rojas@gmail.com', 35, current_date - 447),
    (61, 'Viviana', NULL, 'Díaz', 'González', '3114816866', 'viviana.diaz@outlook.com', 41, current_date - 21),
    (62, 'Diego', NULL, 'Suárez', 'Cortés', '3205974324', 'diego.suarez@gmail.com', 23, current_date - 105),
    (63, 'Isabella', NULL, 'Cárdenas', 'Rodríguez', '3188196471', 'isabella.cardenas@gmail.com', 5, current_date - 456),
    (64, 'Jorge', NULL, 'Gómez', 'Restrepo', '3029471297', 'jorge.gomez@gmail.com', 47, current_date - 519),
    (65, 'Diego', 'Brayan', 'Jiménez', 'Pérez', '3217660328', 'diego.jimenez@unbosque.edu.co', 12, current_date - 134),
    (66, 'Marcela', 'Daniela', 'Castro', 'González', '3004651160', 'marcela.castro@unbosque.edu.co', 24, current_date - 248),
    (67, 'Lucía', NULL, 'Herrera', 'Hernández', '3149865238', 'lucia.herrera@hotmail.com', 29, current_date - 453),
    (68, 'Iván', 'Héctor', 'Restrepo', 'Montoya', '3016196461', 'ivan.restrepo@outlook.com', 5, current_date - 300),
    (69, 'Camilo', 'Carlos', 'Vargas', 'Mendoza', '3157356804', 'camilo.vargas@yahoo.com', 21, current_date - 236),
    (70, 'Juliana', 'Sara', 'Ruiz', 'Mendoza', '3013745050', 'juliana.ruiz@hotmail.com', 25, current_date - 540),
    (71, 'Brayan', NULL, 'Cortés', 'Ruiz', '3049084938', 'brayan.cortes@gmail.com', 50, current_date - 102),
    (72, 'Alejandra', 'Marcela', 'Muñoz', 'Acosta', '3133607375', 'alejandra.munoz@outlook.com', 28, current_date - 136),
    (73, 'Jorge', NULL, 'Herrera', 'Álvarez', '3178863610', 'jorge.herrera@yahoo.com', 42, current_date - 330),
    (74, 'Jorge', NULL, 'Acosta', 'Cárdenas', '3167638519', 'jorge.acosta@gmail.com', 39, current_date - 535),
    (75, 'Santiago', 'Nicolás', 'Hernández', 'Cárdenas', '3172668466', 'santiago.hernandez@gmail.com', 42, current_date - 469),
    (76, 'Mateo', 'Sebastián', 'Suárez', NULL, '3166579685', 'mateo.suarez@outlook.com', 24, current_date - 284),
    (77, 'Catalina', NULL, 'Londoño', 'Álvarez', '3149114041', 'catalina.londono@yahoo.com', 9, current_date - 349),
    (78, 'Alejandro', 'Jhonatan', 'Lozano', 'González', '3141782910', 'alejandro.lozano@outlook.com', 18, current_date - 471),
    (79, 'Isabella', 'Carolina', 'Pérez', 'Álvarez', '3164214815', 'isabella.perez@gmail.com', 16, current_date - 265),
    (80, 'Miguel', NULL, 'Muñoz', 'Álvarez', '3059538558', 'miguel.munoz@gmail.com', 33, current_date - 31),
    (81, 'Lucía', NULL, 'Restrepo', 'Becerra', '3184477747', 'lucia.restrepo@yahoo.com', 4, current_date - 239),
    (82, 'Felipe', NULL, 'Álvarez', NULL, '3057612695', 'felipe.alvarez@hotmail.com', 3, current_date - 141),
    (83, 'Samuel', NULL, 'González', 'García', '3177862946', 'samuel.gonzalez@unbosque.edu.co', 12, current_date - 231),
    (84, 'Lina', 'Carolina', 'Arango', 'Romero', '3201476525', 'lina.arango@gmail.com', 45, current_date - 125),
    (85, 'Óscar', 'Camilo', 'Muñoz', NULL, '3231719302', 'oscar.munoz@outlook.com', 34, current_date - 185),
    (86, 'Brayan', 'Camilo', 'Castro', 'Parra', '3126669975', 'brayan.castro@hotmail.com', 19, current_date - 305),
    (87, 'María', 'Ángela', 'Becerra', 'Castro', '3144037636', 'maria.becerra@yahoo.com', 15, current_date - 497),
    (88, 'Laura', NULL, 'Castaño', 'Castro', '3139864622', 'laura.castano@gmail.com', 7, current_date - 175),
    (89, 'Jorge', 'Kevin', 'Lozano', NULL, '3505643481', 'jorge.lozano@hotmail.com', 9, current_date - 54),
    (90, 'Juan', 'Felipe', 'Arango', 'Peña', '3054283536', 'juan.arango@gmail.com', 35, current_date - 446),
    (91, 'Andrea', NULL, 'Cifuentes', 'Ortiz', '3183132788', 'andrea.cifuentes@hotmail.com', 39, current_date - 249),
    (92, 'Tomás', NULL, 'Muñoz', 'Castaño', '3104139603', 'tomas.munoz@yahoo.com', 8, current_date - 153),
    (93, 'Alejandra', NULL, 'Cifuentes', 'Zapata', '3126824514', 'alejandra.cifuentes@outlook.com', 39, current_date - 418),
    (94, 'Diana', NULL, 'Salazar', 'Rodríguez', '3177678641', 'diana.salazar@gmail.com', 12, current_date - 237),
    (95, 'David', NULL, 'Poveda', 'Salazar', '3159059061', 'david.poveda@outlook.com', 23, current_date - 354),
    (96, 'María', NULL, 'Hernández', 'Poveda', '3217691619', 'maria.hernandez@gmail.com', 37, current_date - 51),
    (97, 'Carolina', NULL, 'Ruiz', NULL, '3161131024', 'carolina.ruiz@unbosque.edu.co', 1, current_date - 310),
    (98, 'Ricardo', 'Brayan', 'Pérez', 'Sánchez', '3154756144', 'ricardo.perez@yahoo.com', 33, current_date - 432),
    (99, 'Óscar', 'Juan', 'Sánchez', NULL, '3189469965', 'oscar.sanchez@outlook.com', 3, current_date - 539),
    (100, 'Mauricio', 'Esteban', 'Restrepo', 'Arango', '3179894571', 'mauricio.restrepo@yahoo.com', 4, current_date - 476),
    (101, 'Brayan', NULL, 'Acosta', 'Ruiz', '3188116982', 'brayan.acosta@unbosque.edu.co', 1, current_date - 347),
    (102, 'María', NULL, 'Zapata', 'Rodríguez', '3045251599', 'maria.zapata@outlook.com', 15, current_date - 22),
    (103, 'Iván', 'Miguel', 'Montoya', 'Mejía', '3042840592', 'ivan.montoya@hotmail.com', 3, current_date - 232),
    (104, 'Esteban', 'Jhonatan', 'Gómez', 'Mejía', '3167815676', 'esteban.gomez@hotmail.com', 43, current_date - 306),
    (105, 'Marcela', NULL, 'Zapata', 'Mendoza', '3149069181', 'marcela.zapata@unbosque.edu.co', 47, current_date - 263),
    (106, 'Luis', NULL, 'Peña', 'Rojas', '3051392679', 'luis.pena@unbosque.edu.co', 29, current_date - 16),
    (107, 'Paola', NULL, 'Restrepo', NULL, '3117007375', 'paola.restrepo@unbosque.edu.co', 25, current_date - 435),
    (108, 'Luis', NULL, 'Buitrago', 'García', '3159812506', 'luis.buitrago@outlook.com', 9, current_date - 48),
    (109, 'Daniela', NULL, 'Rojas', 'Parra', '3008737749', 'daniela.rojas@outlook.com', 29, current_date - 421),
    (110, 'Brayan', 'Mauricio', 'Ortiz', 'Muñoz', '3026827105', 'brayan.ortiz@gmail.com', 18, current_date - 183),
    (111, 'Jhonatan', 'Camilo', 'Gómez', 'Poveda', '3118485308', 'jhonatan.gomez@hotmail.com', 39, current_date - 134),
    (112, 'Daniel', 'Jorge', 'Castaño', 'Gutiérrez', '3026931262', 'daniel.castano@hotmail.com', 33, current_date - 284),
    (113, 'Tomás', NULL, 'García', NULL, '3026215308', 'tomas.garcia@unbosque.edu.co', 50, current_date - 213),
    (114, 'Daniela', 'Andrea', 'Gómez', 'Ospina', '3016370565', 'daniela.gomez@hotmail.com', 16, current_date - 419),
    (115, 'Gabriel', NULL, 'Rincón', 'Becerra', '3202616136', 'gabriel.rincon@unbosque.edu.co', 42, current_date - 171),
    (116, 'Viviana', 'Juliana', 'Álvarez', 'Londoño', '3189763190', 'viviana.alvarez@hotmail.com', 47, current_date - 475),
    (117, 'Mateo', NULL, 'Castro', NULL, '3184203313', 'mateo.castro@unbosque.edu.co', 28, current_date - 288),
    (118, 'Camilo', 'Tomás', 'Buitrago', NULL, '3113014583', 'camilo.buitrago@hotmail.com', 49, current_date - 72),
    (119, 'Marcela', NULL, 'Torres', NULL, '3115824937', 'marcela.torres@unbosque.edu.co', 48, current_date - 316),
    (120, 'Ángela', NULL, 'Herrera', 'Zapata', '3507503876', 'angela.herrera@unbosque.edu.co', 7, current_date - 226),
    (121, 'Daniel', NULL, 'Buitrago', 'Arango', '3058840375', 'daniel.buitrago@outlook.com', 47, current_date - 400),
    (122, 'Iván', 'Daniel', 'Romero', 'Vargas', '3188595481', 'ivan.romero@gmail.com', 21, current_date - 479),
    (123, 'Natalia', 'Mariana', 'Rodríguez', 'Ospina', '3187468231', 'natalia.rodriguez@unbosque.edu.co', 11, current_date - 13),
    (124, 'Lina', 'Paola', 'Castaño', 'Vargas', '3114075124', 'lina.castano@gmail.com', 20, current_date - 474),
    (125, 'Paola', 'Yuliana', 'Sánchez', NULL, '3182398941', 'paola.sanchez@yahoo.com', 38, current_date - 288),
    (126, 'Manuela', 'María', 'Ruiz', 'Jiménez', '3176967716', 'manuela.ruiz@unbosque.edu.co', 16, current_date - 384),
    (127, 'Sebastián', 'Ricardo', 'Moreno', NULL, '3125355351', 'sebastian.moreno@outlook.com', 38, current_date - 282),
    (128, 'Mateo', NULL, 'Hernández', 'Muñoz', '3135054197', 'mateo.hernandez@yahoo.com', 41, current_date - 73),
    (129, 'Sebastián', NULL, 'Ruiz', 'Valencia', '3007878232', 'sebastian.ruiz@yahoo.com', 6, current_date - 274),
    (130, 'Tatiana', NULL, 'Martínez', 'Cortés', '3235683208', 'tatiana.martinez@unbosque.edu.co', 12, current_date - 385),
    (131, 'Yuliana', NULL, 'Martínez', 'Mejía', '3016552602', 'yuliana.martinez@outlook.com', 1, current_date - 549),
    (132, 'Mariana', 'Lorena', 'Suárez', 'Zapata', '3125512269', 'mariana.suarez@yahoo.com', 38, current_date - 336),
    (133, 'Esteban', NULL, 'Ospina', 'González', '3003960325', 'esteban.ospina@hotmail.com', 41, current_date - 19),
    (134, 'Lucía', NULL, 'Martínez', 'Arango', '3118906081', 'lucia.martinez@yahoo.com', 21, current_date - 520),
    (135, 'David', NULL, 'Salazar', 'Quintero', '3136867755', 'david.salazar@hotmail.com', 36, current_date - 6),
    (136, 'Carlos', 'Kevin', 'Rincón', NULL, '3028730100', 'carlos.rincon@unbosque.edu.co', 45, current_date - 218),
    (137, 'Carlos', 'Julián', 'Jiménez', 'Sánchez', '3181045686', 'carlos.jimenez@hotmail.com', 19, current_date - 424),
    (138, 'Isabella', NULL, 'Poveda', NULL, '3151026292', 'isabella.poveda@hotmail.com', 24, current_date - 91),
    (139, 'Isabella', NULL, 'González', 'Álvarez', '3045366288', 'isabella.gonzalez@yahoo.com', 30, current_date - 330),
    (140, 'Tomás', NULL, 'Rojas', 'García', '3211152190', 'tomas.rojas@gmail.com', 3, current_date - 441),
    (141, 'Ricardo', 'Luis', 'Parra', NULL, '3151594246', 'ricardo.parra@outlook.com', 31, current_date - 186),
    (142, 'Carolina', 'Andrea', 'Castaño', 'Pérez', '3136121863', 'carolina.castano@outlook.com', 2, current_date - 564),
    (143, 'Iván', NULL, 'Parra', 'Suárez', '3503091389', 'ivan.parra@gmail.com', 30, current_date - 306),
    (144, 'Paola', NULL, 'Herrera', 'Restrepo', '3055912397', 'paola.herrera@hotmail.com', 46, current_date - 160),
    (145, 'Gabriela', NULL, 'Martínez', NULL, '3155910030', 'gabriela.martinez@hotmail.com', 26, current_date - 355),
    (146, 'Esteban', NULL, 'Gómez', NULL, '3215874864', 'esteban.gomez@gmail.com', 24, current_date - 261),
    (147, 'Felipe', NULL, 'Becerra', 'Vargas', '3183518478', 'felipe.becerra@yahoo.com', 13, current_date - 9),
    (148, 'Alejandra', NULL, 'Peña', 'Castaño', '3128656714', 'alejandra.pena@gmail.com', 28, current_date - 624),
    (149, 'Lina', 'Manuela', 'Ruiz', 'Zapata', '3218904323', 'lina.ruiz@yahoo.com', 42, current_date - 466),
    (150, 'Carolina', 'Valentina', 'Martínez', 'Restrepo', '3161839685', 'carolina.martinez@hotmail.com', 50, current_date - 425),
    (151, 'Santiago', NULL, 'Ruiz', NULL, '3046124405', 'santiago.ruiz@outlook.com', 24, current_date - 482),
    (152, 'Juliana', 'Luisa', 'Arango', 'Montoya', '3232425580', 'juliana.arango@unbosque.edu.co', 23, current_date - 83),
    (153, 'Isabella', 'Ángela', 'Torres', 'Becerra', '3002756788', 'isabella.torres@hotmail.com', 19, current_date - 90),
    (154, 'Héctor', 'Tomás', 'Peña', 'Suárez', '3162982110', 'hector.pena2@hotmail.com', 33, current_date - 20),
    (155, 'Paula', 'Laura', 'Díaz', 'Acosta', '3176187202', 'paula.diaz@unbosque.edu.co', 32, current_date - 315),
    (156, 'Iván', NULL, 'Mendoza', 'Mejía', '3207604637', 'ivan.mendoza@hotmail.com', 45, current_date - 107),
    (157, 'Lucía', 'Lorena', 'Suárez', 'Moreno', '3059165780', 'lucia.suarez@yahoo.com', 11, current_date - 322),
    (158, 'Brayan', 'Esteban', 'Torres', NULL, '3232917074', 'brayan.torres@hotmail.com', 46, current_date - 317),
    (159, 'Sofía', NULL, 'Becerra', 'Gómez', '3052547166', 'sofia.becerra@yahoo.com', 26, current_date - 553),
    (160, 'Sofía', NULL, 'Díaz', 'González', '3177674132', 'sofia.diaz@hotmail.com', 37, current_date - 258),
    (161, 'Alejandra', NULL, 'Poveda', NULL, '3159717761', 'alejandra.poveda@gmail.com', 30, current_date - 315),
    (162, 'Fernando', 'Julián', 'Buitrago', 'Martínez', '3175164216', 'fernando.buitrago@hotmail.com', 22, current_date - 536),
    (163, 'Jorge', 'Alejandro', 'Gutiérrez', 'Ortiz', '3207806358', 'jorge.gutierrez@outlook.com', 11, current_date - 415),
    (164, 'Miguel', NULL, 'Lozano', 'González', '3116120792', 'miguel.lozano@hotmail.com', 10, current_date - 343),
    (165, 'Mariana', 'Paola', 'Jiménez', 'Valencia', '3144990028', 'mariana.jimenez@gmail.com', 35, current_date - 234),
    (166, 'Juan', NULL, 'Ortiz', 'Poveda', '3101045572', 'juan.ortiz@hotmail.com', 2, current_date - 490),
    (167, 'Miguel', NULL, 'Sánchez', 'Mejía', '3054855382', 'miguel.sanchez@yahoo.com', 10, current_date - 117),
    (168, 'Diego', 'Alejandro', 'Buitrago', 'Londoño', '3142572245', 'diego.buitrago@hotmail.com', 47, current_date - 597),
    (169, 'Lucía', 'Mariana', 'Cortés', 'Jiménez', '3145486456', 'lucia.cortes@yahoo.com', 12, current_date - 162),
    (170, 'Juan', 'Mauricio', 'Buitrago', 'Londoño', '3101594180', 'juan.buitrago@unbosque.edu.co', 15, current_date - 262),
    (171, 'Mauricio', NULL, 'Quintero', 'Restrepo', '3124402353', 'mauricio.quintero@unbosque.edu.co', 16, current_date - 98),
    (172, 'Sara', NULL, 'Vargas', 'Parra', '3027070355', 'sara.vargas@outlook.com', 15, current_date - 23),
    (173, 'Lina', NULL, 'García', 'Ortiz', '3174461295', 'lina.garcia@unbosque.edu.co', 13, current_date - 482),
    (174, 'Laura', NULL, 'Ospina', 'Martínez', '3162449857', 'laura.ospina@hotmail.com', 42, current_date - 66),
    (175, 'Tatiana', 'Mariana', 'Álvarez', 'González', '3183349278', 'tatiana.alvarez@unbosque.edu.co', 26, current_date - 125),
    (176, 'Laura', 'Diana', 'Hernández', 'Herrera', '3146417300', 'laura.hernandez@hotmail.com', 42, current_date - 188),
    (177, 'Yuliana', NULL, 'Pérez', 'Ospina', '3123943623', 'yuliana.perez2@unbosque.edu.co', 20, current_date - 386),
    (178, 'Lina', 'Juliana', 'Cárdenas', NULL, '3136500367', 'lina.cardenas@hotmail.com', 27, current_date - 202),
    (179, 'Natalia', NULL, 'Ramírez', 'Torres', '3046777645', 'natalia.ramirez@unbosque.edu.co', 4, current_date - 506),
    (180, 'Jhonatan', 'Gabriel', 'González', 'Parra', '3129939007', 'jhonatan.gonzalez@gmail.com', 35, current_date - 26),
    (181, 'Samuel', 'Gabriel', 'Ospina', 'Álvarez', '3007667741', 'samuel.ospina@hotmail.com', 32, current_date - 362),
    (182, 'David', 'Santiago', 'Peña', NULL, '3158438243', 'david.pena@outlook.com', 49, current_date - 404),
    (183, 'Lina', 'Paula', 'Gutiérrez', 'Cárdenas', '3214127543', 'lina.gutierrez@gmail.com', 5, current_date - 186),
    (184, 'Mauricio', 'Mateo', 'Mejía', NULL, '3501853052', 'mauricio.mejia@yahoo.com', 27, current_date - 336),
    (185, 'Ángela', 'Carolina', 'Mejía', 'Peña', '3101516137', 'angela.mejia@yahoo.com', 38, current_date - 473),
    (186, 'Paula', NULL, 'Peña', 'Rodríguez', '3103602528', 'paula.pena@hotmail.com', 31, current_date - 161),
    (187, 'Iván', 'Diego', 'Castro', 'Gutiérrez', '3158492939', 'ivan.castro@unbosque.edu.co', 24, current_date - 8),
    (188, 'Paola', 'Diana', 'Salazar', 'Gutiérrez', '3142727961', 'paola.salazar@hotmail.com', 20, current_date - 590),
    (189, 'Paola', NULL, 'Rincón', 'Gómez', '3234393561', 'paola.rincon@hotmail.com', 22, current_date - 329),
    (190, 'Luis', NULL, 'Díaz', 'Herrera', '3124565706', 'luis.diaz@outlook.com', 49, current_date - 379),
    (191, 'Diego', NULL, 'Zapata', 'Castro', '3152715008', 'diego.zapata@hotmail.com', 16, current_date - 266),
    (192, 'Jorge', 'Samuel', 'Romero', NULL, '3187180204', 'jorge.romero@yahoo.com', 16, current_date - 291),
    (193, 'Ángela', 'Sofía', 'Ospina', 'García', '3046896990', 'angela.ospina@yahoo.com', 1, current_date - 514),
    (194, 'Tatiana', 'Sara', 'García', 'Restrepo', '3008622919', 'tatiana.garcia@hotmail.com', 22, current_date - 292),
    (195, 'Laura', NULL, 'Martínez', 'Ramírez', '3183298346', 'laura.martinez@outlook.com', 20, current_date - 16),
    (196, 'Juliana', 'Paula', 'Lozano', 'Álvarez', '3177525233', 'juliana.lozano@unbosque.edu.co', 46, current_date - 196),
    (197, 'Paula', 'Valentina', 'Ospina', 'Gutiérrez', '3142736161', 'paula.ospina@outlook.com', 24, current_date - 131),
    (198, 'Camilo', NULL, 'Castaño', 'Ruiz', '3029045025', 'camilo.castano@unbosque.edu.co', 23, current_date - 416),
    (199, 'Marcela', 'Paola', 'Cárdenas', 'Salazar', '3201631837', 'marcela.cardenas@hotmail.com', 7, current_date - 95),
    (200, 'Tomás', NULL, 'Hernández', 'Peña', '3124150312', 'tomas.hernandez@hotmail.com', 13, current_date - 135),
    (201, 'María', NULL, 'Gómez', 'Lozano', '3171795655', 'maria.gomez@gmail.com', 38, current_date - 45),
    (202, 'Andrea', NULL, 'López', 'Torres', '3166286937', 'andrea.lopez@outlook.com', 3, current_date - 339),
    (203, 'Kevin', 'Gabriel', 'Hernández', 'Poveda', '3048090201', 'kevin.hernandez@outlook.com', 39, current_date - 423),
    (204, 'Diego', NULL, 'Cárdenas', 'Gómez', '3502380117', 'diego.cardenas@yahoo.com', 34, current_date - 158),
    (205, 'Viviana', 'Ángela', 'Suárez', 'Mejía', '3207145945', 'viviana.suarez@gmail.com', 32, current_date - 513),
    (206, 'Carolina', NULL, 'Cifuentes', 'Zapata', '3216863301', 'carolina.cifuentes@unbosque.edu.co', 35, current_date - 511),
    (207, 'Camila', NULL, 'Ospina', NULL, '3168521143', 'camila.ospina@hotmail.com', 43, current_date - 32),
    (208, 'Viviana', NULL, 'Becerra', 'Mejía', '3153391835', 'viviana.becerra@yahoo.com', 33, current_date - 91),
    (209, 'Juliana', NULL, 'Pérez', 'Ramírez', '3101828886', 'juliana.perez@gmail.com', 2, current_date - 19),
    (210, 'Felipe', NULL, 'Jiménez', 'Muñoz', '3216336502', 'felipe.jimenez@outlook.com', 7, current_date - 105),
    (211, 'Sebastián', 'Diego', 'Romero', 'Sánchez', '3115828273', 'sebastian.romero@gmail.com', 13, current_date - 455),
    (212, 'Andrea', 'Juliana', 'Mejía', 'Castro', '3054987190', 'andrea.mejia@outlook.com', 44, current_date - 120),
    (213, 'Nicolás', NULL, 'Restrepo', 'González', '3008239943', 'nicolas.restrepo@hotmail.com', 2, current_date - 328),
    (214, 'Viviana', 'Lucía', 'Restrepo', 'Arango', '3216777067', 'viviana.restrepo@hotmail.com', 9, current_date - 263),
    (215, 'Santiago', 'Samuel', 'Salazar', 'López', '3048652659', 'santiago.salazar@hotmail.com', 9, current_date - 363),
    (216, 'Jhonatan', 'Santiago', 'Castro', 'Acosta', '3219497839', 'jhonatan.castro@unbosque.edu.co', 1, current_date - 339),
    (217, 'Jhonatan', NULL, 'Salazar', NULL, '3204688670', 'jhonatan.salazar@gmail.com', 39, current_date - 602),
    (218, 'Valentina', 'Ángela', 'Herrera', 'Ramírez', '3219922201', 'valentina.herrera@unbosque.edu.co', 15, current_date - 131),
    (219, 'Jhonatan', NULL, 'Díaz', 'Valencia', '3205717318', 'jhonatan.diaz@unbosque.edu.co', 22, current_date - 313),
    (220, 'Andrés', 'Jhonatan', 'González', 'Arango', '3139932425', 'andres.gonzalez@gmail.com', 27, current_date - 179),
    (221, 'Iván', NULL, 'Torres', 'Castaño', '3237515174', 'ivan.torres@outlook.com', 46, current_date - 199),
    (222, 'Esteban', NULL, 'Ramírez', 'Moreno', '3051897140', 'esteban.ramirez@outlook.com', 6, current_date - 73),
    (223, 'Viviana', 'Mariana', 'Cifuentes', NULL, '3127375940', 'viviana.cifuentes@gmail.com', 45, current_date - 452),
    (224, 'Julián', 'Luis', 'Ruiz', 'Castaño', '3218989633', 'julian.ruiz@yahoo.com', 28, current_date - 103),
    (225, 'Mateo', NULL, 'Parra', 'Montoya', '3142028238', 'mateo.parra@gmail.com', 47, current_date - 425),
    (226, 'Luisa', 'Daniela', 'García', 'Álvarez', '3017406052', 'luisa.garcia@hotmail.com', 20, current_date - 437),
    (227, 'Diana', 'Viviana', 'Martínez', 'Muñoz', '3505960680', 'diana.martinez@yahoo.com', 28, current_date - 285),
    (228, 'Juan', NULL, 'Zapata', 'Romero', '3204139032', 'juan.zapata@gmail.com', 48, current_date - 305),
    (229, 'María', NULL, 'Zapata', 'Cifuentes', '3015542381', 'maria.zapata@unbosque.edu.co', 45, current_date - 110),
    (230, 'Fernando', 'Iván', 'Valencia', 'Gómez', '3174282246', 'fernando.valencia@outlook.com', 27, current_date - 86),
    (231, 'Jorge', 'Andrés', 'Hernández', 'Becerra', '3026636822', 'jorge.hernandez@outlook.com', 11, current_date - 231),
    (232, 'David', NULL, 'Moreno', 'Londoño', '3146546447', 'david.moreno@outlook.com', 6, current_date - 161),
    (233, 'Tomás', 'Héctor', 'Ruiz', 'Peña', '3168568281', 'tomas.ruiz@hotmail.com', 7, current_date - 462),
    (234, 'Héctor', NULL, 'Rincón', 'Restrepo', '3021308633', 'hector.rincon@hotmail.com', 27, current_date - 293),
    (235, 'Juliana', NULL, 'Poveda', 'García', '3185929807', 'juliana.poveda@gmail.com', 13, current_date - 510),
    (236, 'Ángela', 'Laura', 'Lozano', 'Castaño', '3164162723', 'angela.lozano@yahoo.com', 5, current_date - 242),
    (237, 'Alejandro', NULL, 'López', 'Londoño', '3155654890', 'alejandro.lopez@outlook.com', 46, current_date - 447),
    (238, 'Camila', NULL, 'Salazar', 'Martínez', '3173956527', 'camila.salazar@yahoo.com', 11, current_date - 287),
    (239, 'Brayan', 'Gabriel', 'Ruiz', 'Vargas', '3154305380', 'brayan.ruiz@hotmail.com', 37, current_date - 89),
    (240, 'Andrés', NULL, 'Martínez', 'Londoño', '3043778401', 'andres.martinez@hotmail.com', 49, current_date - 144),
    (241, 'Sofía', 'Viviana', 'Martínez', 'Rincón', '3102167088', 'sofia.martinez@yahoo.com', 31, current_date - 169),
    (242, 'Juan', 'Mauricio', 'Hernández', 'García', '3004738744', 'juan.hernandez@gmail.com', 47, current_date - 185),
    (243, 'Esteban', 'Sebastián', 'Acosta', 'Hernández', '3021422100', 'esteban.acosta@outlook.com', 45, current_date - 236),
    (244, 'Brayan', 'Diego', 'Acosta', 'Ortiz', '3158223103', 'brayan.acosta@hotmail.com', 33, current_date - 294),
    (245, 'Kevin', NULL, 'Rodríguez', 'Herrera', '3502742367', 'kevin.rodriguez@hotmail.com', 38, current_date - 38),
    (246, 'Laura', NULL, 'Valencia', 'Rojas', '3149324694', 'laura.valencia@gmail.com', 19, current_date - 616),
    (247, 'Nicolás', NULL, 'Castro', 'Gutiérrez', '3173878111', 'nicolas.castro@hotmail.com', 38, current_date - 310),
    (248, 'Lorena', NULL, 'Ruiz', 'Cortés', '3157597346', 'lorena.ruiz@unbosque.edu.co', 34, current_date - 287),
    (249, 'Lucía', 'Marcela', 'Ospina', 'González', '3011736139', 'lucia.ospina@hotmail.com', 26, current_date - 343),
    (250, 'Jhonatan', NULL, 'Pérez', 'Ortiz', '3238779043', 'jhonatan.perez@unbosque.edu.co', 29, current_date - 387),
    (251, 'Santiago', 'Iván', 'Quintero', 'Díaz', '3219729177', 'santiago.quintero@yahoo.com', 35, current_date - 154),
    (252, 'Santiago', NULL, 'Álvarez', 'Rodríguez', '3504155699', 'santiago.alvarez@hotmail.com', 7, current_date - 104),
    (253, 'Kevin', NULL, 'García', 'Montoya', '3015852943', 'kevin.garcia@hotmail.com', 30, current_date - 274),
    (254, 'Andrea', NULL, 'Buitrago', 'Salazar', '3215538349', 'andrea.buitrago@yahoo.com', 5, current_date - 403),
    (255, 'Carlos', NULL, 'Mendoza', NULL, '3184234417', 'carlos.mendoza@outlook.com', 9, current_date - 356),
    (256, 'Natalia', NULL, 'Herrera', 'Poveda', '3005721700', 'natalia.herrera@yahoo.com', 46, current_date - 37),
    (257, 'Nicolás', NULL, 'Herrera', 'Torres', '3012331375', 'nicolas.herrera@outlook.com', 36, current_date - 149),
    (258, 'Daniela', NULL, 'Quintero', 'Mejía', '3201405154', 'daniela.quintero@gmail.com', 16, current_date - 482),
    (259, 'Viviana', NULL, 'Mejía', 'Peña', '3214701527', 'viviana.mejia2@unbosque.edu.co', 41, current_date - 402),
    (260, 'Yuliana', 'Alejandra', 'Lozano', 'Restrepo', '3171398768', 'yuliana.lozano@outlook.com', 47, current_date - 329),
    (261, 'Daniel', NULL, 'Rincón', 'Cárdenas', '3203373106', 'daniel.rincon@hotmail.com', 4, current_date - 138),
    (262, 'Sofía', 'Paola', 'Rojas', NULL, '3186237451', 'sofia.rojas@outlook.com', 44, current_date - 441),
    (263, 'Mariana', NULL, 'Londoño', 'Restrepo', '3154551320', 'mariana.londono@yahoo.com', 5, current_date - 293),
    (264, 'Diana', NULL, 'Castaño', 'Acosta', '3503718198', 'diana.castano@gmail.com', 12, current_date - 679),
    (265, 'Gabriela', 'Juliana', 'Quintero', 'López', '3207414634', 'gabriela.quintero@gmail.com', 19, current_date - 517),
    (266, 'Ángela', 'Paula', 'Cárdenas', 'Cifuentes', '3143971339', 'angela.cardenas@hotmail.com', 30, current_date - 252),
    (267, 'Mariana', NULL, 'Mejía', NULL, '3172648765', 'mariana.mejia@yahoo.com', 31, current_date - 467),
    (268, 'María', NULL, 'Quintero', NULL, '3175241051', 'maria.quintero@gmail.com', 33, current_date - 515),
    (269, 'Jhonatan', NULL, 'Díaz', 'Ramírez', '3049604464', 'jhonatan.diaz@outlook.com', 34, current_date - 351),
    (270, 'Lucía', NULL, 'Mejía', 'Arango', '3185821635', 'lucia.mejia@unbosque.edu.co', 26, current_date - 73),
    (271, 'Sebastián', 'Julián', 'Martínez', 'Muñoz', '3101836296', 'sebastian.martinez@hotmail.com', 32, current_date - 220),
    (272, 'Felipe', 'Fernando', 'Moreno', 'García', '3147356320', 'felipe.moreno@unbosque.edu.co', 44, current_date - 257),
    (273, 'Tomás', NULL, 'Peña', NULL, '3057422180', 'tomas.pena2@gmail.com', 44, current_date - 586),
    (274, 'Esteban', NULL, 'Gutiérrez', 'López', '3218597480', 'esteban.gutierrez@unbosque.edu.co', 30, current_date - 206),
    (275, 'Lorena', NULL, 'Ramírez', NULL, '3135759053', 'lorena.ramirez@yahoo.com', 4, current_date - 19),
    (276, 'Camila', NULL, 'Rincón', NULL, '3175928416', 'camila.rincon@yahoo.com', 38, current_date - 418),
    (277, 'Marcela', 'Catalina', 'Cortés', 'Quintero', '3161482282', 'marcela.cortes@gmail.com', 35, current_date - 274),
    (278, 'Daniel', 'Ricardo', 'Valencia', NULL, '3104077149', 'daniel.valencia@gmail.com', 35, current_date - 189),
    (279, 'Mateo', 'Daniel', 'Herrera', 'Ruiz', '3103986075', 'mateo.herrera@outlook.com', 16, current_date - 482),
    (280, 'Paula', NULL, 'Castro', 'Salazar', '3005793300', 'paula.castro@outlook.com', 3, current_date - 113),
    (281, 'Miguel', 'Héctor', 'García', NULL, '3048267133', 'miguel.garcia@unbosque.edu.co', 12, current_date - 388),
    (282, 'Gabriel', 'Mateo', 'Cifuentes', 'Pérez', '3171153004', 'gabriel.cifuentes@hotmail.com', 34, current_date - 526),
    (283, 'Catalina', NULL, 'Rodríguez', 'Hernández', '3209137866', 'catalina.rodriguez@yahoo.com', 3, current_date - 86),
    (284, 'Andrés', NULL, 'Hernández', 'Restrepo', '3169391189', 'andres.hernandez@yahoo.com', 34, current_date - 94),
    (285, 'Héctor', 'Jorge', 'Gutiérrez', 'Muñoz', '3181719471', 'hector.gutierrez@unbosque.edu.co', 37, current_date - 84),
    (286, 'Iván', 'Sebastián', 'Suárez', 'Castro', '3201813131', 'ivan.suarez@hotmail.com', 45, current_date - 508),
    (287, 'Lorena', 'Isabella', 'Ruiz', 'Quintero', '3122554294', 'lorena.ruiz@yahoo.com', 9, current_date - 265),
    (288, 'Lorena', NULL, 'Buitrago', 'Hernández', '3168390301', 'lorena.buitrago@gmail.com', 4, current_date - 395),
    (289, 'Yuliana', NULL, 'Ramírez', 'Romero', '3026704195', 'yuliana.ramirez@outlook.com', 49, current_date - 98),
    (290, 'Ángela', NULL, 'Pérez', 'Ospina', '3045609398', 'angela.perez@unbosque.edu.co', 36, current_date - 232),
    (291, 'Gabriela', 'Luisa', 'Cortés', 'López', '3164958980', 'gabriela.cortes@hotmail.com', 26, current_date - 102),
    (292, 'Brayan', NULL, 'Restrepo', 'González', '3119904344', 'brayan.restrepo@yahoo.com', 9, current_date - 213),
    (293, 'Jorge', 'Daniel', 'Rincón', 'García', '3239063809', 'jorge.rincon@gmail.com', 25, current_date - 275),
    (294, 'Luisa', 'Lina', 'Cortés', 'Buitrago', '3131717819', 'luisa.cortes@hotmail.com', 7, current_date - 265),
    (295, 'Luisa', 'Daniela', 'López', 'Zapata', '3013934449', 'luisa.lopez@hotmail.com', 9, current_date - 297),
    (296, 'Iván', 'Mateo', 'Vargas', 'Arango', '3506128323', 'ivan.vargas@hotmail.com', 9, current_date - 313),
    (297, 'Viviana', NULL, 'Cifuentes', 'Buitrago', '3002139272', 'viviana.cifuentes@unbosque.edu.co', 27, current_date - 65),
    (298, 'Carlos', 'Felipe', 'Mendoza', 'Rodríguez', '3026781818', 'carlos.mendoza@hotmail.com', 39, current_date - 333),
    (299, 'Andrés', NULL, 'Moreno', 'Restrepo', '3052536549', 'andres.moreno@outlook.com', 40, current_date - 14),
    (300, 'Sara', NULL, 'Mendoza', NULL, '3136027117', 'sara.mendoza@unbosque.edu.co', 29, current_date - 157),
    (301, 'Andrés', NULL, 'Suárez', 'Torres', '3007186136', 'andres.suarez@yahoo.com', 30, current_date - 272),
    (302, 'David', NULL, 'Romero', 'Zapata', '3126118287', 'david.romero@outlook.com', 40, current_date - 514),
    (303, 'Ricardo', NULL, 'Ramírez', NULL, '3016525575', 'ricardo.ramirez@hotmail.com', 30, current_date - 420),
    (304, 'Camila', NULL, 'Zapata', 'Montoya', '3021504899', 'camila.zapata@gmail.com', 39, current_date - 400),
    (305, 'Luisa', 'Andrea', 'Cifuentes', 'Romero', '3008637088', 'luisa.cifuentes@unbosque.edu.co', 38, current_date - 464),
    (306, 'David', 'Kevin', 'Cortés', 'Restrepo', '3154611352', 'david.cortes@yahoo.com', 32, current_date - 462),
    (307, 'Jhonatan', NULL, 'García', 'Castro', '3148454972', 'jhonatan.garcia@hotmail.com', 5, current_date - 220),
    (308, 'Julián', NULL, 'Moreno', NULL, '3127141127', 'julian.moreno@outlook.com', 40, current_date - 367),
    (309, 'Sebastián', 'Jhonatan', 'Vargas', NULL, '3043765267', 'sebastian.vargas@hotmail.com', 38, current_date - 111),
    (310, 'Luisa', NULL, 'Rojas', 'Zapata', '3022594864', 'luisa.rojas@hotmail.com', 47, current_date - 134),
    (311, 'Andrés', 'Miguel', 'Suárez', 'Vargas', '3179648046', 'andres.suarez@gmail.com', 12, current_date - 52),
    (312, 'Diana', 'María', 'Ospina', 'Cifuentes', '3027796148', 'diana.ospina@yahoo.com', 14, current_date - 498),
    (313, 'Iván', 'Brayan', 'Rodríguez', 'Gómez', '3168092589', 'ivan.rodriguez@outlook.com', 45, current_date - 29),
    (314, 'Esteban', 'Samuel', 'Díaz', 'Cárdenas', '3008206850', 'esteban.diaz@yahoo.com', 40, current_date - 320),
    (315, 'Brayan', NULL, 'Valencia', 'Cárdenas', '3059337707', 'brayan.valencia@unbosque.edu.co', 41, current_date - 369),
    (316, 'Santiago', NULL, 'Cifuentes', 'Lozano', '3112692696', 'santiago.cifuentes@gmail.com', 39, current_date - 390),
    (317, 'Daniel', NULL, 'Pérez', NULL, '3104979660', 'daniel.perez@yahoo.com', 42, current_date - 263),
    (318, 'Brayan', 'Tomás', 'Castaño', 'Mendoza', '3015464570', 'brayan.castano@outlook.com', 27, current_date - 377),
    (319, 'Daniela', 'Yuliana', 'González', 'Álvarez', '3184164163', 'daniela.gonzalez@gmail.com', 2, current_date - 518),
    (320, 'Daniela', NULL, 'Cortés', 'López', '3008787761', 'daniela.cortes@outlook.com', 6, current_date - 390),
    (321, 'Isabella', 'Tatiana', 'Mejía', 'Martínez', '3137588087', 'isabella.mejia@unbosque.edu.co', 27, current_date - 411),
    (322, 'Tomás', NULL, 'Ospina', 'Poveda', '3043211059', 'tomas.ospina@outlook.com', 41, current_date - 70),
    (323, 'Santiago', NULL, 'Ramírez', 'Torres', '3044282491', 'santiago.ramirez@unbosque.edu.co', 3, current_date - 349),
    (324, 'Brayan', NULL, 'Arango', 'Castaño', '3016346006', 'brayan.arango@outlook.com', 6, current_date - 215),
    (325, 'Sebastián', NULL, 'Vargas', 'Zapata', '3159671634', 'sebastian.vargas@gmail.com', 16, current_date - 651),
    (326, 'Diego', 'Jhonatan', 'Arango', 'Mendoza', '3153014034', 'diego.arango@gmail.com', 8, current_date - 93),
    (327, 'Óscar', NULL, 'Herrera', 'Suárez', '3236005357', 'oscar.herrera@gmail.com', 43, current_date - 464),
    (328, 'Mariana', 'Lucía', 'Torres', 'Ramírez', '3205263892', 'mariana.torres@hotmail.com', 40, current_date - 529),
    (329, 'Alejandro', NULL, 'Lozano', 'Suárez', '3167851231', 'alejandro.lozano@yahoo.com', 20, current_date - 105),
    (330, 'Gabriela', NULL, 'Sánchez', NULL, '3148364383', 'gabriela.sanchez@hotmail.com', 16, current_date - 430),
    (331, 'Alejandra', NULL, 'Rodríguez', 'Rincón', '3003290527', 'alejandra.rodriguez@unbosque.edu.co', 41, current_date - 430),
    (332, 'Gabriel', NULL, 'Mendoza', 'Sánchez', '3136277438', 'gabriel.mendoza@yahoo.com', 37, current_date - 194),
    (333, 'Ricardo', NULL, 'Martínez', 'Sánchez', '3234139657', 'ricardo.martinez@gmail.com', 36, current_date - 69),
    (334, 'Valentina', NULL, 'Hernández', NULL, '3131487602', 'valentina.hernandez@hotmail.com', 47, current_date - 145),
    (335, 'Juliana', NULL, 'Suárez', 'Romero', '3142488213', 'juliana.suarez@gmail.com', 47, current_date - 474),
    (336, 'Sara', NULL, 'López', NULL, '3218990006', 'sara.lopez@unbosque.edu.co', 11, current_date - 588),
    (337, 'Julián', NULL, 'Rojas', 'Vargas', '3125774454', 'julian.rojas@hotmail.com', 18, current_date - 142),
    (338, 'Lina', NULL, 'Vargas', 'Moreno', '3116413926', 'lina.vargas@hotmail.com', 35, current_date - 525),
    (339, 'Óscar', 'Tomás', 'Lozano', NULL, '3102767206', 'oscar.lozano@hotmail.com', 38, current_date - 272),
    (340, 'Sara', NULL, 'Poveda', NULL, '3006781703', 'sara.poveda@outlook.com', 16, current_date - 519),
    (341, 'Ángela', NULL, 'Martínez', 'Lozano', '3186578289', 'angela.martinez@outlook.com', 5, current_date - 160),
    (342, 'Mateo', 'Iván', 'Cárdenas', 'Ruiz', '3184211870', 'mateo.cardenas@yahoo.com', 38, current_date - 91),
    (343, 'Camilo', 'Héctor', 'Buitrago', NULL, '3057057939', 'camilo.buitrago@unbosque.edu.co', 30, current_date - 320),
    (344, 'Óscar', NULL, 'Hernández', 'López', '3024821091', 'oscar.hernandez@outlook.com', 33, current_date - 206),
    (345, 'Santiago', NULL, 'Ospina', 'Suárez', '3054369852', 'santiago.ospina@outlook.com', 30, current_date - 401),
    (346, 'Andrea', NULL, 'Zapata', 'Restrepo', '3219249446', 'andrea.zapata@gmail.com', 25, current_date - 200),
    (347, 'Isabella', 'Carolina', 'Gutiérrez', 'Castro', '3104929299', 'isabella.gutierrez@yahoo.com', 27, current_date - 209),
    (348, 'Diego', 'Luis', 'Díaz', 'Mejía', '3014997822', 'diego.diaz@outlook.com', 42, current_date - 158),
    (349, 'Carlos', NULL, 'Parra', NULL, '3155713182', 'carlos.parra@hotmail.com', 33, current_date - 167),
    (350, 'Julián', 'David', 'Sánchez', 'Ramírez', '3013712956', 'julian.sanchez@outlook.com', 7, current_date - 418);

-- ---------------------------------------------------------------------
-- INFO_MEDICA (239) - opcional, máximo una por miembro (1:1)
-- ---------------------------------------------------------------------
INSERT INTO info_medica (id_miembro, contacto_emergencia, condicion_medica, tipo_sangre) VALUES
    (1, '3047959456', NULL, 'AB+'),
    (3, '3215550546', 'Tendinitis en hombro derecho', 'A-'),
    (4, '3118657891', NULL, 'A+'),
    (5, '3208407377', NULL, 'O+'),
    (6, '3219890662', NULL, 'B+'),
    (9, '3211948190', NULL, 'B-'),
    (10, '3014710618', NULL, 'O+'),
    (11, '3175199739', NULL, 'O+'),
    (12, '3207842104', NULL, 'A-'),
    (13, '3025811238', 'Escoliosis leve', 'A+'),
    (14, '3103825023', NULL, 'A+'),
    (15, '3138324646', NULL, 'O+'),
    (16, '3501760180', 'Fascitis plantar', 'A+'),
    (21, '3188602647', 'Hipotiroidismo', 'A+'),
    (22, '3508060069', NULL, 'O+'),
    (23, '3119791392', NULL, 'O+'),
    (25, '3109285120', 'Cirugía de LCA hace 1 año', 'O+'),
    (26, '3122331200', NULL, 'A+'),
    (27, '3119835009', NULL, 'B+'),
    (28, '3211618592', 'Hipertensión controlada', 'O+'),
    (29, '3025908753', 'Asma leve', 'O+'),
    (30, '3008458104', 'Embarazo (segundo trimestre)', 'B-'),
    (31, '3107333663', NULL, 'B+'),
    (33, '3146579476', 'Tendinitis en hombro derecho', 'O+'),
    (34, '3233120070', NULL, 'B+'),
    (36, '3106635051', NULL, 'B+'),
    (37, '3057534522', NULL, 'O+'),
    (38, '3185814569', NULL, 'A+'),
    (39, '3152667568', 'Alergia a la penicilina', 'B+'),
    (40, '3007180706', NULL, 'B+'),
    (43, '3116001636', 'Migraña crónica', 'A+'),
    (44, '3136702744', NULL, 'A+'),
    (45, '3218964670', NULL, 'A+'),
    (46, '3043848543', 'Diabetes tipo 2', 'O+'),
    (47, '3509771292', NULL, 'O+'),
    (48, '3238004257', NULL, 'O+'),
    (50, '3118132678', NULL, 'O-'),
    (51, '3178611449', NULL, 'O+'),
    (53, '3163924476', NULL, 'B+'),
    (54, '3234747931', NULL, 'O+'),
    (55, '3172382777', 'Hipertensión controlada', 'B+'),
    (56, '3162591358', 'Fascitis plantar', 'A+'),
    (58, '3121140922', NULL, 'A+'),
    (59, '3186928066', 'Cirugía de LCA hace 1 año', 'A+'),
    (61, '3042021657', NULL, 'O+'),
    (63, '3187930296', NULL, 'A+'),
    (64, '3102793905', NULL, 'O+'),
    (65, '3504659739', 'Tendinitis en hombro derecho', 'A+'),
    (67, '3216103184', NULL, 'A+'),
    (68, '3151274712', NULL, 'O+'),
    (69, '3157535709', NULL, 'O+'),
    (70, '3012211415', 'Fascitis plantar', 'O+'),
    (71, '3506213492', NULL, 'O+'),
    (72, '3003010147', NULL, 'A-'),
    (74, '3508861714', NULL, 'A+'),
    (75, '3042462882', 'Escoliosis leve', 'A+'),
    (77, '3179970916', 'Escoliosis leve', 'O+'),
    (78, '3174156004', NULL, 'A+'),
    (79, '3029150852', NULL, 'O+'),
    (81, '3502978344', NULL, 'O+'),
    (82, '3049927126', 'Lesión de rodilla (menisco) en recuperación', 'B+'),
    (85, '3152346730', NULL, 'A+'),
    (87, '3155720873', NULL, 'A+'),
    (88, '3056887039', NULL, 'B+'),
    (90, '3232715540', 'Lesión de rodilla (menisco) en recuperación', 'O+'),
    (91, '3508437896', NULL, 'O+'),
    (92, '3132829698', 'Hernia discal L4-L5', 'A+'),
    (95, '3012108446', NULL, 'A+'),
    (96, '3127576718', NULL, 'O+'),
    (97, '3023890771', 'Hipotiroidismo', 'A+'),
    (98, '3203586850', NULL, 'O+'),
    (99, '3501794715', NULL, 'O+'),
    (102, '3105955038', 'Esguince de tobillo reciente', 'O+'),
    (103, '3022423437', NULL, 'O+'),
    (104, '3115896461', 'Lesión de rodilla (menisco) en recuperación', 'B+'),
    (105, '3043670444', NULL, 'A+'),
    (106, '3142002382', NULL, 'A+'),
    (107, '3009546963', NULL, 'O+'),
    (109, '3166527616', NULL, 'O+'),
    (111, '3003790513', 'Hipertensión controlada', 'A+'),
    (112, '3041918354', NULL, 'O+'),
    (113, '3054978112', NULL, 'O+'),
    (116, '3236872909', NULL, 'O+'),
    (118, '3183826431', NULL, 'AB-'),
    (119, '3202458848', 'Migraña crónica', 'A-'),
    (120, '3026076350', NULL, 'B+'),
    (121, '3017168051', NULL, 'AB-'),
    (122, '3165056227', 'Arritmia controlada con medicación', 'O+'),
    (125, '3101970077', NULL, 'A-'),
    (126, '3179561172', 'Hipotiroidismo', 'AB+'),
    (127, '3501536358', NULL, 'A-'),
    (128, '3205382794', NULL, 'B+'),
    (129, '3219069554', 'Asma leve', 'B+'),
    (130, '3169591964', 'Diabetes tipo 2', 'O+'),
    (131, '3171413914', NULL, 'O+'),
    (134, '3201146377', NULL, 'A+'),
    (135, '3204007672', NULL, 'O+'),
    (137, '3177095496', NULL, 'B+'),
    (138, '3007849546', 'Arritmia controlada con medicación', 'O+'),
    (140, '3011953624', NULL, 'A-'),
    (141, '3509449537', NULL, 'O+'),
    (142, '3219330805', NULL, 'AB+'),
    (144, '3161138766', NULL, 'A-'),
    (145, '3187091239', NULL, 'A+'),
    (146, '3205003035', NULL, 'O+'),
    (149, '3029081758', 'Hernia discal L4-L5', 'B+'),
    (150, '3206324981', 'Tendinitis en hombro derecho', 'A-'),
    (151, '3021187627', 'Hipertensión controlada', 'O+'),
    (154, '3017994491', 'Diabetes tipo 2', 'O+'),
    (155, '3107206449', NULL, 'O+'),
    (156, '3111631129', NULL, 'O+'),
    (158, '3235979311', NULL, 'A+'),
    (160, '3237604242', NULL, 'O+'),
    (161, '3052507873', 'Escoliosis leve', 'AB-'),
    (162, '3231208752', NULL, 'O+'),
    (164, '3138928792', NULL, 'O-'),
    (165, '3508678019', NULL, 'O+'),
    (166, '3213666222', NULL, 'A+'),
    (167, '3509113221', NULL, 'O+'),
    (171, '3007905550', NULL, 'A+'),
    (172, '3187793209', 'Hipotiroidismo', 'B+'),
    (174, '3215529795', 'Arritmia controlada con medicación', 'AB+'),
    (175, '3018367149', NULL, 'A+'),
    (176, '3112516418', NULL, 'B+'),
    (177, '3051590263', NULL, 'B+'),
    (180, '3041035843', 'Migraña crónica', 'B+'),
    (181, '3134864634', NULL, 'O+'),
    (182, '3116393988', NULL, 'A+'),
    (183, '3049784126', NULL, 'O+'),
    (186, '3505769617', NULL, 'O-'),
    (187, '3188336796', NULL, 'AB+'),
    (188, '3183586765', 'Asma leve', 'B+'),
    (190, '3009627590', NULL, 'A+'),
    (192, '3237519000', 'Alergia a la penicilina', 'A+'),
    (195, '3161498545', 'Arritmia controlada con medicación', 'O+'),
    (199, '3214392841', NULL, 'O+'),
    (200, '3124756211', NULL, 'O+'),
    (201, '3008326478', 'Hernia discal L4-L5', 'A+'),
    (202, '3239085848', 'Esguince de tobillo reciente', 'B+'),
    (204, '3219869494', 'Arritmia controlada con medicación', 'O+'),
    (205, '3233978783', NULL, 'B+'),
    (208, '3208324120', 'Cirugía de LCA hace 1 año', 'AB+'),
    (209, '3001180466', NULL, 'A+'),
    (211, '3236082425', NULL, 'A+'),
    (212, '3018608134', NULL, 'O+'),
    (213, '3017222096', 'Esguince de tobillo reciente', 'O+'),
    (214, '3149714251', 'Fascitis plantar', 'O+'),
    (218, '3019875581', NULL, 'O+'),
    (219, '3203875281', 'Arritmia controlada con medicación', 'B-'),
    (220, '3152476043', 'Tendinitis en hombro derecho', 'O+'),
    (221, '3206010064', NULL, 'O+'),
    (222, '3025974980', NULL, 'O+'),
    (223, '3501946188', 'Hernia discal L4-L5', 'B-'),
    (224, '3237210867', 'Arritmia controlada con medicación', 'A+'),
    (225, '3161833785', NULL, 'O+'),
    (226, '3005118686', NULL, 'O+'),
    (227, '3042619971', NULL, 'A+'),
    (232, '3204689902', NULL, 'O-'),
    (233, '3131751748', NULL, 'B+'),
    (235, '3006137471', 'Fascitis plantar', 'AB+'),
    (237, '3104804488', NULL, 'O+'),
    (239, '3239068666', NULL, 'A+'),
    (240, '3507827580', NULL, 'AB+'),
    (241, '3181741576', NULL, 'A+'),
    (242, '3503905683', NULL, 'O-'),
    (243, '3001209250', NULL, 'A-'),
    (244, '3214166498', NULL, 'O+'),
    (245, '3102163436', 'Fascitis plantar', 'B+'),
    (247, '3028837215', NULL, 'B+'),
    (248, '3121134191', NULL, 'O+'),
    (249, '3218510825', 'Migraña crónica', 'B+'),
    (251, '3108153329', NULL, 'B+'),
    (252, '3027832302', 'Asma leve', 'A+'),
    (253, '3209782091', 'Alergia a la penicilina', 'B-'),
    (254, '3133662488', NULL, 'B+'),
    (256, '3506332755', NULL, 'B+'),
    (257, '3057912403', 'Escoliosis leve', 'B-'),
    (258, '3217058069', 'Arritmia controlada con medicación', 'O+'),
    (259, '3182773661', NULL, 'AB-'),
    (260, '3016485633', NULL, 'O+'),
    (262, '3101627268', NULL, 'O+'),
    (263, '3129916571', 'Diabetes tipo 2', 'AB+'),
    (264, '3207631436', 'Lesión de rodilla (menisco) en recuperación', 'B+'),
    (265, '3028201757', NULL, 'O+'),
    (266, '3025392749', NULL, 'O-'),
    (267, '3171563718', NULL, 'A-'),
    (270, '3124175561', 'Asma leve', 'O+'),
    (271, '3508537194', NULL, 'O+'),
    (273, '3102855920', NULL, 'O+'),
    (274, '3125334462', 'Alergia a la penicilina', 'A+'),
    (276, '3013109286', NULL, 'A+'),
    (278, '3002277020', 'Diabetes tipo 2', 'O+'),
    (279, '3029274662', 'Hernia discal L4-L5', 'AB-'),
    (280, '3007095823', 'Fascitis plantar', 'O+'),
    (282, '3205513696', 'Diabetes tipo 2', 'AB-'),
    (283, '3008206275', NULL, 'O+'),
    (284, '3128116167', 'Alergia a la penicilina', 'O+'),
    (285, '3218318979', NULL, 'A+'),
    (286, '3108041152', 'Arritmia controlada con medicación', 'O+'),
    (289, '3209311988', 'Alergia a la penicilina', 'A+'),
    (291, '3146105208', NULL, 'A+'),
    (292, '3168490149', 'Asma leve', 'O-'),
    (294, '3168812292', NULL, 'B-'),
    (297, '3055155964', NULL, 'B+'),
    (298, '3206527958', 'Asma leve', 'O+'),
    (299, '3148371842', NULL, 'AB-'),
    (300, '3114093524', NULL, 'O+'),
    (301, '3116565097', 'Embarazo (segundo trimestre)', 'O+'),
    (302, '3178752150', NULL, 'O+'),
    (303, '3122381240', NULL, 'O+'),
    (307, '3507261400', 'Fascitis plantar', 'O+'),
    (309, '3124026100', NULL, 'A+'),
    (311, '3006586760', NULL, 'O+'),
    (312, '3009190166', NULL, 'A+'),
    (313, '3232430329', NULL, 'A+'),
    (314, '3021177739', NULL, 'O+'),
    (315, '3209150807', 'Esguince de tobillo reciente', 'B+'),
    (317, '3178376541', NULL, 'O+'),
    (318, '3118543283', 'Cirugía de LCA hace 1 año', 'O+'),
    (320, '3144302687', NULL, 'O+'),
    (321, '3214706388', NULL, 'O+'),
    (322, '3105621879', NULL, 'A+'),
    (324, '3168834132', 'Cirugía de LCA hace 1 año', 'A+'),
    (325, '3507525887', 'Tendinitis en hombro derecho', 'O+'),
    (327, '3503982464', NULL, 'O+'),
    (328, '3172378457', 'Escoliosis leve', 'O+'),
    (329, '3151637985', NULL, 'A+'),
    (330, '3146993112', 'Cirugía de LCA hace 1 año', 'AB-'),
    (331, '3103943547', NULL, 'O+'),
    (333, '3147063211', 'Tendinitis en hombro derecho', 'A+'),
    (334, '3001947507', 'Esguince de tobillo reciente', 'A+'),
    (335, '3183701820', NULL, 'A+'),
    (338, '3159358826', NULL, 'O-'),
    (341, '3124860556', NULL, 'O-'),
    (343, '3216751935', NULL, 'O+'),
    (345, '3186279978', NULL, 'O+'),
    (347, '3504493372', 'Arritmia controlada con medicación', 'AB+'),
    (348, '3218999323', 'Esguince de tobillo reciente', 'O+'),
    (350, '3173896242', NULL, 'O+');

-- ---------------------------------------------------------------------
-- MEMBRESIA (847) - historial por miembro, máximo UNA activa
-- ---------------------------------------------------------------------
INSERT INTO membresia (id_membresia, id_miembro, id_tipo_plan, estado, fecha_inicio, fecha_fin) VALUES
    -- miembro 7 Alejandro Valencia: 2 membresía(s), 1 activa
    (1, 7, 1, 'VENCIDA', current_date - 171, (current_date - 171 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (2, 7, 3, 'ACTIVA', current_date - 137, (current_date - 137 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 8 Esteban López: 2 membresía(s), 1 activa
    (3, 8, 1, 'VENCIDA', current_date - 319, (current_date - 319 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (4, 8, 3, 'ACTIVA', current_date - 284, (current_date - 284 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 9 Paola Parra: 2 membresía(s), ninguna activa
    (5, 9, 2, 'VENCIDA', current_date - 484, (current_date - 484 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (6, 9, 3, 'VENCIDA', current_date - 389, (current_date - 389 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 10 Fernando Álvarez: 1 membresía(s), 1 activa
    (7, 10, 3, 'ACTIVA', current_date - 354, (current_date - 354 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 11 Isabella Cárdenas: 2 membresía(s), 1 activa
    (8, 11, 2, 'VENCIDA', current_date - 343, (current_date - 343 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (9, 11, 3, 'ACTIVA', current_date - 246, (current_date - 246 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 12 Lucía Rodríguez: 1 membresía(s), 1 activa
    (10, 12, 2, 'ACTIVA', current_date - 8, (current_date - 8 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 13 Esteban Hernández: 3 membresía(s), ninguna activa
    (11, 13, 1, 'VENCIDA', current_date - 264, (current_date - 264 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (12, 13, 1, 'VENCIDA', current_date - 233, (current_date - 233 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (13, 13, 2, 'VENCIDA', current_date - 95, (current_date - 95 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 14 Mariana Buitrago: 1 membresía(s), 1 activa
    (14, 14, 3, 'ACTIVA', current_date - 280, (current_date - 280 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 15 Isabella Cortés: 1 membresía(s), 1 activa
    (15, 15, 3, 'ACTIVA', current_date - 325, (current_date - 325 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 16 Paula Lozano: 6 membresía(s), 1 activa
    (16, 16, 2, 'VENCIDA', current_date - 458, (current_date - 458 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (17, 16, 1, 'VENCIDA', current_date - 365, (current_date - 365 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (18, 16, 2, 'VENCIDA', current_date - 333, (current_date - 333 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (19, 16, 1, 'VENCIDA', current_date - 240, (current_date - 240 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (20, 16, 1, 'VENCIDA', current_date - 203, (current_date - 203 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (21, 16, 3, 'ACTIVA', current_date - 170, (current_date - 170 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 17 Santiago Gutiérrez: 4 membresía(s), 1 activa
    (22, 17, 1, 'VENCIDA', current_date - 293, (current_date - 293 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (23, 17, 2, 'VENCIDA', current_date - 262, (current_date - 262 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (24, 17, 1, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (25, 17, 2, 'ACTIVA', current_date - 20, (current_date - 20 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 18 David Montoya: 2 membresía(s), 1 activa
    (26, 18, 3, 'VENCIDA', current_date - 504, (current_date - 504 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (27, 18, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 19 Nicolás Ospina: 2 membresía(s), 1 activa
    (28, 19, 3, 'VENCIDA', current_date - 495, (current_date - 495 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (29, 19, 3, 'ACTIVA', current_date - 126, (current_date - 126 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 20 Iván Castro: 1 membresía(s), 1 activa
    (30, 20, 1, 'ACTIVA', current_date - 8, (current_date - 8 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 21 Mauricio Muñoz: 3 membresía(s), 1 activa
    (31, 21, 1, 'VENCIDA', current_date - 170, (current_date - 170 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (32, 21, 1, 'VENCIDA', current_date - 61, (current_date - 61 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (33, 21, 1, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 22 Yuliana Castaño: 2 membresía(s), 1 activa
    (34, 22, 2, 'VENCIDA', current_date - 143, (current_date - 143 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (35, 22, 2, 'ACTIVA', current_date - 8, (current_date - 8 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 23 Luisa Montoya: 2 membresía(s), 1 activa
    (36, 23, 3, 'VENCIDA', current_date - 435, (current_date - 435 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (37, 23, 3, 'ACTIVA', current_date - 20, (current_date - 20 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 24 Daniela Romero: 4 membresía(s), 1 activa
    (38, 24, 1, 'VENCIDA', current_date - 218, (current_date - 218 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (39, 24, 1, 'VENCIDA', current_date - 182, (current_date - 182 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (40, 24, 2, 'VENCIDA', current_date - 149, (current_date - 149 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (41, 24, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 25 Isabella Becerra: 1 membresía(s), 1 activa
    (42, 25, 2, 'ACTIVA', current_date - 47, (current_date - 47 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 26 Andrés Mejía: 2 membresía(s), 1 activa
    (43, 26, 1, 'VENCIDA', current_date - 155, (current_date - 155 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (44, 26, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 27 Esteban Ortiz: 1 membresía(s), 1 activa
    (45, 27, 2, 'ACTIVA', current_date - 47, (current_date - 47 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 28 Paola Mejía: 3 membresía(s), 1 activa
    (46, 28, 1, 'VENCIDA', current_date - 191, (current_date - 191 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (47, 28, 2, 'VENCIDA', current_date - 160, (current_date - 160 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (48, 28, 2, 'ACTIVA', current_date - 68, (current_date - 68 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 29 Tomás Peña: 2 membresía(s), 1 activa
    (49, 29, 2, 'VENCIDA', current_date - 410, (current_date - 410 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (50, 29, 3, 'ACTIVA', current_date - 312, (current_date - 312 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 30 Natalia Valencia: 2 membresía(s), ninguna activa
    (51, 30, 1, 'VENCIDA', current_date - 409, (current_date - 409 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (52, 30, 3, 'VENCIDA', current_date - 375, (current_date - 375 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 31 Felipe Álvarez: 3 membresía(s), 1 activa
    (53, 31, 1, 'VENCIDA', current_date - 170, (current_date - 170 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (54, 31, 2, 'VENCIDA', current_date - 133, (current_date - 133 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (55, 31, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 32 David Acosta: 2 membresía(s), 1 activa
    (56, 32, 1, 'VENCIDA', current_date - 45, (current_date - 45 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (57, 32, 3, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 33 Iván González: 5 membresía(s), 1 activa
    (58, 33, 1, 'VENCIDA', current_date - 509, (current_date - 509 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (59, 33, 1, 'VENCIDA', current_date - 478, (current_date - 478 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (60, 33, 1, 'VENCIDA', current_date - 442, (current_date - 442 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (61, 33, 3, 'VENCIDA', current_date - 410, (current_date - 410 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (62, 33, 3, 'ACTIVA', current_date, (current_date + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 34 Marcela Cifuentes: 1 membresía(s), 1 activa
    (63, 34, 2, 'ACTIVA', current_date - 52, (current_date - 52 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 35 Héctor Peña: 5 membresía(s), 1 activa
    (64, 35, 1, 'VENCIDA', current_date - 197, (current_date - 197 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (65, 35, 1, 'VENCIDA', current_date - 163, (current_date - 163 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (66, 35, 2, 'VENCIDA', current_date - 128, (current_date - 128 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (67, 35, 1, 'VENCIDA', current_date - 32, (current_date - 32 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (68, 35, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 36 Mauricio Rodríguez: 2 membresía(s), 1 activa
    (69, 36, 1, 'VENCIDA', current_date - 120, (current_date - 120 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (70, 36, 3, 'ACTIVA', current_date - 85, (current_date - 85 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 37 Camilo García: 2 membresía(s), 1 activa
    (71, 37, 2, 'VENCIDA', current_date - 144, (current_date - 144 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (72, 37, 2, 'ACTIVA', current_date - 49, (current_date - 49 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 38 Daniela Londoño: 1 membresía(s), 1 activa
    (73, 38, 1, 'ACTIVA', current_date - 13, (current_date - 13 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 39 Natalia Herrera: 4 membresía(s), 1 activa
    (74, 39, 1, 'VENCIDA', current_date - 245, (current_date - 245 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (75, 39, 1, 'VENCIDA', current_date - 209, (current_date - 209 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (76, 39, 1, 'VENCIDA', current_date - 175, (current_date - 175 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (77, 39, 3, 'ACTIVA', current_date - 142, (current_date - 142 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 40 Sofía Arango: 2 membresía(s), 1 activa
    (78, 40, 3, 'VENCIDA', current_date - 444, (current_date - 444 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (79, 40, 2, 'ACTIVA', current_date - 75, (current_date - 75 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 41 Daniela Zapata: 2 membresía(s), 1 activa
    (80, 41, 2, 'VENCIDA', current_date - 146, (current_date - 146 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (81, 41, 2, 'ACTIVA', current_date - 48, (current_date - 48 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 42 Samuel Torres: 3 membresía(s), 1 activa
    (82, 42, 2, 'VENCIDA', current_date - 146, (current_date - 146 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (83, 42, 1, 'VENCIDA', current_date - 51, (current_date - 51 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (84, 42, 3, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 43 Yuliana Pérez: 2 membresía(s), ninguna activa
    (85, 43, 1, 'VENCIDA', current_date - 235, (current_date - 235 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (86, 43, 2, 'VENCIDA', current_date - 200, (current_date - 200 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 44 Ángela García: 4 membresía(s), 1 activa
    (87, 44, 1, 'VENCIDA', current_date - 277, (current_date - 277 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (88, 44, 1, 'VENCIDA', current_date - 245, (current_date - 245 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (89, 44, 1, 'VENCIDA', current_date - 214, (current_date - 214 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (90, 44, 3, 'ACTIVA', current_date - 39, (current_date - 39 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 45 Juliana Rincón: 2 membresía(s), 1 activa
    (91, 45, 2, 'VENCIDA', current_date - 424, (current_date - 424 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (92, 45, 3, 'ACTIVA', current_date - 328, (current_date - 328 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 46 Juliana Peña: 1 membresía(s), 1 activa
    (93, 46, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 47 Ricardo Arango: 2 membresía(s), 1 activa
    (94, 47, 2, 'VENCIDA', current_date - 368, (current_date - 368 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (95, 47, 3, 'ACTIVA', current_date - 275, (current_date - 275 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 48 Sofía Londoño: 2 membresía(s), 1 activa
    (96, 48, 1, 'VENCIDA', current_date - 368, (current_date - 368 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (97, 48, 3, 'ACTIVA', current_date - 332, (current_date - 332 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 49 Mateo García: 3 membresía(s), 1 activa
    (98, 49, 2, 'VENCIDA', current_date - 310, (current_date - 310 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (99, 49, 2, 'VENCIDA', current_date - 217, (current_date - 217 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (100, 49, 3, 'ACTIVA', current_date - 122, (current_date - 122 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 50 Carlos Suárez: 4 membresía(s), ninguna activa
    (101, 50, 1, 'VENCIDA', current_date - 519, (current_date - 519 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (102, 50, 1, 'VENCIDA', current_date - 487, (current_date - 487 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (103, 50, 1, 'VENCIDA', current_date - 454, (current_date - 454 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (104, 50, 2, 'VENCIDA', current_date - 339, (current_date - 339 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 51 Nicolás Quintero: 8 membresía(s), 1 activa
    (105, 51, 1, 'VENCIDA', current_date - 409, (current_date - 409 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (106, 51, 1, 'VENCIDA', current_date - 373, (current_date - 373 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (107, 51, 1, 'VENCIDA', current_date - 272, (current_date - 272 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (108, 51, 1, 'VENCIDA', current_date - 236, (current_date - 236 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (109, 51, 1, 'VENCIDA', current_date - 203, (current_date - 203 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (110, 51, 2, 'VENCIDA', current_date - 172, (current_date - 172 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (111, 51, 1, 'VENCIDA', current_date - 74, (current_date - 74 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (112, 51, 3, 'ACTIVA', current_date - 38, (current_date - 38 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 52 Nicolás López: 1 membresía(s), 1 activa
    (113, 52, 3, 'ACTIVA', current_date - 85, (current_date - 85 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 53 Viviana Mejía: 1 membresía(s), 1 activa
    (114, 53, 1, 'ACTIVA', current_date - 24, (current_date - 24 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 54 Iván Cárdenas: 3 membresía(s), 1 activa
    (115, 54, 1, 'VENCIDA', current_date - 489, (current_date - 489 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (116, 54, 3, 'VENCIDA', current_date - 452, (current_date - 452 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (117, 54, 3, 'ACTIVA', current_date - 82, (current_date - 82 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 55 Isabella Buitrago: 2 membresía(s), ninguna activa
    (118, 55, 2, 'VENCIDA', current_date - 399, (current_date - 399 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (119, 55, 2, 'VENCIDA', current_date - 306, (current_date - 306 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 56 Nicolás Londoño: 4 membresía(s), 1 activa
    (120, 56, 2, 'VENCIDA', current_date - 379, (current_date - 379 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (121, 56, 2, 'VENCIDA', current_date - 188, (current_date - 188 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (122, 56, 1, 'VENCIDA', current_date - 93, (current_date - 93 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (123, 56, 2, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 57 Alejandra Cárdenas: 1 membresía(s), 1 activa
    (124, 57, 1, 'ACTIVA', current_date - 6, (current_date - 6 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 58 Diego Londoño: 3 membresía(s), 1 activa
    (125, 58, 2, 'VENCIDA', current_date - 282, (current_date - 282 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (126, 58, 2, 'VENCIDA', current_date - 189, (current_date - 189 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (127, 58, 2, 'ACTIVA', current_date - 9, (current_date - 9 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 59 Mariana Mejía: 2 membresía(s), 1 activa
    (128, 59, 2, 'VENCIDA', current_date - 188, (current_date - 188 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (129, 59, 3, 'ACTIVA', current_date - 90, (current_date - 90 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 60 Tatiana Rojas: 4 membresía(s), 1 activa
    (130, 60, 1, 'VENCIDA', current_date - 447, (current_date - 447 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (131, 60, 1, 'VENCIDA', current_date - 395, (current_date - 395 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (132, 60, 1, 'VENCIDA', current_date - 261, (current_date - 261 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (133, 60, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 61 Viviana Díaz: 1 membresía(s), 1 activa
    (134, 61, 2, 'ACTIVA', current_date - 18, (current_date - 18 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 62 Diego Suárez: 2 membresía(s), 1 activa
    (135, 62, 1, 'VENCIDA', current_date - 105, (current_date - 105 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (136, 62, 1, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 63 Isabella Cárdenas: 2 membresía(s), 1 activa
    (137, 63, 3, 'VENCIDA', current_date - 455, (current_date - 455 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (138, 63, 3, 'ACTIVA', current_date - 78, (current_date - 78 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 64 Jorge Gómez: 4 membresía(s), 1 activa
    (139, 64, 2, 'VENCIDA', current_date - 519, (current_date - 519 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (140, 64, 1, 'VENCIDA', current_date - 427, (current_date - 427 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (141, 64, 2, 'VENCIDA', current_date - 394, (current_date - 394 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (142, 64, 3, 'ACTIVA', current_date - 173, (current_date - 173 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 65 Diego Jiménez: 3 membresía(s), 1 activa
    (143, 65, 2, 'VENCIDA', current_date - 134, (current_date - 134 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (144, 65, 1, 'VENCIDA', current_date - 42, (current_date - 42 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (145, 65, 1, 'ACTIVA', current_date - 5, (current_date - 5 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 66 Marcela Castro: 4 membresía(s), ninguna activa
    (146, 66, 1, 'VENCIDA', current_date - 248, (current_date - 248 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (147, 66, 1, 'VENCIDA', current_date - 211, (current_date - 211 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (148, 66, 1, 'VENCIDA', current_date - 177, (current_date - 177 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (149, 66, 2, 'VENCIDA', current_date - 142, (current_date - 142 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 67 Lucía Herrera: 2 membresía(s), 1 activa
    (150, 67, 3, 'VENCIDA', current_date - 452, (current_date - 452 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (151, 67, 3, 'ACTIVA', current_date - 86, (current_date - 86 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 68 Iván Restrepo: 2 membresía(s), 1 activa
    (152, 68, 2, 'VENCIDA', current_date - 300, (current_date - 300 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (153, 68, 3, 'ACTIVA', current_date - 208, (current_date - 208 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 69 Camilo Vargas: 1 membresía(s), 1 activa
    (154, 69, 3, 'ACTIVA', current_date - 236, (current_date - 236 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 70 Juliana Ruiz: 2 membresía(s), ninguna activa
    (155, 70, 3, 'VENCIDA', current_date - 540, (current_date - 540 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (156, 70, 2, 'VENCIDA', current_date - 173, (current_date - 173 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 71 Brayan Cortés: 2 membresía(s), 1 activa
    (157, 71, 1, 'VENCIDA', current_date - 102, (current_date - 102 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (158, 71, 3, 'ACTIVA', current_date - 71, (current_date - 71 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 72 Alejandra Muñoz: 1 membresía(s), 1 activa
    (159, 72, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 73 Jorge Herrera: 3 membresía(s), 1 activa
    (160, 73, 2, 'VENCIDA', current_date - 330, (current_date - 330 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (161, 73, 2, 'VENCIDA', current_date - 232, (current_date - 232 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (162, 73, 3, 'ACTIVA', current_date - 119, (current_date - 119 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 74 Jorge Acosta: 3 membresía(s), 1 activa
    (163, 74, 3, 'VENCIDA', current_date - 534, (current_date - 534 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (164, 74, 2, 'VENCIDA', current_date - 114, (current_date - 114 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (165, 74, 3, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 75 Santiago Hernández: 3 membresía(s), 1 activa
    (166, 75, 2, 'VENCIDA', current_date - 469, (current_date - 469 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (167, 75, 1, 'VENCIDA', current_date - 376, (current_date - 376 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (168, 75, 3, 'ACTIVA', current_date - 286, (current_date - 286 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 76 Mateo Suárez: 5 membresía(s), ninguna activa
    (169, 76, 1, 'VENCIDA', current_date - 284, (current_date - 284 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (170, 76, 1, 'VENCIDA', current_date - 253, (current_date - 253 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (171, 76, 1, 'VENCIDA', current_date - 192, (current_date - 192 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (172, 76, 1, 'VENCIDA', current_date - 160, (current_date - 160 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (173, 76, 1, 'VENCIDA', current_date - 126, (current_date - 126 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 77 Catalina Londoño: 1 membresía(s), 1 activa
    (174, 77, 3, 'ACTIVA', current_date - 347, (current_date - 347 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 78 Alejandro Lozano: 4 membresía(s), 1 activa
    (175, 78, 1, 'VENCIDA', current_date - 471, (current_date - 471 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (176, 78, 2, 'VENCIDA', current_date - 435, (current_date - 435 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (177, 78, 1, 'VENCIDA', current_date - 342, (current_date - 342 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (178, 78, 3, 'ACTIVA', current_date - 226, (current_date - 226 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 79 Isabella Pérez: 4 membresía(s), 1 activa
    (179, 79, 1, 'VENCIDA', current_date - 265, (current_date - 265 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (180, 79, 1, 'VENCIDA', current_date - 120, (current_date - 120 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (181, 79, 1, 'VENCIDA', current_date - 79, (current_date - 79 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (182, 79, 2, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 80 Miguel Muñoz: 2 membresía(s), 1 activa
    (183, 80, 1, 'VENCIDA', current_date - 31, (current_date - 31 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (184, 80, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 81 Lucía Restrepo: 1 membresía(s), 1 activa
    (185, 81, 3, 'ACTIVA', current_date - 239, (current_date - 239 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 82 Felipe Álvarez: 2 membresía(s), 1 activa
    (186, 82, 2, 'VENCIDA', current_date - 141, (current_date - 141 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (187, 82, 3, 'ACTIVA', current_date - 47, (current_date - 47 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 83 Samuel González: 3 membresía(s), 1 activa
    (188, 83, 2, 'VENCIDA', current_date - 231, (current_date - 231 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (189, 83, 1, 'VENCIDA', current_date - 112, (current_date - 112 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (190, 83, 3, 'ACTIVA', current_date - 81, (current_date - 81 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 84 Lina Arango: 2 membresía(s), 1 activa
    (191, 84, 2, 'VENCIDA', current_date - 125, (current_date - 125 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (192, 84, 2, 'ACTIVA', current_date - 21, (current_date - 21 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 85 Óscar Muñoz: 2 membresía(s), 1 activa
    (193, 85, 2, 'VENCIDA', current_date - 182, (current_date - 182 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (194, 85, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 86 Brayan Castro: 1 membresía(s), ninguna activa
    (195, 86, 2, 'VENCIDA', current_date - 305, (current_date - 305 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 87 María Becerra: 2 membresía(s), 1 activa
    (196, 87, 3, 'VENCIDA', current_date - 497, (current_date - 497 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (197, 87, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 88 Laura Castaño: 3 membresía(s), 1 activa
    (198, 88, 1, 'VENCIDA', current_date - 172, (current_date - 172 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (199, 88, 2, 'VENCIDA', current_date - 135, (current_date - 135 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (200, 88, 2, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 89 Jorge Lozano: 2 membresía(s), 1 activa
    (201, 89, 1, 'VENCIDA', current_date - 51, (current_date - 51 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (202, 89, 3, 'ACTIVA', current_date - 18, (current_date - 18 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 90 Juan Arango: 4 membresía(s), 1 activa
    (203, 90, 1, 'VENCIDA', current_date - 445, (current_date - 445 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (204, 90, 2, 'VENCIDA', current_date - 410, (current_date - 410 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (205, 90, 2, 'VENCIDA', current_date - 278, (current_date - 278 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (206, 90, 3, 'ACTIVA', current_date - 186, (current_date - 186 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 91 Andrea Cifuentes: 4 membresía(s), 1 activa
    (207, 91, 2, 'VENCIDA', current_date - 246, (current_date - 246 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (208, 91, 1, 'VENCIDA', current_date - 151, (current_date - 151 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (209, 91, 1, 'VENCIDA', current_date - 119, (current_date - 119 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (210, 91, 1, 'ACTIVA', current_date - 10, (current_date - 10 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 92 Tomás Muñoz: 3 membresía(s), 1 activa
    (211, 92, 2, 'VENCIDA', current_date - 150, (current_date - 150 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (212, 92, 1, 'VENCIDA', current_date - 53, (current_date - 53 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (213, 92, 3, 'ACTIVA', current_date - 18, (current_date - 18 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 93 Alejandra Cifuentes: 3 membresía(s), 1 activa
    (214, 93, 3, 'VENCIDA', current_date - 418, (current_date - 418 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (215, 93, 1, 'VENCIDA', current_date - 49, (current_date - 49 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (216, 93, 2, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 94 Diana Salazar: 6 membresía(s), 1 activa
    (217, 94, 1, 'VENCIDA', current_date - 237, (current_date - 237 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (218, 94, 1, 'VENCIDA', current_date - 178, (current_date - 178 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (219, 94, 1, 'VENCIDA', current_date - 147, (current_date - 147 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (220, 94, 1, 'VENCIDA', current_date - 114, (current_date - 114 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (221, 94, 1, 'VENCIDA', current_date - 77, (current_date - 77 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (222, 94, 2, 'ACTIVA', current_date - 43, (current_date - 43 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 95 David Poveda: 4 membresía(s), 1 activa
    (223, 95, 1, 'VENCIDA', current_date - 353, (current_date - 353 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (224, 95, 2, 'VENCIDA', current_date - 295, (current_date - 295 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (225, 95, 2, 'VENCIDA', current_date - 200, (current_date - 200 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (226, 95, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 96 María Hernández: 2 membresía(s), 1 activa
    (227, 96, 1, 'VENCIDA', current_date - 51, (current_date - 51 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (228, 96, 2, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 97 Carolina Ruiz: 2 membresía(s), 1 activa
    (229, 97, 2, 'VENCIDA', current_date - 310, (current_date - 310 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (230, 97, 3, 'ACTIVA', current_date - 212, (current_date - 212 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 98 Ricardo Pérez: 2 membresía(s), 1 activa
    (231, 98, 3, 'VENCIDA', current_date - 432, (current_date - 432 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (232, 98, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 99 Óscar Sánchez: 2 membresía(s), ninguna activa
    (233, 99, 3, 'VENCIDA', current_date - 539, (current_date - 539 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (234, 99, 1, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 100 Mauricio Restrepo: 3 membresía(s), 1 activa
    (235, 100, 2, 'VENCIDA', current_date - 476, (current_date - 476 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (236, 100, 2, 'VENCIDA', current_date - 379, (current_date - 379 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (237, 100, 3, 'ACTIVA', current_date - 142, (current_date - 142 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 101 Brayan Acosta: 1 membresía(s), ninguna activa
    (238, 101, 1, 'VENCIDA', current_date - 346, (current_date - 346 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 102 María Zapata: 1 membresía(s), 1 activa
    (239, 102, 3, 'ACTIVA', current_date - 19, (current_date - 19 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 103 Iván Montoya: 2 membresía(s), 1 activa
    (240, 103, 2, 'VENCIDA', current_date - 231, (current_date - 231 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (241, 103, 3, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 104 Esteban Gómez: 1 membresía(s), 1 activa
    (242, 104, 3, 'ACTIVA', current_date - 306, (current_date - 306 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 105 Marcela Zapata: 1 membresía(s), ninguna activa
    (243, 105, 1, 'VENCIDA', current_date - 263, (current_date - 263 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 106 Luis Peña: 1 membresía(s), 1 activa
    (244, 106, 3, 'ACTIVA', current_date - 16, (current_date - 16 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 107 Paola Restrepo: 1 membresía(s), ninguna activa
    (245, 107, 3, 'VENCIDA', current_date - 435, (current_date - 435 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 108 Luis Buitrago: 1 membresía(s), 1 activa
    (246, 108, 3, 'ACTIVA', current_date - 48, (current_date - 48 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 109 Daniela Rojas: 2 membresía(s), 1 activa
    (247, 109, 3, 'VENCIDA', current_date - 419, (current_date - 419 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (248, 109, 3, 'ACTIVA', current_date - 53, (current_date - 53 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 110 Brayan Ortiz: 3 membresía(s), 1 activa
    (249, 110, 2, 'VENCIDA', current_date - 181, (current_date - 181 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (250, 110, 1, 'VENCIDA', current_date - 87, (current_date - 87 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (251, 110, 2, 'ACTIVA', current_date - 54, (current_date - 54 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 111 Jhonatan Gómez: 1 membresía(s), 1 activa
    (252, 111, 3, 'ACTIVA', current_date - 134, (current_date - 134 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 112 Daniel Castaño: 3 membresía(s), 1 activa
    (253, 112, 1, 'VENCIDA', current_date - 284, (current_date - 284 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (254, 112, 1, 'VENCIDA', current_date - 250, (current_date - 250 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (255, 112, 3, 'ACTIVA', current_date - 216, (current_date - 216 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 113 Tomás García: 2 membresía(s), ninguna activa
    (256, 113, 1, 'VENCIDA', current_date - 213, (current_date - 213 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (257, 113, 1, 'VENCIDA', current_date - 142, (current_date - 142 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 114 Daniela Gómez: 1 membresía(s), ninguna activa
    (258, 114, 3, 'VENCIDA', current_date - 419, (current_date - 419 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 115 Gabriel Rincón: 2 membresía(s), 1 activa
    (259, 115, 2, 'VENCIDA', current_date - 171, (current_date - 171 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (260, 115, 3, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 116 Viviana Álvarez: 4 membresía(s), 1 activa
    (261, 116, 3, 'VENCIDA', current_date - 473, (current_date - 473 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (262, 116, 1, 'VENCIDA', current_date - 101, (current_date - 101 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (263, 116, 1, 'VENCIDA', current_date - 35, (current_date - 35 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (264, 116, 1, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 117 Mateo Castro: 4 membresía(s), 1 activa
    (265, 117, 2, 'VENCIDA', current_date - 288, (current_date - 288 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (266, 117, 1, 'VENCIDA', current_date - 124, (current_date - 124 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (267, 117, 1, 'VENCIDA', current_date - 87, (current_date - 87 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (268, 117, 1, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 118 Camilo Buitrago: 1 membresía(s), 1 activa
    (269, 118, 2, 'ACTIVA', current_date - 72, (current_date - 72 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 119 Marcela Torres: 1 membresía(s), 1 activa
    (270, 119, 3, 'ACTIVA', current_date - 313, (current_date - 313 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 120 Ángela Herrera: 3 membresía(s), ninguna activa
    (271, 120, 1, 'VENCIDA', current_date - 226, (current_date - 226 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (272, 120, 2, 'VENCIDA', current_date - 175, (current_date - 175 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (273, 120, 1, 'VENCIDA', current_date - 81, (current_date - 81 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 121 Daniel Buitrago: 1 membresía(s), ninguna activa
    (274, 121, 3, 'VENCIDA', current_date - 400, (current_date - 400 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 122 Iván Romero: 1 membresía(s), ninguna activa
    (275, 122, 1, 'VENCIDA', current_date - 479, (current_date - 479 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 123 Natalia Rodríguez: 1 membresía(s), 1 activa
    (276, 123, 1, 'ACTIVA', current_date - 13, (current_date - 13 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 124 Lina Castaño: 4 membresía(s), 1 activa
    (277, 124, 2, 'VENCIDA', current_date - 474, (current_date - 474 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (278, 124, 2, 'VENCIDA', current_date - 271, (current_date - 271 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (279, 124, 2, 'VENCIDA', current_date - 179, (current_date - 179 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (280, 124, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 125 Paola Sánchez: 1 membresía(s), 1 activa
    (281, 125, 3, 'ACTIVA', current_date - 288, (current_date - 288 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 126 Manuela Ruiz: 3 membresía(s), 1 activa
    (282, 126, 2, 'VENCIDA', current_date - 384, (current_date - 384 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (283, 126, 1, 'VENCIDA', current_date - 289, (current_date - 289 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (284, 126, 3, 'ACTIVA', current_date - 256, (current_date - 256 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 127 Sebastián Moreno: 2 membresía(s), 1 activa
    (285, 127, 2, 'VENCIDA', current_date - 282, (current_date - 282 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (286, 127, 3, 'ACTIVA', current_date - 186, (current_date - 186 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 128 Mateo Hernández: 1 membresía(s), 1 activa
    (287, 128, 3, 'ACTIVA', current_date - 73, (current_date - 73 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 129 Sebastián Ruiz: 1 membresía(s), 1 activa
    (288, 129, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 130 Tatiana Martínez: 2 membresía(s), 1 activa
    (289, 130, 1, 'VENCIDA', current_date - 385, (current_date - 385 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (290, 130, 3, 'ACTIVA', current_date - 219, (current_date - 219 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 131 Yuliana Martínez: 1 membresía(s), ninguna activa
    (291, 131, 3, 'VENCIDA', current_date - 549, (current_date - 549 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 132 Mariana Suárez: 1 membresía(s), 1 activa
    (292, 132, 3, 'ACTIVA', current_date - 336, (current_date - 336 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 133 Esteban Ospina: 1 membresía(s), 1 activa
    (293, 133, 1, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 134 Lucía Martínez: 3 membresía(s), 1 activa
    (294, 134, 3, 'VENCIDA', current_date - 520, (current_date - 520 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (295, 134, 2, 'VENCIDA', current_date - 131, (current_date - 131 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (296, 134, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 135 David Salazar: 1 membresía(s), 1 activa
    (297, 135, 3, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 136 Carlos Rincón: 4 membresía(s), ninguna activa
    (298, 136, 1, 'VENCIDA', current_date - 218, (current_date - 218 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (299, 136, 1, 'VENCIDA', current_date - 187, (current_date - 187 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (300, 136, 2, 'VENCIDA', current_date - 150, (current_date - 150 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (301, 136, 1, 'VENCIDA', current_date - 58, (current_date - 58 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 137 Carlos Jiménez: 2 membresía(s), 1 activa
    (302, 137, 2, 'VENCIDA', current_date - 424, (current_date - 424 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (303, 137, 3, 'ACTIVA', current_date - 200, (current_date - 200 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 138 Isabella Poveda: 2 membresía(s), 1 activa
    (304, 138, 1, 'VENCIDA', current_date - 91, (current_date - 91 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (305, 138, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 139 Isabella González: 2 membresía(s), 1 activa
    (306, 139, 2, 'VENCIDA', current_date - 328, (current_date - 328 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (307, 139, 3, 'ACTIVA', current_date - 231, (current_date - 231 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 140 Tomás Rojas: 4 membresía(s), 1 activa
    (308, 140, 1, 'VENCIDA', current_date - 441, (current_date - 441 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (309, 140, 3, 'VENCIDA', current_date - 407, (current_date - 407 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (310, 140, 1, 'VENCIDA', current_date - 40, (current_date - 40 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (311, 140, 2, 'ACTIVA', current_date - 6, (current_date - 6 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 141 Ricardo Parra: 4 membresía(s), 1 activa
    (312, 141, 1, 'VENCIDA', current_date - 186, (current_date - 186 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (313, 141, 1, 'VENCIDA', current_date - 151, (current_date - 151 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (314, 141, 2, 'VENCIDA', current_date - 120, (current_date - 120 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (315, 141, 2, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 142 Carolina Castaño: 1 membresía(s), ninguna activa
    (316, 142, 2, 'VENCIDA', current_date - 564, (current_date - 564 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 143 Iván Parra: 3 membresía(s), 1 activa
    (317, 143, 1, 'VENCIDA', current_date - 306, (current_date - 306 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (318, 143, 1, 'VENCIDA', current_date - 145, (current_date - 145 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (319, 143, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 144 Paola Herrera: 3 membresía(s), 1 activa
    (320, 144, 1, 'VENCIDA', current_date - 160, (current_date - 160 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (321, 144, 2, 'VENCIDA', current_date - 126, (current_date - 126 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (322, 144, 2, 'ACTIVA', current_date - 29, (current_date - 29 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 145 Gabriela Martínez: 4 membresía(s), 1 activa
    (323, 145, 2, 'VENCIDA', current_date - 355, (current_date - 355 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (324, 145, 2, 'VENCIDA', current_date - 262, (current_date - 262 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (325, 145, 2, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (326, 145, 2, 'ACTIVA', current_date - 70, (current_date - 70 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 146 Esteban Gómez: 4 membresía(s), 1 activa
    (327, 146, 1, 'VENCIDA', current_date - 260, (current_date - 260 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (328, 146, 1, 'VENCIDA', current_date - 158, (current_date - 158 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (329, 146, 1, 'VENCIDA', current_date - 122, (current_date - 122 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (330, 146, 3, 'ACTIVA', current_date, (current_date + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 147 Felipe Becerra: 1 membresía(s), 1 activa
    (331, 147, 1, 'ACTIVA', current_date - 9, (current_date - 9 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 148 Alejandra Peña: 3 membresía(s), 1 activa
    (332, 148, 2, 'VENCIDA', current_date - 621, (current_date - 621 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (333, 148, 3, 'VENCIDA', current_date - 494, (current_date - 494 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (334, 148, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 149 Lina Ruiz: 1 membresía(s), ninguna activa
    (335, 149, 3, 'VENCIDA', current_date - 465, (current_date - 465 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 150 Carolina Martínez: 2 membresía(s), 1 activa
    (336, 150, 2, 'VENCIDA', current_date - 425, (current_date - 425 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (337, 150, 3, 'ACTIVA', current_date - 332, (current_date - 332 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 151 Santiago Ruiz: 3 membresía(s), 1 activa
    (338, 151, 3, 'VENCIDA', current_date - 482, (current_date - 482 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (339, 151, 2, 'VENCIDA', current_date - 115, (current_date - 115 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (340, 151, 2, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 152 Juliana Arango: 1 membresía(s), 1 activa
    (341, 152, 3, 'ACTIVA', current_date - 83, (current_date - 83 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 153 Isabella Torres: 2 membresía(s), 1 activa
    (342, 153, 1, 'VENCIDA', current_date - 87, (current_date - 87 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (343, 153, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 154 Héctor Peña: 1 membresía(s), 1 activa
    (344, 154, 2, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 155 Paula Díaz: 2 membresía(s), 1 activa
    (345, 155, 1, 'VENCIDA', current_date - 315, (current_date - 315 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (346, 155, 3, 'ACTIVA', current_date - 177, (current_date - 177 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 156 Iván Mendoza: 1 membresía(s), 1 activa
    (347, 156, 3, 'ACTIVA', current_date - 107, (current_date - 107 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 157 Lucía Suárez: 2 membresía(s), ninguna activa
    (348, 157, 2, 'VENCIDA', current_date - 322, (current_date - 322 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (349, 157, 1, 'VENCIDA', current_date - 153, (current_date - 153 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 158 Brayan Torres: 1 membresía(s), 1 activa
    (350, 158, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 159 Sofía Becerra: 3 membresía(s), ninguna activa
    (351, 159, 2, 'VENCIDA', current_date - 552, (current_date - 552 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (352, 159, 3, 'VENCIDA', current_date - 431, (current_date - 431 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (353, 159, 1, 'VENCIDA', current_date - 59, (current_date - 59 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 160 Sofía Díaz: 3 membresía(s), 1 activa
    (354, 160, 2, 'VENCIDA', current_date - 255, (current_date - 255 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (355, 160, 1, 'VENCIDA', current_date - 40, (current_date - 40 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (356, 160, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 161 Alejandra Poveda: 1 membresía(s), ninguna activa
    (357, 161, 1, 'VENCIDA', current_date - 315, (current_date - 315 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 162 Fernando Buitrago: 3 membresía(s), 1 activa
    (358, 162, 3, 'VENCIDA', current_date - 536, (current_date - 536 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (359, 162, 1, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (360, 162, 2, 'ACTIVA', current_date - 77, (current_date - 77 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 163 Jorge Gutiérrez: 2 membresía(s), ninguna activa
    (361, 163, 2, 'VENCIDA', current_date - 415, (current_date - 415 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (362, 163, 2, 'VENCIDA', current_date - 320, (current_date - 320 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 164 Miguel Lozano: 1 membresía(s), 1 activa
    (363, 164, 3, 'ACTIVA', current_date - 342, (current_date - 342 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 165 Mariana Jiménez: 3 membresía(s), 1 activa
    (364, 165, 1, 'VENCIDA', current_date - 234, (current_date - 234 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (365, 165, 2, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (366, 165, 3, 'ACTIVA', current_date - 73, (current_date - 73 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 166 Juan Ortiz: 2 membresía(s), 1 activa
    (367, 166, 3, 'VENCIDA', current_date - 490, (current_date - 490 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (368, 166, 3, 'ACTIVA', current_date - 118, (current_date - 118 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 167 Miguel Sánchez: 4 membresía(s), 1 activa
    (369, 167, 1, 'VENCIDA', current_date - 117, (current_date - 117 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (370, 167, 1, 'VENCIDA', current_date - 85, (current_date - 85 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (371, 167, 1, 'VENCIDA', current_date - 51, (current_date - 51 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (372, 167, 2, 'ACTIVA', current_date - 15, (current_date - 15 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 168 Diego Buitrago: 3 membresía(s), 1 activa
    (373, 168, 3, 'VENCIDA', current_date - 597, (current_date - 597 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (374, 168, 1, 'VENCIDA', current_date - 229, (current_date - 229 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (375, 168, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 169 Lucía Cortés: 3 membresía(s), 1 activa
    (376, 169, 1, 'VENCIDA', current_date - 162, (current_date - 162 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (377, 169, 1, 'VENCIDA', current_date - 130, (current_date - 130 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (378, 169, 3, 'ACTIVA', current_date - 94, (current_date - 94 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 170 Juan Buitrago: 4 membresía(s), 1 activa
    (379, 170, 1, 'VENCIDA', current_date - 261, (current_date - 261 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (380, 170, 1, 'VENCIDA', current_date - 145, (current_date - 145 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (381, 170, 1, 'VENCIDA', current_date - 32, (current_date - 32 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (382, 170, 1, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 171 Mauricio Quintero: 2 membresía(s), 1 activa
    (383, 171, 2, 'VENCIDA', current_date - 98, (current_date - 98 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (384, 171, 2, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 172 Sara Vargas: 1 membresía(s), 1 activa
    (385, 172, 2, 'ACTIVA', current_date - 20, (current_date - 20 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 173 Lina García: 3 membresía(s), 1 activa
    (386, 173, 2, 'VENCIDA', current_date - 482, (current_date - 482 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (387, 173, 2, 'VENCIDA', current_date - 386, (current_date - 386 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (388, 173, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 174 Laura Ospina: 2 membresía(s), 1 activa
    (389, 174, 1, 'VENCIDA', current_date - 63, (current_date - 63 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (390, 174, 1, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 175 Tatiana Álvarez: 2 membresía(s), 1 activa
    (391, 175, 2, 'VENCIDA', current_date - 125, (current_date - 125 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (392, 175, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 176 Laura Hernández: 3 membresía(s), 1 activa
    (393, 176, 1, 'VENCIDA', current_date - 188, (current_date - 188 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (394, 176, 1, 'VENCIDA', current_date - 151, (current_date - 151 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (395, 176, 2, 'ACTIVA', current_date - 77, (current_date - 77 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 177 Yuliana Pérez: 4 membresía(s), 1 activa
    (396, 177, 2, 'VENCIDA', current_date - 386, (current_date - 386 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (397, 177, 1, 'VENCIDA', current_date - 294, (current_date - 294 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (398, 177, 2, 'VENCIDA', current_date - 137, (current_date - 137 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (399, 177, 2, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 178 Lina Cárdenas: 2 membresía(s), 1 activa
    (400, 178, 2, 'VENCIDA', current_date - 202, (current_date - 202 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (401, 178, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 179 Natalia Ramírez: 3 membresía(s), 1 activa
    (402, 179, 3, 'VENCIDA', current_date - 506, (current_date - 506 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (403, 179, 1, 'VENCIDA', current_date - 139, (current_date - 139 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (404, 179, 2, 'ACTIVA', current_date - 55, (current_date - 55 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 180 Jhonatan González: 1 membresía(s), 1 activa
    (405, 180, 2, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 181 Samuel Ospina: 2 membresía(s), 1 activa
    (406, 181, 2, 'VENCIDA', current_date - 362, (current_date - 362 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (407, 181, 3, 'ACTIVA', current_date - 264, (current_date - 264 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 182 David Peña: 2 membresía(s), 1 activa
    (408, 182, 3, 'VENCIDA', current_date - 404, (current_date - 404 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (409, 182, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 183 Lina Gutiérrez: 6 membresía(s), 1 activa
    (410, 183, 1, 'VENCIDA', current_date - 186, (current_date - 186 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (411, 183, 1, 'VENCIDA', current_date - 151, (current_date - 151 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (412, 183, 1, 'VENCIDA', current_date - 120, (current_date - 120 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (413, 183, 1, 'VENCIDA', current_date - 87, (current_date - 87 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (414, 183, 1, 'VENCIDA', current_date - 53, (current_date - 53 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (415, 183, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 184 Mauricio Mejía: 4 membresía(s), 1 activa
    (416, 184, 2, 'VENCIDA', current_date - 336, (current_date - 336 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (417, 184, 1, 'VENCIDA', current_date - 131, (current_date - 131 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (418, 184, 2, 'VENCIDA', current_date - 99, (current_date - 99 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (419, 184, 2, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 185 Ángela Mejía: 3 membresía(s), 1 activa
    (420, 185, 2, 'VENCIDA', current_date - 470, (current_date - 470 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (421, 185, 2, 'VENCIDA', current_date - 372, (current_date - 372 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (422, 185, 3, 'ACTIVA', current_date - 279, (current_date - 279 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 186 Paula Peña: 3 membresía(s), 1 activa
    (423, 186, 2, 'VENCIDA', current_date - 159, (current_date - 159 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (424, 186, 1, 'VENCIDA', current_date - 63, (current_date - 63 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (425, 186, 2, 'ACTIVA', current_date - 28, (current_date - 28 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 187 Iván Castro: 1 membresía(s), 1 activa
    (426, 187, 3, 'ACTIVA', current_date - 8, (current_date - 8 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 188 Paola Salazar: 1 membresía(s), ninguna activa
    (427, 188, 3, 'VENCIDA', current_date - 590, (current_date - 590 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 189 Paola Rincón: 2 membresía(s), 1 activa
    (428, 189, 2, 'VENCIDA', current_date - 329, (current_date - 329 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (429, 189, 3, 'ACTIVA', current_date - 233, (current_date - 233 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 190 Luis Díaz: 2 membresía(s), 1 activa
    (430, 190, 3, 'VENCIDA', current_date - 379, (current_date - 379 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (431, 190, 3, 'ACTIVA', current_date - 13, (current_date - 13 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 191 Diego Zapata: 1 membresía(s), ninguna activa
    (432, 191, 1, 'VENCIDA', current_date - 266, (current_date - 266 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 192 Jorge Romero: 3 membresía(s), 1 activa
    (433, 192, 1, 'VENCIDA', current_date - 291, (current_date - 291 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (434, 192, 1, 'VENCIDA', current_date - 258, (current_date - 258 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (435, 192, 3, 'ACTIVA', current_date - 99, (current_date - 99 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 193 Ángela Ospina: 4 membresía(s), 1 activa
    (436, 193, 2, 'VENCIDA', current_date - 514, (current_date - 514 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (437, 193, 3, 'VENCIDA', current_date - 419, (current_date - 419 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (438, 193, 1, 'VENCIDA', current_date - 52, (current_date - 52 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (439, 193, 2, 'ACTIVA', current_date - 18, (current_date - 18 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 194 Tatiana García: 1 membresía(s), 1 activa
    (440, 194, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 195 Laura Martínez: 1 membresía(s), 1 activa
    (441, 195, 1, 'ACTIVA', current_date - 14, (current_date - 14 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 196 Juliana Lozano: 5 membresía(s), 1 activa
    (442, 196, 2, 'VENCIDA', current_date - 196, (current_date - 196 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (443, 196, 1, 'VENCIDA', current_date - 99, (current_date - 99 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (444, 196, 1, 'VENCIDA', current_date - 65, (current_date - 65 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (445, 196, 1, 'VENCIDA', current_date - 31, (current_date - 31 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (446, 196, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 197 Paula Ospina: 2 membresía(s), 1 activa
    (447, 197, 1, 'VENCIDA', current_date - 130, (current_date - 130 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (448, 197, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 198 Camilo Castaño: 3 membresía(s), 1 activa
    (449, 198, 3, 'VENCIDA', current_date - 414, (current_date - 414 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (450, 198, 1, 'VENCIDA', current_date - 46, (current_date - 46 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (451, 198, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 199 Marcela Cárdenas: 2 membresía(s), 1 activa
    (452, 199, 2, 'VENCIDA', current_date - 92, (current_date - 92 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (453, 199, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 200 Tomás Hernández: 2 membresía(s), 1 activa
    (454, 200, 2, 'VENCIDA', current_date - 135, (current_date - 135 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (455, 200, 3, 'ACTIVA', current_date - 39, (current_date - 39 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 201 María Gómez: 1 membresía(s), 1 activa
    (456, 201, 2, 'ACTIVA', current_date - 42, (current_date - 42 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 202 Andrea López: 1 membresía(s), 1 activa
    (457, 202, 3, 'ACTIVA', current_date - 339, (current_date - 339 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 203 Kevin Hernández: 5 membresía(s), ninguna activa
    (458, 203, 2, 'VENCIDA', current_date - 423, (current_date - 423 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (459, 203, 2, 'VENCIDA', current_date - 325, (current_date - 325 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (460, 203, 2, 'VENCIDA', current_date - 227, (current_date - 227 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (461, 203, 1, 'VENCIDA', current_date - 130, (current_date - 130 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (462, 203, 1, 'VENCIDA', current_date - 47, (current_date - 47 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 204 Diego Cárdenas: 2 membresía(s), 1 activa
    (463, 204, 1, 'VENCIDA', current_date - 158, (current_date - 158 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (464, 204, 3, 'ACTIVA', current_date - 124, (current_date - 124 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 205 Viviana Suárez: 2 membresía(s), 1 activa
    (465, 205, 3, 'VENCIDA', current_date - 513, (current_date - 513 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (466, 205, 2, 'ACTIVA', current_date - 9, (current_date - 9 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 206 Carolina Cifuentes: 2 membresía(s), 1 activa
    (467, 206, 3, 'VENCIDA', current_date - 511, (current_date - 511 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (468, 206, 3, 'ACTIVA', current_date - 144, (current_date - 144 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 207 Camila Ospina: 2 membresía(s), 1 activa
    (469, 207, 1, 'VENCIDA', current_date - 32, (current_date - 32 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (470, 207, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 208 Viviana Becerra: 1 membresía(s), 1 activa
    (471, 208, 3, 'ACTIVA', current_date - 88, (current_date - 88 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 209 Juliana Pérez: 1 membresía(s), 1 activa
    (472, 209, 2, 'ACTIVA', current_date - 19, (current_date - 19 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 210 Felipe Jiménez: 2 membresía(s), 1 activa
    (473, 210, 2, 'VENCIDA', current_date - 105, (current_date - 105 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (474, 210, 3, 'ACTIVA', current_date - 10, (current_date - 10 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 211 Sebastián Romero: 2 membresía(s), ninguna activa
    (475, 211, 2, 'VENCIDA', current_date - 455, (current_date - 455 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (476, 211, 1, 'VENCIDA', current_date - 358, (current_date - 358 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 212 Andrea Mejía: 3 membresía(s), 1 activa
    (477, 212, 1, 'VENCIDA', current_date - 120, (current_date - 120 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (478, 212, 1, 'VENCIDA', current_date - 62, (current_date - 62 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (479, 212, 1, 'ACTIVA', current_date - 24, (current_date - 24 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 213 Nicolás Restrepo: 1 membresía(s), 1 activa
    (480, 213, 3, 'ACTIVA', current_date - 328, (current_date - 328 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 214 Viviana Restrepo: 1 membresía(s), ninguna activa
    (481, 214, 1, 'VENCIDA', current_date - 263, (current_date - 263 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 215 Santiago Salazar: 5 membresía(s), 1 activa
    (482, 215, 1, 'VENCIDA', current_date - 360, (current_date - 360 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (483, 215, 2, 'VENCIDA', current_date - 325, (current_date - 325 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (484, 215, 2, 'VENCIDA', current_date - 229, (current_date - 229 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (485, 215, 1, 'VENCIDA', current_date - 35, (current_date - 35 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (486, 215, 3, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 216 Jhonatan Castro: 3 membresía(s), 1 activa
    (487, 216, 1, 'VENCIDA', current_date - 339, (current_date - 339 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (488, 216, 2, 'VENCIDA', current_date - 302, (current_date - 302 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (489, 216, 3, 'ACTIVA', current_date - 206, (current_date - 206 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 217 Jhonatan Salazar: 6 membresía(s), 1 activa
    (490, 217, 2, 'VENCIDA', current_date - 602, (current_date - 602 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (491, 217, 2, 'VENCIDA', current_date - 510, (current_date - 510 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (492, 217, 2, 'VENCIDA', current_date - 417, (current_date - 417 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (493, 217, 2, 'VENCIDA', current_date - 298, (current_date - 298 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (494, 217, 2, 'VENCIDA', current_date - 201, (current_date - 201 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (495, 217, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 218 Valentina Herrera: 2 membresía(s), 1 activa
    (496, 218, 1, 'VENCIDA', current_date - 131, (current_date - 131 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (497, 218, 2, 'ACTIVA', current_date - 60, (current_date - 60 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 219 Jhonatan Díaz: 2 membresía(s), 1 activa
    (498, 219, 1, 'VENCIDA', current_date - 313, (current_date - 313 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (499, 219, 3, 'ACTIVA', current_date - 146, (current_date - 146 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 220 Andrés González: 2 membresía(s), 1 activa
    (500, 220, 2, 'VENCIDA', current_date - 179, (current_date - 179 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (501, 220, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 221 Iván Torres: 3 membresía(s), 1 activa
    (502, 221, 2, 'VENCIDA', current_date - 199, (current_date - 199 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (503, 221, 1, 'VENCIDA', current_date - 83, (current_date - 83 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (504, 221, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 222 Esteban Ramírez: 1 membresía(s), 1 activa
    (505, 222, 3, 'ACTIVA', current_date - 73, (current_date - 73 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 223 Viviana Cifuentes: 5 membresía(s), 1 activa
    (506, 223, 2, 'VENCIDA', current_date - 452, (current_date - 452 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (507, 223, 2, 'VENCIDA', current_date - 354, (current_date - 354 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (508, 223, 1, 'VENCIDA', current_date - 256, (current_date - 256 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (509, 223, 2, 'VENCIDA', current_date - 222, (current_date - 222 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (510, 223, 2, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 224 Julián Ruiz: 2 membresía(s), 1 activa
    (511, 224, 1, 'VENCIDA', current_date - 100, (current_date - 100 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (512, 224, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 225 Mateo Parra: 2 membresía(s), 1 activa
    (513, 225, 3, 'VENCIDA', current_date - 425, (current_date - 425 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (514, 225, 3, 'ACTIVA', current_date - 56, (current_date - 56 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 226 Luisa García: 2 membresía(s), 1 activa
    (515, 226, 3, 'VENCIDA', current_date - 435, (current_date - 435 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (516, 226, 2, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 227 Diana Martínez: 4 membresía(s), 1 activa
    (517, 227, 2, 'VENCIDA', current_date - 285, (current_date - 285 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (518, 227, 2, 'VENCIDA', current_date - 188, (current_date - 188 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (519, 227, 1, 'VENCIDA', current_date - 90, (current_date - 90 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (520, 227, 2, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 228 Juan Zapata: 1 membresía(s), 1 activa
    (521, 228, 3, 'ACTIVA', current_date - 305, (current_date - 305 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 229 María Zapata: 2 membresía(s), 1 activa
    (522, 229, 1, 'VENCIDA', current_date - 110, (current_date - 110 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (523, 229, 2, 'ACTIVA', current_date - 76, (current_date - 76 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 230 Fernando Valencia: 1 membresía(s), 1 activa
    (524, 230, 3, 'ACTIVA', current_date - 86, (current_date - 86 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 231 Jorge Hernández: 4 membresía(s), 1 activa
    (525, 231, 1, 'VENCIDA', current_date - 229, (current_date - 229 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (526, 231, 1, 'VENCIDA', current_date - 198, (current_date - 198 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (527, 231, 2, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (528, 231, 3, 'ACTIVA', current_date - 73, (current_date - 73 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 232 David Moreno: 3 membresía(s), 1 activa
    (529, 232, 1, 'VENCIDA', current_date - 158, (current_date - 158 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (530, 232, 1, 'VENCIDA', current_date - 127, (current_date - 127 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (531, 232, 2, 'ACTIVA', current_date - 51, (current_date - 51 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 233 Tomás Ruiz: 2 membresía(s), 1 activa
    (532, 233, 2, 'VENCIDA', current_date - 459, (current_date - 459 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (533, 233, 3, 'ACTIVA', current_date - 250, (current_date - 250 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 234 Héctor Rincón: 3 membresía(s), 1 activa
    (534, 234, 1, 'VENCIDA', current_date - 293, (current_date - 293 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (535, 234, 1, 'VENCIDA', current_date - 193, (current_date - 193 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (536, 234, 2, 'ACTIVA', current_date - 39, (current_date - 39 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 235 Juliana Poveda: 2 membresía(s), 1 activa
    (537, 235, 3, 'VENCIDA', current_date - 510, (current_date - 510 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (538, 235, 3, 'ACTIVA', current_date - 142, (current_date - 142 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 236 Ángela Lozano: 2 membresía(s), 1 activa
    (539, 236, 2, 'VENCIDA', current_date - 242, (current_date - 242 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (540, 236, 1, 'ACTIVA', current_date - 24, (current_date - 24 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 237 Alejandro López: 5 membresía(s), 1 activa
    (541, 237, 1, 'VENCIDA', current_date - 447, (current_date - 447 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (542, 237, 2, 'VENCIDA', current_date - 340, (current_date - 340 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (543, 237, 2, 'VENCIDA', current_date - 180, (current_date - 180 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (544, 237, 1, 'VENCIDA', current_date - 82, (current_date - 82 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (545, 237, 3, 'ACTIVA', current_date - 46, (current_date - 46 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 238 Camila Salazar: 2 membresía(s), 1 activa
    (546, 238, 2, 'VENCIDA', current_date - 287, (current_date - 287 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (547, 238, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 239 Brayan Ruiz: 2 membresía(s), 1 activa
    (548, 239, 1, 'VENCIDA', current_date - 89, (current_date - 89 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (549, 239, 1, 'ACTIVA', current_date - 4, (current_date - 4 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 240 Andrés Martínez: 2 membresía(s), 1 activa
    (550, 240, 1, 'VENCIDA', current_date - 144, (current_date - 144 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (551, 240, 2, 'ACTIVA', current_date - 59, (current_date - 59 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 241 Sofía Martínez: 4 membresía(s), 1 activa
    (552, 241, 1, 'VENCIDA', current_date - 169, (current_date - 169 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (553, 241, 1, 'VENCIDA', current_date - 138, (current_date - 138 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (554, 241, 1, 'VENCIDA', current_date - 51, (current_date - 51 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (555, 241, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 242 Juan Hernández: 3 membresía(s), 1 activa
    (556, 242, 1, 'VENCIDA', current_date - 185, (current_date - 185 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (557, 242, 1, 'VENCIDA', current_date - 152, (current_date - 152 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (558, 242, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 243 Esteban Acosta: 4 membresía(s), 1 activa
    (559, 243, 1, 'VENCIDA', current_date - 233, (current_date - 233 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (560, 243, 1, 'VENCIDA', current_date - 178, (current_date - 178 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (561, 243, 2, 'VENCIDA', current_date - 114, (current_date - 114 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (562, 243, 3, 'ACTIVA', current_date - 17, (current_date - 17 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 244 Brayan Acosta: 2 membresía(s), 1 activa
    (563, 244, 1, 'VENCIDA', current_date - 294, (current_date - 294 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (564, 244, 3, 'ACTIVA', current_date - 261, (current_date - 261 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 245 Kevin Rodríguez: 2 membresía(s), 1 activa
    (565, 245, 1, 'VENCIDA', current_date - 38, (current_date - 38 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (566, 245, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 246 Laura Valencia: 4 membresía(s), 1 activa
    (567, 246, 2, 'VENCIDA', current_date - 616, (current_date - 616 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (568, 246, 3, 'VENCIDA', current_date - 524, (current_date - 524 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (569, 246, 2, 'VENCIDA', current_date - 156, (current_date - 156 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (570, 246, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 247 Nicolás Castro: 1 membresía(s), 1 activa
    (571, 247, 3, 'ACTIVA', current_date - 310, (current_date - 310 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 248 Lorena Ruiz: 4 membresía(s), 1 activa
    (572, 248, 1, 'VENCIDA', current_date - 287, (current_date - 287 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (573, 248, 2, 'VENCIDA', current_date - 254, (current_date - 254 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (574, 248, 1, 'VENCIDA', current_date - 157, (current_date - 157 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (575, 248, 1, 'ACTIVA', current_date - 10, (current_date - 10 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 249 Lucía Ospina: 1 membresía(s), 1 activa
    (576, 249, 3, 'ACTIVA', current_date - 343, (current_date - 343 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 250 Jhonatan Pérez: 4 membresía(s), 1 activa
    (577, 250, 2, 'VENCIDA', current_date - 385, (current_date - 385 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (578, 250, 1, 'VENCIDA', current_date - 291, (current_date - 291 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (579, 250, 2, 'VENCIDA', current_date - 171, (current_date - 171 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (580, 250, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 251 Santiago Quintero: 3 membresía(s), 1 activa
    (581, 251, 1, 'VENCIDA', current_date - 154, (current_date - 154 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (582, 251, 1, 'VENCIDA', current_date - 33, (current_date - 33 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (583, 251, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 252 Santiago Álvarez: 2 membresía(s), 1 activa
    (584, 252, 1, 'VENCIDA', current_date - 104, (current_date - 104 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (585, 252, 3, 'ACTIVA', current_date - 70, (current_date - 70 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 253 Kevin García: 3 membresía(s), ninguna activa
    (586, 253, 2, 'VENCIDA', current_date - 274, (current_date - 274 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (587, 253, 1, 'VENCIDA', current_date - 151, (current_date - 151 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (588, 253, 2, 'VENCIDA', current_date - 115, (current_date - 115 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 254 Andrea Buitrago: 3 membresía(s), 1 activa
    (589, 254, 1, 'VENCIDA', current_date - 401, (current_date - 401 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (590, 254, 3, 'VENCIDA', current_date - 367, (current_date - 367 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (591, 254, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 255 Carlos Mendoza: 5 membresía(s), 1 activa
    (592, 255, 2, 'VENCIDA', current_date - 353, (current_date - 353 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (593, 255, 1, 'VENCIDA', current_date - 223, (current_date - 223 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (594, 255, 2, 'VENCIDA', current_date - 190, (current_date - 190 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (595, 255, 2, 'VENCIDA', current_date - 96, (current_date - 96 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (596, 255, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 256 Natalia Herrera: 1 membresía(s), 1 activa
    (597, 256, 2, 'ACTIVA', current_date - 37, (current_date - 37 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 257 Nicolás Herrera: 3 membresía(s), 1 activa
    (598, 257, 1, 'VENCIDA', current_date - 149, (current_date - 149 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (599, 257, 2, 'VENCIDA', current_date - 115, (current_date - 115 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (600, 257, 3, 'ACTIVA', current_date - 19, (current_date - 19 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 258 Daniela Quintero: 6 membresía(s), 1 activa
    (601, 258, 2, 'VENCIDA', current_date - 479, (current_date - 479 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (602, 258, 1, 'VENCIDA', current_date - 384, (current_date - 384 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (603, 258, 2, 'VENCIDA', current_date - 348, (current_date - 348 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (604, 258, 2, 'VENCIDA', current_date - 256, (current_date - 256 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (605, 258, 2, 'VENCIDA', current_date - 159, (current_date - 159 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (606, 258, 2, 'ACTIVA', current_date - 63, (current_date - 63 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 259 Viviana Mejía: 2 membresía(s), 1 activa
    (607, 259, 3, 'VENCIDA', current_date - 402, (current_date - 402 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (608, 259, 1, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 260 Yuliana Lozano: 3 membresía(s), 1 activa
    (609, 260, 2, 'VENCIDA', current_date - 329, (current_date - 329 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (610, 260, 1, 'VENCIDA', current_date - 119, (current_date - 119 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (611, 260, 2, 'ACTIVA', current_date - 50, (current_date - 50 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 261 Daniel Rincón: 4 membresía(s), 1 activa
    (612, 261, 1, 'VENCIDA', current_date - 138, (current_date - 138 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (613, 261, 1, 'VENCIDA', current_date - 104, (current_date - 104 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (614, 261, 1, 'VENCIDA', current_date - 73, (current_date - 73 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (615, 261, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 262 Sofía Rojas: 2 membresía(s), ninguna activa
    (616, 262, 1, 'VENCIDA', current_date - 441, (current_date - 441 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (617, 262, 3, 'VENCIDA', current_date - 370, (current_date - 370 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 263 Mariana Londoño: 4 membresía(s), 1 activa
    (618, 263, 1, 'VENCIDA', current_date - 293, (current_date - 293 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (619, 263, 2, 'VENCIDA', current_date - 198, (current_date - 198 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (620, 263, 1, 'VENCIDA', current_date - 103, (current_date - 103 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (621, 263, 2, 'ACTIVA', current_date - 69, (current_date - 69 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 264 Diana Castaño: 5 membresía(s), 1 activa
    (622, 264, 1, 'VENCIDA', current_date - 679, (current_date - 679 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (623, 264, 2, 'VENCIDA', current_date - 642, (current_date - 642 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (624, 264, 1, 'VENCIDA', current_date - 468, (current_date - 468 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (625, 264, 3, 'VENCIDA', current_date - 435, (current_date - 435 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (626, 264, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 265 Gabriela Quintero: 1 membresía(s), ninguna activa
    (627, 265, 3, 'VENCIDA', current_date - 514, (current_date - 514 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 266 Ángela Cárdenas: 4 membresía(s), 1 activa
    (628, 266, 1, 'VENCIDA', current_date - 249, (current_date - 249 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (629, 266, 1, 'VENCIDA', current_date - 213, (current_date - 213 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (630, 266, 2, 'VENCIDA', current_date - 181, (current_date - 181 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (631, 266, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 267 Mariana Mejía: 3 membresía(s), 1 activa
    (632, 267, 3, 'VENCIDA', current_date - 467, (current_date - 467 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (633, 267, 2, 'VENCIDA', current_date - 100, (current_date - 100 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (634, 267, 3, 'ACTIVA', current_date - 7, (current_date - 7 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 268 María Quintero: 5 membresía(s), 1 activa
    (635, 268, 2, 'VENCIDA', current_date - 515, (current_date - 515 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (636, 268, 2, 'VENCIDA', current_date - 418, (current_date - 418 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (637, 268, 1, 'VENCIDA', current_date - 306, (current_date - 306 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (638, 268, 1, 'VENCIDA', current_date - 271, (current_date - 271 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (639, 268, 3, 'ACTIVA', current_date - 240, (current_date - 240 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 269 Jhonatan Díaz: 3 membresía(s), 1 activa
    (640, 269, 2, 'VENCIDA', current_date - 351, (current_date - 351 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (641, 269, 1, 'VENCIDA', current_date - 222, (current_date - 222 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (642, 269, 3, 'ACTIVA', current_date - 188, (current_date - 188 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 270 Lucía Mejía: 1 membresía(s), 1 activa
    (643, 270, 2, 'ACTIVA', current_date - 70, (current_date - 70 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 271 Sebastián Martínez: 5 membresía(s), 1 activa
    (644, 271, 1, 'VENCIDA', current_date - 220, (current_date - 220 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (645, 271, 1, 'VENCIDA', current_date - 185, (current_date - 185 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (646, 271, 2, 'VENCIDA', current_date - 152, (current_date - 152 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (647, 271, 1, 'VENCIDA', current_date - 59, (current_date - 59 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (648, 271, 2, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 272 Felipe Moreno: 4 membresía(s), 1 activa
    (649, 272, 1, 'VENCIDA', current_date - 254, (current_date - 254 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (650, 272, 2, 'VENCIDA', current_date - 218, (current_date - 218 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (651, 272, 2, 'VENCIDA', current_date - 121, (current_date - 121 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (652, 272, 2, 'ACTIVA', current_date - 25, (current_date - 25 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 273 Tomás Peña: 3 membresía(s), ninguna activa
    (653, 273, 2, 'VENCIDA', current_date - 584, (current_date - 584 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (654, 273, 2, 'VENCIDA', current_date - 487, (current_date - 487 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (655, 273, 3, 'VENCIDA', current_date - 393, (current_date - 393 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 274 Esteban Gutiérrez: 3 membresía(s), 1 activa
    (656, 274, 1, 'VENCIDA', current_date - 206, (current_date - 206 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (657, 274, 1, 'VENCIDA', current_date - 171, (current_date - 171 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (658, 274, 2, 'ACTIVA', current_date - 36, (current_date - 36 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 275 Lorena Ramírez: 1 membresía(s), 1 activa
    (659, 275, 2, 'ACTIVA', current_date - 19, (current_date - 19 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 276 Camila Rincón: 2 membresía(s), ninguna activa
    (660, 276, 1, 'VENCIDA', current_date - 418, (current_date - 418 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (661, 276, 2, 'VENCIDA', current_date - 382, (current_date - 382 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 277 Marcela Cortés: 3 membresía(s), 1 activa
    (662, 277, 1, 'VENCIDA', current_date - 274, (current_date - 274 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (663, 277, 2, 'VENCIDA', current_date - 241, (current_date - 241 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (664, 277, 3, 'ACTIVA', current_date - 147, (current_date - 147 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 278 Daniel Valencia: 2 membresía(s), 1 activa
    (665, 278, 1, 'VENCIDA', current_date - 189, (current_date - 189 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (666, 278, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 279 Mateo Herrera: 1 membresía(s), ninguna activa
    (667, 279, 3, 'VENCIDA', current_date - 482, (current_date - 482 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 280 Paula Castro: 3 membresía(s), 1 activa
    (668, 280, 1, 'VENCIDA', current_date - 113, (current_date - 113 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (669, 280, 1, 'VENCIDA', current_date - 77, (current_date - 77 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (670, 280, 2, 'ACTIVA', current_date - 46, (current_date - 46 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 281 Miguel García: 1 membresía(s), ninguna activa
    (671, 281, 3, 'VENCIDA', current_date - 388, (current_date - 388 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 282 Gabriel Cifuentes: 3 membresía(s), 1 activa
    (672, 282, 2, 'VENCIDA', current_date - 525, (current_date - 525 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (673, 282, 1, 'VENCIDA', current_date - 377, (current_date - 377 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (674, 282, 3, 'ACTIVA', current_date - 345, (current_date - 345 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 283 Catalina Rodríguez: 2 membresía(s), 1 activa
    (675, 283, 1, 'VENCIDA', current_date - 86, (current_date - 86 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (676, 283, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 284 Andrés Hernández: 2 membresía(s), 1 activa
    (677, 284, 2, 'VENCIDA', current_date - 94, (current_date - 94 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (678, 284, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 285 Héctor Gutiérrez: 2 membresía(s), 1 activa
    (679, 285, 1, 'VENCIDA', current_date - 84, (current_date - 84 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (680, 285, 3, 'ACTIVA', current_date - 47, (current_date - 47 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 286 Iván Suárez: 2 membresía(s), ninguna activa
    (681, 286, 1, 'VENCIDA', current_date - 508, (current_date - 508 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (682, 286, 2, 'VENCIDA', current_date - 475, (current_date - 475 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 287 Lorena Ruiz: 4 membresía(s), ninguna activa
    (683, 287, 1, 'VENCIDA', current_date - 265, (current_date - 265 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (684, 287, 1, 'VENCIDA', current_date - 233, (current_date - 233 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (685, 287, 1, 'VENCIDA', current_date - 130, (current_date - 130 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (686, 287, 1, 'VENCIDA', current_date - 96, (current_date - 96 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 288 Lorena Buitrago: 2 membresía(s), 1 activa
    (687, 288, 1, 'VENCIDA', current_date - 395, (current_date - 395 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (688, 288, 3, 'ACTIVA', current_date - 246, (current_date - 246 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 289 Yuliana Ramírez: 2 membresía(s), 1 activa
    (689, 289, 2, 'VENCIDA', current_date - 98, (current_date - 98 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (690, 289, 1, 'ACTIVA', current_date - 5, (current_date - 5 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 290 Ángela Pérez: 4 membresía(s), 1 activa
    (691, 290, 2, 'VENCIDA', current_date - 232, (current_date - 232 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (692, 290, 1, 'VENCIDA', current_date - 140, (current_date - 140 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (693, 290, 2, 'VENCIDA', current_date - 105, (current_date - 105 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (694, 290, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 291 Gabriela Cortés: 1 membresía(s), 1 activa
    (695, 291, 3, 'ACTIVA', current_date - 102, (current_date - 102 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 292 Brayan Restrepo: 3 membresía(s), 1 activa
    (696, 292, 2, 'VENCIDA', current_date - 213, (current_date - 213 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (697, 292, 1, 'VENCIDA', current_date - 117, (current_date - 117 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (698, 292, 3, 'ACTIVA', current_date - 85, (current_date - 85 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 293 Jorge Rincón: 2 membresía(s), 1 activa
    (699, 293, 1, 'VENCIDA', current_date - 275, (current_date - 275 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (700, 293, 3, 'ACTIVA', current_date - 243, (current_date - 243 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 294 Luisa Cortés: 2 membresía(s), 1 activa
    (701, 294, 2, 'VENCIDA', current_date - 265, (current_date - 265 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (702, 294, 3, 'ACTIVA', current_date - 112, (current_date - 112 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 295 Luisa López: 3 membresía(s), 1 activa
    (703, 295, 2, 'VENCIDA', current_date - 294, (current_date - 294 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (704, 295, 2, 'VENCIDA', current_date - 172, (current_date - 172 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (705, 295, 1, 'ACTIVA', current_date - 3, (current_date - 3 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 296 Iván Vargas: 1 membresía(s), 1 activa
    (706, 296, 3, 'ACTIVA', current_date - 313, (current_date - 313 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 297 Viviana Cifuentes: 3 membresía(s), 1 activa
    (707, 297, 1, 'VENCIDA', current_date - 65, (current_date - 65 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (708, 297, 1, 'VENCIDA', current_date - 33, (current_date - 33 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (709, 297, 1, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 298 Carlos Mendoza: 2 membresía(s), ninguna activa
    (710, 298, 2, 'VENCIDA', current_date - 333, (current_date - 333 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (711, 298, 1, 'VENCIDA', current_date - 240, (current_date - 240 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 299 Andrés Moreno: 1 membresía(s), 1 activa
    (712, 299, 2, 'ACTIVA', current_date - 11, (current_date - 11 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 300 Sara Mendoza: 3 membresía(s), 1 activa
    (713, 300, 2, 'VENCIDA', current_date - 157, (current_date - 157 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (714, 300, 1, 'VENCIDA', current_date - 60, (current_date - 60 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (715, 300, 2, 'ACTIVA', current_date - 29, (current_date - 29 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 301 Andrés Suárez: 2 membresía(s), 1 activa
    (716, 301, 1, 'VENCIDA', current_date - 272, (current_date - 272 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (717, 301, 3, 'ACTIVA', current_date - 171, (current_date - 171 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 302 David Romero: 3 membresía(s), 1 activa
    (718, 302, 1, 'VENCIDA', current_date - 514, (current_date - 514 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (719, 302, 2, 'VENCIDA', current_date - 381, (current_date - 381 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (720, 302, 3, 'ACTIVA', current_date - 285, (current_date - 285 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 303 Ricardo Ramírez: 4 membresía(s), ninguna activa
    (721, 303, 2, 'VENCIDA', current_date - 420, (current_date - 420 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (722, 303, 1, 'VENCIDA', current_date - 327, (current_date - 327 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (723, 303, 2, 'VENCIDA', current_date - 207, (current_date - 207 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (724, 303, 2, 'VENCIDA', current_date - 110, (current_date - 110 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 304 Camila Zapata: 2 membresía(s), 1 activa
    (725, 304, 3, 'VENCIDA', current_date - 400, (current_date - 400 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (726, 304, 3, 'ACTIVA', current_date - 31, (current_date - 31 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 305 Luisa Cifuentes: 3 membresía(s), 1 activa
    (727, 305, 3, 'VENCIDA', current_date - 464, (current_date - 464 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (728, 305, 1, 'VENCIDA', current_date - 93, (current_date - 93 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (729, 305, 1, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 306 David Cortés: 4 membresía(s), 1 activa
    (730, 306, 3, 'VENCIDA', current_date - 462, (current_date - 462 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (731, 306, 1, 'VENCIDA', current_date - 94, (current_date - 94 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (732, 306, 1, 'VENCIDA', current_date - 63, (current_date - 63 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (733, 306, 3, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 307 Jhonatan García: 2 membresía(s), 1 activa
    (734, 307, 1, 'VENCIDA', current_date - 218, (current_date - 218 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (735, 307, 2, 'ACTIVA', current_date - 53, (current_date - 53 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 308 Julián Moreno: 2 membresía(s), 1 activa
    (736, 308, 3, 'VENCIDA', current_date - 367, (current_date - 367 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (737, 308, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 309 Sebastián Vargas: 2 membresía(s), 1 activa
    (738, 309, 2, 'VENCIDA', current_date - 111, (current_date - 111 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (739, 309, 1, 'ACTIVA', current_date - 13, (current_date - 13 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 310 Luisa Rojas: 3 membresía(s), 1 activa
    (740, 310, 1, 'VENCIDA', current_date - 134, (current_date - 134 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (741, 310, 1, 'VENCIDA', current_date - 99, (current_date - 99 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (742, 310, 2, 'ACTIVA', current_date - 66, (current_date - 66 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 311 Andrés Suárez: 2 membresía(s), 1 activa
    (743, 311, 1, 'VENCIDA', current_date - 52, (current_date - 52 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (744, 311, 3, 'ACTIVA', current_date - 20, (current_date - 20 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 312 Diana Ospina: 2 membresía(s), ninguna activa
    (745, 312, 1, 'VENCIDA', current_date - 498, (current_date - 498 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (746, 312, 2, 'VENCIDA', current_date - 421, (current_date - 421 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 313 Iván Rodríguez: 1 membresía(s), 1 activa
    (747, 313, 2, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 314 Esteban Díaz: 1 membresía(s), 1 activa
    (748, 314, 3, 'ACTIVA', current_date - 320, (current_date - 320 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 315 Brayan Valencia: 3 membresía(s), 1 activa
    (749, 315, 1, 'VENCIDA', current_date - 368, (current_date - 368 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (750, 315, 1, 'VENCIDA', current_date - 332, (current_date - 332 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (751, 315, 3, 'ACTIVA', current_date - 301, (current_date - 301 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 316 Santiago Cifuentes: 2 membresía(s), 1 activa
    (752, 316, 3, 'VENCIDA', current_date - 390, (current_date - 390 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (753, 316, 2, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 317 Daniel Pérez: 1 membresía(s), ninguna activa
    (754, 317, 1, 'VENCIDA', current_date - 263, (current_date - 263 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 318 Brayan Castaño: 3 membresía(s), 1 activa
    (755, 318, 1, 'VENCIDA', current_date - 374, (current_date - 374 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (756, 318, 1, 'VENCIDA', current_date - 342, (current_date - 342 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (757, 318, 3, 'ACTIVA', current_date - 291, (current_date - 291 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 319 Daniela González: 4 membresía(s), 1 activa
    (758, 319, 2, 'VENCIDA', current_date - 518, (current_date - 518 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (759, 319, 3, 'VENCIDA', current_date - 424, (current_date - 424 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (760, 319, 1, 'VENCIDA', current_date - 55, (current_date - 55 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (761, 319, 2, 'ACTIVA', current_date - 16, (current_date - 16 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 320 Daniela Cortés: 1 membresía(s), ninguna activa
    (762, 320, 2, 'VENCIDA', current_date - 390, (current_date - 390 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 321 Isabella Mejía: 1 membresía(s), ninguna activa
    (763, 321, 1, 'VENCIDA', current_date - 411, (current_date - 411 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 322 Tomás Ospina: 1 membresía(s), 1 activa
    (764, 322, 2, 'ACTIVA', current_date - 70, (current_date - 70 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 323 Santiago Ramírez: 3 membresía(s), ninguna activa
    (765, 323, 1, 'VENCIDA', current_date - 347, (current_date - 347 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (766, 323, 2, 'VENCIDA', current_date - 310, (current_date - 310 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (767, 323, 1, 'VENCIDA', current_date - 217, (current_date - 217 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 324 Brayan Arango: 1 membresía(s), 1 activa
    (768, 324, 3, 'ACTIVA', current_date - 215, (current_date - 215 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 325 Sebastián Vargas: 3 membresía(s), 1 activa
    (769, 325, 1, 'VENCIDA', current_date - 651, (current_date - 651 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (770, 325, 3, 'VENCIDA', current_date - 618, (current_date - 618 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (771, 325, 1, 'ACTIVA', current_date - 24, (current_date - 24 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 326 Diego Arango: 3 membresía(s), 1 activa
    (772, 326, 1, 'VENCIDA', current_date - 93, (current_date - 93 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (773, 326, 1, 'VENCIDA', current_date - 58, (current_date - 58 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (774, 326, 1, 'ACTIVA', current_date, (current_date + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 327 Óscar Herrera: 2 membresía(s), 1 activa
    (775, 327, 3, 'VENCIDA', current_date - 464, (current_date - 464 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (776, 327, 3, 'ACTIVA', current_date - 94, (current_date - 94 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 328 Mariana Torres: 7 membresía(s), 1 activa
    (777, 328, 2, 'VENCIDA', current_date - 529, (current_date - 529 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (778, 328, 1, 'VENCIDA', current_date - 432, (current_date - 432 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (779, 328, 1, 'VENCIDA', current_date - 399, (current_date - 399 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (780, 328, 2, 'VENCIDA', current_date - 366, (current_date - 366 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (781, 328, 1, 'VENCIDA', current_date - 166, (current_date - 166 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (782, 328, 1, 'VENCIDA', current_date - 132, (current_date - 132 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (783, 328, 3, 'ACTIVA', current_date - 95, (current_date - 95 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 329 Alejandro Lozano: 4 membresía(s), 1 activa
    (784, 329, 1, 'VENCIDA', current_date - 103, (current_date - 103 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (785, 329, 1, 'VENCIDA', current_date - 68, (current_date - 68 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (786, 329, 1, 'VENCIDA', current_date - 33, (current_date - 33 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (787, 329, 1, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 330 Gabriela Sánchez: 5 membresía(s), 1 activa
    (788, 330, 2, 'VENCIDA', current_date - 428, (current_date - 428 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (789, 330, 1, 'VENCIDA', current_date - 335, (current_date - 335 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (790, 330, 2, 'VENCIDA', current_date - 302, (current_date - 302 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (791, 330, 2, 'VENCIDA', current_date - 207, (current_date - 207 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (792, 330, 2, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 331 Alejandra Rodríguez: 4 membresía(s), 1 activa
    (793, 331, 2, 'VENCIDA', current_date - 430, (current_date - 430 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (794, 331, 1, 'VENCIDA', current_date - 338, (current_date - 338 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (795, 331, 2, 'VENCIDA', current_date - 303, (current_date - 303 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (796, 331, 3, 'ACTIVA', current_date - 211, (current_date - 211 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 332 Gabriel Mendoza: 2 membresía(s), 1 activa
    (797, 332, 2, 'VENCIDA', current_date - 194, (current_date - 194 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (798, 332, 2, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 333 Ricardo Martínez: 2 membresía(s), 1 activa
    (799, 333, 1, 'VENCIDA', current_date - 68, (current_date - 68 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (800, 333, 2, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 334 Valentina Hernández: 2 membresía(s), 1 activa
    (801, 334, 2, 'VENCIDA', current_date - 145, (current_date - 145 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (802, 334, 2, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 335 Juliana Suárez: 5 membresía(s), 1 activa
    (803, 335, 2, 'VENCIDA', current_date - 474, (current_date - 474 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (804, 335, 1, 'VENCIDA', current_date - 379, (current_date - 379 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (805, 335, 2, 'VENCIDA', current_date - 282, (current_date - 282 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (806, 335, 2, 'VENCIDA', current_date - 165, (current_date - 165 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (807, 335, 3, 'ACTIVA', current_date - 69, (current_date - 69 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 336 Sara López: 3 membresía(s), ninguna activa
    (808, 336, 2, 'VENCIDA', current_date - 588, (current_date - 588 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (809, 336, 1, 'VENCIDA', current_date - 442, (current_date - 442 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (810, 336, 2, 'VENCIDA', current_date - 411, (current_date - 411 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 337 Julián Rojas: 1 membresía(s), 1 activa
    (811, 337, 1, 'ACTIVA', current_date - 22, (current_date - 22 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 338 Lina Vargas: 4 membresía(s), 1 activa
    (812, 338, 2, 'VENCIDA', current_date - 525, (current_date - 525 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (813, 338, 1, 'VENCIDA', current_date - 430, (current_date - 430 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (814, 338, 3, 'VENCIDA', current_date - 393, (current_date - 393 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (815, 338, 1, 'ACTIVA', current_date - 18, (current_date - 18 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 339 Óscar Lozano: 3 membresía(s), 1 activa
    (816, 339, 2, 'VENCIDA', current_date - 272, (current_date - 272 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (817, 339, 1, 'VENCIDA', current_date - 176, (current_date - 176 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (818, 339, 2, 'ACTIVA', current_date - 20, (current_date - 20 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 340 Sara Poveda: 4 membresía(s), 1 activa
    (819, 340, 2, 'VENCIDA', current_date - 519, (current_date - 519 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (820, 340, 1, 'VENCIDA', current_date - 423, (current_date - 423 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (821, 340, 3, 'VENCIDA', current_date - 391, (current_date - 391 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (822, 340, 3, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 341 Ángela Martínez: 3 membresía(s), 1 activa
    (823, 341, 1, 'VENCIDA', current_date - 160, (current_date - 160 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (824, 341, 2, 'VENCIDA', current_date - 124, (current_date - 124 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (825, 341, 3, 'ACTIVA', current_date - 23, (current_date - 23 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 342 Mateo Cárdenas: 1 membresía(s), 1 activa
    (826, 342, 3, 'ACTIVA', current_date - 85, (current_date - 85 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 343 Camilo Buitrago: 1 membresía(s), 1 activa
    (827, 343, 3, 'ACTIVA', current_date - 320, (current_date - 320 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 344 Óscar Hernández: 3 membresía(s), 1 activa
    (828, 344, 2, 'VENCIDA', current_date - 206, (current_date - 206 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (829, 344, 1, 'VENCIDA', current_date - 82, (current_date - 82 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (830, 344, 2, 'ACTIVA', current_date - 45, (current_date - 45 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 345 Santiago Ospina: 4 membresía(s), 1 activa
    (831, 345, 2, 'VENCIDA', current_date - 398, (current_date - 398 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (832, 345, 2, 'VENCIDA', current_date - 300, (current_date - 300 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (833, 345, 2, 'VENCIDA', current_date - 208, (current_date - 208 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (834, 345, 3, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 346 Andrea Zapata: 1 membresía(s), 1 activa
    (835, 346, 3, 'ACTIVA', current_date - 200, (current_date - 200 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    -- miembro 347 Isabella Gutiérrez: 4 membresía(s), 1 activa
    (836, 347, 2, 'VENCIDA', current_date - 209, (current_date - 209 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (837, 347, 1, 'VENCIDA', current_date - 116, (current_date - 116 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (838, 347, 1, 'VENCIDA', current_date - 84, (current_date - 84 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (839, 347, 1, 'ACTIVA', current_date - 2, (current_date - 2 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    -- miembro 348 Diego Díaz: 2 membresía(s), 1 activa
    (840, 348, 2, 'VENCIDA', current_date - 158, (current_date - 158 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (841, 348, 2, 'ACTIVA', current_date, (current_date + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 349 Carlos Parra: 4 membresía(s), 1 activa
    (842, 349, 2, 'VENCIDA', current_date - 167, (current_date - 167 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    (843, 349, 1, 'VENCIDA', current_date - 74, (current_date - 74 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (844, 349, 1, 'VENCIDA', current_date - 40, (current_date - 40 + INTERVAL '1 month' - INTERVAL '1 day')::date),
    (845, 349, 2, 'ACTIVA', current_date - 6, (current_date - 6 + INTERVAL '3 months' - INTERVAL '1 day')::date),
    -- miembro 350 Julián Sánchez: 2 membresía(s), 1 activa
    (846, 350, 3, 'VENCIDA', current_date - 418, (current_date - 418 + INTERVAL '1 year' - INTERVAL '1 day')::date),
    (847, 350, 3, 'ACTIVA', current_date - 1, (current_date - 1 + INTERVAL '1 year' - INTERVAL '1 day')::date);

-- ---------------------------------------------------------------------
-- PAGO  (uno por cada renovación)
-- ---------------------------------------------------------------------

INSERT INTO pago (id_pago, id_miembro, id_metodo_pago, monto, fecha_pago) VALUES
    (1, 7, 2, 90000.00, current_date - 171),  -- membresía 1
    (2, 7, 1, 850000.00, current_date - 137),  -- membresía 2
    (3, 8, 2, 90000.00, current_date - 319),  -- membresía 3
    (4, 8, 3, 850000.00, current_date - 284),  -- membresía 4
    (5, 9, 3, 220000.00, current_date - 484),  -- membresía 5
    (6, 9, 1, 780000.00, current_date - 389),  -- membresía 6
    (7, 10, 3, 765000.00, current_date - 354),  -- membresía 7
    (8, 11, 2, 240000.00, current_date - 343),  -- membresía 8
    (9, 11, 1, 850000.00, current_date - 246),  -- membresía 9
    (10, 12, 1, 240000.00, current_date - 8),  -- membresía 10
    (11, 13, 1, 90000.00, current_date - 264),  -- membresía 11
    (12, 13, 1, 90000.00, current_date - 233),  -- membresía 12
    (13, 13, 1, 240000.00, current_date - 95),  -- membresía 13
    (14, 14, 3, 850000.00, current_date - 280),  -- membresía 14
    (15, 15, 1, 850000.00, current_date - 325),  -- membresía 15
    (16, 16, 3, 220000.00, current_date - 458),  -- membresía 16
    (17, 16, 3, 90000.00, current_date - 365),  -- membresía 17
    (18, 16, 3, 240000.00, current_date - 333),  -- membresía 18
    (19, 16, 3, 90000.00, current_date - 240),  -- membresía 19
    (20, 16, 2, 90000.00, current_date - 203),  -- membresía 20
    (21, 16, 1, 850000.00, current_date - 170),  -- membresía 21
    (22, 17, 1, 90000.00, current_date - 293),  -- membresía 22
    (23, 17, 2, 240000.00, current_date - 262),  -- membresía 23
    (24, 17, 1, 90000.00, current_date - 167),  -- membresía 24
    (25, 17, 1, 240000.00, current_date - 20),  -- membresía 25
    (26, 18, 2, 780000.00, current_date - 504),  -- membresía 26
    (27, 18, 3, 850000.00, current_date - 2),  -- membresía 27
    (28, 19, 1, 780000.00, current_date - 495),  -- membresía 28
    (29, 19, 2, 850000.00, current_date - 126),  -- membresía 29
    (30, 20, 2, 90000.00, current_date - 8),  -- membresía 30
    (31, 21, 1, 90000.00, current_date - 170),  -- membresía 31
    (32, 21, 1, 90000.00, current_date - 61),  -- membresía 32
    (33, 21, 1, 90000.00, current_date - 2),  -- membresía 33
    (34, 22, 1, 240000.00, current_date - 143),  -- membresía 34
    (35, 22, 1, 240000.00, current_date - 8),  -- membresía 35
    (36, 23, 1, 780000.00, current_date - 435),  -- membresía 36
    (37, 23, 3, 850000.00, current_date - 20),  -- membresía 37
    (38, 24, 2, 90000.00, current_date - 218),  -- membresía 38
    (39, 24, 2, 90000.00, current_date - 182),  -- membresía 39
    (40, 24, 2, 240000.00, current_date - 149),  -- membresía 40
    (41, 24, 3, 850000.00, current_date - 2),  -- membresía 41
    (42, 25, 1, 240000.00, current_date - 47),  -- membresía 42
    (43, 26, 1, 90000.00, current_date - 155),  -- membresía 43
    (44, 26, 3, 240000.00, current_date),  -- membresía 44
    (45, 27, 1, 216000.00, current_date - 47),  -- membresía 45
    (46, 28, 1, 90000.00, current_date - 191),  -- membresía 46
    (47, 28, 3, 240000.00, current_date - 160),  -- membresía 47
    (48, 28, 1, 240000.00, current_date - 68),  -- membresía 48
    (49, 29, 1, 220000.00, current_date - 410),  -- membresía 49
    (50, 29, 2, 850000.00, current_date - 312),  -- membresía 50
    (51, 30, 1, 80000.00, current_date - 409),  -- membresía 51
    (52, 30, 3, 780000.00, current_date - 375),  -- membresía 52
    (53, 31, 2, 90000.00, current_date - 170),  -- membresía 53
    (54, 31, 3, 240000.00, current_date - 133),  -- membresía 54
    (55, 31, 1, 765000.00, current_date - 2),  -- membresía 55
    (56, 32, 2, 90000.00, current_date - 45),  -- membresía 56
    (57, 32, 2, 850000.00, current_date - 3),  -- membresía 57
    (58, 33, 3, 80000.00, current_date - 509),  -- membresía 58
    (59, 33, 1, 80000.00, current_date - 478),  -- membresía 59
    (60, 33, 1, 80000.00, current_date - 442),  -- membresía 60
    (61, 33, 2, 780000.00, current_date - 410),  -- membresía 61
    (62, 33, 1, 850000.00, current_date),  -- membresía 62
    (63, 34, 1, 216000.00, current_date - 52),  -- membresía 63
    (64, 35, 1, 90000.00, current_date - 197),  -- membresía 64
    (65, 35, 1, 90000.00, current_date - 163),  -- membresía 65
    (66, 35, 3, 240000.00, current_date - 128),  -- membresía 66
    (67, 35, 2, 90000.00, current_date - 32),  -- membresía 67
    (68, 35, 3, 90000.00, current_date),  -- membresía 68
    (69, 36, 3, 90000.00, current_date - 120),  -- membresía 69
    (70, 36, 1, 850000.00, current_date - 85),  -- membresía 70
    (71, 37, 1, 240000.00, current_date - 144),  -- membresía 71
    (72, 37, 3, 240000.00, current_date - 49),  -- membresía 72
    (73, 38, 1, 90000.00, current_date - 13),  -- membresía 73
    (74, 39, 3, 90000.00, current_date - 245),  -- membresía 74
    (75, 39, 1, 90000.00, current_date - 209),  -- membresía 75
    (76, 39, 2, 90000.00, current_date - 175),  -- membresía 76
    (77, 39, 1, 850000.00, current_date - 142),  -- membresía 77
    (78, 40, 1, 780000.00, current_date - 444),  -- membresía 78
    (79, 40, 1, 240000.00, current_date - 75),  -- membresía 79
    (80, 41, 1, 240000.00, current_date - 146),  -- membresía 80
    (81, 41, 1, 240000.00, current_date - 48),  -- membresía 81
    (82, 42, 1, 240000.00, current_date - 146),  -- membresía 82
    (83, 42, 1, 90000.00, current_date - 51),  -- membresía 83
    (84, 42, 2, 850000.00, current_date - 17),  -- membresía 84
    (85, 43, 2, 90000.00, current_date - 235),  -- membresía 85
    (86, 43, 1, 240000.00, current_date - 200),  -- membresía 86
    (87, 44, 3, 90000.00, current_date - 277),  -- membresía 87
    (88, 44, 3, 90000.00, current_date - 245),  -- membresía 88
    (89, 44, 3, 90000.00, current_date - 214),  -- membresía 89
    (90, 44, 2, 850000.00, current_date - 39),  -- membresía 90
    (91, 45, 1, 220000.00, current_date - 424),  -- membresía 91
    (92, 45, 1, 850000.00, current_date - 328),  -- membresía 92
    (93, 46, 2, 90000.00, current_date - 22),  -- membresía 93
    (94, 47, 2, 220000.00, current_date - 368),  -- membresía 94
    (95, 47, 2, 850000.00, current_date - 275),  -- membresía 95
    (96, 48, 3, 72000.00, current_date - 368),  -- membresía 96
    (97, 48, 1, 850000.00, current_date - 332),  -- membresía 97
    (98, 49, 2, 240000.00, current_date - 310),  -- membresía 98
    (99, 49, 3, 216000.00, current_date - 217),  -- membresía 99
    (100, 49, 2, 850000.00, current_date - 122),  -- membresía 100
    (101, 50, 2, 80000.00, current_date - 519),  -- membresía 101
    (102, 50, 1, 80000.00, current_date - 487),  -- membresía 102
    (103, 50, 1, 80000.00, current_date - 454),  -- membresía 103
    (104, 50, 1, 240000.00, current_date - 339),  -- membresía 104
    (105, 51, 1, 80000.00, current_date - 409),  -- membresía 105
    (106, 51, 1, 80000.00, current_date - 373),  -- membresía 106
    (107, 51, 1, 90000.00, current_date - 272),  -- membresía 107
    (108, 51, 2, 90000.00, current_date - 236),  -- membresía 108
    (109, 51, 3, 90000.00, current_date - 203),  -- membresía 109
    (110, 51, 1, 240000.00, current_date - 172),  -- membresía 110
    (111, 51, 1, 81000.00, current_date - 74),  -- membresía 111
    (112, 51, 3, 850000.00, current_date - 38),  -- membresía 112
    (113, 52, 3, 850000.00, current_date - 85),  -- membresía 113
    (114, 53, 1, 90000.00, current_date - 24),  -- membresía 114
    (115, 54, 2, 80000.00, current_date - 489),  -- membresía 115
    (116, 54, 1, 780000.00, current_date - 452),  -- membresía 116
    (117, 54, 2, 850000.00, current_date - 82),  -- membresía 117
    (118, 55, 2, 220000.00, current_date - 399),  -- membresía 118
    (119, 55, 1, 240000.00, current_date - 306),  -- membresía 119
    (120, 56, 2, 220000.00, current_date - 379),  -- membresía 120
    (121, 56, 1, 240000.00, current_date - 188),  -- membresía 121
    (122, 56, 1, 90000.00, current_date - 93),  -- membresía 122
    (123, 56, 3, 240000.00, current_date - 3),  -- membresía 123
    (124, 57, 3, 90000.00, current_date - 6),  -- membresía 124
    (125, 58, 1, 240000.00, current_date - 282),  -- membresía 125
    (126, 58, 2, 240000.00, current_date - 189),  -- membresía 126
    (127, 58, 3, 240000.00, current_date - 9),  -- membresía 127
    (128, 59, 1, 240000.00, current_date - 188),  -- membresía 128
    (129, 59, 2, 850000.00, current_date - 90),  -- membresía 129
    (130, 60, 3, 80000.00, current_date - 447),  -- membresía 130
    (131, 60, 2, 80000.00, current_date - 395),  -- membresía 131
    (132, 60, 2, 90000.00, current_date - 261),  -- membresía 132
    (133, 60, 1, 90000.00, current_date - 22),  -- membresía 133
    (134, 61, 3, 240000.00, current_date - 18),  -- membresía 134
    (135, 62, 3, 90000.00, current_date - 105),  -- membresía 135
    (136, 62, 2, 90000.00, current_date - 2),  -- membresía 136
    (137, 63, 3, 780000.00, current_date - 455),  -- membresía 137
    (138, 63, 1, 850000.00, current_date - 78),  -- membresía 138
    (139, 64, 1, 220000.00, current_date - 519),  -- membresía 139
    (140, 64, 1, 80000.00, current_date - 427),  -- membresía 140
    (141, 64, 3, 220000.00, current_date - 394),  -- membresía 141
    (142, 64, 3, 765000.00, current_date - 173),  -- membresía 142
    (143, 65, 1, 240000.00, current_date - 134),  -- membresía 143
    (144, 65, 3, 90000.00, current_date - 42),  -- membresía 144
    (145, 65, 1, 90000.00, current_date - 5),  -- membresía 145
    (146, 66, 2, 90000.00, current_date - 248),  -- membresía 146
    (147, 66, 2, 90000.00, current_date - 211),  -- membresía 147
    (148, 66, 2, 81000.00, current_date - 177),  -- membresía 148
    (149, 66, 3, 240000.00, current_date - 142),  -- membresía 149
    (150, 67, 1, 780000.00, current_date - 452),  -- membresía 150
    (151, 67, 1, 850000.00, current_date - 86),  -- membresía 151
    (152, 68, 1, 240000.00, current_date - 300),  -- membresía 152
    (153, 68, 1, 850000.00, current_date - 208),  -- membresía 153
    (154, 69, 1, 850000.00, current_date - 236),  -- membresía 154
    (155, 70, 2, 780000.00, current_date - 540),  -- membresía 155
    (156, 70, 3, 240000.00, current_date - 173),  -- membresía 156
    (157, 71, 1, 90000.00, current_date - 102),  -- membresía 157
    (158, 71, 1, 850000.00, current_date - 71),  -- membresía 158
    (159, 72, 3, 90000.00, current_date - 22),  -- membresía 159
    (160, 73, 1, 216000.00, current_date - 330),  -- membresía 160
    (161, 73, 1, 240000.00, current_date - 232),  -- membresía 161
    (162, 73, 2, 850000.00, current_date - 119),  -- membresía 162
    (163, 74, 1, 780000.00, current_date - 534),  -- membresía 163
    (164, 74, 2, 240000.00, current_date - 114),  -- membresía 164
    (165, 74, 3, 850000.00, current_date - 22),  -- membresía 165
    (166, 75, 2, 220000.00, current_date - 469),  -- membresía 166
    (167, 75, 3, 80000.00, current_date - 376),  -- membresía 167
    (168, 75, 3, 850000.00, current_date - 286),  -- membresía 168
    (169, 76, 1, 90000.00, current_date - 284),  -- membresía 169
    (170, 76, 2, 90000.00, current_date - 253),  -- membresía 170
    (171, 76, 2, 90000.00, current_date - 192),  -- membresía 171
    (172, 76, 2, 81000.00, current_date - 160),  -- membresía 172
    (173, 76, 2, 90000.00, current_date - 126),  -- membresía 173
    (174, 77, 2, 850000.00, current_date - 347),  -- membresía 174
    (175, 78, 1, 80000.00, current_date - 471),  -- membresía 175
    (176, 78, 2, 220000.00, current_date - 435),  -- membresía 176
    (177, 78, 1, 90000.00, current_date - 342),  -- membresía 177
    (178, 78, 3, 850000.00, current_date - 226),  -- membresía 178
    (179, 79, 3, 90000.00, current_date - 265),  -- membresía 179
    (180, 79, 1, 81000.00, current_date - 120),  -- membresía 180
    (181, 79, 2, 90000.00, current_date - 79),  -- membresía 181
    (182, 79, 2, 240000.00, current_date - 22),  -- membresía 182
    (183, 80, 1, 90000.00, current_date - 31),  -- membresía 183
    (184, 80, 1, 90000.00, current_date),  -- membresía 184
    (185, 81, 1, 850000.00, current_date - 239),  -- membresía 185
    (186, 82, 2, 240000.00, current_date - 141),  -- membresía 186
    (187, 82, 1, 850000.00, current_date - 47),  -- membresía 187
    (188, 83, 1, 240000.00, current_date - 231),  -- membresía 188
    (189, 83, 1, 90000.00, current_date - 112),  -- membresía 189
    (190, 83, 2, 765000.00, current_date - 81),  -- membresía 190
    (191, 84, 2, 240000.00, current_date - 125),  -- membresía 191
    (192, 84, 3, 240000.00, current_date - 21),  -- membresía 192
    (193, 85, 2, 240000.00, current_date - 182),  -- membresía 193
    (194, 85, 2, 90000.00, current_date - 3),  -- membresía 194
    (195, 86, 3, 216000.00, current_date - 305),  -- membresía 195
    (196, 87, 2, 702000.00, current_date - 497),  -- membresía 196
    (197, 87, 3, 240000.00, current_date),  -- membresía 197
    (198, 88, 1, 90000.00, current_date - 172),  -- membresía 198
    (199, 88, 2, 240000.00, current_date - 135),  -- membresía 199
    (200, 88, 2, 216000.00, current_date - 3),  -- membresía 200
    (201, 89, 2, 90000.00, current_date - 51),  -- membresía 201
    (202, 89, 1, 850000.00, current_date - 18),  -- membresía 202
    (203, 90, 3, 80000.00, current_date - 445),  -- membresía 203
    (204, 90, 2, 220000.00, current_date - 410),  -- membresía 204
    (205, 90, 1, 240000.00, current_date - 278),  -- membresía 205
    (206, 90, 1, 850000.00, current_date - 186),  -- membresía 206
    (207, 91, 2, 240000.00, current_date - 246),  -- membresía 207
    (208, 91, 1, 90000.00, current_date - 151),  -- membresía 208
    (209, 91, 2, 90000.00, current_date - 119),  -- membresía 209
    (210, 91, 3, 90000.00, current_date - 10),  -- membresía 210
    (211, 92, 3, 240000.00, current_date - 150),  -- membresía 211
    (212, 92, 1, 90000.00, current_date - 53),  -- membresía 212
    (213, 92, 1, 850000.00, current_date - 18),  -- membresía 213
    (214, 93, 2, 780000.00, current_date - 418),  -- membresía 214
    (215, 93, 3, 90000.00, current_date - 49),  -- membresía 215
    (216, 93, 3, 240000.00, current_date - 3),  -- membresía 216
    (217, 94, 3, 90000.00, current_date - 237),  -- membresía 217
    (218, 94, 2, 90000.00, current_date - 178),  -- membresía 218
    (219, 94, 1, 90000.00, current_date - 147),  -- membresía 219
    (220, 94, 2, 81000.00, current_date - 114),  -- membresía 220
    (221, 94, 1, 90000.00, current_date - 77),  -- membresía 221
    (222, 94, 2, 240000.00, current_date - 43),  -- membresía 222
    (223, 95, 2, 90000.00, current_date - 353),  -- membresía 223
    (224, 95, 1, 240000.00, current_date - 295),  -- membresía 224
    (225, 95, 1, 240000.00, current_date - 200),  -- membresía 225
    (226, 95, 3, 90000.00, current_date - 3),  -- membresía 226
    (227, 96, 1, 90000.00, current_date - 51),  -- membresía 227
    (228, 96, 2, 240000.00, current_date - 17),  -- membresía 228
    (229, 97, 2, 240000.00, current_date - 310),  -- membresía 229
    (230, 97, 1, 850000.00, current_date - 212),  -- membresía 230
    (231, 98, 2, 780000.00, current_date - 432),  -- membresía 231
    (232, 98, 1, 90000.00, current_date - 23),  -- membresía 232
    (233, 99, 2, 780000.00, current_date - 539),  -- membresía 233
    (234, 99, 1, 90000.00, current_date - 167),  -- membresía 234
    (235, 100, 1, 220000.00, current_date - 476),  -- membresía 235
    (236, 100, 1, 220000.00, current_date - 379),  -- membresía 236
    (237, 100, 3, 850000.00, current_date - 142),  -- membresía 237
    (238, 101, 1, 90000.00, current_date - 346),  -- membresía 238
    (239, 102, 1, 850000.00, current_date - 19),  -- membresía 239
    (240, 103, 3, 240000.00, current_date - 231),  -- membresía 240
    (241, 103, 1, 850000.00, current_date - 1),  -- membresía 241
    (242, 104, 2, 850000.00, current_date - 306),  -- membresía 242
    (243, 105, 2, 90000.00, current_date - 263),  -- membresía 243
    (244, 106, 2, 850000.00, current_date - 16),  -- membresía 244
    (245, 107, 2, 780000.00, current_date - 435),  -- membresía 245
    (246, 108, 3, 850000.00, current_date - 48),  -- membresía 246
    (247, 109, 3, 780000.00, current_date - 419),  -- membresía 247
    (248, 109, 1, 850000.00, current_date - 53),  -- membresía 248
    (249, 110, 1, 240000.00, current_date - 181),  -- membresía 249
    (250, 110, 1, 90000.00, current_date - 87),  -- membresía 250
    (251, 110, 2, 240000.00, current_date - 54),  -- membresía 251
    (252, 111, 1, 850000.00, current_date - 134),  -- membresía 252
    (253, 112, 1, 90000.00, current_date - 284),  -- membresía 253
    (254, 112, 1, 90000.00, current_date - 250),  -- membresía 254
    (255, 112, 1, 850000.00, current_date - 216),  -- membresía 255
    (256, 113, 2, 90000.00, current_date - 213),  -- membresía 256
    (257, 113, 1, 90000.00, current_date - 142),  -- membresía 257
    (258, 114, 1, 780000.00, current_date - 419),  -- membresía 258
    (259, 115, 1, 240000.00, current_date - 171),  -- membresía 259
    (260, 115, 1, 850000.00, current_date - 3),  -- membresía 260
    (261, 116, 3, 780000.00, current_date - 473),  -- membresía 261
    (262, 116, 2, 90000.00, current_date - 101),  -- membresía 262
    (263, 116, 1, 90000.00, current_date - 35),  -- membresía 263
    (264, 116, 1, 90000.00, current_date - 1),  -- membresía 264
    (265, 117, 1, 240000.00, current_date - 288),  -- membresía 265
    (266, 117, 1, 90000.00, current_date - 124),  -- membresía 266
    (267, 117, 2, 90000.00, current_date - 87),  -- membresía 267
    (268, 117, 3, 90000.00, current_date - 1),  -- membresía 268
    (269, 118, 2, 240000.00, current_date - 72),  -- membresía 269
    (270, 119, 1, 850000.00, current_date - 313),  -- membresía 270
    (271, 120, 1, 90000.00, current_date - 226),  -- membresía 271
    (272, 120, 1, 240000.00, current_date - 175),  -- membresía 272
    (273, 120, 1, 90000.00, current_date - 81),  -- membresía 273
    (274, 121, 2, 780000.00, current_date - 400),  -- membresía 274
    (275, 122, 1, 72000.00, current_date - 479),  -- membresía 275
    (276, 123, 1, 90000.00, current_date - 13),  -- membresía 276
    (277, 124, 3, 220000.00, current_date - 474),  -- membresía 277
    (278, 124, 1, 240000.00, current_date - 271),  -- membresía 278
    (279, 124, 3, 240000.00, current_date - 179),  -- membresía 279
    (280, 124, 2, 90000.00, current_date - 25),  -- membresía 280
    (281, 125, 3, 850000.00, current_date - 288),  -- membresía 281
    (282, 126, 1, 220000.00, current_date - 384),  -- membresía 282
    (283, 126, 1, 90000.00, current_date - 289),  -- membresía 283
    (284, 126, 3, 850000.00, current_date - 256),  -- membresía 284
    (285, 127, 3, 240000.00, current_date - 282),  -- membresía 285
    (286, 127, 2, 850000.00, current_date - 186),  -- membresía 286
    (287, 128, 2, 850000.00, current_date - 73),  -- membresía 287
    (288, 129, 3, 90000.00, current_date - 23),  -- membresía 288
    (289, 130, 1, 80000.00, current_date - 385),  -- membresía 289
    (290, 130, 1, 850000.00, current_date - 219),  -- membresía 290
    (291, 131, 1, 780000.00, current_date - 549),  -- membresía 291
    (292, 132, 3, 850000.00, current_date - 336),  -- membresía 292
    (293, 133, 2, 90000.00, current_date - 17),  -- membresía 293
    (294, 134, 1, 780000.00, current_date - 520),  -- membresía 294
    (295, 134, 2, 240000.00, current_date - 131),  -- membresía 295
    (296, 134, 1, 216000.00, current_date),  -- membresía 296
    (297, 135, 3, 850000.00, current_date - 3),  -- membresía 297
    (298, 136, 3, 90000.00, current_date - 218),  -- membresía 298
    (299, 136, 2, 90000.00, current_date - 187),  -- membresía 299
    (300, 136, 2, 240000.00, current_date - 150),  -- membresía 300
    (301, 136, 3, 90000.00, current_date - 58),  -- membresía 301
    (302, 137, 2, 220000.00, current_date - 424),  -- membresía 302
    (303, 137, 3, 850000.00, current_date - 200),  -- membresía 303
    (304, 138, 1, 90000.00, current_date - 91),  -- membresía 304
    (305, 138, 1, 850000.00, current_date - 2),  -- membresía 305
    (306, 139, 1, 240000.00, current_date - 328),  -- membresía 306
    (307, 139, 1, 850000.00, current_date - 231),  -- membresía 307
    (308, 140, 3, 72000.00, current_date - 441),  -- membresía 308
    (309, 140, 2, 780000.00, current_date - 407),  -- membresía 309
    (310, 140, 2, 90000.00, current_date - 40),  -- membresía 310
    (311, 140, 1, 240000.00, current_date - 6),  -- membresía 311
    (312, 141, 1, 90000.00, current_date - 186),  -- membresía 312
    (313, 141, 1, 90000.00, current_date - 151),  -- membresía 313
    (314, 141, 2, 240000.00, current_date - 120),  -- membresía 314
    (315, 141, 1, 240000.00, current_date - 22),  -- membresía 315
    (316, 142, 1, 220000.00, current_date - 564),  -- membresía 316
    (317, 143, 1, 90000.00, current_date - 306),  -- membresía 317
    (318, 143, 2, 90000.00, current_date - 145),  -- membresía 318
    (319, 143, 2, 90000.00, current_date),  -- membresía 319
    (320, 144, 2, 90000.00, current_date - 160),  -- membresía 320
    (321, 144, 1, 240000.00, current_date - 126),  -- membresía 321
    (322, 144, 2, 240000.00, current_date - 29),  -- membresía 322
    (323, 145, 1, 240000.00, current_date - 355),  -- membresía 323
    (324, 145, 1, 240000.00, current_date - 262),  -- membresía 324
    (325, 145, 3, 240000.00, current_date - 167),  -- membresía 325
    (326, 145, 1, 240000.00, current_date - 70),  -- membresía 326
    (327, 146, 1, 90000.00, current_date - 260),  -- membresía 327
    (328, 146, 1, 90000.00, current_date - 158),  -- membresía 328
    (329, 146, 1, 90000.00, current_date - 122),  -- membresía 329
    (330, 146, 1, 765000.00, current_date),  -- membresía 330
    (331, 147, 2, 90000.00, current_date - 9),  -- membresía 331
    (332, 148, 2, 220000.00, current_date - 621),  -- membresía 332
    (333, 148, 2, 780000.00, current_date - 494),  -- membresía 333
    (334, 148, 2, 90000.00, current_date - 22),  -- membresía 334
    (335, 149, 3, 780000.00, current_date - 465),  -- membresía 335
    (336, 150, 2, 220000.00, current_date - 425),  -- membresía 336
    (337, 150, 3, 850000.00, current_date - 332),  -- membresía 337
    (338, 151, 3, 780000.00, current_date - 482),  -- membresía 338
    (339, 151, 1, 240000.00, current_date - 115),  -- membresía 339
    (340, 151, 1, 240000.00, current_date - 23),  -- membresía 340
    (341, 152, 1, 850000.00, current_date - 83),  -- membresía 341
    (342, 153, 1, 90000.00, current_date - 87),  -- membresía 342
    (343, 153, 2, 90000.00, current_date),  -- membresía 343
    (344, 154, 1, 216000.00, current_date - 17),  -- membresía 344
    (345, 155, 2, 81000.00, current_date - 315),  -- membresía 345
    (346, 155, 1, 850000.00, current_date - 177),  -- membresía 346
    (347, 156, 2, 765000.00, current_date - 107),  -- membresía 347
    (348, 157, 1, 240000.00, current_date - 322),  -- membresía 348
    (349, 157, 1, 90000.00, current_date - 153),  -- membresía 349
    (350, 158, 3, 90000.00, current_date - 25),  -- membresía 350
    (351, 159, 3, 198000.00, current_date - 552),  -- membresía 351
    (352, 159, 1, 780000.00, current_date - 431),  -- membresía 352
    (353, 159, 1, 90000.00, current_date - 59),  -- membresía 353
    (354, 160, 3, 240000.00, current_date - 255),  -- membresía 354
    (355, 160, 2, 90000.00, current_date - 40),  -- membresía 355
    (356, 160, 1, 90000.00, current_date - 3),  -- membresía 356
    (357, 161, 3, 90000.00, current_date - 315),  -- membresía 357
    (358, 162, 1, 780000.00, current_date - 536),  -- membresía 358
    (359, 162, 2, 90000.00, current_date - 167),  -- membresía 359
    (360, 162, 1, 240000.00, current_date - 77),  -- membresía 360
    (361, 163, 2, 220000.00, current_date - 415),  -- membresía 361
    (362, 163, 1, 216000.00, current_date - 320),  -- membresía 362
    (363, 164, 3, 850000.00, current_date - 342),  -- membresía 363
    (364, 165, 1, 90000.00, current_date - 234),  -- membresía 364
    (365, 165, 3, 240000.00, current_date - 167),  -- membresía 365
    (366, 165, 3, 850000.00, current_date - 73),  -- membresía 366
    (367, 166, 3, 780000.00, current_date - 490),  -- membresía 367
    (368, 166, 1, 850000.00, current_date - 118),  -- membresía 368
    (369, 167, 1, 90000.00, current_date - 117),  -- membresía 369
    (370, 167, 3, 90000.00, current_date - 85),  -- membresía 370
    (371, 167, 2, 90000.00, current_date - 51),  -- membresía 371
    (372, 167, 3, 240000.00, current_date - 15),  -- membresía 372
    (373, 168, 1, 702000.00, current_date - 597),  -- membresía 373
    (374, 168, 3, 90000.00, current_date - 229),  -- membresía 374
    (375, 168, 1, 90000.00, current_date - 22),  -- membresía 375
    (376, 169, 2, 90000.00, current_date - 162),  -- membresía 376
    (377, 169, 1, 90000.00, current_date - 130),  -- membresía 377
    (378, 169, 3, 850000.00, current_date - 94),  -- membresía 378
    (379, 170, 1, 90000.00, current_date - 261),  -- membresía 379
    (380, 170, 1, 90000.00, current_date - 145),  -- membresía 380
    (381, 170, 1, 90000.00, current_date - 32),  -- membresía 381
    (382, 170, 3, 90000.00, current_date - 1),  -- membresía 382
    (383, 171, 1, 240000.00, current_date - 98),  -- membresía 383
    (384, 171, 3, 240000.00, current_date - 2),  -- membresía 384
    (385, 172, 3, 216000.00, current_date - 20),  -- membresía 385
    (386, 173, 3, 220000.00, current_date - 482),  -- membresía 386
    (387, 173, 1, 220000.00, current_date - 386),  -- membresía 387
    (388, 173, 1, 90000.00, current_date - 23),  -- membresía 388
    (389, 174, 3, 90000.00, current_date - 63),  -- membresía 389
    (390, 174, 1, 90000.00, current_date - 1),  -- membresía 390
    (391, 175, 2, 240000.00, current_date - 125),  -- membresía 391
    (392, 175, 2, 90000.00, current_date - 22),  -- membresía 392
    (393, 176, 2, 90000.00, current_date - 188),  -- membresía 393
    (394, 176, 2, 90000.00, current_date - 151),  -- membresía 394
    (395, 176, 2, 240000.00, current_date - 77),  -- membresía 395
    (396, 177, 3, 220000.00, current_date - 386),  -- membresía 396
    (397, 177, 3, 90000.00, current_date - 294),  -- membresía 397
    (398, 177, 1, 240000.00, current_date - 137),  -- membresía 398
    (399, 177, 1, 240000.00, current_date - 17),  -- membresía 399
    (400, 178, 3, 240000.00, current_date - 202),  -- membresía 400
    (401, 178, 3, 90000.00, current_date - 3),  -- membresía 401
    (402, 179, 1, 780000.00, current_date - 506),  -- membresía 402
    (403, 179, 1, 90000.00, current_date - 139),  -- membresía 403
    (404, 179, 1, 216000.00, current_date - 55),  -- membresía 404
    (405, 180, 3, 240000.00, current_date - 23),  -- membresía 405
    (406, 181, 1, 240000.00, current_date - 362),  -- membresía 406
    (407, 181, 2, 850000.00, current_date - 264),  -- membresía 407
    (408, 182, 1, 780000.00, current_date - 404),  -- membresía 408
    (409, 182, 3, 850000.00, current_date - 2),  -- membresía 409
    (410, 183, 1, 90000.00, current_date - 186),  -- membresía 410
    (411, 183, 1, 90000.00, current_date - 151),  -- membresía 411
    (412, 183, 1, 90000.00, current_date - 120),  -- membresía 412
    (413, 183, 2, 90000.00, current_date - 87),  -- membresía 413
    (414, 183, 1, 90000.00, current_date - 53),  -- membresía 414
    (415, 183, 2, 90000.00, current_date - 3),  -- membresía 415
    (416, 184, 2, 240000.00, current_date - 336),  -- membresía 416
    (417, 184, 3, 90000.00, current_date - 131),  -- membresía 417
    (418, 184, 1, 216000.00, current_date - 99),  -- membresía 418
    (419, 184, 2, 240000.00, current_date - 3),  -- membresía 419
    (420, 185, 2, 198000.00, current_date - 470),  -- membresía 420
    (421, 185, 1, 220000.00, current_date - 372),  -- membresía 421
    (422, 185, 1, 765000.00, current_date - 279),  -- membresía 422
    (423, 186, 1, 240000.00, current_date - 159),  -- membresía 423
    (424, 186, 2, 90000.00, current_date - 63),  -- membresía 424
    (425, 186, 1, 240000.00, current_date - 28),  -- membresía 425
    (426, 187, 1, 850000.00, current_date - 8),  -- membresía 426
    (427, 188, 3, 780000.00, current_date - 590),  -- membresía 427
    (428, 189, 2, 240000.00, current_date - 329),  -- membresía 428
    (429, 189, 1, 850000.00, current_date - 233),  -- membresía 429
    (430, 190, 2, 780000.00, current_date - 379),  -- membresía 430
    (431, 190, 2, 850000.00, current_date - 13),  -- membresía 431
    (432, 191, 1, 90000.00, current_date - 266),  -- membresía 432
    (433, 192, 1, 90000.00, current_date - 291),  -- membresía 433
    (434, 192, 3, 90000.00, current_date - 258),  -- membresía 434
    (435, 192, 3, 850000.00, current_date - 99),  -- membresía 435
    (436, 193, 2, 220000.00, current_date - 514),  -- membresía 436
    (437, 193, 2, 780000.00, current_date - 419),  -- membresía 437
    (438, 193, 1, 90000.00, current_date - 52),  -- membresía 438
    (439, 193, 1, 240000.00, current_date - 18),  -- membresía 439
    (440, 194, 1, 81000.00, current_date - 25),  -- membresía 440
    (441, 195, 2, 90000.00, current_date - 14),  -- membresía 441
    (442, 196, 1, 240000.00, current_date - 196),  -- membresía 442
    (443, 196, 1, 90000.00, current_date - 99),  -- membresía 443
    (444, 196, 1, 90000.00, current_date - 65),  -- membresía 444
    (445, 196, 1, 90000.00, current_date - 31),  -- membresía 445
    (446, 196, 1, 90000.00, current_date),  -- membresía 446
    (447, 197, 3, 90000.00, current_date - 130),  -- membresía 447
    (448, 197, 1, 240000.00, current_date),  -- membresía 448
    (449, 198, 1, 780000.00, current_date - 414),  -- membresía 449
    (450, 198, 2, 90000.00, current_date - 46),  -- membresía 450
    (451, 198, 1, 240000.00, current_date),  -- membresía 451
    (452, 199, 3, 240000.00, current_date - 92),  -- membresía 452
    (453, 199, 1, 240000.00, current_date),  -- membresía 453
    (454, 200, 2, 240000.00, current_date - 135),  -- membresía 454
    (455, 200, 2, 765000.00, current_date - 39),  -- membresía 455
    (456, 201, 2, 240000.00, current_date - 42),  -- membresía 456
    (457, 202, 2, 850000.00, current_date - 339),  -- membresía 457
    (458, 203, 1, 220000.00, current_date - 423),  -- membresía 458
    (459, 203, 1, 240000.00, current_date - 325),  -- membresía 459
    (460, 203, 1, 240000.00, current_date - 227),  -- membresía 460
    (461, 203, 2, 90000.00, current_date - 130),  -- membresía 461
    (462, 203, 1, 90000.00, current_date - 47),  -- membresía 462
    (463, 204, 2, 90000.00, current_date - 158),  -- membresía 463
    (464, 204, 3, 850000.00, current_date - 124),  -- membresía 464
    (465, 205, 1, 780000.00, current_date - 513),  -- membresía 465
    (466, 205, 2, 240000.00, current_date - 9),  -- membresía 466
    (467, 206, 3, 702000.00, current_date - 511),  -- membresía 467
    (468, 206, 1, 850000.00, current_date - 144),  -- membresía 468
    (469, 207, 1, 81000.00, current_date - 32),  -- membresía 469
    (470, 207, 2, 240000.00, current_date - 1),  -- membresía 470
    (471, 208, 3, 850000.00, current_date - 88),  -- membresía 471
    (472, 209, 1, 240000.00, current_date - 19),  -- membresía 472
    (473, 210, 1, 240000.00, current_date - 105),  -- membresía 473
    (474, 210, 1, 850000.00, current_date - 10),  -- membresía 474
    (475, 211, 2, 220000.00, current_date - 455),  -- membresía 475
    (476, 211, 1, 90000.00, current_date - 358),  -- membresía 476
    (477, 212, 1, 90000.00, current_date - 120),  -- membresía 477
    (478, 212, 1, 90000.00, current_date - 62),  -- membresía 478
    (479, 212, 1, 90000.00, current_date - 24),  -- membresía 479
    (480, 213, 3, 765000.00, current_date - 328),  -- membresía 480
    (481, 214, 3, 90000.00, current_date - 263),  -- membresía 481
    (482, 215, 1, 90000.00, current_date - 360),  -- membresía 482
    (483, 215, 1, 240000.00, current_date - 325),  -- membresía 483
    (484, 215, 2, 240000.00, current_date - 229),  -- membresía 484
    (485, 215, 2, 90000.00, current_date - 35),  -- membresía 485
    (486, 215, 2, 850000.00, current_date - 1),  -- membresía 486
    (487, 216, 1, 90000.00, current_date - 339),  -- membresía 487
    (488, 216, 2, 216000.00, current_date - 302),  -- membresía 488
    (489, 216, 1, 850000.00, current_date - 206),  -- membresía 489
    (490, 217, 3, 198000.00, current_date - 602),  -- membresía 490
    (491, 217, 1, 220000.00, current_date - 510),  -- membresía 491
    (492, 217, 1, 220000.00, current_date - 417),  -- membresía 492
    (493, 217, 2, 240000.00, current_date - 298),  -- membresía 493
    (494, 217, 1, 216000.00, current_date - 201),  -- membresía 494
    (495, 217, 2, 90000.00, current_date - 25),  -- membresía 495
    (496, 218, 2, 90000.00, current_date - 131),  -- membresía 496
    (497, 218, 1, 240000.00, current_date - 60),  -- membresía 497
    (498, 219, 1, 90000.00, current_date - 313),  -- membresía 498
    (499, 219, 2, 850000.00, current_date - 146),  -- membresía 499
    (500, 220, 1, 240000.00, current_date - 179),  -- membresía 500
    (501, 220, 3, 240000.00, current_date),  -- membresía 501
    (502, 221, 3, 240000.00, current_date - 199),  -- membresía 502
    (503, 221, 3, 81000.00, current_date - 83),  -- membresía 503
    (504, 221, 1, 850000.00, current_date - 2),  -- membresía 504
    (505, 222, 3, 850000.00, current_date - 73),  -- membresía 505
    (506, 223, 2, 220000.00, current_date - 452),  -- membresía 506
    (507, 223, 3, 240000.00, current_date - 354),  -- membresía 507
    (508, 223, 2, 90000.00, current_date - 256),  -- membresía 508
    (509, 223, 2, 240000.00, current_date - 222),  -- membresía 509
    (510, 223, 1, 240000.00, current_date - 23),  -- membresía 510
    (511, 224, 2, 90000.00, current_date - 100),  -- membresía 511
    (512, 224, 3, 90000.00, current_date - 3),  -- membresía 512
    (513, 225, 2, 780000.00, current_date - 425),  -- membresía 513
    (514, 225, 1, 850000.00, current_date - 56),  -- membresía 514
    (515, 226, 1, 702000.00, current_date - 435),  -- membresía 515
    (516, 226, 1, 240000.00, current_date - 3),  -- membresía 516
    (517, 227, 1, 240000.00, current_date - 285),  -- membresía 517
    (518, 227, 1, 240000.00, current_date - 188),  -- membresía 518
    (519, 227, 3, 90000.00, current_date - 90),  -- membresía 519
    (520, 227, 1, 240000.00, current_date - 2),  -- membresía 520
    (521, 228, 2, 850000.00, current_date - 305),  -- membresía 521
    (522, 229, 3, 90000.00, current_date - 110),  -- membresía 522
    (523, 229, 1, 240000.00, current_date - 76),  -- membresía 523
    (524, 230, 1, 850000.00, current_date - 86),  -- membresía 524
    (525, 231, 1, 90000.00, current_date - 229),  -- membresía 525
    (526, 231, 1, 90000.00, current_date - 198),  -- membresía 526
    (527, 231, 3, 240000.00, current_date - 167),  -- membresía 527
    (528, 231, 1, 850000.00, current_date - 73),  -- membresía 528
    (529, 232, 1, 90000.00, current_date - 158),  -- membresía 529
    (530, 232, 1, 90000.00, current_date - 127),  -- membresía 530
    (531, 232, 3, 240000.00, current_date - 51),  -- membresía 531
    (532, 233, 1, 220000.00, current_date - 459),  -- membresía 532
    (533, 233, 1, 850000.00, current_date - 250),  -- membresía 533
    (534, 234, 1, 90000.00, current_date - 293),  -- membresía 534
    (535, 234, 1, 90000.00, current_date - 193),  -- membresía 535
    (536, 234, 1, 240000.00, current_date - 39),  -- membresía 536
    (537, 235, 1, 780000.00, current_date - 510),  -- membresía 537
    (538, 235, 1, 850000.00, current_date - 142),  -- membresía 538
    (539, 236, 2, 216000.00, current_date - 242),  -- membresía 539
    (540, 236, 2, 90000.00, current_date - 24),  -- membresía 540
    (541, 237, 3, 80000.00, current_date - 447),  -- membresía 541
    (542, 237, 1, 240000.00, current_date - 340),  -- membresía 542
    (543, 237, 1, 240000.00, current_date - 180),  -- membresía 543
    (544, 237, 3, 90000.00, current_date - 82),  -- membresía 544
    (545, 237, 1, 850000.00, current_date - 46),  -- membresía 545
    (546, 238, 2, 240000.00, current_date - 287),  -- membresía 546
    (547, 238, 1, 90000.00, current_date - 23),  -- membresía 547
    (548, 239, 1, 90000.00, current_date - 89),  -- membresía 548
    (549, 239, 1, 90000.00, current_date - 4),  -- membresía 549
    (550, 240, 1, 81000.00, current_date - 144),  -- membresía 550
    (551, 240, 2, 240000.00, current_date - 59),  -- membresía 551
    (552, 241, 1, 90000.00, current_date - 169),  -- membresía 552
    (553, 241, 3, 90000.00, current_date - 138),  -- membresía 553
    (554, 241, 1, 90000.00, current_date - 51),  -- membresía 554
    (555, 241, 1, 240000.00, current_date - 1),  -- membresía 555
    (556, 242, 1, 90000.00, current_date - 185),  -- membresía 556
    (557, 242, 2, 90000.00, current_date - 152),  -- membresía 557
    (558, 242, 3, 90000.00, current_date - 3),  -- membresía 558
    (559, 243, 1, 90000.00, current_date - 233),  -- membresía 559
    (560, 243, 1, 90000.00, current_date - 178),  -- membresía 560
    (561, 243, 1, 240000.00, current_date - 114),  -- membresía 561
    (562, 243, 3, 765000.00, current_date - 17),  -- membresía 562
    (563, 244, 2, 90000.00, current_date - 294),  -- membresía 563
    (564, 244, 1, 850000.00, current_date - 261),  -- membresía 564
    (565, 245, 1, 81000.00, current_date - 38),  -- membresía 565
    (566, 245, 2, 240000.00, current_date - 1),  -- membresía 566
    (567, 246, 1, 220000.00, current_date - 616),  -- membresía 567
    (568, 246, 1, 780000.00, current_date - 524),  -- membresía 568
    (569, 246, 1, 240000.00, current_date - 156),  -- membresía 569
    (570, 246, 1, 90000.00, current_date - 25),  -- membresía 570
    (571, 247, 1, 850000.00, current_date - 310),  -- membresía 571
    (572, 248, 3, 90000.00, current_date - 287),  -- membresía 572
    (573, 248, 1, 240000.00, current_date - 254),  -- membresía 573
    (574, 248, 2, 90000.00, current_date - 157),  -- membresía 574
    (575, 248, 2, 90000.00, current_date - 10),  -- membresía 575
    (576, 249, 1, 850000.00, current_date - 343),  -- membresía 576
    (577, 250, 1, 220000.00, current_date - 385),  -- membresía 577
    (578, 250, 2, 90000.00, current_date - 291),  -- membresía 578
    (579, 250, 1, 240000.00, current_date - 171),  -- membresía 579
    (580, 250, 3, 850000.00, current_date - 2),  -- membresía 580
    (581, 251, 2, 90000.00, current_date - 154),  -- membresía 581
    (582, 251, 1, 90000.00, current_date - 33),  -- membresía 582
    (583, 251, 1, 90000.00, current_date),  -- membresía 583
    (584, 252, 1, 90000.00, current_date - 104),  -- membresía 584
    (585, 252, 1, 850000.00, current_date - 70),  -- membresía 585
    (586, 253, 1, 240000.00, current_date - 274),  -- membresía 586
    (587, 253, 3, 90000.00, current_date - 151),  -- membresía 587
    (588, 253, 1, 240000.00, current_date - 115),  -- membresía 588
    (589, 254, 3, 80000.00, current_date - 401),  -- membresía 589
    (590, 254, 1, 780000.00, current_date - 367),  -- membresía 590
    (591, 254, 1, 90000.00, current_date),  -- membresía 591
    (592, 255, 1, 240000.00, current_date - 353),  -- membresía 592
    (593, 255, 2, 90000.00, current_date - 223),  -- membresía 593
    (594, 255, 1, 240000.00, current_date - 190),  -- membresía 594
    (595, 255, 3, 240000.00, current_date - 96),  -- membresía 595
    (596, 255, 3, 240000.00, current_date - 1),  -- membresía 596
    (597, 256, 1, 240000.00, current_date - 37),  -- membresía 597
    (598, 257, 1, 90000.00, current_date - 149),  -- membresía 598
    (599, 257, 2, 240000.00, current_date - 115),  -- membresía 599
    (600, 257, 2, 850000.00, current_date - 19),  -- membresía 600
    (601, 258, 3, 220000.00, current_date - 479),  -- membresía 601
    (602, 258, 2, 80000.00, current_date - 384),  -- membresía 602
    (603, 258, 2, 240000.00, current_date - 348),  -- membresía 603
    (604, 258, 1, 216000.00, current_date - 256),  -- membresía 604
    (605, 258, 2, 240000.00, current_date - 159),  -- membresía 605
    (606, 258, 1, 240000.00, current_date - 63),  -- membresía 606
    (607, 259, 1, 780000.00, current_date - 402),  -- membresía 607
    (608, 259, 2, 90000.00, current_date - 25),  -- membresía 608
    (609, 260, 1, 240000.00, current_date - 329),  -- membresía 609
    (610, 260, 3, 90000.00, current_date - 119),  -- membresía 610
    (611, 260, 2, 240000.00, current_date - 50),  -- membresía 611
    (612, 261, 3, 90000.00, current_date - 138),  -- membresía 612
    (613, 261, 2, 90000.00, current_date - 104),  -- membresía 613
    (614, 261, 3, 90000.00, current_date - 73),  -- membresía 614
    (615, 261, 1, 90000.00, current_date - 23),  -- membresía 615
    (616, 262, 3, 80000.00, current_date - 441),  -- membresía 616
    (617, 262, 1, 702000.00, current_date - 370),  -- membresía 617
    (618, 263, 2, 90000.00, current_date - 293),  -- membresía 618
    (619, 263, 2, 240000.00, current_date - 198),  -- membresía 619
    (620, 263, 2, 90000.00, current_date - 103),  -- membresía 620
    (621, 263, 1, 216000.00, current_date - 69),  -- membresía 621
    (622, 264, 1, 80000.00, current_date - 679),  -- membresía 622
    (623, 264, 1, 220000.00, current_date - 642),  -- membresía 623
    (624, 264, 1, 80000.00, current_date - 468),  -- membresía 624
    (625, 264, 3, 780000.00, current_date - 435),  -- membresía 625
    (626, 264, 2, 90000.00, current_date - 23),  -- membresía 626
    (627, 265, 1, 780000.00, current_date - 514),  -- membresía 627
    (628, 266, 3, 90000.00, current_date - 249),  -- membresía 628
    (629, 266, 1, 90000.00, current_date - 213),  -- membresía 629
    (630, 266, 1, 240000.00, current_date - 181),  -- membresía 630
    (631, 266, 3, 90000.00, current_date),  -- membresía 631
    (632, 267, 1, 780000.00, current_date - 467),  -- membresía 632
    (633, 267, 1, 240000.00, current_date - 100),  -- membresía 633
    (634, 267, 3, 850000.00, current_date - 7),  -- membresía 634
    (635, 268, 2, 220000.00, current_date - 515),  -- membresía 635
    (636, 268, 3, 220000.00, current_date - 418),  -- membresía 636
    (637, 268, 2, 90000.00, current_date - 306),  -- membresía 637
    (638, 268, 2, 90000.00, current_date - 271),  -- membresía 638
    (639, 268, 1, 850000.00, current_date - 240),  -- membresía 639
    (640, 269, 3, 240000.00, current_date - 351),  -- membresía 640
    (641, 269, 1, 90000.00, current_date - 222),  -- membresía 641
    (642, 269, 2, 850000.00, current_date - 188),  -- membresía 642
    (643, 270, 3, 240000.00, current_date - 70),  -- membresía 643
    (644, 271, 3, 81000.00, current_date - 220),  -- membresía 644
    (645, 271, 1, 90000.00, current_date - 185),  -- membresía 645
    (646, 271, 2, 240000.00, current_date - 152),  -- membresía 646
    (647, 271, 3, 90000.00, current_date - 59),  -- membresía 647
    (648, 271, 2, 240000.00, current_date - 25),  -- membresía 648
    (649, 272, 3, 90000.00, current_date - 254),  -- membresía 649
    (650, 272, 2, 240000.00, current_date - 218),  -- membresía 650
    (651, 272, 1, 240000.00, current_date - 121),  -- membresía 651
    (652, 272, 1, 240000.00, current_date - 25),  -- membresía 652
    (653, 273, 2, 220000.00, current_date - 584),  -- membresía 653
    (654, 273, 2, 220000.00, current_date - 487),  -- membresía 654
    (655, 273, 3, 702000.00, current_date - 393),  -- membresía 655
    (656, 274, 1, 90000.00, current_date - 206),  -- membresía 656
    (657, 274, 3, 90000.00, current_date - 171),  -- membresía 657
    (658, 274, 2, 216000.00, current_date - 36),  -- membresía 658
    (659, 275, 3, 216000.00, current_date - 19),  -- membresía 659
    (660, 276, 1, 80000.00, current_date - 418),  -- membresía 660
    (661, 276, 3, 220000.00, current_date - 382),  -- membresía 661
    (662, 277, 1, 90000.00, current_date - 274),  -- membresía 662
    (663, 277, 2, 240000.00, current_date - 241),  -- membresía 663
    (664, 277, 1, 850000.00, current_date - 147),  -- membresía 664
    (665, 278, 1, 90000.00, current_date - 189),  -- membresía 665
    (666, 278, 1, 90000.00, current_date - 22),  -- membresía 666
    (667, 279, 3, 780000.00, current_date - 482),  -- membresía 667
    (668, 280, 3, 90000.00, current_date - 113),  -- membresía 668
    (669, 280, 2, 90000.00, current_date - 77),  -- membresía 669
    (670, 280, 2, 240000.00, current_date - 46),  -- membresía 670
    (671, 281, 1, 780000.00, current_date - 388),  -- membresía 671
    (672, 282, 1, 220000.00, current_date - 525),  -- membresía 672
    (673, 282, 3, 80000.00, current_date - 377),  -- membresía 673
    (674, 282, 2, 765000.00, current_date - 345),  -- membresía 674
    (675, 283, 2, 90000.00, current_date - 86),  -- membresía 675
    (676, 283, 1, 90000.00, current_date),  -- membresía 676
    (677, 284, 3, 216000.00, current_date - 94),  -- membresía 677
    (678, 284, 1, 240000.00, current_date - 1),  -- membresía 678
    (679, 285, 2, 90000.00, current_date - 84),  -- membresía 679
    (680, 285, 1, 850000.00, current_date - 47),  -- membresía 680
    (681, 286, 2, 80000.00, current_date - 508),  -- membresía 681
    (682, 286, 1, 220000.00, current_date - 475),  -- membresía 682
    (683, 287, 1, 90000.00, current_date - 265),  -- membresía 683
    (684, 287, 3, 90000.00, current_date - 233),  -- membresía 684
    (685, 287, 1, 90000.00, current_date - 130),  -- membresía 685
    (686, 287, 3, 90000.00, current_date - 96),  -- membresía 686
    (687, 288, 1, 80000.00, current_date - 395),  -- membresía 687
    (688, 288, 1, 850000.00, current_date - 246),  -- membresía 688
    (689, 289, 3, 216000.00, current_date - 98),  -- membresía 689
    (690, 289, 2, 90000.00, current_date - 5),  -- membresía 690
    (691, 290, 1, 240000.00, current_date - 232),  -- membresía 691
    (692, 290, 1, 90000.00, current_date - 140),  -- membresía 692
    (693, 290, 1, 240000.00, current_date - 105),  -- membresía 693
    (694, 290, 1, 240000.00, current_date),  -- membresía 694
    (695, 291, 1, 765000.00, current_date - 102),  -- membresía 695
    (696, 292, 1, 240000.00, current_date - 213),  -- membresía 696
    (697, 292, 2, 90000.00, current_date - 117),  -- membresía 697
    (698, 292, 1, 850000.00, current_date - 85),  -- membresía 698
    (699, 293, 1, 90000.00, current_date - 275),  -- membresía 699
    (700, 293, 1, 850000.00, current_date - 243),  -- membresía 700
    (701, 294, 1, 240000.00, current_date - 265),  -- membresía 701
    (702, 294, 2, 850000.00, current_date - 112),  -- membresía 702
    (703, 295, 1, 240000.00, current_date - 294),  -- membresía 703
    (704, 295, 1, 240000.00, current_date - 172),  -- membresía 704
    (705, 295, 1, 90000.00, current_date - 3),  -- membresía 705
    (706, 296, 2, 850000.00, current_date - 313),  -- membresía 706
    (707, 297, 2, 81000.00, current_date - 65),  -- membresía 707
    (708, 297, 1, 90000.00, current_date - 33),  -- membresía 708
    (709, 297, 2, 90000.00, current_date - 1),  -- membresía 709
    (710, 298, 1, 240000.00, current_date - 333),  -- membresía 710
    (711, 298, 2, 90000.00, current_date - 240),  -- membresía 711
    (712, 299, 1, 240000.00, current_date - 11),  -- membresía 712
    (713, 300, 3, 240000.00, current_date - 157),  -- membresía 713
    (714, 300, 2, 90000.00, current_date - 60),  -- membresía 714
    (715, 300, 2, 240000.00, current_date - 29),  -- membresía 715
    (716, 301, 1, 90000.00, current_date - 272),  -- membresía 716
    (717, 301, 3, 850000.00, current_date - 171),  -- membresía 717
    (718, 302, 1, 80000.00, current_date - 514),  -- membresía 718
    (719, 302, 1, 220000.00, current_date - 381),  -- membresía 719
    (720, 302, 2, 850000.00, current_date - 285),  -- membresía 720
    (721, 303, 3, 220000.00, current_date - 420),  -- membresía 721
    (722, 303, 3, 90000.00, current_date - 327),  -- membresía 722
    (723, 303, 2, 240000.00, current_date - 207),  -- membresía 723
    (724, 303, 2, 240000.00, current_date - 110),  -- membresía 724
    (725, 304, 2, 780000.00, current_date - 400),  -- membresía 725
    (726, 304, 2, 850000.00, current_date - 31),  -- membresía 726
    (727, 305, 2, 780000.00, current_date - 464),  -- membresía 727
    (728, 305, 3, 90000.00, current_date - 93),  -- membresía 728
    (729, 305, 1, 90000.00, current_date - 23),  -- membresía 729
    (730, 306, 2, 780000.00, current_date - 462),  -- membresía 730
    (731, 306, 2, 90000.00, current_date - 94),  -- membresía 731
    (732, 306, 2, 90000.00, current_date - 63),  -- membresía 732
    (733, 306, 1, 850000.00, current_date - 2),  -- membresía 733
    (734, 307, 2, 90000.00, current_date - 218),  -- membresía 734
    (735, 307, 2, 240000.00, current_date - 53),  -- membresía 735
    (736, 308, 2, 780000.00, current_date - 367),  -- membresía 736
    (737, 308, 1, 81000.00, current_date),  -- membresía 737
    (738, 309, 2, 240000.00, current_date - 111),  -- membresía 738
    (739, 309, 2, 90000.00, current_date - 13),  -- membresía 739
    (740, 310, 1, 90000.00, current_date - 134),  -- membresía 740
    (741, 310, 1, 90000.00, current_date - 99),  -- membresía 741
    (742, 310, 2, 240000.00, current_date - 66),  -- membresía 742
    (743, 311, 1, 90000.00, current_date - 52),  -- membresía 743
    (744, 311, 3, 850000.00, current_date - 20),  -- membresía 744
    (745, 312, 3, 80000.00, current_date - 498),  -- membresía 745
    (746, 312, 1, 220000.00, current_date - 421),  -- membresía 746
    (747, 313, 3, 240000.00, current_date - 23),  -- membresía 747
    (748, 314, 2, 850000.00, current_date - 320),  -- membresía 748
    (749, 315, 2, 80000.00, current_date - 368),  -- membresía 749
    (750, 315, 1, 90000.00, current_date - 332),  -- membresía 750
    (751, 315, 2, 850000.00, current_date - 301),  -- membresía 751
    (752, 316, 3, 780000.00, current_date - 390),  -- membresía 752
    (753, 316, 1, 240000.00, current_date - 23),  -- membresía 753
    (754, 317, 2, 90000.00, current_date - 263),  -- membresía 754
    (755, 318, 2, 80000.00, current_date - 374),  -- membresía 755
    (756, 318, 1, 90000.00, current_date - 342),  -- membresía 756
    (757, 318, 2, 850000.00, current_date - 291),  -- membresía 757
    (758, 319, 1, 220000.00, current_date - 518),  -- membresía 758
    (759, 319, 3, 780000.00, current_date - 424),  -- membresía 759
    (760, 319, 1, 90000.00, current_date - 55),  -- membresía 760
    (761, 319, 1, 240000.00, current_date - 16),  -- membresía 761
    (762, 320, 1, 198000.00, current_date - 390),  -- membresía 762
    (763, 321, 1, 80000.00, current_date - 411),  -- membresía 763
    (764, 322, 2, 240000.00, current_date - 70),  -- membresía 764
    (765, 323, 1, 90000.00, current_date - 347),  -- membresía 765
    (766, 323, 2, 240000.00, current_date - 310),  -- membresía 766
    (767, 323, 1, 90000.00, current_date - 217),  -- membresía 767
    (768, 324, 2, 765000.00, current_date - 215),  -- membresía 768
    (769, 325, 1, 80000.00, current_date - 651),  -- membresía 769
    (770, 325, 3, 780000.00, current_date - 618),  -- membresía 770
    (771, 325, 1, 90000.00, current_date - 24),  -- membresía 771
    (772, 326, 2, 90000.00, current_date - 93),  -- membresía 772
    (773, 326, 2, 90000.00, current_date - 58),  -- membresía 773
    (774, 326, 2, 90000.00, current_date),  -- membresía 774
    (775, 327, 3, 780000.00, current_date - 464),  -- membresía 775
    (776, 327, 2, 850000.00, current_date - 94),  -- membresía 776
    (777, 328, 3, 220000.00, current_date - 529),  -- membresía 777
    (778, 328, 1, 80000.00, current_date - 432),  -- membresía 778
    (779, 328, 2, 80000.00, current_date - 399),  -- membresía 779
    (780, 328, 3, 220000.00, current_date - 366),  -- membresía 780
    (781, 328, 2, 81000.00, current_date - 166),  -- membresía 781
    (782, 328, 1, 90000.00, current_date - 132),  -- membresía 782
    (783, 328, 2, 850000.00, current_date - 95),  -- membresía 783
    (784, 329, 2, 90000.00, current_date - 103),  -- membresía 784
    (785, 329, 3, 90000.00, current_date - 68),  -- membresía 785
    (786, 329, 2, 90000.00, current_date - 33),  -- membresía 786
    (787, 329, 1, 90000.00, current_date - 2),  -- membresía 787
    (788, 330, 2, 220000.00, current_date - 428),  -- membresía 788
    (789, 330, 1, 90000.00, current_date - 335),  -- membresía 789
    (790, 330, 1, 240000.00, current_date - 302),  -- membresía 790
    (791, 330, 3, 240000.00, current_date - 207),  -- membresía 791
    (792, 330, 1, 240000.00, current_date - 2),  -- membresía 792
    (793, 331, 3, 220000.00, current_date - 430),  -- membresía 793
    (794, 331, 1, 90000.00, current_date - 338),  -- membresía 794
    (795, 331, 2, 240000.00, current_date - 303),  -- membresía 795
    (796, 331, 1, 850000.00, current_date - 211),  -- membresía 796
    (797, 332, 2, 240000.00, current_date - 194),  -- membresía 797
    (798, 332, 1, 240000.00, current_date - 2),  -- membresía 798
    (799, 333, 1, 81000.00, current_date - 68),  -- membresía 799
    (800, 333, 2, 240000.00, current_date - 1),  -- membresía 800
    (801, 334, 1, 240000.00, current_date - 145),  -- membresía 801
    (802, 334, 1, 240000.00, current_date - 2),  -- membresía 802
    (803, 335, 1, 220000.00, current_date - 474),  -- membresía 803
    (804, 335, 1, 80000.00, current_date - 379),  -- membresía 804
    (805, 335, 1, 240000.00, current_date - 282),  -- membresía 805
    (806, 335, 3, 240000.00, current_date - 165),  -- membresía 806
    (807, 335, 3, 850000.00, current_date - 69),  -- membresía 807
    (808, 336, 1, 220000.00, current_date - 588),  -- membresía 808
    (809, 336, 1, 80000.00, current_date - 442),  -- membresía 809
    (810, 336, 2, 220000.00, current_date - 411),  -- membresía 810
    (811, 337, 2, 90000.00, current_date - 22),  -- membresía 811
    (812, 338, 1, 220000.00, current_date - 525),  -- membresía 812
    (813, 338, 3, 80000.00, current_date - 430),  -- membresía 813
    (814, 338, 2, 702000.00, current_date - 393),  -- membresía 814
    (815, 338, 1, 90000.00, current_date - 18),  -- membresía 815
    (816, 339, 1, 240000.00, current_date - 272),  -- membresía 816
    (817, 339, 2, 90000.00, current_date - 176),  -- membresía 817
    (818, 339, 2, 240000.00, current_date - 20),  -- membresía 818
    (819, 340, 3, 220000.00, current_date - 519),  -- membresía 819
    (820, 340, 2, 72000.00, current_date - 423),  -- membresía 820
    (821, 340, 1, 780000.00, current_date - 391),  -- membresía 821
    (822, 340, 1, 850000.00, current_date - 1),  -- membresía 822
    (823, 341, 1, 81000.00, current_date - 160),  -- membresía 823
    (824, 341, 2, 240000.00, current_date - 124),  -- membresía 824
    (825, 341, 3, 850000.00, current_date - 23),  -- membresía 825
    (826, 342, 1, 850000.00, current_date - 85),  -- membresía 826
    (827, 343, 3, 850000.00, current_date - 320),  -- membresía 827
    (828, 344, 2, 240000.00, current_date - 206),  -- membresía 828
    (829, 344, 3, 90000.00, current_date - 82),  -- membresía 829
    (830, 344, 2, 240000.00, current_date - 45),  -- membresía 830
    (831, 345, 1, 220000.00, current_date - 398),  -- membresía 831
    (832, 345, 3, 240000.00, current_date - 300),  -- membresía 832
    (833, 345, 1, 240000.00, current_date - 208),  -- membresía 833
    (834, 345, 2, 765000.00, current_date - 1),  -- membresía 834
    (835, 346, 1, 850000.00, current_date - 200),  -- membresía 835
    (836, 347, 2, 240000.00, current_date - 209),  -- membresía 836
    (837, 347, 3, 90000.00, current_date - 116),  -- membresía 837
    (838, 347, 1, 90000.00, current_date - 84),  -- membresía 838
    (839, 347, 3, 90000.00, current_date - 2),  -- membresía 839
    (840, 348, 1, 240000.00, current_date - 158),  -- membresía 840
    (841, 348, 2, 240000.00, current_date),  -- membresía 841
    (842, 349, 3, 240000.00, current_date - 167),  -- membresía 842
    (843, 349, 1, 90000.00, current_date - 74),  -- membresía 843
    (844, 349, 1, 90000.00, current_date - 40),  -- membresía 844
    (845, 349, 2, 216000.00, current_date - 6),  -- membresía 845
    (846, 350, 2, 702000.00, current_date - 418),  -- membresía 846
    (847, 350, 2, 850000.00, current_date - 1);  -- membresía 847

-- ---------------------------------------------------------------------
-- CLASE (113) - dictada por un entrenador activo de la misma sede
-- ---------------------------------------------------------------------
INSERT INTO clase (id_clase, nombre, descripcion, cupo_maximo, id_sede, id_empleado) VALUES
    (1, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 23, 1, 7),
    (2, 'Body Pump', 'Tonificación con barra y discos', 24, 1, 8),
    (3, 'Body Pump', 'Tonificación con barra y discos', 17, 2, 11),
    (4, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 21, 2, 11),
    (5, 'GAP', 'Glúteos, abdomen y piernas', 23, 2, 12),
    (6, 'Kickboxing', 'Combinación de golpes y patadas', 16, 3, 15),
    (7, 'Rumba aeróbica', 'Cardio con coreografías', 24, 3, 16),
    (8, 'Kickboxing', 'Combinación de golpes y patadas', 11, 4, 19),
    (9, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 14, 4, 20),
    (10, 'Stretching', 'Estiramiento y movilidad articular', 18, 5, 23),
    (11, 'Kickboxing', 'Combinación de golpes y patadas', 18, 5, 24),
    (12, 'GAP', 'Glúteos, abdomen y piernas', 17, 6, 27),
    (13, 'TRX', 'Entrenamiento en suspensión', 10, 6, 27),
    (14, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 16, 6, 28),
    (15, 'Yoga', 'Yoga hatha para todos los niveles', 23, 7, 32),
    (16, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 13, 7, 33),
    (17, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 14, 8, 36),
    (18, 'Spinning', 'Ciclismo indoor por intervalos', 17, 8, 37),
    (19, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 16, 8, 37),
    (20, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 10, 9, 40),
    (21, 'GAP', 'Glúteos, abdomen y piernas', 21, 9, 41),
    (22, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 11, 10, 44),
    (23, 'Funcional', 'Circuito con peso corporal y accesorios', 14, 10, 45),
    (24, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 10, 11, 49),
    (25, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 13, 11, 50),
    (26, 'Stretching', 'Estiramiento y movilidad articular', 24, 12, 53),
    (27, 'Spinning', 'Ciclismo indoor por intervalos', 16, 12, 54),
    (28, 'Stretching', 'Estiramiento y movilidad articular', 16, 12, 54),
    (29, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 11, 13, 57),
    (30, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 23, 13, 58),
    (31, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 21, 14, 62),
    (32, 'Zumba', 'Baile aeróbico con ritmos latinos', 30, 14, 62),
    (33, 'Yoga', 'Yoga hatha para todos los niveles', 27, 14, 63),
    (34, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 12, 14, 63),
    (35, 'TRX', 'Entrenamiento en suspensión', 12, 15, 66),
    (36, 'Rumba aeróbica', 'Cardio con coreografías', 26, 15, 67),
    (37, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 13, 16, 70),
    (38, 'TRX', 'Entrenamiento en suspensión', 11, 16, 70),
    (39, 'Funcional', 'Circuito con peso corporal y accesorios', 16, 17, 73),
    (40, 'Kickboxing', 'Combinación de golpes y patadas', 17, 17, 73),
    (41, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 18, 18, 77),
    (42, 'Rumba aeróbica', 'Cardio con coreografías', 20, 18, 78),
    (43, 'Stretching', 'Estiramiento y movilidad articular', 17, 19, 81),
    (44, 'TRX', 'Entrenamiento en suspensión', 8, 19, 81),
    (45, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 18, 20, 84),
    (46, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 21, 20, 84),
    (47, 'Stretching', 'Estiramiento y movilidad articular', 17, 21, 89),
    (48, 'Rumba aeróbica', 'Cardio con coreografías', 23, 21, 90),
    (49, 'Zumba', 'Baile aeróbico con ritmos latinos', 22, 22, 93),
    (50, 'Stretching', 'Estiramiento y movilidad articular', 22, 22, 93),
    (51, 'GAP', 'Glúteos, abdomen y piernas', 15, 23, 96),
    (52, 'Yoga', 'Yoga hatha para todos los niveles', 26, 23, 96),
    (53, 'Stretching', 'Estiramiento y movilidad articular', 24, 24, 99),
    (54, 'Kickboxing', 'Combinación de golpes y patadas', 17, 24, 99),
    (55, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 20, 24, 100),
    (56, 'Stretching', 'Estiramiento y movilidad articular', 25, 24, 100),
    (57, 'Body Pump', 'Tonificación con barra y discos', 19, 25, 103),
    (58, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 15, 25, 103),
    (59, 'Stretching', 'Estiramiento y movilidad articular', 16, 26, 106),
    (60, 'Kickboxing', 'Combinación de golpes y patadas', 18, 26, 106),
    (61, 'Zumba', 'Baile aeróbico con ritmos latinos', 23, 27, 109),
    (62, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 10, 27, 110),
    (63, 'Rumba aeróbica', 'Cardio con coreografías', 24, 28, 114),
    (64, 'Body Pump', 'Tonificación con barra y discos', 15, 28, 114),
    (65, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 16, 29, 117),
    (66, 'Kickboxing', 'Combinación de golpes y patadas', 15, 29, 117),
    (67, 'Kickboxing', 'Combinación de golpes y patadas', 10, 30, 120),
    (68, 'Funcional', 'Circuito con peso corporal y accesorios', 14, 30, 121),
    (69, 'Kickboxing', 'Combinación de golpes y patadas', 12, 30, 121),
    (70, 'Kickboxing', 'Combinación de golpes y patadas', 10, 31, 125),
    (71, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 15, 31, 125),
    (72, 'Spinning', 'Ciclismo indoor por intervalos', 24, 32, 128),
    (73, 'Zumba', 'Baile aeróbico con ritmos latinos', 24, 32, 128),
    (74, 'Stretching', 'Estiramiento y movilidad articular', 24, 33, 131),
    (75, 'Kickboxing', 'Combinación de golpes y patadas', 18, 33, 132),
    (76, 'Stretching', 'Estiramiento y movilidad articular', 23, 33, 132),
    (77, 'Spinning', 'Ciclismo indoor por intervalos', 19, 34, 135),
    (78, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 12, 34, 135),
    (79, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 16, 35, 140),
    (80, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 10, 35, 140),
    (81, 'GAP', 'Glúteos, abdomen y piernas', 21, 36, 143),
    (82, 'Kickboxing', 'Combinación de golpes y patadas', 10, 36, 144),
    (83, 'GAP', 'Glúteos, abdomen y piernas', 24, 36, 144),
    (84, 'TRX', 'Entrenamiento en suspensión', 10, 37, 147),
    (85, 'GAP', 'Glúteos, abdomen y piernas', 16, 37, 147),
    (86, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 14, 38, 150),
    (87, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 15, 38, 150),
    (88, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 13, 39, 153),
    (89, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 21, 39, 154),
    (90, 'Body Pump', 'Tonificación con barra y discos', 25, 40, 157),
    (91, 'Stretching', 'Estiramiento y movilidad articular', 23, 40, 157),
    (92, 'Funcional', 'Circuito con peso corporal y accesorios', 15, 41, 161),
    (93, 'TRX', 'Entrenamiento en suspensión', 9, 41, 161),
    (94, 'TRX', 'Entrenamiento en suspensión', 9, 42, 165),
    (95, 'Spinning', 'Ciclismo indoor por intervalos', 18, 42, 166),
    (96, 'TRX', 'Entrenamiento en suspensión', 9, 42, 166),
    (97, 'Stretching', 'Estiramiento y movilidad articular', 21, 43, 169),
    (98, 'HIIT', 'Intervalos de alta intensidad de 45 minutos', 16, 43, 169),
    (99, 'CrossFit', 'Entrenamiento funcional de alta intensidad', 11, 44, 172),
    (100, 'Zumba', 'Baile aeróbico con ritmos latinos', 34, 44, 172),
    (101, 'TRX', 'Entrenamiento en suspensión', 12, 45, 175),
    (102, 'Rumba aeróbica', 'Cardio con coreografías', 26, 45, 176),
    (103, 'TRX', 'Entrenamiento en suspensión', 10, 45, 176),
    (104, 'Yoga', 'Yoga hatha para todos los niveles', 22, 46, 179),
    (105, 'Spinning', 'Ciclismo indoor por intervalos', 23, 46, 179),
    (106, 'Boxeo fitness', 'Técnica de boxeo y acondicionamiento', 10, 47, 182),
    (107, 'Kickboxing', 'Combinación de golpes y patadas', 14, 47, 182),
    (108, 'GAP', 'Glúteos, abdomen y piernas', 23, 48, 185),
    (109, 'Kickboxing', 'Combinación de golpes y patadas', 10, 48, 186),
    (110, 'Spinning', 'Ciclismo indoor por intervalos', 25, 49, 190),
    (111, 'Yoga', 'Yoga hatha para todos los niveles', 24, 49, 190),
    (112, 'Kickboxing', 'Combinación de golpes y patadas', 11, 50, 193),
    (113, 'Pilates mat', 'Fortalecimiento de core en colchoneta', 16, 50, 193);

-- ---------------------------------------------------------------------
-- SESION
-- ---------------------------------------------------------------------
INSERT INTO sesion (numero_sesion, id_clase, fecha, hora_inicio, hora_fin) VALUES
    (1, 1, current_date - 35, '12:00', '13:00'),
    (2, 1, current_date - 27, '12:00', '13:00'),
    (3, 1, current_date - 22, '12:00', '13:00'),
    (4, 1, current_date + 1, '12:00', '13:00'),
    (5, 1, current_date + 7, '12:00', '13:00'),
    (6, 2, current_date - 35, '06:00', '07:00'),
    (7, 2, current_date - 34, '06:00', '07:00'),
    (8, 2, current_date + 3, '06:00', '07:00'),
    (9, 2, current_date + 18, '06:00', '07:00'),
    (10, 2, current_date + 21, '06:00', '07:00'),
    (11, 3, current_date - 11, '20:00', '21:00'),
    (12, 3, current_date - 3, '20:00', '21:00'),
    (13, 3, current_date + 7, '20:00', '21:00'),
    (14, 3, current_date + 10, '20:00', '21:00'),
    (15, 4, current_date - 34, '09:00', '10:00'),
    (16, 4, current_date - 21, '09:00', '10:00'),
    (17, 4, current_date - 1, '09:00', '10:00'),
    (18, 4, current_date + 11, '09:00', '10:00'),
    (19, 4, current_date + 21, '09:00', '10:00'),
    (20, 5, current_date - 14, '17:00', '18:00'),
    (21, 5, current_date - 8, '17:00', '18:00'),
    (22, 5, current_date + 7, '17:00', '18:00'),
    (23, 5, current_date + 15, '17:00', '18:00'),
    (24, 5, current_date + 18, '17:00', '18:00'),
    (25, 6, current_date - 27, '07:00', '08:00'),
    (26, 6, current_date - 9, '07:00', '08:00'),
    (27, 6, current_date + 2, '07:00', '08:00'),
    (28, 6, current_date + 11, '07:00', '08:00'),
    (29, 7, current_date - 34, '20:00', '21:00'),
    (30, 7, current_date - 29, '20:00', '21:00'),
    (31, 7, current_date - 26, '20:00', '21:00'),
    (32, 7, current_date + 3, '20:00', '21:00'),
    (33, 7, current_date + 6, '20:00', '21:00'),
    (34, 7, current_date + 9, '20:00', '21:00'),
    (35, 8, current_date - 26, '20:00', '21:00'),
    (36, 8, current_date - 10, '20:00', '21:00'),
    (37, 8, current_date + 11, '20:00', '21:00'),
    (38, 8, current_date + 15, '20:00', '21:00'),
    (39, 9, current_date - 30, '09:00', '10:00'),
    (40, 9, current_date - 20, '09:00', '10:00'),
    (41, 9, current_date - 14, '09:00', '10:00'),
    (42, 9, current_date + 8, '09:00', '10:00'),
    (43, 9, current_date + 9, '09:00', '10:00'),
    (44, 9, current_date + 18, '09:00', '10:00'),
    (45, 10, current_date - 34, '07:00', '08:00'),
    (46, 10, current_date - 10, '07:00', '08:00'),
    (47, 10, current_date - 6, '07:00', '08:00'),
    (48, 10, current_date + 7, '07:00', '08:00'),
    (49, 10, current_date + 11, '07:00', '08:00'),
    (50, 11, current_date - 29, '06:00', '07:00'),
    (51, 11, current_date - 28, '06:00', '07:00'),
    (52, 11, current_date + 9, '06:00', '07:00'),
    (53, 11, current_date + 16, '06:00', '07:00'),
    (54, 12, current_date - 26, '18:00', '19:00'),
    (55, 12, current_date - 14, '18:00', '19:00'),
    (56, 12, current_date + 4, '18:00', '19:00'),
    (57, 12, current_date + 10, '18:00', '19:00'),
    (58, 12, current_date + 11, '18:00', '19:00'),
    (59, 13, current_date - 21, '12:00', '13:00'),
    (60, 13, current_date - 4, '12:00', '13:00'),
    (61, 13, current_date + 6, '12:00', '13:00'),
    (62, 13, current_date + 17, '12:00', '13:00'),
    (63, 14, current_date - 28, '06:00', '07:00'),
    (64, 14, current_date - 25, '06:00', '07:00'),
    (65, 14, current_date - 18, '06:00', '07:00'),
    (66, 14, current_date + 1, '06:00', '07:00'),
    (67, 14, current_date + 7, '06:00', '07:00'),
    (68, 14, current_date + 8, '06:00', '07:00'),
    (69, 15, current_date - 23, '17:00', '18:00'),
    (70, 15, current_date - 2, '17:00', '18:00'),
    (71, 15, current_date + 16, '17:00', '18:00'),
    (72, 15, current_date + 19, '17:00', '18:00'),
    (73, 16, current_date - 14, '20:00', '21:00'),
    (74, 16, current_date - 12, '20:00', '21:00'),
    (75, 16, current_date + 4, '20:00', '21:00'),
    (76, 16, current_date + 8, '20:00', '21:00'),
    (77, 16, current_date + 21, '20:00', '21:00'),
    (78, 17, current_date - 35, '20:00', '21:00'),
    (79, 17, current_date - 12, '20:00', '21:00'),
    (80, 17, current_date + 2, '20:00', '21:00'),
    (81, 17, current_date + 9, '20:00', '21:00'),
    (82, 17, current_date + 16, '20:00', '21:00'),
    (83, 18, current_date - 17, '12:00', '13:00'),
    (84, 18, current_date - 9, '12:00', '13:00'),
    (85, 18, current_date + 7, '12:00', '13:00'),
    (86, 18, current_date + 19, '12:00', '13:00'),
    (87, 19, current_date - 27, '09:00', '10:00'),
    (88, 19, current_date - 12, '09:00', '10:00'),
    (89, 19, current_date - 2, '09:00', '10:00'),
    (90, 19, current_date + 3, '09:00', '10:00'),
    (91, 19, current_date + 12, '09:00', '10:00'),
    (92, 19, current_date + 17, '09:00', '10:00'),
    (93, 20, current_date - 33, '12:00', '13:00'),
    (94, 20, current_date - 19, '12:00', '13:00'),
    (95, 20, current_date - 5, '12:00', '13:00'),
    (96, 20, current_date + 1, '12:00', '13:00'),
    (97, 20, current_date + 19, '12:00', '13:00'),
    (98, 21, current_date - 34, '19:00', '20:00'),
    (99, 21, current_date - 5, '19:00', '20:00'),
    (100, 21, current_date + 6, '19:00', '20:00'),
    (101, 21, current_date + 7, '19:00', '20:00'),
    (102, 21, current_date + 15, '19:00', '20:00'),
    (103, 22, current_date - 31, '20:00', '21:00'),
    (104, 22, current_date - 17, '20:00', '21:00'),
    (105, 22, current_date + 4, '20:00', '21:00'),
    (106, 22, current_date + 15, '20:00', '21:00'),
    (107, 23, current_date - 27, '17:00', '18:00'),
    (108, 23, current_date - 20, '17:00', '18:00'),
    (109, 23, current_date + 4, '17:00', '18:00'),
    (110, 23, current_date + 9, '17:00', '18:00'),
    (111, 24, current_date - 35, '12:00', '13:00'),
    (112, 24, current_date - 14, '12:00', '13:00'),
    (113, 24, current_date - 4, '12:00', '13:00'),
    (114, 24, current_date + 9, '12:00', '13:00'),
    (115, 24, current_date + 14, '12:00', '13:00'),
    (116, 25, current_date - 35, '06:00', '07:00'),
    (117, 25, current_date - 17, '06:00', '07:00'),
    (118, 25, current_date - 8, '06:00', '07:00'),
    (119, 25, current_date + 3, '06:00', '07:00'),
    (120, 25, current_date + 5, '06:00', '07:00'),
    (121, 25, current_date + 11, '06:00', '07:00'),
    (122, 26, current_date - 32, '19:00', '20:00'),
    (123, 26, current_date - 7, '19:00', '20:00'),
    (124, 26, current_date + 2, '19:00', '20:00'),
    (125, 26, current_date + 4, '19:00', '20:00'),
    (126, 27, current_date - 29, '09:00', '10:00'),
    (127, 27, current_date - 23, '09:00', '10:00'),
    (128, 27, current_date + 12, '09:00', '10:00'),
    (129, 27, current_date + 13, '09:00', '10:00'),
    (130, 27, current_date + 19, '09:00', '10:00'),
    (131, 28, current_date - 31, '18:00', '19:00'),
    (132, 28, current_date - 28, '18:00', '19:00'),
    (133, 28, current_date - 7, '18:00', '19:00'),
    (134, 28, current_date + 15, '18:00', '19:00'),
    (135, 28, current_date + 20, '18:00', '19:00'),
    (136, 29, current_date - 26, '18:00', '19:00'),
    (137, 29, current_date - 22, '18:00', '19:00'),
    (138, 29, current_date + 3, '18:00', '19:00'),
    (139, 29, current_date + 9, '18:00', '19:00'),
    (140, 29, current_date + 20, '18:00', '19:00'),
    (141, 30, current_date - 20, '09:00', '10:00'),
    (142, 30, current_date - 16, '09:00', '10:00'),
    (143, 30, current_date + 5, '09:00', '10:00'),
    (144, 30, current_date + 15, '09:00', '10:00'),
    (145, 30, current_date + 19, '09:00', '10:00'),
    (146, 31, current_date - 33, '07:00', '08:00'),
    (147, 31, current_date - 30, '07:00', '08:00'),
    (148, 31, current_date + 8, '07:00', '08:00'),
    (149, 31, current_date + 19, '07:00', '08:00'),
    (150, 32, current_date - 27, '09:00', '10:00'),
    (151, 32, current_date - 11, '09:00', '10:00'),
    (152, 32, current_date - 9, '09:00', '10:00'),
    (153, 32, current_date + 5, '09:00', '10:00'),
    (154, 32, current_date + 8, '09:00', '10:00'),
    (155, 33, current_date - 33, '12:00', '13:00'),
    (156, 33, current_date - 19, '12:00', '13:00'),
    (157, 33, current_date - 13, '12:00', '13:00'),
    (158, 33, current_date + 1, '12:00', '13:00'),
    (159, 33, current_date + 18, '12:00', '13:00'),
    (160, 34, current_date - 33, '18:00', '19:00'),
    (161, 34, current_date - 8, '18:00', '19:00'),
    (162, 34, current_date - 3, '18:00', '19:00'),
    (163, 34, current_date + 1, '18:00', '19:00'),
    (164, 34, current_date + 8, '18:00', '19:00'),
    (165, 34, current_date + 13, '18:00', '19:00'),
    (166, 35, current_date - 20, '06:00', '07:00'),
    (167, 35, current_date - 18, '06:00', '07:00'),
    (168, 35, current_date - 16, '06:00', '07:00'),
    (169, 35, current_date + 3, '06:00', '07:00'),
    (170, 35, current_date + 4, '06:00', '07:00'),
    (171, 35, current_date + 5, '06:00', '07:00'),
    (172, 36, current_date - 28, '19:00', '20:00'),
    (173, 36, current_date - 17, '19:00', '20:00'),
    (174, 36, current_date - 2, '19:00', '20:00'),
    (175, 36, current_date + 10, '19:00', '20:00'),
    (176, 36, current_date + 12, '19:00', '20:00'),
    (177, 37, current_date - 25, '09:00', '10:00'),
    (178, 37, current_date - 7, '09:00', '10:00'),
    (179, 37, current_date - 4, '09:00', '10:00'),
    (180, 37, current_date + 12, '09:00', '10:00'),
    (181, 37, current_date + 15, '09:00', '10:00'),
    (182, 38, current_date - 31, '18:00', '19:00'),
    (183, 38, current_date - 12, '18:00', '19:00'),
    (184, 38, current_date + 7, '18:00', '19:00'),
    (185, 38, current_date + 17, '18:00', '19:00'),
    (186, 39, current_date - 35, '20:00', '21:00'),
    (187, 39, current_date - 6, '20:00', '21:00'),
    (188, 39, current_date + 3, '20:00', '21:00'),
    (189, 39, current_date + 12, '20:00', '21:00'),
    (190, 39, current_date + 14, '20:00', '21:00'),
    (191, 40, current_date - 33, '07:00', '08:00'),
    (192, 40, current_date - 10, '07:00', '08:00'),
    (193, 40, current_date + 16, '07:00', '08:00'),
    (194, 40, current_date + 19, '07:00', '08:00'),
    (195, 41, current_date - 17, '19:00', '20:00'),
    (196, 41, current_date - 4, '19:00', '20:00'),
    (197, 41, current_date - 3, '19:00', '20:00'),
    (198, 41, current_date + 2, '19:00', '20:00'),
    (199, 41, current_date + 3, '19:00', '20:00'),
    (200, 42, current_date - 31, '12:00', '13:00'),
    (201, 42, current_date - 28, '12:00', '13:00'),
    (202, 42, current_date - 27, '12:00', '13:00'),
    (203, 42, current_date + 6, '12:00', '13:00'),
    (204, 42, current_date + 11, '12:00', '13:00'),
    (205, 43, current_date - 35, '20:00', '21:00'),
    (206, 43, current_date - 25, '20:00', '21:00'),
    (207, 43, current_date - 12, '20:00', '21:00'),
    (208, 43, current_date + 4, '20:00', '21:00'),
    (209, 43, current_date + 6, '20:00', '21:00'),
    (210, 43, current_date + 20, '20:00', '21:00'),
    (211, 44, current_date - 24, '07:00', '08:00'),
    (212, 44, current_date - 10, '07:00', '08:00'),
    (213, 44, current_date + 16, '07:00', '08:00'),
    (214, 44, current_date + 19, '07:00', '08:00'),
    (215, 45, current_date - 16, '20:00', '21:00'),
    (216, 45, current_date - 9, '20:00', '21:00'),
    (217, 45, current_date - 1, '20:00', '21:00'),
    (218, 45, current_date + 7, '20:00', '21:00'),
    (219, 45, current_date + 9, '20:00', '21:00'),
    (220, 46, current_date - 22, '06:00', '07:00'),
    (221, 46, current_date - 16, '06:00', '07:00'),
    (222, 46, current_date - 10, '06:00', '07:00'),
    (223, 46, current_date + 9, '06:00', '07:00'),
    (224, 46, current_date + 13, '06:00', '07:00'),
    (225, 46, current_date + 21, '06:00', '07:00'),
    (226, 47, current_date - 16, '06:00', '07:00'),
    (227, 47, current_date - 8, '06:00', '07:00'),
    (228, 47, current_date + 1, '06:00', '07:00'),
    (229, 47, current_date + 15, '06:00', '07:00'),
    (230, 48, current_date - 33, '19:00', '20:00'),
    (231, 48, current_date - 17, '19:00', '20:00'),
    (232, 48, current_date - 1, '19:00', '20:00'),
    (233, 48, current_date + 8, '19:00', '20:00'),
    (234, 48, current_date + 9, '19:00', '20:00'),
    (235, 48, current_date + 21, '19:00', '20:00'),
    (236, 49, current_date - 33, '19:00', '20:00'),
    (237, 49, current_date - 8, '19:00', '20:00'),
    (238, 49, current_date - 4, '19:00', '20:00'),
    (239, 49, current_date + 7, '19:00', '20:00'),
    (240, 49, current_date + 16, '19:00', '20:00'),
    (241, 49, current_date + 21, '19:00', '20:00'),
    (242, 50, current_date - 25, '17:00', '18:00'),
    (243, 50, current_date - 10, '17:00', '18:00'),
    (244, 50, current_date - 6, '17:00', '18:00'),
    (245, 50, current_date + 4, '17:00', '18:00'),
    (246, 50, current_date + 9, '17:00', '18:00'),
    (247, 50, current_date + 19, '17:00', '18:00'),
    (248, 51, current_date - 32, '12:00', '13:00'),
    (249, 51, current_date - 28, '12:00', '13:00'),
    (250, 51, current_date + 1, '12:00', '13:00'),
    (251, 51, current_date + 4, '12:00', '13:00'),
    (252, 51, current_date + 15, '12:00', '13:00'),
    (253, 52, current_date - 27, '17:00', '18:00'),
    (254, 52, current_date - 26, '17:00', '18:00'),
    (255, 52, current_date - 10, '17:00', '18:00'),
    (256, 52, current_date + 1, '17:00', '18:00'),
    (257, 52, current_date + 11, '17:00', '18:00'),
    (258, 53, current_date - 31, '07:00', '08:00'),
    (259, 53, current_date - 1, '07:00', '08:00'),
    (260, 53, current_date + 2, '07:00', '08:00'),
    (261, 53, current_date + 8, '07:00', '08:00'),
    (262, 53, current_date + 18, '07:00', '08:00'),
    (263, 54, current_date - 24, '19:00', '20:00'),
    (264, 54, current_date - 20, '19:00', '20:00'),
    (265, 54, current_date - 16, '19:00', '20:00'),
    (266, 54, current_date + 3, '19:00', '20:00'),
    (267, 54, current_date + 6, '19:00', '20:00'),
    (268, 54, current_date + 16, '19:00', '20:00'),
    (269, 55, current_date - 27, '06:00', '07:00'),
    (270, 55, current_date - 21, '06:00', '07:00'),
    (271, 55, current_date + 1, '06:00', '07:00'),
    (272, 55, current_date + 3, '06:00', '07:00'),
    (273, 56, current_date - 22, '09:00', '10:00'),
    (274, 56, current_date - 8, '09:00', '10:00'),
    (275, 56, current_date - 1, '09:00', '10:00'),
    (276, 56, current_date + 4, '09:00', '10:00'),
    (277, 56, current_date + 8, '09:00', '10:00'),
    (278, 56, current_date + 15, '09:00', '10:00'),
    (279, 57, current_date - 34, '09:00', '10:00'),
    (280, 57, current_date - 25, '09:00', '10:00'),
    (281, 57, current_date - 1, '09:00', '10:00'),
    (282, 57, current_date + 2, '09:00', '10:00'),
    (283, 57, current_date + 4, '09:00', '10:00'),
    (284, 57, current_date + 9, '09:00', '10:00'),
    (285, 58, current_date - 32, '06:00', '07:00'),
    (286, 58, current_date - 18, '06:00', '07:00'),
    (287, 58, current_date - 14, '06:00', '07:00'),
    (288, 58, current_date + 3, '06:00', '07:00'),
    (289, 58, current_date + 12, '06:00', '07:00'),
    (290, 59, current_date - 11, '07:00', '08:00'),
    (291, 59, current_date - 4, '07:00', '08:00'),
    (292, 59, current_date + 3, '07:00', '08:00'),
    (293, 59, current_date + 11, '07:00', '08:00'),
    (294, 59, current_date + 12, '07:00', '08:00'),
    (295, 60, current_date - 24, '19:00', '20:00'),
    (296, 60, current_date - 23, '19:00', '20:00'),
    (297, 60, current_date + 7, '19:00', '20:00'),
    (298, 60, current_date + 21, '19:00', '20:00'),
    (299, 61, current_date - 8, '09:00', '10:00'),
    (300, 61, current_date - 2, '09:00', '10:00'),
    (301, 61, current_date + 4, '09:00', '10:00'),
    (302, 61, current_date + 20, '09:00', '10:00'),
    (303, 62, current_date - 34, '20:00', '21:00'),
    (304, 62, current_date - 26, '20:00', '21:00'),
    (305, 62, current_date - 23, '20:00', '21:00'),
    (306, 62, current_date + 8, '20:00', '21:00'),
    (307, 62, current_date + 15, '20:00', '21:00'),
    (308, 62, current_date + 18, '20:00', '21:00'),
    (309, 63, current_date - 33, '20:00', '21:00'),
    (310, 63, current_date - 28, '20:00', '21:00'),
    (311, 63, current_date - 21, '20:00', '21:00'),
    (312, 63, current_date + 1, '20:00', '21:00'),
    (313, 63, current_date + 18, '20:00', '21:00'),
    (314, 63, current_date + 19, '20:00', '21:00'),
    (315, 64, current_date - 20, '17:00', '18:00'),
    (316, 64, current_date - 11, '17:00', '18:00'),
    (317, 64, current_date - 3, '17:00', '18:00'),
    (318, 64, current_date + 8, '17:00', '18:00'),
    (319, 64, current_date + 18, '17:00', '18:00'),
    (320, 64, current_date + 19, '17:00', '18:00'),
    (321, 65, current_date - 22, '06:00', '07:00'),
    (322, 65, current_date - 21, '06:00', '07:00'),
    (323, 65, current_date - 11, '06:00', '07:00'),
    (324, 65, current_date + 1, '06:00', '07:00'),
    (325, 65, current_date + 20, '06:00', '07:00'),
    (326, 66, current_date - 29, '07:00', '08:00'),
    (327, 66, current_date - 14, '07:00', '08:00'),
    (328, 66, current_date + 3, '07:00', '08:00'),
    (329, 66, current_date + 13, '07:00', '08:00'),
    (330, 66, current_date + 15, '07:00', '08:00'),
    (331, 67, current_date - 31, '07:00', '08:00'),
    (332, 67, current_date - 9, '07:00', '08:00'),
    (333, 67, current_date - 2, '07:00', '08:00'),
    (334, 67, current_date + 7, '07:00', '08:00'),
    (335, 67, current_date + 9, '07:00', '08:00'),
    (336, 67, current_date + 12, '07:00', '08:00'),
    (337, 68, current_date - 27, '09:00', '10:00'),
    (338, 68, current_date - 15, '09:00', '10:00'),
    (339, 68, current_date + 1, '09:00', '10:00'),
    (340, 68, current_date + 19, '09:00', '10:00'),
    (341, 69, current_date - 30, '20:00', '21:00'),
    (342, 69, current_date - 29, '20:00', '21:00'),
    (343, 69, current_date - 9, '20:00', '21:00'),
    (344, 69, current_date + 2, '20:00', '21:00'),
    (345, 69, current_date + 11, '20:00', '21:00'),
    (346, 69, current_date + 12, '20:00', '21:00'),
    (347, 70, current_date - 28, '06:00', '07:00'),
    (348, 70, current_date - 7, '06:00', '07:00'),
    (349, 70, current_date + 8, '06:00', '07:00'),
    (350, 70, current_date + 19, '06:00', '07:00'),
    (351, 71, current_date - 22, '17:00', '18:00'),
    (352, 71, current_date - 11, '17:00', '18:00'),
    (353, 71, current_date - 9, '17:00', '18:00'),
    (354, 71, current_date + 4, '17:00', '18:00'),
    (355, 71, current_date + 10, '17:00', '18:00'),
    (356, 72, current_date - 5, '12:00', '13:00'),
    (357, 72, current_date - 2, '12:00', '13:00'),
    (358, 72, current_date + 3, '12:00', '13:00'),
    (359, 72, current_date + 6, '12:00', '13:00'),
    (360, 73, current_date - 27, '09:00', '10:00'),
    (361, 73, current_date - 18, '09:00', '10:00'),
    (362, 73, current_date + 1, '09:00', '10:00'),
    (363, 73, current_date + 12, '09:00', '10:00'),
    (364, 74, current_date - 35, '18:00', '19:00'),
    (365, 74, current_date - 10, '18:00', '19:00'),
    (366, 74, current_date - 7, '18:00', '19:00'),
    (367, 74, current_date + 1, '18:00', '19:00'),
    (368, 74, current_date + 5, '18:00', '19:00'),
    (369, 74, current_date + 21, '18:00', '19:00'),
    (370, 75, current_date - 34, '12:00', '13:00'),
    (371, 75, current_date - 15, '12:00', '13:00'),
    (372, 75, current_date + 4, '12:00', '13:00'),
    (373, 75, current_date + 10, '12:00', '13:00'),
    (374, 76, current_date - 25, '07:00', '08:00'),
    (375, 76, current_date - 16, '07:00', '08:00'),
    (376, 76, current_date + 6, '07:00', '08:00'),
    (377, 76, current_date + 18, '07:00', '08:00'),
    (378, 77, current_date - 22, '06:00', '07:00'),
    (379, 77, current_date - 6, '06:00', '07:00'),
    (380, 77, current_date + 12, '06:00', '07:00'),
    (381, 77, current_date + 21, '06:00', '07:00'),
    (382, 78, current_date - 16, '17:00', '18:00'),
    (383, 78, current_date - 9, '17:00', '18:00'),
    (384, 78, current_date - 8, '17:00', '18:00'),
    (385, 78, current_date + 1, '17:00', '18:00'),
    (386, 78, current_date + 12, '17:00', '18:00'),
    (387, 78, current_date + 19, '17:00', '18:00'),
    (388, 79, current_date - 35, '19:00', '20:00'),
    (389, 79, current_date - 9, '19:00', '20:00'),
    (390, 79, current_date + 11, '19:00', '20:00'),
    (391, 79, current_date + 16, '19:00', '20:00'),
    (392, 80, current_date - 33, '06:00', '07:00'),
    (393, 80, current_date - 10, '06:00', '07:00'),
    (394, 80, current_date + 13, '06:00', '07:00'),
    (395, 80, current_date + 15, '06:00', '07:00'),
    (396, 81, current_date - 18, '19:00', '20:00'),
    (397, 81, current_date - 3, '19:00', '20:00'),
    (398, 81, current_date + 3, '19:00', '20:00'),
    (399, 81, current_date + 9, '19:00', '20:00'),
    (400, 82, current_date - 20, '17:00', '18:00'),
    (401, 82, current_date - 14, '17:00', '18:00'),
    (402, 82, current_date - 2, '17:00', '18:00'),
    (403, 82, current_date + 10, '17:00', '18:00'),
    (404, 82, current_date + 17, '17:00', '18:00'),
    (405, 83, current_date - 31, '07:00', '08:00'),
    (406, 83, current_date - 21, '07:00', '08:00'),
    (407, 83, current_date - 1, '07:00', '08:00'),
    (408, 83, current_date + 6, '07:00', '08:00'),
    (409, 83, current_date + 12, '07:00', '08:00'),
    (410, 83, current_date + 18, '07:00', '08:00'),
    (411, 84, current_date - 5, '17:00', '18:00'),
    (412, 84, current_date - 4, '17:00', '18:00'),
    (413, 84, current_date - 3, '17:00', '18:00'),
    (414, 84, current_date + 2, '17:00', '18:00'),
    (415, 84, current_date + 13, '17:00', '18:00'),
    (416, 85, current_date - 27, '12:00', '13:00'),
    (417, 85, current_date - 24, '12:00', '13:00'),
    (418, 85, current_date - 15, '12:00', '13:00'),
    (419, 85, current_date + 3, '12:00', '13:00'),
    (420, 85, current_date + 5, '12:00', '13:00'),
    (421, 86, current_date - 35, '09:00', '10:00'),
    (422, 86, current_date - 34, '09:00', '10:00'),
    (423, 86, current_date - 30, '09:00', '10:00'),
    (424, 86, current_date + 11, '09:00', '10:00'),
    (425, 86, current_date + 13, '09:00', '10:00'),
    (426, 87, current_date - 12, '20:00', '21:00'),
    (427, 87, current_date - 11, '20:00', '21:00'),
    (428, 87, current_date + 1, '20:00', '21:00'),
    (429, 87, current_date + 20, '20:00', '21:00'),
    (430, 88, current_date - 28, '17:00', '18:00'),
    (431, 88, current_date - 27, '17:00', '18:00'),
    (432, 88, current_date - 11, '17:00', '18:00'),
    (433, 88, current_date + 18, '17:00', '18:00'),
    (434, 88, current_date + 19, '17:00', '18:00'),
    (435, 88, current_date + 21, '17:00', '18:00'),
    (436, 89, current_date - 34, '09:00', '10:00'),
    (437, 89, current_date - 28, '09:00', '10:00'),
    (438, 89, current_date - 26, '09:00', '10:00'),
    (439, 89, current_date + 1, '09:00', '10:00'),
    (440, 89, current_date + 20, '09:00', '10:00'),
    (441, 90, current_date - 31, '06:00', '07:00'),
    (442, 90, current_date - 20, '06:00', '07:00'),
    (443, 90, current_date + 11, '06:00', '07:00'),
    (444, 90, current_date + 17, '06:00', '07:00'),
    (445, 91, current_date - 32, '20:00', '21:00'),
    (446, 91, current_date - 6, '20:00', '21:00'),
    (447, 91, current_date + 8, '20:00', '21:00'),
    (448, 91, current_date + 10, '20:00', '21:00'),
    (449, 91, current_date + 19, '20:00', '21:00'),
    (450, 92, current_date - 32, '06:00', '07:00'),
    (451, 92, current_date - 28, '06:00', '07:00'),
    (452, 92, current_date - 8, '06:00', '07:00'),
    (453, 92, current_date + 2, '06:00', '07:00'),
    (454, 92, current_date + 21, '06:00', '07:00'),
    (455, 93, current_date - 35, '20:00', '21:00'),
    (456, 93, current_date - 30, '20:00', '21:00'),
    (457, 93, current_date - 4, '20:00', '21:00'),
    (458, 93, current_date + 5, '20:00', '21:00'),
    (459, 93, current_date + 6, '20:00', '21:00'),
    (460, 93, current_date + 7, '20:00', '21:00'),
    (461, 94, current_date - 18, '12:00', '13:00'),
    (462, 94, current_date - 16, '12:00', '13:00'),
    (463, 94, current_date - 14, '12:00', '13:00'),
    (464, 94, current_date + 4, '12:00', '13:00'),
    (465, 94, current_date + 8, '12:00', '13:00'),
    (466, 94, current_date + 18, '12:00', '13:00'),
    (467, 95, current_date - 31, '18:00', '19:00'),
    (468, 95, current_date - 16, '18:00', '19:00'),
    (469, 95, current_date - 12, '18:00', '19:00'),
    (470, 95, current_date + 1, '18:00', '19:00'),
    (471, 95, current_date + 12, '18:00', '19:00'),
    (472, 95, current_date + 14, '18:00', '19:00'),
    (473, 96, current_date - 32, '12:00', '13:00'),
    (474, 96, current_date - 20, '12:00', '13:00'),
    (475, 96, current_date - 5, '12:00', '13:00'),
    (476, 96, current_date + 12, '12:00', '13:00'),
    (477, 96, current_date + 17, '12:00', '13:00'),
    (478, 97, current_date - 11, '20:00', '21:00'),
    (479, 97, current_date - 10, '20:00', '21:00'),
    (480, 97, current_date - 4, '20:00', '21:00'),
    (481, 97, current_date + 7, '20:00', '21:00'),
    (482, 97, current_date + 9, '20:00', '21:00'),
    (483, 97, current_date + 12, '20:00', '21:00'),
    (484, 98, current_date - 22, '09:00', '10:00'),
    (485, 98, current_date - 4, '09:00', '10:00'),
    (486, 98, current_date + 3, '09:00', '10:00'),
    (487, 98, current_date + 4, '09:00', '10:00'),
    (488, 98, current_date + 12, '09:00', '10:00'),
    (489, 99, current_date - 29, '17:00', '18:00'),
    (490, 99, current_date - 5, '17:00', '18:00'),
    (491, 99, current_date + 3, '17:00', '18:00'),
    (492, 99, current_date + 5, '17:00', '18:00'),
    (493, 99, current_date + 6, '17:00', '18:00'),
    (494, 100, current_date - 14, '12:00', '13:00'),
    (495, 100, current_date - 12, '12:00', '13:00'),
    (496, 100, current_date - 6, '12:00', '13:00'),
    (497, 100, current_date + 19, '12:00', '13:00'),
    (498, 100, current_date + 21, '12:00', '13:00'),
    (499, 101, current_date - 33, '07:00', '08:00'),
    (500, 101, current_date - 20, '07:00', '08:00'),
    (501, 101, current_date + 5, '07:00', '08:00'),
    (502, 101, current_date + 14, '07:00', '08:00'),
    (503, 102, current_date - 20, '18:00', '19:00'),
    (504, 102, current_date - 7, '18:00', '19:00'),
    (505, 102, current_date - 4, '18:00', '19:00'),
    (506, 102, current_date + 2, '18:00', '19:00'),
    (507, 102, current_date + 20, '18:00', '19:00'),
    (508, 103, current_date - 12, '07:00', '08:00'),
    (509, 103, current_date - 4, '07:00', '08:00'),
    (510, 103, current_date + 12, '07:00', '08:00'),
    (511, 103, current_date + 14, '07:00', '08:00'),
    (512, 104, current_date - 32, '17:00', '18:00'),
    (513, 104, current_date - 3, '17:00', '18:00'),
    (514, 104, current_date + 7, '17:00', '18:00'),
    (515, 104, current_date + 13, '17:00', '18:00'),
    (516, 104, current_date + 17, '17:00', '18:00'),
    (517, 105, current_date - 26, '09:00', '10:00'),
    (518, 105, current_date - 20, '09:00', '10:00'),
    (519, 105, current_date + 8, '09:00', '10:00'),
    (520, 105, current_date + 15, '09:00', '10:00'),
    (521, 105, current_date + 17, '09:00', '10:00'),
    (522, 106, current_date - 15, '19:00', '20:00'),
    (523, 106, current_date - 1, '19:00', '20:00'),
    (524, 106, current_date + 1, '19:00', '20:00'),
    (525, 106, current_date + 4, '19:00', '20:00'),
    (526, 106, current_date + 10, '19:00', '20:00'),
    (527, 107, current_date - 22, '06:00', '07:00'),
    (528, 107, current_date - 9, '06:00', '07:00'),
    (529, 107, current_date + 3, '06:00', '07:00'),
    (530, 107, current_date + 4, '06:00', '07:00'),
    (531, 107, current_date + 14, '06:00', '07:00'),
    (532, 108, current_date - 20, '18:00', '19:00'),
    (533, 108, current_date - 9, '18:00', '19:00'),
    (534, 108, current_date - 5, '18:00', '19:00'),
    (535, 108, current_date + 14, '18:00', '19:00'),
    (536, 108, current_date + 15, '18:00', '19:00'),
    (537, 109, current_date - 34, '20:00', '21:00'),
    (538, 109, current_date - 28, '20:00', '21:00'),
    (539, 109, current_date - 14, '20:00', '21:00'),
    (540, 109, current_date + 4, '20:00', '21:00'),
    (541, 109, current_date + 18, '20:00', '21:00'),
    (542, 110, current_date - 33, '20:00', '21:00'),
    (543, 110, current_date - 13, '20:00', '21:00'),
    (544, 110, current_date + 7, '20:00', '21:00'),
    (545, 110, current_date + 17, '20:00', '21:00'),
    (546, 111, current_date - 31, '09:00', '10:00'),
    (547, 111, current_date - 3, '09:00', '10:00'),
    (548, 111, current_date - 1, '09:00', '10:00'),
    (549, 111, current_date + 7, '09:00', '10:00'),
    (550, 111, current_date + 11, '09:00', '10:00'),
    (551, 111, current_date + 12, '09:00', '10:00'),
    (552, 112, current_date - 35, '12:00', '13:00'),
    (553, 112, current_date - 18, '12:00', '13:00'),
    (554, 112, current_date + 13, '12:00', '13:00'),
    (555, 112, current_date + 21, '12:00', '13:00'),
    (556, 113, current_date - 19, '20:00', '21:00'),
    (557, 113, current_date - 15, '20:00', '21:00'),
    (558, 113, current_date + 13, '20:00', '21:00'),
    (559, 113, current_date + 15, '20:00', '21:00');

-- ---------------------------------------------------------------------
-- MIEMBRO_SESION - inscripciones N:M 
-- ---------------------------------------------------------------------

INSERT INTO miembro_sesion (id_miembro, numero_sesion, fecha_inscripcion, asistio) VALUES
    (294, 1, current_date - 39, TRUE),
    (216, 1, current_date - 37, TRUE),
    (193, 1, current_date - 35, TRUE),
    (97, 1, current_date - 35, TRUE),
    (216, 2, current_date - 29, TRUE),
    (169, 2, current_date - 27, TRUE),
    (100, 2, current_date - 29, TRUE),
    (193, 2, current_date - 31, TRUE),
    (97, 2, current_date - 29, TRUE),
    (216, 3, current_date - 24, FALSE),
    (97, 3, current_date - 26, FALSE),
    (324, 3, current_date - 23, TRUE),
    (193, 4, current_date - 1, FALSE),
    (140, 4, current_date, FALSE),
    (97, 4, current_date - 1, FALSE),
    (216, 4, current_date - 3, FALSE),
    (216, 5, current_date, FALSE),
    (215, 5, current_date, FALSE),
    (193, 5, current_date - 2, FALSE),
    (97, 5, current_date - 2, FALSE),
    (218, 5, current_date - 1, FALSE),
    (294, 6, current_date - 37, TRUE),
    (193, 6, current_date - 39, TRUE),
    (280, 6, current_date - 35, TRUE),
    (97, 6, current_date - 36, TRUE),
    (216, 6, current_date - 37, TRUE),
    (213, 6, current_date - 35, TRUE),
    (29, 7, current_date - 36, TRUE),
    (97, 7, current_date - 38, TRUE),
    (216, 7, current_date - 34, FALSE),
    (193, 7, current_date - 34, TRUE),
    (216, 8, current_date - 1, FALSE),
    (210, 8, current_date - 1, FALSE),
    (341, 8, current_date - 1, FALSE),
    (193, 8, current_date - 2, FALSE),
    (77, 8, current_date - 1, FALSE),
    (97, 8, current_date - 3, FALSE),
    (218, 9, current_date, FALSE),
    (216, 9, current_date, FALSE),
    (193, 9, current_date, FALSE),
    (324, 10, current_date - 2, FALSE),
    (97, 10, current_date - 2, FALSE),
    (193, 10, current_date - 2, FALSE),
    (166, 11, current_date - 13, TRUE),
    (213, 11, current_date - 12, FALSE),
    (319, 11, current_date - 11, FALSE),
    (209, 11, current_date - 11, FALSE),
    (263, 11, current_date - 12, TRUE),
    (94, 11, current_date - 11, TRUE),
    (319, 12, current_date - 5, TRUE),
    (92, 12, current_date - 5, TRUE),
    (166, 12, current_date - 6, FALSE),
    (216, 12, current_date - 3, TRUE),
    (20, 12, current_date - 7, FALSE),
    (213, 12, current_date - 6, TRUE),
    (209, 12, current_date - 3, TRUE),
    (213, 13, current_date - 3, FALSE),
    (319, 13, current_date, FALSE),
    (166, 13, current_date - 1, FALSE),
    (209, 13, current_date - 1, FALSE),
    (140, 13, current_date - 3, FALSE),
    (20, 13, current_date - 1, FALSE),
    (319, 14, current_date - 3, FALSE),
    (213, 14, current_date - 2, FALSE),
    (20, 14, current_date - 1, FALSE),
    (166, 14, current_date - 3, FALSE),
    (296, 14, current_date, FALSE),
    (28, 14, current_date - 1, FALSE),
    (209, 14, current_date - 2, FALSE),
    (63, 14, current_date - 3, FALSE),
    (213, 15, current_date - 34, TRUE),
    (166, 15, current_date - 38, TRUE),
    (233, 15, current_date - 37, TRUE),
    (307, 15, current_date - 34, TRUE),
    (319, 15, current_date - 35, TRUE),
    (130, 16, current_date - 22, TRUE),
    (213, 16, current_date - 22, TRUE),
    (166, 16, current_date - 22, TRUE),
    (170, 16, current_date - 25, TRUE),
    (319, 17, current_date - 1, TRUE),
    (209, 17, current_date - 5, TRUE),
    (20, 17, current_date - 4, TRUE),
    (295, 17, current_date - 1, TRUE),
    (166, 17, current_date - 4, TRUE),
    (213, 17, current_date - 5, FALSE),
    (319, 18, current_date - 3, FALSE),
    (20, 18, current_date - 1, FALSE),
    (28, 18, current_date, FALSE),
    (218, 18, current_date, FALSE),
    (209, 18, current_date, FALSE),
    (213, 18, current_date, FALSE),
    (166, 18, current_date - 2, FALSE),
    (216, 19, current_date, FALSE),
    (213, 19, current_date - 1, FALSE),
    (166, 19, current_date, FALSE),
    (280, 19, current_date - 3, FALSE),
    (16, 19, current_date - 2, FALSE),
    (319, 19, current_date, FALSE),
    (209, 19, current_date - 2, FALSE),
    (209, 20, current_date - 14, TRUE),
    (169, 20, current_date - 16, TRUE),
    (213, 20, current_date - 15, TRUE),
    (166, 20, current_date - 17, TRUE),
    (319, 20, current_date - 15, FALSE),
    (193, 20, current_date - 16, TRUE),
    (166, 21, current_date - 11, TRUE),
    (319, 21, current_date - 10, TRUE),
    (215, 21, current_date - 12, FALSE),
    (209, 21, current_date - 8, TRUE),
    (81, 21, current_date - 8, TRUE),
    (213, 21, current_date - 9, TRUE),
    (216, 21, current_date - 11, TRUE),
    (20, 22, current_date, FALSE),
    (319, 22, current_date, FALSE),
    (166, 22, current_date - 2, FALSE),
    (170, 23, current_date - 1, FALSE),
    (20, 23, current_date - 1, FALSE),
    (213, 23, current_date - 2, FALSE),
    (42, 23, current_date - 3, FALSE),
    (166, 23, current_date - 2, FALSE),
    (319, 23, current_date - 3, FALSE),
    (20, 24, current_date - 1, FALSE),
    (213, 24, current_date, FALSE),
    (172, 24, current_date, FALSE),
    (166, 24, current_date - 3, FALSE),
    (280, 25, current_date - 30, TRUE),
    (202, 25, current_date - 28, TRUE),
    (82, 25, current_date - 31, FALSE),
    (210, 25, current_date - 31, TRUE),
    (140, 25, current_date - 31, TRUE),
    (288, 25, current_date - 28, TRUE),
    (42, 25, current_date - 31, FALSE),
    (94, 25, current_date - 27, TRUE),
    (280, 26, current_date - 12, TRUE),
    (82, 26, current_date - 9, TRUE),
    (42, 26, current_date - 12, TRUE),
    (202, 26, current_date - 13, TRUE),
    (231, 26, current_date - 10, TRUE),
    (24, 27, current_date - 2, FALSE),
    (202, 27, current_date - 1, FALSE),
    (103, 28, current_date - 1, FALSE),
    (42, 28, current_date - 3, FALSE),
    (82, 28, current_date - 1, FALSE),
    (82, 29, current_date - 34, TRUE),
    (42, 29, current_date - 34, TRUE),
    (89, 29, current_date - 35, TRUE),
    (140, 29, current_date - 35, TRUE),
    (202, 29, current_date - 34, TRUE),
    (280, 29, current_date - 38, FALSE),
    (202, 30, current_date - 29, TRUE),
    (42, 30, current_date - 32, TRUE),
    (235, 30, current_date - 29, TRUE),
    (140, 30, current_date - 32, FALSE),
    (82, 30, current_date - 30, TRUE),
    (280, 30, current_date - 33, TRUE),
    (296, 31, current_date - 26, TRUE),
    (202, 31, current_date - 26, TRUE),
    (170, 31, current_date - 27, TRUE),
    (42, 31, current_date - 29, TRUE),
    (280, 31, current_date - 29, TRUE),
    (82, 31, current_date - 28, TRUE),
    (140, 31, current_date - 26, TRUE),
    (252, 32, current_date - 2, FALSE),
    (140, 32, current_date - 2, FALSE),
    (202, 32, current_date - 3, FALSE),
    (130, 32, current_date - 2, FALSE),
    (42, 32, current_date - 3, FALSE),
    (103, 32, current_date, FALSE),
    (82, 32, current_date - 2, FALSE),
    (280, 32, current_date - 2, FALSE),
    (94, 32, current_date - 3, FALSE),
    (172, 33, current_date - 2, FALSE),
    (280, 33, current_date - 3, FALSE),
    (202, 33, current_date - 3, FALSE),
    (170, 33, current_date - 1, FALSE),
    (42, 33, current_date - 2, FALSE),
    (140, 33, current_date - 2, FALSE),
    (82, 33, current_date - 1, FALSE),
    (233, 34, current_date - 2, FALSE),
    (213, 34, current_date - 1, FALSE),
    (82, 34, current_date - 2, FALSE),
    (68, 34, current_date - 1, FALSE),
    (202, 34, current_date - 1, FALSE),
    (24, 34, current_date - 1, FALSE),
    (280, 34, current_date - 2, FALSE),
    (179, 35, current_date - 30, TRUE),
    (324, 35, current_date - 29, FALSE),
    (89, 35, current_date - 30, TRUE),
    (288, 35, current_date - 27, TRUE),
    (100, 35, current_date - 26, TRUE),
    (81, 35, current_date - 30, TRUE),
    (81, 36, current_date - 11, FALSE),
    (288, 36, current_date - 14, TRUE),
    (179, 36, current_date - 11, FALSE),
    (261, 36, current_date - 11, TRUE),
    (100, 36, current_date - 13, TRUE),
    (275, 36, current_date - 10, FALSE),
    (275, 37, current_date, FALSE),
    (63, 37, current_date - 1, FALSE),
    (179, 37, current_date - 2, FALSE),
    (263, 38, current_date - 2, FALSE),
    (288, 38, current_date, FALSE),
    (179, 38, current_date - 3, FALSE),
    (280, 39, current_date - 33, TRUE),
    (292, 39, current_date - 31, TRUE),
    (81, 39, current_date - 32, TRUE),
    (179, 39, current_date - 33, TRUE),
    (288, 39, current_date - 30, TRUE),
    (100, 39, current_date - 31, TRUE),
    (261, 40, current_date - 23, TRUE),
    (82, 40, current_date - 24, FALSE),
    (179, 40, current_date - 21, TRUE),
    (81, 40, current_date - 21, TRUE),
    (288, 40, current_date - 21, FALSE),
    (100, 40, current_date - 22, TRUE),
    (179, 41, current_date - 14, TRUE),
    (94, 41, current_date - 16, TRUE),
    (81, 41, current_date - 15, FALSE),
    (288, 41, current_date - 16, TRUE),
    (92, 41, current_date - 15, TRUE),
    (261, 41, current_date - 18, TRUE),
    (275, 41, current_date - 15, TRUE),
    (100, 41, current_date - 15, TRUE),
    (288, 42, current_date - 1, FALSE),
    (52, 42, current_date - 1, FALSE),
    (275, 42, current_date - 1, FALSE),
    (179, 42, current_date, FALSE),
    (100, 43, current_date - 3, FALSE),
    (81, 43, current_date - 3, FALSE),
    (319, 43, current_date - 2, FALSE),
    (179, 43, current_date, FALSE),
    (288, 43, current_date - 3, FALSE),
    (275, 43, current_date - 2, FALSE),
    (275, 44, current_date - 3, FALSE),
    (179, 44, current_date - 1, FALSE),
    (81, 44, current_date - 2, FALSE),
    (288, 44, current_date - 3, FALSE),
    (100, 44, current_date - 2, FALSE),
    (92, 44, current_date, FALSE),
    (210, 44, current_date - 1, FALSE),
    (68, 45, current_date - 36, TRUE),
    (307, 45, current_date - 34, TRUE),
    (63, 45, current_date - 36, TRUE),
    (254, 45, current_date - 34, TRUE),
    (183, 45, current_date - 34, TRUE),
    (263, 45, current_date - 37, TRUE),
    (42, 45, current_date - 36, FALSE),
    (216, 45, current_date - 37, TRUE),
    (307, 46, current_date - 13, TRUE),
    (341, 46, current_date - 14, FALSE),
    (202, 46, current_date - 14, TRUE),
    (294, 46, current_date - 14, TRUE),
    (63, 46, current_date - 14, TRUE),
    (263, 46, current_date - 10, TRUE),
    (236, 46, current_date - 11, FALSE),
    (254, 46, current_date - 14, FALSE),
    (68, 46, current_date - 10, TRUE),
    (254, 47, current_date - 7, TRUE),
    (63, 47, current_date - 8, TRUE),
    (68, 47, current_date - 6, TRUE),
    (263, 47, current_date - 6, FALSE),
    (236, 47, current_date - 6, TRUE),
    (341, 47, current_date - 6, TRUE),
    (307, 47, current_date - 9, FALSE),
    (173, 47, current_date - 7, FALSE),
    (263, 48, current_date, FALSE),
    (183, 48, current_date - 1, FALSE),
    (209, 48, current_date - 1, FALSE),
    (68, 48, current_date, FALSE),
    (63, 48, current_date - 1, FALSE),
    (307, 48, current_date, FALSE),
    (200, 48, current_date - 3, FALSE),
    (341, 48, current_date, FALSE),
    (28, 48, current_date, FALSE),
    (63, 49, current_date - 1, FALSE),
    (263, 49, current_date - 3, FALSE),
    (68, 49, current_date - 1, FALSE),
    (183, 49, current_date - 3, FALSE),
    (179, 49, current_date - 3, FALSE),
    (341, 49, current_date - 2, FALSE),
    (307, 49, current_date - 3, FALSE),
    (210, 49, current_date - 1, FALSE),
    (193, 50, current_date - 30, FALSE),
    (183, 50, current_date - 33, TRUE),
    (307, 50, current_date - 33, TRUE),
    (254, 50, current_date - 29, FALSE),
    (263, 50, current_date - 31, TRUE),
    (68, 50, current_date - 32, TRUE),
    (63, 50, current_date - 29, TRUE),
    (254, 51, current_date - 29, FALSE),
    (307, 51, current_date - 30, TRUE),
    (63, 51, current_date - 28, TRUE),
    (68, 51, current_date - 31, FALSE),
    (263, 51, current_date - 31, FALSE),
    (28, 51, current_date - 31, TRUE),
    (83, 51, current_date - 31, TRUE),
    (183, 51, current_date - 28, FALSE),
    (63, 52, current_date - 3, FALSE),
    (341, 52, current_date - 1, FALSE),
    (68, 52, current_date - 2, FALSE),
    (255, 52, current_date - 1, FALSE),
    (263, 52, current_date, FALSE),
    (307, 52, current_date - 2, FALSE),
    (183, 52, current_date - 3, FALSE),
    (68, 53, current_date - 2, FALSE),
    (307, 53, current_date, FALSE),
    (263, 53, current_date - 3, FALSE),
    (341, 53, current_date, FALSE),
    (324, 54, current_date - 27, TRUE),
    (222, 54, current_date - 29, FALSE),
    (169, 54, current_date - 30, FALSE),
    (216, 54, current_date - 26, TRUE),
    (232, 54, current_date - 29, FALSE),
    (319, 55, current_date - 16, TRUE),
    (324, 55, current_date - 14, TRUE),
    (222, 55, current_date - 14, FALSE),
    (129, 55, current_date - 17, TRUE),
    (232, 55, current_date - 18, TRUE),
    (222, 56, current_date - 3, FALSE),
    (16, 56, current_date - 2, FALSE),
    (129, 56, current_date - 3, FALSE),
    (89, 56, current_date, FALSE),
    (232, 56, current_date, FALSE),
    (324, 56, current_date - 2, FALSE),
    (296, 56, current_date - 2, FALSE),
    (324, 57, current_date - 1, FALSE),
    (222, 57, current_date - 2, FALSE),
    (29, 57, current_date, FALSE),
    (232, 57, current_date - 3, FALSE),
    (210, 57, current_date - 2, FALSE),
    (82, 57, current_date - 3, FALSE),
    (202, 58, current_date - 2, FALSE),
    (324, 58, current_date, FALSE),
    (294, 58, current_date - 2, FALSE),
    (222, 58, current_date, FALSE),
    (232, 58, current_date - 2, FALSE),
    (324, 59, current_date - 23, TRUE),
    (232, 59, current_date - 22, TRUE),
    (341, 59, current_date - 22, TRUE),
    (222, 59, current_date - 23, FALSE),
    (232, 60, current_date - 5, TRUE),
    (129, 60, current_date - 6, TRUE),
    (29, 60, current_date - 4, TRUE),
    (193, 60, current_date - 6, TRUE),
    (324, 60, current_date - 6, TRUE),
    (164, 60, current_date - 8, TRUE),
    (222, 60, current_date - 8, TRUE),
    (232, 61, current_date - 3, FALSE),
    (222, 61, current_date - 1, FALSE),
    (232, 62, current_date, FALSE),
    (254, 62, current_date, FALSE),
    (324, 62, current_date, FALSE),
    (222, 62, current_date - 2, FALSE),
    (232, 63, current_date - 31, TRUE),
    (222, 63, current_date - 32, TRUE),
    (166, 63, current_date - 32, TRUE),
    (324, 63, current_date - 30, FALSE),
    (54, 64, current_date - 27, TRUE),
    (232, 64, current_date - 26, FALSE),
    (167, 64, current_date - 29, TRUE),
    (324, 64, current_date - 29, TRUE),
    (222, 64, current_date - 25, TRUE),
    (166, 65, current_date - 22, TRUE),
    (222, 65, current_date - 20, TRUE),
    (129, 65, current_date - 21, TRUE),
    (324, 65, current_date - 21, FALSE),
    (232, 65, current_date - 19, TRUE),
    (232, 66, current_date - 1, FALSE),
    (202, 66, current_date - 2, FALSE),
    (324, 66, current_date - 3, FALSE),
    (129, 66, current_date - 3, FALSE),
    (222, 66, current_date - 1, FALSE),
    (324, 67, current_date, FALSE),
    (210, 67, current_date - 3, FALSE),
    (218, 67, current_date - 3, FALSE),
    (222, 68, current_date - 2, FALSE),
    (324, 68, current_date - 1, FALSE),
    (232, 68, current_date, FALSE),
    (252, 69, current_date - 23, TRUE),
    (169, 69, current_date - 26, TRUE),
    (29, 69, current_date - 27, TRUE),
    (199, 69, current_date - 23, TRUE),
    (233, 69, current_date - 25, TRUE),
    (294, 69, current_date - 25, TRUE),
    (210, 69, current_date - 26, TRUE),
    (210, 70, current_date - 4, TRUE),
    (252, 70, current_date - 5, TRUE),
    (140, 70, current_date - 4, TRUE),
    (294, 70, current_date - 5, TRUE),
    (280, 70, current_date - 6, TRUE),
    (29, 70, current_date - 3, TRUE),
    (77, 70, current_date - 2, TRUE),
    (233, 70, current_date - 6, TRUE),
    (88, 71, current_date - 1, FALSE),
    (200, 71, current_date, FALSE),
    (292, 71, current_date - 2, FALSE),
    (252, 71, current_date, FALSE),
    (202, 71, current_date, FALSE),
    (29, 71, current_date - 1, FALSE),
    (233, 71, current_date - 2, FALSE),
    (294, 71, current_date - 1, FALSE),
    (210, 71, current_date, FALSE),
    (29, 72, current_date, FALSE),
    (233, 72, current_date - 3, FALSE),
    (252, 72, current_date - 2, FALSE),
    (350, 72, current_date, FALSE),
    (87, 72, current_date, FALSE),
    (294, 73, current_date - 17, FALSE),
    (252, 73, current_date - 16, TRUE),
    (172, 73, current_date - 18, TRUE),
    (215, 73, current_date - 14, TRUE),
    (199, 73, current_date - 16, TRUE),
    (29, 73, current_date - 14, TRUE),
    (233, 73, current_date - 18, FALSE),
    (252, 74, current_date - 14, TRUE),
    (233, 74, current_date - 12, TRUE),
    (29, 74, current_date - 15, TRUE),
    (294, 74, current_date - 13, TRUE),
    (199, 74, current_date - 15, TRUE),
    (231, 74, current_date - 15, TRUE),
    (275, 75, current_date - 3, FALSE),
    (172, 75, current_date - 1, FALSE),
    (199, 75, current_date, FALSE),
    (350, 75, current_date - 1, FALSE),
    (29, 75, current_date, FALSE),
    (294, 76, current_date - 3, FALSE),
    (233, 76, current_date - 3, FALSE),
    (130, 76, current_date, FALSE),
    (88, 77, current_date, FALSE),
    (65, 77, current_date, FALSE),
    (294, 77, current_date - 1, FALSE),
    (252, 77, current_date - 1, FALSE),
    (326, 78, current_date - 35, TRUE),
    (42, 78, current_date - 38, FALSE),
    (92, 78, current_date - 37, TRUE),
    (280, 79, current_date - 12, FALSE),
    (263, 79, current_date - 14, FALSE),
    (92, 79, current_date - 14, TRUE),
    (108, 80, current_date - 1, FALSE),
    (68, 80, current_date - 2, FALSE),
    (92, 80, current_date - 2, FALSE),
    (94, 80, current_date, FALSE),
    (92, 81, current_date - 1, FALSE),
    (209, 82, current_date - 1, FALSE),
    (218, 82, current_date, FALSE),
    (92, 82, current_date, FALSE),
    (294, 83, current_date - 21, TRUE),
    (264, 83, current_date - 19, FALSE),
    (129, 84, current_date - 11, FALSE),
    (92, 84, current_date - 13, TRUE),
    (52, 85, current_date - 2, FALSE),
    (140, 85, current_date, FALSE),
    (92, 85, current_date - 1, FALSE),
    (89, 86, current_date - 1, FALSE),
    (92, 86, current_date - 3, FALSE),
    (255, 86, current_date - 1, FALSE),
    (92, 87, current_date - 31, FALSE),
    (296, 87, current_date - 28, TRUE),
    (231, 87, current_date - 28, FALSE),
    (288, 87, current_date - 30, TRUE),
    (172, 88, current_date - 12, TRUE),
    (92, 88, current_date - 14, FALSE),
    (29, 88, current_date - 12, FALSE),
    (280, 89, current_date - 3, TRUE),
    (89, 89, current_date - 3, TRUE),
    (92, 89, current_date - 6, TRUE),
    (235, 90, current_date, FALSE),
    (319, 90, current_date - 3, FALSE),
    (92, 90, current_date - 2, FALSE),
    (216, 90, current_date - 3, FALSE),
    (92, 91, current_date - 3, FALSE),
    (42, 91, current_date, FALSE),
    (83, 91, current_date - 3, FALSE),
    (42, 92, current_date, FALSE),
    (92, 92, current_date - 1, FALSE),
    (210, 92, current_date, FALSE),
    (292, 93, current_date - 35, TRUE),
    (108, 93, current_date - 37, TRUE),
    (296, 93, current_date - 37, TRUE),
    (255, 93, current_date - 36, TRUE),
    (77, 93, current_date - 35, TRUE),
    (215, 93, current_date - 35, TRUE),
    (45, 93, current_date - 35, TRUE),
    (263, 93, current_date - 35, TRUE),
    (130, 94, current_date - 21, FALSE),
    (255, 94, current_date - 23, TRUE),
    (108, 94, current_date - 21, TRUE),
    (292, 94, current_date - 19, FALSE),
    (341, 94, current_date - 23, TRUE),
    (292, 95, current_date - 8, TRUE),
    (296, 95, current_date - 6, TRUE),
    (77, 95, current_date - 5, TRUE),
    (89, 95, current_date - 8, TRUE),
    (108, 95, current_date - 5, TRUE),
    (193, 95, current_date - 7, TRUE),
    (296, 96, current_date - 3, FALSE),
    (164, 96, current_date - 1, FALSE),
    (108, 96, current_date - 3, FALSE),
    (89, 96, current_date - 3, FALSE),
    (108, 97, current_date - 2, FALSE),
    (292, 97, current_date - 2, FALSE),
    (89, 98, current_date - 37, TRUE),
    (29, 98, current_date - 38, TRUE),
    (296, 98, current_date - 34, TRUE),
    (77, 98, current_date - 34, FALSE),
    (288, 98, current_date - 34, TRUE),
    (108, 98, current_date - 35, TRUE),
    (255, 98, current_date - 36, TRUE),
    (167, 99, current_date - 5, FALSE),
    (83, 99, current_date - 8, TRUE),
    (108, 99, current_date - 8, TRUE),
    (129, 99, current_date - 5, TRUE),
    (77, 99, current_date - 6, TRUE),
    (89, 99, current_date - 7, TRUE),
    (296, 99, current_date - 9, TRUE),
    (292, 99, current_date - 9, TRUE),
    (77, 100, current_date - 2, FALSE),
    (296, 100, current_date - 2, FALSE),
    (38, 100, current_date - 3, FALSE),
    (215, 100, current_date, FALSE),
    (216, 100, current_date - 2, FALSE),
    (89, 100, current_date, FALSE),
    (292, 100, current_date - 1, FALSE),
    (77, 101, current_date - 2, FALSE),
    (89, 101, current_date - 1, FALSE),
    (292, 101, current_date - 1, FALSE),
    (77, 102, current_date - 2, FALSE),
    (263, 102, current_date - 2, FALSE),
    (292, 102, current_date - 1, FALSE),
    (295, 102, current_date - 2, FALSE),
    (108, 102, current_date - 1, FALSE),
    (296, 102, current_date - 3, FALSE),
    (89, 102, current_date, FALSE),
    (82, 103, current_date - 33, TRUE),
    (255, 103, current_date - 31, FALSE),
    (28, 103, current_date - 31, TRUE),
    (164, 103, current_date - 32, FALSE),
    (319, 103, current_date - 34, TRUE),
    (311, 104, current_date - 19, TRUE),
    (215, 104, current_date - 21, TRUE),
    (28, 104, current_date - 19, TRUE),
    (164, 104, current_date - 17, TRUE),
    (38, 105, current_date - 2, FALSE),
    (94, 105, current_date, FALSE),
    (167, 106, current_date - 2, FALSE),
    (28, 106, current_date - 1, FALSE),
    (231, 106, current_date, FALSE),
    (164, 106, current_date - 3, FALSE),
    (140, 106, current_date - 1, FALSE),
    (167, 107, current_date - 28, TRUE),
    (164, 107, current_date - 27, TRUE),
    (263, 107, current_date - 30, TRUE),
    (28, 107, current_date - 31, FALSE),
    (129, 108, current_date - 21, FALSE),
    (82, 108, current_date - 21, FALSE),
    (28, 108, current_date - 23, TRUE),
    (164, 108, current_date - 24, TRUE),
    (83, 109, current_date - 3, FALSE),
    (94, 109, current_date, FALSE),
    (38, 109, current_date - 3, FALSE),
    (164, 109, current_date - 1, FALSE),
    (28, 109, current_date - 2, FALSE),
    (167, 109, current_date - 2, FALSE),
    (140, 109, current_date - 3, FALSE),
    (147, 110, current_date - 3, FALSE),
    (28, 110, current_date - 2, FALSE),
    (164, 110, current_date - 2, FALSE),
    (167, 110, current_date - 1, FALSE),
    (235, 110, current_date - 2, FALSE),
    (199, 110, current_date, FALSE),
    (231, 111, current_date - 37, TRUE),
    (45, 111, current_date - 38, TRUE),
    (233, 111, current_date - 38, TRUE),
    (45, 112, current_date - 14, TRUE),
    (231, 112, current_date - 17, TRUE),
    (82, 112, current_date - 17, TRUE),
    (238, 112, current_date - 18, TRUE),
    (238, 113, current_date - 7, TRUE),
    (231, 113, current_date - 4, TRUE),
    (45, 113, current_date - 4, TRUE),
    (54, 113, current_date - 7, TRUE),
    (236, 113, current_date - 6, TRUE),
    (123, 113, current_date - 5, TRUE),
    (123, 114, current_date, FALSE),
    (52, 114, current_date - 2, FALSE),
    (102, 114, current_date - 3, FALSE),
    (123, 115, current_date - 3, FALSE),
    (45, 115, current_date - 1, FALSE),
    (20, 115, current_date - 1, FALSE),
    (231, 115, current_date - 1, FALSE),
    (45, 116, current_date - 39, FALSE),
    (231, 116, current_date - 39, TRUE),
    (183, 116, current_date - 35, FALSE),
    (231, 117, current_date - 18, TRUE),
    (288, 117, current_date - 19, TRUE),
    (232, 117, current_date - 20, TRUE),
    (45, 117, current_date - 21, FALSE),
    (324, 117, current_date - 21, TRUE),
    (238, 117, current_date - 21, TRUE),
    (97, 118, current_date - 9, TRUE),
    (123, 118, current_date - 12, TRUE),
    (238, 118, current_date - 12, TRUE),
    (231, 118, current_date - 8, TRUE),
    (45, 118, current_date - 8, FALSE),
    (199, 118, current_date - 11, TRUE),
    (263, 119, current_date - 1, FALSE),
    (108, 119, current_date - 2, FALSE),
    (238, 119, current_date - 2, FALSE),
    (231, 119, current_date, FALSE),
    (45, 119, current_date - 3, FALSE),
    (65, 120, current_date - 2, FALSE),
    (45, 120, current_date - 2, FALSE),
    (123, 120, current_date - 3, FALSE),
    (94, 120, current_date, FALSE),
    (231, 120, current_date, FALSE),
    (183, 121, current_date - 1, FALSE),
    (202, 121, current_date - 1, FALSE),
    (45, 121, current_date - 3, FALSE),
    (28, 121, current_date - 2, FALSE),
    (123, 121, current_date - 3, FALSE),
    (231, 121, current_date, FALSE),
    (65, 122, current_date - 36, TRUE),
    (307, 122, current_date - 36, TRUE),
    (94, 122, current_date - 32, TRUE),
    (130, 122, current_date - 36, TRUE),
    (281, 122, current_date - 35, TRUE),
    (54, 122, current_date - 33, TRUE),
    (169, 122, current_date - 35, TRUE),
    (311, 122, current_date - 36, TRUE),
    (83, 122, current_date - 33, TRUE),
    (261, 123, current_date - 10, TRUE),
    (311, 123, current_date - 11, FALSE),
    (169, 123, current_date - 10, FALSE),
    (264, 123, current_date - 7, TRUE),
    (83, 123, current_date - 7, FALSE),
    (94, 123, current_date - 10, FALSE),
    (130, 123, current_date - 7, FALSE),
    (54, 123, current_date - 10, TRUE),
    (307, 123, current_date - 11, TRUE),
    (94, 124, current_date - 1, FALSE),
    (311, 124, current_date - 1, FALSE),
    (222, 124, current_date - 3, FALSE),
    (169, 124, current_date - 3, FALSE),
    (54, 124, current_date - 1, FALSE),
    (341, 124, current_date - 1, FALSE),
    (65, 124, current_date, FALSE),
    (130, 124, current_date, FALSE),
    (81, 124, current_date - 1, FALSE),
    (83, 124, current_date - 2, FALSE),
    (54, 125, current_date - 1, FALSE),
    (341, 125, current_date - 2, FALSE),
    (94, 125, current_date - 2, FALSE),
    (54, 126, current_date - 32, TRUE),
    (281, 126, current_date - 30, TRUE),
    (94, 126, current_date - 31, FALSE),
    (311, 126, current_date - 33, FALSE),
    (130, 126, current_date - 33, TRUE),
    (83, 126, current_date - 30, FALSE),
    (65, 126, current_date - 30, TRUE),
    (263, 126, current_date - 29, FALSE),
    (169, 126, current_date - 32, TRUE),
    (54, 127, current_date - 27, TRUE),
    (202, 127, current_date - 25, TRUE),
    (130, 127, current_date - 26, TRUE),
    (83, 127, current_date - 25, FALSE),
    (169, 127, current_date - 25, FALSE),
    (94, 127, current_date - 23, TRUE),
    (65, 127, current_date - 25, TRUE),
    (65, 128, current_date - 3, FALSE),
    (130, 128, current_date, FALSE),
    (54, 128, current_date, FALSE),
    (169, 128, current_date - 1, FALSE),
    (311, 128, current_date - 2, FALSE),
    (94, 128, current_date - 3, FALSE),
    (202, 128, current_date - 1, FALSE),
    (83, 129, current_date - 1, FALSE),
    (94, 129, current_date - 1, FALSE),
    (54, 129, current_date - 2, FALSE),
    (169, 129, current_date - 1, FALSE),
    (54, 130, current_date - 2, FALSE),
    (169, 130, current_date - 3, FALSE),
    (311, 130, current_date - 3, FALSE),
    (65, 130, current_date, FALSE),
    (94, 130, current_date - 1, FALSE),
    (89, 130, current_date - 2, FALSE),
    (83, 130, current_date - 1, FALSE),
    (130, 130, current_date - 3, FALSE),
    (169, 131, current_date - 31, TRUE),
    (54, 131, current_date - 34, FALSE),
    (94, 131, current_date - 34, TRUE),
    (311, 131, current_date - 31, FALSE),
    (130, 131, current_date - 33, TRUE),
    (215, 131, current_date - 32, FALSE),
    (83, 131, current_date - 31, TRUE),
    (281, 131, current_date - 31, TRUE),
    (65, 131, current_date - 33, TRUE),
    (130, 132, current_date - 31, TRUE),
    (82, 132, current_date - 29, TRUE),
    (281, 132, current_date - 32, FALSE),
    (83, 132, current_date - 29, TRUE),
    (311, 132, current_date - 30, FALSE),
    (169, 132, current_date - 29, FALSE),
    (65, 132, current_date - 32, TRUE),
    (100, 132, current_date - 29, TRUE),
    (130, 133, current_date - 9, TRUE),
    (94, 133, current_date - 11, TRUE),
    (169, 133, current_date - 9, TRUE),
    (311, 133, current_date - 8, FALSE),
    (54, 133, current_date - 10, TRUE),
    (216, 133, current_date - 11, TRUE),
    (83, 133, current_date - 9, TRUE),
    (264, 133, current_date - 9, TRUE),
    (167, 134, current_date, FALSE),
    (130, 134, current_date, FALSE),
    (311, 135, current_date, FALSE),
    (83, 135, current_date, FALSE),
    (54, 135, current_date - 2, FALSE),
    (94, 135, current_date, FALSE),
    (235, 136, current_date - 28, TRUE),
    (16, 136, current_date - 29, FALSE),
    (200, 136, current_date - 29, TRUE),
    (54, 136, current_date - 29, TRUE),
    (235, 137, current_date - 26, TRUE),
    (296, 137, current_date - 26, TRUE),
    (200, 137, current_date - 25, FALSE),
    (29, 137, current_date - 25, TRUE),
    (16, 137, current_date - 26, TRUE),
    (169, 137, current_date - 23, TRUE),
    (16, 138, current_date - 1, FALSE),
    (263, 138, current_date - 1, FALSE),
    (167, 139, current_date - 1, FALSE),
    (147, 139, current_date, FALSE),
    (235, 139, current_date - 1, FALSE),
    (200, 139, current_date - 1, FALSE),
    (63, 140, current_date - 2, FALSE),
    (166, 140, current_date - 1, FALSE),
    (16, 140, current_date - 1, FALSE),
    (200, 140, current_date, FALSE),
    (235, 140, current_date, FALSE),
    (16, 141, current_date - 22, TRUE),
    (235, 141, current_date - 20, TRUE),
    (140, 141, current_date - 24, TRUE),
    (200, 141, current_date - 21, FALSE),
    (130, 142, current_date - 19, FALSE),
    (200, 142, current_date - 18, TRUE),
    (307, 142, current_date - 16, FALSE),
    (16, 142, current_date - 16, TRUE),
    (235, 142, current_date - 16, TRUE),
    (173, 142, current_date - 16, TRUE),
    (16, 143, current_date - 3, FALSE),
    (147, 143, current_date - 1, FALSE),
    (218, 143, current_date - 1, FALSE),
    (200, 143, current_date - 2, FALSE),
    (77, 143, current_date - 1, FALSE),
    (235, 143, current_date - 2, FALSE),
    (97, 144, current_date, FALSE),
    (235, 144, current_date - 3, FALSE),
    (169, 144, current_date, FALSE),
    (200, 144, current_date - 1, FALSE),
    (16, 144, current_date - 2, FALSE),
    (147, 144, current_date - 2, FALSE),
    (235, 145, current_date - 3, FALSE),
    (103, 145, current_date, FALSE),
    (200, 145, current_date - 3, FALSE),
    (92, 145, current_date - 2, FALSE),
    (16, 145, current_date, FALSE),
    (232, 146, current_date - 33, TRUE),
    (97, 146, current_date - 33, TRUE),
    (97, 147, current_date - 30, TRUE),
    (280, 147, current_date - 31, TRUE),
    (45, 148, current_date - 1, FALSE),
    (89, 148, current_date - 1, FALSE),
    (263, 150, current_date - 28, TRUE),
    (108, 150, current_date - 28, TRUE),
    (100, 151, current_date - 12, FALSE),
    (319, 152, current_date - 13, TRUE),
    (92, 152, current_date - 11, TRUE),
    (292, 153, current_date, FALSE),
    (20, 153, current_date - 1, FALSE),
    (231, 154, current_date - 3, FALSE),
    (102, 154, current_date - 2, FALSE),
    (29, 155, current_date - 34, TRUE),
    (82, 156, current_date - 21, TRUE),
    (252, 156, current_date - 20, TRUE),
    (307, 157, current_date - 14, FALSE),
    (311, 157, current_date - 14, TRUE),
    (210, 158, current_date - 1, FALSE),
    (255, 158, current_date - 1, FALSE),
    (89, 159, current_date, FALSE),
    (130, 159, current_date - 1, FALSE),
    (108, 160, current_date - 34, TRUE),
    (236, 161, current_date - 9, TRUE),
    (29, 161, current_date - 9, FALSE),
    (235, 162, current_date - 3, TRUE),
    (52, 162, current_date - 7, TRUE),
    (167, 163, current_date - 2, FALSE),
    (210, 163, current_date - 3, FALSE),
    (54, 164, current_date, FALSE),
    (65, 164, current_date - 2, FALSE),
    (102, 165, current_date - 2, FALSE),
    (52, 166, current_date - 22, TRUE),
    (218, 166, current_date - 20, TRUE),
    (170, 166, current_date - 22, FALSE),
    (77, 166, current_date - 24, TRUE),
    (65, 166, current_date - 23, TRUE),
    (218, 167, current_date - 22, TRUE),
    (172, 167, current_date - 18, TRUE),
    (170, 167, current_date - 19, TRUE),
    (52, 167, current_date - 18, FALSE),
    (292, 167, current_date - 19, TRUE),
    (164, 167, current_date - 21, TRUE),
    (77, 168, current_date - 17, FALSE),
    (218, 168, current_date - 18, TRUE),
    (29, 168, current_date - 17, TRUE),
    (172, 168, current_date - 17, FALSE),
    (170, 168, current_date - 16, FALSE),
    (102, 168, current_date - 18, TRUE),
    (52, 168, current_date - 20, TRUE),
    (218, 169, current_date - 2, FALSE),
    (52, 169, current_date, FALSE),
    (218, 170, current_date - 1, FALSE),
    (102, 170, current_date - 2, FALSE),
    (172, 170, current_date - 3, FALSE),
    (29, 170, current_date - 3, FALSE),
    (238, 170, current_date, FALSE),
    (172, 171, current_date - 2, FALSE),
    (52, 171, current_date - 1, FALSE),
    (52, 172, current_date - 28, TRUE),
    (218, 172, current_date - 28, TRUE),
    (231, 172, current_date - 30, TRUE),
    (170, 172, current_date - 29, TRUE),
    (235, 172, current_date - 30, TRUE),
    (170, 173, current_date - 19, TRUE),
    (172, 173, current_date - 17, TRUE),
    (16, 173, current_date - 19, TRUE),
    (218, 173, current_date - 20, TRUE),
    (52, 173, current_date - 17, TRUE),
    (16, 174, current_date - 6, TRUE),
    (307, 174, current_date - 5, FALSE),
    (172, 174, current_date - 4, TRUE),
    (102, 174, current_date - 5, TRUE),
    (52, 174, current_date - 6, FALSE),
    (218, 174, current_date - 2, FALSE),
    (20, 175, current_date - 3, FALSE),
    (52, 175, current_date - 2, FALSE),
    (82, 175, current_date, FALSE),
    (172, 175, current_date, FALSE),
    (218, 175, current_date, FALSE),
    (263, 175, current_date, FALSE),
    (218, 176, current_date - 3, FALSE),
    (288, 176, current_date - 1, FALSE),
    (52, 176, current_date - 3, FALSE),
    (172, 176, current_date - 2, FALSE),
    (102, 176, current_date - 2, FALSE),
    (42, 176, current_date - 3, FALSE),
    (192, 177, current_date - 29, TRUE),
    (7, 177, current_date - 28, TRUE),
    (258, 177, current_date - 25, TRUE),
    (110, 177, current_date - 25, TRUE),
    (126, 177, current_date - 29, TRUE),
    (171, 177, current_date - 29, FALSE),
    (325, 178, current_date - 11, TRUE),
    (79, 178, current_date - 10, FALSE),
    (126, 178, current_date - 11, FALSE),
    (246, 178, current_date - 9, TRUE),
    (192, 178, current_date - 10, TRUE),
    (110, 178, current_date - 7, TRUE),
    (194, 179, current_date - 8, FALSE),
    (126, 179, current_date - 6, TRUE),
    (192, 179, current_date - 6, TRUE),
    (325, 179, current_date - 6, TRUE),
    (79, 179, current_date - 7, TRUE),
    (15, 179, current_date - 6, FALSE),
    (126, 180, current_date - 3, FALSE),
    (330, 180, current_date - 1, FALSE),
    (7, 181, current_date, FALSE),
    (33, 181, current_date, FALSE),
    (126, 181, current_date, FALSE),
    (192, 181, current_date, FALSE),
    (171, 181, current_date - 1, FALSE),
    (171, 182, current_date - 33, TRUE),
    (192, 182, current_date - 33, TRUE),
    (126, 182, current_date - 33, TRUE),
    (340, 182, current_date - 32, FALSE),
    (258, 182, current_date - 33, FALSE),
    (7, 182, current_date - 31, FALSE),
    (325, 183, current_date - 15, FALSE),
    (171, 183, current_date - 16, TRUE),
    (110, 183, current_date - 14, TRUE),
    (79, 183, current_date - 12, TRUE),
    (13, 183, current_date - 12, TRUE),
    (258, 183, current_date - 16, FALSE),
    (192, 183, current_date - 14, TRUE),
    (126, 183, current_date - 16, TRUE),
    (15, 184, current_date - 2, FALSE),
    (126, 184, current_date - 2, FALSE),
    (48, 184, current_date - 2, FALSE),
    (340, 184, current_date - 1, FALSE),
    (192, 185, current_date - 3, FALSE),
    (79, 185, current_date - 3, FALSE),
    (11, 186, current_date - 39, TRUE),
    (78, 186, current_date - 38, FALSE),
    (13, 186, current_date - 35, TRUE),
    (195, 187, current_date - 10, TRUE),
    (48, 187, current_date - 10, TRUE),
    (11, 187, current_date - 9, FALSE),
    (330, 188, current_date - 2, FALSE),
    (11, 188, current_date - 2, FALSE),
    (11, 189, current_date - 3, FALSE),
    (226, 190, current_date, FALSE),
    (137, 190, current_date, FALSE),
    (11, 190, current_date - 3, FALSE),
    (219, 191, current_date - 36, TRUE),
    (11, 191, current_date - 37, FALSE),
    (13, 191, current_date - 36, FALSE),
    (11, 192, current_date - 12, TRUE),
    (13, 192, current_date - 14, TRUE),
    (171, 192, current_date - 13, TRUE),
    (162, 192, current_date - 11, TRUE),
    (7, 192, current_date - 13, FALSE),
    (11, 193, current_date - 1, FALSE),
    (189, 193, current_date - 2, FALSE),
    (137, 193, current_date, FALSE),
    (11, 194, current_date - 3, FALSE),
    (78, 195, current_date - 20, TRUE),
    (337, 195, current_date - 18, TRUE),
    (110, 195, current_date - 18, FALSE),
    (124, 195, current_date - 20, TRUE),
    (246, 195, current_date - 17, TRUE),
    (110, 196, current_date - 6, TRUE),
    (78, 196, current_date - 4, FALSE),
    (337, 196, current_date - 5, TRUE),
    (258, 196, current_date - 7, TRUE),
    (219, 196, current_date - 6, TRUE),
    (78, 197, current_date - 3, TRUE),
    (110, 197, current_date - 3, TRUE),
    (337, 197, current_date - 6, TRUE),
    (337, 198, current_date - 1, FALSE),
    (7, 198, current_date - 3, FALSE),
    (78, 199, current_date, FALSE),
    (110, 199, current_date, FALSE),
    (79, 199, current_date - 1, FALSE),
    (177, 199, current_date - 2, FALSE),
    (134, 199, current_date, FALSE),
    (337, 199, current_date, FALSE),
    (110, 200, current_date - 35, FALSE),
    (11, 200, current_date - 34, FALSE),
    (258, 200, current_date - 35, TRUE),
    (78, 200, current_date - 31, TRUE),
    (126, 201, current_date - 32, FALSE),
    (78, 201, current_date - 31, TRUE),
    (110, 201, current_date - 32, FALSE),
    (78, 202, current_date - 29, TRUE),
    (110, 202, current_date - 29, TRUE),
    (69, 203, current_date, FALSE),
    (137, 203, current_date, FALSE),
    (226, 203, current_date - 3, FALSE),
    (78, 203, current_date - 2, FALSE),
    (110, 203, current_date - 2, FALSE),
    (192, 204, current_date - 3, FALSE),
    (79, 204, current_date - 3, FALSE),
    (110, 204, current_date, FALSE),
    (78, 204, current_date - 2, FALSE),
    (192, 205, current_date - 36, TRUE),
    (40, 205, current_date - 35, TRUE),
    (110, 205, current_date - 37, TRUE),
    (219, 205, current_date - 37, TRUE),
    (137, 205, current_date - 36, TRUE),
    (40, 206, current_date - 27, TRUE),
    (7, 206, current_date - 25, TRUE),
    (137, 206, current_date - 29, TRUE),
    (15, 206, current_date - 26, FALSE),
    (137, 207, current_date - 12, TRUE),
    (40, 207, current_date - 14, TRUE),
    (258, 207, current_date - 15, TRUE),
    (337, 207, current_date - 13, TRUE),
    (48, 207, current_date - 14, TRUE),
    (246, 207, current_date - 15, TRUE),
    (40, 208, current_date - 2, FALSE),
    (126, 208, current_date - 2, FALSE),
    (219, 208, current_date, FALSE),
    (137, 208, current_date - 3, FALSE),
    (137, 209, current_date, FALSE),
    (48, 209, current_date - 3, FALSE),
    (40, 209, current_date, FALSE),
    (79, 209, current_date - 1, FALSE),
    (153, 210, current_date, FALSE),
    (137, 210, current_date - 1, FALSE),
    (340, 210, current_date, FALSE),
    (137, 211, current_date - 28, FALSE),
    (110, 211, current_date - 24, TRUE),
    (126, 211, current_date - 28, TRUE),
    (246, 212, current_date - 13, TRUE),
    (219, 212, current_date - 14, TRUE),
    (192, 212, current_date - 10, TRUE),
    (137, 212, current_date - 10, TRUE),
    (40, 212, current_date - 11, TRUE),
    (192, 213, current_date, FALSE),
    (153, 214, current_date, FALSE),
    (137, 214, current_date - 1, FALSE),
    (40, 215, current_date - 19, TRUE),
    (7, 215, current_date - 17, FALSE),
    (192, 215, current_date - 17, TRUE),
    (124, 215, current_date - 18, TRUE),
    (329, 215, current_date - 19, TRUE),
    (124, 216, current_date - 9, TRUE),
    (258, 216, current_date - 10, TRUE),
    (329, 216, current_date - 13, FALSE),
    (195, 216, current_date - 10, TRUE),
    (7, 216, current_date - 11, TRUE),
    (189, 216, current_date - 12, TRUE),
    (177, 216, current_date - 13, TRUE),
    (124, 217, current_date - 4, TRUE),
    (15, 217, current_date - 3, TRUE),
    (258, 217, current_date - 1, TRUE),
    (195, 217, current_date - 2, TRUE),
    (177, 217, current_date - 3, TRUE),
    (7, 217, current_date - 4, TRUE),
    (137, 217, current_date - 4, TRUE),
    (226, 217, current_date - 1, TRUE),
    (330, 218, current_date - 2, FALSE),
    (7, 218, current_date - 2, FALSE),
    (177, 218, current_date - 3, FALSE),
    (195, 218, current_date - 3, FALSE),
    (15, 218, current_date, FALSE),
    (226, 218, current_date - 3, FALSE),
    (7, 219, current_date - 2, FALSE),
    (226, 219, current_date - 1, FALSE),
    (177, 219, current_date - 3, FALSE),
    (195, 219, current_date - 2, FALSE),
    (192, 219, current_date - 2, FALSE),
    (124, 220, current_date - 24, TRUE),
    (126, 220, current_date - 26, TRUE),
    (7, 220, current_date - 22, FALSE),
    (329, 220, current_date - 23, TRUE),
    (192, 220, current_date - 22, TRUE),
    (329, 221, current_date - 20, TRUE),
    (7, 221, current_date - 20, TRUE),
    (124, 221, current_date - 16, FALSE),
    (325, 221, current_date - 16, FALSE),
    (195, 222, current_date - 10, TRUE),
    (48, 222, current_date - 10, TRUE),
    (177, 222, current_date - 14, TRUE),
    (124, 222, current_date - 11, TRUE),
    (171, 222, current_date - 10, TRUE),
    (329, 222, current_date - 10, TRUE),
    (192, 222, current_date - 12, TRUE),
    (7, 222, current_date - 10, TRUE),
    (226, 223, current_date, FALSE),
    (195, 223, current_date - 2, FALSE),
    (40, 223, current_date - 2, FALSE),
    (7, 223, current_date - 3, FALSE),
    (329, 223, current_date - 1, FALSE),
    (177, 223, current_date - 2, FALSE),
    (7, 224, current_date, FALSE),
    (177, 224, current_date - 1, FALSE),
    (226, 224, current_date - 3, FALSE),
    (226, 225, current_date, FALSE),
    (329, 225, current_date - 2, FALSE),
    (79, 225, current_date - 1, FALSE),
    (177, 225, current_date - 3, FALSE),
    (7, 225, current_date - 2, FALSE),
    (219, 225, current_date - 3, FALSE),
    (137, 225, current_date - 1, FALSE),
    (69, 226, current_date - 18, FALSE),
    (171, 226, current_date - 17, TRUE),
    (11, 227, current_date - 8, TRUE),
    (69, 227, current_date - 9, TRUE),
    (219, 227, current_date - 12, TRUE),
    (134, 228, current_date, FALSE),
    (15, 228, current_date - 3, FALSE),
    (69, 228, current_date - 1, FALSE),
    (246, 228, current_date - 1, FALSE),
    (162, 228, current_date - 1, FALSE),
    (177, 229, current_date, FALSE),
    (189, 229, current_date - 1, FALSE),
    (69, 229, current_date - 1, FALSE),
    (13, 230, current_date - 36, TRUE),
    (69, 230, current_date - 36, TRUE),
    (69, 231, current_date - 21, TRUE),
    (329, 231, current_date - 20, FALSE),
    (69, 232, current_date - 1, TRUE),
    (110, 232, current_date - 2, TRUE),
    (78, 232, current_date - 1, TRUE),
    (126, 233, current_date - 1, FALSE),
    (137, 233, current_date - 1, FALSE),
    (69, 233, current_date - 2, FALSE),
    (69, 234, current_date - 1, FALSE),
    (69, 235, current_date - 3, FALSE),
    (177, 235, current_date, FALSE),
    (134, 235, current_date, FALSE),
    (171, 235, current_date - 1, FALSE),
    (189, 236, current_date - 34, TRUE),
    (162, 236, current_date - 37, FALSE),
    (219, 236, current_date - 33, TRUE),
    (15, 236, current_date - 36, TRUE),
    (48, 236, current_date - 36, TRUE),
    (219, 237, current_date - 8, TRUE),
    (162, 237, current_date - 8, TRUE),
    (15, 237, current_date - 9, TRUE),
    (48, 237, current_date - 10, TRUE),
    (13, 237, current_date - 9, TRUE),
    (337, 237, current_date - 10, TRUE),
    (194, 237, current_date - 11, TRUE),
    (189, 237, current_date - 9, FALSE),
    (195, 237, current_date - 10, TRUE),
    (15, 238, current_date - 5, TRUE),
    (194, 238, current_date - 7, TRUE),
    (48, 238, current_date - 7, FALSE),
    (189, 238, current_date - 6, TRUE),
    (162, 238, current_date - 4, TRUE),
    (162, 239, current_date - 1, FALSE),
    (48, 239, current_date - 1, FALSE),
    (189, 239, current_date - 1, FALSE),
    (7, 240, current_date - 3, FALSE),
    (15, 240, current_date - 2, FALSE),
    (219, 240, current_date - 1, FALSE),
    (7, 241, current_date - 1, FALSE),
    (192, 241, current_date - 1, FALSE),
    (189, 241, current_date - 3, FALSE),
    (219, 241, current_date - 2, FALSE),
    (15, 241, current_date - 2, FALSE),
    (126, 242, current_date - 27, TRUE),
    (48, 242, current_date - 28, FALSE),
    (15, 242, current_date - 25, FALSE),
    (219, 242, current_date - 25, TRUE),
    (189, 242, current_date - 25, TRUE),
    (137, 242, current_date - 26, TRUE),
    (162, 242, current_date - 25, TRUE),
    (162, 243, current_date - 10, TRUE),
    (189, 243, current_date - 13, TRUE),
    (219, 243, current_date - 14, TRUE),
    (15, 243, current_date - 11, FALSE),
    (192, 243, current_date - 12, TRUE),
    (195, 243, current_date - 11, TRUE),
    (194, 243, current_date - 13, TRUE),
    (48, 243, current_date - 11, TRUE),
    (194, 244, current_date - 8, TRUE),
    (219, 244, current_date - 8, TRUE),
    (11, 244, current_date - 7, TRUE),
    (189, 244, current_date - 6, TRUE),
    (162, 244, current_date - 8, TRUE),
    (48, 244, current_date - 7, TRUE),
    (15, 244, current_date - 6, TRUE),
    (162, 245, current_date - 3, FALSE),
    (15, 245, current_date - 3, FALSE),
    (219, 245, current_date - 3, FALSE),
    (48, 245, current_date - 2, FALSE),
    (110, 245, current_date - 2, FALSE),
    (189, 245, current_date - 2, FALSE),
    (340, 246, current_date, FALSE),
    (15, 246, current_date - 1, FALSE),
    (189, 246, current_date, FALSE),
    (48, 246, current_date, FALSE),
    (162, 246, current_date - 1, FALSE),
    (219, 246, current_date - 2, FALSE),
    (189, 247, current_date, FALSE),
    (48, 247, current_date - 2, FALSE),
    (219, 247, current_date - 2, FALSE),
    (171, 247, current_date - 2, FALSE),
    (15, 247, current_date, FALSE),
    (152, 248, current_date - 34, TRUE),
    (198, 248, current_date - 36, TRUE),
    (10, 248, current_date - 35, TRUE),
    (152, 249, current_date - 28, TRUE),
    (198, 249, current_date - 28, TRUE),
    (10, 249, current_date - 32, FALSE),
    (59, 249, current_date - 28, FALSE),
    (44, 249, current_date - 29, TRUE),
    (56, 250, current_date - 3, FALSE),
    (23, 250, current_date - 3, FALSE),
    (95, 250, current_date - 1, FALSE),
    (151, 251, current_date - 1, FALSE),
    (31, 251, current_date - 1, FALSE),
    (56, 252, current_date - 3, FALSE),
    (234, 252, current_date - 2, FALSE),
    (95, 252, current_date, FALSE),
    (31, 252, current_date - 2, FALSE),
    (62, 252, current_date, FALSE),
    (152, 252, current_date - 2, FALSE),
    (59, 253, current_date - 27, TRUE),
    (230, 253, current_date - 27, TRUE),
    (198, 253, current_date - 31, TRUE),
    (10, 253, current_date - 28, TRUE),
    (249, 253, current_date - 29, TRUE),
    (152, 253, current_date - 27, TRUE),
    (198, 254, current_date - 30, TRUE),
    (270, 254, current_date - 29, FALSE),
    (291, 254, current_date - 27, TRUE),
    (152, 254, current_date - 30, TRUE),
    (10, 254, current_date - 29, TRUE),
    (23, 255, current_date - 13, TRUE),
    (291, 255, current_date - 10, TRUE),
    (297, 255, current_date - 14, TRUE),
    (152, 255, current_date - 12, TRUE),
    (10, 255, current_date - 14, FALSE),
    (152, 256, current_date - 2, FALSE),
    (56, 256, current_date - 1, FALSE),
    (22, 256, current_date, FALSE),
    (23, 256, current_date, FALSE),
    (62, 256, current_date - 2, FALSE),
    (95, 256, current_date, FALSE),
    (59, 256, current_date - 3, FALSE),
    (31, 256, current_date, FALSE),
    (138, 257, current_date - 1, FALSE),
    (230, 257, current_date, FALSE),
    (346, 257, current_date - 3, FALSE),
    (23, 257, current_date - 1, FALSE),
    (95, 257, current_date - 3, FALSE),
    (22, 257, current_date - 3, FALSE),
    (62, 257, current_date - 1, FALSE),
    (56, 257, current_date - 2, FALSE),
    (152, 257, current_date - 3, FALSE),
    (151, 258, current_date - 31, TRUE),
    (293, 258, current_date - 35, FALSE),
    (32, 258, current_date - 32, TRUE),
    (187, 259, current_date - 4, TRUE),
    (148, 259, current_date - 5, TRUE),
    (151, 259, current_date - 2, TRUE),
    (230, 260, current_date - 1, FALSE),
    (151, 260, current_date - 1, FALSE),
    (138, 260, current_date - 2, FALSE),
    (187, 261, current_date, FALSE),
    (151, 261, current_date, FALSE),
    (197, 261, current_date, FALSE),
    (138, 261, current_date, FALSE),
    (220, 261, current_date, FALSE),
    (270, 261, current_date, FALSE),
    (230, 261, current_date - 1, FALSE),
    (187, 262, current_date - 1, FALSE),
    (8, 262, current_date, FALSE),
    (138, 262, current_date, FALSE),
    (151, 262, current_date - 2, FALSE),
    (234, 263, current_date - 25, TRUE),
    (8, 264, current_date - 24, TRUE),
    (10, 264, current_date - 22, TRUE),
    (151, 264, current_date - 21, TRUE),
    (293, 265, current_date - 16, TRUE),
    (346, 265, current_date - 18, TRUE),
    (145, 265, current_date - 18, TRUE),
    (151, 265, current_date - 16, TRUE),
    (117, 266, current_date - 1, FALSE),
    (138, 266, current_date - 1, FALSE),
    (56, 266, current_date, FALSE),
    (151, 266, current_date, FALSE),
    (175, 266, current_date, FALSE),
    (187, 266, current_date - 2, FALSE),
    (151, 267, current_date - 2, FALSE),
    (187, 267, current_date - 3, FALSE),
    (95, 267, current_date - 2, FALSE),
    (44, 267, current_date - 2, FALSE),
    (138, 268, current_date, FALSE),
    (187, 268, current_date - 2, FALSE),
    (62, 268, current_date, FALSE),
    (151, 268, current_date - 3, FALSE),
    (152, 269, current_date - 28, TRUE),
    (297, 269, current_date - 29, TRUE),
    (151, 269, current_date - 28, TRUE),
    (270, 270, current_date - 22, FALSE),
    (151, 270, current_date - 22, TRUE),
    (187, 271, current_date - 3, FALSE),
    (151, 271, current_date, FALSE),
    (59, 271, current_date - 1, FALSE),
    (227, 271, current_date - 1, FALSE),
    (32, 272, current_date - 2, FALSE),
    (152, 272, current_date - 2, FALSE),
    (138, 272, current_date, FALSE),
    (72, 272, current_date, FALSE),
    (146, 272, current_date, FALSE),
    (187, 272, current_date - 1, FALSE),
    (197, 272, current_date, FALSE),
    (151, 272, current_date - 3, FALSE),
    (44, 273, current_date - 26, TRUE),
    (32, 273, current_date - 26, FALSE),
    (23, 274, current_date - 12, TRUE),
    (152, 274, current_date - 10, TRUE),
    (151, 274, current_date - 8, TRUE),
    (72, 274, current_date - 9, TRUE),
    (151, 275, current_date - 4, TRUE),
    (23, 275, current_date - 4, TRUE),
    (44, 275, current_date - 1, TRUE),
    (187, 275, current_date - 5, TRUE),
    (10, 275, current_date - 5, TRUE),
    (197, 276, current_date, FALSE),
    (145, 276, current_date - 1, FALSE),
    (291, 276, current_date - 2, FALSE),
    (187, 276, current_date - 3, FALSE),
    (151, 276, current_date - 2, FALSE),
    (138, 277, current_date, FALSE),
    (146, 277, current_date, FALSE),
    (187, 277, current_date - 1, FALSE),
    (138, 278, current_date - 2, FALSE),
    (151, 278, current_date - 1, FALSE),
    (346, 278, current_date - 2, FALSE),
    (187, 278, current_date, FALSE),
    (145, 278, current_date, FALSE),
    (293, 279, current_date - 36, TRUE),
    (198, 279, current_date - 37, FALSE),
    (8, 279, current_date - 34, TRUE),
    (346, 279, current_date - 36, TRUE),
    (44, 279, current_date - 36, TRUE),
    (10, 279, current_date - 37, TRUE),
    (8, 280, current_date - 27, TRUE),
    (230, 280, current_date - 27, FALSE),
    (44, 280, current_date - 28, TRUE),
    (293, 280, current_date - 25, TRUE),
    (346, 280, current_date - 28, TRUE),
    (270, 280, current_date - 25, TRUE),
    (8, 281, current_date - 4, TRUE),
    (18, 281, current_date - 1, TRUE),
    (346, 281, current_date - 1, TRUE),
    (249, 281, current_date - 4, TRUE),
    (293, 281, current_date - 2, TRUE),
    (293, 282, current_date - 1, FALSE),
    (346, 282, current_date - 1, FALSE),
    (224, 282, current_date - 3, FALSE),
    (8, 282, current_date - 2, FALSE),
    (18, 282, current_date, FALSE),
    (293, 283, current_date - 3, FALSE),
    (8, 283, current_date, FALSE),
    (346, 283, current_date - 2, FALSE),
    (44, 283, current_date - 1, FALSE),
    (346, 284, current_date - 3, FALSE),
    (293, 284, current_date, FALSE),
    (8, 284, current_date - 3, FALSE),
    (95, 284, current_date - 1, FALSE),
    (18, 284, current_date, FALSE),
    (318, 284, current_date - 2, FALSE),
    (44, 284, current_date - 2, FALSE),
    (8, 285, current_date - 36, TRUE),
    (159, 285, current_date - 32, TRUE),
    (249, 285, current_date - 32, FALSE),
    (293, 285, current_date - 33, FALSE),
    (346, 285, current_date - 32, TRUE),
    (44, 285, current_date - 33, FALSE),
    (8, 286, current_date - 20, TRUE),
    (346, 286, current_date - 20, FALSE),
    (230, 286, current_date - 19, TRUE),
    (184, 286, current_date - 18, FALSE),
    (44, 286, current_date - 21, TRUE),
    (293, 286, current_date - 19, TRUE),
    (8, 287, current_date - 17, TRUE),
    (291, 287, current_date - 17, TRUE),
    (293, 287, current_date - 15, TRUE),
    (44, 287, current_date - 15, TRUE),
    (346, 287, current_date - 15, TRUE),
    (293, 288, current_date - 2, FALSE),
    (346, 288, current_date - 1, FALSE),
    (22, 288, current_date - 3, FALSE),
    (270, 288, current_date - 1, FALSE),
    (44, 288, current_date - 1, FALSE),
    (8, 288, current_date - 1, FALSE),
    (18, 289, current_date - 1, FALSE),
    (297, 289, current_date - 1, FALSE),
    (293, 289, current_date, FALSE),
    (8, 289, current_date - 3, FALSE),
    (44, 289, current_date - 1, FALSE),
    (270, 290, current_date - 12, TRUE),
    (59, 290, current_date - 14, TRUE),
    (175, 290, current_date - 14, FALSE),
    (145, 290, current_date - 14, FALSE),
    (234, 290, current_date - 14, TRUE),
    (291, 290, current_date - 13, FALSE),
    (249, 291, current_date - 4, TRUE),
    (270, 291, current_date - 6, FALSE),
    (59, 291, current_date - 7, TRUE),
    (175, 291, current_date - 4, TRUE),
    (145, 291, current_date - 7, TRUE),
    (291, 291, current_date - 4, TRUE),
    (270, 292, current_date - 3, FALSE),
    (145, 292, current_date, FALSE),
    (175, 292, current_date, FALSE),
    (31, 293, current_date - 2, FALSE),
    (32, 293, current_date - 3, FALSE),
    (59, 294, current_date - 1, FALSE),
    (32, 294, current_date - 2, FALSE),
    (138, 294, current_date - 2, FALSE),
    (145, 294, current_date, FALSE),
    (291, 294, current_date - 3, FALSE),
    (297, 294, current_date, FALSE),
    (249, 294, current_date - 2, FALSE),
    (270, 294, current_date - 2, FALSE),
    (10, 295, current_date - 26, TRUE),
    (59, 295, current_date - 26, TRUE),
    (291, 295, current_date - 26, TRUE),
    (145, 295, current_date - 25, TRUE),
    (270, 295, current_date - 26, TRUE),
    (32, 295, current_date - 25, TRUE),
    (291, 296, current_date - 25, TRUE),
    (270, 296, current_date - 26, TRUE),
    (145, 296, current_date - 23, FALSE),
    (249, 296, current_date - 26, TRUE),
    (59, 296, current_date - 25, TRUE),
    (346, 296, current_date - 26, TRUE),
    (32, 296, current_date - 24, FALSE),
    (234, 296, current_date - 23, TRUE),
    (224, 297, current_date - 3, FALSE),
    (32, 297, current_date - 1, FALSE),
    (270, 297, current_date - 3, FALSE),
    (59, 297, current_date - 1, FALSE),
    (145, 297, current_date - 3, FALSE),
    (291, 297, current_date - 1, FALSE),
    (44, 297, current_date - 3, FALSE),
    (249, 297, current_date - 3, FALSE),
    (32, 298, current_date, FALSE),
    (297, 298, current_date, FALSE),
    (291, 298, current_date - 3, FALSE),
    (59, 298, current_date - 2, FALSE),
    (249, 298, current_date - 2, FALSE),
    (31, 298, current_date, FALSE),
    (291, 299, current_date - 11, TRUE),
    (318, 299, current_date - 9, TRUE),
    (297, 299, current_date - 10, TRUE),
    (230, 299, current_date - 12, TRUE),
    (234, 299, current_date - 11, TRUE),
    (318, 300, current_date - 6, TRUE),
    (234, 300, current_date - 4, FALSE),
    (230, 300, current_date - 2, TRUE),
    (152, 301, current_date - 3, FALSE),
    (178, 301, current_date - 3, FALSE),
    (234, 301, current_date, FALSE),
    (184, 301, current_date - 3, FALSE),
    (22, 301, current_date - 3, FALSE),
    (230, 301, current_date, FALSE),
    (318, 301, current_date - 3, FALSE),
    (297, 301, current_date - 1, FALSE),
    (347, 301, current_date - 2, FALSE),
    (347, 302, current_date - 2, FALSE),
    (44, 302, current_date, FALSE),
    (230, 302, current_date, FALSE),
    (178, 302, current_date - 1, FALSE),
    (234, 302, current_date - 2, FALSE),
    (297, 302, current_date - 1, FALSE),
    (318, 302, current_date - 3, FALSE),
    (318, 303, current_date - 38, TRUE),
    (184, 303, current_date - 35, TRUE),
    (234, 303, current_date - 35, TRUE),
    (230, 303, current_date - 36, TRUE),
    (318, 304, current_date - 29, TRUE),
    (234, 304, current_date - 30, TRUE),
    (297, 304, current_date - 28, TRUE),
    (184, 304, current_date - 26, TRUE),
    (230, 304, current_date - 29, TRUE),
    (234, 305, current_date - 24, TRUE),
    (318, 305, current_date - 26, TRUE),
    (230, 305, current_date - 24, TRUE),
    (138, 306, current_date - 2, FALSE),
    (178, 306, current_date - 1, FALSE),
    (178, 307, current_date - 1, FALSE),
    (234, 307, current_date - 2, FALSE),
    (145, 307, current_date - 1, FALSE),
    (234, 308, current_date - 3, FALSE),
    (347, 308, current_date - 1, FALSE),
    (270, 309, current_date - 37, TRUE),
    (8, 310, current_date - 28, TRUE),
    (145, 311, current_date - 25, TRUE),
    (148, 311, current_date - 22, TRUE),
    (62, 312, current_date - 2, FALSE),
    (224, 312, current_date - 3, FALSE),
    (72, 312, current_date, FALSE),
    (227, 312, current_date - 2, FALSE),
    (148, 312, current_date - 2, FALSE),
    (178, 312, current_date, FALSE),
    (224, 313, current_date - 1, FALSE),
    (291, 313, current_date - 2, FALSE),
    (138, 313, current_date, FALSE),
    (18, 313, current_date, FALSE),
    (224, 314, current_date - 2, FALSE),
    (291, 314, current_date, FALSE),
    (62, 314, current_date, FALSE),
    (227, 314, current_date - 1, FALSE),
    (32, 314, current_date - 1, FALSE),
    (148, 315, current_date - 20, TRUE),
    (72, 315, current_date - 20, FALSE),
    (23, 315, current_date - 20, TRUE),
    (72, 316, current_date - 14, TRUE),
    (293, 316, current_date - 14, TRUE),
    (148, 316, current_date - 14, TRUE),
    (318, 317, current_date - 7, TRUE),
    (224, 317, current_date - 3, TRUE),
    (148, 317, current_date - 6, TRUE),
    (72, 317, current_date - 6, TRUE),
    (152, 318, current_date, FALSE),
    (224, 318, current_date - 3, FALSE),
    (59, 318, current_date - 2, FALSE),
    (151, 319, current_date - 1, FALSE),
    (227, 319, current_date, FALSE),
    (224, 319, current_date - 2, FALSE),
    (318, 320, current_date - 2, FALSE),
    (117, 320, current_date, FALSE),
    (300, 321, current_date - 24, TRUE),
    (30, 321, current_date - 25, FALSE),
    (35, 321, current_date - 24, FALSE),
    (109, 321, current_date - 26, TRUE),
    (34, 321, current_date - 23, TRUE),
    (267, 321, current_date - 24, TRUE),
    (139, 322, current_date - 22, TRUE),
    (53, 322, current_date - 21, TRUE),
    (67, 322, current_date - 21, TRUE),
    (35, 322, current_date - 25, TRUE),
    (300, 322, current_date - 24, TRUE),
    (39, 322, current_date - 22, TRUE),
    (109, 322, current_date - 22, TRUE),
    (271, 322, current_date - 25, TRUE),
    (109, 323, current_date - 12, FALSE),
    (35, 323, current_date - 11, TRUE),
    (30, 323, current_date - 12, TRUE),
    (39, 323, current_date - 14, TRUE),
    (300, 323, current_date - 14, TRUE),
    (181, 323, current_date - 14, TRUE),
    (106, 323, current_date - 11, TRUE),
    (67, 323, current_date - 13, TRUE),
    (106, 324, current_date - 1, FALSE),
    (250, 324, current_date - 1, FALSE),
    (271, 324, current_date - 2, FALSE),
    (205, 325, current_date - 3, FALSE),
    (109, 325, current_date - 1, FALSE),
    (300, 325, current_date - 2, FALSE),
    (106, 325, current_date, FALSE),
    (343, 325, current_date - 2, FALSE),
    (109, 326, current_date - 29, FALSE),
    (67, 326, current_date - 32, TRUE),
    (30, 326, current_date - 33, TRUE),
    (9, 326, current_date - 32, TRUE),
    (39, 326, current_date - 29, TRUE),
    (155, 327, current_date - 15, TRUE),
    (39, 327, current_date - 17, TRUE),
    (67, 327, current_date - 15, TRUE),
    (109, 327, current_date - 14, TRUE),
    (35, 327, current_date - 18, FALSE),
    (30, 327, current_date - 15, TRUE),
    (300, 327, current_date - 15, TRUE),
    (139, 327, current_date - 15, TRUE),
    (343, 327, current_date - 18, TRUE),
    (53, 328, current_date - 2, FALSE),
    (271, 328, current_date - 2, FALSE),
    (106, 328, current_date - 2, FALSE),
    (109, 328, current_date, FALSE),
    (25, 328, current_date, FALSE),
    (39, 328, current_date - 3, FALSE),
    (67, 328, current_date - 3, FALSE),
    (35, 328, current_date, FALSE),
    (300, 328, current_date - 2, FALSE),
    (155, 329, current_date - 1, FALSE),
    (39, 329, current_date - 1, FALSE),
    (300, 329, current_date - 2, FALSE),
    (106, 329, current_date - 3, FALSE),
    (139, 329, current_date, FALSE),
    (109, 329, current_date - 2, FALSE),
    (67, 329, current_date - 1, FALSE),
    (250, 329, current_date - 1, FALSE),
    (109, 330, current_date, FALSE),
    (67, 330, current_date - 1, FALSE),
    (300, 330, current_date - 1, FALSE),
    (39, 330, current_date - 3, FALSE),
    (345, 330, current_date, FALSE),
    (253, 331, current_date - 33, FALSE),
    (274, 331, current_date - 32, TRUE),
    (267, 331, current_date - 33, TRUE),
    (301, 331, current_date - 31, TRUE),
    (39, 332, current_date - 12, TRUE),
    (139, 332, current_date - 11, TRUE),
    (301, 332, current_date - 13, TRUE),
    (274, 332, current_date - 9, TRUE),
    (53, 332, current_date - 9, TRUE),
    (343, 332, current_date - 12, TRUE),
    (141, 333, current_date - 3, TRUE),
    (274, 333, current_date - 2, TRUE),
    (106, 333, current_date - 4, TRUE),
    (343, 334, current_date - 2, FALSE),
    (301, 334, current_date - 1, FALSE),
    (274, 334, current_date - 2, FALSE),
    (139, 334, current_date, FALSE),
    (241, 334, current_date, FALSE),
    (343, 335, current_date, FALSE),
    (139, 335, current_date - 1, FALSE),
    (274, 335, current_date, FALSE),
    (205, 335, current_date - 1, FALSE),
    (301, 335, current_date - 1, FALSE),
    (143, 336, current_date, FALSE),
    (345, 336, current_date, FALSE),
    (301, 336, current_date - 2, FALSE),
    (274, 336, current_date - 2, FALSE),
    (25, 336, current_date - 2, FALSE),
    (139, 337, current_date - 30, TRUE),
    (253, 337, current_date - 29, FALSE),
    (181, 337, current_date - 30, TRUE),
    (301, 337, current_date - 29, FALSE),
    (303, 337, current_date - 29, TRUE),
    (274, 337, current_date - 30, FALSE),
    (343, 337, current_date - 28, TRUE),
    (35, 337, current_date - 29, TRUE),
    (53, 338, current_date - 18, TRUE),
    (274, 338, current_date - 15, TRUE),
    (139, 338, current_date - 15, TRUE),
    (301, 338, current_date - 19, TRUE),
    (300, 338, current_date - 18, TRUE),
    (343, 338, current_date - 19, FALSE),
    (345, 339, current_date - 1, FALSE),
    (343, 339, current_date, FALSE),
    (301, 339, current_date - 3, FALSE),
    (139, 339, current_date - 1, FALSE),
    (267, 339, current_date - 2, FALSE),
    (274, 339, current_date, FALSE),
    (53, 339, current_date - 2, FALSE),
    (181, 339, current_date - 3, FALSE),
    (301, 340, current_date - 2, FALSE),
    (343, 340, current_date - 1, FALSE),
    (139, 340, current_date - 2, FALSE),
    (181, 341, current_date - 33, TRUE),
    (303, 341, current_date - 33, TRUE),
    (67, 341, current_date - 33, TRUE),
    (343, 341, current_date - 32, FALSE),
    (139, 341, current_date - 31, TRUE),
    (253, 342, current_date - 30, FALSE),
    (303, 342, current_date - 29, TRUE),
    (301, 342, current_date - 32, TRUE),
    (274, 342, current_date - 32, TRUE),
    (241, 342, current_date - 30, TRUE),
    (274, 343, current_date - 9, TRUE),
    (39, 343, current_date - 9, TRUE),
    (301, 343, current_date - 13, TRUE),
    (139, 343, current_date - 9, TRUE),
    (53, 343, current_date - 12, TRUE),
    (343, 343, current_date - 11, TRUE),
    (109, 343, current_date - 13, TRUE),
    (301, 344, current_date - 2, FALSE),
    (274, 344, current_date, FALSE),
    (343, 344, current_date - 3, FALSE),
    (53, 344, current_date, FALSE),
    (345, 344, current_date - 1, FALSE),
    (139, 344, current_date - 3, FALSE),
    (306, 344, current_date - 1, FALSE),
    (301, 345, current_date - 2, FALSE),
    (205, 345, current_date - 3, FALSE),
    (343, 346, current_date - 2, FALSE),
    (274, 346, current_date, FALSE),
    (143, 346, current_date, FALSE),
    (39, 346, current_date - 3, FALSE),
    (109, 346, current_date, FALSE),
    (9, 347, current_date - 29, TRUE),
    (241, 347, current_date - 30, TRUE),
    (67, 347, current_date - 32, TRUE),
    (25, 347, current_date - 28, TRUE),
    (267, 347, current_date - 32, TRUE),
    (141, 348, current_date - 10, TRUE),
    (186, 348, current_date - 9, TRUE),
    (25, 348, current_date - 9, TRUE),
    (271, 348, current_date - 8, TRUE),
    (267, 349, current_date - 2, FALSE),
    (300, 349, current_date - 2, FALSE),
    (267, 350, current_date - 3, FALSE),
    (267, 351, current_date - 22, TRUE),
    (301, 351, current_date - 22, FALSE),
    (186, 351, current_date - 26, TRUE),
    (25, 351, current_date - 24, TRUE),
    (186, 352, current_date - 15, TRUE),
    (271, 352, current_date - 12, TRUE),
    (141, 352, current_date - 14, TRUE),
    (30, 352, current_date - 11, TRUE),
    (25, 352, current_date - 12, TRUE),
    (25, 353, current_date - 9, TRUE),
    (106, 353, current_date - 10, TRUE),
    (141, 353, current_date - 9, TRUE),
    (186, 353, current_date - 10, TRUE),
    (109, 353, current_date - 11, TRUE),
    (35, 353, current_date - 12, TRUE),
    (241, 354, current_date, FALSE),
    (25, 354, current_date - 2, FALSE),
    (39, 354, current_date, FALSE),
    (139, 354, current_date - 3, FALSE),
    (186, 354, current_date - 2, FALSE),
    (106, 354, current_date - 2, FALSE),
    (141, 355, current_date, FALSE),
    (343, 355, current_date, FALSE),
    (181, 356, current_date - 9, TRUE),
    (155, 356, current_date - 5, TRUE),
    (205, 356, current_date - 9, TRUE),
    (300, 356, current_date - 7, FALSE),
    (34, 356, current_date - 7, TRUE),
    (271, 356, current_date - 9, TRUE),
    (155, 357, current_date - 4, TRUE),
    (106, 357, current_date - 5, TRUE),
    (181, 357, current_date - 6, TRUE),
    (67, 357, current_date - 6, TRUE),
    (34, 357, current_date - 2, TRUE),
    (271, 357, current_date - 6, FALSE),
    (53, 357, current_date - 2, TRUE),
    (205, 357, current_date - 3, FALSE),
    (181, 358, current_date, FALSE),
    (34, 358, current_date - 1, FALSE),
    (155, 358, current_date - 3, FALSE),
    (205, 358, current_date, FALSE),
    (39, 358, current_date - 2, FALSE),
    (271, 358, current_date - 1, FALSE),
    (25, 358, current_date - 1, FALSE),
    (34, 359, current_date, FALSE),
    (155, 359, current_date - 1, FALSE),
    (181, 359, current_date, FALSE),
    (205, 359, current_date - 2, FALSE),
    (271, 359, current_date, FALSE),
    (345, 359, current_date, FALSE),
    (343, 359, current_date - 2, FALSE),
    (34, 360, current_date - 31, TRUE),
    (67, 360, current_date - 30, TRUE),
    (155, 360, current_date - 30, TRUE),
    (267, 361, current_date - 22, TRUE),
    (155, 361, current_date - 19, TRUE),
    (139, 361, current_date - 18, TRUE),
    (181, 361, current_date - 21, TRUE),
    (25, 361, current_date - 19, FALSE),
    (34, 361, current_date - 22, TRUE),
    (271, 361, current_date - 21, FALSE),
    (186, 362, current_date - 3, FALSE),
    (155, 362, current_date - 2, FALSE),
    (306, 362, current_date, FALSE),
    (34, 362, current_date - 2, FALSE),
    (205, 362, current_date, FALSE),
    (155, 363, current_date, FALSE),
    (25, 363, current_date - 2, FALSE),
    (306, 363, current_date, FALSE),
    (268, 364, current_date - 36, TRUE),
    (112, 364, current_date - 39, FALSE),
    (244, 364, current_date - 37, FALSE),
    (344, 364, current_date - 36, TRUE),
    (349, 364, current_date - 36, TRUE),
    (208, 364, current_date - 38, FALSE),
    (277, 364, current_date - 38, TRUE),
    (282, 364, current_date - 35, FALSE),
    (244, 365, current_date - 11, TRUE),
    (154, 365, current_date - 11, TRUE),
    (338, 365, current_date - 10, TRUE),
    (344, 365, current_date - 13, TRUE),
    (98, 365, current_date - 12, FALSE),
    (80, 365, current_date - 14, TRUE),
    (268, 365, current_date - 11, TRUE),
    (112, 365, current_date - 11, FALSE),
    (208, 365, current_date - 14, TRUE),
    (180, 365, current_date - 10, TRUE),
    (204, 365, current_date - 11, TRUE),
    (244, 366, current_date - 8, TRUE),
    (268, 366, current_date - 9, FALSE),
    (248, 366, current_date - 10, TRUE),
    (46, 366, current_date - 10, TRUE),
    (90, 366, current_date - 8, TRUE),
    (80, 366, current_date - 8, TRUE),
    (112, 366, current_date - 9, TRUE),
    (154, 366, current_date - 7, TRUE),
    (85, 367, current_date - 3, FALSE),
    (208, 367, current_date - 2, FALSE),
    (60, 367, current_date - 2, FALSE),
    (165, 367, current_date - 3, FALSE),
    (349, 367, current_date - 1, FALSE),
    (344, 367, current_date - 1, FALSE),
    (268, 367, current_date - 3, FALSE),
    (154, 367, current_date, FALSE),
    (244, 367, current_date - 1, FALSE),
    (112, 367, current_date, FALSE),
    (98, 367, current_date, FALSE),
    (112, 368, current_date - 3, FALSE),
    (344, 368, current_date, FALSE),
    (208, 368, current_date - 3, FALSE),
    (206, 368, current_date - 1, FALSE),
    (154, 368, current_date, FALSE),
    (251, 368, current_date, FALSE),
    (349, 368, current_date - 1, FALSE),
    (244, 368, current_date - 3, FALSE),
    (268, 368, current_date, FALSE),
    (282, 368, current_date - 3, FALSE),
    (154, 369, current_date - 1, FALSE),
    (349, 369, current_date - 1, FALSE),
    (112, 369, current_date, FALSE),
    (208, 369, current_date - 1, FALSE),
    (244, 369, current_date - 2, FALSE),
    (344, 369, current_date - 1, FALSE),
    (268, 369, current_date - 2, FALSE),
    (338, 370, current_date - 38, FALSE),
    (344, 370, current_date - 37, FALSE),
    (206, 370, current_date - 38, TRUE),
    (349, 370, current_date - 34, TRUE),
    (268, 370, current_date - 38, TRUE),
    (112, 370, current_date - 35, FALSE),
    (208, 370, current_date - 34, TRUE),
    (244, 370, current_date - 38, FALSE),
    (268, 371, current_date - 17, TRUE),
    (344, 371, current_date - 19, TRUE),
    (98, 371, current_date - 16, TRUE),
    (80, 371, current_date - 15, TRUE),
    (349, 371, current_date - 19, TRUE),
    (208, 371, current_date - 16, FALSE),
    (112, 372, current_date - 1, FALSE),
    (268, 372, current_date - 1, FALSE),
    (154, 372, current_date, FALSE),
    (46, 372, current_date - 3, FALSE),
    (344, 372, current_date - 3, FALSE),
    (244, 372, current_date, FALSE),
    (204, 372, current_date - 2, FALSE),
    (268, 373, current_date - 3, FALSE),
    (90, 373, current_date, FALSE),
    (244, 373, current_date - 2, FALSE),
    (344, 373, current_date - 1, FALSE),
    (80, 373, current_date, FALSE),
    (154, 373, current_date - 3, FALSE),
    (165, 373, current_date, FALSE),
    (208, 373, current_date - 2, FALSE),
    (112, 373, current_date, FALSE),
    (204, 374, current_date - 26, TRUE),
    (268, 374, current_date - 26, TRUE),
    (112, 374, current_date - 29, TRUE),
    (344, 374, current_date - 27, FALSE),
    (349, 374, current_date - 28, TRUE),
    (208, 374, current_date - 28, TRUE),
    (244, 374, current_date - 27, TRUE),
    (269, 374, current_date - 29, TRUE),
    (268, 375, current_date - 16, FALSE),
    (208, 375, current_date - 19, TRUE),
    (344, 375, current_date - 16, TRUE),
    (154, 375, current_date - 17, TRUE),
    (60, 375, current_date - 18, FALSE),
    (46, 375, current_date - 16, TRUE),
    (112, 375, current_date - 20, TRUE),
    (204, 376, current_date - 1, FALSE),
    (208, 376, current_date, FALSE),
    (349, 376, current_date, FALSE),
    (268, 376, current_date - 2, FALSE),
    (112, 376, current_date - 1, FALSE),
    (344, 377, current_date - 2, FALSE),
    (282, 377, current_date - 2, FALSE),
    (154, 377, current_date - 2, FALSE),
    (112, 377, current_date - 3, FALSE),
    (349, 377, current_date, FALSE),
    (244, 377, current_date, FALSE),
    (85, 377, current_date - 3, FALSE),
    (208, 377, current_date - 2, FALSE),
    (204, 377, current_date - 2, FALSE),
    (268, 377, current_date - 2, FALSE),
    (244, 378, current_date - 26, TRUE),
    (208, 378, current_date - 23, TRUE),
    (282, 378, current_date - 24, FALSE),
    (284, 378, current_date - 22, TRUE),
    (204, 378, current_date - 26, FALSE),
    (269, 378, current_date - 24, TRUE),
    (80, 378, current_date - 26, TRUE),
    (112, 379, current_date - 8, TRUE),
    (284, 379, current_date - 6, TRUE),
    (277, 379, current_date - 8, TRUE),
    (204, 379, current_date - 9, FALSE),
    (282, 379, current_date - 10, TRUE),
    (269, 379, current_date - 10, TRUE),
    (268, 379, current_date - 6, FALSE),
    (248, 379, current_date - 6, TRUE),
    (204, 380, current_date, FALSE),
    (269, 380, current_date - 1, FALSE),
    (282, 380, current_date - 2, FALSE),
    (344, 380, current_date - 3, FALSE),
    (208, 380, current_date - 1, FALSE),
    (248, 380, current_date - 3, FALSE),
    (85, 380, current_date - 2, FALSE),
    (284, 380, current_date - 1, FALSE),
    (154, 381, current_date, FALSE),
    (344, 381, current_date - 3, FALSE),
    (269, 381, current_date, FALSE),
    (85, 381, current_date - 1, FALSE),
    (204, 381, current_date, FALSE),
    (90, 381, current_date - 3, FALSE),
    (284, 381, current_date, FALSE),
    (204, 382, current_date - 19, TRUE),
    (269, 382, current_date - 17, TRUE),
    (80, 382, current_date - 16, TRUE),
    (284, 382, current_date - 17, TRUE),
    (282, 382, current_date - 18, TRUE),
    (269, 383, current_date - 9, FALSE),
    (248, 383, current_date - 9, TRUE),
    (282, 383, current_date - 13, TRUE),
    (204, 383, current_date - 11, TRUE),
    (278, 383, current_date - 9, TRUE),
    (154, 384, current_date - 10, FALSE),
    (282, 384, current_date - 11, TRUE),
    (204, 384, current_date - 10, TRUE),
    (269, 384, current_date - 9, TRUE),
    (284, 384, current_date - 8, TRUE),
    (165, 384, current_date - 11, TRUE),
    (251, 384, current_date - 9, FALSE),
    (85, 385, current_date, FALSE),
    (180, 385, current_date - 2, FALSE),
    (248, 385, current_date - 3, FALSE),
    (80, 386, current_date, FALSE),
    (85, 386, current_date, FALSE),
    (90, 387, current_date - 1, FALSE),
    (208, 387, current_date, FALSE),
    (282, 387, current_date - 2, FALSE),
    (85, 387, current_date - 2, FALSE),
    (277, 388, current_date - 38, TRUE),
    (268, 388, current_date - 37, TRUE),
    (206, 388, current_date - 38, FALSE),
    (338, 388, current_date - 39, TRUE),
    (165, 388, current_date - 35, TRUE),
    (90, 388, current_date - 36, TRUE),
    (344, 388, current_date - 36, TRUE),
    (277, 389, current_date - 12, TRUE),
    (46, 389, current_date - 9, TRUE),
    (165, 389, current_date - 11, TRUE),
    (338, 389, current_date - 13, TRUE),
    (278, 389, current_date - 9, TRUE),
    (206, 390, current_date, FALSE),
    (277, 390, current_date - 1, FALSE),
    (90, 390, current_date, FALSE),
    (165, 390, current_date - 2, FALSE),
    (349, 390, current_date - 1, FALSE),
    (180, 390, current_date - 1, FALSE),
    (90, 391, current_date - 1, FALSE),
    (206, 391, current_date - 2, FALSE),
    (268, 391, current_date, FALSE),
    (344, 391, current_date - 1, FALSE),
    (112, 391, current_date - 2, FALSE),
    (165, 391, current_date - 3, FALSE),
    (277, 391, current_date - 1, FALSE),
    (180, 391, current_date - 3, FALSE),
    (338, 392, current_date - 37, TRUE),
    (206, 392, current_date - 33, TRUE),
    (90, 392, current_date - 35, TRUE),
    (277, 392, current_date - 34, TRUE),
    (284, 392, current_date - 34, TRUE),
    (165, 392, current_date - 34, TRUE),
    (349, 392, current_date - 33, TRUE),
    (204, 392, current_date - 36, TRUE),
    (277, 393, current_date - 14, FALSE),
    (180, 393, current_date - 13, FALSE),
    (154, 393, current_date - 13, FALSE),
    (46, 393, current_date - 11, TRUE),
    (60, 393, current_date - 13, TRUE),
    (269, 393, current_date - 12, TRUE),
    (165, 393, current_date - 12, TRUE),
    (90, 394, current_date - 3, FALSE),
    (206, 394, current_date, FALSE),
    (180, 394, current_date, FALSE),
    (277, 394, current_date - 3, FALSE),
    (85, 395, current_date, FALSE),
    (165, 395, current_date - 2, FALSE),
    (206, 395, current_date - 3, FALSE),
    (277, 395, current_date, FALSE),
    (268, 395, current_date - 2, FALSE),
    (112, 395, current_date - 2, FALSE),
    (257, 396, current_date - 18, FALSE),
    (19, 396, current_date - 22, TRUE),
    (290, 396, current_date - 22, TRUE),
    (160, 396, current_date - 18, TRUE),
    (127, 396, current_date - 21, TRUE),
    (135, 397, current_date - 3, TRUE),
    (247, 397, current_date - 5, TRUE),
    (96, 397, current_date - 7, TRUE),
    (339, 397, current_date - 6, TRUE),
    (257, 397, current_date - 7, TRUE),
    (57, 397, current_date - 6, TRUE),
    (135, 398, current_date - 1, FALSE),
    (333, 398, current_date, FALSE),
    (57, 398, current_date, FALSE),
    (49, 398, current_date - 2, FALSE),
    (257, 398, current_date - 3, FALSE),
    (132, 398, current_date, FALSE),
    (309, 398, current_date - 2, FALSE),
    (135, 399, current_date - 3, FALSE),
    (19, 399, current_date, FALSE),
    (257, 399, current_date, FALSE),
    (41, 399, current_date - 1, FALSE),
    (57, 399, current_date - 3, FALSE),
    (132, 400, current_date - 21, FALSE),
    (290, 400, current_date - 22, TRUE),
    (247, 400, current_date - 22, TRUE),
    (257, 401, current_date - 14, TRUE),
    (127, 401, current_date - 16, TRUE),
    (245, 401, current_date - 17, TRUE),
    (257, 402, current_date - 4, TRUE),
    (12, 402, current_date - 4, TRUE),
    (57, 402, current_date - 5, FALSE),
    (285, 402, current_date - 2, TRUE),
    (49, 403, current_date - 3, FALSE),
    (257, 403, current_date - 2, FALSE),
    (135, 403, current_date, FALSE),
    (96, 404, current_date - 3, FALSE),
    (127, 404, current_date, FALSE),
    (333, 404, current_date, FALSE),
    (257, 404, current_date - 1, FALSE),
    (57, 404, current_date - 2, FALSE),
    (257, 405, current_date - 34, FALSE),
    (41, 405, current_date - 33, TRUE),
    (245, 405, current_date - 34, TRUE),
    (290, 405, current_date - 35, FALSE),
    (290, 406, current_date - 24, FALSE),
    (127, 406, current_date - 22, TRUE),
    (160, 407, current_date - 3, TRUE),
    (49, 407, current_date - 5, TRUE),
    (57, 407, current_date - 2, TRUE),
    (135, 407, current_date - 1, TRUE),
    (257, 407, current_date - 2, TRUE),
    (41, 407, current_date - 1, TRUE),
    (290, 408, current_date, FALSE),
    (57, 408, current_date - 3, FALSE),
    (135, 408, current_date - 1, FALSE),
    (185, 408, current_date - 1, FALSE),
    (333, 408, current_date - 1, FALSE),
    (257, 408, current_date, FALSE),
    (160, 408, current_date - 3, FALSE),
    (257, 409, current_date - 2, FALSE),
    (132, 409, current_date - 2, FALSE),
    (342, 409, current_date - 2, FALSE),
    (257, 410, current_date, FALSE),
    (132, 410, current_date - 1, FALSE),
    (57, 410, current_date - 2, FALSE),
    (135, 410, current_date - 1, FALSE),
    (127, 410, current_date, FALSE),
    (333, 410, current_date - 1, FALSE),
    (290, 410, current_date, FALSE),
    (96, 411, current_date - 7, TRUE),
    (41, 411, current_date - 8, TRUE),
    (309, 411, current_date - 6, TRUE),
    (12, 411, current_date - 8, TRUE),
    (49, 411, current_date - 7, TRUE),
    (201, 411, current_date - 5, TRUE),
    (285, 411, current_date - 5, TRUE),
    (285, 412, current_date - 8, TRUE),
    (12, 412, current_date - 5, TRUE),
    (96, 412, current_date - 6, TRUE),
    (127, 412, current_date - 5, TRUE),
    (257, 412, current_date - 5, TRUE),
    (41, 412, current_date - 7, TRUE),
    (185, 413, current_date - 4, TRUE),
    (96, 413, current_date - 3, TRUE),
    (309, 413, current_date - 3, TRUE),
    (285, 413, current_date - 6, TRUE),
    (41, 413, current_date - 7, FALSE),
    (49, 414, current_date - 2, FALSE),
    (247, 414, current_date - 3, FALSE),
    (285, 414, current_date - 2, FALSE),
    (49, 415, current_date, FALSE),
    (12, 415, current_date, FALSE),
    (239, 415, current_date - 1, FALSE),
    (96, 415, current_date, FALSE),
    (49, 416, current_date - 30, TRUE),
    (41, 416, current_date - 29, TRUE),
    (285, 416, current_date - 31, TRUE),
    (96, 416, current_date - 30, TRUE),
    (160, 416, current_date - 29, TRUE),
    (290, 416, current_date - 28, TRUE),
    (185, 416, current_date - 30, TRUE),
    (127, 417, current_date - 27, TRUE),
    (41, 417, current_date - 26, TRUE),
    (285, 417, current_date - 28, TRUE),
    (309, 417, current_date - 27, TRUE),
    (160, 417, current_date - 28, FALSE),
    (49, 417, current_date - 26, TRUE),
    (245, 417, current_date - 24, TRUE),
    (96, 417, current_date - 25, FALSE),
    (285, 418, current_date - 19, FALSE),
    (49, 418, current_date - 16, TRUE),
    (41, 418, current_date - 15, TRUE),
    (160, 418, current_date - 18, TRUE),
    (247, 418, current_date - 18, FALSE),
    (185, 418, current_date - 18, TRUE),
    (12, 419, current_date, FALSE),
    (257, 419, current_date - 3, FALSE),
    (245, 420, current_date - 1, FALSE),
    (239, 420, current_date - 2, FALSE),
    (96, 420, current_date - 3, FALSE),
    (309, 420, current_date - 1, FALSE),
    (49, 420, current_date - 3, FALSE),
    (41, 420, current_date - 2, FALSE),
    (160, 420, current_date - 3, FALSE),
    (285, 420, current_date - 2, FALSE),
    (257, 420, current_date - 2, FALSE),
    (342, 421, current_date - 35, FALSE),
    (247, 421, current_date - 37, TRUE),
    (127, 421, current_date - 35, FALSE),
    (49, 421, current_date - 36, TRUE),
    (19, 421, current_date - 35, TRUE),
    (309, 421, current_date - 37, TRUE),
    (342, 422, current_date - 38, FALSE),
    (247, 422, current_date - 36, FALSE),
    (127, 422, current_date - 37, FALSE),
    (201, 422, current_date - 36, TRUE),
    (245, 422, current_date - 35, TRUE),
    (132, 422, current_date - 34, TRUE),
    (309, 422, current_date - 36, TRUE),
    (185, 422, current_date - 36, FALSE),
    (257, 422, current_date - 37, TRUE),
    (132, 423, current_date - 34, TRUE),
    (127, 423, current_date - 30, TRUE),
    (19, 423, current_date - 30, TRUE),
    (185, 423, current_date - 34, TRUE),
    (247, 423, current_date - 33, TRUE),
    (201, 423, current_date - 31, TRUE),
    (309, 423, current_date - 30, FALSE),
    (290, 423, current_date - 30, FALSE),
    (342, 423, current_date - 32, TRUE),
    (125, 423, current_date - 31, TRUE),
    (245, 423, current_date - 34, FALSE),
    (132, 424, current_date, FALSE),
    (201, 424, current_date, FALSE),
    (245, 424, current_date - 1, FALSE),
    (185, 425, current_date - 3, FALSE),
    (132, 425, current_date - 2, FALSE),
    (185, 426, current_date - 14, FALSE),
    (132, 426, current_date - 16, TRUE),
    (309, 426, current_date - 13, TRUE),
    (342, 426, current_date - 12, TRUE),
    (245, 426, current_date - 14, FALSE),
    (125, 426, current_date - 15, FALSE),
    (247, 426, current_date - 12, TRUE),
    (305, 426, current_date - 14, FALSE),
    (339, 426, current_date - 16, FALSE),
    (127, 426, current_date - 16, TRUE),
    (309, 427, current_date - 12, FALSE),
    (127, 427, current_date - 11, TRUE),
    (19, 427, current_date - 11, FALSE),
    (201, 427, current_date - 12, TRUE),
    (132, 427, current_date - 13, TRUE),
    (96, 427, current_date - 12, TRUE),
    (247, 427, current_date - 13, TRUE),
    (185, 427, current_date - 11, TRUE),
    (132, 428, current_date - 2, FALSE),
    (342, 428, current_date - 2, FALSE),
    (125, 428, current_date - 3, FALSE),
    (245, 428, current_date, FALSE),
    (339, 429, current_date - 3, FALSE),
    (185, 429, current_date - 1, FALSE),
    (201, 429, current_date - 2, FALSE),
    (247, 429, current_date - 2, FALSE),
    (257, 429, current_date - 3, FALSE),
    (125, 429, current_date - 2, FALSE),
    (160, 429, current_date - 1, FALSE),
    (203, 430, current_date - 28, TRUE),
    (111, 430, current_date - 29, TRUE),
    (93, 430, current_date - 31, TRUE),
    (304, 430, current_date - 29, TRUE),
    (316, 430, current_date - 30, TRUE),
    (314, 430, current_date - 28, TRUE),
    (111, 431, current_date - 27, TRUE),
    (74, 431, current_date - 29, TRUE),
    (93, 431, current_date - 31, FALSE),
    (308, 431, current_date - 31, TRUE),
    (203, 431, current_date - 31, TRUE),
    (74, 432, current_date - 12, TRUE),
    (217, 432, current_date - 15, TRUE),
    (302, 432, current_date - 15, TRUE),
    (304, 432, current_date - 14, TRUE),
    (316, 432, current_date - 13, TRUE),
    (74, 433, current_date - 2, FALSE),
    (93, 433, current_date - 3, FALSE),
    (58, 433, current_date - 2, FALSE),
    (314, 434, current_date, FALSE),
    (111, 434, current_date - 3, FALSE),
    (74, 434, current_date - 3, FALSE),
    (304, 434, current_date - 2, FALSE),
    (93, 434, current_date - 1, FALSE),
    (302, 434, current_date - 3, FALSE),
    (316, 435, current_date - 3, FALSE),
    (74, 435, current_date - 1, FALSE),
    (304, 435, current_date, FALSE),
    (316, 436, current_date - 36, TRUE),
    (111, 436, current_date - 37, TRUE),
    (203, 436, current_date - 35, FALSE),
    (93, 436, current_date - 34, TRUE),
    (314, 436, current_date - 35, TRUE),
    (74, 436, current_date - 38, FALSE),
    (304, 437, current_date - 30, TRUE),
    (93, 437, current_date - 31, TRUE),
    (203, 437, current_date - 32, FALSE),
    (308, 437, current_date - 31, FALSE),
    (74, 437, current_date - 29, FALSE),
    (316, 437, current_date - 31, TRUE),
    (111, 437, current_date - 28, FALSE),
    (302, 437, current_date - 28, TRUE),
    (93, 438, current_date - 29, TRUE),
    (302, 438, current_date - 30, TRUE),
    (111, 438, current_date - 27, TRUE),
    (328, 438, current_date - 29, TRUE),
    (316, 438, current_date - 29, TRUE),
    (74, 438, current_date - 30, TRUE),
    (304, 438, current_date - 30, TRUE),
    (203, 438, current_date - 29, TRUE),
    (111, 439, current_date - 1, FALSE),
    (302, 439, current_date - 3, FALSE),
    (74, 439, current_date - 1, FALSE),
    (316, 439, current_date - 3, FALSE),
    (91, 439, current_date - 2, FALSE),
    (217, 439, current_date, FALSE),
    (328, 439, current_date - 1, FALSE),
    (314, 440, current_date - 3, FALSE),
    (299, 440, current_date - 1, FALSE),
    (304, 440, current_date - 2, FALSE),
    (74, 440, current_date - 2, FALSE),
    (316, 440, current_date - 2, FALSE),
    (93, 440, current_date - 2, FALSE),
    (111, 440, current_date - 1, FALSE),
    (308, 441, current_date - 34, TRUE),
    (328, 441, current_date - 33, FALSE),
    (314, 441, current_date - 33, TRUE),
    (93, 441, current_date - 34, TRUE),
    (302, 441, current_date - 31, TRUE),
    (328, 442, current_date - 21, TRUE),
    (308, 442, current_date - 23, FALSE),
    (302, 442, current_date - 22, TRUE),
    (314, 442, current_date - 23, TRUE),
    (217, 442, current_date - 24, TRUE),
    (302, 443, current_date - 3, FALSE),
    (299, 443, current_date, FALSE),
    (328, 443, current_date - 3, FALSE),
    (111, 443, current_date, FALSE),
    (328, 444, current_date, FALSE),
    (316, 444, current_date - 2, FALSE),
    (91, 444, current_date - 1, FALSE),
    (302, 444, current_date, FALSE),
    (314, 444, current_date - 3, FALSE),
    (93, 444, current_date, FALSE),
    (299, 444, current_date - 3, FALSE),
    (58, 444, current_date - 1, FALSE),
    (111, 445, current_date - 36, TRUE),
    (308, 445, current_date - 34, TRUE),
    (302, 445, current_date - 36, TRUE),
    (316, 445, current_date - 32, TRUE),
    (328, 445, current_date - 32, TRUE),
    (314, 445, current_date - 32, TRUE),
    (217, 446, current_date - 7, TRUE),
    (314, 446, current_date - 10, TRUE),
    (58, 446, current_date - 6, TRUE),
    (316, 446, current_date - 6, FALSE),
    (328, 446, current_date - 8, FALSE),
    (308, 446, current_date - 6, TRUE),
    (299, 446, current_date - 6, TRUE),
    (302, 446, current_date - 9, TRUE),
    (93, 447, current_date, FALSE),
    (58, 447, current_date - 3, FALSE),
    (314, 447, current_date, FALSE),
    (328, 447, current_date, FALSE),
    (302, 447, current_date, FALSE),
    (308, 447, current_date, FALSE),
    (299, 447, current_date - 1, FALSE),
    (328, 448, current_date - 1, FALSE),
    (304, 448, current_date, FALSE),
    (302, 448, current_date - 3, FALSE),
    (304, 449, current_date - 3, FALSE),
    (308, 449, current_date, FALSE),
    (299, 449, current_date, FALSE),
    (328, 449, current_date - 2, FALSE),
    (93, 449, current_date - 1, FALSE),
    (331, 450, current_date - 36, FALSE),
    (315, 450, current_date - 34, TRUE),
    (322, 450, current_date - 36, TRUE),
    (75, 450, current_date - 36, TRUE),
    (128, 450, current_date - 34, TRUE),
    (315, 451, current_date - 29, TRUE),
    (331, 451, current_date - 31, TRUE),
    (73, 451, current_date - 29, TRUE),
    (75, 451, current_date - 29, TRUE),
    (176, 451, current_date - 31, FALSE),
    (128, 451, current_date - 29, TRUE),
    (322, 451, current_date - 32, TRUE),
    (322, 452, current_date - 11, TRUE),
    (259, 452, current_date - 12, TRUE),
    (133, 452, current_date - 12, TRUE),
    (61, 452, current_date - 9, TRUE),
    (331, 452, current_date - 10, TRUE),
    (128, 452, current_date - 12, FALSE),
    (176, 452, current_date - 10, TRUE),
    (315, 452, current_date - 9, FALSE),
    (133, 453, current_date - 3, FALSE),
    (128, 453, current_date - 2, FALSE),
    (331, 454, current_date - 3, FALSE),
    (61, 454, current_date - 2, FALSE),
    (73, 454, current_date, FALSE),
    (75, 454, current_date, FALSE),
    (128, 454, current_date - 3, FALSE),
    (315, 454, current_date - 2, FALSE),
    (322, 455, current_date - 35, TRUE),
    (315, 455, current_date - 36, TRUE),
    (128, 455, current_date - 39, TRUE),
    (331, 455, current_date - 37, TRUE),
    (331, 456, current_date - 30, TRUE),
    (128, 456, current_date - 34, TRUE),
    (322, 456, current_date - 31, TRUE),
    (315, 456, current_date - 32, TRUE),
    (133, 457, current_date - 8, FALSE),
    (331, 457, current_date - 8, TRUE),
    (259, 457, current_date - 5, TRUE),
    (128, 457, current_date - 4, TRUE),
    (315, 457, current_date - 7, TRUE),
    (61, 458, current_date - 2, FALSE),
    (315, 458, current_date - 2, FALSE),
    (133, 458, current_date - 2, FALSE),
    (331, 458, current_date - 3, FALSE),
    (61, 459, current_date - 3, FALSE),
    (174, 459, current_date, FALSE),
    (315, 459, current_date - 1, FALSE),
    (128, 460, current_date - 1, FALSE),
    (73, 460, current_date - 2, FALSE),
    (133, 460, current_date - 1, FALSE),
    (61, 460, current_date, FALSE),
    (322, 461, current_date - 19, TRUE),
    (73, 461, current_date - 19, TRUE),
    (176, 461, current_date - 20, TRUE),
    (75, 461, current_date - 21, TRUE),
    (75, 462, current_date - 19, TRUE),
    (73, 462, current_date - 18, FALSE),
    (322, 462, current_date - 18, TRUE),
    (176, 462, current_date - 20, TRUE),
    (315, 463, current_date - 17, TRUE),
    (133, 463, current_date - 14, TRUE),
    (75, 463, current_date - 15, TRUE),
    (73, 463, current_date - 18, TRUE),
    (176, 463, current_date - 15, TRUE),
    (115, 464, current_date - 1, FALSE),
    (331, 464, current_date - 2, FALSE),
    (133, 464, current_date, FALSE),
    (73, 464, current_date - 1, FALSE),
    (331, 465, current_date, FALSE),
    (176, 465, current_date - 1, FALSE),
    (115, 465, current_date - 3, FALSE),
    (73, 465, current_date - 2, FALSE),
    (75, 465, current_date - 3, FALSE),
    (174, 466, current_date - 1, FALSE),
    (322, 466, current_date - 3, FALSE),
    (115, 466, current_date, FALSE),
    (75, 466, current_date, FALSE),
    (75, 467, current_date - 31, FALSE),
    (322, 467, current_date - 33, TRUE),
    (315, 467, current_date - 32, TRUE),
    (176, 467, current_date - 33, TRUE),
    (73, 467, current_date - 35, TRUE),
    (128, 467, current_date - 32, TRUE),
    (75, 468, current_date - 18, TRUE),
    (315, 468, current_date - 16, TRUE),
    (73, 468, current_date - 18, TRUE),
    (176, 468, current_date - 20, TRUE),
    (322, 468, current_date - 18, TRUE),
    (61, 468, current_date - 18, TRUE),
    (73, 469, current_date - 12, FALSE),
    (331, 469, current_date - 16, TRUE),
    (128, 469, current_date - 16, TRUE),
    (176, 469, current_date - 12, TRUE),
    (322, 469, current_date - 16, TRUE),
    (75, 469, current_date - 13, TRUE),
    (133, 470, current_date - 3, FALSE),
    (322, 470, current_date - 1, FALSE),
    (331, 470, current_date - 2, FALSE),
    (75, 470, current_date - 1, FALSE),
    (73, 470, current_date, FALSE),
    (115, 470, current_date - 1, FALSE),
    (176, 470, current_date - 3, FALSE),
    (331, 471, current_date, FALSE),
    (75, 471, current_date - 2, FALSE),
    (322, 471, current_date - 1, FALSE),
    (115, 471, current_date, FALSE),
    (73, 471, current_date - 1, FALSE),
    (315, 472, current_date - 2, FALSE),
    (115, 472, current_date - 1, FALSE),
    (176, 473, current_date - 36, TRUE),
    (331, 473, current_date - 32, TRUE),
    (75, 473, current_date - 33, TRUE),
    (73, 473, current_date - 34, TRUE),
    (331, 474, current_date - 24, TRUE),
    (176, 474, current_date - 20, FALSE),
    (75, 474, current_date - 22, TRUE),
    (75, 475, current_date - 8, TRUE),
    (128, 475, current_date - 9, TRUE),
    (73, 475, current_date - 6, TRUE),
    (115, 476, current_date - 1, FALSE),
    (75, 476, current_date - 1, FALSE),
    (73, 476, current_date - 1, FALSE),
    (73, 477, current_date, FALSE),
    (75, 477, current_date - 2, FALSE),
    (174, 477, current_date - 1, FALSE),
    (262, 478, current_date - 11, FALSE),
    (27, 478, current_date - 15, TRUE),
    (327, 478, current_date - 15, TRUE),
    (104, 478, current_date - 15, FALSE),
    (207, 478, current_date - 13, FALSE),
    (17, 478, current_date - 14, TRUE),
    (212, 478, current_date - 11, FALSE),
    (272, 479, current_date - 10, FALSE),
    (17, 479, current_date - 11, TRUE),
    (47, 479, current_date - 10, TRUE),
    (104, 479, current_date - 13, TRUE),
    (27, 479, current_date - 13, TRUE),
    (207, 479, current_date - 12, TRUE),
    (262, 479, current_date - 14, TRUE),
    (327, 479, current_date - 13, TRUE),
    (272, 480, current_date - 5, FALSE),
    (27, 480, current_date - 4, TRUE),
    (212, 480, current_date - 4, FALSE),
    (327, 480, current_date - 8, TRUE),
    (17, 480, current_date - 7, FALSE),
    (104, 480, current_date - 5, TRUE),
    (327, 481, current_date - 3, FALSE),
    (47, 481, current_date, FALSE),
    (17, 481, current_date - 1, FALSE),
    (104, 482, current_date, FALSE),
    (17, 482, current_date - 2, FALSE),
    (47, 482, current_date, FALSE),
    (327, 483, current_date - 1, FALSE),
    (17, 483, current_date - 1, FALSE),
    (104, 483, current_date - 1, FALSE),
    (27, 483, current_date - 1, FALSE),
    (272, 483, current_date - 2, FALSE),
    (27, 484, current_date - 25, TRUE),
    (262, 484, current_date - 25, TRUE),
    (327, 484, current_date - 26, TRUE),
    (104, 484, current_date - 24, TRUE),
    (207, 484, current_date - 26, FALSE),
    (212, 484, current_date - 23, TRUE),
    (327, 485, current_date - 7, TRUE),
    (17, 485, current_date - 5, TRUE),
    (272, 485, current_date - 6, TRUE),
    (104, 485, current_date - 4, FALSE),
    (27, 485, current_date - 5, TRUE),
    (47, 485, current_date - 6, FALSE),
    (17, 486, current_date - 2, FALSE),
    (207, 486, current_date - 1, FALSE),
    (272, 487, current_date, FALSE),
    (47, 487, current_date - 3, FALSE),
    (104, 487, current_date - 2, FALSE),
    (17, 487, current_date - 1, FALSE),
    (207, 487, current_date - 1, FALSE),
    (327, 488, current_date - 3, FALSE),
    (27, 488, current_date, FALSE),
    (17, 488, current_date - 1, FALSE),
    (272, 488, current_date, FALSE),
    (47, 489, current_date - 33, TRUE),
    (27, 489, current_date - 30, TRUE),
    (273, 489, current_date - 32, TRUE),
    (262, 489, current_date - 32, TRUE),
    (327, 489, current_date - 30, TRUE),
    (327, 490, current_date - 8, TRUE),
    (272, 490, current_date - 5, TRUE),
    (207, 490, current_date - 6, TRUE),
    (27, 490, current_date - 6, TRUE),
    (47, 490, current_date - 8, TRUE),
    (212, 490, current_date - 6, TRUE),
    (17, 491, current_date - 3, FALSE),
    (272, 491, current_date, FALSE),
    (104, 491, current_date - 1, FALSE),
    (327, 491, current_date, FALSE),
    (104, 492, current_date, FALSE),
    (27, 492, current_date - 2, FALSE),
    (272, 492, current_date - 2, FALSE),
    (47, 492, current_date - 3, FALSE),
    (17, 493, current_date - 2, FALSE),
    (47, 494, current_date - 16, TRUE),
    (17, 494, current_date - 14, TRUE),
    (104, 494, current_date - 17, TRUE),
    (327, 494, current_date - 14, FALSE),
    (272, 494, current_date - 18, TRUE),
    (212, 494, current_date - 16, TRUE),
    (262, 494, current_date - 18, TRUE),
    (47, 495, current_date - 13, TRUE),
    (17, 495, current_date - 16, TRUE),
    (262, 495, current_date - 14, TRUE),
    (27, 495, current_date - 14, TRUE),
    (212, 495, current_date - 13, TRUE),
    (327, 495, current_date - 13, TRUE),
    (272, 495, current_date - 13, TRUE),
    (262, 496, current_date - 10, FALSE),
    (104, 496, current_date - 6, TRUE),
    (327, 496, current_date - 7, TRUE),
    (212, 496, current_date - 7, TRUE),
    (47, 496, current_date - 10, TRUE),
    (17, 496, current_date - 6, TRUE),
    (272, 496, current_date - 7, TRUE),
    (47, 497, current_date, FALSE),
    (27, 497, current_date - 2, FALSE),
    (17, 497, current_date, FALSE),
    (207, 497, current_date, FALSE),
    (272, 497, current_date - 1, FALSE),
    (17, 498, current_date - 1, FALSE),
    (47, 498, current_date - 1, FALSE),
    (272, 498, current_date - 1, FALSE),
    (27, 498, current_date - 1, FALSE),
    (136, 499, current_date - 37, TRUE),
    (156, 499, current_date - 37, TRUE),
    (237, 499, current_date - 37, TRUE),
    (229, 499, current_date - 35, TRUE),
    (243, 499, current_date - 33, FALSE),
    (156, 500, current_date - 24, FALSE),
    (144, 500, current_date - 20, TRUE),
    (229, 500, current_date - 22, TRUE),
    (158, 500, current_date - 23, TRUE),
    (223, 500, current_date - 22, TRUE),
    (84, 501, current_date - 2, FALSE),
    (243, 501, current_date - 3, FALSE),
    (144, 501, current_date - 1, FALSE),
    (221, 502, current_date - 1, FALSE),
    (84, 502, current_date, FALSE),
    (223, 502, current_date - 3, FALSE),
    (313, 502, current_date - 1, FALSE),
    (229, 503, current_date - 23, FALSE),
    (237, 503, current_date - 20, TRUE),
    (223, 503, current_date - 22, FALSE),
    (156, 503, current_date - 22, TRUE),
    (313, 503, current_date - 21, TRUE),
    (196, 503, current_date - 23, FALSE),
    (229, 504, current_date - 10, FALSE),
    (243, 504, current_date - 11, TRUE),
    (313, 504, current_date - 9, TRUE),
    (84, 504, current_date - 9, FALSE),
    (223, 504, current_date - 11, TRUE),
    (237, 504, current_date - 7, TRUE),
    (156, 504, current_date - 11, TRUE),
    (158, 504, current_date - 11, TRUE),
    (144, 504, current_date - 8, TRUE),
    (223, 505, current_date - 6, TRUE),
    (84, 505, current_date - 8, TRUE),
    (229, 505, current_date - 8, TRUE),
    (243, 505, current_date - 8, TRUE),
    (237, 505, current_date - 4, TRUE),
    (156, 505, current_date - 6, TRUE),
    (256, 505, current_date - 6, TRUE),
    (313, 505, current_date - 6, TRUE),
    (156, 506, current_date, FALSE),
    (313, 506, current_date, FALSE),
    (221, 506, current_date, FALSE),
    (158, 506, current_date - 3, FALSE),
    (229, 506, current_date - 3, FALSE),
    (243, 506, current_date - 1, FALSE),
    (84, 506, current_date - 3, FALSE),
    (237, 506, current_date - 3, FALSE),
    (223, 506, current_date - 3, FALSE),
    (223, 507, current_date - 3, FALSE),
    (156, 507, current_date - 1, FALSE),
    (237, 507, current_date - 2, FALSE),
    (313, 507, current_date, FALSE),
    (243, 507, current_date - 1, FALSE),
    (84, 507, current_date, FALSE),
    (144, 507, current_date - 3, FALSE),
    (313, 508, current_date - 15, TRUE),
    (237, 508, current_date - 13, TRUE),
    (84, 508, current_date - 12, TRUE),
    (223, 508, current_date - 12, TRUE),
    (158, 508, current_date - 14, TRUE),
    (229, 508, current_date - 12, TRUE),
    (156, 508, current_date - 15, TRUE),
    (84, 509, current_date - 7, TRUE),
    (223, 509, current_date - 8, TRUE),
    (144, 509, current_date - 4, FALSE),
    (313, 509, current_date - 5, TRUE),
    (229, 509, current_date - 5, FALSE),
    (156, 509, current_date - 7, TRUE),
    (237, 510, current_date - 3, FALSE),
    (84, 510, current_date - 1, FALSE),
    (221, 510, current_date - 1, FALSE),
    (144, 510, current_date - 3, FALSE),
    (243, 510, current_date, FALSE),
    (256, 511, current_date - 2, FALSE),
    (156, 511, current_date - 3, FALSE),
    (243, 511, current_date, FALSE),
    (256, 512, current_date - 34, TRUE),
    (229, 512, current_date - 35, TRUE),
    (237, 512, current_date - 33, TRUE),
    (156, 512, current_date - 34, TRUE),
    (158, 513, current_date - 4, TRUE),
    (144, 513, current_date - 4, TRUE),
    (243, 513, current_date - 5, TRUE),
    (237, 513, current_date - 4, TRUE),
    (256, 513, current_date - 6, TRUE),
    (84, 513, current_date - 5, TRUE),
    (256, 514, current_date - 2, FALSE),
    (84, 514, current_date - 2, FALSE),
    (144, 514, current_date, FALSE),
    (223, 514, current_date - 1, FALSE),
    (196, 514, current_date, FALSE),
    (237, 514, current_date - 3, FALSE),
    (237, 515, current_date - 2, FALSE),
    (144, 515, current_date - 2, FALSE),
    (196, 515, current_date, FALSE),
    (223, 515, current_date, FALSE),
    (156, 515, current_date - 1, FALSE),
    (256, 515, current_date - 2, FALSE),
    (237, 516, current_date - 3, FALSE),
    (256, 516, current_date - 1, FALSE),
    (221, 516, current_date, FALSE),
    (223, 516, current_date, FALSE),
    (144, 516, current_date, FALSE),
    (243, 517, current_date - 28, FALSE),
    (144, 517, current_date - 29, FALSE),
    (196, 517, current_date - 30, TRUE),
    (256, 517, current_date - 28, TRUE),
    (237, 517, current_date - 30, FALSE),
    (229, 517, current_date - 30, TRUE),
    (144, 518, current_date - 20, TRUE),
    (196, 518, current_date - 23, TRUE),
    (84, 518, current_date - 21, FALSE),
    (237, 518, current_date - 21, TRUE),
    (256, 518, current_date - 22, TRUE),
    (313, 518, current_date - 23, TRUE),
    (158, 518, current_date - 21, TRUE),
    (144, 519, current_date - 3, FALSE),
    (256, 519, current_date - 2, FALSE),
    (243, 519, current_date - 2, FALSE),
    (237, 519, current_date - 2, FALSE),
    (156, 520, current_date - 1, FALSE),
    (196, 520, current_date, FALSE),
    (221, 520, current_date - 1, FALSE),
    (144, 520, current_date - 1, FALSE),
    (237, 520, current_date, FALSE),
    (223, 521, current_date - 2, FALSE),
    (196, 521, current_date, FALSE),
    (256, 521, current_date - 1, FALSE),
    (237, 521, current_date, FALSE),
    (168, 522, current_date - 16, TRUE),
    (310, 522, current_date - 19, TRUE),
    (335, 522, current_date - 18, TRUE),
    (310, 523, current_date - 4, TRUE),
    (260, 523, current_date - 3, TRUE),
    (335, 523, current_date - 2, TRUE),
    (242, 523, current_date - 1, FALSE),
    (310, 524, current_date - 2, FALSE),
    (335, 524, current_date, FALSE),
    (242, 524, current_date - 2, FALSE),
    (168, 524, current_date, FALSE),
    (260, 524, current_date - 1, FALSE),
    (260, 525, current_date - 1, FALSE),
    (168, 525, current_date, FALSE),
    (310, 525, current_date - 3, FALSE),
    (335, 525, current_date - 3, FALSE),
    (242, 525, current_date - 3, FALSE),
    (335, 526, current_date - 2, FALSE),
    (64, 526, current_date - 1, FALSE),
    (225, 526, current_date - 1, FALSE),
    (242, 526, current_date, FALSE),
    (260, 526, current_date - 2, FALSE),
    (310, 526, current_date, FALSE),
    (225, 527, current_date - 26, TRUE),
    (310, 527, current_date - 25, FALSE),
    (335, 527, current_date - 24, TRUE),
    (116, 527, current_date - 23, TRUE),
    (260, 527, current_date - 23, TRUE),
    (168, 527, current_date - 22, TRUE),
    (64, 527, current_date - 24, TRUE),
    (225, 528, current_date - 13, TRUE),
    (168, 528, current_date - 9, TRUE),
    (310, 528, current_date - 11, TRUE),
    (260, 528, current_date - 11, TRUE),
    (116, 528, current_date - 9, TRUE),
    (335, 528, current_date - 9, TRUE),
    (64, 528, current_date - 10, TRUE),
    (335, 529, current_date, FALSE),
    (242, 529, current_date, FALSE),
    (334, 529, current_date - 1, FALSE),
    (310, 529, current_date - 3, FALSE),
    (260, 529, current_date - 1, FALSE),
    (168, 529, current_date - 3, FALSE),
    (64, 529, current_date - 1, FALSE),
    (334, 530, current_date - 2, FALSE),
    (64, 530, current_date - 1, FALSE),
    (310, 530, current_date - 2, FALSE),
    (242, 531, current_date - 1, FALSE),
    (260, 531, current_date, FALSE),
    (64, 531, current_date - 2, FALSE),
    (225, 531, current_date - 1, FALSE),
    (335, 531, current_date - 2, FALSE),
    (310, 531, current_date - 1, FALSE),
    (37, 532, current_date - 21, TRUE),
    (14, 532, current_date - 23, FALSE),
    (51, 532, current_date - 24, TRUE),
    (119, 532, current_date - 23, TRUE),
    (228, 532, current_date - 23, TRUE),
    (119, 533, current_date - 9, TRUE),
    (51, 533, current_date - 10, TRUE),
    (228, 533, current_date - 10, TRUE),
    (14, 533, current_date - 11, TRUE),
    (37, 533, current_date - 9, TRUE),
    (37, 534, current_date - 7, FALSE),
    (51, 534, current_date - 9, TRUE),
    (228, 534, current_date - 7, TRUE),
    (14, 534, current_date - 7, TRUE),
    (119, 534, current_date - 8, FALSE),
    (119, 535, current_date, FALSE),
    (14, 535, current_date, FALSE),
    (51, 535, current_date - 3, FALSE),
    (228, 535, current_date, FALSE),
    (119, 536, current_date - 2, FALSE),
    (37, 536, current_date - 3, FALSE),
    (228, 536, current_date - 1, FALSE),
    (14, 536, current_date - 3, FALSE),
    (228, 537, current_date - 38, TRUE),
    (37, 537, current_date - 34, FALSE),
    (51, 537, current_date - 38, TRUE),
    (51, 538, current_date - 28, TRUE),
    (228, 538, current_date - 31, TRUE),
    (37, 538, current_date - 29, FALSE),
    (14, 538, current_date - 28, TRUE),
    (119, 538, current_date - 32, TRUE),
    (228, 539, current_date - 15, TRUE),
    (119, 539, current_date - 17, FALSE),
    (37, 539, current_date - 14, TRUE),
    (14, 539, current_date - 17, TRUE),
    (51, 539, current_date - 14, TRUE),
    (228, 540, current_date - 1, FALSE),
    (37, 540, current_date, FALSE),
    (51, 540, current_date, FALSE),
    (14, 540, current_date - 1, FALSE),
    (119, 541, current_date - 2, FALSE),
    (14, 541, current_date - 2, FALSE),
    (51, 541, current_date - 1, FALSE),
    (37, 541, current_date - 2, FALSE),
    (228, 541, current_date - 2, FALSE),
    (240, 542, current_date - 34, TRUE),
    (289, 542, current_date - 33, TRUE),
    (190, 542, current_date - 35, TRUE),
    (118, 542, current_date - 36, TRUE),
    (289, 543, current_date - 15, TRUE),
    (118, 543, current_date - 16, TRUE),
    (240, 543, current_date - 15, TRUE),
    (21, 544, current_date, FALSE),
    (240, 544, current_date, FALSE),
    (289, 544, current_date - 3, FALSE),
    (118, 544, current_date - 2, FALSE),
    (190, 544, current_date, FALSE),
    (21, 545, current_date - 2, FALSE),
    (289, 545, current_date - 1, FALSE),
    (182, 545, current_date - 2, FALSE),
    (190, 546, current_date - 31, TRUE),
    (289, 546, current_date - 32, TRUE),
    (118, 546, current_date - 35, FALSE),
    (240, 546, current_date - 32, TRUE),
    (118, 547, current_date - 4, FALSE),
    (190, 547, current_date - 5, FALSE),
    (240, 547, current_date - 5, TRUE),
    (21, 548, current_date - 1, FALSE),
    (190, 548, current_date - 3, FALSE),
    (240, 548, current_date - 3, FALSE),
    (289, 548, current_date - 4, TRUE),
    (118, 548, current_date - 5, TRUE),
    (118, 549, current_date - 1, FALSE),
    (289, 549, current_date - 2, FALSE),
    (182, 549, current_date - 2, FALSE),
    (240, 549, current_date, FALSE),
    (190, 549, current_date - 1, FALSE),
    (240, 550, current_date - 3, FALSE),
    (190, 550, current_date - 3, FALSE),
    (21, 550, current_date - 2, FALSE),
    (182, 550, current_date - 2, FALSE),
    (118, 550, current_date - 1, FALSE),
    (289, 550, current_date - 1, FALSE),
    (21, 551, current_date - 2, FALSE),
    (240, 551, current_date - 1, FALSE),
    (289, 551, current_date - 3, FALSE),
    (118, 551, current_date, FALSE),
    (190, 551, current_date, FALSE),
    (182, 551, current_date, FALSE),
    (36, 552, current_date - 35, TRUE),
    (150, 552, current_date - 37, TRUE),
    (71, 552, current_date - 37, TRUE),
    (150, 553, current_date - 19, TRUE),
    (71, 553, current_date - 20, TRUE),
    (36, 553, current_date - 21, TRUE),
    (71, 554, current_date, FALSE),
    (36, 554, current_date, FALSE),
    (150, 554, current_date - 2, FALSE),
    (36, 555, current_date - 2, FALSE),
    (71, 555, current_date - 1, FALSE),
    (150, 555, current_date - 3, FALSE),
    (150, 556, current_date - 22, TRUE),
    (36, 556, current_date - 23, TRUE),
    (71, 556, current_date - 20, TRUE),
    (150, 557, current_date - 16, TRUE),
    (71, 557, current_date - 17, TRUE),
    (36, 557, current_date - 18, TRUE),
    (150, 558, current_date - 1, FALSE),
    (36, 558, current_date, FALSE),
    (71, 558, current_date - 3, FALSE),
    (71, 559, current_date - 1, FALSE),
    (36, 559, current_date - 3, FALSE);

-- ---------------------------------------------------------------------
-- EQUIPO  (cada equipo pertenece a una sola sede)
-- ---------------------------------------------------------------------
INSERT INTO equipo (id_equipo, nombre, id_tipo_equipo, id_sede, fecha_adquisicion) VALUES
    (1, 'Barras olímpicas', 3, 1, current_date - 250),
    (2, 'Bicicleta de spinning', 1, 1, current_date - 852),
    (3, 'Máquina Smith', 2, 1, current_date - 513),
    (4, 'Set bosu', 4, 1, current_date - 828),
    (5, 'Hip thrust máquina', 2, 2, current_date - 403),
    (6, 'Set balones medicinales', 4, 2, current_date - 1033),
    (7, 'Bicicleta de spinning', 1, 2, current_date - 999),
    (8, 'Jaula de potencia', 2, 3, current_date - 117),
    (9, 'Curl femoral sentado', 2, 3, current_date - 1084),
    (10, 'Hip thrust máquina', 2, 3, current_date - 843),
    (11, 'Elíptica Precor EFX', 1, 4, current_date - 1466),
    (12, 'Banco plano', 3, 4, current_date - 504),
    (13, 'Remo Concept2', 1, 4, current_date - 712),
    (14, 'Pec deck', 2, 5, current_date - 498),
    (15, 'Máquina Smith', 2, 5, current_date - 151),
    (16, 'Caminadora Technogym', 1, 5, current_date - 244),
    (17, 'Trineo de empuje', 4, 6, current_date - 795),
    (18, 'Cuerdas de batalla', 4, 6, current_date - 952),
    (19, 'Caminadora Technogym', 1, 6, current_date - 643),
    (20, 'Set discos de hierro', 3, 6, current_date - 1367),
    (21, 'Set discos bumper', 3, 7, current_date - 1085),
    (22, 'SkiErg Concept2', 1, 7, current_date - 835),
    (23, 'Set discos de hierro', 3, 7, current_date - 994),
    (24, 'Set discos bumper', 3, 8, current_date - 899),
    (25, 'Elíptica', 1, 8, current_date - 111),
    (26, 'Rig funcional 6 m', 4, 8, current_date - 338),
    (27, 'Rack de mancuernas', 3, 9, current_date - 370),
    (28, 'Banco Scott', 3, 9, current_date - 1362),
    (29, 'Banco Scott', 3, 9, current_date - 936),
    (30, 'Set bosu', 4, 10, current_date - 733),
    (31, 'Cuerdas de batalla', 4, 10, current_date - 567),
    (32, 'Air bike Assault', 1, 10, current_date - 1083),
    (33, 'Jalón al pecho', 2, 10, current_date - 276),
    (34, 'Set cajones pliométricos', 4, 11, current_date - 1152),
    (35, 'Set balones medicinales', 4, 11, current_date - 1120),
    (36, 'Elíptica Precor EFX', 1, 11, current_date - 262),
    (37, 'Remo sentado máquina', 2, 12, current_date - 101),
    (38, 'Elíptica Precor EFX', 1, 12, current_date - 1285),
    (39, 'Set discos bumper', 3, 12, current_date - 768),
    (40, 'Set bandas de resistencia', 4, 12, current_date - 780),
    (41, 'Prensa de piernas', 2, 13, current_date - 1095),
    (42, 'Banco Scott', 3, 13, current_date - 703),
    (43, 'Abductor/aductor', 2, 13, current_date - 872),
    (44, 'Trineo de empuje', 4, 14, current_date - 937),
    (45, 'Air bike Assault', 1, 14, current_date - 1231),
    (46, 'Mancuernas 32-50 kg', 3, 14, current_date - 1399),
    (47, 'Mancuernas 5-30 kg', 3, 14, current_date - 929),
    (48, 'Banco Scott', 3, 15, current_date - 738),
    (49, 'Hip thrust máquina', 2, 15, current_date - 457),
    (50, 'Trineo de empuje', 4, 15, current_date - 1319),
    (51, 'Rack de mancuernas', 3, 16, current_date - 559),
    (52, 'Set balones medicinales', 4, 16, current_date - 293),
    (53, 'Remo sentado máquina', 2, 16, current_date - 797),
    (54, 'Curl femoral sentado', 2, 16, current_date - 283),
    (55, 'Remo Concept2', 1, 17, current_date - 1118),
    (56, 'Crossover doble polea', 2, 17, current_date - 746),
    (57, 'Escalera de agilidad', 4, 17, current_date - 1138),
    (58, 'Barras olímpicas', 3, 17, current_date - 408),
    (59, 'Banco ajustable', 3, 18, current_date - 365),
    (60, 'Set cajones pliométricos', 4, 18, current_date - 668),
    (61, 'Air bike Assault', 1, 18, current_date - 1087),
    (62, 'Set bandas de resistencia', 4, 18, current_date - 1272),
    (63, 'Air bike Assault', 1, 19, current_date - 864),
    (64, 'Banco ajustable', 3, 19, current_date - 1003),
    (65, 'Banco plano', 3, 19, current_date - 1372),
    (66, 'Extensión de pierna', 2, 19, current_date - 1317),
    (67, 'Elíptica Precor EFX', 1, 20, current_date - 395),
    (68, 'Set bandas de resistencia', 4, 20, current_date - 1444),
    (69, 'Air bike Assault', 1, 20, current_date - 180),
    (70, 'Set slam balls', 4, 21, current_date - 459),
    (71, 'Elíptica Precor EFX', 1, 21, current_date - 573),
    (72, 'Prensa de piernas', 2, 21, current_date - 399),
    (73, 'Abductor/aductor', 2, 22, current_date - 133),
    (74, 'Kit TRX Pro', 4, 22, current_date - 1176),
    (75, 'Mancuernas 32-50 kg', 3, 22, current_date - 1149),
    (76, 'Set discos de hierro', 3, 23, current_date - 897),
    (77, 'Bici spinning Keiser M3', 1, 23, current_date - 1084),
    (78, 'Máquina de poleas', 2, 23, current_date - 427),
    (79, 'Set bandas de resistencia', 4, 24, current_date - 1207),
    (80, 'Banco ajustable', 3, 24, current_date - 297),
    (81, 'Set discos bumper', 3, 24, current_date - 1466),
    (82, 'Cinta curva Woodway', 1, 24, current_date - 324),
    (83, 'Prensa de piernas', 2, 25, current_date - 1286),
    (84, 'Banco ajustable', 3, 25, current_date - 1420),
    (85, 'Banco ajustable', 3, 25, current_date - 647),
    (86, 'Mancuernas 5-30 kg', 3, 25, current_date - 530),
    (87, 'Press de pecho sentado', 2, 26, current_date - 171),
    (88, 'Barras olímpicas', 3, 26, current_date - 886),
    (89, 'Kettlebells', 4, 26, current_date - 1478),
    (90, 'Cinta curva Woodway', 1, 26, current_date - 1053),
    (91, 'Pec deck', 2, 27, current_date - 986),
    (92, 'Banco Scott', 3, 27, current_date - 695),
    (93, 'Trineo de empuje', 4, 27, current_date - 633),
    (94, 'Máquina Smith', 2, 28, current_date - 588),
    (95, 'Curl femoral sentado', 2, 28, current_date - 1162),
    (96, 'Crossover doble polea', 2, 28, current_date - 545),
    (97, 'Hip thrust máquina', 2, 28, current_date - 437),
    (98, 'Banco plano', 3, 29, current_date - 1128),
    (99, 'Set balones medicinales', 4, 29, current_date - 369),
    (100, 'Bicicleta estática', 1, 29, current_date - 612),
    (101, 'Abductor/aductor', 2, 30, current_date - 559),
    (102, 'Press de pecho sentado', 2, 30, current_date - 1061),
    (103, 'Multiestación 4 puestos', 2, 30, current_date - 1143),
    (104, 'Crossover doble polea', 2, 31, current_date - 1011),
    (105, 'Bicicleta estática', 1, 31, current_date - 802),
    (106, 'Elíptica Precor EFX', 1, 31, current_date - 1317),
    (107, 'Set bosu', 4, 31, current_date - 463),
    (108, 'Banco plano', 3, 32, current_date - 426),
    (109, 'Remo Concept2', 1, 32, current_date - 860),
    (110, 'Jalón al pecho', 2, 32, current_date - 691),
    (111, 'Bicicleta de spinning', 1, 32, current_date - 537),
    (112, 'Rig funcional 6 m', 4, 33, current_date - 1372),
    (113, 'Bicicleta estática', 1, 33, current_date - 683),
    (114, 'Cuerdas de batalla', 4, 33, current_date - 1364),
    (115, 'Trineo de empuje', 4, 33, current_date - 996),
    (116, 'Prensa de piernas', 2, 34, current_date - 213),
    (117, 'Pec deck', 2, 34, current_date - 767),
    (118, 'Trineo de empuje', 4, 34, current_date - 424),
    (119, 'Caminadora Technogym', 1, 34, current_date - 1173),
    (120, 'Bicicleta estática', 1, 35, current_date - 121),
    (121, 'Prensa de piernas', 2, 35, current_date - 294),
    (122, 'Set discos bumper', 3, 35, current_date - 255),
    (123, 'Kit TRX Pro', 4, 35, current_date - 1202),
    (124, 'Curl femoral sentado', 2, 36, current_date - 892),
    (125, 'Remo sentado máquina', 2, 36, current_date - 787),
    (126, 'Bici spinning Keiser M3', 1, 36, current_date - 1074),
    (127, 'Kit TRX Pro', 4, 37, current_date - 299),
    (128, 'Caminadora Technogym', 1, 37, current_date - 543),
    (129, 'Barra Z', 3, 37, current_date - 266),
    (130, 'Set slam balls', 4, 37, current_date - 527),
    (131, 'Set balones medicinales', 4, 38, current_date - 231),
    (132, 'Set slam balls', 4, 38, current_date - 1278),
    (133, 'Banco Scott', 3, 38, current_date - 620),
    (134, 'Set discos de hierro', 3, 39, current_date - 297),
    (135, 'Elíptica Precor EFX', 1, 39, current_date - 237),
    (136, 'Barra Z', 3, 39, current_date - 639),
    (137, 'Air bike Assault', 1, 39, current_date - 1278),
    (138, 'Rig funcional 6 m', 4, 40, current_date - 792),
    (139, 'Rack de sentadillas', 2, 40, current_date - 1224),
    (140, 'Elíptica', 1, 40, current_date - 599),
    (141, 'Hack squat', 2, 41, current_date - 1116),
    (142, 'Rack de mancuernas', 3, 41, current_date - 148),
    (143, 'Banco Scott', 3, 41, current_date - 797),
    (144, 'Cuerdas de batalla', 4, 41, current_date - 507),
    (145, 'Mancuernas 32-50 kg', 3, 42, current_date - 738),
    (146, 'Banco Scott', 3, 42, current_date - 182),
    (147, 'Bicicleta estática', 1, 42, current_date - 1089),
    (148, 'Set cajones pliométricos', 4, 43, current_date - 296),
    (149, 'Bicicleta estática', 1, 43, current_date - 1328),
    (150, 'Banco Scott', 3, 43, current_date - 464),
    (151, 'Escaladora StairMaster', 1, 43, current_date - 571),
    (152, 'Rack de mancuernas', 3, 44, current_date - 110),
    (153, 'Bici spinning Keiser M3', 1, 44, current_date - 383),
    (154, 'Escalera de agilidad', 4, 44, current_date - 752),
    (155, 'Set cajones pliométricos', 4, 44, current_date - 403),
    (156, 'Kit TRX Pro', 4, 45, current_date - 279),
    (157, 'Jalón al pecho', 2, 45, current_date - 322),
    (158, 'Barra Z', 3, 45, current_date - 1039),
    (159, 'Set cajones pliométricos', 4, 46, current_date - 543),
    (160, 'Press de pecho sentado', 2, 46, current_date - 916),
    (161, 'Rack de mancuernas', 3, 46, current_date - 791),
    (162, 'Abductor/aductor', 2, 46, current_date - 284),
    (163, 'Mancuernas 32-50 kg', 3, 47, current_date - 1142),
    (164, 'Set cajones pliométricos', 4, 47, current_date - 1367),
    (165, 'Set bandas de resistencia', 4, 47, current_date - 677),
    (166, 'Banco plano', 3, 48, current_date - 352),
    (167, 'Mancuernas 32-50 kg', 3, 48, current_date - 143),
    (168, 'SkiErg Concept2', 1, 48, current_date - 1300),
    (169, 'Elíptica', 1, 48, current_date - 234),
    (170, 'Jaula de potencia', 2, 49, current_date - 679),
    (171, 'Escaladora StairMaster', 1, 49, current_date - 204),
    (172, 'Elíptica Precor EFX', 1, 49, current_date - 1378),
    (173, 'Rack de mancuernas', 3, 50, current_date - 920),
    (174, 'Cuerdas de batalla', 4, 50, current_date - 986),
    (175, 'Curl femoral sentado', 2, 50, current_date - 1382);

-- ---------------------------------------------------------------------
-- MANTENIMIENTO_EQUIPO 
-- ---------------------------------------------------------------------
INSERT INTO mantenimiento_equipo (numero_mantenimiento, id_equipo, descripcion, costo, fecha_mantenimiento) VALUES
    (1, 3, 'Revisión de soldaduras', 440000.00, current_date - 426),
    (2, 3, 'Ajuste y calibración de pesas', 980000.00, current_date - 231),
    (3, 3, 'Revisión de cables', 550000.00, current_date - 7),
    (4, 6, 'Revisión de desgaste y reemplazo de piezas', 340000.00, current_date - 995),
    (5, 6, 'Revisión de desgaste y reemplazo de piezas', 450000.00, current_date - 829),
    (6, 7, 'Ajuste de resistencia', 150000.00, current_date - 899),
    (7, 9, 'Ajuste y calibración de pesas', 1450000.00, current_date - 983),
    (8, 9, 'Revisión cubierta por garantía', 0.00, current_date - 869),
    (9, 9, 'Lubricación de guías', 150000.00, current_date - 785),
    (10, 11, 'Cambio de banda', 1250000.00, current_date - 1381),
    (11, 11, 'Ajuste de resistencia', 250000.00, current_date - 1225),
    (12, 12, 'Revisión de soldaduras', 850000.00, current_date - 403),
    (13, 12, 'Revisión de soldaduras', 1460000.00, current_date - 210),
    (14, 12, 'Reemplazo de tapicería', 750000.00, current_date - 142),
    (15, 12, 'Revisión de soldaduras', 1360000.00, current_date - 18),
    (16, 13, 'Cambio de pantalla de consola', 360000.00, current_date - 621),
    (17, 16, 'Lubricación y calibración', 470000.00, current_date - 125),
    (18, 17, 'Reposición de piezas dañadas', 920000.00, current_date - 729),
    (19, 17, 'Reposición de piezas dañadas', 1390000.00, current_date - 497),
    (20, 21, 'Reemplazo de tapicería', 1270000.00, current_date - 965),
    (21, 21, 'Reposición de piezas dañadas', 1020000.00, current_date - 752),
    (22, 21, 'Revisión de soldaduras', 720000.00, current_date - 614),
    (23, 28, 'Reemplazo de tapicería', 1070000.00, current_date - 1290),
    (24, 28, 'Reposición de piezas dañadas', 1240000.00, current_date - 1051),
    (25, 28, 'Ajuste de tornillería y agarres', 490000.00, current_date - 813),
    (26, 31, 'Revisión cubierta por garantía', 0.00, current_date - 521),
    (27, 32, 'Reemplazo de motor', 800000.00, current_date - 1040),
    (28, 32, 'Lubricación y calibración', 480000.00, current_date - 830),
    (29, 34, 'Limpieza profunda y desinfección', 60000.00, current_date - 1118),
    (30, 35, 'Limpieza profunda y desinfección', 70000.00, current_date - 1087),
    (31, 35, 'Revisión de anclajes', 770000.00, current_date - 874),
    (32, 36, 'Cambio de pantalla de consola', 250000.00, current_date - 189),
    (33, 38, 'Lubricación y calibración', 1080000.00, current_date - 1245),
    (34, 38, 'Cambio de pedales', 540000.00, current_date - 6),
    (35, 39, 'Reemplazo de tapicería', 740000.00, current_date - 714),
    (36, 39, 'Ajuste de tornillería y agarres', 1170000.00, current_date - 613),
    (37, 40, 'Revisión de desgaste y reemplazo de piezas', 680000.00, current_date - 721),
    (38, 40, 'Reposición de piezas dañadas', 780000.00, current_date - 519),
    (39, 40, 'Revisión cubierta por garantía', 0.00, current_date - 435),
    (40, 41, 'Cambio de poleas', 680000.00, current_date - 1009),
    (41, 41, 'Lubricación de guías', 190000.00, current_date - 899),
    (42, 43, 'Cambio de poleas', 1330000.00, current_date - 776),
    (43, 44, 'Revisión de anclajes', 1350000.00, current_date - 821),
    (44, 44, 'Revisión cubierta por garantía', 0.00, current_date - 700),
    (45, 44, 'Revisión de desgaste y reemplazo de piezas', 1000000.00, current_date - 485),
    (46, 46, 'Revisión cubierta por garantía', 0.00, current_date - 1295),
    (47, 48, 'Revisión de soldaduras', 1410000.00, current_date - 682),
    (48, 48, 'Ajuste de tornillería y agarres', 1010000.00, current_date - 598),
    (49, 48, 'Reemplazo de tapicería', 590000.00, current_date - 471),
    (50, 49, 'Ajuste y calibración de pesas', 1310000.00, current_date - 370),
    (51, 49, 'Revisión de soldaduras', 100000.00, current_date - 256),
    (52, 50, 'Reposición de piezas dañadas', 800000.00, current_date - 1263),
    (53, 50, 'Revisión de desgaste y reemplazo de piezas', 230000.00, current_date - 1059),
    (54, 50, 'Revisión de desgaste y reemplazo de piezas', 700000.00, current_date - 846),
    (55, 51, 'Revisión cubierta por garantía', 0.00, current_date - 483),
    (56, 51, 'Revisión de soldaduras', 780000.00, current_date - 317),
    (57, 51, 'Reposición de piezas dañadas', 780000.00, current_date - 181),
    (58, 52, 'Revisión de anclajes', 1090000.00, current_date - 187),
    (59, 52, 'Reposición de piezas dañadas', 600000.00, current_date - 99),
    (60, 52, 'Revisión de desgaste y reemplazo de piezas', 1310000.00, current_date - 8),
    (61, 56, 'Reemplazo de tapicería', 1340000.00, current_date - 653),
    (62, 56, 'Reemplazo de tapicería', 790000.00, current_date - 580),
    (63, 59, 'Reposición de piezas dañadas', 730000.00, current_date - 249),
    (64, 60, 'Reposición de piezas dañadas', 1080000.00, current_date - 618),
    (65, 60, 'Revisión de anclajes', 1400000.00, current_date - 445),
    (66, 61, 'Revisión cubierta por garantía', 0.00, current_date - 1011),
    (67, 61, 'Cambio de pantalla de consola', 1250000.00, current_date - 818),
    (68, 61, 'Cambio de banda', 1030000.00, current_date - 629),
    (69, 62, 'Reposición de piezas dañadas', 480000.00, current_date - 1209),
    (70, 62, 'Revisión de anclajes', 190000.00, current_date - 1014),
    (71, 62, 'Reposición de piezas dañadas', 930000.00, current_date - 803),
    (72, 63, 'Revisión eléctrica y de tarjeta', 1000000.00, current_date - 748),
    (73, 63, 'Cambio de pedales', 1170000.00, current_date - 642),
    (74, 63, 'Reemplazo de motor', 1050000.00, current_date - 508),
    (75, 64, 'Reemplazo de tapicería', 1300000.00, current_date - 958),
    (76, 65, 'Reposición de piezas dañadas', 980000.00, current_date - 1262),
    (77, 66, 'Cambio de poleas', 660000.00, current_date - 1275),
    (78, 66, 'Reemplazo de tapicería', 560000.00, current_date - 1166),
    (79, 66, 'Reemplazo de tapicería', 1320000.00, current_date - 1014),
    (80, 67, 'Reemplazo de motor', 80000.00, current_date - 351),
    (81, 68, 'Reposición de piezas dañadas', 260000.00, current_date - 1355),
    (82, 68, 'Reposición de piezas dañadas', 1490000.00, current_date - 1115),
    (83, 68, 'Limpieza profunda y desinfección', 1190000.00, current_date - 1015),
    (84, 70, 'Revisión cubierta por garantía', 0.00, current_date - 413),
    (85, 71, 'Revisión cubierta por garantía', 0.00, current_date - 516),
    (86, 72, 'Revisión de soldaduras', 910000.00, current_date - 332),
    (87, 72, 'Revisión de soldaduras', 1170000.00, current_date - 211),
    (88, 77, 'Cambio de pedales', 1010000.00, current_date - 1042),
    (89, 77, 'Revisión cubierta por garantía', 0.00, current_date - 963),
    (90, 77, 'Revisión cubierta por garantía', 0.00, current_date - 826),
    (91, 78, 'Revisión de cables', 720000.00, current_date - 392),
    (92, 81, 'Ajuste de tornillería y agarres', 290000.00, current_date - 1401),
    (93, 82, 'Cambio de pantalla de consola', 260000.00, current_date - 282),
    (94, 83, 'Revisión de soldaduras', 820000.00, current_date - 1228),
    (95, 83, 'Ajuste y calibración de pesas', 100000.00, current_date - 1069),
    (96, 83, 'Revisión de soldaduras', 1330000.00, current_date - 910),
    (97, 86, 'Reposición de piezas dañadas', 1420000.00, current_date - 483),
    (98, 86, 'Revisión cubierta por garantía', 0.00, current_date - 255),
    (99, 88, 'Revisión cubierta por garantía', 0.00, current_date - 839),
    (100, 89, 'Revisión de anclajes', 1080000.00, current_date - 1404),
    (101, 89, 'Reposición de piezas dañadas', 110000.00, current_date - 1331),
    (102, 89, 'Reposición de piezas dañadas', 550000.00, current_date - 1144),
    (103, 90, 'Revisión eléctrica y de tarjeta', 1080000.00, current_date - 993),
    (104, 90, 'Cambio de banda', 250000.00, current_date - 811),
    (105, 91, 'Cambio de poleas', 550000.00, current_date - 930),
    (106, 94, 'Lubricación de guías', 670000.00, current_date - 476),
    (107, 94, 'Cambio de poleas', 1330000.00, current_date - 348),
    (108, 95, 'Revisión de soldaduras', 520000.00, current_date - 1132),
    (109, 95, 'Revisión de soldaduras', 1290000.00, current_date - 906),
    (110, 96, 'Reemplazo de tapicería', 90000.00, current_date - 451),
    (111, 97, 'Lubricación de guías', 800000.00, current_date - 364),
    (112, 97, 'Reemplazo de tapicería', 1490000.00, current_date - 169),
    (113, 98, 'Reposición de piezas dañadas', 240000.00, current_date - 1017),
    (114, 99, 'Reposición de piezas dañadas', 940000.00, current_date - 261),
    (115, 99, 'Revisión de anclajes', 420000.00, current_date - 167),
    (116, 99, 'Reposición de piezas dañadas', 1400000.00, current_date - 92),
    (117, 99, 'Revisión de anclajes', 1400000.00, current_date - 6),
    (118, 100, 'Revisión cubierta por garantía', 0.00, current_date - 557),
    (119, 100, 'Cambio de rodamientos', 330000.00, current_date - 415),
    (120, 100, 'Revisión eléctrica y de tarjeta', 1150000.00, current_date - 254),
    (121, 101, 'Revisión de soldaduras', 470000.00, current_date - 447),
    (122, 101, 'Revisión cubierta por garantía', 0.00, current_date - 260),
    (123, 102, 'Revisión de soldaduras', 200000.00, current_date - 993),
    (124, 102, 'Cambio de poleas', 1070000.00, current_date - 17),
    (125, 104, 'Cambio de poleas', 1140000.00, current_date - 959),
    (126, 104, 'Cambio de poleas', 180000.00, current_date - 796),
    (127, 106, 'Revisión cubierta por garantía', 0.00, current_date - 1241),
    (128, 106, 'Revisión cubierta por garantía', 0.00, current_date - 1144),
    (129, 106, 'Ajuste de resistencia', 1190000.00, current_date - 1005),
    (130, 107, 'Revisión cubierta por garantía', 0.00, current_date - 364),
    (131, 107, 'Revisión de anclajes', 1050000.00, current_date - 2),
    (132, 108, 'Ajuste de tornillería y agarres', 1210000.00, current_date - 356),
    (133, 108, 'Reemplazo de tapicería', 930000.00, current_date - 136),
    (134, 108, 'Reemplazo de tapicería', 990000.00, current_date - 39),
    (135, 110, 'Revisión de soldaduras', 400000.00, current_date - 578),
    (136, 113, 'Cambio de banda', 1370000.00, current_date - 634),
    (137, 113, 'Revisión eléctrica y de tarjeta', 450000.00, current_date - 386),
    (138, 115, 'Revisión cubierta por garantía', 0.00, current_date - 937),
    (139, 115, 'Reposición de piezas dañadas', 440000.00, current_date - 772),
    (140, 115, 'Reposición de piezas dañadas', 390000.00, current_date - 600),
    (141, 116, 'Lubricación de guías', 780000.00, current_date - 97),
    (142, 118, 'Limpieza profunda y desinfección', 1500000.00, current_date - 344),
    (143, 119, 'Reemplazo de motor', 1030000.00, current_date - 1094),
    (144, 119, 'Cambio de banda', 730000.00, current_date - 18),
    (145, 123, 'Limpieza profunda y desinfección', 660000.00, current_date - 1118),
    (146, 123, 'Revisión de anclajes', 300000.00, current_date - 906),
    (147, 124, 'Revisión de cables', 160000.00, current_date - 842),
    (148, 128, 'Cambio de rodamientos', 160000.00, current_date - 495),
    (149, 128, 'Cambio de pedales', 1160000.00, current_date - 274),
    (150, 130, 'Limpieza profunda y desinfección', 160000.00, current_date - 422),
    (151, 131, 'Revisión de anclajes', 800000.00, current_date - 168),
    (152, 133, 'Ajuste de tornillería y agarres', 1320000.00, current_date - 583),
    (153, 133, 'Ajuste de tornillería y agarres', 210000.00, current_date - 425),
    (154, 133, 'Reemplazo de tapicería', 1050000.00, current_date - 240),
    (155, 136, 'Ajuste de tornillería y agarres', 910000.00, current_date - 578),
    (156, 136, 'Reemplazo de tapicería', 1120000.00, current_date - 362),
    (157, 137, 'Cambio de banda', 740000.00, current_date - 1164),
    (158, 137, 'Lubricación y calibración', 390000.00, current_date - 1066),
    (159, 137, 'Revisión eléctrica y de tarjeta', 1160000.00, current_date - 884),
    (160, 140, 'Reemplazo de motor', 1140000.00, current_date - 479),
    (161, 140, 'Reemplazo de motor', 290000.00, current_date - 270),
    (162, 142, 'Reposición de piezas dañadas', 330000.00, current_date - 67),
    (163, 144, 'Revisión de anclajes', 940000.00, current_date - 453),
    (164, 145, 'Revisión de soldaduras', 580000.00, current_date - 661),
    (165, 146, 'Reemplazo de tapicería', 820000.00, current_date - 100),
    (166, 147, 'Cambio de banda', 1020000.00, current_date - 1051),
    (167, 147, 'Revisión eléctrica y de tarjeta', 820000.00, current_date - 822),
    (168, 148, 'Revisión de desgaste y reemplazo de piezas', 1310000.00, current_date - 266),
    (169, 148, 'Revisión de desgaste y reemplazo de piezas', 360000.00, current_date - 198),
    (170, 149, 'Ajuste de resistencia', 530000.00, current_date - 1248),
    (171, 149, 'Cambio de banda', 230000.00, current_date - 7),
    (172, 150, 'Revisión cubierta por garantía', 0.00, current_date - 352),
    (173, 150, 'Reposición de piezas dañadas', 340000.00, current_date - 209),
    (174, 151, 'Ajuste de resistencia', 550000.00, current_date - 507),
    (175, 151, 'Cambio de banda', 1200000.00, current_date - 283),
    (176, 151, 'Revisión eléctrica y de tarjeta', 280000.00, current_date - 193),
    (177, 152, 'Reposición de piezas dañadas', 960000.00, current_date - 77),
    (178, 154, 'Reposición de piezas dañadas', 1250000.00, current_date - 644),
    (179, 156, 'Revisión de desgaste y reemplazo de piezas', 1110000.00, current_date - 248),
    (180, 157, 'Reemplazo de tapicería', 1000000.00, current_date - 247),
    (181, 157, 'Lubricación de guías', 1380000.00, current_date - 96),
    (182, 160, 'Ajuste y calibración de pesas', 430000.00, current_date - 878),
    (183, 160, 'Revisión cubierta por garantía', 0.00, current_date - 772),
    (184, 161, 'Ajuste de tornillería y agarres', 1460000.00, current_date - 745),
    (185, 161, 'Ajuste de tornillería y agarres', 1180000.00, current_date - 591),
    (186, 161, 'Reemplazo de tapicería', 510000.00, current_date - 492),
    (187, 162, 'Lubricación de guías', 490000.00, current_date - 181),
    (188, 162, 'Revisión cubierta por garantía', 0.00, current_date - 40),
    (189, 163, 'Ajuste de tornillería y agarres', 1390000.00, current_date - 1033),
    (190, 163, 'Revisión de soldaduras', 1260000.00, current_date - 7),
    (191, 164, 'Limpieza profunda y desinfección', 1320000.00, current_date - 1285),
    (192, 164, 'Limpieza profunda y desinfección', 1220000.00, current_date - 1093),
    (193, 164, 'Revisión cubierta por garantía', 0.00, current_date - 1017),
    (194, 164, 'Revisión de desgaste y reemplazo de piezas', 820000.00, current_date - 3),
    (195, 168, 'Revisión cubierta por garantía', 0.00, current_date - 1230),
    (196, 168, 'Reemplazo de motor', 960000.00, current_date - 1055),
    (197, 168, 'Revisión cubierta por garantía', 0.00, current_date - 821),
    (198, 169, 'Reemplazo de motor', 250000.00, current_date - 123),
    (199, 170, 'Revisión de cables', 1080000.00, current_date - 578),
    (200, 170, 'Ajuste y calibración de pesas', 1480000.00, current_date - 382),
    (201, 170, 'Ajuste y calibración de pesas', 920000.00, current_date - 245),
    (202, 171, 'Cambio de pantalla de consola', 1120000.00, current_date - 109),
    (203, 171, 'Lubricación y calibración', 950000.00, current_date - 33),
    (204, 174, 'Revisión de desgaste y reemplazo de piezas', 370000.00, current_date - 952),
    (205, 174, 'Revisión cubierta por garantía', 0.00, current_date - 841),
    (206, 174, 'Reposición de piezas dañadas', 430000.00, current_date - 642),
    (207, 175, 'Cambio de poleas', 1230000.00, current_date - 1283),
    (208, 175, 'Revisión de soldaduras', 1010000.00, current_date - 1162),
    (209, 175, 'Reemplazo de tapicería', 90000.00, current_date - 1044);

-- ---------------------------------------------------------------------
-- se ajustan al último id para que los INSERT de la aplicación
-- que usan nextval sigan desde ahí
-- ---------------------------------------------------------------------
SELECT setval('seq_rol_empleado', (SELECT max(id_rol_empleado)  FROM rol_empleado)::bigint);
SELECT setval('seq_tipo_plan', (SELECT max(id_tipo_plan)  FROM tipo_plan)::bigint);
SELECT setval('seq_metodo_pago', (SELECT max(id_metodo_pago) FROM metodo_pago)::bigint);
SELECT setval('seq_tipo_equipo', (SELECT max(id_tipo_equipo)   FROM tipo_equipo)::bigint);
SELECT setval('seq_sede', (SELECT max(id_sede) FROM sede)::bigint);
SELECT setval('seq_empleado', (SELECT max(id_empleado)  FROM empleado)::bigint);
SELECT setval('seq_miembro', (SELECT max(id_miembro) FROM miembro)::bigint);
SELECT setval('seq_membresia', (SELECT max(id_membresia) FROM membresia)::bigint);
SELECT setval('seq_pago', (SELECT max(id_pago)  FROM pago)::bigint);
SELECT setval('seq_clase',  (SELECT max(id_clase) FROM clase)::bigint);
SELECT setval('seq_sesion', (SELECT max(numero_sesion) FROM sesion)::bigint);
SELECT setval('seq_equipo', (SELECT max(id_equipo) FROM equipo)::bigint);
SELECT setval('seq_mantenimiento_equipo', (SELECT max(numero_mantenimiento) FROM mantenimiento_equipo)::bigint);


COMMIT;

-- =====================================================================
-- CONSULTAS DE VERIFICACIÓN
-- =====================================================================

-- 1. Cantidad de registros por tabla
SELECT 'sede' AS tabla, count(*) FROM sede UNION ALL
SELECT 'rol_empleado', count(*) FROM rol_empleado UNION ALL
SELECT 'empleado', count(*) FROM empleado UNION ALL
SELECT 'miembro', count(*) FROM miembro UNION ALL
SELECT 'info_medica', count(*) FROM info_medica UNION ALL
SELECT 'tipo_plan', count(*) FROM tipo_plan UNION ALL
SELECT 'membresia', count(*) FROM membresia UNION ALL
SELECT 'metodo_pago', count(*) FROM metodo_pago UNION ALL
SELECT 'pago', count(*) FROM pago UNION ALL
SELECT 'clase', count(*) FROM clase UNION ALL
SELECT 'sesion', count(*) FROM sesion UNION ALL
SELECT 'miembro_sesion', count(*) FROM miembro_sesion UNION ALL
SELECT 'tipo_equipo', count(*) FROM tipo_equipo UNION ALL
SELECT 'equipo', count(*) FROM equipo UNION ALL
SELECT 'mantenimiento_equipo', count(*) FROM mantenimiento_equipo;

-- 2. Miembro 1:N Membresía -> muchas membresías, máximo una activa
SELECT m.id_miembro, m.primer_nombre || ' ' || m.primer_apellido AS miembro,
       count(*)                                         AS total_membresias,
       count(*) FILTER (WHERE mb.estado = 'ACTIVA')     AS activas,
       count(*) FILTER (WHERE mb.estado = 'VENCIDA')    AS vencidas
  FROM miembro m JOIN membresia mb ON mb.id_miembro = m.id_miembro
 GROUP BY m.id_miembro, miembro
 ORDER BY total_membresias DESC
 LIMIT 10;

-- 3. Historial completo de un miembro con su pago de cada renovación
SELECT mb.id_membresia, tp.nombre AS plan, mb.estado, mb.fecha_inicio, mb.fecha_fin,
       p.id_pago, p.monto, mp.nombre AS metodo
  FROM membresia mb
  JOIN tipo_plan tp ON tp.id_tipo_plan = mb.id_tipo_plan
  LEFT JOIN pago p  ON p.id_miembro = mb.id_miembro AND p.fecha_pago = mb.fecha_inicio
  LEFT JOIN metodo_pago mp ON mp.id_metodo_pago = p.id_metodo_pago
 WHERE mb.id_miembro = (SELECT id_miembro FROM membresia GROUP BY id_miembro ORDER BY count(*) DESC LIMIT 1)
 ORDER BY mb.fecha_inicio;

-- 4. Reglas: cada consulta debe devolver 0
SELECT 'miembros con más de una activa' AS regla, count(*) FROM (
       SELECT id_miembro FROM membresia WHERE estado = 'ACTIVA' GROUP BY id_miembro HAVING count(*) > 1) x
UNION ALL
SELECT 'activas con fecha_fin pasada', count(*) FROM membresia WHERE estado = 'ACTIVA' AND fecha_fin < current_date
UNION ALL
SELECT 'membresías solapadas del mismo miembro', count(*)
  FROM membresia a JOIN membresia b ON a.id_miembro = b.id_miembro AND a.id_membresia < b.id_membresia
 WHERE a.fecha_inicio <= b.fecha_fin AND b.fecha_inicio <= a.fecha_fin
UNION ALL
SELECT 'membresías sin su pago', count(*) FROM membresia mb
 WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.id_miembro = mb.id_miembro AND p.fecha_pago = mb.fecha_inicio)
UNION ALL
SELECT 'clases con entrenador inválido', count(*) FROM clase c JOIN empleado e ON e.id_empleado = c.id_empleado
 WHERE e.id_rol_empleado <> 4 OR NOT e.activo OR e.id_sede <> c.id_sede
UNION ALL
SELECT 'sesiones cruzadas del mismo entrenador', count(*)
  FROM sesion s1 JOIN clase c1 ON c1.id_clase = s1.id_clase
  JOIN sesion s2 ON s2.fecha = s1.fecha AND s2.numero_sesion > s1.numero_sesion
  JOIN clase c2 ON c2.id_clase = s2.id_clase AND c2.id_empleado = c1.id_empleado
 WHERE s1.hora_inicio < s2.hora_fin AND s2.hora_inicio < s1.hora_fin
UNION ALL
SELECT 'sesiones sobre el cupo', count(*) FROM (
       SELECT ms.numero_sesion FROM miembro_sesion ms
         JOIN sesion s ON s.numero_sesion = ms.numero_sesion JOIN clase c ON c.id_clase = s.id_clase
        GROUP BY ms.numero_sesion, c.cupo_maximo HAVING count(*) > c.cupo_maximo) x
UNION ALL
SELECT 'inscripciones sin membresía activa ese día', count(*) FROM miembro_sesion ms
 WHERE NOT EXISTS (SELECT 1 FROM membresia mb WHERE mb.id_miembro = ms.id_miembro
                      AND ms.fecha_inscripcion BETWEEN mb.fecha_inicio AND mb.fecha_fin)
UNION ALL
SELECT 'inscripciones después de la sesión', count(*) FROM miembro_sesion ms
  JOIN sesion s ON s.numero_sesion = ms.numero_sesion WHERE ms.fecha_inscripcion > s.fecha
UNION ALL
SELECT 'asistencia marcada en sesiones futuras', count(*) FROM miembro_sesion ms
  JOIN sesion s ON s.numero_sesion = ms.numero_sesion WHERE ms.asistio AND s.fecha > current_date
UNION ALL
SELECT 'mantenimientos futuros o antes de la compra', count(*) FROM mantenimiento_equipo mt
  JOIN equipo e ON e.id_equipo = mt.id_equipo
 WHERE mt.fecha_mantenimiento > current_date OR mt.fecha_mantenimiento < e.fecha_adquisicion
UNION ALL
SELECT 'cadena sin administrador activo', CASE WHEN EXISTS (
       SELECT 1 FROM empleado WHERE id_rol_empleado = 1 AND activo) THEN 0 ELSE 1 END;

-- 5. Miembro N:M Sesión: inscritos y asistentes por sesión (primeras 15)
SELECT s.numero_sesion, c.nombre AS clase, se.nombre AS sede, s.fecha, s.hora_inicio,
       c.cupo_maximo, count(ms.id_miembro) AS inscritos,
       count(*) FILTER (WHERE ms.asistio) AS asistieron
  FROM sesion s
  JOIN clase c ON c.id_clase = s.id_clase
  JOIN sede se ON se.id_sede = c.id_sede
  LEFT JOIN miembro_sesion ms ON ms.numero_sesion = s.numero_sesion
 GROUP BY s.numero_sesion, c.nombre, se.nombre, s.fecha, s.hora_inicio, c.cupo_maximo
 ORDER BY s.numero_sesion
 LIMIT 15;

-- 6. Miembros que asisten a clases en una sede distinta a la suya
SELECT m.id_miembro, m.primer_nombre || ' ' || m.primer_apellido AS miembro,
       sm.nombre AS sede_inscrito, sc.nombre AS sede_clase, c.nombre AS clase, s.fecha
  FROM miembro_sesion ms
  JOIN miembro m  ON m.id_miembro = ms.id_miembro
  JOIN sesion s   ON s.numero_sesion = ms.numero_sesion
  JOIN clase c    ON c.id_clase = s.id_clase
  JOIN sede sm    ON sm.id_sede = m.id_sede
  JOIN sede sc    ON sc.id_sede = c.id_sede
 WHERE m.id_sede <> c.id_sede
 LIMIT 10;

-- 7. Sede 1:N Empleado / Miembro / Clase / Equipo
SELECT se.id_sede, se.nombre,
       (SELECT count(*) FROM empleado e WHERE e.id_sede = se.id_sede) AS empleados,
       (SELECT count(*) FROM miembro m  WHERE m.id_sede = se.id_sede) AS miembros,
       (SELECT count(*) FROM clase c    WHERE c.id_sede = se.id_sede) AS clases,
       (SELECT count(*) FROM equipo q   WHERE q.id_sede = se.id_sede) AS equipos
  FROM sede se ORDER BY se.id_sede;

-- 8. Equipo 1:N Mantenimiento: equipos con mantenimiento en los últimos 30 días
SELECT e.id_equipo, e.nombre, te.nombre AS tipo, se.nombre AS sede, mt.fecha_mantenimiento, mt.descripcion
  FROM mantenimiento_equipo mt
  JOIN equipo e       ON e.id_equipo = mt.id_equipo
  JOIN tipo_equipo te ON te.id_tipo_equipo = e.id_tipo_equipo
  JOIN sede se        ON se.id_sede = e.id_sede
 WHERE mt.fecha_mantenimiento >= current_date - 30
 ORDER BY mt.fecha_mantenimiento DESC;
