CREATE DATABASE V_P_F_T      --View_Procedure_Function_Trigger
USE V_P_F_T

CREATE TABLE Students
(
Id int primary key identity,
[Name] nvarchar(20),
Surname nvarchar(20),
Age int,
QuizId int foreign key references Quizes(Id)
)

CREATE TABLE Quizes 
(
Id int primary key identity,
VARIANT nvarchar
)

INSERT INTO Quizes VALUES 
('A'),
('B'),
('C')

INSERT INTO Students VALUES 
('Seymur','Mammadov',19,1),
('Lorem','Ipsumov',20,1),
('Filan','Filankesov',18,2),
('Any','One',19,3)

--View
CREATE VIEW StudentDetails
AS
SELECT s.*,q.VARIANT FROM Students s
JOIN 
Quizes q
ON
q.Id=s.QuizId
WHERE s.Name LIKE '%M%'

SELECT * FROM StudentDetails

--Procedure
CREATE PROCEDURE Details @x nvarchar(20)
AS
SELECT s.*,q.VARIANT FROM Students s
JOIN 
Quizes q
ON
q.Id=s.QuizId
WHERE s.Name LIKE CONCAT('%',@x,'%')

EXEC Details a

--Function
CREATE FUNCTION Func()
RETURNS int
AS BEGIN 
DECLARE @x int
SELECT @x = SUM(Age) FROM StudentDetails
RETURN @x
END

SELECT dbo.Func()

--Trigger
CREATE TRIGGER trig
ON 
Students 
FOR INSERT,DELETE
AS
SELECT * FROM Students

INSERT INTO Students VALUES
('Salam','Aleykum',50,2)

DELETE FROM Students WHERE Surname LIKE 'a__%'  -- a ile baslayir ve en azi 3 herflidi


