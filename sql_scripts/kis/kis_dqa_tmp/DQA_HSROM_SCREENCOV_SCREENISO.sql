-- DQA_/HSROM/SCREENCOV_SCREENISO
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENISO"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENISO" ~ '\w' THEN n."SCREENISO"
        ELSE NULL
    END AS "SCREENISO"/*,
    m.long_name*/
  FROM kis."/HSROM/SCREENCOV" n
  --LEFT JOIN metadata_repository.TABLE m ON n."SCREENISO" = m.sourceid
  GROUP BY n."SCREENISO"--, m.long_name
  ORDER BY "QUANTITY" DESC;

