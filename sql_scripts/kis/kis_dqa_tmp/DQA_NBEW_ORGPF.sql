-- DQA_NBEW_ORGPF
CREATE OR REPLACE VIEW kis."DQA_NBEW_ORGPF"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGPF" ~ '\w' THEN n."ORGPF"
        ELSE NULL
    END AS "ORGPF",
    m.orgna "ORGNA"
  FROM kis."NBEW" n
  LEFT join norg m ON n."ORGFA" = m.orgid
  GROUP BY n."ORGPF", "ORGNA"
  ORDER BY "QUANTITY" DESC;

