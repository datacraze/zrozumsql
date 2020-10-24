--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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

ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_id_user_fkey;
ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_id_trans_type_fkey;
ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_id_trans_subcat_fkey;
ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_id_trans_cat_fkey;
ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_id_trans_ba_fkey;
ALTER TABLE ONLY expense_tracker.transaction_subcategory DROP CONSTRAINT transaction_subcategory_id_trans_cat_fkey;
ALTER TABLE ONLY expense_tracker.transaction_bank_accounts DROP CONSTRAINT transaction_bank_accounts_id_ba_typ_fkey;
ALTER TABLE ONLY expense_tracker.transaction_bank_accounts DROP CONSTRAINT transaction_bank_accounts_id_ba_own_fkey;
ALTER TABLE ONLY expense_tracker.bank_account_types DROP CONSTRAINT bank_account_types_id_ba_own_fkey;
ALTER TABLE ONLY expense_tracker.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY expense_tracker.transactions DROP CONSTRAINT transactions_pkey;
ALTER TABLE ONLY expense_tracker.transaction_type DROP CONSTRAINT transaction_type_pkey;
ALTER TABLE ONLY expense_tracker.transaction_subcategory DROP CONSTRAINT transaction_subcategory_pkey;
ALTER TABLE ONLY expense_tracker.transaction_category DROP CONSTRAINT transaction_category_pkey;
ALTER TABLE ONLY expense_tracker.transaction_bank_accounts DROP CONSTRAINT transaction_bank_accounts_pkey;
ALTER TABLE ONLY expense_tracker.bank_account_types DROP CONSTRAINT bank_account_types_pkey;
ALTER TABLE ONLY expense_tracker.bank_account_owner DROP CONSTRAINT bank_account_owner_pkey;
ALTER TABLE expense_tracker.users ALTER COLUMN id_user DROP DEFAULT;
ALTER TABLE expense_tracker.transactions ALTER COLUMN id_transaction DROP DEFAULT;
ALTER TABLE expense_tracker.transaction_type ALTER COLUMN id_trans_type DROP DEFAULT;
ALTER TABLE expense_tracker.transaction_subcategory ALTER COLUMN id_trans_subcat DROP DEFAULT;
ALTER TABLE expense_tracker.transaction_category ALTER COLUMN id_trans_cat DROP DEFAULT;
ALTER TABLE expense_tracker.transaction_bank_accounts ALTER COLUMN id_trans_ba DROP DEFAULT;
ALTER TABLE expense_tracker.bank_account_types ALTER COLUMN id_ba_type DROP DEFAULT;
ALTER TABLE expense_tracker.bank_account_owner ALTER COLUMN id_ba_own DROP DEFAULT;
DROP SEQUENCE expense_tracker.users_id_user_seq;
DROP TABLE expense_tracker.users;
DROP SEQUENCE expense_tracker.transactions_id_transaction_seq;
DROP TABLE expense_tracker.transactions;
DROP SEQUENCE expense_tracker.transaction_type_id_trans_type_seq;
DROP TABLE expense_tracker.transaction_type;
DROP SEQUENCE expense_tracker.transaction_subcategory_id_trans_subcat_seq;
DROP TABLE expense_tracker.transaction_subcategory;
DROP SEQUENCE expense_tracker.transaction_category_id_trans_cat_seq;
DROP TABLE expense_tracker.transaction_category;
DROP SEQUENCE expense_tracker.transaction_bank_accounts_id_trans_ba_seq;
DROP TABLE expense_tracker.transaction_bank_accounts;
DROP SEQUENCE expense_tracker.bank_account_types_id_ba_type_seq;
DROP TABLE expense_tracker.bank_account_types;
DROP SEQUENCE expense_tracker.bank_account_owner_id_ba_own_seq;
DROP TABLE expense_tracker.bank_account_owner;
DROP SCHEMA expense_tracker;
--
-- Name: expense_tracker; Type: SCHEMA; Schema: -; Owner: expense_tracker_group
--

CREATE SCHEMA expense_tracker;


ALTER SCHEMA expense_tracker OWNER TO expense_tracker_group;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank_account_owner; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.bank_account_owner (
    id_ba_own integer NOT NULL,
    owner_name character varying(50) NOT NULL,
    owner_desc character varying(250),
    user_login integer NOT NULL,
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.bank_account_owner OWNER TO expense_tracker_group;

--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.bank_account_owner_id_ba_own_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.bank_account_owner_id_ba_own_seq OWNER TO expense_tracker_group;

--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.bank_account_owner_id_ba_own_seq OWNED BY expense_tracker.bank_account_owner.id_ba_own;


--
-- Name: bank_account_types; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.bank_account_types (
    id_ba_type integer NOT NULL,
    ba_type character varying(50) NOT NULL,
    ba_desc character varying(250),
    active character(1) DEFAULT 1 NOT NULL,
    is_common_account character(1) DEFAULT 0 NOT NULL,
    id_ba_own integer,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.bank_account_types OWNER TO expense_tracker_group;

--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.bank_account_types_id_ba_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.bank_account_types_id_ba_type_seq OWNER TO expense_tracker_group;

--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.bank_account_types_id_ba_type_seq OWNED BY expense_tracker.bank_account_types.id_ba_type;


--
-- Name: transaction_bank_accounts; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.transaction_bank_accounts (
    id_trans_ba integer NOT NULL,
    id_ba_own integer,
    id_ba_typ integer,
    bank_account_name character varying(50) NOT NULL,
    bank_account_desc character varying(250),
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_bank_accounts OWNER TO expense_tracker_group;

--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.transaction_bank_accounts_id_trans_ba_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_bank_accounts_id_trans_ba_seq OWNER TO expense_tracker_group;

--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.transaction_bank_accounts_id_trans_ba_seq OWNED BY expense_tracker.transaction_bank_accounts.id_trans_ba;


--
-- Name: transaction_category; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.transaction_category (
    id_trans_cat integer NOT NULL,
    category_name character varying(50) NOT NULL,
    category_description character varying(250),
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_category OWNER TO expense_tracker_group;

--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.transaction_category_id_trans_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_category_id_trans_cat_seq OWNER TO expense_tracker_group;

--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.transaction_category_id_trans_cat_seq OWNED BY expense_tracker.transaction_category.id_trans_cat;


--
-- Name: transaction_subcategory; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.transaction_subcategory (
    id_trans_subcat integer NOT NULL,
    id_trans_cat integer,
    subcategory_name character varying(50) NOT NULL,
    subcategory_description character varying(250),
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_subcategory OWNER TO expense_tracker_group;

--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.transaction_subcategory_id_trans_subcat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_subcategory_id_trans_subcat_seq OWNER TO expense_tracker_group;

--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.transaction_subcategory_id_trans_subcat_seq OWNED BY expense_tracker.transaction_subcategory.id_trans_subcat;


--
-- Name: transaction_type; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.transaction_type (
    id_trans_type integer NOT NULL,
    transaction_type_name character varying(50) NOT NULL,
    transaction_type_desc character varying(250),
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_type OWNER TO expense_tracker_group;

--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.transaction_type_id_trans_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_type_id_trans_type_seq OWNER TO expense_tracker_group;

--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.transaction_type_id_trans_type_seq OWNED BY expense_tracker.transaction_type.id_trans_type;


--
-- Name: transactions; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.transactions (
    id_transaction integer NOT NULL,
    id_trans_ba integer,
    id_trans_cat integer,
    id_trans_subcat integer,
    id_trans_type integer,
    id_user integer,
    transaction_date date DEFAULT CURRENT_DATE,
    transaction_value numeric(9,2),
    transaction_description text,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transactions OWNER TO expense_tracker_group;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.transactions_id_transaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transactions_id_transaction_seq OWNER TO expense_tracker_group;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.transactions_id_transaction_seq OWNED BY expense_tracker.transactions.id_transaction;


--
-- Name: users; Type: TABLE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE TABLE expense_tracker.users (
    id_user integer NOT NULL,
    user_login character varying(25) NOT NULL,
    user_name character varying(50) NOT NULL,
    user_password character varying(100) NOT NULL,
    password_salt character varying(100) NOT NULL,
    active character(1) DEFAULT 1 NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.users OWNER TO expense_tracker_group;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: expense_tracker_group
--

CREATE SEQUENCE expense_tracker.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.users_id_user_seq OWNER TO expense_tracker_group;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER SEQUENCE expense_tracker.users_id_user_seq OWNED BY expense_tracker.users.id_user;


--
-- Name: bank_account_owner id_ba_own; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.bank_account_owner ALTER COLUMN id_ba_own SET DEFAULT nextval('expense_tracker.bank_account_owner_id_ba_own_seq'::regclass);


--
-- Name: bank_account_types id_ba_type; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.bank_account_types ALTER COLUMN id_ba_type SET DEFAULT nextval('expense_tracker.bank_account_types_id_ba_type_seq'::regclass);


--
-- Name: transaction_bank_accounts id_trans_ba; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts ALTER COLUMN id_trans_ba SET DEFAULT nextval('expense_tracker.transaction_bank_accounts_id_trans_ba_seq'::regclass);


--
-- Name: transaction_category id_trans_cat; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_category ALTER COLUMN id_trans_cat SET DEFAULT nextval('expense_tracker.transaction_category_id_trans_cat_seq'::regclass);


--
-- Name: transaction_subcategory id_trans_subcat; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory ALTER COLUMN id_trans_subcat SET DEFAULT nextval('expense_tracker.transaction_subcategory_id_trans_subcat_seq'::regclass);


--
-- Name: transaction_type id_trans_type; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_type ALTER COLUMN id_trans_type SET DEFAULT nextval('expense_tracker.transaction_type_id_trans_type_seq'::regclass);


--
-- Name: transactions id_transaction; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions ALTER COLUMN id_transaction SET DEFAULT nextval('expense_tracker.transactions_id_transaction_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.users ALTER COLUMN id_user SET DEFAULT nextval('expense_tracker.users_id_user_seq'::regclass);


--
-- Data for Name: bank_account_owner; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.bank_account_owner (id_ba_own, owner_name, owner_desc, user_login, active, insert_date, update_date) FROM stdin;
1	Janusz Kowalski	Pan Janusz - Głowa Rodziny	1	1	2020-10-23 20:38:35.870757	2020-10-23 20:38:35.870757
2	Grażyna Kowalska	Pani Grażyna - Szyja Rodziny	2	1	2020-10-23 20:38:35.870757	2020-10-23 20:38:35.870757
3	Janusz i Grażynka	Pan Janusz i Grażynka właściciele.	2	1	2020-10-23 20:38:35.870757	2020-10-23 20:38:35.870757
\.


--
-- Data for Name: bank_account_types; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.bank_account_types (id_ba_type, ba_type, ba_desc, active, is_common_account, id_ba_own, insert_date, update_date) FROM stdin;
-1	<unknown>	<unknown>	1	0	\N	2020-10-23 20:38:50.847268	2020-10-23 20:38:50.847268
1	ROR	Rachunek oszczędnościowo rozliczeniowy.	1	0	1	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
2	ROR	Rachunek oszczędnościowo rozliczeniowy.	1	0	2	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
3	OSZCZ	Rachunek oszczędnościowy.	1	0	1	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
4	OSZCZ	Rachunek oszczędnościowy.	1	0	2	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
5	ROR - WSPÓLNY	Rachunek oszczędnościowo rozliczeniowy wspólny.	1	1	3	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
6	OSZCZ - WSPÓLNY	Rachunek oszczędnościowy wspólny.	1	1	3	2020-10-23 20:39:03.241582	2020-10-23 20:39:03.241582
\.


--
-- Data for Name: transaction_bank_accounts; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.transaction_bank_accounts (id_trans_ba, id_ba_own, id_ba_typ, bank_account_name, bank_account_desc, active, insert_date, update_date) FROM stdin;
-1	\N	\N	<unknown>	<unknown>	1	2020-10-23 20:39:07.465157	2020-10-23 20:39:07.465157
1	1	1	ROR - Janusz	ROR Janusza.	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
2	2	2	ROR - Grażyna	ROR Grażynki	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
3	1	3	OSZCZ - Janusz	Oszczędnościowe konto Janusza.	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
4	2	4	OSZCZ - Grażyna	Oszczędnościowe konto Grażynki.	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
5	3	5	ROR - Janusz i Grażynka	ROR Janusza i Grażynki	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
6	3	6	OSZCZ - Janusz i Grażynka	Oszczędnościowe konto Janusza i Grażynki	1	2020-10-23 20:39:09.36194	2020-10-23 20:39:09.36194
\.


--
-- Data for Name: transaction_category; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.transaction_category (id_trans_cat, category_name, category_description, active, insert_date, update_date) FROM stdin;
-1	<unknown>	<unknown>	1	2020-10-23 20:39:15.967146	2020-10-23 20:39:15.967146
1	JEDZENIE	Kategoria związana z zakupami spożywczymi i jedzeniem	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
2	PRZYCHÓD	Kategoria dotycząca przychodów w budżecie.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
3	UŻYWKI	Alkohol, Papierosy.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
4	OPŁATY_RACHUNKI	Opłaty ogólne - prąd, gaz, woda itd.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
5	ZDROWIE_CHEMIA	Wszystko związane z ogólnie pojętym zdrowie i chemią domową.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
6	UBRANIE	Kategoria związana z ubiorem.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
7	RELAKS	Kategoria związana z ogólnym relaksem - wakacje, kino, teatr itp.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
8	TRANSPORT	Samochód, taxi, komunikacja publiczna.	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
9	INNE_WYDATKI	Kategoria związana z zakupami spożywczymi i jedzeniem	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
10	OSZCZĘDNOŚCI	Kategoria związana z zakupami spożywczymi i jedzeniem	1	2020-10-23 20:39:17.215229	2020-10-23 20:39:17.215229
\.


--
-- Data for Name: transaction_subcategory; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.transaction_subcategory (id_trans_subcat, id_trans_cat, subcategory_name, subcategory_description, active, insert_date, update_date) FROM stdin;
-1	\N	<unknown>	<unknown>	1	2020-10-23 20:39:20.35331	2020-10-23 20:39:20.35331
1	2	Wynagrodzenie	Wynagrodzenie	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
2	2	Wynagrodzenie	Wynagrodzenie	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
3	2	Wynagrodzenie	Wynagrodzenie	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
4	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
5	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
6	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
7	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
8	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
9	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
10	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
11	1	Junk Food	Junk Food	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
12	3	Alkohol	Alkohol	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
13	4	Czynsz	Czynsz	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
14	4	Gaz	Gaz	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
15	4	Prąd	Prąd	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
16	4	Internet i TV	Internet i TV	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
17	4	Ubezpieczenie	Ubezpieczenie	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
18	4	Telefon	Telefon	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
19	4	PIT podatek	PIT podatek	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
20	4	Żłobek/Przedszkole	Żłobek/Przedszkole	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
21	5	Kosmetyki	Kosmetyki	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
22	5	Lekarz	Lekarz	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
23	5	Apteka	Apteka	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
24	5	Szpital	Szpital	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
25	5	Fryzjer	Fryzjer	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
26	5	Chemia	Chemia	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
27	6	Zakupy ubraniowe	Zakupy ubraniowe	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
28	6	Szewc	Szewc	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
29	6	Krawiec	Krawiec	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
30	7	Wakacje	Wakacje	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
31	7	Kino	Kino	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
32	7	Teatr Opera	Teatr Opera	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
33	7	Koncert	Koncert	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
34	7	Spa	Spa	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
35	7	Fitness	Fitness	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
36	7	Książki	Książki	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
37	7	Gry	Gry	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
38	7	Basen	Basen	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
39	7	Muzeum	Muzeum	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
40	8	Parkingi	Parkingi	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
41	8	MPK	MPK	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
42	8	PKP	PKP	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
43	8	Samochód	Samochód	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
44	8	Taxi	Taxi	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
45	8	Bus	Bus	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
46	9	Inne wydatk	Inne wydatk	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
47	9	Bankomat	Bankomat	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
48	9	Prezenty	Prezenty	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
49	9	Technologie	Technologie	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
50	9	Opłaty Prowizje banku	Opłaty Prowizje banku	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
51	9	Darowizna	Darowizna	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
52	9	Rata AGD	Rata AGD	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
53	9	Przelewy Bankowe	Przelewy Bankowe	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
54	10	Oszczędności	Oszczędności	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
55	10	Odsetki	Odsetki	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
56	10	Lokata	Lokata	1	2020-10-23 20:39:57.217866	2020-10-23 20:39:57.217866
\.


--
-- Data for Name: transaction_type; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.transaction_type (id_trans_type, transaction_type_name, transaction_type_desc, active, insert_date, update_date) FROM stdin;
-1	<unknown>	<unknown>	1	2020-10-23 20:39:12.196043	2020-10-23 20:39:12.196043
1	Uznanie	Wpływ na konto.	1	2020-10-23 20:39:13.438933	2020-10-23 20:39:13.438933
2	Obciążenie	Wydatek z konta.	1	2020-10-23 20:39:13.438933	2020-10-23 20:39:13.438933
3	Wypłata własna	Przelew / wypłata własna z konta.	1	2020-10-23 20:39:13.438933	2020-10-23 20:39:13.438933
4	Wpłata własna	Przelew / wpłata własna na konto.	1	2020-10-23 20:39:13.438933	2020-10-23 20:39:13.438933
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.transactions (id_transaction, id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description, insert_date, update_date) FROM stdin;
1	1	1	-1	2	\N	2015-07-01	-13.71	21f8cef79c3df0a9c878be1570b9f3e9	2020-10-23 22:10:50.870031	2020-10-23 22:10:50.870031
2	5	1	-1	2	\N	2015-07-01	-17.69	98894c6d5b1a2ba59f7ec32cadad286c	2020-10-23 22:10:50.873708	2020-10-23 22:10:50.873708
3	5	9	47	3	\N	2015-07-01	-50.00	19f42e77c95b7a5a9a6f36d0b95f0e9f	2020-10-23 22:10:50.876025	2020-10-23 22:10:50.876025
4	5	9	-1	2	\N	2015-07-01	-5.00	08a641013301b0c0294304b3e7b2f45c	2020-10-23 22:10:50.878392	2020-10-23 22:10:50.878392
5	5	10	54	4	\N	2015-07-01	3000.00	bb61d78a978c0d7c27a5d7235be0aa69	2020-10-23 22:10:50.880547	2020-10-23 22:10:50.880547
6	6	10	54	4	\N	2015-07-02	1500.00	11ad377b5a9a9fd5491cf3acf5b37513	2020-10-23 22:10:50.882452	2020-10-23 22:10:50.882452
7	6	10	54	4	\N	2015-07-02	1000.00	49ce39db34b99ef74936ed6d37486712	2020-10-23 22:10:50.884739	2020-10-23 22:10:50.884739
8	5	4	17	2	\N	2015-07-02	-120.00	3417ed882084a60ae30cf097c9df73c7	2020-10-23 22:10:50.886464	2020-10-23 22:10:50.886464
9	5	10	54	3	\N	2015-07-02	-1500.00	11ad377b5a9a9fd5491cf3acf5b37513	2020-10-23 22:10:50.888296	2020-10-23 22:10:50.888296
10	1	1	-1	2	\N	2015-07-03	-12.00	3a840c6a9822b2037235e78928360c65	2020-10-23 22:10:50.890731	2020-10-23 22:10:50.890731
11	1	1	11	2	\N	2015-07-03	-2.00	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:10:50.893159	2020-10-23 22:10:50.893159
12	1	1	-1	2	\N	2015-07-03	-3.00	c2626d850c80ea07e7511bbae4c76f4b	2020-10-23 22:10:50.895011	2020-10-23 22:10:50.895011
13	1	1	-1	2	\N	2015-07-03	-19.00	6da37dd3139aa4d9aa55b8d237ec5d4a	2020-10-23 22:10:50.897717	2020-10-23 22:10:50.897717
14	1	1	-1	2	\N	2015-07-03	-10.00	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:10:50.900511	2020-10-23 22:10:50.900511
15	1	1	11	2	\N	2015-07-03	-17.00	912d2b1c7b2826caf99687388d2e8f7c	2020-10-23 22:10:50.902999	2020-10-23 22:10:50.902999
16	1	1	-1	2	\N	2015-07-03	-4.00	fa14d4fe2f19414de3ebd9f63d5c0169	2020-10-23 22:10:50.90503	2020-10-23 22:10:50.90503
17	1	6	28	2	\N	2015-07-03	-30.00	78ef7d03f1cb58ea4f3ba4a547cdeda7	2020-10-23 22:10:50.907493	2020-10-23 22:10:50.907493
18	5	5	22	2	\N	2015-07-03	-150.00	6aaef7dcd74846a3eed100343d4c9ff1	2020-10-23 22:10:50.91026	2020-10-23 22:10:50.91026
19	1	2	3	1	\N	2015-07-04	3784.73	37dd44b74df0300eaba7d5964d438ab4	2020-10-23 22:10:50.912924	2020-10-23 22:10:50.912924
20	1	10	54	3	\N	2015-07-04	-1276.31	31103b39ac37ed3b4cf65836ed2eee1f	2020-10-23 22:10:50.915546	2020-10-23 22:10:50.915546
21	1	10	54	3	\N	2015-07-04	-2000.00	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:10:50.918196	2020-10-23 22:10:50.918196
22	3	10	54	4	\N	2015-07-04	2000.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:10:50.920116	2020-10-23 22:10:50.920116
23	6	10	54	4	\N	2015-07-04	1276.31	7cc45b045c2c28f5f1950c68267e1c1c	2020-10-23 22:10:50.92218	2020-10-23 22:10:50.92218
24	5	1	-1	2	\N	2015-07-04	-102.90	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:50.923984	2020-10-23 22:10:50.923984
25	5	4	50	2	\N	2015-07-04	-8.00	e58c8b0cbfcbe2a2c18fbb41763bfd42	2020-10-23 22:10:50.926615	2020-10-23 22:10:50.926615
26	1	1	-1	2	\N	2015-07-05	-2.00	704a9613f075f9dafff1a0146b76558e	2020-10-23 22:10:50.929021	2020-10-23 22:10:50.929021
27	5	1	-1	2	\N	2015-07-05	-38.50	621bf66ddb7c962aa0d22ac97d69b793	2020-10-23 22:10:50.930716	2020-10-23 22:10:50.930716
28	2	6	27	2	\N	2015-07-04	-50.00	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:10:50.933315	2020-10-23 22:10:50.933315
29	2	1	-1	2	\N	2015-07-03	-5.88	596d904bfc6e33220346954b6e59f12c	2020-10-23 22:10:50.935841	2020-10-23 22:10:50.935841
30	5	1	-1	2	\N	2015-07-06	-17.23	977c37f00b723bc3ec61227ff00537aa	2020-10-23 22:10:50.938083	2020-10-23 22:10:50.938083
31	2	1	-1	2	\N	2015-07-06	-4.00	d463c87a846080c57e7cbde6a8398590	2020-10-23 22:10:50.940338	2020-10-23 22:10:50.940338
32	2	7	31	2	\N	2015-07-04	-14.00	cea1a1da958a6b3bcf93a70e3fced376	2020-10-23 22:10:50.94241	2020-10-23 22:10:50.94241
33	2	10	54	3	\N	2015-07-02	-1000.00	7545abd83865e0c1498a6b5eac76c58b	2020-10-23 22:10:50.944523	2020-10-23 22:10:50.944523
34	6	10	54	4	\N	2015-07-02	1000.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:50.946512	2020-10-23 22:10:50.946512
35	2	6	28	1	\N	2015-07-04	30.00	5f93f983524def3dca464469d2cf9f3e	2020-10-23 22:10:50.948403	2020-10-23 22:10:50.948403
36	2	7	-1	2	\N	2015-07-06	-11.50	e29ac9f673f5e41116828d7db06d7125	2020-10-23 22:10:50.950407	2020-10-23 22:10:50.950407
37	2	5	21	2	\N	2015-07-06	-7.00	7658d0d2112eb265d6496cbac9de1e24	2020-10-23 22:10:50.956746	2020-10-23 22:10:50.956746
38	1	1	-1	2	\N	2015-07-07	-150.00	75fbb4413bac1445662bc20f25d7220a	2020-10-23 22:10:50.958339	2020-10-23 22:10:50.958339
39	5	1	-1	2	\N	2015-07-07	-41.08	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:50.960172	2020-10-23 22:10:50.960172
40	2	1	-1	2	\N	2015-07-08	-12.64	847cc55b7032108eee6dd897f3bca8a5	2020-10-23 22:10:50.961771	2020-10-23 22:10:50.961771
41	5	5	23	2	\N	2015-07-08	-24.45	3916b3b51b8b4a0a97f12aa77ff25d89	2020-10-23 22:10:50.963273	2020-10-23 22:10:50.963273
42	2	5	21	2	\N	2015-07-08	-73.23	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:50.964771	2020-10-23 22:10:50.964771
43	1	1	-1	2	\N	2015-07-08	-10.52	21f8cef79c3df0a9c878be1570b9f3e9	2020-10-23 22:10:50.966233	2020-10-23 22:10:50.966233
44	5	5	22	2	\N	2015-07-09	-30.00	6a765ac3b5a3cb073b95357dc8f4fd87	2020-10-23 22:10:50.967994	2020-10-23 22:10:50.967994
45	5	1	-1	2	\N	2015-07-09	-34.34	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:50.969804	2020-10-23 22:10:50.969804
46	1	8	40	2	\N	2015-07-11	-4.00	88ff3c5e7abe5c365fc714330a475618	2020-10-23 22:10:50.972067	2020-10-23 22:10:50.972067
47	1	1	-1	2	\N	2015-07-11	-2.20	b90a692ce8297a27fba811452146779e	2020-10-23 22:10:50.974016	2020-10-23 22:10:50.974016
48	1	1	11	2	\N	2015-07-11	-1.49	119f7f00d4188a58b00db75b0be1a1af	2020-10-23 22:10:50.975727	2020-10-23 22:10:50.975727
49	1	1	-1	2	\N	2015-07-10	-7.80	1c9c9853926c530ab639481cf64c7693	2020-10-23 22:10:50.977438	2020-10-23 22:10:50.977438
50	1	1	-1	2	\N	2015-07-10	-2.80	b4d83f6860b6ffa13862443f17eb9f72	2020-10-23 22:10:50.979369	2020-10-23 22:10:50.979369
51	1	1	11	2	\N	2015-07-12	-133.00	93129a5756514c8149034bbbfb3b76d9	2020-10-23 22:10:50.982083	2020-10-23 22:10:50.982083
52	1	2	3	1	\N	2015-07-12	100.00	263a82a0c7b139fca63c8e5fb3e22638	2020-10-23 22:10:50.984188	2020-10-23 22:10:50.984188
53	1	8	40	2	\N	2015-07-14	-8.00	88ff3c5e7abe5c365fc714330a475618	2020-10-23 22:10:50.986058	2020-10-23 22:10:50.986058
54	1	8	40	2	\N	2015-07-13	-8.00	88ff3c5e7abe5c365fc714330a475618	2020-10-23 22:10:50.987361	2020-10-23 22:10:50.987361
55	1	2	54	4	\N	2015-07-12	2000.00	128fc4f48693ac191c662898b0719506	2020-10-23 22:10:50.989289	2020-10-23 22:10:50.989289
56	3	9	-1	3	\N	2015-07-12	-2000.00	0d5afc51b9ef610ea7d3570c3e0fc353	2020-10-23 22:10:50.991068	2020-10-23 22:10:50.991068
57	1	1	-1	2	\N	2015-07-14	-11.36	21f8cef79c3df0a9c878be1570b9f3e9	2020-10-23 22:10:50.992681	2020-10-23 22:10:50.992681
58	1	1	-1	2	\N	2015-07-14	-8.66	378173d43591fa50441d96443a7436d2	2020-10-23 22:10:50.994325	2020-10-23 22:10:50.994325
59	5	5	21	2	\N	2015-07-12	-39.97	8fbae680402078fc09de66a2c4956326	2020-10-23 22:10:50.996204	2020-10-23 22:10:50.996204
60	1	1	-1	2	\N	2015-07-12	-285.27	8f2f665a201e5b76e34c3321bd359740	2020-10-23 22:10:50.997962	2020-10-23 22:10:50.997962
61	1	1	-1	2	\N	2015-07-13	-14.52	2dd027223e5c8ae96e0859277d824168	2020-10-23 22:10:50.999879	2020-10-23 22:10:50.999879
62	1	1	-1	2	\N	2015-07-13	-7.97	28cb510090e7e926daa92745a8b02362	2020-10-23 22:10:51.001903	2020-10-23 22:10:51.001903
63	5	1	-1	2	\N	2015-07-13	-32.09	b13cb21e454e93ee66f2c25b192c10aa	2020-10-23 22:10:51.00391	2020-10-23 22:10:51.00391
64	1	5	23	2	\N	2015-07-14	-33.89	cdb6d75b264e745bcfe826fc8bdb43e4	2020-10-23 22:10:51.005176	2020-10-23 22:10:51.005176
65	5	5	23	2	\N	2015-07-14	-13.90	b56a18e0eacdf51aa2a5306b0f533204	2020-10-23 22:10:51.006366	2020-10-23 22:10:51.006366
66	1	5	23	1	\N	2015-07-14	13.90	b56a18e0eacdf51aa2a5306b0f533204	2020-10-23 22:10:51.007741	2020-10-23 22:10:51.007741
67	5	5	-1	2	\N	2015-07-14	-26.12	a0f6d0244be79da7040362bf43e9af46	2020-10-23 22:10:51.009137	2020-10-23 22:10:51.009137
68	5	1	-1	2	\N	2015-07-14	-12.08	00ac8ed3b4327bdd4ebbebcb2ba10a00	2020-10-23 22:10:51.01059	2020-10-23 22:10:51.01059
69	1	6	27	2	\N	2015-07-14	-39.99	75fc093c0ee742f6dddaa13fff98f104	2020-10-23 22:10:51.01219	2020-10-23 22:10:51.01219
70	5	6	27	1	\N	2015-07-14	39.99	a9a1d5317a33ae8cef33961c34144f84	2020-10-23 22:10:51.013588	2020-10-23 22:10:51.013588
71	5	1	-1	2	\N	2015-07-14	-107.25	82ac38c599dc6d201e9d16c4d6bafeb9	2020-10-23 22:10:51.014966	2020-10-23 22:10:51.014966
72	2	4	18	2	\N	2015-07-16	-58.36	6dd909835db21a2c776707daeb646070	2020-10-23 22:10:51.01644	2020-10-23 22:10:51.01644
73	2	4	18	2	\N	2015-07-16	-19.99	405c7606466ad55dbbb05ea0b70808c4	2020-10-23 22:10:51.01783	2020-10-23 22:10:51.01783
74	2	5	23	2	\N	2015-07-13	-18.99	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:10:51.019148	2020-10-23 22:10:51.019148
75	2	6	27	2	\N	2015-07-16	-41.90	ab4b3a1a1d279581ef3bcbd98d6abee4	2020-10-23 22:10:51.020457	2020-10-23 22:10:51.020457
76	5	5	22	2	\N	2015-07-16	-120.00	fbe09b0dd739626f9c8108b618adb0b4	2020-10-23 22:10:51.021804	2020-10-23 22:10:51.021804
77	5	5	23	2	\N	2015-07-18	-45.99	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:51.023113	2020-10-23 22:10:51.023113
78	5	5	21	2	\N	2015-07-18	-44.64	e0875a7d00226102ef260a579ef5e697	2020-10-23 22:10:51.024471	2020-10-23 22:10:51.024471
79	1	1	-1	2	\N	2015-07-18	-25.24	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:51.025763	2020-10-23 22:10:51.025763
80	1	2	3	4	\N	2015-07-18	79.90	d98d4448b9d05256b86f6ca464f8c01f	2020-10-23 22:10:51.027179	2020-10-23 22:10:51.027179
81	5	5	23	2	\N	2015-07-16	-35.79	fedd26149ad210cf17643a6b91f21800	2020-10-23 22:10:51.028567	2020-10-23 22:10:51.028567
82	1	8	40	2	\N	2015-07-16	-4.00	430c3626b879b4005d41b8a46172e0c0	2020-10-23 22:10:51.030299	2020-10-23 22:10:51.030299
83	1	5	23	2	\N	2015-07-17	-33.89	33a190996c7d195c4f7726293cbb44b0	2020-10-23 22:10:51.031852	2020-10-23 22:10:51.031852
84	1	5	23	2	\N	2015-07-17	-4.50	89b327b02ad20e9d93a23c30a3bfa1bf	2020-10-23 22:10:51.033774	2020-10-23 22:10:51.033774
85	5	4	50	2	\N	2015-07-13	-5.00	00d294ebc577f9126eca52ff17a454a7	2020-10-23 22:10:51.035624	2020-10-23 22:10:51.035624
86	1	1	-1	2	\N	2015-07-18	-2.89	f335e9f0e59921511c33549aee7cc1e5	2020-10-23 22:10:51.037275	2020-10-23 22:10:51.037275
87	1	4	18	2	\N	2015-07-20	-50.00	47470cd2665db5bedbaa1a75256db736	2020-10-23 22:10:51.038949	2020-10-23 22:10:51.038949
88	1	8	40	2	\N	2015-07-20	-28.10	ba55ff88bddf71220a86105441fd2fff	2020-10-23 22:10:51.040819	2020-10-23 22:10:51.040819
89	1	1	-1	2	\N	2015-07-20	-4.50	b4d83f6860b6ffa13862443f17eb9f72	2020-10-23 22:10:51.042643	2020-10-23 22:10:51.042643
90	1	1	-1	2	\N	2015-07-20	-7.50	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:51.045129	2020-10-23 22:10:51.045129
91	1	6	27	2	\N	2015-07-20	-339.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:51.046759	2020-10-23 22:10:51.046759
92	1	9	48	2	\N	2015-07-20	-79.00	9c01802ddb981e6bcfbec0f0516b8e35	2020-10-23 22:10:51.048273	2020-10-23 22:10:51.048273
93	5	9	-1	2	\N	2015-07-20	-37.76	f579c8706286fb7ce72ef94a0d14c4bf	2020-10-23 22:10:51.049869	2020-10-23 22:10:51.049869
94	5	1	-1	2	\N	2015-07-21	-11.70	6cb7f4178c6e1d7172c36632810fc851	2020-10-23 22:10:51.05179	2020-10-23 22:10:51.05179
95	1	4	18	2	\N	2015-07-21	-2.28	54668cea9e67e18308da8c89d8551d2a	2020-10-23 22:10:51.053483	2020-10-23 22:10:51.053483
96	5	1	-1	2	\N	2015-07-21	-13.96	0ff39bbbf981ac0151d340c9aa40e63e	2020-10-23 22:10:51.055101	2020-10-23 22:10:51.055101
97	5	5	23	2	\N	2015-07-23	-28.00	88f5c2843bb4d1479cc583ebf2e3beea	2020-10-23 22:10:51.056602	2020-10-23 22:10:51.056602
98	5	1	-1	2	\N	2015-07-23	-67.09	b13cb21e454e93ee66f2c25b192c10aa	2020-10-23 22:10:51.058052	2020-10-23 22:10:51.058052
99	2	5	22	1	\N	2015-07-17	211.00	942dd26dab18af7d4a73fde5adf8d6d4	2020-10-23 22:10:51.059759	2020-10-23 22:10:51.059759
100	2	5	22	2	\N	2015-07-24	-211.00	45d9e8a1f050027058ffd6e208f31caa	2020-10-23 22:10:51.06144	2020-10-23 22:10:51.06144
101	5	5	22	1	\N	2015-07-24	211.00	05f971b5ec196b8c65b75d2ef8267331	2020-10-23 22:10:51.062808	2020-10-23 22:10:51.062808
102	2	9	48	2	\N	2015-07-24	-339.00	2aa2ebeeff6c28aaebf43136f3493e18	2020-10-23 22:10:51.064407	2020-10-23 22:10:51.064407
103	1	9	48	1	\N	2015-07-24	339.00	32601f4115aae8cca6d143d9bf3bbc08	2020-10-23 22:10:51.065858	2020-10-23 22:10:51.065858
104	1	9	-1	2	\N	2015-07-24	-159.00	996a7fa078cc36c46d02f9af3bef918b	2020-10-23 22:10:51.067501	2020-10-23 22:10:51.067501
105	1	9	-1	2	\N	2015-07-24	-128.00	996a7fa078cc36c46d02f9af3bef918b	2020-10-23 22:10:51.069121	2020-10-23 22:10:51.069121
106	1	1	-1	2	\N	2015-07-24	-1.98	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:51.070723	2020-10-23 22:10:51.070723
107	5	9	48	2	\N	2015-07-27	-300.00	dc7ebb981e58df4857a69c05589d5a8d	2020-10-23 22:10:51.072554	2020-10-23 22:10:51.072554
108	5	4	50	2	\N	2015-07-27	-5.00	08a641013301b0c0294304b3e7b2f45c	2020-10-23 22:10:51.074216	2020-10-23 22:10:51.074216
109	5	5	23	2	\N	2015-07-27	-8.99	fc7020775a7cdf161ab5267985c54601	2020-10-23 22:10:51.075629	2020-10-23 22:10:51.075629
110	5	5	23	2	\N	2015-07-27	-18.90	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:10:51.077003	2020-10-23 22:10:51.077003
111	5	1	-1	2	\N	2015-07-27	-38.61	0b4fd578fa85b9d3ad197fb3a5fbf4db	2020-10-23 22:10:51.078466	2020-10-23 22:10:51.078466
112	1	1	-1	2	\N	2015-07-27	-23.45	37bc1b6433166494d611199664a8b3e1	2020-10-23 22:10:51.080152	2020-10-23 22:10:51.080152
113	1	8	43	2	\N	2015-07-27	-14.00	2c5d27255f304e869657726360fed06f	2020-10-23 22:10:51.081777	2020-10-23 22:10:51.081777
114	1	1	-1	2	\N	2015-07-27	-5.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.083868	2020-10-23 22:10:51.083868
115	5	5	22	2	\N	2015-07-28	-11.00	0c836250208fda4a94d75440cebfd991	2020-10-23 22:10:51.085576	2020-10-23 22:10:51.085576
116	5	1	-1	2	\N	2015-07-28	-27.08	ae775a2bd99e8b4b31a33486f4804fd3	2020-10-23 22:10:51.087339	2020-10-23 22:10:51.087339
117	5	4	16	2	\N	2015-07-28	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:51.088793	2020-10-23 22:10:51.088793
118	2	2	-1	1	\N	2015-07-27	40.00	99c91b979d234058c005ea53bf19594d	2020-10-23 22:10:51.090184	2020-10-23 22:10:51.090184
119	2	1	-1	2	\N	2015-07-25	-9.19	2d6cc4b2d139a53512fb8cbb3086ae2e	2020-10-23 22:10:51.091585	2020-10-23 22:10:51.091585
120	2	1	-1	2	\N	2015-07-30	-10.86	8c539ae23d4c1fd886ba1eb7a7baec92	2020-10-23 22:10:51.093268	2020-10-23 22:10:51.093268
121	1	1	11	2	\N	2015-07-31	-1.50	f29c21d4897f78948b91f03172341b7b	2020-10-23 22:10:51.0947	2020-10-23 22:10:51.0947
122	1	1	-1	2	\N	2015-07-31	-5.50	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:51.096121	2020-10-23 22:10:51.096121
123	1	1	-1	2	\N	2015-07-29	-84.00	fe216b9d7454ba87b9d61879bf2d3f86	2020-10-23 22:10:51.097625	2020-10-23 22:10:51.097625
124	1	7	32	2	\N	2015-07-29	-142.00	829190b95220e77629ac62b57de957c1	2020-10-23 22:10:51.099196	2020-10-23 22:10:51.099196
125	1	2	3	1	\N	2015-07-29	7667.53	c244b83e57695ab921f94faee20cac43	2020-10-23 22:10:51.101297	2020-10-23 22:10:51.101297
126	5	5	23	2	\N	2015-07-29	-32.79	d1c93c5bd481bd3d366c0407c60902c0	2020-10-23 22:10:51.102858	2020-10-23 22:10:51.102858
127	1	1	-1	2	\N	2015-07-31	-10.90	7adc2aa60ee65cb8df10902a783afb34	2020-10-23 22:10:51.104338	2020-10-23 22:10:51.104338
128	2	5	22	1	\N	2015-07-30	129.00	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:10:51.105852	2020-10-23 22:10:51.105852
129	2	2	3	1	\N	2015-07-29	6434.18	ae35ffcd3fe32daf7039c6897564fd93	2020-10-23 22:10:51.107291	2020-10-23 22:10:51.107291
130	2	10	-1	3	\N	2015-07-29	-3000.00	c6b6db39bda331c92902c6d2848151e9	2020-10-23 22:10:51.10891	2020-10-23 22:10:51.10891
131	1	9	-1	3	\N	2015-08-01	-1500.00	a96b65a721e561e1e3de768ac819ffbb	2020-10-23 22:10:51.110554	2020-10-23 22:10:51.110554
132	1	10	54	3	\N	2015-08-01	-800.00	6855456e2fe46a9d49d3d3af4f57443d	2020-10-23 22:10:51.112476	2020-10-23 22:10:51.112476
133	1	10	54	3	\N	2015-08-01	-700.00	95e2f996d978e0623f5325134f04dd90	2020-10-23 22:10:51.114102	2020-10-23 22:10:51.114102
134	1	1	11	2	\N	2015-08-01	-6.09	567279e87b30fbbc84740f8fa558ecc2	2020-10-23 22:10:51.11603	2020-10-23 22:10:51.11603
135	1	1	-1	2	\N	2015-08-01	-3.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.11774	2020-10-23 22:10:51.11774
136	3	10	54	4	\N	2015-08-01	1500.00	69746dd9b05454baef427877a7676da1	2020-10-23 22:10:51.120185	2020-10-23 22:10:51.120185
137	5	8	43	2	\N	2015-08-01	-225.70	6c9882bbac1c7093bd25041881277658	2020-10-23 22:10:51.12275	2020-10-23 22:10:51.12275
138	1	4	18	2	\N	2015-08-01	-5.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:51.124615	2020-10-23 22:10:51.124615
139	5	9	47	3	\N	2015-08-01	-100.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:10:51.126475	2020-10-23 22:10:51.126475
140	2	2	-1	4	\N	2015-08-01	100.00	3cbce60ef9b1eec4a42776149bb85fa4	2020-10-23 22:10:51.128226	2020-10-23 22:10:51.128226
141	5	2	-1	4	\N	2015-08-01	1500.00	596d904bfc6e33220346954b6e59f12c	2020-10-23 22:10:51.129906	2020-10-23 22:10:51.129906
142	5	1	-1	2	\N	2015-08-01	-5.78	0c44f7c0e75812c79b0aa9648dad5257	2020-10-23 22:10:51.131974	2020-10-23 22:10:51.131974
143	6	10	54	4	\N	2015-08-01	4500.00	cd91e55ad07e82f90b92169fbb3466ce	2020-10-23 22:10:51.133461	2020-10-23 22:10:51.133461
144	6	2	-1	1	\N	2015-08-01	40.93	31fefc0e570cb3860f2a6d4b38c6490d	2020-10-23 22:10:51.135206	2020-10-23 22:10:51.135206
145	6	4	50	2	\N	2015-08-01	-7.78	6b15c1729c4511b1f3625befaabe4c78	2020-10-23 22:10:51.137064	2020-10-23 22:10:51.137064
146	1	7	34	2	\N	2015-08-01	-129.00	4e336702a2d6a5fc6470ef2bc18f25ce	2020-10-23 22:10:51.138567	2020-10-23 22:10:51.138567
147	5	2	-1	4	\N	2015-08-02	100.00	facb303d3a998c2f7f7b2551e7446c38	2020-10-23 22:10:51.140411	2020-10-23 22:10:51.140411
148	5	5	24	2	\N	2015-08-02	-45.00	3916b3b51b8b4a0a97f12aa77ff25d89	2020-10-23 22:10:51.142123	2020-10-23 22:10:51.142123
149	5	5	23	2	\N	2015-08-02	-5.18	27b98536f92a03a0af5c1a0e6523c241	2020-10-23 22:10:51.143588	2020-10-23 22:10:51.143588
150	5	1	-1	2	\N	2015-08-02	-72.20	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:51.145268	2020-10-23 22:10:51.145268
151	1	8	41	2	\N	2015-08-02	-21.00	151f9002fb3c303ea3851145a4aee019	2020-10-23 22:10:51.146722	2020-10-23 22:10:51.146722
152	1	1	-1	2	\N	2015-08-03	-3.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.149032	2020-10-23 22:10:51.149032
153	1	8	41	2	\N	2015-08-03	-46.00	4e336702a2d6a5fc6470ef2bc18f25ce	2020-10-23 22:10:51.15105	2020-10-23 22:10:51.15105
154	1	8	41	1	\N	2015-08-04	21.00	3c5c7ef80bf7defa378f561073d3ec43	2020-10-23 22:10:51.153188	2020-10-23 22:10:51.153188
155	1	1	-1	2	\N	2015-08-04	-2.50	bf0a970cb9da391992c69626451e72a1	2020-10-23 22:10:51.155511	2020-10-23 22:10:51.155511
156	2	10	54	3	\N	2015-08-04	-2000.00	21cea431e6a5dbdb0e78a21075618e7d	2020-10-23 22:10:51.157686	2020-10-23 22:10:51.157686
157	2	5	22	3	\N	2015-08-03	-129.00	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:10:51.159912	2020-10-23 22:10:51.159912
158	5	5	22	4	\N	2015-08-03	129.00	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:10:51.162498	2020-10-23 22:10:51.162498
159	5	1	-1	2	\N	2015-08-06	-51.16	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.164645	2020-10-23 22:10:51.164645
160	2	5	21	2	\N	2015-08-06	-39.90	ca8155f4d27f205953f9d3d7974bdd70	2020-10-23 22:10:51.167438	2020-10-23 22:10:51.167438
161	5	10	54	4	\N	2015-08-01	3000.00	52b63d77bf43b876cfb710b0def2fbcc	2020-10-23 22:10:51.169495	2020-10-23 22:10:51.169495
162	5	10	54	3	\N	2015-08-01	-1500.00	992fe32ccaed550899772cc80a40d81f	2020-10-23 22:10:51.171645	2020-10-23 22:10:51.171645
163	6	10	54	4	\N	2015-08-01	1500.00	992fe32ccaed550899772cc80a40d81f	2020-10-23 22:10:51.173231	2020-10-23 22:10:51.173231
164	2	2	-1	1	\N	2015-08-06	85.90	88e9e7b2576ade31f805abfd30491dbb	2020-10-23 22:10:51.175066	2020-10-23 22:10:51.175066
165	6	10	54	4	\N	2015-08-04	2000.00	21cea431e6a5dbdb0e78a21075618e7d	2020-10-23 22:10:51.176532	2020-10-23 22:10:51.176532
166	1	1	11	2	\N	2015-08-07	-16.00	f946e2879f507d67b1bc9adecf88c880	2020-10-23 22:10:51.178875	2020-10-23 22:10:51.178875
167	1	1	11	2	\N	2015-08-06	-18.00	bd7f9884bfc6b482046e91444f37de35	2020-10-23 22:10:51.180736	2020-10-23 22:10:51.180736
168	1	1	11	2	\N	2015-08-06	-4.85	3759b70a6df0ca402642963bd06ddfb1	2020-10-23 22:10:51.183164	2020-10-23 22:10:51.183164
169	1	9	-1	2	\N	2015-08-08	-5.00	6c524f9d5d7027454a783c841250ba71	2020-10-23 22:10:51.185128	2020-10-23 22:10:51.185128
170	1	1	-1	2	\N	2015-08-07	-240.00	ceca6b7aa8467137c3f20d630be0c8df	2020-10-23 22:10:51.186704	2020-10-23 22:10:51.186704
171	5	5	23	2	\N	2015-08-05	-21.80	0f28b5d49b3020afeecd95b4009adf4c	2020-10-23 22:10:51.18805	2020-10-23 22:10:51.18805
172	1	1	-1	2	\N	2015-08-05	-11.18	c5abea48796263bb7bc6b87d30422e6a	2020-10-23 22:10:51.189821	2020-10-23 22:10:51.189821
173	5	1	-1	2	\N	2015-08-10	-104.89	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:10:51.191513	2020-10-23 22:10:51.191513
174	2	1	-1	2	\N	2015-08-08	-15.00	041150f6e3a01dcf7fbd76049587f73f	2020-10-23 22:10:51.193247	2020-10-23 22:10:51.193247
175	1	1	11	2	\N	2015-08-11	-2.00	31b33144106f9699c5d6e65d8a88f7d9	2020-10-23 22:10:51.19511	2020-10-23 22:10:51.19511
176	1	1	-1	2	\N	2015-08-12	-6.43	69261fbe9d321e10245d1c5150056baf	2020-10-23 22:10:51.196495	2020-10-23 22:10:51.196495
177	5	1	-1	2	\N	2015-08-11	-18.47	d0a90a64db3da7d80521401057d69bb3	2020-10-23 22:10:51.197866	2020-10-23 22:10:51.197866
178	1	9	-1	2	\N	2015-08-12	-11.86	b83aac23b9528732c23cc7352950e880	2020-10-23 22:10:51.199629	2020-10-23 22:10:51.199629
179	5	1	-1	2	\N	2015-08-12	-141.51	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:51.201407	2020-10-23 22:10:51.201407
180	5	1	-1	2	\N	2015-08-14	-59.04	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:51.203199	2020-10-23 22:10:51.203199
181	5	5	23	2	\N	2015-08-14	-53.90	37dd44b74df0300eaba7d5964d438ab4	2020-10-23 22:10:51.204618	2020-10-23 22:10:51.204618
182	2	5	21	2	\N	2015-08-14	-44.85	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:51.206567	2020-10-23 22:10:51.206567
183	2	6	27	2	\N	2015-08-14	-50.00	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:10:51.208629	2020-10-23 22:10:51.208629
184	1	1	-1	2	\N	2015-08-13	-6.90	b4d83f6860b6ffa13862443f17eb9f72	2020-10-23 22:10:51.21034	2020-10-23 22:10:51.21034
185	1	1	-1	2	\N	2015-08-15	-7.60	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:51.212175	2020-10-23 22:10:51.212175
186	1	1	-1	2	\N	2015-08-14	-30.00	1960f108636b1f7a73a595cb3e8a19f6	2020-10-23 22:10:51.214021	2020-10-23 22:10:51.214021
187	1	9	48	2	\N	2015-08-13	-200.81	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:10:51.215972	2020-10-23 22:10:51.215972
188	5	1	-1	2	\N	2015-08-16	-63.28	b7923fe9afe7142a24720692484321c5	2020-10-23 22:10:51.218205	2020-10-23 22:10:51.218205
189	1	9	-1	2	\N	2015-08-16	-267.00	405c7606466ad55dbbb05ea0b70808c4	2020-10-23 22:10:51.220082	2020-10-23 22:10:51.220082
190	1	1	11	2	\N	2015-08-18	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.221813	2020-10-23 22:10:51.221813
191	5	1	-1	2	\N	2015-08-18	-20.86	582a01f265547b1ce38891316c3427d5	2020-10-23 22:10:51.223479	2020-10-23 22:10:51.223479
192	5	5	23	2	\N	2015-08-19	-43.00	32601f4115aae8cca6d143d9bf3bbc08	2020-10-23 22:10:51.225225	2020-10-23 22:10:51.225225
193	5	5	23	2	\N	2015-08-18	-17.90	4d5b995358e7798bc7e9d9db83c612a5	2020-10-23 22:10:51.227192	2020-10-23 22:10:51.227192
194	5	1	-1	2	\N	2015-08-20	-62.74	0965d2bfac11dbee3d4b3002d525ddcc	2020-10-23 22:10:51.229275	2020-10-23 22:10:51.229275
195	5	1	-1	2	\N	2015-08-12	-104.89	bcbe3365e6ac95ea2c0343a2395834dd	2020-10-23 22:10:51.231149	2020-10-23 22:10:51.231149
196	5	5	21	2	\N	2015-08-08	-55.89	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:51.233466	2020-10-23 22:10:51.233466
197	2	6	27	2	\N	2015-08-17	-50.00	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:10:51.235412	2020-10-23 22:10:51.235412
198	5	1	-1	2	\N	2015-08-21	-39.79	ed74883a0e62f7670f6dd6bf9390ab48	2020-10-23 22:10:51.2371	2020-10-23 22:10:51.2371
199	1	1	-1	2	\N	2015-08-22	-21.86	67d16d00201083a2b118dd5128dd6f59	2020-10-23 22:10:51.238864	2020-10-23 22:10:51.238864
200	1	9	-1	2	\N	2015-08-22	-259.00	e316443f25fef1e9ebf48b221dc41b28	2020-10-23 22:10:51.240645	2020-10-23 22:10:51.240645
201	1	5	23	2	\N	2015-08-21	-6.20	1b7610c0693b7bbfd2ea3993da4d6fc0	2020-10-23 22:10:51.242661	2020-10-23 22:10:51.242661
202	1	1	-1	2	\N	2015-08-22	-132.00	09c20929ac4356a90624c6434a51ec73	2020-10-23 22:10:51.244414	2020-10-23 22:10:51.244414
203	1	1	-1	2	\N	2015-08-20	-18.28	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:51.246346	2020-10-23 22:10:51.246346
204	1	1	-1	2	\N	2015-08-20	-13.80	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.247804	2020-10-23 22:10:51.247804
205	1	1	-1	2	\N	2015-08-21	-4.50	2fdc411ceb06840c386ed1d6f200a135	2020-10-23 22:10:51.249282	2020-10-23 22:10:51.249282
206	1	9	-1	4	\N	2015-08-21	1500.00	1a52d0abee91ac5be8bb82d996cc7bda	2020-10-23 22:10:51.251691	2020-10-23 22:10:51.251691
207	3	9	-1	3	\N	2015-08-21	-1500.00	1a52d0abee91ac5be8bb82d996cc7bda	2020-10-23 22:10:51.253169	2020-10-23 22:10:51.253169
208	1	10	54	3	\N	2015-08-21	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:51.254798	2020-10-23 22:10:51.254798
209	2	1	-1	2	\N	2015-08-22	-10.00	f828edc20051679939b205229f41e729	2020-10-23 22:10:51.256373	2020-10-23 22:10:51.256373
210	1	10	54	3	\N	2015-08-21	-500.00	54da85d4cbcfe11da5db6c1be35f6aaa	2020-10-23 22:10:51.257967	2020-10-23 22:10:51.257967
211	5	2	-1	4	\N	2015-08-21	500.00	54da85d4cbcfe11da5db6c1be35f6aaa	2020-10-23 22:10:51.259466	2020-10-23 22:10:51.259466
212	5	1	-1	2	\N	2015-08-23	-23.39	56ce955b020482d7ba9ca231f499cb2d	2020-10-23 22:10:51.261821	2020-10-23 22:10:51.261821
213	1	1	-1	2	\N	2015-08-25	-5.70	6008683015da4d3c1ce22105cc707371	2020-10-23 22:10:51.264027	2020-10-23 22:10:51.264027
214	5	5	23	2	\N	2015-08-26	-14.90	d463c87a846080c57e7cbde6a8398590	2020-10-23 22:10:51.26594	2020-10-23 22:10:51.26594
215	2	1	-1	2	\N	2015-08-26	-7.70	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.26782	2020-10-23 22:10:51.26782
216	1	1	-1	2	\N	2015-08-25	-8.00	2b03a11699c62b969e1636e984d056db	2020-10-23 22:10:51.269974	2020-10-23 22:10:51.269974
217	1	1	11	2	\N	2015-08-27	-3.30	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.271498	2020-10-23 22:10:51.271498
218	1	1	11	2	\N	2015-08-26	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.273084	2020-10-23 22:10:51.273084
219	5	9	-1	2	\N	2015-08-27	-525.00	868f4a79ecb69df929cc0f70c33c5a3c	2020-10-23 22:10:51.274797	2020-10-23 22:10:51.274797
220	5	5	22	2	\N	2015-08-27	-200.00	8148cf440956aa149775202a8a22d1d1	2020-10-23 22:10:51.276315	2020-10-23 22:10:51.276315
221	5	1	-1	2	\N	2015-08-27	-50.00	b0db275a08c8f0bb69e86309be108a45	2020-10-23 22:10:51.277842	2020-10-23 22:10:51.277842
222	5	9	-1	2	\N	2015-08-26	-35.50	853c0eb6fd1ca116dfe81feb04265569	2020-10-23 22:10:51.279213	2020-10-23 22:10:51.279213
223	5	9	-1	2	\N	2015-08-29	-200.00	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:10:51.280983	2020-10-23 22:10:51.280983
224	1	1	-1	2	\N	2015-08-27	-9.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:51.282669	2020-10-23 22:10:51.282669
225	1	1	-1	2	\N	2015-08-27	-13.24	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.284609	2020-10-23 22:10:51.284609
226	5	1	-1	2	\N	2015-08-27	-108.40	b3af409bb8423187c75e6c7f5b683908	2020-10-23 22:10:51.286403	2020-10-23 22:10:51.286403
227	1	2	3	1	\N	2015-08-26	8400.05	e88a49bccde359f0cabb40db83ba6080	2020-10-23 22:10:51.288388	2020-10-23 22:10:51.288388
228	1	9	-1	2	\N	2015-08-27	-1500.00	de8eedf27d2d459f2f171942b07bec12	2020-10-23 22:10:51.290304	2020-10-23 22:10:51.290304
229	1	4	18	2	\N	2015-08-27	-21.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:10:51.292472	2020-10-23 22:10:51.292472
230	1	8	41	2	\N	2015-08-27	-46.00	4e336702a2d6a5fc6470ef2bc18f25ce	2020-10-23 22:10:51.29452	2020-10-23 22:10:51.29452
231	1	10	54	2	\N	2015-08-27	-500.00	563c921f86a55d6de976d908883dcfce	2020-10-23 22:10:51.296311	2020-10-23 22:10:51.296311
232	5	2	-1	4	\N	2015-08-27	1500.00	3c7a72ab2324009215e56d50d1b99569	2020-10-23 22:10:51.297932	2020-10-23 22:10:51.297932
233	6	2	-1	4	\N	2015-08-27	1500.00	3cf166c6b73f030b4f67eeaeba301103	2020-10-23 22:10:51.300123	2020-10-23 22:10:51.300123
234	6	2	-1	4	\N	2015-08-27	3500.00	b3fbb9b47283b0ca35c0a1b25a161a30	2020-10-23 22:10:51.302077	2020-10-23 22:10:51.302077
235	1	10	54	3	\N	2015-08-27	-400.00	628cc8fc94ab4adad79e586b32c479ca	2020-10-23 22:10:51.303632	2020-10-23 22:10:51.303632
236	3	2	-1	4	\N	2015-08-27	400.00	628cc8fc94ab4adad79e586b32c479ca	2020-10-23 22:10:51.305005	2020-10-23 22:10:51.305005
237	5	1	-1	2	\N	2015-08-29	-930.00	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:10:51.306476	2020-10-23 22:10:51.306476
238	5	1	-1	2	\N	2015-08-29	-80.58	55c86dd42f088b5f7d434e7bab282e63	2020-10-23 22:10:51.307908	2020-10-23 22:10:51.307908
239	5	5	21	2	\N	2015-08-30	-123.40	e44fea3bec53bcea3b7513ccef5857ac	2020-10-23 22:10:51.309291	2020-10-23 22:10:51.309291
240	1	1	-1	2	\N	2015-08-28	-15.74	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.310723	2020-10-23 22:10:51.310723
241	1	1	-1	2	\N	2015-08-31	-3.45	bf0a970cb9da391992c69626451e72a1	2020-10-23 22:10:51.312096	2020-10-23 22:10:51.312096
242	6	10	54	4	\N	2015-08-31	5000.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:10:51.313459	2020-10-23 22:10:51.313459
243	5	2	-1	4	\N	2015-08-31	100.00	b6aea7af56564f32a22ce27f25936b82	2020-10-23 22:10:51.314905	2020-10-23 22:10:51.314905
244	5	9	-1	2	\N	2015-08-30	-269.00	8c3db30aba706c50b2a8497efa43b872	2020-10-23 22:10:51.316264	2020-10-23 22:10:51.316264
245	1	1	-1	2	\N	2015-08-31	-96.00	6c94db4a808e5b20e82b9b2024665fa3	2020-10-23 22:10:51.317806	2020-10-23 22:10:51.317806
246	5	5	21	2	\N	2015-08-29	-13.57	54dd11685d504aa2eff075007900b41f	2020-10-23 22:10:51.319216	2020-10-23 22:10:51.319216
247	2	2	3	1	\N	2015-08-26	7780.60	853c0eb6fd1ca116dfe81feb04265569	2020-10-23 22:10:51.320646	2020-10-23 22:10:51.320646
248	2	10	54	3	\N	2015-08-28	-3000.00	24c0c8618da63ae4153bfff9809daaed	2020-10-23 22:10:51.321956	2020-10-23 22:10:51.321956
249	2	10	54	2	\N	2015-08-28	-295.00	815be9c5c7d37e665a99f23bbbdc345f	2020-10-23 22:10:51.323235	2020-10-23 22:10:51.323235
250	2	1	-1	2	\N	2015-08-29	-50.00	a27ef1c79c867d68d049751af69f4b38	2020-10-23 22:10:51.324647	2020-10-23 22:10:51.324647
251	5	8	43	2	\N	2015-10-03	-133.07	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:10:51.326008	2020-10-23 22:10:51.326008
252	5	1	-1	2	\N	2015-10-04	-89.21	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:51.327341	2020-10-23 22:10:51.327341
253	1	1	-1	2	\N	2015-10-02	-21.00	541c75d9a67828ccfe20959984b8dbf6	2020-10-23 22:10:51.328739	2020-10-23 22:10:51.328739
254	1	1	-1	2	\N	2015-10-02	-17.50	541c75d9a67828ccfe20959984b8dbf6	2020-10-23 22:10:51.330705	2020-10-23 22:10:51.330705
255	1	1	-1	2	\N	2015-10-02	-60.00	3c7a72ab2324009215e56d50d1b99569	2020-10-23 22:10:51.332278	2020-10-23 22:10:51.332278
256	1	1	-1	2	\N	2015-10-01	-8.07	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.334211	2020-10-23 22:10:51.334211
257	1	1	-1	2	\N	2015-10-01	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:51.335637	2020-10-23 22:10:51.335637
258	1	1	-1	2	\N	2015-10-01	-11.45	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:51.337341	2020-10-23 22:10:51.337341
259	1	1	-1	2	\N	2015-10-04	-15.08	725875b65be0b5456e290ab0df52f62e	2020-10-23 22:10:51.339284	2020-10-23 22:10:51.339284
260	1	1	-1	2	\N	2015-10-02	-5.00	a6cb53f898763c410cf00175c3deedeb	2020-10-23 22:10:51.34068	2020-10-23 22:10:51.34068
261	5	4	15	2	\N	2015-10-04	-126.36	9cbe1f2b71231e51acd9d0e0d48b832f	2020-10-23 22:10:51.342553	2020-10-23 22:10:51.342553
262	5	4	13	2	\N	2015-10-04	-327.77	23d6ea691f42ea37ddc3676ddac2a07f	2020-10-23 22:10:51.344271	2020-10-23 22:10:51.344271
263	1	8	41	2	\N	2015-10-06	-64.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:51.345995	2020-10-23 22:10:51.345995
264	5	1	-1	2	\N	2015-10-05	-61.20	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.348063	2020-10-23 22:10:51.348063
265	2	10	54	3	\N	2015-10-05	-1500.00	1347b12704ea451e89c54fee1b9e0cae	2020-10-23 22:10:51.349563	2020-10-23 22:10:51.349563
266	2	10	54	3	\N	2015-10-05	-500.00	e995f98d56967d946471af29d7bf99f1	2020-10-23 22:10:51.351318	2020-10-23 22:10:51.351318
267	2	10	54	3	\N	2015-10-05	-2500.00	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:10:51.353861	2020-10-23 22:10:51.353861
268	6	10	54	4	\N	2015-10-05	1500.00	1347b12704ea451e89c54fee1b9e0cae	2020-10-23 22:10:51.356203	2020-10-23 22:10:51.356203
269	4	10	54	4	\N	2015-10-05	2500.00	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:10:51.357991	2020-10-23 22:10:51.357991
270	2	1	-1	2	\N	2015-10-06	-8.90	1c1d4df596d01da60385f0bb17a4a9e0	2020-10-23 22:10:51.359774	2020-10-23 22:10:51.359774
271	2	4	16	1	\N	2015-10-06	80.00	738aebc1f9aef81413d00e0990bb2e45	2020-10-23 22:10:51.361457	2020-10-23 22:10:51.361457
272	1	9	-1	2	\N	2015-10-06	-50.00	26c91801f25caaf4bf5db26f6ad5802b	2020-10-23 22:10:51.363705	2020-10-23 22:10:51.363705
273	1	2	3	1	\N	2015-10-06	297.68	6045083e3a6452f9be2e1966d5851dff	2020-10-23 22:10:51.365318	2020-10-23 22:10:51.365318
274	2	1	-1	2	\N	2015-10-07	-4.70	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.366646	2020-10-23 22:10:51.366646
275	2	1	-1	2	\N	2015-10-07	-7.80	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:10:51.368573	2020-10-23 22:10:51.368573
276	5	5	22	2	\N	2015-10-08	-200.00	b8492ebc3602aaa39adffb5f84e6e48d	2020-10-23 22:10:51.370148	2020-10-23 22:10:51.370148
277	2	1	-1	2	\N	2015-10-08	-10.00	3b11d4ed537ced20e41a9b8a067f5d85	2020-10-23 22:10:51.371638	2020-10-23 22:10:51.371638
278	5	1	-1	2	\N	2015-10-12	-16.73	bd686fd640be98efaae0091fa301e613	2020-10-23 22:10:51.373269	2020-10-23 22:10:51.373269
279	2	6	27	2	\N	2015-10-12	-33.00	204a3eeab2a68f6bd87db22983749c42	2020-10-23 22:10:51.37504	2020-10-23 22:10:51.37504
280	5	1	-1	2	\N	2015-10-13	-45.21	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.376615	2020-10-23 22:10:51.376615
281	5	1	-1	2	\N	2015-10-15	-14.19	3bae86cea8b0298f34b0847fca86361a	2020-10-23 22:10:51.37799	2020-10-23 22:10:51.37799
282	5	1	-1	2	\N	2015-10-15	-9.23	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.379896	2020-10-23 22:10:51.379896
283	2	8	41	2	\N	2015-10-16	-40.00	71c32595c397960f74555a8b9db16f75	2020-10-23 22:10:51.381674	2020-10-23 22:10:51.381674
284	2	7	35	2	\N	2015-10-16	-5.00	6d4a60c0cdc04146a1ef2c56caf03d80	2020-10-23 22:10:51.383439	2020-10-23 22:10:51.383439
285	5	6	27	2	\N	2015-10-16	-21.00	f144614f14c11f8493449e44ecb7559c	2020-10-23 22:10:51.385283	2020-10-23 22:10:51.385283
286	2	1	-1	2	\N	2015-10-19	-3.50	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.387044	2020-10-23 22:10:51.387044
287	1	1	11	2	\N	2015-10-10	-3.30	8d70912d7789d196b998e3d5728d0473	2020-10-23 22:10:51.388804	2020-10-23 22:10:51.388804
288	1	1	-1	2	\N	2015-10-10	-1.71	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.390506	2020-10-23 22:10:51.390506
289	5	8	43	2	\N	2015-10-18	-211.63	d693c4871a99d7acf43c4b1112da0c6e	2020-10-23 22:10:51.392245	2020-10-23 22:10:51.392245
290	5	1	-1	2	\N	2015-10-10	-69.77	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.394013	2020-10-23 22:10:51.394013
291	1	1	-1	2	\N	2015-10-08	-27.40	24681928425f5a9133504de568f5f6df	2020-10-23 22:10:51.395626	2020-10-23 22:10:51.395626
292	1	1	-1	2	\N	2015-10-09	-28.70	577bcc914f9e55d5e4e4f82f9f00e7d4	2020-10-23 22:10:51.397318	2020-10-23 22:10:51.397318
293	1	1	-1	2	\N	2015-10-03	-4.73	83aefffc5cb2fd09c7218cace5a57150	2020-10-23 22:10:51.398932	2020-10-23 22:10:51.398932
294	5	1	-1	2	\N	2015-10-11	-8.00	83aefffc5cb2fd09c7218cace5a57150	2020-10-23 22:10:51.400516	2020-10-23 22:10:51.400516
295	1	1	-1	2	\N	2015-10-10	-9.67	0fb4949df4b890779431a30052df940e	2020-10-23 22:10:51.402346	2020-10-23 22:10:51.402346
296	1	1	-1	2	\N	2015-10-15	-2.45	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:51.404063	2020-10-23 22:10:51.404063
297	5	1	-1	2	\N	2015-10-10	-21.14	915c00c94072a859394077f49d202b6a	2020-10-23 22:10:51.405739	2020-10-23 22:10:51.405739
298	1	1	-1	2	\N	2015-10-16	-22.97	f144614f14c11f8493449e44ecb7559c	2020-10-23 22:10:51.407505	2020-10-23 22:10:51.407505
299	1	1	-1	2	\N	2015-10-17	-43.09	f144614f14c11f8493449e44ecb7559c	2020-10-23 22:10:51.40932	2020-10-23 22:10:51.40932
300	5	2	-1	4	\N	2015-10-05	300.00	2b14cb605a1ebfe1ec0b9ad1be8800bc	2020-10-23 22:10:51.410763	2020-10-23 22:10:51.410763
301	5	1	-1	2	\N	2015-10-20	-87.92	c51e9d44a659ecf9512e1a2844416d9b	2020-10-23 22:10:51.412062	2020-10-23 22:10:51.412062
302	5	1	-1	2	\N	2015-10-20	-13.96	db5e3ca8f31baa572cb64be6e74d0dba	2020-10-23 22:10:51.413393	2020-10-23 22:10:51.413393
303	5	1	-1	2	\N	2015-10-22	-35.00	91063e75da9043813ddc8bda2a134b02	2020-10-23 22:10:51.414714	2020-10-23 22:10:51.414714
304	5	1	-1	2	\N	2015-10-22	-13.50	a80fbbb5787b057841f0ea51cd9a9b26	2020-10-23 22:10:51.41609	2020-10-23 22:10:51.41609
305	2	6	27	2	\N	2015-10-22	-18.00	7a3697ecbdb485a0d3b3bb2fc3916b92	2020-10-23 22:10:51.417566	2020-10-23 22:10:51.417566
306	2	1	-1	2	\N	2015-10-22	-6.48	da3c56867333df0fff5655eac38d0630	2020-10-23 22:10:51.419163	2020-10-23 22:10:51.419163
307	1	9	-1	2	\N	2015-10-22	-6.40	0edaec591e2043aa9e36626c839fce18	2020-10-23 22:10:51.420402	2020-10-23 22:10:51.420402
308	1	1	-1	2	\N	2015-10-22	-11.13	01f78be6f7cad02658508fe4616098a9	2020-10-23 22:10:51.421728	2020-10-23 22:10:51.421728
309	5	2	-1	1	\N	2015-10-23	200.00	a4d751f128596dee5517d8a007e6ea02	2020-10-23 22:10:51.423234	2020-10-23 22:10:51.423234
310	2	6	27	2	\N	2015-10-23	-104.97	55c86dd42f088b5f7d434e7bab282e63	2020-10-23 22:10:51.424526	2020-10-23 22:10:51.424526
311	1	1	-1	2	\N	2015-10-23	-26.00	18197006551a437629411cc79c7dc3d8	2020-10-23 22:10:51.425968	2020-10-23 22:10:51.425968
312	1	1	-1	2	\N	2015-10-23	-2.45	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.427555	2020-10-23 22:10:51.427555
313	1	1	11	2	\N	2015-10-23	-2.49	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:10:51.429749	2020-10-23 22:10:51.429749
314	1	1	-1	2	\N	2015-10-23	-35.34	d2716515bd05082789a31002d4bbc958	2020-10-23 22:10:51.431388	2020-10-23 22:10:51.431388
315	1	1	-1	2	\N	2015-10-23	-16.00	62a0e3d0e8d9db40e64419904a137c32	2020-10-23 22:10:51.43287	2020-10-23 22:10:51.43287
316	5	1	-1	2	\N	2015-10-24	-99.47	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.434761	2020-10-23 22:10:51.434761
317	1	1	11	2	\N	2015-10-23	-2.00	8d70912d7789d196b998e3d5728d0473	2020-10-23 22:10:51.436428	2020-10-23 22:10:51.436428
318	1	1	-1	2	\N	2015-10-23	-3.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.437764	2020-10-23 22:10:51.437764
319	2	6	27	2	\N	2015-10-24	-10.00	d54c1fa682619ec13c17b308a993232f	2020-10-23 22:10:51.439096	2020-10-23 22:10:51.439096
320	2	6	27	2	\N	2015-10-24	-6.12	ac1dd209cbcc5e5d1c6e28598e8cbbe8	2020-10-23 22:10:51.440465	2020-10-23 22:10:51.440465
321	2	5	21	2	\N	2015-10-24	-40.00	20aee3a5f4643755a79ee5f6a73050ac	2020-10-23 22:10:51.441844	2020-10-23 22:10:51.441844
322	5	4	16	2	\N	2015-10-26	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:51.443247	2020-10-23 22:10:51.443247
323	2	6	27	2	\N	2015-10-27	-40.10	b56c3e19f5a9156859dc89cdf30afc1b	2020-10-23 22:10:51.444963	2020-10-23 22:10:51.444963
324	2	9	48	2	\N	2015-10-27	-299.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:51.447015	2020-10-23 22:10:51.447015
325	2	1	-1	2	\N	2015-10-27	-9.18	e53b6788d562d06fc3fa311e988bc27a	2020-10-23 22:10:51.449069	2020-10-23 22:10:51.449069
326	2	9	-1	2	\N	2015-10-27	-641.00	599f127bd63e32d6fd5457f9f1fa1e14	2020-10-23 22:10:51.451193	2020-10-23 22:10:51.451193
327	2	2	3	1	\N	2015-10-27	6681.37	0706dfd8b8609ec0635c4369b59d699f	2020-10-23 22:10:51.453136	2020-10-23 22:10:51.453136
328	2	10	54	3	\N	2015-10-27	-1500.00	20e8a6dc4a14e987cca668822d90e3c8	2020-10-23 22:10:51.454766	2020-10-23 22:10:51.454766
329	2	10	54	3	\N	2015-10-27	-1500.00	56f8e43767cf93af23801dbdf2bf0335	2020-10-23 22:10:51.456404	2020-10-23 22:10:51.456404
330	5	10	54	4	\N	2015-10-27	1500.00	20e8a6dc4a14e987cca668822d90e3c8	2020-10-23 22:10:51.458198	2020-10-23 22:10:51.458198
331	6	10	54	4	\N	2015-10-27	1500.00	56f8e43767cf93af23801dbdf2bf0335	2020-10-23 22:10:51.459926	2020-10-23 22:10:51.459926
332	5	10	54	3	\N	2015-10-27	-2000.00	860d76957a4845af5c1a4b77c6670852	2020-10-23 22:10:51.461889	2020-10-23 22:10:51.461889
333	6	10	54	4	\N	2015-10-27	2000.00	860d76957a4845af5c1a4b77c6670852	2020-10-23 22:10:51.463563	2020-10-23 22:10:51.463563
334	2	10	54	3	\N	2015-10-27	-2000.00	ab095d255486a6e82e6e4dce89468cf5	2020-10-23 22:10:51.465254	2020-10-23 22:10:51.465254
335	4	10	54	4	\N	2015-10-27	2000.00	ab095d255486a6e82e6e4dce89468cf5	2020-10-23 22:10:51.467177	2020-10-23 22:10:51.467177
336	1	2	3	1	\N	2015-10-28	8400.05	d7131d1ae44bc08bfaea5b61f9be7f11	2020-10-23 22:10:51.468991	2020-10-23 22:10:51.468991
337	1	10	54	3	\N	2015-10-28	-500.00	6395ebd0f4b478145ecfbaf939454fa4	2020-10-23 22:10:51.470744	2020-10-23 22:10:51.470744
338	1	10	54	3	\N	2015-10-28	-1850.00	b2737b37b181300a80927e307554821a	2020-10-23 22:10:51.472333	2020-10-23 22:10:51.472333
339	1	10	54	3	\N	2015-10-28	-1500.00	758874998f5bd0c393da094e1967a72b	2020-10-23 22:10:51.473809	2020-10-23 22:10:51.473809
340	6	10	54	4	\N	2015-10-28	1500.00	758874998f5bd0c393da094e1967a72b	2020-10-23 22:10:51.47506	2020-10-23 22:10:51.47506
341	1	10	54	3	\N	2015-10-28	-4400.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:10:51.476376	2020-10-23 22:10:51.476376
342	3	10	54	4	\N	2015-10-28	4400.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:10:51.477672	2020-10-23 22:10:51.477672
343	5	1	-1	2	\N	2015-10-26	-8.69	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:51.478914	2020-10-23 22:10:51.478914
344	2	1	-1	2	\N	2015-10-29	-30.00	df263d996281d984952c07998dc54358	2020-10-23 22:10:51.480272	2020-10-23 22:10:51.480272
345	5	1	-1	2	\N	2015-10-29	-36.11	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.481712	2020-10-23 22:10:51.481712
346	5	5	23	2	\N	2015-10-29	-53.99	4062fdd0a447a552e142398c4a94241b	2020-10-23 22:10:51.483049	2020-10-23 22:10:51.483049
347	2	5	22	2	\N	2015-10-29	-50.00	b9228e0962a78b84f3d5d92f4faa000b	2020-10-23 22:10:51.485043	2020-10-23 22:10:51.485043
348	2	9	48	2	\N	2015-10-29	-39.90	d54c1fa682619ec13c17b308a993232f	2020-10-23 22:10:51.487138	2020-10-23 22:10:51.487138
349	2	8	41	2	\N	2015-10-30	-40.00	e820f3a30380e5c6e584268c302d35fa	2020-10-23 22:10:51.488715	2020-10-23 22:10:51.488715
350	2	1	-1	2	\N	2015-10-30	-22.00	9f536174f0d50e0afd5f0e935495f1ef	2020-10-23 22:10:51.49038	2020-10-23 22:10:51.49038
351	2	8	44	2	\N	2015-10-30	-17.00	582a01f265547b1ce38891316c3427d5	2020-10-23 22:10:51.491679	2020-10-23 22:10:51.491679
352	5	1	-1	2	\N	2015-10-31	-50.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:51.492946	2020-10-23 22:10:51.492946
353	5	4	13	2	\N	2015-10-31	-327.77	3417ed882084a60ae30cf097c9df73c7	2020-10-23 22:10:51.494332	2020-10-23 22:10:51.494332
354	5	4	14	2	\N	2015-10-31	-124.00	f4be00279ee2e0a53eafdaa94a151e2c	2020-10-23 22:10:51.49582	2020-10-23 22:10:51.49582
355	6	2	-1	1	\N	2015-10-31	9.29	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:51.497817	2020-10-23 22:10:51.497817
356	5	1	-1	2	\N	2015-10-31	-28.11	eed5af6add95a9a6f1252739b1ad8c24	2020-10-23 22:10:51.499674	2020-10-23 22:10:51.499674
357	5	1	-1	2	\N	2015-10-31	-81.27	320722549d1751cf3f247855f937b982	2020-10-23 22:10:51.501564	2020-10-23 22:10:51.501564
358	1	1	-1	2	\N	2015-10-31	-25.00	7b16783a9d7ce44e12deb7c9a372a027	2020-10-23 22:10:51.503193	2020-10-23 22:10:51.503193
359	1	1	-1	2	\N	2015-10-31	-34.00	52b7bee83b5f424d63ef78f36db3eaf2	2020-10-23 22:10:51.504822	2020-10-23 22:10:51.504822
360	1	1	-1	2	\N	2015-10-31	-16.00	f0c7c8ee504f69ff718e8b26f949220a	2020-10-23 22:10:51.506192	2020-10-23 22:10:51.506192
361	2	1	-1	1	\N	2015-09-01	0.00	44634e6a8140e7640e9088fb97bdac50	2020-10-23 22:10:51.508148	2020-10-23 22:10:51.508148
362	2	10	54	3	\N	2015-09-01	-3500.00	4310e3e7a5890265a915effd565d7992	2020-10-23 22:10:51.509925	2020-10-23 22:10:51.509925
363	5	1	-1	2	\N	2015-09-01	-123.40	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:51.511955	2020-10-23 22:10:51.511955
364	5	4	16	2	\N	2015-09-01	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:51.513751	2020-10-23 22:10:51.513751
365	5	1	-1	2	\N	2015-09-01	-50.00	0452c066bedd0a279865e510e4b2ddb7	2020-10-23 22:10:51.515351	2020-10-23 22:10:51.515351
366	5	10	54	4	\N	2015-09-01	3000.00	5059efdf60bdf6b7fd0a069501542bb5	2020-10-23 22:10:51.517271	2020-10-23 22:10:51.517271
367	5	4	13	2	\N	2015-09-01	-397.40	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:10:51.519167	2020-10-23 22:10:51.519167
368	5	10	54	3	\N	2015-09-01	-1500.00	8bce5c225bb9a7364e25b9a744a429d5	2020-10-23 22:10:51.520855	2020-10-23 22:10:51.520855
369	6	10	54	4	\N	2015-09-01	1500.00	8bce5c225bb9a7364e25b9a744a429d5	2020-10-23 22:10:51.522527	2020-10-23 22:10:51.522527
370	6	10	54	4	\N	2015-09-01	3500.00	4310e3e7a5890265a915effd565d7992	2020-10-23 22:10:51.52429	2020-10-23 22:10:51.52429
371	1	1	-1	2	\N	2015-09-02	-3.85	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:51.526159	2020-10-23 22:10:51.526159
372	1	1	11	2	\N	2015-09-02	-5.50	bf0a970cb9da391992c69626451e72a1	2020-10-23 22:10:51.527935	2020-10-23 22:10:51.527935
373	1	9	-1	2	\N	2015-09-02	-100.00	0c2c0801d663f43707d9f9e578b200dd	2020-10-23 22:10:51.529836	2020-10-23 22:10:51.529836
374	6	2	-1	1	\N	2015-09-01	44.11	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:51.531416	2020-10-23 22:10:51.531416
375	5	1	-1	2	\N	2015-09-02	-44.98	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.5331	2020-10-23 22:10:51.5331
376	5	5	23	2	\N	2015-09-02	-43.00	e00da03b685a0dd18fb6a08af0923de0	2020-10-23 22:10:51.534782	2020-10-23 22:10:51.534782
377	5	5	23	2	\N	2015-09-04	-78.40	7d06a9cf10f2e9e47e77d6c6cfaa7f54	2020-10-23 22:10:51.537086	2020-10-23 22:10:51.537086
378	2	5	21	2	\N	2015-09-04	-55.23	af032fbcb07ffc7bd2569d86ae4ce1f5	2020-10-23 22:10:51.53882	2020-10-23 22:10:51.53882
379	2	4	18	2	\N	2015-09-04	-111.88	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:51.540215	2020-10-23 22:10:51.540215
380	2	4	18	2	\N	2015-09-04	-40.06	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:51.541566	2020-10-23 22:10:51.541566
381	1	1	11	2	\N	2015-09-03	-1.60	61b4a64be663682e8cb037d9719ad8cd	2020-10-23 22:10:51.542751	2020-10-23 22:10:51.542751
382	1	1	-1	2	\N	2015-09-04	-13.52	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.54394	2020-10-23 22:10:51.54394
383	5	1	-1	2	\N	2015-09-07	-12.94	5dd033d162065873ffdfa5c0ec597932	2020-10-23 22:10:51.545273	2020-10-23 22:10:51.545273
384	5	1	-1	2	\N	2015-09-05	-40.21	b3af409bb8423187c75e6c7f5b683908	2020-10-23 22:10:51.546519	2020-10-23 22:10:51.546519
385	1	1	-1	2	\N	2015-09-05	-20.00	4b56626af6238c2ff3d08e5ee9174346	2020-10-23 22:10:51.547782	2020-10-23 22:10:51.547782
386	1	1	11	2	\N	2015-09-05	-12.70	3497865f828d5b3c019257c6f0fb67b2	2020-10-23 22:10:51.549138	2020-10-23 22:10:51.549138
387	1	9	-1	2	\N	2015-09-06	-5.00	4524f17a5640c6ccc57bc5a68c0ab3b9	2020-10-23 22:10:51.551061	2020-10-23 22:10:51.551061
388	1	1	-1	2	\N	2015-09-05	-50.00	1b5449c9c2f3481ae6c524c55d3fb9e2	2020-10-23 22:10:51.552423	2020-10-23 22:10:51.552423
389	5	9	48	2	\N	2015-09-08	-600.00	a7f24560dc76362cc97a872d0fff59db	2020-10-23 22:10:51.553687	2020-10-23 22:10:51.553687
390	5	2	-1	4	\N	2015-09-08	105.70	043c3d7e489c69b48737cc0c92d0f3a2	2020-10-23 22:10:51.554864	2020-10-23 22:10:51.554864
391	5	2	-1	4	\N	2015-09-08	105.70	043c3d7e489c69b48737cc0c92d0f3a2	2020-10-23 22:10:51.556027	2020-10-23 22:10:51.556027
392	2	9	48	2	\N	2015-09-08	-45.00	a30ba599dc9a86c83069d31f6eccace6	2020-10-23 22:10:51.557288	2020-10-23 22:10:51.557288
393	5	2	-1	1	\N	2015-09-09	19.90	74bba22728b6185eec06286af6bec36d	2020-10-23 22:10:51.558634	2020-10-23 22:10:51.558634
394	5	4	13	2	\N	2015-09-10	-9.93	30eaaaf5c36ec455827f2ad34b41f70d	2020-10-23 22:10:51.559925	2020-10-23 22:10:51.559925
395	5	1	-1	2	\N	2015-09-10	-90.39	492287294ce9e2e85da9c1e5f06780fa	2020-10-23 22:10:51.561258	2020-10-23 22:10:51.561258
396	1	8	40	2	\N	2015-09-10	-1.00	11f298496dab43d2acd47997670ee01e	2020-10-23 22:10:51.56256	2020-10-23 22:10:51.56256
397	1	1	11	2	\N	2015-09-10	-1.60	054cfa342c557022336f9c51029ec9ad	2020-10-23 22:10:51.563926	2020-10-23 22:10:51.563926
398	1	1	-1	2	\N	2015-09-10	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:51.565519	2020-10-23 22:10:51.565519
399	1	1	-1	2	\N	2015-09-10	-10.39	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:51.567053	2020-10-23 22:10:51.567053
400	1	8	40	2	\N	2015-09-10	-27.70	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:51.568544	2020-10-23 22:10:51.568544
401	1	9	48	2	\N	2015-09-09	-359.85	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:51.569786	2020-10-23 22:10:51.569786
402	2	6	27	2	\N	2015-09-11	-99.90	3f7d7ba72a6872975f5bd3f2254ab238	2020-10-23 22:10:51.57104	2020-10-23 22:10:51.57104
403	2	5	21	2	\N	2015-09-11	-39.99	47b3844d7d80486508007293cfb77909	2020-10-23 22:10:51.572366	2020-10-23 22:10:51.572366
404	2	8	41	2	\N	2015-09-11	-30.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:51.573664	2020-10-23 22:10:51.573664
405	2	8	41	2	\N	2015-09-11	-5.60	e0283dadd1277d0ce6c6bae5787408a2	2020-10-23 22:10:51.574937	2020-10-23 22:10:51.574937
406	1	1	-1	2	\N	2015-09-12	-17.44	0f49c89d1e7298bb9930789c8ed59d48	2020-10-23 22:10:51.576233	2020-10-23 22:10:51.576233
407	5	1	-1	2	\N	2015-09-13	-69.00	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:10:51.577578	2020-10-23 22:10:51.577578
408	1	9	48	2	\N	2015-09-12	-20.00	38c8ce17b0d03d0bb30d3b78edfa597d	2020-10-23 22:10:51.578892	2020-10-23 22:10:51.578892
409	5	1	-1	2	\N	2015-09-13	-14.38	539fd53b59e3bb12d203f45a912eeaf2	2020-10-23 22:10:51.580362	2020-10-23 22:10:51.580362
410	2	4	16	2	\N	2015-09-14	-44.99	7eabe3a1649ffa2b3ff8c02ebfd5659f	2020-10-23 22:10:51.581644	2020-10-23 22:10:51.581644
411	2	4	18	2	\N	2015-09-14	-3.60	150186647526dfba823db3cb195b6404	2020-10-23 22:10:51.583274	2020-10-23 22:10:51.583274
412	2	6	27	2	\N	2015-09-12	-89.98	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:10:51.585196	2020-10-23 22:10:51.585196
413	2	9	-1	2	\N	2015-09-12	-80.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:51.586557	2020-10-23 22:10:51.586557
414	5	9	47	2	\N	2015-09-12	-50.00	18d8042386b79e2c279fd162df0205c8	2020-10-23 22:10:51.587823	2020-10-23 22:10:51.587823
415	5	1	-1	2	\N	2015-09-12	-55.06	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:51.589478	2020-10-23 22:10:51.589478
416	5	4	15	2	\N	2015-09-15	-185.33	7c6f989b82189ed8ec46ec2973583ba9	2020-10-23 22:10:51.590841	2020-10-23 22:10:51.590841
417	2	1	-1	2	\N	2015-09-15	-32.90	2fdc411ceb06840c386ed1d6f200a135	2020-10-23 22:10:51.592043	2020-10-23 22:10:51.592043
418	1	1	11	2	\N	2015-09-14	-1.50	eebc37163657a4d729b6e28c3b850fc9	2020-10-23 22:10:51.593245	2020-10-23 22:10:51.593245
419	1	1	11	2	\N	2015-09-14	-8.49	0b8aff0438617c055eb55f0ba5d226fa	2020-10-23 22:10:51.594508	2020-10-23 22:10:51.594508
420	1	2	-1	1	\N	2015-09-14	200.81	705f2172834666788607efbfca35afb3	2020-10-23 22:10:51.595759	2020-10-23 22:10:51.595759
421	1	1	-1	2	\N	2015-09-16	-16.89	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.597015	2020-10-23 22:10:51.597015
422	1	1	-1	2	\N	2015-09-16	-5.34	d8a3db1331d1d85d2bf5d4e8823f0d80	2020-10-23 22:10:51.598328	2020-10-23 22:10:51.598328
423	5	1	-1	2	\N	2015-09-16	-78.74	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:51.599724	2020-10-23 22:10:51.599724
424	2	9	-1	2	\N	2015-09-16	-35.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:51.601585	2020-10-23 22:10:51.601585
425	5	1	-1	2	\N	2015-09-16	-11.76	c883eba76b703e3c51c328cf406dbc95	2020-10-23 22:10:51.60301	2020-10-23 22:10:51.60301
426	1	1	11	2	\N	2015-09-16	-1.60	22fb0cee7e1f3bde58293de743871417	2020-10-23 22:10:51.604238	2020-10-23 22:10:51.604238
427	2	1	-1	2	\N	2015-09-19	-3.87	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.60544	2020-10-23 22:10:51.60544
428	1	5	21	2	\N	2015-09-19	-11.79	721002e45ce8fc58e4bd08b19b89a38c	2020-10-23 22:10:51.606567	2020-10-23 22:10:51.606567
429	5	5	21	2	\N	2015-09-19	-98.97	eba0dc302bcd9a273f8bbb72be3a687b	2020-10-23 22:10:51.607721	2020-10-23 22:10:51.607721
430	5	1	-1	2	\N	2015-09-19	-19.93	bdcbe0e09f9b05829ed552e01babea04	2020-10-23 22:10:51.608884	2020-10-23 22:10:51.608884
431	1	5	25	2	\N	2015-09-19	-35.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:10:51.61004	2020-10-23 22:10:51.61004
432	5	1	-1	2	\N	2015-09-19	-7.67	68264bdb65b97eeae6788aa3348e553c	2020-10-23 22:10:51.611175	2020-10-23 22:10:51.611175
433	5	1	-1	2	\N	2015-09-19	-18.97	68264bdb65b97eeae6788aa3348e553c	2020-10-23 22:10:51.612279	2020-10-23 22:10:51.612279
434	2	1	-1	2	\N	2015-09-20	-17.00	173f6138afd9b026372907766f8d3764	2020-10-23 22:10:51.613442	2020-10-23 22:10:51.613442
435	2	1	-1	2	\N	2015-09-20	-70.00	c753ca99cb9a635d99942cc37f0a0ce5	2020-10-23 22:10:51.614543	2020-10-23 22:10:51.614543
436	5	10	54	4	\N	2015-09-21	900.00	61b4a64be663682e8cb037d9719ad8cd	2020-10-23 22:10:51.615641	2020-10-23 22:10:51.615641
437	5	1	-1	2	\N	2015-09-21	-26.60	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.616793	2020-10-23 22:10:51.616793
438	2	1	-1	2	\N	2015-09-22	-35.00	7ff570da3b2ba4814f4c3c330bce4c56	2020-10-23 22:10:51.618116	2020-10-23 22:10:51.618116
439	5	5	23	2	\N	2015-09-22	-49.99	357b6f7587a9cb5d0f97659b50424922	2020-10-23 22:10:51.619431	2020-10-23 22:10:51.619431
440	5	6	27	2	\N	2015-09-22	-24.00	3cdb0dd8faabc2042e1793d248cf8076	2020-10-23 22:10:51.620649	2020-10-23 22:10:51.620649
441	5	5	23	2	\N	2015-09-22	-51.00	a3fcb5fb9f29eed6064fd350374e2de8	2020-10-23 22:10:51.621787	2020-10-23 22:10:51.621787
442	2	1	-1	2	\N	2015-09-23	-41.00	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:10:51.623214	2020-10-23 22:10:51.623214
443	5	6	27	2	\N	2015-09-23	-9.00	2f9e91d515c304249275300d3adb94a7	2020-10-23 22:10:51.624396	2020-10-23 22:10:51.624396
444	5	1	-1	2	\N	2015-09-23	-13.96	0ff39bbbf981ac0151d340c9aa40e63e	2020-10-23 22:10:51.625629	2020-10-23 22:10:51.625629
445	5	1	-1	2	\N	2015-09-21	-9.40	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.62687	2020-10-23 22:10:51.62687
446	1	1	-1	2	\N	2015-09-24	-8.92	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.627994	2020-10-23 22:10:51.627994
447	1	4	18	2	\N	2015-09-20	-21.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:51.629107	2020-10-23 22:10:51.629107
448	1	8	45	2	\N	2015-09-24	-32.00	3692e633c258493a1a98c641e947569b	2020-10-23 22:10:51.630214	2020-10-23 22:10:51.630214
449	1	8	45	2	\N	2015-09-24	-29.00	b7bb35b9c6ca2aee2df08cf09d7016c2	2020-10-23 22:10:51.63133	2020-10-23 22:10:51.63133
450	1	2	3	1	\N	2015-09-24	8400.05	7e7757b1e12abcb736ab9a754ffb617a	2020-10-23 22:10:51.63243	2020-10-23 22:10:51.63243
451	1	1	-1	2	\N	2015-09-27	-12.34	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.63362	2020-10-23 22:10:51.63362
452	5	8	43	2	\N	2015-09-25	-146.93	f90f2aca5c640289d0a29417bcb63a37	2020-10-23 22:10:51.634956	2020-10-23 22:10:51.634956
453	5	1	-1	2	\N	2015-09-25	-2.79	c64e8971b113555fbcbb72508a29c7c3	2020-10-23 22:10:51.636207	2020-10-23 22:10:51.636207
454	5	5	23	2	\N	2015-09-28	-17.59	266356ae2a5ba3478d8dc1abc8c9b78f	2020-10-23 22:10:51.637395	2020-10-23 22:10:51.637395
455	5	5	22	2	\N	2015-09-26	-330.00	645b55e0019f39c9af724df342913581	2020-10-23 22:10:51.638602	2020-10-23 22:10:51.638602
456	5	2	-1	1	\N	2015-09-25	27.90	209f504258204379d36b77d57d5c14a0	2020-10-23 22:10:51.639776	2020-10-23 22:10:51.639776
457	5	10	54	3	\N	2015-09-27	-1000.00	c90fe2651db8f9cf13b9e37bc8add720	2020-10-23 22:10:51.640959	2020-10-23 22:10:51.640959
458	6	10	54	4	\N	2015-09-27	1000.00	c90fe2651db8f9cf13b9e37bc8add720	2020-10-23 22:10:51.642123	2020-10-23 22:10:51.642123
459	1	10	54	3	\N	2015-09-28	-500.00	bc2dd5c0c70cd37500f38ca9b0570e7e	2020-10-23 22:10:51.643262	2020-10-23 22:10:51.643262
460	1	10	54	3	\N	2015-09-28	-1500.00	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:51.645083	2020-10-23 22:10:51.645083
461	1	10	54	3	\N	2015-09-28	-1500.00	109a0ca3bc27f3e96597370d5c8cf03d	2020-10-23 22:10:51.646311	2020-10-23 22:10:51.646311
462	3	10	54	4	\N	2015-09-28	200.00	cfd2df1b818260f12a37dd9b527193c3	2020-10-23 22:10:51.647627	2020-10-23 22:10:51.647627
463	3	10	54	4	\N	2015-09-28	4000.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:10:51.649132	2020-10-23 22:10:51.649132
464	1	10	54	3	\N	2015-09-28	-200.00	628cc8fc94ab4adad79e586b32c479ca	2020-10-23 22:10:51.650425	2020-10-23 22:10:51.650425
465	1	10	54	3	\N	2015-09-28	-4000.00	ea20a043c08f5168d4409ff4144f32e2	2020-10-23 22:10:51.652169	2020-10-23 22:10:51.652169
466	6	10	54	4	\N	2015-09-28	1500.00	63dc7ed1010d3c3b8269faf0ba7491d4	2020-10-23 22:10:51.653477	2020-10-23 22:10:51.653477
467	2	1	-1	2	\N	2015-09-25	-29.00	20aee3a5f4643755a79ee5f6a73050ac	2020-10-23 22:10:51.6547	2020-10-23 22:10:51.6547
468	2	8	41	2	\N	2015-09-24	-30.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:51.65581	2020-10-23 22:10:51.65581
469	5	4	16	2	\N	2015-09-28	-49.90	5b8a7b498ef844e4fe6ad6b57f6ecab7	2020-10-23 22:10:51.657056	2020-10-23 22:10:51.657056
470	2	4	18	2	\N	2015-09-29	-40.60	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:51.65819	2020-10-23 22:10:51.65819
471	1	1	-1	2	\N	2015-09-29	-8.82	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:10:51.659267	2020-10-23 22:10:51.659267
472	1	1	-1	2	\N	2015-09-29	-3.85	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:10:51.660262	2020-10-23 22:10:51.660262
473	2	2	3	1	\N	2015-09-29	6500.60	10e1b7ca0d760d5be46a3d3798e6953d	2020-10-23 22:10:51.661285	2020-10-23 22:10:51.661285
474	2	10	54	3	\N	2015-09-29	-1500.00	53e3a7161e428b65688f14b84d61c610	2020-10-23 22:10:51.662305	2020-10-23 22:10:51.662305
475	5	10	54	4	\N	2015-09-29	1500.00	53e3a7161e428b65688f14b84d61c610	2020-10-23 22:10:51.663356	2020-10-23 22:10:51.663356
476	1	4	17	2	\N	2015-09-29	-68.00	7826581883e86855213a04c3a6f6c7aa	2020-10-23 22:10:51.664342	2020-10-23 22:10:51.664342
477	1	9	48	2	\N	2015-09-29	-5.00	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:10:51.665364	2020-10-23 22:10:51.665364
478	1	1	-1	2	\N	2015-09-29	-21.79	4e17f800ea5ef44af240ef0115a07210	2020-10-23 22:10:51.666415	2020-10-23 22:10:51.666415
479	1	1	-1	2	\N	2015-09-29	-24.00	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:51.667504	2020-10-23 22:10:51.667504
480	5	2	-1	4	\N	2015-11-01	1500.00	3493894fa4ea036cfc6433c3e2ee63b0	2020-10-23 22:10:51.668696	2020-10-23 22:10:51.668696
481	1	8	41	2	\N	2015-11-01	-64.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:51.669715	2020-10-23 22:10:51.669715
482	5	8	45	2	\N	2015-11-03	-23.00	bfcecaaa7ef0ca1faaf82eeed09ade80	2020-10-23 22:10:51.670845	2020-10-23 22:10:51.670845
483	5	5	23	2	\N	2015-11-03	-25.80	d516b13671a4179d9b7b458a6ebdeb92	2020-10-23 22:10:51.672029	2020-10-23 22:10:51.672029
484	2	9	-1	2	\N	2015-11-03	-12.00	56d59b9a55b4aaf7072b9a4d77bd24a3	2020-10-23 22:10:51.673777	2020-10-23 22:10:51.673777
485	5	9	48	2	\N	2015-11-03	-48.00	a5fb920139997fc286c0f7c25734279c	2020-10-23 22:10:51.675019	2020-10-23 22:10:51.675019
486	1	8	45	2	\N	2015-11-05	-21.00	e2d0b388cca1286ab322c788dbfed4ef	2020-10-23 22:10:51.676029	2020-10-23 22:10:51.676029
487	1	1	-1	2	\N	2015-11-05	-5.69	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:51.677312	2020-10-23 22:10:51.677312
488	5	8	42	2	\N	2015-11-05	-20.00	af127a0b31ade0e5dbd4c8cb4c3094b8	2020-10-23 22:10:51.678306	2020-10-23 22:10:51.678306
489	5	5	22	2	\N	2015-11-05	-330.00	7b77c1df2b9373962dd65d98afeca3d8	2020-10-23 22:10:51.679356	2020-10-23 22:10:51.679356
490	1	8	40	2	\N	2015-11-05	-3.70	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:10:51.680346	2020-10-23 22:10:51.680346
491	5	8	43	2	\N	2015-11-07	-14.99	f803dfeb3583d5099a58a7478f28bd75	2020-10-23 22:10:51.68139	2020-10-23 22:10:51.68139
492	5	1	-1	2	\N	2015-11-07	-60.02	826be7ff2c26e5fcc1481c7de183d948	2020-10-23 22:10:51.682463	2020-10-23 22:10:51.682463
493	5	8	43	2	\N	2015-11-07	-59.99	3cf166c6b73f030b4f67eeaeba301103	2020-10-23 22:10:51.68373	2020-10-23 22:10:51.68373
494	5	9	48	2	\N	2015-11-07	-14.90	fe292c59c55768f7b35ec393e249760e	2020-10-23 22:10:51.685366	2020-10-23 22:10:51.685366
495	2	1	-1	2	\N	2015-11-05	-11.00	105e6038d3f668c538d4f678e477543c	2020-10-23 22:10:51.686462	2020-10-23 22:10:51.686462
496	2	6	27	2	\N	2015-11-07	-445.79	5be372d4352c9807436913fcd665e652	2020-10-23 22:10:51.687665	2020-10-23 22:10:51.687665
497	5	1	-1	2	\N	2015-11-08	-24.62	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:51.688858	2020-10-23 22:10:51.688858
498	2	6	27	1	\N	2015-11-09	291.86	2149cefa3e311a70096f04e17f4aa5c8	2020-10-23 22:10:51.689899	2020-10-23 22:10:51.689899
499	2	6	27	2	\N	2015-11-09	-25.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:51.69127	2020-10-23 22:10:51.69127
500	2	5	21	2	\N	2015-11-09	-39.46	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:51.692314	2020-10-23 22:10:51.692314
501	1	1	-1	2	\N	2015-11-11	-5.00	c8c41c4a18675a74e01c8a20e8a0f662	2020-10-23 22:10:51.693399	2020-10-23 22:10:51.693399
502	1	1	-1	2	\N	2015-11-11	-10.00	2a097c8e4ebabb754f6e346bedd967b4	2020-10-23 22:10:51.694459	2020-10-23 22:10:51.694459
503	5	8	43	2	\N	2015-11-10	-120.40	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:51.695524	2020-10-23 22:10:51.695524
504	5	1	-1	2	\N	2015-11-07	-10.93	4e17f800ea5ef44af240ef0115a07210	2020-10-23 22:10:51.696669	2020-10-23 22:10:51.696669
505	1	5	25	2	\N	2015-11-09	-40.00	556f391937dfd4398cbac35e050a2177	2020-10-23 22:10:51.697805	2020-10-23 22:10:51.697805
506	1	1	-1	2	\N	2015-11-11	-43.00	83e1a2761dbec035ee3d11d05cf161eb	2020-10-23 22:10:51.699163	2020-10-23 22:10:51.699163
507	1	1	11	2	\N	2015-11-10	-4.89	9b8619251a19057cff70779273e95aa6	2020-10-23 22:10:51.70028	2020-10-23 22:10:51.70028
508	1	9	-1	2	\N	2015-11-11	-2.00	8c9611718f0422ac8dd0baf0903d22e5	2020-10-23 22:10:51.701456	2020-10-23 22:10:51.701456
509	1	5	21	2	\N	2015-11-09	-80.63	9e94b15ed312fa42232fd87a55db0d39	2020-10-23 22:10:51.702582	2020-10-23 22:10:51.702582
510	1	8	41	2	\N	2015-11-11	-26.40	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:51.703768	2020-10-23 22:10:51.703768
511	1	1	-1	2	\N	2015-11-12	-7.90	4e17f800ea5ef44af240ef0115a07210	2020-10-23 22:10:51.705107	2020-10-23 22:10:51.705107
512	1	1	-1	2	\N	2015-11-12	-143.75	d7207860598dc597770e93d8b42b44dd	2020-10-23 22:10:51.706254	2020-10-23 22:10:51.706254
513	1	6	27	2	\N	2015-11-12	-19.99	5fe8a1fd7ab33a21e76fb8429d31b0e7	2020-10-23 22:10:51.707341	2020-10-23 22:10:51.707341
514	3	9	-1	3	\N	2015-11-12	-1000.00	fc49306d97602c8ed1be1dfbf0835ead	2020-10-23 22:10:51.708453	2020-10-23 22:10:51.708453
515	1	9	-1	4	\N	2015-11-12	1000.00	fc49306d97602c8ed1be1dfbf0835ead	2020-10-23 22:10:51.709562	2020-10-23 22:10:51.709562
516	5	8	43	2	\N	2015-11-15	-150.29	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:10:51.710658	2020-10-23 22:10:51.710658
517	1	1	-1	2	\N	2015-11-13	-19.00	329b07e46fdaa0ad1f851729d49524f8	2020-10-23 22:10:51.711842	2020-10-23 22:10:51.711842
518	1	1	-1	2	\N	2015-11-13	-36.00	0605032afdb4bb8cdc5e3e969c33d1dd	2020-10-23 22:10:51.713193	2020-10-23 22:10:51.713193
519	1	1	11	2	\N	2015-11-15	-2.29	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:51.714349	2020-10-23 22:10:51.714349
520	2	2	-1	1	\N	2015-11-16	700.00	362e80d4df43b03ae6d3f8540cd63626	2020-10-23 22:10:51.715483	2020-10-23 22:10:51.715483
521	2	1	-1	2	\N	2015-11-16	-5.90	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.716526	2020-10-23 22:10:51.716526
522	2	4	16	2	\N	2015-11-16	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:51.717789	2020-10-23 22:10:51.717789
523	2	10	54	3	\N	2015-11-16	-500.00	8f468c873a32bb0619eaeb2050ba45d1	2020-10-23 22:10:51.719104	2020-10-23 22:10:51.719104
524	4	10	54	4	\N	2015-11-16	500.00	8f468c873a32bb0619eaeb2050ba45d1	2020-10-23 22:10:51.720219	2020-10-23 22:10:51.720219
525	2	1	-1	2	\N	2015-11-17	-44.40	698d51a19d8a121ce581499d7b701668	2020-10-23 22:10:51.721437	2020-10-23 22:10:51.721437
526	5	1	-1	2	\N	2015-11-17	-6.84	e316443f25fef1e9ebf48b221dc41b28	2020-10-23 22:10:51.722561	2020-10-23 22:10:51.722561
527	5	1	-1	2	\N	2015-11-18	-73.80	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.723688	2020-10-23 22:10:51.723688
528	5	1	-1	2	\N	2015-11-18	-16.19	0f28b5d49b3020afeecd95b4009adf4c	2020-10-23 22:10:51.72491	2020-10-23 22:10:51.72491
529	5	5	22	2	\N	2015-11-19	-200.00	5718f60276889792dc022b1d3dba7cd4	2020-10-23 22:10:51.725982	2020-10-23 22:10:51.725982
530	5	1	-1	2	\N	2015-11-19	-12.70	8f5be278a4c0d9ce39df64e37e6e1202	2020-10-23 22:10:51.727379	2020-10-23 22:10:51.727379
531	5	1	-1	2	\N	2015-11-19	-6.30	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:10:51.728435	2020-10-23 22:10:51.728435
532	5	5	23	2	\N	2015-11-20	-110.30	fbe851c6ccc3960273f4f7caf5dc4c57	2020-10-23 22:10:51.729526	2020-10-23 22:10:51.729526
533	2	5	23	2	\N	2015-11-20	-39.90	c7c43d863d4491c8aa4668fa12bdf60a	2020-10-23 22:10:51.730563	2020-10-23 22:10:51.730563
534	5	6	27	2	\N	2015-11-20	-16.00	f144614f14c11f8493449e44ecb7559c	2020-10-23 22:10:51.731624	2020-10-23 22:10:51.731624
535	2	1	-1	2	\N	2015-11-20	-3.20	66982b1fe4aa3f560148700f092acc21	2020-10-23 22:10:51.732828	2020-10-23 22:10:51.732828
536	2	8	44	2	\N	2015-11-21	-20.00	ab0eefe4e22456520006f254adf1947a	2020-10-23 22:10:51.733928	2020-10-23 22:10:51.733928
537	2	1	-1	2	\N	2015-11-21	-9.32	43289cd437c0341064d1d20424e7bf84	2020-10-23 22:10:51.735076	2020-10-23 22:10:51.735076
538	2	9	-1	2	\N	2015-11-21	-39.00	50c3d7614917b24303ee6a220679dab3	2020-10-23 22:10:51.736174	2020-10-23 22:10:51.736174
539	5	5	23	2	\N	2015-11-23	-35.47	a1d6b81e36f848d69fb657d79d2693c4	2020-10-23 22:10:51.737302	2020-10-23 22:10:51.737302
540	2	1	-1	2	\N	2015-11-23	-10.77	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:51.738451	2020-10-23 22:10:51.738451
541	5	1	-1	2	\N	2015-11-23	-9.03	e316443f25fef1e9ebf48b221dc41b28	2020-10-23 22:10:51.739937	2020-10-23 22:10:51.739937
542	2	8	41	2	\N	2015-11-23	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:51.741447	2020-10-23 22:10:51.741447
543	2	1	-1	2	\N	2015-11-26	-7.98	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:51.742925	2020-10-23 22:10:51.742925
544	2	1	-1	2	\N	2015-11-26	-3.90	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.74422	2020-10-23 22:10:51.74422
545	5	1	-1	2	\N	2015-11-26	-19.17	3644a684f98ea8fe223c713b77189a77	2020-10-23 22:10:51.745511	2020-10-23 22:10:51.745511
546	5	5	23	2	\N	2015-11-27	-78.40	d68005ccf362b82d084551b6291792a3	2020-10-23 22:10:51.74724	2020-10-23 22:10:51.74724
547	5	5	23	2	\N	2015-11-27	-21.99	c132f9f93de9e5b0e503bade367b4817	2020-10-23 22:10:51.748611	2020-10-23 22:10:51.748611
548	5	5	21	2	\N	2015-11-27	-39.17	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:51.749936	2020-10-23 22:10:51.749936
549	5	1	-1	2	\N	2015-11-28	-54.97	7380ad8a673226ae47fce7bff88e9c33	2020-10-23 22:10:51.751786	2020-10-23 22:10:51.751786
550	1	1	11	2	\N	2015-11-27	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.753498	2020-10-23 22:10:51.753498
551	1	1	-1	2	\N	2015-11-28	-17.00	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:51.755342	2020-10-23 22:10:51.755342
552	1	1	-1	2	\N	2015-11-21	-20.00	2a9ced3967f417a7877cc296438e6fb4	2020-10-23 22:10:51.756859	2020-10-23 22:10:51.756859
553	1	1	-1	2	\N	2015-11-21	-68.00	182a2e5271287357ea1966e47f0b427d	2020-10-23 22:10:51.758581	2020-10-23 22:10:51.758581
554	1	1	-1	2	\N	2015-11-21	-44.00	f1c1592588411002af340cbaedd6fc33	2020-10-23 22:10:51.760221	2020-10-23 22:10:51.760221
555	1	1	11	2	\N	2015-11-21	-18.95	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:10:51.761569	2020-10-23 22:10:51.761569
556	1	1	-1	2	\N	2015-11-25	-2.45	bff82d18862ce94df14bdee55295f812	2020-10-23 22:10:51.763045	2020-10-23 22:10:51.763045
557	1	1	-1	2	\N	2015-11-25	-10.04	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.764623	2020-10-23 22:10:51.764623
558	5	1	-1	2	\N	2015-11-25	-11.13	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.766103	2020-10-23 22:10:51.766103
559	5	1	-1	2	\N	2015-11-25	-64.39	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:51.767577	2020-10-23 22:10:51.767577
560	1	1	11	2	\N	2015-11-25	-35.28	8f85517967795eeef66c225f7883bdcb	2020-10-23 22:10:51.769186	2020-10-23 22:10:51.769186
561	1	2	3	1	\N	2015-11-27	7267.40	b12717ae6e6bc7077b723fc50d4fadfd	2020-10-23 22:10:51.770474	2020-10-23 22:10:51.770474
562	1	10	54	3	\N	2015-11-28	-500.00	105d2e8ca45f93a6eb40a48fc3447d92	2020-10-23 22:10:51.771883	2020-10-23 22:10:51.771883
563	1	10	54	3	\N	2015-11-28	-1850.00	da3c56867333df0fff5655eac38d0630	2020-10-23 22:10:51.773355	2020-10-23 22:10:51.773355
564	1	10	54	3	\N	2015-11-28	-1500.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:51.774732	2020-10-23 22:10:51.774732
565	6	10	54	4	\N	2015-11-28	1500.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:51.776162	2020-10-23 22:10:51.776162
566	1	8	41	2	\N	2015-11-28	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:51.777584	2020-10-23 22:10:51.777584
567	2	2	3	1	\N	2015-11-28	5266.94	a36084f1119b4e3d9143b303baec52c2	2020-10-23 22:10:51.779219	2020-10-23 22:10:51.779219
568	2	10	54	3	\N	2015-11-28	-1500.00	3cec07e9ba5f5bb252d13f5f431e4bbb	2020-10-23 22:10:51.781127	2020-10-23 22:10:51.781127
569	6	10	54	4	\N	2015-11-28	1500.00	a51420eb80ca6b315990764935e93a93	2020-10-23 22:10:51.782416	2020-10-23 22:10:51.782416
570	2	10	54	3	\N	2015-11-28	-1500.00	860e624684b1fc1da4ea84e9fc28fc80	2020-10-23 22:10:51.784041	2020-10-23 22:10:51.784041
571	5	10	54	4	\N	2015-11-28	1500.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:51.785572	2020-10-23 22:10:51.785572
572	2	4	18	2	\N	2015-11-28	-42.54	5dd033d162065873ffdfa5c0ec597932	2020-10-23 22:10:51.787138	2020-10-23 22:10:51.787138
573	2	10	54	3	\N	2015-11-29	-1500.00	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:10:51.788745	2020-10-23 22:10:51.788745
574	4	10	54	4	\N	2015-11-29	1500.00	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:10:51.790147	2020-10-23 22:10:51.790147
575	5	4	13	2	\N	2015-11-29	-327.77	bd73aee5e8328c6fbfbede30a0003aa2	2020-10-23 22:10:51.792153	2020-10-23 22:10:51.792153
576	5	4	15	2	\N	2015-11-29	-126.36	3c7781a36bcd6cf08c11a970fbe0e2a6	2020-10-23 22:10:51.793781	2020-10-23 22:10:51.793781
577	5	4	14	2	\N	2015-11-29	-99.00	11b9842e0a271ff252c1903e7132cd68	2020-10-23 22:10:51.795544	2020-10-23 22:10:51.795544
578	2	5	21	2	\N	2015-11-30	-23.57	6421d6f2b699564d0160c4b6708fab18	2020-10-23 22:10:51.796908	2020-10-23 22:10:51.796908
579	2	1	-1	2	\N	2015-11-30	-6.50	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.798586	2020-10-23 22:10:51.798586
580	5	1	-1	2	\N	2015-11-30	0.00	0bb4aec1710521c12ee76289d9440817	2020-10-23 22:10:51.800047	2020-10-23 22:10:51.800047
581	1	8	44	2	\N	2015-11-30	-5.00	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:10:51.801992	2020-10-23 22:10:51.801992
582	1	1	11	2	\N	2015-11-30	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.803762	2020-10-23 22:10:51.803762
583	1	9	48	2	\N	2015-11-30	-50.00	043c3d7e489c69b48737cc0c92d0f3a2	2020-10-23 22:10:51.805257	2020-10-23 22:10:51.805257
584	1	9	48	2	\N	2015-11-30	-20.00	dfcba9f21bb5b1e8a8980caa5f9972d1	2020-10-23 22:10:51.806496	2020-10-23 22:10:51.806496
585	1	10	54	3	\N	2015-11-30	-3500.00	4fbda18b0514e1467ce010763b9f863d	2020-10-23 22:10:51.807867	2020-10-23 22:10:51.807867
586	3	10	54	4	\N	2015-11-30	3500.00	4fbda18b0514e1467ce010763b9f863d	2020-10-23 22:10:51.809438	2020-10-23 22:10:51.809438
587	5	10	54	4	\N	2015-12-02	1500.00	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:51.810712	2020-10-23 22:10:51.810712
588	5	1	-1	2	\N	2015-12-01	-69.53	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:51.812123	2020-10-23 22:10:51.812123
589	5	5	23	2	\N	2015-12-01	-25.97	d95e2c39a6dbe37024c0ab91c3df4495	2020-10-23 22:10:51.813579	2020-10-23 22:10:51.813579
590	2	4	18	2	\N	2015-12-01	-44.51	e76a2f0f39106e5e833f1323866171d4	2020-10-23 22:10:51.814998	2020-10-23 22:10:51.814998
591	2	9	48	2	\N	2015-12-03	-70.10	5cfcf4431b67fb31985285f1572d6370	2020-10-23 22:10:51.816276	2020-10-23 22:10:51.816276
592	5	6	27	2	\N	2015-12-03	-38.90	53e7b8af5060acd10033824d91de35df	2020-10-23 22:10:51.818535	2020-10-23 22:10:51.818535
593	5	5	23	2	\N	2015-12-03	-21.52	af7df3a1c9e4ebec19d3fdab40d430a5	2020-10-23 22:10:51.82039	2020-10-23 22:10:51.82039
594	5	6	27	2	\N	2015-12-03	-9.90	4c3d79f13232bd5220b99f59e60210a2	2020-10-23 22:10:51.821732	2020-10-23 22:10:51.821732
595	5	5	23	2	\N	2015-12-04	-16.06	2a36d30082b96c3bb0081bf7e2d6762a	2020-10-23 22:10:51.823009	2020-10-23 22:10:51.823009
596	2	1	-1	2	\N	2015-12-04	-11.08	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:51.824153	2020-10-23 22:10:51.824153
597	2	9	48	2	\N	2015-12-03	-34.80	0195adcd3a2ab89a85c7427332844257	2020-10-23 22:10:51.825246	2020-10-23 22:10:51.825246
598	2	6	27	2	\N	2015-12-07	-6.00	1dbec22a9befca7676c6378e1d97c909	2020-10-23 22:10:51.826328	2020-10-23 22:10:51.826328
599	5	1	-1	2	\N	2015-12-07	-24.75	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:10:51.827699	2020-10-23 22:10:51.827699
600	2	1	-1	2	\N	2015-12-05	-10.00	04ecb1fa28506ccb6f72b12c0245ddbc	2020-10-23 22:10:51.828893	2020-10-23 22:10:51.828893
601	2	5	21	2	\N	2015-12-08	-11.88	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:51.830077	2020-10-23 22:10:51.830077
602	5	5	23	2	\N	2015-12-09	-14.99	515633118366a8bd9aec1e889189897d	2020-10-23 22:10:51.831395	2020-10-23 22:10:51.831395
603	2	1	-1	2	\N	2015-12-09	-7.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.832645	2020-10-23 22:10:51.832645
604	5	5	23	2	\N	2015-12-10	-102.68	df2aa5111f6e4eff7d335824974ba840	2020-10-23 22:10:51.8341	2020-10-23 22:10:51.8341
605	1	5	23	2	\N	2015-12-09	-20.00	ca4b2ccf7faf05cc949e973fd82e89ef	2020-10-23 22:10:51.835621	2020-10-23 22:10:51.835621
606	1	1	11	2	\N	2015-12-10	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.837202	2020-10-23 22:10:51.837202
607	1	1	11	2	\N	2015-12-05	-1.80	eae27d77ca20db309e056e3d2dcd7d69	2020-10-23 22:10:51.838556	2020-10-23 22:10:51.838556
608	1	1	11	2	\N	2015-12-10	-5.40	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:10:51.839802	2020-10-23 22:10:51.839802
609	1	1	11	2	\N	2015-12-10	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:51.841111	2020-10-23 22:10:51.841111
610	1	9	48	2	\N	2015-12-04	-83.75	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:51.842467	2020-10-23 22:10:51.842467
611	1	1	-1	2	\N	2015-12-10	-72.00	a44987440c0b9efdbd270eb6e4afe279	2020-10-23 22:10:51.844121	2020-10-23 22:10:51.844121
612	1	9	48	2	\N	2015-12-14	-10.00	d17eca2e1a1943fe407399a43ddf65be	2020-10-23 22:10:51.845714	2020-10-23 22:10:51.845714
613	1	9	48	2	\N	2015-12-04	-149.00	1126bfbd706f9d266b5ea43033f0dce7	2020-10-23 22:10:51.847423	2020-10-23 22:10:51.847423
614	1	1	-1	2	\N	2015-12-06	-3.85	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:51.848901	2020-10-23 22:10:51.848901
615	1	1	-1	2	\N	2015-12-02	-3.55	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.850383	2020-10-23 22:10:51.850383
616	1	9	-1	2	\N	2015-12-13	-2.00	a0f6d0244be79da7040362bf43e9af46	2020-10-23 22:10:51.851911	2020-10-23 22:10:51.851911
617	1	9	48	2	\N	2015-12-12	-59.00	6c7d0acef32a64a17a3f2a789ce0d712	2020-10-23 22:10:51.853315	2020-10-23 22:10:51.853315
618	5	9	48	2	\N	2015-12-13	-100.00	ac41056e786c290c1c44c3b54e047a0e	2020-10-23 22:10:51.85462	2020-10-23 22:10:51.85462
619	5	1	-1	2	\N	2015-12-13	-15.80	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:51.856053	2020-10-23 22:10:51.856053
620	1	1	-1	2	\N	2015-12-12	-6.50	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:10:51.857339	2020-10-23 22:10:51.857339
621	5	1	-1	2	\N	2015-12-12	-63.14	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:51.859233	2020-10-23 22:10:51.859233
622	5	1	-1	2	\N	2015-12-05	-269.76	441954d29ad2a375cef8ea524a2c7e73	2020-10-23 22:10:51.860716	2020-10-23 22:10:51.860716
623	2	9	48	2	\N	2015-12-13	-15.00	ac41056e786c290c1c44c3b54e047a0e	2020-10-23 22:10:51.862056	2020-10-23 22:10:51.862056
624	2	4	16	2	\N	2015-12-13	-19.99	200787e659fed405fb4e546c46ecab7e	2020-10-23 22:10:51.86322	2020-10-23 22:10:51.86322
625	1	7	36	2	\N	2015-12-09	-4.92	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.86437	2020-10-23 22:10:51.86437
626	3	10	54	3	\N	2015-12-13	-9500.00	fc49306d97602c8ed1be1dfbf0835ead	2020-10-23 22:10:51.865496	2020-10-23 22:10:51.865496
627	1	10	54	4	\N	2015-12-13	9500.00	fc49306d97602c8ed1be1dfbf0835ead	2020-10-23 22:10:51.86666	2020-10-23 22:10:51.86666
628	1	9	49	2	\N	2015-12-13	-3404.36	a1f73568850e480e957b52e8952e8a4e	2020-10-23 22:10:51.868124	2020-10-23 22:10:51.868124
629	5	9	48	2	\N	2015-12-14	-12.50	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:10:51.869651	2020-10-23 22:10:51.869651
630	5	9	48	2	\N	2015-12-15	-124.99	705b43ec76ace9c2438a028f26695c7d	2020-10-23 22:10:51.871011	2020-10-23 22:10:51.871011
631	2	9	48	2	\N	2015-12-15	-181.95	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:10:51.872356	2020-10-23 22:10:51.872356
632	5	1	-1	2	\N	2015-12-17	-14.65	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:51.873792	2020-10-23 22:10:51.873792
633	2	8	41	2	\N	2015-12-17	-55.60	2e176c4d6ea6098643f4c1bd757f7c17	2020-10-23 22:10:51.875133	2020-10-23 22:10:51.875133
634	2	9	48	2	\N	2015-12-17	-7.99	45e8fd5a6446d053f397ccfc43aa736b	2020-10-23 22:10:51.876799	2020-10-23 22:10:51.876799
635	2	9	48	2	\N	2015-12-17	-49.00	e96ed478dab8595a7dbda4cbcbee168f	2020-10-23 22:10:51.878266	2020-10-23 22:10:51.878266
636	2	9	48	2	\N	2015-12-17	-100.00	dc912a253d1e9ba40e2c597ed2376640	2020-10-23 22:10:51.880241	2020-10-23 22:10:51.880241
637	5	1	-1	2	\N	2015-12-18	-102.50	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:10:51.881635	2020-10-23 22:10:51.881635
638	2	9	48	2	\N	2015-12-18	-5.60	77c80e9139a0621d8c7d6430cd0dead7	2020-10-23 22:10:51.883419	2020-10-23 22:10:51.883419
639	2	8	44	2	\N	2015-12-18	-17.00	648ea973c3ba48397fcd70b55711c516	2020-10-23 22:10:51.885278	2020-10-23 22:10:51.885278
640	2	1	-1	2	\N	2015-12-18	-10.00	23ba2ed5b71203f23816c81b0f2d1a17	2020-10-23 22:10:51.887145	2020-10-23 22:10:51.887145
641	2	9	48	2	\N	2015-12-19	-43.56	0f7db25642f061a1d37eee6ff70763e7	2020-10-23 22:10:51.888556	2020-10-23 22:10:51.888556
642	5	5	23	2	\N	2015-12-19	-75.05	99a7dd8f21187921b3b62d328a98a10e	2020-10-23 22:10:51.890267	2020-10-23 22:10:51.890267
643	2	1	-1	2	\N	2015-12-19	-24.70	e08cfc1931e7d947c2ca48ffef4997b6	2020-10-23 22:10:51.891516	2020-10-23 22:10:51.891516
644	5	1	-1	2	\N	2015-12-20	-8.80	43d39b10627d301292d4333d225411fb	2020-10-23 22:10:51.892625	2020-10-23 22:10:51.892625
645	1	9	49	2	\N	2015-12-18	-9.00	88ff290c640d1ec9372faef19206de9d	2020-10-23 22:10:51.893744	2020-10-23 22:10:51.893744
646	1	9	48	2	\N	2015-12-18	-15.00	d5afa6023ce591ac94b0b60aaea014f3	2020-10-23 22:10:51.89511	2020-10-23 22:10:51.89511
647	1	1	-1	2	\N	2015-12-18	-10.99	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:51.89643	2020-10-23 22:10:51.89643
648	1	1	-1	2	\N	2015-12-16	-19.00	a86c450b76fb8c371afead6410d55534	2020-10-23 22:10:51.897902	2020-10-23 22:10:51.897902
649	1	1	11	2	\N	2015-12-17	-2.00	3a080b2a2f11ddee1a665fb9807eec24	2020-10-23 22:10:51.899161	2020-10-23 22:10:51.899161
650	1	2	3	1	\N	2015-12-21	7751.72	588d4c8022a1b06da847986d79070391	2020-10-23 22:10:51.900524	2020-10-23 22:10:51.900524
651	1	10	54	3	\N	2015-12-21	-1850.00	a1ce56bcfdf6db7c5f1754aa6be841aa	2020-10-23 22:10:51.902686	2020-10-23 22:10:51.902686
652	1	10	54	3	\N	2015-12-21	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:51.904447	2020-10-23 22:10:51.904447
653	1	10	54	3	\N	2015-12-21	-1500.00	ea95a7d80f83fc61f9f153f2638ea853	2020-10-23 22:10:51.906237	2020-10-23 22:10:51.906237
654	6	10	54	4	\N	2015-12-21	1500.00	ea95a7d80f83fc61f9f153f2638ea853	2020-10-23 22:10:51.908091	2020-10-23 22:10:51.908091
655	1	9	48	2	\N	2015-12-21	-1400.00	5dbc295d04f3c435382da0c7b0432233	2020-10-23 22:10:51.909838	2020-10-23 22:10:51.909838
656	1	9	-1	2	\N	2015-12-21	-25.00	7378bfed68f89ff95e4c60884628cb16	2020-10-23 22:10:51.911389	2020-10-23 22:10:51.911389
657	2	2	-1	1	\N	2015-12-21	1400.00	5dbc295d04f3c435382da0c7b0432233	2020-10-23 22:10:51.913151	2020-10-23 22:10:51.913151
658	2	2	3	1	\N	2015-12-22	5236.37	221224ce11e0a18d951cd5b892a3d8b6	2020-10-23 22:10:51.914439	2020-10-23 22:10:51.914439
659	2	10	54	3	\N	2015-12-22	-1500.00	323839261ec89d64d6fa6eca9afe5195	2020-10-23 22:10:51.91586	2020-10-23 22:10:51.91586
660	5	10	54	4	\N	2015-12-22	1500.00	09bfd314c8db44c57bfe59c337854adf	2020-10-23 22:10:51.917391	2020-10-23 22:10:51.917391
661	2	10	54	3	\N	2015-12-22	-1500.00	2ab394d20a8e880e7dbcc56dee903e4a	2020-10-23 22:10:51.919091	2020-10-23 22:10:51.919091
662	6	10	54	4	\N	2015-12-22	1500.00	a2799841174715c92b7742c188a0bf60	2020-10-23 22:10:51.920417	2020-10-23 22:10:51.920417
663	5	1	-1	2	\N	2015-12-21	-5.50	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:51.921813	2020-10-23 22:10:51.921813
664	2	6	27	2	\N	2015-12-22	-50.00	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:10:51.923189	2020-10-23 22:10:51.923189
665	5	9	48	2	\N	2015-12-22	-32.60	359de4a25a64387a87452c97aaf61715	2020-10-23 22:10:51.924795	2020-10-23 22:10:51.924795
666	5	4	13	2	\N	2015-12-22	-327.77	042c621a0c2ddb031679e3537092cb21	2020-10-23 22:10:51.926295	2020-10-23 22:10:51.926295
667	5	4	15	2	\N	2015-12-22	-126.36	f1e2b2e2fd7e4e5873065d4ba583f51e	2020-10-23 22:10:51.928126	2020-10-23 22:10:51.928126
668	1	1	-1	2	\N	2015-12-22	-15.09	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:51.929546	2020-10-23 22:10:51.929546
669	1	1	-1	2	\N	2015-12-22	-12.00	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.930938	2020-10-23 22:10:51.930938
670	5	4	16	2	\N	2015-12-22	-49.90	3e9b58be0c3a8720f3942b3aafc74791	2020-10-23 22:10:51.932169	2020-10-23 22:10:51.932169
671	5	8	43	2	\N	2015-12-23	-154.33	d79aac075930c83c2f1e369a511148fe	2020-10-23 22:10:51.933434	2020-10-23 22:10:51.933434
672	5	1	-1	2	\N	2015-12-23	-6.48	95a65875daa3da360c3c9232671922a9	2020-10-23 22:10:51.935429	2020-10-23 22:10:51.935429
673	1	1	-1	2	\N	2015-12-24	-86.53	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:51.936836	2020-10-23 22:10:51.936836
674	5	8	45	2	\N	2015-12-28	-64.00	dfdd3c92684920b99831888d469e70cd	2020-10-23 22:10:51.938306	2020-10-23 22:10:51.938306
675	1	7	35	2	\N	2015-12-28	-55.00	a8a94eee03e271f865dbf8cdbeb0129d	2020-10-23 22:10:51.939859	2020-10-23 22:10:51.939859
676	1	1	-1	2	\N	2015-12-26	-60.50	6a962dce5e813db299d4120ac1a4cf8b	2020-10-23 22:10:51.941869	2020-10-23 22:10:51.941869
677	1	1	-1	2	\N	2015-12-25	-11.98	c192e5e089b6fc7e5c5c890e4842810b	2020-10-23 22:10:51.943738	2020-10-23 22:10:51.943738
678	5	7	30	1	\N	2015-12-28	1000.00	6d4a60c0cdc04146a1ef2c56caf03d80	2020-10-23 22:10:51.945282	2020-10-23 22:10:51.945282
679	6	7	30	2	\N	2015-12-28	-1000.00	6d4a60c0cdc04146a1ef2c56caf03d80	2020-10-23 22:10:51.94673	2020-10-23 22:10:51.94673
680	5	7	30	2	\N	2015-12-28	-2186.90	dbe862ab956bf427794f823487d61816	2020-10-23 22:10:51.948701	2020-10-23 22:10:51.948701
681	5	7	30	2	\N	2015-12-28	-5.00	e1cdbda92a8167c8a6c994872fd32b3e	2020-10-23 22:10:51.950218	2020-10-23 22:10:51.950218
682	1	1	-1	2	\N	2015-12-24	-9.60	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:51.951642	2020-10-23 22:10:51.951642
683	2	4	18	2	\N	2015-12-27	-42.13	941e1aaaba585b952b62c14a3a175a61	2020-10-23 22:10:51.953016	2020-10-23 22:10:51.953016
684	5	4	16	2	\N	2015-12-27	-69.99	bf8229696f7a3bb4700cfddef19fa23f	2020-10-23 22:10:51.95438	2020-10-23 22:10:51.95438
685	2	6	27	2	\N	2015-12-28	-39.90	aad1b69cc02cd49456b00a88a0740d90	2020-10-23 22:10:51.955751	2020-10-23 22:10:51.955751
686	2	9	49	2	\N	2015-12-28	-3250.00	f79d24702a62c376e127b1ad05076af4	2020-10-23 22:10:51.957094	2020-10-23 22:10:51.957094
687	5	9	47	2	\N	2015-12-29	-40.00	28b49b2bb14fe8fbbebeb5a70ed6ea50	2020-10-23 22:10:51.958689	2020-10-23 22:10:51.958689
688	5	1	-1	2	\N	2015-12-29	-109.93	02a32ad2669e6fe298e607fe7cc0e1a0	2020-10-23 22:10:51.960186	2020-10-23 22:10:51.960186
689	1	10	54	3	\N	2015-12-29	-5000.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:10:51.961599	2020-10-23 22:10:51.961599
690	3	10	54	4	\N	2015-12-29	5000.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:10:51.963064	2020-10-23 22:10:51.963064
691	1	9	49	2	\N	2015-12-29	-2511.00	8d70912d7789d196b998e3d5728d0473	2020-10-23 22:10:51.964464	2020-10-23 22:10:51.964464
692	1	9	49	2	\N	2015-12-29	-19.00	e2230b853516e7b05d79744fbd4c9c13	2020-10-23 22:10:51.966013	2020-10-23 22:10:51.966013
693	1	9	49	2	\N	2015-12-29	-56.90	7d166a0a1471987d823d0db707d2b5d5	2020-10-23 22:10:51.967714	2020-10-23 22:10:51.967714
694	1	9	49	2	\N	2015-12-29	-31.14	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:10:51.969365	2020-10-23 22:10:51.969365
695	1	1	11	2	\N	2015-12-31	-3.30	0d1f3b0802c73b1e989b36551deb0193	2020-10-23 22:10:51.971447	2020-10-23 22:10:51.971447
696	1	1	-1	2	\N	2015-12-31	-8.49	e124b27a3a7c7426bd24ef802b8fdba4	2020-10-23 22:10:51.972935	2020-10-23 22:10:51.972935
697	1	1	-1	2	\N	2015-12-28	-4.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.974332	2020-10-23 22:10:51.974332
698	1	9	48	2	\N	2015-12-31	-25.48	3c15c83e08a3b56476864a1ab9ad3b83	2020-10-23 22:10:51.975767	2020-10-23 22:10:51.975767
699	1	1	-1	2	\N	2015-12-30	-8.00	4b56626af6238c2ff3d08e5ee9174346	2020-10-23 22:10:51.977483	2020-10-23 22:10:51.977483
700	1	9	-1	2	\N	2015-12-22	-10.68	d92b4497a67179d0484928bc89aa9e92	2020-10-23 22:10:51.979053	2020-10-23 22:10:51.979053
701	1	1	-1	2	\N	2015-12-30	-64.00	b48124b507ffb0a2ad963982010de473	2020-10-23 22:10:51.981564	2020-10-23 22:10:51.981564
702	1	5	21	2	\N	2015-12-30	-43.03	6c972c70b83e631d25ed5c43533df463	2020-10-23 22:10:51.983285	2020-10-23 22:10:51.983285
703	2	9	48	2	\N	2015-12-31	-32.36	e3dd4f68aba71df559166b99b1749fa4	2020-10-23 22:10:51.985554	2020-10-23 22:10:51.985554
704	2	9	-1	2	\N	2015-12-31	-16.79	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:51.987523	2020-10-23 22:10:51.987523
705	5	10	54	4	\N	2016-01-04	1500.00	8039b4e0e6fe78bee7d3e5cfbfa343f0	2020-10-23 22:10:51.989088	2020-10-23 22:10:51.989088
706	1	1	-1	2	\N	2016-01-01	-7.80	f9028faec74be6ec9b852b0a542e2f39	2020-10-23 22:10:51.990583	2020-10-23 22:10:51.990583
707	5	8	43	2	\N	2016-01-01	-162.60	c57b93e83112330690d8f219cab5c24d	2020-10-23 22:10:51.991924	2020-10-23 22:10:51.991924
708	1	2	3	1	\N	2016-01-04	1404.00	061412e4a03c02f9902576ec55ebbe77	2020-10-23 22:10:51.993375	2020-10-23 22:10:51.993375
709	1	10	54	3	\N	2016-01-04	-1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:51.995003	2020-10-23 22:10:51.995003
710	3	10	54	4	\N	2016-01-04	1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:51.996292	2020-10-23 22:10:51.996292
711	1	1	-1	2	\N	2016-01-04	-2.60	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:51.997709	2020-10-23 22:10:51.997709
712	1	5	21	2	\N	2016-01-07	-26.98	6c972c70b83e631d25ed5c43533df463	2020-10-23 22:10:51.999105	2020-10-23 22:10:51.999105
713	1	8	41	2	\N	2016-01-07	-49.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:52.000332	2020-10-23 22:10:52.000332
714	1	1	-1	2	\N	2016-01-07	-12.00	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.001955	2020-10-23 22:10:52.001955
715	1	9	48	2	\N	2016-01-05	-122.90	1e4725363d155960c84a94870b2b4622	2020-10-23 22:10:52.003211	2020-10-23 22:10:52.003211
716	1	1	-1	2	\N	2016-01-07	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.005327	2020-10-23 22:10:52.005327
717	2	1	-1	2	\N	2016-01-03	-11.56	b4d7fcb1aac27e05e0c3a7f456088aef	2020-10-23 22:10:52.00725	2020-10-23 22:10:52.00725
718	2	9	49	2	\N	2016-01-02	-29.00	7cd0d39652f62f1724e04b7d7b8176cd	2020-10-23 22:10:52.008689	2020-10-23 22:10:52.008689
719	2	6	27	2	\N	2016-01-02	-49.99	2fd60519570054c301d09557a2d45f9e	2020-10-23 22:10:52.01	2020-10-23 22:10:52.01
720	2	5	25	2	\N	2016-01-02	-79.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:52.011204	2020-10-23 22:10:52.011204
721	5	1	-1	2	\N	2016-01-02	-53.55	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:52.012391	2020-10-23 22:10:52.012391
722	5	1	-1	2	\N	2016-01-02	-6.94	b1c9d27f61ccd2d29637f0c0bc65c19f	2020-10-23 22:10:52.013713	2020-10-23 22:10:52.013713
723	5	8	43	2	\N	2016-01-09	-182.24	7826581883e86855213a04c3a6f6c7aa	2020-10-23 22:10:52.015506	2020-10-23 22:10:52.015506
724	1	1	-1	2	\N	2016-01-08	-4.45	815be9c5c7d37e665a99f23bbbdc345f	2020-10-23 22:10:52.016995	2020-10-23 22:10:52.016995
725	1	1	-1	2	\N	2016-01-08	-12.42	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.018525	2020-10-23 22:10:52.018525
726	5	9	48	1	\N	2016-01-08	100.00	0d9781f46cbb67b4662bdcaad87b8dc9	2020-10-23 22:10:52.020479	2020-10-23 22:10:52.020479
727	5	1	-1	2	\N	2016-01-09	-16.38	185c29dc24325934ee377cfda20e414c	2020-10-23 22:10:52.021838	2020-10-23 22:10:52.021838
728	2	1	-1	2	\N	2016-01-09	-6.80	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:10:52.023076	2020-10-23 22:10:52.023076
729	2	9	48	2	\N	2016-01-12	-87.70	7a53928fa4dd31e82c6ef826f341daec	2020-10-23 22:10:52.024268	2020-10-23 22:10:52.024268
730	2	4	16	2	\N	2016-01-12	-28.99	200787e659fed405fb4e546c46ecab7e	2020-10-23 22:10:52.025501	2020-10-23 22:10:52.025501
731	5	1	-1	2	\N	2016-01-09	-69.63	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.026717	2020-10-23 22:10:52.026717
732	5	6	27	2	\N	2016-01-14	-54.70	60df67c92429bea18195ffa8c7440a81	2020-10-23 22:10:52.027903	2020-10-23 22:10:52.027903
733	2	9	48	2	\N	2016-01-14	-29.90	704a9613f075f9dafff1a0146b76558e	2020-10-23 22:10:52.029149	2020-10-23 22:10:52.029149
734	2	6	27	1	\N	2016-01-15	50.00	3497865f828d5b3c019257c6f0fb67b2	2020-10-23 22:10:52.030403	2020-10-23 22:10:52.030403
735	2	1	-1	2	\N	2016-01-14	-13.90	f50d2c2f517a1bf37777e5c9ede37e06	2020-10-23 22:10:52.031647	2020-10-23 22:10:52.031647
736	5	5	23	2	\N	2016-01-15	-59.59	3885fb83a3d1d81e5e963af3d5427d91	2020-10-23 22:10:52.032809	2020-10-23 22:10:52.032809
737	2	5	21	2	\N	2016-01-15	-13.57	3dd48ab31d016ffcbf3314df2b3cb9ce	2020-10-23 22:10:52.034445	2020-10-23 22:10:52.034445
738	5	5	21	1	\N	2016-01-15	13.57	3dd48ab31d016ffcbf3314df2b3cb9ce	2020-10-23 22:10:52.035969	2020-10-23 22:10:52.035969
739	1	1	11	2	\N	2016-01-13	-2.00	96991368fec63c8a1bfc48a70010f84a	2020-10-23 22:10:52.037344	2020-10-23 22:10:52.037344
740	5	9	-1	2	\N	2016-01-17	-3.00	c203c6e48c98693905808b7e1c43c336	2020-10-23 22:10:52.038546	2020-10-23 22:10:52.038546
741	5	1	-1	2	\N	2016-01-14	-10.13	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:52.040015	2020-10-23 22:10:52.040015
742	5	1	-1	2	\N	2016-01-13	-6.70	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:52.041311	2020-10-23 22:10:52.041311
743	5	1	-1	2	\N	2016-01-12	-9.46	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:10:52.042415	2020-10-23 22:10:52.042415
744	5	1	-1	2	\N	2016-01-16	-73.29	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.043616	2020-10-23 22:10:52.043616
745	1	1	-1	2	\N	2016-01-11	-7.29	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:52.044887	2020-10-23 22:10:52.044887
746	1	1	-1	2	\N	2016-01-11	-3.85	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.045946	2020-10-23 22:10:52.045946
747	1	1	-1	2	\N	2016-01-11	-12.17	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:10:52.047343	2020-10-23 22:10:52.047343
748	5	1	-1	2	\N	2016-01-17	-7.99	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:10:52.048669	2020-10-23 22:10:52.048669
749	2	1	-1	2	\N	2016-01-16	-10.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.04993	2020-10-23 22:10:52.04993
750	2	8	41	2	\N	2016-01-18	-5.60	746f5a6144cf56559a2479837925c07e	2020-10-23 22:10:52.051287	2020-10-23 22:10:52.051287
751	2	8	41	2	\N	2016-01-18	-46.00	770393cee8a16a4e929504f0c6a78f78	2020-10-23 22:10:52.052822	2020-10-23 22:10:52.052822
752	2	8	41	2	\N	2016-01-19	-7.60	746f5a6144cf56559a2479837925c07e	2020-10-23 22:10:52.054038	2020-10-23 22:10:52.054038
753	5	1	-1	2	\N	2016-01-21	-120.38	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.055293	2020-10-23 22:10:52.055293
754	2	9	49	2	\N	2016-01-23	-13.00	b4a5f57bd19102a769d4eeff4de65c0c	2020-10-23 22:10:52.056559	2020-10-23 22:10:52.056559
755	1	1	-1	2	\N	2016-01-24	-86.00	e62595ee98b585153dac87ce1ab69c3c	2020-10-23 22:10:52.058158	2020-10-23 22:10:52.058158
756	1	1	-1	2	\N	2016-01-22	-4.40	ab095d255486a6e82e6e4dce89468cf5	2020-10-23 22:10:52.059482	2020-10-23 22:10:52.059482
757	1	5	25	2	\N	2016-01-23	-35.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:10:52.060837	2020-10-23 22:10:52.060837
758	1	1	-1	2	\N	2016-01-21	-12.84	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.062156	2020-10-23 22:10:52.062156
759	1	1	-1	2	\N	2016-01-22	-15.18	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.063529	2020-10-23 22:10:52.063529
760	5	1	-1	2	\N	2016-01-20	-14.70	db5e3ca8f31baa572cb64be6e74d0dba	2020-10-23 22:10:52.065086	2020-10-23 22:10:52.065086
761	1	1	-1	2	\N	2016-01-19	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.066395	2020-10-23 22:10:52.066395
762	5	4	16	2	\N	2016-01-25	-49.90	9951145db4d446ec7ace1fd924468dac	2020-10-23 22:10:52.06803	2020-10-23 22:10:52.06803
763	2	9	48	2	\N	2016-01-25	-24.80	48aedb8880cab8c45637abc7493ecddd	2020-10-23 22:10:52.069525	2020-10-23 22:10:52.069525
764	2	1	-1	2	\N	2016-01-25	-5.40	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.070929	2020-10-23 22:10:52.070929
765	2	1	-1	2	\N	2016-01-22	-7.00	1e223ec204a54a8429ef74f736f40bf6	2020-10-23 22:10:52.07207	2020-10-23 22:10:52.07207
766	5	1	-1	2	\N	2016-01-26	-16.33	872488f88d1b2db54d55bc8bba2fad1b	2020-10-23 22:10:52.07327	2020-10-23 22:10:52.07327
767	2	4	18	2	\N	2016-01-28	-42.62	1c7e8a9166ac8fa6c65824ab32f26cfd	2020-10-23 22:10:52.074632	2020-10-23 22:10:52.074632
768	2	1	-1	2	\N	2016-01-28	-8.78	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:52.076212	2020-10-23 22:10:52.076212
769	2	1	-1	2	\N	2016-01-29	-6.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.077817	2020-10-23 22:10:52.077817
770	1	2	3	1	\N	2016-01-27	8316.05	73bc0e873332c29e17e0a37afaf030e5	2020-10-23 22:10:52.079326	2020-10-23 22:10:52.079326
771	1	1	-1	2	\N	2016-01-30	-28.60	cf30c5a9bfb152765dae97cee99689f8	2020-10-23 22:10:52.080602	2020-10-23 22:10:52.080602
772	1	8	40	2	\N	2016-01-30	-2.50	56447dee63a4593608eb2b62fbdd2bcd	2020-10-23 22:10:52.081861	2020-10-23 22:10:52.081861
773	2	8	40	2	\N	2016-01-30	-4.50	56447dee63a4593608eb2b62fbdd2bcd	2020-10-23 22:10:52.083289	2020-10-23 22:10:52.083289
774	5	7	35	2	\N	2016-01-30	-50.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:52.084563	2020-10-23 22:10:52.084563
775	1	1	-1	2	\N	2016-01-29	-11.33	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:52.086232	2020-10-23 22:10:52.086232
776	1	1	-1	2	\N	2016-01-27	-4.40	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:52.08764	2020-10-23 22:10:52.08764
777	5	1	-1	2	\N	2016-01-30	-42.60	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.089216	2020-10-23 22:10:52.089216
778	1	10	54	3	\N	2016-01-30	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:52.090472	2020-10-23 22:10:52.090472
779	1	10	54	3	\N	2016-01-30	-1500.00	719b75424fd8dfc276c4da51ec8306f0	2020-10-23 22:10:52.091698	2020-10-23 22:10:52.091698
780	5	10	54	4	\N	2016-01-30	1500.00	719b75424fd8dfc276c4da51ec8306f0	2020-10-23 22:10:52.092961	2020-10-23 22:10:52.092961
781	1	10	54	3	\N	2016-01-30	-1500.00	3daf3224b85a18c85ae50d63a7a6097c	2020-10-23 22:10:52.094198	2020-10-23 22:10:52.094198
782	6	10	54	4	\N	2016-01-30	1500.00	3daf3224b85a18c85ae50d63a7a6097c	2020-10-23 22:10:52.095459	2020-10-23 22:10:52.095459
783	1	10	54	3	\N	2016-01-30	-350.00	8ea5d22eba2d75b7651304f4dcde8eee	2020-10-23 22:10:52.096809	2020-10-23 22:10:52.096809
784	1	10	54	3	\N	2016-01-30	-2000.00	3f05ed99d40a8630e778f41d994fd7ff	2020-10-23 22:10:52.098069	2020-10-23 22:10:52.098069
785	3	10	54	4	\N	2016-01-30	2000.00	3f05ed99d40a8630e778f41d994fd7ff	2020-10-23 22:10:52.099326	2020-10-23 22:10:52.099326
786	1	10	54	3	\N	2016-01-30	-500.00	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:10:52.100635	2020-10-23 22:10:52.100635
787	5	10	54	4	\N	2016-01-30	500.00	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:10:52.102276	2020-10-23 22:10:52.102276
788	2	2	3	1	\N	2016-01-28	4601.24	8c2aa185e4d169c94c7cdc984d7db036	2020-10-23 22:10:52.103729	2020-10-23 22:10:52.103729
789	2	10	54	3	\N	2016-01-30	-1500.00	f619797e6f149858f77bf0db0a606d56	2020-10-23 22:10:52.105012	2020-10-23 22:10:52.105012
790	5	10	54	4	\N	2016-01-30	1500.00	f619797e6f149858f77bf0db0a606d56	2020-10-23 22:10:52.106311	2020-10-23 22:10:52.106311
791	2	10	54	3	\N	2016-01-30	-1500.00	d8ae32d2fa6274ff84baf7cebc4c30e5	2020-10-23 22:10:52.1076	2020-10-23 22:10:52.1076
792	6	10	54	4	\N	2016-01-30	1500.00	d8ae32d2fa6274ff84baf7cebc4c30e5	2020-10-23 22:10:52.10905	2020-10-23 22:10:52.10905
793	2	10	54	3	\N	2016-01-30	-500.00	77c80e9139a0621d8c7d6430cd0dead7	2020-10-23 22:10:52.11023	2020-10-23 22:10:52.11023
794	4	10	54	4	\N	2016-01-30	500.00	77c80e9139a0621d8c7d6430cd0dead7	2020-10-23 22:10:52.111446	2020-10-23 22:10:52.111446
795	5	4	13	2	\N	2016-01-31	-420.00	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:10:52.112879	2020-10-23 22:10:52.112879
796	5	4	15	2	\N	2016-01-31	-126.36	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.114242	2020-10-23 22:10:52.114242
797	5	8	43	2	\N	2016-01-31	-20.00	0d9781f46cbb67b4662bdcaad87b8dc9	2020-10-23 22:10:52.115624	2020-10-23 22:10:52.115624
798	1	10	54	2	\N	2016-01-30	-1500.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.116979	2020-10-23 22:10:52.116979
799	5	10	54	4	\N	2016-01-30	500.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.118786	2020-10-23 22:10:52.118786
800	6	10	54	4	\N	2016-01-30	1000.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.120387	2020-10-23 22:10:52.120387
801	5	8	43	2	\N	2016-02-05	-34.98	7ac003a62aca8645624b9f9c05642fa7	2020-10-23 22:10:52.121658	2020-10-23 22:10:52.121658
802	5	7	30	2	\N	2016-02-04	-11.00	55743cc0393b1cb4b8b37d09ae48d097	2020-10-23 22:10:52.122997	2020-10-23 22:10:52.122997
803	5	8	43	2	\N	2016-02-05	-20.00	0d9781f46cbb67b4662bdcaad87b8dc9	2020-10-23 22:10:52.1241	2020-10-23 22:10:52.1241
804	5	7	30	2	\N	2016-02-03	-44.00	f2d4b09567fc047e0d59297d141c824d	2020-10-23 22:10:52.125272	2020-10-23 22:10:52.125272
805	5	1	-1	2	\N	2016-02-03	-84.12	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.126532	2020-10-23 22:10:52.126532
806	5	1	-1	2	\N	2016-02-03	-25.78	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.128075	2020-10-23 22:10:52.128075
807	5	1	-1	2	\N	2016-02-03	-103.77	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.129289	2020-10-23 22:10:52.129289
808	5	4	13	2	\N	2016-02-01	-420.90	13156e347b1734f38db62eea70f7b0a5	2020-10-23 22:10:52.131349	2020-10-23 22:10:52.131349
809	5	4	15	2	\N	2016-02-01	-126.36	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:10:52.13269	2020-10-23 22:10:52.13269
810	5	1	-1	2	\N	2016-02-01	-42.62	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.133936	2020-10-23 22:10:52.133936
811	5	8	43	2	\N	2016-02-02	-137.94	285e19f20beded7d215102b49d5c09a0	2020-10-23 22:10:52.135243	2020-10-23 22:10:52.135243
812	1	9	48	2	\N	2016-02-06	-27.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:52.136518	2020-10-23 22:10:52.136518
813	5	1	-1	2	\N	2016-02-06	-90.75	b3af409bb8423187c75e6c7f5b683908	2020-10-23 22:10:52.137969	2020-10-23 22:10:52.137969
814	2	1	-1	2	\N	2016-02-06	-13.00	fff83f4182a42ac6494729535987ff42	2020-10-23 22:10:52.139279	2020-10-23 22:10:52.139279
815	5	1	-1	2	\N	2016-02-06	-40.00	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.140517	2020-10-23 22:10:52.140517
816	5	1	-1	2	\N	2016-02-06	-30.00	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.141936	2020-10-23 22:10:52.141936
817	2	1	-1	1	\N	2016-02-06	30.00	0f96613235062963ccde717b18f97592	2020-10-23 22:10:52.143435	2020-10-23 22:10:52.143435
818	5	7	30	2	\N	2016-02-07	-561.90	605ff764c617d3cd28dbbdd72be8f9a2	2020-10-23 22:10:52.144617	2020-10-23 22:10:52.144617
819	5	7	30	2	\N	2016-02-08	-43.34	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:10:52.145846	2020-10-23 22:10:52.145846
820	1	8	41	2	\N	2016-02-08	-46.00	1ff8064e274d0ba812d61379d97a2f4c	2020-10-23 22:10:52.147169	2020-10-23 22:10:52.147169
821	1	8	41	2	\N	2016-02-08	-28.20	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:52.148231	2020-10-23 22:10:52.148231
822	2	1	-1	2	\N	2016-02-09	-3.50	ffc987113c7a22fb2a52b6f9842f79be	2020-10-23 22:10:52.149466	2020-10-23 22:10:52.149466
823	2	1	-1	2	\N	2016-02-09	-28.00	218a0aefd1d1a4be65601cc6ddc1520e	2020-10-23 22:10:52.150883	2020-10-23 22:10:52.150883
824	2	1	-1	2	\N	2016-02-09	-12.90	b597e5b0e7970deda3d6cf8017b929b7	2020-10-23 22:10:52.152526	2020-10-23 22:10:52.152526
825	2	6	27	2	\N	2016-02-11	-44.99	13f9896df61279c928f19721878fac41	2020-10-23 22:10:52.153949	2020-10-23 22:10:52.153949
826	5	1	-1	2	\N	2016-02-11	-58.54	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:52.155183	2020-10-23 22:10:52.155183
827	5	1	-1	2	\N	2016-02-11	-27.93	ad30b44e1e057a2070dacac94607470d	2020-10-23 22:10:52.156437	2020-10-23 22:10:52.156437
828	2	1	-1	2	\N	2016-02-11	-3.90	ffc987113c7a22fb2a52b6f9842f79be	2020-10-23 22:10:52.157858	2020-10-23 22:10:52.157858
829	2	6	27	2	\N	2016-02-11	-24.99	88ae6372cfdc5df69a976e893f4d554b	2020-10-23 22:10:52.159034	2020-10-23 22:10:52.159034
830	2	1	-1	2	\N	2016-02-12	-3.90	d61e4bbd6393c9111e6526ea173a7c8b	2020-10-23 22:10:52.160142	2020-10-23 22:10:52.160142
831	2	1	-1	2	\N	2016-02-13	-11.00	6daddd96b0e241ab30f1dcdd858fd15e	2020-10-23 22:10:52.161236	2020-10-23 22:10:52.161236
832	2	1	-1	2	\N	2016-02-13	-12.00	f0e743de86483d3ef431b8c8f393418e	2020-10-23 22:10:52.162423	2020-10-23 22:10:52.162423
833	1	1	-1	2	\N	2016-02-09	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:52.163719	2020-10-23 22:10:52.163719
834	1	1	-1	2	\N	2016-02-09	-1.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.164899	2020-10-23 22:10:52.164899
835	1	1	-1	2	\N	2016-02-09	-4.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.166133	2020-10-23 22:10:52.166133
836	1	1	-1	2	\N	2016-02-12	-14.82	25ddc0f8c9d3e22e03d3076f98d83cb2	2020-10-23 22:10:52.167385	2020-10-23 22:10:52.167385
837	5	1	-1	2	\N	2016-02-13	-93.11	320722549d1751cf3f247855f937b982	2020-10-23 22:10:52.168739	2020-10-23 22:10:52.168739
838	1	1	-1	2	\N	2016-02-12	-114.00	7634ea65a4e6d9041cfd3f7de18e334a	2020-10-23 22:10:52.170077	2020-10-23 22:10:52.170077
839	1	2	-1	4	\N	2016-02-15	295.00	069d3bb002acd8d7dd095917f9efe4cb	2020-10-23 22:10:52.171257	2020-10-23 22:10:52.171257
840	2	8	44	2	\N	2016-02-13	-20.00	4bfd966f0f4b6763509ba309ddada756	2020-10-23 22:10:52.172329	2020-10-23 22:10:52.172329
841	2	6	27	2	\N	2016-02-13	-53.17	c058f544c737782deacefa532d9add4c	2020-10-23 22:10:52.173422	2020-10-23 22:10:52.173422
842	5	9	49	2	\N	2016-02-14	-154.00	f1f8047f32e9774835037cb02e55f1de	2020-10-23 22:10:52.174515	2020-10-23 22:10:52.174515
843	5	9	-1	2	\N	2016-02-14	-520.00	e308ac73399237a7606dcafdfbcb89fd	2020-10-23 22:10:52.176002	2020-10-23 22:10:52.176002
844	5	5	23	2	\N	2016-02-15	-79.87	e94550c93cd70fe748e6982b3439ad3b	2020-10-23 22:10:52.177707	2020-10-23 22:10:52.177707
845	2	1	-1	2	\N	2016-02-15	-4.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.179068	2020-10-23 22:10:52.179068
846	2	9	-1	2	\N	2016-02-14	-188.90	4324bb834e17ddb66ac56d51a659dace	2020-10-23 22:10:52.18025	2020-10-23 22:10:52.18025
847	5	4	13	2	\N	2016-02-15	-89.00	e8c0653fea13f91bf3c48159f7c24f78	2020-10-23 22:10:52.181444	2020-10-23 22:10:52.181444
848	1	2	-1	1	\N	2016-02-15	43.30	84506442dda92f2efef35c9d84cfea99	2020-10-23 22:10:52.182701	2020-10-23 22:10:52.182701
849	2	9	49	2	\N	2016-02-16	-20.00	77b5dd21ac825740bf51c89cc593b8c5	2020-10-23 22:10:52.183913	2020-10-23 22:10:52.183913
850	5	6	27	2	\N	2016-02-16	-19.90	ae5c384e5973ba774a7aa0839e2d9b4a	2020-10-23 22:10:52.185457	2020-10-23 22:10:52.185457
851	5	1	-1	2	\N	2016-02-18	-94.12	c427f3280738cd20e165dd0c0a42cb8c	2020-10-23 22:10:52.186825	2020-10-23 22:10:52.186825
852	2	1	-1	2	\N	2016-02-18	-6.60	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:52.188008	2020-10-23 22:10:52.188008
853	2	6	27	2	\N	2016-02-18	-59.80	528226d422b003bce28af6446108fc1d	2020-10-23 22:10:52.189278	2020-10-23 22:10:52.189278
854	5	5	22	2	\N	2016-02-19	-300.00	084d5dcb6d1c6f790ff013bb8751bd2d	2020-10-23 22:10:52.19052	2020-10-23 22:10:52.19052
855	5	1	-1	2	\N	2016-02-19	-17.27	e7360c0525d1e355aceb1174cb591015	2020-10-23 22:10:52.191798	2020-10-23 22:10:52.191798
856	1	1	-1	2	\N	2016-02-20	-18.95	a8811e4ace534ddf1e517e255389cf2f	2020-10-23 22:10:52.19298	2020-10-23 22:10:52.19298
857	5	1	-1	2	\N	2016-02-19	-9.48	31af771f6fc7fc96c96852892fe7e126	2020-10-23 22:10:52.194331	2020-10-23 22:10:52.194331
858	5	1	-1	2	\N	2016-02-19	-65.18	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.195658	2020-10-23 22:10:52.195658
859	1	1	-1	2	\N	2016-02-17	-4.38	7b13b2203029ed80337f27127a9f1d28	2020-10-23 22:10:52.196999	2020-10-23 22:10:52.196999
860	1	1	11	2	\N	2016-02-17	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:52.198035	2020-10-23 22:10:52.198035
861	1	1	11	2	\N	2016-02-17	-5.00	65d0efc410cb372de67a7c9d1bc95f15	2020-10-23 22:10:52.199127	2020-10-23 22:10:52.199127
862	1	1	-1	2	\N	2016-02-19	-19.00	21f64e3ec83330fbc425f52ff209c835	2020-10-23 22:10:52.200388	2020-10-23 22:10:52.200388
863	5	1	-1	2	\N	2016-02-19	-10.74	0ff39bbbf981ac0151d340c9aa40e63e	2020-10-23 22:10:52.202044	2020-10-23 22:10:52.202044
864	1	1	-1	2	\N	2016-02-17	-14.65	8e7c6b19af1fc49034a4b2663e55d987	2020-10-23 22:10:52.20356	2020-10-23 22:10:52.20356
865	1	1	-1	2	\N	2016-02-18	-19.52	8e7c6b19af1fc49034a4b2663e55d987	2020-10-23 22:10:52.205272	2020-10-23 22:10:52.205272
866	1	1	-1	2	\N	2016-02-18	-92.00	7b16783a9d7ce44e12deb7c9a372a027	2020-10-23 22:10:52.206577	2020-10-23 22:10:52.206577
867	5	2	-1	1	\N	2016-02-17	31.32	24ea02bea379f86ed49fa11257f69ef8	2020-10-23 22:10:52.207877	2020-10-23 22:10:52.207877
868	5	7	35	2	\N	2016-02-20	-30.00	0520a41422ce63b356f79ca728e06b2a	2020-10-23 22:10:52.209073	2020-10-23 22:10:52.209073
869	2	6	27	2	\N	2016-02-21	-169.96	7ddde8dfd3a5b1c79de6bb7ab756a399	2020-10-23 22:10:52.210137	2020-10-23 22:10:52.210137
870	5	1	-1	2	\N	2016-02-20	-14.74	0520a41422ce63b356f79ca728e06b2a	2020-10-23 22:10:52.211251	2020-10-23 22:10:52.211251
871	2	8	41	2	\N	2016-02-22	-46.00	1ff8064e274d0ba812d61379d97a2f4c	2020-10-23 22:10:52.212688	2020-10-23 22:10:52.212688
872	2	4	16	2	\N	2016-02-22	-21.92	200787e659fed405fb4e546c46ecab7e	2020-10-23 22:10:52.214313	2020-10-23 22:10:52.214313
873	1	5	21	2	\N	2016-02-22	-25.76	9e94b15ed312fa42232fd87a55db0d39	2020-10-23 22:10:52.215745	2020-10-23 22:10:52.215745
874	5	2	-1	1	\N	2016-02-22	94.00	c6bc586e4125cbbcc420fe13387f1896	2020-10-23 22:10:52.216973	2020-10-23 22:10:52.216973
875	2	5	21	2	\N	2016-02-25	-17.50	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:10:52.218333	2020-10-23 22:10:52.218333
876	2	6	27	2	\N	2016-02-25	-19.99	33e8075e9970de0cfea955afd4644bb2	2020-10-23 22:10:52.219696	2020-10-23 22:10:52.219696
877	2	5	21	2	\N	2016-02-25	-33.00	f056ba9633b803f136990d0fe4d7bee2	2020-10-23 22:10:52.221416	2020-10-23 22:10:52.221416
878	2	5	21	2	\N	2016-02-26	-15.98	de8eedf27d2d459f2f171942b07bec12	2020-10-23 22:10:52.222642	2020-10-23 22:10:52.222642
879	2	5	21	2	\N	2016-02-26	-13.58	ec8ce6abb3e952a85b8551ba726a1227	2020-10-23 22:10:52.223809	2020-10-23 22:10:52.223809
880	5	5	21	2	\N	2016-02-26	-12.90	d61ea975e655355497c4ae44544565d1	2020-10-23 22:10:52.225146	2020-10-23 22:10:52.225146
881	2	2	3	1	\N	2016-02-26	3605.84	ef0b0b5b1f685fd8e36cb1c9bd1387b8	2020-10-23 22:10:52.226615	2020-10-23 22:10:52.226615
882	1	2	3	1	\N	2016-02-26	10045.13	8039b4e0e6fe78bee7d3e5cfbfa343f0	2020-10-23 22:10:52.22809	2020-10-23 22:10:52.22809
883	1	10	54	3	\N	2016-02-26	-3000.00	8d34201a5b85900908db6cae92723617	2020-10-23 22:10:52.229479	2020-10-23 22:10:52.229479
884	6	10	54	4	\N	2016-02-26	3000.00	8d34201a5b85900908db6cae92723617	2020-10-23 22:10:52.230982	2020-10-23 22:10:52.230982
885	1	10	54	3	\N	2016-02-26	-1500.00	8cc8aaea7440ac22bfc8a439c1c2f237	2020-10-23 22:10:52.232327	2020-10-23 22:10:52.232327
886	5	10	54	4	\N	2016-02-26	1500.00	8cc8aaea7440ac22bfc8a439c1c2f237	2020-10-23 22:10:52.233688	2020-10-23 22:10:52.233688
887	1	10	54	3	\N	2016-02-26	-1500.00	8cc8aaea7440ac22bfc8a439c1c2f237	2020-10-23 22:10:52.235052	2020-10-23 22:10:52.235052
888	1	10	54	3	\N	2016-02-26	-500.00	ccf296ca8488f71b0e97d174abe1448e	2020-10-23 22:10:52.236374	2020-10-23 22:10:52.236374
889	1	10	54	3	\N	2016-02-26	-3500.00	8557acbd605dce2d0a6106c47bcd2338	2020-10-23 22:10:52.237619	2020-10-23 22:10:52.237619
890	3	10	54	4	\N	2016-02-26	3500.00	8557acbd605dce2d0a6106c47bcd2338	2020-10-23 22:10:52.23886	2020-10-23 22:10:52.23886
891	1	1	11	2	\N	2016-02-26	-1.80	f29c21d4897f78948b91f03172341b7b	2020-10-23 22:10:52.240093	2020-10-23 22:10:52.240093
892	1	1	-1	2	\N	2016-02-26	-26.00	8170395a8a20582b582b805d5b5e21c8	2020-10-23 22:10:52.241406	2020-10-23 22:10:52.241406
893	1	1	-1	2	\N	2016-02-26	-11.08	7cb49a36f0c97e7fbe3fdc6ad93d141f	2020-10-23 22:10:52.242851	2020-10-23 22:10:52.242851
894	1	1	-1	2	\N	2016-02-26	-17.21	7cb49a36f0c97e7fbe3fdc6ad93d141f	2020-10-23 22:10:52.244196	2020-10-23 22:10:52.244196
895	5	4	13	2	\N	2016-02-26	-349.79	a5297d15410aaa7799e1d28a39294be8	2020-10-23 22:10:52.245543	2020-10-23 22:10:52.245543
896	5	4	14	2	\N	2016-02-26	-96.76	fbf70cb49ab268a3ec42a4d17f61390e	2020-10-23 22:10:52.24707	2020-10-23 22:10:52.24707
897	1	1	-1	2	\N	2016-02-20	-19.80	71149d8d730099caae3b0ad93b6b93ae	2020-10-23 22:10:52.248214	2020-10-23 22:10:52.248214
898	5	1	-1	2	\N	2016-02-27	-6.99	62a0e3d0e8d9db40e64419904a137c32	2020-10-23 22:10:52.249645	2020-10-23 22:10:52.249645
899	2	4	18	2	\N	2016-02-28	-41.98	0714c352af2ecb1aa703a5a7664644c5	2020-10-23 22:10:52.252064	2020-10-23 22:10:52.252064
900	5	1	-1	2	\N	2016-02-27	-100.00	00ac8ed3b4327bdd4ebbebcb2ba10a00	2020-10-23 22:10:52.253453	2020-10-23 22:10:52.253453
901	2	9	-1	1	\N	2016-02-27	100.00	3fdf7ff211eec1dde75bbdba2e8b5bde	2020-10-23 22:10:52.254941	2020-10-23 22:10:52.254941
902	5	1	-1	2	\N	2016-02-27	-107.16	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:52.256156	2020-10-23 22:10:52.256156
903	1	1	-1	2	\N	2016-02-27	-6.00	a0f6d0244be79da7040362bf43e9af46	2020-10-23 22:10:52.257445	2020-10-23 22:10:52.257445
904	5	4	16	2	\N	2016-03-01	-49.90	0f39f4e7639fadbb26041e51432b609c	2020-10-23 22:10:52.258725	2020-10-23 22:10:52.258725
905	5	4	13	2	\N	2016-03-01	-22.04	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:10:52.259927	2020-10-23 22:10:52.259927
906	5	9	-1	2	\N	2016-03-01	-30.00	0f89141116f7f7aa036773544ccecd15	2020-10-23 22:10:52.26142	2020-10-23 22:10:52.26142
907	5	1	-1	2	\N	2016-03-01	-12.17	bd686fd640be98efaae0091fa301e613	2020-10-23 22:10:52.26249	2020-10-23 22:10:52.26249
908	5	10	54	4	\N	2016-03-01	1500.00	4911e516e5aa21d327512e0c8b197616	2020-10-23 22:10:52.263606	2020-10-23 22:10:52.263606
909	1	1	11	2	\N	2016-03-01	-1.80	294e575c31c3e40483086f3b89793001	2020-10-23 22:10:52.26493	2020-10-23 22:10:52.26493
910	1	1	-1	2	\N	2016-03-01	-14.41	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:10:52.266193	2020-10-23 22:10:52.266193
911	1	1	-1	2	\N	2016-03-01	-12.27	b798c28e671592bc0fe82b05d71c69ba	2020-10-23 22:10:52.267557	2020-10-23 22:10:52.267557
912	1	1	-1	2	\N	2016-03-01	-17.48	138bb0696595b338afbab333c555292a	2020-10-23 22:10:52.269043	2020-10-23 22:10:52.269043
913	5	7	30	2	\N	2016-03-01	-1005.72	4951ec72a8a308419e44c62bc45c682b	2020-10-23 22:10:52.270514	2020-10-23 22:10:52.270514
914	5	7	30	2	\N	2016-03-01	-1107.80	131dfcee41083a5673dee0a63878bf5b	2020-10-23 22:10:52.272414	2020-10-23 22:10:52.272414
915	2	10	54	3	\N	2016-03-01	-1000.00	31af771f6fc7fc96c96852892fe7e126	2020-10-23 22:10:52.273818	2020-10-23 22:10:52.273818
916	2	10	54	3	\N	2016-03-01	-1000.00	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:10:52.275321	2020-10-23 22:10:52.275321
917	5	10	54	4	\N	2016-03-01	1000.00	31af771f6fc7fc96c96852892fe7e126	2020-10-23 22:10:52.277137	2020-10-23 22:10:52.277137
918	5	10	54	4	\N	2016-03-01	1000.00	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:10:52.278283	2020-10-23 22:10:52.278283
919	1	9	49	2	\N	2016-03-01	-46.14	7d0d5a5dd9de1422c29fe8ec87b69204	2020-10-23 22:10:52.279593	2020-10-23 22:10:52.279593
920	2	6	28	2	\N	2016-03-02	-20.00	7ac40f334458e1ae276de8609e6e77e9	2020-10-23 22:10:52.280751	2020-10-23 22:10:52.280751
921	2	1	-1	2	\N	2016-03-02	-14.38	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:10:52.281833	2020-10-23 22:10:52.281833
922	5	10	54	2	\N	2016-03-03	-1000.00	6008683015da4d3c1ce22105cc707371	2020-10-23 22:10:52.283128	2020-10-23 22:10:52.283128
923	2	10	54	1	\N	2016-03-03	1000.00	6008683015da4d3c1ce22105cc707371	2020-10-23 22:10:52.284542	2020-10-23 22:10:52.284542
924	5	1	-1	2	\N	2016-03-03	-57.75	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.28593	2020-10-23 22:10:52.28593
925	2	8	41	2	\N	2016-03-03	-30.00	58238e9ae2dd305d79c2ebc8c1883422	2020-10-23 22:10:52.287152	2020-10-23 22:10:52.287152
926	5	1	-1	2	\N	2016-03-06	-21.40	f4a918ae12ee8b9cdf2c78f771bcb712	2020-10-23 22:10:52.288282	2020-10-23 22:10:52.288282
927	1	1	-1	2	\N	2016-03-04	-13.07	26e359e83860db1d11b6acca57d8ea88	2020-10-23 22:10:52.289525	2020-10-23 22:10:52.289525
928	1	1	-1	2	\N	2016-03-04	-60.00	6417c761ca3a8218b8b68e0ddacc514a	2020-10-23 22:10:52.291594	2020-10-23 22:10:52.291594
929	1	1	-1	2	\N	2016-03-04	-59.99	b5b4094c70811825d4594e6a5a227e49	2020-10-23 22:10:52.293066	2020-10-23 22:10:52.293066
930	5	1	-1	2	\N	2016-03-05	-49.92	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.294317	2020-10-23 22:10:52.294317
931	5	1	-1	2	\N	2016-03-05	-12.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.295677	2020-10-23 22:10:52.295677
932	1	8	41	2	\N	2016-03-06	-46.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:10:52.297314	2020-10-23 22:10:52.297314
933	5	1	-1	2	\N	2016-03-07	-11.11	ff98d47a8a3d33e894c878d21afc5a44	2020-10-23 22:10:52.298565	2020-10-23 22:10:52.298565
934	5	1	-1	2	\N	2016-03-08	-50.86	668df5a099a9fd3af823e16a98235a81	2020-10-23 22:10:52.299775	2020-10-23 22:10:52.299775
935	5	9	-1	2	\N	2016-03-08	-20.00	b56c3e19f5a9156859dc89cdf30afc1b	2020-10-23 22:10:52.301222	2020-10-23 22:10:52.301222
936	2	1	-1	2	\N	2016-03-09	-27.00	0951e222c39c42674fc1ad8b1283564e	2020-10-23 22:10:52.302569	2020-10-23 22:10:52.302569
937	5	4	15	2	\N	2016-03-10	-57.12	52523aa4bb7d0e9033453b98dd6b6e87	2020-10-23 22:10:52.304295	2020-10-23 22:10:52.304295
938	5	1	-1	2	\N	2016-03-11	-30.58	6f145d35eb70b65980be6dc26adeb058	2020-10-23 22:10:52.305577	2020-10-23 22:10:52.305577
939	2	9	48	2	\N	2016-03-11	-14.96	e08549a19f9035f313995d64075de7fa	2020-10-23 22:10:52.306771	2020-10-23 22:10:52.306771
940	5	9	48	1	\N	2016-03-11	14.96	2d535a4fe10f593d8c6a5b35d152604e	2020-10-23 22:10:52.308052	2020-10-23 22:10:52.308052
941	1	1	-1	2	\N	2016-03-11	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.309305	2020-10-23 22:10:52.309305
942	5	1	-1	2	\N	2016-03-12	-99.05	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.310588	2020-10-23 22:10:52.310588
943	1	1	-1	2	\N	2016-03-08	-105.00	7e5cc4a07afc096ab7d0a39b469c837b	2020-10-23 22:10:52.312088	2020-10-23 22:10:52.312088
944	1	9	49	2	\N	2016-03-11	-299.00	49ff677b6b04d1037317ad4a07ab58db	2020-10-23 22:10:52.313319	2020-10-23 22:10:52.313319
945	1	1	-1	2	\N	2016-03-09	-15.42	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.314609	2020-10-23 22:10:52.314609
946	5	1	-1	2	\N	2016-03-10	-11.70	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:52.315853	2020-10-23 22:10:52.315853
947	5	1	-1	2	\N	2016-03-10	-44.49	158f3069a435b314a80bdcb024f8e422	2020-10-23 22:10:52.31763	2020-10-23 22:10:52.31763
948	1	9	-1	2	\N	2016-03-12	-5.00	563c921f86a55d6de976d908883dcfce	2020-10-23 22:10:52.319226	2020-10-23 22:10:52.319226
949	2	4	19	2	\N	2016-03-13	-1221.00	2de5d71b613907737f26c793998e88d9	2020-10-23 22:10:52.320612	2020-10-23 22:10:52.320612
950	2	5	25	2	\N	2016-03-13	-45.00	82a958afc122a6e476b5f93a210b781e	2020-10-23 22:10:52.321959	2020-10-23 22:10:52.321959
951	2	6	27	2	\N	2016-03-13	-110.94	1772c7ee061e403943a88f11bcef8149	2020-10-23 22:10:52.323329	2020-10-23 22:10:52.323329
952	2	1	-1	2	\N	2016-03-13	-10.60	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:52.324631	2020-10-23 22:10:52.324631
953	2	10	54	3	\N	2016-03-13	-500.00	842f3298f90f01fa8d7086b05252e705	2020-10-23 22:10:52.326048	2020-10-23 22:10:52.326048
954	6	10	54	4	\N	2016-03-13	500.00	842f3298f90f01fa8d7086b05252e705	2020-10-23 22:10:52.327241	2020-10-23 22:10:52.327241
955	2	5	21	2	\N	2016-03-14	-18.99	2a9ced3967f417a7877cc296438e6fb4	2020-10-23 22:10:52.32895	2020-10-23 22:10:52.32895
956	5	1	-1	2	\N	2016-03-15	-28.43	6f278f85c688b6cf275730b90ec6096c	2020-10-23 22:10:52.330881	2020-10-23 22:10:52.330881
957	2	1	-1	2	\N	2016-03-15	-8.50	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:52.332653	2020-10-23 22:10:52.332653
958	2	9	-1	2	\N	2016-03-15	-10.00	d8ae1f0b868d69547dd6377f7538eec6	2020-10-23 22:10:52.334675	2020-10-23 22:10:52.334675
959	5	5	23	2	\N	2016-03-16	-53.99	45862a09025491ef4c60c6fca99cdd3a	2020-10-23 22:10:52.337058	2020-10-23 22:10:52.337058
960	5	5	23	2	\N	2016-03-16	-28.35	7826581883e86855213a04c3a6f6c7aa	2020-10-23 22:10:52.338514	2020-10-23 22:10:52.338514
961	5	5	21	2	\N	2016-03-16	-28.01	b2b36a2becd039215094ccf3fa43aee1	2020-10-23 22:10:52.339892	2020-10-23 22:10:52.339892
962	5	1	-1	2	\N	2016-03-16	-10.20	9e46bce99da9676692d196558a079266	2020-10-23 22:10:52.341233	2020-10-23 22:10:52.341233
963	2	1	-1	1	\N	2016-03-16	10.20	9e46bce99da9676692d196558a079266	2020-10-23 22:10:52.342608	2020-10-23 22:10:52.342608
964	2	6	27	1	\N	2016-03-16	39.98	5c936263f3428a40227908d5a3847c0b	2020-10-23 22:10:52.344464	2020-10-23 22:10:52.344464
965	5	1	-1	2	\N	2016-03-16	-50.38	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:10:52.346148	2020-10-23 22:10:52.346148
966	5	1	-1	2	\N	2016-03-18	-21.51	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:10:52.347697	2020-10-23 22:10:52.347697
967	5	1	-1	2	\N	2016-03-18	-17.40	c16c8bfd64c521e726c0b5bb02749c47	2020-10-23 22:10:52.349332	2020-10-23 22:10:52.349332
968	2	1	-1	1	\N	2016-03-18	17.40	c16c8bfd64c521e726c0b5bb02749c47	2020-10-23 22:10:52.351048	2020-10-23 22:10:52.351048
969	2	7	33	2	\N	2016-03-18	-64.26	b05ef1f72e4bbd5cbefdc8b5d95e0b3b	2020-10-23 22:10:52.353195	2020-10-23 22:10:52.353195
970	1	2	-1	1	\N	2016-03-15	300.00	170c944978496731ba71f34c25826a34	2020-10-23 22:10:52.354958	2020-10-23 22:10:52.354958
971	1	9	48	2	\N	2016-03-19	-37.50	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:52.358572	2020-10-23 22:10:52.358572
972	1	1	-1	2	\N	2016-03-18	-25.00	f0c7c8ee504f69ff718e8b26f949220a	2020-10-23 22:10:52.360705	2020-10-23 22:10:52.360705
973	1	1	-1	2	\N	2016-03-18	-20.00	5705e1164a8394aace6018e27d20d237	2020-10-23 22:10:52.362205	2020-10-23 22:10:52.362205
974	1	1	11	2	\N	2016-03-18	-17.85	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:10:52.363695	2020-10-23 22:10:52.363695
975	5	1	-1	2	\N	2016-03-19	-95.10	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.365117	2020-10-23 22:10:52.365117
976	1	1	-1	2	\N	2016-03-16	-9.96	26e359e83860db1d11b6acca57d8ea88	2020-10-23 22:10:52.366416	2020-10-23 22:10:52.366416
977	1	1	-1	2	\N	2016-03-14	-8.56	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:52.36826	2020-10-23 22:10:52.36826
978	1	1	-1	2	\N	2016-03-16	-4.57	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:52.369862	2020-10-23 22:10:52.369862
979	1	1	-1	2	\N	2016-03-15	-2.45	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:52.371248	2020-10-23 22:10:52.371248
980	1	1	-1	2	\N	2016-03-17	-12.53	26e359e83860db1d11b6acca57d8ea88	2020-10-23 22:10:52.372643	2020-10-23 22:10:52.372643
981	5	1	-1	2	\N	2016-03-16	-12.23	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:52.373975	2020-10-23 22:10:52.373975
982	4	9	-1	3	\N	2016-03-19	-500.00	31727cf01af32bdc3c5d92a52295d30e	2020-10-23 22:10:52.37529	2020-10-23 22:10:52.37529
983	2	9	-1	4	\N	2016-03-19	500.00	31727cf01af32bdc3c5d92a52295d30e	2020-10-23 22:10:52.376606	2020-10-23 22:10:52.376606
984	2	5	21	2	\N	2016-03-19	-39.99	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:10:52.378175	2020-10-23 22:10:52.378175
985	2	9	48	2	\N	2016-03-19	-64.80	74bba22728b6185eec06286af6bec36d	2020-10-23 22:10:52.379472	2020-10-23 22:10:52.379472
986	2	6	27	2	\N	2016-03-19	-399.00	1f965c4bfb315420cc619453909426bb	2020-10-23 22:10:52.380837	2020-10-23 22:10:52.380837
987	2	1	-1	2	\N	2016-03-19	-34.00	6417c761ca3a8218b8b68e0ddacc514a	2020-10-23 22:10:52.382357	2020-10-23 22:10:52.382357
988	2	8	41	2	\N	2016-03-19	-2.80	8c6744c9d42ec2cb9e8885b54ff744d0	2020-10-23 22:10:52.383568	2020-10-23 22:10:52.383568
989	2	8	44	2	\N	2016-03-19	-24.00	648ea973c3ba48397fcd70b55711c516	2020-10-23 22:10:52.385372	2020-10-23 22:10:52.385372
990	5	5	23	2	\N	2016-03-21	-9.50	d19ecce9394cd2d89b94b68012ad27cf	2020-10-23 22:10:52.38691	2020-10-23 22:10:52.38691
991	5	1	-1	2	\N	2016-03-21	-86.66	140d805191f53cacfb04dc47813d29e1	2020-10-23 22:10:52.388328	2020-10-23 22:10:52.388328
992	2	1	-1	2	\N	2016-03-21	-35.00	df8b15ba30764e3b9ce084c11336603a	2020-10-23 22:10:52.389696	2020-10-23 22:10:52.389696
993	6	9	-1	3	\N	2016-03-21	-1000.00	4860077c11610977c1446fd0bc72f6b2	2020-10-23 22:10:52.391435	2020-10-23 22:10:52.391435
994	5	9	-1	4	\N	2016-03-21	1000.00	4860077c11610977c1446fd0bc72f6b2	2020-10-23 22:10:52.393043	2020-10-23 22:10:52.393043
995	2	7	35	2	\N	2016-03-21	-60.00	81d37ce432deac7aaa9702a64726f047	2020-10-23 22:10:52.39435	2020-10-23 22:10:52.39435
996	5	5	23	2	\N	2016-03-23	-17.99	4b0a59ddf11c58e7446c9df0da541a84	2020-10-23 22:10:52.395875	2020-10-23 22:10:52.395875
997	5	9	48	2	\N	2016-03-23	-16.50	8039b4e0e6fe78bee7d3e5cfbfa343f0	2020-10-23 22:10:52.397514	2020-10-23 22:10:52.397514
998	5	1	-1	2	\N	2016-03-24	-6.75	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.39905	2020-10-23 22:10:52.39905
999	2	1	-1	1	\N	2016-03-24	6.75	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.40032	2020-10-23 22:10:52.40032
1000	5	7	35	2	\N	2016-03-24	-60.00	5da19fa1260738da1dc2223af6325108	2020-10-23 22:10:52.402259	2020-10-23 22:10:52.402259
1001	2	7	35	1	\N	2016-03-24	60.00	5da19fa1260738da1dc2223af6325108	2020-10-23 22:10:52.403895	2020-10-23 22:10:52.403895
1002	5	1	-1	2	\N	2016-03-25	-21.38	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:10:52.405343	2020-10-23 22:10:52.405343
1003	5	8	43	2	\N	2016-03-25	-98.00	550a141f12de6341fba65b0ad0433500	2020-10-23 22:10:52.407016	2020-10-23 22:10:52.407016
1004	5	8	43	2	\N	2016-03-25	-167.88	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:52.40865	2020-10-23 22:10:52.40865
1005	1	5	21	2	\N	2016-03-25	-26.97	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:52.410288	2020-10-23 22:10:52.410288
1006	5	2	-1	1	\N	2016-03-25	26.97	a0ebee5d753c05cd46374203d6f1ff52	2020-10-23 22:10:52.411482	2020-10-23 22:10:52.411482
1007	1	5	21	2	\N	2016-03-25	-60.51	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:52.412784	2020-10-23 22:10:52.412784
1008	5	5	23	2	\N	2016-03-22	-48.80	7ff570da3b2ba4814f4c3c330bce4c56	2020-10-23 22:10:52.414172	2020-10-23 22:10:52.414172
1009	5	5	23	2	\N	2016-03-23	-62.29	d7ee6c45ea891305f16deaafccd40e05	2020-10-23 22:10:52.415464	2020-10-23 22:10:52.415464
1010	1	1	-1	2	\N	2016-03-22	-8.37	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.416725	2020-10-23 22:10:52.416725
1011	1	1	11	2	\N	2016-03-22	-8.37	061412e4a03c02f9902576ec55ebbe77	2020-10-23 22:10:52.418019	2020-10-23 22:10:52.418019
1012	1	1	-1	2	\N	2016-03-23	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.419393	2020-10-23 22:10:52.419393
1013	1	1	-1	2	\N	2016-03-23	-15.75	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.420734	2020-10-23 22:10:52.420734
1014	1	6	27	2	\N	2016-03-21	-4.99	87c7d2a22550d476eb4ee56e8f88acff	2020-10-23 22:10:52.422216	2020-10-23 22:10:52.422216
1015	1	9	48	2	\N	2016-03-21	-44.50	f74068eac285b14de5ef06da6e9010e3	2020-10-23 22:10:52.423366	2020-10-23 22:10:52.423366
1016	1	9	49	2	\N	2016-03-26	-22.37	0bed3765bd22a7103796f60e28b0ea68	2020-10-23 22:10:52.424442	2020-10-23 22:10:52.424442
1017	1	2	3	1	\N	2016-03-25	8307.05	dce3947f36f66ed250640f078458fdb8	2020-10-23 22:10:52.425685	2020-10-23 22:10:52.425685
1018	1	2	-1	1	\N	2016-03-26	200.00	f7656e9fb889d8ba19dc12017c08eda8	2020-10-23 22:10:52.427152	2020-10-23 22:10:52.427152
1019	1	10	54	2	\N	2016-03-26	-200.00	f7656e9fb889d8ba19dc12017c08eda8	2020-10-23 22:10:52.42841	2020-10-23 22:10:52.42841
1020	1	10	54	3	\N	2016-03-29	-500.00	f74068eac285b14de5ef06da6e9010e3	2020-10-23 22:10:52.429633	2020-10-23 22:10:52.429633
1021	1	10	54	3	\N	2016-03-29	-1500.00	ae5c384e5973ba774a7aa0839e2d9b4a	2020-10-23 22:10:52.430976	2020-10-23 22:10:52.430976
1022	1	10	54	3	\N	2016-03-29	-600.00	ecca76103660ab0c1b54659785293726	2020-10-23 22:10:52.432176	2020-10-23 22:10:52.432176
1023	5	10	54	4	\N	2016-03-29	600.00	ecca76103660ab0c1b54659785293726	2020-10-23 22:10:52.433408	2020-10-23 22:10:52.433408
1024	1	10	54	3	\N	2016-03-29	-3500.00	23c5cd6a6391cddacef39d22e40656c6	2020-10-23 22:10:52.434673	2020-10-23 22:10:52.434673
1025	6	10	54	4	\N	2016-03-29	3500.00	23c5cd6a6391cddacef39d22e40656c6	2020-10-23 22:10:52.436443	2020-10-23 22:10:52.436443
1026	1	9	-1	1	\N	2016-03-29	22.00	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:52.43839	2020-10-23 22:10:52.43839
1027	5	9	-1	3	\N	2016-03-29	-22.00	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:52.439603	2020-10-23 22:10:52.439603
1028	2	2	3	1	\N	2016-03-24	3877.76	da0d1111d2dc5d489242e60ebcbaf988	2020-10-23 22:10:52.440914	2020-10-23 22:10:52.440914
1029	2	5	22	3	\N	2016-03-26	-301.50	8065d07da4a77621450aa84fee5656d9	2020-10-23 22:10:52.44218	2020-10-23 22:10:52.44218
1030	5	5	22	4	\N	2016-03-26	301.50	ad8d994fb30388c28ff5100c1a198837	2020-10-23 22:10:52.443566	2020-10-23 22:10:52.443566
1031	2	4	18	2	\N	2016-03-29	-40.15	705f2172834666788607efbfca35afb3	2020-10-23 22:10:52.445179	2020-10-23 22:10:52.445179
1032	2	10	54	3	\N	2016-03-29	-900.00	93e72f20112c07a787512750916fecae	2020-10-23 22:10:52.446399	2020-10-23 22:10:52.446399
1033	5	10	54	4	\N	2016-03-29	900.00	93e72f20112c07a787512750916fecae	2020-10-23 22:10:52.447587	2020-10-23 22:10:52.447587
1034	2	10	54	3	\N	2016-03-29	-900.00	18a2ed0bbf9cd483570dd5b9563bc32c	2020-10-23 22:10:52.448703	2020-10-23 22:10:52.448703
1035	6	10	54	4	\N	2016-03-29	900.00	18a2ed0bbf9cd483570dd5b9563bc32c	2020-10-23 22:10:52.450116	2020-10-23 22:10:52.450116
1036	2	10	54	3	\N	2016-03-29	-1000.00	4d8d2b25153fa9ba1feb2f14997dac4f	2020-10-23 22:10:52.451802	2020-10-23 22:10:52.451802
1037	4	10	54	4	\N	2016-03-29	1000.00	4d8d2b25153fa9ba1feb2f14997dac4f	2020-10-23 22:10:52.453571	2020-10-23 22:10:52.453571
1038	1	1	-1	2	\N	2016-03-31	-8.19	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.454908	2020-10-23 22:10:52.454908
1039	1	1	-1	2	\N	2016-03-30	-22.49	8c7bbbba95c1025975e548cee86dfadc	2020-10-23 22:10:52.456141	2020-10-23 22:10:52.456141
1040	2	4	15	2	\N	2016-04-02	-300.00	e633ebc842f846efae80b6dda8f2fb00	2020-10-23 22:10:52.45743	2020-10-23 22:10:52.45743
1041	5	9	48	2	\N	2016-04-02	-100.00	64aaf6814c0d3c75b50b6191ed217748	2020-10-23 22:10:52.458768	2020-10-23 22:10:52.458768
1042	2	8	41	2	\N	2016-04-05	-46.00	5807a685d1a9ab3b599035bc566ce2b9	2020-10-23 22:10:52.460128	2020-10-23 22:10:52.460128
1043	5	5	23	2	\N	2016-04-05	-8.49	5a4e0812feaadcae3f49a8895e24ab3b	2020-10-23 22:10:52.461295	2020-10-23 22:10:52.461295
1044	5	1	-1	2	\N	2016-04-05	-25.00	51f8c0f57b4592c35b43106399041035	2020-10-23 22:10:52.462444	2020-10-23 22:10:52.462444
1045	2	1	-1	1	\N	2016-04-05	25.00	23d6ea691f42ea37ddc3676ddac2a07f	2020-10-23 22:10:52.463636	2020-10-23 22:10:52.463636
1046	5	4	13	2	\N	2016-04-06	-349.79	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:10:52.464801	2020-10-23 22:10:52.464801
1047	5	4	15	2	\N	2016-04-06	-96.17	d87538ecdd64b81881f810e945c0efa2	2020-10-23 22:10:52.465891	2020-10-23 22:10:52.465891
1048	5	1	-1	2	\N	2016-04-06	-106.73	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.467002	2020-10-23 22:10:52.467002
1049	5	5	23	2	\N	2016-04-07	-45.97	602b90c674f8cb7b17e0d8a49697082d	2020-10-23 22:10:52.468276	2020-10-23 22:10:52.468276
1050	5	5	23	2	\N	2016-04-07	-19.99	f57a2f557b098c43f11ab969efe1504b	2020-10-23 22:10:52.469606	2020-10-23 22:10:52.469606
1051	5	1	-1	2	\N	2016-04-07	-9.10	3a840c6a9822b2037235e78928360c65	2020-10-23 22:10:52.470999	2020-10-23 22:10:52.470999
1052	2	1	-1	2	\N	2016-04-07	-10.90	28a31abd4abddffcac2ecb3953913b5f	2020-10-23 22:10:52.472103	2020-10-23 22:10:52.472103
1053	5	4	13	2	\N	2016-04-07	-147.95	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:52.473186	2020-10-23 22:10:52.473186
1054	5	4	13	2	\N	2016-04-07	-11.15	3885fb83a3d1d81e5e963af3d5427d91	2020-10-23 22:10:52.474349	2020-10-23 22:10:52.474349
1055	5	8	43	2	\N	2016-04-02	-132.48	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:10:52.475574	2020-10-23 22:10:52.475574
1056	1	1	-1	2	\N	2016-04-05	-55.00	f7664060cc52bc6f3d620bcedc94a4b6	2020-10-23 22:10:52.476808	2020-10-23 22:10:52.476808
1057	1	1	-1	2	\N	2016-04-07	-26.00	f7664060cc52bc6f3d620bcedc94a4b6	2020-10-23 22:10:52.477997	2020-10-23 22:10:52.477997
1058	1	1	-1	2	\N	2016-04-06	-11.00	f7664060cc52bc6f3d620bcedc94a4b6	2020-10-23 22:10:52.479259	2020-10-23 22:10:52.479259
1059	1	1	-1	2	\N	2016-04-06	-15.00	f7664060cc52bc6f3d620bcedc94a4b6	2020-10-23 22:10:52.480431	2020-10-23 22:10:52.480431
1060	1	4	19	2	\N	2016-04-09	-1712.00	a2c0085b355750b5645411a7d63f8e60	2020-10-23 22:10:52.481828	2020-10-23 22:10:52.481828
1061	5	2	-1	4	\N	2016-04-03	1500.00	e0932d6426c66ffde75f845923a6d77d	2020-10-23 22:10:52.483417	2020-10-23 22:10:52.483417
1062	1	1	-1	2	\N	2016-04-03	-50.00	170c944978496731ba71f34c25826a34	2020-10-23 22:10:52.484676	2020-10-23 22:10:52.484676
1063	5	1	-1	2	\N	2016-04-03	-29.71	138bb0696595b338afbab333c555292a	2020-10-23 22:10:52.48649	2020-10-23 22:10:52.48649
1064	5	1	-1	2	\N	2016-04-04	-71.90	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.487899	2020-10-23 22:10:52.487899
1065	1	1	11	2	\N	2016-04-01	-4.95	5487315b1286f907165907aa8fc96619	2020-10-23 22:10:52.489121	2020-10-23 22:10:52.489121
1066	1	1	-1	2	\N	2016-04-01	-3.85	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.490412	2020-10-23 22:10:52.490412
1067	5	1	-1	2	\N	2016-04-04	-10.74	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:52.491611	2020-10-23 22:10:52.491611
1068	1	1	-1	2	\N	2016-04-04	-14.13	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.492964	2020-10-23 22:10:52.492964
1069	1	6	27	2	\N	2016-04-06	-100.28	3cdb0dd8faabc2042e1793d248cf8076	2020-10-23 22:10:52.494334	2020-10-23 22:10:52.494334
1070	1	9	48	2	\N	2016-04-06	-54.90	60696feae44e81f50c6c1c65cd5c24a5	2020-10-23 22:10:52.495533	2020-10-23 22:10:52.495533
1071	1	1	-1	2	\N	2016-04-08	-12.00	16c16f5b7d54cfd52f5e73a846bf2d2e	2020-10-23 22:10:52.496745	2020-10-23 22:10:52.496745
1072	1	1	11	2	\N	2016-04-05	-7.80	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:10:52.497927	2020-10-23 22:10:52.497927
1073	1	1	-1	2	\N	2016-04-05	-16.34	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.499061	2020-10-23 22:10:52.499061
1074	1	8	41	2	\N	2016-04-09	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:52.500319	2020-10-23 22:10:52.500319
1075	2	6	27	2	\N	2016-04-09	-63.00	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:10:52.50177	2020-10-23 22:10:52.50177
1076	2	6	27	2	\N	2016-04-09	-169.00	e7b49124e25a0c36eccf98e1a6a1a153	2020-10-23 22:10:52.503521	2020-10-23 22:10:52.503521
1077	5	1	-1	2	\N	2016-04-11	-13.13	6d5d53e6f3738b98aafd818cb842670a	2020-10-23 22:10:52.504929	2020-10-23 22:10:52.504929
1078	5	1	-1	2	\N	2016-04-11	-15.20	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.506514	2020-10-23 22:10:52.506514
1079	2	1	-1	1	\N	2016-04-11	15.20	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.507836	2020-10-23 22:10:52.507836
1080	2	6	27	2	\N	2016-04-12	-81.90	348aabcfdf0004c41e3e199c5bae43e3	2020-10-23 22:10:52.509336	2020-10-23 22:10:52.509336
1081	5	1	-1	2	\N	2016-04-13	-15.02	942dd26dab18af7d4a73fde5adf8d6d4	2020-10-23 22:10:52.510474	2020-10-23 22:10:52.510474
1082	2	5	21	2	\N	2016-04-13	-7.89	0f243f3be92942b7bc653ac46e835ec2	2020-10-23 22:10:52.511682	2020-10-23 22:10:52.511682
1083	5	8	43	2	\N	2016-04-13	-708.20	3adf42e1b0b4d6c7ccf56aea8d11f791	2020-10-23 22:10:52.512941	2020-10-23 22:10:52.512941
1084	1	1	-1	2	\N	2016-04-13	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.514342	2020-10-23 22:10:52.514342
1085	1	1	-1	2	\N	2016-04-13	-3.45	ae5c384e5973ba774a7aa0839e2d9b4a	2020-10-23 22:10:52.516049	2020-10-23 22:10:52.516049
1086	1	2	3	1	\N	2016-04-11	972.00	37c0d6a8f55d92886feb0f0843c2b6c7	2020-10-23 22:10:52.517399	2020-10-23 22:10:52.517399
1087	1	1	-1	2	\N	2016-04-08	-9.64	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.518748	2020-10-23 22:10:52.518748
1088	1	10	54	3	\N	2016-04-13	-500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:52.520417	2020-10-23 22:10:52.520417
1089	3	10	54	4	\N	2016-04-13	500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:52.521838	2020-10-23 22:10:52.521838
1090	5	8	43	2	\N	2016-04-15	-59.00	013d407166ec4fa56eb1e1f8cbe183b9	2020-10-23 22:10:52.523086	2020-10-23 22:10:52.523086
1091	1	1	-1	2	\N	2016-04-15	-14.08	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.524798	2020-10-23 22:10:52.524798
1092	1	1	-1	2	\N	2016-04-14	-10.27	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.526177	2020-10-23 22:10:52.526177
1093	1	1	-1	2	\N	2016-04-11	-9.48	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.52757	2020-10-23 22:10:52.52757
1094	2	1	-1	2	\N	2016-04-16	-61.00	5a2605f367bf70dcf8de527a423a452e	2020-10-23 22:10:52.54517	2020-10-23 22:10:52.54517
1095	5	5	22	2	\N	2016-04-16	-300.00	582a01f265547b1ce38891316c3427d5	2020-10-23 22:10:52.546788	2020-10-23 22:10:52.546788
1096	5	1	-1	2	\N	2016-04-17	-29.30	eddea82ad2755b24c4e168c5fc2ebd40	2020-10-23 22:10:52.548195	2020-10-23 22:10:52.548195
1097	5	8	45	2	\N	2016-04-19	-27.00	03b90eb112838f07e019adb36c4300ed	2020-10-23 22:10:52.549586	2020-10-23 22:10:52.549586
1098	5	8	45	2	\N	2016-04-19	-36.00	1bb59d47cbbda38fe9038007a0ba4aae	2020-10-23 22:10:52.551138	2020-10-23 22:10:52.551138
1099	5	1	-1	2	\N	2016-04-16	-50.00	e022cd6724aa101e3e266c22c06f7e4f	2020-10-23 22:10:52.552486	2020-10-23 22:10:52.552486
1100	1	5	25	2	\N	2016-04-16	-35.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:52.553731	2020-10-23 22:10:52.553731
1101	5	1	-1	2	\N	2016-04-16	-85.85	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.554907	2020-10-23 22:10:52.554907
1102	5	1	-1	2	\N	2016-04-18	-85.14	f4a918ae12ee8b9cdf2c78f771bcb712	2020-10-23 22:10:52.556145	2020-10-23 22:10:52.556145
1103	5	2	-1	1	\N	2016-04-20	35.41	f79921bbae40a577928b76d2fc3edc2a	2020-10-23 22:10:52.557444	2020-10-23 22:10:52.557444
1104	5	1	-1	2	\N	2016-04-19	-19.00	0aa1883c6411f7873cb83dacb17b0afc	2020-10-23 22:10:52.558888	2020-10-23 22:10:52.558888
1105	2	1	-1	1	\N	2016-04-19	19.00	0aa1883c6411f7873cb83dacb17b0afc	2020-10-23 22:10:52.560108	2020-10-23 22:10:52.560108
1106	2	1	-1	2	\N	2016-04-20	-30.50	d4c659b3b005793e2fc12a983318d23e	2020-10-23 22:10:52.561338	2020-10-23 22:10:52.561338
1107	2	1	-1	2	\N	2016-04-20	-7.00	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.562492	2020-10-23 22:10:52.562492
1108	2	5	21	2	\N	2016-04-21	-52.51	357b6f7587a9cb5d0f97659b50424922	2020-10-23 22:10:52.563886	2020-10-23 22:10:52.563886
1109	2	1	-1	2	\N	2016-04-21	-59.41	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:52.565153	2020-10-23 22:10:52.565153
1110	5	5	21	2	\N	2016-04-21	-56.22	08cc114579a4fe08771a04496f12612b	2020-10-23 22:10:52.566334	2020-10-23 22:10:52.566334
1111	2	9	-1	4	\N	2016-04-22	200.00	d2cbf3a725316f70ab82094346a45ee1	2020-10-23 22:10:52.567893	2020-10-23 22:10:52.567893
1112	4	9	-1	3	\N	2016-04-22	-200.00	d2cbf3a725316f70ab82094346a45ee1	2020-10-23 22:10:52.569507	2020-10-23 22:10:52.569507
1113	2	1	-1	2	\N	2016-04-22	-35.30	0aa1883c6411f7873cb83dacb17b0afc	2020-10-23 22:10:52.570717	2020-10-23 22:10:52.570717
1114	2	6	27	2	\N	2016-04-22	-33.30	d64a340bcb633f536d56e51874281454	2020-10-23 22:10:52.571811	2020-10-23 22:10:52.571811
1115	2	4	16	2	\N	2016-04-23	-19.99	08bfb7e81f8e8e69c698fcc37d73c1d4	2020-10-23 22:10:52.573012	2020-10-23 22:10:52.573012
1116	2	4	16	2	\N	2016-04-23	-28.30	08bfb7e81f8e8e69c698fcc37d73c1d4	2020-10-23 22:10:52.574231	2020-10-23 22:10:52.574231
1117	3	9	-1	3	\N	2016-04-22	-3000.00	842ebbc52dfc38e5a94ce5d17e8a4f04	2020-10-23 22:10:52.575457	2020-10-23 22:10:52.575457
1118	5	9	-1	4	\N	2016-04-22	500.00	888b2487d53d5c9c571b5c197abf25e5	2020-10-23 22:10:52.576796	2020-10-23 22:10:52.576796
1119	1	9	-1	4	\N	2016-04-22	2500.00	a94e12226a9c01600ac0d46ea11359e2	2020-10-23 22:10:52.578045	2020-10-23 22:10:52.578045
1120	5	1	-1	2	\N	2016-04-23	-17.73	da86afcc58037b32c437365de9fd9566	2020-10-23 22:10:52.579327	2020-10-23 22:10:52.579327
1121	5	1	-1	2	\N	2016-04-23	-111.71	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:52.580594	2020-10-23 22:10:52.580594
1122	1	1	-1	2	\N	2016-04-21	-16.37	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.581783	2020-10-23 22:10:52.581783
1123	1	1	-1	2	\N	2016-04-21	-6.77	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.582923	2020-10-23 22:10:52.582923
1124	1	1	11	2	\N	2016-04-22	-21.89	2f404348efdd07119956bd6a6011978c	2020-10-23 22:10:52.584189	2020-10-23 22:10:52.584189
1125	1	1	-1	2	\N	2016-04-22	-14.98	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:52.585793	2020-10-23 22:10:52.585793
1126	1	1	-1	2	\N	2016-04-22	-30.96	c45147dee729311ef5b5c3003946c48f	2020-10-23 22:10:52.58713	2020-10-23 22:10:52.58713
1127	5	1	-1	2	\N	2016-04-23	-9.38	8c6e9167014d9aad2317354d0948973d	2020-10-23 22:10:52.588408	2020-10-23 22:10:52.588408
1128	5	9	-1	2	\N	2016-04-23	-11.00	c1445cabed5c957bd296c8f327306d5a	2020-10-23 22:10:52.58972	2020-10-23 22:10:52.58972
1129	1	8	43	2	\N	2016-04-26	-2070.00	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:10:52.590993	2020-10-23 22:10:52.590993
1130	5	1	-1	2	\N	2016-04-24	-10.20	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:10:52.592221	2020-10-23 22:10:52.592221
1131	1	1	11	2	\N	2016-04-26	-4.29	ca46c1b9512a7a8315fa3c5a946e8265	2020-10-23 22:10:52.593461	2020-10-23 22:10:52.593461
1132	1	1	-1	2	\N	2016-04-26	-12.00	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:10:52.594714	2020-10-23 22:10:52.594714
1133	1	1	-1	2	\N	2016-04-26	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.596244	2020-10-23 22:10:52.596244
1134	1	1	-1	2	\N	2016-04-26	-20.00	f0c7c8ee504f69ff718e8b26f949220a	2020-10-23 22:10:52.598392	2020-10-23 22:10:52.598392
1135	1	1	-1	2	\N	2016-04-26	-25.00	1960f108636b1f7a73a595cb3e8a19f6	2020-10-23 22:10:52.599684	2020-10-23 22:10:52.599684
1136	1	1	-1	2	\N	2016-04-27	-3.85	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.601182	2020-10-23 22:10:52.601182
1137	1	2	3	1	\N	2016-04-26	8303.05	2f10228cee7feec8a8a740166e66fe13	2020-10-23 22:10:52.602506	2020-10-23 22:10:52.602506
1138	5	1	-1	2	\N	2016-04-24	-10.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:52.603755	2020-10-23 22:10:52.603755
1139	5	4	16	2	\N	2016-04-25	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:52.605421	2020-10-23 22:10:52.605421
1140	5	1	-1	2	\N	2016-04-27	-7.60	53e14307da50fefa8918c8e92be644b6	2020-10-23 22:10:52.606803	2020-10-23 22:10:52.606803
1141	1	9	48	2	\N	2016-04-27	-107.97	e27378559b6bd4675c207991d921ceda	2020-10-23 22:10:52.608153	2020-10-23 22:10:52.608153
1142	1	10	54	3	\N	2016-04-27	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:52.609358	2020-10-23 22:10:52.609358
1143	1	10	54	3	\N	2016-04-27	-1500.00	f9db0a0d0c761f5849975f0227f6cce5	2020-10-23 22:10:52.610461	2020-10-23 22:10:52.610461
1144	5	10	54	4	\N	2016-04-27	1500.00	f9db0a0d0c761f5849975f0227f6cce5	2020-10-23 22:10:52.611608	2020-10-23 22:10:52.611608
1145	1	10	54	3	\N	2016-04-27	-5000.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:52.612791	2020-10-23 22:10:52.612791
1146	3	10	54	4	\N	2016-04-27	5000.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:52.613984	2020-10-23 22:10:52.613984
1147	1	10	54	3	\N	2016-04-27	-1000.00	3328bdf9a4b9504b9398284244fe97c2	2020-10-23 22:10:52.615109	2020-10-23 22:10:52.615109
1148	6	10	54	4	\N	2016-04-27	1000.00	3328bdf9a4b9504b9398284244fe97c2	2020-10-23 22:10:52.616315	2020-10-23 22:10:52.616315
1149	2	4	18	2	\N	2016-04-26	-42.05	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:52.617567	2020-10-23 22:10:52.617567
1150	5	1	-1	2	\N	2016-04-26	-17.50	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.619352	2020-10-23 22:10:52.619352
1151	2	1	-1	1	\N	2016-04-26	17.50	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.620772	2020-10-23 22:10:52.620772
1152	2	2	3	1	\N	2016-04-27	3742.30	e7f8a7fb0b77bcb3b283af5be021448f	2020-10-23 22:10:52.622008	2020-10-23 22:10:52.622008
1153	5	1	-1	2	\N	2016-04-28	-59.41	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:10:52.623552	2020-10-23 22:10:52.623552
1154	2	1	-1	1	\N	2016-04-28	59.41	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:10:52.624743	2020-10-23 22:10:52.624743
1155	5	1	-1	2	\N	2016-04-28	-35.30	c9ddbd1c832b879ddc41cc06135adc80	2020-10-23 22:10:52.626147	2020-10-23 22:10:52.626147
1156	5	6	27	2	\N	2016-04-28	-33.30	c1c01d0de6527b17f76bac3d48a7117e	2020-10-23 22:10:52.627312	2020-10-23 22:10:52.627312
1157	2	1	-1	1	\N	2016-04-28	35.30	c9ddbd1c832b879ddc41cc06135adc80	2020-10-23 22:10:52.628384	2020-10-23 22:10:52.628384
1158	2	6	27	1	\N	2016-04-28	33.30	c1c01d0de6527b17f76bac3d48a7117e	2020-10-23 22:10:52.629529	2020-10-23 22:10:52.629529
1159	2	10	54	3	\N	2016-04-28	-900.00	2fbd284a27d3bd75eb1f86e36c33d9e2	2020-10-23 22:10:52.630702	2020-10-23 22:10:52.630702
1160	5	10	54	4	\N	2016-04-28	900.00	2fbd284a27d3bd75eb1f86e36c33d9e2	2020-10-23 22:10:52.632153	2020-10-23 22:10:52.632153
1161	2	10	54	3	\N	2016-04-28	-900.00	359de4a25a64387a87452c97aaf61715	2020-10-23 22:10:52.633425	2020-10-23 22:10:52.633425
1162	6	10	54	4	\N	2016-04-28	900.00	359de4a25a64387a87452c97aaf61715	2020-10-23 22:10:52.634607	2020-10-23 22:10:52.634607
1163	5	4	13	2	\N	2016-04-28	-349.79	65b9eea6e1cc6bb9f0cd2a47751a186f	2020-10-23 22:10:52.636279	2020-10-23 22:10:52.636279
1164	5	4	15	2	\N	2016-04-28	-96.17	2f10228cee7feec8a8a740166e66fe13	2020-10-23 22:10:52.637549	2020-10-23 22:10:52.637549
1165	5	4	14	2	\N	2016-04-28	-94.22	077e29b11be80ab57e1a2ecabb7da330	2020-10-23 22:10:52.638751	2020-10-23 22:10:52.638751
1166	1	1	-1	2	\N	2016-04-28	-3.59	69e936d7bf29f02c8d4b809619b7596a	2020-10-23 22:10:52.63989	2020-10-23 22:10:52.63989
1167	1	1	-1	2	\N	2016-04-28	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.641384	2020-10-23 22:10:52.641384
1168	5	5	23	2	\N	2016-04-29	-122.12	58238e9ae2dd305d79c2ebc8c1883422	2020-10-23 22:10:52.642674	2020-10-23 22:10:52.642674
1169	2	5	21	2	\N	2016-04-29	-5.24	0fcbc61acd0479dc77e3cccc0f5ffca7	2020-10-23 22:10:52.643875	2020-10-23 22:10:52.643875
1170	5	5	21	2	\N	2016-04-29	-29.90	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:10:52.645334	2020-10-23 22:10:52.645334
1171	5	5	21	2	\N	2016-04-29	-98.73	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:52.646476	2020-10-23 22:10:52.646476
1172	5	5	21	2	\N	2016-04-29	-23.99	16ecfd64586ec6c1ab212762c2c38a90	2020-10-23 22:10:52.647621	2020-10-23 22:10:52.647621
1173	5	8	43	2	\N	2016-04-29	-174.57	11340131feec68e7ca463f960f0f341c	2020-10-23 22:10:52.648914	2020-10-23 22:10:52.648914
1174	1	1	-1	2	\N	2016-04-30	-45.10	8d70912d7789d196b998e3d5728d0473	2020-10-23 22:10:52.650306	2020-10-23 22:10:52.650306
1175	6	10	54	1	\N	2016-04-30	31.13	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:52.651512	2020-10-23 22:10:52.651512
1176	5	1	-1	2	\N	2016-05-02	-43.30	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:52.652778	2020-10-23 22:10:52.652778
1177	1	1	-1	2	\N	2016-05-02	-2.45	47470cd2665db5bedbaa1a75256db736	2020-10-23 22:10:52.653981	2020-10-23 22:10:52.653981
1178	1	1	-1	2	\N	2016-05-03	-5.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:52.655116	2020-10-23 22:10:52.655116
1179	1	1	-1	2	\N	2016-05-03	-6.58	c8fbbe3ab0d6d8839244383ae4887a0d	2020-10-23 22:10:52.656235	2020-10-23 22:10:52.656235
1180	5	1	-1	2	\N	2016-05-04	-16.04	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:10:52.657528	2020-10-23 22:10:52.657528
1181	2	9	-1	2	\N	2016-05-05	-29.99	ab095d255486a6e82e6e4dce89468cf5	2020-10-23 22:10:52.658917	2020-10-23 22:10:52.658917
1182	2	4	18	2	\N	2016-05-05	-40.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:10:52.660163	2020-10-23 22:10:52.660163
1183	5	9	48	2	\N	2016-05-06	-89.70	3bae86cea8b0298f34b0847fca86361a	2020-10-23 22:10:52.661958	2020-10-23 22:10:52.661958
1184	2	9	48	1	\N	2016-05-06	89.70	3bae86cea8b0298f34b0847fca86361a	2020-10-23 22:10:52.663307	2020-10-23 22:10:52.663307
1185	2	5	21	2	\N	2016-05-06	-11.57	420f617ae7f67a7bff593ee517f976a4	2020-10-23 22:10:52.664635	2020-10-23 22:10:52.664635
1186	5	9	48	1	\N	2016-05-07	100.00	3cf166c6b73f030b4f67eeaeba301103	2020-10-23 22:10:52.665892	2020-10-23 22:10:52.665892
1187	5	1	-1	2	\N	2016-05-08	-32.00	0353ab4cbed5beae847a7ff6e220b5cf	2020-10-23 22:10:52.667173	2020-10-23 22:10:52.667173
1188	5	5	21	2	\N	2016-05-08	-49.99	044f2a6eda8910a8c2fbab0a3d79452c	2020-10-23 22:10:52.668567	2020-10-23 22:10:52.668567
1189	1	8	41	2	\N	2016-05-10	-46.00	a562cfa07c2b1213b3a5c99b756fc206	2020-10-23 22:10:52.670303	2020-10-23 22:10:52.670303
1190	1	9	-1	4	\N	2016-05-04	3000.00	3ee13bad273a0cf15204ed51a77e236c	2020-10-23 22:10:52.671667	2020-10-23 22:10:52.671667
1191	3	9	-1	3	\N	2016-05-04	-3000.00	3ee13bad273a0cf15204ed51a77e236c	2020-10-23 22:10:52.673136	2020-10-23 22:10:52.673136
1192	1	1	-1	2	\N	2016-05-10	-3.85	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.674437	2020-10-23 22:10:52.674437
1193	1	1	-1	2	\N	2016-05-09	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.676391	2020-10-23 22:10:52.676391
1194	1	1	-1	2	\N	2016-05-06	-12.27	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.677996	2020-10-23 22:10:52.677996
1195	5	1	-1	2	\N	2016-05-08	-13.14	f50d2c2f517a1bf37777e5c9ede37e06	2020-10-23 22:10:52.679409	2020-10-23 22:10:52.679409
1196	5	8	43	2	\N	2016-05-08	-158.60	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:10:52.680972	2020-10-23 22:10:52.680972
1197	1	1	-1	2	\N	2016-05-05	-5.47	61c9e7fb675f02218005d1e319984736	2020-10-23 22:10:52.682515	2020-10-23 22:10:52.682515
1198	1	5	21	2	\N	2016-05-05	-11.66	f29c21d4897f78948b91f03172341b7b	2020-10-23 22:10:52.684235	2020-10-23 22:10:52.684235
1199	1	9	48	2	\N	2016-05-05	-116.00	ad71b715717f7e4757565373c1a88e1f	2020-10-23 22:10:52.685772	2020-10-23 22:10:52.685772
1200	1	6	27	2	\N	2016-05-05	-519.98	98b297950041a42470269d56260243a1	2020-10-23 22:10:52.687468	2020-10-23 22:10:52.687468
1201	1	6	27	2	\N	2016-05-05	-549.99	7a900bb74d403cb60a8fa53ce0725dd4	2020-10-23 22:10:52.689003	2020-10-23 22:10:52.689003
1202	1	6	27	2	\N	2016-05-05	-391.68	4f2efd34d6fdca3ad192526b3cdd0002	2020-10-23 22:10:52.690424	2020-10-23 22:10:52.690424
1203	5	1	-1	2	\N	2016-05-10	-47.53	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:52.691841	2020-10-23 22:10:52.691841
1204	2	9	-1	2	\N	2016-05-11	-100.00	d5cfead94f5350c12c322b5b664544c1	2020-10-23 22:10:52.693752	2020-10-23 22:10:52.693752
1205	2	10	54	3	\N	2016-05-11	-1500.00	7386b943e784e95d4a89a28046f86e94	2020-10-23 22:10:52.695684	2020-10-23 22:10:52.695684
1206	4	10	54	4	\N	2016-05-11	1500.00	7386b943e784e95d4a89a28046f86e94	2020-10-23 22:10:52.697109	2020-10-23 22:10:52.697109
1207	2	9	-1	4	\N	2016-05-10	500.00	0df005d77e7ae6f8e415181868650263	2020-10-23 22:10:52.698821	2020-10-23 22:10:52.698821
1208	2	5	21	2	\N	2016-05-02	-134.10	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:10:52.70024	2020-10-23 22:10:52.70024
1209	1	1	11	2	\N	2016-05-11	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:52.701631	2020-10-23 22:10:52.701631
1210	1	1	-1	2	\N	2016-05-11	-4.01	470e7a4f017a5476afb7eeb3f8b96f9b	2020-10-23 22:10:52.703028	2020-10-23 22:10:52.703028
1211	1	1	-1	2	\N	2016-05-11	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.704373	2020-10-23 22:10:52.704373
1212	1	8	41	2	\N	2016-05-11	-11.40	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:10:52.706435	2020-10-23 22:10:52.706435
1213	1	8	41	2	\N	2016-05-11	-28.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:52.708639	2020-10-23 22:10:52.708639
1214	5	6	27	2	\N	2016-05-12	-7.00	432aca3a1e345e339f35a30c8f65edce	2020-10-23 22:10:52.710178	2020-10-23 22:10:52.710178
1215	5	1	-1	2	\N	2016-05-12	-13.00	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:52.712059	2020-10-23 22:10:52.712059
1216	5	5	21	2	\N	2016-05-13	-22.98	be878df20279a2fedfa0386709d4ecae	2020-10-23 22:10:52.713477	2020-10-23 22:10:52.713477
1217	2	6	27	2	\N	2016-05-13	-189.99	912d2b1c7b2826caf99687388d2e8f7c	2020-10-23 22:10:52.714917	2020-10-23 22:10:52.714917
1218	2	5	21	2	\N	2016-05-13	-33.98	e7b24b112a44fdd9ee93bdf998c6ca0e	2020-10-23 22:10:52.716141	2020-10-23 22:10:52.716141
1219	5	1	-1	2	\N	2016-05-13	-9.06	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.717452	2020-10-23 22:10:52.717452
1220	2	1	-1	1	\N	2016-05-13	9.06	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.718931	2020-10-23 22:10:52.718931
1221	1	9	48	2	\N	2016-05-10	-109.00	d98cd8f0408543caaf60d9075191d179	2020-10-23 22:10:52.720301	2020-10-23 22:10:52.720301
1222	1	1	-1	2	\N	2016-05-12	-4.28	470e7a4f017a5476afb7eeb3f8b96f9b	2020-10-23 22:10:52.721586	2020-10-23 22:10:52.721586
1223	1	1	-1	2	\N	2016-05-13	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.72288	2020-10-23 22:10:52.72288
1224	1	1	-1	2	\N	2016-05-12	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.724026	2020-10-23 22:10:52.724026
1225	1	1	-1	2	\N	2016-05-13	-15.65	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.725165	2020-10-23 22:10:52.725165
1226	5	1	-1	2	\N	2016-05-14	-12.62	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:10:52.726435	2020-10-23 22:10:52.726435
1227	5	1	-1	2	\N	2016-05-24	-22.00	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.727699	2020-10-23 22:10:52.727699
1228	2	1	-1	1	\N	2016-05-24	22.00	70975b2698ab9d51a74c6bba22339cd5	2020-10-23 22:10:52.72888	2020-10-23 22:10:52.72888
1229	5	7	30	4	\N	2016-05-14	2000.00	131fb12b08bbc3ab3772e76cca59a3f3	2020-10-23 22:10:52.730027	2020-10-23 22:10:52.730027
1230	6	7	30	3	\N	2016-05-14	-2000.00	131fb12b08bbc3ab3772e76cca59a3f3	2020-10-23 22:10:52.731203	2020-10-23 22:10:52.731203
1231	5	1	-1	2	\N	2016-05-24	-9.48	72c99f8ceac6fefe190e9df14bc38973	2020-10-23 22:10:52.732357	2020-10-23 22:10:52.732357
1232	5	1	-1	2	\N	2016-05-23	-30.63	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.733985	2020-10-23 22:10:52.733985
1233	5	1	-1	2	\N	2016-05-24	-22.79	56ce955b020482d7ba9ca231f499cb2d	2020-10-23 22:10:52.735662	2020-10-23 22:10:52.735662
1234	5	1	-1	2	\N	2016-05-24	-5.77	dd458505749b2941217ddd59394240e8	2020-10-23 22:10:52.737287	2020-10-23 22:10:52.737287
1235	5	1	-1	2	\N	2016-05-24	-69.87	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.738555	2020-10-23 22:10:52.738555
1236	5	1	-1	2	\N	2016-05-20	-231.12	1b566cac7f0519e74f48bc63b8dda470	2020-10-23 22:10:52.739832	2020-10-23 22:10:52.739832
1237	5	1	-1	2	\N	2016-05-17	-39.00	2008f0e5828d906bd21610b729ebc83b	2020-10-23 22:10:52.741025	2020-10-23 22:10:52.741025
1238	5	7	30	2	\N	2016-05-14	-1428.45	2671eb6e9150cf9b53eb39752a1fb21c	2020-10-23 22:10:52.742299	2020-10-23 22:10:52.742299
1239	1	7	37	2	\N	2016-05-22	-89.73	7d0d5a5dd9de1422c29fe8ec87b69204	2020-10-23 22:10:52.743661	2020-10-23 22:10:52.743661
1240	5	1	-1	2	\N	2016-05-26	-11.28	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:10:52.745176	2020-10-23 22:10:52.745176
1241	2	8	41	2	\N	2016-05-26	-5.60	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:52.747661	2020-10-23 22:10:52.747661
1242	2	8	41	2	\N	2016-05-26	-50.00	11b921ef080f7736089c757404650e40	2020-10-23 22:10:52.749001	2020-10-23 22:10:52.749001
1243	2	1	-1	2	\N	2016-05-26	-9.90	6081594975a764c8e3a691fa2b3a321d	2020-10-23 22:10:52.750268	2020-10-23 22:10:52.750268
1244	5	9	48	2	\N	2016-05-26	-6.49	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:10:52.751411	2020-10-23 22:10:52.751411
1245	2	9	48	1	\N	2016-05-26	6.49	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:10:52.752651	2020-10-23 22:10:52.752651
1246	2	4	18	2	\N	2016-05-26	-45.13	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:52.753949	2020-10-23 22:10:52.753949
1247	2	4	16	2	\N	2016-05-26	-20.10	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:52.755123	2020-10-23 22:10:52.755123
1248	2	2	3	1	\N	2016-05-26	5173.68	ca46c1b9512a7a8315fa3c5a946e8265	2020-10-23 22:10:52.756312	2020-10-23 22:10:52.756312
1249	2	10	54	2	\N	2016-05-26	-900.00	42d772b8ec1165757f11de7fc2049563	2020-10-23 22:10:52.757522	2020-10-23 22:10:52.757522
1250	5	10	54	1	\N	2016-05-26	900.00	42d772b8ec1165757f11de7fc2049563	2020-10-23 22:10:52.758612	2020-10-23 22:10:52.758612
1251	2	10	54	2	\N	2016-05-26	-900.00	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:52.759738	2020-10-23 22:10:52.759738
1252	6	10	54	1	\N	2016-05-26	900.00	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:52.760908	2020-10-23 22:10:52.760908
1253	2	10	54	2	\N	2016-05-26	-2200.00	4524f17a5640c6ccc57bc5a68c0ab3b9	2020-10-23 22:10:52.762009	2020-10-23 22:10:52.762009
1254	4	10	54	1	\N	2016-05-26	2200.00	4524f17a5640c6ccc57bc5a68c0ab3b9	2020-10-23 22:10:52.763098	2020-10-23 22:10:52.763098
1255	5	4	13	2	\N	2016-05-26	-349.79	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:10:52.764192	2020-10-23 22:10:52.764192
1256	5	4	15	2	\N	2016-05-26	-96.17	20e9e854760d152615078596780b9a61	2020-10-23 22:10:52.765304	2020-10-23 22:10:52.765304
1257	5	4	14	2	\N	2016-05-26	-96.53	04349b9fb69e76d386f89382c01027d2	2020-10-23 22:10:52.766369	2020-10-23 22:10:52.766369
1258	2	5	25	2	\N	2016-05-27	-35.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:52.767518	2020-10-23 22:10:52.767518
1259	2	1	-1	2	\N	2016-05-27	-9.50	725ad7265830d2c0aae80b6e27b31007	2020-10-23 22:10:52.768794	2020-10-23 22:10:52.768794
1260	2	5	21	2	\N	2016-05-27	-2.99	2f37d10131f2a483a8dd005b3d14b0d9	2020-10-23 22:10:52.770106	2020-10-23 22:10:52.770106
1261	2	8	44	2	\N	2016-05-27	-12.60	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:52.771324	2020-10-23 22:10:52.771324
1262	5	1	-1	2	\N	2016-05-29	-58.10	c25dc000c94b902b8ff197352d4b0b18	2020-10-23 22:10:52.772541	2020-10-23 22:10:52.772541
1263	2	1	-1	1	\N	2016-05-29	58.10	c25dc000c94b902b8ff197352d4b0b18	2020-10-23 22:10:52.774115	2020-10-23 22:10:52.774115
1264	1	2	3	1	\N	2016-05-24	8506.13	05f971b5ec196b8c65b75d2ef8267331	2020-10-23 22:10:52.77542	2020-10-23 22:10:52.77542
1265	1	1	-1	2	\N	2016-05-27	-17.17	138bb0696595b338afbab333c555292a	2020-10-23 22:10:52.777349	2020-10-23 22:10:52.777349
1266	1	1	-1	2	\N	2016-05-27	-4.18	fcdbd14ffa933c5622e48828e824c517	2020-10-23 22:10:52.778998	2020-10-23 22:10:52.778998
1267	1	9	-1	2	\N	2016-05-27	-142.00	0537fb40a68c18da59a35c2bfe1ca554	2020-10-23 22:10:52.78061	2020-10-23 22:10:52.78061
1268	1	8	41	2	\N	2016-05-27	-27.20	71c32595c397960f74555a8b9db16f75	2020-10-23 22:10:52.782306	2020-10-23 22:10:52.782306
1269	1	9	-1	2	\N	2016-05-27	-3.00	01386bd6d8e091c2ab4c7c7de644d37b	2020-10-23 22:10:52.784225	2020-10-23 22:10:52.784225
1270	1	9	-1	2	\N	2016-05-27	-86.00	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:52.786038	2020-10-23 22:10:52.786038
1271	5	1	-1	2	\N	2016-05-30	-8.99	6788875d69976f4d4c84b2812f95d3ac	2020-10-23 22:10:52.787362	2020-10-23 22:10:52.787362
1272	5	1	-1	2	\N	2016-05-30	-5.29	fcdbd14ffa933c5622e48828e824c517	2020-10-23 22:10:52.788513	2020-10-23 22:10:52.788513
1273	1	10	54	3	\N	2016-05-29	-700.00	87c7d2a22550d476eb4ee56e8f88acff	2020-10-23 22:10:52.789756	2020-10-23 22:10:52.789756
1274	1	10	54	3	\N	2016-05-29	-1500.00	b6a1085a27ab7bff7550f8a3bd017df8	2020-10-23 22:10:52.791467	2020-10-23 22:10:52.791467
1275	5	10	54	4	\N	2016-05-29	1500.00	b6a1085a27ab7bff7550f8a3bd017df8	2020-10-23 22:10:52.793257	2020-10-23 22:10:52.793257
1276	1	10	54	3	\N	2016-05-29	-3000.00	334862df8c6258d8d6c93be7058025b1	2020-10-23 22:10:52.794972	2020-10-23 22:10:52.794972
1277	6	10	54	4	\N	2016-05-29	3000.00	334862df8c6258d8d6c93be7058025b1	2020-10-23 22:10:52.796468	2020-10-23 22:10:52.796468
1278	1	1	-1	2	\N	2016-05-28	-60.00	ad8d994fb30388c28ff5100c1a198837	2020-10-23 22:10:52.797927	2020-10-23 22:10:52.797927
1279	1	1	-1	2	\N	2016-05-28	-8.81	f9b37e877ad57838c4b4982d97eaed39	2020-10-23 22:10:52.800215	2020-10-23 22:10:52.800215
1280	1	1	-1	2	\N	2016-05-28	-21.33	06eb133bbfaef5b68abe123e005a7c95	2020-10-23 22:10:52.80194	2020-10-23 22:10:52.80194
1281	1	10	54	3	\N	2016-05-29	-4000.00	db390edd8c6c54dbca9223a278afea44	2020-10-23 22:10:52.804189	2020-10-23 22:10:52.804189
1282	3	10	54	4	\N	2016-05-29	4000.00	db390edd8c6c54dbca9223a278afea44	2020-10-23 22:10:52.805673	2020-10-23 22:10:52.805673
1283	5	1	-1	2	\N	2016-05-29	-180.00	21f8cef79c3df0a9c878be1570b9f3e9	2020-10-23 22:10:52.807007	2020-10-23 22:10:52.807007
1284	1	1	11	2	\N	2016-05-27	-5.29	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:52.808227	2020-10-23 22:10:52.808227
1285	5	1	-1	2	\N	2016-05-27	-10.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.809439	2020-10-23 22:10:52.809439
1286	5	1	-1	2	\N	2016-05-25	-131.49	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.810772	2020-10-23 22:10:52.810772
1287	1	10	54	4	\N	2016-05-25	200.00	fbf70cb49ab268a3ec42a4d17f61390e	2020-10-23 22:10:52.812137	2020-10-23 22:10:52.812137
1288	5	8	43	2	\N	2016-05-29	-23.42	2f5efe02a46206ff8b69e5a57a369e29	2020-10-23 22:10:52.813368	2020-10-23 22:10:52.813368
1289	5	8	43	2	\N	2016-05-29	-65.20	edb10d6f004104105f4331fc67481c54	2020-10-23 22:10:52.814436	2020-10-23 22:10:52.814436
1290	2	8	41	2	\N	2016-05-30	-46.00	35e5113347298d16d27399578ce98659	2020-10-23 22:10:52.815485	2020-10-23 22:10:52.815485
1291	5	4	16	2	\N	2016-05-30	-49.90	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:10:52.816602	2020-10-23 22:10:52.816602
1292	5	1	-1	2	\N	2016-05-30	-54.30	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:52.817755	2020-10-23 22:10:52.817755
1293	2	1	-1	1	\N	2016-05-30	54.30	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:52.819439	2020-10-23 22:10:52.819439
1294	2	9	47	2	\N	2016-05-31	-300.00	512dc597be7ae761876315165dc8bd2e	2020-10-23 22:10:52.820788	2020-10-23 22:10:52.820788
1295	1	8	43	2	\N	2016-05-31	-517.00	33ea2a5e212ab720e2aa929f17630ca7	2020-10-23 22:10:52.822094	2020-10-23 22:10:52.822094
1296	5	1	-1	2	\N	2016-05-02	-43.30	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:52.823377	2020-10-23 22:10:52.823377
1297	5	1	-1	2	\N	2016-06-01	-13.30	dd46269118915f85b343da54b42c11d6	2020-10-23 22:10:52.824656	2020-10-23 22:10:52.824656
1298	2	1	-1	1	\N	2016-06-01	13.30	dd46269118915f85b343da54b42c11d6	2020-10-23 22:10:52.825844	2020-10-23 22:10:52.825844
1299	2	1	-1	2	\N	2016-06-01	-21.90	18a8388cd0c2abde7f0bc0fc214992ae	2020-10-23 22:10:52.827107	2020-10-23 22:10:52.827107
1300	2	1	-1	2	\N	2016-06-01	-5.00	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:10:52.828217	2020-10-23 22:10:52.828217
1301	5	1	-1	2	\N	2016-06-02	-13.86	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.829562	2020-10-23 22:10:52.829562
1302	5	1	-1	2	\N	2016-06-06	-35.50	b90a692ce8297a27fba811452146779e	2020-10-23 22:10:52.830837	2020-10-23 22:10:52.830837
1303	2	1	-1	2	\N	2016-06-03	-1.99	fcb33197307a7df89ae663c88a28721f	2020-10-23 22:10:52.832387	2020-10-23 22:10:52.832387
1304	2	9	48	2	\N	2016-06-04	-4.79	4740a40d683c35180c179cb652706b45	2020-10-23 22:10:52.833582	2020-10-23 22:10:52.833582
1305	2	9	48	2	\N	2016-06-06	-80.00	84206a436129b50ca9d868d99e33e36b	2020-10-23 22:10:52.834744	2020-10-23 22:10:52.834744
1306	5	1	-1	2	\N	2016-06-07	-21.37	7cd98be5e1169540c0d3bffad38df058	2020-10-23 22:10:52.836162	2020-10-23 22:10:52.836162
1307	2	1	-1	2	\N	2016-06-07	-10.90	8d231d47e5d2546508bc630640f7d27c	2020-10-23 22:10:52.837459	2020-10-23 22:10:52.837459
1308	2	1	-1	2	\N	2016-06-08	-35.50	b90a692ce8297a27fba811452146779e	2020-10-23 22:10:52.838732	2020-10-23 22:10:52.838732
1309	5	1	-1	1	\N	2016-06-08	35.50	5cadcd1c9dee49d04a4640e3434c7b3e	2020-10-23 22:10:52.840063	2020-10-23 22:10:52.840063
1310	5	1	-1	2	\N	2016-06-08	-15.78	942dd26dab18af7d4a73fde5adf8d6d4	2020-10-23 22:10:52.841216	2020-10-23 22:10:52.841216
1311	5	9	-1	2	\N	2016-06-04	-500.00	07d82a6b4d8450ab912608a93f8a24d4	2020-10-23 22:10:52.842374	2020-10-23 22:10:52.842374
1312	5	8	43	2	\N	2016-06-01	-192.01	2c9c0b5d3d18d1024a0f64a89770eb83	2020-10-23 22:10:52.843587	2020-10-23 22:10:52.843587
1313	5	8	43	2	\N	2016-06-05	-188.43	0a0a258559b3c442d31b81f1e40c0d65	2020-10-23 22:10:52.844832	2020-10-23 22:10:52.844832
1314	5	8	43	2	\N	2016-06-03	-183.74	4a47d2983c8bd392b120b627e0e1cab4	2020-10-23 22:10:52.84623	2020-10-23 22:10:52.84623
1315	5	8	43	2	\N	2016-06-08	-517.00	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:10:52.847468	2020-10-23 22:10:52.847468
1316	1	1	11	2	\N	2016-06-07	-2.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.848751	2020-10-23 22:10:52.848751
1317	1	1	-1	2	\N	2016-06-03	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.849928	2020-10-23 22:10:52.849928
1318	1	1	-1	2	\N	2016-06-07	-3.64	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:52.851342	2020-10-23 22:10:52.851342
1319	1	1	-1	2	\N	2016-06-06	-5.56	297cd5b16264aab5b31ea30886c86798	2020-10-23 22:10:52.853144	2020-10-23 22:10:52.853144
1320	1	1	-1	2	\N	2016-06-06	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.854332	2020-10-23 22:10:52.854332
1321	1	1	-1	2	\N	2016-06-04	-23.02	2d709130f7e61ad0622f575e922d393b	2020-10-23 22:10:52.855604	2020-10-23 22:10:52.855604
1322	1	1	-1	2	\N	2016-06-03	-3.32	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:52.856909	2020-10-23 22:10:52.856909
1323	5	1	-1	2	\N	2016-06-09	-15.96	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:10:52.858105	2020-10-23 22:10:52.858105
1324	5	9	48	2	\N	2016-06-09	-49.99	1960f108636b1f7a73a595cb3e8a19f6	2020-10-23 22:10:52.859405	2020-10-23 22:10:52.859405
1325	2	6	27	2	\N	2016-06-09	-16.00	fac79668dfbfbe6295cfe751f7170da2	2020-10-23 22:10:52.860619	2020-10-23 22:10:52.860619
1326	5	1	-1	2	\N	2016-06-09	-6.50	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:10:52.861823	2020-10-23 22:10:52.861823
1327	2	1	-1	2	\N	2016-06-09	-6.10	ab3097f1abb246275a855ea1531ac311	2020-10-23 22:10:52.863041	2020-10-23 22:10:52.863041
1328	5	9	-1	2	\N	2016-06-09	-36.50	49c9adb18e44be0711a94e827042f630	2020-10-23 22:10:52.864205	2020-10-23 22:10:52.864205
1329	2	9	-1	1	\N	2016-06-09	36.50	4d439535a3065efd10d37a80209d14ee	2020-10-23 22:10:52.865563	2020-10-23 22:10:52.865563
1330	5	1	-1	2	\N	2016-06-10	-15.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:52.867001	2020-10-23 22:10:52.867001
1331	2	1	-1	2	\N	2016-06-10	-14.00	5dd033d162065873ffdfa5c0ec597932	2020-10-23 22:10:52.868394	2020-10-23 22:10:52.868394
1332	1	1	-1	2	\N	2016-06-09	-3.18	888e77686074d437aa3708f892dd0daa	2020-10-23 22:10:52.870434	2020-10-23 22:10:52.870434
1333	1	1	-1	2	\N	2016-06-09	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:52.871904	2020-10-23 22:10:52.871904
1334	5	1	-1	2	\N	2016-06-11	-114.39	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.873059	2020-10-23 22:10:52.873059
1335	1	1	-1	2	\N	2016-06-10	-20.55	10b50c8fd7af85a29d6f942567f74e4f	2020-10-23 22:10:52.87422	2020-10-23 22:10:52.87422
1336	1	1	-1	2	\N	2016-06-10	-3.12	26e31959fc4d7f3a335e9fc023ad2b75	2020-10-23 22:10:52.875331	2020-10-23 22:10:52.875331
1337	1	1	-1	2	\N	2016-06-11	-130.10	831eae3fa74b59c3c943ad25f7b952bf	2020-10-23 22:10:52.876498	2020-10-23 22:10:52.876498
1338	2	7	31	2	\N	2016-06-12	-14.00	3d8e28caf901313a554cebc7d32e67e5	2020-10-23 22:10:52.877634	2020-10-23 22:10:52.877634
1339	2	1	-1	2	\N	2016-06-12	-11.50	4784ff28c0957a6847114429c529813a	2020-10-23 22:10:52.878702	2020-10-23 22:10:52.878702
1340	2	1	-1	2	\N	2016-06-12	-15.80	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:52.879945	2020-10-23 22:10:52.879945
1341	5	1	-1	2	\N	2016-06-12	-15.80	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:52.881156	2020-10-23 22:10:52.881156
1342	2	1	-1	1	\N	2016-06-12	15.80	07673633ee8436ef816e5133e01bda75	2020-10-23 22:10:52.882359	2020-10-23 22:10:52.882359
1343	1	1	11	2	\N	2016-06-12	-8.47	a5fb920139997fc286c0f7c25734279c	2020-10-23 22:10:52.883735	2020-10-23 22:10:52.883735
1344	5	6	27	2	\N	2016-06-13	-99.81	b597e5b0e7970deda3d6cf8017b929b7	2020-10-23 22:10:52.885281	2020-10-23 22:10:52.885281
1345	2	6	27	2	\N	2016-06-13	-22.00	51899e8e7e59413bbffce38d3664b184	2020-10-23 22:10:52.887354	2020-10-23 22:10:52.887354
1346	2	1	-1	2	\N	2016-06-13	-11.20	aa169b49b583a2b5af89203c2b78c67c	2020-10-23 22:10:52.888867	2020-10-23 22:10:52.888867
1347	2	1	-1	2	\N	2016-06-15	-11.00	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:52.890067	2020-10-23 22:10:52.890067
1348	2	1	-1	2	\N	2016-06-15	-40.73	d1f491a404d6854880943e5c3cd9ca25	2020-10-23 22:10:52.89201	2020-10-23 22:10:52.89201
1349	2	6	27	2	\N	2016-06-15	-39.99	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:52.893798	2020-10-23 22:10:52.893798
1350	2	9	48	2	\N	2016-06-15	-64.90	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:10:52.895068	2020-10-23 22:10:52.895068
1351	2	4	16	2	\N	2016-06-16	-19.99	901695fb1e54f4a451ba70a6e45d9d8d	2020-10-23 22:10:52.896268	2020-10-23 22:10:52.896268
1352	2	5	21	2	\N	2016-06-16	-14.10	dc6a6489640ca02b0d42dabeb8e46bb7	2020-10-23 22:10:52.897549	2020-10-23 22:10:52.897549
1353	2	5	21	2	\N	2016-06-16	-35.27	525b5a44998bc501be69d1f148861a78	2020-10-23 22:10:52.898789	2020-10-23 22:10:52.898789
1354	6	9	-1	3	\N	2016-06-16	-973.62	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.900374	2020-10-23 22:10:52.900374
1355	5	9	-1	4	\N	2016-06-16	973.62	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:52.901993	2020-10-23 22:10:52.901993
1356	5	1	-1	2	\N	2016-06-17	-19.28	839ab46820b524afda05122893c2fe8e	2020-10-23 22:10:52.903351	2020-10-23 22:10:52.903351
1357	2	1	-1	2	\N	2016-06-17	-19.70	f57a2f557b098c43f11ab969efe1504b	2020-10-23 22:10:52.904849	2020-10-23 22:10:52.904849
1358	5	1	-1	2	\N	2016-06-17	-82.63	11364907cf269dd2183b64287156072a	2020-10-23 22:10:52.90622	2020-10-23 22:10:52.90622
1359	2	1	-1	1	\N	2016-06-17	82.63	11364907cf269dd2183b64287156072a	2020-10-23 22:10:52.907439	2020-10-23 22:10:52.907439
1360	5	6	27	2	\N	2016-06-17	-22.00	bc288159fa4e86c5b5d99e2446033f9a	2020-10-23 22:10:52.908782	2020-10-23 22:10:52.908782
1361	2	6	27	1	\N	2016-06-17	22.00	bc288159fa4e86c5b5d99e2446033f9a	2020-10-23 22:10:52.91004	2020-10-23 22:10:52.91004
1362	1	8	41	2	\N	2016-06-17	-6.20	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:10:52.911083	2020-10-23 22:10:52.911083
1363	1	5	21	2	\N	2016-06-13	-103.41	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:52.912167	2020-10-23 22:10:52.912167
1364	1	1	-1	2	\N	2016-06-17	-5.03	d7131d1ae44bc08bfaea5b61f9be7f11	2020-10-23 22:10:52.913306	2020-10-23 22:10:52.913306
1365	1	1	-1	2	\N	2016-06-13	-11.52	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.914519	2020-10-23 22:10:52.914519
1366	1	1	-1	2	\N	2016-06-13	-3.92	d7131d1ae44bc08bfaea5b61f9be7f11	2020-10-23 22:10:52.915802	2020-10-23 22:10:52.915802
1367	1	1	-1	2	\N	2016-06-13	-3.50	e6d847d396d27a844f169a7798df228c	2020-10-23 22:10:52.916958	2020-10-23 22:10:52.916958
1368	1	1	-1	2	\N	2016-06-16	-23.84	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.918031	2020-10-23 22:10:52.918031
1369	1	1	-1	2	\N	2016-06-16	-6.78	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:52.919406	2020-10-23 22:10:52.919406
1370	5	1	-1	2	\N	2016-06-18	-17.11	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:52.920963	2020-10-23 22:10:52.920963
1371	1	1	-1	2	\N	2016-06-18	-6.58	eed5af6add95a9a6f1252739b1ad8c24	2020-10-23 22:10:52.922269	2020-10-23 22:10:52.922269
1372	5	1	-1	2	\N	2016-06-18	-68.58	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:52.923503	2020-10-23 22:10:52.923503
1373	2	1	-1	2	\N	2016-06-18	-9.00	853c0eb6fd1ca116dfe81feb04265569	2020-10-23 22:10:52.924683	2020-10-23 22:10:52.924683
1374	2	1	-1	2	\N	2016-06-18	-8.00	c172a8ce69eede4a9d5041fbe039bfd8	2020-10-23 22:10:52.926187	2020-10-23 22:10:52.926187
1375	2	1	-1	2	\N	2016-06-18	-8.00	c172a8ce69eede4a9d5041fbe039bfd8	2020-10-23 22:10:52.927735	2020-10-23 22:10:52.927735
1376	2	1	-1	2	\N	2016-06-18	-27.00	796a87242da86a3f65b913140a7868df	2020-10-23 22:10:52.929135	2020-10-23 22:10:52.929135
1377	2	1	-1	2	\N	2016-06-18	-9.50	0353ab4cbed5beae847a7ff6e220b5cf	2020-10-23 22:10:52.930225	2020-10-23 22:10:52.930225
1378	5	1	-1	2	\N	2016-06-18	-9.50	a0b6652366863f9e6851b71382b9571d	2020-10-23 22:10:52.931305	2020-10-23 22:10:52.931305
1379	2	1	-1	1	\N	2016-06-18	9.50	a0b6652366863f9e6851b71382b9571d	2020-10-23 22:10:52.932465	2020-10-23 22:10:52.932465
1380	2	6	27	2	\N	2016-06-19	-45.50	621461af90cadfdaf0e8d4cc25129f91	2020-10-23 22:10:52.933863	2020-10-23 22:10:52.933863
1381	2	1	-1	2	\N	2016-06-19	-28.80	027e000db6f954acc3a36bebb8ca2b79	2020-10-23 22:10:52.935653	2020-10-23 22:10:52.935653
1382	5	6	27	2	\N	2016-06-19	-33.00	a532400ed62e772b9dc0b86f46e583ff	2020-10-23 22:10:52.937089	2020-10-23 22:10:52.937089
1383	5	1	-1	2	\N	2016-06-19	-28.80	633d8ed2e4a7f07c8419f2678a0f1ca3	2020-10-23 22:10:52.93881	2020-10-23 22:10:52.93881
1384	2	6	27	1	\N	2016-06-19	33.00	a532400ed62e772b9dc0b86f46e583ff	2020-10-23 22:10:52.940276	2020-10-23 22:10:52.940276
1385	2	1	-1	1	\N	2016-06-19	28.80	633d8ed2e4a7f07c8419f2678a0f1ca3	2020-10-23 22:10:52.941755	2020-10-23 22:10:52.941755
1386	2	1	-1	2	\N	2016-06-21	-20.92	1ddd5cbfaad65fd327ac0cb6ad8ca2b8	2020-10-23 22:10:52.943082	2020-10-23 22:10:52.943082
1387	5	1	-1	2	\N	2016-06-21	-20.92	b1c9d27f61ccd2d29637f0c0bc65c19f	2020-10-23 22:10:52.944506	2020-10-23 22:10:52.944506
1388	2	1	-1	1	\N	2016-06-21	20.92	5fe8a1fd7ab33a21e76fb8429d31b0e7	2020-10-23 22:10:52.945998	2020-10-23 22:10:52.945998
1389	2	1	-1	2	\N	2016-06-22	-17.18	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:52.947638	2020-10-23 22:10:52.947638
1390	5	1	-1	2	\N	2016-06-21	-17.18	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:10:52.949247	2020-10-23 22:10:52.949247
1391	2	1	-1	1	\N	2016-06-21	17.18	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:10:52.950922	2020-10-23 22:10:52.950922
1392	2	6	27	2	\N	2016-06-22	-45.00	76dc611d6ebaafc66cc0879c71b5db5c	2020-10-23 22:10:52.952741	2020-10-23 22:10:52.952741
1393	2	5	21	2	\N	2016-06-22	-23.97	53c3bce66e43be4f209556518c2fcb54	2020-10-23 22:10:52.954367	2020-10-23 22:10:52.954367
1394	2	6	27	2	\N	2016-06-23	-44.60	da3c56867333df0fff5655eac38d0630	2020-10-23 22:10:52.956197	2020-10-23 22:10:52.956197
1395	2	6	27	2	\N	2016-06-23	-55.70	4324bb834e17ddb66ac56d51a659dace	2020-10-23 22:10:52.958335	2020-10-23 22:10:52.958335
1396	2	9	48	2	\N	2016-06-23	-39.90	528226d422b003bce28af6446108fc1d	2020-10-23 22:10:52.959613	2020-10-23 22:10:52.959613
1397	2	1	-1	2	\N	2016-06-23	-14.00	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:52.96148	2020-10-23 22:10:52.96148
1398	2	5	21	2	\N	2016-06-24	-7.99	1816533e898f2ead4768e0aaae739883	2020-10-23 22:10:52.963314	2020-10-23 22:10:52.963314
1399	1	1	-1	2	\N	2016-06-23	-4.00	e6d847d396d27a844f169a7798df228c	2020-10-23 22:10:52.964888	2020-10-23 22:10:52.964888
1400	1	1	11	2	\N	2016-06-23	-2.00	1905aedab9bf2477edc068a355bba31a	2020-10-23 22:10:52.966264	2020-10-23 22:10:52.966264
1401	1	1	-1	2	\N	2016-06-22	-21.62	c8fbbe3ab0d6d8839244383ae4887a0d	2020-10-23 22:10:52.968342	2020-10-23 22:10:52.968342
1402	1	8	42	2	\N	2016-06-24	-29.10	c30a5fa5e5905eac744ef8c427d1ce38	2020-10-23 22:10:52.969802	2020-10-23 22:10:52.969802
1403	1	1	-1	2	\N	2016-06-23	-15.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:52.971601	2020-10-23 22:10:52.971601
1404	1	8	41	2	\N	2016-06-21	-46.00	e1e32e235eee1f970470a3a6658dfdd5	2020-10-23 22:10:52.973047	2020-10-23 22:10:52.973047
1405	1	2	3	1	\N	2016-06-24	8303.05	4d4ee54ba23dc3bf49ed799a9e56064e	2020-10-23 22:10:52.974375	2020-10-23 22:10:52.974375
1406	1	10	54	3	\N	2016-06-24	-1500.00	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:52.975964	2020-10-23 22:10:52.975964
1407	5	10	54	4	\N	2016-06-24	1500.00	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:52.977286	2020-10-23 22:10:52.977286
1408	1	10	54	3	\N	2016-06-24	-500.00	6f8a28be5f158752eba976d9a69f6abb	2020-10-23 22:10:52.978926	2020-10-23 22:10:52.978926
1409	1	8	41	2	\N	2016-06-24	-27.99	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:52.980997	2020-10-23 22:10:52.980997
1410	1	10	54	3	\N	2016-06-24	-1000.00	b2737b37b181300a80927e307554821a	2020-10-23 22:10:52.982336	2020-10-23 22:10:52.982336
1411	3	10	54	4	\N	2016-06-24	1000.00	b2737b37b181300a80927e307554821a	2020-10-23 22:10:52.98391	2020-10-23 22:10:52.98391
1412	1	10	54	3	\N	2016-06-24	-5000.00	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:10:52.985761	2020-10-23 22:10:52.985761
1413	6	10	54	4	\N	2016-06-24	5000.00	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:10:52.98745	2020-10-23 22:10:52.98745
1414	1	1	-1	2	\N	2016-06-25	-4.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:52.988854	2020-10-23 22:10:52.988854
1415	5	1	-1	2	\N	2016-06-25	-2.55	952d723fab28e9efa0d1f6e46e033358	2020-10-23 22:10:52.990171	2020-10-23 22:10:52.990171
1416	5	1	-1	2	\N	2016-06-25	-7.20	7f5144f962efde75e0f7661e032166db	2020-10-23 22:10:52.991607	2020-10-23 22:10:52.991607
1417	1	1	-1	2	\N	2016-06-25	-25.12	10b50c8fd7af85a29d6f942567f74e4f	2020-10-23 22:10:52.993105	2020-10-23 22:10:52.993105
1418	1	1	11	2	\N	2016-06-25	-10.00	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:52.994559	2020-10-23 22:10:52.994559
1419	5	1	-1	2	\N	2016-06-25	-14.91	29d77601560ca1600158ecd574fe5c96	2020-10-23 22:10:52.995957	2020-10-23 22:10:52.995957
1420	5	1	-1	2	\N	2016-06-25	-155.25	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:52.997255	2020-10-23 22:10:52.997255
1421	5	1	-1	2	\N	2016-06-26	-40.00	00005d789ce172f162aaa14e74364fd5	2020-10-23 22:10:52.998922	2020-10-23 22:10:52.998922
1422	1	1	-1	2	\N	2016-06-26	-9.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:53.00025	2020-10-23 22:10:53.00025
1423	2	1	-1	2	\N	2016-06-26	-36.41	4d0c5af710fb34ba9877183bf7e05b15	2020-10-23 22:10:53.001782	2020-10-23 22:10:53.001782
1424	5	1	-1	2	\N	2016-06-26	-36.41	d240e3d38a8882ecad8633c8f9c78c9b	2020-10-23 22:10:53.003606	2020-10-23 22:10:53.003606
1425	2	1	-1	1	\N	2016-06-26	36.41	d240e3d38a8882ecad8633c8f9c78c9b	2020-10-23 22:10:53.006001	2020-10-23 22:10:53.006001
1426	2	1	-1	2	\N	2016-06-26	-9.50	7bd04fa5dbafcb47a21b66b5de1044dd	2020-10-23 22:10:53.0077	2020-10-23 22:10:53.0077
1427	2	7	33	2	\N	2016-06-26	-10.00	d9cd488a4b1da83f8bf027474788f679	2020-10-23 22:10:53.009492	2020-10-23 22:10:53.009492
1428	1	1	-1	2	\N	2016-06-26	-0.99	796a87242da86a3f65b913140a7868df	2020-10-23 22:10:53.011089	2020-10-23 22:10:53.011089
1429	5	5	23	2	\N	2016-06-27	-12.95	b6edc1cd1f36e45daf6d7824d7bb2283	2020-10-23 22:10:53.012742	2020-10-23 22:10:53.012742
1430	2	1	-1	2	\N	2016-06-27	-10.30	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:53.014409	2020-10-23 22:10:53.014409
1431	5	4	16	2	\N	2016-06-27	-49.90	dba0cfd90a67544dc80e9af70c8c1b4d	2020-10-23 22:10:53.015898	2020-10-23 22:10:53.015898
1432	2	2	3	1	\N	2016-06-27	3734.30	d707329bece455a462b58ce00d1194c9	2020-10-23 22:10:53.017393	2020-10-23 22:10:53.017393
1433	2	10	54	3	\N	2016-06-27	-900.00	245894da7605c9899120033b962320c3	2020-10-23 22:10:53.019154	2020-10-23 22:10:53.019154
1434	2	10	54	3	\N	2016-06-27	-900.00	83bbec8bc6092eeaef162a47125cfcf9	2020-10-23 22:10:53.020658	2020-10-23 22:10:53.020658
1435	5	10	54	4	\N	2016-06-27	900.00	245894da7605c9899120033b962320c3	2020-10-23 22:10:53.022156	2020-10-23 22:10:53.022156
1436	6	10	54	4	\N	2016-06-27	900.00	83bbec8bc6092eeaef162a47125cfcf9	2020-10-23 22:10:53.023567	2020-10-23 22:10:53.023567
1437	2	10	54	3	\N	2016-06-27	-1100.00	2e65f2f2fdaf6c699b223c61b1b5ab89	2020-10-23 22:10:53.024957	2020-10-23 22:10:53.024957
1438	6	10	54	4	\N	2016-06-27	1100.00	2e65f2f2fdaf6c699b223c61b1b5ab89	2020-10-23 22:10:53.02626	2020-10-23 22:10:53.02626
1439	5	4	13	2	\N	2016-06-28	-373.99	89b327b02ad20e9d93a23c30a3bfa1bf	2020-10-23 22:10:53.027568	2020-10-23 22:10:53.027568
1440	5	4	15	2	\N	2016-06-28	-96.17	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:10:53.028943	2020-10-23 22:10:53.028943
1441	2	4	18	2	\N	2016-06-28	-39.99	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:53.030183	2020-10-23 22:10:53.030183
1442	5	1	-1	2	\N	2016-06-28	-60.53	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:10:53.031495	2020-10-23 22:10:53.031495
1443	1	1	-1	2	\N	2016-06-27	-3.50	e6d847d396d27a844f169a7798df228c	2020-10-23 22:10:53.03277	2020-10-23 22:10:53.03277
1444	1	9	49	2	\N	2016-06-28	-364.00	42e7aaa88b48137a16a1acd04ed91125	2020-10-23 22:10:53.034166	2020-10-23 22:10:53.034166
1445	1	1	-1	2	\N	2016-06-27	-23.55	8c3db30aba706c50b2a8497efa43b872	2020-10-23 22:10:53.036157	2020-10-23 22:10:53.036157
1446	1	6	27	2	\N	2016-06-28	-75.02	879fb036880969b30cccd23864ffb047	2020-10-23 22:10:53.037632	2020-10-23 22:10:53.037632
1447	5	5	23	2	\N	2016-06-29	-43.60	29657d5f5b1930d00169d7a0378e395b	2020-10-23 22:10:53.039155	2020-10-23 22:10:53.039155
1448	2	1	-1	2	\N	2016-06-29	-4.50	a71d83915f8839e1da511021db1b3aa0	2020-10-23 22:10:53.040464	2020-10-23 22:10:53.040464
1449	2	1	-1	2	\N	2016-06-30	-19.50	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:10:53.041972	2020-10-23 22:10:53.041972
1450	5	1	-1	2	\N	2016-06-30	-29.80	733acea111e5db580f48512a78b88af7	2020-10-23 22:10:53.043815	2020-10-23 22:10:53.043815
1451	2	1	-1	1	\N	2016-06-30	29.80	733acea111e5db580f48512a78b88af7	2020-10-23 22:10:53.045234	2020-10-23 22:10:53.045234
1452	2	9	-1	2	\N	2016-06-30	-31.00	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:10:53.046548	2020-10-23 22:10:53.046548
1453	1	1	-1	2	\N	2016-06-30	-16.76	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:10:53.047813	2020-10-23 22:10:53.047813
1454	2	1	-1	2	\N	2016-07-01	-60.00	01161aaa0b6d1345dd8fe4e481144d84	2020-10-23 22:10:53.049097	2020-10-23 22:10:53.049097
1455	5	1	-1	2	\N	2016-07-01	-34.51	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:53.050408	2020-10-23 22:10:53.050408
1456	2	1	-1	2	\N	2016-07-01	-14.49	828152d112507f3ea5b7ddc171f2bb2e	2020-10-23 22:10:53.051685	2020-10-23 22:10:53.051685
1457	1	10	54	3	\N	2016-07-02	-300.00	f0b0502b8483b1261a9961f3063c1844	2020-10-23 22:10:53.053643	2020-10-23 22:10:53.053643
1458	5	10	54	4	\N	2016-07-02	300.00	f0b0502b8483b1261a9961f3063c1844	2020-10-23 22:10:53.055639	2020-10-23 22:10:53.055639
1459	5	5	25	2	\N	2016-07-02	-35.00	d305177996baf37d4c5c301e96a6e760	2020-10-23 22:10:53.056975	2020-10-23 22:10:53.056975
1460	5	1	-1	2	\N	2016-07-02	-270.11	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:53.058422	2020-10-23 22:10:53.058422
1461	5	1	-1	2	\N	2016-07-02	-6.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.059934	2020-10-23 22:10:53.059934
1462	5	9	-1	3	\N	2016-07-02	-160.00	164f17b765d4a3a9e1ec40c52861b94d	2020-10-23 22:10:53.06125	2020-10-23 22:10:53.06125
1463	1	9	-1	4	\N	2016-07-02	160.00	164f17b765d4a3a9e1ec40c52861b94d	2020-10-23 22:10:53.062457	2020-10-23 22:10:53.062457
1464	6	2	3	1	\N	2016-06-30	35.73	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:53.06371	2020-10-23 22:10:53.06371
1465	5	5	23	2	\N	2016-07-02	-20.66	a9a6653e48976138166de32772b1bf40	2020-10-23 22:10:53.06493	2020-10-23 22:10:53.06493
1466	2	6	27	2	\N	2016-07-03	-69.98	2b44928ae11fb9384c4cf38708677c48	2020-10-23 22:10:53.066227	2020-10-23 22:10:53.066227
1467	5	9	47	2	\N	2016-07-03	-20.00	a760880003e7ddedfef56acb3b09697f	2020-10-23 22:10:53.067617	2020-10-23 22:10:53.067617
1468	2	1	-1	2	\N	2016-07-04	-16.82	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:53.069439	2020-10-23 22:10:53.069439
1469	2	1	-1	2	\N	2016-07-04	-27.72	d38d9ea990b62560807a34ccf36f3160	2020-10-23 22:10:53.071431	2020-10-23 22:10:53.071431
1470	2	8	45	2	\N	2016-07-04	-30.80	d516b13671a4179d9b7b458a6ebdeb92	2020-10-23 22:10:53.072941	2020-10-23 22:10:53.072941
1471	5	1	-1	2	\N	2016-07-05	-40.56	ae8c067572c25c853d39b3232d96321b	2020-10-23 22:10:53.074461	2020-10-23 22:10:53.074461
1472	5	1	-1	2	\N	2016-07-05	-27.72	f9846452b5a6cf746985937b4eb3820e	2020-10-23 22:10:53.075696	2020-10-23 22:10:53.075696
1473	2	1	-1	1	\N	2016-07-05	27.72	f9846452b5a6cf746985937b4eb3820e	2020-10-23 22:10:53.076913	2020-10-23 22:10:53.076913
1474	2	6	27	2	\N	2016-07-09	-4.98	acc3e0404646c57502b480dc052c4fe1	2020-10-23 22:10:53.078167	2020-10-23 22:10:53.078167
1475	2	1	-1	2	\N	2016-07-08	-34.80	056a59127f8ef363eaaf74e385b24b37	2020-10-23 22:10:53.079574	2020-10-23 22:10:53.079574
1476	2	1	-1	2	\N	2016-07-08	-9.53	d74ecbda8c7c1357612b99017f277d9b	2020-10-23 22:10:53.08107	2020-10-23 22:10:53.08107
1477	2	1	-1	2	\N	2016-07-07	-15.00	110947219f7935a3082cb17064564cfb	2020-10-23 22:10:53.082755	2020-10-23 22:10:53.082755
1478	2	9	48	2	\N	2016-07-09	-100.00	b2dd7d505d68df0b925e5045ce8d4c8f	2020-10-23 22:10:53.084397	2020-10-23 22:10:53.084397
1479	2	7	33	1	\N	2016-07-07	188.20	12490594201760da299ee96320ee4e4e	2020-10-23 22:10:53.086301	2020-10-23 22:10:53.086301
1480	5	1	-1	2	\N	2016-07-11	-44.33	9b0a5fa32a0adc5f4f86a750a1c72e98	2020-10-23 22:10:53.08792	2020-10-23 22:10:53.08792
1481	2	1	-1	1	\N	2016-07-11	44.33	9b0a5fa32a0adc5f4f86a750a1c72e98	2020-10-23 22:10:53.089443	2020-10-23 22:10:53.089443
1482	1	1	-1	2	\N	2016-07-11	-2.45	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.090569	2020-10-23 22:10:53.090569
1483	1	1	-1	2	\N	2016-07-11	-15.00	b9f7bd321b14c90c398315f2180bf9ec	2020-10-23 22:10:53.091995	2020-10-23 22:10:53.091995
1484	5	8	43	2	\N	2016-07-10	-175.60	5f1e46ccb87a58e2c31ba6cc8d087d5d	2020-10-23 22:10:53.093239	2020-10-23 22:10:53.093239
1485	1	1	11	2	\N	2016-07-10	-9.58	3cdc1846cca1f6ca13b091a51eef9f9e	2020-10-23 22:10:53.094612	2020-10-23 22:10:53.094612
1486	5	1	-1	2	\N	2016-07-07	-33.56	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:10:53.0962	2020-10-23 22:10:53.0962
1487	1	1	-1	2	\N	2016-07-11	-1.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.09761	2020-10-23 22:10:53.09761
1488	1	8	45	2	\N	2016-07-07	-12.00	01f78be6f7cad02658508fe4616098a9	2020-10-23 22:10:53.099131	2020-10-23 22:10:53.099131
1489	1	1	-1	2	\N	2016-07-07	-25.00	c6f057b86584942e415435ffb1fa93d4	2020-10-23 22:10:53.100818	2020-10-23 22:10:53.100818
1490	1	1	-1	2	\N	2016-07-03	-21.46	5b5be1003cc290a17d5c83b942a656c0	2020-10-23 22:10:53.102282	2020-10-23 22:10:53.102282
1491	5	9	48	2	\N	2016-07-07	-500.00	c9f01d0bf8f9fcd76c71f8ae7bb837b2	2020-10-23 22:10:53.103728	2020-10-23 22:10:53.103728
1492	1	1	11	2	\N	2016-07-05	-4.00	ed265bc903a5a097f61d3ec064d96d2e	2020-10-23 22:10:53.104889	2020-10-23 22:10:53.104889
1493	1	1	-1	2	\N	2016-07-05	-2.50	7453d397f9aee858b150105f45494b86	2020-10-23 22:10:53.106037	2020-10-23 22:10:53.106037
1494	1	1	-1	2	\N	2016-07-05	-4.00	96e0e8897766f1994129ffbf0777c681	2020-10-23 22:10:53.107259	2020-10-23 22:10:53.107259
1495	5	5	23	2	\N	2016-07-07	-7.46	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:10:53.10849	2020-10-23 22:10:53.10849
1496	5	1	11	2	\N	2016-07-06	-16.00	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:10:53.109769	2020-10-23 22:10:53.109769
1497	1	1	-1	2	\N	2016-07-05	-41.10	a608a24ed70d4c1103ee78f2da5d69b4	2020-10-23 22:10:53.111553	2020-10-23 22:10:53.111553
1498	1	5	23	2	\N	2016-07-11	-35.59	277b3b5aaf3cde82e214d879ea587e15	2020-10-23 22:10:53.113003	2020-10-23 22:10:53.113003
1499	1	2	3	1	\N	2016-07-04	696.60	3708ac9790c5f74760a23cf98de3907b	2020-10-23 22:10:53.114285	2020-10-23 22:10:53.114285
1500	5	8	43	2	\N	2016-07-08	-169.12	0e2505027d08ccc418fc928962e715c6	2020-10-23 22:10:53.115818	2020-10-23 22:10:53.115818
1501	5	1	-1	2	\N	2016-07-09	-19.76	5b8add2a5d98b1a652ea7fd72d942dac	2020-10-23 22:10:53.117406	2020-10-23 22:10:53.117406
1502	5	1	-1	2	\N	2016-07-09	-23.72	35144c08489e38eeb334cfd3417af741	2020-10-23 22:10:53.118581	2020-10-23 22:10:53.118581
1503	5	9	48	2	\N	2016-07-08	-12.99	588d4c8022a1b06da847986d79070391	2020-10-23 22:10:53.120198	2020-10-23 22:10:53.120198
1504	1	7	30	2	\N	2016-07-07	-24.00	c29e661156ee6cdb9ff7e305d898e589	2020-10-23 22:10:53.121429	2020-10-23 22:10:53.121429
1505	1	1	-1	2	\N	2016-07-04	-21.00	4acbac37408ada4b96737e4dd4b799cd	2020-10-23 22:10:53.122597	2020-10-23 22:10:53.122597
1506	1	1	-1	2	\N	2016-07-06	-25.00	c947c450b7f3d9d07b0e747712cee8c6	2020-10-23 22:10:53.123819	2020-10-23 22:10:53.123819
1507	1	1	-1	2	\N	2016-07-06	-16.00	e11a3057560d38fce4468acccbfae592	2020-10-23 22:10:53.12523	2020-10-23 22:10:53.12523
1508	1	9	-1	2	\N	2016-07-11	-30.00	54190dbbc9cf2dd6e85e6f5c51ddce35	2020-10-23 22:10:53.126564	2020-10-23 22:10:53.126564
1509	1	1	11	2	\N	2016-07-12	-5.98	e4984763783e0d6201b8af37194c826e	2020-10-23 22:10:53.127978	2020-10-23 22:10:53.127978
1510	1	1	11	2	\N	2016-07-12	-4.56	2d14a3064b032e8e9b7692cbc10ca4de	2020-10-23 22:10:53.129233	2020-10-23 22:10:53.129233
1511	5	9	-1	2	\N	2016-07-12	-26.89	11778dd76eff6f83047b6da609df524d	2020-10-23 22:10:53.130442	2020-10-23 22:10:53.130442
1512	2	4	16	2	\N	2016-07-12	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:53.131861	2020-10-23 22:10:53.131861
1513	1	1	-1	2	\N	2016-07-13	-50.00	fe82627d79349461aa066e1121fa81a6	2020-10-23 22:10:53.133274	2020-10-23 22:10:53.133274
1514	1	1	-1	2	\N	2016-07-14	-2.45	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.134605	2020-10-23 22:10:53.134605
1515	1	1	-1	2	\N	2016-07-14	-13.43	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.136232	2020-10-23 22:10:53.136232
1516	1	1	11	2	\N	2016-07-14	-2.00	23ce1851341ec1fa9e0c259de10bf87c	2020-10-23 22:10:53.137595	2020-10-23 22:10:53.137595
1517	1	1	-1	2	\N	2016-07-13	-5.19	c64e8971b113555fbcbb72508a29c7c3	2020-10-23 22:10:53.139648	2020-10-23 22:10:53.139648
1518	2	6	27	2	\N	2016-07-14	-50.00	106f8a84b0d154c01cadc289aabc2e24	2020-10-23 22:10:53.141027	2020-10-23 22:10:53.141027
1519	5	6	27	2	\N	2016-07-14	-30.00	ab233b682ec355648e7891e66c54191b	2020-10-23 22:10:53.142349	2020-10-23 22:10:53.142349
1520	2	6	27	2	\N	2016-07-14	-169.98	82fd19a5ecfb9b60c8a2655f30e793d0	2020-10-23 22:10:53.143908	2020-10-23 22:10:53.143908
1521	2	6	27	2	\N	2016-07-14	-29.90	b7923fe9afe7142a24720692484321c5	2020-10-23 22:10:53.145235	2020-10-23 22:10:53.145235
1522	1	8	43	2	\N	2016-07-15	-6.00	5ef0b4eba35ab2d6180b0bca7e46b6f9	2020-10-23 22:10:53.146555	2020-10-23 22:10:53.146555
1523	1	1	-1	2	\N	2016-07-15	-46.00	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:10:53.147814	2020-10-23 22:10:53.147814
1524	1	10	54	1	\N	2016-07-17	200.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.149272	2020-10-23 22:10:53.149272
1525	1	10	54	3	\N	2016-07-17	-200.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.150406	2020-10-23 22:10:53.150406
1526	1	1	-1	2	\N	2016-07-17	-3.36	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.151647	2020-10-23 22:10:53.151647
1527	5	8	43	2	\N	2016-07-17	-149.31	46ea18c940eb09afe7a1ba70dde4563f	2020-10-23 22:10:53.153331	2020-10-23 22:10:53.153331
1528	1	1	-1	2	\N	2016-07-16	-12.99	27aa458f2b6bf800f26b903af42007a9	2020-10-23 22:10:53.154796	2020-10-23 22:10:53.154796
1529	2	8	45	2	\N	2016-07-15	-54.00	329c6e1598183e00e7f20b7bb516b3d1	2020-10-23 22:10:53.156325	2020-10-23 22:10:53.156325
1530	2	1	-1	2	\N	2016-07-18	-92.15	8f2f665a201e5b76e34c3321bd359740	2020-10-23 22:10:53.157662	2020-10-23 22:10:53.157662
1531	2	6	27	2	\N	2016-07-18	-39.90	1e1ca3b541b07aca4c1ccce4be0aa69f	2020-10-23 22:10:53.159011	2020-10-23 22:10:53.159011
1532	2	8	41	2	\N	2016-07-18	-30.80	9928d7bfaa479346f3313a64f3ca7038	2020-10-23 22:10:53.160168	2020-10-23 22:10:53.160168
1533	1	2	-1	1	\N	2016-07-19	180.00	23e0326cca6fd2a035cfcef4fb3a68f6	2020-10-23 22:10:53.161283	2020-10-23 22:10:53.161283
1534	5	2	-1	4	\N	2016-07-19	180.00	23e0326cca6fd2a035cfcef4fb3a68f6	2020-10-23 22:10:53.162515	2020-10-23 22:10:53.162515
1535	1	9	48	3	\N	2016-07-19	-180.00	23e0326cca6fd2a035cfcef4fb3a68f6	2020-10-23 22:10:53.163816	2020-10-23 22:10:53.163816
1536	1	1	-1	2	\N	2016-07-19	-14.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:10:53.16495	2020-10-23 22:10:53.16495
1537	1	1	-1	2	\N	2016-07-19	-2.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.16601	2020-10-23 22:10:53.16601
1538	2	1	-1	2	\N	2016-07-19	-20.04	7cf856926a50e2bad7e9042d6a4dbfcd	2020-10-23 22:10:53.167245	2020-10-23 22:10:53.167245
1539	2	6	27	2	\N	2016-07-19	-79.90	b4f3bf00e4598578d72b12d81b66a4c4	2020-10-23 22:10:53.168409	2020-10-23 22:10:53.168409
1540	5	4	17	2	\N	2016-07-20	-112.00	17c276c8e723eb46aef576537e9d56d0	2020-10-23 22:10:53.169965	2020-10-23 22:10:53.169965
1541	2	6	27	2	\N	2016-07-20	-30.00	59e9280dfd52b7d04026ca27777fa83e	2020-10-23 22:10:53.171199	2020-10-23 22:10:53.171199
1542	2	6	27	2	\N	2016-07-20	-12.50	6ccdec00af5166d66e2f8e45aac98975	2020-10-23 22:10:53.172293	2020-10-23 22:10:53.172293
1543	5	1	-1	2	\N	2016-07-20	-17.10	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:53.173581	2020-10-23 22:10:53.173581
1544	2	7	-1	2	\N	2016-07-20	-12.50	4eb49c402ee7d0a3ac4d832d6b38855e	2020-10-23 22:10:53.174693	2020-10-23 22:10:53.174693
1545	2	7	-1	2	\N	2016-07-20	-14.00	2bf5baf56c92b59956c10e70c3b73c1e	2020-10-23 22:10:53.175718	2020-10-23 22:10:53.175718
1546	1	1	-1	2	\N	2016-07-21	-7.20	a608a24ed70d4c1103ee78f2da5d69b4	2020-10-23 22:10:53.176774	2020-10-23 22:10:53.176774
1547	1	1	-1	2	\N	2016-07-21	-252.09	f668d2179e0d4ce533268be29fc60e75	2020-10-23 22:10:53.177926	2020-10-23 22:10:53.177926
1548	1	8	41	2	\N	2016-07-21	-46.00	8c6744c9d42ec2cb9e8885b54ff744d0	2020-10-23 22:10:53.179104	2020-10-23 22:10:53.179104
1549	1	1	-1	2	\N	2016-07-21	-3.82	2d14a3064b032e8e9b7692cbc10ca4de	2020-10-23 22:10:53.180247	2020-10-23 22:10:53.180247
1550	1	2	-1	1	\N	2016-07-22	22.00	4095c738a053396aff667961966ad5fb	2020-10-23 22:10:53.181413	2020-10-23 22:10:53.181413
1551	1	1	-1	2	\N	2016-07-23	-20.00	398d9f5f16e2d7a8a42cc2527dcbcecd	2020-10-23 22:10:53.182498	2020-10-23 22:10:53.182498
1552	1	1	-1	2	\N	2016-07-23	-5.00	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:53.183824	2020-10-23 22:10:53.183824
1553	1	1	-1	2	\N	2016-07-23	-2.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.185601	2020-10-23 22:10:53.185601
1554	1	1	-1	2	\N	2016-07-23	-6.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.186895	2020-10-23 22:10:53.186895
1555	1	9	-1	2	\N	2016-07-22	-40.00	7504adad8bb96320eb3afdd4df6e1f60	2020-10-23 22:10:53.188001	2020-10-23 22:10:53.188001
1556	2	2	-1	1	\N	2016-07-22	40.00	7504adad8bb96320eb3afdd4df6e1f60	2020-10-23 22:10:53.189021	2020-10-23 22:10:53.189021
1557	1	1	-1	2	\N	2016-07-24	-10.00	301ad0e3bd5cb1627a2044908a42fdc2	2020-10-23 22:10:53.190107	2020-10-23 22:10:53.190107
1558	1	1	-1	2	\N	2016-07-23	-17.20	f9c9cb50e8f1909e70f7f6f5a9d2e9d5	2020-10-23 22:10:53.191351	2020-10-23 22:10:53.191351
1559	1	1	11	2	\N	2016-07-22	-12.37	e4984763783e0d6201b8af37194c826e	2020-10-23 22:10:53.192543	2020-10-23 22:10:53.192543
1560	5	1	-1	2	\N	2016-07-22	-9.23	5ec91aac30eae62f4140325d09b9afd0	2020-10-23 22:10:53.193708	2020-10-23 22:10:53.193708
1561	2	1	-1	2	\N	2016-07-23	-3.20	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:10:53.194882	2020-10-23 22:10:53.194882
1562	2	6	27	1	\N	2016-07-22	60.00	3497865f828d5b3c019257c6f0fb67b2	2020-10-23 22:10:53.196097	2020-10-23 22:10:53.196097
1563	2	1	-1	2	\N	2016-07-25	-10.00	301ad0e3bd5cb1627a2044908a42fdc2	2020-10-23 22:10:53.197328	2020-10-23 22:10:53.197328
1564	2	2	-1	1	\N	2016-07-25	5137.95	70f638907a795f5e1c66434f5574e79e	2020-10-23 22:10:53.198461	2020-10-23 22:10:53.198461
1565	2	10	54	3	\N	2016-07-25	-1500.00	9eb3bb824c1810435ef8e63d8cc49b59	2020-10-23 22:10:53.200137	2020-10-23 22:10:53.200137
1566	5	10	54	4	\N	2016-07-25	1500.00	9eb3bb824c1810435ef8e63d8cc49b59	2020-10-23 22:10:53.201194	2020-10-23 22:10:53.201194
1567	2	10	54	3	\N	2016-07-25	-1500.00	84a66e687796223b14cd2a5564fe3322	2020-10-23 22:10:53.203357	2020-10-23 22:10:53.203357
1568	6	10	54	4	\N	2016-07-25	1500.00	84a66e687796223b14cd2a5564fe3322	2020-10-23 22:10:53.204742	2020-10-23 22:10:53.204742
1569	5	4	16	2	\N	2016-07-25	-49.90	cfee398643cbc3dc5eefc89334cacdc1	2020-10-23 22:10:53.205851	2020-10-23 22:10:53.205851
1570	5	4	13	2	\N	2016-07-25	-361.89	6a2408ed8723d43f8ae3ea65c1a6f664	2020-10-23 22:10:53.206995	2020-10-23 22:10:53.206995
1571	2	9	48	2	\N	2016-07-25	-100.00	e7b24b112a44fdd9ee93bdf998c6ca0e	2020-10-23 22:10:53.208035	2020-10-23 22:10:53.208035
1572	5	8	45	2	\N	2016-07-25	-54.00	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:10:53.209243	2020-10-23 22:10:53.209243
1573	2	8	45	1	\N	2016-07-25	54.00	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:10:53.210451	2020-10-23 22:10:53.210451
1574	5	1	-1	2	\N	2016-07-25	-92.15	05049e90fa4f5039a8cadc6acbb4b2cc	2020-10-23 22:10:53.211589	2020-10-23 22:10:53.211589
1575	2	1	-1	1	\N	2016-07-25	92.15	1ecfb463472ec9115b10c292ef8bc986	2020-10-23 22:10:53.212691	2020-10-23 22:10:53.212691
1576	5	1	-1	2	\N	2016-07-25	-20.04	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:53.213854	2020-10-23 22:10:53.213854
1577	2	1	-1	1	\N	2016-07-25	20.04	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:53.21548	2020-10-23 22:10:53.21548
1578	5	6	27	2	\N	2016-07-25	-30.00	1d183655789c74eacc95a75398e6d55c	2020-10-23 22:10:53.216979	2020-10-23 22:10:53.216979
1579	2	6	27	1	\N	2016-07-25	30.00	1d183655789c74eacc95a75398e6d55c	2020-10-23 22:10:53.218375	2020-10-23 22:10:53.218375
1580	2	2	-1	2	\N	2016-07-25	-40.00	e4a6222cdb5b34375400904f03d8e6a5	2020-10-23 22:10:53.219798	2020-10-23 22:10:53.219798
1581	1	2	-1	1	\N	2016-07-25	40.00	e4a6222cdb5b34375400904f03d8e6a5	2020-10-23 22:10:53.22132	2020-10-23 22:10:53.22132
1582	5	5	21	2	\N	2016-07-25	-76.81	044f2a6eda8910a8c2fbab0a3d79452c	2020-10-23 22:10:53.222753	2020-10-23 22:10:53.222753
1583	2	5	21	2	\N	2016-07-25	-25.96	1b5355fe75bd31e9be9b748743e45cec	2020-10-23 22:10:53.22408	2020-10-23 22:10:53.22408
1584	5	5	21	1	\N	2016-07-25	25.96	1b5355fe75bd31e9be9b748743e45cec	2020-10-23 22:10:53.225252	2020-10-23 22:10:53.225252
1585	2	1	-1	2	\N	2016-07-25	-17.14	18997733ec258a9fcaf239cc55d53363	2020-10-23 22:10:53.226385	2020-10-23 22:10:53.226385
1586	1	1	11	2	\N	2016-07-25	-1.30	df877f3865752637daa540ea9cbc474f	2020-10-23 22:10:53.227557	2020-10-23 22:10:53.227557
1587	1	1	11	2	\N	2016-07-26	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.2289	2020-10-23 22:10:53.2289
1588	1	9	48	2	\N	2016-07-26	-13.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:53.2302	2020-10-23 22:10:53.2302
1589	1	1	-1	2	\N	2016-07-25	-31.20	ef84407769f8cdbe00f4902bf2b256f0	2020-10-23 22:10:53.231556	2020-10-23 22:10:53.231556
1590	1	1	-1	2	\N	2016-07-26	-16.37	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.232939	2020-10-23 22:10:53.232939
1591	5	9	-1	3	\N	2016-07-26	-60.00	bc6dc48b743dc5d013b1abaebd2faed2	2020-10-23 22:10:53.234129	2020-10-23 22:10:53.234129
1592	1	2	-1	4	\N	2016-07-26	60.00	4311359ed4969e8401880e3c1836fbe1	2020-10-23 22:10:53.235303	2020-10-23 22:10:53.235303
1593	1	1	11	2	\N	2016-07-26	-10.30	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:10:53.237056	2020-10-23 22:10:53.237056
1594	1	1	-1	2	\N	2016-07-27	-13.63	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.238313	2020-10-23 22:10:53.238313
1595	1	1	11	2	\N	2016-07-27	-4.63	2d14a3064b032e8e9b7692cbc10ca4de	2020-10-23 22:10:53.239457	2020-10-23 22:10:53.239457
1596	5	1	-1	2	\N	2016-07-27	-87.48	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:10:53.24091	2020-10-23 22:10:53.24091
1597	5	1	-1	2	\N	2016-07-27	-10.65	801886d15a07a0f786169c3fa4c54b34	2020-10-23 22:10:53.242307	2020-10-23 22:10:53.242307
1598	1	9	-1	2	\N	2016-07-28	-60.00	34ed066df378efacc9b924ec161e7639	2020-10-23 22:10:53.243743	2020-10-23 22:10:53.243743
1599	5	2	-1	4	\N	2016-07-28	60.00	34ed066df378efacc9b924ec161e7639	2020-10-23 22:10:53.244939	2020-10-23 22:10:53.244939
1600	1	2	-1	1	\N	2016-07-28	16.00	ecca76103660ab0c1b54659785293726	2020-10-23 22:10:53.246194	2020-10-23 22:10:53.246194
1601	1	2	3	4	\N	2016-07-28	10012.32	9cf6dfa8f7748e167c0f8c1c10fec614	2020-10-23 22:10:53.24755	2020-10-23 22:10:53.24755
1602	1	10	54	3	\N	2016-07-28	-500.00	a9705e100a158e3828c344cd096331e5	2020-10-23 22:10:53.248692	2020-10-23 22:10:53.248692
1603	1	10	54	3	\N	2016-07-28	-1500.00	3daf3224b85a18c85ae50d63a7a6097c	2020-10-23 22:10:53.24992	2020-10-23 22:10:53.24992
1604	6	10	54	4	\N	2016-07-28	1500.00	3daf3224b85a18c85ae50d63a7a6097c	2020-10-23 22:10:53.250986	2020-10-23 22:10:53.250986
1605	1	10	54	2	\N	2016-07-28	-1500.00	6c079f53cab9e6766bb3368aac01ffe5	2020-10-23 22:10:53.252032	2020-10-23 22:10:53.252032
1606	1	10	54	3	\N	2016-07-28	-5000.00	d2e2a9d8a114d2dd3feba88cf64fa2b6	2020-10-23 22:10:53.253475	2020-10-23 22:10:53.253475
1607	5	10	54	4	\N	2016-07-28	5000.00	d2e2a9d8a114d2dd3feba88cf64fa2b6	2020-10-23 22:10:53.254879	2020-10-23 22:10:53.254879
1608	1	8	43	2	\N	2016-07-28	-403.50	28a40486970ef037b8cc878b226ccdeb	2020-10-23 22:10:53.256207	2020-10-23 22:10:53.256207
1609	2	4	16	2	\N	2016-07-28	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:53.257665	2020-10-23 22:10:53.257665
1610	2	4	18	2	\N	2016-07-28	-40.22	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:53.259119	2020-10-23 22:10:53.259119
1611	5	8	43	2	\N	2016-07-30	-29.69	db31dcd832b4a85bf9aeee10dfeddded	2020-10-23 22:10:53.260464	2020-10-23 22:10:53.260464
1612	1	1	-1	2	\N	2016-07-30	-9.86	c52f1bd66cc19d05628bd8bf27af3ad6	2020-10-23 22:10:53.261822	2020-10-23 22:10:53.261822
1613	1	6	28	2	\N	2016-07-30	-194.00	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:10:53.263031	2020-10-23 22:10:53.263031
1614	5	8	43	2	\N	2016-07-29	-176.67	9186844637c7ca38f5f65a804457d2a0	2020-10-23 22:10:53.264177	2020-10-23 22:10:53.264177
1615	5	8	43	2	\N	2016-07-29	-111.74	c93db2ce61c4ab0593d0323da24d4568	2020-10-23 22:10:53.265294	2020-10-23 22:10:53.265294
1616	1	7	36	2	\N	2016-07-31	-56.56	31103b39ac37ed3b4cf65836ed2eee1f	2020-10-23 22:10:53.266363	2020-10-23 22:10:53.266363
1617	1	7	33	2	\N	2016-07-31	-29.99	afda332245e2af431fb7b672a68b659d	2020-10-23 22:10:53.267707	2020-10-23 22:10:53.267707
1618	1	7	35	2	\N	2016-07-31	-40.00	4b56626af6238c2ff3d08e5ee9174346	2020-10-23 22:10:53.268918	2020-10-23 22:10:53.268918
1619	1	1	-1	2	\N	2016-07-31	-10.30	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:10:53.270509	2020-10-23 22:10:53.270509
1620	1	1	11	2	\N	2016-07-31	-5.29	23ce1851341ec1fa9e0c259de10bf87c	2020-10-23 22:10:53.272214	2020-10-23 22:10:53.272214
1621	1	2	-1	1	\N	2016-08-01	115.00	9cf7d312748f4e6163ba65d1daa489ad	2020-10-23 22:10:53.273792	2020-10-23 22:10:53.273792
1622	1	2	-1	1	\N	2016-08-01	131.50	a8811e4ace534ddf1e517e255389cf2f	2020-10-23 22:10:53.275287	2020-10-23 22:10:53.275287
1623	1	1	-1	2	\N	2016-08-02	-3.50	2d14a3064b032e8e9b7692cbc10ca4de	2020-10-23 22:10:53.276453	2020-10-23 22:10:53.276453
1624	1	1	-1	2	\N	2016-08-02	-1.80	d3c8a0832878a5e1d4e873e57b7f4238	2020-10-23 22:10:53.277737	2020-10-23 22:10:53.277737
1625	1	1	-1	2	\N	2016-08-01	-2.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.279039	2020-10-23 22:10:53.279039
1626	5	1	-1	2	\N	2016-08-03	-15.74	c8fbbe3ab0d6d8839244383ae4887a0d	2020-10-23 22:10:53.28027	2020-10-23 22:10:53.28027
1627	1	1	-1	2	\N	2016-08-02	-22.00	c95ad2a05a8ddb244c6bc3b1041d3f1f	2020-10-23 22:10:53.281461	2020-10-23 22:10:53.281461
1628	6	2	-1	1	\N	2016-08-01	43.44	5544c39c40833ed5de0fc2a596d567ca	2020-10-23 22:10:53.2826	2020-10-23 22:10:53.2826
1629	5	1	-1	2	\N	2016-08-03	-35.10	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.284029	2020-10-23 22:10:53.284029
1630	5	2	-1	1	\N	2016-08-01	1500.00	5845a61cbe9ef44e8ee9e517ee5985f9	2020-10-23 22:10:53.285217	2020-10-23 22:10:53.285217
1631	2	9	-1	2	\N	2016-08-04	-135.00	ccc0aa1b81bf81e16c676ddb977c5881	2020-10-23 22:10:53.286579	2020-10-23 22:10:53.286579
1632	1	9	-1	1	\N	2016-08-04	135.00	ccc0aa1b81bf81e16c676ddb977c5881	2020-10-23 22:10:53.287919	2020-10-23 22:10:53.287919
1633	2	9	-1	1	\N	2016-08-04	135.00	ccc0aa1b81bf81e16c676ddb977c5881	2020-10-23 22:10:53.289019	2020-10-23 22:10:53.289019
1634	2	4	16	1	\N	2016-08-04	60.00	18a2ed0bbf9cd483570dd5b9563bc32c	2020-10-23 22:10:53.290097	2020-10-23 22:10:53.290097
1635	2	8	42	2	\N	2016-08-04	-88.20	92daa86ad43a42f28f4bf58e94667c95	2020-10-23 22:10:53.291215	2020-10-23 22:10:53.291215
1636	2	8	44	2	\N	2016-08-04	-16.00	e836d813fd184325132fca8edcdfb40e	2020-10-23 22:10:53.292392	2020-10-23 22:10:53.292392
1637	2	8	41	2	\N	2016-08-04	-8.40	a22305db840043e44ad7319005b090ce	2020-10-23 22:10:53.294029	2020-10-23 22:10:53.294029
1638	2	1	-1	2	\N	2016-08-04	-14.00	7a9a0010088783883f564db65f66c88d	2020-10-23 22:10:53.29528	2020-10-23 22:10:53.29528
1639	2	1	-1	2	\N	2016-08-04	-27.98	6ecbdd6ec859d284dc13885a37ce8d81	2020-10-23 22:10:53.296739	2020-10-23 22:10:53.296739
1640	2	6	27	2	\N	2016-08-04	-9.90	eaae339c4d89fc102edd9dbdb6a28915	2020-10-23 22:10:53.298479	2020-10-23 22:10:53.298479
1641	2	6	27	2	\N	2016-08-04	-25.00	5ae692608ab908ccfe1b500272498eb8	2020-10-23 22:10:53.299791	2020-10-23 22:10:53.299791
1642	5	8	42	2	\N	2016-08-04	-104.20	14cb04d62a1fc10c06dafc8ca3361720	2020-10-23 22:10:53.301237	2020-10-23 22:10:53.301237
1643	2	8	42	1	\N	2016-08-04	104.20	14cb04d62a1fc10c06dafc8ca3361720	2020-10-23 22:10:53.302631	2020-10-23 22:10:53.302631
1644	1	1	-1	2	\N	2016-08-04	-30.00	d60ea3899962ccffb8e5c7893e7eddd7	2020-10-23 22:10:53.303894	2020-10-23 22:10:53.303894
1645	1	1	-1	2	\N	2016-08-05	-31.00	cf30c5a9bfb152765dae97cee99689f8	2020-10-23 22:10:53.304995	2020-10-23 22:10:53.304995
1646	1	1	-1	2	\N	2016-08-06	-9.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.306161	2020-10-23 22:10:53.306161
1647	1	1	-1	2	\N	2016-08-05	-5.47	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:53.307434	2020-10-23 22:10:53.307434
1648	5	9	-1	3	\N	2016-08-06	-40.00	5cfcf4431b67fb31985285f1572d6370	2020-10-23 22:10:53.308762	2020-10-23 22:10:53.308762
1649	1	2	-1	4	\N	2016-08-06	40.00	5cfcf4431b67fb31985285f1572d6370	2020-10-23 22:10:53.309931	2020-10-23 22:10:53.309931
1650	2	6	27	2	\N	2016-08-07	-17.00	5ae692608ab908ccfe1b500272498eb8	2020-10-23 22:10:53.311324	2020-10-23 22:10:53.311324
1651	2	8	41	2	\N	2016-08-07	-14.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:10:53.312371	2020-10-23 22:10:53.312371
1652	5	7	35	2	\N	2016-08-08	-97.00	3d705a6f6a902ac2d7c6c9b46d215933	2020-10-23 22:10:53.31353	2020-10-23 22:10:53.31353
1653	5	2	-1	1	\N	2016-08-16	1200.00	ec8956637a99787bd197eacd77acce5e	2020-10-23 22:10:53.314608	2020-10-23 22:10:53.314608
1654	2	5	21	2	\N	2016-08-16	-26.46	d296c101daa88a51f6ca8cfc1ac79b50	2020-10-23 22:10:53.315645	2020-10-23 22:10:53.315645
1655	2	8	41	2	\N	2016-08-17	-50.00	71c32595c397960f74555a8b9db16f75	2020-10-23 22:10:53.316959	2020-10-23 22:10:53.316959
1656	1	7	36	2	\N	2016-08-18	-0.38	3dd5307908f9499d0e37c2f1fcb0059f	2020-10-23 22:10:53.318052	2020-10-23 22:10:53.318052
1657	1	8	43	2	\N	2016-08-15	-175.24	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.319446	2020-10-23 22:10:53.319446
1658	5	8	43	3	\N	2016-08-18	-175.24	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.320766	2020-10-23 22:10:53.320766
1659	1	2	-1	4	\N	2016-08-18	175.24	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.321882	2020-10-23 22:10:53.321882
1660	1	1	11	2	\N	2016-08-15	-9.29	18bbcaa5ef823894fc2814721a5976ae	2020-10-23 22:10:53.322982	2020-10-23 22:10:53.322982
1661	1	9	-1	2	\N	2016-08-16	-64.56	31103b39ac37ed3b4cf65836ed2eee1f	2020-10-23 22:10:53.324127	2020-10-23 22:10:53.324127
1662	1	9	-1	2	\N	2016-08-16	-64.56	2e1c6ef401c6f4e66790a9df179b885f	2020-10-23 22:10:53.325247	2020-10-23 22:10:53.325247
1663	1	9	-1	2	\N	2016-08-16	-64.56	a0950d25a0593f48090ead2dc84abd77	2020-10-23 22:10:53.326296	2020-10-23 22:10:53.326296
1664	1	4	50	2	\N	2016-08-16	-20.00	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:10:53.327346	2020-10-23 22:10:53.327346
1665	1	4	50	2	\N	2016-08-16	-20.00	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:10:53.328448	2020-10-23 22:10:53.328448
1666	1	4	50	2	\N	2016-08-16	-20.00	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:10:53.32965	2020-10-23 22:10:53.32965
1667	5	9	-1	3	\N	2016-08-18	-64.56	17d63b1625c816c22647a73e1482372b	2020-10-23 22:10:53.330843	2020-10-23 22:10:53.330843
1668	1	2	-1	4	\N	2016-08-18	64.56	17d63b1625c816c22647a73e1482372b	2020-10-23 22:10:53.332019	2020-10-23 22:10:53.332019
1669	1	2	-1	1	\N	2016-08-15	65.00	632cee946db83e7a52ce5e8d6f0fed35	2020-10-23 22:10:53.33323	2020-10-23 22:10:53.33323
1670	1	9	-1	2	\N	2016-08-18	-1.80	68514647ec088625b110cee8439bfdb6	2020-10-23 22:10:53.334476	2020-10-23 22:10:53.334476
1671	5	1	-1	2	\N	2016-08-07	-79.83	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.335805	2020-10-23 22:10:53.335805
1672	5	1	-1	2	\N	2016-08-06	-46.92	467b35bb671dc46082048ea9505f9083	2020-10-23 22:10:53.337395	2020-10-23 22:10:53.337395
1673	5	1	-1	2	\N	2016-08-16	-69.94	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.338515	2020-10-23 22:10:53.338515
1674	5	8	43	2	\N	2016-08-15	-100.14	120632446c35682a996c50830ee55882	2020-10-23 22:10:53.340352	2020-10-23 22:10:53.340352
1675	5	8	43	2	\N	2016-08-10	-157.05	47564d08c3fdb0b12e49c072c30ff2ee	2020-10-23 22:10:53.341644	2020-10-23 22:10:53.341644
1676	5	8	43	2	\N	2016-08-10	-87.69	47564d08c3fdb0b12e49c072c30ff2ee	2020-10-23 22:10:53.342924	2020-10-23 22:10:53.342924
1677	5	7	30	2	\N	2016-08-18	-5906.92	e1e32e235eee1f970470a3a6658dfdd5	2020-10-23 22:10:53.344208	2020-10-23 22:10:53.344208
1678	1	8	41	2	\N	2016-08-18	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:53.345587	2020-10-23 22:10:53.345587
1679	1	8	41	2	\N	2016-08-18	-27.20	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:53.347185	2020-10-23 22:10:53.347185
1680	1	1	-1	2	\N	2016-08-19	-14.87	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.348484	2020-10-23 22:10:53.348484
1681	1	1	-1	2	\N	2016-08-19	-20.50	86f21daaeb50a5e1c5e6f7353945bb91	2020-10-23 22:10:53.349726	2020-10-23 22:10:53.349726
1682	1	1	-1	2	\N	2016-08-19	-18.50	86f21daaeb50a5e1c5e6f7353945bb91	2020-10-23 22:10:53.35127	2020-10-23 22:10:53.35127
1683	1	1	-1	2	\N	2016-08-19	-17.00	b534ba68236ba543ae44b22bd110a1d6	2020-10-23 22:10:53.353521	2020-10-23 22:10:53.353521
1684	1	1	-1	2	\N	2016-08-19	-17.00	86f21daaeb50a5e1c5e6f7353945bb91	2020-10-23 22:10:53.355124	2020-10-23 22:10:53.355124
1685	1	1	-1	2	\N	2016-08-19	-26.00	6a8addeb940cd48f8177c44d5991650e	2020-10-23 22:10:53.356759	2020-10-23 22:10:53.356759
1686	1	1	-1	2	\N	2016-08-19	-10.00	86f21daaeb50a5e1c5e6f7353945bb91	2020-10-23 22:10:53.358067	2020-10-23 22:10:53.358067
1687	5	1	-1	3	\N	2016-08-19	-30.00	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:10:53.359349	2020-10-23 22:10:53.359349
1688	5	1	-1	2	\N	2016-08-19	-51.06	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.36055	2020-10-23 22:10:53.36055
1689	5	9	47	2	\N	2016-08-20	-50.00	0df8042a5fe9a829368522d695328450	2020-10-23 22:10:53.36172	2020-10-23 22:10:53.36172
1690	5	9	47	2	\N	2016-08-20	-50.00	4896d2676d51661d891bd53006e3dad2	2020-10-23 22:10:53.363208	2020-10-23 22:10:53.363208
1691	2	1	-1	2	\N	2016-08-21	-68.20	e633ebc842f846efae80b6dda8f2fb00	2020-10-23 22:10:53.364409	2020-10-23 22:10:53.364409
1692	5	1	-1	1	\N	2016-08-21	68.20	e633ebc842f846efae80b6dda8f2fb00	2020-10-23 22:10:53.365534	2020-10-23 22:10:53.365534
1693	2	1	-1	2	\N	2016-08-19	-7.00	4b6538a44a1dfdc2b83477cd76dee98e	2020-10-23 22:10:53.366566	2020-10-23 22:10:53.366566
1694	2	1	-1	2	\N	2016-08-19	-9.00	6daddd96b0e241ab30f1dcdd858fd15e	2020-10-23 22:10:53.367645	2020-10-23 22:10:53.367645
1695	2	1	-1	2	\N	2016-08-19	-10.00	6daddd96b0e241ab30f1dcdd858fd15e	2020-10-23 22:10:53.369204	2020-10-23 22:10:53.369204
1696	2	1	-1	2	\N	2016-08-19	-11.00	2f885d0fbe2e131bfc9d98363e55d1d4	2020-10-23 22:10:53.370772	2020-10-23 22:10:53.370772
1697	2	8	44	2	\N	2016-08-19	-13.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:53.372087	2020-10-23 22:10:53.372087
1698	1	9	48	2	\N	2016-08-22	-500.00	3a0ec7409456f8eb388d9fb2df2fec1b	2020-10-23 22:10:53.373394	2020-10-23 22:10:53.373394
1699	1	1	-1	2	\N	2016-08-22	-2.45	f2020fba25808474bb2ea066aa7bbfab	2020-10-23 22:10:53.374873	2020-10-23 22:10:53.374873
1700	5	1	-1	2	\N	2016-08-22	-39.24	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.376341	2020-10-23 22:10:53.376341
1701	1	9	48	2	\N	2016-08-23	-45.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:53.377585	2020-10-23 22:10:53.377585
1702	2	5	21	2	\N	2016-08-23	-55.93	e94550c93cd70fe748e6982b3439ad3b	2020-10-23 22:10:53.378709	2020-10-23 22:10:53.378709
1703	2	1	-1	2	\N	2016-08-23	-4.00	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:53.379751	2020-10-23 22:10:53.379751
1704	2	1	-1	2	\N	2016-08-23	-30.00	846749d080d9212b3c1883fbc8a51263	2020-10-23 22:10:53.380926	2020-10-23 22:10:53.380926
1705	5	1	-1	2	\N	2016-08-24	-52.74	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:10:53.382028	2020-10-23 22:10:53.382028
1706	2	6	27	2	\N	2016-08-24	-7.00	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:10:53.383271	2020-10-23 22:10:53.383271
1707	1	1	11	2	\N	2016-08-20	-5.29	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.384431	2020-10-23 22:10:53.384431
1708	1	1	11	2	\N	2016-08-24	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.385967	2020-10-23 22:10:53.385967
1709	1	1	-1	2	\N	2016-08-24	-16.16	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.387332	2020-10-23 22:10:53.387332
1710	2	1	-1	2	\N	2016-08-25	-24.00	6e7b33fdea3adc80ebd648fffb665bb8	2020-10-23 22:10:53.388717	2020-10-23 22:10:53.388717
1711	2	1	-1	2	\N	2016-08-25	-9.00	6e7b33fdea3adc80ebd648fffb665bb8	2020-10-23 22:10:53.389919	2020-10-23 22:10:53.389919
1712	2	8	44	2	\N	2016-08-25	-10.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:53.391324	2020-10-23 22:10:53.391324
1713	5	5	23	2	\N	2016-08-26	-27.00	c753ca99cb9a635d99942cc37f0a0ce5	2020-10-23 22:10:53.392462	2020-10-23 22:10:53.392462
1714	2	4	18	2	\N	2016-08-27	-112.31	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:53.39377	2020-10-23 22:10:53.39377
1715	5	9	47	2	\N	2016-08-27	-50.00	577bcc914f9e55d5e4e4f82f9f00e7d4	2020-10-23 22:10:53.395342	2020-10-23 22:10:53.395342
1716	1	5	25	2	\N	2016-08-27	-35.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:53.396937	2020-10-23 22:10:53.396937
1717	5	8	43	2	\N	2016-08-27	-20.00	8a3bdaf491ab1aa2f5f8c9e41575f679	2020-10-23 22:10:53.398219	2020-10-23 22:10:53.398219
1718	5	1	-1	2	\N	2016-08-27	-50.13	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.399519	2020-10-23 22:10:53.399519
1719	5	1	11	2	\N	2016-08-25	-5.54	766ebcd59621e305170616ba3d3dac32	2020-10-23 22:10:53.400825	2020-10-23 22:10:53.400825
1720	1	1	-1	2	\N	2016-08-26	-5.97	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:53.402038	2020-10-23 22:10:53.402038
1721	1	5	21	2	\N	2016-08-27	-17.78	9e94b15ed312fa42232fd87a55db0d39	2020-10-23 22:10:53.403304	2020-10-23 22:10:53.403304
1722	1	1	-1	2	\N	2016-08-27	-17.30	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:53.404409	2020-10-23 22:10:53.404409
1723	5	4	16	2	\N	2016-08-28	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:53.405511	2020-10-23 22:10:53.405511
1724	2	1	-1	2	\N	2016-08-28	-41.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:10:53.40655	2020-10-23 22:10:53.40655
1725	1	9	-1	2	\N	2016-08-30	-100.00	54190dbbc9cf2dd6e85e6f5c51ddce35	2020-10-23 22:10:53.407873	2020-10-23 22:10:53.407873
1726	1	2	3	1	\N	2016-08-30	9999.52	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:10:53.409048	2020-10-23 22:10:53.409048
1727	5	1	-1	2	\N	2016-08-28	-25.52	a44987440c0b9efdbd270eb6e4afe279	2020-10-23 22:10:53.410206	2020-10-23 22:10:53.410206
1728	1	1	-1	2	\N	2016-08-29	-10.62	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.411421	2020-10-23 22:10:53.411421
1729	1	7	33	2	\N	2016-08-31	-29.99	afda332245e2af431fb7b672a68b659d	2020-10-23 22:10:53.412571	2020-10-23 22:10:53.412571
1730	1	1	11	2	\N	2016-08-27	-5.89	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.413895	2020-10-23 22:10:53.413895
1731	1	9	-1	2	\N	2016-08-27	-10.00	e836d813fd184325132fca8edcdfb40e	2020-10-23 22:10:53.415392	2020-10-23 22:10:53.415392
1732	1	1	11	2	\N	2016-08-28	-4.59	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.416688	2020-10-23 22:10:53.416688
1733	1	4	-1	3	\N	2016-08-30	-1500.00	1c613d503dec9c1be87ddc813e742607	2020-10-23 22:10:53.418074	2020-10-23 22:10:53.418074
1734	1	10	54	3	\N	2016-08-30	-5500.00	2f10228cee7feec8a8a740166e66fe13	2020-10-23 22:10:53.419367	2020-10-23 22:10:53.419367
1735	6	10	54	4	\N	2016-08-30	5500.00	2f10228cee7feec8a8a740166e66fe13	2020-10-23 22:10:53.420686	2020-10-23 22:10:53.420686
1736	1	10	54	3	\N	2016-08-30	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:10:53.422089	2020-10-23 22:10:53.422089
1737	1	10	54	3	\N	2016-08-30	-1000.00	f8f84f4253ff3acd938d001ca704a84e	2020-10-23 22:10:53.423252	2020-10-23 22:10:53.423252
1738	3	10	54	4	\N	2016-08-30	1000.00	f8f84f4253ff3acd938d001ca704a84e	2020-10-23 22:10:53.424398	2020-10-23 22:10:53.424398
1739	2	9	47	2	\N	2016-08-26	-50.00	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:10:53.425616	2020-10-23 22:10:53.425616
1740	2	2	3	1	\N	2016-08-29	5842.60	23c5cd6a6391cddacef39d22e40656c6	2020-10-23 22:10:53.426992	2020-10-23 22:10:53.426992
1741	2	9	47	2	\N	2016-08-30	-50.00	fc698bd6eba4453d16fc4acb4abf4a5a	2020-10-23 22:10:53.42832	2020-10-23 22:10:53.42832
1742	5	5	23	2	\N	2016-08-29	-54.10	d34ab169b70c9dcd35e62896010cd9ff	2020-10-23 22:10:53.429647	2020-10-23 22:10:53.429647
1743	2	10	54	3	\N	2016-08-31	-1500.00	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:10:53.43121	2020-10-23 22:10:53.43121
1744	5	10	54	4	\N	2016-08-31	1500.00	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:10:53.432422	2020-10-23 22:10:53.432422
1745	2	10	54	3	\N	2016-08-31	-2500.00	bca3d09e5a575a702eafcdaf2da72b85	2020-10-23 22:10:53.433606	2020-10-23 22:10:53.433606
1746	6	10	54	4	\N	2016-08-31	2500.00	bca3d09e5a575a702eafcdaf2da72b85	2020-10-23 22:10:53.435	2020-10-23 22:10:53.435
1747	5	4	13	2	\N	2016-08-31	-246.82	d7ee6c45ea891305f16deaafccd40e05	2020-10-23 22:10:53.436478	2020-10-23 22:10:53.436478
1748	5	4	14	2	\N	2016-08-31	-96.42	18230e1fb6e5dd3cfb0bcec4f863e167	2020-10-23 22:10:53.437775	2020-10-23 22:10:53.437775
1749	2	10	54	3	\N	2016-08-31	-1000.00	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:10:53.439005	2020-10-23 22:10:53.439005
1750	4	10	54	4	\N	2016-08-31	1000.00	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:10:53.44019	2020-10-23 22:10:53.44019
1751	2	10	54	3	\N	2016-08-31	-1000.00	218a0aefd1d1a4be65601cc6ddc1520e	2020-10-23 22:10:53.441603	2020-10-23 22:10:53.441603
1752	6	10	54	4	\N	2016-08-31	1000.00	218a0aefd1d1a4be65601cc6ddc1520e	2020-10-23 22:10:53.443124	2020-10-23 22:10:53.443124
1753	1	1	11	2	\N	2016-08-31	-2.00	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:53.4442	2020-10-23 22:10:53.4442
1754	5	1	-1	2	\N	2016-09-02	-99.16	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.445276	2020-10-23 22:10:53.445276
1755	2	9	47	2	\N	2016-09-05	-100.00	e268203a5d92464c9a3c5f94b4386863	2020-10-23 22:10:53.44629	2020-10-23 22:10:53.44629
1756	5	5	23	2	\N	2016-09-05	-27.49	bd73aee5e8328c6fbfbede30a0003aa2	2020-10-23 22:10:53.447392	2020-10-23 22:10:53.447392
1757	1	8	44	2	\N	2016-09-02	-25.00	5e388103a391daabe3de1d76a6739ccd	2020-10-23 22:10:53.448374	2020-10-23 22:10:53.448374
1758	1	1	-1	2	\N	2016-09-02	-129.00	42bdc9471e7f3a28971799e33adfb776	2020-10-23 22:10:53.449391	2020-10-23 22:10:53.449391
1759	1	1	11	2	\N	2016-09-02	-13.95	5487315b1286f907165907aa8fc96619	2020-10-23 22:10:53.45036	2020-10-23 22:10:53.45036
1760	1	1	11	2	\N	2016-09-02	-15.00	a8c07d583f9358cd523718fb3ca56e72	2020-10-23 22:10:53.451377	2020-10-23 22:10:53.451377
1761	1	1	-1	2	\N	2016-09-02	-30.00	0605032afdb4bb8cdc5e3e969c33d1dd	2020-10-23 22:10:53.452342	2020-10-23 22:10:53.452342
1762	1	8	45	2	\N	2016-08-30	-24.00	fe292c59c55768f7b35ec393e249760e	2020-10-23 22:10:53.453621	2020-10-23 22:10:53.453621
1763	1	1	-1	2	\N	2016-08-31	-1.80	d3c8a0832878a5e1d4e873e57b7f4238	2020-10-23 22:10:53.4547	2020-10-23 22:10:53.4547
1764	1	1	11	2	\N	2016-09-02	-20.00	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:53.455875	2020-10-23 22:10:53.455875
1765	1	1	11	2	\N	2016-09-03	-6.68	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:10:53.457152	2020-10-23 22:10:53.457152
1766	1	9	-1	2	\N	2016-09-03	-2.40	98161ea86740fe71734330821f7d6b81	2020-10-23 22:10:53.458122	2020-10-23 22:10:53.458122
1767	5	1	-1	2	\N	2016-09-03	-12.66	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.459125	2020-10-23 22:10:53.459125
1768	1	1	-1	2	\N	2016-09-02	-10.69	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.460078	2020-10-23 22:10:53.460078
1769	1	1	-1	2	\N	2016-09-01	-15.96	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.461065	2020-10-23 22:10:53.461065
1770	1	10	54	3	\N	2016-09-05	-700.00	0d7de1aca9299fe63f3e0041f02638a3	2020-10-23 22:10:53.462034	2020-10-23 22:10:53.462034
1771	5	10	54	4	\N	2016-09-05	700.00	0d7de1aca9299fe63f3e0041f02638a3	2020-10-23 22:10:53.463013	2020-10-23 22:10:53.463013
1772	5	4	-1	2	\N	2016-09-05	-590.00	2dee5601bb2fd59717f5aee952b159fb	2020-10-23 22:10:53.464029	2020-10-23 22:10:53.464029
1773	1	1	11	2	\N	2016-09-04	-10.92	203a7ea2c22dfa784d8a0f3aa33c5f69	2020-10-23 22:10:53.465056	2020-10-23 22:10:53.465056
1774	6	10	54	1	\N	2016-08-31	46.31	5544c39c40833ed5de0fc2a596d567ca	2020-10-23 22:10:53.46601	2020-10-23 22:10:53.46601
1775	1	1	-1	2	\N	2016-09-06	-13.00	9d92a68a2c7e3e2538c9cb4d6c09824b	2020-10-23 22:10:53.467288	2020-10-23 22:10:53.467288
1776	1	1	11	2	\N	2016-09-06	-7.77	1ff8064e274d0ba812d61379d97a2f4c	2020-10-23 22:10:53.468255	2020-10-23 22:10:53.468255
1777	2	1	-1	2	\N	2016-09-06	-8.00	6a10bbd480e4c5573d8f3af73ae0454b	2020-10-23 22:10:53.469272	2020-10-23 22:10:53.469272
1778	2	1	-1	2	\N	2016-09-06	-10.14	369f40254f1a56c86cc3562a205d72b3	2020-10-23 22:10:53.470337	2020-10-23 22:10:53.470337
1779	2	9	47	2	\N	2016-09-06	-50.00	4753cb21ffb150d76e13233f66c10141	2020-10-23 22:10:53.471371	2020-10-23 22:10:53.471371
1780	5	9	48	2	\N	2016-09-06	-42.00	b04217ced107df851e2715c57328f4af	2020-10-23 22:10:53.472346	2020-10-23 22:10:53.472346
1781	5	10	54	1	\N	2016-09-06	1500.00	b6e07796d9e7e1eb3b8b098cd30976d5	2020-10-23 22:10:53.473387	2020-10-23 22:10:53.473387
1782	5	10	54	3	\N	2016-09-07	-700.00	677e09724f0e2df9b6c000b75b5da10d	2020-10-23 22:10:53.475272	2020-10-23 22:10:53.475272
1783	1	10	54	4	\N	2016-09-07	700.00	677e09724f0e2df9b6c000b75b5da10d	2020-10-23 22:10:53.476275	2020-10-23 22:10:53.476275
1784	5	1	-1	2	\N	2016-09-07	-51.26	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.477303	2020-10-23 22:10:53.477303
1785	1	1	-1	2	\N	2016-09-07	-95.57	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:10:53.478286	2020-10-23 22:10:53.478286
1786	5	1	-1	2	\N	2016-09-08	-14.28	81ba2154738ffaa2caee191531725803	2020-10-23 22:10:53.479376	2020-10-23 22:10:53.479376
1787	5	5	23	2	\N	2016-09-09	-7.80	6f8a28be5f158752eba976d9a69f6abb	2020-10-23 22:10:53.480359	2020-10-23 22:10:53.480359
1788	5	1	-1	2	\N	2016-09-09	-5.30	043c3d7e489c69b48737cc0c92d0f3a2	2020-10-23 22:10:53.481386	2020-10-23 22:10:53.481386
1789	1	1	-1	2	\N	2016-09-08	-26.00	21f64e3ec83330fbc425f52ff209c835	2020-10-23 22:10:53.482404	2020-10-23 22:10:53.482404
1790	1	1	-1	2	\N	2016-09-10	-5.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.483409	2020-10-23 22:10:53.483409
1791	5	1	-1	2	\N	2016-09-12	-11.94	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:53.484411	2020-10-23 22:10:53.484411
1792	2	9	-1	2	\N	2016-09-13	-130.00	8056ac6ddcb0f14b019219391c1159c7	2020-10-23 22:10:53.485451	2020-10-23 22:10:53.485451
1793	2	1	-1	2	\N	2016-09-13	-12.60	dff4f135ef796247aa8ae9da2c4c6c8e	2020-10-23 22:10:53.486425	2020-10-23 22:10:53.486425
1794	2	9	47	2	\N	2016-09-14	-50.00	f1876419406791a07585a978e9644c74	2020-10-23 22:10:53.487457	2020-10-23 22:10:53.487457
1795	5	1	-1	2	\N	2016-09-15	-68.43	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.488708	2020-10-23 22:10:53.488708
1796	5	1	-1	2	\N	2016-09-13	-50.00	3b32e93540abe1425efa37772407c9bb	2020-10-23 22:10:53.489694	2020-10-23 22:10:53.489694
1797	5	1	-1	2	\N	2016-09-14	-10.91	4e17f800ea5ef44af240ef0115a07210	2020-10-23 22:10:53.490826	2020-10-23 22:10:53.490826
1798	1	1	-1	2	\N	2016-09-15	-10.72	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.491771	2020-10-23 22:10:53.491771
1799	1	8	44	2	\N	2016-09-09	-50.00	22951f2450d2131b00c1a0baafda65dc	2020-10-23 22:10:53.492835	2020-10-23 22:10:53.492835
1800	1	7	36	2	\N	2016-09-15	-144.90	d490d7b4576290fa60eb31b5fc917ad1	2020-10-23 22:10:53.494135	2020-10-23 22:10:53.494135
1801	5	9	-1	2	\N	2016-09-18	-10.00	4fac9ba115140ac4f1c22da82aa0bc7f	2020-10-23 22:10:53.495136	2020-10-23 22:10:53.495136
1802	1	1	-1	2	\N	2016-09-18	-5.00	c8c41c4a18675a74e01c8a20e8a0f662	2020-10-23 22:10:53.496222	2020-10-23 22:10:53.496222
1803	1	9	49	2	\N	2016-09-18	-55.99	ee7733547fbb26cdfeb9b6a4f84231b4	2020-10-23 22:10:53.497499	2020-10-23 22:10:53.497499
1804	5	1	-1	2	\N	2016-09-17	-11.48	d1c38a09acc34845c6be3a127a5aacaf	2020-10-23 22:10:53.499006	2020-10-23 22:10:53.499006
1805	5	1	-1	2	\N	2016-09-17	-11.94	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:53.500268	2020-10-23 22:10:53.500268
1806	5	1	-1	2	\N	2016-09-17	-7.18	0520a41422ce63b356f79ca728e06b2a	2020-10-23 22:10:53.501581	2020-10-23 22:10:53.501581
1807	5	1	-1	2	\N	2016-09-17	-6.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.502924	2020-10-23 22:10:53.502924
1808	1	1	-1	2	\N	2016-09-16	-19.63	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.504443	2020-10-23 22:10:53.504443
1809	1	1	11	2	\N	2016-09-16	-2.00	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:53.505812	2020-10-23 22:10:53.505812
1810	5	1	-1	2	\N	2016-09-17	-98.36	aef1e06f7b97d57942850adb46ec7c68	2020-10-23 22:10:53.507118	2020-10-23 22:10:53.507118
1811	2	4	16	2	\N	2016-09-21	-19.99	31103b39ac37ed3b4cf65836ed2eee1f	2020-10-23 22:10:53.508278	2020-10-23 22:10:53.508278
1812	2	9	48	2	\N	2016-09-24	-220.00	d98cd8f0408543caaf60d9075191d179	2020-10-23 22:10:53.50939	2020-10-23 22:10:53.50939
1813	1	9	48	1	\N	2016-09-24	220.00	d98cd8f0408543caaf60d9075191d179	2020-10-23 22:10:53.510422	2020-10-23 22:10:53.510422
1814	5	5	23	2	\N	2016-09-24	-77.59	29b7d70814383d3d41fe12d57cb4736a	2020-10-23 22:10:53.511637	2020-10-23 22:10:53.511637
1815	1	1	-1	2	\N	2016-09-24	-11.32	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.513188	2020-10-23 22:10:53.513188
1816	1	1	-1	2	\N	2016-09-23	-12.79	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.514401	2020-10-23 22:10:53.514401
1817	5	1	-1	2	\N	2016-09-24	-100.98	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.515888	2020-10-23 22:10:53.515888
1818	1	1	-1	2	\N	2016-09-24	-93.53	5a61ba2a7872efc131c0f9becef6703b	2020-10-23 22:10:53.51721	2020-10-23 22:10:53.51721
1819	1	8	41	2	\N	2016-09-23	-19.83	49e8f76092d28e8eebf0398b0268e2ba	2020-10-23 22:10:53.51833	2020-10-23 22:10:53.51833
1820	1	10	54	1	\N	2016-09-17	200.00	4a974c8c32469a4a0901b7059421806d	2020-10-23 22:10:53.519603	2020-10-23 22:10:53.519603
1821	1	10	54	3	\N	2016-09-17	-200.00	4a974c8c32469a4a0901b7059421806d	2020-10-23 22:10:53.520956	2020-10-23 22:10:53.520956
1822	1	1	-1	2	\N	2016-09-09	-95.57	2a097c8e4ebabb754f6e346bedd967b4	2020-10-23 22:10:53.521978	2020-10-23 22:10:53.521978
1823	1	8	41	2	\N	2016-09-24	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:53.523296	2020-10-23 22:10:53.523296
1824	1	8	41	2	\N	2016-09-24	-27.20	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:53.524411	2020-10-23 22:10:53.524411
1825	5	9	48	2	\N	2016-09-25	-38.38	0714c352af2ecb1aa703a5a7664644c5	2020-10-23 22:10:53.52568	2020-10-23 22:10:53.52568
1826	5	9	48	2	\N	2016-09-24	-214.50	5a1ef0be325f3a1311a04164bfbf6e4b	2020-10-23 22:10:53.527239	2020-10-23 22:10:53.527239
1827	5	4	16	2	\N	2016-09-25	-49.90	2f86f1028eed92d84e9b9e35843c1d6a	2020-10-23 22:10:53.52856	2020-10-23 22:10:53.52856
1828	5	9	48	2	\N	2016-09-25	-46.42	0f243f3be92942b7bc653ac46e835ec2	2020-10-23 22:10:53.530163	2020-10-23 22:10:53.530163
1829	2	4	18	2	\N	2016-09-28	-39.99	51dc44968c1e1ce918082679732df9bf	2020-10-23 22:10:53.531497	2020-10-23 22:10:53.531497
1830	2	9	47	2	\N	2016-09-25	-150.00	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:10:53.532679	2020-10-23 22:10:53.532679
1831	5	9	47	2	\N	2016-09-28	-100.00	846c260d715e5b854ffad5f70a516c88	2020-10-23 22:10:53.534089	2020-10-23 22:10:53.534089
1832	5	1	-1	2	\N	2016-09-28	-39.71	fccb3cdc9acc14a6e70a12f74560c026	2020-10-23 22:10:53.53523	2020-10-23 22:10:53.53523
1833	2	2	3	1	\N	2016-09-29	5653.87	9f585adaba6eebfbe272f44e6ba74172	2020-10-23 22:10:53.536422	2020-10-23 22:10:53.536422
1834	2	10	54	3	\N	2016-09-29	-1500.00	e308ac73399237a7606dcafdfbcb89fd	2020-10-23 22:10:53.537729	2020-10-23 22:10:53.537729
1835	5	10	54	4	\N	2016-09-29	1500.00	0b594a627d2947eb71ccd66f476fa9ad	2020-10-23 22:10:53.538984	2020-10-23 22:10:53.538984
1836	2	10	54	3	\N	2016-09-29	-1500.00	f500a9c2c56debf8c12ca8c4e4895a29	2020-10-23 22:10:53.540145	2020-10-23 22:10:53.540145
1837	6	10	54	4	\N	2016-09-29	1500.00	f500a9c2c56debf8c12ca8c4e4895a29	2020-10-23 22:10:53.541329	2020-10-23 22:10:53.541329
1838	5	4	13	2	\N	2016-09-29	-344.25	7bd04fa5dbafcb47a21b66b5de1044dd	2020-10-23 22:10:53.542441	2020-10-23 22:10:53.542441
1839	5	4	15	2	\N	2016-09-29	-227.90	8885e8c52b8aaee7cacd7bceac43c1bb	2020-10-23 22:10:53.54393	2020-10-23 22:10:53.54393
1840	5	4	-1	2	\N	2016-09-29	-590.00	47cf26c17f2ef17fb3d3a5967b83dbbd	2020-10-23 22:10:53.545124	2020-10-23 22:10:53.545124
1841	2	9	-1	2	\N	2016-09-30	-100.00	30d2c1109139d2f14e57194d12394f01	2020-10-23 22:10:53.546255	2020-10-23 22:10:53.546255
1842	5	9	-1	2	\N	2016-09-28	-99.99	afb484a006f5ab0e043179cef7518ab7	2020-10-23 22:10:53.547377	2020-10-23 22:10:53.547377
1843	1	1	11	2	\N	2016-09-26	-9.79	bf21751ba657f55e1c6f7f56fe5f4149	2020-10-23 22:10:53.548442	2020-10-23 22:10:53.548442
1844	1	1	11	2	\N	2016-09-30	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.549509	2020-10-23 22:10:53.549509
1845	1	1	-1	2	\N	2016-09-27	-2.35	a27ef1c79c867d68d049751af69f4b38	2020-10-23 22:10:53.550697	2020-10-23 22:10:53.550697
1846	1	7	33	2	\N	2016-09-30	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:53.55174	2020-10-23 22:10:53.55174
1847	1	1	-1	2	\N	2016-09-28	-4.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.552877	2020-10-23 22:10:53.552877
1848	1	1	-1	2	\N	2016-09-29	-11.94	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:53.554208	2020-10-23 22:10:53.554208
1849	5	5	23	2	\N	2016-09-30	-121.40	2a053dbfd231e20838efbd904d02a746	2020-10-23 22:10:53.555592	2020-10-23 22:10:53.555592
1850	1	10	54	3	\N	2016-09-28	-500.00	088fe7a7d85cebd83448c4477a0a2dd6	2020-10-23 22:10:53.557392	2020-10-23 22:10:53.557392
1851	1	9	49	2	\N	2016-09-26	-31.80	25d46895f001766902354a18fba665ee	2020-10-23 22:10:53.558625	2020-10-23 22:10:53.558625
1852	1	6	27	2	\N	2016-09-26	-218.90	069d3bb002acd8d7dd095917f9efe4cb	2020-10-23 22:10:53.55972	2020-10-23 22:10:53.55972
1853	1	10	54	1	\N	2016-09-28	8183.63	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:10:53.560896	2020-10-23 22:10:53.560896
1854	1	10	54	3	\N	2016-09-28	-1500.00	b634947a581491a6d5ea20b68bf03d42	2020-10-23 22:10:53.562269	2020-10-23 22:10:53.562269
1855	5	10	54	4	\N	2016-09-28	1500.00	b634947a581491a6d5ea20b68bf03d42	2020-10-23 22:10:53.563398	2020-10-23 22:10:53.563398
1856	1	10	54	3	\N	2016-09-28	-1500.00	9188905e74c28e489b44e954ec0b9bca	2020-10-23 22:10:53.564545	2020-10-23 22:10:53.564545
1857	1	10	54	3	\N	2016-09-28	-1000.00	c51e9d44a659ecf9512e1a2844416d9b	2020-10-23 22:10:53.565601	2020-10-23 22:10:53.565601
1858	3	10	54	4	\N	2016-09-28	1000.00	c51e9d44a659ecf9512e1a2844416d9b	2020-10-23 22:10:53.566678	2020-10-23 22:10:53.566678
1859	1	10	54	3	\N	2016-09-28	-3000.00	d7a728a67d909e714c0774e22cb806f2	2020-10-23 22:10:53.567775	2020-10-23 22:10:53.567775
1860	6	10	54	4	\N	2016-09-28	3000.00	d7a728a67d909e714c0774e22cb806f2	2020-10-23 22:10:53.568961	2020-10-23 22:10:53.568961
1861	1	9	-1	3	\N	2016-09-28	-378.40	90778f2b0e9f6514ea61d96cdb6485bd	2020-10-23 22:10:53.570194	2020-10-23 22:10:53.570194
1862	5	2	-1	4	\N	2016-09-28	378.40	90778f2b0e9f6514ea61d96cdb6485bd	2020-10-23 22:10:53.571409	2020-10-23 22:10:53.571409
1863	6	10	54	1	\N	2016-09-30	54.72	5544c39c40833ed5de0fc2a596d567ca	2020-10-23 22:10:53.572537	2020-10-23 22:10:53.572537
1864	5	5	21	2	\N	2016-10-01	18.08	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:53.573651	2020-10-23 22:10:53.573651
1865	5	1	-1	2	\N	2016-10-01	-162.60	26408ffa703a72e8ac0117e74ad46f33	2020-10-23 22:10:53.574892	2020-10-23 22:10:53.574892
1866	2	1	-1	2	\N	2016-10-02	-28.15	a8147e09f3ab3606bc1e81af8ed25f39	2020-10-23 22:10:53.576329	2020-10-23 22:10:53.576329
1867	2	1	-1	1	\N	2016-10-02	10.00	d93ed5b6db83be78efb0d05ae420158e	2020-10-23 22:10:53.577451	2020-10-23 22:10:53.577451
1868	2	8	44	2	\N	2016-10-02	-11.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:53.578506	2020-10-23 22:10:53.578506
1869	2	8	41	2	\N	2016-10-03	-6.60	746f5a6144cf56559a2479837925c07e	2020-10-23 22:10:53.579639	2020-10-23 22:10:53.579639
1870	5	1	-1	2	\N	2016-10-02	-11.94	e2e4e3f6a29fe8623d354404de34f0d0	2020-10-23 22:10:53.580871	2020-10-23 22:10:53.580871
1871	1	1	-1	2	\N	2016-10-01	-23.75	b2f627fff19fda463cb386442eac2b3d	2020-10-23 22:10:53.582031	2020-10-23 22:10:53.582031
1872	1	2	-1	1	\N	2016-10-02	6.50	c630dd16135d2a82b0518e1cd3b5d36f	2020-10-23 22:10:53.583205	2020-10-23 22:10:53.583205
1873	1	1	-1	2	\N	2016-10-03	-4.00	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:53.584594	2020-10-23 22:10:53.584594
1874	5	5	23	2	\N	2016-10-03	-23.90	5e1fd267bf6b31835f40c698909ff5d5	2020-10-23 22:10:53.586103	2020-10-23 22:10:53.586103
1875	2	8	41	2	\N	2016-10-03	-50.00	10a0b07fd47bb66223d4748ec8c4d114	2020-10-23 22:10:53.587535	2020-10-23 22:10:53.587535
1876	2	1	-1	1	\N	2016-10-04	40.00	5da19fa1260738da1dc2223af6325108	2020-10-23 22:10:53.588705	2020-10-23 22:10:53.588705
1877	5	10	54	1	\N	2016-10-04	1500.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:53.589829	2020-10-23 22:10:53.589829
1878	5	10	54	3	\N	2016-10-04	-1500.00	c51e9d44a659ecf9512e1a2844416d9b	2020-10-23 22:10:53.590994	2020-10-23 22:10:53.590994
1879	6	10	54	4	\N	2016-10-04	1500.00	c51e9d44a659ecf9512e1a2844416d9b	2020-10-23 22:10:53.592209	2020-10-23 22:10:53.592209
1880	1	2	3	1	\N	2016-10-04	615.60	b90a692ce8297a27fba811452146779e	2020-10-23 22:10:53.593654	2020-10-23 22:10:53.593654
1881	1	1	-1	2	\N	2016-10-04	-15.00	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.595069	2020-10-23 22:10:53.595069
1882	5	5	23	2	\N	2016-10-04	-38.95	110947219f7935a3082cb17064564cfb	2020-10-23 22:10:53.596276	2020-10-23 22:10:53.596276
1883	2	9	48	2	\N	2016-10-04	-154.00	7ce3284b743aefde80ffd9aec500e085	2020-10-23 22:10:53.597628	2020-10-23 22:10:53.597628
1884	5	1	-1	2	\N	2016-10-04	-42.00	500e75a036dc2d7d2fec5da1b71d36cc	2020-10-23 22:10:53.598923	2020-10-23 22:10:53.598923
1885	2	9	-1	2	\N	2016-10-04	-27.00	e6d847d396d27a844f169a7798df228c	2020-10-23 22:10:53.60016	2020-10-23 22:10:53.60016
1886	1	9	-1	2	\N	2016-10-05	-100.00	54190dbbc9cf2dd6e85e6f5c51ddce35	2020-10-23 22:10:53.601319	2020-10-23 22:10:53.601319
1887	5	1	-1	2	\N	2016-10-05	-10.57	979d472a84804b9f647bc185a877a8b5	2020-10-23 22:10:53.602431	2020-10-23 22:10:53.602431
1888	5	9	48	2	\N	2016-10-06	-50.00	75e35fd9fcd6051376d77b9251c846f1	2020-10-23 22:10:53.603974	2020-10-23 22:10:53.603974
1889	5	5	21	2	\N	2016-10-06	-47.25	f335e9f0e59921511c33549aee7cc1e5	2020-10-23 22:10:53.605895	2020-10-23 22:10:53.605895
1890	2	6	27	2	\N	2016-10-06	-16.98	de0c53b072a58a256ce156d70d06e0c8	2020-10-23 22:10:53.607342	2020-10-23 22:10:53.607342
1891	2	6	27	2	\N	2016-10-06	-39.90	2b24d495052a8ce66358eb576b8912c8	2020-10-23 22:10:53.608767	2020-10-23 22:10:53.608767
1892	5	9	48	2	\N	2016-10-06	-66.97	8757150decbd89b0f5442ca3db4d0e0e	2020-10-23 22:10:53.609957	2020-10-23 22:10:53.609957
1893	4	9	-1	3	\N	2016-10-06	-2000.00	6da37dd3139aa4d9aa55b8d237ec5d4a	2020-10-23 22:10:53.611405	2020-10-23 22:10:53.611405
1894	2	9	-1	4	\N	2016-10-06	2000.00	6da37dd3139aa4d9aa55b8d237ec5d4a	2020-10-23 22:10:53.612822	2020-10-23 22:10:53.612822
1895	1	1	11	2	\N	2016-10-06	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.61427	2020-10-23 22:10:53.61427
1896	5	1	11	2	\N	2016-10-08	-4.79	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:10:53.615487	2020-10-23 22:10:53.615487
1897	5	8	43	2	\N	2016-10-07	-189.61	82a958afc122a6e476b5f93a210b781e	2020-10-23 22:10:53.616576	2020-10-23 22:10:53.616576
1898	5	8	43	2	\N	2016-10-09	-174.79	e316443f25fef1e9ebf48b221dc41b28	2020-10-23 22:10:53.617712	2020-10-23 22:10:53.617712
1899	1	1	-1	2	\N	2016-10-08	-6.58	51ef186e18dc00c2d31982567235c559	2020-10-23 22:10:53.619122	2020-10-23 22:10:53.619122
1900	1	1	-1	2	\N	2016-10-07	-14.50	a891fab616218a3f7195a5eea2518005	2020-10-23 22:10:53.620494	2020-10-23 22:10:53.620494
1901	5	1	-1	2	\N	2016-10-09	-78.47	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.621826	2020-10-23 22:10:53.621826
1902	2	4	16	2	\N	2016-10-17	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:10:53.623032	2020-10-23 22:10:53.623032
1903	5	8	45	2	\N	2016-10-18	-36.00	e7b49124e25a0c36eccf98e1a6a1a153	2020-10-23 22:10:53.624181	2020-10-23 22:10:53.624181
1904	1	1	-1	2	\N	2016-10-12	-5.80	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:53.625389	2020-10-23 22:10:53.625389
1905	5	5	23	2	\N	2016-10-12	-89.64	5b1ef900028b395d16243191057244df	2020-10-23 22:10:53.626589	2020-10-23 22:10:53.626589
1906	5	1	-1	2	\N	2016-10-15	-21.96	c8fbbe3ab0d6d8839244383ae4887a0d	2020-10-23 22:10:53.627737	2020-10-23 22:10:53.627737
1907	5	5	23	2	\N	2016-10-13	-8.99	4b0a59ddf11c58e7446c9df0da541a84	2020-10-23 22:10:53.629037	2020-10-23 22:10:53.629037
1908	5	1	-1	2	\N	2016-10-12	-13.11	f0b37405c98cb029e67cf77819c435b0	2020-10-23 22:10:53.630142	2020-10-23 22:10:53.630142
1909	1	5	23	2	\N	2016-10-16	-16.41	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:10:53.631474	2020-10-23 22:10:53.631474
1910	1	1	-1	2	\N	2016-10-17	-2.79	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.632799	2020-10-23 22:10:53.632799
1911	5	1	-1	2	\N	2016-10-17	-13.22	86a2395a932aff7056c9e047e8c1f3f8	2020-10-23 22:10:53.634053	2020-10-23 22:10:53.634053
1912	1	1	-1	2	\N	2016-10-18	-1.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:53.635364	2020-10-23 22:10:53.635364
1913	1	5	21	2	\N	2016-10-18	-37.75	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:53.637179	2020-10-23 22:10:53.637179
1914	5	5	23	2	\N	2016-10-18	-25.00	5b1ef900028b395d16243191057244df	2020-10-23 22:10:53.638467	2020-10-23 22:10:53.638467
1915	1	1	-1	2	\N	2016-10-18	-14.73	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.640117	2020-10-23 22:10:53.640117
1916	1	1	-1	2	\N	2016-10-18	-16.68	207f466f93e1ea0d07fb2607ee058df7	2020-10-23 22:10:53.64121	2020-10-23 22:10:53.64121
1917	2	8	44	2	\N	2016-10-10	-31.77	a8c07d583f9358cd523718fb3ca56e72	2020-10-23 22:10:53.642231	2020-10-23 22:10:53.642231
1918	2	1	-1	2	\N	2016-10-10	-6.75	65b2f1d7cfef85c039935b7556f46be1	2020-10-23 22:10:53.643317	2020-10-23 22:10:53.643317
1919	2	1	-1	2	\N	2016-10-10	-39.43	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:53.644375	2020-10-23 22:10:53.644375
1920	5	1	-1	2	\N	2016-10-11	-28.98	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:53.645703	2020-10-23 22:10:53.645703
1921	2	6	27	2	\N	2016-10-11	-75.41	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:10:53.647408	2020-10-23 22:10:53.647408
1922	2	1	-1	2	\N	2016-10-12	-37.79	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:53.64883	2020-10-23 22:10:53.64883
1923	2	1	-1	2	\N	2016-10-13	-28.93	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:53.650357	2020-10-23 22:10:53.650357
1924	2	1	-1	2	\N	2016-10-14	-40.34	08bfb7e81f8e8e69c698fcc37d73c1d4	2020-10-23 22:10:53.651491	2020-10-23 22:10:53.651491
1925	2	1	-1	2	\N	2016-10-14	-29.19	95d26ffafee743d9f66206a4a6c6895a	2020-10-23 22:10:53.652712	2020-10-23 22:10:53.652712
1926	2	1	-1	2	\N	2016-10-19	-28.98	2e1c6ef401c6f4e66790a9df179b885f	2020-10-23 22:10:53.65413	2020-10-23 22:10:53.65413
1927	5	1	-1	1	\N	2016-10-19	28.98	2e1c6ef401c6f4e66790a9df179b885f	2020-10-23 22:10:53.655409	2020-10-23 22:10:53.655409
1928	2	10	54	3	\N	2016-10-19	-2000.00	7ce3284b743aefde80ffd9aec500e085	2020-10-23 22:10:53.65657	2020-10-23 22:10:53.65657
1929	4	10	54	4	\N	2016-10-19	2000.00	7ce3284b743aefde80ffd9aec500e085	2020-10-23 22:10:53.658023	2020-10-23 22:10:53.658023
1930	1	2	-1	1	\N	2016-10-20	1033.79	03d818313dca7055ea3c4f41f2679311	2020-10-23 22:10:53.659198	2020-10-23 22:10:53.659198
1931	5	1	-1	2	\N	2016-10-22	-7.17	860cad7f4fcdf603739ca94379e2f8ef	2020-10-23 22:10:53.660332	2020-10-23 22:10:53.660332
1932	1	6	27	2	\N	2016-10-22	-1399.80	ef9462de87ead2ea204c7c7069b3f513	2020-10-23 22:10:53.661556	2020-10-23 22:10:53.661556
1933	1	1	-1	2	\N	2016-10-22	-17.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.662801	2020-10-23 22:10:53.662801
1934	1	1	-1	2	\N	2016-10-22	-37.60	8df2c13088e42821ef575a790db5b015	2020-10-23 22:10:53.664004	2020-10-23 22:10:53.664004
1935	5	5	23	2	\N	2016-10-19	-19.99	19bcd8bfc9812692b9e1cb9f759a09a2	2020-10-23 22:10:53.665083	2020-10-23 22:10:53.665083
1936	1	1	11	2	\N	2016-10-18	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.66616	2020-10-23 22:10:53.66616
1937	5	1	-1	2	\N	2016-10-20	-91.33	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:53.667281	2020-10-23 22:10:53.667281
1938	2	9	48	2	\N	2016-10-20	-149.98	dda42991d4b466afefaa108c9c2f6eeb	2020-10-23 22:10:53.668388	2020-10-23 22:10:53.668388
1939	2	1	-1	2	\N	2016-10-23	-20.00	51dc44968c1e1ce918082679732df9bf	2020-10-23 22:10:53.670069	2020-10-23 22:10:53.670069
1940	2	7	30	2	\N	2016-10-23	-1260.72	fe8c15fed5f808006ce95eddb7366e35	2020-10-23 22:10:53.671389	2020-10-23 22:10:53.671389
1941	1	8	41	2	\N	2016-10-24	-46.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:10:53.672557	2020-10-23 22:10:53.672557
1942	1	5	21	2	\N	2016-10-24	-113.90	468b93d3184e7651de18b0c697eda59d	2020-10-23 22:10:53.674019	2020-10-23 22:10:53.674019
1943	2	6	27	2	\N	2016-10-24	-35.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:10:53.675262	2020-10-23 22:10:53.675262
1944	2	4	18	2	\N	2016-10-27	-338.30	f344a40a52a94ab7903e6b35896b543e	2020-10-23 22:10:53.676451	2020-10-23 22:10:53.676451
1945	2	2	3	1	\N	2016-10-27	5678.34	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:10:53.677573	2020-10-23 22:10:53.677573
1946	2	10	54	3	\N	2016-10-27	-1500.00	e62595ee98b585153dac87ce1ab69c3c	2020-10-23 22:10:53.678681	2020-10-23 22:10:53.678681
1947	2	10	54	3	\N	2016-10-27	-2500.00	b9c4c0ec0a3bc8870a7307f5a3e3b494	2020-10-23 22:10:53.679844	2020-10-23 22:10:53.679844
1948	5	10	54	4	\N	2016-10-27	1500.00	e62595ee98b585153dac87ce1ab69c3c	2020-10-23 22:10:53.681031	2020-10-23 22:10:53.681031
1949	6	10	54	4	\N	2016-10-27	2500.00	b9c4c0ec0a3bc8870a7307f5a3e3b494	2020-10-23 22:10:53.682322	2020-10-23 22:10:53.682322
1950	1	2	3	1	\N	2016-10-26	9133.05	3b067c57f5a49076b2827f5061d93810	2020-10-23 22:10:53.683598	2020-10-23 22:10:53.683598
1951	1	1	-1	2	\N	2016-10-26	-11.98	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.684922	2020-10-23 22:10:53.684922
1952	1	9	48	2	\N	2016-10-29	-24.50	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:53.686298	2020-10-23 22:10:53.686298
1953	5	1	-1	2	\N	2016-10-29	-13.00	39af031dbed803c6c17f4e3848566a66	2020-10-23 22:10:53.687769	2020-10-23 22:10:53.687769
1954	1	1	-1	2	\N	2016-10-25	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:53.68892	2020-10-23 22:10:53.68892
1955	5	1	-1	2	\N	2016-10-28	-15.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:10:53.689996	2020-10-23 22:10:53.689996
1956	5	1	-1	2	\N	2016-10-28	-4.90	c1445cabed5c957bd296c8f327306d5a	2020-10-23 22:10:53.691032	2020-10-23 22:10:53.691032
1957	1	9	48	2	\N	2016-10-27	-12.00	2fbd284a27d3bd75eb1f86e36c33d9e2	2020-10-23 22:10:53.69267	2020-10-23 22:10:53.69267
1958	5	1	-1	2	\N	2016-10-29	-5.70	711b11d280c95049e90546804a530030	2020-10-23 22:10:53.693932	2020-10-23 22:10:53.693932
1959	5	1	-1	2	\N	2016-10-29	-25.67	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:53.69507	2020-10-23 22:10:53.69507
1960	1	1	-1	2	\N	2016-10-25	-1.79	85ef939c6c3ff3966e25169134a8006b	2020-10-23 22:10:53.696181	2020-10-23 22:10:53.696181
1961	1	1	11	2	\N	2016-10-25	-20.57	b2b36a2becd039215094ccf3fa43aee1	2020-10-23 22:10:53.697348	2020-10-23 22:10:53.697348
1962	1	10	54	3	\N	2016-10-29	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:53.698628	2020-10-23 22:10:53.698628
1963	1	10	54	3	\N	2016-10-29	-1500.00	8a8625ece1d74a011a5616629fe94b1f	2020-10-23 22:10:53.699892	2020-10-23 22:10:53.699892
1964	6	10	54	4	\N	2016-10-29	1500.00	8a8625ece1d74a011a5616629fe94b1f	2020-10-23 22:10:53.701038	2020-10-23 22:10:53.701038
1965	1	10	54	3	\N	2016-10-29	-1000.00	1cc3633c579a90cfdd895e64021e2163	2020-10-23 22:10:53.702087	2020-10-23 22:10:53.702087
1966	3	10	54	4	\N	2016-10-29	1000.00	1cc3633c579a90cfdd895e64021e2163	2020-10-23 22:10:53.703304	2020-10-23 22:10:53.703304
1967	1	10	54	3	\N	2016-10-29	-4000.00	23e0326cca6fd2a035cfcef4fb3a68f6	2020-10-23 22:10:53.704505	2020-10-23 22:10:53.704505
1968	6	10	54	4	\N	2016-10-29	4000.00	23e0326cca6fd2a035cfcef4fb3a68f6	2020-10-23 22:10:53.705845	2020-10-23 22:10:53.705845
1969	2	2	-1	1	\N	2016-10-28	6145.48	e27378559b6bd4675c207991d921ceda	2020-10-23 22:10:53.707111	2020-10-23 22:10:53.707111
1970	2	9	-1	2	\N	2016-10-28	-4932.87	b4288d9c0ec0a1841b3b3728321e7088	2020-10-23 22:10:53.708374	2020-10-23 22:10:53.708374
1971	5	1	-1	2	\N	2016-10-29	-248.75	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:53.709611	2020-10-23 22:10:53.709611
1972	5	1	-1	2	\N	2016-10-29	-191.97	9d862a87b8a029b45c385b57ece47e0d	2020-10-23 22:10:53.710772	2020-10-23 22:10:53.710772
1973	5	6	27	2	\N	2016-10-28	-82.00	c244b83e57695ab921f94faee20cac43	2020-10-23 22:10:53.71248	2020-10-23 22:10:53.71248
1974	2	6	27	2	\N	2016-10-29	-82.00	c244b83e57695ab921f94faee20cac43	2020-10-23 22:10:53.713687	2020-10-23 22:10:53.713687
1975	5	6	27	1	\N	2016-10-29	82.00	c244b83e57695ab921f94faee20cac43	2020-10-23 22:10:53.714873	2020-10-23 22:10:53.714873
1976	2	10	54	3	\N	2016-10-30	-1000.00	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:10:53.716107	2020-10-23 22:10:53.716107
1977	6	10	54	4	\N	2016-10-30	1000.00	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:10:53.717254	2020-10-23 22:10:53.717254
1978	2	10	54	3	\N	2016-10-30	-1000.00	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:10:53.718449	2020-10-23 22:10:53.718449
1979	4	10	54	4	\N	2016-10-30	1000.00	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:10:53.719791	2020-10-23 22:10:53.719791
1980	5	9	48	2	\N	2016-10-31	-19.92	31fefc0e570cb3860f2a6d4b38c6490d	2020-10-23 22:10:53.721157	2020-10-23 22:10:53.721157
1981	5	4	13	2	\N	2016-10-31	-344.25	80be1b8fd4413ff9b47f733a4dc5bee5	2020-10-23 22:10:53.722368	2020-10-23 22:10:53.722368
1982	5	4	15	2	\N	2016-10-31	-114.48	228a695337a15a74e85365e8a836935e	2020-10-23 22:10:53.723665	2020-10-23 22:10:53.723665
1983	5	4	16	2	\N	2016-10-31	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:53.72489	2020-10-23 22:10:53.72489
1984	5	4	-1	2	\N	2016-10-31	-590.00	0f243f3be92942b7bc653ac46e835ec2	2020-10-23 22:10:53.726288	2020-10-23 22:10:53.726288
1985	1	9	-1	2	\N	2016-11-01	-10.00	1a5b1e4daae265b790965a275b53ae50	2020-10-23 22:10:53.727372	2020-10-23 22:10:53.727372
1986	1	1	-1	2	\N	2016-10-31	-44.72	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.728385	2020-10-23 22:10:53.728385
1987	1	5	25	2	\N	2016-10-31	-35.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:53.729739	2020-10-23 22:10:53.729739
1988	5	5	23	2	\N	2016-10-31	-9.89	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:53.731181	2020-10-23 22:10:53.731181
1989	1	7	33	2	\N	2016-11-02	-29.99	d045c59a90d7587d8d671b5f5aec4e7c	2020-10-23 22:10:53.732429	2020-10-23 22:10:53.732429
1990	6	10	55	1	\N	2016-10-31	63.38	6c03a1381f19bcd8b80eb6e448827882	2020-10-23 22:10:53.733771	2020-10-23 22:10:53.733771
1991	5	1	-1	2	\N	2016-11-02	-61.46	52850519e2b8990d5b11cb52f947d832	2020-10-23 22:10:53.735041	2020-10-23 22:10:53.735041
1992	5	5	21	2	\N	2016-11-02	-91.53	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:53.73638	2020-10-23 22:10:53.73638
1993	5	10	54	1	\N	2016-11-02	1500.00	f344a40a52a94ab7903e6b35896b543e	2020-10-23 22:10:53.737956	2020-10-23 22:10:53.737956
1994	5	5	23	2	\N	2016-11-02	-31.98	b662f239dc62c4b92fc0e3bb81742b2e	2020-10-23 22:10:53.739376	2020-10-23 22:10:53.739376
1995	5	5	23	2	\N	2016-11-02	-18.99	e9b1ad953dcf5fd357195adadc014066	2020-10-23 22:10:53.740452	2020-10-23 22:10:53.740452
1996	1	1	-1	2	\N	2016-11-04	-2.45	69cb3ea317a32c4e6143e665fdb20b14	2020-10-23 22:10:53.741497	2020-10-23 22:10:53.741497
1997	5	5	23	2	\N	2016-11-03	-26.99	77cb694303503450ca673be9b2fd2ed2	2020-10-23 22:10:53.742524	2020-10-23 22:10:53.742524
1998	1	1	-1	2	\N	2016-11-02	-3.55	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:53.744289	2020-10-23 22:10:53.744289
1999	1	1	11	2	\N	2016-11-04	-4.99	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:53.745608	2020-10-23 22:10:53.745608
2000	5	1	-1	2	\N	2016-11-04	-19.53	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.746899	2020-10-23 22:10:53.746899
2001	1	9	-1	2	\N	2016-11-04	-1.00	6c3cf77d52820cd0fe646d38bc2145ca	2020-10-23 22:10:53.748207	2020-10-23 22:10:53.748207
2002	5	1	-1	2	\N	2016-11-05	-5.19	de000668f8becda6e1abe88552ac25f7	2020-10-23 22:10:53.749627	2020-10-23 22:10:53.749627
2003	5	1	-1	2	\N	2016-11-05	-8.80	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:53.750995	2020-10-23 22:10:53.750995
2004	5	1	-1	2	\N	2016-11-05	-14.55	914b62192c43efb8aa203ef848054856	2020-10-23 22:10:53.752498	2020-10-23 22:10:53.752498
2005	1	3	-1	2	\N	2016-11-05	-5.48	d2467530ef7303b14c9988df20bb8ce4	2020-10-23 22:10:53.754066	2020-10-23 22:10:53.754066
2006	1	3	-1	2	\N	2016-11-05	-25.30	4de7cd7b4a762dc9becd4afaf10c4a9d	2020-10-23 22:10:53.75552	2020-10-23 22:10:53.75552
2007	5	1	-1	2	\N	2016-11-05	-11.94	0ff39bbbf981ac0151d340c9aa40e63e	2020-10-23 22:10:53.756885	2020-10-23 22:10:53.756885
2008	1	1	-1	2	\N	2016-11-06	-7.57	9afe2b8215c08e9d7cab10fe37686726	2020-10-23 22:10:53.758225	2020-10-23 22:10:53.758225
2009	5	1	-1	2	\N	2016-11-06	-60.00	c753ca99cb9a635d99942cc37f0a0ce5	2020-10-23 22:10:53.759599	2020-10-23 22:10:53.759599
2010	2	9	48	2	\N	2016-11-07	-109.82	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:10:53.760939	2020-10-23 22:10:53.760939
2011	2	9	48	2	\N	2016-11-07	-44.50	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:10:53.762486	2020-10-23 22:10:53.762486
2012	2	9	48	2	\N	2016-11-07	-36.94	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:10:53.764201	2020-10-23 22:10:53.764201
2013	2	5	21	2	\N	2016-11-07	-13.38	7ac40f334458e1ae276de8609e6e77e9	2020-10-23 22:10:53.765862	2020-10-23 22:10:53.765862
2014	2	9	49	2	\N	2016-11-07	-16.35	884d247c6f65a96a7da4d1105d584ddd	2020-10-23 22:10:53.7673	2020-10-23 22:10:53.7673
2015	5	4	14	2	\N	2016-11-08	-133.95	e86ed757bb8302f8c6c2bb648d65e213	2020-10-23 22:10:53.768492	2020-10-23 22:10:53.768492
2016	1	1	-1	2	\N	2016-11-08	-15.40	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.770016	2020-10-23 22:10:53.770016
2017	5	1	-1	2	\N	2016-11-08	-10.29	27377792dd0e58af31b18d08d1aac17e	2020-10-23 22:10:53.771592	2020-10-23 22:10:53.771592
2018	5	1	-1	2	\N	2016-11-08	-7.78	470e7a4f017a5476afb7eeb3f8b96f9b	2020-10-23 22:10:53.773546	2020-10-23 22:10:53.773546
2019	5	3	-1	2	\N	2016-11-08	-15.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:10:53.775169	2020-10-23 22:10:53.775169
2020	5	1	-1	2	\N	2016-11-08	-38.33	9766527f2b5d3e95d4a733fcfb77bd7e	2020-10-23 22:10:53.776908	2020-10-23 22:10:53.776908
2021	5	8	43	2	\N	2016-11-09	-29.99	329f96e8c09d79abd767f696183d7dfa	2020-10-23 22:10:53.778503	2020-10-23 22:10:53.778503
2022	5	8	43	2	\N	2016-11-13	-5.00	77726bbfd8c9d1ddde666c077acde196	2020-10-23 22:10:53.780408	2020-10-23 22:10:53.780408
2023	1	8	43	2	\N	2016-11-13	-1.00	77726bbfd8c9d1ddde666c077acde196	2020-10-23 22:10:53.781936	2020-10-23 22:10:53.781936
2024	5	8	43	2	\N	2016-11-11	-177.80	26408ffa703a72e8ac0117e74ad46f33	2020-10-23 22:10:53.783982	2020-10-23 22:10:53.783982
2025	5	9	-1	2	\N	2016-11-12	-13.70	f59fdf375356ae3796c80c76ff51ba53	2020-10-23 22:10:53.785374	2020-10-23 22:10:53.785374
2026	5	3	-1	2	\N	2016-11-12	-44.10	dc309b9dd3445fa298c4d01c3d79658f	2020-10-23 22:10:53.787274	2020-10-23 22:10:53.787274
2027	5	1	-1	2	\N	2016-11-13	-60.27	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.788837	2020-10-23 22:10:53.788837
2028	5	8	43	2	\N	2016-11-07	-59.00	0f840be9b8db4d3fbd5ba2ce59211f55	2020-10-23 22:10:53.790284	2020-10-23 22:10:53.790284
2029	2	9	48	2	\N	2016-11-13	-79.49	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:10:53.792032	2020-10-23 22:10:53.792032
2030	2	4	16	2	\N	2016-11-13	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:53.7935	2020-10-23 22:10:53.7935
2031	5	3	-1	2	\N	2016-11-14	-8.98	f87be31a72bb8a8c23a86d9a6c80658a	2020-10-23 22:10:53.795047	2020-10-23 22:10:53.795047
2032	5	1	-1	2	\N	2016-11-14	-9.80	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.796249	2020-10-23 22:10:53.796249
2033	5	5	23	2	\N	2016-11-14	-10.26	63923f49e5241343aa7acb6a06a751e7	2020-10-23 22:10:53.797423	2020-10-23 22:10:53.797423
2034	1	1	-1	2	\N	2016-11-18	-12.24	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.798518	2020-10-23 22:10:53.798518
2035	5	1	-1	2	\N	2016-11-19	-9.00	937b588685c9a2a8f927c2181931400d	2020-10-23 22:10:53.821143	2020-10-23 22:10:53.821143
2036	5	5	23	2	\N	2016-11-19	-9.50	7cd0d39652f62f1724e04b7d7b8176cd	2020-10-23 22:10:53.823626	2020-10-23 22:10:53.823626
2037	1	1	11	2	\N	2016-11-18	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.82516	2020-10-23 22:10:53.82516
2038	5	1	-1	2	\N	2016-11-19	-6.44	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.826765	2020-10-23 22:10:53.826765
2039	5	1	-1	2	\N	2016-11-19	-48.04	320722549d1751cf3f247855f937b982	2020-10-23 22:10:53.828658	2020-10-23 22:10:53.828658
2040	5	1	-1	2	\N	2016-11-17	-6.75	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.830206	2020-10-23 22:10:53.830206
2041	5	1	-1	2	\N	2016-11-17	-3.95	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:53.8317	2020-10-23 22:10:53.8317
2042	5	1	-1	2	\N	2016-11-17	-47.02	320722549d1751cf3f247855f937b982	2020-10-23 22:10:53.834303	2020-10-23 22:10:53.834303
2043	2	5	21	2	\N	2016-11-07	-13.38	8b2ac250317d8bdb24daaeead085d546	2020-10-23 22:10:53.835936	2020-10-23 22:10:53.835936
2044	5	5	23	2	\N	2016-11-14	-10.26	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:10:53.837494	2020-10-23 22:10:53.837494
2045	5	1	-1	2	\N	2016-11-21	-16.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.839044	2020-10-23 22:10:53.839044
2046	5	5	23	2	\N	2016-11-21	-17.50	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:10:53.840481	2020-10-23 22:10:53.840481
2047	1	8	41	2	\N	2016-11-21	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:53.842113	2020-10-23 22:10:53.842113
2048	5	1	-1	2	\N	2016-11-22	-10.68	5f186416e080ba24cce21c2122e106ad	2020-10-23 22:10:53.843643	2020-10-23 22:10:53.843643
2049	5	5	21	2	\N	2016-11-22	-33.46	ce009312d54578c68576e5bc2f10208c	2020-10-23 22:10:53.845366	2020-10-23 22:10:53.845366
2050	1	5	21	2	\N	2016-11-22	-30.96	c7796e6bcbe26d476b2246e04d8176f6	2020-10-23 22:10:53.846851	2020-10-23 22:10:53.846851
2051	1	1	-1	2	\N	2016-11-22	-12.50	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.848626	2020-10-23 22:10:53.848626
2052	5	1	-1	2	\N	2016-11-22	-16.32	34ed066df378efacc9b924ec161e7639	2020-10-23 22:10:53.850422	2020-10-23 22:10:53.850422
2053	2	1	-1	2	\N	2016-11-23	-21.00	64223ccf70bbb65a3a4aceac37e21016	2020-10-23 22:10:53.852073	2020-10-23 22:10:53.852073
2054	1	9	49	2	\N	2016-11-25	-277.08	4dee7f40dd21f4879df0e70d955072b4	2020-10-23 22:10:53.85419	2020-10-23 22:10:53.85419
2055	5	1	-1	2	\N	2016-11-25	-11.94	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:53.856088	2020-10-23 22:10:53.856088
2056	5	5	22	2	\N	2016-11-26	-200.00	3c47d78fe7ac0b5edae392453e976c42	2020-10-23 22:10:53.857944	2020-10-23 22:10:53.857944
2057	2	5	21	2	\N	2016-11-26	-10.29	9addc82a168b2b3e70a3c831a187b5cb	2020-10-23 22:10:53.859774	2020-10-23 22:10:53.859774
2058	2	8	44	2	\N	2016-11-26	-6.00	afa939adf52ddcbd204c814afcdd754a	2020-10-23 22:10:53.86201	2020-10-23 22:10:53.86201
2059	1	1	-1	2	\N	2016-11-25	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:53.863869	2020-10-23 22:10:53.863869
2060	1	1	11	2	\N	2016-11-25	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.865628	2020-10-23 22:10:53.865628
2061	1	9	48	2	\N	2016-11-25	-283.50	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:53.867504	2020-10-23 22:10:53.867504
2062	5	7	38	2	\N	2016-11-26	-9.00	c720b31d2c8177e5a06e8e5ac3254261	2020-10-23 22:10:53.868983	2020-10-23 22:10:53.868983
2063	5	1	-1	2	\N	2016-11-26	-130.67	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:53.870937	2020-10-23 22:10:53.870937
2064	2	1	-1	2	\N	2016-11-25	-9.89	8bcc19a177970876bf838c89bae6ff52	2020-10-23 22:10:53.872387	2020-10-23 22:10:53.872387
2065	1	2	3	1	\N	2016-11-25	11509.01	5db3daef1ac645ecefb7c7707f50cccb	2020-10-23 22:10:53.874075	2020-10-23 22:10:53.874075
2066	1	10	54	3	\N	2016-11-25	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:10:53.876198	2020-10-23 22:10:53.876198
2067	1	10	54	3	\N	2016-11-25	-1500.00	17d63b1625c816c22647a73e1482372b	2020-10-23 22:10:53.877635	2020-10-23 22:10:53.877635
2068	5	10	54	4	\N	2016-11-25	1500.00	17d63b1625c816c22647a73e1482372b	2020-10-23 22:10:53.878997	2020-10-23 22:10:53.878997
2069	1	10	54	3	\N	2016-11-25	-7500.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:53.880773	2020-10-23 22:10:53.880773
2070	3	10	54	4	\N	2016-11-25	7500.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:53.882578	2020-10-23 22:10:53.882578
2071	1	10	54	3	\N	2016-11-25	-1500.00	6c079f53cab9e6766bb3368aac01ffe5	2020-10-23 22:10:53.884391	2020-10-23 22:10:53.884391
2072	3	10	54	3	\N	2016-11-27	-7500.00	729b3eb46deef960ee144aa1b32acdc9	2020-10-23 22:10:53.886157	2020-10-23 22:10:53.886157
2073	6	10	54	4	\N	2016-11-27	3500.00	ab817c9349cf9c4f6877e1894a1faa00	2020-10-23 22:10:53.888189	2020-10-23 22:10:53.888189
2074	1	10	54	3	\N	2016-11-27	-3500.00	ab817c9349cf9c4f6877e1894a1faa00	2020-10-23 22:10:53.890014	2020-10-23 22:10:53.890014
2075	3	10	54	4	\N	2016-11-27	2200.00	fe131d7f5a6b38b23cc967316c13dae2	2020-10-23 22:10:53.892325	2020-10-23 22:10:53.892325
2076	1	10	54	3	\N	2016-11-27	-2200.00	fe131d7f5a6b38b23cc967316c13dae2	2020-10-23 22:10:53.894816	2020-10-23 22:10:53.894816
2077	1	10	54	3	\N	2016-11-27	-1100.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:10:53.902504	2020-10-23 22:10:53.902504
2078	1	10	54	4	\N	2016-11-27	7500.00	729b3eb46deef960ee144aa1b32acdc9	2020-10-23 22:10:53.904568	2020-10-23 22:10:53.904568
2079	5	9	-1	2	\N	2016-11-27	-100.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:53.905883	2020-10-23 22:10:53.905883
2080	2	9	-1	1	\N	2016-11-27	100.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:53.906988	2020-10-23 22:10:53.906988
2081	5	9	48	2	\N	2016-11-27	-146.00	37bc2f75bf1bcfe8450a1a41c200364c	2020-10-23 22:10:53.908114	2020-10-23 22:10:53.908114
2082	2	9	48	2	\N	2016-11-27	-44.90	30f78cd500afd51e75d8351e4418ed9a	2020-10-23 22:10:53.909441	2020-10-23 22:10:53.909441
2083	5	9	48	2	\N	2016-11-27	-35.00	98161ea86740fe71734330821f7d6b81	2020-10-23 22:10:53.911172	2020-10-23 22:10:53.911172
2084	5	9	48	2	\N	2016-11-27	-56.99	2a9ced3967f417a7877cc296438e6fb4	2020-10-23 22:10:53.912698	2020-10-23 22:10:53.912698
2085	5	1	-1	2	\N	2016-11-27	-3.64	2f86f1028eed92d84e9b9e35843c1d6a	2020-10-23 22:10:53.914307	2020-10-23 22:10:53.914307
2086	2	1	-1	2	\N	2016-11-27	-20.00	ec4e01e598e5e988d2ff830c19b3e1ad	2020-10-23 22:10:53.915802	2020-10-23 22:10:53.915802
2087	2	8	41	2	\N	2016-11-27	-8.40	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:10:53.917243	2020-10-23 22:10:53.917243
2088	2	4	18	2	\N	2016-11-27	-40.68	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:53.918478	2020-10-23 22:10:53.918478
2089	5	9	48	2	\N	2016-11-27	-72.00	9a7a9f2793a745797d8e08f9dbc6a10e	2020-10-23 22:10:53.920348	2020-10-23 22:10:53.920348
2090	5	9	48	2	\N	2016-11-27	-44.70	8f108d05d23041b5866f9cb2ff109661	2020-10-23 22:10:53.921881	2020-10-23 22:10:53.921881
2091	5	8	43	2	\N	2016-11-27	-100.90	29dea2aaf1d32caff9b4566bff2687d6	2020-10-23 22:10:53.923381	2020-10-23 22:10:53.923381
2092	5	8	43	2	\N	2016-11-27	-83.72	700df6e8f55dd18a15e3083ba53effc3	2020-10-23 22:10:53.925421	2020-10-23 22:10:53.925421
2093	5	4	16	2	\N	2016-11-28	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:53.927108	2020-10-23 22:10:53.927108
2094	2	2	3	1	\N	2016-11-28	7000.27	d1dc065b2f2b62029d87f3938208d61e	2020-10-23 22:10:53.928685	2020-10-23 22:10:53.928685
2095	2	10	54	3	\N	2016-11-28	-1500.00	e08549a19f9035f313995d64075de7fa	2020-10-23 22:10:53.930238	2020-10-23 22:10:53.930238
2096	2	10	54	3	\N	2016-11-28	-1500.00	c705391d04121497dfbf72f6a533d1bc	2020-10-23 22:10:53.931673	2020-10-23 22:10:53.931673
2097	5	10	54	4	\N	2016-11-28	1500.00	e08549a19f9035f313995d64075de7fa	2020-10-23 22:10:53.933146	2020-10-23 22:10:53.933146
2098	6	10	54	4	\N	2016-11-28	1500.00	c705391d04121497dfbf72f6a533d1bc	2020-10-23 22:10:53.934601	2020-10-23 22:10:53.934601
2099	2	10	54	3	\N	2016-11-28	-1000.00	7cd98be5e1169540c0d3bffad38df058	2020-10-23 22:10:53.93619	2020-10-23 22:10:53.93619
2100	2	10	54	3	\N	2016-11-28	-1500.00	c705391d04121497dfbf72f6a533d1bc	2020-10-23 22:10:53.938194	2020-10-23 22:10:53.938194
2101	6	10	54	4	\N	2016-11-28	1000.00	7cd98be5e1169540c0d3bffad38df058	2020-10-23 22:10:53.939987	2020-10-23 22:10:53.939987
2102	4	10	54	4	\N	2016-11-28	1500.00	c705391d04121497dfbf72f6a533d1bc	2020-10-23 22:10:53.94159	2020-10-23 22:10:53.94159
2103	5	9	48	2	\N	2016-11-27	-69.96	b31c8fa57872f91daccc860b27f51af6	2020-10-23 22:10:53.943325	2020-10-23 22:10:53.943325
2104	1	1	11	2	\N	2016-11-27	-1.00	6ea2ef7311b482724a9b7b0bc0dd85c6	2020-10-23 22:10:53.944997	2020-10-23 22:10:53.944997
2105	5	1	-1	2	\N	2016-11-27	-4.98	a74b59c0f4fd1cc6e7ff3acb630e455c	2020-10-23 22:10:53.946459	2020-10-23 22:10:53.946459
2106	5	4	13	2	\N	2016-11-29	-344.25	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:10:53.948226	2020-10-23 22:10:53.948226
2107	5	4	15	2	\N	2016-11-29	-114.48	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:10:53.949558	2020-10-23 22:10:53.949558
2108	5	4	-1	2	\N	2016-11-29	-590.00	a8ef70fa8b69e69b272ba381ad58ec86	2020-10-23 22:10:53.950744	2020-10-23 22:10:53.950744
2109	2	9	-1	2	\N	2016-11-30	-11.50	22951f2450d2131b00c1a0baafda65dc	2020-10-23 22:10:53.951857	2020-10-23 22:10:53.951857
2110	2	8	41	2	\N	2016-11-30	-50.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:10:53.953335	2020-10-23 22:10:53.953335
2111	6	10	54	4	\N	2016-12-02	1500.00	e49b8b4053df9505e1f48c3a701c0682	2020-10-23 22:10:53.954659	2020-10-23 22:10:53.954659
2112	6	10	55	1	\N	2016-11-30	70.89	5311e735f2fb86f02443c525b1ead622	2020-10-23 22:10:53.956163	2020-10-23 22:10:53.956163
2113	1	1	11	2	\N	2016-12-02	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:53.957289	2020-10-23 22:10:53.957289
2114	1	1	11	2	\N	2016-12-02	-7.14	fe131d7f5a6b38b23cc967316c13dae2	2020-10-23 22:10:53.958456	2020-10-23 22:10:53.958456
2115	1	1	-1	2	\N	2016-11-29	-14.70	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.959519	2020-10-23 22:10:53.959519
2116	1	1	-1	2	\N	2016-11-29	-2.45	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:53.960713	2020-10-23 22:10:53.960713
2117	5	1	-1	2	\N	2016-12-01	-11.94	2eee138f866ed8993971164cf969590d	2020-10-23 22:10:53.962166	2020-10-23 22:10:53.962166
2118	5	1	-1	2	\N	2016-11-30	-58.68	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:53.963334	2020-10-23 22:10:53.963334
2119	5	5	23	2	\N	2016-11-30	-103.90	1e4ca0db331b0919fbb70c96514764f5	2020-10-23 22:10:53.964525	2020-10-23 22:10:53.964525
2120	1	7	33	2	\N	2016-11-30	-29.99	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:10:53.965694	2020-10-23 22:10:53.965694
2121	1	9	-1	2	\N	2016-12-02	-18.26	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:53.96698	2020-10-23 22:10:53.96698
2122	5	2	-1	1	\N	2016-12-02	35.93	aefd52743ca68817405fb48271a864c2	2020-10-23 22:10:53.96824	2020-10-23 22:10:53.96824
2123	3	10	54	3	\N	2016-12-02	-13200.00	272ddc4a91d83e63c917d7ba1ad9e332	2020-10-23 22:10:53.969477	2020-10-23 22:10:53.969477
2124	5	1	-1	2	\N	2016-12-03	-16.65	b534ba68236ba543ae44b22bd110a1d6	2020-10-23 22:10:53.970944	2020-10-23 22:10:53.970944
2125	5	5	23	2	\N	2016-12-03	-34.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:53.972365	2020-10-23 22:10:53.972365
2126	5	5	26	2	\N	2016-12-03	-14.93	d9d7dbddc29177b121a6aa1bb09d15fd	2020-10-23 22:10:53.973464	2020-10-23 22:10:53.973464
2127	5	1	-1	2	\N	2016-12-03	-8.10	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:10:53.974809	2020-10-23 22:10:53.974809
2128	1	9	48	2	\N	2016-12-03	-54.50	b2eaa5f4f4079e25ac2c33b54d6b7fa1	2020-10-23 22:10:53.976337	2020-10-23 22:10:53.976337
2129	1	7	36	2	\N	2016-12-03	-22.90	82489c9737cc245530c7a6ebef3753ec	2020-10-23 22:10:53.97752	2020-10-23 22:10:53.97752
2130	2	9	-1	2	\N	2016-12-04	-15.85	e935fef54719cd1ea514fa97ec613bb7	2020-10-23 22:10:53.97875	2020-10-23 22:10:53.97875
2131	5	9	-1	1	\N	2016-12-04	15.85	e935fef54719cd1ea514fa97ec613bb7	2020-10-23 22:10:53.980237	2020-10-23 22:10:53.980237
2132	2	7	31	2	\N	2016-12-04	-20.00	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:10:53.981399	2020-10-23 22:10:53.981399
2133	1	9	48	2	\N	2016-12-04	-216.99	172b15f388b945149bf9b57fa18a2ed2	2020-10-23 22:10:53.982523	2020-10-23 22:10:53.982523
2134	5	1	-1	2	\N	2016-12-04	-21.55	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.983651	2020-10-23 22:10:53.983651
2135	5	1	-1	2	\N	2016-12-04	-11.31	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.985031	2020-10-23 22:10:53.985031
2136	5	1	-1	2	\N	2016-12-04	-19.93	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:53.986268	2020-10-23 22:10:53.986268
2137	1	1	-1	2	\N	2016-12-05	-10.00	d8a3db1331d1d85d2bf5d4e8823f0d80	2020-10-23 22:10:53.987692	2020-10-23 22:10:53.987692
2138	1	9	48	2	\N	2016-12-05	-50.40	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:10:53.988872	2020-10-23 22:10:53.988872
2139	1	9	48	2	\N	2016-12-05	-23.24	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:10:53.989966	2020-10-23 22:10:53.989966
2140	1	2	-1	1	\N	2016-12-05	550.00	5c240e2f0693bf45f2cd42a6c67c4157	2020-10-23 22:10:53.991158	2020-10-23 22:10:53.991158
2141	1	8	41	2	\N	2016-12-05	-21.96	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:53.992345	2020-10-23 22:10:53.992345
2142	1	1	-1	2	\N	2016-12-07	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:53.993457	2020-10-23 22:10:53.993457
2143	5	1	-1	2	\N	2016-12-07	-92.92	eebc37163657a4d729b6e28c3b850fc9	2020-10-23 22:10:53.994709	2020-10-23 22:10:53.994709
2144	1	7	37	2	\N	2016-12-08	-4.00	547dda58658106fc165031928914e17f	2020-10-23 22:10:53.995855	2020-10-23 22:10:53.995855
2145	1	3	-1	2	\N	2016-12-08	-14.00	97d7e117f62a5a28540fe51c4e233f61	2020-10-23 22:10:53.997274	2020-10-23 22:10:53.997274
2146	1	1	11	2	\N	2016-12-09	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:53.998601	2020-10-23 22:10:53.998601
2147	1	1	-1	2	\N	2016-12-09	-16.06	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:53.999949	2020-10-23 22:10:53.999949
2148	1	1	11	2	\N	2016-12-09	-1.80	6fb954eb246cdc56d2d89e30d677336c	2020-10-23 22:10:54.001185	2020-10-23 22:10:54.001185
2149	5	1	-1	2	\N	2016-12-10	-33.85	61ca8a8b7d52d30c8655c4ba9928db64	2020-10-23 22:10:54.002717	2020-10-23 22:10:54.002717
2150	5	1	-1	2	\N	2016-12-10	-83.96	320722549d1751cf3f247855f937b982	2020-10-23 22:10:54.005019	2020-10-23 22:10:54.005019
2151	1	1	-1	2	\N	2016-12-10	-7.98	e7e5c2e2d0fad407a12c0a890c0d0133	2020-10-23 22:10:54.007026	2020-10-23 22:10:54.007026
2152	2	1	-1	2	\N	2016-12-11	-0.56	a5bc48da98a520ab4b37a5c8eb009cc9	2020-10-23 22:10:54.008392	2020-10-23 22:10:54.008392
2153	5	5	23	2	\N	2016-12-12	-6.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.009729	2020-10-23 22:10:54.009729
2154	5	5	23	2	\N	2016-12-12	-9.30	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.011246	2020-10-23 22:10:54.011246
2155	5	9	48	2	\N	2016-12-13	-75.00	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:10:54.012542	2020-10-23 22:10:54.012542
2156	5	9	48	2	\N	2016-12-13	-14.90	208b2c346f1de235e4ef1e7c3f890fc3	2020-10-23 22:10:54.013922	2020-10-23 22:10:54.013922
2157	2	9	48	2	\N	2016-12-13	-10.00	a2eb13cc3e0b62227c8931996a7e1bce	2020-10-23 22:10:54.015811	2020-10-23 22:10:54.015811
2158	5	3	-1	2	\N	2016-12-12	-17.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:10:54.017568	2020-10-23 22:10:54.017568
2159	2	3	-1	2	\N	2016-12-12	-25.48	0c3b4a2d08b08107327726d9dd3ebec4	2020-10-23 22:10:54.019285	2020-10-23 22:10:54.019285
2160	5	1	-1	2	\N	2016-12-07	-11.84	23b85ebbbd599ca5f2ea0a45a118d7d7	2020-10-23 22:10:54.020686	2020-10-23 22:10:54.020686
2161	2	1	-1	2	\N	2016-12-08	-4.07	23b85ebbbd599ca5f2ea0a45a118d7d7	2020-10-23 22:10:54.022003	2020-10-23 22:10:54.022003
2162	1	1	-1	2	\N	2016-12-15	-3.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.023225	2020-10-23 22:10:54.023225
2163	1	1	-1	2	\N	2016-12-14	-14.50	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.024431	2020-10-23 22:10:54.024431
2164	1	5	23	2	\N	2016-12-15	-42.88	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.025505	2020-10-23 22:10:54.025505
2165	5	5	23	2	\N	2016-12-15	-101.00	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.026566	2020-10-23 22:10:54.026566
2166	5	5	23	2	\N	2016-12-15	-35.57	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.027654	2020-10-23 22:10:54.027654
2167	1	10	54	3	\N	2016-12-15	-500.00	e205ee2a5de471a70c1fd1b46033a75f	2020-10-23 22:10:54.028948	2020-10-23 22:10:54.028948
2168	5	10	54	4	\N	2016-12-15	500.00	e205ee2a5de471a70c1fd1b46033a75f	2020-10-23 22:10:54.030244	2020-10-23 22:10:54.030244
2169	5	5	23	3	\N	2016-12-15	-42.88	85ef939c6c3ff3966e25169134a8006b	2020-10-23 22:10:54.031442	2020-10-23 22:10:54.031442
2170	1	2	-1	4	\N	2016-12-15	42.88	85ef939c6c3ff3966e25169134a8006b	2020-10-23 22:10:54.03266	2020-10-23 22:10:54.03266
2171	1	5	22	2	\N	2016-12-15	-26.00	dd6d5383fc56c4e65ed07665cd088f9a	2020-10-23 22:10:54.033821	2020-10-23 22:10:54.033821
2172	5	5	22	3	\N	2016-12-15	-26.00	3fe94a002317b5f9259f82690aeea4cd	2020-10-23 22:10:54.035017	2020-10-23 22:10:54.035017
2173	1	2	-1	4	\N	2016-12-15	26.00	3fe94a002317b5f9259f82690aeea4cd	2020-10-23 22:10:54.036309	2020-10-23 22:10:54.036309
2174	5	9	48	2	\N	2016-12-15	-32.90	b2dd7d505d68df0b925e5045ce8d4c8f	2020-10-23 22:10:54.037834	2020-10-23 22:10:54.037834
2175	5	9	48	2	\N	2016-12-15	-209.17	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:10:54.039041	2020-10-23 22:10:54.039041
2176	5	9	48	2	\N	2016-12-15	-15.00	cea1a1da958a6b3bcf93a70e3fced376	2020-10-23 22:10:54.040294	2020-10-23 22:10:54.040294
2177	2	9	48	2	\N	2016-12-15	-16.20	4e0928de075538c593fbdabb0c5ef2c3	2020-10-23 22:10:54.041624	2020-10-23 22:10:54.041624
2178	2	9	48	2	\N	2016-12-15	-129.80	6ccdec00af5166d66e2f8e45aac98975	2020-10-23 22:10:54.042853	2020-10-23 22:10:54.042853
2179	5	5	21	2	\N	2016-12-15	-118.09	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:54.044117	2020-10-23 22:10:54.044117
2180	2	5	21	2	\N	2016-12-15	-57.96	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:10:54.045513	2020-10-23 22:10:54.045513
2181	5	5	21	1	\N	2016-12-15	57.96	1b566cac7f0519e74f48bc63b8dda470	2020-10-23 22:10:54.046982	2020-10-23 22:10:54.046982
2182	2	10	54	3	\N	2016-12-15	-26500.00	b92e69f54ecb42fd22c839dd8cb68056	2020-10-23 22:10:54.048269	2020-10-23 22:10:54.048269
2183	4	10	54	4	\N	2016-12-15	26500.00	ddbceb90786c0766eb638ec7d4376cf2	2020-10-23 22:10:54.049402	2020-10-23 22:10:54.049402
2184	1	5	21	3	\N	2016-12-15	-26.27	9e94b15ed312fa42232fd87a55db0d39	2020-10-23 22:10:54.050537	2020-10-23 22:10:54.050537
2185	5	5	21	4	\N	2016-12-15	26.27	bcfe9bb5337cce255318bb10c381f919	2020-10-23 22:10:54.051652	2020-10-23 22:10:54.051652
2186	1	1	-1	2	\N	2016-12-16	-5.00	1ddd5cbfaad65fd327ac0cb6ad8ca2b8	2020-10-23 22:10:54.052983	2020-10-23 22:10:54.052983
2187	1	1	11	2	\N	2016-12-16	-5.99	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:10:54.054464	2020-10-23 22:10:54.054464
2188	1	9	48	2	\N	2016-12-17	-99.99	08a641013301b0c0294304b3e7b2f45c	2020-10-23 22:10:54.055932	2020-10-23 22:10:54.055932
2189	1	9	48	2	\N	2016-12-17	-85.28	1c1d4df596d01da60385f0bb17a4a9e0	2020-10-23 22:10:54.057259	2020-10-23 22:10:54.057259
2190	1	9	49	2	\N	2016-12-17	-17.99	1fe7306869529c380be67ed7a2e91478	2020-10-23 22:10:54.058506	2020-10-23 22:10:54.058506
2191	5	1	-1	2	\N	2016-12-17	-20.01	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.059821	2020-10-23 22:10:54.059821
2192	1	1	-1	2	\N	2016-12-17	-4.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.061302	2020-10-23 22:10:54.061302
2193	5	9	48	3	\N	2016-12-17	-49.99	c2f7ab46df3db842040a86a0897a5377	2020-10-23 22:10:54.062482	2020-10-23 22:10:54.062482
2194	1	2	-1	4	\N	2016-12-17	49.99	c2f7ab46df3db842040a86a0897a5377	2020-10-23 22:10:54.063605	2020-10-23 22:10:54.063605
2195	2	1	-1	2	\N	2016-12-15	-13.00	22c80808a91b7afa77ce0bf85a7cd7f9	2020-10-23 22:10:54.064899	2020-10-23 22:10:54.064899
2196	5	9	48	2	\N	2016-12-17	-39.89	d305177996baf37d4c5c301e96a6e760	2020-10-23 22:10:54.066084	2020-10-23 22:10:54.066084
2197	5	9	-1	2	\N	2016-12-18	-94.66	8f2f665a201e5b76e34c3321bd359740	2020-10-23 22:10:54.067276	2020-10-23 22:10:54.067276
2198	5	1	-1	2	\N	2016-12-18	-19.38	d64d5284264bf6d5f25915ad53b6a358	2020-10-23 22:10:54.068452	2020-10-23 22:10:54.068452
2199	5	8	44	2	\N	2016-12-19	-27.20	273e8ba1054319d9e47d2bef1c9ac7cb	2020-10-23 22:10:54.069969	2020-10-23 22:10:54.069969
2200	1	7	31	2	\N	2016-12-19	-34.00	291597a100aadd814d197af4f4bab3a7	2020-10-23 22:10:54.071337	2020-10-23 22:10:54.071337
2201	2	2	3	1	\N	2016-12-20	5623.73	140f6969d5213fd0ece03148e62e461e	2020-10-23 22:10:54.072655	2020-10-23 22:10:54.072655
2202	2	10	54	3	\N	2016-12-20	-1500.00	562fedbc9f28da2e55ec0344a39d5284	2020-10-23 22:10:54.073824	2020-10-23 22:10:54.073824
2203	5	10	54	4	\N	2016-12-20	1500.00	562fedbc9f28da2e55ec0344a39d5284	2020-10-23 22:10:54.074909	2020-10-23 22:10:54.074909
2204	2	10	54	3	\N	2016-12-20	-2200.00	824da999fd3743e7d4e6e19246b0cb55	2020-10-23 22:10:54.076121	2020-10-23 22:10:54.076121
2205	6	10	54	4	\N	2016-12-20	2200.00	824da999fd3743e7d4e6e19246b0cb55	2020-10-23 22:10:54.077353	2020-10-23 22:10:54.077353
2206	5	4	13	2	\N	2016-12-20	-344.25	a52a63e01e3414bb80dab89de7fdaff5	2020-10-23 22:10:54.078888	2020-10-23 22:10:54.078888
2207	5	4	15	2	\N	2016-12-20	-114.48	9013713c3b217945fe8bc4ec3bd2d436	2020-10-23 22:10:54.080321	2020-10-23 22:10:54.080321
2208	5	4	14	2	\N	2016-12-20	-114.77	102a31bba84c93e69dc27d8015863957	2020-10-23 22:10:54.081773	2020-10-23 22:10:54.081773
2209	5	4	-1	2	\N	2016-12-20	-590.00	af7df3a1c9e4ebec19d3fdab40d430a5	2020-10-23 22:10:54.083402	2020-10-23 22:10:54.083402
2210	5	8	44	2	\N	2016-12-20	-50.00	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:10:54.084906	2020-10-23 22:10:54.084906
2211	5	8	43	2	\N	2016-12-20	-295.00	e68dc4981c2310e883786e7f723fa37d	2020-10-23 22:10:54.086401	2020-10-23 22:10:54.086401
2212	1	1	-1	2	\N	2016-12-20	-2.45	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:54.087793	2020-10-23 22:10:54.087793
2213	1	1	-1	2	\N	2016-12-20	-12.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.088921	2020-10-23 22:10:54.088921
2214	1	2	3	1	\N	2016-12-20	9345.61	d2490f048dc3b77a457e3e450ab4eb38	2020-10-23 22:10:54.09036	2020-10-23 22:10:54.09036
2215	1	10	54	3	\N	2016-12-20	-1100.00	6a3b5c5a20b01f9952f1f2c17bdd8a52	2020-10-23 22:10:54.092439	2020-10-23 22:10:54.092439
2216	1	10	54	3	\N	2016-12-20	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:54.093636	2020-10-23 22:10:54.093636
2217	1	10	54	3	\N	2016-12-20	-2200.00	53cc638c15debc4d5b3bf12f949f5d79	2020-10-23 22:10:54.095019	2020-10-23 22:10:54.095019
2218	1	10	54	3	\N	2016-12-20	-1500.00	4233c671d9af706ea385d7db34a0ca71	2020-10-23 22:10:54.096231	2020-10-23 22:10:54.096231
2219	1	10	54	3	\N	2016-12-20	-1500.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:10:54.0974	2020-10-23 22:10:54.0974
2220	5	10	54	4	\N	2016-12-20	1500.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:10:54.098548	2020-10-23 22:10:54.098548
2221	1	10	54	3	\N	2016-12-20	-1500.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:10:54.099692	2020-10-23 22:10:54.099692
2222	6	10	54	4	\N	2016-12-20	1500.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:10:54.100847	2020-10-23 22:10:54.100847
2223	1	10	54	3	\N	2016-12-20	-1000.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:10:54.102126	2020-10-23 22:10:54.102126
2224	6	10	54	4	\N	2016-12-20	1000.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:10:54.103404	2020-10-23 22:10:54.103404
2225	1	1	11	2	\N	2016-12-21	-2.00	9b74428a7127863f5d881bdbd45cd87f	2020-10-23 22:10:54.104879	2020-10-23 22:10:54.104879
2226	1	1	11	2	\N	2016-12-21	-10.50	f828edc20051679939b205229f41e729	2020-10-23 22:10:54.106306	2020-10-23 22:10:54.106306
2227	1	1	-1	2	\N	2016-12-22	-14.36	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.107611	2020-10-23 22:10:54.107611
2228	1	1	-1	2	\N	2016-12-22	-12.73	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.109028	2020-10-23 22:10:54.109028
2229	5	1	-1	2	\N	2016-12-21	-17.84	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.11041	2020-10-23 22:10:54.11041
2230	2	5	21	2	\N	2016-12-22	-24.99	c75b6f114c23a4d7ea11331e7c00e73c	2020-10-23 22:10:54.111784	2020-10-23 22:10:54.111784
2231	2	3	-1	2	\N	2016-12-22	-10.00	73bc0e873332c29e17e0a37afaf030e5	2020-10-23 22:10:54.113282	2020-10-23 22:10:54.113282
2232	5	9	48	2	\N	2016-12-22	-34.90	5f0f5e5f33945135b874349cfbed4fb9	2020-10-23 22:10:54.114355	2020-10-23 22:10:54.114355
2233	5	1	-1	2	\N	2016-12-22	-14.73	98d6f58ab0dafbb86b083a001561bb34	2020-10-23 22:10:54.115511	2020-10-23 22:10:54.115511
2234	2	4	16	2	\N	2016-12-23	-19.99	f6bd47ac3fe64bc8dc33279851b0ebfa	2020-10-23 22:10:54.116658	2020-10-23 22:10:54.116658
2235	5	4	16	2	\N	2016-12-25	-49.90	1fa5da2d939a6f4d3a5a6592ace5ac0f	2020-10-23 22:10:54.117892	2020-10-23 22:10:54.117892
2236	2	4	18	2	\N	2016-12-25	-42.07	060ad92489947d410d897474079c1477	2020-10-23 22:10:54.11916	2020-10-23 22:10:54.11916
2237	2	5	23	2	\N	2016-12-27	-20.58	396b9e79fc8438e96d20ac292944ced3	2020-10-23 22:10:54.120484	2020-10-23 22:10:54.120484
2238	2	6	43	2	\N	2016-12-25	-29.99	34caf9a9cd06f43282f4d158109ec0ca	2020-10-23 22:10:54.121996	2020-10-23 22:10:54.121996
2239	2	5	48	2	\N	2016-12-24	-13.00	1f6294ad29107e6871ff715ad7d43129	2020-10-23 22:10:54.12383	2020-10-23 22:10:54.12383
2240	5	9	-1	2	\N	2016-12-25	-46.27	173f6138afd9b026372907766f8d3764	2020-10-23 22:10:54.125327	2020-10-23 22:10:54.125327
2241	1	8	41	2	\N	2016-12-27	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:54.1266	2020-10-23 22:10:54.1266
2242	5	8	43	2	\N	2017-01-01	-183.84	e205ee2a5de471a70c1fd1b46033a75f	2020-10-23 22:10:54.127882	2020-10-23 22:10:54.127882
2243	5	7	31	2	\N	2016-12-28	-37.00	37ed61cfb742b9eef9d417ac03ed9d46	2020-10-23 22:10:54.129023	2020-10-23 22:10:54.129023
2244	5	1	-1	2	\N	2016-12-30	-46.98	9c91ba4952ec7cc9395f270984df0a82	2020-10-23 22:10:54.130115	2020-10-23 22:10:54.130115
2245	1	7	33	2	\N	2016-12-30	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:54.131361	2020-10-23 22:10:54.131361
2246	5	5	21	2	\N	2016-12-28	-31.40	e5f9e111c81a67d11c69032bf1116c6c	2020-10-23 22:10:54.132823	2020-10-23 22:10:54.132823
2247	1	10	54	4	\N	2017-01-01	100.00	f7656e9fb889d8ba19dc12017c08eda8	2020-10-23 22:10:54.134096	2020-10-23 22:10:54.134096
2248	1	10	54	3	\N	2017-01-01	-100.00	f7656e9fb889d8ba19dc12017c08eda8	2020-10-23 22:10:54.135543	2020-10-23 22:10:54.135543
2249	5	1	-1	2	\N	2017-01-01	-11.94	00b9568dbb693e6b97ec5200da07bc47	2020-10-23 22:10:54.137477	2020-10-23 22:10:54.137477
2250	5	9	48	2	\N	2016-12-30	-10.99	d17eca2e1a1943fe407399a43ddf65be	2020-10-23 22:10:54.139285	2020-10-23 22:10:54.139285
2251	1	1	-1	2	\N	2016-12-30	-2.00	fb4468645f162092401b2488483bb691	2020-10-23 22:10:54.140604	2020-10-23 22:10:54.140604
2252	1	3	-1	2	\N	2016-12-30	-13.96	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:54.142089	2020-10-23 22:10:54.142089
2253	1	9	-1	2	\N	2016-12-31	-43.64	3e716f30c8450143d7248609a6653887	2020-10-23 22:10:54.143499	2020-10-23 22:10:54.143499
2254	5	2	-1	4	\N	2016-12-28	13.00	80bb3759b7d1c02f3d37e11bdc835159	2020-10-23 22:10:54.144814	2020-10-23 22:10:54.144814
2255	5	9	-1	2	\N	2016-12-31	-15.18	3e716f30c8450143d7248609a6653887	2020-10-23 22:10:54.146091	2020-10-23 22:10:54.146091
2256	6	10	55	1	\N	2016-12-31	82.88	1905aedab9bf2477edc068a355bba31a	2020-10-23 22:10:54.147327	2020-10-23 22:10:54.147327
2257	1	2	-1	4	\N	2017-01-01	0.00	89d6846a7c3e6cbac0e0f42264450ba7	2020-10-23 22:10:54.148623	2020-10-23 22:10:54.148623
2258	5	1	-1	2	\N	2017-01-02	-95.37	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.150016	2020-10-23 22:10:54.150016
2259	5	2	-1	4	\N	2017-01-02	1500.00	7e7757b1e12abcb736ab9a754ffb617a	2020-10-23 22:10:54.151243	2020-10-23 22:10:54.151243
2260	5	5	23	2	\N	2017-01-02	-63.97	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.152669	2020-10-23 22:10:54.152669
2261	5	1	-1	2	\N	2017-01-02	-5.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.154071	2020-10-23 22:10:54.154071
2262	5	1	11	2	\N	2017-01-02	-1.80	14065fdb806e73e4874d76f6d17e79d9	2020-10-23 22:10:54.155276	2020-10-23 22:10:54.155276
2263	5	8	41	2	\N	2017-01-02	-3.80	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:54.156394	2020-10-23 22:10:54.156394
2264	5	1	-1	2	\N	2017-01-02	-2.79	e0932d6426c66ffde75f845923a6d77d	2020-10-23 22:10:54.157571	2020-10-23 22:10:54.157571
2265	5	10	54	3	\N	2017-01-02	-1000.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:10:54.159065	2020-10-23 22:10:54.159065
2266	6	10	54	4	\N	2017-01-02	1000.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:10:54.160411	2020-10-23 22:10:54.160411
2267	1	4	16	2	\N	2017-01-02	-21.50	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:10:54.16168	2020-10-23 22:10:54.16168
2268	1	2	-1	4	\N	2017-01-02	9800.00	d1c93c5bd481bd3d366c0407c60902c0	2020-10-23 22:10:54.16315	2020-10-23 22:10:54.16315
2269	1	2	-1	4	\N	2017-01-02	2000.00	d14220ee66aeec73c49038385428ec4c	2020-10-23 22:10:54.164483	2020-10-23 22:10:54.164483
2270	1	2	3	1	\N	2017-01-02	712.80	6f145d35eb70b65980be6dc26adeb058	2020-10-23 22:10:54.165724	2020-10-23 22:10:54.165724
2271	1	9	49	2	\N	2017-01-02	-30.40	5b1ef900028b395d16243191057244df	2020-10-23 22:10:54.167047	2020-10-23 22:10:54.167047
2272	1	9	49	2	\N	2017-01-02	-52.94	3b29727da65c7501710b6c9f1a8101bc	2020-10-23 22:10:54.168173	2020-10-23 22:10:54.168173
2273	1	9	49	2	\N	2017-01-04	-2100.00	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:54.169267	2020-10-23 22:10:54.169267
2274	1	9	49	2	\N	2017-01-05	-17.25	7f9098b3aa499fc3c45fc1b938fa2983	2020-10-23 22:10:54.17096	2020-10-23 22:10:54.17096
2275	1	9	-1	2	\N	2017-01-03	-5.00	9c53c3afcaeef658a8db8da3dda4aa69	2020-10-23 22:10:54.172322	2020-10-23 22:10:54.172322
2276	1	7	32	2	\N	2017-01-06	-71.00	901695fb1e54f4a451ba70a6e45d9d8d	2020-10-23 22:10:54.173494	2020-10-23 22:10:54.173494
2277	5	9	48	2	\N	2017-01-06	-74.99	a8ecbabae151abacba7dbde04f761c37	2020-10-23 22:10:54.174773	2020-10-23 22:10:54.174773
2278	5	1	-1	2	\N	2017-01-08	-2.78	a74b59c0f4fd1cc6e7ff3acb630e455c	2020-10-23 22:10:54.176467	2020-10-23 22:10:54.176467
2279	5	1	-1	2	\N	2017-01-08	-107.16	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.177621	2020-10-23 22:10:54.177621
2280	5	1	-1	2	\N	2017-01-09	-16.24	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.17874	2020-10-23 22:10:54.17874
2281	1	8	42	2	\N	2017-01-09	-40.00	52523aa4bb7d0e9033453b98dd6b6e87	2020-10-23 22:10:54.180019	2020-10-23 22:10:54.180019
2282	5	7	36	2	\N	2017-01-09	-129.99	719b75424fd8dfc276c4da51ec8306f0	2020-10-23 22:10:54.181023	2020-10-23 22:10:54.181023
2283	5	5	23	2	\N	2017-01-09	-37.49	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.182205	2020-10-23 22:10:54.182205
2284	5	5	21	2	\N	2017-01-09	-36.96	3cf91fd9a117253d8aff65d5bbb3fcfa	2020-10-23 22:10:54.183446	2020-10-23 22:10:54.183446
2285	1	5	21	2	\N	2017-01-09	-66.95	3cf91fd9a117253d8aff65d5bbb3fcfa	2020-10-23 22:10:54.184756	2020-10-23 22:10:54.184756
2286	1	1	-1	2	\N	2017-01-09	-2.36	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.186456	2020-10-23 22:10:54.186456
2287	1	1	-1	2	\N	2017-01-10	-3.16	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.187865	2020-10-23 22:10:54.187865
2288	1	3	-1	2	\N	2017-01-11	-30.00	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:10:54.189087	2020-10-23 22:10:54.189087
2289	1	1	-1	2	\N	2017-01-11	-3.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.19081	2020-10-23 22:10:54.19081
2290	1	8	41	2	\N	2017-01-12	-9.40	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:10:54.192118	2020-10-23 22:10:54.192118
2291	1	1	-1	2	\N	2017-01-12	-2.65	14065fdb806e73e4874d76f6d17e79d9	2020-10-23 22:10:54.193378	2020-10-23 22:10:54.193378
2292	1	1	-1	2	\N	2017-01-11	-4.25	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:10:54.195089	2020-10-23 22:10:54.195089
2293	1	1	-1	2	\N	2017-01-13	-20.21	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.196431	2020-10-23 22:10:54.196431
2294	5	1	-1	2	\N	2017-01-14	-26.21	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.197799	2020-10-23 22:10:54.197799
2295	1	1	-1	2	\N	2017-01-14	-9.70	1efa39bcaec6f3900149160693694536	2020-10-23 22:10:54.199253	2020-10-23 22:10:54.199253
2296	1	9	48	2	\N	2017-01-14	-10.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:54.200598	2020-10-23 22:10:54.200598
2297	1	1	-1	2	\N	2017-01-14	-3.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.201874	2020-10-23 22:10:54.201874
2298	1	9	-1	2	\N	2017-01-15	-10.00	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:10:54.203352	2020-10-23 22:10:54.203352
2299	5	9	48	2	\N	2017-01-15	-19.99	404484e0cd9e0617f39d5dd308a80a09	2020-10-23 22:10:54.204733	2020-10-23 22:10:54.204733
2300	5	1	-1	2	\N	2017-01-15	-71.90	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.20587	2020-10-23 22:10:54.20587
2301	1	2	-1	1	\N	2017-01-12	40.00	1dbec22a9befca7676c6378e1d97c909	2020-10-23 22:10:54.206917	2020-10-23 22:10:54.206917
2302	5	7	36	2	\N	2017-01-15	-39.90	b9c4c0ec0a3bc8870a7307f5a3e3b494	2020-10-23 22:10:54.208069	2020-10-23 22:10:54.208069
2303	5	9	48	2	\N	2017-01-15	-189.90	60696feae44e81f50c6c1c65cd5c24a5	2020-10-23 22:10:54.209284	2020-10-23 22:10:54.209284
2304	5	5	23	2	\N	2017-01-15	-27.59	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:10:54.210538	2020-10-23 22:10:54.210538
2305	1	7	36	2	\N	2017-01-15	-22.90	106f8a84b0d154c01cadc289aabc2e24	2020-10-23 22:10:54.211717	2020-10-23 22:10:54.211717
2306	2	9	-1	2	\N	2017-01-17	-488.21	a6424c058ac13a3bdac2580bde0e702a	2020-10-23 22:10:54.212915	2020-10-23 22:10:54.212915
2307	1	1	-1	2	\N	2017-01-17	-14.50	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.213964	2020-10-23 22:10:54.213964
2308	2	9	48	2	\N	2017-01-17	-79.99	7045bd5b973ab49104a88ed12b7424ba	2020-10-23 22:10:54.215018	2020-10-23 22:10:54.215018
2309	5	5	23	2	\N	2017-01-17	-7.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.216157	2020-10-23 22:10:54.216157
2310	5	1	-1	2	\N	2017-01-17	-12.96	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.217249	2020-10-23 22:10:54.217249
2311	2	9	-1	2	\N	2017-01-20	-58.00	8a4fe2eac821cc07db049f1279357195	2020-10-23 22:10:54.21838	2020-10-23 22:10:54.21838
2312	5	1	-1	2	\N	2017-01-19	-14.87	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.219585	2020-10-23 22:10:54.219585
2313	5	9	48	2	\N	2017-01-20	-67.00	04e0529dedd62c6f71a30ff5e281d459	2020-10-23 22:10:54.221204	2020-10-23 22:10:54.221204
2314	5	1	-1	2	\N	2017-01-21	-5.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.222563	2020-10-23 22:10:54.222563
2315	5	1	-1	2	\N	2017-01-21	-4.60	5b52f08c77c86d048c78ea841df47193	2020-10-23 22:10:54.223765	2020-10-23 22:10:54.223765
2316	1	1	11	2	\N	2017-01-20	-14.79	e1bc0db9c1a8a80883c7fd8df7332da0	2020-10-23 22:10:54.224885	2020-10-23 22:10:54.224885
2317	1	8	44	2	\N	2017-01-20	-10.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:54.226227	2020-10-23 22:10:54.226227
2318	5	1	-1	2	\N	2017-01-21	-85.67	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.227428	2020-10-23 22:10:54.227428
2319	5	1	-1	2	\N	2017-01-20	-13.36	8c7bbbba95c1025975e548cee86dfadc	2020-10-23 22:10:54.228574	2020-10-23 22:10:54.228574
2320	5	5	23	2	\N	2017-01-20	-50.97	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.229727	2020-10-23 22:10:54.229727
2321	1	1	-1	2	\N	2017-01-20	-3.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.230929	2020-10-23 22:10:54.230929
2322	2	1	-1	2	\N	2017-01-21	-32.84	45fbc6d3e05ebd93369ce542e8f2322d	2020-10-23 22:10:54.232811	2020-10-23 22:10:54.232811
2323	2	1	-1	2	\N	2017-01-21	-3.17	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:54.234064	2020-10-23 22:10:54.234064
2324	1	5	21	2	\N	2017-01-24	-13.99	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:54.235719	2020-10-23 22:10:54.235719
2325	1	1	-1	2	\N	2017-01-24	-19.92	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.237754	2020-10-23 22:10:54.237754
2326	5	1	-1	2	\N	2017-01-24	-16.32	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.239168	2020-10-23 22:10:54.239168
2327	2	5	21	2	\N	2017-01-24	-31.15	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:54.240647	2020-10-23 22:10:54.240647
2328	2	4	16	2	\N	2017-01-24	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:10:54.242116	2020-10-23 22:10:54.242116
2329	1	9	49	2	\N	2017-01-25	-24.60	7ea97341577f42fa6c189332e7a60af5	2020-10-23 22:10:54.243339	2020-10-23 22:10:54.243339
2330	5	1	-1	2	\N	2017-01-25	-7.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.244533	2020-10-23 22:10:54.244533
2331	1	2	3	1	\N	2017-01-25	10172.62	d2490f048dc3b77a457e3e450ab4eb38	2020-10-23 22:10:54.245917	2020-10-23 22:10:54.245917
2332	1	10	54	3	\N	2017-01-25	-500.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:10:54.24721	2020-10-23 22:10:54.24721
2333	1	10	54	3	\N	2017-01-25	-4500.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:54.24852	2020-10-23 22:10:54.24852
2334	6	10	54	4	\N	2017-01-25	4500.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:54.249771	2020-10-23 22:10:54.249771
2335	1	10	54	3	\N	2017-01-25	-2000.00	23b66dd4d9be6bba639bc882f30f5475	2020-10-23 22:10:54.251154	2020-10-23 22:10:54.251154
2336	1	10	54	3	\N	2017-01-25	-1100.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:10:54.252396	2020-10-23 22:10:54.252396
2337	1	1	-1	2	\N	2017-01-26	-14.68	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.253786	2020-10-23 22:10:54.253786
2338	5	1	-1	2	\N	2017-01-26	-4.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.255484	2020-10-23 22:10:54.255484
2339	5	1	-1	2	\N	2017-01-26	-14.42	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.25734	2020-10-23 22:10:54.25734
2340	5	5	23	2	\N	2017-01-26	-36.48	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.259072	2020-10-23 22:10:54.259072
2341	2	2	3	1	\N	2017-01-27	5598.89	7dea0847709f4fe2dd92e26cffddee72	2020-10-23 22:10:54.260175	2020-10-23 22:10:54.260175
2342	2	10	54	3	\N	2017-01-28	-1500.00	11ad377b5a9a9fd5491cf3acf5b37513	2020-10-23 22:10:54.261177	2020-10-23 22:10:54.261177
2343	5	10	54	4	\N	2017-01-28	1500.00	11ad377b5a9a9fd5491cf3acf5b37513	2020-10-23 22:10:54.262155	2020-10-23 22:10:54.262155
2344	2	10	54	3	\N	2017-01-28	-2000.00	922aa8292277aac1bd8b88d476997512	2020-10-23 22:10:54.263139	2020-10-23 22:10:54.263139
2345	6	10	54	4	\N	2017-01-28	2000.00	922aa8292277aac1bd8b88d476997512	2020-10-23 22:10:54.264231	2020-10-23 22:10:54.264231
2346	2	10	54	3	\N	2017-01-28	-3000.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:54.265363	2020-10-23 22:10:54.265363
2347	4	10	54	4	\N	2017-01-28	3000.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:54.266446	2020-10-23 22:10:54.266446
2348	1	6	27	2	\N	2017-01-28	-29.97	e77bc7b6a888586184d57c4b852b7b19	2020-10-23 22:10:54.267476	2020-10-23 22:10:54.267476
2349	1	9	-1	2	\N	2017-01-27	-30.00	fec8d47d412bcbeece3d9128ae855a7a	2020-10-23 22:10:54.268623	2020-10-23 22:10:54.268623
2350	1	1	-1	2	\N	2017-01-27	-7.08	04e0529dedd62c6f71a30ff5e281d459	2020-10-23 22:10:54.270713	2020-10-23 22:10:54.270713
2351	1	1	-1	2	\N	2017-01-27	-14.16	1543843a4723ed2ab08e18053ae6dc5b	2020-10-23 22:10:54.272292	2020-10-23 22:10:54.272292
2352	1	5	25	2	\N	2017-01-28	-35.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:10:54.273391	2020-10-23 22:10:54.273391
2353	5	1	-1	2	\N	2017-01-28	-28.85	5ede596ddd7b81b559a5c18941be6089	2020-10-23 22:10:54.274523	2020-10-23 22:10:54.274523
2354	5	5	23	2	\N	2017-01-27	-121.49	fe8c15fed5f808006ce95eddb7366e35	2020-10-23 22:10:54.27559	2020-10-23 22:10:54.27559
2355	5	1	-1	2	\N	2017-01-28	-12.00	e7360c0525d1e355aceb1174cb591015	2020-10-23 22:10:54.276849	2020-10-23 22:10:54.276849
2356	5	1	-1	2	\N	2017-01-18	-103.18	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.27827	2020-10-23 22:10:54.27827
2357	5	4	13	2	\N	2017-01-28	-89.00	795b9138e3fa0d382426a0c383711252	2020-10-23 22:10:54.279369	2020-10-23 22:10:54.279369
2358	5	4	13	2	\N	2017-01-28	-344.25	9be40cee5b0eee1462c82c6964087ff9	2020-10-23 22:10:54.280519	2020-10-23 22:10:54.280519
2359	2	7	34	2	\N	2017-01-26	-25.00	30f78cd500afd51e75d8351e4418ed9a	2020-10-23 22:10:54.281581	2020-10-23 22:10:54.281581
2360	2	1	-1	2	\N	2017-01-27	-25.00	13f9896df61279c928f19721878fac41	2020-10-23 22:10:54.28267	2020-10-23 22:10:54.28267
2361	2	3	-1	2	\N	2017-01-27	-21.50	8ea5d22eba2d75b7651304f4dcde8eee	2020-10-23 22:10:54.283826	2020-10-23 22:10:54.283826
2362	5	4	15	2	\N	2017-01-28	-114.48	1f7f31128359ac99188a716d5846f270	2020-10-23 22:10:54.285087	2020-10-23 22:10:54.285087
2363	5	4	-1	2	\N	2017-01-28	-590.00	a9fc33d2fddb7e77a0dbb39921193ac0	2020-10-23 22:10:54.286343	2020-10-23 22:10:54.286343
2364	2	8	40	2	\N	2017-01-28	-4.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.288002	2020-10-23 22:10:54.288002
2365	5	9	48	2	\N	2017-01-28	-72.70	2ba100d60448c3b5fe2dc55a892104f0	2020-10-23 22:10:54.289175	2020-10-23 22:10:54.289175
2366	2	4	18	2	\N	2017-01-28	-58.01	9b6e8be5d32a53f1440f55489474d72b	2020-10-23 22:10:54.290291	2020-10-23 22:10:54.290291
2367	1	1	-1	2	\N	2017-01-29	-14.00	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:54.291325	2020-10-23 22:10:54.291325
2368	1	1	-1	2	\N	2017-01-29	-28.00	9f65a84d84fb42109c54b47384a437d8	2020-10-23 22:10:54.292464	2020-10-23 22:10:54.292464
2369	5	1	-1	2	\N	2017-01-29	-11.70	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:54.293496	2020-10-23 22:10:54.293496
2370	1	3	-1	2	\N	2017-01-28	-15.08	d95131849da9c75adf0d324b63972160	2020-10-23 22:10:54.294616	2020-10-23 22:10:54.294616
2371	1	8	41	2	\N	2017-01-29	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:54.295696	2020-10-23 22:10:54.295696
2372	1	9	-1	2	\N	2017-01-29	-228.97	e820a45f1dfc7b95282d10b6087e11c0	2020-10-23 22:10:54.29675	2020-10-23 22:10:54.29675
2373	1	8	41	2	\N	2017-01-29	-1.28	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:54.297883	2020-10-23 22:10:54.297883
2374	1	7	33	2	\N	2017-01-31	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:54.298965	2020-10-23 22:10:54.298965
2375	1	10	54	3	\N	2017-01-31	-1500.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:10:54.300065	2020-10-23 22:10:54.300065
2376	5	10	54	4	\N	2017-01-31	1500.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:10:54.301228	2020-10-23 22:10:54.301228
2377	5	4	16	2	\N	2017-01-31	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:54.302343	2020-10-23 22:10:54.302343
2378	5	10	54	3	\N	2017-02-01	-1100.00	8546f9c88ab637678947a81775464b17	2020-10-23 22:10:54.303765	2020-10-23 22:10:54.303765
2379	1	2	-1	4	\N	2017-02-01	64.05	991b0847d09377885dd95e7587af813e	2020-10-23 22:10:54.305139	2020-10-23 22:10:54.305139
2380	5	1	-1	2	\N	2017-02-01	-89.42	e206ddbb250a8466a32639f93ce17d0a	2020-10-23 22:10:54.306375	2020-10-23 22:10:54.306375
2381	6	10	55	1	\N	2017-01-31	88.51	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:54.307501	2020-10-23 22:10:54.307501
2382	6	10	-1	4	\N	2017-01-31	42.16	d7624a07bef798689041f094177b379a	2020-10-23 22:10:54.308638	2020-10-23 22:10:54.308638
2383	1	9	-1	3	\N	2017-02-01	-13.80	f5e36d28d44657b98522190197a4eb5f	2020-10-23 22:10:54.309843	2020-10-23 22:10:54.309843
2384	5	2	-1	4	\N	2017-02-01	144.22	f5e36d28d44657b98522190197a4eb5f	2020-10-23 22:10:54.311235	2020-10-23 22:10:54.311235
2385	2	9	-1	2	\N	2017-02-04	-82.00	b91886635e922e85604961f252b9da87	2020-10-23 22:10:54.312376	2020-10-23 22:10:54.312376
2386	5	9	-1	1	\N	2017-02-04	82.00	b91886635e922e85604961f252b9da87	2020-10-23 22:10:54.313507	2020-10-23 22:10:54.313507
2387	2	1	-1	2	\N	2017-02-04	-10.90	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:10:54.314607	2020-10-23 22:10:54.314607
2388	5	2	-1	4	\N	2017-02-03	1100.00	4b04a686b0ad13dce35fa99fa4161c65	2020-10-23 22:10:54.31574	2020-10-23 22:10:54.31574
2389	5	5	21	2	\N	2017-02-04	-82.92	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:10:54.316844	2020-10-23 22:10:54.316844
2390	5	1	-1	2	\N	2017-02-04	-188.28	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:54.317932	2020-10-23 22:10:54.317932
2391	5	1	-1	2	\N	2017-02-04	-16.00	bf458802928616325f5e4ff7591ca4ff	2020-10-23 22:10:54.319075	2020-10-23 22:10:54.319075
2392	1	2	-1	1	\N	2017-02-04	16.00	bf458802928616325f5e4ff7591ca4ff	2020-10-23 22:10:54.32032	2020-10-23 22:10:54.32032
2393	5	1	-1	2	\N	2017-02-02	-8.76	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.321549	2020-10-23 22:10:54.321549
2394	1	3	-1	2	\N	2017-02-03	-23.90	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:10:54.322771	2020-10-23 22:10:54.322771
2395	5	5	23	2	\N	2017-02-03	-6.40	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.323939	2020-10-23 22:10:54.323939
2396	5	5	26	3	\N	2017-02-05	-228.97	68624f538551e4bad25380bf9802648e	2020-10-23 22:10:54.325047	2020-10-23 22:10:54.325047
2397	1	2	-1	4	\N	2017-02-05	228.97	68624f538551e4bad25380bf9802648e	2020-10-23 22:10:54.326164	2020-10-23 22:10:54.326164
2398	1	2	-1	4	\N	2017-02-05	8.76	8f2f665a201e5b76e34c3321bd359740	2020-10-23 22:10:54.327371	2020-10-23 22:10:54.327371
2399	1	4	18	2	\N	2017-02-05	-19.00	32e19ccedc969f0291bce49ca7341a06	2020-10-23 22:10:54.328515	2020-10-23 22:10:54.328515
2400	5	1	-1	2	\N	2017-02-05	-12.08	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.32975	2020-10-23 22:10:54.32975
2401	5	9	48	2	\N	2017-02-06	-31.80	11b921ef080f7736089c757404650e40	2020-10-23 22:10:54.331088	2020-10-23 22:10:54.331088
2402	5	5	23	2	\N	2017-02-06	-31.80	9882d05cb24f7fd0d1cd0dcd1b86a8a1	2020-10-23 22:10:54.332243	2020-10-23 22:10:54.332243
2403	2	9	48	2	\N	2017-02-06	-4.00	62518398bc0f10e6a3198b33d6788f3a	2020-10-23 22:10:54.333402	2020-10-23 22:10:54.333402
2404	2	10	54	2	\N	2017-02-06	-100.00	df20e1cfbc5fab04cc56a56b202974a0	2020-10-23 22:10:54.334507	2020-10-23 22:10:54.334507
2405	5	1	-1	2	\N	2017-02-06	-12.08	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.335639	2020-10-23 22:10:54.335639
2406	5	1	-1	2	\N	2017-02-06	-13.54	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.336974	2020-10-23 22:10:54.336974
2407	1	1	-1	2	\N	2017-02-06	-3.69	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.338091	2020-10-23 22:10:54.338091
2408	2	2	3	1	\N	2017-02-07	1619.16	102a31bba84c93e69dc27d8015863957	2020-10-23 22:10:54.339216	2020-10-23 22:10:54.339216
2409	2	1	-1	2	\N	2017-02-08	-10.00	91063e75da9043813ddc8bda2a134b02	2020-10-23 22:10:54.340313	2020-10-23 22:10:54.340313
2410	1	1	-1	2	\N	2017-02-09	-11.63	e7db56dbec713f0510010c6d997d9ddd	2020-10-23 22:10:54.341421	2020-10-23 22:10:54.341421
2411	5	1	-1	2	\N	2017-02-08	-115.41	b056eb1587586b71e2da9acfe4fbd19e	2020-10-23 22:10:54.342513	2020-10-23 22:10:54.342513
2412	1	9	48	2	\N	2017-02-08	-49.33	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:10:54.34367	2020-10-23 22:10:54.34367
2413	5	9	48	2	\N	2017-02-11	-200.00	fe397f3f6f24b8500bc9c5f356384020	2020-10-23 22:10:54.344965	2020-10-23 22:10:54.344965
2414	5	1	-1	2	\N	2017-02-11	-30.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.346369	2020-10-23 22:10:54.346369
2415	1	1	-1	2	\N	2017-02-11	-10.65	7a61695826ec9e899e35fbb39469cc75	2020-10-23 22:10:54.347578	2020-10-23 22:10:54.347578
2416	1	1	11	2	\N	2017-02-11	-3.99	23ce1851341ec1fa9e0c259de10bf87c	2020-10-23 22:10:54.349062	2020-10-23 22:10:54.349062
2417	1	3	-1	2	\N	2017-02-11	-4.70	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:10:54.350379	2020-10-23 22:10:54.350379
2418	2	3	-1	2	\N	2017-02-11	-30.00	db780008ffa192e7447f125de2ccdbe2	2020-10-23 22:10:54.351848	2020-10-23 22:10:54.351848
2419	5	1	-1	2	\N	2017-02-11	-21.00	b4d83f6860b6ffa13862443f17eb9f72	2020-10-23 22:10:54.353871	2020-10-23 22:10:54.353871
2420	1	1	-1	2	\N	2017-02-14	-10.00	08c5433a60135c32e34f46a71175850c	2020-10-23 22:10:54.355889	2020-10-23 22:10:54.355889
2421	1	9	48	2	\N	2017-02-14	-39.90	898a87d1176aabe8f6afd67c7afb5cb0	2020-10-23 22:10:54.357384	2020-10-23 22:10:54.357384
2422	5	1	-1	2	\N	2017-02-12	-14.15	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.358744	2020-10-23 22:10:54.358744
2423	1	9	48	2	\N	2017-02-14	-9.98	c43897d3a068d877707a1495c590734f	2020-10-23 22:10:54.360293	2020-10-23 22:10:54.360293
2424	5	5	23	2	\N	2017-02-13	-67.49	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:10:54.361494	2020-10-23 22:10:54.361494
2425	1	9	48	2	\N	2017-02-14	-59.90	fdb93d315c7989b47056e2f5d5e28793	2020-10-23 22:10:54.362891	2020-10-23 22:10:54.362891
2426	1	9	48	2	\N	2017-02-14	-20.00	671f8ff3e6c9b665f711c75a801c04b1	2020-10-23 22:10:54.364188	2020-10-23 22:10:54.364188
2427	2	1	-1	2	\N	2017-02-14	-29.78	37bc2f75bf1bcfe8450a1a41c200364c	2020-10-23 22:10:54.365407	2020-10-23 22:10:54.365407
2428	2	5	23	2	\N	2017-02-14	-50.00	1c613d503dec9c1be87ddc813e742607	2020-10-23 22:10:54.366842	2020-10-23 22:10:54.366842
2429	5	5	23	1	\N	2017-02-14	50.00	1c613d503dec9c1be87ddc813e742607	2020-10-23 22:10:54.368412	2020-10-23 22:10:54.368412
2430	2	4	16	2	\N	2017-02-15	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:54.369939	2020-10-23 22:10:54.369939
2431	1	1	-1	2	\N	2017-02-17	-3.16	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:10:54.372125	2020-10-23 22:10:54.372125
2432	1	1	-1	2	\N	2017-02-17	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:10:54.373493	2020-10-23 22:10:54.373493
2433	1	1	-1	2	\N	2017-02-17	-18.84	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.374841	2020-10-23 22:10:54.374841
2434	1	1	-1	2	\N	2017-02-16	-17.51	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.376002	2020-10-23 22:10:54.376002
2435	1	5	23	2	\N	2017-02-16	-18.99	120632446c35682a996c50830ee55882	2020-10-23 22:10:54.377192	2020-10-23 22:10:54.377192
2436	5	5	23	2	\N	2017-02-16	-59.76	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.378432	2020-10-23 22:10:54.378432
2437	1	10	54	4	\N	2017-02-16	8900.00	d37fa31bd432cd22ed69681a7e16cf0e	2020-10-23 22:10:54.379713	2020-10-23 22:10:54.379713
2438	1	10	54	3	\N	2017-02-16	-8500.00	d37fa31bd432cd22ed69681a7e16cf0e	2020-10-23 22:10:54.380981	2020-10-23 22:10:54.380981
2439	5	5	21	2	\N	2017-02-16	-97.75	6f1071cac42b19d40149f58ee960582d	2020-10-23 22:10:54.382295	2020-10-23 22:10:54.382295
2440	2	6	27	2	\N	2017-02-16	-59.90	43ef4393816412456a776afb5477cc24	2020-10-23 22:10:54.383742	2020-10-23 22:10:54.383742
2441	5	1	-1	2	\N	2017-02-18	-87.86	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.385209	2020-10-23 22:10:54.385209
2442	5	1	-1	2	\N	2017-02-18	-42.75	068815e086d67013e8300188e50513e8	2020-10-23 22:10:54.386494	2020-10-23 22:10:54.386494
2443	5	1	-1	2	\N	2017-02-18	-11.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.388573	2020-10-23 22:10:54.388573
2444	5	1	-1	2	\N	2017-02-18	-4.00	004f2da97091f78e4b8b4f669aebc912	2020-10-23 22:10:54.390308	2020-10-23 22:10:54.390308
2445	1	9	48	2	\N	2017-02-08	-20.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:54.391452	2020-10-23 22:10:54.391452
2446	2	9	-1	2	\N	2017-02-08	-10.99	a797343ad6da0b3f1ad01b1930f17bb7	2020-10-23 22:10:54.392516	2020-10-23 22:10:54.392516
2447	5	1	-1	2	\N	2017-02-19	-10.50	df7782cc7d1222cb8c1fb24f33ea040a	2020-10-23 22:10:54.393919	2020-10-23 22:10:54.393919
2448	1	8	43	2	\N	2017-02-19	-51.21	f0e1ddaa127c1344cd2cb93ede3e0eb4	2020-10-23 22:10:54.395443	2020-10-23 22:10:54.395443
2449	1	9	-1	2	\N	2017-02-18	-24.99	d305177996baf37d4c5c301e96a6e760	2020-10-23 22:10:54.397263	2020-10-23 22:10:54.397263
2450	2	4	19	2	\N	2017-02-19	-478.00	26f0dbf80fc20703a88c42214c35d649	2020-10-23 22:10:54.398791	2020-10-23 22:10:54.398791
2451	2	9	48	2	\N	2017-02-22	-10.00	fc698bd6eba4453d16fc4acb4abf4a5a	2020-10-23 22:10:54.400187	2020-10-23 22:10:54.400187
2452	2	1	-1	2	\N	2017-02-22	-17.20	55b37c5c270e5d84c793e486d798c01d	2020-10-23 22:10:54.401499	2020-10-23 22:10:54.401499
2453	1	1	-1	2	\N	2017-02-25	-14.07	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.402897	2020-10-23 22:10:54.402897
2454	1	1	-1	2	\N	2017-02-25	-12.08	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.404712	2020-10-23 22:10:54.404712
2455	1	3	-1	2	\N	2017-02-24	-35.20	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:10:54.405944	2020-10-23 22:10:54.405944
2456	1	1	-1	2	\N	2017-02-25	-10.53	2421fcb1263b9530df88f7f002e78ea5	2020-10-23 22:10:54.407226	2020-10-23 22:10:54.407226
2457	1	1	-1	2	\N	2017-02-25	-263.52	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:10:54.408479	2020-10-23 22:10:54.408479
2458	1	2	3	1	\N	2017-02-24	9825.75	8eb318b235b5e5ad5054608c162b6f8c	2020-10-23 22:10:54.409756	2020-10-23 22:10:54.409756
2459	2	3	-1	2	\N	2017-02-24	-20.00	ee69587bfe3a045c95680b5e02d1524b	2020-10-23 22:10:54.411218	2020-10-23 22:10:54.411218
2460	2	5	25	2	\N	2017-02-25	-40.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:54.412471	2020-10-23 22:10:54.412471
2461	2	5	23	2	\N	2017-02-25	-23.19	06eb61b839a0cefee4967c67ccb099dc	2020-10-23 22:10:54.413775	2020-10-23 22:10:54.413775
2462	2	1	-1	2	\N	2017-02-25	-16.96	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:10:54.415023	2020-10-23 22:10:54.415023
2463	1	10	54	3	\N	2017-02-25	-2355.00	8e9a5e7fd02d9828a1ce35e1cddeb39c	2020-10-23 22:10:54.416237	2020-10-23 22:10:54.416237
2464	6	10	54	4	\N	2017-02-25	2355.00	8e9a5e7fd02d9828a1ce35e1cddeb39c	2020-10-23 22:10:54.417684	2020-10-23 22:10:54.417684
2465	1	10	54	3	\N	2017-02-25	-1500.00	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:10:54.418931	2020-10-23 22:10:54.418931
2466	5	10	54	4	\N	2017-02-25	1500.00	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:10:54.420571	2020-10-23 22:10:54.420571
2467	1	10	54	3	\N	2017-02-25	-1500.00	a8ecbabae151abacba7dbde04f761c37	2020-10-23 22:10:54.422108	2020-10-23 22:10:54.422108
2468	1	10	54	3	\N	2017-02-25	-2200.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:10:54.423425	2020-10-23 22:10:54.423425
2469	1	10	54	3	\N	2017-02-25	-500.00	443cb001c138b2561a0d90720d6ce111	2020-10-23 22:10:54.424891	2020-10-23 22:10:54.424891
2470	1	2	-1	4	\N	2017-02-25	387.91	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:10:54.426291	2020-10-23 22:10:54.426291
2471	5	9	-1	3	\N	2017-02-25	-387.91	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:10:54.427599	2020-10-23 22:10:54.427599
2472	1	10	54	3	\N	2017-02-25	-850.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:10:54.428927	2020-10-23 22:10:54.428927
2473	1	10	54	3	\N	2017-02-25	-1000.00	14b9225c6d469d3feafd23a2fd0d4490	2020-10-23 22:10:54.430351	2020-10-23 22:10:54.430351
2474	2	2	3	1	\N	2017-02-25	6792.81	e134fe3e8dc67b89dcd928aa2a7e7dcf	2020-10-23 22:10:54.431882	2020-10-23 22:10:54.431882
2475	2	10	54	3	\N	2017-02-26	-1500.00	956350bfd1852bdd1112e1dcfbfae9ee	2020-10-23 22:10:54.433111	2020-10-23 22:10:54.433111
2476	5	10	54	4	\N	2017-02-26	1500.00	956350bfd1852bdd1112e1dcfbfae9ee	2020-10-23 22:10:54.434358	2020-10-23 22:10:54.434358
2477	2	10	54	3	\N	2017-02-26	-2500.00	737765366b09ef64c7e90e4ca9b5eabf	2020-10-23 22:10:54.435618	2020-10-23 22:10:54.435618
2478	6	10	54	4	\N	2017-02-26	2500.00	737765366b09ef64c7e90e4ca9b5eabf	2020-10-23 22:10:54.437581	2020-10-23 22:10:54.437581
2479	2	10	54	3	\N	2017-02-26	-3900.00	a64c94baaf368e1840a1324e839230de	2020-10-23 22:10:54.439157	2020-10-23 22:10:54.439157
2480	4	10	54	4	\N	2017-02-26	3900.00	a64c94baaf368e1840a1324e839230de	2020-10-23 22:10:54.440787	2020-10-23 22:10:54.440787
2481	5	4	13	2	\N	2017-02-26	-344.25	99d80f38d6e21b45fc5f865b265a47c0	2020-10-23 22:10:54.44215	2020-10-23 22:10:54.44215
2482	5	4	14	2	\N	2017-02-26	-99.18	751145ad37c5e8dc026d255848d51a27	2020-10-23 22:10:54.444266	2020-10-23 22:10:54.444266
2483	5	4	-1	2	\N	2017-02-26	-590.00	3e16f12ef950c43e633cb9faaaaa49ba	2020-10-23 22:10:54.446102	2020-10-23 22:10:54.446102
2484	5	1	-1	2	\N	2017-02-26	-57.35	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:10:54.447533	2020-10-23 22:10:54.447533
2485	2	1	-1	3	\N	2017-02-26	-57.35	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:10:54.449298	2020-10-23 22:10:54.449298
2486	1	8	41	2	\N	2017-02-27	-28.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:54.450639	2020-10-23 22:10:54.450639
2487	2	4	18	2	\N	2017-02-28	-40.00	060ad92489947d410d897474079c1477	2020-10-23 22:10:54.451947	2020-10-23 22:10:54.451947
2488	2	5	21	2	\N	2017-02-28	-13.29	ff8408738b5820e10c31b1d7843a9285	2020-10-23 22:10:54.45403	2020-10-23 22:10:54.45403
2489	5	4	16	2	\N	2017-03-02	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:54.455912	2020-10-23 22:10:54.455912
2490	2	1	-1	2	\N	2017-03-02	-10.67	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:10:54.457214	2020-10-23 22:10:54.457214
2491	5	2	-1	2	\N	2017-03-02	-46.67	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:10:54.458614	2020-10-23 22:10:54.458614
2492	2	2	-1	1	\N	2017-03-02	46.67	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:10:54.460263	2020-10-23 22:10:54.460263
2493	5	1	-1	2	\N	2017-03-03	-52.20	d926d7bb9ccf46fc04a61bd65d87b9b3	2020-10-23 22:10:54.461668	2020-10-23 22:10:54.461668
2494	1	10	54	4	\N	2017-03-05	1000.00	31668270a64a66188b2c969d57998572	2020-10-23 22:10:54.463281	2020-10-23 22:10:54.463281
2495	1	7	33	2	\N	2017-03-05	-29.99	28cb510090e7e926daa92745a8b02362	2020-10-23 22:10:54.464598	2020-10-23 22:10:54.464598
2496	1	8	41	2	\N	2017-03-05	-46.00	621d261761bcd729bd826439b38a9600	2020-10-23 22:10:54.466137	2020-10-23 22:10:54.466137
2497	1	1	11	2	\N	2017-03-03	-2.00	3a080b2a2f11ddee1a665fb9807eec24	2020-10-23 22:10:54.467444	2020-10-23 22:10:54.467444
2498	5	8	43	2	\N	2017-02-28	-101.51	5ec91aac30eae62f4140325d09b9afd0	2020-10-23 22:10:54.468772	2020-10-23 22:10:54.468772
2499	5	8	43	2	\N	2017-02-27	-27.00	55371441b6d303298feeec6f09990555	2020-10-23 22:10:54.470173	2020-10-23 22:10:54.470173
2500	5	8	43	2	\N	2017-03-04	-11.00	15faa2ce0bb8fbb9ceb57b38bc3abd6c	2020-10-23 22:10:54.47207	2020-10-23 22:10:54.47207
2501	1	8	40	2	\N	2017-03-04	-10.00	df8b15ba30764e3b9ce084c11336603a	2020-10-23 22:10:54.473506	2020-10-23 22:10:54.473506
2502	1	1	-1	2	\N	2017-03-03	-2.80	b9b4abeafdffae758561c5bc344c22c0	2020-10-23 22:10:54.474872	2020-10-23 22:10:54.474872
2503	5	1	-1	2	\N	2017-03-04	-9.89	4f208c522ae36c3e2f0f96291ba4f8a2	2020-10-23 22:10:54.476919	2020-10-23 22:10:54.476919
2504	5	1	-1	2	\N	2017-03-04	-24.99	1b5449c9c2f3481ae6c524c55d3fb9e2	2020-10-23 22:10:54.478912	2020-10-23 22:10:54.478912
2505	1	1	11	2	\N	2017-03-01	-2.19	6b15c1729c4511b1f3625befaabe4c78	2020-10-23 22:10:54.480161	2020-10-23 22:10:54.480161
2506	1	1	-1	2	\N	2017-03-01	-5.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.481438	2020-10-23 22:10:54.481438
2507	5	10	54	4	\N	2017-03-04	1500.00	a1ce56bcfdf6db7c5f1754aa6be841aa	2020-10-23 22:10:54.482832	2020-10-23 22:10:54.482832
2508	5	1	-1	2	\N	2017-03-04	-90.30	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.484156	2020-10-23 22:10:54.484156
2509	1	1	-1	2	\N	2017-02-28	-3.55	0007fa08b864a9bd335a0a3495d61626	2020-10-23 22:10:54.485644	2020-10-23 22:10:54.485644
2510	1	1	-1	2	\N	2017-03-04	-13.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.487184	2020-10-23 22:10:54.487184
2511	1	1	-1	2	\N	2017-03-04	-10.00	8c7bbbba95c1025975e548cee86dfadc	2020-10-23 22:10:54.488883	2020-10-23 22:10:54.488883
2512	5	1	-1	2	\N	2017-03-04	-17.78	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.490195	2020-10-23 22:10:54.490195
2513	1	3	-1	2	\N	2017-03-02	-24.00	3c7a72ab2324009215e56d50d1b99569	2020-10-23 22:10:54.491712	2020-10-23 22:10:54.491712
2514	1	7	32	2	\N	2017-03-03	-56.00	0f243f3be92942b7bc653ac46e835ec2	2020-10-23 22:10:54.49333	2020-10-23 22:10:54.49333
2515	1	8	41	2	\N	2017-03-02	-28.00	979144252f0ff2369e5c0f265e71b53c	2020-10-23 22:10:54.494656	2020-10-23 22:10:54.494656
2516	6	10	55	1	\N	2017-02-28	85.89	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:54.496482	2020-10-23 22:10:54.496482
2517	5	9	-1	2	\N	2017-03-05	-17.55	f90f2aca5c640289d0a29417bcb63a37	2020-10-23 22:10:54.497868	2020-10-23 22:10:54.497868
2518	1	2	-1	1	\N	2017-02-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:10:54.499232	2020-10-23 22:10:54.499232
2519	5	4	-1	2	\N	2017-02-07	-21.00	bf21751ba657f55e1c6f7f56fe5f4149	2020-10-23 22:10:54.500593	2020-10-23 22:10:54.500593
2520	5	9	47	2	\N	2017-02-05	-39.00	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:10:54.502418	2020-10-23 22:10:54.502418
2521	1	1	-1	2	\N	2017-03-06	-15.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:54.503997	2020-10-23 22:10:54.503997
2522	1	9	48	2	\N	2017-03-08	-9.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:54.505345	2020-10-23 22:10:54.505345
2523	5	1	-1	2	\N	2017-03-08	-23.35	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.506834	2020-10-23 22:10:54.506834
2524	2	1	-1	2	\N	2017-03-09	-7.21	ee4acff3c086b6ec26de0ca8c58c8b43	2020-10-23 22:10:54.508347	2020-10-23 22:10:54.508347
2525	2	9	48	2	\N	2017-03-10	-5.00	5ff832d9bca8241d653279756f3ccd11	2020-10-23 22:10:54.509753	2020-10-23 22:10:54.509753
2526	1	1	-1	2	\N	2017-03-12	-10.80	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:10:54.511344	2020-10-23 22:10:54.511344
2527	1	1	-1	2	\N	2017-03-12	-3.79	21a28858754a02c8cf5f86b5b9371ea0	2020-10-23 22:10:54.512874	2020-10-23 22:10:54.512874
2528	1	1	-1	2	\N	2017-03-11	-3.28	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:10:54.514353	2020-10-23 22:10:54.514353
2529	1	1	11	2	\N	2017-03-11	-2.49	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.515871	2020-10-23 22:10:54.515871
2530	5	1	-1	2	\N	2017-03-11	-277.46	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.517227	2020-10-23 22:10:54.517227
2531	1	7	31	2	\N	2017-03-09	-40.00	8c0988bbc8bb3023dc5c926a3a5b789d	2020-10-23 22:10:54.51856	2020-10-23 22:10:54.51856
2532	5	1	-1	2	\N	2017-03-11	-27.32	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.519841	2020-10-23 22:10:54.519841
2533	1	4	18	2	\N	2017-03-12	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:10:54.521271	2020-10-23 22:10:54.521271
2534	2	3	-1	2	\N	2017-03-13	-23.80	c143901dfd95e6cc334954e0d37ee65c	2020-10-23 22:10:54.522566	2020-10-23 22:10:54.522566
2535	5	7	30	2	\N	2017-03-14	-220.25	d8ae32d2fa6274ff84baf7cebc4c30e5	2020-10-23 22:10:54.523959	2020-10-23 22:10:54.523959
2536	2	7	33	2	\N	2017-03-15	-90.00	4c85a292227de470f866fa5c06250ed9	2020-10-23 22:10:54.525274	2020-10-23 22:10:54.525274
2537	2	1	-1	2	\N	2017-03-15	-78.00	a2d5d2b44d2e61ef70e48ef8beda1c5f	2020-10-23 22:10:54.526646	2020-10-23 22:10:54.526646
2538	2	9	47	2	\N	2017-03-17	-100.00	9f06f2538cdbb40bce9973f60506de09	2020-10-23 22:10:54.528195	2020-10-23 22:10:54.528195
2539	5	5	26	2	\N	2017-03-17	-52.91	74b2c41c45b3e51cf6a19655d028c75c	2020-10-23 22:10:54.530179	2020-10-23 22:10:54.530179
2540	2	6	27	2	\N	2017-03-17	-79.90	794604517fda2714467ca22ac153b831	2020-10-23 22:10:54.531442	2020-10-23 22:10:54.531442
2541	2	6	27	2	\N	2017-03-17	-79.90	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:54.532695	2020-10-23 22:10:54.532695
2542	2	7	31	2	\N	2017-03-18	-22.00	d9f61279b8182ce2acbd0d88a5ff8918	2020-10-23 22:10:54.533826	2020-10-23 22:10:54.533826
2543	2	3	-1	2	\N	2017-03-18	-15.00	a64c94baaf368e1840a1324e839230de	2020-10-23 22:10:54.535154	2020-10-23 22:10:54.535154
2544	1	1	-1	2	\N	2017-03-11	-9.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.536505	2020-10-23 22:10:54.536505
2545	5	1	-1	2	\N	2017-03-17	-22.36	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.538288	2020-10-23 22:10:54.538288
2546	1	1	-1	2	\N	2017-03-16	-2.20	d3c8a0832878a5e1d4e873e57b7f4238	2020-10-23 22:10:54.539633	2020-10-23 22:10:54.539633
2547	1	1	-1	2	\N	2017-03-17	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:54.540978	2020-10-23 22:10:54.540978
2548	1	1	-1	2	\N	2017-03-17	-10.83	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.542306	2020-10-23 22:10:54.542306
2549	5	9	48	2	\N	2017-03-13	-12.99	71a3cb155f8dc89bf3d0365288219936	2020-10-23 22:10:54.54405	2020-10-23 22:10:54.54405
2550	5	1	-1	2	\N	2017-03-18	-130.69	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.545315	2020-10-23 22:10:54.545315
2551	5	1	-1	2	\N	2017-03-18	-12.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.547339	2020-10-23 22:10:54.547339
2552	5	1	-1	2	\N	2017-03-18	-3.10	208b2c346f1de235e4ef1e7c3f890fc3	2020-10-23 22:10:54.548642	2020-10-23 22:10:54.548642
2553	1	9	51	2	\N	2017-03-19	-100.00	e2f43259cb63e38b9ed8d2d24af245e9	2020-10-23 22:10:54.549885	2020-10-23 22:10:54.549885
2554	5	5	23	2	\N	2017-03-20	-30.40	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.551125	2020-10-23 22:10:54.551125
2555	2	4	16	2	\N	2017-03-21	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:54.552583	2020-10-23 22:10:54.552583
2556	5	5	26	2	\N	2017-03-23	-104.62	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:10:54.554107	2020-10-23 22:10:54.554107
2557	2	6	27	2	\N	2017-03-23	-45.80	ed74883a0e62f7670f6dd6bf9390ab48	2020-10-23 22:10:54.556345	2020-10-23 22:10:54.556345
2558	5	6	27	2	\N	2017-03-23	-93.42	bea96d9eb39e0397d7abc031ee04121d	2020-10-23 22:10:54.557917	2020-10-23 22:10:54.557917
2559	2	6	27	3	\N	2017-03-23	-57.86	f7ba755c736f384e67833dfd65ecba31	2020-10-23 22:10:54.559285	2020-10-23 22:10:54.559285
2560	5	1	-1	2	\N	2017-03-24	-16.39	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:10:54.560626	2020-10-23 22:10:54.560626
2561	5	6	27	2	\N	2017-03-24	-11.90	b55ec28c52d5f6205684a473a2193564	2020-10-23 22:10:54.561943	2020-10-23 22:10:54.561943
2562	5	1	-1	2	\N	2017-03-25	-2.20	5de8bf0c8ab1d9b8064f1f4600e1d551	2020-10-23 22:10:54.56317	2020-10-23 22:10:54.56317
2563	5	1	-1	2	\N	2017-03-25	-13.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.564561	2020-10-23 22:10:54.564561
2564	5	3	-1	2	\N	2017-03-24	-4.99	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:54.566212	2020-10-23 22:10:54.566212
2565	5	1	-1	2	\N	2017-03-25	-125.06	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.567623	2020-10-23 22:10:54.567623
2566	5	1	11	2	\N	2017-03-24	-5.69	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:10:54.569488	2020-10-23 22:10:54.569488
2567	5	1	-1	2	\N	2017-03-24	-6.64	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:10:54.571459	2020-10-23 22:10:54.571459
2568	5	1	-1	2	\N	2017-03-25	-7.28	173f6138afd9b026372907766f8d3764	2020-10-23 22:10:54.572931	2020-10-23 22:10:54.572931
2569	5	4	16	2	\N	2017-03-28	-49.90	4b5a141538fd8a5e38ef69216841756a	2020-10-23 22:10:54.574299	2020-10-23 22:10:54.574299
2570	2	2	3	1	\N	2017-03-28	5659.74	0353ab4cbed5beae847a7ff6e220b5cf	2020-10-23 22:10:54.57561	2020-10-23 22:10:54.57561
2571	2	4	18	2	\N	2017-03-28	-40.22	7c50afe1d8e6ee4cea552132d50dc461	2020-10-23 22:10:54.57683	2020-10-23 22:10:54.57683
2572	2	1	-1	2	\N	2017-03-28	-59.90	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:10:54.578818	2020-10-23 22:10:54.578818
2573	2	6	27	2	\N	2017-03-28	-128.59	4a24daecaaedbb0ea5ef7b72aaae1a2e	2020-10-23 22:10:54.580182	2020-10-23 22:10:54.580182
2574	5	6	27	1	\N	2017-03-28	128.59	4a24daecaaedbb0ea5ef7b72aaae1a2e	2020-10-23 22:10:54.581496	2020-10-23 22:10:54.581496
2575	2	10	54	3	\N	2017-03-28	-1500.00	769879b4fb85edac3863871265c6a7b8	2020-10-23 22:10:54.582848	2020-10-23 22:10:54.582848
2576	5	10	54	4	\N	2017-03-28	1500.00	769879b4fb85edac3863871265c6a7b8	2020-10-23 22:10:54.584134	2020-10-23 22:10:54.584134
2577	2	10	54	3	\N	2017-03-28	-1500.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:54.585473	2020-10-23 22:10:54.585473
2578	6	10	54	4	\N	2017-03-28	1500.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:54.587253	2020-10-23 22:10:54.587253
2579	2	10	54	3	\N	2017-03-28	-1500.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:54.588682	2020-10-23 22:10:54.588682
2580	4	10	54	4	\N	2017-03-28	1500.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:10:54.590067	2020-10-23 22:10:54.590067
2581	1	8	41	2	\N	2017-03-30	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:54.591327	2020-10-23 22:10:54.591327
2582	1	1	11	2	\N	2017-03-30	-2.00	3a080b2a2f11ddee1a665fb9807eec24	2020-10-23 22:10:54.592596	2020-10-23 22:10:54.592596
2583	1	7	33	2	\N	2017-03-31	-29.99	1673448ee7064c989d02579c534f6b66	2020-10-23 22:10:54.594112	2020-10-23 22:10:54.594112
2584	1	1	-1	2	\N	2017-03-29	-15.00	eefc9e10ebdc4a2333b42b2dbb8f27b6	2020-10-23 22:10:54.595531	2020-10-23 22:10:54.595531
2585	1	7	31	2	\N	2017-03-27	-25.00	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:10:54.596859	2020-10-23 22:10:54.596859
2586	1	1	11	2	\N	2017-03-27	-7.50	4ae8b31072fc84173510878e209b5f7d	2020-10-23 22:10:54.598456	2020-10-23 22:10:54.598456
2587	5	5	23	2	\N	2017-03-31	-19.89	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.599795	2020-10-23 22:10:54.599795
2588	5	1	-1	2	\N	2017-03-31	-41.80	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.60106	2020-10-23 22:10:54.60106
2589	1	1	-1	2	\N	2017-03-26	-12.46	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:54.602306	2020-10-23 22:10:54.602306
2590	5	1	-1	2	\N	2017-03-28	-20.04	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.603725	2020-10-23 22:10:54.603725
2591	5	1	-1	2	\N	2017-03-27	-3.98	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:54.605201	2020-10-23 22:10:54.605201
2592	5	5	23	2	\N	2017-03-28	-95.83	081b16bcd52a14c866fe2ab1ae3c065a	2020-10-23 22:10:54.606546	2020-10-23 22:10:54.606546
2593	1	5	21	2	\N	2017-03-28	-37.26	3f289930a8ec31a12fa27d15b2ad16d2	2020-10-23 22:10:54.607847	2020-10-23 22:10:54.607847
2594	1	1	-1	2	\N	2017-03-29	-15.33	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.609146	2020-10-23 22:10:54.609146
2595	1	2	3	1	\N	2017-03-28	10294.89	dce3947f36f66ed250640f078458fdb8	2020-10-23 22:10:54.610533	2020-10-23 22:10:54.610533
2596	1	1	-1	2	\N	2017-03-24	-15.50	3a0772443a0739141292a5429b952fe6	2020-10-23 22:10:54.612019	2020-10-23 22:10:54.612019
2597	1	10	54	3	\N	2017-03-30	-500.00	1495632bab0a9204698dbfd412e1a31e	2020-10-23 22:10:54.613292	2020-10-23 22:10:54.613292
2598	1	10	54	3	\N	2017-03-30	-1500.00	cf67355a3333e6e143439161adc2d82e	2020-10-23 22:10:54.614693	2020-10-23 22:10:54.614693
2599	6	10	54	4	\N	2017-03-30	1500.00	cf67355a3333e6e143439161adc2d82e	2020-10-23 22:10:54.616423	2020-10-23 22:10:54.616423
2600	1	10	54	3	\N	2017-03-30	-1500.00	31a9ee0d77b989bfe1f50e3d52ac45e7	2020-10-23 22:10:54.618044	2020-10-23 22:10:54.618044
2601	1	10	54	3	\N	2017-03-30	-1100.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:10:54.619394	2020-10-23 22:10:54.619394
2602	1	10	54	3	\N	2017-03-30	-2200.00	23b66dd4d9be6bba639bc882f30f5475	2020-10-23 22:10:54.620824	2020-10-23 22:10:54.620824
2603	5	4	13	2	\N	2017-03-30	-225.07	191d265f565c43a94aee148f925c4811	2020-10-23 22:10:54.622337	2020-10-23 22:10:54.622337
2604	5	4	15	2	\N	2017-03-30	-246.83	b950034705b54888b189ef2a35b5d3b5	2020-10-23 22:10:54.623559	2020-10-23 22:10:54.623559
2605	5	4	-1	2	\N	2017-03-30	-590.00	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:10:54.624985	2020-10-23 22:10:54.624985
2606	1	10	54	3	\N	2017-03-30	-3075.00	df2aa5111f6e4eff7d335824974ba840	2020-10-23 22:10:54.626146	2020-10-23 22:10:54.626146
2607	6	10	54	4	\N	2017-03-30	3075.00	df2aa5111f6e4eff7d335824974ba840	2020-10-23 22:10:54.627445	2020-10-23 22:10:54.627445
2608	2	4	18	2	\N	2017-03-30	-29.00	4ea7bf2a68d7aef22cf427421aaae9e9	2020-10-23 22:10:54.628872	2020-10-23 22:10:54.628872
2609	1	9	-1	2	\N	2017-03-31	-29.00	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:10:54.630332	2020-10-23 22:10:54.630332
2610	1	1	11	2	\N	2017-03-31	-2.00	b4f11e019e5ad481489e0d710a7825ba	2020-10-23 22:10:54.631527	2020-10-23 22:10:54.631527
2611	1	1	11	2	\N	2017-03-31	-5.19	2a4a83ce605eaf2e7f73e1ff973a29c9	2020-10-23 22:10:54.632899	2020-10-23 22:10:54.632899
2612	5	1	-1	2	\N	2017-03-31	-13.96	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.634828	2020-10-23 22:10:54.634828
2613	5	9	49	3	\N	2017-04-02	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:10:54.636555	2020-10-23 22:10:54.636555
2614	6	10	55	4	\N	2017-04-02	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:10:54.638152	2020-10-23 22:10:54.638152
2615	6	10	55	1	\N	2017-03-31	100.50	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:54.639485	2020-10-23 22:10:54.639485
2616	1	1	-1	2	\N	2017-04-01	-2.99	4f4adcbf8c6f66dcfc8a3282ac2bf10a	2020-10-23 22:10:54.640702	2020-10-23 22:10:54.640702
2617	5	1	-1	2	\N	2017-04-01	-230.19	67e103b0761e60683e83c559be18d40c	2020-10-23 22:10:54.642028	2020-10-23 22:10:54.642028
2618	1	1	11	2	\N	2017-04-01	-3.99	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.643099	2020-10-23 22:10:54.643099
2619	5	9	48	2	\N	2017-04-01	-269.97	879fb036880969b30cccd23864ffb047	2020-10-23 22:10:54.644149	2020-10-23 22:10:54.644149
2620	5	1	-1	2	\N	2017-04-01	-17.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.645397	2020-10-23 22:10:54.645397
2621	2	3	-1	2	\N	2017-04-01	-18.00	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:10:54.646898	2020-10-23 22:10:54.646898
2622	2	8	44	2	\N	2017-04-01	-14.00	280d67d8d8d170333dbc2a452728baf4	2020-10-23 22:10:54.648136	2020-10-23 22:10:54.648136
2623	1	8	41	2	\N	2017-04-02	-27.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:54.649331	2020-10-23 22:10:54.649331
2624	1	9	49	2	\N	2017-04-02	-25.41	69e936d7bf29f02c8d4b809619b7596a	2020-10-23 22:10:54.650715	2020-10-23 22:10:54.650715
2625	2	8	41	2	\N	2017-04-01	-11.40	c4258e0f536604c99f79545e930d5a22	2020-10-23 22:10:54.651999	2020-10-23 22:10:54.651999
2626	1	1	-1	2	\N	2017-04-02	-13.00	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:10:54.653376	2020-10-23 22:10:54.653376
2627	1	2	-1	1	\N	2017-04-02	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:10:54.655046	2020-10-23 22:10:54.655046
2628	1	9	-1	2	\N	2017-04-02	-18.03	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:10:54.656328	2020-10-23 22:10:54.656328
2629	5	10	54	1	\N	2017-04-02	34.68	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:10:54.657539	2020-10-23 22:10:54.657539
2630	5	10	54	4	\N	2017-04-03	1500.00	47b3844d7d80486508007293cfb77909	2020-10-23 22:10:54.658837	2020-10-23 22:10:54.658837
2631	1	10	55	1	\N	2017-04-03	59.91	915c00c94072a859394077f49d202b6a	2020-10-23 22:10:54.660226	2020-10-23 22:10:54.660226
2632	1	1	11	2	\N	2017-04-03	-1.49	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.661535	2020-10-23 22:10:54.661535
2633	5	5	26	2	\N	2017-04-03	-4.99	6c574a6668c2aacffb8ef8066dda013c	2020-10-23 22:10:54.662958	2020-10-23 22:10:54.662958
2634	1	1	-1	2	\N	2017-04-04	-1.68	21a28858754a02c8cf5f86b5b9371ea0	2020-10-23 22:10:54.664349	2020-10-23 22:10:54.664349
2635	1	5	23	2	\N	2017-04-04	-23.40	1a64bd65a2a3994ffbf18a0987b6997d	2020-10-23 22:10:54.665778	2020-10-23 22:10:54.665778
2636	1	5	23	2	\N	2017-04-04	-61.99	bba309fac5497bbdf844affc666e894e	2020-10-23 22:10:54.667055	2020-10-23 22:10:54.667055
2637	5	5	25	2	\N	2017-04-04	-20.00	2cb98cf87a1ea7d68097499de4c25d84	2020-10-23 22:10:54.668386	2020-10-23 22:10:54.668386
2638	5	1	-1	2	\N	2017-04-04	-18.23	8ae114df2641b681b4fc51ed989f97b2	2020-10-23 22:10:54.669883	2020-10-23 22:10:54.669883
2639	2	8	41	2	\N	2017-04-05	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:54.671351	2020-10-23 22:10:54.671351
2640	5	9	-1	1	\N	2017-04-05	11.77	d141a38ed86d53812c6b824fb0831700	2020-10-23 22:10:54.672696	2020-10-23 22:10:54.672696
2641	2	8	41	2	\N	2017-04-05	-5.80	ffd52f3c7e12435a724a8f30fddadd9c	2020-10-23 22:10:54.674399	2020-10-23 22:10:54.674399
2642	2	10	55	1	\N	2017-04-05	59.91	839a4b111f06594f5e680091208cbf87	2020-10-23 22:10:54.675833	2020-10-23 22:10:54.675833
2643	5	8	43	2	\N	2017-04-05	-112.00	3afa03758825774293e45362314f5592	2020-10-23 22:10:54.677163	2020-10-23 22:10:54.677163
2644	5	1	-1	2	\N	2017-04-05	-126.00	af032fbcb07ffc7bd2569d86ae4ce1f5	2020-10-23 22:10:54.678546	2020-10-23 22:10:54.678546
2645	5	8	43	2	\N	2017-04-05	-69.00	37bc1b6433166494d611199664a8b3e1	2020-10-23 22:10:54.680054	2020-10-23 22:10:54.680054
2646	5	8	43	2	\N	2017-04-05	-442.00	552acd90c96884c05a0adba32fc66340	2020-10-23 22:10:54.682384	2020-10-23 22:10:54.682384
2647	1	1	-1	2	\N	2017-04-06	-5.65	120632446c35682a996c50830ee55882	2020-10-23 22:10:54.683818	2020-10-23 22:10:54.683818
2648	1	3	-1	2	\N	2017-04-06	-168.00	599f127bd63e32d6fd5457f9f1fa1e14	2020-10-23 22:10:54.685202	2020-10-23 22:10:54.685202
2649	1	1	-1	2	\N	2017-04-07	-13.88	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.686501	2020-10-23 22:10:54.686501
2650	5	1	-1	2	\N	2017-04-07	-14.32	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.688237	2020-10-23 22:10:54.688237
2651	5	1	-1	2	\N	2017-04-08	-27.97	6fa7fdc9fe6ceda9c0b11be6df042c45	2020-10-23 22:10:54.68965	2020-10-23 22:10:54.68965
2652	5	1	-1	2	\N	2017-04-08	-120.44	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.691109	2020-10-23 22:10:54.691109
2653	1	9	48	2	\N	2017-04-08	-8.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:54.692465	2020-10-23 22:10:54.692465
2654	2	3	-1	2	\N	2017-04-09	-34.50	8d231d47e5d2546508bc630640f7d27c	2020-10-23 22:10:54.693799	2020-10-23 22:10:54.693799
2655	1	1	-1	2	\N	2017-04-08	-24.80	8fe0093bb30d6f8c31474bd0764e6ac0	2020-10-23 22:10:54.695003	2020-10-23 22:10:54.695003
2656	1	1	11	2	\N	2017-04-08	-21.97	6421d6f2b699564d0160c4b6708fab18	2020-10-23 22:10:54.696211	2020-10-23 22:10:54.696211
2657	1	10	54	4	\N	2017-04-09	2500.00	49e8f76092d28e8eebf0398b0268e2ba	2020-10-23 22:10:54.697693	2020-10-23 22:10:54.697693
2658	1	1	-1	2	\N	2017-04-09	-80.00	52b7bee83b5f424d63ef78f36db3eaf2	2020-10-23 22:10:54.698932	2020-10-23 22:10:54.698932
2659	5	1	-1	2	\N	2017-04-09	-12.23	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.700421	2020-10-23 22:10:54.700421
2660	1	4	19	2	\N	2017-04-09	-601.00	53f1ce1310367adfe34e70e39c454d88	2020-10-23 22:10:54.701833	2020-10-23 22:10:54.701833
2661	5	7	30	2	\N	2017-04-10	-705.46	6d0f846348a856321729a2f36734d1a7	2020-10-23 22:10:54.703228	2020-10-23 22:10:54.703228
2662	2	6	27	1	\N	2017-04-10	65.70	c9ceacdf41060f6acff522f9c338ba77	2020-10-23 22:10:54.704836	2020-10-23 22:10:54.704836
2663	1	7	36	2	\N	2017-04-11	-68.80	bd65a930f9c18ff534d9a2676850496d	2020-10-23 22:10:54.706237	2020-10-23 22:10:54.706237
2664	5	8	43	2	\N	2017-04-11	-17.90	677e09724f0e2df9b6c000b75b5da10d	2020-10-23 22:10:54.707663	2020-10-23 22:10:54.707663
2665	5	7	36	2	\N	2017-04-11	-7.99	5e3002b1b5b6ce9e1ba962e4cde4b2de	2020-10-23 22:10:54.708982	2020-10-23 22:10:54.708982
2666	1	2	-1	4	\N	2017-04-11	43.00	b56a18e0eacdf51aa2a5306b0f533204	2020-10-23 22:10:54.710289	2020-10-23 22:10:54.710289
2667	5	1	-1	3	\N	2017-04-11	-43.00	52b7bee83b5f424d63ef78f36db3eaf2	2020-10-23 22:10:54.71153	2020-10-23 22:10:54.71153
2668	5	2	-1	1	\N	2017-04-12	8.00	d4fba90f641f82e5063b8d2587f123dc	2020-10-23 22:10:54.712923	2020-10-23 22:10:54.712923
2669	1	2	-1	1	\N	2017-04-12	21.00	d4fba90f641f82e5063b8d2587f123dc	2020-10-23 22:10:54.714373	2020-10-23 22:10:54.714373
2670	1	1	-1	2	\N	2017-04-13	-2.00	ad71b715717f7e4757565373c1a88e1f	2020-10-23 22:10:54.715858	2020-10-23 22:10:54.715858
2671	1	1	-1	2	\N	2017-04-13	-3.15	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.717091	2020-10-23 22:10:54.717091
2672	1	1	-1	2	\N	2017-04-12	-13.98	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.718465	2020-10-23 22:10:54.718465
2673	5	1	-1	2	\N	2017-04-12	-11.45	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.719643	2020-10-23 22:10:54.719643
2674	6	10	54	3	\N	2017-04-13	-3250.00	4911e516e5aa21d327512e0c8b197616	2020-10-23 22:10:54.721087	2020-10-23 22:10:54.721087
2675	5	10	54	4	\N	2017-04-13	3250.00	4911e516e5aa21d327512e0c8b197616	2020-10-23 22:10:54.722512	2020-10-23 22:10:54.722512
2676	2	4	16	2	\N	2017-04-13	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:10:54.723892	2020-10-23 22:10:54.723892
2677	5	1	-1	2	\N	2017-04-14	-10.86	0e51011a4c4891e5c01c12d85c4dcaa7	2020-10-23 22:10:54.725284	2020-10-23 22:10:54.725284
2678	5	8	43	2	\N	2017-04-14	-172.26	84a66e687796223b14cd2a5564fe3322	2020-10-23 22:10:54.726553	2020-10-23 22:10:54.726553
2679	1	1	-1	2	\N	2017-04-19	-11.14	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.728005	2020-10-23 22:10:54.728005
2680	1	1	11	2	\N	2017-04-19	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.729381	2020-10-23 22:10:54.729381
2681	1	1	-1	2	\N	2017-04-19	-2.07	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.730972	2020-10-23 22:10:54.730972
2682	5	8	43	2	\N	2017-04-17	-124.71	0aa1883c6411f7873cb83dacb17b0afc	2020-10-23 22:10:54.732256	2020-10-23 22:10:54.732256
2683	1	5	21	2	\N	2017-04-19	-12.99	2d709130f7e61ad0622f575e922d393b	2020-10-23 22:10:54.733455	2020-10-23 22:10:54.733455
2684	5	8	43	2	\N	2017-04-19	-887.73	4ae8b31072fc84173510878e209b5f7d	2020-10-23 22:10:54.734602	2020-10-23 22:10:54.734602
2685	1	1	-1	2	\N	2017-04-19	-2.55	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.735692	2020-10-23 22:10:54.735692
2686	1	6	27	2	\N	2017-04-19	-279.99	ba55ff88bddf71220a86105441fd2fff	2020-10-23 22:10:54.737095	2020-10-23 22:10:54.737095
2687	1	9	48	2	\N	2017-04-19	-69.00	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:10:54.738481	2020-10-23 22:10:54.738481
2688	1	9	51	2	\N	2017-04-19	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:10:54.739865	2020-10-23 22:10:54.739865
2689	1	1	-1	2	\N	2017-04-20	-4.00	0efe32849d230d7f53049ddc4a4b0c60	2020-10-23 22:10:54.741221	2020-10-23 22:10:54.741221
2690	1	8	44	2	\N	2017-04-21	-14.85	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:54.742482	2020-10-23 22:10:54.742482
2691	1	1	-1	2	\N	2017-04-20	-10.27	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:54.743895	2020-10-23 22:10:54.743895
2692	1	5	21	2	\N	2017-04-20	-12.99	9461cce28ebe3e76fb4b931c35a169b0	2020-10-23 22:10:54.745231	2020-10-23 22:10:54.745231
2693	1	5	25	2	\N	2017-04-22	-40.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:10:54.746342	2020-10-23 22:10:54.746342
2694	5	1	-1	2	\N	2017-04-22	-114.68	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.747746	2020-10-23 22:10:54.747746
2695	5	1	-1	2	\N	2017-04-22	-15.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.749251	2020-10-23 22:10:54.749251
2696	5	1	-1	2	\N	2017-04-22	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:54.750651	2020-10-23 22:10:54.750651
2697	5	8	43	2	\N	2017-04-22	-1057.91	393f11e67a7d89ccfee8c8e5169fc790	2020-10-23 22:10:54.752216	2020-10-23 22:10:54.752216
2698	1	6	27	2	\N	2017-04-23	-159.80	593c7889f7851a0a3b6415211f74e78c	2020-10-23 22:10:54.753595	2020-10-23 22:10:54.753595
2699	5	5	23	2	\N	2017-04-23	-63.97	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.755203	2020-10-23 22:10:54.755203
2700	2	10	54	3	\N	2017-04-24	-10450.00	5fe8a1fd7ab33a21e76fb8429d31b0e7	2020-10-23 22:10:54.756577	2020-10-23 22:10:54.756577
2701	4	10	54	4	\N	2017-04-24	10450.00	5fe8a1fd7ab33a21e76fb8429d31b0e7	2020-10-23 22:10:54.758202	2020-10-23 22:10:54.758202
2702	5	8	42	2	\N	2017-04-24	-44.10	39ac7c174aa1388a75e1f69b07a52881	2020-10-23 22:10:54.759403	2020-10-23 22:10:54.759403
2703	5	5	23	2	\N	2017-04-24	-50.16	a9e5f1f3465c0d01949c66ce74733d70	2020-10-23 22:10:54.760568	2020-10-23 22:10:54.760568
2704	2	4	16	1	\N	2017-04-24	100.00	e69f8884b7194f038d5a746795cf544b	2020-10-23 22:10:54.761894	2020-10-23 22:10:54.761894
2705	1	1	-1	2	\N	2017-04-24	-51.00	5e3159c417bc8b8486ca3c96b91fdb33	2020-10-23 22:10:54.763215	2020-10-23 22:10:54.763215
2706	5	1	-1	2	\N	2017-04-24	-53.00	dc6a70712a252123c40d2adba6a11d84	2020-10-23 22:10:54.764653	2020-10-23 22:10:54.764653
2707	2	9	48	2	\N	2017-04-25	-10.00	efbd6ef165207baae1f083830046770d	2020-10-23 22:10:54.765927	2020-10-23 22:10:54.765927
2708	2	1	-1	2	\N	2017-04-25	-2.74	90794e3b050f815354e3e29e977a88ab	2020-10-23 22:10:54.767329	2020-10-23 22:10:54.767329
2709	5	5	23	2	\N	2017-04-25	-8.04	52720e003547c70561bf5e03b95aa99f	2020-10-23 22:10:54.768822	2020-10-23 22:10:54.768822
2710	1	1	-1	2	\N	2017-04-27	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:10:54.770647	2020-10-23 22:10:54.770647
2711	1	1	-1	2	\N	2017-04-25	-2.20	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:54.772029	2020-10-23 22:10:54.772029
2712	5	1	-1	2	\N	2017-04-28	-7.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.773225	2020-10-23 22:10:54.773225
2713	1	1	-1	2	\N	2017-04-26	-36.00	30205d8ecb1b1a72880924ef11b0e7d0	2020-10-23 22:10:54.774558	2020-10-23 22:10:54.774558
2714	1	1	-1	2	\N	2017-04-26	-35.48	27377792dd0e58af31b18d08d1aac17e	2020-10-23 22:10:54.775814	2020-10-23 22:10:54.775814
2715	1	2	3	1	\N	2017-04-26	12423.45	c3992e9a68c5ae12bd18488bc579b30d	2020-10-23 22:10:54.777208	2020-10-23 22:10:54.777208
2716	1	10	54	3	\N	2017-04-28	-6300.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:54.778488	2020-10-23 22:10:54.778488
2717	1	10	54	3	\N	2017-04-28	-1500.00	cb936c3a480f946447f01f4d77d4d633	2020-10-23 22:10:54.779786	2020-10-23 22:10:54.779786
2718	1	10	54	3	\N	2017-04-28	-2700.00	cad1e737769f50c552f6085c23ade09a	2020-10-23 22:10:54.781421	2020-10-23 22:10:54.781421
2719	1	10	54	3	\N	2017-04-28	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:10:54.783028	2020-10-23 22:10:54.783028
2720	1	10	54	3	\N	2017-04-28	-2200.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:10:54.784369	2020-10-23 22:10:54.784369
2721	6	10	54	4	\N	2017-04-28	6300.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:54.785634	2020-10-23 22:10:54.785634
2722	2	7	37	2	\N	2017-04-28	-25.00	48b062032bae7a6b904b67ea3affba1c	2020-10-23 22:10:54.787114	2020-10-23 22:10:54.787114
2723	2	3	-1	2	\N	2017-04-28	-24.00	e14518b71fb3306fef04fcf950cae886	2020-10-23 22:10:54.788556	2020-10-23 22:10:54.788556
2724	2	1	-1	2	\N	2017-04-28	-7.00	49d95500d38a6743acd0005164c10769	2020-10-23 22:10:54.790014	2020-10-23 22:10:54.790014
2725	2	8	41	2	\N	2017-04-28	-2.80	c2b0073a68dc528568b799b3dd052bd8	2020-10-23 22:10:54.791308	2020-10-23 22:10:54.791308
2726	5	1	-1	2	\N	2017-04-29	-258.29	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:10:54.792664	2020-10-23 22:10:54.792664
2727	5	5	23	2	\N	2017-04-29	-33.49	ea7e2a2801b7eaa1b1e92aa132c6fc39	2020-10-23 22:10:54.794116	2020-10-23 22:10:54.794116
2728	2	1	-1	2	\N	2017-04-28	-31.00	a0f6d0244be79da7040362bf43e9af46	2020-10-23 22:10:54.795376	2020-10-23 22:10:54.795376
2729	2	9	48	2	\N	2017-04-28	-16.00	13e1ad0d81448c812a189ed10681c98f	2020-10-23 22:10:54.796633	2020-10-23 22:10:54.796633
2730	2	9	48	2	\N	2017-04-28	-20.17	a780a63fb8d67bf5d1b7e62c10ec6488	2020-10-23 22:10:54.798343	2020-10-23 22:10:54.798343
2731	2	8	44	2	\N	2017-04-28	-6.00	648ea973c3ba48397fcd70b55711c516	2020-10-23 22:10:54.79973	2020-10-23 22:10:54.79973
2732	2	1	-1	2	\N	2017-04-28	-5.00	2fd66275288599b508bdcaeb5ee16790	2020-10-23 22:10:54.801146	2020-10-23 22:10:54.801146
2733	5	1	-1	2	\N	2017-04-29	-5.69	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:10:54.802725	2020-10-23 22:10:54.802725
2734	5	9	48	2	\N	2017-04-29	-65.80	8b95858ec38e3f105457f69fdca2eeaf	2020-10-23 22:10:54.804747	2020-10-23 22:10:54.804747
2735	2	6	27	2	\N	2017-04-29	-89.97	348aabcfdf0004c41e3e199c5bae43e3	2020-10-23 22:10:54.806475	2020-10-23 22:10:54.806475
2736	2	2	3	1	\N	2017-04-26	5720.58	5c7d5705ab73466c0584cc782cb12d2e	2020-10-23 22:10:54.807878	2020-10-23 22:10:54.807878
2737	2	10	54	3	\N	2017-04-29	-1500.00	952d723fab28e9efa0d1f6e46e033358	2020-10-23 22:10:54.809671	2020-10-23 22:10:54.809671
2738	5	10	54	4	\N	2017-04-29	1500.00	952d723fab28e9efa0d1f6e46e033358	2020-10-23 22:10:54.811146	2020-10-23 22:10:54.811146
2739	2	10	54	3	\N	2017-04-29	-2600.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:10:54.812461	2020-10-23 22:10:54.812461
2740	6	10	54	4	\N	2017-04-29	2600.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:10:54.813768	2020-10-23 22:10:54.813768
2741	2	10	54	3	\N	2017-04-29	-1000.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:10:54.814953	2020-10-23 22:10:54.814953
2742	4	10	54	4	\N	2017-04-29	1000.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:10:54.816131	2020-10-23 22:10:54.816131
2743	5	4	15	2	\N	2017-04-29	-117.59	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:10:54.817364	2020-10-23 22:10:54.817364
2744	5	4	13	2	\N	2017-04-29	-567.45	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:10:54.818737	2020-10-23 22:10:54.818737
2745	5	4	14	2	\N	2017-04-29	-94.49	cf34362ab126ce8338d8991cc1404980	2020-10-23 22:10:54.82064	2020-10-23 22:10:54.82064
2746	5	4	-1	2	\N	2017-04-29	-590.00	08c5433a60135c32e34f46a71175850c	2020-10-23 22:10:54.822391	2020-10-23 22:10:54.822391
2747	5	4	16	2	\N	2017-04-29	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:54.824131	2020-10-23 22:10:54.824131
2748	2	4	18	2	\N	2017-04-29	-44.81	5a842f2dd9f9bef91c20e51a20806e80	2020-10-23 22:10:54.825497	2020-10-23 22:10:54.825497
2749	2	2	-1	1	\N	2017-04-29	246.92	82cec96096d4281b7c95cd7e74623496	2020-10-23 22:10:54.826691	2020-10-23 22:10:54.826691
2750	5	1	-1	2	\N	2017-04-29	-10.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.828256	2020-10-23 22:10:54.828256
2751	5	1	-1	2	\N	2017-04-29	-107.34	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:10:54.829643	2020-10-23 22:10:54.829643
2752	1	7	36	2	\N	2017-04-28	-30.32	d516b13671a4179d9b7b458a6ebdeb92	2020-10-23 22:10:54.83095	2020-10-23 22:10:54.83095
2753	5	5	23	2	\N	2017-04-28	-17.90	a4a042cf4fd6bfb47701cbc8a1653ada	2020-10-23 22:10:54.832234	2020-10-23 22:10:54.832234
2754	5	5	23	2	\N	2017-04-28	-25.49	2dd027223e5c8ae96e0859277d824168	2020-10-23 22:10:54.833464	2020-10-23 22:10:54.833464
2755	1	5	21	2	\N	2017-04-28	-45.97	3f289930a8ec31a12fa27d15b2ad16d2	2020-10-23 22:10:54.835199	2020-10-23 22:10:54.835199
2756	1	1	-1	2	\N	2017-04-28	-2.20	acc3e0404646c57502b480dc052c4fe1	2020-10-23 22:10:54.836319	2020-10-23 22:10:54.836319
2757	1	7	33	2	\N	2017-04-30	-14.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:54.837618	2020-10-23 22:10:54.837618
2758	5	7	33	2	\N	2017-04-30	-15.00	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:54.838826	2020-10-23 22:10:54.838826
2759	6	10	55	1	\N	2017-04-30	102.39	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:54.840144	2020-10-23 22:10:54.840144
2760	1	2	3	1	\N	2017-05-01	23.28	00ec53c4682d36f5c4359f4ae7bd7ba1	2020-10-23 22:10:54.841219	2020-10-23 22:10:54.841219
2761	5	9	-1	2	\N	2017-05-01	-11.77	00ec53c4682d36f5c4359f4ae7bd7ba1	2020-10-23 22:10:54.84245	2020-10-23 22:10:54.84245
2762	5	10	54	4	\N	2017-05-02	1500.00	766ebcd59621e305170616ba3d3dac32	2020-10-23 22:10:54.843606	2020-10-23 22:10:54.843606
2763	5	3	-1	2	\N	2017-05-01	-35.96	9c838d2e45b2ad1094d42f4ef36764f6	2020-10-23 22:10:54.845004	2020-10-23 22:10:54.845004
2764	1	1	-1	2	\N	2017-05-01	-10.00	c8c41c4a18675a74e01c8a20e8a0f662	2020-10-23 22:10:54.84629	2020-10-23 22:10:54.84629
2765	5	1	-1	2	\N	2017-05-01	-24.60	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.847371	2020-10-23 22:10:54.847371
2766	2	6	27	2	\N	2017-05-02	-116.76	a0ebee5d753c05cd46374203d6f1ff52	2020-10-23 22:10:54.848738	2020-10-23 22:10:54.848738
2767	2	6	27	2	\N	2017-05-02	-67.42	48b062032bae7a6b904b67ea3affba1c	2020-10-23 22:10:54.850082	2020-10-23 22:10:54.850082
2768	2	6	27	2	\N	2017-05-02	-101.22	fc09eda86e2c445f0c6e6036c660640b	2020-10-23 22:10:54.85122	2020-10-23 22:10:54.85122
2769	5	7	30	2	\N	2017-05-03	-240.00	5d5e80f0197cffc38cb703731b11a30c	2020-10-23 22:10:54.85244	2020-10-23 22:10:54.85244
2770	1	8	41	2	\N	2017-05-03	-46.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:54.853489	2020-10-23 22:10:54.853489
2771	5	1	-1	2	\N	2017-05-02	-6.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.854912	2020-10-23 22:10:54.854912
2772	5	1	-1	2	\N	2017-05-02	-16.48	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.856073	2020-10-23 22:10:54.856073
2773	5	1	-1	2	\N	2017-05-02	-18.26	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.857593	2020-10-23 22:10:54.857593
2774	1	1	-1	2	\N	2017-05-03	-5.47	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:54.858778	2020-10-23 22:10:54.858778
2775	5	1	-1	2	\N	2017-05-04	-10.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.859985	2020-10-23 22:10:54.859985
2776	1	9	48	2	\N	2017-05-04	-20.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:54.861102	2020-10-23 22:10:54.861102
2777	1	9	-1	2	\N	2017-05-05	-25.00	aa86045b793fd7fe8baa40e6a6a2dbb6	2020-10-23 22:10:54.862546	2020-10-23 22:10:54.862546
2778	5	1	-1	2	\N	2017-05-05	-94.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:54.864037	2020-10-23 22:10:54.864037
2779	1	1	-1	2	\N	2017-05-05	-6.08	298f95e1bf9136124592c8d4825a06fc	2020-10-23 22:10:54.865152	2020-10-23 22:10:54.865152
2780	5	1	-1	2	\N	2017-05-07	-7.76	98894c6d5b1a2ba59f7ec32cadad286c	2020-10-23 22:10:54.866508	2020-10-23 22:10:54.866508
2781	2	1	-1	2	\N	2017-05-07	-16.50	b534ba68236ba543ae44b22bd110a1d6	2020-10-23 22:10:54.868128	2020-10-23 22:10:54.868128
2782	2	1	-1	2	\N	2017-05-06	-6.90	682670d9ab0aaa4dc01895a59aa8f91b	2020-10-23 22:10:54.869352	2020-10-23 22:10:54.869352
2783	5	5	26	2	\N	2017-05-06	-58.09	fbe7c4d9864143adc1b2e15e939fff43	2020-10-23 22:10:54.870983	2020-10-23 22:10:54.870983
2784	2	7	36	2	\N	2017-05-06	-10.00	c3f0e8cb7de97a908771f372ce3cdadd	2020-10-23 22:10:54.872704	2020-10-23 22:10:54.872704
2785	2	8	41	2	\N	2017-05-07	-2.80	15d4e891d784977cacbfcbb00c48f133	2020-10-23 22:10:54.874114	2020-10-23 22:10:54.874114
2786	5	4	-1	2	\N	2017-05-08	-98.00	4740a40d683c35180c179cb652706b45	2020-10-23 22:10:54.875342	2020-10-23 22:10:54.875342
2787	2	6	27	2	\N	2017-05-08	-15.00	02e62b4fa2e3445a3c0cceb274e801aa	2020-10-23 22:10:54.876779	2020-10-23 22:10:54.876779
2788	5	5	23	2	\N	2017-05-08	-25.89	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:10:54.878206	2020-10-23 22:10:54.878206
2789	1	9	49	2	\N	2017-05-08	-29.99	4062fdd0a447a552e142398c4a94241b	2020-10-23 22:10:54.879276	2020-10-23 22:10:54.879276
2790	1	1	-1	2	\N	2017-05-07	-65.00	330770104891acbdcbeb059eabf162d5	2020-10-23 22:10:54.880598	2020-10-23 22:10:54.880598
2791	1	9	48	2	\N	2017-05-08	-115.00	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:10:54.88181	2020-10-23 22:10:54.88181
2792	5	9	48	2	\N	2017-05-08	-100.00	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:10:54.883154	2020-10-23 22:10:54.883154
2793	1	9	49	2	\N	2017-05-06	-119.00	d5067c4b4f3c7a93746a2574bca0bfdb	2020-10-23 22:10:54.884494	2020-10-23 22:10:54.884494
2794	5	1	-1	2	\N	2017-05-07	-13.19	bf458802928616325f5e4ff7591ca4ff	2020-10-23 22:10:54.885673	2020-10-23 22:10:54.885673
2795	5	5	23	2	\N	2017-05-06	-14.99	70babaa65d2a6591316e8a89406a909f	2020-10-23 22:10:54.887273	2020-10-23 22:10:54.887273
2796	5	5	23	2	\N	2017-05-09	-34.89	b1e0f99cad711d6fb36c9109e817065b	2020-10-23 22:10:54.888913	2020-10-23 22:10:54.888913
2797	5	7	30	2	\N	2017-05-09	-300.00	6a64033582463ce72c66dc13d534b163	2020-10-23 22:10:54.890481	2020-10-23 22:10:54.890481
2798	1	10	54	4	\N	2017-05-12	12000.00	c29e661156ee6cdb9ff7e305d898e589	2020-10-23 22:10:54.891724	2020-10-23 22:10:54.891724
2799	1	1	-1	2	\N	2017-05-13	-19.90	b706835de79a2b4e80506f582af3676a	2020-10-23 22:10:54.893186	2020-10-23 22:10:54.893186
2800	1	1	11	2	\N	2017-05-12	-4.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:10:54.894273	2020-10-23 22:10:54.894273
2801	1	1	-1	2	\N	2017-05-12	-11.44	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.896021	2020-10-23 22:10:54.896021
2802	1	1	-1	2	\N	2017-05-11	-12.90	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:54.897155	2020-10-23 22:10:54.897155
2803	1	4	18	2	\N	2017-05-12	-29.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:10:54.899075	2020-10-23 22:10:54.899075
2804	1	4	18	2	\N	2017-05-14	-29.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:10:54.90031	2020-10-23 22:10:54.90031
2805	1	8	41	2	\N	2017-05-14	-23.33	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:54.901419	2020-10-23 22:10:54.901419
2806	5	1	-1	2	\N	2017-05-10	-10.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.903039	2020-10-23 22:10:54.903039
2807	1	8	41	2	\N	2017-05-11	-2.80	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:54.904729	2020-10-23 22:10:54.904729
2808	1	1	-1	2	\N	2017-05-10	-14.50	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:54.906274	2020-10-23 22:10:54.906274
2809	5	1	-1	2	\N	2017-05-10	-16.78	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:54.907756	2020-10-23 22:10:54.907756
2810	5	5	23	2	\N	2017-05-10	-103.90	1e4ca0db331b0919fbb70c96514764f5	2020-10-23 22:10:54.909325	2020-10-23 22:10:54.909325
2811	5	1	-1	2	\N	2017-05-12	-75.56	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:54.910687	2020-10-23 22:10:54.910687
2812	5	1	-1	2	\N	2017-05-13	-10.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:54.91202	2020-10-23 22:10:54.91202
2813	2	6	27	1	\N	2017-05-16	116.76	6045083e3a6452f9be2e1966d5851dff	2020-10-23 22:10:54.913199	2020-10-23 22:10:54.913199
2814	2	8	41	2	\N	2017-05-15	-2.80	746f5a6144cf56559a2479837925c07e	2020-10-23 22:10:54.91447	2020-10-23 22:10:54.91447
2815	5	8	43	2	\N	2017-05-16	-101.11	da86afcc58037b32c437365de9fd9566	2020-10-23 22:10:54.916286	2020-10-23 22:10:54.916286
2816	2	1	-1	2	\N	2017-05-15	-5.00	db5e3ca8f31baa572cb64be6e74d0dba	2020-10-23 22:10:54.917649	2020-10-23 22:10:54.917649
2817	2	9	48	2	\N	2017-05-16	-5.00	4a5a40872023e565257ef33296261f15	2020-10-23 22:10:54.9404	2020-10-23 22:10:54.9404
2818	2	1	-1	2	\N	2017-05-14	-13.30	43289cd437c0341064d1d20424e7bf84	2020-10-23 22:10:54.942452	2020-10-23 22:10:54.942452
2819	2	1	-1	2	\N	2017-05-15	-17.93	fdb93d315c7989b47056e2f5d5e28793	2020-10-23 22:10:54.94394	2020-10-23 22:10:54.94394
2820	5	1	-1	2	\N	2017-05-14	-8.65	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:54.94541	2020-10-23 22:10:54.94541
2821	5	1	-1	2	\N	2017-05-14	-13.50	b3fbb9b47283b0ca35c0a1b25a161a30	2020-10-23 22:10:54.947125	2020-10-23 22:10:54.947125
2822	2	7	30	1	\N	2017-05-15	352.73	56808686a033759e95d2b6fc81f26e77	2020-10-23 22:10:54.94863	2020-10-23 22:10:54.94863
2823	5	7	38	2	\N	2017-05-17	-39.00	b8492ebc3602aaa39adffb5f84e6e48d	2020-10-23 22:10:54.950395	2020-10-23 22:10:54.950395
2824	2	1	-1	2	\N	2017-05-17	-3.70	dd724f3d232d14257dd01b8ee0b4c2c7	2020-10-23 22:10:54.951588	2020-10-23 22:10:54.951588
2825	2	8	41	2	\N	2017-05-18	-18.00	ace36274b07800437f25027557064bbd	2020-10-23 22:10:54.953008	2020-10-23 22:10:54.953008
2826	2	1	-1	2	\N	2017-05-19	-19.85	a5d3078bee99fd4dcf791414fbca1a4f	2020-10-23 22:10:54.954454	2020-10-23 22:10:54.954454
2827	2	1	-1	2	\N	2017-05-19	-6.85	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:54.955739	2020-10-23 22:10:54.955739
2828	2	1	-1	2	\N	2017-05-19	-13.60	b3fbb9b47283b0ca35c0a1b25a161a30	2020-10-23 22:10:54.957069	2020-10-23 22:10:54.957069
2829	2	8	41	2	\N	2017-05-19	-50.00	e820f3a30380e5c6e584268c302d35fa	2020-10-23 22:10:54.958239	2020-10-23 22:10:54.958239
2830	2	4	16	2	\N	2017-05-19	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:10:54.959553	2020-10-23 22:10:54.959553
2831	2	9	48	1	\N	2017-05-20	100.00	9972fa89a49bd697185da4788172a1a8	2020-10-23 22:10:54.96091	2020-10-23 22:10:54.96091
2832	2	8	41	2	\N	2017-05-20	-8.40	8c6744c9d42ec2cb9e8885b54ff744d0	2020-10-23 22:10:54.962332	2020-10-23 22:10:54.962332
2833	2	1	-1	2	\N	2017-05-20	-14.00	5ede596ddd7b81b559a5c18941be6089	2020-10-23 22:10:54.963643	2020-10-23 22:10:54.963643
2834	2	1	-1	2	\N	2017-05-20	-18.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:54.96545	2020-10-23 22:10:54.96545
2835	5	3	-1	2	\N	2017-05-20	-22.00	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:10:54.966779	2020-10-23 22:10:54.966779
2836	2	1	-1	2	\N	2017-05-21	-15.60	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:10:54.968291	2020-10-23 22:10:54.968291
2837	2	1	-1	1	\N	2017-05-21	10.00	6a9aeddfc689c1d0e3b9ccc3ab651bc5	2020-10-23 22:10:54.969782	2020-10-23 22:10:54.969782
2838	5	1	-1	2	\N	2017-05-23	-7.50	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:54.971663	2020-10-23 22:10:54.971663
2839	5	1	-1	2	\N	2017-05-23	-15.19	71149d8d730099caae3b0ad93b6b93ae	2020-10-23 22:10:54.973175	2020-10-23 22:10:54.973175
2840	5	4	13	2	\N	2017-05-24	-137.98	03dec25e5158510aba66cefc9111607a	2020-10-23 22:10:54.974868	2020-10-23 22:10:54.974868
2841	1	9	49	3	\N	2017-05-23	-150.00	fc79aa9a96e7f005de7dd10e37aa2c8c	2020-10-23 22:10:54.976211	2020-10-23 22:10:54.976211
2842	1	10	54	3	\N	2017-05-23	-2000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:10:54.977731	2020-10-23 22:10:54.977731
2843	1	10	54	3	\N	2017-05-23	-12960.48	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:10:54.979296	2020-10-23 22:10:54.979296
2844	1	10	54	3	\N	2017-05-23	-1500.00	05f9be08a7893f00515b7c27aa125016	2020-10-23 22:10:54.980651	2020-10-23 22:10:54.980651
2845	5	10	54	4	\N	2017-05-23	1500.00	05f9be08a7893f00515b7c27aa125016	2020-10-23 22:10:54.982103	2020-10-23 22:10:54.982103
2846	5	5	23	2	\N	2017-05-25	-11.00	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:54.984017	2020-10-23 22:10:54.984017
2847	5	5	22	2	\N	2017-05-25	-190.00	bf8229696f7a3bb4700cfddef19fa23f	2020-10-23 22:10:54.985581	2020-10-23 22:10:54.985581
2848	5	1	-1	2	\N	2017-05-25	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:54.987177	2020-10-23 22:10:54.987177
2849	5	1	-1	2	\N	2017-05-24	-92.04	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:54.98862	2020-10-23 22:10:54.98862
2850	5	5	26	2	\N	2017-05-27	-28.30	9e3cfc48eccf81a0d57663e129aef3cb	2020-10-23 22:10:54.990192	2020-10-23 22:10:54.990192
2851	2	5	26	2	\N	2017-05-27	-17.27	f8604c518463c8686750766aa9675879	2020-10-23 22:10:54.991539	2020-10-23 22:10:54.991539
2852	2	5	21	2	\N	2017-05-27	-84.90	c7c43d863d4491c8aa4668fa12bdf60a	2020-10-23 22:10:54.99299	2020-10-23 22:10:54.99299
2853	2	5	21	2	\N	2017-05-27	-41.97	ab0eefe4e22456520006f254adf1947a	2020-10-23 22:10:55.006416	2020-10-23 22:10:55.006416
2854	5	5	23	2	\N	2017-05-27	-12.13	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:55.008156	2020-10-23 22:10:55.008156
2855	5	1	-1	2	\N	2017-05-27	-36.63	aba3b6fd5d186d28e06ff97135cade7f	2020-10-23 22:10:55.010092	2020-10-23 22:10:55.010092
2856	5	1	-1	2	\N	2017-05-27	-102.08	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:10:55.011735	2020-10-23 22:10:55.011735
2857	1	3	-1	2	\N	2017-05-26	-21.98	3fdf7ff211eec1dde75bbdba2e8b5bde	2020-10-23 22:10:55.013133	2020-10-23 22:10:55.013133
2858	1	3	-1	2	\N	2017-05-26	-12.00	65b9eea6e1cc6bb9f0cd2a47751a186f	2020-10-23 22:10:55.014409	2020-10-23 22:10:55.014409
2859	1	3	-1	2	\N	2017-05-26	-23.00	c95ad2a05a8ddb244c6bc3b1041d3f1f	2020-10-23 22:10:55.015599	2020-10-23 22:10:55.015599
2860	1	9	48	2	\N	2017-05-26	-50.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:10:55.01687	2020-10-23 22:10:55.01687
2861	1	3	-1	2	\N	2017-05-26	-23.00	c95ad2a05a8ddb244c6bc3b1041d3f1f	2020-10-23 22:10:55.018191	2020-10-23 22:10:55.018191
2862	1	7	36	2	\N	2017-05-25	-112.97	45280de359eb485c9225be4240a13bd1	2020-10-23 22:10:55.0194	2020-10-23 22:10:55.0194
2863	1	1	-1	2	\N	2017-05-26	-15.17	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.021137	2020-10-23 22:10:55.021137
2864	1	1	-1	2	\N	2017-05-25	-11.55	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.023207	2020-10-23 22:10:55.023207
2865	2	5	23	2	\N	2017-05-26	-120.70	66808e327dc79d135ba18e051673d906	2020-10-23 22:10:55.024996	2020-10-23 22:10:55.024996
2866	1	7	30	2	\N	2017-05-26	-2972.51	cbfd26523009bb7fab5f7f3fdfa5b6bc	2020-10-23 22:10:55.026455	2020-10-23 22:10:55.026455
2867	1	1	-1	2	\N	2017-05-28	-22.18	6c94db4a808e5b20e82b9b2024665fa3	2020-10-23 22:10:55.027809	2020-10-23 22:10:55.027809
2868	5	1	-1	2	\N	2017-05-29	-14.66	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.029197	2020-10-23 22:10:55.029197
2869	5	1	-1	2	\N	2017-05-30	-59.68	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:55.030584	2020-10-23 22:10:55.030584
2870	2	2	3	1	\N	2017-05-30	11538.62	59f52e09ddf034e29a57caf27f4d6e95	2020-10-23 22:10:55.032035	2020-10-23 22:10:55.032035
2871	2	10	54	3	\N	2017-05-30	-1500.00	b5b41fac0361d157d9673ecb926af5ae	2020-10-23 22:10:55.033654	2020-10-23 22:10:55.033654
2872	5	10	54	4	\N	2017-05-30	1500.00	b5b41fac0361d157d9673ecb926af5ae	2020-10-23 22:10:55.03523	2020-10-23 22:10:55.03523
2873	2	10	54	3	\N	2017-05-30	-2000.00	40aa48c0e1ef1af6ecc1af96aa2f2c0f	2020-10-23 22:10:55.036632	2020-10-23 22:10:55.036632
2874	6	10	54	4	\N	2017-05-30	2000.00	40aa48c0e1ef1af6ecc1af96aa2f2c0f	2020-10-23 22:10:55.038067	2020-10-23 22:10:55.038067
2875	2	10	54	3	\N	2017-05-30	-7500.00	1ff8a7b5dc7a7d1f0ed65aaa29c04b1e	2020-10-23 22:10:55.039834	2020-10-23 22:10:55.039834
2876	4	10	54	4	\N	2017-05-30	7500.00	1ff8a7b5dc7a7d1f0ed65aaa29c04b1e	2020-10-23 22:10:55.041157	2020-10-23 22:10:55.041157
2877	5	5	23	2	\N	2017-05-30	-29.98	ebde10de659e856e522303776dd7bdf1	2020-10-23 22:10:55.042391	2020-10-23 22:10:55.042391
2878	1	1	-1	2	\N	2017-05-30	-3.87	db5e3ca8f31baa572cb64be6e74d0dba	2020-10-23 22:10:55.043615	2020-10-23 22:10:55.043615
2879	1	2	3	1	\N	2017-05-30	10012.52	14451daa5c7f813573b8a72a0e1cfd95	2020-10-23 22:10:55.044816	2020-10-23 22:10:55.044816
2880	5	4	13	2	\N	2017-05-30	-341.20	245894da7605c9899120033b962320c3	2020-10-23 22:10:55.046287	2020-10-23 22:10:55.046287
2881	5	4	15	2	\N	2017-05-30	-117.59	758874998f5bd0c393da094e1967a72b	2020-10-23 22:10:55.047626	2020-10-23 22:10:55.047626
2882	5	4	14	2	\N	2017-05-30	-98.83	2661c453ffd171ff42dcfcf56dbaf398	2020-10-23 22:10:55.049094	2020-10-23 22:10:55.049094
2883	5	4	-1	2	\N	2017-05-30	-590.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:10:55.050231	2020-10-23 22:10:55.050231
2884	1	9	51	2	\N	2017-05-30	-110.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:10:55.051547	2020-10-23 22:10:55.051547
2885	1	10	54	3	\N	2017-05-30	-500.00	82a2efc5c69d4c327d979dbb6e60dd70	2020-10-23 22:10:55.052746	2020-10-23 22:10:55.052746
2886	1	10	54	3	\N	2017-05-30	-1500.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:55.054418	2020-10-23 22:10:55.054418
2887	1	10	54	3	\N	2017-05-30	-5600.00	8a0e1141fd37fa5b98d5bb769ba1a7cc	2020-10-23 22:10:55.055855	2020-10-23 22:10:55.055855
2888	6	10	54	4	\N	2017-05-30	5600.00	8a0e1141fd37fa5b98d5bb769ba1a7cc	2020-10-23 22:10:55.057427	2020-10-23 22:10:55.057427
2889	1	10	54	3	\N	2017-05-30	-2200.00	23b66dd4d9be6bba639bc882f30f5475	2020-10-23 22:10:55.058796	2020-10-23 22:10:55.058796
2890	2	9	-1	2	\N	2017-05-31	-150.00	c59e980940cbb12bca6af262a3d70f16	2020-10-23 22:10:55.060192	2020-10-23 22:10:55.060192
2891	1	1	-1	2	\N	2017-05-31	-14.86	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.06135	2020-10-23 22:10:55.06135
2892	5	1	-1	2	\N	2017-05-31	-12.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.062652	2020-10-23 22:10:55.062652
2893	2	5	21	2	\N	2017-06-01	-32.00	ccb0989662211f61edae2e26d58ea92f	2020-10-23 22:10:55.063868	2020-10-23 22:10:55.063868
2894	2	5	26	2	\N	2017-06-01	-12.90	7d04bbbe5494ae9d2f5a76aa1c00fa2f	2020-10-23 22:10:55.065164	2020-10-23 22:10:55.065164
2895	5	5	23	2	\N	2017-06-01	-18.95	7984a0279babd7864742a228570b5792	2020-10-23 22:10:55.066572	2020-10-23 22:10:55.066572
2896	5	1	-1	2	\N	2017-06-01	-10.35	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:55.068073	2020-10-23 22:10:55.068073
2897	5	4	16	2	\N	2017-06-01	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:10:55.069329	2020-10-23 22:10:55.069329
2898	2	4	18	2	\N	2017-05-31	-10.02	8ce4b5fcb6c0dfa9f094c84ac00a09b9	2020-10-23 22:10:55.071019	2020-10-23 22:10:55.071019
2899	5	4	13	2	\N	2017-06-02	-40.43	1f2d2bf8cb003fc3ba9c14ad00f9e3b4	2020-10-23 22:10:55.072524	2020-10-23 22:10:55.072524
2900	2	9	-1	2	\N	2017-06-02	-178.00	69261fbe9d321e10245d1c5150056baf	2020-10-23 22:10:55.074182	2020-10-23 22:10:55.074182
2901	2	8	44	2	\N	2017-06-02	-17.00	6b1a54573ec5f2456526fc8d2bad4598	2020-10-23 22:10:55.075507	2020-10-23 22:10:55.075507
2902	2	9	47	2	\N	2017-06-03	-20.00	e70866c5cefff90781fc1a90804ad49a	2020-10-23 22:10:55.07675	2020-10-23 22:10:55.07675
2903	5	9	48	2	\N	2017-06-03	-22.99	6943cef214dd860f8bdb2b4f5bd0bf08	2020-10-23 22:10:55.0779	2020-10-23 22:10:55.0779
2904	5	1	-1	2	\N	2017-06-03	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.079118	2020-10-23 22:10:55.079118
2905	1	5	21	2	\N	2017-06-02	-36.45	4e01e9a9cb99af3dbc8cd67cb412a4e3	2020-10-23 22:10:55.080425	2020-10-23 22:10:55.080425
2906	5	1	-1	2	\N	2017-06-03	-89.40	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:55.08179	2020-10-23 22:10:55.08179
2907	1	9	49	2	\N	2017-06-01	-14.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:55.083129	2020-10-23 22:10:55.083129
2908	5	9	49	2	\N	2017-06-01	-15.00	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:10:55.084489	2020-10-23 22:10:55.084489
2909	5	10	54	4	\N	2017-06-03	1500.00	8a0e1141fd37fa5b98d5bb769ba1a7cc	2020-10-23 22:10:55.085884	2020-10-23 22:10:55.085884
2910	5	1	-1	2	\N	2017-06-03	-12.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.087308	2020-10-23 22:10:55.087308
2911	1	1	-1	2	\N	2017-06-01	-35.67	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:55.08899	2020-10-23 22:10:55.08899
2912	1	3	-1	2	\N	2017-06-01	-47.68	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:10:55.090415	2020-10-23 22:10:55.090415
2913	5	5	23	2	\N	2017-06-01	-13.80	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:55.091508	2020-10-23 22:10:55.091508
2914	1	1	-1	2	\N	2017-06-02	-36.30	24681928425f5a9133504de568f5f6df	2020-10-23 22:10:55.092943	2020-10-23 22:10:55.092943
2915	5	9	48	2	\N	2017-06-03	-44.00	4dee7f40dd21f4879df0e70d955072b4	2020-10-23 22:10:55.094321	2020-10-23 22:10:55.094321
2916	6	10	55	1	\N	2017-06-01	113.76	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:55.09556	2020-10-23 22:10:55.09556
2917	1	2	-1	1	\N	2017-06-03	8.57	285e19f20beded7d215102b49d5c09a0	2020-10-23 22:10:55.096963	2020-10-23 22:10:55.096963
2918	5	9	-1	2	\N	2017-06-03	-50.87	285e19f20beded7d215102b49d5c09a0	2020-10-23 22:10:55.098191	2020-10-23 22:10:55.098191
2919	5	4	-1	2	\N	2017-06-04	-112.00	815be9c5c7d37e665a99f23bbbdc345f	2020-10-23 22:10:55.099374	2020-10-23 22:10:55.099374
2920	2	1	-1	2	\N	2017-06-03	-14.00	4eb30f049b1f69543e589bc855dd91f8	2020-10-23 22:10:55.100675	2020-10-23 22:10:55.100675
2921	2	9	-1	1	\N	2017-06-04	274.00	bc21d9f71453e9121c16e3979231bf60	2020-10-23 22:10:55.102033	2020-10-23 22:10:55.102033
2922	5	8	42	2	\N	2017-06-03	-63.00	33fa70028d34a6608488788c3b6ec31e	2020-10-23 22:10:55.103181	2020-10-23 22:10:55.103181
2923	2	4	18	2	\N	2017-06-04	-29.00	a8a94eee03e271f865dbf8cdbeb0129d	2020-10-23 22:10:55.104818	2020-10-23 22:10:55.104818
2924	5	1	-1	2	\N	2017-06-07	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.106084	2020-10-23 22:10:55.106084
2925	1	1	-1	2	\N	2017-06-07	-5.38	a41f05e659a0119d3f21b5fea8dbc958	2020-10-23 22:10:55.107499	2020-10-23 22:10:55.107499
2926	1	8	44	2	\N	2017-06-03	-10.00	1634f79e9c8aede7c2930e1181cb4cf9	2020-10-23 22:10:55.10882	2020-10-23 22:10:55.10882
2927	1	3	-1	2	\N	2017-06-03	-13.90	33ea2a5e212ab720e2aa929f17630ca7	2020-10-23 22:10:55.110453	2020-10-23 22:10:55.110453
2928	1	9	-1	2	\N	2017-06-06	-25.00	cf5cf20f2545b642ad00c2d507a04c94	2020-10-23 22:10:55.111727	2020-10-23 22:10:55.111727
2929	1	3	-1	2	\N	2017-06-06	-18.20	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:10:55.113248	2020-10-23 22:10:55.113248
2930	5	1	-1	2	\N	2017-06-06	-35.72	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:10:55.114586	2020-10-23 22:10:55.114586
2931	1	3	-1	2	\N	2017-06-04	-12.69	ef0b0b5b1f685fd8e36cb1c9bd1387b8	2020-10-23 22:10:55.115857	2020-10-23 22:10:55.115857
2932	1	1	-1	2	\N	2017-06-04	-2.19	695c39846d069ffff90953ab7eb4cadf	2020-10-23 22:10:55.117008	2020-10-23 22:10:55.117008
2933	1	8	41	2	\N	2017-06-05	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:55.118177	2020-10-23 22:10:55.118177
2934	6	10	54	3	\N	2017-06-07	-65000.00	468de6e9452bb71156c91a5c4c020000	2020-10-23 22:10:55.119464	2020-10-23 22:10:55.119464
2935	5	10	54	4	\N	2017-06-07	65000.00	468de6e9452bb71156c91a5c4c020000	2020-10-23 22:10:55.120837	2020-10-23 22:10:55.120837
2936	1	10	54	4	\N	2017-06-08	10800.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:10:55.123171	2020-10-23 22:10:55.123171
2937	1	10	54	4	\N	2017-06-08	13200.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:10:55.124768	2020-10-23 22:10:55.124768
2938	1	10	54	3	\N	2017-06-08	-22000.00	468de6e9452bb71156c91a5c4c020000	2020-10-23 22:10:55.126037	2020-10-23 22:10:55.126037
2939	6	10	54	4	\N	2017-06-08	22000.00	468de6e9452bb71156c91a5c4c020000	2020-10-23 22:10:55.127758	2020-10-23 22:10:55.127758
2940	2	8	41	2	\N	2017-06-08	-50.00	b7b16ecf8ca53723593894116071700c	2020-10-23 22:10:55.128952	2020-10-23 22:10:55.128952
2941	2	3	-1	2	\N	2017-06-09	-10.00	b3af409bb8423187c75e6c7f5b683908	2020-10-23 22:10:55.130102	2020-10-23 22:10:55.130102
2942	2	9	48	2	\N	2017-06-09	-5.00	fd3cd64e8cbf777d8d6a935011d01443	2020-10-23 22:10:55.131343	2020-10-23 22:10:55.131343
2943	4	10	54	3	\N	2017-06-09	-58500.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:10:55.132525	2020-10-23 22:10:55.132525
2944	2	10	54	4	\N	2017-06-09	58500.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:10:55.133918	2020-10-23 22:10:55.133918
2945	2	10	54	3	\N	2017-06-09	-59000.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:10:55.13563	2020-10-23 22:10:55.13563
2946	5	10	54	4	\N	2017-06-09	59000.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:10:55.137271	2020-10-23 22:10:55.137271
2947	2	9	48	2	\N	2017-06-09	-33.70	84905bbca339ab6f35302f1978616606	2020-10-23 22:10:55.139171	2020-10-23 22:10:55.139171
2948	5	1	-1	2	\N	2017-06-10	-21.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.140497	2020-10-23 22:10:55.140497
2949	5	1	-1	2	\N	2017-06-10	-160.48	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:55.141841	2020-10-23 22:10:55.141841
2950	5	1	-1	2	\N	2017-06-09	-11.61	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:10:55.143139	2020-10-23 22:10:55.143139
2951	5	1	-1	2	\N	2017-06-09	-14.57	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:55.14433	2020-10-23 22:10:55.14433
2952	5	1	-1	2	\N	2017-06-09	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:55.145632	2020-10-23 22:10:55.145632
2953	5	10	54	3	\N	2017-06-11	-68000.00	d4fba90f641f82e5063b8d2587f123dc	2020-10-23 22:10:55.147052	2020-10-23 22:10:55.147052
2954	6	10	54	4	\N	2017-06-11	68000.00	d4fba90f641f82e5063b8d2587f123dc	2020-10-23 22:10:55.148493	2020-10-23 22:10:55.148493
2955	1	1	-1	2	\N	2017-06-12	-2.20	0efe32849d230d7f53049ddc4a4b0c60	2020-10-23 22:10:55.149857	2020-10-23 22:10:55.149857
2956	5	3	-1	2	\N	2017-06-10	-25.99	35115981b2f724e389a3e310639ba2a5	2020-10-23 22:10:55.151148	2020-10-23 22:10:55.151148
2957	1	9	51	2	\N	2017-06-12	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:10:55.152468	2020-10-23 22:10:55.152468
2958	2	1	-1	2	\N	2017-06-12	-16.57	8d9e78ee05f0247b1e9399c06976bda7	2020-10-23 22:10:55.153884	2020-10-23 22:10:55.153884
2959	1	8	41	2	\N	2017-06-18	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:55.155688	2020-10-23 22:10:55.155688
2960	5	9	48	2	\N	2017-06-17	-25.00	477fde6198d72a5bf98a3b85165f20ea	2020-10-23 22:10:55.157011	2020-10-23 22:10:55.157011
2961	5	9	48	2	\N	2017-06-17	-730.00	8065d07da4a77621450aa84fee5656d9	2020-10-23 22:10:55.158216	2020-10-23 22:10:55.158216
2962	1	1	11	2	\N	2017-06-17	-17.90	4ae8b31072fc84173510878e209b5f7d	2020-10-23 22:10:55.159482	2020-10-23 22:10:55.159482
2963	1	7	36	2	\N	2017-06-17	-56.79	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:10:55.160998	2020-10-23 22:10:55.160998
2964	1	5	21	2	\N	2017-06-17	-14.05	4e01e9a9cb99af3dbc8cd67cb412a4e3	2020-10-23 22:10:55.162294	2020-10-23 22:10:55.162294
2965	1	5	21	2	\N	2017-06-16	-65.00	b5dc4e5d9b495d0196f61d45b26ef33e	2020-10-23 22:10:55.163846	2020-10-23 22:10:55.163846
2966	1	2	-1	1	\N	2017-06-18	12.99	3e716f30c8450143d7248609a6653887	2020-10-23 22:10:55.165214	2020-10-23 22:10:55.165214
2967	5	9	48	2	\N	2017-06-18	-12.99	3eb29d792013f8445b89d1c0cb051d4e	2020-10-23 22:10:55.166563	2020-10-23 22:10:55.166563
2968	1	7	35	2	\N	2017-06-18	-60.00	59e9280dfd52b7d04026ca27777fa83e	2020-10-23 22:10:55.168183	2020-10-23 22:10:55.168183
2969	5	8	43	2	\N	2017-06-16	-115.37	9f396fe44e7c05c16873b05ec425cbad	2020-10-23 22:10:55.169444	2020-10-23 22:10:55.169444
2970	5	8	43	2	\N	2017-06-15	-156.85	56f8e43767cf93af23801dbdf2bf0335	2020-10-23 22:10:55.170726	2020-10-23 22:10:55.170726
2971	1	1	11	2	\N	2017-06-14	-2.00	173f6138afd9b026372907766f8d3764	2020-10-23 22:10:55.172824	2020-10-23 22:10:55.172824
2972	1	1	-1	2	\N	2017-06-14	-20.18	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:55.174411	2020-10-23 22:10:55.174411
2973	1	1	-1	2	\N	2017-06-14	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:55.175737	2020-10-23 22:10:55.175737
2974	1	1	-1	2	\N	2017-06-13	-9.66	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.177105	2020-10-23 22:10:55.177105
2975	1	1	-1	2	\N	2017-06-13	-3.99	d1229569ae37f6f0d96727ae1169862f	2020-10-23 22:10:55.178471	2020-10-23 22:10:55.178471
2976	5	5	23	2	\N	2017-06-14	-7.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:55.179879	2020-10-23 22:10:55.179879
2977	5	1	-1	2	\N	2017-06-18	-10.96	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.181364	2020-10-23 22:10:55.181364
2978	5	1	-1	2	\N	2017-06-14	-17.60	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.182681	2020-10-23 22:10:55.182681
2979	5	1	-1	2	\N	2017-06-18	-10.96	6788875d69976f4d4c84b2812f95d3ac	2020-10-23 22:10:55.183971	2020-10-23 22:10:55.183971
2980	5	1	-1	2	\N	2017-06-18	-10.17	63dc7ed1010d3c3b8269faf0ba7491d4	2020-10-23 22:10:55.18552	2020-10-23 22:10:55.18552
2981	5	4	16	2	\N	2017-06-28	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:10:55.186881	2020-10-23 22:10:55.186881
2982	2	4	16	2	\N	2017-06-29	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:10:55.188983	2020-10-23 22:10:55.188983
2983	2	2	3	1	\N	2017-06-29	5720.58	4734ba6f3de83d861c3176a6273cac6d	2020-10-23 22:10:55.190356	2020-10-23 22:10:55.190356
2984	2	10	54	3	\N	2017-06-29	-1500.00	9882d05cb24f7fd0d1cd0dcd1b86a8a1	2020-10-23 22:10:55.191815	2020-10-23 22:10:55.191815
2985	5	10	54	4	\N	2017-06-29	1500.00	9882d05cb24f7fd0d1cd0dcd1b86a8a1	2020-10-23 22:10:55.193111	2020-10-23 22:10:55.193111
2986	2	4	18	2	\N	2017-06-29	-29.90	2c5d27255f304e869657726360fed06f	2020-10-23 22:10:55.194384	2020-10-23 22:10:55.194384
2987	2	10	54	3	\N	2017-06-29	-4000.00	b4a528955b84f584974e92d025a75d1f	2020-10-23 22:10:55.195911	2020-10-23 22:10:55.195911
2988	6	10	54	4	\N	2017-06-29	4000.00	99c5e07b4d5de9d18c350cdf64c5aa3d	2020-10-23 22:10:55.197318	2020-10-23 22:10:55.197318
2989	5	4	-1	2	\N	2017-06-29	-590.00	e56954b4f6347e897f954495eab16a88	2020-10-23 22:10:55.198685	2020-10-23 22:10:55.198685
2990	5	4	13	2	\N	2017-06-29	-381.63	3b32e93540abe1425efa37772407c9bb	2020-10-23 22:10:55.199917	2020-10-23 22:10:55.199917
2991	5	4	15	2	\N	2017-06-29	-117.59	20e9e854760d152615078596780b9a61	2020-10-23 22:10:55.201284	2020-10-23 22:10:55.201284
2992	2	9	-1	1	\N	2017-06-29	44.90	c4015b7f368e6b4871809f49debe0579	2020-10-23 22:10:55.202717	2020-10-23 22:10:55.202717
2993	2	1	-1	2	\N	2017-06-29	-14.00	00b82ccebba034c4727af7c1e9d72dd1	2020-10-23 22:10:55.20412	2020-10-23 22:10:55.20412
2994	1	1	-1	2	\N	2017-06-30	-4.40	b48124b507ffb0a2ad963982010de473	2020-10-23 22:10:55.205516	2020-10-23 22:10:55.205516
2995	5	1	-1	2	\N	2017-06-30	-3.38	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:10:55.206926	2020-10-23 22:10:55.206926
2996	5	1	11	2	\N	2017-06-30	-5.49	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:10:55.208305	2020-10-23 22:10:55.208305
2997	5	1	-1	2	\N	2017-06-30	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.209646	2020-10-23 22:10:55.209646
2998	5	1	-1	2	\N	2017-06-28	-145.30	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:55.210863	2020-10-23 22:10:55.210863
2999	5	1	-1	2	\N	2017-06-27	-11.70	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.212042	2020-10-23 22:10:55.212042
3000	5	5	22	2	\N	2017-06-29	-280.00	ac41056e786c290c1c44c3b54e047a0e	2020-10-23 22:10:55.213374	2020-10-23 22:10:55.213374
3001	5	1	-1	2	\N	2017-06-27	-72.00	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:10:55.214693	2020-10-23 22:10:55.214693
3002	1	1	-1	2	\N	2017-06-26	-7.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.216055	2020-10-23 22:10:55.216055
3003	1	7	33	2	\N	2017-06-30	-14.99	f75ad600a9baec25e3568beb6984e4b6	2020-10-23 22:10:55.217366	2020-10-23 22:10:55.217366
3004	5	7	33	2	\N	2017-06-30	-15.00	f75ad600a9baec25e3568beb6984e4b6	2020-10-23 22:10:55.218642	2020-10-23 22:10:55.218642
3005	5	7	30	2	\N	2017-06-26	-120.94	131dfcee41083a5673dee0a63878bf5b	2020-10-23 22:10:55.220293	2020-10-23 22:10:55.220293
3006	5	7	30	2	\N	2017-06-26	-623.04	22133acd72e0ae3659ae67455debc53b	2020-10-23 22:10:55.222715	2020-10-23 22:10:55.222715
3007	5	7	30	2	\N	2017-06-23	-75.97	c2b0073a68dc528568b799b3dd052bd8	2020-10-23 22:10:55.224087	2020-10-23 22:10:55.224087
3008	5	7	30	2	\N	2017-06-23	-94.42	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:10:55.225378	2020-10-23 22:10:55.225378
3009	5	7	30	2	\N	2017-06-17	-1688.00	210943091c538d2640b1e8ad9a95e694	2020-10-23 22:10:55.226557	2020-10-23 22:10:55.226557
3010	6	10	55	1	\N	2017-06-30	125.75	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:55.227853	2020-10-23 22:10:55.227853
3011	6	10	54	4	\N	2017-06-30	5500.00	b805d7ddcd91b1d3f59fc6bf2b152b94	2020-10-23 22:10:55.229004	2020-10-23 22:10:55.229004
3012	1	2	3	1	\N	2017-06-28	10005.52	55a5d349a037ffe3dac59efac8bb41bf	2020-10-23 22:10:55.230101	2020-10-23 22:10:55.230101
3013	1	10	54	3	\N	2017-06-30	-5500.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:55.231244	2020-10-23 22:10:55.231244
3014	1	10	54	3	\N	2017-06-30	-500.00	fac76a977ae305f29a4d3524da1f88ae	2020-10-23 22:10:55.232319	2020-10-23 22:10:55.232319
3015	1	10	54	3	\N	2017-06-30	-2000.00	6a3b5c5a20b01f9952f1f2c17bdd8a52	2020-10-23 22:10:55.233614	2020-10-23 22:10:55.233614
3016	1	10	54	3	\N	2017-06-30	-1000.00	53cc638c15debc4d5b3bf12f949f5d79	2020-10-23 22:10:55.234742	2020-10-23 22:10:55.234742
3017	1	10	54	3	\N	2017-06-30	-2000.00	4a5a40872023e565257ef33296261f15	2020-10-23 22:10:55.235953	2020-10-23 22:10:55.235953
3018	1	7	30	2	\N	2017-06-28	-42.98	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.237056	2020-10-23 22:10:55.237056
3019	1	7	30	2	\N	2017-06-28	-22.02	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.238449	2020-10-23 22:10:55.238449
3020	1	9	48	2	\N	2017-06-27	-12.00	fbc780df196942ae2b6efacf422c0590	2020-10-23 22:10:55.239703	2020-10-23 22:10:55.239703
3021	1	7	30	2	\N	2017-06-27	-41.29	79c99116d79f13a80b5f7cc4238ac3d0	2020-10-23 22:10:55.241087	2020-10-23 22:10:55.241087
3022	1	7	30	2	\N	2017-06-27	-34.46	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.242357	2020-10-23 22:10:55.242357
3023	1	7	30	2	\N	2017-06-26	-27.75	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.243445	2020-10-23 22:10:55.243445
3024	1	7	30	2	\N	2017-06-26	-36.78	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.244833	2020-10-23 22:10:55.244833
3025	1	7	30	2	\N	2017-06-26	-30.28	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.246161	2020-10-23 22:10:55.246161
3026	1	7	30	2	\N	2017-06-26	-26.22	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.247438	2020-10-23 22:10:55.247438
3027	1	7	30	2	\N	2017-06-24	-33.46	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.248784	2020-10-23 22:10:55.248784
3028	1	7	30	2	\N	2017-06-24	-49.52	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.250088	2020-10-23 22:10:55.250088
3029	1	7	36	2	\N	2017-06-23	-68.73	5283e034e61c8db740a2bbe6a0ad5852	2020-10-23 22:10:55.251255	2020-10-23 22:10:55.251255
3030	1	7	36	2	\N	2017-06-21	-35.84	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:10:55.252878	2020-10-23 22:10:55.252878
3031	5	2	-1	1	\N	2017-06-23	200.00	8f468c873a32bb0619eaeb2050ba45d1	2020-10-23 22:10:55.254251	2020-10-23 22:10:55.254251
3032	2	8	44	2	\N	2017-07-02	-25.00	b34269e38e2ec5b9ea0e50b2857b7154	2020-10-23 22:10:55.255643	2020-10-23 22:10:55.255643
3033	2	8	41	2	\N	2017-07-02	-2.80	6a2408ed8723d43f8ae3ea65c1a6f664	2020-10-23 22:10:55.256842	2020-10-23 22:10:55.256842
3034	2	1	-1	2	\N	2017-07-02	-10.00	1aa48fc4880bb0c9b8a3bf979d3b917e	2020-10-23 22:10:55.257999	2020-10-23 22:10:55.257999
3035	2	3	-1	2	\N	2017-07-02	-20.00	537b7187fa3664168a7045c2af4356c8	2020-10-23 22:10:55.259272	2020-10-23 22:10:55.259272
3036	5	1	-1	2	\N	2017-07-02	-18.22	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.260478	2020-10-23 22:10:55.260478
3037	5	1	-1	2	\N	2017-07-02	-3.99	9778da7e6b1b15582f3a6261bc9275cb	2020-10-23 22:10:55.261836	2020-10-23 22:10:55.261836
3038	1	7	35	2	\N	2017-07-01	-40.00	4b56626af6238c2ff3d08e5ee9174346	2020-10-23 22:10:55.263164	2020-10-23 22:10:55.263164
3039	1	9	49	2	\N	2017-07-03	-12.30	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:10:55.264374	2020-10-23 22:10:55.264374
3040	1	8	41	2	\N	2017-07-03	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:55.265687	2020-10-23 22:10:55.265687
3041	1	9	48	2	\N	2017-07-03	-117.90	31b35a6b7f28ca5647e1065c189c5c0f	2020-10-23 22:10:55.267054	2020-10-23 22:10:55.267054
3042	5	10	54	4	\N	2017-07-03	2000.00	6855456e2fe46a9d49d3d3af4f57443d	2020-10-23 22:10:55.268201	2020-10-23 22:10:55.268201
3043	5	9	-1	2	\N	2017-07-03	-10.02	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:10:55.269429	2020-10-23 22:10:55.269429
3044	4	2	-1	4	\N	2017-07-01	3850.00	a4f23670e1833f3fdb077ca70bbd5d66	2020-10-23 22:10:55.270812	2020-10-23 22:10:55.270812
3045	5	7	30	3	\N	2017-07-03	-150.00	04f22bbec8c0f38e55c8425c78c0d9b8	2020-10-23 22:10:55.272132	2020-10-23 22:10:55.272132
3046	1	7	30	4	\N	2017-07-03	150.00	04f22bbec8c0f38e55c8425c78c0d9b8	2020-10-23 22:10:55.273415	2020-10-23 22:10:55.273415
3047	5	9	48	3	\N	2017-07-03	-200.00	8b16ebc056e613024c057be590b542eb	2020-10-23 22:10:55.274592	2020-10-23 22:10:55.274592
3048	5	4	-1	2	\N	2017-07-03	-98.00	42998cf32d552343bc8e460416382dca	2020-10-23 22:10:55.27585	2020-10-23 22:10:55.27585
3049	5	1	-1	2	\N	2017-07-03	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.277087	2020-10-23 22:10:55.277087
3050	5	5	23	2	\N	2017-07-03	-51.95	7ff570da3b2ba4814f4c3c330bce4c56	2020-10-23 22:10:55.27828	2020-10-23 22:10:55.27828
3051	5	9	48	2	\N	2017-07-04	-18.40	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:55.279509	2020-10-23 22:10:55.279509
3052	2	6	27	2	\N	2017-07-04	-104.50	3885fb83a3d1d81e5e963af3d5427d91	2020-10-23 22:10:55.280707	2020-10-23 22:10:55.280707
3053	5	1	-1	2	\N	2017-07-05	-25.51	6d4a60c0cdc04146a1ef2c56caf03d80	2020-10-23 22:10:55.281936	2020-10-23 22:10:55.281936
3054	5	5	23	2	\N	2017-07-05	-52.97	6d3b101ea442c36cfbf4ccf97ea6a0a5	2020-10-23 22:10:55.283092	2020-10-23 22:10:55.283092
3055	5	1	-1	2	\N	2017-07-05	-118.14	7f2ba118c0929b17399526db728e8223	2020-10-23 22:10:55.284235	2020-10-23 22:10:55.284235
3056	5	9	48	2	\N	2017-07-05	-66.50	b3c470cb4ed147bbb63f1f089d176652	2020-10-23 22:10:55.28535	2020-10-23 22:10:55.28535
3057	5	9	48	2	\N	2017-07-05	-47.89	5487315b1286f907165907aa8fc96619	2020-10-23 22:10:55.28638	2020-10-23 22:10:55.28638
3058	5	5	23	2	\N	2017-07-06	-10.48	c747744d17c6c1c9ab299b561708c2cd	2020-10-23 22:10:55.287687	2020-10-23 22:10:55.287687
3059	2	1	-1	2	\N	2017-07-06	-3.30	2f86f1028eed92d84e9b9e35843c1d6a	2020-10-23 22:10:55.288905	2020-10-23 22:10:55.288905
3060	2	6	27	2	\N	2017-07-06	-293.30	4eb30f049b1f69543e589bc855dd91f8	2020-10-23 22:10:55.290045	2020-10-23 22:10:55.290045
3061	2	6	28	2	\N	2017-07-07	-20.00	aa942ab2bfa6ebda4840e7360ce6e7ef	2020-10-23 22:10:55.291162	2020-10-23 22:10:55.291162
3062	5	5	23	2	\N	2017-07-07	-23.98	bbd77802b7ea77c28698114a8245ff57	2020-10-23 22:10:55.292274	2020-10-23 22:10:55.292274
3063	5	8	43	2	\N	2017-07-08	-165.38	7c91f9555d05e335d195d761340f8968	2020-10-23 22:10:55.293439	2020-10-23 22:10:55.293439
3064	1	1	-1	2	\N	2017-07-07	-4.20	b48124b507ffb0a2ad963982010de473	2020-10-23 22:10:55.29455	2020-10-23 22:10:55.29455
3065	1	7	35	2	\N	2017-07-04	-99.98	97ab62d3ffd876fc9ae166589b9cde1b	2020-10-23 22:10:55.295638	2020-10-23 22:10:55.295638
3066	5	2	-1	1	\N	2017-07-08	550.00	4e79c55861cfff46a105f0c21d3d1396	2020-10-23 22:10:55.296696	2020-10-23 22:10:55.296696
3067	1	1	-1	2	\N	2017-07-09	-5.88	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.297727	2020-10-23 22:10:55.297727
3068	1	1	-1	2	\N	2017-07-09	-9.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.298801	2020-10-23 22:10:55.298801
3069	1	1	-1	2	\N	2017-07-09	-3.20	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:10:55.299902	2020-10-23 22:10:55.299902
3070	5	5	23	2	\N	2017-07-06	-6.06	0d5ddfc1c68c9ea885cc01ead1563763	2020-10-23 22:10:55.300995	2020-10-23 22:10:55.300995
3071	5	5	23	2	\N	2017-07-06	-35.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:10:55.302088	2020-10-23 22:10:55.302088
3072	5	1	-1	2	\N	2017-07-07	-82.18	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:55.303344	2020-10-23 22:10:55.303344
3073	5	5	23	2	\N	2017-07-08	-16.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:55.305245	2020-10-23 22:10:55.305245
3074	5	1	-1	2	\N	2017-07-04	-22.21	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.306505	2020-10-23 22:10:55.306505
3075	1	1	-1	2	\N	2017-07-05	-2.80	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:10:55.307764	2020-10-23 22:10:55.307764
3076	1	1	-1	2	\N	2017-07-06	-10.90	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.308844	2020-10-23 22:10:55.308844
3077	1	1	-1	2	\N	2017-07-07	-15.22	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:10:55.309927	2020-10-23 22:10:55.309927
3078	5	9	48	2	\N	2017-07-11	-55.00	af7df3a1c9e4ebec19d3fdab40d430a5	2020-10-23 22:10:55.311057	2020-10-23 22:10:55.311057
3079	5	1	-1	2	\N	2017-07-10	-9.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.312801	2020-10-23 22:10:55.312801
3080	2	1	-1	2	\N	2017-07-10	-10.00	86f21daaeb50a5e1c5e6f7353945bb91	2020-10-23 22:10:55.313899	2020-10-23 22:10:55.313899
3081	2	9	48	2	\N	2017-07-11	-20.00	d5cfead94f5350c12c322b5b664544c1	2020-10-23 22:10:55.314952	2020-10-23 22:10:55.314952
3082	5	9	48	1	\N	2017-07-11	20.00	ad972f10e0800b49d76fed33a21f6698	2020-10-23 22:10:55.315995	2020-10-23 22:10:55.315995
3083	5	6	27	2	\N	2017-07-10	-104.50	a12b702439630d3303cb7bb27e51bb41	2020-10-23 22:10:55.317066	2020-10-23 22:10:55.317066
3084	5	9	-1	3	\N	2017-07-11	-400.00	9afe2b8215c08e9d7cab10fe37686726	2020-10-23 22:10:55.318516	2020-10-23 22:10:55.318516
3085	2	9	-1	4	\N	2017-07-11	400.00	9afe2b8215c08e9d7cab10fe37686726	2020-10-23 22:10:55.319714	2020-10-23 22:10:55.319714
3086	2	8	41	2	\N	2017-07-11	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:10:55.321016	2020-10-23 22:10:55.321016
3087	5	5	23	2	\N	2017-07-11	-2.18	658a0be763a67b0164c6c814f12c614d	2020-10-23 22:10:55.322244	2020-10-23 22:10:55.322244
3088	2	5	25	2	\N	2017-07-12	-35.00	2ab56412b1163ee131e1246da0955bd1	2020-10-23 22:10:55.323521	2020-10-23 22:10:55.323521
3089	2	1	-1	2	\N	2017-07-12	-10.00	d1229569ae37f6f0d96727ae1169862f	2020-10-23 22:10:55.324817	2020-10-23 22:10:55.324817
3090	2	8	41	2	\N	2017-07-12	-3.80	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:55.326054	2020-10-23 22:10:55.326054
3091	2	4	16	2	\N	2017-07-12	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:10:55.327302	2020-10-23 22:10:55.327302
3092	1	4	18	2	\N	2017-07-14	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:10:55.328609	2020-10-23 22:10:55.328609
3093	5	1	-1	2	\N	2017-07-12	-41.42	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:10:55.330074	2020-10-23 22:10:55.330074
3094	5	1	-1	2	\N	2017-07-14	-11.94	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.331378	2020-10-23 22:10:55.331378
3095	1	7	35	2	\N	2017-07-14	-279.99	ffbb466329361588defb5e30e5df168f	2020-10-23 22:10:55.332574	2020-10-23 22:10:55.332574
3096	5	1	-1	2	\N	2017-07-15	-153.87	320722549d1751cf3f247855f937b982	2020-10-23 22:10:55.333938	2020-10-23 22:10:55.333938
3097	5	1	-1	2	\N	2017-07-15	-14.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.335101	2020-10-23 22:10:55.335101
3098	2	3	-1	2	\N	2017-07-16	-18.00	b59fb8c4c61b01ac09c6344362716465	2020-10-23 22:10:55.336258	2020-10-23 22:10:55.336258
3099	5	1	-1	2	\N	2017-07-16	-103.98	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:10:55.338045	2020-10-23 22:10:55.338045
3100	1	9	49	2	\N	2017-07-17	-51.00	aa942ab2bfa6ebda4840e7360ce6e7ef	2020-10-23 22:10:55.339375	2020-10-23 22:10:55.339375
3101	5	7	30	2	\N	2017-07-18	-50.00	dc923329b287b2f1a42f5cb5f868f462	2020-10-23 22:10:55.340777	2020-10-23 22:10:55.340777
3102	5	3	-1	2	\N	2017-07-17	-17.99	b90a692ce8297a27fba811452146779e	2020-10-23 22:10:55.342165	2020-10-23 22:10:55.342165
3103	1	1	11	2	\N	2017-07-19	-2.00	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:10:55.343663	2020-10-23 22:10:55.343663
3104	5	5	23	2	\N	2017-07-18	-13.83	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:10:55.345188	2020-10-23 22:10:55.345188
3105	5	1	-1	2	\N	2017-07-19	-54.78	09930c455a56f8d2241685079463e1bd	2020-10-23 22:10:55.346644	2020-10-23 22:10:55.346644
3106	5	5	23	2	\N	2017-07-19	-50.94	e83488e04e2a8c35f0e4678bee9a1b98	2020-10-23 22:10:55.347844	2020-10-23 22:10:55.347844
3107	2	1	-1	2	\N	2017-07-19	-4.80	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:55.349258	2020-10-23 22:10:55.349258
3108	5	5	26	2	\N	2017-07-19	-21.17	ac15b43402034ea143328b2fda1744e5	2020-10-23 22:10:55.350369	2020-10-23 22:10:55.350369
3109	2	5	26	2	\N	2017-07-19	-25.17	9f53d83ec0691550f7d2507d57f4f5a2	2020-10-23 22:10:55.352456	2020-10-23 22:10:55.352456
3110	2	2	3	1	\N	2017-07-20	556.49	30ec5e0321717ccd99e22354a3af0899	2020-10-23 22:10:55.354192	2020-10-23 22:10:55.354192
3111	2	9	-1	3	\N	2017-07-21	-400.00	5a5d609279ef343902a4f56855ad6f6d	2020-10-23 22:10:55.35588	2020-10-23 22:10:55.35588
3112	5	9	-1	4	\N	2017-07-21	400.00	5a5d609279ef343902a4f56855ad6f6d	2020-10-23 22:10:55.357201	2020-10-23 22:10:55.357201
3113	2	4	18	2	\N	2017-07-21	-10.00	9f829f5f7d6d644e4560971cb07a756f	2020-10-23 22:10:55.358383	2020-10-23 22:10:55.358383
3114	1	2	-1	1	\N	2017-07-21	0.00	22ffb871208fbc2be174d852724acee3	2020-10-23 22:10:55.359653	2020-10-23 22:10:55.359653
3115	1	7	36	2	\N	2017-07-21	-65.23	158e46ebb0fa28059bffc445a6f10da0	2020-10-23 22:10:55.361224	2020-10-23 22:10:55.361224
3116	5	1	-1	2	\N	2017-07-20	-9.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.362438	2020-10-23 22:10:55.362438
3117	5	1	-1	2	\N	2017-07-22	-11.90	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:10:55.363565	2020-10-23 22:10:55.363565
3118	5	1	-1	2	\N	2017-07-22	-83.20	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:10:55.364655	2020-10-23 22:10:55.364655
3119	1	9	48	2	\N	2017-07-22	-27.00	a0950d25a0593f48090ead2dc84abd77	2020-10-23 22:10:55.365865	2020-10-23 22:10:55.365865
3120	1	1	-1	2	\N	2017-07-22	-30.00	0fb4949df4b890779431a30052df940e	2020-10-23 22:10:55.367391	2020-10-23 22:10:55.367391
3121	5	1	-1	2	\N	2017-07-22	-16.38	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:55.368578	2020-10-23 22:10:55.368578
3122	2	6	27	2	\N	2017-07-22	-9.80	9b698eb3105bd82528f23d0c92dedfc0	2020-10-23 22:10:55.36984	2020-10-23 22:10:55.36984
3123	2	9	-1	2	\N	2017-07-22	-99.00	001cbc059a402b3be7c99be558eaaf73	2020-10-23 22:10:55.371019	2020-10-23 22:10:55.371019
3124	5	9	48	2	\N	2017-07-22	-45.40	63c4da4fde984fa5c719cdcf2147ab7f	2020-10-23 22:10:55.372324	2020-10-23 22:10:55.372324
3125	2	9	-1	2	\N	2017-07-22	-22.80	001cbc059a402b3be7c99be558eaaf73	2020-10-23 22:10:55.373565	2020-10-23 22:10:55.373565
3126	5	1	-1	2	\N	2017-07-21	-41.73	99f667dfcfff1b0fb966bfff38de28bb	2020-10-23 22:10:55.374764	2020-10-23 22:10:55.374764
3127	2	6	27	2	\N	2017-07-22	-75.46	b55ec28c52d5f6205684a473a2193564	2020-10-23 22:10:55.375789	2020-10-23 22:10:55.375789
3128	5	1	11	2	\N	2017-07-23	-17.38	c6a338a988f479dff20b1c16d728efa2	2020-10-23 22:10:55.376933	2020-10-23 22:10:55.376933
3129	5	3	-1	2	\N	2017-07-23	-19.98	e70866c5cefff90781fc1a90804ad49a	2020-10-23 22:10:55.378138	2020-10-23 22:10:55.378138
3130	5	7	30	2	\N	2017-07-24	-135.72	992fe32ccaed550899772cc80a40d81f	2020-10-23 22:10:55.37933	2020-10-23 22:10:55.37933
3131	1	5	25	2	\N	2017-07-22	-40.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:10:55.380486	2020-10-23 22:10:55.380486
3132	2	6	27	1	\N	2017-07-24	104.50	ca296325805579421f9c03660b6037cf	2020-10-23 22:10:55.381662	2020-10-23 22:10:55.381662
3133	2	7	31	2	\N	2017-07-24	-22.00	935c1f5d59a9bdd22194d551ed375acd	2020-10-23 22:10:55.382958	2020-10-23 22:10:55.382958
3134	2	9	48	2	\N	2017-07-24	-10.00	57aeee35c98205091e18d1140e9f38cf	2020-10-23 22:10:55.384467	2020-10-23 22:10:55.384467
3135	5	7	30	2	\N	2017-07-25	-120.00	3522d54cf3e819b5d3e1cbf8aef6af5a	2020-10-23 22:10:55.385848	2020-10-23 22:10:55.385848
3136	5	8	43	2	\N	2017-07-25	-31.50	8231bff6dd5731e59e1c385c67ba277a	2020-10-23 22:10:55.386996	2020-10-23 22:10:55.386996
3137	5	5	23	2	\N	2017-07-25	-55.48	7f9098b3aa499fc3c45fc1b938fa2983	2020-10-23 22:10:55.388128	2020-10-23 22:10:55.388128
3138	5	1	-1	2	\N	2017-07-25	-23.13	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.389382	2020-10-23 22:10:55.389382
3139	1	5	21	2	\N	2017-07-26	-46.25	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:10:55.390469	2020-10-23 22:10:55.390469
3140	1	2	3	1	\N	2017-07-26	12257.09	362842296f8c3370c748838bccf5e9c6	2020-10-23 22:10:55.391672	2020-10-23 22:10:55.391672
3141	5	1	-1	2	\N	2017-07-26	-10.82	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:10:55.392873	2020-10-23 22:10:55.392873
3142	5	3	-1	2	\N	2017-07-26	-17.99	95b3019deacb238e7455893b97926528	2020-10-23 22:10:55.394031	2020-10-23 22:10:55.394031
3143	5	1	-1	2	\N	2017-07-26	-92.80	320722549d1751cf3f247855f937b982	2020-10-23 22:10:55.395201	2020-10-23 22:10:55.395201
3144	5	1	-1	2	\N	2017-07-27	-13.14	824da999fd3743e7d4e6e19246b0cb55	2020-10-23 22:10:55.396392	2020-10-23 22:10:55.396392
3145	1	3	-1	2	\N	2017-07-27	-36.72	5544c39c40833ed5de0fc2a596d567ca	2020-10-23 22:10:55.397597	2020-10-23 22:10:55.397597
3146	2	5	21	2	\N	2017-07-27	-43.55	f2d55651da3ccc07bce92c32b85ba563	2020-10-23 22:10:55.398866	2020-10-23 22:10:55.398866
3147	2	6	27	3	\N	2017-07-28	-104.50	fe73f687e5bc5280214e0486b273a5f9	2020-10-23 22:10:55.39995	2020-10-23 22:10:55.39995
3148	5	6	27	4	\N	2017-07-28	104.50	fe73f687e5bc5280214e0486b273a5f9	2020-10-23 22:10:55.400965	2020-10-23 22:10:55.400965
3149	2	2	3	1	\N	2017-07-28	5652.93	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:10:55.402037	2020-10-23 22:10:55.402037
3150	2	10	54	3	\N	2017-07-28	-1500.00	ab233b682ec355648e7891e66c54191b	2020-10-23 22:10:55.403374	2020-10-23 22:10:55.403374
3151	5	10	54	4	\N	2017-07-28	1500.00	ab233b682ec355648e7891e66c54191b	2020-10-23 22:10:55.40523	2020-10-23 22:10:55.40523
3152	2	10	54	3	\N	2017-07-28	-3000.00	1821e85b82eef4439c2f8c3fc98d4e90	2020-10-23 22:10:55.406669	2020-10-23 22:10:55.406669
3153	6	10	54	4	\N	2017-07-28	3000.00	1821e85b82eef4439c2f8c3fc98d4e90	2020-10-23 22:10:55.407921	2020-10-23 22:10:55.407921
3154	2	10	54	3	\N	2017-07-28	-500.00	828152d112507f3ea5b7ddc171f2bb2e	2020-10-23 22:10:55.409519	2020-10-23 22:10:55.409519
3155	4	10	54	4	\N	2017-07-28	500.00	828152d112507f3ea5b7ddc171f2bb2e	2020-10-23 22:10:55.410732	2020-10-23 22:10:55.410732
3156	5	4	13	2	\N	2017-07-28	-56.89	a1d33d0dfec820b41b54430b50e96b5c	2020-10-23 22:10:55.411825	2020-10-23 22:10:55.411825
3157	1	1	-1	2	\N	2017-07-28	-2.49	df877f3865752637daa540ea9cbc474f	2020-10-23 22:10:55.412913	2020-10-23 22:10:55.412913
3158	5	1	-1	2	\N	2017-07-29	-20.00	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:10:55.413905	2020-10-23 22:10:55.413905
3159	5	1	-1	2	\N	2017-07-29	-116.08	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:10:55.415117	2020-10-23 22:10:55.415117
3160	2	6	27	2	\N	2017-07-29	-19.47	a1285459e416a3c2fc3b67025265fe4e	2020-10-23 22:10:55.416379	2020-10-23 22:10:55.416379
3161	2	8	41	2	\N	2017-07-29	-52.80	89e752fda1fe0397d932251ad5e6acef	2020-10-23 22:10:55.417623	2020-10-23 22:10:55.417623
3162	5	4	13	2	\N	2017-07-29	-381.63	6a2408ed8723d43f8ae3ea65c1a6f664	2020-10-23 22:10:55.418802	2020-10-23 22:10:55.418802
3163	5	4	-1	2	\N	2017-07-29	-590.00	a8ef70fa8b69e69b272ba381ad58ec86	2020-10-23 22:10:55.419932	2020-10-23 22:10:55.419932
3164	5	4	15	2	\N	2017-07-29	-117.59	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:10:55.421198	2020-10-23 22:10:55.421198
3165	5	8	43	2	\N	2017-07-29	-191.08	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:55.422958	2020-10-23 22:10:55.422958
3166	5	1	-1	2	\N	2017-07-30	-34.10	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:55.424133	2020-10-23 22:10:55.424133
3167	1	9	-1	2	\N	2017-07-30	-81.50	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:10:55.425312	2020-10-23 22:10:55.425312
3168	1	10	54	3	\N	2017-07-30	-12000.00	fe292c59c55768f7b35ec393e249760e	2020-10-23 22:10:55.426364	2020-10-23 22:10:55.426364
3169	5	7	33	3	\N	2017-07-31	-15.00	d6a60dbe22c357f0016389cafb3ea4e4	2020-10-23 22:10:55.427458	2020-10-23 22:10:55.427458
3170	1	2	-1	4	\N	2017-07-03	15.00	d6a60dbe22c357f0016389cafb3ea4e4	2020-10-23 22:10:55.428668	2020-10-23 22:10:55.428668
3171	5	4	16	2	\N	2017-07-30	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:10:55.4301	2020-10-23 22:10:55.4301
3172	1	8	41	2	\N	2017-07-31	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:10:55.431427	2020-10-23 22:10:55.431427
3173	1	9	-1	2	\N	2017-08-01	-3.00	2ca65f58e35d9ad45bf7f3ae5cfd08f1	2020-10-23 22:10:55.432832	2020-10-23 22:10:55.432832
3174	5	1	-1	2	\N	2017-08-01	-16.82	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.434086	2020-10-23 22:10:55.434086
3175	1	9	49	2	\N	2017-08-01	-100.00	ae775a2bd99e8b4b31a33486f4804fd3	2020-10-23 22:10:55.435261	2020-10-23 22:10:55.435261
3176	6	10	55	1	\N	2017-08-01	160.41	31140df990f363df5aa50b75dd394522	2020-10-23 22:10:55.43648	2020-10-23 22:10:55.43648
3177	1	10	54	4	\N	2017-08-01	12000.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:10:55.437624	2020-10-23 22:10:55.437624
3178	1	10	54	3	\N	2017-08-01	-7000.00	819067493a57721cedd20a5ffcdc4b60	2020-10-23 22:10:55.439453	2020-10-23 22:10:55.439453
3179	1	10	54	3	\N	2017-08-01	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:10:55.440702	2020-10-23 22:10:55.440702
3180	1	10	54	3	\N	2017-08-01	-1000.00	668df5a099a9fd3af823e16a98235a81	2020-10-23 22:10:55.441803	2020-10-23 22:10:55.441803
3181	1	10	54	3	\N	2017-08-01	-1000.00	e131f3bfae5023af3d5e45151b46f47f	2020-10-23 22:10:55.442972	2020-10-23 22:10:55.442972
3182	1	10	54	3	\N	2017-08-01	-2000.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:55.44415	2020-10-23 22:10:55.44415
3183	6	10	54	4	\N	2017-08-01	2000.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:10:55.445396	2020-10-23 22:10:55.445396
3184	2	9	48	2	\N	2017-08-02	-10.00	065ea8988ce7154605bfd1674a90581c	2020-10-23 22:10:55.446674	2020-10-23 22:10:55.446674
3185	5	1	-1	2	\N	2017-08-02	-12.98	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:10:55.448095	2020-10-23 22:10:55.448095
3186	1	1	-1	2	\N	2017-08-02	-2.99	695c39846d069ffff90953ab7eb4cadf	2020-10-23 22:10:55.449292	2020-10-23 22:10:55.449292
3187	5	1	-1	2	\N	2017-08-03	-8.51	5d717f90b4dd9fd563a311514fefc6b8	2020-10-23 22:10:55.450905	2020-10-23 22:10:55.450905
3188	1	1	-1	2	\N	2017-08-03	-4.20	6b42012b07d091395230a3a71b477a02	2020-10-23 22:10:55.452654	2020-10-23 22:10:55.452654
3189	1	9	51	2	\N	2017-08-03	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:10:55.453824	2020-10-23 22:10:55.453824
3190	1	7	35	2	\N	2017-08-04	-29.98	e77bc7b6a888586184d57c4b852b7b19	2020-10-23 22:10:55.455263	2020-10-23 22:10:55.455263
3191	5	10	54	3	\N	2017-08-04	-1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.456599	2020-10-23 22:10:55.456599
3192	6	10	54	4	\N	2017-08-04	1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.457848	2020-10-23 22:10:55.457848
3193	5	10	54	4	\N	2017-08-04	5500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.459339	2020-10-23 22:10:55.459339
3194	5	10	54	3	\N	2017-08-04	-500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.460439	2020-10-23 22:10:55.460439
3195	1	10	54	4	\N	2017-08-04	500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.461651	2020-10-23 22:10:55.461651
3196	5	8	43	2	\N	2017-08-04	-33.70	dc72030c78471e298a91e06022fb7662	2020-10-23 22:10:55.463001	2020-10-23 22:10:55.463001
3197	5	1	-1	2	\N	2017-08-04	-19.80	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:10:55.464155	2020-10-23 22:10:55.464155
3198	5	1	-1	2	\N	2017-08-04	-3.19	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:10:55.465241	2020-10-23 22:10:55.465241
3199	5	1	-1	2	\N	2017-08-04	-65.82	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.466273	2020-10-23 22:10:55.466273
3200	5	1	-1	2	\N	2017-08-05	-34.50	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:10:55.467332	2020-10-23 22:10:55.467332
3201	5	7	30	2	\N	2017-08-05	-32.00	773d6e0a31ef59cd58cf04a377326cc2	2020-10-23 22:10:55.468359	2020-10-23 22:10:55.468359
3202	5	1	-1	2	\N	2017-08-05	-34.13	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.469454	2020-10-23 22:10:55.469454
3203	5	8	43	2	\N	2017-08-06	-33.70	dc72030c78471e298a91e06022fb7662	2020-10-23 22:10:55.470475	2020-10-23 22:10:55.470475
3204	5	8	43	2	\N	2017-08-06	-208.12	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:55.471666	2020-10-23 22:10:55.471666
3205	5	9	-1	2	\N	2017-08-06	-6.30	2ca65f58e35d9ad45bf7f3ae5cfd08f1	2020-10-23 22:10:55.472889	2020-10-23 22:10:55.472889
3206	5	10	54	3	\N	2017-08-07	-2500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:10:55.474042	2020-10-23 22:10:55.474042
3207	1	1	-1	2	\N	2017-08-07	-11.24	f421888918b43ff64385f6fef0bca725	2020-10-23 22:10:55.47516	2020-10-23 22:10:55.47516
3208	5	5	23	2	\N	2017-08-07	-14.99	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:10:55.476193	2020-10-23 22:10:55.476193
3209	5	1	-1	2	\N	2017-08-07	-22.68	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.477301	2020-10-23 22:10:55.477301
3210	1	7	30	1	\N	2017-08-07	280.00	787cacc9296d1e1bc664ef88fed264ee	2020-10-23 22:10:55.478338	2020-10-23 22:10:55.478338
3211	1	7	30	2	\N	2017-08-07	-360.00	787cacc9296d1e1bc664ef88fed264ee	2020-10-23 22:10:55.479512	2020-10-23 22:10:55.479512
3212	1	8	45	2	\N	2017-08-07	-37.00	c7885a9afe0848a1fd9053f596de710d	2020-10-23 22:10:55.480935	2020-10-23 22:10:55.480935
3213	1	1	-1	2	\N	2017-08-07	-2.20	9023f6c6054a6f53fad320dc87e73850	2020-10-23 22:10:55.482133	2020-10-23 22:10:55.482133
3214	2	1	-1	2	\N	2017-08-07	-16.50	19f42e77c95b7a5a9a6f36d0b95f0e9f	2020-10-23 22:10:55.483237	2020-10-23 22:10:55.483237
3215	2	1	-1	2	\N	2017-08-07	-11.00	ac15b43402034ea143328b2fda1744e5	2020-10-23 22:10:55.484378	2020-10-23 22:10:55.484378
3216	5	4	-1	2	\N	2017-08-07	-126.00	fae0b27c451c728867a567e8c1bb4e53	2020-10-23 22:10:55.485487	2020-10-23 22:10:55.485487
3217	2	9	48	2	\N	2017-08-04	-11.99	bc2dd5c0c70cd37500f38ca9b0570e7e	2020-10-23 22:10:55.486591	2020-10-23 22:10:55.486591
3218	2	1	-1	2	\N	2017-08-04	-43.50	525cb7384683b0f3e96dc031d7ffbe52	2020-10-23 22:10:55.487836	2020-10-23 22:10:55.487836
3219	1	8	44	2	\N	2017-08-08	-20.59	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:10:55.489054	2020-10-23 22:10:55.489054
3220	5	1	-1	2	\N	2017-08-08	-17.73	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.490169	2020-10-23 22:10:55.490169
3221	5	1	-1	2	\N	2017-08-08	-87.42	320722549d1751cf3f247855f937b982	2020-10-23 22:10:55.491361	2020-10-23 22:10:55.491361
3222	5	1	-1	2	\N	2017-08-09	-10.57	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.492563	2020-10-23 22:10:55.492563
3223	6	10	54	4	\N	2017-08-10	2500.00	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:10:55.493839	2020-10-23 22:10:55.493839
3224	5	1	-1	2	\N	2017-08-10	-27.21	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:10:55.495098	2020-10-23 22:10:55.495098
3225	5	1	-1	2	\N	2017-08-11	-6.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.496218	2020-10-23 22:10:55.496218
3226	1	1	-1	2	\N	2017-08-12	-14.96	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.497262	2020-10-23 22:10:55.497262
3227	5	1	-1	2	\N	2017-08-12	-20.37	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.498397	2020-10-23 22:10:55.498397
3228	5	8	43	2	\N	2017-08-12	-203.35	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:10:55.499688	2020-10-23 22:10:55.499688
3229	5	1	-1	2	\N	2017-08-14	-16.25	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.500941	2020-10-23 22:10:55.500941
3230	1	9	48	2	\N	2017-08-15	-66.90	68acb0b7d6d97328e668337593bc4ec7	2020-10-23 22:10:55.502084	2020-10-23 22:10:55.502084
3231	1	9	48	2	\N	2017-08-15	-150.00	68acb0b7d6d97328e668337593bc4ec7	2020-10-23 22:10:55.503167	2020-10-23 22:10:55.503167
3232	1	1	-1	2	\N	2017-08-15	-10.19	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.504546	2020-10-23 22:10:55.504546
3233	1	1	-1	2	\N	2017-08-16	-8.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:10:55.505934	2020-10-23 22:10:55.505934
3234	5	5	23	2	\N	2017-08-16	-108.89	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:10:55.50719	2020-10-23 22:10:55.50719
3235	1	9	51	2	\N	2017-08-16	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:10:55.508561	2020-10-23 22:10:55.508561
3236	5	1	-1	2	\N	2017-08-16	-100.86	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:10:55.509894	2020-10-23 22:10:55.509894
3237	1	1	11	2	\N	2017-08-17	-8.00	e5841df2166dd424a57127423d276bbe	2020-10-23 22:40:13.053412	2020-10-23 22:40:13.053412
3238	1	1	11	2	\N	2017-08-17	-8.00	e5841df2166dd424a57127423d276bbe	2020-10-23 22:40:23.435637	2020-10-23 22:40:23.435637
3239	1	1	-1	2	\N	2017-08-17	-13.92	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:32.457001	2020-10-23 22:40:32.457001
3240	1	1	-1	2	\N	2017-08-17	-12.93	26343650e5444f1040078a99b41ecab3	2020-10-23 22:40:32.4586	2020-10-23 22:40:32.4586
3241	5	1	-1	2	\N	2017-08-19	-81.66	320722549d1751cf3f247855f937b982	2020-10-23 22:40:32.460445	2020-10-23 22:40:32.460445
3242	5	1	-1	2	\N	2017-08-19	-6.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.462518	2020-10-23 22:40:32.462518
3243	5	1	-1	2	\N	2017-08-19	-15.48	1728efbda81692282ba642aafd57be3a	2020-10-23 22:40:32.464602	2020-10-23 22:40:32.464602
3244	1	1	-1	2	\N	2017-08-20	-20.00	a6cb53f898763c410cf00175c3deedeb	2020-10-23 22:40:32.46691	2020-10-23 22:40:32.46691
3245	2	9	-1	2	\N	2017-08-21	-59.85	f2217062e9a397a1dca429e7d70bc6ca	2020-10-23 22:40:32.468376	2020-10-23 22:40:32.468376
3246	2	9	-1	2	\N	2017-08-21	-59.85	f73b76ce8949fe29bf2a537cfa420e8f	2020-10-23 22:40:32.469632	2020-10-23 22:40:32.469632
3247	2	9	-1	1	\N	2017-08-21	47.88	a5e00132373a7031000fd987a3c9f87b	2020-10-23 22:40:32.471038	2020-10-23 22:40:32.471038
3248	5	1	-1	2	\N	2017-08-20	-18.42	05b980fd14414110790904f87051f9e9	2020-10-23 22:40:32.472509	2020-10-23 22:40:32.472509
3249	2	6	27	2	\N	2017-08-14	-69.98	26408ffa703a72e8ac0117e74ad46f33	2020-10-23 22:40:32.474383	2020-10-23 22:40:32.474383
3250	5	1	-1	2	\N	2017-08-14	-18.63	05b980fd14414110790904f87051f9e9	2020-10-23 22:40:32.47575	2020-10-23 22:40:32.47575
3251	2	4	18	2	\N	2017-08-18	-29.00	e13f0e90f70b014d9e168fb944882764	2020-10-23 22:40:32.477242	2020-10-23 22:40:32.477242
3252	1	9	48	2	\N	2017-08-23	-31.98	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:32.479045	2020-10-23 22:40:32.479045
3253	1	8	41	2	\N	2017-08-22	-7.60	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:40:32.480405	2020-10-23 22:40:32.480405
3254	5	5	23	2	\N	2017-08-24	-24.59	c9733017b7b4cc30759a7f726ca11617	2020-10-23 22:40:32.481688	2020-10-23 22:40:32.481688
3255	2	1	-1	2	\N	2017-08-24	-25.50	ebccbfa05569eaaeefc7e261dd0bdb26	2020-10-23 22:40:32.483021	2020-10-23 22:40:32.483021
3256	2	1	-1	2	\N	2017-08-25	-7.00	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:40:32.484286	2020-10-23 22:40:32.484286
3257	1	1	-1	2	\N	2017-08-25	-15.00	b7b16ecf8ca53723593894116071700c	2020-10-23 22:40:32.485535	2020-10-23 22:40:32.485535
3258	1	3	-1	2	\N	2017-08-25	-36.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:32.487031	2020-10-23 22:40:32.487031
3259	5	1	-1	2	\N	2017-08-24	-7.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.489192	2020-10-23 22:40:32.489192
3260	5	1	-1	2	\N	2017-08-26	-5.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.49143	2020-10-23 22:40:32.49143
3261	5	1	-1	2	\N	2017-08-24	-7.18	a2962a1fa38aa0c4755ab89a6605e755	2020-10-23 22:40:32.493539	2020-10-23 22:40:32.493539
3262	5	1	-1	2	\N	2017-08-26	-10.24	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:32.495155	2020-10-23 22:40:32.495155
3263	5	1	-1	2	\N	2017-08-26	-110.51	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:32.496375	2020-10-23 22:40:32.496375
3264	1	9	49	2	\N	2017-08-27	-93.49	8f85e3c8e60ab4b0b3e88cdf6642644b	2020-10-23 22:40:32.497569	2020-10-23 22:40:32.497569
3265	5	1	-1	2	\N	2017-08-27	-35.93	705f2172834666788607efbfca35afb3	2020-10-23 22:40:32.498786	2020-10-23 22:40:32.498786
3266	2	5	26	2	\N	2017-08-27	-8.30	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:40:32.500167	2020-10-23 22:40:32.500167
3267	1	4	18	2	\N	2017-08-27	-29.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:32.501833	2020-10-23 22:40:32.501833
3268	1	1	11	2	\N	2017-08-28	-7.94	ad0e5e531c8bc838a33cf6d1d0c789d3	2020-10-23 22:40:32.503174	2020-10-23 22:40:32.503174
3269	5	9	-1	3	\N	2017-08-29	-50.00	288cc0ff022877bd3df94bc9360b9c5d	2020-10-23 22:40:32.504836	2020-10-23 22:40:32.504836
3270	2	9	-1	4	\N	2017-08-29	50.00	288cc0ff022877bd3df94bc9360b9c5d	2020-10-23 22:40:32.506861	2020-10-23 22:40:32.506861
3271	2	4	18	2	\N	2017-08-29	-29.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:32.508743	2020-10-23 22:40:32.508743
3272	5	1	-1	2	\N	2017-08-29	-10.26	671f8ff3e6c9b665f711c75a801c04b1	2020-10-23 22:40:32.510449	2020-10-23 22:40:32.510449
3273	2	2	3	1	\N	2017-08-29	7006.61	04e0529dedd62c6f71a30ff5e281d459	2020-10-23 22:40:32.512483	2020-10-23 22:40:32.512483
3274	2	10	54	3	\N	2017-08-30	-1500.00	66e5b85592673701a365258dcb11f2b2	2020-10-23 22:40:32.514555	2020-10-23 22:40:32.514555
3275	5	10	54	4	\N	2017-08-30	1500.00	66e5b85592673701a365258dcb11f2b2	2020-10-23 22:40:32.516175	2020-10-23 22:40:32.516175
3276	2	10	54	3	\N	2017-08-30	-2000.00	66e5b85592673701a365258dcb11f2b2	2020-10-23 22:40:32.518173	2020-10-23 22:40:32.518173
3277	6	10	54	4	\N	2017-08-30	2000.00	66e5b85592673701a365258dcb11f2b2	2020-10-23 22:40:32.520013	2020-10-23 22:40:32.520013
3278	5	4	13	2	\N	2017-08-30	-381.63	d709f38ef758b5066ef31b18039b8ce5	2020-10-23 22:40:32.521893	2020-10-23 22:40:32.521893
3279	5	4	-1	2	\N	2017-08-30	-590.00	1eb3aa055e74efd118825142f6ee3e2c	2020-10-23 22:40:32.523894	2020-10-23 22:40:32.523894
3280	5	4	16	2	\N	2017-08-30	-49.90	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:40:32.525952	2020-10-23 22:40:32.525952
3281	5	4	14	2	\N	2017-08-30	-96.67	b56c3e19f5a9156859dc89cdf30afc1b	2020-10-23 22:40:32.52797	2020-10-23 22:40:32.52797
3282	1	1	-1	2	\N	2017-08-31	-2.20	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:32.529854	2020-10-23 22:40:32.529854
3283	1	2	3	1	\N	2017-08-28	8214.52	9e3cfc48eccf81a0d57663e129aef3cb	2020-10-23 22:40:32.531945	2020-10-23 22:40:32.531945
3284	1	2	-1	4	\N	2017-08-31	15.00	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:32.533862	2020-10-23 22:40:32.533862
3285	5	7	33	3	\N	2017-08-31	-15.00	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:32.535795	2020-10-23 22:40:32.535795
3286	1	10	54	3	\N	2017-08-31	-500.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:32.537667	2020-10-23 22:40:32.537667
3287	1	9	-1	3	\N	2017-08-31	-84.99	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:32.539687	2020-10-23 22:40:32.539687
3288	1	8	41	2	\N	2017-08-31	-24.29	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:32.541949	2020-10-23 22:40:32.541949
3289	1	8	41	2	\N	2017-08-31	-46.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:32.543995	2020-10-23 22:40:32.543995
3290	6	10	55	1	\N	2017-09-01	136.71	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:32.545959	2020-10-23 22:40:32.545959
3291	1	10	54	3	\N	2017-09-01	-7000.00	c2d128461711cb0d371c986a4a7cc001	2020-10-23 22:40:32.548054	2020-10-23 22:40:32.548054
3292	1	2	-1	1	\N	2017-09-01	31.53	6883966fd8f918a4aa29be29d2c386fb	2020-10-23 22:40:32.55022	2020-10-23 22:40:32.55022
3293	5	4	13	2	\N	2017-09-01	-10.16	fb6e612cbc5b55c03054170e271d0437	2020-10-23 22:40:32.552331	2020-10-23 22:40:32.552331
3294	2	1	-1	2	\N	2017-09-01	-5.78	07871915a8107172b3b5dc15a6574ad3	2020-10-23 22:40:32.554331	2020-10-23 22:40:32.554331
3295	2	1	-1	2	\N	2017-09-01	-6.85	456e25ca2b585673c5aaeb40eba16d56	2020-10-23 22:40:32.556392	2020-10-23 22:40:32.556392
3296	5	1	-1	2	\N	2017-09-01	-18.44	28b49b2bb14fe8fbbebeb5a70ed6ea50	2020-10-23 22:40:32.558405	2020-10-23 22:40:32.558405
3297	2	10	54	3	\N	2017-09-01	-1000.00	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:32.560374	2020-10-23 22:40:32.560374
3298	6	10	54	4	\N	2017-09-01	1000.00	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:32.562226	2020-10-23 22:40:32.562226
3299	5	1	-1	2	\N	2017-09-01	-17.55	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.56416	2020-10-23 22:40:32.56416
3300	5	1	-1	2	\N	2017-09-02	-11.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.566309	2020-10-23 22:40:32.566309
3301	5	2	-1	4	\N	2017-09-01	27.70	6f8a28be5f158752eba976d9a69f6abb	2020-10-23 22:40:32.567793	2020-10-23 22:40:32.567793
3302	5	1	-1	2	\N	2017-09-02	-139.02	ee7733547fbb26cdfeb9b6a4f84231b4	2020-10-23 22:40:32.569394	2020-10-23 22:40:32.569394
3303	5	1	-1	2	\N	2017-09-02	-17.40	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.570696	2020-10-23 22:40:32.570696
3304	5	4	-1	2	\N	2017-09-02	-112.00	2a4a83ce605eaf2e7f73e1ff973a29c9	2020-10-23 22:40:32.572057	2020-10-23 22:40:32.572057
3305	5	1	11	2	\N	2017-09-04	-4.59	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:40:32.574188	2020-10-23 22:40:32.574188
3306	5	3	-1	2	\N	2017-09-04	-9.34	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:32.575592	2020-10-23 22:40:32.575592
3307	1	1	-1	2	\N	2017-09-06	-2.20	ad71b715717f7e4757565373c1a88e1f	2020-10-23 22:40:32.576982	2020-10-23 22:40:32.576982
3308	5	1	-1	2	\N	2017-09-06	-6.84	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:32.578468	2020-10-23 22:40:32.578468
3309	5	10	54	4	\N	2017-09-06	5500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:32.579771	2020-10-23 22:40:32.579771
3310	5	10	54	3	\N	2017-09-07	-2500.00	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:40:32.581068	2020-10-23 22:40:32.581068
3311	5	10	54	3	\N	2017-09-06	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:32.582631	2020-10-23 22:40:32.582631
3312	5	10	54	3	\N	2017-09-06	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:32.583844	2020-10-23 22:40:32.583844
3313	2	9	-1	2	\N	2017-09-06	-300.00	b56c3e19f5a9156859dc89cdf30afc1b	2020-10-23 22:40:32.585723	2020-10-23 22:40:32.585723
3314	2	9	48	2	\N	2017-09-06	-89.90	cb4e48b5365723ef2c49bbf8fdd8a0a7	2020-10-23 22:40:32.587022	2020-10-23 22:40:32.587022
3315	2	9	48	2	\N	2017-09-06	-20.00	11f298496dab43d2acd47997670ee01e	2020-10-23 22:40:32.588493	2020-10-23 22:40:32.588493
3316	2	9	48	2	\N	2017-09-06	-129.92	28a40486970ef037b8cc878b226ccdeb	2020-10-23 22:40:32.590029	2020-10-23 22:40:32.590029
3317	1	1	-1	2	\N	2017-09-06	-12.79	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.591982	2020-10-23 22:40:32.591982
3318	1	7	36	2	\N	2017-09-07	-48.50	0bed3765bd22a7103796f60e28b0ea68	2020-10-23 22:40:32.593309	2020-10-23 22:40:32.593309
3319	1	1	-1	2	\N	2017-09-07	-11.08	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.594672	2020-10-23 22:40:32.594672
3320	1	1	-1	2	\N	2017-09-08	-16.40	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.596024	2020-10-23 22:40:32.596024
3321	2	9	48	2	\N	2017-09-08	-14.99	f7e6c85504ce6e82442c770f7c8606f0	2020-10-23 22:40:32.597286	2020-10-23 22:40:32.597286
3322	5	9	48	2	\N	2017-09-08	-156.30	131fb12b08bbc3ab3772e76cca59a3f3	2020-10-23 22:40:32.598601	2020-10-23 22:40:32.598601
3323	5	1	-1	2	\N	2017-09-08	-39.89	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:40:32.599992	2020-10-23 22:40:32.599992
3324	5	8	43	2	\N	2017-09-09	-217.71	a6cb53f898763c410cf00175c3deedeb	2020-10-23 22:40:32.601453	2020-10-23 22:40:32.601453
3325	5	8	43	2	\N	2017-09-10	-222.66	e0f1a4afdc30e0724bd9be57355de70e	2020-10-23 22:40:32.60268	2020-10-23 22:40:32.60268
3326	5	8	43	2	\N	2017-09-09	-36.20	3d8e28caf901313a554cebc7d32e67e5	2020-10-23 22:40:32.603919	2020-10-23 22:40:32.603919
3327	1	1	-1	2	\N	2017-09-10	-17.60	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:40:32.605254	2020-10-23 22:40:32.605254
3328	1	1	11	2	\N	2017-09-09	-5.99	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:40:32.606551	2020-10-23 22:40:32.606551
3329	5	1	-1	2	\N	2017-09-10	-7.90	758215d106c39f7aa9ff0e2ede452b10	2020-10-23 22:40:32.607757	2020-10-23 22:40:32.607757
3330	5	3	-1	2	\N	2017-09-10	-22.10	c3e878e27f52e2a57ace4d9a76fd9acf	2020-10-23 22:40:32.608992	2020-10-23 22:40:32.608992
3331	5	1	-1	2	\N	2017-09-10	-58.84	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.610505	2020-10-23 22:40:32.610505
3332	5	7	30	2	\N	2017-09-10	-857.80	49c9adb18e44be0711a94e827042f630	2020-10-23 22:40:32.612802	2020-10-23 22:40:32.612802
3333	5	10	54	4	\N	2017-09-11	2500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:32.614669	2020-10-23 22:40:32.614669
3334	5	10	54	4	\N	2017-09-11	2500.00	da8d64a328bacb851402b21e1a3227f4	2020-10-23 22:40:32.616332	2020-10-23 22:40:32.616332
3335	6	10	54	3	\N	2017-09-11	-2500.00	da8d64a328bacb851402b21e1a3227f4	2020-10-23 22:40:32.61763	2020-10-23 22:40:32.61763
3336	1	10	54	4	\N	2017-09-11	200.00	86450167edd1be996127491b0057db7a	2020-10-23 22:40:32.619065	2020-10-23 22:40:32.619065
3337	5	10	54	3	\N	2017-09-11	-700.00	e2837a5b2d626abb4d186b41195574ff	2020-10-23 22:40:32.621323	2020-10-23 22:40:32.621323
3338	5	7	30	2	\N	2017-09-12	-14.00	626ba6666b7942411018af8b5d54602f	2020-10-23 22:40:32.622944	2020-10-23 22:40:32.622944
3339	5	7	30	2	\N	2017-09-12	-41.40	73885e2ab36d685507b9e34be2444389	2020-10-23 22:40:32.625002	2020-10-23 22:40:32.625002
3340	5	1	-1	2	\N	2017-09-12	-28.01	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:32.626335	2020-10-23 22:40:32.626335
3341	5	7	30	2	\N	2017-09-12	-32.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:32.627624	2020-10-23 22:40:32.627624
3342	5	7	30	2	\N	2017-09-12	-30.00	79ec16df80b57696a03bb364410061f3	2020-10-23 22:40:32.628827	2020-10-23 22:40:32.628827
3343	5	1	-1	2	\N	2017-09-11	-119.53	801886d15a07a0f786169c3fa4c54b34	2020-10-23 22:40:32.630032	2020-10-23 22:40:32.630032
3344	1	7	36	2	\N	2017-09-13	-59.80	72c99f8ceac6fefe190e9df14bc38973	2020-10-23 22:40:32.631351	2020-10-23 22:40:32.631351
3345	5	7	30	2	\N	2017-09-13	-13.00	ce2a591fe40223a6be837462f79caf3c	2020-10-23 22:40:32.632634	2020-10-23 22:40:32.632634
3346	5	7	30	2	\N	2017-09-13	-25.44	0320df6b7344edcfeb510595dff01338	2020-10-23 22:40:32.63407	2020-10-23 22:40:32.63407
3347	5	7	30	2	\N	2017-09-13	-5.50	8cdcda79a8dc66aa6c711c9a000b0ac0	2020-10-23 22:40:32.635817	2020-10-23 22:40:32.635817
3348	1	9	49	2	\N	2017-09-13	-288.00	185c29dc24325934ee377cfda20e414c	2020-10-23 22:40:32.637756	2020-10-23 22:40:32.637756
3349	5	7	30	2	\N	2017-09-15	-75.00	57bbcb50322f47702de79937c482ba20	2020-10-23 22:40:32.63928	2020-10-23 22:40:32.63928
3350	5	1	-1	2	\N	2017-09-15	-51.75	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:32.641127	2020-10-23 22:40:32.641127
3351	5	1	-1	2	\N	2017-09-14	-95.49	67d16d00201083a2b118dd5128dd6f59	2020-10-23 22:40:32.642341	2020-10-23 22:40:32.642341
3352	5	1	-1	2	\N	2017-09-14	-8.20	d37fa31bd432cd22ed69681a7e16cf0e	2020-10-23 22:40:32.643492	2020-10-23 22:40:32.643492
3353	5	7	30	2	\N	2017-09-14	-12.00	02c43aeb26e1db88c47c4c6cf8001144	2020-10-23 22:40:32.644729	2020-10-23 22:40:32.644729
3354	5	7	30	2	\N	2017-09-14	-13.50	5f7478e5278270a0851340d2deda3943	2020-10-23 22:40:32.646127	2020-10-23 22:40:32.646127
3355	5	8	43	2	\N	2017-09-16	-225.53	298d14571b7620c3f1a16121ddf44952	2020-10-23 22:40:32.647463	2020-10-23 22:40:32.647463
3356	5	1	-1	2	\N	2017-09-16	-7.28	9e75d6afe46ed5b11890591b8b2e76a5	2020-10-23 22:40:32.648752	2020-10-23 22:40:32.648752
3357	5	8	43	2	\N	2017-09-16	-36.20	d707329bece455a462b58ce00d1194c9	2020-10-23 22:40:32.650097	2020-10-23 22:40:32.650097
3358	5	1	-1	2	\N	2017-09-17	-17.60	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:32.651418	2020-10-23 22:40:32.651418
3359	5	1	-1	2	\N	2017-09-17	-16.08	ce8a9ea1be6239e906e9f5393a9f9ea5	2020-10-23 22:40:32.652696	2020-10-23 22:40:32.652696
3360	5	1	-1	2	\N	2017-09-17	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:32.65398	2020-10-23 22:40:32.65398
3361	5	1	-1	2	\N	2017-09-17	-80.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.655456	2020-10-23 22:40:32.655456
3362	1	5	21	2	\N	2017-09-18	-44.96	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:40:32.658054	2020-10-23 22:40:32.658054
3363	5	4	18	2	\N	2017-09-18	-29.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:32.659434	2020-10-23 22:40:32.659434
3364	5	8	43	2	\N	2017-09-18	-38.99	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:32.66081	2020-10-23 22:40:32.66081
3365	1	3	-1	2	\N	2017-09-19	-35.00	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:40:32.662279	2020-10-23 22:40:32.662279
3366	5	4	18	2	\N	2017-09-19	-29.00	335628b154666834079b64e2357c0cfb	2020-10-23 22:40:32.663624	2020-10-23 22:40:32.663624
3367	2	4	16	2	\N	2017-09-20	-29.90	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:32.664979	2020-10-23 22:40:32.664979
3368	5	9	48	2	\N	2017-09-19	-79.00	b804e36d2604740efb7817fc48c5c35a	2020-10-23 22:40:32.666617	2020-10-23 22:40:32.666617
3369	5	9	48	2	\N	2017-09-19	-156.30	ee2b121deeb9a112ad842be32a9435e4	2020-10-23 22:40:32.667907	2020-10-23 22:40:32.667907
3370	2	4	18	2	\N	2017-09-20	-58.00	46e7d8a9218ab3c3b572492c82786d28	2020-10-23 22:40:32.669283	2020-10-23 22:40:32.669283
3371	5	4	18	1	\N	2017-09-20	58.00	46e7d8a9218ab3c3b572492c82786d28	2020-10-23 22:40:32.670472	2020-10-23 22:40:32.670472
3372	1	9	51	2	\N	2017-09-20	-20.00	c2ce36d19e6cf7111044dd934ee1cf2a	2020-10-23 22:40:32.671628	2020-10-23 22:40:32.671628
3373	1	1	11	2	\N	2017-09-20	-7.37	b534ba68236ba543ae44b22bd110a1d6	2020-10-23 22:40:32.672737	2020-10-23 22:40:32.672737
3374	1	7	31	2	\N	2017-09-21	-45.00	a861405761149022ffe871c0967b2412	2020-10-23 22:40:32.674256	2020-10-23 22:40:32.674256
3375	5	5	23	2	\N	2017-09-21	-21.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:32.675636	2020-10-23 22:40:32.675636
3376	1	1	-1	2	\N	2017-09-22	-2.20	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:32.676991	2020-10-23 22:40:32.676991
3377	1	1	11	2	\N	2017-09-22	-23.00	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:32.678318	2020-10-23 22:40:32.678318
3378	5	1	-1	2	\N	2017-09-23	-360.13	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.679718	2020-10-23 22:40:32.679718
3379	5	4	16	2	\N	2017-09-26	-49.90	e651ac7d74129f29735687d13e2da0f7	2020-10-23 22:40:32.681245	2020-10-23 22:40:32.681245
3380	5	7	30	2	\N	2017-09-27	-150.00	f3214b371d7ce3e5487ea4a37a50b643	2020-10-23 22:40:32.682528	2020-10-23 22:40:32.682528
3381	1	4	18	2	\N	2017-09-27	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:32.68371	2020-10-23 22:40:32.68371
3382	5	4	15	2	\N	2017-09-28	-115.96	64771a8f2e4276f55219ad0e3faa4140	2020-10-23 22:40:32.684903	2020-10-23 22:40:32.684903
3383	5	1	-1	2	\N	2017-09-28	-13.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.686116	2020-10-23 22:40:32.686116
3384	1	2	3	1	\N	2017-09-28	8048.73	e70866c5cefff90781fc1a90804ad49a	2020-10-23 22:40:32.687585	2020-10-23 22:40:32.687585
3385	1	10	54	3	\N	2017-09-29	-500.00	08d5c38bebb9c7b13b9d3abb894deb2b	2020-10-23 22:40:32.688817	2020-10-23 22:40:32.688817
3386	5	1	-1	2	\N	2017-09-29	-93.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.690627	2020-10-23 22:40:32.690627
3387	1	1	-1	2	\N	2017-09-30	-20.50	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:32.691893	2020-10-23 22:40:32.691893
3388	1	2	-1	4	\N	2017-10-01	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:32.693014	2020-10-23 22:40:32.693014
3389	1	9	51	2	\N	2017-10-01	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:32.694226	2020-10-23 22:40:32.694226
3390	6	10	55	1	\N	2017-09-30	97.60	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:32.695286	2020-10-23 22:40:32.695286
3391	1	9	-1	2	\N	2017-10-01	-7.10	c4258e0f536604c99f79545e930d5a22	2020-10-23 22:40:32.696462	2020-10-23 22:40:32.696462
3392	5	2	-1	1	\N	2017-10-01	70.90	c4258e0f536604c99f79545e930d5a22	2020-10-23 22:40:32.697557	2020-10-23 22:40:32.697557
3393	1	9	49	2	\N	2017-10-01	-150.00	272dec0a14ee301b59ec3ec6bff6ec3e	2020-10-23 22:40:32.698879	2020-10-23 22:40:32.698879
3394	1	10	54	3	\N	2017-10-02	-7000.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:32.700401	2020-10-23 22:40:32.700401
3395	2	2	3	1	\N	2017-10-01	5720.58	ca46c1b9512a7a8315fa3c5a946e8265	2020-10-23 22:40:32.701798	2020-10-23 22:40:32.701798
3396	2	9	48	2	\N	2017-10-02	-10.00	51899e8e7e59413bbffce38d3664b184	2020-10-23 22:40:32.703376	2020-10-23 22:40:32.703376
3397	2	9	48	2	\N	2017-10-02	-33.69	56272a9b00af450de3a584868e9fcc37	2020-10-23 22:40:32.7049	2020-10-23 22:40:32.7049
3398	2	6	27	2	\N	2017-10-02	-126.89	9de6d14fff9806d4bcd1ef555be766cd	2020-10-23 22:40:32.706609	2020-10-23 22:40:32.706609
3399	2	9	48	2	\N	2017-10-02	-37.14	56272a9b00af450de3a584868e9fcc37	2020-10-23 22:40:32.708307	2020-10-23 22:40:32.708307
3400	2	9	48	2	\N	2017-10-02	-20.81	56272a9b00af450de3a584868e9fcc37	2020-10-23 22:40:32.709899	2020-10-23 22:40:32.709899
3401	2	9	48	2	\N	2017-10-02	-83.66	502e4a16930e414107ee22b6198c578f	2020-10-23 22:40:32.7112	2020-10-23 22:40:32.7112
3402	2	10	54	3	\N	2017-10-02	-1500.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:32.712584	2020-10-23 22:40:32.712584
3403	5	10	54	4	\N	2017-10-02	1500.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:32.714045	2020-10-23 22:40:32.714045
3404	2	10	54	3	\N	2017-10-02	-2000.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:32.715412	2020-10-23 22:40:32.715412
3405	6	10	54	4	\N	2017-10-02	2000.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:32.716812	2020-10-23 22:40:32.716812
3406	2	9	47	2	\N	2017-10-02	-60.00	69c858fe2c9e6417065842e924f5340e	2020-10-23 22:40:32.718397	2020-10-23 22:40:32.718397
3407	2	5	25	2	\N	2017-10-02	-40.00	539fd53b59e3bb12d203f45a912eeaf2	2020-10-23 22:40:32.719859	2020-10-23 22:40:32.719859
3408	2	10	54	3	\N	2017-10-08	-300.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:32.721465	2020-10-23 22:40:32.721465
3409	4	10	54	4	\N	2017-10-08	300.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:32.722883	2020-10-23 22:40:32.722883
3410	5	4	-1	2	\N	2017-10-02	-590.00	0e6b5b70ba9fded82b7fe546d882d062	2020-10-23 22:40:32.724451	2020-10-23 22:40:32.724451
3411	5	4	13	2	\N	2017-10-02	-391.79	1772c7ee061e403943a88f11bcef8149	2020-10-23 22:40:32.725853	2020-10-23 22:40:32.725853
3412	5	4	15	2	\N	2017-10-02	-122.89	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:40:32.727115	2020-10-23 22:40:32.727115
3413	2	9	-1	2	\N	2017-10-03	-148.90	1906b463e2d9877bc8968d55f5c094a2	2020-10-23 22:40:32.728478	2020-10-23 22:40:32.728478
3414	5	1	-1	2	\N	2017-10-03	-11.48	23b85ebbbd599ca5f2ea0a45a118d7d7	2020-10-23 22:40:32.729904	2020-10-23 22:40:32.729904
3415	1	8	41	2	\N	2017-10-03	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:32.731346	2020-10-23 22:40:32.731346
3416	5	7	30	2	\N	2017-10-04	-200.00	0e2505027d08ccc418fc928962e715c6	2020-10-23 22:40:32.73283	2020-10-23 22:40:32.73283
3417	2	9	-1	2	\N	2017-10-04	-72.00	6c9882bbac1c7093bd25041881277658	2020-10-23 22:40:32.734471	2020-10-23 22:40:32.734471
3418	6	10	54	3	\N	2017-10-04	-10000.00	1eb3aa055e74efd118825142f6ee3e2c	2020-10-23 22:40:32.735774	2020-10-23 22:40:32.735774
3419	5	10	54	4	\N	2017-10-04	10000.00	1eb3aa055e74efd118825142f6ee3e2c	2020-10-23 22:40:32.73706	2020-10-23 22:40:32.73706
3420	5	10	54	3	\N	2017-10-04	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:32.738469	2020-10-23 22:40:32.738469
3421	5	10	54	3	\N	2017-10-04	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:32.740641	2020-10-23 22:40:32.740641
3422	5	1	-1	2	\N	2017-10-04	-99.00	d66f248b690954fd2b84b58193d1391c	2020-10-23 22:40:32.742121	2020-10-23 22:40:32.742121
3423	5	10	54	4	\N	2017-10-04	5500.00	44bf7b9933876f77884a0ab47dac319a	2020-10-23 22:40:32.743382	2020-10-23 22:40:32.743382
3424	1	5	25	2	\N	2017-10-07	-40.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:32.744623	2020-10-23 22:40:32.744623
3425	5	1	-1	2	\N	2017-10-07	-8.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.746043	2020-10-23 22:40:32.746043
3426	5	1	-1	2	\N	2017-10-07	-10.16	6dd909835db21a2c776707daeb646070	2020-10-23 22:40:32.747434	2020-10-23 22:40:32.747434
3427	5	1	-1	2	\N	2017-10-07	-67.34	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:32.748843	2020-10-23 22:40:32.748843
3428	5	10	54	3	\N	2017-10-09	-2500.00	82cec96096d4281b7c95cd7e74623496	2020-10-23 22:40:32.750612	2020-10-23 22:40:32.750612
3429	5	1	-1	2	\N	2017-10-08	-59.02	a8abb4bb284b5b27aa7cb790dc20f80b	2020-10-23 22:40:32.751986	2020-10-23 22:40:32.751986
3430	2	1	-1	1	\N	2017-10-08	59.02	fcbb8a6c7a6eadb3f05b6be8c70e8064	2020-10-23 22:40:32.753318	2020-10-23 22:40:32.753318
3431	2	9	47	2	\N	2017-10-08	-50.00	74b2c41c45b3e51cf6a19655d028c75c	2020-10-23 22:40:32.754616	2020-10-23 22:40:32.754616
3432	5	1	-1	2	\N	2017-10-09	-68.62	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:32.756209	2020-10-23 22:40:32.756209
3433	1	1	-1	2	\N	2017-10-10	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:32.757809	2020-10-23 22:40:32.757809
3434	1	7	36	2	\N	2017-10-10	-58.03	6b9abf067124bb08d034e3fdad22d0fa	2020-10-23 22:40:32.759585	2020-10-23 22:40:32.759585
3435	5	10	54	4	\N	2017-10-11	2500.00	b3e2026d10e46df62f0d1cdfa85d7aaa	2020-10-23 22:40:32.76097	2020-10-23 22:40:32.76097
3436	1	1	-1	2	\N	2017-10-11	-16.15	ba3866600c3540f67c1e9575e213be0a	2020-10-23 22:40:32.762311	2020-10-23 22:40:32.762311
3437	6	10	54	4	\N	2017-10-11	1800.00	599f127bd63e32d6fd5457f9f1fa1e14	2020-10-23 22:40:32.763732	2020-10-23 22:40:32.763732
3438	1	10	54	4	\N	2017-10-11	200.00	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:32.765142	2020-10-23 22:40:32.765142
3439	5	10	54	3	\N	2017-10-11	-2500.00	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:32.76637	2020-10-23 22:40:32.76637
3440	1	1	-1	2	\N	2017-10-13	-2.20	df877f3865752637daa540ea9cbc474f	2020-10-23 22:40:32.767512	2020-10-23 22:40:32.767512
3441	1	7	31	2	\N	2017-10-12	-27.00	5ff832d9bca8241d653279756f3ccd11	2020-10-23 22:40:32.768812	2020-10-23 22:40:32.768812
3442	1	1	-1	2	\N	2017-10-13	-17.64	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:32.770206	2020-10-23 22:40:32.770206
3443	1	8	44	2	\N	2017-10-12	-20.96	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:32.771534	2020-10-23 22:40:32.771534
3444	1	1	11	2	\N	2017-10-12	-12.00	4ae8b31072fc84173510878e209b5f7d	2020-10-23 22:40:32.773452	2020-10-23 22:40:32.773452
3445	5	1	-1	2	\N	2017-10-13	-3.90	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:40:32.775118	2020-10-23 22:40:32.775118
3446	1	9	48	2	\N	2017-10-13	-15.00	a0950d25a0593f48090ead2dc84abd77	2020-10-23 22:40:32.776456	2020-10-23 22:40:32.776456
3447	5	5	23	2	\N	2017-10-14	-19.99	53c535a8b8a2c8bb670d136b82e73f99	2020-10-23 22:40:32.778032	2020-10-23 22:40:32.778032
3448	5	1	-1	2	\N	2017-10-14	-30.68	3f4141dd78660e916ddb828787cf6ee6	2020-10-23 22:40:32.780007	2020-10-23 22:40:32.780007
3449	5	1	-1	2	\N	2017-10-15	-0.59	f29c21d4897f78948b91f03172341b7b	2020-10-23 22:40:32.78167	2020-10-23 22:40:32.78167
3450	5	1	-1	2	\N	2017-10-14	-79.92	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:32.783024	2020-10-23 22:40:32.783024
3451	5	1	-1	2	\N	2017-10-14	-12.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.784716	2020-10-23 22:40:32.784716
3452	1	2	-1	3	\N	2017-10-14	-19.70	ad0e5e531c8bc838a33cf6d1d0c789d3	2020-10-23 22:40:32.786079	2020-10-23 22:40:32.786079
3453	1	2	-1	4	\N	2017-10-14	19.70	d6ce0af67d10d5d0f73bd7744a15d3cb	2020-10-23 22:40:32.787399	2020-10-23 22:40:32.787399
3454	5	2	-1	4	\N	2017-10-14	19.70	d6ce0af67d10d5d0f73bd7744a15d3cb	2020-10-23 22:40:32.788899	2020-10-23 22:40:32.788899
3455	2	5	21	2	\N	2017-10-14	-80.80	31b33144106f9699c5d6e65d8a88f7d9	2020-10-23 22:40:32.790623	2020-10-23 22:40:32.790623
3456	2	5	26	2	\N	2017-10-14	-8.58	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:32.791971	2020-10-23 22:40:32.791971
3457	2	3	-1	2	\N	2017-10-14	-16.00	88ff3c5e7abe5c365fc714330a475618	2020-10-23 22:40:32.793203	2020-10-23 22:40:32.793203
3458	2	8	41	2	\N	2017-10-14	-5.60	f335e9f0e59921511c33549aee7cc1e5	2020-10-23 22:40:32.794565	2020-10-23 22:40:32.794565
3459	2	8	41	2	\N	2017-10-14	-50.00	02722e52b2748a68e41da1461253bb52	2020-10-23 22:40:32.795798	2020-10-23 22:40:32.795798
3460	2	9	-1	2	\N	2017-10-14	-200.00	8c2aa185e4d169c94c7cdc984d7db036	2020-10-23 22:40:32.797126	2020-10-23 22:40:32.797126
3461	2	9	-1	2	\N	2017-10-14	-200.00	5705e1164a8394aace6018e27d20d237	2020-10-23 22:40:32.798852	2020-10-23 22:40:32.798852
3462	2	9	-1	1	\N	2017-10-15	12669.74	5eced9718393c2cb55df6759c5084de2	2020-10-23 22:40:32.800192	2020-10-23 22:40:32.800192
3463	2	9	-1	2	\N	2017-10-15	-10000.00	e0cf1f47118daebc5b16269099ad7347	2020-10-23 22:40:32.801377	2020-10-23 22:40:32.801377
3464	2	9	-1	2	\N	2017-10-16	-688.63	e0cf1f47118daebc5b16269099ad7347	2020-10-23 22:40:32.802555	2020-10-23 22:40:32.802555
3465	5	5	26	2	\N	2017-10-17	-18.55	d55a38f8a6bbece5b3278908f1e09a11	2020-10-23 22:40:32.803918	2020-10-23 22:40:32.803918
3466	1	1	11	2	\N	2017-10-19	-6.35	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:40:32.805117	2020-10-23 22:40:32.805117
3467	1	1	-1	2	\N	2017-10-19	-4.40	a43c7f3d9d0f4a718450633e3765b67c	2020-10-23 22:40:32.806542	2020-10-23 22:40:32.806542
3468	5	1	-1	2	\N	2017-10-21	-6.50	a041fd74f6e07754fe6b3ba46e53bda2	2020-10-23 22:40:32.808112	2020-10-23 22:40:32.808112
3469	5	1	-1	2	\N	2017-10-21	-17.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.809448	2020-10-23 22:40:32.809448
3470	5	1	-1	2	\N	2017-10-21	-9.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:32.810876	2020-10-23 22:40:32.810876
3471	5	1	-1	2	\N	2017-10-21	-159.18	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:32.812315	2020-10-23 22:40:32.812315
3472	5	8	43	2	\N	2017-10-21	-226.26	d1c38a09acc34845c6be3a127a5aacaf	2020-10-23 22:40:32.813697	2020-10-23 22:40:32.813697
3473	2	4	16	2	\N	2017-10-23	-19.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:40:32.815225	2020-10-23 22:40:32.815225
3474	5	1	11	2	\N	2017-10-25	-7.59	e820a45f1dfc7b95282d10b6087e11c0	2020-10-23 22:40:32.816566	2020-10-23 22:40:32.816566
3475	5	5	23	2	\N	2017-10-25	-22.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:32.817906	2020-10-23 22:40:32.817906
3476	5	8	43	2	\N	2017-10-25	-69.00	013d407166ec4fa56eb1e1f8cbe183b9	2020-10-23 22:40:32.819149	2020-10-23 22:40:32.819149
3477	1	1	11	2	\N	2017-10-27	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:32.820672	2020-10-23 22:40:32.820672
3478	5	1	-1	2	\N	2017-10-28	-19.59	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:32.821995	2020-10-23 22:40:32.821995
3479	5	1	-1	2	\N	2017-10-26	-15.26	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:32.82396	2020-10-23 22:40:32.82396
3480	5	8	43	2	\N	2017-10-29	-87.60	d1f491a404d6854880943e5c3cd9ca25	2020-10-23 22:40:32.825815	2020-10-23 22:40:32.825815
3481	1	1	-1	2	\N	2017-10-30	-9.69	ba3866600c3540f67c1e9575e213be0a	2020-10-23 22:40:32.82739	2020-10-23 22:40:32.82739
3482	5	1	-1	2	\N	2017-10-30	-18.23	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.82881	2020-10-23 22:40:32.82881
3483	5	1	-1	2	\N	2017-10-30	-76.88	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:32.8301	2020-10-23 22:40:32.8301
3484	1	1	11	2	\N	2017-10-31	-2.00	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:32.83133	2020-10-23 22:40:32.83133
3485	1	1	-1	2	\N	2017-10-31	-15.49	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.832553	2020-10-23 22:40:32.832553
3486	1	1	-1	2	\N	2017-10-30	-13.97	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.834055	2020-10-23 22:40:32.834055
3487	1	2	3	1	\N	2017-10-30	8722.94	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:40:32.835434	2020-10-23 22:40:32.835434
3488	5	1	-1	2	\N	2017-10-31	-16.49	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.83676	2020-10-23 22:40:32.83676
3489	5	7	33	3	\N	2017-10-31	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:32.838153	2020-10-23 22:40:32.838153
3490	1	2	-1	4	\N	2017-10-31	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:32.839589	2020-10-23 22:40:32.839589
3491	1	10	54	3	\N	2017-10-31	-500.00	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:40:32.841111	2020-10-23 22:40:32.841111
3492	2	9	47	2	\N	2017-10-23	-100.00	69746dd9b05454baef427877a7676da1	2020-10-23 22:40:32.842431	2020-10-23 22:40:32.842431
3493	2	2	3	1	\N	2017-10-31	5720.58	489d3d6c15d5362448686b2b01172d32	2020-10-23 22:40:32.843769	2020-10-23 22:40:32.843769
3494	2	10	54	2	\N	2017-10-31	-1500.00	a39a9463ee52082ac1a66be22c074763	2020-10-23 22:40:32.845054	2020-10-23 22:40:32.845054
3495	5	10	54	1	\N	2017-10-31	1500.00	a39a9463ee52082ac1a66be22c074763	2020-10-23 22:40:32.846281	2020-10-23 22:40:32.846281
3496	2	10	54	2	\N	2017-10-31	-2000.00	975eb15e3054381f30594fd6542d4912	2020-10-23 22:40:32.847594	2020-10-23 22:40:32.847594
3497	5	10	54	1	\N	2017-10-31	2000.00	975eb15e3054381f30594fd6542d4912	2020-10-23 22:40:32.848986	2020-10-23 22:40:32.848986
3498	2	4	18	2	\N	2017-10-31	-29.00	f830ba4cee864c087fac4c3a5abb01ab	2020-10-23 22:40:32.850242	2020-10-23 22:40:32.850242
3499	5	4	16	2	\N	2017-10-31	-49.90	44bf7b9933876f77884a0ab47dac319a	2020-10-23 22:40:32.851574	2020-10-23 22:40:32.851574
3500	5	1	-1	2	\N	2017-10-31	-8.24	06997f04a7db92466a2baa6ebc8b872d	2020-10-23 22:40:32.853123	2020-10-23 22:40:32.853123
3501	5	4	13	2	\N	2017-10-31	-391.79	4af8312f6c544239b2f0346cb1ddb223	2020-10-23 22:40:32.854386	2020-10-23 22:40:32.854386
3502	5	4	-1	2	\N	2017-10-31	-590.00	e4197929aa122bf1b322269386d7ccfe	2020-10-23 22:40:32.855726	2020-10-23 22:40:32.855726
3503	5	4	15	2	\N	2017-10-31	-133.16	0977c8a9495b634a48a90306338cdb85	2020-10-23 22:40:32.857452	2020-10-23 22:40:32.857452
3504	5	4	14	2	\N	2017-10-31	-170.49	b64eab8ce39e013604e243089c687e4f	2020-10-23 22:40:32.858701	2020-10-23 22:40:32.858701
3505	5	10	55	1	\N	2017-10-31	93.74	4d439535a3065efd10d37a80209d14ee	2020-10-23 22:40:32.859915	2020-10-23 22:40:32.859915
3506	5	9	-1	2	\N	2017-11-01	-15.80	019a75e5ea6e1f30fbfe5a527779c859	2020-10-23 22:40:32.861231	2020-10-23 22:40:32.861231
3507	1	2	-1	1	\N	2017-11-01	21.47	019a75e5ea6e1f30fbfe5a527779c859	2020-10-23 22:40:32.862617	2020-10-23 22:40:32.862617
3508	1	9	49	3	\N	2017-11-01	-102.00	272dec0a14ee301b59ec3ec6bff6ec3e	2020-10-23 22:40:32.864007	2020-10-23 22:40:32.864007
3509	1	8	41	2	\N	2017-11-01	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:40:32.865239	2020-10-23 22:40:32.865239
3510	1	10	54	3	\N	2017-11-02	-7000.00	a3869b8ec554d1205194a64ba64e9858	2020-10-23 22:40:32.866504	2020-10-23 22:40:32.866504
3511	2	10	54	3	\N	2017-11-01	-700.00	7ff570da3b2ba4814f4c3c330bce4c56	2020-10-23 22:40:32.867778	2020-10-23 22:40:32.867778
3512	4	10	54	4	\N	2017-11-01	700.00	7ff570da3b2ba4814f4c3c330bce4c56	2020-10-23 22:40:32.869076	2020-10-23 22:40:32.869076
3513	2	2	-1	1	\N	2017-11-01	350.00	ab3097f1abb246275a855ea1531ac311	2020-10-23 22:40:32.870809	2020-10-23 22:40:32.870809
3514	5	4	-1	2	\N	2017-11-02	-198.00	d1c93c5bd481bd3d366c0407c60902c0	2020-10-23 22:40:32.872401	2020-10-23 22:40:32.872401
3515	1	9	48	2	\N	2017-11-02	-32.00	719b75424fd8dfc276c4da51ec8306f0	2020-10-23 22:40:32.874235	2020-10-23 22:40:32.874235
3516	1	4	18	2	\N	2017-11-02	-29.00	cd2cbd0a7d28268acfa68c32fcd6bcd6	2020-10-23 22:40:32.875591	2020-10-23 22:40:32.875591
3517	5	1	-1	2	\N	2017-11-02	-3.97	fb6e612cbc5b55c03054170e271d0437	2020-10-23 22:40:32.877069	2020-10-23 22:40:32.877069
3518	5	1	-1	2	\N	2017-11-02	-56.67	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.878414	2020-10-23 22:40:32.878414
3519	5	1	-1	2	\N	2017-11-02	-109.40	1e4ca0db331b0919fbb70c96514764f5	2020-10-23 22:40:32.879839	2020-10-23 22:40:32.879839
3520	1	3	-1	2	\N	2017-11-03	-79.99	05f971b5ec196b8c65b75d2ef8267331	2020-10-23 22:40:32.881112	2020-10-23 22:40:32.881112
3521	5	1	-1	2	\N	2017-11-04	-15.68	bf21751ba657f55e1c6f7f56fe5f4149	2020-10-23 22:40:32.882368	2020-10-23 22:40:32.882368
3522	5	1	-1	2	\N	2017-11-04	-83.71	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:32.883602	2020-10-23 22:40:32.883602
3523	1	9	48	2	\N	2017-11-04	-25.00	a0950d25a0593f48090ead2dc84abd77	2020-10-23 22:40:32.884775	2020-10-23 22:40:32.884775
3524	5	1	-1	2	\N	2017-11-04	-10.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.885955	2020-10-23 22:40:32.885955
3525	5	1	-1	2	\N	2017-11-04	-6.00	a041fd74f6e07754fe6b3ba46e53bda2	2020-10-23 22:40:32.887141	2020-10-23 22:40:32.887141
3526	5	1	-1	2	\N	2017-11-03	-21.02	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:32.888405	2020-10-23 22:40:32.888405
3527	2	3	-1	2	\N	2017-11-03	-21.48	5e9f92a01c986bafcabbafd145520b13	2020-10-23 22:40:32.889884	2020-10-23 22:40:32.889884
3528	5	1	-1	2	\N	2017-11-04	-10.80	d4b47562a5f5daddc52c7555d452042f	2020-10-23 22:40:32.891503	2020-10-23 22:40:32.891503
3529	5	1	-1	2	\N	2017-11-04	-21.98	0537fb40a68c18da59a35c2bfe1ca554	2020-10-23 22:40:32.893005	2020-10-23 22:40:32.893005
3530	2	5	21	2	\N	2017-11-08	-29.99	33a190996c7d195c4f7726293cbb44b0	2020-10-23 22:40:32.894739	2020-10-23 22:40:32.894739
3531	2	9	48	2	\N	2017-11-08	-89.94	ae2cef1cbe80fb30a86d4ffd2c2273c1	2020-10-23 22:40:32.896337	2020-10-23 22:40:32.896337
3532	2	6	27	2	\N	2017-11-08	-139.00	a84de47e9e92ace446d9eaf9b2e56ef8	2020-10-23 22:40:32.897513	2020-10-23 22:40:32.897513
3533	2	2	3	1	\N	2017-11-09	1005.40	7aba22cc26aa39d479b00af0f0aa1b48	2020-10-23 22:40:32.898708	2020-10-23 22:40:32.898708
3534	5	1	-1	2	\N	2017-11-09	-14.90	7e9a443cbdbd7d1211b7d12d1033134b	2020-10-23 22:40:32.899945	2020-10-23 22:40:32.899945
3535	2	10	54	3	\N	2017-11-09	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:32.901457	2020-10-23 22:40:32.901457
3536	4	10	54	4	\N	2017-11-09	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:32.902697	2020-10-23 22:40:32.902697
3537	2	10	54	3	\N	2017-11-09	-1500.00	6f3ef77ac0e3619e98159e9b6febf557	2020-10-23 22:40:32.90404	2020-10-23 22:40:32.90404
3538	6	10	54	4	\N	2017-11-09	1500.00	6f3ef77ac0e3619e98159e9b6febf557	2020-10-23 22:40:32.905288	2020-10-23 22:40:32.905288
3539	5	10	54	4	\N	2017-11-10	5500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:32.90675	2020-10-23 22:40:32.90675
3540	5	10	54	3	\N	2017-11-10	-2500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:32.908272	2020-10-23 22:40:32.908272
3541	5	10	54	4	\N	2017-11-13	2500.00	36ba4cb483d0fd4596bc1fb239c4f07c	2020-10-23 22:40:32.909815	2020-10-23 22:40:32.909815
3542	5	10	54	3	\N	2017-11-10	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:32.911138	2020-10-23 22:40:32.911138
3543	5	10	54	3	\N	2017-11-10	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:32.912399	2020-10-23 22:40:32.912399
3544	5	1	-1	2	\N	2017-11-10	-108.29	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:32.913659	2020-10-23 22:40:32.913659
3545	5	1	-1	2	\N	2017-11-10	-14.49	1728efbda81692282ba642aafd57be3a	2020-10-23 22:40:32.915012	2020-10-23 22:40:32.915012
3546	5	1	-1	2	\N	2017-11-10	-16.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:32.91672	2020-10-23 22:40:32.91672
3547	5	1	-1	2	\N	2017-11-10	-65.00	ea6f96d684fcea2caa82e4e262810723	2020-10-23 22:40:32.918018	2020-10-23 22:40:32.918018
3548	5	1	-1	2	\N	2017-11-13	-60.00	01161aaa0b6d1345dd8fe4e481144d84	2020-10-23 22:40:32.919188	2020-10-23 22:40:32.919188
3549	2	1	-1	1	\N	2017-11-13	120.00	fbc780df196942ae2b6efacf422c0590	2020-10-23 22:40:32.920341	2020-10-23 22:40:32.920341
3550	5	5	22	2	\N	2017-11-10	-210.00	d2467530ef7303b14c9988df20bb8ce4	2020-10-23 22:40:32.921576	2020-10-23 22:40:32.921576
3551	1	1	-1	2	\N	2017-11-08	-4.79	e68dc4981c2310e883786e7f723fa37d	2020-10-23 22:40:32.9232	2020-10-23 22:40:32.9232
3552	1	1	-1	2	\N	2017-11-07	-15.00	0dc8f3959597de2462d5aba542a4b712	2020-10-23 22:40:32.924636	2020-10-23 22:40:32.924636
3553	1	1	11	2	\N	2017-11-07	-2.00	901695fb1e54f4a451ba70a6e45d9d8d	2020-10-23 22:40:32.926758	2020-10-23 22:40:32.926758
3554	1	3	-1	2	\N	2017-11-11	-11.67	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:40:32.92855	2020-10-23 22:40:32.92855
3555	5	1	-1	2	\N	2017-11-12	-62.23	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.929987	2020-10-23 22:40:32.929987
3556	5	8	43	2	\N	2017-11-12	-10.00	e134fe3e8dc67b89dcd928aa2a7e7dcf	2020-10-23 22:40:32.931585	2020-10-23 22:40:32.931585
3557	2	4	16	2	\N	2017-11-13	-19.99	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:32.934023	2020-10-23 22:40:32.934023
3558	5	10	54	3	\N	2017-11-18	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:32.935572	2020-10-23 22:40:32.935572
3559	5	10	54	3	\N	2017-11-18	-200.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:32.936751	2020-10-23 22:40:32.936751
3560	1	10	54	4	\N	2017-11-18	200.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:32.937842	2020-10-23 22:40:32.937842
3561	1	10	54	3	\N	2017-11-18	-500.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:40:32.938907	2020-10-23 22:40:32.938907
3562	6	10	54	4	\N	2017-11-18	500.00	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:40:32.940128	2020-10-23 22:40:32.940128
3563	1	5	22	2	\N	2017-11-13	-90.00	efbd6ef165207baae1f083830046770d	2020-10-23 22:40:32.9416	2020-10-23 22:40:32.9416
3564	1	1	11	2	\N	2017-11-13	-11.67	9951145db4d446ec7ace1fd924468dac	2020-10-23 22:40:32.942797	2020-10-23 22:40:32.942797
3565	1	1	-1	2	\N	2017-11-17	-13.51	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:32.944018	2020-10-23 22:40:32.944018
3566	5	1	-1	2	\N	2017-11-18	-114.66	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:32.945352	2020-10-23 22:40:32.945352
3567	5	1	-1	2	\N	2017-11-18	-10.90	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:32.94655	2020-10-23 22:40:32.94655
3568	5	1	-1	2	\N	2017-11-18	-24.05	aef1e06f7b97d57942850adb46ec7c68	2020-10-23 22:40:32.947663	2020-10-23 22:40:32.947663
3569	5	1	-1	2	\N	2017-11-16	-4.74	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.948853	2020-10-23 22:40:32.948853
3570	5	1	-1	2	\N	2017-11-13	-22.96	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.950164	2020-10-23 22:40:32.950164
3571	5	5	23	2	\N	2017-11-14	-2.99	19234ad17f55e978593450288ac90bb4	2020-10-23 22:40:32.951336	2020-10-23 22:40:32.951336
3572	5	1	-1	2	\N	2017-11-17	-10.74	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:40:32.952495	2020-10-23 22:40:32.952495
3573	5	1	11	2	\N	2017-11-17	-4.79	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:40:32.953745	2020-10-23 22:40:32.953745
3574	5	1	-1	2	\N	2017-11-17	-1.18	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:32.955061	2020-10-23 22:40:32.955061
3575	5	1	-1	2	\N	2017-11-14	-3.99	abd01ad25d87aa583930a3764e711e33	2020-10-23 22:40:32.956457	2020-10-23 22:40:32.956457
3576	5	9	-1	2	\N	2017-11-16	-52.84	22951f2450d2131b00c1a0baafda65dc	2020-10-23 22:40:32.957857	2020-10-23 22:40:32.957857
3577	5	1	-1	2	\N	2017-11-17	-8.79	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.959181	2020-10-23 22:40:32.959181
3578	1	3	-1	2	\N	2017-11-18	-88.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:40:32.960311	2020-10-23 22:40:32.960311
3579	5	1	-1	2	\N	2017-11-18	-204.22	07d82a6b4d8450ab912608a93f8a24d4	2020-10-23 22:40:32.961441	2020-10-23 22:40:32.961441
3580	5	9	48	2	\N	2017-11-18	-35.20	6a2408ed8723d43f8ae3ea65c1a6f664	2020-10-23 22:40:32.962581	2020-10-23 22:40:32.962581
3581	2	1	-1	2	\N	2017-11-18	-17.58	b96ff8720857ae51929cf422157895ee	2020-10-23 22:40:32.963849	2020-10-23 22:40:32.963849
3582	2	9	-1	2	\N	2017-11-18	-400.00	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:40:32.965431	2020-10-23 22:40:32.965431
3583	5	5	23	2	\N	2017-11-20	-19.99	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:40:32.966705	2020-10-23 22:40:32.966705
3584	5	5	23	2	\N	2017-11-22	-24.55	19234ad17f55e978593450288ac90bb4	2020-10-23 22:40:32.968086	2020-10-23 22:40:32.968086
3585	5	1	-1	2	\N	2017-11-22	-6.77	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.969744	2020-10-23 22:40:32.969744
3586	5	2	-1	1	\N	2017-11-22	150.00	a52a63e01e3414bb80dab89de7fdaff5	2020-10-23 22:40:32.970971	2020-10-23 22:40:32.970971
3587	1	9	51	2	\N	2017-11-23	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:32.972174	2020-10-23 22:40:32.972174
3588	1	1	-1	2	\N	2017-11-25	-2.80	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:40:32.97332	2020-10-23 22:40:32.97332
3589	1	1	-1	2	\N	2017-11-25	-2.20	9023f6c6054a6f53fad320dc87e73850	2020-10-23 22:40:32.974555	2020-10-23 22:40:32.974555
3590	5	1	11	2	\N	2017-11-25	-11.88	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:32.975652	2020-10-23 22:40:32.975652
3591	5	1	-1	2	\N	2017-11-25	-179.93	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.977023	2020-10-23 22:40:32.977023
3592	1	1	-1	2	\N	2017-11-25	-79.93	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:32.978459	2020-10-23 22:40:32.978459
3593	1	1	-1	2	\N	2017-11-25	-14.60	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:32.979677	2020-10-23 22:40:32.979677
3594	1	1	-1	2	\N	2017-11-25	-19.04	d81fee4887336b1dba216cfff99bd9e6	2020-10-23 22:40:32.980804	2020-10-23 22:40:32.980804
3595	5	1	-1	2	\N	2017-11-25	-18.69	1728efbda81692282ba642aafd57be3a	2020-10-23 22:40:32.981974	2020-10-23 22:40:32.981974
3596	5	1	-1	2	\N	2017-11-25	-8.00	3347d307c9f7f4a44e4dd13f0a337e68	2020-10-23 22:40:32.983204	2020-10-23 22:40:32.983204
3597	5	1	-1	2	\N	2017-11-25	-11.47	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:32.984325	2020-10-23 22:40:32.984325
3598	1	3	-1	2	\N	2017-11-25	-20.00	b634947a581491a6d5ea20b68bf03d42	2020-10-23 22:40:32.985417	2020-10-23 22:40:32.985417
3599	5	4	16	2	\N	2017-11-27	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:32.986517	2020-10-23 22:40:32.986517
3600	2	4	16	2	\N	2017-11-27	-19.99	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:32.98775	2020-10-23 22:40:32.98775
3601	2	6	27	1	\N	2017-11-25	139.00	00e105d8a775f9dc1eb058243c5a442e	2020-10-23 22:40:32.989111	2020-10-23 22:40:32.989111
3602	2	3	-1	1	\N	2017-11-26	20.00	53fde96fcc4b4ce72d7739202324cd49	2020-10-23 22:40:32.990667	2020-10-23 22:40:32.990667
3603	2	3	-1	2	\N	2017-11-24	-10.00	a516a87cfcaef229b342c437fe2b95f7	2020-10-23 22:40:32.992007	2020-10-23 22:40:32.992007
3604	2	3	-1	2	\N	2017-11-26	-20.00	da86afcc58037b32c437365de9fd9566	2020-10-23 22:40:32.993345	2020-10-23 22:40:32.993345
3605	2	1	-1	2	\N	2017-11-24	-5.00	5c936263f3428a40227908d5a3847c0b	2020-10-23 22:40:32.994586	2020-10-23 22:40:32.994586
3606	2	1	-1	2	\N	2017-11-24	-34.00	08568948e369d6e5901ea1052de036ac	2020-10-23 22:40:32.995718	2020-10-23 22:40:32.995718
3607	5	9	48	2	\N	2017-11-24	-20.00	d459859854f7b6fb945edd33eee75a8e	2020-10-23 22:40:32.996894	2020-10-23 22:40:32.996894
3608	2	8	44	2	\N	2017-11-24	-13.00	2c0ffc99883aa95d0ec4712db7526586	2020-10-23 22:40:32.99816	2020-10-23 22:40:32.99816
3609	2	9	-1	2	\N	2017-11-24	-480.00	cd91e55ad07e82f90b92169fbb3466ce	2020-10-23 22:40:32.999562	2020-10-23 22:40:32.999562
3610	2	9	-1	2	\N	2017-11-24	-509.30	ede7e2b6d13a41ddf9f4bdef84fdc737	2020-10-23 22:40:33.000909	2020-10-23 22:40:33.000909
3611	5	5	21	2	\N	2017-11-27	-12.27	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:33.002397	2020-10-23 22:40:33.002397
3612	1	5	21	2	\N	2017-11-27	-11.98	3f289930a8ec31a12fa27d15b2ad16d2	2020-10-23 22:40:33.003563	2020-10-23 22:40:33.003563
3613	1	9	48	2	\N	2017-11-27	-374.80	40c6ad5294dc11f18d09f120b14e3d28	2020-10-23 22:40:33.004709	2020-10-23 22:40:33.004709
3614	1	2	3	1	\N	2017-11-28	10242.17	ff12b5098fd5f30ec6b4831756351e03	2020-10-23 22:40:33.006207	2020-10-23 22:40:33.006207
3615	1	10	54	3	\N	2017-11-29	-500.00	ff4d5fbbafdf976cfdc032e3bde78de5	2020-10-23 22:40:33.007597	2020-10-23 22:40:33.007597
3616	1	1	-1	2	\N	2017-11-28	-2.20	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:33.008767	2020-10-23 22:40:33.008767
3617	2	2	3	1	\N	2017-11-29	5598.60	53c3ca51d2a9d2b61ca543cdfc800c02	2020-10-23 22:40:33.009881	2020-10-23 22:40:33.009881
3618	2	2	-1	1	\N	2017-11-29	300.00	865fe807bb0ed8ffba5fcfd7c12269f5	2020-10-23 22:40:33.010927	2020-10-23 22:40:33.010927
3619	2	6	27	2	\N	2017-11-29	-25.00	cf67355a3333e6e143439161adc2d82e	2020-10-23 22:40:33.012061	2020-10-23 22:40:33.012061
3620	2	8	44	2	\N	2017-12-01	-30.00	4c56ff4ce4aaf9573aa5dff913df997a	2020-10-23 22:40:33.013119	2020-10-23 22:40:33.013119
3621	2	1	-1	2	\N	2017-12-01	-10.40	da8ce53cf0240070ce6c69c48cd588ee	2020-10-23 22:40:33.014304	2020-10-23 22:40:33.014304
3622	5	1	-1	2	\N	2017-12-01	-10.98	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:40:33.015391	2020-10-23 22:40:33.015391
3623	2	1	-1	2	\N	2017-12-01	-9.70	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:33.016526	2020-10-23 22:40:33.016526
3624	2	1	-1	2	\N	2017-12-01	-24.60	f53414b54f195046bc6576c73739adca	2020-10-23 22:40:33.017621	2020-10-23 22:40:33.017621
3625	2	9	48	2	\N	2017-12-01	-54.99	539fd53b59e3bb12d203f45a912eeaf2	2020-10-23 22:40:33.018726	2020-10-23 22:40:33.018726
3626	2	1	-1	2	\N	2017-12-01	-7.56	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:33.019851	2020-10-23 22:40:33.019851
3627	5	1	-1	2	\N	2017-12-01	-13.41	ace1382ebc1e0b1cbaeaa6811594a2ca	2020-10-23 22:40:33.020944	2020-10-23 22:40:33.020944
3628	2	4	18	2	\N	2017-12-01	-29.00	846c260d715e5b854ffad5f70a516c88	2020-10-23 22:40:33.022012	2020-10-23 22:40:33.022012
3629	2	10	54	3	\N	2017-12-01	-1500.00	65a36640de70ddc1207ce88ece099a89	2020-10-23 22:40:33.023345	2020-10-23 22:40:33.023345
3630	5	10	54	4	\N	2017-12-01	1500.00	65a36640de70ddc1207ce88ece099a89	2020-10-23 22:40:33.02474	2020-10-23 22:40:33.02474
3631	2	10	54	3	\N	2017-12-01	-2000.00	81d37ce432deac7aaa9702a64726f047	2020-10-23 22:40:33.026205	2020-10-23 22:40:33.026205
3632	6	10	54	4	\N	2017-12-01	2000.00	81d37ce432deac7aaa9702a64726f047	2020-10-23 22:40:33.027506	2020-10-23 22:40:33.027506
3633	5	4	13	2	\N	2017-12-01	-391.79	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:33.028753	2020-10-23 22:40:33.028753
3634	5	4	15	2	\N	2017-12-01	-133.16	e6a1914efe78d4ce1d680933a8adee5c	2020-10-23 22:40:33.030002	2020-10-23 22:40:33.030002
3635	5	4	-1	2	\N	2017-12-01	-590.00	08c5433a60135c32e34f46a71175850c	2020-10-23 22:40:33.031168	2020-10-23 22:40:33.031168
3636	2	9	49	2	\N	2017-12-01	-11.00	db8e1af0cb3aca1ae2d0018624204529	2020-10-23 22:40:33.032655	2020-10-23 22:40:33.032655
3637	5	9	49	2	\N	2017-12-03	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.033767	2020-10-23 22:40:33.033767
3638	1	2	-1	4	\N	2017-11-30	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.034898	2020-10-23 22:40:33.034898
3639	1	9	51	2	\N	2017-11-30	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.036124	2020-10-23 22:40:33.036124
3640	5	5	23	2	\N	2017-11-29	-37.46	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:33.037567	2020-10-23 22:40:33.037567
3641	1	3	-1	2	\N	2017-12-02	-35.06	fc112b7de95d1a8457a855d1d92cda11	2020-10-23 22:40:33.038808	2020-10-23 22:40:33.038808
3642	1	1	11	2	\N	2017-12-02	-5.99	71469579f0a9f6b9a1f278c364d51065	2020-10-23 22:40:33.040766	2020-10-23 22:40:33.040766
3643	5	1	-1	2	\N	2017-12-03	-99.76	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:33.042381	2020-10-23 22:40:33.042381
3644	1	10	54	3	\N	2017-12-01	-7000.00	38cb5dd93ddbed300d126e0328001acd	2020-10-23 22:40:33.043582	2020-10-23 22:40:33.043582
3645	1	8	44	2	\N	2017-12-02	-15.47	e633ebc842f846efae80b6dda8f2fb00	2020-10-23 22:40:33.044909	2020-10-23 22:40:33.044909
3646	1	1	-1	2	\N	2017-12-04	-5.60	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:33.046146	2020-10-23 22:40:33.046146
3647	1	1	-1	2	\N	2017-12-04	-13.73	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.047264	2020-10-23 22:40:33.047264
3648	1	3	-1	2	\N	2017-12-04	-271.00	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:33.048406	2020-10-23 22:40:33.048406
3649	1	4	18	2	\N	2017-12-03	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.049637	2020-10-23 22:40:33.049637
3650	5	1	-1	2	\N	2017-12-03	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.050875	2020-10-23 22:40:33.050875
3651	1	9	-1	3	\N	2017-12-03	-230.86	185e65bc40581880c4f2c82958de8cfe	2020-10-23 22:40:33.052282	2020-10-23 22:40:33.052282
3652	5	2	-1	4	\N	2017-12-03	230.86	185e65bc40581880c4f2c82958de8cfe	2020-10-23 22:40:33.053456	2020-10-23 22:40:33.053456
3653	1	9	-1	2	\N	2017-12-03	-11.13	b7892fb3c2f009c65f686f6355c895b5	2020-10-23 22:40:33.054617	2020-10-23 22:40:33.054617
3654	1	9	-1	3	\N	2017-12-03	-88.08	185e65bc40581880c4f2c82958de8cfe	2020-10-23 22:40:33.055862	2020-10-23 22:40:33.055862
3655	6	10	55	1	\N	2017-12-03	91.59	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:40:33.057889	2020-10-23 22:40:33.057889
3656	1	9	48	2	\N	2017-12-04	-30.00	8b5040a8a5baf3e0e67386c2e3a9b903	2020-10-23 22:40:33.059304	2020-10-23 22:40:33.059304
3657	5	10	54	4	\N	2017-12-04	5500.00	898a87d1176aabe8f6afd67c7afb5cb0	2020-10-23 22:40:33.060873	2020-10-23 22:40:33.060873
3658	6	10	54	4	\N	2017-12-04	30000.00	08a641013301b0c0294304b3e7b2f45c	2020-10-23 22:40:33.062176	2020-10-23 22:40:33.062176
3659	5	10	54	3	\N	2017-12-04	-1000.00	1816533e898f2ead4768e0aaae739883	2020-10-23 22:40:33.063647	2020-10-23 22:40:33.063647
3660	5	10	54	3	\N	2017-12-04	-500.00	72da7fd6d1302c0a159f6436d01e9eb0	2020-10-23 22:40:33.065416	2020-10-23 22:40:33.065416
3661	1	8	41	2	\N	2017-12-07	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:33.066734	2020-10-23 22:40:33.066734
3662	1	4	18	2	\N	2017-12-05	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.068541	2020-10-23 22:40:33.068541
3663	1	9	48	2	\N	2017-12-05	-45.76	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:40:33.070238	2020-10-23 22:40:33.070238
3664	5	5	26	2	\N	2017-12-04	-9.99	4a5a40872023e565257ef33296261f15	2020-10-23 22:40:33.071926	2020-10-23 22:40:33.071926
3665	5	4	-1	2	\N	2017-12-07	-189.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:33.073902	2020-10-23 22:40:33.073902
3666	1	3	-1	2	\N	2017-12-07	-13.67	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:40:33.075395	2020-10-23 22:40:33.075395
3667	1	1	-1	2	\N	2017-12-07	-14.46	43acfb3c016819505e96a8544f2d9660	2020-10-23 22:40:33.076893	2020-10-23 22:40:33.076893
3668	1	9	-1	3	\N	2017-12-07	-140.00	7a614fd06c325499f1680b9896beedeb	2020-10-23 22:40:33.078103	2020-10-23 22:40:33.078103
3669	5	1	-1	2	\N	2017-12-11	-18.63	1728efbda81692282ba642aafd57be3a	2020-10-23 22:40:33.079206	2020-10-23 22:40:33.079206
3670	5	1	-1	2	\N	2017-12-11	-10.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.080266	2020-10-23 22:40:33.080266
3671	5	1	-1	2	\N	2017-12-11	-103.83	320722549d1751cf3f247855f937b982	2020-10-23 22:40:33.081472	2020-10-23 22:40:33.081472
3672	5	9	48	2	\N	2017-12-11	-74.80	a1b4aee403666cdebd9058e04577ca0e	2020-10-23 22:40:33.082817	2020-10-23 22:40:33.082817
3673	5	9	48	2	\N	2017-12-11	-107.67	0946676d26ce64a63b767646b50ee8f1	2020-10-23 22:40:33.084438	2020-10-23 22:40:33.084438
3674	1	1	-1	2	\N	2017-12-11	-4.40	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:33.085706	2020-10-23 22:40:33.085706
3675	5	10	54	3	\N	2017-12-11	-500.00	8148cf440956aa149775202a8a22d1d1	2020-10-23 22:40:33.087218	2020-10-23 22:40:33.087218
3676	5	10	54	3	\N	2017-12-11	-200.00	598f5f04d65b4e0e35515b367763fee6	2020-10-23 22:40:33.088615	2020-10-23 22:40:33.088615
3677	1	10	54	4	\N	2017-12-11	200.00	598f5f04d65b4e0e35515b367763fee6	2020-10-23 22:40:33.09024	2020-10-23 22:40:33.09024
3678	5	10	54	3	\N	2017-12-11	-1800.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:33.091881	2020-10-23 22:40:33.091881
3679	6	10	54	4	\N	2017-12-11	1800.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:33.093202	2020-10-23 22:40:33.093202
3680	1	10	54	3	\N	2017-12-11	-1368.64	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:40:33.094601	2020-10-23 22:40:33.094601
3681	6	10	54	4	\N	2017-12-11	1368.64	0fde226e9984d92298d59429a3b0311e	2020-10-23 22:40:33.096207	2020-10-23 22:40:33.096207
3682	1	9	51	2	\N	2017-12-12	-20.00	8807ea68c5175d0173220bec0542d2e9	2020-10-23 22:40:33.097686	2020-10-23 22:40:33.097686
3683	5	1	-1	2	\N	2017-12-12	-39.71	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.099326	2020-10-23 22:40:33.099326
3684	2	1	-1	2	\N	2017-12-15	-14.00	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:33.100801	2020-10-23 22:40:33.100801
3685	2	7	37	2	\N	2017-12-15	-10.67	d2ce51cff86160dbe257712c28650d20	2020-10-23 22:40:33.102682	2020-10-23 22:40:33.102682
3686	2	1	-1	2	\N	2017-12-15	-12.76	9188905e74c28e489b44e954ec0b9bca	2020-10-23 22:40:33.10455	2020-10-23 22:40:33.10455
3687	5	9	48	1	\N	2017-12-15	74.80	a1b4aee403666cdebd9058e04577ca0e	2020-10-23 22:40:33.106297	2020-10-23 22:40:33.106297
3688	1	1	11	2	\N	2017-12-14	-2.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:40:33.107923	2020-10-23 22:40:33.107923
3689	1	1	-1	2	\N	2017-12-13	-5.37	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:33.110298	2020-10-23 22:40:33.110298
3690	1	5	21	2	\N	2017-12-16	-13.99	8065d07da4a77621450aa84fee5656d9	2020-10-23 22:40:33.112171	2020-10-23 22:40:33.112171
3691	1	1	-1	2	\N	2017-12-14	-12.23	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:33.113521	2020-10-23 22:40:33.113521
3692	1	1	-1	2	\N	2017-12-13	-16.82	23bd2bb77f267d8bcb92e0a43f58168d	2020-10-23 22:40:33.115085	2020-10-23 22:40:33.115085
3693	5	1	-1	2	\N	2017-12-16	-10.35	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.116691	2020-10-23 22:40:33.116691
3694	5	1	-1	2	\N	2017-12-16	-98.69	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.118109	2020-10-23 22:40:33.118109
3695	5	1	11	2	\N	2017-12-15	-9.58	b706835de79a2b4e80506f582af3676a	2020-10-23 22:40:33.119231	2020-10-23 22:40:33.119231
3696	1	7	35	2	\N	2017-12-17	-55.00	70ef895d62319987fc8a0b52f7f7180d	2020-10-23 22:40:33.120415	2020-10-23 22:40:33.120415
3697	1	7	35	2	\N	2017-12-17	-70.00	bfb816793deaf72c06b413901789f97e	2020-10-23 22:40:33.121653	2020-10-23 22:40:33.121653
3698	5	9	48	2	\N	2017-12-18	-63.89	59981d7f62215b7caba08427d24e9fb5	2020-10-23 22:40:33.122949	2020-10-23 22:40:33.122949
3699	5	9	48	2	\N	2017-12-18	-39.99	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:33.124655	2020-10-23 22:40:33.124655
3700	5	5	23	2	\N	2017-12-18	-18.99	01fb07dbdfe3d4d753a7150ef1bbb7f0	2020-10-23 22:40:33.126213	2020-10-23 22:40:33.126213
3701	5	9	48	2	\N	2017-12-18	-32.99	57dfa78c5a344d76abe0d93827ecccf6	2020-10-23 22:40:33.128049	2020-10-23 22:40:33.128049
3702	1	5	23	2	\N	2017-12-18	-86.97	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:33.129577	2020-10-23 22:40:33.129577
3703	5	9	48	2	\N	2017-12-19	-65.93	419cd8b91180ee0a954b4c114f88f408	2020-10-23 22:40:33.131095	2020-10-23 22:40:33.131095
3704	2	9	48	2	\N	2017-12-17	-26.98	552acd90c96884c05a0adba32fc66340	2020-10-23 22:40:33.13224	2020-10-23 22:40:33.13224
3705	2	9	48	2	\N	2017-12-17	-8.26	b10060445f910bfb5ed976e1271f998b	2020-10-23 22:40:33.133475	2020-10-23 22:40:33.133475
3706	2	1	-1	2	\N	2017-12-17	-41.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:40:33.134704	2020-10-23 22:40:33.134704
3707	2	1	-1	2	\N	2017-12-15	-4.50	ffc987113c7a22fb2a52b6f9842f79be	2020-10-23 22:40:33.136044	2020-10-23 22:40:33.136044
3708	5	9	48	2	\N	2017-12-20	-94.99	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:33.137264	2020-10-23 22:40:33.137264
3709	2	3	-1	2	\N	2017-12-19	-10.00	20401b2f2c0b1742a41634f3f60f1386	2020-10-23 22:40:33.138663	2020-10-23 22:40:33.138663
3710	2	5	21	2	\N	2017-12-20	-12.98	1c222c9181f2dfcc08ca42e869cf88c8	2020-10-23 22:40:33.140809	2020-10-23 22:40:33.140809
3711	5	1	-1	2	\N	2017-12-20	-20.26	3619cb5bf1ba5b8f0523230ca3f4f148	2020-10-23 22:40:33.142692	2020-10-23 22:40:33.142692
3712	5	1	-1	2	\N	2017-12-20	-5.37	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:40:33.144343	2020-10-23 22:40:33.144343
3713	1	2	3	4	\N	2017-12-21	8722.94	588d4c8022a1b06da847986d79070391	2020-10-23 22:40:33.147738	2020-10-23 22:40:33.147738
3714	1	10	54	3	\N	2017-12-21	-500.00	c90fe2651db8f9cf13b9e37bc8add720	2020-10-23 22:40:33.149453	2020-10-23 22:40:33.149453
3715	2	2	3	1	\N	2017-12-22	4645.08	e124b27a3a7c7426bd24ef802b8fdba4	2020-10-23 22:40:33.151666	2020-10-23 22:40:33.151666
3716	2	10	54	3	\N	2017-12-22	-1500.00	3994f23bfb2b89994bd6e828977b42ae	2020-10-23 22:40:33.153894	2020-10-23 22:40:33.153894
3717	5	10	54	4	\N	2017-12-22	1500.00	3994f23bfb2b89994bd6e828977b42ae	2020-10-23 22:40:33.155315	2020-10-23 22:40:33.155315
3718	2	9	-1	2	\N	2017-12-22	-2697.40	1d0a6844d227e2bf549a7fa6dfd2485f	2020-10-23 22:40:33.157373	2020-10-23 22:40:33.157373
3719	5	5	23	2	\N	2017-12-22	-9.50	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.159171	2020-10-23 22:40:33.159171
3720	1	9	51	2	\N	2017-12-22	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.160542	2020-10-23 22:40:33.160542
3721	5	1	-1	2	\N	2017-12-21	-8.14	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.161873	2020-10-23 22:40:33.161873
3722	5	1	-1	2	\N	2017-12-22	-35.48	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.163522	2020-10-23 22:40:33.163522
3723	1	9	48	2	\N	2017-12-22	-79.99	e6f4149f5c6a20ed69b859bc81de182c	2020-10-23 22:40:33.165324	2020-10-23 22:40:33.165324
3724	6	10	54	3	\N	2017-12-23	-500.00	6d01ba369faf00eaad5fe83687b200df	2020-10-23 22:40:33.167045	2020-10-23 22:40:33.167045
3725	1	10	54	4	\N	2017-12-23	500.00	6d01ba369faf00eaad5fe83687b200df	2020-10-23 22:40:33.168784	2020-10-23 22:40:33.168784
3726	1	8	43	2	\N	2017-12-23	-143.33	ea01e5fd8e4d8832825acdd20eac5104	2020-10-23 22:40:33.170767	2020-10-23 22:40:33.170767
3727	1	9	-1	2	\N	2017-12-24	-53.50	afa939adf52ddcbd204c814afcdd754a	2020-10-23 22:40:33.172601	2020-10-23 22:40:33.172601
3728	1	9	-1	2	\N	2017-12-26	-20.00	9c53c3afcaeef658a8db8da3dda4aa69	2020-10-23 22:40:33.17457	2020-10-23 22:40:33.17457
3729	1	9	-1	2	\N	2017-12-27	-50.00	288cc0ff022877bd3df94bc9360b9c5d	2020-10-23 22:40:33.176487	2020-10-23 22:40:33.176487
3730	1	8	43	2	\N	2017-12-27	-126.59	e9a12268e5fcb045a232cdc56709049a	2020-10-23 22:40:33.178224	2020-10-23 22:40:33.178224
3731	5	1	-1	2	\N	2017-12-27	-3.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.179872	2020-10-23 22:40:33.179872
3732	5	9	48	2	\N	2017-12-27	-96.89	ed74883a0e62f7670f6dd6bf9390ab48	2020-10-23 22:40:33.181823	2020-10-23 22:40:33.181823
3733	5	4	16	2	\N	2017-12-27	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:33.183612	2020-10-23 22:40:33.183612
3734	2	1	-1	2	\N	2017-12-27	-18.66	502e4a16930e414107ee22b6198c578f	2020-10-23 22:40:33.185541	2020-10-23 22:40:33.185541
3735	5	4	13	2	\N	2017-12-27	-391.79	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:33.187818	2020-10-23 22:40:33.187818
3736	5	4	-1	2	\N	2017-12-27	-590.00	08c5433a60135c32e34f46a71175850c	2020-10-23 22:40:33.189942	2020-10-23 22:40:33.189942
3737	5	4	15	2	\N	2017-12-27	-133.16	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:40:33.192219	2020-10-23 22:40:33.192219
3738	1	1	-1	2	\N	2017-12-28	-25.39	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.193807	2020-10-23 22:40:33.193807
3739	1	1	-1	2	\N	2017-12-28	-7.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.19546	2020-10-23 22:40:33.19546
3740	1	1	-1	2	\N	2017-12-28	-12.00	d548e49f6950d3a8b4e58c12041c08e7	2020-10-23 22:40:33.197224	2020-10-23 22:40:33.197224
3741	1	5	25	2	\N	2017-12-29	-40.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:33.199163	2020-10-23 22:40:33.199163
3742	1	9	-1	2	\N	2017-12-29	-129.00	8c9611718f0422ac8dd0baf0903d22e5	2020-10-23 22:40:33.20089	2020-10-23 22:40:33.20089
3743	1	9	-1	2	\N	2017-12-29	-238.00	628cc8fc94ab4adad79e586b32c479ca	2020-10-23 22:40:33.202642	2020-10-23 22:40:33.202642
3744	2	1	-1	2	\N	2017-12-29	-12.60	b47c45d026cf6a167e20b542af33ec63	2020-10-23 22:40:33.204358	2020-10-23 22:40:33.204358
3745	1	1	-1	2	\N	2017-12-29	-39.00	d41e4d6a1176ea36b93af88eb4ba11ba	2020-10-23 22:40:33.206164	2020-10-23 22:40:33.206164
3746	5	7	30	2	\N	2017-12-29	-240.00	956350bfd1852bdd1112e1dcfbfae9ee	2020-10-23 22:40:33.208484	2020-10-23 22:40:33.208484
3747	1	1	-1	2	\N	2017-12-30	-13.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.210102	2020-10-23 22:40:33.210102
3748	5	1	-1	2	\N	2017-12-30	-9.78	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:33.212009	2020-10-23 22:40:33.212009
3749	5	1	-1	2	\N	2017-12-30	-144.34	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.214019	2020-10-23 22:40:33.214019
3750	1	9	49	2	\N	2017-12-30	-30.00	398d9f5f16e2d7a8a42cc2527dcbcecd	2020-10-23 22:40:33.216136	2020-10-23 22:40:33.216136
3751	5	1	-1	2	\N	2017-12-31	-3.98	3e7c1c394a8557a57012a9be9bf7b5ef	2020-10-23 22:40:33.217498	2020-10-23 22:40:33.217498
3752	1	2	-1	4	\N	2017-12-31	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.21895	2020-10-23 22:40:33.21895
3753	5	7	33	3	\N	2017-12-31	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.220261	2020-10-23 22:40:33.220261
3754	6	10	55	1	\N	2017-12-31	99.95	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:40:33.222434	2020-10-23 22:40:33.222434
3755	1	10	54	3	\N	2017-12-31	-17.44	b7892fb3c2f009c65f686f6355c895b5	2020-10-23 22:40:33.224316	2020-10-23 22:40:33.224316
3756	5	1	-1	2	\N	2017-12-31	-12.62	5ed40cc0659d685215b4897e21fa3cab	2020-10-23 22:40:33.226776	2020-10-23 22:40:33.226776
3757	5	10	54	4	\N	2018-01-01	6052.02	ceccd19ee311aa73c14b7c8ff491ffed	2020-10-23 22:40:33.228971	2020-10-23 22:40:33.228971
3758	5	10	54	3	\N	2018-01-01	-5000.05	86b122d4358357d834a87ce618a55de0	2020-10-23 22:40:33.231175	2020-10-23 22:40:33.231175
3759	6	10	54	4	\N	2018-01-01	5000.05	86b122d4358357d834a87ce618a55de0	2020-10-23 22:40:33.233525	2020-10-23 22:40:33.233525
3760	6	10	54	4	\N	2017-12-25	10000.00	6a64033582463ce72c66dc13d534b163	2020-10-23 22:40:33.234929	2020-10-23 22:40:33.234929
3761	5	9	-1	2	\N	2017-12-31	-86.41	f1852259718f260ca67402fd8acb42f8	2020-10-23 22:40:33.23614	2020-10-23 22:40:33.23614
3762	1	10	54	1	\N	2018-01-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:33.237325	2020-10-23 22:40:33.237325
3763	1	9	49	3	\N	2018-01-01	-150.00	21f8cef79c3df0a9c878be1570b9f3e9	2020-10-23 22:40:33.238547	2020-10-23 22:40:33.238547
3764	1	8	41	2	\N	2018-01-01	-46.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:33.240572	2020-10-23 22:40:33.240572
3765	5	1	-1	2	\N	2018-01-02	-11.26	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.242062	2020-10-23 22:40:33.242062
3766	5	5	23	2	\N	2018-01-02	-5.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.244188	2020-10-23 22:40:33.244188
3767	5	5	23	2	\N	2018-01-02	-29.66	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.246525	2020-10-23 22:40:33.246525
3768	5	8	43	2	\N	2018-01-03	-141.54	c7c239bfa5b464ef6c560b9cab0b3332	2020-10-23 22:40:33.247894	2020-10-23 22:40:33.247894
3769	5	5	23	2	\N	2018-01-02	-6.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.24911	2020-10-23 22:40:33.24911
3770	1	1	-1	2	\N	2018-01-04	-68.18	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.250196	2020-10-23 22:40:33.250196
3771	1	4	18	2	\N	2018-01-04	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.251298	2020-10-23 22:40:33.251298
3772	1	9	-1	3	\N	2018-01-04	-500.00	999fe455196bf8d34e2d743fc4b22b85	2020-10-23 22:40:33.252605	2020-10-23 22:40:33.252605
3773	5	9	-1	4	\N	2018-01-04	500.00	999fe455196bf8d34e2d743fc4b22b85	2020-10-23 22:40:33.253843	2020-10-23 22:40:33.253843
3774	1	10	54	3	\N	2018-01-02	-7000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:33.255064	2020-10-23 22:40:33.255064
3775	5	10	54	4	\N	2018-01-04	5500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:33.256482	2020-10-23 22:40:33.256482
3776	5	9	51	2	\N	2018-01-02	-30.00	ca4b2ccf7faf05cc949e973fd82e89ef	2020-10-23 22:40:33.25792	2020-10-23 22:40:33.25792
3777	1	9	51	2	\N	2018-01-02	-8.00	9c53c3afcaeef658a8db8da3dda4aa69	2020-10-23 22:40:33.259545	2020-10-23 22:40:33.259545
3778	5	9	47	2	\N	2018-01-02	-250.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:40:33.260794	2020-10-23 22:40:33.260794
3779	1	2	-1	4	\N	2018-01-02	220.00	e174b03de89decac4d4ed2da3ba1f5df	2020-10-23 22:40:33.262084	2020-10-23 22:40:33.262084
3780	1	9	48	2	\N	2018-01-02	-179.00	52b117a6e171b082cf23e86727f67ba7	2020-10-23 22:40:33.263388	2020-10-23 22:40:33.263388
3781	5	10	54	3	\N	2018-01-04	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:33.264856	2020-10-23 22:40:33.264856
3782	6	10	54	4	\N	2018-01-04	1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:33.266244	2020-10-23 22:40:33.266244
3783	5	10	54	3	\N	2018-01-04	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:33.267603	2020-10-23 22:40:33.267603
3784	1	9	49	2	\N	2018-01-05	-124.23	a8bb8b55788a7882f3e6ca8d1b52bdde	2020-10-23 22:40:33.268902	2020-10-23 22:40:33.268902
3785	5	1	-1	2	\N	2018-01-05	-121.80	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.270251	2020-10-23 22:40:33.270251
3786	5	5	26	2	\N	2018-01-06	-28.99	d423104a94cbf2faa1c9ba9f06e1679e	2020-10-23 22:40:33.271488	2020-10-23 22:40:33.271488
3787	5	1	-1	2	\N	2018-01-05	-6.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.272831	2020-10-23 22:40:33.272831
3788	5	5	23	2	\N	2018-01-05	-21.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.275094	2020-10-23 22:40:33.275094
3789	5	5	23	2	\N	2018-01-05	-52.97	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.276311	2020-10-23 22:40:33.276311
3790	5	1	-1	2	\N	2018-01-02	-3.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.27756	2020-10-23 22:40:33.27756
3791	2	6	27	2	\N	2018-01-02	-69.98	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:40:33.278767	2020-10-23 22:40:33.278767
3792	2	6	27	2	\N	2018-01-02	-59.96	348aabcfdf0004c41e3e199c5bae43e3	2020-10-23 22:40:33.280111	2020-10-23 22:40:33.280111
3793	2	6	27	2	\N	2018-01-02	-69.99	b55ec28c52d5f6205684a473a2193564	2020-10-23 22:40:33.281303	2020-10-23 22:40:33.281303
3794	2	4	18	2	\N	2018-01-03	-29.00	d0f3dc437da6e6318e2b7ef1417af7f0	2020-10-23 22:40:33.282798	2020-10-23 22:40:33.282798
3795	2	6	27	2	\N	2018-01-04	-49.98	348aabcfdf0004c41e3e199c5bae43e3	2020-10-23 22:40:33.284397	2020-10-23 22:40:33.284397
3796	5	9	-1	2	\N	2018-01-06	-1000.00	e0ec453e28e061cc58ac43f91dc2f3f0	2020-10-23 22:40:33.285598	2020-10-23 22:40:33.285598
3797	2	9	-1	1	\N	2018-01-06	1000.00	e0ec453e28e061cc58ac43f91dc2f3f0	2020-10-23 22:40:33.286823	2020-10-23 22:40:33.286823
3798	2	9	-1	1	\N	2018-01-02	532.52	2dee5601bb2fd59717f5aee952b159fb	2020-10-23 22:40:33.288144	2020-10-23 22:40:33.288144
3799	2	9	51	2	\N	2018-01-06	-100.00	e730ad29229b967d96ac02a1120f1619	2020-10-23 22:40:33.28942	2020-10-23 22:40:33.28942
3800	1	10	54	4	\N	2018-01-07	4500.00	e9b1ad953dcf5fd357195adadc014066	2020-10-23 22:40:33.291631	2020-10-23 22:40:33.291631
3801	2	7	33	2	\N	2018-01-08	-20.00	1595af6435015c77a7149e92a551338e	2020-10-23 22:40:33.293252	2020-10-23 22:40:33.293252
3802	2	8	41	2	\N	2018-01-08	-50.00	e820f3a30380e5c6e584268c302d35fa	2020-10-23 22:40:33.294797	2020-10-23 22:40:33.294797
3803	5	4	14	2	\N	2018-01-09	-136.59	cf34362ab126ce8338d8991cc1404980	2020-10-23 22:40:33.296829	2020-10-23 22:40:33.296829
3804	5	1	-1	2	\N	2018-01-08	-2.70	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:33.2981	2020-10-23 22:40:33.2981
3805	5	1	-1	2	\N	2018-01-08	-9.65	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:33.299365	2020-10-23 22:40:33.299365
3806	1	1	-1	2	\N	2018-01-08	-49.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:33.300638	2020-10-23 22:40:33.300638
3807	1	5	21	2	\N	2018-01-08	-32.28	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:33.302148	2020-10-23 22:40:33.302148
3808	5	5	21	2	\N	2018-01-08	-49.45	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:33.303893	2020-10-23 22:40:33.303893
3809	1	5	22	2	\N	2018-01-08	-2702.50	e9b1ad953dcf5fd357195adadc014066	2020-10-23 22:40:33.305306	2020-10-23 22:40:33.305306
3810	1	1	-1	2	\N	2018-01-08	-14.55	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.306534	2020-10-23 22:40:33.306534
3811	1	2	-1	1	\N	2018-01-09	80.00	cb09a716ffe7c519c744b31f6076cce9	2020-10-23 22:40:33.307981	2020-10-23 22:40:33.307981
3812	6	9	-1	2	\N	2018-01-09	-300.00	828152d112507f3ea5b7ddc171f2bb2e	2020-10-23 22:40:33.309285	2020-10-23 22:40:33.309285
3813	2	1	-1	2	\N	2018-01-10	-12.75	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:33.310543	2020-10-23 22:40:33.310543
3814	5	1	-1	2	\N	2018-01-10	-5.98	3a465180a2c1e3ecd2e8311048d2183f	2020-10-23 22:40:33.311885	2020-10-23 22:40:33.311885
3815	5	5	23	2	\N	2018-01-10	-24.99	dc5c7986daef50c1e02ab09b442ee34f	2020-10-23 22:40:33.313285	2020-10-23 22:40:33.313285
3816	2	6	27	2	\N	2018-01-10	-7.00	204a3eeab2a68f6bd87db22983749c42	2020-10-23 22:40:33.314583	2020-10-23 22:40:33.314583
3817	5	10	54	3	\N	2018-01-11	-1900.00	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:33.316377	2020-10-23 22:40:33.316377
3818	6	10	54	4	\N	2018-01-11	1900.00	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:33.317676	2020-10-23 22:40:33.317676
3819	5	10	54	3	\N	2018-01-11	-500.00	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:33.319081	2020-10-23 22:40:33.319081
3820	5	10	54	3	\N	2018-01-11	-100.00	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:33.320708	2020-10-23 22:40:33.320708
3821	1	10	54	4	\N	2018-01-11	100.00	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:33.322793	2020-10-23 22:40:33.322793
3822	5	1	-1	2	\N	2018-01-11	-135.00	31a9ee0d77b989bfe1f50e3d52ac45e7	2020-10-23 22:40:33.324706	2020-10-23 22:40:33.324706
3823	5	1	-1	2	\N	2018-01-13	-23.00	2a9ced3967f417a7877cc296438e6fb4	2020-10-23 22:40:33.326591	2020-10-23 22:40:33.326591
3824	5	1	-1	2	\N	2018-01-13	-171.32	320722549d1751cf3f247855f937b982	2020-10-23 22:40:33.328011	2020-10-23 22:40:33.328011
3825	1	2	-1	1	\N	2018-01-13	79.60	99ff292e23794ad843b5d75c459ed289	2020-10-23 22:40:33.32952	2020-10-23 22:40:33.32952
3826	1	9	51	2	\N	2018-01-13	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.331158	2020-10-23 22:40:33.331158
3827	5	1	-1	2	\N	2018-01-13	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.332496	2020-10-23 22:40:33.332496
3828	5	1	-1	2	\N	2018-01-12	-16.07	57bbcb50322f47702de79937c482ba20	2020-10-23 22:40:33.333819	2020-10-23 22:40:33.333819
3829	5	1	-1	2	\N	2018-01-14	-7.28	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:33.335904	2020-10-23 22:40:33.335904
3830	1	7	32	2	\N	2018-01-14	-336.50	47cfc27c36f07700a44a24887ded7cec	2020-10-23 22:40:33.337248	2020-10-23 22:40:33.337248
3831	1	2	-1	1	\N	2018-01-04	468.78	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:40:33.338479	2020-10-23 22:40:33.338479
3832	1	10	54	3	\N	2018-01-14	-1459.15	452d9d2ddc00d8762d5b580c0aaee5c9	2020-10-23 22:40:33.340689	2020-10-23 22:40:33.340689
3833	2	9	51	2	\N	2018-01-14	-10.00	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:40:33.342145	2020-10-23 22:40:33.342145
3834	1	9	51	2	\N	2018-01-14	-12.00	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:40:33.343344	2020-10-23 22:40:33.343344
3835	2	2	3	1	\N	2018-01-16	1627.82	a9f05953ecfdece37960c0a531627f36	2020-10-23 22:40:33.344552	2020-10-23 22:40:33.344552
3836	2	9	48	2	\N	2018-01-15	-19.90	9e3cfc48eccf81a0d57663e129aef3cb	2020-10-23 22:40:33.34575	2020-10-23 22:40:33.34575
3837	2	9	48	2	\N	2018-01-16	-50.00	5c44f18b762ccfaa619598db2838c67a	2020-10-23 22:40:33.347174	2020-10-23 22:40:33.347174
3838	2	6	27	2	\N	2018-01-16	-175.96	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:40:33.349211	2020-10-23 22:40:33.349211
3839	2	6	27	2	\N	2018-01-16	-44.98	8e7c6b19af1fc49034a4b2663e55d987	2020-10-23 22:40:33.35124	2020-10-23 22:40:33.35124
3840	2	5	21	2	\N	2018-01-16	-32.96	71a3cb155f8dc89bf3d0365288219936	2020-10-23 22:40:33.352669	2020-10-23 22:40:33.352669
3841	5	5	23	2	\N	2018-01-16	-19.99	18a5699c873242b2564a20d8736c2d71	2020-10-23 22:40:33.354057	2020-10-23 22:40:33.354057
3842	2	5	23	2	\N	2018-01-16	-15.65	8c6aa8068da0e0de08691b91863f11f6	2020-10-23 22:40:33.3555	2020-10-23 22:40:33.3555
3843	5	9	48	2	\N	2018-01-17	-247.00	d96409bf894217686ba124d7356686c9	2020-10-23 22:40:33.357197	2020-10-23 22:40:33.357197
3844	5	4	19	2	\N	2018-01-17	-91.00	56808686a033759e95d2b6fc81f26e77	2020-10-23 22:40:33.358819	2020-10-23 22:40:33.358819
3845	1	1	-1	2	\N	2018-01-17	-16.96	c3f0e8cb7de97a908771f372ce3cdadd	2020-10-23 22:40:33.36022	2020-10-23 22:40:33.36022
3846	1	1	-1	2	\N	2018-01-17	-3.96	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.361768	2020-10-23 22:40:33.361768
3847	1	9	48	2	\N	2018-01-18	-149.99	04e0529dedd62c6f71a30ff5e281d459	2020-10-23 22:40:33.363492	2020-10-23 22:40:33.363492
3848	1	9	48	2	\N	2018-01-18	-54.14	04e0529dedd62c6f71a30ff5e281d459	2020-10-23 22:40:33.365469	2020-10-23 22:40:33.365469
3849	2	6	27	1	\N	2018-01-18	49.99	bcbef6628a45535849b6066c357a17ea	2020-10-23 22:40:33.366823	2020-10-23 22:40:33.366823
3850	2	6	27	2	\N	2018-01-18	-79.98	47cf26c17f2ef17fb3d3a5967b83dbbd	2020-10-23 22:40:33.368381	2020-10-23 22:40:33.368381
3851	2	5	21	2	\N	2018-01-18	-45.27	8bb518e95bb8c25e31ea444ca6549b95	2020-10-23 22:40:33.369814	2020-10-23 22:40:33.369814
3852	1	3	-1	2	\N	2018-01-19	-60.00	c2d551f8bf786de555e357c64ca8beb3	2020-10-23 22:40:33.371368	2020-10-23 22:40:33.371368
3853	5	5	23	2	\N	2018-01-20	-22.90	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:33.373541	2020-10-23 22:40:33.373541
3854	5	1	-1	2	\N	2018-01-20	-4.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.375994	2020-10-23 22:40:33.375994
3855	5	1	-1	2	\N	2018-01-20	-146.70	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.378409	2020-10-23 22:40:33.378409
3856	5	1	-1	2	\N	2018-01-20	-14.78	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.38025	2020-10-23 22:40:33.38025
3857	2	9	48	2	\N	2018-01-20	-51.00	55c86dd42f088b5f7d434e7bab282e63	2020-10-23 22:40:33.381943	2020-10-23 22:40:33.381943
3858	5	8	43	2	\N	2018-01-21	-249.88	e70611883d2760c8bbafb4acb29e3446	2020-10-23 22:40:33.384273	2020-10-23 22:40:33.384273
3859	1	2	-1	1	\N	2018-01-20	51.00	e820a45f1dfc7b95282d10b6087e11c0	2020-10-23 22:40:33.386623	2020-10-23 22:40:33.386623
3860	1	1	-1	2	\N	2018-01-23	-16.50	b9b4abeafdffae758561c5bc344c22c0	2020-10-23 22:40:33.388855	2020-10-23 22:40:33.388855
3861	1	3	-1	2	\N	2018-01-26	-39.00	a80fbbb5787b057841f0ea51cd9a9b26	2020-10-23 22:40:33.391087	2020-10-23 22:40:33.391087
3862	1	1	-1	2	\N	2018-01-25	-28.40	e5f6ad6ce374177eef023bf5d0c018b6	2020-10-23 22:40:33.39257	2020-10-23 22:40:33.39257
3863	1	2	-1	1	\N	2018-01-24	51.00	52be5fecc6cde2c0602277e8b50135e1	2020-10-23 22:40:33.394951	2020-10-23 22:40:33.394951
3864	1	2	3	1	\N	2018-01-25	9500.41	00fe3a0007618c71f25c134fa361f0a4	2020-10-23 22:40:33.397278	2020-10-23 22:40:33.397278
3865	5	5	23	2	\N	2018-01-24	-72.48	ac112d0832171b2877f63c669bf3d303	2020-10-23 22:40:33.399649	2020-10-23 22:40:33.399649
3866	5	1	-1	2	\N	2018-01-24	-21.42	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.401909	2020-10-23 22:40:33.401909
3867	1	10	54	3	\N	2018-01-26	-500.00	0a55934d481127bd4c81ac1b76ed45ee	2020-10-23 22:40:33.404184	2020-10-23 22:40:33.404184
3868	1	10	54	3	\N	2018-01-26	-1000.00	45fbc6d3e05ebd93369ce542e8f2322d	2020-10-23 22:40:33.405846	2020-10-23 22:40:33.405846
3869	1	10	54	3	\N	2018-01-26	-1000.00	4440abdeb0c14417ecc1dfd7d0753d72	2020-10-23 22:40:33.408198	2020-10-23 22:40:33.408198
3870	5	10	54	4	\N	2018-01-26	1000.00	4440abdeb0c14417ecc1dfd7d0753d72	2020-10-23 22:40:33.410137	2020-10-23 22:40:33.410137
3871	5	1	-1	2	\N	2018-01-27	-8.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.412005	2020-10-23 22:40:33.412005
3872	5	1	-1	2	\N	2018-01-27	-143.80	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.413881	2020-10-23 22:40:33.413881
3873	5	1	-1	2	\N	2018-01-27	-18.12	8c7bbbba95c1025975e548cee86dfadc	2020-10-23 22:40:33.41565	2020-10-23 22:40:33.41565
3874	2	2	3	1	\N	2018-01-27	1720.20	c7796e6bcbe26d476b2246e04d8176f6	2020-10-23 22:40:33.417519	2020-10-23 22:40:33.417519
3875	2	2	3	1	\N	2018-01-27	6368.42	2fd60519570054c301d09557a2d45f9e	2020-10-23 22:40:33.419332	2020-10-23 22:40:33.419332
3876	2	10	54	3	\N	2018-01-27	-1500.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:33.421108	2020-10-23 22:40:33.421108
3877	5	10	54	4	\N	2018-01-27	1500.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:33.422977	2020-10-23 22:40:33.422977
3878	2	10	54	3	\N	2018-01-27	-5000.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.424937	2020-10-23 22:40:33.424937
3879	6	10	54	4	\N	2018-01-27	5000.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.42709	2020-10-23 22:40:33.42709
3880	2	10	54	3	\N	2018-01-27	-800.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:33.429244	2020-10-23 22:40:33.429244
3881	4	10	54	4	\N	2018-01-27	800.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:33.431195	2020-10-23 22:40:33.431195
3882	2	9	48	2	\N	2018-01-27	-30.00	fb4468645f162092401b2488483bb691	2020-10-23 22:40:33.432868	2020-10-23 22:40:33.432868
3883	2	9	48	2	\N	2018-01-27	-39.92	fb4468645f162092401b2488483bb691	2020-10-23 22:40:33.434441	2020-10-23 22:40:33.434441
3884	2	5	23	2	\N	2018-01-27	-34.98	e0eba56742c8f78998d4adf5aba57829	2020-10-23 22:40:33.435965	2020-10-23 22:40:33.435965
3885	2	6	27	2	\N	2018-01-27	-38.50	204a3eeab2a68f6bd87db22983749c42	2020-10-23 22:40:33.437325	2020-10-23 22:40:33.437325
3886	5	4	-1	2	\N	2018-01-27	-590.00	08c5433a60135c32e34f46a71175850c	2020-10-23 22:40:33.438753	2020-10-23 22:40:33.438753
3887	5	4	13	2	\N	2018-01-27	-391.79	9be40cee5b0eee1462c82c6964087ff9	2020-10-23 22:40:33.440244	2020-10-23 22:40:33.440244
3888	5	4	15	2	\N	2018-01-27	-133.16	1f7f31128359ac99188a716d5846f270	2020-10-23 22:40:33.441532	2020-10-23 22:40:33.441532
3889	5	4	16	2	\N	2018-01-27	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:40:33.442898	2020-10-23 22:40:33.442898
3890	5	1	-1	2	\N	2018-01-28	-18.70	41ae36ecb9b3eee609d05b90c14222fb	2020-10-23 22:40:33.444476	2020-10-23 22:40:33.444476
3891	5	4	13	2	\N	2018-01-29	-27.43	979d472a84804b9f647bc185a877a8b5	2020-10-23 22:40:33.446323	2020-10-23 22:40:33.446323
3892	5	1	-1	2	\N	2018-01-30	-20.71	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:33.447903	2020-10-23 22:40:33.447903
3893	2	4	18	2	\N	2018-01-31	-29.00	b798c28e671592bc0fe82b05d71c69ba	2020-10-23 22:40:33.449701	2020-10-23 22:40:33.449701
3894	2	9	48	2	\N	2018-02-01	-10.00	1b5355fe75bd31e9be9b748743e45cec	2020-10-23 22:40:33.451643	2020-10-23 22:40:33.451643
3895	2	5	21	2	\N	2018-02-01	-43.12	97ab62d3ffd876fc9ae166589b9cde1b	2020-10-23 22:40:33.453619	2020-10-23 22:40:33.453619
3896	5	5	26	2	\N	2018-02-01	-30.44	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:40:33.455121	2020-10-23 22:40:33.455121
3897	5	5	23	2	\N	2018-02-01	-31.48	d8e5885d6308db44f63cfc0fc7b4644a	2020-10-23 22:40:33.456926	2020-10-23 22:40:33.456926
3898	2	3	-1	2	\N	2018-02-02	-14.00	e0875a7d00226102ef260a579ef5e697	2020-10-23 22:40:33.458815	2020-10-23 22:40:33.458815
3899	2	1	-1	2	\N	2018-02-02	-8.80	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:33.460714	2020-10-23 22:40:33.460714
3900	2	6	27	1	\N	2018-02-02	79.98	f1876419406791a07585a978e9644c74	2020-10-23 22:40:33.462493	2020-10-23 22:40:33.462493
3901	2	9	-1	1	\N	2018-02-02	64.30	6a9135d42c779d2dcd1d32199053ec6a	2020-10-23 22:40:33.464296	2020-10-23 22:40:33.464296
3902	1	10	54	3	\N	2018-02-01	-7000.00	4a429e0b8871ec788a3a171545d959e8	2020-10-23 22:40:33.465727	2020-10-23 22:40:33.465727
3903	1	1	-1	2	\N	2018-02-01	-11.56	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.467177	2020-10-23 22:40:33.467177
3904	1	1	-1	2	\N	2018-02-01	-19.57	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.468752	2020-10-23 22:40:33.468752
3905	1	1	-1	2	\N	2018-02-01	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:33.470613	2020-10-23 22:40:33.470613
3906	1	2	-1	1	\N	2018-02-02	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.472409	2020-10-23 22:40:33.472409
3907	1	2	-1	1	\N	2018-01-29	51.00	52be5fecc6cde2c0602277e8b50135e1	2020-10-23 22:40:33.474268	2020-10-23 22:40:33.474268
3908	1	1	-1	2	\N	2018-01-31	-12.95	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.475882	2020-10-23 22:40:33.475882
3909	5	7	33	2	\N	2018-02-02	-15.00	d81fee4887336b1dba216cfff99bd9e6	2020-10-23 22:40:33.477421	2020-10-23 22:40:33.477421
3910	1	9	-1	2	\N	2018-02-02	-64.95	7e86f7d63279fc772b30b42aebda6111	2020-10-23 22:40:33.478991	2020-10-23 22:40:33.478991
3911	6	10	55	1	\N	2018-01-31	109.53	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:33.480441	2020-10-23 22:40:33.480441
3912	1	1	-1	2	\N	2018-02-02	-23.04	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.481887	2020-10-23 22:40:33.481887
3913	5	1	-1	2	\N	2018-02-03	-10.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.483281	2020-10-23 22:40:33.483281
3914	1	9	48	2	\N	2018-02-03	-14.99	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:40:33.484796	2020-10-23 22:40:33.484796
3915	5	1	-1	2	\N	2018-02-03	-116.95	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:33.486094	2020-10-23 22:40:33.486094
3916	2	1	-1	2	\N	2018-02-02	-14.48	502e4a16930e414107ee22b6198c578f	2020-10-23 22:40:33.487636	2020-10-23 22:40:33.487636
3917	2	1	-1	2	\N	2018-02-02	-21.60	6ac96a01f1a5a89e133480856d7cfcf0	2020-10-23 22:40:33.489615	2020-10-23 22:40:33.489615
3918	5	10	54	4	\N	2018-02-04	5500.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:33.49139	2020-10-23 22:40:33.49139
3919	1	4	18	2	\N	2018-02-03	-19.00	40461a08504dd59433e3aac89554aa51	2020-10-23 22:40:33.492615	2020-10-23 22:40:33.492615
3920	1	2	-1	4	\N	2018-02-04	200.00	1073abc18d56d33f2837a9c706e26740	2020-10-23 22:40:33.494158	2020-10-23 22:40:33.494158
3921	5	9	48	3	\N	2018-02-04	-200.00	1073abc18d56d33f2837a9c706e26740	2020-10-23 22:40:33.495672	2020-10-23 22:40:33.495672
3922	1	9	48	2	\N	2018-02-04	-200.00	92262bf907af914b95a0fc33c3f33bf6	2020-10-23 22:40:33.497303	2020-10-23 22:40:33.497303
3923	1	8	41	2	\N	2018-02-04	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:40:33.499091	2020-10-23 22:40:33.499091
3924	5	1	-1	2	\N	2018-02-04	-88.64	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:33.501315	2020-10-23 22:40:33.501315
3925	5	5	23	2	\N	2018-02-04	-37.48	519915e4ca0861bc51d95832bebcb89b	2020-10-23 22:40:33.503271	2020-10-23 22:40:33.503271
3926	5	5	21	2	\N	2018-02-04	-8.30	7eacb532570ff6858afd2723755ff790	2020-10-23 22:40:33.505317	2020-10-23 22:40:33.505317
3927	2	5	21	2	\N	2018-02-04	-14.90	a5d3078bee99fd4dcf791414fbca1a4f	2020-10-23 22:40:33.506959	2020-10-23 22:40:33.506959
3928	5	10	54	3	\N	2018-02-05	-1500.00	f7b5cf5d4293f27d001c59cfdbc00086	2020-10-23 22:40:33.508844	2020-10-23 22:40:33.508844
3929	6	10	54	4	\N	2018-02-05	1500.00	f7b5cf5d4293f27d001c59cfdbc00086	2020-10-23 22:40:33.510415	2020-10-23 22:40:33.510415
3930	1	10	54	4	\N	2018-02-05	300.00	beb22fb694d513edcf5533cf006dfeae	2020-10-23 22:40:33.512009	2020-10-23 22:40:33.512009
3931	5	10	54	3	\N	2018-02-05	-300.00	beb22fb694d513edcf5533cf006dfeae	2020-10-23 22:40:33.513569	2020-10-23 22:40:33.513569
3932	5	10	54	3	\N	2018-02-07	-2500.00	44bf7b9933876f77884a0ab47dac319a	2020-10-23 22:40:33.515337	2020-10-23 22:40:33.515337
3933	5	1	-1	2	\N	2018-02-05	-144.00	ff8408738b5820e10c31b1d7843a9285	2020-10-23 22:40:33.517306	2020-10-23 22:40:33.517306
3934	1	9	49	2	\N	2018-02-05	-57.96	65d0efc410cb372de67a7c9d1bc95f15	2020-10-23 22:40:33.519032	2020-10-23 22:40:33.519032
3935	2	1	-1	2	\N	2018-02-05	-13.05	4103046c06cfc364d02d4ab82c3fc6cb	2020-10-23 22:40:33.520708	2020-10-23 22:40:33.520708
3936	5	10	54	3	\N	2018-02-06	-2390.47	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.522948	2020-10-23 22:40:33.522948
3937	6	10	54	4	\N	2018-02-06	2390.47	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.524828	2020-10-23 22:40:33.524828
3938	4	10	54	3	\N	2018-02-06	-2341.35	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.52684	2020-10-23 22:40:33.52684
3939	2	10	54	4	\N	2018-02-06	2341.35	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.528596	2020-10-23 22:40:33.528596
3940	2	10	54	3	\N	2018-02-06	-2300.00	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.529879	2020-10-23 22:40:33.529879
3941	5	10	54	4	\N	2018-02-06	2300.00	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:33.531075	2020-10-23 22:40:33.531075
3942	2	1	-1	2	\N	2018-02-07	-12.49	7386b943e784e95d4a89a28046f86e94	2020-10-23 22:40:33.532241	2020-10-23 22:40:33.532241
3943	2	4	16	2	\N	2018-02-08	-19.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:33.53347	2020-10-23 22:40:33.53347
3944	5	8	43	2	\N	2018-02-10	-182.02	6602294be910b1e3c4571bd98c4d5484	2020-10-23 22:40:33.534728	2020-10-23 22:40:33.534728
3945	1	7	33	2	\N	2018-02-12	-208.00	c0acf44b2a10bcda66af8fb929488881	2020-10-23 22:40:33.535948	2020-10-23 22:40:33.535948
3946	1	1	-1	2	\N	2018-02-12	-9.46	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.537132	2020-10-23 22:40:33.537132
3947	1	2	-1	1	\N	2018-02-07	25.00	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:33.538599	2020-10-23 22:40:33.538599
3948	1	7	36	2	\N	2018-02-07	-59.80	cf23ea1d9da4ba76444408abc755f2bb	2020-10-23 22:40:33.540081	2020-10-23 22:40:33.540081
3949	1	3	-1	2	\N	2018-02-10	-12.07	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.541527	2020-10-23 22:40:33.541527
3950	1	10	54	4	\N	2018-02-11	500.00	19f42e77c95b7a5a9a6f36d0b95f0e9f	2020-10-23 22:40:33.542913	2020-10-23 22:40:33.542913
3951	5	5	23	2	\N	2018-02-09	-34.34	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:40:33.544124	2020-10-23 22:40:33.544124
3952	5	5	23	2	\N	2018-02-09	-114.00	1e4ca0db331b0919fbb70c96514764f5	2020-10-23 22:40:33.545288	2020-10-23 22:40:33.545288
3953	5	5	23	2	\N	2018-02-10	-25.85	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:40:33.54682	2020-10-23 22:40:33.54682
3954	5	1	-1	2	\N	2018-02-11	-68.69	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.547961	2020-10-23 22:40:33.547961
3955	1	8	43	2	\N	2018-02-11	-6.00	138bb0696595b338afbab333c555292a	2020-10-23 22:40:33.5491	2020-10-23 22:40:33.5491
3956	1	9	49	3	\N	2018-02-11	-100.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:33.550541	2020-10-23 22:40:33.550541
3957	5	10	54	4	\N	2018-02-12	2500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:33.551988	2020-10-23 22:40:33.551988
3958	1	1	-1	2	\N	2018-02-12	-56.00	edd6b311024aa1094b847933dd729225	2020-10-23 22:40:33.553133	2020-10-23 22:40:33.553133
3959	1	2	-1	1	\N	2018-02-12	50.00	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:33.554206	2020-10-23 22:40:33.554206
3960	1	8	44	2	\N	2018-02-12	-24.74	86c5d849e25cdf86c4a67239415925c6	2020-10-23 22:40:33.555297	2020-10-23 22:40:33.555297
3961	5	1	-1	2	\N	2018-02-12	-6.59	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.556718	2020-10-23 22:40:33.556718
3962	1	2	-1	1	\N	2018-02-14	25.00	5ff832d9bca8241d653279756f3ccd11	2020-10-23 22:40:33.55827	2020-10-23 22:40:33.55827
3963	1	2	-1	1	\N	2018-02-14	28.00	4abbf97c1ed2b6ae4f44905aa7401fe0	2020-10-23 22:40:33.559845	2020-10-23 22:40:33.559845
3964	5	1	-1	2	\N	2018-02-14	-4.80	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:33.561369	2020-10-23 22:40:33.561369
3965	2	2	-1	1	\N	2018-02-15	3077.42	56fbb10d67233396fd603a5ab2893990	2020-10-23 22:40:33.562586	2020-10-23 22:40:33.562586
3966	5	10	54	3	\N	2018-02-16	-1000.00	335b24485713e81adcdd19578ee943e6	2020-10-23 22:40:33.563655	2020-10-23 22:40:33.563655
3967	6	10	54	4	\N	2018-02-16	1000.00	335b24485713e81adcdd19578ee943e6	2020-10-23 22:40:33.56474	2020-10-23 22:40:33.56474
3968	5	10	54	3	\N	2018-02-16	-1100.00	b2c2931b583f7aec9606845cb7271c2d	2020-10-23 22:40:33.565915	2020-10-23 22:40:33.565915
3969	2	10	54	4	\N	2018-02-16	1100.00	b2c2931b583f7aec9606845cb7271c2d	2020-10-23 22:40:33.567017	2020-10-23 22:40:33.567017
3970	1	3	-1	2	\N	2018-02-16	-31.56	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:40:33.568203	2020-10-23 22:40:33.568203
3971	1	1	-1	2	\N	2018-02-17	-24.00	547ddaad46cd88a59726463319458e05	2020-10-23 22:40:33.569446	2020-10-23 22:40:33.569446
3972	1	8	44	2	\N	2018-02-17	-14.15	f5224aef157557157154df8302753df9	2020-10-23 22:40:33.57071	2020-10-23 22:40:33.57071
3973	1	8	41	2	\N	2018-02-17	-27.80	ba55ff88bddf71220a86105441fd2fff	2020-10-23 22:40:33.572083	2020-10-23 22:40:33.572083
3974	1	9	51	2	\N	2018-02-16	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.573847	2020-10-23 22:40:33.573847
3975	1	2	-1	1	\N	2018-02-16	25.00	7504adad8bb96320eb3afdd4df6e1f60	2020-10-23 22:40:33.575226	2020-10-23 22:40:33.575226
3976	1	3	-1	2	\N	2018-02-16	-30.78	f249516a6c501fa547566fd624f6c2a7	2020-10-23 22:40:33.576816	2020-10-23 22:40:33.576816
3977	5	1	-1	2	\N	2018-02-16	-113.38	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.578257	2020-10-23 22:40:33.578257
3978	5	1	-1	2	\N	2018-02-18	-8.26	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.579639	2020-10-23 22:40:33.579639
3979	1	10	54	3	\N	2018-02-11	-200.00	b3acba35dccf9236caea81145263149b	2020-10-23 22:40:33.580929	2020-10-23 22:40:33.580929
3980	1	10	54	4	\N	2018-02-11	200.00	b3acba35dccf9236caea81145263149b	2020-10-23 22:40:33.582462	2020-10-23 22:40:33.582462
3981	5	4	-1	2	\N	2018-02-19	-13.00	55a5d349a037ffe3dac59efac8bb41bf	2020-10-23 22:40:33.584304	2020-10-23 22:40:33.584304
3982	5	4	-1	2	\N	2018-02-19	-18.00	d750731dae20d00a30eaa4da2473e3ea	2020-10-23 22:40:33.585683	2020-10-23 22:40:33.585683
3983	2	5	23	2	\N	2018-02-19	-44.95	e9d86da6f3c5ce5efb8caba44ede2e99	2020-10-23 22:40:33.58718	2020-10-23 22:40:33.58718
3984	2	1	-1	2	\N	2018-02-19	-9.50	b597e5b0e7970deda3d6cf8017b929b7	2020-10-23 22:40:33.588428	2020-10-23 22:40:33.588428
3985	2	5	22	2	\N	2018-02-19	-50.00	06ca655e1cff36fe062f783aa99f7c34	2020-10-23 22:40:33.589868	2020-10-23 22:40:33.589868
3986	2	4	19	2	\N	2018-02-19	-1340.00	0977c8a9495b634a48a90306338cdb85	2020-10-23 22:40:33.591698	2020-10-23 22:40:33.591698
3987	2	10	54	3	\N	2018-02-19	-500.00	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:40:33.593259	2020-10-23 22:40:33.593259
3988	4	10	54	4	\N	2018-02-19	500.00	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:40:33.595597	2020-10-23 22:40:33.595597
3989	2	10	54	3	\N	2018-02-19	-2000.00	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:40:33.597235	2020-10-23 22:40:33.597235
3990	6	10	54	4	\N	2018-02-19	2000.00	c2a5cf2bc1664e53c78d93705650a1df	2020-10-23 22:40:33.598617	2020-10-23 22:40:33.598617
3991	2	9	48	2	\N	2018-02-19	-25.00	f4f450e119f56ef9134f032558a8f31e	2020-10-23 22:40:33.600109	2020-10-23 22:40:33.600109
3992	1	9	48	1	\N	2018-02-19	25.00	5ff832d9bca8241d653279756f3ccd11	2020-10-23 22:40:33.601492	2020-10-23 22:40:33.601492
3993	2	4	16	2	\N	2018-02-24	-14.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:33.602839	2020-10-23 22:40:33.602839
3994	1	10	54	3	\N	2018-02-24	-200.00	1bc3c8b3c3e56862ef1a366669478bbc	2020-10-23 22:40:33.604382	2020-10-23 22:40:33.604382
3995	5	10	54	4	\N	2018-02-24	200.00	1bc3c8b3c3e56862ef1a366669478bbc	2020-10-23 22:40:33.605943	2020-10-23 22:40:33.605943
3996	5	1	-1	2	\N	2018-02-24	-8.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.607657	2020-10-23 22:40:33.607657
3997	5	1	-1	2	\N	2018-02-23	-186.88	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.609173	2020-10-23 22:40:33.609173
3998	5	1	-1	2	\N	2018-02-22	-10.08	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.610744	2020-10-23 22:40:33.610744
3999	5	1	-1	2	\N	2018-02-22	-10.48	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.612364	2020-10-23 22:40:33.612364
4000	1	1	-1	2	\N	2018-02-21	-14.00	53f1ce1310367adfe34e70e39c454d88	2020-10-23 22:40:33.614024	2020-10-23 22:40:33.614024
4001	1	1	-1	2	\N	2018-02-21	-100.00	158e46ebb0fa28059bffc445a6f10da0	2020-10-23 22:40:33.615599	2020-10-23 22:40:33.615599
4002	1	2	-1	1	\N	2018-02-20	25.00	5ff832d9bca8241d653279756f3ccd11	2020-10-23 22:40:33.617431	2020-10-23 22:40:33.617431
4003	5	1	-1	2	\N	2018-02-25	-18.23	24ea02bea379f86ed49fa11257f69ef8	2020-10-23 22:40:33.618934	2020-10-23 22:40:33.618934
4004	5	5	26	2	\N	2018-02-25	-16.79	6c3cf77d52820cd0fe646d38bc2145ca	2020-10-23 22:40:33.620635	2020-10-23 22:40:33.620635
4005	2	5	21	2	\N	2018-02-25	-26.99	64d9d311a00724c464d7eb5e5157ad50	2020-10-23 22:40:33.622142	2020-10-23 22:40:33.622142
4006	2	7	33	2	\N	2018-02-26	-55.00	2e7f585062fd382544f72bdbea6712f0	2020-10-23 22:40:33.623541	2020-10-23 22:40:33.623541
4007	2	7	37	2	\N	2018-02-26	-110.00	40c989cc0bdee457475f49d3f3f8c10a	2020-10-23 22:40:33.625277	2020-10-23 22:40:33.625277
4008	1	9	-1	3	\N	2018-02-26	-22.00	6d5c286b445a88593080b20149758efa	2020-10-23 22:40:33.626918	2020-10-23 22:40:33.626918
4009	1	2	3	1	\N	2018-02-26	9500.41	f4552671f8909587cf485ea990207f3b	2020-10-23 22:40:33.628387	2020-10-23 22:40:33.628387
4010	1	10	54	3	\N	2018-02-26	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:33.629725	2020-10-23 22:40:33.629725
4011	1	10	54	3	\N	2018-02-26	-1000.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:33.631252	2020-10-23 22:40:33.631252
4012	1	1	-1	2	\N	2018-02-27	-15.00	50b05158007666ea639217e9ed49acee	2020-10-23 22:40:33.633098	2020-10-23 22:40:33.633098
4013	5	1	-1	2	\N	2018-02-27	-26.65	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.634796	2020-10-23 22:40:33.634796
4014	1	8	40	2	\N	2018-02-26	-3.00	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:40:33.636946	2020-10-23 22:40:33.636946
4015	5	7	33	3	\N	2018-02-28	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.63861	2020-10-23 22:40:33.63861
4016	1	2	-1	4	\N	2018-02-28	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.640299	2020-10-23 22:40:33.640299
4017	5	1	-1	2	\N	2018-02-28	-8.55	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.642264	2020-10-23 22:40:33.642264
4018	1	9	-1	2	\N	2018-03-01	-21.08	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:40:33.643901	2020-10-23 22:40:33.643901
4019	5	2	-1	1	\N	2018-03-01	14.81	3cbd315f78980e95ecf8147fa93fe3cd	2020-10-23 22:40:33.645618	2020-10-23 22:40:33.645618
4020	1	10	54	3	\N	2018-03-01	-7000.00	d3bda6ff7eabd4e861e899b20c308564	2020-10-23 22:40:33.647054	2020-10-23 22:40:33.647054
4021	6	10	55	1	\N	2018-03-01	108.65	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:33.648379	2020-10-23 22:40:33.648379
4022	1	8	41	2	\N	2018-03-01	-46.00	c95ad2a05a8ddb244c6bc3b1041d3f1f	2020-10-23 22:40:33.649683	2020-10-23 22:40:33.649683
4023	1	9	-1	2	\N	2018-03-01	-150.00	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:33.651126	2020-10-23 22:40:33.651126
4024	2	2	3	1	\N	2018-03-01	14781.07	0706dfd8b8609ec0635c4369b59d699f	2020-10-23 22:40:33.652401	2020-10-23 22:40:33.652401
4025	2	10	54	3	\N	2018-03-01	-1500.00	6f5a6fc883cc9402be5ff5d0648a074f	2020-10-23 22:40:33.653728	2020-10-23 22:40:33.653728
4026	5	10	54	4	\N	2018-03-01	1500.00	6f5a6fc883cc9402be5ff5d0648a074f	2020-10-23 22:40:33.656116	2020-10-23 22:40:33.656116
4027	2	10	54	3	\N	2018-03-01	-10000.00	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:40:33.658187	2020-10-23 22:40:33.658187
4028	6	10	54	4	\N	2018-03-01	10000.00	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:40:33.659951	2020-10-23 22:40:33.659951
4029	5	4	-1	2	\N	2018-03-03	-126.00	004f2da97091f78e4b8b4f669aebc912	2020-10-23 22:40:33.662006	2020-10-23 22:40:33.662006
4030	5	4	13	2	\N	2018-03-03	-391.79	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:33.663495	2020-10-23 22:40:33.663495
4031	5	4	-1	2	\N	2018-03-03	-590.00	0c49aacf018ec46f08a22c75dbe8cf5e	2020-10-23 22:40:33.665455	2020-10-23 22:40:33.665455
4032	5	4	14	2	\N	2018-03-03	-110.79	cf34362ab126ce8338d8991cc1404980	2020-10-23 22:40:33.666972	2020-10-23 22:40:33.666972
4033	5	4	16	2	\N	2018-03-03	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:40:33.668152	2020-10-23 22:40:33.668152
4034	5	5	25	2	\N	2018-03-04	-20.00	202cb962ac59075b964b07152d234b70	2020-10-23 22:40:33.669571	2020-10-23 22:40:33.669571
4035	1	9	51	2	\N	2018-03-02	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.670703	2020-10-23 22:40:33.670703
4036	5	9	48	2	\N	2018-03-04	-25.60	c8c41c4a18675a74e01c8a20e8a0f662	2020-10-23 22:40:33.671798	2020-10-23 22:40:33.671798
4037	5	1	-1	2	\N	2018-03-02	-142.72	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:33.67299	2020-10-23 22:40:33.67299
4038	5	1	-1	2	\N	2018-03-01	-18.80	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:33.674282	2020-10-23 22:40:33.674282
4039	5	1	-1	2	\N	2018-03-01	-8.50	dd982884edf68487cb8ff664b3dfdf12	2020-10-23 22:40:33.675569	2020-10-23 22:40:33.675569
4040	5	1	-1	2	\N	2018-03-04	-10.92	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:33.676904	2020-10-23 22:40:33.676904
4041	2	10	54	3	\N	2018-03-02	-1500.00	2ad2fbd0bf44a168601b559e41b8758d	2020-10-23 22:40:33.678181	2020-10-23 22:40:33.678181
4042	5	10	54	4	\N	2018-03-05	5500.00	558cb90273f237253bb874c790d52587	2020-10-23 22:40:33.679403	2020-10-23 22:40:33.679403
4043	1	10	54	4	\N	2018-03-04	4000.00	b447314072b1439f33c41317de66748b	2020-10-23 22:40:33.681204	2020-10-23 22:40:33.681204
4044	1	4	-1	2	\N	2018-03-04	-974.00	14d63dbd7ad2642d1926f74f2ec8b341	2020-10-23 22:40:33.682404	2020-10-23 22:40:33.682404
4045	1	8	43	2	\N	2018-03-04	-241.89	ace4eadc8ba7f37ce292e6aef3ec64f1	2020-10-23 22:40:33.683591	2020-10-23 22:40:33.683591
4046	5	1	-1	2	\N	2018-03-05	-3.58	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:33.684753	2020-10-23 22:40:33.684753
4047	5	9	-1	3	\N	2018-03-06	-608.77	08a641013301b0c0294304b3e7b2f45c	2020-10-23 22:40:33.686232	2020-10-23 22:40:33.686232
4048	6	10	54	4	\N	2018-03-06	608.77	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:33.68742	2020-10-23 22:40:33.68742
4049	5	10	54	3	\N	2018-03-06	-500.00	102a31bba84c93e69dc27d8015863957	2020-10-23 22:40:33.688598	2020-10-23 22:40:33.688598
4050	1	10	54	4	\N	2018-03-06	500.00	102a31bba84c93e69dc27d8015863957	2020-10-23 22:40:33.689806	2020-10-23 22:40:33.689806
4051	1	8	44	2	\N	2018-03-06	-25.44	dd770d3392932ac08ff1184c966108fe	2020-10-23 22:40:33.691209	2020-10-23 22:40:33.691209
4052	5	10	54	3	\N	2018-03-07	-2500.00	52c5ddf28d2bb239fdb3e04ebe23cc5f	2020-10-23 22:40:33.692401	2020-10-23 22:40:33.692401
4053	1	9	48	2	\N	2018-03-08	-40.00	61de962f19b684dc9ce24c0fdcdbd0de	2020-10-23 22:40:33.693565	2020-10-23 22:40:33.693565
4054	5	8	43	2	\N	2018-03-08	-232.20	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:33.69477	2020-10-23 22:40:33.69477
4055	5	1	-1	2	\N	2018-03-08	-8.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.696374	2020-10-23 22:40:33.696374
4056	5	1	-1	2	\N	2018-03-08	-17.92	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:33.697913	2020-10-23 22:40:33.697913
4057	5	5	23	2	\N	2018-03-08	-22.49	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.69927	2020-10-23 22:40:33.69927
4058	5	1	-1	2	\N	2018-03-09	-139.26	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:33.700407	2020-10-23 22:40:33.700407
4059	5	3	-1	2	\N	2018-03-09	-13.59	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.701562	2020-10-23 22:40:33.701562
4060	5	1	-1	2	\N	2018-03-07	-6.30	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:33.702714	2020-10-23 22:40:33.702714
4061	5	5	23	2	\N	2018-03-07	-20.47	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.703857	2020-10-23 22:40:33.703857
4062	5	1	-1	2	\N	2018-03-10	-7.92	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:40:33.705068	2020-10-23 22:40:33.705068
4063	5	1	-1	2	\N	2018-03-10	-5.40	d9f61279b8182ce2acbd0d88a5ff8918	2020-10-23 22:40:33.706285	2020-10-23 22:40:33.706285
4064	5	8	43	2	\N	2018-03-11	-94.99	064f64f3f721532db519b408e4fb57c6	2020-10-23 22:40:33.707627	2020-10-23 22:40:33.707627
4065	2	9	-1	2	\N	2018-03-12	-106.50	b7bb35b9c6ca2aee2df08cf09d7016c2	2020-10-23 22:40:33.709016	2020-10-23 22:40:33.709016
4066	2	9	47	2	\N	2018-03-12	-50.00	788d986905533aba051261497ecffcbb	2020-10-23 22:40:33.710432	2020-10-23 22:40:33.710432
4067	2	4	18	2	\N	2018-03-12	-29.00	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:40:33.711576	2020-10-23 22:40:33.711576
4068	2	8	41	2	\N	2018-03-12	-50.00	e820f3a30380e5c6e584268c302d35fa	2020-10-23 22:40:33.713081	2020-10-23 22:40:33.713081
4069	2	10	54	3	\N	2018-03-12	-500.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:33.714705	2020-10-23 22:40:33.714705
4070	4	10	54	4	\N	2018-03-12	500.00	82150a0eb9986ec8aeba71776a43b5f0	2020-10-23 22:40:33.716242	2020-10-23 22:40:33.716242
4071	2	10	54	3	\N	2018-03-12	-1000.00	0ff8033cf9437c213ee13937b1c4c455	2020-10-23 22:40:33.717419	2020-10-23 22:40:33.717419
4072	5	10	54	4	\N	2018-03-12	1000.00	0ff8033cf9437c213ee13937b1c4c455	2020-10-23 22:40:33.718616	2020-10-23 22:40:33.718616
4073	5	10	54	4	\N	2018-03-12	2500.00	8efcba51452ad4de43c64649e3177b80	2020-10-23 22:40:33.719741	2020-10-23 22:40:33.719741
4074	5	1	-1	2	\N	2018-03-12	-5.37	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:33.72089	2020-10-23 22:40:33.72089
4075	1	7	36	2	\N	2018-03-12	-16.99	5fd0b37cd7dbbb00f97ba6ce92bf5add	2020-10-23 22:40:33.722089	2020-10-23 22:40:33.722089
4076	2	1	-1	2	\N	2018-03-13	-31.00	5c572eca050594c7bc3c36e7e8ab9550	2020-10-23 22:40:33.723445	2020-10-23 22:40:33.723445
4077	2	3	-1	2	\N	2018-03-13	-18.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.724671	2020-10-23 22:40:33.724671
4078	2	7	37	2	\N	2018-03-13	-19.99	c113e6c00b0912d0db9497a1f397f864	2020-10-23 22:40:33.725928	2020-10-23 22:40:33.725928
4079	5	5	23	2	\N	2018-03-14	-7.00	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.727214	2020-10-23 22:40:33.727214
4080	5	1	-1	2	\N	2018-03-15	-3.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.728365	2020-10-23 22:40:33.728365
4081	5	1	-1	2	\N	2018-03-16	-152.13	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.729503	2020-10-23 22:40:33.729503
4082	5	1	-1	2	\N	2018-03-15	-9.59	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.730707	2020-10-23 22:40:33.730707
4083	5	1	-1	2	\N	2018-03-14	-10.47	b5aa8d454b5d69881cb4da89af4dbc92	2020-10-23 22:40:33.731843	2020-10-23 22:40:33.731843
4084	1	7	37	2	\N	2018-03-17	-81.76	d6c651ddcd97183b2e40bc464231c962	2020-10-23 22:40:33.733069	2020-10-23 22:40:33.733069
4085	5	1	-1	2	\N	2018-03-17	-9.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.734221	2020-10-23 22:40:33.734221
4086	5	5	23	2	\N	2018-03-17	-9.95	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:33.735379	2020-10-23 22:40:33.735379
4087	5	1	-1	2	\N	2018-03-17	-3.58	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.736501	2020-10-23 22:40:33.736501
4088	1	4	18	2	\N	2018-03-18	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.73754	2020-10-23 22:40:33.73754
4089	2	4	16	2	\N	2018-03-18	-14.99	b7cd5863ecc6125b74e0b55c6e41af17	2020-10-23 22:40:33.73864	2020-10-23 22:40:33.73864
4090	2	1	-1	2	\N	2018-03-18	-35.00	051e4e127b92f5d98d3c79b195f2b291	2020-10-23 22:40:33.73971	2020-10-23 22:40:33.73971
4091	2	1	-1	2	\N	2018-03-18	-33.50	7fa732b517cbed14a48843d74526c11a	2020-10-23 22:40:33.741046	2020-10-23 22:40:33.741046
4092	2	1	-1	2	\N	2018-03-18	-11.88	a5f7d7322cef445eeceff67de18a1254	2020-10-23 22:40:33.742616	2020-10-23 22:40:33.742616
4093	5	1	-1	2	\N	2018-03-18	-10.97	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:40:33.743774	2020-10-23 22:40:33.743774
4094	5	4	-1	2	\N	2018-03-19	-195.00	1ca0e26db8434056b5c8fb8ba22a5e96	2020-10-23 22:40:33.744958	2020-10-23 22:40:33.744958
4095	1	5	21	2	\N	2018-03-19	-7.58	e64770ac6bac05626b4f59b6a03e2ff8	2020-10-23 22:40:33.746102	2020-10-23 22:40:33.746102
4096	1	9	48	2	\N	2018-03-19	-149.00	bc02825482843c73c56392a0aa0da165	2020-10-23 22:40:33.747228	2020-10-23 22:40:33.747228
4097	5	1	-1	2	\N	2018-03-20	-4.99	b19ecf34e19dc5a67d9aa76728133e59	2020-10-23 22:40:33.748274	2020-10-23 22:40:33.748274
4098	2	1	-1	2	\N	2018-03-21	-3.60	23b66dd4d9be6bba639bc882f30f5475	2020-10-23 22:40:33.749349	2020-10-23 22:40:33.749349
4099	5	8	43	2	\N	2018-03-21	-272.00	913bc9230eeef481fc118ab0e8b7f40d	2020-10-23 22:40:33.750461	2020-10-23 22:40:33.750461
4100	5	5	23	2	\N	2018-03-21	-3.00	db8aa89a5984798f253e576c40980ee7	2020-10-23 22:40:33.751622	2020-10-23 22:40:33.751622
4101	5	1	-1	2	\N	2018-03-21	-9.90	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:33.752767	2020-10-23 22:40:33.752767
4102	1	1	-1	2	\N	2018-03-21	-15.30	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.782646	2020-10-23 22:40:33.782646
4103	5	4	16	2	\N	2018-03-22	-59.80	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:33.784095	2020-10-23 22:40:33.784095
4104	2	5	23	2	\N	2018-03-21	-19.13	1595af6435015c77a7149e92a551338e	2020-10-23 22:40:33.785253	2020-10-23 22:40:33.785253
4105	5	1	-1	2	\N	2018-03-22	-11.95	9ee80664be5e7dc42f4e2b3872cd2ab0	2020-10-23 22:40:33.786408	2020-10-23 22:40:33.786408
4106	1	3	-1	2	\N	2018-03-23	-50.43	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.788001	2020-10-23 22:40:33.788001
4107	5	5	23	2	\N	2018-03-22	-27.61	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.789202	2020-10-23 22:40:33.789202
4108	5	8	43	2	\N	2018-03-23	-98.00	3afa03758825774293e45362314f5592	2020-10-23 22:40:33.790313	2020-10-23 22:40:33.790313
4109	5	1	-1	2	\N	2018-03-24	-11.86	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.791466	2020-10-23 22:40:33.791466
4110	5	1	-1	2	\N	2018-03-22	-11.36	ffe7388dd3c316553b51162b87272c9f	2020-10-23 22:40:33.792581	2020-10-23 22:40:33.792581
4111	5	1	-1	2	\N	2018-03-23	-230.00	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.793672	2020-10-23 22:40:33.793672
4112	5	1	-1	2	\N	2018-03-23	-16.70	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:33.794801	2020-10-23 22:40:33.794801
4113	5	1	-1	2	\N	2018-03-22	-16.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.795951	2020-10-23 22:40:33.795951
4114	1	7	30	2	\N	2018-03-25	-25.00	9b432723daa16652e28d1ff06288ff52	2020-10-23 22:40:33.797064	2020-10-23 22:40:33.797064
4115	1	1	-1	2	\N	2018-03-25	-3.99	0b8aff0438617c055eb55f0ba5d226fa	2020-10-23 22:40:33.79823	2020-10-23 22:40:33.79823
4116	2	1	-1	2	\N	2018-03-26	-85.50	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:33.799785	2020-10-23 22:40:33.799785
4117	2	9	47	2	\N	2018-03-26	-50.00	4daa3db355ef2b0e64b472968cb70f0d	2020-10-23 22:40:33.801724	2020-10-23 22:40:33.801724
4118	2	3	-1	2	\N	2018-03-26	-10.50	8e41b8197a1e94d06214743e740314b2	2020-10-23 22:40:33.803519	2020-10-23 22:40:33.803519
4119	5	7	31	2	\N	2018-03-26	-22.00	c1afefbc15e0f4065b2157ac0b2d551a	2020-10-23 22:40:33.80536	2020-10-23 22:40:33.80536
4120	1	9	48	2	\N	2018-03-26	-49.99	ed4388cbca96dd6e0b49fe17270a6ecb	2020-10-23 22:40:33.807197	2020-10-23 22:40:33.807197
4121	1	5	23	2	\N	2018-03-26	-210.02	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:33.809288	2020-10-23 22:40:33.809288
4122	1	7	36	2	\N	2018-03-26	-250.39	ca8155f4d27f205953f9d3d7974bdd70	2020-10-23 22:40:33.811267	2020-10-23 22:40:33.811267
4123	1	2	3	1	\N	2018-03-26	9500.59	5283e034e61c8db740a2bbe6a0ad5852	2020-10-23 22:40:33.813247	2020-10-23 22:40:33.813247
4124	1	10	54	3	\N	2018-03-26	-500.00	191d265f565c43a94aee148f925c4811	2020-10-23 22:40:33.815197	2020-10-23 22:40:33.815197
4125	1	10	54	3	\N	2018-03-26	-1000.00	0f6c4825aed47c4c35acf3f3a3d00cf8	2020-10-23 22:40:33.816911	2020-10-23 22:40:33.816911
4126	1	10	54	3	\N	2018-03-26	-1000.00	c60dd8eb128dacd4181e2e3889de79e8	2020-10-23 22:40:33.818752	2020-10-23 22:40:33.818752
4127	6	10	54	4	\N	2018-03-26	1000.00	c60dd8eb128dacd4181e2e3889de79e8	2020-10-23 22:40:33.820364	2020-10-23 22:40:33.820364
4128	1	9	51	2	\N	2018-03-26	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.821951	2020-10-23 22:40:33.821951
4129	5	1	-1	2	\N	2018-03-28	-16.99	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:40:33.823353	2020-10-23 22:40:33.823353
4130	2	7	37	1	\N	2018-03-28	73.70	c57f7ababb03b7eb12334994aa3235e9	2020-10-23 22:40:33.825207	2020-10-23 22:40:33.825207
4131	2	7	37	1	\N	2018-03-28	70.70	c57f7ababb03b7eb12334994aa3235e9	2020-10-23 22:40:33.826434	2020-10-23 22:40:33.826434
4132	2	2	3	1	\N	2018-03-28	5750.32	99e1a134b5162ec1f876acde751211ea	2020-10-23 22:40:33.828071	2020-10-23 22:40:33.828071
4133	2	10	54	3	\N	2018-03-29	-1500.00	769879b4fb85edac3863871265c6a7b8	2020-10-23 22:40:33.829156	2020-10-23 22:40:33.829156
4134	5	10	54	4	\N	2018-03-29	1500.00	769879b4fb85edac3863871265c6a7b8	2020-10-23 22:40:33.830214	2020-10-23 22:40:33.830214
4135	2	10	54	3	\N	2018-03-29	-500.00	9b0a5fa32a0adc5f4f86a750a1c72e98	2020-10-23 22:40:33.831248	2020-10-23 22:40:33.831248
4136	4	10	54	4	\N	2018-03-29	500.00	9b0a5fa32a0adc5f4f86a750a1c72e98	2020-10-23 22:40:33.832287	2020-10-23 22:40:33.832287
4137	2	10	54	3	\N	2018-03-29	-2000.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.833341	2020-10-23 22:40:33.833341
4138	6	10	54	4	\N	2018-03-29	2000.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.834561	2020-10-23 22:40:33.834561
4139	5	4	-1	2	\N	2018-03-29	-590.00	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:40:33.835952	2020-10-23 22:40:33.835952
4140	5	4	13	2	\N	2018-03-29	-419.22	b6aea7af56564f32a22ce27f25936b82	2020-10-23 22:40:33.837347	2020-10-23 22:40:33.837347
4141	5	4	15	2	\N	2018-03-29	-80.32	07e1cd7dca89a1678042477183b7ac3f	2020-10-23 22:40:33.838588	2020-10-23 22:40:33.838588
4142	5	7	30	2	\N	2018-03-30	-200.00	d79336faaadf20ff5134b0de737a47cd	2020-10-23 22:40:33.83973	2020-10-23 22:40:33.83973
4143	1	9	51	2	\N	2018-03-29	-20.00	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:33.841412	2020-10-23 22:40:33.841412
4144	1	7	37	2	\N	2018-03-31	-8.99	ff4d5fbbafdf976cfdc032e3bde78de5	2020-10-23 22:40:33.842656	2020-10-23 22:40:33.842656
4145	5	5	23	3	\N	2018-03-31	-226.00	e9c508d0670cbac92033a5486cbb2615	2020-10-23 22:40:33.843744	2020-10-23 22:40:33.843744
4146	1	2	-1	4	\N	2018-03-31	226.00	e9c508d0670cbac92033a5486cbb2615	2020-10-23 22:40:33.84483	2020-10-23 22:40:33.84483
4147	1	10	54	3	\N	2018-03-31	-7000.00	ebd9629fc3ae5e9f6611e2ee05a31cef	2020-10-23 22:40:33.845969	2020-10-23 22:40:33.845969
4148	5	7	33	3	\N	2018-03-31	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.847072	2020-10-23 22:40:33.847072
4149	1	2	-1	4	\N	2018-03-31	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:33.848158	2020-10-23 22:40:33.848158
4150	2	5	23	1	\N	2018-03-22	109.59	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:33.849484	2020-10-23 22:40:33.849484
4151	1	9	-1	2	\N	2018-04-01	-34.33	00ec53c4682d36f5c4359f4ae7bd7ba1	2020-10-23 22:40:33.850661	2020-10-23 22:40:33.850661
4152	5	9	-1	2	\N	2018-04-01	-8.63	00ec53c4682d36f5c4359f4ae7bd7ba1	2020-10-23 22:40:33.851751	2020-10-23 22:40:33.851751
4153	1	9	-1	2	\N	2018-04-01	-146.86	1ce5080e5aaead15cb3b5f62558e7164	2020-10-23 22:40:33.866766	2020-10-23 22:40:33.866766
4154	1	8	41	2	\N	2018-04-01	-46.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:40:33.868052	2020-10-23 22:40:33.868052
4155	6	2	-1	4	\N	2018-04-02	200.00	4324bb834e17ddb66ac56d51a659dace	2020-10-23 22:40:33.8692	2020-10-23 22:40:33.8692
4156	6	10	55	1	\N	2018-04-01	134.90	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:33.870305	2020-10-23 22:40:33.870305
4157	5	1	-1	2	\N	2018-04-02	-3.40	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:33.87146	2020-10-23 22:40:33.87146
4158	5	8	43	2	\N	2018-04-01	-179.36	dd770d3392932ac08ff1184c966108fe	2020-10-23 22:40:33.872609	2020-10-23 22:40:33.872609
4159	2	7	32	2	\N	2018-04-02	-306.94	1ddd5cbfaad65fd327ac0cb6ad8ca2b8	2020-10-23 22:40:33.873781	2020-10-23 22:40:33.873781
4160	2	9	-1	1	\N	2018-04-03	105.00	13156e347b1734f38db62eea70f7b0a5	2020-10-23 22:40:33.875217	2020-10-23 22:40:33.875217
4161	2	4	18	2	\N	2018-04-03	-19.99	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.876498	2020-10-23 22:40:33.876498
4162	5	4	-1	2	\N	2018-04-05	-189.00	53e3a7161e428b65688f14b84d61c610	2020-10-23 22:40:33.8776	2020-10-23 22:40:33.8776
4163	5	1	-1	2	\N	2018-04-06	-121.41	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:33.878657	2020-10-23 22:40:33.878657
4164	1	8	45	2	\N	2018-04-08	-22.00	89040245036dd537f7de0ef773bc49be	2020-10-23 22:40:33.879645	2020-10-23 22:40:33.879645
4165	1	7	30	2	\N	2018-04-07	-25.00	7a614fd06c325499f1680b9896beedeb	2020-10-23 22:40:33.880736	2020-10-23 22:40:33.880736
4166	1	1	-1	2	\N	2018-04-07	-56.50	84b87c1712e72207f984e3422a1141dc	2020-10-23 22:40:33.881868	2020-10-23 22:40:33.881868
4167	1	3	-1	2	\N	2018-04-06	-18.00	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:33.882893	2020-10-23 22:40:33.882893
4168	1	1	-1	2	\N	2018-04-06	-13.11	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:33.88394	2020-10-23 22:40:33.88394
4169	1	1	-1	2	\N	2018-04-05	-43.90	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:40:33.885002	2020-10-23 22:40:33.885002
4170	1	3	-1	2	\N	2018-04-05	-23.47	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.886168	2020-10-23 22:40:33.886168
4171	1	8	45	2	\N	2018-04-04	-21.79	5705e1164a8394aace6018e27d20d237	2020-10-23 22:40:33.887323	2020-10-23 22:40:33.887323
4172	5	1	-1	2	\N	2018-04-06	-1.25	63dc7ed1010d3c3b8269faf0ba7491d4	2020-10-23 22:40:33.888532	2020-10-23 22:40:33.888532
4173	5	1	-1	2	\N	2018-04-05	-6.28	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.889663	2020-10-23 22:40:33.889663
4174	5	10	54	4	\N	2018-04-04	5500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:33.890754	2020-10-23 22:40:33.890754
4175	5	10	54	3	\N	2018-04-08	-200.00	f2d55651da3ccc07bce92c32b85ba563	2020-10-23 22:40:33.891879	2020-10-23 22:40:33.891879
4176	6	8	43	2	\N	2018-04-09	-585.00	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:33.893086	2020-10-23 22:40:33.893086
4177	1	5	22	2	\N	2018-04-09	-1769.00	3692e633c258493a1a98c641e947569b	2020-10-23 22:40:33.894405	2020-10-23 22:40:33.894405
4178	1	1	-1	2	\N	2018-04-09	-13.36	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.89548	2020-10-23 22:40:33.89548
4179	5	10	54	3	\N	2018-04-09	-2500.00	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:40:33.896641	2020-10-23 22:40:33.896641
4180	5	10	54	4	\N	2018-04-10	2500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:33.897811	2020-10-23 22:40:33.897811
4181	1	4	18	2	\N	2018-04-11	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:33.89899	2020-10-23 22:40:33.89899
4182	1	1	-1	2	\N	2018-04-12	-26.98	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.900342	2020-10-23 22:40:33.900342
4183	5	1	-1	2	\N	2018-04-11	-4.99	3dd5307908f9499d0e37c2f1fcb0059f	2020-10-23 22:40:33.901537	2020-10-23 22:40:33.901537
4184	5	1	-1	2	\N	2018-04-11	-3.75	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:33.902702	2020-10-23 22:40:33.902702
4185	5	8	43	2	\N	2018-04-12	-761.00	bc02825482843c73c56392a0aa0da165	2020-10-23 22:40:33.903769	2020-10-23 22:40:33.903769
4186	5	1	-1	2	\N	2018-04-10	-2.36	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:33.904906	2020-10-23 22:40:33.904906
4187	6	10	54	3	\N	2018-04-11	-43000.00	599f127bd63e32d6fd5457f9f1fa1e14	2020-10-23 22:40:33.906292	2020-10-23 22:40:33.906292
4188	5	10	54	4	\N	2018-04-11	43000.00	599f127bd63e32d6fd5457f9f1fa1e14	2020-10-23 22:40:33.907623	2020-10-23 22:40:33.907623
4189	2	5	21	2	\N	2018-04-14	-82.90	081b16bcd52a14c866fe2ab1ae3c065a	2020-10-23 22:40:33.90897	2020-10-23 22:40:33.90897
4190	2	5	23	2	\N	2018-04-14	-3.99	7fe1f8abaad094e0b5cb1b01d712f708	2020-10-23 22:40:33.910102	2020-10-23 22:40:33.910102
4191	5	9	48	2	\N	2018-04-14	-44.40	ed131ab781d9cbb68656dbca262aefd4	2020-10-23 22:40:33.911442	2020-10-23 22:40:33.911442
4192	2	3	-1	2	\N	2018-04-13	-16.50	f1a333688622b5bc6da3e9c4d2ef76e5	2020-10-23 22:40:33.912584	2020-10-23 22:40:33.912584
4193	2	1	-1	2	\N	2018-04-14	-7.56	a2962a1fa38aa0c4755ab89a6605e755	2020-10-23 22:40:33.913718	2020-10-23 22:40:33.913718
4194	2	4	16	2	\N	2018-04-16	-14.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:40:33.91476	2020-10-23 22:40:33.91476
4195	1	1	-1	2	\N	2018-04-13	-19.10	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:33.915768	2020-10-23 22:40:33.915768
4196	1	7	36	2	\N	2018-04-14	-89.80	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:40:33.916848	2020-10-23 22:40:33.916848
4197	1	7	35	2	\N	2018-04-16	-62.80	430c3626b879b4005d41b8a46172e0c0	2020-10-23 22:40:33.917951	2020-10-23 22:40:33.917951
4198	5	8	43	2	\N	2018-04-15	-216.31	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:33.919016	2020-10-23 22:40:33.919016
4199	5	5	23	2	\N	2018-04-13	-16.49	6db9d974cbdaf126d4f08e80f71f3166	2020-10-23 22:40:33.92015	2020-10-23 22:40:33.92015
4200	5	1	-1	2	\N	2018-04-13	-161.76	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.921516	2020-10-23 22:40:33.921516
4201	5	1	-1	2	\N	2018-04-14	-7.48	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:33.922621	2020-10-23 22:40:33.922621
4202	5	1	-1	2	\N	2018-04-14	-7.98	d6ce0af67d10d5d0f73bd7744a15d3cb	2020-10-23 22:40:33.923709	2020-10-23 22:40:33.923709
4203	5	1	-1	2	\N	2018-04-14	-12.50	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:33.925491	2020-10-23 22:40:33.925491
4204	5	1	-1	2	\N	2018-04-18	6.58	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.926668	2020-10-23 22:40:33.926668
4205	1	2	-1	1	\N	2018-04-18	50.00	5de65eaca0d9133356857cfd4d77974c	2020-10-23 22:40:33.92771	2020-10-23 22:40:33.92771
4206	5	1	-1	2	\N	2018-04-17	-39.08	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.9288	2020-10-23 22:40:33.9288
4207	5	1	-1	2	\N	2018-04-21	-11.20	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:33.929912	2020-10-23 22:40:33.929912
4208	1	9	48	2	\N	2018-04-21	-22.00	a0950d25a0593f48090ead2dc84abd77	2020-10-23 22:40:33.931027	2020-10-23 22:40:33.931027
4209	1	1	-1	2	\N	2018-04-20	-17.56	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.932142	2020-10-23 22:40:33.932142
4210	5	1	-1	2	\N	2018-04-18	-39.08	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:33.93322	2020-10-23 22:40:33.93322
4211	5	1	-1	2	\N	2018-04-20	-97.19	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:33.934588	2020-10-23 22:40:33.934588
4212	1	1	-1	2	\N	2018-04-21	-6.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:40:33.93566	2020-10-23 22:40:33.93566
4213	1	5	25	2	\N	2018-04-21	-25.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:33.936794	2020-10-23 22:40:33.936794
4214	1	9	51	2	\N	2018-04-21	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:33.937858	2020-10-23 22:40:33.937858
4215	2	6	27	2	\N	2018-04-19	-39.00	621bf66ddb7c962aa0d22ac97d69b793	2020-10-23 22:40:33.938867	2020-10-23 22:40:33.938867
4216	1	10	54	4	\N	2018-04-23	1500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:33.939865	2020-10-23 22:40:33.939865
4217	1	3	-1	2	\N	2018-04-22	-10.50	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.941322	2020-10-23 22:40:33.941322
4218	1	3	-1	2	\N	2018-04-21	-18.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:33.942967	2020-10-23 22:40:33.942967
4219	1	9	48	2	\N	2018-04-23	-12.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:33.944348	2020-10-23 22:40:33.944348
4220	1	9	49	2	\N	2018-04-23	-372.75	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:40:33.945669	2020-10-23 22:40:33.945669
4221	5	1	-1	2	\N	2018-04-23	-14.57	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.946848	2020-10-23 22:40:33.946848
4222	2	5	21	2	\N	2018-04-24	-99.80	766ebcd59621e305170616ba3d3dac32	2020-10-23 22:40:33.948246	2020-10-23 22:40:33.948246
4223	2	5	23	2	\N	2018-04-24	-90.48	bdde48544098c87ef3443a60569f6776	2020-10-23 22:40:33.949437	2020-10-23 22:40:33.949437
4224	2	1	-1	2	\N	2018-04-25	-6.57	e9a34dc534ac1ffc6d2367c17bc69d29	2020-10-23 22:40:33.950573	2020-10-23 22:40:33.950573
4225	2	9	47	2	\N	2018-04-26	-50.00	f8f84f4253ff3acd938d001ca704a84e	2020-10-23 22:40:33.951626	2020-10-23 22:40:33.951626
4226	2	6	27	2	\N	2018-04-26	-39.00	49182f81e6a13cf5eaa496d51fea6406	2020-10-23 22:40:33.952835	2020-10-23 22:40:33.952835
4227	2	2	3	1	\N	2018-04-27	5747.61	29dea2aaf1d32caff9b4566bff2687d6	2020-10-23 22:40:33.954029	2020-10-23 22:40:33.954029
4228	2	10	54	3	\N	2018-04-27	-1500.00	a8ae67a7d91a310d67c643a73cb9d031	2020-10-23 22:40:33.955084	2020-10-23 22:40:33.955084
4229	5	10	54	4	\N	2018-04-27	1500.00	a8ae67a7d91a310d67c643a73cb9d031	2020-10-23 22:40:33.956472	2020-10-23 22:40:33.956472
4230	2	10	54	3	\N	2018-04-27	-500.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:40:33.958064	2020-10-23 22:40:33.958064
4231	4	10	54	4	\N	2018-04-27	500.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:40:33.959299	2020-10-23 22:40:33.959299
4232	2	10	54	3	\N	2018-04-27	-1600.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.960533	2020-10-23 22:40:33.960533
4233	6	10	54	4	\N	2018-04-27	1600.00	c410003ef13d451727aeff9082c29a5c	2020-10-23 22:40:33.961874	2020-10-23 22:40:33.961874
4234	5	4	16	2	\N	2018-04-27	-49.90	578f86aa2e3745f15770e2b0d177c9f6	2020-10-23 22:40:33.962974	2020-10-23 22:40:33.962974
4235	1	9	-1	3	\N	2018-04-26	-20.00	51ef186e18dc00c2d31982567235c559	2020-10-23 22:40:33.964019	2020-10-23 22:40:33.964019
4236	5	3	-1	2	\N	2018-04-27	-17.50	7fa732b517cbed14a48843d74526c11a	2020-10-23 22:40:33.965133	2020-10-23 22:40:33.965133
4237	5	1	-1	2	\N	2018-04-27	-225.67	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:33.966202	2020-10-23 22:40:33.966202
4238	5	1	-1	2	\N	2018-04-26	-4.99	fc698bd6eba4453d16fc4acb4abf4a5a	2020-10-23 22:40:33.967366	2020-10-23 22:40:33.967366
4239	5	1	-1	2	\N	2018-04-25	-5.40	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:33.968451	2020-10-23 22:40:33.968451
4240	1	1	-1	2	\N	2018-04-27	-18.60	e5f6ad6ce374177eef023bf5d0c018b6	2020-10-23 22:40:33.969548	2020-10-23 22:40:33.969548
4241	1	1	-1	2	\N	2018-04-26	-12.70	e5f6ad6ce374177eef023bf5d0c018b6	2020-10-23 22:40:33.971119	2020-10-23 22:40:33.971119
4242	1	1	-1	2	\N	2018-04-25	-14.19	e5f6ad6ce374177eef023bf5d0c018b6	2020-10-23 22:40:33.972205	2020-10-23 22:40:33.972205
4243	1	9	49	2	\N	2018-04-26	-79.50	be3159ad04564bfb90db9e32851ebf9c	2020-10-23 22:40:33.973324	2020-10-23 22:40:33.973324
4244	1	2	3	1	\N	2018-04-27	15337.99	853c0eb6fd1ca116dfe81feb04265569	2020-10-23 22:40:33.974526	2020-10-23 22:40:33.974526
4245	1	10	54	3	\N	2018-04-28	-7500.00	d90876bf4c28d9b5222e4d18eed22ad9	2020-10-23 22:40:33.975866	2020-10-23 22:40:33.975866
4246	6	10	54	4	\N	2018-04-28	7500.00	d90876bf4c28d9b5222e4d18eed22ad9	2020-10-23 22:40:33.97698	2020-10-23 22:40:33.97698
4247	1	10	54	3	\N	2018-04-28	-500.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:33.97811	2020-10-23 22:40:33.97811
4248	1	9	48	2	\N	2018-04-28	-83.97	03791a189ab8540b8fe97dcee9af279f	2020-10-23 22:40:33.979239	2020-10-23 22:40:33.979239
4249	5	1	-1	2	\N	2018-04-28	-88.02	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:33.980959	2020-10-23 22:40:33.980959
4250	5	1	-1	2	\N	2018-04-28	-16.75	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:33.982214	2020-10-23 22:40:33.982214
4251	5	4	-1	2	\N	2018-04-28	-590.00	816b112c6105b3ebd537828a39af4818	2020-10-23 22:40:33.983307	2020-10-23 22:40:33.983307
4252	5	4	13	2	\N	2018-04-28	-391.79	65b9eea6e1cc6bb9f0cd2a47751a186f	2020-10-23 22:40:33.984392	2020-10-23 22:40:33.984392
4253	5	4	13	2	\N	2018-04-28	-135.45	e64770ac6bac05626b4f59b6a03e2ff8	2020-10-23 22:40:33.985501	2020-10-23 22:40:33.985501
4254	5	4	15	2	\N	2018-04-28	-109.78	8a6a1c6f110632f3d70249ebe93045fb	2020-10-23 22:40:33.986621	2020-10-23 22:40:33.986621
4255	5	4	14	2	\N	2018-04-28	-106.21	3415b4481a177647820b151081eeecd4	2020-10-23 22:40:33.987659	2020-10-23 22:40:33.987659
4256	2	7	33	2	\N	2018-04-28	-105.00	1b566cac7f0519e74f48bc63b8dda470	2020-10-23 22:40:33.988689	2020-10-23 22:40:33.988689
4257	1	9	48	2	\N	2018-04-28	-108.00	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:40:33.989851	2020-10-23 22:40:33.989851
4258	1	3	-1	2	\N	2018-04-28	-12.07	b03dfc3ff80e0edc860b0d7fa200f39d	2020-10-23 22:40:33.991111	2020-10-23 22:40:33.991111
4259	2	8	41	2	\N	2018-04-28	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:33.992348	2020-10-23 22:40:33.992348
4260	2	3	-1	2	\N	2018-04-28	-20.60	7fe1f8abaad094e0b5cb1b01d712f708	2020-10-23 22:40:33.993532	2020-10-23 22:40:33.993532
4261	1	2	-1	4	\N	2018-04-30	15.00	7b2b417df328c89a176eaf7977838661	2020-10-23 22:40:33.995238	2020-10-23 22:40:33.995238
4262	1	5	22	2	\N	2018-04-30	-1012.50	3692e633c258493a1a98c641e947569b	2020-10-23 22:40:33.996689	2020-10-23 22:40:33.996689
4263	1	1	-1	2	\N	2018-04-30	-39.21	24ea02bea379f86ed49fa11257f69ef8	2020-10-23 22:40:33.998121	2020-10-23 22:40:33.998121
4264	5	1	-1	2	\N	2018-04-30	-17.76	6f1071cac42b19d40149f58ee960582d	2020-10-23 22:40:33.9993	2020-10-23 22:40:33.9993
4265	5	7	33	3	\N	2018-04-30	-15.00	7b2b417df328c89a176eaf7977838661	2020-10-23 22:40:34.000309	2020-10-23 22:40:34.000309
4266	1	8	41	2	\N	2018-04-30	-23.40	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.001376	2020-10-23 22:40:34.001376
4267	1	7	35	2	\N	2018-04-28	-102.00	4d41ca3ae901a60c9d82d1eb80b58661	2020-10-23 22:40:34.002512	2020-10-23 22:40:34.002512
4268	2	4	18	2	\N	2018-04-30	-29.00	d2d80fe634ef8d08cec7d82581314939	2020-10-23 22:40:34.003596	2020-10-23 22:40:34.003596
4269	5	2	3	1	\N	2018-04-27	1500.00	1fa5da2d939a6f4d3a5a6592ace5ac0f	2020-10-23 22:40:34.004711	2020-10-23 22:40:34.004711
4270	6	10	55	1	\N	2018-04-30	105.81	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:34.005825	2020-10-23 22:40:34.005825
4271	6	9	-1	1	\N	2018-05-01	39.69	f07e4af71b1084fb21996f62d98be1ab	2020-10-23 22:40:34.007129	2020-10-23 22:40:34.007129
4272	1	9	-1	2	\N	2018-05-01	-70.85	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:40:34.008434	2020-10-23 22:40:34.008434
4273	5	9	-1	1	\N	2018-05-01	50.00	547ddaad46cd88a59726463319458e05	2020-10-23 22:40:34.00956	2020-10-23 22:40:34.00956
4274	5	9	48	2	\N	2018-05-10	-500.00	15faa2ce0bb8fbb9ceb57b38bc3abd6c	2020-10-23 22:40:34.010674	2020-10-23 22:40:34.010674
4275	5	1	-1	2	\N	2018-05-04	-50.11	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.011706	2020-10-23 22:40:34.011706
4276	5	4	-1	2	\N	2018-05-05	-153.00	10b50c8fd7af85a29d6f942567f74e4f	2020-10-23 22:40:34.012758	2020-10-23 22:40:34.012758
4277	2	9	47	2	\N	2018-05-03	-50.00	81f191836205536080092176d918b90a	2020-10-23 22:40:34.014224	2020-10-23 22:40:34.014224
4278	5	10	54	4	\N	2018-05-04	5500.00	ed1ad7211901a6c84e6c677620508bbd	2020-10-23 22:40:34.01562	2020-10-23 22:40:34.01562
4279	5	1	-1	2	\N	2018-05-05	-28.92	e4159e12ad1fc8e3ea788d257dd7a8f5	2020-10-23 22:40:34.01685	2020-10-23 22:40:34.01685
4280	5	1	-1	2	\N	2018-04-30	-51.05	e0283dadd1277d0ce6c6bae5787408a2	2020-10-23 22:40:34.018013	2020-10-23 22:40:34.018013
4281	5	8	43	2	\N	2018-05-05	-171.15	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:34.019072	2020-10-23 22:40:34.019072
4282	5	1	-1	2	\N	2018-05-04	-14.57	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:34.020372	2020-10-23 22:40:34.020372
4283	5	1	-1	2	\N	2018-05-07	-61.56	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:34.021444	2020-10-23 22:40:34.021444
4284	5	1	-1	2	\N	2018-05-08	-22.31	6aaef7dcd74846a3eed100343d4c9ff1	2020-10-23 22:40:34.022575	2020-10-23 22:40:34.022575
4285	5	10	54	3	\N	2018-05-11	-500.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:34.023672	2020-10-23 22:40:34.023672
4286	5	10	54	3	\N	2018-05-11	-1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.025285	2020-10-23 22:40:34.025285
4287	6	10	54	4	\N	2018-05-11	1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.026437	2020-10-23 22:40:34.026437
4288	5	10	54	4	\N	2018-05-11	4900.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.027514	2020-10-23 22:40:34.027514
4289	5	10	54	3	\N	2018-05-11	-4926.88	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.028633	2020-10-23 22:40:34.028633
4290	6	10	54	4	\N	2018-05-11	4926.88	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.029766	2020-10-23 22:40:34.029766
4291	5	8	43	2	\N	2018-05-11	-141.40	f4a918ae12ee8b9cdf2c78f771bcb712	2020-10-23 22:40:34.030882	2020-10-23 22:40:34.030882
4292	5	8	43	2	\N	2018-05-11	-140.17	102a31bba84c93e69dc27d8015863957	2020-10-23 22:40:34.032187	2020-10-23 22:40:34.032187
4293	5	1	-1	2	\N	2018-05-06	-12.28	b1ff82ea598c4ca2ed175c541569aae7	2020-10-23 22:40:34.033675	2020-10-23 22:40:34.033675
4294	1	1	-1	2	\N	2018-05-16	-28.90	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:40:34.034923	2020-10-23 22:40:34.034923
4295	5	1	-1	2	\N	2018-05-15	-8.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.03617	2020-10-23 22:40:34.03617
4296	1	5	22	2	\N	2018-05-14	-100.00	d06efb5b5e0daf8db9debffcaab84142	2020-10-23 22:40:34.037272	2020-10-23 22:40:34.037272
4297	1	1	-1	2	\N	2018-05-15	-15.88	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.038668	2020-10-23 22:40:34.038668
4298	1	1	-1	2	\N	2018-05-15	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:34.039837	2020-10-23 22:40:34.039837
4299	1	7	35	2	\N	2018-05-15	-150.00	4896d2676d51661d891bd53006e3dad2	2020-10-23 22:40:34.041414	2020-10-23 22:40:34.041414
4300	1	4	18	2	\N	2018-05-14	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:34.042659	2020-10-23 22:40:34.042659
4301	1	9	48	2	\N	2018-05-14	-99.00	0336dcbab05b9d5ad24f4333c7658a0e	2020-10-23 22:40:34.043771	2020-10-23 22:40:34.043771
4302	1	10	54	3	\N	2018-05-11	-150.00	31ed63ae87c44e83c37270d559a714e1	2020-10-23 22:40:34.044873	2020-10-23 22:40:34.044873
4303	1	10	54	3	\N	2018-05-11	-4000.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:34.045964	2020-10-23 22:40:34.045964
4304	1	1	-1	2	\N	2018-05-11	-3.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.047037	2020-10-23 22:40:34.047037
4305	1	3	-1	2	\N	2018-05-11	-16.00	c192e5e089b6fc7e5c5c890e4842810b	2020-10-23 22:40:34.048304	2020-10-23 22:40:34.048304
4306	1	9	51	2	\N	2018-05-10	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.049338	2020-10-23 22:40:34.049338
4307	1	2	-1	1	\N	2018-05-10	3823.45	306754ce45dc3a2441a1828dcf3fe238	2020-10-23 22:40:34.050498	2020-10-23 22:40:34.050498
4308	1	3	-1	2	\N	2018-05-10	-9.00	853c0eb6fd1ca116dfe81feb04265569	2020-10-23 22:40:34.051878	2020-10-23 22:40:34.051878
4309	1	3	-1	2	\N	2018-05-10	-22.00	d1c93c5bd481bd3d366c0407c60902c0	2020-10-23 22:40:34.053474	2020-10-23 22:40:34.053474
4310	1	1	-1	2	\N	2018-05-10	-20.00	b86e8d03fe992d1b0e19656875ee557c	2020-10-23 22:40:34.054637	2020-10-23 22:40:34.054637
4311	1	5	21	2	\N	2018-05-09	-56.97	db31dcd832b4a85bf9aeee10dfeddded	2020-10-23 22:40:34.055653	2020-10-23 22:40:34.055653
4312	1	1	-1	2	\N	2018-05-09	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:34.056723	2020-10-23 22:40:34.056723
4313	1	5	21	2	\N	2018-05-08	-50.90	468b93d3184e7651de18b0c697eda59d	2020-10-23 22:40:34.057913	2020-10-23 22:40:34.057913
4314	1	7	31	2	\N	2018-05-07	-15.00	10a6165b2aa40b3f6252923608c859e8	2020-10-23 22:40:34.05918	2020-10-23 22:40:34.05918
4315	1	2	-1	1	\N	2018-05-07	108.00	99797ce3dfa2ab20b459fff8b99d30e9	2020-10-23 22:40:34.060321	2020-10-23 22:40:34.060321
4316	1	8	41	2	\N	2018-05-07	-46.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:34.061409	2020-10-23 22:40:34.061409
4317	1	9	49	3	\N	2018-05-07	-150.00	663e50bd28ff76962cc8d3c81c7cd3ba	2020-10-23 22:40:34.062574	2020-10-23 22:40:34.062574
4318	1	10	54	4	\N	2018-05-04	1500.00	dbf9738ba4d7786c6e935a149169fe2c	2020-10-23 22:40:34.063688	2020-10-23 22:40:34.063688
4319	1	10	54	3	\N	2018-05-02	-7000.00	becf3aa5cf9e244cc7f84aeb73d3bab9	2020-10-23 22:40:34.064888	2020-10-23 22:40:34.064888
4320	1	3	-1	2	\N	2018-05-04	-8.18	4eb49c402ee7d0a3ac4d832d6b38855e	2020-10-23 22:40:34.066723	2020-10-23 22:40:34.066723
4321	1	1	-1	2	\N	2018-05-04	-253.00	6e2713a6efee97bacb63e52c54f0ada0	2020-10-23 22:40:34.068923	2020-10-23 22:40:34.068923
4322	5	1	-1	2	\N	2018-05-17	-10.74	e8cb4ff5f9f6d5ff45a4fec7ddd72400	2020-10-23 22:40:34.071074	2020-10-23 22:40:34.071074
4323	5	1	-1	2	\N	2018-05-16	-12.28	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.072606	2020-10-23 22:40:34.072606
4324	5	1	-1	2	\N	2018-05-07	-19.40	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.073796	2020-10-23 22:40:34.073796
4325	5	1	-1	2	\N	2018-05-09	-15.60	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.075521	2020-10-23 22:40:34.075521
4326	5	9	47	2	\N	2018-05-17	-50.00	4d439535a3065efd10d37a80209d14ee	2020-10-23 22:40:34.076867	2020-10-23 22:40:34.076867
4327	5	9	47	2	\N	2018-05-16	-50.00	e07413354875be01a996dc560274708e	2020-10-23 22:40:34.07837	2020-10-23 22:40:34.07837
4328	5	1	-1	2	\N	2018-05-17	-22.31	dd982884edf68487cb8ff664b3dfdf12	2020-10-23 22:40:34.079585	2020-10-23 22:40:34.079585
4329	2	4	16	2	\N	2018-05-18	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:34.080704	2020-10-23 22:40:34.080704
4330	6	10	54	3	\N	2018-05-18	-10000.00	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:40:34.081769	2020-10-23 22:40:34.081769
4331	5	10	54	4	\N	2018-05-18	10000.00	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:40:34.082942	2020-10-23 22:40:34.082942
4332	5	1	-1	2	\N	2018-05-19	-13.83	71c32595c397960f74555a8b9db16f75	2020-10-23 22:40:34.084106	2020-10-23 22:40:34.084106
4333	2	5	26	2	\N	2018-05-19	-41.82	417ad863873950168eb20d228d6f4f16	2020-10-23 22:40:34.085218	2020-10-23 22:40:34.085218
4334	1	5	22	2	\N	2018-05-21	-100.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:34.086323	2020-10-23 22:40:34.086323
4335	1	7	36	2	\N	2018-05-21	-17.43	a94e12226a9c01600ac0d46ea11359e2	2020-10-23 22:40:34.087397	2020-10-23 22:40:34.087397
4336	1	1	-1	2	\N	2018-05-20	-2.69	d2490f048dc3b77a457e3e450ab4eb38	2020-10-23 22:40:34.088567	2020-10-23 22:40:34.088567
4337	5	1	-1	2	\N	2018-05-21	-23.57	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.089802	2020-10-23 22:40:34.089802
4338	5	3	-1	2	\N	2018-05-19	-19.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:34.091591	2020-10-23 22:40:34.091591
4339	5	1	-1	2	\N	2018-05-18	-185.00	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.092925	2020-10-23 22:40:34.092925
4340	5	1	-1	2	\N	2018-05-19	-8.59	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:34.094064	2020-10-23 22:40:34.094064
4341	5	1	-1	2	\N	2018-05-19	-8.60	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.095626	2020-10-23 22:40:34.095626
4342	5	1	-1	2	\N	2018-05-19	-10.74	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:34.096888	2020-10-23 22:40:34.096888
4343	5	3	-1	2	\N	2018-05-19	-10.16	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.098665	2020-10-23 22:40:34.098665
4344	5	1	-1	2	\N	2018-05-24	-7.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.09976	2020-10-23 22:40:34.09976
4345	5	1	-1	2	\N	2018-05-23	-3.00	796218fb822714b4775a65bf080ca4ad	2020-10-23 22:40:34.100904	2020-10-23 22:40:34.100904
4346	5	5	23	2	\N	2018-05-25	-28.99	c9e791d6604a5fcc1f4e6ad574f43328	2020-10-23 22:40:34.102028	2020-10-23 22:40:34.102028
4347	5	1	-1	2	\N	2018-05-25	-197.72	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.103073	2020-10-23 22:40:34.103073
4348	1	9	48	2	\N	2018-05-25	-30.00	2f29fff04bbb10a699a33f749497096c	2020-10-23 22:40:34.104088	2020-10-23 22:40:34.104088
4349	1	1	-1	2	\N	2018-05-25	-21.34	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.10589	2020-10-23 22:40:34.10589
4350	5	1	-1	2	\N	2018-05-26	-11.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.108049	2020-10-23 22:40:34.108049
4351	5	1	-1	2	\N	2018-05-26	-7.50	a041fd74f6e07754fe6b3ba46e53bda2	2020-10-23 22:40:34.10947	2020-10-23 22:40:34.10947
4352	5	1	-1	2	\N	2018-05-26	-16.00	b31e825ba7b90e7a25ce1f88ba3a1d40	2020-10-23 22:40:34.11063	2020-10-23 22:40:34.11063
4353	1	9	48	2	\N	2018-05-26	-15.00	67d96d458abdef21792e6d8e590244e7	2020-10-23 22:40:34.111705	2020-10-23 22:40:34.111705
4354	5	4	16	2	\N	2018-05-27	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:34.112785	2020-10-23 22:40:34.112785
4355	5	3	-1	2	\N	2018-05-26	-20.46	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.11388	2020-10-23 22:40:34.11388
4356	1	2	3	1	\N	2018-05-28	10781.41	448acff3e9c205990131f600cb06360c	2020-10-23 22:40:34.114958	2020-10-23 22:40:34.114958
4357	1	7	36	2	\N	2018-05-28	-78.25	6008683015da4d3c1ce22105cc707371	2020-10-23 22:40:34.116026	2020-10-23 22:40:34.116026
4358	1	9	49	2	\N	2018-05-28	-613.77	288cc0ff022877bd3df94bc9360b9c5d	2020-10-23 22:40:34.117147	2020-10-23 22:40:34.117147
4359	1	9	49	2	\N	2018-05-28	-150.00	b75427b031d9ece858e5f9404469c6c9	2020-10-23 22:40:34.118344	2020-10-23 22:40:34.118344
4360	1	10	54	3	\N	2018-05-28	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.119853	2020-10-23 22:40:34.119853
4361	1	10	54	3	\N	2018-05-28	-1000.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:34.120989	2020-10-23 22:40:34.120989
4362	5	5	23	2	\N	2018-05-28	-29.49	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.122293	2020-10-23 22:40:34.122293
4363	1	9	49	3	\N	2018-05-28	-100.00	663e50bd28ff76962cc8d3c81c7cd3ba	2020-10-23 22:40:34.123413	2020-10-23 22:40:34.123413
4364	1	1	-1	2	\N	2018-05-29	-1.62	006f52e9102a8d3be2fe5614f42ba989	2020-10-23 22:40:34.124812	2020-10-23 22:40:34.124812
4365	1	1	-1	2	\N	2018-05-29	-13.90	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:34.126123	2020-10-23 22:40:34.126123
4366	5	1	-1	2	\N	2018-05-29	-9.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:34.127236	2020-10-23 22:40:34.127236
4367	5	5	23	2	\N	2018-05-29	-90.10	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.128564	2020-10-23 22:40:34.128564
4368	5	1	-1	2	\N	2018-05-30	-11.98	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.129714	2020-10-23 22:40:34.129714
4369	5	1	-1	2	\N	2018-05-30	-6.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.130861	2020-10-23 22:40:34.130861
4370	5	1	-1	2	\N	2018-05-30	-11.20	be82263b451d92b83956abd22941c042	2020-10-23 22:40:34.132051	2020-10-23 22:40:34.132051
4371	2	2	3	1	\N	2018-05-30	13874.16	ef4e3b775c934dada217712d76f3d51f	2020-10-23 22:40:34.133113	2020-10-23 22:40:34.133113
4372	2	2	3	1	\N	2018-05-30	559.94	19f3cd308f1455b3fa09a282e0d496f4	2020-10-23 22:40:34.134215	2020-10-23 22:40:34.134215
4373	2	10	54	3	\N	2018-05-30	-5000.00	6f1071cac42b19d40149f58ee960582d	2020-10-23 22:40:34.13527	2020-10-23 22:40:34.13527
4374	5	10	54	4	\N	2018-05-30	5000.00	6f1071cac42b19d40149f58ee960582d	2020-10-23 22:40:34.136569	2020-10-23 22:40:34.136569
4375	5	4	13	2	\N	2018-05-30	-391.79	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:34.137614	2020-10-23 22:40:34.137614
4376	5	4	-1	2	\N	2018-05-30	-590.00	758874998f5bd0c393da094e1967a72b	2020-10-23 22:40:34.138779	2020-10-23 22:40:34.138779
4377	5	4	15	2	\N	2018-05-30	-109.78	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:40:34.139811	2020-10-23 22:40:34.139811
4378	2	10	54	3	\N	2018-05-31	-500.00	47d1e990583c9c67424d369f3414728e	2020-10-23 22:40:34.140844	2020-10-23 22:40:34.140844
4379	4	10	54	4	\N	2018-05-31	500.00	47d1e990583c9c67424d369f3414728e	2020-10-23 22:40:34.142288	2020-10-23 22:40:34.142288
4380	2	10	54	3	\N	2018-05-31	-6000.00	320722549d1751cf3f247855f937b982	2020-10-23 22:40:34.143493	2020-10-23 22:40:34.143493
4381	5	10	54	4	\N	2018-05-31	6000.00	320722549d1751cf3f247855f937b982	2020-10-23 22:40:34.144651	2020-10-23 22:40:34.144651
4382	2	9	47	3	\N	2018-05-22	-50.00	9d88dbeb65c8d336c3e5b69977f359bc	2020-10-23 22:40:34.145728	2020-10-23 22:40:34.145728
4383	5	7	33	3	\N	2018-05-31	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.146834	2020-10-23 22:40:34.146834
4384	1	2	-1	4	\N	2018-05-31	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.148193	2020-10-23 22:40:34.148193
4385	5	1	-1	2	\N	2018-05-31	-17.80	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.149232	2020-10-23 22:40:34.149232
4386	1	1	-1	2	\N	2018-05-31	-221.00	7623cbe09d061a0bfe1f34c0627205bb	2020-10-23 22:40:34.150349	2020-10-23 22:40:34.150349
4387	2	1	-1	2	\N	2018-05-31	-11.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.151414	2020-10-23 22:40:34.151414
4388	6	10	55	1	\N	2018-05-31	102.62	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:34.152442	2020-10-23 22:40:34.152442
4389	1	10	54	3	\N	2018-06-01	-7000.00	26c91801f25caaf4bf5db26f6ad5802b	2020-10-23 22:40:34.153476	2020-10-23 22:40:34.153476
4390	1	9	-1	4	\N	2018-06-01	15.23	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:40:34.15456	2020-10-23 22:40:34.15456
4391	5	2	-1	4	\N	2018-06-01	16.83	0a93c4e8557cb6897b438861e21c55ee	2020-10-23 22:40:34.155671	2020-10-23 22:40:34.155671
4392	5	1	-1	2	\N	2018-06-01	-110.84	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.156877	2020-10-23 22:40:34.156877
4393	5	1	-1	2	\N	2018-06-01	-5.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.158334	2020-10-23 22:40:34.158334
4394	2	9	-1	2	\N	2018-06-01	-200.00	362842296f8c3370c748838bccf5e9c6	2020-10-23 22:40:34.159556	2020-10-23 22:40:34.159556
4395	5	9	48	2	\N	2018-06-01	-29.70	856deecf45fa4ace6b5b49bd4ad54acf	2020-10-23 22:40:34.160696	2020-10-23 22:40:34.160696
4396	5	1	-1	2	\N	2018-06-01	-8.29	fb7b9ffa5462084c5f4e7e85a093e6d7	2020-10-23 22:40:34.161943	2020-10-23 22:40:34.161943
4397	5	1	-1	2	\N	2018-06-01	-54.83	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:34.163143	2020-10-23 22:40:34.163143
4398	5	9	-1	2	\N	2018-06-01	-27.50	339fc34a878d41879319289799bd2096	2020-10-23 22:40:34.164235	2020-10-23 22:40:34.164235
4399	2	5	23	2	\N	2018-06-01	-11.99	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:34.165345	2020-10-23 22:40:34.165345
4400	2	3	-1	2	\N	2018-06-02	-18.00	01f78be6f7cad02658508fe4616098a9	2020-10-23 22:40:34.166486	2020-10-23 22:40:34.166486
4401	1	1	-1	2	\N	2018-06-02	-45.00	fc2ffb1c8ebc32cd87c795a4e310d2bf	2020-10-23 22:40:34.167521	2020-10-23 22:40:34.167521
4402	1	10	54	3	\N	2018-06-03	-200.00	3f7d7ba72a6872975f5bd3f2254ab238	2020-10-23 22:40:34.168677	2020-10-23 22:40:34.168677
4403	5	1	-1	2	\N	2018-06-03	-21.98	c2f7ab46df3db842040a86a0897a5377	2020-10-23 22:40:34.169755	2020-10-23 22:40:34.169755
4404	5	5	23	2	\N	2018-06-04	-34.97	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:34.170888	2020-10-23 22:40:34.170888
4405	1	1	-1	2	\N	2018-06-04	-9.00	bfdf6e06fd64cd2de2721e0bedc989ed	2020-10-23 22:40:34.171971	2020-10-23 22:40:34.171971
4406	1	1	-1	2	\N	2018-06-05	-6.67	c940df0e5050cf1dff8cc7a9eb81569b	2020-10-23 22:40:34.17302	2020-10-23 22:40:34.17302
4407	1	1	-1	2	\N	2018-06-05	-3.99	f7b6f532b566605cbb9657c243eb7ae6	2020-10-23 22:40:34.174185	2020-10-23 22:40:34.174185
4408	1	9	49	2	\N	2018-06-05	-10.00	dc6a6489640ca02b0d42dabeb8e46bb7	2020-10-23 22:40:34.175373	2020-10-23 22:40:34.175373
4409	5	1	-1	2	\N	2018-06-05	-23.00	b9b4abeafdffae758561c5bc344c22c0	2020-10-23 22:40:34.176511	2020-10-23 22:40:34.176511
4410	5	1	-1	2	\N	2018-06-05	-7.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.177546	2020-10-23 22:40:34.177546
4411	5	4	-1	2	\N	2018-06-06	-117.00	fb6e612cbc5b55c03054170e271d0437	2020-10-23 22:40:34.178639	2020-10-23 22:40:34.178639
4412	2	9	48	2	\N	2018-06-06	-10.00	ff77f989ff699a82c072402156bf0537	2020-10-23 22:40:34.179705	2020-10-23 22:40:34.179705
4413	2	5	23	2	\N	2018-06-07	-55.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.180844	2020-10-23 22:40:34.180844
4414	5	1	-1	2	\N	2018-06-07	-50.00	1eaeac7d2483dbce5a6e9acf3c91d2ab	2020-10-23 22:40:34.182015	2020-10-23 22:40:34.182015
4415	2	8	41	2	\N	2018-06-07	-50.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.18321	2020-10-23 22:40:34.18321
4416	2	8	41	2	\N	2018-06-08	-11.00	afb484a006f5ab0e043179cef7518ab7	2020-10-23 22:40:34.184347	2020-10-23 22:40:34.184347
4417	5	1	-1	2	\N	2018-06-09	-4.80	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:34.18547	2020-10-23 22:40:34.18547
4418	5	1	-1	2	\N	2018-06-09	-7.21	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:40:34.186657	2020-10-23 22:40:34.186657
4419	5	1	-1	2	\N	2018-06-08	-125.26	67e103b0761e60683e83c559be18d40c	2020-10-23 22:40:34.187838	2020-10-23 22:40:34.187838
4420	1	1	-1	2	\N	2016-06-07	-27.90	5be39d213a5e0ac77bde56867df34de3	2020-10-23 22:40:34.188976	2020-10-23 22:40:34.188976
4421	1	3	-1	2	\N	2018-06-08	-17.46	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.190341	2020-10-23 22:40:34.190341
4422	1	1	-1	2	\N	2018-06-08	-15.75	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.191696	2020-10-23 22:40:34.191696
4423	1	2	-1	1	\N	2018-06-07	613.77	a797343ad6da0b3f1ad01b1930f17bb7	2020-10-23 22:40:34.193064	2020-10-23 22:40:34.193064
4424	1	10	54	3	\N	2018-06-07	-1000.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.194498	2020-10-23 22:40:34.194498
4425	1	8	41	2	\N	2018-06-06	-25.40	71c32595c397960f74555a8b9db16f75	2020-10-23 22:40:34.195806	2020-10-23 22:40:34.195806
4426	1	8	41	2	\N	2018-06-06	-46.00	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:34.196997	2020-10-23 22:40:34.196997
4427	1	8	51	2	\N	2018-06-06	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.198201	2020-10-23 22:40:34.198201
4428	5	1	-1	2	\N	2018-06-07	-11.34	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.199634	2020-10-23 22:40:34.199634
4429	5	5	23	2	\N	2018-06-07	-66.57	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.201102	2020-10-23 22:40:34.201102
4430	5	10	54	4	\N	2018-06-06	5500.00	6fb6fd655fc39c0617735f754aa4877f	2020-10-23 22:40:34.202563	2020-10-23 22:40:34.202563
4431	5	10	54	3	\N	2018-06-08	-2500.00	6fb6fd655fc39c0617735f754aa4877f	2020-10-23 22:40:34.203696	2020-10-23 22:40:34.203696
4432	2	9	48	2	\N	2018-06-09	-33.96	82c89ed04868c75db962bb3bbe2d4b4c	2020-10-23 22:40:34.204829	2020-10-23 22:40:34.204829
4433	5	10	54	4	\N	2018-06-11	2500.00	fba8a8dd8fadf4dbc49f8c2132a9c867	2020-10-23 22:40:34.206021	2020-10-23 22:40:34.206021
4434	1	7	30	2	\N	2018-06-10	-805.70	0d8e64dd6bb3dfeda04c860bc14953cf	2020-10-23 22:40:34.207102	2020-10-23 22:40:34.207102
4435	1	2	-1	1	\N	2018-06-11	230.20	4de7cd7b4a762dc9becd4afaf10c4a9d	2020-10-23 22:40:34.208535	2020-10-23 22:40:34.208535
4436	5	7	30	3	\N	2018-06-11	-345.30	a9ced3dad556814ed46042de696e1849	2020-10-23 22:40:34.21001	2020-10-23 22:40:34.21001
4437	1	2	-1	4	\N	2018-06-11	345.30	a9ced3dad556814ed46042de696e1849	2020-10-23 22:40:34.211196	2020-10-23 22:40:34.211196
4438	1	2	-1	4	\N	2018-06-10	1000.00	aa4af0bc068cfcd528f13a7ba14d6a27	2020-10-23 22:40:34.212261	2020-10-23 22:40:34.212261
4439	5	7	30	2	\N	2018-06-11	-460.00	4753cb21ffb150d76e13233f66c10141	2020-10-23 22:40:34.213344	2020-10-23 22:40:34.213344
4440	6	10	54	3	\N	2018-06-11	-10000.00	77880d29bd323c06214b51e43515399a	2020-10-23 22:40:34.214426	2020-10-23 22:40:34.214426
4441	5	10	54	4	\N	2018-06-11	10000.00	77880d29bd323c06214b51e43515399a	2020-10-23 22:40:34.215537	2020-10-23 22:40:34.215537
4442	5	1	-1	2	\N	2018-06-12	-13.33	44fe455c4ce5034fbe4788b5066fb80f	2020-10-23 22:40:34.216695	2020-10-23 22:40:34.216695
4443	5	1	-1	2	\N	2018-06-12	-5.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.217849	2020-10-23 22:40:34.217849
4444	1	1	-1	2	\N	2018-06-12	-6.00	d516b13671a4179d9b7b458a6ebdeb92	2020-10-23 22:40:34.219215	2020-10-23 22:40:34.219215
4445	1	4	18	2	\N	2018-06-12	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:34.220437	2020-10-23 22:40:34.220437
4446	5	8	43	2	\N	2018-06-13	-246.00	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:34.221718	2020-10-23 22:40:34.221718
4447	5	1	-1	2	\N	2018-06-14	-20.18	9f65a84d84fb42109c54b47384a437d8	2020-10-23 22:40:34.222923	2020-10-23 22:40:34.222923
4448	1	1	-1	2	\N	2018-06-13	-20.80	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:34.224108	2020-10-23 22:40:34.224108
4449	5	1	-1	2	\N	2018-06-14	-33.78	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.225571	2020-10-23 22:40:34.225571
4450	5	5	23	2	\N	2018-06-15	-37.48	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.226769	2020-10-23 22:40:34.226769
4451	5	1	-1	2	\N	2018-06-15	-9.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.228044	2020-10-23 22:40:34.228044
4452	5	1	-1	2	\N	2018-06-15	-140.64	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.229278	2020-10-23 22:40:34.229278
4453	1	3	-1	2	\N	2018-06-16	-14.16	7d166a0a1471987d823d0db707d2b5d5	2020-10-23 22:40:34.230443	2020-10-23 22:40:34.230443
4454	1	7	38	2	\N	2018-06-16	-16.00	c720b31d2c8177e5a06e8e5ac3254261	2020-10-23 22:40:34.231531	2020-10-23 22:40:34.231531
4455	1	3	-1	2	\N	2018-06-17	-11.16	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.232622	2020-10-23 22:40:34.232622
4456	2	7	34	2	\N	2018-06-17	-50.00	8ebda540cbcc4d7336496819a46a1b68	2020-10-23 22:40:34.233675	2020-10-23 22:40:34.233675
4457	2	1	-1	2	\N	2018-06-16	-41.00	64d9d311a00724c464d7eb5e5157ad50	2020-10-23 22:40:34.235297	2020-10-23 22:40:34.235297
4458	2	9	-1	2	\N	2018-06-18	-830.00	335628b154666834079b64e2357c0cfb	2020-10-23 22:40:34.236392	2020-10-23 22:40:34.236392
4459	2	3	-1	2	\N	2018-06-18	-10.00	4e0ada9a2332865a72ff5f4b426b5217	2020-10-23 22:40:34.237449	2020-10-23 22:40:34.237449
4460	2	2	-1	1	\N	2018-06-18	660.00	8441307d59baa3cdbedea237264a1a22	2020-10-23 22:40:34.238619	2020-10-23 22:40:34.238619
4461	5	1	-1	2	\N	2018-06-19	-11.50	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:40:34.239753	2020-10-23 22:40:34.239753
4462	5	5	26	2	\N	2018-06-19	-78.80	68acb0b7d6d97328e668337593bc4ec7	2020-10-23 22:40:34.240912	2020-10-23 22:40:34.240912
4463	5	1	-1	2	\N	2018-06-19	-80.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:34.242529	2020-10-23 22:40:34.242529
4464	2	4	18	2	\N	2018-06-19	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:34.243725	2020-10-23 22:40:34.243725
4465	5	4	16	2	\N	2018-06-23	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:34.244928	2020-10-23 22:40:34.244928
4466	5	8	43	2	\N	2018-06-23	-213.07	56f8e43767cf93af23801dbdf2bf0335	2020-10-23 22:40:34.246126	2020-10-23 22:40:34.246126
4467	5	8	43	2	\N	2018-06-23	-40.00	ee856d08fd1ca7312f84ecbce2eabba4	2020-10-23 22:40:34.247264	2020-10-23 22:40:34.247264
4468	5	7	30	2	\N	2016-06-22	-135.00	dedf5088bdc282646e85a0131eca928e	2020-10-23 22:40:34.248416	2020-10-23 22:40:34.248416
4469	5	7	30	2	\N	2016-06-21	-10.00	b4c0c84c7057348e020770ca973e668c	2020-10-23 22:40:34.249594	2020-10-23 22:40:34.249594
4470	5	1	-1	2	\N	2018-06-22	-19.29	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.250687	2020-10-23 22:40:34.250687
4471	5	3	-1	2	\N	2018-06-19	-23.98	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.251727	2020-10-23 22:40:34.251727
4472	5	1	-1	2	\N	2018-06-18	-14.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.252802	2020-10-23 22:40:34.252802
4473	5	1	-1	2	\N	2018-06-20	-130.12	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.253922	2020-10-23 22:40:34.253922
4474	5	5	23	2	\N	2018-06-20	-18.99	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.25501	2020-10-23 22:40:34.25501
4475	1	2	-1	1	\N	2018-06-21	230.20	aed9beb6b9ca533cd6cc4f11a85ab77b	2020-10-23 22:40:34.256119	2020-10-23 22:40:34.256119
4476	1	1	-1	2	\N	2018-06-21	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:34.25751	2020-10-23 22:40:34.25751
4477	1	10	54	3	\N	2018-06-23	-800.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.258921	2020-10-23 22:40:34.258921
4478	5	7	30	2	\N	2018-06-22	-50.00	99bcfcd754a98ce89cb86f73acc04645	2020-10-23 22:40:34.260192	2020-10-23 22:40:34.260192
4479	5	2	-1	1	\N	2018-06-21	99.72	d44bbe4876f51dae2e73f0b2833cd74d	2020-10-23 22:40:34.26143	2020-10-23 22:40:34.26143
4480	5	5	23	2	\N	2018-06-20	-19.99	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.262631	2020-10-23 22:40:34.262631
4481	5	9	-1	2	\N	2018-06-23	-20.70	c30a5fa5e5905eac744ef8c427d1ce38	2020-10-23 22:40:34.263742	2020-10-23 22:40:34.263742
4482	2	5	23	2	\N	2018-06-20	-8.99	64e96efbc1ee0531bf144c1f5528223f	2020-10-23 22:40:34.264939	2020-10-23 22:40:34.264939
4483	2	5	23	2	\N	2018-06-21	-6.99	45d716114932b7186b228938311a5fc0	2020-10-23 22:40:34.266134	2020-10-23 22:40:34.266134
4484	2	1	-1	2	\N	2018-06-23	-14.00	30d69ba3457fbe63ddf07f88adbca502	2020-10-23 22:40:34.267265	2020-10-23 22:40:34.267265
4485	2	9	48	2	\N	2018-06-23	-87.93	3a465180a2c1e3ecd2e8311048d2183f	2020-10-23 22:40:34.268401	2020-10-23 22:40:34.268401
4486	2	5	23	2	\N	2018-06-23	-74.11	185c29dc24325934ee377cfda20e414c	2020-10-23 22:40:34.269614	2020-10-23 22:40:34.269614
4487	2	1	-1	2	\N	2018-06-24	-11.85	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:34.270921	2020-10-23 22:40:34.270921
4488	2	5	23	1	\N	2018-06-20	109.61	00b82ccebba034c4727af7c1e9d72dd1	2020-10-23 22:40:34.272197	2020-10-23 22:40:34.272197
4489	1	9	48	2	\N	2018-06-23	-74.99	a96b65a721e561e1e3de768ac819ffbb	2020-10-23 22:40:34.273331	2020-10-23 22:40:34.273331
4490	1	7	33	3	\N	2018-06-26	-20.00	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:34.274629	2020-10-23 22:40:34.274629
4491	1	2	3	1	\N	2018-06-26	10713.70	02e62b4fa2e3445a3c0cceb274e801aa	2020-10-23 22:40:34.275856	2020-10-23 22:40:34.275856
4492	1	8	41	2	\N	2018-06-25	-29.60	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.277334	2020-10-23 22:40:34.277334
4493	1	9	48	2	\N	2018-06-24	-30.00	3d1bdabde1dcd502febec9b208942ceb	2020-10-23 22:40:34.278694	2020-10-23 22:40:34.278694
4494	5	1	-1	2	\N	2018-06-26	-3.49	b5b41fac0361d157d9673ecb926af5ae	2020-10-23 22:40:34.279859	2020-10-23 22:40:34.279859
4495	5	1	-1	2	\N	2018-06-26	-9.54	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:34.281027	2020-10-23 22:40:34.281027
4496	5	1	-1	2	\N	2018-06-25	-20.00	94f6d7e04a4d452035300f18b984988c	2020-10-23 22:40:34.282317	2020-10-23 22:40:34.282317
4497	5	1	-1	2	\N	2018-06-25	-4.50	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:34.283396	2020-10-23 22:40:34.283396
4498	5	1	-1	2	\N	2018-06-26	-9.60	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:34.284603	2020-10-23 22:40:34.284603
4499	1	10	54	3	\N	2018-06-27	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.285702	2020-10-23 22:40:34.285702
4500	1	10	54	3	\N	2018-06-27	-1200.00	8f53295a73878494e9bc8dd6c3c7104f	2020-10-23 22:40:34.286797	2020-10-23 22:40:34.286797
4501	1	10	54	3	\N	2018-06-27	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:34.287834	2020-10-23 22:40:34.287834
4502	6	10	54	4	\N	2018-06-27	1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:34.288991	2020-10-23 22:40:34.288991
4503	2	9	-1	2	\N	2018-06-28	-110.00	1feea25ecb958229287f885aebe7c49b	2020-10-23 22:40:34.290439	2020-10-23 22:40:34.290439
4504	1	3	-1	2	\N	2018-06-27	-13.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.291746	2020-10-23 22:40:34.291746
4505	1	1	-1	2	\N	2018-06-29	-2.80	fdb6a98504d8397b553cc36901d22482	2020-10-23 22:40:34.292997	2020-10-23 22:40:34.292997
4506	1	1	-1	2	\N	2018-06-29	-16.13	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:34.294333	2020-10-23 22:40:34.294333
4507	1	3	-1	2	\N	2018-06-27	-16.18	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.295552	2020-10-23 22:40:34.295552
4508	1	7	33	3	\N	2018-06-27	-20.00	41012ddde92340324f2588ba57878686	2020-10-23 22:40:34.29676	2020-10-23 22:40:34.29676
4509	5	1	-1	2	\N	2018-06-29	-125.19	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.298024	2020-10-23 22:40:34.298024
4510	5	1	-1	2	\N	2018-06-28	-15.67	21a28858754a02c8cf5f86b5b9371ea0	2020-10-23 22:40:34.299382	2020-10-23 22:40:34.299382
4511	5	8	43	2	\N	2018-06-28	-115.00	b92e69f54ecb42fd22c839dd8cb68056	2020-10-23 22:40:34.300558	2020-10-23 22:40:34.300558
4512	5	7	33	3	\N	2018-06-30	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.301633	2020-10-23 22:40:34.301633
4513	1	2	-1	4	\N	2018-06-30	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.302742	2020-10-23 22:40:34.302742
4514	5	9	48	2	\N	2018-06-30	-13.50	a9676a20fc4e4b1efda8bd959a6186c0	2020-10-23 22:40:34.303801	2020-10-23 22:40:34.303801
4515	5	9	48	2	\N	2018-06-30	-24.97	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:40:34.304878	2020-10-23 22:40:34.304878
4516	5	5	23	2	\N	2018-06-30	-23.99	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.305973	2020-10-23 22:40:34.305973
4517	5	1	-1	2	\N	2018-06-30	-50.00	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.307093	2020-10-23 22:40:34.307093
4518	1	10	54	3	\N	2018-07-01	-7000.00	f0935e4cd5920aa6c7c996a5ee53a70f	2020-10-23 22:40:34.308572	2020-10-23 22:40:34.308572
4519	6	10	55	1	\N	2018-06-30	89.33	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:34.309977	2020-10-23 22:40:34.309977
4520	2	2	3	1	\N	2018-06-27	6340.75	0706dfd8b8609ec0635c4369b59d699f	2020-10-23 22:40:34.311106	2020-10-23 22:40:34.311106
4521	1	2	-1	4	\N	2018-07-01	8.00	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:40:34.312352	2020-10-23 22:40:34.312352
4522	5	9	-1	3	\N	2018-07-01	-28.94	0a93c4e8557cb6897b438861e21c55ee	2020-10-23 22:40:34.313849	2020-10-23 22:40:34.313849
4523	1	9	49	2	\N	2018-07-01	-100.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:40:34.31518	2020-10-23 22:40:34.31518
4524	1	8	41	2	\N	2018-07-01	-46.00	71ad16ad2c4d81f348082ff6c4b20768	2020-10-23 22:40:34.316773	2020-10-23 22:40:34.316773
4525	2	3	-1	2	\N	2018-07-01	-23.50	98d6f58ab0dafbb86b083a001561bb34	2020-10-23 22:40:34.318067	2020-10-23 22:40:34.318067
4526	2	10	54	3	\N	2018-07-01	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.319649	2020-10-23 22:40:34.319649
4527	4	10	54	4	\N	2018-07-01	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.320942	2020-10-23 22:40:34.320942
4528	2	10	54	3	\N	2018-07-01	-4500.00	ca3b14bc94368ca594edbdf5bbd94969	2020-10-23 22:40:34.322213	2020-10-23 22:40:34.322213
4529	5	10	54	4	\N	2018-07-01	4500.00	ca3b14bc94368ca594edbdf5bbd94969	2020-10-23 22:40:34.323681	2020-10-23 22:40:34.323681
4530	5	4	13	2	\N	2018-07-01	-391.79	71d6bedc2742299ee1d5c68dd063414f	2020-10-23 22:40:34.325107	2020-10-23 22:40:34.325107
4531	5	4	15	2	\N	2018-07-01	-109.78	5ed40cc0659d685215b4897e21fa3cab	2020-10-23 22:40:34.326378	2020-10-23 22:40:34.326378
4532	5	4	14	2	\N	2018-07-01	-108.44	5737c6ec2e0716f3d8a7a5c4e0de0d9a	2020-10-23 22:40:34.327593	2020-10-23 22:40:34.327593
4533	5	4	-1	2	\N	2018-07-01	-590.00	4e0928de075538c593fbdabb0c5ef2c3	2020-10-23 22:40:34.329628	2020-10-23 22:40:34.329628
4534	2	10	54	3	\N	2018-07-02	-1500.00	8a4fe2eac821cc07db049f1279357195	2020-10-23 22:40:34.330847	2020-10-23 22:40:34.330847
4535	2	4	18	2	\N	2018-07-02	-29.00	0700f963c87b2e758411b527c9f016f2	2020-10-23 22:40:34.332076	2020-10-23 22:40:34.332076
4536	2	9	-1	2	\N	2018-07-02	-80.00	b3e2026d10e46df62f0d1cdfa85d7aaa	2020-10-23 22:40:34.333136	2020-10-23 22:40:34.333136
4537	2	1	-1	2	\N	2018-07-02	-10.00	4c3d79f13232bd5220b99f59e60210a2	2020-10-23 22:40:34.334427	2020-10-23 22:40:34.334427
4538	2	7	33	2	\N	2018-07-02	-100.00	6e3df1e2bccb9e5eea0d1822814ed45f	2020-10-23 22:40:34.336336	2020-10-23 22:40:34.336336
4539	2	9	48	2	\N	2018-07-04	-82.95	d1f255a373a3cef72e03aa9d980c7eca	2020-10-23 22:40:34.337518	2020-10-23 22:40:34.337518
4540	5	1	-1	2	\N	2018-07-04	-27.28	89fcd07f20b6785b92134bd6c1d0fa42	2020-10-23 22:40:34.338553	2020-10-23 22:40:34.338553
4541	5	9	48	2	\N	2018-07-02	-100.00	1e1ca3b541b07aca4c1ccce4be0aa69f	2020-10-23 22:40:34.339575	2020-10-23 22:40:34.339575
4542	5	1	-1	2	\N	2018-07-03	-22.37	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.340756	2020-10-23 22:40:34.340756
4543	5	1	-1	2	\N	2018-07-03	-15.27	7ea97341577f42fa6c189332e7a60af5	2020-10-23 22:40:34.342707	2020-10-23 22:40:34.342707
4544	5	5	23	2	\N	2018-07-03	-65.06	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.344018	2020-10-23 22:40:34.344018
4545	5	1	-1	2	\N	2018-07-03	-13.00	7ea97341577f42fa6c189332e7a60af5	2020-10-23 22:40:34.34509	2020-10-23 22:40:34.34509
4546	5	1	-1	2	\N	2018-07-03	-6.00	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:34.346333	2020-10-23 22:40:34.346333
4547	5	10	54	4	\N	2018-07-04	5500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.347575	2020-10-23 22:40:34.347575
4548	5	1	-1	2	\N	2018-07-06	-167.57	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.348824	2020-10-23 22:40:34.348824
4549	2	9	48	1	\N	2018-07-06	32.89	f75ad600a9baec25e3568beb6984e4b6	2020-10-23 22:40:34.35001	2020-10-23 22:40:34.35001
4550	2	9	48	2	\N	2018-07-06	-49.75	1cc25bdfb4403f564ee473e68ebe8db1	2020-10-23 22:40:34.351103	2020-10-23 22:40:34.351103
4551	2	9	48	2	\N	2018-07-06	-59.99	e20f0d4902a30e54e87a1cdb23e5a925	2020-10-23 22:40:34.352503	2020-10-23 22:40:34.352503
4552	2	5	23	2	\N	2018-07-06	-22.99	7b13b2203029ed80337f27127a9f1d28	2020-10-23 22:40:34.353648	2020-10-23 22:40:34.353648
4553	2	5	23	2	\N	2018-07-06	-17.09	6bc24fc1ab650b25b4114e93a98f1eba	2020-10-23 22:40:34.354931	2020-10-23 22:40:34.354931
4554	5	1	-1	2	\N	2018-07-06	-17.53	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:34.356159	2020-10-23 22:40:34.356159
4555	2	4	18	2	\N	2018-07-06	-25.00	d2d80fe634ef8d08cec7d82581314939	2020-10-23 22:40:34.357434	2020-10-23 22:40:34.357434
4556	2	7	34	1	\N	2018-07-06	70.00	c2c400743edd1f7b223c95cd9fcdd3f0	2020-10-23 22:40:34.35874	2020-10-23 22:40:34.35874
4557	1	9	51	2	\N	2018-07-06	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.359917	2020-10-23 22:40:34.359917
4558	5	3	-1	2	\N	2018-07-06	-31.66	212bc46229d91aac7b2250b17a1ba20d	2020-10-23 22:40:34.361032	2020-10-23 22:40:34.361032
4559	1	9	48	2	\N	2018-07-07	-97.40	e8b8dd86e67bfe28c06e58d679b33116	2020-10-23 22:40:34.362181	2020-10-23 22:40:34.362181
4560	2	1	-1	2	\N	2018-07-07	-12.00	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:40:34.363221	2020-10-23 22:40:34.363221
4561	5	1	-1	2	\N	2018-07-08	-1.99	e0cc48d330745c266528aacf234d9015	2020-10-23 22:40:34.364493	2020-10-23 22:40:34.364493
4562	6	10	54	3	\N	2018-07-09	-5000.00	625f96daee918472f22d00a89da74b55	2020-10-23 22:40:34.365479	2020-10-23 22:40:34.365479
4563	5	10	54	4	\N	2018-07-09	5000.00	625f96daee918472f22d00a89da74b55	2020-10-23 22:40:34.366545	2020-10-23 22:40:34.366545
4564	5	10	54	3	\N	2018-07-09	-2500.00	e79c01a3b2c251c79b6575788e15798b	2020-10-23 22:40:34.367702	2020-10-23 22:40:34.367702
4565	2	1	-1	2	\N	2018-07-09	-20.00	dd46269118915f85b343da54b42c11d6	2020-10-23 22:40:34.369457	2020-10-23 22:40:34.369457
4566	5	1	-1	3	\N	2018-07-09	-20.00	dd46269118915f85b343da54b42c11d6	2020-10-23 22:40:34.370625	2020-10-23 22:40:34.370625
4567	2	1	-1	4	\N	2018-07-09	20.00	dd46269118915f85b343da54b42c11d6	2020-10-23 22:40:34.37171	2020-10-23 22:40:34.37171
4568	5	4	-1	2	\N	2018-07-09	-126.00	41f1f19176d383480afa65d325c06ed0	2020-10-23 22:40:34.372814	2020-10-23 22:40:34.372814
4569	2	2	-1	1	\N	2018-07-10	960.00	40aa48c0e1ef1af6ecc1af96aa2f2c0f	2020-10-23 22:40:34.373942	2020-10-23 22:40:34.373942
4570	5	9	48	2	\N	2018-07-10	-44.60	07c5807d0d927dcd0980f86024e5208b	2020-10-23 22:40:34.375227	2020-10-23 22:40:34.375227
4571	5	1	-1	2	\N	2018-07-12	-9.50	b639b69797ebed78f26a314f53566956	2020-10-23 22:40:34.376434	2020-10-23 22:40:34.376434
4572	5	1	-1	2	\N	2018-07-12	-7.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:34.377497	2020-10-23 22:40:34.377497
4573	1	5	25	2	\N	2018-07-12	-45.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:34.37858	2020-10-23 22:40:34.37858
4574	1	8	44	2	\N	2018-07-12	-21.37	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:34.379612	2020-10-23 22:40:34.379612
4575	1	6	27	2	\N	2018-07-11	-39.90	3b5dca501ee1e6d8cd7b905f4e1bf723	2020-10-23 22:40:34.380694	2020-10-23 22:40:34.380694
4576	5	9	48	2	\N	2018-07-11	-10.00	703f00744cdc3de982b5adb0217383fe	2020-10-23 22:40:34.381777	2020-10-23 22:40:34.381777
4577	5	9	48	2	\N	2018-07-11	-15.00	5f48f418cbf9ff9a23f9087b8727f4be	2020-10-23 22:40:34.382865	2020-10-23 22:40:34.382865
4578	1	1	-1	2	\N	2018-07-11	-13.40	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:34.383968	2020-10-23 22:40:34.383968
4579	5	1	-1	2	\N	2018-07-12	-13.40	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:34.3852	2020-10-23 22:40:34.3852
4580	1	1	-1	2	\N	2018-07-10	-18.60	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.386303	2020-10-23 22:40:34.386303
4581	1	5	21	2	\N	2018-07-11	-32.65	6c972c70b83e631d25ed5c43533df463	2020-10-23 22:40:34.387427	2020-10-23 22:40:34.387427
4582	5	1	-1	2	\N	2018-07-11	-77.40	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.388501	2020-10-23 22:40:34.388501
4583	1	1	-1	2	\N	2018-07-12	-15.70	a805ae5228411fef54ab5ad0d57486b6	2020-10-23 22:40:34.389545	2020-10-23 22:40:34.389545
4584	5	9	48	2	\N	2018-07-11	-52.98	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:40:34.390559	2020-10-23 22:40:34.390559
4585	5	1	-1	2	\N	2018-07-10	-3.94	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:34.391667	2020-10-23 22:40:34.391667
4586	5	1	-1	2	\N	2018-07-09	-3.39	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:34.392869	2020-10-23 22:40:34.392869
4587	5	10	54	4	\N	2018-07-10	2500.00	82cec96096d4281b7c95cd7e74623496	2020-10-23 22:40:34.393858	2020-10-23 22:40:34.393858
4588	1	3	-1	2	\N	2018-07-14	-21.11	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.394785	2020-10-23 22:40:34.394785
4589	1	1	-1	2	\N	2018-07-13	-11.06	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.395681	2020-10-23 22:40:34.395681
4590	1	1	-1	2	\N	2018-07-13	-2.80	82161242827b703e6acf9c726942a1e4	2020-10-23 22:40:34.396671	2020-10-23 22:40:34.396671
4591	5	3	-1	2	\N	2018-07-14	-44.68	d663d87815b60985de0a0c14e5348b5d	2020-10-23 22:40:34.397592	2020-10-23 22:40:34.397592
4592	5	1	-1	2	\N	2018-07-14	-30.11	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.398542	2020-10-23 22:40:34.398542
4593	5	1	-1	2	\N	2018-07-14	-12.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.399504	2020-10-23 22:40:34.399504
4594	5	1	-1	2	\N	2018-07-14	-49.80	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.400456	2020-10-23 22:40:34.400456
4595	5	1	-1	2	\N	2018-07-12	-7.65	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.401379	2020-10-23 22:40:34.401379
4596	5	1	-1	2	\N	2018-07-13	-202.83	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.402353	2020-10-23 22:40:34.402353
4597	2	4	16	2	\N	2018-07-16	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:34.403267	2020-10-23 22:40:34.403267
4598	2	9	48	2	\N	2018-07-20	-20.00	91867fbe648e441c67b97fe5efcbd15a	2020-10-23 22:40:34.404458	2020-10-23 22:40:34.404458
4599	2	1	-1	2	\N	2018-07-21	-20.48	15195f8ffec6d7da495bb9364b679247	2020-10-23 22:40:34.405382	2020-10-23 22:40:34.405382
4600	5	9	-1	2	\N	2018-07-21	-120.99	53e3a7161e428b65688f14b84d61c610	2020-10-23 22:40:34.406308	2020-10-23 22:40:34.406308
4601	5	9	48	2	\N	2018-07-21	-10.00	8f85517967795eeef66c225f7883bdcb	2020-10-23 22:40:34.40727	2020-10-23 22:40:34.40727
4602	5	8	43	2	\N	2018-07-21	-225.81	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:34.408521	2020-10-23 22:40:34.408521
4603	5	3	-1	2	\N	2018-07-22	-17.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:34.409695	2020-10-23 22:40:34.409695
4604	1	1	-1	2	\N	2018-07-18	-19.00	03f5c5151e651832e5e4c9746d565229	2020-10-23 22:40:34.410738	2020-10-23 22:40:34.410738
4605	1	3	-1	2	\N	2018-07-19	-29.80	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.411682	2020-10-23 22:40:34.411682
4606	1	1	-1	2	\N	2018-07-19	-3.75	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.412662	2020-10-23 22:40:34.412662
4607	1	3	-1	2	\N	2018-07-20	-60.00	06ca655e1cff36fe062f783aa99f7c34	2020-10-23 22:40:34.413589	2020-10-23 22:40:34.413589
4608	1	1	-1	2	\N	2018-07-20	-14.11	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.414568	2020-10-23 22:40:34.414568
4609	1	5	23	2	\N	2018-07-20	-27.49	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.415489	2020-10-23 22:40:34.415489
4610	1	9	48	2	\N	2018-07-21	-11.65	f579c8706286fb7ce72ef94a0d14c4bf	2020-10-23 22:40:34.416476	2020-10-23 22:40:34.416476
4611	1	1	-1	2	\N	2018-07-21	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:34.417404	2020-10-23 22:40:34.417404
4612	1	1	-1	2	\N	2018-07-21	-2.25	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.418385	2020-10-23 22:40:34.418385
4613	1	1	-1	2	\N	2018-07-21	-15.63	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.419307	2020-10-23 22:40:34.419307
4614	1	1	-1	2	\N	2018-07-23	-11.89	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.420254	2020-10-23 22:40:34.420254
4615	1	1	-1	2	\N	2018-07-21	-14.50	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.421526	2020-10-23 22:40:34.421526
4616	5	1	-1	2	\N	2018-07-21	-9.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.42252	2020-10-23 22:40:34.42252
4617	5	1	-1	2	\N	2018-07-20	-132.19	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.423447	2020-10-23 22:40:34.423447
4618	1	8	41	2	\N	2018-07-22	-23.00	ba55ff88bddf71220a86105441fd2fff	2020-10-23 22:40:34.424437	2020-10-23 22:40:34.424437
4619	1	9	-1	3	\N	2018-07-22	-20.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:40:34.425394	2020-10-23 22:40:34.425394
4620	5	1	-1	2	\N	2018-07-23	-7.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.426344	2020-10-23 22:40:34.426344
4621	2	9	48	2	\N	2018-07-24	-164.45	08bfb7e81f8e8e69c698fcc37d73c1d4	2020-10-23 22:40:34.427278	2020-10-23 22:40:34.427278
4622	2	2	3	1	\N	2018-07-27	5964.30	0bed3765bd22a7103796f60e28b0ea68	2020-10-23 22:40:34.428505	2020-10-23 22:40:34.428505
4623	2	7	33	2	\N	2018-07-28	-50.00	3a066bda8c96b9478bb0512f0a43028c	2020-10-23 22:40:34.429435	2020-10-23 22:40:34.429435
4624	2	9	-1	4	\N	2018-07-28	391.81	3e716f30c8450143d7248609a6653887	2020-10-23 22:40:34.430413	2020-10-23 22:40:34.430413
4625	2	10	54	3	\N	2018-07-28	-5000.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:40:34.431394	2020-10-23 22:40:34.431394
4626	5	10	54	4	\N	2018-07-28	5000.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:40:34.43234	2020-10-23 22:40:34.43234
4627	5	4	13	2	\N	2018-07-29	-391.79	2291d2ec3b3048d1a6f86c2c4591b7e0	2020-10-23 22:40:34.433276	2020-10-23 22:40:34.433276
4628	5	4	-1	2	\N	2018-07-29	-590.00	e166f18e211001ff8f47f5d71bd5c254	2020-10-23 22:40:34.434516	2020-10-23 22:40:34.434516
4629	5	4	15	2	\N	2018-07-29	-109.78	6e0721b2c6977135b916ef286bcb49ec	2020-10-23 22:40:34.435445	2020-10-23 22:40:34.435445
4630	5	1	-1	2	\N	2018-07-26	-13.84	a5f7d7322cef445eeceff67de18a1254	2020-10-23 22:40:34.436411	2020-10-23 22:40:34.436411
4631	5	1	-1	2	\N	2018-07-28	-13.24	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:40:34.437339	2020-10-23 22:40:34.437339
4632	5	1	-1	2	\N	2018-07-28	-13.15	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:34.438305	2020-10-23 22:40:34.438305
4633	5	1	-1	2	\N	2018-07-28	-19.11	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.439227	2020-10-23 22:40:34.439227
4634	2	1	-1	2	\N	2018-07-29	-16.00	415947e1fe3f41f919e8a4e9ba8939fa	2020-10-23 22:40:34.440461	2020-10-23 22:40:34.440461
4635	6	10	54	3	\N	2018-07-25	-50000.00	871c14878fa75bc327ba87d2d284d596	2020-10-23 22:40:34.441456	2020-10-23 22:40:34.441456
4636	5	10	54	4	\N	2018-07-25	50000.00	871c14878fa75bc327ba87d2d284d596	2020-10-23 22:40:34.442482	2020-10-23 22:40:34.442482
4637	5	9	48	2	\N	2018-07-28	-31.79	25d46895f001766902354a18fba665ee	2020-10-23 22:40:34.44341	2020-10-23 22:40:34.44341
4638	1	1	-1	2	\N	2018-07-25	-2.38	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.444402	2020-10-23 22:40:34.444402
4639	1	2	-1	1	\N	2018-07-27	45.65	bcfe9bb5337cce255318bb10c381f919	2020-10-23 22:40:34.445329	2020-10-23 22:40:34.445329
4640	1	2	-1	1	\N	2018-07-27	40.55	bcfe9bb5337cce255318bb10c381f919	2020-10-23 22:40:34.446269	2020-10-23 22:40:34.446269
4641	1	2	3	1	\N	2018-07-27	10781.96	362842296f8c3370c748838bccf5e9c6	2020-10-23 22:40:34.44747	2020-10-23 22:40:34.44747
4642	1	10	54	3	\N	2018-07-27	-1000.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.448463	2020-10-23 22:40:34.448463
4643	1	10	54	3	\N	2018-07-27	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.449436	2020-10-23 22:40:34.449436
4644	1	10	54	3	\N	2018-07-27	-200.00	e63bbb12f96cce0b88dea6fd4d3fda7b	2020-10-23 22:40:34.450409	2020-10-23 22:40:34.450409
4645	1	10	54	3	\N	2018-07-27	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:34.451331	2020-10-23 22:40:34.451331
4646	6	10	54	4	\N	2018-07-27	1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:34.452304	2020-10-23 22:40:34.452304
4647	1	9	51	2	\N	2018-07-27	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.453227	2020-10-23 22:40:34.453227
4648	1	1	-1	2	\N	2018-07-27	-32.00	cf30c5a9bfb152765dae97cee99689f8	2020-10-23 22:40:34.454446	2020-10-23 22:40:34.454446
4649	1	4	18	2	\N	2018-07-28	-29.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:34.455371	2020-10-23 22:40:34.455371
4650	1	1	-1	2	\N	2018-07-28	-15.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.456325	2020-10-23 22:40:34.456325
4651	1	9	48	2	\N	2018-07-28	-32.00	97e8527feaf77a97fc38f34216141515	2020-10-23 22:40:34.457244	2020-10-23 22:40:34.457244
4652	1	7	36	2	\N	2018-07-30	-130.00	3a066bda8c96b9478bb0512f0a43028c	2020-10-23 22:40:34.458654	2020-10-23 22:40:34.458654
4653	1	1	-1	2	\N	2018-07-30	-13.67	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.459788	2020-10-23 22:40:34.459788
4654	5	1	-1	2	\N	2018-07-28	-100.32	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.460889	2020-10-23 22:40:34.460889
4655	5	5	23	2	\N	2018-07-24	-3.50	a0b3884152727aae6878481eca307532	2020-10-23 22:40:34.461899	2020-10-23 22:40:34.461899
4656	5	1	-1	2	\N	2018-07-24	-9.96	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.462898	2020-10-23 22:40:34.462898
4657	5	1	-1	2	\N	2018-07-28	-47.12	5191792b1ad05675fea3bbf015036b3b	2020-10-23 22:40:34.463969	2020-10-23 22:40:34.463969
4658	5	9	50	2	\N	2018-07-25	-7.50	c630dd16135d2a82b0518e1cd3b5d36f	2020-10-23 22:40:34.464981	2020-10-23 22:40:34.464981
4659	5	3	-1	2	\N	2018-07-28	-17.99	3759b70a6df0ca402642963bd06ddfb1	2020-10-23 22:40:34.466037	2020-10-23 22:40:34.466037
4660	5	1	-1	2	\N	2018-07-30	-35.00	4c5bde74a8f110656874902f07378009	2020-10-23 22:40:34.467108	2020-10-23 22:40:34.467108
4661	5	7	33	3	\N	2018-07-31	-15.00	7b2b417df328c89a176eaf7977838661	2020-10-23 22:40:34.468286	2020-10-23 22:40:34.468286
4662	1	2	-1	4	\N	2018-07-31	15.00	7b2b417df328c89a176eaf7977838661	2020-10-23 22:40:34.469597	2020-10-23 22:40:34.469597
4663	1	1	-1	2	\N	2018-08-01	-10.45	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.470597	2020-10-23 22:40:34.470597
4664	1	1	-1	2	\N	2018-07-31	-5.78	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:34.47195	2020-10-23 22:40:34.47195
4665	1	10	54	3	\N	2018-08-01	-7000.00	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.472935	2020-10-23 22:40:34.472935
4666	5	10	54	4	\N	2018-08-01	885.00	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.474048	2020-10-23 22:40:34.474048
4667	6	10	54	4	\N	2018-08-01	9000.00	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.475416	2020-10-23 22:40:34.475416
4668	6	10	54	4	\N	2018-08-01	21000.00	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.476533	2020-10-23 22:40:34.476533
4669	5	1	-1	2	\N	2018-08-01	-15.34	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:34.477625	2020-10-23 22:40:34.477625
4670	5	10	54	3	\N	2018-08-01	-2733.10	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.478904	2020-10-23 22:40:34.478904
4671	6	10	54	4	\N	2018-08-01	2733.10	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:34.480233	2020-10-23 22:40:34.480233
4672	6	10	55	1	\N	2018-08-01	74.94	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:34.481352	2020-10-23 22:40:34.481352
4673	1	9	-1	2	\N	2018-08-01	-44.06	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:40:34.482384	2020-10-23 22:40:34.482384
4674	5	9	-1	2	\N	2018-08-01	-81.33	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:40:34.483965	2020-10-23 22:40:34.483965
4675	1	2	-1	1	\N	2018-08-01	0.00	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:40:34.485004	2020-10-23 22:40:34.485004
4676	5	1	-1	2	\N	2018-08-04	-7.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.48604	2020-10-23 22:40:34.48604
4677	5	9	48	2	\N	2018-08-04	-500.00	c0ad3e597794ff5b85dc55bba00394c6	2020-10-23 22:40:34.487055	2020-10-23 22:40:34.487055
4678	5	9	48	2	\N	2018-08-03	-22.90	6d3b101ea442c36cfbf4ccf97ea6a0a5	2020-10-23 22:40:34.488105	2020-10-23 22:40:34.488105
4679	5	9	48	2	\N	2018-08-04	-5.20	b2eeb7362ef83deff5c7813a67e14f0a	2020-10-23 22:40:34.489467	2020-10-23 22:40:34.489467
4680	5	1	-1	2	\N	2018-08-04	-137.77	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:34.490686	2020-10-23 22:40:34.490686
4681	5	8	43	2	\N	2018-08-03	-203.47	13f9896df61279c928f19721878fac41	2020-10-23 22:40:34.492118	2020-10-23 22:40:34.492118
4682	5	5	23	2	\N	2018-08-03	-28.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.493581	2020-10-23 22:40:34.493581
4683	2	9	47	2	\N	2018-08-04	-100.00	12429caa7dae2d0de5a0c4ab435ce613	2020-10-23 22:40:34.494852	2020-10-23 22:40:34.494852
4684	2	4	18	2	\N	2018-08-06	-25.00	151f9002fb3c303ea3851145a4aee019	2020-10-23 22:40:34.49601	2020-10-23 22:40:34.49601
4685	1	1	-1	2	\N	2018-08-10	-21.65	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.497025	2020-10-23 22:40:34.497025
4686	1	3	-1	2	\N	2018-08-09	-12.00	05f971b5ec196b8c65b75d2ef8267331	2020-10-23 22:40:34.498078	2020-10-23 22:40:34.498078
4687	1	1	-1	2	\N	2018-08-09	-25.00	b534ba68236ba543ae44b22bd110a1d6	2020-10-23 22:40:34.499058	2020-10-23 22:40:34.499058
4688	1	3	-1	2	\N	2018-08-09	-8.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.500028	2020-10-23 22:40:34.500028
4689	1	3	-1	2	\N	2018-08-09	-9.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.501125	2020-10-23 22:40:34.501125
4690	1	3	-1	2	\N	2018-08-09	-14.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.502584	2020-10-23 22:40:34.502584
4691	1	1	-1	2	\N	2018-08-09	-14.97	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.503719	2020-10-23 22:40:34.503719
4692	1	1	-1	2	\N	2018-08-08	-12.00	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.504824	2020-10-23 22:40:34.504824
4693	1	3	-1	2	\N	2018-08-07	-4.09	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.506008	2020-10-23 22:40:34.506008
4694	1	1	-1	2	\N	2018-08-04	-6.50	72b090aebf783b64b0eb0622ff2f84b4	2020-10-23 22:40:34.507183	2020-10-23 22:40:34.507183
4695	1	1	-1	2	\N	2018-08-03	-40.00	e29ac9f673f5e41116828d7db06d7125	2020-10-23 22:40:34.508735	2020-10-23 22:40:34.508735
4696	5	1	-1	2	\N	2018-08-11	-11.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.510064	2020-10-23 22:40:34.510064
4697	5	1	-1	2	\N	2018-08-09	-11.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.511353	2020-10-23 22:40:34.511353
4698	5	1	-1	2	\N	2018-08-09	-21.24	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:34.512344	2020-10-23 22:40:34.512344
4699	5	1	-1	2	\N	2018-08-07	-153.00	8148cf440956aa149775202a8a22d1d1	2020-10-23 22:40:34.513432	2020-10-23 22:40:34.513432
4700	5	1	-1	2	\N	2018-08-07	-23.68	5404c6842152a0c1e8b80cb8457d8571	2020-10-23 22:40:34.514746	2020-10-23 22:40:34.514746
4701	5	8	43	2	\N	2018-08-07	-192.07	82a958afc122a6e476b5f93a210b781e	2020-10-23 22:40:34.515869	2020-10-23 22:40:34.515869
4702	5	10	54	4	\N	2018-08-06	5500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.516996	2020-10-23 22:40:34.516996
4703	5	10	54	3	\N	2018-08-07	-2500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.518089	2020-10-23 22:40:34.518089
4704	2	10	54	3	\N	2018-08-02	-1500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.519172	2020-10-23 22:40:34.519172
4705	5	1	-1	2	\N	2018-08-11	-149.52	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.520228	2020-10-23 22:40:34.520228
4706	2	1	-1	2	\N	2018-08-11	-8.00	c747744d17c6c1c9ab299b561708c2cd	2020-10-23 22:40:34.521287	2020-10-23 22:40:34.521287
4707	2	5	26	2	\N	2018-08-11	-4.49	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:34.522461	2020-10-23 22:40:34.522461
4708	2	5	26	2	\N	2018-08-11	-69.83	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:40:34.523578	2020-10-23 22:40:34.523578
4709	2	1	-1	2	\N	2018-08-11	-15.96	7db183c15847634a301761dc8b88e035	2020-10-23 22:40:34.524876	2020-10-23 22:40:34.524876
4710	2	9	48	2	\N	2018-08-11	-39.99	860320be12a1c050cd7731794e231bd3	2020-10-23 22:40:34.526536	2020-10-23 22:40:34.526536
4711	2	6	27	2	\N	2018-08-11	-14.90	42e77b63637ab381e8be5f8318cc28a2	2020-10-23 22:40:34.52772	2020-10-23 22:40:34.52772
4712	2	6	27	2	\N	2018-08-11	-69.99	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.528823	2020-10-23 22:40:34.528823
4713	5	8	43	2	\N	2018-08-13	-219.85	41596b5f0806f22457b98502a5dc69fc	2020-10-23 22:40:34.529962	2020-10-23 22:40:34.529962
4714	5	10	54	4	\N	2018-08-13	2500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.531119	2020-10-23 22:40:34.531119
4715	5	10	54	3	\N	2018-08-13	-5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.532236	2020-10-23 22:40:34.532236
4716	6	10	54	4	\N	2018-08-13	5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.533536	2020-10-23 22:40:34.533536
4717	1	9	48	2	\N	2018-08-13	-309.00	6855456e2fe46a9d49d3d3af4f57443d	2020-10-23 22:40:34.534873	2020-10-23 22:40:34.534873
4718	1	9	48	2	\N	2018-08-13	-16.49	6855456e2fe46a9d49d3d3af4f57443d	2020-10-23 22:40:34.536012	2020-10-23 22:40:34.536012
4719	5	1	-1	2	\N	2018-08-13	-4.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.537198	2020-10-23 22:40:34.537198
4720	5	5	23	2	\N	2018-08-13	-35.97	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:34.538508	2020-10-23 22:40:34.538508
4721	5	1	-1	2	\N	2018-08-13	-23.98	03791a189ab8540b8fe97dcee9af279f	2020-10-23 22:40:34.539604	2020-10-23 22:40:34.539604
4722	1	1	-1	2	\N	2018-08-15	-80.00	009a8b5a0cdf9d29afdc7eda9c2e8729	2020-10-23 22:40:34.54078	2020-10-23 22:40:34.54078
4723	1	8	41	2	\N	2018-08-16	-4.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:34.54227	2020-10-23 22:40:34.54227
4724	1	8	41	2	\N	2018-08-16	-50.95	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.543525	2020-10-23 22:40:34.543525
4725	5	2	-1	1	\N	2018-08-16	151.20	ac18ecedc6a1a71b26568c53ae5c0e62	2020-10-23 22:40:34.544631	2020-10-23 22:40:34.544631
4726	5	5	25	2	\N	2018-08-14	-25.00	2cb98cf87a1ea7d68097499de4c25d84	2020-10-23 22:40:34.545641	2020-10-23 22:40:34.545641
4727	5	1	-1	2	\N	2018-08-14	-5.00	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:34.546682	2020-10-23 22:40:34.546682
4728	5	3	-1	2	\N	2018-08-16	-8.98	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.547711	2020-10-23 22:40:34.547711
4729	5	1	-1	2	\N	2018-08-16	-16.59	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:40:34.548727	2020-10-23 22:40:34.548727
4730	5	1	-1	2	\N	2018-08-16	-8.54	f2d8c578871db7c146c902331a5368fc	2020-10-23 22:40:34.549676	2020-10-23 22:40:34.549676
4731	5	1	-1	2	\N	2018-08-16	-5.40	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:34.550684	2020-10-23 22:40:34.550684
4732	4	10	54	3	\N	2018-08-16	-500.00	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:40:34.55177	2020-10-23 22:40:34.55177
4733	2	10	54	4	\N	2018-08-16	500.00	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:40:34.552849	2020-10-23 22:40:34.552849
4734	2	4	16	2	\N	2018-08-16	-29.99	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:34.553943	2020-10-23 22:40:34.553943
4735	2	6	27	2	\N	2018-08-16	-16.70	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:34.55496	2020-10-23 22:40:34.55496
4736	1	6	27	2	\N	2018-08-17	-199.00	cd2cbd0a7d28268acfa68c32fcd6bcd6	2020-10-23 22:40:34.556026	2020-10-23 22:40:34.556026
4737	1	6	27	2	\N	2018-08-17	-329.90	ace56d06ef627eabe7e70ee3015303ba	2020-10-23 22:40:34.557152	2020-10-23 22:40:34.557152
4738	1	6	27	2	\N	2018-08-17	-59.99	de0034053bf08ed9ab63d04229a8685b	2020-10-23 22:40:34.558881	2020-10-23 22:40:34.558881
4739	1	5	21	2	\N	2018-08-17	-12.99	9461cce28ebe3e76fb4b931c35a169b0	2020-10-23 22:40:34.560199	2020-10-23 22:40:34.560199
4740	1	9	50	2	\N	2018-08-17	-7.50	84d9ee44e457ddef7f2c4f25dc8fa865	2020-10-23 22:40:34.561193	2020-10-23 22:40:34.561193
4741	1	10	54	4	\N	2018-08-17	400.00	84117275be999ff55a987b9381e01f96	2020-10-23 22:40:34.562533	2020-10-23 22:40:34.562533
4742	1	9	-1	3	\N	2018-08-16	-100.00	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:34.563584	2020-10-23 22:40:34.563584
4743	2	6	27	2	\N	2018-08-17	-14.00	6ea2ef7311b482724a9b7b0bc0dd85c6	2020-10-23 22:40:34.564677	2020-10-23 22:40:34.564677
4744	5	9	48	2	\N	2018-08-17	-34.00	30eaaaf5c36ec455827f2ad34b41f70d	2020-10-23 22:40:34.565895	2020-10-23 22:40:34.565895
4745	2	9	47	2	\N	2018-08-17	-50.00	9b04d152845ec0a378394003c96da594	2020-10-23 22:40:34.567049	2020-10-23 22:40:34.567049
4746	5	9	47	2	\N	2018-08-17	-500.00	3619cb5bf1ba5b8f0523230ca3f4f148	2020-10-23 22:40:34.568243	2020-10-23 22:40:34.568243
4747	2	5	25	2	\N	2018-08-20	-40.00	9f829f5f7d6d644e4560971cb07a756f	2020-10-23 22:40:34.569286	2020-10-23 22:40:34.569286
4748	2	8	41	2	\N	2018-08-21	-50.00	e820f3a30380e5c6e584268c302d35fa	2020-10-23 22:40:34.570325	2020-10-23 22:40:34.570325
4749	5	1	-1	2	\N	2018-08-20	-105.26	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:34.571491	2020-10-23 22:40:34.571491
4750	2	1	-1	2	\N	2018-08-21	-5.40	ebf11048b18616fbd6ba58d38a1858be	2020-10-23 22:40:34.572544	2020-10-23 22:40:34.572544
4751	2	1	-1	2	\N	2018-08-22	-49.00	bb8f53d98054f5b6d60889d54b1ea61c	2020-10-23 22:40:34.573531	2020-10-23 22:40:34.573531
4752	1	3	-1	2	\N	2018-08-21	-29.00	d58c0b5d9e88c04fc7b459d8e772b0ce	2020-10-23 22:40:34.574544	2020-10-23 22:40:34.574544
4753	5	1	-1	2	\N	2018-08-20	-9.25	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.575719	2020-10-23 22:40:34.575719
4754	5	1	-1	2	\N	2018-08-21	-13.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.576879	2020-10-23 22:40:34.576879
4755	5	5	23	2	\N	2018-08-19	-40.50	3af7892a614601fd8632759437984dcd	2020-10-23 22:40:34.577951	2020-10-23 22:40:34.577951
4756	5	8	41	2	\N	2018-08-19	-203.36	829190b95220e77629ac62b57de957c1	2020-10-23 22:40:34.579215	2020-10-23 22:40:34.579215
4757	5	7	36	2	\N	2018-08-20	-7.90	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:34.580435	2020-10-23 22:40:34.580435
4758	1	8	41	2	\N	2018-08-17	-37.00	8eb318b235b5e5ad5054608c162b6f8c	2020-10-23 22:40:34.58166	2020-10-23 22:40:34.58166
4759	5	1	-1	2	\N	2018-08-24	-9.60	605ff764c617d3cd28dbbdd72be8f9a2	2020-10-23 22:40:34.582793	2020-10-23 22:40:34.582793
4760	5	4	16	2	\N	2018-08-24	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:34.58378	2020-10-23 22:40:34.58378
4761	2	1	-1	2	\N	2018-08-22	-25.00	ebccbfa05569eaaeefc7e261dd0bdb26	2020-10-23 22:40:34.58476	2020-10-23 22:40:34.58476
4762	2	1	-1	2	\N	2018-08-22	-49.00	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:40:34.585732	2020-10-23 22:40:34.585732
4763	2	4	16	1	\N	2018-08-22	100.00	efd706e016f655021c0849b9358ac675	2020-10-23 22:40:34.586764	2020-10-23 22:40:34.586764
4764	1	3	-1	2	\N	2018-08-24	-3.39	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.587823	2020-10-23 22:40:34.587823
4765	1	1	-1	2	\N	2018-08-23	-62.80	24681928425f5a9133504de568f5f6df	2020-10-23 22:40:34.588977	2020-10-23 22:40:34.588977
4766	5	8	43	2	\N	2018-08-24	-248.01	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:34.59034	2020-10-23 22:40:34.59034
4767	5	1	-1	2	\N	2018-08-26	-81.97	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.591852	2020-10-23 22:40:34.591852
4768	1	4	18	2	\N	2018-08-27	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:34.593335	2020-10-23 22:40:34.593335
4769	1	2	3	1	\N	2018-08-27	8607.60	fde9264cf376fffe2ee4ddf4a988880d	2020-10-23 22:40:34.594585	2020-10-23 22:40:34.594585
4770	1	10	54	3	\N	2018-08-27	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.595683	2020-10-23 22:40:34.595683
4771	1	10	54	3	\N	2018-08-27	-700.00	58b57dcb10d16ab6214310c5459419ca	2020-10-23 22:40:34.596748	2020-10-23 22:40:34.596748
4772	2	6	27	2	\N	2018-08-28	-130.00	f55f1f93dc6030257f6dfe1e799d73bb	2020-10-23 22:40:34.59777	2020-10-23 22:40:34.59777
4773	2	2	3	1	\N	2018-08-28	9061.89	204a3eeab2a68f6bd87db22983749c42	2020-10-23 22:40:34.598878	2020-10-23 22:40:34.598878
4774	2	10	54	3	\N	2018-08-28	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.599957	2020-10-23 22:40:34.599957
4775	4	10	54	4	\N	2018-08-28	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.601677	2020-10-23 22:40:34.601677
4776	2	10	54	3	\N	2018-08-28	-6500.00	6f3ef77ac0e3619e98159e9b6febf557	2020-10-23 22:40:34.602838	2020-10-23 22:40:34.602838
4777	5	10	54	4	\N	2018-08-28	6500.00	6f3ef77ac0e3619e98159e9b6febf557	2020-10-23 22:40:34.603918	2020-10-23 22:40:34.603918
4778	5	4	13	2	\N	2018-08-28	-404.88	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:34.605034	2020-10-23 22:40:34.605034
4779	5	4	15	2	\N	2018-08-28	-115.48	df7782cc7d1222cb8c1fb24f33ea040a	2020-10-23 22:40:34.606219	2020-10-23 22:40:34.606219
4780	5	4	14	2	\N	2018-08-28	-108.33	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:34.607375	2020-10-23 22:40:34.607375
4781	5	1	-1	2	\N	2018-08-29	-4.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.608456	2020-10-23 22:40:34.608456
4782	1	1	-1	2	\N	2018-08-28	-10.68	5b5be1003cc290a17d5c83b942a656c0	2020-10-23 22:40:34.609813	2020-10-23 22:40:34.609813
4783	1	1	-1	2	\N	2018-08-28	-1.69	b5cc2f2bce2e25c81175b1a867d33e0a	2020-10-23 22:40:34.611691	2020-10-23 22:40:34.611691
4784	1	9	51	2	\N	2018-08-30	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.612839	2020-10-23 22:40:34.612839
4785	5	1	-1	2	\N	2018-08-29	-14.53	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:34.614079	2020-10-23 22:40:34.614079
4786	5	1	-1	2	\N	2018-08-30	-4.20	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:34.615235	2020-10-23 22:40:34.615235
4787	5	5	23	2	\N	2018-08-30	-88.02	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.616669	2020-10-23 22:40:34.616669
4788	5	7	33	3	\N	2018-08-31	-15.00	7f5144f962efde75e0f7661e032166db	2020-10-23 22:40:34.617875	2020-10-23 22:40:34.617875
4789	1	2	-1	4	\N	2018-08-31	15.00	7f5144f962efde75e0f7661e032166db	2020-10-23 22:40:34.618953	2020-10-23 22:40:34.618953
4790	5	1	-1	2	\N	2018-08-31	-10.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.620006	2020-10-23 22:40:34.620006
4791	5	9	48	2	\N	2018-08-31	-39.69	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:40:34.621081	2020-10-23 22:40:34.621081
4792	5	1	-1	2	\N	2018-08-31	-124.67	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:34.622111	2020-10-23 22:40:34.622111
4793	6	10	55	1	\N	2018-08-31	68.07	8c18a8955c810caf01de158a6eb57908	2020-10-23 22:40:34.623086	2020-10-23 22:40:34.623086
4794	5	2	-1	1	\N	2018-09-01	0.00	158e46ebb0fa28059bffc445a6f10da0	2020-10-23 22:40:34.624275	2020-10-23 22:40:34.624275
4795	1	10	54	3	\N	2018-09-01	-7000.00	d9b88725d0e719bad8fe8ed59e0fd463	2020-10-23 22:40:34.626056	2020-10-23 22:40:34.626056
4796	1	9	49	2	\N	2018-09-01	-100.00	e737b5ac24a63afc00e81377a906728d	2020-10-23 22:40:34.627345	2020-10-23 22:40:34.627345
4797	5	5	26	2	\N	2018-09-01	-44.40	18a2ed0bbf9cd483570dd5b9563bc32c	2020-10-23 22:40:34.628387	2020-10-23 22:40:34.628387
4798	2	9	48	2	\N	2018-09-01	-7.99	ec172bdf8268fc78d68135c83f2c9231	2020-10-23 22:40:34.629371	2020-10-23 22:40:34.629371
4799	2	1	-1	2	\N	2018-09-01	-12.00	e08549a19f9035f313995d64075de7fa	2020-10-23 22:40:34.630373	2020-10-23 22:40:34.630373
4800	1	1	-1	2	\N	2018-09-02	-10.50	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:40:34.631388	2020-10-23 22:40:34.631388
4801	5	9	48	2	\N	2018-09-02	-70.00	6788875d69976f4d4c84b2812f95d3ac	2020-10-23 22:40:34.632676	2020-10-23 22:40:34.632676
4802	2	9	48	2	\N	2018-09-02	-30.00	cd00692c3bfe59267d5ecfac5310286c	2020-10-23 22:40:34.633808	2020-10-23 22:40:34.633808
4803	1	1	-1	2	\N	2018-09-05	-9.40	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.634865	2020-10-23 22:40:34.634865
4804	5	1	-1	2	\N	2018-09-05	-119.42	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:34.635886	2020-10-23 22:40:34.635886
4805	5	1	-1	2	\N	2018-09-04	-11.94	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:34.636959	2020-10-23 22:40:34.636959
4806	5	1	-1	2	\N	2018-09-04	-9.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.638088	2020-10-23 22:40:34.638088
4807	5	5	23	2	\N	2018-09-03	-25.49	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.639278	2020-10-23 22:40:34.639278
4808	5	1	-1	2	\N	2018-09-03	-3.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.640317	2020-10-23 22:40:34.640317
4809	5	4	-1	2	\N	2018-09-06	-162.00	42998cf32d552343bc8e460416382dca	2020-10-23 22:40:34.64135	2020-10-23 22:40:34.64135
4810	5	10	54	4	\N	2018-09-04	5500.00	8af25e7891a6d3304633d972810637cf	2020-10-23 22:40:34.642643	2020-10-23 22:40:34.642643
4811	2	10	54	3	\N	2018-09-03	-1500.00	8af25e7891a6d3304633d972810637cf	2020-10-23 22:40:34.643761	2020-10-23 22:40:34.643761
4812	1	10	54	4	\N	2018-09-06	500.00	c24cd76e1ce41366a4bbe8a49b02a028	2020-10-23 22:40:34.644829	2020-10-23 22:40:34.644829
4813	5	10	54	3	\N	2018-09-06	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.645812	2020-10-23 22:40:34.645812
4814	1	10	54	4	\N	2018-09-06	500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.64683	2020-10-23 22:40:34.64683
4815	1	8	42	2	\N	2018-09-06	-212.00	3cec07e9ba5f5bb252d13f5f431e4bbb	2020-10-23 22:40:34.647834	2020-10-23 22:40:34.647834
4816	5	10	54	3	\N	2018-09-07	-2500.00	8af25e7891a6d3304633d972810637cf	2020-10-23 22:40:34.648845	2020-10-23 22:40:34.648845
4817	5	1	-1	2	\N	2018-09-07	-9.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.649945	2020-10-23 22:40:34.649945
4818	5	8	43	2	\N	2018-09-07	-251.42	afd08aa3a732effe76c37772ec41ad20	2020-10-23 22:40:34.651015	2020-10-23 22:40:34.651015
4819	5	1	-1	2	\N	2018-09-07	-21.98	3b144455abbdcf4d5329bc5e9cf14f92	2020-10-23 22:40:34.652159	2020-10-23 22:40:34.652159
4820	1	1	-1	2	\N	2018-09-08	-8.73	3b144455abbdcf4d5329bc5e9cf14f92	2020-10-23 22:40:34.653214	2020-10-23 22:40:34.653214
4821	1	3	-1	2	\N	2018-09-08	-20.00	3a080b2a2f11ddee1a665fb9807eec24	2020-10-23 22:40:34.654263	2020-10-23 22:40:34.654263
4822	1	1	-1	2	\N	2018-09-08	-36.60	3b144455abbdcf4d5329bc5e9cf14f92	2020-10-23 22:40:34.655287	2020-10-23 22:40:34.655287
4823	1	8	42	2	\N	2018-09-09	-182.00	9cf525b383c7d980312f7f2ae0b20ba0	2020-10-23 22:40:34.656291	2020-10-23 22:40:34.656291
4824	1	7	35	2	\N	2018-09-09	-67.00	30f5eef91a397e4bbab4d93aeb286aef	2020-10-23 22:40:34.657285	2020-10-23 22:40:34.657285
4825	1	1	-1	2	\N	2018-09-09	-41.90	970cc2690f73f070b53535c7f6c4bc47	2020-10-23 22:40:34.658902	2020-10-23 22:40:34.658902
4826	1	1	-1	2	\N	2018-09-10	-9.00	eef65dfd5f52defae7f04a474dd76f2f	2020-10-23 22:40:34.660166	2020-10-23 22:40:34.660166
4827	1	1	-1	2	\N	2018-09-10	-1.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.661489	2020-10-23 22:40:34.661489
4828	1	1	-1	2	\N	2018-09-11	-17.60	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.662566	2020-10-23 22:40:34.662566
4829	1	9	51	2	\N	2018-09-13	-20.00	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:34.663552	2020-10-23 22:40:34.663552
4830	5	10	54	4	\N	2018-09-11	2500.00	8af25e7891a6d3304633d972810637cf	2020-10-23 22:40:34.664607	2020-10-23 22:40:34.664607
4831	5	1	-1	2	\N	2018-09-11	-7.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.665671	2020-10-23 22:40:34.665671
4832	5	5	21	2	\N	2018-09-12	-45.16	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:40:34.666765	2020-10-23 22:40:34.666765
4833	5	2	-1	1	\N	2018-09-13	67.16	d44bbe4876f51dae2e73f0b2833cd74d	2020-10-23 22:40:34.667746	2020-10-23 22:40:34.667746
4834	5	1	-1	2	\N	2018-09-13	-5.67	598b3e71ec378bd83e0a727608b5db01	2020-10-23 22:40:34.668866	2020-10-23 22:40:34.668866
4835	5	5	23	2	\N	2018-09-13	-45.97	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.670106	2020-10-23 22:40:34.670106
4836	5	1	-1	2	\N	2018-09-13	-106.94	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.671186	2020-10-23 22:40:34.671186
4837	5	1	-1	2	\N	2018-09-13	-15.01	ae0eb3eed39d2bcef4622b2499a05fe6	2020-10-23 22:40:34.672273	2020-10-23 22:40:34.672273
4838	1	9	51	2	\N	2018-09-13	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.673282	2020-10-23 22:40:34.673282
4839	1	1	-1	2	\N	2018-09-15	-37.90	d90876bf4c28d9b5222e4d18eed22ad9	2020-10-23 22:40:34.674277	2020-10-23 22:40:34.674277
4840	5	1	-1	2	\N	2018-09-15	-15.70	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:40:34.675357	2020-10-23 22:40:34.675357
4841	5	1	-1	2	\N	2018-09-15	-2.87	5b52f08c77c86d048c78ea841df47193	2020-10-23 22:40:34.676509	2020-10-23 22:40:34.676509
4842	5	1	-1	2	\N	2018-09-15	-9.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.677587	2020-10-23 22:40:34.677587
4843	5	9	48	2	\N	2018-09-14	-28.55	bf0a970cb9da391992c69626451e72a1	2020-10-23 22:40:34.678655	2020-10-23 22:40:34.678655
4844	1	3	-1	2	\N	2018-09-15	-21.00	c1445cabed5c957bd296c8f327306d5a	2020-10-23 22:40:34.679628	2020-10-23 22:40:34.679628
4845	5	1	-1	2	\N	2018-09-16	-15.70	a1d6b81e36f848d69fb657d79d2693c4	2020-10-23 22:40:34.680609	2020-10-23 22:40:34.680609
4846	5	1	-1	2	\N	2018-09-17	-20.14	1700002963a49da13542e0726b7bb758	2020-10-23 22:40:34.681596	2020-10-23 22:40:34.681596
4847	2	4	16	2	\N	2018-09-20	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:34.682739	2020-10-23 22:40:34.682739
4848	2	5	22	1	\N	2018-09-13	128.17	5a89924ad353f0f0d5b7bf6ee8e0909b	2020-10-23 22:40:34.683886	2020-10-23 22:40:34.683886
4849	2	4	18	2	\N	2018-09-08	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:34.684911	2020-10-23 22:40:34.684911
4850	2	1	-1	2	\N	2018-09-09	-21.98	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:34.685938	2020-10-23 22:40:34.685938
4851	2	4	16	1	\N	2018-09-07	100.00	1b5449c9c2f3481ae6c524c55d3fb9e2	2020-10-23 22:40:34.686952	2020-10-23 22:40:34.686952
4852	5	9	48	2	\N	2018-09-20	-65.00	03753883dc14bdd53dab5d175abd09f1	2020-10-23 22:40:34.687975	2020-10-23 22:40:34.687975
4853	2	9	48	2	\N	2018-09-20	-54.98	7b4e2412f6019b9176b58021e1d8f40f	2020-10-23 22:40:34.689009	2020-10-23 22:40:34.689009
4854	5	1	-1	2	\N	2018-09-20	-63.73	fd1597879183ad6c02a9a36cb3c074f5	2020-10-23 22:40:34.690288	2020-10-23 22:40:34.690288
4855	5	1	-1	2	\N	2018-09-20	-134.42	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:40:34.691385	2020-10-23 22:40:34.691385
4856	5	9	48	2	\N	2018-09-20	-24.90	73bbe745386fa773e49954ff24f16f31	2020-10-23 22:40:34.69261	2020-10-23 22:40:34.69261
4857	2	5	23	2	\N	2018-09-20	-35.69	e11a3057560d38fce4468acccbfae592	2020-10-23 22:40:34.693718	2020-10-23 22:40:34.693718
4858	1	1	-1	2	\N	2018-09-21	-17.21	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.694766	2020-10-23 22:40:34.694766
4859	1	8	42	2	\N	2018-09-18	-73.00	cf2508f19af544b3ab4935ddb7414a9d	2020-10-23 22:40:34.695789	2020-10-23 22:40:34.695789
4860	1	1	-1	2	\N	2018-09-21	-16.00	e2230b853516e7b05d79744fbd4c9c13	2020-10-23 22:40:34.696848	2020-10-23 22:40:34.696848
4861	5	1	-1	2	\N	2018-09-22	-9.95	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:40:34.697858	2020-10-23 22:40:34.697858
4862	5	1	-1	2	\N	2018-09-22	-11.20	a041fd74f6e07754fe6b3ba46e53bda2	2020-10-23 22:40:34.698878	2020-10-23 22:40:34.698878
4863	5	1	-1	2	\N	2018-09-22	-8.60	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.699986	2020-10-23 22:40:34.699986
4864	5	1	-1	2	\N	2018-09-21	-3.84	4eb1107c15de158c48a6fac6983d5ec2	2020-10-23 22:40:34.701023	2020-10-23 22:40:34.701023
4865	2	9	47	3	\N	2018-09-22	-100.00	8b0a53da4d4777afb054fb1a4fd2060d	2020-10-23 22:40:34.702039	2020-10-23 22:40:34.702039
4866	2	1	-1	2	\N	2018-09-22	-13.20	173f6138afd9b026372907766f8d3764	2020-10-23 22:40:34.703011	2020-10-23 22:40:34.703011
4867	2	3	-1	2	\N	2018-09-21	-11.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.704013	2020-10-23 22:40:34.704013
4868	5	7	30	2	\N	2018-09-22	-50.00	a8f15eda80c50adb0e71943adc8015cf	2020-10-23 22:40:34.704992	2020-10-23 22:40:34.704992
4869	5	5	26	2	\N	2018-09-22	-36.91	e3b55dca427b6f1a1a2a22563129284a	2020-10-23 22:40:34.706043	2020-10-23 22:40:34.706043
4870	2	9	48	2	\N	2018-09-22	-58.00	a2449b6477c1fef79be4202906486876	2020-10-23 22:40:34.707045	2020-10-23 22:40:34.707045
4871	2	9	48	2	\N	2018-09-22	-49.99	e1eee5e2b42d45443cdc82db1a3bc465	2020-10-23 22:40:34.70809	2020-10-23 22:40:34.70809
4872	5	1	-1	2	\N	2018-09-23	-7.49	7c91f9555d05e335d195d761340f8968	2020-10-23 22:40:34.709568	2020-10-23 22:40:34.709568
4873	1	9	49	3	\N	2018-09-22	-50.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:34.710667	2020-10-23 22:40:34.710667
4874	1	7	36	2	\N	2018-09-22	-33.89	854d9fca60b4bd07f9bb215d59ef5561	2020-10-23 22:40:34.711737	2020-10-23 22:40:34.711737
4875	2	8	45	2	\N	2018-09-22	-39.00	65cfedc1257708b982a1843db9b46872	2020-10-23 22:40:34.712867	2020-10-23 22:40:34.712867
4876	5	1	-1	2	\N	2018-09-24	-54.60	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:34.713908	2020-10-23 22:40:34.713908
4877	1	1	-1	2	\N	2018-09-24	-5.88	c172a8ce69eede4a9d5041fbe039bfd8	2020-10-23 22:40:34.714875	2020-10-23 22:40:34.714875
4878	5	8	45	2	\N	2018-09-24	-39.00	1a1f350e065f6646a0c8468b3e1eeb45	2020-10-23 22:40:34.716034	2020-10-23 22:40:34.716034
4879	5	8	43	2	\N	2018-09-25	-234.26	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:34.717104	2020-10-23 22:40:34.717104
4880	1	9	49	2	\N	2018-09-25	-99.00	35dbf860256a38d45b1429958533424d	2020-10-23 22:40:34.718157	2020-10-23 22:40:34.718157
4881	1	1	-1	2	\N	2018-10-01	-2.80	9d92a68a2c7e3e2538c9cb4d6c09824b	2020-10-23 22:40:34.719157	2020-10-23 22:40:34.719157
4882	1	1	-1	2	\N	2018-10-01	-13.64	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:34.720185	2020-10-23 22:40:34.720185
4883	1	9	48	2	\N	2018-10-01	-20.00	68b6a776378decbb4a79cda89087c4ce	2020-10-23 22:40:34.72127	2020-10-23 22:40:34.72127
4884	1	1	-1	2	\N	2018-10-29	-2.99	297cd5b16264aab5b31ea30886c86798	2020-10-23 22:40:34.722695	2020-10-23 22:40:34.722695
4885	1	8	41	2	\N	2018-09-30	-29.55	738cccd4fda172441f216712a488dca6	2020-10-23 22:40:34.723884	2020-10-23 22:40:34.723884
4886	1	1	-1	2	\N	2018-09-28	-1.80	563c921f86a55d6de976d908883dcfce	2020-10-23 22:40:34.725151	2020-10-23 22:40:34.725151
4887	1	5	25	2	\N	2018-09-28	-50.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:34.726449	2020-10-23 22:40:34.726449
4888	1	3	-1	2	\N	2018-09-26	-55.00	ce5577e089317810bb3c4d695bfdb6b1	2020-10-23 22:40:34.727589	2020-10-23 22:40:34.727589
4889	1	4	18	2	\N	2018-09-27	-19.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:34.729364	2020-10-23 22:40:34.729364
4890	1	1	-1	2	\N	2018-09-27	-18.80	2ba100d60448c3b5fe2dc55a892104f0	2020-10-23 22:40:34.730623	2020-10-23 22:40:34.730623
4891	1	6	28	2	\N	2018-09-27	-8.98	b22899abfa50d6e0ce48d3cf349ac15a	2020-10-23 22:40:34.731903	2020-10-23 22:40:34.731903
4892	1	9	48	2	\N	2018-09-27	-74.99	e6f4149f5c6a20ed69b859bc81de182c	2020-10-23 22:40:34.733391	2020-10-23 22:40:34.733391
4893	1	3	-1	2	\N	2018-09-26	-11.00	43feaeeecd7b2fe2ae2e26d917b6477d	2020-10-23 22:40:34.73458	2020-10-23 22:40:34.73458
4894	1	8	41	2	\N	2018-09-26	-5.90	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:34.735747	2020-10-23 22:40:34.735747
4895	1	8	41	2	\N	2018-09-26	-26.40	71c32595c397960f74555a8b9db16f75	2020-10-23 22:40:34.736903	2020-10-23 22:40:34.736903
4896	1	2	3	1	\N	2018-09-26	9603.33	a8bb8b55788a7882f3e6ca8d1b52bdde	2020-10-23 22:40:34.738026	2020-10-23 22:40:34.738026
4897	1	10	54	3	\N	2018-10-01	-7000.00	81e74d678581a3bb7a720b019f4f1a93	2020-10-23 22:40:34.739128	2020-10-23 22:40:34.739128
4898	5	1	-1	2	\N	2018-10-01	-18.38	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.740372	2020-10-23 22:40:34.740372
4899	5	1	-1	2	\N	2018-10-01	-19.45	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:34.741714	2020-10-23 22:40:34.741714
4900	5	9	-1	2	\N	2018-10-01	-98.29	bf62768ca46b6c3b5bea9515d1a1fc45	2020-10-23 22:40:34.743246	2020-10-23 22:40:34.743246
4901	5	1	-1	2	\N	2018-09-28	-7.20	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.74448	2020-10-23 22:40:34.74448
4902	5	1	-1	2	\N	2018-09-28	-3.99	8649d08b16b9b12ae93322a1936015ea	2020-10-23 22:40:34.745722	2020-10-23 22:40:34.745722
4903	5	1	-1	2	\N	2018-09-26	-8.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.747103	2020-10-23 22:40:34.747103
4904	6	10	55	1	\N	2018-09-30	0.36	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:34.748424	2020-10-23 22:40:34.748424
4905	6	10	55	1	\N	2018-09-30	69.30	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:34.749993	2020-10-23 22:40:34.749993
4906	1	9	49	2	\N	2018-10-01	-99.99	e97ee2054defb209c35fe4dc94599061	2020-10-23 22:40:34.751243	2020-10-23 22:40:34.751243
4907	1	10	54	3	\N	2018-10-01	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.752401	2020-10-23 22:40:34.752401
4908	1	10	54	3	\N	2018-10-01	-500.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:34.753685	2020-10-23 22:40:34.753685
4909	1	10	54	3	\N	2018-10-01	-200.00	343d9040a671c45832ee5381860e2996	2020-10-23 22:40:34.755115	2020-10-23 22:40:34.755115
4910	5	7	30	2	\N	2018-10-01	-47.95	a8f15eda80c50adb0e71943adc8015cf	2020-10-23 22:40:34.75707	2020-10-23 22:40:34.75707
4911	5	7	33	3	\N	2018-10-01	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.758665	2020-10-23 22:40:34.758665
4912	1	2	-1	4	\N	2018-10-01	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.760295	2020-10-23 22:40:34.760295
4913	5	1	-1	2	\N	2018-10-02	-6.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.761548	2020-10-23 22:40:34.761548
4914	5	5	23	2	\N	2018-10-02	-39.48	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.762769	2020-10-23 22:40:34.762769
4915	1	1	-1	2	\N	2018-10-02	-2.00	21cea431e6a5dbdb0e78a21075618e7d	2020-10-23 22:40:34.763893	2020-10-23 22:40:34.763893
4916	2	2	3	1	\N	2018-10-03	4991.13	b2f627fff19fda463cb386442eac2b3d	2020-10-23 22:40:34.765013	2020-10-23 22:40:34.765013
4917	2	10	54	3	\N	2018-10-02	-3000.00	38c8ce17b0d03d0bb30d3b78edfa597d	2020-10-23 22:40:34.766153	2020-10-23 22:40:34.766153
4918	5	10	54	4	\N	2018-10-02	3000.00	38c8ce17b0d03d0bb30d3b78edfa597d	2020-10-23 22:40:34.76737	2020-10-23 22:40:34.76737
4919	2	9	-1	2	\N	2018-10-02	-96.41	f335e9f0e59921511c33549aee7cc1e5	2020-10-23 22:40:34.768626	2020-10-23 22:40:34.768626
4920	5	4	13	2	\N	2018-10-03	-398.78	d7b24e66a3c4ea77a4a224995bc3899a	2020-10-23 22:40:34.769906	2020-10-23 22:40:34.769906
4921	5	10	54	3	\N	2018-10-03	-5000.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:34.771214	2020-10-23 22:40:34.771214
4922	6	10	54	4	\N	2018-10-03	5000.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:34.772748	2020-10-23 22:40:34.772748
4923	5	4	16	2	\N	2018-10-04	-49.90	e165421110ba03099a1c0393373c5b43	2020-10-23 22:40:34.774059	2020-10-23 22:40:34.774059
4924	1	9	-1	2	\N	2018-10-04	-79.99	5f4195fd143ca44b68480255c171f7ef	2020-10-23 22:40:34.775568	2020-10-23 22:40:34.775568
4925	5	1	-1	2	\N	2018-10-04	-100.16	67e103b0761e60683e83c559be18d40c	2020-10-23 22:40:34.776822	2020-10-23 22:40:34.776822
4926	5	10	54	4	\N	2018-10-08	5400.00	b3e2026d10e46df62f0d1cdfa85d7aaa	2020-10-23 22:40:34.777992	2020-10-23 22:40:34.777992
4927	1	1	-1	2	\N	2018-10-05	-15.19	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:34.779061	2020-10-23 22:40:34.779061
4928	1	8	41	2	\N	2018-10-06	-33.22	71c32595c397960f74555a8b9db16f75	2020-10-23 22:40:34.780207	2020-10-23 22:40:34.780207
4929	1	9	51	2	\N	2018-10-05	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.781811	2020-10-23 22:40:34.781811
4930	5	1	-1	2	\N	2018-10-06	-65.26	647bba344396e7c8170902bcf2e15551	2020-10-23 22:40:34.783087	2020-10-23 22:40:34.783087
4931	5	1	-1	2	\N	2018-10-06	-4.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.784629	2020-10-23 22:40:34.784629
4932	5	1	-1	2	\N	2018-10-05	-31.95	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.786265	2020-10-23 22:40:34.786265
4933	5	1	-1	2	\N	2018-10-05	-4.95	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.787466	2020-10-23 22:40:34.787466
4934	5	1	-1	2	\N	2018-10-07	-47.87	5c44f18b762ccfaa619598db2838c67a	2020-10-23 22:40:34.788808	2020-10-23 22:40:34.788808
4935	5	10	54	3	\N	2018-10-08	-2500.00	becf3aa5cf9e244cc7f84aeb73d3bab9	2020-10-23 22:40:34.790138	2020-10-23 22:40:34.790138
4936	5	1	-1	2	\N	2018-10-07	-8.95	67e103b0761e60683e83c559be18d40c	2020-10-23 22:40:34.791433	2020-10-23 22:40:34.791433
4937	5	9	48	2	\N	2018-10-08	-108.16	7386b943e784e95d4a89a28046f86e94	2020-10-23 22:40:34.79275	2020-10-23 22:40:34.79275
4938	2	3	-1	2	\N	2018-10-08	-14.69	8e7c6b19af1fc49034a4b2663e55d987	2020-10-23 22:40:34.79415	2020-10-23 22:40:34.79415
4939	2	4	18	2	\N	2018-10-08	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:34.795532	2020-10-23 22:40:34.795532
4940	2	1	-1	2	\N	2018-10-09	-18.31	f3180ef260920b1f25543cd89011920a	2020-10-23 22:40:34.796791	2020-10-23 22:40:34.796791
4941	5	10	54	4	\N	2018-10-11	2500.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:34.798236	2020-10-23 22:40:34.798236
4942	5	1	-1	2	\N	2018-10-09	-10.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.799813	2020-10-23 22:40:34.799813
4943	1	1	-1	2	\N	2018-10-11	-15.72	01f78be6f7cad02658508fe4616098a9	2020-10-23 22:40:34.801322	2020-10-23 22:40:34.801322
4944	1	3	-1	2	\N	2018-10-12	-47.00	e29ac9f673f5e41116828d7db06d7125	2020-10-23 22:40:34.802572	2020-10-23 22:40:34.802572
4945	5	10	54	3	\N	2018-10-12	-5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.804388	2020-10-23 22:40:34.804388
4946	6	10	54	4	\N	2018-10-12	5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.806129	2020-10-23 22:40:34.806129
4947	5	1	-1	2	\N	2018-10-13	-8.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.807431	2020-10-23 22:40:34.807431
4948	5	1	-1	2	\N	2018-10-12	-19.73	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.808827	2020-10-23 22:40:34.808827
4949	5	1	-1	2	\N	2018-10-12	-182.28	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.81036	2020-10-23 22:40:34.81036
4950	2	2	3	1	\N	2018-10-13	1534.03	31668270a64a66188b2c969d57998572	2020-10-23 22:40:34.811763	2020-10-23 22:40:34.811763
4951	2	9	47	2	\N	2018-10-14	-50.00	b9228e0962a78b84f3d5d92f4faa000b	2020-10-23 22:40:34.81336	2020-10-23 22:40:34.81336
4952	5	1	-1	2	\N	2018-10-16	-1.80	bfcacdfdea54d7b07d6b9c9f108118a6	2020-10-23 22:40:34.814562	2020-10-23 22:40:34.814562
4953	5	1	-1	2	\N	2018-10-18	-140.09	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:40:34.815982	2020-10-23 22:40:34.815982
4954	5	3	-1	2	\N	2018-10-19	-19.99	7fa732b517cbed14a48843d74526c11a	2020-10-23 22:40:34.817294	2020-10-23 22:40:34.817294
4955	1	3	-1	2	\N	2018-10-18	-430.00	738aebc1f9aef81413d00e0990bb2e45	2020-10-23 22:40:34.818418	2020-10-23 22:40:34.818418
4956	1	1	-1	2	\N	2018-10-19	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:34.819724	2020-10-23 22:40:34.819724
4957	1	5	23	2	\N	2018-10-19	-51.49	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.820909	2020-10-23 22:40:34.820909
4958	1	1	-1	2	\N	2018-10-17	-13.75	13f9896df61279c928f19721878fac41	2020-10-23 22:40:34.822688	2020-10-23 22:40:34.822688
4959	1	1	-1	2	\N	2018-10-18	-11.17	13f9896df61279c928f19721878fac41	2020-10-23 22:40:34.823957	2020-10-23 22:40:34.823957
4960	1	1	-1	2	\N	2018-10-17	-19.00	f2e587d9254f9d8b81fac329cd0f859e	2020-10-23 22:40:34.826034	2020-10-23 22:40:34.826034
4961	1	5	23	2	\N	2018-10-17	-2.50	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.827394	2020-10-23 22:40:34.827394
4962	1	5	23	2	\N	2018-10-17	-17.73	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.829122	2020-10-23 22:40:34.829122
4963	1	5	23	2	\N	2018-10-16	-18.99	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.830607	2020-10-23 22:40:34.830607
4964	1	1	-1	2	\N	2018-10-16	-14.50	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:40:34.831862	2020-10-23 22:40:34.831862
4965	1	8	41	2	\N	2018-10-15	-37.00	2a9d121cd9c3a1832bb6d2cc6bd7a8a7	2020-10-23 22:40:34.833265	2020-10-23 22:40:34.833265
4966	1	8	41	2	\N	2018-10-15	-33.42	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.834624	2020-10-23 22:40:34.834624
4967	5	6	27	2	\N	2018-10-20	-13.98	1feea25ecb958229287f885aebe7c49b	2020-10-23 22:40:34.836005	2020-10-23 22:40:34.836005
4968	5	1	-1	2	\N	2018-10-20	-9.90	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:34.837377	2020-10-23 22:40:34.837377
4969	5	1	-1	2	\N	2018-10-18	-11.34	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:34.838754	2020-10-23 22:40:34.838754
4970	5	4	15	2	\N	2018-10-24	-126.28	310dcbbf4cce62f762a2aaa148d556bd	2020-10-23 22:40:34.840255	2020-10-23 22:40:34.840255
4971	4	10	54	3	\N	2018-10-23	-2000.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:34.841467	2020-10-23 22:40:34.841467
4972	2	10	54	4	\N	2018-10-23	2000.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:34.843078	2020-10-23 22:40:34.843078
4973	2	6	27	2	\N	2018-10-20	-59.60	f5f8590cd58a54e94377e6ae2eded4d9	2020-10-23 22:40:34.844611	2020-10-23 22:40:34.844611
4974	2	5	26	2	\N	2018-10-19	-111.22	b639b69797ebed78f26a314f53566956	2020-10-23 22:40:34.845953	2020-10-23 22:40:34.845953
4975	5	5	26	2	\N	2018-10-24	-59.25	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:34.847292	2020-10-23 22:40:34.847292
4976	2	5	26	1	\N	2018-10-24	59.25	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:34.848606	2020-10-23 22:40:34.848606
4977	2	9	48	2	\N	2018-10-13	-23.99	0dc8f3959597de2462d5aba542a4b712	2020-10-23 22:40:34.849928	2020-10-23 22:40:34.849928
4978	2	1	-1	2	\N	2018-10-18	-9.29	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:40:34.851278	2020-10-23 22:40:34.851278
4979	2	9	48	2	\N	2018-10-25	-10.00	e0932d6426c66ffde75f845923a6d77d	2020-10-23 22:40:34.852612	2020-10-23 22:40:34.852612
4980	2	9	48	2	\N	2018-10-25	-10.00	76dc611d6ebaafc66cc0879c71b5db5c	2020-10-23 22:40:34.854258	2020-10-23 22:40:34.854258
4981	5	4	16	2	\N	2018-10-26	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:40:34.855578	2020-10-23 22:40:34.855578
4982	2	9	-1	2	\N	2018-10-26	-6.40	9188905e74c28e489b44e954ec0b9bca	2020-10-23 22:40:34.857006	2020-10-23 22:40:34.857006
4983	1	3	-1	2	\N	2018-10-27	-24.00	e9b1ad953dcf5fd357195adadc014066	2020-10-23 22:40:34.858406	2020-10-23 22:40:34.858406
4984	1	3	-1	2	\N	2018-10-25	-18.00	03c67da1cd19e9c82e8373fb3bf0f476	2020-10-23 22:40:34.85975	2020-10-23 22:40:34.85975
4985	1	1	-1	2	\N	2018-10-26	-13.83	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:34.861095	2020-10-23 22:40:34.861095
4986	1	5	23	2	\N	2018-10-26	-12.00	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.862376	2020-10-23 22:40:34.862376
4987	5	8	41	2	\N	2018-10-27	-34.24	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:34.863697	2020-10-23 22:40:34.863697
4988	1	5	23	2	\N	2018-10-27	-59.15	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.864907	2020-10-23 22:40:34.864907
4989	1	10	54	3	\N	2018-10-27	-900.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:34.86628	2020-10-23 22:40:34.86628
4990	1	10	54	3	\N	2018-10-27	-500.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:34.867869	2020-10-23 22:40:34.867869
4991	1	9	48	2	\N	2018-10-25	-10.00	5dd9db5e033da9c6fb5ba83c7a7ebea9	2020-10-23 22:40:34.869249	2020-10-23 22:40:34.869249
4992	1	2	3	1	\N	2018-10-25	10045.59	fd24cef72637843f3ed7d1a80765c341	2020-10-23 22:40:34.870392	2020-10-23 22:40:34.870392
4993	1	9	-1	2	\N	2018-10-26	-10.00	f87be31a72bb8a8c23a86d9a6c80658a	2020-10-23 22:40:34.871745	2020-10-23 22:40:34.871745
4994	1	1	-1	2	\N	2018-10-25	-19.80	164f17b765d4a3a9e1ec40c52861b94d	2020-10-23 22:40:34.872972	2020-10-23 22:40:34.872972
4995	1	5	23	2	\N	2018-10-28	-73.99	7b40ea13ae416cb92d3169cc0112a348	2020-10-23 22:40:34.87424	2020-10-23 22:40:34.87424
4996	5	1	-1	2	\N	2018-10-28	-205.84	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.876014	2020-10-23 22:40:34.876014
4997	5	1	-1	2	\N	2018-10-28	-17.34	6b9abf067124bb08d034e3fdad22d0fa	2020-10-23 22:40:34.877237	2020-10-23 22:40:34.877237
4998	5	1	-1	2	\N	2018-10-27	-24.29	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:34.878891	2020-10-23 22:40:34.878891
4999	5	1	-1	2	\N	2018-10-27	-3.78	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:34.880317	2020-10-23 22:40:34.880317
5000	5	1	-1	2	\N	2018-10-27	-14.20	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:34.881535	2020-10-23 22:40:34.881535
5001	5	1	-1	2	\N	2018-10-27	-8.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.882894	2020-10-23 22:40:34.882894
5002	5	3	-1	2	\N	2018-10-26	-22.18	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:34.884314	2020-10-23 22:40:34.884314
5003	5	1	-1	2	\N	2018-10-26	-62.32	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:34.885509	2020-10-23 22:40:34.885509
5004	2	10	54	3	\N	2018-10-26	-1000.00	342e8c42dd599e79ce7b7f2e808661f7	2020-10-23 22:40:34.887151	2020-10-23 22:40:34.887151
5005	5	10	54	4	\N	2018-10-26	1000.00	342e8c42dd599e79ce7b7f2e808661f7	2020-10-23 22:40:34.888543	2020-10-23 22:40:34.888543
5006	5	1	-1	2	\N	2018-10-24	-12.06	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.889668	2020-10-23 22:40:34.889668
5007	5	5	23	2	\N	2018-10-24	-1.90	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.891026	2020-10-23 22:40:34.891026
5008	5	5	23	2	\N	2018-10-24	-109.40	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.892626	2020-10-23 22:40:34.892626
5009	5	1	-1	2	\N	2018-10-24	-11.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.893892	2020-10-23 22:40:34.893892
5010	5	1	-1	2	\N	2018-10-24	-2.49	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.895214	2020-10-23 22:40:34.895214
5011	5	1	-1	2	\N	2018-10-23	-27.51	29e3eb16bfdd864d811e6587f8c297a7	2020-10-23 22:40:34.896535	2020-10-23 22:40:34.896535
5012	5	7	36	2	\N	2018-10-23	-72.79	6008683015da4d3c1ce22105cc707371	2020-10-23 22:40:34.897681	2020-10-23 22:40:34.897681
5013	5	5	23	2	\N	2018-10-23	-46.98	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.899033	2020-10-23 22:40:34.899033
5014	5	1	-1	2	\N	2018-10-23	-3.40	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.900447	2020-10-23 22:40:34.900447
5015	1	1	-1	2	\N	2018-10-22	-8.45	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.901662	2020-10-23 22:40:34.901662
5016	1	9	51	2	\N	2018-10-28	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:34.903108	2020-10-23 22:40:34.903108
5017	1	10	54	3	\N	2018-10-28	-300.00	68053af2923e00204c3ca7c6a3150cf7	2020-10-23 22:40:34.904491	2020-10-23 22:40:34.904491
5018	1	9	-1	3	\N	2018-10-28	-1000.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:34.906046	2020-10-23 22:40:34.906046
5019	1	10	54	3	\N	2018-11-01	-7000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:34.907303	2020-10-23 22:40:34.907303
5020	2	9	48	2	\N	2018-10-28	-19.99	342cecdc051a8edfd09ff5bf429a4704	2020-10-23 22:40:34.90861	2020-10-23 22:40:34.90861
5021	2	2	3	1	\N	2018-10-29	5762.43	002aa8019f6b6221b7562c35d54f116c	2020-10-23 22:40:34.909964	2020-10-23 22:40:34.909964
5022	2	10	54	3	\N	2018-10-30	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.911193	2020-10-23 22:40:34.911193
5023	4	10	54	4	\N	2018-10-30	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.912321	2020-10-23 22:40:34.912321
5024	2	10	54	3	\N	2018-10-30	-3000.00	352407221afb776e3143e8a1a0577885	2020-10-23 22:40:34.913614	2020-10-23 22:40:34.913614
5025	5	10	54	4	\N	2018-10-30	3000.00	352407221afb776e3143e8a1a0577885	2020-10-23 22:40:34.914713	2020-10-23 22:40:34.914713
5026	5	4	13	2	\N	2018-10-30	-404.88	13156e347b1734f38db62eea70f7b0a5	2020-10-23 22:40:34.91591	2020-10-23 22:40:34.91591
5027	5	8	43	2	\N	2018-10-30	-227.75	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:34.917104	2020-10-23 22:40:34.917104
5028	5	4	15	2	\N	2018-10-31	-125.80	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:34.918225	2020-10-23 22:40:34.918225
5029	5	4	14	2	\N	2018-10-31	-125.06	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:34.91946	2020-10-23 22:40:34.91946
5030	5	7	33	3	\N	2018-10-31	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.920521	2020-10-23 22:40:34.920521
5031	1	2	-1	4	\N	2018-10-31	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:34.921728	2020-10-23 22:40:34.921728
5032	6	10	55	1	\N	2018-10-31	78.08	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:34.922814	2020-10-23 22:40:34.922814
5033	5	9	-1	2	\N	2018-11-01	-312.16	a7f24560dc76362cc97a872d0fff59db	2020-10-23 22:40:34.924325	2020-10-23 22:40:34.924325
5034	1	9	-1	2	\N	2018-11-01	-16.80	cf5cf20f2545b642ad00c2d507a04c94	2020-10-23 22:40:34.925561	2020-10-23 22:40:34.925561
5035	5	8	43	2	\N	2018-11-02	0.00	82b5f6802b727b0d948d38cbccd48904	2020-10-23 22:40:34.926889	2020-10-23 22:40:34.926889
5036	1	8	40	2	\N	2018-11-02	0.00	c5eb593003c43c2a2325b0bda3956ac0	2020-10-23 22:40:34.927908	2020-10-23 22:40:34.927908
5037	5	3	-1	2	\N	2018-11-02	-8.98	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:34.929064	2020-10-23 22:40:34.929064
5038	5	1	-1	2	\N	2018-11-03	-269.47	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.930399	2020-10-23 22:40:34.930399
5039	5	1	-1	2	\N	2018-11-03	-34.44	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:40:34.931598	2020-10-23 22:40:34.931598
5040	2	6	27	2	\N	2018-11-03	-139.97	9f65a84d84fb42109c54b47384a437d8	2020-10-23 22:40:34.932831	2020-10-23 22:40:34.932831
5041	2	9	48	2	\N	2018-11-03	-75.88	3bf7ffb8a26efc093a9bbf5eb88b982e	2020-10-23 22:40:34.933984	2020-10-23 22:40:34.933984
5042	2	9	48	2	\N	2018-11-03	-209.50	d87538ecdd64b81881f810e945c0efa2	2020-10-23 22:40:34.935124	2020-10-23 22:40:34.935124
5043	2	1	-1	2	\N	2018-11-03	-28.97	8a4b5cefd83b9f9d2a9c82fb10fd8ee6	2020-10-23 22:40:34.936245	2020-10-23 22:40:34.936245
5044	5	9	48	2	\N	2018-11-02	-29.70	62a0e3d0e8d9db40e64419904a137c32	2020-10-23 22:40:34.937388	2020-10-23 22:40:34.937388
5045	5	1	-1	2	\N	2018-11-02	-11.90	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:34.938596	2020-10-23 22:40:34.938596
5046	2	9	51	2	\N	2018-11-02	-100.00	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:40:34.939747	2020-10-23 22:40:34.939747
5047	5	1	-1	2	\N	2018-11-07	-7.41	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.940931	2020-10-23 22:40:34.940931
5048	5	9	53	4	\N	2018-11-05	5400.00	4c56ff4ce4aaf9573aa5dff913df997a	2020-10-23 22:40:34.942809	2020-10-23 22:40:34.942809
5049	5	9	53	3	\N	2018-11-07	-2500.00	4c56ff4ce4aaf9573aa5dff913df997a	2020-10-23 22:40:34.94428	2020-10-23 22:40:34.94428
5050	1	6	29	2	\N	2018-11-08	-20.00	2671eb6e9150cf9b53eb39752a1fb21c	2020-10-23 22:40:34.945448	2020-10-23 22:40:34.945448
5051	5	1	-1	2	\N	2018-11-08	-16.75	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.946639	2020-10-23 22:40:34.946639
5052	5	1	-1	2	\N	2018-11-08	-10.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.947742	2020-10-23 22:40:34.947742
5053	2	4	16	2	\N	2018-11-09	-29.99	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:34.948906	2020-10-23 22:40:34.948906
5054	2	4	18	2	\N	2018-11-09	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:34.950122	2020-10-23 22:40:34.950122
5055	5	1	-1	2	\N	2018-11-09	-188.35	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.951266	2020-10-23 22:40:34.951266
5056	5	3	-1	2	\N	2018-11-09	-19.99	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:34.952562	2020-10-23 22:40:34.952562
5057	5	9	53	4	\N	2018-11-10	2500.00	b7892fb3c2f009c65f686f6355c895b5	2020-10-23 22:40:34.95374	2020-10-23 22:40:34.95374
5058	5	1	-1	2	\N	2018-11-10	-8.48	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:34.95477	2020-10-23 22:40:34.95477
5059	5	1	-1	2	\N	2018-11-10	-2.95	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.956005	2020-10-23 22:40:34.956005
5060	5	9	36	2	\N	2018-11-13	-116.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.957174	2020-10-23 22:40:34.957174
5061	2	1	-1	2	\N	2018-11-07	-12.60	06ca655e1cff36fe062f783aa99f7c34	2020-10-23 22:40:34.958273	2020-10-23 22:40:34.958273
5062	5	1	-1	2	\N	2018-11-14	-10.17	7d06a9cf10f2e9e47e77d6c6cfaa7f54	2020-10-23 22:40:34.95967	2020-10-23 22:40:34.95967
5063	1	1	-1	2	\N	2018-11-15	-23.50	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:34.96106	2020-10-23 22:40:34.96106
5064	5	1	-1	2	\N	2018-11-13	-5.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.962497	2020-10-23 22:40:34.962497
5065	5	5	23	2	\N	2018-11-13	-32.55	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:34.963745	2020-10-23 22:40:34.963745
5066	5	1	-1	2	\N	2018-11-16	-13.77	3619cb5bf1ba5b8f0523230ca3f4f148	2020-10-23 22:40:34.964867	2020-10-23 22:40:34.964867
5067	5	1	-1	2	\N	2018-11-16	-13.60	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.966107	2020-10-23 22:40:34.966107
5068	1	1	-1	2	\N	2018-11-16	-16.50	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:34.967233	2020-10-23 22:40:34.967233
5069	5	3	-1	2	\N	2018-11-16	-46.44	8cb22bdd0b7ba1ab13d742e22eed8da2	2020-10-23 22:40:34.96839	2020-10-23 22:40:34.96839
5070	5	1	-1	2	\N	2018-11-16	-133.85	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:34.969605	2020-10-23 22:40:34.969605
5071	5	1	-1	2	\N	2018-11-16	-27.90	d7b85f12bdf36266db695411a654f73f	2020-10-23 22:40:34.970711	2020-10-23 22:40:34.970711
5072	5	5	26	2	\N	2018-11-20	-87.40	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:40:34.971911	2020-10-23 22:40:34.971911
5073	2	6	27	1	\N	2018-11-21	59.99	6a765ac3b5a3cb073b95357dc8f4fd87	2020-10-23 22:40:34.973032	2020-10-23 22:40:34.973032
5074	2	9	48	2	\N	2018-11-22	-300.00	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:40:34.974467	2020-10-23 22:40:34.974467
5075	5	1	-1	2	\N	2018-11-20	-18.56	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:34.975956	2020-10-23 22:40:34.975956
5076	5	1	-1	2	\N	2018-11-20	-10.14	2029d9e809d823d9997727800b7b5b90	2020-10-23 22:40:34.977115	2020-10-23 22:40:34.977115
5077	5	2	-1	1	\N	2018-11-10	1207.92	1385974ed5904a438616ff7bdb3f7439	2020-10-23 22:40:34.978389	2020-10-23 22:40:34.978389
5078	5	1	-1	2	\N	2018-11-12	-12.30	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:40:34.9794	2020-10-23 22:40:34.9794
5079	2	7	35	2	\N	2018-11-23	-9.95	fac79668dfbfbe6295cfe751f7170da2	2020-10-23 22:40:34.980573	2020-10-23 22:40:34.980573
5080	5	9	48	2	\N	2018-11-23	-25.00	93dd4de5cddba2c733c65f233097f05a	2020-10-23 22:40:34.981691	2020-10-23 22:40:34.981691
5081	5	4	16	2	\N	2018-11-23	-49.90	7c6e445ae7306a3f1566a5131d5f2ea7	2020-10-23 22:40:34.982954	2020-10-23 22:40:34.982954
5082	5	1	-1	2	\N	2018-11-23	-197.71	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:34.984207	2020-10-23 22:40:34.984207
5083	5	1	-1	2	\N	2018-11-24	-14.15	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:34.985241	2020-10-23 22:40:34.985241
5084	5	1	-1	2	\N	2018-11-25	-29.27	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:34.986432	2020-10-23 22:40:34.986432
5085	6	10	54	3	\N	2018-11-27	-15000.00	4e0cb6fb5fb446d1c92ede2ed8780188	2020-10-23 22:40:34.987453	2020-10-23 22:40:34.987453
5086	5	10	54	4	\N	2018-11-27	15000.00	4e0cb6fb5fb446d1c92ede2ed8780188	2020-10-23 22:40:34.988598	2020-10-23 22:40:34.988598
5087	5	1	-1	2	\N	2018-11-27	-10.14	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:34.989665	2020-10-23 22:40:34.989665
5088	1	2	3	1	\N	2018-11-26	11118.76	5db3daef1ac645ecefb7c7707f50cccb	2020-10-23 22:40:34.99086	2020-10-23 22:40:34.99086
5089	2	2	3	1	\N	2018-11-27	8869.03	ab0eefe4e22456520006f254adf1947a	2020-10-23 22:40:34.992029	2020-10-23 22:40:34.992029
5090	2	10	54	3	\N	2018-11-28	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.993282	2020-10-23 22:40:34.993282
5091	4	10	54	4	\N	2018-11-28	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:34.994519	2020-10-23 22:40:34.994519
5092	2	10	54	3	\N	2018-11-28	-6500.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:40:34.99557	2020-10-23 22:40:34.99557
5093	5	10	54	4	\N	2018-11-28	6500.00	295219768a27fb6ddedce5a526ababf2	2020-10-23 22:40:34.996767	2020-10-23 22:40:34.996767
5094	5	4	13	2	\N	2018-11-28	-404.88	d7b24e66a3c4ea77a4a224995bc3899a	2020-10-23 22:40:34.997769	2020-10-23 22:40:34.997769
5095	5	4	15	2	\N	2018-11-28	-125.80	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:34.999102	2020-10-23 22:40:34.999102
5096	5	4	14	2	\N	2018-11-28	-105.39	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:35.000478	2020-10-23 22:40:35.000478
5097	2	4	16	2	\N	2018-11-28	-35.98	6a8addeb940cd48f8177c44d5991650e	2020-10-23 22:40:35.00157	2020-10-23 22:40:35.00157
5098	5	1	-1	2	\N	2018-11-28	-7.93	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.002787	2020-10-23 22:40:35.002787
5099	5	7	33	3	\N	2018-11-30	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.003753	2020-10-23 22:40:35.003753
5100	1	7	33	4	\N	2018-11-30	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.004895	2020-10-23 22:40:35.004895
5101	5	9	48	2	\N	2018-12-01	-108.90	78d668fb65e0abe98e8bef0f67437b1b	2020-10-23 22:40:35.006056	2020-10-23 22:40:35.006056
5102	5	5	23	2	\N	2018-12-01	-13.00	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.007196	2020-10-23 22:40:35.007196
5103	5	1	-1	2	\N	2018-11-30	-286.47	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.0085	2020-10-23 22:40:35.0085
5104	5	1	-1	2	\N	2018-12-01	-11.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.009742	2020-10-23 22:40:35.009742
5105	6	10	55	1	\N	2018-11-30	25.25	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:35.010843	2020-10-23 22:40:35.010843
5106	1	10	54	3	\N	2018-12-01	-500.00	13e1ad0d81448c812a189ed10681c98f	2020-10-23 22:40:35.012097	2020-10-23 22:40:35.012097
5107	1	10	54	3	\N	2018-12-01	-200.00	343d9040a671c45832ee5381860e2996	2020-10-23 22:40:35.013702	2020-10-23 22:40:35.013702
5108	1	10	54	3	\N	2018-12-01	-7000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.014807	2020-10-23 22:40:35.014807
5109	1	10	54	3	\N	2018-12-01	-1000.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:35.015967	2020-10-23 22:40:35.015967
5110	1	9	48	2	\N	2018-11-30	-129.99	8c0988bbc8bb3023dc5c926a3a5b789d	2020-10-23 22:40:35.01713	2020-10-23 22:40:35.01713
5111	5	2	-1	1	\N	2018-11-30	129.99	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.018269	2020-10-23 22:40:35.018269
5112	1	9	-1	3	\N	2018-12-01	-797.50	704a9613f075f9dafff1a0146b76558e	2020-10-23 22:40:35.019566	2020-10-23 22:40:35.019566
5113	1	10	54	3	\N	2018-12-01	-1471.10	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:35.020628	2020-10-23 22:40:35.020628
5114	6	10	54	4	\N	2018-12-01	3000.00	8867f73c679c214f8e5e88c67c7baae9	2020-10-23 22:40:35.021761	2020-10-23 22:40:35.021761
5115	6	10	54	4	\N	2018-12-01	4000.00	8867f73c679c214f8e5e88c67c7baae9	2020-10-23 22:40:35.022901	2020-10-23 22:40:35.022901
5116	5	2	-1	1	\N	2018-12-01	59.99	b14ae6a176b177a2b84eff85b65d558f	2020-10-23 22:40:35.024053	2020-10-23 22:40:35.024053
5117	5	9	49	2	\N	2018-12-01	-230.08	87c7d2a22550d476eb4ee56e8f88acff	2020-10-23 22:40:35.025511	2020-10-23 22:40:35.025511
5118	5	9	48	2	\N	2018-12-01	-98.26	5dbc295d04f3c435382da0c7b0432233	2020-10-23 22:40:35.026974	2020-10-23 22:40:35.026974
5119	2	9	48	2	\N	2018-12-02	-141.40	0f840be9b8db4d3fbd5ba2ce59211f55	2020-10-23 22:40:35.02818	2020-10-23 22:40:35.02818
5120	5	1	-1	2	\N	2018-12-02	-20.54	6d3b48096eae8b0bf540149207bd0f67	2020-10-23 22:40:35.029255	2020-10-23 22:40:35.029255
5121	2	10	54	3	\N	2018-12-03	-1500.00	8a4fe2eac821cc07db049f1279357195	2020-10-23 22:40:35.030471	2020-10-23 22:40:35.030471
5122	5	8	43	2	\N	2018-12-03	-238.15	30d69ba3457fbe63ddf07f88adbca502	2020-10-23 22:40:35.0315	2020-10-23 22:40:35.0315
5123	2	5	25	2	\N	2018-12-03	-45.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:35.032664	2020-10-23 22:40:35.032664
5124	2	1	-1	2	\N	2018-12-05	-14.74	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:35.033717	2020-10-23 22:40:35.033717
5125	2	9	48	2	\N	2018-12-05	-58.19	9d88dbeb65c8d336c3e5b69977f359bc	2020-10-23 22:40:35.03498	2020-10-23 22:40:35.03498
5126	1	9	50	2	\N	2018-12-02	-11.00	1700002963a49da13542e0726b7bb758	2020-10-23 22:40:35.036133	2020-10-23 22:40:35.036133
5127	5	9	47	2	\N	2018-12-03	-40.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:40:35.037272	2020-10-23 22:40:35.037272
5128	1	9	47	1	\N	2018-12-03	40.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:40:35.03851	2020-10-23 22:40:35.03851
5129	1	9	-1	2	\N	2018-12-03	-20.00	4b6538a44a1dfdc2b83477cd76dee98e	2020-10-23 22:40:35.039554	2020-10-23 22:40:35.039554
5130	1	9	53	3	\N	2018-12-07	-40.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.040684	2020-10-23 22:40:35.040684
5131	5	2	-1	4	\N	2018-12-07	40.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.041856	2020-10-23 22:40:35.041856
5132	5	2	-1	4	\N	2018-12-05	5400.00	839a4b111f06594f5e680091208cbf87	2020-10-23 22:40:35.043172	2020-10-23 22:40:35.043172
5133	5	9	53	3	\N	2018-12-07	-2500.00	839a4b111f06594f5e680091208cbf87	2020-10-23 22:40:35.044255	2020-10-23 22:40:35.044255
5134	5	1	-1	2	\N	2018-12-05	-11.34	52720e003547c70561bf5e03b95aa99f	2020-10-23 22:40:35.045487	2020-10-23 22:40:35.045487
5135	5	1	-1	2	\N	2018-12-05	-45.47	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:35.046572	2020-10-23 22:40:35.046572
5136	5	9	48	2	\N	2018-12-03	-29.85	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:40:35.047712	2020-10-23 22:40:35.047712
5137	5	9	53	3	\N	2018-12-07	-65.00	e96ed478dab8595a7dbda4cbcbee168f	2020-10-23 22:40:35.04876	2020-10-23 22:40:35.04876
5138	1	2	-1	4	\N	2018-12-07	65.00	e96ed478dab8595a7dbda4cbcbee168f	2020-10-23 22:40:35.049957	2020-10-23 22:40:35.049957
5139	1	8	41	2	\N	2018-12-07	-37.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:35.051197	2020-10-23 22:40:35.051197
5140	1	9	53	3	\N	2018-12-07	-27.00	b3e2026d10e46df62f0d1cdfa85d7aaa	2020-10-23 22:40:35.052353	2020-10-23 22:40:35.052353
5141	5	1	-1	2	\N	2018-12-07	-146.11	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:35.054138	2020-10-23 22:40:35.054138
5142	5	1	-1	2	\N	2018-12-07	-8.40	be83ab3ecd0db773eb2dc1b0a17836a1	2020-10-23 22:40:35.05563	2020-10-23 22:40:35.05563
5143	5	1	-1	2	\N	2018-12-07	-27.28	34ec78fcc91ffb1e54cd85e4a0924332	2020-10-23 22:40:35.05717	2020-10-23 22:40:35.05717
5144	5	1	-1	2	\N	2018-12-07	-9.90	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.058527	2020-10-23 22:40:35.058527
5145	2	9	48	2	\N	2018-12-08	-43.00	a9a6653e48976138166de32772b1bf40	2020-10-23 22:40:35.060405	2020-10-23 22:40:35.060405
5146	2	1	-1	2	\N	2018-12-08	-43.00	b85f7d33e1fffff32a44294cd546ed99	2020-10-23 22:40:35.062161	2020-10-23 22:40:35.062161
5147	5	9	48	2	\N	2018-12-08	-5.99	d95131849da9c75adf0d324b63972160	2020-10-23 22:40:35.063411	2020-10-23 22:40:35.063411
5148	2	9	48	2	\N	2018-12-08	-80.42	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:35.064774	2020-10-23 22:40:35.064774
5149	2	1	-1	2	\N	2018-12-08	-16.60	75e35fd9fcd6051376d77b9251c846f1	2020-10-23 22:40:35.066102	2020-10-23 22:40:35.066102
5150	2	4	18	2	\N	2018-12-08	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:35.067287	2020-10-23 22:40:35.067287
5151	2	1	-1	2	\N	2018-12-08	-14.74	57bbcb50322f47702de79937c482ba20	2020-10-23 22:40:35.068525	2020-10-23 22:40:35.068525
5152	5	9	48	3	\N	2018-12-08	-100.00	4b6538a44a1dfdc2b83477cd76dee98e	2020-10-23 22:40:35.070017	2020-10-23 22:40:35.070017
5153	2	9	48	4	\N	2018-12-08	100.00	4b6538a44a1dfdc2b83477cd76dee98e	2020-10-23 22:40:35.071443	2020-10-23 22:40:35.071443
5154	2	1	-1	2	\N	2018-12-09	-11.00	89d6846a7c3e6cbac0e0f42264450ba7	2020-10-23 22:40:35.072712	2020-10-23 22:40:35.072712
5155	5	9	48	2	\N	2018-12-10	-87.06	d87538ecdd64b81881f810e945c0efa2	2020-10-23 22:40:35.07384	2020-10-23 22:40:35.07384
5156	2	9	48	2	\N	2018-12-11	-70.00	d87538ecdd64b81881f810e945c0efa2	2020-10-23 22:40:35.075403	2020-10-23 22:40:35.075403
5157	2	9	48	2	\N	2018-12-12	-10.00	6e71165340db6e2b495a192b4895941e	2020-10-23 22:40:35.076907	2020-10-23 22:40:35.076907
5158	5	1	-1	2	\N	2018-12-11	-7.19	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:35.078598	2020-10-23 22:40:35.078598
5159	1	9	51	2	\N	2018-12-11	-20.00	30a38e2b3db8e0cd68c5eaef1a7edbe4	2020-10-23 22:40:35.07992	2020-10-23 22:40:35.07992
5160	5	2	-1	1	\N	2018-12-10	2500.00	70388fdec0a374fa35108c1f480f81a0	2020-10-23 22:40:35.081138	2020-10-23 22:40:35.081138
5161	2	9	51	2	\N	2018-12-13	-10.00	c8fbbe3ab0d6d8839244383ae4887a0d	2020-10-23 22:40:35.082421	2020-10-23 22:40:35.082421
5162	5	1	-1	2	\N	2018-12-13	-7.20	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.083685	2020-10-23 22:40:35.083685
5163	5	1	-1	2	\N	2018-12-14	-105.27	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.084874	2020-10-23 22:40:35.084874
5164	5	1	-1	2	\N	2018-12-14	-8.94	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:35.086198	2020-10-23 22:40:35.086198
5165	5	1	-1	2	\N	2018-12-14	-5.25	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:35.087389	2020-10-23 22:40:35.087389
5166	5	1	-1	2	\N	2018-12-15	-9.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.088642	2020-10-23 22:40:35.088642
5167	5	1	-1	2	\N	2018-12-15	-193.65	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.090309	2020-10-23 22:40:35.090309
5168	5	1	-1	2	\N	2018-12-18	-1.20	5e3002b1b5b6ce9e1ba962e4cde4b2de	2020-10-23 22:40:35.091425	2020-10-23 22:40:35.091425
5169	5	1	-1	2	\N	2018-12-18	-7.96	92daa86ad43a42f28f4bf58e94667c95	2020-10-23 22:40:35.092868	2020-10-23 22:40:35.092868
5170	5	1	-1	2	\N	2018-12-18	-15.50	4e66fcc4f4639dc0144c27973a54bf83	2020-10-23 22:40:35.0942	2020-10-23 22:40:35.0942
5171	5	1	-1	2	\N	2018-12-18	-10.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.095454	2020-10-23 22:40:35.095454
5172	5	5	23	2	\N	2018-12-18	-123.08	88ff3c5e7abe5c365fc714330a475618	2020-10-23 22:40:35.096738	2020-10-23 22:40:35.096738
5173	5	9	48	2	\N	2018-12-19	-35.00	189e7a7077ee39d86cf5da33816fd51d	2020-10-23 22:40:35.097828	2020-10-23 22:40:35.097828
5174	5	9	48	2	\N	2018-12-19	-22.90	048b821311c9daae12c9918632dd2838	2020-10-23 22:40:35.099219	2020-10-23 22:40:35.099219
5175	5	9	48	2	\N	2018-12-19	-30.49	b1989c4122c8d81819985e5b05567a91	2020-10-23 22:40:35.100738	2020-10-23 22:40:35.100738
5176	1	2	-1	4	\N	2018-12-17	324.17	e7360c0525d1e355aceb1174cb591015	2020-10-23 22:40:35.101891	2020-10-23 22:40:35.101891
5177	1	9	50	2	\N	2018-12-17	-7.50	4558dbb6f6f8bb2e16d03b85bde76e2c	2020-10-23 22:40:35.103429	2020-10-23 22:40:35.103429
5178	1	9	53	3	\N	2018-12-17	-300.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:35.104629	2020-10-23 22:40:35.104629
5179	5	1	-1	2	\N	2018-12-15	-0.99	2956ef6ebf5067ab2dad19052ca0c6b2	2020-10-23 22:40:35.10595	2020-10-23 22:40:35.10595
5180	5	9	48	2	\N	2018-12-17	-27.00	15d4e891d784977cacbfcbb00c48f133	2020-10-23 22:40:35.107391	2020-10-23 22:40:35.107391
5181	5	9	48	2	\N	2018-12-16	-24.98	9f06f2538cdbb40bce9973f60506de09	2020-10-23 22:40:35.108859	2020-10-23 22:40:35.108859
5182	5	1	-1	2	\N	2018-12-13	-2.20	2956ef6ebf5067ab2dad19052ca0c6b2	2020-10-23 22:40:35.110276	2020-10-23 22:40:35.110276
5183	5	5	25	2	\N	2018-12-14	-25.00	2cb98cf87a1ea7d68097499de4c25d84	2020-10-23 22:40:35.111336	2020-10-23 22:40:35.111336
5184	5	1	-1	2	\N	2018-12-20	-6.79	72c99f8ceac6fefe190e9df14bc38973	2020-10-23 22:40:35.112723	2020-10-23 22:40:35.112723
5185	5	9	48	3	\N	2018-12-21	-1000.00	0cd8d72c71dab14441b7fb8e7db5212d	2020-10-23 22:40:35.114533	2020-10-23 22:40:35.114533
5186	1	2	3	4	\N	2018-12-21	10745.14	362842296f8c3370c748838bccf5e9c6	2020-10-23 22:40:35.115627	2020-10-23 22:40:35.115627
5187	1	9	51	2	\N	2018-12-23	-100.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:35.116676	2020-10-23 22:40:35.116676
5188	5	9	-1	2	\N	2018-12-22	-33.50	f828edc20051679939b205229f41e729	2020-10-23 22:40:35.117698	2020-10-23 22:40:35.117698
5189	5	9	48	2	\N	2018-12-22	-154.92	82901154ea5372edea77506d467aa449	2020-10-23 22:40:35.118779	2020-10-23 22:40:35.118779
5190	2	4	16	2	\N	2018-12-25	-35.98	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:35.119759	2020-10-23 22:40:35.119759
5191	1	10	54	3	\N	2018-12-27	-100.00	23b66dd4d9be6bba639bc882f30f5475	2020-10-23 22:40:35.120821	2020-10-23 22:40:35.120821
5192	1	10	54	3	\N	2018-12-27	-1000.00	bafd5a4703b299183010a4a961234483	2020-10-23 22:40:35.121837	2020-10-23 22:40:35.121837
5193	1	10	54	3	\N	2018-12-27	-1500.00	1816533e898f2ead4768e0aaae739883	2020-10-23 22:40:35.122831	2020-10-23 22:40:35.122831
5194	5	7	33	3	\N	2018-12-27	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.123874	2020-10-23 22:40:35.123874
5195	1	2	-1	4	\N	2018-12-27	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.125021	2020-10-23 22:40:35.125021
5196	5	10	54	3	\N	2018-12-27	-2760.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:35.126507	2020-10-23 22:40:35.126507
5197	6	10	54	4	\N	2018-12-27	2760.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:35.127682	2020-10-23 22:40:35.127682
5198	5	8	43	2	\N	2018-12-28	-210.39	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:35.128818	2020-10-23 22:40:35.128818
5199	5	1	-1	2	\N	2018-12-28	-47.13	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:35.129945	2020-10-23 22:40:35.129945
5200	1	2	-1	1	\N	2018-12-28	50.00	e820a45f1dfc7b95282d10b6087e11c0	2020-10-23 22:40:35.131198	2020-10-23 22:40:35.131198
5201	1	2	-1	1	\N	2018-12-28	24.75	e820a45f1dfc7b95282d10b6087e11c0	2020-10-23 22:40:35.132491	2020-10-23 22:40:35.132491
5202	5	7	31	2	\N	2018-12-29	-59.80	4a974c8c32469a4a0901b7059421806d	2020-10-23 22:40:35.133674	2020-10-23 22:40:35.133674
5203	1	2	-1	4	\N	2018-12-31	80.00	b1989c4122c8d81819985e5b05567a91	2020-10-23 22:40:35.134835	2020-10-23 22:40:35.134835
5204	5	2	-1	4	\N	2018-12-31	400.00	192fc044e74dffea144f9ac5dc9f3395	2020-10-23 22:40:35.135813	2020-10-23 22:40:35.135813
5205	5	1	-1	2	\N	2018-12-31	-104.22	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.136788	2020-10-23 22:40:35.136788
5206	5	1	-1	2	\N	2018-12-31	-3.58	43828c66e9f47ea1c35dba2d2a92e969	2020-10-23 22:40:35.13776	2020-10-23 22:40:35.13776
5207	5	5	23	2	\N	2018-12-31	-12.99	cbcb58ac2e496207586df2854b17995f	2020-10-23 22:40:35.139041	2020-10-23 22:40:35.139041
5208	5	1	-1	2	\N	2018-12-31	-12.40	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.140482	2020-10-23 22:40:35.140482
5209	2	2	3	1	\N	2018-12-31	6331.10	0706dfd8b8609ec0635c4369b59d699f	2020-10-23 22:40:35.141634	2020-10-23 22:40:35.141634
5210	2	10	54	3	\N	2018-12-31	-4000.00	c64e8971b113555fbcbb72508a29c7c3	2020-10-23 22:40:35.143008	2020-10-23 22:40:35.143008
5211	5	10	54	4	\N	2018-12-31	4000.00	c64e8971b113555fbcbb72508a29c7c3	2020-10-23 22:40:35.144686	2020-10-23 22:40:35.144686
5212	5	4	13	2	\N	2018-12-31	-404.88	d7b24e66a3c4ea77a4a224995bc3899a	2020-10-23 22:40:35.145914	2020-10-23 22:40:35.145914
5213	5	4	15	2	\N	2018-12-31	-125.80	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:35.146967	2020-10-23 22:40:35.146967
5214	2	9	-1	4	\N	2018-12-31	20.08	43303daa5f60d99c1728b9a4fbc0aa57	2020-10-23 22:40:35.148448	2020-10-23 22:40:35.148448
5215	5	9	-1	2	\N	2018-12-31	-28.85	3916b3b51b8b4a0a97f12aa77ff25d89	2020-10-23 22:40:35.149559	2020-10-23 22:40:35.149559
5216	6	10	55	1	\N	2018-12-31	19.11	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:35.150767	2020-10-23 22:40:35.150767
5217	1	9	53	3	\N	2019-01-01	-7000.00	73419b6a9d656901a23c97c3eb85ff7b	2020-10-23 22:40:35.152002	2020-10-23 22:40:35.152002
5218	1	7	35	2	\N	2019-01-01	-55.00	70ef895d62319987fc8a0b52f7f7180d	2020-10-23 22:40:35.153157	2020-10-23 22:40:35.153157
5219	1	7	35	2	\N	2019-01-01	-120.00	7b13b2203029ed80337f27127a9f1d28	2020-10-23 22:40:35.154608	2020-10-23 22:40:35.154608
5220	1	9	53	3	\N	2019-01-01	-750.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:35.155638	2020-10-23 22:40:35.155638
5221	1	9	53	3	\N	2019-01-01	-162.55	452d9d2ddc00d8762d5b580c0aaee5c9	2020-10-23 22:40:35.156814	2020-10-23 22:40:35.156814
5222	1	8	41	2	\N	2019-01-01	-37.00	1ff8064e274d0ba812d61379d97a2f4c	2020-10-23 22:40:35.157872	2020-10-23 22:40:35.157872
5223	1	9	49	2	\N	2019-01-01	-107.01	fb8490a9504a36c212b5a1be7b4ca7e4	2020-10-23 22:40:35.15903	2020-10-23 22:40:35.15903
5224	5	5	23	2	\N	2019-01-03	-61.60	e9a34dc534ac1ffc6d2367c17bc69d29	2020-10-23 22:40:35.160476	2020-10-23 22:40:35.160476
5225	5	10	54	4	\N	2019-01-04	5400.00	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:35.161601	2020-10-23 22:40:35.161601
5226	5	7	30	2	\N	2019-01-04	-150.00	988549da24fb1ad68244445496c80b52	2020-10-23 22:40:35.162672	2020-10-23 22:40:35.162672
5227	2	7	30	1	\N	2019-01-04	150.00	988549da24fb1ad68244445496c80b52	2020-10-23 22:40:35.163757	2020-10-23 22:40:35.163757
5228	1	2	-1	1	\N	2019-01-05	24.75	52720e003547c70561bf5e03b95aa99f	2020-10-23 22:40:35.164908	2020-10-23 22:40:35.164908
5229	5	1	-1	2	\N	2019-01-05	-17.36	d9cd488a4b1da83f8bf027474788f679	2020-10-23 22:40:35.166231	2020-10-23 22:40:35.166231
5230	5	1	-1	2	\N	2019-01-07	-7.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.167384	2020-10-23 22:40:35.167384
5231	5	1	-1	2	\N	2019-01-07	-178.15	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.168515	2020-10-23 22:40:35.168515
5232	5	9	48	2	\N	2019-01-07	-2.50	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:35.169671	2020-10-23 22:40:35.169671
5233	5	9	53	3	\N	2019-01-07	-2500.00	15d4e891d784977cacbfcbb00c48f133	2020-10-23 22:40:35.171394	2020-10-23 22:40:35.171394
5234	5	3	-1	2	\N	2019-01-07	-84.26	53c535a8b8a2c8bb670d136b82e73f99	2020-10-23 22:40:35.172599	2020-10-23 22:40:35.172599
5235	5	9	53	3	\N	2019-01-07	-5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.173629	2020-10-23 22:40:35.173629
5236	6	10	54	4	\N	2019-01-07	5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.17462	2020-10-23 22:40:35.17462
5237	5	9	48	2	\N	2019-01-07	-13.25	13f320e7b5ead1024ac95c3b208610db	2020-10-23 22:40:35.175738	2020-10-23 22:40:35.175738
5238	5	9	48	2	\N	2019-01-07	-59.50	4c43c3e905ab954683408e8f3e8a5af0	2020-10-23 22:40:35.177092	2020-10-23 22:40:35.177092
5239	2	4	18	2	\N	2019-01-07	-25.00	151f9002fb3c303ea3851145a4aee019	2020-10-23 22:40:35.178707	2020-10-23 22:40:35.178707
5240	2	6	27	2	\N	2019-01-08	-33.60	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:35.180116	2020-10-23 22:40:35.180116
5241	6	10	54	3	\N	2019-01-10	-20000.00	be83ab3ecd0db773eb2dc1b0a17836a1	2020-10-23 22:40:35.181312	2020-10-23 22:40:35.181312
5242	5	10	54	4	\N	2019-01-10	20000.00	be83ab3ecd0db773eb2dc1b0a17836a1	2020-10-23 22:40:35.182568	2020-10-23 22:40:35.182568
5243	2	6	27	2	\N	2019-01-10	-69.80	eb80b8864bc8a8df368d95cac8ecf372	2020-10-23 22:40:35.183633	2020-10-23 22:40:35.183633
5244	2	9	47	2	\N	2019-01-09	-100.00	83e1a2761dbec035ee3d11d05cf161eb	2020-10-23 22:40:35.184784	2020-10-23 22:40:35.184784
5245	2	9	48	2	\N	2019-01-10	-10.00	992fe32ccaed550899772cc80a40d81f	2020-10-23 22:40:35.185992	2020-10-23 22:40:35.185992
5246	1	2	-1	4	\N	2019-01-12	10.00	84117275be999ff55a987b9381e01f96	2020-10-23 22:40:35.187009	2020-10-23 22:40:35.187009
5247	1	7	36	2	\N	2019-01-12	-27.00	37f0e884fbad9667e38940169d0a3c95	2020-10-23 22:40:35.18842	2020-10-23 22:40:35.18842
5248	5	9	48	2	\N	2019-01-12	-9.90	97678a4b04345b34b97244ea56c1b7e1	2020-10-23 22:40:35.189462	2020-10-23 22:40:35.189462
5249	5	1	-1	2	\N	2019-01-12	-5.70	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.190514	2020-10-23 22:40:35.190514
5250	5	1	-1	2	\N	2019-01-11	-163.02	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.191784	2020-10-23 22:40:35.191784
5251	5	1	-1	2	\N	2019-01-10	-8.59	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:35.193051	2020-10-23 22:40:35.193051
5252	5	1	-1	2	\N	2019-01-10	-10.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.19425	2020-10-23 22:40:35.19425
5253	5	5	21	2	\N	2019-01-10	-18.97	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:35.195445	2020-10-23 22:40:35.195445
5254	2	6	27	2	\N	2019-01-12	-19.99	20ac53b1b739df511b6df0539e995ed9	2020-10-23 22:40:35.196573	2020-10-23 22:40:35.196573
5255	2	9	48	2	\N	2019-01-12	-40.99	6c574a6668c2aacffb8ef8066dda013c	2020-10-23 22:40:35.197662	2020-10-23 22:40:35.197662
5256	2	4	16	2	\N	2019-01-14	-29.99	b3e654bda369607f2a4809e5f3282b52	2020-10-23 22:40:35.198751	2020-10-23 22:40:35.198751
5257	5	1	-1	2	\N	2019-01-14	-10.80	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:35.199746	2020-10-23 22:40:35.199746
5258	5	10	54	4	\N	2019-01-11	2500.00	4310e3e7a5890265a915effd565d7992	2020-10-23 22:40:35.200785	2020-10-23 22:40:35.200785
5259	2	6	27	1	\N	2019-01-16	39.90	945c92ca6395cdbeb553cbcddf441aeb	2020-10-23 22:40:35.201946	2020-10-23 22:40:35.201946
5260	2	1	-1	2	\N	2019-01-16	-40.00	48044979623ab599d9557300637aa49b	2020-10-23 22:40:35.202981	2020-10-23 22:40:35.202981
5261	2	6	27	2	\N	2019-01-16	-79.98	b55ec28c52d5f6205684a473a2193564	2020-10-23 22:40:35.204352	2020-10-23 22:40:35.204352
5262	2	1	-1	2	\N	2019-01-16	-14.24	6df0aa6b0f3e0dd34480423263886f1e	2020-10-23 22:40:35.205546	2020-10-23 22:40:35.205546
5263	5	8	43	2	\N	2019-01-16	-230.47	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:35.206849	2020-10-23 22:40:35.206849
5264	5	4	-1	2	\N	2019-01-17	-91.00	b2eb7349035754953b57a32e2841bda5	2020-10-23 22:40:35.208439	2020-10-23 22:40:35.208439
5265	5	9	51	2	\N	2019-01-13	-40.00	bd11443c66c6aecb60415d7165bdda33	2020-10-23 22:40:35.209766	2020-10-23 22:40:35.209766
5266	5	1	-1	2	\N	2019-01-18	-8.45	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.211088	2020-10-23 22:40:35.211088
5267	2	1	-1	2	\N	2019-01-17	-7.97	115f89503138416a242f40fb7d7f338e	2020-10-23 22:40:35.212182	2020-10-23 22:40:35.212182
5268	5	1	-1	2	\N	2019-01-18	-146.54	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:40:35.213236	2020-10-23 22:40:35.213236
5269	1	2	-1	4	\N	2019-01-21	450.00	3c7781a36bcd6cf08c11a970fbe0e2a6	2020-10-23 22:40:35.214505	2020-10-23 22:40:35.214505
5270	1	9	48	2	\N	2019-01-21	-256.00	714b98e0a797e8f119f257a4ab802f86	2020-10-23 22:40:35.215494	2020-10-23 22:40:35.215494
5271	5	3	-1	2	\N	2019-01-19	-46.33	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.21673	2020-10-23 22:40:35.21673
5272	2	9	47	2	\N	2019-01-24	-14.68	a8ecbabae151abacba7dbde04f761c37	2020-10-23 22:40:35.218017	2020-10-23 22:40:35.218017
5273	1	2	-1	1	\N	2019-01-24	50.00	2169184650ee32062f115ec35faf6c9b	2020-10-23 22:40:35.219208	2020-10-23 22:40:35.219208
5274	1	8	41	2	\N	2019-01-26	-25.00	ba55ff88bddf71220a86105441fd2fff	2020-10-23 22:40:35.220427	2020-10-23 22:40:35.220427
5275	5	10	54	4	\N	2019-01-26	5429.44	0ff39bbbf981ac0151d340c9aa40e63e	2020-10-23 22:40:35.221702	2020-10-23 22:40:35.221702
5276	1	10	54	4	\N	2019-01-26	4500.00	d490d7b4576290fa60eb31b5fc917ad1	2020-10-23 22:40:35.22307	2020-10-23 22:40:35.22307
5277	5	9	53	3	\N	2019-01-26	-3929.44	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.22447	2020-10-23 22:40:35.22447
5278	6	10	54	4	\N	2019-01-26	3929.44	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.225546	2020-10-23 22:40:35.225546
5279	1	9	53	3	\N	2019-01-26	-1000.00	185c29dc24325934ee377cfda20e414c	2020-10-23 22:40:35.227003	2020-10-23 22:40:35.227003
5280	1	9	53	3	\N	2019-01-26	-450.00	b0db275a08c8f0bb69e86309be108a45	2020-10-23 22:40:35.228454	2020-10-23 22:40:35.228454
5281	1	9	53	3	\N	2019-01-26	-1500.00	2a084e55c87b1ebcdaad1f62fdbbac8e	2020-10-23 22:40:35.229523	2020-10-23 22:40:35.229523
5282	1	9	53	3	\N	2019-01-26	-1000.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:35.230618	2020-10-23 22:40:35.230618
5283	1	9	53	3	\N	2019-01-26	-706.75	25cf634a77c7909b87b9d8a19b610bae	2020-10-23 22:40:35.231729	2020-10-23 22:40:35.231729
5284	5	1	-1	2	\N	2019-01-26	-15.35	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.232813	2020-10-23 22:40:35.232813
5285	5	1	-1	2	\N	2019-01-24	-106.32	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.233899	2020-10-23 22:40:35.233899
5286	5	3	-1	2	\N	2019-01-25	-31.39	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:35.235038	2020-10-23 22:40:35.235038
5287	5	1	11	2	\N	2019-01-24	-17.67	8e5082190f9c8af00b4d59583e601515	2020-10-23 22:40:35.236154	2020-10-23 22:40:35.236154
5288	5	2	-1	1	\N	2019-01-26	26.08	785b30443fd6e2de160408ddcfcae6fa	2020-10-23 22:40:35.237295	2020-10-23 22:40:35.237295
5289	5	9	53	3	\N	2019-01-26	-200.00	93dd4de5cddba2c733c65f233097f05a	2020-10-23 22:40:35.238352	2020-10-23 22:40:35.238352
5290	5	1	-1	2	\N	2019-01-27	-188.15	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.23932	2020-10-23 22:40:35.23932
5291	2	6	27	2	\N	2019-01-27	-34.98	e0af5865757b3f2a82967f6177aae43d	2020-10-23 22:40:35.240319	2020-10-23 22:40:35.240319
5292	2	9	48	2	\N	2019-01-27	-139.88	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:40:35.241377	2020-10-23 22:40:35.241377
5293	2	3	-1	2	\N	2019-01-26	-12.00	52b63d77bf43b876cfb710b0def2fbcc	2020-10-23 22:40:35.243332	2020-10-23 22:40:35.243332
5294	2	7	31	2	\N	2019-01-26	-22.00	c033b45d3a7250ceb21c53590c7e564c	2020-10-23 22:40:35.244772	2020-10-23 22:40:35.244772
5295	1	8	41	2	\N	2019-01-30	-3.00	9b72e31dac81715466cd580a448cf823	2020-10-23 22:40:35.246018	2020-10-23 22:40:35.246018
5296	1	2	-1	1	\N	2019-01-29	98.00	33ea2a5e212ab720e2aa929f17630ca7	2020-10-23 22:40:35.247083	2020-10-23 22:40:35.247083
5297	1	2	-1	1	\N	2019-01-29	96.00	3554b056350eabea4171c518276523e0	2020-10-23 22:40:35.248743	2020-10-23 22:40:35.248743
5298	1	2	-1	1	\N	2019-01-29	48.00	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:40:35.250001	2020-10-23 22:40:35.250001
5299	5	5	23	2	\N	2019-01-30	-39.47	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.251108	2020-10-23 22:40:35.251108
5300	5	1	-1	2	\N	2019-01-30	-8.42	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.252407	2020-10-23 22:40:35.252407
5301	5	1	-1	2	\N	2019-01-30	-7.02	084d5dcb6d1c6f790ff013bb8751bd2d	2020-10-23 22:40:35.253366	2020-10-23 22:40:35.253366
5302	2	2	3	1	\N	2019-01-29	6898.64	263a82a0c7b139fca63c8e5fb3e22638	2020-10-23 22:40:35.254378	2020-10-23 22:40:35.254378
5303	5	1	11	2	\N	2019-01-30	-15.05	958be1aac9d0641822a4dbaa3ad9010f	2020-10-23 22:40:35.255593	2020-10-23 22:40:35.255593
5304	2	10	54	3	\N	2019-01-31	-5000.00	09ebf345bbc6049b9977a21077d59d7e	2020-10-23 22:40:35.256718	2020-10-23 22:40:35.256718
5305	5	10	54	4	\N	2019-01-31	5000.00	09ebf345bbc6049b9977a21077d59d7e	2020-10-23 22:40:35.257923	2020-10-23 22:40:35.257923
5306	5	4	13	2	\N	2019-01-31	-340.89	2b44928ae11fb9384c4cf38708677c48	2020-10-23 22:40:35.259229	2020-10-23 22:40:35.259229
5307	5	4	15	2	\N	2019-01-31	-125.80	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:35.260594	2020-10-23 22:40:35.260594
5308	5	4	14	2	\N	2019-01-31	-105.70	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:35.261676	2020-10-23 22:40:35.261676
5309	5	4	16	2	\N	2019-01-31	-54.89	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:35.262953	2020-10-23 22:40:35.262953
5310	5	8	43	2	\N	2019-02-01	-176.08	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:35.263998	2020-10-23 22:40:35.263998
5311	5	1	-1	2	\N	2019-02-01	-2.99	776b6dd127edaa9b77b19a643a2529ae	2020-10-23 22:40:35.264994	2020-10-23 22:40:35.264994
5312	1	9	53	3	\N	2019-02-01	-100.00	f2d55651da3ccc07bce92c32b85ba563	2020-10-23 22:40:35.266071	2020-10-23 22:40:35.266071
5313	5	2	-1	4	\N	2019-02-03	152.50	dff4f135ef796247aa8ae9da2c4c6c8e	2020-10-23 22:40:35.267617	2020-10-23 22:40:35.267617
5314	1	9	53	3	\N	2019-02-03	-152.50	dff4f135ef796247aa8ae9da2c4c6c8e	2020-10-23 22:40:35.268809	2020-10-23 22:40:35.268809
5315	5	9	53	3	\N	2019-02-01	-152.50	e4bb4c5173c2ce17fd8fcd40041c068f	2020-10-23 22:40:35.269959	2020-10-23 22:40:35.269959
5316	5	7	30	2	\N	2019-02-03	-145.09	de406ffa87be469ed33279efc42221d0	2020-10-23 22:40:35.271042	2020-10-23 22:40:35.271042
5317	5	1	-1	2	\N	2019-01-31	-1.50	224147087de9b3872613ec323d8b486f	2020-10-23 22:40:35.272434	2020-10-23 22:40:35.272434
5318	5	4	16	2	\N	2019-01-31	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:35.273604	2020-10-23 22:40:35.273604
5319	6	10	55	1	\N	2019-01-31	12.07	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:35.274756	2020-10-23 22:40:35.274756
5320	5	7	33	3	\N	2019-02-03	-15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.276026	2020-10-23 22:40:35.276026
5321	1	2	-1	4	\N	2019-02-03	15.00	35e5113347298d16d27399578ce98659	2020-10-23 22:40:35.277311	2020-10-23 22:40:35.277311
5322	1	8	41	2	\N	2019-02-03	-37.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:35.279008	2020-10-23 22:40:35.279008
5323	1	2	-1	1	\N	2019-02-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:35.280246	2020-10-23 22:40:35.280246
5324	5	9	53	3	\N	2019-02-03	-250.00	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:35.281523	2020-10-23 22:40:35.281523
5325	1	2	-1	4	\N	2019-02-03	250.00	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:35.282754	2020-10-23 22:40:35.282754
5326	1	9	53	3	\N	2019-02-03	-280.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:35.284058	2020-10-23 22:40:35.284058
5327	5	1	-1	2	\N	2019-02-06	-16.23	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:35.285523	2020-10-23 22:40:35.285523
5328	5	1	11	2	\N	2019-02-05	-6.78	8cecbb717800d07e6b36ab8ae1b04f5c	2020-10-23 22:40:35.286753	2020-10-23 22:40:35.286753
5329	5	5	23	2	\N	2019-02-06	-23.99	9f3fcc1b61d824135f8841ad9ef2a5bf	2020-10-23 22:40:35.288224	2020-10-23 22:40:35.288224
5330	5	1	-1	2	\N	2019-02-06	-9.84	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.289292	2020-10-23 22:40:35.289292
5331	5	1	-1	2	\N	2019-02-08	-180.77	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:40:35.290302	2020-10-23 22:40:35.290302
5332	2	4	18	2	\N	2019-02-08	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:35.29128	2020-10-23 22:40:35.29128
5333	5	1	-1	2	\N	2019-02-08	-18.40	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:40:35.29317	2020-10-23 22:40:35.29317
5334	5	1	-1	2	\N	2019-02-08	-21.35	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.294354	2020-10-23 22:40:35.294354
5335	5	1	-1	2	\N	2019-02-08	-13.50	ce08becc73195df12d99d761bfbba68d	2020-10-23 22:40:35.295392	2020-10-23 22:40:35.295392
5336	5	1	-1	2	\N	2019-02-08	-12.68	bd686fd640be98efaae0091fa301e613	2020-10-23 22:40:35.296396	2020-10-23 22:40:35.296396
5337	6	10	54	3	\N	2019-02-11	-3961.00	a0b6652366863f9e6851b71382b9571d	2020-10-23 22:40:35.297393	2020-10-23 22:40:35.297393
5338	5	10	54	4	\N	2019-02-11	3961.00	a0b6652366863f9e6851b71382b9571d	2020-10-23 22:40:35.298441	2020-10-23 22:40:35.298441
5339	5	2	-1	4	\N	2019-02-11	600.00	58d4d1e7b1e97b258c9ed0b37e02d087	2020-10-23 22:40:35.299494	2020-10-23 22:40:35.299494
5340	1	2	-1	1	\N	2019-02-11	100.00	6f3ef77ac0e3619e98159e9b6febf557	2020-10-23 22:40:35.300537	2020-10-23 22:40:35.300537
5341	1	9	53	3	\N	2019-02-11	-94.50	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:35.301575	2020-10-23 22:40:35.301575
5342	5	9	47	3	\N	2019-02-11	-3000.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:40:35.302626	2020-10-23 22:40:35.302626
5343	5	1	-1	2	\N	2019-02-09	-49.88	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.303762	2020-10-23 22:40:35.303762
5344	5	7	30	2	\N	2019-02-09	-140.00	db780008ffa192e7447f125de2ccdbe2	2020-10-23 22:40:35.305	2020-10-23 22:40:35.305
5345	5	1	-1	2	\N	2019-02-09	-162.00	4df5a365f18ce8948c12e1c83285313b	2020-10-23 22:40:35.306116	2020-10-23 22:40:35.306116
5346	5	8	43	2	\N	2019-02-08	-17.50	b41790604622f445048db73fdc111473	2020-10-23 22:40:35.307234	2020-10-23 22:40:35.307234
5347	5	1	-1	2	\N	2019-02-08	-42.55	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.308306	2020-10-23 22:40:35.308306
5348	5	8	43	2	\N	2019-02-08	-259.00	b2dd7d505d68df0b925e5045ce8d4c8f	2020-10-23 22:40:35.309884	2020-10-23 22:40:35.309884
5349	5	5	21	2	\N	2019-02-12	-66.43	389bc7bb1e1c2a5e7e147703232a88f6	2020-10-23 22:40:35.311152	2020-10-23 22:40:35.311152
5350	2	5	21	2	\N	2019-02-12	-31.97	d18f655c3fce66ca401d5f38b48c89af	2020-10-23 22:40:35.312224	2020-10-23 22:40:35.312224
5351	2	4	16	2	\N	2019-02-12	-31.99	8d6dc35e506fc23349dd10ee68dabb64	2020-10-23 22:40:35.313232	2020-10-23 22:40:35.313232
5352	1	2	-1	1	\N	2019-02-14	39.17	4b0250793549726d5c1ea3906726ebfe	2020-10-23 22:40:35.314203	2020-10-23 22:40:35.314203
5353	1	2	-1	4	\N	2019-02-13	1120.00	ace435d49572add5f18d3ea54ca413f5	2020-10-23 22:40:35.315202	2020-10-23 22:40:35.315202
5354	1	8	43	2	\N	2019-02-13	-1120.00	ace435d49572add5f18d3ea54ca413f5	2020-10-23 22:40:35.316677	2020-10-23 22:40:35.316677
5355	1	9	48	2	\N	2019-02-16	-28.79	e14518b71fb3306fef04fcf950cae886	2020-10-23 22:40:35.317824	2020-10-23 22:40:35.317824
5356	5	1	-1	2	\N	2019-02-16	-140.14	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.319219	2020-10-23 22:40:35.319219
5357	5	1	-1	2	\N	2019-02-16	-11.25	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.320221	2020-10-23 22:40:35.320221
5358	5	1	-1	2	\N	2019-02-16	-37.49	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:35.321731	2020-10-23 22:40:35.321731
5359	5	8	43	2	\N	2019-02-14	-50.00	013d407166ec4fa56eb1e1f8cbe183b9	2020-10-23 22:40:35.323045	2020-10-23 22:40:35.323045
5360	1	9	51	2	\N	2019-02-14	-20.00	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:35.324355	2020-10-23 22:40:35.324355
5361	5	8	43	2	\N	2019-02-03	-52.00	a41224aecb2480b50e3bd3ee5e2187ab	2020-10-23 22:40:35.325454	2020-10-23 22:40:35.325454
5362	4	10	54	3	\N	2019-02-15	-2008.58	3c2bc68830ca45fdc2c02235fb2af57c	2020-10-23 22:40:35.326984	2020-10-23 22:40:35.326984
5363	2	10	54	4	\N	2019-02-15	2008.58	3c2bc68830ca45fdc2c02235fb2af57c	2020-10-23 22:40:35.328138	2020-10-23 22:40:35.328138
5364	2	4	19	2	\N	2019-02-16	-1664.00	05f9be08a7893f00515b7c27aa125016	2020-10-23 22:40:35.329194	2020-10-23 22:40:35.329194
5365	2	5	23	2	\N	2019-02-16	-55.97	be27a24e1055447e27c24e713125185d	2020-10-23 22:40:35.330234	2020-10-23 22:40:35.330234
5366	2	6	27	2	\N	2019-02-16	-22.60	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:35.331311	2020-10-23 22:40:35.331311
5367	5	8	43	2	\N	2019-02-16	-179.99	8c18a8955c810caf01de158a6eb57908	2020-10-23 22:40:35.332569	2020-10-23 22:40:35.332569
5368	5	1	-1	2	\N	2019-02-20	-28.07	0d1f3b0802c73b1e989b36551deb0193	2020-10-23 22:40:35.334516	2020-10-23 22:40:35.334516
5369	5	4	-1	2	\N	2019-02-21	-14.00	9be40cee5b0eee1462c82c6964087ff9	2020-10-23 22:40:35.335926	2020-10-23 22:40:35.335926
5370	5	4	16	2	\N	2019-02-22	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:35.337296	2020-10-23 22:40:35.337296
5371	2	9	47	2	\N	2019-02-22	-50.00	013d407166ec4fa56eb1e1f8cbe183b9	2020-10-23 22:40:35.338445	2020-10-23 22:40:35.338445
5372	5	1	-1	2	\N	2019-02-22	-13.05	458adea9687ccee28a4b97b773941b13	2020-10-23 22:40:35.340517	2020-10-23 22:40:35.340517
5373	5	4	-1	2	\N	2019-02-21	-19.00	9be40cee5b0eee1462c82c6964087ff9	2020-10-23 22:40:35.3422	2020-10-23 22:40:35.3422
5374	1	8	41	2	\N	2019-02-23	-0.30	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:40:35.343691	2020-10-23 22:40:35.343691
5375	5	8	41	2	\N	2019-02-23	-1.00	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:40:35.344808	2020-10-23 22:40:35.344808
5376	5	1	-1	2	\N	2019-02-23	-29.40	11c6d471fa4e354e62e684d293694202	2020-10-23 22:40:35.346058	2020-10-23 22:40:35.346058
5377	5	8	43	2	\N	2019-02-23	-226.50	56f8e43767cf93af23801dbdf2bf0335	2020-10-23 22:40:35.347379	2020-10-23 22:40:35.347379
5378	5	1	-1	2	\N	2019-02-22	-179.68	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:35.348643	2020-10-23 22:40:35.348643
5379	5	1	-1	2	\N	2019-02-25	-8.30	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.349755	2020-10-23 22:40:35.349755
5380	5	1	-1	2	\N	2019-02-24	-21.45	63c4c2f5f352bf65623b043e550bb0c5	2020-10-23 22:40:35.351348	2020-10-23 22:40:35.351348
5381	5	9	50	2	\N	2019-02-25	-7.50	42cde9b4477fcfa21199c72885e13993	2020-10-23 22:40:35.352623	2020-10-23 22:40:35.352623
5382	5	2	-1	1	\N	2019-02-25	0.32	c4e187dcd2ea9518f72fdaaad6231d17	2020-10-23 22:40:35.353819	2020-10-23 22:40:35.353819
5383	1	9	50	2	\N	2019-02-25	-7.50	42cde9b4477fcfa21199c72885e13993	2020-10-23 22:40:35.35505	2020-10-23 22:40:35.35505
5384	1	2	-1	4	\N	2019-02-25	3546.27	e5fd7fb28526626f37fb508cb9ed8ef8	2020-10-23 22:40:35.356288	2020-10-23 22:40:35.356288
5385	1	9	53	3	\N	2019-02-25	-3538.50	e5fd7fb28526626f37fb508cb9ed8ef8	2020-10-23 22:40:35.357342	2020-10-23 22:40:35.357342
5386	5	2	-1	4	\N	2019-02-25	3538.50	e5fd7fb28526626f37fb508cb9ed8ef8	2020-10-23 22:40:35.358393	2020-10-23 22:40:35.358393
5387	5	2	-1	4	\N	2019-02-25	2441.50	e5fd7fb28526626f37fb508cb9ed8ef8	2020-10-23 22:40:35.359632	2020-10-23 22:40:35.359632
5388	5	1	-1	2	\N	2019-02-26	-21.44	e268203a5d92464c9a3c5f94b4386863	2020-10-23 22:40:35.360995	2020-10-23 22:40:35.360995
5389	2	1	-1	2	\N	2019-02-27	-13.90	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:35.362209	2020-10-23 22:40:35.362209
5390	2	2	3	1	\N	2019-02-27	11967.51	29dea2aaf1d32caff9b4566bff2687d6	2020-10-23 22:40:35.363514	2020-10-23 22:40:35.363514
5391	2	10	54	3	\N	2019-02-27	-10000.00	56ce955b020482d7ba9ca231f499cb2d	2020-10-23 22:40:35.364939	2020-10-23 22:40:35.364939
5392	5	10	54	4	\N	2019-02-27	10000.00	56ce955b020482d7ba9ca231f499cb2d	2020-10-23 22:40:35.366352	2020-10-23 22:40:35.366352
5393	6	10	55	1	\N	2019-02-28	5.97	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:35.367445	2020-10-23 22:40:35.367445
5394	5	1	-1	2	\N	2019-02-27	-17.95	c042f4db68f23406c6cecf84a7ebb0fe	2020-10-23 22:40:35.368524	2020-10-23 22:40:35.368524
5395	5	1	-1	2	\N	2019-02-27	-111.37	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:35.369619	2020-10-23 22:40:35.369619
5396	5	1	-1	2	\N	2019-02-27	-15.80	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:40:35.370681	2020-10-23 22:40:35.370681
5397	5	1	-1	2	\N	2019-03-01	-9.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.371724	2020-10-23 22:40:35.371724
5398	5	9	50	2	\N	2019-03-01	-10.00	8df2c13088e42821ef575a790db5b015	2020-10-23 22:40:35.372786	2020-10-23 22:40:35.372786
5399	5	1	-1	2	\N	2019-03-01	-3.48	d463c87a846080c57e7cbde6a8398590	2020-10-23 22:40:35.373873	2020-10-23 22:40:35.373873
5400	1	2	-1	1	\N	2019-03-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:35.374961	2020-10-23 22:40:35.374961
5401	5	2	-1	4	\N	2019-03-01	4000.00	25d46895f001766902354a18fba665ee	2020-10-23 22:40:35.376157	2020-10-23 22:40:35.376157
5402	1	2	-1	4	\N	2019-03-01	5929.02	c9e791d6604a5fcc1f4e6ad574f43328	2020-10-23 22:40:35.377432	2020-10-23 22:40:35.377432
5403	5	9	53	3	\N	2019-03-01	-1000.00	edbaebd0df9bf50582263c45279f9f16	2020-10-23 22:40:35.378752	2020-10-23 22:40:35.378752
5404	5	9	53	3	\N	2019-03-01	-6000.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:35.379861	2020-10-23 22:40:35.379861
5405	6	10	54	4	\N	2019-03-01	6000.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:35.380913	2020-10-23 22:40:35.380913
5406	1	9	51	2	\N	2019-03-01	-120.00	30d2c1109139d2f14e57194d12394f01	2020-10-23 22:40:35.381917	2020-10-23 22:40:35.381917
5407	1	8	41	2	\N	2019-03-01	-37.00	11364907cf269dd2183b64287156072a	2020-10-23 22:40:35.40193	2020-10-23 22:40:35.40193
5408	1	9	53	3	\N	2019-03-01	-540.37	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.403729	2020-10-23 22:40:35.403729
5409	1	9	53	3	\N	2019-03-01	-3620.00	758215d106c39f7aa9ff0e2ede452b10	2020-10-23 22:40:35.405927	2020-10-23 22:40:35.405927
5410	5	1	-1	2	\N	2019-03-02	-43.75	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.408105	2020-10-23 22:40:35.408105
5411	5	1	-1	2	\N	2019-03-02	-115.81	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.410323	2020-10-23 22:40:35.410323
5412	2	5	23	2	\N	2019-03-04	-29.99	37029430cfd06ae2a279cc1e2504e7c3	2020-10-23 22:40:35.412324	2020-10-23 22:40:35.412324
5413	2	5	23	2	\N	2019-03-04	-13.99	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:40:35.414139	2020-10-23 22:40:35.414139
5414	2	7	31	2	\N	2019-03-04	-23.00	72346edf1e7eb8a030281f780fefe3fd	2020-10-23 22:40:35.416095	2020-10-23 22:40:35.416095
5415	2	1	-1	2	\N	2019-03-04	-16.80	aef1e06f7b97d57942850adb46ec7c68	2020-10-23 22:40:35.417789	2020-10-23 22:40:35.417789
5416	5	4	13	2	\N	2019-03-05	-395.74	f74068eac285b14de5ef06da6e9010e3	2020-10-23 22:40:35.419266	2020-10-23 22:40:35.419266
5417	2	6	27	2	\N	2019-03-05	-10.90	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:35.421037	2020-10-23 22:40:35.421037
5418	1	9	50	2	\N	2019-03-03	-11.00	4f6ffe13a5d75b2d6a3923922b3922e5	2020-10-23 22:40:35.422714	2020-10-23 22:40:35.422714
5419	1	2	-1	4	\N	2019-03-03	20.00	9cc138f8dc04cbf16240daa92d8d50e2	2020-10-23 22:40:35.424043	2020-10-23 22:40:35.424043
5420	1	4	19	2	\N	2019-03-06	-1612.00	a91f7d0f27f3c35bd2692c05876cc13f	2020-10-23 22:40:35.425573	2020-10-23 22:40:35.425573
5421	5	1	-1	2	\N	2019-03-08	-10.05	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.427048	2020-10-23 22:40:35.427048
5422	5	1	-1	2	\N	2019-03-07	-3.60	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:35.428657	2020-10-23 22:40:35.428657
5423	5	1	-1	2	\N	2019-03-06	-5.98	29b7d70814383d3d41fe12d57cb4736a	2020-10-23 22:40:35.430018	2020-10-23 22:40:35.430018
5424	5	1	-1	2	\N	2019-03-05	-15.75	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.431285	2020-10-23 22:40:35.431285
5425	5	9	50	2	\N	2019-03-02	-8.00	0aa1883c6411f7873cb83dacb17b0afc	2020-10-23 22:40:35.432629	2020-10-23 22:40:35.432629
5426	2	1	-1	2	\N	2019-03-08	-29.96	9b0a5fa32a0adc5f4f86a750a1c72e98	2020-10-23 22:40:35.433941	2020-10-23 22:40:35.433941
5427	2	5	23	2	\N	2019-03-08	-16.99	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:35.435205	2020-10-23 22:40:35.435205
5428	1	3	-1	2	\N	2019-03-09	-5.39	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.436494	2020-10-23 22:40:35.436494
5429	5	1	-1	2	\N	2019-03-09	-184.35	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:35.43775	2020-10-23 22:40:35.43775
5430	2	4	18	2	\N	2019-03-12	-25.00	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:40:35.439063	2020-10-23 22:40:35.439063
5431	2	4	18	2	\N	2019-03-12	-31.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:35.440772	2020-10-23 22:40:35.440772
5432	5	8	43	2	\N	2019-03-13	-1000.00	913bc9230eeef481fc118ab0e8b7f40d	2020-10-23 22:40:35.442118	2020-10-23 22:40:35.442118
5433	5	2	-1	4	\N	2019-03-13	15.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.443536	2020-10-23 22:40:35.443536
5434	5	9	-1	3	\N	2019-03-13	-15.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.444851	2020-10-23 22:40:35.444851
5435	1	2	-1	4	\N	2019-03-13	15.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:35.4461	2020-10-23 22:40:35.4461
5436	5	1	-1	2	\N	2019-03-12	-7.74	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.447377	2020-10-23 22:40:35.447377
5437	5	5	26	2	\N	2013-03-14	-30.11	0957ec7f9a1e6ef4908051352f0c6fbd	2020-10-23 22:40:35.448613	2020-10-23 22:40:35.448613
5438	5	1	-1	2	\N	2013-03-14	-18.60	3e716f30c8450143d7248609a6653887	2020-10-23 22:40:35.449862	2020-10-23 22:40:35.449862
5439	5	1	-1	2	\N	2013-03-14	-9.29	c8fbbc86abe8bd6a5eb6a3b4d0411301	2020-10-23 22:40:35.451066	2020-10-23 22:40:35.451066
5440	5	1	-1	2	\N	2013-03-14	-12.30	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.452507	2020-10-23 22:40:35.452507
5441	5	1	-1	2	\N	2013-03-14	-2.50	8d34201a5b85900908db6cae92723617	2020-10-23 22:40:35.453724	2020-10-23 22:40:35.453724
5442	5	1	-1	2	\N	2013-03-14	-20.54	3619cb5bf1ba5b8f0523230ca3f4f148	2020-10-23 22:40:35.455214	2020-10-23 22:40:35.455214
5443	2	9	47	2	\N	2019-03-12	-50.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:35.456446	2020-10-23 22:40:35.456446
5444	5	1	-1	2	\N	2019-03-14	-7.48	626ba6666b7942411018af8b5d54602f	2020-10-23 22:40:35.457895	2020-10-23 22:40:35.457895
5445	5	1	-1	2	\N	2019-03-14	-144.68	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.459164	2020-10-23 22:40:35.459164
5446	2	1	-1	2	\N	2019-03-16	-11.32	801886d15a07a0f786169c3fa4c54b34	2020-10-23 22:40:35.460711	2020-10-23 22:40:35.460711
5447	2	9	47	2	\N	2019-03-17	-50.00	0839983bfd57146d01f22f45340add56	2020-10-23 22:40:35.461989	2020-10-23 22:40:35.461989
5448	5	4	16	2	\N	2019-03-17	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:35.463407	2020-10-23 22:40:35.463407
5449	5	1	-1	2	\N	2019-03-17	-6.40	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:35.464816	2020-10-23 22:40:35.464816
5450	5	1	-1	2	\N	2019-03-17	-2.80	73fd1f9f5308d9c25da3da52404d843e	2020-10-23 22:40:35.466377	2020-10-23 22:40:35.466377
5451	2	1	-1	2	\N	2019-03-18	-33.96	677e09724f0e2df9b6c000b75b5da10d	2020-10-23 22:40:35.467614	2020-10-23 22:40:35.467614
5452	5	1	-1	2	\N	2019-03-19	-19.20	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:35.474741	2020-10-23 22:40:35.474741
5453	5	2	-1	4	\N	2019-03-26	4800.00	0e75385608a4a0053942ad1081ab3537	2020-10-23 22:40:35.476365	2020-10-23 22:40:35.476365
5454	5	1	-1	2	\N	2019-03-21	-10.07	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.477976	2020-10-23 22:40:35.477976
5455	5	5	21	2	\N	2019-03-26	-76.24	dc6a6489640ca02b0d42dabeb8e46bb7	2020-10-23 22:40:35.479236	2020-10-23 22:40:35.479236
5456	5	5	23	2	\N	2019-03-23	-28.49	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.480223	2020-10-23 22:40:35.480223
5457	5	1	-1	2	\N	2019-03-23	-19.20	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:35.481233	2020-10-23 22:40:35.481233
5458	5	1	-1	2	\N	2019-03-23	-11.26	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:35.482239	2020-10-23 22:40:35.482239
5459	5	1	-1	2	\N	2019-03-23	-10.82	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:35.483234	2020-10-23 22:40:35.483234
5460	5	1	-1	2	\N	2019-03-22	-150.77	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.484203	2020-10-23 22:40:35.484203
5461	5	1	-1	2	\N	2019-03-21	-1.79	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.485209	2020-10-23 22:40:35.485209
5462	5	1	-1	2	\N	2019-03-18	-23.56	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.486188	2020-10-23 22:40:35.486188
5463	5	1	-1	2	\N	2019-03-18	-12.00	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.487191	2020-10-23 22:40:35.487191
5464	5	9	50	2	\N	2019-03-11	-5.00	a67f096809415ca1c9f112d96d27689b	2020-10-23 22:40:35.488162	2020-10-23 22:40:35.488162
5465	5	10	54	3	\N	2019-03-26	-4000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.489397	2020-10-23 22:40:35.489397
5466	6	10	54	4	\N	2019-03-26	4000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.490513	2020-10-23 22:40:35.490513
5467	5	2	-1	4	\N	2019-03-26	14.13	7e86f7d63279fc772b30b42aebda6111	2020-10-23 22:40:35.491688	2020-10-23 22:40:35.491688
5468	2	2	3	1	\N	2019-03-27	7498.78	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:35.4928	2020-10-23 22:40:35.4928
5469	2	10	54	3	\N	2019-03-27	-5000.00	1fe7306869529c380be67ed7a2e91478	2020-10-23 22:40:35.493953	2020-10-23 22:40:35.493953
5470	5	10	54	4	\N	2019-03-27	5000.00	b16ca745ad43b243f09726e9138577e3	2020-10-23 22:40:35.495068	2020-10-23 22:40:35.495068
5471	2	2	-1	1	\N	2019-03-27	5.00	45a1d05ca1176c6f286632d35c94ef6c	2020-10-23 22:40:35.496061	2020-10-23 22:40:35.496061
5472	5	4	13	2	\N	2019-03-27	-395.74	288cc0ff022877bd3df94bc9360b9c5d	2020-10-23 22:40:35.497095	2020-10-23 22:40:35.497095
5473	5	4	15	2	\N	2019-03-27	-39.91	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:35.498082	2020-10-23 22:40:35.498082
5474	5	8	45	2	\N	2019-03-28	-40.00	d5067c4b4f3c7a93746a2574bca0bfdb	2020-10-23 22:40:35.499107	2020-10-23 22:40:35.499107
5475	5	8	45	2	\N	2019-03-29	-40.00	ee69587bfe3a045c95680b5e02d1524b	2020-10-23 22:40:35.500081	2020-10-23 22:40:35.500081
5476	5	1	-1	2	\N	2019-03-27	-14.05	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.501095	2020-10-23 22:40:35.501095
5477	5	1	-1	2	\N	2019-03-29	-152.16	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.502098	2020-10-23 22:40:35.502098
5478	5	5	23	2	\N	2019-03-30	-31.96	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:35.503116	2020-10-23 22:40:35.503116
5479	5	3	-1	2	\N	2019-03-30	-7.80	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.505147	2020-10-23 22:40:35.505147
5480	5	9	48	2	\N	2019-03-31	-100.00	e0550b25de266e2e10779c994297edd4	2020-10-23 22:40:35.506481	2020-10-23 22:40:35.506481
5481	5	1	-1	2	\N	2019-03-31	-26.30	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:35.507692	2020-10-23 22:40:35.507692
5482	5	8	43	2	\N	2019-03-30	-15.00	b137fdd1f79d56c7edf3365fea7520f2	2020-10-23 22:40:35.508985	2020-10-23 22:40:35.508985
5483	5	1	-1	2	\N	2019-03-30	-11.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.510454	2020-10-23 22:40:35.510454
5484	5	1	-1	2	\N	2019-03-30	-14.78	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.511803	2020-10-23 22:40:35.511803
5485	5	9	47	2	\N	2019-03-29	-20.00	51d92be1c60d1db1d2e5e7a07da55b26	2020-10-23 22:40:35.513024	2020-10-23 22:40:35.513024
5486	5	9	-1	2	\N	2019-03-29	-3.93	7e86f7d63279fc772b30b42aebda6111	2020-10-23 22:40:35.514186	2020-10-23 22:40:35.514186
5487	6	10	55	1	\N	2019-03-31	7.10	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:35.515272	2020-10-23 22:40:35.515272
5488	1	2	-1	4	\N	2019-04-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:35.516423	2020-10-23 22:40:35.516423
5489	5	2	-1	4	\N	2019-04-01	1500.00	d3bda6ff7eabd4e861e899b20c308564	2020-10-23 22:40:35.51756	2020-10-23 22:40:35.51756
5490	2	9	53	3	\N	2019-04-01	-1500.00	bb1803ca8db55bea267f66e6ebae0208	2020-10-23 22:40:35.518549	2020-10-23 22:40:35.518549
5491	1	9	51	2	\N	2019-04-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:35.519595	2020-10-23 22:40:35.519595
5492	5	2	-1	4	\N	2019-04-01	414.16	ee39292e45d456a6955c220dc5f3c977	2020-10-23 22:40:35.520655	2020-10-23 22:40:35.520655
5493	1	2	-1	4	\N	2019-04-01	750.00	9afe2b8215c08e9d7cab10fe37686726	2020-10-23 22:40:35.521689	2020-10-23 22:40:35.521689
5494	1	9	53	3	\N	2019-04-01	-120.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.522706	2020-10-23 22:40:35.522706
5495	5	1	-1	2	\N	2019-04-01	-8.90	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:35.523753	2020-10-23 22:40:35.523753
5496	2	6	27	2	\N	2019-04-01	-55.80	b05ef1f72e4bbd5cbefdc8b5d95e0b3b	2020-10-23 22:40:35.524855	2020-10-23 22:40:35.524855
5497	1	1	11	2	\N	2019-04-01	-20.00	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:40:35.525899	2020-10-23 22:40:35.525899
5498	1	3	-1	2	\N	2019-04-01	-21.46	623a67a34852dc4ed42b87c84cade0e1	2020-10-23 22:40:35.527321	2020-10-23 22:40:35.527321
5499	1	7	35	2	\N	2019-04-01	-110.00	30d69ba3457fbe63ddf07f88adbca502	2020-10-23 22:40:35.528473	2020-10-23 22:40:35.528473
5500	5	1	-1	2	\N	2019-04-03	-6.00	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:35.529535	2020-10-23 22:40:35.529535
5501	5	1	-1	2	\N	2019-04-03	-8.97	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.530518	2020-10-23 22:40:35.530518
5502	5	1	-1	2	\N	2019-04-03	-8.38	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.531518	2020-10-23 22:40:35.531518
5503	5	1	-1	2	\N	2019-04-03	-6.60	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:35.532496	2020-10-23 22:40:35.532496
5504	5	1	-1	2	\N	2019-04-02	-3.59	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:35.533552	2020-10-23 22:40:35.533552
5505	5	1	-1	2	\N	2019-04-02	-11.94	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:35.534605	2020-10-23 22:40:35.534605
5506	5	5	23	2	\N	2019-04-02	-3.00	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.535653	2020-10-23 22:40:35.535653
5507	5	1	-1	2	\N	2019-04-02	-72.60	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.536703	2020-10-23 22:40:35.536703
5508	5	5	23	2	\N	2019-04-02	-1.50	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.537775	2020-10-23 22:40:35.537775
5509	5	8	43	2	\N	2019-04-01	-300.00	b4a5f57bd19102a769d4eeff4de65c0c	2020-10-23 22:40:35.53894	2020-10-23 22:40:35.53894
5510	5	2	-1	1	\N	2019-04-01	20.43	887ad370e29a0f99e5ce1394a9e7e7ee	2020-10-23 22:40:35.539991	2020-10-23 22:40:35.539991
5511	5	9	-1	2	\N	2019-04-04	-1.58	6a8addeb940cd48f8177c44d5991650e	2020-10-23 22:40:35.54115	2020-10-23 22:40:35.54115
5512	1	8	41	2	\N	2019-04-04	-37.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:35.542312	2020-10-23 22:40:35.542312
5513	2	6	27	2	\N	2019-04-04	-35.00	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:35.543462	2020-10-23 22:40:35.543462
5514	2	1	-1	2	\N	2019-04-04	-6.00	8ea5d22eba2d75b7651304f4dcde8eee	2020-10-23 22:40:35.54459	2020-10-23 22:40:35.54459
5515	2	5	23	2	\N	2019-04-04	-29.90	666f46f88b716f964ff644c0334a6ee0	2020-10-23 22:40:35.545716	2020-10-23 22:40:35.545716
5516	2	1	-1	2	\N	2019-04-04	-3.39	283d4cf32fc0de7eb96464a45c65d249	2020-10-23 22:40:35.546762	2020-10-23 22:40:35.546762
5517	2	5	23	2	\N	2019-04-04	-94.16	6296255ede2ff271e19c833ecfdb5f29	2020-10-23 22:40:35.54781	2020-10-23 22:40:35.54781
5518	2	10	54	3	\N	2019-04-05	-500.00	8bb518e95bb8c25e31ea444ca6549b95	2020-10-23 22:40:35.548837	2020-10-23 22:40:35.548837
5519	4	10	54	4	\N	2019-04-05	500.00	8bb518e95bb8c25e31ea444ca6549b95	2020-10-23 22:40:35.549835	2020-10-23 22:40:35.549835
5520	1	1	11	2	\N	2019-04-05	-10.50	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:35.550881	2020-10-23 22:40:35.550881
5521	5	8	43	2	\N	2019-04-05	-229.23	bfcacdfdea54d7b07d6b9c9f108118a6	2020-10-23 22:40:35.552008	2020-10-23 22:40:35.552008
5522	5	1	-1	2	\N	2019-04-05	-66.14	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:35.553168	2020-10-23 22:40:35.553168
5523	2	1	-1	2	\N	2019-04-06	-42.00	1ab4b8faa2e8aa14f080857659e7fab7	2020-10-23 22:40:35.554358	2020-10-23 22:40:35.554358
5524	2	1	-1	2	\N	2019-04-06	-10.90	fe397f3f6f24b8500bc9c5f356384020	2020-10-23 22:40:35.555399	2020-10-23 22:40:35.555399
5525	2	1	-1	2	\N	2019-04-06	-10.90	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:35.556399	2020-10-23 22:40:35.556399
5526	2	1	-1	1	\N	2019-04-06	30.90	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:35.557395	2020-10-23 22:40:35.557395
5527	1	1	-1	2	\N	2019-04-09	-20.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:35.558401	2020-10-23 22:40:35.558401
5528	1	1	-1	2	\N	2019-04-08	-15.30	13f9896df61279c928f19721878fac41	2020-10-23 22:40:35.559528	2020-10-23 22:40:35.559528
5529	1	1	-1	2	\N	2019-04-07	-15.78	3fc9032b573128db4b3ef9220411f64c	2020-10-23 22:40:35.560703	2020-10-23 22:40:35.560703
5530	1	1	-1	2	\N	2019-04-06	-22.00	5e3002b1b5b6ce9e1ba962e4cde4b2de	2020-10-23 22:40:35.561764	2020-10-23 22:40:35.561764
5531	1	1	-1	2	\N	2019-04-06	-9.89	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.56277	2020-10-23 22:40:35.56277
5532	1	1	-1	2	\N	2019-04-06	-1.69	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.563826	2020-10-23 22:40:35.563826
5533	1	7	35	2	\N	2019-04-05	-19.96	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:35.565035	2020-10-23 22:40:35.565035
5534	5	1	-1	2	\N	2019-04-09	-119.85	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.566119	2020-10-23 22:40:35.566119
5535	5	1	-1	2	\N	2019-04-09	-11.72	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.567376	2020-10-23 22:40:35.567376
5536	5	1	-1	2	\N	2019-04-08	-10.99	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.568519	2020-10-23 22:40:35.568519
5537	5	1	-1	2	\N	2019-04-08	-6.50	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.569674	2020-10-23 22:40:35.569674
5538	5	8	43	2	\N	2019-04-07	-72.40	0d9781f46cbb67b4662bdcaad87b8dc9	2020-10-23 22:40:35.571341	2020-10-23 22:40:35.571341
5539	5	8	43	2	\N	2019-04-09	-724.00	bd686fd640be98efaae0091fa301e613	2020-10-23 22:40:35.572448	2020-10-23 22:40:35.572448
5540	2	1	-1	2	\N	2019-04-10	-9.27	d61e4bbd6393c9111e6526ea173a7c8b	2020-10-23 22:40:35.573597	2020-10-23 22:40:35.573597
5541	2	1	-1	2	\N	2019-04-10	-3.00	ffc987113c7a22fb2a52b6f9842f79be	2020-10-23 22:40:35.574603	2020-10-23 22:40:35.574603
5542	5	8	43	2	\N	2019-04-10	-107.99	131fb12b08bbc3ab3772e76cca59a3f3	2020-10-23 22:40:35.575749	2020-10-23 22:40:35.575749
5543	5	9	-1	2	\N	2019-04-11	-42.00	fbc780df196942ae2b6efacf422c0590	2020-10-23 22:40:35.576989	2020-10-23 22:40:35.576989
5544	5	1	-1	2	\N	2019-04-12	-6.28	9188905e74c28e489b44e954ec0b9bca	2020-10-23 22:40:35.578039	2020-10-23 22:40:35.578039
5545	5	1	-1	2	\N	2019-04-12	-5.30	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.579404	2020-10-23 22:40:35.579404
5546	2	6	27	2	\N	2019-04-12	-8.60	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:35.580546	2020-10-23 22:40:35.580546
5547	5	1	-1	2	\N	2019-04-15	-10.40	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.581711	2020-10-23 22:40:35.581711
5548	2	1	-1	2	\N	2019-04-15	-13.90	4eb30f049b1f69543e589bc855dd91f8	2020-10-23 22:40:35.582752	2020-10-23 22:40:35.582752
5549	2	9	47	2	\N	2019-04-16	-20.00	08568948e369d6e5901ea1052de036ac	2020-10-23 22:40:35.583956	2020-10-23 22:40:35.583956
5550	2	1	-1	2	\N	2019-04-17	-11.20	8e9a5e7fd02d9828a1ce35e1cddeb39c	2020-10-23 22:40:35.585051	2020-10-23 22:40:35.585051
5551	5	5	26	2	\N	2019-04-17	-111.28	d3543b25c8e3d12b31f114c9138ce9c2	2020-10-23 22:40:35.586331	2020-10-23 22:40:35.586331
5552	2	5	26	2	\N	2019-04-17	-46.76	cb4e48b5365723ef2c49bbf8fdd8a0a7	2020-10-23 22:40:35.587454	2020-10-23 22:40:35.587454
5553	5	5	26	1	\N	2019-04-17	46.76	cb4e48b5365723ef2c49bbf8fdd8a0a7	2020-10-23 22:40:35.588445	2020-10-23 22:40:35.588445
5554	2	5	23	2	\N	2019-04-17	-17.47	860d76957a4845af5c1a4b77c6670852	2020-10-23 22:40:35.589433	2020-10-23 22:40:35.589433
5555	5	1	-1	2	\N	2019-04-17	-7.88	37a0abfed5bee2b616b5d56d8af90b9f	2020-10-23 22:40:35.59045	2020-10-23 22:40:35.59045
5556	2	4	16	2	\N	2019-04-18	-31.99	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:35.591551	2020-10-23 22:40:35.591551
5557	6	10	54	3	\N	2019-04-19	-10013.07	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:35.592906	2020-10-23 22:40:35.592906
5558	5	10	54	4	\N	2019-04-19	10013.07	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:35.594213	2020-10-23 22:40:35.594213
5559	5	1	-1	2	\N	2019-04-19	-12.54	178c7757b43381bf43d0078a84a586ac	2020-10-23 22:40:35.595319	2020-10-23 22:40:35.595319
5560	2	6	27	2	\N	2019-04-19	-34.00	48044979623ab599d9557300637aa49b	2020-10-23 22:40:35.596441	2020-10-23 22:40:35.596441
5561	5	1	-1	2	\N	2019-04-19	-257.01	a1585847aaa6407c9449d1309731fed0	2020-10-23 22:40:35.597564	2020-10-23 22:40:35.597564
5562	1	2	-1	4	\N	2019-04-21	125.46	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:35.598692	2020-10-23 22:40:35.598692
5563	1	9	53	3	\N	2019-04-27	-103.73	0e5d835f3135681e04eea1c202813778	2020-10-23 22:40:35.599793	2020-10-23 22:40:35.599793
5564	1	9	53	3	\N	2019-04-18	-20.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:35.600743	2020-10-23 22:40:35.600743
5565	5	9	53	3	\N	2019-04-28	-200.00	ec9355bcb8b22be692ec4ec20d7412b7	2020-10-23 22:40:35.601849	2020-10-23 22:40:35.601849
5566	1	8	41	2	\N	2019-04-23	-70.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:35.602926	2020-10-23 22:40:35.602926
5567	1	3	-1	2	\N	2019-04-19	-12.47	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.604112	2020-10-23 22:40:35.604112
5568	1	1	-1	2	\N	2019-04-18	-18.75	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:35.605417	2020-10-23 22:40:35.605417
5569	1	1	-1	2	\N	2019-04-17	-14.17	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:35.606501	2020-10-23 22:40:35.606501
5570	1	1	-1	2	\N	2019-04-15	-19.35	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:35.607571	2020-10-23 22:40:35.607571
5571	1	1	-1	2	\N	2019-04-15	-3.98	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:35.608635	2020-10-23 22:40:35.608635
5572	1	1	11	2	\N	2019-04-15	-12.00	f828edc20051679939b205229f41e729	2020-10-23 22:40:35.609848	2020-10-23 22:40:35.609848
5573	1	3	-1	2	\N	2019-04-15	-12.00	994b568b7fa9be5f260452c3e36955c7	2020-10-23 22:40:35.611078	2020-10-23 22:40:35.611078
5574	1	3	-1	2	\N	2019-04-15	-8.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.612364	2020-10-23 22:40:35.612364
5575	1	1	-1	2	\N	2019-04-13	-13.97	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:35.61338	2020-10-23 22:40:35.61338
5576	1	3	-1	2	\N	2019-04-13	-15.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.614372	2020-10-23 22:40:35.614372
5577	1	3	-1	2	\N	2019-04-13	-10.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.615363	2020-10-23 22:40:35.615363
5578	1	8	41	2	\N	2019-04-13	-7.60	25f70604fe1b709fd8d4c5cae3c8e575	2020-10-23 22:40:35.616425	2020-10-23 22:40:35.616425
5579	1	1	-1	2	\N	2019-04-13	-3.59	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:35.617571	2020-10-23 22:40:35.617571
5580	6	2	3	1	\N	2019-04-26	10000.00	3d2d8ccb37df977cb6d9da15b76c3f3a	2020-10-23 22:40:35.618736	2020-10-23 22:40:35.618736
5581	5	2	3	1	\N	2019-04-26	4284.40	3d2d8ccb37df977cb6d9da15b76c3f3a	2020-10-23 22:40:35.619993	2020-10-23 22:40:35.619993
5582	5	1	-1	2	\N	2019-04-28	-303.46	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:35.621275	2020-10-23 22:40:35.621275
5583	5	3	-1	2	\N	2019-04-27	-14.20	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:35.622505	2020-10-23 22:40:35.622505
5584	5	1	11	2	\N	2019-04-27	-3.30	b92f3b97433c7c7b9695f044185bc6c3	2020-10-23 22:40:35.623792	2020-10-23 22:40:35.623792
5585	5	1	-1	2	\N	2019-04-27	-14.85	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.624927	2020-10-23 22:40:35.624927
5586	5	1	-1	2	\N	2019-04-25	-125.61	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:35.625981	2020-10-23 22:40:35.625981
5587	5	8	43	2	\N	2019-04-24	-204.78	ecea75c8a732e60a4296df05fd2d21fd	2020-10-23 22:40:35.627321	2020-10-23 22:40:35.627321
5588	5	9	-1	2	\N	2019-04-23	-45.00	f59fdf375356ae3796c80c76ff51ba53	2020-10-23 22:40:35.628473	2020-10-23 22:40:35.628473
5589	5	1	-1	2	\N	2019-04-23	-7.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.629619	2020-10-23 22:40:35.629619
5590	5	2	-1	1	\N	2019-04-19	83.91	887ad370e29a0f99e5ce1394a9e7e7ee	2020-10-23 22:40:35.630655	2020-10-23 22:40:35.630655
5591	5	8	43	2	\N	2019-04-16	-239.90	fcb33197307a7df89ae663c88a28721f	2020-10-23 22:40:35.631707	2020-10-23 22:40:35.631707
5592	5	1	-1	2	\N	2019-04-15	-166.99	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.632715	2020-10-23 22:40:35.632715
5593	5	1	-1	2	\N	2019-04-15	-12.61	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.63381	2020-10-23 22:40:35.63381
5594	5	1	-1	2	\N	2019-04-13	-8.80	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:35.634977	2020-10-23 22:40:35.634977
5595	2	5	21	2	\N	2019-04-29	-43.96	b3683be1bf21e13235c839195de5e284	2020-10-23 22:40:35.636507	2020-10-23 22:40:35.636507
5596	5	1	-1	2	\N	2019-04-29	-35.07	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:35.637748	2020-10-23 22:40:35.637748
5597	5	5	23	2	\N	2019-04-29	-31.99	e0f1a4afdc30e0724bd9be57355de70e	2020-10-23 22:40:35.639024	2020-10-23 22:40:35.639024
5598	2	6	27	2	\N	2019-04-29	-32.00	204a3eeab2a68f6bd87db22983749c42	2020-10-23 22:40:35.640247	2020-10-23 22:40:35.640247
5599	5	1	-1	2	\N	2019-04-29	-9.10	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.641613	2020-10-23 22:40:35.641613
5600	5	1	-1	2	\N	2019-04-25	-14.85	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.64333	2020-10-23 22:40:35.64333
5601	5	1	-1	2	\N	2019-04-29	-7.50	263a82a0c7b139fca63c8e5fb3e22638	2020-10-23 22:40:35.644726	2020-10-23 22:40:35.644726
5602	1	5	23	2	\N	2019-04-29	-41.98	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:35.645898	2020-10-23 22:40:35.645898
5603	2	2	3	1	\N	2019-04-30	7465.07	a780a63fb8d67bf5d1b7e62c10ec6488	2020-10-23 22:40:35.646989	2020-10-23 22:40:35.646989
5604	2	10	54	3	\N	2019-04-30	-5000.00	a8ae67a7d91a310d67c643a73cb9d031	2020-10-23 22:40:35.648415	2020-10-23 22:40:35.648415
5605	5	10	54	4	\N	2019-04-30	5000.00	a8ae67a7d91a310d67c643a73cb9d031	2020-10-23 22:40:35.649626	2020-10-23 22:40:35.649626
5606	2	10	54	3	\N	2019-04-30	-500.00	2d535a4fe10f593d8c6a5b35d152604e	2020-10-23 22:40:35.651257	2020-10-23 22:40:35.651257
5607	4	10	54	4	\N	2019-04-30	500.00	2d535a4fe10f593d8c6a5b35d152604e	2020-10-23 22:40:35.652413	2020-10-23 22:40:35.652413
5608	5	9	53	4	\N	2019-05-01	5500.00	25d46895f001766902354a18fba665ee	2020-10-23 22:40:35.653617	2020-10-23 22:40:35.653617
5609	1	10	54	4	\N	2019-05-01	4228.45	03753883dc14bdd53dab5d175abd09f1	2020-10-23 22:40:35.655102	2020-10-23 22:40:35.655102
5610	1	9	51	2	\N	2019-05-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:35.656322	2020-10-23 22:40:35.656322
5611	5	9	53	3	\N	2019-05-01	-7000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.657688	2020-10-23 22:40:35.657688
5612	6	10	54	4	\N	2019-05-01	7000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.658831	2020-10-23 22:40:35.658831
5613	5	4	16	3	\N	2019-05-01	-146.00	67d16d00201083a2b118dd5128dd6f59	2020-10-23 22:40:35.660849	2020-10-23 22:40:35.660849
5614	1	2	-1	4	\N	2019-05-01	146.00	67d16d00201083a2b118dd5128dd6f59	2020-10-23 22:40:35.662474	2020-10-23 22:40:35.662474
5615	5	9	53	3	\N	2019-05-01	-1000.00	cb0d16b06e44c1921c54d9d987a36b85	2020-10-23 22:40:35.663605	2020-10-23 22:40:35.663605
5616	6	10	55	1	\N	2019-05-01	8.17	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:35.664889	2020-10-23 22:40:35.664889
5617	1	9	53	3	\N	2019-05-01	-1000.00	9a6447b2c6197e18e15d289c8f021045	2020-10-23 22:40:35.665943	2020-10-23 22:40:35.665943
5618	1	9	53	3	\N	2019-05-01	-500.00	69e936d7bf29f02c8d4b809619b7596a	2020-10-23 22:40:35.667065	2020-10-23 22:40:35.667065
5619	1	9	53	3	\N	2019-05-01	-500.00	b86e8d03fe992d1b0e19656875ee557c	2020-10-23 22:40:35.668093	2020-10-23 22:40:35.668093
5620	1	9	53	3	\N	2019-05-01	-1000.00	73cee82a78c10273e4ee233c7e822b97	2020-10-23 22:40:35.669301	2020-10-23 22:40:35.669301
5621	5	2	-1	1	\N	2019-04-30	451.00	e7db56dbec713f0510010c6d997d9ddd	2020-10-23 22:40:35.670466	2020-10-23 22:40:35.670466
5622	5	9	-1	1	\N	2019-05-01	44.31	7bd04fa5dbafcb47a21b66b5de1044dd	2020-10-23 22:40:35.671649	2020-10-23 22:40:35.671649
5623	1	8	41	2	\N	2019-05-01	-45.00	335628b154666834079b64e2357c0cfb	2020-10-23 22:40:35.673202	2020-10-23 22:40:35.673202
5624	1	8	41	2	\N	2019-05-01	-14.15	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:35.67436	2020-10-23 22:40:35.67436
5625	1	9	53	3	\N	2019-05-01	-60.00	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:35.67543	2020-10-23 22:40:35.67543
5626	5	2	-1	4	\N	2019-05-01	2500.00	fd9b753b7e10cfca36eacb14fd8c8e59	2020-10-23 22:40:35.677546	2020-10-23 22:40:35.677546
5627	1	1	-1	2	\N	2019-05-01	-110.00	db31dcd832b4a85bf9aeee10dfeddded	2020-10-23 22:40:35.678749	2020-10-23 22:40:35.678749
5628	1	9	48	2	\N	2019-05-02	-200.00	6999d9690e04368d9d49f6ccf1988ddb	2020-10-23 22:40:35.679931	2020-10-23 22:40:35.679931
5629	2	2	-1	1	\N	2019-05-02	200.00	6999d9690e04368d9d49f6ccf1988ddb	2020-10-23 22:40:35.681086	2020-10-23 22:40:35.681086
5630	5	4	13	2	\N	2019-05-02	-209.16	be878df20279a2fedfa0386709d4ecae	2020-10-23 22:40:35.682301	2020-10-23 22:40:35.682301
5631	5	1	-1	2	\N	2019-05-02	-289.27	77bd88627ff6e7949800e96a4324100a	2020-10-23 22:40:35.68343	2020-10-23 22:40:35.68343
5632	5	4	15	2	\N	2019-05-02	-102.00	ae2cef1cbe80fb30a86d4ffd2c2273c1	2020-10-23 22:40:35.684541	2020-10-23 22:40:35.684541
5633	5	4	14	2	\N	2019-05-02	-101.10	7f27f8f0e3023964c4c8619b40450985	2020-10-23 22:40:35.685725	2020-10-23 22:40:35.685725
5634	5	9	-1	2	\N	2019-05-02	-796.00	3b8a614226a953a8cd9526fca6fe9ba5	2020-10-23 22:40:35.687092	2020-10-23 22:40:35.687092
5635	1	1	-1	2	\N	2019-05-02	-1.48	496e05e1aea0a9c4655800e8a7b9ea28	2020-10-23 22:40:35.688173	2020-10-23 22:40:35.688173
5636	1	7	31	2	\N	2019-05-02	-81.00	e0875a7d00226102ef260a579ef5e697	2020-10-23 22:40:35.689553	2020-10-23 22:40:35.689553
5637	5	1	-1	2	\N	2019-05-02	-24.43	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.690617	2020-10-23 22:40:35.690617
5638	5	9	48	2	\N	2019-05-02	-150.00	6c4b761a28b734fe93831e3fb400ce87	2020-10-23 22:40:35.691649	2020-10-23 22:40:35.691649
5639	5	9	53	3	\N	2019-05-03	-250.00	51ef186e18dc00c2d31982567235c559	2020-10-23 22:40:35.692719	2020-10-23 22:40:35.692719
5640	5	1	-1	2	\N	2019-05-04	-50.85	82901154ea5372edea77506d467aa449	2020-10-23 22:40:35.694307	2020-10-23 22:40:35.694307
5641	5	8	43	2	\N	2019-05-04	-254.83	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:35.695832	2020-10-23 22:40:35.695832
5642	6	9	53	3	\N	2019-05-05	-3000.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:35.697483	2020-10-23 22:40:35.697483
5643	5	2	-1	4	\N	2019-05-05	3000.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:35.698764	2020-10-23 22:40:35.698764
5644	1	1	-1	2	\N	2019-05-08	-3.99	f7b6f532b566605cbb9657c243eb7ae6	2020-10-23 22:40:35.699882	2020-10-23 22:40:35.699882
5645	5	4	16	2	\N	2019-05-08	-70.00	5c850ded23bac06021231af66b433a15	2020-10-23 22:40:35.700994	2020-10-23 22:40:35.700994
5646	5	5	25	2	\N	2019-05-08	-50.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:35.702146	2020-10-23 22:40:35.702146
5647	5	1	-1	2	\N	2019-05-08	-155.06	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.703954	2020-10-23 22:40:35.703954
5648	5	1	-1	2	\N	2019-05-08	-7.34	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:35.705317	2020-10-23 22:40:35.705317
5649	2	5	25	2	\N	2019-05-09	-50.00	038cc811e9b1d5f7db675ea49cf420d6	2020-10-23 22:40:35.70648	2020-10-23 22:40:35.70648
5650	2	1	-1	2	\N	2019-05-09	-10.00	3651b231e1426f95130b0b0807c010b0	2020-10-23 22:40:35.707586	2020-10-23 22:40:35.707586
5651	1	9	48	2	\N	2019-05-09	-10.55	1321a07566b34741473743e2e294b5d6	2020-10-23 22:40:35.708726	2020-10-23 22:40:35.708726
5652	1	2	-1	1	\N	2019-05-11	54.00	1b014086a5cf92eb3238d0d45c8c61a4	2020-10-23 22:40:35.709916	2020-10-23 22:40:35.709916
5653	5	1	-1	2	\N	2019-05-12	-19.57	038cc811e9b1d5f7db675ea49cf420d6	2020-10-23 22:40:35.711385	2020-10-23 22:40:35.711385
5654	5	5	23	2	\N	2019-05-11	-26.22	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.712505	2020-10-23 22:40:35.712505
5655	5	1	-1	2	\N	2019-05-11	-364.30	acdb0f57d50aebd6177da497bc17a697	2020-10-23 22:40:35.713607	2020-10-23 22:40:35.713607
5656	5	2	-1	1	\N	2019-05-11	29.99	5487315b1286f907165907aa8fc96619	2020-10-23 22:40:35.71473	2020-10-23 22:40:35.71473
5657	5	2	-1	1	\N	2019-05-11	7.19	5487315b1286f907165907aa8fc96619	2020-10-23 22:40:35.715784	2020-10-23 22:40:35.715784
5658	5	2	-1	1	\N	2019-05-11	50.00	cf988b9b96e028423ec7eee782dc370f	2020-10-23 22:40:35.71691	2020-10-23 22:40:35.71691
5659	5	9	47	2	\N	2019-05-18	-20.00	bf458802928616325f5e4ff7591ca4ff	2020-10-23 22:40:35.718009	2020-10-23 22:40:35.718009
5660	5	1	-1	2	\N	2019-05-17	-55.51	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:35.719208	2020-10-23 22:40:35.719208
5661	5	5	23	2	\N	2019-05-18	-13.90	247863823d87fd906471d6ab4c82c2c0	2020-10-23 22:40:35.720595	2020-10-23 22:40:35.720595
5662	5	1	-1	2	\N	2019-05-18	-41.10	03dec25e5158510aba66cefc9111607a	2020-10-23 22:40:35.721825	2020-10-23 22:40:35.721825
5663	5	1	-1	2	\N	2019-05-19	-10.00	ffc987113c7a22fb2a52b6f9842f79be	2020-10-23 22:40:35.723066	2020-10-23 22:40:35.723066
5664	5	1	-1	2	\N	2019-05-20	-5.56	d58072be2820e8682c0a27c0518e805e	2020-10-23 22:40:35.724517	2020-10-23 22:40:35.724517
5665	5	1	-1	2	\N	2019-05-16	-2.15	274ad4786c3abca69fa097b85867d9a4	2020-10-23 22:40:35.725805	2020-10-23 22:40:35.725805
5666	5	1	-1	2	\N	2019-05-17	-232.22	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:35.727989	2020-10-23 22:40:35.727989
5667	2	1	-1	2	\N	2019-05-15	-14.00	8a367154238900f35cb1872992aa19e4	2020-10-23 22:40:35.729361	2020-10-23 22:40:35.729361
5668	2	4	18	2	\N	2019-05-16	-25.00	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:40:35.730661	2020-10-23 22:40:35.730661
5669	2	9	48	2	\N	2019-05-17	-20.00	52c67bbfbe8e648e977e02db482be943	2020-10-23 22:40:35.731898	2020-10-23 22:40:35.731898
5670	2	6	27	2	\N	2019-05-18	-81.85	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:40:35.73312	2020-10-23 22:40:35.73312
5671	5	9	47	2	\N	2019-05-19	-2000.00	5cc6f084eb251ebdc0d53f15a761554a	2020-10-23 22:40:35.734226	2020-10-23 22:40:35.734226
5672	1	9	53	3	\N	2019-05-26	-20.00	b3e2026d10e46df62f0d1cdfa85d7aaa	2020-10-23 22:40:35.735604	2020-10-23 22:40:35.735604
5673	1	9	49	2	\N	2019-05-26	-195.57	bba309fac5497bbdf844affc666e894e	2020-10-23 22:40:35.737147	2020-10-23 22:40:35.737147
5674	1	1	-1	2	\N	2019-05-26	-15.25	cf5630fcff2945079ba5df0da41deb89	2020-10-23 22:40:35.738781	2020-10-23 22:40:35.738781
5675	1	7	33	2	\N	2019-05-26	-44.20	958f7351e49f8ace660c42794b330479	2020-10-23 22:40:35.740216	2020-10-23 22:40:35.740216
5676	1	1	-1	2	\N	2019-05-26	-3.90	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:35.741724	2020-10-23 22:40:35.741724
5677	1	3	-1	2	\N	2019-05-26	-100.00	74071a673307ca7459bcf75fbd024e09	2020-10-23 22:40:35.743176	2020-10-23 22:40:35.743176
5678	5	9	-1	2	\N	2019-05-26	-20.00	6e3df1e2bccb9e5eea0d1822814ed45f	2020-10-23 22:40:35.744526	2020-10-23 22:40:35.744526
5679	5	1	-1	2	\N	2019-05-26	-38.00	4310e3e7a5890265a915effd565d7992	2020-10-23 22:40:35.745637	2020-10-23 22:40:35.745637
5680	5	1	-1	2	\N	2019-05-26	-10.36	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:35.74709	2020-10-23 22:40:35.74709
5681	5	1	-1	2	\N	2019-05-26	-119.35	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.748366	2020-10-23 22:40:35.748366
5682	5	1	-1	2	\N	2019-05-26	-8.00	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:40:35.749587	2020-10-23 22:40:35.749587
5683	5	1	-1	2	\N	2019-05-26	-12.13	3554b056350eabea4171c518276523e0	2020-10-23 22:40:35.750978	2020-10-23 22:40:35.750978
5684	5	4	16	2	\N	2019-05-26	-49.90	b7ee6f5f9aa5cd17ca1aea43ce848496	2020-10-23 22:40:35.752355	2020-10-23 22:40:35.752355
5685	5	9	50	2	\N	2019-05-26	-7.50	64aaf6814c0d3c75b50b6191ed217748	2020-10-23 22:40:35.753386	2020-10-23 22:40:35.753386
5686	5	1	-1	2	\N	2019-05-26	-3.30	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:40:35.754534	2020-10-23 22:40:35.754534
5687	5	1	-1	2	\N	2019-05-26	-4.50	3c47d78fe7ac0b5edae392453e976c42	2020-10-23 22:40:35.755693	2020-10-23 22:40:35.755693
5688	5	10	54	4	\N	2019-05-28	3000.00	52b5d16f82048cef6fbf24e5f5acfe9b	2020-10-23 22:40:35.756715	2020-10-23 22:40:35.756715
5689	2	2	3	1	\N	2019-05-28	10724.16	474ff659e94a09d2b740bd5967f808f4	2020-10-23 22:40:35.757846	2020-10-23 22:40:35.757846
5690	2	10	54	3	\N	2019-05-30	-500.00	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:40:35.758919	2020-10-23 22:40:35.758919
5691	4	10	54	4	\N	2019-05-30	500.00	f7262416a572be9f413a19c7d6667bf4	2020-10-23 22:40:35.760387	2020-10-23 22:40:35.760387
5692	2	10	54	3	\N	2019-05-30	-8000.00	0320df6b7344edcfeb510595dff01338	2020-10-23 22:40:35.761699	2020-10-23 22:40:35.761699
5693	5	10	54	4	\N	2019-05-30	8000.00	0320df6b7344edcfeb510595dff01338	2020-10-23 22:40:35.762826	2020-10-23 22:40:35.762826
5694	5	4	13	2	\N	2019-05-30	-370.94	54dd11685d504aa2eff075007900b41f	2020-10-23 22:40:35.763962	2020-10-23 22:40:35.763962
5695	5	4	15	2	\N	2019-05-30	-102.00	9186844637c7ca38f5f65a804457d2a0	2020-10-23 22:40:35.765059	2020-10-23 22:40:35.765059
5696	5	4	15	2	\N	2019-05-30	-62.27	7750ca3559e5b8e1f44210283368fc16	2020-10-23 22:40:35.766543	2020-10-23 22:40:35.766543
5697	5	1	-1	2	\N	2019-05-29	-12.34	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:35.767643	2020-10-23 22:40:35.767643
5698	6	10	55	1	\N	2019-06-01	12.82	5b8a7b498ef844e4fe6ad6b57f6ecab7	2020-10-23 22:40:35.768993	2020-10-23 22:40:35.768993
5699	5	2	-1	4	\N	2019-06-01	2500.00	3944b025c9ca7eec3154b44666ae04a0	2020-10-23 22:40:35.770138	2020-10-23 22:40:35.770138
5700	5	9	53	3	\N	2019-06-01	-1000.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:35.7712	2020-10-23 22:40:35.7712
5701	1	10	54	4	\N	2019-06-01	4429.44	60df67c92429bea18195ffa8c7440a81	2020-10-23 22:40:35.77222	2020-10-23 22:40:35.77222
5702	1	9	53	3	\N	2019-06-01	-709.44	3b51e9238820d905967c906f7bac93f8	2020-10-23 22:40:35.773225	2020-10-23 22:40:35.773225
5703	5	10	54	4	\N	2019-06-01	709.44	3b51e9238820d905967c906f7bac93f8	2020-10-23 22:40:35.775052	2020-10-23 22:40:35.775052
5704	1	9	53	3	\N	2019-06-01	-2000.00	9dfd70fdf15a3cb1ea00d7799ac6651b	2020-10-23 22:40:35.776204	2020-10-23 22:40:35.776204
5705	1	9	51	2	\N	2019-06-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:35.777477	2020-10-23 22:40:35.777477
5706	1	9	49	2	\N	2019-06-01	-79.50	da8ce53cf0240070ce6c69c48cd588ee	2020-10-23 22:40:35.778617	2020-10-23 22:40:35.778617
5707	1	9	53	3	\N	2019-06-01	-20.00	e97ee2054defb209c35fe4dc94599061	2020-10-23 22:40:35.780006	2020-10-23 22:40:35.780006
5708	1	1	-1	2	\N	2019-06-01	-14.53	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:35.781216	2020-10-23 22:40:35.781216
5709	1	1	-1	2	\N	2019-06-01	-5.60	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:35.782349	2020-10-23 22:40:35.782349
5710	1	1	-1	2	\N	2019-06-01	-2.20	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:40:35.783483	2020-10-23 22:40:35.783483
5711	1	1	-1	2	\N	2019-06-01	-2.80	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:35.784555	2020-10-23 22:40:35.784555
5712	1	3	-1	2	\N	2019-06-01	-20.00	109a0ca3bc27f3e96597370d5c8cf03d	2020-10-23 22:40:35.785603	2020-10-23 22:40:35.785603
5713	5	1	-1	2	\N	2019-06-01	-19.10	52b7bee83b5f424d63ef78f36db3eaf2	2020-10-23 22:40:35.786805	2020-10-23 22:40:35.786805
5714	5	1	-1	2	\N	2019-06-01	-62.25	52b7bee83b5f424d63ef78f36db3eaf2	2020-10-23 22:40:35.788165	2020-10-23 22:40:35.788165
5715	5	1	-1	2	\N	2019-06-01	-6.00	e7e5c2e2d0fad407a12c0a890c0d0133	2020-10-23 22:40:35.789352	2020-10-23 22:40:35.789352
5716	5	1	-1	2	\N	2019-06-01	-172.50	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.790658	2020-10-23 22:40:35.790658
5717	5	9	48	2	\N	2019-06-01	-219.90	52cdba63fa81f2f0d70663ff29c16b57	2020-10-23 22:40:35.792098	2020-10-23 22:40:35.792098
5718	5	5	23	2	\N	2019-06-01	-42.49	922c556baf6272bffc4fa28b2e9a0bbc	2020-10-23 22:40:35.793461	2020-10-23 22:40:35.793461
5719	5	1	-1	2	\N	2019-06-01	-42.00	3d6cef782694c3ae6de46e04be484f01	2020-10-23 22:40:35.7949	2020-10-23 22:40:35.7949
5720	5	1	-1	2	\N	2019-06-01	-12.95	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.796336	2020-10-23 22:40:35.796336
5721	1	5	21	2	\N	2019-06-01	-62.66	6c972c70b83e631d25ed5c43533df463	2020-10-23 22:40:35.79743	2020-10-23 22:40:35.79743
5722	5	8	43	2	\N	2019-06-01	-243.79	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:35.798584	2020-10-23 22:40:35.798584
5723	5	9	48	2	\N	2019-06-01	-219.48	66808e327dc79d135ba18e051673d906	2020-10-23 22:40:35.799651	2020-10-23 22:40:35.799651
5724	1	2	-1	1	\N	2019-07-01	0.00	ddd40623285c1557a6e2bbc0c7a4252d	2020-10-23 22:40:35.801325	2020-10-23 22:40:35.801325
5725	5	10	54	4	\N	2019-07-01	3500.00	3e7c1c394a8557a57012a9be9bf7b5ef	2020-10-23 22:40:35.802654	2020-10-23 22:40:35.802654
5726	1	10	54	4	\N	2019-07-01	2246.26	68000b5f90a1d5b5b1a93dbb8aa92d3e	2020-10-23 22:40:35.803868	2020-10-23 22:40:35.803868
5727	5	4	13	2	\N	2019-07-02	-377.44	3b32e93540abe1425efa37772407c9bb	2020-10-23 22:40:35.805114	2020-10-23 22:40:35.805114
5728	5	4	15	2	\N	2019-07-02	-102.00	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:35.80628	2020-10-23 22:40:35.80628
5729	5	4	14	2	\N	2019-07-02	-105.39	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:35.807629	2020-10-23 22:40:35.807629
5730	5	1	-1	2	\N	2019-07-02	-50.00	dc72030c78471e298a91e06022fb7662	2020-10-23 22:40:35.808828	2020-10-23 22:40:35.808828
5731	5	10	54	3	\N	2019-07-02	-5000.00	25d46895f001766902354a18fba665ee	2020-10-23 22:40:35.810233	2020-10-23 22:40:35.810233
5732	6	10	54	4	\N	2019-07-02	5000.00	25d46895f001766902354a18fba665ee	2020-10-23 22:40:35.811427	2020-10-23 22:40:35.811427
5733	5	10	54	3	\N	2019-07-02	-500.00	7f17fef8054e554343d7bbca70a3093b	2020-10-23 22:40:35.812453	2020-10-23 22:40:35.812453
5734	1	9	53	3	\N	2019-07-04	-15.00	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:35.813501	2020-10-23 22:40:35.813501
5735	5	2	-1	4	\N	2019-07-04	15.00	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:35.81467	2020-10-23 22:40:35.81467
5736	1	8	41	2	\N	2019-07-02	-45.00	2e65f2f2fdaf6c699b223c61b1b5ab89	2020-10-23 22:40:35.815925	2020-10-23 22:40:35.815925
5737	1	7	36	2	\N	2019-07-02	-18.19	b9c4c0ec0a3bc8870a7307f5a3e3b494	2020-10-23 22:40:35.817454	2020-10-23 22:40:35.817454
5738	1	9	51	2	\N	2019-07-02	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:35.818605	2020-10-23 22:40:35.818605
5739	1	7	36	2	\N	2019-07-02	-197.00	8a3bdaf491ab1aa2f5f8c9e41575f679	2020-10-23 22:40:35.819762	2020-10-23 22:40:35.819762
5740	1	9	53	3	\N	2019-07-02	-1000.00	29e3eb16bfdd864d811e6587f8c297a7	2020-10-23 22:40:35.820921	2020-10-23 22:40:35.820921
5741	5	1	-1	2	\N	2019-07-03	-83.21	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:40:35.822176	2020-10-23 22:40:35.822176
5742	5	9	53	3	\N	2019-07-04	-500.00	8056ac6ddcb0f14b019219391c1159c7	2020-10-23 22:40:35.823563	2020-10-23 22:40:35.823563
5743	5	7	30	2	\N	2019-07-04	-142.00	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:40:35.824787	2020-10-23 22:40:35.824787
5744	2	1	-1	2	\N	2019-07-04	-13.90	64045136e2600e0e784f0a95c3b7ee30	2020-10-23 22:40:35.826008	2020-10-23 22:40:35.826008
5745	2	1	-1	2	\N	2019-07-04	-9.98	85bbf826ee4bc0b1631537bedaf4c258	2020-10-23 22:40:35.827682	2020-10-23 22:40:35.827682
5746	1	9	49	2	\N	2019-07-06	-57.22	79f091e65667e38af3b5834271fe777b	2020-10-23 22:40:35.829157	2020-10-23 22:40:35.829157
5747	5	1	-1	2	\N	2019-07-06	-11.56	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.830625	2020-10-23 22:40:35.830625
5748	5	1	-1	2	\N	2019-07-06	-166.11	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.831753	2020-10-23 22:40:35.831753
5749	5	1	-1	2	\N	2019-07-06	-25.53	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.832854	2020-10-23 22:40:35.832854
5750	5	7	30	2	\N	2019-07-06	-700.00	d725ec04c205e27363daa4fda1f1d5b1	2020-10-23 22:40:35.834026	2020-10-23 22:40:35.834026
5751	5	5	23	2	\N	2019-07-06	-49.98	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:35.835142	2020-10-23 22:40:35.835142
5752	5	9	-1	2	\N	2019-07-06	-6.99	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:40:35.836283	2020-10-23 22:40:35.836283
5753	2	1	-1	2	\N	2019-07-06	-105.00	a8a28fd26702727b6ae0a8fb9acacf59	2020-10-23 22:40:35.837329	2020-10-23 22:40:35.837329
5754	1	1	-1	2	\N	2019-07-08	-11.00	5ea1649a31336092c05438df996a3e59	2020-10-23 22:40:35.838375	2020-10-23 22:40:35.838375
5755	5	4	16	2	\N	2019-07-08	-70.00	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:35.840503	2020-10-23 22:40:35.840503
5756	5	1	-1	2	\N	2019-07-08	-14.00	82aa4b0af34c2313a562076992e50aa3	2020-10-23 22:40:35.841738	2020-10-23 22:40:35.841738
5757	5	1	-1	2	\N	2019-07-08	-1.99	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:35.84325	2020-10-23 22:40:35.84325
5758	5	5	26	2	\N	2019-07-08	-104.23	988549da24fb1ad68244445496c80b52	2020-10-23 22:40:35.844448	2020-10-23 22:40:35.844448
5759	5	1	-1	2	\N	2019-07-08	-45.43	11d6bba7419fc73aea85132de2dc4c6f	2020-10-23 22:40:35.845573	2020-10-23 22:40:35.845573
5760	2	4	16	2	\N	2019-07-12	-37.98	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:35.846768	2020-10-23 22:40:35.846768
5761	5	5	22	2	\N	2019-07-16	-110.00	bc6dc48b743dc5d013b1abaebd2faed2	2020-10-23 22:40:35.847934	2020-10-23 22:40:35.847934
5762	5	1	-1	2	\N	2019-07-16	-13.43	f3180ef260920b1f25543cd89011920a	2020-10-23 22:40:35.849155	2020-10-23 22:40:35.849155
5763	5	1	-1	2	\N	2019-07-16	-10.00	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:40:35.850274	2020-10-23 22:40:35.850274
5764	4	10	54	3	\N	2019-07-16	-2000.00	08cc114579a4fe08771a04496f12612b	2020-10-23 22:40:35.851396	2020-10-23 22:40:35.851396
5765	2	10	54	4	\N	2019-07-16	2000.00	08cc114579a4fe08771a04496f12612b	2020-10-23 22:40:35.852569	2020-10-23 22:40:35.852569
5766	2	4	18	2	\N	2019-07-17	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:35.853753	2020-10-23 22:40:35.853753
5767	5	1	-1	2	\N	2019-07-15	-238.35	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:40:35.854987	2020-10-23 22:40:35.854987
5768	5	1	-1	2	\N	2019-07-15	-6.00	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:35.85619	2020-10-23 22:40:35.85619
5769	5	8	43	2	\N	2019-07-15	-237.90	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:35.857539	2020-10-23 22:40:35.857539
5770	6	10	54	3	\N	2019-07-16	-3000.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:35.85875	2020-10-23 22:40:35.85875
5771	5	10	54	4	\N	2019-07-16	3000.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:35.860662	2020-10-23 22:40:35.860662
5772	5	7	30	2	\N	2019-07-16	-810.28	1fdf93b56e93b40523acc5dd3c7e3b18	2020-10-23 22:40:35.862033	2020-10-23 22:40:35.862033
5773	1	7	30	1	\N	2019-07-16	810.28	1fdf93b56e93b40523acc5dd3c7e3b18	2020-10-23 22:40:35.863171	2020-10-23 22:40:35.863171
5774	5	1	-1	2	\N	2019-07-18	-8.37	9eb28bb6f913083af25ee95deb72ea86	2020-10-23 22:40:35.864293	2020-10-23 22:40:35.864293
5775	5	1	-1	2	\N	2019-07-18	-22.56	bd22982cccc88eef8062aa14eb1d6073	2020-10-23 22:40:35.865656	2020-10-23 22:40:35.865656
5776	5	1	-1	2	\N	2019-07-18	-20.00	860cad7f4fcdf603739ca94379e2f8ef	2020-10-23 22:40:35.866985	2020-10-23 22:40:35.866985
5777	5	5	23	2	\N	2019-07-18	-25.99	b597e5b0e7970deda3d6cf8017b929b7	2020-10-23 22:40:35.86828	2020-10-23 22:40:35.86828
5778	5	1	-1	2	\N	2019-07-18	-3.99	dd982884edf68487cb8ff664b3dfdf12	2020-10-23 22:40:35.869577	2020-10-23 22:40:35.869577
5779	2	4	16	2	\N	2019-07-19	-31.99	f1a333688622b5bc6da3e9c4d2ef76e5	2020-10-23 22:40:35.870808	2020-10-23 22:40:35.870808
5780	5	1	-1	2	\N	2019-07-19	-31.57	bd686fd640be98efaae0091fa301e613	2020-10-23 22:40:35.872058	2020-10-23 22:40:35.872058
5781	5	1	-1	2	\N	2019-07-19	-10.20	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.873199	2020-10-23 22:40:35.873199
5782	2	1	-1	2	\N	2019-07-19	-5.20	19451d0bc375b8010b684753bde99ac8	2020-10-23 22:40:35.874533	2020-10-23 22:40:35.874533
5783	5	1	-1	2	\N	2019-07-19	-13.90	794604517fda2714467ca22ac153b831	2020-10-23 22:40:35.875696	2020-10-23 22:40:35.875696
5784	5	7	36	2	\N	2019-07-19	-44.66	ac112d0832171b2877f63c669bf3d303	2020-10-23 22:40:35.87702	2020-10-23 22:40:35.87702
5785	1	9	53	3	\N	2019-07-19	-47.27	65658fde58ab3c2b6e5132a39fae7cb9	2020-10-23 22:40:35.878371	2020-10-23 22:40:35.878371
5786	1	9	53	3	\N	2019-07-19	-790.00	65658fde58ab3c2b6e5132a39fae7cb9	2020-10-23 22:40:35.879503	2020-10-23 22:40:35.879503
5787	1	2	-1	4	\N	2019-07-19	500.00	d07e70efcfab08731a97e7b91be644de	2020-10-23 22:40:35.880995	2020-10-23 22:40:35.880995
5788	1	7	31	2	\N	2019-07-19	-97.50	8d34201a5b85900908db6cae92723617	2020-10-23 22:40:35.88248	2020-10-23 22:40:35.88248
5789	1	9	49	2	\N	2019-07-19	-67.18	8b3c634880c63335a439fbc2b92a719b	2020-10-23 22:40:35.883818	2020-10-23 22:40:35.883818
5790	1	9	48	2	\N	2019-07-19	-100.00	dc0a093288cc72c6fbadda50e8f62572	2020-10-23 22:40:35.885225	2020-10-23 22:40:35.885225
5791	1	9	49	2	\N	2019-07-19	-629.03	41f1f19176d383480afa65d325c06ed0	2020-10-23 22:40:35.886478	2020-10-23 22:40:35.886478
5792	5	1	-1	2	\N	2019-07-19	-499.34	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:35.887697	2020-10-23 22:40:35.887697
5793	5	1	-1	2	\N	2019-07-19	-1.35	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.888831	2020-10-23 22:40:35.888831
5794	5	9	48	2	\N	2019-07-19	-140.98	eb80b8864bc8a8df368d95cac8ecf372	2020-10-23 22:40:35.88989	2020-10-23 22:40:35.88989
5795	2	9	48	2	\N	2019-07-23	-49.98	61adaa589829c01feb3bf7df563a94c6	2020-10-23 22:40:35.890881	2020-10-23 22:40:35.890881
5796	5	9	48	2	\N	2019-07-23	-39.99	e863bda06ae03910640f9382a6ec7fe6	2020-10-23 22:40:35.89191	2020-10-23 22:40:35.89191
5797	2	5	26	2	\N	2019-07-23	-41.53	e8536def9dd3f9cec97d1b07285ab8f9	2020-10-23 22:40:35.893541	2020-10-23 22:40:35.893541
5798	5	1	-1	2	\N	2019-07-23	-7.48	860e624684b1fc1da4ea84e9fc28fc80	2020-10-23 22:40:35.894872	2020-10-23 22:40:35.894872
5799	5	1	-1	2	\N	2019-07-23	-3.60	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.896114	2020-10-23 22:40:35.896114
5800	2	6	27	2	\N	2019-07-23	-52.96	d750731dae20d00a30eaa4da2473e3ea	2020-10-23 22:40:35.897216	2020-10-23 22:40:35.897216
5801	2	9	-1	1	\N	2019-07-25	29.99	fcbb8a6c7a6eadb3f05b6be8c70e8064	2020-10-23 22:40:35.89826	2020-10-23 22:40:35.89826
5802	2	5	21	2	\N	2019-07-25	-28.27	bf6fac7e14a502c2f0e5a16242d3a9b2	2020-10-23 22:40:35.899277	2020-10-23 22:40:35.899277
5803	5	1	-1	2	\N	2019-07-25	-9.56	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:35.900348	2020-10-23 22:40:35.900348
5804	2	1	-1	2	\N	2019-07-25	-36.00	4e778d14d6c249326754a89d28669096	2020-10-23 22:40:35.901397	2020-10-23 22:40:35.901397
5805	5	4	16	2	\N	2019-07-26	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:35.902497	2020-10-23 22:40:35.902497
5806	2	9	47	2	\N	2019-07-25	-50.00	851ddf5058cf22df63d3344ad89919cf	2020-10-23 22:40:35.903643	2020-10-23 22:40:35.903643
5807	5	1	-1	2	\N	2019-07-29	-9.80	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:35.904817	2020-10-23 22:40:35.904817
5808	5	7	38	2	\N	2019-07-28	-30.00	7f5144f962efde75e0f7661e032166db	2020-10-23 22:40:35.905978	2020-10-23 22:40:35.905978
5809	5	7	38	2	\N	2019-07-28	-26.00	105d2e8ca45f93a6eb40a48fc3447d92	2020-10-23 22:40:35.907356	2020-10-23 22:40:35.907356
5810	5	5	23	2	\N	2019-07-31	-107.73	700df6e8f55dd18a15e3083ba53effc3	2020-10-23 22:40:35.908626	2020-10-23 22:40:35.908626
5811	2	6	27	2	\N	2019-07-31	-29.90	61ba0068c382e4650f86723a001f50f5	2020-10-23 22:40:35.909873	2020-10-23 22:40:35.909873
5812	2	6	27	2	\N	2019-07-31	-64.97	711b11d280c95049e90546804a530030	2020-10-23 22:40:35.911474	2020-10-23 22:40:35.911474
5813	2	2	3	1	\N	2019-07-29	7147.43	228f5bf20ecd035a990b7769ddf48768	2020-10-23 22:40:35.912688	2020-10-23 22:40:35.912688
5814	2	10	54	3	\N	2019-07-29	-4500.00	4af8312f6c544239b2f0346cb1ddb223	2020-10-23 22:40:35.913779	2020-10-23 22:40:35.913779
5815	5	10	54	4	\N	2019-07-29	4500.00	4af8312f6c544239b2f0346cb1ddb223	2020-10-23 22:40:35.914821	2020-10-23 22:40:35.914821
5816	5	1	-1	2	\N	2019-08-01	-214.90	14065fdb806e73e4874d76f6d17e79d9	2020-10-23 22:40:35.915764	2020-10-23 22:40:35.915764
5817	5	5	23	2	\N	2019-08-01	-19.95	ea20a043c08f5168d4409ff4144f32e2	2020-10-23 22:40:35.916754	2020-10-23 22:40:35.916754
5818	5	4	13	2	\N	2019-08-02	-412.74	362842296f8c3370c748838bccf5e9c6	2020-10-23 22:40:35.917822	2020-10-23 22:40:35.917822
5819	5	4	15	2	\N	2019-08-02	-102.00	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:35.918972	2020-10-23 22:40:35.918972
5820	5	10	54	4	\N	2019-08-01	4000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.920105	2020-10-23 22:40:35.920105
5821	1	10	54	4	\N	2019-08-01	3740.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:35.921209	2020-10-23 22:40:35.921209
5822	1	7	36	2	\N	2019-08-01	-60.94	19f3cd308f1455b3fa09a282e0d496f4	2020-10-23 22:40:35.922797	2020-10-23 22:40:35.922797
5823	1	2	-1	3	\N	2019-08-01	-263.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.924061	2020-10-23 22:40:35.924061
5824	1	2	-1	3	\N	2019-08-01	-23.34	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.925589	2020-10-23 22:40:35.925589
5825	5	9	53	3	\N	2019-08-01	-500.00	7bd04fa5dbafcb47a21b66b5de1044dd	2020-10-23 22:40:35.927171	2020-10-23 22:40:35.927171
5826	5	9	53	3	\N	2019-08-01	-4500.00	f3f27a324736617f20abbf2ffd806f6d	2020-10-23 22:40:35.928367	2020-10-23 22:40:35.928367
5827	6	10	54	4	\N	2019-08-01	4500.00	f3f27a324736617f20abbf2ffd806f6d	2020-10-23 22:40:35.929419	2020-10-23 22:40:35.929419
5828	5	2	-1	1	\N	2019-08-01	500.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:35.930504	2020-10-23 22:40:35.930504
5829	5	9	53	3	\N	2019-08-01	-500.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:35.931703	2020-10-23 22:40:35.931703
5830	6	10	55	1	\N	2019-08-01	5.67	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:35.932903	2020-10-23 22:40:35.932903
5831	1	9	53	3	\N	2019-08-01	-3000.00	08f8e0260c64418510cefb2b06eee5cd	2020-10-23 22:40:35.934006	2020-10-23 22:40:35.934006
5832	1	1	-1	2	\N	2019-08-01	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:35.935034	2020-10-23 22:40:35.935034
5833	1	8	41	2	\N	2019-08-01	-45.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:35.936223	2020-10-23 22:40:35.936223
5834	1	9	51	2	\N	2019-08-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:35.937284	2020-10-23 22:40:35.937284
5835	1	1	-1	2	\N	2019-08-01	-190.00	8a8625ece1d74a011a5616629fe94b1f	2020-10-23 22:40:35.938392	2020-10-23 22:40:35.938392
5836	1	1	-1	2	\N	2019-08-01	-4.59	f2d8c578871db7c146c902331a5368fc	2020-10-23 22:40:35.93945	2020-10-23 22:40:35.93945
5837	1	1	-1	2	\N	2019-08-01	-3.99	287e03db1d99e0ec2edb90d079e142f3	2020-10-23 22:40:35.940782	2020-10-23 22:40:35.940782
5838	1	9	-1	2	\N	2019-08-01	-57.00	836e75f43ae8dad727d06f019cae48cf	2020-10-23 22:40:35.942016	2020-10-23 22:40:35.942016
5839	1	1	-1	2	\N	2019-08-01	-8.48	f5224aef157557157154df8302753df9	2020-10-23 22:40:35.943179	2020-10-23 22:40:35.943179
5840	5	1	-1	2	\N	2019-08-01	-2.49	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:35.944442	2020-10-23 22:40:35.944442
5841	5	1	-1	2	\N	2019-08-01	-151.69	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.945662	2020-10-23 22:40:35.945662
5842	1	9	53	3	\N	2019-08-01	-30.00	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:40:35.946868	2020-10-23 22:40:35.946868
5843	5	2	-1	4	\N	2019-08-01	30.00	74ad3db0ea146ab342bf50a4f4bc19b7	2020-10-23 22:40:35.948182	2020-10-23 22:40:35.948182
5844	5	1	-1	2	\N	2019-08-01	-8.73	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.949461	2020-10-23 22:40:35.949461
5845	5	9	-1	2	\N	2019-08-01	-21.27	d53a7800f1c72cbc52e64eeb6d2732b2	2020-10-23 22:40:35.950805	2020-10-23 22:40:35.950805
5846	1	2	-1	1	\N	2019-08-02	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:35.952452	2020-10-23 22:40:35.952452
5847	5	9	53	3	\N	2019-08-04	-200.00	e6a1914efe78d4ce1d680933a8adee5c	2020-10-23 22:40:35.953661	2020-10-23 22:40:35.953661
5848	5	1	-1	2	\N	2019-08-05	-62.87	004f2da97091f78e4b8b4f669aebc912	2020-10-23 22:40:35.954902	2020-10-23 22:40:35.954902
5849	5	8	43	2	\N	2019-08-05	-195.18	4b6ab9ccb0321722d887f9f603233841	2020-10-23 22:40:35.956166	2020-10-23 22:40:35.956166
5850	2	9	47	2	\N	2019-08-06	-50.00	8f468c873a32bb0619eaeb2050ba45d1	2020-10-23 22:40:35.957409	2020-10-23 22:40:35.957409
5851	1	9	53	3	\N	2019-08-06	-200.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:35.959084	2020-10-23 22:40:35.959084
5852	1	1	-1	2	\N	2019-08-09	-6.99	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:40:35.961247	2020-10-23 22:40:35.961247
5853	1	1	11	2	\N	2019-08-09	-11.00	f828edc20051679939b205229f41e729	2020-10-23 22:40:35.962794	2020-10-23 22:40:35.962794
5854	1	1	-1	2	\N	2019-08-08	-18.02	42649b640f1e5fc1bfb3069dbb00813b	2020-10-23 22:40:35.964435	2020-10-23 22:40:35.964435
5855	1	1	-1	2	\N	2019-08-06	-3.00	46227bd4985512298d53eac3707b3c68	2020-10-23 22:40:35.965821	2020-10-23 22:40:35.965821
5856	1	1	-1	2	\N	2019-08-06	-16.86	7634ea65a4e6d9041cfd3f7de18e334a	2020-10-23 22:40:35.967041	2020-10-23 22:40:35.967041
5857	5	1	-1	2	\N	2019-08-09	-11.59	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.968107	2020-10-23 22:40:35.968107
5858	5	1	-1	2	\N	2019-08-09	-170.53	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:35.969141	2020-10-23 22:40:35.969141
5859	5	4	17	2	\N	2019-08-11	-479.00	5072d348b267983ddc0786d821c3fe32	2020-10-23 22:40:35.97015	2020-10-23 22:40:35.97015
5860	5	4	17	2	\N	2019-08-11	-226.00	210943091c538d2640b1e8ad9a95e694	2020-10-23 22:40:35.971249	2020-10-23 22:40:35.971249
5861	5	2	-1	1	\N	2019-08-11	22.44	887ad370e29a0f99e5ce1394a9e7e7ee	2020-10-23 22:40:35.972535	2020-10-23 22:40:35.972535
5862	5	2	-1	1	\N	2019-08-11	6.99	887ad370e29a0f99e5ce1394a9e7e7ee	2020-10-23 22:40:35.973792	2020-10-23 22:40:35.973792
5863	5	4	16	2	\N	2019-08-06	-70.00	0c415b72b97c5c9feba343416ec8a2a7	2020-10-23 22:40:35.975124	2020-10-23 22:40:35.975124
5864	5	9	48	2	\N	2019-08-06	-100.00	18997733ec258a9fcaf239cc55d53363	2020-10-23 22:40:35.97773	2020-10-23 22:40:35.97773
5865	5	1	-1	2	\N	2019-08-16	-210.30	329f96e8c09d79abd767f696183d7dfa	2020-10-23 22:40:35.979219	2020-10-23 22:40:35.979219
5866	5	1	-1	2	\N	2019-08-16	-4.00	46227bd4985512298d53eac3707b3c68	2020-10-23 22:40:35.980505	2020-10-23 22:40:35.980505
5867	5	1	-1	2	\N	2019-08-16	-5.73	633d8ed2e4a7f07c8419f2678a0f1ca3	2020-10-23 22:40:35.981764	2020-10-23 22:40:35.981764
5868	5	7	39	2	\N	2019-08-16	-11.00	b04217ced107df851e2715c57328f4af	2020-10-23 22:40:35.982832	2020-10-23 22:40:35.982832
5869	5	7	39	2	\N	2019-08-16	-24.00	5eced9718393c2cb55df6759c5084de2	2020-10-23 22:40:35.983833	2020-10-23 22:40:35.983833
5870	5	7	38	2	\N	2019-08-15	-62.00	f65c21785488c23001a9a39a7c199cc0	2020-10-23 22:40:35.984831	2020-10-23 22:40:35.984831
5871	5	1	-1	2	\N	2019-08-15	-19.96	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:35.98588	2020-10-23 22:40:35.98588
5872	5	1	-1	2	\N	2019-08-14	-170.86	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:35.98717	2020-10-23 22:40:35.98717
5873	5	1	-1	2	\N	2019-08-14	-3.00	46227bd4985512298d53eac3707b3c68	2020-10-23 22:40:35.988253	2020-10-23 22:40:35.988253
5874	5	1	-1	2	\N	2019-08-12	-4.08	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:35.989392	2020-10-23 22:40:35.989392
5875	5	8	43	2	\N	2019-08-12	-246.05	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:35.990524	2020-10-23 22:40:35.990524
5876	1	9	53	3	\N	2019-08-16	-30.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:35.991661	2020-10-23 22:40:35.991661
5877	1	7	35	2	\N	2019-08-17	-199.00	dbe862ab956bf427794f823487d61816	2020-10-23 22:40:35.992703	2020-10-23 22:40:35.992703
5878	1	1	-1	2	\N	2019-08-15	-1.39	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:35.993898	2020-10-23 22:40:35.993898
5879	1	9	49	2	\N	2019-08-14	-35.67	bba309fac5497bbdf844affc666e894e	2020-10-23 22:40:35.995111	2020-10-23 22:40:35.995111
5880	1	9	49	2	\N	2019-08-14	-37.99	1d70cd01b957710c5cd1c7422f604f06	2020-10-23 22:40:35.996348	2020-10-23 22:40:35.996348
5881	1	9	49	2	\N	2019-08-14	-49.64	5705e1164a8394aace6018e27d20d237	2020-10-23 22:40:35.997431	2020-10-23 22:40:35.997431
5882	1	9	49	2	\N	2019-08-14	-259.38	ea374832adce7bfea33f3dd1728a6611	2020-10-23 22:40:35.998682	2020-10-23 22:40:35.998682
5883	1	2	-1	4	\N	2019-08-14	1500.00	c4de9fe96832a877668d0dced80657b8	2020-10-23 22:40:35.999979	2020-10-23 22:40:35.999979
5884	5	2	-1	4	\N	2019-08-18	1800.00	cfbce4c1d7c425baf21d6b6f2babe6be	2020-10-23 22:40:36.001232	2020-10-23 22:40:36.001232
5885	1	9	48	2	\N	2019-08-18	-150.00	ad71b715717f7e4757565373c1a88e1f	2020-10-23 22:40:36.002417	2020-10-23 22:40:36.002417
5886	1	1	-1	2	\N	2019-08-18	-162.00	898a87d1176aabe8f6afd67c7afb5cb0	2020-10-23 22:40:36.00382	2020-10-23 22:40:36.00382
5887	5	7	30	2	\N	2019-08-18	-580.25	cc658eb212161d41f74e015d38e0cba9	2020-10-23 22:40:36.004949	2020-10-23 22:40:36.004949
5888	2	6	27	2	\N	2019-08-17	-75.50	a9f05953ecfdece37960c0a531627f36	2020-10-23 22:40:36.006157	2020-10-23 22:40:36.006157
5889	2	6	27	2	\N	2019-08-17	-169.97	f7ba755c736f384e67833dfd65ecba31	2020-10-23 22:40:36.007257	2020-10-23 22:40:36.007257
5890	2	5	21	2	\N	2019-08-13	-13.59	c75b6f114c23a4d7ea11331e7c00e73c	2020-10-23 22:40:36.008265	2020-10-23 22:40:36.008265
5891	2	4	18	2	\N	2019-08-14	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:36.009281	2020-10-23 22:40:36.009281
5892	2	9	48	1	\N	2019-08-14	150.00	eb163727917cbba1eea208541a643e74	2020-10-23 22:40:36.010592	2020-10-23 22:40:36.010592
5893	2	10	54	3	\N	2019-08-10	-500.00	368f787b78264ed0b3316a61dd0ccbf2	2020-10-23 22:40:36.011954	2020-10-23 22:40:36.011954
5894	4	10	54	4	\N	2019-08-10	500.00	368f787b78264ed0b3316a61dd0ccbf2	2020-10-23 22:40:36.013152	2020-10-23 22:40:36.013152
5895	5	5	23	2	\N	2019-08-19	-72.14	d4c659b3b005793e2fc12a983318d23e	2020-10-23 22:40:36.014364	2020-10-23 22:40:36.014364
5896	2	1	-1	2	\N	2019-08-20	-16.00	55c86dd42f088b5f7d434e7bab282e63	2020-10-23 22:40:36.015551	2020-10-23 22:40:36.015551
5897	2	6	27	2	\N	2019-08-20	-13.00	0ba83ef039e82784e1d9cec03d72f256	2020-10-23 22:40:36.016832	2020-10-23 22:40:36.016832
5898	5	1	-1	2	\N	2019-08-20	-7.70	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:36.018329	2020-10-23 22:40:36.018329
5899	5	1	-1	2	\N	2019-08-21	-22.22	b3e3e393c77e35a4a3f3cbd1e429b5dc	2020-10-23 22:40:36.019614	2020-10-23 22:40:36.019614
5900	1	9	53	3	\N	2019-08-23	-25.80	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.02096	2020-10-23 22:40:36.02096
5901	1	5	21	2	\N	2019-08-20	-65.35	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:36.022537	2020-10-23 22:40:36.022537
5902	1	5	25	2	\N	2019-08-20	-50.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:36.023761	2020-10-23 22:40:36.023761
5903	1	1	-1	2	\N	2019-08-21	-39.00	c35121d7636aba8b6ad47c4561469a16	2020-10-23 22:40:36.02504	2020-10-23 22:40:36.02504
5904	1	3	-1	2	\N	2019-08-20	-43.00	db780008ffa192e7447f125de2ccdbe2	2020-10-23 22:40:36.026412	2020-10-23 22:40:36.026412
5905	1	1	-1	2	\N	2019-08-20	-30.00	633d8ed2e4a7f07c8419f2678a0f1ca3	2020-10-23 22:40:36.027686	2020-10-23 22:40:36.027686
5906	1	9	49	2	\N	2019-08-20	-197.00	64771a8f2e4276f55219ad0e3faa4140	2020-10-23 22:40:36.028867	2020-10-23 22:40:36.028867
5907	5	1	-1	2	\N	2019-08-24	-53.04	05b980fd14414110790904f87051f9e9	2020-10-23 22:40:36.030091	2020-10-23 22:40:36.030091
5908	5	8	43	2	\N	2019-08-23	-233.81	dd770d3392932ac08ff1184c966108fe	2020-10-23 22:40:36.031232	2020-10-23 22:40:36.031232
5909	5	4	16	2	\N	2019-08-23	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:36.032278	2020-10-23 22:40:36.032278
5910	2	9	47	2	\N	2019-08-26	-50.00	0e85d79a6f9cf7a02539c86bf11563c3	2020-10-23 22:40:36.033338	2020-10-23 22:40:36.033338
5911	2	4	16	2	\N	2019-08-27	-30.30	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:36.034356	2020-10-23 22:40:36.034356
5912	2	1	-1	2	\N	2019-08-23	-13.90	4eb30f049b1f69543e589bc855dd91f8	2020-10-23 22:40:36.035368	2020-10-23 22:40:36.035368
5913	5	1	-1	2	\N	2019-08-28	-139.63	81448138f5f163ccdba4acc69819f280	2020-10-23 22:40:36.036507	2020-10-23 22:40:36.036507
5914	5	1	-1	2	\N	2019-08-27	-10.20	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.037689	2020-10-23 22:40:36.037689
5915	5	1	11	2	\N	2019-08-27	-20.40	f828edc20051679939b205229f41e729	2020-10-23 22:40:36.038754	2020-10-23 22:40:36.038754
5916	2	2	3	1	\N	2019-08-28	10294.99	45f02740b1a245d2282be9e81dd82db3	2020-10-23 22:40:36.040056	2020-10-23 22:40:36.040056
5917	2	10	54	3	\N	2019-08-28	-1500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.041602	2020-10-23 22:40:36.041602
5918	4	10	54	4	\N	2019-08-28	1500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.042795	2020-10-23 22:40:36.042795
5919	2	10	54	3	\N	2019-08-28	-800.00	a91f7d0f27f3c35bd2692c05876cc13f	2020-10-23 22:40:36.044462	2020-10-23 22:40:36.044462
5920	2	10	54	3	\N	2019-08-28	-6000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:36.045697	2020-10-23 22:40:36.045697
5921	5	10	54	4	\N	2019-08-28	6000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:36.046761	2020-10-23 22:40:36.046761
5922	5	10	54	3	\N	2019-08-28	-2500.00	682670d9ab0aaa4dc01895a59aa8f91b	2020-10-23 22:40:36.047779	2020-10-23 22:40:36.047779
5923	6	10	54	4	\N	2019-08-28	2500.00	682670d9ab0aaa4dc01895a59aa8f91b	2020-10-23 22:40:36.048898	2020-10-23 22:40:36.048898
5924	5	5	23	2	\N	2019-08-28	-23.98	ea20a043c08f5168d4409ff4144f32e2	2020-10-23 22:40:36.050126	2020-10-23 22:40:36.050126
5925	5	5	26	2	\N	2019-08-28	-13.99	4c70ddf151e7a4b6e8de341ce777efdb	2020-10-23 22:40:36.051301	2020-10-23 22:40:36.051301
5926	5	5	23	2	\N	2019-08-28	-10.38	cedebb6e872f539bef8c3f919874e9d7	2020-10-23 22:40:36.052587	2020-10-23 22:40:36.052587
5927	2	8	44	2	\N	2019-08-28	-15.95	8c70fffcd96f48b4932ba47fb2346a42	2020-10-23 22:40:36.054725	2020-10-23 22:40:36.054725
5928	2	1	-1	2	\N	2019-08-28	-35.00	2b03a11699c62b969e1636e984d056db	2020-10-23 22:40:36.056327	2020-10-23 22:40:36.056327
5929	2	5	23	1	\N	2019-08-29	202.17	854d9fca60b4bd07f9bb215d59ef5561	2020-10-23 22:40:36.057752	2020-10-23 22:40:36.057752
5930	5	5	23	1	\N	2019-08-29	7.00	2f404348efdd07119956bd6a6011978c	2020-10-23 22:40:36.059485	2020-10-23 22:40:36.059485
5931	5	1	-1	2	\N	2019-08-30	-34.66	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:36.061211	2020-10-23 22:40:36.061211
5932	5	4	13	2	\N	2019-08-30	-392.95	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:36.062385	2020-10-23 22:40:36.062385
5933	5	4	14	2	\N	2019-08-30	-103.26	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:36.063515	2020-10-23 22:40:36.063515
5934	5	4	14	2	\N	2019-08-30	-58.59	b6f0479ae87d244975439c6124592772	2020-10-23 22:40:36.065044	2020-10-23 22:40:36.065044
5935	5	10	54	4	\N	2019-08-30	5000.00	3e7c1c394a8557a57012a9be9bf7b5ef	2020-10-23 22:40:36.066267	2020-10-23 22:40:36.066267
5936	1	10	54	4	\N	2019-08-30	3596.39	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:36.067545	2020-10-23 22:40:36.067545
5937	1	9	51	2	\N	2019-08-30	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:36.068742	2020-10-23 22:40:36.068742
5938	1	9	53	3	\N	2019-08-30	-88.00	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:36.06999	2020-10-23 22:40:36.06999
5939	1	9	53	3	\N	2019-08-30	-1500.00	3cf166c6b73f030b4f67eeaeba301103	2020-10-23 22:40:36.071462	2020-10-23 22:40:36.071462
5940	1	8	41	2	\N	2019-08-30	-45.00	80e604705d0b23ddd6544f2e424feca1	2020-10-23 22:40:36.072736	2020-10-23 22:40:36.072736
5941	1	9	53	3	\N	2019-08-30	-500.00	b19ecf34e19dc5a67d9aa76728133e59	2020-10-23 22:40:36.074024	2020-10-23 22:40:36.074024
5942	1	1	-1	2	\N	2019-08-30	-17.40	42f28ef602b7e4a83629779eff5e75ff	2020-10-23 22:40:36.075078	2020-10-23 22:40:36.075078
5943	6	10	55	1	\N	2019-08-31	9.49	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:36.076234	2020-10-23 22:40:36.076234
5944	5	1	-1	2	\N	2019-09-01	-16.00	868f4a79ecb69df929cc0f70c33c5a3c	2020-10-23 22:40:36.07744	2020-10-23 22:40:36.07744
5945	5	9	53	3	\N	2019-09-01	-4000.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.078527	2020-10-23 22:40:36.078527
5946	6	10	54	4	\N	2019-09-01	4000.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.079557	2020-10-23 22:40:36.079557
5947	5	9	53	3	\N	2019-09-01	-500.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:36.080689	2020-10-23 22:40:36.080689
5948	5	1	-1	2	\N	2019-09-01	-17.96	45498335438b9a1365147894cd8636af	2020-10-23 22:40:36.081949	2020-10-23 22:40:36.081949
5949	5	1	-1	2	\N	2019-09-01	-450.47	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:36.083368	2020-10-23 22:40:36.083368
5950	1	9	53	3	\N	2019-09-01	-360.98	4fac9ba115140ac4f1c22da82aa0bc7f	2020-10-23 22:40:36.084675	2020-10-23 22:40:36.084675
5951	5	2	-1	4	\N	2019-09-01	360.98	4fac9ba115140ac4f1c22da82aa0bc7f	2020-10-23 22:40:36.086	2020-10-23 22:40:36.086
5952	1	2	3	1	\N	2019-09-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:36.08743	2020-10-23 22:40:36.08743
5953	1	7	36	2	\N	2019-09-01	-112.36	ca8155f4d27f205953f9d3d7974bdd70	2020-10-23 22:40:36.088571	2020-10-23 22:40:36.088571
5954	1	7	36	2	\N	2019-09-01	-40.65	ca8155f4d27f205953f9d3d7974bdd70	2020-10-23 22:40:36.089676	2020-10-23 22:40:36.089676
5955	2	5	26	2	\N	2019-09-02	-20.98	42e77b63637ab381e8be5f8318cc28a2	2020-10-23 22:40:36.090758	2020-10-23 22:40:36.090758
5956	2	9	48	2	\N	2019-09-02	-18.40	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:40:36.091806	2020-10-23 22:40:36.091806
5957	2	1	-1	2	\N	2019-09-02	-1.99	c630dd16135d2a82b0518e1cd3b5d36f	2020-10-23 22:40:36.092905	2020-10-23 22:40:36.092905
5958	5	9	48	2	\N	2019-09-02	-72.32	b1eec33c726a60554bc78518d5f9b32c	2020-10-23 22:40:36.094295	2020-10-23 22:40:36.094295
5959	2	8	41	2	\N	2019-09-02	-50.00	063d17063d336710235a9e87924f5803	2020-10-23 22:40:36.095503	2020-10-23 22:40:36.095503
5960	5	4	15	2	\N	2019-09-02	-306.93	441954d29ad2a375cef8ea524a2c7e73	2020-10-23 22:40:36.096618	2020-10-23 22:40:36.096618
5961	5	9	47	2	\N	2019-09-02	-20.00	45dcf90898324c08ca6a041ba8f8684c	2020-10-23 22:40:36.097741	2020-10-23 22:40:36.097741
5962	5	7	32	2	\N	2019-09-03	-101.78	dae00a99f4e5f91349f81eaef529e133	2020-10-23 22:40:36.098806	2020-10-23 22:40:36.098806
5963	5	10	54	3	\N	2019-09-03	-2500.00	4911e516e5aa21d327512e0c8b197616	2020-10-23 22:40:36.099937	2020-10-23 22:40:36.099937
5964	5	1	-1	2	\N	2019-09-04	-5.40	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.101136	2020-10-23 22:40:36.101136
5965	5	1	-1	2	\N	2019-09-05	-268.29	8806015d8104aa7fad5b98db8e29812c	2020-10-23 22:40:36.102521	2020-10-23 22:40:36.102521
5966	5	1	-1	2	\N	2019-09-05	-43.88	ea6f96d684fcea2caa82e4e262810723	2020-10-23 22:40:36.103743	2020-10-23 22:40:36.103743
5967	2	1	-1	3	\N	2019-09-06	-200.00	217eedd1ba8c592db97d0dbe54c7adfc	2020-10-23 22:40:36.104825	2020-10-23 22:40:36.104825
5968	5	1	-1	4	\N	2019-09-06	200.00	217eedd1ba8c592db97d0dbe54c7adfc	2020-10-23 22:40:36.105947	2020-10-23 22:40:36.105947
5969	5	8	43	2	\N	2019-09-06	-245.64	151f9002fb3c303ea3851145a4aee019	2020-10-23 22:40:36.107191	2020-10-23 22:40:36.107191
5970	5	9	47	2	\N	2019-09-06	-40.00	e6d847d396d27a844f169a7798df228c	2020-10-23 22:40:36.108374	2020-10-23 22:40:36.108374
5971	5	9	48	2	\N	2019-09-07	-34.99	e6d847d396d27a844f169a7798df228c	2020-10-23 22:40:36.11068	2020-10-23 22:40:36.11068
5972	5	1	-1	2	\N	2019-09-07	-99.02	82901154ea5372edea77506d467aa449	2020-10-23 22:40:36.111949	2020-10-23 22:40:36.111949
5973	1	9	53	3	\N	2019-09-07	-40.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:36.113096	2020-10-23 22:40:36.113096
5974	5	2	-1	4	\N	2019-09-07	40.00	705f2172834666788607efbfca35afb3	2020-10-23 22:40:36.114205	2020-10-23 22:40:36.114205
5975	5	4	16	2	\N	2019-09-07	-70.00	b19ecf34e19dc5a67d9aa76728133e59	2020-10-23 22:40:36.115585	2020-10-23 22:40:36.115585
5976	5	1	-1	2	\N	2019-09-07	-6.80	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:36.116608	2020-10-23 22:40:36.116608
5977	1	9	53	3	\N	2019-09-07	-71.91	6d5c286b445a88593080b20149758efa	2020-10-23 22:40:36.11763	2020-10-23 22:40:36.11763
5978	1	2	-1	1	\N	2019-09-08	46.20	5544c39c40833ed5de0fc2a596d567ca	2020-10-23 22:40:36.118687	2020-10-23 22:40:36.118687
5979	1	1	-1	2	\N	2019-09-08	-14.00	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:40:36.119848	2020-10-23 22:40:36.119848
5980	1	1	-1	2	\N	2019-09-08	-2.80	d3c8a0832878a5e1d4e873e57b7f4238	2020-10-23 22:40:36.121011	2020-10-23 22:40:36.121011
5981	1	9	53	3	\N	2019-09-04	-60.99	6d5c286b445a88593080b20149758efa	2020-10-23 22:40:36.12228	2020-10-23 22:40:36.12228
5982	1	9	53	3	\N	2019-09-08	-200.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.123591	2020-10-23 22:40:36.123591
5983	2	9	48	2	\N	2019-09-07	-7.99	df6d2338b2b8fce1ec2f6dda0a630eb0	2020-10-23 22:40:36.124921	2020-10-23 22:40:36.124921
5984	5	1	-1	2	\N	2019-09-10	-8.73	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.12638	2020-10-23 22:40:36.12638
5985	2	9	51	2	\N	2019-09-11	-100.00	2d14a3064b032e8e9b7692cbc10ca4de	2020-10-23 22:40:36.127622	2020-10-23 22:40:36.127622
5986	5	5	23	2	\N	2019-09-11	-16.65	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:36.128818	2020-10-23 22:40:36.128818
5987	5	1	-1	2	\N	2019-09-12	-2.00	087408522c31eeb1f982bc0eaf81d35f	2020-10-23 22:40:36.130498	2020-10-23 22:40:36.130498
5988	5	1	-1	2	\N	2019-09-12	-8.94	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:36.131597	2020-10-23 22:40:36.131597
5989	5	5	23	2	\N	2019-09-12	-32.97	9be40cee5b0eee1462c82c6964087ff9	2020-10-23 22:40:36.13304	2020-10-23 22:40:36.13304
5990	2	6	27	2	\N	2019-09-12	-14.00	c2f7ab46df3db842040a86a0897a5377	2020-10-23 22:40:36.134518	2020-10-23 22:40:36.134518
5991	5	1	-1	2	\N	2019-09-12	-80.31	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.135758	2020-10-23 22:40:36.135758
5992	2	4	18	2	\N	2019-09-12	-25.00	b16ca745ad43b243f09726e9138577e3	2020-10-23 22:40:36.137139	2020-10-23 22:40:36.137139
5993	5	1	-1	2	\N	2019-09-16	-12.40	9013713c3b217945fe8bc4ec3bd2d436	2020-10-23 22:40:36.138669	2020-10-23 22:40:36.138669
5994	5	8	43	2	\N	2019-09-15	-36.20	a36084f1119b4e3d9143b303baec52c2	2020-10-23 22:40:36.139965	2020-10-23 22:40:36.139965
5995	5	8	43	2	\N	2019-09-15	-189.38	f5f8590cd58a54e94377e6ae2eded4d9	2020-10-23 22:40:36.141259	2020-10-23 22:40:36.141259
5996	5	8	43	2	\N	2019-09-14	-36.20	4311359ed4969e8401880e3c1836fbe1	2020-10-23 22:40:36.142257	2020-10-23 22:40:36.142257
5997	1	7	35	2	\N	2019-09-13	-19.96	56c968ba413527105d0ab942f3363a9e	2020-10-23 22:40:36.143569	2020-10-23 22:40:36.143569
5998	1	8	41	2	\N	2019-09-11	-30.57	2de5d71b613907737f26c793998e88d9	2020-10-23 22:40:36.144808	2020-10-23 22:40:36.144808
5999	1	9	49	2	\N	2019-09-11	-489.53	80c26d6ab0295160b8ad123b86c9ad53	2020-10-23 22:40:36.146027	2020-10-23 22:40:36.146027
6000	5	9	-1	3	\N	2019-09-16	-200.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:36.147449	2020-10-23 22:40:36.147449
6001	2	9	-1	4	\N	2019-09-16	200.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:36.148678	2020-10-23 22:40:36.148678
6002	2	4	16	2	\N	2019-09-16	-29.99	0362fec4071e4b32b890e937551fcf46	2020-10-23 22:40:36.149775	2020-10-23 22:40:36.149775
6003	4	9	-1	3	\N	2019-09-17	-500.00	b401e52c2c6faf9a5898627c5c4c4d7d	2020-10-23 22:40:36.150932	2020-10-23 22:40:36.150932
6004	2	9	-1	4	\N	2019-09-17	500.00	b401e52c2c6faf9a5898627c5c4c4d7d	2020-10-23 22:40:36.152228	2020-10-23 22:40:36.152228
6005	2	8	44	2	\N	2019-09-16	-4.50	a4dbd8c75d709fe2c0d94c3eb7817f48	2020-10-23 22:40:36.153539	2020-10-23 22:40:36.153539
6006	5	5	26	3	\N	2019-09-17	-37.43	441954d29ad2a375cef8ea524a2c7e73	2020-10-23 22:40:36.154644	2020-10-23 22:40:36.154644
6007	2	5	26	4	\N	2019-09-17	37.43	441954d29ad2a375cef8ea524a2c7e73	2020-10-23 22:40:36.155674	2020-10-23 22:40:36.155674
6008	2	9	-1	2	\N	2019-09-17	-2.90	b4c0c84c7057348e020770ca973e668c	2020-10-23 22:40:36.156658	2020-10-23 22:40:36.156658
6009	5	1	-1	2	\N	2019-09-17	-14.59	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:40:36.157881	2020-10-23 22:40:36.157881
6010	2	1	-1	2	\N	2019-09-21	-46.74	c6c3956ac99102230b94411b28613345	2020-10-23 22:40:36.159155	2020-10-23 22:40:36.159155
6011	1	4	18	2	\N	2019-09-21	-1.00	c22abfa379f38b5b0411bc11fa9bf92f	2020-10-23 22:40:36.16056	2020-10-23 22:40:36.16056
6012	1	8	42	2	\N	2019-09-20	-98.00	357b6f7587a9cb5d0f97659b50424922	2020-10-23 22:40:36.161709	2020-10-23 22:40:36.161709
6013	5	10	54	4	\N	2019-09-27	500.00	69421f032498c97020180038fddb8e24	2020-10-23 22:40:36.162745	2020-10-23 22:40:36.162745
6014	6	9	53	3	\N	2019-09-20	-2000.00	af4736081305537c98a3d5771c0c2f85	2020-10-23 22:40:36.163839	2020-10-23 22:40:36.163839
6015	5	2	-1	4	\N	2019-09-20	2000.00	af4736081305537c98a3d5771c0c2f85	2020-10-23 22:40:36.164936	2020-10-23 22:40:36.164936
6016	5	1	-1	2	\N	2019-09-27	-70.32	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.165989	2020-10-23 22:40:36.165989
6017	5	1	-1	2	\N	2019-09-27	-3.49	c947c450b7f3d9d07b0e747712cee8c6	2020-10-23 22:40:36.167056	2020-10-23 22:40:36.167056
6018	5	1	-1	2	\N	2019-09-28	-81.54	c6c3956ac99102230b94411b28613345	2020-10-23 22:40:36.168031	2020-10-23 22:40:36.168031
6019	2	9	53	3	\N	2019-09-26	-64.47	3cb5c81480a83ab9e47c60fa2b86e404	2020-10-23 22:40:36.169059	2020-10-23 22:40:36.169059
6020	5	9	53	4	\N	2019-09-26	64.47	3cb5c81480a83ab9e47c60fa2b86e404	2020-10-23 22:40:36.170292	2020-10-23 22:40:36.170292
6021	5	7	30	2	\N	2019-09-29	-1468.80	1595af6435015c77a7149e92a551338e	2020-10-23 22:40:36.171605	2020-10-23 22:40:36.171605
6022	5	1	-1	2	\N	2019-09-23	-104.89	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:36.172925	2020-10-23 22:40:36.172925
6023	5	1	-1	2	\N	2019-09-21	-6.56	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:40:36.174132	2020-10-23 22:40:36.174132
6024	2	9	-1	2	\N	2019-09-26	-100.00	a2316974230c2b19e989071e521b9b93	2020-10-23 22:40:36.175737	2020-10-23 22:40:36.175737
6025	2	6	27	2	\N	2019-09-26	-139.99	28ec7098ba29ee707ae609e87ea857f0	2020-10-23 22:40:36.177155	2020-10-23 22:40:36.177155
6026	2	2	3	1	\N	2019-09-26	5422.54	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:40:36.17855	2020-10-23 22:40:36.17855
6027	2	10	54	3	\N	2019-09-28	-3000.00	7a9a0010088783883f564db65f66c88d	2020-10-23 22:40:36.179689	2020-10-23 22:40:36.179689
6028	5	10	54	4	\N	2019-09-28	3000.00	7a9a0010088783883f564db65f66c88d	2020-10-23 22:40:36.180771	2020-10-23 22:40:36.180771
6029	5	9	53	3	\N	2019-09-28	-277.20	525b5a44998bc501be69d1f148861a78	2020-10-23 22:40:36.182178	2020-10-23 22:40:36.182178
6030	2	9	53	4	\N	2019-09-28	277.20	525b5a44998bc501be69d1f148861a78	2020-10-23 22:40:36.18346	2020-10-23 22:40:36.18346
6031	5	4	13	2	\N	2019-09-28	-392.95	1772c7ee061e403943a88f11bcef8149	2020-10-23 22:40:36.184731	2020-10-23 22:40:36.184731
6032	5	4	16	2	\N	2019-09-28	-49.90	1c4f698b042f3fb1c79fda5fc205f50c	2020-10-23 22:40:36.185938	2020-10-23 22:40:36.185938
6033	5	1	-1	2	\N	2019-09-28	-8.55	956350bfd1852bdd1112e1dcfbfae9ee	2020-10-23 22:40:36.187095	2020-10-23 22:40:36.187095
6034	2	6	27	2	\N	2019-09-29	-32.90	53fde96fcc4b4ce72d7739202324cd49	2020-10-23 22:40:36.188142	2020-10-23 22:40:36.188142
6035	2	6	27	2	\N	2019-09-29	-35.80	6d3b48096eae8b0bf540149207bd0f67	2020-10-23 22:40:36.189182	2020-10-23 22:40:36.189182
6036	2	6	27	2	\N	2019-09-29	-85.97	13156e347b1734f38db62eea70f7b0a5	2020-10-23 22:40:36.190223	2020-10-23 22:40:36.190223
6037	2	6	27	2	\N	2019-09-29	-91.56	21ca2c1a71abd61af7a1d1a736847656	2020-10-23 22:40:36.191548	2020-10-23 22:40:36.191548
6038	5	2	-1	4	\N	2019-10-01	3000.00	dc392fd5e4d37f7b9cab616184b92a82	2020-10-23 22:40:36.192599	2020-10-23 22:40:36.192599
6039	5	9	53	3	\N	2019-10-01	-1000.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.193683	2020-10-23 22:40:36.193683
6040	6	2	-1	4	\N	2019-10-01	1000.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.194881	2020-10-23 22:40:36.194881
6041	5	9	53	3	\N	2019-10-01	-500.00	7f100b7b36092fb9b06dfb4fac360931	2020-10-23 22:40:36.196036	2020-10-23 22:40:36.196036
6042	1	2	-1	4	\N	2019-10-01	4959.14	028938ac39bd53b085c4584c2143f4fb	2020-10-23 22:40:36.197628	2020-10-23 22:40:36.197628
6043	1	9	53	3	\N	2019-10-01	-2000.00	53cc638c15debc4d5b3bf12f949f5d79	2020-10-23 22:40:36.198736	2020-10-23 22:40:36.198736
6044	1	9	51	2	\N	2019-10-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:36.199983	2020-10-23 22:40:36.199983
6045	6	10	55	1	\N	2019-10-01	15.01	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.201133	2020-10-23 22:40:36.201133
6046	5	5	21	2	\N	2019-10-01	-21.15	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:36.202703	2020-10-23 22:40:36.202703
6047	5	1	-1	2	\N	2019-10-01	-131.66	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.203907	2020-10-23 22:40:36.203907
6048	5	1	-1	2	\N	2019-10-01	-23.00	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.204982	2020-10-23 22:40:36.204982
6049	1	2	3	1	\N	2019-10-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:36.206108	2020-10-23 22:40:36.206108
6050	1	8	41	2	\N	2019-10-01	-25.87	71c32595c397960f74555a8b9db16f75	2020-10-23 22:40:36.207127	2020-10-23 22:40:36.207127
6051	1	8	41	2	\N	2019-10-01	-45.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:36.208451	2020-10-23 22:40:36.208451
6052	2	5	25	2	\N	2019-10-02	-45.00	82a958afc122a6e476b5f93a210b781e	2020-10-23 22:40:36.209622	2020-10-23 22:40:36.209622
6053	2	6	27	2	\N	2019-10-02	-199.99	6a9177312f2eefe4f376b89178c3ae95	2020-10-23 22:40:36.211	2020-10-23 22:40:36.211
6054	2	6	27	2	\N	2019-10-02	-74.16	478eefeb17128f6705a508e60ef34f76	2020-10-23 22:40:36.212318	2020-10-23 22:40:36.212318
6055	2	6	27	1	\N	2019-10-02	139.99	68000b5f90a1d5b5b1a93dbb8aa92d3e	2020-10-23 22:40:36.213443	2020-10-23 22:40:36.213443
6056	2	6	27	1	\N	2019-10-02	90.86	ef4e3b775c934dada217712d76f3d51f	2020-10-23 22:40:36.21461	2020-10-23 22:40:36.21461
6057	2	6	27	1	\N	2019-10-02	50.98	edd6b311024aa1094b847933dd729225	2020-10-23 22:40:36.215737	2020-10-23 22:40:36.215737
6058	5	4	15	2	\N	2019-10-02	-7.38	e57c6b956a6521b28495f2886ca0977a	2020-10-23 22:40:36.216855	2020-10-23 22:40:36.216855
6059	1	1	-1	2	\N	2019-10-02	-16.94	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:36.218705	2020-10-23 22:40:36.218705
6060	1	9	53	3	\N	2019-10-03	-70.63	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.219954	2020-10-23 22:40:36.219954
6061	5	8	43	2	\N	2019-10-02	-207.43	b31e825ba7b90e7a25ce1f88ba3a1d40	2020-10-23 22:40:36.221108	2020-10-23 22:40:36.221108
6062	5	5	22	2	\N	2019-10-02	-50.00	3415b4481a177647820b151081eeecd4	2020-10-23 22:40:36.222222	2020-10-23 22:40:36.222222
6063	5	1	-1	2	\N	2019-10-03	-195.92	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.223364	2020-10-23 22:40:36.223364
6064	5	9	48	2	\N	2019-10-03	-44.99	81bb84f15740b786e17b726d969d35b7	2020-10-23 22:40:36.22444	2020-10-23 22:40:36.22444
6065	5	9	48	2	\N	2019-10-03	-19.90	81bb84f15740b786e17b726d969d35b7	2020-10-23 22:40:36.225568	2020-10-23 22:40:36.225568
6066	2	5	22	2	\N	2019-10-03	-579.98	a4d6044701ee96ee3a68e69f6c921595	2020-10-23 22:40:36.226841	2020-10-23 22:40:36.226841
6067	5	9	47	2	\N	2019-10-03	-3000.00	e07413354875be01a996dc560274708e	2020-10-23 22:40:36.228222	2020-10-23 22:40:36.228222
6068	5	1	-1	2	\N	2019-10-03	-66.20	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.229431	2020-10-23 22:40:36.229431
6069	5	1	-1	2	\N	2019-10-04	-15.84	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.230668	2020-10-23 22:40:36.230668
6070	5	1	-1	2	\N	2019-10-05	-16.80	c6c3956ac99102230b94411b28613345	2020-10-23 22:40:36.232104	2020-10-23 22:40:36.232104
6071	5	1	-1	2	\N	2019-10-06	-8.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.233505	2020-10-23 22:40:36.233505
6072	2	6	27	1	\N	2019-10-07	199.99	5e0e2ff11074a3bfe4bbe5eff81e35cd	2020-10-23 22:40:36.234701	2020-10-23 22:40:36.234701
6073	2	2	3	1	\N	2019-10-07	330.00	9df62e693988eb4e1e1444ece0578579	2020-10-23 22:40:36.235931	2020-10-23 22:40:36.235931
6074	5	8	45	2	\N	2019-10-07	-86.00	10e1b7ca0d760d5be46a3d3798e6953d	2020-10-23 22:40:36.237439	2020-10-23 22:40:36.237439
6075	5	1	-1	2	\N	2019-10-10	-191.96	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.2393	2020-10-23 22:40:36.2393
6076	5	1	-1	2	\N	2019-10-10	-9.66	ff77f989ff699a82c072402156bf0537	2020-10-23 22:40:36.240472	2020-10-23 22:40:36.240472
6077	1	1	-1	2	\N	2019-10-12	-14.71	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:36.241519	2020-10-23 22:40:36.241519
6078	1	1	-1	2	\N	2019-10-12	-2.80	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.242547	2020-10-23 22:40:36.242547
6079	1	1	-1	2	\N	2019-10-12	-27.04	e38222129dc1e23d47c5e6572d7c5646	2020-10-23 22:40:36.244287	2020-10-23 22:40:36.244287
6080	1	1	-1	2	\N	2019-10-12	-189.00	0b4fd578fa85b9d3ad197fb3a5fbf4db	2020-10-23 22:40:36.245456	2020-10-23 22:40:36.245456
6081	1	8	44	2	\N	2019-10-12	-50.00	962e611a0fdbd09ad6368caece8df75c	2020-10-23 22:40:36.246526	2020-10-23 22:40:36.246526
6082	1	7	35	2	\N	2019-10-12	-20.00	4abbf97c1ed2b6ae4f44905aa7401fe0	2020-10-23 22:40:36.247605	2020-10-23 22:40:36.247605
6083	1	5	22	2	\N	2019-10-12	-138.85	33a190996c7d195c4f7726293cbb44b0	2020-10-23 22:40:36.248678	2020-10-23 22:40:36.248678
6084	1	9	53	3	\N	2019-10-12	-2000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.249815	2020-10-23 22:40:36.249815
6085	5	1	-1	2	\N	2019-10-12	-57.00	25cf634a77c7909b87b9d8a19b610bae	2020-10-23 22:40:36.251077	2020-10-23 22:40:36.251077
6086	5	4	16	2	\N	2019-10-12	-70.00	98161ea86740fe71734330821f7d6b81	2020-10-23 22:40:36.252153	2020-10-23 22:40:36.252153
6087	2	4	16	2	\N	2019-10-13	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:36.253324	2020-10-23 22:40:36.253324
6088	5	1	-1	2	\N	2019-10-19	-107.19	6f278f85c688b6cf275730b90ec6096c	2020-10-23 22:40:36.2545	2020-10-23 22:40:36.2545
6089	5	1	-1	2	\N	2019-10-14	-72.47	10cecad0b6a73b29eed52ba7f908284a	2020-10-23 22:40:36.255609	2020-10-23 22:40:36.255609
6090	5	1	-1	2	\N	2019-10-16	-71.28	10cecad0b6a73b29eed52ba7f908284a	2020-10-23 22:40:36.256627	2020-10-23 22:40:36.256627
6091	5	5	23	2	\N	2019-10-18	-117.05	7964e5e6c65b646c01df35ace01619a2	2020-10-23 22:40:36.257755	2020-10-23 22:40:36.257755
6092	2	5	21	2	\N	2019-10-19	-55.97	d4fdaaf961c7084a877c09d73a8e4ae8	2020-10-23 22:40:36.258953	2020-10-23 22:40:36.258953
6093	5	5	21	1	\N	2019-10-19	55.97	d4fdaaf961c7084a877c09d73a8e4ae8	2020-10-23 22:40:36.260285	2020-10-23 22:40:36.260285
6094	5	5	23	2	\N	2019-10-14	-13.47	ed50bcd1655946555b2e87106d4e6418	2020-10-23 22:40:36.261508	2020-10-23 22:40:36.261508
6095	2	5	22	1	\N	2019-10-18	400.00	2f6bde94326aa9bd6f4d0b8bdf6bcbbe	2020-10-23 22:40:36.262689	2020-10-23 22:40:36.262689
6096	2	8	44	2	\N	2019-10-18	-17.01	dd6d5383fc56c4e65ed07665cd088f9a	2020-10-23 22:40:36.26396	2020-10-23 22:40:36.26396
6097	5	1	-1	2	\N	2019-10-18	-18.32	f621871c906652d63f7a87d50cc81bb5	2020-10-23 22:40:36.265092	2020-10-23 22:40:36.265092
6098	5	9	47	2	\N	2019-10-19	-200.00	d1229569ae37f6f0d96727ae1169862f	2020-10-23 22:40:36.266277	2020-10-23 22:40:36.266277
6099	5	9	47	2	\N	2019-10-18	-250.00	87852772765fb56a3d9a019c722ce793	2020-10-23 22:40:36.267423	2020-10-23 22:40:36.267423
6100	5	5	23	2	\N	2019-10-17	-39.40	a67f096809415ca1c9f112d96d27689b	2020-10-23 22:40:36.268486	2020-10-23 22:40:36.268486
6101	2	4	18	2	\N	2019-10-18	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:36.269507	2020-10-23 22:40:36.269507
6102	5	2	-1	1	\N	2019-10-24	130.00	ddd40623285c1557a6e2bbc0c7a4252d	2020-10-23 22:40:36.270485	2020-10-23 22:40:36.270485
6103	5	1	-1	2	\N	2019-10-25	-8.10	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:40:36.271539	2020-10-23 22:40:36.271539
6104	5	1	-1	2	\N	2019-10-25	-14.32	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.272582	2020-10-23 22:40:36.272582
6105	5	5	23	2	\N	2019-10-25	-17.98	ea20a043c08f5168d4409ff4144f32e2	2020-10-23 22:40:36.273754	2020-10-23 22:40:36.273754
6106	2	10	54	3	\N	2019-10-25	-500.00	7f6ffaa6bb0b408017b62254211691b5	2020-10-23 22:40:36.274988	2020-10-23 22:40:36.274988
6107	4	10	54	4	\N	2019-10-25	500.00	7f6ffaa6bb0b408017b62254211691b5	2020-10-23 22:40:36.276277	2020-10-23 22:40:36.276277
6108	5	2	-1	4	\N	2019-10-25	1000.00	4964f6191cd8fc59ad9c02f02cf416be	2020-10-23 22:40:36.277828	2020-10-23 22:40:36.277828
6109	5	1	-1	2	\N	2019-10-25	-78.68	b056eb1587586b71e2da9acfe4fbd19e	2020-10-23 22:40:36.279258	2020-10-23 22:40:36.279258
6110	1	9	53	3	\N	2019-10-22	-20.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:36.280347	2020-10-23 22:40:36.280347
6111	1	8	41	2	\N	2019-10-20	-4.60	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:36.281359	2020-10-23 22:40:36.281359
6112	1	1	11	2	\N	2019-10-20	-55.98	5487315b1286f907165907aa8fc96619	2020-10-23 22:40:36.282333	2020-10-23 22:40:36.282333
6113	1	7	35	2	\N	2019-10-21	-25.00	86bcda239376b59e5a84fe97b1c452fa	2020-10-23 22:40:36.283381	2020-10-23 22:40:36.283381
6114	1	1	-1	2	\N	2019-10-21	-58.40	cc9b2449fbbb9b88f5756db82875773e	2020-10-23 22:40:36.284406	2020-10-23 22:40:36.284406
6115	1	7	35	2	\N	2019-10-25	-69.00	53f1ce1310367adfe34e70e39c454d88	2020-10-23 22:40:36.285416	2020-10-23 22:40:36.285416
6116	1	1	-1	2	\N	2019-10-25	-16.37	5e8a4ad8948e27d7e3bc6857463ab751	2020-10-23 22:40:36.286526	2020-10-23 22:40:36.286526
6117	1	1	-1	2	\N	2019-10-25	-26.86	ec5aa0b7846082a2415f0902f0da88f2	2020-10-23 22:40:36.287604	2020-10-23 22:40:36.287604
6118	1	1	-1	2	\N	2019-10-25	-13.00	0a912ffa3d32b6d3ee3d220c3693d12d	2020-10-23 22:40:36.288595	2020-10-23 22:40:36.288595
6119	1	1	11	2	\N	2019-10-25	-7.00	5487315b1286f907165907aa8fc96619	2020-10-23 22:40:36.289629	2020-10-23 22:40:36.289629
6120	1	9	48	2	\N	2019-10-25	-15.00	de4cba49484ec054e3a5da011421f36e	2020-10-23 22:40:36.290714	2020-10-23 22:40:36.290714
6121	1	3	-1	2	\N	2019-10-25	-83.99	33a97012cdc6b7767cf71404ac21cf25	2020-10-23 22:40:36.291858	2020-10-23 22:40:36.291858
6122	1	1	-1	2	\N	2019-10-25	-2.80	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.292846	2020-10-23 22:40:36.292846
6123	1	9	53	3	\N	2019-10-25	-20.00	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:36.294061	2020-10-23 22:40:36.294061
6124	1	9	-1	2	\N	2019-10-25	-2.20	8f2763e5c327397bc0ff29b55857b1ab	2020-10-23 22:40:36.295608	2020-10-23 22:40:36.295608
6125	1	1	-1	2	\N	2019-10-25	-3.50	935c1f5d59a9bdd22194d551ed375acd	2020-10-23 22:40:36.296937	2020-10-23 22:40:36.296937
6126	1	2	-1	4	\N	2019-10-25	533.79	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:36.298174	2020-10-23 22:40:36.298174
6127	1	9	49	2	\N	2019-10-25	-230.64	2e7f585062fd382544f72bdbea6712f0	2020-10-23 22:40:36.299264	2020-10-23 22:40:36.299264
6128	1	1	-1	2	\N	2019-10-25	-1.80	4d42b8302f6c2e3d48dc0fb1f3797141	2020-10-23 22:40:36.300448	2020-10-23 22:40:36.300448
6129	5	8	43	2	\N	2019-10-25	-80.00	5191792b1ad05675fea3bbf015036b3b	2020-10-23 22:40:36.301531	2020-10-23 22:40:36.301531
6130	5	1	-1	2	\N	2019-10-25	-50.00	b056eb1587586b71e2da9acfe4fbd19e	2020-10-23 22:40:36.302604	2020-10-23 22:40:36.302604
6131	2	8	40	2	\N	2019-10-26	-7.00	40461a08504dd59433e3aac89554aa51	2020-10-23 22:40:36.30366	2020-10-23 22:40:36.30366
6132	2	8	44	2	\N	2019-10-26	-35.08	2a9ced3967f417a7877cc296438e6fb4	2020-10-23 22:40:36.304678	2020-10-23 22:40:36.304678
6133	5	8	43	2	\N	2019-10-26	-225.00	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:36.305658	2020-10-23 22:40:36.305658
6134	5	1	-1	2	\N	2019-10-26	-20.64	b798c28e671592bc0fe82b05d71c69ba	2020-10-23 22:40:36.306735	2020-10-23 22:40:36.306735
6135	2	8	44	2	\N	2019-10-28	-27.12	74db120f0a8e5646ef5a30154e9f6deb	2020-10-23 22:40:36.307804	2020-10-23 22:40:36.307804
6136	5	5	23	2	\N	2019-10-28	-12.99	4c85a292227de470f866fa5c06250ed9	2020-10-23 22:40:36.309133	2020-10-23 22:40:36.309133
6137	5	4	16	2	\N	2019-10-29	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:36.310271	2020-10-23 22:40:36.310271
6138	5	1	-1	2	\N	2019-10-29	-16.27	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.311822	2020-10-23 22:40:36.311822
6139	2	2	3	1	\N	2019-10-29	5615.59	620b649ff913b11026b137ea2a7aa4ec	2020-10-23 22:40:36.31326	2020-10-23 22:40:36.31326
6140	2	10	54	3	\N	2019-10-30	-3000.00	7b9e896a37f695061d96856eb483d7ba	2020-10-23 22:40:36.314666	2020-10-23 22:40:36.314666
6141	5	10	54	4	\N	2019-10-30	3000.00	7b9e896a37f695061d96856eb483d7ba	2020-10-23 22:40:36.316067	2020-10-23 22:40:36.316067
6142	2	10	54	3	\N	2019-10-30	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.317481	2020-10-23 22:40:36.317481
6143	4	10	54	4	\N	2019-10-30	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.318512	2020-10-23 22:40:36.318512
6144	5	4	13	2	\N	2019-10-30	-392.95	faecbd2dae425cfd3e4b4e5a9ecfdc84	2020-10-23 22:40:36.319499	2020-10-23 22:40:36.319499
6145	5	7	31	2	\N	2019-10-30	-80.00	c4e187dcd2ea9518f72fdaaad6231d17	2020-10-23 22:40:36.320481	2020-10-23 22:40:36.320481
6146	5	4	15	2	\N	2019-10-30	-103.89	d2e2a9d8a114d2dd3feba88cf64fa2b6	2020-10-23 22:40:36.32154	2020-10-23 22:40:36.32154
6147	1	1	-1	2	\N	2019-10-30	-7.50	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:36.322686	2020-10-23 22:40:36.322686
6148	1	9	53	3	\N	2019-10-29	-21.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.324067	2020-10-23 22:40:36.324067
6149	1	9	48	2	\N	2019-10-29	-12.82	a2799841174715c92b7742c188a0bf60	2020-10-23 22:40:36.325311	2020-10-23 22:40:36.325311
6150	1	1	11	2	\N	2019-10-24	-19.00	0d0871f0806eae32d30983b62252da50	2020-10-23 22:40:36.326746	2020-10-23 22:40:36.326746
6151	5	1	-1	2	\N	2019-10-31	-225.53	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:36.328267	2020-10-23 22:40:36.328267
6152	6	10	55	1	\N	2019-10-31	15.43	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.32953	2020-10-23 22:40:36.32953
6153	6	10	54	4	\N	2019-11-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.330642	2020-10-23 22:40:36.330642
6154	5	10	54	4	\N	2019-11-01	500.00	4964f6191cd8fc59ad9c02f02cf416be	2020-10-23 22:40:36.332826	2020-10-23 22:40:36.332826
6155	1	10	54	4	\N	2019-11-01	5000.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:36.334274	2020-10-23 22:40:36.334274
6156	1	9	53	3	\N	2019-11-01	-99.30	8b69230d6781901b8902032a86c8db8b	2020-10-23 22:40:36.335424	2020-10-23 22:40:36.335424
6157	1	9	53	3	\N	2019-11-01	-4000.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:36.337371	2020-10-23 22:40:36.337371
6158	1	2	-1	1	\N	2019-11-01	0.00	aa86045b793fd7fe8baa40e6a6a2dbb6	2020-10-23 22:40:36.338602	2020-10-23 22:40:36.338602
6159	1	9	49	2	\N	2019-11-01	-15.52	60710fc39180f03bb8b67a484a969021	2020-10-23 22:40:36.34007	2020-10-23 22:40:36.34007
6160	2	5	21	2	\N	2019-11-02	-28.28	114d6f9d705905ed945a8abfb369abd5	2020-10-23 22:40:36.341389	2020-10-23 22:40:36.341389
6161	2	1	-1	2	\N	2019-11-03	-55.00	2c5d27255f304e869657726360fed06f	2020-10-23 22:40:36.342554	2020-10-23 22:40:36.342554
6162	5	7	38	2	\N	2019-11-03	-26.00	d3543b25c8e3d12b31f114c9138ce9c2	2020-10-23 22:40:36.343901	2020-10-23 22:40:36.343901
6163	5	10	54	3	\N	2019-11-04	-2500.00	c57b93e83112330690d8f219cab5c24d	2020-10-23 22:40:36.345594	2020-10-23 22:40:36.345594
6164	6	10	54	4	\N	2019-11-04	2500.00	c57b93e83112330690d8f219cab5c24d	2020-10-23 22:40:36.34669	2020-10-23 22:40:36.34669
6165	5	9	48	2	\N	2019-11-05	-108.90	7ea97341577f42fa6c189332e7a60af5	2020-10-23 22:40:36.347773	2020-10-23 22:40:36.347773
6166	2	9	48	2	\N	2019-11-05	-80.25	ba71b125684b37343c63a696fdfbe680	2020-10-23 22:40:36.348846	2020-10-23 22:40:36.348846
6167	5	1	-1	2	\N	2019-11-04	-6.86	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:36.349924	2020-10-23 22:40:36.349924
6168	5	1	-1	2	\N	2019-11-06	-8.00	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:36.351104	2020-10-23 22:40:36.351104
6169	5	5	25	2	\N	2019-11-06	-30.00	2cb98cf87a1ea7d68097499de4c25d84	2020-10-23 22:40:36.352636	2020-10-23 22:40:36.352636
6170	2	8	44	2	\N	2019-11-07	-21.84	fb5e43e9f522b003b9b93e5abd98d20e	2020-10-23 22:40:36.353928	2020-10-23 22:40:36.353928
6171	2	1	-1	2	\N	2019-11-07	-6.00	8418604ea573578ddfef0106c4d99830	2020-10-23 22:40:36.355368	2020-10-23 22:40:36.355368
6172	2	5	26	2	\N	2019-11-07	-46.94	1be3bc32e6564055d5ca3e5a354acbef	2020-10-23 22:40:36.356619	2020-10-23 22:40:36.356619
6173	5	5	23	2	\N	2019-11-07	-55.99	621461af90cadfdaf0e8d4cc25129f91	2020-10-23 22:40:36.35793	2020-10-23 22:40:36.35793
6174	5	5	23	2	\N	2019-11-07	-13.99	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:36.359146	2020-10-23 22:40:36.359146
6175	2	6	27	2	\N	2019-11-07	-240.50	405c7606466ad55dbbb05ea0b70808c4	2020-10-23 22:40:36.360284	2020-10-23 22:40:36.360284
6176	2	9	48	2	\N	2019-11-07	-59.95	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:40:36.361563	2020-10-23 22:40:36.361563
6177	5	5	26	2	\N	2019-11-07	-24.26	e0283dadd1277d0ce6c6bae5787408a2	2020-10-23 22:40:36.362721	2020-10-23 22:40:36.362721
6178	2	5	26	1	\N	2019-11-07	24.26	e0283dadd1277d0ce6c6bae5787408a2	2020-10-23 22:40:36.363992	2020-10-23 22:40:36.363992
6179	5	1	-1	2	\N	2019-11-08	-160.59	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.365345	2020-10-23 22:40:36.365345
6180	2	9	49	2	\N	2019-11-12	-245.00	218c3d6f821947a59e83845f6b1fb845	2020-10-23 22:40:36.366499	2020-10-23 22:40:36.366499
6181	5	1	-1	2	\N	2019-11-13	-36.19	8df707a948fac1b4a0f97aa554886ec8	2020-10-23 22:40:36.367661	2020-10-23 22:40:36.367661
6182	5	4	14	2	\N	2019-11-13	-181.50	d5e7be7e0314b894ca0b3609e98bacee	2020-10-23 22:40:36.368795	2020-10-23 22:40:36.368795
6183	4	10	54	3	\N	2019-11-13	-2500.00	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:40:36.369982	2020-10-23 22:40:36.369982
6184	2	10	54	4	\N	2019-11-13	2500.00	2ef63d0b6f17fb4810e07cb72c3c533e	2020-10-23 22:40:36.371216	2020-10-23 22:40:36.371216
6185	5	5	23	2	\N	2019-11-13	-18.49	00d2a735511a71b0d8449a57cf2520aa	2020-10-23 22:40:36.372353	2020-10-23 22:40:36.372353
6186	5	1	-1	2	\N	2019-11-13	-11.45	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:36.373585	2020-10-23 22:40:36.373585
6187	2	4	18	2	\N	2019-11-14	-25.00	df7782cc7d1222cb8c1fb24f33ea040a	2020-10-23 22:40:36.374758	2020-10-23 22:40:36.374758
6188	2	9	49	1	\N	2019-11-14	245.00	9de6d14fff9806d4bcd1ef555be766cd	2020-10-23 22:40:36.376462	2020-10-23 22:40:36.376462
6189	2	1	-1	2	\N	2019-11-15	-33.00	b4491791559820061bd66c2b5a4fff1d	2020-10-23 22:40:36.377908	2020-10-23 22:40:36.377908
6190	2	4	16	2	\N	2019-11-15	-29.99	96640993dd2592a16c29226daf83b860	2020-10-23 22:40:36.379149	2020-10-23 22:40:36.379149
6191	2	9	48	1	\N	2019-11-15	100.00	081b16bcd52a14c866fe2ab1ae3c065a	2020-10-23 22:40:36.380258	2020-10-23 22:40:36.380258
6192	2	6	27	2	\N	2019-11-14	-67.97	fa83a11a198d5a7f0bf77a1987bcd006	2020-10-23 22:40:36.381376	2020-10-23 22:40:36.381376
6193	5	1	-1	2	\N	2019-11-15	-256.17	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.382537	2020-10-23 22:40:36.382537
6194	2	2	-1	1	\N	2019-11-15	1.43	0668fd989adc825f582bbb0721090f0e	2020-10-23 22:40:36.383711	2020-10-23 22:40:36.383711
6195	1	9	49	2	\N	2019-11-08	-21.07	422707f82a00d48fe37bd9e9597f56dd	2020-10-23 22:40:36.384793	2020-10-23 22:40:36.384793
6196	1	1	-1	2	\N	2019-11-15	-16.90	f0013a69a234aa85c02ee4212f59914b	2020-10-23 22:40:36.38594	2020-10-23 22:40:36.38594
6197	1	5	25	2	\N	2019-11-12	-59.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:36.38702	2020-10-23 22:40:36.38702
6198	1	5	21	2	\N	2019-11-12	-61.85	b59d9f9e843dedb09e407849f3396cb1	2020-10-23 22:40:36.388082	2020-10-23 22:40:36.388082
6199	1	9	-1	2	\N	2019-11-12	-330.00	dfbc33fe81c91e89c0148f2b40bb6aaa	2020-10-23 22:40:36.389381	2020-10-23 22:40:36.389381
6200	1	9	48	2	\N	2019-11-12	-87.97	00b9568dbb693e6b97ec5200da07bc47	2020-10-23 22:40:36.39068	2020-10-23 22:40:36.39068
6201	1	9	48	2	\N	2019-11-12	-10.00	ba8e4d24b2cca9dd63c09bdca461eecd	2020-10-23 22:40:36.391978	2020-10-23 22:40:36.391978
6202	1	8	41	2	\N	2019-11-12	-1.00	ae2cef1cbe80fb30a86d4ffd2c2273c1	2020-10-23 22:40:36.393395	2020-10-23 22:40:36.393395
6203	5	1	11	2	\N	2019-11-12	-31.95	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:40:36.394756	2020-10-23 22:40:36.394756
6204	5	1	-1	2	\N	2019-11-07	-3.94	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:40:36.396509	2020-10-23 22:40:36.396509
6205	5	1	-1	2	\N	2019-11-07	-6.00	59ff869f7786d5e661e258b5cb425579	2020-10-23 22:40:36.397949	2020-10-23 22:40:36.397949
6206	5	4	16	2	\N	2019-11-03	-70.00	0c415b72b97c5c9feba343416ec8a2a7	2020-10-23 22:40:36.399347	2020-10-23 22:40:36.399347
6207	1	2	-1	4	\N	2019-11-17	3000.00	6f942b1ffa5780a2552735930367b3a0	2020-10-23 22:40:36.400484	2020-10-23 22:40:36.400484
6208	2	2	-1	4	\N	2019-11-17	1000.00	83973fd8a64df0aaf7014feb1032de18	2020-10-23 22:40:36.401553	2020-10-23 22:40:36.401553
6209	1	8	41	2	\N	2019-11-17	-29.00	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.402596	2020-10-23 22:40:36.402596
6210	5	8	43	2	\N	2019-11-17	-225.50	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:36.403837	2020-10-23 22:40:36.403837
6211	2	9	48	2	\N	2019-11-17	-2279.00	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:40:36.405108	2020-10-23 22:40:36.405108
6212	5	5	23	2	\N	2019-11-18	-13.90	e8cb4ff5f9f6d5ff45a4fec7ddd72400	2020-10-23 22:40:36.406201	2020-10-23 22:40:36.406201
6213	5	5	23	2	\N	2019-11-19	-43.20	afd4836712c5e77550897e25711e1d96	2020-10-23 22:40:36.407229	2020-10-23 22:40:36.407229
6214	2	1	-1	2	\N	2019-11-19	-21.00	e316443f25fef1e9ebf48b221dc41b28	2020-10-23 22:40:36.408248	2020-10-23 22:40:36.408248
6215	2	8	44	2	\N	2019-11-19	-26.16	bd559ce0fb11855e1be7684959f490b4	2020-10-23 22:40:36.409421	2020-10-23 22:40:36.409421
6216	5	9	48	2	\N	2019-11-19	-25.00	c34115cc13d27fca6f958240c5d1f554	2020-10-23 22:40:36.410614	2020-10-23 22:40:36.410614
6217	1	9	53	3	\N	2019-11-19	-30.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:36.412026	2020-10-23 22:40:36.412026
6218	1	9	53	3	\N	2019-11-19	-100.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:36.413193	2020-10-23 22:40:36.413193
6219	1	1	-1	2	\N	2019-11-23	-1074.70	559afd0979bb51e7532980fc12ca3f4e	2020-10-23 22:40:36.414273	2020-10-23 22:40:36.414273
6220	1	1	-1	2	\N	2019-11-21	-3.60	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:36.41553	2020-10-23 22:40:36.41553
6221	1	9	-1	2	\N	2019-11-22	-9.20	330770104891acbdcbeb059eabf162d5	2020-10-23 22:40:36.41659	2020-10-23 22:40:36.41659
6222	1	1	-1	2	\N	2019-11-22	-35.44	558cb90273f237253bb874c790d52587	2020-10-23 22:40:36.417611	2020-10-23 22:40:36.417611
6223	1	1	-1	2	\N	2019-11-22	-3.50	6b42012b07d091395230a3a71b477a02	2020-10-23 22:40:36.418835	2020-10-23 22:40:36.418835
6224	5	1	-1	2	\N	2019-11-23	-12.11	6d0f846348a856321729a2f36734d1a7	2020-10-23 22:40:36.420091	2020-10-23 22:40:36.420091
6225	5	5	23	2	\N	2019-11-21	-41.98	28c0306b74ea36caccd5e7a766707577	2020-10-23 22:40:36.421456	2020-10-23 22:40:36.421456
6226	5	1	-1	2	\N	2019-11-23	-7.46	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:36.422672	2020-10-23 22:40:36.422672
6227	5	4	16	2	\N	2019-11-23	-49.90	a891fab616218a3f7195a5eea2518005	2020-10-23 22:40:36.424105	2020-10-23 22:40:36.424105
6228	5	1	-1	2	\N	2019-11-23	-7.91	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:36.42572	2020-10-23 22:40:36.42572
6229	5	1	-1	2	\N	2019-11-23	-224.54	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.42706	2020-10-23 22:40:36.42706
6230	2	1	-1	2	\N	2019-11-26	-100.72	55371441b6d303298feeec6f09990555	2020-10-23 22:40:36.428479	2020-10-23 22:40:36.428479
6231	5	1	-1	2	\N	2019-11-26	-14.35	89b45ff321063b749efc5b5b3aa79930	2020-10-23 22:40:36.429549	2020-10-23 22:40:36.429549
6232	5	5	26	2	\N	2019-11-25	-82.14	7b03619fa0825678c6ad07bb587216f2	2020-10-23 22:40:36.430583	2020-10-23 22:40:36.430583
6233	1	6	27	2	\N	2019-11-26	-129.99	a9c3a357b81dcb7e93844108cd7b6608	2020-10-23 22:40:36.431608	2020-10-23 22:40:36.431608
6234	2	9	48	1	\N	2019-11-25	100.00	f92b1905929018c322964d49fe99789e	2020-10-23 22:40:36.432809	2020-10-23 22:40:36.432809
6235	2	9	48	1	\N	2019-11-25	100.00	14065fdb806e73e4874d76f6d17e79d9	2020-10-23 22:40:36.434081	2020-10-23 22:40:36.434081
6236	5	1	-1	2	\N	2019-11-26	-6.60	1673448ee7064c989d02579c534f6b66	2020-10-23 22:40:36.435336	2020-10-23 22:40:36.435336
6237	5	5	23	2	\N	2019-11-27	-15.00	5ed40cc0659d685215b4897e21fa3cab	2020-10-23 22:40:36.436741	2020-10-23 22:40:36.436741
6238	5	8	43	2	\N	2019-11-27	-12.00	e134fe3e8dc67b89dcd928aa2a7e7dcf	2020-10-23 22:40:36.438116	2020-10-23 22:40:36.438116
6239	2	2	3	1	\N	2019-11-27	8436.72	2179cfc25f775ce48c02fbeaaddabc7d	2020-10-23 22:40:36.4396	2020-10-23 22:40:36.4396
6240	2	10	54	3	\N	2019-11-27	-1000.00	d3cc08f31856f2baad4ae7253f541545	2020-10-23 22:40:36.440722	2020-10-23 22:40:36.440722
6241	4	10	54	4	\N	2019-11-27	1000.00	d3cc08f31856f2baad4ae7253f541545	2020-10-23 22:40:36.441778	2020-10-23 22:40:36.441778
6242	2	10	54	3	\N	2019-11-27	-2000.00	92a42a2b93b5b1dda7fa6652063cb5df	2020-10-23 22:40:36.442765	2020-10-23 22:40:36.442765
6243	6	10	54	4	\N	2019-11-27	2000.00	92a42a2b93b5b1dda7fa6652063cb5df	2020-10-23 22:40:36.444237	2020-10-23 22:40:36.444237
6244	2	10	54	3	\N	2019-11-27	-3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:36.445573	2020-10-23 22:40:36.445573
6245	5	10	54	4	\N	2019-11-27	3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:36.446801	2020-10-23 22:40:36.446801
6246	5	4	13	2	\N	2019-11-27	-392.95	c5ff2543b53f4cc0ad3819a36752467b	2020-10-23 22:40:36.44815	2020-10-23 22:40:36.44815
6247	5	4	15	2	\N	2019-11-27	-103.89	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:36.449246	2020-10-23 22:40:36.449246
6248	5	1	-1	2	\N	2019-11-28	-154.21	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.45042	2020-10-23 22:40:36.45042
6249	5	1	-1	2	\N	2019-11-28	-2.80	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:36.451605	2020-10-23 22:40:36.451605
6250	5	5	23	2	\N	2019-11-28	-149.95	85d8ce590ad8981ca2c8286f79f59954	2020-10-23 22:40:36.45285	2020-10-23 22:40:36.45285
6251	2	6	27	2	\N	2019-11-29	-159.99	17380c1b3ba45cc445b955cc6e133b5d	2020-10-23 22:40:36.45436	2020-10-23 22:40:36.45436
6252	2	6	27	2	\N	2019-11-29	-265.92	03dec25e5158510aba66cefc9111607a	2020-10-23 22:40:36.455516	2020-10-23 22:40:36.455516
6253	2	5	21	2	\N	2019-11-29	-150.34	7f5d04d189dfb634e6a85bb9d9adf21e	2020-10-23 22:40:36.456571	2020-10-23 22:40:36.456571
6254	2	6	27	2	\N	2019-11-29	-55.99	159ba4a89132f47014da2c413f2ad52a	2020-10-23 22:40:36.457624	2020-10-23 22:40:36.457624
6255	1	9	-1	3	\N	2019-11-30	-1000.00	4df4ffadf8950f2ebbd82eedcfe604f4	2020-10-23 22:40:36.458628	2020-10-23 22:40:36.458628
6256	1	9	53	3	\N	2019-11-30	-20.00	ff905c528ce7ce9e64c0758b54855b50	2020-10-23 22:40:36.459751	2020-10-23 22:40:36.459751
6257	1	9	48	2	\N	2019-11-30	-100.00	829190b95220e77629ac62b57de957c1	2020-10-23 22:40:36.46163	2020-10-23 22:40:36.46163
6258	1	1	11	2	\N	2019-11-30	-4.00	77cceb48899c14eeb09222035514172d	2020-10-23 22:40:36.462902	2020-10-23 22:40:36.462902
6259	5	8	43	2	\N	2019-11-30	-227.34	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:36.464216	2020-10-23 22:40:36.464216
6260	1	2	-1	1	\N	2019-11-30	227.34	dbe272bab69f8e13f14b405e038deb64	2020-10-23 22:40:36.465359	2020-10-23 22:40:36.465359
6261	1	9	48	2	\N	2019-11-30	-15.00	ed5bb80f46a76945b1cc86a09a854ca5	2020-10-23 22:40:36.466499	2020-10-23 22:40:36.466499
6262	5	9	53	3	\N	2019-11-30	-500.00	8056ac6ddcb0f14b019219391c1159c7	2020-10-23 22:40:36.467618	2020-10-23 22:40:36.467618
6263	5	1	-1	2	\N	2019-11-30	-227.70	82901154ea5372edea77506d467aa449	2020-10-23 22:40:36.468743	2020-10-23 22:40:36.468743
6264	5	5	21	2	\N	2019-11-30	-43.18	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:36.469853	2020-10-23 22:40:36.469853
6265	5	9	-1	2	\N	2019-11-30	-26.10	1a5b1e4daae265b790965a275b53ae50	2020-10-23 22:40:36.471003	2020-10-23 22:40:36.471003
6266	1	2	3	1	\N	2019-12-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:36.472774	2020-10-23 22:40:36.472774
6267	6	10	54	4	\N	2019-12-01	500.00	1251b83b9e06b0b4b9cdc614f4160be1	2020-10-23 22:40:36.474016	2020-10-23 22:40:36.474016
6268	6	10	54	4	\N	2019-12-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.475436	2020-10-23 22:40:36.475436
6269	5	10	54	4	\N	2019-12-01	1500.00	307fd7f231593cf189b68d28f91f63bb	2020-10-23 22:40:36.476642	2020-10-23 22:40:36.476642
6270	6	10	55	1	\N	2019-12-01	18.99	f93c420db6c4e9585be3239f7dcb927b	2020-10-23 22:40:36.478331	2020-10-23 22:40:36.478331
6271	6	10	55	1	\N	2019-12-01	11.22	223066bb0bab283616c3c35340106cbc	2020-10-23 22:40:36.479612	2020-10-23 22:40:36.479612
6272	1	9	-1	3	\N	2019-12-01	-800.00	7ba15e3f075e78d4d10235aaf3b15ff8	2020-10-23 22:40:36.480741	2020-10-23 22:40:36.480741
6273	1	2	-1	4	\N	2019-12-01	999.14	d07e70efcfab08731a97e7b91be644de	2020-10-23 22:40:36.482161	2020-10-23 22:40:36.482161
6274	1	9	53	3	\N	2019-12-01	-30.00	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:36.483614	2020-10-23 22:40:36.483614
6275	1	9	51	2	\N	2019-12-01	-120.00	f20b80a0d815cbbccd2d50ff2e78d97a	2020-10-23 22:40:36.484716	2020-10-23 22:40:36.484716
6276	2	9	51	2	\N	2019-12-02	-50.00	9b6e8be5d32a53f1440f55489474d72b	2020-10-23 22:40:36.485822	2020-10-23 22:40:36.485822
6277	2	6	27	1	\N	2019-12-03	199.96	405c7606466ad55dbbb05ea0b70808c4	2020-10-23 22:40:36.486903	2020-10-23 22:40:36.486903
6278	2	6	27	2	\N	2019-12-03	-179.99	b84b24cb8658ce5fbc7b5c0257dabcdd	2020-10-23 22:40:36.488094	2020-10-23 22:40:36.488094
6279	5	9	48	2	\N	2019-12-03	-19.99	6d42e803db9ab0e3f1751542a0106c51	2020-10-23 22:40:36.489434	2020-10-23 22:40:36.489434
6280	5	1	-1	2	\N	2019-12-03	-7.86	df20e1cfbc5fab04cc56a56b202974a0	2020-10-23 22:40:36.490469	2020-10-23 22:40:36.490469
6281	2	6	27	1	\N	2019-12-04	179.99	5edc5ce86f5f5d98d77ab1e14f40c4cd	2020-10-23 22:40:36.491435	2020-10-23 22:40:36.491435
6282	2	5	23	2	\N	2019-12-04	-19.99	be878df20279a2fedfa0386709d4ecae	2020-10-23 22:40:36.492516	2020-10-23 22:40:36.492516
6283	5	5	23	2	\N	2019-12-04	-30.00	1960f108636b1f7a73a595cb3e8a19f6	2020-10-23 22:40:36.493807	2020-10-23 22:40:36.493807
6284	2	2	-1	1	\N	2019-12-04	100.00	eebc37163657a4d729b6e28c3b850fc9	2020-10-23 22:40:36.495089	2020-10-23 22:40:36.495089
6285	5	1	-1	2	\N	2019-12-05	-15.89	81d11c21f282d6d968efaccdf9adeb2f	2020-10-23 22:40:36.496098	2020-10-23 22:40:36.496098
6286	5	8	43	2	\N	2019-12-04	-224.59	00d2a735511a71b0d8449a57cf2520aa	2020-10-23 22:40:36.497272	2020-10-23 22:40:36.497272
6287	2	7	31	2	\N	2019-12-05	-13.00	39c4de73711fea02c5468558541ea581	2020-10-23 22:40:36.498493	2020-10-23 22:40:36.498493
6288	2	8	42	2	\N	2019-12-05	-60.00	de118786b5cddc3188d04a75e15d854e	2020-10-23 22:40:36.499506	2020-10-23 22:40:36.499506
6289	1	9	53	3	\N	2019-12-07	-20.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.500457	2020-10-23 22:40:36.500457
6290	1	5	25	2	\N	2019-12-07	-59.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:36.501406	2020-10-23 22:40:36.501406
6291	5	9	48	2	\N	2019-12-07	-179.79	6cdd60ea0045eb7a6ec44c54d29ed402	2020-10-23 22:40:36.502324	2020-10-23 22:40:36.502324
6292	1	9	48	2	\N	2019-12-07	-25.50	f1c1592588411002af340cbaedd6fc33	2020-10-23 22:40:36.503235	2020-10-23 22:40:36.503235
6293	1	1	-1	2	\N	2019-12-07	-1.80	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.504437	2020-10-23 22:40:36.504437
6294	1	9	51	2	\N	2019-12-07	-20.00	043c3d7e489c69b48737cc0c92d0f3a2	2020-10-23 22:40:36.505397	2020-10-23 22:40:36.505397
6295	1	1	11	2	\N	2019-12-07	-11.99	5487315b1286f907165907aa8fc96619	2020-10-23 22:40:36.506969	2020-10-23 22:40:36.506969
6296	1	9	48	2	\N	2019-12-07	-157.09	298f95e1bf9136124592c8d4825a06fc	2020-10-23 22:40:36.508104	2020-10-23 22:40:36.508104
6297	1	1	-1	2	\N	2019-12-07	-9.90	b5cc2f2bce2e25c81175b1a867d33e0a	2020-10-23 22:40:36.509227	2020-10-23 22:40:36.509227
6298	1	5	23	2	\N	2019-12-07	-22.00	b41be6fcf038a5b701df0cca737db745	2020-10-23 22:40:36.510724	2020-10-23 22:40:36.510724
6299	1	2	-1	4	\N	2019-12-07	224.59	dbe272bab69f8e13f14b405e038deb64	2020-10-23 22:40:36.511879	2020-10-23 22:40:36.511879
6300	5	8	43	2	\N	2019-12-07	-36.99	89f0fd5c927d466d6ec9a21b9ac34ffa	2020-10-23 22:40:36.512871	2020-10-23 22:40:36.512871
6301	5	4	16	2	\N	2019-12-07	-70.00	3417ed882084a60ae30cf097c9df73c7	2020-10-23 22:40:36.513855	2020-10-23 22:40:36.513855
6302	2	6	27	2	\N	2019-12-07	-180.99	0520a41422ce63b356f79ca728e06b2a	2020-10-23 22:40:36.514731	2020-10-23 22:40:36.514731
6303	5	9	48	2	\N	2019-12-07	-14.98	53160f47e41b77b4e8ff0c2cff06ad9e	2020-10-23 22:40:36.515726	2020-10-23 22:40:36.515726
6304	2	5	21	2	\N	2019-12-07	-60.56	69421f032498c97020180038fddb8e24	2020-10-23 22:40:36.51671	2020-10-23 22:40:36.51671
6305	5	1	-1	2	\N	2019-12-07	-165.31	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.517653	2020-10-23 22:40:36.517653
6306	2	1	-1	2	\N	2019-12-07	-42.58	b662f239dc62c4b92fc0e3bb81742b2e	2020-10-23 22:40:36.518567	2020-10-23 22:40:36.518567
6307	2	9	48	2	\N	2019-12-08	-68.79	7ed89b34f253ed84d2e9d92423f1b0c3	2020-10-23 22:40:36.51952	2020-10-23 22:40:36.51952
6308	5	9	48	2	\N	2019-12-08	-30.37	58a41a6ca3bb87a1921b45052ca03a69	2020-10-23 22:40:36.520474	2020-10-23 22:40:36.520474
6309	2	9	51	2	\N	2019-12-09	-100.00	3daf3224b85a18c85ae50d63a7a6097c	2020-10-23 22:40:36.521531	2020-10-23 22:40:36.521531
6310	5	5	23	2	\N	2019-12-10	-72.99	beee7b04fbc880c61b7750ef7074bc42	2020-10-23 22:40:36.522483	2020-10-23 22:40:36.522483
6311	5	1	-1	2	\N	2019-12-10	-13.15	973ed1483e40f3d06c13065a87141940	2020-10-23 22:40:36.523449	2020-10-23 22:40:36.523449
6312	5	1	-1	2	\N	2019-12-10	-13.00	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:36.524367	2020-10-23 22:40:36.524367
6313	5	1	-1	2	\N	2019-12-11	-10.81	0deb1c54814305ca9ad266f53bc82511	2020-10-23 22:40:36.525367	2020-10-23 22:40:36.525367
6314	2	1	-1	2	\N	2019-12-11	-4.00	ac51dde4208c12904a31c20680bb9c7f	2020-10-23 22:40:36.526315	2020-10-23 22:40:36.526315
6315	5	8	43	2	\N	2019-12-11	-230.66	94b26e0a262280d57ac5f5c9af1a9ed4	2020-10-23 22:40:36.527301	2020-10-23 22:40:36.527301
6316	5	5	26	2	\N	2019-12-11	-66.96	8ce4b5fcb6c0dfa9f094c84ac00a09b9	2020-10-23 22:40:36.528503	2020-10-23 22:40:36.528503
6317	5	2	-1	1	\N	2019-12-12	772.17	24896ee4c6526356cc127852413ea3b4	2020-10-23 22:40:36.529563	2020-10-23 22:40:36.529563
6318	5	1	-1	2	\N	2019-12-13	-19.40	5f2c22cb4a5380af7ca75622a6426917	2020-10-23 22:40:36.530536	2020-10-23 22:40:36.530536
6319	5	1	-1	2	\N	2019-12-13	-12.16	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.531494	2020-10-23 22:40:36.531494
6320	5	9	49	2	\N	2019-12-14	-50.00	0fe197f2ce4dd36d6139a893a43a8acd	2020-10-23 22:40:36.5324	2020-10-23 22:40:36.5324
6321	2	9	49	1	\N	2019-12-14	50.00	0fe197f2ce4dd36d6139a893a43a8acd	2020-10-23 22:40:36.533319	2020-10-23 22:40:36.533319
6322	2	4	18	2	\N	2019-12-15	-25.00	0bc96764ef1c462048a0fcb0da133b57	2020-10-23 22:40:36.53423	2020-10-23 22:40:36.53423
6323	2	6	27	2	\N	2019-12-15	-110.87	b5fde512c76571c8afd6a6089eaaf42a	2020-10-23 22:40:36.535558	2020-10-23 22:40:36.535558
6324	2	6	27	2	\N	2019-12-15	-103.87	f36eef004356bd9bc79f5e794a339946	2020-10-23 22:40:36.536523	2020-10-23 22:40:36.536523
6325	2	6	27	1	\N	2019-12-15	179.99	4e79c55861cfff46a105f0c21d3d1396	2020-10-23 22:40:36.537524	2020-10-23 22:40:36.537524
6326	5	9	48	2	\N	2019-12-15	-200.00	c6bc586e4125cbbcc420fe13387f1896	2020-10-23 22:40:36.538447	2020-10-23 22:40:36.538447
6327	5	9	48	2	\N	2019-12-15	-50.00	b30b8fe32ae3eefc5bf8cccaa4f0ce5d	2020-10-23 22:40:36.539401	2020-10-23 22:40:36.539401
6328	2	9	48	1	\N	2019-12-15	50.00	b30b8fe32ae3eefc5bf8cccaa4f0ce5d	2020-10-23 22:40:36.540378	2020-10-23 22:40:36.540378
6329	2	4	16	2	\N	2019-12-15	-29.99	5e9c67e78ddcb147409625d15bc6cedd	2020-10-23 22:40:36.54133	2020-10-23 22:40:36.54133
6330	2	9	48	2	\N	2019-12-15	-75.00	2f86f1028eed92d84e9b9e35843c1d6a	2020-10-23 22:40:36.542368	2020-10-23 22:40:36.542368
6331	2	9	48	1	\N	2019-12-16	150.00	4b6538a44a1dfdc2b83477cd76dee98e	2020-10-23 22:40:36.543435	2020-10-23 22:40:36.543435
6332	2	9	48	2	\N	2019-12-16	-59.99	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:40:36.544469	2020-10-23 22:40:36.544469
6333	5	1	-1	2	\N	2019-12-16	-364.29	e0550b25de266e2e10779c994297edd4	2020-10-23 22:40:36.545458	2020-10-23 22:40:36.545458
6334	5	9	48	2	\N	2019-12-17	-50.77	180d41c5378101447554b85ed2ac6c79	2020-10-23 22:40:36.546378	2020-10-23 22:40:36.546378
6335	5	1	-1	2	\N	2019-12-18	-12.45	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.547311	2020-10-23 22:40:36.547311
6336	5	1	-1	2	\N	2019-12-18	-12.23	0e75385608a4a0053942ad1081ab3537	2020-10-23 22:40:36.548507	2020-10-23 22:40:36.548507
6337	5	5	22	2	\N	2019-12-17	-110.00	e6b4b2a746ed40e1af829d1fa82daa10	2020-10-23 22:40:36.549453	2020-10-23 22:40:36.549453
6338	5	1	-1	2	\N	2019-12-18	-25.90	99c5e07b4d5de9d18c350cdf64c5aa3d	2020-10-23 22:40:36.55042	2020-10-23 22:40:36.55042
6339	5	1	-1	2	\N	2019-12-18	-52.38	0d3180d672e08b4c5312dcdafdf6ef36	2020-10-23 22:40:36.551483	2020-10-23 22:40:36.551483
6340	2	1	-1	2	\N	2019-12-18	-23.50	cf34362ab126ce8338d8991cc1404980	2020-10-23 22:40:36.552471	2020-10-23 22:40:36.552471
6341	1	9	53	3	\N	2019-12-19	-30.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.553486	2020-10-23 22:40:36.553486
6342	1	8	41	2	\N	2019-12-18	-30.57	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.554422	2020-10-23 22:40:36.554422
6343	1	2	-1	4	\N	2019-12-18	3000.00	7dcd340d84f762eba80aa538b0c527f7	2020-10-23 22:40:36.555357	2020-10-23 22:40:36.555357
6344	1	9	51	2	\N	2019-12-18	-100.00	7378bfed68f89ff95e4c60884628cb16	2020-10-23 22:40:36.55629	2020-10-23 22:40:36.55629
6345	1	1	-1	2	\N	2019-12-18	-12.92	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:36.557492	2020-10-23 22:40:36.557492
6346	1	1	-1	2	\N	2019-12-18	-2.00	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.558468	2020-10-23 22:40:36.558468
6347	1	9	48	2	\N	2019-12-18	-150.00	72ceae670a5e4f1424ef8d21a9feab0c	2020-10-23 22:40:36.559633	2020-10-23 22:40:36.559633
6348	1	1	-1	2	\N	2019-12-18	-20.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:36.560799	2020-10-23 22:40:36.560799
6349	1	9	48	2	\N	2019-12-18	-109.89	77a98983f35b5839c588f9dc1a64193c	2020-10-23 22:40:36.562021	2020-10-23 22:40:36.562021
6350	1	1	-1	2	\N	2019-12-18	-34.50	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:36.563123	2020-10-23 22:40:36.563123
6351	1	6	27	2	\N	2019-12-18	-159.92	69746dd9b05454baef427877a7676da1	2020-10-23 22:40:36.564312	2020-10-23 22:40:36.564312
6352	1	1	-1	2	\N	2019-12-18	-21.20	f421888918b43ff64385f6fef0bca725	2020-10-23 22:40:36.565249	2020-10-23 22:40:36.565249
6353	1	1	-1	2	\N	2019-12-18	-2.80	70aff2103bb09b4b33c93335ae1ded7a	2020-10-23 22:40:36.56645	2020-10-23 22:40:36.56645
6354	6	9	53	3	\N	2019-12-16	-3000.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:36.567405	2020-10-23 22:40:36.567405
6355	5	1	-1	2	\N	2019-12-17	-27.47	04f180f66e2a539f3d02490d9867cb14	2020-10-23 22:40:36.568343	2020-10-23 22:40:36.568343
6356	5	1	-1	2	\N	2019-12-17	-53.06	8885e8c52b8aaee7cacd7bceac43c1bb	2020-10-23 22:40:36.569256	2020-10-23 22:40:36.569256
6357	5	1	-1	2	\N	2019-12-17	-199.22	fbe851c6ccc3960273f4f7caf5dc4c57	2020-10-23 22:40:36.570487	2020-10-23 22:40:36.570487
6358	5	1	-1	2	\N	2019-12-23	-354.65	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.571446	2020-10-23 22:40:36.571446
6359	5	1	-1	2	\N	2019-12-23	-20.63	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.57245	2020-10-23 22:40:36.57245
6360	5	9	48	2	\N	2019-12-23	-500.00	aa169b49b583a2b5af89203c2b78c67c	2020-10-23 22:40:36.57345	2020-10-23 22:40:36.57345
6361	2	2	3	1	\N	2019-12-23	5634.51	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:40:36.574463	2020-10-23 22:40:36.574463
6362	5	1	-1	2	\N	2019-12-23	-14.60	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.575459	2020-10-23 22:40:36.575459
6363	5	9	47	2	\N	2019-12-23	-50.00	3944b025c9ca7eec3154b44666ae04a0	2020-10-23 22:40:36.576615	2020-10-23 22:40:36.576615
6364	5	8	43	2	\N	2019-12-23	-15.00	e134fe3e8dc67b89dcd928aa2a7e7dcf	2020-10-23 22:40:36.577997	2020-10-23 22:40:36.577997
6365	2	10	54	3	\N	2019-12-24	-500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.579418	2020-10-23 22:40:36.579418
6366	4	10	54	4	\N	2019-12-24	500.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:36.580753	2020-10-23 22:40:36.580753
6367	2	10	54	3	\N	2019-12-24	-3000.00	b4c0c84c7057348e020770ca973e668c	2020-10-23 22:40:36.58205	2020-10-23 22:40:36.58205
6368	5	10	54	4	\N	2019-12-24	3000.00	b4c0c84c7057348e020770ca973e668c	2020-10-23 22:40:36.583217	2020-10-23 22:40:36.583217
6369	5	4	13	2	\N	2019-12-24	-392.95	da8ce53cf0240070ce6c69c48cd588ee	2020-10-23 22:40:36.584419	2020-10-23 22:40:36.584419
6370	5	4	15	2	\N	2019-12-24	-103.89	72da7fd6d1302c0a159f6436d01e9eb0	2020-10-23 22:40:36.585552	2020-10-23 22:40:36.585552
6371	5	4	14	2	\N	2019-12-24	-113.34	e308ac73399237a7606dcafdfbcb89fd	2020-10-23 22:40:36.586672	2020-10-23 22:40:36.586672
6372	5	5	23	2	\N	2019-12-27	-73.73	245894da7605c9899120033b962320c3	2020-10-23 22:40:36.587716	2020-10-23 22:40:36.587716
6373	2	5	26	2	\N	2019-12-27	-26.97	70d9aafba78f0608e4ee55391351d89f	2020-10-23 22:40:36.588761	2020-10-23 22:40:36.588761
6374	2	5	23	2	\N	2019-12-27	-142.97	7bae4b5ba8bfe53a6478e5a4e8e47b31	2020-10-23 22:40:36.589826	2020-10-23 22:40:36.589826
6375	5	5	23	2	\N	2019-12-27	-5.99	59021154c209a4a5f6b758de56305096	2020-10-23 22:40:36.591108	2020-10-23 22:40:36.591108
6376	5	9	48	3	\N	2019-12-27	-150.00	82fd19a5ecfb9b60c8a2655f30e793d0	2020-10-23 22:40:36.592225	2020-10-23 22:40:36.592225
6377	6	2	-1	4	\N	2019-12-27	150.00	82fd19a5ecfb9b60c8a2655f30e793d0	2020-10-23 22:40:36.593474	2020-10-23 22:40:36.593474
6378	5	8	43	3	\N	2019-12-28	-232.30	8557acbd605dce2d0a6106c47bcd2338	2020-10-23 22:40:36.59493	2020-10-23 22:40:36.59493
6379	1	9	53	3	\N	2019-12-28	-757.49	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:36.596084	2020-10-23 22:40:36.596084
6380	5	4	16	2	\N	2019-12-29	-49.90	d54c1fa682619ec13c17b308a993232f	2020-10-23 22:40:36.597193	2020-10-23 22:40:36.597193
6381	5	1	-1	2	\N	2019-12-30	-40.19	b4f3bf00e4598578d72b12d81b66a4c4	2020-10-23 22:40:36.598373	2020-10-23 22:40:36.598373
6382	6	10	55	1	\N	2019-12-31	22.05	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.599472	2020-10-23 22:40:36.599472
6383	6	10	55	1	\N	2019-12-31	13.15	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.600524	2020-10-23 22:40:36.600524
6384	1	2	-1	4	\N	2020-01-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:36.601681	2020-10-23 22:40:36.601681
6385	6	10	54	4	\N	2020-01-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.602927	2020-10-23 22:40:36.602927
6386	6	10	54	4	\N	2020-01-01	500.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:36.604138	2020-10-23 22:40:36.604138
6387	5	2	-1	4	\N	2020-01-01	1500.00	307fd7f231593cf189b68d28f91f63bb	2020-10-23 22:40:36.605314	2020-10-23 22:40:36.605314
6388	1	2	-1	4	\N	2020-01-01	600.69	d07e70efcfab08731a97e7b91be644de	2020-10-23 22:40:36.606448	2020-10-23 22:40:36.606448
6389	1	9	51	2	\N	2020-01-01	-150.00	357b6f7587a9cb5d0f97659b50424922	2020-10-23 22:40:36.607574	2020-10-23 22:40:36.607574
6390	1	8	41	2	\N	2020-01-01	-45.00	46944fb74c71615e47f228b12bfe2796	2020-10-23 22:40:36.608813	2020-10-23 22:40:36.608813
6391	1	9	53	3	\N	2020-01-01	-30.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.610266	2020-10-23 22:40:36.610266
6392	1	8	41	2	\N	2020-01-01	-22.40	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.611562	2020-10-23 22:40:36.611562
6393	5	4	16	2	\N	2020-01-02	-70.00	4f04d70a475b264744fd4b80a10bcfba	2020-10-23 22:40:36.612826	2020-10-23 22:40:36.612826
6394	5	8	43	3	\N	2020-01-03	-199.07	9186844637c7ca38f5f65a804457d2a0	2020-10-23 22:40:36.614306	2020-10-23 22:40:36.614306
6395	1	2	-1	4	\N	2020-01-03	199.07	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:36.615587	2020-10-23 22:40:36.615587
6396	1	7	37	2	\N	2020-01-03	-19.90	95f7bb2661386983a957ba798caded32	2020-10-23 22:40:36.616917	2020-10-23 22:40:36.616917
6397	5	8	43	2	\N	2020-01-02	-5.00	2c9c0b5d3d18d1024a0f64a89770eb83	2020-10-23 22:40:36.618277	2020-10-23 22:40:36.618277
6398	5	5	23	2	\N	2020-01-02	-43.97	0e28f8bd8d065cdef5cf35b1dc5027ac	2020-10-23 22:40:36.619422	2020-10-23 22:40:36.619422
6399	5	8	43	3	\N	2020-01-04	-256.18	9186844637c7ca38f5f65a804457d2a0	2020-10-23 22:40:36.620934	2020-10-23 22:40:36.620934
6400	1	2	-1	4	\N	2020-01-04	256.18	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:36.62255	2020-10-23 22:40:36.62255
6401	5	1	-1	2	\N	2020-01-04	-200.00	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.623752	2020-10-23 22:40:36.623752
6402	2	6	27	2	\N	2020-01-04	-24.99	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.624883	2020-10-23 22:40:36.624883
6403	2	6	27	2	\N	2020-01-03	-499.80	8f53295a73878494e9bc8dd6c3c7104f	2020-10-23 22:40:36.626059	2020-10-23 22:40:36.626059
6404	2	6	27	2	\N	2020-01-02	-249.90	3dd5307908f9499d0e37c2f1fcb0059f	2020-10-23 22:40:36.627841	2020-10-23 22:40:36.627841
6405	2	7	31	2	\N	2020-01-05	-13.00	dafebf341c339693b1855473848fa4ee	2020-10-23 22:40:36.654407	2020-10-23 22:40:36.654407
6406	5	9	-1	2	\N	2020-01-05	-50.00	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:36.655938	2020-10-23 22:40:36.655938
6407	2	6	27	1	\N	2020-01-08	499.80	b40ac2a3761c5ef1abb96e736e99ea13	2020-10-23 22:40:36.657262	2020-10-23 22:40:36.657262
6408	5	5	26	2	\N	2020-01-08	-34.82	a2d43a881f06ae3693c99a57ae919f7e	2020-10-23 22:40:36.658469	2020-10-23 22:40:36.658469
6409	5	1	-1	2	\N	2020-01-09	-9.57	c21e76015a693f739e82095d2b9f8cb2	2020-10-23 22:40:36.659602	2020-10-23 22:40:36.659602
6410	5	1	-1	2	\N	2020-01-09	-11.35	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:36.66113	2020-10-23 22:40:36.66113
6411	1	1	11	2	\N	2020-01-10	-29.50	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.662524	2020-10-23 22:40:36.662524
6412	1	3	12	2	\N	2020-01-10	-118.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:36.663604	2020-10-23 22:40:36.663604
6413	5	1	-1	2	\N	2020-01-11	-149.12	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:36.664582	2020-10-23 22:40:36.664582
6414	5	6	27	2	\N	2020-01-11	-29.98	bf458802928616325f5e4ff7591ca4ff	2020-10-23 22:40:36.665715	2020-10-23 22:40:36.665715
6415	2	1	-1	2	\N	2020-01-12	-61.00	e5f6ad6ce374177eef023bf5d0c018b6	2020-10-23 22:40:36.666786	2020-10-23 22:40:36.666786
6416	2	4	16	2	\N	2020-01-13	-29.99	b3e654bda369607f2a4809e5f3282b52	2020-10-23 22:40:36.667956	2020-10-23 22:40:36.667956
6417	5	5	23	2	\N	2020-01-15	-54.98	b86c05240e1a30474d980f7bee2b2d7c	2020-10-23 22:40:36.6691	2020-10-23 22:40:36.6691
6418	5	1	-1	2	\N	2020-01-15	-15.20	865fe807bb0ed8ffba5fcfd7c12269f5	2020-10-23 22:40:36.670222	2020-10-23 22:40:36.670222
6419	2	4	18	2	\N	2020-01-15	-25.00	b16ca745ad43b243f09726e9138577e3	2020-10-23 22:40:36.671294	2020-10-23 22:40:36.671294
6420	5	1	-1	2	\N	2020-01-15	-294.60	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.672533	2020-10-23 22:40:36.672533
6421	5	8	43	2	\N	2020-01-15	-6.00	b137fdd1f79d56c7edf3365fea7520f2	2020-10-23 22:40:36.673909	2020-10-23 22:40:36.673909
6422	2	9	47	2	\N	2020-01-15	-50.00	992fe32ccaed550899772cc80a40d81f	2020-10-23 22:40:36.675041	2020-10-23 22:40:36.675041
6423	5	7	38	2	\N	2020-01-17	-55.00	2578ca1194ef0f4349adcd77b5706e98	2020-10-23 22:40:36.676039	2020-10-23 22:40:36.676039
6424	5	2	-1	1	\N	2020-01-17	1000.00	dbf9be6a30ab421f18e7c8b89c1baf09	2020-10-23 22:40:36.677351	2020-10-23 22:40:36.677351
6425	2	7	38	2	\N	2020-01-17	-0.80	81e74d678581a3bb7a720b019f4f1a93	2020-10-23 22:40:36.678469	2020-10-23 22:40:36.678469
6426	5	1	-1	2	\N	2020-01-18	-39.59	6f278f85c688b6cf275730b90ec6096c	2020-10-23 22:40:36.679697	2020-10-23 22:40:36.679697
6427	1	2	-1	4	\N	2020-01-16	246.37	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:36.680874	2020-10-23 22:40:36.680874
6428	1	1	-1	2	\N	2020-01-15	-5.60	e8605e9d68694c7da09e41bccb33ba85	2020-10-23 22:40:36.682019	2020-10-23 22:40:36.682019
6429	1	1	-1	2	\N	2020-01-15	-2.80	a6adde77a9376211cdd86ccc21fdc279	2020-10-23 22:40:36.683143	2020-10-23 22:40:36.683143
6430	1	1	-1	2	\N	2020-01-15	-16.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:36.684295	2020-10-23 22:40:36.684295
6431	5	9	53	3	\N	2020-01-19	-246.37	a4300b002bcfb71f291dac175d52df94	2020-10-23 22:40:36.685443	2020-10-23 22:40:36.685443
6432	1	9	53	3	\N	2020-01-19	-20.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.686527	2020-10-23 22:40:36.686527
6433	2	9	47	2	\N	2020-01-20	-50.00	b7923fe9afe7142a24720692484321c5	2020-10-23 22:40:36.687581	2020-10-23 22:40:36.687581
6434	5	1	-1	2	\N	2020-01-21	-90.00	67f7fb873eaf29526a11a9b7ac33bfac	2020-10-23 22:40:36.688542	2020-10-23 22:40:36.688542
6435	2	1	-1	2	\N	2020-01-23	-81.72	0dea65087d23355f98eff21a59a752b9	2020-10-23 22:40:36.689591	2020-10-23 22:40:36.689591
6436	2	5	23	2	\N	2020-01-23	-43.94	3a080b2a2f11ddee1a665fb9807eec24	2020-10-23 22:40:36.690765	2020-10-23 22:40:36.690765
6437	5	8	40	2	\N	2020-01-23	-7.00	e7b24b112a44fdd9ee93bdf998c6ca0e	2020-10-23 22:40:36.691983	2020-10-23 22:40:36.691983
6438	2	5	23	1	\N	2020-01-24	142.97	311428b0fea03a045747eec996709957	2020-10-23 22:40:36.693107	2020-10-23 22:40:36.693107
6439	2	1	-1	2	\N	2020-01-24	-132.92	6da9003b743b65f4c0ccd295cc484e57	2020-10-23 22:40:36.694359	2020-10-23 22:40:36.694359
6440	2	6	27	2	\N	2020-01-24	-21.35	01b27d0d50473fc9d0b524c05f5ea5b6	2020-10-23 22:40:36.695606	2020-10-23 22:40:36.695606
6441	1	9	-1	3	\N	2020-01-26	-80.00	7cb49a36f0c97e7fbe3fdc6ad93d141f	2020-10-23 22:40:36.696763	2020-10-23 22:40:36.696763
6442	1	1	-1	2	\N	2020-01-26	-26.17	c6995debe1404950a319e778b155a40c	2020-10-23 22:40:36.697927	2020-10-23 22:40:36.697927
6443	1	9	50	2	\N	2020-01-26	-5.00	d5f038a4537e6a3f89b32ae3227b6702	2020-10-23 22:40:36.699282	2020-10-23 22:40:36.699282
6444	1	9	-1	2	\N	2020-01-26	-392.27	8bb518e95bb8c25e31ea444ca6549b95	2020-10-23 22:40:36.70033	2020-10-23 22:40:36.70033
6445	1	1	-1	2	\N	2020-01-26	-22.00	42a0e188f5033bc65bf8d78622277c4e	2020-10-23 22:40:36.701413	2020-10-23 22:40:36.701413
6446	1	1	-1	2	\N	2020-01-26	-20.00	8e8969dfa7f61083338ec6f3eb722db3	2020-10-23 22:40:36.70247	2020-10-23 22:40:36.70247
6447	1	8	41	2	\N	2020-01-26	-30.57	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.703583	2020-10-23 22:40:36.703583
6448	1	8	43	2	\N	2020-01-26	-217.05	704afe073992cbe4813cae2f7715336f	2020-10-23 22:40:36.704693	2020-10-23 22:40:36.704693
6449	5	2	-1	4	\N	2020-01-26	1500.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:36.705904	2020-10-23 22:40:36.705904
6450	5	9	53	3	\N	2020-01-26	-217.05	dbe272bab69f8e13f14b405e038deb64	2020-10-23 22:40:36.707139	2020-10-23 22:40:36.707139
6451	1	2	-1	4	\N	2020-01-26	217.05	dbe272bab69f8e13f14b405e038deb64	2020-10-23 22:40:36.708376	2020-10-23 22:40:36.708376
6452	5	9	53	3	\N	2020-01-27	-214.64	6ecbdd6ec859d284dc13885a37ce8d81	2020-10-23 22:40:36.724514	2020-10-23 22:40:36.724514
6453	2	9	53	4	\N	2020-01-27	214.64	6ecbdd6ec859d284dc13885a37ce8d81	2020-10-23 22:40:36.726162	2020-10-23 22:40:36.726162
6454	5	9	53	3	\N	2020-01-27	-151.07	8f53295a73878494e9bc8dd6c3c7104f	2020-10-23 22:40:36.727479	2020-10-23 22:40:36.727479
6455	2	9	53	4	\N	2020-01-27	151.07	8f53295a73878494e9bc8dd6c3c7104f	2020-10-23 22:40:36.728644	2020-10-23 22:40:36.728644
6456	5	9	53	3	\N	2020-01-27	-115.98	0b5c4a1eebab6d8468677877384a76c2	2020-10-23 22:40:36.729702	2020-10-23 22:40:36.729702
6457	2	9	53	4	\N	2020-01-27	115.98	320722549d1751cf3f247855f937b982	2020-10-23 22:40:36.730732	2020-10-23 22:40:36.730732
6458	5	4	16	2	\N	2020-01-27	-49.90	d54c1fa682619ec13c17b308a993232f	2020-10-23 22:40:36.732262	2020-10-23 22:40:36.732262
6459	2	5	21	2	\N	2020-01-28	-49.61	03753883dc14bdd53dab5d175abd09f1	2020-10-23 22:40:36.733562	2020-10-23 22:40:36.733562
6460	5	9	-1	2	\N	2020-01-28	-227.08	57c98783377c2ffe8f993be770162bfa	2020-10-23 22:40:36.734768	2020-10-23 22:40:36.734768
6461	5	4	-1	2	\N	2020-01-29	-96.00	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:36.736066	2020-10-23 22:40:36.736066
6462	2	2	3	1	\N	2020-01-29	7223.19	31b7b72368bd13d8bfca653ccbae5693	2020-10-23 22:40:36.737209	2020-10-23 22:40:36.737209
6463	2	10	54	3	\N	2020-01-29	-3000.00	164f17b765d4a3a9e1ec40c52861b94d	2020-10-23 22:40:36.738362	2020-10-23 22:40:36.738362
6464	5	10	54	4	\N	2020-01-29	3000.00	164f17b765d4a3a9e1ec40c52861b94d	2020-10-23 22:40:36.739457	2020-10-23 22:40:36.739457
6465	2	10	54	3	\N	2020-01-29	-2000.00	efd706e016f655021c0849b9358ac675	2020-10-23 22:40:36.740538	2020-10-23 22:40:36.740538
6466	6	10	54	4	\N	2020-01-29	2000.00	efd706e016f655021c0849b9358ac675	2020-10-23 22:40:36.741635	2020-10-23 22:40:36.741635
6467	2	10	54	3	\N	2020-01-29	-500.00	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:36.742781	2020-10-23 22:40:36.742781
6468	4	10	54	4	\N	2020-01-29	500.00	5ebf8364d17c8df7e4afd586c24f84a0	2020-10-23 22:40:36.744093	2020-10-23 22:40:36.744093
6469	1	9	53	3	\N	2020-02-01	-100.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.745411	2020-10-23 22:40:36.745411
6470	6	10	54	4	\N	2020-02-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.746511	2020-10-23 22:40:36.746511
6471	6	10	54	4	\N	2020-02-01	500.00	4aa85437126656d3ace43c6542b379d4	2020-10-23 22:40:36.747595	2020-10-23 22:40:36.747595
6472	1	2	-1	4	\N	2020-02-01	5987.46	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.748767	2020-10-23 22:40:36.748767
6473	6	10	55	1	\N	2020-02-01	22.09	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.750117	2020-10-23 22:40:36.750117
6474	6	10	55	1	\N	2020-02-01	14.61	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.751249	2020-10-23 22:40:36.751249
6475	1	8	41	2	\N	2020-02-01	-25.60	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.752421	2020-10-23 22:40:36.752421
6476	1	8	41	2	\N	2020-02-01	-45.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:36.753607	2020-10-23 22:40:36.753607
6477	1	9	53	2	\N	2020-02-01	-700.00	df6d2338b2b8fce1ec2f6dda0a630eb0	2020-10-23 22:40:36.754729	2020-10-23 22:40:36.754729
6478	1	9	51	2	\N	2020-02-01	-150.00	30d2c1109139d2f14e57194d12394f01	2020-10-23 22:40:36.755818	2020-10-23 22:40:36.755818
6479	1	10	54	3	\N	2020-02-01	-4000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.756856	2020-10-23 22:40:36.756856
6480	1	8	43	2	\N	2020-02-01	-16.00	b137fdd1f79d56c7edf3365fea7520f2	2020-10-23 22:40:36.758182	2020-10-23 22:40:36.758182
6481	1	7	35	2	\N	2020-02-01	-70.00	468b93d3184e7651de18b0c697eda59d	2020-10-23 22:40:36.759507	2020-10-23 22:40:36.759507
6482	1	9	-1	2	\N	2020-02-01	-178.73	8bb518e95bb8c25e31ea444ca6549b95	2020-10-23 22:40:36.7607	2020-10-23 22:40:36.7607
6483	1	8	43	2	\N	2020-02-01	-42.17	0520a41422ce63b356f79ca728e06b2a	2020-10-23 22:40:36.762199	2020-10-23 22:40:36.762199
6484	5	1	-1	2	\N	2020-02-01	-239.13	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.763659	2020-10-23 22:40:36.763659
6485	5	5	23	2	\N	2020-02-01	-88.00	61d378325fabb23972552783bdacc0a9	2020-10-23 22:40:36.764819	2020-10-23 22:40:36.764819
6486	5	8	43	2	\N	2020-02-01	-140.89	4dce563764ef4ce3e7e63480d81e9682	2020-10-23 22:40:36.76604	2020-10-23 22:40:36.76604
6487	5	5	23	2	\N	2020-01-31	-26.59	6a6226f60f9000ed9395aa58f432e8b7	2020-10-23 22:40:36.76736	2020-10-23 22:40:36.76736
6488	5	8	43	2	\N	2020-01-31	-600.00	dbe862ab956bf427794f823487d61816	2020-10-23 22:40:36.768357	2020-10-23 22:40:36.768357
6489	5	1	-1	2	\N	2020-01-30	-10.02	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:36.769387	2020-10-23 22:40:36.769387
6490	5	5	23	2	\N	2020-01-30	-189.94	661f35eb61cbb63a89430a43c3516a25	2020-10-23 22:40:36.770435	2020-10-23 22:40:36.770435
6491	5	8	43	2	\N	2020-01-29	-237.59	6c9882bbac1c7093bd25041881277658	2020-10-23 22:40:36.771611	2020-10-23 22:40:36.771611
6492	1	2	-1	1	\N	2020-02-01	0.00	aa86045b793fd7fe8baa40e6a6a2dbb6	2020-10-23 22:40:36.77277	2020-10-23 22:40:36.77277
6493	5	4	13	2	\N	2020-02-04	-392.95	d7b24e66a3c4ea77a4a224995bc3899a	2020-10-23 22:40:36.774007	2020-10-23 22:40:36.774007
6494	5	4	15	2	\N	2020-02-04	-103.89	1251b83b9e06b0b4b9cdc614f4160be1	2020-10-23 22:40:36.77538	2020-10-23 22:40:36.77538
6495	5	4	14	2	\N	2020-02-04	-111.25	d4319fefc66c701f24c875afda6360d6	2020-10-23 22:40:36.776449	2020-10-23 22:40:36.776449
6496	2	7	31	2	\N	2020-02-04	-13.00	6c524f9d5d7027454a783c841250ba71	2020-10-23 22:40:36.777586	2020-10-23 22:40:36.777586
6497	1	5	25	2	\N	2020-02-05	-59.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:36.778888	2020-10-23 22:40:36.778888
6498	5	1	-1	2	\N	2020-02-07	-42.97	69adc1e107f7f7d035d7baf04342e1ca	2020-10-23 22:40:36.780271	2020-10-23 22:40:36.780271
6499	5	5	21	2	\N	2020-02-07	-34.36	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:36.781656	2020-10-23 22:40:36.781656
6500	5	8	45	2	\N	2020-02-05	-68.80	6a765ac3b5a3cb073b95357dc8f4fd87	2020-10-23 22:40:36.78284	2020-10-23 22:40:36.78284
6501	5	1	-1	2	\N	2020-02-05	-63.15	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.784183	2020-10-23 22:40:36.784183
6502	5	4	16	2	\N	2020-02-05	-70.00	4bcfb9e52cfc0eb8af8a81e7d73eb3e9	2020-10-23 22:40:36.785495	2020-10-23 22:40:36.785495
6503	2	6	27	2	\N	2020-02-05	-59.98	9c91ba4952ec7cc9395f270984df0a82	2020-10-23 22:40:36.78657	2020-10-23 22:40:36.78657
6504	5	1	-1	2	\N	2020-02-07	-177.67	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.787612	2020-10-23 22:40:36.787612
6505	2	6	27	2	\N	2020-02-11	-59.98	896fc6fe02ebf9f02084d3efd03015a9	2020-10-23 22:40:36.788606	2020-10-23 22:40:36.788606
6506	2	6	27	1	\N	2020-02-11	29.99	22d89fee6a558936882e816a177923a4	2020-10-23 22:40:36.789621	2020-10-23 22:40:36.789621
6507	5	1	-1	2	\N	2020-02-11	-118.65	ccc0aa1b81bf81e16c676ddb977c5881	2020-10-23 22:40:36.790647	2020-10-23 22:40:36.790647
6508	5	8	45	2	\N	2020-02-11	-34.40	de000668f8becda6e1abe88552ac25f7	2020-10-23 22:40:36.791677	2020-10-23 22:40:36.791677
6509	5	4	13	2	\N	2020-02-13	-573.87	8e6b42f1644ecb1327dc03ab345e618b	2020-10-23 22:40:36.792642	2020-10-23 22:40:36.792642
6510	2	4	18	2	\N	2020-02-14	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:36.794374	2020-10-23 22:40:36.794374
6511	2	1	-1	2	\N	2020-02-14	-12.00	e2837a5b2d626abb4d186b41195574ff	2020-10-23 22:40:36.795562	2020-10-23 22:40:36.795562
6512	2	1	-1	1	\N	2020-02-15	10.00	d4c2e4a3297fe25a71d030b67eb83bfc	2020-10-23 22:40:36.797226	2020-10-23 22:40:36.797226
6513	5	1	-1	2	\N	2020-02-16	-362.90	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:36.798294	2020-10-23 22:40:36.798294
6514	2	4	16	2	\N	2020-02-14	-29.99	5313297dda50692d067cee4accd89d46	2020-10-23 22:40:36.799491	2020-10-23 22:40:36.799491
6515	5	8	43	2	\N	2020-02-15	-228.04	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:36.800623	2020-10-23 22:40:36.800623
6516	5	1	-1	1	\N	2020-02-15	42.96	dae00a99f4e5f91349f81eaef529e133	2020-10-23 22:40:36.801958	2020-10-23 22:40:36.801958
6517	1	9	53	3	\N	2020-02-11	-90.00	084c5df23e2412534e96f68477ee7ee6	2020-10-23 22:40:36.803252	2020-10-23 22:40:36.803252
6518	1	8	43	2	\N	2020-02-16	-4.00	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:40:36.804378	2020-10-23 22:40:36.804378
6519	1	9	48	2	\N	2020-02-16	-154.85	1373b2bffa7f7642fde0dd2e982172d7	2020-10-23 22:40:36.805405	2020-10-23 22:40:36.805405
6520	1	5	21	2	\N	2020-02-16	-42.96	cd00692c3bfe59267d5ecfac5310286c	2020-10-23 22:40:36.806475	2020-10-23 22:40:36.806475
6521	1	1	11	2	\N	2020-02-16	-24.95	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.807625	2020-10-23 22:40:36.807625
6522	1	1	-1	2	\N	2020-02-16	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:36.808709	2020-10-23 22:40:36.808709
6523	1	1	11	2	\N	2020-02-16	-9.50	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.809779	2020-10-23 22:40:36.809779
6524	1	1	-1	2	\N	2020-02-16	-50.08	57c98783377c2ffe8f993be770162bfa	2020-10-23 22:40:36.811018	2020-10-23 22:40:36.811018
6525	1	1	11	2	\N	2020-02-16	-13.45	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.812255	2020-10-23 22:40:36.812255
6526	1	7	35	2	\N	2020-02-16	-183.00	1e4725363d155960c84a94870b2b4622	2020-10-23 22:40:36.813337	2020-10-23 22:40:36.813337
6527	5	1	-1	2	\N	2020-02-17	-14.35	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:36.814399	2020-10-23 22:40:36.814399
6528	5	1	-1	2	\N	2020-02-17	-10.05	ef4e3b775c934dada217712d76f3d51f	2020-10-23 22:40:36.815504	2020-10-23 22:40:36.815504
6529	2	5	23	2	\N	2020-02-17	-6.00	8b8c319de4ac8b53bd7d98893f6ac6ea	2020-10-23 22:40:36.816586	2020-10-23 22:40:36.816586
6530	5	5	22	2	\N	2020-02-18	-274.99	1efaf9b6cc3ccfb96ce9f57d68c55599	2020-10-23 22:40:36.817592	2020-10-23 22:40:36.817592
6531	5	5	23	2	\N	2020-02-18	-79.46	42553a9b1d4f3d9ff87d08b3b61b0e84	2020-10-23 22:40:36.818583	2020-10-23 22:40:36.818583
6532	5	1	-1	2	\N	2020-02-18	-166.92	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.81962	2020-10-23 22:40:36.81962
6533	2	6	27	1	\N	2020-02-15	29.99	3b32e93540abe1425efa37772407c9bb	2020-10-23 22:40:36.820652	2020-10-23 22:40:36.820652
6534	5	1	-1	2	\N	2020-02-18	-10.00	a3d8d4ed427d2efe59a7e402c991651f	2020-10-23 22:40:36.821733	2020-10-23 22:40:36.821733
6535	2	5	23	2	\N	2020-02-21	-246.65	b0f607752e5a23af4c523d0f5e60441e	2020-10-23 22:40:36.822781	2020-10-23 22:40:36.822781
6536	5	5	23	2	\N	2020-02-21	-125.00	b0f607752e5a23af4c523d0f5e60441e	2020-10-23 22:40:36.82385	2020-10-23 22:40:36.82385
6537	2	5	23	1	\N	2020-02-21	125.00	b0f607752e5a23af4c523d0f5e60441e	2020-10-23 22:40:36.824862	2020-10-23 22:40:36.824862
6538	5	1	-1	2	\N	2020-02-24	-8.10	2050e03ca119580f74cca14cc6e97462	2020-10-23 22:40:36.82588	2020-10-23 22:40:36.82588
6539	5	5	23	2	\N	2020-02-24	-22.40	4b0a59ddf11c58e7446c9df0da541a84	2020-10-23 22:40:36.827115	2020-10-23 22:40:36.827115
6540	5	5	23	2	\N	2020-02-24	-19.99	1d183655789c74eacc95a75398e6d55c	2020-10-23 22:40:36.828592	2020-10-23 22:40:36.828592
6541	5	4	-1	2	\N	2020-02-24	-15.00	737765366b09ef64c7e90e4ca9b5eabf	2020-10-23 22:40:36.829768	2020-10-23 22:40:36.829768
6542	2	2	3	1	\N	2020-02-26	10434.03	b615d64ae020c5d2cbf80bdade3ae2e2	2020-10-23 22:40:36.830919	2020-10-23 22:40:36.830919
6543	2	10	54	3	\N	2020-02-27	-3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:36.83217	2020-10-23 22:40:36.83217
6544	5	10	54	4	\N	2020-02-27	3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:36.833524	2020-10-23 22:40:36.833524
6545	2	10	54	3	\N	2020-02-27	-1000.00	7d4ab9ed3c0110be73af0fcd7e353f5d	2020-10-23 22:40:36.834537	2020-10-23 22:40:36.834537
6546	4	10	54	4	\N	2020-02-27	1000.00	7d4ab9ed3c0110be73af0fcd7e353f5d	2020-10-23 22:40:36.835549	2020-10-23 22:40:36.835549
6547	5	2	-1	1	\N	2020-02-27	1000.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:36.836529	2020-10-23 22:40:36.836529
6548	5	4	13	2	\N	2020-02-27	-81.38	22951f2450d2131b00c1a0baafda65dc	2020-10-23 22:40:36.837555	2020-10-23 22:40:36.837555
6549	5	4	13	2	\N	2020-02-27	-488.08	e0f1a4afdc30e0724bd9be57355de70e	2020-10-23 22:40:36.838615	2020-10-23 22:40:36.838615
6550	5	10	54	3	\N	2020-02-27	-1000.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:36.839733	2020-10-23 22:40:36.839733
6551	6	10	54	4	\N	2020-02-27	1000.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:36.84122	2020-10-23 22:40:36.84122
6552	5	1	-1	2	\N	2020-02-28	-274.77	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.842252	2020-10-23 22:40:36.842252
6553	5	1	-1	2	\N	2020-02-28	-6.69	8e7c6b19af1fc49034a4b2663e55d987	2020-10-23 22:40:36.843344	2020-10-23 22:40:36.843344
6554	5	4	16	2	\N	2020-02-28	-49.90	d54c1fa682619ec13c17b308a993232f	2020-10-23 22:40:36.84466	2020-10-23 22:40:36.84466
6555	1	9	53	3	\N	2020-02-29	-20.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.845999	2020-10-23 22:40:36.845999
6556	1	1	-1	2	\N	2020-02-29	-13.50	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:36.847257	2020-10-23 22:40:36.847257
6557	1	1	-1	2	\N	2020-02-29	-2.80	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.848412	2020-10-23 22:40:36.848412
6558	1	8	40	2	\N	2020-02-29	-7.00	ffb1a639005c12f3f7a50f76a37f0128	2020-10-23 22:40:36.849468	2020-10-23 22:40:36.849468
6559	1	9	51	2	\N	2020-02-29	-20.00	8a8625ece1d74a011a5616629fe94b1f	2020-10-23 22:40:36.850502	2020-10-23 22:40:36.850502
6560	1	8	43	2	\N	2020-02-29	-197.90	1afa34a7f984eeabdbb0a7d494132ee5	2020-10-23 22:40:36.851556	2020-10-23 22:40:36.851556
6561	1	1	-1	2	\N	2020-02-29	-7.50	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:36.852527	2020-10-23 22:40:36.852527
6562	1	9	48	2	\N	2020-02-29	-600.00	defd40204344c9659a0a3eb4ebc125f6	2020-10-23 22:40:36.853512	2020-10-23 22:40:36.853512
6563	1	1	-1	2	\N	2020-02-29	-8.70	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:36.854514	2020-10-23 22:40:36.854514
6564	1	1	-1	2	\N	2020-02-29	-2.80	f8682da658989b9c52f4f1818928bec7	2020-10-23 22:40:36.855565	2020-10-23 22:40:36.855565
6565	1	2	-1	4	\N	2020-02-29	500.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:36.856655	2020-10-23 22:40:36.856655
6566	5	8	43	2	\N	2020-03-01	-202.24	6c9882bbac1c7093bd25041881277658	2020-10-23 22:40:36.857673	2020-10-23 22:40:36.857673
6567	6	10	55	1	\N	2020-03-01	24.27	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.858722	2020-10-23 22:40:36.858722
6568	6	10	55	1	\N	2020-03-01	15.21	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:36.859748	2020-10-23 22:40:36.859748
6569	1	8	43	2	\N	2020-03-01	-11.00	77726bbfd8c9d1ddde666c077acde196	2020-10-23 22:40:36.861118	2020-10-23 22:40:36.861118
6570	1	2	3	1	\N	2020-03-01	0.00	aa86045b793fd7fe8baa40e6a6a2dbb6	2020-10-23 22:40:36.86242	2020-10-23 22:40:36.86242
6571	1	10	54	4	\N	2020-03-01	6196.85	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.863563	2020-10-23 22:40:36.863563
6572	5	10	54	4	\N	2020-03-01	3500.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.864579	2020-10-23 22:40:36.864579
6573	5	9	53	3	\N	2020-03-01	-500.00	a4a042cf4fd6bfb47701cbc8a1653ada	2020-10-23 22:40:36.86565	2020-10-23 22:40:36.86565
6574	6	10	54	4	\N	2020-03-01	500.00	a4a042cf4fd6bfb47701cbc8a1653ada	2020-10-23 22:40:36.866656	2020-10-23 22:40:36.866656
6575	5	9	53	3	\N	2020-03-01	-1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.867962	2020-10-23 22:40:36.867962
6576	6	10	54	4	\N	2020-03-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.869133	2020-10-23 22:40:36.869133
6577	1	9	53	3	\N	2020-03-01	-1000.00	f1c1592588411002af340cbaedd6fc33	2020-10-23 22:40:36.870252	2020-10-23 22:40:36.870252
6578	5	9	53	3	\N	2020-03-01	-447.90	8c70fffcd96f48b4932ba47fb2346a42	2020-10-23 22:40:36.871456	2020-10-23 22:40:36.871456
6579	1	2	-1	4	\N	2020-03-01	447.90	8c70fffcd96f48b4932ba47fb2346a42	2020-10-23 22:40:36.872779	2020-10-23 22:40:36.872779
6580	1	9	53	3	\N	2020-03-01	-4500.00	acfe2016fa13e98581d46526c6b9695e	2020-10-23 22:40:36.8739	2020-10-23 22:40:36.8739
6581	1	9	51	2	\N	2020-03-01	-150.00	30d2c1109139d2f14e57194d12394f01	2020-10-23 22:40:36.875101	2020-10-23 22:40:36.875101
6582	1	8	41	2	\N	2020-03-01	-45.00	4f9169c176b5cdf950180c6cd33cec5e	2020-10-23 22:40:36.8763	2020-10-23 22:40:36.8763
6583	1	8	41	2	\N	2020-03-01	-21.20	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.877412	2020-10-23 22:40:36.877412
6584	1	9	53	3	\N	2020-03-01	-20.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.878847	2020-10-23 22:40:36.878847
6585	5	1	-1	2	\N	2020-03-02	-100.10	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.880373	2020-10-23 22:40:36.880373
6586	5	8	43	2	\N	2020-03-04	-300.00	b056eb1587586b71e2da9acfe4fbd19e	2020-10-23 22:40:36.881487	2020-10-23 22:40:36.881487
6587	5	1	-1	2	\N	2020-03-04	-11.95	df55215a72c9c74bc47076f59b5b2ea2	2020-10-23 22:40:36.88268	2020-10-23 22:40:36.88268
6588	5	10	54	3	\N	2020-03-04	-2500.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:36.883797	2020-10-23 22:40:36.883797
6589	6	10	54	4	\N	2020-03-04	2500.00	d6eb9369eb4ab926c2611722566d64d7	2020-10-23 22:40:36.884973	2020-10-23 22:40:36.884973
6590	1	2	-1	1	\N	2020-03-04	17.00	f830ba4cee864c087fac4c3a5abb01ab	2020-10-23 22:40:36.886136	2020-10-23 22:40:36.886136
6591	1	2	-1	4	\N	2020-03-04	120.00	d233bde0af1035da94aecb0b0583be5e	2020-10-23 22:40:36.887276	2020-10-23 22:40:36.887276
6592	5	9	53	3	\N	2020-03-04	-120.00	d233bde0af1035da94aecb0b0583be5e	2020-10-23 22:40:36.888481	2020-10-23 22:40:36.888481
6593	1	9	53	3	\N	2020-03-04	-200.00	5ed40cc0659d685215b4897e21fa3cab	2020-10-23 22:40:36.889611	2020-10-23 22:40:36.889611
6594	6	10	54	4	\N	2020-03-04	200.00	5ed40cc0659d685215b4897e21fa3cab	2020-10-23 22:40:36.890642	2020-10-23 22:40:36.890642
6595	1	5	22	2	\N	2020-03-06	-370.00	80bb3759b7d1c02f3d37e11bdc835159	2020-10-23 22:40:36.891687	2020-10-23 22:40:36.891687
6596	1	1	11	2	\N	2020-03-06	-18.95	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.89267	2020-10-23 22:40:36.89267
6597	1	9	48	2	\N	2020-03-07	-24.92	ff8408738b5820e10c31b1d7843a9285	2020-10-23 22:40:36.893914	2020-10-23 22:40:36.893914
6598	1	1	11	2	\N	2020-03-05	-12.60	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.895314	2020-10-23 22:40:36.895314
6599	1	8	40	2	\N	2020-03-05	-7.00	61c9e7fb675f02218005d1e319984736	2020-10-23 22:40:36.89661	2020-10-23 22:40:36.89661
6600	5	1	-1	2	\N	2020-03-07	-31.47	85fc37b18c57097425b52fc7afbb6969	2020-10-23 22:40:36.897937	2020-10-23 22:40:36.897937
6601	5	4	16	2	\N	2020-03-07	-70.00	e2a2dcc36a08a345332c751b2f2e476c	2020-10-23 22:40:36.899553	2020-10-23 22:40:36.899553
6602	5	1	-1	2	\N	2020-03-07	-216.30	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.900947	2020-10-23 22:40:36.900947
6603	5	5	23	2	\N	2020-03-12	-32.97	6da9003b743b65f4c0ccd295cc484e57	2020-10-23 22:40:36.90219	2020-10-23 22:40:36.90219
6604	5	9	-1	2	\N	2020-03-12	-4.10	22951f2450d2131b00c1a0baafda65dc	2020-10-23 22:40:36.903428	2020-10-23 22:40:36.903428
6605	5	5	23	2	\N	2020-03-12	-88.95	f6c133924af9a1fee113960ac453662a	2020-10-23 22:40:36.904654	2020-10-23 22:40:36.904654
6606	2	1	-1	2	\N	2020-03-12	-118.93	f339d22c4278461f6deec62a26586686	2020-10-23 22:40:36.905801	2020-10-23 22:40:36.905801
6607	5	8	43	2	\N	2020-03-12	-100.00	b056eb1587586b71e2da9acfe4fbd19e	2020-10-23 22:40:36.906917	2020-10-23 22:40:36.906917
6608	1	8	40	2	\N	2020-03-16	-2.00	d66f248b690954fd2b84b58193d1391c	2020-10-23 22:40:36.90795	2020-10-23 22:40:36.90795
6609	1	5	22	2	\N	2020-03-16	-370.00	b26b5bd439240902daba36f49e55f985	2020-10-23 22:40:36.909084	2020-10-23 22:40:36.909084
6610	5	1	-1	2	\N	2020-03-16	-130.36	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.910409	2020-10-23 22:40:36.910409
6611	1	1	-1	2	\N	2020-03-16	-2.80	f74c6339bd99053e6d6c5905b35dd2b7	2020-10-23 22:40:36.911793	2020-10-23 22:40:36.911793
6612	1	1	-1	2	\N	2020-03-16	-3.20	5d3bb24bd96c8b1e38c187c8039bdc3e	2020-10-23 22:40:36.913264	2020-10-23 22:40:36.913264
6613	1	9	48	2	\N	2020-03-16	-16.00	ea88400b72f68ba4b46eaac3db07b41a	2020-10-23 22:40:36.914524	2020-10-23 22:40:36.914524
6614	1	1	-1	2	\N	2020-03-16	-183.00	c143901dfd95e6cc334954e0d37ee65c	2020-10-23 22:40:36.915667	2020-10-23 22:40:36.915667
6615	5	5	23	2	\N	2020-03-16	-8.00	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:36.916715	2020-10-23 22:40:36.916715
6616	5	1	-1	2	\N	2020-03-16	-142.82	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.918075	2020-10-23 22:40:36.918075
6617	5	1	-1	2	\N	2020-03-16	-243.94	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.919285	2020-10-23 22:40:36.919285
6618	5	5	23	2	\N	2020-03-16	-11.99	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:36.920357	2020-10-23 22:40:36.920357
6619	5	5	23	2	\N	2020-03-16	-44.46	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:36.92143	2020-10-23 22:40:36.92143
6620	5	8	43	2	\N	2020-03-16	-216.92	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:36.922459	2020-10-23 22:40:36.922459
6621	5	2	-1	1	\N	2020-03-16	4350.00	a4d751f128596dee5517d8a007e6ea02	2020-10-23 22:40:36.924347	2020-10-23 22:40:36.924347
6622	5	9	53	3	\N	2020-03-16	-3500.00	2e7f585062fd382544f72bdbea6712f0	2020-10-23 22:40:36.92567	2020-10-23 22:40:36.92567
6623	6	10	54	4	\N	2020-03-16	3500.00	2e7f585062fd382544f72bdbea6712f0	2020-10-23 22:40:36.926744	2020-10-23 22:40:36.926744
6624	2	4	18	2	\N	2020-03-19	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:36.927979	2020-10-23 22:40:36.927979
6625	5	10	54	4	\N	2020-03-17	2000.00	bff5898d193afb27fbce600cb1301528	2020-10-23 22:40:36.929565	2020-10-23 22:40:36.929565
6626	5	1	-1	2	\N	2020-03-22	-128.53	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.930882	2020-10-23 22:40:36.930882
6627	2	4	19	2	\N	2020-03-23	-1780.00	6ce5608d8200ff569a8d736f4e0830d9	2020-10-23 22:40:36.932027	2020-10-23 22:40:36.932027
6628	2	10	54	3	\N	2020-03-23	-2000.00	8649d08b16b9b12ae93322a1936015ea	2020-10-23 22:40:36.933095	2020-10-23 22:40:36.933095
6629	6	10	54	4	\N	2020-03-23	2000.00	5dd9db5e033da9c6fb5ba83c7a7ebea9	2020-10-23 22:40:36.934171	2020-10-23 22:40:36.934171
6630	6	10	54	3	\N	2020-03-17	-2000.00	922aa8292277aac1bd8b88d476997512	2020-10-23 22:40:36.935208	2020-10-23 22:40:36.935208
6631	5	1	-1	2	\N	2020-03-23	-321.93	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.936747	2020-10-23 22:40:36.936747
6632	1	9	53	3	\N	2020-03-29	-30.00	a7aeed74714116f3b292a982238f83d2	2020-10-23 22:40:36.937959	2020-10-23 22:40:36.937959
6633	5	9	49	2	\N	2020-03-29	-180.00	3a05edc134bbbd8391d9de47f97e20c5	2020-10-23 22:40:36.939059	2020-10-23 22:40:36.939059
6634	5	9	53	3	\N	2020-03-29	-1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.94012	2020-10-23 22:40:36.94012
6635	6	10	54	4	\N	2020-03-29	1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:36.941508	2020-10-23 22:40:36.941508
6636	1	2	-1	1	\N	2020-03-29	183.00	2dd5590d38ef348e84a69e8ca646d13d	2020-10-23 22:40:36.942594	2020-10-23 22:40:36.942594
6637	1	4	-1	2	\N	2020-03-29	-73.00	59ebb570a2fe7f06eba12b50698b278c	2020-10-23 22:40:36.943696	2020-10-23 22:40:36.943696
6638	1	9	49	2	\N	2020-03-29	-1689.90	cfecdb276f634854f3ef915e2e980c31	2020-10-23 22:40:36.945383	2020-10-23 22:40:36.945383
6639	1	2	-1	4	\N	2020-03-29	1600.00	cfecdb276f634854f3ef915e2e980c31	2020-10-23 22:40:36.946489	2020-10-23 22:40:36.946489
6640	2	2	3	1	\N	2020-03-27	7336.53	ef84407769f8cdbe00f4902bf2b256f0	2020-10-23 22:40:36.947521	2020-10-23 22:40:36.947521
6641	2	10	54	3	\N	2020-03-29	-3000.00	219ca63b478b215b8e145532c5e79a65	2020-10-23 22:40:36.948623	2020-10-23 22:40:36.948623
6642	5	10	54	4	\N	2020-03-29	3000.00	219ca63b478b215b8e145532c5e79a65	2020-10-23 22:40:36.949855	2020-10-23 22:40:36.949855
6643	5	4	13	2	\N	2020-03-29	-488.08	9fd81843ad7f202f26c1a174c7357585	2020-10-23 22:40:36.951028	2020-10-23 22:40:36.951028
6644	5	4	16	2	\N	2020-03-29	-49.90	fe292c59c55768f7b35ec393e249760e	2020-10-23 22:40:36.95227	2020-10-23 22:40:36.95227
6645	5	4	14	2	\N	2020-03-29	-108.92	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:36.953617	2020-10-23 22:40:36.953617
6646	5	4	15	2	\N	2020-03-29	-243.50	a7228a7d885a3f09046ee2a8fb2e3252	2020-10-23 22:40:36.95495	2020-10-23 22:40:36.95495
6647	2	10	54	3	\N	2020-03-29	-2500.00	3ee13bad273a0cf15204ed51a77e236c	2020-10-23 22:40:36.956263	2020-10-23 22:40:36.956263
6648	6	10	54	4	\N	2020-03-29	2500.00	c3b441075396e38f0210808c66976f9a	2020-10-23 22:40:36.957454	2020-10-23 22:40:36.957454
6649	2	10	54	3	\N	2020-03-29	-500.00	85118f551cd104d25a2971693c3bc254	2020-10-23 22:40:36.958654	2020-10-23 22:40:36.958654
6650	4	10	54	4	\N	2020-03-29	500.00	85118f551cd104d25a2971693c3bc254	2020-10-23 22:40:36.959842	2020-10-23 22:40:36.959842
6651	5	1	-1	2	\N	2020-03-31	-311.12	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:36.961079	2020-10-23 22:40:36.961079
6652	5	9	49	2	\N	2020-03-31	-37.55	936ee4bdb7091d965b2907330d65fdaa	2020-10-23 22:40:36.962287	2020-10-23 22:40:36.962287
6653	6	10	55	1	\N	2020-03-31	31.91	f3024e1e60e8aa70f7c59b4287de9ef0	2020-10-23 22:40:36.963404	2020-10-23 22:40:36.963404
6654	6	10	55	1	\N	2020-03-31	18.02	b83aac23b9528732c23cc7352950e880	2020-10-23 22:40:36.964993	2020-10-23 22:40:36.964993
6655	5	9	53	3	\N	2020-04-01	-1000.00	9fa56a63bae9e526e1bde54c8acfd9e9	2020-10-23 22:40:36.966232	2020-10-23 22:40:36.966232
6656	1	2	-1	4	\N	2020-04-01	0.00	aa86045b793fd7fe8baa40e6a6a2dbb6	2020-10-23 22:40:36.967348	2020-10-23 22:40:36.967348
6657	1	2	-1	4	\N	2020-04-01	5992.45	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:40:36.968453	2020-10-23 22:40:36.968453
6658	5	2	-1	4	\N	2020-04-01	3500.00	a92263c38f1d4427e98d0a4a163d5c97	2020-10-23 22:40:36.969686	2020-10-23 22:40:36.969686
6659	1	9	-1	3	\N	2020-04-01	-400.00	f1c1592588411002af340cbaedd6fc33	2020-10-23 22:40:36.970826	2020-10-23 22:40:36.970826
6660	5	9	53	3	\N	2020-04-01	-500.00	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:40:36.972455	2020-10-23 22:40:36.972455
6661	6	10	54	4	\N	2020-04-01	500.00	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:40:36.973525	2020-10-23 22:40:36.973525
6662	5	9	53	3	\N	2020-04-01	-1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.974564	2020-10-23 22:40:36.974564
6663	6	10	54	4	\N	2020-04-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:36.975636	2020-10-23 22:40:36.975636
6664	1	8	41	2	\N	2020-04-01	-15.20	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:36.976754	2020-10-23 22:40:36.976754
6665	1	9	53	3	\N	2020-04-01	-30.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:36.977945	2020-10-23 22:40:36.977945
6666	1	9	53	3	\N	2020-04-01	-5000.00	6a3b5c5a20b01f9952f1f2c17bdd8a52	2020-10-23 22:40:36.979369	2020-10-23 22:40:36.979369
6667	1	9	51	2	\N	2020-04-01	-150.00	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:40:36.980458	2020-10-23 22:40:36.980458
6668	2	4	16	2	\N	2020-04-02	-13.00	149e9677a5989fd342ae44213df68868	2020-10-23 22:40:36.981496	2020-10-23 22:40:36.981496
6669	5	8	18	2	\N	2020-04-02	-592.00	89a315baa3536db9180ebd6794202fa8	2020-10-23 22:40:36.982513	2020-10-23 22:40:36.982513
6670	5	10	54	3	\N	2020-04-03	-2000.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:40:36.983912	2020-10-23 22:40:36.983912
6671	6	10	54	4	\N	2020-04-03	2000.00	fd16e067040340f4460315d9b0801ab0	2020-10-23 22:40:36.985208	2020-10-23 22:40:36.985208
6672	6	9	53	3	\N	2020-04-05	-1000.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:36.986372	2020-10-23 22:40:36.986372
6673	5	2	-1	4	\N	2020-04-05	1000.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:36.987718	2020-10-23 22:40:36.987718
6674	5	1	-1	2	\N	2020-04-05	-488.53	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:36.988966	2020-10-23 22:40:36.988966
6675	5	4	16	2	\N	2020-04-05	-70.00	1905aedab9bf2477edc068a355bba31a	2020-10-23 22:40:36.990166	2020-10-23 22:40:36.990166
6676	5	2	-1	1	\N	2020-04-11	1000.00	ea6f96d684fcea2caa82e4e262810723	2020-10-23 22:40:36.991231	2020-10-23 22:40:36.991231
6677	5	9	53	3	\N	2020-04-11	-1000.00	ea6f96d684fcea2caa82e4e262810723	2020-10-23 22:40:36.992282	2020-10-23 22:40:36.992282
6678	5	5	23	2	\N	2020-04-13	-464.45	0b4fd578fa85b9d3ad197fb3a5fbf4db	2020-10-23 22:40:36.99338	2020-10-23 22:40:36.99338
6679	5	1	-1	2	\N	2020-04-15	-189.19	fc3cf452d3da8402bebb765225ce8c0e	2020-10-23 22:40:36.994585	2020-10-23 22:40:36.994585
6680	2	6	27	2	\N	2020-04-15	-159.90	10a6165b2aa40b3f6252923608c859e8	2020-10-23 22:40:36.995864	2020-10-23 22:40:36.995864
6681	2	6	27	1	\N	2020-04-15	89.93	6b2fad52729428b9256d6ddfe45feb31	2020-10-23 22:40:36.997426	2020-10-23 22:40:36.997426
6682	1	6	27	2	\N	2020-04-17	-89.93	03c67da1cd19e9c82e8373fb3bf0f476	2020-10-23 22:40:36.998581	2020-10-23 22:40:36.998581
6683	1	7	36	2	\N	2020-04-18	-39.95	7378bfed68f89ff95e4c60884628cb16	2020-10-23 22:40:36.999833	2020-10-23 22:40:36.999833
6684	1	9	53	3	\N	2020-02-22	-200.00	43acfb3c016819505e96a8544f2d9660	2020-10-23 22:40:37.000978	2020-10-23 22:40:37.000978
6685	5	2	-1	4	\N	2020-02-22	200.00	43acfb3c016819505e96a8544f2d9660	2020-10-23 22:40:37.002115	2020-10-23 22:40:37.002115
6686	5	1	-1	2	\N	2020-04-23	-293.73	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:37.003479	2020-10-23 22:40:37.003479
6687	5	4	16	2	\N	2020-04-23	-49.90	a22f516e1504face1e7fd70924199e5c	2020-10-23 22:40:37.004604	2020-10-23 22:40:37.004604
6688	5	7	36	2	\N	2020-04-23	-6.94	44fe455c4ce5034fbe4788b5066fb80f	2020-10-23 22:40:37.005657	2020-10-23 22:40:37.005657
6689	2	9	53	3	\N	2020-04-23	-1400.00	86c5d849e25cdf86c4a67239415925c6	2020-10-23 22:40:37.006664	2020-10-23 22:40:37.006664
6690	5	2	-1	4	\N	2020-04-23	1400.00	86c5d849e25cdf86c4a67239415925c6	2020-10-23 22:40:37.007719	2020-10-23 22:40:37.007719
6691	4	9	53	3	\N	2020-04-23	-500.00	7bf287d67cf7616daac1859e37ea8a5b	2020-10-23 22:40:37.008852	2020-10-23 22:40:37.008852
6692	2	2	-1	4	\N	2020-04-23	503.34	7bf287d67cf7616daac1859e37ea8a5b	2020-10-23 22:40:37.010329	2020-10-23 22:40:37.010329
6693	2	5	21	2	\N	2020-04-29	-23.98	01161aaa0b6d1345dd8fe4e481144d84	2020-10-23 22:40:37.011741	2020-10-23 22:40:37.011741
6694	2	2	3	1	\N	2020-04-29	7059.50	7b03619fa0825678c6ad07bb587216f2	2020-10-23 22:40:37.01312	2020-10-23 22:40:37.01312
6695	2	4	18	2	\N	2020-04-29	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:37.014366	2020-10-23 22:40:37.014366
6696	5	2	3	1	\N	2020-04-29	500.00	92d19640d5111f21609dbfbf8567b688	2020-10-23 22:40:37.015624	2020-10-23 22:40:37.015624
6697	5	5	23	2	\N	2020-04-29	-283.72	1373b2bffa7f7642fde0dd2e982172d7	2020-10-23 22:40:37.016828	2020-10-23 22:40:37.016828
6698	2	10	54	3	\N	2020-04-29	-3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:37.017924	2020-10-23 22:40:37.017924
6699	5	10	54	4	\N	2020-04-29	3000.00	686a28313cd8becaa6e43b63517ff612	2020-10-23 22:40:37.019065	2020-10-23 22:40:37.019065
6700	5	5	23	2	\N	2020-04-30	-204.91	df877f3865752637daa540ea9cbc474f	2020-10-23 22:40:37.0203	2020-10-23 22:40:37.0203
6701	5	1	-1	2	\N	2020-04-30	-332.82	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:37.021308	2020-10-23 22:40:37.021308
6702	5	9	-1	2	\N	2020-04-30	-200.00	2ba100d60448c3b5fe2dc55a892104f0	2020-10-23 22:40:37.02241	2020-10-23 22:40:37.02241
6703	5	4	13	2	\N	2020-04-30	-488.08	65b9eea6e1cc6bb9f0cd2a47751a186f	2020-10-23 22:40:37.023494	2020-10-23 22:40:37.023494
6704	5	4	15	2	\N	2020-04-30	-89.99	f9a40a4780f5e1306c46f1c8daecee3b	2020-10-23 22:40:37.02466	2020-10-23 22:40:37.02466
6705	1	2	-1	4	\N	2020-04-30	200.00	dff4f135ef796247aa8ae9da2c4c6c8e	2020-10-23 22:40:37.025874	2020-10-23 22:40:37.025874
6706	1	9	53	3	\N	2020-04-30	-75.22	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:40:37.027079	2020-10-23 22:40:37.027079
6707	5	2	-1	4	\N	2020-04-30	75.22	f56a4e35ceb23466f6ecf1dd4e40f816	2020-10-23 22:40:37.028289	2020-10-23 22:40:37.028289
6708	6	10	55	1	\N	2020-05-01	39.62	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.029545	2020-10-23 22:40:37.029545
6709	6	10	55	1	\N	2020-05-01	19.74	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.030589	2020-10-23 22:40:37.030589
6710	5	2	-1	1	\N	2020-05-01	1340.82	eb80b8864bc8a8df368d95cac8ecf372	2020-10-23 22:40:37.031703	2020-10-23 22:40:37.031703
6711	5	9	53	3	\N	2020-05-01	-71.00	a1f73568850e480e957b52e8952e8a4e	2020-10-23 22:40:37.03271	2020-10-23 22:40:37.03271
6712	1	2	-1	4	\N	2020-05-01	71.00	a1f73568850e480e957b52e8952e8a4e	2020-10-23 22:40:37.033857	2020-10-23 22:40:37.033857
6713	6	10	54	4	\N	2020-05-01	500.00	96a00fe0f015b6a6695785625a4350ae	2020-10-23 22:40:37.035078	2020-10-23 22:40:37.035078
6714	6	10	54	4	\N	2020-05-01	1500.00	ce1a17d5c8412cf57ccd11891b6f51b3	2020-10-23 22:40:37.03616	2020-10-23 22:40:37.03616
6715	5	10	54	4	\N	2020-05-01	1000.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:40:37.037337	2020-10-23 22:40:37.037337
6716	1	2	-1	4	\N	2020-05-01	16117.60	bdcbe0e09f9b05829ed552e01babea04	2020-10-23 22:40:37.038421	2020-10-23 22:40:37.038421
6717	1	9	53	3	\N	2020-05-01	-15000.00	30f78cd500afd51e75d8351e4418ed9a	2020-10-23 22:40:37.039571	2020-10-23 22:40:37.039571
6718	1	9	53	3	\N	2020-05-01	-30.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:37.040652	2020-10-23 22:40:37.040652
6719	1	9	51	2	\N	2020-05-01	-150.00	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:40:37.041867	2020-10-23 22:40:37.041867
6720	2	9	51	2	\N	2020-05-03	-50.00	45d9e8a1f050027058ffd6e208f31caa	2020-10-23 22:40:37.042983	2020-10-23 22:40:37.042983
6721	5	10	54	3	\N	2020-05-04	-1300.00	0e01938fc48a2cfb5f2217fbfb00722d	2020-10-23 22:40:37.04421	2020-10-23 22:40:37.04421
6722	6	10	54	4	\N	2020-05-04	1300.00	0e01938fc48a2cfb5f2217fbfb00722d	2020-10-23 22:40:37.045818	2020-10-23 22:40:37.045818
6723	5	4	16	2	\N	2020-05-04	-70.00	b19ecf34e19dc5a67d9aa76728133e59	2020-10-23 22:40:37.046944	2020-10-23 22:40:37.046944
6724	1	9	48	2	\N	2020-05-04	-208.66	82f2b308c3b01637c607ce05f52a2fed	2020-10-23 22:40:37.048018	2020-10-23 22:40:37.048018
6725	2	4	16	2	\N	2020-05-04	-13.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:37.049071	2020-10-23 22:40:37.049071
6726	1	3	12	2	\N	2020-05-07	-445.50	f2fc990265c712c49d51a18a32b39f0c	2020-10-23 22:40:37.050224	2020-10-23 22:40:37.050224
6727	5	8	43	2	\N	2020-05-08	-101.06	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.051813	2020-10-23 22:40:37.051813
6728	5	8	43	2	\N	2020-05-08	-594.00	3848808e4e42fdc33de064464cdac6df	2020-10-23 22:40:37.053796	2020-10-23 22:40:37.053796
6729	5	1	-1	2	\N	2020-05-07	-253.89	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:37.055261	2020-10-23 22:40:37.055261
6730	2	9	48	2	\N	2020-05-08	-397.50	b2dd7d505d68df0b925e5045ce8d4c8f	2020-10-23 22:40:37.056475	2020-10-23 22:40:37.056475
6731	2	9	48	2	\N	2020-05-08	-44.40	8170395a8a20582b582b805d5b5e21c8	2020-10-23 22:40:37.057636	2020-10-23 22:40:37.057636
6732	5	2	-1	1	\N	2020-05-11	139.95	ace4eadc8ba7f37ce292e6aef3ec64f1	2020-10-23 22:40:37.058775	2020-10-23 22:40:37.058775
6733	5	2	-1	1	\N	2020-05-11	79.18	ace4eadc8ba7f37ce292e6aef3ec64f1	2020-10-23 22:40:37.059885	2020-10-23 22:40:37.059885
6734	5	5	22	2	\N	2020-05-12	-360.00	3cb5c81480a83ab9e47c60fa2b86e404	2020-10-23 22:40:37.061272	2020-10-23 22:40:37.061272
6735	5	10	54	3	\N	2020-05-13	-3000.00	0b594a627d2947eb71ccd66f476fa9ad	2020-10-23 22:40:37.062477	2020-10-23 22:40:37.062477
6736	6	10	54	4	\N	2020-05-13	3000.00	0b594a627d2947eb71ccd66f476fa9ad	2020-10-23 22:40:37.063664	2020-10-23 22:40:37.063664
6737	6	10	54	4	\N	2020-05-18	1300.00	f64eac11f2cd8f0efa196f8ad173178e	2020-10-23 22:40:37.065537	2020-10-23 22:40:37.065537
6738	6	10	54	4	\N	2020-05-18	2500.00	210f760a89db30aa72ca258a3483cc7f	2020-10-23 22:40:37.067368	2020-10-23 22:40:37.067368
6739	1	9	-1	2	\N	2020-05-18	-9.80	0edaec591e2043aa9e36626c839fce18	2020-10-23 22:40:37.069084	2020-10-23 22:40:37.069084
6740	1	9	53	3	\N	2020-05-16	-60.00	e97ee2054defb209c35fe4dc94599061	2020-10-23 22:40:37.07027	2020-10-23 22:40:37.07027
6741	1	9	49	2	\N	2020-05-16	-3578.01	db780008ffa192e7447f125de2ccdbe2	2020-10-23 22:40:37.071422	2020-10-23 22:40:37.071422
6742	1	2	-1	4	\N	2020-05-16	3463.62	b1eec33c726a60554bc78518d5f9b32c	2020-10-23 22:40:37.07259	2020-10-23 22:40:37.07259
6743	1	9	49	2	\N	2020-05-16	-78.00	ea88400b72f68ba4b46eaac3db07b41a	2020-10-23 22:40:37.073737	2020-10-23 22:40:37.073737
6744	5	8	43	2	\N	2020-05-17	-149.74	ec0e8bfa8e2eeec52f917e398efdfaf4	2020-10-23 22:40:37.074867	2020-10-23 22:40:37.074867
6745	5	5	23	2	\N	2020-05-16	-93.07	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:37.075925	2020-10-23 22:40:37.075925
6746	5	1	-1	2	\N	2020-05-15	-420.19	a7a2b843de676ba54755e12be4ad3213	2020-10-23 22:40:37.076997	2020-10-23 22:40:37.076997
6747	1	5	25	2	\N	2020-05-21	-60.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:37.078135	2020-10-23 22:40:37.078135
6748	5	1	-1	2	\N	2020-05-21	-142.30	c23d9fcedcea5273f780155be19c511d	2020-10-23 22:40:37.079525	2020-10-23 22:40:37.079525
6749	5	4	16	2	\N	2020-05-21	-49.90	93a4e159a18aad5a41f9e3c4ab42f21e	2020-10-23 22:40:37.081558	2020-10-23 22:40:37.081558
6750	5	9	48	2	\N	2020-05-27	-248.78	37bd5d78ad893082420e4095aa6404db	2020-10-23 22:40:37.083625	2020-10-23 22:40:37.083625
6751	1	5	21	2	\N	2020-05-26	-38.77	e64770ac6bac05626b4f59b6a03e2ff8	2020-10-23 22:40:37.085032	2020-10-23 22:40:37.085032
6752	1	2	-1	4	\N	2020-05-22	500.00	766ebcd59621e305170616ba3d3dac32	2020-10-23 22:40:37.086121	2020-10-23 22:40:37.086121
6753	1	9	50	2	\N	2020-05-22	-7.50	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:40:37.08757	2020-10-23 22:40:37.08757
6754	1	9	-1	2	\N	2020-05-22	-9.80	0edaec591e2043aa9e36626c839fce18	2020-10-23 22:40:37.088748	2020-10-23 22:40:37.088748
6755	1	9	53	2	\N	2020-05-22	-250.00	d14220ee66aeec73c49038385428ec4c	2020-10-23 22:40:37.089868	2020-10-23 22:40:37.089868
6756	2	9	48	2	\N	2020-05-22	-106.69	2b03a11699c62b969e1636e984d056db	2020-10-23 22:40:37.090978	2020-10-23 22:40:37.090978
6757	2	4	18	2	\N	2020-05-22	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:37.092028	2020-10-23 22:40:37.092028
6758	2	2	3	1	\N	2020-05-28	7336.53	c6b6db39bda331c92902c6d2848151e9	2020-10-23 22:40:37.093198	2020-10-23 22:40:37.093198
6759	2	10	54	3	\N	2020-05-28	-3000.00	452d9d2ddc00d8762d5b580c0aaee5c9	2020-10-23 22:40:37.094656	2020-10-23 22:40:37.094656
6760	5	10	54	4	\N	2020-05-28	3000.00	452d9d2ddc00d8762d5b580c0aaee5c9	2020-10-23 22:40:37.096071	2020-10-23 22:40:37.096071
6761	2	10	54	3	\N	2020-05-28	-2000.00	21f64e3ec83330fbc425f52ff209c835	2020-10-23 22:40:37.097516	2020-10-23 22:40:37.097516
6762	4	10	54	4	\N	2020-05-28	2000.00	824da999fd3743e7d4e6e19246b0cb55	2020-10-23 22:40:37.098532	2020-10-23 22:40:37.098532
6763	2	5	23	2	\N	2020-05-22	-49.97	53c3ca51d2a9d2b61ca543cdfc800c02	2020-10-23 22:40:37.099559	2020-10-23 22:40:37.099559
6764	5	1	-1	2	\N	2020-05-28	-229.88	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:37.100658	2020-10-23 22:40:37.100658
6765	6	10	55	1	\N	2020-05-31	46.28	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.101674	2020-10-23 22:40:37.101674
6766	6	10	55	1	\N	2020-05-31	22.87	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.102706	2020-10-23 22:40:37.102706
6767	6	10	55	1	\N	2020-05-31	34.42	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.103925	2020-10-23 22:40:37.103925
6768	1	9	-1	2	\N	2020-06-01	0.00	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:40:37.105083	2020-10-23 22:40:37.105083
6769	6	10	54	4	\N	2020-06-01	441.50	a9e5f1f3465c0d01949c66ce74733d70	2020-10-23 22:40:37.106344	2020-10-23 22:40:37.106344
6770	6	10	54	4	\N	2020-06-01	10358.50	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:37.107358	2020-10-23 22:40:37.107358
6771	1	9	53	3	\N	2020-06-01	-23.00	272dec0a14ee301b59ec3ec6bff6ec3e	2020-10-23 22:40:37.108339	2020-10-23 22:40:37.108339
6772	6	10	54	4	\N	2020-06-01	500.00	1068c6e4c8051cfd4e9ea8072e3189e2	2020-10-23 22:40:37.109343	2020-10-23 22:40:37.109343
6773	6	10	54	4	\N	2020-06-01	1500.00	f7e64c1c226734fe86b6c91bd01cf9f5	2020-10-23 22:40:37.110373	2020-10-23 22:40:37.110373
6774	5	10	54	4	\N	2020-06-01	1500.00	e2c0be24560d78c5e599c2a9c9d0bbd2	2020-10-23 22:40:37.111848	2020-10-23 22:40:37.111848
6775	1	9	53	3	\N	2020-06-01	-2500.00	c2d128461711cb0d371c986a4a7cc001	2020-10-23 22:40:37.113161	2020-10-23 22:40:37.113161
6776	1	2	-1	4	\N	2020-06-01	6484.69	e205ee2a5de471a70c1fd1b46033a75f	2020-10-23 22:40:37.114288	2020-10-23 22:40:37.114288
6777	1	9	51	2	\N	2020-06-01	-150.00	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:40:37.115272	2020-10-23 22:40:37.115272
6778	5	1	-1	2	\N	2020-06-03	-266.01	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:37.116381	2020-10-23 22:40:37.116381
6779	2	9	53	3	\N	2020-06-03	-1500.00	68264bdb65b97eeae6788aa3348e553c	2020-10-23 22:40:37.117522	2020-10-23 22:40:37.117522
6780	5	7	30	2	\N	2020-06-03	-300.00	1c222c9181f2dfcc08ca42e869cf88c8	2020-10-23 22:40:37.118699	2020-10-23 22:40:37.118699
6781	5	4	13	2	\N	2020-06-04	-273.66	f6bd47ac3fe64bc8dc33279851b0ebfa	2020-10-23 22:40:37.120139	2020-10-23 22:40:37.120139
6782	5	4	15	2	\N	2020-06-04	-89.99	78ef7d03f1cb58ea4f3ba4a547cdeda7	2020-10-23 22:40:37.121528	2020-10-23 22:40:37.121528
6783	5	10	54	3	\N	2020-06-04	-3000.00	441954d29ad2a375cef8ea524a2c7e73	2020-10-23 22:40:37.12276	2020-10-23 22:40:37.12276
6784	6	10	54	4	\N	2020-06-04	3000.00	06ca655e1cff36fe062f783aa99f7c34	2020-10-23 22:40:37.124006	2020-10-23 22:40:37.124006
6785	1	9	53	3	\N	2020-06-05	-4000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:37.125238	2020-10-23 22:40:37.125238
6786	5	4	16	2	\N	2020-06-06	-70.00	08bfb7e81f8e8e69c698fcc37d73c1d4	2020-10-23 22:40:37.126339	2020-10-23 22:40:37.126339
6787	1	8	43	2	\N	2020-06-08	-12.00	2c9c0b5d3d18d1024a0f64a89770eb83	2020-10-23 22:40:37.127408	2020-10-23 22:40:37.127408
6788	5	8	43	2	\N	2020-06-08	-180.92	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.128724	2020-10-23 22:40:37.128724
6789	1	8	40	2	\N	2020-06-08	-2.00	61c9e7fb675f02218005d1e319984736	2020-10-23 22:40:37.130891	2020-10-23 22:40:37.130891
6790	5	5	21	2	\N	2020-06-08	-58.92	622063ecd8f36d3846af5fc7c8efbbe0	2020-10-23 22:40:37.132505	2020-10-23 22:40:37.132505
6791	1	2	3	1	\N	2020-06-10	197.93	ac112d0832171b2877f63c669bf3d303	2020-10-23 22:40:37.133813	2020-10-23 22:40:37.133813
6792	2	5	21	2	\N	2020-06-10	-111.46	dd46269118915f85b343da54b42c11d6	2020-10-23 22:40:37.135228	2020-10-23 22:40:37.135228
6793	2	5	21	2	\N	2020-06-10	-39.00	ed50bcd1655946555b2e87106d4e6418	2020-10-23 22:40:37.13638	2020-10-23 22:40:37.13638
6794	5	5	21	1	\N	2020-06-10	39.00	ed50bcd1655946555b2e87106d4e6418	2020-10-23 22:40:37.137582	2020-10-23 22:40:37.137582
6795	2	4	16	2	\N	2020-06-10	-13.00	823a22c4a2ead7ded8d5ed4a40052114	2020-10-23 22:40:37.138753	2020-10-23 22:40:37.138753
6796	5	1	-1	2	\N	2020-06-10	-138.90	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.140073	2020-10-23 22:40:37.140073
6797	5	1	-1	2	\N	2020-06-13	-9.38	59c33016884a62116be975a9bb8257e3	2020-10-23 22:40:37.141487	2020-10-23 22:40:37.141487
6798	5	1	-1	2	\N	2020-06-11	-338.86	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.142632	2020-10-23 22:40:37.142632
6799	2	5	23	2	\N	2020-06-16	-45.98	914df829466dccccc766acf5a951186c	2020-10-23 22:40:37.143766	2020-10-23 22:40:37.143766
6800	5	5	26	2	\N	2020-06-16	-58.42	ad30b44e1e057a2070dacac94607470d	2020-10-23 22:40:37.14573	2020-10-23 22:40:37.14573
6801	4	9	-1	3	\N	2020-06-15	-1500.00	dc5c7986daef50c1e02ab09b442ee34f	2020-10-23 22:40:37.147204	2020-10-23 22:40:37.147204
6802	2	9	-1	4	\N	2020-06-15	1500.00	dc5c7986daef50c1e02ab09b442ee34f	2020-10-23 22:40:37.148522	2020-10-23 22:40:37.148522
6803	6	9	-1	3	\N	2020-06-22	-600.00	afd312e1d5c8dbb69a6b2478cb28f2e7	2020-10-23 22:40:37.149917	2020-10-23 22:40:37.149917
6804	5	9	-1	4	\N	2020-06-22	600.00	afd312e1d5c8dbb69a6b2478cb28f2e7	2020-10-23 22:40:37.151559	2020-10-23 22:40:37.151559
6805	5	9	47	2	\N	2020-06-22	-200.00	7984a0279babd7864742a228570b5792	2020-10-23 22:40:37.152759	2020-10-23 22:40:37.152759
6806	5	1	-1	2	\N	2020-06-20	-87.25	b4437b20c99e1f1f5415ec0a884586fc	2020-10-23 22:40:37.153946	2020-10-23 22:40:37.153946
6807	2	5	25	2	\N	2020-06-22	-60.00	afd312e1d5c8dbb69a6b2478cb28f2e7	2020-10-23 22:40:37.155249	2020-10-23 22:40:37.155249
6808	5	5	23	2	\N	2020-06-22	-54.48	f0bf769ba54a2caa10b2dcf6125a10ec	2020-10-23 22:40:37.15668	2020-10-23 22:40:37.15668
6809	2	4	18	2	\N	2020-06-20	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:37.157849	2020-10-23 22:40:37.157849
6810	5	1	-1	2	\N	2020-06-18	-226.02	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.158902	2020-10-23 22:40:37.158902
6811	5	4	-1	2	\N	2020-06-23	-170.00	467b35bb671dc46082048ea9505f9083	2020-10-23 22:40:37.160034	2020-10-23 22:40:37.160034
6812	5	9	-1	2	\N	2020-06-23	-45.00	4ffce04d92a4d6cb21c1494cdfcd6dc1	2020-10-23 22:40:37.161403	2020-10-23 22:40:37.161403
6813	5	9	48	2	\N	2020-06-26	-5.99	2fbe23e027cb89205bfd7a5f50b44446	2020-10-23 22:40:37.162786	2020-10-23 22:40:37.162786
6814	5	1	-1	2	\N	2020-06-26	-243.41	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.16412	2020-10-23 22:40:37.16412
6815	2	2	3	1	\N	2020-06-26	7090.50	d707329bece455a462b58ce00d1194c9	2020-10-23 22:40:37.165349	2020-10-23 22:40:37.165349
6816	2	10	54	3	\N	2020-06-26	-4000.00	6671381000ee06f48d92e30c603533e2	2020-10-23 22:40:37.166489	2020-10-23 22:40:37.166489
6817	5	10	54	4	\N	2020-06-26	4000.00	6671381000ee06f48d92e30c603533e2	2020-10-23 22:40:37.167633	2020-10-23 22:40:37.167633
6818	5	4	13	2	\N	2020-06-27	-493.38	3b32e93540abe1425efa37772407c9bb	2020-10-23 22:40:37.168822	2020-10-23 22:40:37.168822
6819	5	4	16	2	\N	2020-06-27	-49.90	704afe073992cbe4813cae2f7715336f	2020-10-23 22:40:37.169932	2020-10-23 22:40:37.169932
6820	5	4	15	2	\N	2020-06-27	-89.99	28cb510090e7e926daa92745a8b02362	2020-10-23 22:40:37.171054	2020-10-23 22:40:37.171054
6821	5	4	14	2	\N	2020-06-27	-109.02	68e129acd99d4b65789a3c9e07fcbfc0	2020-10-23 22:40:37.172235	2020-10-23 22:40:37.172235
6822	5	10	54	3	\N	2020-06-27	-1400.00	64b2c118675af170ec2f5274d45852d7	2020-10-23 22:40:37.173281	2020-10-23 22:40:37.173281
6823	6	10	54	4	\N	2020-06-27	1400.00	64b2c118675af170ec2f5274d45852d7	2020-10-23 22:40:37.17459	2020-10-23 22:40:37.17459
6824	1	7	33	2	\N	2020-06-30	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:37.175841	2020-10-23 22:40:37.175841
6825	1	2	-1	4	\N	2020-06-28	8000.00	5b69b9cb83065d403869739ae7f0995e	2020-10-23 22:40:37.177099	2020-10-23 22:40:37.177099
6826	1	8	40	2	\N	2020-06-29	-7.00	8cdcda79a8dc66aa6c711c9a000b0ac0	2020-10-23 22:40:37.178359	2020-10-23 22:40:37.178359
6827	1	1	-1	2	\N	2020-06-26	-2.49	371bce7dc83817b7893bcdeed13799b5	2020-10-23 22:40:37.179718	2020-10-23 22:40:37.179718
6828	1	5	22	2	\N	2020-06-25	-120.00	efbd6ef165207baae1f083830046770d	2020-10-23 22:40:37.180823	2020-10-23 22:40:37.180823
6829	1	1	-1	2	\N	2020-06-25	-10.00	38913e1d6a7b94cb0f55994f679f5956	2020-10-23 22:40:37.181961	2020-10-23 22:40:37.181961
6830	1	8	43	2	\N	2020-06-25	-12.00	8cdcda79a8dc66aa6c711c9a000b0ac0	2020-10-23 22:40:37.183233	2020-10-23 22:40:37.183233
6831	1	7	31	2	\N	2020-06-24	-18.00	fc2f3fdddbfa842a484fce9cdad03b5f	2020-10-23 22:40:37.18448	2020-10-23 22:40:37.18448
6832	1	9	-1	2	\N	2020-06-24	-65.00	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:37.185644	2020-10-23 22:40:37.185644
6833	5	1	-1	2	\N	2020-06-29	-26.84	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.187206	2020-10-23 22:40:37.187206
6834	5	5	23	2	\N	2020-06-29	-59.99	ae0eb3eed39d2bcef4622b2499a05fe6	2020-10-23 22:40:37.18855	2020-10-23 22:40:37.18855
6835	5	9	53	3	\N	2020-06-28	-1000.00	e7f8a7fb0b77bcb3b283af5be021448f	2020-10-23 22:40:37.189732	2020-10-23 22:40:37.189732
6836	5	4	14	2	\N	2020-06-30	-360.43	2d6cc4b2d139a53512fb8cbb3086ae2e	2020-10-23 22:40:37.191444	2020-10-23 22:40:37.191444
6837	5	9	48	2	\N	2020-06-29	-5.99	5edc5ce86f5f5d98d77ab1e14f40c4cd	2020-10-23 22:40:37.192613	2020-10-23 22:40:37.192613
6838	1	9	51	2	\N	2020-07-01	-50.00	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:40:37.193773	2020-10-23 22:40:37.193773
6839	1	9	53	3	\N	2020-07-01	-8000.00	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:37.195002	2020-10-23 22:40:37.195002
6840	6	10	55	1	\N	2020-07-01	24.31	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.196214	2020-10-23 22:40:37.196214
6841	6	10	55	1	\N	2020-07-01	10.10	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.197306	2020-10-23 22:40:37.197306
6842	6	10	54	4	\N	2020-07-01	1000.00	5fd28b90717abeca69602078ef5dd1b3	2020-10-23 22:40:37.19848	2020-10-23 22:40:37.19848
6843	5	2	-1	4	\N	2020-07-01	1500.00	f8d9e102d44885f6f82ee0fbe3ee2339	2020-10-23 22:40:37.199645	2020-10-23 22:40:37.199645
6844	1	2	-1	4	\N	2020-07-01	900.00	10f4b6fd8f36ab8c5a06964836c3dff6	2020-10-23 22:40:37.200828	2020-10-23 22:40:37.200828
6845	5	9	48	2	\N	2020-07-02	-319.88	fc721c1b9e22384e1bae7ad5557f5662	2020-10-23 22:40:37.201957	2020-10-23 22:40:37.201957
6846	5	1	-1	2	\N	2020-07-03	-350.39	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.203173	2020-10-23 22:40:37.203173
6847	5	4	-1	2	\N	2020-07-03	-170.00	5b69b9cb83065d403869739ae7f0995e	2020-10-23 22:40:37.204476	2020-10-23 22:40:37.204476
6848	5	10	54	3	\N	2020-07-03	-1000.00	cf9369da16f00da18f259d3e3d465864	2020-10-23 22:40:37.205692	2020-10-23 22:40:37.205692
6849	6	10	54	4	\N	2020-07-03	1000.00	64b2c118675af170ec2f5274d45852d7	2020-10-23 22:40:37.206906	2020-10-23 22:40:37.206906
6850	2	10	54	3	\N	2020-07-03	-500.00	5a89924ad353f0f0d5b7bf6ee8e0909b	2020-10-23 22:40:37.208282	2020-10-23 22:40:37.208282
6851	6	10	54	4	\N	2020-07-03	500.00	f07e4af71b1084fb21996f62d98be1ab	2020-10-23 22:40:37.209364	2020-10-23 22:40:37.209364
6852	5	8	43	2	\N	2020-07-03	-164.97	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.210338	2020-10-23 22:40:37.210338
6853	5	5	23	2	\N	2020-07-03	-31.99	25b93ae83ec006784ad13edc0ab8b11e	2020-10-23 22:40:37.211785	2020-10-23 22:40:37.211785
6854	5	5	21	2	\N	2020-07-03	-29.96	5d4c1f9dcfae3d779b77f4bff24cefab	2020-10-23 22:40:37.213359	2020-10-23 22:40:37.213359
6855	5	9	47	2	\N	2020-07-03	-50.00	4753cb21ffb150d76e13233f66c10141	2020-10-23 22:40:37.214682	2020-10-23 22:40:37.214682
6856	2	1	-1	2	\N	2020-07-03	-54.00	120632446c35682a996c50830ee55882	2020-10-23 22:40:37.216019	2020-10-23 22:40:37.216019
6857	2	8	40	2	\N	2020-07-03	-12.00	6bcec1e5ab3029f75796afe4569866b9	2020-10-23 22:40:37.217546	2020-10-23 22:40:37.217546
6858	2	4	16	2	\N	2020-07-04	-26.00	f0e743de86483d3ef431b8c8f393418e	2020-10-23 22:40:37.218663	2020-10-23 22:40:37.218663
6859	2	6	27	2	\N	2020-07-07	-130.64	9cbe1f2b71231e51acd9d0e0d48b832f	2020-10-23 22:40:37.2199	2020-10-23 22:40:37.2199
6860	5	1	-1	2	\N	2020-07-07	-153.66	f619797e6f149858f77bf0db0a606d56	2020-10-23 22:40:37.221159	2020-10-23 22:40:37.221159
6861	5	1	-1	2	\N	2020-07-07	-16.00	4e79c55861cfff46a105f0c21d3d1396	2020-10-23 22:40:37.222283	2020-10-23 22:40:37.222283
6862	5	4	16	2	\N	2020-07-07	-70.00	f72f8acf007667e87f65f1bfed7d3b55	2020-10-23 22:40:37.224055	2020-10-23 22:40:37.224055
6863	1	9	-1	2	\N	2020-07-14	-46.15	218c3d6f821947a59e83845f6b1fb845	2020-10-23 22:40:37.225129	2020-10-23 22:40:37.225129
6864	1	3	12	2	\N	2020-07-14	-121.18	467b35bb671dc46082048ea9505f9083	2020-10-23 22:40:37.226595	2020-10-23 22:40:37.226595
6865	1	7	31	2	\N	2020-07-14	-25.00	647e24fdbfcbc54e7dbb98e11c45059b	2020-10-23 22:40:37.22807	2020-10-23 22:40:37.22807
6866	5	8	43	2	\N	2020-07-10	-43.80	89f0fd5c927d466d6ec9a21b9ac34ffa	2020-10-23 22:40:37.229494	2020-10-23 22:40:37.229494
6867	5	1	-1	2	\N	2020-07-10	-200.00	0946676d26ce64a63b767646b50ee8f1	2020-10-23 22:40:37.23081	2020-10-23 22:40:37.23081
6868	5	1	-1	2	\N	2020-07-10	-80.00	a23e10ddc6117ee143b1241b024c7e54	2020-10-23 22:40:37.232414	2020-10-23 22:40:37.232414
6869	5	3	12	2	\N	2020-07-10	-42.20	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.233668	2020-10-23 22:40:37.233668
6870	5	3	12	2	\N	2020-07-10	-42.32	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.23496	2020-10-23 22:40:37.23496
6871	5	1	-1	2	\N	2020-07-10	-347.77	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.236558	2020-10-23 22:40:37.236558
6872	5	1	-1	2	\N	2020-07-10	-29.97	21e772d447b7e4ae9736b63319ea88fa	2020-10-23 22:40:37.237701	2020-10-23 22:40:37.237701
6873	2	8	40	2	\N	2020-07-15	-17.00	61c9e7fb675f02218005d1e319984736	2020-10-23 22:40:37.238748	2020-10-23 22:40:37.238748
6874	2	1	-1	2	\N	2020-07-15	-10.90	8056ac6ddcb0f14b019219391c1159c7	2020-10-23 22:40:37.240208	2020-10-23 22:40:37.240208
6875	2	5	21	2	\N	2020-07-16	-16.30	1732cb437260c60a0744aea8aedfa331	2020-10-23 22:40:37.241495	2020-10-23 22:40:37.241495
6876	5	5	23	2	\N	2020-07-16	-138.44	950a4152c2b4aa3ad78bdd6b366cc179	2020-10-23 22:40:37.242771	2020-10-23 22:40:37.242771
6877	5	1	-1	2	\N	2020-07-16	-56.57	52c5ddf28d2bb239fdb3e04ebe23cc5f	2020-10-23 22:40:37.244541	2020-10-23 22:40:37.244541
6878	5	1	-1	2	\N	2020-07-18	-144.41	5e767b3a49c00747825fef754c5ea435	2020-10-23 22:40:37.246159	2020-10-23 22:40:37.246159
6879	5	9	53	3	\N	2020-07-17	-50.00	09bf1bdd216513c2a26c210598d03498	2020-10-23 22:40:37.247472	2020-10-23 22:40:37.247472
6880	1	1	-1	2	\N	2020-07-19	-118.00	e322a3e0634d30442d4bd1971ba82688	2020-10-23 22:40:37.248598	2020-10-23 22:40:37.248598
6881	2	1	-1	2	\N	2020-07-20	-58.00	a0f6d0244be79da7040362bf43e9af46	2020-10-23 22:40:37.249768	2020-10-23 22:40:37.249768
6882	2	9	53	4	\N	2020-07-17	50.00	915c00c94072a859394077f49d202b6a	2020-10-23 22:40:37.250909	2020-10-23 22:40:37.250909
6883	2	4	18	2	\N	2020-07-17	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:37.252276	2020-10-23 22:40:37.252276
6884	2	8	44	2	\N	2020-07-17	-22.13	c6c3956ac99102230b94411b28613345	2020-10-23 22:40:37.25337	2020-10-23 22:40:37.25337
6885	5	9	-1	4	\N	2020-07-24	1000.00	46b3765c7804788f00cc03fc395c64bd	2020-10-23 22:40:37.254485	2020-10-23 22:40:37.254485
6886	5	1	-1	2	\N	2020-07-25	-101.12	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.255714	2020-10-23 22:40:37.255714
6887	5	8	43	2	\N	2020-07-25	-194.89	daca41214b39c5dc66674d09081940f0	2020-10-23 22:40:37.256872	2020-10-23 22:40:37.256872
6888	5	5	23	2	\N	2020-07-25	-44.98	568628e0d993b1973adc718237da6e93	2020-10-23 22:40:37.257979	2020-10-23 22:40:37.257979
6889	5	6	27	2	\N	2020-07-25	-89.73	5311e735f2fb86f02443c525b1ead622	2020-10-23 22:40:37.259539	2020-10-23 22:40:37.259539
6890	5	1	-1	2	\N	2020-07-25	-94.23	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.260643	2020-10-23 22:40:37.260643
6891	5	4	16	2	\N	2020-07-25	-49.90	1c4f698b042f3fb1c79fda5fc205f50c	2020-10-23 22:40:37.261968	2020-10-23 22:40:37.261968
6892	1	5	23	2	\N	2020-07-25	-19.99	52cdba63fa81f2f0d70663ff29c16b57	2020-10-23 22:40:37.263307	2020-10-23 22:40:37.263307
6893	1	8	40	2	\N	2020-07-25	-40.00	f026e5defa5b331fa5709c4419060c8a	2020-10-23 22:40:37.264471	2020-10-23 22:40:37.264471
6894	1	5	25	2	\N	2020-07-23	-60.00	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:37.265567	2020-10-23 22:40:37.265567
6895	1	1	-1	2	\N	2020-07-25	-20.00	99bcfcd754a98ce89cb86f73acc04645	2020-10-23 22:40:37.266633	2020-10-23 22:40:37.266633
6896	1	8	41	2	\N	2020-07-22	-30.57	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:37.267676	2020-10-23 22:40:37.267676
6897	1	8	40	2	\N	2020-07-22	-2.00	61c9e7fb675f02218005d1e319984736	2020-10-23 22:40:37.268674	2020-10-23 22:40:37.268674
6898	5	1	-1	2	\N	2020-07-27	-88.33	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.269736	2020-10-23 22:40:37.269736
6899	5	4	17	2	\N	2020-07-27	-462.46	5072d348b267983ddc0786d821c3fe32	2020-10-23 22:40:37.270727	2020-10-23 22:40:37.270727
6900	5	4	17	2	\N	2020-07-27	-247.00	210943091c538d2640b1e8ad9a95e694	2020-10-23 22:40:37.271796	2020-10-23 22:40:37.271796
6901	2	2	3	1	\N	2020-07-29	7336.53	b7cd5863ecc6125b74e0b55c6e41af17	2020-10-23 22:40:37.272833	2020-10-23 22:40:37.272833
6902	2	10	54	3	\N	2020-07-29	-3000.00	6aab1270668d8cac7cef2566a1c5f569	2020-10-23 22:40:37.273936	2020-10-23 22:40:37.273936
6903	5	10	54	4	\N	2020-07-29	3000.00	6aab1270668d8cac7cef2566a1c5f569	2020-10-23 22:40:37.275162	2020-10-23 22:40:37.275162
6904	5	5	23	2	\N	2020-07-29	-124.54	d045c59a90d7587d8d671b5f5aec4e7c	2020-10-23 22:40:37.276279	2020-10-23 22:40:37.276279
6905	5	5	23	2	\N	2020-07-29	-89.97	26d8753dfb330f57be75f2cfdbe7b94f	2020-10-23 22:40:37.277324	2020-10-23 22:40:37.277324
6906	5	1	-1	2	\N	2020-07-29	-77.43	1bc3c8b3c3e56862ef1a366669478bbc	2020-10-23 22:40:37.278493	2020-10-23 22:40:37.278493
6907	5	4	13	2	\N	2020-07-30	-490.73	719b75424fd8dfc276c4da51ec8306f0	2020-10-23 22:40:37.27968	2020-10-23 22:40:37.27968
6908	5	4	15	2	\N	2020-07-30	-89.99	e02c10df2c67d72dfa5b9cdd6e72b2d5	2020-10-23 22:40:37.28084	2020-10-23 22:40:37.28084
6909	2	9	-1	3	\N	2020-07-30	-50.00	a5297d15410aaa7799e1d28a39294be8	2020-10-23 22:40:37.282112	2020-10-23 22:40:37.282112
6910	5	9	-1	4	\N	2020-07-30	50.00	a5297d15410aaa7799e1d28a39294be8	2020-10-23 22:40:37.28385	2020-10-23 22:40:37.28385
6911	2	10	54	3	\N	2020-07-30	-1000.00	3636638817772e42b59d74cff571fbb3	2020-10-23 22:40:37.285282	2020-10-23 22:40:37.285282
6912	6	10	54	4	\N	2020-07-30	1000.00	3636638817772e42b59d74cff571fbb3	2020-10-23 22:40:37.286469	2020-10-23 22:40:37.286469
6913	2	10	54	3	\N	2020-07-30	-500.00	847cc55b7032108eee6dd897f3bca8a5	2020-10-23 22:40:37.287589	2020-10-23 22:40:37.287589
6914	4	10	54	4	\N	2020-07-30	500.00	847cc55b7032108eee6dd897f3bca8a5	2020-10-23 22:40:37.288644	2020-10-23 22:40:37.288644
6915	5	2	-1	4	\N	2020-08-01	1500.00	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:37.289738	2020-10-23 22:40:37.289738
6916	6	10	54	4	\N	2020-08-01	1000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:37.290831	2020-10-23 22:40:37.290831
6917	2	2	-1	4	\N	2020-08-01	1000.00	ad71b715717f7e4757565373c1a88e1f	2020-10-23 22:40:37.291867	2020-10-23 22:40:37.291867
6918	6	10	55	1	\N	2020-08-01	4.90	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.292904	2020-10-23 22:40:37.292904
6919	6	10	55	1	\N	2020-08-01	2.00	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.294004	2020-10-23 22:40:37.294004
6920	5	8	43	2	\N	2020-07-30	-170.17	6aca97005c68f1206823815f66102863	2020-10-23 22:40:37.295519	2020-10-23 22:40:37.295519
6921	5	1	-1	2	\N	2020-07-30	-151.01	c33f6d86a780ff4b0a4c2e9e2b815859	2020-10-23 22:40:37.296843	2020-10-23 22:40:37.296843
6922	1	2	-1	4	\N	2020-08-01	4900.00	10f4b6fd8f36ab8c5a06964836c3dff6	2020-10-23 22:40:37.297995	2020-10-23 22:40:37.297995
6923	1	7	33	2	\N	2020-07-30	-29.99	d6a60dbe22c357f0016389cafb3ea4e4	2020-10-23 22:40:37.29909	2020-10-23 22:40:37.29909
6924	1	1	-1	2	\N	2020-07-30	-102.30	5c385d6d334ea0a9301bd28ea067aba7	2020-10-23 22:40:37.300101	2020-10-23 22:40:37.300101
6925	1	8	44	2	\N	2020-07-30	-20.41	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.301155	2020-10-23 22:40:37.301155
6926	1	8	45	2	\N	2020-07-30	-88.00	667048d15828dc7f462313e0582cfa82	2020-10-23 22:40:37.302272	2020-10-23 22:40:37.302272
6927	1	8	43	2	\N	2020-07-30	-12.00	b137fdd1f79d56c7edf3365fea7520f2	2020-10-23 22:40:37.30338	2020-10-23 22:40:37.30338
6928	1	3	12	2	\N	2020-07-30	-85.00	467b35bb671dc46082048ea9505f9083	2020-10-23 22:40:37.304443	2020-10-23 22:40:37.304443
6929	1	1	11	2	\N	2020-07-30	-9.50	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:37.305535	2020-10-23 22:40:37.305535
6930	1	2	3	1	\N	2020-08-01	0.00	32b30a250abd6331e03a2a1f16466346	2020-10-23 22:40:37.306732	2020-10-23 22:40:37.306732
6931	1	9	53	3	\N	2020-08-03	-4500.00	1e056d2b0ebd5c878c550da6ac5d3724	2020-10-23 22:40:37.30782	2020-10-23 22:40:37.30782
6932	1	9	51	2	\N	2020-08-03	-50.00	2823f4797102ce1a1aec05359cc16dd9	2020-10-23 22:40:37.308893	2020-10-23 22:40:37.308893
6933	5	4	16	2	\N	2020-08-05	-70.00	856deecf45fa4ace6b5b49bd4ad54acf	2020-10-23 22:40:37.309886	2020-10-23 22:40:37.309886
6934	1	8	44	2	\N	2020-08-10	-25.19	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.311179	2020-10-23 22:40:37.311179
6935	1	3	12	2	\N	2020-08-08	-19.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:37.312469	2020-10-23 22:40:37.312469
6936	1	3	12	2	\N	2020-08-08	-11.00	64b8fd0411e420f466f1e3bfc8be184a	2020-10-23 22:40:37.313635	2020-10-23 22:40:37.313635
6937	1	1	-1	2	\N	2020-08-08	-31.00	cf30c5a9bfb152765dae97cee99689f8	2020-10-23 22:40:37.314733	2020-10-23 22:40:37.314733
6938	1	8	44	2	\N	2020-08-08	-24.88	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.315748	2020-10-23 22:40:37.315748
6939	5	1	-1	2	\N	2020-08-10	-174.73	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.316801	2020-10-23 22:40:37.316801
6940	5	1	-1	2	\N	2020-08-10	-70.79	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:37.317863	2020-10-23 22:40:37.317863
6941	5	1	-1	2	\N	2020-08-08	-92.95	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.318954	2020-10-23 22:40:37.318954
6942	5	9	53	3	\N	2020-08-04	-3000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:37.320016	2020-10-23 22:40:37.320016
6943	6	10	54	4	\N	2020-08-04	3000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:37.321084	2020-10-23 22:40:37.321084
6944	6	9	53	3	\N	2020-07-31	-1000.00	ad0e5e531c8bc838a33cf6d1d0c789d3	2020-10-23 22:40:37.322406	2020-10-23 22:40:37.322406
6945	2	5	26	2	\N	2020-08-04	-100.96	a39a9463ee52082ac1a66be22c074763	2020-10-23 22:40:37.324156	2020-10-23 22:40:37.324156
6946	5	8	43	2	\N	2020-08-12	-202.73	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.325769	2020-10-23 22:40:37.325769
6947	5	5	22	2	\N	2020-08-13	-360.00	88ff290c640d1ec9372faef19206de9d	2020-10-23 22:40:37.327025	2020-10-23 22:40:37.327025
6948	5	1	-1	2	\N	2020-08-14	-174.90	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.328434	2020-10-23 22:40:37.328434
6949	5	1	-1	2	\N	2020-08-13	-64.35	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.329725	2020-10-23 22:40:37.329725
6950	1	5	22	2	\N	2020-08-13	-70.99	da6f7e83b73d589559b55957554ea2cc	2020-10-23 22:40:37.331	2020-10-23 22:40:37.331
6951	2	1	-1	2	\N	2020-08-16	-13.00	18a5699c873242b2564a20d8736c2d71	2020-10-23 22:40:37.332184	2020-10-23 22:40:37.332184
6952	2	4	18	2	\N	2020-08-17	-25.00	95cfeba12aaf6aeab36b5ef260200a7f	2020-10-23 22:40:37.333401	2020-10-23 22:40:37.333401
6953	5	1	-1	2	\N	2020-08-18	-69.18	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.334632	2020-10-23 22:40:37.334632
6954	5	1	-1	2	\N	2020-08-19	-18.00	138bb0696595b338afbab333c555292a	2020-10-23 22:40:37.336226	2020-10-23 22:40:37.336226
6955	5	2	-1	4	\N	2020-08-20	5100.00	8a4b5cefd83b9f9d2a9c82fb10fd8ee6	2020-10-23 22:40:37.337585	2020-10-23 22:40:37.337585
6956	5	9	53	3	\N	2020-08-20	-3800.00	cd58d01a92dfbb87a677cd98859b839b	2020-10-23 22:40:37.339704	2020-10-23 22:40:37.339704
6957	6	10	54	4	\N	2020-08-20	3800.00	cd58d01a92dfbb87a677cd98859b839b	2020-10-23 22:40:37.340906	2020-10-23 22:40:37.340906
6958	1	8	44	2	\N	2020-08-20	-15.80	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:37.342012	2020-10-23 22:40:37.342012
6959	1	5	22	2	\N	2020-08-20	-170.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:37.343286	2020-10-23 22:40:37.343286
6960	1	8	44	2	\N	2020-08-20	-2.00	8cdcda79a8dc66aa6c711c9a000b0ac0	2020-10-23 22:40:37.345212	2020-10-23 22:40:37.345212
6961	1	8	44	2	\N	2020-08-20	-18.74	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:37.346465	2020-10-23 22:40:37.346465
6962	1	8	44	2	\N	2020-08-20	-14.05	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.347747	2020-10-23 22:40:37.347747
6963	1	1	-1	2	\N	2020-08-20	-20.70	09343bf85846ddb4e567e9344e092d91	2020-10-23 22:40:37.349041	2020-10-23 22:40:37.349041
6964	5	5	21	2	\N	2020-08-20	-53.74	84f7e69969dea92a925508f7c1f9579a	2020-10-23 22:40:37.350167	2020-10-23 22:40:37.350167
6965	5	1	-1	2	\N	2020-08-20	-221.15	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:37.351355	2020-10-23 22:40:37.351355
6966	2	1	-1	2	\N	2020-08-21	-49.00	2ffdaacec91ea7965e15a995558a6bd4	2020-10-23 22:40:37.352688	2020-10-23 22:40:37.352688
6967	2	1	-1	2	\N	2020-08-23	-84.00	4922471c0eccfb06e0520896ebdd0c18	2020-10-23 22:40:37.353821	2020-10-23 22:40:37.353821
6968	2	1	-1	2	\N	2020-08-23	-27.00	4922471c0eccfb06e0520896ebdd0c18	2020-10-23 22:40:37.354903	2020-10-23 22:40:37.354903
6969	5	1	-1	2	\N	2020-08-23	-18.00	4922471c0eccfb06e0520896ebdd0c18	2020-10-23 22:40:37.356001	2020-10-23 22:40:37.356001
6970	5	10	54	3	\N	2020-08-25	-1000.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:37.357124	2020-10-23 22:40:37.357124
6971	6	10	54	4	\N	2020-08-25	1000.00	deb3292f208a7e5bd67f00d44cb1692d	2020-10-23 22:40:37.358286	2020-10-23 22:40:37.358286
6972	5	1	-1	2	\N	2020-08-25	-50.11	e861c9a4467e51500bd648c32544d96e	2020-10-23 22:40:37.359451	2020-10-23 22:40:37.359451
6973	2	1	-1	2	\N	2020-08-26	-20.00	a8147e09f3ab3606bc1e81af8ed25f39	2020-10-23 22:40:37.360541	2020-10-23 22:40:37.360541
6974	2	6	27	2	\N	2020-08-27	-159.99	64771a8f2e4276f55219ad0e3faa4140	2020-10-23 22:40:37.361838	2020-10-23 22:40:37.361838
6975	5	5	23	2	\N	2020-08-27	-59.45	9c838d2e45b2ad1094d42f4ef36764f6	2020-10-23 22:40:37.363039	2020-10-23 22:40:37.363039
6976	5	1	-1	2	\N	2020-08-27	-157.85	428fca9bc1921c25c5121f9da7815cde	2020-10-23 22:40:37.364089	2020-10-23 22:40:37.364089
6977	5	8	43	2	\N	2020-08-27	-40.00	c8ffe9a587b126f152ed3d89a146b445	2020-10-23 22:40:37.365198	2020-10-23 22:40:37.365198
6978	2	6	27	2	\N	2020-08-28	-79.99	db17681617c658bd7b3994461cd5b723	2020-10-23 22:40:37.366275	2020-10-23 22:40:37.366275
6979	2	6	27	2	\N	2020-08-28	-99.99	fc8001f834f6a5f0561080d134d53d29	2020-10-23 22:40:37.367337	2020-10-23 22:40:37.367337
6980	5	1	-1	2	\N	2020-08-28	-104.20	91ad824c07c2b782ba20a03215757f77	2020-10-23 22:40:37.368471	2020-10-23 22:40:37.368471
6981	2	2	3	1	\N	2020-08-28	7336.53	2a084e55c87b1ebcdaad1f62fdbbac8e	2020-10-23 22:40:37.369664	2020-10-23 22:40:37.369664
6982	2	10	54	3	\N	2020-08-28	-1000.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:37.370697	2020-10-23 22:40:37.370697
6983	4	10	54	4	\N	2020-08-28	1000.00	f61d6947467ccd3aa5af24db320235dd	2020-10-23 22:40:37.371771	2020-10-23 22:40:37.371771
6984	2	10	54	3	\N	2020-08-28	-3000.00	352407221afb776e3143e8a1a0577885	2020-10-23 22:40:37.372943	2020-10-23 22:40:37.372943
6985	6	10	54	4	\N	2020-08-28	3000.00	352407221afb776e3143e8a1a0577885	2020-10-23 22:40:37.374478	2020-10-23 22:40:37.374478
6986	2	10	54	3	\N	2020-08-28	-2000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:37.375651	2020-10-23 22:40:37.375651
6987	5	10	54	4	\N	2020-08-28	2000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:37.376734	2020-10-23 22:40:37.376734
6988	5	4	13	2	\N	2020-08-28	-608.15	140f6969d5213fd0ece03148e62e461e	2020-10-23 22:40:37.377982	2020-10-23 22:40:37.377982
6989	5	4	16	2	\N	2020-08-28	-49.90	336efc5a2cdd35d98e8aa99afe35af86	2020-10-23 22:40:37.379617	2020-10-23 22:40:37.379617
6990	5	4	14	2	\N	2020-08-28	-108.92	c6bc586e4125cbbcc420fe13387f1896	2020-10-23 22:40:37.380859	2020-10-23 22:40:37.380859
6991	1	2	-1	4	\N	2020-08-31	10.00	40c989cc0bdee457475f49d3f3f8c10a	2020-10-23 22:40:37.381916	2020-10-23 22:40:37.381916
6992	1	9	47	3	\N	2020-08-31	-120.00	e64770ac6bac05626b4f59b6a03e2ff8	2020-10-23 22:40:37.383345	2020-10-23 22:40:37.383345
6993	1	7	33	2	\N	2020-08-31	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:37.38453	2020-10-23 22:40:37.38453
6994	1	8	44	2	\N	2020-08-31	-15.36	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.385695	2020-10-23 22:40:37.385695
6995	1	1	11	2	\N	2020-08-31	-3.99	d4da62547d103a9b22fb9805e08dea24	2020-10-23 22:40:37.386789	2020-10-23 22:40:37.386789
6996	1	2	-1	4	\N	2020-08-31	10400.00	0a93c4e8557cb6897b438861e21c55ee	2020-10-23 22:40:37.387849	2020-10-23 22:40:37.387849
6997	1	9	50	2	\N	2020-08-31	-7.50	af3f3ecf3ae5a2b4cfc6ed9e24f7ca15	2020-10-23 22:40:37.389373	2020-10-23 22:40:37.389373
6998	1	5	22	2	\N	2020-08-31	-150.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:37.390549	2020-10-23 22:40:37.390549
6999	1	9	49	2	\N	2020-08-31	-23.99	128fc4f48693ac191c662898b0719506	2020-10-23 22:40:37.391838	2020-10-23 22:40:37.391838
7000	1	7	30	2	\N	2020-08-31	-134.00	c399862d3b9d6b76c8436e924a68c45b	2020-10-23 22:40:37.392996	2020-10-23 22:40:37.392996
7001	1	1	-1	2	\N	2020-08-31	-11.70	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:37.394208	2020-10-23 22:40:37.394208
7002	1	8	41	2	\N	2020-08-31	-30.57	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:37.395778	2020-10-23 22:40:37.395778
7003	5	1	-1	2	\N	2020-08-31	-12.95	2eacbe0cfb2f81c4785dad98b7eb1d30	2020-10-23 22:40:37.397079	2020-10-23 22:40:37.397079
7004	5	8	43	2	\N	2020-09-01	-210.67	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.398368	2020-10-23 22:40:37.398368
7005	6	10	55	1	\N	2020-09-01	4.52	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.399728	2020-10-23 22:40:37.399728
7006	6	10	55	1	\N	2020-09-01	1.87	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.401019	2020-10-23 22:40:37.401019
7007	1	9	53	3	\N	2020-09-01	-9900.00	fe1b5c967f208619a91864bd7a9c9bd7	2020-10-23 22:40:37.402231	2020-10-23 22:40:37.402231
7008	5	2	-1	4	\N	2020-09-01	1500.00	8546f9c88ab637678947a81775464b17	2020-10-23 22:40:37.403326	2020-10-23 22:40:37.403326
7009	6	10	54	4	\N	2020-09-01	1000.00	8546f9c88ab637678947a81775464b17	2020-10-23 22:40:37.404421	2020-10-23 22:40:37.404421
7010	1	2	-1	4	\N	2020-09-01	5800.00	8546f9c88ab637678947a81775464b17	2020-10-23 22:40:37.405531	2020-10-23 22:40:37.405531
7011	1	9	48	2	\N	2020-09-01	-18.00	714b98e0a797e8f119f257a4ab802f86	2020-10-23 22:40:37.406571	2020-10-23 22:40:37.406571
7012	1	5	22	2	\N	2020-09-01	-100.96	56c968ba413527105d0ab942f3363a9e	2020-10-23 22:40:37.407652	2020-10-23 22:40:37.407652
7013	1	9	53	3	\N	2020-09-01	-5000.00	2a452c50d7c60fb1974ac813f3c6f2bb	2020-10-23 22:40:37.40864	2020-10-23 22:40:37.40864
7014	2	5	21	2	\N	2020-09-02	-47.76	8489f53d27c4117286b8dd704198ada0	2020-10-23 22:40:37.409646	2020-10-23 22:40:37.409646
7015	2	6	27	2	\N	2020-09-02	-79.99	aa169b49b583a2b5af89203c2b78c67c	2020-10-23 22:40:37.410642	2020-10-23 22:40:37.410642
7016	2	6	27	1	\N	2020-09-02	159.99	8170395a8a20582b582b805d5b5e21c8	2020-10-23 22:40:37.411893	2020-10-23 22:40:37.411893
7017	2	1	-1	2	\N	2020-09-01	-49.10	4a24daecaaedbb0ea5ef7b72aaae1a2e	2020-10-23 22:40:37.413101	2020-10-23 22:40:37.413101
7018	5	5	23	2	\N	2020-09-02	-68.97	c6cfc71608aa82325c88db3df5678c89	2020-10-23 22:40:37.414174	2020-10-23 22:40:37.414174
7019	5	1	-1	2	\N	2020-09-02	-167.15	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.415503	2020-10-23 22:40:37.415503
7020	5	10	54	3	\N	2020-09-02	-2000.00	14451daa5c7f813573b8a72a0e1cfd95	2020-10-23 22:40:37.416573	2020-10-23 22:40:37.416573
7021	6	10	54	4	\N	2020-09-02	2000.00	14451daa5c7f813573b8a72a0e1cfd95	2020-10-23 22:40:37.417716	2020-10-23 22:40:37.417716
7022	5	8	43	2	\N	2020-09-05	-134.62	b6e07796d9e7e1eb3b8b098cd30976d5	2020-10-23 22:40:37.418778	2020-10-23 22:40:37.418778
7023	5	8	43	2	\N	2020-09-11	-186.26	b6e07796d9e7e1eb3b8b098cd30976d5	2020-10-23 22:40:37.419834	2020-10-23 22:40:37.419834
7024	5	8	43	2	\N	2020-09-12	-175.22	b6e07796d9e7e1eb3b8b098cd30976d5	2020-10-23 22:40:37.420891	2020-10-23 22:40:37.420891
7025	1	1	11	2	\N	2020-09-12	-32.10	d6bfd14556631c0afe39dfe86338d475	2020-10-23 22:40:37.422109	2020-10-23 22:40:37.422109
7026	1	1	-1	2	\N	2020-09-13	-47.00	cf30c5a9bfb152765dae97cee99689f8	2020-10-23 22:40:37.423411	2020-10-23 22:40:37.423411
7027	1	9	49	2	\N	2020-09-13	-77.99	9431c87f273e507e6040fcb07dcb4509	2020-10-23 22:40:37.424578	2020-10-23 22:40:37.424578
7028	1	1	-1	2	\N	2020-09-10	-50.00	c058f544c737782deacefa532d9add4c	2020-10-23 22:40:37.425741	2020-10-23 22:40:37.425741
7029	1	1	11	2	\N	2020-09-07	-14.97	ace435d49572add5f18d3ea54ca413f5	2020-10-23 22:40:37.426864	2020-10-23 22:40:37.426864
7030	1	3	12	2	\N	2020-09-07	-45.32	4ff88711605e5dcbdecaaab563e1efc6	2020-10-23 22:40:37.42809	2020-10-23 22:40:37.42809
7031	1	8	43	2	\N	2020-09-05	-2.00	8cdcda79a8dc66aa6c711c9a000b0ac0	2020-10-23 22:40:37.429537	2020-10-23 22:40:37.429537
7032	1	9	49	2	\N	2020-09-05	-159.00	2671eb6e9150cf9b53eb39752a1fb21c	2020-10-23 22:40:37.43088	2020-10-23 22:40:37.43088
7033	1	5	22	2	\N	2020-09-05	-150.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:37.432156	2020-10-23 22:40:37.432156
7034	1	9	51	2	\N	2020-09-13	-50.00	30d2c1109139d2f14e57194d12394f01	2020-10-23 22:40:37.433304	2020-10-23 22:40:37.433304
7035	5	8	43	2	\N	2020-09-12	-36.20	6b9abf067124bb08d034e3fdad22d0fa	2020-10-23 22:40:37.434347	2020-10-23 22:40:37.434347
7036	5	8	43	2	\N	2020-09-06	-36.20	6b9abf067124bb08d034e3fdad22d0fa	2020-10-23 22:40:37.435375	2020-10-23 22:40:37.435375
7037	5	9	48	2	\N	2020-09-13	-101.18	ff4d5fbbafdf976cfdc032e3bde78de5	2020-10-23 22:40:37.436731	2020-10-23 22:40:37.436731
7038	5	1	-1	2	\N	2020-09-11	-17.20	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.43795	2020-10-23 22:40:37.43795
7039	5	1	-1	2	\N	2020-09-10	-101.50	131dfcee41083a5673dee0a63878bf5b	2020-10-23 22:40:37.439058	2020-10-23 22:40:37.439058
7040	5	5	22	2	\N	2020-09-10	-8.00	d07fa77424f98947760b3d059337fac7	2020-10-23 22:40:37.440172	2020-10-23 22:40:37.440172
7041	5	1	-1	2	\N	2020-09-10	-9.40	67e103b0761e60683e83c559be18d40c	2020-10-23 22:40:37.441537	2020-10-23 22:40:37.441537
7042	5	7	30	2	\N	2020-09-10	-53.00	076a0c97d09cf1a0ec3e19c7f2529f2b	2020-10-23 22:40:37.442744	2020-10-23 22:40:37.442744
7043	5	7	30	2	\N	2020-09-10	-48.00	ee2b121deeb9a112ad842be32a9435e4	2020-10-23 22:40:37.443953	2020-10-23 22:40:37.443953
7044	5	1	-1	2	\N	2020-09-10	-124.91	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.445203	2020-10-23 22:40:37.445203
7045	5	1	-1	2	\N	2020-09-10	-31.50	ce2a591fe40223a6be837462f79caf3c	2020-10-23 22:40:37.446302	2020-10-23 22:40:37.446302
7046	5	1	-1	2	\N	2020-09-10	-20.31	ed5bb80f46a76945b1cc86a09a854ca5	2020-10-23 22:40:37.447408	2020-10-23 22:40:37.447408
7047	5	4	16	2	\N	2020-09-10	-70.00	b19ecf34e19dc5a67d9aa76728133e59	2020-10-23 22:40:37.448519	2020-10-23 22:40:37.448519
7048	5	7	30	2	\N	2020-09-10	-500.00	3752cf1889486b8fd2c071c9dcf0fd34	2020-10-23 22:40:37.449719	2020-10-23 22:40:37.449719
7049	5	9	48	2	\N	2020-09-10	-84.53	996a7fa078cc36c46d02f9af3bef918b	2020-10-23 22:40:37.450948	2020-10-23 22:40:37.450948
7050	5	1	-1	2	\N	2020-09-10	-100.05	7f2ba118c0929b17399526db728e8223	2020-10-23 22:40:37.45215	2020-10-23 22:40:37.45215
7051	2	5	23	2	\N	2020-09-14	-5.00	b6a1085a27ab7bff7550f8a3bd017df8	2020-10-23 22:40:37.453205	2020-10-23 22:40:37.453205
7052	5	1	-1	2	\N	2020-09-14	-163.97	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.454898	2020-10-23 22:40:37.454898
7053	2	5	23	2	\N	2020-09-14	-1.00	cf84131f90589f7d06ad2f55ade6765a	2020-10-23 22:40:37.456004	2020-10-23 22:40:37.456004
7054	2	1	-1	2	\N	2020-09-12	-5.00	12490594201760da299ee96320ee4e4e	2020-10-23 22:40:37.45733	2020-10-23 22:40:37.45733
7055	2	6	27	1	\N	2020-09-03	99.99	b7ee6f5f9aa5cd17ca1aea43ce848496	2020-10-23 22:40:37.458485	2020-10-23 22:40:37.458485
7056	2	5	26	2	\N	2020-09-17	-17.98	7b2b417df328c89a176eaf7977838661	2020-10-23 22:40:37.459684	2020-10-23 22:40:37.459684
7057	2	5	26	2	\N	2020-09-17	-12.49	575350f3778d69173cfd6d265b7844bf	2020-10-23 22:40:37.46106	2020-10-23 22:40:37.46106
7058	2	8	40	2	\N	2020-09-17	-2.00	6bcec1e5ab3029f75796afe4569866b9	2020-10-23 22:40:37.462458	2020-10-23 22:40:37.462458
7059	5	1	-1	2	\N	2020-09-17	-149.06	b9b4abeafdffae758561c5bc344c22c0	2020-10-23 22:40:37.463741	2020-10-23 22:40:37.463741
7060	5	8	43	2	\N	2020-09-17	-15.00	e134fe3e8dc67b89dcd928aa2a7e7dcf	2020-10-23 22:40:37.464743	2020-10-23 22:40:37.464743
7061	2	8	44	2	\N	2020-09-19	-41.40	a2962a1fa38aa0c4755ab89a6605e755	2020-10-23 22:40:37.465823	2020-10-23 22:40:37.465823
7062	2	8	44	1	\N	2020-09-19	18.00	9afe2b8215c08e9d7cab10fe37686726	2020-10-23 22:40:37.466892	2020-10-23 22:40:37.466892
7063	2	8	44	2	\N	2020-09-19	-10.65	738aebc1f9aef81413d00e0990bb2e45	2020-10-23 22:40:37.467893	2020-10-23 22:40:37.467893
7064	2	3	12	2	\N	2020-09-19	-12.00	f5aca9cfa8da698453a961a1b873f2e7	2020-10-23 22:40:37.468924	2020-10-23 22:40:37.468924
7065	2	4	18	2	\N	2020-09-19	-25.00	d3c79f08734a725f74019c5e722f2a1b	2020-10-23 22:40:37.469929	2020-10-23 22:40:37.469929
7066	2	6	27	1	\N	2020-09-19	79.99	b3b561ca2ef93f34f018e2858bea214e	2020-10-23 22:40:37.470933	2020-10-23 22:40:37.470933
7067	2	9	-1	2	\N	2020-09-19	-3.97	0957ec7f9a1e6ef4908051352f0c6fbd	2020-10-23 22:40:37.471991	2020-10-23 22:40:37.471991
7068	5	9	48	1	\N	2020-09-21	41.99	550f370e1efe82ddac8d0ff61066536d	2020-10-23 22:40:37.473152	2020-10-23 22:40:37.473152
7069	1	8	43	2	\N	2020-09-22	-140.00	beed13602b9b0e6ecb5b568ff5058f07	2020-10-23 22:40:37.474313	2020-10-23 22:40:37.474313
7070	1	8	43	2	\N	2020-09-22	-1448.00	6c9882bbac1c7093bd25041881277658	2020-10-23 22:40:37.475447	2020-10-23 22:40:37.475447
7071	1	8	41	2	\N	2020-09-22	-21.73	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:37.476599	2020-10-23 22:40:37.476599
7072	1	8	44	2	\N	2020-09-22	-30.57	31c8f1568c7dd69a946aaaa062bdbe17	2020-10-23 22:40:37.477887	2020-10-23 22:40:37.477887
7073	1	9	-1	2	\N	2020-09-19	-7.94	d2ce51cff86160dbe257712c28650d20	2020-10-23 22:40:37.479708	2020-10-23 22:40:37.479708
7074	1	1	-1	2	\N	2020-09-19	-294.04	09930c455a56f8d2241685079463e1bd	2020-10-23 22:40:37.481043	2020-10-23 22:40:37.481043
7075	1	5	22	2	\N	2020-09-19	-150.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:37.48217	2020-10-23 22:40:37.48217
7076	1	8	43	2	\N	2020-09-19	-138.57	d9ffae53405ba39d73e12bb0060d44e7	2020-10-23 22:40:37.483756	2020-10-23 22:40:37.483756
7077	1	1	-1	2	\N	2020-09-16	-17.00	f310cb5807ae5bbd0811d382cea39b22	2020-10-23 22:40:37.484803	2020-10-23 22:40:37.484803
7078	1	5	25	2	\N	2020-09-16	-57.00	d11b4d2eb850a74816f853c6d9125b7c	2020-10-23 22:40:37.485878	2020-10-23 22:40:37.485878
7079	1	9	49	2	\N	2020-09-16	-799.00	f026e5defa5b331fa5709c4419060c8a	2020-10-23 22:40:37.487122	2020-10-23 22:40:37.487122
7080	1	2	-1	4	\N	2020-09-14	11303.79	d7d9a39d5df2279385cf5441c61d5fb9	2020-10-23 22:40:37.488286	2020-10-23 22:40:37.488286
7081	5	9	53	3	\N	2020-09-23	-2050.61	10e1b7ca0d760d5be46a3d3798e6953d	2020-10-23 22:40:37.489522	2020-10-23 22:40:37.489522
7082	1	2	-1	4	\N	2020-09-23	2050.61	10e1b7ca0d760d5be46a3d3798e6953d	2020-10-23 22:40:37.490728	2020-10-23 22:40:37.490728
7083	5	2	-1	4	\N	2020-09-23	3000.00	87c5046eae7047ffcab32eb1cb7dcf85	2020-10-23 22:40:37.492008	2020-10-23 22:40:37.492008
7084	6	9	53	3	\N	2020-09-23	-3000.00	87c5046eae7047ffcab32eb1cb7dcf85	2020-10-23 22:40:37.493735	2020-10-23 22:40:37.493735
7085	2	9	48	2	\N	2020-09-25	-31.00	c2aee86157b4a40b78132f1e71a9e6f1	2020-10-23 22:40:37.495332	2020-10-23 22:40:37.495332
7086	2	2	3	1	\N	2020-09-26	8238.46	1ce5080e5aaead15cb3b5f62558e7164	2020-10-23 22:40:37.496582	2020-10-23 22:40:37.496582
7087	5	1	-1	2	\N	2020-09-25	-211.09	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.498144	2020-10-23 22:40:37.498144
7088	5	5	23	2	\N	2020-09-26	-38.08	f9846452b5a6cf746985937b4eb3820e	2020-10-23 22:40:37.499446	2020-10-23 22:40:37.499446
7089	5	5	23	2	\N	2020-09-26	-13.00	1a2acc74c1e04b493caa4f83cee3603e	2020-10-23 22:40:37.500707	2020-10-23 22:40:37.500707
7090	5	1	-1	2	\N	2020-09-26	-96.68	ce2a591fe40223a6be837462f79caf3c	2020-10-23 22:40:37.502033	2020-10-23 22:40:37.502033
7091	5	1	-1	2	\N	2020-09-26	-24.14	290988f69cc7cde0361bdb4212a035c1	2020-10-23 22:40:37.503265	2020-10-23 22:40:37.503265
7092	5	1	-1	2	\N	2020-09-26	-4.45	bd686fd640be98efaae0091fa301e613	2020-10-23 22:40:37.504516	2020-10-23 22:40:37.504516
7093	2	10	54	3	\N	2020-09-27	-4000.00	7de0ae1f75046b22854282f458b09ad3	2020-10-23 22:40:37.50574	2020-10-23 22:40:37.50574
7094	6	10	54	4	\N	2020-09-27	4000.00	7de0ae1f75046b22854282f458b09ad3	2020-10-23 22:40:37.506951	2020-10-23 22:40:37.506951
7095	2	10	54	3	\N	2020-09-27	-2000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:37.508221	2020-10-23 22:40:37.508221
7096	5	10	54	4	\N	2020-09-27	2000.00	ac2e1569ede5742bd215a25d133df94a	2020-10-23 22:40:37.509347	2020-10-23 22:40:37.509347
7097	5	4	13	2	\N	2020-09-27	-493.88	04349b9fb69e76d386f89382c01027d2	2020-10-23 22:40:37.510375	2020-10-23 22:40:37.510375
7098	5	4	16	2	\N	2020-09-27	-49.90	5a467b7fe6c4e891373829de1b0c2a00	2020-10-23 22:40:37.511708	2020-10-23 22:40:37.511708
7099	5	4	15	2	\N	2020-09-27	-216.16	71ad16ad2c4d81f348082ff6c4b20768	2020-10-23 22:40:37.513305	2020-10-23 22:40:37.513305
7100	5	4	15	2	\N	2020-09-27	-145.02	449ea577e4656d919e9557379bf7c490	2020-10-23 22:40:37.514603	2020-10-23 22:40:37.514603
7101	1	5	22	2	\N	2020-09-24	-150.00	956cf47fac6a09f8e5632e51e8a8f4a1	2020-10-23 22:40:37.515931	2020-10-23 22:40:37.515931
7102	1	1	-1	2	\N	2020-09-24	-9.00	d2430361d6ef69afdee8ec3450fac448	2020-10-23 22:40:37.517148	2020-10-23 22:40:37.517148
7103	1	9	49	2	\N	2020-09-27	-2000.00	f1c1592588411002af340cbaedd6fc33	2020-10-23 22:40:37.518411	2020-10-23 22:40:37.518411
7104	2	9	-1	2	\N	2020-09-28	-100.75	6a8addeb940cd48f8177c44d5991650e	2020-10-23 22:40:37.519667	2020-10-23 22:40:37.519667
7105	2	1	-1	2	\N	2020-09-28	-8.49	8e9a5e7fd02d9828a1ce35e1cddeb39c	2020-10-23 22:40:37.520743	2020-10-23 22:40:37.520743
7106	1	9	53	3	\N	2020-10-01	-1600.00	142949df56ea8ae0be8b5306971900a4	2020-10-23 22:40:37.521839	2020-10-23 22:40:37.521839
7107	1	9	53	3	\N	2020-10-01	-1000.00	4d0c5af710fb34ba9877183bf7e05b15	2020-10-23 22:40:37.52298	2020-10-23 22:40:37.52298
7108	6	2	-1	4	\N	2020-10-01	1000.00	4d0c5af710fb34ba9877183bf7e05b15	2020-10-23 22:40:37.524048	2020-10-23 22:40:37.524048
7109	1	9	53	3	\N	2020-10-01	-1500.00	d9d7dbddc29177b121a6aa1bb09d15fd	2020-10-23 22:40:37.525319	2020-10-23 22:40:37.525319
7110	5	2	-1	4	\N	2020-10-01	1500.00	d9d7dbddc29177b121a6aa1bb09d15fd	2020-10-23 22:40:37.526337	2020-10-23 22:40:37.526337
7111	1	8	44	2	\N	2020-09-30	-49.82	fde03952412c18f5f291fa75c20df17f	2020-10-23 22:40:37.527344	2020-10-23 22:40:37.527344
7112	1	8	44	2	\N	2020-09-30	-11.66	b48124b507ffb0a2ad963982010de473	2020-10-23 22:40:37.528527	2020-10-23 22:40:37.528527
7113	1	7	33	2	\N	2020-09-30	-29.99	445855888566fcf2ec727ab4aca87fcc	2020-10-23 22:40:37.529802	2020-10-23 22:40:37.529802
7114	1	9	50	2	\N	2020-10-01	-15.00	a5bc48da98a520ab4b37a5c8eb009cc9	2020-10-23 22:40:37.531015	2020-10-23 22:40:37.531015
7115	6	10	55	1	\N	2020-10-01	1.05	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.532055	2020-10-23 22:40:37.532055
7116	6	10	55	1	\N	2020-10-01	0.44	31140df990f363df5aa50b75dd394522	2020-10-23 22:40:37.533103	2020-10-23 22:40:37.533103
7117	5	1	-1	2	\N	2020-09-29	-145.23	6833f9193892566d71a2d76572cfc06c	2020-10-23 22:40:37.534142	2020-10-23 22:40:37.534142
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: expense_tracker; Owner: expense_tracker_group
--

COPY expense_tracker.users (id_user, user_login, user_name, user_password, password_salt, active, insert_date, update_date) FROM stdin;
1	jkowalski	Janusz Kowalski	b8dc82c15ae882bbe7e04659a60e3cba	123$	1	2020-10-23 20:38:02.859732	2020-10-23 20:38:02.859732
2	gkowalska	Grażyna Kowalska	3c37f9d5ca7960423885c668a4058b21	123$	1	2020-10-23 20:38:04.254404	2020-10-23 20:38:04.254404
\.


--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.bank_account_owner_id_ba_own_seq', 3, true);


--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.bank_account_types_id_ba_type_seq', 6, true);


--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.transaction_bank_accounts_id_trans_ba_seq', 6, true);


--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.transaction_category_id_trans_cat_seq', 10, true);


--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.transaction_subcategory_id_trans_subcat_seq', 56, true);


--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.transaction_type_id_trans_type_seq', 4, true);


--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.transactions_id_transaction_seq', 7117, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: expense_tracker_group
--

SELECT pg_catalog.setval('expense_tracker.users_id_user_seq', 2, true);


--
-- Name: bank_account_owner bank_account_owner_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.bank_account_owner
    ADD CONSTRAINT bank_account_owner_pkey PRIMARY KEY (id_ba_own);


--
-- Name: bank_account_types bank_account_types_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.bank_account_types
    ADD CONSTRAINT bank_account_types_pkey PRIMARY KEY (id_ba_type);


--
-- Name: transaction_bank_accounts transaction_bank_accounts_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT transaction_bank_accounts_pkey PRIMARY KEY (id_trans_ba);


--
-- Name: transaction_category transaction_category_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_category
    ADD CONSTRAINT transaction_category_pkey PRIMARY KEY (id_trans_cat);


--
-- Name: transaction_subcategory transaction_subcategory_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory
    ADD CONSTRAINT transaction_subcategory_pkey PRIMARY KEY (id_trans_subcat);


--
-- Name: transaction_type transaction_type_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (id_trans_type);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id_transaction);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: bank_account_types bank_account_types_id_ba_own_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.bank_account_types
    ADD CONSTRAINT bank_account_types_id_ba_own_fkey FOREIGN KEY (id_ba_own) REFERENCES expense_tracker.bank_account_owner(id_ba_own);


--
-- Name: transaction_bank_accounts transaction_bank_accounts_id_ba_own_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT transaction_bank_accounts_id_ba_own_fkey FOREIGN KEY (id_ba_own) REFERENCES expense_tracker.bank_account_owner(id_ba_own);


--
-- Name: transaction_bank_accounts transaction_bank_accounts_id_ba_typ_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT transaction_bank_accounts_id_ba_typ_fkey FOREIGN KEY (id_ba_typ) REFERENCES expense_tracker.bank_account_types(id_ba_type);


--
-- Name: transaction_subcategory transaction_subcategory_id_trans_cat_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory
    ADD CONSTRAINT transaction_subcategory_id_trans_cat_fkey FOREIGN KEY (id_trans_cat) REFERENCES expense_tracker.transaction_category(id_trans_cat);


--
-- Name: transactions transactions_id_trans_ba_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_id_trans_ba_fkey FOREIGN KEY (id_trans_ba) REFERENCES expense_tracker.transaction_bank_accounts(id_trans_ba);


--
-- Name: transactions transactions_id_trans_cat_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_id_trans_cat_fkey FOREIGN KEY (id_trans_cat) REFERENCES expense_tracker.transaction_category(id_trans_cat);


--
-- Name: transactions transactions_id_trans_subcat_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_id_trans_subcat_fkey FOREIGN KEY (id_trans_subcat) REFERENCES expense_tracker.transaction_subcategory(id_trans_subcat);


--
-- Name: transactions transactions_id_trans_type_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_id_trans_type_fkey FOREIGN KEY (id_trans_type) REFERENCES expense_tracker.transaction_type(id_trans_type);


--
-- Name: transactions transactions_id_user_fkey; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: expense_tracker_group
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_id_user_fkey FOREIGN KEY (id_user) REFERENCES expense_tracker.users(id_user);


--
-- PostgreSQL database dump complete
--

