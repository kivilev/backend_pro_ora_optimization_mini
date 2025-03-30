/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Find entry/start point
  
  Description: find problem code
  
  views: user_xxx, all_xxx, dba_xxx
  
*/

select t.job_name, t.job_type, t.job_action, t.*
  from dba_scheduler_jobs t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
 order by t.job_name desc;

select *
  from dba_scheduler_job_log t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
 order by t.log_date desc;

select t.job_name
       ,t.log_date
       ,substr(t.session_id, 0, instr(t.session_id, ',')-1) sid
       ,substr(t.session_id, instr(t.session_id, ',')+1) serial
       ,t.run_duration
       ,t.cpu_used
       ,'----'
       ,t.*
  from dba_scheduler_job_run_details t
 where t.job_name = 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB'
   and t.status = 'SUCCEEDED'
 order by t.log_date desc;

