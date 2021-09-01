--ES
with num_cit as(
    select c1.DUtente, count(*) NCit
    from cinguettio c1 join cinguettio c2 
        on (c1.IDCinguettio = c2.Ricinguettio)
    group by IDUtente
)
select u.Nome
from utente u join on num_cit n on (u.IDUtente = n.IDUtente)
where n.NCit >= all(select n1.NCit from num_cit n1);