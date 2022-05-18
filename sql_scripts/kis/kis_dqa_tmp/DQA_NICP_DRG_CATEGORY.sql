-- DQA_NICP_DRG_CATEGORY
CREATE OR REPLACE VIEW kis."DQA_NICP_DRG_CATEGORY"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DRG_CATEGORY" ~ '\w' THEN n."DRG_CATEGORY"
        ELSE NULL
    END AS "DRG_CATEGORY",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."DRG_CATEGORY" = m.sourceid
  GROUP BY n."DRG_CATEGORY", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

