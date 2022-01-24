/*
Date su sledeće relacione šeme:

Grad(Naziv, Drzava, BrojStanovnika)
Bioskop(BID, Ime, Naziv references Grad)
Sala(Broj, BID references Bioskop, Kapacitet)
Film(FID, Naslov, Trajanje)
Projekcija(PID, FID references Film, Broj references Sala, BID references Sala,
BrojGledalaca)

Napomena. Primarni ključevi su podvučeni. Atribut Naziv u relacionoj šemi Bioskop je spoljnji
ključ na relacionu šemu Grad i označava u kom gradu se nalazi bioskopo. Atribut BID u
relacionoj šemi Sala je spoljnji ključ na relacionu šemu Bioskop i označava u kom bioskopu
se sala nalazi. U relacionoj šemi Projekcija, atribut FID je spoljnji ključ na relacionu šemu Film
i označava koji film je prikazan u toku te projekcije, dok atributi Broj i BID u istoj šemi kao u
paru predstavljaju spoljni ključ na relaciju Sala i označavaju u kojoj sali je održana projekcija.
*/

-- Kreiranje tabela

CREATE TABLE Grad(
  Naziv varchar(50) NOT NULL PRIMARY KEY,
  Drzava varchar(50) NOT NULL,
  BrojStanovnika int
);

CREATE TABLE Bioskop(
  BID bigint NOT NULL PRIMARY KEY,
  Ime varchar(50) NOT NULL,
  Naziv varchar(50) NOT NULL,
  FOREIGN KEY(Naziv) REFERENCES Grad(Naziv)
);

CREATE TABLE Sala(
  Broj int NOT NULL,
  BID bigint NOT NULL,
  Kapacitet int,
  FOREIGN KEY(BID) REFERENCES Bioskop(BID),
  PRIMARY KEY(Broj, BID)
);

CREATE TABLE Film(
  FID bigint NOT NULL PRIMARY KEY,
  Naslov varchar(50) NOT NULL,
  Trajanje text
);

CREATE TABLE Projekcija (
    PID BIGINT NOT NULL PRIMARY KEY,
    FID BIGINT NOT NULL,
    Broj INT NOT NULL,
    BID BIGINT NOT NULL,
    BrojGledalaca INT,
    FOREIGN KEY (FID) REFERENCES Film (FID),
    FOREIGN KEY (Broj) REFERENCES Sala (Broj),
    FOREIGN KEY (BID) REFERENCES Sala (BID)
);

-- Zadaci za vjezbu

/*
1.
a) Izlistati naslove filmova, zajedno sa brojem različitih gradova u kojima su projektovani,
pod uslovom da je taj broj veći od 5.
b) Naći film koji je imao najveći broj projekcija.
c) Naći filmove koji su projektovani u svakom bioskopu.
d) Izlistati parove filmova koji su projektovani u istim salama.
e) Naći gradove u kojima se prikazivao film koji je do sada imao najveći broj projekcija.
f) Naći parove FID, BID tako da je film sa ključem FID bar 3 puta prikazan u bioskopu sa
ključem BID.
g) Naći grad u kom je održana najposjećenija projekcija nekog filma.
h) Naći film koji je u svakoj sali projektovan bar 2 puta.
i) Naći gradove u kojima su prikazani svi filmovi.
j) Odrediti u kom bioskopu se nalazi najposjećenija sala. Napomena: najposjećenija sala je
ona u kojoj je bio najveći broj gledalaca, gledano ukupno po svim projekcijama u njoj.
*/

-- b) Naći film koji je imao najveći broj projekcija.

SELECT f.naslov, COUNT(p.pid) 
FROM film AS f, projekcija AS p
WHERE f.fid = p.fid
GROUP BY f.fid
ORDER BY COUNT(p.pid)

-- c) Naći filmove koji su projektovani u svakom bioskopu.

SELECT *
FROM Film AS f, Bioskop AS b, Projekcija AS p 
WHERE p.fid = f.fid AND p.bid = b.bid

-- i) Naći gradove u kojima su prikazani svi filmovi.

SELECT g.naziv
FROM Grad AS g, Film AS f, Bioskop AS b, Projekcija AS p 
WHERE g.naziv = b.naziv AND p.fid = f.fid AND p.bid = b.bid

/*
2.
a) Naći sale koje imaju kapacitet veći od 50 mjesta.
b) Naći najveću salu.
c) Naći bioskope koji imaju više od jedne sale.
d) Naći bioskope u kojima je svaka projekcija imala više od 50 gledalaca.
e) Naći film koji je makar jednom projektovan u svakom bioskopu.
f) Naci najmanju salu.
*/

-- a) Naći sale koje imaju kapacitet veći od 50 mjesta.

SELECT * 
FROM sala 
WHERE kapacitet > 50

-- b) Naći najveću salu.

SELECT MAX(Kapacitet) 
FROM sala

-- f) Naci najmanju salu.

SELECT MIN(Kapacitet) 
FROM sala





