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

-- select all the data quality tables and the columns starting with  Is*
-- SELECT column_name, table_name
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_public.INFORMATION_SCHEMA.COLUMNS`
-- WHERE table_name like 'dq%'
-- AND   column_name like 'Is%'
-- ORDER by table_name
-- SELECT t1.table_id, t1.row_count AS dim_count 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__ t1
-- WHERE t1.table_id like 'dim%'

SELECT t1.table_id, t1.row_count AS dim_count , t2.table_id, t2.row_count AS dq_count ,ROUND(COALESCE(SAFE_DIVIDE(t2.row_count , t1.row_count),1) * 100) as Percentage
FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__ t1
JOIN  gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__ t2
      ON t2.table_id = CONCAT('dq_',t1.table_id) 
WHERE t1.table_id like 'dim%'
ORDER BY percentage DESC



-- dq_dim_account_blances
SELECT count(*) ,Is_missing_Laba_pay_ref, Is_missing_Laba_balance, Is_missing_Laba_balance_date, Is_Laba_balance_date_future
 FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_account_balances`
 GROUP BY Is_missing_Laba_pay_ref, Is_missing_Laba_balance, Is_missing_Laba_balance_date, Is_Laba_balance_date_future

-- dq_dim_contact_details
SELECT count(*) , Is_missing_lcde_legacy_ref, Is_missing_lcde_contact_name, Is_missing_lcde_comments
 FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_contact_details`
GROUP BY Is_missing_lcde_legacy_ref, Is_missing_lcde_contact_name, Is_missing_lcde_comments

-- dq_dim_ofv_housing_group
SELECT COUNT(*) AS cnt, Is_missing_lpva_char_value
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_ofv_housing_group`
GROUP BY Is_missing_lpva_char_value	

-- dq_dim_people
SELECT COUNT(*) AS cnt,Is_missing_occupant_type_code,Is_missing_household_start_date	 
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_people`
GROUP BY Is_missing_occupant_type_code,Is_missing_household_start_date

-- dq_dim_physical_au_addresses
SELECT COUNT(*) AS cnt, Is_missing_postcode,Is_missing_area_or_town
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_physical_au_addresses`
GROUP BY  Is_missing_postcode,Is_missing_area_or_town

-- dq_dim_property
SELECT COUNT(*) AS cnt, Is_duplicate, Is_missing_property_status_start, Is_missing_property_debit_to_date, Is_missing_lpro_prop_status	 
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_property`
GROUP BY Is_duplicate, Is_missing_property_status_start, Is_missing_property_debit_to_date, Is_missing_lpro_prop_status	

-- dq_dim_property_addresses
SELECT COUNT(*) AS cnt, Is_missing_postcode, Is_missing_area_or_town
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_property_addresses`
GROUP BY Is_missing_postcode, Is_missing_area_or_town

-- dq_dim_revenue_accounts
SELECT COUNT(*) AS cnt,Is_missing_pay_ref, Is_missing_account_type_code
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_revenue_accounts`
GROUP BY Is_missing_pay_ref, Is_missing_account_type_code

-- dq_dim_tenancy
SELECT COUNT(*) AS cnt, Is_missing_tenancy_source_code, Is_missing_tenancy_termination_code, Is_missing_tenancy_type_code, Is_missing_tenure_type_code, Is_missing_tenant_name	
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_tenancy`
GROUP BY Is_missing_tenancy_source_code, Is_missing_tenancy_termination_code, Is_missing_tenancy_type_code, Is_missing_tenure_type_code, Is_missing_tenant_name	 

-- dq_fct_estates_property_elements
SELECT COUNT(*) AS cnt, Is_missing_lpel_ety_code, Is_missing_lpel_start, Is_missing_lpel_atty_code, Is_missing_lpel_aun_ind, Is_missing_lpel_fat_code, Is_missing_lpel_hrv_elo_code
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_fct_estates_property_elements`
GROUP BY  Is_missing_lpel_ety_code, Is_missing_lpel_start, Is_missing_lpel_atty_code, Is_missing_lpel_aun_ind, Is_missing_lpel_fat_code, Is_missing_lpel_hrv_elo_code
