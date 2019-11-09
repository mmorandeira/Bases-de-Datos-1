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
-- -- Name: unc_esq_wireless; Type: SCHEMA; Schema: -; Owner: unc_248557
-- --

-- CREATE SCHEMA unc_esq_wireless;


-- ALTER SCHEMA unc_esq_wireless OWNER TO unc_248557;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: equipo; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_equipo (
    id_equipo integer NOT NULL,
    nombre character varying(80) NOT NULL,
    mac character varying(20),
    ip character varying(20),
    ap character varying(20),
    id_servicio integer NOT NULL,
    id_cliente integer NOT NULL,
    fecha_alta timestamp without time zone,
    fecha_baja timestamp without time zone
);


ALTER TABLE unc_248557.wireless_equipo OWNER TO unc_248557;

--
-- Name: barrio; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_barrio (
    id_barrio integer NOT NULL,
    nombre character varying(20) NOT NULL,
    id_ciudad integer NOT NULL
);


ALTER TABLE unc_248557.wireless_barrio OWNER TO unc_248557;

--
-- Name: categoria; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_categoria (
    id_cat integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE unc_248557.wireless_categoria OWNER TO unc_248557;

--
-- Name: ciudad; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_ciudad (
    id_ciudad integer NOT NULL,
    nombre character varying(80) NOT NULL
);


ALTER TABLE unc_248557.wireless_ciudad OWNER TO unc_248557;

--
-- Name: cliente; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_cliente (
    id_cliente integer NOT NULL,
    saldo numeric(18,3)
);


ALTER TABLE unc_248557.wireless_cliente OWNER TO unc_248557;

--
-- Name: comprobante; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_comprobante (
    id_comp bigint NOT NULL,
    id_tcomp integer NOT NULL,
    fecha timestamp without time zone,
    id_lugar integer NOT NULL,
    comentario character varying(2048) NOT NULL,
    estado character varying(20),
    fecha_vencimiento timestamp without time zone,
    id_turno integer,
    importe numeric(18,5) NOT NULL,
    id_cliente integer NOT NULL
);


ALTER TABLE unc_248557.wireless_comprobante OWNER TO unc_248557;

--
-- Name: direccion; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_direccion (
    id_direccion integer NOT NULL,
    id_persona integer NOT NULL,
    calle character varying(50) NOT NULL,
    numero integer NOT NULL,
    piso integer,
    depto character varying(50),
    id_barrio integer NOT NULL
);


ALTER TABLE unc_248557.wireless_direccion OWNER TO unc_248557;

--
-- Name: lineacomprobante; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_lineacomprobante (
    nro_linea integer NOT NULL,
    id_comp bigint NOT NULL,
    id_tcomp integer NOT NULL,
    descripcion character varying(80) NOT NULL,
    cantidad integer NOT NULL,
    importe numeric(18,5) NOT NULL,
    id_servicio integer
);


ALTER TABLE unc_248557.wireless_lineacomprobante OWNER TO unc_248557;

--
-- Name: lugar; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_lugar (
    id_lugar integer NOT NULL,
    nombre character varying(80)
);


ALTER TABLE unc_248557.wireless_lugar OWNER TO unc_248557;

--
-- Name: mail; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_mail (
    id_persona integer NOT NULL,
    mail character varying(120) NOT NULL,
    tipo character varying(20) NOT NULL
);


ALTER TABLE unc_248557.wireless_mail OWNER TO unc_248557;

--
-- Name: persona; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_persona (
    id_persona integer NOT NULL,
    tipo character varying(10) NOT NULL,
    tipodoc character varying(10) NOT NULL,
    nrodoc character varying(10) NOT NULL,
    nombre character varying(40) NOT NULL,
    apellido character varying(40) NOT NULL,
    fecha_nacimiento timestamp without time zone NOT NULL,
    fecha_baja timestamp without time zone,
    cuit character varying(20),
    activo boolean NOT NULL
);


ALTER TABLE unc_248557.wireless_persona OWNER TO unc_248557;

--
-- Name: personal; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_personal (
    id_personal integer NOT NULL,
    id_rol integer NOT NULL
);


ALTER TABLE unc_248557.wireless_personal OWNER TO unc_248557;

--
-- Name: rol; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_rol (
    id_rol integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE unc_248557.wireless_rol OWNER TO unc_248557;

--
-- Name: servicio; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_servicio (
    id_servicio integer NOT NULL,
    nombre character varying(80) NOT NULL,
    periodico boolean NOT NULL,
    costo numeric(18,3) NOT NULL,
    intervalo integer,
    tipo_intervalo character varying(20),
    activo boolean DEFAULT true NOT NULL,
    id_cat integer NOT NULL,
    CONSTRAINT wireless_check_0 CHECK (((tipo_intervalo)::text = ANY (ARRAY[('semana'::character varying)::text, ('quincena'::character varying)::text, ('mes'::character varying)::text, ('bimestre'::character varying)::text])))
);


ALTER TABLE unc_248557.wireless_servicio OWNER TO unc_248557;

--
-- Name: telefono; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_telefono (
    id_persona integer NOT NULL,
    carac integer NOT NULL,
    numero integer NOT NULL
);


ALTER TABLE unc_248557.wireless_telefono OWNER TO unc_248557;

--
-- Name: tipocomprobante; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_tipocomprobante (
    id_tcomp integer NOT NULL,
    nombre character varying(30) NOT NULL,
    tipo character varying(80) NOT NULL
);


ALTER TABLE unc_248557.wireless_tipocomprobante OWNER TO unc_248557;

--
-- Name: turno; Type: TABLE; Schema: unc_esq_wireless; Owner: unc_248557
--

CREATE TABLE unc_248557.wireless_turno (
    id_turno integer NOT NULL,
    id_lugar integer NOT NULL,
    desde timestamp without time zone NOT NULL,
    hasta timestamp without time zone,
    dinero_inicio numeric(18,3) NOT NULL,
    dinero_fin numeric(18,3),
    id_personal integer NOT NULL
);


ALTER TABLE unc_248557.wireless_turno OWNER TO unc_248557;

--
-- Data for Name: barrio; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_barrio VALUES (1, 'Wien', 82);
INSERT INTO unc_248557.wireless_barrio VALUES (2, 'Ulster', 44);
INSERT INTO unc_248557.wireless_barrio VALUES (3, 'Wien', 95);
INSERT INTO unc_248557.wireless_barrio VALUES (4, 'Namen', 81);
INSERT INTO unc_248557.wireless_barrio VALUES (5, 'Berlin', 61);
INSERT INTO unc_248557.wireless_barrio VALUES (6, 'Imo', 23);
INSERT INTO unc_248557.wireless_barrio VALUES (7, 'AN', 65);
INSERT INTO unc_248557.wireless_barrio VALUES (8, 'West-Vlaande', 77);
INSERT INTO unc_248557.wireless_barrio VALUES (9, 'Cartago', 79);
INSERT INTO unc_248557.wireless_barrio VALUES (10, 'Washington', 79);
INSERT INTO unc_248557.wireless_barrio VALUES (11, 'Vermont', 89);
INSERT INTO unc_248557.wireless_barrio VALUES (12, 'PA', 76);
INSERT INTO unc_248557.wireless_barrio VALUES (13, 'KN', 89);
INSERT INTO unc_248557.wireless_barrio VALUES (14, 'Zuid Holland', 75);
INSERT INTO unc_248557.wireless_barrio VALUES (15, 'RM', 54);
INSERT INTO unc_248557.wireless_barrio VALUES (16, 'Castilla', 4);
INSERT INTO unc_248557.wireless_barrio VALUES (17, 'Asturias', 67);
INSERT INTO unc_248557.wireless_barrio VALUES (18, 'Gujarat', 44);
INSERT INTO unc_248557.wireless_barrio VALUES (19, 'Campania', 19);
INSERT INTO unc_248557.wireless_barrio VALUES (20, 'San José', 37);
INSERT INTO unc_248557.wireless_barrio VALUES (21, 'Sląskie', 53);
INSERT INTO unc_248557.wireless_barrio VALUES (22, 'M', 87);
INSERT INTO unc_248557.wireless_barrio VALUES (23, 'Minnesota', 72);
INSERT INTO unc_248557.wireless_barrio VALUES (24, 'Coquimbo', 76);
INSERT INTO unc_248557.wireless_barrio VALUES (25, 'QC', 39);
INSERT INTO unc_248557.wireless_barrio VALUES (26, 'Biobío', 55);
INSERT INTO unc_248557.wireless_barrio VALUES (27, 'Nordrhein', 68);
INSERT INTO unc_248557.wireless_barrio VALUES (28, 'Araucanía', 34);
INSERT INTO unc_248557.wireless_barrio VALUES (29, 'NSW', 46);
INSERT INTO unc_248557.wireless_barrio VALUES (30, 'Stockholms', 31);
INSERT INTO unc_248557.wireless_barrio VALUES (31, 'KS', 27);
INSERT INTO unc_248557.wireless_barrio VALUES (32, 'DE', 76);
INSERT INTO unc_248557.wireless_barrio VALUES (33, 'Baden', 7);
INSERT INTO unc_248557.wireless_barrio VALUES (34, 'AN', 60);
INSERT INTO unc_248557.wireless_barrio VALUES (35, 'Ogun', 54);
INSERT INTO unc_248557.wireless_barrio VALUES (36, 'DO', 28);
INSERT INTO unc_248557.wireless_barrio VALUES (37, 'North Island', 17);
INSERT INTO unc_248557.wireless_barrio VALUES (38, 'Hamburg', 83);
INSERT INTO unc_248557.wireless_barrio VALUES (39, 'CV', 90);
INSERT INTO unc_248557.wireless_barrio VALUES (40, 'Friesland', 35);
INSERT INTO unc_248557.wireless_barrio VALUES (41, 'Victoria', 15);
INSERT INTO unc_248557.wireless_barrio VALUES (42, 'Berlin', 64);
INSERT INTO unc_248557.wireless_barrio VALUES (43, 'SP', 36);
INSERT INTO unc_248557.wireless_barrio VALUES (44, 'NSW', 98);
INSERT INTO unc_248557.wireless_barrio VALUES (45, 'Maharastra', 61);
INSERT INTO unc_248557.wireless_barrio VALUES (46, 'ME', 6);
INSERT INTO unc_248557.wireless_barrio VALUES (47, 'LA', 90);
INSERT INTO unc_248557.wireless_barrio VALUES (48, 'LE', 2);
INSERT INTO unc_248557.wireless_barrio VALUES (49, 'Ankara', 16);
INSERT INTO unc_248557.wireless_barrio VALUES (50, 'Quebec', 3);
INSERT INTO unc_248557.wireless_barrio VALUES (51, 'Ulster', 26);
INSERT INTO unc_248557.wireless_barrio VALUES (52, 'São Paulo', 3);
INSERT INTO unc_248557.wireless_barrio VALUES (53, 'Wien', 88);
INSERT INTO unc_248557.wireless_barrio VALUES (54, 'DB', 31);
INSERT INTO unc_248557.wireless_barrio VALUES (55, 'KE', 77);
INSERT INTO unc_248557.wireless_barrio VALUES (56, 'IL', 70);
INSERT INTO unc_248557.wireless_barrio VALUES (57, 'C', 27);
INSERT INTO unc_248557.wireless_barrio VALUES (58, 'Centre', 92);
INSERT INTO unc_248557.wireless_barrio VALUES (59, 'Pernambuco', 74);
INSERT INTO unc_248557.wireless_barrio VALUES (60, 'DS', 97);
INSERT INTO unc_248557.wireless_barrio VALUES (61, 'CH', 59);
INSERT INTO unc_248557.wireless_barrio VALUES (62, 'North Island', 23);
INSERT INTO unc_248557.wireless_barrio VALUES (63, 'South Island', 33);
INSERT INTO unc_248557.wireless_barrio VALUES (64, 'California', 45);
INSERT INTO unc_248557.wireless_barrio VALUES (65, 'Konya', 47);
INSERT INTO unc_248557.wireless_barrio VALUES (66, 'Mersin', 47);
INSERT INTO unc_248557.wireless_barrio VALUES (67, 'Connacht', 11);
INSERT INTO unc_248557.wireless_barrio VALUES (68, 'ME', 91);
INSERT INTO unc_248557.wireless_barrio VALUES (69, 'WM', 10);
INSERT INTO unc_248557.wireless_barrio VALUES (70, 'Extremadura', 93);
INSERT INTO unc_248557.wireless_barrio VALUES (71, 'Swiętokrzyskie', 31);
INSERT INTO unc_248557.wireless_barrio VALUES (72, 'BW', 50);
INSERT INTO unc_248557.wireless_barrio VALUES (73, 'SL', 45);
INSERT INTO unc_248557.wireless_barrio VALUES (74, 'New South Wales', 75);
INSERT INTO unc_248557.wireless_barrio VALUES (75, 'Gelderland', 84);
INSERT INTO unc_248557.wireless_barrio VALUES (76, 'Lancashire', 34);
INSERT INTO unc_248557.wireless_barrio VALUES (77, 'Limburg', 41);
INSERT INTO unc_248557.wireless_barrio VALUES (78, 'Stockholms', 68);
INSERT INTO unc_248557.wireless_barrio VALUES (79, 'Istanbul', 60);
INSERT INTO unc_248557.wireless_barrio VALUES (80, 'Tamil Nadu', 9);
INSERT INTO unc_248557.wireless_barrio VALUES (81, 'N.', 3);
INSERT INTO unc_248557.wireless_barrio VALUES (82, 'ON', 38);
INSERT INTO unc_248557.wireless_barrio VALUES (83, 'LB', 49);
INSERT INTO unc_248557.wireless_barrio VALUES (84, 'X', 72);
INSERT INTO unc_248557.wireless_barrio VALUES (85, 'HR', 93);
INSERT INTO unc_248557.wireless_barrio VALUES (86, 'SJ', 59);
INSERT INTO unc_248557.wireless_barrio VALUES (87, 'L', 5);
INSERT INTO unc_248557.wireless_barrio VALUES (88, 'IM', 86);
INSERT INTO unc_248557.wireless_barrio VALUES (89, 'M', 1);
INSERT INTO unc_248557.wireless_barrio VALUES (90, 'NI', 97);
INSERT INTO unc_248557.wireless_barrio VALUES (91, 'HA', 34);
INSERT INTO unc_248557.wireless_barrio VALUES (92, 'QC', 80);
INSERT INTO unc_248557.wireless_barrio VALUES (93, 'Île-de-France', 26);
INSERT INTO unc_248557.wireless_barrio VALUES (94, 'HA', 92);
INSERT INTO unc_248557.wireless_barrio VALUES (95, 'Connacht', 19);
INSERT INTO unc_248557.wireless_barrio VALUES (96, 'KN', 27);
INSERT INTO unc_248557.wireless_barrio VALUES (97, 'RI', 85);
INSERT INTO unc_248557.wireless_barrio VALUES (98, 'LOM', 55);
INSERT INTO unc_248557.wireless_barrio VALUES (99, 'HH', 77);
INSERT INTO unc_248557.wireless_barrio VALUES (100, 'Jonkopings', 84);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_categoria VALUES (1, 'massa');
INSERT INTO unc_248557.wireless_categoria VALUES (2, 'lobortis');
INSERT INTO unc_248557.wireless_categoria VALUES (3, 'volutpat');
INSERT INTO unc_248557.wireless_categoria VALUES (4, 'mi');
INSERT INTO unc_248557.wireless_categoria VALUES (5, 'et');


--
-- Data for Name: ciudad; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_ciudad VALUES (1, 'Fort Providence');
INSERT INTO unc_248557.wireless_ciudad VALUES (2, 'Oberursel');
INSERT INTO unc_248557.wireless_ciudad VALUES (3, 'Limbach-Oberfrohna');
INSERT INTO unc_248557.wireless_ciudad VALUES (4, 'San Pedro de Atacama');
INSERT INTO unc_248557.wireless_ciudad VALUES (5, 'Bowling Green');
INSERT INTO unc_248557.wireless_ciudad VALUES (6, 'Falun');
INSERT INTO unc_248557.wireless_ciudad VALUES (7, 'Ninhue');
INSERT INTO unc_248557.wireless_ciudad VALUES (8, 'Sommethonne');
INSERT INTO unc_248557.wireless_ciudad VALUES (9, 'Fairbanks');
INSERT INTO unc_248557.wireless_ciudad VALUES (10, 'Olmen');
INSERT INTO unc_248557.wireless_ciudad VALUES (11, 'Malbaie');
INSERT INTO unc_248557.wireless_ciudad VALUES (12, 'Miramichi');
INSERT INTO unc_248557.wireless_ciudad VALUES (13, 'San Francisco');
INSERT INTO unc_248557.wireless_ciudad VALUES (14, 'Aalen');
INSERT INTO unc_248557.wireless_ciudad VALUES (15, 'Sunderland');
INSERT INTO unc_248557.wireless_ciudad VALUES (16, 'Leffinge');
INSERT INTO unc_248557.wireless_ciudad VALUES (17, 'Bottrop');
INSERT INTO unc_248557.wireless_ciudad VALUES (18, 'Saint-Denis');
INSERT INTO unc_248557.wireless_ciudad VALUES (19, 'Pietrasanta');
INSERT INTO unc_248557.wireless_ciudad VALUES (20, 'Machynlleth');
INSERT INTO unc_248557.wireless_ciudad VALUES (21, 'Orléans');
INSERT INTO unc_248557.wireless_ciudad VALUES (22, 'Birmingham');
INSERT INTO unc_248557.wireless_ciudad VALUES (23, 'Sint-Denijs');
INSERT INTO unc_248557.wireless_ciudad VALUES (24, 'Chandler');
INSERT INTO unc_248557.wireless_ciudad VALUES (25, 'Şereflikoçhisar');
INSERT INTO unc_248557.wireless_ciudad VALUES (26, 'Thorembais-Saint-Trond');
INSERT INTO unc_248557.wireless_ciudad VALUES (27, 'Subiaco');
INSERT INTO unc_248557.wireless_ciudad VALUES (28, 'Saskatoon');
INSERT INTO unc_248557.wireless_ciudad VALUES (29, 'Panchià');
INSERT INTO unc_248557.wireless_ciudad VALUES (30, 'Carleton');
INSERT INTO unc_248557.wireless_ciudad VALUES (31, 'Falmouth');
INSERT INTO unc_248557.wireless_ciudad VALUES (32, 'Diyarbakır');
INSERT INTO unc_248557.wireless_ciudad VALUES (33, 'Knoxville');
INSERT INTO unc_248557.wireless_ciudad VALUES (34, 'Mont-Sainte-Genevive');
INSERT INTO unc_248557.wireless_ciudad VALUES (35, 'Berlare');
INSERT INTO unc_248557.wireless_ciudad VALUES (36, 'Maubeuge');
INSERT INTO unc_248557.wireless_ciudad VALUES (37, 'Marzabotto');
INSERT INTO unc_248557.wireless_ciudad VALUES (38, 'Bulzi');
INSERT INTO unc_248557.wireless_ciudad VALUES (39, 'Bruck an der Mur');
INSERT INTO unc_248557.wireless_ciudad VALUES (40, 'Oldenburg');
INSERT INTO unc_248557.wireless_ciudad VALUES (41, 'Napoli');
INSERT INTO unc_248557.wireless_ciudad VALUES (42, 'Curon Venosta/Graun im Vinschgau');
INSERT INTO unc_248557.wireless_ciudad VALUES (43, 'Heinsch');
INSERT INTO unc_248557.wireless_ciudad VALUES (44, 'Leiden');
INSERT INTO unc_248557.wireless_ciudad VALUES (45, 'Ortonovo');
INSERT INTO unc_248557.wireless_ciudad VALUES (46, 'Monacilioni');
INSERT INTO unc_248557.wireless_ciudad VALUES (47, 'Roosendaal');
INSERT INTO unc_248557.wireless_ciudad VALUES (48, 'Asse');
INSERT INTO unc_248557.wireless_ciudad VALUES (49, 'Scarborough');
INSERT INTO unc_248557.wireless_ciudad VALUES (50, 'Weißenfels');
INSERT INTO unc_248557.wireless_ciudad VALUES (51, 'Mal');
INSERT INTO unc_248557.wireless_ciudad VALUES (52, 'Hoogeveen');
INSERT INTO unc_248557.wireless_ciudad VALUES (53, 'Portezuelo');
INSERT INTO unc_248557.wireless_ciudad VALUES (54, 'Guysborough');
INSERT INTO unc_248557.wireless_ciudad VALUES (55, 'Sahiwal');
INSERT INTO unc_248557.wireless_ciudad VALUES (56, 'Penhold');
INSERT INTO unc_248557.wireless_ciudad VALUES (57, 'Dresden');
INSERT INTO unc_248557.wireless_ciudad VALUES (58, 'Itterbeek');
INSERT INTO unc_248557.wireless_ciudad VALUES (59, 'Skövde');
INSERT INTO unc_248557.wireless_ciudad VALUES (60, 'Loksbergen');
INSERT INTO unc_248557.wireless_ciudad VALUES (61, 'Riksingen');
INSERT INTO unc_248557.wireless_ciudad VALUES (62, 'Burin');
INSERT INTO unc_248557.wireless_ciudad VALUES (63, 'Siquirres');
INSERT INTO unc_248557.wireless_ciudad VALUES (64, 'Brixton');
INSERT INTO unc_248557.wireless_ciudad VALUES (65, 'Santo Stefano Quisquina');
INSERT INTO unc_248557.wireless_ciudad VALUES (66, 'Oudekapelle');
INSERT INTO unc_248557.wireless_ciudad VALUES (67, 'Paternopoli');
INSERT INTO unc_248557.wireless_ciudad VALUES (68, 'Afsnee');
INSERT INTO unc_248557.wireless_ciudad VALUES (69, 'Mandasor');
INSERT INTO unc_248557.wireless_ciudad VALUES (70, 'Homburg');
INSERT INTO unc_248557.wireless_ciudad VALUES (71, 'Montague');
INSERT INTO unc_248557.wireless_ciudad VALUES (72, 'Longvilly');
INSERT INTO unc_248557.wireless_ciudad VALUES (73, 'Hull');
INSERT INTO unc_248557.wireless_ciudad VALUES (74, 'Güssing');
INSERT INTO unc_248557.wireless_ciudad VALUES (75, 'Susegana');
INSERT INTO unc_248557.wireless_ciudad VALUES (76, 'Malbaie');
INSERT INTO unc_248557.wireless_ciudad VALUES (77, 'San Rafael');
INSERT INTO unc_248557.wireless_ciudad VALUES (78, 'Denver');
INSERT INTO unc_248557.wireless_ciudad VALUES (79, 'Nieuwerkerken');
INSERT INTO unc_248557.wireless_ciudad VALUES (80, 'Castel Colonna');
INSERT INTO unc_248557.wireless_ciudad VALUES (81, 'Forchtenstein');
INSERT INTO unc_248557.wireless_ciudad VALUES (82, 'Colloredo di Monte Albano');
INSERT INTO unc_248557.wireless_ciudad VALUES (83, 'Cheyenne');
INSERT INTO unc_248557.wireless_ciudad VALUES (84, 'Rothes');
INSERT INTO unc_248557.wireless_ciudad VALUES (85, 'Kilmalcolm');
INSERT INTO unc_248557.wireless_ciudad VALUES (86, 'Klemskerke');
INSERT INTO unc_248557.wireless_ciudad VALUES (87, 'Orvault');
INSERT INTO unc_248557.wireless_ciudad VALUES (88, 'Riksingen');
INSERT INTO unc_248557.wireless_ciudad VALUES (89, 'Labro');
INSERT INTO unc_248557.wireless_ciudad VALUES (90, 'Hervey Bay');
INSERT INTO unc_248557.wireless_ciudad VALUES (91, 'Newbury');
INSERT INTO unc_248557.wireless_ciudad VALUES (92, 'Richmond Hill');
INSERT INTO unc_248557.wireless_ciudad VALUES (93, 'Wrocław');
INSERT INTO unc_248557.wireless_ciudad VALUES (94, 'Ajaccio');
INSERT INTO unc_248557.wireless_ciudad VALUES (95, 'Fallais');
INSERT INTO unc_248557.wireless_ciudad VALUES (96, 'Warspite');
INSERT INTO unc_248557.wireless_ciudad VALUES (97, 'San Fernando');
INSERT INTO unc_248557.wireless_ciudad VALUES (98, 'Giove');
INSERT INTO unc_248557.wireless_ciudad VALUES (99, 'Houffalize');
INSERT INTO unc_248557.wireless_ciudad VALUES (100, 'Ammanford');


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_cliente VALUES (31, 2319.550);
INSERT INTO unc_248557.wireless_cliente VALUES (32, 2749.160);
INSERT INTO unc_248557.wireless_cliente VALUES (33, 747.410);
INSERT INTO unc_248557.wireless_cliente VALUES (34, 1195.200);
INSERT INTO unc_248557.wireless_cliente VALUES (35, 2591.550);
INSERT INTO unc_248557.wireless_cliente VALUES (36, -44.610);
INSERT INTO unc_248557.wireless_cliente VALUES (37, 1970.950);
INSERT INTO unc_248557.wireless_cliente VALUES (38, 3062.660);
INSERT INTO unc_248557.wireless_cliente VALUES (39, 1717.740);
INSERT INTO unc_248557.wireless_cliente VALUES (40, 1616.770);
INSERT INTO unc_248557.wireless_cliente VALUES (41, 1727.210);
INSERT INTO unc_248557.wireless_cliente VALUES (42, 4137.500);
INSERT INTO unc_248557.wireless_cliente VALUES (43, 2770.410);
INSERT INTO unc_248557.wireless_cliente VALUES (44, 1581.940);
INSERT INTO unc_248557.wireless_cliente VALUES (45, 1374.720);
INSERT INTO unc_248557.wireless_cliente VALUES (46, 1491.810);
INSERT INTO unc_248557.wireless_cliente VALUES (47, 2122.890);
INSERT INTO unc_248557.wireless_cliente VALUES (48, 2953.270);
INSERT INTO unc_248557.wireless_cliente VALUES (49, 2885.040);
INSERT INTO unc_248557.wireless_cliente VALUES (50, 3757.090);
INSERT INTO unc_248557.wireless_cliente VALUES (51, 2331.800);
INSERT INTO unc_248557.wireless_cliente VALUES (52, 1075.530);
INSERT INTO unc_248557.wireless_cliente VALUES (53, 2441.120);
INSERT INTO unc_248557.wireless_cliente VALUES (54, 2391.060);
INSERT INTO unc_248557.wireless_cliente VALUES (55, 3044.560);
INSERT INTO unc_248557.wireless_cliente VALUES (56, 2492.300);
INSERT INTO unc_248557.wireless_cliente VALUES (57, 3101.890);
INSERT INTO unc_248557.wireless_cliente VALUES (58, 401.620);
INSERT INTO unc_248557.wireless_cliente VALUES (59, 411.300);
INSERT INTO unc_248557.wireless_cliente VALUES (60, 195.670);
INSERT INTO unc_248557.wireless_cliente VALUES (61, 2013.380);
INSERT INTO unc_248557.wireless_cliente VALUES (62, 3773.530);
INSERT INTO unc_248557.wireless_cliente VALUES (63, 414.840);
INSERT INTO unc_248557.wireless_cliente VALUES (64, 2344.380);
INSERT INTO unc_248557.wireless_cliente VALUES (65, 1207.330);
INSERT INTO unc_248557.wireless_cliente VALUES (66, 1519.240);
INSERT INTO unc_248557.wireless_cliente VALUES (67, 486.120);
INSERT INTO unc_248557.wireless_cliente VALUES (68, 2397.810);
INSERT INTO unc_248557.wireless_cliente VALUES (69, 1965.890);
INSERT INTO unc_248557.wireless_cliente VALUES (70, 1357.000);
INSERT INTO unc_248557.wireless_cliente VALUES (71, 6730.310);
INSERT INTO unc_248557.wireless_cliente VALUES (72, 665.800);
INSERT INTO unc_248557.wireless_cliente VALUES (73, 820.760);
INSERT INTO unc_248557.wireless_cliente VALUES (74, 694.440);
INSERT INTO unc_248557.wireless_cliente VALUES (75, 1446.960);
INSERT INTO unc_248557.wireless_cliente VALUES (76, 5182.990);
INSERT INTO unc_248557.wireless_cliente VALUES (77, 1660.120);
INSERT INTO unc_248557.wireless_cliente VALUES (78, 611.970);
INSERT INTO unc_248557.wireless_cliente VALUES (79, 4140.130);
INSERT INTO unc_248557.wireless_cliente VALUES (80, 1444.930);
INSERT INTO unc_248557.wireless_cliente VALUES (81, 624.560);
INSERT INTO unc_248557.wireless_cliente VALUES (82, 1779.850);
INSERT INTO unc_248557.wireless_cliente VALUES (83, -394.070);
INSERT INTO unc_248557.wireless_cliente VALUES (84, 1072.620);
INSERT INTO unc_248557.wireless_cliente VALUES (85, 136.120);
INSERT INTO unc_248557.wireless_cliente VALUES (86, 2328.930);
INSERT INTO unc_248557.wireless_cliente VALUES (87, 1658.710);
INSERT INTO unc_248557.wireless_cliente VALUES (88, 1414.000);
INSERT INTO unc_248557.wireless_cliente VALUES (89, 1874.870);
INSERT INTO unc_248557.wireless_cliente VALUES (90, 1853.140);
INSERT INTO unc_248557.wireless_cliente VALUES (91, 2961.220);
INSERT INTO unc_248557.wireless_cliente VALUES (92, 2366.630);
INSERT INTO unc_248557.wireless_cliente VALUES (93, 1804.750);
INSERT INTO unc_248557.wireless_cliente VALUES (94, 994.600);
INSERT INTO unc_248557.wireless_cliente VALUES (95, 1282.390);
INSERT INTO unc_248557.wireless_cliente VALUES (96, 2553.170);
INSERT INTO unc_248557.wireless_cliente VALUES (97, 945.890);
INSERT INTO unc_248557.wireless_cliente VALUES (98, 827.370);
INSERT INTO unc_248557.wireless_cliente VALUES (99, 2881.900);
INSERT INTO unc_248557.wireless_cliente VALUES (100, 4112.610);


--
-- Data for Name: comprobante; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_comprobante VALUES (49, 2, '2010-02-22 00:00:00', 2, 'est', NULL, NULL, NULL, 0.00000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (256, 2, '2008-07-10 00:00:00', 24, 'feugiat', NULL, NULL, NULL, 0.00000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (352, 2, '2001-07-26 00:00:00', 17, 'mus. Donec', NULL, NULL, NULL, 0.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (549, 2, '2016-07-20 00:00:00', 16, 'non,', NULL, NULL, NULL, 0.00000, 81);
INSERT INTO unc_248557.wireless_comprobante VALUES (1, 3, '2000-06-29 19:20:29', 3, 'eu, odio. Phasellus', 'PAGADO', NULL, 153, 416.35000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (2, 3, '2011-05-12 08:07:50', 14, 'sed, sapien.', 'PAGADO', NULL, 17, 802.28000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (3, 1, '2004-02-01 00:00:00', 4, 'dis parturient montes,', NULL, '2004-02-11 00:00:00', NULL, 59.00000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (6, 2, '2006-10-08 00:00:00', 26, 'vitae purus gravida', NULL, NULL, NULL, 0.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (7, 3, '2002-08-06 15:45:43', 24, 'risus', 'PAGADO', NULL, 86, 232.11000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (8, 3, '2015-01-09 02:49:17', 10, 'pede nec', 'PAGADO', NULL, 58, 899.35000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (10, 3, '2005-09-29 21:19:19', 3, 'ac', 'PAGADO', NULL, 74, 308.73000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (11, 1, '2010-06-08 00:00:00', 24, 'a, arcu.', NULL, '2010-06-18 00:00:00', NULL, 185.00000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (13, 1, '2017-01-15 00:00:00', 26, 'Suspendisse sed', NULL, '2017-01-25 00:00:00', NULL, 174.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (15, 1, '2015-03-31 00:00:00', 30, 'justo eu', NULL, '2015-04-10 00:00:00', NULL, 44.00000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (16, 1, '2011-03-10 00:00:00', 5, 'ullamcorper. Duis', NULL, '2011-03-20 00:00:00', NULL, 189.00000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (17, 1, '2007-09-19 00:00:00', 9, 'eu tellus.', NULL, '2007-09-29 00:00:00', NULL, 10.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (19, 1, '2016-01-20 00:00:00', 21, 'Phasellus', NULL, '2016-01-30 00:00:00', NULL, 61.00000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (23, 1, '2009-11-16 00:00:00', 1, 'dignissim tempor arcu.', NULL, '2009-11-26 00:00:00', NULL, 26.00000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (24, 3, '2016-01-26 09:15:45', 10, 'ipsum dolor sit', 'PAGADO', NULL, 62, 115.41000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (25, 1, '2000-08-15 00:00:00', 20, 'Integer vulputate, risus', NULL, '2000-08-25 00:00:00', NULL, 56.00000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (26, 3, '2016-01-03 00:35:17', 8, 'eu sem.', 'PAGADO', NULL, 147, 560.10000, 77);
INSERT INTO unc_248557.wireless_comprobante VALUES (27, 1, '2011-10-11 00:00:00', 4, 'ultrices a, auctor', NULL, '2011-10-21 00:00:00', NULL, 3.00000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (28, 1, '2011-01-03 00:00:00', 5, 'dolor elit,', NULL, '2011-01-13 00:00:00', NULL, 203.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (29, 3, '2010-03-09 16:02:26', 30, 'ante ipsum primis', 'PAGADO', NULL, 122, 549.80000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (30, 3, '2009-11-27 14:17:54', 29, 'velit. Aliquam nisl.', 'PAGADO', NULL, 170, 174.86000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (32, 2, '2002-12-19 00:00:00', 16, 'Donec tempor,', NULL, NULL, NULL, 0.00000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (33, 3, '2006-12-27 01:43:55', 4, 'faucibus.', 'PAGADO', NULL, 72, 685.08000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (34, 3, '2004-06-16 21:15:44', 29, 'ut', 'PAGADO', NULL, 149, 912.06000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (36, 3, '2011-05-27 19:20:47', 8, 'arcu.', 'PAGADO', NULL, 84, 877.76000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (37, 3, '2009-12-17 22:35:18', 30, 'elit.', 'PAGADO', NULL, 185, 143.51000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (38, 3, '2014-12-11 06:52:16', 19, 'pede nec ante', 'PAGADO', NULL, 181, 518.96000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (39, 3, '2000-06-29 20:20:29', 17, 'non', 'PAGADO', NULL, 153, 502.17000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (40, 1, '2012-07-18 00:00:00', 16, 'magna.', NULL, '2012-07-28 00:00:00', NULL, 12.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (42, 1, '2001-11-15 00:00:00', 1, 'Donec nibh. Quisque', NULL, '2001-11-25 00:00:00', NULL, 150.00000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (44, 2, '2007-10-16 00:00:00', 13, 'lobortis', NULL, NULL, NULL, 0.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (45, 3, '2014-02-14 21:59:06', 23, 'facilisis lorem tristique', 'PAGADO', NULL, 142, 303.98000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (48, 3, '2001-06-21 07:12:41', 26, 'Nunc sed', 'PAGADO', NULL, 75, 473.82000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (51, 1, '2005-10-17 00:00:00', 25, 'amet lorem semper', NULL, '2005-10-27 00:00:00', NULL, 141.00000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (53, 1, '2008-03-07 00:00:00', 15, 'sagittis placerat.', NULL, '2008-03-17 00:00:00', NULL, 5.00000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (54, 2, '2009-11-05 00:00:00', 17, 'In mi pede,', NULL, NULL, NULL, 0.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (57, 1, '2004-02-09 00:00:00', 16, 'tempus', NULL, '2004-02-19 00:00:00', NULL, 57.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (58, 1, '2015-12-08 00:00:00', 12, 'pretium', NULL, '2015-12-18 00:00:00', NULL, 60.00000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (59, 2, '2005-08-23 00:00:00', 13, 'vulputate, posuere', NULL, NULL, NULL, 0.00000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (62, 3, '2005-04-10 01:36:23', 10, 'rutrum', 'PAGADO', NULL, 154, 810.81000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (63, 3, '2006-07-18 10:37:26', 14, 'sociis', 'PAGADO', NULL, 28, 446.89000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (64, 3, '2011-05-22 14:12:18', 4, 'enim diam vel', 'PAGADO', NULL, 99, 811.67000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (65, 3, '2000-06-30 00:20:29', 3, 'primis in faucibus', 'PAGADO', NULL, 153, 835.90000, 44);
INSERT INTO unc_248557.wireless_comprobante VALUES (66, 3, '2003-04-27 06:41:15', 22, 'sit', 'PAGADO', NULL, 45, 976.81000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (68, 1, '2008-07-26 00:00:00', 3, 'Cum sociis natoque', NULL, '2008-08-05 00:00:00', NULL, 60.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (69, 3, '2000-06-10 03:00:13', 28, 'elementum, dui quis', 'PAGADO', NULL, 54, 67.30000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (70, 3, '2000-08-27 06:22:38', 19, 'eu', 'PAGADO', NULL, 180, 845.27000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (71, 3, '2010-10-25 07:59:34', 13, 'et', 'PAGADO', NULL, 35, 589.09000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (72, 2, '2009-11-07 00:00:00', 6, 'eu odio', NULL, NULL, NULL, 0.00000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (74, 1, '2003-02-20 00:00:00', 12, 'Sed eu nibh', NULL, '2003-03-02 00:00:00', NULL, 182.00000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (75, 3, '2009-01-15 04:23:28', 7, 'sem', 'PAGADO', NULL, 98, 128.89000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (76, 1, '2011-10-16 00:00:00', 6, 'scelerisque mollis. Phasellus', NULL, '2011-10-26 00:00:00', NULL, 74.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (77, 3, '2009-01-01 22:52:05', 1, 'elit. Etiam laoreet,', 'PAGADO', NULL, 3, 288.88000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (78, 1, '2005-12-13 00:00:00', 17, 'sed turpis', NULL, '2005-12-23 00:00:00', NULL, 98.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (80, 1, '2017-05-28 00:00:00', 13, 'ornare,', NULL, '2017-06-07 00:00:00', NULL, 147.00000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (81, 3, '2004-02-05 02:59:53', 27, 'Donec', 'PAGADO', NULL, 34, 732.76000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (82, 3, '2006-09-04 11:04:32', 30, 'magna tellus faucibus', 'PAGADO', NULL, 1, 165.30000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (83, 3, '2016-08-20 08:52:52', 4, 'lorem eu', 'PAGADO', NULL, 93, 631.44000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (84, 3, '2000-11-11 09:55:34', 20, 'mattis semper,', 'PAGADO', NULL, 39, 299.03000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (85, 3, '2016-01-03 03:35:17', 6, 'adipiscing elit.', 'PAGADO', NULL, 147, 696.40000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (86, 3, '2015-02-03 03:59:28', 24, 'orci. Ut sagittis', 'PAGADO', NULL, 119, 139.27000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (87, 1, '2010-04-15 00:00:00', 5, 'sit', NULL, '2010-04-25 00:00:00', NULL, 50.00000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (88, 3, '2001-05-27 01:38:27', 11, 'quam vel', 'PAGADO', NULL, 194, 233.58000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (89, 3, '2007-03-29 07:56:40', 21, 'mauris.', 'PAGADO', NULL, 15, 400.08000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (91, 1, '2015-05-22 00:00:00', 20, 'Duis elementum,', NULL, '2015-06-01 00:00:00', NULL, 162.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (92, 3, '2004-03-13 08:58:51', 22, 'ultricies ligula. Nullam', 'PAGADO', NULL, 174, 998.18000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (93, 2, '2002-01-23 00:00:00', 24, 'amet', NULL, NULL, NULL, 0.00000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (94, 2, '2012-02-07 00:00:00', 18, 'nec ante blandit', NULL, NULL, NULL, 0.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (97, 3, '2010-12-02 18:47:49', 28, 'massa.', 'PAGADO', NULL, 129, 203.93000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (99, 3, '2001-07-26 02:38:10', 18, 'id magna et', 'PAGADO', NULL, 172, 846.44000, 74);
INSERT INTO unc_248557.wireless_comprobante VALUES (104, 3, '2008-11-23 07:52:18', 27, 'Duis sit amet', 'PAGADO', NULL, 23, 230.73000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (107, 3, '2006-06-11 00:41:40', 17, 'sit', 'PAGADO', NULL, 24, 567.30000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (108, 3, '2001-08-01 06:27:13', 4, 'risus. Morbi metus.', 'PAGADO', NULL, 32, 276.32000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (109, 2, '2003-12-18 00:00:00', 25, 'ultricies ligula. Nullam', NULL, NULL, NULL, 0.00000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (110, 1, '2005-04-01 00:00:00', 18, 'a,', NULL, '2005-04-11 00:00:00', NULL, 96.00000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (111, 1, '2005-08-02 00:00:00', 1, 'tristique', NULL, '2005-08-12 00:00:00', NULL, 171.00000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (114, 1, '2009-07-06 00:00:00', 28, 'posuere, enim nisl', NULL, '2009-07-16 00:00:00', NULL, 23.00000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (115, 2, '2015-02-27 00:00:00', 2, 'rutrum magna.', NULL, NULL, NULL, 0.00000, 59);
INSERT INTO unc_248557.wireless_comprobante VALUES (116, 3, '2001-06-09 12:32:36', 8, 'urna', 'PAGADO', NULL, 114, 392.53000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (118, 3, '2015-07-30 01:08:26', 21, 'massa. Vestibulum', 'PAGADO', NULL, 27, 522.96000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (120, 3, '2013-05-29 00:16:53', 4, 'Aliquam nec', 'PAGADO', NULL, 116, 813.33000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (121, 3, '2000-08-22 13:30:09', 28, 'Ut', 'PAGADO', NULL, 178, 780.75000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (122, 3, '2014-02-14 21:59:06', 25, 'amet', 'PAGADO', NULL, 142, 210.54000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (125, 2, '2006-04-30 00:00:00', 9, 'nonummy.', NULL, NULL, NULL, 0.00000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (126, 3, '2016-01-03 03:35:17', 5, 'accumsan neque et', 'PAGADO', NULL, 147, 837.76000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (127, 3, '2015-03-12 17:45:19', 6, 'tempor', 'PAGADO', NULL, 187, 874.21000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (128, 2, '2011-05-24 00:00:00', 16, 'eu,', NULL, NULL, NULL, 0.00000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (131, 2, '2012-07-19 00:00:00', 3, 'sociis natoque penatibus', NULL, NULL, NULL, 0.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (132, 3, '2015-10-26 14:10:36', 23, 'adipiscing fringilla,', 'PAGADO', NULL, 92, 963.39000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (133, 3, '2006-11-19 23:41:36', 29, 'aliquet molestie', 'PAGADO', NULL, 136, 606.33000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (134, 1, '2005-09-08 00:00:00', 20, 'velit egestas lacinia.', NULL, '2005-09-18 00:00:00', NULL, 37.00000, 74);
INSERT INTO unc_248557.wireless_comprobante VALUES (136, 2, '2010-11-12 00:00:00', 11, 'at, iaculis quis,', NULL, NULL, NULL, 0.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (137, 1, '2007-04-22 00:00:00', 29, 'per inceptos hymenaeos.', NULL, '2007-05-02 00:00:00', NULL, 76.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (139, 3, '2009-12-03 02:54:29', 30, 'Nam interdum enim', 'PAGADO', NULL, 33, 533.95000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (140, 3, '2009-04-06 03:03:58', 2, 'ornare. In', 'PAGADO', NULL, 186, 805.61000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (142, 3, '2004-03-13 04:58:51', 18, 'nunc', 'PAGADO', NULL, 174, 493.29000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (144, 3, '2011-02-01 00:37:04', 25, 'varius.', 'PAGADO', NULL, 166, 35.66000, 73);
INSERT INTO unc_248557.wireless_comprobante VALUES (146, 3, '2007-09-22 07:41:04', 11, 'vestibulum massa', 'PAGADO', NULL, 12, 59.52000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (150, 3, '2000-07-26 07:40:54', 9, 'magnis', 'PAGADO', NULL, 44, 968.67000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (152, 1, '2002-05-03 00:00:00', 13, 'lobortis', NULL, '2002-05-13 00:00:00', NULL, 79.00000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (153, 1, '2007-08-18 00:00:00', 12, 'ligula tortor, dictum', NULL, '2007-08-28 00:00:00', NULL, 109.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (154, 3, '2015-01-09 03:49:17', 26, 'molestie', 'PAGADO', NULL, 58, 898.91000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (156, 1, '2005-10-07 00:00:00', 18, 'non lorem vitae', NULL, '2005-10-17 00:00:00', NULL, 68.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (157, 3, '2014-02-15 00:59:06', 21, 'cursus.', 'PAGADO', NULL, 142, 408.49000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (158, 3, '2006-03-13 05:39:03', 30, 'Cum', 'PAGADO', NULL, 8, 323.60000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (160, 3, '2008-10-31 15:12:07', 22, 'vitae', 'PAGADO', NULL, 21, 168.19000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (164, 3, '2015-01-12 21:18:58', 22, 'nisl elementum', 'PAGADO', NULL, 63, 886.46000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (166, 1, '2001-10-19 00:00:00', 20, 'a,', NULL, '2001-10-29 00:00:00', NULL, 76.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (168, 2, '2003-02-07 00:00:00', 27, 'Sed', NULL, NULL, NULL, 0.00000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (170, 2, '2011-08-02 00:00:00', 8, 'urna. Nunc quis', NULL, NULL, NULL, 0.00000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (172, 2, '2013-06-26 00:00:00', 2, 'Cras dictum ultricies', NULL, NULL, NULL, 0.00000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (174, 1, '2012-09-11 00:00:00', 11, 'porttitor', NULL, '2012-09-21 00:00:00', NULL, 81.00000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (175, 3, '2000-01-31 17:08:14', 24, 'Aliquam', 'PAGADO', NULL, 73, 421.61000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (176, 2, '2011-08-28 00:00:00', 25, 'sit amet, dapibus', NULL, NULL, NULL, 0.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (177, 3, '2011-04-16 22:38:53', 9, 'velit.', 'PAGADO', NULL, 125, 29.51000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (178, 1, '2015-11-29 00:00:00', 23, 'tortor', NULL, '2015-12-09 00:00:00', NULL, 94.00000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (179, 1, '2003-02-22 00:00:00', 1, 'libero.', NULL, '2003-03-04 00:00:00', NULL, 172.00000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (181, 2, '2014-09-03 00:00:00', 5, 'Aliquam', NULL, NULL, NULL, 0.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (182, 3, '2015-02-18 13:36:19', 24, 'lobortis. Class', 'PAGADO', NULL, 141, 948.65000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (183, 1, '2001-11-20 00:00:00', 3, 'auctor odio', NULL, '2001-11-30 00:00:00', NULL, 40.00000, 73);
INSERT INTO unc_248557.wireless_comprobante VALUES (184, 2, '2012-01-29 00:00:00', 10, 'Class aptent taciti', NULL, NULL, NULL, 0.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (186, 1, '2014-04-04 00:00:00', 27, 'risus varius', NULL, '2014-04-14 00:00:00', NULL, 148.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (188, 3, '2003-04-06 20:56:54', 17, 'interdum. Sed auctor', 'PAGADO', NULL, 68, 970.50000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (189, 3, '2003-07-20 06:52:58', 3, 'fringilla, porttitor vulputate,', 'PAGADO', NULL, 56, 428.48000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (190, 3, '2006-06-11 05:41:40', 17, 'sed dolor. Fusce', 'PAGADO', NULL, 24, 597.01000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (191, 1, '2010-12-08 00:00:00', 13, 'et malesuada fames', NULL, '2010-12-18 00:00:00', NULL, 34.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (192, 3, '2010-11-10 17:20:50', 20, 'ipsum', 'PAGADO', NULL, 131, 871.26000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (193, 3, '2007-09-05 05:25:19', 29, 'vitae nibh. Donec', 'PAGADO', NULL, 159, 389.67000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (194, 3, '2004-01-18 13:08:18', 6, 'cursus in, hendrerit', 'PAGADO', NULL, 111, 947.97000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (197, 1, '2008-08-25 00:00:00', 30, 'velit dui, semper', NULL, '2008-09-04 00:00:00', NULL, 57.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (199, 2, '2015-01-05 00:00:00', 24, 'ad', NULL, NULL, NULL, 0.00000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (200, 3, '2004-05-18 16:20:08', 19, 'consequat purus.', 'PAGADO', NULL, 6, 74.09000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (201, 1, '2000-11-01 00:00:00', 5, 'urna. Nullam', NULL, '2000-11-11 00:00:00', NULL, 43.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (202, 3, '2011-12-16 12:43:38', 4, 'Lorem', 'PAGADO', NULL, 13, 585.14000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (203, 1, '2009-10-08 00:00:00', 5, 'magnis dis parturient', NULL, '2009-10-18 00:00:00', NULL, 45.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (206, 2, '2008-12-06 00:00:00', 7, 'ac,', NULL, NULL, NULL, 0.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (209, 2, '2003-12-30 00:00:00', 17, 'ornare tortor', NULL, NULL, NULL, 0.00000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (210, 1, '2005-06-27 00:00:00', 18, 'lacinia mattis.', NULL, '2005-07-07 00:00:00', NULL, 99.00000, 59);
INSERT INTO unc_248557.wireless_comprobante VALUES (212, 3, '2011-12-16 16:43:38', 21, 'erat neque non', 'PAGADO', NULL, 13, 315.42000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (213, 3, '2001-06-21 06:12:41', 18, 'dictum', 'PAGADO', NULL, 75, 592.66000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (214, 3, '2011-11-19 12:19:12', 2, 'diam at pretium', 'PAGADO', NULL, 57, 872.12000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (215, 1, '2012-03-10 00:00:00', 27, 'est. Nunc laoreet', NULL, '2012-03-20 00:00:00', NULL, 65.00000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (216, 3, '2015-03-12 21:45:19', 24, 'vulputate ullamcorper magna.', 'PAGADO', NULL, 187, 839.95000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (218, 1, '2008-03-31 00:00:00', 1, 'faucibus.', NULL, '2008-04-10 00:00:00', NULL, 24.00000, 77);
INSERT INTO unc_248557.wireless_comprobante VALUES (220, 3, '2015-01-18 21:54:01', 1, 'Cras', 'PAGADO', NULL, 30, 131.50000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (227, 1, '2000-12-05 00:00:00', 2, 'magna.', NULL, '2000-12-15 00:00:00', NULL, 35.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (228, 3, '2009-12-17 22:35:18', 1, 'augue eu', 'PAGADO', NULL, 185, 868.08000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (229, 3, '2001-07-12 07:39:35', 7, 'imperdiet dictum magna.', 'PAGADO', NULL, 189, 415.04000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (231, 3, '2004-02-05 06:59:53', 28, 'nisi', 'PAGADO', NULL, 34, 383.65000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (233, 3, '2014-12-06 22:27:46', 13, 'mi. Aliquam gravida', 'PAGADO', NULL, 165, 589.28000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (235, 1, '2012-02-29 00:00:00', 3, 'sollicitudin a,', NULL, '2012-03-10 00:00:00', NULL, 109.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (236, 1, '2013-12-20 00:00:00', 22, 'Pellentesque tincidunt tempus', NULL, '2013-12-30 00:00:00', NULL, 100.00000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (237, 3, '2009-01-08 08:53:37', 29, 'blandit.', 'PAGADO', NULL, 37, 516.52000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (240, 1, '2015-05-04 00:00:00', 18, 'elit sed consequat', NULL, '2015-05-14 00:00:00', NULL, 117.00000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (244, 3, '2009-12-03 01:54:29', 26, 'lectus rutrum urna,', 'PAGADO', NULL, 33, 23.35000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (245, 2, '2001-06-03 00:00:00', 7, 'nisl. Quisque fringilla', NULL, NULL, NULL, 0.00000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (249, 3, '2007-07-06 13:36:07', 13, 'libero', 'PAGADO', NULL, 107, 49.17000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (250, 2, '2010-10-02 00:00:00', 20, 'porttitor', NULL, NULL, NULL, 0.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (251, 3, '2006-05-07 05:15:44', 15, 'vehicula et, rutrum', 'PAGADO', NULL, 48, 525.26000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (253, 1, '2011-10-26 00:00:00', 2, 'ac nulla. In', NULL, '2011-11-05 00:00:00', NULL, 77.00000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (257, 3, '2004-01-18 12:08:18', 13, 'Sed', 'PAGADO', NULL, 111, 363.14000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (259, 3, '2004-07-24 10:04:16', 12, 'est', 'PAGADO', NULL, 127, 655.91000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (260, 3, '2015-07-01 15:14:19', 30, 'Phasellus ornare.', 'PAGADO', NULL, 196, 571.73000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (261, 3, '2015-01-18 23:54:01', 8, 'arcu. Vestibulum ante', 'PAGADO', NULL, 30, 909.29000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (262, 2, '2000-11-08 00:00:00', 7, 'aptent taciti', NULL, NULL, NULL, 0.00000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (263, 3, '2014-03-17 16:49:35', 3, 'nunc nulla', 'PAGADO', NULL, 184, 951.76000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (265, 1, '2015-07-01 00:00:00', 26, 'orci lacus', NULL, '2015-07-11 00:00:00', NULL, 14.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (266, 1, '2015-07-28 00:00:00', 2, 'porttitor tellus', NULL, '2015-08-07 00:00:00', NULL, 42.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (268, 1, '2012-09-14 00:00:00', 26, 'pretium neque.', NULL, '2012-09-24 00:00:00', NULL, 85.00000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (269, 3, '2015-07-26 17:27:45', 12, 'sit amet ultricies', 'PAGADO', NULL, 183, 809.92000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (270, 2, '2009-07-31 00:00:00', 20, 'magna', NULL, NULL, NULL, 0.00000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (271, 1, '2010-09-09 00:00:00', 1, 'sollicitudin adipiscing', NULL, '2010-09-19 00:00:00', NULL, 70.00000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (272, 1, '2009-03-22 00:00:00', 24, 'arcu. Vestibulum ante', NULL, '2009-04-01 00:00:00', NULL, 43.00000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (273, 1, '2000-10-20 00:00:00', 13, 'id, mollis nec,', NULL, '2000-10-30 00:00:00', NULL, 216.00000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (274, 3, '2014-11-05 22:28:47', 10, 'vitae risus.', 'PAGADO', NULL, 132, 82.77000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (276, 1, '2013-04-15 00:00:00', 18, 'netus', NULL, '2013-04-25 00:00:00', NULL, 86.00000, 81);
INSERT INTO unc_248557.wireless_comprobante VALUES (277, 2, '2014-07-04 00:00:00', 27, 'Nunc', NULL, NULL, NULL, 0.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (279, 3, '2016-08-20 09:52:52', 18, 'lorem lorem, luctus', 'PAGADO', NULL, 93, 588.03000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (280, 2, '2008-10-01 00:00:00', 13, 'neque', NULL, NULL, NULL, 0.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (282, 2, '2010-01-09 00:00:00', 20, 'eget, dictum placerat,', NULL, NULL, NULL, 0.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (285, 3, '2013-03-02 00:53:52', 17, 'eu tempor erat', 'PAGADO', NULL, 2, 989.19000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (288, 1, '2007-01-25 00:00:00', 22, 'ut mi.', NULL, '2007-02-04 00:00:00', NULL, 153.00000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (291, 2, '2003-01-28 00:00:00', 25, 'tincidunt', NULL, NULL, NULL, 0.00000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (292, 3, '2006-09-14 04:58:58', 21, 'porttitor vulputate, posuere', 'PAGADO', NULL, 179, 593.13000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (293, 3, '2017-03-19 04:33:56', 14, 'ac,', 'PAGADO', NULL, 138, 360.91000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (296, 3, '2010-07-09 00:56:26', 7, 'dolor dapibus', 'PAGADO', NULL, 162, 641.95000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (299, 3, '2006-05-07 08:15:44', 15, 'Aliquam', 'PAGADO', NULL, 48, 806.43000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (300, 1, '2015-04-24 00:00:00', 27, 'Nulla', NULL, '2015-05-04 00:00:00', NULL, 69.00000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (301, 2, '2014-11-11 00:00:00', 15, 'arcu eu', NULL, NULL, NULL, 0.00000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (302, 3, '2000-07-25 05:32:16', 7, 'vel', 'PAGADO', NULL, 5, 51.90000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (303, 3, '2008-09-04 12:08:51', 12, 'ante', 'PAGADO', NULL, 65, 172.89000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (304, 3, '2011-01-06 04:50:40', 20, 'adipiscing lacus.', 'PAGADO', NULL, 4, 494.86000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (307, 2, '2008-10-02 00:00:00', 8, 'enim, gravida sit', NULL, NULL, NULL, 0.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (308, 1, '2005-11-21 00:00:00', 30, 'magna.', NULL, '2005-12-01 00:00:00', NULL, 99.00000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (309, 1, '2000-10-26 00:00:00', 26, 'sit amet, dapibus', NULL, '2000-11-05 00:00:00', NULL, 42.00000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (310, 1, '2009-01-13 00:00:00', 25, 'odio', NULL, '2009-01-23 00:00:00', NULL, 34.00000, 44);
INSERT INTO unc_248557.wireless_comprobante VALUES (311, 2, '2000-01-15 00:00:00', 18, 'vulputate ullamcorper', NULL, NULL, NULL, 0.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (314, 2, '2012-01-18 00:00:00', 26, 'venenatis lacus.', NULL, NULL, NULL, 0.00000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (316, 3, '2011-05-12 09:07:50', 25, 'Fusce feugiat. Lorem', 'PAGADO', NULL, 17, 968.20000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (319, 1, '2014-07-13 00:00:00', 4, 'amet risus. Donec', NULL, '2014-07-23 00:00:00', NULL, 38.00000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (320, 1, '2000-02-14 00:00:00', 24, 'sem ut dolor', NULL, '2000-02-24 00:00:00', NULL, 115.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (324, 3, '2011-05-22 16:12:18', 5, 'ornare. Fusce', 'PAGADO', NULL, 99, 192.38000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (325, 1, '2007-02-02 00:00:00', 13, 'netus et', NULL, '2007-02-12 00:00:00', NULL, 101.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (326, 1, '2009-09-03 00:00:00', 14, 'elit, pellentesque', NULL, '2009-09-13 00:00:00', NULL, 32.00000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (328, 1, '2016-08-19 00:00:00', 26, 'risus.', NULL, '2016-08-29 00:00:00', NULL, 88.00000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (329, 1, '2014-01-23 00:00:00', 14, 'non ante bibendum', NULL, '2014-02-02 00:00:00', NULL, 46.00000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (331, 3, '2012-05-11 07:51:35', 3, 'semper pretium neque.', 'PAGADO', NULL, 70, 241.42000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (332, 1, '2005-07-21 00:00:00', 14, 'erat', NULL, '2005-07-31 00:00:00', NULL, 105.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (333, 3, '2008-05-24 03:37:58', 17, 'at pretium', 'PAGADO', NULL, 158, 195.22000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (334, 3, '2012-01-26 10:29:20', 16, 'ultrices.', 'PAGADO', NULL, 105, 6.46000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (336, 3, '2006-09-14 01:58:58', 25, 'neque', 'PAGADO', NULL, 179, 63.53000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (337, 3, '2006-07-09 13:45:03', 16, 'dapibus quam', 'PAGADO', NULL, 161, 951.73000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (340, 1, '2005-12-22 00:00:00', 8, 'nec,', NULL, '2006-01-01 00:00:00', NULL, 55.00000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (342, 1, '2010-10-18 00:00:00', 20, 'gravida.', NULL, '2010-10-28 00:00:00', NULL, 95.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (343, 1, '2010-03-04 00:00:00', 29, 'Nunc', NULL, '2010-03-14 00:00:00', NULL, 11.00000, 80);
INSERT INTO unc_248557.wireless_comprobante VALUES (344, 3, '2015-07-01 18:14:19', 22, 'Aliquam', 'PAGADO', NULL, 196, 805.73000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (348, 1, '2014-03-21 00:00:00', 18, 'leo.', NULL, '2014-03-31 00:00:00', NULL, 86.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (351, 1, '2004-07-02 00:00:00', 11, 'sem mollis dui,', NULL, '2004-07-12 00:00:00', NULL, 85.00000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (353, 1, '2004-08-30 00:00:00', 22, 'felis, adipiscing', NULL, '2004-09-09 00:00:00', NULL, 21.00000, 44);
INSERT INTO unc_248557.wireless_comprobante VALUES (355, 3, '2017-02-11 07:29:19', 11, 'nec ante. Maecenas', 'PAGADO', NULL, 10, 507.62000, 46);
INSERT INTO unc_248557.wireless_comprobante VALUES (356, 3, '2015-05-25 22:52:02', 3, 'Cum', 'PAGADO', NULL, 146, 809.95000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (357, 3, '2002-10-16 00:52:40', 4, 'vel pede', 'PAGADO', NULL, 120, 588.26000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (359, 1, '2007-01-27 00:00:00', 20, 'massa. Integer vitae', NULL, '2007-02-06 00:00:00', NULL, 129.00000, 73);
INSERT INTO unc_248557.wireless_comprobante VALUES (360, 3, '2004-12-19 10:20:56', 16, 'mollis. Phasellus libero', 'PAGADO', NULL, 41, 88.34000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (363, 3, '2014-12-11 11:52:16', 14, 'primis', 'PAGADO', NULL, 181, 46.97000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (366, 3, '2015-05-22 19:04:21', 13, 'egestas blandit. Nam', 'PAGADO', NULL, 101, 167.98000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (367, 3, '2004-06-22 23:23:16', 10, 'eleifend', 'PAGADO', NULL, 193, 656.91000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (369, 2, '2012-05-13 00:00:00', 10, 'id ante dictum', NULL, NULL, NULL, 0.00000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (370, 3, '2012-01-26 12:29:20', 13, 'enim,', 'PAGADO', NULL, 105, 911.42000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (372, 1, '2011-03-15 00:00:00', 14, 'eget mollis', NULL, '2011-03-25 00:00:00', NULL, 61.00000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (373, 1, '2016-12-14 00:00:00', 4, 'nec tempus scelerisque,', NULL, '2016-12-24 00:00:00', NULL, 20.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (375, 3, '2002-02-26 16:59:33', 27, 'tellus. Nunc lectus', 'PAGADO', NULL, 19, 807.31000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (376, 2, '2012-06-23 00:00:00', 6, 'Curabitur vel', NULL, NULL, NULL, 0.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (377, 3, '2013-03-01 22:53:52', 26, 'augue', 'PAGADO', NULL, 2, 261.90000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (378, 3, '2017-03-19 07:33:56', 22, 'Curabitur consequat, lectus', 'PAGADO', NULL, 138, 156.06000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (382, 3, '2015-10-16 09:56:33', 17, 'placerat', 'PAGADO', NULL, 71, 46.49000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (383, 1, '2009-02-21 00:00:00', 15, 'nec', NULL, '2009-03-03 00:00:00', NULL, 127.00000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (384, 3, '2015-02-20 19:13:34', 14, 'euismod mauris eu', 'PAGADO', NULL, 130, 826.67000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (385, 1, '2002-05-10 00:00:00', 11, 'diam. Pellentesque habitant', NULL, '2002-05-20 00:00:00', NULL, 91.00000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (386, 3, '2012-01-08 09:11:56', 29, 'at sem molestie', 'PAGADO', NULL, 168, 149.48000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (387, 3, '2004-01-18 18:08:18', 24, 'nisi.', 'PAGADO', NULL, 111, 898.63000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (389, 3, '2008-06-08 23:58:04', 23, 'ante. Vivamus', 'PAGADO', NULL, 51, 89.79000, 72);
INSERT INTO unc_248557.wireless_comprobante VALUES (391, 3, '2004-01-18 15:08:18', 9, 'lorem semper', 'PAGADO', NULL, 111, 685.75000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (392, 3, '2004-03-13 10:58:51', 15, 'congue, elit', 'PAGADO', NULL, 174, 147.31000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (393, 1, '2000-01-16 00:00:00', 23, 'pede. Cras vulputate', NULL, '2000-01-26 00:00:00', NULL, 50.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (395, 3, '2006-06-23 23:16:21', 4, 'lectus. Nullam suscipit,', 'PAGADO', NULL, 18, 869.88000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (396, 3, '2000-02-19 20:55:16', 29, 'nonummy. Fusce fermentum', 'PAGADO', NULL, 110, 408.50000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (398, 1, '2013-12-04 00:00:00', 3, 'elit fermentum risus,', NULL, '2013-12-14 00:00:00', NULL, 34.00000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (399, 3, '2001-05-19 12:47:50', 25, 'Nunc ac', 'PAGADO', NULL, 197, 97.90000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (401, 1, '2002-12-28 00:00:00', 23, 'auctor,', NULL, '2003-01-07 00:00:00', NULL, 125.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (402, 3, '2014-12-07 00:27:46', 17, 'mollis. Phasellus libero', 'PAGADO', NULL, 165, 102.53000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (404, 3, '2003-03-30 12:53:50', 4, 'nulla. In', 'PAGADO', NULL, 14, 97.69000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (405, 1, '2017-01-03 00:00:00', 25, 'pharetra nibh. Aliquam', NULL, '2017-01-13 00:00:00', NULL, 160.00000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (406, 3, '2011-05-27 13:20:47', 7, 'gravida. Praesent eu', 'PAGADO', NULL, 84, 785.38000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (407, 3, '2013-07-20 12:28:41', 28, 'dictum mi,', 'PAGADO', NULL, 140, 196.46000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (408, 3, '2006-07-18 07:37:26', 6, 'sit amet', 'PAGADO', NULL, 28, 436.78000, 59);
INSERT INTO unc_248557.wireless_comprobante VALUES (411, 3, '2003-06-04 18:58:22', 19, 'justo nec ante.', 'PAGADO', NULL, 50, 141.16000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (412, 3, '2009-03-04 05:49:28', 27, 'quam a', 'PAGADO', NULL, 152, 846.12000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (413, 2, '2000-08-07 00:00:00', 16, 'euismod enim. Etiam', NULL, NULL, NULL, 0.00000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (415, 3, '2001-04-06 14:07:14', 15, 'quis,', 'PAGADO', NULL, 117, 825.67000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (417, 1, '2006-05-28 00:00:00', 24, 'lacus. Cras interdum.', NULL, '2006-06-07 00:00:00', NULL, 76.00000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (420, 3, '2008-12-15 01:39:09', 9, 'Donec fringilla. Donec', 'PAGADO', NULL, 173, 640.52000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (421, 1, '2015-01-09 00:00:00', 29, 'magnis dis', NULL, '2015-01-19 00:00:00', NULL, 21.00000, 81);
INSERT INTO unc_248557.wireless_comprobante VALUES (422, 3, '2001-12-09 12:45:13', 7, 'sed turpis nec', 'PAGADO', NULL, 77, 883.67000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (424, 3, '2004-12-19 10:20:56', 23, 'neque', 'PAGADO', NULL, 41, 270.48000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (425, 3, '2000-09-29 21:31:53', 21, 'sed,', 'PAGADO', NULL, 88, 868.28000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (427, 2, '2013-09-16 00:00:00', 26, 'tempus non, lacinia', NULL, NULL, NULL, 0.00000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (428, 3, '2001-06-09 14:32:36', 29, 'lacinia mattis. Integer', 'PAGADO', NULL, 114, 103.45000, 46);
INSERT INTO unc_248557.wireless_comprobante VALUES (429, 2, '2012-01-06 00:00:00', 5, 'arcu eu', NULL, NULL, NULL, 0.00000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (430, 2, '2012-07-03 00:00:00', 6, 'Curae Donec', NULL, NULL, NULL, 0.00000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (431, 2, '2001-06-11 00:00:00', 8, 'sagittis. Nullam', NULL, NULL, NULL, 0.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (432, 2, '2005-11-16 00:00:00', 16, 'feugiat nec,', NULL, NULL, NULL, 0.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (433, 1, '2000-02-16 00:00:00', 25, 'nascetur ridiculus mus.', NULL, '2000-02-26 00:00:00', NULL, 180.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (436, 3, '2010-07-09 02:56:26', 20, 'Donec', 'PAGADO', NULL, 162, 437.38000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (438, 3, '2004-02-05 05:59:53', 20, 'dui, semper et,', 'PAGADO', NULL, 34, 334.80000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (440, 1, '2016-12-10 00:00:00', 24, 'orci. Phasellus dapibus', NULL, '2016-12-20 00:00:00', NULL, 69.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (441, 3, '2008-12-15 02:39:09', 22, 'nibh dolor, nonummy', 'PAGADO', NULL, 173, 151.39000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (442, 3, '2005-04-09 21:36:23', 9, 'tristique', 'PAGADO', NULL, 154, 544.09000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (443, 2, '2004-03-30 00:00:00', 27, 'dolor. Fusce', NULL, NULL, NULL, 0.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (445, 1, '2001-05-16 00:00:00', 27, 'eu,', NULL, '2001-05-26 00:00:00', NULL, 40.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (446, 1, '2005-11-21 00:00:00', 10, 'Nunc', NULL, '2005-12-01 00:00:00', NULL, 69.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (447, 3, '2000-08-22 08:30:09', 10, 'et', 'PAGADO', NULL, 178, 166.82000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (449, 3, '2017-02-11 04:29:19', 22, 'scelerisque neque. Nullam', 'PAGADO', NULL, 10, 625.17000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (450, 3, '2000-09-29 23:31:53', 30, 'Vestibulum ut eros', 'PAGADO', NULL, 88, 83.57000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (451, 1, '2011-01-08 00:00:00', 22, 'id, mollis', NULL, '2011-01-18 00:00:00', NULL, 91.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (452, 3, '2000-08-27 08:22:38', 19, 'Sed dictum.', 'PAGADO', NULL, 180, 513.38000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (453, 2, '2002-12-17 00:00:00', 12, 'tempus', NULL, NULL, NULL, 0.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (455, 3, '2014-06-02 08:53:16', 10, 'quis diam luctus', 'PAGADO', NULL, 59, 904.62000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (456, 1, '2000-01-12 00:00:00', 2, 'at augue', NULL, '2000-01-22 00:00:00', NULL, 153.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (457, 3, '2010-03-09 14:02:26', 20, 'a felis ullamcorper', 'PAGADO', NULL, 122, 830.07000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (458, 3, '2009-03-04 01:49:28', 23, 'Duis volutpat nunc', 'PAGADO', NULL, 152, 193.21000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (459, 3, '2005-05-28 05:47:25', 8, 'Cras', 'PAGADO', NULL, 124, 64.44000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (461, 1, '2009-10-26 00:00:00', 15, 'montes, nascetur', NULL, '2009-11-05 00:00:00', NULL, 97.00000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (463, 2, '2013-10-23 00:00:00', 18, 'lobortis. Class', NULL, NULL, NULL, 0.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (468, 2, '2000-05-19 00:00:00', 16, 'cursus luctus, ipsum', NULL, NULL, NULL, 0.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (470, 1, '2016-08-16 00:00:00', 2, 'pede', NULL, '2016-08-26 00:00:00', NULL, 161.00000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (471, 1, '2005-12-05 00:00:00', 15, 'nascetur ridiculus', NULL, '2005-12-15 00:00:00', NULL, 36.00000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (472, 2, '2007-10-23 00:00:00', 10, 'In lorem. Donec', NULL, NULL, NULL, 0.00000, 59);
INSERT INTO unc_248557.wireless_comprobante VALUES (473, 1, '2007-10-02 00:00:00', 4, 'Nulla tincidunt, neque', NULL, '2007-10-12 00:00:00', NULL, 100.00000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (474, 1, '2007-04-17 00:00:00', 16, 'massa. Quisque', NULL, '2007-04-27 00:00:00', NULL, 117.00000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (479, 1, '2005-11-30 00:00:00', 29, 'accumsan neque et', NULL, '2005-12-10 00:00:00', NULL, 9.00000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (482, 3, '2003-03-30 12:53:50', 22, 'vel,', 'PAGADO', NULL, 14, 27.60000, 81);
INSERT INTO unc_248557.wireless_comprobante VALUES (484, 3, '2015-01-18 23:54:01', 24, 'non, vestibulum nec,', 'PAGADO', NULL, 30, 140.38000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (486, 1, '2006-01-20 00:00:00', 28, 'at, libero.', NULL, '2006-01-30 00:00:00', NULL, 64.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (489, 3, '2000-07-25 02:32:16', 1, 'sapien, gravida non,', 'PAGADO', NULL, 5, 62.51000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (490, 3, '2014-04-30 10:27:05', 22, 'molestie tellus. Aenean', 'PAGADO', NULL, 182, 449.10000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (491, 3, '2012-01-08 05:11:56', 6, 'dolor. Fusce', 'PAGADO', NULL, 168, 801.04000, 44);
INSERT INTO unc_248557.wireless_comprobante VALUES (492, 1, '2016-11-02 00:00:00', 4, 'lorem, auctor quis,', NULL, '2016-11-12 00:00:00', NULL, 188.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (494, 2, '2007-10-20 00:00:00', 13, 'Vivamus sit amet', NULL, NULL, NULL, 0.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (497, 3, '2000-01-31 15:08:14', 21, 'et', 'PAGADO', NULL, 73, 45.30000, 73);
INSERT INTO unc_248557.wireless_comprobante VALUES (498, 1, '2017-06-02 00:00:00', 10, 'lectus. Cum sociis', NULL, '2017-06-12 00:00:00', NULL, 75.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (499, 3, '2010-04-19 04:53:03', 10, 'ut eros', 'PAGADO', NULL, 112, 785.77000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (500, 1, '2003-07-25 00:00:00', 7, 'porttitor tellus', NULL, '2003-08-04 00:00:00', NULL, 173.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (503, 3, '2014-05-15 02:47:06', 5, 'eu', 'PAGADO', NULL, 148, 772.03000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (510, 1, '2016-09-14 00:00:00', 19, 'non, egestas', NULL, '2016-09-24 00:00:00', NULL, 8.00000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (516, 3, '2012-09-29 06:32:47', 14, 'Nam', 'PAGADO', NULL, 164, 540.24000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (518, 2, '2012-12-28 00:00:00', 17, 'pharetra. Nam ac', NULL, NULL, NULL, 0.00000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (519, 3, '2002-08-27 16:14:45', 5, 'Aliquam', 'PAGADO', NULL, 76, 96.40000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (521, 2, '2010-10-28 00:00:00', 4, 'at, nisi.', NULL, NULL, NULL, 0.00000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (522, 3, '2005-05-28 06:47:25', 15, 'erat vitae risus.', 'PAGADO', NULL, 124, 225.88000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (525, 3, '2017-03-19 08:33:56', 1, 'Donec est.', 'PAGADO', NULL, 138, 152.43000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (526, 3, '2009-11-27 11:17:54', 4, 'ante', 'PAGADO', NULL, 170, 163.34000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (527, 3, '2013-08-18 12:28:39', 16, 'Nullam vitae', 'PAGADO', NULL, 31, 869.04000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (528, 1, '2008-02-12 00:00:00', 2, 'dolor. Donec', NULL, '2008-02-22 00:00:00', NULL, 250.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (530, 1, '2002-09-21 00:00:00', 18, 'egestas', NULL, '2002-10-01 00:00:00', NULL, 157.00000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (531, 1, '2012-12-15 00:00:00', 4, 'enim mi tempor', NULL, '2012-12-25 00:00:00', NULL, 74.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (532, 3, '2004-05-18 17:20:08', 1, 'Sed eu', 'PAGADO', NULL, 6, 374.88000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (533, 1, '2004-01-14 00:00:00', 9, 'est.', NULL, '2004-01-24 00:00:00', NULL, 48.00000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (534, 3, '2000-07-25 07:32:16', 18, 'mauris blandit mattis.', 'PAGADO', NULL, 5, 383.88000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (535, 3, '2010-03-09 15:02:26', 16, 'erat semper rutrum.', 'PAGADO', NULL, 122, 390.64000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (536, 1, '2012-05-12 00:00:00', 25, 'ligula eu enim.', NULL, '2012-05-22 00:00:00', NULL, 97.00000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (537, 2, '2011-12-22 00:00:00', 21, 'nisl. Quisque fringilla', NULL, NULL, NULL, 0.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (538, 1, '2013-07-20 00:00:00', 18, 'scelerisque neque. Nullam', NULL, '2013-07-30 00:00:00', NULL, 75.00000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (539, 3, '2008-06-09 02:58:04', 1, 'nibh.', 'PAGADO', NULL, 51, 286.54000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (540, 2, '2009-06-23 00:00:00', 27, 'mollis nec, cursus', NULL, NULL, NULL, 0.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (542, 3, '2014-11-05 20:28:47', 30, 'nulla ante, iaculis', 'PAGADO', NULL, 132, 260.66000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (543, 3, '2015-09-04 08:24:15', 19, 'nisl.', 'PAGADO', NULL, 150, 938.14000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (547, 2, '2005-07-23 00:00:00', 1, 'massa. Vestibulum accumsan', NULL, NULL, NULL, 0.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (548, 3, '2000-08-27 04:22:38', 13, 'Nunc ut', 'PAGADO', NULL, 180, 686.45000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (550, 1, '2000-07-10 00:00:00', 16, 'In ornare sagittis', NULL, '2000-07-20 00:00:00', NULL, 8.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (551, 3, '2016-01-26 07:15:45', 19, 'vestibulum massa rutrum', 'PAGADO', NULL, 62, 279.88000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (552, 3, '2009-12-03 03:54:29', 12, 'Vivamus rhoncus. Donec', 'PAGADO', NULL, 33, 799.48000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (553, 3, '2006-09-04 13:04:32', 19, 'ullamcorper,', 'PAGADO', NULL, 1, 876.75000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (554, 3, '2004-10-01 00:21:26', 3, 'ante', 'PAGADO', NULL, 36, 160.86000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (556, 1, '2013-03-20 00:00:00', 5, 'mi enim, condimentum', NULL, '2013-03-30 00:00:00', NULL, 138.00000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (559, 1, '2007-07-04 00:00:00', 14, 'egestas', NULL, '2007-07-14 00:00:00', NULL, 8.00000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (560, 1, '2007-11-11 00:00:00', 20, 'nulla. Donec non', NULL, '2007-11-21 00:00:00', NULL, 76.00000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (562, 3, '2000-09-03 02:55:45', 17, 'sit amet metus.', 'PAGADO', NULL, 53, 67.47000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (566, 1, '2004-10-27 00:00:00', 4, 'ac orci.', NULL, '2004-11-06 00:00:00', NULL, 59.00000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (567, 1, '2010-08-07 00:00:00', 17, 'amet ultricies sem', NULL, '2010-08-17 00:00:00', NULL, 48.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (568, 3, '2000-08-27 04:22:38', 10, 'Quisque varius.', 'PAGADO', NULL, 180, 338.40000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (570, 3, '2003-07-20 06:52:58', 20, 'mi. Aliquam', 'PAGADO', NULL, 56, 499.83000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (572, 3, '2004-06-25 13:28:59', 26, 'torquent per conubia', 'PAGADO', NULL, 128, 850.59000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (573, 3, '2015-05-26 02:52:02', 19, 'Nunc', 'PAGADO', NULL, 146, 222.38000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (574, 1, '2010-11-01 00:00:00', 20, 'quam a felis', NULL, '2010-11-11 00:00:00', NULL, 93.00000, 74);
INSERT INTO unc_248557.wireless_comprobante VALUES (576, 2, '2006-10-20 00:00:00', 3, 'Nunc', NULL, NULL, NULL, 0.00000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (578, 1, '2010-01-19 00:00:00', 30, 'libero', NULL, '2010-01-29 00:00:00', NULL, 163.00000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (579, 1, '2012-03-28 00:00:00', 15, 'dolor. Fusce feugiat.', NULL, '2012-04-07 00:00:00', NULL, 70.00000, 77);
INSERT INTO unc_248557.wireless_comprobante VALUES (582, 3, '2000-10-13 16:07:49', 9, 'Aliquam adipiscing', 'PAGADO', NULL, 49, 178.23000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (583, 1, '2005-02-15 00:00:00', 8, 'porttitor tellus', NULL, '2005-02-25 00:00:00', NULL, 76.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (585, 3, '2009-12-03 00:54:29', 29, 'Nulla facilisi.', 'PAGADO', NULL, 33, 616.51000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (589, 3, '2008-10-13 14:16:57', 28, 'Aliquam erat volutpat.', 'PAGADO', NULL, 171, 973.11000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (590, 3, '2006-03-13 10:39:03', 11, 'et netus et', 'PAGADO', NULL, 8, 440.29000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (591, 3, '2006-02-18 10:09:35', 11, 'nunc id', 'PAGADO', NULL, 22, 999.50000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (592, 3, '2004-07-23 15:12:47', 7, 'ligula. Nullam', 'PAGADO', NULL, 61, 96.35000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (593, 2, '2014-01-19 00:00:00', 18, 'vulputate dui, nec', NULL, NULL, NULL, 0.00000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (594, 3, '2011-03-22 20:38:24', 28, 'nunc nulla vulputate', 'PAGADO', NULL, 199, 724.21000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (595, 1, '2008-09-20 00:00:00', 9, 'Sed malesuada', NULL, '2008-09-30 00:00:00', NULL, 67.00000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (596, 1, '2013-08-13 00:00:00', 5, 'pharetra. Quisque ac', NULL, '2013-08-23 00:00:00', NULL, 100.00000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (599, 3, '2017-08-11 05:17:36', 8, 'a, scelerisque sed,', 'PAGADO', NULL, 139, 103.62000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (600, 1, '2002-01-15 00:00:00', 28, 'nec ante blandit', NULL, '2002-01-25 00:00:00', NULL, 113.00000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (601, 2, '2002-01-19 00:00:00', 13, 'sociosqu ad litora', NULL, NULL, NULL, 0.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (603, 1, '2006-07-07 00:00:00', 29, 'arcu vel', NULL, '2006-07-17 00:00:00', NULL, 96.00000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (604, 2, '2006-08-26 00:00:00', 5, 'tortor at', NULL, NULL, NULL, 0.00000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (605, 1, '2012-05-09 00:00:00', 19, 'nibh.', NULL, '2012-05-19 00:00:00', NULL, 49.00000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (606, 3, '2001-06-21 09:12:41', 27, 'Fusce mollis.', 'PAGADO', NULL, 75, 669.97000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (607, 1, '2001-01-04 00:00:00', 3, 'In', NULL, '2001-01-14 00:00:00', NULL, 91.00000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (609, 3, '2015-10-16 14:56:33', 11, 'Donec consectetuer', 'PAGADO', NULL, 71, 698.60000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (610, 2, '2011-01-27 00:00:00', 12, 'tellus. Nunc lectus', NULL, NULL, NULL, 0.00000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (611, 3, '2001-04-06 10:07:14', 3, 'Praesent luctus.', 'PAGADO', NULL, 117, 653.70000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (612, 2, '2014-03-04 00:00:00', 11, 'Nullam velit dui,', NULL, NULL, NULL, 0.00000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (613, 3, '2004-06-23 03:23:16', 23, 'vel,', 'PAGADO', NULL, 193, 378.90000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (614, 2, '2013-05-29 00:00:00', 18, 'ante', NULL, NULL, NULL, 0.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (615, 3, '2013-10-09 15:09:12', 12, 'nonummy', 'PAGADO', NULL, 123, 451.06000, 46);
INSERT INTO unc_248557.wireless_comprobante VALUES (616, 3, '2015-05-22 13:04:21', 21, 'neque pellentesque massa', 'PAGADO', NULL, 101, 630.16000, 62);
INSERT INTO unc_248557.wireless_comprobante VALUES (618, 1, '2016-04-28 00:00:00', 16, 'massa.', NULL, '2016-05-08 00:00:00', NULL, 267.00000, 83);
INSERT INTO unc_248557.wireless_comprobante VALUES (619, 3, '2012-05-04 04:58:17', 1, 'enim.', 'PAGADO', NULL, 78, 347.40000, 80);
INSERT INTO unc_248557.wireless_comprobante VALUES (620, 1, '2001-01-18 00:00:00', 12, 'viverra.', NULL, '2001-01-28 00:00:00', NULL, 75.00000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (622, 1, '2003-09-17 00:00:00', 29, 'blandit', NULL, '2003-09-27 00:00:00', NULL, 70.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (624, 1, '2009-03-26 00:00:00', 12, 'nibh. Donec', NULL, '2009-04-05 00:00:00', NULL, 5.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (628, 1, '2014-01-25 00:00:00', 4, 'semper cursus.', NULL, '2014-02-04 00:00:00', NULL, 44.00000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (631, 2, '2013-08-18 00:00:00', 4, 'ac orci. Ut', NULL, NULL, NULL, 0.00000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (635, 3, '2001-05-29 04:03:08', 2, 'in faucibus orci', 'PAGADO', NULL, 46, 595.96000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (636, 1, '2016-10-29 00:00:00', 14, 'Curabitur ut', NULL, '2016-11-08 00:00:00', NULL, 89.00000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (637, 3, '2004-05-18 21:20:08', 14, 'in, tempus eu,', 'PAGADO', NULL, 6, 482.34000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (644, 1, '2006-09-05 00:00:00', 25, 'lacinia vitae,', NULL, '2006-09-15 00:00:00', NULL, 17.00000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (645, 3, '2011-05-12 05:07:50', 22, 'imperdiet non, vestibulum', 'PAGADO', NULL, 17, 691.36000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (646, 1, '2002-04-09 00:00:00', 23, 'egestas hendrerit', NULL, '2002-04-19 00:00:00', NULL, 44.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (648, 3, '2003-04-06 21:56:54', 29, 'pretium', 'PAGADO', NULL, 68, 848.59000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (649, 3, '2015-01-09 05:49:17', 15, 'lacinia. Sed congue,', 'PAGADO', NULL, 58, 805.33000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (650, 3, '2015-02-18 19:36:19', 22, 'ultrices, mauris', 'PAGADO', NULL, 141, 837.10000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (651, 3, '2015-02-02 21:59:28', 21, 'velit eu sem.', 'PAGADO', NULL, 119, 145.92000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (653, 1, '2003-08-08 00:00:00', 23, 'dapibus quam', NULL, '2003-08-18 00:00:00', NULL, 16.00000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (659, 3, '2011-05-27 17:20:47', 13, 'magna', 'PAGADO', NULL, 84, 62.73000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (661, 1, '2000-07-05 00:00:00', 17, 'ac urna. Ut', NULL, '2000-07-15 00:00:00', NULL, 104.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (663, 3, '2011-04-17 04:00:44', 26, 'ornare.', 'PAGADO', NULL, 85, 605.91000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (664, 3, '2000-01-31 17:08:14', 28, 'a feugiat tellus', 'PAGADO', NULL, 73, 212.11000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (665, 3, '2004-05-18 15:20:08', 16, 'mus.', 'PAGADO', NULL, 6, 86.75000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (667, 2, '2007-05-14 00:00:00', 4, 'ipsum. Suspendisse non', NULL, NULL, NULL, 0.00000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (668, 3, '2006-07-18 09:37:26', 19, 'eu tellus', 'PAGADO', NULL, 28, 382.82000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (671, 1, '2011-04-08 00:00:00', 18, 'rhoncus.', NULL, '2011-04-18 00:00:00', NULL, 85.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (674, 2, '2013-01-10 00:00:00', 5, 'in, tempus', NULL, NULL, NULL, 0.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (675, 1, '2012-12-22 00:00:00', 5, 'mauris erat eget', NULL, '2013-01-01 00:00:00', NULL, 99.00000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (676, 3, '2008-11-23 04:52:18', 30, 'eu,', 'PAGADO', NULL, 23, 894.32000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (677, 1, '2009-07-27 00:00:00', 8, 'commodo', NULL, '2009-08-06 00:00:00', NULL, 329.00000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (681, 1, '2004-11-21 00:00:00', 5, 'Nunc', NULL, '2004-12-01 00:00:00', NULL, 52.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (682, 3, '2001-12-09 12:45:13', 22, 'elit. Curabitur sed', 'PAGADO', NULL, 77, 779.98000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (684, 3, '2015-07-26 14:27:45', 25, 'erat. Vivamus nisi.', 'PAGADO', NULL, 183, 457.95000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (691, 1, '2006-01-23 00:00:00', 16, 'vel', NULL, '2006-02-02 00:00:00', NULL, 78.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (693, 3, '2003-04-27 09:41:15', 16, 'tincidunt', 'PAGADO', NULL, 45, 890.85000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (695, 3, '2006-07-17 16:59:53', 25, 'ac turpis', 'PAGADO', NULL, 143, 646.53000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (696, 1, '2010-09-19 00:00:00', 15, 'magna a neque.', NULL, '2010-09-29 00:00:00', NULL, 80.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (700, 3, '2009-01-02 04:52:05', 29, 'malesuada vel,', 'PAGADO', NULL, 3, 423.06000, 77);
INSERT INTO unc_248557.wireless_comprobante VALUES (702, 2, '2013-05-28 00:00:00', 10, 'fames', NULL, NULL, NULL, 0.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (703, 2, '2009-10-05 00:00:00', 9, 'sociis natoque penatibus', NULL, NULL, NULL, 0.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (705, 3, '2009-08-04 02:49:03', 28, 'tincidunt pede ac', 'PAGADO', NULL, 163, 829.03000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (706, 3, '2009-01-01 22:52:05', 21, 'velit', 'PAGADO', NULL, 3, 764.61000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (707, 3, '2001-06-09 13:32:36', 2, 'molestie. Sed id', 'PAGADO', NULL, 114, 213.00000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (709, 3, '2000-10-23 11:56:12', 10, 'at, libero.', 'PAGADO', NULL, 155, 996.49000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (710, 2, '2012-11-02 00:00:00', 5, 'eu', NULL, NULL, NULL, 0.00000, 53);
INSERT INTO unc_248557.wireless_comprobante VALUES (712, 1, '2003-06-07 00:00:00', 28, 'augue', NULL, '2003-06-17 00:00:00', NULL, 131.00000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (714, 3, '2009-01-02 00:52:05', 6, 'et', 'PAGADO', NULL, 3, 73.52000, 59);
INSERT INTO unc_248557.wireless_comprobante VALUES (716, 1, '2012-04-10 00:00:00', 16, 'sodales elit erat', NULL, '2012-04-20 00:00:00', NULL, 81.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (719, 1, '2016-11-13 00:00:00', 23, 'massa lobortis', NULL, '2016-11-23 00:00:00', NULL, 134.00000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (721, 3, '2000-09-03 01:55:45', 22, 'sociis natoque', 'PAGADO', NULL, 53, 306.62000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (723, 3, '2011-05-27 12:20:47', 14, 'fermentum arcu.', 'PAGADO', NULL, 84, 168.86000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (724, 1, '2006-12-17 00:00:00', 23, 'Morbi accumsan laoreet', NULL, '2006-12-27 00:00:00', NULL, 4.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (725, 2, '2000-11-14 00:00:00', 16, 'erat semper', NULL, NULL, NULL, 0.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (726, 3, '2003-07-20 03:52:58', 17, 'aliquam', 'PAGADO', NULL, 56, 991.36000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (727, 3, '2000-10-10 11:50:43', 6, 'erat', 'PAGADO', NULL, 83, 530.91000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (729, 3, '2004-07-24 12:04:16', 4, 'Vivamus molestie', 'PAGADO', NULL, 127, 552.21000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (730, 3, '2017-08-11 05:17:36', 27, 'aliquam, enim nec', 'PAGADO', NULL, 139, 665.71000, 93);
INSERT INTO unc_248557.wireless_comprobante VALUES (733, 1, '2008-01-10 00:00:00', 12, 'lorem,', NULL, '2008-01-20 00:00:00', NULL, 168.00000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (734, 1, '2013-11-25 00:00:00', 12, 'Aliquam auctor, velit', NULL, '2013-12-05 00:00:00', NULL, 58.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (736, 1, '2002-04-02 00:00:00', 18, 'netus et malesuada', NULL, '2002-04-12 00:00:00', NULL, 20.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (738, 3, '2008-06-09 00:58:04', 23, 'sodales.', 'PAGADO', NULL, 51, 223.56000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (742, 2, '2008-12-05 00:00:00', 7, 'semper rutrum. Fusce', NULL, NULL, NULL, 0.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (744, 1, '2000-10-05 00:00:00', 21, 'litora torquent per', NULL, '2000-10-15 00:00:00', NULL, 76.00000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (746, 3, '2011-02-21 15:27:30', 8, 'at lacus.', 'PAGADO', NULL, 104, 949.51000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (749, 3, '2002-11-03 01:23:41', 28, 'suscipit,', 'PAGADO', NULL, 55, 742.04000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (750, 1, '2006-09-25 00:00:00', 12, 'Vivamus', NULL, '2006-10-05 00:00:00', NULL, 81.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (752, 2, '2001-07-23 00:00:00', 5, 'dictum', NULL, NULL, NULL, 0.00000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (753, 1, '2013-11-15 00:00:00', 5, 'mauris. Suspendisse', NULL, '2013-11-25 00:00:00', NULL, 115.00000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (755, 1, '2005-04-08 00:00:00', 30, 'magnis dis', NULL, '2005-04-18 00:00:00', NULL, 2.00000, 82);
INSERT INTO unc_248557.wireless_comprobante VALUES (756, 3, '2002-09-30 08:21:54', 20, 'diam. Pellentesque habitant', 'PAGADO', NULL, 29, 491.48000, 57);
INSERT INTO unc_248557.wireless_comprobante VALUES (757, 3, '2008-12-15 01:39:09', 30, 'rhoncus. Proin', 'PAGADO', NULL, 173, 312.50000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (758, 3, '2002-10-16 03:52:40', 3, 'elementum', 'PAGADO', NULL, 120, 188.92000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (759, 1, '2003-09-30 00:00:00', 5, 'molestie pharetra', NULL, '2003-10-10 00:00:00', NULL, 126.00000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (761, 3, '2001-06-21 12:12:41', 11, 'Nunc commodo', 'PAGADO', NULL, 75, 705.09000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (763, 1, '2012-03-18 00:00:00', 8, 'ac', NULL, '2012-03-28 00:00:00', NULL, 85.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (766, 1, '2011-08-15 00:00:00', 30, 'nonummy ut,', NULL, '2011-08-25 00:00:00', NULL, 20.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (769, 3, '2007-03-29 05:56:40', 11, 'Nam', 'PAGADO', NULL, 15, 548.89000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (771, 1, '2005-08-01 00:00:00', 2, 'vestibulum,', NULL, '2005-08-11 00:00:00', NULL, 154.00000, 78);
INSERT INTO unc_248557.wireless_comprobante VALUES (772, 2, '2015-01-03 00:00:00', 9, 'a,', NULL, NULL, NULL, 0.00000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (779, 1, '2010-01-14 00:00:00', 1, 'tempus mauris', NULL, '2010-01-24 00:00:00', NULL, 26.00000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (780, 1, '2005-11-04 00:00:00', 16, 'risus. Duis', NULL, '2005-11-14 00:00:00', NULL, 69.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (782, 3, '2015-01-09 07:49:17', 16, 'malesuada augue ut', 'PAGADO', NULL, 58, 754.24000, 99);
INSERT INTO unc_248557.wireless_comprobante VALUES (783, 3, '2013-10-09 16:09:12', 9, 'lobortis.', 'PAGADO', NULL, 123, 703.96000, 81);
INSERT INTO unc_248557.wireless_comprobante VALUES (784, 3, '2001-12-09 07:45:13', 29, 'augue', 'PAGADO', NULL, 77, 93.55000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (785, 2, '2012-11-28 00:00:00', 23, 'placerat, orci', NULL, NULL, NULL, 0.00000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (788, 3, '2001-04-06 13:07:14', 24, 'est.', 'PAGADO', NULL, 117, 457.95000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (789, 3, '2008-09-04 16:08:51', 1, 'vel nisl. Quisque', 'PAGADO', NULL, 65, 602.49000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (790, 3, '2008-11-23 06:52:18', 5, 'euismod enim.', 'PAGADO', NULL, 23, 356.25000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (791, 3, '2015-07-29 21:08:26', 17, 'molestie sodales.', 'PAGADO', NULL, 27, 550.34000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (792, 3, '2003-03-13 03:47:26', 8, 'justo eu', 'PAGADO', NULL, 118, 703.76000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (793, 3, '2015-01-13 03:18:58', 19, 'risus', 'PAGADO', NULL, 63, 200.52000, 72);
INSERT INTO unc_248557.wireless_comprobante VALUES (797, 1, '2010-07-22 00:00:00', 15, 'nisi', NULL, '2010-08-01 00:00:00', NULL, 153.00000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (799, 1, '2004-10-30 00:00:00', 1, 'tincidunt. Donec', NULL, '2004-11-09 00:00:00', NULL, 9.00000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (800, 1, '2001-06-17 00:00:00', 19, 'Duis', NULL, '2001-06-27 00:00:00', NULL, 73.00000, 85);
INSERT INTO unc_248557.wireless_comprobante VALUES (801, 3, '2000-02-01 22:44:07', 18, 'Mauris quis turpis', 'PAGADO', NULL, 94, 860.60000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (802, 1, '2007-03-23 00:00:00', 20, 'id, libero. Donec', NULL, '2007-04-02 00:00:00', NULL, 9.00000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (803, 3, '2001-05-19 16:47:50', 19, 'tristique senectus et', 'PAGADO', NULL, 197, 54.39000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (804, 2, '2007-08-28 00:00:00', 19, 'dapibus ligula.', NULL, NULL, NULL, 0.00000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (805, 2, '2009-02-01 00:00:00', 12, 'massa.', NULL, NULL, NULL, 0.00000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (806, 1, '2003-04-27 00:00:00', 28, 'elit', NULL, '2003-05-07 00:00:00', NULL, 83.00000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (807, 3, '2015-02-03 02:59:28', 10, 'ut mi.', 'PAGADO', NULL, 119, 849.49000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (808, 2, '2012-05-19 00:00:00', 19, 'Quisque imperdiet,', NULL, NULL, NULL, 0.00000, 91);
INSERT INTO unc_248557.wireless_comprobante VALUES (809, 1, '2003-01-14 00:00:00', 21, 'Aenean eget metus.', NULL, '2003-01-24 00:00:00', NULL, 82.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (811, 1, '2002-03-09 00:00:00', 20, 'vitae', NULL, '2002-03-19 00:00:00', NULL, 50.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (812, 3, '2008-09-04 11:08:51', 29, 'Nulla tempor augue', 'PAGADO', NULL, 65, 770.96000, 77);
INSERT INTO unc_248557.wireless_comprobante VALUES (813, 3, '2006-02-18 04:09:35', 8, 'sagittis', 'PAGADO', NULL, 22, 540.69000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (814, 3, '2002-12-16 09:11:45', 29, 'et', 'PAGADO', NULL, 108, 65.53000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (815, 1, '2008-09-15 00:00:00', 11, 'feugiat placerat', NULL, '2008-09-25 00:00:00', NULL, 151.00000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (818, 1, '2009-03-27 00:00:00', 17, 'Integer vulputate, risus', NULL, '2009-04-06 00:00:00', NULL, 86.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (819, 1, '2013-03-11 00:00:00', 3, 'Mauris molestie', NULL, '2013-03-21 00:00:00', NULL, 72.00000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (824, 3, '2002-11-06 20:33:02', 1, 'nascetur', 'PAGADO', NULL, 190, 802.73000, 64);
INSERT INTO unc_248557.wireless_comprobante VALUES (825, 3, '2001-02-22 05:03:45', 5, 'Aliquam', 'PAGADO', NULL, 96, 775.88000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (826, 2, '2009-04-12 00:00:00', 13, 'turpis non', NULL, NULL, NULL, 0.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (828, 3, '2001-05-19 11:47:50', 5, 'pellentesque.', 'PAGADO', NULL, 197, 602.69000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (831, 1, '2017-08-11 00:00:00', 1, 'mollis. Phasellus libero', NULL, '2017-08-21 00:00:00', NULL, 189.00000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (832, 1, '2009-04-06 00:00:00', 24, 'dapibus ligula.', NULL, '2009-04-16 00:00:00', NULL, 193.00000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (833, 3, '2006-05-07 09:15:44', 18, 'quam. Pellentesque', 'PAGADO', NULL, 48, 631.37000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (835, 2, '2005-02-03 00:00:00', 5, 'orci', NULL, NULL, NULL, 0.00000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (837, 3, '2013-04-20 15:34:54', 19, 'purus, accumsan interdum', 'PAGADO', NULL, 38, 538.95000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (838, 3, '2014-04-30 14:27:05', 29, 'eleifend nec,', 'PAGADO', NULL, 182, 115.09000, 34);
INSERT INTO unc_248557.wireless_comprobante VALUES (840, 1, '2012-10-26 00:00:00', 28, 'et ultrices posuere', NULL, '2012-11-05 00:00:00', NULL, 54.00000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (843, 1, '2007-01-21 00:00:00', 1, 'sed dolor.', NULL, '2007-01-31 00:00:00', NULL, 22.00000, 87);
INSERT INTO unc_248557.wireless_comprobante VALUES (844, 3, '2000-10-13 16:07:49', 6, 'feugiat', 'PAGADO', NULL, 49, 530.46000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (846, 1, '2010-11-09 00:00:00', 13, 'commodo ipsum.', NULL, '2010-11-19 00:00:00', NULL, 39.00000, 41);
INSERT INTO unc_248557.wireless_comprobante VALUES (847, 3, '2009-04-06 01:03:58', 9, 'fringilla', 'PAGADO', NULL, 186, 29.59000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (848, 1, '2012-05-23 00:00:00', 16, 'nulla. Donec', NULL, '2012-06-02 00:00:00', NULL, 22.00000, 38);
INSERT INTO unc_248557.wireless_comprobante VALUES (850, 3, '2004-05-18 19:20:08', 29, 'eu, placerat', 'PAGADO', NULL, 6, 788.72000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (852, 3, '2014-11-05 15:28:47', 6, 'ipsum dolor sit', 'PAGADO', NULL, 132, 407.74000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (853, 3, '2015-10-05 09:27:01', 6, 'eu eros.', 'PAGADO', NULL, 151, 156.61000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (854, 3, '2008-05-23 21:37:58', 23, 'est.', 'PAGADO', NULL, 158, 925.25000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (858, 3, '2006-02-18 09:09:35', 11, 'laoreet, libero', 'PAGADO', NULL, 22, 648.02000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (859, 1, '2002-08-29 00:00:00', 14, 'ultricies ornare, elit', NULL, '2002-09-08 00:00:00', NULL, 109.00000, 68);
INSERT INTO unc_248557.wireless_comprobante VALUES (860, 3, '2011-10-31 22:18:21', 11, 'eu dolor', 'PAGADO', NULL, 97, 474.54000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (861, 3, '2002-04-19 16:51:24', 5, 'ligula. Donec', 'PAGADO', NULL, 89, 488.27000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (862, 3, '2004-06-16 19:15:44', 3, 'orci, in', 'PAGADO', NULL, 149, 20.80000, 94);
INSERT INTO unc_248557.wireless_comprobante VALUES (863, 1, '2008-06-09 00:00:00', 6, 'ante lectus', NULL, '2008-06-19 00:00:00', NULL, 15.00000, 86);
INSERT INTO unc_248557.wireless_comprobante VALUES (864, 3, '2002-08-27 19:14:45', 15, 'et, magna. Praesent', 'PAGADO', NULL, 76, 560.43000, 71);
INSERT INTO unc_248557.wireless_comprobante VALUES (870, 1, '2014-03-26 00:00:00', 26, 'lacus. Etiam', NULL, '2014-04-05 00:00:00', NULL, 43.00000, 89);
INSERT INTO unc_248557.wireless_comprobante VALUES (871, 3, '2011-05-27 18:20:47', 5, 'orci', 'PAGADO', NULL, 84, 193.18000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (872, 3, '2012-12-26 08:58:48', 3, 'elit,', 'PAGADO', NULL, 135, 494.66000, 67);
INSERT INTO unc_248557.wireless_comprobante VALUES (873, 3, '2000-01-31 19:08:14', 22, 'fermentum', 'PAGADO', NULL, 73, 117.05000, 47);
INSERT INTO unc_248557.wireless_comprobante VALUES (874, 1, '2000-05-10 00:00:00', 16, 'cubilia', NULL, '2000-05-20 00:00:00', NULL, 111.00000, 80);
INSERT INTO unc_248557.wireless_comprobante VALUES (875, 3, '2000-02-02 02:44:07', 8, 'dictum magna. Ut', 'PAGADO', NULL, 94, 657.38000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (876, 2, '2012-08-09 00:00:00', 4, 'mauris', NULL, NULL, NULL, 0.00000, 43);
INSERT INTO unc_248557.wireless_comprobante VALUES (877, 3, '2008-10-31 15:12:07', 28, 'ut', 'PAGADO', NULL, 21, 481.23000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (878, 3, '2015-02-20 17:13:34', 12, 'tincidunt nibh. Phasellus', 'PAGADO', NULL, 130, 686.87000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (880, 1, '2011-09-06 00:00:00', 10, 'Duis', NULL, '2011-09-16 00:00:00', NULL, 78.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (881, 1, '2008-05-13 00:00:00', 24, 'Aliquam', NULL, '2008-05-23 00:00:00', NULL, 100.00000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (883, 3, '2003-03-13 00:47:26', 10, 'non, dapibus', 'PAGADO', NULL, 118, 870.69000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (885, 1, '2017-07-13 00:00:00', 7, 'Donec egestas.', NULL, '2017-07-23 00:00:00', NULL, 22.00000, 74);
INSERT INTO unc_248557.wireless_comprobante VALUES (886, 3, '2017-03-19 05:33:56', 16, 'Nunc', 'PAGADO', NULL, 138, 620.10000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (889, 1, '2012-02-21 00:00:00', 2, 'Vivamus euismod', NULL, '2012-03-02 00:00:00', NULL, 94.00000, 35);
INSERT INTO unc_248557.wireless_comprobante VALUES (890, 3, '2014-06-26 08:46:16', 7, 'mus. Donec', 'PAGADO', NULL, 115, 460.62000, 100);
INSERT INTO unc_248557.wireless_comprobante VALUES (894, 3, '2015-01-09 09:49:17', 14, 'dignissim magna a', 'PAGADO', NULL, 58, 198.42000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (895, 2, '2001-09-13 00:00:00', 11, 'dui. Cras', NULL, NULL, NULL, 0.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (896, 3, '2009-12-02 21:54:29', 10, 'Quisque nonummy', 'PAGADO', NULL, 33, 842.05000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (897, 3, '2009-01-02 02:52:05', 2, 'lacinia vitae,', 'PAGADO', NULL, 3, 118.38000, 56);
INSERT INTO unc_248557.wireless_comprobante VALUES (898, 2, '2005-09-08 00:00:00', 28, 'Phasellus', NULL, NULL, NULL, 0.00000, 88);
INSERT INTO unc_248557.wireless_comprobante VALUES (899, 3, '2001-05-19 09:47:50', 17, 'bibendum. Donec', 'PAGADO', NULL, 197, 788.68000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (903, 1, '2000-09-25 00:00:00', 17, 'erat eget ipsum.', NULL, '2000-10-05 00:00:00', NULL, 148.00000, 61);
INSERT INTO unc_248557.wireless_comprobante VALUES (906, 1, '2003-06-01 00:00:00', 8, 'rhoncus. Nullam', NULL, '2003-06-11 00:00:00', NULL, 73.00000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (907, 3, '2009-03-04 05:49:28', 25, 'orci. Ut sagittis', 'PAGADO', NULL, 152, 375.49000, 72);
INSERT INTO unc_248557.wireless_comprobante VALUES (908, 1, '2007-09-13 00:00:00', 1, 'tempus', NULL, '2007-09-23 00:00:00', NULL, 99.00000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (911, 1, '2016-06-18 00:00:00', 11, 'cursus, diam', NULL, '2016-06-28 00:00:00', NULL, 111.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (912, 2, '2006-09-26 00:00:00', 10, 'et ultrices', NULL, NULL, NULL, 0.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (913, 1, '2001-01-19 00:00:00', 4, 'enim. Mauris quis', NULL, '2001-01-29 00:00:00', NULL, 62.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (916, 2, '2002-04-09 00:00:00', 4, 'tincidunt tempus', NULL, NULL, NULL, 0.00000, 92);
INSERT INTO unc_248557.wireless_comprobante VALUES (917, 3, '2006-07-18 09:37:26', 6, 'aliquet, metus urna', 'PAGADO', NULL, 28, 243.32000, 33);
INSERT INTO unc_248557.wireless_comprobante VALUES (920, 2, '2016-12-15 00:00:00', 30, 'Suspendisse', NULL, NULL, NULL, 0.00000, 51);
INSERT INTO unc_248557.wireless_comprobante VALUES (921, 1, '2006-06-16 00:00:00', 24, 'eget nisi', NULL, '2006-06-26 00:00:00', NULL, 3.00000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (922, 1, '2001-04-07 00:00:00', 9, 'lectus,', NULL, '2001-04-17 00:00:00', NULL, 100.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (923, 3, '2002-11-06 19:33:02', 15, 'condimentum. Donec', 'PAGADO', NULL, 190, 908.80000, 73);
INSERT INTO unc_248557.wireless_comprobante VALUES (926, 2, '2014-09-18 00:00:00', 24, 'elit. Aliquam auctor,', NULL, NULL, NULL, 0.00000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (927, 1, '2007-09-11 00:00:00', 30, 'Nulla', NULL, '2007-09-21 00:00:00', NULL, 187.00000, 45);
INSERT INTO unc_248557.wireless_comprobante VALUES (928, 1, '2003-09-02 00:00:00', 28, 'mollis dui, in', NULL, '2003-09-12 00:00:00', NULL, 119.00000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (933, 3, '2015-01-09 02:49:17', 29, 'Integer tincidunt aliquam', 'PAGADO', NULL, 58, 462.34000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (934, 3, '2000-03-17 03:59:04', 2, 'risus. Quisque libero', 'PAGADO', NULL, 66, 932.99000, 80);
INSERT INTO unc_248557.wireless_comprobante VALUES (936, 3, '2014-05-15 03:47:06', 19, 'lorem, vehicula', 'PAGADO', NULL, 148, 710.28000, 96);
INSERT INTO unc_248557.wireless_comprobante VALUES (940, 1, '2007-05-03 00:00:00', 10, 'Donec', NULL, '2007-05-13 00:00:00', NULL, 27.00000, 39);
INSERT INTO unc_248557.wireless_comprobante VALUES (941, 3, '2014-06-26 12:46:16', 5, 'purus. Maecenas', 'PAGADO', NULL, 115, 341.34000, 58);
INSERT INTO unc_248557.wireless_comprobante VALUES (942, 3, '2014-03-17 16:49:35', 9, 'Integer', 'PAGADO', NULL, 184, 30.06000, 40);
INSERT INTO unc_248557.wireless_comprobante VALUES (943, 2, '2015-11-24 00:00:00', 17, 'metus.', NULL, NULL, NULL, 0.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (946, 3, '2000-11-05 07:57:42', 9, 'Morbi accumsan', 'PAGADO', NULL, 79, 860.02000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (947, 1, '2007-10-21 00:00:00', 14, 'malesuada augue', NULL, '2007-10-31 00:00:00', NULL, 79.00000, 75);
INSERT INTO unc_248557.wireless_comprobante VALUES (948, 1, '2016-07-23 00:00:00', 15, 'vulputate dui,', NULL, '2016-08-02 00:00:00', NULL, 94.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (949, 3, '2001-05-19 13:47:50', 15, 'elit, dictum', 'PAGADO', NULL, 197, 371.77000, 52);
INSERT INTO unc_248557.wireless_comprobante VALUES (950, 1, '2008-11-25 00:00:00', 29, 'in faucibus orci', NULL, '2008-12-05 00:00:00', NULL, 214.00000, 42);
INSERT INTO unc_248557.wireless_comprobante VALUES (953, 1, '2005-08-05 00:00:00', 25, 'lacinia. Sed congue,', NULL, '2005-08-15 00:00:00', NULL, 46.00000, 36);
INSERT INTO unc_248557.wireless_comprobante VALUES (954, 3, '2016-09-07 01:30:05', 3, 'id, blandit', 'PAGADO', NULL, 95, 352.49000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (955, 1, '2003-11-14 00:00:00', 23, 'mi', NULL, '2003-11-24 00:00:00', NULL, 118.00000, 95);
INSERT INTO unc_248557.wireless_comprobante VALUES (956, 3, '2010-11-10 18:20:50', 4, 'tincidunt', 'PAGADO', NULL, 131, 437.84000, 90);
INSERT INTO unc_248557.wireless_comprobante VALUES (957, 1, '2000-10-18 00:00:00', 7, 'vestibulum', NULL, '2000-10-28 00:00:00', NULL, 117.00000, 50);
INSERT INTO unc_248557.wireless_comprobante VALUES (958, 3, '2004-07-24 10:04:16', 20, 'ac', 'PAGADO', NULL, 127, 286.54000, 80);
INSERT INTO unc_248557.wireless_comprobante VALUES (960, 1, '2005-08-18 00:00:00', 7, 'Donec consectetuer', NULL, '2005-08-28 00:00:00', NULL, 104.00000, 63);
INSERT INTO unc_248557.wireless_comprobante VALUES (961, 1, '2006-04-25 00:00:00', 26, 'nec, eleifend non,', NULL, '2006-05-05 00:00:00', NULL, 47.00000, 37);
INSERT INTO unc_248557.wireless_comprobante VALUES (962, 3, '2015-09-04 08:24:15', 30, 'erat vitae', 'PAGADO', NULL, 150, 550.98000, 32);
INSERT INTO unc_248557.wireless_comprobante VALUES (963, 3, '2014-04-30 08:27:05', 17, 'nibh. Phasellus', 'PAGADO', NULL, 182, 429.68000, 46);
INSERT INTO unc_248557.wireless_comprobante VALUES (965, 3, '2000-06-10 09:00:13', 8, 'cursus', 'PAGADO', NULL, 54, 674.39000, 55);
INSERT INTO unc_248557.wireless_comprobante VALUES (966, 2, '2014-01-31 00:00:00', 10, 'nec, cursus', NULL, NULL, NULL, 0.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (968, 1, '2007-01-28 00:00:00', 18, 'ante bibendum', NULL, '2007-02-07 00:00:00', NULL, 75.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (969, 1, '2012-11-20 00:00:00', 6, 'Proin', NULL, '2012-11-30 00:00:00', NULL, 46.00000, 70);
INSERT INTO unc_248557.wireless_comprobante VALUES (970, 1, '2017-08-09 00:00:00', 28, 'ullamcorper.', NULL, '2017-08-19 00:00:00', NULL, 88.00000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (971, 1, '2008-01-15 00:00:00', 27, 'et nunc. Quisque', NULL, '2008-01-25 00:00:00', NULL, 13.00000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (972, 3, '2006-01-25 11:52:45', 29, 'ligula consectetuer', 'PAGADO', NULL, 167, 277.34000, 31);
INSERT INTO unc_248557.wireless_comprobante VALUES (973, 2, '2008-03-05 00:00:00', 23, 'posuere vulputate,', NULL, NULL, NULL, 0.00000, 49);
INSERT INTO unc_248557.wireless_comprobante VALUES (975, 1, '2007-02-17 00:00:00', 17, 'Aenean', NULL, '2007-02-27 00:00:00', NULL, 23.00000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (977, 1, '2012-09-02 00:00:00', 28, 'at, libero. Morbi', NULL, '2012-09-12 00:00:00', NULL, 145.00000, 60);
INSERT INTO unc_248557.wireless_comprobante VALUES (978, 3, '2000-07-25 07:32:16', 9, 'libero lacus, varius', 'PAGADO', NULL, 5, 904.75000, 54);
INSERT INTO unc_248557.wireless_comprobante VALUES (980, 1, '2010-04-28 00:00:00', 4, 'odio sagittis semper.', NULL, '2010-05-08 00:00:00', NULL, 74.00000, 98);
INSERT INTO unc_248557.wireless_comprobante VALUES (982, 3, '2001-07-12 06:39:35', 13, 'sapien. Aenean massa.', 'PAGADO', NULL, 189, 344.20000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (984, 3, '2009-01-02 02:52:05', 21, 'nonummy. Fusce', 'PAGADO', NULL, 3, 160.53000, 79);
INSERT INTO unc_248557.wireless_comprobante VALUES (985, 1, '2007-07-15 00:00:00', 24, 'luctus lobortis. Class', NULL, '2007-07-25 00:00:00', NULL, 123.00000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (986, 1, '2006-11-14 00:00:00', 28, 'mi eleifend egestas.', NULL, '2006-11-24 00:00:00', NULL, 246.00000, 66);
INSERT INTO unc_248557.wireless_comprobante VALUES (987, 2, '2010-04-11 00:00:00', 10, 'Proin non massa', NULL, NULL, NULL, 0.00000, 74);
INSERT INTO unc_248557.wireless_comprobante VALUES (988, 3, '2012-03-20 01:41:49', 20, 'eget mollis lectus', 'PAGADO', NULL, 144, 734.39000, 76);
INSERT INTO unc_248557.wireless_comprobante VALUES (990, 3, '2000-05-21 06:42:34', 13, 'Maecenas iaculis aliquet', 'PAGADO', NULL, 160, 957.53000, 69);
INSERT INTO unc_248557.wireless_comprobante VALUES (991, 2, '2006-12-28 00:00:00', 6, 'risus. Nulla eget', NULL, NULL, NULL, 0.00000, 48);
INSERT INTO unc_248557.wireless_comprobante VALUES (994, 3, '2001-04-06 10:07:14', 10, 'id sapien. Cras', 'PAGADO', NULL, 117, 231.02000, 65);
INSERT INTO unc_248557.wireless_comprobante VALUES (995, 2, '2016-09-12 00:00:00', 11, 'erat. Vivamus', NULL, NULL, NULL, 0.00000, 97);
INSERT INTO unc_248557.wireless_comprobante VALUES (996, 1, '2001-09-25 00:00:00', 1, 'vestibulum. Mauris magna.', NULL, '2001-10-05 00:00:00', NULL, 94.00000, 84);
INSERT INTO unc_248557.wireless_comprobante VALUES (999, 3, '2004-03-26 17:20:32', 9, 'ornare tortor', 'PAGADO', NULL, 60, 314.25000, 95);


--
-- Data for Name: direccion; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_direccion VALUES (1, 70, '661-1992 Nullam C.', 42, NULL, NULL, 94);
INSERT INTO unc_248557.wireless_direccion VALUES (2, 8, 'Apdo.:793-6886 Duis ', 30, NULL, NULL, 76);
INSERT INTO unc_248557.wireless_direccion VALUES (3, 60, 'Apartado núm.: 243, 3874 Eu Ctra.', 10, NULL, NULL, 10);
INSERT INTO unc_248557.wireless_direccion VALUES (4, 7, 'Apdo.:608-9214 Facilisis. C.', 992, NULL, NULL, 17);
INSERT INTO unc_248557.wireless_direccion VALUES (5, 27, '4865 Nam Calle', 355, NULL, NULL, 2);
INSERT INTO unc_248557.wireless_direccion VALUES (6, 53, 'Apartado núm.: 345, 4274 Eleifend C/', 760, NULL, NULL, 38);
INSERT INTO unc_248557.wireless_direccion VALUES (7, 42, 'Apdo.:986-1023 Penatibus Av.', 940, NULL, NULL, 55);
INSERT INTO unc_248557.wireless_direccion VALUES (8, 48, '399-2901 Adipiscing Carretera', 443, NULL, NULL, 21);
INSERT INTO unc_248557.wireless_direccion VALUES (9, 63, 'Apdo.:265-933 Mauris ', 104, NULL, NULL, 55);
INSERT INTO unc_248557.wireless_direccion VALUES (10, 50, 'Apartado núm.: 568, 3787 Integer ', 919, NULL, NULL, 82);
INSERT INTO unc_248557.wireless_direccion VALUES (11, 34, '282-4534 Fusce C.', 577, NULL, NULL, 58);
INSERT INTO unc_248557.wireless_direccion VALUES (12, 25, '454-3614 Vivamus C.', 574, NULL, NULL, 41);
INSERT INTO unc_248557.wireless_direccion VALUES (13, 56, 'Apartado núm.: 689, 5275 Mauris Avenida', 704, NULL, NULL, 26);
INSERT INTO unc_248557.wireless_direccion VALUES (14, 10, '132-7283 Duis Av.', 564, NULL, NULL, 73);
INSERT INTO unc_248557.wireless_direccion VALUES (15, 56, 'Apartado núm.: 520, 6770 Turpis Av.', 291, NULL, NULL, 87);
INSERT INTO unc_248557.wireless_direccion VALUES (16, 54, '177-3835 Elit, C.', 63, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (17, 84, 'Apdo.:471-3824 Lectus C.', 732, NULL, NULL, 95);
INSERT INTO unc_248557.wireless_direccion VALUES (18, 12, 'Apartado núm.: 599, 3605 Arcu. Avenida', 361, NULL, NULL, 42);
INSERT INTO unc_248557.wireless_direccion VALUES (19, 98, 'Apartado núm.: 505, 5186 Interdum C.', 490, NULL, NULL, 97);
INSERT INTO unc_248557.wireless_direccion VALUES (20, 32, 'Apartado núm.: 299, 4363 Mollis. C.', 290, NULL, NULL, 76);
INSERT INTO unc_248557.wireless_direccion VALUES (21, 71, '5364 Ornare Ctra.', 911, NULL, NULL, 26);
INSERT INTO unc_248557.wireless_direccion VALUES (22, 39, 'Apdo.:488-6979 Leo, Avenida', 781, NULL, NULL, 70);
INSERT INTO unc_248557.wireless_direccion VALUES (23, 38, 'Apartado núm.: 624, 1816 Egestas Avda.', 977, NULL, NULL, 32);
INSERT INTO unc_248557.wireless_direccion VALUES (24, 62, 'Apdo.:324-8327 Convallis, ', 50, NULL, NULL, 36);
INSERT INTO unc_248557.wireless_direccion VALUES (25, 61, '9002 Ut Carretera', 483, NULL, NULL, 74);
INSERT INTO unc_248557.wireless_direccion VALUES (26, 11, '549-1245 Morbi Avenida', 978, NULL, NULL, 81);
INSERT INTO unc_248557.wireless_direccion VALUES (27, 45, '669-9766 Mus. Avda.', 607, NULL, NULL, 30);
INSERT INTO unc_248557.wireless_direccion VALUES (28, 50, 'Apdo.:684-6811 A, C.', 292, NULL, NULL, 19);
INSERT INTO unc_248557.wireless_direccion VALUES (29, 4, '610-8172 Odio. Av.', 343, NULL, NULL, 47);
INSERT INTO unc_248557.wireless_direccion VALUES (30, 73, '9719 Vivamus Calle', 756, NULL, NULL, 19);
INSERT INTO unc_248557.wireless_direccion VALUES (31, 50, '258-7357 Tellus Calle', 635, NULL, NULL, 98);
INSERT INTO unc_248557.wireless_direccion VALUES (32, 59, 'Apdo.:261-2586 Sem Calle', 215, NULL, NULL, 11);
INSERT INTO unc_248557.wireless_direccion VALUES (33, 18, 'Apdo.:291-3805 Cras Avda.', 906, NULL, NULL, 6);
INSERT INTO unc_248557.wireless_direccion VALUES (34, 25, 'Apartado núm.: 908, 2884 Neque. Av.', 29, NULL, NULL, 41);
INSERT INTO unc_248557.wireless_direccion VALUES (35, 60, '9974 Magna C.', 742, NULL, NULL, 76);
INSERT INTO unc_248557.wireless_direccion VALUES (36, 30, 'Apdo.:847-1431 Quisque Avenida', 658, NULL, NULL, 71);
INSERT INTO unc_248557.wireless_direccion VALUES (37, 14, 'Apdo.:677-7916 Neque Carretera', 605, NULL, NULL, 56);
INSERT INTO unc_248557.wireless_direccion VALUES (38, 92, '4894 Semper, ', 357, NULL, NULL, 5);
INSERT INTO unc_248557.wireless_direccion VALUES (39, 22, 'Apartado núm.: 253, 3627 Quisque Carretera', 84, NULL, NULL, 6);
INSERT INTO unc_248557.wireless_direccion VALUES (40, 67, '2280 Elementum Carretera', 320, NULL, NULL, 34);
INSERT INTO unc_248557.wireless_direccion VALUES (41, 40, '6372 Fusce C/', 239, NULL, NULL, 4);
INSERT INTO unc_248557.wireless_direccion VALUES (42, 38, '229-2066 Aliquet ', 921, NULL, NULL, 39);
INSERT INTO unc_248557.wireless_direccion VALUES (43, 4, '9357 Luctus Calle', 61, NULL, NULL, 81);
INSERT INTO unc_248557.wireless_direccion VALUES (44, 68, 'Apartado núm.: 813, 1733 Metus. Avenida', 425, NULL, NULL, 59);
INSERT INTO unc_248557.wireless_direccion VALUES (45, 45, 'Apdo.:103-830 Pede, Avda.', 994, NULL, NULL, 2);
INSERT INTO unc_248557.wireless_direccion VALUES (46, 15, '6341 Ut Calle', 319, NULL, NULL, 80);
INSERT INTO unc_248557.wireless_direccion VALUES (47, 48, 'Apartado núm.: 907, 5719 Ornare. Av.', 548, NULL, NULL, 5);
INSERT INTO unc_248557.wireless_direccion VALUES (48, 81, '4191 Massa Av.', 843, NULL, NULL, 68);
INSERT INTO unc_248557.wireless_direccion VALUES (49, 8, 'Apdo.:746-2773 Amet Av.', 755, NULL, NULL, 9);
INSERT INTO unc_248557.wireless_direccion VALUES (50, 100, 'Apartado núm.: 953, 5123 Ipsum. Avenida', 529, NULL, NULL, 38);
INSERT INTO unc_248557.wireless_direccion VALUES (51, 50, 'Apartado núm.: 293, 416 Erat ', 402, NULL, NULL, 92);
INSERT INTO unc_248557.wireless_direccion VALUES (52, 69, 'Apartado núm.: 439, 2425 Facilisis. C.', 470, NULL, NULL, 69);
INSERT INTO unc_248557.wireless_direccion VALUES (53, 1, '407-9946 Ut Ctra.', 104, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (54, 15, 'Apartado núm.: 701, 3757 Eu, Avda.', 285, NULL, NULL, 6);
INSERT INTO unc_248557.wireless_direccion VALUES (55, 16, 'Apdo.:226-8189 Sed ', 469, NULL, NULL, 31);
INSERT INTO unc_248557.wireless_direccion VALUES (56, 74, 'Apartado núm.: 339, 1764 Ullamcorper. Calle', 858, NULL, NULL, 80);
INSERT INTO unc_248557.wireless_direccion VALUES (57, 21, '2026 Pede, Carretera', 116, NULL, NULL, 4);
INSERT INTO unc_248557.wireless_direccion VALUES (58, 6, '2969 Natoque Av.', 959, NULL, NULL, 14);
INSERT INTO unc_248557.wireless_direccion VALUES (59, 25, 'Apartado núm.: 707, 7708 Non, C.', 498, NULL, NULL, 100);
INSERT INTO unc_248557.wireless_direccion VALUES (60, 59, 'Apartado núm.: 669, 1103 Fringilla C.', 692, NULL, NULL, 2);
INSERT INTO unc_248557.wireless_direccion VALUES (61, 4, '374 Nam Calle', 720, NULL, NULL, 42);
INSERT INTO unc_248557.wireless_direccion VALUES (62, 99, '7189 Sagittis Ctra.', 232, NULL, NULL, 59);
INSERT INTO unc_248557.wireless_direccion VALUES (63, 45, '6888 Vel C.', 108, NULL, NULL, 41);
INSERT INTO unc_248557.wireless_direccion VALUES (64, 66, 'Apdo.:910-5828 Phasellus Av.', 881, NULL, NULL, 32);
INSERT INTO unc_248557.wireless_direccion VALUES (65, 52, 'Apartado núm.: 149, 4906 Elementum Calle', 844, NULL, NULL, 93);
INSERT INTO unc_248557.wireless_direccion VALUES (66, 81, 'Apdo.:691-9692 Metus. C.', 609, NULL, NULL, 26);
INSERT INTO unc_248557.wireless_direccion VALUES (67, 75, 'Apartado núm.: 956, 962 Imperdiet Ctra.', 230, NULL, NULL, 1);
INSERT INTO unc_248557.wireless_direccion VALUES (68, 70, '8992 Nulla. Ctra.', 459, NULL, NULL, 27);
INSERT INTO unc_248557.wireless_direccion VALUES (69, 69, '4563 Suspendisse Avda.', 478, NULL, NULL, 19);
INSERT INTO unc_248557.wireless_direccion VALUES (70, 81, 'Apdo.:647-5949 Egestas Calle', 390, NULL, NULL, 94);
INSERT INTO unc_248557.wireless_direccion VALUES (71, 59, '9705 Vel ', 177, NULL, NULL, 60);
INSERT INTO unc_248557.wireless_direccion VALUES (72, 15, 'Apartado núm.: 222, 1847 Aliquet, Calle', 312, NULL, NULL, 5);
INSERT INTO unc_248557.wireless_direccion VALUES (73, 24, 'Apartado núm.: 556, 1164 Venenatis Carretera', 894, NULL, NULL, 67);
INSERT INTO unc_248557.wireless_direccion VALUES (74, 19, 'Apdo.:590-9825 Sed, Calle', 748, NULL, NULL, 61);
INSERT INTO unc_248557.wireless_direccion VALUES (75, 59, '302-2139 Mauris Carretera', 740, NULL, NULL, 61);
INSERT INTO unc_248557.wireless_direccion VALUES (76, 27, '6587 Integer C/', 105, NULL, NULL, 97);
INSERT INTO unc_248557.wireless_direccion VALUES (77, 58, 'Apartado núm.: 906, 8237 Ultrices. Carretera', 68, NULL, NULL, 1);
INSERT INTO unc_248557.wireless_direccion VALUES (78, 49, '3574 Nisl C/', 230, NULL, NULL, 96);
INSERT INTO unc_248557.wireless_direccion VALUES (79, 20, '820-2920 Laoreet C/', 144, NULL, NULL, 51);
INSERT INTO unc_248557.wireless_direccion VALUES (80, 67, 'Apartado núm.: 911, 3879 Enim Carretera', 711, NULL, NULL, 38);
INSERT INTO unc_248557.wireless_direccion VALUES (81, 23, 'Apdo.:517-7947 Et ', 336, NULL, NULL, 81);
INSERT INTO unc_248557.wireless_direccion VALUES (82, 9, 'Apartado núm.: 523, 4338 Pede Avenida', 808, NULL, NULL, 62);
INSERT INTO unc_248557.wireless_direccion VALUES (83, 91, '4109 Vivamus Avda.', 662, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (84, 95, 'Apartado núm.: 596, 4402 Tortor Carretera', 779, NULL, NULL, 6);
INSERT INTO unc_248557.wireless_direccion VALUES (85, 57, '994 Aliquam Ctra.', 107, NULL, NULL, 58);
INSERT INTO unc_248557.wireless_direccion VALUES (86, 13, '4162 Nullam Avda.', 18, NULL, NULL, 57);
INSERT INTO unc_248557.wireless_direccion VALUES (87, 51, '7516 Consectetuer Avda.', 817, NULL, NULL, 18);
INSERT INTO unc_248557.wireless_direccion VALUES (88, 61, '7642 Malesuada ', 591, NULL, NULL, 15);
INSERT INTO unc_248557.wireless_direccion VALUES (89, 13, 'Apdo.:172-931 At ', 588, NULL, NULL, 24);
INSERT INTO unc_248557.wireless_direccion VALUES (90, 87, 'Apdo.:835-2476 Sagittis ', 384, NULL, NULL, 64);
INSERT INTO unc_248557.wireless_direccion VALUES (91, 11, 'Apdo.:636-7984 Nascetur ', 456, NULL, NULL, 44);
INSERT INTO unc_248557.wireless_direccion VALUES (92, 5, '2827 Nec, Avenida', 410, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (93, 74, 'Apdo.:992-7556 Curabitur Carretera', 936, NULL, NULL, 57);
INSERT INTO unc_248557.wireless_direccion VALUES (94, 22, 'Apartado núm.: 631, 4899 In, Calle', 935, NULL, NULL, 55);
INSERT INTO unc_248557.wireless_direccion VALUES (95, 50, 'Apdo.:195-8826 Magna Calle', 696, NULL, NULL, 59);
INSERT INTO unc_248557.wireless_direccion VALUES (96, 27, 'Apdo.:653-5279 Ipsum ', 877, NULL, NULL, 21);
INSERT INTO unc_248557.wireless_direccion VALUES (97, 2, 'Apdo.:188-523 A Avda.', 688, NULL, NULL, 17);
INSERT INTO unc_248557.wireless_direccion VALUES (98, 17, 'Apartado núm.: 135, 3452 Orci. ', 723, NULL, NULL, 59);
INSERT INTO unc_248557.wireless_direccion VALUES (99, 20, 'Apdo.:848-9064 Mi, Avenida', 274, NULL, NULL, 9);
INSERT INTO unc_248557.wireless_direccion VALUES (100, 81, '143-5714 Eget Av.', 765, NULL, NULL, 57);
INSERT INTO unc_248557.wireless_direccion VALUES (101, 92, 'Apdo.:336-9835 Mauris Avenida', 153, NULL, NULL, 100);
INSERT INTO unc_248557.wireless_direccion VALUES (102, 5, '948-2481 Euismod Calle', 527, NULL, NULL, 94);
INSERT INTO unc_248557.wireless_direccion VALUES (103, 94, 'Apartado núm.: 873, 9946 Eget ', 611, NULL, NULL, 51);
INSERT INTO unc_248557.wireless_direccion VALUES (104, 61, '540-9595 Orci, C.', 399, NULL, NULL, 48);
INSERT INTO unc_248557.wireless_direccion VALUES (105, 72, 'Apartado núm.: 778, 1910 Non, ', 306, NULL, NULL, 88);
INSERT INTO unc_248557.wireless_direccion VALUES (106, 1, 'Apdo.:842-711 Lacinia Carretera', 415, NULL, NULL, 22);
INSERT INTO unc_248557.wireless_direccion VALUES (107, 13, '987-9887 Iaculis, Calle', 798, NULL, NULL, 46);
INSERT INTO unc_248557.wireless_direccion VALUES (108, 34, 'Apartado núm.: 280, 1406 Quam C.', 946, NULL, NULL, 18);
INSERT INTO unc_248557.wireless_direccion VALUES (109, 98, 'Apartado núm.: 789, 3915 Fusce Ctra.', 15, NULL, NULL, 38);
INSERT INTO unc_248557.wireless_direccion VALUES (110, 41, 'Apdo.:916-2852 Scelerisque Avda.', 897, NULL, NULL, 56);
INSERT INTO unc_248557.wireless_direccion VALUES (111, 34, '970-2513 Tristique Av.', 143, NULL, NULL, 41);
INSERT INTO unc_248557.wireless_direccion VALUES (112, 3, '446-4096 Mattis. Avda.', 489, NULL, NULL, 97);
INSERT INTO unc_248557.wireless_direccion VALUES (113, 30, '589-2858 Et Carretera', 146, NULL, NULL, 19);
INSERT INTO unc_248557.wireless_direccion VALUES (114, 71, 'Apdo.:247-9278 Ligula Avenida', 857, NULL, NULL, 74);
INSERT INTO unc_248557.wireless_direccion VALUES (115, 62, '9923 Ante. C.', 57, NULL, NULL, 50);
INSERT INTO unc_248557.wireless_direccion VALUES (116, 76, 'Apartado núm.: 616, 8756 Suspendisse Av.', 531, NULL, NULL, 6);
INSERT INTO unc_248557.wireless_direccion VALUES (117, 39, 'Apartado núm.: 996, 8184 In, Av.', 34, NULL, NULL, 22);
INSERT INTO unc_248557.wireless_direccion VALUES (118, 100, '3799 Lectus. ', 957, NULL, NULL, 56);
INSERT INTO unc_248557.wireless_direccion VALUES (119, 62, 'Apartado núm.: 727, 3767 Ridiculus ', 277, NULL, NULL, 96);
INSERT INTO unc_248557.wireless_direccion VALUES (120, 98, 'Apdo.:312-8994 Lorem, C.', 881, NULL, NULL, 67);
INSERT INTO unc_248557.wireless_direccion VALUES (121, 71, 'Apdo.:803-2590 Eget Avenida', 439, NULL, NULL, 38);
INSERT INTO unc_248557.wireless_direccion VALUES (122, 51, 'Apdo.:817-7552 Facilisis C/', 970, NULL, NULL, 2);
INSERT INTO unc_248557.wireless_direccion VALUES (123, 33, '2763 A, Carretera', 521, NULL, NULL, 26);
INSERT INTO unc_248557.wireless_direccion VALUES (124, 59, '3339 Libero C.', 475, NULL, NULL, 11);
INSERT INTO unc_248557.wireless_direccion VALUES (125, 39, '6206 Nisl. Carretera', 409, NULL, NULL, 15);
INSERT INTO unc_248557.wireless_direccion VALUES (126, 25, 'Apdo.:973-3976 Erat Avenida', 424, NULL, NULL, 79);
INSERT INTO unc_248557.wireless_direccion VALUES (127, 22, 'Apartado núm.: 261, 2869 Curabitur Avda.', 485, NULL, NULL, 93);
INSERT INTO unc_248557.wireless_direccion VALUES (128, 44, '9637 Sed ', 278, NULL, NULL, 54);
INSERT INTO unc_248557.wireless_direccion VALUES (129, 62, '7676 Tempus C.', 258, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (130, 53, 'Apdo.:303-4207 Lacus. C.', 160, NULL, NULL, 19);
INSERT INTO unc_248557.wireless_direccion VALUES (131, 81, 'Apartado núm.: 185, 9634 Natoque ', 134, NULL, NULL, 87);
INSERT INTO unc_248557.wireless_direccion VALUES (132, 44, '185-8456 Nullam Avenida', 622, NULL, NULL, 30);
INSERT INTO unc_248557.wireless_direccion VALUES (133, 94, 'Apdo.:634-7077 Fames Avda.', 980, NULL, NULL, 14);
INSERT INTO unc_248557.wireless_direccion VALUES (134, 39, 'Apartado núm.: 974, 1107 Consectetuer C.', 710, NULL, NULL, 3);
INSERT INTO unc_248557.wireless_direccion VALUES (135, 96, 'Apdo.:399-3395 Erat Avenida', 201, NULL, NULL, 1);
INSERT INTO unc_248557.wireless_direccion VALUES (136, 96, '1299 Felis Avda.', 566, NULL, NULL, 85);
INSERT INTO unc_248557.wireless_direccion VALUES (137, 45, 'Apartado núm.: 123, 5965 A Ctra.', 798, NULL, NULL, 97);
INSERT INTO unc_248557.wireless_direccion VALUES (138, 50, 'Apdo.:934-9611 Venenatis Avda.', 80, NULL, NULL, 50);
INSERT INTO unc_248557.wireless_direccion VALUES (139, 60, 'Apdo.:866-8773 Ac, Calle', 657, NULL, NULL, 26);
INSERT INTO unc_248557.wireless_direccion VALUES (140, 47, '8110 Non Avenida', 87, NULL, NULL, 66);
INSERT INTO unc_248557.wireless_direccion VALUES (141, 28, '158-730 Gravida C.', 831, NULL, NULL, 95);
INSERT INTO unc_248557.wireless_direccion VALUES (142, 15, '232-6730 Donec ', 77, NULL, NULL, 28);
INSERT INTO unc_248557.wireless_direccion VALUES (143, 9, '147-6077 Ornare C/', 209, NULL, NULL, 28);
INSERT INTO unc_248557.wireless_direccion VALUES (144, 46, 'Apdo.:416-4577 Nec Carretera', 675, NULL, NULL, 66);
INSERT INTO unc_248557.wireless_direccion VALUES (145, 40, '967-2051 Lobortis Av.', 388, NULL, NULL, 21);
INSERT INTO unc_248557.wireless_direccion VALUES (146, 67, '463-3309 Non Av.', 62, NULL, NULL, 33);
INSERT INTO unc_248557.wireless_direccion VALUES (147, 94, '512-5589 Magna, Avenida', 647, NULL, NULL, 2);
INSERT INTO unc_248557.wireless_direccion VALUES (148, 84, 'Apdo.:405-1096 Donec Avda.', 797, NULL, NULL, 73);
INSERT INTO unc_248557.wireless_direccion VALUES (149, 83, 'Apdo.:629-471 Sagittis ', 505, NULL, NULL, 76);
INSERT INTO unc_248557.wireless_direccion VALUES (150, 89, 'Apartado núm.: 584, 3060 Lorem C/', 871, NULL, NULL, 65);


--
-- Data for Name: equipo; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_equipo VALUES (1, 'pede.', NULL, NULL, NULL, 23, 92, '2017-03-29 06:57:34', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (2, 'sapien,', NULL, NULL, NULL, 13, 89, '2017-12-06 19:54:32', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (3, 'eu', NULL, NULL, NULL, 4, 84, '2018-03-09 02:26:35', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (4, 'imperdiet', NULL, NULL, NULL, 22, 45, '2017-11-09 14:54:16', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (5, 'tincidunt', NULL, NULL, NULL, 32, 67, '2018-07-09 13:45:58', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (6, 'Nunc', NULL, NULL, NULL, 22, 62, '2018-08-21 21:05:55', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (7, 'eros.', NULL, NULL, NULL, 41, 89, '2017-07-23 23:10:27', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (8, 'odio', NULL, NULL, NULL, 13, 96, '2016-09-16 11:27:15', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (9, 'urna', NULL, NULL, NULL, 45, 70, '2017-11-29 16:29:41', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (10, 'egestas', NULL, NULL, NULL, 7, 75, '2018-06-02 03:04:22', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (11, 'arcu.', NULL, NULL, NULL, 12, 75, '2017-11-11 11:11:17', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (12, 'amet,', NULL, NULL, NULL, 26, 74, '2017-03-26 02:43:41', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (13, 'eget', NULL, NULL, NULL, 32, 34, '2017-07-26 06:21:00', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (14, 'sed', NULL, NULL, NULL, 45, 69, '2017-08-15 06:08:11', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (15, 'nisl.', NULL, NULL, NULL, 5, 45, '2017-08-01 09:10:33', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (16, 'eu', NULL, NULL, NULL, 26, 51, '2018-09-10 02:53:43', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (17, 'neque', NULL, NULL, NULL, 27, 66, '2018-04-28 21:27:46', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (18, 'mollis', NULL, NULL, NULL, 10, 52, '2017-08-16 01:04:40', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (19, 'rutrum', NULL, NULL, NULL, 41, 73, '2016-12-27 14:47:05', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (20, 'interdum', NULL, NULL, NULL, 34, 90, '2017-02-21 05:17:22', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (21, 'justo.', NULL, NULL, NULL, 38, 59, '2018-06-03 20:36:30', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (22, 'lacus,', NULL, NULL, NULL, 20, 53, '2017-07-12 13:34:37', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (23, 'non', NULL, NULL, NULL, 24, 84, '2016-12-07 08:09:38', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (24, 'gravida', NULL, NULL, NULL, 32, 34, '2016-10-18 01:41:12', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (25, 'at,', NULL, NULL, NULL, 27, 64, '2017-08-11 05:56:51', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (26, 'augue', NULL, NULL, NULL, 35, 37, '2017-05-24 14:57:43', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (27, 'porta', NULL, NULL, NULL, 13, 48, '2018-04-27 07:31:05', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (28, 'semper', NULL, NULL, NULL, 39, 95, '2017-10-17 21:48:24', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (29, 'odio.', NULL, NULL, NULL, 32, 44, '2018-08-24 09:47:41', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (30, 'nisi.', NULL, NULL, NULL, 10, 79, '2017-07-20 03:06:43', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (31, 'Integer', NULL, NULL, NULL, 18, 41, '2017-03-26 12:29:10', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (32, 'neque', NULL, NULL, NULL, 6, 46, '2018-07-23 02:40:18', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (33, 'Nunc', NULL, NULL, NULL, 17, 81, '2017-01-26 06:20:56', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (34, 'semper,', NULL, NULL, NULL, 27, 76, '2016-11-27 08:19:28', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (35, 'nunc', NULL, NULL, NULL, 31, 39, '2017-10-31 21:44:04', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (36, 'natoque', NULL, NULL, NULL, 33, 84, '2017-10-21 01:00:55', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (37, 'adipiscing', NULL, NULL, NULL, 16, 65, '2018-05-28 09:04:18', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (38, 'a', NULL, NULL, NULL, 13, 90, '2017-08-23 23:50:29', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (39, 'lorem', NULL, NULL, NULL, 44, 84, '2018-01-05 21:28:02', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (40, 'orci', NULL, NULL, NULL, 1, 71, '2016-11-24 07:02:22', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (41, 'auctor', NULL, NULL, NULL, 10, 81, '2017-10-01 04:35:31', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (42, 'sollicitudin', NULL, NULL, NULL, 9, 98, '2017-01-22 16:30:54', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (43, 'massa.', NULL, NULL, NULL, 31, 76, '2018-04-21 18:28:19', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (44, 'Nullam', NULL, NULL, NULL, 29, 64, '2017-04-15 21:05:17', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (45, 'augue,', NULL, NULL, NULL, 15, 53, '2018-04-17 19:49:13', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (46, 'nec,', NULL, NULL, NULL, 46, 34, '2018-01-20 03:35:54', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (47, 'sapien', NULL, NULL, NULL, 40, 89, '2017-03-09 16:38:03', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (48, 'lacus.', NULL, NULL, NULL, 5, 56, '2017-10-23 23:40:55', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (49, 'libero.', NULL, NULL, NULL, 36, 90, '2017-06-24 06:56:43', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (50, 'Aenean', NULL, NULL, NULL, 30, 48, '2017-03-12 22:13:56', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (51, 'aliquet', NULL, NULL, NULL, 39, 84, '2017-03-25 04:38:31', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (52, 'Nullam', NULL, NULL, NULL, 20, 63, '2017-02-01 11:19:56', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (53, 'Donec', NULL, NULL, NULL, 8, 52, '2017-08-11 09:48:11', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (54, 'cursus', NULL, NULL, NULL, 47, 81, '2018-06-03 21:18:44', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (55, 'gravida', NULL, NULL, NULL, 30, 44, '2018-04-19 08:52:05', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (56, 'pede,', NULL, NULL, NULL, 6, 64, '2017-10-18 10:17:58', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (57, 'sodales', NULL, NULL, NULL, 1, 34, '2017-10-19 22:43:38', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (58, 'Aliquam', NULL, NULL, NULL, 12, 63, '2017-03-19 14:16:10', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (59, 'sociosqu', NULL, NULL, NULL, 3, 81, '2017-11-20 22:51:49', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (60, 'parturient', NULL, NULL, NULL, 2, 91, '2018-02-21 07:08:01', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (61, 'feugiat', NULL, NULL, NULL, 20, 90, '2018-02-23 13:41:46', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (62, 'at', NULL, NULL, NULL, 34, 55, '2017-05-04 01:56:39', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (63, 'auctor.', NULL, NULL, NULL, 44, 67, '2017-10-26 03:08:46', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (64, 'ut', NULL, NULL, NULL, 29, 78, '2017-11-13 08:09:02', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (65, 'orci', NULL, NULL, NULL, 48, 56, '2018-05-19 08:08:05', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (66, 'Donec', NULL, NULL, NULL, 25, 39, '2018-05-26 23:33:00', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (67, 'pede', NULL, NULL, NULL, 27, 78, '2018-01-18 08:53:11', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (68, 'libero', NULL, NULL, NULL, 47, 46, '2016-09-14 18:51:43', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (69, 'scelerisque', NULL, NULL, NULL, 2, 48, '2017-09-18 13:46:32', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (70, 'mauris', NULL, NULL, NULL, 40, 92, '2017-09-22 10:15:42', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (71, 'elit', NULL, NULL, NULL, 11, 49, '2018-07-29 06:36:17', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (72, 'eu', NULL, NULL, NULL, 28, 64, '2017-12-26 19:46:49', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (73, 'malesuada', NULL, NULL, NULL, 39, 61, '2018-06-18 16:54:24', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (74, 'purus', NULL, NULL, NULL, 36, 76, '2017-01-17 20:37:37', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (75, 'Nunc', NULL, NULL, NULL, 48, 100, '2017-06-21 14:13:30', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (76, 'Phasellus', NULL, NULL, NULL, 3, 58, '2017-06-06 09:42:59', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (77, 'Curabitur', NULL, NULL, NULL, 25, 68, '2017-04-21 10:51:26', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (78, 'sed', NULL, NULL, NULL, 36, 49, '2017-10-10 22:22:47', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (79, 'ultricies', NULL, NULL, NULL, 24, 84, '2016-10-03 08:36:08', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (80, 'urna', NULL, NULL, NULL, 13, 89, '2018-07-22 08:40:47', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (81, 'Aliquam', NULL, NULL, NULL, 13, 40, '2018-02-10 17:01:26', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (82, 'porttitor', NULL, NULL, NULL, 2, 79, '2017-09-29 08:29:38', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (83, 'Phasellus', NULL, NULL, NULL, 13, 43, '2016-10-19 07:58:49', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (84, 'Fusce', NULL, NULL, NULL, 44, 61, '2018-07-16 07:14:52', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (85, 'dis', NULL, NULL, NULL, 43, 43, '2018-01-12 03:39:07', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (86, 'Nunc', NULL, NULL, NULL, 9, 51, '2018-02-01 14:58:22', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (87, 'lacus.', NULL, NULL, NULL, 4, 50, '2018-07-11 19:31:05', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (88, 'vulputate,', NULL, NULL, NULL, 37, 44, '2017-09-01 00:28:48', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (89, 'fermentum', NULL, NULL, NULL, 39, 38, '2017-11-27 14:09:23', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (90, 'Fusce', NULL, NULL, NULL, 20, 87, '2016-11-01 10:15:48', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (91, 'montes,', NULL, NULL, NULL, 29, 84, '2017-10-28 22:38:56', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (92, 'ornare,', NULL, NULL, NULL, 39, 94, '2017-06-04 15:55:31', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (93, 'non,', NULL, NULL, NULL, 34, 79, '2016-11-07 21:40:06', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (94, 'faucibus', NULL, NULL, NULL, 39, 33, '2017-09-24 23:59:15', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (95, 'ac', NULL, NULL, NULL, 38, 51, '2018-08-10 12:22:16', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (96, 'Aliquam', NULL, NULL, NULL, 12, 32, '2016-09-30 19:44:25', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (97, 'varius', NULL, NULL, NULL, 19, 85, '2018-05-13 13:47:51', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (98, 'neque.', NULL, NULL, NULL, 5, 86, '2018-01-30 07:37:18', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (99, 'et', NULL, NULL, NULL, 50, 48, '2018-01-11 21:29:51', NULL);
INSERT INTO unc_248557.wireless_equipo VALUES (100, 'odio', NULL, NULL, NULL, 14, 43, '2017-04-02 03:59:15', NULL);


--
-- Data for Name: lineacomprobante; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1, 859, 1, 'feugiat. Sed', 2, 69.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (4, 325, 1, 'id risus', 3, 30.00000, 50);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (5, 42, 1, 'Suspendisse ac', 3, 95.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (7, 28, 1, 'dui quis', 4, 22.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (8, 240, 1, 'at, velit.', 1, 58.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (9, 771, 1, 'at pede.', 4, 87.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (10, 183, 1, 'netus et', 3, 40.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (13, 110, 1, 'posuere, enim', 1, 23.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (15, 696, 1, 'Proin eget', 5, 8.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (16, 474, 1, 'Curabitur consequat,', 1, 30.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (18, 620, 1, 'odio. Nam', 3, 75.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (20, 903, 1, 'neque tellus,', 4, 64.00000, 30);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (26, 870, 1, 'Duis a', 2, 43.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (27, 197, 1, 'amet, consectetuer', 2, 50.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (29, 13, 1, 'tempor erat', 2, 86.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (30, 152, 1, 'consequat nec,', 3, 79.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (31, 818, 1, 'eros nec', 4, 82.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (33, 750, 1, 'dui nec', 2, 58.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (34, 618, 1, 'at risus.', 1, 12.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (39, 800, 1, 'Mauris eu', 3, 29.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (43, 471, 1, 'egestas. Aliquam', 2, 36.00000, 7);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (44, 811, 1, 'lobortis quam', 5, 50.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (50, 227, 1, 'lorem, luctus', 2, 35.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (52, 91, 1, 'lorem lorem,', 4, 47.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (53, 800, 1, 'lectus justo', 1, 44.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (54, 253, 1, 'ullamcorper, nisl', 1, 37.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (57, 372, 1, 'magna. Phasellus', 3, 61.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (66, 300, 1, 'suscipit, est', 5, 28.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (68, 681, 1, 'Nunc quis', 4, 52.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (72, 405, 1, 'Maecenas ornare', 5, 94.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (74, 197, 1, 'Quisque tincidunt', 2, 7.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (80, 40, 1, 'non, egestas', 1, 12.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (83, 780, 1, 'tempor augue', 3, 69.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (89, 210, 1, 'cursus luctus,', 3, 99.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (98, 848, 1, 'nec, euismod', 5, 22.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (99, 17, 1, 'egestas. Sed', 5, 10.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (100, 809, 1, 'risus a', 3, 82.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (102, 661, 1, 'tempor augue', 3, 57.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (110, 753, 1, 'adipiscing ligula.', 2, 62.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (115, 456, 1, 'velit. Aliquam', 1, 71.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (116, 922, 1, 'nisi nibh', 3, 76.00000, 11);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (121, 947, 1, 'ornare, facilisis', 5, 79.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (122, 11, 1, 'in molestie', 3, 93.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (123, 240, 1, 'Nunc ac', 5, 59.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (124, 309, 1, 'Quisque fringilla', 4, 42.00000, 28);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (140, 351, 1, 'varius. Nam', 5, 63.00000, 7);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (141, 87, 1, 'Mauris magna.', 4, 50.00000, 7);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (143, 556, 1, 'risus. Nunc', 1, 48.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (150, 755, 1, 'eu turpis.', 5, 2.00000, 4);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (151, 186, 1, 'Proin sed', 1, 54.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (161, 42, 1, 'ultricies ligula.', 1, 32.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (165, 398, 1, 'mi lorem,', 1, 34.00000, 16);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (170, 179, 1, 'est. Mauris', 4, 82.00000, 12);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (176, 618, 1, 'ac mattis', 1, 62.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (177, 595, 1, 'nisi magna', 4, 24.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (178, 53, 1, 'sit amet,', 2, 5.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (183, 153, 1, 'mollis nec,', 5, 22.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (187, 922, 1, 'nonummy ac,', 2, 24.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (191, 446, 1, 'fringilla euismod', 2, 69.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (193, 763, 1, 'metus. In', 2, 71.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (195, 528, 1, 'mollis nec,', 2, 87.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (200, 843, 1, 'dictum sapien.', 4, 22.00000, 28);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (201, 308, 1, 'ut, sem.', 1, 99.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (203, 957, 1, 'in sodales', 3, 51.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (204, 500, 1, 'sagittis augue,', 2, 96.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (209, 11, 1, 'sociis natoque', 4, 92.00000, 15);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (210, 76, 1, 'dolor sit', 3, 74.00000, 4);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (212, 215, 1, 'Mauris ut', 3, 65.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (213, 831, 1, 'vitae, sodales', 3, 96.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (217, 16, 1, 'Donec egestas.', 5, 62.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (226, 273, 1, 'consectetuer ipsum', 1, 64.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (227, 28, 1, 'Aenean sed', 3, 55.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (228, 329, 1, 'magna. Praesent', 5, 46.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (230, 320, 1, 'non enim', 4, 87.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (233, 927, 1, 'risus. Nunc', 5, 96.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (237, 716, 1, 'ultrices. Duis', 1, 81.00000, 45);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (238, 653, 1, 'euismod est', 4, 16.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (239, 859, 1, 'nec urna', 5, 29.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (241, 353, 1, 'Maecenas iaculis', 1, 21.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (242, 266, 1, 'sed dictum', 5, 42.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (245, 80, 1, 'dapibus rutrum,', 2, 59.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (246, 908, 1, 'velit eu', 4, 99.00000, 8);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (247, 433, 1, 'Aenean egestas', 5, 84.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (249, 928, 1, 'conubia nostra,', 2, 62.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (258, 691, 1, 'eu dolor', 1, 25.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (260, 921, 1, 'mauris, rhoncus', 5, 3.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (267, 628, 1, 'nulla vulputate', 3, 44.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (272, 753, 1, 'Proin vel', 5, 53.00000, 14);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (274, 319, 1, 'dolor. Fusce', 5, 25.00000, 11);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (276, 74, 1, 'Donec fringilla.', 2, 88.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (278, 111, 1, 'pede. Nunc', 3, 96.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (280, 550, 1, 'nec quam.', 2, 8.00000, 47);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (284, 903, 1, 'neque tellus,', 2, 79.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (286, 960, 1, 'Vivamus sit', 1, 83.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (287, 276, 1, 'Cras pellentesque.', 1, 86.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (289, 797, 1, 'lorem, eget', 4, 54.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (290, 288, 1, 'interdum. Nunc', 2, 40.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (292, 114, 1, 'vitae risus.', 5, 23.00000, 30);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (294, 985, 1, 'accumsan laoreet', 5, 98.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (295, 385, 1, 'sociis natoque', 1, 66.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (296, 111, 1, 'mauris ut', 1, 26.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (298, 300, 1, 'Donec vitae', 2, 41.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (301, 719, 1, 'Donec at', 1, 74.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (303, 832, 1, 'semper tellus', 4, 88.00000, 15);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (306, 531, 1, 'luctus. Curabitur', 4, 67.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (309, 600, 1, 'diam eu', 3, 68.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (312, 78, 1, 'lectus quis', 3, 8.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (315, 863, 1, 'ullamcorper viverra.', 1, 15.00000, 8);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (326, 955, 1, 'sociis natoque', 4, 19.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (328, 57, 1, 'dapibus ligula.', 1, 57.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (329, 815, 1, 'ac, feugiat', 1, 93.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (333, 583, 1, 'eu metus.', 1, 76.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (335, 351, 1, 'eu dui.', 1, 10.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (337, 733, 1, 'mauris id', 4, 93.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (341, 445, 1, 'leo elementum', 4, 40.00000, 30);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (348, 646, 1, 'Class aptent', 3, 44.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (354, 433, 1, 'turpis egestas.', 3, 19.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (356, 492, 1, 'amet, consectetuer', 1, 31.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (362, 675, 1, 'ultrices sit', 4, 40.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (364, 578, 1, 'enim, sit', 2, 72.00000, 28);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (365, 607, 1, 'eu, placerat', 2, 91.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (366, 840, 1, 'sit amet', 1, 54.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (367, 51, 1, 'placerat. Cras', 5, 80.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (370, 724, 1, 'dui. Suspendisse', 2, 4.00000, 45);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (373, 456, 1, 'Proin dolor.', 1, 82.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (378, 880, 1, 'et ipsum', 1, 78.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (379, 986, 1, 'a feugiat', 4, 16.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (382, 624, 1, 'porttitor tellus', 5, 5.00000, 8);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (384, 913, 1, 'enim. Nunc', 5, 62.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (385, 957, 1, 'per conubia', 1, 63.00000, 7);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (388, 797, 1, 'odio. Etiam', 2, 99.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (390, 560, 1, 'sed, facilisis', 5, 76.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (391, 273, 1, 'semper, dui', 5, 91.00000, 28);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (393, 696, 1, 'Nam tempor', 5, 72.00000, 16);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (400, 911, 1, 'dapibus gravida.', 2, 77.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (402, 328, 1, 'placerat velit.', 5, 88.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (403, 744, 1, 'tristique pharetra.', 4, 56.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (405, 492, 1, 'pellentesque eget,', 4, 95.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (408, 473, 1, 'natoque penatibus', 3, 100.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (409, 927, 1, 'vulputate ullamcorper', 5, 91.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (410, 253, 1, 'et risus.', 1, 40.00000, 28);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (419, 953, 1, 'pede et', 5, 46.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (422, 763, 1, 'massa. Integer', 2, 14.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (423, 310, 1, 'pede nec', 3, 34.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (425, 675, 1, 'mi. Duis', 5, 59.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (429, 712, 1, 'nisi. Aenean', 4, 68.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (435, 566, 1, 'Curae Donec', 1, 59.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (439, 832, 1, 'id ante', 3, 1.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (440, 479, 1, 'ullamcorper, velit', 3, 9.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (442, 719, 1, 'sit amet', 2, 60.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (445, 986, 1, 'erat, eget', 1, 81.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (446, 156, 1, 'est ac', 4, 8.00000, 8);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (449, 319, 1, 'quis turpis', 3, 13.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (450, 677, 1, 'cursus et,', 2, 62.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (451, 831, 1, 'massa. Mauris', 4, 43.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (452, 832, 1, 'sit amet', 2, 33.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (455, 203, 1, 'mauris. Morbi', 5, 30.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (456, 948, 1, 'auctor quis,', 4, 94.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (457, 636, 1, 'ligula consectetuer', 2, 83.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (458, 25, 1, 'libero est,', 2, 56.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (459, 326, 1, 'ipsum ac', 5, 32.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (460, 996, 1, 'erat, in', 5, 94.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (463, 957, 1, 'id, blandit', 3, 3.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (468, 618, 1, 'ornare, lectus', 4, 92.00000, 7);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (471, 470, 1, 'vulputate dui,', 3, 69.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (473, 393, 1, 'euismod mauris', 3, 50.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (478, 530, 1, 'Duis ac', 3, 80.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (479, 405, 1, 'ut, nulla.', 3, 66.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (484, 498, 1, 'eget, ipsum.', 2, 75.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (485, 111, 1, 'in consequat', 5, 49.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (486, 166, 1, 'pede nec', 5, 76.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (489, 268, 1, 'vulputate, posuere', 4, 85.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (490, 600, 1, 'Nullam velit', 2, 25.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (491, 134, 1, 'malesuada fames', 4, 37.00000, 30);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (494, 440, 1, 'sagittis. Nullam', 1, 69.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (495, 340, 1, 'nec urna', 2, 55.00000, 47);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (499, 417, 1, 'Curabitur vel', 4, 76.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (500, 940, 1, 'nec, cursus', 4, 27.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (504, 383, 1, 'tellus, imperdiet', 1, 45.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (506, 618, 1, 'Nunc pulvinar', 5, 96.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (508, 421, 1, 'Donec est', 1, 21.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (509, 236, 1, 'massa rutrum', 5, 100.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (512, 831, 1, 'posuere cubilia', 4, 50.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (515, 819, 1, 'Maecenas mi', 5, 72.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (516, 156, 1, 'elementum at,', 1, 23.00000, 45);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (518, 80, 1, 'eu dolor', 2, 88.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (523, 677, 1, 'dolor elit,', 4, 98.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (525, 969, 1, 'eu, accumsan', 4, 23.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (531, 538, 1, 'consectetuer, cursus', 1, 19.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (536, 78, 1, 'lobortis risus.', 5, 90.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (539, 58, 1, 'Praesent interdum', 5, 60.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (549, 273, 1, 'est. Mauris', 1, 61.00000, 12);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (554, 23, 1, 'Integer vulputate,', 2, 26.00000, 50);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (556, 806, 1, 'odio. Nam', 5, 28.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (561, 536, 1, 'Aenean gravida', 3, 97.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (563, 538, 1, 'consectetuer euismod', 2, 12.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (564, 186, 1, 'Mauris eu', 2, 94.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (566, 359, 1, 'nec urna', 3, 75.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (568, 3, 1, 'eu elit.', 4, 59.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (571, 906, 1, 'ligula. Aenean', 5, 1.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (572, 806, 1, 'dignissim pharetra.', 4, 55.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (574, 538, 1, 'gravida sagittis.', 1, 44.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (575, 201, 1, 'augue. Sed', 5, 1.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (577, 91, 1, 'sollicitudin adipiscing', 5, 67.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (579, 174, 1, 'arcu. Nunc', 3, 81.00000, 30);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (580, 771, 1, 'ultricies sem', 2, 67.00000, 11);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (583, 881, 1, 'ligula elit,', 1, 100.00000, 15);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (585, 235, 1, 'est. Nunc', 3, 58.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (586, 977, 1, 'consequat purus.', 3, 8.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (589, 74, 1, 'enim. Nunc', 4, 94.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (590, 470, 1, 'semper erat,', 5, 92.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (597, 733, 1, 'orci tincidunt', 1, 75.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (599, 911, 1, 'Fusce diam', 4, 34.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (602, 235, 1, 'est arcu', 3, 47.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (603, 671, 1, 'vel quam', 3, 85.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (606, 595, 1, 'et libero.', 4, 43.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (608, 955, 1, 'sit amet', 2, 99.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (615, 203, 1, 'a odio', 4, 15.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (621, 343, 1, 'mi lacinia', 1, 11.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (632, 401, 1, 'orci luctus', 5, 46.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (633, 734, 1, 'orci, adipiscing', 3, 58.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (643, 985, 1, 'sollicitudin commodo', 1, 25.00000, 47);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (646, 766, 1, 'semper et,', 5, 20.00000, 50);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (648, 201, 1, 'eget odio.', 1, 42.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (649, 618, 1, 'commodo tincidunt', 1, 5.00000, 48);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (655, 156, 1, 'eget nisi', 1, 37.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (657, 928, 1, 'lectus pede,', 1, 57.00000, 47);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (663, 600, 1, 'egestas blandit.', 4, 20.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (665, 528, 1, 'neque. Nullam', 4, 91.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (669, 961, 1, 'eu, accumsan', 2, 47.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (672, 325, 1, 'orci luctus', 5, 71.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (676, 596, 1, 'sit amet', 5, 100.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (677, 28, 1, 'dui. Cras', 2, 95.00000, 14);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (679, 815, 1, 'non, vestibulum', 2, 58.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (686, 968, 1, 'lorem, luctus', 3, 75.00000, 12);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (688, 885, 1, 'rutrum urna,', 1, 22.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (690, 373, 1, 'dictum sapien.', 1, 20.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (693, 889, 1, 'neque. Sed', 5, 94.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (694, 348, 1, 'Quisque ac', 2, 86.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (695, 950, 1, 'id ante', 4, 78.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (696, 342, 1, 'dis parturient', 5, 41.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (698, 977, 1, 'aliquet odio.', 2, 85.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (700, 677, 1, 'dis parturient', 3, 77.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (704, 759, 1, 'dui quis', 1, 98.00000, 14);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (710, 342, 1, 'sit amet', 5, 54.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (713, 271, 1, 'sagittis augue,', 5, 70.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (718, 750, 1, 'ligula. Nullam', 2, 23.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (721, 986, 1, 'ac metus', 4, 30.00000, 26);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (723, 636, 1, 'mi enim,', 3, 6.00000, 50);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (729, 218, 1, 'tortor. Integer', 2, 24.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (730, 567, 1, 'nulla at', 1, 14.00000, 15);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (732, 191, 1, 'In condimentum.', 5, 34.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (733, 351, 1, 'id ante', 3, 12.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (734, 528, 1, 'nibh lacinia', 3, 37.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (737, 846, 1, 'iaculis enim,', 2, 39.00000, 4);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (739, 288, 1, 'Nam tempor', 4, 18.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (750, 818, 1, 'nisi. Cum', 5, 4.00000, 45);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (751, 332, 1, 'felis. Donec', 2, 99.00000, 39);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (759, 474, 1, 'Morbi sit', 5, 87.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (764, 383, 1, 'Mauris vel', 4, 82.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (772, 510, 1, 'Nulla dignissim.', 3, 8.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (776, 677, 1, 'malesuada malesuada.', 1, 54.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (777, 51, 1, 'Donec tempor,', 3, 61.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (781, 15, 1, 'nunc, ullamcorper', 3, 44.00000, 40);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (782, 288, 1, 'a, malesuada', 1, 26.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (785, 950, 1, 'quis, pede.', 1, 77.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (790, 179, 1, 'at fringilla', 1, 90.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (792, 677, 1, 'nec, cursus', 1, 38.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (795, 530, 1, 'scelerisque neque.', 4, 77.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (797, 605, 1, 'nisl. Maecenas', 1, 49.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (799, 960, 1, 'leo elementum', 1, 21.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (805, 799, 1, 'massa rutrum', 3, 9.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (809, 567, 1, 'non, hendrerit', 5, 34.00000, 12);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (810, 359, 1, 'per conubia', 2, 54.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (811, 433, 1, 'senectus et', 2, 75.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (813, 531, 1, 'amet orci.', 4, 7.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (816, 528, 1, 'elit sed', 2, 35.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (818, 779, 1, 'eu tellus', 4, 26.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (821, 433, 1, 'blandit congue.', 2, 2.00000, 2);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (836, 28, 1, 'vitae, erat.', 3, 31.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (839, 603, 1, 'odio a', 2, 96.00000, 44);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (842, 574, 1, 'interdum feugiat.', 2, 93.00000, 1);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (850, 874, 1, 'venenatis vel,', 1, 82.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (852, 533, 1, 'volutpat. Nulla', 2, 48.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (857, 500, 1, 'ligula eu', 5, 77.00000, 24);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (858, 986, 1, 'fringilla euismod', 2, 23.00000, 4);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (861, 556, 1, 'purus. Nullam', 3, 90.00000, 46);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (862, 970, 1, 'Aenean eget', 3, 31.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (866, 13, 1, 'cubilia Curae', 3, 73.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (868, 401, 1, 'Aenean egestas', 2, 79.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (870, 16, 1, 'ac arcu.', 1, 74.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (876, 19, 1, 'magna. Suspendisse', 5, 61.00000, 29);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (878, 272, 1, 'Pellentesque ultricies', 2, 43.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (879, 559, 1, 'egestas nunc', 4, 8.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (881, 986, 1, 'nulla. Cras', 3, 14.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (884, 661, 1, 'tristique pellentesque,', 4, 47.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (886, 980, 1, 'pellentesque, tellus', 3, 74.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (887, 859, 1, 'arcu. Morbi', 1, 11.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (890, 744, 1, 'elit, pellentesque', 5, 20.00000, 17);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (892, 451, 1, 'Donec elementum,', 1, 91.00000, 8);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (900, 178, 1, 'lobortis quis,', 3, 94.00000, 3);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (901, 320, 1, 'Donec nibh', 3, 28.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (903, 906, 1, 'non massa', 3, 72.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (905, 578, 1, 'porta elit,', 3, 67.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (907, 977, 1, 'amet, consectetuer', 5, 52.00000, 47);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (908, 712, 1, 'Aliquam fringilla', 2, 63.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (913, 16, 1, 'tristique neque', 3, 53.00000, 38);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (917, 622, 1, 'semper erat,', 4, 70.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (918, 492, 1, 'orci tincidunt', 1, 62.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (919, 137, 1, 'et tristique', 5, 76.00000, 36);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (922, 27, 1, 'vestibulum, neque', 1, 3.00000, 43);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (923, 91, 1, 'lacinia orci,', 1, 48.00000, 14);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (924, 265, 1, 'nunc. In', 3, 14.00000, 35);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (925, 832, 1, 'lorem semper', 3, 71.00000, 21);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (926, 644, 1, 'semper, dui', 1, 17.00000, 20);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (927, 759, 1, 'Mauris vel', 3, 28.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (930, 42, 1, 'et malesuada', 5, 23.00000, 31);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (932, 971, 1, 'odio sagittis', 4, 13.00000, 5);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (933, 579, 1, 'tincidunt. Donec', 3, 70.00000, 41);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (934, 874, 1, 'ornare egestas', 2, 29.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (936, 691, 1, 'a sollicitudin', 3, 53.00000, 37);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (939, 332, 1, 'et ipsum', 3, 6.00000, 23);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (940, 110, 1, 'tincidunt, nunc', 4, 73.00000, 9);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (944, 903, 1, 'malesuada ut,', 3, 5.00000, 22);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (946, 68, 1, 'scelerisque mollis.', 4, 60.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (947, 461, 1, 'metus. Vivamus', 1, 97.00000, 32);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (949, 13, 1, 'nisl arcu', 2, 15.00000, 50);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (957, 802, 1, 'lectus pede', 1, 9.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (961, 578, 1, 'ante lectus', 2, 24.00000, 42);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (964, 970, 1, 'augue scelerisque', 3, 57.00000, 6);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (966, 288, 1, 'sit amet', 3, 69.00000, 25);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (971, 486, 1, 'urna suscipit', 4, 64.00000, 18);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (977, 986, 1, 'mattis. Cras', 4, 82.00000, 12);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (981, 975, 1, 'In mi', 5, 23.00000, 49);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (987, 235, 1, 'Quisque imperdiet,', 2, 4.00000, 27);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (988, 950, 1, 'Nullam enim.', 5, 59.00000, 19);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (993, 153, 1, 'neque vitae', 5, 87.00000, 10);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (996, 385, 1, 'senectus et', 2, 25.00000, 34);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (998, 969, 1, 'augue, eu', 1, 23.00000, 13);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (999, 736, 1, 'diam dictum', 5, 20.00000, 33);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1007, 128, 2, 'ac, feugiat', 4, 87.00000, 100);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1019, 262, 2, 'placerat, augue.', 5, 54.00000, 60);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1020, 725, 2, 'neque. Nullam', 1, 55.00000, 83);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1022, 443, 2, 'sem, vitae', 2, 71.00000, 88);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1023, 547, 2, 'facilisis vitae,', 3, 77.00000, 63);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1024, 125, 2, 'neque. Morbi', 4, 52.00000, 89);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1026, 943, 2, 'et, rutrum', 1, 13.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1028, 601, 2, 'Duis a', 2, 51.00000, 79);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1030, 376, 2, 'eros. Proin', 5, 37.00000, 76);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1031, 785, 2, 'parturient montes,', 1, 49.00000, 87);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1033, 674, 2, 'felis eget', 3, 52.00000, 79);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1038, 898, 2, 'Sed dictum.', 4, 55.00000, 56);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1039, 72, 2, 'cursus et,', 1, 59.00000, 95);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1041, 703, 2, 'mattis semper,', 1, 69.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1046, 49, 2, 'Sed malesuada', 4, 25.00000, 86);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1049, 966, 2, 'ultrices posuere', 5, 38.00000, 84);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1055, 44, 2, 'fermentum risus,', 3, 6.00000, 56);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1059, 453, 2, 'facilisi. Sed', 5, 96.00000, 87);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1061, 631, 2, 'nonummy. Fusce', 5, 55.00000, 100);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1064, 742, 2, 'dis parturient', 5, 9.00000, 100);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1065, 413, 2, 'eget mollis', 1, 54.00000, 79);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1068, 468, 2, 'dolor vitae', 3, 38.00000, 90);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1069, 752, 2, 'lacinia vitae,', 3, 71.00000, 74);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1070, 991, 2, 'sem semper', 5, 80.00000, 71);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1072, 206, 2, 'tempor diam', 4, 45.00000, 70);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1073, 250, 2, 'porta elit,', 3, 83.00000, 82);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1074, 549, 2, 'libero. Integer', 4, 56.00000, 74);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1079, 601, 2, 'dolor sit', 2, 53.00000, 89);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1080, 176, 2, 'metus. In', 3, 5.00000, 90);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1082, 245, 2, 'senectus et', 4, 92.00000, 92);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1084, 256, 2, 'Cras dictum', 4, 70.00000, 80);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1090, 610, 2, 'non, luctus', 3, 59.00000, 62);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1091, 430, 2, 'nisl arcu', 4, 34.00000, 80);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1096, 604, 2, 'semper cursus.', 3, 100.00000, 82);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1103, 912, 2, 'fermentum convallis', 2, 75.00000, 74);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1109, 280, 2, 'ac risus.', 1, 61.00000, 60);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1112, 614, 2, 'pede sagittis', 1, 47.00000, 53);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1119, 576, 2, 'amet, consectetuer', 3, 34.00000, 89);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1120, 895, 2, 'vestibulum massa', 5, 92.00000, 73);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1121, 282, 2, 'a purus.', 4, 65.00000, 70);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1125, 432, 2, 'egestas a,', 1, 95.00000, 81);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1128, 674, 2, 'Cum sociis', 1, 43.00000, 69);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1132, 916, 2, 'lacus vestibulum', 5, 20.00000, 92);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1133, 209, 2, 'sagittis placerat.', 3, 85.00000, 80);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1134, 311, 2, 'lobortis quam', 2, 61.00000, 84);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1135, 282, 2, 'sed, sapien.', 1, 41.00000, 93);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1137, 6, 2, 'molestie arcu.', 2, 12.00000, 78);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1142, 181, 2, 'faucibus orci', 2, 29.00000, 52);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1143, 270, 2, 'ante ipsum', 1, 27.00000, 81);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1144, 537, 2, 'a, magna.', 3, 94.00000, 67);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1146, 291, 2, 'faucibus orci', 2, 75.00000, 59);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1147, 307, 2, 'magnis dis', 2, 75.00000, 59);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1149, 521, 2, 'nascetur ridiculus', 5, 53.00000, 51);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1158, 742, 2, 'ornare. In', 1, 60.00000, 86);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1161, 109, 2, 'laoreet, libero', 5, 39.00000, 56);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1169, 808, 2, 'libero. Proin', 5, 20.00000, 55);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1170, 518, 2, 'diam dictum', 4, 38.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1175, 710, 2, 'est ac', 2, 99.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1176, 772, 2, 'Integer mollis.', 1, 40.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1179, 429, 2, 'in, hendrerit', 3, 67.00000, 68);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1183, 54, 2, 'sollicitudin a,', 3, 34.00000, 83);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1185, 314, 2, 'libero et', 2, 62.00000, 51);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1186, 94, 2, 'faucibus. Morbi', 4, 71.00000, 77);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1187, 184, 2, 'Mauris blandit', 1, 43.00000, 99);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1189, 973, 2, 'sed leo.', 2, 32.00000, 88);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1191, 667, 2, 'laoreet, libero', 2, 5.00000, 68);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1194, 926, 2, 'molestie orci', 3, 6.00000, 58);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1195, 301, 2, 'eget, ipsum.', 4, 83.00000, 93);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1197, 430, 2, 'odio a', 5, 7.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1200, 352, 2, 'urna. Vivamus', 2, 16.00000, 63);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1207, 472, 2, 'commodo auctor', 1, 50.00000, 97);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1213, 593, 2, 'enim. Etiam', 4, 74.00000, 71);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1215, 995, 2, 'nec quam.', 3, 22.00000, 75);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1216, 427, 2, 'arcu. Nunc', 2, 48.00000, 98);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1218, 463, 2, 'iaculis aliquet', 3, 28.00000, 92);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1219, 593, 2, 'commodo auctor', 1, 27.00000, 67);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1220, 136, 2, 'suscipit, est', 3, 46.00000, 60);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1221, 674, 2, 'convallis in,', 3, 35.00000, 100);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1222, 250, 2, 'non, hendrerit', 2, 51.00000, 60);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1223, 291, 2, 'turpis vitae', 4, 16.00000, 73);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1226, 32, 2, 'sapien, cursus', 1, 93.00000, 65);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1227, 93, 2, 'velit justo', 5, 16.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1229, 170, 2, 'semper auctor.', 2, 31.00000, 70);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1236, 804, 2, 'In lorem.', 5, 88.00000, 89);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1237, 432, 2, 'erat. Vivamus', 4, 94.00000, 99);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1238, 172, 2, 'ultrices sit', 1, 25.00000, 80);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1241, 115, 2, 'interdum feugiat.', 4, 97.00000, 78);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1244, 702, 2, 'Pellentesque tincidunt', 4, 13.00000, 83);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1247, 131, 2, 'nisl arcu', 1, 60.00000, 73);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1249, 494, 2, 'nulla. In', 1, 91.00000, 97);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1252, 920, 2, 'ornare, elit', 3, 96.00000, 99);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1255, 209, 2, 'dictum eleifend,', 2, 60.00000, 62);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1256, 612, 2, 'scelerisque, lorem', 2, 60.00000, 94);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1258, 369, 2, 'Nunc pulvinar', 2, 83.00000, 53);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1259, 876, 2, 'arcu vel', 3, 73.00000, 79);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1260, 209, 2, 'tristique pharetra.', 3, 95.00000, 85);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1261, 987, 2, 'luctus. Curabitur', 3, 88.00000, 73);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1262, 199, 2, 'lacinia mattis.', 1, 62.00000, 91);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1263, 431, 2, 'Aliquam nisl.', 2, 77.00000, 98);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1267, 277, 2, 'ut quam', 1, 1.00000, 100);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1273, 59, 2, 'Cras lorem', 2, 76.00000, 76);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1275, 540, 2, 'Cras dolor', 1, 33.00000, 83);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1276, 826, 2, 'nec, imperdiet', 3, 21.00000, 57);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1277, 835, 2, 'convallis est,', 2, 37.00000, 79);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1283, 540, 2, 'quis, pede.', 4, 37.00000, 65);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1289, 805, 2, 'Cum sociis', 3, 24.00000, 86);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1293, 301, 2, 'a, arcu.', 5, 52.00000, 62);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1294, 168, 2, 'molestie tellus.', 3, 64.00000, 84);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1297, 115, 2, 'rutrum lorem', 2, 47.00000, 55);
INSERT INTO unc_248557.wireless_lineacomprobante VALUES (1299, 593, 2, 'amet risus.', 3, 45.00000, 55);


--
-- Data for Name: lugar; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_lugar VALUES (1, 'Bowden');
INSERT INTO unc_248557.wireless_lugar VALUES (2, 'Duns');
INSERT INTO unc_248557.wireless_lugar VALUES (3, 'Winchester');
INSERT INTO unc_248557.wireless_lugar VALUES (4, 'Montignoso');
INSERT INTO unc_248557.wireless_lugar VALUES (5, 'Alcalá de Henares');
INSERT INTO unc_248557.wireless_lugar VALUES (6, 'Rosoux-Crenwick');
INSERT INTO unc_248557.wireless_lugar VALUES (7, 'Bydgoszcz');
INSERT INTO unc_248557.wireless_lugar VALUES (8, 'Dongelberg');
INSERT INTO unc_248557.wireless_lugar VALUES (9, 'Helmond');
INSERT INTO unc_248557.wireless_lugar VALUES (10, 'Lairg');
INSERT INTO unc_248557.wireless_lugar VALUES (11, 'Lodine');
INSERT INTO unc_248557.wireless_lugar VALUES (12, 'Castelmarte');
INSERT INTO unc_248557.wireless_lugar VALUES (13, 'Banchory');
INSERT INTO unc_248557.wireless_lugar VALUES (14, 'Hattiesburg');
INSERT INTO unc_248557.wireless_lugar VALUES (15, 'Königs Wusterhausen');
INSERT INTO unc_248557.wireless_lugar VALUES (16, 'Marbella');
INSERT INTO unc_248557.wireless_lugar VALUES (17, 'Priolo Gargallo');
INSERT INTO unc_248557.wireless_lugar VALUES (18, 'Villenave-d''Ornon');
INSERT INTO unc_248557.wireless_lugar VALUES (19, 'Tulsa');
INSERT INTO unc_248557.wireless_lugar VALUES (20, 'Newark');
INSERT INTO unc_248557.wireless_lugar VALUES (21, 'Ostra Vetere');
INSERT INTO unc_248557.wireless_lugar VALUES (22, 'Fossato di Vico');
INSERT INTO unc_248557.wireless_lugar VALUES (23, 'Genappe');
INSERT INTO unc_248557.wireless_lugar VALUES (24, 'Cuenca');
INSERT INTO unc_248557.wireless_lugar VALUES (25, 'Gressoney-La-Trinitè');
INSERT INTO unc_248557.wireless_lugar VALUES (26, 'Motueka');
INSERT INTO unc_248557.wireless_lugar VALUES (27, 'Shillong');
INSERT INTO unc_248557.wireless_lugar VALUES (28, 'Roosbeek');
INSERT INTO unc_248557.wireless_lugar VALUES (29, 'Marsciano');
INSERT INTO unc_248557.wireless_lugar VALUES (30, 'Rocca d''Arce');


--
-- Data for Name: mail; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--



--
-- Data for Name: persona; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_persona VALUES (1, 'P', 'DNI', '24872875', 'Beau', 'Hammond', '1993-12-23 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (2, 'C', 'DNI', '29076703', 'Vladimir', 'Love', '1975-02-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (3, 'C', 'DNI', '20789135', 'Maris', 'Barker', '1958-12-19 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (4, 'C', 'DNI', '27890783', 'Tucker', 'Bonner', '1961-11-14 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (5, 'P', 'DNI', '17076853', 'Guy', 'Duke', '1949-09-14 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (6, 'C', 'DNI', '25167415', 'Cairo', 'Vega', '2004-01-27 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (7, 'P', 'DNI', '25277858', 'Aline', 'Trujillo', '1949-06-04 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (8, 'P', 'DNI', '14983174', 'Kyla', 'Wall', '1990-10-10 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (9, 'P', 'DNI', '13065374', 'Lavinia', 'Mckinney', '1984-10-31 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (10, 'C', 'DNI', '22178532', 'Nicholas', 'Oneal', '1968-11-05 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (11, 'P', 'LE', '12728069', 'Jaden', 'Ellison', '1930-07-27 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (12, 'P', 'LE', '17423074', 'Daquan', 'Joyner', '1987-07-29 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (13, 'C', 'LE', '13512556', 'Dora', 'Davidson', '1949-08-14 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (14, 'P', 'LE', '17747296', 'Naida', 'Mayer', '1944-11-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (15, 'C', 'LE', '27970012', 'Lawrence', 'Jensen', '1964-04-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (16, 'C', 'LE', '24894184', 'Lesley', 'Dale', '1969-10-07 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (17, 'P', 'LE', '17424204', 'Howard', 'Cooper', '1987-03-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (18, 'P', 'LE', '27251084', 'Lareina', 'Russell', '1934-12-19 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (19, 'P', 'LE', '13652876', 'Hall', 'Bridges', '1990-09-21 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (20, 'P', 'LE', '27623918', 'Preston', 'Reynolds', '1992-04-07 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (21, 'C', 'LC', '13996930', 'Rooney', 'Jensen', '2004-05-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (22, 'C', 'LC', '26369468', 'Willow', 'Hancock', '1971-05-25 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (23, 'C', 'LC', '16738422', 'Rahim', 'Collier', '1976-08-26 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (24, 'P', 'LC', '22033543', 'Delilah', 'Ward', '1935-11-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (25, 'P', 'LC', '28069684', 'Amery', 'Pacheco', '1931-04-13 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (26, 'C', 'LC', '25973526', 'Rahim', 'Massey', '1982-02-10 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (27, 'C', 'LC', '25970539', 'Beverly', 'Pratt', '1950-03-02 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (28, 'C', 'LC', '28301086', 'Harding', 'Hahn', '1967-02-20 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (29, 'C', 'LC', '12824696', 'Nerea', 'Lowe', '1943-12-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (30, 'P', 'LC', '16059920', 'Mercedes', 'Hayes', '1991-09-17 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (31, 'P', 'DNI', '21916589', 'Asher', 'Burton', '1979-08-26 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (32, 'C', 'DNI', '16190106', 'Robin', 'Holman', '1995-09-03 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (33, 'P', 'DNI', '12090986', 'Ora', 'Skinner', '1997-04-10 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (34, 'C', 'DNI', '13395205', 'Pandora', 'Marsh', '1967-09-14 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (35, 'C', 'DNI', '24847355', 'Brynne', 'Greene', '1984-11-12 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (36, 'P', 'DNI', '24226335', 'Georgia', 'Hansen', '1952-10-13 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (37, 'P', 'DNI', '20320355', 'Clinton', 'Gilmore', '1973-12-12 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (38, 'C', 'DNI', '14651738', 'Piper', 'Gamble', '1991-04-19 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (39, 'C', 'DNI', '13277564', 'Buffy', 'Fry', '1964-05-27 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (40, 'C', 'DNI', '20233505', 'Alexandra', 'Erickson', '1940-07-20 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (41, 'P', 'LE', '13576701', 'Knox', 'Anderson', '1946-10-20 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (42, 'C', 'LE', '11905386', 'Ava', 'Roach', '1955-05-13 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (43, 'C', 'LE', '23584509', 'Shaine', 'Bentley', '2014-03-19 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (44, 'P', 'LE', '27636378', 'Jin', 'Maxwell', '2010-02-10 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (45, 'P', 'LE', '22521202', 'Dieter', 'Wiggins', '1954-05-07 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (46, 'P', 'LE', '27494848', 'Althea', 'Lara', '2013-12-13 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (47, 'C', 'LE', '19301816', 'Quentin', 'Barker', '1975-09-28 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (48, 'C', 'LE', '25215448', 'Dana', 'Evans', '1971-02-25 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (49, 'C', 'LE', '14207148', 'Kirestin', 'Parker', '1962-08-26 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (50, 'P', 'LE', '12529625', 'Quyn', 'Booth', '1933-02-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (51, 'C', 'LC', '17887367', 'Gisela', 'Neal', '1949-10-04 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (52, 'C', 'LC', '21358392', 'Oliver', 'Bray', '1941-12-30 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (53, 'C', 'LC', '28818241', 'Emmanuel', 'Glass', '1957-12-20 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (54, 'C', 'LC', '12820965', 'Leah', 'Rodgers', '1938-05-01 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (55, 'P', 'LC', '26506156', 'Delilah', 'Mcknight', '1946-06-13 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (56, 'P', 'LC', '12429553', 'Hamish', 'Holman', '2009-04-05 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (57, 'C', 'LC', '10571767', 'William', 'Rich', '1972-11-26 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (58, 'C', 'LC', '27254743', 'Simon', 'Walsh', '1957-06-12 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (59, 'P', 'LC', '13364035', 'Finn', 'Hopper', '1969-06-02 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (60, 'P', 'LC', '11254242', 'Daphne', 'Ramsey', '1990-10-21 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (61, 'P', 'DNI', '28085657', 'Lucy', 'Wilkerson', '1950-02-08 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (62, 'P', 'DNI', '20611212', 'James', 'Hensley', '1984-05-23 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (63, 'C', 'DNI', '27635364', 'Rana', 'Ratliff', '1984-05-06 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (64, 'P', 'DNI', '21652640', 'Myles', 'Alford', '1971-10-08 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (65, 'P', 'DNI', '15247393', 'Shelly', 'Parks', '1936-04-22 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (66, 'C', 'DNI', '19828924', 'Orla', 'Moore', '1988-06-10 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (67, 'C', 'DNI', '10217217', 'Denton', 'Galloway', '1975-02-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (68, 'P', 'DNI', '17290636', 'Hedda', 'Davenport', '1985-12-06 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (69, 'C', 'DNI', '11624130', 'Sara', 'Campos', '1984-12-20 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (70, 'P', 'DNI', '24166752', 'Sacha', 'Waller', '1949-06-30 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (71, 'P', 'LE', '13969584', 'Ahmed', 'Edwards', '2015-02-27 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (72, 'P', 'LE', '28111517', 'Linda', 'Lopez', '1985-12-06 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (73, 'P', 'LE', '29896605', 'Arsenio', 'Patel', '1989-08-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (74, 'P', 'LE', '20623806', 'Britanni', 'Moss', '2000-07-16 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (75, 'P', 'LE', '24339056', 'Blaine', 'Padilla', '1956-05-14 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (76, 'C', 'LE', '24802236', 'Veda', 'Finley', '1984-09-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (77, 'C', 'LE', '15611666', 'Darrel', 'Hammond', '2003-12-02 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (78, 'P', 'LE', '14539813', 'Quintessa', 'Hendricks', '1986-12-03 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (79, 'P', 'LE', '16569069', 'Rachel', 'Grant', '1987-02-11 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (80, 'C', 'LE', '14793493', 'Raven', 'Pace', '1950-03-09 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (81, 'C', 'LC', '20382688', 'Hunter', 'Morales', '1980-09-11 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (82, 'P', 'LC', '15222558', 'Kevyn', 'Mayo', '2016-07-27 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (83, 'P', 'LC', '19057829', 'Catherine', 'Carney', '1999-08-23 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (84, 'C', 'LC', '26091188', 'Oprah', 'Bell', '1980-08-06 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (85, 'P', 'LC', '22887544', 'Bernard', 'Perez', '1937-11-11 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (86, 'P', 'LC', '16541190', 'Charity', 'Mcknight', '1952-11-05 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (87, 'C', 'LC', '19866083', 'Alisa', 'Irwin', '1954-04-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (88, 'C', 'LC', '24243159', 'Riley', 'Kinney', '2017-05-31 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (89, 'P', 'LC', '20609147', 'Kenneth', 'Lott', '2011-04-08 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (90, 'P', 'LC', '26061643', 'Ferdinand', 'Tillman', '1941-12-15 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (91, 'C', 'DNI', '17678199', 'Kitra', 'Powell', '1992-02-11 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (92, 'C', 'DNI', '23076250', 'Sydney', 'Mccarty', '1934-06-18 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (93, 'C', 'DNI', '27105778', 'Zelda', 'Richards', '2011-06-16 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (94, 'C', 'DNI', '19937693', 'Alden', 'Brown', '1978-01-19 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (95, 'P', 'DNI', '29421131', 'Eagan', 'Puckett', '1963-09-22 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (96, 'C', 'DNI', '20165140', 'Minerva', 'Thornton', '1938-06-22 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (97, 'C', 'DNI', '26459469', 'Alfreda', 'Sullivan', '2005-05-23 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (98, 'C', 'DNI', '22225038', 'Felicia', 'Benjamin', '1962-01-06 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (99, 'P', 'DNI', '20928269', 'Hanna', 'Haley', '1942-05-04 00:00:00', NULL, NULL, true);
INSERT INTO unc_248557.wireless_persona VALUES (100, 'P', 'DNI', '16295652', 'Noel', 'Strickland', '1987-10-24 00:00:00', NULL, NULL, true);


--
-- Data for Name: personal; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_personal VALUES (1, 5);
INSERT INTO unc_248557.wireless_personal VALUES (2, 4);
INSERT INTO unc_248557.wireless_personal VALUES (3, 3);
INSERT INTO unc_248557.wireless_personal VALUES (4, 2);
INSERT INTO unc_248557.wireless_personal VALUES (5, 3);
INSERT INTO unc_248557.wireless_personal VALUES (6, 3);
INSERT INTO unc_248557.wireless_personal VALUES (7, 2);
INSERT INTO unc_248557.wireless_personal VALUES (8, 1);
INSERT INTO unc_248557.wireless_personal VALUES (9, 2);
INSERT INTO unc_248557.wireless_personal VALUES (10, 4);
INSERT INTO unc_248557.wireless_personal VALUES (11, 2);
INSERT INTO unc_248557.wireless_personal VALUES (12, 1);
INSERT INTO unc_248557.wireless_personal VALUES (13, 4);
INSERT INTO unc_248557.wireless_personal VALUES (14, 3);
INSERT INTO unc_248557.wireless_personal VALUES (15, 3);
INSERT INTO unc_248557.wireless_personal VALUES (16, 4);
INSERT INTO unc_248557.wireless_personal VALUES (17, 5);
INSERT INTO unc_248557.wireless_personal VALUES (18, 1);
INSERT INTO unc_248557.wireless_personal VALUES (19, 1);
INSERT INTO unc_248557.wireless_personal VALUES (20, 2);
INSERT INTO unc_248557.wireless_personal VALUES (21, 2);
INSERT INTO unc_248557.wireless_personal VALUES (22, 4);
INSERT INTO unc_248557.wireless_personal VALUES (23, 4);
INSERT INTO unc_248557.wireless_personal VALUES (24, 2);
INSERT INTO unc_248557.wireless_personal VALUES (25, 1);
INSERT INTO unc_248557.wireless_personal VALUES (26, 1);
INSERT INTO unc_248557.wireless_personal VALUES (27, 5);
INSERT INTO unc_248557.wireless_personal VALUES (28, 1);
INSERT INTO unc_248557.wireless_personal VALUES (29, 2);
INSERT INTO unc_248557.wireless_personal VALUES (30, 5);


--
-- Data for Name: rol; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_rol VALUES (1, 'Admin');
INSERT INTO unc_248557.wireless_rol VALUES (2, 'operador');
INSERT INTO unc_248557.wireless_rol VALUES (3, 'Gerente');
INSERT INTO unc_248557.wireless_rol VALUES (4, 'Tecnico');
INSERT INTO unc_248557.wireless_rol VALUES (5, 'Admin');


--
-- Data for Name: servicio; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_servicio VALUES (1, 'facilisis, magna', true, 34.950, 5, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (2, 'cubilia Curae', true, 72.970, 10, 'quincena', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (3, 'auctor. Mauris', true, 53.750, 15, 'mes', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (4, 'nunc sed', true, 43.420, 20, 'bimestre', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (5, 'odio. Etiam', true, 9.300, 25, 'semana', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (6, 'ad litora', true, 69.320, 5, 'quincena', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (7, 'et, euismod', true, 7.220, 10, 'mes', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (8, 'Donec tempus,', true, 57.940, 15, 'bimestre', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (9, 'vitae, sodales', true, 92.260, 20, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (10, 'orci luctus', true, 54.670, 25, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (11, 'Cras interdum.', true, 70.720, 5, 'mes', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (12, 'justo sit', true, 71.290, 10, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (13, 'velit. Sed', true, 62.900, 15, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (14, 'magna nec', true, 71.910, 20, 'quincena', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (15, 'est ac', true, 19.640, 25, 'mes', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (16, 'augue ut', true, 1.330, 5, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (17, 'est. Nunc', true, 25.460, 10, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (18, 'velit justo', true, 78.070, 15, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (19, 'habitant morbi', true, 0.810, 20, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (20, 'Sed auctor', true, 69.040, 25, 'bimestre', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (21, 'ridiculus mus.', true, 84.330, 5, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (22, 'mattis. Integer', true, 20.860, 10, 'quincena', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (23, 'Cras pellentesque.', true, 65.170, 15, 'mes', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (24, 'Praesent eu', true, 43.760, 20, 'bimestre', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (25, 'fringilla. Donec', true, 99.270, 25, 'semana', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (26, 'fringilla, porttitor', true, 59.720, 5, 'quincena', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (27, 'eget lacus.', true, 77.710, 10, 'mes', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (28, 'Nullam feugiat', true, 82.520, 15, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (29, 'neque. Sed', true, 73.410, 20, 'semana', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (30, 'Phasellus dapibus', true, 51.990, 25, 'quincena', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (31, 'viverra. Donec', true, 96.330, 5, 'mes', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (32, 'eu metus.', true, 87.550, 10, 'bimestre', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (33, 'odio. Aliquam', true, 18.080, 15, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (34, 'accumsan neque', true, 45.410, 20, 'quincena', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (35, 'commodo ipsum.', true, 66.750, 25, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (36, 'amet orci.', true, 3.530, 5, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (37, 'vel quam', true, 39.150, 10, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (38, 'augue id', true, 3.310, 15, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (39, 'Quisque tincidunt', true, 23.240, 20, 'mes', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (40, 'egestas. Sed', true, 15.550, 25, 'bimestre', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (41, 'diam eu', true, 12.860, 5, 'semana', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (42, 'lorem ac', true, 78.310, 10, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (43, 'Donec dignissim', true, 24.590, 15, 'mes', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (44, 'Nunc ac', true, 5.090, 20, 'bimestre', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (45, 'nulla at', true, 61.630, 25, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (46, 'Etiam bibendum', true, 34.940, 5, 'quincena', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (47, 'sit amet', true, 87.220, 10, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (48, 'eget massa.', true, 81.520, 15, 'bimestre', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (49, 'diam luctus', true, 81.140, 20, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (50, 'Lorem ipsum', true, 26.620, 25, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (51, 'tristique pellentesque,', false, 37.520, NULL, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (52, 'odio. Nam', false, 30.610, NULL, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (53, 'nec, imperdiet', false, 19.040, NULL, 'mes', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (54, 'lobortis, nisi', false, 20.660, NULL, 'bimestre', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (55, 'lacus. Aliquam', false, 12.730, NULL, 'semana', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (56, 'sociis natoque', false, 22.020, NULL, 'quincena', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (57, 'odio. Phasellus', false, 42.850, NULL, 'mes', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (58, 'a, arcu.', false, 73.230, NULL, 'bimestre', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (59, 'sagittis placerat.', false, 40.720, NULL, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (60, 'ipsum dolor', false, 74.510, NULL, 'quincena', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (61, 'condimentum eget,', false, 57.420, NULL, 'mes', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (62, 'amet, consectetuer', false, 13.460, NULL, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (63, 'Morbi neque', false, 10.190, NULL, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (64, 'ornare, lectus', false, 62.340, NULL, 'quincena', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (65, 'purus sapien,', false, 36.020, NULL, 'mes', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (66, 'vel, venenatis', false, 0.420, NULL, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (67, 'lobortis, nisi', false, 51.450, NULL, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (68, 'Nullam nisl.', false, 18.890, NULL, 'quincena', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (69, 'arcu iaculis', false, 99.060, NULL, 'mes', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (70, 'facilisis non,', false, 51.160, NULL, 'bimestre', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (71, 'tellus faucibus', false, 13.340, NULL, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (72, 'a mi', false, 34.890, NULL, 'quincena', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (73, 'dictum eleifend,', false, 85.350, NULL, 'mes', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (74, 'tincidunt orci', false, 93.830, NULL, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (75, 'porttitor tellus', false, 51.830, NULL, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (76, 'nunc est,', false, 39.310, NULL, 'quincena', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (77, 'sit amet', false, 0.000, NULL, 'mes', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (78, 'sapien, gravida', false, 54.200, NULL, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (79, 'arcu. Vestibulum', false, 43.880, NULL, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (80, 'erat vitae', false, 96.820, NULL, 'quincena', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (81, 'sit amet', false, 90.530, NULL, 'mes', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (82, 'rutrum magna.', false, 42.340, NULL, 'bimestre', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (83, 'arcu. Vestibulum', false, 33.330, NULL, 'semana', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (84, 'nunc. Quisque', false, 14.110, NULL, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (85, 'Morbi metus.', false, 8.760, NULL, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (86, 'nec luctus', false, 5.530, NULL, 'bimestre', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (87, 'et risus.', false, 57.280, NULL, 'semana', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (88, 'eget, dictum', false, 63.490, NULL, 'quincena', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (89, 'condimentum eget,', false, 6.990, NULL, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (90, 'interdum ligula', false, 40.050, NULL, 'bimestre', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (91, 'felis. Nulla', false, 55.100, NULL, 'semana', true, 2);
INSERT INTO unc_248557.wireless_servicio VALUES (92, 'parturient montes,', false, 29.260, NULL, 'quincena', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (93, 'in consectetuer', false, 70.380, NULL, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (94, 'felis eget', false, 71.670, NULL, 'bimestre', true, 4);
INSERT INTO unc_248557.wireless_servicio VALUES (95, 'sed consequat', false, 76.700, NULL, 'semana', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (96, 'orci quis', false, 45.270, NULL, 'quincena', true, 5);
INSERT INTO unc_248557.wireless_servicio VALUES (97, 'amet, faucibus', false, 42.950, NULL, 'mes', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (98, 'est, mollis', false, 0.060, NULL, 'bimestre', true, 1);
INSERT INTO unc_248557.wireless_servicio VALUES (99, 'Class aptent', false, 40.890, NULL, 'semana', true, 3);
INSERT INTO unc_248557.wireless_servicio VALUES (100, 'ac ipsum.', false, 21.090, NULL, 'quincena', true, 1);


--
-- Data for Name: telefono; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--



--
-- Data for Name: tipocomprobante; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_tipocomprobante VALUES (1, 'Factura', 'A');
INSERT INTO unc_248557.wireless_tipocomprobante VALUES (2, 'Remito', 'B');
INSERT INTO unc_248557.wireless_tipocomprobante VALUES (3, 'Recibo', 'C');


--
-- Data for Name: turno; Type: TABLE DATA; Schema: unc_esq_wireless; Owner: unc_248557
--

INSERT INTO unc_248557.wireless_turno VALUES (1, 29, '2006-09-04 09:04:32', '2006-09-04 17:04:32', 395.410, 1437.460, 27);
INSERT INTO unc_248557.wireless_turno VALUES (2, 21, '2013-03-01 17:53:52', '2013-03-02 01:53:52', 475.390, 1726.480, 13);
INSERT INTO unc_248557.wireless_turno VALUES (3, 28, '2009-01-01 21:52:05', '2009-01-02 05:52:05', 556.940, 2385.920, 16);
INSERT INTO unc_248557.wireless_turno VALUES (4, 9, '2011-01-05 21:50:40', '2011-01-06 05:50:40', 426.720, 921.580, 16);
INSERT INTO unc_248557.wireless_turno VALUES (5, 20, '2000-07-25 02:32:16', '2000-07-25 10:32:16', 687.060, 2090.100, 19);
INSERT INTO unc_248557.wireless_turno VALUES (6, 29, '2004-05-18 15:20:08', '2004-05-18 23:20:08', 500.040, 2306.820, 21);
INSERT INTO unc_248557.wireless_turno VALUES (7, 24, '2008-12-01 20:26:22', '2008-12-02 04:26:22', 145.840, 145.840, 11);
INSERT INTO unc_248557.wireless_turno VALUES (8, 9, '2006-03-13 04:39:03', '2006-03-13 12:39:03', 563.880, 1327.770, 4);
INSERT INTO unc_248557.wireless_turno VALUES (9, 7, '2009-09-22 04:17:22', '2009-09-22 12:17:22', 391.510, 391.510, 25);
INSERT INTO unc_248557.wireless_turno VALUES (10, 18, '2017-02-11 04:29:19', '2017-02-11 12:29:19', 968.230, 2101.020, 30);
INSERT INTO unc_248557.wireless_turno VALUES (11, 4, '2004-12-19 04:46:31', '2004-12-19 12:46:31', 386.840, 386.840, 3);
INSERT INTO unc_248557.wireless_turno VALUES (12, 22, '2007-09-22 03:41:04', '2007-09-22 11:41:04', 463.230, 522.750, 19);
INSERT INTO unc_248557.wireless_turno VALUES (13, 16, '2011-12-16 09:43:38', '2011-12-16 17:43:38', 869.520, 1770.080, 4);
INSERT INTO unc_248557.wireless_turno VALUES (14, 19, '2003-03-30 11:53:50', '2003-03-30 19:53:50', 276.870, 402.160, 18);
INSERT INTO unc_248557.wireless_turno VALUES (15, 8, '2007-03-29 02:56:40', '2007-03-29 10:56:40', 781.460, 1730.430, 23);
INSERT INTO unc_248557.wireless_turno VALUES (16, 6, '2008-12-06 11:17:07', '2008-12-06 19:17:07', 395.730, 395.730, 1);
INSERT INTO unc_248557.wireless_turno VALUES (17, 5, '2011-05-12 04:07:50', '2011-05-12 12:07:50', 261.530, 2723.370, 4);
INSERT INTO unc_248557.wireless_turno VALUES (18, 7, '2006-06-23 21:16:21', '2006-06-24 05:16:21', 470.760, 1340.640, 2);
INSERT INTO unc_248557.wireless_turno VALUES (19, 20, '2002-02-26 13:59:33', '2002-02-26 21:59:33', 15.300, 822.610, 18);
INSERT INTO unc_248557.wireless_turno VALUES (20, 9, '2000-02-08 06:17:07', '2000-02-08 14:17:07', 147.310, 147.310, 11);
INSERT INTO unc_248557.wireless_turno VALUES (21, 27, '2008-10-31 12:12:07', '2008-10-31 20:12:07', 692.820, 1342.240, 28);
INSERT INTO unc_248557.wireless_turno VALUES (22, 11, '2006-02-18 04:09:35', '2006-02-18 12:09:35', 225.590, 2413.800, 21);
INSERT INTO unc_248557.wireless_turno VALUES (23, 13, '2008-11-23 04:52:18', '2008-11-23 12:52:18', 619.240, 2100.540, 9);
INSERT INTO unc_248557.wireless_turno VALUES (24, 11, '2006-06-11 00:41:40', '2006-06-11 08:41:40', 668.130, 1832.440, 2);
INSERT INTO unc_248557.wireless_turno VALUES (25, 19, '2000-07-23 14:46:01', '2000-07-23 22:46:01', 85.730, 85.730, 11);
INSERT INTO unc_248557.wireless_turno VALUES (26, 28, '2009-09-27 22:30:22', '2009-09-28 06:30:22', 516.070, 516.070, 17);
INSERT INTO unc_248557.wireless_turno VALUES (27, 21, '2015-07-29 18:08:26', '2015-07-30 02:08:26', 929.020, 2002.320, 24);
INSERT INTO unc_248557.wireless_turno VALUES (28, 6, '2006-07-18 07:37:26', '2006-07-18 15:37:26', 461.470, 1971.280, 11);
INSERT INTO unc_248557.wireless_turno VALUES (29, 18, '2002-09-30 04:21:54', '2002-09-30 12:21:54', 51.610, 543.090, 3);
INSERT INTO unc_248557.wireless_turno VALUES (30, 14, '2015-01-18 17:54:01', '2015-01-19 01:54:01', 452.960, 1634.130, 10);
INSERT INTO unc_248557.wireless_turno VALUES (31, 21, '2013-08-18 07:28:39', '2013-08-18 15:28:39', 28.810, 897.850, 17);
INSERT INTO unc_248557.wireless_turno VALUES (32, 8, '2001-07-31 23:27:13', '2001-08-01 07:27:13', 595.500, 871.820, 13);
INSERT INTO unc_248557.wireless_turno VALUES (33, 19, '2009-12-02 21:54:29', '2009-12-03 05:54:29', 232.620, 3047.960, 21);
INSERT INTO unc_248557.wireless_turno VALUES (34, 14, '2004-02-05 02:59:53', '2004-02-05 10:59:53', 70.480, 1521.690, 1);
INSERT INTO unc_248557.wireless_turno VALUES (35, 2, '2010-10-25 01:59:34', '2010-10-25 09:59:34', 835.450, 1424.540, 7);
INSERT INTO unc_248557.wireless_turno VALUES (36, 4, '2004-09-30 22:21:26', '2004-10-01 06:21:26', 656.790, 817.650, 6);
INSERT INTO unc_248557.wireless_turno VALUES (37, 11, '2009-01-08 04:53:37', '2009-01-08 12:53:37', 831.010, 1347.530, 11);
INSERT INTO unc_248557.wireless_turno VALUES (38, 27, '2013-04-20 09:34:54', '2013-04-20 17:34:54', 155.710, 694.660, 16);
INSERT INTO unc_248557.wireless_turno VALUES (39, 19, '2000-11-11 05:55:34', '2000-11-11 13:55:34', 565.050, 864.080, 7);
INSERT INTO unc_248557.wireless_turno VALUES (40, 17, '2002-08-31 15:15:52', '2002-08-31 23:15:52', 475.880, 475.880, 5);
INSERT INTO unc_248557.wireless_turno VALUES (41, 28, '2004-12-19 03:20:56', '2004-12-19 11:20:56', 860.210, 1219.030, 10);
INSERT INTO unc_248557.wireless_turno VALUES (42, 23, '2000-09-19 02:33:37', '2000-09-19 10:33:37', 425.530, 425.530, 20);
INSERT INTO unc_248557.wireless_turno VALUES (43, 4, '2004-07-03 09:11:56', '2004-07-03 17:11:56', 551.230, 551.230, 1);
INSERT INTO unc_248557.wireless_turno VALUES (44, 9, '2000-07-26 07:40:54', '2000-07-26 15:40:54', 84.740, 1053.410, 19);
INSERT INTO unc_248557.wireless_turno VALUES (45, 20, '2003-04-27 04:41:15', '2003-04-27 12:41:15', 729.100, 2596.760, 6);
INSERT INTO unc_248557.wireless_turno VALUES (46, 10, '2001-05-28 22:03:08', '2001-05-29 06:03:08', 151.010, 746.970, 17);
INSERT INTO unc_248557.wireless_turno VALUES (47, 9, '2002-01-26 01:22:44', '2002-01-26 09:22:44', 347.920, 347.920, 30);
INSERT INTO unc_248557.wireless_turno VALUES (48, 17, '2006-05-07 03:15:44', '2006-05-07 11:15:44', 565.160, 2528.220, 18);
INSERT INTO unc_248557.wireless_turno VALUES (49, 13, '2000-10-13 11:07:49', '2000-10-13 19:07:49', 182.520, 891.210, 22);
INSERT INTO unc_248557.wireless_turno VALUES (50, 8, '2003-06-04 18:58:22', '2003-06-05 02:58:22', 889.240, 1030.400, 1);
INSERT INTO unc_248557.wireless_turno VALUES (51, 2, '2008-06-08 19:58:04', '2008-06-09 03:58:04', 262.620, 862.510, 24);
INSERT INTO unc_248557.wireless_turno VALUES (52, 12, '2013-11-05 10:51:55', '2013-11-05 18:51:55', 42.570, 42.570, 26);
INSERT INTO unc_248557.wireless_turno VALUES (53, 7, '2000-09-02 21:55:45', '2000-09-03 05:55:45', 18.140, 392.230, 25);
INSERT INTO unc_248557.wireless_turno VALUES (54, 24, '2000-06-10 03:00:13', '2000-06-10 11:00:13', 75.060, 816.750, 3);
INSERT INTO unc_248557.wireless_turno VALUES (55, 13, '2002-11-02 20:23:41', '2002-11-03 04:23:41', 565.600, 1307.640, 11);
INSERT INTO unc_248557.wireless_turno VALUES (56, 8, '2003-07-20 01:52:58', '2003-07-20 09:52:58', 10.960, 1930.630, 6);
INSERT INTO unc_248557.wireless_turno VALUES (57, 4, '2011-11-19 06:19:12', '2011-11-19 14:19:12', 607.020, 1479.140, 16);
INSERT INTO unc_248557.wireless_turno VALUES (58, 7, '2015-01-09 02:49:17', '2015-01-09 10:49:17', 720.130, 4738.720, 17);
INSERT INTO unc_248557.wireless_turno VALUES (59, 12, '2014-06-02 06:53:16', '2014-06-02 14:53:16', 958.710, 1863.330, 6);
INSERT INTO unc_248557.wireless_turno VALUES (60, 13, '2004-03-26 17:20:32', '2004-03-27 01:20:32', 633.860, 948.110, 24);
INSERT INTO unc_248557.wireless_turno VALUES (61, 4, '2004-07-23 12:12:47', '2004-07-23 20:12:47', 9.090, 105.440, 18);
INSERT INTO unc_248557.wireless_turno VALUES (62, 6, '2016-01-26 05:15:45', '2016-01-26 13:15:45', 866.910, 1262.200, 30);
INSERT INTO unc_248557.wireless_turno VALUES (63, 6, '2015-01-12 21:18:58', '2015-01-13 05:18:58', 718.220, 1805.200, 16);
INSERT INTO unc_248557.wireless_turno VALUES (64, 20, '2002-12-18 09:08:46', '2002-12-18 17:08:46', 374.900, 374.900, 11);
INSERT INTO unc_248557.wireless_turno VALUES (65, 21, '2008-09-04 10:08:51', '2008-09-04 18:08:51', 305.840, 1852.180, 24);
INSERT INTO unc_248557.wireless_turno VALUES (66, 16, '2000-03-17 02:59:04', '2000-03-17 10:59:04', 519.720, 1452.710, 6);
INSERT INTO unc_248557.wireless_turno VALUES (67, 29, '2001-03-24 05:04:56', '2001-03-24 13:04:56', 838.040, 838.040, 7);
INSERT INTO unc_248557.wireless_turno VALUES (68, 8, '2003-04-06 15:56:54', '2003-04-06 23:56:54', 347.560, 2166.650, 21);
INSERT INTO unc_248557.wireless_turno VALUES (69, 13, '2004-07-18 20:57:37', '2004-07-19 04:57:37', 644.430, 644.430, 27);
INSERT INTO unc_248557.wireless_turno VALUES (70, 9, '2012-05-11 01:51:35', '2012-05-11 09:51:35', 271.750, 513.170, 14);
INSERT INTO unc_248557.wireless_turno VALUES (71, 8, '2015-10-16 08:56:33', '2015-10-16 16:56:33', 235.260, 980.350, 17);
INSERT INTO unc_248557.wireless_turno VALUES (72, 4, '2006-12-27 01:43:55', '2006-12-27 09:43:55', 538.590, 1223.670, 30);
INSERT INTO unc_248557.wireless_turno VALUES (73, 15, '2000-01-31 12:08:14', '2000-01-31 20:08:14', 933.700, 1729.770, 9);
INSERT INTO unc_248557.wireless_turno VALUES (74, 24, '2005-09-29 16:19:19', '2005-09-30 00:19:19', 565.100, 873.830, 20);
INSERT INTO unc_248557.wireless_turno VALUES (75, 7, '2001-06-21 05:12:41', '2001-06-21 13:12:41', 314.350, 2755.890, 2);
INSERT INTO unc_248557.wireless_turno VALUES (76, 14, '2002-08-27 15:14:45', '2002-08-27 23:14:45', 865.580, 1522.410, 15);
INSERT INTO unc_248557.wireless_turno VALUES (77, 19, '2001-12-09 07:45:13', '2001-12-09 15:45:13', 877.770, 2634.970, 1);
INSERT INTO unc_248557.wireless_turno VALUES (78, 12, '2012-05-04 00:58:17', '2012-05-04 08:58:17', 153.980, 501.380, 10);
INSERT INTO unc_248557.wireless_turno VALUES (79, 9, '2000-11-05 00:57:42', '2000-11-05 08:57:42', 539.010, 1399.030, 11);
INSERT INTO unc_248557.wireless_turno VALUES (80, 29, '2004-02-16 23:05:21', '2004-02-17 07:05:21', 880.720, 880.720, 29);
INSERT INTO unc_248557.wireless_turno VALUES (81, 14, '2011-10-31 23:08:27', '2011-11-01 07:08:27', 222.690, 222.690, 7);
INSERT INTO unc_248557.wireless_turno VALUES (82, 8, '2013-09-10 14:54:34', '2013-09-10 22:54:34', 642.380, 642.380, 20);
INSERT INTO unc_248557.wireless_turno VALUES (83, 19, '2000-10-10 06:50:43', '2000-10-10 14:50:43', 490.760, 1021.670, 27);
INSERT INTO unc_248557.wireless_turno VALUES (84, 16, '2011-05-27 12:20:47', '2011-05-27 20:20:47', 246.880, 2334.790, 20);
INSERT INTO unc_248557.wireless_turno VALUES (85, 19, '2011-04-17 00:00:44', '2011-04-17 08:00:44', 461.100, 1067.010, 30);
INSERT INTO unc_248557.wireless_turno VALUES (86, 6, '2002-08-06 13:45:43', '2002-08-06 21:45:43', 363.840, 595.950, 6);
INSERT INTO unc_248557.wireless_turno VALUES (87, 18, '2012-07-28 07:53:51', '2012-07-28 15:53:51', 953.830, 953.830, 30);
INSERT INTO unc_248557.wireless_turno VALUES (88, 15, '2000-09-29 16:31:53', '2000-09-30 00:31:53', 435.980, 1387.830, 22);
INSERT INTO unc_248557.wireless_turno VALUES (89, 10, '2002-04-19 16:51:24', '2002-04-20 00:51:24', 542.130, 1030.400, 7);
INSERT INTO unc_248557.wireless_turno VALUES (90, 7, '2005-02-27 12:19:51', '2005-02-27 20:19:51', 475.900, 475.900, 12);
INSERT INTO unc_248557.wireless_turno VALUES (91, 29, '2002-09-29 21:18:25', '2002-09-30 05:18:25', 977.670, 977.670, 20);
INSERT INTO unc_248557.wireless_turno VALUES (92, 17, '2015-10-26 14:10:36', '2015-10-26 22:10:36', 536.310, 1499.700, 16);
INSERT INTO unc_248557.wireless_turno VALUES (93, 8, '2016-08-20 05:52:52', '2016-08-20 13:52:52', 756.830, 1976.300, 18);
INSERT INTO unc_248557.wireless_turno VALUES (94, 16, '2000-02-01 22:44:07', '2000-02-02 06:44:07', 812.750, 2330.730, 26);
INSERT INTO unc_248557.wireless_turno VALUES (95, 6, '2016-09-06 19:30:05', '2016-09-07 03:30:05', 858.830, 1211.320, 3);
INSERT INTO unc_248557.wireless_turno VALUES (96, 9, '2001-02-22 02:03:45', '2001-02-22 10:03:45', 525.060, 1300.940, 12);
INSERT INTO unc_248557.wireless_turno VALUES (97, 7, '2011-10-31 16:18:21', '2011-11-01 00:18:21', 30.880, 505.420, 28);
INSERT INTO unc_248557.wireless_turno VALUES (98, 19, '2009-01-15 01:23:28', '2009-01-15 09:23:28', 862.430, 991.320, 7);
INSERT INTO unc_248557.wireless_turno VALUES (99, 8, '2011-05-22 10:12:18', '2011-05-22 18:12:18', 819.880, 1823.930, 30);
INSERT INTO unc_248557.wireless_turno VALUES (100, 21, '2011-05-21 18:20:48', '2011-05-22 02:20:48', 390.040, 390.040, 9);
INSERT INTO unc_248557.wireless_turno VALUES (101, 6, '2015-05-22 13:04:21', '2015-05-22 21:04:21', 30.760, 828.900, 30);
INSERT INTO unc_248557.wireless_turno VALUES (102, 26, '2006-01-28 08:50:08', '2006-01-28 16:50:08', 841.440, 841.440, 25);
INSERT INTO unc_248557.wireless_turno VALUES (103, 15, '2017-07-27 08:40:04', '2017-07-27 16:40:04', 300.930, 300.930, 3);
INSERT INTO unc_248557.wireless_turno VALUES (104, 27, '2011-02-21 12:27:30', '2011-02-21 20:27:30', 46.890, 996.400, 26);
INSERT INTO unc_248557.wireless_turno VALUES (105, 22, '2012-01-26 06:29:20', '2012-01-26 14:29:20', 876.700, 1794.580, 19);
INSERT INTO unc_248557.wireless_turno VALUES (106, 6, '2003-06-12 19:10:53', '2003-06-13 03:10:53', 350.150, 350.150, 29);
INSERT INTO unc_248557.wireless_turno VALUES (107, 2, '2007-07-06 09:36:07', '2007-07-06 17:36:07', 894.650, 943.820, 21);
INSERT INTO unc_248557.wireless_turno VALUES (108, 8, '2002-12-16 04:11:45', '2002-12-16 12:11:45', 220.220, 285.750, 15);
INSERT INTO unc_248557.wireless_turno VALUES (109, 12, '2010-03-21 01:51:39', '2010-03-21 09:51:39', 700.990, 700.990, 18);
INSERT INTO unc_248557.wireless_turno VALUES (110, 19, '2000-02-19 19:55:16', '2000-02-20 03:55:16', 614.680, 1023.180, 9);
INSERT INTO unc_248557.wireless_turno VALUES (111, 24, '2004-01-18 12:08:18', '2004-01-18 20:08:18', 454.560, 3350.050, 24);
INSERT INTO unc_248557.wireless_turno VALUES (112, 17, '2010-04-18 21:53:03', '2010-04-19 05:53:03', 134.140, 919.910, 2);
INSERT INTO unc_248557.wireless_turno VALUES (113, 29, '2017-06-09 13:27:54', '2017-06-09 21:27:54', 525.560, 525.560, 17);
INSERT INTO unc_248557.wireless_turno VALUES (114, 10, '2001-06-09 07:32:36', '2001-06-09 15:32:36', 153.670, 862.650, 20);
INSERT INTO unc_248557.wireless_turno VALUES (115, 11, '2014-06-26 05:46:16', '2014-06-26 13:46:16', 964.620, 1766.580, 6);
INSERT INTO unc_248557.wireless_turno VALUES (116, 4, '2013-05-28 22:16:53', '2013-05-29 06:16:53', 115.980, 929.310, 14);
INSERT INTO unc_248557.wireless_turno VALUES (117, 10, '2001-04-06 10:07:14', '2001-04-06 18:07:14', 433.000, 2601.340, 18);
INSERT INTO unc_248557.wireless_turno VALUES (118, 4, '2003-03-13 00:47:26', '2003-03-13 08:47:26', 619.390, 2193.840, 26);
INSERT INTO unc_248557.wireless_turno VALUES (119, 7, '2015-02-02 20:59:28', '2015-02-03 04:59:28', 390.800, 1525.480, 16);
INSERT INTO unc_248557.wireless_turno VALUES (120, 30, '2002-10-15 23:52:40', '2002-10-16 07:52:40', 546.760, 1323.940, 23);
INSERT INTO unc_248557.wireless_turno VALUES (121, 3, '2000-06-08 19:52:35', '2000-06-09 03:52:35', 55.260, 55.260, 13);
INSERT INTO unc_248557.wireless_turno VALUES (122, 5, '2010-03-09 10:02:26', '2010-03-09 18:02:26', 494.170, 2264.680, 5);
INSERT INTO unc_248557.wireless_turno VALUES (123, 3, '2013-10-09 11:09:12', '2013-10-09 19:09:12', 846.670, 2001.690, 11);
INSERT INTO unc_248557.wireless_turno VALUES (124, 27, '2005-05-28 05:47:25', '2005-05-28 13:47:25', 454.450, 744.770, 1);
INSERT INTO unc_248557.wireless_turno VALUES (125, 25, '2011-04-16 22:38:53', '2011-04-17 06:38:53', 543.900, 573.410, 28);
INSERT INTO unc_248557.wireless_turno VALUES (126, 22, '2003-02-17 16:56:41', '2003-02-18 00:56:41', 312.450, 312.450, 30);
INSERT INTO unc_248557.wireless_turno VALUES (127, 8, '2004-07-24 05:04:16', '2004-07-24 13:04:16', 694.900, 2189.560, 10);
INSERT INTO unc_248557.wireless_turno VALUES (128, 23, '2004-06-25 11:28:59', '2004-06-25 19:28:59', 883.000, 1733.590, 18);
INSERT INTO unc_248557.wireless_turno VALUES (129, 2, '2010-12-02 14:47:49', '2010-12-02 22:47:49', 3.700, 207.630, 23);
INSERT INTO unc_248557.wireless_turno VALUES (130, 11, '2015-02-20 14:13:34', '2015-02-20 22:13:34', 376.820, 1890.360, 11);
INSERT INTO unc_248557.wireless_turno VALUES (131, 8, '2010-11-10 16:20:50', '2010-11-11 00:20:50', 373.850, 1682.950, 13);
INSERT INTO unc_248557.wireless_turno VALUES (132, 3, '2014-11-05 15:28:47', '2014-11-05 23:28:47', 77.770, 828.940, 19);
INSERT INTO unc_248557.wireless_turno VALUES (133, 16, '2016-01-30 20:11:09', '2016-01-31 04:11:09', 434.240, 434.240, 8);
INSERT INTO unc_248557.wireless_turno VALUES (134, 18, '2010-09-14 16:27:48', '2010-09-15 00:27:48', 66.560, 66.560, 27);
INSERT INTO unc_248557.wireless_turno VALUES (135, 7, '2012-12-26 08:58:48', '2012-12-26 16:58:48', 400.820, 895.480, 4);
INSERT INTO unc_248557.wireless_turno VALUES (136, 6, '2006-11-19 16:41:36', '2006-11-20 00:41:36', 998.300, 1604.630, 13);
INSERT INTO unc_248557.wireless_turno VALUES (137, 3, '2004-06-24 17:43:22', '2004-06-25 01:43:22', 350.290, 350.290, 19);
INSERT INTO unc_248557.wireless_turno VALUES (138, 15, '2017-03-19 03:33:56', '2017-03-19 11:33:56', 180.730, 1470.230, 14);
INSERT INTO unc_248557.wireless_turno VALUES (139, 17, '2017-08-10 23:17:36', '2017-08-11 07:17:36', 822.380, 1591.710, 29);
INSERT INTO unc_248557.wireless_turno VALUES (140, 19, '2013-07-20 10:28:41', '2013-07-20 18:28:41', 771.680, 968.140, 27);
INSERT INTO unc_248557.wireless_turno VALUES (141, 18, '2015-02-18 13:36:19', '2015-02-18 21:36:19', 600.320, 2386.070, 17);
INSERT INTO unc_248557.wireless_turno VALUES (142, 6, '2014-02-14 19:59:06', '2014-02-15 03:59:06', 865.990, 1789.000, 26);
INSERT INTO unc_248557.wireless_turno VALUES (143, 19, '2006-07-17 13:59:53', '2006-07-17 21:59:53', 129.450, 775.980, 18);
INSERT INTO unc_248557.wireless_turno VALUES (144, 19, '2012-03-19 20:41:49', '2012-03-20 04:41:49', 411.760, 1146.150, 27);
INSERT INTO unc_248557.wireless_turno VALUES (145, 5, '2001-03-18 22:10:16', '2001-03-19 06:10:16', 463.780, 463.780, 9);
INSERT INTO unc_248557.wireless_turno VALUES (146, 22, '2015-05-25 22:52:02', '2015-05-26 06:52:02', 814.890, 1847.220, 18);
INSERT INTO unc_248557.wireless_turno VALUES (147, 20, '2016-01-02 23:35:17', '2016-01-03 07:35:17', 208.570, 2302.830, 2);
INSERT INTO unc_248557.wireless_turno VALUES (148, 13, '2014-05-15 01:47:06', '2014-05-15 09:47:06', 787.990, 2270.300, 2);
INSERT INTO unc_248557.wireless_turno VALUES (149, 30, '2004-06-16 19:15:44', '2004-06-17 03:15:44', 296.840, 1229.700, 12);
INSERT INTO unc_248557.wireless_turno VALUES (150, 28, '2015-09-04 04:24:15', '2015-09-04 12:24:15', 868.060, 2357.180, 22);
INSERT INTO unc_248557.wireless_turno VALUES (151, 2, '2015-10-05 07:27:01', '2015-10-05 15:27:01', 990.860, 1147.470, 17);
INSERT INTO unc_248557.wireless_turno VALUES (152, 6, '2009-03-03 23:49:28', '2009-03-04 07:49:28', 350.360, 1765.180, 16);
INSERT INTO unc_248557.wireless_turno VALUES (153, 3, '2000-06-29 17:20:29', '2000-06-30 01:20:29', 848.660, 2603.080, 22);
INSERT INTO unc_248557.wireless_turno VALUES (154, 19, '2005-04-09 20:36:23', '2005-04-10 04:36:23', 5.720, 1360.620, 11);
INSERT INTO unc_248557.wireless_turno VALUES (155, 7, '2000-10-23 07:56:12', '2000-10-23 15:56:12', 407.430, 1403.920, 14);
INSERT INTO unc_248557.wireless_turno VALUES (156, 1, '2002-01-17 05:11:55', '2002-01-17 13:11:55', 372.960, 372.960, 14);
INSERT INTO unc_248557.wireless_turno VALUES (157, 9, '2005-04-09 08:13:42', '2005-04-09 16:13:42', 50.160, 50.160, 16);
INSERT INTO unc_248557.wireless_turno VALUES (158, 13, '2008-05-23 20:37:58', '2008-05-24 04:37:58', 303.750, 1424.220, 29);
INSERT INTO unc_248557.wireless_turno VALUES (159, 6, '2007-09-05 01:25:19', '2007-09-05 09:25:19', 788.160, 1177.830, 30);
INSERT INTO unc_248557.wireless_turno VALUES (160, 5, '2000-05-21 04:42:34', '2000-05-21 12:42:34', 494.710, 1452.240, 19);
INSERT INTO unc_248557.wireless_turno VALUES (161, 16, '2006-07-09 10:45:03', '2006-07-09 18:45:03', 951.730, 1903.460, 25);
INSERT INTO unc_248557.wireless_turno VALUES (162, 18, '2010-07-08 19:56:26', '2010-07-09 03:56:26', 938.290, 2017.620, 24);
INSERT INTO unc_248557.wireless_turno VALUES (163, 27, '2009-08-04 02:49:03', '2009-08-04 10:49:03', 404.410, 1233.440, 29);
INSERT INTO unc_248557.wireless_turno VALUES (164, 2, '2012-09-29 01:32:47', '2012-09-29 09:32:47', 842.140, 1382.380, 21);
INSERT INTO unc_248557.wireless_turno VALUES (165, 6, '2014-12-06 20:27:46', '2014-12-07 04:27:46', 594.830, 1286.640, 6);
INSERT INTO unc_248557.wireless_turno VALUES (166, 16, '2011-01-31 18:37:04', '2011-02-01 02:37:04', 618.840, 654.500, 9);
INSERT INTO unc_248557.wireless_turno VALUES (167, 26, '2006-01-25 07:52:45', '2006-01-25 15:52:45', 197.560, 474.900, 14);
INSERT INTO unc_248557.wireless_turno VALUES (168, 26, '2012-01-08 05:11:56', '2012-01-08 13:11:56', 915.910, 1866.430, 21);
INSERT INTO unc_248557.wireless_turno VALUES (169, 14, '2005-08-07 14:34:15', '2005-08-07 22:34:15', 180.010, 180.010, 21);
INSERT INTO unc_248557.wireless_turno VALUES (170, 1, '2009-11-27 11:17:54', '2009-11-27 19:17:54', 648.830, 987.030, 15);
INSERT INTO unc_248557.wireless_turno VALUES (171, 25, '2008-10-13 11:16:57', '2008-10-13 19:16:57', 51.220, 1024.330, 4);
INSERT INTO unc_248557.wireless_turno VALUES (172, 9, '2001-07-25 20:38:10', '2001-07-26 04:38:10', 163.590, 1010.030, 18);
INSERT INTO unc_248557.wireless_turno VALUES (173, 23, '2008-12-14 21:39:09', '2008-12-15 05:39:09', 191.170, 1295.580, 7);
INSERT INTO unc_248557.wireless_turno VALUES (174, 17, '2004-03-13 03:58:51', '2004-03-13 11:58:51', 43.540, 1682.320, 7);
INSERT INTO unc_248557.wireless_turno VALUES (175, 16, '2004-04-07 19:15:43', '2004-04-08 03:15:43', 340.620, 340.620, 17);
INSERT INTO unc_248557.wireless_turno VALUES (176, 15, '2012-07-08 07:27:22', '2012-07-08 15:27:22', 405.240, 405.240, 29);
INSERT INTO unc_248557.wireless_turno VALUES (177, 17, '2006-12-27 20:55:21', '2006-12-28 04:55:21', 628.010, 628.010, 23);
INSERT INTO unc_248557.wireless_turno VALUES (178, 3, '2000-08-22 07:30:09', '2000-08-22 15:30:09', 815.410, 1762.980, 14);
INSERT INTO unc_248557.wireless_turno VALUES (179, 21, '2006-09-13 21:58:58', '2006-09-14 05:58:58', 401.950, 1058.610, 6);
INSERT INTO unc_248557.wireless_turno VALUES (180, 12, '2000-08-27 02:22:38', '2000-08-27 10:22:38', 411.060, 2794.560, 25);
INSERT INTO unc_248557.wireless_turno VALUES (181, 22, '2014-12-11 06:52:16', '2014-12-11 14:52:16', 997.810, 1563.740, 24);
INSERT INTO unc_248557.wireless_turno VALUES (182, 13, '2014-04-30 07:27:05', '2014-04-30 15:27:05', 956.530, 1950.400, 16);
INSERT INTO unc_248557.wireless_turno VALUES (183, 11, '2015-07-26 10:27:45', '2015-07-26 18:27:45', 908.980, 2176.850, 11);
INSERT INTO unc_248557.wireless_turno VALUES (184, 30, '2014-03-17 10:49:35', '2014-03-17 18:49:35', 795.430, 1777.250, 28);
INSERT INTO unc_248557.wireless_turno VALUES (185, 18, '2009-12-17 20:35:18', '2009-12-18 04:35:18', 347.870, 1359.460, 5);
INSERT INTO unc_248557.wireless_turno VALUES (186, 26, '2009-04-05 20:03:58', '2009-04-06 04:03:58', 181.930, 1017.130, 7);
INSERT INTO unc_248557.wireless_turno VALUES (187, 7, '2015-03-12 16:45:19', '2015-03-13 00:45:19', 483.260, 2197.420, 7);
INSERT INTO unc_248557.wireless_turno VALUES (188, 25, '2016-06-19 01:09:57', '2016-06-19 09:09:57', 458.610, 458.610, 8);
INSERT INTO unc_248557.wireless_turno VALUES (189, 12, '2001-07-12 01:39:35', '2001-07-12 09:39:35', 841.450, 1600.690, 13);
INSERT INTO unc_248557.wireless_turno VALUES (190, 20, '2002-11-06 15:33:02', '2002-11-06 23:33:02', 355.230, 2066.760, 17);
INSERT INTO unc_248557.wireless_turno VALUES (191, 6, '2001-11-18 02:13:40', '2001-11-18 10:13:40', 54.640, 54.640, 24);
INSERT INTO unc_248557.wireless_turno VALUES (192, 13, '2000-07-12 05:30:46', '2000-07-12 13:30:46', 743.350, 743.350, 2);
INSERT INTO unc_248557.wireless_turno VALUES (193, 5, '2004-06-22 21:23:16', '2004-06-23 05:23:16', 624.230, 1660.040, 4);
INSERT INTO unc_248557.wireless_turno VALUES (194, 24, '2001-05-26 18:38:27', '2001-05-27 02:38:27', 218.300, 451.880, 25);
INSERT INTO unc_248557.wireless_turno VALUES (195, 11, '2006-08-08 00:01:37', '2006-08-08 08:01:37', 326.820, 326.820, 16);
INSERT INTO unc_248557.wireless_turno VALUES (196, 3, '2015-07-01 12:14:19', '2015-07-01 20:14:19', 32.310, 1409.770, 16);
INSERT INTO unc_248557.wireless_turno VALUES (197, 25, '2001-05-19 09:47:50', '2001-05-19 17:47:50', 333.300, 2248.730, 30);
INSERT INTO unc_248557.wireless_turno VALUES (198, 16, '2009-02-26 21:57:08', '2009-02-27 05:57:08', 237.700, 237.700, 8);
INSERT INTO unc_248557.wireless_turno VALUES (199, 16, '2011-03-22 19:38:24', '2011-03-23 03:38:24', 495.620, 1219.830, 24);
INSERT INTO unc_248557.wireless_turno VALUES (200, 27, '2015-05-06 06:59:34', '2015-05-06 14:59:34', 52.810, 52.810, 10);


--
-- Name: barrio barrio_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_barrio
    ADD CONSTRAINT wireless_barrio_pk PRIMARY KEY (id_barrio);


--
-- Name: categoria categoria_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_categoria
    ADD CONSTRAINT wireless_categoria_pk PRIMARY KEY (id_cat);


--
-- Name: ciudad ciudad_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_ciudad
    ADD CONSTRAINT wireless_ciudad_pk PRIMARY KEY (id_ciudad);


--
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_cliente
    ADD CONSTRAINT wireless_cliente_pk PRIMARY KEY (id_cliente);


--
-- Name: direccion direccion_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_direccion
    ADD CONSTRAINT wireless_direccion_pk PRIMARY KEY (id_direccion, id_persona);


--
-- Name: equipo equipo_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_equipo
    ADD CONSTRAINT wireless_equipo_pk PRIMARY KEY (id_equipo);


--
-- Name: mail mail_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_mail
    ADD CONSTRAINT wireless_mail_pk PRIMARY KEY (id_persona, mail);


--
-- Name: personal personal_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_personal
    ADD CONSTRAINT wireless_personal_pk PRIMARY KEY (id_personal);


--
-- Name: comprobante pk_comprobante; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_comprobante
    ADD CONSTRAINT wireless_pk_comprobante PRIMARY KEY (id_comp, id_tcomp);


--
-- Name: lineacomprobante pk_lineacomp; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_lineacomprobante
    ADD CONSTRAINT wireless_pk_lineacomp PRIMARY KEY (nro_linea, id_comp, id_tcomp);


--
-- Name: lugar pk_lugar; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_lugar
    ADD CONSTRAINT wireless_pk_lugar PRIMARY KEY (id_lugar);


--
-- Name: persona pk_persona; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_persona
    ADD CONSTRAINT wireless_pk_persona PRIMARY KEY (id_persona);


--
-- Name: servicio pk_servicio; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_servicio
    ADD CONSTRAINT wireless_pk_servicio PRIMARY KEY (id_servicio);


--
-- Name: tipocomprobante pk_tipo_comprobante; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_tipocomprobante
    ADD CONSTRAINT wireless_pk_tipo_comprobante PRIMARY KEY (id_tcomp);


--
-- Name: rol rol_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_rol
    ADD CONSTRAINT wireless_rol_pk PRIMARY KEY (id_rol);


--
-- Name: telefono telefono_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_telefono
    ADD CONSTRAINT wireless_telefono_pk PRIMARY KEY (id_persona, carac, numero);


--
-- Name: turno turno_pk; Type: CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_turno
    ADD CONSTRAINT wireless_turno_pk PRIMARY KEY (id_turno);


--
-- Name: barrio fk_barrio_ciudad; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_barrio
    ADD CONSTRAINT wireless_fk_barrio_ciudad FOREIGN KEY (id_ciudad) REFERENCES unc_248557.wireless_ciudad(id_ciudad);


--
-- Name: cliente fk_cliente_persona; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_cliente
    ADD CONSTRAINT wireless_fk_cliente_persona FOREIGN KEY (id_cliente) REFERENCES unc_248557.wireless_persona(id_persona);


--
-- Name: comprobante fk_comprobante_cliente; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_comprobante
    ADD CONSTRAINT wireless_fk_comprobante_cliente FOREIGN KEY (id_cliente) REFERENCES unc_248557.wireless_cliente(id_cliente);


--
-- Name: comprobante fk_comprobante_lugar; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_comprobante
    ADD CONSTRAINT wireless_fk_comprobante_lugar FOREIGN KEY (id_lugar) REFERENCES unc_248557.wireless_lugar(id_lugar);


--
-- Name: comprobante fk_comprobante_tipocomprobante; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_comprobante
    ADD CONSTRAINT wireless_fk_comprobante_tipocomprobante FOREIGN KEY (id_tcomp) REFERENCES unc_248557.wireless_tipocomprobante(id_tcomp);


--
-- Name: comprobante fk_comprobante_turno; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_comprobante
    ADD CONSTRAINT wireless_fk_comprobante_turno FOREIGN KEY (id_turno) REFERENCES unc_248557.wireless_turno(id_turno);


--
-- Name: direccion fk_direccion; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_direccion
    ADD CONSTRAINT wireless_fk_direccion FOREIGN KEY (id_persona) REFERENCES unc_248557.wireless_persona(id_persona);


--
-- Name: direccion fk_direccion_barrio; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_direccion
    ADD CONSTRAINT wireless_fk_direccion_barrio FOREIGN KEY (id_barrio) REFERENCES unc_248557.wireless_barrio(id_barrio);


--
-- Name: equipo fk_equipo_cliente; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_equipo
    ADD CONSTRAINT wireless_fk_equipo_cliente FOREIGN KEY (id_cliente) REFERENCES unc_248557.wireless_cliente(id_cliente);


--
-- Name: equipo fk_equipo_servicio; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_equipo
    ADD CONSTRAINT wireless_fk_equipo_servicio FOREIGN KEY (id_servicio) REFERENCES unc_248557.wireless_servicio(id_servicio);


--
-- Name: lineacomprobante fk_lineacomprobante_comprobante; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_lineacomprobante
    ADD CONSTRAINT wireless_fk_lineacomprobante_comprobante FOREIGN KEY (id_comp, id_tcomp) REFERENCES unc_248557.wireless_comprobante(id_comp, id_tcomp);


--
-- Name: mail fk_mail_persona; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_mail
    ADD CONSTRAINT wireless_fk_mail_persona FOREIGN KEY (id_persona) REFERENCES unc_248557.wireless_persona(id_persona);


--
-- Name: personal fk_personal_persona; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_personal
    ADD CONSTRAINT wireless_fk_personal_persona FOREIGN KEY (id_personal) REFERENCES unc_248557.wireless_persona(id_persona);


--
-- Name: personal fk_personal_rol; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_personal
    ADD CONSTRAINT wireless_fk_personal_rol FOREIGN KEY (id_rol) REFERENCES unc_248557.wireless_rol(id_rol);


--
-- Name: turno fk_personal_turno; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_turno
    ADD CONSTRAINT wireless_fk_personal_turno FOREIGN KEY (id_personal) REFERENCES unc_248557.wireless_personal(id_personal);


--
-- Name: servicio fk_servicio_categoria; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_servicio
    ADD CONSTRAINT wireless_fk_servicio_categoria FOREIGN KEY (id_cat) REFERENCES unc_248557.wireless_categoria(id_cat);


--
-- Name: telefono fk_telefono; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_telefono
    ADD CONSTRAINT wireless_fk_telefono FOREIGN KEY (id_persona) REFERENCES unc_248557.wireless_persona(id_persona);


--
-- Name: turno fk_turno_lugar; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_turno
    ADD CONSTRAINT wireless_fk_turno_lugar FOREIGN KEY (id_lugar) REFERENCES unc_248557.wireless_lugar(id_lugar);


--
-- Name: lineacomprobante lineacomprobante_servicio; Type: FK CONSTRAINT; Schema: unc_esq_wireless; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.wireless_lineacomprobante
    ADD CONSTRAINT wireless_lineacomprobante_servicio FOREIGN KEY (id_servicio) REFERENCES unc_248557.wireless_servicio(id_servicio);


--
-- Name: SCHEMA unc_esq_wireless; Type: ACL; Schema: -; Owner: unc_248557
--

GRANT ALL ON SCHEMA unc_esq_wireless TO unc_staff;
GRANT USAGE ON SCHEMA unc_esq_wireless TO PUBLIC;


--
-- Name: TABLE equipo; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_equipo TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_equipo TO PUBLIC;


--
-- Name: TABLE barrio; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_barrio TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_barrio TO PUBLIC;


--
-- Name: TABLE categoria; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_categoria TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_categoria TO PUBLIC;


--
-- Name: TABLE ciudad; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_ciudad TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_ciudad TO PUBLIC;


--
-- Name: TABLE cliente; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_cliente TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_cliente TO PUBLIC;


--
-- Name: TABLE comprobante; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_comprobante TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_comprobante TO PUBLIC;


--
-- Name: TABLE direccion; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_direccion TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_direccion TO PUBLIC;


--
-- Name: TABLE lineacomprobante; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_lineacomprobante TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_lineacomprobante TO PUBLIC;


--
-- Name: TABLE lugar; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_lugar TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_lugar TO PUBLIC;


--
-- Name: TABLE mail; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_mail TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_mail TO PUBLIC;


--
-- Name: TABLE persona; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_persona TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_persona TO PUBLIC;


--
-- Name: TABLE personal; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_personal TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_personal TO PUBLIC;


--
-- Name: TABLE rol; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_rol TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_rol TO PUBLIC;


--
-- Name: TABLE servicio; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_servicio TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_servicio TO PUBLIC;


--
-- Name: TABLE telefono; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_telefono TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_telefono TO PUBLIC;


--
-- Name: TABLE tipocomprobante; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_tipocomprobante TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_tipocomprobante TO PUBLIC;


--
-- Name: TABLE turno; Type: ACL; Schema: unc_esq_wireless; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.wireless_turno TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.wireless_turno TO PUBLIC;


--
-- unc_248557QL database dump complete
--

