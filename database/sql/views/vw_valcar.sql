-- 1. Raw view of valcar. RAW DATA
CREATE OR REPLACE VIEW vw_valcar AS 
SELECT regcit.namecit,
regcit.country,
regcar.descar,
regcat.descat,
valcar.cvalue
FROM valcar
INNER JOIN regcit ON valcar.idncity=regcit.idncity
INNER JOIN regcar ON valcar.idcara=regcar.idcara
INNER JOIN regcat ON regcar.idncat=regcat.idncat


-- ==========================================
--  SELECT COUNT(*) FROM vw_valcar;
--          +----------+
--          | COUNT(*) |
--          +----------+
--          |    39916 |
--          +----------+
--      1 row in set (0.03 sec)
-- ==========================================