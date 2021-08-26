--ES
select b.Titolo, b.Artista
from brano b 
    join passaggio p1 on (b.Codice = p1.CodiceBrano)
    join passaggio p2 on (p1.CodiceBrano = p2.CodiceBrano and p1.DataOra <> p2.DataOra)
    join passaggio p3 on (p2.CodiceBrano = p3.CodiceBrano and p2.DataOra <> p3.DataOra)
where p1.Citta = 'Torino' and p2.Citta = 'Torino' and p3.Citta = 'Torino'
 and p1.Durata < b.Durata and p2.Durata < b.Durata and p3.Durata < b.Durata;


--ES (soluzione dell'esame)
select b.Codice, b.Titolo, b.Artista
from brano b join passaggio p on (b.Codice = p.CodiceBrano)
where p.Durata < b.Durata and p.Citta = 'Torino'
group by b.Codice, b.Titolo, b.Artista
having count(*) > 2;