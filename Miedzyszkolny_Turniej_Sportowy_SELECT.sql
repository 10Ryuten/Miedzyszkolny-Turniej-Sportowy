Alter session Set nls_date_format = 'yyyy-mm-dd';

-- Polecenia SELECT z warunkiem WHERE
-- 1.1 Nazwy dyscyplin, w ktorych uczestnicza cale czteroosobowe druzyny, posortowane alfabetycznie:
select nazwa "Nazwa dyscypliny" from dyscypliny where liczbaZawodnikow = 4 order by nazwa;

-- 1.2 Data pierwszego turnieju:
select data "Data pierwszego turnieju" from turniej where nrTurnieju = 1;

-- 1.3 Imiona i daty urodzen wszystkich zawodnikow o nazwisku Kowalski:
select imie "Imie", dataUrodzenia "Data urodzenia" from zawodnicy where nazwisko = 'Kowalski';

-- 1.4 Nazwy i emaile szkol o kodzie pocztowym 05-500:
select nazwa "Nazwa szkoly", email "Email szkoly" from szkoly where kodPocztowy = '05-500';

-- 1.5 Kod pocztowy stadionu o nazwie "Stadion miejski":
select kodPocztowy "Kod pocztowy" from stadiony where nazwa = 'Stadion miejski';

-- Polecenia SELECT ze zlaczeniem tabel
-- 2.1 Liczby punktow, przyznawanych zawodnikom, za pierwsze miejsca w poszczegolnych dyscyplinach:
select nazwa "Nazwa dyscypliny", liczbaPunktow "Liczba punktow za 1 miejsce"
from punktacja p join dyscypliny d
on p.idDyscypliny = d.idDyscypliny
where zajeteMiejsce = 1;

-- 2.2 Nazwy szkol znajdujacych sie w miejscowosci "Piaseczno":
select s.nazwa "Nazwa szkoly" 
from szkoly s join miejscowosc m
on s.idMiejscowosci = m.idMiejscowosci
where m.nazwa = 'Piaseczno';

-- 2.3 Id, imie i nazwisko zawodnikow, ktorzy przynajmniej raz rywalizowali w dyscyplinie "skok w dal":
select distinct z.idZawodnika, z.imie, z.nazwisko  
from zawodnicy z join zawodnikTurniej zt
on z.idZawodnika = zt.idZawodnika
join dysZawTur dzt 
on zt.idZawodnikTurniej = dzt.idZawodnikTurniej
join dyscypliny d
on dzt.idDyscypliny = d.idDyscypliny
where d.nazwa = 'skok w dal'
order by z.idZawodnika;
 
-- 2.4 Nazwy szkol posiadajacych zwyciezcow pierwszego turnieju w dyscyplinie "skok w dal" lub "biegi przelajowe"
select s.nazwa "Nazwa szkoly"
from szkoly s join szkolaTurniej st
on s.idSzkoly = st.idSzkoly
join zawodnikTurniej zt
on st.idSzkolaTurniej = zt.idSzkolaTurniej
join dysZawTur dzt
on dzt.idZawodnikTurniej = zt.idZawodnikTurniej
join dyscypliny d
on d.idDyscypliny = dzt.idDyscypliny
where (zajeteMiejsce = 1 and nrTurnieju = 1) and (d.nazwa = 'skok w dal' or d.nazwa = 'biegi prze³ajowe');

-- 2.5 Nazwa i adres stadionu, w którego miejscowosci nie ma zadnej szkoly uczestniczacej w turnieju:
select s.nazwa "Nazwa Stadionu", m.nazwa || ', ' || s.adres || ', ' || s.kodPocztowy "Adres"
from stadiony s join miejscowosc m
on s.idMiejscowosci = m.idMiejscowosci
left join szkoly sz
on sz.idMiejscowosci = m.idMiejscowosci
where sz.idMiejscowosci is null; 

-- Polecenia SELECT z klauzula GROUP BY
-- 3.1 Sumy punktow poszczegolnych szkol w pierwszym turnieju:
select s.nazwa "Nazwa szkoly", Sum(p.liczbaPunktow) "Suma punktow"
from szkoly s join szkolaTurniej st 
on s.idSzkoly = st.idSzkoly
join zawodnikTurniej zt
on st.idSzkolaTurniej = zt.idSzkolaTurniej
join dysZawTur dzt
on dzt.idZawodnikTurniej = zt.idZawodnikTurniej
join dyscypliny d
on dzt.idDyscypliny = d.idDyscypliny
join punktacja p 
on p.idDyscypliny = d.idDyscypliny and p.zajeteMiejsce = dzt.zajeteMiejsce
where nrTurnieju = 1
group by s.idSzkoly, s.nazwa
order by "Suma punktow" DESC;

-- 3.2 Sumy punktow poszczegolnych zawodnikow w pierwszym turnieju:
select s.nazwa "Nazwa szkoly", z.imie "Imie zawodnika", z.nazwisko "Nazwisko zawodnika", Sum(p.liczbaPunktow) "Suma punktow"
from zawodnicy z join zawodnikTurniej zt
on z.idZawodnika = zt.idZawodnika
join szkolaTurniej st
on st.idSzkolaTurniej = zt.idSzkolaTurniej
join szkoly s
on s.idSzkoly = st.idSzkoly
join dysZawTur dzt
on dzt.idZawodnikTurniej = zt.idZawodnikTurniej
join dyscypliny d
on d.idDyscypliny = dzt.idDyscypliny
join punktacja p
on p.idDyscypliny = d.idDyscypliny and p.zajeteMiejsce = dzt.zajeteMiejsce
join szkoly s
on s.idSzkoly = st.idSzkoly
where st.nrTurnieju = 1
group by z.idZawodnika, z.imie, z.nazwisko, s.idSzkoly, s.nazwa
order by s.nazwa, "Suma punktow" DESC;

-- 3.3 Imiona i nazwiska zawodnikow, ktorzy brali udzial w tylko jednym turnieju:
select z.imie "Imie zawodnika", z.nazwisko "Nazwisko zawodnika"
from zawodnicy z join zawodnikTurniej zt
on z.idZawodnika = zt.idZawodnika
join szkolaTurniej st
on st.idSzkolaTurniej = zt.idSzkolaTurniej
group by z.idZawodnika, z.imie, z.nazwisko
having Count(zt.idZawodnikTurniej) = 1;

-- 3.4 Wszystkie dane zawodnikow, ktorzy brali udzial we wszystkich dyscyplinach w przynajmniej jednym turnieju:
select distinct z.idZawodnika "Id zawodnika", z.imie "Imie zawodnika", z.nazwisko "Nazwisko zawodnika", z.dataUrodzenia "Data urodzenia zawodnika"
from zawodnicy z join zawodnikTurniej zt
on z.idZawodnika = zt.idZawodnika
join szkolaTurniej st
on st.idSzkolaTurniej = zt.idSzkolaTurniej
join dysZawTur dzt 
on zt.idZawodnikTurniej = dzt.idZawodnikTurniej
group by nrTurnieju, z.idZawodnika, z.imie, z.nazwisko, z.dataUrodzenia
having Count(dzt.idZawodnikTurniej) = 4;

-- 3.5 Imie, nazwisko i suma punktow zawodnika, ktory uzyskal najwiecej punktow w turnieju na stadionie w miejscowosci "Gora Kalwaria":
select z.imie "Imie", z.nazwisko "Nazwisko", Sum (p.liczbaPunktow) "Suma punktow"
from zawodnicy z join zawodnikTurniej zt
on z.idZawodnika = zt.idZawodnika
join dysZawTur dzt
on dzt.idZawodnikTurniej = zt.idZawodnikTurniej
join dyscypliny d
on d.idDyscypliny = dzt.idDyscypliny
join punktacja p
on p.idDyscypliny = d.idDyscypliny and p.zajeteMiejsce = dzt.zajeteMiejsce
join szkolaTurniej st
on st.idSzkolaTurniej = zt.idSzkolaTurniej
join turniej t
on st.nrTurnieju = t.nrTurnieju
join stadiony st
on st.idStadionu = t.idStadionu
join miejscowosc m
on m.idMiejscowosci = st.idMiejscowosci
where m.nazwa = 'Góra Kalwaria'
group by z.idZawodnika, z.imie, z.nazwisko
having Sum (p.liczbaPunktow) >= ALL (
    select Sum (p.liczbaPunktow)
    from zawodnicy z join zawodnikTurniej zt
    on z.idZawodnika = zt.idZawodnika
    join dysZawTur dzt
    on dzt.idZawodnikTurniej = zt.idZawodnikTurniej
    join dyscypliny d
    on d.idDyscypliny = dzt.idDyscypliny
    join punktacja p
    on p.idDyscypliny = d.idDyscypliny and p.zajeteMiejsce = dzt.zajeteMiejsce
    join szkolaTurniej st
    on st.idSzkolaTurniej = zt.idSzkolaTurniej
    join turniej t
    on st.nrTurnieju = t.nrTurnieju
    join stadiony st
    on st.idStadionu = t.idStadionu
    join miejscowosc m
    on m.idMiejscowosci = st.idMiejscowosci
    where m.nazwa = 'Góra Kalwaria'
    group by z.idZawodnika
);













