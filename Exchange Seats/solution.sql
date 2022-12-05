with seats as (Select *,lag(student,1,student) over (partition by null order by id desc) as lag_id,
              lead(student,1,student) over (partition by null order by id desc) as lead_id from Seat),
lead_sep as (Select id,lead_id as new_id from seats where mod(id,2)=0),
lag_sep as (Select id,lag_id as new_id from seats where mod(id,2)=1)

Select id,new_id as student from (select id,new_id from lead_sep union select id,new_id from lag_sep) as T order by id asc