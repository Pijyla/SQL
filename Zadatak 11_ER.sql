CREATE TABLE Zaposleni(
JMBG bigint NOT NULL PRIMARY KEY,
ime varchar(50),
prezime varchar(50),
datum_zaposljavanja date,
radni_staz int
);

CREATE TABLE Vozaci(
JMBG bigint NOT NULL,
broj_sati_voznje int,
FOREIGN KEY (JMBG) REFERENCES Zaposleni(JMBG)
);

CREATE TABLE Godisnji_medicinski_pregled(
JMBG bigint NOT NULL,
nalaz text,
datum date,
FOREIGN KEY (JMBG) REFERENCES Vozaci(JMBG)
);

CREATE TABLE Tip_vozila(
ID bigint NOT NULL PRIMARY KEY
);

CREATE TABLE Vozi(
JMBG bigint NOT NULL,
ID bigint NOT NULL,
FOREIGN KEY (JMBG) REFERENCES Vozaci(JMBG),
FOREIGN KEY (ID) REFERENCES Tip_vozila(ID)
);

CREATE TABLE Vozovi(
Registracija bigint NOT NULL PRIMARY KEY,
dozvoljen_broj_vagona int,
godina_proizvodnje year
);

CREATE TABLE Red_voznje(
ID bigint NOT NULL PRIMARY KEY,
datum_polaska date,
vrijeme_polaska time,
JMBG bigint NOT NULL,
obicna_mjesta int,
vip_mjesta int,
cijena_karte decimal(10,2),
cijena_vip_karte decimal(10,2),
FOREIGN KEY (JMBG) REFERENCES Zaposleni(JMBG)
);

CREATE TABLE Kreira_red_voznje(
JMBG bigint NOT NULL,
datum_kreiranja date,
FOREIGN KEY (JMBG) REFERENCES Zaposleni(JMBG)
);

CREATE TABLE Karte(
broj_karte bigint NOT NULL PRIMARY KEY,
datum_prodaje date,
ime_kupca varchar(50),
prezime_kupca varchar(50),
cijena_karte decimal(10,2)
);

CREATE TABLE Putnici(
broj_karte bigint NOT NULL,
ID bigint NOT NULL,
FOREIGN KEY (broj_karte) REFERENCES Karte(broj_karte),
FOREIGN KEY (ID) REFERENCES Red_voznje(ID)
);
