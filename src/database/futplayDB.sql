USE MASTER;

GO

 IF EXISTS(SELECT name FROM sys.databases
   WHERE name = 'FUTPLAY_DB')
   DROP DATABASE FUTPLAY_DB
GO

CREATE DATABASE FUTPLAY_DB;

GO

USE FUTPLAY_DB;

GO

SET DATEFORMAT DMY;

GO

CREATE TABLE PROVINCIA ( 
provinciaID INT IDENTITY(1,1)  NOT NULL,
nombre VARCHAR (60) NOT NULL,
CONSTRAINT PK_PROVINCIA_ID PRIMARY KEY (provinciaID)
)

GO

CREATE TABLE CANTON (
cantonID INT IDENTITY(1,1)  NOT NULL,
provinciaID INT  NOT NULL,
nombre VARCHAR (60) NOT NULL,
CONSTRAINT PK_CANTON_ID PRIMARY KEY (cantonID),
CONSTRAINT FK_PROVINCIA_ID  FOREIGN KEY (provinciaID) REFERENCES PROVINCIA (provinciaID)
)

GO

CREATE TABLE DISTRITO (
distritoID INT IDENTITY(1,1)  NOT NULL,
cantonID INT  NOT NULL,
nombre VARCHAR (60) NOT NULL,
CONSTRAINT PK_DISTRITO_ID PRIMARY KEY (distritoID),
CONSTRAINT FK_CANTON_ID  FOREIGN KEY (cantonID) REFERENCES CANTON (cantonID)
)

GO
CREATE TABLE ROLES (
roleID INT IDENTITY(1,1)  NOT NULL,
nombre VARCHAR (60) NOT NULL,
CONSTRAINT PK_ROLE_ID PRIMARY KEY (roleID)
)
GO

CREATE TABLE USUARIOS (
usuarioID INT IDENTITY(1,1)  NOT NULL,
roleID INT  NOT NULL,
provinciaID INT  NOT NULL,
cantonID INT  NOT NULL,
distritoID INT  NOT NULL,
foto VARCHAR (60) NOT NULL,
nombre VARCHAR (60) NOT NULL,
apellido1 VARCHAR (60) NOT NULL,
apellido2 VARCHAR (60) NOT NULL,
fechaNac DATE,
telefono VARCHAR (60) NOT NULL,
direccion VARCHAR (60),
correo VARCHAR (60) NOT NULL,
contrasena VARCHAR (60) NOT NULL,
intentos INTEGER,
CONSTRAINT PK_USUARIO_ID PRIMARY KEY (usuarioID),
CONSTRAINT FK_USUARIO_ROLE_ID  FOREIGN KEY (roleID) REFERENCES ROLES (roleID),
CONSTRAINT FK_USUARIO_PROVINCIA_ID  FOREIGN KEY (provinciaID) REFERENCES PROVINCIA (provinciaID),
CONSTRAINT FK_USUARIO_CANTON_ID  FOREIGN KEY (cantonID) REFERENCES CANTON (cantonID),
CONSTRAINT FK_USUARIO_DISTRITO_ID  FOREIGN KEY (distritoID) REFERENCES DISTRITO (distritoID)
)
GO
CREATE TABLE CLUBES (
clubID VARCHAR(40) NOT NULL,
usuarioID INT NOT NULL,
provinciaID INT  NOT NULL,
cantonID INT  NOT NULL,
distritoID INT  NOT NULL,
foto VARCHAR (60) NOT NULL,
nombre VARCHAR (60) NOT NULL,
abreviacion VARCHAR (20),
direccion TEXT ,
CONSTRAINT PK_CLUB_ID PRIMARY KEY (clubID),
CONSTRAINT FK_USUARIO_CLUB_ID  FOREIGN KEY (usuarioID) REFERENCES USUARIOS (usuarioID),
CONSTRAINT FK_USUARIO_CLUB_PROVINCIA_ID  FOREIGN KEY (provinciaID) REFERENCES PROVINCIA (provinciaID),
CONSTRAINT FK_USUARIO_CLUB_CANTON_ID  FOREIGN KEY (cantonID) REFERENCES CANTON (cantonID),
CONSTRAINT FK_USUARIO_CLUB_DISTRITO_ID  FOREIGN KEY (distritoID) REFERENCES DISTRITO (distritoID)

)

GO

CREATE TABLE CANCHAS (
canchaID INT IDENTITY(1,1)  NOT NULL,
provinciaID INT  NOT NULL,
cantonID INT  NOT NULL,
distritoID INT  NOT NULL,
codCancha VARCHAR (40) NOT NULL,
precioHora DOUBLE PRECISION NOT NULL,
direccion TEXT ,
CONSTRAINT PK_CANCHA_ID PRIMARY KEY (canchaID),
CONSTRAINT FK_CANCHA_PROVINCIA_ID  FOREIGN KEY (provinciaID) REFERENCES PROVINCIA (provinciaID),
CONSTRAINT FK_CANCHA_CANTON_ID  FOREIGN KEY (cantonID) REFERENCES CANTON (cantonID),
CONSTRAINT FK_CANCHA_DISTRITO_ID  FOREIGN KEY (distritoID) REFERENCES DISTRITO (distritoID)

)
GO
CREATE TABLE POSICIONES (
posicionID INT IDENTITY(1,1)  NOT NULL,
nombre VARCHAR (40) NOT NULL,
CONSTRAINT PK_POSICION_ID PRIMARY KEY (posicionID)
)
GO
CREATE TABLE SOLICITUDES_CLUBES(
solicitudID INT IDENTITY(1,1) NOT NULL,
clubID VARCHAR(40) NOT NULL,
usuarioID INT  NOT NULL,
confirmacion BIT NOT NULL,
CONSTRAINT PK_SOLICITUD_CLUBES_ID PRIMARY KEY (solicitudID),
CONSTRAINT FK_SOLICITUD_CLUBES_ID  FOREIGN KEY (clubID) REFERENCES CLUBES (clubID),
CONSTRAINT FK_SOLICITUD_USUARIO_ID  FOREIGN KEY (usuarioID) REFERENCES USUARIOS (usuarioID)
)

GO

CREATE TABLE JUGADORES_CLUBES_POSICION(
jugadorID INT IDENTITY(1,1) NOT NULL,
clubID VARCHAR(40) NOT NULL,
usuarioID INT  NOT NULL,
posicionID INT  NOT NULL,
CONSTRAINT PK_JUGADORES_ID PRIMARY KEY (jugadorID),
CONSTRAINT FK_JUGADORES_CLUBES_ID  FOREIGN KEY (clubID) REFERENCES CLUBES (clubID),
CONSTRAINT FK_JUGADORES_CLUBES_USUARIO_ID  FOREIGN KEY (usuarioID) REFERENCES USUARIOS (usuarioID)
)

GO

CREATE TABLE RETOS(
retoID INT IDENTITY(1,1) NOT NULL,
usuarioID INT  NOT NULL,
clubID1 VARCHAR(40) NOT NULL,
clubID2 VARCHAR(40) NOT NULL,
confirmacion1 BIT  NOT NULL,
confirmacion2 BIT  NOT NULL,
CONSTRAINT PK_RETOS_ID PRIMARY KEY (retoID),
CONSTRAINT FK_RETOS_USUARIO_ID  FOREIGN KEY (usuarioID) REFERENCES USUARIOS (usuarioID),
CONSTRAINT FK_RETO_CLUBE1_ID  FOREIGN KEY (clubID1) REFERENCES CLUBES (clubID),
CONSTRAINT FK_RETO_CLUBE2_ID  FOREIGN KEY (clubID2) REFERENCES CLUBES (clubID)
)

GO

CREATE TABLE RESERVACIONES(
reservacionID INT IDENTITY(1,1) NOT NULL,
retoID INT  NOT NULL,
canchaID INT  NOT NULL,
feha DATE NOT NULL,
horaInicio TIME NOT NULL,
horaFIN TIME NOT NULL,
precioHora DOUBLE PRECISION NOT NULL,
montoTotal DOUBLE PRECISION NOT NULL,
montoAbonado DOUBLE PRECISION NOT NULL,
montoPendiente DOUBLE PRECISION NOT NULL,
estado BIT NOT NULL,
notas TEXT NOT NULL,
CONSTRAINT PK_RESERVACION_ID PRIMARY KEY (reservacionID),
CONSTRAINT FK_RESERVACION_RETO_ID  FOREIGN KEY (retoID) REFERENCES RETOS (retoID),
CONSTRAINT FK_RESERVACION_CANCHA_ID  FOREIGN KEY (canchaID) REFERENCES CANCHAS (canchaID),
)

GO
CREATE TABLE PARTIDOS(
partidoID INT IDENTITY(1,1) NOT NULL,
reservacionID INT  NOT NULL,
golesClub1 INT  NOT NULL,
golesClub2 INT  NOT NULL,
resultado INT  NOT NULL,
evaluacion TEXT NOT NULL,
CONSTRAINT PK_PARTIDOS_ID PRIMARY KEY (partidoID),
CONSTRAINT FK_RESERVACION_PARTIDO_ID  FOREIGN KEY (reservacionID) REFERENCES RESERVACIONES (reservacionID)
)

GO
CREATE TABLE EVALUACION_EQUIPOS(
evaluacionID INT IDENTITY(1,1) NOT NULL,
partidoID INT NOT NULL,
emisorID VARCHAR(40)  NOT NULL,
receptorID  VARCHAR(40)  NOT NULL,
calificacion INT  NOT NULL,
evaluacion TEXT NOT NULL,
estrellas INT  NOT NULL,
dureza VARCHAR(40)  NOT NULL,
CONSTRAINT PK_EVALUACION_EQUIPOS_ID PRIMARY KEY (evaluacionID),
CONSTRAINT FK_EVALUACION_EQUIPOS_PARTIDO_ID  FOREIGN KEY (partidoID) REFERENCES PARTIDOS (partidoID),
CONSTRAINT FK_EVALUACION_EQUIPOS_EMISOR_ID  FOREIGN KEY (emisorID) REFERENCES CLUBES (clubID),
CONSTRAINT FK_EVALUACION_EQUIPOS_RECEPTOR_ID  FOREIGN KEY (emisorID) REFERENCES CLUBES (clubID)
)

GO

CREATE TABLE ALINEACION_PARTIDOS(
alineacionID INT IDENTITY(1,1) NOT NULL,
partidoID INT NOT NULL,
clubID VARCHAR(40)  NOT NULL,
jugadorID  INT  NOT NULL,
posicionID INT  NOT NULL,
camisetas INT  NOT NULL,
goles INT  NOT NULL,
rojas INT  NOT NULL,
amarillas INT  NOT NULL,
calificacion INT  NOT NULL,
evaluacion TEXT NOT NULL,
estrellas INT  NOT NULL,
CONSTRAINT PK_ALINEACION_PARTIDOS_ID PRIMARY KEY (alineacionID),
CONSTRAINT FK_ALINEACION_PARTIDOS_PARTIDO_ID  FOREIGN KEY (partidoID) REFERENCES PARTIDOS (partidoID),
CONSTRAINT FK_ALINEACION_PARTIDOS_CLUB_ID  FOREIGN KEY (clubID) REFERENCES CLUBES (clubID),
CONSTRAINT FK_ALINEACION_PARTIDOS_JUGADOR_ID  FOREIGN KEY (jugadorID) REFERENCES JUGADORES_CLUBES_POSICION (jugadorID),
CONSTRAINT FK_ALINEACION_PARTIDOS_POCICIONES_ID  FOREIGN KEY (posicionID) REFERENCES POSICIONES (posicionID)
)

GO