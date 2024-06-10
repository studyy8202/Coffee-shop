select
r.date,
s.first_name,
s.last_name,
s.sal_per_hour,
sh.start_time,
sh.end_time,
(sh.end_time - sh.start_time)/10000 AS hour_work,
((sh.end_time - sh.start_time)/10000) * s.sal_per_hour as staff_cost 
from rotation r
left join staff s on r.staff_id = r.staff_id
left join shift sh on r.shift_id = sh.shift_id