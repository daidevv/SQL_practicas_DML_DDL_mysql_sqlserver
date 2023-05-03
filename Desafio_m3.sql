-- M3-DESAFIOS

/* Ejercicio 1
Liste los apellidos y nombres de los representantes de ventas,  en orden alfabético por apellido.*/

SELECT p.LastName, p.FirstName, e.JobTitle  
FROM HumanResources.Employee AS e
JOIN Person.Person AS p 
ON e.BusinessEntityID = p.BusinessEntityID  
WHERE e.JobTitle = 'Sales Representative'
ORDER BY p.LastName

/*Ejercicio 2
Genere una lista de contactos y calcule cuántos hay de c/u,  
ordenados desde los más numerosos a los menos numerosos.*/

SELECT c.ContactTypeID, c.Name AS ContactTypeName, COUNT(*) AS N_contacts  
FROM Person.BusinessEntityContact AS bec
JOIN Person.ContactType AS c 
ON c.ContactTypeID = bec.ContactTypeID  
GROUP BY c.ContactTypeID, c.Name
ORDER BY COUNT(*) DESC


--Ejercicio 3
--3.1. Restrinja la lista del Lab anterior, sólo a aquellos contactos con  más de 100 ocurrencias.

SELECT c.ContactTypeID, c.Name AS ContactTypeName, COUNT(*) AS N_contacts
FROM Person.BusinessEntityContact AS bec
JOIN Person.ContactType AS c ON c.ContactTypeID = bec.ContactTypeID
GROUP BY c.ContactTypeID, c.Name
HAVING COUNT(*) > 100
ORDER BY COUNT(*) DESC

--3.2. Liste los nombres de los productos, junto a las reseñas que puedan tener.

SELECT p.Name Producto, pr.Comments Reseña, p.ProductID
FROM Production.Product p
LEFT JOIN Production.ProductReview pr 
ON p.ProductID = pr.ProductID


--3.3 Determine si el código de producto 718 tiene ventas con precio  menor al de lista.

SELECT DISTINCT p.Name Producto, p.ListPrice Precio, sd.UnitPrice 'Precio Vta'
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS p 
ON sd.ProductID = p.ProductID
AND sd.UnitPrice < p.ListPrice
WHERE p.ProductID = 718;

