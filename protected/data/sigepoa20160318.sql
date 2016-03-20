--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-03-18 15:48:48 VET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 10 (class 2615 OID 486464)
-- Name: poa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA poa;


ALTER SCHEMA poa OWNER TO postgres;

SET search_path = poa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 248 (class 1259 OID 487650)
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
    meta character varying(500),
    bien_servicio character varying(200)
);


ALTER TABLE acciones OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 487662)
-- Name: acciones_id_accion_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE acciones_id_accion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acciones_id_accion_seq OWNER TO postgres;

--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 249
-- Name: acciones_id_accion_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE acciones_id_accion_seq OWNED BY acciones.id_accion;


--
-- TOC entry 250 (class 1259 OID 487667)
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


ALTER TABLE actividades OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 487676)
-- Name: actividades_id_actividades_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE actividades_id_actividades_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actividades_id_actividades_seq OWNER TO postgres;

--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 251
-- Name: actividades_id_actividades_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE actividades_id_actividades_seq OWNED BY actividades.id_actividades;


--
-- TOC entry 252 (class 1259 OID 487681)
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


ALTER TABLE comentarios OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 487693)
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE comentarios_id_comentarios_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comentarios_id_comentarios_seq OWNER TO postgres;

--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 253
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE comentarios_id_comentarios_seq OWNED BY comentarios.id_comentarios;


--
-- TOC entry 267 (class 1259 OID 1357127)
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


ALTER TABLE estatus_poa OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 1357125)
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE estatus_poa_id_estatus_poa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estatus_poa_id_estatus_poa_seq OWNER TO postgres;

--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 266
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE estatus_poa_id_estatus_poa_seq OWNED BY estatus_poa.id_estatus_poa;


--
-- TOC entry 254 (class 1259 OID 487709)
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


ALTER TABLE maestro OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 487724)
-- Name: maestro_id_maestro_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE maestro_id_maestro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maestro_id_maestro_seq OWNER TO postgres;

--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 255
-- Name: maestro_id_maestro_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE maestro_id_maestro_seq OWNED BY maestro.id_maestro;


--
-- TOC entry 262 (class 1259 OID 1356420)
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
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE poa OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 1356418)
-- Name: poa_id_poa_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE poa_id_poa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa_id_poa_seq OWNER TO postgres;

--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 261
-- Name: poa_id_poa_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE poa_id_poa_seq OWNED BY poa.id_poa;


--
-- TOC entry 256 (class 1259 OID 487746)
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


ALTER TABLE rendimiento OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 487752)
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE rendimiento_id_rendimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rendimiento_id_rendimiento_seq OWNER TO postgres;

--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 257
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE rendimiento_id_rendimiento_seq OWNED BY rendimiento.id_rendimiento;


--
-- TOC entry 258 (class 1259 OID 487757)
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


ALTER TABLE responsable OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 487766)
-- Name: responsable_id_responsable_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE responsable_id_responsable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE responsable_id_responsable_seq OWNER TO postgres;

--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 259
-- Name: responsable_id_responsable_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE responsable_id_responsable_seq OWNED BY responsable.id_responsable;


--
-- TOC entry 263 (class 1259 OID 1356504)
-- Name: vsw_acciones; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_acciones AS
 SELECT ac.id_accion,
    ac.nombre_accion,
    ac.fk_unidad_medida,
    mt.descripcion AS unidad_medida,
    ac.fk_ambito,
    am.descripcion AS ambito,
    ac.meta,
    ac.bien_servicio,
    ac.cantidad,
    ac.fk_poa
   FROM ((acciones ac
     LEFT JOIN maestro mt ON ((mt.id_maestro = ac.fk_unidad_medida)))
     LEFT JOIN maestro am ON ((am.id_maestro = ac.fk_ambito)))
  ORDER BY ac.id_accion;


ALTER TABLE vsw_acciones OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 1356509)
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


ALTER TABLE vsw_actividades OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 1360810)
-- Name: vsw_admin; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_admin AS
 SELECT pro.id_poa,
    pro.nombre,
    res.cod_dependencia_cruge,
    res.dependencia_cruge,
    est.fk_estatus_poa,
    maest.descripcion,
    pro.fk_tipo_poa,
    te.descripcion AS tipo_poa
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


ALTER TABLE vsw_admin OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 487789)
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


ALTER TABLE vsw_personal OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 1357969)
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
    per_dir.dependencia
   FROM ((((((poa pro
     LEFT JOIN maestro ms ON ((ms.id_maestro = pro.fk_tipo_poa)))
     LEFT JOIN responsable res ON ((res.fk_poa = pro.id_poa)))
     LEFT JOIN public.cruge_user user_res ON ((user_res.iduser = res.fk_persona_registro)))
     LEFT JOIN public.cruge_user user_dir ON ((user_dir.iduser = res.fk_dir_responsable)))
     LEFT JOIN vsw_personal per ON ((per.id_persona = user_res.id_persona)))
     LEFT JOIN vsw_personal per_dir ON ((per_dir.id_persona = user_dir.id_persona)));


ALTER TABLE vsw_poa OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 1356530)
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


ALTER TABLE vsw_poa2 OWNER TO postgres;

--
-- TOC entry 2208 (class 2604 OID 487807)
-- Name: id_accion; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones ALTER COLUMN id_accion SET DEFAULT nextval('acciones_id_accion_seq'::regclass);


--
-- TOC entry 2212 (class 2604 OID 487808)
-- Name: id_actividades; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades ALTER COLUMN id_actividades SET DEFAULT nextval('actividades_id_actividades_seq'::regclass);


--
-- TOC entry 2216 (class 2604 OID 487812)
-- Name: id_comentarios; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios ALTER COLUMN id_comentarios SET DEFAULT nextval('comentarios_id_comentarios_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 1357130)
-- Name: id_estatus_poa; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa ALTER COLUMN id_estatus_poa SET DEFAULT nextval('estatus_poa_id_estatus_poa_seq'::regclass);


--
-- TOC entry 2220 (class 2604 OID 487817)
-- Name: id_maestro; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY maestro ALTER COLUMN id_maestro SET DEFAULT nextval('maestro_id_maestro_seq'::regclass);


--
-- TOC entry 2229 (class 2604 OID 1356423)
-- Name: id_poa; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa ALTER COLUMN id_poa SET DEFAULT nextval('poa_id_poa_seq'::regclass);


--
-- TOC entry 2224 (class 2604 OID 487822)
-- Name: id_rendimiento; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento ALTER COLUMN id_rendimiento SET DEFAULT nextval('rendimiento_id_rendimiento_seq'::regclass);


--
-- TOC entry 2228 (class 2604 OID 487823)
-- Name: id_responsable; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable ALTER COLUMN id_responsable SET DEFAULT nextval('responsable_id_responsable_seq'::regclass);


--
-- TOC entry 2401 (class 0 OID 487650)
-- Dependencies: 248
-- Data for Name: acciones; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY acciones (id_accion, nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, meta, bien_servicio) FROM stdin;
1	ttttt	37	20	47	7	2	2016-03-18 15:07:50.31494	2	2016-03-18 15:07:50.31494	12	t	tttt	ttt
2	fff	36	20	47	8	437	2016-03-18 15:08:55.29337	437	2016-03-18 15:08:55.29337	12	t	fff	fff
3	oooo	37	50	47	8	437	2016-03-18 15:12:03.584809	437	2016-03-18 15:12:03.584809	12	t	oooo	ooooo
4	oooo	37	50	47	8	437	2016-03-18 15:13:14.691363	437	2016-03-18 15:13:14.691363	12	t	oooo	ooooo
5	ddddd	36	20	47	9	437	2016-03-18 15:39:41.023316	437	2016-03-18 15:39:41.023316	12	t	dddd	ddd
\.


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 249
-- Name: acciones_id_accion_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('acciones_id_accion_seq', 5, true);


--
-- TOC entry 2403 (class 0 OID 487667)
-- Dependencies: 250
-- Data for Name: actividades; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY actividades (id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
\.


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 251
-- Name: actividades_id_actividades_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('actividades_id_actividades_seq', 1, false);


--
-- TOC entry 2405 (class 0 OID 487681)
-- Dependencies: 252
-- Data for Name: comentarios; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY comentarios (id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_poa, fk_tipo_entidad) FROM stdin;
\.


--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 253
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentarios_seq', 1, false);


--
-- TOC entry 2416 (class 0 OID 1357127)
-- Dependencies: 267
-- Data for Name: estatus_poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY estatus_poa (id_estatus_poa, fk_estatus_poa, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_tipo_entidad) FROM stdin;
1	50	1	437	2016-03-17 15:34:39.344704	\N	2016-03-17 15:34:39.344704	21	t	8
2	50	2	437	2016-03-17 15:41:35.482654	\N	2016-03-17 15:41:35.482654	21	t	8
3	50	3	437	2016-03-18 13:10:12.975425	\N	2016-03-18 13:10:12.975425	21	t	8
4	50	4	437	2016-03-18 13:20:21.048314	\N	2016-03-18 13:20:21.048314	21	t	8
5	50	5	437	2016-03-18 13:36:52.570156	\N	2016-03-18 13:36:52.570156	21	t	8
6	50	6	437	2016-03-18 14:07:02.846511	\N	2016-03-18 14:07:02.846511	21	t	8
7	50	7	437	2016-03-18 14:25:02.819568	\N	2016-03-18 14:25:02.819568	21	t	8
8	50	8	437	2016-03-18 15:08:25.341241	\N	2016-03-18 15:08:25.341241	21	t	8
9	50	9	437	2016-03-18 15:39:04.243331	\N	2016-03-18 15:39:04.243331	21	t	8
\.


--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 266
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('estatus_poa_id_estatus_poa_seq', 9, true);


--
-- TOC entry 2407 (class 0 OID 487709)
-- Dependencies: 254
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
56	MESES	0	12	1	2016-03-14 10:06:57.834732	\N	2016-03-14 10:06:57.834732	t
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
\.


--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 255
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 74, true);


--
-- TOC entry 2414 (class 0 OID 1356420)
-- Dependencies: 262
-- Data for Name: poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY poa (id_poa, nombre, fk_tipo_poa, obj_historico, obj_estrategico, obj_general, obj_institucional, descripcion, fecha_inicio, fecha_final, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
1	fhgfg	71	\N	\N	gfhgfhfg	\N	fghfghfgh	\N	\N	437	2016-03-17 15:34:39.256997	\N	2016-03-17 15:34:39.256997	24	t
2	ggffgh	71	\N	\N	fghfghfgh	\N	fgghfgfg fgg  fg	\N	\N	437	2016-03-17 15:41:35.421826	\N	2016-03-17 15:41:35.421826	24	t
3	Proyecto	70	Objetivo Historico	Objetivo Estrategico	Objetivo General	Objetivo Institucional 	Descripcion	2016-01-01 00:00:00	2016-11-30 00:00:00	437	2016-03-18 13:10:12.854148	\N	2016-03-18 13:10:12.854148	24	t
4	ddsfsdfsdsdfsdfsdfsd	70	sdfdsfdf	eeesdf	sdfdsseeef	eesfd	sefde	2016-01-01 00:00:00	2016-12-31 00:00:00	437	2016-03-18 13:20:20.98218	\N	2016-03-18 13:20:20.98218	24	t
5	fghfghfxg fghfghfg gggg 	70	gggggg	g ghgh 	dfgfggfh gfhgfhfgh fgfgfjhf g	gfgtt tt 	gghg	2016-01-01 00:00:00	2016-12-30 00:00:00	437	2016-03-18 13:36:52.507036	\N	2016-03-18 13:36:52.507036	24	t
6	Acción Centralizada	71	\N	\N	Objetivo Genral	\N	Descripcion	\N	\N	437	2016-03-18 14:07:02.784522	\N	2016-03-18 14:07:02.784522	24	t
7	Nombre Acción Centralizada	71	\N	\N	Objetivo General  Acción Centralizada	\N	 Acción Centralizada	\N	\N	437	2016-03-18 14:25:02.751504	\N	2016-03-18 14:25:02.751504	24	t
8	ffff	71	\N	\N	ffff	\N	fff	\N	\N	437	2016-03-18 15:08:25.268493	\N	2016-03-18 15:08:25.268493	24	t
9	gfgfgfg	71	\N	\N	fgfgfgfg	\N	fgfgfg	\N	\N	437	2016-03-18 15:39:04.188407	\N	2016-03-18 15:39:04.188407	24	t
\.


--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 261
-- Name: poa_id_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('poa_id_poa_seq', 9, true);


--
-- TOC entry 2409 (class 0 OID 487746)
-- Dependencies: 256
-- Data for Name: rendimiento; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY rendimiento (id_rendimiento, fk_meses, created_by, created_date, modified_by, modified_date, fk_status, es_activo, cantidad_cumplida, cantidad_programada, fk_tipo_entidad, id_entidad) FROM stdin;
1	57	437	2016-03-18 15:13:14.720179	\N	2016-03-18 15:13:14.720179	27	t	\N	1	73	4
2	58	437	2016-03-18 15:13:14.736223	\N	2016-03-18 15:13:14.736223	27	t	\N	2	73	4
3	59	437	2016-03-18 15:13:14.753691	\N	2016-03-18 15:13:14.753691	27	t	\N	3	73	4
4	60	437	2016-03-18 15:13:14.769547	\N	2016-03-18 15:13:14.769547	27	t	\N	4	73	4
5	61	437	2016-03-18 15:13:14.786724	\N	2016-03-18 15:13:14.786724	27	t	\N	5	73	4
6	62	437	2016-03-18 15:13:14.802944	\N	2016-03-18 15:13:14.802944	27	t	\N	6	73	4
7	63	437	2016-03-18 15:13:14.819792	\N	2016-03-18 15:13:14.819792	27	t	\N	7	73	4
8	64	437	2016-03-18 15:13:14.837005	\N	2016-03-18 15:13:14.837005	27	t	\N	8	73	4
9	65	437	2016-03-18 15:13:14.853517	\N	2016-03-18 15:13:14.853517	27	t	\N	9	73	4
10	66	437	2016-03-18 15:13:14.869926	\N	2016-03-18 15:13:14.869926	27	t	\N	20	73	4
11	67	437	2016-03-18 15:13:14.887138	\N	2016-03-18 15:13:14.887138	27	t	\N	21	73	4
12	68	437	2016-03-18 15:13:14.903743	\N	2016-03-18 15:13:14.903743	27	t	\N	22	73	4
13	57	437	2016-03-18 15:39:41.048202	\N	2016-03-18 15:39:41.048202	27	t	\N	20	73	5
14	58	437	2016-03-18 15:39:41.065365	\N	2016-03-18 15:39:41.065365	27	t	\N	20	73	5
15	59	437	2016-03-18 15:39:41.08175	\N	2016-03-18 15:39:41.08175	27	t	\N	20	73	5
16	60	437	2016-03-18 15:39:41.098473	\N	2016-03-18 15:39:41.098473	27	t	\N	20	73	5
17	61	437	2016-03-18 15:39:41.11524	\N	2016-03-18 15:39:41.11524	27	t	\N	20	73	5
18	62	437	2016-03-18 15:39:41.131831	\N	2016-03-18 15:39:41.131831	27	t	\N	20	73	5
19	63	437	2016-03-18 15:39:41.148342	\N	2016-03-18 15:39:41.148342	27	t	\N	20	73	5
20	64	437	2016-03-18 15:39:41.165712	\N	2016-03-18 15:39:41.165712	27	t	\N	20	73	5
21	65	437	2016-03-18 15:39:41.182617	\N	2016-03-18 15:39:41.182617	27	t	\N	20	73	5
22	66	437	2016-03-18 15:39:41.199943	\N	2016-03-18 15:39:41.199943	27	t	\N	20	73	5
23	67	437	2016-03-18 15:39:41.215913	\N	2016-03-18 15:39:41.215913	27	t	\N	20	73	5
24	68	437	2016-03-18 15:39:41.232492	\N	2016-03-18 15:39:41.232492	27	t	\N	20	73	5
\.


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 257
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('rendimiento_id_rendimiento_seq', 24, true);


--
-- TOC entry 2411 (class 0 OID 487757)
-- Dependencies: 258
-- Data for Name: responsable; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY responsable (id_responsable, fk_persona_registro, fk_dir_responsable, fk_poa, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus, cod_dependencia_cruge, dependencia_cruge) FROM stdin;
1	437	355	1	437	\N	2016-03-17 15:34:39.311166	2016-03-17 15:34:39.311166	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
2	437	355	2	437	\N	2016-03-17 15:41:35.456062	2016-03-17 15:41:35.456062	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
3	437	355	3	437	\N	2016-03-18 13:10:12.930786	2016-03-18 13:10:12.930786	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
4	437	355	4	437	\N	2016-03-18 13:20:21.020927	2016-03-18 13:20:21.020927	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
5	437	355	5	437	\N	2016-03-18 13:36:52.544142	2016-03-18 13:36:52.544142	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
6	437	355	6	437	\N	2016-03-18 14:07:02.818916	2016-03-18 14:07:02.818916	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
7	437	355	7	437	\N	2016-03-18 14:25:02.792303	2016-03-18 14:25:02.792303	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
8	437	355	8	437	\N	2016-03-18 15:08:25.313799	2016-03-18 15:08:25.313799	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
9	437	355	9	437	\N	2016-03-18 15:39:04.216197	2016-03-18 15:39:04.216197	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 259
-- Name: responsable_id_responsable_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('responsable_id_responsable_seq', 9, true);


--
-- TOC entry 2238 (class 2606 OID 487849)
-- Name: id_accion; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT id_accion PRIMARY KEY (id_accion);


--
-- TOC entry 2240 (class 2606 OID 487854)
-- Name: id_actividades; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT id_actividades PRIMARY KEY (id_actividades);


--
-- TOC entry 2242 (class 2606 OID 487859)
-- Name: id_comentarios; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT id_comentarios PRIMARY KEY (id_comentarios);


--
-- TOC entry 2252 (class 2606 OID 1357303)
-- Name: id_estatus_poa; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT id_estatus_poa PRIMARY KEY (id_estatus_poa);


--
-- TOC entry 2244 (class 2606 OID 487869)
-- Name: id_maestro; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY maestro
    ADD CONSTRAINT id_maestro PRIMARY KEY (id_maestro);


--
-- TOC entry 2250 (class 2606 OID 1356434)
-- Name: id_poa; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT id_poa PRIMARY KEY (id_poa);


--
-- TOC entry 2246 (class 2606 OID 487874)
-- Name: id_rendimiento; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT id_rendimiento PRIMARY KEY (id_rendimiento);


--
-- TOC entry 2248 (class 2606 OID 487879)
-- Name: id_responsable; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT id_responsable PRIMARY KEY (id_responsable);


--
-- TOC entry 2257 (class 2606 OID 487888)
-- Name: actividades_fk_status_fkey; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT actividades_fk_status_fkey FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2258 (class 2606 OID 487893)
-- Name: fk_accion; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT fk_accion FOREIGN KEY (fk_accion) REFERENCES acciones(id_accion);


--
-- TOC entry 2253 (class 2606 OID 487906)
-- Name: fk_ambito; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_ambito FOREIGN KEY (fk_ambito) REFERENCES maestro(id_maestro);


--
-- TOC entry 2265 (class 2606 OID 487911)
-- Name: fk_dir_responsable; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_dir_responsable FOREIGN KEY (fk_dir_responsable) REFERENCES public.cruge_user(iduser);


--
-- TOC entry 2260 (class 2606 OID 487919)
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2254 (class 2606 OID 487924)
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2266 (class 2606 OID 487932)
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- TOC entry 2270 (class 2606 OID 1356440)
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2271 (class 2606 OID 1357134)
-- Name: fk_estatus_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_estatus_poa FOREIGN KEY (fk_estatus_poa) REFERENCES maestro(id_maestro);


--
-- TOC entry 2262 (class 2606 OID 487937)
-- Name: fk_mes; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_mes FOREIGN KEY (fk_meses) REFERENCES maestro(id_maestro);


--
-- TOC entry 2267 (class 2606 OID 487945)
-- Name: fk_persona_registro; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_persona_registro FOREIGN KEY (fk_persona_registro) REFERENCES public.cruge_user(iduser);


--
-- TOC entry 2256 (class 2606 OID 1356474)
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- TOC entry 2261 (class 2606 OID 1356479)
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- TOC entry 2268 (class 2606 OID 1356499)
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- TOC entry 2272 (class 2606 OID 1357139)
-- Name: fk_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_poa FOREIGN KEY (fk_poa) REFERENCES poa(id_poa);


--
-- TOC entry 2263 (class 2606 OID 487984)
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2273 (class 2606 OID 1357144)
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_poa
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- TOC entry 2264 (class 2606 OID 1360707)
-- Name: fk_tipo_entidad; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_tipo_entidad FOREIGN KEY (fk_tipo_entidad) REFERENCES maestro(id_maestro);


--
-- TOC entry 2269 (class 2606 OID 1356435)
-- Name: fk_tipo_poa; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_tipo_poa FOREIGN KEY (fk_tipo_poa) REFERENCES maestro(id_maestro);


--
-- TOC entry 2255 (class 2606 OID 488002)
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES maestro(id_maestro);


--
-- TOC entry 2259 (class 2606 OID 488010)
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES maestro(id_maestro);


-- Completed on 2016-03-18 15:48:51 VET

--
-- PostgreSQL database dump complete
--

