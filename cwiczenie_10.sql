--Przetwarzanie transakcyjne
-- Wykorzystuj¹c SQL Server i bazê AdventureWorks rozwi¹¿ poni¿sze zadania.
USE AdventureWorks2022;

--1. Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), 
--   a nastêpnie aktualizuje cenê produktu o ProductID równym 680 
--   w tabeli Production.Product o 10% i nastêpnie zatwierdza transakcjê.

BEGIN TRANSACTION;

UPDATE Production.Product SET ListPrice = ListPrice*1.1
WHERE ProductID = 680;

COMMIT;

--2. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt 
--   o ProductID równym 707 z tabeli Production.Product,
--   ale nastêpnie wycofuje transakcjê.

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

BEGIN TRANSACTION;

DELETE pr
FROM Production.Product as pr
WHERE ProductID = 707;

ROLLBACK;

-- SELECT * FROM Production.Product WHERE ProductID = 707;

--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--   Production.Product, a nastêpnie zatwierdza transakcjê.


BEGIN TRANSACTION;
SET IDENTITY_INSERT Production.Product  ON;
INSERT INTO Production.Product 
(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,
SafetyStockLevel, ReorderPoint, StandardCost,ListPrice,DaysToManufacture,
ProductLine,ProductSubcategoryID, ProductModelID,SellStartDate,ModifiedDate)
VALUES (1000, 'produkt 1', 'KJ-Y678-p', 0, 1, 'Blue', 8, 2, 10, 20, 0, 'A',
11, 22, 2011-05-31, 2014-02-08)
SET IDENTITY_INSERT Production.Product  OFF;
COMMIT;

-- SELECT COUNT(ProductID) FROM Production.Product;

--4. Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost
--   wszystkich produktów w tabeli Production.Product o 10%, 
--   je¿eli suma wszystkich StandardCost po aktualizacji nie przekracza 50000. 
--   W przeciwnym razie zapytanie powinno wycofaæ transakcjê.

BEGIN TRANSACTION;

UPDATE Production.Product SET StandardCost = StandardCost*1.1;
DECLARE @suma FLOAT;
SELECT @suma = SUM(StandardCost) FROM Production.Product;

IF @suma <= 50000
BEGIN
	COMMIT;
END
ELSE
BEGIN
	PRINT('Wycofano transakcjê');
	ROLLBACK;
END

-- SELECT SUM(StandardCost) FROM Production.Product;

--5. Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt 
--   do tabeli Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, 
--   zapytanie powinno wycofaæ transakcjê.

BEGIN TRANSACTION;

IF NOT EXISTS (SELECT * FROM Production.Product WHERE ProductNumber = 'KJ-Y678-Q')
BEGIN
	SET IDENTITY_INSERT Production.Product  ON;
	INSERT INTO Production.Product 
(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,
SafetyStockLevel, ReorderPoint, StandardCost,ListPrice,DaysToManufacture,
ProductLine,ProductSubcategoryID, ProductModelID,SellStartDate,ModifiedDate)
	VALUES (1000, 'nowy produkt', 'KJ-Y678-Q', 0, 1, 'Blue', 8, 2, 10, 20, 0, 'A',
11, 22, 2011-05-31, 2014-02-08)
	SET IDENTITY_INSERT Production.Product  OFF;
	PRINT('Dodano nowy produkt')
	COMMIT;
END

ELSE
BEGIN
	PRINT('Wycofano transakcjê');
	ROLLBACK;
END


--6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ 
--   OrderQty dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail.
--	 Je¿eli którykolwiek z zamówieñ ma OrderQty równ¹ 0, 
--   zapytanie powinnowycofaæ transakcjê.

BEGIN TRANSACTION;

DECLARE @zero INT;
SELECT @zero = COUNT(OrderQty) FROM Sales.SalesOrderDetail WHERE OrderQty-1 = 0;

IF @zero = 0
BEGIN
	UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty-1;
	COMMIT;
END
ELSE
BEGIN
	PRINT('Wycofano transakcjê');
	ROLLBACK;
END

--   SELECT OrderQty FROM Sales.SalesOrderDetail

--7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty,
--   których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów 
--   w tabeli Production.Product. Je¿eli liczba produktów do usuniêcia 
--   przekracza 10, zapytanie powinno wycofaæ transakcjê

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

BEGIN TRANSACTION;

DECLARE @do_usuniecia INT, @srednia FLOAT;
SELECT @srednia = AVG(StandardCost) FROM Production.Product;
SELECT @do_usuniecia = COUNT(StandardCost) FROM Production.Product
WHERE StandardCost > @srednia;

IF @do_usuniecia < 10
BEGIN
	DELETE 
	FROM Production.Product WHERE StandardCost > @srednia
END

ELSE
BEGIN
	PRINT('Wycofano transakcjê');
	ROLLBACK;
END;

