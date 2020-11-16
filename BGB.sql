-- База данных брокера банковсих гарантий
-- Описание БД
-- База данных предназначена для хренения информации связанной с деятельностью брокера банковских гарантий.
-- Описание таблиц

-- Таблица company - содержит информацию о компаниях(клиентах) , Наименование, ИНН, Дата регистрации...

-- Таблица contact_persons - предназначена для хранения информации о контактных лицах компаний и банков.
-- В ней присутствуют поля для хранения Имени, Даты рождения, email...

-- Таблица phones - предназначена для хранения номеров телелефонов контактных лиц

-- Таблица banks - здесь храниться информация о банках, Наименование банка...

-- Таблица banks_request - это таблица по запросам в банк. Храним в ней информацию о номере заявки и её сумме в разрезе банка.

-- Таблица zakupki - Информация о закупках, Номер, сумма банковкой гарантии, закон...

-- Таблица individuals - для хранения информации о физических лицах

-- Таблица agents - агенты, процентные ставки для начисления вознаграждений

-- Таблица adress - адреса компаний, банков...

-- Таблица contracts - информация о совершаемых сделках

-- Таблица customer_rating - ранжирование клиентов

drop database if exists BGB;
create database BGB;
use BGB;

drop table if exists companies;									-- 1 Таблица клиентов
create table companies(
	id serial primary key,
	inn varchar(12) unique,                             		-- ИНН 
	name varchar(50) unique,									-- Наименование
	index(name)
);

drop table if exists banks; 									-- 2 Таблица банков
create table banks(
	id serial primary key,
	name varchar(50), 											-- Наименование банка
	comment text,
	index(name)
);


drop table if exists banks_request; 							-- 3 Таблица запросов в банк
create table banks_request(
	id serial primary key,
	bank_id bigint unsigned,
	number_request varchar(50), 								-- Номер заявки
	sum_request DECIMAL(15,2),									-- Сумма заявки
	comment text,
	index(number_request),
	foreign key (bank_id) references banks (id)
);

drop table if exists individuals; 								-- 4 Таблица физических лиц
create table individuals(
	id serial primary key,
	name varchar(50), 				 								-- ФИО  
	birthday date,													-- Дата рождения
	email varchar(120) unique,										-- email
	comment text,
	index(name)
);

drop table if exists contact_persons; 								-- 5 Таблица котактных лиц
create table contact_persons(
	id serial primary key,
	company_id bigint unsigned, 
	individual_id bigint unsigned,
	proprietor bool,  												-- Является ли контактное лицо собственником
	email varchar(120),												-- email
	spam bool, 														-- Делать или нет рассылку
	comment text,
	foreign key (company_id) references companies (id),
	foreign key (individual_id) references individuals (id)
);
 
drop table if exists agents; 										-- 6 Таблица агентов 
create table agents(
	id serial primary key,
	agent_commission double,
	individual_id bigint unsigned,
	comment text,
	foreign key (individual_id) references individuals (id)
);

drop table if exists phones; 										-- 7 Таблица телефонных номеров
create table phones(
	id serial primary key,
	contact_person_id bigint unsigned,
	individual_id bigint unsigned,
	phone bigint,													-- Номер телефона
	whats_app bool,	                                                -- Номер есть в Whats app
	index(phone),
	foreign key (contact_person_id) references contact_persons (id),
	foreign key (individual_id) references individuals (id)
);

drop table if exists zakupki; 								        -- 8 Таблица закупок
create table zakupki(
	id serial primary key,
	number_zakupki varchar(100), 								    -- Номер закупки
	sum_zakupki DECIMAL(15,2),										-- Сумма закупки
	zakon enum('44-ФЗ','223-ФЗ') default '44-ФЗ',					-- Закон
	srok int,                                                       -- Срок, количество дней	
	comment text
);

drop table if exists adress; 								        -- 9 Таблица адресов
create table adress(
	id serial primary key,
	company_id bigint unsigned,
	contact_person_id bigint unsigned,
	adress text,
	comment text,
	foreign key (company_id) references companies (id),
	foreign key (contact_person_id) references contact_persons (id)
);

drop table if exists contracts; 								    -- 10 Таблица сделок
create table contracts(
	id serial primary key,
	bank_request_id bigint unsigned,
	agent_id bigint unsigned,
	zakupki_id bigint unsigned,
	company_id bigint unsigned,
	number_contract bigint,
	сommission double,
	сommission_remuneration double,
	status enum('На рассмотрении', 'Есть предложения', 'На согласовании текст', 'Выставлена платёжка', 'Оплачено', 'Выдана', 'Отказ клиента', 'Отказ банка', 'Выдана и занесена в пчёлку', 'Пока неактуально', 'Заявка неактуальная'  ) default 'На рассмотрении',  												-- Является ли контактное лицо собственником
    comment text,
  	created_at datetime default current_timestamp,
  	foreign key (bank_request_id) references banks_request(id),
  	foreign key (agent_id) references agents(id),
  	foreign key (zakupki_id) references zakupki(id),
  	foreign key (company_id) references companies(id)
);

drop table if exists customer_rating; 								-- 11 Таблица рейтинга 
create table customer_rating(
	id serial primary key,
	company_id bigint unsigned,
	-- количество сделок
	-- общая сумма сделок
	comment text,
	foreign key (company_id) references companies (id)
);

