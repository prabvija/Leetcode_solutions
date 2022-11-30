with distinct_col as (select distinct salary from Employee),
ranked as (Select salary,lead(salary,1) over (partition by null order by salary desc) as rank_var from distinct_col)

Select rank_var as SecondHighestSalary from ranked limit 1