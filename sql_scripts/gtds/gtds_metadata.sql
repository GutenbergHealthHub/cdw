
  -- sterbedatum_exakt
  drop table if exists metadata_repository.sterbedatum_exakt;
  create table metadata_repository.sterbedatum_exakt(
    id serial primary key,
    sourceid varchar not null,
    sterbedatum_exakt varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, sterbedatum_exakt)
);

  -- tumortod
  drop table if exists metadata_repository.tumortod;
  create table metadata_repository.tumortod(
    id serial primary key,
    sourceid varchar not null,
    tumortod varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, tumortod)
);

  -- autopsie
  drop table if exists metadata_repository.autopsie;
  create table metadata_repository.autopsie(
    id serial primary key,
    sourceid varchar not null,
    autopsie varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, autopsie)
);

  -- lokalisation
  drop table if exists metadata_repository.lokalisation;
  create table metadata_repository.lokalisation(
    id serial primary key,
    sourceid varchar not null,
    lokalisation varchar,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, lokalisation)
);


  -- lok_seite
  drop table if exists metadata_repository.lok_seite;
  create table metadata_repository.lok_seite(
    id serial primary key,
    sourceid varchar not null,
    lok_seite varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, lok_seite)
);

  -- lok_haupt_neben
  drop table if exists metadata_repository.lok_haupt_neben;
  create table metadata_repository.lok_haupt_neben(
    id serial primary key,
    sourceid varchar not null,
    lok_haupt_neben varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, lok_haupt_neben)
);


  -- histo_haupt_neben
  drop table if exists metadata_repository.histo_haupt_neben;
  create table metadata_repository.histo_haupt_neben(
    id serial primary key,
    sourceid varchar not null,
    histo_haupt_neben varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, histo_haupt_neben)
);

  -- histo_diagnose
  drop table if exists metadata_repository.histo_diagnose;
  create table metadata_repository.histo_diagnose(
    id serial primary key,
    sourceid varchar not null,
    histo_diagnose varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, histo_diagnose)
);

  -- histo_herkunft
  drop table if exists metadata_repository.histo_herkunft;
  create table metadata_repository.histo_herkunft(
    id serial primary key,
    sourceid varchar not null,
    histo_herkunft varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, histo_herkunft)
);

  -- histo_grading
  drop table if exists metadata_repository.histo_grading;
  create table metadata_repository.histo_grading(
    id serial primary key,
    sourceid varchar not null,
    histo_grading varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, histo_grading)
);

 
  -- klin_tnm_herkunft
  drop table if exists metadata_repository.klin_tnm_herkunft;
  create table metadata_repository.klin_tnm_herkunft(
    id serial primary key,
    sourceid varchar not null,
    klin_tnm_herkunft varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, klin_tnm_herkunft)
);


  -- ann_arbor_herkunft
  drop table if exists metadata_repository.ann_arbor_herkunft;
  create table metadata_repository.ann_arbor_herkunft(
    id serial primary key,
    sourceid varchar not null,
    ann_arbor_herkunft varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, ann_arbor_herkunft)
);

  -- ann_arbor_stadium
  drop table if exists metadata_repository.ann_arbor_stadium;
  create table metadata_repository.ann_arbor_stadium(
    id serial primary key,
    sourceid varchar not null,
    ann_arbor_stadium varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, ann_arbor_stadium)
);

  -- ann_arbor_allgemein
  drop table if exists metadata_repository.ann_arbor_allgemein;
  create table metadata_repository.ann_arbor_allgemein(
    id serial primary key,
    sourceid varchar not null,
    ann_arbor_allgemein varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, ann_arbor_allgemein)
);


  -- sonstige_herkunft
  drop table if exists metadata_repository.sonstige_herkunft;
  create table metadata_repository.sonstige_herkunft(
    id serial primary key,
    sourceid varchar not null,
    sonstige_herkunft varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, sonstige_herkunft)
);

   -- applikationsart
  drop table if exists metadata_repository.applikationsart;
  create table metadata_repository.applikationsart(
    id serial primary key,
    sourceid varchar not null,
    applikationsart varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, applikationsart)
);

  -- applikationstechnik
  drop table if exists metadata_repository.applikationstechnik;
  create table metadata_repository.applikationstechnik(
    id serial primary key,
    sourceid varchar not null,
    applikationstechnik varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, applikationstechnik)
);

    -- strahlenart
  drop table if exists metadata_repository.strahlenart;
  create table metadata_repository.strahlenart(
    id serial primary key,
    sourceid varchar not null,
    strahlenart varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, strahlenart)
);

  
  -- r_klassifikation
  drop table if exists metadata_repository.r_klassifikation;
  create table metadata_repository.r_klassifikation(
    id serial primary key,
    sourceid varchar not null,
    r_klassifikation varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, r_klassifikation)
);

  
  -- op_intention
  drop table if exists metadata_repository.op_intention;
  create table metadata_repository.op_intention(
    id serial primary key,
    sourceid varchar not null,
    op_intention varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, op_intention)
);
  -- innere_protokoll_typ
  drop table if exists metadata_repository.protokoll_typ;
  create table metadata_repository.protokoll_typ(
    id serial primary key,
    sourceid varchar not null,
    protokoll_typ varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, protokoll_typ)
);

  -- ann_arbor_extra
  drop table if exists metadata_repository.ann_arbor_extra;
  create table metadata_repository.ann_arbor_extra(
    id serial primary key,
    sourceid varchar not null,
    ann_arbor_extra varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, ann_arbor_extra)
);

  
  -- lok_rezidivart
  drop table if exists metadata_repository.lok_rezidivart;
  create table metadata_repository.lok_rezidivart(
    id serial primary key,
    sourceid varchar not null,
    lok_rezidivart varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, lok_rezidivart)
);

 
  -- einwilligung
  drop table if exists metadata_repository.einwilligung;
  create table metadata_repository.einwilligung(
    id serial primary key,
    sourceid varchar not null,
    einwilligung varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, einwilligung)
);

  -- tumorauspraegung
  drop table if exists metadata_repository.tumorauspraegung;
  create table metadata_repository.tumorauspraegung(
    id serial primary key,
    sourceid varchar not null,
    tumorauspraegung varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, tumorauspraegung)
);

  -- erfassungsanlass
  drop table if exists metadata_repository.erfassungsanlass;
  create table metadata_repository.erfassungsanlass(
    id serial primary key,
    sourceid varchar not null,
    erfassungsanlass varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, erfassungsanlass)
);

  -- arzt_anlass
  drop table if exists metadata_repository.arzt_anlass;
  create table metadata_repository.arzt_anlass(
    id serial primary key,
    sourceid varchar not null,
    arzt_anlass varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, arzt_anlass)
);

  -- diagsich_hoechste
  drop table if exists metadata_repository.diagsich_hoechste;
  create table metadata_repository.diagsich_hoechste(
    id serial primary key,
    sourceid varchar not null,
    diagsich_hoechste varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, diagsich_hoechste)
);


  -- abschluss_grund
  drop table if exists metadata_repository.abschluss_grund;
  create table metadata_repository.abschluss_grund(
    id serial primary key,
    sourceid varchar not null,
    abschluss_grund varchar not null,
    description varchar,
    source varchar not null default 'gtds' references metadata_repository.sources(sourceid),
    inserted timestamp not null default now(),
    unique(sourceid, abschluss_grund)
);

  -- residiv
  drop table if exists metadata_repository.residiv;
  create table metadata_repository.residiv(
    id serial primary key,
    sourceid varchar not null,
    residiv varchar not null,
    description varchar,
    source varchar not null references metadata_repository.sources(sourceid) default 'gtds',
    inserted timestamp not null default now(),
    unique(sourceid, residiv)
);
