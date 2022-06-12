--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: decrease_dogs_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrease_dogs_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE shelters
SET dogs_counter = dogs_counter -1
WHERE OLD.shelter_name = shelters.shelter_name;
return OLD;
END;
$$;


ALTER FUNCTION public.decrease_dogs_amount() OWNER TO postgres;

--
-- Name: decrease_purposes_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrease_purposes_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE purposescounter
SET number_of = number_of  -1
WHERE OLD.main_purpose = purposescounter.purpose;
return OLD;
END;
$$;


ALTER FUNCTION public.decrease_purposes_amount() OWNER TO postgres;

--
-- Name: decrise_dogs_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrise_dogs_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE sheters
SET dogs_counter = dogs_counter -1
WHERE OLD.shelter_name = shelters_shelter_name;
return OLD;
END;
$$;


ALTER FUNCTION public.decrise_dogs_amount() OWNER TO postgres;

--
-- Name: update_dogs_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_dogs_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE shelters
SET dogs_counter = dogs_counter +1
WHERE NEW.shelter_name = shelters.shelter_name;
return NEW;
END;
$$;


ALTER FUNCTION public.update_dogs_amount() OWNER TO postgres;

--
-- Name: update_purposes_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_purposes_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE purposescounter
SET number_of = number_of  +1
WHERE NEW.main_purpose = purposescounter.purpose;
return NEW;
END;
$$;


ALTER FUNCTION public.update_purposes_amount() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: deeperpagedogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deeperpagedogs (
    breed character varying(50) NOT NULL,
    photo text,
    life_duration character varying(70),
    main_purpose character varying(50),
    full_description text,
    main_characteristics character varying(50)[],
    size character varying(30),
    weight_border1 integer,
    weight_border2 integer,
    height_female integer,
    height_male integer,
    CONSTRAINT deeperpagedogs_size_check CHECK (((size)::text = ANY ((ARRAY['¬Ґ«Є п'::character varying, 'агз­ п'::character varying, 'баҐ¤­пп'::character varying, 'ЄагЇ­ п'::character varying, '®зҐ­м ЄагЇ­ п'::character varying])::text[])))
);


ALTER TABLE public.deeperpagedogs OWNER TO postgres;

--
-- Name: mainpagedogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mainpagedogs (
    breed character varying(50) NOT NULL,
    photo text,
    description text
);


ALTER TABLE public.mainpagedogs OWNER TO postgres;

--
-- Name: photogallery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photogallery (
    breed character varying(50),
    photos character varying(100)[],
    CONSTRAINT photogallery_breed_check CHECK ((breed IS NOT NULL))
);


ALTER TABLE public.photogallery OWNER TO postgres;

--
-- Name: purposescounter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purposescounter (
    purpose character varying(50) NOT NULL,
    number_of integer DEFAULT 0
);


ALTER TABLE public.purposescounter OWNER TO postgres;

--
-- Name: shelterdogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shelterdogs (
    id bigint NOT NULL,
    name character varying(60) DEFAULT 'Unnamed'::character varying,
    breed character varying(50),
    age integer NOT NULL,
    vaccinations character varying(40)[],
    shelter_name character varying(30) NOT NULL,
    gender character varying(10) NOT NULL,
    full_description text,
    weight integer NOT NULL,
    height integer NOT NULL,
    CONSTRAINT shelterdogs_age_check CHECK ((age > 0)),
    CONSTRAINT shelterdogs_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying])::text[])))
);


ALTER TABLE public.shelterdogs OWNER TO postgres;

--
-- Name: shelterdogs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shelterdogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shelterdogs_id_seq OWNER TO postgres;

--
-- Name: shelterdogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shelterdogs_id_seq OWNED BY public.shelterdogs.id;


--
-- Name: shelters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shelters (
    shelter_name character varying(30) NOT NULL,
    shelter_location character varying(50),
    phone_number character varying(15),
    dogs_counter integer DEFAULT 0,
    CONSTRAINT shelters_phone_number_check CHECK ((phone_number IS NOT NULL)),
    CONSTRAINT shelters_shelter_location_check CHECK ((shelter_location IS NOT NULL))
);


ALTER TABLE public.shelters OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    nickname character varying(30) NOT NULL,
    email character varying(40) NOT NULL,
    password character varying(30) NOT NULL,
    city character varying(40) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: shelterdogs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs ALTER COLUMN id SET DEFAULT nextval('public.shelterdogs_id_seq'::regclass);


--
-- Data for Name: deeperpagedogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deeperpagedogs (breed, photo, life_duration, main_purpose, full_description, main_characteristics, size, weight_border1, weight_border2, height_female, height_male) FROM stdin;
Ђўбва «Ё©бЄ п ®ўз аЄ 	https://placepic.ru/wp-content/uploads/2019/07/merle-dog-long.jpg	 13 - 15 «Ґв	Companion	ЌҐ б®Ў Є  - ¬Ґзв 	{"ЋзҐ­м ЇаҐ¤ ­­ п",„аг¦Ґ«оЎ­ п,"Џ®¤е®¤Ёв ¤«п ®е®вл"}	ЄагЇ­ п	26	50	53	58
ЂЄЁв -Ё­г	https://lapkins.ru/upload/uf/78e/78e8b448a6ebc51f00d4f68203c82c9b.jpg	 10 - 13 «Ґв	Companion	џЇ®­бЄЁ© Ў «¤с¦, ўбҐ¬ аҐЄ®¬Ґ­¤го	{"‚лб®ЄЁ© Ё­вҐ««ҐЄв","Џа®¦Ёў ­ЁҐ ў­Ґ ¤®¬ ","Џ®¤е®¤Ёв ¤«п ®е®вл"}	ЄагЇ­ п	35	50	66	71
Џг¤Ґ«м	https://lapkins.ru/upload/iblock/6e5/6e52cb986e51a236498ecb062598d8a9.jpg	 10 - 18 «Ґв	Hunting	Љг¤апўҐ­мЄ п, ўлЈ«п¤Ёв § Ў ў­®	{"Њ «® «Ё­пҐв",„аг¦Ґ«оЎ­ п,"Џ®¤е®¤Ёв ¤«п ®е®вл","•®а®иҐҐ Ї®б«ги ­ЁҐ"}	ЄагЇ­ п	26	35	53	58
ЌҐ¬ҐжЄ п ®ўз аЄ 	https://proprikol.ru/wp-content/uploads/2020/10/kartinki-nemeczkoj-ovcharki-1.jpg	 12 - 15 «Ґв	Service	‚®§¬®¦­® Ё¬Ґ­­® ®­  б­Ё¬ « бм ў Њгев аҐ	{"Џа®¦Ёў ­ЁҐ ў­Ґ ¤®¬ ","ЋзҐ­м ЇаҐ¤ ­­ п","Џ®¤е®¤Ёв ¤«п ®е®вл","•®а®иҐҐ Ї®б«ги ­ЁҐ"}	ЄагЇ­ п	28	40	60	65
ЏҐЄЁ­Ґб	https://sobakevi4.ru/wp-content/uploads/2020/08/1.-pekines-imeet-drevnie-korni.jpg	 15 - 16 «Ґв	Decorative	‹Ёж® б¬Ґи­®Ґ	{"Њ «® « Ґв","ЋвбгвбвўгҐв згўбвў® бва е ","ЋзҐ­м ЇаҐ¤ ­­ п"}	¬Ґ«Є п	6	10	53	58
— г-— г	https://porodysobak.com/wp-content/uploads/2019/12/chow-chow_01_lg.jpg	 9 - 15 «Ґв	Companion	ЋЈа®¬­ п Ё « бЄ®ў п	{"Џ®¤е®¤Ёв ¤«п ®еа ­л","ЋзҐ­м ЇаҐ¤ ­­ п"}	ЄагЇ­ п	25	32	51	56
Њ «мвЁЇг	https://skstoit.ru/wp-content/uploads/2022/01/skolko-stoit-maltipu-1.jpg	 13 - 15 «Ґв	Decorative	Њ «Ґ­мЄ п, г¤®Ў­® Ўа вм б б®Ў®© ў ЄагЈ®бўҐв­®Ґ ЇгвҐиҐбвўЁҐ	{"Њ «® « Ґв","ЋзҐ­м ЇаҐ¤ ­­ п"}	¬Ґ«Є п	5	10	29	30
Sharpey	https://cat4you.ru/wp-content/uploads/b/5/b/b5bbf97fa1462f2353a229592ec0e7ea.jpeg	 9 - 11 «Ґв	Companion	Џ®е®¦  ­  ЊЁи«Ґ­	{"‚лб®ЄЁ© Ё­вҐ««ҐЄв","Џ®¤е®¤Ёв ¤«п ®еа ­л","ЋзҐ­м ЇаҐ¤ ­­ п"}	баҐ¤­пп	11	25	50	52
\.


--
-- Data for Name: mainpagedogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mainpagedogs (breed, photo, description) FROM stdin;
Ђўбва «Ё©бЄЁ© вҐамҐа	https://catfishes.ru/wp-content/uploads/2020/03/malsob1.jpg	ЊҐ«Є п еҐа­п ЎҐЈ Ґв ўЁ«пҐв еў®бв®¬
ЂЁ¤Ё	https://catfishes.ru/wp-content/uploads/2020/09/atlas1.jpg	’гЇ® ЈЁЈ з ¤
ЂЄЁв -Ё­г	https://catfishes.ru/wp-content/uploads/2021/06/akita4.jpg	ЉаҐЇЄЁ© ¤аг¦®Є-ЇЁа®¦®Є
\.


--
-- Data for Name: photogallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photogallery (breed, photos) FROM stdin;
\.


--
-- Data for Name: purposescounter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purposescounter (purpose, number_of) FROM stdin;
Pastoral	0
Fighting	0
Hunting	1
Service	1
Companion	4
Decorative	2
\.


--
-- Data for Name: shelterdogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelterdogs (id, name, breed, age, vaccinations, shelter_name, gender, full_description, weight, height) FROM stdin;
\.


--
-- Data for Name: shelters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelters (shelter_name, shelter_location, phone_number, dogs_counter) FROM stdin;
Rakom Sakom	NN ylica Jopa	89877456194	0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (nickname, email, password, city) FROM stdin;
\.


--
-- Name: shelterdogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelterdogs_id_seq', 8, true);


--
-- Name: deeperpagedogs deeperpagedogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deeperpagedogs
    ADD CONSTRAINT deeperpagedogs_pkey PRIMARY KEY (breed);


--
-- Name: mainpagedogs mainpagedogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mainpagedogs
    ADD CONSTRAINT mainpagedogs_pkey PRIMARY KEY (breed);


--
-- Name: purposescounter purposescounter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purposescounter
    ADD CONSTRAINT purposescounter_pkey PRIMARY KEY (purpose);


--
-- Name: shelterdogs shelterdogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs
    ADD CONSTRAINT shelterdogs_pkey PRIMARY KEY (id);


--
-- Name: shelters shelters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelters
    ADD CONSTRAINT shelters_pkey PRIMARY KEY (shelter_name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (nickname);


--
-- Name: shelterdogs dogs_decrease_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER dogs_decrease_trigger BEFORE DELETE ON public.shelterdogs FOR EACH ROW EXECUTE FUNCTION public.decrease_dogs_amount();


--
-- Name: shelterdogs dogs_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER dogs_trigger AFTER INSERT ON public.shelterdogs FOR EACH ROW EXECUTE FUNCTION public.update_dogs_amount();


--
-- Name: deeperpagedogs purpose_decrease_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER purpose_decrease_trigger BEFORE DELETE ON public.deeperpagedogs FOR EACH ROW EXECUTE FUNCTION public.decrease_purposes_amount();


--
-- Name: deeperpagedogs purpose_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER purpose_trigger AFTER INSERT ON public.deeperpagedogs FOR EACH ROW EXECUTE FUNCTION public.update_purposes_amount();


--
-- Name: shelterdogs fk_breed_photos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs
    ADD CONSTRAINT fk_breed_photos FOREIGN KEY (shelter_name) REFERENCES public.shelters(shelter_name);


--
-- Name: deeperpagedogs fk_purposes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deeperpagedogs
    ADD CONSTRAINT fk_purposes FOREIGN KEY (main_purpose) REFERENCES public.purposescounter(purpose);


--
-- PostgreSQL database dump complete
--

