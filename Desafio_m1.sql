-- M1-DESAFIO

-- Resolución del ejercicio 1

-- 1.1. Recupere los diferentes tipos de contactos que son managers,  
-- ordenados alfabéticamente por nombre de z → a.


SELECT ContactTypeID, Name  
FROM Person.ContactType  
WHERE Name LIKE '%Manager%'  
ORDER BY Name DESC


-- 1.2. Recupere los datos indicados en el ejemplo de resultado anterior, 
-- de los  empleados con cargo de Gerente de Marketing o Senior Tool Designer.

SELECT BusinessEntityID, Gender, MaritalStatus, JobTitle  
FROM [HumanResources].[Employee]
WHERE JobTitle IN ('Marketing Manager', 'Senior Tool Designer')

-- Resolución del ejercicio 2
-- 2.1 Recuperar datos de los productos con color y tamaño  informado, según el ejemplo:


SELECT	Name, Size, Color
FROM Production.Product  
WHERE Size IS NOT NULL AND Color IS NOT NULL;

SELECT	Name, Size, Color
FROM Production.Product  
WHERE Size IS  NULL AND Color IS  NULL;


-- Resolución del ejercicio 3
-- 3.1. Liste datos de la facturación de los meses de 06/2011 y  07/2011, 
-- respetando la salida de ejemplo:

SELECT SalesOrderID #factura, OrderDate fecha, TotalDue total  
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-06-01' AND '2011-07-31'


-- 3.2. A los datos de la facturación de los meses de 06/2011 y 07/2011,
-- obtenidos  agréguele el cálculo de 21% de IVA.

SELECT SalesOrderID #factura, OrderDate fecha, TotalDue total, TotalDue * .21 IVA  
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-06-01' AND '2011-07-31'


