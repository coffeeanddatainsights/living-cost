-- 1. Cleaned view containing cleaned data of vw_valcar(valcar). CLEANED DATA
-- Remove duplicates
-- Remove white spaces and right format of varchar fields
-- Remove NULL or NEGATIVE cvalue
-- descar : replaced '_' with ' ' and removed '(usd)'
CREATE OR REPLACE VIEW vw_valcar_cleaned AS 
SELECT 
    DISTINCT
        CONCAT(UPPER(LEFT(namecit, 1)), LOWER(SUBSTRING(namecit, 2))) AS CityName,
        CONCAT(UPPER(LEFT(country, 1)), LOWER(SUBSTRING(country, 2))) AS Country,
        REPLACE (
            REPLACE(LOWER(descar), '_', ' '),
            '(usd)', ''
        ) AS Paramethers,
        descat AS Category,
        cvalue AS MeanPrice
FROM vw_valcar
WHERE 1=1 
AND cvalue IS NOT NULL
AND cvalue > 0
AND TRIM(namecit) <> ''
AND TRIM(country) <> ''
AND TRIM(descar) <> ''
AND TRIM(descat) <> ''

-- ==========================================
--  SELECT COUNT(*) FROM vw_valcar_cleaned;
--          +----------+
--          | COUNT(*) |
--          +----------+
--          |    39893 |
--          +----------+
--      1 row in set (0.03 sec)
-- ==========================================