-- WITH List_dq_tables AS
-- (
-- SELECT table_name
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_public.INFORMATION_SCHEMA.TABLES`
-- WHERE table_name like 'dq%'
-- ),

-- List_dq_Columns AS
-- (
-- SELECT * 
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_public.INFORMATION_SCHEMA.COLUMNS`
-- )


-- SELECT C.*
-- FROM List_dq_Columns C
-- JOIN List_dq_tables T ON C.table_name = T.table_name

SELECT column_name, table_name
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name like 'dq%'
AND   column_name like 'Is%'
ORDER by table_name


-- column_name	table_name
-- 1	Is_missing_Laba_pay_ref	dq_dim_account_balances
-- 2	Is_missing_Laba_balance	dq_dim_account_balances
-- 3	Is_missing_Laba_balance_date	dq_dim_account_balances
-- 4	Is_Laba_balance_date_future	dq_dim_account_balances
-- 5	Is_missing_lcde_legacy_ref	dq_dim_contact_details
-- 6	Is_missing_lcde_contact_name	dq_dim_contact_details
-- 7	Is_missing_lcde_comments	dq_dim_contact_details
-- 8	Is_missing_lpva_char_value	dq_dim_ofv_housing_group
-- 9	Is_missing_occupant_type_code	dq_dim_people
-- 10	Is_missing_household_start_date	dq_dim_people
-- 11	Is_missing_postcode	dq_dim_physical_au_addresses
-- 12	Is_missing_area_or_town	dq_dim_physical_au_addresses
-- 13	Is_duplicate	dq_dim_property
-- 14	Is_missing_property_status_start	dq_dim_property
-- 15	Is_missing_property_debit_to_date	dq_dim_property
-- 16	Is_missing_lpro_prop_status	dq_dim_property
-- 17	Is_missing_postcode	dq_dim_property_addresses
-- 18	Is_missing_area_or_town	dq_dim_property_addresses
-- 19	Is_missing_pay_ref	dq_dim_revenue_accounts
-- 20	Is_missing_account_type_code	dq_dim_revenue_accounts
-- 21	Is_missing_class_code	dq_dim_revenue_accounts
-- 22	Is_missing_start_date	dq_dim_revenue_accounts
-- 23	Is_bad_tcy_alt_ref	dq_dim_revenue_accounts
-- 24	Is_void_tenancy	dq_dim_tenancy
-- 25	Is_missing_tenancy_source_code	dq_dim_tenancy
-- 26	Is_missing_tenancy_termination_code	dq_dim_tenancy
-- 27	Is_missing_tenancy_type_code	dq_dim_tenancy
-- 28	Is_missing_tenure_type_code	dq_dim_tenancy
-- 29	Is_missing_tenant_name	dq_dim_tenancy
-- 30	Is_missing_lpel_ety_code	dq_fct_estates_property_elements
-- 31	Is_missing_lpel_start	dq_fct_estates_property_elements
-- 32	Is_missing_lpel_atty_code	dq_fct_estates_property_elements
-- 33	Is_missing_lpel_aun_ind	dq_fct_estates_property_elements
-- 34	Is_missing_lpel_fat_code	dq_fct_estates_property_elements
-- 35	Is_missing_lpel_hrv_elo_code	dq_fct_estates_property_elements
-- 36	Is_missing_lpel_value	dq_fct_estates_property_elements

SELECT t1.table_id, t1.row_count AS dim_count , t2.table_id, t2.row_count AS dq_count ,ROUND(SAFE_DIVIDE(t2.row_count , t1.row_count)) * 100 
FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__ t1
JOIN  gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__ t2
      ON t2.table_id = CONCAT('dq_',t1.table_id) 
WHERE t1.table_id like 'dim%'
ORDER BY t1.table_id 

SELECT 346609/54805156 *100

	table_id	dim_count	table_id_1	dq_count
1	dim_account_arrears_actions	54805156	dq_dim_account_arrears_actions	346609
2	dim_account_balances	11817694	dq_dim_account_balances	469866
3	dim_contact_details	0	dq_dim_contact_details	298494
4	dim_debit_breakdowns	4183710563	dq_dim_debit_breakdowns	21874399
5	dim_ofv_housing_group	10441	dq_dim_ofv_housing_group	2171
6	dim_ofv_reason_not_required	95036	dq_dim_ofv_reason_not_required	0
7	dim_people	47985	dq_dim_people	0
8	dim_people_addresses	34460	dq_dim_people_addresses	18899
9	dim_physical_au_addresses	12614	dq_dim_physical_au_addresses	1
10	dim_property	11288	dq_dim_property	0
11	dim_property_addresses	12614	dq_dim_property_addresses	1
12	dim_revenue_accounts	30811	dq_dim_revenue_accounts	1
13	dim_tenancy	31934	dq_dim_tenancy	82
14	dim_transactions	754146	dq_dim_transactions	46931393