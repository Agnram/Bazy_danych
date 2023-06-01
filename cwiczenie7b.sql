Use AdventureWorks2022;

--1. Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. 
-- Procedura musi przyjmowa� jako argument wej�ciowy liczb� n. 
-- Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja, wywo�ywana przez procedur�.

-- FUNKCJA
CREATE OR ALTER FUNCTION dbo.FibonacciFun (@n INT)
RETURNS @fib_tab TABLE
(
	liczba int 
)
AS
BEGIN
	DECLARE 
			@F0 INT = 0,
            @F1 INT = 1,
            @F2 INT,
			@i INT = 1;

	INSERT INTO @fib_tab VALUES (0);

	WHILE @n >= @i
	BEGIN
	  
      INSERT INTO @fib_tab VALUES (@F1);
	  SET @F2 = @F0 + @F1;
      SET @F0 = @F1
      SET @F1 = @F2
	  SET @i = @i + 1
	END

RETURN
END

--  Select * from dbo.FibonacciFun(1)

-- PROCEDURA
CREATE OR ALTER PROCEDURE dbo.FibonacciProc (@n INT)
AS
BEGIN
	SELECT * FROM dbo.FibonacciFun(@n);
END;


EXEC dbo.FibonacciProc @n=10;



--2. Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons 
--   zmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami.

CREATE OR ALTER TRIGGER UpperLastName
ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person SET LastName = UPPER(LastName)
END

INSERT INTO Person.Person (BusinessEntityID,PersonType,NameStyle,FirstName,
LastName, EmailPromotion) 
VALUES (20778,'EM',0,'Maria','Kot', 0)


--   SELECT * FROM Person.Person WHERE BusinessEntityID = 20778;


--3. Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie,
--   je�eli nast�pi zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%.

CREATE OR ALTER TRIGGER Sales.taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE 
	@TaxRate_0 SMALLMONEY,
	@TaxRate_1 SMALLMONEY;

	SELECT @TaxRate_0 = TaxRate FROM DELETED;
	SELECT @TaxRate_1 = TaxRate FROM INSERTED;

	IF @TaxRate_1 > 1.3*@TaxRate_0
	BEGIN
		RAISERROR('Przekroczono dopuszczaln� warto�� zmiany podatku!!!',19,1);
	END
END

UPDATE Sales.SalesTaxRate SET TaxRate = TaxRate*1.5

--   SELECT TaxRate FROM Sales.SalesTaxRate




