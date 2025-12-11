WITH public_people AS (
    SELECT *
    FROM  `gc-r-prj-originmig.Origin_Migration_omar_public.dim_people`
),

int_dim_people AS (
    SELECT *
    FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
)

-- SELECT count(*) cnt, P.Lpar_hop_end_date,P.Lpar_hop_hrv_rel_code, P.LPAR_TIN_HRV_TIR_CODE
-- FROM public_people P
-- WHERE P.Lpar_hop_end_date is NULL
-- GROUP BY P.Lpar_hop_end_date,P.Lpar_hop_hrv_rel_code, P.LPAR_TIN_HRV_TIR_CODE
-- ORDER BY  cnt DESC
SELECT count(*) cnt
,P.LPAR_HOP_HPER_CODE 
,p.Lpar_hop_end_date 
-- ,P.LPAR_TIN_HRV_TIR_CODE
FROM public_people P
WHERE p.Lpar_hop_end_date is null
AND   p.Lpar_hop_hper_code is not null
GROUP BY
P.LPAR_HOP_HPER_CODE 
,p.Lpar_hop_end_date 
-- ,P.LPAR_TIN_HRV_TIR_CODE



-- 38756 Records failed with HDL93 - Person End Reason/End Date 
--     - One cannot be supplied without the other 
--     - Mapping logic recently amended 
--         to join using contact id to dim_tenancy and use termination_reason, 
--     not all fields correctly populated on sheet, I have corrected this
SELECT count(*) , Lpar_per_title
FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
GROUP BY Lpar_per_title
ORDER BY 1

-- returns 47 rows with DOB 
SELECT Lpar_per_title, REGEXP_EXTRACT(Lpar_per_title, r'^\d+') , *
FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
WHERE REGEXP_EXTRACT(Lpar_per_title, r'^\d+') IS NOT NULL

-- returns 47 rows with DOB
SELECT Lpar_per_title, REGEXP_EXTRACT(Lpar_per_title, r'^\d+') , *
FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people
WHERE REGEXP_EXTRACT(Lpar_per_title, r'^\d+') IS NOT NULL

-- all tiles or null
SELECT count(*) ,Lpar_per_title
FROM gc-r-prj-originmig.Origin_Migration_omar_staging.stg_dim_people
GROUP BY Lpar_per_title
ORDER BY 1

-- return no Titles with numbers
WITH Contact_history AS(
    SELECT
        Primary_account_tenancy_id,
        Contact_id,
        Title,
        First_name,
        Last_name,
        Date_of_birth,
        Full_name,
        ROW_NUMBER()
            OVER (PARTITION BY Contact_id ORDER BY Modified_on DESC)
            AS Rn,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`dim_contact_history`
)

-- SELECT REGEXP_EXTRACT(Title , r'^\d+') 
-- FROM Contact_history 
-- WHERE rn =1
-- AND  REGEXP_EXTRACT(Title , r'^\d+') IS NOT NULL


SELECT count(*), REGEXP_EXTRACT(Title , r'^\d+') 
FROM Contact_history 
WHERE rn =1
GROUP BY   REGEXP_EXTRACT(Title , r'^\d+')
ORDER BY 1



SELECT * 