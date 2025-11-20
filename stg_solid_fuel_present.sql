
  
  WITH Source AS (
    SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_raw`.`raw_dim_property`
),

Property_hierarchy AS (
    SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar`.`property_hierarchy`
),

Components AS (
    SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_raw`.`raw_fct_components`
),

Solid_fuel_components AS (
    SELECT DISTINCT Property_id,
    FROM Components
    WHERE
        Component_name = "Solid Fuel Boiler Present"
), 

temp_final AS(


SELECT
  S.Orchard_property_reference AS Lpel_pro_propref,
  'SFUEL_PRE'           AS Lpel_ety_code,
  COALESCE(S.Handover_date,CAST(CURRENT_TIMESTAMP() AS DATE))             AS Lpel_start,
  CASE WHEN C.Property_id IS NOT NULL THEN 'PRESENT'
              ELSE 'NOTPRESENT' END              AS Lpel_atty_code,
  CAST(NULL AS STRING)         AS Lpel_date,
  CAST(NULL AS INT64)             AS Lpel_value,
  CAST(NULL AS STRING)                 AS Lpel_hrv_repcat,
  CAST(NULL AS STRING)               AS Lpel_end,
  Ph.Property_hierarchy               AS Lpel_hrv_elo_code,
  CAST(NULL AS STRING)               AS Lpel_fat_code,
  CAST(NULL AS STRING)              AS Lpel_text,
  CASE WHEN Ph.Property_hierarchy = 'AUN' THEN 'A' ELSE NULL END                AS Lpel_aun_ind,
  CAST(NULL AS STRING)               AS Lpel_hrv_rco_code,
  CAST(NULL AS STRING)          AS Lpel_quantity,
  CAST(NULL AS STRING)        AS Lpel_text_value,
  CAST(NULL AS STRING)    AS Lpel_remaining_life,
  CAST(NULL AS DATE)      AS Lpel_install_date,
  CAST(NULL AS STRING)       AS Lpel_repair_cost,
  CAST(NULL AS STRING)       AS Lpel_repair_year,
  CAST(NULL AS STRING)        AS Lpel_hrv_hqdc_code,
  CAST(NULL AS STRING)     AS Lpel_deferral_year,
  CAST(NULL AS STRING)     AS Lpel_override_cost,
  'Compliance'           AS Element_type,
  'Solid Fuel Boiler Present'           AS Element_name,
  S.Asset_status AS Asset_status,
  S.Asset_subcategory AS Asset_subcategory
FROM Source AS S
              INNER JOIN Property_hierarchy Ph ON Ph.Orchard_property_reference = CAST(S.Orchard_property_reference as STRING)
              LEFT JOIN Solid_fuel_components C ON C.Property_id = S.Property_id
)

SELECT count(*), Lpel_atty_code 
FROM temp_final
GROUP BY Lpel_atty_code;


WITH 

Components AS (
    SELECT *, FROM `gc-r-prj-originmig`.`Origin_Migration_omar_raw`.`raw_fct_components`
),

Solid_fuel_components AS (
    SELECT DISTINCT Property_id,
    FROM Components
    -- WHERE Component_name like "%olid%"
    WHERE Component_name ="Solid Fuel Bolier Responsibility" --"Solid Fuel Boiler Present"
)

    SELECT * FROM Solid_fuel_components;
    -- SELECT DISTINCT Component_name, Property_id ,Components, *
    -- WHERE Component_name like "%olid%"
    -- FROM Solid_fuel_components