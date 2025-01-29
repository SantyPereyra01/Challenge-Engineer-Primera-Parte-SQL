--OPCION 1:

--Script create tables para ejecutar en SQL estandar, me base en PostgreSQL

-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    direccion TEXT,
    telefono VARCHAR(20),
    genero VARCHAR(10)
);

-- Tabla Categoria
CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    ruta TEXT NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo')),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP,
    id_categoria INT NOT NULL REFERENCES Categoria(id_categoria)
);

-- Tabla Compra
CREATE TABLE Compra (
    id_compra SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES Usuario(id_usuario),
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Detalle_Compra (Intermedia entre Compra y Producto)
CREATE TABLE Detalle_Compra (
    id_compra INT NOT NULL REFERENCES Compra(id_compra),
    id_producto INT NOT NULL REFERENCES Producto(id_producto),
    cantidad INT NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    precio_total DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    PRIMARY KEY (id_compra, id_producto)
);

-- Tabla Historial_Precios_Estados (almacena el precio y estado de los productos al final del día)
CREATE TABLE Historial_Precios_Estados (
    id_historial SERIAL PRIMARY KEY,
    id_producto INT NOT NULL REFERENCES Producto(id_producto),
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('activo', 'inactivo')),
    fecha_registro DATE DEFAULT CURRENT_DATE
);

---No hace falta verificar ya que la consola te debuge con "CREATE TABLE"

--OPCION 2:

--Script create tables para ejecutar en SQL estandar, me base en MySQL

-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    direccion TEXT,
    telefono VARCHAR(20),
    genero VARCHAR(10)
);

-- Tabla Categoria
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    ruta TEXT NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabla Compra
CREATE TABLE Compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla Detalle_Compra (Intermedia entre Compra y Producto)
CREATE TABLE Detalle_Compra (
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    precio_total DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    PRIMARY KEY (id_compra, id_producto),
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Tabla para almacenar el precio y estado de los productos al final del día
CREATE TABLE Historial_Precios_Estados (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL,
    fecha_registro DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

--verificar si se crearon:
SHOW TABLES;

--OPCIÓN 3:

--Script create tables para ejecutar en SQL estandar, me base en SQL Server

-- Asegurar que QUOTED_IDENTIFIER esté activado
SET QUOTED_IDENTIFIER ON;
GO

-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    apellido NVARCHAR(50) NOT NULL,
    correo NVARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    direccion NVARCHAR(MAX),
    telefono NVARCHAR(20),
    genero NVARCHAR(10)
);

-- Tabla Categoria
CREATE TABLE Categoria (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(100) NOT NULL,
    ruta NVARCHAR(MAX) NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(10) NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo')),
    fecha_creacion DATETIME DEFAULT GETDATE(),
    fecha_baja DATETIME NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabla Compra
CREATE TABLE Compra (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_compra DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla Detalle_Compra (Intermedia entre Compra y Producto)
CREATE TABLE Detalle_Compra (
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    precio_total AS (cantidad * precio_unitario) PERSISTED,
    PRIMARY KEY (id_compra, id_producto),
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Tabla para almacenar el precio y estado de los productos al final del día
CREATE TABLE Historial_Precios_Estados (
    id_historial INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(10) NOT NULL CHECK (estado IN ('activo', 'inactivo')),
    fecha_registro DATE DEFAULT GETDATE(),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

--verificar si se crearon:

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';