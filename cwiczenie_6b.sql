
--Wykorzystuj�c baz� danych stworzon� na poprzednich �wiczeniach wykonaj nast�puj�ce polecenia:
USE firma2;

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(14);

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(', SUBSTRING(telefon,1,3), ')', SUBSTRING(telefon,4,9));

SELECT telefon FROM ksiegowosc.pracownicy;

-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333�
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon,6,3), '-', SUBSTRING(telefon,9,3), '-', SUBSTRING(telefon,12,3));


-- c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter
SELECT TOP 1 
id_pracownika, UPPER(imie) as imie, UPPER(nazwisko) as nazwisko, UPPER(adres) as adres, telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

-- d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5
SELECT pr.id_pracownika,
		HASHBYTES('MD5', pr.imie) as imie, 
		HASHBYTES('MD5', pr.nazwisko) as nazwisko, 
		HASHBYTES('MD5', pr.adres) as adres, 
		HASHBYTES('MD5', convert(varchar(10), pe.kwota, 0)) as pensja
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji

-- f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.
SELECT *
FROM ksiegowosc.pracownicy as pr
LEFT JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as prem ON prem.id_premii = wyn.id_premii


-- g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu:
-- Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma� pensj� ca�kowit� na kwot� 7540 z�, 
-- gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�

SELECT 
		CONCAT(	'Pracownik ', pr.imie, ' ', pr.nazwisko, ', w dniu ', g.data, 
		' otrzyma� pensje ca�kowit� na kwote ',
		CASE WHEN g.liczba_godzin-160>0 
		THEN ISNULL(pm.kwota,0)+pe.kwota+(g.liczba_godzin-160)*20
		WHEN g.liczba_godzin-160<=0 THEN ISNULL(pm.kwota,0)+pe.kwota END,
		' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', pe.kwota, ' z�, premia: ', ISNULL(pm.kwota,0),
		' z�, nadgodziny: ',  
		CASE WHEN g.liczba_godzin-160>0  
		THEN (g.liczba_godzin-160)*20
		WHEN g.liczba_godzin-160<=0 THEN 0 END, 
		'z�') as raport
FROM ksiegowosc.pracownicy as pr
INNER JOIN ksiegowosc.wynagrodzenie as wyn ON pr.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja as pe ON pe.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia as pm ON pm.id_premii = wyn.id_premii
INNER JOIN ksiegowosc.godziny as g ON g.id_godziny = wyn.id_godziny


