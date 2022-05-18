-- DQA_NBEW_DSPTY
CREATE OR REPLACE VIEW kis."DQA_NBEW_DSPTY"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DSPTY" ~ '\w' THEN n."DSPTY"
        ELSE NULL
    END AS "DSPTY",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."DSPTY" = m.sourceid
  GROUP BY n."DSPTY", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

