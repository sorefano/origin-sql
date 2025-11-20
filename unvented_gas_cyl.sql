    SELECT
    count(*) ,Type_name ,Component_name
    FROM `gc-r-prj-originmig.Origin_Migration_omar_raw.raw_fct_components`
    RRR AND Type_name LIKE "Air Source"
    -- WHERE Component_name = "Hot Water Cylinder"
    -- AND   Type_name like '%Unvented%'
    GROUP BY Type_name,Component_name