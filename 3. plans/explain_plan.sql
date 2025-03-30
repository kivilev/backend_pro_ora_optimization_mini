/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru)

  Lesson: 3. plans
  
  Description: Script to explore SQL execution plans

*/

select * from v$sqlarea t;

select * from v$sqlarea t where lower(t.sql_text) like '%count(c.client_id)%';

select * from v$sqlarea t where t.sql_id = '3fjmu9yzjv9vr';


-- getting explain plan
explain plan for
select count(c.client_id)
          from client c
              ,table(t_numbers(:b1)) t
         where c.is_active = 1;
 
select * from dbms_xplan.display(format => 'ALL'); 

