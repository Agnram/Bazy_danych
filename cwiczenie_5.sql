USE firma2;

-- 1. Utworzenie nowej bazy danych
CREATE DATABASE firma2;

-- 2. Dodanie nowego schematu
CREATE SCHEMA ksiegowosc;

-- 4. Dodanie tabel do schematu rozliczenia
CREATE TABLE ksiegowosc.pracownicy (

id_pracownika INT PRIMARY KEY,
imie NVARCHAR(50) NOT NULL,
nazwisko NVARCHAR(55) NOT NULL,
adres NVARCHAR(100) NOT NULL,
telefon CHAR(12)

);


CREATE TABLE ksiegowosc.godziny (

id_godziny INT PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin SMALLINT NOT NULL,
id_pracownika INT FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika) NOT NULL
);


CREATE TABLE ksiegowosc.pensja (
id_pensji INT PRIMARY KEY,
stanowisko NVARCHAR(25) NOT NULL,
kwota MONEY NOT NULL,
);

CREATE TABLE ksiegowosc.premia (
id_premii INT PRIMARY KEY,
rodzaj NVARCHAR(20),
kwota SMALLMONEY NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenie(
id_wynagrodzenia INT PRIMARY KEY,
data DATE NOT NULL,
id_pracownika INT FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika) NOT NULL,
id_godziny INT FOREIGN KEY REFERENCES ksiegowosc.godziny(id_godziny) NOT NULL,
id_pensji INT FOREIGN KEY REFERENCES ksiegowosc.pensja(id_pensji) NOT NULL,
id_premii INT FOREIGN KEY REFERENCES ksiegowosc.premia(id_premii) NULL
);

-- dodanie komentarzy do tabel
EXEC sys.sp_addextendedproperty 
    @name=N'tabela pracownicy', 
    @value=N'tabela zawierajaca informacje o pracownikach' ,
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'pracownicy' ;

	EXEC sys.sp_addextendedproperty 
    @name=N'tabela godziny', 
    @value=N'tabela zawierajaca informacje o godzinach pracy' ,
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'godziny' ;

	EXEC sys.sp_addextendedproperty 
    @name=N'tabela pensja', 
    @value=N'tabela zawierajaca informacje o pensjach' ,
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'pensja'; 

	EXEC sys.sp_addextendedproperty 
    @name=N'tabela premia', 
    @value=N'tabela zawierajaca informacje o premiach' ,
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'premia';

	EXEC sys.sp_addextendedproperty 
    @name=N'tabela wynagrodzenie', 
    @value=N'tabela zawierajaca informacje o wynagrodzeniach' ,
    @level0type=N'SCHEMA',
    @level0name=N'ksiegowosc', 
    @level1type=N'TABLE',
    @level1name=N'wynagrodzenie' 

-- 5. Wype³nienie tabel rekordami
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES 
(1, 'Anna', 'Kot', 'Kocia 15, 11-111 Kotow', '+48928027098'),
(2, 'Hanna', 'Kura', 'Kocia 18, 11-111 Kotow', '+48928027091'),
(3, 'Joanna', 'Kaczka', 'Kocia 215, 11-111 Kotow', '+48928023098'),
(4, 'Marianna', 'Koñ', 'Mleczna 11b, 11-111 Kotow', '+48928027028'),
(5, 'Maria', 'Koniczyna', 'Mleczna 11a, 11-111 Kotow', '+48928027198'),
(6, 'Marian', 'Stokrotka', 'Mleczna 21, 11-111 Kotow', '+48928017098'),
(7, 'Marcin', 'B³awatek', 'Mleczna 15, 11-111 Kotow', '+48328027098'),
(8, 'Mariusz', 'Las', 'Rybia 222, 11-111 Kotow', '+48228027098'),
(9, 'Mateusz', 'Rzeka', 'Rybia 54 11-111 Kotow', 'NULL'),
(10, 'Tadeusz', 'Dolina', 'Wielorybia 84, 11-110 Wielorybow', 'NULL')


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES 
(1, '2023-04-08', 200, 1),
(2, '2023-04-08', 87, 2),
(3, '2023-04-08', 100, 3),
(4, '2023-04-09', 13, 4),
(5, '2023-04-09', 165, 5),
(6, '2023-04-09', 104, 6),
(7, '2023-04-10', 20, 7),
(8, '2023-04-10', 176, 8),
(9, '2023-04-10', 54, 9),
(10, '2023-04-11', 54, 10)


INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
(1, NULL, 1000),
(2, NULL, 1000),
(3, NULL, 1000),
(4, NULL, 2000),
(5, NULL, 2000),
(6, NULL, 2000),
(7, NULL, 400),
(8, NULL, 400),
(9, NULL, 400),
(10, NULL, 800)


INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES 
(1, 'kierownik', 7000),
(2, 'kierownik', 8000),
(3, 'operator maszyn', 2500),
(4, 'operator maszyn', 900),
(5, 'operator maszyn', 1700),
(6, 'elektryk', 5000),
(7, 'elektryk', 3000),
(8, 'mechanik', 1300),
(9, 'mechanik', 950),
(10, 'sekretarz', 1800)

INSERT INTO ksiegowosc.wynagrodzenie ( id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2023-04-20', 1, 1, 1, 1),
(2, '2023-04-21', 2, 2, 2, 3),
(3, '2023-04-21', 3, 3, 3, 5),
(4, '2023-04-21', 4, 4, 4, 7),
(5, '2023-04-22', 5, 5, 5, 9),
(6, '2023-04-22', 6, 6, 6, NULL),
(7, '2023-04-22', 7, 7, 7, NULL),
(8, '2023-04-22', 8, 8, 8, NULL),
(9, '2023-04-23', 9, 9, 9, NULL),
(10, '2023-04-23', 10, 10, 10, NULL)



-- 6. a) Wyœwietl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika,imie FROM ksiegowosc.pracownicy

-- b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.
SELECT pr.id_pracownika 
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
WHERE pe.kwota > 1000

-- c) Wyœwietl id pracowników nieposiadaj¹cych premii, których p³aca jest wiêksza ni¿ 2000.
SELECT pr.id_pracownika 
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as prem ON prem.id_premii = wyn.id_premii
WHERE wyn.id_premii IS NULL
AND pe.kwota > 2000

-- d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’.
SELECT * FROM ksiegowosc.pracownicy
WHERE ksiegowosc.pracownicy.imie LIKE 'J%';

-- e) Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.
SELECT * FROM ksiegowosc.pracownicy as pr
WHERE pr.nazwisko LIKE '%n%' AND pr.imie LIKE '%a';

-- f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, 
--    i¿ standardowy czas pracy to 160 h miesiêcznie.
SELECT pr.imie, pr.nazwisko, godz.liczba_godzin-160 AS liczba_nadgodzin
FROM ksiegowosc.godziny as godz
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON godz.id_godziny = wyn.id_godziny
INNER JOIN ksiegowosc.pracownicy as pr ON pr.id_pracownika = wyn.id_pracownika
WHERE godz.liczba_godzin>160

-- g) Wyœwietl imiê i nazwisko pracowników, 
--    których pensja zawiera siê w przedziale 1500 – 3000 PLN.
SELECT pr.imie,pr.nazwisko
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
WHERE pe.kwota < 3000
AND pe.kwota > 1500;

-- h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT pr.imie,pr.nazwisko
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.godziny as godz ON godz.id_godziny = wyn.id_wynagrodzenia
LEFT JOIN ksiegowosc.premia as prem ON prem.id_premii = wyn.id_premii
WHERE wyn.id_premii IS NULL
AND (godz.liczba_godzin > 160);

-- i) Uszereguj pracowników wed³ug pensji.
SELECT pr.*, pe.kwota 
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
ORDER BY pe.kwota;

-- j) Uszereguj pracowników wed³ug pensji i premii malej¹co.
SELECT pr.*, pe.kwota AS kwota_pensji, prem.kwota AS kwota_premii
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as prem ON prem.id_premii = wyn.id_premii
ORDER BY pe.kwota,prem.kwota DESC;

-- k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’.
SELECT pe.stanowisko, COUNT(pe.stanowisko) AS ilosc_pracownikow
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
GROUP BY pe.stanowisko;

-- l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ 
SELECT AVG(pr.kwota + pe.kwota) AS srednia, 
MIN(pr.kwota + pe.kwota) AS minimalna_placa, 
MAX(pr.kwota + pe.kwota) AS maksymalna_placa
FROM ksiegowosc.wynagrodzenie as wyn
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as pr ON pr.id_premii = wyn.id_premii
WHERE pe.stanowisko = 'kierownik';

-- m) Policz sumê wszystkich wynagrodzeñ.
SELECT SUM(pr.kwota + pe.kwota) as suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie as wyn
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
INNER JOIN ksiegowosc.premia as pr ON pr.id_premii = wyn.id_premii


-- f/n) Policz sumê wynagrodzeñ w ramach danego stanowiska.
SELECT stanowisko, (SUM(pe.kwota) + SUM(ISNULL(pr.kwota,0)) )as suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie as wyn
LEFT OUTER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT OUTER JOIN ksiegowosc.premia as pr ON pr.id_premii = wyn.id_premii
GROUP BY stanowisko;

-- g/o) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.
SElECT pe.stanowisko, COUNT(PREM.kwota) as liczba_premii
FROM ksiegowosc.premia as prem 
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON prem.id_premii = wyn.id_premii
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
GROUP BY pe.stanowisko;



