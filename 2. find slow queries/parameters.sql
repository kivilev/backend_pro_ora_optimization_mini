/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Get slow queries
  
  Description: guarantee time preserve sql plan
  
*/

-- sys
alter system set "_sqlmon_recycle_time" = 300 scope = both; -- 5 minutes
alter system set "_sqlmon_max_plan" = 40 scope = both; -- 20*CPU


-- SHOW PARAMETER _sqlmon;

-- sys
select ksppinm, ksppstvl, ksppdesc
  from sys.x$ksppi a, sys.x$ksppsv b
 where a.indx=b.indx
  and lower(ksppinm) like lower('%_sqlmon%')
order by ksppinm;


-- parameters for data retention in AWR
select * from dba_hist_wr_control;
