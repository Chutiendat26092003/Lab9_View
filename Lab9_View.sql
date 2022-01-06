-- Bài 1
CREATE DATABASE Lab9_View
GO

USE Lab9_View
GO 

CREATE VIEW ProductList09
AS 
SELECT ProductID, Name
FROM AdventureWorks2019.Production.Product

SELECT * FROM ProductList09

-- Bài 2
CREATE VIEW SalesOrderDetail
AS 
SELECT pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty,  od.UnitPrice*od.OrderQty AS [Total Price]
FROM AdventureWorks2019.Production.Product od
JOIN AdventureWorks2019.Sales.SalesOrderDetail pr  
ON od.ProductID=pr.ProductID

SELECT * FROM SalesOrderDetail



--Phần 3
CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY IDENTITY,
	CustomerName varchar(50),
	Address varchar(100),
	Phone varchar (12)
)
GO 

CREATE TABLE Book
(
    BookCode int PRIMARY KEY,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
    Title varchar(100),
	Price int,
	InStore int
)
GO 

CREATE TABLE BookSold
(
    BookSoldID int PRIMARY KEY,
	CustomerID INT IDENTITY FOREIGN KEY REFERENCES Customer(CustomerID),
	BookCode int FOREIGN KEY REFERENCES Book(BookCode),
	Date datetime,
	Price int,
	Amount int
)
GO

INSERT INTO Customer VALUES ('Jack A','Ha Noi', '0988888666'),
                            ('Jack B','Ha Noi', '0988888888'),
							('Jack C','Ha Noi', '0988888777'),
							('Jack D','Ha Noi', '0988888111'),
							('Jack E','Ha Noi', '0988888555'),
							('Jack F','Ha Noi', '0988888222')

INSERT INTO Book VALUES (1000, 'Văn học', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100'),
                        (1001, 'Văn học', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100'),
						(1002, 'Kinh tế', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100'),
						(1003, 'Văn học', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100'),
						(1004, 'Kinh tế', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100'),
						(1005, 'Văn học', 'Anla', 'Kim Dong', 'Hoc IT', '100000', '100')

INSERT INTO BookSold VALUES (10000, 1, '1000', '2012-2-2', '90000','20'),
                            (10001, 2, '1001', '2012-2-2', '90000','20'),
							(10002, 2, '1002', '2012-2-2', '90000','20'),
							(10003, 2, '1003', '2012-2-2', '90000','20'),
							(10004, 3, '1004', '2012-2-2', '90000','20'),
							(10005, 3, '1005', '2012-2-2', '90000','20'),
							(10006, 4, '1005', '2012-2-2', '90000','20'),
							(10007, 5, '1003', '2012-2-2', '90000','20'),
							(10008, 5, '1002', '2012-2-2', '90000','20'),
							(10009, 5, '1004', '2012-2-2', '90000','20')




SELECT * FROM dbo.Customer 
SELECT * FROM dbo.Book
SELECT * FROM dbo.BookSold


CREATE VIEW BookAmout
AS
SELECT B.BookCode, B.Title, B.Price, BS.Amount
FROM dbo.Book AS B
JOIN dbo.BookSold  AS BS
ON B.BookCode = BS.BookCode


SELECT * FROM BookAmout


CREATE VIEW BookBuyAmout
AS
SELECT C.CustomerID, C.CustomerName, C.Address, SUM(Amount) AS BuyAmout
FROM dbo.Customer AS C
JOIN dbo.BookSold  AS BS
ON BS.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName, C.Address

SELECT * FROM BookBuyAmout


CREATE VIEW BookBuyAmout4
AS
SELECT C.CustomerID, C.CustomerName, C.Address, B.Author
FROM dbo.Customer AS C
JOIN dbo.BookSold  AS BS ON BS.CustomerID = C.CustomerID
JOIN dbo.Book AS B ON B.BookCode = BS.BookCode
WHERE MONTH(Date) = MONTH(Date) - 1 

SELECT * FROM BookBuyAmout4


CREATE VIEW BookBuyAmout5
AS
SELECT C.CustomerID, C.CustomerName, C.Address,
       BS.Price,SUM(Amount) AS BuyAmout , SUM(Price*Amout) AS PriceAmount
FROM dbo.Customer AS C
JOIN dbo.BookSold  AS BS ON BS.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName, C.Address, BS.Price, BS.Amount

SELECT * FROM BookBuyAmout5 









--Phần 4
CREATE TABLE Class
(
    ClassCode VARCHAR(10) PRIMARY KEY,
	HeadTeacher varchar(30),
	Room varchar(30),
	TimeSlot CHAR,
	CloseDate DATETIME
)
GO

CREATE TABLE Student
(
     RollNo varchar(10) PRIMARY KEY,
	 ClassCode VARCHAR(10) FOREIGN KEY REFERENCES Class(ClassCode),
	 FullName varchar(30),
	 Male BIT,
	 BirthDate DATETIME,
	 Address varchar(30),
	 Provice char(2),
	 Email varchar(30) 
)
GO
 
CREATE TABLE Subject 
(
    SubjectCode varchar(10) PRIMARY KEY,
	SubjectName VARCHAR(40),
	WMark BIT,
	PMark BIT,
	WTest_per INT,
	PTest_per INT
)
GO

CREATE TABLE Mark
(
    RollNo varchar(10) FOREIGN KEY REFERENCES Student(RollNo),
    SubjectCode varchar(10) FOREIGN KEY REFERENCES Subject(SubjectCode),
	WMark FLOAT,
	PMark FLOAT,
	Mark FLOAT 
)
GO


INSERT INTO Class VALUES ('C1007L', 'Jack A', 'Class 7', 'G', '2018-5-1'),
                         ('C1008L', 'Jack B', 'Class 8', 'I', '2020-5-1'),
						 ('C1009L', 'Jack C', 'Class 9', 'L', '2021-5-1'),
						 ('C1010L', 'Jack D', 'Class 10', 'M', '2021-9-1'),
						 ('C1011L', 'Jack E', 'Class 11', 'G', '2022-5-1')

INSERT INTO Student VALUES ('A00264', 'C1007L', 'Abraham A', '0', '1999-4-1','NewYork', 'NY', 'aa@gmail.com'),
                           ('A00265', 'C1007L', 'Abraham B', '1', '1999-1-1','NewYork', 'NY', 'ab@gmail.com'),
						   ('A00266', 'C1007L', 'Abraham C', '1', '2000-5-1','NewYork', 'NY', 'ac@gmail.com'),
						   ('A00267', 'C1008L', 'Abraham D', '0', '2000-6-1','NewYork', 'NY', 'ad@gmail.com'),
						   ('A00268', 'C1008L', 'Abraham E', '0', '2000-8-1','NewYork', 'NY', 'ae@gmail.com'),
						   ('A00269', 'C1007L', 'Abraham F', '0', '1999-2-1','NewYork', 'NY', 'af@gmail.com'),
						   ('A00270', 'C1009L', 'Abraham G', '1', '2000-10-1','NewYork', 'NY', 'ag@gmail.com'),
						   ('A00271', 'C1009L', 'Abraham H', '0', '1999-1-1','NewYork', 'NY', 'ah@gmail.com'),
						   ('A00272', 'C1010L', 'Abraham I', '0', '1999-1-1','NewYork', 'NY', 'ai@gmail.com'),
						   ('A00273', 'C1010L', 'Abraham K', '1', '2000-9-1','NewYork', 'NY', 'ak@gmail.com'),
						   ('A00274', 'C1011L', 'Abraham L', '1', '2000-11-1','NewYork', 'NY', 'al@gmail.com'),
						   ('A00275', 'C1011L', 'Abraham M', '0', '2000-2-1','NewYork', 'NY', 'am@gmail.com'),
						   ('A00276', 'C1007L', 'Abraham AN', '0', '1999-8-1','NewYork', 'NY', 'an@gmail.com')

INSERT INTO Subject VALUES ('EPC', 'Elementary Programing with C', '1', '1', 2, 3),
                           ('CF', 'Elementary Programing with C', '1', '1', 2, 3),
						   ('Java1', 'Java1', '1', '1', 2, 3)					
					
INSERT INTO Mark VALUES    ('A00264', 'EPC', 7, 8, NULL),
                           ('A00265', 'EPC', 6, 5, NULL),
						   ('A00266', 'EPC', 8, 8, NULL),
						   ('A00267', 'EPC', 7, 8, NULL),
						   ('A00268', 'CF', 10, 9 , NULL),
						   ('A00264', 'CF', 7, 8, NULL),
						   ('A00270', 'CF', 5, 5, NULL),
						   ('A00271', 'CF', 6, 6, NULL),
						   ('A00266', 'Java1', 6, 7,NULL),
						   ('A00273', 'Java1', 9, 9,NULL),
						   ('A00274', 'CF', 9, 6, NULL),
						   ('A00275', 'Java1', 6, 5,NULL),
						   ('A00276', 'Java1', 7, 8,NULL),
						   ('A00269', NULL, NULL , NULL, NULL),
						   ('A00272', NULL, NULL , NULL, NULL)

SELECT * FROM  dbo.Class
SELECT * FROM  dbo.Student
SELECT * FROM  dbo.Subject
SELECT * FROM  dbo.Mark

CREATE VIEW haibaithi AS
SELECT dbo.Mark.RollNo, ClassCode,FullName, COUNT(SubjectCode) AS SoMonThi
FROM dbo.Student
JOIN dbo.Mark ON Mark.RollNo = Student.RollNo
GROUP BY dbo.Mark.RollNo, ClassCode,FullName 
HAVING COUNT(SubjectCode) >= 2

SELECT * FROM haibaithi



CREATE VIEW truotmonthi  AS
SELECT s.RollNo, s.ClassCode, s.FullName,  m.WMark, m.PMark
FROM dbo.Student AS s 
JOIN dbo.Mark AS m ON m.RollNo = s.RollNo
WHERE WMark <=6 OR PMark <=6

SELECT * FROM truotmonthi



CREATE VIEW timeSlotG  AS
SELECT s.RollNo, s.ClassCode, s.FullName, TimeSlot
FROM dbo.Student AS s 
JOIN dbo.Class AS c ON c.ClassCode = s.ClassCode
WHERE TimeSlot = 'G'

SELECT * FROM timeSlotG



CREATE VIEW GiaoVien  AS
SELECT c.ClassCode, c.HeadTeacher, s.FullName, m.PMark, m.WMark, SUM(c.ClassCode)
FROM dbo.Class AS c
JOIN dbo.Student AS s ON s.ClassCode = c.ClassCode
JOIN dbo.Mark AS m ON m.RollNo = s.RollNo
WHERE WMark <=6 OR PMark <=6
GROUP BY c.ClassCode, c.HeadTeacher, s.FullName, m.PMark, m.WMark
HAVING SUM(HeadTeacher) >= 3

SELECT * FROM timeSlotG



CREATE VIEW GiaoVien  AS
SELECT  s.FullName, c.ClassCode, c.HeadTeacher,m.SubjectCode, m.PMark, m.WMark
FROM dbo.Class AS c
JOIN dbo.Student AS s ON s.ClassCode = c.ClassCode
JOIN dbo.Mark AS m ON m.RollNo = s.RollNo
WHERE m.SubjectCode = 'EPC' AND   ( WMark <=6 OR PMark <=6)
ORDER BY c.ClassCode 

SELECT * FROM timeSlotG





