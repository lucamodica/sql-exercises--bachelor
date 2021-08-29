--ES
select avg(Eta), avg(reddito)
from persona
where Cod in(
    select Cod
    from voto
    where NomeCandidato = 'Donald Trump' and
        AnnoElezione >= all(select AnnoElezione from elezione)
)
and Cod not in(
    select Cod 
    from voto v join candidato c on (v.NomeCandidato = c.NomeCandidato)
    where c.PartitoCandidato = 'Repubblicano' and
        AnnoElezione < any(select AnnoElezione from elezione)
);