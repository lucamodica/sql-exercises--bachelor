--ES
select *
from utente u join seguace s on (u.IDUtente = s.IDUtente1)
    join cinguettio c1 on (s.IDUtente1 = c1.IDUtente)
    join cinguettio c2 on (s.IDUtente2 = c2.IDUtente
                        and c2.IDCinguettio = c1.Ricinguettio)
    where c1.DataC < s.DataS;