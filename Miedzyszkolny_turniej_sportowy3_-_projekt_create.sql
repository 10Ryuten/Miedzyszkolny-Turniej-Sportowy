-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-02-02 14:58:18.577

-- tables
-- Table: DysZawTur
CREATE TABLE DysZawTur (
    IdZawodnikTurniej integer  NOT NULL,
    IdDyscypliny integer  NOT NULL,
    ZajeteMiejsce integer  NULL,
    CONSTRAINT DysZawTur_pk PRIMARY KEY (IdZawodnikTurniej,IdDyscypliny)
) ;

-- Table: Dyscypliny
CREATE TABLE Dyscypliny (
    IdDyscypliny integer  NOT NULL,
    Nazwa varchar2(32)  NOT NULL,
    LiczbaZawodnikow integer  NOT NULL,
    CONSTRAINT Dyscypliny_pk PRIMARY KEY (IdDyscypliny)
) ;

-- Table: Miejscowosc
CREATE TABLE Miejscowosc (
    IdMiejscowosci integer  NOT NULL,
    Nazwa varchar2(32)  NOT NULL,
    CONSTRAINT Miejscowosc_pk PRIMARY KEY (IdMiejscowosci)
) ;

-- Table: Punktacja
CREATE TABLE Punktacja (
    IdDyscypliny integer  NOT NULL,
    ZajeteMiejsce integer  NOT NULL,
    LiczbaPunktow integer  NOT NULL,
    CONSTRAINT Punktacja_pk PRIMARY KEY (IdDyscypliny,ZajeteMiejsce)
) ;

-- Table: Stadiony
CREATE TABLE Stadiony (
    IdStadionu integer  NOT NULL,
    Nazwa varchar2(100)  NOT NULL,
    IdMiejscowosci integer  NOT NULL,
    Adres varchar2(60)  NOT NULL,
    KodPocztowy varchar2(6)  NOT NULL,
    CONSTRAINT Stadiony_pk PRIMARY KEY (IdStadionu)
) ;

-- Table: SzkolaTurniej
CREATE TABLE SzkolaTurniej (
    IdSzkolaTurniej integer  NOT NULL,
    IdSzkoly integer  NOT NULL,
    NrTurnieju integer  NOT NULL,
    CONSTRAINT SzkolaTurniej_pk PRIMARY KEY (IdSzkolaTurniej)
) ;

-- Table: Szkoly
CREATE TABLE Szkoly (
    IdSzkoly integer  NOT NULL,
    Nazwa varchar2(100)  NOT NULL,
    IdMiejscowosci integer  NOT NULL,
    Adres varchar2(60)  NOT NULL,
    KodPocztowy varchar2(6)  NOT NULL,
    Email varchar2(32)  NOT NULL,
    CONSTRAINT Szkoly_pk PRIMARY KEY (IdSzkoly)
) ;

-- Table: Turniej
CREATE TABLE Turniej (
    NrTurnieju integer  NOT NULL,
    Data date  NOT NULL,
    IdStadionu integer  NOT NULL,
    CONSTRAINT Turniej_pk PRIMARY KEY (NrTurnieju)
) ;

-- Table: Zawodnicy
CREATE TABLE Zawodnicy (
    IdZawodnika integer  NOT NULL,
    Imie varchar2(32)  NOT NULL,
    Nazwisko varchar2(32)  NOT NULL,
    DataUrodzenia date  NOT NULL,
    CONSTRAINT Zawodnicy_pk PRIMARY KEY (IdZawodnika)
) ;

-- Table: ZawodnikTurniej
CREATE TABLE ZawodnikTurniej (
    IdZawodnikTurniej integer  NOT NULL,
    IdZawodnika integer  NOT NULL,
    IdSzkolaTurniej integer  NOT NULL,
    CONSTRAINT ZawodnikTurniej_pk PRIMARY KEY (IdZawodnikTurniej)
) ;

-- foreign keys
-- Reference: DysZawTur_Dyscypliny (table: DysZawTur)
ALTER TABLE DysZawTur ADD CONSTRAINT DysZawTur_Dyscypliny
    FOREIGN KEY (IdDyscypliny)
    REFERENCES Dyscypliny (IdDyscypliny);

-- Reference: DysZawTur_ZawodnikTurniej (table: DysZawTur)
ALTER TABLE DysZawTur ADD CONSTRAINT DysZawTur_ZawodnikTurniej
    FOREIGN KEY (IdZawodnikTurniej)
    REFERENCES ZawodnikTurniej (IdZawodnikTurniej);

-- Reference: Punktacja_Dyscypliny (table: Punktacja)
ALTER TABLE Punktacja ADD CONSTRAINT Punktacja_Dyscypliny
    FOREIGN KEY (IdDyscypliny)
    REFERENCES Dyscypliny (IdDyscypliny);

-- Reference: Stadiony_Miejscowosc (table: Stadiony)
ALTER TABLE Stadiony ADD CONSTRAINT Stadiony_Miejscowosc
    FOREIGN KEY (IdMiejscowosci)
    REFERENCES Miejscowosc (IdMiejscowosci);

-- Reference: SzkolaTurniej_Szkoly (table: SzkolaTurniej)
ALTER TABLE SzkolaTurniej ADD CONSTRAINT SzkolaTurniej_Szkoly
    FOREIGN KEY (IdSzkoly)
    REFERENCES Szkoly (IdSzkoly);

-- Reference: SzkolaTurniej_Turniej (table: SzkolaTurniej)
ALTER TABLE SzkolaTurniej ADD CONSTRAINT SzkolaTurniej_Turniej
    FOREIGN KEY (NrTurnieju)
    REFERENCES Turniej (NrTurnieju);

-- Reference: Szkoly_Miejscowosc (table: Szkoly)
ALTER TABLE Szkoly ADD CONSTRAINT Szkoly_Miejscowosc
    FOREIGN KEY (IdMiejscowosci)
    REFERENCES Miejscowosc (IdMiejscowosci);

-- Reference: Table_5_Stadiony (table: Turniej)
ALTER TABLE Turniej ADD CONSTRAINT Table_5_Stadiony
    FOREIGN KEY (IdStadionu)
    REFERENCES Stadiony (IdStadionu);

-- Reference: ZawodnikTurniej_SzkolaTurniej (table: ZawodnikTurniej)
ALTER TABLE ZawodnikTurniej ADD CONSTRAINT ZawodnikTurniej_SzkolaTurniej
    FOREIGN KEY (IdSzkolaTurniej)
    REFERENCES SzkolaTurniej (IdSzkolaTurniej);

-- Reference: ZawodnikTurniej_Zawodnicy (table: ZawodnikTurniej)
ALTER TABLE ZawodnikTurniej ADD CONSTRAINT ZawodnikTurniej_Zawodnicy
    FOREIGN KEY (IdZawodnika)
    REFERENCES Zawodnicy (IdZawodnika);

-- End of file.

