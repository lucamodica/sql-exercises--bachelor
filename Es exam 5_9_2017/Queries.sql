--ES
with num_despacito as(
    select NomeEmittente, Citta, count(*) NumPlay
    from passaggio join brano on (CodiceBrano = Codice)
    where Titolo = 'Despacito' and Artista = 'Luis Fonsi'
        and extract(year FROM DataOra)= '2017'
    group by NomeEmittente, Citta
)
select NomeEmittente, Citta
from num_despacito
where NumPlay = (select max(n.NumPlay) from num_despacito);


--ES (soluzione dell'esame)
with num_despacito as(
    select NomeEmittente, Citta, count(*) NumPlay
    from passaggio join brano on (CodiceBrano = Codice)
    where Titolo = 'Despacito' and Artista = 'Luis Fonsi'
        and extract(year FROM DataOra)= '2017'
    group by NomeEmittente, Citta
)
select NomeEmittente, Citta
from radio
where (NomeEmittente, Citta) in (
    select n1.NomeEmittente, n2.Citta
    from num_despacito n1
    where NumPlay >= all(select n2.NumPlay from num_despacito n2)
);