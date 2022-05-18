-- DQA_NORG_SLLGO
CREATE OR REPLACE VIEW kis."DQA_NORG_SLLGO"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."SLLGO" ~ '\w' THEN n."SLLGO"
        ELSE NULL
    END AS "SLLGO",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."SLLGO" = m.sourceid
  GROUP BY n."SLLGO", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

