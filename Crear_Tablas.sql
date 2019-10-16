use GD2C2019

create table Usuario(
	ID_Usuario smallint NOT NULL,
	USR_USRName varchar(255),
	USR_Pass varchar(255),
	PRIMARY KEY (ID_Usuario)
)

create table Cliente ( 
	ID_Clie smallint NOT NULL,
	Clie_Nom varchar(255) NOT NULL,
	Clie_Apellido varchar(255) NOT NULL,
	Clie_DNI numeric(9,0) UNIQUE NOT NULL,
	Clie_Calle varchar(255),
	Clie_Piso numeric(2,0),
	Clie_Dpto varchar(2),
	Clie_Localidad varchar(255),
	Clie_Tel numeric(14,0) UNIQUE, 
	Clie_Mail varchar(255) UNIQUE,
	Clie_Ciudad varchar(255),
	Clie_Fecha_Nac datetime,
	PRIMARY KEY (ID_Clie)
)

create table Proveedor (
	ID_Proveedor smallint NOT NULL,
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
	Provee_Rubro varchar(20),
	Provee_NombreContacto varchar(100),
	PRIMARY KEY (ID_Proveedor)
)

create table Administrativo (
	ID_Admin smallint NOT NULL,
	PRIMARY KEY (ID_Admin)
)

create table Rol(
	ID_Rol smallint NOT NULL,
	PRIMARY KEY (ID_Rol)
)

create table Funcion (
	ID_Func smallint NOT NULL,
	PRIMARY KEY (ID_Func)
)

create table Roles_Por_Usuario (
	ID_Usuario smallint NOT NULL,
	ID_Rol smallint NOT NULL,
	FOREIGN KEY (ID_Usuario) REFERENCES Usuario (ID_Usuario),
	FOREIGN KEY (ID_Rol) REFERENCES Rol (ID_Rol)
)

create table Funcion_Por_Rol (
	ID_Rol smallint NOT NULL,
	ID_Func smallint NOT NULL,
	FOREIGN KEY (ID_Rol) REFERENCES Rol (ID_Rol),
	FOREIGN KEY (ID_Func) REFERENCES Funcion (ID_Func)
)

create table Cuenta (
	ID_Cuenta smallint NOT NULL,
	ID_Clie smallint NOT NULL,
	Carga_Fecha datetime,
	Carga_Monto numeric(10,3),
	Tipo_Pago varchar(5),
	PRIMARY KEY (ID_Cuenta),
	FOREIGN KEY (ID_Clie) REFERENCES Cliente (ID_Clie) 
)

create table Tarjeta (
	ID_Tarjeta smallint NOT NULL,
	ID_Cuenta smallint NOT NULL,
	Tarj_Nro numeric(20,0) UNIQUE,
	Tarj_Cod_Seg numeric(3,0),
	PRIMARY KEY (ID_Tarjeta),
	FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta (ID_Cuenta)
)

create table Factura (
	ID_Fact smallint NOT NULL,
	ID_Proveedor smallint NOT NULL,
	Fact_Fecha datetime,
	Fact_Nro numeric (18,0),
	PRIMARY KEY (ID_Fact),
	FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor (ID_Proveedor)
)

create table Oferta (
	ID_Oferta smallint NOT NULL,
	ID_Proveedor smallint NOT NULL,
	Ofe_Precio numeric(18,2) NOT NULL,
	Ofe_Precio_Ficticio numeric(18,2),
	Ofe_Fecha datetime,
	Ofe_Fecha_Venc datetime,
	Ofe_Descrip varchar(255),
	Ofe_Cant numeric(18,0),
	Ofe_Fecha_Compra datetime,
	Ofe_Cod smallint NOT NULL,
	PRIMARY KEY (ID_Oferta),
	FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor (ID_Proveedor)
)

create table Compra (
	ID_Compra smallint NOT NULL,
	ID_Oferta smallint NOT NULL,
	ID_Clie smallint NOT NULL,
	Compra_Fecha datetime,
	Compra_Cant numeric(18,0),
	PRIMARY KEY (ID_Compra),
	FOREIGN KEY (ID_Oferta) REFERENCES Oferta (ID_Oferta),
	FOREIGN KEY (ID_Clie) REFERENCES Cliente (ID_Clie)
)

create table Cupon (
	ID_Cupon smallint NOT NULL,
	ID_Compra smallint NOT NULL,
	Cup_Fecha_Consumo datetime,
	Cup_Fecha_Venc datetime,
	PRIMARY KEY (ID_Cupon),
	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra)

)

create table Detalle_Facturacion (
	ID_Detalle_Fact smallint NOT NULL,
	ID_Fact smallint NOT NULL,
	ID_Compra smallint NOT NULL,
	PRIMARY KEY (ID_Detalle_Fact),
	FOREIGN KEY (ID_Fact) REFERENCES Factura (ID_Fact),
	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra)
)
