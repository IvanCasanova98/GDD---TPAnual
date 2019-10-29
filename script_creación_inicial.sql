USE GD2C2019;

IF NOT EXISTS (select * from sys.schemas where name = 'HPBC')
BEGIN
EXEC('create schema HPBC')
END;
GO

create FUNCTION HPBC.Hash_Contraseņa(@AEncriptar nvarchar(255))
RETURNS varbinary(8000)
BEGIN

RETURN HASHBYTES('SHA2_256', @AEncriptar); 

END
GO


IF NOT EXISTS (select * from sysobjects where name='Cliente' and xtype='U')
CREATE TABLE HPBC.Cliente(
	clie_ID INT NOT NULL IDENTITY(1,1),
	clie_nombre nvarchar(255) NOT NULL,
	clie_apellido nvarchar(255) NOT NULL,
	clie_dni numeric(18,0) UNIQUE NOT NULL,
	clie_mail nvarchar(255) UNIQUE NOT NULL,
	clie_tel numeric(18,0) UNIQUE NULL,
	clie_direccion nvarchar(255) NOT NULL,
	clie_fecha_nac date NOT NULL,
	clie_ciudad nvarchar(255) NULL,
	clie_localidad nvarchar(255) NULL,
	clie_habilitado bit NOT NULL,
	clie_monto numeric(18,0) NOT NULL,
	clie_usuario_ID INT,
 CONSTRAINT PK_Cliente PRIMARY KEY CLUSTERED(
	clie_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO


IF NOT EXISTS (select * from sysobjects where name='Usuario' and xtype='U')
CREATE TABLE HPBC.Usuario(
	usuario_id INT NOT NULL IDENTITY(1,1),
	usuario_username nvarchar(50) NOT NULL,
	usuario_password varbinary(8000) NOT NULL,
	usuario_habilitado BIT NOT NULL,
	usuario_bloqueado BIT NOT NULL,
	usuario_cant_logeo_error INT NULL,
 CONSTRAINT PK_Usuario PRIMARY KEY CLUSTERED(
	usuario_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO


IF NOT EXISTS (select * from sysobjects where name='Proveedor' and xtype='U')
CREATE TABLE HPBC.Proveedor(
	Provee_ID INT NOT NULL identity(1,1) ,
	Provee_Rs varchar(100) UNIQUE NOT NULL,
	Provee_Calle varchar(255),
	Provee_Piso numeric(2,0),
	Provee_Dpto varchar(2),
	Provee_Localidad varchar(255),
	Provee_Ciudad varchar(255),
	Provee_CodPostal numeric(4,0),
	Provee_Mail varchar(255) UNIQUE,
	Provee_CUIT numeric(11,0) UNIQUE NOT NULL,
	Provee_Tel numeric(14,0) UNIQUE,
	Provee_NombreContacto varchar(100),
	Provee_Habilitado Bit NOT NULL,
	Provee_Rubro INT,
	Provee_usuario_id INT,
 CONSTRAINT PK_Proveedor PRIMARY KEY CLUSTERED(
	Provee_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Administrativo' and xtype='U')
CREATE TABLE HPBC.Administrativo(
	Admin_ID INT identity(1,1) NOT NULL,
 CONSTRAINT PK_Administrativo PRIMARY KEY CLUSTERED(
	Admin_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO


IF NOT EXISTS (select * from sysobjects where name='Rol' and xtype='U')
CREATE TABLE HPBC.Rol(
	Rol_ID INT identity(1,1) NOT NULL,
	Rol_detalle nvarchar(255) NOT NULL,
	Rol_Habilitado Bit DEFAULT 1,
 CONSTRAINT PK_Rol PRIMARY KEY CLUSTERED(
	Rol_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Funcion' and xtype='U')
CREATE TABLE HPBC.Funcion(
	Func_ID INT identity(1,1) NOT NULL,
	Func_detalle nvarchar(255) NOT NULL,
 CONSTRAINT PK_Funcion PRIMARY KEY CLUSTERED(
	Func_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Rol_Por_Usuario' and xtype='U')
CREATE TABLE HPBC.Rol_Por_Usuario(
	ID_Rol INT NOT NULL,
	ID_Usuario INT NOT NULL,
 CONSTRAINT PK_Rol_Por_Usuario PRIMARY KEY CLUSTERED(
	ID_Rol ASC,
	ID_Usuario ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Funcion_Por_Rol' and xtype='U')
CREATE TABLE HPBC.Funcion_Por_Rol(
	Rol_ID INT NOT NULL,
	Func_ID INT NOT NULL,
 CONSTRAINT PK_Funcion_Por_Rol PRIMARY KEY CLUSTERED(
	Rol_ID ASC,
	Func_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Credito' and xtype='U')
CREATE TABLE HPBC.Credito(
	Credito_ID INT identity(1,1) NOT NULL,
	Credito_ID_Clie INT NOT NULL,
	Carga_Fecha datetime,
	Carga_Monto numeric(12,2),
	Credito_ID_Tarjeta INT NOT NULL,
 CONSTRAINT PK_Creditos PRIMARY KEY CLUSTERED(
	Credito_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Tipo_Pago' and xtype='U')
CREATE TABLE HPBC.Tipo_Pago(
	Tipo_Pago_ID INT identity(1,1) NOT NULL,
	Tarj_Detalle nvarchar(255) NOT NULL,
	Tarj_Nro numeric(20,0) UNIQUE,
	Tarj_Cod_Seg numeric(3,0),
 CONSTRAINT PK_Tipo_Pago PRIMARY KEY CLUSTERED(
	Tipo_Pago_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Factura' and xtype='U')
CREATE TABLE HPBC.Factura(
	Fact_ID INT identity(1,1) NOT NULL,
	Fact_ID_Proveedor INT NOT NULL,
	Fact_Fecha datetime,
	Fact_Nro numeric (18,0),
 CONSTRAINT PK_Fact PRIMARY KEY CLUSTERED(
	Fact_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Oferta' and xtype='U')
CREATE TABLE HPBC.Oferta(
	Ofe_ID INT identity(1,1) NOT NULL,
	Ofe_ID_Proveedor INT NOT NULL,
	Ofe_Precio numeric(18,2) NOT NULL,
	Ofe_Precio_Ficticio numeric(18,2),
	Ofe_Fecha datetime,
	Ofe_Fecha_Venc datetime,
	Ofe_Descrip varchar(255),
	Ofe_Cant numeric(18,0),
	Ofe_Fecha_Compra datetime,
	Ofe_Cod smallint NOT NULL,
	Ofe_Max_Cant_Por_Usuario numeric(18,0) null
 CONSTRAINT PK_Oferta PRIMARY KEY CLUSTERED(
	Ofe_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Compra' and xtype='U')
CREATE TABLE HPBC.Compra(
	Compra_ID int identity(1,1) NOT NULL,
	Compra_ID_Oferta int  NOT NULL,
	Compra_ID_Clie_Dest Int  NOT NULL,
	Compra_Fecha datetime,
	Compra_Cant numeric(18,0),
 CONSTRAINT PK_Compra PRIMARY KEY CLUSTERED(
	Compra_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Cupon' and xtype='U')
CREATE TABLE HPBC.Cupon(
	Cupon_ID Int identity(1,1) NOT NULL,
	Cupon_ID_Compra Int NOT NULL,
	Cup_Fecha_Consumo datetime,
	Cup_Fecha_Venc datetime,
 CONSTRAINT PK_Cupon PRIMARY KEY CLUSTERED(
	Cupon_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Detalle_Fact' and xtype='U')
CREATE TABLE HPBC.Detalle_Fact(
	Detalle_Fact_ID int identity(1,1) NOT NULL,
	Detalle_ID_Fact Int NOT NULL,
	Detalle_ID_Compra int NOT NULL,
 CONSTRAINT PK_Detalle_Fact PRIMARY KEY CLUSTERED(
	Detalle_Fact_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='Rubro' and xtype='U')
CREATE TABLE HPBC.Rubro(
	Rubro_ID int identity(1,1) NOT NULL,
	Rubro_detalle nvarchar(255) NOT NULL,
 CONSTRAINT PK_Rubro PRIMARY KEY CLUSTERED(
	Rubro_ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)ON [PRIMARY]
GO

IF NOT EXISTS (select * from sysobjects where name='TablaTemporal' and xtype='U')
CREATE TABLE HPBC.TablaTemporal(
	[Cli_Nombre] [nvarchar](255) NULL,
	[Cli_Apellido] [nvarchar](255) NULL,
	[Cli_Dni] [numeric](18, 0) NULL,
	[Cli_Direccion] [nvarchar](255) NULL,
	[Cli_Telefono] [numeric](14,0) NULL,
	[Cli_Mail] [nvarchar](255) NULL,
	[Cli_Fecha_Nac] [datetime] NULL,
	[Cli_Ciudad] [nvarchar](255) NULL,
	[Carga_Credito] [numeric](12,2) NULL,
	[Carga_Fecha] [datetime] NULL,
	[Tipo_Pago_Desc] [nvarchar](255) NULL,
	[Cli_Dest_Nombre] [nvarchar](255) NULL,
    [Cli_Dest_Apellido] [nvarchar](255) NULL,
    [Cli_Dest_Dni] [numeric](18, 0) NULL,
    [Cli_Dest_Direccion] [nvarchar](255) NULL,
    [Cli_Dest_Telefono] [numeric](14,0) NULL,
    [Cli_Dest_Mail] [nvarchar](255) NULL,
    [Cli_Dest_Fecha_Nac] [datetime] NULL,
    [Cli_Dest_Ciudad] [nvarchar](255) NULL,
	[Provee_RS] [nvarchar](100) NULL,
	[Provee_Dom] [nvarchar](255) NULL,
	[Provee_Ciudad] [nvarchar](255) NULL,
	[Provee_Telefono] [numeric](14,0) NULL,
	[Provee_CUIT] [numeric] (11,0) NULL,
	[Provee_Rubro] [nvarchar](255) NULL,
	[Oferta_Precio] [numeric](18, 0) NULL,
	[Oferta_Precio_Ficticio] [numeric](18, 0) NULL,
	[Oferta_Fecha] [datetime] NULL,
	[Oferta_Fecha_Venc] [datetime] NULL,
	[Oferta_Cantidad] [numeric](18, 0) NULL,
	[Oferta_Descripcion] [nvarchar](255) NULL,
	[Oferta_Fecha_Compra] [datetime] NULL,
	[Oferta_Codigo] [smallint] NULL,
	[Oferta_Entregado_Fecha] [datetime] NULL,
	[Factura_Nro] [numeric](18, 0) NULL,
	[Factura_Fecha] [datetime] NULL
) ON [PRIMARY]


/* Creacion de las 16 FOREIGN KEYS */

IF NOT EXISTS (select * from sysobjects where name='FK_Cliente_ID_Usuario' and xtype='F')
ALTER TABLE HPBC.Cliente WITH CHECK ADD CONSTRAINT FK_Cliente_ID_Usuario  FOREIGN KEY(clie_usuario_ID)
REFERENCES HPBC.Usuario(usuario_id)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Provedor_ID_Usuario' and xtype='F')
ALTER TABLE HPBC.Proveedor WITH CHECK ADD CONSTRAINT FK_Provedor_ID_Usuario FOREIGN KEY(Provee_usuario_id)
REFERENCES HPBC.Usuario(usuario_id)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Usuario_ID_Rol' and xtype='F')
ALTER TABLE HPBC.Rol_Por_Usuario WITH CHECK ADD CONSTRAINT FK_Usuario_ID_Rol FOREIGN KEY(ID_Rol)
REFERENCES HPBC.Rol(Rol_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Rol_ID_Usuario' and xtype='F')
ALTER TABLE HPBC.Rol_Por_Usuario WITH CHECK ADD CONSTRAINT FK_Rol_ID_Usuario FOREIGN KEY(ID_Usuario)
REFERENCES HPBC.Usuario(usuario_id)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Funcion_ID_Rol' and xtype='F')
ALTER TABLE HPBC.Funcion_Por_Rol WITH CHECK ADD CONSTRAINT FK_Funcion_ID_Rol FOREIGN KEY(Rol_ID)
REFERENCES HPBC.Rol(Rol_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Rol_ID_Funcion' and xtype='F')
ALTER TABLE HPBC.Funcion_Por_Rol WITH CHECK ADD CONSTRAINT FK_Rol_ID_Funcion FOREIGN KEY(Func_ID)
REFERENCES HPBC.Funcion(Func_ID)
GO


IF NOT EXISTS (select * from sysobjects where name='FK_Oferta_ID_Provedor' and xtype='F')
ALTER TABLE HPBC.Oferta WITH CHECK ADD CONSTRAINT FK_Oferta_ID_Provedor FOREIGN KEY(Ofe_ID_Proveedor)
REFERENCES HPBC.Proveedor(Provee_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Provee_ID_Rubro' and xtype='F')
ALTER TABLE HPBC.Proveedor WITH CHECK ADD CONSTRAINT FK_Provee_ID_Rubro FOREIGN KEY(Provee_Rubro)
REFERENCES HPBC.Rubro(Rubro_ID)
GO


IF NOT EXISTS (select * from sysobjects where name='FK_Compra_ID_Oferta' and xtype='F')
ALTER TABLE HPBC.Compra WITH CHECK ADD CONSTRAINT FK_Compra_ID_Oferta FOREIGN KEY(Compra_ID_Oferta)
REFERENCES HPBC.Oferta(Ofe_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Compra_ID_Clie' and xtype='F')
ALTER TABLE HPBC.Compra WITH CHECK ADD CONSTRAINT FK_Compra_ID_Clie FOREIGN KEY(Compra_ID_Clie_Dest)
REFERENCES HPBC.Cliente(clie_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Cupon_ID_Compra' and xtype='F')
ALTER TABLE HPBC.Cupon WITH CHECK ADD CONSTRAINT FK_Cupon_ID_Compra FOREIGN KEY (Cupon_ID_Compra)
REFERENCES HPBC.Compra(Compra_ID)
GO


IF NOT EXISTS (select * from sysobjects where name='FK_Credito_ID_Clie' and xtype='F')
ALTER TABLE HPBC.Credito WITH CHECK ADD CONSTRAINT FK_Credito_ID_Clie FOREIGN KEY (Credito_ID_Clie)
REFERENCES HPBC.Cliente(clie_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Credito_ID_Tarjeta' and xtype='F')
ALTER TABLE HPBC.Credito WITH CHECK ADD CONSTRAINT FK_Credito_ID_Tarjeta FOREIGN KEY (Credito_ID_Tarjeta)
REFERENCES HPBC.Tipo_Pago(Tipo_Pago_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Fact_ID_Proveedor' and xtype='F')
ALTER TABLE HPBC.Factura WITH CHECK ADD CONSTRAINT FK_Fact_ID_Proveedor FOREIGN KEY (Fact_ID_Proveedor)
REFERENCES HPBC.Proveedor(Provee_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Detalle_ID_Fact' and xtype='F')
ALTER TABLE HPBC.Detalle_Fact WITH CHECK ADD CONSTRAINT FK_Detalle_ID_Fact FOREIGN KEY (Detalle_ID_Fact)
REFERENCES HPBC.Factura(Fact_ID)
GO

IF NOT EXISTS (select * from sysobjects where name='FK_Detalle_ID_Compra' and xtype='F')
ALTER TABLE HPBC.Detalle_Fact  WITH CHECK ADD CONSTRAINT FK_Detalle_ID_Compra FOREIGN KEY (Detalle_ID_Compra)
REFERENCES HPBC.Compra(Compra_ID)
GO

USE [master]
GO
ALTER DATABASE [GD2C2019] SET READ_WRITE 
GO
USE GD2C2019;
GO


IF EXISTS (SELECT name FROM sysobjects WHERE name='limpiar_tablas' AND type='p')
DROP PROCEDURE HPBC.limpiar_tablas
GO
CREATE PROCEDURE HPBC.limpiar_tablas
AS
BEGIN
DELETE FROM [HPBC].[Administrativo]
DELETE FROM [HPBC].[Cliente]
DELETE FROM [HPBC].[Compra]
DELETE FROM [HPBC].[Credito]
DELETE FROM [HPBC].[Cupon]
DELETE FROM [HPBC].[Detalle_Fact]
DELETE FROM [HPBC].[Factura]
DELETE FROM [HPBC].[Funcion]
DELETE FROM [HPBC].[Funcion_Por_Rol]
DELETE FROM [HPBC].[Oferta]
DELETE FROM [HPBC].[Proveedor]
DELETE FROM [HPBC].[Rol]
DELETE FROM [HPBC].[Rol_Por_Usuario]
DELETE FROM [HPBC].[Rubro]
DELETE FROM [HPBC].[Tipo_Pago]
DELETE FROM [HPBC].[TablaTemporal]
DELETE FROM [HPBC].[Usuario]
END

EXEC HPBC.limpiar_tablas
GO


INSERT INTO HPBC.Funcion(Func_detalle)
Values('AMB DE ROL')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('REGISTRO')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('AMB DE CLIENTES')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('AMB DE PROVEDOR')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('CARGA DE CREDITO')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('CONFECCION Y PUBLICACION DE OFERTAS')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('COMPRAR OFERTA')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('ENTREGA/CONSUMO DE OFERTA')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('FACTURACION PROVEDOR')
INSERT INTO HPBC.Funcion(Func_detalle)
Values('LISTADO ESTADISTICO')

INSERT INTO HPBC.Rol(Rol_detalle)
Values('Administrativo')
INSERT INTO HPBC.Rol(Rol_detalle)
Values('Cliente')
INSERT INTO HPBC.Rol(Rol_detalle)
Values('Provedor')
/*le doy a los roles sus funcs*/
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(1,1)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(1,3)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(1,4)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(1,9)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(1,10)

INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(2,2)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(2,5)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(2,7)

INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(3,2)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(3,6)
INSERT INTO HPBC.Funcion_Por_Rol(Rol_ID,Func_ID)
Values(3,8)

--admin
INSERT INTO HPBC.Usuario(usuario_username, usuario_password, usuario_habilitado, usuario_bloqueado, usuario_cant_logeo_error)
VALUES('admin',HASHBYTES('SHA2_256','admin'),1,0,0)
GO
INSERT INTO HPBC.Rol_Por_Usuario(ID_Rol ,ID_Usuario)
SELECT 1, (SELECT usuario_id from  HPBC.Usuario WHERE usuario_username= 'admin')
GO

--Creo triggers para bajas logicas

create TRIGGER HPBC.trigger_baja_logica ON HPBC.Rol FOR UPDATE
AS 
BEGIN TRANSACTION
	IF EXISTS(SELECT 1 FROM inserted i WHERE i.rol_habilitado = 0)
	BEGIN
		DELETE FROM HPBC.Rol_Por_Usuario
		WHERE ID_Rol = (SELECT i.Rol_ID FROM inserted i)
	END
COMMIT TRANSACTION
GO


/* CLIENTES */
	/* Me traigo todos los clientes que sean distintos */

	/*Se agrupa clientes de la tabla Maestra y se inserta en una tabla Temporal*/
	SELECT Cli_Nombre AS Nombre,Cli_Apellido AS Apellido,convert(nvarchar(255),Cli_Dni) AS Dni ,Cli_Direccion, Cli_Telefono AS Telefono, Cli_Mail as Email,Cli_Ciudad, Cli_Fecha_Nac
	INTO #Temp_Clientes
	FROM GD2C2019.gd_esquema.Maestra
	WHERE Cli_Dni IS NOT NULL AND Cli_Mail IS NOT NULL
	GROUP BY Cli_Nombre,Cli_Apellido,Cli_Dni,Cli_Fecha_Nac,Cli_Mail,Cli_Direccion,Cli_Telefono,Cli_Ciudad;
	
	/*Se busca si existe incosistencia en los datos mediante otra tabla Temporal*/
	SELECT  Nombre,Apellido,Dni,Cli_Fecha_Nac,Email,Cli_Direccion,Telefono,Cli_Ciudad,row_number() OVER(PARTITION BY Dni ORDER BY Email) AS cantDni,row_number() OVER(PARTITION BY Email ORDER BY Email) AS cantEmail
	INTO #Temp_Cli_Incons
	FROM #Temp_Clientes
	GROUP BY Nombre,Apellido,Dni,Cli_Fecha_Nac,Email,Cli_Direccion,Telefono,Cli_Ciudad;
	
	/* Borro la primer tabla temporal, ya que no sirve mas */
	DROP TABLE #Temp_Clientes;
	
	/* Se cren los usuarios de los Clientes */
	INSERT INTO HPBC.Usuario (usuario_username, usuario_password, usuario_habilitado, usuario_bloqueado, usuario_cant_logeo_error)
	SELECT Dni AS username , HASHBYTES('SHA2_256',Dni), 1, 0, 0
	FROM #Temp_Cli_Incons
	WHERE cantDni = 1 AND cantEmail = 1 
	
	/* Se les asigna el Rol de Cliente */
	INSERT INTO HPBC.Rol_Por_Usuario(ID_Rol ,ID_Usuario)
	SELECT 2, usuario_id 
	FROM HPBC.Usuario
	WHERE usuario_id NOT IN (SELECT ID_Usuario FROM HPBC.Rol_Por_Usuario)
	
	/* Ahora si se insertan los Clientes */
	INSERT INTO HPBC.Cliente (clie_nombre, clie_apellido,  clie_dni, clie_mail, clie_tel, clie_direccion, clie_fecha_nac, clie_ciudad,clie_localidad, clie_habilitado,clie_monto, clie_usuario_id)
	SELECT Nombre, Apellido, convert(numeric(18,0),Dni),  Email, Telefono, Cli_Direccion,Cli_Fecha_Nac,Cli_Ciudad,null, 1,200 ,u.usuario_id
	FROM #Temp_Cli_Incons 
	INNER JOIN HPBC.Usuario u
	ON Dni = u.usuario_username
	WHERE cantDni = 1 and cantEmail = 1 
	ORDER BY dni
	
	/* No sirve mas */
	DROP TABLE #Temp_Cli_Incons;

