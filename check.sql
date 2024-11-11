use role ACCOUNTADMIN;

-- you should see all tutorial warehouses
show warehouses like 'tutorial%';

-- you should see TUTORIAL_DEMO_DB and TODO_APP
select database_name, created::date as ctd from snowflake.account_usage.databases where ctd >dateadd(day,-1,current_date());

-- should display tutorial_admin, tutorial_developer and tutorial_analyst
select name, created_on::date as ctd from snowflake.account_usage.roles where ctd >dateadd(day,-1,current_date());

-- Should thrown an error before user_grants
-- this will work only after user is granted the role `tutorial_admin`

USE ROLE tutorial_admin;
use database tutorial_demo_db;
use schema data;
select * from customers;
