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
    nombre_accion character varying(800) NOT NULL,
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
    actividad character varying(800),
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
    es_activo boolean DEFAULT true NOT NULL,
    descripcion2 character varying(200)
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
    nombre character varying(800) NOT NULL,
    fk_tipo_poa integer NOT NULL,
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
    cantidad integer,
    fk_historico integer,
    fk_nacional integer,
    fk_estrategico integer,
    fk_general integer,
    fk_institucional integer,
    fk_estrategico_mr integer
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
    nombre character varying(800),
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
-- Name: vsw_cruge_fieldvalues; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_cruge_fieldvalues AS
 SELECT field1.value AS dependencia,
    field2.value AS cargo,
    field2.iduser
   FROM (public.cruge_fieldvalue field1
     JOIN public.cruge_fieldvalue field2 ON ((field1.iduser = field2.iduser)))
  WHERE ((field1.idfield = 1) AND (field2.idfield = 0))
  GROUP BY field1.value, field2.value, field2.iduser
  ORDER BY field2.iduser;


ALTER TABLE poa.vsw_cruge_fieldvalues OWNER TO postgres;

--
-- Name: vsw_pdf_proyecto; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_pdf_proyecto AS
 SELECT pa.id_poa,
    pa.nombre AS nombre_proyecto,
    acc.nombre_accion,
    obj_general.descripcion AS objetivo_general,
    obj_historico.descripcion AS objetivo_historico,
    acc.fk_unidad_medida,
    ms.descripcion AS unidad_medida,
    act.actividad,
    act.fk_unidad_medida AS unidad_actividad,
    ms2.descripcion AS unidad_actividades,
    res.dependencia_cruge AS unidad_ejecutora
   FROM ((((((((((acciones acc
     LEFT JOIN poa pa ON ((pa.id_poa = acc.fk_poa)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = acc.fk_unidad_medida)))
     LEFT JOIN actividades act ON ((act.fk_accion = acc.id_accion)))
     LEFT JOIN responsable res ON ((res.fk_poa = pa.id_poa)))
     LEFT JOIN maestro ms2 ON ((ms2.id_maestro = act.fk_unidad_medida)))
     LEFT JOIN maestro obj_historico ON ((obj_historico.id_maestro = pa.fk_historico)))
     LEFT JOIN maestro obj_nacional ON ((obj_nacional.id_maestro = pa.fk_nacional)))
     LEFT JOIN maestro obj_estrategico ON ((obj_estrategico.id_maestro = pa.fk_estrategico)))
     LEFT JOIN maestro obj_general ON ((obj_general.id_maestro = pa.fk_general)))
     LEFT JOIN maestro obj_institucional ON ((obj_institucional.id_maestro = pa.fk_institucional)));


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
    pro.fk_historico,
    obj_historico.descripcion AS obj_historico,
    pro.fk_nacional,
    obj_nacional.descripcion AS obj_nacional,
    pro.fk_estrategico,
    obj_estrategico.descripcion AS obj_estrategico,
    pro.fk_general,
    obj_general.descripcion AS obj_general,
    pro.fk_estrategico_mr,
    obj_estrategico_mr.descripcion AS obj_estrategico_mr,
    pro.fk_institucional,
    obj_institucional.descripcion AS obj_institucional,
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
   FROM (((((((((((((poa pro
     LEFT JOIN maestro ms ON ((ms.id_maestro = pro.fk_tipo_poa)))
     LEFT JOIN responsable res ON ((res.fk_poa = pro.id_poa)))
     LEFT JOIN public.cruge_user user_res ON ((user_res.iduser = res.fk_persona_registro)))
     LEFT JOIN public.cruge_user user_dir ON ((user_dir.iduser = res.fk_dir_responsable)))
     LEFT JOIN vsw_personal per ON ((per.id_persona = user_res.id_persona)))
     LEFT JOIN vsw_personal per_dir ON ((per_dir.id_persona = user_dir.id_persona)))
     LEFT JOIN maestro ms2 ON ((ms2.id_maestro = pro.fk_unidad_medida)))
     LEFT JOIN maestro obj_historico ON ((obj_historico.id_maestro = pro.fk_historico)))
     LEFT JOIN maestro obj_nacional ON ((obj_nacional.id_maestro = pro.fk_nacional)))
     LEFT JOIN maestro obj_estrategico ON ((obj_estrategico.id_maestro = pro.fk_estrategico)))
     LEFT JOIN maestro obj_general ON ((obj_general.id_maestro = pro.fk_general)))
     LEFT JOIN maestro obj_institucional ON ((obj_institucional.id_maestro = pro.fk_institucional)))
     LEFT JOIN maestro obj_estrategico_mr ON ((obj_estrategico_mr.id_maestro = pro.fk_estrategico_mr)));


ALTER TABLE poa.vsw_poa OWNER TO postgres;

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
63	Accion 01	1043	45	47	53	437	2016-06-26 03:07:43.857358	\N	2016-06-26 03:07:43.857358	12	t	Bien o Servicio 01
64	Accion 02	1043	1200	47	53	437	2016-06-26 03:10:44.295611	\N	2016-06-26 03:10:44.295611	12	t	Bien o Servicio 02
\.


--
-- Name: acciones_id_accion_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('acciones_id_accion_seq', 64, true);


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY actividades (id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
162	Actividad 01.1	1043	3	63	437	2016-06-26 03:08:12.792436	\N	2016-06-26 03:08:12.792436	15	t
163	Actividad 01.2	1043	7	63	437	2016-06-26 03:08:30.202814	\N	2016-06-26 03:08:30.202814	15	t
164	Actividad 01.3	1043	11	63	437	2016-06-26 03:08:49.51334	\N	2016-06-26 03:08:49.51334	15	t
166	Actividad 01.4	1043	24	63	437	2016-06-26 03:09:53.670251	\N	2016-06-26 03:09:53.670251	15	t
167	Actividad 02.1	1043	300	64	437	2016-06-26 03:11:14.879184	\N	2016-06-26 03:11:14.879184	15	t
168	Actividad 02.2	1043	300	64	437	2016-06-26 03:11:25.708645	\N	2016-06-26 03:11:25.708645	15	t
169	Actividad 02.3	1043	300	64	437	2016-06-26 03:11:41.946113	\N	2016-06-26 03:11:41.946113	15	t
171	Actividad 02.4	1043	300	64	437	2016-06-26 03:12:09.592721	\N	2016-06-26 03:12:09.592721	15	t
\.


--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('actividades_id_actividades_seq', 171, true);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY comentarios (id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_poa, fk_tipo_entidad) FROM stdin;
48	Rechazado	355	2016-06-26 03:14:10.548913	\N	2016-06-26 03:14:10.548913	18	t	53	9
49		355	2016-06-26 03:16:02.467802	\N	2016-06-26 03:16:02.467802	18	t	53	9
50		481	2016-06-26 03:17:41.872197	\N	2016-06-26 03:17:41.872197	18	t	53	10
\.


--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentarios_seq', 50, true);


--
-- Data for Name: estatus_poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY estatus_poa (id_estatus_poa, fk_estatus_poa, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_tipo_entidad) FROM stdin;
128	50	53	437	2016-06-26 03:07:00.923815	\N	2016-06-26 03:07:00.923815	21	t	8
129	51	53	437	2016-06-26 03:13:27.887214	\N	2016-06-26 03:13:27.887214	21	t	8
130	55	53	355	2016-06-26 03:14:10.524527	\N	2016-06-26 03:14:10.524527	21	t	9
131	51	53	437	2016-06-26 03:15:30.764084	\N	2016-06-26 03:15:30.764084	21	t	8
132	54	53	355	2016-06-26 03:16:02.441269	\N	2016-06-26 03:16:02.441269	21	t	9
133	52	53	481	2016-06-26 03:17:41.854028	\N	2016-06-26 03:17:41.854028	21	t	10
\.


--
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('estatus_poa_id_estatus_poa_seq', 133, true);


--
-- Data for Name: maestro; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY maestro (id_maestro, descripcion, padre, hijo, created_by, created_date, modified_by, modified_date, es_activo, descripcion2) FROM stdin;
1	NACIONALIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
2	V	1	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
3	E	1	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
4	SEXO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
5	F	4	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
6	M	4	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
7	TIPO ENTIDAD	0	3	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
8	ANALISTA	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
9	DIRECCION	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
10	PLANIFICACION	7	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
11	ESTATUS ACCION	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
12	ACTIVO	11	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
13	INACTIVO	11	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
14	ESTATUS ACTIVIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
15	ACTIVO	14	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
16	INACTIVO	14	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
17	ESTATUS COMENTARIO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
18	ACTIVO	17	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
19	INACTIVO	17	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
21	ACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
22	INACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
24	ACTIVO	23	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
25	INACTIVO	23	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
26	ESTATUS RENDIMIENTO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
27	ACTIVO	26	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
28	INACTIVO	26	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
29	ESTATUS RESPONSABLE	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
30	ACTIVO	29	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
31	INACTIVO	29	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
32	ESTATUS UNIDAD	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
33	ACTIVO	32	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
34	INACTIVO	32	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
35	UNIDAD DE MEDIDA	0	10	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
36	CONVENIO	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
37	POLITICA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
38	BOLETIN	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
39	TALLER	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
41	INFORME	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
42	SISTEMA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
43	MINUTA	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
44	SOLICITUD	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
45	CUADRO	35	0	1	2016-02-22 01:40:23.839546	\N	2016-02-22 01:40:23.839546	t	\N
46	TIPO AMBITO	0	2	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t	\N
47	NACIONAL	46	0	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t	\N
48	INTERNACIONAL	46	0	1	2016-02-22 01:51:38.847367	\N	2016-02-22 01:51:38.847367	t	\N
50	NUEVO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t	\N
52	APROBADO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t	\N
53	REVISADO	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t	\N
49	ESTATUS EVALUACION	0	5	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t	\N
51	ENVIADO AL DIRECTOR(A)	49	0	1	2016-02-22 13:02:11.295578	\N	2016-02-22 13:02:11.295578	t	\N
54	ENVIADO A PLANIFICACIÓN	49	0	1	2016-03-11 03:42:38.704464	\N	2016-03-11 03:42:38.704464	t	\N
55	RECHAZADO	49	0	1	2016-03-11 14:18:56.849685	\N	2016-03-11 14:18:56.849685	t	\N
23	ESTATUS POA	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
20	ESTATUS TABLA ESTATUS_POA	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t	\N
69	TIPO POA	0	2	1	2016-03-15 16:14:13.974914	\N	2016-03-15 16:14:13.974914	t	\N
70	PROYECTO	69	0	1	2016-03-15 16:15:54.206749	\N	2016-03-15 16:15:54.206749	t	\N
71	ACCION CENTRALIZADA	69	0	1	2016-03-15 16:16:19.926663	\N	2016-03-15 16:16:19.926663	t	\N
73	ACCION	72	0	1	2016-03-18 12:18:28.719331	\N	2016-03-18 12:18:28.719331	t	\N
74	ACTIVIDAD 	72	0	1	2016-03-18 12:18:44.247239	\N	2016-03-18 12:18:44.247239	t	\N
72	TIPO RENDIMIENTO	0	2	1	2016-03-18 12:17:32.519334	\N	2016-03-18 12:17:32.519334	t	\N
76	TRIMESTRE I	75	0	1	2016-03-29 03:19:37.751389	\N	2016-03-29 03:19:37.751389	t	\N
77	TRIMESTRE II	75	0	1	2016-03-29 03:19:47.975151	\N	2016-03-29 03:19:47.975151	t	\N
78	TRIMESTRE III	75	0	1	2016-03-29 03:19:58.268372	\N	2016-03-29 03:19:58.268372	t	\N
79	TRIMESTRE IV	75	0	1	2016-03-29 03:20:08.425526	\N	2016-03-29 03:20:08.425526	t	\N
81	SEMESTRE I	80	0	1	2016-03-29 03:20:50.006354	\N	2016-03-29 03:20:50.006354	t	\N
82	SEMESTRE II	80	0	1	2016-03-29 03:21:00.113966	\N	2016-03-29 03:21:00.113966	t	\N
83	MEDIDA TIEMPO	0	3	1	2016-03-29 03:21:40.827492	\N	2016-03-29 03:21:40.827492	t	\N
80	SEMESTRE	83	2	1	2016-03-29 03:20:26.261644	\N	2016-03-29 03:20:26.261644	t	\N
75	TRIMESTRE	83	4	1	2016-03-29 03:19:17.442634	\N	2016-03-29 03:19:17.442634	t	\N
56	MESES	83	12	1	2016-03-14 10:06:57.834732	\N	2016-03-14 10:06:57.834732	t	\N
40	 	35	0	1	2016-02-22 01:40:23.839546	481	2016-04-26 09:17:31.132792	f	\N
57	ENERO	56	0	1	2016-03-14 10:07:10.082581	\N	2016-03-14 10:07:10.082581	t	1
58	FEBRERO	56	0	1	2016-03-14 10:07:19.858357	\N	2016-03-14 10:07:19.858357	t	2
59	MARZO	56	0	1	2016-03-14 10:07:28.338305	\N	2016-03-14 10:07:28.338305	t	3
60	ABRIL	56	0	1	2016-03-14 10:07:35.650111	\N	2016-03-14 10:07:35.650111	t	4
61	MAYO	56	0	1	2016-03-14 10:07:41.905957	\N	2016-03-14 10:07:41.905957	t	5
62	JUNIO	56	0	1	2016-03-14 10:07:48.633965	\N	2016-03-14 10:07:48.633965	t	6
63	JULIO	56	0	1	2016-03-14 10:07:54.777846	\N	2016-03-14 10:07:54.777846	t	7
64	AGOSTO	56	0	1	2016-03-14 10:08:03.793658	\N	2016-03-14 10:08:03.793658	t	8
65	SEPTIEMBRE	56	0	1	2016-03-14 10:08:22.121565	\N	2016-03-14 10:08:22.121565	t	9
66	OCTUBRE	56	0	1	2016-03-14 10:08:30.465294	\N	2016-03-14 10:08:30.465294	t	10
67	NOVIEMBRE	56	0	1	2016-03-14 10:08:37.001253	\N	2016-03-14 10:08:37.001253	t	11
68	DICIEMBRE	56	0	1	2016-03-14 10:08:46.513118	\N	2016-03-14 10:08:46.513118	t	12
84	CON	35	0	481	2016-04-26 09:17:12.908853	481	2016-04-26 09:17:25.178646	f	\N
85		35	0	481	2016-05-02 12:29:02.417877	481	2016-05-02 12:30:01.416101	f	\N
86	PLAN DE LA PATRIA	0	5	1	2016-05-22 19:10:15.71217	\N	2016-05-22 19:10:15.71217	t	\N
87	1. Defender expandir y consolidar el bien más preciado que hemos reconquistado después de 200 años: la Independencia Nacional.	86	7	1	2016-05-22 19:14:15.541209	\N	2016-05-22 19:14:15.541209	t	Objetivo Historico 1
976	COMPROMISO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
139	1.2.5.2 Consolidar el control efectivo de las actividades clave de la cadena de valor de petróleo y gas.	127	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.5.2
140	1.2.6.1 Defender las políticas para la justa valorización del petróleo.	128	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.6.1
141	1.2.9.1 Impulsar mecanismos entre los países productores de gas para una justa valorización del gas y su conservación.	131	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.9.1
105	1.1.1.2 Desplegar todas las acciones políticas necesarias para garantizar los procesos electorales en un clima de estabilidad y lograr que se reconozca de manera pacífica la voluntad soberana de nuestro pueblo.	99	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.1.2
106	1.1.1.3 Convocar a todos los sectores democráticos y honestos del país a contribuir al desarrollo pacífico de los procesos electorales.	99	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.1.3
107	1.1.2.1 Fortalecer y defender a los Poderes Públicos del Estado.	100	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.2.1
93	1.2 Preservar y consolidar la soberanía sobre los recursos petroleros y demás recursos naturales estratégicos.	87	12	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.2
94	1.3 Garantizar el manejo soberano del ingreso nacional.	87	10	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.3
95	1.4 Lograr la soberanía alimentaria para garantizar el sagrado derecho a la alimentación de nuestro pueblo.	87	10	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.4
96	1.5 Desarrollar nuestras capacidades científico-tecnológicas vinculadas a las necesidades del pueblo.	87	4	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.5
108	1.1.2.2 Fortalecer la conciencia y la organización sectorial y territorial de nuestro pueblo para la defensa integral de la patria.	100	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.2.2
109	1.1.2.3 Potenciar las capacidades de los organismos de Seguridad ciudadana del Estado para garantizar la estabilidad política y la paz de la Nación.	100	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.2.3
89	3. Convertir a Venezuela en un país potencia en lo social, lo económico y lo político dentro de la Gran Potencia Naciente de América Latina y el Caribe, que garanticen la conformación de una zona de paz en Nuestra América.	86	4	1	2016-05-22 19:14:15.541209	\N	2016-05-22 19:14:15.541209	t	Objetivo Historico 3
97	1.6 Fortalecer el poder defensivo nacional para proteger la Independencia y la soberanía nacional, asegurando los recursos y riquezas de nuestro país para las futuras generaciones.	87	4	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.6
98	1.7 Adecuar el aparato económico productivo, la infraestructura y los servicios del Estado incrementando la capacidad de respuesta a las necesidades del pueblo ante posibles estados de excepción en el marco de la Defensa Integral de la Nación.	87	2	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.7
90	4. Contribuir al desarrollo de una nueva geopolítica internacional en la cual tome cuerpo el mundo multicéntrico y pluripolar que permita lograr el equilibrio del universo y garantizar la paz planetaria en el planeta.	86	4	1	2016-05-22 19:14:15.541209	\N	2016-05-22 19:14:15.541209	t	Objetivo Historico 4
91	5. Contribuir con la preservación de la vida en el planeta y la salvación de la especie humana.	86	4	1	2016-05-22 19:14:15.541209	\N	2016-05-22 19:14:15.541209	t	Objetivo Historico 5
1039	PLANES DE ACCIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1040	MESAS DE TRABAJO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1041	INVESTIGACIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
99	1.1.1 Fortalecer a través de los procesos electorales la Revolución Bolivariana, elevando la moral y la conciencia del pueblo venezolano y de los pueblos del mundo en su lucha por la emancipación.	92	3	1	2016-05-22 19:57:30.897818	\N	2016-05-22 19:57:30.897818	t	Objetivo Estrategico 1.1.1
92	1.1 Garantizar la continuidad y consolidación de la Revolución Bolivariana.	87	5	1	2016-05-22 19:23:18.709134	\N	2016-05-22 19:23:18.709134	t	Objetivo Nacional 1.1
100	1.1.2 Preparar la defensa de la voluntad del pueblo, mediante la organización popular y el ejercicio democrático de la autoridad del Estado.	92	3	1	2016-05-22 19:57:30.897818	\N	2016-05-22 19:57:30.897818	t	Objetivo Estrategico 1.1.2
101	1.1.3 Fortalecer y expandir el Poder Popular.	92	3	1	2016-05-22 19:57:30.897818	\N	2016-05-22 19:57:30.897818	t	Objetivo Estrategico 1.1.3
102	1.1.4 Preservar y recuperar los espacios de gobierno regional y local, para profundizar la restitución del poder al pueblo.	92	1	1	2016-05-22 19:57:30.897818	\N	2016-05-22 19:57:30.897818	t	Objetivo Estrategico 1.1.4
103	1.1.5 Seguir construyendo la soberanía y democratización comunicacional.	92	9	1	2016-05-22 19:57:30.897818	\N	2016-05-22 19:57:30.897818	t	Objetivo Estrategico 1.1.5
104	1.1.1.1 Consolidar la unidad de la clase trabajadora y de sus capas profesionales, de los pequeños y medianos productores del campo y la ciudad; así como de los movimientos y organizaciones sociales que acompañan a la Revolución Bolivariana.	99	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.1.1
1042	ASIGNACIONES ECONÓMICAS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1043	PERSONA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1044	REDES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1045	ASISTENCIA TÉCNICA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1046	PAGO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1047	COMITÉ	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1048	CONVENCIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1049	INSTRUCTOR	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1050	FACILITADOR	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1051	PRESENTACIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1052	SERVIDOR	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1053	ACOMPAÑAMIENTO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
124	1.2.2 Mantener y garantizar el control por parte del Estado sobre Petróleos de Venezuela S .A. (PDVSA).	93	2	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.2
126	1.2.4 Promover y estimular la investigación científica y el desarrollo tecnológico, con el propósito de asegurar las operaciones medulares de la industria petrolera.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.4
128	1.2.6 Fortalecer la coordinación de políticas petroleras en el seno de la OPEP y otros organismos internacionales, para la justa valorización de nuestros recursos naturales.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.6
977	DESEMBOLSO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
132	1.2.10 Elevar la conciencia política e ideológica del Pueblo y de los trabajadores petroleros y mineros, así como también su participación activa en la defensa de los recursos naturales estratégicos de la Nación.	93	4	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.10
133	1.2.11 Crear las condiciones para influir en la valorización de los precios de los minerales.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.11
135	1.2.2.1 Garantizar la hegemonía del Estado sobre la producción nacional de petróleo.	124	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.2.1
110	1.1.3.1 Formar a las organizaciones del Poder Popular en procesos de planificación, coordinación, control y administración de servicios que eleven el vivir bien.	101	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.3.1
111	1.1.3.2 Fortalecer el Poder Popular en el ejercicio compartido de funciones de planificación, elaboración, ejecución y seguimiento de las políticas públicas.	101	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.3.2
112	1.1.3.3 Transferir al Poder Popular, en corresponsabilidad, competencias, servicios y otras atribuciones del Poder Público nacional, regional y municipal.	101	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.3.3
113	1.1.4.1 Garantizar la planificación, elaboración, ejecución y seguimiento participativo de las políticas regionales y locales, en consonancia con los objetivos del Plan de Desarrollo Económico y Social de la Nación.	102	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.4.1
114	1.1.5.1 Garantizar el derecho del pueblo a estar informado veraz y oportunamente, así como al libre ejercicio de la información y comunicación.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.1
115	1.1.5.2 Fortalecer el uso responsable y crítico de los medios de comunicación públicos, privados y comunitarios como instrumentos de formación de valores bolivarianos.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.2
116	1.1.5.3 Consolidar la regulación y contraloría social de los medios de comunicación como herramienta para el fortalecimiento del Poder Popular.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.3
117	1.1.5.4 Promover e impulsar un sistema nacional de comunicación popular.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.4
120	1.1.5.7 Actualizar y desarrollar de forma permanente las plataformas tecnológicas de comunicación e información, garantizando el acceso a la comunicación oportuna y ética a fin de contribuir a la satisfacción de las necesidades para el vivir bien de nuestro pueblo, entre otras.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.7
118	1.1.5.5 Fomentar la investigación y formación sobre la comunicación como proceso humano y herramienta de transformación y construcción social.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.5
119	1.1.5.6 Desarrollar redes de comunicación y medios de expresión de la palabra, la imagen y las voces de nuestros pueblos, con miras al fortalecimiento de los procesos de integración y unidad latinoamericana y caribeña.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.6
123	1.2.1 Fortalecer el rol del Estado en la administración y explotación de los recursos hidrocarburíferos y mineros.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.1
121	1.1.5.8 Consolidar la adecuación tecnológica del sistema público de comunicación con el marco de la implementación de la Televisión Digital Abierta y el uso de las nuevas TIC.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.8
122	1.1.5.9 Conformar un sistema de medios que contribuya a la organización sectorial para la defensa integral de la Patria, con énfasis en la consolidación de nuevos medios y formas de producir contenidos en la frontera con relevancia de los valores patrióticos y socialistas.	103	0	1	2016-05-22 20:15:31.226228	\N	2016-05-22 20:15:31.226228	t	Objetivo General 1.1.5.9
127	1.2.5 Asegurar los medios para el control efectivo de las actividades conexas y estratégicas asociadas a la cadena industrial de explotación de los recursos hidrocarburíferos.	93	2	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.5
125	1.2.3 Mantener y garantizar el control por parte del Estado de las empresas nacionales que exploten los recursos mineros en el territorio nacional.	93	1	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.3
129	1.2.7 Impulsar y promover una iniciativa de coordinación entre los países gigantes petroleros.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.7
130	1.2.8 Asegurar los medios para el control efectivo de las actividades conexas y estratégicas asociadas a la cadena industrial de explotación de los recursos mineros.	93	0	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.8
131	1.2.9 Lograr una instancia de coordinación de políticas gasíferas para un a valorización justa y razonable del gas.	93	1	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.9
134	1.2.12 Garantizar la propiedad y uso de los recursos naturales del país, de forma soberana, para la satisfacción de las demandas internas así como su uso en función de los más altos intereses nacionales.	93	3	1	2016-05-22 20:25:08.85471	\N	2016-05-22 20:25:08.85471	t	Objetivo Estrategico 1.2.12
136	1.2.2.2 Asegurar una participación mayoritaria de PDVSA en las empresas mixtas.	124	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.2.2
138	1.2.5.1 Fortalecer las acciones emprendidas para el control efectivo de las actividades conexas estratégicas de la industria petrolera.	127	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.5.1
1054	REGISTRO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
137	1.2.3.1 Consolidar y fortalecer una empresa estatal para la explotación de los recursos mineros.	125	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.3.1
1055	FERIA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1056	CONSTRUCCIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1057	MUJER SENSIBILIZADA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1058	REUNIÓN REALIZADA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1059	SEDES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1060	CRÉDITOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1061	BOLÍVARES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
152	1.3.4 Establecer mecanismos de control sobre la comercialización de los minerales.	94	2	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.4
158	1.3.10 Mejorar y promover la eficiencia de la gestión fiscal del sector público para generar mayor transparencia, y confiabilidad sobre el impacto económico y social de la política fiscal.	94	6	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.10
159	1.3.3.1 Regularizar y controlar la producción de minerales estratégicos.	151	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.3.1
153	1.3.5 Fortalecer y profundizar acuerdos financieros con socios estratégicos.	94	3	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.5
154	1.3.6 Mantener y consolidar los convenios de cooperación, solidaridad y complementariedad con países aliados.	94	4	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.6
155	1.3.7 Fortalecer los mecanismos de cooperación en el mercado común del Sur (MERCOSUR).	94	1	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.7
156	1.3.8 Diseñar y establecer mecanismos novedosos y efectivos, orientados a promover la participación popular en la renta petrolera, tales como la inversión y el ahorro.	94	2	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.8
161	1.3.3.3 Reordenar y establecer las tasas de regalía aplicables a la liquidación de los distintos minerales.	151	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.3.3
142	1.2.10.1 Profundizar el contenido político y social de la industria petrolera y minera.	132	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.10.1
143	1.2.10.2 Impulsar la participación de los trabajadores en la planificación de las actividades de la industria petrolera y minera.	132	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.10.2
144	1.2.10.3 Consolidar y profundizar instancias de participación política del pueblo y de los trabajadores petroleros y mineros.	132	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.10.3
145	1.2.10.4 Fortalecer los planes estratégicos de contingencia en el sector de hidrocarburos, minería y gas, que incorporen la participación del Poder Popular para contrarrestar posibles sabotajes.	132	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.10.4
146	1.2.12.1 Defender la propiedad de la Nación sobre los recursos estratégicos no petroleros, así como el desarrollo sustentable y sostenible de las capacidades de aprovechamiento de los mismos, en sus procesos de transformación y agregación de valor nacional.	134	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.12.1
147	1.2.12.2 Desarrollar la prospectiva, inventario integral sobre una plataforma tecnológica nacional, así como la apropiación de técnicas para el aprovechamiento eficiente y sustentable de los recursos naturales, en función de los intereses soberanos de la Nación.	134	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.12.2
148	1.2.12.3 Garantizar la incorporación de los recursos naturales estratégicos al proceso productivo, de forma eficiente y sustentable para la satisfacción y acceso democrático de la población a los bienes y servicios para el vivir bien.	134	0	1	2016-05-22 20:37:41.576835	\N	2016-05-22 20:37:41.576835	t	Objetivo General 1.2.12.3
149	1.3.1 Mantener y fortalecer el actual régimen fiscal petrolero para garantizar el bienestar del pueblo.	94	0	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.1
150	1.3.2 Mantener y fortalecer mecanismos eficaces de captación de la renta excedentaria, por incrementos extraordinarios de los precios internacionales de los hidrocarburos.	94	0	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.2
151	1.3.3 Establecer y desarrollar un régimen fiscal minero, así como mecanismos de captación eficientes para la recaudación de la renta por la actividad minera.	94	4	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.3
157	1.3.9 Compatibilizar el sistema impositivo hacia estándares internacionales de eficiencia tributaria para alcanzar acuerdos comerciales más efectivos y eficientes con los países socios, salvaguardando la soberanía nacional.	94	1	1	2016-05-22 20:44:10.548915	\N	2016-05-22 20:44:10.548915	t	Objetivo Estrategico 1.3.9
160	1.3.3.2 Fortalecer el régimen de recaudación y fiscalización de la actividad minera.	151	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.3.2
162	1.3.3.4 Revisar y regularizar los convenios de regalía específicos para cada uno de los minerales.	151	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.3.4
163	1.3.4.1 Crear entes estatales para la comercialización de los minerales.	152	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.4.1
164	1.3.4.2 Establecer mecanismos transparentes para la valorización de los minerales.	152	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.4.2
165	1.3.5.1 Mantener y ampliar el Fondo Conjunto Chino - Venezolano, como estrategia para afianzar una nueva geopolítica, basada en la diversificación de mercados, y como mecanismo para la asignación de recursos dirigidos al desarrollo de proyectos estratégicos en materia social, de infraestructura, industria, agricultura y energía, entre otros.	153	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.5.1
166	1.3.5.2 Promover la creación de mecanismos de cooperación bilateral con socios estratégicos, mediante los cuales se reciban recursos financieros que sean cancelados a través del suministro de crudos y productos.	153	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.5.2
167	1.3.5.3 Promover la constitución de fideicomisos para el financiamiento de proyectos estratégicos.	153	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.5.3
168	1.3.6.1 Fortalecer y ampliar los Convenios de Cooperación Energética (CCE) para motorizar el establecimiento de relaciones de intercambio justas, solidarias, eficientes y sin intermediación en la lucha contra la pobreza, reduciendo las asimetrías económicas y sociales.	154	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.6.1
169	1.3.6.2 Fortalecer los acuerdos en el marco de Petrocaribe, con la finalidad de eliminar las barreras del acceso a los recursos energéticos, por la vía de un nuevo esquema de intercambio comercial favorable, equitativo y justo.	154	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.6.2
183	1.4.2 Acelerar la democratización del acceso de los campesinos y campesinas, productores y productoras, y de las distintas formas colectivas y empresas socialistas, a los recursos necesarios para la producción (tierra, agua, riego, semillas, capital), impulsando el uso racional y sostenible de los mismos.	95	7	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.2
184	1.4.3 Afianzar un conjunto de políticas públicas de apoyo a la producción, distribución, comercialización y organización del sector rural y participación del poder popular campesino en la implementación de un Plan Nacional de Producción de Alimentos que garantice la soberanía alimentaria.	95	10	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.3
185	1.4.4 Fortalecer la infraestructura, el desarrollo y funcionamiento de los grandes polos socialistas de producción primaria agropecuaria y grandes sistemas de riego, gestionados a través de empresas socialistas, privilegiando la integración de los procesos productivos a escala industrial.	95	2	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.4
186	1.4.5 Consolidar las redes de producción y distribución de productos de consumo directo y del sistema de procesamiento agroindustrial.	95	2	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.5
187	1.4.6 Crear, consolidar y apoyar centros de venta y distribución directa de productos agropecuarios y otros de consumo masivo, locales y en las grandes ciudades, garantizando su acceso a precio justo por parte de la población y una remuneración justa al trabajo campesino e incentivando el desarrollo del comercio local, nacional y de exportación.	95	7	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.6
188	1.4.7 Consolidar el aparato agroindustrial bajo control de empresas socialistas, garantizando al menos un 60% de la capacidad de almacenamiento y procesamiento en rubros básicos (cereales, oleaginosas, leguminosas, azúcar, carne y leche) y un 30% en el resto de los rubros alimenticios.	95	4	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.7
189	1.4.8 Desarrollar un sistema de apoyo e incentivos para la promoción del comercio internacional de exportación de rubros agrícolas.	95	4	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.8
190	1.4.9 Establecer mecanismos para ejercer la nueva institucionalidad revolucionaria que garantice la participación de los pequeños y medianos productores en las decisiones en materia agropecuaria, a través de los consejos campesinos y las redes de productores y productoras libres y asociados.	95	1	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.9
191	1.4.10 Promover los modelos de producción diversificados, a partir de la agricultura familiar, campesina, urbana, periurbana e indígena, recuperando, validando y divulgando modelos tradicionales y sostenibles de producción.	95	4	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.10
692	3.3.1 Fortalecer la industria militar venezolana.	527	4	1	2016-06-05 20:20:19.656821	\N	2016-06-05 20:20:19.656821	t	Objetivo Estrategico 3.3.1
192	1.4.1.1 Incrementar la superficie cultivada para vegetales de ciclo corto en al menos un 43%, pasando de 2,88 MM de hectáreas a 4,12 MM de hectáreas anuales al final del período, considerando el uso racional del recurso suelo y las tecnologías de casa de cultivo.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.1
170	1.3.6.3 Impulsar en el seno de Petrocaribe proyectos orientados a la disminución del consumo energético.	154	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.6.3
172	1.3.7.1 Incentivar a través del MERCOSUR proyectos que permitan diversificar la economía venezolana.	155	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.7.1
171	1.3.6.4 Fortalecer el ALBA como instrumento para alcanzar un desarrollo justo, solidario y sustentable ; el trato especial y diferenciado que tenga en cuenta el nivel de desarrollo de los diversos países y la dimensión de sus economías; la complementariedad económica y la cooperación entre los países participantes, y el fomento de las inversiones de capitales latinoamericanos en la propia América Latina y el Caribe.	154	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.6.4
173	1.3.8.1 Fortalecer el Fondo de Ahorro Nacional de la Clase Obrera, para generar y manejar instrumentos financieros que permitan obtener los recursos necesarios para cubrir la deuda actual que mantiene el Estado por concepto de prestaciones sociales de empleados del sector público.	156	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.8.1
174	1.3.8.2 Impulsar el Fondo de Ahorro Popular, como mecanismo de ahorro y participación en la industria petrolera.	156	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.8.2
175	1.3.9.1 Adecuar y fortalecer los mecanismos de control impositivo para mejorar la eficiencia en la recaudación de los tributos nacionales y viabilizar futuros acuerdos comerciales.	157	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.9.1
176	1.3.10.1 Desarrollar un nuevo sistema cambiario y de asignación de divisas que nos permitan alcanzar máxima transparencia, control, eficiencia y eficacia en la asignación de divisas.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.1
177	1.3.10.2 Crear el Centro Nacional de Comercio Exterior con el fin de desarrollar e instrumentar la política nacional en materia dé divisas, exportaciones e importaciones, articulando dichas políticas en función del desarrollo nacional.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.2
178	1.3.10.3 Implementar el Plan General de Divisas de la Nación que permita optimizar, jerarquizar y controlar la asignación de divisas a los distintos sectores de la economía nacional.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.3
179	1.3.10.4 Crear la Corporación Nacional de Comercio Exterior a fin de concentrar esfuerzos en potenciar nuestra capacidad para la obtención y procura nacional e internacional de bienes e insumos básicos, requeridos para la satisfacción de las necesidades de nuestra población.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.4
180	1.3.10.5 Diseñar la planificación de la inversión pública para el ejercicio del presupuesto anual, con el fin de dar consistencia a la política fiscal con los objetivos económicos y sociales de la Nación.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.5
181	1.3.10.6 Incrementar los niveles de inversión pública en sectores estratégicos como apalancamiento para el desarrollo socio productivo.	158	0	1	2016-05-22 21:03:39.291914	\N	2016-05-22 21:03:39.291914	t	Objetivo General 1.3.10.6
182	1.4.1 Eliminar definitivamente el latifundio . Realizar un proceso de organización y zonificación agroecológica en base a las capacidades de uso de la tierra y crear un sistema de catastro rural para garantizar el acceso justo y uso racional del recurso suelo.	95	7	1	2016-05-22 21:10:43.814506	\N	2016-05-22 21:10:43.814506	t	Objetivo Estrategico 1.4.1
193	1.4.1.2 Ampliar la superficie agrícola bajo riego.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.2
1062	ACTO ADMINISTRATIVO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
195	1.4.1.4 Establecer un sistema integrado de operaciones institucionales en la creación del catastro rural.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.4
196	1.4.1.5 Mejorar proceso de regulación y acceso a la tierra.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.5
197	1.4.1.6 Ordenar y reglamentar la actividad pesquera y acuícola.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.6
199	1.4.2.1 Incorporar al parque de maquinarias agrícolas, privilegiando la organización colectiva para su uso, en base al desarrollo de la industria nacional de ensamblaje y fabricación : tractores agrícolas, cosechadoras e implementos para la siembra.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.1
201	1.4.2.3 Establecer redes de transporte comunal, financiadas y administradas por el Estado, con el fin de minimizar costos al productor en el traslado de insumos y cosecha.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.3
978	MANUAL	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
202	1.4.2.4 Apoyar y promover la creación y fortalecimiento de las redes de campesinos, entre otras formas de organización para la producción agrícola, así como su formación integral permanente en los sectores productores del país.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.4
203	1.4.2.5 Diseñar y ejecutar un plan para la reactivación de maquinarias, equipos e implementos agrícolas.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.5
204	1.4.2.6 Incrementar la producción y protección nacional de las semillas de rubros estratégicos, a fin de satisfacer los requerimientos de los planes nacionales de siembra para consumo, protegiendo a la población del cultivo y consumo de productos transgénicos y otros perjudiciales a la salud.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.6
205	1.4.2.7 Incrementar la producción nacional de bioinsumos para impulsar modelos de producción sustentables.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.7
206	1.4.3.1 Aumento de la producción nacional agropecuaria (vegetal, pecuaria y acuícola-pesquera) en un 80%, para alcanzar 42 MM de tn/año.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.1
207	1.4.3.2 Desarrollar un diagnóstico de los requerimientos de alimento, de las capacidades de producción que permitan garantizar el acceso a la tierra, la tecnología soberana y los insumos adecuados.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.2
208	1.4.3.3 Impulsar una producción agrícola sin agrotóxicos, basada en la diversidad autóctona y en una relación armónica con la naturaleza.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.3
209	1.4.3.4 Incrementar la producción de cereales, en al menos un 100%, para llegar a 7 MM de tn/año ; a través del plan cerealero nacional.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.4
282	1.6.4.2 Incrementar y fortalecer el empleo de la Milicia en las funciones de apoyo al desarrollo nacional.	268	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.4.2
210	1.4.3.5 Incrementar la producción de leguminosas en 95%, para alcanzar 200 mil tn/año ; de oleaginosas en 30% para alcanzar 1,5 MM tn/año ; de cultivos tropicales en 165%, para alcanzar 17 MM tn/año ; de hortalizas en 40%, para alcanzar 2,5 MM tn/año ; de frutales en 20%, para alcanzar 4 MM tn/año ; de raíces y tubérculos en 25%, para alcanzar 2,5 MM tn/año ; a través del planes especiales de producción.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.5
211	1.4.3.6 Incrementar la producción pecuaria en al menos 40%, para alcanzar 7 MM de tn/año; a través del plan pecuario nacional.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.6
212	1.4.3.7 Elevar producción de carne de bovino en al menos 45%, para alcanzar 740 mil tn/año ; de leche en 50%, para alcanzar 4 MM de tn/año ; de huevos de consumo en 40%, para llegar a 370 mil tn/año ; de pollo en 43%, para alcanzar 1,7 MM de tn/año ; de porcinos en 75%, para alcanzar las 400 mil tn/año ; de ovinos y caprinos en 450%, para alcanzar 66 mil tn/año ; otras especies en 35%, para alcanzar 370 mil tn/año.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.7
213	1.4.3.8 Incrementar la producción de pesca y acuicultura en un 20%, para alcanzar 300 mil tn/año.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.8
214	1.4.3.9 Ampliar la frontera agrícola y consolidar el desarrollo rural en áreas con gran potencial agrícola e hídrico, mediante la transferencia tecnológica e inversión para el saneamiento de suelos con estructura de drenaje, riego, plantas de procesamiento y almacenamiento de alimentos, rehabilitación de infraestructura agrícola y social.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.9
215	1.4.3.10 Fortalecer la producción nacional en nuevos rubros, o rubros en los cuales la producción nacional es relativamente débil, para cubrir 30% de la demanda nacional en aceites y grasas, y 50% de derivados lácteos.	184	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.3.10
216	1.4.4.1 Iniciar, continuar y consolidar proyectos de Desarrollo Rural Integral, tales como : Delta del Orinoco en Islas Cocuinas, Manamito y Guara ; Píritu-Becerra ; Eje Elorza-Mantecal, entre otros.	185	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.4.1
217	1.4.4.2 Consolidar el modelo productivo socialista en proyectos, unidades de propiedad social agrícolas (UPSA), grandes y medianos sistemas de riego, empresas socialistas ganaderas y fundos zamoranos adscritos al Ministerio del Poder Popular con competencia en materia de Agricultura y Tierras.	185	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.4.2
219	1.4.5.2 Consolidar el sistema agroindustrial venezolano basado en la construcción planificada de plantas agroindustriales, y creación en su entorno de redes de producción de las materias primas requeridas y redes de distribución de los productos terminados, como estrategia principal del injerto socialista . Incluyendo entre otros : plantas procesadoras de leche, mataderos frigoríficos, almacenamiento de cereales, oleaginosas y semillas, casas de labores pesqueras.	186	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.5.2
220	1.4.6.1 Expandir las redes de distribución socialista de alimentos, tales como Mercal, Cval, Pdval, Bicentenario y programas de distribución gratuita y red de distribución de alimentos preparados, tales como las areperas y restaurantes Venezuela.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.1
221	1.4.6.2 Crear centros de acopio y redes de distribución comunal, y fortalecer los mercados comunales para garantizar la venta a precio justo de alimentos sin intermediarios.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.2
242	1.5.3 Impulsar el desarrollo y uso de equipos electrónicos y aplicaciones informáticas en tecnologías libres y estándares abiertos.	96	4	1	2016-05-22 21:46:01.715456	\N	2016-05-22 21:46:01.715456	t	Objetivo Estrategico 1.5.3
245	1.5.1.2 Crear una Red Nacional de Parques Tecnológicos para el desarrollo y aplicación de la ciencia, la tecnología y la innovación en esos espacios temáticos y en los parques industriales en general.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.2
246	1.5.1.3 Fortalecer y orientar la actividad científica, tecnológica y de innovación hacia el aprovechamiento efectivo de las potencialidades y capacidades nacionales para el desarrollo sustentable y la satisfacción de las necesidades sociales, orientando la investigación hacia áreas estratégicas definidas como prioritarias para la solución de los problemas sociales.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.3
273	1.6.1.4 Preparar al país para la Defensa Integral de la Nación, integrando los esfuerzos del Poder Público, el Pueblo y la Fuerza Armada Nacional Bolivariana.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.4
241	1.5.2 Fortalecer los espacios y programas de formación para el trabajo liberador, fomentando los valores patrióticos y el sentido crítico.	96	7	1	2016-05-22 21:46:01.715456	\N	2016-05-22 21:46:01.715456	t	Objetivo Estrategico 1.5.2
979	SEGUIMIENTO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
243	1.5.4 Establecer una política satelital del Estado venezolano para colocar la actividad al servicio del desarrollo general de la Nación.	96	2	1	2016-05-22 21:46:01.715456	\N	2016-05-22 21:46:01.715456	t	Objetivo Estrategico 1.5.4
244	1.5.1.1 Desarrollar una actividad científica, tecnológica y de innovación, transdisciplinaria asociada directamente a la estructura productiva nacional, que permita dar respuesta a problemas concretos del sector, fomentando el desarrollo de procesos de escalamiento industrial orientados al aprovechamiento de las potencialidades, con efectiva transferencia de conocimientos para la soberanía tecnológica.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.1
223	1.4.6.4 Establecer una red nacional de centros de distribución de hortalizas y frutales con sus respectivas redes de transporte.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.4
224	1.4.6.5 Fortalecer los sistemas de control de calidad asociados a los servicios de almacenaje, empaque, distribución, y expendio al mayor y detal de alimentos, que garantice las condiciones óptimas del producto.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.5
225	1.4.6.6 Fortalecer el acceso a los programas y proyectos de educación al productor y al consumidor de artículos alimenticios declarados de primera necesidad, a través de la ampliación y mejora de los mecanismos de difusión.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.6
226	1.4.6.7 Fortalecer el sistema de transporte de carga que facilite el flujo desde los centros de producción a los centros de acopio y Distribución.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.7
227	1.4.7.1 Fortalecer el componente tecnológico de las empresas agroindustriales que conforman la Corporación Venezolana de Alimentos, para optimizar la productividad en función de las capacidades actuales y las potencialidades de cada uno de sus componentes.	188	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.7.1
281	1.6.4.1 Incrementar el desarrollo de la Milicia Territorial con la finalidad de asegurar las fuerzas necesarias para la Defensa Integral de la Nación.	268	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.4.1
228	1.4.7.2 Activar formas de organización popular, partiendo de las bases campesinas e incluyendo las milicias bolivarianas, con el fin de ser incorporadas a los procesos de diseño, ejecución y seguimiento de políticas agrícolas del Gobierno Bolivariano.	188	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.7.2
229	1.4.7.3 Destinar las tierras rescatadas prioritariamente a la producción de semillas de acuerdo con sus respectivas características climáticas, considerando las técnicas tradicionales y costumbres de cultivo de la región.	188	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.7.3
230	1.4.7.4 Crear, culminar y consolidar fábricas de plantas y máquinas para el procesamiento agroindustrial (tractores, cosechadoras), centros genéticos de producción pecuaria y acuícolas, entre otros.	188	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.7.4
231	1.4.8.1 Constituir empresas mixtas de exportación con países miembros del ALBA y Mercosur y otros aliados extrarregionales.	189	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.8.1
232	1.4.8.2 Diseñar y ejecutar una política de exportaciones de productos agrícolas con valor agregado a los países del Caribe y al norte de Brasil.	189	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.8.2
233	1.4.8.3 Definir, en el marco de los acuerdos internacionales y de integración, políticas de protección comercial de la agricultura nacional.	189	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.8.3
235	1.4.9.1 Promover a través de las asambleas agrarias a nivel regional, conjuntamente con pequeñas organizaciones agroproductivas, consejos campesinos y las redes de productores y productoras libres y asociados, el desarrollo participativo en los planes producción, aprovechando así las capacidades técnicas y culturales de cada región.	190	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.9.1
236	1.4.10.1 Promover la innovación y producción de insumos tecnológicos para la pequeña agricultura, aumentando los índices de eficacia y productividad.	191	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.10.1
237	1.4.10.2 Fomentar la organización y formación del poder popular y las formas colectivas para el desarrollo de los procesos productivos a nivel local, a través de la expansión de las escuelas y cursos de formación de cuadros.	191	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.10.2
238	1.4.10.3 Impulsar el desarrollo y utilización de tecnologías de bajos insumos, reduciendo las emisiones nocivas al ambiente y promoviendo la agricultura a pequeña escala y sin agrotóxicos.	191	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.10.3
239	1.4.10.4 Otorgar el reconocimiento al conuco como fuente histórica, patrimonio de nuestra agrobiodiversidad y principal reserva de germoplasmas autóctonos vivos.	191	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.10.4
274	1.6.1.5 Incrementar la participación activa del pueblo para consolidar la unión cívico-militar.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.5
275	1.6.1.6 Fortalecer la formación del pueblo en principios y valores de Independencia, Soberanía y Patria, para su participación en la defensa integral de la Nación.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.6
757	4.1 Continuar desempeñando un papel protagónico en la construcción de la unión latinoamericana y caribeña.	90	10	1	2016-06-06 00:17:33.54993	\N	2016-06-06 00:17:33.54993	t	Objetivo Nacional 4.1
766	4.1.6 Fortalecer las alianzas estratégicas bilaterales con los países de Nuestra América, como base para impulsar los esquemas de integración y unión subregionales y regionales.	757	4	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.6
253	1.5.2.2 Propiciar el programa la Escuela en la Fábrica, o unidad productiva a efectos no sólo de mejorar los niveles de preparación para el trabajo, sino más aún la cultura del mismo, la organización en Consejos de Obreros y el Punto y Círculo como elementos sustanciales del cambio del modelo productivo.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.2
248	1.5.1.5 Garantizar el acceso oportuno y uso adecuado de las telecomunicaciones y tecnologías de información, mediante el desarrollo de la infraestructura necesaria, así como de las aplicaciones informáticas que atiendan necesidades sociales.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.5
249	1.5.1.6 Fomentar la consolidación de los espacios de participación popular en la gestión pública de las áreas temáticas y territoriales relacionadas con la ciencia, la tecnología y la innovación.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.6
250	1.5.1.7 Transformar la praxis científica a través de la interacción entre las diversas formas de conocimiento, abriendo los espacios tradicionales de producción del mismo para la generación de saberes colectivizados y nuevos cuadros científicos integrales.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.7
980	FORMULARIO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
251	1.5.1.8 Impulsar la formación para la ciencia, tecnología e innovación, a través de formas de organización y socialización del conocimiento científico para la consolidación de espacios de participación colectiva.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.8
254	1.5.2.3 Consolidar el despliegue de la infraestructura educativa del país, en los centros universitarios, técnicos, medios y ocupacionales, tanto en las unidades de producción como en los parques industriales.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.3
255	1.5.2.4 Desarrollar aplicaciones informáticas que atiendan necesidades sociales.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.4
256	1.5.2.5 Generar y difundir a través de las TIC contenidos basados en valores nacionales, multiétnicos y pluriculturales de nuestros pueblos y, con ellos, los principios inherentes al Socialismo Bolivariano.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.5
257	1.5.2.6 Garantizar la creación y apropiación del conocimiento para el desarrollo, producción y buen uso de las telecomunicaciones y tecnologías de la información.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.6
258	1.5.2.7 Ampliar la capacidad científico-técnica y humanística para garantizar la seguridad y soberanía en la producción de los insumos materiales, así como la producción teórico-metodológica y artística, necesarias para el buen vivir, mediante el incremento en un 70% el financiamiento a la investigación e innovación orientadas a proyectos que apuntalen la felicidad del pueblo.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.7
259	1.5.3.1 Garantizar el impulso de la formación y transferencia de conocimiento que permita el desarrollo de equipos electrónicos y aplicaciones informáticas en tecnologías libres y estándares abiertos.	242	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.3.1
280	1.6.3.4 Adecuar el marco jurídico necesario para desarrollar las áreas de inteligencia y contrainteligencia de nuestra Fuerza Armada Nacional Bolivariana bajo los principios de la Defensa Integral de la Nación.	267	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.3.4
260	1.5.3.2 Garantizar la democratización y apropiación del conocimiento del pueblo en materia de equipos electrónicos y aplicaciones informáticas en tecnologías libres a través de programas educativos en los centros universitarios, técnicos, medios y ocupacionales.	242	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.3.2
261	1.5.3.3 Garantizar, en las instituciones del Estado, el uso de equipos electrónicos y aplicaciones informáticas en tecnologías libres y estándares abiertos.	242	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.3.3
263	1.5.4.1 Fortalecer el uso pacífico de la tecnología espacial para garantizar al país el manejo soberano de sus telecomunicaciones y de herramientas asociadas que permitan consolidar el desarrollo nacional en áreas estratégicas como educación, salud, seguridad y alimentación.	243	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.4.1
264	1.5.4.2 Impulsar la masificación de la tecnología espacial a través de procesos de formación, e infraestructura necesaria que permitan colocarla al servicio de las necesidades del pueblo.	243	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.4.2
265	1.6.1 Incrementar la capacidad defensiva del país con la consolidación y afianzamiento de la redistribución territorial de la Fuerza Armada Nacional Bolivariana.	97	7	1	2016-05-22 22:04:38.148666	\N	2016-05-22 22:04:38.148666	t	Objetivo Estrategico 1.6.1
266	1.6.2 Consolidar la Gran Misión Soldado de la Patria Negro Primero como política integral de fortalecimiento de la Fuerza Armada Nacional Bolivariana, que asegure bienestar, seguridad social y protección a la familia militar venezolana ; el equipamiento, mantenimiento e infraestructura militar; la participación de la FANB en las tareas de desarrollo nacional ; y el desarrollo educativo de sus componentes.	97	0	1	2016-05-22 22:04:38.148666	\N	2016-05-22 22:04:38.148666	t	Objetivo Estrategico 1.6.2
267	1.6.3 Fortalecer e incrementar el sistema de Inteligencia Contrainteligencia Militar para la Defensa Integral de la Patria.	97	4	1	2016-05-22 22:04:38.148666	\N	2016-05-22 22:04:38.148666	t	Objetivo Estrategico 1.6.3
268	1.6.4 Fortalecer la Milicia Nacional Bolivariana.	97	4	1	2016-05-22 22:04:38.148666	\N	2016-05-22 22:04:38.148666	t	Objetivo Estrategico 1.6.4
269	1.6.5 Incrementar y mantener el apresto operacional de la Fuerza Armada Nacional Bolivariana para la Defensa Integral de la Nación.	97	4	1	2016-05-22 22:04:38.148666	\N	2016-05-22 22:04:38.148666	t	Objetivo Estrategico 1.6.5
270	1.6.1.1 Mantener actualizados los planes para la Defensa Territorial y Defensa Integral adaptados a las características geoestratégicas y sociopolíticas de nuestra Patria.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.1
271	1.6.1.2 Incrementar la actividad operativa cívico-militar en las fronteras para la defensa de nuestro territorio, a fin de controlar y neutralizar el crimen trasnacional, así como la acción de grupos generadores de violencia.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.2
272	1.6.1.3 Efectuar los procesos de creación, reestructuración, reequipamiento y reubicación de las unidades militares, atendiendo a las necesidades de la Defensa Integral de la Patria y su soberanía.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.3
439	2.3.2.5 Conformar bancos comunales que permitan consolidar la nueva arquitectura financiera del Poder Popular.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.5
440	2.3.2.6 Promover la conformación de los consejos de economía comunal en las comunas y los comités de economía comunal en los consejos comunales.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.6
291	1.7.1.1 Promover en los Poderes Públicos del Estado la creación y desarrollo de sus propios sistemas de contingencia.	289	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.1.1
297	2.1 Propulsar la transformación del sistema económico, en función de la transición al socialismo bolivariano, trascendiendo el modelo rentista petrolero capitalista hacia el modelo económico productivo socialista, basado en el desarrollo de las fuerzas productivas.	88	5	1	2016-05-22 22:27:40.412975	\N	2016-05-22 22:27:40.412975	t	Objetivo Nacional 2.1
298	2.2 Construir una sociedad igualitaria y justa.	88	13	1	2016-05-22 22:27:40.412975	\N	2016-05-22 22:27:40.412975	t	Objetivo Nacional 2.2
304	2.1.3 Expandir e integrar las cadenas productivas, generando la mayor cantidad de valor agregado y orientándolas hacia la satisfacción de las necesidades sociales para la construcción del socialismo, promoviendo la diversificación del aparato productivo.	297	7	1	2016-05-23 00:55:33.624623	\N	2016-05-23 00:55:33.624623	t	Objetivo Estrategico 2.1.3
305	2.1.4 Desarrollar modelos incluyentes de gestión de las unidades productivas, participativos con los trabajadores y trabajadoras, alineados con las políticas nacionales, así como con una cultura del trabajo que se contraponga al rentismo petrolero, desmontando la estructura oligopólica y monopólica existente.	297	9	1	2016-05-23 00:55:33.624623	\N	2016-05-23 00:55:33.624623	t	Objetivo Estrategico 2.1.4
400	2.2.11.1 Fomentar políticas para incrementar la Lactancia Materna Exclusiva (LME) para cubrir al menos el 70% de la población lactante.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.1
333	2.2.1 Superar las formas de explotación capitalistas presentes en el proceso social del trabajo, a través del despliegue de relaciones socialistas entre trabajadores y trabajadoras con este proceso, como espacio fundamental para el desarrollo integral de la población.	298	6	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.1
299	2.3 Consolidar y expandir el poder popular y la democracia socialista.	88	5	1	2016-05-22 22:27:40.412975	\N	2016-05-22 22:27:40.412975	t	Objetivo Nacional 2.3
300	2.4 Convocar y promover una nueva orientación ética, moral y espiritual de la sociedad, basada en los valores liberadores del socialismo.	88	2	1	2016-05-22 22:27:40.412975	\N	2016-05-22 22:27:40.412975	t	Objetivo Nacional 2.4
301	2.5 Lograr la irrupción definitiva del Nuevo Estado Democrático y Social, de Derecho y de Justicia.	88	8	1	2016-05-22 22:27:40.412975	\N	2016-05-22 22:27:40.412975	t	Objetivo Nacional 2.5
302	2.1.1 Impulsar nuevas formas de organización que pongan al servicio de la sociedad los medios de producción, y estimulen la generación de un tejido productivo sustentable enmarcado en el nuevo metabolismo para la transición al socialismo.	297	4	1	2016-05-23 00:55:33.624623	\N	2016-05-23 00:55:33.624623	t	Objetivo Estrategico 2.1.1
276	1.6.1.7 Diseñar planes estratégicos de cooperación entre las instituciones del gobierno, la Fuerza Armada Nacional Bolivariana y el Poder Popular, a fin de garantizar el desarrollo y la defensa integral de la Nación.	265	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.1.7
277	1.6.3.1 Consolidar el Sistema Territorial de Inteligencia Contrainteligencia Militar.	267	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.3.1
278	1.6.3.2 Masificar de manera ordenada la búsqueda de información útil para la seguridad ciudadana y defensa de la Patria.	267	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.3.2
279	1.6.3.3 Actualizar y adaptar los planes de estudio en el área de inteligencia y contrainteligencia de acuerdo al Pensamiento Militar Bolivariano.	267	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.3.3
758	4.2 Afianzar la identidad nacional y nuestroamericana.	90	2	1	2016-06-06 00:17:33.54993	\N	2016-06-06 00:17:33.54993	t	Objetivo Nacional 4.2
283	1.6.4.3 Fomentar e incrementar la creación de los Cuerpos Combatientes en todas las estructuras del Estado.	268	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.4.3
284	1.6.4.4 Diseñar estrategias para garantizar la participación del pueblo en la Defensa Integral de la Nación, tales como planes de adiestramiento a ciudadanas y ciudadanos en la corresponsabilidad de Defensa Integral de la Nación.	268	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.4.4
285	1.6.5.1 Modernizar, conservar, almacenar y mantener el equipamiento y los sistemas de armas de la Fuerza Armada Nacional Bolivariana.	269	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.5.1
286	1.6.5.2 Fortalecer el sistema de apoyo logístico y de sanidad militar de nuestra Fuerza Armada Nacional Bolivariana.	269	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.5.2
287	1.6.5.3 Incrementar las reservas de materiales, sistemas y equipos para el sostenimiento de la Defensa Integral de la Nación.	269	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.5.3
288	1.6.5.4 Incrementar la adquisición de sistemas de armas materiales para la dotación de unidades militares.	269	0	1	2016-05-22 22:17:01.343401	\N	2016-05-22 22:17:01.343401	t	Objetivo General 1.6.5.4
289	1.7.1 Crear el Sistema Integral de Gestión de los estados de excepción.	98	4	1	2016-05-22 22:19:20.173135	\N	2016-05-22 22:19:20.173135	t	Objetivo Estrategico 1.7.1
292	1.7.1.2 Realizar el inventario del potencial nacional disponible para el apoyo integral en situaciones de estado de excepción.	289	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.1.2
293	1.7.1.3 Reglamentar y difundir los parámetros que regirán los procesos de movilización y requisición.	289	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.1.3
295	1.7.2.1 Integrar el Sistema de Apoyo Logístico Territorial (S .A.L .T .E.) al proceso de articulación de la estructura del aparato productivo e infraestructura de servicios del Estado, según la conformación geográfica de las Regiones Estratégicas de Defensa Integral.	290	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.2.1
296	1.7.2.2 Crear la Escuela Popular Itinerante para la educación del pueblo en materia de Defensa Integral.	290	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.2.2 
290	1.7.2 Crear el Sistema Logístico Nacional, integrando el Sistema Logístico de la Fuerza Armada Nacional Bolivariana.	98	2	1	2016-05-22 22:19:20.173135	\N	2016-05-22 22:19:20.173135	t	Objetivo Estrategico 1.7.2
307	2.1.6 Conformar la institucionalidad del modelo de gestión socialista.	297	2	1	2016-05-23 01:10:18.012421	\N	2016-05-23 01:10:18.012421	t	Objetivo Estrategico 2.1.6
308	2.1.1.1 Diseñar estrategias que permitan garantizar la participación del pueblo, aumentando su nivel de conciencia para afrontar cualquier escenario que se origine como consecuencia de la guerra económica.	302	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.1.1
306	2.1.5 Fortalecer el sistema de distribución directa de los insumos y productos, atacando la especulación propia del capitalismo, para garantizar la satisfacción de las necesidades del pueblo.	297	3	1	2016-05-23 00:55:33.624623	\N	2016-05-23 00:55:33.624623	t	Objetivo Estrategico 2.1.5
310	2.1.1.3 Democratizar los medios de producción, impulsando nuevas formas de propiedad, colocándolas al servicio de la sociedad.	302	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.1.3
311	2.1.1.4 Fortalecer la planificación centralizada y el sistema presupuestario para el desarrollo y direccionamiento de las cadenas estratégicas de la nación.	302	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.1.4
312	2.1.3.1 Generar un sistema de integración de las redes productivas, que permita articular la cadena de valor para la satisfacción de las necesidades sociales de la población.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.1
313	2.1.3.2 Potenciar el aparato productivo nacional, actualizándolo tecnológicamente y articulándolo al nuevo modelo, para proveer la base material de la construcción del socialismo.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.2
314	2.1.3.3 Generar un nuevo esquema de incentivos que permita la optimización en la asignación de recursos e incrementar la producción y el valor agregado nacional.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.3
315	2.1.3.4 Fortalecer sectores productivos donde el país presente ventajas comparativas, orientando los excedentes como base económica alternativa al modelo monoexportador.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.4
316	2.1.3.5 Conformar un sistema de parques industriales para el fortalecimiento de cadenas productivas, tejido industrial, facilidades logísticas, formación, tecnología y sistema de distribución de insumos y productos con precios justos . Estos nodos tendrán unidades de gestión integral para concentrar servicios y potenciar nuevas formas de organización de la producción.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.5
317	2.1.3.6 Desarrollar bancos de insumos dentro del sistema industrial para garantizar la cantidad y el tiempo del acceso a las materias primas e insumos industriales con precios justos, para una estructura sana del sistema económico industrial.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.6
318	2.1.3.7 Generar espacios de complementación productiva comercial con países aliados y estratégicos.	304	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.3.7
319	2.1.4.1 Construir una cultura del trabajo que se contraponga al rentismo mediante el impulso de la formación desde la praxis del trabajo, conciencia del trabajador y trabajadora, como sujetos activos del proceso de transformación y participación democrática del trabajo, orientada a los más altos intereses nacionales.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.1
320	2.1.4.2 Propiciar un nuevo modelo de gestión en las unidades productivas, de propiedad social directa e indirecta, que sea eficiente, sustentable y que genere retornabilidad social y/o económica del proceso productivo.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.2
321	2.1.4.3 Impulsar la conformación de Consejos de Trabajadores y Trabajadoras en las unidades productivas, en el marco de la consolidación y fortalecimiento de la democracia participativa y protagónica.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.3
322	2.1.4.4 Promover el desarrollo de instancias de coordinación entre los Consejos Comunales y Consejos de Trabajadores y Trabajadoras.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.4
323	2.1.4.5 Desarrollar un sistema de estímulos para el fomento de las pequeñas y medianas industrias privadas y empresas conjuntas, en un marco de máxima corresponsabilidad social del aparato productivo, reconociendo el trabajo de mujeres y hombres emprendedores.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.5
325	2.1.4.7 Impulsar nuevas formas de organización de la producción a través de los conglomerados productivos que permita la vinculación de la industria nacional de una misma cadena productiva, generando economía de escala, así como el desarrollo de los principios de solidaridad y complementariedad económica productiva.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.7
326	2.1.4.8 Fomentar la educación del consumidor en el desarrollo de su rol protagónico en la planificación, ejecución y fiscalización de políticas, en el modelo económico productivo socialista.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.8
327	2.1.4.9 Impulsar el plan nacional de pleno abastecimiento garantizando a la población venezolana el acceso a los alimentos y bienes esenciales.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.9
328	2.1.5.1 Generar y fortalecer las cadenas de distribución, estatales, comunales y mixtas que representen alternativas en la distribución y ahorro directo a la población de los productos intermedios y de consumo final.	306	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.5.1
329	2.1.5.2 Propiciar sistemas de transporte y distribución que tiendan al flujo de mercancías directo desde las unidades de producción al consumidor, centros de acopio o unidades de producción intermedias.	306	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.5.2
330	2.1.5.3 Ampliar y adecuar la red de almacenes (tanto en frío como en seco) a nivel local, para el fortalecimiento de las unidadesproductivas socialistas.	306	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.5.3
331	2.1.6.1 Configurar una arquitectura institucional que organice los sectores productivos de propiedad social directa o indirecta a través de Corporaciones para la Planificación Centralizada.	307	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.6.1
332	2.1.6.2 Implantar el Modelo de Gestión socialista en las unidades productivas.	307	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.6.2
466	2.4.2.3 Desarrollar jornadas y procedimientos de interpelación popular sobre la gestión de los servidores públicos.	459	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.2.3
342	2.2.10 Asegurar la salud de la población desde la perspectiva de prevención y promoción de la calidad de vida, teniendo en cuenta los grupos sociales vulnerables, etarios, etnias, género, estratos y territorios sociales.	298	11	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.10
343	2.2.11 Asegurar una alimentación saludable, una nutrición adecuada a lo largo del ciclo de vida y la lactancia materna, en concordancia con los mandatos constitucionales sobre salud, soberanía y seguridad alimentaria, profundizando y ampliando las condiciones que las garanticen.	298	7	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.11
344	2.2.12 Continuar garantizando el derecho a la educación con calidad y pertinencia, a través del mejoramiento de las condiciones de ingreso, prosecución y egreso del sistema educativo.	298	12	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.12
345	2.2.13 Consolidar las Misiones, Grandes Misiones Socialistas como instrumento revolucionario para nuevo Estado democrático, social de derecho y de justicia.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.13
346	2.2.1.1 Universalizar la seguridad social para todos y todas.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.1
347	2.2.1.2 Asegurar la garantía de prestaciones básicas universales relativas a las contingencias de vejez, sobrevivencia, personas con discapacidad, cesantía y desempleo, derivadas de la vinculación con el mercado de trabajo.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.2
348	2.2.1.3 Garantizar la formación colectiva en los centros de trabajo, favoreciendo la incorporación al trabajo productivo, solidario y liberador.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.3
349	2.2.1.4 Afianzar valores que resguarden la identidad, construyan soberanía y defensa de la Patria, a partir del disfrute físico, espiritual e intelectual, y el reconocimiento de nuestro patrimonio cultural y natural.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.4
350	2.2.1.5 Promover la armonización de la vida familiar y laboral.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.5
351	2.2.1.6 Asegurar el desarrollo físico, cognitivo, moral y un ambiente seguro y saludable de trabajo, en condiciones laborales y de seguridad social gratificantes.	333	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.1.6
801	4.3.1 Conformar una red de relaciones políticas con los polos de poder emergentes.	759	8	1	2016-06-06 00:46:41.563884	\N	2016-06-06 00:46:41.563884	t	Objetivo Estrategico 4.3.1
803	4.3.3 Impulsar la diplomacia de los pueblos y la participación protagónica de los movimientos populares organizados en la construcción de un mundo multipolar y en equilibrio.	759	2	1	2016-06-06 00:46:41.563884	\N	2016-06-06 00:46:41.563884	t	Objetivo Estrategico 4.3.3
334	2.2.2 Consolidar el Sistema Nacional de Misiones y Grandes Misiones Socialistas Hugo Chávez, como conjunto integrado de políticas y programas que materializan los derechos y garantías del Estado Social de Derecho y de Justicia y sirve de plataforma de organización, articulación y gestión de la política social en los distintos niveles territoriales del país, para dar mayor eficiencia y eficacia a las políticas sociales de la Revolución.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.2
335	2.2.3 Potenciar las expresiones culturales liberadoras del pueblo.	298	7	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.3
336	2.2.4 Consolidar la equidad de género con valores socialistas, garantizando y respetando los derechos de todos y todas, y la diversidad social.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.4
337	2.2.5 Fomentar la inclusión y el vivir bien de los pueblos indígenas.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.5
338	2.2.6 Propiciar las condiciones para el desarrollo de una cultura de recreación y práctica deportiva liberadora, ambientalista e integradora en torno a los valores de la Patria, como vía para la liberación de la conciencia, la paz y la convivencia armónica.	298	5	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.6
339	2.2.7 Fortalecer el protagonismo de la juventud en el desarrollo consolidación de la Revolución Bolivariana.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.7
340	2.2.8 Seguir avanzando en la transformación del sistema penitenciario para la prestación de un servicio que garantice los derechos humanos de las personas privadas de libertad y favorezca su inserción productiva en la sociedad.	298	5	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.8
341	2.2.9 Continuar combatiendo la desigualdad a través de la erradicación de la pobreza extrema y disminución de la pobreza general, hacia su total eliminación.	298	4	1	2016-05-23 01:19:09.141844	\N	2016-05-23 01:19:09.141844	t	Objetivo Estrategico 2.2.9
352	2.2.2.1 Unificar el nivel de dirección nacional, regional, estadal, municipal y comunal de las Misiones y Grandes Misiones socialistas.	334	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.2.1
831	4.4.3.2 Efectuar la porción mayoritaria del intercambio económico y comercial con polos emergentes del mundo nuevo.	820	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.3.2
969	ANTEPROYECTO Y PROYECTO DE PRESUPUESTO PRESENTACIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
970	FICHA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
354	2.2.2.3 Fortalecer el tejido social de las misiones, para garantizar la participación del Poder Popular en todas las etapas de planificación, ejecución, seguimiento y control, así como la generación de saldos organizativos de la población beneficiaria.	334	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.2.3
355	2.2.2.4 Coordinar de manera centralizada, el plan de formación, financiamiento y producción de toda la política social, mediante la integración de la infraestructura social, del personal y de los recursos operativos.	334	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.2.4
356	2.2.3.1 Incrementar sostenidamente la producción y distribución de bienes culturales a nivel nacional.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.1
357	2.2.3.2 Fortalecer las editoriales que incluyan espacios de participación del poder popular en la política editorial mediante la generación de imprentas regionales.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.2
358	2.2.3.3 Aumentar los espacios y la infraestructura cultural a disposición del pueblo, que permitan el desarrollo local de las artes.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.3
359	2.2.3.4 Impulsar y ampliar la red de intelectuales, artistas, cultores y cultoras, y la organización de redes comunitarias culturales.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.4
360	2.2.3.5 Desarrollar investigaciones sobre las tradiciones culturales que impulsen el conocimiento y práctica cultural.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.5
361	2.2.3.6 Visibilizar la identidad histórico-comunitaria en conexión con la Misión Cultura Corazón Adentro.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.6
362	2.2.3.7 Consolidar el protagonismo popular en las manifestaciones culturales y deportivas, centrado en la creación de una conciencia generadora de transformaciones para la construcción del socialismo.	335	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.3.7
363	2.2.4.1 Profundizar la participación política y protagónica de las mujeres.	336	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.4.1
364	2.2.4.2 Incorporar la perspectiva de la igualdad de género en las políticas públicas promoviendo la no discriminación y la protección de los grupos socialmente vulnerables.	336	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.4.2
365	2.2.4.3 Generar políticas formativas sobre la perspectiva de igualdad de género y de diversidad sexual.	336	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.4.3
366	2.2.4.4 Promover el debate y reflexión de los derechos de la comunidad sexo-diversa.	336	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.4.4
367	2.2.5.1 Acelerar la demarcación de los territorios indígenas, a través de la entrega de títulos de propiedad de tierras a sus comunidades.	337	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.5.1
981	MUJER ATENDIDA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
982	SOLICITUD RECIBIDA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
953	3.11 Fortalecer la participación de las mujeres en las acciones emprendidas en materia de seguridad y soberanía alimentaria.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.11
952	3.10 Concienciar a la población de mujeres sobre una alimentación saludable, sana y balanceada en sus distintas fases del ciclo de vida.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.10
369	2.2.5.3 Impulsar la formación, capacitación y financiamiento para unidades socio-productivas en las comunidades indígenas, respetando sus prácticas y formas de organización tradicionales.	337	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.5.3
370	2.2.5.4 Ampliar la presencia de las Misiones y Grandes Misiones Socialistas en las comunidades indígenas, con absoluto respeto a sus costumbres, usos, cultura, formas de organización y ejercicio de la autoridad ancestral.	337	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.5.4
371	2.2.6.1 Profundizar la masificación deportiva.	338	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.6.1
372	2.2.6.2 Consolidar el Fondo Nacional del Deporte, Actividad Física y Educación Física para impulsar la masificación del deporte.	338	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.6.2
373	2.2.6.3 Ampliar la infraestructura de la Misión Barrio Adentro Deportivo y de todos los espacios deportivos a nivel parroquial.	338	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.6.3
374	2.2.6.4 Contribuir a la práctica sistemática, masiva y diversificada de la actividad física en las comunidades y espacios públicos.	338	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.6.4
376	2.2.7.1 Promover la ética socialista en los espacios de formación, recreación y ocio libre de los jóvenes, orientando ésta hacia la paz, la solidaridad, una vida sana y la convivencia comunal.	339	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.7.1
377	2.2.7.2 Desarrollar espacios institucionales de formación y atención integral para jóvenes en situación de vulnerabilidad.	339	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.7.2
378	2.2.7.3 Fortalecer la organización y participación protagónica de los jóvenes a través de la conformación de Consejos del Poder Popular Juvenil, entre otras iniciativas.	339	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.7.3
379	2.2.7.4 Promover una política de inclusión de los jóvenes al sistema productivo nacional, con especial énfasis en los jóvenes de sectores de menores ingresos, incentivando una cultura económica productiva socialista.	339	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.7.4
380	2.2.8.1 Avanzar en la transformación del sistema penitenciario, a través de la incorporación de familiares de las personas privadas de libertad, consejos comunales, organizaciones sociales y cualquier otra forma de organización, a labores pertinentes a la materia penitenciaria.	340	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.8.1
381	2.2.8.2 Combatir la impunidad, el retardo procesal penal, en coordinación con los poderes públicos involucrados.	340	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.8.2
382	2.2.8.3 Mejorar y construir infraestructuras para las Comunidades Penitenciarias, incorporando espacios para el trabajo productivo.	340	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.8.3
383	2.2.8.4 Transformar el sistema de justicia penal generando alternativas para el cumplimiento de la pena así como otros beneficios procesales que coadyuve a la conformación de un nuevo orden de administración de justicia.	340	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.8.4
384	2.2.8.5 Crear un sistema integral de apoyo post penitenciario, con énfasis en programas socio educativos y laborales, garantizando la privacidad de los antecedentes penales.	340	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.8.5
385	2.2.9.1. Erradicar la pobreza extrema.	341	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.9.1
388	2.2.9.4 Impulsar la corresponsabilidad del Poder Popular en la lucha por la erradicación de la pobreza en todas sus manifestaciones.	341	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.9.4
389	2.2.10.1 Asegurar la salud de la población, a través del fortalecimiento continuo y la consolidación de todos los niveles de atención y servicios del Sistema Público Nacional de Salud, priorizando el nivel de atención primaria para la promoción de estilos y condiciones de vida saludables en toda la población.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.1
390	2.2.10.2 Fomentar la creación de centros y servicios especializados en el Sistema Público Nacional de Salud.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.2
391	2.2.10.3 Articular bajo la rectoría única del Sistema Público Nacional de Salud a todos los órganos y entes prestadores de servicios de salud públicos y privados.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.3
392	2.2.10.4 Disminuir el sobrepeso y el sedentarismo como factores de riesgos de enfermedades prevenibles, a través de mecanismos que fomenten la actividad física, mejoren los hábitos alimenticios y patrones de consumo . Promover la disminución a un 12% del porcentaje de la población de 7-14 años con sobrepeso (peso-talla).	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.4
393	2.2.10.5 Impulsar la participación protagónica del Poder Popular en los espacios de articulación intersectorial e institucionales para la promoción de la calidad de vida y la salud, a través del : a) el incremento de los egresados de las distintas profesiones que se encuentran integradas al Sistema Público Nacional de Salud, alcanzando los 80 .000 profesionales de la salud para 2019 ; b) la participación de los órganos del Poder Popular en la planificación, ejecución, monitoreo y evaluación de las acciones de salud en las Áreas de Salud Integral Comunitaria ; y c) la constitución de organizaciones populares en salud, tales como los comités de salud.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.5
394	2.2.10.6 Aumentar al 15% la producción nacional de medicamentos esenciales requeridos por el Sistema Publico Nacional de Salud.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.6
395	2.2.10.7 Aumentar al 10% la producción nacional de material médico quirúrgico requerido por el Sistema Público Nacional de Salud.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.7
398	2.2.10.10 Reducir cargas de enfermedad, mortalidad prematura y mortalidad evitable con énfasis en mortalidad materna, mortalidad en menores de 5 años.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.10
397	2.2.10.9 Fortalecer la atención de la salud sexual y reproductiva de la población venezolana con énfasis en los sectores de mayor vulnerabilidad y exclusión.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.9
396	2.2.10.8 Consolidar y expandir la Red de Farmacias Populares en todo el territorio nacional.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.8
399	2.2.10.11 Articular todos los niveles de protección, promoción, prevención, atención integral y rehabilitación a la salud individual y colectiva en el marco de Áreas de Salud Integral Comunitarias.	342	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.10.11 
401	2.2.11.2 Desarrollar planes de apoyo, protección y promoción de la lactancia materna, así como la creación de redes de lactarios de leche materna.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.2
402	2.2.11.3 Asegurar la alimentación saludable de la población, con especial atención en la primera infancia (prenatal - 8 años).	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.3
403	2.2.11.4 Consolidar las casas de alimentación, para adecuarlas y ampliarlas como centros de formación y atención nutricional.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.4
404	2.2.11.5 Fortalecer los programas de asistencia alimentaria en el sistema educativo.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.5
405	2.2.11.6 Promover hábitos alimentarios saludables y patrones de consumo adaptados a las potencialidades productivas del país.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.6
406	2.2.11.7 Prevenir y controlar las carencias de micronutrientes y promoción de la seguridad alimentaria en los hogares.	343	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.11.7
407	2.2.12.1 Desarrollar en el Currículo Nacional Bolivariano los contenidos de la educación integral y liberadora con fundamento en los valores y principios de la Patria.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.1
409	2.2.12.3 Profundizar la territorialización y pertinencia de la educación universitaria, a través del aumento de la matrícula municipalizada en un 60%, con iniciativas como las misiones Sucre y Alma Mater, así como los programas nacionales de formación avanzada.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.3
410	2.2.12.4 Ampliar la infraestructura y la dotación escolar y deportiva, garantizando la ejecución de un plan de construcción, ampliación, reparación y mantenimiento permanente.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.4
411	2.2.12.5 Continuar incorporando tecnologías de la información y de la comunicación al proceso educativo.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.5
412	2.2.12.6 Profundizar la acción educativa, comunicacional y de protección del ambiente.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.6
413	2.2.12.7 Desarrollar la educación intercultural bilingüe, promoviendo el rescate y la preservación de las lenguas indígenas.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.7
424	2.3.2 Impulsar la transformación del modelo económico rentístico hacia el nuevo modelo productivo diversificado y socialista, con participación protagónica de las instancias del Poder Popular.	299	7	1	2016-05-23 02:04:12.076096	\N	2016-05-23 02:04:12.076096	t	Objetivo Estrategico 2.3.2
426	2.3.4 Impulsar la corresponsabilidad del Poder Popular en la lucha por la inclusión social y erradicación de la pobreza.	299	6	1	2016-05-23 02:04:12.076096	\N	2016-05-23 02:04:12.076096	t	Objetivo Estrategico 2.3.4
427	2.3.5 Consolidar la formación integral socialista, permanente y continua, en los diferentes procesos de socialización e intercambio de saberes del Poder Popular, fortaleciendo habilidades y estrategias para el ejercicio de lo público y el desarrollo socio-cultural y productivo de las comunidades.	299	5	1	2016-05-23 02:04:12.076096	\N	2016-05-23 02:04:12.076096	t	Objetivo Estrategico 2.3.5
428	2.3.1.1 Promover, consolidar y expandir la organización del poder popular en el ámbito territorial y sectorial, en la figura de las distintas instancias de participación.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.1
444	2.3.3.3 Impulsar la creación de Unidades de acompañamiento técnico integral estadales, dotando al Poder Popular organizado de herramientas técnicas útiles para una gestión comunal eficiente, eficaz, efectiva y de calidad.	425	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.3.3
429	2.3.1.2 Promover la organización del poder popular en el sistema de agregación comunal para la construcción del Estado Social de Derecho y de Justicia a través de instancias como consejos comunales, salas de batalla social, comunas socialistas, ciudades comunales, federaciones y confederaciones comunales, entre otros.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.2
414	2.2.12.8 Desarrollar programas y proyectos de formación-investigación que den respuesta a las necesidades y potencialidades productivas para el proyecto nacional.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.8
415	2.2.12.9 Desarrollar programas en educación en los que se incorporen contenidos enfocados en los conocimientos ancestrales y populares.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.9
416	2.2.12.10 Impulsar la transformación universitaria y la formación técnico-profesional, para su vinculación con los objetivos del proyecto nacional.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.10
417	2.2.12.11 Consolidar la democratización del acceso a la educación técnica y universitaria.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.11
418	2.2.12.12 Consolidar el derecho constitucional a la educación universitaria para todas y todos, fortaleciendo el ingreso, prosecución y egreso, incrementando al 100% la inclusión de jóvenes bachilleres al sistema de educación universitaria.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.12
419	2.2.13.1 Fortalecer y ampliar el Sistema de Misiones y Grandes Misiones Socialistas para garantizar la cobertura, calidad, corresponsabilidad y eficiencia en la satisfacción de las necesidades de la población.	345	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.13.1
420	2.2.13.2 Desarrollar, desde las grandes misiones, los sistemas de acompañamiento territorial, para transformar la vida de familias y comunidades en situación de pobreza y de riesgo.	345	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.13.2
421	2.2.13.3 Generar saldos organizativos del Poder Popular en las Misiones y Grandes Misiones.	345	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.13.3
422	2.2.13.4 Garantizar sistemas de financiamiento especial para la sostenibilidad de las misiones y Grandes Misiones Socialistas.	345	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.13.4
423	2.3.1 Promover la construcción del Estado Social de Derecho y de Justicia a través de la consolidación y expansión del poder popular organizado.	299	7	1	2016-05-23 02:04:12.076096	\N	2016-05-23 02:04:12.076096	t	Objetivo Estrategico 2.3.1
425	2.3.3 Garantizar la transferencia de competencias en torno a la gestión y administración de lo público desde las distintas instancias del Estado hacia las comunidades organizadas.	299	5	1	2016-05-23 02:04:12.076096	\N	2016-05-23 02:04:12.076096	t	Objetivo Estrategico 2.3.3
430	2.3.1.3 Acelerar la conformación los Consejos Comunales a nivel nacional, garantizando la cobertura del 70% de la población total venezolana organizada en Consejos Comunales para el año 2019.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.3
431	2.3.1.4 Promover la conformación de las Salas de Batalla Social, como herramienta de articulación entre el pueblo organizado y el Estado.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.4
983	JORNADA REALIZADA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
432	2.3.1.5 Afianzar la conformación de las Comunas Socialistas, para la consolidación del Poder Popular, de acuerdo a las características demográficas de los ejes de desarrollo territorial, para alcanzar 3.000 Comunas el año 2019.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.5
433	2.3.1.6 Conformar las Federaciones y Confederaciones Comunales para el fortalecimiento de las capacidades creadoras del Poder Popular, en los ámbitos territoriales, socioproductivos, políticos, económicos, sociales, culturales, ecológicos y de seguridad y defensa de la soberanía nacional.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.6
434	2.3.1.7 Impulsar la organización comunal de los Pueblos Indígenas, garantizando la constitución de 40 Comunas Indígenas Socialistas para el año 2019.	423	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.1.7
435	2.3.2.1 Desarrollar el Sistema Económico Comunal con las distintas formas de organización socioproductiva : empresas de propiedad social directa, unidades familiares, grupos de intercambio solidario y demás formas asociativas para el trabajo.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.1
436	2.3.2.2 Promover la creación y fortalecimiento de empresas de propiedad social directa, para contribuir a la generación de un nuevo tejido productivo diversificado y sustentable para la construcción del socialismo bolivariano.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.2
437	2.3.2.3 Desarrollar una nueva arquitectura financiera, configurando redes de organizaciones económico-financieras, que gestionen los recursos financieros y no financieros, retornables y no retornables, administradas por las comunidades y diferentes organizaciones del Poder Popular.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.3
438	2.3.2.4 Fortalecer el Sistema Económico Comunal, mediante procesos de transferencia de empresas de propiedad social indirecta a instancias del Poder Popular, así como el fortalecimiento de las instancias de financiamiento y la integración de cadenas productivas y de valor.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.4
459	2.4.2 Fortalecer la contraloría social, para mejorar el desempeño de la gestión pública, de las instancias del Poder Popular y las actividades privadas que afecten el interés colectivo.	300	3	1	2016-05-23 02:23:25.145124	\N	2016-05-23 02:23:25.145124	t	Objetivo Estrategico 2.4.2
463	2.4.1.4 Adecuar los planes de estudio en todos los niveles para la inclusión de estrategias de formación de valores socialistas y patrióticos.	458	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.1.4
441	2.3.2.7 Registro y conformación de todas las Empresas de Propiedad Social Directa Comunal, Empresas de Propiedad Social Indirecta Comunal, Unidades Productivas Familiares y Grupos de Intercambio Solidarios existentes en el país.	424	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.2.7
442	2.3.3.1 Lograr la consolidación de un sistema de articulación entre las diferentes instancias del poder popular, con el fin de trascender de la acción local al ámbito de lo regional y nacional, rumbo a la construcción de un subsistema de Comunas, Distritos Motores de Desarrollo y Ejes de Desarrollo Territorial.	425	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.3.1
443	2.3.3.2 Instaurar la noción de corresponsabilidad en torno al proceso de planificación comunal, regional y territorial para impulsar la participación corresponsable de la organización popular en el estudio y establecimiento de los lineamientos y acciones estratégicas para el desarrollo de planes, obras y servicios en las comunidades y regiones.	425	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.3.2
525	3.1 Consolidar el papel de Venezuela como Potencia Energética Mundial.	89	16	1	2016-06-05 17:02:19.913905	\N	2016-06-05 17:02:19.913905	t	Objetivo Nacional 3.1
445	2.3.3.4 Promover la organización de las unidades de contraloría social de los consejos comunales, para garantizar la máxima eficiencia de las políticas públicas.	425	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.3.4
446	2.3.3.5 Desarrollar lineamientos y acciones estratégicas para la transferencia de competencias en la gestión de planes, obras y servicios en las comunidades y regiones.	425	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.3.5
447	2.3.4.1 Promover instancias organizativas del Poder Popular, tales como los comités de prevención, protección social, deporte y recreación de los consejos comunales, para atender a la población en situación de vulnerabilidad.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.1
448	2.3.4.2 Desarrollar planes integrales comunitarios y políticas orientadas a incluir a las personas en situación de vulnerabilidad.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.2
449	2.3.4.3 Fomentar el ejercicio de la contraloría social en el ámbito comunitario como garantía del cumplimiento de políticas de inclusión social.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.3
450	2.3.4.5 Aplicar programas de formación y debate permanente en materia de prevención social con la participación de los voceros y voceras del Poder Popular.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.5
452	2.3.4.7 Impulsar la creación y desarrollo de las Mesas Comunales del Sistema Nacional de Misiones y Grandes Misiones Socialistas, garantizando la participación de organizaciones del Poder Popular en la gestión de los programas sociales.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.7
453	2.3.5.1 Desarrollar programas de formación y socialización que fortalezcan la capacidad de gestión del Poder Popular en competencias que le sean transferidas en los ámbitos político, económico, social, jurídico y en áreas estratégicas para el desarrollo nacional.	427	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.5.1
454	2.3.5.2 Desarrollar programas permanentes de formación socio-política y técnico-productiva, a través de la Escuela para el Fortalecimiento del Poder Popular, entre otros espacios.	427	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.5.2
455	2.3.5.3 Incorporar facilitadores provenientes de las diferentes organizaciones del Poder Popular como sujetos principales en los procesos de formación.	427	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.5.3
456	2.3.5.4 Establecer espacios de formación en las comunas y salas de batalla social, gestionados por las propias comunidades, para el aprendizaje y socialización de conocimiento.	427	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.5.4
457	2.3.5.5 Contribuir a la formación técnico-productiva para el desarrollo local y el fortalecimiento de las capacidades productivas del Poder Popular.	427	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.5.5
984	ACTIVIDAD IMPARTIDA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
458	2.4.1 Preservar los valores bolivarianos liberadores, igualitarios, solidarios del pueblo venezolano y fomentar el desarrollo de una nueva ética socialista.	300	4	1	2016-05-23 02:23:25.145124	\N	2016-05-23 02:23:25.145124	t	Objetivo Estrategico 2.4.1
461	2.4.1.2 Desarrollar una batalla frontal contra las diversas formas de corrupción, fortaleciendo las instituciones del Estado, fomentando la participación protagónica del Poder Popular, promoviendo la transparencia y la automatización de la gestión pública, así como los mecanismos legales de sanción penal, administrativa, civil y disciplinaria contra las lesiones o el manejo inadecuado de los fondos públicos.	458	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.1.2
462	2.4.1.3 Promover la ética y los valores socialistas, la formación y autoformación, la disciplina consciente basada en la crítica y la autocrítica, la práctica de la solidaridad y el amor, la conciencia del deber social y la lucha contra la corrupción y el burocratismo.	458	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.1.3
464	2.4.2.1 Ampliar los mecanismos de contraloría social para resguardar los intereses colectivos, fomentando la nueva ética revolucionaria en el desempeño de las funciones públicas.	459	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.2.1
465	2.4.2.2 Multiplicar los mecanismos que permitan al Poder Popular ejercer su capacidad y potestad en la prevención, vigilancia, supervisión y acompañamiento en la gestión de los fondos públicos, organismos de la administración pública y en las mismas instancias del Poder Popular.	459	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.2.2
472	2.5.6 Fortalecer el Sistema Nacional de Planificación Pública y Popular para la construcción de la sociedad socialista de justicia y equidad, en el marco del nuevo Estado democrático y social de Derecho y de Justicia.	301	7	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.6
473	2.5.7 Fortalecer el Sistema Estadístico Nacional en sus mecanismos, instancias y operaciones estadísticas. 	301	6	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.7
474	2.5.8 Impulsar el desarrollo de la normativa legal e infraestructura necesaria para la consolidación de Gobierno Electrónico.	301	2	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.8
475	2.5.1.1 Diseñar junto a las diferentes organizaciones del Poder Popular, normas que desarrollen los principios constitucionales para el ejercicio de la democracia directa.	467	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.1.1
480	2.5.2.3 Promover el desarrollo de la planificación participativa territorial y económica, a través de la articulación permanente de los planes comunitarios y comunales con los planes locales, regionales y nacionales.	468	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.2.3
478	2.5.2.1 Transferir, competencias de los distintos niveles del Poder Público a las comunas, comunidades organizadas y demás organizaciones del Poder Popular, bajo las directrices del Consejo Federal de Gobierno, con el mayor grado de planificación para el adecuado desarrollo territorial.	468	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.2.1
479	2.5.2.2 Desplegar la función planificadora del Consejo Federal de Gobierno, propiciando la coordinación y control de las acciones del Poder Ejecutivo Nacional en las diferentes instancias territoriales, político administrativas y comunales, para el adecuado desarrollo regional bajo criterios de sostenibilidad y sustentabilidad guiado por los principios socialistas.	468	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.2.2
467	2.5.1 Desatar la potencia contenida en la Constitución Bolivariana para el ejercicio de la democracia participativa y protagónica.	301	3	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.1
468	2.5.2 Desarrollar el Sistema Federal de Gobierno, basado en los principios de integridad territorial, económica y política de la Nación, mediante la participación protagónica del Poder Popular en las funciones de gobierno comunal y en la administración de los medios de producción de bienes y servicios de propiedad social.	301	3	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.2
469	2.5.3 Acelerar la construcción de la nueva plataforma institucional del Estado, en el marco del nuevo modelo de Gestión Socialista Bolivariano.	301	6	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.3
470	2.5.4 Impulsar una profunda, definitiva e impostergable revolución en el sistema de administración de Justicia, entre los Poderes Públicos y el Poder Popular, que garantice la igualdad de condiciones y oportunidades a toda la población a su acceso y aplicación.	301	7	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.4
471	2.5.5 Desplegar en sobremarcha la Gran Misión ¡A Toda Vida! Venezuela concebida como una política integral de seguridad ciudadana, con el fin de transformar los factores de carácter estructural, situacional e institucional, generadores de la violencia y el delito, para reducirlos, aumentando la convivencia solidaria y el disfrute del pueblo al libre y seguro ejercicio de sus actividades familiares, comunales, sociales, formativas, laborales, sindicales, económicas, culturales y recreacionales.	301	16	1	2016-05-23 02:34:00.529808	\N	2016-05-23 02:34:00.529808	t	Objetivo Estrategico 2.5.5
476	2.5.1.2 Establecer nuevos y permanentes mecanismos de integración entre Estado y Sociedad fortaleciendo la organización y las capacidades para la Defensa Integral de la Nación.	467	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.1.2
477	2.5.1.3 Fortalecer los sistemas de comunicación permanente, que permitan la interacción entre las instituciones públicas y el Poder Popular para la construcción colectiva del nuevo Estado Socialista, bajo el principio de "mandar, obedeciendo".	467	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.1.3
481	2.5.3.1 Establecer políticas de estímulo y reconocimiento a los servidores públicos, así como de líderes populares y sociales, que desarrollen el ejercicio de sus funciones en el marco de los valores que comportan la ética socialista.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.1
482	2.5.3.2 Forjar una cultura revolucionaria del servidor público, regida por la nueva ética socialista, promoviendo una actuación en función de la acción del Estado, fundamentado en el principio de la administración pública al servicio de las personas.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.2
483	2.5.3.3 Promover la revalorización de la cultura del saber y del trabajo con visión socialista, mediante la creación de Escuelas de Formación de Cuadros Administrativos, Políticos y Técnicos en las Instituciones del Estado, en las empresas de Propiedad Social, en las instancias del Poder Popular y en las instituciones públicas, como mecanismos indispensables para la transformación del Estado.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.3
759	4.3 Continuar impulsando el desarrollo de un mundo multicéntrico y pluripolar sin dominación imperial y con respeto a la autodeterminación de los pueblos.	90	4	1	2016-06-06 00:17:33.54993	\N	2016-06-06 00:17:33.54993	t	Objetivo Nacional 4.3
484	2.5.3.4 Ejecutar un proceso de reorganización de la Administración Pública, homologando y dignificando las condiciones de los servidores públicos, de acuerdo a sus roles y competencias, para potenciar y ampliar sus capacidades, con miras a desarrollar el modelo económico productivo socialista.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.4
252	1.5.2.1 Actualizar y orientar los programas formativos integrales y permanentes hacia las necesidades y demandas del sistema productivo nacional, con el fin de garantizar la formación técnica, profesional y ocupacional del trabajo.	241	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.2.1
486	2.5.3.6 Suprimir los requerimientos innecesarios exigidos a los ciudadanos y ciudadanas para la realización de trámites administrativos, a través de la masificación de tecnologías y unificación de criterios, erradicando definitivamente la actividad de los gestores.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.6
487	2.5.4.1 Fortalecer el sistema de administración de justicia mediante la dotación de los medios necesarios para su óptimo desempeño, incluyendo el nivel de investigación criminal que permita combatir la impunidad y el retraso procesal.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.1
488	2.5.4.2 Promover la justicia de paz comunal como herramienta eficaz para respaldar la convivencia pacífica y favorecer la práctica de la solidaridad y el amor entre los venezolanos y las venezolanas.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.2
489	2.5.4.3 Mejorar la infraestructura existente y construir nuevos espacios físicos para aumentar el número de Tribunales y Fiscalías a nivel Nacional.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.3
490	2.5.4.4 Apoyar la implementación de Fiscalías y Juzgados Municipales en todo el país.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.4
492	2.5.4.6 Promover la articulación e integración coherente de los instrumentos jurídicos existentes, que favorezca la eficiencia y eficacia en la aplicación de la justicia.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.6
493	2.5.4.7 Apoyar la creación de mecanismos alternativos de resolución de conflictos, mediante la instalación de Casas de la Justicia Penal en cada uno de los municipios priorizados.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.7
495	2.5.5.2 Consolidar el Movimiento Por la Paz y la Vida para la construcción de una cultura de paz, mediante propuestas y acciones a favor de una convivencia pacífica, segura, solidaria y libertaria, a través del fortalecimiento de la organización y la movilización popular en apoyo a la Gran Misión A Toda Vida Venezuela.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.2
496	2.5.5.3 Impulsar los comités y campañas de desarme voluntario de la población, así como la reinserción plena en la sociedad de quienes hagan entrega voluntaria de armas, con procedimientos ajustados a derecho, para fortalecer las políticas públicas de seguridad ciudadana, atacando las causas del delito y generando condiciones de paz y de justicia desde dentro de las comunidades.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.3
497	2.5.5.4 Fortalecer los órganos de seguridad pública y ciudadana en materia de control y prevención del delito, mediante la dotación de equipamiento individual e institucional a los cuerpos de policía y la tecnificación comunicacional para una respuesta rápida y efectiva.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.4
498	2.5.5.5 Desplegar la Policía Nacional Bolivariana en todo el territorio nacional.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.5
499	2.5.5.6 Implementar el Plan Patria Segura a nivel nacional, para fortalecer la capacidad del Estado de protección a los ciudadanos y construir la paz desde adentro, en corresponsabilidad con el poder popular y la Fuerza Armada Nacional Bolivariana.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.6
500	2.5.5.7 Culminar el proceso de refundación del Cuerpo de Investigaciones Científicas, Penales y Criminalísticas (CICPC).	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.7
1020	EXPEDIENTE	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1021	AUTO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
501	2.5.5.8 Crear y socializar el conocimiento para la convivencia y la seguridad ciudadana, constituyendo Centro Comunales Integrales de Resolución de Conflicto.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.8
502	2.5.5.9 Proseguir con la expansión de la UNES en el territorio nacional, con el fin de aumentar la capacidad de investigación y formación del nuevo modelo policial y la producción de saber en materia de seguridad ciudadana.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.9
503	2.5.5.10 Activar el Sistema Nacional de Atención a las Víctimas.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.10
504	2.5.5.11 Crear un área estratégica o campo de conocimiento sobre seguridad ciudadana, a través del Fondo Nacional de Ciencia, Innovación y Tecnología.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.11
505	2.5.5.12 Fortalecer los órganos en materia de protección civil, administración de desastres y emergencias, para garantizar la protección ciudadana ante cualquier situación que implique amenaza, vulnerabilidad o riesgo.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.12
506	2.5.5.13 Optimizar el establecimiento de políticas y planes que promuevan una cultura hacia la prevención y atención ante eventos adversos, sustentándose en los valores de voluntariedad, solidaridad y desprendimiento.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.13
507	2.5.5.14 Mantener y reforzar la lucha frontal contra la producción, tráfico y consumo ilícito de drogas, legitimación de capitales y delincuencia organizada, considerados asuntos de seguridad de Estado, de conformidad con las leyes nacionales, convenios, acuerdos y tratados internaciones.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.14
508	2.5.5.15 Fortalecer los procesos en materia de identificación, migración y extranjería, mediante la implantación de alta tecnología, con el propósito de garantizar el derecho a la identidad y a la seguridad jurídica.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.15
509	2.5.5.16 Optimizar los procesos de registro público y del notariado para garantizar la seguridad jurídica de las actuaciones de los usuarios, mediante la publicidad registral y fe pública, de procesos expeditos y oportunos, apegados a la Ley.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.16
510	2.5.6.1 Avanzar en el desarrollo del ordenamiento legal del Sistema de Planificación Pública y Popular.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.1
760	4.4 Desmontar el sistema neocolonial de dominación imperial.	90	3	1	2016-06-06 00:17:33.54993	\N	2016-06-06 00:17:33.54993	t	Objetivo Nacional 4.4
88	2. Continuar construyendo el socialismo bolivariano del siglo XXI, en Venezuela, como alternativa al sistema destructivo y salvaje del capitalismo y con ello asegurar "la mayor suma de felicidad posible, la mayor suma de seguridad social y la mayor suma de estabilidad política" para nuestro pueblo.	86	5	1	2016-05-22 19:14:15.541209	\N	2016-05-22 19:14:15.541209	t	Objetivo Historico 2
194	1.4.1.3 Fortalecer el uso oportuno de las herramientas geográficas como instrumento de sistematización y difusión de la gestión y análisis del desarrollo rural integral del país.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.3
198	1.4.1.7 Contribuir con la soberanía alimentaria en el país mediante el fortalecimiento del sistema de transporte y la conectividad acuática y aérea.	182	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.1.7
200	1.4.2.2 Fortalecer los programas de mantenimiento y construcción de vialidad y electrificación rural, con la creación de brigadas y unidades de mecanización vial por parte de la Milicia Nacional Bolivariana, los Consejos Comunales y Campesinos, las Redes de Productores Libres y Asociados, las Alcaldías, las Gobernaciones y el Instituto Nacional de Desarrollo Rural.	183	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.2.2
218	1.4.5.1 Impulsar la conformación, organización, planificación, financiamiento y compras a redes de productores libres y asociados (REPLAs) en el entorno de las plantas agroindustriales, para garantizar la transformación del modelo agrícola actual hacia la agricultura planificada bajo los principios socialistas.	186	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.5.1
222	1.4.6.3 Fortalecer y modernizar el sistema de regulación social y estatal para combatir la usura y la especulación en la compra y distribución de los alimentos, dado su carácter de bienes esenciales para la vida humana.	187	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.6.3
234	1.4.8.4 Diseñar medidas de fomento para la creación o reactivación del sector productivo nacional con miras a la exportación, con especial atención a las pequeñas y medianas empresas, empresas de propiedad social directa, cooperativas y otras formas asociativas.	189	0	1	2016-05-22 21:40:51.040787	\N	2016-05-22 21:40:51.040787	t	Objetivo General 1.4.8.4
240	1.5.1 Consolidar un estilo científico, tecnológico e innovador de carácter transformador, diverso, creativo y dinámico, garante de la independencia y la soberanía económica, contribuyendo así a la construcción del Modelo Productivo Socialista, el fortalecimiento de la Ética Socialista y la satisfacción efectiva de las necesidades del pueblo venezolano.	96	8	1	2016-05-22 21:46:01.715456	\N	2016-05-22 21:46:01.715456	t	Objetivo Estrategico 1.5.1
247	1.5.1.4 Crear espacios de innovación asociadas a unidades socioproductivas en comunidades organizadas, aprovechando para ello el establecimiento de redes nacionales y regionales de cooperación científico—tecnológica, a fin de fortalecer las capacidades del Sistema Nacional de Ciencia, Tecnología e Innovación.	240	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.1.4
832	4.4.3.3 Incrementar la participación económica y tecnológica de polos emergentes del mundo en proyectos de desarrollo nacional.	820	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.3.3
833	4.4.3.4 Establecer alianzas para la coordinación política y el intercambio económico entre mecanismos de unión del Sur de los diferentes continentes, con especial énfasis en el Grupo de países BRICS.	820	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.3.4
512	2.5.6.3 Optimizar los procesos de definición, formulación, ejecución , control y evaluación de las políticas públicas, regulando la relación entre los distintos niveles políticos del Poder Público, y la relación de éstos con el Poder Popular.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.3 
513	2.5.6.4 Desarrollar un sistema único que integre la formulación, ejecución y control de los planes y proyectos vinculados con el presupuesto público, que permita el seguimiento oportuno de las metas y objetivos establecidos, promoviendo la transparencia en el manejo de los recursos públicos, bajo criterios de prudencia y racionalidad económica.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.4
514	2.5.6.5 Promover al Sistema Nacional de Planificación como instancia coordinadora, e integradora de la actividad planificadora, favoreciendo la política de ordenación del territorio de acuerdo a sus capacidades y recursos físicos, naturales, ambientales y patrimoniales, dando relevancia a su historia.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.5
515	2.5.6.6 Establecer mecanismos de formación integral en materia de planificación a los servidoras y servidores públicos, así como a los voceros del Poder Popular, orientados al fortalecimiento de las capacidades técnicas para el desarrollo de proyectos y el diseño de políticas públicas.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.6
516	2.5.6.7 Consolidar la democracia protagónica y participativa del pueblo, dando significancia al papel planificador de los consejos comunales, que se incorporan al Sistema Nacional de Planificación Pública a través del Consejo de Planificación Comunal y las instancias de planificación de los Consejos Comunales.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.7
517	2.5.7.1 Desarrollar indicadores y estadísticas con el Poder Popular para ser incluidos en el Sistema Estadístico Nacional.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.1
518	2.5.7.2 Fortalecer la producción, interoperabilidad e intercambio de información estadística oficial producida por organismos, entes y empresas del Estado.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.2
519	2.5.7.3 Impulsar el desarrollo de la cartografía con fines estadísticos y el mapeo de las políticas sociales.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.3
520	2.5.7.4 Desarrollar investigaciones estadísticas mediante el sistema integrado de estadísticas sociales y económicas, para el seguimiento de las políticas y medición de impactos.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.4
521	2.5.7.5 Asegurar la formación sistemática en estadísticas públicas.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.5
522	2.5.7.6 Desarrollar un nuevo sistema de indicadores del vivir bien, que permita una efectiva evaluación y visibilización de los avances de la Revolución Bolivariana.	473	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.7.6
524	2.5.8.2 Adecuar y fortalecer las plataformas de las instituciones del Estado como vía para mejorar la eficiencia en el intercambio de datos necesario para el desarrollo del Gobierno Electrónico.	474	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.8.2
552	3.1.2.6 Construir una capacidad de almacenamiento de 20 millones de barriles de crudo y productos, y el tendido de 2 .000 Km de tuberías entre oleoductos y diluenductos con capacidad de transportar 2,5 MMBD.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.6
262	1.5.3.4 Desarrollar una política integral que impulse la creación de centros tecnológicos en centros educativos, universitarios, técnicos, medios que garanticen procesos formativos integrales y continuos en materia de equipos electrónicos y aplicaciones informáticas en tecnologías libres y estándares abiertos.	242	0	1	2016-05-22 21:59:56.082393	\N	2016-05-22 21:59:56.082393	t	Objetivo General 1.5.3.4
294	1.7.1.4 Crear estrategias que generen el reconocimiento por parte de la población sobre los cambios de condiciones ordinarias a condiciones extraordinarias, para la activación y movilización organizada en el marco de la defensa integral de la patria.	289	0	1	2016-05-22 22:23:28.829977	\N	2016-05-22 22:23:28.829977	t	Objetivo General 1.7.1.4
531	3.1.3 Mantener la producción en las áreas tradicionales de petróleo y gas.	525	3	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.3
532	3.1.4 Desarrollar las reservas del Cinturón Gasífero en nuestro mar territorial . Incrementando la capacidad de producción y acelerando los esfuerzos exploratorios de nuestras reservas.	525	3	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.4
534	3.1.6 Expandir la infraestructura de transporte, almacenamiento y despacho de petróleo y gas, sobre la base de complementar los objetivos de seguridad energética de la Nación, la nueva geopolítica nacional y el incremento de la producción nacional de petróleo y gas.	525	8	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.6
535	3.1.7 Fortalecer y expandir la industria petroquímica nacional.	525	6	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.7
536	3.1.8 Desarrollar el complejo industrial conexo a la industria petrolera, gasífera y petroquímica para fortalecer y profundizar nuestra soberanía económica.	525	4	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.8
537	3.1.9 Fortalecer y profundizar la soberanía tecnológica del sector hidrocarburos.	525	9	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.9
538	3.1.10 Profundizar la diversificación de nuestros mercados internacionales de hidrocarburos, con el objetivo de utilizar la fortaleza de ser un país potencia energética, para desplegar nuestra propia geopolítica.	525	3	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.10
539	3.1.11 Fortalecer y profundizar las capacidades operativas de PDVSA.	525	6	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.11
540	3.1.12 Garantizar la Seguridad Energética del país, optimizando la eficiencia en la planificación estratégica y táctica, que permita minimizar los riesgos inherentes a los flujos energéticos en el territorio.	525	5	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.12
541	3.1.13 Fortalecer al Estado en el control y gestión del sistema eléctrico nacional para su ampliación y consolidación.	525	10	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.13
542	3.1.14 Fortalecer y profundizar la cooperación energética internacional.	525	3	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.14
543	3.1.15 Contribuir al desarrollo del sistema económico nacional mediante la explotación y transformación racional sustentable de los recursos minerales, con el uso de tecnología de bajo impacto ambiental.	525	4	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.15
544	3.1.16 Desarrollar el potencial minero nacional para la diversificación de las fuentes de empleo, ingresos y formas de propiedad social.	525	8	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.16\t
526	3.2 Desarrollar el poderío económico en base al aprovechamiento óptimo de las potencialidades que ofrecen nuestros recursos para la generación de la máxima felicidad de nuestro pueblo, así como de las bases materiales para la construcción de nuestro socialismo bolivariano.	89	7	1	2016-06-05 17:02:19.913905	\N	2016-06-05 17:02:19.913905	t	Objetivo Nacional 3.2
527	3.3 Ampliar y conformar el poderío militar para la defensa de la Patria.	89	3	1	2016-06-05 17:02:19.913905	\N	2016-06-05 17:02:19.913905	t	Objetivo Nacional 3.3
528	3.4 Profundizar el desarrollo de la nueva geopolítica nacional.	89	7	1	2016-06-05 17:02:19.913905	\N	2016-06-05 17:02:19.913905	t	Objetivo Nacional 3.4
545	3.1.1.1 Alcanzar la capacidad de producción de crudo hasta 3,3 MMBD para el año 2014 y 6 MMBD para el año 2019.	529	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.1.1
546	3.1.1.2 Alcanzar la producción de gas natural para el año 2014 hasta 7 .830 MMPCD y en el año 2019 a 10.494 MMPCD.	529	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.1.2
547	3.1.2.1 Desarrollar la producción de las siete nuevas empresas mixtas ya establecidas de producción y procesamiento de los crudos de la Faja Petrolífera del Orinoco, para alcanzar la capacidad de producción de 2.090 MBD en el 2019.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.1
529	3.1.1 Desarrollar la capacidad de producción del país en línea con las inmensas reservas de hidrocarburos, bajo el principio de la explotación racional y la política de conservación del recurso natural agotable y no renovable.	525	2	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.1
530	3.1.2 Desarrollar la Faja Petrolífera del Orinoco, para alcanzar, mediante las reservas probadas, ya certificadas, una capacidad de producción total de 4 MMBD para el 2019, en concordancia con los objetivos estratégicos de producción de crudo, bajo una política ambientalmente responsable.	525	11	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.2
533	3.1.5 Adecuar y expandir el circuito de refinación nacional para el incremento de la capacidad de procesamiento de hidrocarburos, en específico crudo extra pesado de la Faja, desconcentrando territorialmente la manufactura de combustible y ampliando la cobertura territorial de abastecimiento de las refinerías.	525	3	1	2016-06-05 17:14:11.703634	\N	2016-06-05 17:14:11.703634	t	Objetivo Estrategico 3.1.5
548	3.1.2.2 Elevar la producción, en las áreas de la Faja Petrolífera del Orinoco actualmente desarrolladas por PDVSA y las Empresa Mixtas a 1 .910 MBD al 2019, aplicando tecnologías que incrementen el factor de recobro.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.2
549	3.1.2.3 Construir cinco nuevos mejoradores para convertir el crudo extrapesado de la Faja Petrolífera del Orinoco en 8° API en crudo mejorado de 32 a 42 API con una capacidad total de 1 MMBD de procesamiento.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.3
550	3.1.2.4 Construir una nueva refinería en el Complejo Industrial José Antonio Anzoátegui con una capacidad de procesamiento de 373 MBD y la primera etapa de una nueva refinería en Cabruta, con una capacidad de procesamiento de 220 MBD.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.4
551	3.1.2.5 Perforar en los bloques asignados 10 .550 pozos horizontales de petróleo, agrupados en 520 macollas de producción.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.5
553	3.1.2.7 Construir un terminal de aguas profundas en el estado Sucre para la recepción y despacho de crudos y productos, con una capacidad de exportación de 2,0 MMBD, así como tres terminales fluviales de sólidos y líquidos en el río Orinoco para el almacenamiento de 120 mil toneladas de coque y 90 mil toneladas de azufre, así como el despacho de 250 MBD de crudo, todo ello en armonía con el ambiente.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.7
554	3.1.2.8 Construir tres plantas termoeléctricas con una capacidad total de generación de 2 .100 MW, las cuales emplearán coque petrolero generado por el proceso de mejoramiento de los crudos de la Faja Petrolífera del Orinoco, contribuyendo así al aprovechamiento de los subproductos generados y al mejoramiento de la matriz energética de consumo.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.8
555	3.1.2.9 Construir dos condominios industriales, uno en el área de Carabobo y otro en el área de Junín, para el suministro de servicios de hidrógeno, nitrógeno, aire comprimido, vapor, agua industrial y de enfriamiento, almacenamiento de coque y azufre, y distribución de electricidad, a los nuevos mejoradores.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.9
556	3.1.2.10 Crear cinco (5) Bases Petroindustriales Socialistas (BPISOS) en la zona de la Faja Petrolífera del Orinoco, en las áreas de Palital, Chaguaramas, San Diego de Cabrutica, Soledad y Santa Rita para desarrollar actividades de metalmecánica, serviciosa pozos, químicos y servicios especializados a refinación.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.10
557	3.1.2.11 Desarrollar facilidades portuarias y aéreo-portuarias en el eje Norte-Sur del río Orinoco.	530	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.2.11
558	3.1.3.1 Continuar las actividades de perforación, rehabilitación y reparación de pozos, que permitan mantener la producción.	531	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.3.1
559	3.1.3.2 Mantener y mejorar los proyectos de recuperación secundaria existentes e incorporar nuevos proyectos a través de tecnologías de inyección de agua y gas, inyección continúa de vapor y surfactantes.	531	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.3.2
560	3.1.3.3 Mantener y mejorar los niveles de confiabilidad mantenibilidad de la infraestructura existente.	531	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.3.3
561	3.1.4.1 Desarrollar las potencialidades existentes en el Cinturón Gasífero de Venezuela en los proyectos Rafael Urdaneta y Mariscal Sucre, para alcanzar una capacidad de producción de gas de 300 MMPCD para el 2014 y 2 .030 MMPCD para el año 2019.	532	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.4.1
562	3.1.4.2 Acelerar los esfuerzos exploratorios del Cinturón Gasífero de Venezuela en las áreas Blanquilla, Golfo de Venezuela, Ensenada de Barcelona, el norte de Mariscal Sucre y Fachada Atlántica, para la búsqueda de nuevas reservas de gas no asociado que permita incorporar reservas de gas con expectativa exploratoria de 135 BPC de gas natural.	532	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.4.2
563	3.1.4.3 Acelerar la incorporación de condensado, hidrocarburo de alto valor comercial, que genera las actividades de explotación de los recursos de hidrocarburos costa afuera, la cual aportará más de 64 MBD al 2019.	532	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.4.3
564	3.1.5.1 Adecuar y expandir el sistema de refinación nacional de 1,3 MMBD en el 2013 a 1,8 MMBD en el 2019, impulsando un mayor procesamiento de los crudos pesados y extrapesados de la Faja Petrolífera del Orinoco, y adaptarlo a las exigencias de calidad de productos en los mercados nacional e internacional.	533	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.5.1
565	3.1.5.2 Adecuar y expandir las refinerías existentes de El Palito, Puerto La Cruz y Complejo Refinador Paraguaná.	533	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.5.2
566	3.1.5.3 Construir dos nuevas refinerías, Batalla de Santa Inés de 100 MBD y Petrobicentenario de 373 MBD, para balancear el suministro del mercado interno e incrementar el contenido de productos en la cesta de exportación de Venezuela.	533	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.5.3
567	3.1.6.1 Adecuar y expandir los sistemas de transporte por poliductos existentes, tales como el Sistema de Suministros Los Andes (SUMANDES) y el Sistema Suministro Oriente (SISOR), y la construcción de nuevos poliductos como Puerto La Cruz- Maturín, Bajo Grande-Planta Ramón Laguna, El Vigía-La Fría, y El Palito-Barquisimeto.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.1
568	3.1.6.2 Adecuar y ampliar la red de plantas de distribución de combustibles, impulsando la construcción de nuevos sistemas, así como la adecuación de los existentes ; entre ellas El Guamache, en la Isla de Margarita y Puerto Pesquero Güiria, y la construcción de nuevas plantas, como Planta del Oeste de Caracas, Guatire, Catia La Mar, Batalla Santa Inés, Cabruta y Jose.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.2
1022	NOTIFICACIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1023	DECISIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
569	3.1.6.3 Ampliar la red de transporte de gas hasta alcanzar 3 .648 Km de gasoductos entre existentes y nuevos como los gasoductos José Francisco Bermúdez (SINORGAS) y el Norte Llanero Fase I.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.3
570	3.1.6.4 Incrementar la capacidad de extracción de líquidos de gas natural, de alto valor comercial, en 130 MBD, a través de los proyectos de procesamiento de gas en el Oriente del País.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.4
571	3.1.6.5 Incrementar la capacidad de compresión de gas para su utilización en el sector industrial y doméstico así como en las operaciones de producción de la industria petrolera mediante la construcción de la infraestructura necesaria que garantice el manejo oportuno de nuevos requerimientos.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.5
572	3.1.6.6 Fortalecer y ampliar la cobertura de la red de distribución de gas metano, con el fin de desplazar el consumo de Gas Licuado de Petróleo (GLP) y brindar mayor calidad de vida a la población y menor contaminación del ambiente, a través del tendido de 8 .625 Km de redes de tubería y 16 .818 Km de líneas internas para beneficiara 728 .900 familias.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.6
573	3.1.6.7 Satisfacer la demanda de gas doméstico a través del aumento de Capacidad Almacenaje de GLP.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.7
574	3.1.6.8 Reacondicionar e incrementar la capacidad de almacenamiento de crudo mediante la adecuación y expansión de la infraestructura existente.	534	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.6.8
575	3.1.7.1 Diversificar el procesamiento de gas natural, naftas y corrientes de refinación, para la generación de productos de mayor valor agregado y la eliminación de importaciones de insumos para refinación.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.8
576	3.1.7.2 Consolidar y desarrollar los seis polos Petroquímicos planificados : Ana María Campos, Morón, José Antonio Anzoátegui, Paraguaná, Navay, Puerto de Nutrias y Güiria.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.9
577	3.1.7.3 Incrementar la producción de fertilizantes nitrogenados y fosfatados en un 43%, lo cual cubrirá la demanda nacional y convertirá a Venezuela en un exportador de fertilizantes para toda la región.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.10
578	3.1.7.4 Incrementar en un 300% la capacidad de producción de olefinas y resinas plásticas tradicionales, y desarrollar otras cadenas de resinas plásticas necesarias para el país, sustituyendo importaciones.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.11
579	3.1.7.5 Expandir en 87% la capacidad instalada del sector productor de químicos, haciendo énfasis en la producción de aromáticos y el desarrollo de las cadenas aguas abajo del metanol y la urea.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.12
580	3.1.7.6 Continuar en el marco de la Gran Misión Vivienda Venezuela, desarrollando las fábricas modulares de viviendas y accesorios (Petrocasas), instalando en diferentes zonas del país diez nuevas plantas, para alcanzar una producción de 50.000 viviendas/año, 800 .000 ventanas/año y 800 .000 puertas/año.	535	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.7.13
581	3.1.8.1 Incrementar la capacidad de ensamblaje y fabricación en el país de taladros y equipos de servicios a pozos, a través de empresas como la Industria China Venezolana de Taladros (ICVT), así como la capacidad de fabricación nacional de tubulares, válvulas y otros bienes de uso en operaciones petroleras.	536	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.8.1
582	3.1.8.2 Fortalecer los procesos de construcción de plataformas de perforación y producción de los yacimientos Costa Afuera, a partir de la experiencia nacional en esta materia, garantizando la disponibilidad de dichos equipos para el desarrollo de la producción gasífera, tal como la plataforma 4 de Febrero que opera en el Golfo de Paria, a fin de garantizar la oportuna disponibilidad de los equipos requeridos en el desarrollo de Mariscal Sucre, Cardón IV y Plataforma Deltana.	536	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.8.2
583	3.1.8.3 Impulsar las actividades de las empresas estatales de mantenimiento, para mejorar el tiempo, servicio y costo de las paradas de planta, en el sistema de refinación nacional y mejoradores.	536	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.8.3
584	3 1.8.4 Impulsar el procesamiento de subproductos petroleros, mediante la creación de empresas estatales, mixtas y conglomerados industriales para la producción de insumos requeridos por las industrias básicas, que permitan integrar las cadenas de petróleo y gas natural con las de hierro-acero y bauxita-aluminio, a través de la instalación de plantas de calcinación del coque, y recuperación de metales del flexicoque y coque verde, ferrovanadio, brea de petróleo y orimatita, entre los casos de negocio identificados.	536	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.8.4
585	3.1.9.1 Continuar con el desarrollo en el país de las tecnologías propias de mejoramiento de crudos pesados y extrapesados y promover su uso, a través de procesos de mejoramiento en sitio, procesos de conversión profunda y procesos de visco reducción.	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.1
586	3.1.9.2 Posicionar el uso de tecnologías de recuperación secundaria y terciaria de crudos pesados y extrapesados, para incrementar el factor de recobro en los yacimientos, tales como inyección continua de vapor, combustión in situ e inyección de surfactantes.	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.2
587	3.1.9.3 Crear la Escuela Técnica Petrolera Socialista para la capacitación de los técnicos medios requeridos en la industria petrolera.	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.3
588	3.1.9.4 Implementar a nivel nacional la Universidad de los Hidrocarburos, a fin de cumplir con la formación técnica y político-ideológica de cuadros para las áreas de desarrollo petrolero, en particular para la Faja Petrolífera del Orinoco y Costa Afuera.	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.4
589	3.1.9.5 Impulsar la formación técnica y político-ideológica, así como la investigación y los encuentros de socialización, para la industrialización de los hidrocarburos, a través del establecimiento de instituciones educativas, científicas y tecnológicas, que contribuyan en el desarrollo de los sectores de transformación aguas abajo.	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.5
590	3.1.9.6 Impulsar la investigación en las áreas de coque y minerales provenientes del procesamiento de los crudos de la Faja Petrolífera del Orinoco, para su industrialización. 	537	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.9.6
591	3.1.10.1 Profundizar las estrategias de diversificación de mercados de crudos y productos derivados hacia mercados que permitan la mejor valorización del crudo venezolano y elimine la dependencia del mercado norteamericano.	538	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.10.1
1024	PROYECTO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
592	3.1.10.2 Profundizar la estrategia de integración y posicionamiento de Venezuela en Latinoamérica y El Caribe, mediante la construcción de un circuito de refinación que articule con las refinerías en Venezuela para contrarrestar la influencia en la formación de precios de los combustibles que tienen otros países, asi como en incrementar la exportación de crudos y productos hacia estas regiones para alcanzar un volumen de 1 .335 MBD en el 2019.	538	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.10.2
593	3.1.10.3 Incrementar la exportación de crudo hacia Asia, en especial China, India y Japón para alcanzar un volumen de exportación de 3.162 MBD en el 2019.	538	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.10.3
651	3.2.3.1 Establecer alianzas estratégicas en un mundo pluripolar que garanticen la transferencia tecnológica y la mejora y humanización de los procesos productivos.	632	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.3.1
594	3.1.11.1 Intensificar las acciones necesarias para garantizar la disponibilidad de los recursos humanos, logísticos y financieros requeridos para ejecutar los planes, programas y proyectos de Petróleos de Venezuela y sus empresas mixtas.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.1
595	3.1.11.2 Incrementar la confiabilidad y disponibilidad de la infraestructura de recolección, tratamiento, almacenamiento, embarque, medición y refinación de hidrocarburos de Petróleos de Venezuela y sus empresas mixtas.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.2
596	3.1.11.3 Garantizar la capacitación y formación del talento humano para ejecutar eficientemente las actividades de la cadena de valor de los hidrocarburos en Petróleos de Venezuela.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.3
597	3.1.11.4 Reforzar el sistema de autosuficiencia eléctrica en los campos operacionales, asegurando autonomía con el sistema eléctrico nacional y esquemas flexibles para la generación de 1.260 MW.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.4
598	3.1.11.5 Optimizar la capacidad de manejo de operaciones acuáticas en el Lago de Maracaibo y todas las embarcaciones petroleras a nivel nacional.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.5
599	3.1.11.6 Promover la fabricación e incrementar la capacidad nacional de ensamblaje y mantenimiento de taladros, así como la capacidad de transporte y logística que permita reducir los tiempos improductivos, atender los planes de crecimiento y fortalecer el control de las actividades medulares.	539	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.11.6
600	3.1.12.1 Diversificar la matriz de energía primaria y adecuar el consumo energético a los mejores estándares de eficiencia, incorporando coque, carbón y energías alternativas.	540	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.12.1
601	3.1.12.2 Sincronizar la producción de los distintos combustibles con la demanda interna, asegurando los días de cobertura requeridos y su disponibilidad en el territorio nacional.	540	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.12.2
602	3.1.12.3 Fomentar el desarrollo de combustibles alternativos que reemplacen paulatinamente el consumo de derivados del petróleo.	540	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.12.3
603	3.1.12.4 Reforzar planes de contingencia en materia de producción y disponibilidad energética, para atender oportunamente los eventos de fuerza mayor.	540	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.12.4
604	3.1.12.5 Ejecutar los proyectos de adecuación, rehabilitación, construcción y mantenimiento de instalaciones y equipos del sistema eléctrico.	540	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.12.5
605	3.1.13.1 Fortalecer y ampliar el sistema eléctrico nacional.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.1
606	3.1.13.2 Diversificar la matriz de insumos para la generación eléctrica, favoreciendo el uso del gas natural, el coque y otras fuentes de energía.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.2
607	3.1.13.3 Completar el desarrollo hidroeléctrico del país, a través de la culminación de los complejos Hidroeléctricos ubicados en el Caroní y en Los Andes.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.3
608	3.1.13.4 Impulsar el uso de tecnologías más eficientes para la generación eléctrica, a través de los cierres de ciclos combinados en las plantas térmicas.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.4
609	3.1.13.5 Ampliar y mejorar el uso de la red de transmisión y distribución de electricidad.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.5
610	3.1.13.6 Satisfacer los requerimientos de demanda de electricidad mediante el desarrollo de infraestructura eléctrica, con criterios de eficiencia, uso racional, calidad, continuidad, confiabilidad, respeto al medio ambiente, seguridad y sustentabilidad económica financiera.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.6
611	3.1.13.7 Fomentar el uso eficiente de la energía eléctrica, a través de una cultura de consumo eficiente y la utilización de fuentes alternas y renovables.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.7
612	3.1.13.8 Garantizar el suministro eléctrico para los proyectos asociados con las misiones sociales, con énfasis en la Gran Misión Vivienda Venezuela, así como para nuevos proyectos socio-productivos previstos en este plan.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.8
613	3.1.13.9 Impulsar y garantizar la seguridad integral y el resguardo de las instalaciones del sistema eléctrico.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.9
614	3.1.13.10 Crear un fondo de desarrollo para las inversiones del sector eléctrico.	541	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.13.10
615	3.1.14.1 Consolidar las alianzas estratégicas entre los países signatarios de los acuerdos del ALBA, Petrocaribe, acuerdos de cooperación energética y convenios integrales de cooperación.	542	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.14.1
616	3.1.14.2 Profundizar las alianzas políticas y económicas con aquellos países con posicionamiento geoestratégico favorable y cuyos intereses converjan con los de nuestra nación, favoreciendo la construcción de un mundo pluripolar.	542	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.14.2
617	3.1.14.3 Profundizar las relaciones de cooperación con los países en la región, en base a los principios de complementariedad y solidaridad, con el propósito de proveerle a los países aliados el acceso a la energía.	542	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.14.3
618	3.1.15.1 Incrementar el nivel de prospecciones geológicas para aumentar la certificación de reservas de minerales a nivel nacional.	543	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.15.1
693	3.3.2 Desarrollar el sistema de adiestramiento con la doctrina militar Bolivariana para la Defensa Integral de la Patria.	527	5	1	2016-06-05 20:20:19.656821	\N	2016-06-05 20:20:19.656821	t	Objetivo Estrategico 3.3.2
1025	CERTIFICADOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
619	3.1.15.2 Explorar nuevos yacimientos minerales en el Escudo de Guayana, Sistema Montañoso del Caribe, Cordillera de los Andes y Sierra de Perijá, con la prospección geológica y la utilización de nuevas tecnologías de bajo impacto ambiental.	543	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.15.2
620	3.1.15.3 Duplicar las reservas minerales de bauxita, hierro, coltán (niobio y tantalita), níquel, roca fosfórica, feldespato y carbón, con la certificación de los yacimientos ubicados en el Escudo de Guayana, Cordillera de los Andes, Sistema Montañoso del Caribe y la Sierra de Perijá.	543	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.15.3
621	3.1.15.4 Duplicar las reservas minerales de oro y diamante con la certificación de los yacimientos ubicados en el Escudo de Guayana, para su utilización como bienes transables para el fortalecimiento de las reservas internacionales.	543	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.15.4
622	3.1.16.1 Impulsar el desarrollo de la minería, partiendo de la demanda endógena industrial como fuerza motriz y articulando la demanda interna con la demanda internacional.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.1
623	3.1.16.2 Integrar las actividades mineras, explotando racionalmente los yacimientos minerales, a través del desarrollo de los conocimientos científicos y tecnológicos, que permita elevar la productividad y mejorar la eficiencia de la producción en el sector.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.2
701	3.3.2.3 Desarrollar un sistema de entrenamiento y preparación combativa más eficiente y de acuerdo a nuestra realidad.	693	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.2.3
985	MATERIAL INFORMATIVO ENTREGADO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
624	3.1.16.3 Incrementar la producción de oro y diamante, actualizando tecnológicamente las empresas estatales de oro, conformando empresas mixtas en las cuales la República tenga el control de sus decisiones y mantenga una participación mayoritaria, y organizando la pequeña minería en unidades de producción de propiedad social.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.3
625	3.1.16.4 Conformar empresas mixtas para la explotación y procesamiento de bauxita, hierro, coltán (niobio y tantalita), níquel, roca fosfórica, feldespato y carbón ; en las cuales la República tenga el control de sus decisiones y mantenga una participación mayoritaria.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.4
626	3.1.16.5 Conformar empresas de propiedad social directa, fomentando la transformación de minerales no metálicos, de uso principal para la construcción de obras civiles, tales como arcillas blandas, arenas, gravas, granzón, granito, granodiorita, esquistos, mármol, gneis, cal, yeso y sal .	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.5
627	3.1.16.6 Promover el desarrollo de tecnologías mineras que disminuyan el impacto ambiental, los volúmenes de material residual y el procesamiento superficial del material útil; aprovechando el potencial de las universidades e institutos del país y los convenios de transferencia tecnológica firmados con países aliados.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.6
628	3.1.16.7 Organizar la pequeña minería, concentrada en la explotación de oro y diamante, en unidades de producción donde el Estado brinde apoyo tecnológico y financiero para proteger la salud de los trabajadores, los recursos naturales y el medio ambiente.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.7
629	3.1.16.8 Crear el Fondo de Desarrollo Social Minero con aportes financieros de la actividad minera, para garantizar la seguridad social del trabajador.	544	0	1	2016-06-05 18:59:39.676884	\N	2016-06-05 18:59:39.676884	t	Objetivo General 3.1.16.8
630	3.2.1 Avanzar hacia la soberanía e independencia productiva en la construcción de redes estratégicas tanto para bienes esenciales como de generación de valor, a partir de nuestras ventajas comparativas.	526	11	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.1
631	3.2.2 Aprovechar las ventajas de localización de nuestro país a escala continental y diversidad de regiones nacionales, a efecto de fomentar su especialización productiva, asociada a ventajas comparativas de sectores estratégicos.	526	3	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.2
632	3.2.3 Apropiar y desarrollar la técnica y tecnología como clave de la eficiencia y humanización del proceso productivo, anclando eslabones de las cadenas productivas y desatando el potencial espacial de las mismas.	526	5	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.3
634	3.2.5 Desarrollar, fortalecer e impulsar los eslabones productivos de la industria nacional identificados en proyectos de áreas prioritarias tales como automotriz, electrodomésticos, materiales de construcción, transformación de plástico y envases, química, hierro-acero, aluminio, entre otras; orientados por un mecanismo de planificación centralizada, sistema presupuestario y modelos de gestión eficientes y productivos cónsonos con la transición al socialismo .	526	24	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.5
635	3.2.6 Fortalecer el sector turismo como estrategia de inclusión social que facilite y garantice al pueblo venezolano, fundamentalmente a las poblaciones más vulnerables, el acceso a su patrimonio turístico (destinos turísticos) y el disfrute de las infraestructuras turísticas del Estado en condiciones de precios justos y razonables.	526	3	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.6
636	3.2.7 Desarrollar el sector turismo como una actividad productiva sustentable que genere excedentes que puedan redistribuirse para satisfacer las necesidades del pueblo.	526	5	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.7
633	3.2.4 Generar mecanismos de circulación del capital que construyan un nuevo metabolismo económico para el estímulo, funcionamiento y desarrollo de la industria nacional.	526	4	1	2016-06-05 19:11:58.508428	\N	2016-06-05 19:11:58.508428	t	Objetivo Estrategico 3.2.4
652	3.2.3.2 Impulsar un desarrollo tecnológico soberano a partir de las necesidades de nuestra industria, para hacer viable el aprovechamiento eficiente y sustentable de los recursos y estructuras de costo apropiadas.	632	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.3.2
854	5.1.3.4 Promover el desarrollo de actividades de turismo sustentable y sostenible para el disfrute de la población.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.4
855	5.1.3.5 Constituir un sistema nacional, regional y local para el aprovechamiento de residuos y desechos, para la creación de insumos útiles para el vivir bien, dándole prioridad a su uso como materias primas secundarias para la industria nacional.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.5
856	5.1.3.6 Preservar y manejar las áreas estratégicas para la conservación, tales como las Abraes, por los beneficios vitales que se derivan de su conservación y su contribución a la suprema felicidad social.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.6
857	5.1.3.7 Promover la conformación de redes locales, nacionales e internacionales para el impulso del modelo ecosocialista.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.7
858	5.1.3.8 Promover prácticas de conservación del ambiente en la actividad socio-productiva, superando el criterio de "eficiencia económica" por ser una práctica desvinculada de la racionalidad en el uso de los recursos naturales.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.8
859	5.1.3.9 Implementar políticas de financiamiento para el desarrollo de unidades productivas, promoviendo el uso de tecnologías amigables con el ambiente.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.9
860	5.1.3.10 Rescatar los saberes ancestrales de los pueblos originarios sobre los procesos productivos, para el desarrollo de tecnologías sustentables que incidan en los nuevos esquemas de relacionamiento internacional.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.10
861	5.1.3.11 Fomentar medios de pago alternativos que trasciendan el uso de monedas (de papel y metálicas), facilitando el establecimiento del comercio justo entre los pueblos suramericanos y países aliados, a la vez que se modifique la influencia del dólar estadounidense como patrón referencial en el comercio internacional.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.11
862	5.1.3.12 Facilitar el acceso a los pequeños y medianos productores y a las formas asociativas de propiedad y de producción, para su inserción efectiva en las cadenas de valor intrarregionales, con sostenibilidad ambiental.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.12
702	3.3.2.4 Comunicar la nueva concepción de Defensa Integral.	693	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.2.4
637	3.2.1.1 Expandir y fortalecer las capacidades de extracción y procesamiento primario y desarrollo aguas abajo de las cadenas de hierro-acero y aluminio . Desconcentrar la localización de acerías y construirlas en distintas regiones del país, para optimizar las distancias de distribución y sentido geoestratégico, atendiendo parámetros de eficiencia energética y sustentabilidad ambiental, así como el desarrollo aguas abajo de nuevos productos . Alcanzar la meta de extracción de 30 MM tn de mineral de hierro y 9 MM tn de acero líquido en 2019, lo que implica la instalación de una capacidad de 4 MM tn en acerías nuevas y en las que están construcción, así como las consecuentes de reducción directa . En el caso del aluminio, recuperar capacidad de extracción y transporte de bauxita así como alcanzar los valores necesarios de la producción de alúmina, ajustando la estructura de costos para hacerla eficiente.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.1
638	3.2.1.2 Desarrollar la producción primaria y construir los ejes estratégicos en la química petroquímica, así como las cadenas asociadas de productos derivados ; como base de la industrialización en la generación de bienes de consumo intermedios y finales; al tiempo que la industria de maquinarias asociadas para tales fines.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.2
639	3.2.1.3 Expandir y desarrollar la producción primaria y aprovechamiento forestal del país, ampliando las plantaciones en volumen y territorialmente, e infraestructura de transformación en toda la cadena productiva, para muebles, viviendas, papel e insumos de otros procesos industriales ; elevando la superficie plantada de 500 mil Ha a 2 millones de Ha así como su transformación integral en el país y saneamiento y prevención en las superficies plantadas. Diversificar la plantación y producción forestal . Alcanzar 1 .167 mil m3 de madera procesada en el 2014 y los 3 .160 mil m3 en el 2016 estabilizándose hasta 2019 . Proyectar las capacidades para un consumo anual de 6,8 millones de m3/año para el periodo 2020-2030 .	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.3
640	3.2.1.4 Industrializar el sector construcción para atender la satisfacción del desarrollo de viviendas, edificaciones, equipamiento urbano e infraestructura . Componentes eléctricos, bombillos de bajo consumo eléctrico, salas de baño, herrajes, piezas de fundición de tamaño medio, grifería, grupos de duchas, uniones y conexiones de bronce, pintura : equipos y maquinarias de construcción; tecnificación e industrialización de sistemas constructivos, entre otros.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.4
641	3.2.1.5 Desarrollar el aprovechamiento soberano tanto en la extracción como en el procesamiento de los minerales no metálicos; técnicas de maxímización del rendimiento y cuidado ambiental, en especial de las cadenas de cemento y agregados de construcción, vidrio e insumos productivos especiales (feldespato, caolín, cal, cal siderúrgica, yeso, caliza, sílice, soda ash entre otros) y nuevos desarrollos como el coltán.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.5
642	3.2.1.6 Construir un amplio tejido industrial, asociado a una arquitectura de redes de sinergias productivas, zonas especiales de desarrollo y Parques y nodos Industriales, orientado a bienes esenciales de consumo final y/o generación de valor.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.6
643	3.2.1.7 Ampliar la capacidad instalada, modernizar y fomentar la apropiación tecnológica en la producción de envases y empaques, tanto para la soberanía alimentaria como para la industria en general. Desarrollo soberano de la industria de plasticubierta, diferentes resinas y cartones para abastecer las demandas nacionales del sector de alimentos . Desarrollo de aplicaciones vinculadas a insumos agrícolas e industriales a partir de los sectores de petroquímica y papel, a efectos de abastecer integralmente las demandas nacionales y exportar en : sacos de cemento, fertilizantes y materiales de construcción . Desarrollo de tecnologías y aplicaciones en vidrio, plástico, cartón y aluminio para la industria farmacéutica así como de higiene y cuidado personal, tanto en consumo nacional como exportación al Alba, Caribe y Mercosur, especialmente.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.7
644	3.2.1.8 Privilegiar la adquisición de productos industriales nacionales, así como estimular su producción para la ejecución de los proyectos nacionales.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.8
645	3.2.1.9 Aplicar mecanismos de fomento y regulación para fortalecer el aparato productivo nacional en los sectores estratégicos.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.9
646	3.2.1.10 Impulsar el establecimiento de normas en los acuerdos comerciales bilaterales y regionales, orientadas a fortalecer las capacidades productivas nacionales y transferencia tecnológica, así como la complementariedad de las cadenas productivas regionales y de la nueva geopolítica internacional para fortalecer el aparato productivo nacional, e igualmente a corregir el daño o afectación de la producción nacional causada por el incremento de importaciones o la presencia de prácticas desleales en las mismas.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.10
647	3.2.1.11 Impulsar mecanismos y prácticas de vigilancia tecnológica para la protección de marcas y patentes venezolanas en el extranjero, incluyendo el monitoreo y las acciones defensivas necesarias para la salvaguarda de este patrimonio intangible de los venezolanos y las venezolanas.	630	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.1.11
1026	CIRCULAR	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1027	REUNIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
648	3.2.2.1 Configurar un esquema de especialización espacial productiva, a partir de las ventajas de localización basadas en el uso racional y eficiente de los recursos disponibles con criterios de independencia, soberanía y equilibrio interregional, constituyendo el eje funcional de las escalas de planificación espacial del país y el sistema de ciudades.	631	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.2.1
649	3.2.2.2 Generar una estructura de sostén productivo, redes regionales, infraestructura de apoyo a la producción, logística y distribución que tiendan a construir economía de escala en una nueva cultura organizativa . Desarrollar la estrategia de conglomerados y alianzas estratégicas a efectos de canalizar los insumos industriales así como la distribución de los mismos, en una dinámica de ruptura del metabolismo del capital . Constituir una red de transporte Estatal así como una nueva lógica al sistema de transporte nacional que racionalice los costos y garantice los tiempos de los insumos y productos en un marco de soberanía nacional. Articular un sistema multimodal de transporte y almacenaje, rentable y eficiente para la producción y distribución, a escala nacional e internacional . Fortalecer y expandir redes alternas de distribución de productos sin intermediación especulativa.	631	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.2.2
650	3.2.2.3 Desarrollar parques y demás áreas de aglomeración industrial como nodos del nuevo sistema productivo nacional y de complementariedad con los proyectos de integración de Nuestra América.	631	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.2.3
653	3.2.3.3 Garantizar procesos formativos integrales y continuos de los trabajadores para adoptar técnicas y tecnologías que hagan más eficiente la producción y humanizar el proceso de trabajo : a) estandarizando el programa de la Escuela en la Fábrica como política de formación y trabajo liberador ; b) Propiciando la política del punto y círculo como método de trabajo, para el fortalecimiento de la base productiva del entorno, articulación social y los encadenamientos productivos ; c) abriendo la Escuela en la Fábrica a las comunidades aledañas con participación de los trabajadores como facilitadores y multiplicadores del proceso ; d) desarrollando proyectos asociados a subproductos y desechos para generar actividad económica a partir del reciclaje ; y e) ampliar las plataformas de formación técnica y profesional para el trabajo.	632	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.3.3
654	3.2.3.4 Fomentar el uso de tecnología y el comercio electrónico seguro en el intercambio de servicios, materias primas, bienes semi-elaborados y productos finales, como aporte a la reducción de los eslabones de las cadenas de comercialización de bienes y servicios básicos para la población, contribuyendo al acercamiento entre productores y compradores, así como nuevas formas organizativas que enfrenten el mercado especulativo.	632	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.3.4
655	3.2.3.5 Desarrollar procesos industriales a escala comunal vinculados con las demandas las grandes y medianas industrias nacionales.	632	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.3.5
656	3.2.4.1 Diseñar e implantar una arquitectura financiera eficiente y soberana, orientada a apalancar el proceso de industrialización nacional en la planificación, evaluación de viabilidad, fondos de preinversión, ejecución y acompañamiento del nuevo aparato productivo: a) Articulando y fortaleciendo los fondos de desarrollo industrial soberano para el nuevo tejido industrial ; b) Impulsando el financiamiento propio y con mecanismos internacionales soberanos a los proyectos industriales estructurantes ; c) Fortaleciendo los bancos e instrumentos financieros de segundo piso para la inversión y expansión del sistema productivo; d) Generando una política para los recursos de la banca a efectos de democratizar el acceso a los recursos para los distintos actores económicos, en especial las pequeñas y medianas empresas, empresas comunales, mixtas, privadas y estatales ; y e) Fomentando los mecanismos institucionales.	633	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.4.1
657	3.2.4.2 Desarrollar economías de escala y complementariedad en el tejido productivo social a objeto de construir un nuevo metabolismo económico, contrario a la lógica del capital, implementando un sistema de aportes de los excedentes de las empresas de propiedad social directa e indirecta, en el marco de la planificación nacional.	633	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.4.2
658	3.2.4.3 Mantener e incrementar los sistemas de compras públicas con el objetivo de impulsar el desarrollo del aparato productivo nacional mediante el flujo circular del capital hacia conglomerados, pequeñas y medianas empresas, empresas comunales, en tanto que motores de la ubicación directa de los bienes y servicios producidos, favoreciendo así la economía a nivel regional.	633	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.4.3
659	3.2.4.4 Desarrollar el diseño, desarrollo de materiales, ingeniería de procesos para la producción de bienes de capital y fábricas madres (fábricas de fábricas).	633	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.4.4
660	3.2.5.1 Afianzar la cadena productiva hierro-acero a efectos de estabilizar las producción, con base en las capacidades instaladas y crear nuevas capacidades, de acuerdo con la meta de extracción de mineral de hierro de 30 MM tn para el 2019, certificación de reservas y la generación de valor agregado nacional : a) fábrica de cabillas y bobinas de acero de Sidor, así como componentes de alto valor agregado, necesidad nacional y potencial exportador ; b) fortalecimiento del Complejo Siderúrgico Nacional en su capacidad de acería y laminación así como ramificación regional ; c) producción y reparación de válvulas petroleras y sinergias entre las plantas existentes así como en tubos sin costura ; d) fábrica de piezas forjadas para la industria petrolera y del aluminio ; e) ejecución organizativa de la Corporación del Hierro Acero y economía de escala en la procura y comercialización soberana.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.1
661	3.2.5.2 Ampliar el horizonte productivo mediante la construcción de los siguientes proyectos estructurantes de la cadena hierro-acero : a) Fábrica de tubos sin costura ; b) Siderúrgica Nacional "José Ignacio de Abreu e Lima" ; c) plantas recuperadoras de materias primas ; d) en Ferrominera del Orinoco : planta de concentración de mineral de hierro (cuarcitas friables), ampliación del muelle de Palúa, aumento de capacidad de transporte ferroviario a 42 MM tn, dotación de maquinaria, equipos y repuestos para minas ; e) fortalecimiento y desarrollo del sistema de transformación nacional para incorporar valor agregado.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.2
673	3.2.5.14 Incrementar las capacidades productivas de los productos de higiene personal y del hogar haciendo énfasis en jabones, champú, desodorante, máquinas de afeitar, papel sanitario, pasta de diente, a efectos de satisfacer con producción nacional la demanda interna.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.14
695	3.3.1.1 Afianzar la cooperación con países hermanos en correspondencia con las necesidades inherentes a la Defensa Integral de la Patria.	692	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.1.1
1028	REUNIONES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
662	3.2.5.3 Fortalecer el potencial de empresas existentes de la cadena hierro-acero : a) en Sidor : recuperación de línea de decapado, máquina de colada continua, línea de mallas electrosoldadas así como otros componentes de generación de valor ; b) alianza estratégica para la producción de electrodos ; c) red de trenes de laminación de escala regional para incorporar la producción de 500 mil tn de cabillas a nivel nacional ; d) construcción de un sistema complementario siderúrgico de HRD, en plantas de 1 a 1,5 MM tn, para dar valor agregado a las nuevas capacidades de extracción de mineral que se desarrollarán ; e) ampliación y construcción de planta de cal para la producción siderúrgica ; f) centros nacionales de acopio de chatarra ferrosa y política de protección como insumo estratégico nacional ; y g) recuperación de capacidad de producción de pellas y briquetas así como generación de nuevos balances de materiales.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.3
663	3.2.5.4 Afianzar los siguientes proyectos en operación en el sector aluminio : Capacidades de producción primaria : a) fábrica de aluminio primario Alcasa ; b) fábrica de aluminio primario Venalum ; c) certificación y producción de bauxita Bauxilum ; Capacidades de transformación ; d) transformadoras de aluminio asociadas a capacidades de extrusión, laminación e inyección ; e) fábrica de rines a afectos de otorgar valor agregado a la materia prima ; f) fábrica de papel de aluminio y envases ; g) fábrica de cables desnudos y recubiertos de aluminio ; h) centros de insumos de materia prima para el sector privado y público nacional ; i) política nacional de fomento y fortalecimiento del sector transformador nacional ; j) desarrollo industrial de los insumos del sector y aprovechamiento de subproductos.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.4
664	3.2.5.5 Culminar en los plazos establecidos la construcción del proyecto Empresa de servicios de laminación del aluminio (Serlaca).	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.5
986	CONTACTO ESTABLECIDO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
665	3.2.5.6 Desarrollar los siguientes proyectos en el sector aluminio : a) adecuación tecnológica de Alcasa y de Venalum para incremento de producción de aluminio primario ; b) en Cabelum, ampliación de capacidad para producción de alambrón y conductores eléctricos; planta de conductores eléctricos aislados de cobre y aluminio ; fábrica de conductores eléctricos ; certificación para exportación al Mercosur c) adecuación tecnológica y ampliación de Rialca ; d) en Bauxilum: adecuación de la planta de producción de alúmina metalúrgica y la mina de bauxita, y adquisición de maquinaria pesada para extracción y acarreo de bauxita y transporte de material ; e) incremento de capacidad de producción de conductores eléctricos de aluminio desnudo ; y f) desarrollo tecnológico para la incorporación de fibra óptica en el núcleo de los cables como oferta de los productos a generar.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.6
666	3.2.5.7 Desarrollar el sector automotriz, fortaleciendo los siguientes proyectos en operación : a) fábrica de asientos automotrices ; b) fábrica de estampados, troquelados y soldaduras de electropuntos para piezas automotrices ; c) planta de transformación de vidrio automotriz; d) ensambladoras de vehículos ; e) ensambladoras de tractores así como empresas mixtas con el sector productivo nacional ; f) ensambladoras de camiones y las alianzas estratégicas con el sector privado nacional ; g) producción de motos y h) ensambladora de bicicletas y fortalecimiento del sector de ensamblaje ; i) producción de partes y piezas .	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.7
667	3.2.5.8 Desarrollar los siguientes proyectos en conceptualización en el sector automotriz: a) fábrica de autobuses tanto para requerimiento nacional como capacidad de exportación ; b) nuevas capacidades en producción de camiones de carga pesada ; c) plantas de maquinaria de construcción y vialidad d) nuevas alianzas estratégicas para la producción de motos y motores fuera de borda e) alianza estratégica para la ampliación de capacidades en producción automotriz . Las capacidades a generar en camiones, autobuses, carros de pasajero y tractores serán con perfil de satisfacción plena del mercado nacional y exportación ; en alianza con la nueva geopolítica multipolar y las zonas económicas del ALBA, PetroCaribe y Mercosur.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.8
668	3.2.5.9 Afianzar el desarrollo del sector automotriz, logrando niveles crecientes de soberanía con : a) la incorporación de partes y piezas nacionales y la apropiación del conocimiento científico-tecnológico ; b) el fortalecimiento tecnológico y productivo del sector autopartista nacional ; c) el desarrollo del centro de ingeniería automotriz: desarrollo de la producción de partes y piezas de manera de incorporar más del 50% del valor para el 2015 y más del 60% para el 2019.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.9
669	3.2.5.10 Afianzar y desarrollar los siguientes proyectos del sector de materiales de construcción : a) fábrica de griferías ; b) fábrica productora de cal ; c) en cemento las empresas Cementos de Venezuela, Industrias Venezolanas del Cemento, Fábrica Nacional de Cemento, Cemento "Cerro Azul" y Cemento Andino ; planta de morteros así como nueva planta de cemento en los Arangues ; la expansión productiva implica adicionalmente segunda línea en San Sebastián de los Reyes y Cumarebo ; y la modificación del equipamiento en Cumarebo, para alcanzar las 16 MM tn en el 2017; d) desarrollo de la cadena de valor del cemento en el concreto y componentes de la construcción prefabricados a partir del cemento y fábrica de morteros secos ; e) fortalecimiento y expansión de sanitarios y cerámicos y de la cadena de insumos asociados, a objeto de cubrir los requerimientos de la Gran Misión Vivienda y capacidades de exportación ; y f) fábrica de partes e insumos industriales.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.10
670	3.2.5.11 Afianzar los siguientes proyectos : a) fábricas de estructuras ligeras de acero galvanizado para uso en construcción ; b) empresa de insumos básicos para la construcción de viviendas ; c) fábrica de producción de vidrio plano ; f) complejo industrial de cerámicas . g) fábrica de paneles prefabricados para la construcción ; f) sistema de aserraderos asociados a Maderas del Orinoco, g) forma organizativa del Conglomerado de Madera a efectos de cubrir las demandas de la Gran Misión Vivienda en tanto puertas y muebles ; h) desarrollo de la planta de paneles de madera.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.11
671	3.2.5.12 Consolidar el sector plástico, empaques y envases, lo que permitirá satisfacer las necesidades del país, haciendo énfasis en los envases de vidrio, plástico, aluminio, plasticubierta, cartón y bolsas. Esto a su vez permitirá la generación de nuevas vertientes de mayor valor agregado de uso en telefonía, informática, vehículos y electrodomésticos cónsonos con la preservación del ambiente. Desarrollar el sector del cartón.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.12
672	3.2.5.13 Ampliar y consolidar el sector de pañales y toallas sanitarias y toallines, con la participación de empresas del Estado, privadas y mixtas ; a efectos de satisfacer para el 2019 todo el requerimiento nacional.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.13
674	3.2.5.15 Desarrollar nuevos proyectos y alianzas para la producción de fármacos e insumos para el sector salud con el fin de cubrir la demanda nacional y de los países del ALBA y atender potencialidades de PetroCaribe y Mercosur . Desarrollar la producción de productos de látex como guantes y preservativos . Desarrollo de fármacos e insumos para la sanidad animal y vegetal.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.15
675	3.2.5.16 Continuar afianzando el desarrollo y ampliación de los proyectos relativos a la fabricación de productos del área de informática y celulares, con creciente incorporación de valor agregado nacional, transferencia tecnológica y esquemas de exportación hacia países aliados, especialmente en el marco de Mercosur.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.16
676	3.2.5.17 Consolidar y ampliar desarrollo de proyectos en el sector de maquinaria y equipos, tales como : a) fábricas de maquinaria pesada para la construcción ; b) fábricas de equipos para procesamiento de alimentos; c) fábricas de equipos de refrigeración industrial.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.17
699	3.3.2.1 Mejorar y adaptar los diseños curriculares en correspondencia con la ética Bolivariana, el concepto de guerra popular prolongada y asimétrica y las nuevas concepciones y necesidades del sector militar.	693	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.2.1
700	3.3.2.2 Consolidar y profundizar la doctrina Bolivariana, en nuestra Fuerza Armada Nacional Bolivariana.	693	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.2.2
677	3.2.5.18 Consolidar la construcción y puesta en marcha de los siguientes proyectos en la cadena productiva forestal-papel : a) Empresa de producción de papel prensa para alcanzar las 250 mil tn/año ; b) Modernización y ampliación de capacidades públicas, con proyectos tales como sacos para cemento y papel higiénico para alcanzar la satisfacción plena de las necesidades nacionales ; y c) Alianzas estratégicas para producción de implementos escolares ; d) culminación del sistema de aserraderos y planta de tableros ; e) carretes y paletas de madera ; y f) muebles y componentes de construcción.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.18
678	3.2.5.19 Desarrollar los siguientes proyectos en el sector textil-calzado : a) tenerías para procesamiento de pieles ; b) desarrollo conglomerado textil y del calzado, para toda la cadena productiva ; c) incrementar la producción primaria de algodón y su procesamiento ; d) fortalecer la producción de hilados, tejidos de algodón, así como la confección de prendas y calzados e) producción de suelas ; f) desarrollar tejidos con mezcla sintética ; g) desarrollar los componentes asociados a los insumos industriales del sector.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.19
679	3.2.5.20 Continuar el impulso a la fabricación nacional de electrodomésticos, consolidando proyectos existentes y ampliando e incentivando nuevos proyectos y la productividad del sector. Incentivar la participación estatal y alianza con privados nacionales e internacionales . Desarrollar énfasis especial en la producción de los componentes e insumos . Instalación de capacidades en Venezuela para la exportación a los países del Alba, Mercosur y Petrocaribe. Desarrollar el centro de ingeniería aplicada y de materiales.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.20
680	3.2.5.21 Desarrollar las capacidades industriales de construcción de maquinaria, equipos e infraestructura del país y de la región. Desarrollo de soporte a la agroindustria . Equipamiento agrícola y alimentos concentrados . Hacer especial énfasis en la cadena del frío.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.21
681	3.2.5.22 Ampliar las capacidades de producción de insumos químicos para la industria a efectos de disminuir la dependencia del componente importado, aprovechando las potencialidades nacionales y generación de cadena de valor.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.22
682	3.2.5.23 Crear nuevos canales y formas de distribución-comercialización a los productos y servicios de manufactura nacional con calidad certificada que permitan el beneficio de un amplio sector de la población de manera económica, constante y eficiente, y promover la fidelidad de los beneficiarios al sello "Hecho en Venezuela".	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.23
683	3.2.5.24 Generar y fortalecer los subsistemas de normalización, metrología y evaluación de la conformidad del Sistema Nacional de la Calidad, requeridos para el desarrollo de los eslabones productivos y concreción de los proyectos de las fabricas socialistas impulsados por el Estado en la construcción del socialismo bolivariano.	634	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.5.24
684	3.2.6.1 Potenciar a Venezuela como multidestino, garantizando el aumento del turismo receptivo, incrementando así el ingreso de divisas al país y fortaleciendo los destinos no tradicionales.	635	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.6.1
685	3.2.6.2 Fortalecer la promoción turística nacional, a través de políticas y programas de turismo social y comunitario, particularmente la promoción de los destinos turísticos deprimidos y los emprendimientos agro y eco turísticos.	635	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.6.2
686	3.2.6.3 Fortalecer la formación integral turística a nivel nacional, a través del crecimiento del Colegio Universitario Hotel Escuela de los Andes venezolanos y el establecimiento de las rede de escuelas de oficios en turismo.	635	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.6.3
687	3.2.7.1 Promover el crecimiento del turismo interno, a través de políticas y programas de turismo social y comunitario, incrementando de manera sostenida el número de movimientos turísticos internos así como la inversión en desarrollo y mejoramiento de infraestructura y servicios turísticos.	636	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.7,1
688	3.2.7.2 Fortalecer a VENETUR como la primera operadora turística del país y posicionar a la Red de Hoteles Venetur como la principal alternativa de alojamiento turístico de gran calidad.	636	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.7,2
689	3.2.7.3 Fomentar la inversión nacional e internacional en el sector turístico, a través del estímulo a los prestadores de servicios turísticos actuales y potenciales de manera de mejorar de manera sostenida la infraestructura y los servicios turísticos.	636	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.7,3
690	3.2.7.4 Fortalecer el posicionamiento internacional de Venezuela como destino turístico, a través de la promoción turística.	636	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.7,4
691	3.2.7.5 Desarrollar la infraestructura y servicios de apoyo a la actividad turística, mediante el fortalecimiento de vialidad, puertos y aeropuertos.	636	0	1	2016-06-05 20:16:48.119601	\N	2016-06-05 20:16:48.119601	t	Objetivo General 3.2.7,5
694	3.3.3 Mejorar y perfeccionar el sistema educativo de la Fuerza Armada Nacional y el Poder Popular, para fortalecer la unidad cívico militar en función de los intereses de la Patria.	527	3	1	2016-06-05 20:20:19.656821	\N	2016-06-05 20:20:19.656821	t	Objetivo Estrategico 3.3.3
1029	BALANCES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
696	3.3.1.2 Fomentar la transferencia tecnológica en cada fase de dotación de nuestra Fuerza Armada Nacional Bolivariana a través de la activación de nuevas industrias y entes generadores de bienes y servicios.	692	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.1.2
697	3.3.1.3 Incrementar el desarrollo de las tecnologías propias de nuestra industria militar, para asegurar autonomía y soberanía en el espacio aéreo, naval y terrestre.	692	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.1.3
698	3.3.1.4 Reforzar los vínculos de integración de nuestra Patria con países hermanos para compartir capacidades y conocimientos en función del vivir bien de nuestro pueblo.	692	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.1.4
987	AYUDA OTORGADA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
988	MEDIOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
703	3.3.2.5 Consolidar un sistema defensivo territorial capaz de dirigir al país en tiempo de guerra desde tiempo de paz, estratégicamente defensivo y eminentemente popular.	693	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.2.5
704	3.3.3.1 Preparar y adiestrar a los integrantes de nuestra Fuerza Armada Nacional Bolivariana bajo la premisa fundamental de los ideales bolivarianos de integración, soberanía, independencia, partiendo del concepto de guerra popular prolongada, asimétrica y de resistencia.	694	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.3.1
705	3.3.3.2 Integrar activamente los planes y diseños curriculares de las academias militares y universidades, para ponerlas al servicio del desarrollo nacional y la defensa integral de la Patria.	694	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.3.2
706	3.3.3.3 Incrementar la formación de profesionales militares y civiles en convenios con países hermanos, para contribuir recíprocamente en la unidad regional y en cívico militar.	694	0	1	2016-06-05 20:30:31.869607	\N	2016-06-05 20:30:31.869607	t	Objetivo General 3.3.3.3
708	3.4.2 Mantener y garantizar el funcionamiento del Consejo Federal de Gobierno, las instancias que lo conforman, así como las formas de coordinación de políticas y acciones entre las entidades político-territoriales y las organizaciones de base del Poder Popular.	528	0	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.2
713	3.4.7 Reforzar y desarrollar mecanismos de control que permitan al Estado ejercer eficazmente su soberanía en el intercambio de bienes en las zonas fronterizas.	528	0	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.7
707	3.4.1 Profundizar la integración soberana nacional y la equidad socio-territorial a través de Ejes de Desarrollo Integral : Norte Llanero, Apure-Orinoco, Occidental y Oriental, Polos de Desarrollo Socialista, Distritos Motores de Desarrollo, las Zonas Económicas Especiales y REDIS.	528	12	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.1
709	3.4.3 Promover la creación del los Distritos Motores de Desarrollo, con la finalidad de impulsar proyectos económicos, sociales, científicos y tecnológicos destinados a lograr el desarrollo integral de las regiones y el fortalecimiento del Poder Popular, en aras de facilitar la transición hacia el socialismo.	528	18	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.3
710	3.4.4 Mejorar e incrementar la infraestructura en las áreas de producción agrícola.	528	2	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.4
711	3.4.5 Integrar el territorio nacional, mediante los corredores multimodales de infraestructura : transporte terrestre, ferroviario, aéreo, fluvial, energía eléctrica, gas, petróleo, agua y telecomunicaciones.	528	6	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.5
712	3.4.6 Planificar desde el Gobierno Central y con protagonismo popular, el desarrollo urbano y rural de las ciudades existentes y de las nacientes a lo largo de nuestro territorio nacional.	528	5	1	2016-06-05 20:35:30.925295	\N	2016-06-05 20:35:30.925295	t	Objetivo Estrategico 3.4.6
714	3.4.1.1 Incrementar la sinergia entre regiones, mediante los ejes de integración y desarrollo Norte Llanero, Apure-Orinoco, Occidental y Oriental, a través de : a) Desarrollo de corredores de infraestructura de transporte multimodal, de energía y de telecomunicaciones en los Ejes de Integración y Desarrollo, constituyéndose el Eje Norte Llanero en articulador entre áreas productivas y de consumo nacional ; b) Implantación de industrias de transformación y de parques industriales temáticos en el Eje Norte Llanero.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.1
715	3.4.1.2 Ordenar el territorio y asegurar la base de sustentación ecológica, mediante la formulación e implementación de planes para las distintas escalas territoriales, la preservación de cuencas hidrográficas y cuerpos de agua, la conservación y preservación de ambientes naturales, el impulso de programas de manejo integral de desechos sólidos y la cultura de los pueblos.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.2
716	3.4.1.3 Fortalecer y mejorar los sistemas de agua potable a lo largo del territorio nacional, manteniendo e incrementando la continuidad del servicio de agua potable a 250 litros por persona, mediante la culminación y construcción de cien acueductos a nivel nacional, para garantizar la producción de 4 .000 millones de metros cúbicos de agua potable, entre otros : Acueducto Tuy 4, Luisa Cáceres de Arismendi, Ampliación del Sistema Regional del Centro y Acueducto Barcelona-Guanta-Lechería.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.3
717	3.4.1.4 Consolidar el Plan Nacional de Aguas para mejorar, reforzar y establecer el suministro de agua en todo el país y especialmente en comunidades populares, con la participación protagónica de los comités de agua y otras organizaciones del Poder Popular.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.4
718	3.4.1.5 Continuar incrementando y mejorando los sistemas de recolección y tratamiento de las aguas servidas en todo el territorio nacional, garantizando el vertido adecuado a los distintos cuerpos de agua.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.5
719	3.4.1.6 Promover y acelerar el desarrollo integral sustentable de la Faja Petrolífera del Orinoco, de acuerdo a la potencialidad productiva y el vivir bien de sus habitantes.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.6
743	3.4.3.18 Distrito Motor Urbano Ciudad Belén, ubicado en el Estado Miranda, para desarrollar el nuevo modelo de ciudad socialista.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.18
770	4.1.10 Promover la resolución armoniosa y cooperativa de las delimitaciones pendientes, entendiendo la estabilización de las fronteras como un elemento de unidad y de paz.	757	0	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.10
771	4.1.1.1 Fortalecer el papel de vanguardia del ALBA en el proceso de unidad de Nuestra América, dinamizando los nuevos espacios como la Unasur y la Celac, en torno a los principios de soberanía, cooperación, complementación y solidaridad.	761	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.1.1
772	4.1.1.2 Fortalecer los mecanismos de concertación política del bloque ALBA en los sistemas interamericano y mundial, hacia su transformación integral.	761	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.1.2
773	4.1.1.3 Construir la Zona Económica del ALBA, fortaleciendo el papel del Sistema Unitario de Compensación Regional (Sucre) y del Banco del Alba en la estrategia de complementariedad económica, financiera, productiva y comercial de la región.	761	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.1.3
740	3.4.3.15 Conformar el Distrito Motor Orichuna-Matiyure, estado Apure . Proyecto dinamizador : UPS Ganaderas, de especialización agropecuaria.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.15
871	5.1.6.1 Desarrollar proyectos de generación de energía eólica, para incrementar su participación en la matriz energética.	843	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.6.1
774	4.1.2.1 Profundizar la alianza entre Venezuela y los países del Caribe, mediante la iniciativa PETROCARIBE, consolidando una unión caribeña independiente y soberana para el desarrollo integral de sus pueblos, buscando corregir las asimetrías energéticas existentes fundamentándose en los principios de cooperación y solidaridad, avanzando hacia la creación de una Zona Económica Petrocaribe (ZEP) que considere a todos los países miembros del Caricom.	762	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.2.1
720	3.4.1.7 Mejorar la funcionalidad de la red de centros urbanos, articulándolos al nuevo modelo productivo : a) impulsando un sistema de ciudades policéntrico ; b) mejorando, ampliando y consolidando los sistemas de interconexión entre los centros poblados, en vialidad, transporte polimodal, puertos, aeropuertos y telecomunicaciones ; c) fomentando el crecimiento y transformación sustentable de los principales centros urbanos, las ciudades intermedias y los centros poblados menores, con especialización productiva y nuevos desarrollos habitacionales.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.7
721	3.4.1.8 Promover el desarrollo sustentable del Arco Minero, con el control soberano y hegemónico del Estado en la cadena productiva del sector y sus actividades conexas, promoviendo el desarrollo de tecnologías propias que permitan una explotación racional, y con base en la definición de unidades de gestión territorial para la coordinación de políticas públicas, preservando el acervo histórico y socio–cultural.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.8
722	3.4.1.9 Impulsar la consolidación de un sistema de áreas industriales, configurándolas en verdaderos Polos de Desarrollo en las regiones : a) consolidación del sistema de parques industriales ; b) desarrollo de los polos petroquímicos ; c) desarrollo de las Bases Petroindustriales Socialistas, de soporte a los emprendimientos petroleros.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.9
723	3.4.1.10 Preservar las cuencas hidrográficas y los cuerpos de agua.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.10
724	3.4.1.11 Maximizar el sistema portuario y aeroportuario que permita el flujo e intercambio entre los centros poblados.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.11
725	3.4.1.12 Desarrollar una taxonomía territorial que articule las comunas productivas con los distritos motores industriales, donde las Zonas Económicas Especiales serán una variante específica de esta para potenciar y direccionar tensores del desarrollo . La economía de escala supondrá una estructura de red productiva que sincronice las demandas industriales con las potencialidades y desarrollo de actividades en las comunas productivas . Al mismo tiempo desarrollar sobre esta estructura de sostén un tramado de parques industriales para el desarrollo nacional y como pivotes interconectados para la integración productiva bolivariana de Nuestra América.	707	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.1.12
726	3.4.3.1 Impulsar la creación de Distritos Motores de Desarrollo, fundamentada en criterios de desarrollo de potencialidades productivas sustentables, así como la ocupación del territorio en áreas estratégicas.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.1
727	3.4.3.2 Fomentar la creación de Distritos Motores de Desarrollo, en áreas que requieran atención prioritaria, haciendo énfasis en el reordenamiento territorial participativo en correspondencia con el interés nacional.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.2
728	3.4.3.3 Impulsar la creación de Distritos Motores de Desarrollo, fomentando la ejecución de obras y servicios esenciales en las regiones y comunidades de menor desarrollo relativo, disminuyendo las asimetrías entre las grandes ciudades y mejorando el hábitat comunitario.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.3
729	3.4.3.4 Decretar y desarrollar ocho (8) Distritos Motores de la Faja Petrolífera del Orinoco ; con el fin de apalancar el desarrollo petrolero así como sus potencialidades adicionales, elementos geohistóricos, relaciones funcionales, capacidades socio-productivas . Los Distritos Motores son : Mapire-Santa Cruz del Orinoco, Ciudad Bolívar-Soledad Falconero, Santa Rita-Caicara del Orinoco, Palital-Chaguaramas, Temblador, Santa María de Ipire y Zuata-San Diego de Cabrutica.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.4
730	3.4.3.5 Conformar el Distrito Motor Barlovento, Estado Miranda. Área con prioridad de tratamiento en la Cuenca del Río Tuy, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.5
731	3.4.3.6 Conformar el Distrito Motor Caicara-Cabruta, Estados Bolívar y Guárico . Proyectos dinamizadores : Tercer Puente sobre el Río Orinoco y UPS Algodones del Orinoco, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.6
732	3.4.3.7 Conformar el Distrito Motor Biruaca-Achaguas, Estados Guárico y Apure . Proyecto dinamizador: Centro de Caña Etanol, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.7
733	3.4.3.8 Conformar el Distrito Motor Paria, Estado Sucre . Proyectos dinamizadores : Proyecto Gasífero Petrolero, Delta-Caribe Oriental, Plataforma Deltana, Empresa Mixta Socialista Cacao del Alba, de especialización Agrícola-Turística.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.8
734	3.4.3.9 Conformar el Distrito Motor Sur del Lago, Estados Zulia y Mérida . Proyecto dinamizador UPS de Distribución, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.9
735	3.4.3.10 Conformar el Distrito Motor Santa Elena de Uairén-Ikabarú, Estados Bolívar y Amazonas . Proyecto dinamizador : transporte aéreo y fluvial, de especialización agroecológica y turística.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.10
736	3.4.3.11 Conformar el Distrito Motor Ortiz-Calabozo, Estados Guárico y Aragua . Proyectos dinamizadores : UPS Agroalimentaria, Complejo Agroindustrial Río Tiznado y Proyecto Río Guárico, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.11
737	3.4.3.12 Conformar el Distrito Motor Los Tacariguas-Las Tejerías. Estados Aragua y Carabobo . Proyectos dinamizadores: Ensambladora de Vehículos Irán-Venezuela y China-Venezuela, solución estructural del crecimiento del Lago de Tacarigua, de especialización industrial, ambiental y agrícola .	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.12
738	3.4.4.13 Conformar el Distrito Motor El Diluvio del Palmar, Estado Zulia . Proyecto dinamizador : Sistema de Riego el Diluvio, de especialización agrícola	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.13
739	3.4.3.14 Conformar el Distrito Motor Florentino (Boconó-Barinas), Estado Barinas y Trujillo . Proyectos dinamizadores: Autopista Boconó-Barinas, Centro de Mejoramiento Genético Florentino, de especialización agroindustrial.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.14
741	3.4.3.16 Conformar el Distrito Motor Urbano Ciudad Tiuna, ubicado en Distrito Capital y el Estado Bolivariano de Miranda, para desarrollar el nuevo modelo de ciudad socialista.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.16
742	3.4.3.17 Distrito Motor Urbano Ciudad Caribia, ubicado en Distrito Capital y el estado Vargas, para desarrollar el nuevo modelo de ciudad socialista.	709	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.3.17
744	3.4.4.1 Promover la creación de zonas de concentración agrícola con grandes potencialidades, con la finalidad de garantizar la seguridad alimentaria nacional y la producción de rubros agropecuarios tales como el maíz, el arroz, la soya, el algodón, el ganado, peces y aves.	710	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.4.1
745	3.4.4.2 Desarrollar las planicies centrales del Río Orinoco.	710	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.4.2
746	3.4.5.1 Mantener y construir las carreteras, autopistas y troncales, conectando las grandes y medianas ciudades a lo largo del territorio nacional.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.1
747	3.4.5.2 Construir la infraestructura vial necesaria que permita conectar las zonas industriales con las zonas de explotación de recursos, y mejorar las condiciones de las carreteras en las zonas rurales y agrícolas.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.2
748	3.4.5.3 Mejorar el servicio público a los usuarios y desplazar el viejo parque automotor que genera un alto consumo de combustible : a) promoviendo la creación de empresas de transporte bajo el esquema de propiedad social directa o indirecta ; y b) incorporando progresivamente energías limpias en las unidades de transporte público y privado.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.3
749	3.4.5.4 Culminar la construcción y rehabilitación de los tramos ferroviarios en ejecución y desarrollar nuevos tramos como columna vertebral de los Ejes de Integración y Desarrollo, para el transporte de pasajeros, productos agrícolas, industriales y bienes comerciales.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.4
750	3 4.5.5 Complementar el sistema de puertos y aeropuertos nacionales, con el fin de atender los requerimientos de manejo de carga nacional e internacional : a) desarrollando la infraestructura y servicios que permitan la navegación a lo largo del Río Orinoco y el Río Apure como canales fundamentales de comunicación, sin depredar el medio ambiente ; b) desarrollando un sistema de puertos con nodos regionales en los Ejes de Integración y Desarrollo Oriental, Occidental y Apure-Orinoco.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.5
751	3.4.5.6 Fortalecer las empresas estatales dirigidas al transporte acuático, aéreo y terrestre, de manera tal que permita mejorar el servicio público tanto de personas, como de materias primas, bienes intermedios y productos terminados, con elevada eficiencia, bajos costos y tarifas justas.	711	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.5.6
752	3.4.6.1 Impulsar el desarrollo de ciudades incluyentes y sustentables : a) implementando la ciudad compacta como modelo de desarrollo urbano sustentable, con edificaciones de baja altura y alta densidad ; b) fomentando la economía de espacios y recursos como medio para lograr el crecimiento urbano equilibrado.	712	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.6.1
753	3.4.6.2 Continuar el desarrollo de la Gran Misión Vivienda Venezuela para abatir el déficit habitacional acumulado : a) construyendo 2 .650 .000 de viviendas nuevas, distribuidas de tal manera que se consoliden los ejes de desarrollo integral, los polos de desarrollo y los distritos motores; b) promoviendo la autoconstrucción ; c) mejorando y ampliando 1 .000 .000 de viviendas, para consolidar asentamientos existentes.	712	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.6.2
754	3.4.6.3 Implementar planes de mejora y dotación de servicios públicos básicos : a) construyendo nuevos sistemas de distribución de agua potable y de saneamiento de aguas servidas en los asentamientos ; b) mejorando los sistemas de distribución local de electricidad ; c) acelerando el plan de distribución de gas doméstico; d) incorporando los nuevos desarrollos y las zonas sin servicio a la red de telecomunicaciones.	712	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.6.3
755	3.4.6.4 Mejorar y construir el equipamiento urbano necesario para garantizar la accesibilidad a servicios viales, educativos, de salud, deportivos, sociales, culturales, de esparcimiento y de seguridad.	712	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.6.4
756	3.4.6.5 Asociar actividades productivas de bajo impacto ambiental a los planes y proyectos urbanos, generando trabajo liberador para los nuevos habitantes, impulsando la diversificación productiva.	712	0	1	2016-06-05 21:00:37.860212	\N	2016-06-05 21:00:37.860212	t	Objetivo General 3.4.6.5
761	4.1.1 Fortalecer la Alianza Bolivariana para los Pueblos de Nuestra América (ALBA) como el espacio vital de relacionamiento político de la Revolución Bolivariana.	757	3	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.1
762	4.1.2 Fortalecer la iniciativa Petrocaribe como esquema de cooperación energética y social solidario.	757	2	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.2
763	4.1.3 Fortalecer Mercosur como espacio de cooperación e integración social, político, económico, productivo y comercial.	757	1	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.3
764	4.1.4 Consolidar la Unión de Naciones Suramericanas (Unasur) como espacio estratégico regional para la construcción del mundo pluripolar.	757	1	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.4
767	4.1.7 Avanzar en la creación de encadenamientos económicos productivos y esquemas de financiamiento con América Latina y el Caribe, que fortalezcan la industria nacional y garanticen el suministro seguro de productos.	757	2	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.7
765	4.1.5 Impulsar y fortalecer a la Comunidad de Estados Latinoamericanos y Caribeños (Celac), como mecanismo de unión de Nuestra América.	757	1	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.5
768	4.1.8 Profundizar las alianzas estratégicas bilaterales existentes entre Venezuela y los países de la región, con especial énfasis en la cooperación con Brasil, Argentina y Uruguay, en las distintas áreas de complementación y cooperación en marcha.	757	3	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.8
769	4.1.9 Impulsar el nuevo orden comunicacional de Nuestra América, con especial énfasis en los nuevos sistemas y medios de información regionales y en el impulso de nuevas herramientas comunicacionales.	757	6	1	2016-06-06 00:22:43.832916	\N	2016-06-06 00:22:43.832916	t	Objetivo Estrategico 4.1.9
775	4.1.2.2 Promover la coordinación entre la Zona Económica del Alba (Ecoalba), la Zona Económica Petrocaribe (ZEP) y el Mercosur, con el fin de crear una Zona Económica Caribeña Suramericana.	762	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.2.2
776	4.1.3.1 Consolidar la Misión Mercosur para desarrollar las áreas de capacitación y formación para la exportación ; investigación, innovación y transferencia tecnológica ; inversión para la producción y promoción de la exportación ; profundización de la industrialización ; y adecuación de infraestructura portuaria y aeroportuaria.	763	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.3.1
777	4.1.4.1 Garantizar la participación activa en los Consejos de UNASUR, para alcanzar el impulso de políticas y acciones que beneficien a los pueblos de Nuestra América, promoviendo la integración sociocultural, económica, energética y de infraestructura suramericana en el marco del fortalecimiento de la soberanía e independencia de los pueblos.	764	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.4.1
778	4.1.5.1 Fortalecer el papel de la Celac como espacio común para la integración política, económica, social y cultural de la región.	765	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.5.1
779	4.1.6.1 Profundizar la identidad política con los gobiernos y pueblos hermanos de los países miembros del ALBA y del Mercosur, para seguir impulsando políticas de justicia y solidaridad en Nuestra América.	766	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.6.1
780	4.1.6.2 Intensificar los proyectos grannacionales de la unión económica con los países del ALBA y de complementación productiva con los países del Mercosur.	766	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.6.2
781	4.1.6.3 Profundizar la estrategia de diálogo político al más alto nivel y de encadenamientos productivos con la hermana Republica de Colombia, dando cumplimiento al mandato de unión de El Libertador Simón Bolívar.	766	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.6.3
782	4.1.6.4 Formar y destacar a los cuadros que impulsarán los acuerdos bilaterales de cooperación y los espacios estratégicos de integración y unión regional.	766	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.6.4
783	4.1.7.1 Fortalecer el Banco del Sur como una institución para la integración financiera regional.	767	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.7.1
784	4.1.7.2 Generar una política permanente de financiamiento solidario para el impulso de encadenamientos económicos productivos de Nuestra América, a fin de de alcanzar la independencia económica, productiva y alimentaria regional.	767	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.7.2
785	4.1.8.1 Consolidar a Venezuela como proveedor de cooperación solidaria, sin pretensiones hegemónicas y con apego al principio de autodeterminación de los pueblos.	768	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.8.1
786	4.1.8.2 Orientar la cooperación con los países aliados de la región, como motor de impulso del modelo socio-productivo socialista.	768	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.8.2
787	4.1.8.3 Garantizar la transferencia científico-tecnológica en la cooperación, a fin de alcanzar la independencia económica productiva.	768	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.8.3
788	4.1.9.1 Fortalecer Telesur, garantizando una mayor presencia regional y mundial.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.1
789	4.1.9.2 Expandir el alcance de la Radio del Sur como herramienta comunicacional para la visibilización de los procesos políticos de la región.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.2
790	4.1.9.3 Fomentar las redes de cadenas informativas alternativas y comunitarias en la región, así como las redes sociales.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.3
791	4.1.9.4 Difundir de forma permanente información veraz producida por los países del ALBA y países aliados del Sur.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.4
792	4.1.9.5 Garantizar la producción permanente de contenidos, para difundir a través de medios de comunicación regionales los avances económicos, sociales, políticos y culturales de la Revolución Bolivariana.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.5
793	4.1.9.6. Desarrollar capacidades de producción de contenidos audiovisuales en formato digital desde y para la puesta en marcha de la Televisión Digital Abierta (TDA) a nivel nacional y para el intercambio regional.	769	0	1	2016-06-06 00:38:24.531095	\N	2016-06-06 00:38:24.531095	t	Objetivo General 4.1.9.6
794	4.2.1 Consolidar la visión de la heterogeneidad y diversidad étnica de Venezuela y Nuestra América, bajo el respeto e inclusión participativa y protagónica de las minorías y pueblos originarios.	758	3	1	2016-06-06 00:40:25.024458	\N	2016-06-06 00:40:25.024458	t	Objetivo Estrategico 4.2.1
795	4.2.2 Crear y consolidar la institucionalidad nacional nuestroamericana en las organizaciones de cooperación e integración.	758	2	1	2016-06-06 00:40:25.024458	\N	2016-06-06 00:40:25.024458	t	Objetivo Estrategico 4.2.2
796	4.2.1.1 Orientar desde el más alto nivel de las organizaciones nacionales y regionales, la generación y divulgación de contenidos educativos sobre la identidad nacional y la diversidad de los pueblos.	794	0	1	2016-06-06 00:44:20.372022	\N	2016-06-06 00:44:20.372022	t	Objetivo General 4.2.1.1
797	4.2.1.2 Aumentar la presencia de la temática sobre la identidad nacional y la diversidad de los pueblos en los contenidos curriculares, programación audiovisual y eventos nacionales e internacionales.	794	0	1	2016-06-06 00:44:20.372022	\N	2016-06-06 00:44:20.372022	t	Objetivo General 4.2.1.2
798	4.2.1.3 Defender la presencia de las minorías étnicas y los pueblos originarios en las instancias de toma de decisiones nuestroamericanas.	794	0	1	2016-06-06 00:44:20.372022	\N	2016-06-06 00:44:20.372022	t	Objetivo General 4.2.1.3
799	4.2.2.1 Fomentar en el ámbito nuestroamericano, convenios de integración cultural, educativa, social, científico-tecnológica, entre otros.	795	0	1	2016-06-06 00:44:20.372022	\N	2016-06-06 00:44:20.372022	t	Objetivo General 4.2.2.1
800	4.2.2.2 Adelantar iniciativas regionales y subregionales, como cartas sociales y culturales, declaraciones, pactos y documentos gubernamentales, que surgen de la participación popular son asumidos en la nueva institucionalidad nuestroamericana.	795	0	1	2016-06-06 00:44:20.372022	\N	2016-06-06 00:44:20.372022	t	Objetivo General 4.2.2.2
802	4.3.2 Conformar un nuevo orden comunicacional del Sur.	759	2	1	2016-06-06 00:46:41.563884	\N	2016-06-06 00:46:41.563884	t	Objetivo Estrategico 4.3.2
804	4.3.4 Continuar impulsando la transformación del sistema de Derechos Humanos sobre la base del respeto, su democratización, la igualdad soberana de los Estados y el principio de la no injerencia.	759	1	1	2016-06-06 00:46:41.563884	\N	2016-06-06 00:46:41.563884	t	Objetivo Estrategico 4.3.4
971	CUADRO DE REPORTES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
972	GRÁFICAS TRIMESTRALES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
805	4.3.1.1 Establecer una alianza con el grupo de países BRICS como núcleo que agrupa a los poderes emergentes fundamentales en la consolidación del mundo pluripolar.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.1
806	4.3.1.2 Impulsar el acercamiento y la coordinación entre los nuevos mecanismos de unión latinoamericana y caribeña (ALBA, Unasur, Celac) y el grupo de países BRICS, con el fin de dar mayor contundencia a la voz de los pueblos del Sur en la agenda global.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.2
807	4.3.1.3 Elevar a un nivel superior las alianzas estratégicas con la República Popular China, la Federación de Rusia, la República Federativa del Brasil, la República de Belarús y la República Islámica de Irán con el fin de seguir consolidando el poder nacional.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.3
808	4.3.1.4 Establecer alianzas estratégicas con la República de la India y la República de Sudáfrica.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.4
809	4.3.1.5 Profundizar las relaciones de cooperación política y económica con todos los países de Nuestra América, y con aquellos países de Africa, Asia, Europa y Oceanía cuyos gobiernos estén dispuestos a trabajar con base en el respeto y la cooperación mutua.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.5
810	4.3.1.6 Intensificar el acercamiento con los mecanismos de integración económica y política del Asia y del Africa, tales como ANSA/ASEAN y CEDEAO/ECOWAS, participando en calidad de observadores y promoviendo los contactos con los mecanismos de unión e integración latinoamericana y caribeña.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.6
811	4.3.1.7 Impulsar el liderazgo en el seno del Movimiento de Países No Alineados (MNOAL), a propósito de la celebración de la XVII Cumbre de Jefes de Estado y de Gobierno en Venezuela.	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.7
812	4.3.1.8 Impulsar foros de unión interregionales Sur-Sur, como el América del Sur-Africa (ASA) y el América del Sur-Países Arabes (ASPA).	801	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.1.8
813	4.3.2.1 Fortalecer las cadenas multiestatales y redes comunitarias de televisión y radio, junto con sus respectivas plataformas electrónicas, expandiendo su alcance, su oferta en diferentes idiomas y la variedad y calidad de sus contenidos, con el fin de proyectar la verdad de los pueblos y romper el bloqueo informativo y la censura impuestas por las corporaciones transnacionales de la comunicación.	802	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.2.1
814	4.3.2.2 Establecer alianzas con las cadenas de comunicación e información de los polos emergentes del mundo, para asegurar el conocimiento mutuo y la información veraz sobre nuestras realidades, sin el filtro deformador de las grandes empresas de comunicación de las potencias imperialistas.	802	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.2.2
815	4.3.3.1 Promover la participación de las redes globales de movimientos sociales en los grandes foros y cumbres internacionales.	803	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.3.1
816	4.3.3.2 Acompañar la organización y realización de foros internacionales de movimientos sociales y organizaciones populares, con el fin de recoger sus reivindicaciones y propuestas para incorporarlas en la agenda política global.	803	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.3.2
817	4.3.4.1 Mantener política activa y liderazgo, conjuntamente con los países progresistas de la región, en el llamado a la urgente y necesaria reforma del Sistema Interamericano de Derechos Humanos, por ser bastión altamente politizado del imperialismo estadounidense.	804	0	1	2016-06-06 00:53:50.494717	\N	2016-06-06 00:53:50.494717	t	Objetivo General 4.3.4.1
818	4.4.1 Deslindar a Venezuela de los mecanismos internacionales de dominación imperial.	760	3	1	2016-06-06 00:56:34.34672	\N	2016-06-06 00:56:34.34672	t	Objetivo Estrategico 4.4.1
819	4.4.2 Reducir el relacionamiento económico y tecnológico con los centros imperiales de dominación a niveles que no comprometan la independencia nacional.	760	6	1	2016-06-06 00:56:34.34672	\N	2016-06-06 00:56:34.34672	t	Objetivo Estrategico 4.4.2
820	4.4.3 Profundizar y ampliar el relacionamiento con los polos emergentes del mundo nuevo.	760	4	1	2016-06-06 00:56:34.34672	\N	2016-06-06 00:56:34.34672	t	Objetivo Estrategico 4.4.3
821	4.4.1.1 Denunciar los tratados multilaterales, así como también los tratados y acuerdos bilaterales que limiten la soberanía nacional frente a los intereses de las potencias neocoloniales, tales como los tratados de promoción y protección de inversiones.	818	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.1.1
822	4.4.1.2 Establecer las alianzas necesarias para neutralizar las acciones de las potencias neocoloniales en organismos internacionales.	818	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.1.2
823	4.4.1.3 Llevar a niveles no vitales la participación de las instituciones financieras internacionales en los proyectos de desarrollo nacional.	818	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.1.3
824	4.4.2.1 Llevar a niveles no vitales el intercambio comercial y el relacionamiento con los circuitos financieros dominados por las potencias neocoloniales.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.1
825	4.4.2.2 Reducir la participación de las potencias neocoloniales en el financiamiento de proyectos estratégicos para el desarrollo nacional.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.2
826	4.4.2.3 Llevar a niveles no vitales la conexión de Venezuela con las redes de comunicación e información dominadas por las potencias neocoloniales.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.3
827	4.4.2.4 Eliminar la dependencia de sectores estratégicos para el desarrollo nacional de redes de comunicación e información controladas por las potencias neocoloniales.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.4
828	4.4.2.5 Llevar a niveles no vitales la participación tecnológica de las potencias imperiales en proyectos de desarrollo nacional.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.5
829	4.4.2.6. Eliminar la participación tecnológica de las potencias imperiales en sectores estratégicos para la soberanía nacional.	819	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.2.6
830	4.4.3.1 Incrementar la representación de divisas emergentes en las reservas monetarias internacionales de la República, así como la utilización de este tipo de divisas en el comercio internacional de Venezuela.	820	0	1	2016-06-06 01:02:13.10687	\N	2016-06-06 01:02:13.10687	t	Objetivo General 4.4.3.1
834	5.1 Construir e impulsar el modelo económico productivo eco-socialista, basado en una relación armónica entre el hombre y la naturaleza, que garantice el uso y aprovechamiento racional, óptimo y sostenible de los recursos naturales, respetando los procesos y ciclos de la naturaleza.	91	6	1	2016-06-06 01:05:31.165517	\N	2016-06-06 01:05:31.165517	t	Objetivo Nacional 5.1
838	5.1.1 Impulsar de manera colectiva la construcción y consolidación del socialismo como única opción frente al modelo depredador, discriminador e insostenible capitalista.	834	3	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.1
895	5.3.4 Elaborar estrategias de mantenimiento y difusión de las características culturales y de la memoria histórica del pueblo venezolano.	836	3	1	2016-06-06 01:35:11.604053	\N	2016-06-06 01:35:11.604053	t	Objetivo Estrategico 5.3.4
839	5.1.2 Promover, a nivel nacional e internacional, una ética ecosocialista que impulse la transformación de los patrones insostenibles de producción y de consumo propios del sistema capitalista.	834	4	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.2
840	5.1.3 Generar alternativas socio-productivas y nuevos esquemas de cooperación social, económica y financiera para el apalancamiento del ecososcialismo y el establecimiento de un comercio justo, bajo los principios de complementariedad, cooperación, soberanía y solidaridad.	834	12	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.3
841	5.1.4 Impulsar la protección del ambiente, la eficiencia en la utilización de recursos y el logro de un desarrollo sostenible, implementando la reducción y el reúso en todas las actividades económicas públicas y privadas.	834	3	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.4
842	5.1.5 Mejorar sustancialmente las condiciones socioambientales de las ciudades.	834	5	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.5
843	5.1.6 Impulsar la generación de energías limpias, aumentando su participación en la matriz energética nacional y promoviendo la soberanía tecnológica.	834	3	1	2016-06-06 01:08:51.52301	\N	2016-06-06 01:08:51.52301	t	Objetivo Estrategico 5.1.6
844	5.1.1.1 Garantizar la soberanía y participación protagónica del Poder Popular organizado para la toma de decisiones, desde el intercambio de conocimientos, racionalidades y formas de vida, para construir el ecosocialismo.	838	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.1.1
845	5.1.1.2 Desarrollar una política integral de conservación, aprovechamiento sustentable, protección y divulgación científica de la diversidad biológica y de los reservorios de agua del país.	838	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.1.2
846	5.1.1.3 Impulsar y garantizar nuevos procesos de producción y valorización de conocimientos científicos, ancestrales, tradicionales y populares, así como nuevas relaciones entre ellos, con especial atención a las prácticas de los grupos sociales invisibilizados y discriminados por el capitalismo y el neocolonialismo.	838	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.1.3
847	5.1.2.1 Impulsar y desarrollar una visión de derechos de la Madre Tierra, como representación de los derechos de las generaciones presentes y futuras, así como de respeto a las otras formas de vida.	839	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.2.1
848	5.1.2.2 Priorizar los intereses comunes sobre los individuales, desde una perspectiva centrada en el equilibrio con la naturaleza y el respeto de las generaciones presentes y futuras.	839	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.2.2
849	5.1.2.3 Promover la igualdad sustantiva entre géneros, personas, culturas y comunidades.	839	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.2.3
850	5.1.2.4 Fomentar un nuevo esquema de valores, orientado al respeto y preservación de la naturaleza, que transforme la conciencia colectiva, sobre los patrones capitalistas de producción y consumo.	839	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.2.4
851	5.1.3.1 Promover la investigación, la innovación y la producción de insumos tecnológicos de bajo impacto ambiental, así como el rescate de tecnologías ancestrales para la producción y procesamiento agrícola y pecuario, entre otros, aumentando los índices de eficacia y productividad.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.1
852	5.1.3.2 Promover la generación y apropiación social del conocimiento, tecnología e innovación que permitan la conservación y el aprovechamiento sustentable, justo y equitativo de la diversidad biológica, garantizando la soberanía del Estado sobre sus recursos naturales.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.2
853	5.1.3.3 Crear sistemas urbanos ecológicos, con diseños arquitectónicos equilibrados con los ecosistemas naturales que reduzcan los niveles de contaminación ambiental.	840	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.3.3
836	5.3 Defender y proteger el patrimonio histórico y cultural venezolano nuestroamericano.	91	4	1	2016-06-06 01:05:31.165517	\N	2016-06-06 01:05:31.165517	t	Objetivo Nacional 5.3
835	5.2 Proteger y defender la soberanía permanente del Estado sobre los recursos naturales para el beneficio supremo de nuestro Pueblo, que será su principal garante.	91	4	1	2016-06-06 01:05:31.165517	\N	2016-06-06 01:05:31.165517	t	Objetivo Nacional 5.2
837	5.4 Contribuir a la conformación de un gran movimiento mundial para contener las causas y reparar los efectos de cambio climático que ocurren como consecuencia del modelo capitalista depredador.	91	3	1	2016-06-06 01:05:31.165517	\N	2016-06-06 01:05:31.165517	t	Objetivo Nacional 5.4
863	5.1.4.1 Promover el uso sustentable y sostenible de los recursos naturales en los procesos de producción, circulación y consumo de los bienes, productos y servicios, así como la disminución de desechos, fomentando campañas permanentes de concienciación.	841	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.4.1
864	5.1.4.2 Fomentar el reúso de los residuos para su utilización como materias primas o bienes finales ; a través de la conformación de circuitos que incluyan la clasificación de residuos por parte de toda la población, estableciendo centros de acopio y unidades productivas transformadoras.	841	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.4.2
865	5.1.4.3 Desarrollar normativas legales que promuevan la implementación del reúso en el país.	841	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.4.3
866	5.1.5.1 Promover ciudades energéticamente eficientes, mediante el uso de tecnologías ahorradoras de energía, así como basadas en el uso de energías limpias (eólicas, solares, gas, entre otras).	842	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.5.1
867	5.1.5.2 Desarrollar sistemas de transporte público eficientes en el uso de recursos y de bajo impacto ambiental.	842	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.5.2
868	5.1.5.3 Aumentar la densidad de áreas verdes por habitante, mediante la construcción de parques y espacios de socialización naturales.	842	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.5.3
869	5.1.5.4 Promover sistemas constructivos no contaminantes y sistemas de viviendas ecoeficientes.	842	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.5.4
870	5.1.5.5 Establecer a la chatarra ferrosa y no ferrosa como un insumo de interés nacional para el proceso productivo, a efecto de atender la estructura de costos de los productos y el cuidado del ambiente así como eficiencia energética.	842	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.5.5
973	DOCUMENTO MENSAJE PRESIDENCIAL	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
872	5.1.6.2 Aumentar la generación de energía solar mediante la instalación de fábricas de paneles solares, que atiendan prioritariamente la demanda energética de las poblaciones aisladas.	843	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.6.2
873	5.1.6.3 Realizar estudios para el desarrollo de fuentes energéticas marinas específicamente la olamotriz y la mareomotriz ; con el fin de aprovechar la potencialidad de nuestras extensas costas.	843	0	1	2016-06-06 01:21:49.919578	\N	2016-06-06 01:21:49.919578	t	Objetivo General 5.1.6.3
874	5.2.1 Promover acciones en el ámbito nacional e internacional para la protección, conservación y gestión sustentable de áreas estratégicas, tales como fuentes y reservorios de agua dulce (superficial y subterránea), cuencas hidrográficas, diversidad biológica, mares, océanos y bosques.	835	7	1	2016-06-06 01:24:05.228835	\N	2016-06-06 01:24:05.228835	t	Objetivo Estrategico 5.2.1
875	5.2.2 Desmontar y luchar contra los esquemas internacionales que promueven la mercantilización de la naturaleza, de los servicios ambientales y de los ecosistemas.	835	3	1	2016-06-06 01:24:05.228835	\N	2016-06-06 01:24:05.228835	t	Objetivo Estrategico 5.2.2
876	5.2.3 Promover la cooperación, a nivel regional, para el manejo integrado de los recursos naturales transfronterizos.	835	2	1	2016-06-06 01:24:05.228835	\N	2016-06-06 01:24:05.228835	t	Objetivo Estrategico 5.2.3
877	5.2.4 Luchar contra la securitización de los problemas ambientales mundiales, para evitar la incorporación de los temas ambientales y humanos como temas de "Seguridad internacional" por parte de las potencias hegemónicas.	835	2	1	2016-06-06 01:24:05.228835	\N	2016-06-06 01:24:05.228835	t	Objetivo Estrategico 5.2.4
878	5.2.1.1 Mantener el liderazgo en las negociaciones internacionales multilaterales y regionales, relacionadas con los respectivos marcos jurídicos sectoriales ambientales.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.1
879	5.2.1.2 Promover la conservación y el uso sustentable de la diversidad biológica, en un marco regional, continental y mundial orientado a la integración, soberanía y el vivir bien.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.2
880	5.2.1.3 Profundizar, articuladamente entre instancias del Poder Público y el Poder Popular, la protección integral del agua como un deber, haciendo uso responsable de la misma e impulsando espacios nacionales e internacionales de discusión sobre su uso y democratización.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.3
881	5.2.1.4 Mantener la independencia en el manejo del sistema de obtención, purificación, administración y suministro de agua potable.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.4
882	5.2.1.5 Proteger las cuencas hidrográficas del país y todos los recursos naturales presentes en ellas, promoviendo su gestión integral, haciendo especial énfasis en las situadas al sur del Orinoco.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.5
883	5.2.1.6 Continuar impulsando el reconocimiento del acceso al agua potable como un derecho humano en todos los ámbitos nacionales e internacionales.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.6
884	5.2.1.7 Garantizar el control soberano sobre el conocimiento, extracción, distribución, comercialización y usos de los minerales estratégicos, de manera sostenible, en función de los más altos intereses nacionales.	874	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.1.7
885	5.2.2.1 Activar alianzas estratégicas para la lucha contra la mercantilización de la naturaleza en todos los ámbitos nacionales e internacionales.	875	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.2.1
886	5.2.2.2 Impulsar el desarrollo de una visión desde el Sur que permita fortalecer la defensa de los intereses regionales en materia ambiental.	875	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.2.2
912	5.4.1.1 Desmontar los esquemas de mercados internacionales de carbono que legitiman la compra de derechos de contaminación y la impune destrucción del planeta.	909	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.1.1
913	5.4.1.2 Promover e impulsar el fortalecimiento del régimen jurídico climático vigente, con énfasis en las responsabilidades históricas de los países desarrollados.	909	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.1.2
914	5.4.1.3 Impulsar y apoyar acciones que promuevan la justicia internacional con relación al incumplimiento de los países desarrollados de sus obligaciones en el marco del Protocolo de Kyoto.	909	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.1.3
915	5.4.1.4 Iniciar un proceso de transformación de las disposiciones legales nacionales para garantizar la administración y la protección del patrimonio natural, en la construcción del ecosocialismo.	909	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.1.4
887	5.2.2.3 Impulsar en los organismos de integración suramericana ALBA, Celac, Unasur, Mercorsur, Petrocaribe, así como en los diversos espacios internacionales a los que asiste Venezuela, el concepto de "bajo impacto ambiental" de forma transversal en todas las acciones emprendidas.	875	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.2.3
888	5.2.3.1 Reimpulsar la cooperación con los países fronterizos en temas de gestión ambiental y zonas ecológicas de interés común conforme a los principios del derecho internacional, respetando la soberanía nacional.	876	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.3.1
889	5.2.3.2 Defender los derechos territoriales y la soberanía del Estado venezolano en las negociaciones relacionadas con la administración de los espacios marinos, submarinos y oceánicos, así como de la diversidad biológica presente en esos espacios.	876	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.3.2
890	5.2.4.1 Mantener vigilancia del desarrollo de la agenda del Consejo de Seguridad de las Naciones Unidas para evitar la injerencia en los temas ambientales y humanos, y su tratamiento como temas de seguridad ciudadana internacional, lo cual atenta contra la soberanía de los pueblos.	877	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.4.1
891	5.2.4.2 Fortalecer los debates sustantivos en temas económicos, sociales y ambientales en todos los ámbitos internacionales, regionales y multilaterales, para que las decisiones se tomen de manera inclusiva y transparente, sin orientaciones de corte neo-colonial por parte de los países desarrollados, promoviendo la incorporación del Poder Popular y en particular los movimientos sociales en estos espacios.	877	0	1	2016-06-06 01:32:13.095237	\N	2016-06-06 01:32:13.095237	t	Objetivo General 5.2.4.2
974	DOCUMENTO MEMORIA Y CUENTA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
975	INSTRUCTIVO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
955	3.13 Acompañar el proceso de humanización penitenciaria de las Privadas de Libertad.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.13
892	5.3.1 Contrarrestar la producción y valorización de elementos culturales y relatos históricos generados desde la óptica neocolonial dominante, que circulan a través de los medios de comunicación e instituciones educativas y culturales, entre otras.	836	2	1	2016-06-06 01:35:11.604053	\N	2016-06-06 01:35:11.604053	t	Objetivo Estrategico 5.3.1
893	5.3.2 Fortalecer y visibilizar los espacios de expresión y fomentar mecanismos de registro e interpretación de las culturas populares y de la memoria histórica venezolana y nuestroamericana.	836	5	1	2016-06-06 01:35:11.604053	\N	2016-06-06 01:35:11.604053	t	Objetivo Estrategico 5.3.2
894	5.3.3 Promover una cultura ecosocialista, que revalorice el patrimonio histórico cultural venezolano y nuestroamericano.	836	3	1	2016-06-06 01:35:11.604053	\N	2016-06-06 01:35:11.604053	t	Objetivo Estrategico 5.3.3
1030	REPORTE	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1031	INSTRUMENTOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
896	5.3.1.1 Involucrar a las instituciones públicas y al Poder Popular en la producción de críticas contundentes a las formas culturales y a las reconstrucciones históricas dominantes.	892	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.1.1
897	5.3.1.2 Promover la producción de contenido educativo, tales como textos escolares, para generar consciencia histórica y formar críticamente las nuevas generaciones.	892	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.1.2
898	5.3.2.1 Fortalecer los procesos que visibilicen la identidad histórico-comunitaria, identificando los espacios de expresión y formas populares de reproducción de la memoria histórica, y fomentando la expresión de las diversas manifestaciones culturales tradicionales.	893	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.2.1
899	5.3.2.2 Promover la organización del Poder Popular para el registro e interpretación de la memoria histórica y la difusión y expresión de las culturas populares.	893	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.2.2
900	5.3.2.3 Garantizar la protección del patrimonio cultural popular y de la memoria histórica, a través de la formación integral permanente y continua de los promotores culturales del Poder Popular.	893	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.2.3
901	5.3.2.4 Involucrar a los museos y otras instituciones de interés histórico y cultural, en el plan de conservación y valorización del Patrimonio cultural e histórico popular.	893	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.2.4
902	5.3.2.5 Impulsar la creación de espacios históricos culturales comunitarios en toda la geografía nacional.	893	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.2.5
903	5.3.3.1 Impulsar debates dentro de las organizaciones del Poder Popular sobre la vivencia cultural y las identidades, para el análisis de la situación actual y los cambios que se necesitan en la construcción del ecosocialismo.	894	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.3.1
904	5.3.3.2 Incorporar a las organizaciones populares en el diseño de las políticas culturales, impulsando iniciativas como los comités de cultura de los consejos comunales entre otras.	894	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.3.2
905	5.3.3.3 Desarrollar estrategias de liberación y emancipación cultural, poniendo especial énfasis en grupos sociales especialmente vulnerables, tales como los grupos sexodiversos, mujeres, estudiantes, niños y niñas, afrodescendientes, entre otros, con la finalidad de garantizar el respeto de sus derechos e identidades.	894	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.3.3
906	5.3.4.1 Producir y difundir materiales sobre la historia de los grupos históricamente invisibilizados y la memoria histórica y cultural de Nuestra América, especialmente en las bibliotecas públicas y escolares, así como en los medios masivos de comunicación.	895	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.4.1
907	5.3.4.2 Ejecutar un plan nacional e internacional de difusión de la cultura tradicional y de la memoria histórica y contemporánea.	895	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.4.2
908	5.3.4.3 Fomentar y garantizar la producción independiente comunitaria de las artes.	895	0	1	2016-06-06 01:41:55.314617	\N	2016-06-06 01:41:55.314617	t	Objetivo General 5.3.4.3
909	5.4.1 Continuar la lucha por la preservación, el respeto y el fortalecimiento del régimen climático conformado por la Convención Marco de Naciones Unidas para el Cambio Climático y su Protocolo de Kyoto.	837	4	1	2016-06-06 01:44:30.027577	\N	2016-06-06 01:44:30.027577	t	Objetivo Estrategico 5.4.1
910	5.4.2 Diseñar un plan de mitigación que abarque los sectores productivos emisores de gases de efecto invernadero, como una contribución voluntaria nacional a los esfuerzos para salvar el planeta.	837	3	1	2016-06-06 01:44:30.027577	\N	2016-06-06 01:44:30.027577	t	Objetivo Estrategico 5.4.2
911	5.4.3 Diseñar un plan nacional de adaptación que permita al país prepararse para los escenarios e impactos climáticos que se producirán debido a la irresponsabilidad de los países industrializados, contaminadores del mundo.	837	3	1	2016-06-06 01:44:30.027577	\N	2016-06-06 01:44:30.027577	t	Objetivo Estrategico 5.4.3
916	5.4.2.1 Promover la adecuación tecnológica para una transformación del sector productivo, de manera sustentable, con especial énfasis en el sector energético, agrícola y pecuario, incorporando el principio de prevención y manejo de los desechos sólidos y peligrosos.	910	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.2.1
917	5.4.2.2 Impulsar a nivel regional e internacional compromisos por parte de todos los países y medidas nacionales de mitigación que contribuyan a corregir el deterioro ambiental que genera el cambio climático global.	910	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.2.2
918	5.4.2.3 Posicionar a Venezuela como referente mundial en la lucha por el cumplimiento de los acuerdos establecidos y de su impulso por la construcción de un nuevo sistema ecosocialista.	910	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.2.3
919	5.4.3.1 Coordinar acciones con todos los entes nacionales encargados de la planificación territorial y la gestión de desastres, con una visión prospectiva del incremento de temperatura previsto para los próximos 20 años, en función de las promesas de mitigación que logren consolidarse en el marco de la Organización de las Naciones Unidas.	911	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.3.1
920	5.4.3.2 Calcular los costos derivados de las pérdidas y daños resultantes de situaciones extremas climáticas, incluyendo seguros y reaseguros para sectores sensibles específicos (como la agricultura), las cuales deberán sumarse a la deuda ecológica de los países industrializados.	911	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.3.2
921	5.4.3.3 Fomentar el desarrollo de planes municipales y locales de adaptación para escenarios de manejo de riesgo que involucren directamente la corresponsabilidad entre el Estado y el Poder Popular.	911	0	1	2016-06-06 01:50:11.929375	\N	2016-06-06 01:50:11.929375	t	Objetivo General 5.4.3.3
303	2.1.2 Desarrollar un sistema de fijación de precios justos para los bienes y servicios, combatiendo las prácticas de ataque a la moneda, acaparamiento, especulación, usura y otros falsos mecanismos de fijación de precios, mediante el fortalecimiento de las leyes e instituciones responsables y la participación protagónica del Poder Popular, para el desarrollo de un nuevo modelo productivo diversificado, sustentado en la cultura del trabajo.	297	0	1	2016-05-23 00:55:33.624623	\N	2016-05-23 00:55:33.624623	t	Objetivo Estrategico 2.1.2
309	2.1.1.2 Insertar nuevos esquemas productivos que irradien en su entorno relaciones de producción e intercambio complementario y solidario, al tiempo que constituyan tejidos productivos de sostén de un nuevo metabolismo socialista . Estos injertos productivos tendrán políticas de asociación entre sí bajo formas de conglomerados para multiplicar su escala.	302	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.1.2
932	1.5 Incorporar el enfoque de género, feminista y de derechos humanos en la formulación de normas en la Asamblea Nacional y los Consejos Legislativos Regionales y Municipales.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.5
1032	INSPECCIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
324	2.1.4.6 Contribuir con el bienestar socioeconómico del entorno donde se asienten las unidades productivas, aplicando la estrategia de punto y círculo, dando cabida a la participación popular en procesos sociales y económicos ; así como de contraloría social. Las unidades de mayor escala propiciarán ramificaciones de insumos a escala comunal, para cooperar en la satisfacción de las necesidades de nuestras comunidades.	305	0	1	2016-05-23 01:11:24.383584	\N	2016-05-23 01:11:24.383584	t	Objetivo General 2.1.4.6
353	2.2.2.2 Crear el Servicio Nacional de Información de Misiones y Grandes Misiones, que establezca un registro único de los beneficiarios de las Misiones, para la planificación, seguimiento y evaluación de la efectividad de los programas sociales en el cumplimiento de sus cometidos, mediante : a) la identificación y situación de la familia ; b) la vinculación a las Misiones y otros programas sociales ; c) el catastro de servicios e instalaciones sociales; d) el sistema de monitoreo de la superación de la pobreza.	334	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.2.2
368	2.2.5.2 Garantizar la adjudicación de viviendas dignas a las comunidades indígenas en situación de vulnerabilidad, respetando su cultura y tradiciones.	337	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.5.2
375	2.2.6.5 Fortalecer el deporte de alto rendimiento, con apoyo integral al atleta y héroes del deporte, desarrollo de la medicina y las ciencias aplicadas al deporte de alto rendimiento, desarrollo de centros de alto rendimiento y de la escuela nacional de talentos deportivos.	338	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.6.5
386	2.2.9.2 Reducir la pobreza general a menos del 15% de los hogares y erradicar la pobreza extrema, potenciando el desarrollo y expansión del alcance territorial de las misiones, grandes misiones y micromisiones que garanticen al pueblo las condiciones para el goce y ejercicio de todos los derechos económicos, sociales y culturales.	341	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.9.2
387	2.2.9.3 Reducir las condiciones de vulnerabilidad social a través del desarrollo y consolidación de las Misiones, Grandes Misiones, tales como la Gran Misión en Amor Mayor, Misión Madres del Barrio, Misión Hijos e Hijas de Venezuela, Misión Alimentación, de Venezuela, Gran Misión Saber y Trabajo, Gran Misión Vivienda Venezuela, Jóvenes de la Patria, AgroVenezuela, Barrio Adentro 1 y II ; así como las micromisiones y otros programas sociales, que permitan la máxima protección a familias venezolanas conformadas por personas adultas mayores, mujeres embarazadas, niños, niñas y adolescentes o con discapacidad.	341	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.9.3
408	2.2.12.2 Extender la cobertura de la matrícula escolar a toda la población, con énfasis en las poblaciones excluidas, de la siguiente manera : a) Etapa de maternal : incrementar la matrícula de 13% hasta el 40% ; b) Etapa de preescolar: universalizar la matrícula al 100% de cobertura ; c) Etapa primaria : consolidar la universalización, aumentando al 100% ; d) Educación media general : incrementar la matrícula al 100% para lograr que toda la población alcance un nivel de instrucción promedio no menor a educación media general o media técnica ; e) Incrementar la matrícula de la educación técnica al 40%.	344	0	1	2016-05-23 01:59:15.333656	\N	2016-05-23 01:59:15.333656	t	Objetivo General 2.2.12.2
451	2.3.4.6 Incorporar al Poder Popular en la recuperación y creación de espacios públicos para el desarrollo de actividades culturales, recreativas y preventivas, tales como las canchas de paz y otras de prevención y recreación en las comunidades.	426	0	1	2016-05-23 02:20:11.257095	\N	2016-05-23 02:20:11.257095	t	Objetivo General 2.3.4.6
460	2.4.1.1 Preservar los valores tradicionales del Pueblo venezolano, de honestidad, responsabilidad, vocación de trabajo, amor al prójimo, solidaridad, voluntad de superación, y de la lucha por la emancipación ; mediante su promoción permanente y a través de todos los medios disponibles, como defensa contra los antivalores del modelo capitalista, que promueve la explotación, el consumismo, el individualismo y la corrupción, y que son el origen de la violencia criminal que agobia a la sociedad venezolana.	458	0	1	2016-05-23 02:27:45.84229	\N	2016-05-23 02:27:45.84229	t	Objetivo General 2.4.1.1
485	2.5.3.5 Impulsar mecanismos de control y sanción ; políticos, administrativos y penales, según sea el caso, para los servidores públicos que incurran en hechos de corrupción u otras conductas y hechos sancionados por las leyes.	469	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.3.5
491	2.5.4.5 Desarrollar una cultura de responsabilidad en la administración de justicia, impulsando las políticas de formación y capacitación de jueces, juezas y fiscales públicos, en función del derecho a vivir bien.	470	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.4.5
494	2.5.5.1 Expandir y consolidar la prevención integral y convivencia comunal, en corresponsabilidad con el Estado, a través del diseño, ejecución y monitoreo del plan de prevención integral en el ámbito nacional, con especial atención a los jóvenes desocupados de los sectores populares ; de la aplicación de un plan especial de vigilancia de patrullaje ; de la activación del Servicio de Policía Comunal en acción conjunta con las organizaciones comunales de base ; de la ejecución del plan de trabajo para lograr el control de armas, municiones y desarme ; así como la intensificación del programa de fortalecimiento de la investigación, aprehensión y procesamiento de personas responsables de delitos.	471	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.5.1
511	2.5.6.2 Reforzar el funcionamiento de los órganos encargados de la planificación y coordinación de las políticas públicas, como garantí a de la asignación de los recursos públicos orientados a la consecución, coordinación y armonización de planes y proyectos, a través de la transformación del país, el desarrollo territorial equilibrado y la justa distribución de la riqueza.	472	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.6.2
948	3.6 Avanzar hacia la erradicación de la violencia contra las mujeres en todas sus expresiones.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.6
523	2.5.8.1 Garantizar el desarrollo del Gobierno Electrónico, mediante la normativa legal e infraestructura necesaria, como sistema para facilitar la participación ciudadana y la gestión pública eficiente y transparente.	474	0	1	2016-05-23 02:59:23.501948	\N	2016-05-23 02:59:23.501948	t	Objetivo General 2.5.8.1
922	Plan para la Igualdad y Equidad de Género “Mama Rosa”	0	5	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
964	ASESORIA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
965	PLAN OPERATIVO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
966	PLAN OPERATIVO REVISADO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
967	PRESUPUESTO DE UNIDAD Y ENTE REVISADO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
968	ANTEPROYECTO Y PROYECTO POAI	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
930	1.3 Impulsar la formación y capacitación política-ideológica de las mujeres para potenciar su liderazgo político, social y comunal.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.3
931	1.4 Impulsar en el Sistema Nacional de Planificación Pública y Popular la incorporación de planes y proyectos con enfoque de género, feminista y de derechos humanos.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.4
933	1.6 Contribuir en la superación de las desigualdades de las mujeres en la nueva geopolitica internacional.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.6
935	2.2 Impulsar la conformación de las nuevas organizaciones productivas de mujeres, como base fundamental del modelo económico socialista feminista.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.2
936	2.3 Consolidar organizaciones socioproductivas lideradas por mujeres.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.3
937	2.4 Coordinar políticas para servicios financieros adecuados y eficientes.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.4
938	2.5 Formar para el trabajo productivo con enfoque de género, feminista y de derechos humanos.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.5
939	2.6 Vigilar el cumplimiento de las leyes que protegen los derechos económicos y laborales de las mujeres.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.6
940	2.7 Coordinar políticas formativas para aumentar la conciencia con enfoque de género, feminista y de Derechos Humanos y en defensa de los derechos según la Ley Orgánica del Trabajo de las Trabajadoras y Trabajadores (LOTTT) y la Ley Orgánica del Sistema Económico Comunal (LOSEC).	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.7
941	2.8 Desarrollar estrategias para la garantía de los derechos económicos de las mujeres que realizan el trabajo del hogar, como parte del reconocimiento del trabajo no remunerado como una actividad que produce valor	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.8
942	2.9 Promoción de las responsabilidades compartidas en el hogar.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.9
943	3.1 Mejorar la cobertura de atención de la población, en las distintas etapas del ciclo de vida, en toda la Red del Sistema Público Nacional de Salud con enfoque de género y de derechos humanos.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.1
944	3.2 Sensibilizar al personal médico asistencial para la atención humanizada, con calidad y calidez en toda la red del SPNS.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.2
945	3.3 Concienciar a las mujeres y a los hombres sobre sus derechos a una sexualidad feliz y responsable, en las distintas etapas del ciclo de vida.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.3
946	3.4 Concienciar a las mujeres y a los hombres sobre los derechos reproductivos.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.4
949	3.7 Promover la incorporación de mujeres a las misiones educativas.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.7
956	3.14 Eliminar todo mecanismo de discriminación y exclusión que ha sufrido las personas de sexualidades y expresiones de género diversas con relación a sus derechos laborales, políticos, económicos, culturales y sociales.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.14
960	4.1 Impulsar una política de Estado de comunicación e información con enfoque de género, feminista y de derechos humanos.	1091	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 4.1
959	3.17 Velar por el desarrollo espiritual y material de las mujeres con algún tipo de discapacidad, en el marco del Estado Democrático y Social de Derecho y de Justicia.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.17
957	3.15 Acompañamiento a las políticas dirigidas a las personas en situación de calle.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.15
958	3.16 Acompañamiento a la niña como sujeta de derecho.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.16
961	4.2 Profundizar el enfoque de género, feminista y de derechos humanos en la política cultural. 	1091	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 4.2
962	4.3 Respetar el acervo histórico y cultural de los pueblos originarios y sus formas de organización en la incorporación del enfoque de género, feminista y de derechos humanos.	1091	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 4.3
963	5.1 Concienciar a mujeres y hombres para que contribuyan con la preservación de la Pachamama, respetando los procesos y ciclos de la naturaleza.	1092	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 5.1
924	2 Dimensión Económica.	922	1	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
934	2.1 Garantizar una mayor y mejor incorporación de las mujeres, sin discriminación, para el trabajo remunerado en los sectores productivos del país.	1071	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 2.1
925	3 Dimensión Social.	922	2	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
926	4 Dimensión Cultural.	922	1	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
927	5 Dimensión Ambiental.	922	1	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
989	HERRAMIENTAS COMUNICACIONALES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
990	EVENTOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
991	CONVOCATORIAS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
992	PLAN DE MEDIOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
993	NOTAS DE PRENSA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
994	MICROS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
995	TWITER	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
996	SEGUIDORES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
997	PUBLICACIONES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
998	VIZUALIZACIONES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
999	FOTOGRAFIAS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1000	DISEÑO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1001	SPOTS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1002	AVISOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1003	TRANSMISIONES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1004	PENDON	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1005	VOLANTES	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1006	TRÍPTICOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1007	MATERIAL P.O.P	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1008	ASAMBLEA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1009	APOYO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1010	VISITAS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1011	INFORMAR	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1012	CAMPAÑA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1013	CREDENCIAL	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1014	PLAN DE TRABAJO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1015	MEMORANDO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1016	OFICIOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1017	MEMORANDO/OFICIOS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1018	CUESTIONARIO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1019	ACTA	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1033	COORDINACIÓN	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1034	ENCUENTRO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1035	DOCUMENTO	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1036	JORNADA 	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1037	PARTICIPANTE	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
1038	MESAS TÉCNICAS	35	0	1	2016-06-06 03:42:32.775394	\N	2016-06-06 03:42:32.775394	t	\N
928	1.1 Garantizar la participación política y paritaria en todos los cargos para la toma de decisiones y alta dirección.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.1
929	1.2 Apoyar la articulación de los movimientos, colectivos y organizaciones, sociales y políticas de mujeres, con las instituciones del Estado en la consolidación del Sistema de Gobierno Popular.	1063	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 1.2
947	3.5 Velar por el cumplimiento de la LOTTT, respecto a la salud ocupacional y seguridad social de las mujeres.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.5
950	3.8 Velar por la incorporación y permanencia en el sistema educativo formal de mujeres y hombres.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.8
951	3.9 Fomentar la incorporación del enfoque de género, feminista y de derechos humanos en el Sistema Educativo Nacional.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.9
954	3.12 Velar por el derecho de vivienda y hábitat digno de las mujeres.	1072	0	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	Objetivo Institucional 3.12
923	1 Dimensión Política e Ideológica.	922	2	1	2016-06-06 02:29:19.899997	\N	2016-06-06 02:29:19.899997	t	\N
1064	Impulsar la participación de las mujeres en la construcción y consolidación del nuevo modelo de desarrollo econḿico productivo socialista, basado en la democratización y socialización de los medios de producción.	923	6	1	2016-06-20 09:10:56.93977	\N	2016-06-20 09:10:56.93977	t	Objetivo Estrategico 2
1065	1.1 Garantizar la participación política y paritaria en todos los cargos para la toma de decisiones y alta dirección.	1064	0	1	2016-06-20 09:14:01.427204	\N	2016-06-20 09:14:01.427204	t	Objetivo Institucional 1.1
1067	1.3 Impulsar la formación y capacitación política-ideológica de las mujeres para potenciar su liderazgo político, social y comunal.	1064	0	1	2016-06-20 09:15:30.424149	\N	2016-06-20 09:15:30.424149	t	Objetivo Institucional 1.3
1068	1.4 Impulsar en el Sistema Nacional de Planificación Pública y Popular la incorporación de planes y proyectos con enfoque de género, feminista y de derechos humanos.	1064	0	1	2016-06-20 09:15:51.487206	\N	2016-06-20 09:15:51.487206	t	Objetivo Institucional 1.4
1069	1.5 Incorporar el enfoque de género, feminista y de derechos humanos en la formulación de normas en la Asamblea Nacional y los Consejos Legislativos Regionales y Municipales.	1064	0	1	2016-06-20 09:16:06.856848	\N	2016-06-20 09:16:06.856848	t	Objetivo Institucional 1.5
1070	1.6 Contribuir en la superación de las desigualdades de las mujeres en la nueva geopolitica internacional.	1064	0	1	2016-06-20 09:16:17.571353	\N	2016-06-20 09:16:17.571353	t	Objetivo Institucional 1.6
1071	Profundizar la participación de las mujeres en la construcción y consolidación del nuevo modelo de desarrollo económico productivo socialista, basado en la democratización y socialización de los medios de producción.	924	9	1	2016-06-20 09:17:13.091008	\N	2016-06-20 09:17:13.091008	t	Objetivo Estrategico 1
1072	Velar por la inclusión de todas las mujeres del territorio nacional, en todos los programas sociales: salud, vivienda y hábitat, educación e investigación, alimentación, deporte, seguridad social y servicios penitenciarios, asi como erradicar la violencia de genéro en todas sus expresiones.	925	17	1	2016-06-20 09:18:55.360933	\N	2016-06-20 09:18:55.360933	t	Objetivo Estrategico 1
1073	Lograr la erradicación de la violencia de género en todas sus expresiones.	925	17	1	2016-06-20 09:24:36.617085	\N	2016-06-20 09:24:36.617085	t	Objetivo Estrategico 2
1091	Concienciar la perspectiva de género en todos los sectores a nivel nacional y actores de las organizaciones políticas, movimientos, colectivos sociales y otras expresiones organizativas del Poder Popular.	926	3	1	2016-06-20 09:30:19.983468	\N	2016-06-20 09:30:19.983468	t	Objetivo Estrategico 1
1074	3.1 Mejorar la cobertura de atención de la población, en las distintas etapas del ciclo de vida, en toda la Red del Sistema Público Nacional de Salud con enfoque de género y de derechos humanos.	1073	0	1	2016-06-20 09:24:59.540882	\N	2016-06-20 09:24:59.540882	t	Objetivo Institucional 3.1
1075	3.2 Sensibilizar al personal médico asistencial para la atención humanizada, con calidad y calidez en toda la red del SPNS.	1073	0	1	2016-06-20 09:25:27.910196	\N	2016-06-20 09:25:27.910196	t	Objetivo Institucional 3.2
1076	3.3 Concienciar a las mujeres y a los hombres sobre sus derechos a una sexualidad feliz y responsable, en las distintas etapas del ciclo de vida.	1073	0	1	2016-06-20 09:25:40.094116	\N	2016-06-20 09:25:40.094116	t	Objetivo Institucional 3.3
1077	3.4 Concienciar a las mujeres y a los hombres sobre los derechos reproductivos.	1073	0	1	2016-06-20 09:26:05.174796	\N	2016-06-20 09:26:05.174796	t	Objetivo Institucional 3.4
1078	3.5 Velar por el cumplimiento de la LOTTT, respecto a la salud ocupacional y seguridad social de las mujeres.	1073	0	1	2016-06-20 09:26:22.684644	\N	2016-06-20 09:26:22.684644	t	Objetivo Institucional 3.5
1079	3.6 Avanzar hacia la erradicación de la violencia contra las mujeres en todas sus expresiones.	1073	0	1	2016-06-20 09:26:34.745129	\N	2016-06-20 09:26:34.745129	t	Objetivo Institucional 3.6
1080	3.7 Promover la incorporación de mujeres a las misiones educativas.	1073	0	1	2016-06-20 09:27:08.602056	\N	2016-06-20 09:27:08.602056	t	Objetivo Institucional 3.7
1082	3.9 Fomentar la incorporación del enfoque de género, feminista y de derechos humanos en el Sistema Educativo Nacional.	1073	0	1	2016-06-20 09:27:40.415108	\N	2016-06-20 09:27:40.415108	t	Objetivo Institucional 3.9
1083	3.10 Concienciar a la población de mujeres sobre una alimentación saludable, sana y balanceada en sus distintas fases del ciclo de vida.	1073	0	1	2016-06-20 09:27:51.47032	\N	2016-06-20 09:27:51.47032	t	Objetivo Institucional 3.10
1084	3.11 Fortalecer la participación de las mujeres en las acciones emprendidas en materia de seguridad y soberanía alimentaria.	1073	0	1	2016-06-20 09:28:03.74742	\N	2016-06-20 09:28:03.74742	t	Objetivo Institucional 3.11
1085	3.12 Velar por el derecho de vivienda y hábitat digno de las mujeres.	1073	0	1	2016-06-20 09:28:16.905667	\N	2016-06-20 09:28:16.905667	t	Objetivo Institucional 3.12
1086	3.13 Acompañar el proceso de humanización penitenciaria de las Privadas de Libertad.	1073	0	1	2016-06-20 09:28:26.815368	\N	2016-06-20 09:28:26.815368	t	Objetivo Institucional 3.13
1088	3.15 Acompañamiento a las políticas dirigidas a las personas en situación de calle.	1073	0	1	2016-06-20 09:28:57.81039	\N	2016-06-20 09:28:57.81039	t	Objetivo Institucional 3.15
1089	3.16 Acompañamiento a la niña como sujeta de derecho.	1073	0	1	2016-06-20 09:29:11.455789	\N	2016-06-20 09:29:11.455789	t	Objetivo Institucional 3.16
1090	3.17 Velar por el desarrollo espiritual y material de las mujeres con algún tipo de discapacidad, en el marco del Estado Democrático y Social de Derecho y de Justicia.	1073	0	1	2016-06-20 09:29:18.323259	\N	2016-06-20 09:29:18.323259	t	Objetivo Institucional 3.17
1063	Lograr la participación política protagónica y paritaria, en condiciones de igualdad entre mujeres y hombres (50 y 50), en todos los ámbitos de la vida pública y en los cargos de elección popular.	923	6	1	2016-06-20 09:10:16.423328	\N	2016-06-20 09:10:16.423328	t	Objetivo Estrategico 1
1066	1.2 Apoyar la articulación de los movimientos, colectivos y organizaciones, sociales y políticas de mujeres, con las instituciones del Estado en la consolidación del Sistema de Gobierno Popular.	1064	0	1	2016-06-20 09:14:59.690321	\N	2016-06-20 09:14:59.690321	t	Objetivo Institucional 1.2
1092	Velar por la preservación del ambiente, en todas las esferas donde se desenvuelven las mujeres y los hombres.	927	1	1	2016-06-20 09:31:30.721786	\N	2016-06-20 09:31:30.721786	t	Objetivo Estrategico 1
1081	3.8 Velar por la incorporación y permanencia en el sistema educativo formal de mujeres\ny hombres.	1073	0	1	2016-06-20 09:27:20.446176	\N	2016-06-20 09:27:20.446176	t	Objetivo Institucional 3.8
1087	3.14 Eliminar todo mecanismo de discriminación y exclusión que ha sufrido las personas de sexualidades y expresiones de género diversas con relación a sus derechos laborales, políticos, económicos, culturales y sociales.	1073	0	1	2016-06-20 09:28:37.250947	\N	2016-06-20 09:28:37.250947	t	Objetivo Institucional 3.14
\.


--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 1092, true);


--
-- Data for Name: poa; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY poa (id_poa, nombre, fk_tipo_poa, descripcion, fecha_inicio, fecha_final, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_unidad_medida, cantidad, fk_historico, fk_nacional, fk_estrategico, fk_general, fk_institucional, fk_estrategico_mr) FROM stdin;
53	Proyecto 01 2016	70		2016-01-01 00:00:00	2016-12-31 00:00:00	437	2016-06-26 03:07:00.824316	437	2016-06-26 03:15:12.518918	24	t	1043	15000	88	297	302	309	935	1071
\.


--
-- Name: poa_id_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('poa_id_poa_seq', 53, true);


--
-- Data for Name: rendimiento; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY rendimiento (id_rendimiento, fk_meses, created_by, created_date, modified_by, modified_date, fk_status, es_activo, cantidad_cumplida, cantidad_programada, fk_tipo_entidad, id_entidad) FROM stdin;
1997	63	437	2016-06-26 03:07:44.01898	\N	2016-06-26 03:07:44.01898	27	t	\N	5	73	63
1998	64	437	2016-06-26 03:07:44.027394	\N	2016-06-26 03:07:44.027394	27	t	\N	6	73	63
1999	65	437	2016-06-26 03:07:44.035971	\N	2016-06-26 03:07:44.035971	27	t	\N	0	73	63
2000	66	437	2016-06-26 03:07:44.053024	\N	2016-06-26 03:07:44.053024	27	t	\N	7	73	63
2001	67	437	2016-06-26 03:07:44.069141	\N	2016-06-26 03:07:44.069141	27	t	\N	8	73	63
2002	68	437	2016-06-26 03:07:44.085942	\N	2016-06-26 03:07:44.085942	27	t	\N	9	73	63
2009	63	437	2016-06-26 03:08:13.052328	\N	2016-06-26 03:08:13.052328	27	t	\N	0	74	162
2010	64	437	2016-06-26 03:08:13.063571	\N	2016-06-26 03:08:13.063571	27	t	\N	0	74	162
2011	65	437	2016-06-26 03:08:13.078696	\N	2016-06-26 03:08:13.078696	27	t	\N	0	74	162
2012	66	437	2016-06-26 03:08:13.095834	\N	2016-06-26 03:08:13.095834	27	t	\N	0	74	162
2013	67	437	2016-06-26 03:08:13.111818	\N	2016-06-26 03:08:13.111818	27	t	\N	0	74	162
2014	68	437	2016-06-26 03:08:13.12932	\N	2016-06-26 03:08:13.12932	27	t	\N	0	74	162
2021	63	437	2016-06-26 03:08:30.448659	\N	2016-06-26 03:08:30.448659	27	t	\N	0	74	163
2022	64	437	2016-06-26 03:08:30.464148	\N	2016-06-26 03:08:30.464148	27	t	\N	0	74	163
2023	65	437	2016-06-26 03:08:30.480987	\N	2016-06-26 03:08:30.480987	27	t	\N	0	74	163
2024	66	437	2016-06-26 03:08:30.496045	\N	2016-06-26 03:08:30.496045	27	t	\N	0	74	163
2025	67	437	2016-06-26 03:08:30.513446	\N	2016-06-26 03:08:30.513446	27	t	\N	0	74	163
2026	68	437	2016-06-26 03:08:30.529864	\N	2016-06-26 03:08:30.529864	27	t	\N	0	74	163
2033	63	437	2016-06-26 03:08:49.730825	\N	2016-06-26 03:08:49.730825	27	t	\N	5	74	164
2034	64	437	2016-06-26 03:08:49.747084	\N	2016-06-26 03:08:49.747084	27	t	\N	6	74	164
2035	65	437	2016-06-26 03:08:49.763605	\N	2016-06-26 03:08:49.763605	27	t	\N	0	74	164
2036	66	437	2016-06-26 03:08:49.7803	\N	2016-06-26 03:08:49.7803	27	t	\N	0	74	164
2037	67	437	2016-06-26 03:08:49.797326	\N	2016-06-26 03:08:49.797326	27	t	\N	0	74	164
2038	68	437	2016-06-26 03:08:49.816557	\N	2016-06-26 03:08:49.816557	27	t	\N	0	74	164
2081	63	437	2016-06-26 03:11:15.126838	\N	2016-06-26 03:11:15.126838	27	t	\N	0	74	167
2082	64	437	2016-06-26 03:11:15.143304	\N	2016-06-26 03:11:15.143304	27	t	\N	0	74	167
2083	65	437	2016-06-26 03:11:15.160737	\N	2016-06-26 03:11:15.160737	27	t	\N	0	74	167
2084	66	437	2016-06-26 03:11:15.175636	\N	2016-06-26 03:11:15.175636	27	t	\N	0	74	167
2085	67	437	2016-06-26 03:11:15.187965	\N	2016-06-26 03:11:15.187965	27	t	\N	0	74	167
2086	68	437	2016-06-26 03:11:15.204108	\N	2016-06-26 03:11:15.204108	27	t	\N	0	74	167
2057	63	437	2016-06-26 03:09:53.943176	\N	2016-06-26 03:09:53.943176	27	t	\N	0	74	166
2058	64	437	2016-06-26 03:09:53.957256	\N	2016-06-26 03:09:53.957256	27	t	\N	0	74	166
2059	65	437	2016-06-26 03:09:53.974779	\N	2016-06-26 03:09:53.974779	27	t	\N	0	74	166
2060	66	437	2016-06-26 03:09:53.994185	\N	2016-06-26 03:09:53.994185	27	t	\N	7	74	166
2061	67	437	2016-06-26 03:09:54.01087	\N	2016-06-26 03:09:54.01087	27	t	\N	8	74	166
2062	68	437	2016-06-26 03:09:54.026839	\N	2016-06-26 03:09:54.026839	27	t	\N	9	74	166
2069	63	437	2016-06-26 03:10:44.418515	\N	2016-06-26 03:10:44.418515	27	t	\N	100	73	64
2070	64	437	2016-06-26 03:10:44.432438	\N	2016-06-26 03:10:44.432438	27	t	\N	100	73	64
2071	65	437	2016-06-26 03:10:44.441734	\N	2016-06-26 03:10:44.441734	27	t	\N	100	73	64
2072	66	437	2016-06-26 03:10:44.458205	\N	2016-06-26 03:10:44.458205	27	t	\N	100	73	64
2073	67	437	2016-06-26 03:10:44.468742	\N	2016-06-26 03:10:44.468742	27	t	\N	100	73	64
2074	68	437	2016-06-26 03:10:44.482993	\N	2016-06-26 03:10:44.482993	27	t	\N	100	73	64
2093	63	437	2016-06-26 03:11:25.935579	\N	2016-06-26 03:11:25.935579	27	t	\N	0	74	168
2094	64	437	2016-06-26 03:11:25.951714	\N	2016-06-26 03:11:25.951714	27	t	\N	0	74	168
2095	65	437	2016-06-26 03:11:25.969273	\N	2016-06-26 03:11:25.969273	27	t	\N	0	74	168
2096	66	437	2016-06-26 03:11:25.985502	\N	2016-06-26 03:11:25.985502	27	t	\N	0	74	168
2097	67	437	2016-06-26 03:11:26.00327	\N	2016-06-26 03:11:26.00327	27	t	\N	0	74	168
2098	68	437	2016-06-26 03:11:26.021282	\N	2016-06-26 03:11:26.021282	27	t	\N	0	74	168
1992	58	437	2016-06-26 03:07:43.936052	437	2016-06-26 03:25:29.418722	27	t	2	2	73	63
1993	59	437	2016-06-26 03:07:43.952697	437	2016-06-26 03:25:29.436284	27	t	0	0	73	63
1994	60	437	2016-06-26 03:07:43.968957	437	2016-06-26 03:25:29.456289	27	t	3	3	73	63
1995	61	437	2016-06-26 03:07:43.985737	437	2016-06-26 03:25:29.468854	27	t	4	4	73	63
1996	62	437	2016-06-26 03:07:44.002851	437	2016-06-26 03:25:29.4865	27	t	0	0	73	63
2004	58	437	2016-06-26 03:08:12.976048	437	2016-06-26 03:25:49.696303	27	t	2	2	74	162
2005	59	437	2016-06-26 03:08:12.99179	437	2016-06-26 03:25:49.71218	27	t	0	0	74	162
2006	60	437	2016-06-26 03:08:13.003165	437	2016-06-26 03:25:49.729096	27	t	0	0	74	162
2007	61	437	2016-06-26 03:08:13.018884	437	2016-06-26 03:25:49.746026	27	t	0	0	74	162
2008	62	437	2016-06-26 03:08:13.029314	437	2016-06-26 03:25:49.762201	27	t	0	0	74	162
2015	57	437	2016-06-26 03:08:30.346202	437	2016-06-26 03:26:06.194634	27	t	0	0	74	163
2016	58	437	2016-06-26 03:08:30.367453	437	2016-06-26 03:26:06.221496	27	t	0	0	74	163
2017	59	437	2016-06-26 03:08:30.380482	437	2016-06-26 03:26:06.238312	27	t	0	0	74	163
2018	60	437	2016-06-26 03:08:30.399783	437	2016-06-26 03:26:06.254886	27	t	3	3	74	163
2020	62	437	2016-06-26 03:08:30.429675	437	2016-06-26 03:26:06.287683	27	t	0	0	74	163
2027	57	437	2016-06-26 03:08:49.647999	437	2016-06-26 03:26:18.432058	27	t	0	0	74	164
2028	58	437	2016-06-26 03:08:49.662309	437	2016-06-26 03:26:18.456333	27	t	0	0	74	164
2029	59	437	2016-06-26 03:08:49.677089	437	2016-06-26 03:26:18.473057	27	t	0	0	74	164
2030	60	437	2016-06-26 03:08:49.691176	437	2016-06-26 03:26:18.488848	27	t	0	0	74	164
2031	61	437	2016-06-26 03:08:49.704047	437	2016-06-26 03:26:18.504079	27	t	0	0	74	164
2032	62	437	2016-06-26 03:08:49.71401	437	2016-06-26 03:26:18.521246	27	t	0	0	74	164
2051	57	437	2016-06-26 03:09:53.803824	437	2016-06-26 03:26:29.755632	27	t	0	0	74	166
2052	58	437	2016-06-26 03:09:53.837052	437	2016-06-26 03:26:29.780535	27	t	0	0	74	166
2053	59	437	2016-06-26 03:09:53.875251	437	2016-06-26 03:26:29.796881	27	t	0	0	74	166
2055	61	437	2016-06-26 03:09:53.906973	437	2016-06-26 03:26:29.828973	27	t	0	0	74	166
2056	62	437	2016-06-26 03:09:53.924715	437	2016-06-26 03:26:29.846684	27	t	0	0	74	166
2063	57	437	2016-06-26 03:10:44.316819	437	2016-06-26 03:26:50.336895	27	t	100	100	73	64
2064	58	437	2016-06-26 03:10:44.333428	437	2016-06-26 03:26:50.362737	27	t	200	100	73	64
2065	59	437	2016-06-26 03:10:44.349889	437	2016-06-26 03:26:50.379241	27	t	200	100	73	64
2066	60	437	2016-06-26 03:10:44.367422	437	2016-06-26 03:26:50.396619	27	t	100	100	73	64
2067	61	437	2016-06-26 03:10:44.383337	437	2016-06-26 03:26:50.413844	27	t	100	100	73	64
2068	62	437	2016-06-26 03:10:44.399946	437	2016-06-26 03:26:50.430454	27	t	100	100	73	64
2075	57	437	2016-06-26 03:11:15.025841	437	2016-06-26 03:27:09.727181	27	t	100	100	74	167
2077	59	437	2016-06-26 03:11:15.067246	437	2016-06-26 03:27:09.762492	27	t	200	100	74	167
2078	60	437	2016-06-26 03:11:15.083685	437	2016-06-26 03:27:09.781223	27	t	0	0	74	167
2079	61	437	2016-06-26 03:11:15.092748	437	2016-06-26 03:27:09.799169	27	t	0	0	74	167
2080	62	437	2016-06-26 03:11:15.110091	437	2016-06-26 03:27:09.815219	27	t	0	0	74	167
2087	57	437	2016-06-26 03:11:25.846617	437	2016-06-26 03:27:21.103941	27	t	0	0	74	168
2088	58	437	2016-06-26 03:11:25.86364	437	2016-06-26 03:27:21.131256	27	t	0	0	74	168
2089	59	437	2016-06-26 03:11:25.883238	437	2016-06-26 03:27:21.148685	27	t	0	0	74	168
2090	60	437	2016-06-26 03:11:25.893528	437	2016-06-26 03:27:21.20648	27	t	100	100	74	168
2091	61	437	2016-06-26 03:11:25.909624	437	2016-06-26 03:27:21.223344	27	t	100	100	74	168
2092	62	437	2016-06-26 03:11:25.926015	437	2016-06-26 03:27:21.238488	27	t	100	100	74	168
2100	58	437	2016-06-26 03:11:42.127648	437	2016-06-26 03:27:30.398869	27	t	0	0	74	169
2101	59	437	2016-06-26 03:11:42.144153	437	2016-06-26 03:27:30.415066	27	t	0	0	74	169
2102	60	437	2016-06-26 03:11:42.177517	437	2016-06-26 03:27:30.430881	27	t	0	0	74	169
2103	61	437	2016-06-26 03:11:42.193224	437	2016-06-26 03:27:30.448559	27	t	0	0	74	169
2105	63	437	2016-06-26 03:11:42.239867	\N	2016-06-26 03:11:42.239867	27	t	\N	100	74	169
2106	64	437	2016-06-26 03:11:42.252576	\N	2016-06-26 03:11:42.252576	27	t	\N	100	74	169
2107	65	437	2016-06-26 03:11:42.268538	\N	2016-06-26 03:11:42.268538	27	t	\N	100	74	169
2108	66	437	2016-06-26 03:11:42.2899	\N	2016-06-26 03:11:42.2899	27	t	\N	0	74	169
2109	67	437	2016-06-26 03:11:42.301962	\N	2016-06-26 03:11:42.301962	27	t	\N	0	74	169
2110	68	437	2016-06-26 03:11:42.324554	\N	2016-06-26 03:11:42.324554	27	t	\N	0	74	169
2129	63	437	2016-06-26 03:12:09.846974	\N	2016-06-26 03:12:09.846974	27	t	\N	0	74	171
2130	64	437	2016-06-26 03:12:09.863015	\N	2016-06-26 03:12:09.863015	27	t	\N	0	74	171
2131	65	437	2016-06-26 03:12:09.88178	\N	2016-06-26 03:12:09.88178	27	t	\N	0	74	171
2132	66	437	2016-06-26 03:12:09.895464	\N	2016-06-26 03:12:09.895464	27	t	\N	100	74	171
2133	67	437	2016-06-26 03:12:09.91122	\N	2016-06-26 03:12:09.91122	27	t	\N	100	74	171
2134	68	437	2016-06-26 03:12:09.920955	\N	2016-06-26 03:12:09.920955	27	t	\N	100	74	171
1991	57	437	2016-06-26 03:07:43.895106	437	2016-06-26 03:25:29.397992	27	t	1	1	73	63
2003	57	437	2016-06-26 03:08:12.952712	437	2016-06-26 03:25:49.670317	27	t	1	1	74	162
2019	61	437	2016-06-26 03:08:30.41989	437	2016-06-26 03:26:06.27111	27	t	4	4	74	163
2054	60	437	2016-06-26 03:09:53.891027	437	2016-06-26 03:26:29.813243	27	t	0	0	74	166
2076	58	437	2016-06-26 03:11:15.053417	437	2016-06-26 03:27:09.7507	27	t	200	100	74	167
2099	57	437	2016-06-26 03:11:42.111794	437	2016-06-26 03:27:30.379625	27	t	0	0	74	169
2104	62	437	2016-06-26 03:11:42.221134	437	2016-06-26 03:27:30.465097	27	t	0	0	74	169
2123	57	437	2016-06-26 03:12:09.732525	437	2016-06-26 03:27:40.546112	27	t	0	0	74	171
2124	58	437	2016-06-26 03:12:09.7641	437	2016-06-26 03:27:40.566075	27	t	0	0	74	171
2125	59	437	2016-06-26 03:12:09.786038	437	2016-06-26 03:27:40.582084	27	t	0	0	74	171
2126	60	437	2016-06-26 03:12:09.795118	437	2016-06-26 03:27:40.598066	27	t	0	0	74	171
2127	61	437	2016-06-26 03:12:09.813093	437	2016-06-26 03:27:40.615331	27	t	0	0	74	171
2128	62	437	2016-06-26 03:12:09.827885	437	2016-06-26 03:27:40.632012	27	t	0	0	74	171
\.


--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('rendimiento_id_rendimiento_seq', 2134, true);


--
-- Data for Name: responsable; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY responsable (id_responsable, fk_persona_registro, fk_dir_responsable, fk_poa, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus, cod_dependencia_cruge, dependencia_cruge) FROM stdin;
52	437	355	53	437	\N	2016-06-26 03:07:00.876077	2016-06-26 03:07:00.876077	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('responsable_id_responsable_seq', 52, true);


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
-- Name: fk_estrategico; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_estrategico FOREIGN KEY (fk_estrategico) REFERENCES maestro(id_maestro);


--
-- Name: fk_estrategico_mr; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_estrategico_mr FOREIGN KEY (fk_estrategico_mr) REFERENCES maestro(id_maestro);


--
-- Name: fk_general; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_general FOREIGN KEY (fk_general) REFERENCES maestro(id_maestro);


--
-- Name: fk_historico; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_historico FOREIGN KEY (fk_historico) REFERENCES maestro(id_maestro);


--
-- Name: fk_institucional; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_institucional FOREIGN KEY (fk_institucional) REFERENCES maestro(id_maestro);


--
-- Name: fk_mes; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_mes FOREIGN KEY (fk_meses) REFERENCES maestro(id_maestro);


--
-- Name: fk_nacional; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY poa
    ADD CONSTRAINT fk_nacional FOREIGN KEY (fk_nacional) REFERENCES maestro(id_maestro);


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

