# Challenge-Engineer-Primera-Parte-SQL
Challenge Engineer - Primera Parte - SQL


# Descripción del Proyecto
Este proyecto consiste en el diseño y desarrollo de un modelo de base de datos para un ecommerce, incluyendo:
- Diseño del **Diagrama Entidad-Relación (DER)**.
- Creación del **script DDL (`create_tables.sql`)** para generar las tablas en MySQL, PostgreSQL y SQL Server.
- Implementación de **consultas SQL (`respuestas_negocio.sql`)** para responder preguntas de negocio clave.
- Creación de un **Stored Procedure** para mantener el histórico de precios y estados de los productos.

# Diseño del Modelo
El **DER** fue diseñado y validado en **dbdiagram.io**. Podés verlo en el siguiente enlace:
🔗 [DER en dbdiagram.io](https://dbdiagram.io/d/679a1ab4263d6cf9a0665639)

### Entidades Principales:
- **Usuario**: Clientes y vendedores del marketplace.
- **Producto**: Artículos en venta en el marketplace.
- **Categoria**: Clasificación de los productos.
- **Compra**: Registra cada transacción dentro del sitio.
- **Detalle_Compra**: Relación entre compras y productos.
- **Historial_Precios_Estados**: Almacena el precio y estado de los productos al final de cada día.


# Para corroborar que "Create_tables.sql" y "respuestas_negocio.sql" este en correcto funcionamiento se probo en:

https://sqlfiddle.com/
#### Creditos a Jonathan Magnan (https://jonathanmagnan.com/) por ser el propietario y creador de esta pagina con sus extensiones que nos facilita a nosotros debugear codigo en WEB

# Consultas Implementadas

### **CREATE TABLES**
scrip que crea las tablas que vamos a usar para hacer las consultas y buscar respuestas al negocio.

### **Listar los usuarios que cumplen años hoy y hayan vendido más de 1500 productos en enero de 2020**
Consulta que filtra usuarios con ventas superiores a 1500 productos en enero 2020 y que cumplen años en la fecha actual.

### **Top 5 de vendedores en la categoría 'Celulares' por mes en 2020**
Consulta que muestra el ranking de los 5 usuarios con mayores ventas en la categoría 'Celulares' por mes.

### **Stored Procedure: Poblar Historial de Precios y Estados**
Procedimiento almacenado que almacena el precio y estado de cada producto al final del día.