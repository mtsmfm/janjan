--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: seat_position; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE seat_position AS ENUM (
    'east',
    'south',
    'west',
    'north'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    round_id integer NOT NULL,
    type character varying NOT NULL,
    tile_id integer,
    seat_id integer,
    base_point integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- Name: fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fields (
    id integer NOT NULL,
    round_id integer NOT NULL,
    seat_id integer,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fields_id_seq OWNED BY fields.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: joins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: rooms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rooms (
    id integer NOT NULL,
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
-- Name: rounds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rounds (
    id integer NOT NULL,
    game_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rounds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rounds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rounds_id_seq OWNED BY rounds.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: seats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seats (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    game_id integer NOT NULL,
    "position" seat_position NOT NULL,
    point integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: seats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seats_id_seq OWNED BY seats.id;


--
-- Name: tiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tiles (
    id integer NOT NULL,
    field_id integer NOT NULL,
    kind character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tiles_id_seq OWNED BY tiles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fields ALTER COLUMN id SET DEFAULT nextval('fields_id_seq'::regclass);


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

ALTER TABLE ONLY rounds ALTER COLUMN id SET DEFAULT nextval('rounds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY seats ALTER COLUMN id SET DEFAULT nextval('seats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tiles ALTER COLUMN id SET DEFAULT nextval('tiles_id_seq'::regclass);


--
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: joins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY joins
    ADD CONSTRAINT joins_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rounds
    ADD CONSTRAINT rounds_pkey PRIMARY KEY (id);


--
-- Name: seats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (id);


--
-- Name: tiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tiles
    ADD CONSTRAINT tiles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_actions_on_round_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_actions_on_round_id ON actions USING btree (round_id);


--
-- Name: index_fields_on_round_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fields_on_round_id ON fields USING btree (round_id);


--
-- Name: index_fields_on_seat_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fields_on_seat_id ON fields USING btree (seat_id);


--
-- Name: index_games_on_room_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_games_on_room_id ON games USING btree (room_id);


--
-- Name: index_joins_on_room_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_joins_on_room_id ON joins USING btree (room_id);


--
-- Name: index_joins_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_joins_on_user_id ON joins USING btree (user_id);


--
-- Name: index_rounds_on_game_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rounds_on_game_id ON rounds USING btree (game_id);


--
-- Name: index_seats_on_game_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seats_on_game_id ON seats USING btree (game_id);


--
-- Name: index_seats_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seats_on_user_id ON seats USING btree (user_id);


--
-- Name: index_tiles_on_field_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tiles_on_field_id ON tiles USING btree (field_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_096a2efd02; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tiles
    ADD CONSTRAINT fk_rails_096a2efd02 FOREIGN KEY (field_id) REFERENCES fields(id);


--
-- Name: fk_rails_129ebf637f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_129ebf637f FOREIGN KEY (tile_id) REFERENCES tiles(id);


--
-- Name: fk_rails_1bfa43d13c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_1bfa43d13c FOREIGN KEY (seat_id) REFERENCES seats(id);


--
-- Name: fk_rails_5a07ad9e8e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fields
    ADD CONSTRAINT fk_rails_5a07ad9e8e FOREIGN KEY (seat_id) REFERENCES seats(id);


--
-- Name: fk_rails_7427b8435c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT fk_rails_7427b8435c FOREIGN KEY (round_id) REFERENCES rounds(id);


--
-- Name: fk_rails_7812c1b477; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rounds
    ADD CONSTRAINT fk_rails_7812c1b477 FOREIGN KEY (game_id) REFERENCES games(id);


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
-- Name: fk_rails_e3a41da4fd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fields
    ADD CONSTRAINT fk_rails_e3a41da4fd FOREIGN KEY (round_id) REFERENCES rounds(id);


--
-- Name: fk_rails_fa444e0ac6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT fk_rails_fa444e0ac6 FOREIGN KEY (game_id) REFERENCES games(id);


--
-- Name: fk_rails_ff1a0875e3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT fk_rails_ff1a0875e3 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20151013124540');

