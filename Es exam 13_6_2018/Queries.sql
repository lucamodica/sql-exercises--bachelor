--ES
select s1.NomeSquadra, s2.NomeSquadra
from squadra s1 join squadra s2 on (s1.NomeSquadra < s1.NomeSquadra)
where not exists(
        select * from partita p1
        where (p1.SquadraCasa = s1.NomeSquadra and p1.SquadraOspite = s2.NomeSquadra)
        or (p1.SquadraCasa = s2.NomeSquadra and p1.SquadraOspite = s1.NomeSquadra)
    )
and exists(
        select * from squadra s3
        where s3.NomeSquadra <> s2.NomeSquadra and s3.NomeSquadra <> s1.NomeSquadra
        and exists(
                select * from partita p2
                where (p2.SquadraCasa = s1.NomeSquadra and p2.SquadraOspite = s3.NomeSquadra
                    and p2.PuntiSC < p2.PuntiSO)
                or (p2.SquadraCasa = s3.NomeSquadra and p2.SquadraOspite = s1.NomeSquadra
                    and p2.PuntiSC > p2.PuntiSO)
            )
        and exists(
                select * from partita p3
                where (p3.SquadraCasa = s2.NomeSquadra and p3.SquadraOspite = s3.NomeSquadra
                    and p3.PuntiSC < p3.PuntiSO)
                or (p3.SquadraCasa = s3.NomeSquadra and p3.SquadraOspite = s2.NomeSquadra
                    and p3.PuntiSC > p3.PuntiSO)
            )
    );
