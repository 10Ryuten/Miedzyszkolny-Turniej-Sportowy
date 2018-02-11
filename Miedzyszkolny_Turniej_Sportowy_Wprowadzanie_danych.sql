Alter session Set nls_date_format = 'yyyy-mm-dd';

-- usuwanie danych z tabel
delete from DysZawTur;
delete from ZawodnikTurniej;
delete from SzkolaTurniej;
delete from Turniej;
delete from Punktacja;
delete from dyscypliny;
delete from szkoly;
delete from stadiony;
delete from miejscowosc;
delete from Zawodnicy;

-- usuwanie sekwencji 
drop sequence SEQ_DYSCYPLINY;
drop sequence SEQ_TURNIEJ;
drop SEQUENCE SEQ_szkoly;
drop SEQUENCE SEQ_miejscowosc;
drop Sequence SEQ_ZAWODNICY;

-- tworzenie sekwencji
create SEQUENCE SEQ_szkoly
  INCREMENT BY 1 start with 1;
create SEQUENCE SEQ_miejscowosc
  INCREMENT BY 1 start with 1;
create SEQUENCE SEQ_turniej
  INCREMENT BY 1 start with 1;
create SEQUENCE SEQ_zawodnicy
  INCREMENT BY 1 start with 1;
create SEQUENCE SEQ_dyscypliny
  INCREMENT BY 1 start with 1;

-- dodawanie miejscowosci
insert into miejscowosc (idMiejscowosci, nazwa)
values (SEQ_miejscowosc.nextval, 'Piaseczno');
insert into miejscowosc (idMiejscowosci, nazwa)
values (SEQ_miejscowosc.nextval, 'Zalesie Górne');
insert into miejscowosc (idMiejscowosci, nazwa)
values (SEQ_miejscowosc.nextval, 'Góra Kalwaria');
insert into miejscowosc (idMiejscowosci, nazwa)
values (SEQ_miejscowosc.nextval, 'Dobiesz');

-- dodawanie szkol
insert into szkoly (idSzkoly, nazwa, idMiejscowosci, Adres, KodPocztowy, Email)
values (SEQ_szkoly.nextval, 'Szkola Podstawowa im. Wspolnej Europy', (select IDMIEJSCOWOSCI from MIEJSCOWOSC where nazwa = 'Zalesie Górne'), 'Sarenki 15', '05-540', 'spWspolnejEuropy@mail.com');
insert into szkoly (idSzkoly, nazwa, idMiejscowosci, Adres, KodPocztowy, Email)
values (SEQ_szkoly.nextval, 'Szko³a Podstawowa im. Kardyna³a Stefana Wyszyñskiego', (select IDMIEJSCOWOSCI from MIEJSCOWOSC where nazwa = 'Dobiesz'), 'Wolska 36', '05-530', 'spdobiesz@op.pl');
insert into szkoly (idSzkoly, nazwa, idMiejscowosci, Adres, KodPocztowy, Email)
values (SEQ_szkoly.nextval, 'Szko³a Podstawowa nr 1', (select IDMIEJSCOWOSCI from MIEJSCOWOSC where nazwa = 'Piaseczno'), 'Œwiêtojañska 18', '05-500', 'sekretariat@sp1piaseczno.pl');
insert into szkoly (idSzkoly, nazwa, idMiejscowosci, Adres, KodPocztowy, Email)
values (SEQ_szkoly.nextval, 'Szko³a Podstawowa nr 2 im. Ewy Krauze', (select IDMIEJSCOWOSCI from MIEJSCOWOSC where nazwa = 'Piaseczno'), 'aleja Kasztanów 12', '05-500', 'szkola.zalesie@wp.pl');

-- dodawanie stadionow
insert into stadiony (idStadionu, nazwa, idMiejscowosci, adres, kodPocztowy)
select NVL(Max(idStadionu), 0) + 1, 'Stadion GOSiR', 1, '1 Maja 16', '05-500' from stadiony;
update stadiony set idmiejscowosci = (select IDMIEJSCOWOSCI from MIEJSCOWOSC where nazwa = 'Piaseczno') where IDSTADIONU = (select NVL(Max(idStadionu), 0) from emp);
insert into stadiony (idStadionu, nazwa, idMiejscowosci, adres, kodPocztowy)
select NVL(Max(idStadionu), 0) + 1, 'Stadion miejski', miejscowosc.IdMiejscowosci, 'Wojska Polskiego 44', '05-530' from Stadiony right join Miejscowosc on 1=1 where miejscowosc.nazwa = 'Góra Kalwaria' group by miejscowosc.idmiejscowosci;

-- dodawanie dyscyplin
insert into dyscypliny (idDyscypliny, nazwa, liczbaZawodnikow)
values (SEQ_dyscypliny.nextval, 'sztafeta', 4);
insert into dyscypliny (idDyscypliny, nazwa, liczbaZawodnikow)
values (SEQ_dyscypliny.nextval, 'dwa ognie', 4);
insert into dyscypliny (idDyscypliny, nazwa, liczbaZawodnikow)
values (SEQ_dyscypliny.nextval, 'biegi prze³ajowe', 2);
insert into dyscypliny (idDyscypliny, nazwa, liczbaZawodnikow)
values (SEQ_dyscypliny.nextval, 'skok w dal', 1);

-- dodawanie punktacji
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 1, 6 from Dyscypliny where dyscypliny.nazwa = 'sztafeta';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 2, 5 from Dyscypliny where dyscypliny.nazwa = 'sztafeta';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 3, 4 from Dyscypliny where dyscypliny.nazwa = 'sztafeta';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 1, 6 from Dyscypliny where dyscypliny.nazwa = 'dwa ognie';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 2, 5 from Dyscypliny where dyscypliny.nazwa = 'dwa ognie';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 3, 4 from Dyscypliny where dyscypliny.nazwa = 'dwa ognie';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 1, 12 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 2, 10 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 3, 8 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 4, 6 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 5, 4 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 6, 2 from Dyscypliny where dyscypliny.nazwa = 'biegi prze³ajowe';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 1, 12 from Dyscypliny where dyscypliny.nazwa = 'skok w dal';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 2, 8 from Dyscypliny where dyscypliny.nazwa = 'skok w dal';
insert into punktacja (idDyscypliny, zajeteMiejsce, liczbaPunktow)
select dyscypliny.idDyscypliny, 3, 4 from Dyscypliny where dyscypliny.nazwa = 'skok w dal';

-- dodawanie zawodnikow
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Jan', 'Kowalski', '2008-12-23');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Micha³', 'Guma', '2007-02-11');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Agnieszka', 'Z¹bkowska', '2008-05-15');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Marta', 'Ko³dra', '2007-07-28');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Andrzej', 'Rzeka', '2009-06-13');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Maja', 'Gryzoñ', '2008-04-08');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Krzysztof', 'Kowalski', '2007-01-04');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Katarzyna', 'Nowak', '2006-09-06');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Marek', 'Tur', '2008-05-07');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Jan', 'Nowak', '2008-04-04');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Kasia', 'Poduszka', '2007-08-23');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Micha³', 'Kowalski', '2007-10-23');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Jan', 'Kowalski', '2008-12-22');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Andrzej', 'Kruk', '2007-11-11');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Matylda', 'Karaœ', '2008-12-30');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Maciek', 'Lusterko', '2007-05-18');
insert into zawodnicy (idZawodnika, imie, nazwisko, dataUrodzenia)
values (SEQ_zawodnicy.nextval, 'Geralt', 'Pingwin', '2008-03-31');

-- dodawanie turniejów
insert into turniej (nrTurnieju, data, idStadionu)
select SEQ_TURNIEJ.NEXTVAL, '2016-05-11', stadiony.idStadionu from stadiony where nazwa = 'Stadion GOSiR';
insert into turniej (nrTurnieju, data, idStadionu)
select SEQ_TURNIEJ.NEXTVAL, '2017-05-10', stadiony.idStadionu from stadiony where nazwa = 'Stadion miejski';

-- dodawanie szkol do turniejow
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szkola Podstawowa im. Wspolnej Europy' and turniej.nrTurnieju = 1 group by szkoly.idSzkoly, turniej.nrTurnieju;
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szko³a Podstawowa nr 1' and turniej.nrTurnieju = 1 group by szkoly.idSzkoly, turniej.nrTurnieju;
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szko³a Podstawowa im. Kardyna³a Stefana Wyszyñskiego' and turniej.nrTurnieju = 1 group by szkoly.idSzkoly, turniej.nrTurnieju;
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szkola Podstawowa im. Wspolnej Europy' and turniej.nrTurnieju = 2 group by szkoly.idSzkoly, turniej.nrTurnieju;
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szko³a Podstawowa nr 1' and turniej.nrTurnieju = 2 group by szkoly.idSzkoly, turniej.nrTurnieju;
insert into SzkolaTurniej (idSzkolaTurniej, idSzkoly, nrTurnieju)
select NVL(Max(idSzkolaTurniej), 0) + 1, szkoly.idSzkoly, turniej.nrTurnieju
from szkolaTurniej right join szkoly on 1=1 join turniej on 1=1 
where szkoly.nazwa = 'Szko³a Podstawowa nr 2 im. Ewy Krauze' and turniej.nrTurnieju = 2 group by szkoly.idSzkoly, turniej.nrTurnieju;

-- dodawanie zawodnikow do pierwszego turnieju
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 1 and szkolaTurniej.idSzkolaTurniej = 1 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 2 and szkolaTurniej.idSzkolaTurniej = 1 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 3 and szkolaTurniej.idSzkolaTurniej = 1 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 4 and szkolaTurniej.idSzkolaTurniej = 1 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 6 and szkolaTurniej.idSzkolaTurniej = 2 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 7 and szkolaTurniej.idSzkolaTurniej = 2 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 8 and szkolaTurniej.idSzkolaTurniej = 2 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 9 and szkolaTurniej.idSzkolaTurniej = 2 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 10 and szkolaTurniej.idSzkolaTurniej = 3 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 11 and szkolaTurniej.idSzkolaTurniej = 3 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 12 and szkolaTurniej.idSzkolaTurniej = 3 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 13 and szkolaTurniej.idSzkolaTurniej = 3 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;

-- dodawanie zawodnikow do drugiego turnieju
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 1 and szkolaTurniej.idSzkolaTurniej = 4 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 2 and szkolaTurniej.idSzkolaTurniej = 4 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 3 and szkolaTurniej.idSzkolaTurniej = 4 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 4 and szkolaTurniej.idSzkolaTurniej = 4 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 5 and szkolaTurniej.idSzkolaTurniej = 5 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 6 and szkolaTurniej.idSzkolaTurniej = 5 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 12 and szkolaTurniej.idSzkolaTurniej = 5 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 14 and szkolaTurniej.idSzkolaTurniej = 5 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 13 and szkolaTurniej.idSzkolaTurniej = 6 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 15 and szkolaTurniej.idSzkolaTurniej = 6 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 16 and szkolaTurniej.idSzkolaTurniej = 6 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;
insert into ZawodnikTurniej (idZawodnikTurniej, idZawodnika, idSzkolaTurniej)
select NVL(MAX(idZawodnikTurniej), 0) + 1, zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej 
from zawodnikTurniej right join zawodnicy on 1=1 join szkolaTurniej on 1=1
where zawodnicy.idZawodnika = 17 and szkolaTurniej.idSzkolaTurniej = 6 group by zawodnicy.idZawodnika, szkolaTurniej.idSzkolaTurniej;

-- dodawanie wyborow dyscyplin i wynikow pierwszego turnieju
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 1;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 2;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 3;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 4;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 5;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 6;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 7;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 8;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 9;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 10;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 11;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 12;

insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 1;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 2;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 3;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 4;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 5;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 6;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 7;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 8;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 9;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 10;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 11;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 12;

insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 4, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 1;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 2;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 6, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 5;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 6;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 9;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 5, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 10;

insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 1, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 1;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 3, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 7;
insert into DysZawTur (idDyscypliny, zajeteMiejsce, idZawodnikTurniej)
select dyscypliny.idDyscypliny, 2, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 12;

-- dodawanie wyboru dyscyplin drugiego turnieju
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 13;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 14;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 15;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 16;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 17;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 18;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 19;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 20;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 21;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 22;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 23;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'sztafeta' and zawodnikTurniej.idZawodnikTurniej = 24;

insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 13;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 14;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 15;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 16;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 17;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 18;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 19;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 20;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 21;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 22;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 23;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'dwa ognie' and zawodnikTurniej.idZawodnikTurniej = 24;

insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 13;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 14;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 17;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 18;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 21;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'biegi prze³ajowe' and zawodnikTurniej.idZawodnikTurniej = 22;

insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 13;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 18;
insert into DysZawTur (idDyscypliny, idZawodnikTurniej)
select dyscypliny.idDyscypliny, zawodnikTurniej.idZawodnikTurniej 
from dyscypliny, zawodnikTurniej
where dyscypliny.nazwa = 'skok w dal' and zawodnikTurniej.idZawodnikTurniej = 24;

-- dodawanie wywnikow drugiego turnieju
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 13 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 14 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 15 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 16 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 17 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 18 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 19 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 20 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 21 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 22 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 23 and idDyscypliny = 1;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 24 and idDyscypliny = 1;

update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 13 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 14 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 15 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 16 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 17 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 18 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 19 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 20 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 21 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 22 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 23 and idDyscypliny = 2;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 24 and idDyscypliny = 2;

update DysZawTur set zajeteMiejsce = 4 where idZawodnikTurniej = 13 and idDyscypliny = 3;
update DysZawTur set zajeteMiejsce = 5 where idZawodnikTurniej = 14 and idDyscypliny = 3;
update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 17 and idDyscypliny = 3;
update DysZawTur set zajeteMiejsce = 6 where idZawodnikTurniej = 18 and idDyscypliny = 3;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 21 and idDyscypliny = 3;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 22 and idDyscypliny = 3;

update DysZawTur set zajeteMiejsce = 3 where idZawodnikTurniej = 13 and idDyscypliny = 4;
update DysZawTur set zajeteMiejsce = 1 where idZawodnikTurniej = 18 and idDyscypliny = 4;
update DysZawTur set zajeteMiejsce = 2 where idZawodnikTurniej = 24 and idDyscypliny = 4;