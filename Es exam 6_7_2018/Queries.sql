--ES
with num_incarichi as(
    select i.NumeroL Idlegislatura, count(*) NumIncarichi 
    from incarico i join primoministro p on 
        (p.Cognome = i.CognomePM and p.Nome = i.NomePM)
    where i.DataGiuramento is null and p.PartitoPolitico is null
    group by i.NumeroL
)
select *
from num_incarichi n
where n.NumIncarichi >= all(select NumIncarichi from num_incarichi);