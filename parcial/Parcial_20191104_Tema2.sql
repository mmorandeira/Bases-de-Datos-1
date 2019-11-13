-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-11-04 02:48:12.688

-- tables
-- Table: ALQUILER
CREATE TABLE ALQUILER (
    id_alquiler int  NOT NULL,
    nro_doc int  NULL,
    tipo_doc char(3)  NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    importe decimal(10,2)  NOT NULL,
    confirmacion boolean  NOT NULL,
    CONSTRAINT PK_ALQUILER PRIMARY KEY (id_alquiler)
);

-- Table: ALQUILER_SERVICIO
CREATE TABLE ALQUILER_SERVICIO (
    tipo_serv char(10)  NOT NULL,
    id_alquiler int  NOT NULL,
    id_serv int  NOT NULL,
    situacion boolean  NOT NULL,
    CONSTRAINT PK_ALQUILER_POSICIONES PRIMARY KEY (tipo_serv,id_alquiler,id_serv)
);

-- Table: SERVICIO
CREATE TABLE SERVICIO (
    id_servicio int  NOT NULL,
    tipo_serv char(10)  NOT NULL,
    caracteristica varchar(50)  NOT NULL,
    valor decimal(10,2)  NOT NULL,
    CONSTRAINT PK_POSICION PRIMARY KEY (id_servicio,tipo_serv)
);

-- Table: TIPO_SERVICIO
CREATE TABLE TIPO_SERVICIO (
    tipo_serv char(10)  NOT NULL,
    descrip varchar(50)  NOT NULL,
    duracion_max decimal(10,2)  NOT NULL,
    distancia_max decimal(10,2)  NULL,
    CONSTRAINT PK_FILA PRIMARY KEY (tipo_serv)
);

-- Table: USUARIO
CREATE TABLE USUARIO (
    nro_doc int  NOT NULL,
    tipo_doc char(3)  NOT NULL,
    nom_apell varchar(50)  NOT NULL,
    fecha_ingreso date  NOT NULL,
    direccion varchar(30)  NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (nro_doc,tipo_doc)
);

-- foreign keys
-- Reference: FK_ESPACIO_TIPO (table: SERVICIO)
ALTER TABLE SERVICIO ADD CONSTRAINT FK_ESPACIO_TIPO
    FOREIGN KEY (tipo_serv)
    REFERENCES TIPO_SERVICIO (tipo_serv)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_RESERVA_CONTACTO (table: ALQUILER)
ALTER TABLE ALQUILER ADD CONSTRAINT FK_RESERVA_CONTACTO
    FOREIGN KEY (nro_doc, tipo_doc)
    REFERENCES USUARIO (nro_doc, tipo_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

