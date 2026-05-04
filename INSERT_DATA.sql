-- ============================================================
-- INSERT_DATA.sql
-- Datos de prueba para el sistema de gestión de incidentes
-- ============================================================

-- --------------------------------------------------------
-- 1. Gravedad (5 filas)
--    nivel: '1'..'5', duracion en minutos
-- --------------------------------------------------------
INSERT INTO Gravedad (duracion, nivel) VALUES (240, '1');  -- 1
INSERT INTO Gravedad (duracion, nivel) VALUES (120, '2');  -- 2
INSERT INTO Gravedad (duracion, nivel) VALUES (60,  '3');  -- 3
INSERT INTO Gravedad (duracion, nivel) VALUES (30,  '4');  -- 4
INSERT INTO Gravedad (duracion, nivel) VALUES (10,  '5');  -- 5

-- --------------------------------------------------------
-- 2. Estado_Incidente (4 filas)
--    descripcion: tipo_incidente_enum
-- --------------------------------------------------------
INSERT INTO Estado_Incidente (descripcion) VALUES ('ACCIDENTE DE TRÁNSITO');  -- 1
INSERT INTO Estado_Incidente (descripcion) VALUES ('INCENDIO');               -- 2
INSERT INTO Estado_Incidente (descripcion) VALUES ('EMERGENCIA MÉDICA');      -- 3
INSERT INTO Estado_Incidente (descripcion) VALUES ('DELITO');                 -- 4

-- --------------------------------------------------------
-- 3. Penalizaciones (4 filas)
-- --------------------------------------------------------
INSERT INTO Penalizaciones (razon) VALUES ('Demora en la respuesta al incidente');             -- 1
INSERT INTO Penalizaciones (razon) VALUES ('Recurso no disponible al momento de asignación'); -- 2
INSERT INTO Penalizaciones (razon) VALUES ('Incumplimiento del SLA de nivel 5');              -- 3
INSERT INTO Penalizaciones (razon) VALUES ('Abandono de zona sin autorización');              -- 4

-- --------------------------------------------------------
-- 4. Estado_Recurso (3 filas)
-- --------------------------------------------------------
INSERT INTO Estado_Recurso (descripcion) VALUES ('DISPONIBLE');   -- 1
INSERT INTO Estado_Recurso (descripcion) VALUES ('OCUPADO');      -- 2
INSERT INTO Estado_Recurso (descripcion) VALUES ('FUERA DE SERVICIO'); -- 3

-- --------------------------------------------------------
-- 5. Zonas (5 filas)
--    nivel_riesgo: 'BAJO', 'MEDIO', 'ALTO'
-- --------------------------------------------------------
INSERT INTO Zonas (nivel_riesgo) VALUES ('ALTO');   -- 1
INSERT INTO Zonas (nivel_riesgo) VALUES ('ALTO');   -- 2
INSERT INTO Zonas (nivel_riesgo) VALUES ('MEDIO');  -- 3
INSERT INTO Zonas (nivel_riesgo) VALUES ('MEDIO');  -- 4
INSERT INTO Zonas (nivel_riesgo) VALUES ('BAJO');   -- 5

-- --------------------------------------------------------
-- 6. Sensores (5 filas)
-- --------------------------------------------------------
INSERT INTO Sensores (coordenada_x, coordenada_y, descripcion, id_zona)
    VALUES (-34.6037, -58.3816, 'Sensor cámara intersección Av. Corrientes y Florida', 1);  -- 1
INSERT INTO Sensores (coordenada_x, coordenada_y, descripcion, id_zona)
    VALUES (-34.6150, -58.3700, 'Sensor humo barrio La Boca',                          1);  -- 2
INSERT INTO Sensores (coordenada_x, coordenada_y, descripcion, id_zona)
    VALUES (-34.5900, -58.4100, 'Sensor movimiento Palermo',                           3);  -- 3
INSERT INTO Sensores (coordenada_x, coordenada_y, descripcion, id_zona)
    VALUES (-34.6200, -58.4400, 'Sensor acústico Caballito',                           4);  -- 4
INSERT INTO Sensores (coordenada_x, coordenada_y, descripcion, id_zona)
    VALUES (-34.6500, -58.4700, 'Sensor temperatura Flores',                           5);  -- 5

-- --------------------------------------------------------
-- 7. Recursos (6 filas)
--    tipo: 'AMBULANCIA', 'BOMBERO', 'PATRULLERO'
-- --------------------------------------------------------
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('AMBULANCIA', -34.6010, -58.3820, 45, 48, 1);  -- 1
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('BOMBERO',    -34.6140, -58.3710, 30, 33, 1);  -- 2
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('PATRULLERO', -34.5910, -58.4080, 62, 65, 3);  -- 3
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('AMBULANCIA', -34.6210, -58.4410, 18, 20, 4);  -- 4
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('PATRULLERO', -34.6490, -58.4680, 10, 10, 5);  -- 5
INSERT INTO Recursos (tipo, coordenada_x, coordenada_y, cantidad_incidentes_resueltos, cantidad_incidentes, id_zona)
    VALUES ('BOMBERO',    -34.6080, -58.3950, 25, 28, 2);  -- 6

-- --------------------------------------------------------
-- 8. Recursos_Estado_Recurso (6 filas)
-- --------------------------------------------------------
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (1, 2, '2026-05-01 08:00:00', '2026-05-01 10:30:00');
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (1, 1, '2026-05-01 10:30:00', NULL);
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (2, 2, '2026-05-01 09:15:00', '2026-05-01 11:45:00');
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (2, 1, '2026-05-01 11:45:00', NULL);
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (3, 3, '2026-05-02 07:00:00', '2026-05-02 18:00:00');
INSERT INTO Recursos_Estado_Recurso (id_recurso, id_estado_recurso, tiempo_inicio, tiempo_fin)
    VALUES (4, 1, '2026-05-03 06:00:00', NULL);

-- --------------------------------------------------------
-- 9. Incidente (6 filas)
-- --------------------------------------------------------
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-01', 'ACCIDENTE DE TRÁNSITO', -34.6040, -58.3815, 1, 1);  -- 1
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-01', 'INCENDIO',              -34.6145, -58.3705, 2, 1);  -- 2
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-02', 'EMERGENCIA MÉDICA',     -34.5905, -58.4095, 3, 3);  -- 3
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-02', 'DELITO',                -34.6205, -58.4405, 4, 4);  -- 4
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-03', 'ACCIDENTE DE TRÁNSITO', -34.6495, -58.4675, 5, 5);  -- 5
INSERT INTO Incidente (fecha, tipo, coordenadas_x, coordenadas_y, id_sensor, id_zona)
    VALUES ('2026-05-03', 'INCENDIO',              -34.6085, -58.3945, NULL, 2); -- 6

-- --------------------------------------------------------
-- 10. Incidente_Gravedad (6 filas)
-- --------------------------------------------------------
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (5, 1, '2026-05-01 08:05:00', NULL,                  'Colisión múltiple con heridos graves');
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (4, 2, '2026-05-01 09:20:00', '2026-05-01 11:50:00', 'Incendio controlado en depósito');
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (3, 3, '2026-05-02 14:00:00', NULL,                  'Paro cardíaco en vía pública');
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (2, 4, '2026-05-02 22:10:00', NULL,                  'Robo a mano armada');
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (3, 5, '2026-05-03 07:45:00', '2026-05-03 09:00:00', 'Choque leve sin heridos');
INSERT INTO Incidente_Gravedad (id_gravedad, id_incidente, tiempo_inicio, tiempo_fin, motivo)
    VALUES (5, 6, '2026-05-03 11:30:00', NULL,                  'Incendio estructural con riesgo de derrumbe');

-- --------------------------------------------------------
-- 11. Incidente_Estado_Incidente (6 filas)
-- --------------------------------------------------------
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (1, 1, '2026-05-01 08:05:00', '2026-05-01 08:20:00');
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (2, 2, '2026-05-01 09:20:00', '2026-05-01 11:50:00');
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (3, 3, '2026-05-02 14:00:00', NULL);
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (4, 4, '2026-05-02 22:10:00', NULL);
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (1, 5, '2026-05-03 07:45:00', '2026-05-03 08:00:00');
INSERT INTO Incidente_Estado_Incidente (id_estado_incidente, id_incidente, tiempo_inicio, tiempo_fin)
    VALUES (2, 6, '2026-05-03 11:30:00', NULL);

-- --------------------------------------------------------
-- 12. Asignaciones (6 filas)
--    estado: 'PENDIENTE', 'EN_PROCESO', 'RESUELTO', 'ESCALADO'
-- --------------------------------------------------------
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (1, 1, 'EN_PROCESO', NULL);
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (2, 2, 'RESUELTO',   NULL);
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (1, 3, 'EN_PROCESO', NULL);
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (3, 4, 'ESCALADO',   1);
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (5, 5, 'RESUELTO',   NULL);
INSERT INTO Asignaciones (id_recurso, id_incidente, estado, id_penalizacion)
    VALUES (6, 6, 'PENDIENTE',  NULL);
