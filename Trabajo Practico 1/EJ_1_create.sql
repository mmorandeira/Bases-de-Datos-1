-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-08-29 12:05:58.878

-- tables
-- Table: TP1_EJ1_ARTICULO
CREATE TABLE TP1_EJ1_ARTICULO (
    id_articulo int  NOT NULL,
    titulo varchar(120)  NOT NULL,
    autor varchar(30)  NOT NULL,
    fecha_pub date  NOT NULL,
    CONSTRAINT PK_TP1_EJ1_ARTICULO PRIMARY KEY (id_articulo)
);

-- Table: TP1_EJ1_CONTIENE
CREATE TABLE TP1_EJ1_CONTIENE (
    cod_p int  NOT NULL,
    idioma char(2)  NOT NULL,
    id_articulo int  NOT NULL,
    CONSTRAINT PK_TP1_EJ1_CONTIENE PRIMARY KEY (cod_p,idioma,id_articulo)
);

-- Table: TP1_EJ1_PALABRA
CREATE TABLE TP1_EJ1_PALABRA (
    cod_p int  NOT NULL,
    idioma char(2)  NOT NULL,
    descripcion varchar(25)  NOT NULL,
    CONSTRAINT PK_TP1_EJ1_PALABRA PRIMARY KEY (cod_p,idioma)
);

-- foreign keys
-- Reference: TP1_EJ1_CONTIENE_TP1_EJ1_ARTICULO (table: TP1_EJ1_CONTIENE)
ALTER TABLE TP1_EJ1_CONTIENE ADD CONSTRAINT TP1_EJ1_CONTIENE_TP1_EJ1_ARTICULO
    FOREIGN KEY (id_articulo)
    REFERENCES TP1_EJ1_ARTICULO (id_articulo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TP1_EJ1_CONTIENE_TP1_EJ1_PALABRA (table: TP1_EJ1_CONTIENE)
ALTER TABLE TP1_EJ1_CONTIENE ADD CONSTRAINT TP1_EJ1_CONTIENE_TP1_EJ1_PALABRA
    FOREIGN KEY (cod_p, idioma)
    REFERENCES TP1_EJ1_PALABRA (cod_p, idioma)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

