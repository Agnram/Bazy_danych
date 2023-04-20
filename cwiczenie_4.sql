
USE firma;

-- 1. Utworzenie nowej bazy danych
CREATE DATABASE firma;

-- 2. Dodanie nowego schematu
CREATE SCHEMA rozliczenia;

-- 3.a) b) c) Dodanie tabeli do schematu rozliczenia
CREATE TABLE rozliczenia.pracownicy (

id_pracownika INT PRIMARY KEY,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(55) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon CHAR(12)
);

CREATE TABLE rozliczenia.godziny (

id_godziny INT PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin SMALLINT NOT NULL,
id_pracownika INT NOT NULL
);


CREATE TABLE rozliczenia.pensje (
id_pensji INT PRIMARY KEY,
stanowisko VARCHAR(25) NOT NULL,
kwota MONEY NOT NULL,
id_premii INT
);

CREATE TABLE rozliczenia.premie (
id_premii INT PRIMARY KEY,
rodzaj VARCHAR(20),
kwota MONEY NOT NULL
);

-- 3.d) Dodanie kluczy obcych
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);


-- 4. Wprowadzanie danych do tabeli
INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES 
(1, 'Anna', 'Kot', 'Kocia 15, 11-111 Kotow', '+48928027098'),
(2, 'Hanna', 'Kaczka', 'Kocia 18, 11-111 Kotow', '+48928027091'),
(3, 'Joanna', 'Kura', 'Kocia 215, 11-111 Kotow', '+48928023098'),
(4, 'Iza', 'Krowa', 'Mleczna 11b, 11-111 Kotow', '+48928027028'),
(5, 'Ewa', 'Kangur', 'Mleczna 11a, 11-111 Kotow', '+48928027198'),
(6, 'Maria', 'Kakadu', 'Mleczna 21, 11-111 Kotow', '+48928017098'),
(7, 'Marian', 'Cokolwiek', 'Mleczna 15, 11-111 Kotow', '+48328027098'),
(8, 'Marianna', 'Zwierze', 'Rybia 222, 11-111 Kotow', '+48228027098'),
(9, 'Marcin', 'Drzewo', 'Rybia 54 11-111 Kotow', '+48928227098'),
(10, 'Mariusz', 'Kowalik', 'Wielorybia 84, 11-110 Wielorybow', '+48028027098')


INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES 
(1, '2023-04-08', 3, 3),
(2, '2023-04-08', 9, 2),
(3, '2023-04-08', 10, 8),
(4, '2023-04-09', 5, 9),
(5, '2023-04-09', 10, 10),
(6, '2023-04-09', 4, 1),
(7, '2023-04-10', 2, 1),
(8, '2023-04-10', 6, 6),
(9, '2023-04-10', 5, 5),
(10, '2023-04-11', 3, 3)



INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
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


INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES 
(1, 'kierownik', 7000, 3),
(2, 'kierownik', 8000, 1),
(3, 'operator maszyn', 7000, 3),
(4, 'operator maszyn', 1900, 2),
(5, 'operator maszyn', 7000, 3),
(6, 'elektryk', 5000, 2),
(7, 'elektryk', 7000, NULL),
(8, 'mechanik', 1900, NULL),
(9, 'mechanik', 5000, NULL),
(10, 'mechanik', 1900, NULL)

-- 5. Wyœwietlenie nazwisk pracowników oraz ich adresów
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- 6. Przekonwertowanie daty z tabeli godziny
SELECT DATEPART(WEEKDAY, data) as dzien_tygodnia,
	   DATEPART(MONTH, data) as miesiac
FROM rozliczenia.godziny;

-- 7. Zmiana nazwy atrybutu kwota na kwota_brutto oraz dodanie nowego o nazwie kwota_netto
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje
ADD kwota_netto as (pensje.kwota_brutto * 0.80);

SELECT * FROM rozliczenia.pensje;