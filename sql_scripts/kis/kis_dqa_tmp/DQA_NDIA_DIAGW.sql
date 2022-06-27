-- DQA_NDIA_DIAGW
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAGW"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIAGW" ~ '\w' THEN n."DIAGW"
        ELSE NULL
    END AS "DIAGW",
    m.diag_gewissheit
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.diag_gewissheit m ON n."DIAGW" = m.sourceid
  GROUP BY n."DIAGW", m.diag_gewissheit
  ORDER BY "QUANTITY" DESC;

