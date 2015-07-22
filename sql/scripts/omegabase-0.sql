





SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;




SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


CREATE TABLE access_log (
    id integer NOT NULL,
    action character varying(30),
    date timestamp with time zone,
    ip character varying(30),
    "user" integer,
    "table" character varying(30),
    table_id integer,
    hostname character varying(300)
);




CREATE SEQUENCE access_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE access_log_id_seq OWNED BY access_log.id;



CREATE TABLE category (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    active boolean
);




CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE category_id_seq OWNED BY category.id;



CREATE TABLE configuration (
    anonymous_can_use boolean,
    anonymous_can_inscribe boolean,
    anonymous_group integer,
    anonymous_inscribe_group integer,
    id integer NOT NULL
);




CREATE SEQUENCE configuration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE configuration_id_seq OWNED BY configuration.id;



CREATE TABLE document (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    date_creation timestamp without time zone NOT NULL,
    date_modification timestamp without time zone NOT NULL,
    texthtml text NOT NULL,
    id_category integer,
    active boolean,
    num_accesses integer,
    isrichtext boolean,
    id_owner integer,
    status character(1),
    keywords tsvector
);




CREATE SEQUENCE document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE document_id_seq OWNED BY document.id;



CREATE TABLE editor (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    id_group integer NOT NULL,
    login character varying(128) NOT NULL,
    password text,
    active boolean DEFAULT true
);




CREATE SEQUENCE editor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE editor_id_seq OWNED BY editor.id;



CREATE TABLE embedded (
    id integer NOT NULL,
    x integer,
    y integer,
    w integer,
    h integer,
    id_document integer
);




CREATE SEQUENCE embedded_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE embedded_id_seq OWNED BY embedded.id;



CREATE TABLE file_blob (
    id integer NOT NULL,
    name character varying(200),
    date timestamp without time zone,
    id_document integer,
    blob bytea,
    folder character varying(200),
    keywords tsvector
);




CREATE SEQUENCE file_blob_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE file_blob_id_seq OWNED BY file_blob.id;



CREATE TABLE "group" (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    perm_administrator_groups boolean,
    perm_administrator_users boolean,
    active boolean DEFAULT true
);




CREATE TABLE group_category (
    id_group integer NOT NULL,
    id_category integer NOT NULL,
    level_priviledge integer
);




CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE group_id_seq OWNED BY "group".id;



CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE logs_id_seq OWNED BY access_log.id;



CREATE TABLE object (
    id integer NOT NULL,
    type integer,
    id_embeb integer,
    x integer,
    y integer,
    width integer,
    height integer,
    text character varying(1000),
    info character varying(10000)
);




CREATE SEQUENCE object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE object_id_seq OWNED BY object.id;



ALTER TABLE ONLY access_log ALTER COLUMN id SET DEFAULT nextval('access_log_id_seq'::regclass);



ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);



ALTER TABLE ONLY configuration ALTER COLUMN id SET DEFAULT nextval('configuration_id_seq'::regclass);



ALTER TABLE ONLY document ALTER COLUMN id SET DEFAULT nextval('document_id_seq'::regclass);



ALTER TABLE ONLY editor ALTER COLUMN id SET DEFAULT nextval('editor_id_seq'::regclass);



ALTER TABLE ONLY embedded ALTER COLUMN id SET DEFAULT nextval('embedded_id_seq'::regclass);



ALTER TABLE ONLY file_blob ALTER COLUMN id SET DEFAULT nextval('file_blob_id_seq'::regclass);



ALTER TABLE ONLY "group" ALTER COLUMN id SET DEFAULT nextval('group_id_seq'::regclass);



ALTER TABLE ONLY object ALTER COLUMN id SET DEFAULT nextval('object_id_seq'::regclass);



ALTER TABLE ONLY category
    ADD CONSTRAINT categorypk PRIMARY KEY (id);



ALTER TABLE ONLY configuration
    ADD CONSTRAINT configurationpk PRIMARY KEY (id);



ALTER TABLE ONLY embedded
    ADD CONSTRAINT embeddedpk PRIMARY KEY (id);



ALTER TABLE ONLY editor
    ADD CONSTRAINT engineerpk PRIMARY KEY (id);



ALTER TABLE ONLY file_blob
    ADD CONSTRAINT file_blobpk PRIMARY KEY (id);



ALTER TABLE ONLY group_category
    ADD CONSTRAINT group_categorypk PRIMARY KEY (id_group, id_category);



ALTER TABLE ONLY "group"
    ADD CONSTRAINT grouppk PRIMARY KEY (id);



ALTER TABLE ONLY access_log
    ADD CONSTRAINT logpk PRIMARY KEY (id);



ALTER TABLE ONLY document
    ADD CONSTRAINT mappk PRIMARY KEY (id);



ALTER TABLE ONLY object
    ADD CONSTRAINT objectpk PRIMARY KEY (id);



CREATE INDEX document_idx ON document USING gin (keywords);



CREATE INDEX editoridx1 ON editor USING btree (login);



CREATE INDEX file_blob_idx1 ON file_blob USING btree (id_document);



CREATE INDEX fki_documentfk1 ON document USING btree (id_category);



ALTER TABLE ONLY configuration
    ADD CONSTRAINT configurationfk1 FOREIGN KEY (anonymous_group) REFERENCES "group"(id);



ALTER TABLE ONLY configuration
    ADD CONSTRAINT configurationfk2 FOREIGN KEY (anonymous_inscribe_group) REFERENCES "group"(id);



ALTER TABLE ONLY document
    ADD CONSTRAINT documentfk1 FOREIGN KEY (id_category) REFERENCES category(id);



ALTER TABLE ONLY document
    ADD CONSTRAINT documentfk2 FOREIGN KEY (id_owner) REFERENCES editor(id);



ALTER TABLE ONLY editor
    ADD CONSTRAINT editorfk1 FOREIGN KEY (id_group) REFERENCES "group"(id);



ALTER TABLE ONLY embedded
    ADD CONSTRAINT embeddedfk1 FOREIGN KEY (id_document) REFERENCES document(id);



ALTER TABLE ONLY file_blob
    ADD CONSTRAINT file_blobfk1 FOREIGN KEY (id_document) REFERENCES document(id);



ALTER TABLE ONLY group_category
    ADD CONSTRAINT group_categoryfk1 FOREIGN KEY (id_category) REFERENCES category(id);



ALTER TABLE ONLY group_category
    ADD CONSTRAINT group_categoryfk2 FOREIGN KEY (id_group) REFERENCES "group"(id);



ALTER TABLE ONLY object
    ADD CONSTRAINT objectfk1 FOREIGN KEY (id_embeb) REFERENCES embedded(id);



REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


insert into "configuration"
( anonymous_can_use,
  anonymous_can_inscribe,
  anonymous_group,
  anonymous_inscribe_group,
  id
) values (
false,
false,
null,
null,
1);


insert into "group" (
id,
  "name",
  perm_administrator_groups,
  perm_administrator_users,
  active

) values (
nextval('group_id_seq'),
'Administrators',
true,
true,
true);




insert into editor (
 id,
 "name",
  id_group,
  "login",
  "password",
  active

 ) values (
  nextval('editor_id_seq'),
  'Administrator',
  1,
  'administrator',
  md5('changeit'),
  true);




insert into category(
id, "name", active)
values (nextval('category_id_seq'), 'Category 1', true);



insert into group_category (
id_group, id_category, level_priviledge)
values (1, 1, 3);



