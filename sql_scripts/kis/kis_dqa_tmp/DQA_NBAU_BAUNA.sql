-- DQA_NBAU_BAUNA
CREATE OR REPLACE VIEW kis."DQA_NBAU_BAUNA"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."BAUNA" ~ '\w' THEN n."BAUNA"
        ELSE NULL
    END AS "BAUNA",
    m.long_name
  FROM kis."NBAU" n
  LEFT JOIN metadata_repository.TABLE m ON n."BAUNA" = m.sourceid
  GROUP BY n."BAUNA", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

