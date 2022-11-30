# Write your MySQL query statement below

with combined as (select D.name as Department, 
                  E.name as Employee, 
                  E.Salary as Salary,
                  dense_rank() over (partition by D.name order by E.Salary desc) as ranked from Employee E left join Department D on E.departmentId=D.id)
                  
Select Department, Employee,Salary from combined where ranked<=3

