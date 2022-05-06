--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2_TDE_1.1.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kis; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA kis;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: nbew; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.nbew (
    einri character varying(4) NOT NULL,
    falnr character varying NOT NULL,
    lfdbew integer NOT NULL,
    bewty character(1),
    bwart character varying(2),
    bwidt date,
    bwizt time without time zone,
    planb boolean,
    statu character varying(2),
    bwedt date,
    bwezt time without time zone,
    plane boolean,
    lfdref integer,
    notkz boolean,
    unfkz character varying(3),
    orgfa character varying(8),
    orgpf character varying(8),
    zimmr character varying(8),
    bett character varying(8),
    planr character varying(10),
    orgau character varying(8),
    ezust character varying(2),
    todur character varying(3),
    erdat date,
    updat date,
    storn boolean,
    stdat date,
    bekat character varying(6),
    nfgref integer,
    vgnref integer,
    stoid character varying(3),
    dspty character varying(8),
    visty character varying(1),
    bwgr1 character varying(2),
    bwgr2 character varying(2),
    tpart character varying(2),
    unfvs boolean,
    insev character varying(4),
    opart character varying(2),
    class character varying(4),
    rfsrc character varying(2),
    fachr character varying(4),
    unfrt character varying(4),
    unfav character varying(2),
    retrievaldate timestamp without time zone,
    bwpdt date,
    bwpzt time without time zone
);


--
-- Name: dqa_bew_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_bew_einri_jahr AS
 SELECT date_part('year'::text, n.bwidt) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)), (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bekat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bekat AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bekat)::text ~ '\w'::text) THEN n.bekat
            ELSE NULL::character varying
        END AS bekat,
    b.behandlungskategorie
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.behandlungskategorie b ON (((n.bekat)::text = (b.sourceid)::text)))
  GROUP BY n.bekat, b.behandlungskategorie
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bekat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bekat_jahr AS
 SELECT date_part('year'::text, n.bwidt) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bekat)::text ~ '\w'::text) THEN n.bekat
            ELSE NULL::character varying
        END AS bekat,
    b.behandlungskategorie
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.behandlungskategorie b ON (((n.bekat)::text = (b.sourceid)::text)))
  GROUP BY n.bekat, b.behandlungskategorie, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)), (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bett; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bett AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bett)::text ~ '\w'::text) THEN n.bett
            ELSE NULL::character varying
        END AS bett
   FROM kis.nbew n
  GROUP BY n.bett
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bett_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bett_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bett)::text ~ '\w'::text) THEN n.bett
            ELSE NULL::character varying
        END AS bett,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.bett, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bew_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bew_jahr AS
 SELECT count(n.falnr) AS bewegungen,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC;


--
-- Name: dqa_nbew_bewty; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bewty AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN (n.bewty ~ '\w'::text) THEN n.bewty
            ELSE NULL::bpchar
        END AS bewty,
    b.bewegungstyp AS bewegunstyp
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.bewegungstyp b ON ((n.bewty = (b.bewty)::bpchar)))
  GROUP BY n.bewty, b.bewegungstyp
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bewty_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bewty_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN (n.bewty ~ '\w'::text) THEN n.bewty
            ELSE NULL::bpchar
        END AS bewty,
    b.bewegungstyp AS bewegunstyp,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.bewegungstyp b ON ((n.bewty = (b.bewty)::bpchar)))
  GROUP BY n.bewty, b.bewegungstyp, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, n.bewty;


--
-- Name: dqa_nbew_bwart; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwart AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwart)::text ~ '\w'::text) THEN n.bwart
            ELSE NULL::character varying
        END AS bwart
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.bewegunsart b ON (((n.bwart)::text = (b.bwart)::text)))
  GROUP BY n.bwart, b.bewegunsart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bwart_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwart_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwart)::text ~ '\w'::text) THEN n.bwart
            ELSE NULL::character varying
        END AS bwart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.bewegunsart b ON (((n.bwart)::text = (b.bwart)::text)))
  GROUP BY n.bwart, b.bewegunsart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bwgr1; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwgr1 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwgr1)::text ~ '\w'::text) THEN n.bwgr1
            ELSE NULL::character varying
        END AS bwgr1
   FROM kis.nbew n
  GROUP BY n.bwgr1
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bwgr1_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwgr1_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwgr1)::text ~ '\w'::text) THEN n.bwgr1
            ELSE NULL::character varying
        END AS bwgr1,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.bwgr1, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bwgr2; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwgr2 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwgr2)::text ~ '\w'::text) THEN n.bwgr2
            ELSE NULL::character varying
        END AS bwgr2
   FROM kis.nbew n
  GROUP BY n.bwgr2
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_bwgr2_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_bwgr2_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwgr2)::text ~ '\w'::text) THEN n.bwgr2
            ELSE NULL::character varying
        END AS bwgr2,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.bwgr2, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_class; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_class AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.class)::text ~ '\w'::text) THEN n.class
            ELSE NULL::character varying
        END AS class
   FROM kis.nbew n
  GROUP BY n.class
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_class_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_class_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.class)::text ~ '\w'::text) THEN n.class
            ELSE NULL::character varying
        END AS class,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.class, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_datum_problem; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_datum_problem AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((((((n.bwedt)::character varying)::text || ' '::text) || ((n.bwezt)::character varying)::text))::timestamp without time zone < (((((n.bwidt)::character varying)::text || ' '::text) || ((n.bwizt)::character varying)::text))::timestamp without time zone) THEN 'star > end'::text
            WHEN (n.bwedt = '9999-12-31'::date) THEN 'no end date (date = 9999-12-31)'::text
            WHEN (n.bwezt = '00:00:00'::time without time zone) THEN 'no end time (time = 00:00:00)'::text
            WHEN (n.bwidt > now()) THEN 'start > now'::text
            ELSE 'ok'::text
        END AS problem
   FROM kis.nbew n
  GROUP BY
        CASE
            WHEN ((((((n.bwedt)::character varying)::text || ' '::text) || ((n.bwezt)::character varying)::text))::timestamp without time zone < (((((n.bwidt)::character varying)::text || ' '::text) || ((n.bwizt)::character varying)::text))::timestamp without time zone) THEN 'star > end'::text
            WHEN (n.bwedt = '9999-12-31'::date) THEN 'no end date (date = 9999-12-31)'::text
            WHEN (n.bwezt = '00:00:00'::time without time zone) THEN 'no end time (time = 00:00:00)'::text
            WHEN (n.bwidt > now()) THEN 'start > now'::text
            ELSE 'ok'::text
        END
  ORDER BY (count(n.falnr));


--
-- Name: dqa_nbew_dspty; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_dspty AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dspty)::text ~ '\w'::text) THEN n.dspty
            ELSE NULL::character varying
        END AS dspty
   FROM kis.nbew n
  GROUP BY n.dspty
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_dspty_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_dspty_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dspty)::text ~ '\w'::text) THEN n.dspty
            ELSE NULL::character varying
        END AS dspty,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.dspty, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_einri; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_einri AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_einri_jahr AS
 SELECT date_part('year'::text, n.bwidt) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)), (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_fachr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_fachr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fachr)::text ~ '\w'::text) THEN n.fachr
            ELSE NULL::character varying
        END AS fachr
   FROM kis.nbew n
  GROUP BY n.fachr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_fachr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_fachr_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fachr)::text ~ '\w'::text) THEN n.fachr
            ELSE NULL::character varying
        END AS fachr,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.fachr, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_insev; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_insev AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.insev)::text ~ '\w'::text) THEN n.insev
            ELSE NULL::character varying
        END AS insev
   FROM kis.nbew n
  GROUP BY n.insev
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_insev_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_insev_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.insev)::text ~ '\w'::text) THEN n.insev
            ELSE NULL::character varying
        END AS insev,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.insev, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_null_values; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_null_values AS
 SELECT count(n.einri) AS quantity,
    'einri'::text AS columns
   FROM kis.nbew n
  WHERE ((n.einri IS NULL) OR ((n.einri)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.falnr) AS quantity,
    'falnr'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.falnr IS NULL) OR ((nbew.falnr)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.falnr) AS quantity,
    'lfdbew'::text AS columns
   FROM kis.nbew
  WHERE (nbew.lfdbew IS NULL)
UNION
 SELECT count(nbew.bewty) AS quantity,
    'bewty'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bewty IS NULL) OR (nbew.bewty !~ '^\w'::text))
UNION
 SELECT count(nbew.bwart) AS quantity,
    'bwart'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bwart IS NULL) OR ((nbew.bwart)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.bwidt) AS quantity,
    'bwidt'::text AS columns
   FROM kis.nbew
  WHERE (nbew.bwidt IS NULL)
UNION
 SELECT count(nbew.bwizt) AS quantity,
    'bwizt'::text AS columns
   FROM kis.nbew
  WHERE (nbew.bwizt IS NULL)
UNION
 SELECT count(nbew.planb) AS quantity,
    'planb'::text AS columns
   FROM kis.nbew
  WHERE (nbew.planb IS NULL)
UNION
 SELECT count(nbew.statu) AS quantity,
    'statu'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.statu IS NULL) OR ((nbew.statu)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.bwedt) AS quantity,
    'bwedt'::text AS columns
   FROM kis.nbew
  WHERE (nbew.bwedt IS NULL)
UNION
 SELECT count(nbew.bwezt) AS quantity,
    'bwezt'::text AS columns
   FROM kis.nbew
  WHERE (nbew.bwezt IS NULL)
UNION
 SELECT count(nbew.plane) AS quantity,
    'plane'::text AS columns
   FROM kis.nbew
  WHERE (nbew.plane IS NULL)
UNION
 SELECT count(nbew.lfdbew) AS quantity,
    'lfdbew'::text AS columns
   FROM kis.nbew
  WHERE (nbew.lfdbew IS NULL)
UNION
 SELECT count(nbew.lfdref) AS quantity,
    'lfdref'::text AS columns
   FROM kis.nbew
  WHERE (nbew.lfdref IS NULL)
UNION
 SELECT count(nbew.notkz) AS quantity,
    'notkz'::text AS columns
   FROM kis.nbew
  WHERE (nbew.notkz IS NULL)
UNION
 SELECT count(nbew.unfkz) AS quantity,
    'unfkz'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.unfkz IS NULL) OR ((nbew.unfkz)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.orgfa) AS quantity,
    'orgfa'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.orgfa IS NULL) OR ((nbew.orgfa)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.orgpf) AS quantity,
    'orgpf'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.orgpf IS NULL) OR ((nbew.orgpf)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.zimmr) AS quantity,
    'zimmr'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.zimmr IS NULL) OR ((nbew.zimmr)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.bett) AS quantity,
    'bett'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bett IS NULL) OR ((nbew.bett)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.planr) AS quantity,
    'planr'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.planr IS NULL) OR ((nbew.planr)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.orgau) AS quantity,
    'orgau'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.orgau IS NULL) OR ((nbew.orgau)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.ezust) AS quantity,
    'ezust'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.ezust IS NULL) OR ((nbew.ezust)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.todur) AS quantity,
    'todur'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.todur IS NULL) OR ((nbew.todur)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.erdat) AS quantity,
    'erdat'::text AS columns
   FROM kis.nbew
  WHERE (nbew.erdat IS NULL)
UNION
 SELECT count(nbew.updat) AS quantity,
    'updat'::text AS columns
   FROM kis.nbew
  WHERE (nbew.updat IS NULL)
UNION
 SELECT count(nbew.storn) AS quantity,
    'storn'::text AS columns
   FROM kis.nbew
  WHERE (nbew.storn IS NULL)
UNION
 SELECT count(nbew.stdat) AS quantity,
    'stdat'::text AS columns
   FROM kis.nbew
  WHERE (nbew.stdat IS NULL)
UNION
 SELECT count(nbew.bekat) AS quantity,
    'bekat'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bekat IS NULL) OR ((nbew.bekat)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.nfgref) AS quantity,
    'nfgref'::text AS columns
   FROM kis.nbew
  WHERE (nbew.nfgref IS NULL)
UNION
 SELECT count(nbew.vgnref) AS quantity,
    'vgnref'::text AS columns
   FROM kis.nbew
  WHERE (nbew.vgnref IS NULL)
UNION
 SELECT count(nbew.stoid) AS quantity,
    'stoid'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.stoid IS NULL) OR ((nbew.stoid)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.dspty) AS quantity,
    'dspty'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.dspty IS NULL) OR ((nbew.dspty)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.visty) AS quantity,
    'visty'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.visty IS NULL) OR ((nbew.visty)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.bwgr1) AS quantity,
    'bwgr1'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bwgr1 IS NULL) OR ((nbew.bwgr1)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.bwgr2) AS quantity,
    'bwgr2'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.bwgr2 IS NULL) OR ((nbew.bwgr2)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.tpart) AS quantity,
    'tpart'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.tpart IS NULL) OR ((nbew.tpart)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.unfvs) AS quantity,
    'unfvs'::text AS columns
   FROM kis.nbew
  WHERE (nbew.unfvs = false)
UNION
 SELECT count(nbew.insev) AS quantity,
    'insev'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.insev IS NULL) OR ((nbew.insev)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.opart) AS quantity,
    'opart'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.opart IS NULL) OR ((nbew.opart)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.class) AS quantity,
    'tpart'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.class IS NULL) OR ((nbew.class)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.rfsrc) AS quantity,
    'rfsrc'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.rfsrc IS NULL) OR ((nbew.rfsrc)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.fachr) AS quantity,
    'fachr'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.fachr IS NULL) OR ((nbew.fachr)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.unfrt) AS quantity,
    'unfrt'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.unfrt IS NULL) OR ((nbew.unfrt)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.unfav) AS quantity,
    'unfav'::text AS columns
   FROM kis.nbew
  WHERE ((nbew.unfav IS NULL) OR ((nbew.unfav)::text !~ '^\w'::text))
UNION
 SELECT count(nbew.retrievaldate) AS quantity,
    'retrievaldate'::text AS columns
   FROM kis.nbew
  WHERE (nbew.retrievaldate IS NULL)
  ORDER BY 1, 2;


--
-- Name: dqa_nbew_opart; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_opart AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.opart)::text ~ '\w'::text) THEN n.opart
            ELSE NULL::character varying
        END AS opart
   FROM kis.nbew n
  GROUP BY n.opart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_opart_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_opart_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.opart)::text ~ '\w'::text) THEN n.opart
            ELSE NULL::character varying
        END AS opart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.opart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: norg; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.norg (
    einri character varying(4) NOT NULL,
    orgid character varying(8) NOT NULL,
    orgty character varying(2),
    orgna character varying(30),
    orgkb character varying(12),
    okurz character varying(5),
    fachr character varying(4),
    fachr2 character varying(4),
    aufkz boolean,
    inten boolean,
    fachr9 character varying(4),
    paedkz boolean,
    fachr1 character varying(4)
);


--
-- Name: dqa_nbew_orgau; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgau AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgau)::text ~ '\w'::text) THEN n.orgau
            ELSE NULL::character varying
        END AS orgau,
    nor.orgna
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgau)::text = (nor.orgid)::text)))
  GROUP BY n.orgau, nor.orgna
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_orgau_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgau_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgau)::text ~ '\w'::text) THEN n.orgau
            ELSE NULL::character varying
        END AS orgau,
    nor.orgna,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgau)::text = (nor.orgid)::text)))
  GROUP BY n.orgau, nor.orgna, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_orgfa; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgfa AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgfa)::text ~ '\w'::text) THEN n.orgfa
            ELSE NULL::character varying
        END AS orgfa,
    nor.orgna
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgfa)::text = (nor.orgid)::text)))
  GROUP BY n.orgfa, nor.orgna
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_orgfa_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgfa_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgfa)::text ~ '\w'::text) THEN n.orgfa
            ELSE NULL::character varying
        END AS orgfa,
    nor.orgna,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgfa)::text = (nor.orgid)::text)))
  GROUP BY n.orgfa, nor.orgna, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_orgpf; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgpf AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgpf)::text ~ '\w'::text) THEN n.orgpf
            ELSE NULL::character varying
        END AS orgpf,
    nor.orgna
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgpf)::text = (nor.orgid)::text)))
  GROUP BY n.orgpf, nor.orgna
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_orgpf_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_orgpf_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.orgpf)::text ~ '\w'::text) THEN n.orgpf
            ELSE NULL::character varying
        END AS orgpf,
    nor.orgna,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN kis.norg nor ON (((n.orgpf)::text = (nor.orgid)::text)))
  GROUP BY n.orgpf, nor.orgna, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_rfsrc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_rfsrc AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.rfsrc)::text ~ '\w'::text) THEN n.rfsrc
            ELSE NULL::character varying
        END AS rfsrc,
    e.einweisungs_ueberweisungs_nachbehandlungsart
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart e ON (((n.rfsrc)::text = (e.rfsrc)::text)))
  GROUP BY n.rfsrc, e.einweisungs_ueberweisungs_nachbehandlungsart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_rfsrc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_rfsrc_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.rfsrc)::text ~ '\w'::text) THEN n.rfsrc
            ELSE NULL::character varying
        END AS rfsrc,
    e.einweisungs_ueberweisungs_nachbehandlungsart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart e ON (((n.rfsrc)::text = (e.rfsrc)::text)))
  GROUP BY n.rfsrc, e.einweisungs_ueberweisungs_nachbehandlungsart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_statu; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_statu AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.statu)::text ~ '\w'::text) THEN n.statu
            ELSE NULL::character varying
        END AS statu,
    s.intstatu AS status
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.inter_status_amb_besu s ON (((n.statu)::text = (s.statu)::text)))
  GROUP BY n.statu, s.intstatu
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_statu_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_statu_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.statu)::text ~ '\w'::text) THEN n.statu
            ELSE NULL::character varying
        END AS statu,
    s.intstatu AS status,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.inter_status_amb_besu s ON (((n.statu)::text = (s.statu)::text)))
  GROUP BY n.statu, s.intstatu, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC,
        CASE
            WHEN ((n.statu)::text ~ '\w'::text) THEN n.statu
            ELSE NULL::character varying
        END;


--
-- Name: dqa_nbew_stoid; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_stoid AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.stoid)::text ~ '\w'::text) THEN n.stoid
            ELSE NULL::character varying
        END AS stoid,
    s.stornierungsgrund
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.stornierungsgrund s ON (((n.stoid)::text = (s.stoid)::text)))
  GROUP BY n.stoid, s.stornierungsgrund
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_stoid_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_stoid_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.stoid)::text ~ '\w'::text) THEN n.stoid
            ELSE NULL::character varying
        END AS stoid,
    s.stornierungsgrund,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.stornierungsgrund s ON (((n.stoid)::text = (s.stoid)::text)))
  GROUP BY n.stoid, s.stornierungsgrund, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_tpart; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_tpart AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.tpart)::text ~ '\w'::text) THEN n.tpart
            ELSE NULL::character varying
        END AS tpart,
    t.transportart
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.transportart t ON (((n.tpart)::text = (t.tpart)::text)))
  GROUP BY n.tpart, t.transportart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_tpart_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_tpart_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.tpart)::text ~ '\w'::text) THEN n.tpart
            ELSE NULL::character varying
        END AS tpart,
    t.transportart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.transportart t ON (((n.tpart)::text = (t.tpart)::text)))
  GROUP BY n.tpart, t.transportart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_unfav; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfav AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfav)::text ~ '\w'::text) THEN n.unfav
            ELSE NULL::character varying
        END AS unfav
   FROM kis.nbew n
  GROUP BY n.unfav
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_unfav_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfav_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfav)::text ~ '\w'::text) THEN n.unfav
            ELSE NULL::character varying
        END AS unfav,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.unfav, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_unfkz; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfkz AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfkz)::text ~ '\w'::text) THEN n.unfkz
            ELSE NULL::character varying
        END AS unfallid,
    u.unfallart
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.unfallart u ON (((n.unfkz)::text = (u.unfkz)::text)))
  GROUP BY
        CASE
            WHEN ((n.unfkz)::text ~ '\w'::text) THEN n.unfkz
            ELSE NULL::character varying
        END, u.unfallart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_unfkz_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfkz_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfkz)::text ~ '\w'::text) THEN n.unfkz
            ELSE NULL::character varying
        END AS unfkz,
    u.unfallart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.unfallart u ON (((n.unfkz)::text = (u.unfkz)::text)))
  GROUP BY n.unfkz, u.unfallart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC,
        CASE
            WHEN ((n.unfkz)::text ~ '\w'::text) THEN n.unfkz
            ELSE NULL::character varying
        END;


--
-- Name: dqa_nbew_unfrt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfrt AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfrt)::text ~ '\w'::text) THEN n.unfrt
            ELSE NULL::character varying
        END AS unfrt
   FROM kis.nbew n
  GROUP BY n.unfrt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_unfrt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_unfrt_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.unfrt)::text ~ '\w'::text) THEN n.unfrt
            ELSE NULL::character varying
        END AS unfrt,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.unfrt, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_zimmr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_zimmr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.zimmr)::text ~ '\w'::text) THEN n.zimmr
            ELSE NULL::character varying
        END AS zimmr
   FROM kis.nbew n
  GROUP BY n.zimmr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nbew_zimmr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbew_zimmr_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.zimmr)::text ~ '\w'::text) THEN n.zimmr
            ELSE NULL::character varying
        END AS zimmr,
    date_part('year'::text, n.bwidt) AS jahr
   FROM kis.nbew n
  GROUP BY n.zimmr, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_nbwe_bwart_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nbwe_bwart_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bwart)::text ~ '\w'::text) THEN n.bwart
            ELSE NULL::character varying
        END AS bwart,
    date_part('year'::text, n.bwidt) AS jahr
   FROM (kis.nbew n
     LEFT JOIN metadata_repository.bewegunsart b ON (((n.bwart)::text = (b.bwart)::text)))
  GROUP BY n.bwart, b.bewegunsart, (date_part('year'::text, n.bwidt))
  ORDER BY (date_part('year'::text, n.bwidt)) DESC,
        CASE
            WHEN ((n.bwart)::text ~ '\w'::text) THEN n.bwart
            ELSE NULL::character varying
        END;


--
-- Name: ndia; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.ndia (
    einri character varying(4) NOT NULL,
    falnr character varying NOT NULL,
    lfdnr integer NOT NULL,
    lfdbew integer,
    dkat1 character varying(2),
    dkey1 character varying(30),
    dkat2 character varying(2),
    dkey2 character varying(30),
    dkat_ref character varying(2),
    dkey_ref character varying(30),
    diadt date,
    diazt time without time zone,
    anzop smallint,
    ewdia boolean,
    bhdia boolean,
    afdia boolean,
    endia boolean,
    fhdia boolean,
    khdia boolean,
    opdia boolean,
    sperr boolean,
    diasi character varying(1),
    erdat date,
    updat date,
    storn boolean,
    stdat date,
    ardia boolean,
    podia boolean,
    tudia boolean,
    diabz boolean,
    diapr character varying(1),
    diagw character varying(2),
    diazs character varying(2),
    dialo character varying(2),
    diafp character varying(8),
    drg_dia_seqno integer,
    drg_category character varying(1),
    drg_relvant boolean,
    dtyp1 character varying(1),
    dtyp2 character varying(1),
    dtype_ref character varying(1),
    dia_link integer,
    ccl smallint,
    dia_valdt date,
    dia_pia_som boolean,
    retrievaldate timestamp without time zone
);


--
-- Name: dqa_ndia_afdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_afdia AS
 SELECT count(n.falnr) AS quantity,
    n.afdia
   FROM kis.ndia n
  GROUP BY n.afdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_afdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_afdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.afdia
   FROM kis.ndia n
  GROUP BY n.afdia, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_anzop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_anzop AS
 SELECT count(n.falnr) AS quantity,
    n.anzop
   FROM kis.ndia n
  GROUP BY n.anzop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_anzop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_anzop_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.anzop
   FROM kis.ndia n
  GROUP BY n.anzop, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ardia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ardia AS
 SELECT count(n.falnr) AS quantity,
    n.ardia
   FROM kis.ndia n
  GROUP BY n.ardia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ardia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ardia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.ardia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.ardia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_bhdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_bhdia AS
 SELECT count(n.falnr) AS quantity,
    n.bhdia
   FROM kis.ndia n
  GROUP BY n.bhdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_bhdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_bhdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.bhdia
   FROM kis.ndia n
  GROUP BY n.bhdia, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ccl; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ccl AS
 SELECT count(n.falnr) AS quantity,
    n.ccl,
    cl.complication_level
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.complication_level cl ON ((((n.ccl)::character varying)::text = (cl.sourceid)::text)))
  GROUP BY n.ccl, cl.complication_level
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ccl_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ccl_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.ccl,
    cl.complication_level
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.complication_level cl ON ((((n.ccl)::character varying)::text = (cl.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.ccl, cl.complication_level
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_link; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_link AS
 SELECT count(n.falnr) AS quantity,
    n.dia_link
   FROM kis.ndia n
  GROUP BY n.dia_link
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_link_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_link_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.dia_link
   FROM kis.ndia n
  GROUP BY n.dia_link, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_pia_som; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_pia_som AS
 SELECT count(n.falnr) AS quantity,
    n.dia_pia_som
   FROM kis.ndia n
  GROUP BY n.dia_pia_som
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_pia_som_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_pia_som_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.dia_pia_som
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.dia_pia_som
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_valdt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_valdt AS
 SELECT count(n.falnr) AS quantity,
    n.dia_valdt
   FROM kis.ndia n
  GROUP BY n.dia_valdt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dia_valdt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dia_valdt_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.dia_valdt
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.dia_valdt
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diabz; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diabz AS
 SELECT count(n.falnr) AS quantity,
    n.diabz
   FROM kis.ndia n
  GROUP BY n.diabz
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diabz_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diabz_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.diabz
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.diabz
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diadt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diadt AS
 SELECT count(n.falnr) AS quantity,
    n.diadt
   FROM kis.ndia n
  GROUP BY n.diadt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diadt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diadt_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.diadt
   FROM kis.ndia n
  GROUP BY n.diadt, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diafp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diafp AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diafp)::text ~ '^\w'::text) THEN n.diafp
            ELSE NULL::character varying
        END AS diafp
   FROM kis.ndia n
  GROUP BY n.diafp
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diafp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diafp_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diafp)::text ~ '^\w'::text) THEN n.diafp
            ELSE NULL::character varying
        END AS diafp
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.diafp
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diagw; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diagw AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diagw)::text ~ '^\w'::text) THEN n.diagw
            ELSE NULL::character varying
        END AS diagw,
    dc.diag_gewissheit AS diagnosis_certainty
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diag_gewissheit dc ON (((n.diagw)::text = (dc.sourceid)::text)))
  GROUP BY n.diagw, dc.diag_gewissheit
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diagw_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diagw_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diagw)::text ~ '^\w'::text) THEN n.diagw
            ELSE NULL::character varying
        END AS diagw,
    dc.diag_gewissheit AS diagnosis_certainty
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diag_gewissheit dc ON (((n.diagw)::text = (dc.sourceid)::text)))
  GROUP BY n.diagw, (date_part('year'::text, n.erdat)), dc.diag_gewissheit
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dialo; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dialo AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dialo)::text ~ '^\w'::text) THEN n.dialo
            ELSE NULL::character varying
        END AS dialo,
    bl.localisation
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.body_localisation bl ON (((n.dialo)::text = (bl.sourceid)::text)))
  GROUP BY n.dialo, bl.localisation
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dialo_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dialo_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dialo)::text ~ '^\w'::text) THEN n.dialo
            ELSE NULL::character varying
        END AS dialo,
    bl.localisation
   FROM (kis.ndia n
     JOIN metadata_repository.body_localisation bl ON (((n.dialo)::text = (bl.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.dialo, bl.localisation
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diapr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diapr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diapr)::text ~ '^\w'::text) THEN n.diapr
            ELSE NULL::character varying
        END AS diapr
   FROM kis.ndia n
  GROUP BY n.diapr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diapr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diapr_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diapr)::text ~ '^\w'::text) THEN n.diapr
            ELSE NULL::character varying
        END AS diapr
   FROM kis.ndia n
  GROUP BY n.diapr, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diasi; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diasi AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diasi)::text ~ '^\w'::text) THEN n.diasi
            ELSE NULL::character varying
        END AS diasi
   FROM kis.ndia n
  GROUP BY n.diasi
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diasi_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diasi_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diasi)::text ~ '^\w'::text) THEN n.diasi
            ELSE NULL::character varying
        END AS diasi
   FROM kis.ndia n
  GROUP BY n.diasi, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diazs; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diazs AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diazs)::text ~ '^\w'::text) THEN n.diazs
            ELSE NULL::character varying
        END AS diazs,
    da.diagnosenzusatz AS diagnosis_additive
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosenzusatz da ON (((n.diazs)::text = (da.sourceid)::text)))
  GROUP BY n.diazs, da.diagnosenzusatz
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diazs_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diazs_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.diazs)::text ~ '^\w'::text) THEN n.diazs
            ELSE NULL::character varying
        END AS diazs,
    da.diagnosenzusatz AS diagnosis_additive
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosenzusatz da ON (((n.diazs)::text = (da.sourceid)::text)))
  GROUP BY n.diazs, (date_part('year'::text, n.erdat)), da.diagnosenzusatz
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diazt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diazt AS
 SELECT count(n.falnr) AS quantity,
    n.diazt
   FROM kis.ndia n
  GROUP BY n.diazt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_diazt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_diazt_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.diazt
   FROM kis.ndia n
  GROUP BY n.diazt, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat1; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat1 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat1)::text ~ '^\w'::text) THEN n.dkat1
            ELSE NULL::character varying
        END AS dkat1
   FROM kis.ndia n
  GROUP BY n.dkat1
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat1_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat1_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat1)::text ~ '\w'::text) THEN n.dkat1
            ELSE NULL::character varying
        END AS dkat1,
    date_part('year'::text, n.erdat) AS jahr
   FROM kis.ndia n
  GROUP BY n.dkat1, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat2; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat2 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat2)::text ~ '^\w'::text) THEN n.dkat2
            ELSE NULL::character varying
        END AS dkat2
   FROM kis.ndia n
  GROUP BY n.dkat2
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat2_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat2_jahr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat2)::text ~ '\w'::text) THEN n.dkat2
            ELSE NULL::character varying
        END AS dkat2,
    date_part('year'::text, n.erdat) AS jahr
   FROM kis.ndia n
  GROUP BY n.dkat2, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat_ref; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat_ref AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat_ref)::text ~ '^\w'::text) THEN n.dkat_ref
            ELSE NULL::character varying
        END AS dkat_ref
   FROM kis.ndia n
  GROUP BY n.dkat_ref
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkat_ref_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkat_ref_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkat_ref)::text ~ '^\w'::text) THEN n.dkat_ref
            ELSE NULL::character varying
        END AS dkat_ref
   FROM kis.ndia n
  GROUP BY n.dkat_ref, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey1; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey1 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey1)::text ~ '^\w'::text) THEN n.dkey1
            ELSE NULL::character varying
        END AS dkey1,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey1)::text = (ig.normcode)::text)))
  GROUP BY n.dkey1, ig.titel, ig.normcode
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey1_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey1_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey1)::text ~ '^\w'::text) THEN n.dkey1
            ELSE NULL::character varying
        END AS dkey1,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey1)::text = (ig.normcode)::text)))
  GROUP BY n.dkey1, ig.titel, ig.normcode, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey2; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey2 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey2)::text ~ '^\w'::text) THEN n.dkey2
            ELSE NULL::character varying
        END AS dkey2,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey2)::text = (ig.normcode)::text)))
  GROUP BY n.dkey2, ig.titel, ig.normcode
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey2_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey2_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey2)::text ~ '^\w'::text) THEN n.dkey2
            ELSE NULL::character varying
        END AS dkey2,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey2)::text = (ig.normcode)::text)))
  GROUP BY n.dkey2, ig.titel, ig.normcode, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey_ref; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey_ref AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey_ref)::text ~ '^\w'::text) THEN n.dkey_ref
            ELSE NULL::character varying
        END AS dkey_ref,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey_ref)::text = (ig.normcode)::text)))
  GROUP BY n.dkey_ref, ig.titel, ig.normcode
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dkey_ref_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dkey_ref_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dkey_ref)::text ~ '^\w'::text) THEN n.dkey_ref
            ELSE NULL::character varying
        END AS dkey_ref,
    ig.normcode AS icd10gm,
    ig.titel
   FROM (kis.ndia n
     LEFT JOIN icd_metainfo.icd10gm ig ON (((n.dkey_ref)::text = (ig.normcode)::text)))
  GROUP BY n.dkey_ref, ig.titel, ig.normcode, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_category; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_category AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN n.drg_category
            ELSE NULL::character varying
        END AS drg_category,
    dt.diagnosis_type
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type dt ON (((n.drg_category)::text = (dt.sourceid)::text)))
  GROUP BY n.drg_category, dt.diagnosis_type
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_category_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_category_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN n.drg_category
            ELSE NULL::character varying
        END AS drg_category,
    dt.diagnosis_type
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type dt ON (((n.drg_category)::text = (dt.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.drg_category, dt.diagnosis_type
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_dia_seqno; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_dia_seqno AS
 SELECT count(n.falnr) AS quantity,
    n.drg_dia_seqno
   FROM kis.ndia n
  GROUP BY n.drg_dia_seqno
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_dia_seqno_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_dia_seqno_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.drg_dia_seqno
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.drg_dia_seqno
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_relvant; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_relvant AS
 SELECT count(n.falnr) AS quantity,
    n.drg_relvant
   FROM kis.ndia n
  GROUP BY n.drg_relvant
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_drg_relvant_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_drg_relvant_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.drg_relvant
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.drg_relvant
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtye_ref; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtye_ref AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtype_ref)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtype_ref
            ELSE NULL::character varying
        END AS dtype_ref,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtype_ref)::text = (dti.sourceid)::text)))
  GROUP BY n.dtype_ref, dti.diagnosis_type_icd
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtye_ref_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtye_ref_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtype_ref)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtype_ref
            ELSE NULL::character varying
        END AS dtype_ref,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtype_ref)::text = (dti.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.dtype_ref, dti.diagnosis_type_icd
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtyp1; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtyp1 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtyp1)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtyp1
            ELSE NULL::character varying
        END AS dtyp1,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtyp1)::text = (dti.sourceid)::text)))
  GROUP BY n.dtyp1, dti.diagnosis_type_icd
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtyp1_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtyp1_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtyp1)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtyp1
            ELSE NULL::character varying
        END AS dtyp1,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtyp1)::text = (dti.sourceid)::text)))
  GROUP BY n.dtyp1, dti.diagnosis_type_icd, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtyp2; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtyp2 AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtyp2)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtyp2
            ELSE NULL::character varying
        END AS dtyp2,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtyp2)::text = (dti.sourceid)::text)))
  GROUP BY n.dtyp2, dti.diagnosis_type_icd
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_dtyp2_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_dtyp2_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.dtyp2)::text = ANY (ARRAY[('!'::character varying)::text, ('*'::character varying)::text, ('+'::character varying)::text, ('#'::character varying)::text, ('M'::character varying)::text])) THEN n.dtyp2
            ELSE NULL::character varying
        END AS dtyp2,
    dti.diagnosis_type_icd
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.diagnosis_type_icd dti ON (((n.dtyp2)::text = (dti.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.dtyp2, dti.diagnosis_type_icd
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_einri; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_einri AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_einri_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.ndia n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_endia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_endia AS
 SELECT count(n.falnr) AS quantity,
    n.endia
   FROM kis.ndia n
  GROUP BY n.endia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_endia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_endia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.endia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.endia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_erdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_erdat AS
 SELECT count(n.falnr) AS quantity,
    n.erdat
   FROM kis.ndia n
  GROUP BY n.erdat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_erdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_erdat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.erdat
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.erdat
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ewdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ewdia AS
 SELECT count(n.falnr) AS quantity,
    n.ewdia
   FROM kis.ndia n
  GROUP BY n.ewdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_ewdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_ewdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.ewdia
   FROM kis.ndia n
  GROUP BY n.ewdia, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_fhdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_fhdia AS
 SELECT count(n.falnr) AS quantity,
    n.fhdia
   FROM kis.ndia n
  GROUP BY n.fhdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_fhdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_fhdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.fhdia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.fhdia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_jahr AS
 SELECT date_part('year'::text, ndia.erdat) AS jahr,
    count(ndia.falnr) AS quantity
   FROM kis.ndia
  GROUP BY (date_part('year'::text, ndia.erdat))
  ORDER BY (date_part('year'::text, ndia.erdat)) DESC;


--
-- Name: dqa_ndia_khdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_khdia AS
 SELECT count(n.falnr) AS quantity,
    n.khdia
   FROM kis.ndia n
  GROUP BY n.khdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_khdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_khdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.khdia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.khdia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_null_values; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_null_values AS
 SELECT count(n.falnr) AS quantity,
    'einri'::text AS columns
   FROM kis.ndia n
  WHERE ((n.einri IS NULL) OR ((n.einri)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'falnr'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.falnr IS NULL) OR ((ndia.falnr)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'lfdnr'::text AS columns
   FROM kis.ndia
  WHERE (ndia.lfdnr IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'lfdbew'::text AS columns
   FROM kis.ndia
  WHERE (ndia.lfdbew IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkat1'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkat1 IS NULL) OR ((ndia.dkat1)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkat2'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkat2 IS NULL) OR ((ndia.dkat2)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkey1'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkey1 IS NULL) OR ((ndia.dkey1)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkey2'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkey2 IS NULL) OR ((ndia.dkey2)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkat_ref'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkat_ref IS NULL) OR ((ndia.dkat_ref)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dkey_ref'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dkey_ref IS NULL) OR ((ndia.dkey_ref)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diadt'::text AS columns
   FROM kis.ndia
  WHERE (ndia.diadt IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diazt'::text AS columns
   FROM kis.ndia
  WHERE (ndia.diazt IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'anzop'::text AS columns
   FROM kis.ndia
  WHERE (ndia.anzop IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'ewdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.ewdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'bhdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.bhdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'afdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.afdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'endia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.endia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'fhdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.fhdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'khdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.khdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'opdia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.opdia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'sperr'::text AS columns
   FROM kis.ndia
  WHERE (ndia.sperr IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diasi'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.diasi IS NULL) OR ((ndia.diasi)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'erdat'::text AS columns
   FROM kis.ndia
  WHERE (ndia.erdat IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'updat'::text AS columns
   FROM kis.ndia
  WHERE (ndia.updat IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'storn'::text AS columns
   FROM kis.ndia
  WHERE (ndia.storn IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'stdat'::text AS columns
   FROM kis.ndia
  WHERE (ndia.stdat IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'ardia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.ardia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'podia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.podia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'tudia'::text AS columns
   FROM kis.ndia
  WHERE (ndia.tudia IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'stdat'::text AS columns
   FROM kis.ndia
  WHERE (ndia.stdat IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diabz'::text AS columns
   FROM kis.ndia
  WHERE (ndia.diabz IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diapr'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.diapr IS NULL) OR ((ndia.diapr)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diagw'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.diagw IS NULL) OR ((ndia.diagw)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diazr'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.diazs IS NULL) OR ((ndia.diazs)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dialo'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dialo IS NULL) OR ((ndia.dialo)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'diafp'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.diafp IS NULL) OR ((ndia.diafp)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'drg_dia_seqno'::text AS columns
   FROM kis.ndia
  WHERE (ndia.drg_dia_seqno IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'drg_category'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.drg_category IS NULL) OR ((ndia.drg_category)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'drg_relevant'::text AS columns
   FROM kis.ndia
  WHERE (ndia.drg_relvant IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dtyp1'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dtyp1 IS NULL) OR ((ndia.dtyp1)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dtyp2'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dtyp2 IS NULL) OR ((ndia.dtyp2)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dtype_ref'::text AS columns
   FROM kis.ndia
  WHERE ((ndia.dtype_ref IS NULL) OR ((ndia.dtype_ref)::text !~ '^\w'::text))
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dia_link'::text AS columns
   FROM kis.ndia
  WHERE (ndia.dia_link IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'ccl'::text AS columns
   FROM kis.ndia
  WHERE (ndia.ccl IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dia_valdt'::text AS columns
   FROM kis.ndia
  WHERE (ndia.dia_valdt IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'dia_pia_som'::text AS columns
   FROM kis.ndia
  WHERE (ndia.dia_pia_som IS NULL)
UNION
 SELECT count(ndia.falnr) AS quantity,
    'retrievaldate'::text AS columns
   FROM kis.ndia
  WHERE (ndia.retrievaldate IS NULL)
  ORDER BY 1, 2;


--
-- Name: dqa_ndia_opdia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_opdia AS
 SELECT count(n.falnr) AS quantity,
    n.opdia
   FROM kis.ndia n
  GROUP BY n.opdia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_opdia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_opdia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.opdia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.opdia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_podia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_podia AS
 SELECT count(n.falnr) AS quantity,
    n.podia
   FROM kis.ndia n
  GROUP BY n.podia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_podia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_podia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.podia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.podia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_sperr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_sperr AS
 SELECT count(n.falnr) AS quantity,
    n.sperr
   FROM kis.ndia n
  GROUP BY n.sperr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_sperr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_sperr_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.sperr
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.sperr
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_stdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_stdat AS
 SELECT count(n.falnr) AS quantity,
    n.stdat
   FROM kis.ndia n
  GROUP BY n.stdat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_stdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_stdat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.stdat
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.stdat
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_storn; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_storn AS
 SELECT count(n.falnr) AS quantity,
    n.storn
   FROM kis.ndia n
  GROUP BY n.storn
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_storn_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_storn_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.storn
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.storn
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_tudia; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_tudia AS
 SELECT count(n.falnr) AS quantity,
    n.tudia
   FROM kis.ndia n
  GROUP BY n.tudia
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_tudia_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_tudia_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.tudia
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.tudia
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_updat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_updat AS
 SELECT count(n.falnr) AS quantity,
    n.updat
   FROM kis.ndia n
  GROUP BY n.updat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_ndia_updat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_ndia_updat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.falnr) AS quantity,
    n.updat
   FROM kis.ndia n
  GROUP BY (date_part('year'::text, n.erdat)), n.updat
  ORDER BY (date_part('year'::text, n.erdat)) DESC, (count(n.falnr)) DESC;


--
-- Name: nfal; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.nfal (
    einri character varying(4) NOT NULL,
    falnr character varying NOT NULL,
    falar character varying(1),
    patnr character varying,
    bekat character varying(6),
    abrkz character varying(1),
    sichv boolean,
    statu character varying(1),
    notan boolean,
    krzan boolean,
    endat date,
    fgtyp character varying(1),
    kzkom boolean,
    enddt date,
    erdat date,
    updat date,
    storn boolean,
    stdat date,
    begdt date,
    fatyp character varying(2),
    fachr character varying(4),
    endtyp character varying(2),
    patw boolean,
    patgew numeric(7,3),
    gwein character varying(3),
    patgro numeric(5,2),
    grein character varying(3),
    resp integer,
    delgw smallint,
    saps_c smallint,
    pim2_c smallint,
    crib_c smallint,
    nems_c integer,
    saps_imc smallint,
    pim2_imc smallint,
    crib_imc smallint,
    nems_imc integer,
    respi_imc integer,
    readm boolean,
    retrievaldate timestamp without time zone,
    einzg character varying(10),
    infkz boolean,
    entim time without time zone
);


--
-- Name: dqa_nfal_abrkz; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_abrkz AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.abrkz)::text ~ '^\w'::text) THEN n.abrkz
            ELSE NULL::character varying
        END AS abrkz
   FROM kis.nfal n
  GROUP BY n.abrkz
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_abrkz_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_abrkz_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.abrkz)::text ~ '^\w'::text) THEN n.abrkz
            ELSE NULL::character varying
        END AS abrkz
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.abrkz
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_begdt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_begdt AS
 SELECT count(n.falnr) AS quantity,
    n.begdt
   FROM kis.nfal n
  GROUP BY n.begdt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_begdt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_begdt_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.begdt
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.begdt
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_bekat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_bekat AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bekat)::text ~ '^\w'::text) THEN n.bekat
            ELSE NULL::character varying
        END AS bkat,
    b.behandlungskategorie
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.behandlungskategorie b ON (((n.bekat)::text = (b.sourceid)::text)))
  GROUP BY n.bekat, b.behandlungskategorie
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_bekat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_bekat_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.bekat)::text ~ '^\w'::text) THEN n.bekat
            ELSE NULL::character varying
        END AS bkat,
    b.behandlungskategorie
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.behandlungskategorie b ON (((n.bekat)::text = (b.sourceid)::text)))
  GROUP BY n.bekat, b.behandlungskategorie,
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_crib_c; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_crib_c AS
 SELECT count(n.falnr) AS quantity,
    n.crib_c
   FROM kis.nfal n
  GROUP BY n.crib_c
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_crib_c_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_crib_c_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.crib_c
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.crib_c
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_crib_imc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_crib_imc AS
 SELECT count(n.falnr) AS quantity,
    n.crib_imc
   FROM kis.nfal n
  GROUP BY n.crib_imc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_crib_imc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_crib_imc_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.crib_imc
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.crib_imc
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_delgw; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_delgw AS
 SELECT count(n.falnr) AS quantity,
    n.delgw
   FROM kis.nfal n
  GROUP BY n.delgw
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_delgw_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_delgw_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.delgw
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.delgw
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_einri; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_einri AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_einri_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri,
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_endat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_endat AS
 SELECT count(n.falnr) AS quantity,
    n.endat
   FROM kis.nfal n
  GROUP BY n.endat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_endat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_endat_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.endat
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.endat
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_enddt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_enddt AS
 SELECT count(n.falnr) AS quantity,
    n.enddt
   FROM kis.nfal n
  GROUP BY n.enddt
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_enddt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_enddt_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.enddt
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.enddt
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_endtyp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_endtyp AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.endtyp)::text ~ '^\w'::text) THEN n.endtyp
            ELSE NULL::character varying
        END AS endtyp,
    f.fallendes
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.fallendes f ON (((n.endtyp)::text = (f.sourceid)::text)))
  GROUP BY n.endtyp, f.fallendes
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_endtyp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_endtyp_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.endtyp)::text ~ '^\w'::text) THEN n.endtyp
            ELSE NULL::character varying
        END AS endtyp,
    f.fallendes
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.fallendes f ON (((f.sourceid)::text = (n.endtyp)::text)))
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.endtyp, f.fallendes
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_erdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_erdat AS
 SELECT count(n.falnr) AS quantity,
    n.erdat
   FROM kis.nfal n
  GROUP BY n.erdat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_erdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_erdat_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.erdat
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.erdat
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fachr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fachr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fachr)::text ~ '^\w'::text) THEN n.fachr
            ELSE NULL::character varying
        END AS fachr,
    f.fachrichtung
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.fachrichtung f ON (((n.fachr)::text = (f.sourceid)::text)))
  GROUP BY n.fachr, f.fachrichtung
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fachr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fachr_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fachr)::text ~ '^\w'::text) THEN n.fachr
            ELSE NULL::character varying
        END AS fachr,
    f.fachrichtung
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.fachrichtung f ON (((f.sourceid)::text = (n.fachr)::text)))
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.fachr, f.fachrichtung
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_falar; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_falar AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.falar)::text ~ '^\d'::text) THEN n.falar
            ELSE NULL::character varying
        END AS falar
   FROM kis.nfal n
  GROUP BY n.falar
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_falar_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_falar_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.falar)::text ~ '^\d'::text) THEN n.falar
            ELSE NULL::character varying
        END AS falar
   FROM kis.nfal n
  GROUP BY n.falar,
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fatyp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fatyp AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fatyp)::text ~ '^\w'::text) THEN n.fatyp
            ELSE NULL::character varying
        END AS fatyp
   FROM kis.nfal n
  GROUP BY n.fatyp
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fatyp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fatyp_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fatyp)::text ~ '^\w'::text) THEN n.fatyp
            ELSE NULL::character varying
        END AS fatyp
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.fatyp
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fgtyp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fgtyp AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fgtyp)::text ~ '^\w'::text) THEN n.fgtyp
            ELSE NULL::character varying
        END AS fgtyp
   FROM kis.nfal n
  GROUP BY n.fgtyp
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_fgtyp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_fgtyp_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.fgtyp)::text ~ '^\w'::text) THEN n.fgtyp
            ELSE NULL::character varying
        END AS fgtyp
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.fgtyp
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_grein; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_grein AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.grein)::text ~ '^\w'::text) THEN n.grein
            ELSE NULL::character varying
        END AS grein,
    u.unitid,
    u.unitname
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.units u ON (((u.sourceid)::text = (n.grein)::text)))
  GROUP BY n.grein, u.unitid, u.unitname
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_grein_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_grein_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.grein)::text ~ '^\w'::text) THEN n.grein
            ELSE NULL::character varying
        END AS grein,
    u.unitid,
    u.unitname
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.units u ON (((u.sourceid)::text = (n.grein)::text)))
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.grein, u.unitid, u.unitname
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_gwein; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_gwein AS
 SELECT count(n.falnr) AS quantity,
    n.gwein,
    u.unitid,
    u.unitname
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.units u ON (((n.gwein)::text = (u.sourceid)::text)))
  GROUP BY n.gwein, u.unitid, u.unitname
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_gwein_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_gwein_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.gwein)::text ~ '^\w'::text) THEN n.gwein
            ELSE NULL::character varying
        END AS gwein,
    u.unitid,
    u.unitname
   FROM (kis.nfal n
     LEFT JOIN metadata_repository.units u ON (((n.gwein)::text = (u.sourceid)::text)))
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.gwein, u.unitid, u.unitname
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_krzan; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_krzan AS
 SELECT count(n.falnr) AS quantity,
    n.krzan
   FROM kis.nfal n
  GROUP BY n.krzan
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_krzan_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_krzan_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.krzan
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.krzan
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_kzkom; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_kzkom AS
 SELECT count(n.falnr) AS quantity,
    n.kzkom
   FROM kis.nfal n
  GROUP BY n.kzkom
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_kzkom_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_kzkom_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.kzkom
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.kzkom
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_nems_c; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_nems_c AS
 SELECT count(n.falnr) AS quantity,
    n.nems_c
   FROM kis.nfal n
  GROUP BY n.nems_c
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_nems_c_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_nems_c_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.nems_c
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.nems_c
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_nems_imc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_nems_imc AS
 SELECT count(n.falnr) AS quantity,
    n.nems_imc
   FROM kis.nfal n
  GROUP BY n.nems_imc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_nems_imc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_nems_imc_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.nems_imc
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.nems_imc
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_notan; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_notan AS
 SELECT count(n.falnr) AS quantity,
    n.notan
   FROM kis.nfal n
  GROUP BY n.notan
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_notan_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_notan_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.notan
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.notan
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_null_values; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_null_values AS
 SELECT count(n.falnr) AS quantity,
    'einri'::text AS columns
   FROM kis.nfal n
  WHERE ((n.einri IS NULL) OR ((n.einri)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'falnr'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.falnr IS NULL) OR ((nfal.falnr)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'falar'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.falar IS NULL) OR ((nfal.falar)::text !~ '^\d'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'patnr'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.patnr IS NULL) OR ((nfal.patnr)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'bekat'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.bekat IS NULL) OR ((nfal.bekat)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'abrkz'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.abrkz IS NULL) OR ((nfal.abrkz)::text !~ '^\d'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'sichv'::text AS columns
   FROM kis.nfal
  WHERE (nfal.sichv IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'statu'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.statu IS NULL) OR ((nfal.statu)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'notan'::text AS columns
   FROM kis.nfal
  WHERE (nfal.notan IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'krzan'::text AS columns
   FROM kis.nfal
  WHERE (nfal.krzan IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'endat'::text AS columns
   FROM kis.nfal
  WHERE (nfal.endat IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'fgtyp'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.fgtyp IS NULL) OR ((nfal.fgtyp)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'kzkom'::text AS columns
   FROM kis.nfal
  WHERE (nfal.kzkom IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'enddt'::text AS columns
   FROM kis.nfal
  WHERE (nfal.enddt IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'erdat'::text AS columns
   FROM kis.nfal
  WHERE (nfal.erdat IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'updat'::text AS columns
   FROM kis.nfal
  WHERE (nfal.updat IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'storn'::text AS columns
   FROM kis.nfal
  WHERE (nfal.storn IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'stdat'::text AS columns
   FROM kis.nfal
  WHERE (nfal.stdat IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'begdt'::text AS columns
   FROM kis.nfal
  WHERE (nfal.begdt IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'fatyp'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.fatyp IS NULL) OR ((nfal.fatyp)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'fachr'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.fachr IS NULL) OR ((nfal.fachr)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'endtyp'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.endtyp IS NULL) OR ((nfal.endtyp)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'patw'::text AS columns
   FROM kis.nfal
  WHERE (nfal.patw IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'patgew'::text AS columns
   FROM kis.nfal
  WHERE (nfal.patgew IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'gwein'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.gwein IS NULL) OR ((nfal.gwein)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'patgro'::text AS columns
   FROM kis.nfal
  WHERE (nfal.patgro IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'grein'::text AS columns
   FROM kis.nfal
  WHERE ((nfal.grein IS NULL) OR ((nfal.grein)::text !~ '^\w'::text))
UNION
 SELECT count(nfal.falnr) AS quantity,
    'resp'::text AS columns
   FROM kis.nfal
  WHERE (nfal.resp IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'delgw'::text AS columns
   FROM kis.nfal
  WHERE (nfal.delgw IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'saps_c'::text AS columns
   FROM kis.nfal
  WHERE (nfal.saps_c IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'pim2_c'::text AS columns
   FROM kis.nfal
  WHERE (nfal.pim2_c IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'crib_c'::text AS columns
   FROM kis.nfal
  WHERE (nfal.crib_c IS NULL)
UNION
 SELECT count(n.falnr) AS quantity,
    'saps_imc'::text AS columns
   FROM kis.nfal n
  WHERE (n.saps_imc IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'pim2_imc'::text AS columns
   FROM kis.nfal
  WHERE (nfal.pim2_imc IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'crib_imc'::text AS columns
   FROM kis.nfal
  WHERE (nfal.crib_imc IS NULL)
UNION
 SELECT count(nfal.falnr) AS quantity,
    'respi_imc'::text AS columns
   FROM kis.nfal
  WHERE (nfal.respi_imc IS NULL)
UNION
 SELECT count(n.falnr) AS quantity,
    'readm'::text AS columns
   FROM kis.nfal n
  WHERE (n.readm IS NULL)
  ORDER BY 1, 2;


--
-- Name: dqa_nfal_patgew; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patgew AS
 SELECT count(n.falnr) AS quantity,
    n.patgew
   FROM kis.nfal n
  GROUP BY n.patgew
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patgew_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patgew_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.patgew
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.patgew
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patgro; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patgro AS
 SELECT count(n.falnr) AS quantity,
    n.patgro
   FROM kis.nfal n
  GROUP BY n.patgro
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patgro_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patgro_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.patgro
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.patgro
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patnr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patnr AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.patnr)::text ~ '^\w'::text) THEN n.patnr
            ELSE NULL::character varying
        END AS patnr
   FROM kis.nfal n
  GROUP BY n.patnr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patnr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patnr_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.patnr)::text ~ '^\w'::text) THEN n.patnr
            ELSE NULL::character varying
        END AS patnr
   FROM kis.nfal n
  GROUP BY n.patnr,
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patw; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patw AS
 SELECT count(n.falnr) AS quantity,
    n.patw
   FROM kis.nfal n
  GROUP BY n.patw
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_patw_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_patw_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.patw
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.patw
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_pim2_c; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_pim2_c AS
 SELECT count(n.falnr) AS quantity,
    n.pim2_c
   FROM kis.nfal n
  GROUP BY n.pim2_c
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_pim2_c_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_pim2_c_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.pim2_c
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.pim2_c
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_pim2_imc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_pim2_imc AS
 SELECT count(n.falnr) AS quantity,
    n.pim2_imc
   FROM kis.nfal n
  GROUP BY n.pim2_imc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_pim2_imc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_pim2_imc_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.pim2_imc
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.pim2_imc
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_readm; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_readm AS
 SELECT count(n.falnr) AS quantity,
    n.readm
   FROM kis.nfal n
  GROUP BY n.readm
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_readm_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_readm_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.readm
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.readm
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_resp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_resp AS
 SELECT count(n.falnr) AS quantity,
    n.resp
   FROM kis.nfal n
  GROUP BY n.resp
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_resp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_resp_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.resp
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.resp
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_respi_imc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_respi_imc AS
 SELECT count(n.falnr) AS quantity,
    n.respi_imc
   FROM kis.nfal n
  GROUP BY n.respi_imc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_respi_imc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_respi_imc_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.respi_imc
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.respi_imc
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_saps_c; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_saps_c AS
 SELECT count(n.falnr) AS quantity,
    n.saps_c
   FROM kis.nfal n
  GROUP BY n.saps_c
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_saps_c_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_saps_c_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.saps_c
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.saps_c
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_saps_imc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_saps_imc AS
 SELECT count(n.falnr) AS quantity,
    n.saps_imc
   FROM kis.nfal n
  GROUP BY n.saps_imc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_saps_imc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_saps_imc_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.saps_imc
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.saps_imc
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_sichv; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_sichv AS
 SELECT count(n.falnr) AS quantity,
    n.sichv
   FROM kis.nfal n
  GROUP BY n.sichv
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_sichv_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_sichv_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.sichv
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.sichv
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_statu; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_statu AS
 SELECT count(n.falnr) AS quantity,
        CASE
            WHEN ((n.statu)::text ~ '^\w'::text) THEN n.statu
            ELSE NULL::character varying
        END AS statu
   FROM kis.nfal n
  GROUP BY n.statu
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_statu_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_statu_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
        CASE
            WHEN ((n.statu)::text ~ '^\w'::text) THEN n.statu
            ELSE NULL::character varying
        END AS statu
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.statu
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_stdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_stdat AS
 SELECT count(n.falnr) AS quantity,
    n.stdat
   FROM kis.nfal n
  GROUP BY n.stdat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_stdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_stdat_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.stdat
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.stdat
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_storn; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_storn AS
 SELECT count(n.falnr) AS quantity,
    n.storn
   FROM kis.nfal n
  GROUP BY n.storn
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_storn_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_storn_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.storn
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.storn
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_updat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_updat AS
 SELECT count(n.falnr) AS quantity,
    n.updat
   FROM kis.nfal n
  GROUP BY n.updat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nfal_updat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nfal_updat_jahr AS
 SELECT
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END AS jahr,
    count(n.falnr) AS quantity,
    n.updat
   FROM kis.nfal n
  GROUP BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, n.updat
  ORDER BY
        CASE
            WHEN (n.erdat IS NULL) THEN date_part('year'::text, n.updat)
            ELSE date_part('year'::text, n.erdat)
        END, (count(n.falnr)) DESC;


--
-- Name: nicp; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.nicp (
    einri character varying(4) NOT NULL,
    falnr character varying NOT NULL,
    lnric character varying(10) NOT NULL,
    lfdbew integer,
    icpmk character varying(2),
    icpml character varying(10),
    icphc boolean,
    anzop smallint,
    bgdop date,
    bztop time without time zone,
    eztop time without time zone,
    lslok character varying(2),
    opart character varying(2),
    updat date,
    storn boolean,
    stdat date,
    drg_category character varying(1),
    drg_relevant boolean,
    orgfa character varying(8),
    orgpf character varying(8),
    endop date,
    prtyp character varying(2),
    quantity numeric(20,8),
    unit character varying(3),
    ccl character varying(3),
    oplebspen boolean,
    retrievaldate timestamp without time zone,
    lnric_ref character varying(11)
);


--
-- Name: dqa_nicp_anzop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_anzop AS
 SELECT count(n.falnr) AS quantities,
    n.anzop
   FROM kis.nicp n
  GROUP BY n.anzop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_anzop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_anzop_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.anzop
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.anzop
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_bgdop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_bgdop AS
 SELECT count(n.falnr) AS quantities,
    n.bgdop
   FROM kis.nicp n
  GROUP BY n.bgdop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_bgdop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_bgdop_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.bgdop
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.bgdop
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_bztop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_bztop AS
 SELECT count(n.falnr) AS quantities,
    n.bztop
   FROM kis.nicp n
  GROUP BY n.bztop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_bztop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_bztop_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.bztop
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.bztop
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_ccl; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_ccl AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.ccl)::text ~ '^\w'::text) THEN n.ccl
            ELSE NULL::character varying
        END AS ccl,
    cl.complication_level
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.complication_level cl ON (((cl.sourceid)::text = (n.ccl)::text)))
  GROUP BY n.ccl, cl.complication_level
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_ccl_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_ccl_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.ccl)::text ~ '^\w'::text) THEN n.ccl
            ELSE NULL::character varying
        END AS ccl,
    cl.complication_level
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.complication_level cl ON (((cl.sourceid)::text = (n.ccl)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.ccl, cl.complication_level
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_drg_category; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_drg_category AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN n.drg_category
            ELSE NULL::character varying
        END AS drg_category,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN dp.drg_prozedur
            ELSE 'keine DRG-Prozedur'::character varying
        END AS drg_prozedur
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.drg_prozedur dp ON (((dp.sourceid)::text = (n.drg_category)::text)))
  GROUP BY n.drg_category, dp.drg_prozedur
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_drg_category_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_drg_category_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN n.drg_category
            ELSE NULL::character varying
        END AS drg_category,
        CASE
            WHEN ((n.drg_category)::text ~ '^\w'::text) THEN dp.drg_prozedur
            ELSE 'keine DRG-Prozedur'::character varying
        END AS drg_prozedur
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.drg_prozedur dp ON (((dp.sourceid)::text = (n.drg_category)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.drg_category, dp.drg_prozedur
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_drg_relevant; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_drg_relevant AS
 SELECT count(n.falnr) AS quantities,
    n.drg_relevant
   FROM kis.nicp n
  GROUP BY n.drg_relevant
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_drg_relevant_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_drg_relevant_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.drg_relevant
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.drg_relevant
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_einri; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_einri AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM kis.nicp n
  GROUP BY n.einri
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_einri_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.einri
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_endop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_endop AS
 SELECT count(n.falnr) AS quantities,
    n.endop
   FROM kis.nicp n
  GROUP BY n.endop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_endop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_endop_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.endop
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.endop
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_eztop; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_eztop AS
 SELECT count(n.falnr) AS quantities,
    n.eztop
   FROM kis.nicp n
  GROUP BY n.eztop
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_eztop_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_eztop_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.eztop
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.eztop
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_falnr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_falnr AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.falnr)::text ~ '^\w'::text) THEN n.falnr
            ELSE NULL::character varying
        END AS falnr
   FROM kis.nicp n
  GROUP BY n.falnr
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_falnr_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_falnr_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.falnr)::text ~ '^\w'::text) THEN n.falnr
            ELSE NULL::character varying
        END AS falnr
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.falnr
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icphc; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icphc AS
 SELECT count(n.falnr) AS quantities,
    n.icphc
   FROM kis.nicp n
  GROUP BY n.icphc
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icphc_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icphc_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.icphc
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.icphc
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icpmk; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icpmk AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.icpmk)::text ~ '^\w'::text) THEN n.icpmk
            ELSE NULL::character varying
        END AS icpmk,
    ok.operation_katalog
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.operation_katalog ok ON (((ok.sourceid)::text = (n.icpmk)::text)))
  GROUP BY n.icpmk, ok.operation_katalog
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icpmk_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icpmk_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.icpmk)::text ~ '^\w'::text) THEN n.icpmk
            ELSE NULL::character varying
        END AS icpmk,
    ok.operation_katalog
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.operation_katalog ok ON (((ok.sourceid)::text = (n.icpmk)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.icpmk, ok.operation_katalog
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icpml; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icpml AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.icpml)::text ~ '^\w'::text) THEN n.icpml
            ELSE NULL::character varying
        END AS icpml,
    o.titel
   FROM (kis.nicp n
     LEFT JOIN ops_metainfo.ops o ON ((upper((o.kode)::text) = upper((n.icpml)::text))))
  GROUP BY n.icpml, o.titel
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_icpml_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_icpml_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.icpml)::text ~ '^\w'::text) THEN n.icpml
            ELSE NULL::character varying
        END AS icpml,
    o.titel
   FROM (kis.nicp n
     LEFT JOIN ops_metainfo.ops o ON ((upper((o.kode)::text) = upper((n.icpml)::text))))
  GROUP BY (date_part('year'::text, n.updat)), n.icpml, o.titel
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lfdbew; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lfdbew AS
 SELECT count(n.falnr) AS quantities,
    n.lfdbew
   FROM kis.nicp n
  GROUP BY n.lfdbew
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lfdbew_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lfdbew_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.lfdbew
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.lfdbew
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lnric; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lnric AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.lnric)::text ~ '^\w'::text) THEN n.lnric
            ELSE NULL::character varying
        END AS lnric
   FROM kis.nicp n
  GROUP BY n.lnric
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lnric_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lnric_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.lnric)::text ~ '^\w'::text) THEN n.lnric
            ELSE NULL::character varying
        END AS lnric
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.lnric
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lslok; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lslok AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.lslok)::text ~ '^\w'::text) THEN n.lslok
            ELSE NULL::character varying
        END AS lslok,
    bl.localisation
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.body_localisation bl ON (((n.lslok)::text = (bl.sourceid)::text)))
  GROUP BY n.lslok, bl.localisation
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_lslok_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_lslok_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.lslok)::text ~ '^\w'::text) THEN n.lslok
            ELSE NULL::character varying
        END AS lslok,
    bl.localisation
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.body_localisation bl ON (((bl.sourceid)::text = (n.lslok)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.lslok, bl.localisation
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_null_values; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_null_values AS
 SELECT count(n.falnr) AS quantities,
    'einri'::text AS columns
   FROM kis.nicp n
  WHERE ((n.einri IS NULL) OR ((n.einri)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'falnr'::text AS columns
   FROM kis.nicp n
  WHERE ((n.falnr IS NULL) OR ((n.falnr)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'lnric'::text AS columns
   FROM kis.nicp n
  WHERE ((n.lnric IS NULL) OR ((n.lnric)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'lfdbew'::text AS columns
   FROM kis.nicp n
  WHERE (n.lfdbew IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'icpmk'::text AS columns
   FROM kis.nicp n
  WHERE ((n.icpmk IS NULL) OR ((n.icpmk)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'icpml'::text AS columns
   FROM kis.nicp n
  WHERE ((n.icpml IS NULL) OR ((n.icpml)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'icphc'::text AS columns
   FROM kis.nicp n
  WHERE (n.icphc IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'anzop'::text AS columns
   FROM kis.nicp n
  WHERE (n.anzop IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'bgdop'::text AS columns
   FROM kis.nicp n
  WHERE (n.bgdop IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'bztop'::text AS columns
   FROM kis.nicp n
  WHERE (n.bztop IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'eztop'::text AS columns
   FROM kis.nicp n
  WHERE (n.eztop IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'lslok'::text AS columns
   FROM kis.nicp n
  WHERE ((n.lslok IS NULL) OR ((n.lslok)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'opart'::text AS columns
   FROM kis.nicp n
  WHERE ((n.opart IS NULL) OR ((n.opart)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'updat'::text AS columns
   FROM kis.nicp n
  WHERE (n.updat IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'storn'::text AS columns
   FROM kis.nicp n
  WHERE (n.storn IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'stdat'::text AS columns
   FROM kis.nicp n
  WHERE (n.stdat IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'drg_category'::text AS columns
   FROM kis.nicp n
  WHERE ((n.drg_category IS NULL) OR ((n.drg_category)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'drg_relevant'::text AS columns
   FROM kis.nicp n
  WHERE (n.drg_relevant IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'orgfa'::text AS columns
   FROM kis.nicp n
  WHERE ((n.orgfa IS NULL) OR ((n.orgfa)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'orgpf'::text AS columns
   FROM kis.nicp n
  WHERE ((n.orgpf IS NULL) OR ((n.orgpf)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'endop'::text AS columns
   FROM kis.nicp n
  WHERE (n.endop IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'prtyp'::text AS columns
   FROM kis.nicp n
  WHERE ((n.prtyp IS NULL) OR ((n.prtyp)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'quantity'::text AS columns
   FROM kis.nicp n
  WHERE (n.quantity IS NULL)
UNION
 SELECT count(n.falnr) AS quantities,
    'unit'::text AS columns
   FROM kis.nicp n
  WHERE ((n.unit IS NULL) OR ((n.unit)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'ccl'::text AS columns
   FROM kis.nicp n
  WHERE ((n.ccl IS NULL) OR ((n.ccl)::text !~ '^\w'::text))
UNION
 SELECT count(n.falnr) AS quantities,
    'oplebspen'::text AS columns
   FROM kis.nicp n
  WHERE (n.oplebspen IS NULL)
  ORDER BY 1, 2;


--
-- Name: dqa_nicp_opart; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_opart AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.opart)::text ~ '^\w'::text) THEN n.opart
            ELSE NULL::character varying
        END AS opart
   FROM kis.nicp n
  GROUP BY n.opart
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_opart_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_opart_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.opart)::text ~ '^\w'::text) THEN n.opart
            ELSE NULL::character varying
        END AS opart
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.opart
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_oplebspen; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_oplebspen AS
 SELECT count(n.falnr) AS quantities,
    n.oplebspen
   FROM kis.nicp n
  GROUP BY n.oplebspen
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_oplebspen_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_oplebspen_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.oplebspen
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.oplebspen
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_orgfa; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_orgfa AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.orgfa)::text ~ '^\w'::text) THEN n.orgfa
            ELSE NULL::character varying
        END AS orgfa,
    ng.orgna
   FROM (kis.nicp n
     LEFT JOIN kis.norg ng ON (((n.orgfa)::text = (ng.orgid)::text)))
  GROUP BY n.orgfa, ng.orgna
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_orgfa_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_orgfa_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.orgfa)::text ~ '^\w'::text) THEN n.orgfa
            ELSE NULL::character varying
        END AS orgfa,
    ng.orgna
   FROM (kis.nicp n
     LEFT JOIN kis.norg ng ON (((ng.orgid)::text = (n.orgfa)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.orgfa, ng.orgna
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_orgpf; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_orgpf AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.orgpf)::text ~ '^\w'::text) THEN n.orgpf
            ELSE NULL::character varying
        END AS orgpf,
    ng.orgna
   FROM (kis.nicp n
     LEFT JOIN kis.norg ng ON (((ng.orgid)::text = (n.orgpf)::text)))
  GROUP BY n.orgpf, ng.orgna
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_orgpf_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_orgpf_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.orgpf)::text ~ '^\w'::text) THEN n.orgpf
            ELSE NULL::character varying
        END AS orgpf,
    ng.orgna
   FROM (kis.nicp n
     LEFT JOIN kis.norg ng ON (((ng.orgid)::text = (n.orgpf)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.orgpf, ng.orgna
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_prtyp; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_prtyp AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.prtyp)::text ~ '^\w'::text) THEN n.prtyp
            ELSE NULL::character varying
        END AS prtyp,
    pt.prozedur_typ
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.prozedur_typ pt ON (((pt.sourceid)::text = (n.prtyp)::text)))
  GROUP BY n.prtyp, pt.prozedur_typ
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_prtyp_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_prtyp_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.prtyp)::text ~ '^\w'::text) THEN n.prtyp
            ELSE NULL::character varying
        END AS prtyp,
    pt.prozedur_typ
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.prozedur_typ pt ON (((pt.sourceid)::text = (n.prtyp)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.prtyp, pt.prozedur_typ
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_quantity; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_quantity AS
 SELECT count(n.falnr) AS quantities,
    n.quantity
   FROM kis.nicp n
  GROUP BY n.quantity
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_quantity_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_quantity_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.quantity
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.quantity
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_stdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_stdat AS
 SELECT count(n.falnr) AS quantities,
    n.stdat
   FROM kis.nicp n
  GROUP BY n.stdat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_stdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_stdat_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.stdat
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.stdat
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_storn; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_storn AS
 SELECT count(n.falnr) AS quantities,
    n.storn
   FROM kis.nicp n
  GROUP BY n.storn
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_storn_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_storn_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.storn
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.storn
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_unit; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_unit AS
 SELECT count(n.falnr) AS quantities,
        CASE
            WHEN ((n.unit)::text ~ '^\w'::text) THEN n.unit
            ELSE NULL::character varying
        END AS unit,
    u.unitid,
    u.unitname
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.units u ON (((u.sourceid)::text = (n.unit)::text)))
  GROUP BY n.unit, u.unitid, u.unitname
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_unit_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_unit_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
        CASE
            WHEN ((n.unit)::text ~ '^\w'::text) THEN n.unit
            ELSE NULL::character varying
        END AS unit,
    u.unitid,
    u.unitname
   FROM (kis.nicp n
     LEFT JOIN metadata_repository.units u ON (((u.sourceid)::text = (n.unit)::text)))
  GROUP BY (date_part('year'::text, n.updat)), n.unit, u.unitid, u.unitname
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_updat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_updat AS
 SELECT count(n.falnr) AS quantities,
    n.updat
   FROM kis.nicp n
  GROUP BY n.updat
  ORDER BY (count(n.falnr)) DESC;


--
-- Name: dqa_nicp_updat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_nicp_updat_jahr AS
 SELECT date_part('year'::text, n.updat) AS jahr,
    count(n.falnr) AS quantities,
    n.updat
   FROM kis.nicp n
  GROUP BY (date_part('year'::text, n.updat)), n.updat
  ORDER BY (date_part('year'::text, n.updat)), (count(n.falnr)) DESC;


--
-- Name: npat; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.npat (
    einri character varying(4) NOT NULL,
    patnr character varying NOT NULL,
    gschl character(1),
    gbdat smallint,
    todkz boolean,
    toddt date,
    todzt time without time zone,
    toddb date,
    todzb time without time zone,
    todur character varying(3),
    land character(3),
    pstlz character varying,
    erdat date,
    updat date,
    storn boolean,
    stdat date,
    race character varying,
    retrievaldate timestamp without time zone,
    statu character varying(2),
    gebie character varying(10),
    rfpat character varying,
    unknown_gbdat boolean,
    sex_special character varying(2)
);


--
-- Name: dqa_npat_einri; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_einri AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.npat n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_einri_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_einri_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN ((n.einri)::text ~ '^\w'::text) THEN n.einri
            ELSE NULL::character varying
        END AS einri
   FROM (kis.npat n
     LEFT JOIN metadata_repository.einrichtung e ON (((n.einri)::text = (e.sourceid)::text)))
  GROUP BY n.einri, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_erdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_erdat AS
 SELECT count(n.patnr) AS quantity,
    n.erdat
   FROM kis.npat n
  GROUP BY n.erdat
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_erdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_erdat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.erdat
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.erdat
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_gbdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_gbdat AS
 SELECT count(n.patnr) AS quantity,
    n.gbdat
   FROM kis.npat n
  GROUP BY n.gbdat
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_gbdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_gbdat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.gbdat
   FROM kis.npat n
  GROUP BY n.gbdat, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_gschl; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_gschl AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN (n.gschl ~ '^\w'::text) THEN n.gschl
            ELSE NULL::bpchar
        END AS gschl,
    g.gender
   FROM (kis.npat n
     LEFT JOIN metadata_repository.gender g ON ((n.gschl = (g.sourceid)::bpchar)))
  GROUP BY n.gschl, g.gender
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_gschl_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_gschl_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN (n.gschl ~ '^\w'::text) THEN n.gschl
            ELSE NULL::bpchar
        END AS gschl,
    g.gender
   FROM (kis.npat n
     LEFT JOIN metadata_repository.gender g ON ((n.gschl = (g.sourceid)::bpchar)))
  GROUP BY n.gschl, g.gender, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_land; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_land AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN (n.land ~ '^\w'::text) THEN n.land
            ELSE NULL::bpchar
        END AS land,
    c.country
   FROM (kis.npat n
     LEFT JOIN metadata_repository.country c ON ((n.land = (c.sourceid)::bpchar)))
  GROUP BY n.land, c.country
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_land_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_land_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN (n.land ~ '^\w'::text) THEN n.land
            ELSE NULL::bpchar
        END AS land,
    c.country
   FROM (kis.npat n
     LEFT JOIN metadata_repository.country c ON ((n.land = (c.sourceid)::bpchar)))
  GROUP BY (date_part('year'::text, n.erdat)), n.land, c.country
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_null_values; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_null_values AS
 SELECT count(n.patnr) AS quantity,
    'einri'::text AS columns
   FROM kis.npat n
  WHERE ((n.einri IS NULL) OR ((n.einri)::text !~ '^\w'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'patnr'::text AS columns
   FROM kis.npat
  WHERE ((npat.patnr IS NULL) OR ((npat.patnr)::text !~ '^\w'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'gschl'::text AS columns
   FROM kis.npat
  WHERE ((npat.gschl IS NULL) OR (npat.gschl !~ '\d'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'gbdat'::text AS columns
   FROM kis.npat
  WHERE (npat.gbdat IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'todkz'::text AS columns
   FROM kis.npat
  WHERE (npat.todkz IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'toddt'::text AS columns
   FROM kis.npat
  WHERE (npat.toddt IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'todzt'::text AS columns
   FROM kis.npat
  WHERE (npat.todzt IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'toddb'::text AS columns
   FROM kis.npat
  WHERE (npat.toddb IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'todzb'::text AS columns
   FROM kis.npat
  WHERE (npat.todzb IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'todur'::text AS columns
   FROM kis.npat
  WHERE ((npat.todur IS NULL) OR ((npat.todur)::text !~ '^\w'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'land'::text AS columns
   FROM kis.npat
  WHERE ((npat.land IS NULL) OR (npat.land !~ '^\w'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'pstlz'::text AS columns
   FROM kis.npat
  WHERE ((npat.pstlz IS NULL) OR ((npat.pstlz)::text !~ '^\w'::text))
UNION
 SELECT count(npat.patnr) AS quantity,
    'erdat'::text AS columns
   FROM kis.npat
  WHERE (npat.erdat IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'updat'::text AS columns
   FROM kis.npat
  WHERE (npat.updat IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'storn'::text AS columns
   FROM kis.npat
  WHERE (npat.storn IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'stdat'::text AS columns
   FROM kis.npat
  WHERE (npat.stdat IS NULL)
UNION
 SELECT count(npat.patnr) AS quantity,
    'race'::text AS columns
   FROM kis.npat
  WHERE ((npat.race IS NULL) OR ((npat.race)::text !~ '^\w'::text))
  ORDER BY 1, 2;


--
-- Name: dqa_npat_pstlz; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_pstlz AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN ((n.pstlz)::text ~ '^\w'::text) THEN n.pstlz
            ELSE NULL::character varying
        END AS pstlz,
    z.land AS bundesland
   FROM (kis.npat n
     LEFT JOIN metadata_repository.zipcode z ON (((n.pstlz)::text = (z.zipcode)::text)))
  GROUP BY n.pstlz, z.land
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_pstlz_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_pstlz_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN ((n.pstlz)::text ~ '^\w'::text) THEN n.pstlz
            ELSE NULL::character varying
        END AS pstlz,
    z.land AS bundesland
   FROM (kis.npat n
     LEFT JOIN metadata_repository.zipcode z ON (((n.pstlz)::text = (z.zipcode)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.pstlz, z.land
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_race; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_race AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN ((n.race)::text ~ '^\w'::text) THEN n.race
            ELSE NULL::character varying
        END AS race
   FROM kis.npat n
  GROUP BY n.race
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_race_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_race_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN ((n.race)::text ~ '^\w'::text) THEN n.race
            ELSE NULL::character varying
        END AS race
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.race
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_stdat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_stdat AS
 SELECT count(n.patnr) AS quantity,
    n.stdat
   FROM kis.npat n
  GROUP BY n.stdat
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_stdat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_stdat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.stdat
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.stdat
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_storn; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_storn AS
 SELECT count(n.patnr) AS quantity,
    n.storn
   FROM kis.npat n
  GROUP BY n.storn
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_storn_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_storn_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.storn
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.storn
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_toddb; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_toddb AS
 SELECT count(n.patnr) AS quantity,
    n.toddb
   FROM kis.npat n
  GROUP BY n.toddb
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_toddb_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_toddb_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.toddb
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.toddb
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_toddt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_toddt AS
 SELECT count(n.patnr) AS quantity,
    n.toddt
   FROM kis.npat n
  GROUP BY n.toddt
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_toddt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_toddt_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.toddt
   FROM kis.npat n
  GROUP BY n.toddt, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todkz; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todkz AS
 SELECT count(n.patnr) AS quantity,
    n.todkz
   FROM kis.npat n
  GROUP BY n.todkz
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todkz_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todkz_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.todkz
   FROM kis.npat n
  GROUP BY n.todkz, (date_part('year'::text, n.erdat))
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todur; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todur AS
 SELECT count(n.patnr) AS quantity,
        CASE
            WHEN ((n.todur)::text ~ '^\w'::text) THEN n.todur
            ELSE NULL::character varying
        END AS todur,
    d.todesursache AS deathcause
   FROM (kis.npat n
     LEFT JOIN metadata_repository.todesursache d ON (((n.todur)::text = (d.sourceid)::text)))
  GROUP BY n.todur, d.todesursache
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todur_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todur_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
        CASE
            WHEN ((n.todur)::text ~ '^\w'::text) THEN n.todur
            ELSE NULL::character varying
        END AS todur,
    d.todesursache AS deathcause
   FROM (kis.npat n
     LEFT JOIN metadata_repository.todesursache d ON (((n.todur)::text = (d.sourceid)::text)))
  GROUP BY (date_part('year'::text, n.erdat)), n.todur, d.todesursache
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todzb; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todzb AS
 SELECT count(n.patnr) AS quantity,
    n.todzb
   FROM kis.npat n
  GROUP BY n.todzb
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todzb_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todzb_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.todzb
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.todzb
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todzt; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todzt AS
 SELECT count(n.patnr) AS quantity,
    n.todzt
   FROM kis.npat n
  GROUP BY n.todzt
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_todzt_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_todzt_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.todzt
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.todzt
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: dqa_npat_updat; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_updat AS
 SELECT count(n.patnr) AS quantity,
    n.updat
   FROM kis.npat n
  GROUP BY n.updat
  ORDER BY (count(n.patnr)) DESC;


--
-- Name: dqa_npat_updat_jahr; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.dqa_npat_updat_jahr AS
 SELECT date_part('year'::text, n.erdat) AS jahr,
    count(n.patnr) AS quantity,
    n.updat
   FROM kis.npat n
  GROUP BY (date_part('year'::text, n.erdat)), n.updat
  ORDER BY (date_part('year'::text, n.erdat)), (count(n.patnr)) DESC;


--
-- Name: npat_dqa; Type: VIEW; Schema: kis; Owner: -
--

CREATE VIEW kis.npat_dqa AS
 SELECT 'einri'::text AS problem,
    (('Wert: '::text || (np.einri)::text) || '- Ungültige Angabe'::text) AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM (kis.npat np
     LEFT JOIN kis.norg nor ON (((np.einri)::text = (nor.einri)::text)))
  WHERE (nor.einri IS NULL)
UNION
 SELECT 'patnr'::text AS problem,
    (('Wert: '::text || (np.patnr)::text) || ' - Ungültige Angabe'::text) AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM kis.npat np
  WHERE ((np.patnr)::text !~ 'P(\-)*\d{10}'::text)
UNION
 SELECT 'gschl'::text AS problem,
    (('Wert: '::text || (np.gschl)::text) || ' - Ungülige Angabe'::text) AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM (kis.npat np
     LEFT JOIN metadata_repository.gender g ON ((np.gschl = (g.sourceid)::bpchar)))
  WHERE ((g.sourceid IS NULL) AND (np.gschl !~~ '^\d'::text))
UNION
 SELECT 'gbdat'::text AS problem,
    (('Wert: '::text || np.gbdat) || ' - Ungültige Angabe'::text) AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM kis.npat np
  WHERE ((np.gbdat < 1900) AND ((np.gbdat)::double precision > date_part('year'::text, now())))
UNION
 SELECT 'todkz'::text AS problem,
    (('Wert: '::text || np.todkz) || ' - Überprüfen Sie die Spalten toddt'::text) AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM kis.npat np
  WHERE ((np.toddt IS NULL) AND np.todkz)
UNION
 SELECT 'toddt'::text AS problem,
    'Überprüfen Sie zusätzlich die Spalten toddb und todkz'::text AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM kis.npat np
  WHERE ((np.toddt > np.toddb) OR (np.toddt > (now())::date))
UNION
 SELECT 'toddb'::text AS problem,
    'Überprüfen Sie zusätzlich die Spalten toddt und todkz'::text AS problem_beschreibung,
    np.einri,
    np.patnr,
    np.gschl,
    np.gbdat,
    np.todkz,
    np.toddt,
    np.todzt,
    np.toddb,
    np.todzb,
    np.todur,
    np.land,
    np.pstlz,
    np.erdat,
    np.updat,
    np.storn,
    np.stdat,
    np.race,
    np.retrievaldate
   FROM kis.npat np
  WHERE ((np.toddt > np.toddb) OR (np.toddb > (now())::date))
UNION
 SELECT 'todur'::text AS problem,
    (('Wert: '::text || (n.todur)::text) || ' - Ungültige Angabe'::text) AS problem_beschreibung,
    n.einri,
    n.patnr,
    n.gschl,
    n.gbdat,
    n.todkz,
    n.toddt,
    n.todzt,
    n.toddb,
    n.todzb,
    n.todur,
    n.land,
    n.pstlz,
    n.erdat,
    n.updat,
    n.storn,
    n.stdat,
    n.race,
    n.retrievaldate
   FROM (kis.npat n
     LEFT JOIN metadata_repository.todesursache d ON (((d.sourceid)::text = (n.todur)::text)))
  WHERE ((d.sourceid IS NULL) AND ((n.todur)::text !~~ ''::text))
UNION
 SELECT 'land'::text AS problem,
    (('Wert: '::text || (n.land)::text) || ' - Ungültige Angabe'::text) AS problem_beschreibung,
    n.einri,
    n.patnr,
    n.gschl,
    n.gbdat,
    n.todkz,
    n.toddt,
    n.todzt,
    n.toddb,
    n.todzb,
    n.todur,
    n.land,
    n.pstlz,
    n.erdat,
    n.updat,
    n.storn,
    n.stdat,
    n.race,
    n.retrievaldate
   FROM (kis.npat n
     LEFT JOIN metadata_repository.country c ON (((c.sourceid)::bpchar = n.land)))
  WHERE ((c.sourceid IS NULL) AND (n.land IS NOT NULL) AND (n.land !~ '\s+'::text) AND (n.land !~~ ''::text))
UNION
 SELECT 'pstlz'::text AS problem,
    (('Wert: '::text || (npat.pstlz)::text) || ' - Ungültige Angabe'::text) AS problem_beschreibung,
    npat.einri,
    npat.patnr,
    npat.gschl,
    npat.gbdat,
    npat.todkz,
    npat.toddt,
    npat.todzt,
    npat.toddb,
    npat.todzb,
    npat.todur,
    npat.land,
    npat.pstlz,
    npat.erdat,
    npat.updat,
    npat.storn,
    npat.stdat,
    npat.race,
    npat.retrievaldate
   FROM kis.npat
  WHERE (((npat.pstlz)::text !~ '\d+'::text) AND ((npat.pstlz)::text !~~ ''::text))
UNION
 SELECT 'erdat'::text AS problem,
    (('Wert: '::text || npat.erdat) || ' - Ungültige Angabe, Überprüfen Sie die Spalten toddt, gbdat oder das Datum von heute'::text) AS problem_beschreibung,
    npat.einri,
    npat.patnr,
    npat.gschl,
    npat.gbdat,
    npat.todkz,
    npat.toddt,
    npat.todzt,
    npat.toddb,
    npat.todzb,
    npat.todur,
    npat.land,
    npat.pstlz,
    npat.erdat,
    npat.updat,
    npat.storn,
    npat.stdat,
    npat.race,
    npat.retrievaldate
   FROM kis.npat
  WHERE ((npat.erdat > (now())::date) OR (date_part('year'::text, npat.erdat) < (npat.gbdat)::double precision) OR (npat.erdat > npat.toddt))
UNION
 SELECT 'updat'::text AS problem,
    (('Wert: '::text || npat.updat) || ' - Ungültige Angabe, Überprüfen Sie die Spalte erdat'::text) AS problem_beschreibung,
    npat.einri,
    npat.patnr,
    npat.gschl,
    npat.gbdat,
    npat.todkz,
    npat.toddt,
    npat.todzt,
    npat.toddb,
    npat.todzb,
    npat.todur,
    npat.land,
    npat.pstlz,
    npat.erdat,
    npat.updat,
    npat.storn,
    npat.stdat,
    npat.race,
    npat.retrievaldate
   FROM kis.npat
  WHERE ((npat.updat > (now())::date) OR (date_part('year'::text, npat.updat) < (npat.gbdat)::double precision) OR (npat.updat < npat.erdat))
UNION
 SELECT 'storn'::text AS problem,
    (('Wert:'::text || npat.storn) || ' - Ungültige Angabe, Überprüfens Sie die Spalte stdat'::text) AS problem_beschreibung,
    npat.einri,
    npat.patnr,
    npat.gschl,
    npat.gbdat,
    npat.todkz,
    npat.toddt,
    npat.todzt,
    npat.toddb,
    npat.todzb,
    npat.todur,
    npat.land,
    npat.pstlz,
    npat.erdat,
    npat.updat,
    npat.storn,
    npat.stdat,
    npat.race,
    npat.retrievaldate
   FROM kis.npat
  WHERE (npat.storn AND (npat.stdat IS NULL))
UNION
 SELECT 'stdat'::text AS problem,
    (('Wert:'::text || npat.stdat) || ' - Ungültige Angabe, Überprüfens Sie die Spalte storn'::text) AS problem_beschreibung,
    npat.einri,
    npat.patnr,
    npat.gschl,
    npat.gbdat,
    npat.todkz,
    npat.toddt,
    npat.todzt,
    npat.toddb,
    npat.todzb,
    npat.todur,
    npat.land,
    npat.pstlz,
    npat.erdat,
    npat.updat,
    npat.storn,
    npat.stdat,
    npat.race,
    npat.retrievaldate
   FROM kis.npat
  WHERE ((npat.stdat IS NOT NULL) AND (NOT npat.storn));


--
-- Name: nper; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.nper (
    pernr character varying(11) NOT NULL,
    makz boolean,
    arzt boolean,
    pfleg boolean,
    barzt boolean,
    begdt date,
    enddt date,
    loekz boolean,
    lodat date,
    erdat date,
    updat date,
    fachr character varying(5),
    sptyp character varying(4),
    retrievaldate timestamp without time zone
);


--
-- Name: nv_period; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.nv_period (
    einri character varying(5) NOT NULL,
    patnr character varying(11) NOT NULL,
    falnr character varying NOT NULL,
    fname character varying(31) NOT NULL,
    lfdnr integer NOT NULL,
    value character varying,
    declare_date date,
    period_begdt date,
    period_enddt date,
    period_bem character varying(30),
    erdat date,
    updat date,
    storn boolean,
    stdat date,
    retrievaldate timestamp without time zone
);


--
-- Name: screencov; Type: TABLE; Schema: kis; Owner: -
--

CREATE TABLE kis.screencov (
    mand character varying NOT NULL,
    einri character varying NOT NULL,
    falnr character varying NOT NULL,
    setdate date NOT NULL,
    settime time without time zone NOT NULL,
    screenoption character varying NOT NULL,
    disscreendllentry character varying,
    disscreenresult character varying,
    screentesttype character varying,
    screenstate character varying,
    screeniso character varying,
    screenisostate character varying,
    screenothers character varying,
    screenvaccstat character varying,
    screenvaccine character varying,
    screenvaccdose numeric,
    insdat date,
    instim time without time zone,
    patnr character varying,
    riskpat boolean,
    storn boolean,
    stdat date,
    sttim time without time zone,
    lfdbew integer,
    retrievaldate timestamp without time zone NOT NULL
);


--
-- Name: norg norg_pkey; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.norg
    ADD CONSTRAINT norg_pkey PRIMARY KEY (einri, orgid);


--
-- Name: nper nper_pkey; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.nper
    ADD CONSTRAINT nper_pkey PRIMARY KEY (pernr);


--
-- Name: nv_period nv_period_pkey; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.nv_period
    ADD CONSTRAINT nv_period_pkey PRIMARY KEY (einri, patnr, fname, lfdnr);


--
-- Name: nfal pk_einri_falnr; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.nfal
    ADD CONSTRAINT pk_einri_falnr PRIMARY KEY (einri, falnr);


--
-- Name: nbew pk_einri_falnr_lfdbew; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.nbew
    ADD CONSTRAINT pk_einri_falnr_lfdbew PRIMARY KEY (einri, falnr, lfdbew);


--
-- Name: ndia pk_einri_falnr_lfdnr; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.ndia
    ADD CONSTRAINT pk_einri_falnr_lfdnr PRIMARY KEY (einri, falnr, lfdnr);


--
-- Name: nicp pk_einri_falnr_lnric; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.nicp
    ADD CONSTRAINT pk_einri_falnr_lnric PRIMARY KEY (einri, falnr, lnric);


--
-- Name: npat pk_einri_patnr; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.npat
    ADD CONSTRAINT pk_einri_patnr PRIMARY KEY (einri, patnr);


--
-- Name: screencov screencov_pkey; Type: CONSTRAINT; Schema: kis; Owner: -
--

ALTER TABLE ONLY kis.screencov
    ADD CONSTRAINT screencov_pkey PRIMARY KEY (mand, einri, falnr, setdate, settime, screenoption);


--
-- PostgreSQL database dump complete
--

