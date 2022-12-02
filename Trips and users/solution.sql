With drivers as (Select users_id as driver_user, banned as drivers_banned from Users where role='driver'),
client as (Select users_id as client_user, banned as client_banned from Users where role='client'),
enhanced as (Select *, case 
        when status like '%cancelled%' then 1 
        else 0 end as status_bool
from Trips T 
left join drivers d on T.driver_id=d.driver_user 
left join client c on T.client_id=c.client_user
where drivers_banned='No' and client_banned='No'),
grouped as (select request_at,sum(status_bool) as sum_status_bool,count(status) as total_count from enhanced group by request_at)

Select request_at as Day, 
case 
    when sum_status_bool=0 then 0.00
    else Round((sum_status_bool/total_count),2) end as "Cancellation Rate"
from grouped group by request_at 
having Day between '2013-10-01' and '2013-10-03'