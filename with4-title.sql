-- WITH stg_dim_people AS (
--     SELECT *
--     FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.stg_dim_people`
-- ),

-- int_dim_people AS (
--     SELECT * 
--     FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
-- )

-- SELECT * 
-- FROM stg_dim_people P
-- WHERE LENGTH(P.Lpar_per_title) > 8

-- SELECT 	Lpar_hop_hpsr_code, Lpar_per_title, *
-- FROM int_dim_people P
-- WHERE LENGTH(P.Lpar_per_title) > 8

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
    WHERE LENGTH(Title) > 2