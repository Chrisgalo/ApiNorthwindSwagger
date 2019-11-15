CREATE TABLE "Employees" (
	"EmployeeID" "int" IDENTITY (1, 1) NOT NULL ,
	"LastName" nvarchar (20) NOT NULL ,
	"FirstName" nvarchar (10) NOT NULL ,
	"Title" nvarchar (30) NULL ,
	"TitleOfCourtesy" nvarchar (25) NULL ,
	"BirthDate" "datetime" NULL ,
	"HireDate" "datetime" NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"HomePhone" nvarchar (24) NULL ,
	"Extension" nvarchar (4) NULL ,
	"Photo" "image" NULL ,
	"Notes" "ntext" NULL ,
	"ReportsTo" "int" NULL ,
	"PhotoPath" nvarchar (255) NULL ,
	CONSTRAINT "PK_Employees" PRIMARY KEY  CLUSTERED 
	(
		"EmployeeID"
	),
	CONSTRAINT "FK_Employees_Employees" FOREIGN KEY 
	(
		"ReportsTo"
	) REFERENCES "dbo"."Employees" (
		"EmployeeID"
	),
	CONSTRAINT "CK_Birthdate" CHECK (BirthDate < getdate())
)
GO
 CREATE  INDEX "LastName" ON "dbo"."Employees"("LastName")
GO
 CREATE  INDEX "PostalCode" ON "dbo"."Employees"("PostalCode")
GO

--Creamos el trigger
--Este trigger esta basado en saber cuando se agrega un nuevo empleado
--sera estilo auditoria y se vera el nombre del empleado registrado y la fecha en que se creo
CREATE TABLE "Log_historial" (
	"EmployeeID" "int" IDENTITY (1, 1) NOT NULL ,
	"LastName" nvarchar (20) NOT NULL ,
	"FirstName" nvarchar (10) NOT NULL ,
	"Fecha Registro" "datetime" NULL, 
	"Title" nvarchar (30) NULL ,
	"TitleOfCourtesy" nvarchar (25) NULL ,
	"BirthDate" "datetime" NULL ,
	"HireDate" "datetime" NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"HomePhone" nvarchar (24) NULL ,
	"Extension" nvarchar (4) NULL
)


create trigger TR_Employee_insert
	on Employees
	for insert
	as
	begin 
	set nocount on; --evita que se muestre que se hallan hecho cambios en alguna tabla
	insert into log_historial("EmployeeID","LastName","FirstName","Fecha Registro","Title","TitleOfCourtesy","BirthDate","HireDate","Address","City",
	"Region","PostalCode","Country","HomePhone","Extension")
	select EmployeeID,LastName,FirstName, getdate(),Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,
	Region,PostalCode,Country,HomePhone,Extension
	from inserted
end

	INSERT "Employees"("EmployeeID","LastName","FirstName","Title","TitleOfCourtesy","BirthDate","HireDate","Address","City","Region","PostalCode","Country","HomePhone","Extension")VALUES(1,'Davolio','Nancy','Sales Representative','Ms.','12/08/1948','05/01/1992','507 - 20th Ave. E.Apt. 2A','Seattle','WA','98122',
	'USA','(206) 555-9857','5467')