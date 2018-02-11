-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-02-02 14:58:18.577

-- foreign keys
ALTER TABLE DysZawTur
    DROP CONSTRAINT DysZawTur_Dyscypliny;

ALTER TABLE DysZawTur
    DROP CONSTRAINT DysZawTur_ZawodnikTurniej;

ALTER TABLE Punktacja
    DROP CONSTRAINT Punktacja_Dyscypliny;

ALTER TABLE Stadiony
    DROP CONSTRAINT Stadiony_Miejscowosc;

ALTER TABLE SzkolaTurniej
    DROP CONSTRAINT SzkolaTurniej_Szkoly;

ALTER TABLE SzkolaTurniej
    DROP CONSTRAINT SzkolaTurniej_Turniej;

ALTER TABLE Szkoly
    DROP CONSTRAINT Szkoly_Miejscowosc;

ALTER TABLE Turniej
    DROP CONSTRAINT Table_5_Stadiony;

ALTER TABLE ZawodnikTurniej
    DROP CONSTRAINT ZawodnikTurniej_SzkolaTurniej;

ALTER TABLE ZawodnikTurniej
    DROP CONSTRAINT ZawodnikTurniej_Zawodnicy;

-- tables
DROP TABLE DysZawTur;

DROP TABLE Dyscypliny;

DROP TABLE Miejscowosc;

DROP TABLE Punktacja;

DROP TABLE Stadiony;

DROP TABLE SzkolaTurniej;

DROP TABLE Szkoly;

DROP TABLE Turniej;

DROP TABLE Zawodnicy;

DROP TABLE ZawodnikTurniej;

-- End of file.

