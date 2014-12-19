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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/badges.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/comments.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/posthistory.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/postlinks.csv' 
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


LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/posts.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/tags.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/users.csv' 
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

LOAD DATA LOCAL INFILE '/Users/timkreienkamp/Documents/Studium/data_science/computing_lab/project/bgse-workbench/data/votes.csv' 
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


