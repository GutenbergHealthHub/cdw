-- DQA_/HSROM/SCREENCOV_SCREENOPTION
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENOPTION"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENOPTION" ~ '\w' THEN n."SCREENOPTION"
        ELSE NULL
    END AS "SCREENOPTION",
    m.hsrom_screenoption
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screenoption m ON n."SCREENOPTION" = m.sourceid
  GROUP BY n."SCREENOPTION", m.hsrom_screenoption
  ORDER BY "QUANTITY" DESC;

