--ES
select *
from libro
where Cod not in(select Cod from operacollettiva)
and Cod not in(select Cod from monografia);