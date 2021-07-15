-- data quality in patient table of kis
drop view if exists kis.npat_dqa;

create or replace view kis.npat_dqa
as
  select 
    'einri' problem,
    'Wert: '||np.einri|| '- Ungültige Angabe' problem_beschreibung,
    np.*
  from kis.npat np
  left join kis.norg nor 
  on np.einri = nor.einri 
  where nor.einri isnull
    union 
  select 
    'patnr' ,
    'Wert: '||patnr|| ' - Ungültige Angabe' ,
    *
  from kis.npat np 
  where patnr !~'P(\-)*\d{10}'
    union 
  select 
    'gschl' problem,
    'Wert: '||np.gschl||' - Ungülige Angabe' ,
    np.*
  from kis.npat np 
  left join metadata_repository.gender g
  on np.gschl = g.sourceid 
  where g.sourceid isnull 
  and np.gschl not like '^\d'
    union 
  select 
    'gbdat',
    'Wert: '||gbdat||' - Ungültige Angabe',
    *
  from kis.npat np 
  where gbdat < 1900 and gbdat > date_part('year', now()) 
    union 
  select 
    'todkz',
    'Wert: '||todkz||' - Überprüfen Sie die Spalten toddt',
    *
  from kis.npat np 
  where toddt isnull and todkz 
    union 
  select 
    'toddt',
    'Überprüfen Sie zusätzlich die Spalten toddb und todkz',
    *
  from kis.npat np 
  where (toddt > toddb) or (toddt > now()::date)
    union 
  /*select 
    'todzt',
    'Überprüfen Sie zusätzlich die Spalte todkz',
    *
  from kis.npat np 
  where todkz and todzt isnull
    union*/ 
  select 
    'toddb',
    'Überprüfen Sie zusätzlich die Spalten toddt und todkz',
    *
  from kis.npat np 
  where (toddt > toddb) or (toddb > now()::date)
    union 
  select
    'todur',
    'Wert: '||todur||' - Ungültige Angabe',
    n.*
  from kis.npat n 
  left join metadata_repository.deathcause d 
    on d.sourceid = n.todur 
  where d.sourceid isnull and todur not like ''
    union 
  select
    'land',
    'Wert: '||land||' - Ungültige Angabe',
    n.*
  from kis.npat n
  left join metadata_repository.country c 
    on c.sourceid = n.land 
  where c.sourceid isnull and land notnull and land !~'\s+' and land not like ''
    union 
  select 
    'pstlz',
    'Wert: '||pstlz||' - Ungültige Angabe',
    *
  from kis.npat
  where pstlz !~'\d+' and pstlz not like ''
    union 
  select 
    'erdat',
    'Wert: '||erdat||' - Ungültige Angabe, Überprüfen Sie die Spalten toddt, gbdat oder das Datum von heute',
    *
  from kis.npat
  where erdat > now()::date or date_part('year', erdat) < gbdat or erdat > toddt
    union
  select 
    'updat',
    'Wert: '||updat||' - Ungültige Angabe, Überprüfen Sie die Spalte erdat',
    *
  from kis.npat
  where updat > now()::date or date_part('year', updat) < gbdat or updat < erdat
    union 
  select 
    'storn',
    'Wert:'||storn||' - Ungültige Angabe, Überprüfens Sie die Spalte stdat',
    *
  from kis.npat 
  where storn and stdat isnull
    union 
  select 
    'stdat',
    'Wert:'||stdat||' - Ungültige Angabe, Überprüfens Sie die Spalte storn',
    *
  from kis.npat 
  where stdat notnull and not storn;
 
 --select * from kis.npat_dqa; 
