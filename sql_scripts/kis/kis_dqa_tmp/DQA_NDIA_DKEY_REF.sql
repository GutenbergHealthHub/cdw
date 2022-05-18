-- DQA_NDIA_DKEY_REF
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY_REF"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DKEY_REF" ~ '\w' THEN n."DKEY_REF"
        ELSE NULL
    END AS "DKEY_REF",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DKEY_REF" = m.sourceid
  GROUP BY n."DKEY_REF", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

