-- WITH Latest_partition AS (
--     SELECT MAX(Loaded_date) AS Max_date,
--     FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`fct_components`
--     WHERE Loaded_date IS NOT NULL

-- ),

-- Components_casted AS (
--     SELECT
--         CAST(Component_id AS STRING) AS Component_id,
--         CAST(Property_id AS STRING) AS Property_id,
--         CAST(Commencement_on AS DATETIME) AS Commencement_on,
--         CAST(Calculated_warranty_expires_on AS DATETIME) AS Calculated_warranty_expires_on,
--         CAST(Installed_on AS DATETIME) AS Installed_on,
--         CAST(Is_determined_multiples_allowed AS BOOLEAN) AS Is_determined_multiples_allowed,
--         CAST(Age AS INT64) AS Age,
--         CAST(Quantity AS INT64) AS Quantity,
--         CAST(Warranty_period AS INT64) AS Warranty_period,
--         CAST(Communal_or_domestic AS STRING) AS Communal_or_domestic,
--         CAST(Component_servicing_responsibility AS STRING) AS Component_servicing_responsibility,
--         CAST(Component_reference AS STRING) AS Component_reference,
--         CAST(Component_full_name AS STRING) AS Component_full_name,
--         CAST(Location_additional_information AS STRING) AS Location_additional_information,
--         CAST(Serial_number AS STRING) AS Serial_number,
--         CAST(Is_job_aggregated_by_asset AS BOOLEAN) AS Is_job_aggregated_by_asset,
--         CAST(Is_multiple_quantities_allowed AS BOOLEAN) AS Is_multiple_quantities_allowed,
--         CAST(Component_name AS STRING) AS Component_name,
--         CAST(Decent_homes_key_component AS STRING) AS Decent_homes_key_component,
--         CAST(Category_name AS STRING) AS Category_name,
--         CAST(Access_name AS STRING) AS Access_name,
--         CAST(Aspect_name AS STRING) AS Aspect_name,
--         CAST(Fuel_type_name AS STRING) AS Fuel_type_name,
--         CAST(Gas_related AS STRING) AS Gas_related,
--         CAST(Glazing_type_name AS STRING) AS Glazing_type_name,
--         CAST(Component_grade_name AS STRING) AS Component_grade_name,
--         CAST(Make_name AS STRING) AS Make_name,
--         CAST(Model_name AS STRING) AS Model_name,
--         CAST(Make_model_code AS INT64) AS Make_model_code,
--         CAST(Monitoring_type_name AS STRING) AS Monitoring_type_name,
--         CAST(Power_source_name AS STRING) AS Power_source_name,
--         CAST(Preservation_order_name AS STRING) AS Preservation_order_name,
--         CAST(Type_name AS STRING) AS Type_name,
--         CAST(Lifespan AS INT64) AS Lifespan,
--         CAST(Replacement_cost AS NUMERIC) AS Replacement_cost,
--         CAST(Loaded_date AS DATETIME) AS Loaded_date,
--     FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`fct_components`
--     WHERE Loaded_date = COALESCE(
        
--             (SELECT Latest_partition.Max_date, FROM Latest_partition)
        
--     )

-- )

-- SELECT *,
-- FROM Components_casted



  
--   WITH Source AS (
--     SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_raw`.`raw_dim_property`
-- ),
 
-- Components AS (
--     SELECT * FROM `gc-r-prj-originmig`.`Origin_Migration_omar_raw`.`raw_fct_components`
-- ),
 
-- HIU_components AS (
--     SELECT Property_id,
--            Component_servicing_responsibility
--     FROM Components
--     WHERE Component_name = "Heat Interface Unit (HIU)"
-- ),
 
-- Property_hierarchy AS (
--     SELECT * FROM `gc-r-prj-originmig`.`Origin_Migration_omar`.`property_hierarchy`
-- ),
 
-- HIU_Property_hierarchy AS (
--     SELECT *
--     FROM Property_hierarchy
-- )



-- SELECT
--   S.Orchard_property_reference AS Lpel_pro_propref,
--   'HIU_RESP'           AS Lpel_ety_code,
--   COALESCE(S.Acquired_date, CAST(CURRENT_TIMESTAMP() AS DATE))             AS Lpel_start,
--   CASE WHEN H.Component_servicing_responsibility = 'Customer' THEN 'CUSTOMER'
--               WHEN H.Component_servicing_responsibility = 'Origin' THEN 'PFP'
--               WHEN H.Component_servicing_responsibility = 'Third Party' THEN 'THIRDPRTY'
--               ELSE NULL END              AS Lpel_atty_code,
--   CAST(NULL AS STRING)         AS Lpel_date,
--   CAST(NULL AS INT64)             AS Lpel_value,
--   CAST(NULL AS STRING)                 AS Lpel_hrv_repcat,
--   CAST(NULL AS STRING)               AS Lpel_end,
--   CAST(NULL AS STRING)               AS Lpel_hrv_elo_code,
--   CAST(NULL AS STRING)               AS Lpel_fat_code,
--   CAST(NULL AS STRING)              AS Lpel_text,
--   CASE WHEN Ph.Property_hierarchy = 'AUN' THEN 'A' ELSE NULL END                AS Lpel_aun_ind,
--   CAST(NULL AS STRING)               AS Lpel_hrv_rco_code,
--   CAST(NULL AS STRING)          AS Lpel_quantity,
--   CAST(NULL AS STRING)        AS Lpel_text_value,
--   CAST(NULL AS STRING)    AS Lpel_remaining_life,
--   CAST(NULL AS DATE)      AS Lpel_install_date,
--   CAST(NULL AS STRING)       AS Lpel_repair_cost,
--   CAST(NULL AS STRING)       AS Lpel_repair_year,
--   CAST(NULL AS STRING)        AS Lpel_hrv_hqdc_code,
--   CAST(NULL AS STRING)     AS Lpel_deferral_year,
--   CAST(NULL AS STRING)     AS Lpel_override_cost,
--   'Compliance'           AS Element_type,
--   'HIU Responsibility'           AS Element_name,
--   S.Asset_status AS Asset_status,
--   S.Asset_subcategory AS Asset_subcategory
-- FROM Source AS S
--                INNER JOIN HIU_components H ON H.Property_id = S.Property_id
--                INNER JOIN HIU_Property_hierarchy Ph ON CAST(S.Orchard_property_reference AS STRING) = Ph.Orchard_property_reference 


  
--   limit 500





--   SELECT * FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_gas_responsibility_element`


--   SELECT * FROM gc-r-prj-originmig.Origin_Migration_omar_Source.fct_components
--   WHERE Lifespan_remaining is not null

-- SELECT count(*) , Lpel_atty_code  
-- FROM   gc-r-prj-originmig.Origin_Migration_omar_staging.stg_unvented_cylinder_present_element
-- GROUP BY Lpel_atty_code

-- SELECT count(*),  CASE WHEN p.Property_id is null THEN 1 ELSE 0 END
-- FROM gc-r-prj-originmig.Origin_Migration_omar_Source.fct_asbestos A
-- LEFT JOIN gc-r-prj-originmig.Origin_Migration_omar_Source.dim_property p
--      ON  P.Property_id = A.Property_id
-- GROUP BY   CASE WHEN p.Property_id is null THEN 1 ELSE 0 END

SELECT count(*) ,do_not_inspect_decision
FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_fct_asbestos A
GROUP BY do_not_inspect_decision 
;
-- SELECT count(*),  CASE WHEN p.Property_id is null THEN 1 ELSE 0 END
SELECT COUNT(DISTINCT P.Property_id)
FROM gc-r-prj-originmig.Origin_Migration_omar_Source.fct_asbestos A
INNER JOIN gc-r-prj-originmig.Origin_Migration_omar_Source.dim_property p
     ON  P.Property_id = A.Property_id
-- WHERE A.do_not_inspect_decision is null
-- GROUP BY do_not_inspect_decision 
-- GROUP BY   CASE WHEN p.Property_id is null THEN 1 ELSE 0 END

SELECT DISTINCT A.Property_id, P.*
FROM gc-r-prj-originmig.Origin_Migration_omar_Source.fct_asbestos A
INNER JOIN gc-r-prj-originmig.Origin_Migration_omar_Source.dim_property p
     ON  P.Property_id = A.Property_id
