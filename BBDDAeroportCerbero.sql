-----------------------------------------
-- BBDD AEROPORT
-- BBDDAeroport.sql
-- Inform�tica Avan�ada
-- 2016-2017
-- Grau Gesti� Aeron�utica
-----------------------------------------
--
-- Aquest script:
--
--        1) Crea les taules de la base de dades Aeroport,
--        2) crea les constraints, i
--        3) hi afegeix els registres. 
--
-- Si ja s'ha executat previament, l'script esborra les taules de la base de 
-- dades i les torna a editar. 
-- De tal manera, cal IGNORAR els missatges d'error que d�na 
-- la primera vegada que s'executa. 
--

DROP TABLE AEROPORT CASCADE CONSTRAINTS; 
DROP TABLE BITLLET CASCADE CONSTRAINTS; 
DROP TABLE MALETA CASCADE CONSTRAINTS; 
DROP TABLE PERSONA CASCADE CONSTRAINTS; 
DROP TABLE PORTA_EMBARCAMENT CASCADE CONSTRAINTS; 
DROP TABLE RESERVA CASCADE CONSTRAINTS; 
DROP TABLE SEIENT CASCADE CONSTRAINTS; 
DROP TABLE VOL CASCADE CONSTRAINTS; 

--COMMIT;

set termout on
prompt 
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt % 1. Creant les taules:   
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt 
set termout off

-- TAULA PERSONA
--DROP TABLE PERSONA CASCADE CONSTRAINTS; 

CREATE TABLE PERSONA ( 
  NIF              VARCHAR2 (11) NOT NULL,
  NOM              VARCHAR2 (50), 
  DATA_NAIXEMENT   DATE,
  ADRE�A           VARCHAR2 (30),
  CODI_POSTAL      NUMBER (5),
  POBLACIO         VARCHAR2 (25),
  PAIS             VARCHAR2 (15),
  TELEFON          NUMBER (9),
  MAIL             VARCHAR2 (40),
  OBSERVACIONS     VARCHAR2 (25),
  CONSTRAINT PASSATGER_PK
  PRIMARY KEY (NIF) );

-- TAULA RESERVA
--DROP TABLE RESERVA CASCADE CONSTRAINTS; 

CREATE TABLE RESERVA ( 
  LOCALITZADOR       VARCHAR2 (6) NOT NULL,
  NIF_CLIENT         VARCHAR2 (11),
  DATA               DATE,
  PREU               NUMBER,
  IVA                NUMBER,
  MODE_PAGAMENT      VARCHAR2 (16),
  CONSTRAINT RESERVA_PK
  PRIMARY KEY (LOCALITZADOR) ) ;

-- TAULA AEROPORT
--DROP TABLE AEROPORT CASCADE CONSTRAINTS; 

CREATE TABLE AEROPORT ( 
  CODI_AEROPORT      VARCHAR2 (5) NOT NULL,
  NOM                VARCHAR2 (50),
  CIUTAT             VARCHAR2 (25),
  PAIS		     VARCHAR2 (25),
  CONSTRAINT AEROPORT_PK
  PRIMARY KEY (CODI_AEROPORT) ) ; 
  
-- TAULA PORTA_EMBARCAMENT
--DROP TABLE PORTA_EMBARCAMENT CASCADE CONSTRAINTS; 

CREATE TABLE PORTA_EMBARCAMENT ( 
  CODI_AEROPORT      VARCHAR2 (5) NOT NULL,
  TERMINAL           NUMBER (3) NOT NULL,
  AREA               NUMBER (3) NOT NULL,
  PORTA              NUMBER (3) NOT NULL,
  CONSTRAINT PORTA_EMBARCAMENT_PK
  PRIMARY KEY (CODI_AEROPORT,TERMINAL,AREA,PORTA) ) ; 

-- TAULA VOL 
--DROP TABLE VOL CASCADE CONSTRAINTS; 

CREATE TABLE VOL ( 
  CODI_VOL         VARCHAR2 (10) NOT NULL, 
  DATA             DATE NOT NULL, 
  COMPANYIA        VARCHAR2 (45), 
  TIPUS_AVIO       VARCHAR2 (20), 
  DESTINACIO       VARCHAR2 (5),
  ORIGEN           VARCHAR2 (5),
  TERMINAL         NUMBER (3),
  AREA             NUMBER (3),
  PORTA            NUMBER (3),
  CONSTRAINT VOL_PK
  PRIMARY KEY (CODI_VOL,DATA) );

-- TAULA BITLLET
--DROP TABLE BITLLET CASCADE CONSTRAINTS; 

CREATE TABLE BITLLET ( 
  LOCALITZADOR       VARCHAR2 (6),
  NIF_PASSATGER      VARCHAR2 (11) NOT NULL,  
  CODI_VOL           VARCHAR2 (10) NOT NULL,
  DATA               DATE NOT NULL,
  FILA               NUMBER (3),
  LLETRA             VARCHAR2 (1),
  ESCALA             NUMBER (2),
  ANADA_TORNADA      VARCHAR2 (8),
  CLASSE             NUMBER (2),
  CONSTRAINT BITLLET_PK
  PRIMARY KEY (NIF_PASSATGER,CODI_VOL,DATA) ) ; 

-- TAULA SEIENT
--DROP TABLE SEIENT CASCADE CONSTRAINTS; 

CREATE TABLE SEIENT ( 
  CODI_VOL           VARCHAR2 (10) NOT NULL,
  DATA               DATE NOT NULL,
  FILA               NUMBER (3) NOT NULL,
  LLETRA             VARCHAR2 (1) NOT NULL,
  NIF_PASSATGER      VARCHAR2 (11),
  EMBARCAT           VARCHAR2 (2),
  CONSTRAINT SEIENT_PK
  PRIMARY KEY (CODI_VOL,DATA,FILA,LLETRA) ) ;  

-- TAULA MALETA
--DROP TABLE MALETA CASCADE CONSTRAINTS;

CREATE TABLE MALETA ( 
  CODI_MALETA    NUMBER (6) NOT NULL, 
  PES            NUMBER, 
  MIDES          VARCHAR2 (15),
  COLOR          VARCHAR2 (10),
  NIF_PASSATGER  VARCHAR2 (9),
  CODI_VOL       VARCHAR2 (7),
  DATA           DATE,
  CONSTRAINT MALETA_PK
  PRIMARY KEY (CODI_MALETA) ) ;

set termout on
prompt
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt % 2. Afegint les restriccions -constraints-: Claus foranes
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt 
set termout off

-- Refer�ncia RESERVA --> PERSONA
ALTER TABLE RESERVA ADD CONSTRAINT RESERVA_FK1
 FOREIGN KEY (NIF_CLIENT) 
  REFERENCES PERSONA (NIF);

-- Refer�ncia PORTA_EMBARCAMENT --> AEROPORT
ALTER TABLE PORTA_EMBARCAMENT ADD CONSTRAINT PORTA_EMBARCAMENT_FK1
 FOREIGN KEY (CODI_AEROPORT)
  REFERENCES AEROPORT(CODI_AEROPORT);
  
-- Refer�ncia VOL --> PORTA_EMBARCAMENT
ALTER TABLE VOL ADD CONSTRAINT VOL_FK1
 FOREIGN KEY (ORIGEN,TERMINAL,AREA,PORTA)
  REFERENCES PORTA_EMBARCAMENT(CODI_AEROPORT,TERMINAL,AREA,PORTA);

-- Refer�ncia VOL --> AEROPORT
ALTER TABLE VOL ADD CONSTRAINT VOL_FK2
 FOREIGN KEY (DESTINACIO)
  REFERENCES AEROPORT(CODI_AEROPORT);

-- Refer�ncia SEIENT --> VOL
ALTER TABLE SEIENT ADD CONSTRAINT SEIENT_FK1
 FOREIGN KEY (CODI_VOL,DATA)
  REFERENCES VOL(CODI_VOL,DATA);
  
-- Refer�ncia SEIENT --> BITLLET
ALTER TABLE SEIENT ADD CONSTRAINT SEIENT_FK2
 FOREIGN KEY (NIF_PASSATGER,CODI_VOL,DATA)
   REFERENCES BITLLET(NIF_PASSATGER,CODI_VOL,DATA);

-- Refer�ncia BITLLET --> PERSONA
ALTER TABLE BITLLET ADD CONSTRAINT BITLLET_FK1
 FOREIGN KEY (NIF_PASSATGER)
  REFERENCES PERSONA(NIF);

-- Refer�ncia BITLLET --> RESERVA
ALTER TABLE BITLLET ADD CONSTRAINT BITLLET_FK2
 FOREIGN KEY (LOCALITZADOR)
  REFERENCES RESERVA(LOCALITZADOR);
  
-- Refer�ncia BITLLET --> VOL
ALTER TABLE BITLLET ADD CONSTRAINT BITLLET_FK3
 FOREIGN KEY (CODI_VOL,DATA)
  REFERENCES VOL(CODI_VOL,DATA);

-- Refer�ncia BITLLET --> SEIENT
ALTER TABLE BITLLET ADD CONSTRAINT BITLLET_FK4
 FOREIGN KEY (CODI_VOL,DATA,FILA,LLETRA)
   REFERENCES SEIENT(CODI_VOL,DATA,FILA,LLETRA);
 
-- Refer�ncia MALETA --> BITLLET
ALTER TABLE MALETA ADD CONSTRAINT MALETA_FK1
 FOREIGN KEY (NIF_PASSATGER,CODI_VOL,DATA)
  REFERENCES BITLLET(NIF_PASSATGER,CODI_VOL,DATA);

COMMIT;

set termout on
prompt
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt % 3. Afegint Registres a les Taules
prompt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt 
set termout off

-- TAULA CLIENT
@Taules\TaulaPersona.sql;
set termout on
prompt Taula Persona Creada
set termout off

-- TAULA RESERVA
@Taules\TaulaReserva2.sql;
set termout on
prompt Taula Reserva Creada
set termout off

-- TAULA AEROPORT
@Taules\TaulaAeroport.sql;
set termout on
prompt Taula Aeroport Creada
set termout off

-- TAULA PORTA_EMBARCAMENT
@Taules\TaulaPorta_embarcament.sql;
set termout on
prompt Taula Porta_Embarcament Creada
set termout off

-- TAULA VOL
@Taules\TaulaVol.sql;
set termout on
prompt Taula Vol Creada
set termout off

-- TAULA Seient
@Taules\TaulaSeient.sql;
set termout on
prompt Taula Seient Creada
set termout off

-- TAULA BITLLET
@Taules\TaulaBitllet.sql;
set termout on
prompt Taula Bitllet Creada
set termout off

-- UPDATE TAULA SEIENT
@Taules\UpdateTaulaSeient.sql;
set termout on
prompt Taula Seient Actualitzada
set termout off

-- TAULA MALETA
@Taules\TaulaMaleta.sql;
set termout on
prompt Taula Maleta Creada
set termout off

--GRANT SELECT ON PERSONA to CARONTE_SELECT;
--GRANT SELECT ON RESERVA to CARONTE_SELECT;
--GRANT SELECT ON AEROPORT to CARONTE_SELECT;
--GRANT SELECT ON PORTA_EMBARCAMENT to CARONTE_SELECT;
--GRANT SELECT ON VOL to CARONTE_SELECT;
--GRANT SELECT ON SEIENT to CARONTE_SELECT;
--GRANT SELECT ON BITLLET to CARONTE_SELECT;
--GRANT SELECT ON MALETA to CARONTE_SELECT;

COMMIT;