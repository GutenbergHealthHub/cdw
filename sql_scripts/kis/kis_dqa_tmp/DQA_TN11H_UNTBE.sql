-- DQA_TN11H_UNTBE
CREATE OR REPLACE VIEW kis."DQA_TN11H_UNTBE"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."UNTBE" ~ '\w' THEN n."UNTBE"
        ELSE NULL
    END AS "UNTBE",
    m.long_name
  FROM kis."TN11H" n
  LEFT JOIN metadata_repository.TABLE m ON n."UNTBE" = m.sourceid
  GROUP BY n."UNTBE", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

