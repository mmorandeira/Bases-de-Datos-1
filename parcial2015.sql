

--EJERCICIO 1
--########################################################################


CREATE TABLE PARCIAL_2015_EMPL (
	nro_emp int NOT NULL,
	"Of" int NOT NULL,
	nombre varchar(20) NOT NULL,
	contacto varchar(20) NULL,
	especialidad varchar(20) NOT NULL,
	CONSTRAINT PK_EMPL PRIMARY KEY(nro_emp,"Of")
);

CREATE TABLE PARCIAL_2015_PROYECTO (
	CodP int NOT NULL,
	descr varchar(20) NOT NULL,
	nro_dir int NULL,
	"Of" int NULL,
	CONSTRAINT PK_PARCIAL_2015_PROYECTO PRIMARY KEY(CodP)
);

CREATE TABLE PARCIAL_2015_TRABAJA (
	CodP int NOT NULL,
	nro_emp int NOT NULL,
	"Of" int NOT NULL,
	HorasSem numeric(5,2) NULL,
	CONSTRAINT PK_PARCIAL_2015_TRABAJA PRIMARY KEY(CodP,nro_emp,"Of")
);

ALTER TABLE PARCIAL_2015_PROYECTO
	ADD CONSTRAINT FK_PARCIAL_2015_PROYECTO_EMPL FOREIGN KEY(nro_dir,"Of")
	REFERENCES PARCIAL_2015_EMPL(nro_emp,"Of")
		ON UPDATE CASCADE
		ON DELETE SET NULL
;

ALTER TABLE PARCIAL_2015_TRABAJA
	ADD CONSTRAINT FK_PARCIAL_2015_TRABAJA_PROYECTO FOREIGN KEY(CodP)
	REFERENCES PARCIAL_2015_PROYECTO(CodP)
		ON UPDATE CASCADE
		ON DELETE CASCADE
;

ALTER TABLE PARCIAL_2015_TRABAJA
	ADD CONSTRAINT FK_PARCIAL_2015_TRABAJA_EMPL FOREIGN KEY(nro_emp,"Of")
	REFERENCES PARCIAL_2015_EMPL(nro_emp,"Of")
		ON UPDATE RESTRICT 
		ON DELETE RESTRICT
;

INSERT INTO parcial_2015_empl(nro_emp,"Of",nombre,contacto,especialidad) VALUES (101,1,'cio','null','null');
INSERT INTO parcial_2015_empl(nro_emp,"Of",nombre,contacto,especialidad) VALUES (102,2,'mati','null','null');
INSERT INTO parcial_2015_empl(nro_emp,"Of",nombre,contacto,especialidad) VALUES (103,1,'dana','null','null');
INSERT INTO parcial_2015_empl(nro_emp,"Of",nombre,contacto,especialidad) VALUES (105,1,'juan','null','null');

INSERT INTO parcial_2015_proyecto(CodP,descr,nro_dir,"Of") VALUES (10,'BD',101,1);

INSERT INTO parcial_2015_trabaja(CodP,nro_emp,"Of",HorasSem) VALUES (10,103,1,30);
INSERT INTO parcial_2015_trabaja(CodP,nro_emp,"Of",HorasSem) VALUES (10,105,1,10);



--EJERCICIO 4
--########################################################################

-- a).1
ALTER TABLE parcial_2015_trabaja ADD CONSTRAINT ck_no_mas_10
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM parcial_2015_trabaja
		GROUP BY codp
		HAVING count(*) > 10
		
	)
);

-- a).2
CREATE ASSERTION mas_30_horas
CHECK NOT EXISTS(
	SELECT 1
	FROM
	parcial_2015_empl e JOIN parcial_2015_trabaja t ON (e.nro_emp = t.nro_emp) AND (e."Of" = t."Of")
	WHERE e.especialidad = 'oficinista' AND t.horassem > 30
);

CREATE OR REPLACE FUNCTION FN_ingenieros_no_trabajan() RETURNS TRIGGER AS
$body$
DECLARE 
	_horas_previas NUMERIC(5,2);
BEGIN
	IF EXISTS (	SELECT 1
				FROM parcial_2015_empl
				WHERE nro_emp = NEW.nro_emp AND "Of" = NEW."Of" AND especialidad = 'ingeniero')) THEN
		SELECT INTO COALESCE(sum(horassen),0) INTO _horas_previas
		FROM parcial_2015_trabaja
		WHERE nro_emp = NEW.nro_emp AND "Of" = NEW."Of"
		IF(_horas_previas + NEW.horassem > 45) THEN
			RAISE EXCEPTION 'los ingenieros no pueden trabajar mas de 45 horas a la semana';
	END IF;
	RETURN NEW;
END;
$body$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_ingenieros_no_trabajan
BEFORE INSERT ON parcial_2015_empl
FOR EACH ROW
EXECUTE PROCEDURE FN_ingenieros_no_trabajan();

 