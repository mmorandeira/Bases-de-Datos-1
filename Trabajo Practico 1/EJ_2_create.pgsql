CREATE TABLE TP1_EJ2_CURSO(
    cod char(4) NOT NULL,
    descripcion varchar(40) NOT NULL,
    tipo char(1) NOT NULL,
    ref_cod char(4) NOT NULL,
    ref_lu int NOT NULL,
    CONSTRAINT PK_TP1_EJ2_CURSO PRIMARY KEY (cod)
);

CREATE TABLE TP1_EJ2_ALUMNO(
    LU int NOT NULL,
    nombre varchar(40) NOT NULL,
    provincia varchar(30) NOT NULL,
    CONSTRAINT PK_TP1_EJ2_ALUMNO PRIMARY KEY (lu)
);

CREATE TABLE TP1_EJ2_INSCRIPTO(
    cod int NOT NULL,
    LU int NOT NULL,
    CONSTRAINT PK_TP1_EJ2_INSCRIPTO PRIMARY KEY (cod,lu)
);

ALTER TABLE TP1_EJ2_CURSO ADD CONSTRAINT ES_REFERENTE
FOREIGN KEY (ref_cod,ref_lu)
REFERENCES TP1_EJ2_INSCRIPTO(cod,lu)
NOT DEFERRABLE
INITIALLY INMEDIATE
;

ALTER TABLE TP1_EJ2_INSCRIPTO ADD CONSTRAINT INSCRIPTO
FOREIGN KEY ()