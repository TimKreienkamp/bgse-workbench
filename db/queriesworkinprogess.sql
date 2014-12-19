create or replace view activity_daily as
select extract(year_month from date(creationdate)) as YearMonth, yearweek(date(CreationDate)) as Year_Week, date(CreationDate) as Date,  UserId from Votes where votes.UserId > 0
UNION All
select extract(year_month from date(creationdate)) as YearMonth, yearweek(date(CreationDate)) as Year_Week, date(CreationDate) as Date,  UserId from Comments where Comments.UserId > 0
Union All
select extract(year_month from date(creationdate)) as YearMonth, yearweek(date(CreationDate)) as Year_Week, date(CreationDate) as Date,  OwnerUserId from Posts where Posts.OWnerUserID > 0 and posts.ParentId = "";
;

create or replace view monthly_activity 
as select yearmonth,
count(distinct userId)as active_users
from activity_daily
group by YearMonth;

create or replace view weekly_activity 
as select year_week,
count(distinct userId)as active_users
from activity_daily
group by Year_week;


create or replace view MAU_WAU_DAU
as
select a.date, count(distinct a.userid) as DAU, b.active_users as WAU, c.active_users as MAU
from activity_daily a
left join 
weekly_activity b
on a.Year_week = b.Year_week
left join
monthly_activity c
on a.yearmonth = c.yearMOnth
where a.date < '2014-09-14'
group by a.date limit 2000;


select * from posts;

desc posts;

select * from Posts where AcceptedAnswerId > 0 and ParentId = 0;



select b.date,
count(distinct a.UserId) as DAU,
count(distinct c.UserId) as WAU,
count(distinct b.Userid) as MAU
from activity_daily a
join 
(select date, userid from activity_daily group by yearmonth) b
on a.date = b.date
join (select date, userid from activity_daily group by year_week)c
on a.date = c.date
group by 1;

use stackexchange;
select * from MAU_WAU_DAU;

select yearweek(Date), count(distinct userid) from activity_daily group by 1;


select date,mau,wau from mau_wau_dau;


desc posts;

desc badges;

select * from posts;

select * from postlinks;


select count(postid) from posts where answercount = 0 and parentid = 0;
select count(postid) from posts;

create or replace view questions_answers_time
as
select a.postid as question, b.postid as answer,  
a.CreationDate as date_asked,
b.CreationDate as date_answered,
time_to_sec(timediff(b.creationdate, a.creationdate))/3600 as time_elapsed
from posts a
join posts b
on a.acceptedanswerid = b.postid where  a.parentid = 0 and a.AcceptedAnswerId != 0;


select * from questions_answers_time order by 5;


create or replace view
analysis_datamart
as select
a.postid as question;

create or replace view user_features
as select
userid, Reputation,
case when CreationDate between '2009-01-01' and '2009-12-31' then 1 else 0
end as
creation_year_2009,
case when CreationDate between '2010-01-01' and '2010-12-31' then 1 else 0
end as
creation_year_2010,
case when CreationDate between '2011-01-01' and '2011-12-31' then 1 else 0
end as
creation_year_2011,
case when CreationDate between '2012-01-01' and '2012-12-31' then 1 else 0
end as
creation_year_2012,
case when CreationDate between '2013-01-01' and '2013-12-31' then 1 else 0
end as
creation_year_2013,
case when CreationDate between '2014-01-01' and '2014-12-31' then 1 else 0
end as
creation_year_2014,
case when website_url like '%http%' then 1 else 0
end
as website_given


from users;

select * from user_features;

desc users;
