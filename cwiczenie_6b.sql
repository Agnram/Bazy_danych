
--Wykorzystuj¹c bazê danych stworzon¹ na poprzednich æwiczeniach wykonaj nastêpuj¹ce polecenia:
USE firma2;

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(14);

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(', SUBSTRING(telefon,1,3), ')', SUBSTRING(telefon,4,9));

SELECT telefon FROM ksiegowosc.pracownicy;

-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon,6,3), '-', SUBSTRING(telefon,9,3), '-', SUBSTRING(telefon,12,3));


-- c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter
SELECT TOP 1 
id_pracownika, UPPER(imie) as imie, UPPER(nazwisko) as nazwisko, UPPER(adres) as adres, telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

-- d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
SELECT pr.id_pracownika,
		HASHBYTES('MD5', pr.imie) as imie, 
		HASHBYTES('MD5', pr.nazwisko) as nazwisko, 
		HASHBYTES('MD5', pr.adres) as adres, 
		HASHBYTES('MD5', convert(varchar(10), pe.kwota, 0)) as pensja
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji

-- f) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.
SELECT *
FROM ksiegowosc.pracownicy as pr
LEFT JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as prem ON prem.id_premii = wyn.id_premii


-- g) wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg poni¿szego szablonu:
-- Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, 
-- gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³

SELECT 
		CONCAT(	'Pracownik ', pr.imie, ' ', pr.nazwisko, ', w dniu ', g.data, 
		' otrzyma³ pensje ca³kowit¹ na kwote ', ISNULL(pm.kwota,0)+pe.kwota, 
		' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pe.kwota, ' z³, premia: ', pm.kwota,
		' z³, nadgodziny: 0 z³') as raport
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as pm ON pm.id_premii = wyn.id_premii
INNER JOIN ksiegowosc.godziny as g ON g.id_godziny = wyn.id_godziny


