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
DELETE FROM dog_purpose WHERE dog_purpose.breed = OLD.breed;
FOR purp_num IN 1 .. array_length(OLD.purposes, 1)
LOOP
UPDATE purposes
SET number_of = number_of -1
WHERE OLD.purposes[purp_num] = purposes.purpose;
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
DECLARE cur_id INT;
BEGIN
FOR purp_num IN 1 .. array_length(NEW.purposes, 1)
LOOP
cur_id:=(SELECT id FROM purposes WHERE NEW.purposes[purp_num] = purposes.purpose);
INSERT INTO dog_purpose (breed, id_purpose) VALUES (NEW.breed, cur_id);
UPDATE purposes
SET number_of = number_of +1
WHERE NEW.purposes[purp_num] = purposes.purpose;
END LOOP;
return NEW;
END;
$$;


ALTER FUNCTION public.update_purps_amount() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dog_purpose; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dog_purpose (
    id bigint NOT NULL,
    breed character varying(30) NOT NULL,
    id_purpose integer
);


ALTER TABLE public.dog_purpose OWNER TO postgres;

--
-- Name: dog_purpose_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dog_purpose_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dog_purpose_id_seq OWNER TO postgres;

--
-- Name: dog_purpose_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dog_purpose_id_seq OWNED BY public.dog_purpose.id;


--
-- Name: dogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dogs (
    breed character varying(50) NOT NULL,
    main_photo text,
    purposes character varying(30)[],
    full_description text,
    main_characteristics character varying(40)[],
    size character varying(15),
    weight_border1 integer,
    weight_border2 integer,
    height_male integer,
    height_female integer,
    max_life_duration integer
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
-- Name: purposes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purposes (
    id bigint NOT NULL,
    purpose character varying(30) NOT NULL,
    number_of integer DEFAULT 0
);


ALTER TABLE public.purposes OWNER TO postgres;

--
-- Name: purposes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purposes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purposes_id_seq OWNER TO postgres;

--
-- Name: purposes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purposes_id_seq OWNED BY public.purposes.id;


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
-- Name: dog_purpose id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dog_purpose ALTER COLUMN id SET DEFAULT nextval('public.dog_purpose_id_seq'::regclass);


--
-- Name: purposes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purposes ALTER COLUMN id SET DEFAULT nextval('public.purposes_id_seq'::regclass);


--
-- Name: shelterdogs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs ALTER COLUMN id SET DEFAULT nextval('public.shelterdogs_id_seq'::regclass);


--
-- Data for Name: dog_purpose; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dog_purpose (id, breed, id_purpose) FROM stdin;
3	Алабай	1
4	Алабай	6
5	Австралийский хилер	5
6	Австралийский хилер	1
10	Американская акита	3
11	Американская акита	1
12	Аляскинский маламут	5
13	Аляскинский кли-кай	4
14	Аляскинский кли-кай	1
15	Американский булли	5
16	Американский булли	1
17	Американский бульдог	1
18	Американский бульдог	5
19	Американский голый терьер	1
20	Американский голый терьер	4
21	Американский кокер-спаниель	1
22	Американский кокер-спаниель	3
23	Амер-й стаффордширский терьер	1
24	Амер-й стаффордширский терьер	5
25	Английский бульдог	1
26	Английский бульдог	3
27	Английский кокер-спаниель	1
28	Английский кокер-спаниель	3
29	Английский мастиф	1
30	Английский мастиф	5
31	Английский пойнтер	3
32	Английский пойнтер	1
33	Английский сеттер	1
34	Английский сеттер	4
35	Английский сеттер	3
36	Аргентинский дог	3
37	Аргентинский дог	6
38	Афганская борзая	3
39	Афганская борзая	1
40	Аффенпинчер	4
41	Аффенпинчер	1
42	Басенджи	3
43	Басенджи	1
44	Бассет-хаунд	3
45	Бассет-хаунд	1
46	Бедлингтон-терьер	1
47	Бедлингтон-терьер	3
48	Белая швейцарская овчарка	1
49	Белая швейцарская овчарка	5
50	Белая швейцарская овчарка	2
51	Бельгийская овчарка	5
\.


--
-- Data for Name: dogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dogs (breed, main_photo, purposes, full_description, main_characteristics, size, weight_border1, weight_border2, height_male, height_female, max_life_duration) FROM stdin;
Австралийская овчарка	https://placepic.ru/wp-content/uploads/2019/07/merle-dog-long.jpg	{Service,Hunting,Pastoral}	Не собака - мечта	{"Очень преданная",Дружелюбная,"Подходит для охоты"}	Крупная	26	50	53	58	15
Акита-ину	https://lapkins.ru/upload/uf/78e/78e8b448a6ebc51f00d4f68203c82c9b.jpg	{Companion}	Японский балдёж, всем рекомендую	{"Высокий интеллект","Проживание вне дома","Подходит для охоты"}	Крупная	35	50	66	71	13
Пудель	https://lapkins.ru/upload/iblock/6e5/6e52cb986e51a236498ecb062598d8a9.jpg	{Hunting,Companion}	Кудрявенькая, выглядит забавно	{"Мало линяет",Дружелюбная,"Подходит для охоты","Хорошее послушание"}	Крупная	26	35	53	58	18
Немецкая овчарка	https://proprikol.ru/wp-content/uploads/2020/10/kartinki-nemeczkoj-ovcharki-1.jpg	{Service,Hunting,Pastoral}	Возможно именно она снималась в Мухтаре	{"Проживание вне дома","Очень преданная","Подходит для охоты","Хорошее послушание"}	Крупная	28	40	60	65	15
Пекинес	https://sobakevi4.ru/wp-content/uploads/2020/08/1.-pekines-imeet-drevnie-korni.jpg	{Decorative,Companion}	Лицо смешное	{"Мало лает","Отсутствует чувство страха","Очень преданная"}	Мелкая	6	10	53	58	16
Мальтипу	https://skstoit.ru/wp-content/uploads/2022/01/skolko-stoit-maltipu-1.jpg	{Decorative,Companion}	Маленькая, удобно брать с собой в кругосветное путешествие	{"Мало лает","Очень преданная"}	Мелкая	5	10	29	30	15
Чау-Чау	https://porodysobak.com/wp-content/uploads/2019/12/chow-chow_01_lg.jpg	{Companion}	Огромная и ласковая	{"Подходит для охраны","Очень преданная"}	Крупная	25	32	51	56	15
Шарпей	https://cat4you.ru/wp-content/uploads/b/5/b/b5bbf97fa1462f2353a229592ec0e7ea.jpeg	{Companion}	Похожа на Мишлен	{"Высокий интеллект","Подходит для охраны","Очень преданная"}	Средняя	11	25	50	52	11
Аляскинский маламут	https://gafki.ru/wp-content/uploads/2019/11/kartinka-1.-aljaskinskij-malamut.jpg	{Service}	Одна из древнейших пород, часто используется на крайнем севере для езды на санях. Отличается невероятной выносливостью, стойкостью, но также и ласковым характером и преданностью	{"Проживание вне дома",Дружелюбная,"Отличное здоровье"}	Крупная	34	38	64	58	16
Американский бульдог	https://natalyland.ru/wp-content/uploads/f/6/e/f6ea57d9e5b40b5ea5094a7e0566a819.jpeg	{Companion,Service}	Достаточно независимая и суровая порода, но при этом очень предана хозяину. Также очень спортивная и активная собака, подойдёт для хозяев со активным стилем жизни	{"Очень преданная","Хорошее послушание","Подходит для охраны","Отсутствует чувство страха",Дружелюбная}	Крупная	32	54	70	65	15
Аффенпинчер	https://for-pet.ru/wp-content/uploads/2020/04/s1200-10.jpg	{Decorative,Companion}	Эта небольшая и крайне милая порода первоначально была выведена для охоты на грызунов. Но из-за своей привлекательной внешности сегодня активно используется, как комапаньон и верный друг	{"Отличное здоровье",Любопытная}	Мелкая	4	6	30	25	14
Американский кокер-спаниель	https://lapkins.ru/upload/iblock/20b/20b0a72e3b205620b88ec831b2701c21.jpg	{Companion,Hunting}	Является прямым потомком английского кокер-спаниеля, является по сути собакой-комапьном с очень дружелюбным и спокойным характером. Но охотничьи корни дают о себе знать, и это выливается в неиссекаемую энергию и хорошую сообразительность	{"Очень преданная","Хорошее послушание","Подходит для охоты",Дружелюбная}	Средняя	8	15	39	36	16
Амер-й стаффордширский терьер	https://klkfavorit.ru/wp-content/uploads/c/b/f/cbf1595f0e634bfe534f30b1a32342b6.jpeg	{Companion,Service}	Является универсальной породой, сочетает в себе любовь и смелость, храбрость и расссудительность, игривость и способность к дрессировке	{"Очень преданная","Хорошее послушание","Подходит для охраны","Отсутствует чувство страха","Высокий интеллект","Мало линяет",Игривая}	Крупная	25	30	48	46	12
Английский пойнтер	https://prosobak.net/wp-content/uploads/2019/11/http-mysocialpet-it-files-large-f63a3ee6bc4a185.jpeg	{Hunting,Companion}	Популярная охотничья порода, также отличается спокойным и дружелюбным характером. Английский пойнтер всеми силами старается угодить хозяину. Собака послушная, добрая, легко обучается	{"Очень преданная","Хорошее послушание","Отличное здоровье","Подходит для охоты",Дружелюбная,Энергичная}	Крупная	25	34	69	66	17
Аргентинский дог	https://sobakevi4.ru/wp-content/uploads/2020/08/1-vneshnij-vid-argentinskogo-doga.jpg	{Hunting,Fighting}	Это порода была выведена в Аргентине и предназначалась для охоты на крупных хищников: ягуары, кабаны и т.д. Эта порода выделяется своей энергичностью, силой и выносливостью	{Энергичная,"Подходит для охоты"}	Крупная	40	45	68	65	15
Белая швейцарская овчарка	https://infodog.ru/wp-content/uploads/2020/07/belaya_shveytsarskaya_ovcharka1.jpg	{Companion,Service,Pastoral}	Дружелюбие, чувствительность к настроению хозяина и тактичность - вот основные черты данной породы. Кроме того, выделяется то, что собаки данной породы гораздо комфортнее себя чувствуют на природе, поэтому этих собак часто используют, как пастушьих	{"Очень преданная","Хорошее послушание","Подходит для охраны","Проживание вне дома"}	Крупная	25	40	66	60	14
Американская акита	https://natalyland.ru/wp-content/uploads/b/8/d/b8de01403ab96cb715a1b0c823381edf.jpeg	{Hunting,Companion}	Молодая порода, была выведена достаточно недавно. Несмотря на название выведена она была в горных районах Японии. Является хорошим охранником, но также очень дружелюбна и может быть отличным компаньоном	{"Подходит для охраны",Дружелюбная}	Очень крупная	45	65	71	66	14
Бельгийская овчарка	https://sobakevi4.ru/wp-content/uploads/2020/08/15e8e436c9a167d476b7385e230a8d9b-1024x683.jpg	{Service}	Прирождённый защитник - это звание, поределённо, про эту породу. Отличается умом и сообразительностью, отлично поддаётся дрессировке	{"Очень преданная","Подходит для охраны","Высокий интеллект"}	Крупная	25	30	62	58	12
Австралийский хилер	https://cat4you.ru/wp-content/uploads/c/a/5/ca538b532174b0e1eecf4781d6f0cc8b.jpeg	{Service,Companion}	Австралийская пастушья собака - порода произошла от скрещивания голубо-мраморных гладкошерстных колли с дикой собакой динго. Отличается высоким интеллектом и преданностью. Хорошо справляется с охранной скота и крайне преспособлена к жизни вне дома	{"Очень преданная","Подходит для охраны","Высокий интеллект","Проживание вне дома"}	Средняя	11	25	51	44	15
Аляскинский кли-кай	https://images.prismic.io/doge/41207b8d-4b3a-4160-a7ed-2e54985ab071_2.jpg	{Decorative,Companion}	Аляскинский кли-кай – миниатюрная альтернатива сибирской хаски, которая позаимствовала от нее уникальную красоту, активный и дружелюбный нрав, любовь, верность и преданность человеку.	{"Хорошее послушание","Высокий интеллект"}	Мелкая	7	10	45	38	15
Американский голый терьер	https://zooblog.ru/wp-content/uploads/2021/08/picture-35.jpeg	{Companion,Decorative}	Свовсем новая порода вывеенная в 1972 году, но уже завоевавшая сердца многих людей своей преданностью, жизнарадостностью и способностью к обучению	{"Хорошее послушание","Отличное здоровье","Мало линяет",Дружелюбная}	Мелкая	3	7	45	35	16
Американский булли	https://natalyland.ru/wp-content/uploads/6/e/c/6ec3dedf2abc42db83722a94d811494f.jpeg	{Service,Companion}	Американский булли – молодая порода, которую уже успели полюбить собаководы за ее грозный вид в сочетании с ласковым характером. Внешний вид действительно не слишком коррелирует с внутренним мироустройством собаки, при добром и заботливом отношении собака станет для вашей семья отличным питомцем	{"Подходит для охраны",Дружелюбная}	Средняя	30	58	57	40	14
Английский кокер-спаниель	https://sobakevi4.ru/wp-content/uploads/2020/08/8cd4f2f088ee4dda1587643b2ee471a9.jpg	{Companion,Hunting}	Спортивный и энергичный пёс с начальным охотничьим назначением, но в наши дни их всё чаще используют, как верного компаьона и друга семьи	{"Очень преданная","Хорошее послушание","Подходит для охоты",Дружелюбная,Энергичная}	Средняя	14	15	40	38	14
Афганская борзая	https://www.kudatotam.ru/upload/000/u0/8/6/32998f8c.jpg	{Hunting,Companion}	Афганская борзая- активная и общительная собака. Представители этой породы дружелюбные, подвижные, отличаются преданностью жизнерадостностью. Также выделяется своенравностью, из-за чего достаточно трудно поддаётся дрессировке	{"Очень преданная",Длинношёрстныя,"Подходит для охоты",Дружелюбная}	Средняя	23	27	73	70	14
Английский мастиф	https://cat4you.ru/wp-content/uploads/1/b/6/1b6cb232298236b77c02eb062e1a7162.jpeg	{Companion,Service}	Медлительные и добродушные, невероятно преданы к своим хозяевам. Предпочитает длительный сон активной игре. Крайне своенравна, если её правильно не воспитать	{"Очень преданная","Подходит для охраны","Проживание вне дома",Дружелюбная,Спокойная}	Очень крупная	70	85	79	65	10
Английский бульдог	https://lapkins.ru/upload/uf/7db/7db4dd21e7b9c0b3bf0f589d63d855d6.jpg	{Companion,Hunting}	Мощная и мускулистая собака с добрым сердцем - станет вам надёжным защитникоми и верным другом. Собаки такой породы обладают неимоверным терпением, добротой и огромной любовью к детям.	{"Очень преданная","Хорошее послушание","Высокий интеллект",Дружелюбная,Спокойная}	Средняя	20	25	42	36	10
Английский сеттер	https://fun-cats.ru/wp-content/uploads/a/4/1/a4119b6284a77a1fde95b3199044a46b.jpeg	{Companion,Decorative,Hunting}	Данную породу порой называют настоящими аристократыми, и это от части является правдой, так как в их характере присутствуют черты членов элитарного общества. Но не дайте этому факту ввести вас в заблуждение, при всей своей аристократичности данная порода считается крайне дружелюбной и преданной	{"Очень преданная","Хорошее послушание","Высокий интеллект","Подходит для охоты",Дружелюбная,Спокойная}	Крупная	20	35	67	62	13
Бассет-хаунд	https://glorypets.ru/wp-content/uploads/2020/06/4-basset-haund-priznannyj-dolgozhitel.jpg	{Hunting,Companion}	Необычная внешность -это то, что чаще всего привлекает людей в этой породе, но многие не знают, что эта древняя охотничья порода из Франции также отличается добродушным и общительным характером. Короткие лапы никак не мешают быть этим собакам отличными охотниками, наоброт это даёт им огромное преимущество при исследовании лисьих и кроличьих нор	{"Очень преданная","Подходит для охоты",Дружелюбная,Лопоухая}	Средняя	18	30	38	35	15
Басенджи	https://avatars.mds.yandex.net/get-zen_doc/1722013/pub_6128ee809f19a0079759bee4_6128ef050773bb314a8d4147/scale_1200	{Hunting,Companion}	Басенджи - одна из древнейших пород и её повадки формировались годами в дикой природе совершенно без участия человека, но несмотря на это одной из основных черт этой собаки явлется преданность своему хозяину	{"Очень преданная","Мало лает","Подходит для охоты",Дружелюбная,Тихая}	Мелкая	10	12	46	43	14
Алабай	https://sobakemozhno.ru/wp-content/uploads/2020/11/alabaj-ili-sredneaziatskaja-ovcharka-21-1024x679.jpg	{Companion,Fighting}	Алабай - среднеазиатская овчарка, изначально выведенная в качестве сторожевой и пастушьей собаки. Считается одной из самых древних пород, имеет огромные размеры и относится к самым сильным и выносливым псамам. Порода обладает ярко выраженными инстинктами охранника и бесстрашного защитника. Ее характерным признаком является независимость практически во всех поведенческих реакциях.	{"Очень преданная",Дружелюбная,"Хорошее послушание"}	Очень крупная	40	50	70	65	12
Дворняжка	https://ferret-pet.ru/wp-content/uploads/3/6/0/360b8716727a6e66f371f10b1c6e2264.jpeg	{Companion}	Генетика свободно размножающихся собак представляет интерес для исследователей, так как история современных пород насчитывает как максимум несколько сотен лет; бутылочные горлышки разведения собак приводят к увеличению неравновесного сцепления генов и препятствуют восстановлению истории развития собак. Исследование генома свободно размножающихся беспородных собак в Евразии выявило отличия, свидетельствующие об их отдельной эволюции; они не представляют собой результат беспорядочного скрещивания чистопородных собак.	{"Очень преданная","Подходит для охраны"}	Средняя	20	38	30	45	16
Бедлингтон-терьер	https://avatars.mds.yandex.net/get-zen_doc/1879615/pub_5cd7e7e86f167700ae3e290d_5cd7fd4364d6ee00aeac620e/scale_1200	{Companion,Hunting}	Собаки данной породы часто встречаются на выставках и спортивных турнирах проводимых среди собак и часто отличается призовыми местами благодаря своей выносливости и высокому интеллекту. Легко поддаётся обучению и дрессировке	{"Очень преданная","Хорошее послушание","Высокий интеллект","Подходит для охоты",Дружелюбная}	Мелкая	8	10	45	37	14
\.


--
-- Data for Name: photogallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photogallery (breed, photos) FROM stdin;
Џг¤Ґ«м	{https://sobakevi4.ru/wp-content/uploads/2020/08/1.-pekines-imeet-drevnie-korni.jpg}
Пудель	{https://lapkins.ru/upload/iblock/6e5/6e52cb986e51a236498ecb062598d8a9.jpg,https://sobakevi4.ru/wp-content/uploads/2020/10/56541b222ea95.jpg,https://petguru.ru/wp-content/uploads/2018/08/royal_poodle_5.jpg}
\.


--
-- Data for Name: purposes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purposes (id, purpose, number_of) FROM stdin;
6	Fighting	2
4	Decorative	6
3	Hunting	14
1	Companion	26
2	Pastoral	3
5	Service	10
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
-- Name: dog_purpose_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dog_purpose_id_seq', 51, true);


--
-- Name: purposes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purposes_id_seq', 6, true);


--
-- Name: shelterdogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelterdogs_id_seq', 9, true);


--
-- Name: dog_purpose dog_purpose_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dog_purpose
    ADD CONSTRAINT dog_purpose_pkey PRIMARY KEY (id);


--
-- Name: dogs dogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dogs
    ADD CONSTRAINT dogs_pkey PRIMARY KEY (breed);


--
-- Name: purposes purposes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purposes
    ADD CONSTRAINT purposes_pkey PRIMARY KEY (id);


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
-- Name: shelterdogs fk_breed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs
    ADD CONSTRAINT fk_breed FOREIGN KEY (breed) REFERENCES public.dogs(breed);


--
-- Name: shelterdogs fk_breed_photos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelterdogs
    ADD CONSTRAINT fk_breed_photos FOREIGN KEY (shelter_name) REFERENCES public.shelters(shelter_name);


--
-- Name: dog_purpose pk_purpose_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dog_purpose
    ADD CONSTRAINT pk_purpose_id FOREIGN KEY (id_purpose) REFERENCES public.purposes(id);


--
-- PostgreSQL database dump complete
--

