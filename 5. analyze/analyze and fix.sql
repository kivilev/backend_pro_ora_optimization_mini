/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Query plan
  
  Description: analaze plan, find bottlenecks, fix
  
*/

---- source query
select count(c.client_id)
  from kivi.client c
      ,table(kivi.t_numbers(:b1)) t
 where c.is_active = 1;


---- get rid of merje join cartesian
select count(c.client_id)
  from kivi.client c
      ,table(kivi.t_numbers(:b1)) t
 where c.is_active = 1
   and c.client_id = value(t);


---- define size of collection
select /*+ cardinality (t 500) */
       count(c.client_id)
  from kivi.client c
      ,table(kivi.t_numbers(:b1)) t
 where c.is_active = 1
   and c.client_id = value(t);


---- final version
select /*+ cardinality (t 500) use_nl(t c) leading(t c)*/
       count(c.client_id)
  from table(kivi.t_numbers(:b1)) t
  join kivi.client c on c.client_id = value(t) and c.is_active = 1;


