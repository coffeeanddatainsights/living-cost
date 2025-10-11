-- =========================================
-- vw_valcar_transformed.sql
-- Transformed view from vw_valcar_cleaned
-- =========================================

CREATE OR REPLACE VIEW vw_valcar_transformed AS
SELECT
    v.CityName,
    v.Country,
    v.Category,
    v.MeanPrice,
    
    -- Normalized Price based on Category
    CASE 
        WHEN AVG(v.MeanPrice) OVER (PARTITION BY v.Category) > 0 
        THEN v.MeanPrice / AVG(v.MeanPrice) OVER (PARTITION BY v.Category)
        ELSE NULL
    END AS NormalizedPrice,
    
    -- Ranking of cities by category (cheaper = rank 1)
    RANK() OVER (PARTITION BY v.Category ORDER BY v.MeanPrice ASC) AS CategoryRank,
    
    -- WeightedPrice - based on weights of each category
    v.MeanPrice * w.weight AS WeightedPrice,
    
    -- CityCostIndex
    SUM(v.MeanPrice * w.weight) OVER (PARTITION BY v.CityName, v.Country) AS CityCostIndex
    
FROM vw_valcar_cleaned v
INNER JOIN regcat ON v.Category=regcat.descat
LEFT JOIN weicat AS w ON regcat.idncat = w.idncat;



--SELECT * FROM vw_valcar_transformed LIMIT 10;
-- +------------------+-------------+------------------------+-----------+-----------------+--------------+---------------+---------------+
-- | CityName         | Country     | Category               | MeanPrice | NormalizedPrice | CategoryRank | WeightedPrice | CityCostIndex |
-- +------------------+-------------+------------------------+-----------+-----------------+--------------+---------------+---------------+
-- | 's-hertogenbosch | Netherlands | Utilities              |     36.27 |        0.398634 |          564 |        9.0675 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Utilities              |    151.91 |        1.669603 |         1411 |       37.9775 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |     59.73 |        5.020788 |         5110 |        5.9730 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |     26.49 |        2.226698 |         4571 |        2.6490 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |      2.13 |        0.179044 |         2621 |        0.2130 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |      2.19 |        0.184087 |         2675 |        0.2190 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |      3.32 |        0.279073 |         3306 |        0.3320 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Transport              |      3.22 |        0.270667 |         3270 |        0.3220 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Leisure and Well-Being |     89.84 |        2.706561 |         9125 |        4.4920 |     5150.4880 |
-- | 's-hertogenbosch | Netherlands | Leisure and Well-Being |    107.32 |        3.233171 |         9580 |        5.3660 |     5150.4880 |
-- +------------------+-------------+------------------------+-----------+-----------------+--------------+---------------+---------------+
-- 10 rows in set (0.54 sec)
