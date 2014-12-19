use stackexchange;

select 
case 
when age > 0 and age <= 19 then "under_20"
when (age >= 20 and age <= 30) then "20_to_30"
when age >= 30 and age <= 40 then "over_30"
when age >40 and age <= 50 then "over_40"
when age > 50 then "senior citizen"
else "NA"
end as age_group,
count(userid)
from users
group by 1;

select min(age) from Users;

select max(age) from Users;

select
avg(case when 
age > 0 then 1
else 0 
end) * 100 as age_indicated_perc 
from
Users;

select count(postid) as number_of_questions from Posts where ParentId = "";
select * from posts where parentid = "" and answercount = 0;



