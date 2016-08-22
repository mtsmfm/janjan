--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: winds; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE winds AS ENUM (
    'east',
    'south',
    'west',
    'north'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE games (
    id integer NOT NULL,
    room_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: joins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE joins (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    room_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: joins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE joins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: joins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE joins_id_seq OWNED BY joins.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rooms (
    id integer NOT NULL,
    joins_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- Name: scenes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scenes (
    id integer NOT NULL,
    game_id integer NOT NULL,
    data bytea,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: scenes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE scenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE scenes_id_seq OWNED BY scenes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY joins ALTER COLUMN id SET DEFAULT nextval('joins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY scenes ALTER COLUMN id SET DEFAULT nextval('scenes_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: joins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY joins
    ADD CONSTRAINT joins_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: scenes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scenes
    ADD CONSTRAINT scenes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_games_on_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_games_on_room_id ON games USING btree (room_id);


--
-- Name: index_joins_on_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_joins_on_room_id ON joins USING btree (room_id);


--
-- Name: index_joins_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_joins_on_user_id ON joins USING btree (user_id);


--
-- Name: index_scenes_on_game_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scenes_on_game_id ON scenes USING btree (game_id);


--
-- Name: fk_rails_6d63773b7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scenes
    ADD CONSTRAINT fk_rails_6d63773b7b FOREIGN KEY (game_id) REFERENCES games(id);


--
-- Name: fk_rails_85ae8f2798; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY joins
    ADD CONSTRAINT fk_rails_85ae8f2798 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_8e87537561; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY joins
    ADD CONSTRAINT fk_rails_8e87537561 FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- Name: fk_rails_b22253b79a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY games
    ADD CONSTRAINT fk_rails_b22253b79a FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20151013124540');


