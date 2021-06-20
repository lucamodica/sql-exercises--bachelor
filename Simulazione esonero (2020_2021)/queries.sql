--ES A
SELECT DISTINCT p.Cliente
FROM PRENOTA p JOIN PRENOTA p2 ON (p1.Cliente = p2.Cliente)
    JOIN CAMERA c ON (p.Piano = c.Piano and p.Num = c.Num)
    JOIN CAMERA c2 ON (p2.Piano = c2.Piano and p2.Num = c2.Num)
WHERE c.NumPostiLetto <> c2.NumPostiLetto;

--ES B
SELECT DISTINCT c.NumTessera, c.Nome, c.CittaResidenza
FROM CLIENTE c JOIN PRENOTA p ON (c.NumTessera = p.Cliente)
    JOIN CAMERA ca ON (p.Num = ca.Num and p.Piano = ca.Piano)
WHERE ca.Prezzo > (SELECT AVG(ca2.Prezzo)
                    FROM CLIENTE c2 JOIN PRENOTA p2 ON (c2.NumTessera = p2.Cliente)
                        JOIN CAMERA ca2 ON (p2.Num = ca2.Num and p2.Piano = ca2.Piano))
                    WHERE c2.CittaResidenza = c.CittaResidenza);

-- ES C
SELECT COUNT(DISTINCT Cliente)
FROM PRENOTA
WHERE Cliente <> ALL(SELECT p.Cliente
                    FROM PRENOTA p JOIN camera c ON (p.Num = c.Num and 
                        p.Piano = c.Piano)
                    WHERE c.Tipo <> 'economica'
                    );