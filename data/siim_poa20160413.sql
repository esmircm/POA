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
-- Name: poa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA poa;


ALTER SCHEMA poa OWNER TO postgres;

SET search_path = poa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acciones; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE acciones (
    id_accion integer NOT NULL,
    nombre_accion character varying(500) NOT NULL,
    fk_unidad_medida integer NOT NULL,
    cantidad integer NOT NULL,
    fk_ambito integer NOT NULL,
    fk_poa integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    bien_servicio character varying(200)
);


ALTER TABLE poa.acciones OWNER TO postgres;

--
-- Name: acciones_id_accion_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE acciones_id_accion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.acciones_id_accion_seq OWNER TO postgres;

--
-- Name: acciones_id_accion_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE acciones_id_accion_seq OWNED BY acciones.id_accion;


--
-- Name: actividades; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE actividades (
    id_actividades integer NOT NULL,
    actividad character varying(200),
    fk_unidad_medida integer NOT NULL,
    cantidad integer,
    fk_accion integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE poa.actividades OWNER TO postgres;

--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE actividades_id_actividades_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.actividades_id_actividades_seq OWNER TO postgres;

--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE actividades_id_actividades_seq OWNED BY actividades.id_actividades;


--
-- Name: comentarios; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE comentarios (
    id_comentarios integer NOT NULL,
    comentarios character varying(1000),
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_poa integer NOT NULL,
    fk_tipo_entidad integer NOT NULL
);


ALTER TABLE poa.comentarios OWNER TO postgres;

--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE comentarios_id_comentarios_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.comentarios_id_comentarios_seq OWNER TO postgres;

--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE comentarios_id_comentarios_seq OWNED BY comentarios.id_comentarios;


--
-- Name: estatus_poa; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE estatus_poa (
    id_estatus_poa integer NOT NULL,
    fk_estatus_poa integer NOT NULL,
    fk_poa integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_tipo_entidad integer NOT NULL
);


ALTER TABLE poa.estatus_poa OWNER TO postgres;

--
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE estatus_poa_id_estatus_poa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.estatus_poa_id_estatus_poa_seq OWNER TO postgres;

--
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE estatus_poa_id_estatus_poa_seq OWNED BY estatus_poa.id_estatus_poa;


--
-- Name: maestro; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE maestro (
    id_maestro integer NOT NULL,
    descripcion character varying(1000),
    padre integer NOT NULL,
    hijo integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE poa.maestro OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE maestro_id_maestro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.maestro_id_maestro_seq OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE maestro_id_maestro_seq OWNED BY maestro.id_maestro;


--
-- Name: poa; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE poa (
    id_poa integer NOT NULL,
    nombre character varying(700) NOT NULL,
    fk_tipo_poa integer NOT NULL,
    obj_historico character varying(800),
    obj_estrategico character varying(800),
    obj_general character varying(800) NOT NULL,
    obj_institucional character varying(800),
    descripcion character varying(800),
    fecha_inicio timestamp without time zone,
    fecha_final timestamp without time zone,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_unidad_medida integer,
    cantidad integer
);


ALTER TABLE poa.poa OWNER TO postgres;

--
-- Name: poa_id_poa_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE poa_id_poa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.poa_id_poa_seq OWNER TO postgres;

--
-- Name: poa_id_poa_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE poa_id_poa_seq OWNED BY poa.id_poa;


--
-- Name: rendimiento; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE rendimiento (
    id_rendimiento integer NOT NULL,
    fk_meses integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    cantidad_cumplida integer,
    cantidad_programada integer NOT NULL,
    fk_tipo_entidad integer NOT NULL,
    id_entidad integer NOT NULL
);


ALTER TABLE poa.rendimiento OWNER TO postgres;

--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE rendimiento_id_rendimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.rendimiento_id_rendimiento_seq OWNER TO postgres;

--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE rendimiento_id_rendimiento_seq OWNED BY rendimiento.id_rendimiento;


--
-- Name: responsable; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE responsable (
    id_responsable integer NOT NULL,
    fk_persona_registro integer NOT NULL,
    fk_dir_responsable integer NOT NULL,
    fk_poa integer NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_estatus integer NOT NULL,
    cod_dependencia_cruge integer NOT NULL,
    dependencia_cruge character varying(200) NOT NULL
);


ALTER TABLE poa.responsable OWNER TO postgres;

--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE responsable_id_responsable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.responsable_id_responsable_seq OWNER TO postgres;

--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE responsable_id_responsable_seq OWNED BY responsable.id_responsable;


--
-- Name: vsw_acciones; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_acciones AS
 SELECT ac.id_accion,
    ac.nombre_accion,
    ac.fk_unidad_medida,
    mt.descripcion AS unidad_medida,
    ac.fk_ambito,
    am.descripcion AS ambito,
    ac.bien_servicio,
    ac.cantidad,
    ac.fk_poa
   FROM ((acciones ac
     LEFT JOIN maestro mt ON ((mt.id_maestro = ac.fk_unidad_medida)))
     LEFT JOIN maestro am ON ((am.id_maestro = ac.fk_ambito)))
  ORDER BY ac.id_accion;


ALTER TABLE poa.vsw_acciones OWNER TO postgres;

--
-- Name: vsw_actividades; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_actividades AS
 SELECT act.id_actividades,
    act.actividad,
    act.cantidad,
    act.fk_unidad_medida,
    pr.descripcion AS unidad_medida,
    acc.id_accion AS fk_accion,
    acc.fk_poa
   FROM ((actividades act
     LEFT JOIN maestro pr ON ((pr.id_maestro = act.fk_unidad_medida)))
     LEFT JOIN acciones acc ON ((acc.id_accion = act.fk_accion)))
  ORDER BY act.id_actividades;


ALTER TABLE poa.vsw_actividades OWNER TO postgres;

--
-- Name: vsw_admin; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE vsw_admin (
    id_poa integer,
    nombre character varying(700),
    cod_dependencia_cruge integer,
    dependencia_cruge character varying(200),
    fk_estatus_poa integer,
    descripcion character varying(1000),
    fk_tipo_poa integer,
    tipo_poa character varying(1000),
    anio double precision
);


ALTER TABLE poa.vsw_admin OWNER TO postgres;

--
-- Name: vsw_pdf_proyecto; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_pdf_proyecto AS
 SELECT pa.id_poa,
    pa.nombre AS nombre_proyecto,
    acc.nombre_accion,
    pa.obj_general AS objetivo_general,
    pa.obj_historico AS objetivo_historico,
    acc.fk_unidad_medida,
    ms.descripcion AS unidad_medida,
    act.actividad,
    act.fk_unidad_medida AS unidad_actividad,
    ms2.descripcion AS unidad_actividades,
    res.dependencia_cruge AS unidad_ejecutora
   FROM (((((acciones acc
     LEFT JOIN poa pa ON ((pa.id_poa = acc.fk_poa)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = acc.fk_unidad_medida)))
     LEFT JOIN actividades act ON ((act.fk_accion = acc.id_accion)))
     LEFT JOIN responsable res ON ((res.fk_poa = pa.id_poa)))
     LEFT JOIN maestro ms2 ON ((ms2.id_maestro = act.fk_unidad_medida)));


ALTER TABLE poa.vsw_pdf_proyecto OWNER TO postgres;

--
-- Name: vsw_personal; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_personal AS
 SELECT p.id_personal AS id_persona,
    p.nacionalidad,
    p.cedula,
    (((p.primer_apellido)::text || ' '::text) || (p.segundo_apellido)::text) AS apellidos,
    (((p.primer_nombre)::text || ' '::text) || (p.segundo_nombre)::text) AS nombres,
    p.sexo,
    p.id_cargo,
    p.descripcion_cargo,
    p.estatus,
    p.id_dependencia AS cod_dependencia,
    p.nombre AS dependencia,
    p.grado
   FROM actualizar.dblink('dbname=actualizacion'::text, 'SELECT per.id_personal, per.nacionalidad, per.cedula, per.primer_nombre, per.segundo_nombre, per.primer_apellido,
segundo_apellido, per.sexo, car.id_cargo, car.descripcion_cargo, tr.estatus, dep.id_dependencia, dep.nombre, car.grado, car.tipo_cargo, tr.fecha_ingreso
FROM personal per
JOIN trabajador tr on tr.id_personal = per.id_personal
JOIN cargo car on car.id_cargo = tr.id_cargo
JOIN dependencia dep on dep.id_dependencia = tr.id_dependencia
'::text) p(id_personal integer, nacionalidad character varying(1), cedula integer, primer_nombre character varying(20), segundo_nombre character varying(20), primer_apellido character varying(20), segundo_apellido character varying(20), sexo character varying(1), id_cargo integer, descripcion_cargo character varying(60), estatus character varying(1), id_dependencia integer, nombre character varying(90), grado integer, tipo_cargo character varying(1), fecha_ingreso date)
  WHERE ((p.estatus)::text = 'A'::text);


ALTER TABLE poa.vsw_personal OWNER TO postgres;

--
-- Name: vsw_poa; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_poa AS
 SELECT pro.id_poa,
    pro.nombre,
    pro.obj_general,
    pro.obj_historico,
    pro.obj_estrategico,
    pro.obj_institucional,
    pro.descripcion,
    pro.fecha_inicio,
    pro.fecha_final,
    pro.fk_unidad_medida,
    ms2.descripcion AS unidad_medida,
    pro.cantidad,
    pro.fk_tipo_poa,
    ms.descripcion AS tipo_poa,
    per.id_persona AS id_persona_responsable,
    per.nombres AS nombres_responsable,
    per.apellidos AS apellidos_responsable,
    per.nacionalidad AS nacionalidad_responsable,
    per.cedula AS cedula_responsable,
    per.descripcion_cargo AS cargo_responsable,
    per.dependencia AS dependencia_responsable,
    per_dir.id_persona,
    per_dir.nombres,
    per_dir.apellidos,
    per_dir.nacionalidad,
    per_dir.cedula,
    per_dir.descripcion_cargo,
    per_dir.dependencia,
    res.cod_dependencia_cruge AS codigo_dependencia,
    date_part('year'::text, pro.fecha_inicio) AS anio
   FROM (((((((poa pro
     LEFT JOIN maestro ms ON ((ms.id_maestro = pro.fk_tipo_poa)))
     LEFT JOIN responsable res ON ((res.fk_poa = pro.id_poa)))
     LEFT JOIN public.cruge_user user_res ON ((user_res.iduser = res.fk_persona_registro)))
     LEFT JOIN public.cruge_user user_dir ON ((user_dir.iduser = res.fk_dir_responsable)))
     LEFT JOIN vsw_personal per ON ((per.id_persona = user_res.id_persona)))
     LEFT JOIN vsw_personal per_dir ON ((per_dir.id_persona = user_dir.id_persona)))
     LEFT JOIN maestro ms2 ON ((ms2.id_maestro = pro.fk_unidad_medida)));


ALTER TABLE poa.vsw_poa OWNER TO postgres;

--
-- Name: vsw_poa2; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_poa2 AS
 SELECT pr.id_poa,
    pr.nombre AS poa,
    pr.obj_general,
    pr.obj_historico,
    pr.descripcion,
    ac.id_accion,
    ac.nombre_accion AS acciones,
    act.id_actividades AS actividades,
    act.actividad
   FROM ((poa pr
     LEFT JOIN acciones ac ON ((ac.fk_poa = pr.id_poa)))
     LEFT JOIN actividades act ON ((act.fk_accion = ac.id_accion)))
  ORDER BY pr.id_poa;


ALTER TABLE poa.vsw_poa2 OWNER TO postgres;

--
-- Name: id_accion; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones ALTER COLUMN id_accion SET DEFAULT nextval('acciones_id_accion_seq'::regclass);


--
-- Name: id_actividades; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades ALTER COLUMN id_actividades SET DEFAULT nextval('actividades_id_actividades_seq'::regclass);


--
-- Name: id_comentarios; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios ALTER COLUMN id_comentarios SET DEFAULT nextval('comentarios_id_comentarios_seq'::regclass);


--
-- Name: id_estatus_poa; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa ALTER COLUMN id_estatus_poa SET DEFAULT nextval('estatus_poa_id_estatus_poa_seq'::regclass);


--
-- Name: id_maestro; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY maestro ALTER COLUMN id_maestro SET DEFAULT nextval('maestro_id_maestro_seq'::regclass);


--
-- Name: id_poa; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa ALTER COLUMN id_poa SET DEFAULT nextval('poa_id_poa_seq'::regclass);


--
-- Name: id_rendimiento; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento ALTER COLUMN id_rendimiento SET DEFAULT nextval('rendimiento_id_rendimiento_seq'::regclass);


--
-- Name: id_responsable; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable ALTER COLUMN id_responsable SET DEFAULT nextval('responsable_id_responsable_seq'::regclass);


--
-- Data for Name: acciones; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY acciones (id_accion, nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, bien_servicio) FROM stdin;
42	Accion 1	36	78	47	39	437	2016-04-07 10:12:32.855897	437	2016-04-07 10:12:32.855897	12	t	Bien o Servicio
43	Accion 2	38	486	47	39	437	2016-04-07 10:35:56.854936	437	2016-04-07 10:35:56.854936	12	t	Bien o Servicio
44	Accion Proyecto 1	36	135	47	40	437	2016-04-07 10:44:09.164252	437	2016-04-07 10:44:09.164252	12	t	Bien o Servicio
45	Accion Proyecto 2	37	78	47	40	437	2016-04-07 10:49:38.108191	437	2016-04-07 10:49:38.108191	12	t	Bien o Servicio
46	Accion Proyecto 3	44	15000	47	40	437	2016-04-07 10:53:14.380607	437	2016-04-07 10:53:14.380607	12	t	Bien o Servicio
47	Acción 01	36	30	47	41	437	2016-04-14 02:30:43.640777	437	2016-04-14 05:27:26.648929	12	t	Bien o Servicio
48	Accion 02	37	60	47	41	437	2016-04-14 02:32:05.722878	437	2016-04-14 05:45:52.791483	12	t	Bien o Servicio
49	Accion 03	39	200	47	41	437	2016-04-14 05:47:32.07005	\N	2016-04-14 05:47:32.07005	12	t	Bien o Servicio 03
\.


--
-- Name: acciones_id_accion_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('acciones_id_accion_seq', 49, true);


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY actividades (id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
106	Actividad 1.1	36	21	42	437	2016-04-07 10:29:39.1979	437	2016-04-07 10:29:39.1979	15	t
107	Actividad 1.2	36	57	42	437	2016-04-07 10:30:13.094141	437	2016-04-07 10:30:13.094141	15	t
108	Actividad 2.1	38	398	43	437	2016-04-07 10:36:48.393294	437	2016-04-07 10:36:48.393294	15	t
109	Actividad 2.2	38	67	43	437	2016-04-07 10:38:12.575829	437	2016-04-07 10:38:12.575829	15	t
110	Actividad 2.3	38	21	43	437	2016-04-07 10:38:50.24399	437	2016-04-07 10:38:50.24399	15	t
111	Actividad Proyecto 1.1	36	103	44	437	2016-04-07 10:44:49.906516	437	2016-04-07 10:44:49.906516	15	t
112	Actividad Proyecto 1.2	36	32	44	437	2016-04-07 10:45:38.111504	437	2016-04-07 10:45:38.111504	15	t
113	Accion Proyecto 2.1	37	6	45	437	2016-04-07 10:49:59.053278	437	2016-04-07 10:49:59.053278	15	t
115	Accion Proyecto 2.2	37	15	45	437	2016-04-07 10:50:36.711516	437	2016-04-07 10:50:36.711516	15	t
116	Accion Proyecto 2.3	37	24	45	437	2016-04-07 10:50:53.662673	437	2016-04-07 10:50:53.662673	15	t
117	Accion Proyecto 2.4	37	33	45	437	2016-04-07 10:51:07.683178	437	2016-04-07 10:51:07.683178	15	t
118	Actividad Proyecto 3.1	44	2500	46	437	2016-04-07 10:53:44.245451	437	2016-04-07 10:53:44.245451	15	t
119	Actividad Proyecto 3.2	44	2500	46	437	2016-04-07 10:54:08.135176	437	2016-04-07 10:54:08.135176	15	t
120	Actividad Proyecto 3.3	43	5000	46	437	2016-04-07 10:54:44.729193	437	2016-04-07 10:54:44.729193	15	t
121	Actividad Proyecto 3.4	44	3000	46	437	2016-04-07 10:55:02.874949	437	2016-04-07 10:55:02.874949	15	t
122	Actividad Proyecto 3.5	44	500	46	437	2016-04-07 10:55:46.544044	437	2016-04-07 10:55:46.544044	15	t
123	Actividad Proyecto 3.6	44	1500	46	437	2016-04-07 10:55:59.409378	437	2016-04-07 10:55:59.409378	15	t
124	Actividad 01.1 	36	45	47	437	2016-04-14 05:28:41.785191	437	2016-04-14 06:58:15.253039	15	t
125	Actividad 01.2	36	2	47	437	2016-04-14 06:58:47.580574	\N	2016-04-14 06:58:47.580574	15	t
126	Actividad 01.3	36	12	47	437	2016-04-14 06:59:34.029445	437	2016-04-14 07:00:01.450501	15	t
\.


--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('actividades_id_actividades_seq', 126, true);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY comentarios (id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_poa, fk_tipo_entidad) FROM stdin;
27		355	2016-04-07 11:00:11.781698	\N	2016-04-07 11:00:11.781698	18	t	40	9
28		462	2016-04-07 11:00:40.231361	\N	2016-04-07 11:00:40.231361	18	t	40	10
29	jjooo	355	2016-04-07 11:44:02.185038	\N	2016-04-07 11:44:02.185038	18	t	39	9
30		355	2016-04-11 12:16:09.178779	\N	2016-04-11 12:16:09.178779	18	t	39	9
31		462	2016-04-11 12:16:35.138139	\N	2016-04-11 12:16:35.138139	18	t	39	10
\.


--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentarios_seq', 31, true);


--
-- Data for Name: estatus_poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY estatus_poa (id_estatus_poa, fk_estatus_poa, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_tipo_entidad) FROM stdin;
81	50	39	437	2016-04-07 10:12:07.858813	\N	2016-04-07 10:12:07.858813	21	t	8
82	50	40	437	2016-04-07 10:43:15.888793	\N	2016-04-07 10:43:15.888793	21	t	8
83	51	40	437	2016-04-07 10:56:19.861549	\N	2016-04-07 10:56:19.861549	21	t	8
84	54	40	355	2016-04-07 11:00:11.753092	\N	2016-04-07 11:00:11.753092	21	t	9
85	52	40	462	2016-04-07 11:00:40.207985	\N	2016-04-07 11:00:40.207985	21	t	10
86	51	39	437	2016-04-07 11:43:39.019282	\N	2016-04-07 11:43:39.019282	21	t	8
87	55	39	355	2016-04-07 11:44:02.160603	\N	2016-04-07 11:44:02.160603	21	t	9
88	51	39	437	2016-04-07 11:44:34.048224	\N	2016-04-07 11:44:34.048224	21	t	8
89	54	39	355	2016-04-11 12:16:09.161797	\N	2016-04-11 12:16:09.161797	21	t	9
90	52	39	462	2016-04-11 12:16:35.111073	\N	2016-04-11 12:16:35.111073	21	t	10
91	50	41	437	2016-04-14 02:07:41.81362	\N	2016-04-14 02:07:41.81362	21	t	8
92	51	41	437	2016-04-14 07:00:22.734686	\N	2016-04-14 07:00:22.734686	21	t	8
\.


--
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('estatus_poa_id_estatus_poa_seq', 92, true);


--
-- Data for Name: maestro; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY maestro (id_maestro, descripcion, padre, hijo, created_by, created_date, modified_by, modified_date, es_activo) FROM stdin;
1	NACIONALIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
2	V	1	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
3	E	1	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
4	SEXO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
5	F	4	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
6	M	4	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
7	TIPO ENTIDAD	0	3	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
8	ANALISTA	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
9	DIRECCION	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
10	PLANIFICACION	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
11	ESTATUS ACCION	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
12	ACTIVO	11	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
13	INACTIVO	11	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
14	ESTATUS ACTIVIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
15	ACTIVO	14	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
16	INACTIVO	14	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
17	ESTATUS COMENTARIO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
18	ACTIVO	17	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
19	INACTIVO	17	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
21	ACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
22	INACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
24	ACTIVO	23	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
25	INACTIVO	23	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
26	ESTATUS RENDIMIENTO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
27	ACTIVO	26	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
28	INACTIVO	26	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
29	ESTATUS RESPONSABLE	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
30	ACTIVO	29	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
31	INACTIVO	29	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
32	ESTATUS UNIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
33	ACTIVO	32	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
34	INACTIVO	32	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
35	UNIDAD DE MEDIDA	0	10	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
36	CONVENIO	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
37	POLITICA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
38	BOLETIN	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
39	TALLER	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
41	INFORME	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
42	SISTEMA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
43	MINUTA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
44	SOLICITUD	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
45	CUADRO	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
46	TIPO AMBITO	0	2	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t
47	NACIONAL	46	0	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t
48	INTERNACIONAL	46	0	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t
50	NUEVO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t
52	APROBADO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t
53	REVISADO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t
40	 	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t
49	ESTATUS EVALUACION	0	5	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t
51	ENVIADO AL DIRECTOR(A)	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t
54	ENVIADO A PLANIFICACIÓN	49	0	1	2016-03-11 03:42:38.704464	\N	2016-03-11 03:42:38.704464	t
55	RECHAZADO	49	0	1	2016-03-11 14:18:56.849685	\N	2016-03-11 14:18:56.849685	t
57	ENERO	56	0	1	2016-03-14 10:07:10.082581	\N	2016-03-14 10:07:10.082581	t
58	FEBRERO	56	0	1	2016-03-14 10:07:19.858357	\N	2016-03-14 10:07:19.858357	t
59	MARZO	56	0	1	2016-03-14 10:07:28.338305	\N	2016-03-14 10:07:28.338305	t
60	ABRIL	56	0	1	2016-03-14 10:07:35.650111	\N	2016-03-14 10:07:35.650111	t
61	MAYO	56	0	1	2016-03-14 10:07:41.905957	\N	2016-03-14 10:07:41.905957	t
62	JUNIO	56	0	1	2016-03-14 10:07:48.633965	\N	2016-03-14 10:07:48.633965	t
63	JULIO	56	0	1	2016-03-14 10:07:54.777846	\N	2016-03-14 10:07:54.777846	t
23	ESTATUS POA	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
20	ESTATUS TABLA ESTATUS_POA	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
64	AGOSTO	56	0	1	2016-03-14 10:08:03.793658	\N	2016-03-14 10:08:03.793658	t
65	SEPTIEMBRE	56	0	1	2016-03-14 10:08:22.121565	\N	2016-03-14 10:08:22.121565	t
66	OCTUBRE	56	0	1	2016-03-14 10:08:30.465294	\N	2016-03-14 10:08:30.465294	t
67	NOVIEMBRE	56	0	1	2016-03-14 10:08:37.001253	\N	2016-03-14 10:08:37.001253	t
68	DICIEMBRE	56	0	1	2016-03-14 10:08:46.513118	\N	2016-03-14 10:08:46.513118	t
69	TIPO POA	0	2	1	2016-03-15 16:14:13.974914	\N	2016-03-15 16:14:13.974914	t
70	PROYECTO	69	0	1	2016-03-15 16:15:54.206749	\N	2016-03-15 16:15:54.206749	t
71	ACCION CENTRALIZADA	69	0	1	2016-03-15 16:16:19.926663	\N	2016-03-15 16:16:19.926663	t
73	ACCION	72	0	1	2016-03-18 12:18:28.719331	\N	2016-03-18 12:18:28.719331	t
74	ACTIVIDAD 	72	0	1	2016-03-18 12:18:44.247239	\N	2016-03-18 12:18:44.247239	t
72	TIPO RENDIMIENTO	0	2	1	2016-03-18 12:17:32.519334	\N	2016-03-18 12:17:32.519334	t
76	TRIMESTRE I	75	0	1	2016-03-29 03:19:37.751389	\N	2016-03-29 03:19:37.751389	t
77	TRIMESTRE II	75	0	1	2016-03-29 03:19:47.975151	\N	2016-03-29 03:19:47.975151	t
78	TRIMESTRE III	75	0	1	2016-03-29 03:19:58.268372	\N	2016-03-29 03:19:58.268372	t
79	TRIMESTRE IV	75	0	1	2016-03-29 03:20:08.425526	\N	2016-03-29 03:20:08.425526	t
81	SEMESTRE I	80	0	1	2016-03-29 03:20:50.006354	\N	2016-03-29 03:20:50.006354	t
82	SEMESTRE II	80	0	1	2016-03-29 03:21:00.113966	\N	2016-03-29 03:21:00.113966	t
83	MEDIDA TIEMPO	0	3	1	2016-03-29 03:21:40.827492	\N	2016-03-29 03:21:40.827492	t
80	SEMESTRE	83	2	1	2016-03-29 03:20:26.261644	\N	2016-03-29 03:20:26.261644	t
75	TRIMESTRE	83	4	1	2016-03-29 03:19:17.442634	\N	2016-03-29 03:19:17.442634	t
56	MESES	83	12	1	2016-03-14 10:06:57.834732	\N	2016-03-14 10:06:57.834732	t
\.


--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 85, true);


--
-- Data for Name: poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY poa (id_poa, nombre, fk_tipo_poa, obj_historico, obj_estrategico, obj_general, obj_institucional, descripcion, fecha_inicio, fecha_final, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_unidad_medida, cantidad) FROM stdin;
38	Poa 1	70	lll	lll	lll	ll	lll	2016-01-01 00:00:00	2016-12-31 00:00:00	1	2016-04-07 09:07:11.318162	\N	2016-04-07 09:07:11.318162	20	t	\N	\N
40	Proyecto 01	70	Historico	Estrategico	Objetivo	Institucional		2016-04-01 00:00:00	2016-12-31 00:00:00	437	2016-04-07 10:43:15.78986	\N	2016-04-07 10:43:15.78986	24	t	36	2500
39	Hola	71	\N	\N	Hola	\N	\N	2016-01-01 00:00:00	2016-12-31 00:00:00	437	2016-04-07 10:12:07.776972	437	2016-04-07 11:44:20.655308	24	t	\N	\N
41	Acción Centralizada 2017	71	\N	\N	Objetivo General 2017	\N	\N	2017-01-01 00:00:00	2017-12-31 00:00:00	437	2016-04-14 02:07:41.722737	\N	2016-04-14 02:07:41.722737	24	t	\N	\N
\.


--
-- Name: poa_id_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('poa_id_poa_seq', 41, true);


--
-- Data for Name: rendimiento; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY rendimiento (id_rendimiento, fk_meses, created_by, created_date, modified_by, modified_date, fk_status, es_activo, cantidad_cumplida, cantidad_programada, fk_tipo_entidad, id_entidad) FROM stdin;
959	57	437	2016-04-07 10:12:32.886622	\N	2016-04-07 10:12:32.886622	27	t	\N	1	73	42
960	58	437	2016-04-07 10:12:32.903222	\N	2016-04-07 10:12:32.903222	27	t	\N	2	73	42
961	59	437	2016-04-07 10:12:32.920849	\N	2016-04-07 10:12:32.920849	27	t	\N	3	73	42
962	60	437	2016-04-07 10:12:32.936114	\N	2016-04-07 10:12:32.936114	27	t	\N	4	73	42
963	61	437	2016-04-07 10:12:32.953212	\N	2016-04-07 10:12:32.953212	27	t	\N	5	73	42
964	62	437	2016-04-07 10:12:32.970151	\N	2016-04-07 10:12:32.970151	27	t	\N	6	73	42
965	63	437	2016-04-07 10:12:32.986743	\N	2016-04-07 10:12:32.986743	27	t	\N	7	73	42
966	64	437	2016-04-07 10:12:33.003465	\N	2016-04-07 10:12:33.003465	27	t	\N	8	73	42
967	65	437	2016-04-07 10:12:33.020191	\N	2016-04-07 10:12:33.020191	27	t	\N	9	73	42
968	66	437	2016-04-07 10:12:33.036742	\N	2016-04-07 10:12:33.036742	27	t	\N	10	73	42
969	67	437	2016-04-07 10:12:33.053418	\N	2016-04-07 10:12:33.053418	27	t	\N	11	73	42
970	68	437	2016-04-07 10:12:33.070121	\N	2016-04-07 10:12:33.070121	27	t	\N	12	73	42
1079	57	437	2016-04-07 10:29:39.303258	\N	2016-04-07 10:29:39.303258	27	t	\N	1	74	106
1080	58	437	2016-04-07 10:29:39.317902	\N	2016-04-07 10:29:39.317902	27	t	\N	2	74	106
1081	59	437	2016-04-07 10:29:39.33347	\N	2016-04-07 10:29:39.33347	27	t	\N	3	74	106
1082	60	437	2016-04-07 10:29:39.350173	\N	2016-04-07 10:29:39.350173	27	t	\N	4	74	106
1083	61	437	2016-04-07 10:29:39.366922	\N	2016-04-07 10:29:39.366922	27	t	\N	5	74	106
1084	62	437	2016-04-07 10:29:39.383697	\N	2016-04-07 10:29:39.383697	27	t	\N	6	74	106
1085	63	437	2016-04-07 10:29:39.400411	\N	2016-04-07 10:29:39.400411	27	t	\N	0	74	106
1086	64	437	2016-04-07 10:29:39.416984	\N	2016-04-07 10:29:39.416984	27	t	\N	0	74	106
1087	65	437	2016-04-07 10:29:39.434298	\N	2016-04-07 10:29:39.434298	27	t	\N	0	74	106
1088	66	437	2016-04-07 10:29:39.450648	\N	2016-04-07 10:29:39.450648	27	t	\N	0	74	106
1089	67	437	2016-04-07 10:29:39.466793	\N	2016-04-07 10:29:39.466793	27	t	\N	0	74	106
1090	68	437	2016-04-07 10:29:39.483549	\N	2016-04-07 10:29:39.483549	27	t	\N	0	74	106
1091	57	437	2016-04-07 10:30:13.203728	\N	2016-04-07 10:30:13.203728	27	t	\N	0	74	107
1092	58	437	2016-04-07 10:30:13.216529	\N	2016-04-07 10:30:13.216529	27	t	\N	0	74	107
1093	59	437	2016-04-07 10:30:13.233448	\N	2016-04-07 10:30:13.233448	27	t	\N	0	74	107
1094	60	437	2016-04-07 10:30:13.250882	\N	2016-04-07 10:30:13.250882	27	t	\N	0	74	107
1095	61	437	2016-04-07 10:30:13.270115	\N	2016-04-07 10:30:13.270115	27	t	\N	0	74	107
1096	62	437	2016-04-07 10:30:13.284132	\N	2016-04-07 10:30:13.284132	27	t	\N	0	74	107
1097	63	437	2016-04-07 10:30:13.300087	\N	2016-04-07 10:30:13.300087	27	t	\N	7	74	107
1098	64	437	2016-04-07 10:30:13.316678	\N	2016-04-07 10:30:13.316678	27	t	\N	8	74	107
1099	65	437	2016-04-07 10:30:13.334079	\N	2016-04-07 10:30:13.334079	27	t	\N	9	74	107
1100	66	437	2016-04-07 10:30:13.351015	\N	2016-04-07 10:30:13.351015	27	t	\N	10	74	107
1101	67	437	2016-04-07 10:30:13.367395	\N	2016-04-07 10:30:13.367395	27	t	\N	11	74	107
1102	68	437	2016-04-07 10:30:13.383186	\N	2016-04-07 10:30:13.383186	27	t	\N	12	74	107
1103	57	437	2016-04-07 10:35:56.875122	\N	2016-04-07 10:35:56.875122	27	t	\N	12	73	43
1104	58	437	2016-04-07 10:35:56.892053	\N	2016-04-07 10:35:56.892053	27	t	\N	10	73	43
1105	59	437	2016-04-07 10:35:56.910711	\N	2016-04-07 10:35:56.910711	27	t	\N	1	73	43
1106	60	437	2016-04-07 10:35:56.926134	\N	2016-04-07 10:35:56.926134	27	t	\N	2	73	43
1107	61	437	2016-04-07 10:35:56.942718	\N	2016-04-07 10:35:56.942718	27	t	\N	5	73	43
1108	62	437	2016-04-07 10:35:56.959407	\N	2016-04-07 10:35:56.959407	27	t	\N	2	73	43
1109	63	437	2016-04-07 10:35:56.975988	\N	2016-04-07 10:35:56.975988	27	t	\N	1	73	43
1110	64	437	2016-04-07 10:35:56.992572	\N	2016-04-07 10:35:56.992572	27	t	\N	5	73	43
1111	65	437	2016-04-07 10:35:57.009026	\N	2016-04-07 10:35:57.009026	27	t	\N	23	73	43
1112	66	437	2016-04-07 10:35:57.025536	\N	2016-04-07 10:35:57.025536	27	t	\N	55	73	43
1113	67	437	2016-04-07 10:35:57.042188	\N	2016-04-07 10:35:57.042188	27	t	\N	120	73	43
1114	68	437	2016-04-07 10:35:57.059466	\N	2016-04-07 10:35:57.059466	27	t	\N	250	73	43
1115	57	437	2016-04-07 10:36:48.508707	\N	2016-04-07 10:36:48.508707	27	t	\N	10	74	108
1116	58	437	2016-04-07 10:36:48.526152	\N	2016-04-07 10:36:48.526152	27	t	\N	5	74	108
1117	59	437	2016-04-07 10:36:48.541374	\N	2016-04-07 10:36:48.541374	27	t	\N	0	74	108
1118	60	437	2016-04-07 10:36:48.557825	\N	2016-04-07 10:36:48.557825	27	t	\N	2	74	108
1119	61	437	2016-04-07 10:36:48.574345	\N	2016-04-07 10:36:48.574345	27	t	\N	5	74	108
1120	62	437	2016-04-07 10:36:48.590827	\N	2016-04-07 10:36:48.590827	27	t	\N	1	74	108
1121	63	437	2016-04-07 10:36:48.607203	\N	2016-04-07 10:36:48.607203	27	t	\N	0	74	108
1122	64	437	2016-04-07 10:36:48.624477	\N	2016-04-07 10:36:48.624477	27	t	\N	5	74	108
1123	65	437	2016-04-07 10:36:48.640668	\N	2016-04-07 10:36:48.640668	27	t	\N	20	74	108
1124	66	437	2016-04-07 10:36:48.657413	\N	2016-04-07 10:36:48.657413	27	t	\N	50	74	108
1125	67	437	2016-04-07 10:36:48.673853	\N	2016-04-07 10:36:48.673853	27	t	\N	100	74	108
1126	68	437	2016-04-07 10:36:48.69064	\N	2016-04-07 10:36:48.69064	27	t	\N	200	74	108
1127	57	437	2016-04-07 10:38:12.698233	\N	2016-04-07 10:38:12.698233	27	t	\N	2	74	109
1128	58	437	2016-04-07 10:38:12.716443	\N	2016-04-07 10:38:12.716443	27	t	\N	5	74	109
1129	59	437	2016-04-07 10:38:12.732841	\N	2016-04-07 10:38:12.732841	27	t	\N	0	74	109
1130	60	437	2016-04-07 10:38:12.750305	\N	2016-04-07 10:38:12.750305	27	t	\N	0	74	109
1131	61	437	2016-04-07 10:38:12.767668	\N	2016-04-07 10:38:12.767668	27	t	\N	0	74	109
1132	62	437	2016-04-07 10:38:12.783108	\N	2016-04-07 10:38:12.783108	27	t	\N	1	74	109
1133	63	437	2016-04-07 10:38:12.800115	\N	2016-04-07 10:38:12.800115	27	t	\N	1	74	109
1134	64	437	2016-04-07 10:38:12.816959	\N	2016-04-07 10:38:12.816959	27	t	\N	0	74	109
1135	65	437	2016-04-07 10:38:12.834712	\N	2016-04-07 10:38:12.834712	27	t	\N	3	74	109
1136	66	437	2016-04-07 10:38:12.850638	\N	2016-04-07 10:38:12.850638	27	t	\N	5	74	109
1137	67	437	2016-04-07 10:38:12.866435	\N	2016-04-07 10:38:12.866435	27	t	\N	0	74	109
1138	68	437	2016-04-07 10:38:12.884356	\N	2016-04-07 10:38:12.884356	27	t	\N	50	74	109
1139	57	437	2016-04-07 10:38:50.35185	\N	2016-04-07 10:38:50.35185	27	t	\N	0	74	110
1140	58	437	2016-04-07 10:38:50.366767	\N	2016-04-07 10:38:50.366767	27	t	\N	0	74	110
1141	59	437	2016-04-07 10:38:50.382918	\N	2016-04-07 10:38:50.382918	27	t	\N	1	74	110
1142	60	437	2016-04-07 10:38:50.400096	\N	2016-04-07 10:38:50.400096	27	t	\N	0	74	110
1143	61	437	2016-04-07 10:38:50.416885	\N	2016-04-07 10:38:50.416885	27	t	\N	0	74	110
1144	62	437	2016-04-07 10:38:50.433418	\N	2016-04-07 10:38:50.433418	27	t	\N	0	74	110
1145	63	437	2016-04-07 10:38:50.450521	\N	2016-04-07 10:38:50.450521	27	t	\N	0	74	110
1146	64	437	2016-04-07 10:38:50.466514	\N	2016-04-07 10:38:50.466514	27	t	\N	0	74	110
1147	65	437	2016-04-07 10:38:50.483	\N	2016-04-07 10:38:50.483	27	t	\N	0	74	110
1148	66	437	2016-04-07 10:38:50.499813	\N	2016-04-07 10:38:50.499813	27	t	\N	20	74	110
1149	67	437	2016-04-07 10:38:50.516522	\N	2016-04-07 10:38:50.516522	27	t	\N	0	74	110
1150	68	437	2016-04-07 10:38:50.533234	\N	2016-04-07 10:38:50.533234	27	t	\N	0	74	110
1151	57	437	2016-04-07 10:44:09.210954	\N	2016-04-07 10:44:09.210954	27	t	\N	10	73	44
1152	58	437	2016-04-07 10:44:09.262356	\N	2016-04-07 10:44:09.262356	27	t	\N	12	73	44
1153	59	437	2016-04-07 10:44:09.312131	\N	2016-04-07 10:44:09.312131	27	t	\N	11	73	44
1154	60	437	2016-04-07 10:44:09.362504	\N	2016-04-07 10:44:09.362504	27	t	\N	12	73	44
1155	61	437	2016-04-07 10:44:09.413254	\N	2016-04-07 10:44:09.413254	27	t	\N	10	73	44
1156	62	437	2016-04-07 10:44:09.462645	\N	2016-04-07 10:44:09.462645	27	t	\N	50	73	44
1157	63	437	2016-04-07 10:44:09.513259	\N	2016-04-07 10:44:09.513259	27	t	\N	2	73	44
1158	64	437	2016-04-07 10:44:09.563699	\N	2016-04-07 10:44:09.563699	27	t	\N	2	73	44
1159	65	437	2016-04-07 10:44:09.61315	\N	2016-04-07 10:44:09.61315	27	t	\N	2	73	44
1160	66	437	2016-04-07 10:44:09.663671	\N	2016-04-07 10:44:09.663671	27	t	\N	10	73	44
1161	67	437	2016-04-07 10:44:09.714665	\N	2016-04-07 10:44:09.714665	27	t	\N	2	73	44
1162	68	437	2016-04-07 10:44:09.764957	\N	2016-04-07 10:44:09.764957	27	t	\N	12	73	44
1163	57	437	2016-04-07 10:44:50.049904	\N	2016-04-07 10:44:50.049904	27	t	\N	10	74	111
1164	58	437	2016-04-07 10:44:50.12297	\N	2016-04-07 10:44:50.12297	27	t	\N	12	74	111
1165	59	437	2016-04-07 10:44:50.163451	\N	2016-04-07 10:44:50.163451	27	t	\N	11	74	111
1166	60	437	2016-04-07 10:44:50.215304	\N	2016-04-07 10:44:50.215304	27	t	\N	12	74	111
1167	61	437	2016-04-07 10:44:50.289567	\N	2016-04-07 10:44:50.289567	27	t	\N	10	74	111
1168	62	437	2016-04-07 10:44:50.330098	\N	2016-04-07 10:44:50.330098	27	t	\N	25	74	111
1169	63	437	2016-04-07 10:44:50.388331	\N	2016-04-07 10:44:50.388331	27	t	\N	2	74	111
1170	64	437	2016-04-07 10:44:50.455168	\N	2016-04-07 10:44:50.455168	27	t	\N	2	74	111
1171	65	437	2016-04-07 10:44:50.522392	\N	2016-04-07 10:44:50.522392	27	t	\N	2	74	111
1172	66	437	2016-04-07 10:44:50.588073	\N	2016-04-07 10:44:50.588073	27	t	\N	5	74	111
1173	67	437	2016-04-07 10:44:50.638868	\N	2016-04-07 10:44:50.638868	27	t	\N	2	74	111
1174	68	437	2016-04-07 10:44:50.689934	\N	2016-04-07 10:44:50.689934	27	t	\N	10	74	111
1175	57	437	2016-04-07 10:45:38.292363	\N	2016-04-07 10:45:38.292363	27	t	\N	0	74	112
1176	58	437	2016-04-07 10:45:38.331827	\N	2016-04-07 10:45:38.331827	27	t	\N	0	74	112
1177	59	437	2016-04-07 10:45:38.391722	\N	2016-04-07 10:45:38.391722	27	t	\N	0	74	112
1178	60	437	2016-04-07 10:45:38.480764	\N	2016-04-07 10:45:38.480764	27	t	\N	0	74	112
1179	61	437	2016-04-07 10:45:38.529897	\N	2016-04-07 10:45:38.529897	27	t	\N	0	74	112
1180	62	437	2016-04-07 10:45:38.596826	\N	2016-04-07 10:45:38.596826	27	t	\N	25	74	112
1181	63	437	2016-04-07 10:45:38.664175	\N	2016-04-07 10:45:38.664175	27	t	\N	0	74	112
1182	64	437	2016-04-07 10:45:38.733475	\N	2016-04-07 10:45:38.733475	27	t	\N	0	74	112
1183	65	437	2016-04-07 10:45:38.808095	\N	2016-04-07 10:45:38.808095	27	t	\N	0	74	112
1184	66	437	2016-04-07 10:45:38.874543	\N	2016-04-07 10:45:38.874543	27	t	\N	5	74	112
1185	67	437	2016-04-07 10:45:38.932835	\N	2016-04-07 10:45:38.932835	27	t	\N	0	74	112
1186	68	437	2016-04-07 10:45:39.015621	\N	2016-04-07 10:45:39.015621	27	t	\N	2	74	112
1187	57	437	2016-04-07 10:49:38.130555	\N	2016-04-07 10:49:38.130555	27	t	\N	1	73	45
1188	58	437	2016-04-07 10:49:38.147277	\N	2016-04-07 10:49:38.147277	27	t	\N	2	73	45
1189	59	437	2016-04-07 10:49:38.164519	\N	2016-04-07 10:49:38.164519	27	t	\N	3	73	45
1190	60	437	2016-04-07 10:49:38.180541	\N	2016-04-07 10:49:38.180541	27	t	\N	4	73	45
1191	61	437	2016-04-07 10:49:38.197975	\N	2016-04-07 10:49:38.197975	27	t	\N	5	73	45
1192	62	437	2016-04-07 10:49:38.216286	\N	2016-04-07 10:49:38.216286	27	t	\N	6	73	45
1193	63	437	2016-04-07 10:49:38.231202	\N	2016-04-07 10:49:38.231202	27	t	\N	7	73	45
1194	64	437	2016-04-07 10:49:38.247781	\N	2016-04-07 10:49:38.247781	27	t	\N	8	73	45
1195	65	437	2016-04-07 10:49:38.264529	\N	2016-04-07 10:49:38.264529	27	t	\N	9	73	45
1196	66	437	2016-04-07 10:49:38.280743	\N	2016-04-07 10:49:38.280743	27	t	\N	10	73	45
1197	67	437	2016-04-07 10:49:38.298437	\N	2016-04-07 10:49:38.298437	27	t	\N	11	73	45
1198	68	437	2016-04-07 10:49:38.314958	\N	2016-04-07 10:49:38.314958	27	t	\N	12	73	45
1199	57	437	2016-04-07 10:49:59.163612	\N	2016-04-07 10:49:59.163612	27	t	\N	1	74	113
1200	58	437	2016-04-07 10:49:59.180287	\N	2016-04-07 10:49:59.180287	27	t	\N	2	74	113
1201	59	437	2016-04-07 10:49:59.196636	\N	2016-04-07 10:49:59.196636	27	t	\N	3	74	113
1202	60	437	2016-04-07 10:49:59.213321	\N	2016-04-07 10:49:59.213321	27	t	\N	0	74	113
1203	61	437	2016-04-07 10:49:59.229935	\N	2016-04-07 10:49:59.229935	27	t	\N	0	74	113
1204	62	437	2016-04-07 10:49:59.248313	\N	2016-04-07 10:49:59.248313	27	t	\N	0	74	113
1205	63	437	2016-04-07 10:49:59.263013	\N	2016-04-07 10:49:59.263013	27	t	\N	0	74	113
1206	64	437	2016-04-07 10:49:59.280719	\N	2016-04-07 10:49:59.280719	27	t	\N	0	74	113
1207	65	437	2016-04-07 10:49:59.296354	\N	2016-04-07 10:49:59.296354	27	t	\N	0	74	113
1208	66	437	2016-04-07 10:49:59.31356	\N	2016-04-07 10:49:59.31356	27	t	\N	0	74	113
1209	67	437	2016-04-07 10:49:59.329843	\N	2016-04-07 10:49:59.329843	27	t	\N	0	74	113
1210	68	437	2016-04-07 10:49:59.346339	\N	2016-04-07 10:49:59.346339	27	t	\N	0	74	113
1223	57	437	2016-04-07 10:50:36.871335	\N	2016-04-07 10:50:36.871335	27	t	\N	0	74	115
1224	58	437	2016-04-07 10:50:36.889848	\N	2016-04-07 10:50:36.889848	27	t	\N	0	74	115
1225	59	437	2016-04-07 10:50:36.905741	\N	2016-04-07 10:50:36.905741	27	t	\N	0	74	115
1226	60	437	2016-04-07 10:50:36.922426	\N	2016-04-07 10:50:36.922426	27	t	\N	4	74	115
1227	61	437	2016-04-07 10:50:36.939188	\N	2016-04-07 10:50:36.939188	27	t	\N	5	74	115
1228	62	437	2016-04-07 10:50:36.956203	\N	2016-04-07 10:50:36.956203	27	t	\N	6	74	115
1229	63	437	2016-04-07 10:50:36.972619	\N	2016-04-07 10:50:36.972619	27	t	\N	0	74	115
1230	64	437	2016-04-07 10:50:36.988701	\N	2016-04-07 10:50:36.988701	27	t	\N	0	74	115
1231	65	437	2016-04-07 10:50:37.008559	\N	2016-04-07 10:50:37.008559	27	t	\N	0	74	115
1232	66	437	2016-04-07 10:50:37.034781	\N	2016-04-07 10:50:37.034781	27	t	\N	0	74	115
1233	67	437	2016-04-07 10:50:37.049162	\N	2016-04-07 10:50:37.049162	27	t	\N	0	74	115
1234	68	437	2016-04-07 10:50:37.063512	\N	2016-04-07 10:50:37.063512	27	t	\N	0	74	115
1235	57	437	2016-04-07 10:50:53.776899	\N	2016-04-07 10:50:53.776899	27	t	\N	0	74	116
1236	58	437	2016-04-07 10:50:53.789622	\N	2016-04-07 10:50:53.789622	27	t	\N	0	74	116
1237	59	437	2016-04-07 10:50:53.805668	\N	2016-04-07 10:50:53.805668	27	t	\N	0	74	116
1238	60	437	2016-04-07 10:50:53.82261	\N	2016-04-07 10:50:53.82261	27	t	\N	0	74	116
1239	61	437	2016-04-07 10:50:53.839868	\N	2016-04-07 10:50:53.839868	27	t	\N	0	74	116
1240	62	437	2016-04-07 10:50:53.856141	\N	2016-04-07 10:50:53.856141	27	t	\N	0	74	116
1241	63	437	2016-04-07 10:50:53.873009	\N	2016-04-07 10:50:53.873009	27	t	\N	7	74	116
1242	64	437	2016-04-07 10:50:53.889861	\N	2016-04-07 10:50:53.889861	27	t	\N	8	74	116
1243	65	437	2016-04-07 10:50:53.906274	\N	2016-04-07 10:50:53.906274	27	t	\N	9	74	116
1244	66	437	2016-04-07 10:50:53.922893	\N	2016-04-07 10:50:53.922893	27	t	\N	0	74	116
1245	67	437	2016-04-07 10:50:53.939201	\N	2016-04-07 10:50:53.939201	27	t	\N	0	74	116
1246	68	437	2016-04-07 10:50:53.956684	\N	2016-04-07 10:50:53.956684	27	t	\N	0	74	116
1247	57	437	2016-04-07 10:51:07.798881	\N	2016-04-07 10:51:07.798881	27	t	\N	0	74	117
1248	58	437	2016-04-07 10:51:07.816122	\N	2016-04-07 10:51:07.816122	27	t	\N	0	74	117
1249	59	437	2016-04-07 10:51:07.833032	\N	2016-04-07 10:51:07.833032	27	t	\N	0	74	117
1250	60	437	2016-04-07 10:51:07.847461	\N	2016-04-07 10:51:07.847461	27	t	\N	0	74	117
1251	61	437	2016-04-07 10:51:07.865665	\N	2016-04-07 10:51:07.865665	27	t	\N	0	74	117
1252	62	437	2016-04-07 10:51:07.881855	\N	2016-04-07 10:51:07.881855	27	t	\N	0	74	117
1253	63	437	2016-04-07 10:51:07.898041	\N	2016-04-07 10:51:07.898041	27	t	\N	0	74	117
1254	64	437	2016-04-07 10:51:07.914164	\N	2016-04-07 10:51:07.914164	27	t	\N	0	74	117
1255	65	437	2016-04-07 10:51:07.933397	\N	2016-04-07 10:51:07.933397	27	t	\N	0	74	117
1256	66	437	2016-04-07 10:51:07.950372	\N	2016-04-07 10:51:07.950372	27	t	\N	10	74	117
1257	67	437	2016-04-07 10:51:07.964333	\N	2016-04-07 10:51:07.964333	27	t	\N	11	74	117
1258	68	437	2016-04-07 10:51:07.98088	\N	2016-04-07 10:51:07.98088	27	t	\N	12	74	117
1259	57	437	2016-04-07 10:53:14.406396	\N	2016-04-07 10:53:14.406396	27	t	\N	2500	73	46
1260	58	437	2016-04-07 10:53:14.422477	\N	2016-04-07 10:53:14.422477	27	t	\N	2500	73	46
1261	59	437	2016-04-07 10:53:14.439385	\N	2016-04-07 10:53:14.439385	27	t	\N	0	73	46
1262	60	437	2016-04-07 10:53:14.456063	\N	2016-04-07 10:53:14.456063	27	t	\N	0	73	46
1263	61	437	2016-04-07 10:53:14.473234	\N	2016-04-07 10:53:14.473234	27	t	\N	0	73	46
1264	62	437	2016-04-07 10:53:14.489924	\N	2016-04-07 10:53:14.489924	27	t	\N	2500	73	46
1265	63	437	2016-04-07 10:53:14.50672	\N	2016-04-07 10:53:14.50672	27	t	\N	2500	73	46
1266	64	437	2016-04-07 10:53:14.523653	\N	2016-04-07 10:53:14.523653	27	t	\N	0	73	46
1267	65	437	2016-04-07 10:53:14.542205	\N	2016-04-07 10:53:14.542205	27	t	\N	0	73	46
1268	66	437	2016-04-07 10:53:14.556591	\N	2016-04-07 10:53:14.556591	27	t	\N	1250	73	46
1269	67	437	2016-04-07 10:53:14.574058	\N	2016-04-07 10:53:14.574058	27	t	\N	1250	73	46
1270	68	437	2016-04-07 10:53:14.590446	\N	2016-04-07 10:53:14.590446	27	t	\N	2500	73	46
1271	57	437	2016-04-07 10:53:44.357317	\N	2016-04-07 10:53:44.357317	27	t	\N	1250	74	118
1272	58	437	2016-04-07 10:53:44.373478	\N	2016-04-07 10:53:44.373478	27	t	\N	1250	74	118
1273	59	437	2016-04-07 10:53:44.3892	\N	2016-04-07 10:53:44.3892	27	t	\N	0	74	118
1274	60	437	2016-04-07 10:53:44.405685	\N	2016-04-07 10:53:44.405685	27	t	\N	0	74	118
1275	61	437	2016-04-07 10:53:44.422303	\N	2016-04-07 10:53:44.422303	27	t	\N	0	74	118
1276	62	437	2016-04-07 10:53:44.438785	\N	2016-04-07 10:53:44.438785	27	t	\N	0	74	118
1277	63	437	2016-04-07 10:53:44.45493	\N	2016-04-07 10:53:44.45493	27	t	\N	0	74	118
1278	64	437	2016-04-07 10:53:44.472046	\N	2016-04-07 10:53:44.472046	27	t	\N	0	74	118
1279	65	437	2016-04-07 10:53:44.489047	\N	2016-04-07 10:53:44.489047	27	t	\N	0	74	118
1280	66	437	2016-04-07 10:53:44.505303	\N	2016-04-07 10:53:44.505303	27	t	\N	0	74	118
1281	67	437	2016-04-07 10:53:44.521917	\N	2016-04-07 10:53:44.521917	27	t	\N	0	74	118
1282	68	437	2016-04-07 10:53:44.538465	\N	2016-04-07 10:53:44.538465	27	t	\N	0	74	118
1283	57	437	2016-04-07 10:54:08.247144	\N	2016-04-07 10:54:08.247144	27	t	\N	1250	74	119
1284	58	437	2016-04-07 10:54:08.264121	\N	2016-04-07 10:54:08.264121	27	t	\N	1250	74	119
1285	59	437	2016-04-07 10:54:08.280798	\N	2016-04-07 10:54:08.280798	27	t	\N	0	74	119
1286	60	437	2016-04-07 10:54:08.297569	\N	2016-04-07 10:54:08.297569	27	t	\N	0	74	119
1287	61	437	2016-04-07 10:54:08.31402	\N	2016-04-07 10:54:08.31402	27	t	\N	0	74	119
1288	62	437	2016-04-07 10:54:08.331031	\N	2016-04-07 10:54:08.331031	27	t	\N	0	74	119
1289	63	437	2016-04-07 10:54:08.34732	\N	2016-04-07 10:54:08.34732	27	t	\N	0	74	119
1290	64	437	2016-04-07 10:54:08.364097	\N	2016-04-07 10:54:08.364097	27	t	\N	0	74	119
1291	65	437	2016-04-07 10:54:08.380538	\N	2016-04-07 10:54:08.380538	27	t	\N	0	74	119
1292	66	437	2016-04-07 10:54:08.397123	\N	2016-04-07 10:54:08.397123	27	t	\N	0	74	119
1293	67	437	2016-04-07 10:54:08.414264	\N	2016-04-07 10:54:08.414264	27	t	\N	0	74	119
1294	68	437	2016-04-07 10:54:08.430616	\N	2016-04-07 10:54:08.430616	27	t	\N	0	74	119
1295	57	437	2016-04-07 10:54:44.849176	\N	2016-04-07 10:54:44.849176	27	t	\N	0	74	120
1296	58	437	2016-04-07 10:54:44.863987	\N	2016-04-07 10:54:44.863987	27	t	\N	0	74	120
1297	59	437	2016-04-07 10:54:44.880496	\N	2016-04-07 10:54:44.880496	27	t	\N	0	74	120
1298	60	437	2016-04-07 10:54:44.898458	\N	2016-04-07 10:54:44.898458	27	t	\N	0	74	120
1299	61	437	2016-04-07 10:54:44.914123	\N	2016-04-07 10:54:44.914123	27	t	\N	0	74	120
1300	62	437	2016-04-07 10:54:44.930575	\N	2016-04-07 10:54:44.930575	27	t	\N	2500	74	120
1301	63	437	2016-04-07 10:54:44.948096	\N	2016-04-07 10:54:44.948096	27	t	\N	2500	74	120
1302	64	437	2016-04-07 10:54:44.964781	\N	2016-04-07 10:54:44.964781	27	t	\N	0	74	120
1303	65	437	2016-04-07 10:54:44.980742	\N	2016-04-07 10:54:44.980742	27	t	\N	0	74	120
1304	66	437	2016-04-07 10:54:44.99739	\N	2016-04-07 10:54:44.99739	27	t	\N	0	74	120
1305	67	437	2016-04-07 10:54:45.014157	\N	2016-04-07 10:54:45.014157	27	t	\N	0	74	120
1306	68	437	2016-04-07 10:54:45.031068	\N	2016-04-07 10:54:45.031068	27	t	\N	0	74	120
1307	57	437	2016-04-07 10:55:02.991449	\N	2016-04-07 10:55:02.991449	27	t	\N	0	74	121
1308	58	437	2016-04-07 10:55:03.00544	\N	2016-04-07 10:55:03.00544	27	t	\N	0	74	121
1309	59	437	2016-04-07 10:55:03.022347	\N	2016-04-07 10:55:03.022347	27	t	\N	0	74	121
1310	60	437	2016-04-07 10:55:03.039028	\N	2016-04-07 10:55:03.039028	27	t	\N	0	74	121
1311	61	437	2016-04-07 10:55:03.055674	\N	2016-04-07 10:55:03.055674	27	t	\N	0	74	121
1312	62	437	2016-04-07 10:55:03.072516	\N	2016-04-07 10:55:03.072516	27	t	\N	0	74	121
1313	63	437	2016-04-07 10:55:03.08867	\N	2016-04-07 10:55:03.08867	27	t	\N	0	74	121
1314	64	437	2016-04-07 10:55:03.106789	\N	2016-04-07 10:55:03.106789	27	t	\N	0	74	121
1315	65	437	2016-04-07 10:55:03.122053	\N	2016-04-07 10:55:03.122053	27	t	\N	0	74	121
1316	66	437	2016-04-07 10:55:03.138897	\N	2016-04-07 10:55:03.138897	27	t	\N	1000	74	121
1317	67	437	2016-04-07 10:55:03.15568	\N	2016-04-07 10:55:03.15568	27	t	\N	1000	74	121
1318	68	437	2016-04-07 10:55:03.171908	\N	2016-04-07 10:55:03.171908	27	t	\N	1000	74	121
1319	57	437	2016-04-07 10:55:46.651391	\N	2016-04-07 10:55:46.651391	27	t	\N	0	74	122
1320	58	437	2016-04-07 10:55:46.665104	\N	2016-04-07 10:55:46.665104	27	t	\N	0	74	122
1321	59	437	2016-04-07 10:55:46.680593	\N	2016-04-07 10:55:46.680593	27	t	\N	0	74	122
1322	60	437	2016-04-07 10:55:46.697474	\N	2016-04-07 10:55:46.697474	27	t	\N	0	74	122
1323	61	437	2016-04-07 10:55:46.714674	\N	2016-04-07 10:55:46.714674	27	t	\N	0	74	122
1324	62	437	2016-04-07 10:55:46.73053	\N	2016-04-07 10:55:46.73053	27	t	\N	0	74	122
1325	63	437	2016-04-07 10:55:46.747699	\N	2016-04-07 10:55:46.747699	27	t	\N	0	74	122
1326	64	437	2016-04-07 10:55:46.763619	\N	2016-04-07 10:55:46.763619	27	t	\N	0	74	122
1327	65	437	2016-04-07 10:55:46.780664	\N	2016-04-07 10:55:46.780664	27	t	\N	0	74	122
1328	66	437	2016-04-07 10:55:46.797505	\N	2016-04-07 10:55:46.797505	27	t	\N	250	74	122
1329	67	437	2016-04-07 10:55:46.814146	\N	2016-04-07 10:55:46.814146	27	t	\N	250	74	122
1330	68	437	2016-04-07 10:55:46.830464	\N	2016-04-07 10:55:46.830464	27	t	\N	0	74	122
1331	57	437	2016-04-07 10:55:59.524691	\N	2016-04-07 10:55:59.524691	27	t	\N	0	74	123
1332	58	437	2016-04-07 10:55:59.539733	\N	2016-04-07 10:55:59.539733	27	t	\N	0	74	123
1333	59	437	2016-04-07 10:55:59.556411	\N	2016-04-07 10:55:59.556411	27	t	\N	0	74	123
1334	60	437	2016-04-07 10:55:59.572175	\N	2016-04-07 10:55:59.572175	27	t	\N	0	74	123
1335	61	437	2016-04-07 10:55:59.589899	\N	2016-04-07 10:55:59.589899	27	t	\N	0	74	123
1336	62	437	2016-04-07 10:55:59.606252	\N	2016-04-07 10:55:59.606252	27	t	\N	0	74	123
1337	63	437	2016-04-07 10:55:59.622343	\N	2016-04-07 10:55:59.622343	27	t	\N	0	74	123
1338	64	437	2016-04-07 10:55:59.639675	\N	2016-04-07 10:55:59.639675	27	t	\N	0	74	123
1339	65	437	2016-04-07 10:55:59.656289	\N	2016-04-07 10:55:59.656289	27	t	\N	0	74	123
1340	66	437	2016-04-07 10:55:59.672148	\N	2016-04-07 10:55:59.672148	27	t	\N	0	74	123
1341	67	437	2016-04-07 10:55:59.691113	\N	2016-04-07 10:55:59.691113	27	t	\N	0	74	123
1342	68	437	2016-04-07 10:55:59.705837	\N	2016-04-07 10:55:59.705837	27	t	\N	1500	74	123
1348	62	437	2016-04-14 02:30:43.74918	437	2016-04-14 05:27:26.755722	27	t	\N	5	73	47
1349	63	437	2016-04-14 02:30:43.76633	437	2016-04-14 05:27:26.770938	27	t	\N	0	73	47
1343	57	437	2016-04-14 02:30:43.676736	437	2016-04-14 05:27:26.670939	27	t	\N	1	73	47
1344	58	437	2016-04-14 02:30:43.702979	437	2016-04-14 05:27:26.688711	27	t	\N	0	73	47
1345	59	437	2016-04-14 02:30:43.715146	437	2016-04-14 05:27:26.703002	27	t	\N	2	73	47
1346	60	437	2016-04-14 02:30:43.725361	437	2016-04-14 05:27:26.722321	27	t	\N	0	73	47
1347	61	437	2016-04-14 02:30:43.740055	437	2016-04-14 05:27:26.737163	27	t	\N	5	73	47
1350	64	437	2016-04-14 02:30:43.783294	437	2016-04-14 05:27:26.791707	27	t	\N	5	73	47
1351	65	437	2016-04-14 02:30:43.799339	437	2016-04-14 05:27:26.802647	27	t	\N	7	73	47
1352	66	437	2016-04-14 02:30:43.817592	437	2016-04-14 05:27:26.82119	27	t	\N	0	73	47
1353	67	437	2016-04-14 02:30:43.832706	437	2016-04-14 05:27:26.838105	27	t	\N	0	73	47
1354	68	437	2016-04-14 02:30:43.841309	437	2016-04-14 05:27:26.855628	27	t	\N	5	73	47
1355	57	437	2016-04-14 02:32:05.742526	437	2016-04-14 05:45:52.819259	27	t	\N	10	73	48
1356	58	437	2016-04-14 02:32:05.751809	437	2016-04-14 05:45:52.833091	27	t	\N	0	73	48
1357	59	437	2016-04-14 02:32:05.768061	437	2016-04-14 05:45:52.849592	27	t	\N	10	73	48
1358	60	437	2016-04-14 02:32:05.785778	437	2016-04-14 05:45:52.864579	27	t	\N	0	73	48
1359	61	437	2016-04-14 02:32:05.802795	437	2016-04-14 05:45:52.882548	27	t	\N	10	73	48
1360	62	437	2016-04-14 02:32:05.818302	437	2016-04-14 05:45:52.901926	27	t	\N	0	73	48
1361	63	437	2016-04-14 02:32:05.835176	437	2016-04-14 05:45:52.916899	27	t	\N	10	73	48
1362	64	437	2016-04-14 02:32:05.851883	437	2016-04-14 05:45:52.933524	27	t	\N	0	73	48
1363	65	437	2016-04-14 02:32:05.869266	437	2016-04-14 05:45:52.952115	27	t	\N	10	73	48
1364	66	437	2016-04-14 02:32:05.885068	437	2016-04-14 05:45:52.965595	27	t	\N	0	73	48
1365	67	437	2016-04-14 02:32:05.901886	437	2016-04-14 05:45:52.981151	27	t	\N	10	73	48
1366	68	437	2016-04-14 02:32:05.918517	437	2016-04-14 05:45:52.989194	27	t	\N	0	73	48
1379	57	437	2016-04-14 05:47:32.095133	\N	2016-04-14 05:47:32.095133	27	t	\N	10	73	49
1380	58	437	2016-04-14 05:47:32.110752	\N	2016-04-14 05:47:32.110752	27	t	\N	10	73	49
1381	59	437	2016-04-14 05:47:32.118603	\N	2016-04-14 05:47:32.118603	27	t	\N	10	73	49
1374	64	437	2016-04-14 05:28:42.104084	437	2016-04-14 06:58:15.75619	27	t	\N	1	74	124
1376	66	437	2016-04-14 05:28:42.145032	437	2016-04-14 06:58:15.787824	27	t	\N	1	74	124
1377	67	437	2016-04-14 05:28:42.154873	437	2016-04-14 06:58:15.805167	27	t	\N	5	74	124
1378	68	437	2016-04-14 05:28:42.173737	437	2016-04-14 06:58:15.823789	27	t	\N	30	74	124
1368	58	437	2016-04-14 05:28:42.004811	437	2016-04-14 06:58:15.649994	27	t	\N	1	74	124
1369	59	437	2016-04-14 05:28:42.029915	437	2016-04-14 06:58:15.663979	27	t	\N	1	74	124
1370	60	437	2016-04-14 05:28:42.047161	437	2016-04-14 06:58:15.681013	27	t	\N	1	74	124
1371	61	437	2016-04-14 05:28:42.065183	437	2016-04-14 06:58:15.698513	27	t	\N	1	74	124
1372	62	437	2016-04-14 05:28:42.080201	437	2016-04-14 06:58:15.714466	27	t	\N	1	74	124
1373	63	437	2016-04-14 05:28:42.095845	437	2016-04-14 06:58:15.73708	27	t	\N	1	74	124
1382	60	437	2016-04-14 05:47:32.127652	\N	2016-04-14 05:47:32.127652	27	t	\N	10	73	49
1383	61	437	2016-04-14 05:47:32.145747	\N	2016-04-14 05:47:32.145747	27	t	\N	10	73	49
1384	62	437	2016-04-14 05:47:32.163542	\N	2016-04-14 05:47:32.163542	27	t	\N	10	73	49
1385	63	437	2016-04-14 05:47:32.17902	\N	2016-04-14 05:47:32.17902	27	t	\N	10	73	49
1386	64	437	2016-04-14 05:47:32.195243	\N	2016-04-14 05:47:32.195243	27	t	\N	10	73	49
1387	65	437	2016-04-14 05:47:32.210307	\N	2016-04-14 05:47:32.210307	27	t	\N	10	73	49
1388	66	437	2016-04-14 05:47:32.219811	\N	2016-04-14 05:47:32.219811	27	t	\N	10	73	49
1389	67	437	2016-04-14 05:47:32.229062	\N	2016-04-14 05:47:32.229062	27	t	\N	50	73	49
1390	68	437	2016-04-14 05:47:32.243894	\N	2016-04-14 05:47:32.243894	27	t	\N	50	73	49
1367	57	437	2016-04-14 05:28:41.989538	437	2016-04-14 06:58:15.626799	27	t	\N	1	74	124
1375	65	437	2016-04-14 05:28:42.123323	437	2016-04-14 06:58:15.774254	27	t	\N	1	74	124
1391	57	437	2016-04-14 06:58:47.801809	\N	2016-04-14 06:58:47.801809	27	t	\N	0	74	125
1392	58	437	2016-04-14 06:58:47.83322	\N	2016-04-14 06:58:47.83322	27	t	\N	0	74	125
1393	59	437	2016-04-14 06:58:47.846668	\N	2016-04-14 06:58:47.846668	27	t	\N	0	74	125
1394	60	437	2016-04-14 06:58:47.863224	\N	2016-04-14 06:58:47.863224	27	t	\N	0	74	125
1395	61	437	2016-04-14 06:58:47.883095	\N	2016-04-14 06:58:47.883095	27	t	\N	0	74	125
1396	62	437	2016-04-14 06:58:47.896094	\N	2016-04-14 06:58:47.896094	27	t	\N	0	74	125
1397	63	437	2016-04-14 06:58:47.91333	\N	2016-04-14 06:58:47.91333	27	t	\N	0	74	125
1398	64	437	2016-04-14 06:58:47.932224	\N	2016-04-14 06:58:47.932224	27	t	\N	0	74	125
1399	65	437	2016-04-14 06:58:47.950132	\N	2016-04-14 06:58:47.950132	27	t	\N	0	74	125
1400	66	437	2016-04-14 06:58:47.966307	\N	2016-04-14 06:58:47.966307	27	t	\N	0	74	125
1401	67	437	2016-04-14 06:58:47.983177	\N	2016-04-14 06:58:47.983177	27	t	\N	1	74	125
1402	68	437	2016-04-14 06:58:47.997107	\N	2016-04-14 06:58:47.997107	27	t	\N	1	74	125
1403	57	437	2016-04-14 06:59:34.211678	437	2016-04-14 07:00:01.689774	27	t	\N	0	74	126
1404	58	437	2016-04-14 06:59:34.22222	437	2016-04-14 07:00:01.70909	27	t	\N	0	74	126
1405	59	437	2016-04-14 06:59:34.233766	437	2016-04-14 07:00:01.725593	27	t	\N	0	74	126
1406	60	437	2016-04-14 06:59:34.249086	437	2016-04-14 07:00:01.749176	27	t	\N	0	74	126
1407	61	437	2016-04-14 06:59:34.267824	437	2016-04-14 07:00:01.770298	27	t	\N	0	74	126
1408	62	437	2016-04-14 06:59:34.281421	437	2016-04-14 07:00:01.786516	27	t	\N	0	74	126
1409	63	437	2016-04-14 06:59:34.297069	437	2016-04-14 07:00:01.799134	27	t	\N	0	74	126
1410	64	437	2016-04-14 06:59:34.306442	437	2016-04-14 07:00:01.819787	27	t	\N	0	74	126
1411	65	437	2016-04-14 06:59:34.323078	437	2016-04-14 07:00:01.834392	27	t	\N	0	74	126
1412	66	437	2016-04-14 06:59:34.339446	437	2016-04-14 07:00:01.849778	27	t	\N	5	74	126
1413	67	437	2016-04-14 06:59:34.351026	437	2016-04-14 07:00:01.868048	27	t	\N	5	74	126
1414	68	437	2016-04-14 06:59:34.365118	437	2016-04-14 07:00:01.89333	27	t	\N	2	74	126
\.


--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('rendimiento_id_rendimiento_seq', 1414, true);


--
-- Data for Name: responsable; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY responsable (id_responsable, fk_persona_registro, fk_dir_responsable, fk_poa, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus, cod_dependencia_cruge, dependencia_cruge) FROM stdin;
38	437	11	39	437	\N	2016-04-07 10:12:07.824679	2016-04-07 10:12:07.824679	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
39	437	355	40	437	\N	2016-04-07 10:43:15.826452	2016-04-07 10:43:15.826452	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
40	437	355	41	437	\N	2016-04-14 02:07:41.774715	2016-04-14 02:07:41.774715	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('responsable_id_responsable_seq', 40, true);


--
-- Name: id_accion; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT id_accion PRIMARY KEY (id_accion);


--
-- Name: id_actividades; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT id_actividades PRIMARY KEY (id_actividades);


--
-- Name: id_comentarios; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT id_comentarios PRIMARY KEY (id_comentarios);


--
-- Name: id_estatus_poa; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT id_estatus_poa PRIMARY KEY (id_estatus_poa);


--
-- Name: id_maestro; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY maestro
    ADD CONSTRAINT id_maestro PRIMARY KEY (id_maestro);


--
-- Name: id_poa; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT id_poa PRIMARY KEY (id_poa);


--
-- Name: id_rendimiento; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT id_rendimiento PRIMARY KEY (id_rendimiento);


--
-- Name: id_responsable; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT id_responsable PRIMARY KEY (id_responsable);


--
-- Name: _RETURN; Type: RULE; Schema: poa; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO vsw_admin DO INSTEAD  SELECT pro.id_poa,
    pro.nombre,
    res.cod_dependencia_cruge,
    res.dependencia_cruge,
    est.fk_estatus_poa,
    maest.descripcion,
    pro.fk_tipo_poa,
    te.descripcion AS tipo_poa,
    date_part('year'::text, pro.fecha_inicio) AS anio
   FROM ((((((poa pro
     LEFT JOIN responsable res ON ((res.fk_poa = pro.id_poa)))
     LEFT JOIN estatus_poa est ON (((est.fk_poa = pro.id_poa) AND (est.created_date = ( SELECT max(est2.created_date) AS max
           FROM estatus_poa est2
          WHERE (est.fk_poa = est2.fk_poa)
          GROUP BY est2.fk_poa)))))
     LEFT JOIN maestro maest ON ((maest.id_maestro = est.fk_estatus_poa)))
     LEFT JOIN maestro te ON ((te.id_maestro = pro.fk_tipo_poa)))
     LEFT JOIN acciones acc ON ((acc.fk_poa = pro.id_poa)))
     LEFT JOIN actividades act ON ((act.fk_accion = acc.id_accion)))
  GROUP BY pro.id_poa, pro.nombre, res.cod_dependencia_cruge, res.dependencia_cruge, est.fk_estatus_poa, maest.descripcion, pro.fk_tipo_poa, te.descripcion
  ORDER BY pro.id_poa;


--
-- Name: actividades_fk_status_fkey; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT actividades_fk_status_fkey FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_accion; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT fk_accion FOREIGN KEY (fk_accion) REFERENCES acciones(id_accion);


--
-- Name: fk_ambito; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_ambito FOREIGN KEY (fk_ambito) REFERENCES maestro(id_maestro);


--
-- Name: fk_dir_responsable; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_dir_responsable FOREIGN KEY (fk_dir_responsable) REFERENCES public.cruge_user(iduser);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_estatus_poa FOREIGN KEY (fk_estatus_poa) REFERENCES maestro(id_maestro);


--
-- Name: fk_mes; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_mes FOREIGN KEY (fk_meses) REFERENCES maestro(id_maestro);


--
-- Name: fk_persona_registro; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_persona_registro FOREIGN KEY (fk_persona_registro) REFERENCES public.cruge_user(iduser);


--
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_tipo_entidad; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_tipo_entidad FOREIGN KEY (fk_tipo_entidad) REFERENCES maestro(id_maestro);


--
-- Name: fk_tipo_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_tipo_poa FOREIGN KEY (fk_tipo_poa) REFERENCES maestro(id_maestro);


--
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES maestro(id_maestro);


--
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES maestro(id_maestro);


--
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES maestro(id_maestro);


--
-- PostgreSQL database dump complete
--

