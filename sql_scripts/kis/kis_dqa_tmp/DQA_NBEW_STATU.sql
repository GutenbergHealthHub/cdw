-- DQA_NBEW_STATU
CREATE OR REPLACE VIEW kis."DQA_NBEW_STATU"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."STATU" ~ '\w' THEN n."STATU"
        ELSE NULL
    END AS "STATU",
    m.intern_status_amb_besuch
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.intern_status_amb_besuch m ON n."STATU" = m.sourceid
  GROUP BY n."STATU", m.intern_status_amb_besuch
  ORDER BY "QUANTITY" DESC;

