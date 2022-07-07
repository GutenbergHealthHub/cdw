-- DQA_/HSROM/SCREENCOV_SCREENISO
drop view kis."DQA_/HSROM/SCREENCOV_SCREENISO";

CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENISO"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENISO" ~ '\w' THEN n."SCREENISO"
        ELSE NULL
    END AS "SCREENISO",
    m.hsrom_screeniso
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screeniso m ON n."SCREENISO" = m.sourceid
  GROUP BY n."SCREENISO", m.hsrom_screeniso
  ORDER BY "QUANTITY" DESC;

