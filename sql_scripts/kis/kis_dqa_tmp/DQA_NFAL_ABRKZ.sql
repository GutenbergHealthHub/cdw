-- DQA_NFAL_ABRKZ
CREATE OR REPLACE VIEW kis."DQA_NFAL_ABRKZ"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ABRKZ" ~ '\w' THEN n."ABRKZ"
        ELSE NULL
    END AS "ABRKZ",
    m.long_name
  FROM kis."NFAL" n
  LEFT JOIN metadata_repository.TABLE m ON n."ABRKZ" = m.sourceid
  GROUP BY n."ABRKZ", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

