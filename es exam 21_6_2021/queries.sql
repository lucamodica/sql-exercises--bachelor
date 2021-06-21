--ES A
SELECT DISTINCT u.Nome, u.Cognome
FROM UTENTE u JOIN REFERTO r ON (u.Nome = r.Nome AND u.Cognome = r.Cognome)
    JOIN ANALISI a ON (r.Analisi = a.Nome)
WHERE u.Eta > 60 AND u.Sesso = 'Donna' AND r.Esito >= a.NormaMin AND r.Esito <= a.NormaMax
ORDER BY u.Cognome, u.Nome DESC

--ES B
SELECT a.tipo, COUNT(a.tipo), AVG(a.Prezzo)
FROM REFERTO r JOIN ANALISI a ON (r.Analisi = a.Nome)
WHERE a.Prezzo > 20 AND r.Data LIKE '2019%'
GROUP BY a.Nome
HAVING COUNT(a.tipo) < 100

--ES C
WITH analisi_digiuno AS
(SELECT DISTINCT r.Nome Nome, r.Cognome Cognome
FROM REFERTO r JOIN ANALISI a ON (r.Analisi = a.Nome)
WHERE a.Digiuno = true)
SELECT Nome, Cognome
FROM UTENTE
WHERE NOT EXISTS (analisi_digiuno)
