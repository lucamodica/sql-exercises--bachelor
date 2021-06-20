--ES A
SELECT s.NomeSerie
FROM SERIE s JOIN EPISODIO e ON s.NomeSerie = e.NomeSerie
    JOIN AUDIO a ON (a.NomeSerie = e.NomeSerie AND 
        a.NumStagione = e.NumStagione AND a.NumEpisodio = e.NumEpisodio)
WHERE s.Nazione = 'Giapponese' AND s.Genere = 'Animazione' 
    AND  a.AdattatoreDialoghi = 'Gualtiero Cannarsi';

--ES B
SELECT e.NomeSerie
FROM EPISODIO e JOIN SOTTOTITOLI cc ON (cc.NomeSerie = e.NomeSerie AND 
        cc.NumStagione = e.NumStagione AND cc.NumEpisodio = e.NumEpisodio)
WHERE e.Anno >= 2015 AND e.Anno <= 2019 AND cc.Lingua = 'Romeno'
GROUP BY e.NomeSerie
HAVING COUNT(DISTINCT e.NumStagione) >= 3;

--ES C
WITH count_cc_never_audio AS
(SELECT a.Lingua lang, COUNT(DISTINCT a.NomeSerie) num_serie
FROM AUDIO a
WHERE a.Lingua IN (SELECT cc.Lingua
                    FROM SOTTOTITOLI cc
                    WHERE NOT EXISTS (SELECT a.Lingua FROM AUDIO a))
GROUP BY a.Lingua
)
SELECT lang
FROM count_cc_never_audio
WHERE num_serie = (SELECT MAX(num_serie) FROM count_cc_never_audio);






