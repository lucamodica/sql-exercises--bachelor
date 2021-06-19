--## Esonero SQL V1 ##
--ES A
select distinct e.tipo
from esercizio e join vocescheda v on e.nome = v.esercizio
    join utente u on (v.nome = u.nome and v.cognome = u.cognome)
where u.sesso = 'femmina' and u.eta <= 30 and u.eta >= 20

--ES B
select v.nome, v.cognome, AVG(v.durata)
from esercizio e join vocescheda v on e.nome = v.esercizio
where e.tipo = 'aerobico'
group by v.nome, v.cognome
having sum(v.durata) > 60

--ES C
with utente_attrezzo as
(select nome, cognome, NumRipetizioni
from vocescheda
where (nome, cognome, ordine) = 
    select v.nome, v.cognome, MAX(v.ordine)
    from vocescheda v join esercizio e on v.esercizio = e.nome
    where e.attrezzo is null
    group by v.nome, v.cognome)
select nome, cognome
from utente_attrezzo
where NumRipetizioni = (select MAX(ua.NumRipetizioni) from utente_attrezzo ua))




--## Esonero SQL V2 ##
--ES A
select distinct e.attrezzo
from esercizio e join vocescheda v on e.nome = v.esercizio
    join utente u on (v.nome = u.nome and v.cognome = u.cognome)
where e.attrezzo is not null and u.sesso = 'uomo' and v.ordine <= 3
order by e.attrezzo desc

--ES B
select e.attrezzo, AVG(v.durata)
from esercizio e join vocescheda v on e.nome = v.esercizio
where e.attrezzo is not null and e.tipo = 'posturale'
group by e.attrezzo
having MAX(v.NumRipetizioni) <= 20

--ES C
with sum_durate as
(select e.attrezzo, SUM(v.durata)
from esercizio e join vocescheda v on e.nome = v.esercizio
where e.attrezzo is not null and e.tipo = 'aerobico' and not exists
    (select *
    from esercizio ee join vocescheda vv on ee.nome = vv.esercizio
    where vv.nome = v.nome and vv.cognome = v.cognome 
        and ee.attrezzo <> e.attrezzo)
group by e.attrezzo)
select attrezzo
from sum_durate
where durata = (select MAX(sd.durata) from sum_durate sd))

