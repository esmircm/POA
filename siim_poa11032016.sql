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
    fk_proyecto integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    meta character varying(500),
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
    modified_by integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_proyecto integer NOT NULL,
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
-- Name: estatus_proyecto; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE estatus_proyecto (
    id_estatus_proyecto integer NOT NULL,
    fk_estatus_proyecto integer NOT NULL,
    fk_proyecto integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    fk_tipo_entidad integer NOT NULL
);


ALTER TABLE poa.estatus_proyecto OWNER TO postgres;

--
-- Name: estatus_id_status_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE estatus_id_status_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.estatus_id_status_seq OWNER TO postgres;

--
-- Name: estatus_id_status_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE estatus_id_status_seq OWNED BY estatus_proyecto.id_estatus_proyecto;


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
-- Name: proyecto; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE proyecto (
    id_proyecto integer NOT NULL,
    nombre_proyecto character varying(500) NOT NULL,
    objetivo_general character varying(500) NOT NULL,
    descripcion character varying(1000),
    fecha_inicio timestamp without time zone,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    objetivo_historico character varying(500)
);


ALTER TABLE poa.proyecto OWNER TO postgres;

--
-- Name: proyecto_id_proyecto_seq; Type: SEQUENCE; Schema: poa; Owner: postgres
--

CREATE SEQUENCE proyecto_id_proyecto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poa.proyecto_id_proyecto_seq OWNER TO postgres;

--
-- Name: proyecto_id_proyecto_seq; Type: SEQUENCE OWNED BY; Schema: poa; Owner: postgres
--

ALTER SEQUENCE proyecto_id_proyecto_seq OWNED BY proyecto.id_proyecto;


--
-- Name: rendimiento; Type: TABLE; Schema: poa; Owner: postgres; Tablespace: 
--

CREATE TABLE rendimiento (
    id_rendimiento integer NOT NULL,
    fk_meses integer NOT NULL,
    fk_actividad integer NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_status integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL,
    cantidad_cumplida integer NOT NULL
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
    fk_proyecto integer NOT NULL,
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
    ac.meta,
    ac.bien_servicio,
    ac.cantidad,
    ac.fk_proyecto
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
    acc.fk_proyecto
   FROM ((actividades act
     LEFT JOIN maestro pr ON ((pr.id_maestro = act.fk_unidad_medida)))
     LEFT JOIN acciones acc ON ((acc.id_accion = act.fk_accion)))
  ORDER BY act.id_actividades;


ALTER TABLE poa.vsw_actividades OWNER TO postgres;

--
-- Name: vsw_admin; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_admin AS
 SELECT pro.id_proyecto,
    pro.nombre_proyecto,
    res.cod_dependencia_cruge,
    res.dependencia_cruge,
    est.fk_estatus_proyecto,
    maest.descripcion
   FROM (((((proyecto pro
     LEFT JOIN responsable res ON ((res.fk_proyecto = pro.id_proyecto)))
     LEFT JOIN estatus_proyecto est ON (((est.fk_proyecto = pro.id_proyecto) AND (est.created_date = ( SELECT max(est2.created_date) AS max
           FROM estatus_proyecto est2
          WHERE (est.fk_proyecto = est2.fk_proyecto)
          GROUP BY est2.fk_proyecto)))))
     LEFT JOIN maestro maest ON ((maest.id_maestro = est.fk_estatus_proyecto)))
     LEFT JOIN acciones acc ON ((acc.fk_proyecto = pro.id_proyecto)))
     LEFT JOIN actividades act ON ((act.fk_accion = acc.id_accion)))
  GROUP BY pro.id_proyecto, pro.nombre_proyecto, res.cod_dependencia_cruge, res.dependencia_cruge, est.fk_estatus_proyecto, maest.descripcion
  ORDER BY pro.id_proyecto;


ALTER TABLE poa.vsw_admin OWNER TO postgres;

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
-- Name: vsw_proyecto; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_proyecto AS
 SELECT pr.id_proyecto,
    pr.nombre_proyecto AS proyecto,
    pr.objetivo_general,
    pr.objetivo_historico,
    pr.descripcion,
    ac.id_accion,
    ac.nombre_accion AS acciones,
    act.id_actividades AS actividades,
    act.actividad
   FROM ((proyecto pr
     LEFT JOIN acciones ac ON ((ac.fk_proyecto = pr.id_proyecto)))
     LEFT JOIN actividades act ON ((act.fk_accion = ac.id_accion)))
  ORDER BY pr.id_proyecto;


ALTER TABLE poa.vsw_proyecto OWNER TO postgres;

--
-- Name: vsw_proyecto2; Type: VIEW; Schema: poa; Owner: postgres
--

CREATE VIEW vsw_proyecto2 AS
 SELECT pro.id_proyecto,
    pro.nombre_proyecto,
    pro.objetivo_general,
    pro.fecha_inicio,
    pro.objetivo_historico,
    pro.descripcion,
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
   FROM (((((proyecto pro
     LEFT JOIN responsable res ON ((res.fk_proyecto = pro.id_proyecto)))
     LEFT JOIN public.cruge_user user_res ON ((user_res.iduser = res.fk_persona_registro)))
     LEFT JOIN public.cruge_user user_dir ON ((user_dir.iduser = res.fk_dir_responsable)))
     LEFT JOIN vsw_personal per ON ((per.id_persona = user_res.id_persona)))
     LEFT JOIN vsw_personal per_dir ON ((per_dir.id_persona = user_dir.id_persona)));


ALTER TABLE poa.vsw_proyecto2 OWNER TO postgres;

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
-- Name: id_estatus_proyecto; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_proyecto ALTER COLUMN id_estatus_proyecto SET DEFAULT nextval('estatus_id_status_seq'::regclass);


--
-- Name: id_maestro; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY maestro ALTER COLUMN id_maestro SET DEFAULT nextval('maestro_id_maestro_seq'::regclass);


--
-- Name: id_proyecto; Type: DEFAULT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY proyecto ALTER COLUMN id_proyecto SET DEFAULT nextval('proyecto_id_proyecto_seq'::regclass);


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

COPY acciones (id_accion, nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_proyecto, created_by, created_date, modified_by, modified_date, fk_status, es_activo, meta, bien_servicio) FROM stdin;
33	1.-Elaboración y Formulación de los Instrumentos de Planificación y Presupuesto (Anteproyecto Proyecto de POAI y Presupuesto).  	41	360	47	37	462	2016-03-11 06:12:46.447433	462	2016-03-11 06:12:46.447433	12	t	Elaborar y Formular 4 Instrumentos.	Documentos Elaborados 
\.


--
-- Name: acciones_id_accion_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('acciones_id_accion_seq', 33, true);


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY actividades (id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
82	Apoyo técnico para la formulación del Plan Operativo y Presupuesto Anual,a las distintas unidades del Minmujer y entes adscritos.	41	120	33	462	2016-03-11 06:13:18.303035	462	2016-03-11 06:13:18.303035	15	t
83	Revisión de los Planes Operativos, Presupuestos y Proyectos elaborados por las Unidades del MINMUJER y Entes adscritos.	41	100	33	462	2016-03-11 06:13:49.629613	462	2016-03-11 06:13:49.629613	15	t
84	Elaboración del Plan Operativo y Presupuesto de la Oficina de Planificación y Presupuesto.	41	100	33	462	2016-03-11 06:14:16.810006	462	2016-03-11 06:14:16.810006	15	t
85	Seguimiento y apoyo en la elaboración del Anteproyecto y Proyecto del POAN del Minmujer. 	41	40	33	462	2016-03-11 06:14:34.531813	462	2016-03-11 06:14:34.531813	15	t
\.


--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('actividades_id_actividades_seq', 85, true);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY comentarios (id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_proyecto, fk_tipo_entidad) FROM stdin;
\.


--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentarios_seq', 1, false);


--
-- Name: estatus_id_status_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('estatus_id_status_seq', 13, true);


--
-- Data for Name: estatus_proyecto; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY estatus_proyecto (id_estatus_proyecto, fk_estatus_proyecto, fk_proyecto, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_tipo_entidad) FROM stdin;
13	50	37	462	2016-03-11 06:12:02.54992	\N	2016-03-11 06:12:02.54992	21	t	8
\.


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
20	ESTATUS TABLA ESTATUS_PROYECTO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
21	ACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
22	INACTIVO	20	0	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
23	ESTATUS PROYECTO	0	2	1	2016-02-21 20:54:21.299128	\N	2016-02-21 20:54:21.299128	t
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
\.


--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 54, true);


--
-- Data for Name: proyecto; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY proyecto (id_proyecto, nombre_proyecto, objetivo_general, descripcion, fecha_inicio, created_by, created_date, modified_by, modified_date, fk_status, es_activo, objetivo_historico) FROM stdin;
37	Democracia Protagónica y Participativa	Garantizar la formulación del Plan Estratégico, Plan Operativo Anual y su vinculación con el Presupuesto del Ministerio y sus Entes Adscritos, así como apoyar en el funcionamiento organizativo y sistemas estadísticos.		2016-01-01 00:00:00	462	2016-03-11 06:12:02.489954	\N	2016-03-11 06:12:02.489954	24	t	\N
\.


--
-- Name: proyecto_id_proyecto_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('proyecto_id_proyecto_seq', 37, true);


--
-- Data for Name: rendimiento; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY rendimiento (id_rendimiento, fk_meses, fk_actividad, created_by, created_date, modified_by, modified_date, fk_status, es_activo, cantidad_cumplida) FROM stdin;
\.


--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('rendimiento_id_rendimiento_seq', 1, false);


--
-- Data for Name: responsable; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY responsable (id_responsable, fk_persona_registro, fk_dir_responsable, fk_proyecto, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus, cod_dependencia_cruge, dependencia_cruge) FROM stdin;
31	462	355	37	462	\N	2016-03-11 06:12:02.523425	2016-03-11 06:12:02.523425	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('responsable_id_responsable_seq', 31, true);


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
-- Name: id_estatus_proyecto; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus_proyecto
    ADD CONSTRAINT id_estatus_proyecto PRIMARY KEY (id_estatus_proyecto);


--
-- Name: id_maestro; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY maestro
    ADD CONSTRAINT id_maestro PRIMARY KEY (id_maestro);


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
-- Name: proyecto_pkey; Type: CONSTRAINT; Schema: poa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proyecto
    ADD CONSTRAINT proyecto_pkey PRIMARY KEY (id_proyecto);


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
-- Name: fk_actividad; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_actividad FOREIGN KEY (fk_actividad) REFERENCES actividades(id_actividades);


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
-- Name: fk_proyecto; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY acciones
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (fk_proyecto) REFERENCES proyecto(id_proyecto);


--
-- Name: fk_proyecto; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_proyecto
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (fk_proyecto) REFERENCES proyecto(id_proyecto);


--
-- Name: fk_proyecto; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (fk_proyecto) REFERENCES proyecto(id_proyecto);


--
-- Name: fk_proyecto; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY responsable
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (fk_proyecto) REFERENCES proyecto(id_proyecto);


--
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY proyecto
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY rendimiento
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_status; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_proyecto
    ADD CONSTRAINT fk_status FOREIGN KEY (fk_status) REFERENCES maestro(id_maestro);


--
-- Name: fk_status_proyecto; Type: FK CONSTRAINT; Schema: poa; Owner: postgres
--

ALTER TABLE ONLY estatus_proyecto
    ADD CONSTRAINT fk_status_proyecto FOREIGN KEY (fk_estatus_proyecto) REFERENCES maestro(id_maestro);


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
-- PostgreSQL database dump complete
--

