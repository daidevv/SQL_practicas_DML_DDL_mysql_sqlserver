-- M2-EJERCICIOS

-- Código - Recuperación de Datos
----------------------------------
--DISTINCT
----------------------------------
--1)Mostrar los diferentes productos vendidos
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID

SELECT  DISTINCT [ProductID]
FROM [Sales].[SalesOrderDetail];


------------------------------- 
-- UNION
--------------------------------                                                                                

--2)Mostrar todos los productos vendidos y ordenados
--Tablas: Sales.SalesOrderDetail, Production.WorkOrder
--Campos: ProductID

SELECT [ProductID]
FROM [Sales].[SalesOrderDetail]

UNION 

SELECT [ProductID]
FROM [Production].[WorkOrder]


-----------------------
-- CASE 
-------------------------

--4)Obtener el id y una columna denominada sexo cuyo valores disponibles sean “Masculino” y ”Femenino”
--Tablas: HumanResources.Employee
--Campos: BusinessEntityID, Gender

SELECT [BusinessEntityID] ,CASE 
WHEN [Gender]='F' THEN 'Femenino'
ELSE 'Masculino'END [Sexo]
FROM [HumanResources].[Employee];


--5)Mostrar el id de los empleados si tiene salario deberá mostrarse descendente de lo contrario ascendente
--Tablas:HumanResources.Employee
--Campos: BusinessEntityID, SalariedFlag	

SELECT [BusinessEntityID],[SalariedFlag]
FROM [HumanResources].[Employee]
ORDER BY 
CASE [SalariedFlag] WHEN 1 THEN [BusinessEntityID] END DESC

--------------------------------------------
-- FUNCIONES DE AGREGADO
---------------------------------------------

--1)Mostrar la fecha más reciente de venta 
--Tablas: Sales.SalesOrderHeader
--Campos: OrderDate

SELECT MAX(OrderDate) AS FechaReciente
FROM Sales.SalesOrderHeader;


--2)Mostrar el precio más barato de todas las bicicletas 
--Tablas: Production.Product
--Campos: ListPrice, ProductNumber

SELECT MIN(ListPrice) AS Precio
FROM Production.Product
WHERE Name LIKE '%BIKE%';


SELECT Name, ListPrice 
FROM Production.Product
WHERE Name LIKE '%BIKE%';


--3)Mostrar la fecha de nacimiento del empleado más joven 
--Tablas: HumanResources.Employee
--Campos: BirthDate

SELECT MAX(BirthDate) AS FechaNacimiento
FROM HumanResources.Employee;


--4)Mostrar el promedio del listado de precios de productos
--Tablas: Production.Product

SELECT AVG(ListPrice) AS Promedio
FROM Production.Product;

--5)Mostrar la cantidad y el total vendido por productos 
--Tablas: Sales.SalesOrderDetail

SELECT	COUNT(*) AS Cantidad,SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail;


---------------------
-- AGRUPAMIENTO
---------------------
--1)Mostrar el código de subcategoría y el precio del producto más barato de cada una de ellas 
--Tablas: Production.Product
--Campos: ProductSubcategoryID, ListPrice

SELECT ProductSubcategoryID, ListPrice, ProductID 
FROM Production.Product PP
WHERE ListPrice=(
SELECT MIN(ListPrice) ListPrice
FROM Production.Product PP1
WHERE PP.ProductSubcategoryID=PP1.ProductSubcategoryID
)
ORDER BY ProductSubcategoryID

--2)Mostrar los productos y la cantidad total vendida de cada uno de ellos
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID, OrderQty

SELECT ProductID,SUM(OrderQty) AS Cantidad
FROM Sales.SalesOrderDetail
GROUP BY ProductID;


SELECT ProductID,AVG(OrderQty) AS Promedio
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

--3)Mostrar el promedio vendido por factura. 
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, LineTotal

SELECT SalesOrderID,AVG(LineTotal) AS Promedio
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;

----------------------------
-- HAVING
----------------------------
--1)Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado 
-- por número de factura  pero sólo de aquellas órdenes superen un total de $10.000 
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, LineTotal

SELECT SalesOrderID,SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal)>10000;

--2)Mostrar la cantidad de facturas que vendieron más de 20 unidades 
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, OrderQty

SELECT SalesOrderID,SUM(OrderQty) AS Total
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty)>20;

