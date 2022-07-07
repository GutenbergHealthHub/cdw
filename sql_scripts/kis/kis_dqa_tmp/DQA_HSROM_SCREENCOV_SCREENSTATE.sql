-- DQA_/HSROM/SCREENCOV_SCREENSTATE
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENSTATE"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENSTATE" ~ '\w' THEN n."SCREENSTATE"
        ELSE NULL
    END AS "SCREENSTATE",
    m.hsrom_screenstate
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screenstate m ON n."SCREENSTATE" = m.sourceid
  GROUP BY n."SCREENSTATE", m.hsrom_screenstate
  ORDER BY "QUANTITY" DESC;

