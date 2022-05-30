-- DQA_/HSROM/SCREENCOV_EINRI
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_EINRI"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."EINRI" ~ '\w' THEN n."EINRI"
        ELSE NULL
    END AS "EINRI"/*,
    m.long_name*/
  FROM kis."/HSROM/SCREENCOV" n
  --LEFT JOIN metadata_repository.TABLE m ON n."EINRI" = m.sourceid
  GROUP BY n."EINRI"--, m.long_name
  ORDER BY "QUANTITY" DESC;

