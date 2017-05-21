-- ******************************************** --
-- SQL DDL Script
-- Файл: model.sql
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

-- таблица людей, участвующих в обследовании,
-- явлвяется общей частью для пациента и врача.
CREATE TABLE person(
	id			int NOT NULL,			-- id
	name		varchar(15) NOT NULL,	-- имя
	surname		varchar(20) NOT NULL,   -- фамилия
	company_id	int NULL,			    -- место аботы
	position_id	int NULL,      			-- должность (старший, младший)
	                                                
	PRIMARY KEY (id)                                
)                                                   
GO                                                  
                                                    
-- таблица пациентов                                
CREATE TABLE patient(                               
	id			int NOT NULL,     		-- id
	person_id	int NOT NULL,     		-- id участника обследования
	adress		varchar(100) NULL,		-- адрес
	blood_type  varchar(2) NULL,  		-- группа крови
	
	PRIMARY KEY (id)
)
GO

-- таблица врачей
CREATE TABLE doctor(
	id			int NOT NULL,          	-- id
	person_id	int NOT NULL,          	-- id врача
	login		varchar(30) NOT NULL,   -- логин врача
	password	varchar(255) NOT NULL,  -- пароль врача
	
	PRIMARY KEY (id)
)
GO

-- таблица компаний
CREATE TABLE company(
	id 			int NOT NULL, 			-- id		
	name		varchar(50) NOT NULL,	-- название компании
	activity    varchar(100) NULL,		-- область деятельности
	
	PRIMARY KEY (id)
)
GO

-- таблица должностей
CREATE TABLE position(
	id			int NOT NULL,			-- id
	name		varchar(100) NOT NULL,  -- наименование должности
	lvl			varchar(20) NULL,		-- должность (старший, младший)
		
	PRIMARY KEY (id)
)
GO

-- таблица лекарств
CREATE TABLE meds(
	id			int NOT NULL,			-- id
	med_type	varchar(50) NOT NULL,	-- тип лекарственного средства
	name		varchar(150) NOT NULL,	-- название препарата
	
	PRIMARY KEY(id)
)
GO

-- таблица принимаемых лекарств
CREATE TABLE cure(
	id			int NOT NULL,			-- id
	patient_id	int NULL,			    -- id пациента
	doc_id		int NULL,				-- id врача
	meds_id		int NULL,			    -- id лекарства
	date_start	date NULL,			    -- дата начала приема
	date_end	date NULL,			    -- дата конца приема
	                                                
	PRIMARY KEY(id)                                 
)
GO                                                   
                                                    
-- таблица результатов измерения КЧСМ               
CREATE TABLE measure(                               
	id 			int NOT NULL,			-- id
	patient_id 	int NOT NULL,			-- id пациента
	doc_id 		int NOT NULL,			-- id доктора
	crit_f 		decimal(4,2) NOT NULL,	-- КЧСМ
	                                                
	PRIMARY KEY(id)                                 
)
GO                                                   
                                                    
-- таблица посещений                                
CREATE TABLE diagnostic(                            
	id			int NOT NULL,           -- id
	patient_id	int NOT NULL,           -- id пациента
	doctor_id	int NOT NULL,           -- id врача
	diagnosis	varchar(2500) NULL,     -- диагнозы
	d_comment	varchar(5000) NULL,		-- комментарии к диагнозу
	lat_visit	date NULL,	            -- последнее посещение
	susp_till	date NULL,              -- время больничного (возможная нетрудоспообность до такого-то числа)
	
	PRIMARY KEY (id)
)
GO

-- ******************************************** --
-- конец скрипта для создания таблиц
-- ******************************************** --

-- скрипт для создания внешних ключей

-- внешний ключ diagnostic -> patient
ALTER TABLE diagnostic
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

-- внешний ключ diagnostic -> doctor
ALTER TABLE diagnostic
    ADD FOREIGN KEY (doctor_id)
		REFERENCES doctor
GO

-- внешний ключ doctor -> person
ALTER TABLE doctor
    ADD FOREIGN KEY (person_id)
		REFERENCES person
GO

-- внешний ключ patient -> person
ALTER TABLE patient
    ADD FOREIGN KEY (person_id)
		REFERENCES person
GO

-- внешний ключ person -> company
ALTER TABLE person
    ADD FOREIGN KEY (company_id)
		REFERENCES company
GO

-- внешний ключ person -> position
ALTER TABLE person
    ADD FOREIGN KEY (position_id)
		REFERENCES position
GO

-- внешний ключ cure -> meds
ALTER TABLE cure
    ADD FOREIGN KEY (meds_id)
		REFERENCES meds
GO

-- внешний ключ cure -> doctor
ALTER TABLE cure
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO

-- внешний ключ cure -> patient
ALTER TABLE cure
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

-- внешний ключ measure -> patient
ALTER TABLE measure
    ADD FOREIGN KEY (patient_id)
		REFERENCES patient
GO

-- внешний ключ measure -> doctor
ALTER TABLE measure
    ADD FOREIGN KEY (doc_id)
		REFERENCES doctor
GO

-- ******************************************** --
-- конец скрипта для создания внешних ключей
-- ******************************************** --

-- ******************************************** --
-- конец файла model.sql
-- ******************************************** --