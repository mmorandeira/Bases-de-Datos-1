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
-- -- Name: unc_esq_producto; Type: SCHEMA; Schema: -; Owner: unc_248557
-- --

-- CREATE SCHEMA unc_esq_producto;


-- ALTER SCHEMA unc_esq_producto OWNER TO unc_248557;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: producto; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_producto (
    id_producto character varying(100) NOT NULL,
    id_tipo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    precio_unitario numeric(18,3) NOT NULL,
    descripcion character varying(1024)
);


ALTER TABLE unc_248557.producto_producto OWNER TO unc_248557;

--
-- Name: productoxorden; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_productoxorden (
    id_producto character varying(100) NOT NULL,
    nro_orden integer NOT NULL,
    cantidad numeric(18,3) NOT NULL
);


ALTER TABLE unc_248557.producto_productoxorden OWNER TO unc_248557;

--
-- Name: cliente; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_cliente (
    id_cliente integer NOT NULL,
    apellido character varying(100) NOT NULL,
    nombre character varying(100) NOT NULL,
    cuit character varying(24) NOT NULL,
    fecha_nacimiento timestamp without time zone NOT NULL
);


ALTER TABLE unc_248557.producto_cliente OWNER TO unc_248557;

--
-- Name: orden; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_orden (
    nro_orden integer NOT NULL,
    id_cliente integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    observaciones character varying(2048)
);


ALTER TABLE unc_248557.producto_orden OWNER TO unc_248557;

--
-- Name: stock; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_stock (
    fecha timestamp without time zone NOT NULL,
    id_producto character varying(100) NOT NULL,
    cantidad numeric(18,3) NOT NULL
);


ALTER TABLE unc_248557.producto_stock OWNER TO unc_248557;

--
-- Name: tipo; Type: TABLE; Schema: unc_esq_producto; Owner: unc_248557
--

CREATE TABLE unc_248557.producto_tipo (
    id_tipo integer NOT NULL,
    id_tipo_padre integer,
    nombre character varying(100) NOT NULL
);


ALTER TABLE unc_248557.producto_tipo OWNER TO unc_248557;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--

INSERT INTO unc_248557.producto_cliente VALUES (1, 'Sims', 'Michael', '318-98-5403', '1950-06-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (2, 'Fernandez', 'Lois', '238-86-8918', '1990-11-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (3, 'Fowler', 'Victor', '226-80-4882', '1960-05-16 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (4, 'Day', 'Sean', '964-22-9180', '1962-03-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (5, 'Brown', 'Michael', '118-63-3466', '1942-05-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (6, 'Anderson', 'Kathleen', '635-87-5219', '1977-02-13 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (7, 'Williams', 'Joseph', '645-33-4087', '1971-09-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (8, 'Payne', 'Jerry', '352-59-2461', '1972-01-02 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (9, 'Ryan', 'Sarah', '215-20-9281', '1951-01-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (10, 'Morales', 'Donna', '952-05-5631', '1958-12-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (11, 'Chapman', 'Lois', '364-28-6094', '1938-07-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (12, 'Richards', 'Debra', '991-03-7519', '1957-06-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (13, 'Hudson', 'Mildred', '977-00-1010', '1937-11-08 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (14, 'Cole', 'Gary', '549-81-1640', '1948-08-03 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (15, 'Cooper', 'Aaron', '107-54-8055', '1990-03-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (16, 'West', 'Roy', '490-69-2572', '1986-08-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (17, 'Jenkins', 'Brian', '877-60-9016', '1959-05-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (18, 'Bryant', 'Henry', '655-74-7073', '1975-05-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (19, 'Butler', 'Julia', '791-33-6711', '1962-03-02 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (20, 'Nichols', 'Sean', '796-72-4612', '1956-10-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (21, 'Harvey', 'Melissa', '582-77-7117', '1958-05-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (22, 'Brown', 'Frank', '757-19-3868', '1945-10-13 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (23, 'Owens', 'Joan', '276-09-1488', '1959-06-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (24, 'Wood', 'Julia', '921-76-4397', '1975-05-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (25, 'Johnston', 'Alice', '114-44-2268', '1993-06-04 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (26, 'Jenkins', 'Douglas', '183-99-3253', '1942-06-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (27, 'Bowman', 'Mildred', '288-71-2905', '1939-04-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (28, 'Fowler', 'Nancy', '848-29-2008', '1966-01-08 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (29, 'Fox', 'Dennis', '316-34-4655', '1947-03-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (30, 'Armstrong', 'Michael', '877-67-2955', '1984-07-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (31, 'Wells', 'Thomas', '167-38-4665', '1979-05-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (32, 'Welch', 'Terry', '465-40-1343', '1943-05-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (33, 'Harper', 'Nicole', '468-20-7812', '1944-10-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (34, 'Mitchell', 'Arthur', '883-34-8826', '1973-12-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (35, 'Wallace', 'Gerald', '441-02-8265', '1976-06-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (36, 'Morales', 'Paula', '754-40-5263', '1946-06-16 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (37, 'Watkins', 'Bruce', '896-83-4773', '1935-07-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (38, 'Sims', 'Steve', '125-56-4632', '1997-07-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (39, 'Simpson', 'Jose', '164-99-0900', '1990-09-04 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (40, 'Garza', 'Jimmy', '806-84-4597', '1970-05-02 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (41, 'Moreno', 'Janet', '629-63-0995', '1944-04-01 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (42, 'Tucker', 'Jeremy', '197-82-5006', '1989-01-08 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (43, 'Alexander', 'Carlos', '329-45-6679', '1946-10-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (44, 'Mcdonald', 'Gerald', '502-41-0320', '1932-08-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (45, 'Burke', 'Lisa', '424-72-2634', '1966-02-03 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (46, 'Gonzalez', 'Steve', '430-57-0026', '1979-06-01 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (47, 'Romero', 'Lawrence', '331-93-8455', '1940-02-08 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (48, 'Lee', 'Julie', '265-47-3007', '1936-01-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (49, 'Perez', 'Steven', '208-77-9503', '1947-06-04 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (50, 'Dunn', 'Jean', '315-23-4750', '1949-10-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (51, 'Wells', 'Robert', '828-41-1263', '1934-09-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (52, 'Thompson', 'Andrea', '675-99-1871', '1980-10-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (53, 'Burns', 'Sara', '526-42-7078', '1938-08-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (54, 'Sanders', 'Frank', '743-40-6518', '1968-02-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (55, 'Lewis', 'Betty', '832-05-0176', '1982-09-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (56, 'Marshall', 'Eugene', '271-24-9723', '1952-02-07 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (57, 'Murray', 'Edward', '563-34-9960', '1977-05-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (58, 'Mason', 'Peter', '403-31-0925', '1965-05-08 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (59, 'Roberts', 'George', '312-05-9494', '1978-01-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (60, 'Roberts', 'Louis', '472-58-8073', '1962-08-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (61, 'Webb', 'Anna', '395-67-3116', '1951-01-02 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (62, 'Wright', 'Amanda', '485-47-8774', '1986-06-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (63, 'Simpson', 'Matthew', '980-16-8042', '1949-12-01 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (64, 'Harper', 'Janet', '234-98-9963', '1939-09-02 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (65, 'Ramos', 'Debra', '356-41-8385', '1951-09-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (66, 'Castillo', 'John', '382-88-3033', '1953-01-03 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (67, 'Stone', 'Margaret', '483-63-4224', '1935-05-09 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (68, 'Carroll', 'Michelle', '235-08-1539', '1984-11-06 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (69, 'Gray', 'Ernest', '236-79-9616', '1952-04-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (70, 'Daniels', 'Annie', '261-55-5513', '1978-05-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (71, 'Hamilton', 'Arthur', '626-69-3342', '1945-10-05 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (72, 'Davis', 'Nicholas', '796-10-7777', '1986-05-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (73, 'Crawford', 'Diana', '746-61-4650', '1979-07-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (74, 'Willis', 'Peter', '176-70-1949', '1979-10-13 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (75, 'Gordon', 'Paula', '153-00-6797', '1989-01-17 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (76, 'Hart', 'Samuel', '920-62-5490', '1990-06-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (77, 'Morales', 'Albert', '106-61-8781', '1934-07-17 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (78, 'Stephens', 'Kathleen', '730-00-8328', '1986-02-21 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (79, 'Hill', 'Cynthia', '443-86-0686', '1994-07-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (80, 'Lopez', 'Jennifer', '633-23-4307', '1966-09-16 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (81, 'Hughes', 'Amy', '789-19-5382', '1964-06-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (82, 'Hall', 'Billy', '518-70-9928', '1942-02-20 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (83, 'Mendoza', 'Carl', '618-64-9053', '1951-07-11 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (84, 'Vasquez', 'Jane', '950-30-4673', '1978-08-19 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (85, 'Daniels', 'Donna', '488-93-4914', '1932-06-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (86, 'Morrison', 'Shirley', '327-02-6226', '1989-03-18 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (87, 'Hamilton', 'Jane', '854-20-1706', '1988-11-10 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (88, 'Dean', 'Andrea', '484-48-1786', '1992-01-19 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (89, 'Richardson', 'Cynthia', '870-21-4820', '1970-09-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (90, 'Roberts', 'Doris', '717-70-5193', '1947-05-12 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (91, 'Fox', 'Louis', '594-17-0704', '1949-08-20 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (92, 'Bryant', 'Kenneth', '195-57-6623', '1950-07-16 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (93, 'Schmidt', 'Brian', '672-14-3957', '1945-04-19 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (94, 'Henderson', 'Paula', '670-75-9452', '1981-11-16 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (95, 'Ray', 'Jimmy', '506-65-0730', '1963-12-14 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (96, 'Phillips', 'Diana', '981-37-3677', '1933-06-17 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (97, 'Phillips', 'Carolyn', '674-93-6506', '1946-12-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (98, 'Carroll', 'Phillip', '634-07-8837', '1984-07-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (99, 'Woods', 'Craig', '422-28-2137', '1945-02-15 00:00:00');
INSERT INTO unc_248557.producto_cliente VALUES (100, 'Turner', 'Lois', '425-88-7133', '1978-10-13 00:00:00');


--
-- Data for Name: orden; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--

INSERT INTO unc_248557.producto_orden VALUES (1, 99, '2015-11-17 00:00:00', 'magna vulputate luctus cum sociis natoque penatibus et');
INSERT INTO unc_248557.producto_orden VALUES (2, 17, '2015-06-21 00:00:00', 'pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut');
INSERT INTO unc_248557.producto_orden VALUES (3, 4, '2015-12-24 00:00:00', 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in');
INSERT INTO unc_248557.producto_orden VALUES (4, 55, '2015-01-17 00:00:00', 'nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget');
INSERT INTO unc_248557.producto_orden VALUES (5, 12, '2015-07-31 00:00:00', 'mauris eget massa tempor convallis');
INSERT INTO unc_248557.producto_orden VALUES (6, 81, '2015-03-14 00:00:00', 'et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus');
INSERT INTO unc_248557.producto_orden VALUES (7, 24, '2015-04-29 00:00:00', 'nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam');
INSERT INTO unc_248557.producto_orden VALUES (8, 8, '2015-02-07 00:00:00', 'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare');
INSERT INTO unc_248557.producto_orden VALUES (9, 14, '2015-03-26 00:00:00', 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis');
INSERT INTO unc_248557.producto_orden VALUES (10, 33, '2015-02-07 00:00:00', 'libero rutrum ac lobortis vel dapibus at diam nam');
INSERT INTO unc_248557.producto_orden VALUES (11, 100, '2015-06-07 00:00:00', 'dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non');
INSERT INTO unc_248557.producto_orden VALUES (12, 94, '2015-02-28 00:00:00', 'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec');
INSERT INTO unc_248557.producto_orden VALUES (13, 78, '2015-05-24 00:00:00', 'sapien cursus vestibulum proin eu mi nulla ac');
INSERT INTO unc_248557.producto_orden VALUES (14, 36, '2015-03-31 00:00:00', 'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus');
INSERT INTO unc_248557.producto_orden VALUES (15, 60, '2015-03-28 00:00:00', 'felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed');
INSERT INTO unc_248557.producto_orden VALUES (16, 52, '2015-07-26 00:00:00', 'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies');
INSERT INTO unc_248557.producto_orden VALUES (17, 53, '2015-05-30 00:00:00', 'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis');
INSERT INTO unc_248557.producto_orden VALUES (18, 33, '2015-12-28 00:00:00', 'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam');
INSERT INTO unc_248557.producto_orden VALUES (19, 81, '2015-07-30 00:00:00', 'massa donec dapibus duis at velit eu');
INSERT INTO unc_248557.producto_orden VALUES (20, 65, '2015-04-27 00:00:00', 'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst');
INSERT INTO unc_248557.producto_orden VALUES (21, 16, '2015-10-30 00:00:00', 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas');
INSERT INTO unc_248557.producto_orden VALUES (22, 27, '2015-06-22 00:00:00', 'donec dapibus duis at velit eu est congue elementum in hac');
INSERT INTO unc_248557.producto_orden VALUES (23, 85, '2015-09-27 00:00:00', 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula');
INSERT INTO unc_248557.producto_orden VALUES (24, 37, '2015-09-22 00:00:00', 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac');
INSERT INTO unc_248557.producto_orden VALUES (25, 5, '2015-08-24 00:00:00', 'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget');
INSERT INTO unc_248557.producto_orden VALUES (26, 94, '2015-06-26 00:00:00', 'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu');
INSERT INTO unc_248557.producto_orden VALUES (27, 81, '2014-11-27 00:00:00', 'luctus nec molestie sed justo');
INSERT INTO unc_248557.producto_orden VALUES (28, 5, '2015-12-24 00:00:00', 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in');
INSERT INTO unc_248557.producto_orden VALUES (29, 3, '2014-11-29 00:00:00', 'etiam vel augue vestibulum rutrum rutrum neque aenean');
INSERT INTO unc_248557.producto_orden VALUES (30, 78, '2015-07-29 00:00:00', 'rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce');
INSERT INTO unc_248557.producto_orden VALUES (31, 76, '2015-10-27 00:00:00', 'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque');
INSERT INTO unc_248557.producto_orden VALUES (32, 91, '2015-03-22 00:00:00', 'nunc purus phasellus in felis donec semper sapien a libero nam');
INSERT INTO unc_248557.producto_orden VALUES (33, 10, '2015-06-22 00:00:00', 'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus');
INSERT INTO unc_248557.producto_orden VALUES (34, 70, '2015-03-26 00:00:00', 'sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia');
INSERT INTO unc_248557.producto_orden VALUES (35, 78, '2015-02-27 00:00:00', 'duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in');
INSERT INTO unc_248557.producto_orden VALUES (36, 30, '2015-01-29 00:00:00', 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices');
INSERT INTO unc_248557.producto_orden VALUES (37, 95, '2015-02-26 00:00:00', 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est');
INSERT INTO unc_248557.producto_orden VALUES (38, 53, '2015-09-22 00:00:00', 'nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id');
INSERT INTO unc_248557.producto_orden VALUES (39, 33, '2015-08-30 00:00:00', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien');
INSERT INTO unc_248557.producto_orden VALUES (40, 45, '2015-09-23 00:00:00', 'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a');
INSERT INTO unc_248557.producto_orden VALUES (41, 4, '2015-11-21 00:00:00', 'fermentum donec ut mauris eget massa tempor convallis nulla neque');
INSERT INTO unc_248557.producto_orden VALUES (42, 98, '2014-11-20 00:00:00', 'luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend');
INSERT INTO unc_248557.producto_orden VALUES (43, 70, '2015-08-30 00:00:00', 'semper interdum mauris ullamcorper purus');
INSERT INTO unc_248557.producto_orden VALUES (44, 100, '2015-06-21 00:00:00', 'hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt');
INSERT INTO unc_248557.producto_orden VALUES (45, 13, '2015-02-25 00:00:00', 'mauris morbi non lectus aliquam sit amet');
INSERT INTO unc_248557.producto_orden VALUES (46, 76, '2015-09-29 00:00:00', 'amet lobortis sapien sapien non mi integer ac neque duis');
INSERT INTO unc_248557.producto_orden VALUES (47, 81, '2015-07-20 00:00:00', 'rutrum rutrum neque aenean auctor gravida sem praesent id');
INSERT INTO unc_248557.producto_orden VALUES (48, 38, '2015-04-23 00:00:00', 'ut erat curabitur gravida nisi at nibh in hac habitasse platea');
INSERT INTO unc_248557.producto_orden VALUES (49, 96, '2015-05-20 00:00:00', 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer');
INSERT INTO unc_248557.producto_orden VALUES (50, 44, '2015-04-22 00:00:00', 'consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla');
INSERT INTO unc_248557.producto_orden VALUES (51, 92, '2015-07-26 00:00:00', 'id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque');
INSERT INTO unc_248557.producto_orden VALUES (52, 47, '2015-03-29 00:00:00', 'blandit ultrices enim lorem ipsum');
INSERT INTO unc_248557.producto_orden VALUES (53, 39, '2015-08-22 00:00:00', 'etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras');
INSERT INTO unc_248557.producto_orden VALUES (54, 40, '2015-07-27 00:00:00', 'tristique est et tempus semper est quam pharetra magna');
INSERT INTO unc_248557.producto_orden VALUES (55, 22, '2015-02-26 00:00:00', 'habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel');
INSERT INTO unc_248557.producto_orden VALUES (56, 27, '2015-07-29 00:00:00', 'magna bibendum imperdiet nullam orci pede venenatis non');
INSERT INTO unc_248557.producto_orden VALUES (57, 96, '2015-10-27 00:00:00', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius');
INSERT INTO unc_248557.producto_orden VALUES (58, 58, '2015-01-29 00:00:00', 'fusce congue diam id ornare imperdiet sapien');
INSERT INTO unc_248557.producto_orden VALUES (59, 66, '2015-10-22 00:00:00', 'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida');
INSERT INTO unc_248557.producto_orden VALUES (60, 43, '2015-04-30 00:00:00', 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede');
INSERT INTO unc_248557.producto_orden VALUES (61, 31, '2015-02-27 00:00:00', 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium');
INSERT INTO unc_248557.producto_orden VALUES (62, 78, '2015-06-21 00:00:00', 'ligula suspendisse ornare consequat lectus in est');
INSERT INTO unc_248557.producto_orden VALUES (63, 40, '2015-02-21 00:00:00', 'vel nulla eget eros elementum');
INSERT INTO unc_248557.producto_orden VALUES (64, 62, '2015-06-24 00:00:00', 'odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit');
INSERT INTO unc_248557.producto_orden VALUES (65, 21, '2015-09-26 00:00:00', 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis');
INSERT INTO unc_248557.producto_orden VALUES (66, 14, '2015-05-28 00:00:00', 'vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum');
INSERT INTO unc_248557.producto_orden VALUES (67, 15, '2015-06-25 00:00:00', 'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi');
INSERT INTO unc_248557.producto_orden VALUES (68, 91, '2015-07-20 00:00:00', 'justo eu massa donec dapibus duis at velit eu est congue elementum in');
INSERT INTO unc_248557.producto_orden VALUES (69, 60, '2015-04-30 00:00:00', 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue');
INSERT INTO unc_248557.producto_orden VALUES (70, 2, '2015-01-25 00:00:00', 'duis faucibus accumsan odio curabitur convallis duis consequat dui');
INSERT INTO unc_248557.producto_orden VALUES (71, 33, '2015-04-23 00:00:00', 'ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam');
INSERT INTO unc_248557.producto_orden VALUES (72, 100, '2015-10-29 00:00:00', 'ac neque duis bibendum morbi non quam nec dui');
INSERT INTO unc_248557.producto_orden VALUES (73, 38, '2015-01-29 00:00:00', 'ante vel ipsum praesent blandit');
INSERT INTO unc_248557.producto_orden VALUES (74, 15, '2015-01-20 00:00:00', 'iaculis justo in hac habitasse platea');
INSERT INTO unc_248557.producto_orden VALUES (75, 10, '2015-05-29 00:00:00', 'id massa id nisl venenatis lacinia aenean');
INSERT INTO unc_248557.producto_orden VALUES (76, 76, '2014-12-28 00:00:00', 'morbi ut odio cras mi pede malesuada');
INSERT INTO unc_248557.producto_orden VALUES (77, 86, '2014-11-26 00:00:00', 'suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis');
INSERT INTO unc_248557.producto_orden VALUES (78, 5, '2015-01-27 00:00:00', 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea');
INSERT INTO unc_248557.producto_orden VALUES (79, 68, '2015-03-23 00:00:00', 'mi in porttitor pede justo eu massa donec dapibus duis at');
INSERT INTO unc_248557.producto_orden VALUES (80, 2, '2015-01-27 00:00:00', 'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta');
INSERT INTO unc_248557.producto_orden VALUES (81, 71, '2015-09-22 00:00:00', 'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam');
INSERT INTO unc_248557.producto_orden VALUES (82, 59, '2015-06-26 00:00:00', 'condimentum curabitur in libero ut');
INSERT INTO unc_248557.producto_orden VALUES (83, 38, '2014-12-27 00:00:00', 'vestibulum rutrum rutrum neque aenean');
INSERT INTO unc_248557.producto_orden VALUES (84, 22, '2015-06-24 00:00:00', 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate');
INSERT INTO unc_248557.producto_orden VALUES (85, 54, '2015-01-27 00:00:00', 'at turpis donec posuere metus vitae ipsum aliquam non mauris morbi');
INSERT INTO unc_248557.producto_orden VALUES (86, 23, '2015-03-22 00:00:00', 'ultrices posuere cubilia curae nulla dapibus');
INSERT INTO unc_248557.producto_orden VALUES (87, 85, '2015-06-26 00:00:00', 'tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse');
INSERT INTO unc_248557.producto_orden VALUES (88, 6, '2014-11-22 00:00:00', 'primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum');
INSERT INTO unc_248557.producto_orden VALUES (89, 13, '2015-01-22 00:00:00', 'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit');
INSERT INTO unc_248557.producto_orden VALUES (90, 70, '2014-11-20 00:00:00', 'vel pede morbi porttitor lorem');
INSERT INTO unc_248557.producto_orden VALUES (91, 80, '2015-04-24 00:00:00', 'massa id lobortis convallis tortor risus');
INSERT INTO unc_248557.producto_orden VALUES (92, 47, '2014-10-29 00:00:00', 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium');
INSERT INTO unc_248557.producto_orden VALUES (93, 6, '2015-07-22 00:00:00', 'dui vel sem sed sagittis nam congue risus semper porta volutpat quam');
INSERT INTO unc_248557.producto_orden VALUES (94, 76, '2015-07-23 00:00:00', 'dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis');
INSERT INTO unc_248557.producto_orden VALUES (95, 47, '2015-08-21 00:00:00', 'nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo');
INSERT INTO unc_248557.producto_orden VALUES (96, 89, '2015-03-21 00:00:00', 'leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor');
INSERT INTO unc_248557.producto_orden VALUES (97, 24, '2014-11-20 00:00:00', 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus');
INSERT INTO unc_248557.producto_orden VALUES (98, 24, '2015-04-27 00:00:00', 'dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus');
INSERT INTO unc_248557.producto_orden VALUES (99, 39, '2015-05-28 00:00:00', 'condimentum neque sapien placerat ante nulla justo');
INSERT INTO unc_248557.producto_orden VALUES (100, 74, '2015-07-23 00:00:00', 'cursus vestibulum proin eu mi nulla ac enim in tempor');
INSERT INTO unc_248557.producto_orden VALUES (101, 85, '2015-02-25 00:00:00', 'amet cursus id turpis integer aliquet massa');
INSERT INTO unc_248557.producto_orden VALUES (102, 53, '2014-12-24 00:00:00', 'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet');
INSERT INTO unc_248557.producto_orden VALUES (103, 5, '2015-05-26 00:00:00', 'diam cras pellentesque volutpat dui maecenas');
INSERT INTO unc_248557.producto_orden VALUES (104, 64, '2015-03-27 00:00:00', 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis');
INSERT INTO unc_248557.producto_orden VALUES (105, 29, '2015-04-20 00:00:00', 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero');
INSERT INTO unc_248557.producto_orden VALUES (106, 8, '2015-05-23 00:00:00', 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in');
INSERT INTO unc_248557.producto_orden VALUES (107, 99, '2015-02-27 00:00:00', 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio');
INSERT INTO unc_248557.producto_orden VALUES (108, 90, '2015-08-25 00:00:00', 'ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros');
INSERT INTO unc_248557.producto_orden VALUES (109, 77, '2015-04-20 00:00:00', 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia');
INSERT INTO unc_248557.producto_orden VALUES (110, 73, '2015-05-24 00:00:00', 'lacus at turpis donec posuere');
INSERT INTO unc_248557.producto_orden VALUES (111, 79, '2015-02-20 00:00:00', 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis');
INSERT INTO unc_248557.producto_orden VALUES (112, 33, '2015-06-29 00:00:00', 'erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis');
INSERT INTO unc_248557.producto_orden VALUES (113, 74, '2015-07-23 00:00:00', 'turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh');
INSERT INTO unc_248557.producto_orden VALUES (114, 4, '2015-05-27 00:00:00', 'morbi odio odio elementum eu interdum eu tincidunt');
INSERT INTO unc_248557.producto_orden VALUES (115, 26, '2015-11-24 00:00:00', 'iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla');
INSERT INTO unc_248557.producto_orden VALUES (116, 53, '2015-11-23 00:00:00', 'feugiat non pretium quis lectus suspendisse potenti in');
INSERT INTO unc_248557.producto_orden VALUES (117, 31, '2015-07-27 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia');
INSERT INTO unc_248557.producto_orden VALUES (118, 57, '2015-04-27 00:00:00', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum');
INSERT INTO unc_248557.producto_orden VALUES (119, 77, '2015-02-25 00:00:00', 'mattis egestas metus aenean fermentum donec ut mauris');
INSERT INTO unc_248557.producto_orden VALUES (120, 60, '2015-01-21 00:00:00', 'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in');
INSERT INTO unc_248557.producto_orden VALUES (121, 84, '2015-07-29 00:00:00', 'sapien varius ut blandit non interdum');
INSERT INTO unc_248557.producto_orden VALUES (122, 100, '2015-07-27 00:00:00', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque');
INSERT INTO unc_248557.producto_orden VALUES (123, 97, '2015-11-28 00:00:00', 'sapien dignissim vestibulum vestibulum ante ipsum primis');
INSERT INTO unc_248557.producto_orden VALUES (124, 28, '2015-07-23 00:00:00', 'etiam justo etiam pretium iaculis justo');
INSERT INTO unc_248557.producto_orden VALUES (125, 56, '2015-09-21 00:00:00', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices');
INSERT INTO unc_248557.producto_orden VALUES (126, 45, '2014-12-27 00:00:00', 'sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan');
INSERT INTO unc_248557.producto_orden VALUES (127, 2, '2015-10-23 00:00:00', 'blandit ultrices enim lorem ipsum dolor');
INSERT INTO unc_248557.producto_orden VALUES (128, 16, '2015-10-23 00:00:00', 'non ligula pellentesque ultrices phasellus');
INSERT INTO unc_248557.producto_orden VALUES (129, 67, '2015-06-26 00:00:00', 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis');
INSERT INTO unc_248557.producto_orden VALUES (130, 87, '2015-03-22 00:00:00', 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor');
INSERT INTO unc_248557.producto_orden VALUES (131, 41, '2014-11-23 00:00:00', 'ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer');
INSERT INTO unc_248557.producto_orden VALUES (132, 47, '2015-02-24 00:00:00', 'maecenas pulvinar lobortis est phasellus sit amet');
INSERT INTO unc_248557.producto_orden VALUES (133, 3, '2015-03-22 00:00:00', 'donec ut dolor morbi vel');
INSERT INTO unc_248557.producto_orden VALUES (134, 74, '2015-04-23 00:00:00', 'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales');
INSERT INTO unc_248557.producto_orden VALUES (135, 16, '2015-07-26 00:00:00', 'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus');
INSERT INTO unc_248557.producto_orden VALUES (136, 71, '2015-05-22 00:00:00', 'donec semper sapien a libero nam dui proin leo odio');
INSERT INTO unc_248557.producto_orden VALUES (137, 82, '2015-01-29 00:00:00', 'rhoncus aliquam lacus morbi quis');
INSERT INTO unc_248557.producto_orden VALUES (138, 48, '2015-11-25 00:00:00', 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac');
INSERT INTO unc_248557.producto_orden VALUES (139, 31, '2015-07-23 00:00:00', 'orci eget orci vehicula condimentum');
INSERT INTO unc_248557.producto_orden VALUES (140, 37, '2015-09-22 00:00:00', 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare');
INSERT INTO unc_248557.producto_orden VALUES (141, 97, '2015-08-28 00:00:00', 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis');
INSERT INTO unc_248557.producto_orden VALUES (142, 96, '2015-01-22 00:00:00', 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in');
INSERT INTO unc_248557.producto_orden VALUES (143, 61, '2015-10-25 00:00:00', 'tristique est et tempus semper est quam pharetra');
INSERT INTO unc_248557.producto_orden VALUES (144, 37, '2015-07-26 00:00:00', 'pretium nisl ut volutpat sapien');
INSERT INTO unc_248557.producto_orden VALUES (145, 27, '2015-03-25 00:00:00', 'venenatis tristique fusce congue diam id');
INSERT INTO unc_248557.producto_orden VALUES (146, 83, '2015-03-22 00:00:00', 'leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor');
INSERT INTO unc_248557.producto_orden VALUES (147, 76, '2015-12-27 00:00:00', 'vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis');
INSERT INTO unc_248557.producto_orden VALUES (148, 67, '2015-10-21 00:00:00', 'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam');
INSERT INTO unc_248557.producto_orden VALUES (149, 70, '2015-02-22 00:00:00', 'mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor');
INSERT INTO unc_248557.producto_orden VALUES (150, 64, '2015-03-26 00:00:00', 'sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum');
INSERT INTO unc_248557.producto_orden VALUES (151, 30, '2015-03-01 00:00:00', 'nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam');
INSERT INTO unc_248557.producto_orden VALUES (152, 63, '2015-03-28 00:00:00', 'rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat');
INSERT INTO unc_248557.producto_orden VALUES (153, 58, '2015-04-25 00:00:00', 'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante');
INSERT INTO unc_248557.producto_orden VALUES (154, 19, '2015-01-26 00:00:00', 'eget massa tempor convallis nulla');
INSERT INTO unc_248557.producto_orden VALUES (155, 35, '2015-02-20 00:00:00', 'curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum');
INSERT INTO unc_248557.producto_orden VALUES (156, 32, '2015-07-25 00:00:00', 'nunc nisl duis bibendum felis sed interdum venenatis turpis');
INSERT INTO unc_248557.producto_orden VALUES (157, 42, '2015-05-22 00:00:00', 'ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante');
INSERT INTO unc_248557.producto_orden VALUES (158, 51, '2015-08-22 00:00:00', 'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna');
INSERT INTO unc_248557.producto_orden VALUES (159, 8, '2015-10-21 00:00:00', 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci');
INSERT INTO unc_248557.producto_orden VALUES (160, 90, '2014-12-20 00:00:00', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu');
INSERT INTO unc_248557.producto_orden VALUES (161, 41, '2015-06-30 00:00:00', 'a libero nam dui proin');
INSERT INTO unc_248557.producto_orden VALUES (162, 74, '2015-01-29 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est');
INSERT INTO unc_248557.producto_orden VALUES (163, 45, '2015-01-22 00:00:00', 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed');
INSERT INTO unc_248557.producto_orden VALUES (164, 70, '2015-02-28 00:00:00', 'bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at');
INSERT INTO unc_248557.producto_orden VALUES (165, 12, '2015-02-21 00:00:00', 'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus');
INSERT INTO unc_248557.producto_orden VALUES (166, 82, '2015-11-30 00:00:00', 'sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras');
INSERT INTO unc_248557.producto_orden VALUES (167, 50, '2015-08-28 00:00:00', 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue');
INSERT INTO unc_248557.producto_orden VALUES (168, 12, '2015-08-24 00:00:00', 'enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper');
INSERT INTO unc_248557.producto_orden VALUES (169, 83, '2015-10-24 00:00:00', 'rhoncus sed vestibulum sit amet cursus id turpis');
INSERT INTO unc_248557.producto_orden VALUES (170, 65, '2015-06-23 00:00:00', 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat');
INSERT INTO unc_248557.producto_orden VALUES (171, 44, '2015-01-29 00:00:00', 'donec pharetra magna vestibulum aliquet ultrices erat tortor');
INSERT INTO unc_248557.producto_orden VALUES (172, 44, '2015-04-25 00:00:00', 'sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae');
INSERT INTO unc_248557.producto_orden VALUES (173, 60, '2015-05-27 00:00:00', 'blandit nam nulla integer pede');
INSERT INTO unc_248557.producto_orden VALUES (174, 73, '2015-01-25 00:00:00', 'tincidunt nulla mollis molestie lorem quisque ut');
INSERT INTO unc_248557.producto_orden VALUES (175, 19, '2014-12-28 00:00:00', 'vel nulla eget eros elementum pellentesque quisque');
INSERT INTO unc_248557.producto_orden VALUES (176, 64, '2015-07-29 00:00:00', 'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices');
INSERT INTO unc_248557.producto_orden VALUES (177, 17, '2014-10-28 00:00:00', 'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec');
INSERT INTO unc_248557.producto_orden VALUES (178, 36, '2015-05-25 00:00:00', 'sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus');
INSERT INTO unc_248557.producto_orden VALUES (179, 63, '2015-08-30 00:00:00', 'rutrum at lorem integer tincidunt');
INSERT INTO unc_248557.producto_orden VALUES (180, 41, '2015-01-26 00:00:00', 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu');
INSERT INTO unc_248557.producto_orden VALUES (181, 41, '2015-02-26 00:00:00', 'nunc vestibulum ante ipsum primis in faucibus orci');
INSERT INTO unc_248557.producto_orden VALUES (182, 74, '2015-09-21 00:00:00', 'purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes');
INSERT INTO unc_248557.producto_orden VALUES (183, 48, '2015-05-22 00:00:00', 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem');
INSERT INTO unc_248557.producto_orden VALUES (184, 64, '2015-10-27 00:00:00', 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit');
INSERT INTO unc_248557.producto_orden VALUES (185, 80, '2015-03-22 00:00:00', 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam');
INSERT INTO unc_248557.producto_orden VALUES (186, 19, '2015-02-27 00:00:00', 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum');
INSERT INTO unc_248557.producto_orden VALUES (187, 46, '2015-03-23 00:00:00', 'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh');
INSERT INTO unc_248557.producto_orden VALUES (188, 34, '2015-12-28 00:00:00', 'maecenas rhoncus aliquam lacus morbi quis tortor id');
INSERT INTO unc_248557.producto_orden VALUES (189, 94, '2015-02-25 00:00:00', 'non pretium quis lectus suspendisse potenti');
INSERT INTO unc_248557.producto_orden VALUES (190, 13, '2014-12-27 00:00:00', 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam');
INSERT INTO unc_248557.producto_orden VALUES (191, 25, '2015-05-25 00:00:00', 'consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere');
INSERT INTO unc_248557.producto_orden VALUES (192, 53, '2015-01-23 00:00:00', 'vehicula consequat morbi a ipsum integer a nibh in quis');
INSERT INTO unc_248557.producto_orden VALUES (193, 11, '2015-03-30 00:00:00', 'lectus in est risus auctor sed tristique in tempus sit amet sem fusce');
INSERT INTO unc_248557.producto_orden VALUES (194, 2, '2015-06-22 00:00:00', 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a');
INSERT INTO unc_248557.producto_orden VALUES (195, 5, '2015-06-26 00:00:00', 'fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend');
INSERT INTO unc_248557.producto_orden VALUES (196, 26, '2015-01-28 00:00:00', 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies');
INSERT INTO unc_248557.producto_orden VALUES (197, 12, '2015-06-22 00:00:00', 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer');
INSERT INTO unc_248557.producto_orden VALUES (198, 53, '2015-01-25 00:00:00', 'ac nulla sed vel enim sit amet nunc viverra dapibus');
INSERT INTO unc_248557.producto_orden VALUES (199, 100, '2015-05-27 00:00:00', 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit');
INSERT INTO unc_248557.producto_orden VALUES (200, 56, '2015-03-26 00:00:00', 'pharetra magna vestibulum aliquet ultrices erat');
INSERT INTO unc_248557.producto_orden VALUES (201, 28, '2014-11-20 00:00:00', 'id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet');
INSERT INTO unc_248557.producto_orden VALUES (202, 29, '2015-03-28 00:00:00', 'quam pharetra magna ac consequat metus sapien ut');
INSERT INTO unc_248557.producto_orden VALUES (203, 84, '2015-03-31 00:00:00', 'eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus');
INSERT INTO unc_248557.producto_orden VALUES (204, 31, '2015-02-20 00:00:00', 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa');
INSERT INTO unc_248557.producto_orden VALUES (205, 71, '2015-01-25 00:00:00', 'lectus aliquam sit amet diam in magna bibendum');
INSERT INTO unc_248557.producto_orden VALUES (206, 22, '2015-02-25 00:00:00', 'metus sapien ut nunc vestibulum ante ipsum primis');
INSERT INTO unc_248557.producto_orden VALUES (207, 83, '2015-06-23 00:00:00', 'eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam');
INSERT INTO unc_248557.producto_orden VALUES (208, 30, '2015-08-24 00:00:00', 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis');
INSERT INTO unc_248557.producto_orden VALUES (209, 45, '2015-02-22 00:00:00', 'eros vestibulum ac est lacinia');
INSERT INTO unc_248557.producto_orden VALUES (210, 72, '2015-11-28 00:00:00', 'at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes');
INSERT INTO unc_248557.producto_orden VALUES (211, 9, '2015-07-29 00:00:00', 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum');
INSERT INTO unc_248557.producto_orden VALUES (212, 76, '2014-10-28 00:00:00', 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec');
INSERT INTO unc_248557.producto_orden VALUES (213, 21, '2015-08-29 00:00:00', 'lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed');
INSERT INTO unc_248557.producto_orden VALUES (214, 33, '2015-03-27 00:00:00', 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis');
INSERT INTO unc_248557.producto_orden VALUES (215, 23, '2015-07-27 00:00:00', 'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper');
INSERT INTO unc_248557.producto_orden VALUES (216, 93, '2015-02-26 00:00:00', 'quis justo maecenas rhoncus aliquam lacus morbi quis');
INSERT INTO unc_248557.producto_orden VALUES (217, 68, '2015-03-24 00:00:00', 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing');
INSERT INTO unc_248557.producto_orden VALUES (218, 60, '2015-10-27 00:00:00', 'id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est');
INSERT INTO unc_248557.producto_orden VALUES (219, 31, '2015-12-31 00:00:00', 'ligula vehicula consequat morbi a ipsum');
INSERT INTO unc_248557.producto_orden VALUES (220, 43, '2014-11-25 00:00:00', 'nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac');
INSERT INTO unc_248557.producto_orden VALUES (221, 17, '2015-11-22 00:00:00', 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor');
INSERT INTO unc_248557.producto_orden VALUES (222, 89, '2015-07-24 00:00:00', 'enim lorem ipsum dolor sit amet');
INSERT INTO unc_248557.producto_orden VALUES (223, 23, '2015-05-20 00:00:00', 'lacinia nisi venenatis tristique fusce');
INSERT INTO unc_248557.producto_orden VALUES (224, 20, '2015-05-30 00:00:00', 'id luctus nec molestie sed justo pellentesque');
INSERT INTO unc_248557.producto_orden VALUES (225, 50, '2015-08-29 00:00:00', 'proin at turpis a pede posuere nonummy integer non velit donec');
INSERT INTO unc_248557.producto_orden VALUES (226, 94, '2015-11-29 00:00:00', 'in hac habitasse platea dictumst morbi vestibulum velit id pretium');
INSERT INTO unc_248557.producto_orden VALUES (227, 34, '2014-11-27 00:00:00', 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet');
INSERT INTO unc_248557.producto_orden VALUES (228, 19, '2014-11-24 00:00:00', 'penatibus et magnis dis parturient montes nascetur ridiculus');
INSERT INTO unc_248557.producto_orden VALUES (229, 19, '2015-07-29 00:00:00', 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue');
INSERT INTO unc_248557.producto_orden VALUES (230, 19, '2015-09-24 00:00:00', 'eget semper rutrum nulla nunc purus phasellus in felis donec semper');
INSERT INTO unc_248557.producto_orden VALUES (231, 68, '2015-08-28 00:00:00', 'cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit');
INSERT INTO unc_248557.producto_orden VALUES (232, 61, '2015-11-25 00:00:00', 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id');
INSERT INTO unc_248557.producto_orden VALUES (233, 97, '2015-10-24 00:00:00', 'molestie lorem quisque ut erat curabitur gravida nisi at nibh in');
INSERT INTO unc_248557.producto_orden VALUES (234, 98, '2015-12-24 00:00:00', 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede');
INSERT INTO unc_248557.producto_orden VALUES (235, 87, '2014-12-25 00:00:00', 'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum');
INSERT INTO unc_248557.producto_orden VALUES (236, 11, '2015-10-27 00:00:00', 'sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla');
INSERT INTO unc_248557.producto_orden VALUES (237, 21, '2015-05-22 00:00:00', 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus');
INSERT INTO unc_248557.producto_orden VALUES (238, 60, '2015-05-27 00:00:00', 'semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis');
INSERT INTO unc_248557.producto_orden VALUES (239, 99, '2015-08-22 00:00:00', 'sed ante vivamus tortor duis mattis egestas metus aenean');
INSERT INTO unc_248557.producto_orden VALUES (240, 7, '2015-04-25 00:00:00', 'sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere');
INSERT INTO unc_248557.producto_orden VALUES (241, 3, '2015-02-23 00:00:00', 'aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus');
INSERT INTO unc_248557.producto_orden VALUES (242, 93, '2015-05-29 00:00:00', 'bibendum felis sed interdum venenatis turpis enim blandit');
INSERT INTO unc_248557.producto_orden VALUES (243, 28, '2015-04-22 00:00:00', 'risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci');
INSERT INTO unc_248557.producto_orden VALUES (244, 25, '2014-12-28 00:00:00', 'odio odio elementum eu interdum eu tincidunt in');
INSERT INTO unc_248557.producto_orden VALUES (245, 28, '2015-10-25 00:00:00', 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna');
INSERT INTO unc_248557.producto_orden VALUES (246, 57, '2015-02-27 00:00:00', 'sed ante vivamus tortor duis mattis egestas');
INSERT INTO unc_248557.producto_orden VALUES (247, 59, '2015-08-29 00:00:00', 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue');
INSERT INTO unc_248557.producto_orden VALUES (248, 9, '2015-09-27 00:00:00', 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras');
INSERT INTO unc_248557.producto_orden VALUES (249, 61, '2015-06-29 00:00:00', 'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at');
INSERT INTO unc_248557.producto_orden VALUES (250, 96, '2015-05-25 00:00:00', 'vestibulum velit id pretium iaculis diam erat');
INSERT INTO unc_248557.producto_orden VALUES (251, 91, '2014-10-27 00:00:00', 'enim leo rhoncus sed vestibulum');
INSERT INTO unc_248557.producto_orden VALUES (252, 52, '2015-07-26 00:00:00', 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis');
INSERT INTO unc_248557.producto_orden VALUES (253, 3, '2015-03-20 00:00:00', 'nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam');
INSERT INTO unc_248557.producto_orden VALUES (254, 5, '2015-04-23 00:00:00', 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat');
INSERT INTO unc_248557.producto_orden VALUES (255, 63, '2015-07-23 00:00:00', 'vivamus in felis eu sapien cursus vestibulum proin eu mi nulla');
INSERT INTO unc_248557.producto_orden VALUES (256, 60, '2015-09-25 00:00:00', 'neque sapien placerat ante nulla justo');
INSERT INTO unc_248557.producto_orden VALUES (257, 19, '2014-12-28 00:00:00', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus');
INSERT INTO unc_248557.producto_orden VALUES (258, 61, '2015-08-23 00:00:00', 'magnis dis parturient montes nascetur ridiculus mus');
INSERT INTO unc_248557.producto_orden VALUES (259, 13, '2015-04-27 00:00:00', 'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede');
INSERT INTO unc_248557.producto_orden VALUES (260, 98, '2015-01-24 00:00:00', 'enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum');
INSERT INTO unc_248557.producto_orden VALUES (261, 87, '2015-07-29 00:00:00', 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus');
INSERT INTO unc_248557.producto_orden VALUES (262, 82, '2015-11-23 00:00:00', 'vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum');
INSERT INTO unc_248557.producto_orden VALUES (263, 78, '2015-03-30 00:00:00', 'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem');
INSERT INTO unc_248557.producto_orden VALUES (264, 28, '2014-10-29 00:00:00', 'ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede');
INSERT INTO unc_248557.producto_orden VALUES (265, 53, '2015-12-31 00:00:00', 'porttitor id consequat in consequat ut nulla');
INSERT INTO unc_248557.producto_orden VALUES (266, 77, '2014-11-28 00:00:00', 'duis aliquam convallis nunc proin at turpis a pede posuere nonummy');
INSERT INTO unc_248557.producto_orden VALUES (267, 95, '2015-06-26 00:00:00', 'id massa id nisl venenatis lacinia aenean sit amet justo');
INSERT INTO unc_248557.producto_orden VALUES (268, 12, '2015-05-24 00:00:00', 'varius ut blandit non interdum in ante');
INSERT INTO unc_248557.producto_orden VALUES (269, 16, '2015-07-24 00:00:00', 'hac habitasse platea dictumst morbi');
INSERT INTO unc_248557.producto_orden VALUES (270, 80, '2015-07-22 00:00:00', 'nulla integer pede justo lacinia eget tincidunt eget');
INSERT INTO unc_248557.producto_orden VALUES (271, 24, '2015-06-26 00:00:00', 'congue risus semper porta volutpat quam pede lobortis ligula sit');
INSERT INTO unc_248557.producto_orden VALUES (272, 11, '2015-05-27 00:00:00', 'sollicitudin mi sit amet lobortis sapien sapien non mi');
INSERT INTO unc_248557.producto_orden VALUES (273, 18, '2015-07-23 00:00:00', 'elementum nullam varius nulla facilisi cras non velit nec');
INSERT INTO unc_248557.producto_orden VALUES (274, 35, '2015-11-25 00:00:00', 'congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae');
INSERT INTO unc_248557.producto_orden VALUES (275, 29, '2014-10-23 00:00:00', 'nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing');
INSERT INTO unc_248557.producto_orden VALUES (276, 7, '2015-08-27 00:00:00', 'libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien');
INSERT INTO unc_248557.producto_orden VALUES (277, 38, '2015-10-25 00:00:00', 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus');
INSERT INTO unc_248557.producto_orden VALUES (278, 45, '2015-01-28 00:00:00', 'integer non velit donec diam neque vestibulum');
INSERT INTO unc_248557.producto_orden VALUES (279, 7, '2015-04-28 00:00:00', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id');
INSERT INTO unc_248557.producto_orden VALUES (280, 44, '2015-12-22 00:00:00', 'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean');
INSERT INTO unc_248557.producto_orden VALUES (281, 25, '2015-10-28 00:00:00', 'sed interdum venenatis turpis enim');
INSERT INTO unc_248557.producto_orden VALUES (282, 97, '2015-02-22 00:00:00', 'rhoncus aliquet pulvinar sed nisl nunc');
INSERT INTO unc_248557.producto_orden VALUES (283, 22, '2015-02-26 00:00:00', 'bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh');
INSERT INTO unc_248557.producto_orden VALUES (284, 79, '2015-05-21 00:00:00', 'ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut');
INSERT INTO unc_248557.producto_orden VALUES (285, 11, '2015-05-29 00:00:00', 'amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed');
INSERT INTO unc_248557.producto_orden VALUES (286, 79, '2015-02-21 00:00:00', 'vitae quam suspendisse potenti nullam porttitor');
INSERT INTO unc_248557.producto_orden VALUES (287, 25, '2015-07-25 00:00:00', 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl');
INSERT INTO unc_248557.producto_orden VALUES (288, 55, '2015-05-23 00:00:00', 'pretium nisl ut volutpat sapien arcu');
INSERT INTO unc_248557.producto_orden VALUES (289, 97, '2015-07-28 00:00:00', 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id');
INSERT INTO unc_248557.producto_orden VALUES (290, 97, '2015-02-21 00:00:00', 'platea dictumst morbi vestibulum velit id pretium iaculis diam');
INSERT INTO unc_248557.producto_orden VALUES (291, 67, '2015-12-28 00:00:00', 'tellus semper interdum mauris ullamcorper purus sit');
INSERT INTO unc_248557.producto_orden VALUES (292, 67, '2015-03-23 00:00:00', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien');
INSERT INTO unc_248557.producto_orden VALUES (293, 99, '2015-10-29 00:00:00', 'nulla sed vel enim sit amet nunc viverra dapibus');
INSERT INTO unc_248557.producto_orden VALUES (294, 63, '2015-11-20 00:00:00', 'pede ac diam cras pellentesque volutpat');
INSERT INTO unc_248557.producto_orden VALUES (295, 61, '2015-04-20 00:00:00', 'ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam');
INSERT INTO unc_248557.producto_orden VALUES (296, 33, '2015-02-26 00:00:00', 'eleifend luctus ultricies eu nibh quisque id');
INSERT INTO unc_248557.producto_orden VALUES (297, 57, '2015-07-26 00:00:00', 'pellentesque volutpat dui maecenas tristique');
INSERT INTO unc_248557.producto_orden VALUES (298, 66, '2015-04-29 00:00:00', 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit');
INSERT INTO unc_248557.producto_orden VALUES (299, 4, '2015-02-20 00:00:00', 'a libero nam dui proin leo odio');
INSERT INTO unc_248557.producto_orden VALUES (300, 63, '2015-04-26 00:00:00', 'ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula');


--
-- Data for Name: producto; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--

INSERT INTO unc_248557.producto_producto VALUES ('1', 11, 'lorem', 1646.670, 'pede venenatis non');
INSERT INTO unc_248557.producto_producto VALUES ('2', 6, 'nulla', 1618.150, 'semper rutrum nulla nunc');
INSERT INTO unc_248557.producto_producto VALUES ('3', 29, 'in', 1223.850, 'in faucibus orci luctus');
INSERT INTO unc_248557.producto_producto VALUES ('4', 24, 'in', 691.220, 'eget eleifend');
INSERT INTO unc_248557.producto_producto VALUES ('5', 19, 'vestibulum', 2479.820, 'nisl venenatis lacinia');
INSERT INTO unc_248557.producto_producto VALUES ('6', 21, 'mi', 2574.240, 'quis orci eget');
INSERT INTO unc_248557.producto_producto VALUES ('7', 24, 'id', 1786.840, 'auctor sed');
INSERT INTO unc_248557.producto_producto VALUES ('8', 7, 'ut', 1824.500, 'morbi non');
INSERT INTO unc_248557.producto_producto VALUES ('9', 6, 'nulla', 113.620, 'egestas metus');
INSERT INTO unc_248557.producto_producto VALUES ('10', 25, 'dui', 516.990, 'suscipit nulla elit');
INSERT INTO unc_248557.producto_producto VALUES ('11', 21, 'curabitur', 1861.180, 'maecenas ut');
INSERT INTO unc_248557.producto_producto VALUES ('12', 13, 'aliquet', 433.480, 'mauris vulputate elementum nullam');
INSERT INTO unc_248557.producto_producto VALUES ('13', 11, 'purus', 2555.430, 'condimentum id luctus');
INSERT INTO unc_248557.producto_producto VALUES ('14', 16, 'ac', 2862.060, 'erat fermentum justo');
INSERT INTO unc_248557.producto_producto VALUES ('15', 4, 'mi', 1646.890, 'est quam pharetra magna');
INSERT INTO unc_248557.producto_producto VALUES ('16', 26, 'justo', 1947.730, 'sagittis sapien');
INSERT INTO unc_248557.producto_producto VALUES ('17', 15, 'nisl', 2068.450, 'neque aenean');
INSERT INTO unc_248557.producto_producto VALUES ('18', 18, 'aliquam', 1458.300, 'ut odio cras');
INSERT INTO unc_248557.producto_producto VALUES ('19', 8, 'nec', 1598.280, 'convallis nulla neque');
INSERT INTO unc_248557.producto_producto VALUES ('20', 17, 'pede', 2077.240, 'vel augue');
INSERT INTO unc_248557.producto_producto VALUES ('21', 17, 'nunc', 1034.590, 'fusce lacus');
INSERT INTO unc_248557.producto_producto VALUES ('22', 11, 'orci', 392.700, 'donec quis');
INSERT INTO unc_248557.producto_producto VALUES ('23', 15, 'sit', 2823.960, 'mauris viverra diam vitae');
INSERT INTO unc_248557.producto_producto VALUES ('24', 4, 'massa', 170.070, 'risus auctor sed');
INSERT INTO unc_248557.producto_producto VALUES ('25', 23, 'justo', 220.730, 'arcu libero rutrum ac');
INSERT INTO unc_248557.producto_producto VALUES ('26', 24, 'diam', 2451.910, 'augue a suscipit nulla');
INSERT INTO unc_248557.producto_producto VALUES ('27', 3, 'adipiscing', 2456.740, 'aliquam augue quam sollicitudin');
INSERT INTO unc_248557.producto_producto VALUES ('28', 8, 'erat', 485.110, 'nec molestie');
INSERT INTO unc_248557.producto_producto VALUES ('29', 13, 'tristique', 1167.180, 'turpis adipiscing');
INSERT INTO unc_248557.producto_producto VALUES ('30', 11, 'consequat', 1770.900, 'posuere cubilia curae mauris');
INSERT INTO unc_248557.producto_producto VALUES ('31', 14, 'ligula', 954.400, 'accumsan tellus');
INSERT INTO unc_248557.producto_producto VALUES ('32', 7, 'ultrices', 2689.890, 'leo pellentesque ultrices');
INSERT INTO unc_248557.producto_producto VALUES ('33', 17, 'nisl', 630.060, 'ultricies eu');
INSERT INTO unc_248557.producto_producto VALUES ('34', 2, 'vel', 1384.540, 'orci luctus et ultrices');
INSERT INTO unc_248557.producto_producto VALUES ('35', 6, 'luctus', 14.730, 'lobortis convallis');
INSERT INTO unc_248557.producto_producto VALUES ('36', 21, 'libero', 2676.150, 'orci eget orci vehicula');
INSERT INTO unc_248557.producto_producto VALUES ('37', 30, 'morbi', 1277.690, 'vulputate elementum nullam varius');
INSERT INTO unc_248557.producto_producto VALUES ('38', 8, 'ac', 68.710, 'turpis sed ante');
INSERT INTO unc_248557.producto_producto VALUES ('39', 12, 'imperdiet', 1578.030, 'congue vivamus metus arcu');
INSERT INTO unc_248557.producto_producto VALUES ('40', 25, 'dolor', 2946.340, 'lacus morbi');
INSERT INTO unc_248557.producto_producto VALUES ('41', 24, 'blandit', 2940.690, 'aliquam lacus');
INSERT INTO unc_248557.producto_producto VALUES ('42', 16, 'tempor', 140.520, 'faucibus orci');
INSERT INTO unc_248557.producto_producto VALUES ('43', 2, 'ut', 2108.620, 'viverra pede');
INSERT INTO unc_248557.producto_producto VALUES ('44', 21, 'sociis', 2574.420, 'ante ipsum primis');
INSERT INTO unc_248557.producto_producto VALUES ('45', 26, 'dictumst', 306.970, 'aliquet at feugiat');
INSERT INTO unc_248557.producto_producto VALUES ('46', 27, 'curae', 206.520, 'proin risus');
INSERT INTO unc_248557.producto_producto VALUES ('47', 7, 'lorem', 2679.550, 'faucibus accumsan odio');
INSERT INTO unc_248557.producto_producto VALUES ('48', 2, 'metus', 710.220, 'tortor eu');
INSERT INTO unc_248557.producto_producto VALUES ('49', 12, 'lacinia', 466.740, 'proin eu');
INSERT INTO unc_248557.producto_producto VALUES ('50', 22, 'vestibulum', 254.380, 'sapien quis');
INSERT INTO unc_248557.producto_producto VALUES ('51', 15, 'eros', 646.510, 'luctus rutrum nulla');
INSERT INTO unc_248557.producto_producto VALUES ('52', 3, 'lectus', 2694.010, 'orci luctus');
INSERT INTO unc_248557.producto_producto VALUES ('53', 18, 'vitae', 1904.350, 'primis in faucibus');
INSERT INTO unc_248557.producto_producto VALUES ('54', 27, 'magna', 2459.350, 'consequat in consequat ut');
INSERT INTO unc_248557.producto_producto VALUES ('55', 10, 'vulputate', 2143.720, 'penatibus et magnis dis');
INSERT INTO unc_248557.producto_producto VALUES ('56', 23, 'aliquam', 1066.130, 'in libero ut');
INSERT INTO unc_248557.producto_producto VALUES ('57', 29, 'est', 2415.050, 'rutrum at lorem');
INSERT INTO unc_248557.producto_producto VALUES ('58', 17, 'rutrum', 2637.530, 'turpis sed');
INSERT INTO unc_248557.producto_producto VALUES ('59', 5, 'ut', 505.190, 'metus vitae ipsum');
INSERT INTO unc_248557.producto_producto VALUES ('60', 4, 'nonummy', 1089.320, 'orci luctus');
INSERT INTO unc_248557.producto_producto VALUES ('61', 27, 'eleifend', 2533.200, 'vestibulum sagittis sapien cum');
INSERT INTO unc_248557.producto_producto VALUES ('62', 19, 'at', 75.580, 'neque libero');
INSERT INTO unc_248557.producto_producto VALUES ('63', 25, 'vestibulum', 2191.580, 'gravida nisi at nibh');
INSERT INTO unc_248557.producto_producto VALUES ('64', 28, 'lacus', 1173.780, 'eleifend luctus ultricies');
INSERT INTO unc_248557.producto_producto VALUES ('65', 4, 'aenean', 354.170, 'lacus morbi quis tortor');
INSERT INTO unc_248557.producto_producto VALUES ('66', 2, 'felis', 250.100, 'vivamus tortor');
INSERT INTO unc_248557.producto_producto VALUES ('67', 16, 'posuere', 72.450, 'ut volutpat sapien');
INSERT INTO unc_248557.producto_producto VALUES ('68', 21, 'nisl', 768.220, 'magna vulputate');
INSERT INTO unc_248557.producto_producto VALUES ('69', 4, 'phasellus', 2880.560, 'luctus et ultrices posuere');
INSERT INTO unc_248557.producto_producto VALUES ('70', 6, 'justo', 1880.450, 'convallis duis consequat dui');
INSERT INTO unc_248557.producto_producto VALUES ('71', 30, 'donec', 2343.760, 'nibh in hac habitasse');
INSERT INTO unc_248557.producto_producto VALUES ('72', 5, 'lacinia', 667.010, 'lacinia eget tincidunt');
INSERT INTO unc_248557.producto_producto VALUES ('73', 22, 'suspendisse', 2347.660, 'dis parturient montes nascetur');
INSERT INTO unc_248557.producto_producto VALUES ('74', 29, 'sed', 851.260, 'nam congue risus semper');
INSERT INTO unc_248557.producto_producto VALUES ('75', 5, 'orci', 2664.000, 'sed vel enim sit');
INSERT INTO unc_248557.producto_producto VALUES ('76', 29, 'venenatis', 533.700, 'in purus eu');
INSERT INTO unc_248557.producto_producto VALUES ('77', 20, 'risus', 1447.210, 'molestie sed justo pellentesque');
INSERT INTO unc_248557.producto_producto VALUES ('78', 23, 'gravida', 567.970, 'natoque penatibus');
INSERT INTO unc_248557.producto_producto VALUES ('79', 7, 'nulla', 2792.640, 'morbi non');
INSERT INTO unc_248557.producto_producto VALUES ('80', 15, 'mauris', 2457.310, 'nibh fusce lacus');
INSERT INTO unc_248557.producto_producto VALUES ('81', 9, 'pretium', 635.890, 'sapien ut nunc vestibulum');
INSERT INTO unc_248557.producto_producto VALUES ('82', 10, 'arcu', 2951.810, 'cras pellentesque');
INSERT INTO unc_248557.producto_producto VALUES ('83', 21, 'fusce', 2307.060, 'vel sem sed sagittis');
INSERT INTO unc_248557.producto_producto VALUES ('84', 26, 'nulla', 1791.670, 'sapien urna');
INSERT INTO unc_248557.producto_producto VALUES ('85', 14, 'odio', 563.590, 'dictumst etiam');
INSERT INTO unc_248557.producto_producto VALUES ('86', 8, 'sapien', 1756.360, 'eu sapien');
INSERT INTO unc_248557.producto_producto VALUES ('87', 9, 'in', 2696.630, 'sollicitudin mi sit');
INSERT INTO unc_248557.producto_producto VALUES ('88', 8, 'tortor', 2571.190, 'at vulputate');
INSERT INTO unc_248557.producto_producto VALUES ('89', 22, 'ligula', 2200.070, 'libero quis orci nullam');
INSERT INTO unc_248557.producto_producto VALUES ('90', 16, 'ipsum', 1396.270, 'id nulla');
INSERT INTO unc_248557.producto_producto VALUES ('91', 25, 'vivamus', 634.020, 'vel nulla eget eros');
INSERT INTO unc_248557.producto_producto VALUES ('92', 20, 'metus', 1337.620, 'quisque arcu libero');
INSERT INTO unc_248557.producto_producto VALUES ('93', 6, 'nulla', 32.410, 'tellus in sagittis');
INSERT INTO unc_248557.producto_producto VALUES ('94', 12, 'est', 2779.740, 'est congue elementum');
INSERT INTO unc_248557.producto_producto VALUES ('95', 25, 'nulla', 2895.820, 'molestie nibh in lectus');
INSERT INTO unc_248557.producto_producto VALUES ('96', 12, 'rhoncus', 1188.300, 'nulla integer');
INSERT INTO unc_248557.producto_producto VALUES ('97', 3, 'iaculis', 2869.460, 'mattis odio');
INSERT INTO unc_248557.producto_producto VALUES ('98', 8, 'massa', 57.410, 'lorem ipsum');
INSERT INTO unc_248557.producto_producto VALUES ('99', 3, 'curabitur', 313.480, 'elementum nullam varius nulla');
INSERT INTO unc_248557.producto_producto VALUES ('100', 19, 'id', 90.550, 'ante vivamus');
INSERT INTO unc_248557.producto_producto VALUES ('101', 1, 'duis', 2513.090, 'integer ac leo pellentesque');
INSERT INTO unc_248557.producto_producto VALUES ('102', 27, 'a', 1527.580, 'leo pellentesque ultrices');
INSERT INTO unc_248557.producto_producto VALUES ('103', 29, 'convallis', 1069.200, 'orci luctus et');
INSERT INTO unc_248557.producto_producto VALUES ('104', 17, 'nulla', 2456.110, 'rutrum at lorem integer');
INSERT INTO unc_248557.producto_producto VALUES ('105', 28, 'etiam', 714.210, 'sapien varius');
INSERT INTO unc_248557.producto_producto VALUES ('106', 26, 'adipiscing', 2179.280, 'dictumst morbi');
INSERT INTO unc_248557.producto_producto VALUES ('107', 8, 'amet', 948.210, 'nulla dapibus dolor');
INSERT INTO unc_248557.producto_producto VALUES ('108', 27, 'porttitor', 287.660, 'pede libero quis orci');
INSERT INTO unc_248557.producto_producto VALUES ('109', 26, 'augue', 2601.740, 'aenean lectus pellentesque eget');
INSERT INTO unc_248557.producto_producto VALUES ('110', 14, 'vestibulum', 17.400, 'potenti cras in');
INSERT INTO unc_248557.producto_producto VALUES ('111', 7, 'nulla', 1199.710, 'enim sit amet nunc');
INSERT INTO unc_248557.producto_producto VALUES ('112', 11, 'eros', 2818.070, 'lobortis ligula sit amet');
INSERT INTO unc_248557.producto_producto VALUES ('113', 27, 'quam', 1762.290, 'morbi porttitor');
INSERT INTO unc_248557.producto_producto VALUES ('114', 8, 'justo', 707.700, 'integer ac');
INSERT INTO unc_248557.producto_producto VALUES ('115', 4, 'in', 2510.480, 'cursus id');
INSERT INTO unc_248557.producto_producto VALUES ('116', 22, 'nec', 452.480, 'nullam orci pede venenatis');
INSERT INTO unc_248557.producto_producto VALUES ('117', 24, 'dui', 483.910, 'nullam orci');
INSERT INTO unc_248557.producto_producto VALUES ('118', 5, 'cras', 1044.840, 'primis in');
INSERT INTO unc_248557.producto_producto VALUES ('119', 18, 'tempus', 803.240, 'nibh ligula nec');
INSERT INTO unc_248557.producto_producto VALUES ('120', 29, 'facilisi', 724.970, 'amet eleifend pede');
INSERT INTO unc_248557.producto_producto VALUES ('121', 16, 'phasellus', 1953.720, 'ultrices aliquet maecenas');
INSERT INTO unc_248557.producto_producto VALUES ('122', 25, 'ligula', 1130.880, 'cursus vestibulum proin eu');
INSERT INTO unc_248557.producto_producto VALUES ('123', 4, 'quam', 1645.030, 'vulputate vitae nisl');
INSERT INTO unc_248557.producto_producto VALUES ('124', 20, 'non', 1313.740, 'risus semper');
INSERT INTO unc_248557.producto_producto VALUES ('125', 9, 'convallis', 2345.940, 'consequat varius integer');
INSERT INTO unc_248557.producto_producto VALUES ('126', 17, 'duis', 2004.440, 'aliquet at');
INSERT INTO unc_248557.producto_producto VALUES ('127', 19, 'eget', 198.180, 'in est');
INSERT INTO unc_248557.producto_producto VALUES ('128', 12, 'dapibus', 2682.600, 'lacinia eget');
INSERT INTO unc_248557.producto_producto VALUES ('129', 11, 'nonummy', 966.920, 'curabitur gravida');
INSERT INTO unc_248557.producto_producto VALUES ('130', 2, 'vel', 343.910, 'consectetuer eget rutrum at');
INSERT INTO unc_248557.producto_producto VALUES ('131', 10, 'diam', 1491.940, 'augue aliquam erat');
INSERT INTO unc_248557.producto_producto VALUES ('132', 29, 'pede', 499.330, 'amet eros suspendisse');
INSERT INTO unc_248557.producto_producto VALUES ('133', 25, 'vulputate', 1114.670, 'aliquam quis');
INSERT INTO unc_248557.producto_producto VALUES ('134', 11, 'maecenas', 1363.750, 'adipiscing molestie');
INSERT INTO unc_248557.producto_producto VALUES ('135', 25, 'duis', 1254.440, 'bibendum imperdiet');
INSERT INTO unc_248557.producto_producto VALUES ('136', 20, 'in', 1435.330, 'orci nullam molestie');
INSERT INTO unc_248557.producto_producto VALUES ('137', 2, 'maecenas', 372.820, 'posuere felis sed');
INSERT INTO unc_248557.producto_producto VALUES ('138', 22, 'ipsum', 813.930, 'viverra dapibus');
INSERT INTO unc_248557.producto_producto VALUES ('139', 29, 'ultrices', 2910.010, 'porttitor id consequat');
INSERT INTO unc_248557.producto_producto VALUES ('140', 18, 'felis', 513.320, 'pellentesque ultrices');
INSERT INTO unc_248557.producto_producto VALUES ('141', 2, 'nunc', 1115.360, 'et tempus');
INSERT INTO unc_248557.producto_producto VALUES ('142', 14, 'ac', 2747.150, 'quam pede lobortis ligula');
INSERT INTO unc_248557.producto_producto VALUES ('143', 7, 'convallis', 2569.670, 'ante vestibulum ante');
INSERT INTO unc_248557.producto_producto VALUES ('144', 1, 'natoque', 2715.270, 'dapibus dolor vel est');
INSERT INTO unc_248557.producto_producto VALUES ('145', 18, 'vestibulum', 2502.490, 'id nisl venenatis');
INSERT INTO unc_248557.producto_producto VALUES ('146', 3, 'mattis', 151.550, 'non pretium');
INSERT INTO unc_248557.producto_producto VALUES ('147', 20, 'dapibus', 1710.750, 'tortor quis');
INSERT INTO unc_248557.producto_producto VALUES ('148', 24, 'nulla', 399.980, 'nulla sed');
INSERT INTO unc_248557.producto_producto VALUES ('149', 21, 'laoreet', 954.910, 'quam sapien varius');
INSERT INTO unc_248557.producto_producto VALUES ('150', 30, 'tempus', 1873.250, 'dolor morbi');
INSERT INTO unc_248557.producto_producto VALUES ('151', 26, 'risus', 2283.530, 'id luctus nec molestie');
INSERT INTO unc_248557.producto_producto VALUES ('152', 25, 'enim', 769.560, 'ipsum aliquam non mauris');
INSERT INTO unc_248557.producto_producto VALUES ('153', 6, 'amet', 1050.190, 'interdum venenatis');
INSERT INTO unc_248557.producto_producto VALUES ('154', 23, 'ut', 843.510, 'magna vulputate luctus cum');
INSERT INTO unc_248557.producto_producto VALUES ('155', 6, 'ut', 2245.760, 'id nisl venenatis');
INSERT INTO unc_248557.producto_producto VALUES ('156', 19, 'volutpat', 988.300, 'sem mauris');
INSERT INTO unc_248557.producto_producto VALUES ('157', 15, 'sed', 942.170, 'ante vel ipsum');
INSERT INTO unc_248557.producto_producto VALUES ('158', 13, 'iaculis', 1379.750, 'quam turpis');
INSERT INTO unc_248557.producto_producto VALUES ('159', 8, 'nulla', 104.490, 'erat volutpat in congue');
INSERT INTO unc_248557.producto_producto VALUES ('160', 3, 'sem', 1464.940, 'consequat in consequat');
INSERT INTO unc_248557.producto_producto VALUES ('161', 16, 'nascetur', 33.170, 'accumsan tellus');
INSERT INTO unc_248557.producto_producto VALUES ('162', 20, 'nulla', 616.890, 'quam sollicitudin vitae consectetuer');
INSERT INTO unc_248557.producto_producto VALUES ('163', 29, 'orci', 2181.180, 'vestibulum sit amet cursus');
INSERT INTO unc_248557.producto_producto VALUES ('164', 24, 'at', 775.800, 'dui maecenas tristique');
INSERT INTO unc_248557.producto_producto VALUES ('165', 3, 'lacinia', 2122.870, 'eu est congue elementum');
INSERT INTO unc_248557.producto_producto VALUES ('166', 9, 'porttitor', 1606.490, 'vulputate elementum');
INSERT INTO unc_248557.producto_producto VALUES ('167', 4, 'dui', 1260.900, 'sed vel');
INSERT INTO unc_248557.producto_producto VALUES ('168', 21, 'nunc', 56.190, 'felis fusce posuere felis');
INSERT INTO unc_248557.producto_producto VALUES ('169', 28, 'amet', 1300.770, 'nulla tellus in sagittis');
INSERT INTO unc_248557.producto_producto VALUES ('170', 3, 'quis', 939.990, 'sem sed');
INSERT INTO unc_248557.producto_producto VALUES ('171', 6, 'amet', 1333.940, 'suscipit ligula in lacus');
INSERT INTO unc_248557.producto_producto VALUES ('172', 16, 'habitasse', 1130.310, 'parturient montes');
INSERT INTO unc_248557.producto_producto VALUES ('173', 30, 'posuere', 871.260, 'potenti in eleifend quam');
INSERT INTO unc_248557.producto_producto VALUES ('174', 28, 'quam', 1213.880, 'nec nisi');
INSERT INTO unc_248557.producto_producto VALUES ('175', 8, 'vivamus', 295.060, 'suscipit a');
INSERT INTO unc_248557.producto_producto VALUES ('176', 24, 'vestibulum', 1850.150, 'rhoncus sed vestibulum');
INSERT INTO unc_248557.producto_producto VALUES ('177', 30, 'turpis', 2156.650, 'auctor sed');
INSERT INTO unc_248557.producto_producto VALUES ('178', 22, 'in', 2623.630, 'vel augue');
INSERT INTO unc_248557.producto_producto VALUES ('179', 28, 'eleifend', 356.250, 'aliquet pulvinar');
INSERT INTO unc_248557.producto_producto VALUES ('180', 21, 'nulla', 2974.270, 'iaculis diam');
INSERT INTO unc_248557.producto_producto VALUES ('181', 17, 'in', 1399.630, 'ut blandit');
INSERT INTO unc_248557.producto_producto VALUES ('182', 21, 'lacus', 2943.260, 'fusce consequat');
INSERT INTO unc_248557.producto_producto VALUES ('183', 6, 'rhoncus', 1697.340, 'nunc purus phasellus in');
INSERT INTO unc_248557.producto_producto VALUES ('184', 15, 'semper', 49.360, 'hendrerit at');
INSERT INTO unc_248557.producto_producto VALUES ('185', 15, 'auctor', 2449.940, 'rhoncus aliquet pulvinar');
INSERT INTO unc_248557.producto_producto VALUES ('186', 9, 'congue', 2548.180, 'turpis a');
INSERT INTO unc_248557.producto_producto VALUES ('187', 20, 'cursus', 502.100, 'sit amet erat');
INSERT INTO unc_248557.producto_producto VALUES ('188', 29, 'dapibus', 1528.050, 'eget tincidunt');
INSERT INTO unc_248557.producto_producto VALUES ('189', 2, 'nisl', 314.690, 'sit amet cursus id');
INSERT INTO unc_248557.producto_producto VALUES ('190', 28, 'sed', 687.560, 'odio consequat varius integer');
INSERT INTO unc_248557.producto_producto VALUES ('191', 12, 'curae', 173.190, 'nibh quisque');
INSERT INTO unc_248557.producto_producto VALUES ('192', 6, 'mauris', 1746.130, 'sagittis dui vel');
INSERT INTO unc_248557.producto_producto VALUES ('193', 17, 'nulla', 1704.420, 'interdum mauris ullamcorper purus');
INSERT INTO unc_248557.producto_producto VALUES ('194', 26, 'pede', 1927.860, 'sit amet');
INSERT INTO unc_248557.producto_producto VALUES ('195', 16, 'luctus', 209.980, 'habitasse platea');
INSERT INTO unc_248557.producto_producto VALUES ('196', 27, 'in', 2524.330, 'ipsum integer');
INSERT INTO unc_248557.producto_producto VALUES ('197', 7, 'amet', 2519.470, 'erat quisque erat eros');
INSERT INTO unc_248557.producto_producto VALUES ('198', 9, 'at', 1064.750, 'ultrices erat tortor sollicitudin');
INSERT INTO unc_248557.producto_producto VALUES ('199', 8, 'accumsan', 110.970, 'sapien varius');
INSERT INTO unc_248557.producto_producto VALUES ('200', 25, 'in', 183.850, 'velit eu est');


--
-- Data for Name: productoxorden; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--



--
-- Data for Name: stock; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--



--
-- Data for Name: tipo; Type: TABLE DATA; Schema: unc_esq_producto; Owner: unc_248557
--

INSERT INTO unc_248557.producto_tipo VALUES (1, NULL, 'vehicula');
INSERT INTO unc_248557.producto_tipo VALUES (2, NULL, 'sem');
INSERT INTO unc_248557.producto_tipo VALUES (3, 2, 'morbi');
INSERT INTO unc_248557.producto_tipo VALUES (4, 3, 'vestibulum');
INSERT INTO unc_248557.producto_tipo VALUES (5, NULL, 'curae');
INSERT INTO unc_248557.producto_tipo VALUES (6, 2, 'proin');
INSERT INTO unc_248557.producto_tipo VALUES (7, 1, 'natoque');
INSERT INTO unc_248557.producto_tipo VALUES (8, 2, 'curae');
INSERT INTO unc_248557.producto_tipo VALUES (9, 8, 'pede');
INSERT INTO unc_248557.producto_tipo VALUES (10, 1, 'vestibulum');
INSERT INTO unc_248557.producto_tipo VALUES (11, 5, 'nibh');
INSERT INTO unc_248557.producto_tipo VALUES (12, 9, 'a');
INSERT INTO unc_248557.producto_tipo VALUES (13, 1, 'tortor');
INSERT INTO unc_248557.producto_tipo VALUES (14, 12, 'augue');
INSERT INTO unc_248557.producto_tipo VALUES (15, 3, 'amet');
INSERT INTO unc_248557.producto_tipo VALUES (16, 6, 'pede');
INSERT INTO unc_248557.producto_tipo VALUES (17, 5, 'dui');
INSERT INTO unc_248557.producto_tipo VALUES (18, 15, 'adipiscing');
INSERT INTO unc_248557.producto_tipo VALUES (19, 7, 'molestie');
INSERT INTO unc_248557.producto_tipo VALUES (20, 2, 'luctus');
INSERT INTO unc_248557.producto_tipo VALUES (21, 3, 'congue');
INSERT INTO unc_248557.producto_tipo VALUES (22, 1, 'convallis');
INSERT INTO unc_248557.producto_tipo VALUES (23, 3, 'erat');
INSERT INTO unc_248557.producto_tipo VALUES (24, 9, 'hac');
INSERT INTO unc_248557.producto_tipo VALUES (25, 15, 'convallis');
INSERT INTO unc_248557.producto_tipo VALUES (26, 8, 'dis');
INSERT INTO unc_248557.producto_tipo VALUES (27, 12, 'aliquam');
INSERT INTO unc_248557.producto_tipo VALUES (28, 12, 'amet');
INSERT INTO unc_248557.producto_tipo VALUES (29, 10, 'curae');
INSERT INTO unc_248557.producto_tipo VALUES (30, 15, 'sit');


--
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_cliente
    ADD CONSTRAINT producto_cliente_pk PRIMARY KEY (id_cliente);


--
-- Name: orden orden_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_orden
    ADD CONSTRAINT producto_orden_pk PRIMARY KEY (nro_orden);


--
-- Name: producto producto_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_producto
    ADD CONSTRAINT producto_producto_pk PRIMARY KEY (id_producto);


--
-- Name: productoxorden productoxorden_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_productoxorden
    ADD CONSTRAINT producto_productoxorden_pk PRIMARY KEY (id_producto, nro_orden);


--
-- Name: stock stock_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_stock
    ADD CONSTRAINT producto_stock_pk PRIMARY KEY (fecha, id_producto);


--
-- Name: tipo tipo_pk; Type: CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_tipo
    ADD CONSTRAINT producto_tipo_pk PRIMARY KEY (id_tipo);


--
-- Name: orden ordenes_cliente; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_orden
    ADD CONSTRAINT producto_ordenes_cliente FOREIGN KEY (id_cliente) REFERENCES unc_248557.producto_cliente(id_cliente);


--
-- Name: producto producto_tipos; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_producto
    ADD CONSTRAINT producto_producto_tipos FOREIGN KEY (id_tipo) REFERENCES unc_248557.producto_tipo(id_tipo);


--
-- Name: productoxorden productoxorden_orden; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_productoxorden
    ADD CONSTRAINT producto_productoxorden_orden FOREIGN KEY (nro_orden) REFERENCES unc_248557.producto_orden(nro_orden);


--
-- Name: productoxorden productoxorden_producto; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_productoxorden
    ADD CONSTRAINT producto_productoxorden_producto FOREIGN KEY (id_producto) REFERENCES unc_248557.producto_producto(id_producto);


--
-- Name: stock stock_producto; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_stock
    ADD CONSTRAINT producto_stock_producto FOREIGN KEY (id_producto) REFERENCES unc_248557.producto_producto(id_producto);


--
-- Name: tipo tipos_tipos; Type: FK CONSTRAINT; Schema: unc_esq_producto; Owner: unc_248557
--

ALTER TABLE ONLY unc_248557.producto_tipo
    ADD CONSTRAINT producto_tipos_tipos FOREIGN KEY (id_tipo_padre) REFERENCES unc_248557.producto_tipo(id_tipo);


--
-- Name: SCHEMA unc_esq_producto; Type: ACL; Schema: -; Owner: unc_248557
--

GRANT ALL ON SCHEMA unc_esq_producto TO unc_staff;
GRANT USAGE ON SCHEMA unc_esq_producto TO PUBLIC;


--
-- Name: TABLE producto; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_producto TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_producto TO PUBLIC;


--
-- Name: TABLE productoxorden; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_productoxorden TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_productoxorden TO PUBLIC;


--
-- Name: TABLE cliente; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_cliente TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_cliente TO PUBLIC;


--
-- Name: TABLE orden; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_orden TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_orden TO PUBLIC;


--
-- Name: TABLE stock; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_stock TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_stock TO PUBLIC;


--
-- Name: TABLE tipo; Type: ACL; Schema: unc_esq_producto; Owner: unc_248557
--

GRANT ALL ON TABLE unc_248557.producto_tipo TO unc_staff;
GRANT SELECT,REFERENCES ON TABLE unc_248557.producto_tipo TO PUBLIC;


--
-- unc_248557QL database dump complete
--

