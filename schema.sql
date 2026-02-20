--
-- PostgreSQL database dump
--

\restrict 5MmK7XaXagIqdgl4fr3fROPRVhd4OCoOSIER21VJGE77uvaZyj41iGeYs5n103s

-- Dumped from database version 18.1 (Postgres.app)
-- Dumped by pg_dump version 18.1 (Postgres.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: danagallo
--

CREATE TABLE public.messages (
    message_id integer NOT NULL,
    sender_user_id integer NOT NULL,
    receiver_user_id integer NOT NULL,
    message text NOT NULL,
    timestamp integer NOT NULL
);


ALTER TABLE public.messages OWNER TO danagallo;

--
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: danagallo
--

CREATE SEQUENCE public.messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_message_id_seq OWNER TO danagallo;

--
-- Name: messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danagallo
--

ALTER SEQUENCE public.messages_message_id_seq OWNED BY public.messages.message_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: danagallo
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO danagallo;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: danagallo
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO danagallo;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danagallo
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: messages message_id; Type: DEFAULT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.messages ALTER COLUMN message_id SET DEFAULT nextval('public.messages_message_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: messages messages_receiver_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_user_id_fkey FOREIGN KEY (receiver_user_id) REFERENCES public.users(user_id);


--
-- Name: messages messages_sender_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danagallo
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_user_id_fkey FOREIGN KEY (sender_user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5MmK7XaXagIqdgl4fr3fROPRVhd4OCoOSIER21VJGE77uvaZyj41iGeYs5n103s

