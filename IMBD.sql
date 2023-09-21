create database imbd_movie;
use imbd_movie;

select count(*) from director_mapping;
select count(*) from genre;
select count(*) from movie;
select count(*) from names;
select count(*) from ratting;
select count(*) from role_mapping;


select * from director_mapping;
select * from genre;
select * from names;
select * from ratting;
select * from role_mapping;

set SQL_SAFE_UPDATES=0;

update movie set country =null where country ='';
update movie set worldwide_gross_income =null where worldwide_gross_income ='';
update movie set languages =null where languages ='';
update movie set production_company =null where production_company ='';

update names set height =null where height ='';
update names set date_of_birth =null where date_of_birth='';
update names set known_for_movies =null where known_for_movies ='';

alter table movie modify column worldwide_gross_income bigint;
alter table movie modify column duratuon int; 
show databases;
show session variables like 'lower_case_table_names'
