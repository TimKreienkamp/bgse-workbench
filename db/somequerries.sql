

#Users
drop table userdata;
create table userdata
as 
select
	a.userid,
	a.reputation,
	a.creationdate,
    a.location,
    a.views,
    a.upvotes,
    a.downvotes,
    a.age,
    count(distinct(b.postid)) as totalposts,
    sum(b.score) as totalscore,
    sum(b.viewcount) totalviews,
    sum(b.answercount) as answersreceived,
    sum(b.commentcount) as commentsreceived,
    count(distinct c.name) as numberofbadges
from users a
left join posts b
on a.userid = b.owneruserid
left join badges c
on a.userid = c.userid
group by a.userid;

#Number of users per agegroup
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

#Average number of posts per user 
select avg(totalposts) from userdata;

#Average number of badges per user
select avg(numberofbadges) from userdata;





#Q&A
#We dont have any data on the answers, expect the answercount and the id of the accepted answer

#Number of posts last week
select count(postid)from posts where creationdate > '2014-09-07';
#Number of posts last month
select count(postid)from posts where creationdate > '2014-08-14';
#Number of posts last year
select count(postid)from posts where creationdate > '2013-09-14';

#Number of posts with accepted answer last week
select count(postid)from posts where creationdate > '2014-09-07' and acceptedanswerid <> 0;
#Number of posts with accepted answer last month
select count(postid)from posts where creationdate > '2014-08-14' and acceptedanswerid <> 0;
#Number of posts with accepted answer last year
select count(postid)from posts where creationdate > '2013-09-14' and acceptedanswerid <> 0;

#Percentage of posts with an accepted answer within last week
select avg(case when acceptedanswerid <>0 then 1 else 0 end) from posts where creationdate > '2014-09-07';
#Percentage of posts with an accepted answer within last week
select avg(case when acceptedanswerid <>0 then 1 else 0 end) from posts where creationdate > '2014-08-14';
#Percentage of posts with an accepted answer within last week
select avg(case when acceptedanswerid <>0 then 1 else 0 end) from posts where creationdate > '2013-09-14';

#Average number of answers for posts within the last week
select avg(answercount) from posts where creationdate > '2014-09-07';
#Average number of answers for posts within the last month
select avg(answercount) from posts where creationdate > '2014-08-14';
#Average number of answers for posts within the last year
select avg(answercount) from posts where creationdate > '2013-09-14';

#Average number of answers for posts within the last week
select avg(commentcount) from posts where creationdate > '2014-09-07';
#Average number of answers for posts within the last month
select avg(commentcount) from posts where creationdate > '2014-08-14';
#Average number of answers for posts within the last year
select avg(commentcount) from posts where creationdate > '2013-09-14';








#Topics
#I dont know how to join on multiple tag values that are given in the post table

use stackexchange;

select * from posts;

create or replace view tags
as
select
	a.tagid,
	a.tagname,
	count(distinct(b.postid)),
    sum(b.viewcount),
    sum(b.answercount),
    sum(b.commentcount),
    sum(b.favoritecount),
    acceptedanswerid
from tags a
left join posts b
on a.tagname = b.tags
WHERE b.tags='value'
group by a.tagid;
