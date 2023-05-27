--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE qrmenu;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:kU3gh6aOvw/QJ0C1TLL3iw==$5bejHBO1kJkfh0wOvwKZZlFYxzqagNq1E2f6tsHcIoc=:qODSea1oq3SrXhcbYY56W6GNLQCxAhlhII8AeociVJA=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- Database "qrmenu" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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
-- Name: qrmenu; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE qrmenu WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE qrmenu OWNER TO postgres;

\connect qrmenu

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    qr text DEFAULT public.uuid_generate_v4(),
    status bigint DEFAULT 1,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    theme bigint DEFAULT 1
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: change_passwords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.change_passwords (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying(255) NOT NULL,
    jwt text,
    account_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    status bigint DEFAULT 0,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.change_passwords OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email text,
    password text,
    full_name character varying(255) NOT NULL,
    mobile character varying(255) NOT NULL,
    status character varying(255) DEFAULT '0'::character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: menus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menus (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    price_s numeric(7,2),
    price_l numeric(7,2),
    image text,
    category_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.menus OWNER TO postgres;

--
-- Name: order_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_transactions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    order_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    menu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    price numeric(7,2),
    qty bigint DEFAULT 1,
    status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.order_transactions OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    order_note character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    payment_type character varying(255)
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    full_name character varying(255) NOT NULL,
    business_name character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mobile character varying(255) NOT NULL,
    logo text DEFAULT public.uuid_generate_v4(),
    account_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    h1 text,
    h2 text,
    h3 text
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: trackings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trackings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    qr text DEFAULT public.uuid_generate_v4(),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.trackings OWNER TO postgres;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, email, password, qr, status, created_at, updated_at, theme) FROM stdin;
d79be938-6f84-4caf-93e6-218faa61f6a6	yellow@yellow.com	$2a$10$PUdnzMignUeoJlfuz/l7B.5.Ug2pBQi6RQ/mzJQ/pzieW.kMNngj6	b8fa4c62-2034-4ca0-9e22-068e1078038c	1	2023-03-31 07:11:57.335241+00	2023-03-31 07:11:57.335241+00	1
f6efb680-b5af-4330-a011-634f8e5693f5	test@gmail.com	$2a$10$.NM2lEfCbzdL1KJJZo7iC.OQ/z8an6SKdCfu5D9xLhKf0of6WHP/a	425a215b-2d34-4a59-82d2-cd879a45a539	1	2023-04-03 19:24:58.718969+00	2023-04-03 19:24:58.718969+00	1
cb5e36ae-aedb-45df-848a-dfaeb4de66ce	a@b.com	$2a$10$ONrnGS/9Itv8K6u8PM5u2O.4w/Ad9cxz.99MZTRh19CbYPWu/.qGi	2d0ad87b-bc4b-473c-86b5-6b2d61fc787f	1	2023-04-03 19:31:27.09815+00	2023-04-03 19:31:27.09815+00	1
29637334-4990-441c-94cd-2cecc6e3ed07	y@slslsl.com	$2a$10$7ayDvQ4.TCfK0TxIhHoF2efK/OczM9HRP9GFZG2DE.6rlrJ/tsVCy	373d4bce-79af-4e77-8ff3-38b579f5ce8a	1	2023-04-03 19:33:34.635003+00	2023-04-03 19:33:34.635003+00	1
eef0695b-9deb-49cb-a64c-b0e7d16425af	well@well.com	$2a$10$gIjMuEoqFoUUIcfy2LBtuOaTcI.r5CFxeLVlLztRD5zmbFaFFaCuW	8f2e47ca-56e9-4945-a811-fd0e08ff0e1e	1	2023-04-03 19:38:39.353149+00	2023-04-03 19:38:39.353149+00	1
d05f4af4-4b0c-4b19-869a-39749e7a75d5	c@c.com	$2a$10$t1P5iSgiskbWADLRiVcly.7aOx2hTtAeabFnfwMedVRsHTSkfgy6S	51731043-67f2-4a2c-8715-d8d23365de4f	1	2023-04-03 19:40:24.223673+00	2023-04-03 19:40:24.223673+00	1
a4310f84-2545-471a-952c-c1cd1e0c2a9b	k@k.com	$2a$10$.ZflADfR9BmSHEfP7ISweeyd0/xq.niyzHUAUCIE8VqDFwOOSO8ES	1c2bf5e9-6c24-40c6-82c0-3913587dc464	1	2023-04-03 19:43:26.143353+00	2023-04-03 19:43:26.143353+00	1
6b734d71-1e1d-48bc-aaef-7d120006e466	h@h.com	$2a$10$8DH3NsqGyuOBurh6HUR2FOj3Q/Mp/nA5Mj01zWk5BsZccSXhmN17G	27765d9a-d237-47d5-9019-0ea20da27a95	1	2023-04-03 19:46:51.593884+00	2023-04-03 19:46:51.593884+00	1
b2bbdd5e-42c5-4f88-804c-23b984364d8e	g@g.com	$2a$10$wPytMgmLDD69IzQ/SX.60eSYHgpU9sX3oyuc4sOQPhtyQskOa4g3O	63fc060c-5af9-4058-b857-b145693b013b	1	2023-04-03 19:50:02.768479+00	2023-04-03 19:50:02.768479+00	1
adfb7609-98f2-459d-99e2-c015d0e4c4b4	t@t.com	$2a$10$okWcnwVDKQCV4n7cbv5dOeog.hEaIBUk3lKih7/TgPUwAfO13Goa6	56008e5a-f4ba-4925-8ec8-7e5029c2ba41	1	2023-04-03 19:52:39.140634+00	2023-04-03 19:52:39.140634+00	1
bd17f812-9388-4c43-ba31-9b4c768a6bc2	e@e.com	$2a$10$Ve607OPQ4l.MfnFhb2z.IOMlC0ATt2LDgwBHYrEo.FvhI.Zgwyyi2	87f76ee9-4c9f-4c8a-9f8f-ca6f410c55de	1	2023-04-03 19:55:12.607335+00	2023-04-03 19:55:12.607335+00	1
1bccafbb-00ca-4abd-9cf7-519d91affe31	awet@qrchaka.com	$2a$10$kUddsTJTw9TD0DwAYzXZ9u/B.vYL5Dv1RYqpHAx3XYOC34AEqGrPW	39e182d5-0fdd-4f6e-9fa9-d81fbb4cc955	1	2023-04-07 10:11:49.889668+00	2023-04-07 10:11:49.889668+00	1
31924924-353a-490a-b8d1-10565c3d9edb	avvvet@gmail.com	$2a$10$h6sWfAaIeW.APnxn7T3.L.arczXpgxm0SCvqqbjaVB.C/OFsmvhg2	proamore	1	2023-03-29 14:47:00.721909+00	2023-05-26 13:29:50.254187+00	2
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, created_at, updated_at) FROM stdin;
0bc92c9f-f749-495f-b21b-55bae9a60fbb	Breakfast	2023-03-29 18:03:12.102477+00	2023-03-29 18:03:12.102477+00
d1bf33bb-52d6-4733-8d72-805c0c61d521	Main Course	2023-03-29 18:04:16.180172+00	2023-03-29 18:04:16.180172+00
f6962a15-cd34-48cf-a4b0-55a93b9ad7bd	Drinks	2023-03-29 18:04:35.68046+00	2023-03-29 18:04:35.68046+00
c2c4041e-9f05-4afd-b8a4-889124792a95	Soup	2023-03-29 18:04:52.153131+00	2023-03-29 18:04:52.153131+00
bb793a17-9b57-4549-99db-754b6750d0fb	Appetizers	2023-03-29 18:05:05.448912+00	2023-03-29 18:05:05.448912+00
52bed839-7ec0-4410-bbd0-0bb988cc7694	Pastas	2023-03-29 18:05:17.582261+00	2023-03-29 18:05:17.582261+00
f9e3e703-928c-4231-8935-450cca8cf59f	Sandwiches	2023-03-29 18:05:29.396243+00	2023-03-29 18:05:29.396243+00
e7a917d2-a622-4524-9600-60e14428d7f7	Sides	2023-03-29 18:05:37.762565+00	2023-03-29 18:05:37.762565+00
f5ce41e9-c3e9-4878-b860-73dfd4886e5a	Juice	2023-03-29 18:05:50.922252+00	2023-03-29 18:05:50.922252+00
8fb5814a-0f16-48ee-ac9f-aadaffe7dba4	Ice Cream	2023-03-29 18:06:03.038544+00	2023-03-29 18:06:03.038544+00
a744cc76-076c-4bbc-97c6-2051bb871422	Pizza	2023-03-29 18:06:14.608353+00	2023-03-29 18:06:14.608353+00
81173496-b583-4d36-b05a-d332023e8c41	Extras	2023-03-29 18:06:23.923981+00	2023-03-29 18:06:23.923981+00
\.


--
-- Data for Name: change_passwords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.change_passwords (id, email, jwt, account_id, status, created_at, updated_at) FROM stdin;
e9faf690-64de-400b-9bd0-6930189ec32a	avvvet@gmail.com	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiMzE5MjQ5MjQtMzUzYS00OTBhLWI4ZDEtMTA1NjVjM2Q5ZWRiIn0.ucDgxfVXxC_uPVEr_KW-901sxKytRYL2mj2Nj-2f9ag	31924924-353a-490a-b8d1-10565c3d9edb	0	2023-04-03 19:51:46.237835+00	2023-04-03 19:51:46.237835+00
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, email, password, full_name, mobile, status, created_at, updated_at) FROM stdin;
3a49fa4a-bd45-44fd-ae64-6963ff4ec34b			Angel Awet	0911090909	0	2023-04-17 20:18:08.86159+00	2023-04-17 20:18:08.86159+00
b64e5873-3792-45dd-bbd8-76fee8081d73			Christian Awet	0911232324	0	2023-04-17 20:19:13.368178+00	2023-04-17 20:19:13.368178+00
8c1168bd-3f25-4fe5-b8a6-c9ec6d0717ee			mR aWET	0911003994	0	2023-04-17 20:23:19.510582+00	2023-04-17 20:23:19.510582+00
cc7f8ba3-4314-43a9-b5f9-5fc646c76e81			Awet	091100343434	0	2023-04-17 20:44:29.029055+00	2023-04-17 20:44:29.029055+00
551645f0-8991-486f-8b3f-0d244b760ebd			Aster Abraha	0911464818	0	2023-04-19 11:53:08.672541+00	2023-04-19 11:53:08.672541+00
1453d57c-d89b-44cc-9c93-3bc71bf705d5			Daniel	Temesgen	0	2023-04-19 12:39:29.728329+00	2023-04-19 12:39:29.728329+00
525e66ac-e5d3-4a4f-96fb-773e7768758b			yellow	0911232323	0	2023-04-19 12:45:09.426515+00	2023-04-19 12:45:09.426515+00
b807e3f8-f187-47df-a97d-a3793fda095f			Chole	09887532	0	2023-04-28 05:45:28.918961+00	2023-04-28 05:45:28.918961+00
42b9fd3b-6182-4ef2-b52d-af0aefc4faec			Yellwo	0911202020	0	2023-05-01 10:09:29.249947+00	2023-05-01 10:09:29.249947+00
6bfc733a-4679-4fc2-8268-1a83d0709973			Christian Awet 	0911607080	0	2023-05-01 10:20:31.511678+00	2023-05-01 10:20:31.511678+00
7b33e6a4-0ddb-4d8e-ad1d-6dae380a7f47			Christian’	099398777	0	2023-05-01 10:26:55.844523+00	2023-05-01 10:26:55.844523+00
26acf868-94cb-4217-a7f8-3f86518bb52d			Yellow 	0911343434	0	2023-05-03 04:27:27.476445+00	2023-05-03 04:27:27.476445+00
f53de781-35c6-498a-8f83-90a2dd340c6a			Awet	0911202124	0	2023-05-03 04:53:36.489903+00	2023-05-03 04:53:36.489903+00
72d8b53d-aaf1-4d86-af40-00e2d254acfe			Awesome 	0911808080	0	2023-05-03 05:01:39.421482+00	2023-05-03 05:01:39.421482+00
\.


--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menus (id, name, description, price_s, price_l, image, category_id, account_id, created_at, updated_at) FROM stdin;
5d99355a-c2aa-4bb5-9e9f-8ae42cb4aaca	yellow	adfs	3.00	3.00		0bc92c9f-f749-495f-b21b-55bae9a60fbb	d79be938-6f84-4caf-93e6-218faa61f6a6	2023-03-31 07:12:12.049123+00	2023-03-31 07:12:12.049123+00
a4c49fcb-a582-490a-abdd-d0e7bcf93f7a	asfsa	sfasdf	44.00	44.00		0bc92c9f-f749-495f-b21b-55bae9a60fbb	d79be938-6f84-4caf-93e6-218faa61f6a6	2023-03-31 07:12:20.547438+00	2023-03-31 07:12:20.547438+00
910ea7f6-8ec1-4dcc-ad9b-9c909eb2b632	Vanilla 	Natural vanila	400.00	400.00	9288e8d4-93a3-4e9c-b6d9-2ea70cb65c62.png	8fb5814a-0f16-48ee-ac9f-aadaffe7dba4	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-17 10:11:31.959864+00
e26c8127-77eb-400f-a62a-b7ba30696e36	Chocolate cake 	cake flavored with melted chocolate, cocoa powder, or both.	450.00	450.00	2a734bfe-646f-4e2d-b00f-a21e133ef639.png	0bc92c9f-f749-495f-b21b-55bae9a60fbb	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-17 10:35:02.512482+00
ea0ab991-8fa0-4897-a5f5-547e2acae9d8	we	qew	45.00	45.00	83cb1207-93a4-4e04-a12a-0e15c7fa04c9.png	d1bf33bb-52d6-4733-8d72-805c0c61d521	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-17 10:35:51.430382+00
b4da10e5-6eb6-45b3-aa28-dac62876b987	Torta della Nonna	This cake is very suitable to make a large number of servings for celebrations write in your order the text to be written and any decoration preference 	200.00	200.00	d1317f15-5111-4512-a95e-098fdf4ce5e5.png	f9e3e703-928c-4231-8935-450cca8cf59f	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-18 16:39:26.584191+00
bee3df2f-6f52-471c-b654-8160db997be0	Anna Belousova 	egg butter milk sugar lemon strawbary	700.00	900.00	8bbf1257-84be-43e0-9317-9c7c1b0cc580.png	f5ce41e9-c3e9-4878-b860-73dfd4886e5a	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-18 16:39:46.406299+00
26e2fb80-973c-4cdc-b5e8-ccd99f458068	Tiramisu Cake	Tiramisu is a coffeeflavoured Italian dessert It is made of ladyfingers dipped in coffee	740.00	950.00	870658a3-a053-4fd5-a840-9eb1a977e08b.png	bb793a17-9b57-4549-99db-754b6750d0fb	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-18 16:41:33.378823+00
e83c4e7d-1ad5-425e-a733-d99e14bfd8a8	Tiramisu Cake	coffeeflavoured Italian dessert It is made of ladyfingers dipped in coffee	850.00	1200.00	92e68db5-f685-4996-bbb2-f0ba6c4d57dd.png	0bc92c9f-f749-495f-b21b-55bae9a60fbb	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-18 22:37:48.28061+00
1a7d8ec6-bec5-402d-a559-994797ef2105	Omelet burger cheesse with paproni topping	This cake is very suitable to make a large number of servings for celebrations write in your order the text to be written and any decoration preference 	140.00	150.00	d185db88-24e5-45dc-b49e-1fbd27a44d0e.png	0bc92c9f-f749-495f-b21b-55bae9a60fbb	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-18 22:38:03.368331+00
\.


--
-- Data for Name: order_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_transactions (id, order_id, menu_id, price, qty, status, created_at, updated_at) FROM stdin;
f6723a49-d3bf-4d50-9b71-1f46acd8c5fb	c6bceaff-1b7b-4078-aadf-e008bb5d3e01	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	4		2023-04-17 20:18:34.006003+00	2023-04-17 20:18:34.006003+00
57d8dbb2-a778-4557-b7a9-47b237b96d31	c6bceaff-1b7b-4078-aadf-e008bb5d3e01	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-17 20:18:34.006003+00	2023-04-17 20:18:34.006003+00
7b5faffb-57d0-4535-9738-2b9ae1503ed9	c6bceaff-1b7b-4078-aadf-e008bb5d3e01	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-17 20:18:34.006003+00	2023-04-17 20:18:34.006003+00
b499ae2f-934b-482e-94a3-475f6331bfc8	ef458cf1-d72a-479c-84c2-938559125bb9	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-17 20:19:18.170118+00	2023-04-17 20:19:18.170118+00
218a28b1-8a70-41c9-9118-67a7d391f701	ef458cf1-d72a-479c-84c2-938559125bb9	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-17 20:19:18.170118+00	2023-04-17 20:19:18.170118+00
1d72a6e9-6fa6-4f32-82b5-0271cb9cf432	ef458cf1-d72a-479c-84c2-938559125bb9	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-17 20:19:18.170118+00	2023-04-17 20:19:18.170118+00
a51f438d-0ca5-4aa6-bb00-d34893065096	1a19fd5e-d44d-4745-9659-dbe3cc98e8e9	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-17 20:23:19.512738+00	2023-04-17 20:23:19.512738+00
3449d30c-c80f-460b-b7b3-a77f0b7df057	1a19fd5e-d44d-4745-9659-dbe3cc98e8e9	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-17 20:23:19.512738+00	2023-04-17 20:23:19.512738+00
e9bea0be-c2a5-4f9d-a8b2-363cced63102	1a19fd5e-d44d-4745-9659-dbe3cc98e8e9	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-17 20:23:19.512738+00	2023-04-17 20:23:19.512738+00
03668a46-5c60-465c-9fe7-a02afc7c07ed	b1b8bd0f-54bc-4d1d-be26-d81d9ac12277	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	2		2023-04-17 20:24:30.92537+00	2023-04-17 20:24:30.92537+00
5ca3e9a5-2589-40c3-b3a0-984c96d7bb33	b1b8bd0f-54bc-4d1d-be26-d81d9ac12277	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	2		2023-04-17 20:24:30.92537+00	2023-04-17 20:24:30.92537+00
984f8b3a-01d9-4cc5-9567-67f4aef4b9ab	b1b8bd0f-54bc-4d1d-be26-d81d9ac12277	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-17 20:24:30.92537+00	2023-04-17 20:24:30.92537+00
74601164-a3ba-4970-b4fe-bafa85825499	7ad33e8d-17e4-4df2-8ec3-8b67562aca47	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	2		2023-04-17 20:44:29.0305+00	2023-04-17 20:44:29.0305+00
9a0f5f71-f3d1-41b3-880a-6dcfa899c76f	7042ac2a-2402-4364-8f48-3c0b2991e917	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-19 09:41:17.613373+00	2023-04-19 09:41:17.613373+00
4df63218-f65e-4af6-9c6d-19a04fd91d78	ce6f071e-d523-475d-800f-c1a397a506f1	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-19 11:53:08.675626+00	2023-04-19 11:53:08.675626+00
65e946b1-b3fa-4897-84b4-7c269e8eb82d	ce6f071e-d523-475d-800f-c1a397a506f1	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-19 11:53:08.675626+00	2023-04-19 11:53:08.675626+00
9caf5d17-8219-4077-a4c7-132304ec56ec	ce6f071e-d523-475d-800f-c1a397a506f1	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-19 11:53:08.675626+00	2023-04-19 11:53:08.675626+00
8cdd5546-41f0-45eb-8d23-abc131f4f057	c47142d4-9d9b-4cf6-9d44-7d9a4a1e0bc0	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	3		2023-04-19 12:39:29.729652+00	2023-04-19 12:39:29.729652+00
8bbcd232-bf6b-4f03-b281-7c0472571e8f	c47142d4-9d9b-4cf6-9d44-7d9a4a1e0bc0	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-19 12:39:29.729652+00	2023-04-19 12:39:29.729652+00
6b1f2007-0ca7-4707-ab34-6744817432d2	c47142d4-9d9b-4cf6-9d44-7d9a4a1e0bc0	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	2		2023-04-19 12:39:29.729652+00	2023-04-19 12:39:29.729652+00
d3626dc1-3cc6-41be-8421-67ea7d137914	6bb00ad0-ada4-4db8-a154-a141c84faec1	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-19 12:45:09.428591+00	2023-04-19 12:45:09.428591+00
039a54fd-4818-4efb-94a9-8c07fcef281b	6bb00ad0-ada4-4db8-a154-a141c84faec1	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-19 12:45:09.428591+00	2023-04-19 12:45:09.428591+00
ba37ed39-87c3-4245-9923-5104ae7369d0	6bb00ad0-ada4-4db8-a154-a141c84faec1	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-04-19 12:45:09.428591+00	2023-04-19 12:45:09.428591+00
362a1856-d049-4efe-9a4b-fdedb83cc2d6	4b65ab0e-c5f1-4c75-ba22-a2a8d39a2036	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-04-27 12:00:07.771673+00	2023-04-27 12:00:07.771673+00
5c034666-a164-493e-ab43-b1cf7244cf2e	4b65ab0e-c5f1-4c75-ba22-a2a8d39a2036	e26c8127-77eb-400f-a62a-b7ba30696e36	200.00	2		2023-04-27 12:00:07.771673+00	2023-04-27 12:00:07.771673+00
b3886531-f4c0-4b9e-9f22-9221cf3b62e3	964d4a93-60bb-4359-901e-5f319edfd0a5	26e2fb80-973c-4cdc-b5e8-ccd99f458068	150.00	1		2023-04-28 05:45:28.921685+00	2023-04-28 05:45:28.921685+00
3ade044c-d6b4-466c-bdaf-b94e8b8cf31a	964d4a93-60bb-4359-901e-5f319edfd0a5	e83c4e7d-1ad5-425e-a733-d99e14bfd8a8	520.00	1		2023-04-28 05:45:28.921685+00	2023-04-28 05:45:28.921685+00
182a99c1-f2dc-493d-a759-595e9032cb3a	3bfcc596-867a-4d0d-bc27-515cb661db08	e26c8127-77eb-400f-a62a-b7ba30696e36	450.00	1		2023-05-01 10:03:40.16712+00	2023-05-01 10:03:40.16712+00
56e137ac-7381-4564-bf72-cbbe9aad2565	3bfcc596-867a-4d0d-bc27-515cb661db08	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	3		2023-05-01 10:03:40.16712+00	2023-05-01 10:03:40.16712+00
a07770dd-9e9c-4329-a36e-addfb0f46a66	cc994fab-b406-4c9d-9371-2445130cc4a0	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-05-01 10:09:29.253545+00	2023-05-01 10:09:29.253545+00
e6a48abb-3cb9-4a6a-9263-2d560012afab	b31c360c-1acc-44af-b545-aa2a93596589	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	3		2023-05-01 10:20:31.515169+00	2023-05-01 10:20:31.515169+00
e02895db-39de-4940-9ece-a1997b58acb0	e5ba23bf-8e10-47be-b3c0-b9000debbb5f	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-05-01 10:26:55.84616+00	2023-05-01 10:26:55.84616+00
5f8ca40a-eba1-43e3-bc43-a0a15e794670	e5ba23bf-8e10-47be-b3c0-b9000debbb5f	e26c8127-77eb-400f-a62a-b7ba30696e36	450.00	1		2023-05-01 10:26:55.84616+00	2023-05-01 10:26:55.84616+00
b35b2cd2-7b3b-4c95-9482-ad2babf82171	e5ba23bf-8e10-47be-b3c0-b9000debbb5f	e83c4e7d-1ad5-425e-a733-d99e14bfd8a8	720.00	1		2023-05-01 10:26:55.84616+00	2023-05-01 10:26:55.84616+00
9f1e2107-e84a-43d5-947a-eea6a8392f57	e5ba23bf-8e10-47be-b3c0-b9000debbb5f	1a7d8ec6-bec5-402d-a559-994797ef2105	140.00	1		2023-05-01 10:26:55.84616+00	2023-05-01 10:26:55.84616+00
2b4eb8c1-6a43-4b45-afee-a561527b9e83	e5ba23bf-8e10-47be-b3c0-b9000debbb5f	26e2fb80-973c-4cdc-b5e8-ccd99f458068	740.00	1		2023-05-01 10:26:55.84616+00	2023-05-01 10:26:55.84616+00
d863e8e5-831b-4302-803d-74b58c9d9629	82b0375a-d21c-4a4f-a4cf-6fe531d4efbd	ea0ab991-8fa0-4897-a5f5-547e2acae9d8	45.00	1		2023-05-03 04:27:27.480262+00	2023-05-03 04:27:27.480262+00
7086eb49-0cb0-4bc8-9d57-3730aa7f1e65	82b0375a-d21c-4a4f-a4cf-6fe531d4efbd	26e2fb80-973c-4cdc-b5e8-ccd99f458068	740.00	1		2023-05-03 04:27:27.480262+00	2023-05-03 04:27:27.480262+00
42548a6b-f4b3-48ca-afb0-13b7aded9bce	10d27443-a79f-4d3a-b172-5ca2a3682342	e26c8127-77eb-400f-a62a-b7ba30696e36	450.00	1		2023-05-03 04:53:36.491484+00	2023-05-03 04:53:36.491484+00
7376bd4e-1169-4e5a-863e-e0bb6ea7af13	10d27443-a79f-4d3a-b172-5ca2a3682342	e83c4e7d-1ad5-425e-a733-d99e14bfd8a8	720.00	1		2023-05-03 04:53:36.491484+00	2023-05-03 04:53:36.491484+00
bf205c1f-16b9-4130-9cd7-9aeb0fb2acb3	10d27443-a79f-4d3a-b172-5ca2a3682342	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	1		2023-05-03 04:53:36.491484+00	2023-05-03 04:53:36.491484+00
227d0b65-1d5c-4c33-834f-867c584d4dd2	13a8e5fb-8567-4b27-93ca-174ed624d69e	b4da10e5-6eb6-45b3-aa28-dac62876b987	200.00	2		2023-05-03 05:01:39.425823+00	2023-05-03 05:01:39.425823+00
299faab0-0b92-4563-b289-e871d6efac7e	13a8e5fb-8567-4b27-93ca-174ed624d69e	e26c8127-77eb-400f-a62a-b7ba30696e36	450.00	1		2023-05-03 05:01:39.425823+00	2023-05-03 05:01:39.425823+00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_id, order_note, status, created_at, updated_at, payment_type) FROM stdin;
c6bceaff-1b7b-4078-aadf-e008bb5d3e01	3a49fa4a-bd45-44fd-ae64-6963ff4ec34b	Your love surround me		2023-04-17 20:18:29.66445+00	2023-04-17 20:18:29.66445+00	\N
ef458cf1-d72a-479c-84c2-938559125bb9	b64e5873-3792-45dd-bbd8-76fee8081d73	Your love surround me		2023-04-17 20:19:14.635475+00	2023-04-17 20:19:14.635475+00	\N
1a19fd5e-d44d-4745-9659-dbe3cc98e8e9	8c1168bd-3f25-4fe5-b8a6-c9ec6d0717ee	Your love surround me		2023-04-17 20:23:19.511709+00	2023-04-17 20:23:19.511709+00	\N
b1b8bd0f-54bc-4d1d-be26-d81d9ac12277	8c1168bd-3f25-4fe5-b8a6-c9ec6d0717ee	Your love surround me		2023-04-17 20:24:30.924247+00	2023-04-17 20:24:30.924247+00	\N
7ad33e8d-17e4-4df2-8ec3-8b67562aca47	cc7f8ba3-4314-43a9-b5f9-5fc646c76e81	Your love surround me		2023-04-17 20:44:29.029867+00	2023-04-17 20:44:29.029867+00	\N
e5ba23bf-8e10-47be-b3c0-b9000debbb5f	7b33e6a4-0ddb-4d8e-ad1d-6dae380a7f47	Fast please	confirmed	2023-05-01 10:26:55.845321+00	2023-05-01 11:31:19.426932+00	cbe-birr
ce6f071e-d523-475d-800f-c1a397a506f1	551645f0-8991-486f-8b3f-0d244b760ebd	I need my order to be fast	confirmed	2023-04-19 11:53:08.673984+00	2023-05-01 11:32:15.26079+00	\N
cc994fab-b406-4c9d-9371-2445130cc4a0	42b9fd3b-6182-4ef2-b52d-af0aefc4faec	Yellow 	confirmed	2023-05-01 10:09:29.251532+00	2023-05-01 11:33:41.088793+00	
c47142d4-9d9b-4cf6-9d44-7d9a4a1e0bc0	1453d57c-d89b-44cc-9c93-3bc71bf705d5	7ellow	confirmed	2023-04-19 12:39:29.729013+00	2023-05-01 11:35:25.861745+00	\N
b31c360c-1acc-44af-b545-aa2a93596589	6bfc733a-4679-4fc2-8268-1a83d0709973	Be fast 	confirmed	2023-05-01 10:20:31.513273+00	2023-05-01 11:35:40.954701+00	cbe-birr
964d4a93-60bb-4359-901e-5f319edfd0a5	b807e3f8-f187-47df-a97d-a3793fda095f	Be fast	confirmed	2023-04-28 05:45:28.920159+00	2023-05-01 11:39:36.223931+00	\N
7042ac2a-2402-4364-8f48-3c0b2991e917	8c1168bd-3f25-4fe5-b8a6-c9ec6d0717ee	Your love surround me	confirmed	2023-04-19 09:41:17.612718+00	2023-05-01 11:40:32.982832+00	\N
6bb00ad0-ada4-4db8-a154-a141c84faec1	525e66ac-e5d3-4a4f-96fb-773e7768758b	yees	confirmed	2023-04-19 12:45:09.427532+00	2023-05-01 11:40:45.708816+00	\N
4b65ab0e-c5f1-4c75-ba22-a2a8d39a2036	525e66ac-e5d3-4a4f-96fb-773e7768758b	be fast 	canceled	2023-04-27 12:00:07.768378+00	2023-05-01 11:40:54.037054+00	\N
82b0375a-d21c-4a4f-a4cf-6fe531d4efbd	26acf868-94cb-4217-a7f8-3f86518bb52d	Yelloe	confirmed	2023-05-03 04:27:27.478514+00	2023-05-03 04:27:51.965554+00	
10d27443-a79f-4d3a-b172-5ca2a3682342	f53de781-35c6-498a-8f83-90a2dd340c6a		canceled	2023-05-03 04:53:36.490703+00	2023-05-03 04:54:08.135454+00	cbe-birr
3bfcc596-867a-4d0d-bc27-515cb661db08	8c1168bd-3f25-4fe5-b8a6-c9ec6d0717ee	Hello 	confirmed	2023-05-01 10:03:40.166581+00	2023-05-03 04:54:20.656207+00	
13a8e5fb-8567-4b27-93ca-174ed624d69e	72d8b53d-aaf1-4d86-af40-00e2d254acfe		confirmed	2023-05-03 05:01:39.423684+00	2023-05-03 05:02:03.054384+00	tele-birr
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, full_name, business_name, address, email, mobile, logo, account_id, created_at, updated_at, h1, h2, h3) FROM stdin;
0193383a-8adf-49cb-8c8e-b1eb4da7e2d5	asdf	sf	fsd	dg@g.com	345	ded1632a-f37b-426a-8c91-5f792bca6bdf	d79be938-6f84-4caf-93e6-218faa61f6a6	2023-03-31 10:25:19.486024+00	2023-03-31 10:25:19.486024+00	\N	\N	\N
e44c4dfd-48d6-4891-8d69-55e72c831412	yes	Christian And Angel Caffee	summit	awet@qrchaka.com	0911232323	e47ad2d2-67ff-44de-98e9-debfc7e8ca0e	1bccafbb-00ca-4abd-9cf7-519d91affe31	2023-04-07 10:12:35.77012+00	2023-04-07 10:12:35.77012+00	Mon. - Thurs. 6 a.m. - 9 p.m.	Fri. - Sat. 6 a.m. - 11 p.m.	Sunday 8 a.m. - 2 p.m.
1c764f57-2f86-47f2-a3e4-0e59120d6e9d	yes	Christian Caffee	addis ababa	g@yes.com	0911003994	11269d76-9ffa-43d6-aab8-bb9297d7cbcc.png	31924924-353a-490a-b8d1-10565c3d9edb	0001-01-01 00:00:00+00	2023-05-01 10:28:59.195693+00	Mon. - Thurs. 6 a.m. - 9 p.m.	Fri. - Sat. 6 a.m. - 11 p.m.	Sunday 8 a.m. - 2 p.m.
\.


--
-- Data for Name: trackings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trackings (id, qr, created_at, updated_at) FROM stdin;
78bff7db-d609-4a45-9cb4-c59affb84c27	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:29:26.130368+00	2023-03-31 10:29:26.130368+00
1d5b6136-e511-407d-a528-60a01327aea9	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:29:47.235186+00	2023-03-31 10:29:47.235186+00
583b4749-a501-4298-9f8f-4f6e1b0a19d8	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:30:43.407646+00	2023-03-31 10:30:43.407646+00
27f76094-0833-4970-88b5-7a310fc8b153	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:31:13.206118+00	2023-03-31 10:31:13.206118+00
84853f70-8f65-4d69-baf2-424757222717	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:31:13.463327+00	2023-03-31 10:31:13.463327+00
a8c35848-d7d6-4db4-8a41-b2e525269d67	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:31:23.64429+00	2023-03-31 10:31:23.64429+00
f57e69f9-4d4f-490a-a3fa-8ec2eeaabe3c	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:31:23.778985+00	2023-03-31 10:31:23.778985+00
97be24f6-5be5-41b2-b402-6782e417a52e	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:33:12.380576+00	2023-03-31 10:33:12.380576+00
5b876201-47be-4fcc-9457-c4a3e56b02eb	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:33:12.677747+00	2023-03-31 10:33:12.677747+00
dbac4cb3-9eea-4ba7-8589-1033f2447339	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:33:27.847028+00	2023-03-31 10:33:27.847028+00
2e63d982-6c44-4363-b51e-ae170bd17891	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:33:28.006149+00	2023-03-31 10:33:28.006149+00
b5546f71-557b-4219-a26c-7752b1e8067f	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:36:40.925507+00	2023-03-31 10:36:40.925507+00
5432aacb-5541-4725-b4b7-e7ea47938dc6	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:37:28.232795+00	2023-03-31 10:37:28.232795+00
0fe7adc8-8719-432d-8ec5-60d9f4deec84	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:37:49.487901+00	2023-03-31 10:37:49.487901+00
21b75f38-1ee6-49e5-ae80-400c18a26fa4	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:38:12.411884+00	2023-03-31 10:38:12.411884+00
b7077860-b4a4-480e-be29-cf4e8ecb19b3	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-03-31 10:38:12.658389+00	2023-03-31 10:38:12.658389+00
8f787df4-10c3-4741-99b0-378981d21364	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:35:28.084332+00	2023-04-04 10:35:28.084332+00
af23cee5-6ac7-4845-874a-7c38808aeeb8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:39:49.597237+00	2023-04-04 10:39:49.597237+00
7500b0b9-ab30-4274-92d1-9c016ac03b8e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:45:52.955452+00	2023-04-04 10:45:52.955452+00
a1579dc2-a4d4-42f8-8121-e207d4db9360	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:46:53.76632+00	2023-04-04 10:46:53.76632+00
023c1b28-9899-45fe-aae0-a1c349e1ee1c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:47:21.050213+00	2023-04-04 10:47:21.050213+00
7c08122d-c6b5-4fc9-b35f-3434231543a3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:47:21.226778+00	2023-04-04 10:47:21.226778+00
35c13b9c-2dcd-40a6-9158-e5b896a0e7c4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:47:56.676202+00	2023-04-04 10:47:56.676202+00
63aff5f1-28ed-4806-a780-2cdd3a3ed942	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:47:56.83573+00	2023-04-04 10:47:56.83573+00
2cf963ed-cd3a-44c4-94c1-344e111481ca	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:48:49.912288+00	2023-04-04 10:48:49.912288+00
6d0b5c6e-996a-4564-a8ed-d9a9ed60be99	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:48:50.064936+00	2023-04-04 10:48:50.064936+00
7a017fc1-01f5-4cc6-9497-118b66860f69	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:50:01.283831+00	2023-04-04 10:50:01.283831+00
f19fc4e5-a9ae-4bb4-80a1-13afd0a3103c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 10:50:01.433481+00	2023-04-04 10:50:01.433481+00
e5d78a94-df76-452d-bf92-f4574c9ca026	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:05:22.761119+00	2023-04-04 11:05:22.761119+00
b184e715-70c1-4730-a8cf-f31a1e077d8c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:05:58.980968+00	2023-04-04 11:05:58.980968+00
063d2646-8114-41dc-ba7f-2ab97847ec3c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:05:59.151157+00	2023-04-04 11:05:59.151157+00
02394bb4-826d-4eb0-9775-55558989c0a7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:07:09.940372+00	2023-04-04 11:07:09.940372+00
50748882-bc3e-4620-ba05-1e9bb10a0e87	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:07:10.440512+00	2023-04-04 11:07:10.440512+00
5f001ae0-647c-4880-b4f6-b73abca552e4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:07:31.231683+00	2023-04-04 11:07:31.231683+00
bbd23a14-6390-43cc-ba74-13a04b925eb3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:07:31.441018+00	2023-04-04 11:07:31.441018+00
3b7ee0fe-cbd6-4a79-a48a-cd4ecc616890	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:08:09.708763+00	2023-04-04 11:08:09.708763+00
aaf2d4ad-c50a-4787-b828-3b8d04be7c60	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:08:09.879235+00	2023-04-04 11:08:09.879235+00
06641a32-651f-4a88-889f-6731bc4520bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:08:48.539099+00	2023-04-04 11:08:48.539099+00
31acf83c-ca32-4621-8b5b-04b9a3ab87cf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:08:49.152809+00	2023-04-04 11:08:49.152809+00
3529040f-0563-4766-920e-fe0a83687bcc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:09:18.749408+00	2023-04-04 11:09:18.749408+00
0ab44d0b-2094-4fba-b516-182c3928d43a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:09:18.897105+00	2023-04-04 11:09:18.897105+00
0522232e-96ed-43f6-95e3-2aff3968804e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:10:41.260164+00	2023-04-04 11:10:41.260164+00
bc8dcfdb-0e5b-4c33-8de8-709ef9464955	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:10:41.460874+00	2023-04-04 11:10:41.460874+00
8f8dee5c-b15e-4920-ad78-65570c7d2efc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:11:07.327867+00	2023-04-04 11:11:07.327867+00
ab18a82f-4872-403b-9f80-e7141a0ca805	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:13:46.603709+00	2023-04-04 11:13:46.603709+00
c9a7b8ff-b0c4-4c6c-a986-1aa3478ecd0d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-04 11:13:46.86885+00	2023-04-04 11:13:46.86885+00
496438cd-578e-4b28-a0e4-cbe40ddb75a5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-06 08:02:54.273913+00	2023-04-06 08:02:54.273913+00
0fd333a4-f88e-416c-a81a-45dd13773aea	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-06 08:03:47.912684+00	2023-04-06 08:03:47.912684+00
d600bc31-aa77-4f81-82e1-0d1c0d460e8a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-06 08:03:59.333411+00	2023-04-06 08:03:59.333411+00
74adb3c4-3360-4015-a474-a9ec33d4175c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:14:34.969815+00	2023-04-07 07:14:34.969815+00
88b02f71-cd96-4fbd-be7f-cd20b724af1b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:20:32.573011+00	2023-04-07 07:20:32.573011+00
3b2a72ad-2a2b-4679-a227-1a5aafa08402	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:26:54.65437+00	2023-04-07 07:26:54.65437+00
fb7000d1-d35d-42a9-813f-c96c0980da35	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:29:22.501324+00	2023-04-07 07:29:22.501324+00
1cbb2651-03a9-421e-9e02-fc4fc85f8586	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:30:00.567667+00	2023-04-07 07:30:00.567667+00
d49b3c9e-c22e-4a91-aa62-25d84ce7603c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:30:01.392968+00	2023-04-07 07:30:01.392968+00
da58dc03-2e37-4d35-ba22-5258d688c083	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:30:31.940589+00	2023-04-07 07:30:31.940589+00
82fc15e5-43b3-47d2-9b24-655070450f29	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:32:25.020604+00	2023-04-07 07:32:25.020604+00
a54382df-19fa-43cf-af8f-e759cebc9448	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:33:47.149915+00	2023-04-07 07:33:47.149915+00
4274e820-d932-4b4f-963e-324cdb8164c1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:34:02.086197+00	2023-04-07 07:34:02.086197+00
fc6b3ebc-03f3-415e-abe7-34340c71e59a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:34:30.341639+00	2023-04-07 07:34:30.341639+00
4d9145ae-3fb8-4ddf-b607-74538f95d2d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:35:26.358447+00	2023-04-07 07:35:26.358447+00
88ab7c04-25b3-4f21-bee8-e27d1ab8d4d9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:39:45.30589+00	2023-04-07 07:39:45.30589+00
3c9c34aa-2580-4ec9-8771-30aac0c842fa	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:39:47.880084+00	2023-04-07 07:39:47.880084+00
fd05bc53-89bd-4f3c-8f14-da2de663c8e2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:40:22.135066+00	2023-04-07 07:40:22.135066+00
de4ece9e-6344-4ec6-9769-fe42e4d0c168	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:44:48.132769+00	2023-04-07 07:44:48.132769+00
e5e9897b-8b1d-4d1c-8919-1632818086b6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 07:45:05.646479+00	2023-04-07 07:45:05.646479+00
91b3ecf7-c750-4661-949d-db5d069850e6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:17:40.500893+00	2023-04-07 08:17:40.500893+00
d70ebdd6-0dcd-4953-9ae8-9258631fb17c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:26:43.218615+00	2023-04-07 08:26:43.218615+00
691a172d-d685-429a-977e-20c39dbe7106	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:26:43.994151+00	2023-04-07 08:26:43.994151+00
805acb99-d19c-407c-8cef-b5b032dabd44	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:26:54.091629+00	2023-04-07 08:26:54.091629+00
24a45af0-bb7b-4acd-89bf-01d7cbd47fd9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:29:39.337623+00	2023-04-07 08:29:39.337623+00
7fd77c13-409a-4239-8501-f528f25fc929	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:29:40.230445+00	2023-04-07 08:29:40.230445+00
a17a915f-c0ca-44bc-ae08-6f2d68c23c86	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:29:40.878572+00	2023-04-07 08:29:40.878572+00
e6f64f71-93b4-4e5c-8b1b-56849b6707c0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 08:30:29.791448+00	2023-04-07 08:30:29.791448+00
b2680414-8406-4938-94e7-fac3d3946d24	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 10:33:37.102056+00	2023-04-07 10:33:37.102056+00
aac68f40-2865-4da4-a304-cc4a978c7449	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 10:38:23.337793+00	2023-04-07 10:38:23.337793+00
ddcf56c7-5b95-4c99-ac09-b05982ae55d6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 10:41:24.291286+00	2023-04-07 10:41:24.291286+00
0f0e59cb-5a1b-4c42-ab88-acda1c261d3d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 10:41:26.86076+00	2023-04-07 10:41:26.86076+00
41e75fa8-7e13-4b76-80d8-ae176c85ad31	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 10:41:27.873426+00	2023-04-07 10:41:27.873426+00
1075e37d-6a44-484e-b3a0-b90ca48b1dc2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:53:04.333291+00	2023-04-07 15:53:04.333291+00
059135dd-a036-4c10-867a-db283f9779f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:54:58.822713+00	2023-04-07 15:54:58.822713+00
c91c2404-ab1b-42dc-8da5-395c0b316270	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:55:00.749853+00	2023-04-07 15:55:00.749853+00
d96d14d7-6070-4168-aa1a-9b51de7254a0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:55:12.422704+00	2023-04-07 15:55:12.422704+00
53567e6f-24aa-49c2-9276-1ba9162c1cb0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:57:10.951489+00	2023-04-07 15:57:10.951489+00
9c61b7b8-2576-4ff9-99fe-fa08aad8c81d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:57:56.46164+00	2023-04-07 15:57:56.46164+00
a3fe9c3f-e0df-4464-85fc-164c25d9566c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:59:30.700517+00	2023-04-07 15:59:30.700517+00
85bf21a8-ad5f-4ec9-8462-d24f9e314731	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 15:59:47.168859+00	2023-04-07 15:59:47.168859+00
513e3484-1176-4570-b643-92178cbc20bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 19:43:17.668692+00	2023-04-07 19:43:17.668692+00
8b055399-ec5d-46ac-936c-212bfe4164f6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-07 19:43:32.67203+00	2023-04-07 19:43:32.67203+00
859a9a0f-974f-44e6-b686-3012914e74a6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-11 06:12:13.593092+00	2023-04-11 06:12:13.593092+00
356aeec9-ab00-48cc-affa-186618f9958b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-11 06:16:31.410919+00	2023-04-11 06:16:31.410919+00
dedfb971-9a62-48c2-a9f9-ff486a73e292	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-11 06:17:25.931728+00	2023-04-11 06:17:25.931728+00
4431453d-b63c-4f4a-a33a-8e1a9566ad41	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-11 06:43:38.609957+00	2023-04-11 06:43:38.609957+00
fb64f856-144a-4753-8ede-0a6b7847bfe3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-11 06:45:04.199333+00	2023-04-11 06:45:04.199333+00
826cb1ba-e8f1-4e99-b1a7-0b9b10b21826	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:47:34.991359+00	2023-04-12 08:47:34.991359+00
5e19098f-8d66-4107-919c-51f27ed9302b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:47:40.670916+00	2023-04-12 08:47:40.670916+00
6f3d47d0-6482-44b4-a569-668d0d5c8994	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:49:31.182889+00	2023-04-12 08:49:31.182889+00
1df8aa75-7ee9-4d74-ac77-443611831b75	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:51:36.358545+00	2023-04-12 08:51:36.358545+00
2e9e0af2-08c9-4523-94a8-5a436b2f5e18	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:52:53.435374+00	2023-04-12 08:52:53.435374+00
38268af6-cd04-4197-a6d9-9c69c8cbaee8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:55:17.11412+00	2023-04-12 08:55:17.11412+00
d1af7b97-89d9-4d88-80b7-dbdb2f7612ec	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 08:55:52.253048+00	2023-04-12 08:55:52.253048+00
2975651d-7d71-46e2-968f-80828a66cec7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:04:17.454633+00	2023-04-12 09:04:17.454633+00
6dd39b20-ef8c-44b5-b144-42434cc3ae9b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:05:01.303941+00	2023-04-12 09:05:01.303941+00
e2ae51f0-809c-4e08-a324-53c8d45d1ff5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:05:42.218013+00	2023-04-12 09:05:42.218013+00
f5a54c19-88b1-4e8f-848f-59424c05521c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:07:13.748211+00	2023-04-12 09:07:13.748211+00
b38b91f5-f0d4-4b68-a945-ca51b827f35f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:07:28.980914+00	2023-04-12 09:07:28.980914+00
ac325295-f62a-4f90-832e-84374f9f9d74	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:08:19.74671+00	2023-04-12 09:08:19.74671+00
9ff23c25-6a7d-4d5d-99f8-6fb451c78481	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:08:39.78367+00	2023-04-12 09:08:39.78367+00
b128320f-d0ae-4909-ba78-4ff2d574e075	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:10:35.917939+00	2023-04-12 09:10:35.917939+00
1f199561-a59e-4ef3-8897-b33ca47f762f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:11:23.729462+00	2023-04-12 09:11:23.729462+00
87a5738f-4a10-4bfb-ba77-c17de29b5612	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:36:31.261289+00	2023-04-12 09:36:31.261289+00
b0aa5577-007c-4d23-a9ba-d9f2fdfdd2cb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:36:39.627047+00	2023-04-12 09:36:39.627047+00
7cd5dbde-9d4a-49ed-9349-8771899648b3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:37:26.085542+00	2023-04-12 09:37:26.085542+00
7d5a8e70-6059-4f4d-a6c5-92a62046dba3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:50:11.309581+00	2023-04-12 09:50:11.309581+00
11140c33-74e9-428f-8a50-57261057f2bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:50:56.717544+00	2023-04-12 09:50:56.717544+00
ffd44922-f9b9-40f7-a2ee-3d63690d2836	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:51:55.963263+00	2023-04-12 09:51:55.963263+00
6cebb214-daac-4268-917c-5d3a72bc5d88	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:52:24.746557+00	2023-04-12 09:52:24.746557+00
cc349393-73dd-4b55-a022-05eed3481792	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 09:52:45.930986+00	2023-04-12 09:52:45.930986+00
207fa304-c5d0-40ba-aae0-d443209ab82d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:19:41.220686+00	2023-04-12 10:19:41.220686+00
bba1274c-d856-4628-94e4-4b809ca6af18	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:19:59.599149+00	2023-04-12 10:19:59.599149+00
9abf5930-1843-489c-b9a8-5f5271b496d9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:20:44.892376+00	2023-04-12 10:20:44.892376+00
ffba84ac-4eb4-4b68-b9a8-ef8c8ef694ca	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:26:51.599779+00	2023-04-12 10:26:51.599779+00
dd38dcd4-cbbc-48bc-93f1-1efa41b0e42c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:27:10.996815+00	2023-04-12 10:27:10.996815+00
1e0f9e8a-7fcc-42c9-b8b8-b8b734951cbb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:27:41.023227+00	2023-04-12 10:27:41.023227+00
6cd8b1ef-6a39-440b-9971-8a2577be3b10	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:34:42.507668+00	2023-04-12 10:34:42.507668+00
1a6b7ce2-adf7-4254-bee4-7a279a515093	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:35:47.228088+00	2023-04-12 10:35:47.228088+00
21d8cbae-4834-4dff-a627-5c8491c8ebf3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:37:10.161516+00	2023-04-12 10:37:10.161516+00
de01071b-a936-461d-84ce-79576beab74b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:50:33.504983+00	2023-04-12 10:50:33.504983+00
3cd7cbb7-1ed4-435e-81b0-7f593ff09d36	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:51:12.511139+00	2023-04-12 10:51:12.511139+00
617be88a-e142-49b5-8ee2-fe90783628dc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:52:01.755725+00	2023-04-12 10:52:01.755725+00
24c246a1-1885-47a5-8dbb-e4310b41a265	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:57:26.95429+00	2023-04-12 10:57:26.95429+00
bef55e65-5007-4041-8887-6d74cdd5beee	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 10:58:54.159109+00	2023-04-12 10:58:54.159109+00
d99a1ee5-d398-4954-b413-a83695b2c9ef	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:02:15.347558+00	2023-04-12 11:02:15.347558+00
3f87cbd0-e1e2-4586-8d9b-fb84a877bf9e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:05:23.468291+00	2023-04-12 11:05:23.468291+00
ba7f8d25-a579-406a-b73c-091003c0929b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:05:35.534785+00	2023-04-12 11:05:35.534785+00
dbd5af33-ba45-4b0e-a341-bb1ea8bc52f7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:06:25.412406+00	2023-04-12 11:06:25.412406+00
70d7016f-b459-44d6-b8d2-5d2e44c45e5e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:07:29.576165+00	2023-04-12 11:07:29.576165+00
7c1f4f69-4ea2-4f79-8f21-6d3b22cfaf6f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:18:10.875373+00	2023-04-12 11:18:10.875373+00
3e7b738f-b031-40c3-b2d5-caadc8320b06	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:18:33.960073+00	2023-04-12 11:18:33.960073+00
ceedf24b-65de-46fa-a5b9-42cbd7205245	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:18:34.910841+00	2023-04-12 11:18:34.910841+00
cf3c5963-e435-4560-9476-23b3ccec605d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:19:02.022578+00	2023-04-12 11:19:02.022578+00
8b4288f0-a991-4d0e-8d42-11e4a82dd2b7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:21:02.785341+00	2023-04-12 11:21:02.785341+00
e9405391-39f2-4d4a-b81f-df55f88e4646	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:45:35.19994+00	2023-04-12 11:45:35.19994+00
f61e86c6-86f5-4a5f-b0fc-3fb5ccd1dd68	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:46:21.047142+00	2023-04-12 11:46:21.047142+00
d50c20d2-0269-48fa-9e82-47d30c159ee7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:48:43.116128+00	2023-04-12 11:48:43.116128+00
2c195ad9-a526-4496-99f6-e872d9b3ad75	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:49:11.605757+00	2023-04-12 11:49:11.605757+00
788c4efa-a6d3-4332-9e5c-344276ae9891	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:50:34.560639+00	2023-04-12 11:50:34.560639+00
51e4a0b1-36bc-4e61-be4d-45abdd1070db	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:52:36.186478+00	2023-04-12 11:52:36.186478+00
781089f4-640a-4707-b6bb-d23911eb6f6e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:56:14.408519+00	2023-04-12 11:56:14.408519+00
aa8d8c24-6c0a-4a56-ba8b-bc44ad1fee07	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:56:24.859263+00	2023-04-12 11:56:24.859263+00
e85eaa6e-1a19-4ca9-91a1-e7a7494d6f3a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:56:45.124239+00	2023-04-12 11:56:45.124239+00
368e51d6-7130-4359-8eea-ae59ff9df2dc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-12 11:57:30.456004+00	2023-04-12 11:57:30.456004+00
20862e30-638f-4ced-8ba8-f01c353454e2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:11:11.065216+00	2023-04-14 16:11:11.065216+00
8e7249fb-b07c-4579-8ffd-7566ed9ed9d8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:11:20.667822+00	2023-04-14 16:11:20.667822+00
97dab719-0930-4c86-8da1-58e3cc479550	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:17:21.08865+00	2023-04-14 16:17:21.08865+00
bb37a6df-b7b4-41c8-adb8-576baaaaf530	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:17:22.424377+00	2023-04-14 16:17:22.424377+00
13101635-e58e-4b79-943c-3ddd9389652b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:18:52.013657+00	2023-04-14 16:18:52.013657+00
82015432-9a3c-4153-b0d8-dad30903d383	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:19:35.740221+00	2023-04-14 16:19:35.740221+00
c65dd54a-fa0f-4fd4-9a9c-81ab8b8186b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:22:53.718702+00	2023-04-14 16:22:53.718702+00
dd549769-506c-4fb9-83ba-b411826d69ed	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:32:10.61886+00	2023-04-14 16:32:10.61886+00
eb30e0b8-b9a3-44e4-8ac7-7733eae66751	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:32:44.226908+00	2023-04-14 16:32:44.226908+00
227fc6a2-2086-46be-927a-fff840eb713e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:37:09.11299+00	2023-04-14 16:37:09.11299+00
cb80d7c9-71e1-4f0c-9102-de239e5d0629	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:41:52.699329+00	2023-04-14 16:41:52.699329+00
d0aa025b-fe38-4bf0-9968-fd88f9302600	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:41:55.132507+00	2023-04-14 16:41:55.132507+00
525dd0f9-bc84-48a1-8149-165187ff83fd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:42:04.352885+00	2023-04-14 16:42:04.352885+00
aa1d57bd-77cd-4256-ad60-8876542398a2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:42:22.558061+00	2023-04-14 16:42:22.558061+00
408ebd79-d244-4de4-b74e-2a90a966dc3e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:43:34.247272+00	2023-04-14 16:43:34.247272+00
ecfefa9d-01a3-48f9-bc34-b02f20fc5143	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:47:03.553528+00	2023-04-14 16:47:03.553528+00
d4e89cbe-6bc8-461c-b039-e4ab5b897b89	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:47:32.586033+00	2023-04-14 16:47:32.586033+00
e0839afe-ef6b-4771-a880-56c3689f68a8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:58:03.085606+00	2023-04-14 16:58:03.085606+00
9afd866d-5ef2-4a52-ab69-3d375fbf20bf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:58:07.259385+00	2023-04-14 16:58:07.259385+00
532e0dd2-ea15-4413-b874-c6f7269d328c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 16:58:36.850007+00	2023-04-14 16:58:36.850007+00
b9a6bb3b-e353-41e7-a9f3-067bac320f50	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:00:37.966719+00	2023-04-14 17:00:37.966719+00
b6b9c4ea-a681-4d4c-8cc0-72b99556e9d9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:00:39.603984+00	2023-04-14 17:00:39.603984+00
d8baefe9-cc37-4664-b689-336ff7e6b7db	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:02:06.350828+00	2023-04-14 17:02:06.350828+00
6c1c69d7-b59a-4d32-8f42-a0b9e446e5af	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:03:13.211901+00	2023-04-14 17:03:13.211901+00
75e1f5e2-0544-491f-8e94-4bc872ca84e7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:06:39.412438+00	2023-04-14 17:06:39.412438+00
b85b1897-3a2c-4d90-a99f-dd56e1acc9df	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:15:43.451651+00	2023-04-14 17:15:43.451651+00
16a1a13a-6612-4551-818e-aaf8376740ce	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:20:46.497911+00	2023-04-14 17:20:46.497911+00
7ab09b20-15bf-4c43-9b84-20955ba34774	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:20:58.108744+00	2023-04-14 17:20:58.108744+00
552e845f-d9f1-4e7c-a24b-e9b3911cff81	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:21:35.089826+00	2023-04-14 17:21:35.089826+00
2d80db1c-4a1e-4eca-bbf3-11a30ddc53f0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:23:36.674216+00	2023-04-14 17:23:36.674216+00
e20caa11-1e75-46ba-8226-4c02a91a70e0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:24:46.355218+00	2023-04-14 17:24:46.355218+00
e51e5579-6cb2-4d4f-91d8-19564a2527f4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:25:10.933684+00	2023-04-14 17:25:10.933684+00
1fa33482-8eba-49e7-adb6-0b4b06441885	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:25:59.283868+00	2023-04-14 17:25:59.283868+00
50bf8b07-3a18-47be-84dc-f9bebbc5e99a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:26:19.609182+00	2023-04-14 17:26:19.609182+00
fb75b3ed-bd87-43f1-a547-594f6f591b73	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:27:16.528363+00	2023-04-14 17:27:16.528363+00
8b48962d-ba54-4431-8950-a1c82a433646	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:27:52.864039+00	2023-04-14 17:27:52.864039+00
d2ee84b3-9209-4f47-a49a-b7599d44c4cb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:30:09.342806+00	2023-04-14 17:30:09.342806+00
84690fdc-1b78-48ea-adab-6d3a1be7cd32	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:30:25.56659+00	2023-04-14 17:30:25.56659+00
06f6e1b9-cf18-4ffe-90b9-f7b5dfeaa398	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:33:20.743549+00	2023-04-14 17:33:20.743549+00
519f48c1-f66c-46cf-8179-0e0e75f2bfb6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:33:35.481001+00	2023-04-14 17:33:35.481001+00
9b7b1716-49b5-4bb2-adc8-0db3a71234bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:35:07.693197+00	2023-04-14 17:35:07.693197+00
466c4435-1de1-41d7-b1b4-f6b4f2217d76	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 17:38:13.02774+00	2023-04-14 17:38:13.02774+00
ffd1f44a-f97b-4aa6-a988-45a23148233c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 18:06:32.04772+00	2023-04-14 18:06:32.04772+00
2c0139df-5505-4c13-97b9-a07f674888e4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-14 18:09:12.309767+00	2023-04-14 18:09:12.309767+00
d73c98d3-f9d4-427f-8cdb-256417c6f9e2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:26:05.1675+00	2023-04-17 05:26:05.1675+00
b03f274e-acab-4ed7-aff9-0117ad437ec3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:26:48.405364+00	2023-04-17 05:26:48.405364+00
4e9ecf3c-a46b-4c6f-81ea-8142a15fa4f1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:27:27.341619+00	2023-04-17 05:27:27.341619+00
d843772d-8a06-4be9-8157-153b41ec42cd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:27:54.867854+00	2023-04-17 05:27:54.867854+00
71229365-9f4a-4255-abc7-7a467d9764a0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:29:24.49997+00	2023-04-17 05:29:24.49997+00
7dd2ebe3-2c47-4256-b77d-8ee0ed92fa19	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:43:01.028149+00	2023-04-17 05:43:01.028149+00
87486e0b-808f-4b4b-8739-afc2273d729b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 05:44:36.232421+00	2023-04-17 05:44:36.232421+00
82f89e7e-9854-4cbd-b367-1f74e2dd5f94	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 09:54:18.445545+00	2023-04-17 09:54:18.445545+00
d0b91d63-86b3-48b8-afd3-2f32cd8f7711	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 09:54:21.38541+00	2023-04-17 09:54:21.38541+00
03122294-3c2d-4e88-97ec-6b34d13f8190	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 09:55:06.29189+00	2023-04-17 09:55:06.29189+00
5ad85fbb-afc3-4359-9acc-812ebeb27b07	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 09:57:46.989628+00	2023-04-17 09:57:46.989628+00
a499cb09-5839-49f7-ae44-4d53b4d462cf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:00:35.636553+00	2023-04-17 10:00:35.636553+00
d597739f-9370-4141-ad0a-718d8c0ac48b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:00:44.117607+00	2023-04-17 10:00:44.117607+00
d5aca82e-18bf-4750-9a88-6dd5601483bf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:01:25.143863+00	2023-04-17 10:01:25.143863+00
3c248744-6db8-4009-80c4-08a3dfcfe0da	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:03:04.371125+00	2023-04-17 10:03:04.371125+00
92b4ac88-7b2f-4789-aa63-47e6ad718f59	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:04:28.022037+00	2023-04-17 10:04:28.022037+00
950b80ac-fa9e-4c16-9256-29bf6c63360d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:06:05.271768+00	2023-04-17 10:06:05.271768+00
21cbb2b1-8b22-4866-8f5f-fafa2c892ac9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:06:26.180723+00	2023-04-17 10:06:26.180723+00
59f4b55a-2098-4310-8c0c-98b787267ecb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 10:07:15.241084+00	2023-04-17 10:07:15.241084+00
e6ba9441-f30e-4fdf-a288-aff2aa3746b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:13:13.881758+00	2023-04-17 11:13:13.881758+00
4fff90a6-aa84-47e3-9aad-7a39f03241a9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:13:16.730012+00	2023-04-17 11:13:16.730012+00
e9d29991-ddfd-4e4c-bd5b-e448787c6c59	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:18:07.403226+00	2023-04-17 11:18:07.403226+00
a8afc584-50d7-4c02-8558-6adf6ea87304	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:18:23.799451+00	2023-04-17 11:18:23.799451+00
7a14c916-cecf-4e70-91c8-4f39faac9bd7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:19:39.981716+00	2023-04-17 11:19:39.981716+00
593967ab-2c0e-4722-9beb-6234e8a751c3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:21:10.700158+00	2023-04-17 11:21:10.700158+00
ec0dd634-a45e-46d5-a77f-923281568d30	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:22:06.576153+00	2023-04-17 11:22:06.576153+00
7adb69c8-7e31-462c-aa3f-b4f652d8bd64	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:26:46.809071+00	2023-04-17 11:26:46.809071+00
8b7497c3-7cd4-4037-a649-d740f2df5746	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:34:12.520131+00	2023-04-17 11:34:12.520131+00
55920b11-5bc6-4809-bd0f-bcf8ac145fd0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:34:54.197637+00	2023-04-17 11:34:54.197637+00
debb98fc-db9e-41f0-9edf-60b116fedb59	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:34:58.014698+00	2023-04-17 11:34:58.014698+00
7e0a334f-f07b-4842-92ff-cac618acadea	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:35:13.663902+00	2023-04-17 11:35:13.663902+00
3301ad03-4c7a-4418-a28f-89fe9230d473	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:36:22.812732+00	2023-04-17 11:36:22.812732+00
b8128b64-e1fb-48f0-90b6-9abc993f4eea	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:37:08.349903+00	2023-04-17 11:37:08.349903+00
7de700b5-842e-41f2-af9b-66cef2635f22	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:37:23.474811+00	2023-04-17 11:37:23.474811+00
2d20e41b-b954-4e1b-a6bb-b51838bd667b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:41:18.852331+00	2023-04-17 11:41:18.852331+00
1f56e920-ccb3-4c41-b3e7-102424534d38	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:45:12.707021+00	2023-04-17 11:45:12.707021+00
d5a7e81b-13e7-4317-96fc-0ba00af4ffc0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:45:38.802494+00	2023-04-17 11:45:38.802494+00
d5d372cc-2a3a-4b6e-9b98-bb46676c08c5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:48:16.768246+00	2023-04-17 11:48:16.768246+00
5f10d11d-4d12-420b-b91e-2c3ac22de35c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:50:45.794009+00	2023-04-17 11:50:45.794009+00
d353d978-2e77-4835-9061-f79789791e73	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:51:38.077011+00	2023-04-17 11:51:38.077011+00
db42fa72-ff4c-4f9d-b90a-06c57ff6f621	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:53:56.206366+00	2023-04-17 11:53:56.206366+00
435ad47c-6def-4b7a-9fa3-5db07433d2dd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:54:35.127224+00	2023-04-17 11:54:35.127224+00
6cb15f75-c3fb-4e69-b0d1-3f9a4c7fcc36	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 11:55:19.109911+00	2023-04-17 11:55:19.109911+00
6d80da46-fafa-434b-85b0-f2e0fef46cb0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:07:01.291962+00	2023-04-17 12:07:01.291962+00
e987d8aa-d313-4387-a7ed-7a6a120f0158	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:07:13.517613+00	2023-04-17 12:07:13.517613+00
709fc937-71af-4f8a-9ed6-9094ed459fe3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:09:28.557146+00	2023-04-17 12:09:28.557146+00
1587e709-e8b9-436f-8808-78a396229938	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:13:58.681921+00	2023-04-17 12:13:58.681921+00
481f29bb-152d-4599-b6d0-ebc4466e0601	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:19:31.218963+00	2023-04-17 12:19:31.218963+00
6b14f1d3-2c39-4974-a70c-d76b14ebd3ca	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:25:06.300404+00	2023-04-17 12:25:06.300404+00
13e6cf56-85e1-41ca-84a1-4dec2097ff50	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:27:38.837308+00	2023-04-17 12:27:38.837308+00
96dfd309-99d5-4c0e-959d-e9645f11e0c9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:31:53.930265+00	2023-04-17 12:31:53.930265+00
d203f26f-72fa-4b0a-90fc-4a70062a7f66	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:36:14.993429+00	2023-04-17 12:36:14.993429+00
175fb702-de66-427b-8612-0753a60776ec	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:38:29.640192+00	2023-04-17 12:38:29.640192+00
33a382ef-1baa-49f2-9082-bc591bc58688	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:44:09.402053+00	2023-04-17 12:44:09.402053+00
8196c5b3-d896-459f-876f-3f1b86826d77	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:44:41.514654+00	2023-04-17 12:44:41.514654+00
01b74ab5-de65-4d00-90ef-905ebe194a71	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:45:32.792358+00	2023-04-17 12:45:32.792358+00
dbc17a37-6988-4468-8f4a-24283bbe6985	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:45:40.065556+00	2023-04-17 12:45:40.065556+00
3d479b82-d7bc-4f2e-ab89-c6566243fe6f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:48:30.151204+00	2023-04-17 12:48:30.151204+00
9b9592ff-9559-4234-85a3-6b1d59904070	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:00:18.248808+00	2023-04-17 13:00:18.248808+00
3b07889f-0b75-4551-b2e7-f8d1b29dc102	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:00:40.874188+00	2023-04-17 13:00:40.874188+00
f40e69ce-a799-475d-95e5-1d3a71a79dcb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:00:56.313153+00	2023-04-17 13:00:56.313153+00
ece26e63-9d16-49e2-96f2-35600089cd99	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:12:15.610421+00	2023-04-17 13:12:15.610421+00
d7570473-8020-4f35-8530-6340453a265a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:15:12.727961+00	2023-04-17 13:15:12.727961+00
adb491a5-fb76-43d9-b442-ea98f0bb37a6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:20:57.101335+00	2023-04-17 13:20:57.101335+00
9362fef5-1e1c-4957-834d-058e338da92a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:40:11.279317+00	2023-04-17 12:40:11.279317+00
95be2fc6-ab2f-4e7a-8720-f28a7070d4cf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:44:22.297884+00	2023-04-17 12:44:22.297884+00
04acfa06-7661-4538-a419-66fc8212a4e0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:45:01.253074+00	2023-04-17 12:45:01.253074+00
1e676a56-c1c5-4765-97a4-2938febe91c6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 12:57:04.065094+00	2023-04-17 12:57:04.065094+00
eff0fe1d-3837-4d3b-b8ea-a33ca82659ab	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:05:36.488128+00	2023-04-17 13:05:36.488128+00
adf6e6ec-75e7-4aa9-987a-3682f1c51644	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:06:39.339389+00	2023-04-17 13:06:39.339389+00
7312c35f-f760-472c-8a8c-eb5905828087	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:07:52.532113+00	2023-04-17 13:07:52.532113+00
05e31378-0e8e-4322-aa21-d7855ef5832e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:08:07.280805+00	2023-04-17 13:08:07.280805+00
eb47c805-e3c9-4bf0-a77a-ebb247674d15	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:08:38.862678+00	2023-04-17 13:08:38.862678+00
4670c9d9-7e42-436b-8b3d-f4fc1ddee630	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:12:03.176069+00	2023-04-17 13:12:03.176069+00
50ce7523-f333-4024-a190-e876e80ba9fb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:21:23.056394+00	2023-04-17 13:21:23.056394+00
c6dd74d2-dd71-4f5f-8dce-ffba928bbc92	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:21:58.565971+00	2023-04-17 13:21:58.565971+00
b5e3b538-b7d3-45f1-8370-a7cc48bd9db1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:23:49.039408+00	2023-04-17 13:23:49.039408+00
170232f6-e11e-499e-be75-83a9da48b213	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:33:08.885727+00	2023-04-17 13:33:08.885727+00
6247fad1-714d-4f6a-ac7d-1860e864590a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 13:56:09.862931+00	2023-04-17 13:56:09.862931+00
27a09062-1617-4bba-8dda-cc43cedab06b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:00:29.722989+00	2023-04-17 14:00:29.722989+00
3871e1e6-a512-4f9e-9dca-e6fd1268eb73	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:04:36.794813+00	2023-04-17 14:04:36.794813+00
bf0cc237-183c-4a51-9de2-7ec5b221056c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:05:24.556108+00	2023-04-17 14:05:24.556108+00
2ed69df6-ca7f-4b7b-ab74-f54adbcfad20	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:07:12.780427+00	2023-04-17 14:07:12.780427+00
c7a83fe1-67a0-4dd3-a94d-b50d333575f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:08:55.480583+00	2023-04-17 14:08:55.480583+00
26fe9014-59e9-405c-b2b9-3dc233768ebc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:12:37.177915+00	2023-04-17 14:12:37.177915+00
03f889a2-bbf6-4035-87f8-2bdc2366332c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:43:39.240594+00	2023-04-17 14:43:39.240594+00
df860b04-2311-400a-9028-85d567a9d73c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:46:30.951775+00	2023-04-17 14:46:30.951775+00
b73fc456-0761-4f13-8ffc-37b9691ce294	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:47:50.250038+00	2023-04-17 14:47:50.250038+00
2f219b00-55ac-47ad-9aa4-105ab1ae19f2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:49:45.704266+00	2023-04-17 14:49:45.704266+00
6a835a20-9362-4139-80d0-bb789a0af0e7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:50:02.212597+00	2023-04-17 14:50:02.212597+00
6834e9ab-5e58-4c2f-a66f-cf6465349a32	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:51:19.964486+00	2023-04-17 14:51:19.964486+00
46901970-1738-4ca1-a168-31fe7fde5c31	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:52:03.114732+00	2023-04-17 14:52:03.114732+00
ff5944ff-99b7-4ec8-9097-7491f558753e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 14:56:30.934175+00	2023-04-17 14:56:30.934175+00
b418acf0-a170-4060-a5fc-29f75d1a507d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:03:42.035165+00	2023-04-17 18:03:42.035165+00
99e225da-27c6-4e9e-a1cb-97e4e800ea3c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:03:51.211148+00	2023-04-17 18:03:51.211148+00
2d0b7045-d95b-4521-ae66-9a3adea221c6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:07:23.945737+00	2023-04-17 18:07:23.945737+00
ffe871b1-44ed-4827-8c0e-0da600e5f2a2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:15:31.614981+00	2023-04-17 18:15:31.614981+00
0776f344-c60f-4c2c-848a-9101d4d12177	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:18:29.291059+00	2023-04-17 18:18:29.291059+00
9a375c96-4e12-4807-a58f-3e4d219cdbad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:19:27.729747+00	2023-04-17 18:19:27.729747+00
8887a795-f29d-4791-8188-a1ddaa390ee1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:20:27.872411+00	2023-04-17 18:20:27.872411+00
e09c5c84-552e-4666-953e-a6d91172de1d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:34:33.283046+00	2023-04-17 18:34:33.283046+00
8e77d772-9a1f-4aed-92d1-109c813a2e7b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 18:35:12.475305+00	2023-04-17 18:35:12.475305+00
c5596df6-676d-4eb4-8dd8-de7668e8daf8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 19:16:23.87492+00	2023-04-17 19:16:23.87492+00
95f9e331-19e9-4415-88d8-d54c32bec54e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 19:20:32.807549+00	2023-04-17 19:20:32.807549+00
57d823d0-cd2a-4f27-8cb1-173e40a3366d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 19:32:57.798833+00	2023-04-17 19:32:57.798833+00
b8ba5fee-ce36-4e11-91b7-92c0ad4b07b9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 20:00:01.836947+00	2023-04-17 20:00:01.836947+00
1273e277-46d7-42d2-bbe6-7642e00234e2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 20:03:31.64422+00	2023-04-17 20:03:31.64422+00
b53d585b-d6b8-4ab3-8783-7d1fe0d82a01	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 20:11:53.924198+00	2023-04-17 20:11:53.924198+00
8bcca922-c1f8-4182-a121-a2dec2593557	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 20:13:50.705285+00	2023-04-17 20:13:50.705285+00
00ae783c-3a07-474d-bdb6-8f1879eea61f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 20:44:04.653745+00	2023-04-17 20:44:04.653745+00
53afb337-8734-4bc7-a815-2ea49c65163a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-17 21:04:24.788343+00	2023-04-17 21:04:24.788343+00
cf373113-e7cb-4468-b2d2-af6ab78cf96b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 08:34:35.029018+00	2023-04-19 08:34:35.029018+00
b64e77fe-5315-4de4-9808-9b52c62f1067	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 08:35:31.303851+00	2023-04-19 08:35:31.303851+00
4a7f5345-0fed-4e0a-8c0b-4c4b0972f37e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 09:40:47.9515+00	2023-04-19 09:40:47.9515+00
437be1e5-5503-424e-9ff7-1489cd521e12	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 09:40:52.228898+00	2023-04-19 09:40:52.228898+00
e1fca1c0-7707-4168-b667-5d519a207847	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 09:51:57.349399+00	2023-04-19 09:51:57.349399+00
ba18c25a-8b34-42a3-a8eb-8aa0c66697cc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 09:52:20.901406+00	2023-04-19 09:52:20.901406+00
2bdd778a-4ca5-4b04-b539-d71fe4ca7580	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 11:52:22.05064+00	2023-04-19 11:52:22.05064+00
fa8ba409-7d56-4768-9f52-2e4b1034bfc3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 11:52:25.789874+00	2023-04-19 11:52:25.789874+00
e91d20cf-ecc3-44ce-8b42-bde3218d27d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 12:20:57.388473+00	2023-04-19 12:20:57.388473+00
5fc51022-1ed7-4847-bba6-0f32a3a7cb1a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 12:21:02.609701+00	2023-04-19 12:21:02.609701+00
053b1b63-1bf8-44a4-8dd3-c7e9f548294a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 12:39:15.011762+00	2023-04-19 12:39:15.011762+00
ea00f9cf-7cbc-407b-81dc-981fb8e53c03	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 12:44:42.431324+00	2023-04-19 12:44:42.431324+00
0a5e02f0-93c9-49c4-a0a3-b270ce733915	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 18:54:28.452573+00	2023-04-19 18:54:28.452573+00
87f2e6be-9991-4efe-89b5-4832ae4c4ed6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 18:59:22.801821+00	2023-04-19 18:59:22.801821+00
dd3108f7-50ab-425c-af65-096c0e1f285d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:00:56.16235+00	2023-04-19 19:00:56.16235+00
33749a75-0895-4b1a-b1fd-ab03a42b1842	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:01:36.242511+00	2023-04-19 19:01:36.242511+00
6577d330-35be-40f9-8f74-f69baa4d046a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:03:27.79033+00	2023-04-19 19:03:27.79033+00
c357e63f-01b4-4dda-a7cb-df0fa0f51896	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:04:06.201392+00	2023-04-19 19:04:06.201392+00
a4c32e3f-9071-42a0-9945-fee0e3b56448	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:05:06.379167+00	2023-04-19 19:05:06.379167+00
c6524543-650a-495e-85e5-63ceba50a3bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:06:11.450999+00	2023-04-19 19:06:11.450999+00
bd0e6a91-2595-4561-9f7f-4cbf427c15e9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:07:17.3299+00	2023-04-19 19:07:17.3299+00
4f1c2677-157e-451a-864d-c1df30fa35b8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:09:15.382887+00	2023-04-19 19:09:15.382887+00
83440fa6-f097-4a75-8aad-b4d8f1e17d1f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:29:49.378887+00	2023-04-19 19:29:49.378887+00
9d203cce-ff5e-4896-8b0d-d39cdf242693	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:39:39.9554+00	2023-04-19 19:39:39.9554+00
252396f7-136e-4683-a17a-8a5dea18557d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:40:49.168866+00	2023-04-19 19:40:49.168866+00
f18310b2-4e0e-4bfe-a44d-f5d3e6948401	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:42:32.469754+00	2023-04-19 19:42:32.469754+00
ae8859a1-7a8f-4b92-a98f-7c13ecfb4d53	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:43:20.402747+00	2023-04-19 19:43:20.402747+00
a0e3de30-bea8-4299-8fe4-6731319bfc52	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:47:51.939262+00	2023-04-19 19:47:51.939262+00
3634bc79-976a-440a-bbc1-dfbf1e73dbf5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:49:38.163808+00	2023-04-19 19:49:38.163808+00
25ec421c-485b-4144-81a6-88a8731384d1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:53:11.207068+00	2023-04-19 19:53:11.207068+00
9eb7ce9a-bc27-4dc6-8298-50397d73a31e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:54:02.114851+00	2023-04-19 19:54:02.114851+00
bbfb01a9-5f2e-4e57-92b4-3969fbdef94a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 19:54:03.882168+00	2023-04-19 19:54:03.882168+00
bf186f29-da84-43b0-a122-c292454fe2e9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:11:02.896039+00	2023-04-19 20:11:02.896039+00
dfe2f5c8-b429-4519-a0bf-0779006504da	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:11:26.470345+00	2023-04-19 20:11:26.470345+00
3e04ad04-4283-413f-a478-a11edfc3a084	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:19:04.196092+00	2023-04-19 20:19:04.196092+00
a6898203-4beb-4eb0-8b5e-f5fdcd136ffe	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:19:45.992316+00	2023-04-19 20:19:45.992316+00
7354b15e-d474-45f3-881f-226addbeb7cc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:23:57.562651+00	2023-04-19 20:23:57.562651+00
273437a4-f69f-4271-9979-9ddceb4403e9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:27:48.4812+00	2023-04-19 20:27:48.4812+00
c58be97a-751b-4ef4-940e-0f4730c06ddf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:27:48.871824+00	2023-04-19 20:27:48.871824+00
43eab1d4-35d2-446e-90a9-150b9a50b8a9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:28:02.352067+00	2023-04-19 20:28:02.352067+00
9e4d66e9-2a94-4b0f-bb8d-7858b690ec2a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:33:02.337346+00	2023-04-19 20:33:02.337346+00
37b13598-c989-405e-8785-22201d5e316e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-19 20:36:14.132228+00	2023-04-19 20:36:14.132228+00
76d4cc32-49ce-45f0-b22a-09c6706cdfa4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 19:56:34.524582+00	2023-04-25 19:56:34.524582+00
d1822059-3138-49ae-99d7-6c1be0597edf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:03:30.312135+00	2023-04-25 20:03:30.312135+00
d485baf9-fe3f-417c-8dc0-6534c5c4f34b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:04:02.705887+00	2023-04-25 20:04:02.705887+00
80fa1cba-ddf8-459b-9a31-2f54f5340b64	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:04:40.575272+00	2023-04-25 20:04:40.575272+00
1ee74a7f-cf1f-4f99-98ee-442e6589c854	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:08:46.619054+00	2023-04-25 20:08:46.619054+00
b6ba005e-97ab-4b21-a4b9-98ed207200bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:09:56.729606+00	2023-04-25 20:09:56.729606+00
05a44c11-14b0-4130-afb2-41a1bbe0e083	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:11:27.633826+00	2023-04-25 20:11:27.633826+00
2615e51f-7f5f-48bb-9f23-dc19c6847ff3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:12:12.118401+00	2023-04-25 20:12:12.118401+00
639d7487-ca54-4f1e-b249-9d98f65f8b1a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:14:55.402752+00	2023-04-25 20:14:55.402752+00
9a3f8949-4daa-4059-8126-4ba9dacda489	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:19:03.468457+00	2023-04-25 20:19:03.468457+00
ea6a2c6e-673d-4811-8f4f-3861ae5113d9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:20:19.047187+00	2023-04-25 20:20:19.047187+00
a32d5671-cd0c-408e-9d90-45abd41a2b99	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:21:04.486595+00	2023-04-25 20:21:04.486595+00
fa81ce4c-c4d4-4ca4-bc95-925f06478efb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:22:01.903998+00	2023-04-25 20:22:01.903998+00
9ed0456e-2aca-41f8-8bc5-68daa0018dd4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:22:56.493375+00	2023-04-25 20:22:56.493375+00
ed5375ab-1909-42ec-99b0-920d3603c803	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:26:03.737733+00	2023-04-25 20:26:03.737733+00
15186134-025c-4e68-bec3-80124c04979f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:28:49.038535+00	2023-04-25 20:28:49.038535+00
a0ac2ca1-96f5-43f6-a7dc-a557dd0cfea7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:29:04.17786+00	2023-04-25 20:29:04.17786+00
56c11c58-c83a-4205-8be5-6f1e54528ba2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:31:00.825781+00	2023-04-25 20:31:00.825781+00
8b84f75d-0151-4527-907c-e0bd5f0f25af	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:38:18.981564+00	2023-04-25 20:38:18.981564+00
d28e095d-1879-4596-a41d-f63c0480654d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 20:42:00.084451+00	2023-04-25 20:42:00.084451+00
14ddfc05-6430-4451-a388-8a85df16e11d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:08:46.611764+00	2023-04-25 21:08:46.611764+00
9f4bd4e6-1755-457f-b958-0a0903ca5231	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:12:56.798817+00	2023-04-25 21:12:56.798817+00
34f8724c-4d74-434b-b0c8-db89499178a2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:13:19.38042+00	2023-04-25 21:13:19.38042+00
032a995e-716d-443a-80fb-e38afc73b9cb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:13:50.864437+00	2023-04-25 21:13:50.864437+00
3e0c61ac-dc7a-4d9c-ab1a-6dfad6c8cf78	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:16:20.193765+00	2023-04-25 21:16:20.193765+00
10e9d630-dacb-4622-a743-46071d944815	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:29:15.171389+00	2023-04-25 21:29:15.171389+00
adc0a20f-0465-4094-9f5d-a13336b7b229	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:37:42.994917+00	2023-04-25 21:37:42.994917+00
81eddf38-dd15-401d-a9a3-39e4324e8e6a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:39:08.480981+00	2023-04-25 21:39:08.480981+00
8d900695-fc6e-4af4-8c41-d03bd57db904	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:41:09.428941+00	2023-04-25 21:41:09.428941+00
07d329b7-061d-4c08-b342-4b55ca01cdb2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:42:53.61475+00	2023-04-25 21:42:53.61475+00
6538c807-7275-4377-936f-9fc9e6248a19	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:51:36.962126+00	2023-04-25 21:51:36.962126+00
c4fec9c0-e49b-41aa-a27f-b6cc06b412e5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:55:58.686289+00	2023-04-25 21:55:58.686289+00
61dba88b-b4e4-4d19-be34-7e96aaa8588e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 21:58:19.052375+00	2023-04-25 21:58:19.052375+00
98366df2-4c41-4d07-9071-6ff86c5748f1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:00:29.955281+00	2023-04-25 22:00:29.955281+00
47264e3b-ea13-4a05-ac40-97a60dc0dc6c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:04:51.083132+00	2023-04-25 22:04:51.083132+00
8d069c1a-9ab1-4602-9336-fc21b867e153	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:05:20.849639+00	2023-04-25 22:05:20.849639+00
40a32944-2deb-44f5-b5ec-dd73e90ac453	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:12:35.106645+00	2023-04-25 22:12:35.106645+00
0ff90045-1afd-4764-af72-806e582d641d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:14:34.48158+00	2023-04-25 22:14:34.48158+00
0b7a95cb-e690-4b86-ae5d-55e3fb1d9265	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:16:10.114646+00	2023-04-25 22:16:10.114646+00
b36f5baa-853d-4fee-b281-f3851ff3c964	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:36:31.630777+00	2023-04-25 22:36:31.630777+00
88d60052-ae6c-480b-acd1-4cf47f6db5a8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:40:11.423553+00	2023-04-25 22:40:11.423553+00
76a2db07-0181-40a8-81ec-dc7e85d43599	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:42:38.234097+00	2023-04-25 22:42:38.234097+00
07b2aae0-dc72-4944-aa92-236e7f57d191	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:46:17.26009+00	2023-04-25 22:46:17.26009+00
a2aee979-1ef8-415f-ae69-09c1c9faea91	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:46:29.442643+00	2023-04-25 22:46:29.442643+00
481add70-05a3-4156-acbb-c170ead99901	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:47:53.219163+00	2023-04-25 22:47:53.219163+00
d1ef99f1-f7dd-4747-8fc1-931e4a3e8910	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:47:59.335851+00	2023-04-25 22:47:59.335851+00
5a57e0bf-0aa0-4e90-88e8-488168c2227f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:48:57.593368+00	2023-04-25 22:48:57.593368+00
78256f8d-1636-411e-b77c-49eef91372d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:49:05.284767+00	2023-04-25 22:49:05.284767+00
77180afc-75ae-4a56-9297-56c0387dd1bc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:50:06.525339+00	2023-04-25 22:50:06.525339+00
3119081e-187f-4a53-b83f-ea821b41e7ce	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:50:11.344165+00	2023-04-25 22:50:11.344165+00
264cb519-55f3-4f73-9071-89f15fd5fa00	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:53:27.324743+00	2023-04-25 22:53:27.324743+00
a571be30-fe7d-49e8-813c-dad18350ca42	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:55:59.427095+00	2023-04-25 22:55:59.427095+00
59d2a9b8-6a65-44d1-a3c0-f1dead81f940	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:56:09.156204+00	2023-04-25 22:56:09.156204+00
185a85f2-5695-47af-9121-e2ed89ca0e17	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 22:56:32.084637+00	2023-04-25 22:56:32.084637+00
55b8b369-2149-4b71-9b04-98076b365699	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:11:29.89636+00	2023-04-25 23:11:29.89636+00
9cd0cd1f-ec0f-4da7-bc53-60f59ed3dec3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:12:03.497941+00	2023-04-25 23:12:03.497941+00
58071c30-69db-4eff-9610-5e783add837e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:13:43.051381+00	2023-04-25 23:13:43.051381+00
0c3783b7-8d3d-4498-aaf3-44984405864f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:13:43.335741+00	2023-04-25 23:13:43.335741+00
b5cedbdc-9b16-4eb2-aaae-375e655ebbae	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:14:39.743897+00	2023-04-25 23:14:39.743897+00
fa2c1cdc-0f83-4759-8c5c-b995b34c556f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:15:58.027577+00	2023-04-25 23:15:58.027577+00
8e7af98b-8708-47b6-bcd5-ad3438a1c522	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:17:16.019195+00	2023-04-25 23:17:16.019195+00
fd4a2c24-576e-4ebd-8011-33070dbc68ad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:17:16.297157+00	2023-04-25 23:17:16.297157+00
1bfb2881-4ef1-4b3f-98a4-29b820e2c882	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:30:50.542504+00	2023-04-25 23:30:50.542504+00
116eb9c9-1a4c-4acd-b872-42bf920a256d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-25 23:33:22.558831+00	2023-04-25 23:33:22.558831+00
ac67ed9f-a576-4b3e-9a25-ca135772fd57	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-26 14:31:39.459229+00	2023-04-26 14:31:39.459229+00
e2e69d90-165c-4eb2-986c-c841cdf1a8c1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-26 14:33:10.301319+00	2023-04-26 14:33:10.301319+00
dff54306-e27d-448f-807d-1bae1d71eb1c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 02:36:21.924574+00	2023-04-27 02:36:21.924574+00
0c62bd14-532d-4eec-abc5-57ac02209bf6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 02:37:33.816107+00	2023-04-27 02:37:33.816107+00
673198ee-4e93-4d81-82c1-5b78fb4a6cb8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 02:53:58.894039+00	2023-04-27 02:53:58.894039+00
0132ab3f-64f5-4f03-94b3-60d0ca3c5d8e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:15:27.277805+00	2023-04-27 03:15:27.277805+00
75392269-932e-4d93-a08a-0262ce2a7710	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:15:30.570546+00	2023-04-27 03:15:30.570546+00
de4d15fe-ce0b-4fec-81a9-7cc2d7a058f9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:17:52.283546+00	2023-04-27 03:17:52.283546+00
4ef9a118-01cf-45d9-96d8-c2f38c929306	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:18:27.475312+00	2023-04-27 03:18:27.475312+00
f91b4a92-dc82-4ad8-bfc5-6dc1303d2048	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:18:32.839043+00	2023-04-27 03:18:32.839043+00
23eac806-b990-436d-a272-4499e85a91ef	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:18:41.155839+00	2023-04-27 03:18:41.155839+00
db393250-baae-4331-85a5-dd25cd67f854	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:20:59.775615+00	2023-04-27 03:20:59.775615+00
7a7fa57f-0c35-4597-a26f-e8dd980e2687	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:25:50.173854+00	2023-04-27 03:25:50.173854+00
51750cb0-6f80-406d-9ea0-8168f00b7b99	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:28:38.710249+00	2023-04-27 03:28:38.710249+00
13187c8e-c849-4ea1-99d6-58d8eab897dc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:29:12.002606+00	2023-04-27 03:29:12.002606+00
0cd7e538-24f9-45b2-bf47-bd8ccd822a61	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:32:06.386547+00	2023-04-27 03:32:06.386547+00
0b8b3eaa-7dbf-4461-b2d1-30f2a1a1bf23	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:41:55.598402+00	2023-04-27 03:41:55.598402+00
1863a51a-bede-40b7-aba0-5594188c9a46	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:46:55.546072+00	2023-04-27 03:46:55.546072+00
667856be-a6b7-45e2-a0c2-a52637cbcff9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:49:55.257434+00	2023-04-27 03:49:55.257434+00
96461bec-c67b-44e9-8a84-2d88575429bb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:50:53.170592+00	2023-04-27 03:50:53.170592+00
fb0cab26-2865-4b2d-ab4c-cbfc32b72ba4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:55:28.077491+00	2023-04-27 03:55:28.077491+00
bd5f3b97-5b5d-409a-b4ad-23e5df4e2290	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:04:21.88042+00	2023-04-27 04:04:21.88042+00
da99f078-d260-45f0-a5dd-ad98dc2ab559	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:09:04.087689+00	2023-04-27 04:09:04.087689+00
d9b85e3e-53a7-4640-987e-6540bdf002e2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:09:04.922026+00	2023-04-27 04:09:04.922026+00
37e17495-4cb0-4777-9645-3b52c039e5e6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:10:42.040912+00	2023-04-27 04:10:42.040912+00
3c8e9d7b-9d0f-4c7b-a84e-43d35749d08c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:10:42.91047+00	2023-04-27 04:10:42.91047+00
c1da4804-bd52-453f-93ae-dd337d262ea8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:19:57.669844+00	2023-04-27 04:19:57.669844+00
a700c9ab-2189-4225-84b2-bd47283ad259	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:20:26.4913+00	2023-04-27 04:20:26.4913+00
84ec1d00-5e0f-405e-b472-6cca4f98eb54	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:23.560431+00	2023-04-27 04:29:23.560431+00
d1b2c61e-1986-491a-8946-0fec48783c3d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:24.659575+00	2023-04-27 04:29:24.659575+00
cae41931-d33e-4a69-96e1-636e8df87acc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:24.846037+00	2023-04-27 04:29:24.846037+00
d8741dfe-ed0b-464c-b057-d8830c9124c2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.433352+00	2023-04-27 04:29:25.433352+00
f195c688-80f6-4181-bef0-edc4a6b97890	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.571446+00	2023-04-27 04:29:25.571446+00
2f3d5a12-499e-4651-8797-05b1d867a68f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:33:11.915876+00	2023-04-27 04:33:11.915876+00
1b79041c-1450-4a8a-8f09-a0b465387c45	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:33:12.687111+00	2023-04-27 04:33:12.687111+00
944e5af7-9180-4a4b-8056-38ea85fc74a2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:45:11.587931+00	2023-04-27 04:45:11.587931+00
68cc22ca-c0ef-47a2-bd91-20300f08abda	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:46:33.686408+00	2023-04-27 04:46:33.686408+00
3c9b48ca-8778-43e3-a4fc-2c349c582b11	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:51:33.58992+00	2023-04-27 03:51:33.58992+00
f299a4af-ede6-43d9-a77e-1a45bd6a23ab	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:53:37.220089+00	2023-04-27 03:53:37.220089+00
8ad24ef8-0b26-4f96-8b6f-c7643a8e8511	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:55:03.758998+00	2023-04-27 03:55:03.758998+00
93c8ecee-e356-4857-a24e-eb4a21742b5a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 03:55:31.18612+00	2023-04-27 03:55:31.18612+00
e3c26cdb-3864-4191-871e-f0ea869066fd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:02:01.622112+00	2023-04-27 04:02:01.622112+00
abc16c8a-8dde-463e-9907-450d5d5ab3ef	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:04:20.974533+00	2023-04-27 04:04:20.974533+00
8c263586-6535-4683-94dd-2622be256e94	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:04:34.753439+00	2023-04-27 04:04:34.753439+00
21b49a55-461d-4cf9-92ad-67d5fd35f5da	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:04:56.439553+00	2023-04-27 04:04:56.439553+00
0b8077a0-6282-4b8d-b9b2-ab6248155b7a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:11:00.074994+00	2023-04-27 04:11:00.074994+00
87d16351-dd74-42fc-83ed-53c107bb66e4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:11:48.172168+00	2023-04-27 04:11:48.172168+00
fd8dadc3-b92e-4804-8960-c0c3b12560a1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:18:07.265851+00	2023-04-27 04:18:07.265851+00
64ffb77e-c8c6-4301-8de2-c1443bac1579	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:18:08.111982+00	2023-04-27 04:18:08.111982+00
9b69fbdb-2f97-486a-82a9-c3e4c7858229	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:18:27.216237+00	2023-04-27 04:18:27.216237+00
1da8ca69-8ad9-4cd6-813c-b45d297528ef	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:18:30.254325+00	2023-04-27 04:18:30.254325+00
4f00e78a-a90e-400d-a770-93fe1aced031	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:19:02.819817+00	2023-04-27 04:19:02.819817+00
c0428c01-71c2-488c-bdcb-1a0d40680d2a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:19:03.640729+00	2023-04-27 04:19:03.640729+00
be5f2873-6276-4f29-8862-6c080226df38	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:24.996692+00	2023-04-27 04:29:24.996692+00
ada0cfd4-beb1-4470-be0c-e2b3f7605a3c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.150819+00	2023-04-27 04:29:25.150819+00
1cf4c250-629a-4c97-818c-f7de33d8527d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.28072+00	2023-04-27 04:29:25.28072+00
3e0d3397-7b82-4856-80cb-fe1c918ca3da	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.718806+00	2023-04-27 04:29:25.718806+00
23598a75-333b-4f25-bac8-7c9a9335e434	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:29:25.832842+00	2023-04-27 04:29:25.832842+00
f7a53b2d-db8a-414d-9053-0a079f46aaa0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:32:36.548785+00	2023-04-27 04:32:36.548785+00
d53632b7-1bf6-4faa-9e13-8c848c0bfabb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:32:37.367549+00	2023-04-27 04:32:37.367549+00
27be5ab7-6934-45dd-ab32-169d84b96d9a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:34:13.198531+00	2023-04-27 04:34:13.198531+00
c6e2c2ae-09b0-40b9-8c4a-23f26013cbd0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:34:13.941214+00	2023-04-27 04:34:13.941214+00
39efbbd6-409e-4d50-ba08-49d40199b871	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:43:39.644573+00	2023-04-27 04:43:39.644573+00
d76f9089-fca6-4356-a3ec-079a50bb1ba9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:44:32.269302+00	2023-04-27 04:44:32.269302+00
0688c86d-ee3c-4439-baae-e21876419b99	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:46:18.769797+00	2023-04-27 04:46:18.769797+00
8a77e09c-227d-4ed5-ac33-c758f1e7bad6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:52:28.473245+00	2023-04-27 04:52:28.473245+00
3465b804-61ab-48a7-a58b-bce5911af111	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:54:34.098485+00	2023-04-27 04:54:34.098485+00
0be15d51-be81-4326-8207-5eff08f1b050	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:56:06.658359+00	2023-04-27 04:56:06.658359+00
47ea9bf7-01bd-4fe1-b000-bbf3eb42674e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 04:58:54.422641+00	2023-04-27 04:58:54.422641+00
e0c781c4-dd79-4d2d-b640-206ec888a759	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:00:38.192638+00	2023-04-27 05:00:38.192638+00
076eec85-cdd5-49d0-b320-e46a303443a6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:03:49.51758+00	2023-04-27 05:03:49.51758+00
deada340-29c8-4bed-8677-0577dd3fa844	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:04:13.34829+00	2023-04-27 05:04:13.34829+00
b70d08f6-e60f-48d1-93aa-4b6ca607807d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:06:05.15236+00	2023-04-27 05:06:05.15236+00
a51d4a94-c02b-4caf-ab6e-f9583296a306	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:06:46.112381+00	2023-04-27 05:06:46.112381+00
ba002fcf-cb8f-408a-8af2-1d3c196c17a1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:07:04.158066+00	2023-04-27 05:07:04.158066+00
24c6bb04-306b-4e9f-8072-ce403c5b53c8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:07:05.970929+00	2023-04-27 05:07:05.970929+00
53eeeb74-74e5-41d1-9a79-0865047b3905	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:11:44.587339+00	2023-04-27 05:11:44.587339+00
a75dba03-2ec7-4615-9587-c8f93e4891a1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:12:30.295338+00	2023-04-27 05:12:30.295338+00
31f887c5-4c26-471f-a3a2-4144000d4e69	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:12:50.519789+00	2023-04-27 05:12:50.519789+00
a0d2b304-f6a5-4ce4-a68c-312a5cbe691d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:13:21.80643+00	2023-04-27 05:13:21.80643+00
82377329-f498-49c7-849a-8ed8c4353449	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:14:11.685763+00	2023-04-27 05:14:11.685763+00
d288db23-b22d-4ceb-b5d6-862c886e006b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:46:15.865052+00	2023-04-27 05:46:15.865052+00
91948965-d99c-4945-8b63-c4cc33b90264	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:46:18.614448+00	2023-04-27 05:46:18.614448+00
a8fba481-58ed-4c35-a343-dcc091c960f8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:56:43.370823+00	2023-04-27 05:56:43.370823+00
057da029-c396-491a-8f78-fca1ea3e57ac	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 05:59:30.57885+00	2023-04-27 05:59:30.57885+00
eab88cf7-bb76-4a5a-95fd-9768551970f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:08:14.124706+00	2023-04-27 06:08:14.124706+00
7fcb99c3-25ff-4574-8c8a-b233b9e8603c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:08:28.699609+00	2023-04-27 06:08:28.699609+00
73feebc8-cc1b-4aaa-8dfb-d513950b67f4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:09:04.161606+00	2023-04-27 06:09:04.161606+00
8f4102a4-13b3-4457-9696-b6033d7aa91a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:11:57.858105+00	2023-04-27 06:11:57.858105+00
b873dd2c-28aa-4603-abcd-71cf6a57a41c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:12:24.3495+00	2023-04-27 06:12:24.3495+00
ef3174cd-5209-430f-a433-de481871a33d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:18:53.460743+00	2023-04-27 06:18:53.460743+00
01f7548b-d101-40dd-b8b0-b1369bca3998	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:20:12.611897+00	2023-04-27 06:20:12.611897+00
698c895b-bf1e-4f3b-a432-23c137a2a9e5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:21:42.819422+00	2023-04-27 06:21:42.819422+00
a90207ca-e351-4fe5-b887-fb8559fbe2cb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:24:11.616089+00	2023-04-27 06:24:11.616089+00
28daaf96-7f97-4568-a4a2-adc439fe6af4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:26:06.315271+00	2023-04-27 06:26:06.315271+00
452c511a-e641-4d35-90cb-131c79f6706d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:26:19.117436+00	2023-04-27 06:26:19.117436+00
f0946bc4-536f-4789-bac1-d46a6830bca6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:33:23.965067+00	2023-04-27 06:33:23.965067+00
d33e8505-7ad5-47ce-9403-32fa86894725	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:36:52.027773+00	2023-04-27 06:36:52.027773+00
e11dbf8c-d06f-4e3b-8f92-43b3ca852736	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:36:53.970511+00	2023-04-27 06:36:53.970511+00
03a02169-a0a7-48d7-aa0d-9208205ab6de	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:37:03.012466+00	2023-04-27 06:37:03.012466+00
9787f4b7-0d04-45a7-80d4-1fb19991cc64	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:38:13.416549+00	2023-04-27 06:38:13.416549+00
c493db3d-6bf9-4196-a804-259b68e58a1d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:39:51.829911+00	2023-04-27 06:39:51.829911+00
4dd44c0b-5e65-4cb2-a0e9-c759cd206f76	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:41:27.216292+00	2023-04-27 06:41:27.216292+00
95876539-6c14-4d81-a635-ad8b54298991	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:41:51.030261+00	2023-04-27 06:41:51.030261+00
5f9883e6-8019-434f-b88e-b7295722693c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:42:45.78465+00	2023-04-27 06:42:45.78465+00
84db28cb-67aa-4989-be5b-f37089c3631d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:44:09.102303+00	2023-04-27 06:44:09.102303+00
60fc1ba0-f1bb-491e-be56-927718c3705b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:45:57.757204+00	2023-04-27 06:45:57.757204+00
cd66d87e-6d51-4abf-9a19-e3309577dbcd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:47:08.600847+00	2023-04-27 06:47:08.600847+00
9a7a6e9d-0bd0-4f02-9a43-f43dc5113d70	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:49:31.732143+00	2023-04-27 06:49:31.732143+00
8a9fcabf-3ea4-45f2-bc13-32b3528d224c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:54:35.502258+00	2023-04-27 06:54:35.502258+00
5ae6cf0b-9141-43f4-b66c-9067a26345fc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:54:54.770108+00	2023-04-27 06:54:54.770108+00
e226dd3d-5c1a-45a3-a3cf-1d2d991b2786	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:55:44.938012+00	2023-04-27 06:55:44.938012+00
3c0ae04d-e2f7-4892-b688-606e30410f7b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:37.772796+00	2023-04-27 06:56:37.772796+00
2c6235b3-9b24-4241-af1e-79b1f793ce6a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:52.163393+00	2023-04-27 06:56:52.163393+00
ff3b666f-1a31-4164-829f-9f7be9c03fbc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:52.831958+00	2023-04-27 06:56:52.831958+00
ee5eb111-daa3-417a-b46d-65bd4c8e7bad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:53.441508+00	2023-04-27 06:56:53.441508+00
9525e76e-121e-461e-bcda-72d81e05eacb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:54.044496+00	2023-04-27 06:56:54.044496+00
3fcd5e29-9151-4b39-9d30-96fcb8d4f801	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:54.656514+00	2023-04-27 06:56:54.656514+00
c26a000f-06a7-46e0-871b-d6b65ac1e5ae	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:55.282826+00	2023-04-27 06:56:55.282826+00
b5bbc5f0-6003-4d10-a8e4-b40e9fd8eb40	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:55.844741+00	2023-04-27 06:56:55.844741+00
bac777ba-fec5-4eae-b7a9-cd06335d701d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:58.741783+00	2023-04-27 06:56:58.741783+00
95360c36-8ee0-46f2-a3a3-6a8b70895668	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:04:50.123361+00	2023-04-27 07:04:50.123361+00
4b81339d-2247-41ed-ad98-c8ca8940db8a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:06:47.336875+00	2023-04-27 07:06:47.336875+00
30eabf16-15f7-4d37-9bd7-05288e458b7d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:08:39.952813+00	2023-04-27 07:08:39.952813+00
c54becc4-f9e4-4ae0-80e6-d80062d7029d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:08:42.473759+00	2023-04-27 07:08:42.473759+00
5918913c-765f-4588-af44-e12eb7afd996	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:08:43.418468+00	2023-04-27 07:08:43.418468+00
5e2e4621-7ff5-4219-90cc-7c9bc6b1cc77	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:16:31.320736+00	2023-04-27 07:16:31.320736+00
c9e6e4da-9803-43db-9686-966cee0abc63	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:20:07.705096+00	2023-04-27 07:20:07.705096+00
8efc9a76-5648-495b-a0e0-45ffba0b3ffd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:21:33.175389+00	2023-04-27 07:21:33.175389+00
fba96f58-9811-4ae7-91cb-73066ef302b6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:23:47.175644+00	2023-04-27 07:23:47.175644+00
4344c408-1a35-4dd5-9b00-1fe6471587d0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:23:48.454037+00	2023-04-27 07:23:48.454037+00
01ecdd74-0334-48da-89b9-63818bb6b2fd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:24:41.567366+00	2023-04-27 07:24:41.567366+00
4e96c8c6-67e3-4b3a-9606-4f1547b5dc7e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:32:06.452583+00	2023-04-27 07:32:06.452583+00
6f4fe87e-3c35-4538-8c44-c601a9af3bfd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:32:14.072863+00	2023-04-27 07:32:14.072863+00
3ee314ca-0cdd-4c53-882b-ff991e5774a7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:35:29.556589+00	2023-04-27 07:35:29.556589+00
7b002c5b-493a-4f2d-b1cf-524af4eb76f0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:37:02.438568+00	2023-04-27 07:37:02.438568+00
9b1b8005-fef0-4a1b-9778-cbb79f7833b7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:37:31.000917+00	2023-04-27 07:37:31.000917+00
2bf50339-8c9a-4429-b4fa-744cd5daf92b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:37:40.564717+00	2023-04-27 07:37:40.564717+00
9d0ba59c-fc45-4c08-b314-4a735fbc87b3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:37:41.356353+00	2023-04-27 07:37:41.356353+00
f9236365-577f-47c6-83f5-d9f7a050017b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:41:55.101862+00	2023-04-27 07:41:55.101862+00
5dd5479d-448c-4d6d-b38a-de3042acfaa2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:53:46.925059+00	2023-04-27 07:53:46.925059+00
93d74436-1001-4771-ac18-3a71a4179782	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:56:42.827325+00	2023-04-27 07:56:42.827325+00
6a1d2095-0f4e-46f4-b637-420455e9e6fa	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:58:43.951309+00	2023-04-27 07:58:43.951309+00
6b79c43a-4ce9-43a7-b535-11e1d1113a79	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:59:25.870844+00	2023-04-27 07:59:25.870844+00
af6c7b24-cd1c-443d-ad62-20d814b159dd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:59:26.013767+00	2023-04-27 07:59:26.013767+00
ac4f6b43-3ee6-4e2c-a591-dacf9f721fde	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:56.406384+00	2023-04-27 06:56:56.406384+00
08ce6987-92a7-4644-ab15-b30aae3a4de0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:56.997703+00	2023-04-27 06:56:56.997703+00
53c744a9-eb65-499a-a4f7-d92fce0b506c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:58.075603+00	2023-04-27 06:56:58.075603+00
abbcf466-e681-4cea-a410-4d8f3ec0ca36	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:56:59.415659+00	2023-04-27 06:56:59.415659+00
5ac127cb-bb1f-4f47-886f-e97592f07a9a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 06:59:07.255791+00	2023-04-27 06:59:07.255791+00
ab3b2498-f8ba-4f8b-813e-9f62d0029330	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:02:10.912033+00	2023-04-27 07:02:10.912033+00
1556df92-42c7-4af7-84f7-6dd9e70956c3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:09:44.868639+00	2023-04-27 07:09:44.868639+00
cc0fa78b-a743-497a-8053-ae1f68f19e72	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:12:19.918797+00	2023-04-27 07:12:19.918797+00
d2ffdf8c-8e8f-4242-a78e-2ae6a8d8c0dc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:16:36.569815+00	2023-04-27 07:16:36.569815+00
e1d311a7-bf23-4dd6-89a9-069447b9fb92	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:16:37.89241+00	2023-04-27 07:16:37.89241+00
5124531c-a0ca-441d-b86b-3024d2d6c0f8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:17:46.679068+00	2023-04-27 07:17:46.679068+00
d32349fe-1ac7-45a8-9069-d5933b934993	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:19:19.212403+00	2023-04-27 07:19:19.212403+00
9b62fe22-b23c-4065-a8d1-f83f8e9ac99e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:28:10.636141+00	2023-04-27 07:28:10.636141+00
bae657f1-a822-4446-94b3-617b6e63bba4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:39:00.13409+00	2023-04-27 07:39:00.13409+00
30372c87-6269-4a6b-ba20-c12d9ad710ea	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:39:40.44754+00	2023-04-27 07:39:40.44754+00
12fe2b8b-d196-4036-a58d-a57b9248c029	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:39:41.808532+00	2023-04-27 07:39:41.808532+00
3240069a-a15d-440a-a6bd-48c2d4e506ba	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:39:42.990355+00	2023-04-27 07:39:42.990355+00
ddaa9a25-5aaf-45c0-8b96-8b7f214ce9d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 07:41:52.704076+00	2023-04-27 07:41:52.704076+00
f9b664b0-00cb-4a6f-85b6-99ffdc5a50ee	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 08:00:27.730305+00	2023-04-27 08:00:27.730305+00
27c9a10e-4d40-4ec0-81e3-073610bbb4dd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 08:00:27.932771+00	2023-04-27 08:00:27.932771+00
997919c8-07fe-422a-9428-0eb19bf29409	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 08:18:39.502145+00	2023-04-27 08:18:39.502145+00
675590d2-8987-49ce-afca-a78d24f077c8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:01:56.58861+00	2023-04-27 10:01:56.58861+00
5a40e292-584c-4f95-8a6d-08be6ab763af	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:02:16.065067+00	2023-04-27 10:02:16.065067+00
a27aa875-dbff-4b09-aa1b-24e0f697e52b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:02:16.29293+00	2023-04-27 10:02:16.29293+00
811091eb-ba2c-4891-936b-e9767b0bd0d0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:02:53.31552+00	2023-04-27 10:02:53.31552+00
2b541765-4d67-450f-ac02-837f4f7471cb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:02:53.450781+00	2023-04-27 10:02:53.450781+00
bd4149ec-fb59-4731-8a2a-465ac25181d5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:04:06.718897+00	2023-04-27 10:04:06.718897+00
8694857d-cadc-4f71-ab33-f38d7d0d2c27	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:04:09.606452+00	2023-04-27 10:04:09.606452+00
7370dc47-070c-4dc8-9df8-64fb7f819eab	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:16:50.81038+00	2023-04-27 10:16:50.81038+00
ff809c00-5f53-4124-8591-7f7a7a411a78	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:17:27.502549+00	2023-04-27 10:17:27.502549+00
920e964b-863e-4025-a35e-783a9a520cac	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:19:16.625366+00	2023-04-27 10:19:16.625366+00
264fd3c6-41e6-4a6f-b58f-c7c36ea2e895	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:19:52.975166+00	2023-04-27 10:19:52.975166+00
f33643fa-d27b-404c-b93f-005a76c2377e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:20:33.205219+00	2023-04-27 10:20:33.205219+00
ce85081d-1900-45ed-9e44-47a116e7b100	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:21:06.051625+00	2023-04-27 10:21:06.051625+00
c57314b8-00de-4df4-9013-57e40b79a5fb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:21:06.603315+00	2023-04-27 10:21:06.603315+00
8e58bf9f-fcad-467d-9cc4-e04e4551cd50	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:22:08.290698+00	2023-04-27 10:22:08.290698+00
3be85991-8fa6-4932-8a11-b8aab5405f77	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:22:08.428765+00	2023-04-27 10:22:08.428765+00
ebef4bfe-2274-4976-b0ff-bbd391c19c30	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:22:36.777388+00	2023-04-27 10:22:36.777388+00
768868af-723c-4f15-851a-d0bc67b77261	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:22:37.01536+00	2023-04-27 10:22:37.01536+00
b60f41bb-c376-4217-96d5-fc7e6d5eaaad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:23:19.045677+00	2023-04-27 10:23:19.045677+00
a10c8dd6-8ae4-4754-866a-c0964978496e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:23:19.180183+00	2023-04-27 10:23:19.180183+00
37c3ab6f-9d2e-44bb-a843-30fb6b0bdb5b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:24:13.993653+00	2023-04-27 10:24:13.993653+00
a377c023-2bc5-4902-8817-163cc2aff74c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:25:05.571289+00	2023-04-27 10:25:05.571289+00
ece10a89-2e95-4a12-a5e0-e31f1335423d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:25:05.745162+00	2023-04-27 10:25:05.745162+00
bd280a0f-5784-477c-af88-ba7a8f4ba0f6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:26:19.817905+00	2023-04-27 10:26:19.817905+00
3cdbad3e-5949-4672-bbbf-01584a4b6917	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:31:17.153907+00	2023-04-27 10:31:17.153907+00
765e34b7-6dfd-4bfc-9464-baf477d36a36	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:31:17.316427+00	2023-04-27 10:31:17.316427+00
4fdc6ddc-6462-4f54-a68c-de409e42b551	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:34:04.273875+00	2023-04-27 10:34:04.273875+00
8fa74e6e-416f-44ee-945c-c95fbbc8910c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:34:04.49675+00	2023-04-27 10:34:04.49675+00
4a054f5e-7c52-440a-8ecb-ed092d127db1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:38:43.511841+00	2023-04-27 10:38:43.511841+00
67509f84-de87-4102-a985-7db94e907bf1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:41:45.592979+00	2023-04-27 10:41:45.592979+00
058aa0bf-ef47-4a22-be95-0df40499d3b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:41:54.560203+00	2023-04-27 10:41:54.560203+00
73cf7339-289b-4896-9ece-9df9c199cd52	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:41:54.751112+00	2023-04-27 10:41:54.751112+00
9e5d0908-b93f-430e-9d18-815010f29e59	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:47:55.4763+00	2023-04-27 10:47:55.4763+00
a32e1925-89ea-46df-8283-5318415b99bb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:47:55.672367+00	2023-04-27 10:47:55.672367+00
d20efe09-aa14-4dbc-b4a2-dc2464adb715	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:49:12.769738+00	2023-04-27 10:49:12.769738+00
85661b6f-0a6d-4d03-98de-850538420701	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:49:16.989244+00	2023-04-27 10:49:16.989244+00
bc72f548-2fe9-48b0-8adb-46113b1bd556	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:52:32.661906+00	2023-04-27 10:52:32.661906+00
7acca0b8-b759-499b-9e28-8047b2faf776	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:52:37.37631+00	2023-04-27 10:52:37.37631+00
37616a15-97b8-449e-88c6-e563279c5d1f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:53:00.938808+00	2023-04-27 10:53:00.938808+00
fdb36385-7420-400f-af03-46122a11a7f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:53:01.09446+00	2023-04-27 10:53:01.09446+00
31b76ba9-3e79-40bc-bc3d-25270c922af3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:53:23.877351+00	2023-04-27 10:53:23.877351+00
35f64dd3-5a6a-4ce5-82b9-350112837dde	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:53:24.086541+00	2023-04-27 10:53:24.086541+00
9d8b423d-473a-4ebc-8225-1a307a16bc15	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:54:28.368494+00	2023-04-27 10:54:28.368494+00
02eea6ed-0b6c-49d6-b9ab-e3ee593c3b31	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:54:28.485996+00	2023-04-27 10:54:28.485996+00
8184a719-026e-4534-bca2-e06ef30c000e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:58:10.475756+00	2023-04-27 10:58:10.475756+00
c9b6956b-7642-40b2-92f9-a660052324d8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:58:10.713585+00	2023-04-27 10:58:10.713585+00
7f40bc2c-51fd-459d-ad9c-017de87e1ba0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:59:04.348374+00	2023-04-27 10:59:04.348374+00
0d4369b4-8b8f-4622-bb52-ac484eaa52bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:59:04.516048+00	2023-04-27 10:59:04.516048+00
40cfba0c-7410-4283-899b-f10b2a05760c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:59:41.921196+00	2023-04-27 10:59:41.921196+00
9e3913b8-51ae-4f07-9041-81a06ab03f12	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 10:59:42.03031+00	2023-04-27 10:59:42.03031+00
f74b43b8-f042-45a4-b999-0893fd7ca6dd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:02:30.704875+00	2023-04-27 11:02:30.704875+00
41ad30f0-2321-4b2f-a483-f91257fb7398	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:03:37.047112+00	2023-04-27 11:03:37.047112+00
de76f315-9462-4ba6-b409-baef129971ee	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:03:37.502583+00	2023-04-27 11:03:37.502583+00
240cc7d0-b720-434f-bdbf-aec9aea0e877	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:04:12.3924+00	2023-04-27 11:04:12.3924+00
1c6534b0-a729-47db-9358-5c80ff4f1854	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:04:12.493396+00	2023-04-27 11:04:12.493396+00
62008f67-b9ea-43ca-aea3-fe5739e3795d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:18:43.40295+00	2023-04-27 11:18:43.40295+00
0b89bad2-8838-4535-b2a4-603aa2a9c404	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:18:43.889683+00	2023-04-27 11:18:43.889683+00
af4fb9fc-0954-4ced-a700-36fd66c488f1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:18:49.957344+00	2023-04-27 11:18:49.957344+00
308e6100-5afd-4be7-a34a-0a9db8d1e50d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:18:50.176963+00	2023-04-27 11:18:50.176963+00
d927c258-f9c0-4792-8e6d-66f6b267e408	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:18:55.850492+00	2023-04-27 11:18:55.850492+00
63814b23-47c2-4d66-a7ed-4e755a541a4e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:10.85914+00	2023-04-27 11:20:10.85914+00
ecd04a9b-8ced-4138-901e-3ab5427c54a5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:42.497233+00	2023-04-27 11:20:42.497233+00
15cfbc40-6300-4e75-a686-28494f2cc3cc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:42.62521+00	2023-04-27 11:20:42.62521+00
b932df9a-a613-4104-909b-5d4ebfd01c0a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:23:03.079052+00	2023-04-27 11:23:03.079052+00
a27c25eb-46fc-418a-8622-887be5879c64	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:25:09.156679+00	2023-04-27 11:25:09.156679+00
beb252f7-a688-455f-85b4-76de0d22bfc9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:37:33.77299+00	2023-04-27 11:37:33.77299+00
ada315f7-c65e-495f-aa91-61ced6a37dad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:56:20.58589+00	2023-04-27 11:56:20.58589+00
7aa4b098-3ba0-4d36-bf27-e938e5c6be06	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:57:04.413413+00	2023-04-27 11:57:04.413413+00
48bd18c4-791a-4f6b-948f-0073f6b02cf6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:57:04.540562+00	2023-04-27 11:57:04.540562+00
f75beaa2-e631-4899-b7d5-b0e0a7b58a3f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:58:22.72539+00	2023-04-27 11:58:22.72539+00
5b1c8543-5a25-490d-996d-97255479649a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:01:28.032907+00	2023-04-27 12:01:28.032907+00
d450ee04-2dc6-4618-b32a-4ac7d9af35f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:06:44.206059+00	2023-04-27 12:06:44.206059+00
acdfb1eb-f9e1-4785-b250-e421e5ec963e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:34:20.054329+00	2023-04-27 12:34:20.054329+00
5206b1e9-5683-451a-9864-abe43cd4a17b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 13:39:49.963161+00	2023-04-27 13:39:49.963161+00
00e96b0c-3b61-4884-b402-eacb7776049a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 14:42:08.653628+00	2023-04-27 14:42:08.653628+00
5c3f0c39-e0b4-455a-9f72-cbd0dc3a98fd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:11.028056+00	2023-04-27 11:20:11.028056+00
19b61dc6-1643-4bfe-8ec3-cc4ab3357c1e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:13.113994+00	2023-04-27 11:20:13.113994+00
3affe6d6-5c72-40cc-a2fc-d1f659b00218	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:13.214979+00	2023-04-27 11:20:13.214979+00
5bb47b26-ef7b-4704-9b6c-33e22414069d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:20:23.402266+00	2023-04-27 11:20:23.402266+00
0da54e75-5993-4a8a-9a2c-193bc4a3bc21	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:23:03.294793+00	2023-04-27 11:23:03.294793+00
c32c8e03-4bfc-40d0-8ed3-a1ec537f905d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:25:09.449745+00	2023-04-27 11:25:09.449745+00
2f7a284b-2321-4e01-8878-650c7062380a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:32:12.090809+00	2023-04-27 11:32:12.090809+00
48678379-35f6-463c-8b60-d2b05b580b0a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:34:08.486246+00	2023-04-27 11:34:08.486246+00
259266bd-01ce-44d0-9602-f5a2a6a4f632	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:37:33.958284+00	2023-04-27 11:37:33.958284+00
261ae5b6-681f-45b4-ab15-1752a6eee87d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:41:26.714646+00	2023-04-27 11:41:26.714646+00
f9fee398-11b5-4cb2-9f4f-7835e801ffe0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:46:00.758253+00	2023-04-27 11:46:00.758253+00
6efbe359-bdea-43c5-975c-562cd722c0e0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:46:00.967044+00	2023-04-27 11:46:00.967044+00
518f7efe-b9fe-4332-8cd5-7fca12645d8d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:53:08.175329+00	2023-04-27 11:53:08.175329+00
68b576ee-be00-4efe-8eb9-6905ec944591	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:53:08.555852+00	2023-04-27 11:53:08.555852+00
d9fe9a46-bda4-41b6-8e79-50122720a9aa	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:56:20.817509+00	2023-04-27 11:56:20.817509+00
1ce68154-9ed9-43a0-8120-7e2b8bc074a4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 11:59:22.486313+00	2023-04-27 11:59:22.486313+00
ee57c943-978d-498d-91f1-15442f6d927b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:01:27.822466+00	2023-04-27 12:01:27.822466+00
404961da-0a01-4ad3-bd26-60f7fc90d436	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:04:21.324825+00	2023-04-27 12:04:21.324825+00
b809eca6-6fa5-44a0-9a9a-751ea848d273	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:05:41.59853+00	2023-04-27 12:05:41.59853+00
db21f5d8-8b76-4d4e-a448-f8a7c9f7a7ad	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:06:23.523584+00	2023-04-27 12:06:23.523584+00
f351ef40-b6ae-4b2f-b791-7856445de094	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:06:44.40688+00	2023-04-27 12:06:44.40688+00
6ff91426-b310-4aba-93d7-7cdfffaa7560	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:07:45.917033+00	2023-04-27 12:07:45.917033+00
25e6746d-70f8-46b2-8098-782bfe90de03	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:08:14.86249+00	2023-04-27 12:08:14.86249+00
69b201dd-72a1-464a-a47d-9d1df16e7ee1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:08:15.109465+00	2023-04-27 12:08:15.109465+00
34cf5a87-cf0f-42a8-ae84-99a2e2ef293e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 12:34:19.722492+00	2023-04-27 12:34:19.722492+00
b1ba77b8-0a0b-48f6-a703-d95c67ec218a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 14:42:07.651567+00	2023-04-27 14:42:07.651567+00
57120ea8-873d-415e-b6b8-396293baf187	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 17:32:17.312971+00	2023-04-27 17:32:17.312971+00
b75454d2-6b51-4604-bd32-4690c657e2f0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 17:36:23.743078+00	2023-04-27 17:36:23.743078+00
1ed22580-c5d7-4591-897c-873d3aca8431	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 17:37:46.50094+00	2023-04-27 17:37:46.50094+00
9adabe29-7f88-4585-a620-cda92c7ca4f5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 17:38:35.289447+00	2023-04-27 17:38:35.289447+00
f93468a8-f232-43fe-aa37-71d72a385d9a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 17:38:35.368175+00	2023-04-27 17:38:35.368175+00
7c4b2838-4cf7-4d02-8d3a-25054a859732	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:03:04.354529+00	2023-04-27 19:03:04.354529+00
b9a07865-073d-4243-9e00-efab3f0cf056	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:03:12.898025+00	2023-04-27 19:03:12.898025+00
609f427f-719f-45a8-b2a5-4c20bc29538f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:06:00.471232+00	2023-04-27 19:06:00.471232+00
b68985de-212c-4ffb-93c1-3141e5999149	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:11.478029+00	2023-04-27 19:15:11.478029+00
5175847f-7a1e-45ad-9483-c270a8c14bc3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:12.37952+00	2023-04-27 19:15:12.37952+00
6ca9c6d3-3ce0-4abc-9ed8-cba3dff3bfcd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:19.829177+00	2023-04-27 19:15:19.829177+00
1dd29f67-dd5d-4ae3-ba35-29fc93221320	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:24.371961+00	2023-04-27 19:15:24.371961+00
e13b580e-f249-40d1-b1ed-7e17919510b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:25.270998+00	2023-04-27 19:15:25.270998+00
a815c104-9fa7-4535-b3ec-8dc55d3401f3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:25.957809+00	2023-04-27 19:15:25.957809+00
8cbaa4ae-c059-468a-8bf2-efd34d8a9cd8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:26.533031+00	2023-04-27 19:15:26.533031+00
2b18c899-1572-4513-8621-7644833d2f5e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:26.678207+00	2023-04-27 19:15:26.678207+00
35472be4-ad35-4d06-bbc8-0c1849704a66	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:26.843189+00	2023-04-27 19:15:26.843189+00
92eefcf6-cb3d-48df-9f90-7eb60a767538	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:26.983712+00	2023-04-27 19:15:26.983712+00
450da9b1-91fb-4c0e-bb49-0791d671b9f2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.14479+00	2023-04-27 19:15:27.14479+00
aa8033d5-0352-45ba-91f1-c5f65960f6be	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.296292+00	2023-04-27 19:15:27.296292+00
ec3854c5-5195-4cb5-9cf4-99439def48ee	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.435699+00	2023-04-27 19:15:27.435699+00
d7529748-866f-4819-a777-a6aa7a494851	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.567585+00	2023-04-27 19:15:27.567585+00
d72a504b-81c2-4a37-a8b6-efdaac0c1b8a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.733922+00	2023-04-27 19:15:27.733922+00
bea894be-d3b1-4788-a0ac-e4195e3e376e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:27.865529+00	2023-04-27 19:15:27.865529+00
4ea0b945-adbb-454a-a0ec-b5e5afbb9fba	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-27 19:15:28.04811+00	2023-04-27 19:15:28.04811+00
22810a42-403c-4a41-b755-f52fcc2b56df	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 05:44:31.913302+00	2023-04-28 05:44:31.913302+00
d083a4be-2dfc-47e9-8d03-9666d564702a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 05:44:36.48297+00	2023-04-28 05:44:36.48297+00
0b966b4c-736a-4712-b2ef-8131352ebca8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 07:58:24.843706+00	2023-04-28 07:58:24.843706+00
4c63b3e0-966a-4d3a-a3ef-adb428834a08	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 07:58:28.296216+00	2023-04-28 07:58:28.296216+00
8dbeed8a-8e2e-42b3-99af-c9d81b9fbc7f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 07:58:58.955832+00	2023-04-28 07:58:58.955832+00
a003bf43-8c75-43a5-9f9b-5e762b065c89	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:03:45.376178+00	2023-04-28 08:03:45.376178+00
fb7f9db9-32bd-4b0d-b10a-e0773d0d49ec	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:03:46.356827+00	2023-04-28 08:03:46.356827+00
2814d977-4170-4861-bda7-7249d6f7d2e4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:09:53.37028+00	2023-04-28 08:09:53.37028+00
b7e6b771-81bb-458a-9903-256627ab2c11	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:09:54.745554+00	2023-04-28 08:09:54.745554+00
d6fce4eb-de5a-4cb3-9baf-7c6589252a94	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:10:52.275767+00	2023-04-28 08:10:52.275767+00
1dbcdba1-1d69-4f86-b737-933a09b4d110	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:11:31.863221+00	2023-04-28 08:11:31.863221+00
ae339e0a-8e6b-491d-910a-f6af2385786e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:12:50.121513+00	2023-04-28 08:12:50.121513+00
9054f63e-1c7b-4830-975e-12780834cf85	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:14:31.19062+00	2023-04-28 08:14:31.19062+00
dc192902-0424-41e1-a587-5f27c5349c10	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:14:31.957779+00	2023-04-28 08:14:31.957779+00
4e2131c0-2f5d-421e-8c2d-734f9ae893d1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:14:51.463242+00	2023-04-28 08:14:51.463242+00
c924354b-c026-420b-bc5c-bd9d1132fdc2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:14:52.416949+00	2023-04-28 08:14:52.416949+00
0b4bb96f-4cf1-4314-81ff-16a111a34884	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:14:53.124839+00	2023-04-28 08:14:53.124839+00
110594e9-b5bf-43ec-a257-d9e0d237f3f7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:18:31.901004+00	2023-04-28 08:18:31.901004+00
7318ce8e-d4e7-4b35-8719-f61fd3f9decc	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:18:50.781293+00	2023-04-28 08:18:50.781293+00
79142f44-48e4-418d-af42-aaa2eda79f09	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:21:15.572487+00	2023-04-28 08:21:15.572487+00
4da7b62d-8a9d-4e6f-bd46-f2651fc85e9e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:21:16.834158+00	2023-04-28 08:21:16.834158+00
d0b17425-b95c-4988-8907-f57b32ff391a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:21:17.511213+00	2023-04-28 08:21:17.511213+00
892de979-cd52-4c1f-8c6d-a30c4f063037	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:21:18.262071+00	2023-04-28 08:21:18.262071+00
3437b9d2-6356-4832-bf7b-21b594d861cd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:21:19.876036+00	2023-04-28 08:21:19.876036+00
51820c14-00d2-4121-8885-13c2f146a3d4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-28 08:22:23.167965+00	2023-04-28 08:22:23.167965+00
3997c624-d44a-45c4-8546-4c28939d4040	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 09:51:56.009631+00	2023-04-29 09:51:56.009631+00
b33e67de-573c-4968-9fa1-0b3be274d756	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:55:28.907105+00	2023-04-29 10:55:28.907105+00
42197ddb-a402-4b2d-936f-7f09ab0dea01	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:57:18.362159+00	2023-04-29 10:57:18.362159+00
a5ec14b8-cc62-45a4-892a-bbb21d2eb660	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:57:19.406633+00	2023-04-29 10:57:19.406633+00
eb8e0b56-508a-4ba1-aa98-75e58db9f6d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:57:20.083919+00	2023-04-29 10:57:20.083919+00
374b7c2a-37da-4d35-ad17-a65478399ad0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:59:29.842903+00	2023-04-29 10:59:29.842903+00
2a44ece7-3b12-448e-9a44-5f52ef82036e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 10:59:53.618082+00	2023-04-29 10:59:53.618082+00
35414cb0-90b1-43c5-87f8-fa14b4e7787c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 11:01:38.289857+00	2023-04-29 11:01:38.289857+00
25731f19-e99f-418e-b285-8ae0ffdae261	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 11:01:44.944817+00	2023-04-29 11:01:44.944817+00
82f9bcba-8369-4c22-bed0-5ddee1a90de2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 11:02:11.654863+00	2023-04-29 11:02:11.654863+00
f5eb9208-be86-4794-a0d9-c33c8ad99f13	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 11:03:01.075042+00	2023-04-29 11:03:01.075042+00
a897f31c-d622-4ee8-99d9-1bc1673170db	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 11:03:01.241871+00	2023-04-29 11:03:01.241871+00
f1bb9501-ee51-43b9-b496-3044199f36ab	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 12:24:05.760052+00	2023-04-29 12:24:05.760052+00
2828f76b-d013-48ee-a729-7baad4c64b58	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 12:24:06.537569+00	2023-04-29 12:24:06.537569+00
e4b58ada-9046-42ab-89d6-037d9b2594bb	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 12:24:33.311105+00	2023-04-29 12:24:33.311105+00
53001350-5b06-49b9-a662-e0c7ab71dc38	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 14:54:15.06354+00	2023-04-29 14:54:15.06354+00
eba8a444-e56b-4365-90bb-eab20683bdc4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 14:56:20.263285+00	2023-04-29 14:56:20.263285+00
ac5d6078-76d7-4090-bbad-42ed541c4fed	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 14:58:37.722132+00	2023-04-29 14:58:37.722132+00
4d982d23-3546-4fe7-b259-7a8ab5972d73	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 15:01:19.884871+00	2023-04-29 15:01:19.884871+00
8cd492be-ae42-4d02-8d9d-1eb53262cbf1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 15:03:28.021014+00	2023-04-29 15:03:28.021014+00
4a794e88-56d6-4a4b-b018-8a5a9a2afd1a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 15:06:03.135907+00	2023-04-29 15:06:03.135907+00
3d277633-4521-47de-b0ae-103e1b770d27	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 15:07:42.264922+00	2023-04-29 15:07:42.264922+00
380daf8a-09d1-476c-967f-768519a0f50f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 15:16:59.281768+00	2023-04-29 15:16:59.281768+00
cdb024f1-87c9-40b5-acad-58e5264c896e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:01:23.316893+00	2023-04-29 17:01:23.316893+00
c5b30af6-00f3-463c-806d-46bb7c19a3b0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:01:30.857392+00	2023-04-29 17:01:30.857392+00
4404cd65-a67e-48af-b267-cf94a9985222	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:02:09.079747+00	2023-04-29 17:02:09.079747+00
e63fb4ae-4940-492f-ad67-025006de2238	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:02:22.267454+00	2023-04-29 17:02:22.267454+00
ddef1953-0474-4dbe-8a7f-f8ec022c75e8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:04:29.236564+00	2023-04-29 17:04:29.236564+00
b2c2f4c2-e5ad-40e2-b09a-10843a50a620	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:04:36.722736+00	2023-04-29 17:04:36.722736+00
f928c9fd-1960-40bf-bccc-a5cf7d0de1c7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:08:56.715387+00	2023-04-29 17:08:56.715387+00
1eb66f5c-2b72-48a7-97d7-a90f6f080b1e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:09:44.515456+00	2023-04-29 17:09:44.515456+00
9f5f74c4-9efb-4a84-af69-ccf0abdbdac1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:11:30.038432+00	2023-04-29 17:11:30.038432+00
605d87ec-225d-457e-a514-a2a045c57475	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:12:12.977605+00	2023-04-29 17:12:12.977605+00
9bc4654a-ce4b-4603-8011-4144628be3ca	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:13:01.251994+00	2023-04-29 17:13:01.251994+00
e17e85e1-6416-41e1-80dc-519ab5e7adac	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:23:21.206825+00	2023-04-29 17:23:21.206825+00
2f15b2a6-de0a-4a90-851f-731cce7de092	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:24:30.931711+00	2023-04-29 17:24:30.931711+00
938d66d8-9590-4cd2-b8ad-1d71ff1fa7ab	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:24:38.454396+00	2023-04-29 17:24:38.454396+00
d0b2a05f-49b6-4f62-a402-c7b4e8248e52	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:24:39.211054+00	2023-04-29 17:24:39.211054+00
506d638a-7b54-440d-ab9f-27c9f34c68d5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:24:45.558288+00	2023-04-29 17:24:45.558288+00
e49e43dd-aa7a-45b6-88c6-7240e835b2c1	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:25:31.634171+00	2023-04-29 17:25:31.634171+00
1681012c-3578-4cd9-b371-c53007828455	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:27:07.529016+00	2023-04-29 17:27:07.529016+00
9023c5bd-4472-4f48-9e5f-7d450d5dcb3c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:28:21.256193+00	2023-04-29 17:28:21.256193+00
a114b349-5399-4fdb-8dde-a08d03c4712b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:30:10.642133+00	2023-04-29 17:30:10.642133+00
d4d3a58c-f42e-425b-9d85-f5b0168b3498	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:31:26.114642+00	2023-04-29 17:31:26.114642+00
01f70190-d4bd-45df-b384-d3661af989b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:31:53.758723+00	2023-04-29 17:31:53.758723+00
2cf4c59c-fa15-4273-b8a8-641152a4402e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:34:45.346775+00	2023-04-29 17:34:45.346775+00
4e655e33-5bc2-416b-94c1-fafaddeb4fd5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:34:47.736058+00	2023-04-29 17:34:47.736058+00
b6fb9b7d-1e0e-487e-a9f0-7834509394c3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:35:20.579062+00	2023-04-29 17:35:20.579062+00
ab9fe002-ae55-43ad-ae73-dc1446fc6e78	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:36:25.010979+00	2023-04-29 17:36:25.010979+00
176d9539-9979-48a6-8cbe-89ebb6b791be	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:37:13.140048+00	2023-04-29 17:37:13.140048+00
58a8e8f1-a14c-4379-b1b9-c6f7a2272bea	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:40:43.796953+00	2023-04-29 17:40:43.796953+00
a63d3da1-5000-4ae8-a140-20715c4695b2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:44:33.960598+00	2023-04-29 17:44:33.960598+00
687507ea-a1b2-4edd-9d40-5d05093ef858	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:45:20.450597+00	2023-04-29 17:45:20.450597+00
0958487f-591d-424b-a44a-706936a900c7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 17:53:18.885631+00	2023-04-29 17:53:18.885631+00
a6faad99-7103-40cc-bbe2-39451804d73b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:06:54.141928+00	2023-04-29 18:06:54.141928+00
3c095751-bef9-48d8-918a-f94be6eef937	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:08:06.307141+00	2023-04-29 18:08:06.307141+00
0be245a4-d602-4ee6-9d60-83bf4959f71a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:08:33.456341+00	2023-04-29 18:08:33.456341+00
4149e705-7954-4f3c-b1eb-35fe86b990bf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:08:53.353089+00	2023-04-29 18:08:53.353089+00
e0cd5b6a-9825-4df5-80e9-60327b75d65e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:09:32.50065+00	2023-04-29 18:09:32.50065+00
1585d2ba-8e90-492f-b7f5-2df8e7245f24	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:15:54.771094+00	2023-04-29 18:15:54.771094+00
9006574e-d3ef-4c2f-967b-29a9e7742bf8	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:16:52.280332+00	2023-04-29 18:16:52.280332+00
f25f3f2d-9ead-4525-a623-e3a4717f1862	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:17:43.079464+00	2023-04-29 18:17:43.079464+00
71f2518a-d764-4d8c-98cd-2f2f8704645f	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:18:43.309006+00	2023-04-29 18:18:43.309006+00
6405a480-04b3-4ff5-838e-75b45cc83d0d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:19:42.972906+00	2023-04-29 18:19:42.972906+00
24b3c7e8-0be2-493d-bd36-6310b5fba999	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:20:27.285886+00	2023-04-29 18:20:27.285886+00
c10908f5-8274-4bcb-a6d7-7661d61e1b17	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:24:59.697268+00	2023-04-29 18:24:59.697268+00
7816600a-20ac-47ee-a01c-4b1cc0e4fa3d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:27:08.875351+00	2023-04-29 18:27:08.875351+00
e87baf95-8f54-420e-8cb2-908a501a7c48	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:27:51.576021+00	2023-04-29 18:27:51.576021+00
cac6c292-1790-471c-9d28-7f570294351e	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 18:28:18.955371+00	2023-04-29 18:28:18.955371+00
f6ca83b0-58b8-4788-9139-e064248d9ffd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:43:23.963207+00	2023-04-29 19:43:23.963207+00
408b9e16-2e70-45b5-9cb9-f81af11e5d9d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:46:19.33025+00	2023-04-29 19:46:19.33025+00
3823d4c8-28af-42a4-a968-b9edd6764916	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:46:32.752322+00	2023-04-29 19:46:32.752322+00
f4dfebc7-d9ac-4a73-865b-2e82bf34a142	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:46:33.760848+00	2023-04-29 19:46:33.760848+00
b6bd3131-02dd-4794-b115-8fc65456dbd3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:48:07.869238+00	2023-04-29 19:48:07.869238+00
fba400d0-f94e-475c-add5-64236616add5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:48:23.305597+00	2023-04-29 19:48:23.305597+00
2e3c8e4e-0cbd-4e47-b36e-de7ebd19d714	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:49:14.912385+00	2023-04-29 19:49:14.912385+00
9dcdcce0-f352-441e-95fb-def33adc7989	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:50:50.820308+00	2023-04-29 19:50:50.820308+00
c431ec04-12d4-4aa4-8bc6-efa453bd4bae	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:52:17.1157+00	2023-04-29 19:52:17.1157+00
2f2226dc-6780-40b5-80cb-8c9d11fb9577	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:52:31.870772+00	2023-04-29 19:52:31.870772+00
b2927ad2-b14f-4d18-9fe9-fd41a19fb4e0	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:52:59.577912+00	2023-04-29 19:52:59.577912+00
faf03f07-cdda-4baa-88db-1d00c70141d3	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:53:54.584596+00	2023-04-29 19:53:54.584596+00
93582f55-cdeb-4a50-980e-bcbd87a68c7a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:55:04.965891+00	2023-04-29 19:55:04.965891+00
fd383cf4-ec45-41b6-9990-74553f7d7e6d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-04-29 19:59:46.827439+00	2023-04-29 19:59:46.827439+00
0d499d9c-affd-48c0-be0d-ea106b11ff00	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 09:29:48.381833+00	2023-05-01 09:29:48.381833+00
7b998217-6a8d-40c2-b727-3ff669483260	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 09:33:41.425497+00	2023-05-01 09:33:41.425497+00
ec8d8f29-4807-44dd-b157-e12bd5edfed2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 09:34:07.254982+00	2023-05-01 09:34:07.254982+00
26e5f0bf-1980-4392-bc79-d787e1350da5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 09:34:07.483372+00	2023-05-01 09:34:07.483372+00
db349ce6-640c-40e8-8f8a-28bdd391b8f6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 09:53:42.900765+00	2023-05-01 09:53:42.900765+00
7b832371-d7d2-461c-98b7-886db058c79c	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:01:16.738697+00	2023-05-01 10:01:16.738697+00
5e0e2e74-274c-40ae-a556-6122ff9a5a1b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:01:16.908229+00	2023-05-01 10:01:16.908229+00
49f856fc-e76b-4893-a65b-a48caef5d22a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:03:18.439528+00	2023-05-01 10:03:18.439528+00
dd245dd3-b88f-4616-920d-24e9dca3fd44	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:03:18.677301+00	2023-05-01 10:03:18.677301+00
d0889aa1-c5c3-4e35-934d-17e78adbb080	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:08:59.018751+00	2023-05-01 10:08:59.018751+00
65bdb876-72ca-4845-9c30-3724c21bbc1a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:08:59.226688+00	2023-05-01 10:08:59.226688+00
2ca6cb8d-e9ce-4f68-aa66-02617720a871	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:16:21.139732+00	2023-05-01 10:16:21.139732+00
09c27b97-6d5a-4d8b-adb1-9e7a6aa818f5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:16:21.342301+00	2023-05-01 10:16:21.342301+00
ee65d351-7e66-4f69-80a0-cfca856b7aed	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:19:53.630021+00	2023-05-01 10:19:53.630021+00
08405351-ba0c-4058-b7a5-0047e6af7c38	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:19:53.805091+00	2023-05-01 10:19:53.805091+00
b8437b14-aafa-455f-8fba-7c8ba4b1a0ca	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:19:58.96983+00	2023-05-01 10:19:58.96983+00
e62d689a-edf3-447f-8c2b-b3d1caf25542	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:19:59.109922+00	2023-05-01 10:19:59.109922+00
e156cef2-faad-4698-9a9c-4c1ece1100dd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:24:51.326583+00	2023-05-01 10:24:51.326583+00
2409860d-a511-4d6c-a824-e1a873ba95d2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:24:51.511803+00	2023-05-01 10:24:51.511803+00
ae2f806a-6411-4443-b21d-df92ae0cced5	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:28:30.1919+00	2023-05-01 10:28:30.1919+00
e3a9cb6c-82c5-498d-9bd7-9de197bda538	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 10:29:02.859773+00	2023-05-01 10:29:02.859773+00
5eda65f3-8e89-4c21-a589-1afe942e4daf	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-01 11:25:20.271596+00	2023-05-01 11:25:20.271596+00
aa7c9044-55d8-4c3e-8cee-9586af86c734	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:03:02.290326+00	2023-05-03 04:03:02.290326+00
82c7bed4-9d2d-4fa8-b5d9-7f19a83c0900	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:05:19.530015+00	2023-05-03 04:05:19.530015+00
db2a5805-b6c5-4242-9cd0-c5cec3a9d86a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:08:17.137267+00	2023-05-03 04:08:17.137267+00
a9f1baa6-f0b8-4cbe-a28e-c6820512f9cd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:10:39.776951+00	2023-05-03 04:10:39.776951+00
567416b9-3596-48df-8035-cdf32629faae	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:11:35.590744+00	2023-05-03 04:11:35.590744+00
20260e0d-5119-432a-9b00-9b8af530f4a9	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:13:50.007687+00	2023-05-03 04:13:50.007687+00
0411a028-b38e-4f3f-ae12-214c9323e46a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:14:02.647264+00	2023-05-03 04:14:02.647264+00
0b29af44-31d5-4244-baea-622fe400a041	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:16:13.275177+00	2023-05-03 04:16:13.275177+00
bf980ffa-699f-45cc-875b-4fa760d94803	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:19:04.298978+00	2023-05-03 04:19:04.298978+00
cba6248b-7f9c-4071-85ee-979b8a9725df	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:25:56.097665+00	2023-05-03 04:25:56.097665+00
5f3c9439-3112-45fb-a755-804a729e9475	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:36:30.503983+00	2023-05-03 04:36:30.503983+00
247891df-4240-4e93-a71f-e19e1ccf3268	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:38:21.850365+00	2023-05-03 04:38:21.850365+00
653e7ecd-eea6-4c4e-a806-a383f481aa58	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:40:14.261215+00	2023-05-03 04:40:14.261215+00
77eca24a-5497-46a3-af3e-25664fdbb0ba	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:40:34.685975+00	2023-05-03 04:40:34.685975+00
12a005f2-a529-4823-a6e8-410323eebe9a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:42:19.487357+00	2023-05-03 04:42:19.487357+00
a8a2a364-43e4-4cfe-ab79-ebcef25261b4	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:44:19.939335+00	2023-05-03 04:44:19.939335+00
9f17ea55-17b7-4486-bfa9-2bdf874ea4ce	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:48:27.186358+00	2023-05-03 04:48:27.186358+00
c14b401f-ee07-43ce-a0fc-7a6b8281c2fe	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:49:23.336982+00	2023-05-03 04:49:23.336982+00
d55a33ad-5b1d-46a3-83c1-4273a4419fb7	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:50:18.370262+00	2023-05-03 04:50:18.370262+00
f2ffe0b9-790c-4d0f-ab8c-2ae99fcf1237	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:50:36.000688+00	2023-05-03 04:50:36.000688+00
039eef62-c63d-4e31-b1b1-d534abfa7aae	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:50:56.64099+00	2023-05-03 04:50:56.64099+00
02fe0a94-a545-4789-8062-db37cacae74b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:53:02.836138+00	2023-05-03 04:53:02.836138+00
0cb37ad2-485f-4dae-a04b-97ca40383f0b	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:54:38.56697+00	2023-05-03 04:54:38.56697+00
da5d0e05-3c15-439d-90f7-ad0d0aecb075	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:54:41.839185+00	2023-05-03 04:54:41.839185+00
f329fbeb-3bbd-4548-ad63-1555b7f670d6	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:57:33.740068+00	2023-05-03 04:57:33.740068+00
8c258072-73d6-4311-bf68-a85dea4f0267	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:59:40.968524+00	2023-05-03 04:59:40.968524+00
7570737a-d02a-401b-aa91-e1c2f02a872d	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 04:59:47.930274+00	2023-05-03 04:59:47.930274+00
b0e2115c-1eac-4093-b36d-b04b8cb71c1a	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:00:03.466996+00	2023-05-03 05:00:03.466996+00
b2b8a5d6-18ce-494f-a13f-e60eddb5f3bd	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:00:03.735605+00	2023-05-03 05:00:03.735605+00
f5b519ac-12ec-48d4-9964-e3179dd875f2	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:05:01.425319+00	2023-05-03 05:05:01.425319+00
eb3a4470-08b9-4bbe-9e9f-e7cc5c0148ef	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:05:56.19966+00	2023-05-03 05:05:56.19966+00
1ad4f521-da6f-4e85-9115-830dcda70011	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:06:29.319699+00	2023-05-03 05:06:29.319699+00
339a53f2-1254-417a-a235-300f97ca2b17	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:08:11.971257+00	2023-05-03 05:08:11.971257+00
ec3d37ae-fce1-4ff2-ab4d-82231de21051	3b5a4668-d54a-45d6-85dc-feb007a4b62c	2023-05-03 05:09:25.226766+00	2023-05-03 05:09:25.226766+00
18fbccf1-35af-409e-8606-5196d44b22f6	proamore	2023-05-03 05:54:34.027004+00	2023-05-03 05:54:34.027004+00
2196b32c-9d89-4b75-a039-1bee4721e847	proamore	2023-05-03 05:55:46.739401+00	2023-05-03 05:55:46.739401+00
43c5a9ff-1cac-4d82-aeac-325d6f0a7eee	proamore	2023-05-03 06:00:03.107245+00	2023-05-03 06:00:03.107245+00
66a4eb65-3e0c-400d-8008-ce4f9556caf8	proamore	2023-05-03 06:00:52.621699+00	2023-05-03 06:00:52.621699+00
f727047d-861d-45bc-85be-9e1c54fc251f	proamore	2023-05-17 10:06:59.921852+00	2023-05-17 10:06:59.921852+00
941f50ca-7d08-4231-a0e0-890efb28c5ae	proamore	2023-05-17 10:07:27.215172+00	2023-05-17 10:07:27.215172+00
18f32f13-4aef-4235-af34-9af4d2af7080	proamore	2023-05-17 10:07:39.818646+00	2023-05-17 10:07:39.818646+00
3499edcf-31fb-44af-886c-36c9693b1492	proamore	2023-05-17 10:08:24.10991+00	2023-05-17 10:08:24.10991+00
42d9212e-55da-46f2-abb1-183d2b6fb117	proamore	2023-05-17 10:08:43.198132+00	2023-05-17 10:08:43.198132+00
0258d44e-db18-449d-86c4-4b82da57c683	proamore	2023-05-17 10:10:23.270068+00	2023-05-17 10:10:23.270068+00
900a1a44-de73-45b8-9dfd-5920a51626d6	proamore	2023-05-17 10:11:35.030253+00	2023-05-17 10:11:35.030253+00
ba0bebac-16a1-40e3-9443-cf7311c8abeb	proamore	2023-05-17 10:26:58.97875+00	2023-05-17 10:26:58.97875+00
2a964a92-cd16-454b-8dca-d8a9ec2ad36a	proamore	2023-05-17 10:27:22.278634+00	2023-05-17 10:27:22.278634+00
01ab3b59-a15a-4aab-905a-5d1776234640	proamore	2023-05-17 10:29:02.989825+00	2023-05-17 10:29:02.989825+00
79f0e09a-6aa6-4609-b482-76b97de6568d	proamore	2023-05-17 10:34:09.441654+00	2023-05-17 10:34:09.441654+00
bc3d360e-a4bb-4ffe-8041-8b6e17165199	proamore	2023-05-17 10:34:29.858857+00	2023-05-17 10:34:29.858857+00
cdef7b61-d1f8-4dd5-95bb-fb1ba616c9ee	proamore	2023-05-17 10:35:58.478093+00	2023-05-17 10:35:58.478093+00
9aaa2982-afc6-4cd1-b8a6-35b68ada37ed	proamore	2023-05-17 10:36:31.279389+00	2023-05-17 10:36:31.279389+00
80315f0d-2f56-4c37-a558-cb807705f321	proamore	2023-05-17 10:38:27.561771+00	2023-05-17 10:38:27.561771+00
fa4e0f79-0560-4368-b1d8-ab5aea7a8a99	proamore	2023-05-17 10:40:05.592651+00	2023-05-17 10:40:05.592651+00
01851c07-d282-4881-9aed-37966993753d	proamore	2023-05-17 10:42:36.908866+00	2023-05-17 10:42:36.908866+00
72a67369-fcff-477d-bb52-566fb5589ffd	proamore	2023-05-17 10:42:55.658588+00	2023-05-17 10:42:55.658588+00
284a6819-beda-4ce3-804d-09ff36ebbc8d	proamore	2023-05-17 10:45:21.148215+00	2023-05-17 10:45:21.148215+00
284819fc-9b9d-4455-9598-8dce0a3e4448	proamore	2023-05-17 10:46:36.832229+00	2023-05-17 10:46:36.832229+00
8d6c96df-9b9c-4b37-8586-320d1a23be04	proamore	2023-05-17 10:51:39.027805+00	2023-05-17 10:51:39.027805+00
ab7227cd-c9b9-4ed5-89a2-1d3b0fc1b14c	proamore	2023-05-17 10:54:23.06876+00	2023-05-17 10:54:23.06876+00
a6a70949-04db-4bcf-b4d6-7227c0001bd2	proamore	2023-05-17 10:54:33.673273+00	2023-05-17 10:54:33.673273+00
a2a5ee47-343d-4da0-bc84-6aaef1d3e2ea	proamore	2023-05-17 10:54:34.758415+00	2023-05-17 10:54:34.758415+00
d3525db1-6c6c-417f-8629-4562154eeec0	proamore	2023-05-17 10:54:35.559228+00	2023-05-17 10:54:35.559228+00
642873fe-9c22-4bdb-8d61-9f148c3fab98	proamore	2023-05-17 10:55:11.254598+00	2023-05-17 10:55:11.254598+00
d33f9866-e3db-49ac-a41a-f84c4fc33863	proamore	2023-05-18 15:09:00.282985+00	2023-05-18 15:09:00.282985+00
0350268e-b3c8-4411-97fc-b195c53f4b8d	proamore	2023-05-18 15:33:50.967791+00	2023-05-18 15:33:50.967791+00
4d6da3df-23d0-4730-9726-815a23659de0	proamore	2023-05-18 15:42:02.450397+00	2023-05-18 15:42:02.450397+00
698d0550-2602-4042-b375-fb0cfc2baff7	proamore	2023-05-18 15:45:10.017161+00	2023-05-18 15:45:10.017161+00
a58562ac-e153-41b2-ab7f-999a4c7b19ae	proamore	2023-05-18 15:47:16.113551+00	2023-05-18 15:47:16.113551+00
aad1f447-0ec7-458c-afa7-49ffb7736749	proamore	2023-05-18 15:49:33.946724+00	2023-05-18 15:49:33.946724+00
335c9bdd-6154-46df-9724-16856fdf3560	proamore	2023-05-18 15:52:50.311678+00	2023-05-18 15:52:50.311678+00
915db89b-99c3-4dad-add8-16680bfc10ab	proamore	2023-05-18 15:52:52.750054+00	2023-05-18 15:52:52.750054+00
23bf1004-a945-4940-9232-56f8b4da4694	proamore	2023-05-18 15:53:32.129632+00	2023-05-18 15:53:32.129632+00
667d6238-32e3-4c2f-8d5b-6a1d0dbcf36a	proamore	2023-05-18 15:55:47.119814+00	2023-05-18 15:55:47.119814+00
a9d2c748-5fbe-4f14-a265-cf4226086849	proamore	2023-05-18 15:58:21.803847+00	2023-05-18 15:58:21.803847+00
ae29f698-503b-4c9a-b0a8-74a43e24f4ed	proamore	2023-05-18 16:01:39.379408+00	2023-05-18 16:01:39.379408+00
d757a0b3-a036-4706-bd76-bedddb1ab75b	proamore	2023-05-18 16:03:17.865112+00	2023-05-18 16:03:17.865112+00
e855a1ca-439e-4cb7-802f-78aea1282d74	proamore	2023-05-18 16:05:01.970936+00	2023-05-18 16:05:01.970936+00
e15673c3-8b55-47b7-b40a-bdd83eb8c5fd	proamore	2023-05-18 16:22:51.889082+00	2023-05-18 16:22:51.889082+00
37ee3d73-32dc-407e-9895-c1a3716a88d7	proamore	2023-05-18 16:23:58.861944+00	2023-05-18 16:23:58.861944+00
dcd24849-d57f-41fb-b5c4-0ed648290c86	proamore	2023-05-18 16:24:00.561902+00	2023-05-18 16:24:00.561902+00
53160b13-2d82-4c17-b58b-7ac22242b76e	proamore	2023-05-18 16:37:38.181151+00	2023-05-18 16:37:38.181151+00
1387cf61-c42a-4c8c-9881-01750cea44ec	proamore	2023-05-18 16:02:48.2437+00	2023-05-18 16:02:48.2437+00
5d198d9e-1c7c-4220-a518-d5c0f859f3d4	proamore	2023-05-18 16:23:59.928876+00	2023-05-18 16:23:59.928876+00
e2376071-172e-4364-a983-a23f4ed0bf39	proamore	2023-05-18 16:24:56.492206+00	2023-05-18 16:24:56.492206+00
6915e5a8-8d51-4875-b8c7-4e9c6b6d44e3	proamore	2023-05-18 16:25:22.995483+00	2023-05-18 16:25:22.995483+00
71d172a2-c013-4cf3-a665-e173f52c3706	proamore	2023-05-18 16:33:56.07798+00	2023-05-18 16:33:56.07798+00
c45c3da2-0e29-4d03-8c7a-66e65e0d2d02	proamore	2023-05-18 16:37:36.991374+00	2023-05-18 16:37:36.991374+00
16fba422-3f98-430f-b30d-5826b05fea7c	proamore	2023-05-18 16:39:28.974751+00	2023-05-18 16:39:28.974751+00
dd6011b2-a041-47d4-84b3-52db3b139e8a	proamore	2023-05-18 16:40:01.986661+00	2023-05-18 16:40:01.986661+00
7963d269-1b23-4ef2-b3bb-7e49c1dd879d	proamore	2023-05-18 16:41:43.530446+00	2023-05-18 16:41:43.530446+00
ae020bdd-029f-4525-98ae-66737f4401ef	proamore	2023-05-18 16:43:02.328673+00	2023-05-18 16:43:02.328673+00
9f9ef39a-d686-4217-a5fa-9673302184a0	proamore	2023-05-18 16:45:28.685768+00	2023-05-18 16:45:28.685768+00
22b06c3d-815a-4cd3-8db8-a90530fcd37d	proamore	2023-05-18 16:46:14.030578+00	2023-05-18 16:46:14.030578+00
e2f82842-07b7-4d8f-a9ca-2f8fbd06b18f	proamore	2023-05-18 16:46:49.564554+00	2023-05-18 16:46:49.564554+00
10530e50-854a-455d-907b-dad1c06fbfa7	proamore	2023-05-18 16:47:58.992988+00	2023-05-18 16:47:58.992988+00
936cd80a-fc52-481d-955d-847a359e20e8	proamore	2023-05-18 16:48:32.297341+00	2023-05-18 16:48:32.297341+00
f28ab4bc-aa08-46d3-83ac-08b44583f91b	proamore	2023-05-18 16:49:55.9333+00	2023-05-18 16:49:55.9333+00
1da5e825-e0c4-40a9-ae29-7087462eafff	proamore	2023-05-18 16:53:35.461455+00	2023-05-18 16:53:35.461455+00
8e9c1ab6-7431-4d75-9d5f-dad191b69522	proamore	2023-05-18 17:31:16.866662+00	2023-05-18 17:31:16.866662+00
59ad2af6-56de-4c89-8ed3-e85b5e61537b	proamore	2023-05-18 17:32:31.664994+00	2023-05-18 17:32:31.664994+00
2e5cf145-ba00-4344-bf84-4f9ec318ad19	proamore	2023-05-18 17:35:53.958172+00	2023-05-18 17:35:53.958172+00
7d56a93e-ed46-497d-adbc-81d6f8f9c6b4	proamore	2023-05-18 17:35:55.185503+00	2023-05-18 17:35:55.185503+00
f8325838-0aef-4f51-bcf3-5b1ca2cf5cf4	proamore	2023-05-18 17:37:40.63919+00	2023-05-18 17:37:40.63919+00
d0c2f371-4f52-4adb-8c64-8028c4e550cc	proamore	2023-05-18 17:38:14.414262+00	2023-05-18 17:38:14.414262+00
12732d2e-737e-44e8-b0f5-c571eaad9f8e	proamore	2023-05-18 17:39:04.375188+00	2023-05-18 17:39:04.375188+00
5cae1e68-8ca6-4f5d-bf50-0bd9a7fb427b	proamore	2023-05-18 17:39:40.485802+00	2023-05-18 17:39:40.485802+00
ded666d5-cddc-4197-9f2a-0fb9ea2dec70	proamore	2023-05-18 17:42:32.769574+00	2023-05-18 17:42:32.769574+00
6c1e6095-1971-4e76-b870-18ca5489af71	proamore	2023-05-18 17:44:05.101087+00	2023-05-18 17:44:05.101087+00
edc976e3-3c1c-4cb3-aec7-485f37222017	proamore	2023-05-18 17:44:31.111436+00	2023-05-18 17:44:31.111436+00
ab006425-7188-49b6-95c6-19cf93a1aa78	proamore	2023-05-18 17:45:07.78201+00	2023-05-18 17:45:07.78201+00
48148ffe-137b-44da-bc49-d14de1979f6e	b8fa4c62-2034-4ca0-9e22-068e1078038c	2023-05-18 18:18:00.10071+00	2023-05-18 18:18:00.10071+00
02bd767f-4381-45b1-9e63-32b8a85eba0e	proamore	2023-05-18 18:19:33.026949+00	2023-05-18 18:19:33.026949+00
44b588ea-53fe-451a-8546-950c6fa685f9	proamore	2023-05-18 18:35:55.976209+00	2023-05-18 18:35:55.976209+00
beaffac6-f594-41ed-9522-4e2f87b43f11	proamore	2023-05-18 18:37:12.343066+00	2023-05-18 18:37:12.343066+00
f0687887-665c-494f-b2be-bd1ca3404a7b	proamore	2023-05-18 18:37:46.092754+00	2023-05-18 18:37:46.092754+00
4c92d4e5-692f-40cf-8c4e-ae4c6343da06	proamore	2023-05-18 18:39:45.387409+00	2023-05-18 18:39:45.387409+00
795dd56c-9e1f-4469-984d-c570070102a5	proamore	2023-05-18 18:40:06.465472+00	2023-05-18 18:40:06.465472+00
91338f7b-1e82-42a7-bbcd-9ce3496b3280	proamore	2023-05-18 22:32:46.253991+00	2023-05-18 22:32:46.253991+00
1738fed3-bbd1-4396-80e2-65544268a390	proamore	2023-05-18 22:34:00.478543+00	2023-05-18 22:34:00.478543+00
34611dd5-8c06-4c64-8d2c-732baf9bb45f	proamore	2023-05-18 22:36:37.233521+00	2023-05-18 22:36:37.233521+00
fbef86c8-0b99-40fd-a486-7972518e025d	proamore	2023-05-18 22:36:50.206705+00	2023-05-18 22:36:50.206705+00
a5d12e6f-de33-4d28-ba2b-73f500bfd8f9	proamore	2023-05-18 22:38:05.58498+00	2023-05-18 22:38:05.58498+00
71bf0a09-29bf-4fce-aedd-dd2fb2d197f9	proamore	2023-05-18 22:41:29.995393+00	2023-05-18 22:41:29.995393+00
1aae1c88-10de-4c4c-8ffb-2ec8b677ef13	proamore	2023-05-18 22:59:40.50521+00	2023-05-18 22:59:40.50521+00
5ff6a080-2d4f-4214-b782-2d52dcbd48c4	proamore	2023-05-18 23:20:22.78862+00	2023-05-18 23:20:22.78862+00
c2cd9bc3-5bd0-4690-801f-bd756850e69f	proamore	2023-05-18 23:20:28.74031+00	2023-05-18 23:20:28.74031+00
a0931040-7c31-454c-9fc2-fb7c0481bf05	proamore	2023-05-18 23:22:09.891407+00	2023-05-18 23:22:09.891407+00
d88f5729-8206-44db-851e-d32fdfe6195d	proamore	2023-05-18 23:22:11.094708+00	2023-05-18 23:22:11.094708+00
e0892e83-fd47-41fc-9b44-dad5c9de73ef	proamore	2023-05-18 23:22:11.928688+00	2023-05-18 23:22:11.928688+00
5b118b9d-dff7-4343-a48c-9b6175ebddf9	proamore	2023-05-18 23:22:12.810096+00	2023-05-18 23:22:12.810096+00
3caae3e7-dd0d-4d8a-bc07-ebf20f9877ea	proamore	2023-05-18 23:22:30.813558+00	2023-05-18 23:22:30.813558+00
5fd57061-4a77-440b-93cf-3aa12f452ac5	proamore	2023-05-18 23:24:44.232047+00	2023-05-18 23:24:44.232047+00
4067d1eb-662b-4c27-a7f6-bbe06c75c1b9	proamore	2023-05-18 23:24:45.131067+00	2023-05-18 23:24:45.131067+00
e9bbc62d-56f5-482a-8ebd-f96677ab999c	proamore	2023-05-18 23:25:00.638712+00	2023-05-18 23:25:00.638712+00
230bc128-98a2-4b60-95c4-d1f369f7fbf3	proamore	2023-05-18 23:25:01.564611+00	2023-05-18 23:25:01.564611+00
2b392dda-376e-4dd3-b459-33f12bf4e578	proamore	2023-05-18 23:25:02.229707+00	2023-05-18 23:25:02.229707+00
20ba5544-1da8-4151-b758-6039d2b5cec1	proamore	2023-05-18 23:25:02.848114+00	2023-05-18 23:25:02.848114+00
c331accc-2808-48a7-9f2f-fb85fff9a8b9	proamore	2023-05-18 23:45:53.496439+00	2023-05-18 23:45:53.496439+00
bf3aaf04-4e76-4c63-8100-46a523b690eb	proamore	2023-05-18 23:52:42.726245+00	2023-05-18 23:52:42.726245+00
19728a05-b784-4989-aef8-dc66199d5802	proamore	2023-05-18 23:52:48.054954+00	2023-05-18 23:52:48.054954+00
5250a271-6150-4178-9fb5-1b47b1c6720b	proamore	2023-05-18 23:54:02.601961+00	2023-05-18 23:54:02.601961+00
00b150be-97af-4fd5-868b-1864bff55439	proamore	2023-05-18 23:54:03.580617+00	2023-05-18 23:54:03.580617+00
9d0f0e0b-9fe7-4e93-b8d9-6f078b7309aa	proamore	2023-05-18 23:59:19.84896+00	2023-05-18 23:59:19.84896+00
7d17fb38-c928-4481-9ebe-218091993583	proamore	2023-05-19 00:02:22.807945+00	2023-05-19 00:02:22.807945+00
ca333aa4-3035-4c5e-a3eb-824b13ddbe29	proamore	2023-05-19 00:04:31.655383+00	2023-05-19 00:04:31.655383+00
35664efb-723e-46dd-b435-8a354dd7b957	proamore	2023-05-19 00:07:12.58539+00	2023-05-19 00:07:12.58539+00
11df82e7-646c-4a25-a8f7-85057f42094b	proamore	2023-05-19 00:10:17.949486+00	2023-05-19 00:10:17.949486+00
fe554e0e-c76a-4643-9f9d-9a46feea093d	proamore	2023-05-19 00:12:12.212406+00	2023-05-19 00:12:12.212406+00
675e94e6-0a87-4ec1-af9e-2b0f61c5a661	proamore	2023-05-19 00:13:13.170272+00	2023-05-19 00:13:13.170272+00
45049a78-77c8-4e0a-b412-9ad8198c58ca	proamore	2023-05-19 00:13:46.155555+00	2023-05-19 00:13:46.155555+00
7ab4b9fb-f2c9-4958-8fb8-746726cfb8cb	proamore	2023-05-19 00:15:40.958737+00	2023-05-19 00:15:40.958737+00
a0ff86a4-537f-4798-9443-460498f685e7	proamore	2023-05-19 00:15:41.768108+00	2023-05-19 00:15:41.768108+00
0c77d7ca-1085-4061-b408-cfff5a29f54c	proamore	2023-05-19 00:15:50.034325+00	2023-05-19 00:15:50.034325+00
dc0fc5ed-cf88-47d6-b3ff-cffe22af4176	proamore	2023-05-19 00:16:48.736701+00	2023-05-19 00:16:48.736701+00
2b57fd3d-6d2b-4213-a3d2-0075436cd00f	proamore	2023-05-19 00:17:30.441698+00	2023-05-19 00:17:30.441698+00
363fdb5e-225e-4c14-9fc6-c26aa1ccb9cc	proamore	2023-05-19 00:17:56.362512+00	2023-05-19 00:17:56.362512+00
6dd336a8-cb8b-4e13-8f32-6a0e17ad2354	proamore	2023-05-19 00:19:13.520035+00	2023-05-19 00:19:13.520035+00
61a2a826-ae56-4277-a5da-09eb5e6e5463	proamore	2023-05-19 00:23:15.613325+00	2023-05-19 00:23:15.613325+00
e2d7366c-34b4-4395-b941-c9f6ad7eee70	proamore	2023-05-19 00:24:17.338617+00	2023-05-19 00:24:17.338617+00
de1cbf84-8d41-4fda-a461-41bb6cd5d74c	proamore	2023-05-19 00:24:29.269479+00	2023-05-19 00:24:29.269479+00
4edef0f7-90f9-4c65-a1d2-9a940ae28074	proamore	2023-05-19 00:26:28.523034+00	2023-05-19 00:26:28.523034+00
0621d244-ab6f-46d8-bcad-f78615310466	proamore	2023-05-19 00:27:06.049207+00	2023-05-19 00:27:06.049207+00
8e2b00d3-91b6-4d87-a025-4e5792fd4455	proamore	2023-05-19 00:27:45.997696+00	2023-05-19 00:27:45.997696+00
726183c0-eb4d-41ed-be08-635fc7e39e33	proamore	2023-05-19 00:29:09.873148+00	2023-05-19 00:29:09.873148+00
aad3fb62-7629-43c5-82ae-58f4af0bd616	proamore	2023-05-19 00:30:25.343119+00	2023-05-19 00:30:25.343119+00
e6fabada-9e9e-4f27-83ba-4472d5d528f6	proamore	2023-05-22 05:38:28.330766+00	2023-05-22 05:38:28.330766+00
f946a2c9-dc0d-4dbe-b29a-7075c48c2507	proamore	2023-05-22 05:39:58.82828+00	2023-05-22 05:39:58.82828+00
5ee0bc55-54d1-495e-ba0a-68eba6f5f8f7	proamore	2023-05-26 13:19:30.285532+00	2023-05-26 13:19:30.285532+00
f34f691b-d5f9-4220-ba5c-d700c855fd93	proamore	2023-05-26 13:20:11.077713+00	2023-05-26 13:20:11.077713+00
71e589bf-45ea-4ee2-8ac4-14fbad31886d	proamore	2023-05-26 13:20:58.221578+00	2023-05-26 13:20:58.221578+00
59601163-7469-4de6-a9c8-0c2e21d44293	proamore	2023-05-26 13:22:22.89182+00	2023-05-26 13:22:22.89182+00
a6b4e4c7-d9d8-4eb7-ab2e-985c3ec0b14b	proamore	2023-05-26 13:25:44.011745+00	2023-05-26 13:25:44.011745+00
f460ee7d-5475-4650-9eba-c60b6f332344	proamore	2023-05-26 13:25:44.745752+00	2023-05-26 13:25:44.745752+00
91d454f6-c998-408e-8abf-d560c6190a88	proamore	2023-05-26 13:26:08.45902+00	2023-05-26 13:26:08.45902+00
841d4770-7269-4d1c-8a02-0321ac3a97c4	proamore	2023-05-26 13:26:09.313316+00	2023-05-26 13:26:09.313316+00
c0682271-c9ab-475b-9263-fc1fac808685	proamore	2023-05-26 13:29:53.394585+00	2023-05-26 13:29:53.394585+00
a6b9e488-bbe6-4ff2-bf2c-06c8e3aabc7c	proamore	2023-05-26 13:31:31.26489+00	2023-05-26 13:31:31.26489+00
049ba2b4-0e90-47ee-a69a-d47f22f51aa2	proamore	2023-05-26 13:39:16.510805+00	2023-05-26 13:39:16.510805+00
f02fc4fe-066a-460d-92dc-f1c0ce371ae8	proamore	2023-05-26 13:39:39.932495+00	2023-05-26 13:39:39.932495+00
69297ada-db76-436c-8465-98e506f839ce	proamore	2023-05-26 13:40:35.768651+00	2023-05-26 13:40:35.768651+00
839722ba-8d0b-4214-ab94-b41832563cfd	proamore	2023-05-26 13:43:13.556362+00	2023-05-26 13:43:13.556362+00
1386e46b-be86-49e4-bb55-11c429f932ba	proamore	2023-05-26 13:43:14.625776+00	2023-05-26 13:43:14.625776+00
e7bddaa4-a5a4-4a00-a300-48dcf796bb76	proamore	2023-05-26 13:44:00.131528+00	2023-05-26 13:44:00.131528+00
a0322361-41af-4a29-b2b4-b2e66b8255ed	proamore	2023-05-26 13:45:47.745126+00	2023-05-26 13:45:47.745126+00
b6739532-1127-47d5-aea4-27c2baf4d3f3	proamore	2023-05-26 13:49:14.146137+00	2023-05-26 13:49:14.146137+00
d6e7d4b3-0c05-4f34-874e-4f2a6bd2db7d	proamore	2023-05-26 13:50:29.00875+00	2023-05-26 13:50:29.00875+00
8469a505-7063-4439-bfad-748228f250c4	proamore	2023-05-26 13:51:22.355825+00	2023-05-26 13:51:22.355825+00
6abdd123-dd34-486f-8ef1-9d5d967aa81c	proamore	2023-05-26 13:54:41.038432+00	2023-05-26 13:54:41.038432+00
6f585933-13d9-447f-bba7-4db89611b687	proamore	2023-05-26 13:54:42.297352+00	2023-05-26 13:54:42.297352+00
0f005e47-1960-42d0-ae5d-332ef9c2e285	proamore	2023-05-26 13:54:43.125757+00	2023-05-26 13:54:43.125757+00
550b52b7-9b4d-4d60-bb27-07993740677c	proamore	2023-05-26 13:55:02.590299+00	2023-05-26 13:55:02.590299+00
a524e9f2-49e8-4523-b8b3-ee55dc8d1d69	proamore	2023-05-26 14:15:10.500896+00	2023-05-26 14:15:10.500896+00
fe081891-f434-4d1b-bfba-34479716ec03	proamore	2023-05-26 14:16:33.601274+00	2023-05-26 14:16:33.601274+00
fc19cdb5-7b17-4857-9be7-5a4b6bb0732f	proamore	2023-05-26 14:29:10.744164+00	2023-05-26 14:29:10.744164+00
0a6655bb-65ed-4256-915d-906f4ec97c14	proamore	2023-05-26 14:31:52.03355+00	2023-05-26 14:31:52.03355+00
b6c16b3c-09ad-4c0a-969f-8dacc25b5eaa	proamore	2023-05-26 14:35:36.3642+00	2023-05-26 14:35:36.3642+00
8ffd1b0b-eef7-4be4-a851-c0779520c43e	proamore	2023-05-26 14:47:53.445311+00	2023-05-26 14:47:53.445311+00
944298da-b5ac-4e85-b533-af5fb228bce7	proamore	2023-05-26 14:48:02.334904+00	2023-05-26 14:48:02.334904+00
d9d1ac65-12d4-4ebe-a719-0afa51117b39	proamore	2023-05-26 14:12:01.824081+00	2023-05-26 14:12:01.824081+00
336d16b3-d764-4518-8ea0-b27a96226b89	proamore	2023-05-26 14:29:09.43301+00	2023-05-26 14:29:09.43301+00
b92c7850-63ea-4de1-913c-7ce82ec045ce	proamore	2023-05-26 14:29:11.557533+00	2023-05-26 14:29:11.557533+00
e318427f-c4b9-49ce-9295-6f5a4d2e4b80	proamore	2023-05-26 14:29:12.647175+00	2023-05-26 14:29:12.647175+00
2c37e19c-9ffe-4cab-9fb0-4075b3e7d51e	proamore	2023-05-26 14:29:59.511445+00	2023-05-26 14:29:59.511445+00
8a626d90-ef50-4e18-80ea-7b03178d3485	proamore	2023-05-26 14:30:42.417633+00	2023-05-26 14:30:42.417633+00
0987751d-0996-4c41-b7b9-dd2b90a1f1ca	proamore	2023-05-26 14:31:49.262787+00	2023-05-26 14:31:49.262787+00
4fe58572-19a5-4d99-8f1f-dbbab310a354	proamore	2023-05-26 14:34:00.872423+00	2023-05-26 14:34:00.872423+00
166581a2-645c-44ff-ab47-4e0124f7efd4	proamore	2023-05-26 14:39:02.827824+00	2023-05-26 14:39:02.827824+00
f7ea15f1-f3ad-4b36-ab25-c019067d57d7	proamore	2023-05-26 14:43:51.63948+00	2023-05-26 14:43:51.63948+00
a7de2ad4-9617-44ec-9033-d0df0f46c3a9	proamore	2023-05-26 14:46:25.681871+00	2023-05-26 14:46:25.681871+00
0bf82b2c-4587-4ead-9750-689d34c2f8a7	proamore	2023-05-26 14:48:03.301345+00	2023-05-26 14:48:03.301345+00
067afc83-f33a-467b-84d8-bf4ad7afca61	proamore	2023-05-26 14:48:04.023219+00	2023-05-26 14:48:04.023219+00
856d9c38-2789-4725-b173-29f395fdf5b8	proamore	2023-05-26 14:48:04.839648+00	2023-05-26 14:48:04.839648+00
7e77c2ce-4557-4571-bfe7-f45b7bf8b932	proamore	2023-05-26 14:50:15.468081+00	2023-05-26 14:50:15.468081+00
c48fcab4-9cbe-426d-b1a4-8db30dbd43be	proamore	2023-05-26 14:52:35.331812+00	2023-05-26 14:52:35.331812+00
78425b96-f02f-4820-9922-d25126bb5c9a	proamore	2023-05-26 14:52:38.685279+00	2023-05-26 14:52:38.685279+00
05968f27-d793-482f-9882-1c1f1d08e69c	proamore	2023-05-26 14:56:27.461326+00	2023-05-26 14:56:27.461326+00
e856d9b8-1683-4eba-97f8-8f770ead3aac	proamore	2023-05-26 14:56:29.701889+00	2023-05-26 14:56:29.701889+00
198a75cf-ce62-4587-928a-3f0c418a609d	proamore	2023-05-26 14:56:29.93047+00	2023-05-26 14:56:29.93047+00
8a3bb301-28ba-486d-905d-5ea5f1aa1b31	proamore	2023-05-26 14:56:46.229525+00	2023-05-26 14:56:46.229525+00
1afece6e-7402-4eda-b9a8-45b5b7d7508b	proamore	2023-05-26 14:56:46.508233+00	2023-05-26 14:56:46.508233+00
c0b1ea59-224d-4976-a49f-cd50984b3e87	proamore	2023-05-26 14:56:56.543004+00	2023-05-26 14:56:56.543004+00
2fa500ed-dd35-4f80-ac3e-b19590d301c4	proamore	2023-05-26 14:58:22.631857+00	2023-05-26 14:58:22.631857+00
994a3d9c-25ba-4ace-aa0f-f0d85e41581d	proamore	2023-05-26 14:58:41.773192+00	2023-05-26 14:58:41.773192+00
fb5f2252-e40f-462c-b695-64cff598424c	proamore	2023-05-26 15:00:55.750815+00	2023-05-26 15:00:55.750815+00
7e1a6601-cb7a-43c2-af33-bfb92a7874d6	proamore	2023-05-26 15:02:31.714928+00	2023-05-26 15:02:31.714928+00
d629d72f-72b0-4ab2-97d9-2a0fc8b409f1	proamore	2023-05-26 15:02:58.915791+00	2023-05-26 15:02:58.915791+00
75476eb5-e778-418a-99c5-e1779a96c8c4	proamore	2023-05-26 15:03:05.07371+00	2023-05-26 15:03:05.07371+00
1c21903c-5567-47eb-8c05-7cff1644af5e	proamore	2023-05-26 15:43:16.048749+00	2023-05-26 15:43:16.048749+00
df1b0747-3174-4ddf-8a45-878737f71a42	proamore	2023-05-26 15:43:53.010297+00	2023-05-26 15:43:53.010297+00
ea04ef79-9947-4bc3-a514-4dd80eef07a7	proamore	2023-05-26 15:44:18.909798+00	2023-05-26 15:44:18.909798+00
a8842ff4-598e-463c-a203-91912b993ed5	proamore	2023-05-26 15:44:38.814605+00	2023-05-26 15:44:38.814605+00
5e3538b1-d693-42a3-9f50-e063c007921f	proamore	2023-05-26 15:44:42.145672+00	2023-05-26 15:44:42.145672+00
21803a64-a866-4d75-8c62-164ec2bf9314	proamore	2023-05-26 15:44:42.271683+00	2023-05-26 15:44:42.271683+00
2affb6d9-8f46-40bb-9814-dbec3ac8b379	proamore	2023-05-26 15:48:36.295558+00	2023-05-26 15:48:36.295558+00
cf3f00b8-dacc-4caf-b1d4-17840a027596	proamore	2023-05-26 15:48:50.2501+00	2023-05-26 15:48:50.2501+00
2bc74f71-691e-45d5-ba0e-4d48fba366cf	proamore	2023-05-26 15:52:13.389938+00	2023-05-26 15:52:13.389938+00
b65dc7cf-ca8d-4127-b044-58cd0dbdc40d	proamore	2023-05-26 15:52:14.183652+00	2023-05-26 15:52:14.183652+00
f29aa725-a496-4f5e-8146-5fea13e979bb	proamore	2023-05-26 15:53:25.67751+00	2023-05-26 15:53:25.67751+00
6a80fe51-3cb7-4976-9ea8-ef9a560e9c00	proamore	2023-05-26 15:56:14.915219+00	2023-05-26 15:56:14.915219+00
ab25a22c-4999-40a3-98e7-2c22ac99f78f	proamore	2023-05-26 15:56:15.351719+00	2023-05-26 15:56:15.351719+00
d644d9e8-de29-4b8f-a044-7ca47e50293c	proamore	2023-05-26 15:56:32.458623+00	2023-05-26 15:56:32.458623+00
77d57c84-0b55-4608-b5a9-1219504b2ea1	proamore	2023-05-26 15:56:32.74039+00	2023-05-26 15:56:32.74039+00
179081a9-d05f-44fe-b9c1-1f2a1dc96050	proamore	2023-05-26 16:13:06.787278+00	2023-05-26 16:13:06.787278+00
\.


--
-- Name: accounts accounts_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_key UNIQUE (email);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_qr_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_qr_key UNIQUE (qr);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: change_passwords change_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_passwords
    ADD CONSTRAINT change_passwords_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: menus menus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (id);


--
-- Name: order_transactions order_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_transactions
    ADD CONSTRAINT order_transactions_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_account_id_key UNIQUE (account_id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: trackings trackings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trackings
    ADD CONSTRAINT trackings_pkey PRIMARY KEY (id);


--
-- Name: change_passwords fk_change_passwords_account; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_passwords
    ADD CONSTRAINT fk_change_passwords_account FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: menus fk_menus_account; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT fk_menus_account FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: menus fk_menus_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT fk_menus_category FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: order_transactions fk_order_transactions_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_transactions
    ADD CONSTRAINT fk_order_transactions_menu FOREIGN KEY (menu_id) REFERENCES public.menus(id);


--
-- Name: order_transactions fk_order_transactions_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_transactions
    ADD CONSTRAINT fk_order_transactions_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: orders fk_orders_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: profiles fk_profiles_account; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT fk_profiles_account FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

