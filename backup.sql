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
-- Name: decrease_purps_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrease_purps_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
FOR purp_num IN 1 .. array_length(OLD.purposes, 1)
LOOP
UPDATE purposescounter
SET number_of = number_of -1
WHERE OLD.purposes[purp_num] = purposescounter.purpose;
END LOOP;
return OLD;
END;
$$;


ALTER FUNCTION public.decrease_purps_amount() OWNER TO postgres;

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

--
-- Name: update_purps_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_purps_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
FOR purp_num IN 1 .. array_length(NEW.purposes, 1)
LOOP
UPDATE purposescounter
SET number_of = number_of +1
WHERE NEW.purposes[purp_num] = purposescounter.purpose;
END LOOP;
return NEW;
END;
$$;


ALTER FUNCTION public.update_purps_amount() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dogs (
    breed character varying(50) NOT NULL,
    main_photo text,
    life_duration character varying(20),
    purposes character varying(30)[],
    full_description text,
    main_characteristics character varying(40)[],
    size character varying(15),
    weight_border1 integer,
    weight_border2 integer,
    height_male integer,
    height_female integer
);


ALTER TABLE public.dogs OWNER TO postgres;

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
    photo text,
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
    link_on_site text,
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
-- Data for Name: dogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dogs (breed, main_photo, life_duration, purposes, full_description, main_characteristics, size, weight_border1, weight_border2, height_male, height_female) FROM stdin;
Австралийская овчарка	https://placepic.ru/wp-content/uploads/2019/07/merle-dog-long.jpg	 13 - 15 лет	{Service,Hunting,Pastoral}	Не собака - мечта	{"Очень преданная",Дружелюбная,"Подходит для охоты"}	крупная	26	50	53	58
Акита-ину	https://lapkins.ru/upload/uf/78e/78e8b448a6ebc51f00d4f68203c82c9b.jpg	 10 - 13 лет	{Companion}	Японский балдёж, всем рекомендую	{"Высокий интеллект","Проживание вне дома","Подходит для охоты"}	крупная	35	50	66	71
Пудель	https://lapkins.ru/upload/iblock/6e5/6e52cb986e51a236498ecb062598d8a9.jpg	 10 - 18 лет	{Hunting,Companion}	Кудрявенькая, выглядит забавно	{"Мало линяет",Дружелюбная,"Подходит для охоты","Хорошее послушание"}	крупная	26	35	53	58
Немецкая овчарка	https://proprikol.ru/wp-content/uploads/2020/10/kartinki-nemeczkoj-ovcharki-1.jpg	 12 - 15 лет	{Service,Hunting,Pastoral}	Возможно именно она снималась в Мухтаре	{"Проживание вне дома","Очень преданная","Подходит для охоты","Хорошее послушание"}	крупная	28	40	60	65
Пекинес	https://sobakevi4.ru/wp-content/uploads/2020/08/1.-pekines-imeet-drevnie-korni.jpg	 15 - 16 лет	{Decorative,Companion}	Лицо смешное	{"Мало лает","Отсутствует чувство страха","Очень преданная"}	мелкая	6	10	53	58
Чау-Чау	https://porodysobak.com/wp-content/uploads/2019/12/chow-chow_01_lg.jpg	 9 - 15 лет	{Companion}	Огромная и ласковая	{"Подходит для охраны","Очень преданная"}	крупная	25	32	51	56
Мальтипу	https://skstoit.ru/wp-content/uploads/2022/01/skolko-stoit-maltipu-1.jpg	 13 - 15 лет	{Decorative,Companion}	Маленькая, удобно брать с собой в кругосветное путешествие	{"Мало лает","Очень преданная"}	мелкая	5	10	29	30
Шарпей	https://cat4you.ru/wp-content/uploads/b/5/b/b5bbf97fa1462f2353a229592ec0e7ea.jpeg	 9 - 11 лет	{Companion}	Похожа на Мишлен	{"Высокий интеллект","Подходит для охраны","Очень преданная"}	средняя	11	25	50	52
\.


--
-- Data for Name: photogallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photogallery (breed, photos) FROM stdin;
Џг¤Ґ«м	{https://sobakevi4.ru/wp-content/uploads/2020/08/1.-pekines-imeet-drevnie-korni.jpg}
Пудель	{https://lapkins.ru/upload/iblock/6e5/6e52cb986e51a236498ecb062598d8a9.jpg,https://sobakevi4.ru/wp-content/uploads/2020/10/56541b222ea95.jpg,https://petguru.ru/wp-content/uploads/2018/08/royal_poodle_5.jpg}
\.


--
-- Data for Name: purposescounter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purposescounter (purpose, number_of) FROM stdin;
Fighting	0
Service	2
Hunting	3
Pastoral	2
Decorative	2
Companion	6
\.


--
-- Data for Name: shelterdogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelterdogs (id, name, breed, age, vaccinations, shelter_name, gender, full_description, weight, height, photo) FROM stdin;
9	Филя	Дворняжка	1	{Стерелизован,"Полная Вакцинация"}	Сострадание	male	Филя - прекрасная собака для семьи! Она полна любви и практически всегда пребывает в хорошем настроении. С ней очень легко общаться. Филя дружелюбна, игрива, легко поддается дрессировке, ей очень нравится взаимодействовать с человеком и выполнять команды. Филя - настоящий компаньон! Она запросто заводит дружбу как с людьми, так и с другими животными. Умеет подстраиваться под настроение человека и его привычки. Очень любит детей и умеет с ними общаться.	10	50	http://forum.sostradanie-nn.ru/bb-templates/kakumei/include/uploads/temp/6229ccca548f1.jpg
\.


--
-- Data for Name: shelters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelters (shelter_name, shelter_location, phone_number, dogs_counter, link_on_site) FROM stdin;
Сострадание	Бурнаковский Проезд 16	+78312162162	1	http://sostradanie-nn.ru/
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (nickname, email, password, city) FROM stdin;
Yoko	yoko.owner@mail.ru	OchenSlojnei_Parole	Нижний Новгород
\.


--
-- Name: shelterdogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelterdogs_id_seq', 9, true);


--
-- Name: dogs dogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dogs
    ADD CONSTRAINT dogs_pkey PRIMARY KEY (breed);


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
-- Name: dogs purps_decrease_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER purps_decrease_trigger BEFORE DELETE ON public.dogs FOR EACH ROW EXECUTE FUNCTION public.decrease_purps_amount();


--
-- Name: dogs purps_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER purps_trigger AFTER INSERT ON public.dogs FOR EACH ROW EXECUTE FUNCTION public.update_purps_amount();


--
-- Name: shelterdogs fk_breed_photos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs
    ADD CONSTRAINT fk_breed_photos FOREIGN KEY (shelter_name) REFERENCES public.shelters(shelter_name);


--
-- PostgreSQL database dump complete
--

