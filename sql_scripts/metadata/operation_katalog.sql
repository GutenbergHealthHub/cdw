-- Operation Kataloge

create table metadata_repository.operation_katalog(
  id serial primary key,
  sourceid varchar not null,
  operation_katalog varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, operation_katalog)
);

insert into metadata_repository.operation_katalog (sourceid, operation_katalog)
  values
      ('1', 'G.tarif'),
    ('20', 'GOÄ/DKGNT'),
    ('30', 'EBM'),
    ('31', 'EBM 1.4.05'),
    ('40', 'BG'),
    ('50', '§ 302'),
    ('60', 'BG 1.5.01'),
    ('D0', 'DRG_2010'),
    ('D4', 'DRG-Katal.'),
    ('D5', 'DRG-Katal.'),
    ('D6', 'DRG_2006'),
    ('D7', 'DRG_2007'),
    ('D8', 'DRG_2008'),
    ('D9', 'DRG_2009'),
    ('DA', 'DRG_2011'),
    ('DB', 'DRG_2012'),
    ('DC', 'DRG_2013'),
    ('DE', 'DRG_2014'),
    ('DF', 'DRG_2015'),
    ('DG', 'DRG_2016'),
    ('DH', 'DRG_2017'),
    ('DI', 'DRG_2018'),
    ('DJ', 'DRG_2019'),
    ('DK', 'DRG_2020'),
    ('DL', 'DRG_2021'),
    ('DM', 'DRG_2022'),
    ('DR', 'DRG-Katal.'),
    ('I0', 'OPS_2010'),
    ('I1', 'ICPM_2.0'),
    ('I2', 'ICPM_2.1'),
    ('I3', 'OPS_2004'),
    ('I5', 'OPS_2005'),
    ('I6', 'OPS_2006'),
    ('I7', 'OPS_2007'),
    ('I8', 'OPS_2008'),
    ('I9', 'OPS_2009'),
    ('IC', 'ICPM'),
    ('L1', 'Labor-KT'),
    ('LA', 'Labor'),
    ('O1', 'OPS_2011'),
    ('O2', 'OPS_2012'),
    ('O3', 'OPS_2013'),
    ('O4', 'OPS_2014'),
    ('O5', 'OPS_2015'),
    ('O6', 'OPS_2016'),
    ('O7', 'OPS_2017'),
    ('O8', 'OPS_2018'),
    ('O9', 'OPS_2019'),
    ('OA', 'OPS_2020'),
    ('OB', 'OPS_2021'),
    ('OC', 'OPS_2022'),
    ('PC', 'PEPP_2013'),
    ('PG', 'PEPP_2016'),
    ('PH', 'PEPP_2017'),
    ('PI', 'PEPP_2018'),
    ('PJ', 'PEPP_2019'),
    ('PK', 'PEPP_2020'),
    ('PL', 'PEPP_2021'),
    ('PM', 'PEPP_2022'),
    ('V1', 'IV-TK M1a1'),
    ('V2', 'IV-TK M1b2')
;