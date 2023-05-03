M4- Laboratorios


---------------------------------------------------------------------------------------------------------

--SUBCONSULTAS

---------------------------------------------------------------------------------------------------------



--1)Listar todos las productos cuyo precio sea inferior al precio promedio de todos los productos

--tablas:Production.Product
--campos: Name, ListPrice

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice<(SELECTAVG(ListPrice)
FROMProduction.Product)
ORDER BY ListPrice DESC, name;


--2)Listar  el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto
--  y el valor promedio general

--tablas:Production.Product
--campos: Name, ListPrice

SELECT	Name producto, ListPrice [precio de lista], (SELECT AVG(ListPrice) 
FROM Production.Product) promedio, ListPrice - (SELECT AVG(ListPrice) 
FROM Production.Product)[diferencia de precio]
FROM	Production.Product;



--3)Mostrar el o los códigos del producto mas caro

--tablas:Production.Product
--campos: ProductID,ListPrice

SELECT ProductID,ListPrice
FROM Production.Product 
WHERE ListPrice = ( SELECT MAX(ListPrice) MAX_PRICE FROM Production.Product );


--4)Mostrar el producto más barato de cada subcategoría. mostrar subcategoría, código de producto

-- y el precio de lista más barato ordenado por subcategoría

--tablas:Production.Product
--campos: ProductSubcategoryID, ProductID, ListPrice

SELECT p1.ProductSubcategoryID, p1.ProductID, p1.ListPrice
FROM Production.Product p1
WHERE ListPrice = (SELECT MIN (ListPrice)
FROM Production.Product p2
WHERE p2.ProductSubcategoryID = p1.ProductSubcategoryID	)
ORDER BY p1.ProductSubcategoryID;





---------------------------------------------------------------------------------------------------------

--SUBCONSULTAS CON EXISTS - NOT EXISTS

---------------------------------------------------------------------------------------------------------



--1)Mostrar los nombres de todos los productos presentes en la subcategoría de ruedas 

--tablas:Production.Product, Production.ProductSubcategory

--campos: ProductSubcategoryID, Name

SELECT ProductSubcategoryID, Name
FROM Production.Product
WHERE EXISTS (SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID = Production.Product.ProductSubcategoryID AND Name like '%Wheels%')



--2)Mostrar todos los productos que no fueron vendidos

--tablas:Production.Product, Sales.SalesOrderDetail
--campos: Name, ProductID

SELECT	p.ProductID, p.Name producto
FROM Production.Product p
WHERE NOT EXISTS(SELECT 1 FROM Sales.SalesOrderDetail sod WHERE p.ProductID = sod.ProductID );



--3)Mostrar la cantidad de personas que no son vendedores 

--tablas: Person.Person, Sales.SalesPerson
--campos: BusinessEntityID 

SELECT COUNT(*) AS Cantidad 
FROM Person.Person p
WHERE NOT EXISTS( SELECT 1 FROM Sales.SalesPerson s WHERE p.BusinessEntityID  = s.BusinessEntityID );



--4)Mostrar todos los vendedores (nombre y apellido) que no tengan asignado un territorio de ventas 

--tablas: Person.Person, Sales.SalesPerson
--campos: BusinessEntityID, TerritoryID, LastName, FirstName

SELECT p.LastName apellido, p.FirstName nombre
FROM Person.Person p 
WHERE  EXISTS(SELECT 1
FROM Sales.SalesPerson AS sp
WHERE sp.BusinessEntityID = p.BusinessEntityID
AND sp.TerritoryID is null)

		



--------------------------------------------------------------------------------------------------------

--SUBCONSULTAS CON IN Y NOT IN

---------------------------------------------------------------------------------------------------------



--1)Mostrar las órdenes de venta que se hayan facturado en territorio de estado unidos

--únicamente 'us' 

--tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
--campos: CountryRegionCode, TerritoryID

SELECT	* FROM Sales.SalesOrderHeader s
WHERE s.TerritoryID IN ( SELECT t.TerritoryID FROM Sales.SalesTerritory t WHERE CountryRegionCode = 'US' );


--2)Al ejercicio anterior agregar ordenes de Francia e Inglaterra 

--tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
--campos: CountryRegionCode, TerritoryID

SELECT * FROM Sales.SalesOrderHeader s
WHERE s.TerritoryID IN (SELECT t.TerritoryID FROM Sales.SalesTerritory t WHERE CountryRegionCode IN ('US', 'FR', 'GB' ) );


--3)Mostrar los nombres de los diez productos más caros 

--tablas:Production.Product
--campos: ListPrice

SELECT	* FROM	Production.Product
WHERE ListPrice IN (SELECT TOP 10 ListPrice
FROM Production.Product
ORDER BY 1 DESC);



--4)Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20 

--tablas:Production.Product, Sales.SalesOrderDetail

--campos: Name, ProductID , OrderQty

SELECT	Name producto 
FROM	Production.Product 
WHERE	ProductID IN (SELECT ProductID 
FROM	Sales.SalesOrderDetail 
WHERE	OrderQty >=20 )
ORDER BY	Name;



---------------------------------------------------------------------------------------------------------

--SUBCONSULTAS CON ALL Y ANY

---------------------------------------------------------------------------------------------------------



--1)Mostrar los nombres de todos los productos de ruedas que fabrica adventure works cycles 

--tablas:Production.Product, Production.ProductSubcategory	

--campos: Name, ProductSubcategoryID

SELECT Name producto
FROM Production.Product
WHERE ProductSubcategoryID =ANY (SELECT	ProductSubcategoryID
FROM	Production.ProductSubcategory
WHERE	Name = 'Wheels');


    
--2)Mostrar los clientes ubicados en un territorio no cubierto por ningún vendedor 

--tablas:Sales.Customer, Sales.SalesPerson
--campos: TerritoryID

SELECT *
FROM Sales.Customer
WHERE TerritoryID <> ALL (SELECT TerritoryID
FROM Sales.SalesPerson);



--3)Listar los productos cuyos precios de venta sean mayores o iguales que el precio de venta 

--máximo de cualquier subcategoría de producto.

--tablas:Production.Product
--campos: Name, ListPrice, ProductSubcategoryID

SELECT Name producto
FROM Production.Product
WHERE ListPrice >= ANY (SELECT	MAX (ListPrice)
FROM Production.Product
GROUP BY ProductSubcategoryID)





####################################################################################################################

---------------------------------------------------------------------------------------------------------

---- INSERT, UPDATE Y DELETE

---------------------------------------------------------------------------------------------------------



--1)Clonar estructura y datos de los campos id, nombre, color y precio de lista de la tabla production.product en una tabla llamada Productos 

--tablas: Production.Product

--campos: Name, Color, ListPrice

SELECT ProductID, Name, Color, ListPrice
INTO Productos
FROM Production.Product



--2)Aumentar un 20% el precio de lista de todos los productos  

--tablas: Produccion

--campos: ListPrice

UPDATE	Productos

SET ListPrice = ListPrice * 1.2

				

--3)Aumentar un 20% el precio de lista de los productos del proveedor 1540 

--tablas:Produccion, Purchasing.ProductVendor

--campos: ProductID, ListPrice, BusinessEntityID

UPDATE	p 
SET ListPrice = ListPrice * 1.2
FROM Productos p
INNER JOIN Purchasing.ProductVendor v 
ON p.ProductID = v.ProductID 
WHERE	 v.BusinessEntityID = 1540



--4)Eliminar los productos cuyo precio es igual a cero

--tablas: Produccion

--campos: ListPrice

DELETE  

FROM Productos

WHERE ListPrice=0;



--5)Insertar un producto dentro de la tabla productos.tener en cuenta los siguientes datos. el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike" y el precio de lista debe ser de 4000 pesos.

--tablas:productos

--campos: Color,Name, ListPrice

INSERT INTO	productos(Color, Name,ListPrice)

VALUES ('Rojo', 'Bicicleta Mountain Bike', 4000);



--6)Aumentar en un 15% el precio de los pedales de bicicleta

--tablas: productos

--campos: Name, ListPrice

UPDATE productos 

SET ListPrice=ListPrice*1.15

WHERE name like'%pedal%';



--7)Eliminar de las productos cuyo nombre empiece con la letra m

--tablas: productos

--campos: Name

DELETE FROM productos 

WHERE Name LIKE 'm%';



--8)Borrar todo el contenido de la tabla personas sin utilizar la instrucción delete.

--tablas: productos

TRUNCATE TABLE productos;



--9)Eliminar tabla productos

--tablas: productos

DROP TABLE productos;