


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ciudad; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_ciudad (
    cod_ciudad integer NOT NULL,
    ciudad character varying(60) NOT NULL,
    pais character varying(40) NOT NULL
);


ALTER TABLE unc_248557.dptos_ciudad OWNER TO unc_248557;

--
-- Name: comentario; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_comentario (
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    id_reserva integer NOT NULL,
    fecha_hora_comentario date NOT NULL,
    comentario character varying(2048) NOT NULL,
    puntuacion integer NOT NULL
);


ALTER TABLE unc_248557.dptos_comentario OWNER TO unc_248557;

--
-- Name: costo_depto; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_costo_depto (
    id_dpto integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    precio_noche numeric(10,2) NOT NULL
);


ALTER TABLE unc_248557.dptos_costo_depto OWNER TO unc_248557;

--
-- Name: costo_hab; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_costo_hab (
    id_dpto integer NOT NULL,
    id_habitacion integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    precio_noche numeric(10,2) NOT NULL
);


ALTER TABLE unc_248557.dptos_costo_hab OWNER TO unc_248557;

--
-- Name: departamento; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_departamento (
    id_dpto integer NOT NULL,
    descripcion character varying(80) NOT NULL,
    superficie numeric(10,2) NOT NULL,
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    id_tipo_depto integer NOT NULL,
    precio_noche numeric(10,2) NOT NULL,
    cod_ciudad integer NOT NULL,
    fecha_alta date NOT NULL
);


ALTER TABLE unc_248557.dptos_departamento OWNER TO unc_248557;

--
-- Name: departamentoamplio; Type: VIEW; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE VIEW unc_248557.dptos_departamentoamplio AS
 SELECT d.id_dpto,
    d.descripcion,
    d.superficie,
    d.tipo_doc,
    d.nro_doc,
    d.id_tipo_depto,
    d.precio_noche,
    d.cod_ciudad,
    d.fecha_alta
   FROM unc_248557.dptos_departamento d
  WHERE (d.superficie > (80)::numeric)
  WITH LOCAL CHECK OPTION;


ALTER TABLE unc_248557.dptos_departamentoamplio OWNER TO unc_248557;

--
-- Name: edo_luego_ocupacion; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_edo_luego_ocupacion (
    id_reserva integer NOT NULL,
    fecha date NOT NULL,
    comentario character varying(2048) NOT NULL
);


ALTER TABLE unc_248557.dptos_edo_luego_ocupacion OWNER TO unc_248557;

--
-- Name: pago; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_pago (
    fecha_pago timestamp without time zone NOT NULL,
    id_reserva integer NOT NULL,
    id_tipo_pago integer NOT NULL,
    comentario character varying(80),
    importe numeric(8,3) NOT NULL
);


ALTER TABLE unc_248557.dptos_pago OWNER TO unc_248557;

--
-- Name: reserva; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_reserva (
    id_reserva integer NOT NULL,
    fecha_reserva date NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    precio_noche numeric(10,2) NOT NULL,
    precio_limpieza numeric(5,3) NOT NULL,
    cancelada boolean NOT NULL,
    tipo_res character(1) NOT NULL
);


ALTER TABLE unc_248557.dptos_reserva OWNER TO unc_248557;

--
-- Name: estadoreserva; Type: VIEW; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE VIEW unc_248557.dptos_estadoreserva AS
 SELECT r.id_reserva,
    r.cancelada
   FROM unc_248557.dptos_reserva r
  WHERE (r.id_reserva IN ( SELECT p.id_reserva
           FROM unc_248557.dptos_pago p
          WHERE (p.importe > (1050)::numeric)));


ALTER TABLE unc_248557.dptos_estadoreserva OWNER TO unc_248557;

--
-- Name: habitacion; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_habitacion (
    id_dpto integer NOT NULL,
    id_habitacion integer NOT NULL,
    posib_camas_simples integer NOT NULL,
    posib_camas_dobles integer NOT NULL,
    posib_camas_kind integer NOT NULL,
    tv boolean NOT NULL,
    sillon integer NOT NULL,
    frigobar integer NOT NULL,
    mesa boolean NOT NULL,
    sillas integer NOT NULL,
    cocina boolean NOT NULL,
    precio_noche numeric(10,2) NOT NULL
);


ALTER TABLE unc_248557.dptos_habitacion OWNER TO unc_248557;

--
-- Name: habitacionsimple; Type: VIEW; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE VIEW unc_248557.dptos_habitacionsimple AS
 SELECT h.id_dpto,
    h.id_habitacion,
    h.posib_camas_simples,
    h.posib_camas_dobles,
    h.posib_camas_kind,
    h.tv,
    h.sillon,
    h.frigobar,
    h.mesa,
    h.sillas,
    h.cocina,
    h.precio_noche
   FROM unc_248557.dptos_habitacion h
  WHERE (h.posib_camas_simples > 3)
  WITH LOCAL CHECK OPTION;


ALTER TABLE unc_248557.dptos_habitacionsimple OWNER TO unc_248557;

--
-- Name: habitacionmix; Type: VIEW; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE VIEW unc_248557.dptos_habitacionmix AS
 SELECT h.id_dpto,
    h.id_habitacion,
    h.posib_camas_simples,
    h.posib_camas_dobles,
    h.posib_camas_kind,
    h.tv,
    h.sillon,
    h.frigobar,
    h.mesa,
    h.sillas,
    h.cocina,
    h.precio_noche
   FROM unc_248557.dptos_habitacionsimple h
  WHERE (h.frigobar = 1)
  WITH LOCAL CHECK OPTION;


ALTER TABLE unc_248557.dptos_habitacionmix OWNER TO unc_248557;

--
-- Name: huesped; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_huesped (
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    cant_res_efectivas integer NOT NULL
);


ALTER TABLE unc_248557.dptos_huesped OWNER TO unc_248557;

--
-- Name: huesped_reserva; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_huesped_reserva (
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    id_reserva integer NOT NULL
);


ALTER TABLE unc_248557.dptos_huesped_reserva OWNER TO unc_248557;

--
-- Name: monoambienteamplio; Type: VIEW; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE VIEW unc_248557.dptos_monoambienteamplio AS
 SELECT a.id_dpto,
    a.descripcion,
    a.superficie,
    a.tipo_doc,
    a.nro_doc,
    a.id_tipo_depto,
    a.precio_noche,
    a.cod_ciudad,
    a.fecha_alta
   FROM unc_248557.dptos_departamentoamplio a
  WHERE (a.id_tipo_depto = 3)
  WITH LOCAL CHECK OPTION;


ALTER TABLE unc_248557.dptos_monoambienteamplio OWNER TO unc_248557;

--
-- Name: persona; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_persona (
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    apellido character varying(80) NOT NULL,
    nombre character varying(80) NOT NULL,
    fecha_nac date NOT NULL,
    e_mail character varying(120) NOT NULL
);


ALTER TABLE unc_248557.dptos_persona OWNER TO unc_248557;

--
-- Name: propietario; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_propietario (
    tipo_doc character(3) NOT NULL,
    nro_doc numeric(11,0) NOT NULL,
    calificacion integer NOT NULL
);


ALTER TABLE unc_248557.dptos_propietario OWNER TO unc_248557;

--
-- Name: reserva_dpto; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_reserva_dpto (
    id_reserva integer NOT NULL,
    id_dpto integer NOT NULL
);


ALTER TABLE unc_248557.dptos_reserva_dpto OWNER TO unc_248557;

--
-- Name: reserva_hab; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_reserva_hab (
    id_reserva integer NOT NULL,
    id_dpto integer NOT NULL,
    id_habitacion integer NOT NULL
);


ALTER TABLE unc_248557.dptos_reserva_hab OWNER TO unc_248557;

--
-- Name: tipo_dpto; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_tipo_dpto (
    id_tipo_depto integer NOT NULL,
    cant_habitaciones integer NOT NULL,
    cant_banios integer NOT NULL,
    cant_max_huespedes integer NOT NULL
);


ALTER TABLE unc_248557.dptos_tipo_dpto OWNER TO unc_248557;

--
-- Name: tipo_pago; Type: TABLE; Schema: unc_esq_dptos; Owner: unc_248557
--

CREATE TABLE unc_248557.dptos_tipo_pago (
    id_tipo_pago integer NOT NULL,
    empresa character varying(30) NOT NULL
);


ALTER TABLE unc_248557.dptos_tipo_pago OWNER TO unc_248557;

--
-- Data for Name: ciudad; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_ciudad VALUES (1, 'Aliano', 'Bosnia and Herzegovina');
INSERT INTO unc_248557.dptos_ciudad VALUES (2, 'Açailândia', 'Belarus');
INSERT INTO unc_248557.dptos_ciudad VALUES (3, 'Sluizen', 'Kyrgyzstan');
INSERT INTO unc_248557.dptos_ciudad VALUES (4, 'Petit-Thier', 'Denmark');
INSERT INTO unc_248557.dptos_ciudad VALUES (5, 'Kilmalcolm', 'Kyrgyzstan');
INSERT INTO unc_248557.dptos_ciudad VALUES (6, 'Namur', 'Lesotho');
INSERT INTO unc_248557.dptos_ciudad VALUES (7, 'Overland Park', 'Kazakhstan');
INSERT INTO unc_248557.dptos_ciudad VALUES (8, 'Woodstock', 'Sri Lanka');
INSERT INTO unc_248557.dptos_ciudad VALUES (9, 'Salzgitter', 'Falkland Islands');
INSERT INTO unc_248557.dptos_ciudad VALUES (10, 'Puri', 'Afghanistan');
INSERT INTO unc_248557.dptos_ciudad VALUES (11, 'Tarsus', 'Turkmenistan');
INSERT INTO unc_248557.dptos_ciudad VALUES (12, 'Auckland', 'New Caledonia');
INSERT INTO unc_248557.dptos_ciudad VALUES (13, 'Terrance', 'Germany');
INSERT INTO unc_248557.dptos_ciudad VALUES (14, 'Redlands', 'Venezuela');
INSERT INTO unc_248557.dptos_ciudad VALUES (15, 'Rabbi', 'Virgin Islands, United States');
INSERT INTO unc_248557.dptos_ciudad VALUES (16, 'Moustier-sur-Sambre', 'Turks and Caicos Islands');
INSERT INTO unc_248557.dptos_ciudad VALUES (17, 'Montese', 'Curaçao');
INSERT INTO unc_248557.dptos_ciudad VALUES (18, 'San Felice a Cancello', 'Costa Rica');
INSERT INTO unc_248557.dptos_ciudad VALUES (19, 'Burdinne', 'Brunei');
INSERT INTO unc_248557.dptos_ciudad VALUES (20, 'Płock', 'Paraguay');
INSERT INTO unc_248557.dptos_ciudad VALUES (21, 'Redwater', 'Lithuania');
INSERT INTO unc_248557.dptos_ciudad VALUES (22, 'Märsta', 'Andorra');
INSERT INTO unc_248557.dptos_ciudad VALUES (23, 'Waterbury', 'Azerbaijan');
INSERT INTO unc_248557.dptos_ciudad VALUES (24, 'Lens-Saint-Servais', 'Kenya');
INSERT INTO unc_248557.dptos_ciudad VALUES (25, 'Gaggio Montano', 'Gambia');
INSERT INTO unc_248557.dptos_ciudad VALUES (26, 'Rueglio', 'Sudan');
INSERT INTO unc_248557.dptos_ciudad VALUES (28, 'Placanica', 'Germany');
INSERT INTO unc_248557.dptos_ciudad VALUES (29, 'Coldstream', 'Taiwan');
INSERT INTO unc_248557.dptos_ciudad VALUES (30, 'Wolvertem', 'Georgia');
INSERT INTO unc_248557.dptos_ciudad VALUES (31, 'Somma Lombardo', 'Guinea-Bissau');
INSERT INTO unc_248557.dptos_ciudad VALUES (32, 'Wick', 'Singapore');
INSERT INTO unc_248557.dptos_ciudad VALUES (33, 'Maaseik', 'Vanuatu');
INSERT INTO unc_248557.dptos_ciudad VALUES (34, 'Umbertide', 'Guernsey');
INSERT INTO unc_248557.dptos_ciudad VALUES (35, 'Steyr', 'Guernsey');
INSERT INTO unc_248557.dptos_ciudad VALUES (36, 'Santa Cesarea Terme', 'Swaziland');
INSERT INTO unc_248557.dptos_ciudad VALUES (37, 'Lerwick', 'Australia');
INSERT INTO unc_248557.dptos_ciudad VALUES (38, 'Schifferstadt', 'Maldives');
INSERT INTO unc_248557.dptos_ciudad VALUES (39, 'Gujranwala', 'United States');
INSERT INTO unc_248557.dptos_ciudad VALUES (40, 'Chepstow', 'Armenia');
INSERT INTO unc_248557.dptos_ciudad VALUES (41, 'Hoorn', 'Venezuela');
INSERT INTO unc_248557.dptos_ciudad VALUES (42, 'Talcahuano', 'New Caledonia');
INSERT INTO unc_248557.dptos_ciudad VALUES (43, 'Chiauci', 'Côte D''Ivoire (Ivory Coast)');
INSERT INTO unc_248557.dptos_ciudad VALUES (44, 'Sauvenire', 'Central African Republic');
INSERT INTO unc_248557.dptos_ciudad VALUES (45, 'Neustrelitz', 'French Polynesia');
INSERT INTO unc_248557.dptos_ciudad VALUES (46, 'Manoppello', 'Nicaragua');
INSERT INTO unc_248557.dptos_ciudad VALUES (47, 'Heist-op-den-Berg', 'El Salvador');
INSERT INTO unc_248557.dptos_ciudad VALUES (48, 'Khammam', 'France');
INSERT INTO unc_248557.dptos_ciudad VALUES (49, 'Renaico', 'Belgium');
INSERT INTO unc_248557.dptos_ciudad VALUES (50, 'Şanlıurfa', 'Sri Lanka');
INSERT INTO unc_248557.dptos_ciudad VALUES (51, 'Großpetersdorf', 'San Marino');
INSERT INTO unc_248557.dptos_ciudad VALUES (52, 'Grezzana', 'Guinea-Bissau');
INSERT INTO unc_248557.dptos_ciudad VALUES (53, 'Arauco', 'Oman');
INSERT INTO unc_248557.dptos_ciudad VALUES (54, 'Gullegem', 'Greenland');
INSERT INTO unc_248557.dptos_ciudad VALUES (55, 'Dover', 'Laos');
INSERT INTO unc_248557.dptos_ciudad VALUES (56, 'Midway', 'Morocco');
INSERT INTO unc_248557.dptos_ciudad VALUES (57, 'Sijsele', 'Cayman Islands');
INSERT INTO unc_248557.dptos_ciudad VALUES (58, 'Wiesbaden', 'Gabon');
INSERT INTO unc_248557.dptos_ciudad VALUES (59, 'Eckernförde', 'Turks and Caicos Islands');
INSERT INTO unc_248557.dptos_ciudad VALUES (60, 'Riparbella', 'Romania');
INSERT INTO unc_248557.dptos_ciudad VALUES (61, 'Vejalpur', 'Jersey');
INSERT INTO unc_248557.dptos_ciudad VALUES (62, 'Nedlands', 'Armenia');
INSERT INTO unc_248557.dptos_ciudad VALUES (63, 'Saint-GŽry', 'British Indian Ocean Territory');
INSERT INTO unc_248557.dptos_ciudad VALUES (64, 'Yaxley', 'Honduras');
INSERT INTO unc_248557.dptos_ciudad VALUES (65, 'Orléans', 'Angola');
INSERT INTO unc_248557.dptos_ciudad VALUES (66, 'Worksop', 'New Caledonia');
INSERT INTO unc_248557.dptos_ciudad VALUES (67, 'Jamoigne', 'Thailand');
INSERT INTO unc_248557.dptos_ciudad VALUES (68, 'Barrhead', 'Norfolk Island');
INSERT INTO unc_248557.dptos_ciudad VALUES (69, 'Hudson''s Hope', 'Slovakia');
INSERT INTO unc_248557.dptos_ciudad VALUES (70, 'Brandenburg', 'Iceland');
INSERT INTO unc_248557.dptos_ciudad VALUES (71, 'Murray Bridge', 'Belarus');
INSERT INTO unc_248557.dptos_ciudad VALUES (72, 'Valfabbrica', 'Portugal');
INSERT INTO unc_248557.dptos_ciudad VALUES (73, 'Birmingham', 'Iran');
INSERT INTO unc_248557.dptos_ciudad VALUES (74, 'Perth', 'Cuba');
INSERT INTO unc_248557.dptos_ciudad VALUES (75, 'Torres del Paine', 'Belize');
INSERT INTO unc_248557.dptos_ciudad VALUES (76, 'Reutlingen', 'Sierra Leone');
INSERT INTO unc_248557.dptos_ciudad VALUES (77, 'Braunau am Inn', 'Sint Maarten');
INSERT INTO unc_248557.dptos_ciudad VALUES (78, 'Melle', 'Peru');
INSERT INTO unc_248557.dptos_ciudad VALUES (79, 'Sint-Kruis-Winkel', 'Paraguay');
INSERT INTO unc_248557.dptos_ciudad VALUES (80, 'Palena', 'Guam');
INSERT INTO unc_248557.dptos_ciudad VALUES (81, 'Wansin', 'Afghanistan');
INSERT INTO unc_248557.dptos_ciudad VALUES (82, 'Oldenburg', 'Austria');
INSERT INTO unc_248557.dptos_ciudad VALUES (83, 'Olivola', 'Singapore');
INSERT INTO unc_248557.dptos_ciudad VALUES (84, 'Torquay', 'Algeria');
INSERT INTO unc_248557.dptos_ciudad VALUES (85, 'Konstanz', 'Congo (Brazzaville)');
INSERT INTO unc_248557.dptos_ciudad VALUES (86, 'Hawick', 'Gambia');
INSERT INTO unc_248557.dptos_ciudad VALUES (87, 'Sagar', 'Congo, the Democratic Republic of the');
INSERT INTO unc_248557.dptos_ciudad VALUES (88, 'Savannah', 'Iraq');
INSERT INTO unc_248557.dptos_ciudad VALUES (89, 'Ballarat', 'Togo');
INSERT INTO unc_248557.dptos_ciudad VALUES (90, 'Lossiemouth', 'Denmark');
INSERT INTO unc_248557.dptos_ciudad VALUES (91, 'De Haan', 'Brazil');
INSERT INTO unc_248557.dptos_ciudad VALUES (92, 'Narbolia', 'Russian Federation');
INSERT INTO unc_248557.dptos_ciudad VALUES (93, 'Gavorrano', 'Northern Mariana Islands');
INSERT INTO unc_248557.dptos_ciudad VALUES (94, 'Puqueldón', 'Luxembourg');
INSERT INTO unc_248557.dptos_ciudad VALUES (95, 'Barbania', 'Zambia');
INSERT INTO unc_248557.dptos_ciudad VALUES (96, 'Caplan', 'Germany');
INSERT INTO unc_248557.dptos_ciudad VALUES (97, 'Smetlede', 'Serbia');
INSERT INTO unc_248557.dptos_ciudad VALUES (98, 'Halifax', 'United States');
INSERT INTO unc_248557.dptos_ciudad VALUES (99, 'Venlo', 'Tokelau');
INSERT INTO unc_248557.dptos_ciudad VALUES (100, 'Chapadinha', 'Ghana');


--
-- Data for Name: comentario; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_comentario VALUES ('DNI', 17794714, 9, '2017-09-03', 'El departamento es muy confortable', 4);
INSERT INTO unc_248557.dptos_comentario VALUES ('DNI', 15798702, 14, '2017-08-09', 'Departamento muy confortable', 4);
INSERT INTO unc_248557.dptos_comentario VALUES ('DNI', 17794714, 9, '2018-11-02', 'Buen departamento', 3);
INSERT INTO unc_248557.dptos_comentario VALUES ('DNI', 15798702, 14, '2018-11-02', 'Buen departamento', 3);


--
-- Data for Name: costo_depto; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--



--
-- Data for Name: costo_hab; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--



--
-- Data for Name: departamento; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_departamento VALUES (48, 'lacus. Aliquam rutrum lorem', 53.58, 'PAS', 29184888, 8, 768.53, 38, '2003-04-09');
INSERT INTO unc_248557.dptos_departamento VALUES (3, 'Integer id magna et ipsum', 64.31, 'LE ', 21583861, 2, 275.19, 64, '2003-01-09');
INSERT INTO unc_248557.dptos_departamento VALUES (5, 'Integer sem elit, pharetra', 71.54, 'LE ', 21791086, 7, 944.45, 100, '2003-05-17');
INSERT INTO unc_248557.dptos_departamento VALUES (69, 'amet nulla. Donec non justo.', 33.75, 'PAS', 13124491, 4, 582.02, 57, '2000-11-26');
INSERT INTO unc_248557.dptos_departamento VALUES (23, 'orci', 12.04, 'DNI', 27875790, 4, 895.31, 69, '2002-05-16');
INSERT INTO unc_248557.dptos_departamento VALUES (78, 'Proin dolor.', 35.77, 'LE ', 21510699, 5, 681.99, 91, '2000-11-21');
INSERT INTO unc_248557.dptos_departamento VALUES (65, 'ornare', 56.34, 'LE ', 6794352, 4, 898.05, 4, '2003-03-29');
INSERT INTO unc_248557.dptos_departamento VALUES (71, 'penatibus et magnis dis', 92.73, 'LC ', 22313653, 8, 630.51, 29, '2001-11-02');
INSERT INTO unc_248557.dptos_departamento VALUES (51, 'cursus', 93.60, 'LC ', 12441796, 4, 454.94, 66, '2002-07-14');
INSERT INTO unc_248557.dptos_departamento VALUES (66, 'Fusce', 69.58, 'LE ', 27190774, 3, 911.01, 15, '2001-07-30');
INSERT INTO unc_248557.dptos_departamento VALUES (62, 'a nunc. In', 9.26, 'PAS', 24494743, 4, 936.27, 29, '2001-04-04');
INSERT INTO unc_248557.dptos_departamento VALUES (100, 'Nulla tempor augue ac ipsum.', 77.18, 'LE ', 27190774, 9, 434.66, 54, '2003-03-01');
INSERT INTO unc_248557.dptos_departamento VALUES (82, 'commodo', 15.52, 'LE ', 3210941, 5, 968.59, 45, '2000-08-24');
INSERT INTO unc_248557.dptos_departamento VALUES (61, 'sapien imperdiet ornare. In faucibus.', 32.87, 'LE ', 21791086, 2, 337.77, 52, '2000-02-22');
INSERT INTO unc_248557.dptos_departamento VALUES (21, 'dui quis accumsan', 81.44, 'PAS', 9951025, 8, 753.29, 56, '2003-05-10');
INSERT INTO unc_248557.dptos_departamento VALUES (2, 'blandit', 99.68, 'LE ', 10008499, 8, 422.02, 38, '2001-10-10');
INSERT INTO unc_248557.dptos_departamento VALUES (93, 'lectus ante', 43.20, 'PAS', 24419500, 8, 305.43, 37, '2000-10-11');
INSERT INTO unc_248557.dptos_departamento VALUES (38, 'eget massa.', 65.01, 'DNI', 20420458, 8, 156.40, 96, '2001-12-15');
INSERT INTO unc_248557.dptos_departamento VALUES (40, 'lectus rutrum urna, nec', 74.88, 'PAS', 12674170, 3, 379.12, 28, '2002-04-28');
INSERT INTO unc_248557.dptos_departamento VALUES (19, 'luctus et ultrices', 82.16, 'LE ', 25136092, 3, 516.89, 14, '2000-01-21');
INSERT INTO unc_248557.dptos_departamento VALUES (27, 'tincidunt dui', 63.99, 'PAS', 13013092, 8, 745.11, 78, '2002-09-06');
INSERT INTO unc_248557.dptos_departamento VALUES (96, 'sodales', 55.76, 'LC ', 12059270, 1, 368.69, 36, '2001-08-22');
INSERT INTO unc_248557.dptos_departamento VALUES (16, 'nibh. Aliquam', 7.03, 'PAS', 12674170, 2, 713.46, 72, '2003-07-01');
INSERT INTO unc_248557.dptos_departamento VALUES (17, 'tortor, dictum eu, placerat', 75.88, 'DNI', 17794714, 4, 145.16, 66, '2003-08-17');
INSERT INTO unc_248557.dptos_departamento VALUES (86, 'euismod enim. Etiam gravida', 69.54, 'PAS', 9007536, 8, 557.74, 73, '2001-04-08');
INSERT INTO unc_248557.dptos_departamento VALUES (57, 'Donec', 37.49, 'DNI', 16630721, 2, 482.31, 99, '2002-06-08');
INSERT INTO unc_248557.dptos_departamento VALUES (13, 'dictum', 74.96, 'LE ', 24717893, 7, 952.28, 83, '2001-01-07');
INSERT INTO unc_248557.dptos_departamento VALUES (24, 'non, vestibulum', 44.80, 'PAS', 16725511, 8, 370.64, 72, '2003-10-10');
INSERT INTO unc_248557.dptos_departamento VALUES (9, 'egestas', 45.12, 'LE ', 29851066, 8, 271.81, 76, '2000-05-03');
INSERT INTO unc_248557.dptos_departamento VALUES (22, 'orci', 24.06, 'LC ', 13411764, 8, 729.97, 38, '2000-12-09');
INSERT INTO unc_248557.dptos_departamento VALUES (60, 'eleifend', 47.71, 'LC ', 27714612, 5, 777.65, 54, '2002-05-10');
INSERT INTO unc_248557.dptos_departamento VALUES (63, 'orci. Ut', 96.35, 'DNI', 25872520, 8, 665.01, 99, '2002-02-11');
INSERT INTO unc_248557.dptos_departamento VALUES (80, 'aliquet lobortis, nisi nibh', 14.51, 'LE ', 28033668, 3, 833.82, 58, '2000-06-05');
INSERT INTO unc_248557.dptos_departamento VALUES (47, 'magna. Sed eu', 70.51, 'DNI', 4348861, 4, 910.40, 86, '2003-07-22');
INSERT INTO unc_248557.dptos_departamento VALUES (98, 'sagittis lobortis mauris. Suspendisse', 88.62, 'LC ', 26628542, 8, 858.87, 13, '2002-08-31');
INSERT INTO unc_248557.dptos_departamento VALUES (70, 'fringilla euismod enim. Etiam', 51.15, 'LE ', 20524129, 5, 475.92, 83, '2003-01-08');
INSERT INTO unc_248557.dptos_departamento VALUES (20, 'semper auctor. Mauris vel', 7.29, 'LE ', 22647473, 2, 619.50, 33, '2003-07-07');
INSERT INTO unc_248557.dptos_departamento VALUES (52, 'magna. Ut tincidunt orci', 29.79, 'LE ', 27190774, 2, 853.17, 95, '2001-04-27');
INSERT INTO unc_248557.dptos_departamento VALUES (68, 'Integer tincidunt aliquam', 88.98, 'DNI', 21542004, 5, 226.81, 93, '2000-01-03');
INSERT INTO unc_248557.dptos_departamento VALUES (36, 'fermentum convallis ligula. Donec luctus', 72.18, 'PAS', 24293944, 2, 853.39, 28, '2003-07-27');
INSERT INTO unc_248557.dptos_departamento VALUES (94, 'faucibus', 88.72, 'LE ', 24396015, 2, 100.14, 87, '2002-12-19');
INSERT INTO unc_248557.dptos_departamento VALUES (18, 'ut', 67.62, 'PAS', 10756287, 8, 564.37, 85, '2003-10-29');
INSERT INTO unc_248557.dptos_departamento VALUES (15, 'scelerisque mollis.', 60.65, 'PAS', 11870429, 2, 678.54, 58, '2003-10-28');
INSERT INTO unc_248557.dptos_departamento VALUES (26, 'eros.', 64.08, 'PAS', 18948738, 8, 749.66, 84, '2002-08-12');
INSERT INTO unc_248557.dptos_departamento VALUES (41, 'Integer', 50.68, 'DNI', 28879365, 5, 209.94, 4, '2001-11-07');
INSERT INTO unc_248557.dptos_departamento VALUES (99, 'felis purus ac', 19.37, 'DNI', 25743011, 2, 732.64, 89, '2002-03-14');
INSERT INTO unc_248557.dptos_departamento VALUES (1, 'ridiculus', 50.11, 'LE ', 10008499, 9, 353.96, 64, '2002-06-05');
INSERT INTO unc_248557.dptos_departamento VALUES (34, 'Praesent eu dui.', 56.16, 'LC ', 12059270, 7, 715.76, 67, '2001-01-27');
INSERT INTO unc_248557.dptos_departamento VALUES (95, 'iaculis, lacus pede sagittis augue,', 42.99, 'PAS', 5462294, 2, 526.36, 95, '2003-02-08');
INSERT INTO unc_248557.dptos_departamento VALUES (50, 'vel, faucibus id, libero. Donec', 95.83, 'LC ', 18798903, 2, 554.05, 94, '2002-11-03');
INSERT INTO unc_248557.dptos_departamento VALUES (12, 'erat eget ipsum.', 45.53, 'LC ', 18798903, 9, 137.48, 35, '2002-12-08');
INSERT INTO unc_248557.dptos_departamento VALUES (6, 'faucibus. Morbi vehicula.', 46.07, 'LE ', 27190774, 5, 688.49, 13, '2000-10-12');
INSERT INTO unc_248557.dptos_departamento VALUES (32, 'feugiat. Lorem ipsum', 63.16, 'LC ', 13411764, 9, 123.41, 9, '2003-02-12');
INSERT INTO unc_248557.dptos_departamento VALUES (79, 'dictum magna. Ut', 36.95, 'LE ', 8135698, 8, 788.07, 100, '2001-01-01');
INSERT INTO unc_248557.dptos_departamento VALUES (10, 'mi eleifend egestas. Sed pharetra,', 4.92, 'LC ', 13742965, 8, 552.22, 85, '2003-06-29');
INSERT INTO unc_248557.dptos_departamento VALUES (67, 'cursus', 97.57, 'DNI', 4538248, 3, 861.62, 31, '2002-03-31');
INSERT INTO unc_248557.dptos_departamento VALUES (76, 'orci lacus', 47.11, 'LE ', 29851066, 8, 525.28, 3, '2001-03-22');
INSERT INTO unc_248557.dptos_departamento VALUES (11, 'Praesent eu', 78.08, 'PAS', 13041560, 5, 606.87, 69, '2000-06-27');
INSERT INTO unc_248557.dptos_departamento VALUES (31, 'non magna. Nam', 66.28, 'LE ', 22647473, 8, 370.12, 68, '2003-02-19');
INSERT INTO unc_248557.dptos_departamento VALUES (84, 'Aenean gravida nunc sed pede.', 66.73, 'LE ', 8388684, 3, 807.44, 81, '2000-05-22');
INSERT INTO unc_248557.dptos_departamento VALUES (44, 'amet ante. Vivamus', 95.66, 'DNI', 19275911, 8, 614.99, 39, '2003-06-26');
INSERT INTO unc_248557.dptos_departamento VALUES (75, 'sapien, gravida non, sollicitudin a,', 62.97, 'PAS', 25823529, 4, 833.17, 10, '2003-12-22');
INSERT INTO unc_248557.dptos_departamento VALUES (56, 'cubilia', 33.28, 'PAS', 22454734, 7, 188.09, 9, '2000-09-04');
INSERT INTO unc_248557.dptos_departamento VALUES (72, 'ipsum porta elit, a', 45.40, 'DNI', 20420458, 4, 690.59, 78, '2001-09-13');
INSERT INTO unc_248557.dptos_departamento VALUES (53, 'Mauris vel', 2.37, 'LC ', 23252809, 7, 371.11, 76, '2001-08-05');
INSERT INTO unc_248557.dptos_departamento VALUES (91, 'faucibus lectus, a sollicitudin orci', 99.44, 'LE ', 25136092, 2, 690.90, 7, '2003-08-29');
INSERT INTO unc_248557.dptos_departamento VALUES (29, 'neque', 72.09, 'LC ', 18617145, 4, 401.35, 96, '2000-09-15');
INSERT INTO unc_248557.dptos_departamento VALUES (92, 'gravida sagittis. Duis gravida.', 95.79, 'LC ', 26628542, 8, 122.19, 80, '2002-03-19');
INSERT INTO unc_248557.dptos_departamento VALUES (4, 'tellus.', 17.28, 'LC ', 5529831, 8, 660.25, 83, '2002-03-27');
INSERT INTO unc_248557.dptos_departamento VALUES (77, 'Suspendisse tristique neque venenatis lacus.', 49.33, 'LC ', 18617145, 8, 604.50, 36, '2001-11-30');
INSERT INTO unc_248557.dptos_departamento VALUES (89, 'Mauris ut', 94.90, 'DNI', 25872520, 7, 570.84, 63, '2002-03-21');
INSERT INTO unc_248557.dptos_departamento VALUES (73, 'nunc', 79.94, 'LC ', 18617145, 8, 589.20, 14, '2000-01-25');
INSERT INTO unc_248557.dptos_departamento VALUES (97, 'Donec felis orci, adipiscing non,', 66.39, 'PAS', 13041560, 3, 400.84, 95, '2000-07-01');
INSERT INTO unc_248557.dptos_departamento VALUES (30, 'eu erat semper', 65.38, 'DNI', 17794714, 9, 474.97, 46, '2003-07-22');
INSERT INTO unc_248557.dptos_departamento VALUES (33, 'dapibus rutrum, justo. Praesent luctus.', 85.48, 'PAS', 10756287, 8, 823.43, 9, '2002-04-04');
INSERT INTO unc_248557.dptos_departamento VALUES (87, 'at pede.', 89.04, 'PAS', 24419500, 5, 387.33, 49, '2003-01-19');
INSERT INTO unc_248557.dptos_departamento VALUES (25, 'Fusce feugiat. Lorem ipsum dolor', 52.07, 'LC ', 10862358, 2, 351.03, 84, '2001-06-17');
INSERT INTO unc_248557.dptos_departamento VALUES (35, 'pharetra. Quisque ac libero', 98.82, 'LC ', 26628542, 6, 446.91, 100, '2003-10-13');
INSERT INTO unc_248557.dptos_departamento VALUES (46, 'vulputate', 13.18, 'DNI', 4538248, 8, 397.51, 29, '2000-04-24');
INSERT INTO unc_248557.dptos_departamento VALUES (54, 'Etiam ligula', 12.25, 'LC ', 26628542, 5, 664.30, 95, '2003-11-24');
INSERT INTO unc_248557.dptos_departamento VALUES (14, 'placerat', 14.54, 'PAS', 16725511, 8, 749.12, 96, '2002-01-04');
INSERT INTO unc_248557.dptos_departamento VALUES (64, 'ipsum dolor', 78.58, 'LE ', 6794352, 4, 405.94, 32, '2003-05-21');
INSERT INTO unc_248557.dptos_departamento VALUES (28, 'a, magna.', 43.45, 'DNI', 11705876, 8, 342.75, 80, '2003-08-24');
INSERT INTO unc_248557.dptos_departamento VALUES (45, 'ac', 9.31, 'LC ', 13742965, 4, 819.21, 70, '2001-08-09');
INSERT INTO unc_248557.dptos_departamento VALUES (90, 'massa.', 15.48, 'LC ', 28727968, 2, 610.41, 33, '2002-10-01');
INSERT INTO unc_248557.dptos_departamento VALUES (55, 'nec metus facilisis lorem tristique', 54.95, 'DNI', 11705876, 1, 610.34, 88, '2003-04-12');
INSERT INTO unc_248557.dptos_departamento VALUES (49, 'sodales purus,', 26.54, 'PAS', 12674170, 4, 628.63, 100, '2002-03-23');
INSERT INTO unc_248557.dptos_departamento VALUES (58, 'fringilla ornare placerat, orci lacus', 47.38, 'DNI', 20420458, 3, 542.03, 14, '2000-09-15');
INSERT INTO unc_248557.dptos_departamento VALUES (7, 'ante', 91.13, 'PAS', 22162763, 2, 602.89, 37, '2000-11-02');
INSERT INTO unc_248557.dptos_departamento VALUES (83, 'elit, dictum', 31.65, 'PAS', 7293853, 5, 857.46, 66, '2000-10-18');
INSERT INTO unc_248557.dptos_departamento VALUES (88, 'varius', 73.02, 'LE ', 28035885, 2, 394.01, 69, '2003-12-20');
INSERT INTO unc_248557.dptos_departamento VALUES (59, 'tristique pellentesque, tellus sem mollis', 63.43, 'LE ', 21791086, 4, 963.92, 58, '2002-12-02');
INSERT INTO unc_248557.dptos_departamento VALUES (39, 'ligula. Aenean euismod mauris', 3.24, 'LC ', 4455131, 8, 252.59, 93, '2000-03-08');
INSERT INTO unc_248557.dptos_departamento VALUES (37, 'condimentum.', 35.61, 'PAS', 24419500, 5, 316.07, 71, '2002-01-24');
INSERT INTO unc_248557.dptos_departamento VALUES (42, 'mattis', 9.87, 'DNI', 25872520, 4, 403.48, 80, '2000-04-13');
INSERT INTO unc_248557.dptos_departamento VALUES (43, 'montes,', 65.74, 'DNI', 20420458, 8, 635.10, 47, '2001-07-05');
INSERT INTO unc_248557.dptos_departamento VALUES (74, 'Nulla', 10.80, 'DNI', 11587439, 2, 669.64, 25, '2000-10-01');
INSERT INTO unc_248557.dptos_departamento VALUES (81, 'molestie', 71.00, 'DNI', 25743011, 4, 661.35, 57, '2000-10-18');
INSERT INTO unc_248557.dptos_departamento VALUES (85, 'Suspendisse sed', 81.85, 'LE ', 28035885, 4, 834.50, 16, '2002-08-12');
INSERT INTO unc_248557.dptos_departamento VALUES (8, 'mattis. Cras eget nisi dictum', 29.76, 'LC ', 18798903, 8, 898.01, 24, '2000-11-22');


--
-- Data for Name: edo_luego_ocupacion; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--



--
-- Data for Name: habitacion; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_habitacion VALUES (8, 1, 1, 2, 2, true, 2, 3, false, 4, false, 98.93);
INSERT INTO unc_248557.dptos_habitacion VALUES (8, 2, 4, 4, 2, false, 1, 3, true, 9, true, 42.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (80, 1, 3, 2, 2, true, 1, 3, false, 7, false, 147.72);
INSERT INTO unc_248557.dptos_habitacion VALUES (16, 1, 4, 2, 2, false, 2, 1, false, 3, true, 37.48);
INSERT INTO unc_248557.dptos_habitacion VALUES (16, 2, 2, 4, 1, false, 1, 2, true, 7, false, 72.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (16, 3, 1, 2, 2, true, 1, 2, false, 1, false, 42.84);
INSERT INTO unc_248557.dptos_habitacion VALUES (16, 4, 2, 2, 2, false, 2, 3, true, 5, true, 145.60);
INSERT INTO unc_248557.dptos_habitacion VALUES (54, 1, 2, 4, 2, true, 2, 3, false, 4, true, 136.86);
INSERT INTO unc_248557.dptos_habitacion VALUES (54, 2, 4, 1, 2, false, 2, 1, true, 3, false, 58.41);
INSERT INTO unc_248557.dptos_habitacion VALUES (54, 3, 2, 3, 2, true, 2, 1, false, 7, true, 67.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (47, 1, 2, 1, 1, true, 1, 3, true, 9, true, 60.85);
INSERT INTO unc_248557.dptos_habitacion VALUES (47, 2, 2, 2, 1, false, 2, 3, false, 4, false, 126.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (47, 3, 1, 4, 2, false, 1, 3, true, 4, true, 137.45);
INSERT INTO unc_248557.dptos_habitacion VALUES (47, 4, 4, 3, 1, false, 1, 2, true, 1, false, 81.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (47, 5, 4, 3, 2, false, 1, 1, true, 10, true, 140.77);
INSERT INTO unc_248557.dptos_habitacion VALUES (46, 1, 2, 1, 2, true, 2, 1, false, 4, false, 16.16);
INSERT INTO unc_248557.dptos_habitacion VALUES (46, 2, 3, 1, 1, true, 2, 2, false, 5, false, 118.38);
INSERT INTO unc_248557.dptos_habitacion VALUES (99, 1, 3, 4, 1, false, 1, 2, false, 7, true, 101.16);
INSERT INTO unc_248557.dptos_habitacion VALUES (99, 2, 2, 4, 1, true, 2, 3, false, 2, false, 111.53);
INSERT INTO unc_248557.dptos_habitacion VALUES (99, 3, 3, 3, 1, true, 2, 3, false, 2, true, 59.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (99, 4, 1, 4, 1, true, 1, 2, false, 8, true, 91.42);
INSERT INTO unc_248557.dptos_habitacion VALUES (83, 1, 4, 2, 2, true, 2, 3, true, 6, false, 128.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (83, 2, 3, 3, 2, true, 2, 3, true, 4, false, 68.97);
INSERT INTO unc_248557.dptos_habitacion VALUES (83, 3, 3, 3, 1, false, 2, 1, true, 5, true, 71.32);
INSERT INTO unc_248557.dptos_habitacion VALUES (28, 1, 2, 3, 1, false, 2, 3, true, 4, true, 90.30);
INSERT INTO unc_248557.dptos_habitacion VALUES (28, 2, 3, 1, 1, true, 2, 3, true, 4, true, 120.24);
INSERT INTO unc_248557.dptos_habitacion VALUES (36, 1, 1, 2, 1, false, 2, 2, false, 3, false, 132.81);
INSERT INTO unc_248557.dptos_habitacion VALUES (36, 2, 2, 1, 2, false, 1, 2, false, 4, true, 16.68);
INSERT INTO unc_248557.dptos_habitacion VALUES (36, 3, 2, 3, 1, false, 2, 2, true, 7, true, 91.29);
INSERT INTO unc_248557.dptos_habitacion VALUES (36, 4, 1, 1, 1, true, 1, 3, true, 5, false, 133.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (94, 1, 4, 3, 2, true, 2, 1, false, 8, true, 108.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (94, 2, 1, 2, 2, false, 1, 1, true, 8, false, 75.25);
INSERT INTO unc_248557.dptos_habitacion VALUES (94, 3, 4, 4, 2, true, 2, 2, true, 5, true, 82.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (94, 4, 3, 1, 2, false, 2, 2, false, 7, false, 46.25);
INSERT INTO unc_248557.dptos_habitacion VALUES (15, 1, 1, 4, 2, false, 2, 2, true, 6, false, 137.76);
INSERT INTO unc_248557.dptos_habitacion VALUES (15, 2, 2, 4, 2, true, 2, 3, false, 5, true, 140.69);
INSERT INTO unc_248557.dptos_habitacion VALUES (15, 3, 3, 2, 2, true, 2, 3, false, 2, false, 135.22);
INSERT INTO unc_248557.dptos_habitacion VALUES (15, 4, 4, 1, 2, true, 1, 1, true, 5, false, 110.26);
INSERT INTO unc_248557.dptos_habitacion VALUES (77, 1, 4, 4, 2, false, 1, 1, true, 4, false, 137.44);
INSERT INTO unc_248557.dptos_habitacion VALUES (77, 2, 3, 2, 2, false, 2, 2, false, 1, false, 80.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (4, 1, 3, 4, 2, false, 2, 3, true, 10, false, 114.41);
INSERT INTO unc_248557.dptos_habitacion VALUES (4, 2, 1, 4, 2, true, 1, 2, false, 1, true, 130.68);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 1, 3, 1, 2, true, 1, 1, true, 7, false, 15.36);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 2, 4, 4, 1, false, 2, 3, true, 9, true, 95.63);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 3, 2, 4, 2, true, 2, 3, false, 3, false, 95.96);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 4, 2, 2, 1, true, 1, 2, false, 2, false, 18.96);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 5, 1, 2, 1, false, 2, 3, false, 10, true, 19.59);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 6, 2, 2, 1, true, 2, 3, true, 2, false, 82.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (30, 7, 1, 2, 1, false, 1, 1, true, 5, false, 137.61);
INSERT INTO unc_248557.dptos_habitacion VALUES (95, 1, 3, 4, 2, false, 2, 2, true, 8, true, 46.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (95, 2, 1, 1, 2, false, 1, 2, false, 2, false, 20.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (95, 3, 1, 4, 1, true, 1, 1, false, 7, true, 75.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (95, 4, 2, 3, 1, false, 1, 2, false, 5, false, 83.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (73, 1, 2, 4, 1, true, 2, 1, true, 4, true, 69.23);
INSERT INTO unc_248557.dptos_habitacion VALUES (73, 2, 1, 2, 2, true, 2, 2, false, 6, true, 146.61);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 1, 1, 1, 2, false, 1, 3, false, 7, true, 45.36);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 2, 4, 1, 2, true, 1, 3, false, 6, true, 125.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 3, 4, 1, 2, true, 1, 2, false, 5, true, 39.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 4, 4, 3, 2, false, 2, 2, false, 6, false, 61.45);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 5, 4, 4, 2, false, 2, 1, true, 3, false, 132.63);
INSERT INTO unc_248557.dptos_habitacion VALUES (56, 6, 2, 3, 1, false, 1, 2, false, 2, true, 79.78);
INSERT INTO unc_248557.dptos_habitacion VALUES (40, 1, 1, 1, 2, true, 2, 1, true, 9, false, 115.25);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 1, 1, 2, 1, false, 2, 1, true, 8, true, 131.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 2, 3, 2, 2, true, 2, 3, true, 10, false, 100.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 3, 2, 3, 2, true, 1, 2, true, 3, false, 95.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 4, 1, 1, 2, true, 1, 2, true, 6, true, 75.83);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 5, 4, 3, 2, false, 1, 3, true, 8, false, 106.25);
INSERT INTO unc_248557.dptos_habitacion VALUES (53, 6, 2, 3, 2, false, 2, 1, true, 3, true, 72.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (62, 1, 2, 2, 2, false, 2, 1, false, 10, false, 36.59);
INSERT INTO unc_248557.dptos_habitacion VALUES (62, 2, 1, 3, 2, false, 2, 3, true, 9, true, 28.62);
INSERT INTO unc_248557.dptos_habitacion VALUES (62, 3, 1, 4, 1, false, 1, 2, false, 10, true, 80.55);
INSERT INTO unc_248557.dptos_habitacion VALUES (62, 4, 1, 1, 1, true, 1, 3, false, 4, false, 29.27);
INSERT INTO unc_248557.dptos_habitacion VALUES (62, 5, 3, 3, 1, false, 2, 2, false, 4, true, 136.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (92, 1, 4, 4, 2, true, 2, 3, true, 5, true, 67.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (92, 2, 2, 3, 2, false, 2, 3, false, 8, true, 13.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (23, 1, 2, 2, 2, false, 2, 1, false, 9, true, 80.18);
INSERT INTO unc_248557.dptos_habitacion VALUES (23, 2, 1, 1, 2, true, 1, 2, true, 1, false, 124.82);
INSERT INTO unc_248557.dptos_habitacion VALUES (23, 3, 2, 3, 1, true, 2, 2, true, 10, true, 56.94);
INSERT INTO unc_248557.dptos_habitacion VALUES (23, 4, 3, 4, 1, true, 1, 2, true, 2, true, 55.42);
INSERT INTO unc_248557.dptos_habitacion VALUES (23, 5, 1, 1, 1, false, 1, 3, true, 7, true, 16.76);
INSERT INTO unc_248557.dptos_habitacion VALUES (20, 1, 1, 3, 1, false, 2, 3, false, 6, false, 62.25);
INSERT INTO unc_248557.dptos_habitacion VALUES (20, 2, 1, 1, 2, false, 1, 3, true, 3, true, 82.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (20, 3, 4, 4, 1, true, 1, 3, false, 2, true, 85.66);
INSERT INTO unc_248557.dptos_habitacion VALUES (20, 4, 4, 2, 1, true, 1, 2, true, 7, true, 91.16);
INSERT INTO unc_248557.dptos_habitacion VALUES (44, 1, 1, 4, 2, true, 2, 2, false, 10, true, 57.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (44, 2, 3, 4, 1, true, 2, 1, false, 10, false, 48.83);
INSERT INTO unc_248557.dptos_habitacion VALUES (82, 1, 3, 3, 1, true, 2, 3, true, 4, true, 116.35);
INSERT INTO unc_248557.dptos_habitacion VALUES (82, 2, 1, 2, 2, false, 2, 2, false, 1, true, 91.22);
INSERT INTO unc_248557.dptos_habitacion VALUES (82, 3, 3, 3, 1, true, 1, 2, false, 10, true, 127.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (25, 1, 1, 4, 1, true, 2, 3, true, 2, false, 57.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (25, 2, 4, 1, 2, false, 1, 1, false, 5, false, 102.60);
INSERT INTO unc_248557.dptos_habitacion VALUES (25, 3, 4, 4, 1, false, 2, 3, true, 7, false, 89.42);
INSERT INTO unc_248557.dptos_habitacion VALUES (25, 4, 3, 2, 1, true, 1, 3, false, 5, true, 13.20);
INSERT INTO unc_248557.dptos_habitacion VALUES (58, 1, 2, 1, 2, true, 1, 1, true, 2, false, 46.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 1, 3, 4, 2, false, 2, 1, true, 10, true, 57.75);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 2, 2, 3, 2, false, 1, 1, false, 5, false, 143.86);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 3, 4, 3, 2, false, 1, 2, false, 7, true, 55.46);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 4, 2, 4, 1, false, 1, 1, false, 5, true, 21.34);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 5, 4, 2, 2, false, 2, 2, true, 1, true, 81.00);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 6, 2, 3, 1, false, 1, 3, true, 1, true, 67.68);
INSERT INTO unc_248557.dptos_habitacion VALUES (1, 7, 2, 4, 1, true, 2, 3, false, 7, true, 99.59);
INSERT INTO unc_248557.dptos_habitacion VALUES (26, 1, 1, 2, 2, true, 2, 3, false, 5, true, 117.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (26, 2, 2, 2, 2, true, 2, 2, true, 8, false, 16.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (86, 1, 4, 4, 1, true, 1, 2, false, 7, true, 22.98);
INSERT INTO unc_248557.dptos_habitacion VALUES (86, 2, 4, 4, 2, false, 1, 2, true, 5, false, 85.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 1, 4, 2, 2, false, 1, 1, false, 8, false, 140.24);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 2, 3, 3, 1, true, 1, 1, false, 7, false, 97.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 3, 2, 1, 2, false, 1, 1, true, 2, true, 67.54);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 4, 2, 2, 1, false, 2, 2, false, 10, true, 74.81);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 5, 4, 4, 1, false, 1, 1, false, 3, true, 64.97);
INSERT INTO unc_248557.dptos_habitacion VALUES (13, 6, 1, 4, 2, true, 1, 1, false, 1, false, 148.17);
INSERT INTO unc_248557.dptos_habitacion VALUES (49, 1, 3, 4, 1, true, 1, 2, true, 4, false, 116.04);
INSERT INTO unc_248557.dptos_habitacion VALUES (49, 2, 3, 2, 2, false, 1, 3, true, 8, false, 141.69);
INSERT INTO unc_248557.dptos_habitacion VALUES (49, 3, 1, 2, 2, false, 2, 3, true, 6, false, 49.04);
INSERT INTO unc_248557.dptos_habitacion VALUES (49, 4, 2, 3, 2, true, 1, 1, false, 2, false, 62.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (49, 5, 4, 1, 1, true, 1, 1, false, 3, false, 88.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (22, 1, 2, 3, 1, false, 1, 1, false, 6, false, 131.45);
INSERT INTO unc_248557.dptos_habitacion VALUES (22, 2, 1, 4, 2, false, 1, 3, true, 5, false, 11.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (91, 1, 3, 2, 1, true, 1, 3, true, 4, true, 38.32);
INSERT INTO unc_248557.dptos_habitacion VALUES (91, 2, 3, 4, 2, true, 2, 2, false, 10, true, 16.51);
INSERT INTO unc_248557.dptos_habitacion VALUES (91, 3, 3, 1, 1, true, 1, 3, true, 4, false, 20.10);
INSERT INTO unc_248557.dptos_habitacion VALUES (91, 4, 1, 4, 1, false, 2, 3, false, 2, false, 115.38);
INSERT INTO unc_248557.dptos_habitacion VALUES (70, 1, 4, 3, 1, true, 2, 3, true, 5, true, 94.72);
INSERT INTO unc_248557.dptos_habitacion VALUES (70, 2, 3, 1, 2, true, 1, 2, true, 10, false, 34.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (70, 3, 1, 4, 1, false, 2, 2, true, 8, true, 56.56);
INSERT INTO unc_248557.dptos_habitacion VALUES (45, 1, 1, 3, 2, false, 2, 1, false, 9, false, 14.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (45, 2, 4, 4, 2, false, 1, 2, false, 10, true, 29.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (45, 3, 4, 4, 1, false, 1, 3, false, 3, false, 91.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (45, 4, 3, 2, 2, true, 1, 1, true, 2, true, 83.14);
INSERT INTO unc_248557.dptos_habitacion VALUES (45, 5, 1, 4, 2, true, 1, 1, true, 2, true, 129.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (27, 1, 2, 1, 1, true, 1, 2, false, 7, true, 45.02);
INSERT INTO unc_248557.dptos_habitacion VALUES (27, 2, 4, 1, 1, false, 2, 2, false, 6, false, 28.57);
INSERT INTO unc_248557.dptos_habitacion VALUES (60, 1, 1, 1, 1, false, 2, 2, false, 3, true, 123.47);
INSERT INTO unc_248557.dptos_habitacion VALUES (60, 2, 2, 3, 2, false, 1, 1, true, 2, true, 42.78);
INSERT INTO unc_248557.dptos_habitacion VALUES (60, 3, 1, 4, 2, true, 2, 1, false, 5, true, 68.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (93, 1, 3, 3, 1, true, 1, 2, false, 9, false, 107.00);
INSERT INTO unc_248557.dptos_habitacion VALUES (93, 2, 3, 4, 2, true, 2, 2, false, 1, true, 14.92);
INSERT INTO unc_248557.dptos_habitacion VALUES (21, 1, 2, 3, 2, false, 1, 1, false, 3, false, 49.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (21, 2, 4, 4, 2, false, 2, 2, false, 7, true, 41.63);
INSERT INTO unc_248557.dptos_habitacion VALUES (97, 1, 3, 4, 1, false, 1, 2, true, 1, false, 59.92);
INSERT INTO unc_248557.dptos_habitacion VALUES (75, 1, 1, 2, 2, false, 2, 2, true, 5, false, 48.01);
INSERT INTO unc_248557.dptos_habitacion VALUES (75, 2, 2, 4, 2, false, 1, 1, false, 9, false, 17.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (75, 3, 3, 4, 1, true, 1, 1, true, 1, true, 108.97);
INSERT INTO unc_248557.dptos_habitacion VALUES (75, 4, 1, 1, 2, true, 2, 3, true, 6, true, 87.69);
INSERT INTO unc_248557.dptos_habitacion VALUES (75, 5, 1, 3, 2, true, 1, 1, false, 8, true, 59.52);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 1, 2, 3, 1, true, 2, 1, false, 4, false, 42.80);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 2, 4, 3, 2, true, 1, 2, false, 5, true, 13.96);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 3, 2, 4, 2, false, 2, 1, true, 8, true, 71.18);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 4, 1, 2, 1, false, 2, 1, true, 8, true, 142.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 5, 3, 1, 1, true, 2, 3, true, 10, true, 148.52);
INSERT INTO unc_248557.dptos_habitacion VALUES (5, 6, 1, 3, 1, false, 1, 3, true, 5, false, 35.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (43, 1, 4, 4, 1, true, 1, 1, true, 4, false, 63.72);
INSERT INTO unc_248557.dptos_habitacion VALUES (43, 2, 2, 2, 2, false, 2, 3, true, 6, false, 145.03);
INSERT INTO unc_248557.dptos_habitacion VALUES (11, 1, 2, 4, 2, true, 1, 1, true, 4, true, 29.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (11, 2, 3, 3, 2, true, 2, 1, false, 9, true, 11.86);
INSERT INTO unc_248557.dptos_habitacion VALUES (11, 3, 3, 4, 1, true, 2, 2, true, 3, false, 138.21);
INSERT INTO unc_248557.dptos_habitacion VALUES (39, 1, 1, 1, 1, false, 2, 2, true, 9, false, 84.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (39, 2, 2, 3, 2, true, 1, 1, true, 9, false, 93.18);
INSERT INTO unc_248557.dptos_habitacion VALUES (3, 1, 4, 4, 1, true, 2, 2, true, 8, true, 29.27);
INSERT INTO unc_248557.dptos_habitacion VALUES (3, 2, 1, 3, 2, false, 2, 3, false, 6, false, 24.69);
INSERT INTO unc_248557.dptos_habitacion VALUES (3, 3, 4, 2, 1, true, 2, 3, true, 8, true, 49.66);
INSERT INTO unc_248557.dptos_habitacion VALUES (3, 4, 3, 2, 1, false, 2, 3, false, 8, false, 100.92);
INSERT INTO unc_248557.dptos_habitacion VALUES (61, 1, 2, 3, 2, false, 2, 2, false, 7, false, 142.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (61, 2, 1, 3, 2, true, 2, 3, false, 7, true, 115.27);
INSERT INTO unc_248557.dptos_habitacion VALUES (61, 3, 1, 4, 1, true, 2, 2, false, 4, true, 125.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (61, 4, 2, 1, 1, true, 1, 2, false, 1, false, 136.08);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 1, 3, 2, 1, true, 2, 1, true, 6, false, 94.08);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 2, 3, 2, 2, false, 2, 1, true, 5, true, 47.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 3, 1, 4, 2, true, 2, 3, true, 7, true, 59.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 4, 2, 4, 2, false, 2, 3, true, 6, false, 98.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 5, 2, 3, 2, true, 2, 2, true, 8, true, 80.48);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 6, 1, 1, 2, false, 2, 3, false, 8, false, 59.65);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 7, 3, 3, 2, true, 1, 3, true, 7, false, 144.31);
INSERT INTO unc_248557.dptos_habitacion VALUES (96, 8, 4, 2, 1, false, 2, 3, false, 4, true, 98.29);
INSERT INTO unc_248557.dptos_habitacion VALUES (87, 1, 4, 4, 1, true, 1, 3, true, 3, true, 25.94);
INSERT INTO unc_248557.dptos_habitacion VALUES (87, 2, 3, 2, 2, false, 1, 2, true, 1, true, 73.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (87, 3, 2, 3, 2, true, 1, 2, true, 9, false, 38.41);
INSERT INTO unc_248557.dptos_habitacion VALUES (67, 1, 4, 1, 2, false, 1, 1, true, 1, true, 103.10);
INSERT INTO unc_248557.dptos_habitacion VALUES (14, 1, 4, 2, 2, true, 2, 2, true, 4, true, 136.12);
INSERT INTO unc_248557.dptos_habitacion VALUES (14, 2, 2, 4, 1, true, 1, 3, true, 6, false, 133.51);
INSERT INTO unc_248557.dptos_habitacion VALUES (17, 1, 3, 4, 1, true, 2, 1, false, 3, false, 107.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (17, 2, 3, 3, 1, false, 1, 1, true, 4, true, 90.93);
INSERT INTO unc_248557.dptos_habitacion VALUES (17, 3, 4, 3, 2, false, 2, 1, true, 2, false, 39.88);
INSERT INTO unc_248557.dptos_habitacion VALUES (17, 4, 2, 1, 1, true, 1, 1, true, 10, false, 84.34);
INSERT INTO unc_248557.dptos_habitacion VALUES (17, 5, 3, 3, 2, false, 2, 3, true, 8, true, 148.94);
INSERT INTO unc_248557.dptos_habitacion VALUES (66, 1, 1, 3, 1, false, 1, 3, true, 3, true, 92.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 1, 2, 1, 2, false, 2, 2, true, 7, false, 57.93);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 2, 3, 3, 2, false, 2, 3, true, 9, true, 110.98);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 3, 1, 3, 2, false, 2, 2, false, 4, true, 117.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 4, 3, 1, 2, true, 1, 2, true, 10, false, 71.36);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 5, 1, 2, 2, false, 2, 2, false, 5, true, 116.10);
INSERT INTO unc_248557.dptos_habitacion VALUES (89, 6, 3, 4, 2, false, 1, 3, true, 4, true, 13.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (50, 1, 3, 3, 2, false, 1, 1, false, 1, true, 36.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (50, 2, 4, 2, 1, true, 2, 1, false, 10, false, 111.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (50, 3, 1, 3, 1, true, 2, 3, true, 5, true, 53.57);
INSERT INTO unc_248557.dptos_habitacion VALUES (50, 4, 1, 2, 1, true, 2, 1, false, 6, true, 69.30);
INSERT INTO unc_248557.dptos_habitacion VALUES (33, 1, 4, 3, 2, false, 1, 1, false, 1, true, 144.23);
INSERT INTO unc_248557.dptos_habitacion VALUES (33, 2, 3, 3, 1, true, 2, 3, false, 1, false, 97.31);
INSERT INTO unc_248557.dptos_habitacion VALUES (19, 1, 3, 3, 1, false, 1, 3, true, 9, true, 63.61);
INSERT INTO unc_248557.dptos_habitacion VALUES (57, 1, 1, 1, 1, false, 1, 2, false, 3, true, 136.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (57, 2, 2, 3, 1, false, 2, 2, true, 10, false, 78.38);
INSERT INTO unc_248557.dptos_habitacion VALUES (57, 3, 4, 3, 2, false, 1, 2, false, 8, true, 73.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (57, 4, 2, 3, 2, true, 1, 1, true, 4, true, 148.39);
INSERT INTO unc_248557.dptos_habitacion VALUES (51, 1, 3, 3, 2, false, 2, 2, false, 9, false, 30.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (51, 2, 1, 2, 1, false, 1, 1, false, 8, true, 44.95);
INSERT INTO unc_248557.dptos_habitacion VALUES (51, 3, 2, 1, 2, true, 2, 3, false, 4, false, 62.54);
INSERT INTO unc_248557.dptos_habitacion VALUES (51, 4, 4, 3, 1, false, 1, 2, true, 8, true, 90.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (51, 5, 1, 1, 2, true, 1, 1, false, 8, true, 103.75);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 1, 4, 1, 2, false, 2, 2, true, 3, true, 44.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 2, 2, 1, 2, true, 2, 2, false, 2, false, 81.90);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 3, 4, 3, 1, true, 2, 2, false, 10, true, 147.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 4, 1, 2, 2, false, 1, 2, false, 5, true, 143.40);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 5, 2, 3, 1, false, 1, 1, false, 3, false, 139.84);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 6, 4, 1, 2, false, 1, 2, true, 5, true, 46.20);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 7, 4, 2, 2, false, 2, 2, true, 6, true, 63.38);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 8, 4, 1, 1, true, 2, 2, false, 9, false, 77.40);
INSERT INTO unc_248557.dptos_habitacion VALUES (35, 9, 2, 4, 2, true, 1, 2, false, 10, true, 73.53);
INSERT INTO unc_248557.dptos_habitacion VALUES (65, 1, 2, 3, 1, false, 2, 1, false, 9, true, 83.89);
INSERT INTO unc_248557.dptos_habitacion VALUES (65, 2, 1, 1, 2, false, 2, 3, false, 8, false, 64.22);
INSERT INTO unc_248557.dptos_habitacion VALUES (65, 3, 1, 1, 2, true, 2, 2, true, 1, true, 50.14);
INSERT INTO unc_248557.dptos_habitacion VALUES (65, 4, 1, 1, 2, true, 1, 1, true, 7, true, 79.66);
INSERT INTO unc_248557.dptos_habitacion VALUES (65, 5, 1, 4, 1, false, 2, 1, false, 5, true, 65.19);
INSERT INTO unc_248557.dptos_habitacion VALUES (31, 1, 4, 3, 2, true, 1, 3, true, 5, true, 146.15);
INSERT INTO unc_248557.dptos_habitacion VALUES (31, 2, 1, 3, 1, true, 2, 1, false, 8, true, 10.15);
INSERT INTO unc_248557.dptos_habitacion VALUES (76, 1, 2, 4, 2, false, 1, 2, false, 6, true, 48.05);
INSERT INTO unc_248557.dptos_habitacion VALUES (76, 2, 1, 2, 1, false, 1, 2, true, 10, true, 10.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (52, 1, 2, 4, 2, false, 2, 2, false, 7, false, 81.44);
INSERT INTO unc_248557.dptos_habitacion VALUES (52, 2, 2, 4, 2, false, 1, 2, false, 10, true, 146.18);
INSERT INTO unc_248557.dptos_habitacion VALUES (52, 3, 3, 3, 1, true, 1, 2, false, 8, true, 74.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (52, 4, 3, 1, 2, true, 2, 1, false, 1, true, 52.03);
INSERT INTO unc_248557.dptos_habitacion VALUES (69, 1, 3, 4, 2, true, 2, 3, false, 8, true, 114.02);
INSERT INTO unc_248557.dptos_habitacion VALUES (69, 2, 2, 2, 2, true, 2, 2, true, 7, true, 111.16);
INSERT INTO unc_248557.dptos_habitacion VALUES (69, 3, 3, 4, 1, false, 1, 3, true, 3, false, 125.14);
INSERT INTO unc_248557.dptos_habitacion VALUES (69, 4, 4, 3, 1, false, 2, 3, false, 6, true, 33.11);
INSERT INTO unc_248557.dptos_habitacion VALUES (69, 5, 1, 4, 1, true, 2, 1, true, 5, true, 128.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (37, 1, 4, 2, 2, true, 1, 1, false, 6, true, 83.02);
INSERT INTO unc_248557.dptos_habitacion VALUES (37, 2, 4, 1, 2, false, 2, 1, false, 8, true, 63.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (37, 3, 4, 3, 1, true, 1, 2, true, 7, true, 83.51);
INSERT INTO unc_248557.dptos_habitacion VALUES (85, 1, 4, 3, 1, true, 2, 1, false, 9, true, 143.02);
INSERT INTO unc_248557.dptos_habitacion VALUES (85, 2, 3, 2, 1, true, 2, 1, true, 8, false, 105.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (85, 3, 4, 4, 2, false, 2, 1, false, 2, false, 94.97);
INSERT INTO unc_248557.dptos_habitacion VALUES (85, 4, 2, 2, 2, true, 2, 1, false, 9, true, 98.29);
INSERT INTO unc_248557.dptos_habitacion VALUES (85, 5, 1, 1, 1, false, 1, 1, true, 9, false, 100.53);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 1, 1, 1, 1, false, 1, 1, false, 10, false, 32.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 2, 2, 4, 1, true, 1, 1, true, 10, false, 31.48);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 3, 4, 3, 2, false, 1, 3, true, 2, true, 123.46);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 4, 4, 3, 1, false, 2, 3, true, 1, true, 95.83);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 5, 3, 3, 2, true, 1, 3, true, 9, false, 72.33);
INSERT INTO unc_248557.dptos_habitacion VALUES (34, 6, 4, 3, 2, false, 2, 3, false, 2, true, 47.52);
INSERT INTO unc_248557.dptos_habitacion VALUES (81, 1, 3, 1, 1, true, 2, 1, true, 8, true, 122.79);
INSERT INTO unc_248557.dptos_habitacion VALUES (81, 2, 1, 2, 1, false, 1, 1, true, 4, true, 90.09);
INSERT INTO unc_248557.dptos_habitacion VALUES (81, 3, 4, 2, 1, false, 2, 1, false, 7, true, 21.15);
INSERT INTO unc_248557.dptos_habitacion VALUES (81, 4, 1, 3, 1, false, 1, 1, true, 5, false, 52.91);
INSERT INTO unc_248557.dptos_habitacion VALUES (81, 5, 1, 1, 2, true, 2, 1, false, 3, true, 47.01);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 1, 1, 4, 1, true, 1, 3, true, 2, false, 78.36);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 2, 4, 1, 1, true, 2, 2, false, 4, true, 14.61);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 3, 4, 2, 1, false, 2, 2, false, 3, false, 97.81);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 4, 3, 2, 2, false, 2, 2, true, 1, true, 96.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 5, 2, 4, 1, false, 1, 2, false, 8, true, 139.47);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 6, 1, 4, 1, false, 1, 3, false, 5, true, 58.70);
INSERT INTO unc_248557.dptos_habitacion VALUES (32, 7, 4, 1, 2, true, 2, 3, true, 3, false, 130.94);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 1, 4, 3, 1, false, 1, 1, true, 4, true, 37.01);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 2, 4, 2, 2, true, 2, 1, false, 7, false, 35.63);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 3, 3, 1, 1, false, 2, 1, false, 10, true, 73.92);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 4, 4, 4, 2, true, 2, 3, true, 2, true, 112.11);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 5, 4, 2, 2, false, 1, 3, false, 6, false, 15.23);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 6, 2, 1, 1, false, 1, 1, true, 3, true, 56.47);
INSERT INTO unc_248557.dptos_habitacion VALUES (12, 7, 4, 3, 1, true, 1, 2, false, 9, false, 62.08);
INSERT INTO unc_248557.dptos_habitacion VALUES (79, 1, 4, 3, 2, false, 1, 2, false, 9, true, 49.13);
INSERT INTO unc_248557.dptos_habitacion VALUES (79, 2, 4, 1, 2, false, 2, 2, true, 8, true, 61.27);
INSERT INTO unc_248557.dptos_habitacion VALUES (10, 1, 3, 2, 2, false, 2, 2, true, 1, true, 70.61);
INSERT INTO unc_248557.dptos_habitacion VALUES (10, 2, 1, 3, 2, false, 2, 3, false, 8, false, 129.14);
INSERT INTO unc_248557.dptos_habitacion VALUES (42, 1, 3, 2, 1, false, 1, 3, true, 7, false, 108.78);
INSERT INTO unc_248557.dptos_habitacion VALUES (42, 2, 4, 3, 1, false, 1, 1, false, 2, false, 45.21);
INSERT INTO unc_248557.dptos_habitacion VALUES (42, 3, 2, 4, 2, true, 2, 3, true, 6, false, 39.30);
INSERT INTO unc_248557.dptos_habitacion VALUES (42, 4, 4, 3, 2, true, 1, 1, true, 4, true, 57.17);
INSERT INTO unc_248557.dptos_habitacion VALUES (42, 5, 4, 3, 1, false, 1, 3, false, 4, false, 89.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (90, 1, 3, 1, 2, false, 1, 3, false, 1, true, 70.82);
INSERT INTO unc_248557.dptos_habitacion VALUES (90, 2, 1, 4, 2, true, 1, 2, false, 2, true, 19.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (90, 3, 3, 2, 2, false, 2, 3, true, 5, false, 33.37);
INSERT INTO unc_248557.dptos_habitacion VALUES (90, 4, 4, 3, 1, true, 2, 1, true, 1, false, 127.13);
INSERT INTO unc_248557.dptos_habitacion VALUES (18, 1, 4, 4, 1, true, 2, 2, false, 2, false, 129.56);
INSERT INTO unc_248557.dptos_habitacion VALUES (18, 2, 4, 1, 2, false, 1, 2, false, 8, false, 35.06);
INSERT INTO unc_248557.dptos_habitacion VALUES (59, 1, 4, 1, 2, false, 1, 3, true, 9, false, 143.13);
INSERT INTO unc_248557.dptos_habitacion VALUES (59, 2, 2, 3, 1, true, 1, 2, false, 10, false, 82.38);
INSERT INTO unc_248557.dptos_habitacion VALUES (59, 3, 4, 4, 2, true, 2, 3, true, 9, false, 26.88);
INSERT INTO unc_248557.dptos_habitacion VALUES (59, 4, 1, 2, 1, true, 1, 1, true, 9, false, 92.41);
INSERT INTO unc_248557.dptos_habitacion VALUES (59, 5, 1, 2, 2, true, 1, 1, true, 9, false, 50.50);
INSERT INTO unc_248557.dptos_habitacion VALUES (78, 1, 2, 3, 1, false, 1, 1, false, 1, false, 94.46);
INSERT INTO unc_248557.dptos_habitacion VALUES (78, 2, 4, 4, 1, true, 1, 2, false, 3, true, 90.32);
INSERT INTO unc_248557.dptos_habitacion VALUES (78, 3, 1, 1, 2, false, 1, 3, true, 9, false, 48.99);
INSERT INTO unc_248557.dptos_habitacion VALUES (98, 1, 4, 2, 2, true, 2, 3, false, 8, false, 103.23);
INSERT INTO unc_248557.dptos_habitacion VALUES (98, 2, 2, 1, 2, false, 2, 3, false, 1, false, 73.55);
INSERT INTO unc_248557.dptos_habitacion VALUES (63, 1, 3, 1, 1, true, 2, 1, true, 6, false, 122.56);
INSERT INTO unc_248557.dptos_habitacion VALUES (63, 2, 2, 2, 2, true, 2, 3, true, 10, false, 61.19);
INSERT INTO unc_248557.dptos_habitacion VALUES (9, 1, 1, 4, 2, false, 1, 3, true, 7, true, 55.81);
INSERT INTO unc_248557.dptos_habitacion VALUES (9, 2, 2, 1, 1, true, 2, 2, true, 8, true, 126.08);
INSERT INTO unc_248557.dptos_habitacion VALUES (24, 1, 1, 4, 2, false, 2, 3, true, 3, false, 50.84);
INSERT INTO unc_248557.dptos_habitacion VALUES (24, 2, 2, 1, 1, true, 1, 1, true, 1, false, 34.88);
INSERT INTO unc_248557.dptos_habitacion VALUES (64, 1, 1, 4, 1, false, 1, 1, true, 1, false, 13.09);
INSERT INTO unc_248557.dptos_habitacion VALUES (64, 2, 1, 4, 1, false, 1, 3, true, 6, true, 22.73);
INSERT INTO unc_248557.dptos_habitacion VALUES (64, 3, 3, 3, 1, true, 1, 2, false, 2, true, 29.35);
INSERT INTO unc_248557.dptos_habitacion VALUES (64, 4, 2, 4, 2, false, 1, 1, true, 4, false, 82.80);
INSERT INTO unc_248557.dptos_habitacion VALUES (64, 5, 3, 2, 2, false, 2, 3, false, 9, false, 98.67);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 1, 3, 1, 2, true, 1, 2, false, 4, false, 51.48);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 2, 1, 4, 2, false, 2, 1, false, 2, false, 18.16);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 3, 2, 3, 1, true, 1, 1, false, 2, false, 14.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 4, 4, 3, 1, true, 2, 1, false, 1, true, 53.49);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 5, 4, 1, 1, false, 2, 1, true, 9, false, 56.78);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 6, 3, 4, 1, true, 1, 1, false, 10, false, 13.30);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 7, 3, 3, 2, true, 1, 2, false, 8, false, 27.45);
INSERT INTO unc_248557.dptos_habitacion VALUES (55, 8, 1, 1, 2, false, 2, 3, true, 8, false, 47.87);
INSERT INTO unc_248557.dptos_habitacion VALUES (68, 1, 2, 3, 2, false, 2, 2, false, 5, false, 125.93);
INSERT INTO unc_248557.dptos_habitacion VALUES (68, 2, 1, 4, 2, true, 1, 1, false, 4, false, 98.40);
INSERT INTO unc_248557.dptos_habitacion VALUES (68, 3, 4, 4, 1, false, 1, 1, false, 9, true, 95.31);
INSERT INTO unc_248557.dptos_habitacion VALUES (84, 1, 2, 1, 1, false, 1, 2, true, 1, true, 58.10);
INSERT INTO unc_248557.dptos_habitacion VALUES (88, 1, 2, 3, 2, false, 2, 1, true, 5, false, 78.57);
INSERT INTO unc_248557.dptos_habitacion VALUES (88, 2, 1, 4, 1, true, 2, 1, false, 8, false, 22.86);
INSERT INTO unc_248557.dptos_habitacion VALUES (88, 3, 3, 4, 1, false, 1, 3, false, 3, true, 147.27);
INSERT INTO unc_248557.dptos_habitacion VALUES (88, 4, 2, 3, 1, true, 1, 3, false, 5, false, 78.93);
INSERT INTO unc_248557.dptos_habitacion VALUES (38, 1, 4, 4, 1, true, 2, 2, false, 6, false, 88.30);
INSERT INTO unc_248557.dptos_habitacion VALUES (38, 2, 3, 3, 1, true, 1, 3, true, 8, false, 130.77);
INSERT INTO unc_248557.dptos_habitacion VALUES (74, 1, 2, 3, 2, true, 1, 1, true, 2, false, 17.97);
INSERT INTO unc_248557.dptos_habitacion VALUES (74, 2, 1, 4, 1, false, 2, 3, false, 10, false, 35.83);
INSERT INTO unc_248557.dptos_habitacion VALUES (74, 3, 3, 2, 1, false, 1, 2, true, 10, true, 118.07);
INSERT INTO unc_248557.dptos_habitacion VALUES (74, 4, 3, 4, 1, true, 2, 3, true, 10, false, 128.39);
INSERT INTO unc_248557.dptos_habitacion VALUES (6, 1, 1, 4, 2, true, 1, 3, true, 10, false, 145.43);
INSERT INTO unc_248557.dptos_habitacion VALUES (6, 2, 3, 2, 1, false, 1, 3, false, 9, false, 26.22);
INSERT INTO unc_248557.dptos_habitacion VALUES (6, 3, 4, 1, 2, false, 2, 3, true, 8, false, 30.10);
INSERT INTO unc_248557.dptos_habitacion VALUES (71, 1, 2, 1, 2, false, 1, 1, true, 4, false, 41.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (71, 2, 3, 2, 1, true, 1, 2, false, 6, true, 110.86);
INSERT INTO unc_248557.dptos_habitacion VALUES (29, 1, 2, 1, 1, true, 1, 2, true, 5, true, 91.52);
INSERT INTO unc_248557.dptos_habitacion VALUES (29, 2, 1, 2, 1, false, 2, 2, true, 8, false, 83.68);
INSERT INTO unc_248557.dptos_habitacion VALUES (29, 3, 4, 3, 1, true, 2, 3, true, 10, false, 29.18);
INSERT INTO unc_248557.dptos_habitacion VALUES (29, 4, 4, 2, 2, false, 1, 2, true, 9, false, 126.50);
INSERT INTO unc_248557.dptos_habitacion VALUES (29, 5, 2, 3, 2, true, 2, 3, true, 6, false, 49.52);
INSERT INTO unc_248557.dptos_habitacion VALUES (2, 1, 1, 2, 1, true, 2, 3, false, 9, true, 87.24);
INSERT INTO unc_248557.dptos_habitacion VALUES (2, 2, 3, 1, 2, true, 1, 1, true, 8, true, 63.72);
INSERT INTO unc_248557.dptos_habitacion VALUES (72, 1, 4, 4, 2, false, 1, 1, true, 2, true, 127.78);
INSERT INTO unc_248557.dptos_habitacion VALUES (72, 2, 4, 1, 2, false, 2, 1, true, 5, true, 78.11);
INSERT INTO unc_248557.dptos_habitacion VALUES (72, 3, 1, 2, 1, true, 1, 1, false, 4, true, 149.35);
INSERT INTO unc_248557.dptos_habitacion VALUES (72, 4, 1, 1, 2, false, 2, 3, false, 3, true, 149.42);
INSERT INTO unc_248557.dptos_habitacion VALUES (72, 5, 4, 1, 2, false, 2, 2, true, 8, false, 26.40);
INSERT INTO unc_248557.dptos_habitacion VALUES (41, 1, 1, 4, 1, true, 1, 3, true, 10, false, 149.95);
INSERT INTO unc_248557.dptos_habitacion VALUES (41, 2, 3, 2, 1, true, 1, 3, false, 6, false, 65.26);
INSERT INTO unc_248557.dptos_habitacion VALUES (41, 3, 3, 3, 2, false, 1, 1, false, 10, false, 16.34);
INSERT INTO unc_248557.dptos_habitacion VALUES (7, 1, 3, 4, 1, true, 1, 2, true, 8, true, 132.58);
INSERT INTO unc_248557.dptos_habitacion VALUES (7, 2, 2, 2, 1, false, 2, 3, true, 9, true, 34.41);
INSERT INTO unc_248557.dptos_habitacion VALUES (7, 3, 1, 4, 2, false, 1, 3, false, 9, false, 42.74);
INSERT INTO unc_248557.dptos_habitacion VALUES (7, 4, 4, 2, 1, true, 1, 1, true, 4, true, 93.30);


--
-- Data for Name: huesped; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 13742965, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 15886290, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 24293944, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 25136092, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 24396015, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 10862358, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 7346498, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 12059270, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 17794714, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 10969042, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 13903127, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 28033668, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 18798903, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 29184888, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 11870429, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 9951025, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 18948738, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 11165347, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 21583861, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 29851066, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 7532989, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 25743011, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 5529831, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 16630721, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 26737732, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 28323666, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 8821662, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 21370337, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 23252809, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 26628542, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 22451784, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 6794352, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 15798702, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 11370335, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 24717893, 4);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 6434385, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 27254844, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 25823529, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 24419500, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 11587439, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 10008499, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 16725511, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 6833369, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 22478993, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 22313653, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 19601195, 5);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 13041560, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 15152489, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 18617145, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 22166044, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 24959390, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 27190774, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 10756287, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 22454734, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 4246820, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 8135698, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 20757135, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 28879365, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 11705876, 4);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 27875790, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 24494743, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 26959679, 2);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 10841700, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 17501340, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 5462294, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 18622442, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 22647473, 3);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 13013092, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 17446663, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 27022956, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 21510699, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('DNI', 21542004, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('LC ', 12441796, 0);
INSERT INTO unc_248557.dptos_huesped VALUES ('LE ', 12794589, 1);
INSERT INTO unc_248557.dptos_huesped VALUES ('PAS', 12674170, 0);


--
-- Data for Name: huesped_reserva; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 1);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 2);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 3);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11165347, 4);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 5);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11705876, 6);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10969042, 7);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 8);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 17794714, 9);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22313653, 10);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22454734, 11);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21583861, 12);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 27190774, 13);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 14);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 15);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 16);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18798903, 17);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 18);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 26737732, 19);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 21542004, 20);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 21);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 9951025, 22);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 23);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 24);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 25);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 17794714, 26);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27022956, 27);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6833369, 28);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 29);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 18948738, 30);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 10008499, 31);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 28033668, 32);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11165347, 33);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10862358, 34);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11705876, 35);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 16725511, 36);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18617145, 37);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 5529831, 38);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22166044, 39);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10756287, 40);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 28323666, 41);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13742965, 42);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 28879365, 43);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 44);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 45);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 46);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 23252809, 47);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 18948738, 48);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 49);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 50);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 18622442, 51);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 52);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 53);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 54);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 15886290, 55);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 28879365, 57);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 28033668, 58);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 25743011, 59);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10969042, 60);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10756287, 61);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 62);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 63);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7532989, 64);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10862358, 65);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 27190774, 66);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 67);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 21370337, 68);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 69);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22451784, 70);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11370335, 71);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 28879365, 72);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 73);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 74);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 75);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 5529831, 76);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 77);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 78);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 79);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11705876, 80);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11705876, 81);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 12794589, 82);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18798903, 83);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 84);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 85);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 86);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 87);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22454734, 88);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 89);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 90);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 91);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 92);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 21370337, 93);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7346498, 94);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 95);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13742965, 96);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 24959390, 97);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 98);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24293944, 99);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 100);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 1);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 1);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22454734, 2);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 3);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 3);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 3);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 4);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 4);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7346498, 5);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 5);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22478993, 6);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22313653, 6);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 7);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 17794714, 7);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10862358, 8);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7346498, 8);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 8);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 29851066, 9);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7532989, 9);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 25743011, 9);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 5529831, 9);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 10);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 15886290, 11);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24396015, 12);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10862358, 12);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7346498, 12);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 13);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 13);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 13);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21510699, 14);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 21542004, 14);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22451784, 15);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6794352, 15);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 16);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 16);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 17);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22166044, 18);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 24959390, 18);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 27190774, 18);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24293944, 19);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 19);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 20);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 20);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 21);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 22);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 20757135, 22);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11165347, 23);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21583861, 23);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 29851066, 23);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7532989, 23);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 24);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 24);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 24);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 18622442, 25);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 25);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 25);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 26);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 26);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 18622442, 27);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 27);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 27);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 27);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 28);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11370335, 28);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 28);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 29);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 29);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 30);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 20757135, 30);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 31);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 18622442, 31);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 31);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 32);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 32);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18617145, 32);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13903127, 33);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 28033668, 33);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18798903, 33);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24293944, 34);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 34);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 35);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7532989, 36);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 25743011, 36);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 5529831, 36);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 16630721, 36);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6794352, 37);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 37);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11370335, 37);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 38);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 39);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 39);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 39);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 40);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 40);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 20757135, 41);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 28879365, 41);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11705876, 41);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22166044, 42);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 24959390, 42);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 27190774, 42);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 43);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 43);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 43);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12059270, 44);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11587439, 45);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 10008499, 45);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 16725511, 45);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 29851066, 46);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 7532989, 46);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 25743011, 46);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 5529831, 46);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6794352, 47);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 47);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 48);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27022956, 48);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21510699, 48);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 21542004, 48);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 18948738, 49);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11165347, 49);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21583861, 49);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10756287, 50);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22454734, 50);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 50);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 50);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 51);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 51);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 51);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 52);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 53);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24396015, 53);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13742965, 54);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 15886290, 54);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24293944, 54);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 25136092, 54);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 28323666, 55);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8821662, 55);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 21370337, 55);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 23252809, 55);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13742965, 57);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 27875790, 58);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24494743, 58);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 59);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 59);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 59);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 60);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 60);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 9951025, 60);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 18948738, 60);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 61);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 62);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 62);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 21370337, 63);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 23252809, 63);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 64);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 64);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 23252809, 65);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 26628542, 65);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22451784, 65);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11587439, 66);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 10008499, 66);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 67);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 67);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 68);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12441796, 69);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 12794589, 69);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 12674170, 69);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15798702, 70);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11370335, 70);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 70);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 71);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 71);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 72);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 24717893, 73);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 6434385, 73);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 73);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 73);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 28323666, 74);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8821662, 74);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 29184888, 75);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 11870429, 75);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 9951025, 75);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 18948738, 75);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 21542004, 76);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12441796, 76);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 12794589, 76);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21510699, 77);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 21542004, 77);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 12441796, 77);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 12794589, 77);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 17794714, 78);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10969042, 78);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 79);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13013092, 80);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17446663, 80);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27022956, 80);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 21510699, 80);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 16630721, 81);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 26737732, 81);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 16725511, 82);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6833369, 82);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 27254844, 83);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 25823529, 83);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 83);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 26737732, 84);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 28323666, 84);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 85);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 85);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24494743, 86);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 26959679, 86);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 86);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 87);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 18622442, 87);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22647473, 87);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 24419500, 88);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 11587439, 88);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 6833369, 89);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22478993, 89);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 16630721, 90);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 26737732, 90);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 28323666, 90);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8821662, 90);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 23252809, 91);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 26628542, 91);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 22451784, 91);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 22166044, 92);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 24959390, 92);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 93);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 20757135, 93);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10756287, 94);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 22454734, 94);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 94);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 95);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 95);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 95);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 10841700, 96);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 17501340, 96);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 5462294, 96);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10969042, 97);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 13903127, 97);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 28033668, 97);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 18798903, 97);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 4246820, 98);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LE ', 8135698, 98);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('LC ', 19601195, 99);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 13041560, 99);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('DNI', 15152489, 99);
INSERT INTO unc_248557.dptos_huesped_reserva VALUES ('PAS', 10969042, 100);


--
-- Data for Name: pago; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-22 00:00:00', 1, 8, 'comentario 1', 114.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-02 00:00:00', 2, 8, 'comentario 2', 1005.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-11 00:00:00', 3, 13, 'comentario 3', 1195.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-14 00:00:00', 4, 19, 'comentario 4', 110.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-28 00:00:00', 5, 19, 'comentario 5', 82.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-18 00:00:00', 6, 18, 'comentario 6', 229.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-04 00:00:00', 7, 4, 'comentario 7', 205.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-07 00:00:00', 8, 17, 'comentario 8', 152.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-13 00:00:00', 9, 14, 'comentario 9', 627.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-03-31 00:00:00', 10, 3, 'comentario 10', 55.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-23 00:00:00', 11, 17, 'comentario 11', 508.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-25 00:00:00', 12, 16, 'comentario 12', 430.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-27 00:00:00', 13, 10, 'comentario 13', 540.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-16 00:00:00', 14, 15, 'comentario 14', 497.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-24 00:00:00', 15, 8, 'comentario 15', 1964.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-14 00:00:00', 16, 10, 'comentario 16', 421.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-02 00:00:00', 18, 19, 'comentario 18', 1217.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-06 00:00:00', 19, 18, 'comentario 19', 1190.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-22 00:00:00', 20, 12, 'comentario 20', 1227.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-03-29 00:00:00', 21, 4, 'comentario 21', 428.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-06 00:00:00', 22, 10, 'comentario 22', 444.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-02 00:00:00', 23, 9, 'comentario 23', 194.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-16 00:00:00', 24, 9, 'comentario 24', 473.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-04 00:00:00', 25, 14, 'comentario 25', 199.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-19 00:00:00', 26, 13, 'comentario 26', 449.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-25 00:00:00', 27, 14, 'comentario 27', 182.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-24 00:00:00', 28, 1, 'comentario 28', 511.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-09 00:00:00', 29, 15, 'comentario 29', 910.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-03-27 00:00:00', 30, 13, 'comentario 30', 83.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-09-28 00:00:00', 31, 2, 'comentario 31', 502.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-30 00:00:00', 32, 19, 'comentario 32', 1793.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-16 00:00:00', 33, 20, 'comentario 33', 189.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-14 00:00:00', 34, 9, 'comentario 34', 758.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-28 00:00:00', 35, 12, 'comentario 35', 256.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-13 00:00:00', 36, 19, 'comentario 36', 1155.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-29 00:00:00', 37, 8, 'comentario 37', 1643.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-29 00:00:00', 38, 10, 'comentario 38', 36.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-09-22 00:00:00', 39, 3, 'comentario 39', 922.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-08 00:00:00', 40, 5, 'comentario 40', 309.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-17 00:00:00', 41, 5, 'comentario 41', 1909.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-30 00:00:00', 42, 4, 'comentario 42', 367.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-17 00:00:00', 43, 2, 'comentario 43', 239.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-14 00:00:00', 44, 20, 'comentario 44', 710.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-06 00:00:00', 45, 13, 'comentario 45', 604.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-07 00:00:00', 46, 16, 'comentario 46', 79.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-24 00:00:00', 47, 8, 'comentario 47', 265.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-16 00:00:00', 48, 4, 'comentario 48', 874.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-03 00:00:00', 49, 15, 'comentario 49', 403.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-22 00:00:00', 50, 6, 'comentario 50', 1601.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-12 00:00:00', 52, 14, 'comentario 52', 973.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-02 00:00:00', 53, 18, 'comentario 53', 1142.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-31 00:00:00', 54, 15, 'comentario 54', 1723.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-11-01 00:00:00', 55, 4, 'comentario 55', 840.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-18 00:00:00', 57, 9, 'comentario 57', 125.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-03 00:00:00', 58, 16, 'comentario 58', 898.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-09-28 00:00:00', 59, 2, 'comentario 59', 563.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-07 00:00:00', 60, 9, 'comentario 60', 717.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-21 00:00:00', 61, 11, 'comentario 61', 340.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-23 00:00:00', 62, 14, 'comentario 62', 158.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-24 00:00:00', 63, 11, 'comentario 63', 473.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-15 00:00:00', 64, 9, 'comentario 64', 285.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-26 00:00:00', 65, 14, 'comentario 65', 212.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-14 00:00:00', 66, 19, 'comentario 66', 272.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-09 00:00:00', 67, 1, 'comentario 67', 855.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-11-02 00:00:00', 68, 12, 'comentario 68', 716.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-31 00:00:00', 69, 7, 'comentario 69', 238.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-11-18 00:00:00', 70, 10, 'comentario 70', 23.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-07 00:00:00', 71, 14, 'comentario 71', 1430.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-20 00:00:00', 72, 11, 'comentario 72', 300.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-06 00:00:00', 73, 14, 'comentario 73', 58.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-30 00:00:00', 74, 17, 'comentario 74', 278.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-26 00:00:00', 75, 12, 'comentario 75', 1564.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-18 00:00:00', 76, 14, 'comentario 76', 210.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-19 00:00:00', 77, 11, 'comentario 77', 139.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-08 00:00:00', 78, 8, 'comentario 78', 890.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-11-06 00:00:00', 79, 2, 'comentario 79', 942.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-17 00:00:00', 80, 13, 'comentario 80', 508.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-05-21 00:00:00', 81, 2, 'comentario 81', 117.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-07 00:00:00', 82, 6, 'comentario 82', 1169.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-01 00:00:00', 83, 8, 'comentario 83', 1127.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-24 00:00:00', 84, 19, 'comentario 84', 534.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-08 00:00:00', 85, 1, 'comentario 85', 610.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-10 00:00:00', 86, 10, 'comentario 86', 973.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-09-22 00:00:00', 87, 7, 'comentario 87', 786.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-01 00:00:00', 88, 9, 'comentario 88', 428.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-09-24 00:00:00', 89, 6, 'comentario 89', 757.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-03 00:00:00', 90, 7, 'comentario 90', 1579.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-07-19 00:00:00', 91, 18, 'comentario 91', 419.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-04-27 00:00:00', 92, 16, 'comentario 92', 1223.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-10-10 00:00:00', 94, 20, 'comentario 94', 823.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-11 00:00:00', 95, 9, 'comentario 95', 214.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-07 00:00:00', 96, 5, 'comentario 96', 558.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-12-04 00:00:00', 97, 14, 'comentario 97', 294.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-06-07 00:00:00', 98, 8, 'comentario 98', 619.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-08-18 00:00:00', 99, 5, 'comentario 99', 1983.000);
INSERT INTO unc_248557.dptos_pago VALUES ('2017-03-15 00:00:00', 100, 6, 'comentario 100', 1051.000);


--
-- Data for Name: persona; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 28033668, 'Cardenas', 'Acton', '1991-10-12', 'magna@pedeCum.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 19601195, 'Cooper', 'Medge', '1973-06-23', 'nibh.Quisque@mauris.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 24494743, 'Graves', 'Beatrice', '1964-12-27', 'egestas@Duis.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 7532989, 'Goodwin', 'Kenneth', '1984-07-22', 'mauris.sagittis@non.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 19275911, 'Hunter', 'Hollee', '1945-07-13', 'neque.vitae.semper@Vivamusmolestiedapibus.net');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 15152489, 'King', 'Orson', '1970-07-11', 'nisl.Maecenas.malesuada@Etiambibendum.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 21510699, 'Mcdonald', 'Anne', '1958-04-12', 'et.eros.Proin@lobortismaurisSuspendisse.com');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 24717893, 'David', 'Marsden', '1975-10-08', 'a@mus.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 13411764, 'Avery', 'Madonna', '1942-05-25', 'augue.porttitor.interdum@vitaealiquetnec.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 16725511, 'Webb', 'Lev', '1973-11-27', 'imperdiet.nec@inmagnaPhasellus.com');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 9951025, 'Burnett', 'Tyrone', '1990-02-19', 'eget.laoreet.posuere@odioNam.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 27022956, 'Mcintyre', 'Keaton', '1959-02-16', 'semper@erat.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 22478993, 'Wilcox', 'Kimberley', '1973-08-15', 'risus@ipsum.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 23252809, 'Fitzpatrick', 'Barclay', '1981-02-04', 'nunc.ullamcorper.eu@ornarelectusante.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 22647473, 'Valdez', 'Uma', '1960-03-24', 'ornare.sagittis@Suspendisse.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 10841700, 'Stevenson', 'Amela', '1962-09-18', 'posuere.cubilia@imperdiet.net');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 21542004, 'Cain', 'Yuli', '1958-04-08', 'Phasellus@et.com');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 28672823, 'Kidd', 'Jordan', '1949-08-03', 'sed.sem.egestas@magnased.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 28323666, 'Johns', 'Palmer', '1981-07-25', 'a@Vestibulumanteipsum.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 11870429, 'Stevenson', 'Kennan', '1990-11-22', 'penatibus.et.magnis@purusac.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 8135698, 'Vargas', 'Grady', '1967-03-28', 'at@scelerisquelorem.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 24001763, 'York', 'Dominique', '1949-09-21', 'eu.eros.Nam@tortor.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 27190774, 'Garcia', 'Ivana', '1968-04-14', 'lacinia.at.iaculis@dui.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 7346498, 'Ball', 'Keefe', '1994-09-13', 'tristique.senectus.et@nectempus.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 15886290, 'Morrow', 'Kiara', '1999-08-17', 'magna@tinciduntpede.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 24959390, 'Kirk', 'Flavia', '1968-11-30', 'est.Nunc.laoreet@ullamcorperDuiscursus.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 12674170, 'Leach', 'Inez', '1955-08-21', 'risus@Nunc.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 21791086, 'Barr', 'Nicholas', '1948-05-09', 'ornare@purus.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 26737732, 'Mcmahon', 'Macon', '1981-07-30', 'lacus@consequatdolor.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 22166044, 'Parker', 'McKenzie', '1969-02-05', 'tincidunt.congue.turpis@arcu.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 28035885, 'Cameron', 'Logan', '1949-10-23', 'ligula@indolor.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 24419500, 'Buckner', 'Baker', '1974-05-26', 'varius.et.euismod@acurnaUt.com');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 8388684, 'Harper', 'Rajah', '1950-05-21', 'nec.leo@facilisisfacilisis.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 27714612, 'Velasquez', 'Kennan', '1949-01-17', 'pharetra.sed.hendrerit@sociisnatoque.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 20420458, 'Floyd', 'Kyra', '1953-11-05', 'neque.Sed.eget@at.net');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 25872520, 'Cash', 'Jocelyn', '1952-05-21', 'magnis.dis.parturient@necmauris.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 6794352, 'Valenzuela', 'Wing', '1978-11-14', 'rutrum.lorem@egestas.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 26959679, 'Pickett', 'Dylan', '1963-10-17', 'orci.sem@liberoProinsed.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 7293853, 'Valdez', 'Portia', '1951-12-22', 'tempor@DonecestNunc.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 13124491, 'Sampson', 'Callie', '1942-02-09', 'Integer.vitae.nibh@malesuada.com');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 12059270, 'Monroe', 'Tatum', '1994-04-08', 'Vestibulum@velfaucibus.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 17794714, 'Briggs', 'Alan', '1993-12-15', 'neque.In@Utnecurna.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 10756287, 'Benjamin', 'Tanek', '1967-11-21', 'Fusce.fermentum@ideratEtiam.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 27875790, 'Preston', 'Aretha', '1965-08-23', 'sit.amet.ornare@nec.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 17501340, 'Davenport', 'Alfonso', '1961-11-25', 'molestie@a.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 24818747, 'Meadows', 'Quon', '1950-11-12', 'Donec@dolornonummy.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 6434385, 'Sampson', 'Sade', '1975-03-24', 'sodales.purus@tellusPhaselluselit.com');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 20757135, 'White', 'Donna', '1966-04-17', 'Praesent@arcueu.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 21583861, 'Austin', 'Jesse', '1987-12-04', 'Proin@malesuada.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 11165347, 'Gross', 'Jordan', '1988-07-27', 'orci.luctus@dolorFusce.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 13013092, 'Carey', 'Gail', '1959-08-13', 'pede@sociisnatoquepenatibus.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 17446663, 'Randolph', 'Regan', '1959-03-03', 'ac.urna@estvitaesodales.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 22162763, 'Callahan', 'Carol', '1940-03-23', 'sit.amet@maurisInteger.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 4538248, 'Sims', 'Kitra', '1945-12-08', 'Quisque@lectus.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 15798702, 'Kinney', 'Damon', '1978-10-30', 'imperdiet@accumsannequeet.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 16630721, 'Mullins', 'Darryl', '1982-07-05', 'Integer@velquamdignissim.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 24396015, 'Mcleod', 'Piper', '1997-09-03', 'Sed@est.net');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 11587439, 'Wilcox', 'Bethany', '1974-05-22', 'ultricies.ornare@euduiCum.com');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 22451784, 'Holt', 'Nita', '1979-03-30', 'molestie@vel.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 29851066, 'Maynard', 'Jason', '1987-01-12', 'ullamcorper@arcuet.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 25743011, 'Garrett', 'Bryar', '1983-12-28', 'magna.sed.dui@montesnasceturridiculus.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 9007536, 'Russo', 'Graham', '1951-05-14', 'ut.nisi.a@quis.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 12883858, 'Larson', 'Taylor', '1953-10-11', 'lacus.Quisque.imperdiet@blanditatnisi.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 12794589, 'Colon', 'Geraldine', '1956-01-08', 'Morbi@nunc.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 22313653, 'Sharp', 'Paul', '1973-07-11', 'amet@nunc.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 10862358, 'Keller', 'Hasad', '1997-03-30', 'sagittis.placerat.Cras@nibh.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 21370337, 'Perkins', 'Owen', '1981-02-10', 'Vivamus@a.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 29184888, 'Daniel', 'Jarrod', '1991-02-09', 'Sed.auctor.odio@Craslorem.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 20524129, 'Phelps', 'Basia', '1940-10-10', 'id.risus.quis@sollicitudinamalesuada.net');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 25136092, 'Wise', 'Melyssa', '1998-04-01', 'mauris@sitamet.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 25823529, 'Caldwell', 'Aretha', '1974-11-24', 'orci@montes.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 4455131, 'Williams', 'Noelle', '1944-10-21', 'Donec.feugiat.metus@Vestibulum.org');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 22454734, 'Lambert', 'Nola', '1967-09-17', 'euismod@loremvehiculaet.net');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 26130123, 'Hinton', 'Kelly', '1954-06-12', 'Nulla.semper@pedeultricesa.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 8263384, 'Yang', 'Acton', '1952-05-06', 'elit.a@turpis.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 12441796, 'Gray', 'Cody', '1957-01-26', 'ullamcorper@egetmollis.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 3210941, 'Delgado', 'Grady', '1951-05-11', 'eget.magna@mattis.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 5529831, 'Rhodes', 'Leo', '1983-03-11', 'justo@duiquisaccumsan.org');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 4348861, 'Wilkerson', 'Hop', '1945-12-20', 'Donec.sollicitudin.adipiscing@porttitorvulputateposuere.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 24293944, 'Jordan', 'Mohammad', '1999-01-28', 'Quisque.ac@velitin.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 27254844, 'Gould', 'Dalton', '1974-12-17', 'et.pede.Nunc@anteiaculisnec.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 18798903, 'Gallagher', 'Quamar', '1991-06-05', 'feugiat.tellus@cursuspurusNullam.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 5462294, 'Herring', 'Matthew', '1961-01-03', 'nec@cubiliaCuraeDonec.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 26628542, 'Cruz', 'Aidan', '1979-04-04', 'dignissim.Maecenas.ornare@inmolestie.net');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 8821662, 'Reed', 'Elijah', '1981-03-13', 'Aenean.egestas@facilisis.net');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 13742965, 'Robles', 'Kenyon', '1999-10-29', 'in.hendrerit.consectetuer@non.net');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 18617145, 'Ramirez', 'Shad', '1970-05-06', 'enim@ligulaNullam.net');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 10969042, 'Perez', 'Shay', '1993-09-06', 'ipsum.nunc.id@vitae.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 13041560, 'Rhodes', 'Driscoll', '1970-09-06', 'sociis.natoque.penatibus@atsemmolestie.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 6833369, 'Brock', 'Courtney', '1973-10-17', 'Etiam.bibendum@aliquet.edu');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 18948738, 'Guthrie', 'Aurora', '1989-06-02', 'in.hendrerit.consectetuer@Mauris.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 9819818, 'Horton', 'Colt', '1947-06-15', 'lorem.ipsum.sodales@nonsapienmolestie.com');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 11705876, 'Tillman', 'Jorden', '1965-11-30', 'molestie.tellus.Aenean@etmalesuadafames.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 13903127, 'Ball', 'Hoyt', '1991-11-07', 'dolor.quam@orciUtsemper.org');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 10008499, 'Whitfield', 'Cheyenne', '1974-05-14', 'nunc.In@Duis.com');
INSERT INTO unc_248557.dptos_persona VALUES ('PAS', 11370335, 'Morales', 'Ginger', '1976-01-06', 'Duis.dignissim.tempor@vulputateullamcorpermagna.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LC ', 28727968, 'Franks', 'Robert', '1948-12-19', 'libero.Integer.in@congueelit.ca');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 4246820, 'Villarreal', 'Oren', '1967-07-01', 'et@arcu.com');
INSERT INTO unc_248557.dptos_persona VALUES ('DNI', 28879365, 'Powell', 'Tana', '1966-03-26', 'elit.erat.vitae@noncursus.co.uk');
INSERT INTO unc_248557.dptos_persona VALUES ('LE ', 18622442, 'Fields', 'Ava', '1960-07-11', 'eu.dolor@Fuscealiquamenim.ca');


--
-- Data for Name: propietario; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 10008499, 1);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 21583861, 4);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 5529831, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 21791086, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 27190774, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 22162763, 0);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 18798903, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 29851066, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 13742965, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 13041560, 4);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 24717893, 10);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 16725511, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 11870429, 0);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 12674170, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 17794714, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 10756287, 4);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 25136092, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 22647473, 9);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 9951025, 9);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 13411764, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 27875790, 1);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 10862358, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 18948738, 5);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 13013092, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 11705876, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 18617145, 9);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 12059270, 4);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 26628542, 6);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 24293944, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 24419500, 6);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 20420458, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 4455131, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 28879365, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 25872520, 1);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 19275911, 0);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 4538248, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 4348861, 9);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 29184888, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 12441796, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 23252809, 5);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 22454734, 2);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 16630721, 1);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 27714612, 6);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 24494743, 10);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 6794352, 10);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 21542004, 0);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 13124491, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 20524129, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 22313653, 4);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 11587439, 9);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 25823529, 5);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 21510699, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 8135698, 3);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 28033668, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('DNI', 25743011, 0);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 3210941, 10);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 7293853, 8);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 8388684, 6);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 28035885, 5);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 9007536, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LC ', 28727968, 7);
INSERT INTO unc_248557.dptos_propietario VALUES ('LE ', 24396015, 5);
INSERT INTO unc_248557.dptos_propietario VALUES ('PAS', 5462294, 2);


--
-- Data for Name: reserva; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_reserva VALUES (1, '2017-12-02', '2017-12-22', '2017-12-28', 'LC ', 19601195, 3.00, 93.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (2, '2017-03-26', '2017-04-02', '2017-04-11', 'LC ', 27254844, 97.00, 35.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (4, '2017-05-10', '2017-05-14', '2017-05-28', 'PAS', 11165347, 2.00, 80.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (5, '2017-12-20', '2017-12-28', '2018-01-11', 'LE ', 8135698, 5.00, 7.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (6, '2017-07-15', '2017-07-18', '2017-07-20', 'DNI', 11705876, 73.00, 10.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (7, '2017-05-22', '2017-06-04', '2017-06-14', 'PAS', 10969042, 15.00, 40.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (8, '2017-08-06', '2017-08-07', '2017-08-09', 'PAS', 29184888, 25.00, 77.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (9, '2017-08-13', '2017-08-13', '2017-09-03', 'DNI', 17794714, 24.00, 99.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (12, '2017-04-24', '2017-04-25', '2017-05-16', 'LE ', 21583861, 19.00, 12.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (13, '2017-06-14', '2017-06-27', '2017-07-02', 'LE ', 27190774, 83.00, 42.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (15, '2017-08-18', '2017-08-24', '2017-09-13', 'DNI', 26959679, 89.00, 95.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (16, '2017-10-03', '2017-10-14', '2017-10-25', 'PAS', 5462294, 28.00, 85.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (18, '2017-10-02', '2017-10-02', '2017-10-18', 'LE ', 24717893, 68.00, 61.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (21, '2017-03-26', '2017-03-29', '2017-04-01', 'DNI', 15798702, 98.00, 36.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (22, '2017-10-02', '2017-10-06', '2017-10-16', 'PAS', 9951025, 33.00, 81.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (24, '2017-05-28', '2017-06-16', '2017-06-30', 'LC ', 19601195, 30.00, 23.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (27, '2017-08-07', '2017-08-25', '2017-09-03', 'LC ', 27022956, 11.00, 72.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (28, '2017-05-15', '2017-05-24', '2017-06-01', 'LE ', 6833369, 52.00, 43.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (29, '2017-12-04', '2017-12-09', '2017-12-18', 'LE ', 4246820, 84.00, 70.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (31, '2017-09-22', '2017-09-28', '2017-10-09', 'LE ', 10008499, 41.00, 10.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (32, '2017-05-12', '2017-05-30', '2017-06-20', 'LE ', 28033668, 81.00, 11.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (34, '2017-06-10', '2017-06-14', '2017-06-21', 'LC ', 10862358, 93.00, 14.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (36, '2017-12-04', '2017-12-13', '2017-12-23', 'PAS', 16725511, 97.00, 88.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (45, '2017-12-04', '2017-12-06', '2017-12-12', 'DNI', 15798702, 79.00, 51.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (46, '2017-03-25', '2017-04-07', '2017-04-26', 'LC ', 10841700, 0.00, 79.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (48, '2017-03-30', '2017-04-16', '2017-04-28', 'PAS', 18948738, 61.00, 81.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (52, '2017-06-06', '2017-06-12', '2017-06-24', 'LE ', 25136092, 69.00, 76.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (57, '2017-10-16', '2017-10-18', '2017-10-20', 'DNI', 28879365, 17.00, 74.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (58, '2017-07-18', '2017-08-03', '2017-08-11', 'LE ', 28033668, 98.00, 16.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (59, '2017-09-08', '2017-09-28', '2017-10-09', 'DNI', 25743011, 44.00, 35.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (63, '2017-10-08', '2017-10-24', '2017-10-28', 'LC ', 19601195, 92.00, 13.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (65, '2017-06-24', '2017-06-26', '2017-07-01', 'LC ', 10862358, 21.00, 86.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (68, '2017-10-19', '2017-11-02', '2017-11-22', 'LC ', 21370337, 30.00, 86.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (69, '2017-07-30', '2017-07-31', '2017-08-04', 'PAS', 13041560, 33.00, 73.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (71, '2017-10-05', '2017-10-07', '2017-10-24', 'PAS', 11370335, 78.00, 26.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (72, '2017-04-10', '2017-04-20', '2017-04-25', 'DNI', 28879365, 40.00, 60.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (77, '2017-07-13', '2017-07-19', '2017-07-27', 'LE ', 4246820, 7.00, 76.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (80, '2017-04-15', '2017-04-17', '2017-04-25', 'DNI', 11705876, 56.00, 4.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (82, '2017-06-19', '2017-07-07', '2017-07-23', 'LE ', 12794589, 64.00, 81.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (88, '2017-03-28', '2017-04-01', '2017-04-09', 'PAS', 22454734, 37.00, 95.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (91, '2017-07-07', '2017-07-19', '2017-07-26', 'LE ', 25136092, 51.00, 11.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (94, '2017-09-21', '2017-10-10', '2017-10-22', 'DNI', 7346498, 56.00, 95.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (96, '2017-05-25', '2017-06-07', '2017-06-13', 'LC ', 13742965, 69.00, 75.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (100, '2017-03-06', '2017-03-15', '2017-03-25', 'LC ', 17501340, 91.00, 50.000, false, 'D');
INSERT INTO unc_248557.dptos_reserva VALUES (10, '2017-03-26', '2017-03-31', '2017-04-09', 'LC ', 22313653, 1.00, 45.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (11, '2017-06-12', '2017-06-23', '2017-07-06', 'PAS', 22454734, 34.00, 32.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (14, '2017-08-10', '2017-08-16', '2017-08-26', 'DNI', 15798702, 39.00, 68.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (17, '2017-11-01', '2017-11-03', '2017-11-23', 'LC ', 18798903, 35.00, 11.000, true, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (19, '2017-04-03', '2017-04-06', '2017-04-25', 'PAS', 26737732, 58.00, 30.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (20, '2017-12-22', '2017-12-22', '2018-01-04', 'DNI', 21542004, 84.00, 51.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (23, '2017-09-20', '2017-10-02', '2017-10-19', 'LC ', 12059270, 8.00, 50.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (25, '2017-03-29', '2017-04-04', '2017-04-10', 'PAS', 24419500, 27.00, 10.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (26, '2017-12-15', '2017-12-19', '2017-12-25', 'DNI', 17794714, 61.00, 22.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (30, '2017-03-12', '2017-03-27', '2017-03-28', 'PAS', 18948738, 27.00, 29.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (33, '2017-04-05', '2017-04-16', '2017-04-28', 'PAS', 11165347, 14.00, 7.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (35, '2017-05-10', '2017-05-28', '2017-06-16', 'DNI', 11705876, 12.00, 16.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (37, '2017-06-14', '2017-06-29', '2017-07-16', 'LC ', 18617145, 88.00, 59.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (38, '2017-05-13', '2017-05-29', '2017-06-02', 'LC ', 5529831, 1.00, 31.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (39, '2017-09-09', '2017-09-22', '2017-10-03', 'LC ', 22166044, 73.00, 46.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (40, '2017-04-28', '2017-05-08', '2017-05-16', 'PAS', 10756287, 29.00, 48.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (41, '2017-04-10', '2017-04-17', '2017-05-06', 'LC ', 28323666, 91.00, 89.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (42, '2017-10-19', '2017-10-30', '2017-11-13', 'LC ', 13742965, 21.00, 52.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (43, '2017-06-28', '2017-07-17', '2017-07-24', 'DNI', 28879365, 26.00, 31.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (44, '2017-12-01', '2017-12-14', '2018-01-04', 'LC ', 19601195, 29.00, 72.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (47, '2017-05-19', '2017-05-24', '2017-06-01', 'LC ', 23252809, 23.00, 58.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (49, '2017-07-20', '2017-08-03', '2017-08-13', 'PAS', 24419500, 30.00, 73.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (50, '2017-10-14', '2017-10-22', '2017-11-09', 'PAS', 6434385, 81.00, 62.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (51, '2017-03-03', '2017-03-18', '2017-03-25', 'LE ', 18622442, 57.00, 29.000, true, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (53, '2017-06-20', '2017-07-02', '2017-07-15', 'PAS', 11870429, 80.00, 22.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (54, '2017-12-24', '2017-12-31', '2018-01-19', 'LE ', 24717893, 85.00, 23.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (55, '2017-10-30', '2017-11-01', '2017-11-14', 'LC ', 15886290, 57.00, 42.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (60, '2017-07-25', '2017-08-07', '2017-08-17', 'PAS', 10969042, 65.00, 2.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (61, '2017-07-15', '2017-07-21', '2017-08-03', 'PAS', 10756287, 24.00, 4.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (62, '2017-08-13', '2017-08-23', '2017-08-27', 'PAS', 24419500, 25.00, 33.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (64, '2017-05-09', '2017-05-15', '2017-05-18', 'DNI', 7532989, 57.00, 57.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (66, '2017-11-29', '2017-12-14', '2017-12-18', 'LE ', 27190774, 46.00, 42.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (67, '2017-05-22', '2017-06-09', '2017-06-28', 'LE ', 22647473, 42.00, 15.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (70, '2017-10-30', '2017-11-18', '2017-12-06', 'LE ', 22451784, 1.00, 4.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (73, '2017-03-24', '2017-04-06', '2017-04-13', 'PAS', 5462294, 0.00, 58.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (74, '2017-05-20', '2017-05-30', '2017-06-13', 'LE ', 22647473, 12.00, 98.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (75, '2017-06-20', '2017-06-26', '2017-07-16', 'LE ', 24717893, 70.00, 94.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (76, '2017-07-29', '2017-08-18', '2017-08-20', 'LC ', 5529831, 42.00, 84.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (78, '2017-09-18', '2017-10-08', '2017-10-17', 'PAS', 13041560, 85.00, 40.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (79, '2017-10-25', '2017-11-06', '2017-11-25', 'PAS', 5462294, 47.00, 2.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (81, '2017-05-20', '2017-05-21', '2017-05-22', 'DNI', 11705876, 36.00, 45.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (83, '2017-05-12', '2017-06-01', '2017-06-18', 'LC ', 18798903, 59.00, 65.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (84, '2017-07-08', '2017-07-24', '2017-07-30', 'PAS', 6434385, 66.00, 72.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (85, '2017-07-29', '2017-08-08', '2017-08-26', 'DNI', 26959679, 30.00, 40.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (86, '2017-04-09', '2017-04-10', '2017-04-20', 'LE ', 22647473, 81.00, 82.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (87, '2017-09-13', '2017-09-22', '2017-10-08', 'LC ', 12059270, 44.00, 38.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (89, '2017-09-05', '2017-09-24', '2017-10-10', 'PAS', 13041560, 42.00, 43.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (90, '2017-09-15', '2017-10-03', '2017-10-23', 'PAS', 29184888, 74.00, 25.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (92, '2017-04-10', '2017-04-27', '2017-05-09', 'LC ', 19601195, 94.00, 1.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (93, '2017-03-02', '2017-03-19', '2017-03-24', 'LC ', 21370337, 57.00, 59.000, true, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (95, '2017-07-24', '2017-08-11', '2017-08-29', 'LE ', 24717893, 8.00, 62.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (97, '2017-11-23', '2017-12-04', '2017-12-17', 'LC ', 24959390, 17.00, 56.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (98, '2017-06-04', '2017-06-07', '2017-06-16', 'PAS', 13013092, 52.00, 99.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (99, '2017-08-01', '2017-08-18', '2017-09-07', 'PAS', 24293944, 92.00, 51.000, false, 'H');
INSERT INTO unc_248557.dptos_reserva VALUES (3, '2017-03-29', '2017-04-11', '2017-04-26', 'PAS', 11870429, 73.00, 27.000, false, 'D');


--
-- Data for Name: reserva_dpto; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_reserva_dpto VALUES (22, 96);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (68, 38);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (58, 56);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (48, 56);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (65, 55);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (27, 84);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (3, 48);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (31, 66);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (82, 21);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (12, 55);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (15, 82);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (88, 58);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (100, 13);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (18, 55);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (59, 71);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (13, 97);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (34, 72);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (63, 52);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (72, 53);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (36, 94);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (16, 54);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (77, 84);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (94, 70);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (52, 84);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (71, 17);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (46, 31);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (80, 49);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (28, 95);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (5, 45);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (96, 54);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (9, 95);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (29, 14);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (69, 70);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (45, 86);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (24, 64);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (32, 71);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (21, 3);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (57, 71);
INSERT INTO unc_248557.dptos_reserva_dpto VALUES (91, 58);


--
-- Data for Name: reserva_hab; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_reserva_hab VALUES (1, 12, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (2, 3, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (4, 13, 6);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (6, 16, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (7, 5, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (8, 12, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (10, 25, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (11, 22, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (14, 27, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (17, 17, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (19, 27, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (20, 29, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (23, 1, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (25, 14, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (26, 8, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (30, 12, 6);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (33, 5, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (35, 12, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (37, 7, 4);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (38, 11, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (39, 1, 5);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (40, 7, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (41, 6, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (42, 17, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (43, 9, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (44, 29, 4);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (47, 16, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (49, 10, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (50, 24, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (51, 13, 6);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (53, 29, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (54, 5, 5);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (55, 16, 4);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (60, 13, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (61, 23, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (62, 23, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (64, 25, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (66, 17, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (67, 15, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (70, 22, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (73, 6, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (74, 12, 6);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (75, 20, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (76, 7, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (78, 28, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (79, 29, 5);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (81, 18, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (83, 3, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (84, 11, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (85, 29, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (86, 13, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (87, 12, 4);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (89, 5, 4);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (90, 20, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (92, 1, 2);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (93, 13, 6);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (95, 18, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (97, 16, 3);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (98, 24, 1);
INSERT INTO unc_248557.dptos_reserva_hab VALUES (99, 13, 5);


--
-- Data for Name: tipo_dpto; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_tipo_dpto VALUES (6, 9, 2, 2);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (3, 1, 2, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (2, 4, 2, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (4, 5, 3, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (1, 8, 2, 4);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (7, 6, 2, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (8, 2, 2, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (9, 7, 3, 5);
INSERT INTO unc_248557.dptos_tipo_dpto VALUES (5, 3, 1, 5);


--
-- Data for Name: tipo_pago; Type: TABLE DATA; Schema: unc_esq_dptos; Owner: unc_248557
--

INSERT INTO unc_248557.dptos_tipo_pago VALUES (1, 'Sed Auctor Company');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (2, 'Proin Sed Turpis Industries');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (3, 'Lacus Cras Interdum Consulting');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (4, 'Mauris Quis Turpis Foundation');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (5, 'Cras Foundation');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (6, 'Placerat Orci Lacus LLP');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (7, 'Interdum Institute');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (8, 'Bibendum Donec Felis');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (9, 'Ornare Libero Institute');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (10, 'Nec Mauris Company');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (11, 'Bibendum Institute');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (12, 'Sapien Cras LLC');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (13, 'Nascetur Ridiculus Mus');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (14, 'Risus Duis A Consulting');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (15, 'Neque Associates');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (16, 'Vestibulum Neque Inc.');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (17, 'Amet Dapibus Id Associates');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (18, 'Cras PC');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (19, 'Gravida Molestie PC');
INSERT INTO unc_248557.dptos_tipo_pago VALUES (20, 'Aliquet Molestie Tellus Corp.');


--
-- Name: ciudad ciudad_pk; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_ciudad
    ADD constraint dptos_ciudad_pk PRIMARY KEY (cod_ciudad);


--
-- Name: costo_hab costo_hab_pk; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_costo_hab
    ADD constraint dptos_costo_hab_pk PRIMARY KEY (id_dpto, id_habitacion, fecha_desde);


--
-- Name: comentario pk_comentario; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_comentario
    ADD constraint dptos_pk_comentario PRIMARY KEY (tipo_doc, nro_doc, id_reserva, fecha_hora_comentario);


--
-- Name: costo_depto pk_costo_depto; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_costo_depto
    ADD constraint dptos_pk_costo_depto PRIMARY KEY (id_dpto, fecha_desde);


--
-- Name: departamento pk_departamento; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_departamento
    ADD constraint dptos_pk_departamento PRIMARY KEY (id_dpto);


--
-- Name: edo_luego_ocupacion pk_edo_luego_ocupacion; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_edo_luego_ocupacion
    ADD constraint dptos_pk_edo_luego_ocupacion PRIMARY KEY (id_reserva, fecha);


--
-- Name: habitacion pk_habitacion; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_habitacion
    ADD constraint dptos_pk_habitacion PRIMARY KEY (id_dpto, id_habitacion);


--
-- Name: huesped pk_huesped; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_huesped
    ADD constraint dptos_pk_huesped PRIMARY KEY (tipo_doc, nro_doc);


--
-- Name: huesped_reserva pk_huesped_reserva; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_huesped_reserva
    ADD constraint dptos_pk_huesped_reserva PRIMARY KEY (tipo_doc, nro_doc, id_reserva);


--
-- Name: pago pk_pago; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_pago
    ADD constraint dptos_pk_pago PRIMARY KEY (fecha_pago, id_reserva, id_tipo_pago);


--
-- Name: persona pk_persona; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_persona
    ADD constraint dptos_pk_persona PRIMARY KEY (tipo_doc, nro_doc);


--
-- Name: propietario pk_propietario; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_propietario
    ADD constraint dptos_pk_propietario PRIMARY KEY (tipo_doc, nro_doc);


--
-- Name: reserva pk_reseva; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva
    ADD constraint dptos_pk_reseva PRIMARY KEY (id_reserva);


--
-- Name: tipo_dpto pk_tipo_dpto; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_tipo_dpto
    ADD constraint dptos_pk_tipo_dpto PRIMARY KEY (id_tipo_depto);


--
-- Name: tipo_pago pk_tipo_pago; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_tipo_pago
    ADD constraint dptos_pk_tipo_pago PRIMARY KEY (id_tipo_pago);


--
-- Name: reserva_dpto reserva_dpto_pk; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_dpto
    ADD constraint dptos_reserva_dpto_pk PRIMARY KEY (id_reserva);


--
-- Name: reserva_hab reserva_hab_pk; Type: CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_hab
    ADD constraint dptos_reserva_hab_pk PRIMARY KEY (id_reserva);


--
-- Name: comentario fk_comentario_huesped_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_comentario
    ADD constraint dptos_fk_comentario_huesped_reserva FOREIGN KEY (tipo_doc, nro_doc, id_reserva) REFERENCES unc_248557.dptos_huesped_reserva(tipo_doc, nro_doc, id_reserva);


--
-- Name: costo_depto fk_costo_depto_departamento; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_costo_depto
    ADD constraint dptos_fk_costo_depto_departamento FOREIGN KEY (id_dpto) REFERENCES unc_248557.dptos_departamento(id_dpto);


--
-- Name: costo_hab fk_costo_hab_habitacion; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_costo_hab
    ADD constraint dptos_fk_costo_hab_habitacion FOREIGN KEY (id_dpto, id_habitacion) REFERENCES unc_248557.dptos_habitacion(id_dpto, id_habitacion);


--
-- Name: departamento fk_departamento_ciudad; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_departamento
    ADD constraint dptos_fk_departamento_ciudad FOREIGN KEY (cod_ciudad) REFERENCES unc_248557.dptos_ciudad(cod_ciudad);


--
-- Name: departamento fk_departamento_propietario; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_departamento
    ADD constraint dptos_fk_departamento_propietario FOREIGN KEY (tipo_doc, nro_doc) REFERENCES unc_248557.dptos_propietario(tipo_doc, nro_doc);


--
-- Name: departamento fk_departamento_tipo_dpto; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_departamento
    ADD constraint dptos_fk_departamento_tipo_dpto FOREIGN KEY (id_tipo_depto) REFERENCES unc_248557.dptos_tipo_dpto(id_tipo_depto);


--
-- Name: edo_luego_ocupacion fk_edo_luego_ocupacion_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_edo_luego_ocupacion
    ADD constraint dptos_fk_edo_luego_ocupacion_reserva FOREIGN KEY (id_reserva) REFERENCES unc_248557.dptos_reserva(id_reserva);


--
-- Name: habitacion fk_habitacion_departamento; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_habitacion
    ADD constraint dptos_fk_habitacion_departamento FOREIGN KEY (id_dpto) REFERENCES unc_248557.dptos_departamento(id_dpto);


--
-- Name: huesped fk_huesped_persona; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_huesped
    ADD constraint dptos_fk_huesped_persona FOREIGN KEY (tipo_doc, nro_doc) REFERENCES unc_248557.dptos_persona(tipo_doc, nro_doc);


--
-- Name: huesped_reserva fk_huesped_reserva_huesped; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_huesped_reserva
    ADD constraint dptos_fk_huesped_reserva_huesped FOREIGN KEY (tipo_doc, nro_doc) REFERENCES unc_248557.dptos_huesped(tipo_doc, nro_doc);


--
-- Name: huesped_reserva fk_huesped_reserva_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_huesped_reserva
    ADD constraint dptos_fk_huesped_reserva_reserva FOREIGN KEY (id_reserva) REFERENCES unc_248557.dptos_reserva(id_reserva);


--
-- Name: pago fk_pago_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_pago
    ADD constraint dptos_fk_pago_reserva FOREIGN KEY (id_reserva) REFERENCES unc_248557.dptos_reserva(id_reserva);


--
-- Name: pago fk_pago_tipo_pago; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_pago
    ADD constraint dptos_fk_pago_tipo_pago FOREIGN KEY (id_tipo_pago) REFERENCES unc_248557.dptos_tipo_pago(id_tipo_pago);


--
-- Name: propietario fk_propietario_persona; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_propietario
    ADD constraint dptos_fk_propietario_persona FOREIGN KEY (tipo_doc, nro_doc) REFERENCES unc_248557.dptos_persona(tipo_doc, nro_doc);


--
-- Name: reserva_dpto fk_reserva_dpto_departamento; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_dpto
    ADD constraint dptos_fk_reserva_dpto_departamento FOREIGN KEY (id_dpto) REFERENCES unc_248557.dptos_departamento(id_dpto);


--
-- Name: reserva_dpto fk_reserva_dpto_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_dpto
    ADD constraint dptos_fk_reserva_dpto_reserva FOREIGN KEY (id_reserva) REFERENCES unc_248557.dptos_reserva(id_reserva);


--
-- Name: reserva_hab fk_reserva_hab_habitacion; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_hab
    ADD constraint dptos_fk_reserva_hab_habitacion FOREIGN KEY (id_dpto, id_habitacion) REFERENCES unc_248557.dptos_habitacion(id_dpto, id_habitacion);


--
-- Name: reserva_hab fk_reserva_hab_reserva; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva_hab
    ADD constraint dptos_fk_reserva_hab_reserva FOREIGN KEY (id_reserva) REFERENCES unc_248557.dptos_reserva(id_reserva);


--
-- Name: reserva fk_reserva_huesped; Type: FK CONSTRAINT; Schema: unc_esq_dptos; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.dptos_reserva
    ADD constraint dptos_fk_reserva_huesped FOREIGN KEY (tipo_doc, nro_doc) REFERENCES unc_248557.dptos_huesped(tipo_doc, nro_doc);


--
-- Name: SCHEMA unc_esq_dptos; Type: ACL; Schema: -; Owner: unc_248557
--

GRANT USAGE ON SCHEMA unc_esq_dptos TO PUBLIC;
GRANT ALL ON SCHEMA unc_esq_dptos TO unc_staff;
GRANT USAGE ON SCHEMA unc_esq_dptos TO unc_alumnos;


--
-- Name: TABLE ciudad; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_ciudad TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_ciudad TO PUBLIC;


--
-- Name: TABLE comentario; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_comentario TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_comentario TO PUBLIC;


--
-- Name: TABLE costo_depto; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_costo_depto TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_costo_depto TO PUBLIC;


--
-- Name: TABLE costo_hab; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_costo_hab TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_costo_hab TO PUBLIC;


--
-- Name: TABLE departamento; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_departamento TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_departamento TO PUBLIC;


--
-- Name: TABLE departamentoamplio; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_departamentoamplio TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_departamentoamplio TO PUBLIC;


--
-- Name: TABLE edo_luego_ocupacion; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_edo_luego_ocupacion TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_edo_luego_ocupacion TO PUBLIC;


--
-- Name: TABLE pago; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_pago TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_pago TO PUBLIC;


--
-- Name: TABLE reserva; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_reserva TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_reserva TO PUBLIC;


--
-- Name: TABLE estadoreserva; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_estadoreserva TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_estadoreserva TO PUBLIC;


--
-- Name: TABLE habitacion; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_habitacion TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_habitacion TO PUBLIC;


--
-- Name: TABLE habitacionsimple; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_habitacionsimple TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_habitacionsimple TO PUBLIC;


--
-- Name: TABLE habitacionmix; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_habitacionmix TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_habitacionmix TO PUBLIC;


--
-- Name: TABLE huesped; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_huesped TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_huesped TO PUBLIC;


--
-- Name: TABLE huesped_reserva; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_huesped_reserva TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_huesped_reserva TO PUBLIC;


--
-- Name: TABLE monoambienteamplio; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_monoambienteamplio TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_monoambienteamplio TO PUBLIC;


--
-- Name: TABLE persona; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_persona TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_persona TO PUBLIC;


--
-- Name: TABLE propietario; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_propietario TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_propietario TO PUBLIC;


--
-- Name: TABLE reserva_dpto; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_reserva_dpto TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_reserva_dpto TO PUBLIC;


--
-- Name: TABLE reserva_hab; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_reserva_hab TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_reserva_hab TO PUBLIC;


--
-- Name: TABLE tipo_dpto; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_tipo_dpto TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_tipo_dpto TO PUBLIC;


--
-- Name: TABLE tipo_pago; Type: ACL; Schema: unc_esq_dptos; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.dptos_tipo_pago TO unc_staff;
GRANT SELECT ON TABLE unc_248557.dptos_tipo_pago TO PUBLIC;


--
-- unc_248557QL database dump complete
--

