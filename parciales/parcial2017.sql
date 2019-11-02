

--EJERCICIO 4
--########################################################################


CREATE TABLE parcial_2017_turno (
	id_turno int NOT NULL,
	CONSTRAINT PK_parcial_2017_turno PRIMARY KEY(id_turno)
);

CREATE TABLE parcial_2017_comprobante (
	id_comprobante int NOT NULL,
	id_turno int NULL,
	CONSTRAINT PK_parcial_2017_comprobante PRIMARY KEY(id_comprobante)
);

SELECT *
FROM parcial_2017_turno
WHERE id_turno NOT IN (SELECT id_turno FROM parcial_2017_comprobante);

SELECT *
FROM parcial_2017_turno t
WHERE NOT EXISTS (SELECT 1 FROM parcial_2017_comprobante WHERE id_turno=t.id_turno);

INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (1,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (2,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (3,NULL);
INSERT INTO parcial_2017_comprobante(id_comprobante,id_turno) VALUES (4,NULL);

INSERT INTO parcial_2017_turno(id_turno) VALUES (1);
INSERT INTO parcial_2017_turno(id_turno) VALUES (2);
INSERT INTO parcial_2017_turno(id_turno) VALUES (3);
INSERT INTO parcial_2017_turno(id_turno) VALUES (4);

