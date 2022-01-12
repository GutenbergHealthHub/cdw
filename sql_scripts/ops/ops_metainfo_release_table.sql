create table ops_metainfo.ops_release_info(
  ops_version varchar primary key,
  ops_release date not null unique check(date_part('year', ops_release) <= date_part('year', now()))
);

--select '    ('''||generate_series(2007, 2022)||''', '''||generate_series(2006, 2021)||'.10.25''),';


insert into ops_metainfo.ops_release_info
  values
    ('2007', '2006.10.25'),
    ('2008', '2007.11.16'),
    ('2009', '2008.10.20'),
    ('2010', '2009.10.26'),
    ('2011', '2010.10.21'),
    ('2012', '2011.10.14'),
    ('2013', '2012.10.12'),
    ('2014', '2013.11.04'),
    ('2015', '2014.10.17'),
    ('2016', '2015.10.16'),
    ('2017', '2016.10.19'),
    ('2018', '2017.10.18'),
    ('2019', '2018.10.19'),
    ('2020', '2019.10.18'),
    ('2021', '2020.10.16'),
    ('2022', '2021.10.22')
;

alter table ops_metainfo.kodes 
rename column fünfsteller to fuensteller;

alter table ops_metainfo.kodes 
add column ver varchar not null default '2021';

