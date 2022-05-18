-- DQA_NBEW_EINRI
CREATE OR REPLACE VIEW kis."DQA_NBEW_EINRI"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."EINRI" ~ '\w' THEN n."EINRI"
        ELSE NULL
    END AS "EINRI",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."EINRI" = m.sourceid
  GROUP BY n."EINRI", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

