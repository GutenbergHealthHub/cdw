-- DQA_NPAT_SEX_SPECIAL
CREATE OR REPLACE VIEW kis."DQA_NPAT_SEX_SPECIAL"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."SEX_SPECIAL" ~ '\w' THEN n."SEX_SPECIAL"
        ELSE NULL
    END AS "SEX_SPECIAL",
    m.long_name
  FROM kis."NPAT" n
  LEFT JOIN metadata_repository.TABLE m ON n."SEX_SPECIAL" = m.sourceid
  GROUP BY n."SEX_SPECIAL", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

