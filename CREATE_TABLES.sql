CREATE TYPE nivel_gravedad_enum AS ENUM ('1', '2', '3', '4', '5');
CREATE TYPE tipo_incidente_enum AS ENUM ('ACCIDENTE DE TRÁNSITO', 'INCENDIO', 'EMERGENCIA MÉDICA', 'DELITO');
CREATE TYPE tipo_recurso_enum AS ENUM ('AMBULANCIA', 'BOMBERO', 'PATRULLERO');
CREATE TYPE nivel_riesgo_enum AS ENUM ('BAJO', 'MEDIO', 'ALTO');
CREATE TYPE estado_incidente_enum AS ENUM ('PENDIENTE', 'EN_PROCESO', 'RESUELTO', 'EN PROCESO');
CREATE TYPE estado_recurso_enum as ENUM ('DISPONIBLE', 'OCUPADO', 'FUERA DE SERVICIO');
CREATE TYPE estado_asignacion_enum as ENUM ('EXITOSA', 'EN_CAMINO', 'FALLIDA')

CREATE TABLE Zonas (
    id           SERIAL            PRIMARY KEY,
    nivel_riesgo nivel_riesgo_enum NOT NULL
);

CREATE TABLE Auditoria_Zonas (
    id_zona      INT            PRIMARY KEY,
    nivel_riesgo nivel_riesgo_enum NOT NULL,
    id_usuario  INT             NOT NULL,
    fecha_hora  TIMESTAMP       NOT NULL,
    accion      VARCHAR(255)    NOT NULL,

    CONSTRAINT fk_auditoria_zonas
        FOREIGN KEY (id_zona) REFERENCES Zonas(id)
);

CREATE TABLE Sensores (
    id          SERIAL  PRIMARY KEY,
    coordenada_x REAL   NOT NULL,
    coordenada_y REAL   NOT NULL,
    descripcion TEXT,
    id_zona     INT     NOT NULL,

    CONSTRAINT fk_sensor_zona
        FOREIGN KEY (id_zona) REFERENCES Zonas(id)
);

CREATE TABLE Auditoria_Sensores (
    id_sensor          INT  PRIMARY KEY,
    coordenada_x REAL   NOT NULL,
    coordenada_y REAL   NOT NULL,
    id_zona     INT     NOT NULL,
    id_usuario  INT             NOT NULL,
    fecha_hora  TIMESTAMP       NOT NULL,
    accion      VARCHAR(255)    NOT NULL,
    CONSTRAINT fk_sensor_zona
        FOREIGN KEY (id_zona) REFERENCES Zonas(id)
);

CREATE TABLE Recursos (
    id                        SERIAL            PRIMARY KEY,
    tipo                      tipo_recurso_enum NOT NULL,
    coordenada_x              REAL              NOT NULL,
    coordenada_y              REAL              NOT NULL,
    cantidad_incidentes_resueltos       INT           NOT NULL DEFAULT 0,
    cantidad_incidentes _asignados      INT               NOT NULL DEFAULT 0,
    id_zona                   INT               NOT NULL,

    CONSTRAINT fk_recurso_zona
        FOREIGN KEY (id_zona) REFERENCES Zonas(id)
);

CREATE TABLE Auditoria_Recursos (
    id                        SERIAL            PRIMARY KEY,
    tipo                      tipo_recurso_enum NOT NULL,
    cantidad_incidentes_resueltos       INT           NOT NULL DEFAULT 0,
    cantidad_incidentes _asignados      INT               NOT NULL DEFAULT 0,
    id_zona                   INT               NOT NULL,
    id_usuario  INT             NOT NULL,
    fecha_hora  TIMESTAMP       NOT NULL,
    accion      VARCHAR(255)    NOT NULL,
    CONSTRAINT fk_recurso_zona
        FOREIGN KEY (id_zona) REFERENCES Zonas(id)
);

CREATE TABLE Gravedad (
    id       SERIAL        PRIMARY KEY,
    duracion INT           NOT NULL,   -- tiempo de espera máximo del SLA en minutos
    nivel    nivel_gravedad_enum NOT NULL
);

CREATE TABLE Estado_Incidente (
    estado          estado_incidente_enum       PRIMARY KEY,
    id_incidente  tipo_incidente_enum NOT NULL PRIMARY KEY,
    tiempo_inicio    TIMESTAMP NOT NULL,
    tiempo_fin       TIMESTAMP --si tiempo_fin es null, es el estado actual
);

CREATE TABLE Penalizaciones (
    id     SERIAL       PRIMARY KEY,
    razon  VARCHAR(255) NOT NULL
);

CREATE TABLE Estado_Recurso (
    id          SERIAL       PRIMARY KEY,
    estado      estado_recurso_enum NOT NULL
);

CREATE TABLE Recursos-Estado_Recurso (
    id_recurso       INT       NOT NULL,
    id_estado_recurso INT      NOT NULL,
    tiempo_inicio    TIMESTAMP NOT NULL,
    tiempo_fin       TIMESTAMP,           -- NULL = estado actual activo

    CONSTRAINT pk_recurso_estado
        PRIMARY KEY (id_recurso, id_estado_recurso, tiempo_inicio),

    CONSTRAINT fk_re_recurso
        FOREIGN KEY (id_recurso)        REFERENCES Recursos(id),
    CONSTRAINT fk_re_estado_recurso
        FOREIGN KEY (id_estado_recurso) REFERENCES Estado_Recurso(id)
);

CREATE TABLE Incidente (
    id           SERIAL             PRIMARY KEY,
    fecha_hora        TIMESTAMP               NOT NULL,
    tipo         tipo_incidente_enum NOT NULL,
    coordenadas_x REAL              NOT NULL,
    coordenadas_y REAL              NOT NULL,
    id_sensor    INT,
    id_zona      INT                NOT NULL,

    CONSTRAINT fk_incidente_sensor
        FOREIGN KEY (id_sensor) REFERENCES Sensores(id),
    CONSTRAINT fk_incidente_zona
        FOREIGN KEY (id_zona)   REFERENCES Zonas(id)
);

CREATE TABLE Incidente_Gravedad (
    id_gravedad  INT       NOT NULL,
    id_incidente INT       NOT NULL,
    tiempo_inicio TIMESTAMP NOT NULL,
    tiempo_fin   TIMESTAMP,
    motivo       TEXT,

    CONSTRAINT pk_incidente_gravedad
        PRIMARY KEY (id_gravedad, id_incidente),

    CONSTRAINT fk_ig_gravedad
        FOREIGN KEY (id_gravedad)  REFERENCES Gravedad(id),
    CONSTRAINT fk_ig_incidente
        FOREIGN KEY (id_incidente) REFERENCES Incidente(id)
);

CREATE TABLE Incidente_Estado_Incidente (
    id_estado_incidente INT       NOT NULL,
    id_incidente        INT       NOT NULL,
    tiempo_inicio       TIMESTAMP NOT NULL,
    tiempo_fin          TIMESTAMP,

    CONSTRAINT pk_incidente_estado
        PRIMARY KEY (id_estado_incidente, id_incidente),

    CONSTRAINT fk_iei_estado
        FOREIGN KEY (id_estado_incidente) REFERENCES Estado_Incidente(id),
    CONSTRAINT fk_iei_incidente
        FOREIGN KEY (id_incidente)        REFERENCES Incidente(id)
);

CREATE TABLE Asignaciones (
    id_recurso     INT                    NOT NULL,
    id_incidente   INT                    NOT NULL,
    estado         estado_asignaciones_enum NOT NULL DEFAULT 'PENDIENTE',
    fecha_hora      TIMESTAMP       NOT NULL,
    id_penalizacion INT,                           -- NULL si no hay sanción

    CONSTRAINT pk_asignacion
        PRIMARY KEY (id_recurso, id_incidente),

    CONSTRAINT fk_asig_recurso
        FOREIGN KEY (id_recurso)      REFERENCES Recursos(id),
    CONSTRAINT fk_asig_incidente
        FOREIGN KEY (id_incidente)    REFERENCES Incidente(id),
    CONSTRAINT fk_asig_penalizacion
        FOREIGN KEY (id_penalizacion) REFERENCES Penalizaciones(id)
);
