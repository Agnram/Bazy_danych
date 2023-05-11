-- 1. Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki pracownika oraz jego danych,
--    a nast�pnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi�� w oparciu o AdventureWorks.
USE AdventureWorks2022;

WITH exp1 AS ( 
	SELECT NationalIDNumber, LoginID, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, VacationHours, SickLeaveHours, Rate
	FROM HumanResources.Employee AS em
	INNER JOIN HumanResources.EmployeePayHistory AS ph ON em.BusinessEntityID = ph.BusinessEntityID
	)
SELECT * INTO #TempEmployeeInfo
FROM exp1;

SELECT * FROM #TempEmployeeInfo;

DROP TABLE #TempEmployeeInfo;

-- 2. Uzyskaj informacje na temat przychod�w ze sprzeda�y wed�ug firmy i kontaktu 
--    (za pomoc� CTE i bazy AdventureWorksL).
USE AdventureWorksLT2022;

WITH exp2 AS (
	SELECT CONCAT(c.CompanyName, ' (', c.FirstName, ' ', c.LastName, ')') AS CompanyContact,
	sh.TotalDue AS Revenue
	FROM SalesLT.Customer as c
	INNER JOIN  SalesLT.SalesOrderHeader as sh ON sh.CustomerID = c.CustomerID
	)
SELECT * FROM exp2
ORDER BY CompanyContact;

-- 3. Napisz zapytanie, kt�re zwr�ci warto�� sprzeda�y dla poszczeg�lnych kategorii produkt�w.
--    Wykorzystaj CTE i baz� AdventureWorksLT.
	
WITH exp3 AS (
	SELECT pc.Name as Category, sd.LineTotal as SalesValues
	FROM SalesLT.ProductCategory as pc
	INNER JOIN SalesLT.Product as pr ON pr.ProductCategoryID = pc.ProductCategoryID
	INNER JOIN SalesLT.SalesOrderDetail as sd ON sd.ProductID = pr.ProductID
	)
SELECT Category, SUM(SalesValues) AS SalesValues FROM exp3
GROUP BY Category
ORDER BY Category



	