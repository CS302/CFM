-- ******************************************** --
-- SQL DML Script
-- Файл: CFM.sql
-- Язык: Transact-SQL
-- СУБД: MS SQL Server 2014
-- Среда разработки: MS Management Studio 2014
-- Автор: Бирюкова К.С.
-- ВКРБ: Распределенная информационная система
-- для отслеживания состояния пилотов на основе
-- измерений КЧСМ с web-доступом.
-- 2017 год.
-- ******************************************** --

-- скрипт для создания таблиц реляционной базы данных.

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_login')
DROP PROCEDURE cfm_login
GO
CREATE PROCEDURE cfm_login
    @Login varchar(30),
    @Password varchar(255)
AS
BEGIN
    SELECT id FROM dbo.doctor
	WHERE login = @Login AND password = @Password
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_insert_measure')
DROP PROCEDURE cfm_insert_measure
GO
CREATE PROCEDURE cfm_insert_measure
    @Pat_id int,
    @Doc_id int,
	@Mes decimal(4, 2)
AS
BEGIN
	DECLARE @id int	
	SET @id = isnull((SELECT MAX(id) FROM dbo.measure), 0) + 1

    INSERT INTO dbo.measure(id, patient_id, doc_id, crit_f)
	VALUES(@id, @Pat_id, @Doc_id, @Mes)
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_read_measures')
DROP PROCEDURE cfm_read_measures
GO
CREATE PROCEDURE cfm_read_measures
    @Pat_id int
AS
BEGIN
    SELECT crit_f FROM dbo.measure
	WHERE patient_id = @Pat_id
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_read_personal')
DROP PROCEDURE cfm_read_personal
GO
CREATE PROCEDURE cfm_read_personal
    @Pat_id int
AS
BEGIN
    SELECT person.name, person.surname, company.name AS c_name, position.name AS p_name
	FROM dbo.person JOIN dbo.patient ON patient.person_id = person.id JOIN dbo.company ON person.company_id = company.id
	JOIN dbo.position ON person.position_id = position.id
	WHERE patient.id = @Pat_id
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_read_diagnosis')
DROP PROCEDURE cfm_read_diagnosis
GO
CREATE PROCEDURE cfm_read_diagnosis
    @Pat_id int
AS
BEGIN
    SELECT diagnosis FROM dbo.diagnostic
	WHERE patient_id = @Pat_id
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_insert_cure')
DROP PROCEDURE cfm_insert_cure
GO
CREATE PROCEDURE cfm_insert_cure
    @Pat_id int,
	@Doc_id int,
	@Date1 date,
	@Date2 date
AS
BEGIN
	DECLARE @id int	
	SET @id = isnull((SELECT MAX(id) FROM dbo.cure), 0) + 1
	
    INSERT INTO dbo.cure (id, patient_id, doc_id, date_start, date_end)
	VALUES (@id, @Pat_id, @Doc_id, @Date1, @Date2)
END
GO

--

IF  EXISTS (SELECT * FROM sys.objects WHERE name = 'cfm_insert_diagnosis')
DROP PROCEDURE cfm_insert_diagnosis
GO
CREATE PROCEDURE cfm_insert_diagnosis
    @Pat_id int,
	@Doc_id int,
	@Diagnosis varchar(2500)
AS
BEGIN
	DECLARE @id int	
	SET @id = isnull((SELECT MAX(id) FROM dbo.diagnostic), 0) + 1
	
    INSERT INTO dbo.diagnostic(id, patient_id, doctor_id, diagnosis)
	VALUES (@id, @Pat_id, @Doc_id, @Diagnosis)
END
GO

-- ******************************************** --
-- конец скрипта для создания хранимых процедур
-- ******************************************** --

-- ******************************************** --
-- конец файла CFM.sql
-- ******************************************** --