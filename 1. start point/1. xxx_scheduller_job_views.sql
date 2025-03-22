/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Find entry/start point
  
  Description: find problem code
  
  views: user_xxx, all_xxx, dba_xxx
  
*/

select *
  from dba_scheduler_jobs t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
 order by t.job_name desc;

select *
  from dba_scheduler_job_log t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
 order by t.log_date desc;

select *
  from dba_scheduler_job_run_details t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
 order by t.log_date desc;

