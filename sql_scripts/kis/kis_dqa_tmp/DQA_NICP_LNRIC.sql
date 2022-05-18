-- DQA_NICP_LNRIC
CREATE OR REPLACE VIEW kis."DQA_NICP_LNRIC"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."LNRIC" ~ '\w' THEN n."LNRIC"
        ELSE NULL
    END AS "LNRIC",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."LNRIC" = m.sourceid
  GROUP BY n."LNRIC", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

