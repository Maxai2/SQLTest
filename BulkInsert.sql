CREATE TABLE Groups
(
	Id int PRIMARY KEY,
	Group_Name nvarchar(20) NOT NULL
)

BULK INSERT Groups
FROM 'C:\TempSQL\groups2.txt'
WITH
(
	--FIELDTERMINATOR = '\t"',
	--ROWTERMINATOR = '"\n',
	FORMATFILE = 'C:\TempSQL\gr.fmt',
	CODEPAGE = '65001' -- UTF-8
)

SELECT *
FROM Groups

DELETE FROM Groups

CREATE TABLE Students
(
	Id int PRIMARY KEY,
	First_Name nvarchar(30) NOT NULL,
	Last_Name nvarchar(30) NOT NULL,
	Group_Id int NOT NULL,

	CONSTRAINT FK_Stud_GroupId FOREIGN KEY (Group_Id) REFERENCES Groups(Id)
)

BULK INSERT Students
FROM 'C:\TempSQL\studs.txt'
WITH
(
	FORMATFILE = 'C:\TempSQL\stud.fmt',
	CODEPAGE = '65001'
)

SELECT *
FROM Students

--bcp FSDM_1711.dbo.Students format nul -f C:\TempSQL\stud.fmt -c -T

/*13.0
4
1       SQLCHAR             0       12      "\tN'"     1     Id                       ""
2       SQLCHAR             0       60      "'\tN'"     2     First_Name               ""
3       SQLCHAR             0       60      "'\t"     3     Last_Name                ""
4       SQLCHAR             0       12      "\r\n"   4     Group_Id                 ""
*/

--2	N'¬€чеслав'	N'«език'	3