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
question_features
as select
postid as questionId,
owneruserid,
creationdate,
(time_to_sec(timediff('2014-09-14 11:00:00', creationdate))/3600) as time_diff,
case when acceptedanswerid = 0 then 0 else 1
end as target,
char_length(body) as length_body,
case when
tags like '%<regression>%' then 1 else 0
end as tag_regression,
case when tags like '%<r>%' then 1 else 0
end as tag_r,
case when tags like '%<time-series>%'
then 1 else 0
end as tag_timeseries,
case when tags like '%<machine-learning>%'
then 1 else 0
end as tag_ml,
case when tags like '%<probability>%'
then 1 else 0
end as tag_proba,
case when tags like '%<hypothesis-testing>%'
then 1 else 0
end as tag_hypotest,
case when tags like '%<distributions>%'
then 1 else 0
end as tag_dist,
case when tags like '%<self-study>%'
then 1 else 0
end as tag_selfstudy,
case when tags like '%<logistic>%'
then 1 else 0
end as tag_logistic,
case when tags like '%<correlation>%'
then 1 else 0
end as tag_corr,
case when tags like '%<statistical-significance>%'
then 1 else 0
end as tag_sig,
case when tags like '%<bayesian>%'
then 1 else 0
end as tag_bayes
from posts 
where (parentid = "" or parentid = 0)
and (time_to_sec(timediff('2014-09-14 11:00:00', creationdate))/3600) > 119
and owneruserid > 0;

select * from question_features;



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
case when websiteurl like '%http%' then 1 else 0
end
as website_given,
case when location != "" then 1 else 0
end as 
location_given,
age
from users where userid > 0;

desc user_features;

create or replace view analysis_mart
as select a.*, b.*
from question_features a
left join user_features b
on a.owneruserid = b.userid;




-- working with a table here cause views don't allow subselects
drop table if exists answered_questions;
create table answered_questions 
as select 
a.postid, a.owneruserid, a.creationdate, sum(b.question_count) as aq
from posts a
left join 
(select owneruserid, creationdate, count(postid) as question_count from
posts where acceptedanswerid != 0 group by 1,2) b 
on a.owneruserid = b.owneruserid 
and a.creationdate >= b.creationdate
where a.parentid = 0
group by a.postid, a.OwnerUserId;



create or replace view analysis_mart_w_answered_questions
as
select a.*, 
case when b.aq is NULL then 0
else b.aq
end  as questions_answered_to_date
from analysis_mart a
join answered_questions b
on a.questionid = b.postid;

select case when target = 1 then "Answered" else "Unanswered" end as Answer_status, 
round(count(questionid)/(select count(questionid) from analysis_mart_w_answered_questions)*100,3) as percentage
from analysis_mart_w_answered_questions group by 1;


select * from tune_grid;




select quantile, round(hours,2) as hours from quantiles where quantile like '%0%';