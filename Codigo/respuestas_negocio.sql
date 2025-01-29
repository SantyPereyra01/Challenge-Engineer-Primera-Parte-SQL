--OPCION 1:

-- respuestas del negocio basado en PostgreSQL

-- lista de los usuarios que cumplen años hoy y que hayan vendido más de 1500 productos en enero de 2020
SELECT u.id_usuario, u.nombre, u.apellido, COUNT(dc.id_producto) AS cantidad_vendida
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE EXTRACT(MONTH FROM u.fecha_nacimiento) = EXTRACT(MONTH FROM CURRENT_DATE) 
  AND EXTRACT(DAY FROM u.fecha_nacimiento) = EXTRACT(DAY FROM CURRENT_DATE) 
  AND EXTRACT(MONTH FROM c.fecha_compra) = 1 
  AND EXTRACT(YEAR FROM c.fecha_compra) = 2020
GROUP BY u.id_usuario, u.nombre, u.apellido
HAVING COUNT(dc.id_producto) > 1500;

-- top 5 de usuarios con mayores ventas ($) por mes en la categoría 'Celulares' durante 2020
SELECT 
    EXTRACT(YEAR FROM c.fecha_compra) AS anio,
    EXTRACT(MONTH FROM c.fecha_compra) AS mes,
    u.id_usuario,
    u.nombre,
    u.apellido,
    COUNT(c.id_compra) AS cantidad_ventas,
    SUM(dc.cantidad) AS productos_vendidos,
    SUM(dc.precio_total) AS monto_total
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE cat.descripcion = 'Celulares'
  AND EXTRACT(YEAR FROM c.fecha_compra) = 2020
GROUP BY anio, mes, u.id_usuario, u.nombre, u.apellido
ORDER BY monto_total DESC
LIMIT 5;

-- SP
CREATE OR REPLACE FUNCTION HistorialPreciosEstados()
RETURNS VOID AS $$
BEGIN
    INSERT INTO Historial_Precios_Estados (id_producto, precio, estado, fecha_registro)
    SELECT p.id_producto, p.precio, p.estado, CURRENT_DATE
    FROM Producto p;
END;
$$ LANGUAGE plpgsql;

-- Ejecutar la función para  la tabla
SELECT HistorialPreciosEstados();


--OPCION 2:

-- respuestas del negocio basado en MySQL

-- lista de los usuarios que cumplen años hoy y que hayan vendido más de 1500 productos en enero de 2020
SELECT u.id_usuario, u.nombre, u.apellido, COUNT(dc.id_producto) AS cantidad_vendida
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE MONTH(u.fecha_nacimiento) = MONTH(CURDATE()) 
  AND DAY(u.fecha_nacimiento) = DAY(CURDATE()) 
  AND MONTH(c.fecha_compra) = 1 
  AND YEAR(c.fecha_compra) = 2020
GROUP BY u.id_usuario, u.nombre, u.apellido
HAVING COUNT(dc.id_producto) > 1500;

-- Top 5 de usuarios con mayores ventas ($) por mes en la categoría 'Celulares' durante 2020
SELECT 
    YEAR(c.fecha_compra) AS anio,
    MONTH(c.fecha_compra) AS mes,
    u.id_usuario,
    u.nombre,
    u.apellido,
    COUNT(c.id_compra) AS cantidad_ventas,
    SUM(dc.cantidad) AS productos_vendidos,
    SUM(dc.precio_total) AS monto_total
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE cat.descripcion = 'Celulares'
  AND YEAR(c.fecha_compra) = 2020
GROUP BY anio, mes, u.id_usuario, u.nombre, u.apellido
ORDER BY monto_total DESC
LIMIT 5;

-- SP
DELIMITER $$
CREATE PROCEDURE HistorialPreciosEstados()
BEGIN
    INSERT INTO Historial_Precios_Estados (id_producto, precio, estado, fecha_registro)
    SELECT p.id_producto, p.precio, p.estado, CURDATE()
    FROM Producto p;
END $$
DELIMITER ;

-- Ejecutar el procedimiento para  la tabla
CALL HistorialPreciosEstados();


--OPCION 3:

-- respuestas del negocio basado en SQL SERVER

-- lista de los usuarios que cumplen años hoy y que hayan vendido más de 1500 productos en enero de 2020
SELECT u.id_usuario, u.nombre, u.apellido, COUNT(dc.id_producto) AS cantidad_vendida
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE MONTH(u.fecha_nacimiento) = MONTH(GETDATE()) 
  AND DAY(u.fecha_nacimiento) = DAY(GETDATE()) 
  AND MONTH(c.fecha_compra) = 1 
  AND YEAR(c.fecha_compra) = 2020
GROUP BY u.id_usuario, u.nombre, u.apellido
HAVING COUNT(dc.id_producto) > 1500;

--Top 5 de usuarios con mayores ventas ($) por mes en la categoría 'Celulares' durante 2020
SELECT TOP 5
    YEAR(c.fecha_compra) AS anio,
    MONTH(c.fecha_compra) AS mes,
    u.id_usuario,
    u.nombre,
    u.apellido,
    COUNT(c.id_compra) AS cantidad_ventas,
    SUM(dc.cantidad) AS productos_vendidos,
    SUM(dc.precio_total) AS monto_total
FROM Usuario u
JOIN Compra c ON u.id_usuario = c.id_usuario
JOIN Detalle_Compra dc ON c.id_compra = dc.id_compra
JOIN Producto p ON dc.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
WHERE cat.descripcion = 'Celulares'
  AND YEAR(c.fecha_compra) = 2020
GROUP BY YEAR(c.fecha_compra), MONTH(c.fecha_compra), u.id_usuario, u.nombre, u.apellido
ORDER BY monto_total DESC;

GO
CREATE OR ALTER PROCEDURE HistorialPreciosEstados
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Historial_Precios_Estados (id_producto, precio, estado, fecha_registro)
    SELECT p.id_producto, p.precio, p.estado, CAST(GETDATE() AS DATE)
    FROM Producto p;
END;
GO

-- Ejecutar el procedimiento para  la tabla
EXEC HistorialPreciosEstados;
