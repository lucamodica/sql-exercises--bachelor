--## Esonero SQL V1 ##
--ES A
select o.DataOrdine, o.Prezzo
from ordine o join ristorante r on (o.Ristorante = r.Codice)
    join utente u on (o.Utente = u.Codice)
where r.Tipo = 'pizzeria' and u.IndirizzoPreferito <> o.IndirizzoConsegna;

--ES B
select u.Nome, u.Citta
from ordine o join ristorante r on (o.Ristorante = r.Codice)
    join utente u on (o.Utente = u.Codice)
where o.Prezzo >= 50
group by u.Codice
having(distinct r.Tipo) >= 2;

--ES C
with lista_ricavi_tot as
(select r.Codice, r.Nome, r.Tipo, sum(o.Prezzo) TotRicavi
from ordine o join ristorante r on (o.Ristorante = r.Codice)
group by(r.Codice))
select *
from lista_ricavi_tot lr
where TotRicavi >= all(select lr1.TotRicavi
                       from lista_ricavi_tot lr1
                       where lr.Codice <> lr1.codice and lr.Tipo = lr1.Tipo);


--## Esonero SQL V2 ##
--ES A
select distinct u.Email
from ordine o join ristorante r on (o.Ristorante = r.Codice)
    join utente u on (o.Utente = u.Codice)
where (r.Tipo = 'paninoteca' or r.Tipo = 'pizzeria') and r.Citta = 'Torino'
order by u.Email desc;

--ES B
select r.Tipo
from ristorante r join ordine o1 on (r.Codice = o1.Ristorante)
    join ordine o2 on (r.codice = o2.Ristorante)
    join utente u1 on (o1.Utente = u1.Codice)
    join utente u2 on (o2.Utente = u2.Codice)
where r.Citta = 'Nichelino' and u1.Citta = 'Torino' and u2.Citta = 'Torino'
    and o1.Utente <> o2.Utente;

--ES C
with lista_ricavi_tot as
(select r.Codice, sum(o.Prezzo) TotRicavi
from ordine o join ristorante r on (o.Ristorante = r.Codice)
where o.Ristorante not in (select o1.Ristorante
                            from oridne o1
                            where o.Ristorante = o1.Ristorante and o1.Prezzo >= 50)
group by(r.Codice)
having sum(o.Prezzo) between 80000 and 100000)
select *
from lista_ricavi_tot lr
where lr.TotRicavi >= all(select lr1.TotRicavi
                       from lista_ricavi_tot lr1);
