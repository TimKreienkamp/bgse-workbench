DROP DATABASE IF EXISTS stackexchange;
CREATE database stackexchange;
USE stackexchange;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS Badges;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Badges` (
  `BadgeID` int,
  `UserId` int,
  `Name` varchar(50),
  `Date` date,
  PRIMARY KEY (`BadgeID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE './data/badges.csv' 
INTO TABLE Badges 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS Comments;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comments` (
  `CommentId` int,
  `PostId` int,
  `Score` int,
  `Text` varchar(600),
  `CreationDate` datetime,
  `UserId` int,
  `UserDisplayName` varchar(30),
  PRIMARY KEY (`CommentID`)
);

LOAD DATA LOCAL INFILE './data/comments.csv' 
INTO TABLE Comments 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS PostHistory;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PostHistory` (
  `PostHistoryID` int,
  `PostId` int,
  `Score` int,
  `Text` varchar(8000),
  `CreationDate` datetime,
  `UserId` int,
  `UserDisplayName` varchar(40),
  PRIMARY KEY (`PostHistoryID`)
);

LOAD DATA LOCAL INFILE './data/posthistory.csv' 
INTO TABLE PostHistory 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS PostLinks;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PostLinks` (
  `PostLinkId` int,
  `CreationDate` datetime,
  `PostId` int,
  `RelatedPostId` int,
  `LinkTypeId` tinyint,
  PRIMARY KEY (`PostLinkId`)
);

LOAD DATA LOCAL INFILE './data/postlinks.csv' 
INTO TABLE PostLinks 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS Posts;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Posts` (
  `Rowname` int,
  `PostId` int,
  `PostTypeId` tinyint,
  `AcceptedAnswerId` int,
  `ParentId` int,
  `CreationDate` datetime,
  `Score` int,
  `ViewCount` int,
  `Body` varchar(8000),
  `OwnerUserId` int,
  `OwnerDisplayName` varchar(40),
  `LastEditorUserId` int,
  `LastEditorDisplayName` varchar(40),
  `LastEditDate` datetime,
  `LastActivityDate` datetime,
  `Title` varchar(250),
  `Tags` varchar(150),
  `AnswerCount` int,
  `CommentCount` int,
  `FavoriteCount` int,
  `ClosedDate` datetime,
  `CommunityOwnedDate` datetime,
  PRIMARY KEY (`PostId`)
);


LOAD DATA LOCAL INFILE './data/posts.csv' 
INTO TABLE Posts 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS Tags;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tags` (
  `TagId` int,
  `TagName` varchar(25),
  `Count` int,
  `ExcerptPostId` int,
  `WikiPostId` int,
  PRIMARY KEY (`TagId`)
);

LOAD DATA LOCAL INFILE './data/tags.csv' 
INTO TABLE Tags 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS Users;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `UserId` int,
  `Reputation` int,
  `CreationDate` datetime,
  `DisplayName` varchar(40),
  `LastAccessDate` datetime,
  `WebsiteUrl` varchar(200),
  `Location` varchar(100),
  `AboutMe` varchar(8000),
  `Views` int,
  `UpVotes` int,
  `DownVotes` int,
  `AccountId` int,
  `Age` int,
  `ProfileImageUrl` varchar(200),
  PRIMARY KEY (`UserId`)
);

LOAD DATA LOCAL INFILE './data/users.csv' 
INTO TABLE Users 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS Votes;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Votes` (
  `VoteId` int,
  `PostId` int,
  `VoteTypeId` tinyint,
  `CreationDate` datetime,
  `UserId` int,
  `BountyAmount` int,
  PRIMARY KEY (`VoteId`)
);

LOAD DATA LOCAL INFILE './data/votes.csv' 
INTO TABLE Votes 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
/*!40101 SET character_set_client = @saved_cs_client */;


-- alter table

SET SQL_SAFE_UPDATES = 0;

update posts set owneruserid = NULL where OwnerUserId = 0;




alter table badges
add foreign key (userid)
references users (userid);
alter table posts
add foreign key (owneruserid)
references users (userid);


update posthistory set postid = NULL where postid = 23974; -- user id 23974 doesn't exist in parent table
update comments set postid = NULL where postid = 23974; -- user id 23974 doesn't exist in parent table
update comments set userid = NULL where userid = 0;
update posthistory set userid = NULL where userid = 0;
update postlinks set postid = NULL where  postid = 23974;
update postlinks set postid = NULL where postid not in (select postid from posts);
update votes set userid = NULL where userid = 0;

alter table posthistory
add foreign key (postid)
references posts (postid);

alter table posthistory
add foreign key (userid)
references users (userid);

alter table comments
add foreign key (postid)
references posts (postid);

alter table comments 
add foreign key (userid)
references users (userid);

alter table postlinks 
add foreign key (postid)
references posts (postid);

alter table votes 
add foreign key (userid)
references users (userid);







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

create or replace view analysis_mart
as select a.*, b.*
from question_features a
left join user_features b
on a.owneruserid = b.userid;


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
    count(distinct(c.Name)) as numberofbadges
from users a
left join posts b
on a.userid = b.owneruserid
left join badges c
on a.userid = c.userid
group by 1;

create or replace view users_acquired_weekly
as select
left(yearweek(creationdate),4) as year,
right(yearweek(creationdate),2) as week,
count(distinct userid) as users
from users
group by 1,2
having year is not null
;


create or replace view questions_asked_weekly
as
select 
	left(yearweek(creationdate), 4) as year,
	right(yearweek(a.creationdate),2)as week, 
	count(distinct a.postid) as questions_asked
from posts a
where yearweek(creationdate) > 201029  
group by 1,2
;



drop table if exists answer_share_weekly;
create table answer_share_weekly as select 
	left(yearweek(a.creationdate),4) as year,
    right(yearweek(a.creationdate),2) as week,
	count(distinct a.postid) as questions_asked,
    round(count(distinct b.postid)/count(distinct a.postid)*100,2) as percentage_answered
from 
posts a 
left join
(select yearweek(creationdate) as week, postid
from posts where (acceptedanswerid != '' or acceptedanswerid != 0) and parentid = '') b
on yearweek(a.creationdate)= b.week
where a.parentid = ''
group by 1,2
;

drop table if exists topics;
create table
topics 
as select
distinct(a.tagname), 
sum(b.commentcount) as comments,
sum(b.viewcount) as views,
sum(b.answercount) as answers
from tags a
left join posts b
on b.tags like concat('%',a.tagname, '%') 
group by 1;

create or replace view questions_answers_time
as
select a.postid as question, b.postid as answer,  
a.CreationDate as date_asked,
b.CreationDate as date_answered,
time_to_sec(timediff(b.creationdate, a.creationdate))/3600 as time_elapsed
from posts a
join posts b
on a.acceptedanswerid = b.postid where  a.parentid = 0 and a.AcceptedAnswerId != 0;

create index user_date_index 
on users (creationdate);

create index post_data_index
on posts (creationdate);

create index user_index 
on users (userid);

create index post_index
on posts (postid);
