  WITH Contact_hist_raw AS (
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
),

Contact_hist AS (
    SELECT DISTINCT *,
    FROM Contact_hist_raw
    WHERE Rn = 1
),

-- WITH 
Property AS (
    SELECT *
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_dim_property`
),

-- Tenancy AS (
--     SELECT *,
--     FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`int_dim_tenancy`
-- ),

-- Contact AS (
--     SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_dim_people`
-- ),

-- SELECT M.Ltcy_alt_ref, M.Ltcy_tho_propref1, M.Lpar_per_alt_ref, 
-- FROM Missing_tenancy M
-- WHERE M.Ltcy_alt_ref like "%48765"

Contact AS (
    SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_dim_people`
    UNION ALL
    SELECT
        Ch.Contact_id,
        CAST(NULL AS STRING) AS Primary_account_tenancy_id,
        Ch.Last_name AS Lpar_per_surname,
        Ch.First_name AS Lpar_per_forename,
        Ch.Full_name,
        Ch.Title AS Lpar_per_title,
        Ch.Date_of_birth AS Lpar_per_date_of_birth,
        CAST(NULL AS STRING) AS Lpar_per_alt_ref,
        CAST(NULL AS DATE) AS Loaded_date,
        CAST(NULL AS STRING) AS Lpar_hop_hpsr_code,
        CAST(NULL AS STRING) AS Lpar_per_initials,
        CAST(NULL AS STRING) AS Lpar_per_hou_disabled_ind,
        CAST(NULL AS STRING) AS Lpar_per_hou_oap_ind,
        CAST(NULL AS STRING) AS Lpar_per_frv_fge_code,
        CAST(NULL AS STRING) AS Lpar_hop_hrv_rel_code,
        CAST(NULL AS STRING) AS Lpar_per_hou_employer,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_hms_code,
        CAST(NULL AS STRING) AS Lpar_phone,
        CAST(NULL AS STRING) AS Lpar_hop_hper_code,
        CAST(NULL AS STRING) AS Lpar_tcy_ind,
        CAST(NULL AS INT64) AS Lpar_tin_main_tenant_ind,
        CAST(NULL AS STRING) AS Lpar_tin_stat_successor_ind,
        CAST(NULL AS STRING) AS Lpar_per_frv_feo_code,
        CAST(NULL AS STRING) AS Lpar_per_ni_no,
        CAST(NULL AS STRING) AS Lpar_per_frv_hgo_code,
        CAST(NULL AS STRING) AS Lpar_per_frv_fnl_code,
        CAST(NULL AS STRING) AS Lpar_per_other_name,
        CAST(NULL AS STRING) AS Lpar_per_hou_surname_prefix,
        CAST(NULL AS STRING) AS Lpar_hou_legacy_ref,
        CAST(NULL AS STRING) AS Lpar_ipp_shortname,
        CAST(NULL AS STRING) AS Lpar_ipp_placement_ind,
        CAST(NULL AS STRING) AS Lpar_ipp_current_ind,
        CAST(NULL AS STRING) AS Lpar_ipp_ipt_code,
        CAST(NULL AS STRING) AS Lpar_ipp_usr_username,
        CAST(NULL AS STRING) AS Lpar_ipp_spr_printer_name,
        CAST(NULL AS STRING) AS Lpar_ipp_comments,
        CAST(NULL AS STRING) AS Lpar_ipp_vca_code,
        CAST(NULL AS STRING) AS Lpar_ipu_aun_code,
        CAST(NULL AS STRING) AS Lpar_ipp_staff_id,
        CAST(NULL AS STRING) AS Lpar_ipp_cos_code,
        CAST(NULL AS STRING) AS Lpar_ipp_hrv_fit_code,
        CAST(NULL AS STRING) AS Lpar_type,
        CAST(NULL AS STRING) AS Lpar_org_sort_code,
        CAST(NULL AS STRING) AS Lpar_org_name,
        CAST(NULL AS STRING) AS Lpar_org_short_name,
        CAST(NULL AS STRING) AS Lpar_org_frv_oty_code,
        CAST(NULL AS STRING) AS Lpar_per_hou_at_risk_ind,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_ntly_code,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_sexo_code,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_rlgn_code,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_ecst_code,
        CAST(NULL AS STRING) AS Lpar_org_current_ind,
        CAST(NULL AS STRING) AS Lpar_hop_head_hhold_ind,
        CAST(NULL AS STRING) AS Lpar_hhold_group_no,
        CAST(NULL AS STRING) AS Lpar_created_date,
        CAST(NULL AS STRING) AS Lpar_created_by,
        CAST(NULL AS STRING) AS Lpar_modified_date,
        CAST(NULL AS STRING) AS Lpar_modified_by,
        CAST(NULL AS STRING) AS Lpar_per_hou_end_date,
        CAST(NULL AS STRING) AS Lpar_per_hou_hrv_hpe_code,
        CAST(NULL AS STRING) AS Lpar_org_dup,
        CAST(NULL AS STRING) AS Lpar_cos_code,
        CAST(NULL AS DATE) AS Lpar_cos_code_update,
    FROM Contact_hist AS Ch
    WHERE Ch.Contact_id NOT IN (SELECT S.Contact_id, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_dim_people` AS S)
),

Tenancy AS (
    SELECT *,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`int_dim_tenancy`
),

Occupancy_raw AS (
    SELECT
        Contact_id,
        Tenancy_id,
        Occupancy_start_date,
        Occupancy_end_date,
        ROW_NUMBER()
            OVER (PARTITION BY Contact_id ORDER BY Occupancy_start_date DESC)
            AS Rn,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`fct_occupancy`
),

Occupancy AS (
    SELECT *,
    FROM Occupancy_raw
    WHERE Rn = 1
),

Former_tenancy_raw AS (
    SELECT
        Leadtenant,
        CAST(Tenancynumber AS INTEGER) AS Tenancy_number,
        ROW_NUMBER()
            OVER (PARTITION BY CAST(Tenancynumber AS INTEGER) ORDER BY Loaded_date DESC)
            AS Rn,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`former_tenancy`
    WHERE Loaded_date >= "2025-09-25"
),

Former_tenancy AS (
    SELECT DISTINCT
        Leadtenant,
        Tenancy_number,
    FROM Former_tenancy_raw
    WHERE Rn = 1
),

Missing_household_start_date AS (
    SELECT Contact_id,
    FROM Occupancy
    WHERE
        Occupancy_start_date IS NULL
),

Missing_occupant_type_code AS (
    SELECT Lpar_per_alt_ref,
    FROM Contact
    WHERE
        Lpar_hop_hrv_rel_code IS NULL
        OR Lpar_hop_hrv_rel_code = "UNMAPPED"
),

Missing_tenancy AS (
    SELECT  C.contact_id, T.Ltcy_alt_ref, c.Primary_account_tenancy_id 
    -- FROM Property P
    FROM Tenancy T 
    JOIN Contact C ON C.Primary_account_tenancy_id = T.Tenancy_id
),
--
-- Missing_ethnicity_code AS (
--     SELECT Lpar_per_alt_ref,
--     FROM Contact
--     WHERE
--         Lpar_per_frv_feo_code IS NULL
--         OR Lpar_per_frv_feo_code = "UNMAPPED"
-- ),
--
-- Missing_language_code AS (
--     SELECT Lpar_per_alt_ref,
--     FROM Contact
--     WHERE
--         Lpar_per_frv_fnl_code IS NULL
--         OR Lpar_per_frv_fnl_code = "UNMAPPED"
-- ),
Data_quality_flag AS (
    SELECT DISTINCT
        C.* EXCEPT (Lpar_per_title, Lpar_per_surname, Lpar_per_forename, Lpar_per_date_of_birth),
        COALESCE(
            T_occupancy.Ltcy_alt_ref,
            T_primary.Ltcy_alt_ref,
            T_secondary.Ltcy_alt_ref,
            T_link.Ltcy_alt_ref,
            T_history.Ltcy_alt_ref,
            T_former.Ltcy_alt_ref,
            T_name.Ltcy_alt_ref
        ) AS Lpar_tcy_alt_ref,
        COALESCE(
            T_occupancy.Ltcy_act_start_date_adjusted,
            T_primary.Ltcy_act_start_date_adjusted,
            T_secondary.Ltcy_act_start_date_adjusted,
            T_link.Ltcy_act_start_date_adjusted,
            T_history.Ltcy_act_start_date_adjusted,
            T_former.Ltcy_act_start_date_adjusted,
            T_name.Ltcy_act_start_date_adjusted
        ) AS Lpar_tin_start_date,
        COALESCE(
            T_occupancy.Ltcy_act_end_date_adjusted,
            T_primary.Ltcy_act_end_date_adjusted,
            T_secondary.Ltcy_act_end_date_adjusted,
            T_link.Ltcy_act_end_date_adjusted,
            T_history.Ltcy_act_end_date_adjusted,
            T_former.Ltcy_act_end_date_adjusted,
            T_name.Ltcy_act_end_date_adjusted
        ) AS Lpar_tin_end_date,
        COALESCE(
            T_occupancy.Ltcy_hrv_ttr_code,
            T_primary.Ltcy_hrv_ttr_code,
            T_secondary.Ltcy_hrv_ttr_code,
            T_link.Ltcy_hrv_ttr_code,
            T_history.Ltcy_hrv_ttr_code,
            T_former.Ltcy_hrv_ttr_code,
            T_name.Ltcy_hrv_ttr_code
        ) AS Lpar_tin_hrv_tir_code,
        CAST(O.Occupancy_start_date AS DATETIME) AS Lpar_hop_start_date,
        CAST(O.Occupancy_end_date AS DATETIME) AS Lpar_hop_end_date,
        -- COALESCE(C.Organisation, Ch.organisation) AS organisation,
        COALESCE(UPPER(C.Lpar_per_title), UPPER(Ch.Title)) AS Lpar_per_title,
        COALESCE(C.Lpar_per_surname, Ch.Last_name) AS Lpar_per_surname,
        COALESCE(C.Lpar_per_forename, Ch.First_name) AS Lpar_per_forename,
        COALESCE(C.Lpar_per_date_of_birth, CAST(Ch.Date_of_birth AS DATE))
            AS Lpar_per_date_of_birth,
        NOT COALESCE(Mhd.Contact_id IS NULL, FALSE) AS Is_missing_household_start_date,
        NOT COALESCE(Otc.Lpar_per_alt_ref IS NULL, FALSE) AS Is_missing_occupant_type_code,
        -- NOT COALESCE(Lc.Lpar_per_alt_ref IS NULL, FALSE) AS Is_missing_language_code,
    FROM Contact AS C
    LEFT OUTER JOIN Contact_hist AS Ch ON C.Contact_id = Ch.Contact_id
    LEFT OUTER JOIN Occupancy AS O ON C.Contact_id = O.Contact_id
    LEFT OUTER JOIN Tenancy AS T_occupancy ON O.Tenancy_id = T_occupancy.Tenancy_id
    LEFT OUTER JOIN Tenancy AS T_primary ON C.Contact_id = T_primary.Primary_contact_id
    LEFT OUTER JOIN Tenancy AS T_secondary ON C.Contact_id = T_secondary.Secondary_contact_id
    LEFT OUTER JOIN Tenancy AS T_link ON C.Primary_account_tenancy_id = T_link.Tenancy_id
    LEFT OUTER JOIN Tenancy AS T_history ON Ch.Primary_account_tenancy_id = T_history.Tenancy_id
    LEFT OUTER JOIN Former_tenancy AS Ft ON LOWER(TRIM(C.Full_name)) = LOWER(TRIM(Ft.Leadtenant))
    LEFT OUTER JOIN Missing_tenancy AS Mt ON c.Primary_account_tenancy_id = Mt.Primary_account_tenancy_id
    LEFT OUTER JOIN
        Tenancy AS T_former
        ON CAST(SUBSTR(T_former.Ltcy_alt_ref, 5) AS INT64) = Ft.Tenancy_number
    LEFT OUTER JOIN
        Tenancy AS T_name
        ON LOWER(TRIM(C.Full_name)) = LOWER(TRIM(T_name.Ltcy_correspond_name))
    LEFT OUTER JOIN Missing_household_start_date AS Mhd ON C.Contact_id = Mhd.Contact_id
    LEFT OUTER JOIN Missing_occupant_type_code AS Otc ON C.Lpar_per_alt_ref = Otc.Lpar_per_alt_ref
    WHERE T_Primary.Ltcy_alt_ref like "%48765" 
),

Final AS (
    SELECT
        Data_quality_flag.*,
        (
            Is_missing_occupant_type_code
            OR Is_missing_household_start_date
        )
            AS Has_data_quality_issues,
    FROM Data_quality_flag
)

SELECT Lpar_tcy_alt_ref,Lpar_tin_start_date,Lpar_tin_end_date, Lpar_tin_hrv_tir_code,*,
FROM Final

  
  limit 500