------------------- utworzenie schematu i tabel -------------------------
CREATE SCHEMA geo;

CREATE TABLE geo.Eon(

id_eon INT PRIMARY KEY,
nazwa_eon VARCHAR(20) NOT NULL
);

CREATE TABLE geo.Era(

id_era	INT PRIMARY KEY,
id_eon	INT REFERENCES geo.Eon(id_eon),
nazwa_era VARCHAR(20) NOT NULL
);

CREATE TABLE geo.Okres(

id_okres	INT PRIMARY KEY,
id_era		INT REFERENCES geo.Era(id_era),
nazwa_okres VARCHAR(20) NOT NULL
);

CREATE TABLE geo.Epoka(

id_epoka	INT PRIMARY KEY,
id_okres	INT REFERENCES geo.Okres(id_okres),
nazwa_epoka VARCHAR(20) NOT NULL
);

CREATE TABLE geo.Pietro(

id_pietro	INT PRIMARY KEY,
id_epoka	INT REFERENCES geo.Epoka(id_epoka),
nazwa_pietro VARCHAR(20) NOT NULL
);

----------------------------- uzupelnienie tabel ----------------------------------

INSERT INTO geo.Eon Values(1, 'Fanerozoik');

INSERT INTO geo.Era Values
(1, 1, 'Kenzoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Paleozoik');

INSERT INTO geo.Okres Values
(1, 1, 'Czwartorzad'),
(2, 1, 'Neogen'),
(3, 1, 'Paleogen'),
(4, 2, 'Kreda'),
(5, 2, 'Jura'),
(6, 2, 'Trias'),
(7, 3, 'Perm'),
(8, 3, 'Karbon'),
(9, 3, 'Dewon');

INSERT INTO geo.Epoka Values
(1, 1, 'Holocen'),
(2, 1, 'Plejstocen'),
(3, 2, 'Pliocen'),
(4, 2, 'Miocen'),
(5, 3, 'Oligocen'),
(6, 3, 'Eocen'),
(7, 4, 'Gorna'),
(8, 4, 'Dolna'), 
(9, 5, 'Gorna'),
(10, 5, 'Srodkowa'),
(11, 5, 'Dolna'),
(12, 6, 'Gorna'),
(13, 6, 'Srodkowa'),
(14, 6, 'Dolna'),
(15, 7, 'Gorny'), 
(16, 7, 'Dolny'), 
(17, 8, 'Gorny'), 
(18, 8, 'Dolny'),
(19, 9, 'Gorny'),
(20, 9, 'Srodkowy'),
(21, 9, 'Dolny'), 
(22, 3, 'Paleocen');

INSERT INTO geo.Pietro Values
(1, 1, 'megalaj'),
(2, 1, 'northgrip'),
(3, 1, 'grenland'),
(4, 2, 'pozny'),
(5, 2, 'chiban'),
(6, 2, 'kalabr'),
(7, 2, 'gelas'),
(8, 3, 'piacent'),
(9, 3, 'zanki'),
(10, 4, 'messyn'),
(11, 4, 'messyn'),
(12, 4, 'serrawal'),
(13, 4, 'lang'),
(14, 4, 'burdygal'),
(15, 4, 'akwitan'),
(16, 5, 'szat'),
(17, 5, 'rupel'),
(18, 6, 'priabon'),
(19, 6, 'barton'),
(20, 6, 'lulet'),
(21, 6, 'ipez'),
(22, 22, 'tanet'),
(23, 22, 'zeland'),
(24, 22, 'dan'),
(25, 7, 'mastych'),
(26, 7, 'kampan'),
(27, 7, 'santon'),
(28, 7, 'koniak'),
(29, 7, 'turon'),
(30, 7, 'alb'),
(31, 8, 'apt'),
(32, 8, 'barrem'),
(33, 8, 'hoteryt'),
(34, 8, 'walazyn'),
(35, 8, 'berrias'),
(36, 9, 'tyton'),
(37, 9, 'kimeryd'),
(38, 9, 'oksford'),
(40, 10, 'kelowej'),
(41, 10, 'baton'),
(42, 10, 'bajos'),
(43, 10, 'aalen'),
(44, 11, 'toark'),
(45, 11, 'pliensbach'),
(46, 11, 'synemur'),
(47, 11, 'hettang'),
(48, 12, 'retyk'),
(49, 12, 'noryk'),
(50, 12, 'karnik'),
(51, 13, 'ladyn'),
(52, 13, 'anizyk'),
(53, 14, 'olenek'),
(54, 14, 'ind'),
(55, 15, 'czansing'),
(56, 15, 'wuczanping'),
(57, 16, 'kungur'),
(58, 16, 'artinsk'),
(59, 16, 'sakmar'),
(60, 16, 'assel'),
(61, 17, 'kasminow'),
(62, 17, 'moskow'),
(63, 17, 'baszjir'),
(64, 18, 'serpuchow'),
(65, 18, 'wizen'),
(66, 18, 'turnej'),
(67, 19, 'famen'),
(68, 19, 'fran'),
(69, 20, 'zywet'),
(70, 20, 'eifel'),
(71, 21, 'esm'),
(72, 21, 'prag'),
(73, 21, 'lokchow');

--------------------------- Utworzenie geo.Tabeli --------------------------------

CREATE TABLE geo.Tabela AS (SELECT * FROM geo.Pietro NATURAL JOIN geo.Epoka NATURAL
JOIN geo.Okres NATURAL JOIN geo.Era NATURAL JOIN geo.Eon );

ALTER TABLE geo.Tabela
ADD PRIMARY KEY (id_pietro);

----------------------------- Utworzenie tabel liczb ---------------------------------

CREATE TABLE geo.Dziesiec(
cyfra INT PRIMARY KEY
);

INSERT INTO geo.Dziesiec Values
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0);


CREATE TABLE geo.Milion(liczba int,cyfra int);
INSERT INTO geo.Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra
FROM geo.Dziesiec a1, geo.Dziesiec a2, geo.Dziesiec a3, geo.Dziesiec a4, 
geo.Dziesiec a5, geo.Dziesiec a6 ;


--------------------------- dodawanie indeksow ------------------------------

CREATE INDEX indx_eon ON geo.Eon(id_eon);
CREATE INDEX indx_era ON geo.Era(id_era);
CREATE INDEX indx_epoka ON geo.Epoka(id_epoka);
CREATE INDEX indx_okres ON geo.Okres(id_okres);
CREATE INDEX indx_pietro ON geo.Pietro(id_pietro);
CREATE INDEX indx_tabela ON geo.Tabela(id_pietro);

CREATE INDEX indx_liczba ON geo.Milion(liczba);
CREATE INDEX indx_cyfra ON geo.Dziesiec(cyfra);

CREATE INDEX indx_T ON geo.Tabela(id_eon, id_era, id_okres, id_epoka);

--------------------------- usuwanie indeksow ---------------------------------

SET search_path = geo

DROP INDEX indx_eon;
DROP INDEX indx_era ;
DROP INDEX indx_epoka;
DROP INDEX indx_okres;
DROP INDEX indx_pietro;
DROP INDEX indx_tabela;

DROP INDEX indx_liczba;
DROP INDEX indx_cyfra;

DROP INDEX indx_T;
-------------------------------- test 1 ZL -----------------------------------
SELECT COUNT(*) FROM geo.Milion INNER JOIN geo.Tabela ON
(mod(geo.Milion.liczba,68)=(geo.Tabela.id_pietro));

-------------------------------- test 2 ZL -----------------------------------
SELECT COUNT(*) FROM geo.Milion 
INNER JOIN geo.Pietro ON (mod(geo.Milion.liczba,68)=geo.Pietro.id_pietro) 
NATURAL JOIN geo.Epoka NATURAL JOIN geo.Okres 
NATURAL JOIN geo.Era NATURAL JOIN geo.Eon;

-------------------------------- test 3 ZG -----------------------------------
SELECT COUNT(*) FROM geo.Milion WHERE mod(geo.Milion.liczba,68)=
(SELECT id_pietro FROM geo.Tabela WHERE mod(geo.Milion.liczba,68)=(id_pietro));

-------------------------------- test 4 ZG -----------------------------------
SELECT COUNT(*) FROM geo.Milion WHERE mod(geo.Milion.liczba,68)IN
(SELECT geo.Pietro.id_pietro FROM geo.Pietro 
 NATURAL JOIN geo.Epoka NATURAL JOIN geo.Okres 
 NATURAL JOIN geo.Era NATURAL JOIN geo.Eon);




