-- DQA_NBEW_ORGFA
CREATE OR REPLACE VIEW kis."DQA_NBEW_ORGFA"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGFA" ~ '\w' THEN n."ORGFA"
        ELSE NULL
    END AS "ORGFA",
    m.orgna "ORGNA"
  FROM kis."NBEW" n
  LEFT join norg m ON n."ORGFA" = m.orgid
  GROUP BY n."ORGFA", "ORGNA"
  ORDER BY "QUANTITY" DESC;

