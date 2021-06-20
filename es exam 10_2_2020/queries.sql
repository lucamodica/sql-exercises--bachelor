--ES A
SELECT s.Citta, COUNT(s.NomeSquadra)
FROM SQUADRA s JOIN CONQUISTA c ON (s.NomeSquadra = c.NomeSquadra)
WHERE c.NomeTitolo = 'Scudetto' and s.AnnoFondazione = c.AnnoConquista
GROUP BY s.Citta;

--ES B
SELECT s.NomeSquadra, c.AnnoConquista
FROM SQUADRA s JOIN CONQUISTA c ON (s.NomeSquadra = c.NomeSquadra)
    JOIN CONQUISTA c2 ON (s.NomeSquadra = c2.NomeSquadra)
    JOIN CONQUISTA c3 ON (s.NomeSquadra = c3.NomeSquadra)
WHERE c.AnnoConquista = c2.AnnoConquista AND c.AnnoConquista = c3.AnnoConquista
    AND c2.AnnoConquista = c3.AnnoConquista AND c.NomeTitolo = 'Scudetto' AND
    c2.NomeTitolo = 'Coppa Italia' AND (c3.NomeTitolo = 'UEFA Champions League'
    OR c3.NomeTitolo = 'Coppa dei Campioni');

--ES C
WITH titolo_europeo AS
(SELECT c.NomeSquadra Squadra, COUNT(*) NumScudetti
FROM CONQUISTA c
WHERE t.AnnoConquista >= 2000 AND c.NomeTitolo = 'Scudetto' AND
    NOT EXISTS(SELECT c1.NomeSquadra
                FROM CONQUISTA c1 JOIN TITOLO t ON (c1.NomeTitolo = t.NomeTitolo)
                WHERE t.AnnoConquista >= 2000 AND t.tipo = 'Europeo')
GROUP BY c.NomeSquadra)
SELECT Squadra
FROM titolo_europeo
WHERE NumScudetti = (SELECT MAX(NumScudetti) FROM titolo_europeo);

    
