CREATE TABLE pacientes (
    id_paciente SERIAL,
    cedula VARCHAR(20),
    nombre_completo VARCHAR(120),
    fecha_nacimiento DATE,
    tipo_sangre VARCHAR(5),

    CONSTRAINT pk_pacientes PRIMARY KEY (id_paciente),
    CONSTRAINT uq_pacientes_cedula UNIQUE (cedula),
    CONSTRAINT chk_pacientes_tipo_sangre 
        CHECK (tipo_sangre IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
);

CREATE TABLE personal_medico (
    id_medico SERIAL,
    nombre_completo VARCHAR(120),
    tarjeta_profesional VARCHAR(50),
    especialidad VARCHAR(100),

    CONSTRAINT pk_personal_medico PRIMARY KEY (id_medico),
    CONSTRAINT uq_personal_medico_tarjeta UNIQUE (tarjeta_profesional)
);

CREATE TABLE citas_medicas (
    id_cita SERIAL,
    id_paciente INT,
    id_medico INT,
    fecha_hora TIMESTAMP,
    motivo_consulta VARCHAR(255),

    CONSTRAINT pk_citas_medicas PRIMARY KEY (id_cita),
    CONSTRAINT fk_citas_paciente 
        FOREIGN KEY (id_paciente) 
        REFERENCES pacientes(id_paciente)
        ON DELETE RESTRICT,
    CONSTRAINT fk_citas_medico 
        FOREIGN KEY (id_medico) 
        REFERENCES personal_medico(id_medico)
        ON DELETE SET NULL
);

CREATE TABLE historias_clinicas (
    id_historia SERIAL,
    id_cita INT,
    diagnostico TEXT,
    tratamiento_recetado TEXT,

    CONSTRAINT pk_historias_clinicas PRIMARY KEY (id_historia),
    CONSTRAINT uq_historias_id_cita UNIQUE (id_cita),
    CONSTRAINT fk_historias_cita 
        FOREIGN KEY (id_cita) 
        REFERENCES citas_medicas(id_cita)
        ON DELETE CASCADE
);

CREATE TABLE monitoreo_signos_vitales (
    id_monitoreo SERIAL,
    id_paciente INT,
    frecuencia_cardiaca INT,
    temperatura DECIMAL(4,2),
    fecha_hora TIMESTAMP,

    CONSTRAINT pk_monitoreo_signos PRIMARY KEY (id_monitoreo),
    CONSTRAINT fk_monitoreo_paciente 
        FOREIGN KEY (id_paciente) 
        REFERENCES pacientes(id_paciente)
        ON DELETE CASCADE,
    CONSTRAINT chk_monitoreo_fc 
        CHECK (frecuencia_cardiaca > 0),
    CONSTRAINT chk_monitoreo_temperatura 
        CHECK (temperatura >= 30 AND temperatura <= 45)
);