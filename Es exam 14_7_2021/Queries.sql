--ES A
select distinct v.*
from videolezione v join programma p on (v.Argomento = p.Videolezione) 
    join corso c on (p.Corso = c.Codice)
where v.CFU > c.CFU / 3
order by v.NomeDocente asc;

--ES B
select c.Corso, count(v1.Argomento), sum(v2.CFU)
from corso c 
    join programma1 p1 on (c.Codice = p1.Corso)
    join programma2 p2 on (c.Codice = p2.Corso)
    join videolezione v1 on (p1.Videolezione = v1.Argomento)
    join videolezione v2 on (p2.Videolezione = v2.Argomento)
where c.CFU >= 6 and p1.Laboratorio = TRUE and p2.Laboratorio = FALSE
group by p1.Corso, p2.Corso
having sum(v1.CFU) > 3;

--ES C
with corsi_no_lab_count_aud_inter as (
    select c.Codice, count(v1.Argomento) n_interattivo, count(v2.Argomento) n_audioslide
    from corso c 
        join programma1 p1 on (c.Codice = p1.Corso)
        join programma2 p2 on (c.Codice = p2.Corso)
        join videolezione v1 on (p1.Videolezione = v1.Argomento)
        join videolezione v2 on (p2.Videolezione = v2.Argomento)
    where not exists(
        select dsitinct Corso 
        from programma
        where Laboratorio = TRUE
    ) and v1.Formato = 'interattivo' and v2.Formato = 'audioslide'
    group by p1.Corso, p2.Corso
)
select *
from corsi_no_lab_count_aud_inter
where n_interattivo > n_audioslide;