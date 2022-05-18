-- DQA_NICP_ICPMK
CREATE OR REPLACE VIEW kis."DQA_NICP_ICPMK"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ICPMK" ~ '\w' THEN n."ICPMK"
        ELSE NULL
    END AS "ICPMK",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."ICPMK" = m.sourceid
  GROUP BY n."ICPMK", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

