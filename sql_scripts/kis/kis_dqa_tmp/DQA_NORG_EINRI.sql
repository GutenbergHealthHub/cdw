-- DQA_NORG_EINRI
CREATE OR REPLACE VIEW kis."DQA_NORG_EINRI"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."EINRI" ~ '\w' THEN n."EINRI"
        ELSE NULL
    END AS "EINRI"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."EINRI" = m.sourceid
  GROUP BY n."EINRI"--, m.long_name
  ORDER BY "QUANTITY" DESC;

