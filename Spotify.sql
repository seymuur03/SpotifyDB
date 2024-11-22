CREATE DATABASE Spotify
USE Spotify


CREATE TABLE Musics
(
Id int primary key identity,
[Name] nvarchar(50) Not Null,
TotalSecond int CHECK (TotalSecond>90 AND TotalSecond<380),  --Check constarintini az işlədirik deyə burda isdifadə eləmək istədim,praktika üçün
Listener_Count int,
AlbumId int foreign key references Albums(Id)
)

CREATE TABLE Artists
(
Id int primary key identity,
[Name] nvarchar(50) Not Null,
Gender nvarchar(30) 
)

CREATE TABLE Albums
(
Id int primary key identity,
[Name] nvarchar(50) Not Null,
Created_Date datetime,
ArtistId int foreign key references Artists(Id)  --OneToMany kimi yanaşdım
)


INSERT INTO Artists VALUES 
('Eminem','Male'),
('Drake','Male')
SELECT * FROM Artists

INSERT INTO Albums VALUES 
('Revival','2017.12.15 00:00:00',1),
('Recovery','2010.06.18 00:00:00',1),
('Scorpion','2018.06.18 00:00:00',2),
('Views','2016.04.29 00:00:00',2)
SELECT * FROM Albums

INSERT INTO Musics VALUES 
('River',221,1500000,1),
('Remind Me',226,1450000,1),
('Believe',315,2340000,1),
('On Fire',304,900000,2),
('Not Afraid',249,870000,2),
('Elevate',305,650000,3),
('Survival',136,646800,3),
('Emotionless',302,1000000,3),
('U with me',291,1200000,4),
('Hype',208,120000,4)
SELECT * FROM Musics


--Task A :
CREATE VIEW MusicDetails
AS
SELECT m.Name AS 'MusicName',m.TotalSecond,ar.Name AS 'ArtistName',a.Name AS 'AlbumName'  FROM Musics m
JOIN 
Albums a
ON 
m.AlbumId=a.Id
JOIN 
Artists ar
ON 
a.ArtistId=ar.Id

SELECT * FROM MusicDetails


--Task B :
CREATE VIEW AlbumDetails 
AS
SELECT al.Name,COUNT(m.AlbumId) AS 'Count_of_musics' FROM Albums al
JOIN 
Musics m
ON 
m.AlbumId=al.Id
GROUP BY al.Id,al.Name,al.Created_Date,al.ArtistId

SELECT * FROM AlbumDetails


--Task C :
CREATE PROCEDURE Details @listenerCount int,@search nvarchar(30)
AS
SELECT m.Name AS 'MusicName',m.Listener_Count,al.Name AS 'AlbumName' FROM Musics m
JOIN 
Albums al
ON
m.AlbumId=al.Id
WHERE Listener_Count>@listenerCount AND al.Name LIKE '%'+@search+'%'

EXEC Details 1000000,iE