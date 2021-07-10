--## Esonero SQL V1 ##
--ES A
select distinct coalesce(p.PartitoPolitico, 'Tecnico') as Partito
from incarico i join prescons p on (p.Cognome = i.CognomePC and p.Nome = i.NomePC)
    join legislatura l on (i.NumeroL = l.Numero)
where i.Durata is not null and i.Durata < 1000 and l.DataFine is not null;

--ES B
select CognomePC, NomePC, count(*) as NumeroIncarichi
from incarico i join prescons p on (p.Cognome = i.CognomePC and p.Nome = i.NomePC)
    join legislatura l on (i.NumeroL = l.Numero)
where AnnoNascita > 1950 and PartitoPolitico is not null
group by CognomePC, NomePC
having sum(i.Durata) > 365 * 5;

--ES C
with pres_incarico_bad as (
    select i.CognomePC, i.NomePC, count(distinct l.Numero) NumLegislature
    from incarico i1 join prescons p on (p.Cognome = i1.CognomePC and p.Nome = i1.NomePC)
    where PartitoPolitico is null and not exists(select CognomePC, NomePC
                                                from incarico
                                                where DataGiuramento is not null)
    group by CognomePC, NomePC
)
select *
from pres_incarico_bad pb
where NumLegislature > all(select pb1.NumLegislature
                            from pres_incarico_bad pb1
                            where pb.CognomePC <> pb1.CognomePC and 
                                pb.NomePC <> pb1.NomePC);


--## Esonero SQL V2 ##
--ES A
select distinct i.CognomePC, i.NomePC, coalesce(i.Durata, '0') as DurataIncarico
from legislatura l join incarico i on (l.Numero = i.NumeroL)
where l.DataFine is not null and (l.CognomePC like 'B%' or l.CognomePC like 'R%');

--ES B
select p.AnnoNascita, sum(i.Durata) DurataIncarichi
from incarico i join prescons p on (p.Cognome = i.CognomePC and p.Nome = i.NomePC)
where PartitoPolitico is not null 
and exists(
    select *
    from incarico i2
    where p.Cognome = i2.CognomePC and p.Nome = i2.NomePC
        and i.Datapreincarico <> i2.Datapreincarico
)
group by p.AnnoNascita;

--ES C
with governo_long_RL as(
    select i.CognomePC, i.NomePC, count(distinct i.NumeroL) num_leg
    from incarico i join prescons p on (p.Cognome = i.CognomePC and p.Nome = i.NomePC)
    where p.PartitoPolitico = 'Radicali Liberi'
    and exists(
        select *
        from incarico i2
        where i.CognomePC = i2.CognomePC and i.NomePC = i2.NomePC
            and i.Durata > 365
    )
    group by i.CognomePC, i.NomePC
)
select *
from governo_long_RL gl
where num_leg = (select max(num_leg) from governo_long_RL);