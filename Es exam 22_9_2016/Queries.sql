--ES
select c.Nome, count(*)
from circolo c join squadra s on (c.Nome = s.Circolo)
    join giocatore g on (s.NomeSquadra = g.Squadra)
where g.TesseraGiocatore not in (select Vincitore from partita) 
group by Nome;


--ES (soluzione dell'esame)
select s.Circolo, count(distinct g.TesseraGiocatore)
from squadra s join giocatore g on (s.NomeSquadra = g.Squadra)
    join partita p on (g.TesseraGiocatore = p.Giocatore1 or
        g.TesseraGiocatore = p.Giocatore2)
where g.TesseraGiocatore not in (select Vincitore from partita) 
group by s.Circolo
-- Il distinct nel count() serve per tenere in considerazione il 
-- fatto che i giocatori possono aver giocato piu partite, pertanto
-- per evitare di contare duplicati.