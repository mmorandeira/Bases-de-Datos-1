-- --
-- -- unc_248557QL database dump
-- --

-- -- Dumped from database version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)
-- -- Dumped by pg_dump version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- --
-- -- Name: unc_esq_voluntario; Type: SCHEMA; Schema: -; Owner: unc_248557
-- --

-- CREATE SCHEMA unc_esq_voluntario;


-- ALTER SCHEMA unc_esq_voluntario OWNER TO unc_248557;

-- --
-- -- Name: SCHEMA unc_esq_voluntario; Type: COMMENT; Schema: -; Owner: unc_248557
-- --

-- COMMENT ON SCHEMA unc_esq_voluntario IS 'Esquema de Voluntarios de la Cátedra';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: voluntario; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_voluntario (
    nombre character varying(20),
    apellido character varying(25) NOT NULL,
    e_mail character varying(40) NOT NULL,
    telefono character varying(20),
    fecha_nacimiento date NOT NULL,
    id_tarea character varying(10) NOT NULL,
    nro_voluntario numeric(6,0) NOT NULL,
    horas_aportadas numeric(8,2),
    porcentaje numeric(2,2),
    id_institucion numeric(4,0),
    id_coordinador numeric(6,0),
    CONSTRAINT voluntario_chk_hs_ap CHECK ((horas_aportadas > (0)::numeric)),
    CONSTRAINT voluntario_ck_horas_aportadas CHECK (((horas_aportadas <= (24000)::numeric) AND (id_coordinador < (206)::numeric)))
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_voluntario OWNER TO unc_248557;

--
-- Name: tarea; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_tarea (
    nombre_tarea character varying(40) NOT NULL,
    min_horas numeric(6,0),
    id_tarea character varying(10) NOT NULL,
    max_horas numeric(6,0)
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_tarea OWNER TO unc_248557;

--
-- Name: continente; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_continente (
    nombre_continente character varying(25),
    id_continente numeric NOT NULL
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_continente OWNER TO unc_248557;

--
-- Name: direccion; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_direccion (
    calle character varying(40),
    codigo_postal character varying(12),
    ciudad character varying(30) NOT NULL,
    provincia character varying(25),
    id_pais character(2) NOT NULL,
    id_direccion numeric(4,0) NOT NULL
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_direccion OWNER TO unc_248557;

--
-- Name: historico; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_historico (
    fecha_inicio date NOT NULL,
    nro_voluntario numeric(6,0) NOT NULL,
    fecha_fin date NOT NULL,
    id_tarea character varying(10) NOT NULL,
    id_institucion numeric(4,0),
    CONSTRAINT voluntario_historico_check CHECK ((fecha_fin > fecha_inicio))
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_historico OWNER TO unc_248557;

--
-- Name: institucion; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_institucion (
    nombre_institucion character varying(60) NOT NULL,
    id_director numeric(6,0),
    id_direccion numeric(4,0),
    id_institucion numeric(4,0) NOT NULL
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_institucion OWNER TO unc_248557;

--
-- Name: pais; Type: TABLE; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE TABLE unc_248557.voluntario_pais (
    nombre_pais character varying(40),
    id_continente numeric NOT NULL,
    id_pais character(2) NOT NULL
)
WITH (autovacuum_enabled='true');


ALTER TABLE unc_248557.voluntario_pais OWNER TO unc_248557;

--
-- Data for Name: continente; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_continente VALUES ('Europeo', 1);
INSERT INTO unc_248557.voluntario_continente VALUES ('Norte Americano', 2);
INSERT INTO unc_248557.voluntario_continente VALUES ('Asiatico', 3);
INSERT INTO unc_248557.voluntario_continente VALUES ('Africano', 4);
INSERT INTO unc_248557.voluntario_continente VALUES ('Sud Americano', 5);
INSERT INTO unc_248557.voluntario_continente VALUES ('Oceania', 6);


--
-- Data for Name: direccion; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_direccion VALUES ('1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT', 1000);
INSERT INTO unc_248557.voluntario_direccion VALUES ('93091 Calle della Testa', '10934', 'Venice', NULL, 'IT', 1100);
INSERT INTO unc_248557.voluntario_direccion VALUES ('2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP', 1200);
INSERT INTO unc_248557.voluntario_direccion VALUES ('9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP', 1300);
INSERT INTO unc_248557.voluntario_direccion VALUES ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US', 1400);
INSERT INTO unc_248557.voluntario_direccion VALUES ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US', 1500);
INSERT INTO unc_248557.voluntario_direccion VALUES ('2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US', 1600);
INSERT INTO unc_248557.voluntario_direccion VALUES ('2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US', 1700);
INSERT INTO unc_248557.voluntario_direccion VALUES ('147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA', 1800);
INSERT INTO unc_248557.voluntario_direccion VALUES ('6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA', 1900);
INSERT INTO unc_248557.voluntario_direccion VALUES ('40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN', 2000);
INSERT INTO unc_248557.voluntario_direccion VALUES ('1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN', 2100);
INSERT INTO unc_248557.voluntario_direccion VALUES ('12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU', 2200);
INSERT INTO unc_248557.voluntario_direccion VALUES ('198 Clementi North', '540198', 'Singapore', NULL, 'SG', 2300);
INSERT INTO unc_248557.voluntario_direccion VALUES ('8204 Arthur St', NULL, 'London', NULL, 'UK', 2400);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK', 2500);
INSERT INTO unc_248557.voluntario_direccion VALUES ('9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK', 2600);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE', 2700);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR', 2800);
INSERT INTO unc_248557.voluntario_direccion VALUES ('20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH', 2900);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH', 3000);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL', 3100);
INSERT INTO unc_248557.voluntario_direccion VALUES ('Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX', 3200);


--
-- Data for Name: historico; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_historico VALUES ('1993-01-13', 102, '1998-07-24', 'IT_PROG', 60);
INSERT INTO unc_248557.voluntario_historico VALUES ('1989-09-21', 101, '1993-10-27', 'AC_ACCOUNT', 110);
INSERT INTO unc_248557.voluntario_historico VALUES ('1993-10-28', 101, '1997-03-15', 'AC_MGR', 110);
INSERT INTO unc_248557.voluntario_historico VALUES ('1996-02-17', 201, '1999-12-19', 'MK_REP', 20);
INSERT INTO unc_248557.voluntario_historico VALUES ('1998-03-24', 114, '1999-12-31', 'ST_CLERK', 50);
INSERT INTO unc_248557.voluntario_historico VALUES ('1999-01-01', 122, '1999-12-31', 'ST_CLERK', 50);
INSERT INTO unc_248557.voluntario_historico VALUES ('1987-09-17', 200, '1993-06-17', 'AD_ASST', 90);
INSERT INTO unc_248557.voluntario_historico VALUES ('1998-03-24', 176, '1998-12-31', 'SA_REP', 80);
INSERT INTO unc_248557.voluntario_historico VALUES ('1999-01-01', 176, '1999-12-31', 'SA_MAN', 80);
INSERT INTO unc_248557.voluntario_historico VALUES ('1994-07-01', 200, '1998-12-31', 'AC_ACCOUNT', 90);
INSERT INTO unc_248557.voluntario_historico VALUES ('1970-01-06', 176, '2019-08-28', 'SA_MAN', 20);


--
-- Data for Name: institucion; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_institucion VALUES ('CASA DE LA PROVIDENCIA', 200, 1700, 10);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CORPORACION URRACAS DE EMAUS', 201, 1800, 20);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION CIVITAS', 114, 1700, 30);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION LAS ROSAS DE AYUDA FRATERNA', 203, 2400, 40);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION HOGAR DE CRISTO', 121, 1500, 50);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION MI CASA', 103, 1400, 60);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CORPORACION SOLIDARIDAD Y DESARROLLO', 204, 2700, 70);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION REGAZO', 145, 2500, 80);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION ALERTA BOSQUES', 100, 1700, 90);
INSERT INTO unc_248557.voluntario_institucion VALUES ('BOSQUEDUCA', 108, 1700, 100);
INSERT INTO unc_248557.voluntario_institucion VALUES ('COMITE NACIONAL PRO DEFENSA DE LA FLORA Y LA FAUNA', 205, 1700, 110);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CONSEJO ECOLOGICO COMUNAL', NULL, 1700, 120);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CORPORACION AMBIENTAL', NULL, 1700, 130);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION VIDA RURAL', NULL, 1700, 140);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CENTRO DE AYUDA MAPUCHE', NULL, 1700, 150);
INSERT INTO unc_248557.voluntario_institucion VALUES ('SIERRAS PROTEGIDAS', NULL, 1700, 160);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CENTRO DE EDUCACION AMBIENTAL', NULL, 1700, 170);
INSERT INTO unc_248557.voluntario_institucion VALUES ('RENACE- RED DE ACCION ECOLOGICA', NULL, 1700, 180);
INSERT INTO unc_248557.voluntario_institucion VALUES ('Contracting', NULL, 1700, 190);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CONSEJO NACIONAL DE LA JUVENTUD', NULL, 1700, 200);
INSERT INTO unc_248557.voluntario_institucion VALUES ('DEFENSA DE LOS DERECHOC DEL NIÑO', NULL, 1700, 210);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION CHILDREN', NULL, 1700, 220);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CORPORACION ANGLICANA', NULL, 1700, 230);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CORPORACION EVANGELICA', NULL, 1700, 240);
INSERT INTO unc_248557.voluntario_institucion VALUES ('CENTRO ECUMENICO', NULL, 1700, 250);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION MARISTA PARA LA SOLIDARIDAD', NULL, 1700, 260);
INSERT INTO unc_248557.voluntario_institucion VALUES ('FUNDACION VIDA', NULL, 1700, 270);


--
-- Data for Name: pais; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_pais VALUES ('Italia', 1, 'IT');
INSERT INTO unc_248557.voluntario_pais VALUES ('Japon', 3, 'JP');
INSERT INTO unc_248557.voluntario_pais VALUES ('Estados Unidos', 2, 'US');
INSERT INTO unc_248557.voluntario_pais VALUES ('Canada', 2, 'CA');
INSERT INTO unc_248557.voluntario_pais VALUES ('China', 3, 'CN');
INSERT INTO unc_248557.voluntario_pais VALUES ('India', 3, 'IN');
INSERT INTO unc_248557.voluntario_pais VALUES ('Australia', 3, 'AU');
INSERT INTO unc_248557.voluntario_pais VALUES ('Zimbabwe', 4, 'ZW');
INSERT INTO unc_248557.voluntario_pais VALUES ('Singapor', 3, 'SG');
INSERT INTO unc_248557.voluntario_pais VALUES ('Reino Unido', 1, 'UK');
INSERT INTO unc_248557.voluntario_pais VALUES ('Francia', 1, 'FR');
INSERT INTO unc_248557.voluntario_pais VALUES ('Alemania', 1, 'DE');
INSERT INTO unc_248557.voluntario_pais VALUES ('Zambia', 4, 'ZM');
INSERT INTO unc_248557.voluntario_pais VALUES ('Egipto', 4, 'EG');
INSERT INTO unc_248557.voluntario_pais VALUES ('Brasil', 2, 'BR');
INSERT INTO unc_248557.voluntario_pais VALUES ('Suiza', 1, 'CH');
INSERT INTO unc_248557.voluntario_pais VALUES ('Holanda', 1, 'NL');
INSERT INTO unc_248557.voluntario_pais VALUES ('Mexico', 2, 'MX');
INSERT INTO unc_248557.voluntario_pais VALUES ('Kuwait', 4, 'KW');
INSERT INTO unc_248557.voluntario_pais VALUES ('Israel', 4, 'IL');
INSERT INTO unc_248557.voluntario_pais VALUES ('Dinamarca', 1, 'DK');
INSERT INTO unc_248557.voluntario_pais VALUES ('Hong Kong', 3, 'HK');
INSERT INTO unc_248557.voluntario_pais VALUES ('Nigeria', 4, 'NG');
INSERT INTO unc_248557.voluntario_pais VALUES ('Argentina', 2, 'AR');
INSERT INTO unc_248557.voluntario_pais VALUES ('Belgica', 1, 'BE');


--
-- Data for Name: tarea; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_tarea VALUES ('PROMOCION', 20000, 'AD_PRES', 40000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('PREVENCION', 15000, 'AD_VP', 30000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('AISTENCIA ANCIANOS', 3000, 'AD_ASST', 6000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('FORESTACION', 8200, 'FI_MGR', 16000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('PLANTACION', 4200, 'FI_ACCOUNT', 9000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ORG.CAMPAÑAS LIMPIEZA', 8200, 'AC_MGR', 16000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('FISCALIZACION DE RECURSOS NATURALES', 4200, 'AC_ACCOUNT', 9000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('CLASES ESPECIALES', 10000, 'SA_MAN', 20000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ORGANIZACION CAMPAMENTOS RECREATIVOS', 6000, 'SA_REP', 12000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ORGANIZACION DE COLECTAS', 8000, 'PU_MAN', 15000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('CLASIFICACION DE ALIMENTOS', 2500, 'PU_CLERK', 5500);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ATENCION DE COMEDORES', 5500, 'ST_MAN', 8500);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ATENCION DE ROPERITOS', 2000, 'ST_CLERK', 5000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('AYUDA DISCAPACITADOS', 2500, 'SH_CLERK', 5500);
INSERT INTO unc_248557.voluntario_tarea VALUES ('CONSTRUCTOR', 4000, 'IT_PROG', 10000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('ASISTENCIA A ENFERMOS', 9000, 'MK_MAN', 15000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('COCINERO', 4000, 'MK_REP', 9000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('MAESTRO ESPECIAL', 4000, 'HR_REP', 9000);
INSERT INTO unc_248557.voluntario_tarea VALUES ('RELACIONES INSTITUCIONALES', 4500, 'PR_REP', 10500);
INSERT INTO unc_248557.voluntario_tarea VALUES ('Nueva Tarea', 100, 'OT_NEW', 3000);


--
-- Data for Name: voluntario; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: unc_248557
--

INSERT INTO unc_248557.voluntario_voluntario VALUES ('Michael', 'Rogers', 'MRogers@OUTLOOK.COM', '+41 643 165 6647', '1998-08-26', 'ST_CLERK', 134, 2900.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Ki', 'Gee', 'KGee@HOTMAIL.COM', '+55 357 58 9144', '1999-12-12', 'ST_CLERK', 135, 2400.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Hazel', 'Philtanker', 'HPhiltanker@OUTLOOK.COM', '+43 431 515 9767', '2000-02-06', 'ST_CLERK', 136, 2200.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Renske', 'Ladwig', 'RLadwig@OUTLOOK.COM', '+17 82 716 4661', '1995-07-14', 'ST_CLERK', 137, 3600.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Stephen', 'Stiles', 'SStiles@GMAIL.COM', '+41 423 875 1325', '1997-10-26', 'ST_CLERK', 138, 3200.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('John', 'Seo', 'JSeo@GMAIL.COM', '+1 922 272 4307', '1998-02-12', 'ST_CLERK', 139, 2700.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Joshua', 'Patel', 'JPatel@HOTMAIL.COM', '+25 550 381 2350', '1998-04-06', 'ST_CLERK', 140, 2500.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Trenna', 'Rajs', 'TRajs@GMAIL.COM', '+38 827 260 2926', '1995-10-17', 'ST_CLERK', 141, 3500.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Curtis', 'Davies', 'CDavies@GMAIL.COM', '+29 424 957 3791', '1997-01-29', 'ST_CLERK', 142, 3100.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Randall', 'Matos', 'RMatos@HOTMAIL.COM', '+47 15 294 4948', '1998-03-15', 'ST_CLERK', 143, 2600.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Peter', 'Vargas', 'PVargas@OUTLOOK.COM', '+27 808 472 7168', '1998-07-09', 'ST_CLERK', 144, 2500.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('John', 'Russell', 'JRussell@OUTLOOK.COM', '+54 188 183 5634', '1996-10-01', 'SA_MAN', 145, 14000.00, 0.40, 80, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Karen', 'Partners', 'KPartners@GMAIL.COM', '+37 59 696 6276', '1997-01-05', 'SA_MAN', 146, 13500.00, 0.30, 80, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alberto', 'Errazuriz', 'AErrazuriz@HOTMAIL.COM', '+59 967 59 3949', '1997-03-10', 'SA_MAN', 147, 12000.00, 0.30, 80, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Gerald', 'Cambrault', 'GCambrault@OUTLOOK.COM', '+32 439 630 1375', '1999-10-15', 'SA_MAN', 148, 11000.00, 0.30, 80, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Eleni', 'Zlotkey', 'EZlotkey@GMAIL.COM', '+16 889 430 7376', '2000-01-29', 'SA_MAN', 149, 10500.00, 0.20, 80, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Peter', 'Tucker', 'PTucker@HOTMAIL.COM', '+19 387 117 950', '1997-01-30', 'SA_REP', 150, 10000.00, 0.30, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('David', 'Bernstein', 'DBernstein@OUTLOOK.COM', '+25 410 590 8482', '1997-03-24', 'SA_REP', 151, 9500.00, 0.25, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Peter', 'Hall', 'PHall@OUTLOOK.COM', '+14 62 565 1080', '1997-08-20', 'SA_REP', 152, 9000.00, 0.25, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Christopher', 'Olsen', 'COlsen@GMAIL.COM', '+15 748 671 8601', '1998-03-30', 'SA_REP', 153, 8000.00, 0.20, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Nanette', 'Cambrault', 'NCambrault@OUTLOOK.COM', '+49 367 488 7873', '1998-12-09', 'SA_REP', 154, 7500.00, 0.20, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Oliver', 'Tuvault', 'OTuvault@HOTMAIL.COM', '+21 546 183 8531', '1999-11-23', 'SA_REP', 155, 7000.00, 0.15, 80, 145);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Janette', 'King', 'JKing@OUTLOOK.COM', '+60 812 990 2513', '1996-01-30', 'SA_REP', 156, 10000.00, 0.35, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Patrick', 'Sully', 'PSully@GMAIL.COM', '+43 421 988 149', '1996-03-04', 'SA_REP', 157, 9500.00, 0.35, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Allan', 'McEwen', 'AMcEwen@GMAIL.COM', '+49 106 110 2102', '1996-08-01', 'SA_REP', 158, 9000.00, 0.35, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Lindsey', 'Smith', 'LSmith@OUTLOOK.COM', '+31 699 59 7345', '1997-03-10', 'SA_REP', 159, 8000.00, 0.30, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Louise', 'Doran', 'LDoran@OUTLOOK.COM', '+46 623 842 99', '1997-12-15', 'SA_REP', 160, 7500.00, 0.30, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Sarath', 'Sewall', 'SSewall@HOTMAIL.COM', '+23 514 870 1783', '1998-11-03', 'SA_REP', 161, 7000.00, 0.25, 80, 146);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Clara', 'Vishney', 'CVishney@GMAIL.COM', '+53 358 965 2166', '1997-11-11', 'SA_REP', 162, 10500.00, 0.25, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Danielle', 'Greene', 'DGreene@OUTLOOK.COM', '+55 148 70 8885', '1999-03-19', 'SA_REP', 163, 9500.00, 0.15, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Mattea', 'Marvins', 'MMarvins@HOTMAIL.COM', '+58 61 140 6611', '2000-01-24', 'SA_REP', 164, 7200.00, 0.10, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('David', 'Lee', 'DLee@GMAIL.COM', '+29 129 676 2889', '2000-02-23', 'SA_REP', 165, 6800.00, 0.10, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Sundar', 'Ande', 'SAnde@GMAIL.COM', '+15 785 499 7503', '2000-03-24', 'SA_REP', 166, 6400.00, 0.10, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Amit', 'Banda', 'ABanda@GMAIL.COM', '+30 557 485 2459', '2000-04-21', 'SA_REP', 167, 6200.00, 0.10, 80, 147);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Lisa', 'Ozer', 'LOzer@OUTLOOK.COM', '+11 328 256 5525', '1997-03-11', 'SA_REP', 168, 11500.00, 0.25, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Harrison', 'Bloom', 'HBloom@GMAIL.COM', '+51 126 731 7227', '1998-03-23', 'SA_REP', 169, 10000.00, 0.20, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Tayler', 'Fox', 'TFox@HOTMAIL.COM', '+30 696 939 3872', '1998-01-24', 'SA_REP', 170, 9600.00, 0.20, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('William', 'Smith', 'WSmith@GMAIL.COM', '+51 9 276 8038', '1999-02-23', 'SA_REP', 171, 7400.00, 0.15, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Elizabeth', 'Bates', 'EBates@GMAIL.COM', '+5 416 465 5503', '1999-03-24', 'SA_REP', 172, 7300.00, 0.15, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Sundita', 'Kumar', 'SKumar@HOTMAIL.COM', '+33 141 839 7785', '2000-04-21', 'SA_REP', 173, 6100.00, 0.10, 80, 148);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Ellen', 'Abel', 'EAbel@OUTLOOK.COM', '+56 338 529 4116', '1996-05-11', 'SA_REP', 174, 11000.00, 0.30, 80, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alyssa', 'Hutton', 'AHutton@GMAIL.COM', '+54 14 657 766', '1997-03-19', 'SA_REP', 175, 8800.00, 0.25, 80, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jonathon', 'Taylor', 'JTaylor@HOTMAIL.COM', '+21 913 629 1825', '1998-03-24', 'SA_REP', 176, 8600.00, 0.20, 80, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jack', 'Livingston', 'JLivingston@OUTLOOK.COM', '+3 360 905 5221', '1998-04-23', 'SA_REP', 177, 8400.00, 0.20, 80, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Kimberely', 'Grant', 'KGrant@OUTLOOK.COM', '+4 844 909 9003', '1999-05-24', 'SA_REP', 178, 7000.00, 0.15, NULL, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Charles', 'Johnson', 'CJohnson@GMAIL.COM', '+52 185 704 9227', '2000-01-04', 'SA_REP', 179, 6200.00, 0.10, 80, 149);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Winston', 'Taylor', 'WTaylor@GMAIL.COM', '+37 170 473 1447', '1998-01-24', 'SH_CLERK', 180, 3200.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jean', 'Fleaur', 'JFleaur@GMAIL.COM', '+19 312 923 2365', '1998-02-23', 'SH_CLERK', 181, 3100.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Martha', 'Sullivan', 'MSullivan@GMAIL.COM', '+40 452 648 5461', '1999-06-21', 'SH_CLERK', 182, 2500.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Girard', 'Geoni', 'GGeoni@OUTLOOK.COM', '+28 306 623 8066', '2000-02-03', 'SH_CLERK', 183, 2800.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Nandita', 'Sarchand', 'NSarchand@HOTMAIL.COM', '+14 252 989 2573', '1996-01-27', 'SH_CLERK', 184, 4200.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alexis', 'Bull', 'ABull@OUTLOOK.COM', '+37 894 779 6680', '1997-02-20', 'SH_CLERK', 185, 4100.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Julia', 'Dellinger', 'JDellinger@GMAIL.COM', '+45 689 568 5920', '1998-06-24', 'SH_CLERK', 186, 3400.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Anthony', 'Cabrio', 'ACabrio@GMAIL.COM', '+53 273 515 4741', '1999-02-07', 'SH_CLERK', 187, 3000.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Kelly', 'Chung', 'KChung@OUTLOOK.COM', '+27 987 619 7518', '1997-06-14', 'SH_CLERK', 188, 3800.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Steven', 'King', 'SKing@HOTMAIL.COM', '+6 504 595 1964', '1987-06-17', 'AD_PRES', 100, 24000.00, NULL, 90, NULL);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Neena', 'Kochhar', 'NKochhar@GMAIL.COM', '+36 821 666 7623', '1989-09-21', 'AD_VP', 101, 17000.00, NULL, 90, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Lex', 'De Haan', 'LDe Haan@OUTLOOK.COM', '+42 553 468 9181', '1993-01-13', 'AD_VP', 102, 17000.00, NULL, 90, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alexander', 'Hunold', 'AHunold@OUTLOOK.COM', '+58 489 69 4169', '1990-01-03', 'IT_PROG', 103, 9000.00, NULL, 60, 102);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Bruce', 'Ernst', 'BErnst@GMAIL.COM', '+38 55 437 3033', '1991-05-21', 'IT_PROG', 104, 6000.00, NULL, 60, 103);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('David', 'Austin', 'DAustin@HOTMAIL.COM', '+60 566 179 6327', '1997-06-25', 'IT_PROG', 105, 4800.00, NULL, 60, 103);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Valli', 'Pataballa', 'VPataballa@GMAIL.COM', '+55 521 825 4031', '1998-02-05', 'IT_PROG', 106, 4800.00, NULL, 60, 103);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Diana', 'Lorentz', 'DLorentz@GMAIL.COM', '+42 923 969 7797', '1999-02-07', 'IT_PROG', 107, 4200.00, NULL, 60, 103);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Nancy', 'Greenberg', 'NGreenberg@OUTLOOK.COM', '+26 564 976 170', '1994-08-17', 'FI_MGR', 108, 12000.00, NULL, 100, 101);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Daniel', 'Faviet', 'DFaviet@HOTMAIL.COM', '+24 642 779 744', '1994-08-16', 'FI_ACCOUNT', 109, 9000.00, NULL, 100, 108);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('John', 'Chen', 'JChen@GMAIL.COM', '+12 248 992 1593', '1997-09-28', 'FI_ACCOUNT', 110, 8200.00, NULL, 100, 108);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Ismael', 'Sciarra', 'ISciarra@GMAIL.COM', '+45 61 576 3699', '1997-09-30', 'FI_ACCOUNT', 111, 7700.00, NULL, 100, 108);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jose Manuel', 'Urman', 'JUrman@OUTLOOK.COM', '+7 14 673 1112', '1998-03-07', 'FI_ACCOUNT', 112, 7800.00, NULL, 100, 108);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Luis', 'Popp', 'LPopp@GMAIL.COM', '+35 852 744 4861', '1999-12-07', 'FI_ACCOUNT', 113, 6900.00, NULL, 100, 108);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Den', 'Raphaely', 'DRaphaely@GMAIL.COM', '+23 569 889 598', '1994-12-07', 'PU_MAN', 114, 11000.00, NULL, 30, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alexander', 'Khoo', 'AKhoo@HOTMAIL.COM', '+30 858 839 9182', '1995-05-18', 'PU_CLERK', 115, 3100.00, NULL, 30, 114);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Shelli', 'Baida', 'SBaida@GMAIL.COM', '+26 815 935 8085', '1997-12-24', 'PU_CLERK', 116, 2900.00, NULL, 30, 114);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Sigal', 'Tobias', 'STobias@HOTMAIL.COM', '+28 714 882 6528', '1997-07-24', 'PU_CLERK', 117, 2800.00, NULL, 30, 114);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Guy', 'Himuro', 'GHimuro@OUTLOOK.COM', '+58 875 812 6986', '1998-11-15', 'PU_CLERK', 118, 2600.00, NULL, 30, 114);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Karen', 'Colmenares', 'KColmenares@OUTLOOK.COM', '+57 388 69 524', '1999-08-10', 'PU_CLERK', 119, 2500.00, NULL, 30, 114);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Matthew', 'Weiss', 'MWeiss@GMAIL.COM', '+25 742 164 9803', '1996-07-18', 'ST_MAN', 120, 8000.00, NULL, 50, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Adam', 'Fripp', 'AFripp@GMAIL.COM', '+36 907 466 9664', '1997-04-10', 'ST_MAN', 121, 8200.00, NULL, 50, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Payam', 'Kaufling', 'PKaufling@OUTLOOK.COM', '+29 356 27 9677', '1995-05-01', 'ST_MAN', 122, 7900.00, NULL, 50, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Shanta', 'Vollman', 'SVollman@HOTMAIL.COM', '+13 865 886 6371', '1997-10-10', 'ST_MAN', 123, 6500.00, NULL, 50, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Kevin', 'Mourgos', 'KMourgos@GMAIL.COM', '+41 821 446 1386', '1999-11-16', 'ST_MAN', 124, 5800.00, NULL, 50, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Julia', 'Nayer', 'JNayer@OUTLOOK.COM', '+33 329 791 4975', '1997-07-16', 'ST_CLERK', 125, 3200.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Irene', 'Mikkilineni', 'IMikkilineni@GMAIL.COM', '+13 603 196 1402', '1998-09-28', 'ST_CLERK', 126, 2700.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('James', 'Landry', 'JLandry@GMAIL.COM', '+60 265 193 3930', '1999-01-14', 'ST_CLERK', 127, 2400.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Steven', 'Markle', 'SMarkle@GMAIL.COM', '+1 356 373 6001', '2000-03-08', 'ST_CLERK', 128, 2200.00, NULL, 50, 120);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Laura', 'Bissot', 'LBissot@HOTMAIL.COM', '+16 839 567 7394', '1997-08-20', 'ST_CLERK', 129, 3300.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jennifer', 'Dilly', 'JDilly@GMAIL.COM', '+18 542 988 9504', '1997-08-13', 'SH_CLERK', 189, 3600.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Timothy', 'Gates', 'TGates@HOTMAIL.COM', '+60 636 496 4596', '1998-07-11', 'SH_CLERK', 190, 2900.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Randall', 'Perkins', 'RPerkins@HOTMAIL.COM', '+57 120 266 1605', '1999-12-19', 'SH_CLERK', 191, 2500.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Sarah', 'Bell', 'SBell@OUTLOOK.COM', '+23 256 418 9826', '1996-02-04', 'SH_CLERK', 192, 4000.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Britney', 'Everett', 'BEverett@HOTMAIL.COM', '+9 198 650 8881', '1997-03-03', 'SH_CLERK', 193, 3900.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Samuel', 'McCain', 'SMcCain@OUTLOOK.COM', '+54 219 480 7596', '1998-07-01', 'SH_CLERK', 194, 3200.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Vance', 'Jones', 'VJones@HOTMAIL.COM', '+30 994 234 9333', '1999-03-17', 'SH_CLERK', 195, 2800.00, NULL, 50, 123);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Alana', 'Walsh', 'AWalsh@HOTMAIL.COM', '+59 852 685 2826', '1998-04-24', 'SH_CLERK', 196, 3100.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Kevin', 'Feeney', 'KFeeney@OUTLOOK.COM', '+24 673 233 3885', '1998-05-23', 'SH_CLERK', 197, 3000.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Donald', 'OConnell', 'DOConnell@HOTMAIL.COM', '+19 729 848 2518', '1999-06-21', 'SH_CLERK', 198, 2600.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Douglas', 'Grant', 'DGrant@GMAIL.COM', '+51 115 412 2195', '2000-01-13', 'SH_CLERK', 199, 2600.00, NULL, 50, 124);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jennifer', 'Whalen', 'JWhalen@GMAIL.COM', '+23 830 202 5190', '1987-09-17', 'AD_ASST', 200, 4400.00, NULL, 10, 101);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Mozhe', 'Atkinson', 'MAtkinson@GMAIL.COM', '+12 593 707 4095', '1997-10-30', 'ST_CLERK', 130, 2800.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('James', 'Marlow', 'JMarlow@HOTMAIL.COM', '+28 593 47 1396', '1997-02-16', 'ST_CLERK', 131, 2500.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('TJ', 'Olson', 'TOlson@OUTLOOK.COM', '+25 492 278 9498', '1999-04-10', 'ST_CLERK', 132, 2100.00, NULL, 50, 121);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Jason', 'Mallin', 'JMallin@GMAIL.COM', '+50 70 447 246', '1996-06-14', 'ST_CLERK', 133, 3300.00, NULL, 50, 122);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Michael', 'Hartstein', 'MHartstein@HOTMAIL.COM', '+2 852 407 9132', '1996-02-17', 'MK_MAN', 201, 13000.00, NULL, 20, 100);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Pat', 'Fay', 'PFay@GMAIL.COM', '+5 887 673 5634', '1997-08-17', 'MK_REP', 202, 6000.00, NULL, 20, 201);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Susan', 'Mavris', 'SMavris@GMAIL.COM', '+53 906 497 8648', '1994-06-07', 'HR_REP', 203, 6500.00, NULL, 40, 101);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Hermann', 'Baer', 'HBaer@OUTLOOK.COM', '+46 182 148 1538', '1994-06-07', 'PR_REP', 204, 10000.00, NULL, 70, 101);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('Shelley', 'Higgins', 'SHiggins@OUTLOOK.COM', '+52 381 542 1654', '1994-06-07', 'AC_MGR', 205, 12000.00, NULL, 110, 101);
INSERT INTO unc_248557.voluntario_voluntario VALUES ('William', 'Gietz', 'WGietz@GMAIL.COM', '+7 390 417 9585', '1994-06-07', 'AC_ACCOUNT', 206, 8300.00, NULL, 110, 205);


--
-- Name: continente pk_continente; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_continente
    ADD CONSTRAINT voluntario_pk_continente PRIMARY KEY (id_continente);


--
-- Name: direccion pk_direccion; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_direccion
    ADD CONSTRAINT voluntario_pk_direccion PRIMARY KEY (id_direccion);


--
-- Name: historico pk_historico; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_historico
    ADD CONSTRAINT voluntario_pk_historico PRIMARY KEY (fecha_inicio, nro_voluntario);


--
-- Name: institucion pk_institucion; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_institucion
    ADD CONSTRAINT voluntario_pk_institucion PRIMARY KEY (id_institucion);


--
-- Name: pais pk_pais; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_pais
    ADD CONSTRAINT voluntario_pk_pais PRIMARY KEY (id_pais);


--
-- Name: tarea pk_tarea; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_tarea
    ADD CONSTRAINT voluntario_pk_tarea PRIMARY KEY (id_tarea);


--
-- Name: voluntario pk_voluntario; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_voluntario
    ADD CONSTRAINT voluntario_pk_voluntario PRIMARY KEY (nro_voluntario);


--
-- Name: emp_email_uk; Type: INDEX; Schema: unc_esq_voluntario; Owner: unc_248557
--

CREATE UNIQUE INDEX emp_email_uk ON unc_248557.voluntario_voluntario USING btree (e_mail);


--
-- Name: pais fk_continente; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_pais
    ADD CONSTRAINT voluntario_fk_continente FOREIGN KEY (id_continente) REFERENCES unc_248557.voluntario_continente(id_continente);


--
-- Name: voluntario fk_coordinador; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_voluntario
    ADD CONSTRAINT voluntario_fk_coordinador FOREIGN KEY (id_coordinador) REFERENCES unc_248557.voluntario_voluntario(nro_voluntario);


--
-- Name: institucion fk_direccion; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_institucion
    ADD CONSTRAINT voluntario_fk_direccion FOREIGN KEY (id_direccion) REFERENCES unc_248557.voluntario_direccion(id_direccion);


--
-- Name: institucion fk_director; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_institucion
    ADD CONSTRAINT voluntario_fk_director FOREIGN KEY (id_director) REFERENCES unc_248557.voluntario_voluntario(nro_voluntario);


--
-- Name: historico fk_institucion_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_historico
    ADD CONSTRAINT voluntario_fk_institucion_h FOREIGN KEY (id_institucion) REFERENCES unc_248557.voluntario_institucion(id_institucion);


--
-- Name: voluntario fk_institucion_v; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_voluntario
    ADD CONSTRAINT voluntario_fk_institucion_v FOREIGN KEY (id_institucion) REFERENCES unc_248557.voluntario_institucion(id_institucion);


--
-- Name: direccion fk_pais; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_direccion
    ADD CONSTRAINT voluntario_fk_pais FOREIGN KEY (id_pais) REFERENCES unc_248557.voluntario_pais(id_pais);


--
-- Name: historico fk_tarea_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_historico
    ADD CONSTRAINT voluntario_fk_tarea_h FOREIGN KEY (id_tarea) REFERENCES unc_248557.voluntario_tarea(id_tarea);


--
-- Name: voluntario fk_tarea_v; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_voluntario
    ADD CONSTRAINT voluntario_fk_tarea_v FOREIGN KEY (id_tarea) REFERENCES unc_248557.voluntario_tarea(id_tarea);


--
-- Name: historico fk_voluntario_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.voluntario_historico
    ADD CONSTRAINT voluntario_fk_voluntario_h FOREIGN KEY (nro_voluntario) REFERENCES unc_248557.voluntario_voluntario(nro_voluntario);


--
-- Name: SCHEMA unc_esq_voluntario; Type: ACL; Schema: -; Owner: unc_248557
--

GRANT USAGE ON SCHEMA unc_esq_voluntario TO PUBLIC;


--
-- Name: TABLE voluntario; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_voluntario TO PUBLIC;


--
-- Name: TABLE tarea; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_tarea TO PUBLIC;


--
-- Name: TABLE continente; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_continente TO PUBLIC;


--
-- Name: TABLE direccion; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_direccion TO PUBLIC;


--
-- Name: TABLE historico; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_historico TO PUBLIC;


--
-- Name: TABLE institucion; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_institucion TO PUBLIC;


--
-- Name: TABLE pais; Type: ACL; Schema: unc_esq_voluntario; Owner: unc_248557
--

GRANT SELECT,REFERENCES ON TABLE unc_248557.voluntario_pais TO PUBLIC;


--
-- unc_248557QL database dump complete
--

