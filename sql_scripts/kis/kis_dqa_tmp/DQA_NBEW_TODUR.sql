-- DQA_NBEW_TODUR
CREATE OR REPLACE VIEW kis."DQA_NBEW_TODUR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."TODUR" ~ '\w' THEN n."TODUR"
        ELSE NULL
    END AS "TODUR",
    m.todesursache
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.todesursache m ON n."TODUR" = m.sourceid
  GROUP BY n."TODUR", m.todesursache
  ORDER BY "QUANTITY" DESC;

