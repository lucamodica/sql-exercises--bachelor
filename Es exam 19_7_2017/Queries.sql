--ES A
select Conferenza, count(*) N_articoli
from articolo
where Anno = '2009'
group by Conferenza
having N_articoli < 20 or N_articoli > 100;


--ES B
with num_pubblicazioni as(
    select NomeAutore, count(*) N_articoli
    from pubblicazione
    group by NomeAutore
)
select Qualifica
from autore join num_pubblicazioni on (Nome = NomeAutore)
where N_articoli >= all(select n.N_articoli from num_pubblicazioni);


--ES B ((soluzione dell'esame)
with num_pubblicazioni as(
    select NomeAutore, count(*) N_articoli
    from pubblicazione
    group by NomeAutore
)
select Qualifica
from autore
where Nome in (
    select NomeAutore
    from num_pubblicazioni
    where N_articoli >= all(select n.N_articoli from num_pubblicazioni n)
);