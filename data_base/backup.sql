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
    weight character varying(70),
    height character varying(70),
    life_duration character varying(70),
    main_purpose character varying(50),
    full_description text,
    main_characteristics character varying(50)[],
    size character varying(30)
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
    photos character varying(100)[]
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
    dogs_counter integer DEFAULT 0
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

COPY public.deeperpagedogs (breed, photo, weight, height, life_duration, main_purpose, full_description, main_characteristics, size) FROM stdin;
ЂЁ¤Ё	https://catfishes.ru/wp-content/uploads/2020/09/atlas1.jpg	¤® 30 ЄЈ	¤® 62 б¬	®в 10 ¤® 12 «Ґв	Hunting	‘®Ў Є  Є« бб­ п п Ўл бҐЎҐ ў§п«. “ ¬Ґ­п в®«мЄ® ¤Ґ­ҐЈ ­Ґв,   в Є-в® ®Ја®¬­ п еҐа­п в Є п ЇгиЁвб п, еў®бв®¬ ўЁ«пҐв Ё « бЄ®ў п,­ ўҐа­®Ґ, Єагв®.	{"Њ­®Ј® «Ё­пҐв",‹ бЄ®ў п,ЂЄвЁў­ п}	баҐ¤­пп
Ђўбва «Ё©бЄЁ© вҐамҐа	https://catfishes.ru/wp-content/uploads/2020/03/malsob1.jpg	®Є®«® 6.5 ЄЈ	¤® 25 б¬	®в 12 ¤® 15 «Ґв	Companion	Ќг нв® Ў §®ўл© ЇаЁ¬Ґа ЄаЁ­¦®ў®© б®Ў ЄЁ. †Ё¤Є® ¤ бв Ї®¤ бҐЎп Ё б¤®е­Ґв. ЌҐ аҐЄ®¬Ґ­¤го	{"Њ «® «Ё­пҐв","ЋзҐ­м ЇаҐ¤ ­­ п",„аг¦Ґ«оЎ­ п,"‚лб®ЄЁ© Ё­вҐ««ҐЄв"}	¬Ґ«Є п
ЂЄЁв -Ё­г	https://catfishes.ru/wp-content/uploads/2021/06/akita4.jpg	¤® 60 ЄЈ	¤® 71 б¬	®в 10 ¤® 13 «Ґв	Companion	џ ­Ґ б¬®ваҐ« • вЁЄ®, ­® нв  б®Ў Є , ўа®¤Ґ, ®ввг¤ . ‚лЈ«п¤Ёв ЇаЁЄ®«м­®, ¤  Ґйс Ё ўҐа­ п ¤®«¦­  Ўлвм	{"Џ®¤е®¤Ёв ¤«п ®еа ­л","‚лб®ЄЁ© Ё­вҐ««ҐЄв","Џа®¦Ёў ­ЁҐ ў­Ґ ¤®¬ ","Џ®¤е®¤Ёв ¤«п ®е®вл","ЋвбгвбвўгҐв згўбвў® бва е "}	ЄагЇ­ п
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
Hunting	1
Companion	2
Pastoral	0
\.


--
-- Data for Name: shelterdogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelterdogs (id, name, breed, age, vaccinations, shelter_name, gender) FROM stdin;
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

SELECT pg_catalog.setval('public.shelterdogs_id_seq', 5, true);


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

