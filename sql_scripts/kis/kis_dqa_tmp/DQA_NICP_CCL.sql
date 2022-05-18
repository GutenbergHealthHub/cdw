-- DQA_NICP_CCL
CREATE OR REPLACE VIEW kis."DQA_NICP_CCL"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."CCL" ~ '\w' THEN n."CCL"
        ELSE NULL
    END AS "CCL",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."CCL" = m.sourceid
  GROUP BY n."CCL", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

