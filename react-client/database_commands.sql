CREATE TABLE asiakas (
astunnus SMALLINT(6) PRIMARY KEY,
asnimi VARCHAR(30) NOT NULL,
asosoite VARCHAR(30),
aspostitoimipaikka VARCHAR(10),
aspuhelinnumero INT(13) NOT NULL,    
aspostinro CHAR(5)    
);

CREATE TABLE yritys (
astunnus SMALLINT(6) PRIMARY KEY,
lisatiedot VARCHAR(70),
FOREIGN KEY (astunnus)
REFERENCES asiakas (astunnus)
);


CREATE TABLE yksityishlo (
astunnus SMALLINT(6) PRIMARY KEY,
lisatiedot VARCHAR(70),
FOREIGN KEY (astunnus) 
REFERENCES asiakas (astunnus));

CREATE TABLE tuote (
tuotenro INT(10) PRIMARY KEY,
tuotenimi VARCHAR(50) NOT NULL,
tuotehinta DECIMAL(5,2) NOT NULL,
kustannus DECIMAL(5,2)
 );

 CREATE TABLE tilaus (
tilausnro INT(10) PRIMARY KEY, 
astunnus SMALLINT(6) NOT NULL,
tila CHAR(1),
henkilomaara SMALLINT(6), 
tilauspvm DATE NOT NULL,
FOREIGN KEY (astunnus) 
REFERENCES asiakas (astunnus)
 );
 
 

CREATE TABLE tilausrivi (
tilausnro INT(10) PRIMARY KEY,
tuotenumero INT(10) NOT NULL,
kpl INTEGER NOT NULL,
ruokavaliokoodi INT(4),
FOREIGN KEY (tilausnro)
REFERENCES tilaus (tilausnro)
);


CREATE TABLE ruokavalio (
tilausnro INT(10) PRIMARY KEY,
ruokavaliokoodi INT(4) NOT NULL,
FOREIGN KEY (tilausnro)
REFERENCES tilausrivi (tilausnro)
);

CREATE TABLE ruokavaliokoodi (
ruokavaliokoodi INT(4) PRIMARY KEY,
ruokavalionimi VARCHAR(20) NOT NULL,
FOREIGN KEY (ruokavaliokoodi)
REFERENCES ruokavalio (ruokavaliokoodi)
);

