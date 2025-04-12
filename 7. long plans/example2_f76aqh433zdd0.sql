SQL_ID  f76aqh433zdd0, child number 0
-------------------------------------
select /*+ NO_PARALLEL*/
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2023-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_SHIPPING_VAT + F_PURCHASE_MOTIVATION.SUM_RET_VAT
     end) as c1,
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2023-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_SHIPPING_INV_VAT + F_PURCHASE_MOTIVATION.SUM_RET_INV_VAT
     end) as c2,
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2023-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_EXPORT_VAT
     end) as c3,
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2024-12-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_SHIPPING_VAT + F_PURCHASE_MOTIVATION.SUM_RET_VAT
     end) as c4,
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2024-12-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_SHIPPING_INV_VAT + F_PURCHASE_MOTIVATION.SUM_RET_INV_VAT
     end) as c5,
 sum(case
       when not D_CALENDAR.REPORT_DATE <
             TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
            not TO_DATE('2024-12-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS') <
             D_CALENDAR.REPORT_DATE then
        F_PURCHASE_MOTIVATION.SUM_EXPORT_VAT
     end) as c6,
 D_COMPANY_HIERARCHY_UZ.LVL3_MANUAL as c7,
 D_PERSON.ASSIGNMENT_NUMBER as c8,
 D_PERSON.PERSON_NAME as c9,
 D_BRAND.BRAND_NAME as c10,
 case
   when D_BRAND.BRAND_GROUP in ('КПП', 'Не определено') then
    D_BRAND.BRAND_NAME
   else
    D_BRAND.BRAND_GROUP
 end as c11
  from DWH_TEST.D_COMPANY_HIERARCHY   D_COMPANY_HIERARCHY /* 01200_AD.0020_COMPANY_HIERARCHY */,
       DWH_TEST.D_COMPANY_HIERARCHY   D_COMPANY_HIERARCHY_UZ /* 01200_AD.0021_COMPANY_HIERARCHY_UZ */,
       DWH_TEST.D_PERSON              D_PERSON /* 01200_AD.0083_PERSON_MAN */,
       DWH_TEST.D_BRAND               D_BRAND /* 01200_AD.0780_BRAND */,
       DWH_TEST.D_CALENDAR            D_CALENDAR /* AD.0010_CALENDAR_DETAIL */,
       DWH_TEST.F_PURCHASE_MOTIVATION F_PURCHASE_MOTIVATION /* AF.01200_PURCHASE_MOTIVATION */
 where (F_PURCHASE_MOTIVATION.ID_PERSON_UZ = D_PERSON.ID_PERSON and
       F_PURCHASE_MOTIVATION.ID_ELEMENT_STRUCTURE_UZ = D_COMPANY_HIERARCHY_UZ.ID_ELEMENT_STRUCTURE and
       D_CALENDAR.ID_CALENDAR = F_PURCHASE_MOTIVATION.ID_CALENDAR and
       F_PURCHASE_MOTIVATION.ID_BRAND = D_BRAND.ID_BRAND and D_CALENDAR.DATE_LEVEL = 7 and
       F_PURCHASE_MOTIVATION.ID_ORGANIZATION = D_COMPANY_HIERARCHY.ID_ELEMENT_STRUCTURE and
       D_COMPANY_HIERARCHY_UZ.LEVEL2 = 'Коммерческая дирекция' and
       D_CALENDAR.ID_CALENDAR >= 720230101 and
       (D_CALENDAR.REPORT_DATE >=
       TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') or
       D_CALENDAR.REPORT_DATE >=
       TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) and
       (D_COMPANY_HIERARCHY_UZ.LVL3_MANUAL in ('ОКСБСО',
                                 'ОПЭ',
                                 'ОСВТ',
                                 'ОСПК',
                                 'ОУЭ',
                                 'Прочее')) and
       (D_CALENDAR.REPORT_DATE <=
       TO_DATE('2023-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS') or
       D_CALENDAR.REPORT_DATE <=
       TO_DATE('2024-12-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) and
       (D_CALENDAR.REPORT_DATE >=
       TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') or
       D_CALENDAR.REPORT_DATE <=
       TO_DATE('2024-12-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) and
       (D_COMPANY_HIERARCHY.LEVEL2 in
       ('Дирекция по продажам',
          'Управление сервисами продаж')) and
       (D_CALENDAR.REPORT_DATE >=
       TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') or
       D_CALENDAR.REPORT_DATE <=
       TO_DATE('2023-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) and
       F_PURCHASE_MOTIVATION.ID_CALENDAR >= 720230101)
 group by D_PERSON.PERSON_NAME,
          D_PERSON.ASSIGNMENT_NUMBER,
          D_COMPANY_HIERARCHY_UZ.LVL3_MANUAL,
          D_BRAND.BRAND_NAME,
          case
            when D_BRAND.BRAND_GROUP in
                 ('КПП', 'Не определено') then
             D_BRAND.BRAND_NAME
            else
             D_BRAND.BRAND_GROUP
          end
 order by c7, c8, c9, c10, c11
 
Plan hash value: 3838198506
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                     | Starts | E-Rows |E-Bytes|E-Temp | Cost (%CPU)| E-Time   | Pstart| Pstop | A-Rows |   A-Time   | Buffers | Reads  |  OMem |  1Mem | Used-Mem |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                          |      1 |        |       |       |  6816 (100)|          |       |       |   1453 |00:00:47.27 |     110K|    110K|       |       |          |
|   1 |  SORT GROUP BY                      |                          |      1 |    351K|    74M|    79M|  6816  (10)| 00:00:02 |       |       |   1453 |00:00:47.27 |     110K|    110K|   478K|   478K|  424K (0)|
|*  2 |   HASH JOIN                         |                          |      1 |    351K|    74M|       |  2638  (23)| 00:00:01 |       |       |     32M|00:00:14.89 |     110K|    110K|  4004K|  2563K| 5652K (0)|
|   3 |    INDEX STORAGE FAST FULL SCAN     | D_PERSON_IDX2            |      1 |  29150 |  1167K|       |     2   (0)| 00:00:01 |       |       |  29150 |00:00:00.01 |      54 |     51 |  1028K|  1028K| 2064K (0)|
|*  4 |    HASH JOIN                        |                          |      1 |    351K|    60M|       |  2636  (23)| 00:00:01 |       |       |     32M|00:00:12.09 |     110K|    110K|  2140K|  2140K| 5174K (0)|
|   5 |     INDEX STORAGE FAST FULL SCAN    | D_BRAND_IDX2             |      1 |   1777 | 51533 |       |     2   (0)| 00:00:01 |       |       |   1777 |00:00:00.01 |       7 |      5 |  1028K|  1028K| 1032K (0)|
|*  6 |     HASH JOIN                       |                          |      1 |    351K|    51M|       |  2633  (23)| 00:00:01 |       |       |     32M|00:00:09.32 |     110K|    110K|  3899K|  3899K| 5138K (0)|
|*  7 |      INDEX STORAGE FAST FULL SCAN   | D_COMPANY_HIERARCHY_IDX1 |      1 |   1169 | 32732 |       |     2   (0)| 00:00:01 |       |       |   1169 |00:00:00.01 |       7 |      5 |  1028K|  1028K| 1032K (0)|
|*  8 |      HASH JOIN                      |                          |      1 |    351K|    41M|       |  2630  (23)| 00:00:01 |       |       |     32M|00:00:07.77 |     110K|    110K|  2632K|  2632K| 5110K (0)|
|*  9 |       INDEX STORAGE FAST FULL SCAN  | D_CALENDAR_IDX1          |      1 |    166 |  3154 |       |     2   (0)| 00:00:01 |       |       |    681 |00:00:00.01 |      29 |     26 |  1028K|  1028K| 1032K (0)|
|* 10 |       HASH JOIN                     |                          |      1 |   1711K|   173M|       |  2625  (23)| 00:00:01 |       |       |     33M|00:00:06.37 |     110K|    110K|  2984K|  2984K| 4038K (0)|
|  11 |        JOIN FILTER CREATE           | :BF0000                  |      1 |      1 |    58 |       |     2   (0)| 00:00:01 |       |       |     19 |00:00:00.01 |       8 |      6 |       |       |          |
|* 12 |         INDEX STORAGE FAST FULL SCAN| D_COMPANY_HIERARCHY_IDX2 |      1 |      1 |    58 |       |     2   (0)| 00:00:01 |       |       |     19 |00:00:00.01 |       8 |      6 |  1028K|  1028K| 1032K (0)|
|  13 |        JOIN FILTER USE              | :BF0000                  |      1 |     24M|  1109M|       |  2574  (22)| 00:00:01 |       |       |     33M|00:00:03.76 |     110K|    110K|       |       |          |
|  14 |         PARTITION RANGE SINGLE      |                          |      1 |     24M|  1109M|       |  2574  (22)| 00:00:01 |     1 |     1 |     33M|00:00:03.72 |     110K|    110K|       |       |          |
|* 15 |          TABLE ACCESS STORAGE FULL  | F_PURCHASE_MOTIVATION    |      1 |     24M|  1109M|       |  2574  (22)| 00:00:01 |     1 |     1 |     33M|00:00:03.70 |     110K|    110K|  1028K|  1028K| 3096K (0)|
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1
   3 - SEL$1 / D_PERSON@SEL$1
   5 - SEL$1 / D_BRAND@SEL$1
   7 - SEL$1 / D_COMPANY_HIERARCHY@SEL$1
   9 - SEL$1 / D_CALENDAR@SEL$1
  12 - SEL$1 / D_COMPANY_HIERARCHY_UZ@SEL$1
  15 - SEL$1 / F_PURCHASE_MOTIVATION@SEL$1
 
Outline Data
-------------
 
  /*+
      BEGIN_OUTLINE_DATA
      IGNORE_OPTIM_EMBEDDED_HINTS
      OPTIMIZER_FEATURES_ENABLE('19.1.0')
      DB_VERSION('19.1.0')
      OPT_PARAM('_optimizer_undo_cost_change' '12.1.0.2')
      OPT_PARAM('_optimizer_unnest_corr_set_subq' 'false')
      OPT_PARAM('_optimizer_ansi_rearchitecture' 'false')
      OPT_PARAM('_fix_control' '8528517:0 13836796:0 16053273:0')
      ALL_ROWS
      OUTLINE_LEAF(@"SEL$1")
      INDEX_FFS(@"SEL$1" "D_COMPANY_HIERARCHY_UZ"@"SEL$1" ("D_COMPANY_HIERARCHY"."ID_ELEMENT_STRUCTURE" "D_COMPANY_HIERARCHY"."LEVEL2" "D_COMPANY_HIERARCHY"."LVL3_MANUAL"))
      FULL(@"SEL$1" "F_PURCHASE_MOTIVATION"@"SEL$1")
      INDEX_FFS(@"SEL$1" "D_CALENDAR"@"SEL$1" ("D_CALENDAR"."DATE_LEVEL" "D_CALENDAR"."ID_CALENDAR" "D_CALENDAR"."REPORT_DATE"))
      INDEX_FFS(@"SEL$1" "D_COMPANY_HIERARCHY"@"SEL$1" ("D_COMPANY_HIERARCHY"."ID_ELEMENT_STRUCTURE" "D_COMPANY_HIERARCHY"."LEVEL2"))
      INDEX_FFS(@"SEL$1" "D_BRAND"@"SEL$1" ("D_BRAND"."ID_BRAND" "D_BRAND"."BRAND_NAME" "D_BRAND"."BRAND_GROUP"))
      INDEX_FFS(@"SEL$1" "D_PERSON"@"SEL$1" ("D_PERSON"."ID_PERSON" "D_PERSON"."PERSON_NAME" "D_PERSON"."ASSIGNMENT_NUMBER"))
      LEADING(@"SEL$1" "D_COMPANY_HIERARCHY_UZ"@"SEL$1" "F_PURCHASE_MOTIVATION"@"SEL$1" "D_CALENDAR"@"SEL$1" "D_COMPANY_HIERARCHY"@"SEL$1" "D_BRAND"@"SEL$1" "D_PERSON"@"SEL$1")
      USE_HASH(@"SEL$1" "F_PURCHASE_MOTIVATION"@"SEL$1")
      USE_HASH(@"SEL$1" "D_CALENDAR"@"SEL$1")
      USE_HASH(@"SEL$1" "D_COMPANY_HIERARCHY"@"SEL$1")
      USE_HASH(@"SEL$1" "D_BRAND"@"SEL$1")
      USE_HASH(@"SEL$1" "D_PERSON"@"SEL$1")
      PX_JOIN_FILTER(@"SEL$1" "F_PURCHASE_MOTIVATION"@"SEL$1")
      SWAP_JOIN_INPUTS(@"SEL$1" "D_CALENDAR"@"SEL$1")
      SWAP_JOIN_INPUTS(@"SEL$1" "D_COMPANY_HIERARCHY"@"SEL$1")
      SWAP_JOIN_INPUTS(@"SEL$1" "D_BRAND"@"SEL$1")
      SWAP_JOIN_INPUTS(@"SEL$1" "D_PERSON"@"SEL$1")
      END_OUTLINE_DATA
  */
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"="D_PERSON"."ID_PERSON")
   4 - access("F_PURCHASE_MOTIVATION"."ID_BRAND"="D_BRAND"."ID_BRAND")
   6 - access("F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"="D_COMPANY_HIERARCHY"."ID_ELEMENT_STRUCTURE")
   7 - storage(("D_COMPANY_HIERARCHY"."LEVEL2"='Дирекция по продажам' OR "D_COMPANY_HIERARCHY"."LEVEL2"='Управление сервисами продаж'))
       filter(("D_COMPANY_HIERARCHY"."LEVEL2"='Дирекция по продажам' OR "D_COMPANY_HIERARCHY"."LEVEL2"='Управление сервисами продаж'))
   8 - access("D_CALENDAR"."ID_CALENDAR"="F_PURCHASE_MOTIVATION"."ID_CALENDAR")
   9 - storage(("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."ID_CALENDAR">=720230101 AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2024-12-05 
              00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."DATE_LEVEL"=7 AND ("D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2023-12-07 00:00:00', 'syyyy-mm-dd hh24:mi:ss') OR "D_CALENDAR"."REPORT_DATE">=TO_DATE(' 
              2024-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))))
       filter(("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."ID_CALENDAR">=720230101 AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2024-12-05 
              00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."DATE_LEVEL"=7 AND ("D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2023-12-07 00:00:00', 'syyyy-mm-dd hh24:mi:ss') OR "D_CALENDAR"."REPORT_DATE">=TO_DATE(' 
              2024-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))))
  10 - access("F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ"="D_COMPANY_HIERARCHY_UZ"."ID_ELEMENT_STRUCTURE")
  12 - storage(("D_COMPANY_HIERARCHY_UZ"."LEVEL2"='Коммерческая дирекция' AND INTERNAL_FUNCTION("D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL")))
       filter(("D_COMPANY_HIERARCHY_UZ"."LEVEL2"='Коммерческая дирекция' AND INTERNAL_FUNCTION("D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL")))
  15 - storage(("F_PURCHASE_MOTIVATION"."ID_CALENDAR">=720230101 AND SYS_OP_BLOOM_FILTER(:BF0000,"F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ")))
       filter(("F_PURCHASE_MOTIVATION"."ID_CALENDAR">=720230101 AND SYS_OP_BLOOM_FILTER(:BF0000,"F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ")))
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=5; rowset=256) "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], "D_PERSON"."ASSIGNMENT_NUMBER"[VARCHAR2,30], "D_PERSON"."PERSON_NAME"[VARCHAR2,120], "D_BRAND"."BRAND_NAME"[VARCHAR2,50], 
       CASE "D_BRAND"."BRAND_GROUP" WHEN 'КПП' THEN "D_BRAND"."BRAND_NAME" WHEN 'Не определено' THEN "D_BRAND"."BRAND_NAME" ELSE "D_BRAND"."BRAND_GROUP" END [120], SUM(CASE  WHEN 
       ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2024-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2024-12-05 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN 
       "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT" END )[22], SUM(CASE  WHEN ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2024-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 
       2024-12-05 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"+"F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT" END )[22], SUM(CASE  WHEN 
       ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2024-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2024-12-05 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"+"F_PURCHASE_MOTIVATION"."SUM_RET_VAT" END )[22], SUM(CASE  WHEN ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND 
       "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2023-12-07 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT" END )[22], SUM(CASE  WHEN ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 
       2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2023-12-07 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"+"F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT" END )[22], SUM(CASE  WHEN ("D_CALENDAR"."REPORT_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND 
       "D_CALENDAR"."REPORT_DATE"<=TO_DATE(' 2023-12-07 00:00:00', 'syyyy-mm-dd hh24:mi:ss')) THEN "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"+"F_PURCHASE_MOTIVATION"."SUM_RET_VAT" END )[22]
   2 - (#keys=1; rowset=256) "D_PERSON"."ASSIGNMENT_NUMBER"[VARCHAR2,30], "D_PERSON"."PERSON_NAME"[VARCHAR2,120], "D_BRAND"."BRAND_GROUP"[VARCHAR2,120], "D_BRAND"."BRAND_NAME"[VARCHAR2,50], 
       "D_CALENDAR"."REPORT_DATE"[DATE,7], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22]
   3 - "D_PERSON"."ID_PERSON"[NUMBER,22], "D_PERSON"."PERSON_NAME"[VARCHAR2,120], "D_PERSON"."ASSIGNMENT_NUMBER"[VARCHAR2,30]
   4 - (#keys=1; rowset=256) "D_BRAND"."BRAND_GROUP"[VARCHAR2,120], "D_BRAND"."BRAND_NAME"[VARCHAR2,50], "D_CALENDAR"."REPORT_DATE"[DATE,7], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], 
       "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22]
   5 - "D_BRAND"."ID_BRAND"[NUMBER,22], "D_BRAND"."BRAND_NAME"[VARCHAR2,50], "D_BRAND"."BRAND_GROUP"[VARCHAR2,120]
   6 - (#keys=1; rowset=256) "D_CALENDAR"."REPORT_DATE"[DATE,7], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22]
   7 - "D_COMPANY_HIERARCHY"."ID_ELEMENT_STRUCTURE"[NUMBER,22]
   8 - (#keys=1; rowset=256) "D_CALENDAR"."REPORT_DATE"[DATE,7], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22]
   9 - "D_CALENDAR"."ID_CALENDAR"[NUMBER,22], "D_CALENDAR"."REPORT_DATE"[DATE,7]
  10 - (#keys=1; rowset=256) "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120], "F_PURCHASE_MOTIVATION"."ID_CALENDAR"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], 
       "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22]
  11 - "D_COMPANY_HIERARCHY_UZ"."ID_ELEMENT_STRUCTURE"[NUMBER,22], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120]
  12 - "D_COMPANY_HIERARCHY_UZ"."ID_ELEMENT_STRUCTURE"[NUMBER,22], "D_COMPANY_HIERARCHY_UZ"."LVL3_MANUAL"[VARCHAR2,120]
  13 - (rowset=256) "F_PURCHASE_MOTIVATION"."ID_CALENDAR"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"[NUMBER,22]
  14 - (rowset=256) "F_PURCHASE_MOTIVATION"."ID_CALENDAR"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"[NUMBER,22]
  15 - (rowset=256) "F_PURCHASE_MOTIVATION"."ID_CALENDAR"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_PERSON_UZ"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ELEMENT_STRUCTURE_UZ"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_SHIPPING_INV_VAT"[FLOAT,22], "F_PURCHASE_MOTIVATION"."SUM_RET_VAT"[NUMBER,22], 
       "F_PURCHASE_MOTIVATION"."SUM_RET_INV_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."SUM_EXPORT_VAT"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_BRAND"[NUMBER,22], "F_PURCHASE_MOTIVATION"."ID_ORGANIZATION"[NUMBER,22]
 
Hint Report (identified by operation id / Query Block Name / Object Alias):
Total hints for statement: 1 (U - Unused (1))
---------------------------------------------------------------------------
 
   0 -  STATEMENT
         U -  NO_PARALLEL
 
Note
-----
   - Degree of Parallelism is 1 because of hint
 
Query Block Registry:
---------------------
 
  <q o="2" f="y"><n><![CDATA[SEL$1]]></n><f><h><t><![CDATA[D_BRAND]]></t><s><![CDATA[SEL$1]]></s></h><h><t><![CDATA[D_CALENDAR]]></t><s><![CDATA[SEL$1]]></s></h><h><t><![CDATA[D_COMPANY_HIERARCHY]]></t><s><![
        CDATA[SEL$1]]></s></h><h><t><![CDATA[D_COMPANY_HIERARCHY_UZ]]></t><s><![CDATA[SEL$1]]></s></h><h><t><![CDATA[D_PERSON]]></t><s><![CDATA[SEL$1]]></s></h><h><t><![CDATA[F_PURCHASE_MOTIVATION]]></t><s><![CDATA
        [SEL$1]]></s></h></f></q>
 
 
