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
-- Name: actualizar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA actualizar;


ALTER SCHEMA actualizar OWNER TO postgres;

--
-- Name: evaluacion; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evaluacion;


ALTER SCHEMA evaluacion OWNER TO postgres;

--
-- Name: poa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA poa;


ALTER SCHEMA poa OWNER TO postgres;

--
-- Name: requisicion; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA requisicion;


ALTER SCHEMA requisicion OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA actualizar;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET search_path = public, pg_catalog;

--
-- Name: fn_eliminar_traza(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fn_eliminar_traza(usuario integer, personal integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE cantidad INTEGER;

  BEGIN
	cantidad = (SELECT n_traza from actualizar.traza WHERE id_usuario = usuario AND id_personal = personal);

   IF cantidad !=3 THEN
	
		RETURN 0;

	ELSE 
		INSERT INTO actualizar.historico (id_usuario, id_personal) 
		VALUES (usuario, personal);
		
		DELETE FROM actualizar.traza
		WHERE id_usuario = usuario
		AND id_personal = personal;

	RETURN 1;

   END IF;
	
  END;
$$;


ALTER FUNCTION public.fn_eliminar_traza(usuario integer, personal integer) OWNER TO postgres;

SET search_path = actualizar, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: historico; Type: TABLE; Schema: actualizar; Owner: postgres; Tablespace: 
--

CREATE TABLE historico (
    id_historico integer NOT NULL,
    id_personal integer,
    id_usuario integer,
    se_activa_1 boolean DEFAULT false NOT NULL,
    se_activa_2 boolean DEFAULT false NOT NULL,
    se_activa_3 boolean DEFAULT false NOT NULL,
    created_date timestamp without time zone DEFAULT now()
);


ALTER TABLE actualizar.historico OWNER TO postgres;

--
-- Name: COLUMN historico.se_activa_1; Type: COMMENT; Schema: actualizar; Owner: postgres
--

COMMENT ON COLUMN historico.se_activa_1 IS 'booleano que permite que se active la actualización de la hoja 1 de actualizacion de rrhh en el sistema siim';


--
-- Name: COLUMN historico.se_activa_2; Type: COMMENT; Schema: actualizar; Owner: postgres
--

COMMENT ON COLUMN historico.se_activa_2 IS 'booleano que permite que se active la actualización de la hoja 2 de actualizacion de rrhh en el sistema siim';


--
-- Name: COLUMN historico.se_activa_3; Type: COMMENT; Schema: actualizar; Owner: postgres
--

COMMENT ON COLUMN historico.se_activa_3 IS 'booleano que permite que se active la actualización de la hoja 3 de actualizacion de rrhh en el sistema siim';


--
-- Name: historico_id_historico_seq; Type: SEQUENCE; Schema: actualizar; Owner: postgres
--

CREATE SEQUENCE historico_id_historico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actualizar.historico_id_historico_seq OWNER TO postgres;

--
-- Name: historico_id_historico_seq; Type: SEQUENCE OWNED BY; Schema: actualizar; Owner: postgres
--

ALTER SEQUENCE historico_id_historico_seq OWNED BY historico.id_historico;


--
-- Name: traza; Type: TABLE; Schema: actualizar; Owner: postgres; Tablespace: 
--

CREATE TABLE traza (
    id_traza integer NOT NULL,
    id_personal integer,
    n_traza integer,
    id_usuario integer,
    fecha_traza timestamp without time zone DEFAULT now() NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT now()
);


ALTER TABLE actualizar.traza OWNER TO postgres;

--
-- Name: traza_id_traza_seq; Type: SEQUENCE; Schema: actualizar; Owner: postgres
--

CREATE SEQUENCE traza_id_traza_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actualizar.traza_id_traza_seq OWNER TO postgres;

--
-- Name: traza_id_traza_seq; Type: SEQUENCE OWNED BY; Schema: actualizar; Owner: postgres
--

ALTER SEQUENCE traza_id_traza_seq OWNED BY traza.id_traza;


--
-- Name: vsw_sigefirrhh; Type: VIEW; Schema: actualizar; Owner: postgres
--

CREATE VIEW vsw_sigefirrhh AS
 SELECT p.id_personal,
    p.cedula,
    p.primer_nombre,
    p.segundo_nombre,
    p.primer_apellido,
    p.segundo_apellido,
    p.descripcion_cargo,
    p.oficina,
    p.id_tipo_dependencia
   FROM dblink('dbname=sigefirrhh_2011 host=172.16.0.222 user=postgres password=postgres'::text, 'SELECT DISTINCT (per.id_personal), per.cedula, per.primer_nombre, per.segundo_nombre, per.primer_apellido, 
													     per.segundo_apellido, car.descripcion_cargo, dep.nombre as oficina, dep.id_tipo_dependencia
													     FROM personal per
													     JOIN trabajador tr on tr.id_personal = per.id_personal
													     JOIN cargo car on car.cod_cargo = tr.cod_cargo AND car.id_cargo = tr.id_cargo
													     JOIN dependencia dep on dep.id_dependencia = tr.id_dependencia
													     WHERE tr.estatus = ''A'' 
													     GROUP BY per.id_personal, per.cedula, per.primer_nombre, per.segundo_nombre, per.primer_apellido, per.segundo_apellido,
													     car.descripcion_cargo, dep.nombre, dep.id_tipo_dependencia
													     ORDER BY oficina'::text) p(id_personal integer, cedula integer, primer_nombre character varying(20), segundo_nombre character varying(20), primer_apellido character varying(20), segundo_apellido character varying(20), descripcion_cargo character varying(90), oficina character varying(90), id_tipo_dependencia integer);


ALTER TABLE actualizar.vsw_sigefirrhh OWNER TO postgres;

--
-- Name: vsw_usuarios_actualizados; Type: VIEW; Schema: actualizar; Owner: postgres
--

CREATE VIEW vsw_usuarios_actualizados AS
 SELECT p.id_personal,
    p.cedula,
    p.primer_nombre,
    p.primer_apellido,
        CASE
            WHEN ((tr.id_personal = p.id_personal) AND (tr.n_traza = 1)) THEN '30%'::text
            WHEN ((tr.id_personal = p.id_personal) AND (tr.n_traza = 2)) THEN '60%'::text
            WHEN ((p.id_personal = hc.id_personal) AND (hc.id_usuario IS NOT NULL)) THEN '100%'::text
            ELSE NULL::text
        END AS porcentaje,
        CASE
            WHEN (tr.fecha_traza IS NOT NULL) THEN (tr.fecha_traza)::date
            WHEN (hc.created_date IS NOT NULL) THEN (hc.created_date)::date
            ELSE NULL::date
        END AS fecha
   FROM ((traza tr
     RIGHT JOIN dblink('dbname=sigefirrhh_2011 host=172.16.0.222 user=postgres password=postgres'::text, 'SELECT id_personal, cedula, primer_nombre, primer_apellido FROM personal'::text) p(id_personal integer, cedula integer, primer_nombre character varying(20), primer_apellido character varying(20)) ON ((p.id_personal = tr.id_personal)))
     LEFT JOIN historico hc ON ((hc.id_personal = p.id_personal)))
  WHERE ((tr.n_traza IS NOT NULL) OR (hc.id_personal IS NOT NULL))
  GROUP BY tr.n_traza, tr.id_personal, p.cedula, p.primer_nombre, p.primer_apellido, tr.fecha_traza, hc.id_personal, p.id_personal, hc.id_usuario, hc.created_date
  ORDER BY
        CASE
            WHEN ((tr.id_personal = p.id_personal) AND (tr.n_traza = 1)) THEN '30%'::text
            WHEN ((tr.id_personal = p.id_personal) AND (tr.n_traza = 2)) THEN '60%'::text
            WHEN ((p.id_personal = hc.id_personal) AND (hc.id_usuario IS NOT NULL)) THEN '100%'::text
            ELSE NULL::text
        END DESC;


ALTER TABLE actualizar.vsw_usuarios_actualizados OWNER TO postgres;

SET search_path = evaluacion, pg_catalog;

--
-- Name: comentarios; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE comentarios (
    id_comentario integer NOT NULL,
    fk_evaluacion integer NOT NULL,
    comentario character varying(1000) NOT NULL,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE evaluacion.comentarios OWNER TO postgres;

--
-- Name: COLUMN comentarios.id_comentario; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN comentarios.id_comentario IS 'clave primaria';


--
-- Name: COLUMN comentarios.fk_evaluacion; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN comentarios.fk_evaluacion IS 'clave foránea con referencia a la evaluacion';


--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE comentarios_id_comentario_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.comentarios_id_comentario_seq OWNER TO postgres;

--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE comentarios_id_comentario_seq OWNED BY comentarios.id_comentario;


--
-- Name: estatus_evaluacion; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE estatus_evaluacion (
    id_estatus_evaluacion integer NOT NULL,
    fk_evaluacion integer NOT NULL,
    fk_tipo_entidad integer NOT NULL,
    fk_entidad integer NOT NULL,
    fk_estatus_evaluacion integer NOT NULL,
    fecha_estatus timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone,
    fk_estatus integer NOT NULL,
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE evaluacion.estatus_evaluacion OWNER TO postgres;

--
-- Name: estatus_evaluacion_id_estatus_evaluacion_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE estatus_evaluacion_id_estatus_evaluacion_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.estatus_evaluacion_id_estatus_evaluacion_seq OWNER TO postgres;

--
-- Name: estatus_evaluacion_id_estatus_evaluacion_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE estatus_evaluacion_id_estatus_evaluacion_seq OWNED BY estatus_evaluacion.id_estatus_evaluacion;


--
-- Name: evaluacion; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE evaluacion (
    id_evaluacion integer NOT NULL,
    fk_evaluador integer,
    fk_evaluado integer,
    total_b integer,
    total_c numeric,
    total_final numeric,
    esta_conforme boolean,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean NOT NULL,
    obj_funcional character varying(200),
    fk_rango_act integer
);


ALTER TABLE evaluacion.evaluacion OWNER TO postgres;

--
-- Name: evaluacion_id_evaluacion_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE evaluacion_id_evaluacion_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.evaluacion_id_evaluacion_seq OWNER TO postgres;

--
-- Name: evaluacion_id_evaluacion_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE evaluacion_id_evaluacion_seq OWNED BY evaluacion.id_evaluacion;


--
-- Name: evaluador; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE evaluador (
    id_evaluador integer NOT NULL,
    cod_nomina integer NOT NULL,
    cargo character varying(100) NOT NULL,
    grado character varying(10),
    cod_clase integer,
    unidad_admtiva character varying(100) NOT NULL,
    fk_persona integer NOT NULL,
    fk_estatus integer NOT NULL,
    fk_supervisor integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL,
    fk_tipo_entidad integer,
    fk_dependencia integer,
    dependencia_cruge character varying(100)
);


ALTER TABLE evaluacion.evaluador OWNER TO postgres;

--
-- Name: COLUMN evaluador.fk_dependencia; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN evaluador.fk_dependencia IS 'Clave foránea con respecto a la oficina a la que se encuentra adscrito el evaluador';


--
-- Name: evaluador_id_evaluador_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE evaluador_id_evaluador_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.evaluador_id_evaluador_seq OWNER TO postgres;

--
-- Name: evaluador_id_evaluador_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE evaluador_id_evaluador_seq OWNED BY evaluador.id_evaluador;


--
-- Name: evaluados; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE evaluados (
    id_evaluado integer NOT NULL,
    cargo character varying(100) NOT NULL,
    grado character varying(10),
    cod_nomina integer,
    fecha_ingreso timestamp without time zone,
    tiempo_puesto timestamp without time zone,
    ubicacion_admtiva character varying(100),
    estado character varying(50),
    periodo_desde timestamp without time zone,
    periodo_hasta timestamp without time zone,
    n_veces integer,
    cod_clase integer,
    fk_persona integer,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean NOT NULL,
    fk_tipo_entidad integer,
    fk_dependencia integer,
    fk_periodo integer
);


ALTER TABLE evaluacion.evaluados OWNER TO postgres;

--
-- Name: COLUMN evaluados.fk_tipo_entidad; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN evaluados.fk_tipo_entidad IS 'clave foránea con respecto a maestro, para determinar el tipo de oficina ';


--
-- Name: COLUMN evaluados.fk_dependencia; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN evaluados.fk_dependencia IS 'clave foránea con referencia a la oficina donde se encuentra adscrito';


--
-- Name: COLUMN evaluados.fk_periodo; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN evaluados.fk_periodo IS 'clave foranea con referencia a maestro, determina el periodo a evaluar';


--
-- Name: evaluados_id_evaluado_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE evaluados_id_evaluado_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.evaluados_id_evaluado_seq OWNER TO postgres;

--
-- Name: evaluados_id_evaluado_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE evaluados_id_evaluado_seq OWNED BY evaluados.id_evaluado;


--
-- Name: maestro; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE maestro (
    id_maestro integer NOT NULL,
    descripcion character varying NOT NULL,
    padre integer,
    hijo integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL,
    descripcion2 character varying(50)
);


ALTER TABLE evaluacion.maestro OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE maestro_id_maestro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.maestro_id_maestro_seq OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE maestro_id_maestro_seq OWNED BY maestro.id_maestro;


--
-- Name: preguntas; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas (
    id_pregunta integer NOT NULL,
    pregunta character varying(500),
    fk_tipo_clase integer,
    pregunta_padre character varying,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL,
    peso_fijo numeric,
    orden character(1)
);


ALTER TABLE evaluacion.preguntas OWNER TO postgres;

--
-- Name: preguntas_colectivas; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas_colectivas (
    id_preguntas_colect integer NOT NULL,
    fk_pregunta integer NOT NULL,
    fk_tipo_clase integer NOT NULL,
    peso integer NOT NULL,
    fk_rango integer NOT NULL,
    subtotal_peso integer NOT NULL,
    fk_evaluacion integer NOT NULL,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL,
    orden character(3)
);


ALTER TABLE evaluacion.preguntas_colectivas OWNER TO postgres;

--
-- Name: COLUMN preguntas_colectivas.orden; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_colectivas.orden IS 'orden de las preguntas';


--
-- Name: preguntas_colectivas_id_preguntas_colect_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE preguntas_colectivas_id_preguntas_colect_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.preguntas_colectivas_id_preguntas_colect_seq OWNER TO postgres;

--
-- Name: preguntas_colectivas_id_preguntas_colect_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE preguntas_colectivas_id_preguntas_colect_seq OWNED BY preguntas_colectivas.id_preguntas_colect;


--
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE preguntas_id_pregunta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.preguntas_id_pregunta_seq OWNER TO postgres;

--
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE preguntas_id_pregunta_seq OWNED BY preguntas.id_pregunta;


--
-- Name: preguntas_individuales; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas_individuales (
    id_preguntas_ind integer NOT NULL,
    objetivo character varying(300) NOT NULL,
    peso integer NOT NULL,
    fk_rango integer,
    subtotal_peso integer,
    fk_evaluacion integer NOT NULL,
    fk_estatus integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean NOT NULL
);


ALTER TABLE evaluacion.preguntas_individuales OWNER TO postgres;

--
-- Name: COLUMN preguntas_individuales.id_preguntas_ind; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.id_preguntas_ind IS 'clave primaria';


--
-- Name: COLUMN preguntas_individuales.objetivo; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.objetivo IS 'referente a los objetivos individuales que el funcionario debe cumplir';


--
-- Name: COLUMN preguntas_individuales.peso; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.peso IS 'peso asignado a cada objetivo';


--
-- Name: COLUMN preguntas_individuales.fk_rango; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.fk_rango IS 'clave foránea en referencia a maestro';


--
-- Name: COLUMN preguntas_individuales.subtotal_peso; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.subtotal_peso IS 'total de puntaje evaluado en esta sección';


--
-- Name: COLUMN preguntas_individuales.fk_evaluacion; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_individuales.fk_evaluacion IS 'clave foránea en referencia a la tabla evaluación';


--
-- Name: preguntas_individuales_id_preguntas_ind_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE preguntas_individuales_id_preguntas_ind_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.preguntas_individuales_id_preguntas_ind_seq OWNER TO postgres;

--
-- Name: preguntas_individuales_id_preguntas_ind_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE preguntas_individuales_id_preguntas_ind_seq OWNED BY preguntas_individuales.id_preguntas_ind;


--
-- Name: preguntas_obrero; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas_obrero (
    id_preguntas_obr integer NOT NULL,
    puntaje numeric NOT NULL,
    fk_pregunta integer NOT NULL,
    fk_evaluacion integer NOT NULL,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean NOT NULL
);


ALTER TABLE evaluacion.preguntas_obrero OWNER TO postgres;

--
-- Name: COLUMN preguntas_obrero.fk_pregunta; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_obrero.fk_pregunta IS 'Clave foránea con referencia a la tabla preguntas';


--
-- Name: COLUMN preguntas_obrero.fk_evaluacion; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_obrero.fk_evaluacion IS 'clave foránea en referencia a la tabla evaluación';


--
-- Name: COLUMN preguntas_obrero.fk_estatus; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN preguntas_obrero.fk_estatus IS 'clave foránea en referencia a la tabla maestro';


--
-- Name: preguntas_obrero_id_preguntas_obr_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE preguntas_obrero_id_preguntas_obr_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.preguntas_obrero_id_preguntas_obr_seq OWNER TO postgres;

--
-- Name: preguntas_obrero_id_preguntas_obr_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE preguntas_obrero_id_preguntas_obr_seq OWNED BY preguntas_obrero.id_preguntas_obr;


--
-- Name: revision; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE revision (
    id_revision integer NOT NULL,
    fk_revision integer,
    fk_evaluador integer,
    fk_evaluacion integer NOT NULL,
    fecha_revision date NOT NULL,
    comentario character varying(500),
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE evaluacion.revision OWNER TO postgres;

--
-- Name: COLUMN revision.fk_revision; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN revision.fk_revision IS 'clave foranea con referencia a maestro';


--
-- Name: COLUMN revision.fk_evaluador; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN revision.fk_evaluador IS 'clave foranea con referencia a persona, se almacena el id_evaluador';


--
-- Name: revision_id_revision_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE revision_id_revision_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.revision_id_revision_seq OWNER TO postgres;

--
-- Name: revision_id_revision_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE revision_id_revision_seq OWNED BY revision.id_revision;


--
-- Name: supervisor; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE supervisor (
    id_supervisor integer NOT NULL,
    fk_persona integer NOT NULL,
    cargo character varying(100) NOT NULL,
    fk_estatus integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer NOT NULL,
    modified_by integer,
    es_activo boolean NOT NULL
);


ALTER TABLE evaluacion.supervisor OWNER TO postgres;

--
-- Name: COLUMN supervisor.id_supervisor; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN supervisor.id_supervisor IS 'clave primaria';


--
-- Name: COLUMN supervisor.fk_persona; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN supervisor.fk_persona IS 'Clave Foránea con respecto a la tabla persona';


--
-- Name: COLUMN supervisor.cargo; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN supervisor.cargo IS 'descripción del cargo';


--
-- Name: COLUMN supervisor.fk_estatus; Type: COMMENT; Schema: evaluacion; Owner: postgres
--

COMMENT ON COLUMN supervisor.fk_estatus IS 'clave foránea con referencia a la tabla maestro, estatus de la tabla';


--
-- Name: supervisor_id_supervisor_seq; Type: SEQUENCE; Schema: evaluacion; Owner: postgres
--

CREATE SEQUENCE supervisor_id_supervisor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evaluacion.supervisor_id_supervisor_seq OWNER TO postgres;

--
-- Name: supervisor_id_supervisor_seq; Type: SEQUENCE OWNED BY; Schema: evaluacion; Owner: postgres
--

ALTER SEQUENCE supervisor_id_supervisor_seq OWNED BY supervisor.id_supervisor;


--
-- Name: vsw_admin; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE vsw_admin (
    id_persona_evaluado integer,
    nacionalidad character varying(1),
    cedula integer,
    apellidos text,
    nombres text,
    descripcion_cargo character varying(60),
    activo character varying(1),
    cod_dependencia_evaluado integer,
    dependencia character varying(90),
    tipo_cargo character varying(1),
    fk_tipo_clase text,
    id_evaluacion integer,
    fecha_creacion_evaluacion timestamp without time zone,
    id_persona integer,
    cod_dependencia_evaluador integer,
    dep_evaluador character varying(90),
    fk_estatus_evaluacion integer,
    estatus character varying,
    tiene_objetivos text,
    cod_dependencia_evaluador_gruge integer,
    dep_evaluador_cruge character varying(100)
);


ALTER TABLE evaluacion.vsw_admin OWNER TO postgres;

--
-- Name: vsw_evaluacion; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_evaluacion AS
 SELECT p.id_personal AS id_persona,
    p.nacionalidad,
    p.cedula,
    p.cod_tipo_personal AS fk_cargo,
    (((p.primer_apellido)::text || ' '::text) || (p.segundo_apellido)::text) AS apellidos,
    (((p.primer_nombre)::text || ' '::text) || (p.segundo_nombre)::text) AS nombres,
    p.sexo,
    p.id_cargo,
    p.descripcion_cargo,
    p.estatus,
    p.codigo_nomina,
    p.id_dependencia AS cod_dependencia,
    p.nombre AS dependencia,
    p.telefono_oficina AS telef_oficina,
    p.grado,
    p.tipo_cargo,
    to_char((p.fecha_ingreso)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char,
        CASE
            WHEN (p.cod_tipo_personal = 1) THEN (14)::text
            WHEN (p.cod_tipo_personal = 2) THEN (13)::text
            WHEN (p.cod_tipo_personal = 3) THEN (11)::text
            WHEN (p.cod_tipo_personal = 4) THEN (12)::text
            ELSE NULL::text
        END AS fk_tipo_clase
   FROM actualizar.dblink('dbname=actualizacion host=localhost user=postgres password=2712'::text, 'SELECT per.id_personal, per.nacionalidad, per.cedula, per.primer_nombre, per.segundo_nombre, per.primer_apellido,
segundo_apellido, per.sexo, car.id_cargo, car.descripcion_cargo, tr.estatus, tr.codigo_nomina, dep.id_dependencia, dep.nombre, per.telefono_oficina, car.grado, car.tipo_cargo, tr.fecha_ingreso,tr.cod_tipo_personal
FROM personal per
JOIN trabajador tr on tr.id_personal = per.id_personal
JOIN cargo car on car.id_cargo = tr.id_cargo
JOIN dependencia dep on dep.id_dependencia = tr.id_dependencia
'::text) p(id_personal integer, nacionalidad character varying(1), cedula integer, primer_nombre character varying(20), segundo_nombre character varying(20), primer_apellido character varying(20), segundo_apellido character varying(20), sexo character varying(1), id_cargo integer, descripcion_cargo character varying(60), estatus character varying(1), codigo_nomina integer, id_dependencia integer, nombre character varying(90), telefono_oficina character varying(15), grado integer, tipo_cargo character varying(1), fecha_ingreso date, cod_tipo_personal integer)
  WHERE ((p.estatus)::text = 'A'::text);


ALTER TABLE evaluacion.vsw_evaluacion OWNER TO postgres;

--
-- Name: vsw_certificado; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_certificado AS
 SELECT pers.id_persona,
    eva.id_evaluacion,
    evados.fk_periodo,
    peri.descripcion AS periodo,
    pers.apellidos,
    pers.nombres,
    pers.nacionalidad,
    pers.cedula,
    pers.sexo,
    evador.cod_nomina,
    evador.cargo,
    vevaldor.cod_dependencia AS cod_dependencia_evaluador,
    vevaldor.dependencia AS dep_evaluador,
    vevaldo.telef_oficina,
    eva.obj_funcional,
    per.id_persona AS id_evaluado,
    per.apellidos AS apellidos_evaluado,
    per.nombres AS nombres_evaluado,
    per.nacionalidad AS nacionalidad_evaluado,
    per.cedula AS cedula_evaluado,
    per.sexo AS sexo_evaluado,
    evados.cod_nomina AS cod_nomina_evaluado,
    evados.cargo AS cargo_evaluado,
    vevaldo.dependencia AS dep_evaluado,
    vevaldo.telef_oficina AS telefono_evaluado,
    est.fk_tipo_entidad AS dependencia,
    est.fk_entidad,
    est.fk_estatus_evaluacion,
    ms.descripcion AS estatus,
    com.id_comentario,
    com.comentario,
    evador.fk_dependencia AS cod_dependencia_evaluador_gruge,
    evador.dependencia_cruge AS dep_evaluador_cruge
   FROM ((((((((((evaluacion eva
     LEFT JOIN estatus_evaluacion est ON ((est.fk_evaluacion = eva.id_evaluacion)))
     JOIN evaluados evados ON ((evados.id_evaluado = eva.fk_evaluado)))
     JOIN maestro peri ON ((peri.id_maestro = evados.fk_periodo)))
     JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     JOIN vsw_evaluacion per ON ((per.id_persona = evados.fk_persona)))
     JOIN vsw_evaluacion pers ON ((pers.id_persona = evador.fk_persona)))
     JOIN vsw_evaluacion vevaldo ON ((vevaldo.id_persona = per.id_persona)))
     JOIN vsw_evaluacion vevaldor ON ((vevaldor.id_persona = pers.id_persona)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = est.fk_estatus_evaluacion)))
     LEFT JOIN comentarios com ON ((com.fk_evaluacion = eva.id_evaluacion)))
  GROUP BY eva.id_evaluacion, pers.id_persona, evados.periodo_desde, evados.periodo_hasta, pers.apellidos, pers.nombres, pers.nacionalidad, pers.cedula, pers.sexo, evador.cod_nomina, evador.cargo, pers.dependencia, evador.unidad_admtiva, vevaldo.telef_oficina, eva.obj_funcional, evador.fk_dependencia, evador.dependencia_cruge, per.id_persona, per.apellidos, per.nombres, per.nacionalidad, per.cedula, per.sexo, evados.cod_nomina, evados.cargo, per.dependencia, evados.ubicacion_admtiva, est.fk_tipo_entidad, est.fk_entidad, est.fk_estatus_evaluacion, ms.descripcion, com.id_comentario, com.comentario, evados.fk_periodo, vevaldor.dependencia, vevaldor.cod_dependencia, vevaldo.dependencia, peri.descripcion
  ORDER BY eva.id_evaluacion;


ALTER TABLE evaluacion.vsw_certificado OWNER TO postgres;

--
-- Name: vsw_listar_personas; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE vsw_listar_personas (
    id_persona_evaluado integer,
    apellidos_evaluado text,
    nombres_evaluado text,
    nacionalidad_evaluado character varying(1),
    cedula_evaluado integer,
    sexo_evaluado character varying(1),
    cod_nomina_evaluado integer,
    fk_cargo_evaluado integer,
    cargo_evaluado character varying(60),
    fecha_creacion_evaluacion timestamp without time zone,
    fk_tipo_clase text,
    cod_oficina_evaluado integer,
    oficina_evaluado character varying(90),
    telefono_evaluado character varying(15),
    id_persona integer,
    id_evaluacion integer,
    fk_periodo integer,
    periodo_evaluacion character varying,
    apellidos text,
    nombres text,
    nacionalidad character varying(1),
    cedula integer,
    sexo character varying(1),
    codigo_nomina integer,
    fk_cargo integer,
    descripcion_cargo character varying(60),
    cod_dependencia integer,
    dependencia character varying(90),
    telef_oficina character varying(15),
    obj_funcional character varying(200),
    fk_estatus_evaluacion integer,
    estatus character varying,
    id_comentario integer,
    comentario character varying(1000),
    tiene_objetivos text,
    cant_objetivos bigint,
    peso_total bigint,
    cod_dependencia_evaluador_gruge integer,
    dep_evaluador_cruge character varying(100)
);


ALTER TABLE evaluacion.vsw_listar_personas OWNER TO postgres;

--
-- Name: vsw_pdf_competencias; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_pdf_competencias AS
 SELECT eva.id_evaluacion,
    preg.id_pregunta,
    preg.pregunta_padre,
    preg.pregunta,
    preg.fk_tipo_clase,
        CASE
            WHEN (preg.fk_tipo_clase = 11) THEN pregob.puntaje
            WHEN (preg.fk_tipo_clase = ANY (ARRAY[12, 13, 14])) THEN (pregcol.peso)::numeric
            ELSE NULL::numeric
        END AS peso,
    pregcol.fk_rango,
    ran.descripcion AS rango,
    pregcol.subtotal_peso
   FROM ((((evaluacion eva
     LEFT JOIN preguntas_colectivas pregcol ON ((pregcol.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN preguntas_obrero pregob ON ((pregob.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN preguntas preg ON (((preg.id_pregunta = pregob.fk_pregunta) OR (preg.id_pregunta = pregcol.fk_pregunta))))
     LEFT JOIN maestro ran ON ((ran.id_maestro = pregcol.fk_rango)));


ALTER TABLE evaluacion.vsw_pdf_competencias OWNER TO postgres;

--
-- Name: vsw_pdf_eval_final; Type: TABLE; Schema: evaluacion; Owner: postgres; Tablespace: 
--

CREATE TABLE vsw_pdf_eval_final (
    id_persona_evaluado integer,
    fk_periodo integer,
    periodo_evaluacion character varying,
    n_veces bigint,
    apellidos_evaluado text,
    nombres_evaluado text,
    cedula_evaluado integer,
    cod_nomina_evaluado integer,
    fk_cargo_evaluado integer,
    cargo_evaluado character varying(60),
    grado_evaluado integer,
    fk_tipo_clase text,
    oficina_evaluado character varying(90),
    telefono_evaluado character varying(15),
    id_evaluacion integer,
    id_persona_evaluador integer,
    apellidos_evaluador text,
    nombres_evaluador text,
    cedula_evaluador integer,
    cod_nomina_evaluador integer,
    fk_cargo_evaluador integer,
    cargo_evaluador character varying(60),
    grado_evaluador integer,
    oficina_evaluador character varying(90),
    telefono_evaluador character varying(15),
    apellidos_supervisor text,
    nombres_supervisor text,
    cedula_supervisor integer,
    cargo_supervisor character varying(60),
    total_b integer,
    total_c numeric,
    total_final numeric,
    id_comentario integer,
    comentario character varying(1000),
    fecha_evaluacion text,
    esta_conforme text,
    fk_rango_act integer,
    rango_actuacion character varying,
    dep_evaluador_cruge character varying(100)
);


ALTER TABLE evaluacion.vsw_pdf_eval_final OWNER TO postgres;

--
-- Name: vsw_pdf_evaluacion; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_pdf_evaluacion AS
 SELECT pers.id_persona,
    eva.id_evaluacion,
    evados.periodo_desde,
    evados.periodo_hasta,
    pers.apellidos,
    pers.nombres,
    pers.nacionalidad,
    pers.cedula,
    pers.sexo,
    evador.cod_nomina,
    evador.cargo,
    evador.unidad_admtiva,
    vevaldo.telef_oficina,
    eva.obj_funcional,
    per.id_persona AS id_evaluado,
    per.apellidos AS apellidos_evaluado,
    per.nombres AS nombres_evaluado,
    per.nacionalidad AS nacionalidad_evaluado,
    per.cedula AS cedula_evaluado,
    per.sexo AS sexo_evaluado,
    evados.cod_nomina AS cod_nomina_evaluado,
    evados.cargo AS cargo_evaluado,
    per.dependencia AS dep_evaluado,
    evados.ubicacion_admtiva AS oficina_evaluado,
    vevaldo.telef_oficina AS telefono_evaluado,
    est.fk_tipo_entidad AS dependencia,
    est.fk_entidad,
    est.fk_estatus_evaluacion,
    ms.descripcion AS estatus,
    com.id_comentario,
    com.comentario,
    evador.dependencia_cruge AS dep_evaluador_cruge
   FROM (((((((((evaluacion eva
     LEFT JOIN estatus_evaluacion est ON (((est.fk_evaluacion = eva.id_evaluacion) AND (est.created_date = ( SELECT max(est2.created_date) AS max
           FROM estatus_evaluacion est2
          WHERE (est2.fk_evaluacion = est.fk_evaluacion)
          GROUP BY est2.fk_evaluacion)))))
     LEFT JOIN comentarios com ON (((com.fk_evaluacion = eva.id_evaluacion) AND (com.created_date = ( SELECT max(com2.created_date) AS max
           FROM comentarios com2
          WHERE (com2.fk_evaluacion = com.fk_evaluacion)
          GROUP BY com2.fk_evaluacion)))))
     JOIN evaluados evados ON ((evados.id_evaluado = eva.fk_evaluado)))
     JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     JOIN vsw_evaluacion per ON ((per.id_persona = evados.fk_persona)))
     JOIN vsw_evaluacion pers ON ((pers.id_persona = evador.fk_persona)))
     JOIN vsw_evaluacion vevaldo ON ((vevaldo.id_persona = per.id_persona)))
     JOIN vsw_evaluacion vevaldor ON ((vevaldor.id_persona = pers.id_persona)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = est.fk_estatus_evaluacion)))
  GROUP BY eva.id_evaluacion, pers.id_persona, evados.periodo_desde, evados.periodo_hasta, pers.apellidos, pers.nombres, pers.nacionalidad, pers.cedula, pers.sexo, evador.cod_nomina, evador.cargo, evador.unidad_admtiva, evador.dependencia_cruge, vevaldo.telef_oficina, eva.obj_funcional, per.id_persona, per.apellidos, per.nombres, per.nacionalidad, per.cedula, per.sexo, evados.cod_nomina, evados.cargo, per.dependencia, evados.ubicacion_admtiva, est.fk_tipo_entidad, est.fk_entidad, est.fk_estatus_evaluacion, ms.descripcion, com.id_comentario, com.comentario
  ORDER BY eva.id_evaluacion;


ALTER TABLE evaluacion.vsw_pdf_evaluacion OWNER TO postgres;

--
-- Name: vsw_pdf_objetivos; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_pdf_objetivos AS
 SELECT eva.id_evaluacion,
    preg.id_preguntas_ind,
    preg.objetivo,
    preg.peso,
    preg.fk_rango,
    ran.descripcion AS rango,
    preg.subtotal_peso
   FROM ((((evaluacion eva
     JOIN evaluados evados ON ((evados.id_evaluado = eva.fk_evaluado)))
     JOIN vsw_evaluacion per ON ((per.id_persona = evados.fk_persona)))
     JOIN preguntas_individuales preg ON ((preg.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN maestro ran ON ((ran.id_maestro = preg.fk_rango)))
  ORDER BY preg.id_preguntas_ind;


ALTER TABLE evaluacion.vsw_pdf_objetivos OWNER TO postgres;

--
-- Name: vsw_pdf_reporte; Type: VIEW; Schema: evaluacion; Owner: postgres
--

CREATE VIEW vsw_pdf_reporte AS
 SELECT perso.id_persona AS id_persona_evaluado,
    perso.apellidos AS apellidos_evaluado,
    perso.nombres AS nombres_evaluado,
    perso.nacionalidad AS nacionalidad_evaluado,
    perso.cedula AS cedula_evaluado,
    perso.sexo AS sexo_evaluado,
    vevaldo.codigo_nomina AS cod_nomina_evaluado,
    caredos.fk_cargo AS fk_cargo_evaluado,
    caredos.descripcion_cargo AS cargo_evaluado,
    caredos.dependencia AS oficina_evaluado,
    vevaldo.telef_oficina AS telefono_evaluado,
    per.id_persona,
    eva.id_evaluacion,
    evados.fk_periodo,
    peri.descripcion AS periodo_evaluacion,
    per.apellidos,
    per.nombres,
    per.nacionalidad,
    per.cedula,
    per.sexo,
    vevaldor.codigo_nomina,
    caredor.fk_cargo,
    vevaldor.telef_oficina,
    est.fk_estatus_evaluacion,
    ms.descripcion AS estatus,
    count(preg.fk_evaluacion) AS cant_objetivos,
    sum(preg.peso) AS peso_total
   FROM ((((((((((((evaluados evados
     RIGHT JOIN evaluacion eva ON ((evados.id_evaluado = eva.fk_evaluado)))
     RIGHT JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     RIGHT JOIN vsw_evaluacion perso ON (((perso.id_persona = evados.fk_persona) AND (eva.created_date = ( SELECT max(eva2.created_date) AS max
           FROM ((evaluacion eva2
             JOIN evaluados evado2 ON ((evado2.id_evaluado = eva2.fk_evaluado)))
             JOIN vsw_evaluacion pers2 ON ((pers2.id_persona = evado2.fk_persona)))
          WHERE (pers2.id_persona = perso.id_persona)
          GROUP BY pers2.id_persona)))))
     LEFT JOIN vsw_evaluacion per ON ((per.id_persona = evador.fk_persona)))
     LEFT JOIN estatus_evaluacion est ON ((((est.fk_evaluacion = eva.id_evaluacion) AND (est.fk_estatus_evaluacion <> 51)) AND (est.fecha_estatus = ( SELECT max(est2.fecha_estatus) AS max
           FROM estatus_evaluacion est2
          WHERE (est2.fk_evaluacion = est.fk_evaluacion)
          GROUP BY est.fk_evaluacion)))))
     RIGHT JOIN vsw_evaluacion vevaldo ON ((vevaldo.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion vevaldor ON ((vevaldor.id_persona = per.id_persona)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = est.fk_estatus_evaluacion)))
     LEFT JOIN vsw_evaluacion caredos ON ((caredos.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion caredor ON ((caredor.id_persona = per.id_persona)))
     LEFT JOIN preguntas_individuales preg ON ((preg.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN maestro peri ON ((peri.id_maestro = evados.fk_periodo)))
  GROUP BY perso.id_persona, perso.apellidos, perso.nombres, perso.nacionalidad, perso.cedula, perso.sexo, vevaldo.codigo_nomina, caredos.fk_cargo, caredos.descripcion_cargo, caredos.dependencia, vevaldo.telef_oficina, per.id_persona, eva.id_evaluacion, evados.fk_periodo, peri.descripcion, per.apellidos, per.nombres, per.nacionalidad, per.cedula, per.sexo, vevaldor.codigo_nomina, caredor.fk_cargo, vevaldor.telef_oficina, est.fk_estatus_evaluacion, ms.descripcion
  ORDER BY eva.id_evaluacion;


ALTER TABLE evaluacion.vsw_pdf_reporte OWNER TO postgres;

SET search_path = poa, pg_catalog;

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
    es_activo boolean DEFAULT true NOT NULL
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
    ac.meta,
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
   FROM actualizar.dblink('dbname=actualizacion host=localhost user=postgres password=2712'::text, 'SELECT per.id_personal, per.nacionalidad, per.cedula, per.primer_nombre, per.segundo_nombre, per.primer_apellido,
segundo_apellido, per.sexo, car.id_cargo, car.descripcion_cargo, tr.estatus, dep.id_dependencia, dep.nombre, car.grado, car.tipo_cargo, tr.fecha_ingreso
FROM personal per
JOIN trabajador tr on tr.id_personal = per.id_personal
JOIN cargo car on car.id_cargo = tr.id_cargo
JOIN dependencia dep on dep.id_dependencia = tr.id_dependencia
'::text) p(id_personal integer, nacionalidad character varying(1), cedula integer, primer_nombre character varying(20), segundo_nombre character varying(20), primer_apellido character varying(20), segundo_apellido character varying(20), sexo character varying(1), id_cargo integer, descripcion_cargo character varying(60), estatus character varying(1), id_dependencia integer, nombre character varying(90), grado integer, tipo_cargo character varying(1), fecha_ingreso date)
  WHERE ((p.estatus)::text = 'A'::text);


ALTER TABLE poa.vsw_personal OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: cruge_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_user (
    iduser integer NOT NULL,
    regdate bigint,
    actdate bigint,
    logondate bigint,
    username character varying(64),
    email character varying(45),
    password character varying(64),
    authkey character varying(100),
    state integer DEFAULT 0,
    totalsessioncounter integer DEFAULT 0,
    currentsessioncounter integer DEFAULT 0,
    id_persona integer
);


ALTER TABLE public.cruge_user OWNER TO postgres;

SET search_path = poa, pg_catalog;

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

SET search_path = public, pg_catalog;

--
-- Name: cruge_authassignment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_authassignment (
    userid integer NOT NULL,
    bizrule text,
    data text,
    itemname character varying(64) NOT NULL
);


ALTER TABLE public.cruge_authassignment OWNER TO postgres;

--
-- Name: cruge_authitem; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_authitem (
    name character varying(64) NOT NULL,
    type integer NOT NULL,
    description text,
    bizrule text,
    data text
);


ALTER TABLE public.cruge_authitem OWNER TO postgres;

--
-- Name: cruge_authitemchild; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_authitemchild (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


ALTER TABLE public.cruge_authitemchild OWNER TO postgres;

--
-- Name: cruge_field; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_field (
    idfield integer NOT NULL,
    fieldname character varying(20) NOT NULL,
    longname character varying(50),
    "position" integer DEFAULT 0,
    required integer DEFAULT 0,
    fieldtype integer DEFAULT 0,
    fieldsize integer DEFAULT 20,
    maxlength integer DEFAULT 45,
    showinreports integer DEFAULT 0,
    useregexp character varying(512),
    useregexpmsg character varying(512),
    predetvalue character varying(4096)
);


ALTER TABLE public.cruge_field OWNER TO postgres;

--
-- Name: cruge_field_idfield_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cruge_field_idfield_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cruge_field_idfield_seq OWNER TO postgres;

--
-- Name: cruge_field_idfield_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cruge_field_idfield_seq OWNED BY cruge_field.idfield;


--
-- Name: cruge_fieldvalue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_fieldvalue (
    idfieldvalue integer NOT NULL,
    iduser integer NOT NULL,
    idfield integer NOT NULL,
    value character varying(4096)
);


ALTER TABLE public.cruge_fieldvalue OWNER TO postgres;

--
-- Name: cruge_fieldvalue_idfieldvalue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cruge_fieldvalue_idfieldvalue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cruge_fieldvalue_idfieldvalue_seq OWNER TO postgres;

--
-- Name: cruge_fieldvalue_idfieldvalue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cruge_fieldvalue_idfieldvalue_seq OWNED BY cruge_fieldvalue.idfieldvalue;


--
-- Name: cruge_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_session (
    idsession integer NOT NULL,
    iduser integer NOT NULL,
    created bigint,
    expire bigint,
    status integer DEFAULT 0,
    ipaddress character varying(45),
    usagecount integer DEFAULT 0,
    lastusage bigint,
    logoutdate bigint,
    ipaddressout character varying(45)
);


ALTER TABLE public.cruge_session OWNER TO postgres;

--
-- Name: cruge_session_idsession_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cruge_session_idsession_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cruge_session_idsession_seq OWNER TO postgres;

--
-- Name: cruge_session_idsession_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cruge_session_idsession_seq OWNED BY cruge_session.idsession;


--
-- Name: cruge_system; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cruge_system (
    idsystem integer NOT NULL,
    name character varying(45),
    largename character varying(45),
    sessionmaxdurationmins integer DEFAULT 30,
    sessionmaxsameipconnections integer DEFAULT 10,
    sessionreusesessions integer DEFAULT 1,
    sessionmaxsessionsperday integer DEFAULT (-1),
    sessionmaxsessionsperuser integer DEFAULT (-1),
    systemnonewsessions integer DEFAULT 0,
    systemdown integer DEFAULT 0,
    registerusingcaptcha integer DEFAULT 0,
    registerusingterms integer DEFAULT 0,
    terms character varying(4096),
    registerusingactivation integer DEFAULT 1,
    defaultroleforregistration character varying(64),
    registerusingtermslabel character varying(100),
    registrationonlogin integer DEFAULT 1
);


ALTER TABLE public.cruge_system OWNER TO postgres;

--
-- Name: cruge_system_idsystem_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cruge_system_idsystem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cruge_system_idsystem_seq OWNER TO postgres;

--
-- Name: cruge_system_idsystem_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cruge_system_idsystem_seq OWNED BY cruge_system.idsystem;


--
-- Name: cruge_user_iduser_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cruge_user_iduser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cruge_user_iduser_seq OWNER TO postgres;

--
-- Name: cruge_user_iduser_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cruge_user_iduser_seq OWNED BY cruge_user.iduser;


--
-- Name: maestro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE maestro (
    id_maestro integer NOT NULL,
    descripcion character varying,
    padre integer,
    hijo integer,
    es_activo boolean DEFAULT true,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now(),
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now(),
    descripcion2 character varying
);


ALTER TABLE public.maestro OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE maestro_id_maestro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maestro_id_maestro_seq OWNER TO postgres;

--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE maestro_id_maestro_seq OWNED BY maestro.id_maestro;


SET search_path = requisicion, pg_catalog;

--
-- Name: datos_requisicion; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE datos_requisicion (
    id_datos_requisicion integer NOT NULL,
    fk_tipo_requisicion integer,
    anio_requisicion integer,
    fk_unidad_ejecutora integer,
    ubicacion_geografica character varying(150),
    fk_parroquia integer,
    ciudad character varying,
    fk_fuente_financia integer,
    es_anulacion boolean DEFAULT false,
    es_activo boolean,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now(),
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE requisicion.datos_requisicion OWNER TO postgres;

--
-- Name: datos_requisicion_id_datos_requisicion_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE datos_requisicion_id_datos_requisicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.datos_requisicion_id_datos_requisicion_seq OWNER TO postgres;

--
-- Name: datos_requisicion_id_datos_requisicion_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE datos_requisicion_id_datos_requisicion_seq OWNED BY datos_requisicion.id_datos_requisicion;


--
-- Name: imputacion_presupuestaria_ac; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE imputacion_presupuestaria_ac (
    id_imp_presupuestaria_ac integer NOT NULL,
    fk_datos_requisicion integer,
    fk_accion_centralizada integer,
    fk_clasificacion_presupuestaria integer,
    descripcion character varying(150),
    fk_unidad_medida integer,
    cantidad integer,
    es_activo boolean,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE requisicion.imputacion_presupuestaria_ac OWNER TO postgres;

--
-- Name: imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq OWNER TO postgres;

--
-- Name: imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq OWNED BY imputacion_presupuestaria_ac.id_imp_presupuestaria_ac;


--
-- Name: imputacion_presupuestaria_ue; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE imputacion_presupuestaria_ue (
    id_imputacion_presupuestaria integer NOT NULL,
    fk_datos_requisicion integer,
    fk_unidad_ejecutora integer,
    fk_proyecto integer,
    fk_accion_especifica integer,
    fk_clasificacion_presupuestaria integer,
    descripcion character varying,
    fk_unidad_medida integer,
    cantidad integer,
    es_activo boolean,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now(),
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE requisicion.imputacion_presupuestaria_ue OWNER TO postgres;

--
-- Name: imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq OWNER TO postgres;

--
-- Name: imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq OWNED BY imputacion_presupuestaria_ue.id_imputacion_presupuestaria;


--
-- Name: lugar_entrega; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE lugar_entrega (
    id_lugar_entrega integer NOT NULL,
    fk_datos_requisicion integer,
    dependencia character varying(100),
    direccion character varying(150),
    es_almacen boolean DEFAULT false,
    fecha_estimada_requerida timestamp without time zone NOT NULL,
    es_activo boolean NOT NULL,
    created_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_estatus integer
);


ALTER TABLE requisicion.lugar_entrega OWNER TO postgres;

--
-- Name: lugar_entrega_id_lugar_entrega_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE lugar_entrega_id_lugar_entrega_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.lugar_entrega_id_lugar_entrega_seq OWNER TO postgres;

--
-- Name: lugar_entrega_id_lugar_entrega_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE lugar_entrega_id_lugar_entrega_seq OWNED BY lugar_entrega.id_lugar_entrega;


--
-- Name: numero_requisicion_unidad; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE numero_requisicion_unidad (
    id_n_requisicion integer NOT NULL,
    fk_datos_requisicion integer,
    numero character varying(14),
    es_activo boolean,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now(),
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE requisicion.numero_requisicion_unidad OWNER TO postgres;

--
-- Name: numero_requisicion_unidad_id_n_requisicion_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE numero_requisicion_unidad_id_n_requisicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.numero_requisicion_unidad_id_n_requisicion_seq OWNER TO postgres;

--
-- Name: numero_requisicion_unidad_id_n_requisicion_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE numero_requisicion_unidad_id_n_requisicion_seq OWNED BY numero_requisicion_unidad.id_n_requisicion;


--
-- Name: observacion; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE observacion (
    id_observacion integer NOT NULL,
    id_entidad integer,
    fk_entidad integer,
    observacion character varying(180),
    es_activo boolean,
    fk_estatus integer,
    created_by integer,
    created_date timestamp without time zone DEFAULT now(),
    modified_by integer,
    modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE requisicion.observacion OWNER TO postgres;

--
-- Name: observacion_id_observacion_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE observacion_id_observacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.observacion_id_observacion_seq OWNER TO postgres;

--
-- Name: observacion_id_observacion_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE observacion_id_observacion_seq OWNED BY observacion.id_observacion;


--
-- Name: pedido; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE pedido (
    id_pedido integer NOT NULL,
    fk_descripcion integer NOT NULL,
    cantidad integer,
    fk_datos_requisicion integer,
    unid_medida integer,
    created_by integer NOT NULL,
    modified_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_estatus integer NOT NULL,
    es_activo boolean
);


ALTER TABLE requisicion.pedido OWNER TO postgres;

--
-- Name: pedido_especial; Type: TABLE; Schema: requisicion; Owner: postgres; Tablespace: 
--

CREATE TABLE pedido_especial (
    id_ped_especial integer NOT NULL,
    descripcion character varying(100),
    cantidad integer,
    fk_datos_requisicion integer,
    unid_medida integer,
    created_by integer NOT NULL,
    modified_by integer,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    fk_estatus integer NOT NULL,
    es_activo boolean NOT NULL
);


ALTER TABLE requisicion.pedido_especial OWNER TO postgres;

--
-- Name: pedido_especial_id_ped_especial_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE pedido_especial_id_ped_especial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.pedido_especial_id_ped_especial_seq OWNER TO postgres;

--
-- Name: pedido_especial_id_ped_especial_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE pedido_especial_id_ped_especial_seq OWNED BY pedido_especial.id_ped_especial;


--
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: requisicion; Owner: postgres
--

CREATE SEQUENCE pedido_id_pedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE requisicion.pedido_id_pedido_seq OWNER TO postgres;

--
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: requisicion; Owner: postgres
--

ALTER SEQUENCE pedido_id_pedido_seq OWNED BY pedido.id_pedido;


SET search_path = actualizar, pg_catalog;

--
-- Name: id_historico; Type: DEFAULT; Schema: actualizar; Owner: postgres
--

ALTER TABLE ONLY historico ALTER COLUMN id_historico SET DEFAULT nextval('historico_id_historico_seq'::regclass);


--
-- Name: id_traza; Type: DEFAULT; Schema: actualizar; Owner: postgres
--

ALTER TABLE ONLY traza ALTER COLUMN id_traza SET DEFAULT nextval('traza_id_traza_seq'::regclass);


SET search_path = evaluacion, pg_catalog;

--
-- Name: id_comentario; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY comentarios ALTER COLUMN id_comentario SET DEFAULT nextval('comentarios_id_comentario_seq'::regclass);


--
-- Name: id_estatus_evaluacion; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion ALTER COLUMN id_estatus_evaluacion SET DEFAULT nextval('estatus_evaluacion_id_estatus_evaluacion_seq'::regclass);


--
-- Name: id_evaluacion; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluacion ALTER COLUMN id_evaluacion SET DEFAULT nextval('evaluacion_id_evaluacion_seq'::regclass);


--
-- Name: id_evaluador; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluador ALTER COLUMN id_evaluador SET DEFAULT nextval('evaluador_id_evaluador_seq'::regclass);


--
-- Name: id_evaluado; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluados ALTER COLUMN id_evaluado SET DEFAULT nextval('evaluados_id_evaluado_seq'::regclass);


--
-- Name: id_maestro; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY maestro ALTER COLUMN id_maestro SET DEFAULT nextval('maestro_id_maestro_seq'::regclass);


--
-- Name: id_pregunta; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas ALTER COLUMN id_pregunta SET DEFAULT nextval('preguntas_id_pregunta_seq'::regclass);


--
-- Name: id_preguntas_colect; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas ALTER COLUMN id_preguntas_colect SET DEFAULT nextval('preguntas_colectivas_id_preguntas_colect_seq'::regclass);


--
-- Name: id_preguntas_ind; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_individuales ALTER COLUMN id_preguntas_ind SET DEFAULT nextval('preguntas_individuales_id_preguntas_ind_seq'::regclass);


--
-- Name: id_preguntas_obr; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_obrero ALTER COLUMN id_preguntas_obr SET DEFAULT nextval('preguntas_obrero_id_preguntas_obr_seq'::regclass);


--
-- Name: id_revision; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY revision ALTER COLUMN id_revision SET DEFAULT nextval('revision_id_revision_seq'::regclass);


--
-- Name: id_supervisor; Type: DEFAULT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY supervisor ALTER COLUMN id_supervisor SET DEFAULT nextval('supervisor_id_supervisor_seq'::regclass);


SET search_path = poa, pg_catalog;

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


SET search_path = public, pg_catalog;

--
-- Name: idfield; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_field ALTER COLUMN idfield SET DEFAULT nextval('cruge_field_idfield_seq'::regclass);


--
-- Name: idfieldvalue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_fieldvalue ALTER COLUMN idfieldvalue SET DEFAULT nextval('cruge_fieldvalue_idfieldvalue_seq'::regclass);


--
-- Name: idsession; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_session ALTER COLUMN idsession SET DEFAULT nextval('cruge_session_idsession_seq'::regclass);


--
-- Name: idsystem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_system ALTER COLUMN idsystem SET DEFAULT nextval('cruge_system_idsystem_seq'::regclass);


--
-- Name: iduser; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_user ALTER COLUMN iduser SET DEFAULT nextval('cruge_user_iduser_seq'::regclass);


--
-- Name: id_maestro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maestro ALTER COLUMN id_maestro SET DEFAULT nextval('maestro_id_maestro_seq'::regclass);


SET search_path = requisicion, pg_catalog;

--
-- Name: id_datos_requisicion; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY datos_requisicion ALTER COLUMN id_datos_requisicion SET DEFAULT nextval('datos_requisicion_id_datos_requisicion_seq'::regclass);


--
-- Name: id_imp_presupuestaria_ac; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac ALTER COLUMN id_imp_presupuestaria_ac SET DEFAULT nextval('imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq'::regclass);


--
-- Name: id_imputacion_presupuestaria; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue ALTER COLUMN id_imputacion_presupuestaria SET DEFAULT nextval('imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq'::regclass);


--
-- Name: id_lugar_entrega; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY lugar_entrega ALTER COLUMN id_lugar_entrega SET DEFAULT nextval('lugar_entrega_id_lugar_entrega_seq'::regclass);


--
-- Name: id_n_requisicion; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY numero_requisicion_unidad ALTER COLUMN id_n_requisicion SET DEFAULT nextval('numero_requisicion_unidad_id_n_requisicion_seq'::regclass);


--
-- Name: id_observacion; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY observacion ALTER COLUMN id_observacion SET DEFAULT nextval('observacion_id_observacion_seq'::regclass);


--
-- Name: id_pedido; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido ALTER COLUMN id_pedido SET DEFAULT nextval('pedido_id_pedido_seq'::regclass);


--
-- Name: id_ped_especial; Type: DEFAULT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido_especial ALTER COLUMN id_ped_especial SET DEFAULT nextval('pedido_especial_id_ped_especial_seq'::regclass);


SET search_path = actualizar, pg_catalog;

--
-- Data for Name: historico; Type: TABLE DATA; Schema: actualizar; Owner: postgres
--

COPY historico (id_historico, id_personal, id_usuario, se_activa_1, se_activa_2, se_activa_3, created_date) FROM stdin;
1	3497	19	f	f	f	2015-07-02 11:29:05.625639
2	3916	15	f	f	f	2015-07-02 11:30:27.528891
3	606	14	f	f	f	2015-07-02 11:34:43.789866
119	2511	151	f	f	f	2015-08-06 14:05:22.474556
120	3461	175	f	f	f	2015-08-06 14:14:43.507404
7	3446	25	f	f	f	2015-07-16 09:18:35.451188
8	1127	29	f	f	f	2015-07-20 08:43:20.777658
9	4293	33	f	f	f	2015-07-20 10:02:15.659307
11	4338	30	f	f	f	2015-07-21 09:17:17.123299
121	3411	152	f	f	f	2015-08-06 14:39:14.472207
122	657	165	f	f	f	2015-08-06 14:49:40.193341
10	1654	31	f	f	f	2015-07-20 10:54:27.463123
123	2268	26	f	f	f	2015-08-06 14:51:27.673051
141	649	9	f	f	f	2015-08-07 15:39:30.90915
12	3662	32	f	f	f	2015-07-21 09:20:45.482305
13	4176	34	f	f	f	2015-07-21 13:51:21.882035
14	2549	39	f	f	f	2015-07-22 11:36:57.894721
15	3580	38	f	f	f	2015-07-22 11:42:24.081381
16	1229	41	f	f	f	2015-07-22 15:19:21.37248
17	568	42	f	f	f	2015-07-22 15:43:01.527599
18	2702	43	f	f	f	2015-07-23 09:19:45.338611
19	3873	47	f	f	f	2015-07-28 08:58:13.422684
20	1392	46	f	f	f	2015-07-28 09:11:43.667211
21	665	50	f	f	f	2015-07-28 09:15:44.586793
22	4257	51	f	f	f	2015-07-28 09:17:04.57904
23	4032	52	f	f	f	2015-07-28 09:28:12.188738
24	2828	53	f	f	f	2015-07-28 09:48:25.307492
25	651	54	f	f	f	2015-07-28 10:45:03.072038
26	3693	55	f	f	f	2015-07-28 10:57:37.824575
27	654	36	f	f	f	2015-07-28 11:07:05.873961
124	4038	20	f	f	f	2015-08-06 14:58:54.063736
125	2504	148	f	f	f	2015-08-06 15:08:07.096636
126	4324	160	f	f	f	2015-08-06 15:17:57.833404
127	2795	150	f	f	f	2015-08-06 15:29:05.886323
128	2808	176	f	f	f	2015-08-06 15:35:23.515509
129	2806	146	f	f	f	2015-08-06 16:53:14.331351
130	4513	136	f	f	f	2015-08-07 09:27:46.575392
131	4432	177	f	f	f	2015-08-07 10:09:50.895763
132	4191	178	f	f	f	2015-08-07 10:17:05.126051
133	4351	179	f	f	f	2015-08-07 10:27:49.751892
28	625	48	f	f	f	2015-07-28 12:59:50.112063
29	3163	49	f	f	f	2015-07-28 13:15:53.278925
30	1050	57	f	f	f	2015-07-29 08:58:10.834161
31	1134	61	f	f	f	2015-07-29 09:08:21.944822
33	3584	69	f	f	f	2015-07-29 10:02:25.120388
34	3444	56	f	f	f	2015-07-29 10:54:17.898453
35	3252	59	f	f	f	2015-07-29 11:04:14.306752
36	3798	72	f	f	f	2015-07-29 11:13:14.85995
37	2235	74	f	f	f	2015-07-29 11:14:46.1677
38	595	71	f	f	f	2015-07-29 11:21:35.167899
39	3561	76	f	f	f	2015-07-29 11:36:29.480327
40	3804	77	f	f	f	2015-07-29 12:25:49.395359
134	4525	168	f	f	f	2015-08-07 10:34:22.816038
5	3918	4	f	t	f	2015-07-14 16:09:17.750481
41	3484	78	f	f	f	2015-07-29 13:31:00.570698
42	3572	64	f	f	f	2015-07-29 15:36:35.526397
43	1133	83	f	f	f	2015-07-30 08:51:33.341572
44	3245	82	f	f	f	2015-07-30 09:51:20.75993
45	1183	85	f	f	f	2015-07-30 10:34:26.406113
46	3589	84	f	f	f	2015-07-30 10:36:41.298883
47	588	87	f	f	f	2015-07-30 11:27:46.864831
48	1186	89	f	f	f	2015-07-30 11:33:05.781023
49	532	88	f	f	f	2015-07-30 11:33:35.74531
50	1218	86	f	f	f	2015-07-30 11:54:36.240424
51	3758	91	f	f	f	2015-07-30 13:28:19.432744
52	2267	92	f	f	f	2015-07-30 13:40:28.672241
53	3657	97	f	f	f	2015-07-30 13:50:21.427746
54	1573	79	f	f	f	2015-07-30 13:53:33.540787
55	1571	96	f	f	f	2015-07-30 13:55:43.193963
56	3984	80	f	f	f	2015-07-30 14:04:06.15453
57	1137	98	f	f	f	2015-07-30 14:05:58.187178
58	2517	99	f	f	f	2015-07-30 14:29:41.185417
59	2266	101	f	f	f	2015-07-30 15:49:07.221631
60	2649	68	f	f	f	2015-07-30 16:06:26.289092
61	4314	60	f	f	f	2015-07-31 07:54:59.179845
62	4325	102	f	f	f	2015-07-31 08:16:22.632561
63	590	103	f	f	f	2015-07-31 08:31:34.608645
64	1587	75	f	f	f	2015-07-31 08:40:11.202666
65	3753	104	f	f	f	2015-07-31 09:29:22.233526
66	4433	105	f	f	f	2015-07-31 10:05:04.608476
67	1658	109	f	f	f	2015-07-31 13:48:09.230211
68	3993	63	f	f	f	2015-07-31 14:36:13.480452
70	2232	65	f	f	f	2015-07-31 15:26:27.344396
71	535	107	f	f	f	2015-07-31 15:31:46.97163
135	2506	163	f	f	f	2015-08-07 10:45:12.977795
69	3903	113	f	f	f	2015-07-31 15:25:13.87354
72	4315	115	f	f	f	2015-07-31 15:57:19.69073
73	3797	116	f	f	f	2015-07-31 16:18:33.390449
74	2648	117	f	f	f	2015-07-31 16:39:26.585861
75	2781	118	f	f	f	2015-07-31 17:02:18.10367
76	4436	120	f	f	f	2015-07-31 17:45:16.324342
77	603	119	f	f	f	2015-07-31 18:54:46.189678
78	3441	123	f	f	f	2015-07-31 20:14:49.135973
79	3251	121	f	f	f	2015-07-31 21:12:57.575302
80	1120	124	f	f	f	2015-08-03 07:44:06.494359
81	1138	125	f	f	f	2015-08-03 07:53:36.520716
82	2941	126	f	f	f	2015-08-03 08:17:35.064902
83	2245	127	f	f	f	2015-08-03 11:27:07.377534
85	3412	132	f	f	f	2015-08-04 08:46:01.122244
87	3837	129	f	f	f	2015-08-05 07:23:54.018727
88	2803	95	f	f	f	2015-08-05 09:04:09.41073
89	4440	144	f	f	f	2015-08-05 11:00:38.322594
90	647	22	f	f	f	2015-08-05 11:08:23.087245
91	4156	141	f	f	f	2015-08-05 11:09:04.982983
92	4152	140	f	f	f	2015-08-05 11:09:17.459112
93	4355	145	f	f	f	2015-08-05 11:09:47.733871
94	4154	142	f	f	f	2015-08-05 11:14:49.693326
95	1140	143	f	f	f	2015-08-05 11:20:12.542896
96	3905	149	f	f	f	2015-08-05 11:35:58.899875
97	4155	153	f	f	f	2015-08-05 11:45:32.596203
98	4437	156	f	f	f	2015-08-05 12:12:18.63985
99	2505	147	f	f	f	2015-08-05 12:50:30.306478
100	3659	158	f	f	f	2015-08-05 13:38:22.511054
101	2269	137	f	f	f	2015-08-05 13:44:04.314633
136	4000	138	f	f	f	2015-08-07 10:54:40.857061
86	4105	128	f	f	f	2015-08-04 21:53:23.05802
102	2512	70	f	f	f	2015-08-05 14:14:41.233239
103	594	100	f	f	f	2015-08-05 14:17:13.857819
104	4303	94	f	f	f	2015-08-05 14:31:53.268504
105	4431	45	f	f	f	2015-08-05 14:34:11.791497
106	1189	162	f	f	f	2015-08-05 14:42:20.913035
107	4298	130	f	f	f	2015-08-05 14:52:40.783984
108	4157	155	f	f	f	2015-08-05 15:26:35.417521
109	2763	166	f	f	f	2015-08-05 15:36:14.889566
110	3581	110	f	f	f	2015-08-06 08:27:48.192699
111	659	170	f	f	f	2015-08-06 11:43:49.214186
112	3417	171	f	f	f	2015-08-06 13:09:49.182797
113	2811	169	f	f	f	2015-08-06 13:30:30.408147
114	1191	131	f	f	f	2015-08-06 13:39:18.241813
115	4252	174	f	f	f	2015-08-06 13:54:04.017723
116	3793	173	f	f	f	2015-08-06 14:00:14.797109
117	4253	157	f	f	f	2015-08-06 14:01:53.083274
118	4192	172	f	f	f	2015-08-06 14:05:17.098251
137	4165	180	f	f	f	2015-08-07 11:08:01.249281
138	3004	112	f	f	f	2015-08-07 11:54:51.085697
139	3831	181	f	f	f	2015-08-07 14:12:37.686689
140	2820	182	f	f	f	2015-08-07 14:12:38.731994
6	2522	27	f	f	f	2015-07-16 09:17:49.467585
143	3756	183	f	f	f	2015-08-07 16:58:10.753221
144	804	187	f	f	f	2015-08-10 11:52:22.707873
146	1047	188	f	f	f	2015-08-10 12:09:32.103899
147	2652	190	f	f	f	2015-08-10 14:01:51.184459
150	2693	159	f	f	f	2015-08-10 19:50:55.717769
151	3652	134	f	f	f	2015-08-11 09:29:14.491694
145	805	186	t	t	t	2015-08-10 11:53:08.388144
84	3496	10	t	f	f	2015-08-03 15:30:52.365453
153	3494	197	f	f	f	2015-08-11 10:06:37.803992
154	3449	194	f	f	f	2015-08-11 10:16:04.480309
152	3796	195	f	f	f	2015-08-11 09:59:58.156857
155	3655	196	f	f	f	2015-08-11 10:31:16.500786
32	2322	67	f	f	f	2015-07-29 09:58:18.480298
156	3588	198	f	f	f	2015-08-11 10:35:58.525494
149	1504	191	f	f	f	2015-08-10 15:49:14.830535
4	1401	11	f	f	f	2015-07-02 11:35:29.444574
142	2643	21	f	f	f	2015-08-07 16:02:37.635996
278	898	303	f	f	f	2015-08-14 20:30:01.40327
279	4423	348	f	f	f	2015-08-14 21:24:33.742561
280	3931	349	f	f	f	2015-08-14 22:00:16.881647
281	2011	226	f	f	f	2015-08-14 22:13:13.073577
282	902	350	f	f	f	2015-08-14 23:23:05.04154
283	4131	292	f	f	f	2015-08-15 15:03:11.270894
148	573	189	f	f	f	2015-08-10 14:05:31.69464
157	1471	185	f	f	f	2015-08-11 11:47:08.050225
158	574	199	f	f	f	2015-08-11 14:24:14.743139
284	4135	326	f	f	f	2015-08-16 20:15:12.534005
286	694	208	f	f	f	2015-08-17 08:52:20.272201
287	794	356	f	f	f	2015-08-17 09:01:21.694638
160	3643	202	f	f	f	2015-08-12 09:02:43.598799
159	2238	201	f	f	f	2015-08-12 07:40:49.990581
161	4137	204	f	f	f	2015-08-12 09:58:40.152305
162	3823	209	f	f	f	2015-08-12 11:30:55.205818
163	4254	210	f	f	f	2015-08-12 11:49:18.400313
164	3892	211	f	f	f	2015-08-12 11:50:59.647216
165	4321	213	f	f	f	2015-08-12 12:52:51.849825
166	1721	214	f	f	f	2015-08-12 13:19:56.002203
167	2525	184	f	f	f	2015-08-12 13:24:59.999251
168	3171	212	f	f	f	2015-08-12 13:46:30.987144
169	774	216	f	f	f	2015-08-12 13:55:20.339303
170	675	218	f	f	f	2015-08-12 14:25:49.63241
171	3656	207	f	f	f	2015-08-12 14:33:08.300647
172	826	219	f	f	f	2015-08-12 14:39:49.795189
173	2247	90	f	f	f	2015-08-12 14:46:32.32229
174	4256	221	f	f	f	2015-08-12 15:10:23.049263
175	1100	222	f	f	f	2015-08-12 15:12:17.986779
176	1741	225	f	f	f	2015-08-12 15:30:57.49052
177	1733	224	f	f	f	2015-08-12 15:37:55.305313
288	643	58	f	f	f	2015-08-17 09:50:25.559748
289	1406	16	f	f	f	2015-08-17 10:08:49.836993
179	4322	229	f	f	f	2015-08-12 16:17:15.300348
180	3826	231	f	f	f	2015-08-12 19:25:46.396037
181	912	233	f	f	f	2015-08-12 20:17:39.199526
182	4532	235	f	f	f	2015-08-12 21:42:16.042158
183	899	234	f	f	f	2015-08-12 22:19:20.24976
184	3338	236	f	f	f	2015-08-13 00:07:47.651372
185	696	237	f	f	f	2015-08-13 06:54:45.230657
186	824	241	f	f	f	2015-08-13 09:00:50.437052
187	687	240	f	f	f	2015-08-13 09:17:08.661743
188	3573	246	f	f	f	2015-08-13 09:36:33.514561
189	4122	249	f	f	f	2015-08-13 09:47:10.854069
190	821	245	f	f	f	2015-08-13 09:49:56.123599
191	759	248	f	f	f	2015-08-13 09:53:44.427416
192	817	247	f	f	f	2015-08-13 09:58:03.837457
193	820	220	f	f	f	2015-08-13 10:12:31.106642
194	819	252	f	f	f	2015-08-13 10:15:34.778284
195	834	251	f	f	f	2015-08-13 10:18:07.238386
196	751	253	f	f	f	2015-08-13 10:23:41.463135
197	757	257	f	f	f	2015-08-13 10:54:28.846152
198	872	254	f	f	f	2015-08-13 11:08:37.572338
199	876	260	f	f	f	2015-08-13 11:33:03.484384
200	752	223	f	f	f	2015-08-13 11:50:42.614033
201	723	258	f	f	f	2015-08-13 11:52:26.742123
202	3992	261	f	f	f	2015-08-13 12:33:03.257046
290	2699	358	f	f	f	2015-08-17 10:10:35.437877
291	861	357	f	f	f	2015-08-17 10:29:49.517034
294	768	343	f	f	f	2015-08-17 14:02:24.886611
295	4425	361	f	f	f	2015-08-17 14:29:09.470459
203	789	265	f	f	f	2015-08-13 12:58:15.486308
178	2889	23	f	f	f	2015-08-12 16:05:24.213407
204	782	270	f	f	f	2015-08-13 13:23:32.507773
205	1058	267	f	f	f	2015-08-13 13:40:05.401294
206	783	272	f	f	f	2015-08-13 13:48:46.678715
207	2351	192	f	f	f	2015-08-13 14:06:43.980911
208	3187	264	f	f	f	2015-08-13 14:13:43.686162
209	1187	275	f	f	f	2015-08-13 14:35:37.045696
210	3962	274	f	f	f	2015-08-13 14:40:21.866013
211	1473	239	f	f	f	2015-08-13 14:41:07.282901
212	4125	276	f	f	f	2015-08-13 14:46:58.954744
213	838	278	f	f	f	2015-08-13 15:05:25.298636
214	1220	279	f	f	f	2015-08-13 15:40:47.418727
215	1219	281	f	f	f	2015-08-13 15:56:59.542608
216	836	266	f	f	f	2015-08-13 17:04:03.772686
217	786	283	f	f	f	2015-08-13 18:04:58.69891
218	4335	284	f	f	f	2015-08-13 18:48:06.460493
219	4134	285	f	f	f	2015-08-13 18:51:29.545276
220	4124	273	f	f	f	2015-08-13 19:28:18.740775
221	753	286	f	f	f	2015-08-13 20:55:35.169688
222	653	291	f	f	f	2015-08-13 21:09:19.84197
223	662	293	f	f	f	2015-08-13 21:27:16.175529
224	941	262	f	f	f	2015-08-13 21:32:16.46306
225	750	250	f	f	f	2015-08-13 21:37:22.652689
226	734	294	f	f	f	2015-08-13 22:17:06.691988
227	729	268	f	f	f	2015-08-14 06:32:52.635304
228	2543	242	f	f	f	2015-08-14 09:08:37.394024
229	727	298	f	f	f	2015-08-14 09:08:48.426113
230	869	301	f	f	f	2015-08-14 09:45:16.758362
231	823	217	f	f	f	2015-08-14 09:46:16.895957
232	868	304	f	f	f	2015-08-14 09:55:41.64817
233	983	297	f	f	f	2015-08-14 10:01:06.883271
234	4121	295	f	f	f	2015-08-14 10:36:48.79342
235	910	306	f	f	f	2015-08-14 10:43:23.889137
236	795	300	f	f	f	2015-08-14 10:49:25.371479
237	911	312	f	f	f	2015-08-14 11:01:16.257498
238	3987	256	f	f	f	2015-08-14 11:05:26.504915
239	3794	313	f	f	f	2015-08-14 11:19:00.985322
240	928	311	f	f	f	2015-08-14 11:19:08.689707
241	800	309	f	f	f	2015-08-14 11:20:42.675275
242	906	243	f	f	f	2015-08-14 11:29:12.038249
243	791	310	f	f	f	2015-08-14 11:38:17.328686
244	617	314	f	f	f	2015-08-14 11:38:57.939855
245	914	315	f	f	f	2015-08-14 11:57:34.646619
246	913	308	f	f	f	2015-08-14 11:59:20.358682
247	796	318	f	f	f	2015-08-14 12:01:30.518501
248	901	296	f	f	f	2015-08-14 12:04:41.210271
249	909	317	f	f	f	2015-08-14 12:20:53.657405
250	756	232	f	f	f	2015-08-14 12:41:31.163482
251	766	290	f	f	f	2015-08-14 12:53:15.318827
252	735	322	f	f	f	2015-08-14 13:18:22.185101
253	4181	299	f	f	f	2015-08-14 13:26:43.952186
254	871	327	f	f	f	2015-08-14 13:47:59.492006
255	818	325	f	f	f	2015-08-14 13:49:04.729041
256	2001	329	f	f	f	2015-08-14 14:15:33.840596
257	944	307	f	f	f	2015-08-14 14:27:18.000796
258	816	305	f	f	f	2015-08-14 15:00:04.186452
259	3240	335	f	f	f	2015-08-14 15:16:13.582801
260	952	332	f	f	f	2015-08-14 15:38:53.502099
261	798	336	f	f	f	2015-08-14 15:50:07.150696
262	758	333	f	f	f	2015-08-14 15:58:53.787334
263	761	319	f	f	f	2015-08-14 16:04:14.077652
264	3985	339	f	f	f	2015-08-14 16:07:53.293214
265	4271	323	f	f	f	2015-08-14 16:12:46.284843
266	3333	324	f	f	f	2015-08-14 16:17:57.503372
267	754	280	f	f	f	2015-08-14 16:18:26.428878
268	946	337	f	f	f	2015-08-14 16:24:01.423833
269	959	341	f	f	f	2015-08-14 16:53:45.531264
270	877	330	f	f	f	2015-08-14 16:56:45.708463
271	958	302	f	f	f	2015-08-14 17:00:22.719337
272	780	340	f	f	f	2015-08-14 17:03:28.260961
273	799	282	f	f	f	2015-08-14 17:31:55.865146
274	4123	320	f	f	f	2015-08-14 17:44:02.709325
275	4141	342	f	f	f	2015-08-14 17:52:34.749427
276	900	344	f	f	f	2015-08-14 19:06:56.082535
277	4422	345	f	f	f	2015-08-14 19:35:16.010737
292	4277	359	f	f	f	2015-08-17 10:51:41.084289
293	864	360	f	f	f	2015-08-17 12:02:24.447077
285	951	353	f	f	f	2015-08-16 22:36:16.812589
296	920	338	f	f	f	2015-08-17 14:46:03.47851
297	4022	362	f	f	f	2015-08-17 15:14:23.855983
298	646	17	f	f	f	2015-08-18 09:36:16.509009
299	4260	366	f	f	f	2015-08-18 10:09:08.248612
300	660	367	f	f	f	2015-08-18 10:10:45.913117
302	4103	355	f	f	f	2015-08-18 10:28:07.045228
303	812	370	f	f	f	2015-08-18 12:53:25.002501
304	926	371	f	f	f	2015-08-18 14:55:52.507566
305	830	363	f	f	f	2015-08-18 14:59:03.608232
306	842	372	f	f	f	2015-08-18 20:29:24.272118
307	744	373	f	f	f	2015-08-19 07:31:28.389516
308	3855	375	f	f	f	2015-08-19 12:05:46.07414
309	2791	377	f	f	f	2015-08-19 12:15:26.275714
310	919	368	f	f	f	2015-08-19 13:49:23.241275
311	3802	28	f	f	f	2015-08-19 13:55:10.970342
312	4090	378	f	f	f	2015-08-19 14:01:42.681342
313	918	379	f	f	f	2015-08-19 15:29:18.745414
314	927	380	f	f	f	2015-08-19 15:44:47.726113
315	1493	382	f	f	f	2015-08-19 16:54:53.926021
316	2825	384	f	f	f	2015-08-20 08:57:29.3781
301	948	365	f	f	f	2015-08-18 10:13:28.473925
317	4472	24	f	f	f	2015-08-21 15:36:02.781955
318	950	387	f	f	f	2015-08-21 17:19:08.7311
319	922	386	f	f	f	2015-08-24 07:55:46.774907
320	2363	388	f	f	f	2015-08-25 14:54:25.554743
321	3854	161	f	f	f	2015-08-28 09:26:36.200032
322	3982	391	f	f	f	2015-08-29 16:25:09.19026
323	3893	390	f	f	f	2015-08-29 16:25:41.901756
324	3994	393	f	f	f	2015-08-31 11:47:35.200292
325	3821	394	f	f	f	2015-08-31 12:24:18.82366
326	2807	395	f	f	f	2015-08-31 15:41:36.095317
327	3853	396	f	f	f	2015-09-01 08:48:28.767318
328	3822	397	f	f	f	2015-09-01 09:25:37.800803
329	2201	398	f	f	f	2015-09-01 09:43:33.445471
330	3184	401	f	f	f	2015-09-01 10:37:48.931506
331	3801	40	f	f	f	2015-09-01 10:41:58.633535
332	3492	402	f	f	f	2015-09-01 11:06:23.140604
333	971	37	f	f	f	2015-09-01 11:19:14.359426
334	4273	389	f	f	f	2015-09-01 11:32:41.346195
335	3868	403	f	f	f	2015-09-01 11:39:07.087309
336	1387	122	f	f	f	2015-09-01 11:51:16.066327
337	692	215	f	f	f	2015-09-01 13:57:23.543696
338	2163	206	f	f	f	2015-09-02 10:59:28.848448
339	4527	404	f	f	f	2015-09-02 13:21:17.974436
340	3805	406	f	f	f	2015-09-03 11:44:45.779295
341	4305	407	f	f	f	2015-09-04 10:34:55.759209
342	2531	409	f	f	f	2015-09-07 10:56:18.11644
343	616	139	f	f	f	2015-09-07 10:59:10.270602
344	3481	106	f	f	f	2015-09-07 13:40:06.808366
345	3864	411	f	f	f	2015-09-08 14:38:59.596511
346	2143	412	f	f	f	2015-09-10 11:05:33.16871
347	1045	376	f	f	f	2015-09-14 08:58:14.524037
348	1105	385	f	f	f	2015-09-14 09:07:50.984348
349	1710	413	f	f	f	2015-09-18 13:30:14.912668
350	609	164	f	f	f	2015-09-21 08:55:03.76555
351	658	392	f	f	f	2015-09-21 14:45:10.273515
352	841	414	f	f	f	2015-09-29 16:47:36.045126
353	4542	415	f	f	f	2015-09-30 13:02:16.105501
354	2342	416	f	f	f	2015-10-01 10:33:51.80748
355	844	383	f	f	f	2015-10-02 10:22:29.819099
356	1961	417	f	f	f	2015-10-07 15:30:05.062503
357	2211	203	f	f	f	2015-10-08 14:51:33.184592
358	2364	418	f	f	f	2015-10-09 14:30:44.764866
359	4332	421	f	f	f	2015-10-13 12:20:30.358779
360	526	111	f	f	f	2015-10-13 13:05:29.072165
361	2254	422	f	f	f	2015-10-13 13:45:36.178634
362	540	419	f	f	f	2015-10-13 14:02:59.317021
363	4166	426	f	f	f	2015-10-14 15:13:10.998379
364	4112	425	f	f	f	2015-10-14 15:13:38.241653
365	3254	428	f	f	f	2015-10-15 13:08:02.909835
366	604	408	f	f	f	2015-10-16 15:07:07.797635
367	3414	429	f	f	f	2015-10-17 10:50:18.715318
368	4541	431	f	f	f	2015-10-20 10:57:09.473331
369	1135	430	f	f	f	2015-10-20 11:11:27.325587
370	4560	432	f	f	f	2015-10-20 11:47:50.065507
371	4438	433	f	f	f	2015-10-21 11:39:18.742018
372	1776	424	f	f	f	2015-10-23 09:08:01.209137
374	3970	436	f	f	f	2015-10-29 13:34:34.847815
375	4559	434	f	f	f	2015-11-02 13:45:05.993572
376	2141	438	f	f	f	2015-11-04 13:51:10.214675
377	3413	133	f	f	f	2015-11-05 13:37:33.75698
373	4172	435	f	f	f	2015-10-26 09:18:57.787309
378	4601	463	f	f	f	2015-12-02 10:25:28.633483
379	4611	461	f	f	f	2015-12-02 10:35:30.50601
380	4612	462	f	f	f	2015-12-02 10:39:13.593468
381	4543	460	f	f	f	2015-12-02 11:03:24.304253
382	4528	437	f	f	f	2016-01-12 15:48:49.344924
\.


--
-- Name: historico_id_historico_seq; Type: SEQUENCE SET; Schema: actualizar; Owner: postgres
--

SELECT pg_catalog.setval('historico_id_historico_seq', 382, true);


--
-- Data for Name: traza; Type: TABLE DATA; Schema: actualizar; Owner: postgres
--

COPY traza (id_traza, id_personal, n_traza, id_usuario, fecha_traza, fecha_creacion) FROM stdin;
349	923	2	374	2015-08-19 08:03:54.902878	2015-08-19 07:56:25.912336
178	544	2	200	2015-08-11 14:20:54.346955	2015-08-11 14:15:19.707381
22	1588	2	44	2015-07-23 10:29:04.522395	2015-07-23 09:59:10.405508
54	3885	2	81	2015-07-29 16:10:05.322677	2015-07-29 16:05:55.333836
374	4333	2	399	2015-09-01 10:02:55.919851	2015-09-01 09:55:18.36832
125	3654	1	154	2015-08-05 11:45:56.249273	2015-08-05 11:45:56.249273
204	2703	2	228	2015-08-12 16:14:19.459952	2015-08-12 16:01:49.208577
206	4025	1	230	2015-08-12 17:27:23.904726	2015-08-12 17:27:23.904726
356	3825	2	381	2015-08-19 16:04:56.019597	2015-08-19 16:03:37.24816
183	2072	2	205	2015-10-13 11:40:56.608393	2015-08-12 10:53:28.890386
396	4557	1	420	2015-10-13 11:41:22.366639	2015-10-13 11:41:22.366639
295	873	1	328	2015-08-14 14:00:01.582067	2015-08-14 14:00:01.582067
39	3810	1	62	2015-07-29 09:07:42.364042	2015-07-29 09:07:42.364042
233	4296	2	259	2015-08-13 11:57:37.223285	2015-08-13 11:37:26.713699
337	767	2	364	2015-08-17 16:15:49.130228	2015-08-17 16:08:20.026241
43	3445	1	66	2015-07-29 09:29:57.395539	2015-07-29 09:29:57.395539
212	930	1	238	2015-08-13 08:34:28.505217	2015-08-13 08:34:28.505217
257	726	2	287	2015-08-13 19:26:21.126915	2015-08-13 19:24:26.668188
88	4500	2	114	2015-07-31 15:29:17.909747	2015-07-31 15:21:11.142403
318	1941	2	347	2015-08-14 19:43:22.652026	2015-08-14 19:37:33.760797
319	936	1	346	2015-08-14 19:49:19.561826	2015-08-14 19:49:19.561826
216	833	2	244	2015-08-13 09:09:39.208343	2015-08-13 09:05:23.331857
110	3261	2	135	2015-08-05 09:29:23.056518	2015-08-05 09:25:48.473263
258	3332	2	288	2015-08-13 19:59:39.034894	2015-08-13 19:54:12.247896
259	1149	2	289	2015-08-13 20:22:12.61476	2015-08-13 20:06:06.278314
239	2618	1	269	2015-08-13 12:58:16.159226	2015-08-13 12:58:16.159226
170	813	1	193	2015-08-11 09:22:55.078895	2015-08-11 09:22:55.078895
136	3941	2	167	2015-08-05 15:44:30.015846	2015-08-05 15:40:33.261671
301	955	2	334	2015-08-14 15:37:01.591635	2015-08-14 14:40:58.329277
242	896	2	271	2015-08-13 13:38:32.754734	2015-08-13 13:35:37.07956
323	3271	2	351	2015-08-14 23:14:33.793609	2015-08-14 23:04:25.596421
403	3981	1	427	2015-10-14 16:20:48.009468	2015-10-14 16:20:48.009468
344	924	1	369	2015-08-18 12:06:48.837419	2015-08-18 12:06:48.837419
299	725	2	331	2015-08-14 15:57:57.768439	2015-08-14 14:25:27.771122
325	793	2	354	2015-08-16 18:13:45.861721	2015-08-16 18:07:09.993844
386	3961	2	410	2015-09-07 11:51:25.933605	2015-09-07 11:48:03.192041
\.


--
-- Name: traza_id_traza_seq; Type: SEQUENCE SET; Schema: actualizar; Owner: postgres
--

SELECT pg_catalog.setval('traza_id_traza_seq', 418, true);


SET search_path = evaluacion, pg_catalog;

--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY comentarios (id_comentario, fk_evaluacion, comentario, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo) FROM stdin;
125	84	Rechazado RRHH 1	16	2016-02-19 10:12:41.951699	2016-02-19 10:12:41.951699	11	\N	t
126	85	Rechazado RRHH 1	16	2016-02-19 10:14:10.783452	2016-02-19 10:14:10.783452	11	\N	t
127	86	Rechazado RRHH 1	16	2016-02-19 10:14:19.491243	2016-02-19 10:14:19.491243	11	\N	t
128	84	Rechazado RRHH 2	16	2016-02-19 10:15:28.946922	2016-02-19 10:15:28.946922	11	\N	t
129	85	Rechazado RRHH 2	16	2016-02-19 10:15:38.955401	2016-02-19 10:15:38.955401	11	\N	t
130	84	Rechazado RRHH 3	16	2016-02-19 10:16:24.454315	2016-02-19 10:16:24.454315	11	\N	t
131	85	Rechazado RRHH	16	2016-02-19 12:09:25.309095	2016-02-19 12:09:25.309095	11	\N	t
132	86	Rechazado RRHH 2	16	2016-02-19 12:09:36.691889	2016-02-19 12:09:36.691889	11	\N	t
133	87	Rechazado RRHH 2	16	2016-02-19 12:09:56.016993	2016-02-19 12:09:56.016993	11	\N	t
134	88	Rechazado RRHH 3	16	2016-02-19 12:10:07.99125	2016-02-19 12:10:07.99125	11	\N	t
135	86	Rechazado RRHH 3	16	2016-02-19 12:12:10.954641	2016-02-19 12:12:10.954641	11	\N	t
136	87	Rechazado RRHH 3	16	2016-02-19 12:12:19.2961	2016-02-19 12:12:19.2961	11	\N	t
137	88	Rechazado RRHH 3	16	2016-02-19 12:12:31.32123	2016-02-19 12:12:31.32123	11	\N	t
\.


--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentario_seq', 137, true);


--
-- Data for Name: estatus_evaluacion; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY estatus_evaluacion (id_estatus_evaluacion, fk_evaluacion, fk_tipo_entidad, fk_entidad, fk_estatus_evaluacion, fecha_estatus, created_by, modified_by, created_date, modified_date, fk_estatus, es_activo) FROM stdin;
277	84	53	437	47	2016-02-18 09:30:13.718009	437	\N	2016-02-18 09:30:13.718009	2016-02-18 09:30:13.718009	65	t
278	85	53	437	47	2016-02-19 10:08:19.67982	437	\N	2016-02-19 10:08:19.67982	2016-02-19 10:08:19.67982	65	t
279	86	53	437	47	2016-02-19 10:08:52.347852	437	\N	2016-02-19 10:08:52.347852	2016-02-19 10:08:52.347852	65	t
280	87	53	437	47	2016-02-19 10:09:24.39677	437	\N	2016-02-19 10:09:24.39677	2016-02-19 10:09:24.39677	65	t
281	88	53	437	47	2016-02-19 10:10:48.892135	437	\N	2016-02-19 10:10:48.892135	2016-02-19 10:10:48.892135	65	t
282	87	52	355	48	2016-02-19 10:11:32.717345	355	\N	2016-02-19 10:11:32.717345	2016-02-19 10:11:32.717345	65	t
283	88	52	355	48	2016-02-19 10:11:35.078676	355	\N	2016-02-19 10:11:35.078676	2016-02-19 10:11:35.078676	65	t
284	85	52	355	48	2016-02-19 10:11:37.439545	355	\N	2016-02-19 10:11:37.439545	2016-02-19 10:11:37.439545	65	t
285	86	52	355	48	2016-02-19 10:11:39.594071	355	\N	2016-02-19 10:11:39.594071	2016-02-19 10:11:39.594071	65	t
286	84	52	355	48	2016-02-19 10:11:41.565165	355	\N	2016-02-19 10:11:41.565165	2016-02-19 10:11:41.565165	65	t
287	84	45	11	50	2016-02-19 10:12:41.937314	11	\N	2016-02-19 10:12:41.937314	2016-02-19 10:12:41.937314	65	t
288	85	45	11	50	2016-02-19 10:14:10.762876	11	\N	2016-02-19 10:14:10.762876	2016-02-19 10:14:10.762876	65	t
289	86	45	11	50	2016-02-19 10:14:19.472265	11	\N	2016-02-19 10:14:19.472265	2016-02-19 10:14:19.472265	65	t
290	84	52	437	79	2016-02-19 10:14:33.00609	437	\N	2016-02-19 10:14:33.00609	2016-02-19 10:14:33.00609	65	t
291	85	52	437	79	2016-02-19 10:14:37.897031	437	\N	2016-02-19 10:14:37.897031	2016-02-19 10:14:37.897031	65	t
292	86	52	437	79	2016-02-19 10:14:43.078503	437	\N	2016-02-19 10:14:43.078503	2016-02-19 10:14:43.078503	65	t
293	85	52	355	48	2016-02-19 10:14:55.446866	355	\N	2016-02-19 10:14:55.446866	2016-02-19 10:14:55.446866	65	t
294	86	52	355	48	2016-02-19 10:14:57.527522	355	\N	2016-02-19 10:14:57.527522	2016-02-19 10:14:57.527522	65	t
295	84	52	355	48	2016-02-19 10:14:59.111162	355	\N	2016-02-19 10:14:59.111162	2016-02-19 10:14:59.111162	65	t
296	84	45	11	50	2016-02-19 10:15:28.91295	11	\N	2016-02-19 10:15:28.91295	2016-02-19 10:15:28.91295	65	t
297	85	45	11	50	2016-02-19 10:15:38.926261	11	\N	2016-02-19 10:15:38.926261	2016-02-19 10:15:38.926261	65	t
298	85	52	437	79	2016-02-19 10:15:52.830859	437	\N	2016-02-19 10:15:52.830859	2016-02-19 10:15:52.830859	65	t
299	84	52	437	79	2016-02-19 10:15:57.324949	437	\N	2016-02-19 10:15:57.324949	2016-02-19 10:15:57.324949	65	t
300	85	52	355	48	2016-02-19 10:16:10.850701	355	\N	2016-02-19 10:16:10.850701	2016-02-19 10:16:10.850701	65	t
301	84	52	355	48	2016-02-19 10:16:12.536143	355	\N	2016-02-19 10:16:12.536143	2016-02-19 10:16:12.536143	65	t
302	84	45	11	50	2016-02-19 10:16:24.429904	11	\N	2016-02-19 10:16:24.429904	2016-02-19 10:16:24.429904	65	t
303	84	52	437	79	2016-02-19 12:08:45.347009	437	\N	2016-02-19 12:08:45.347009	2016-02-19 12:08:45.347009	65	t
304	85	45	11	50	2016-02-19 12:09:25.286449	11	\N	2016-02-19 12:09:25.286449	2016-02-19 12:09:25.286449	65	t
305	86	45	11	50	2016-02-19 12:09:36.67666	11	\N	2016-02-19 12:09:36.67666	2016-02-19 12:09:36.67666	65	t
306	87	45	11	50	2016-02-19 12:09:55.997103	11	\N	2016-02-19 12:09:55.997103	2016-02-19 12:09:55.997103	65	t
307	88	45	11	50	2016-02-19 12:10:07.970564	11	\N	2016-02-19 12:10:07.970564	2016-02-19 12:10:07.970564	65	t
308	86	52	437	79	2016-02-19 12:11:18.706876	437	\N	2016-02-19 12:11:18.706876	2016-02-19 12:11:18.706876	65	t
309	88	52	437	79	2016-02-19 12:11:27.981923	437	\N	2016-02-19 12:11:27.981923	2016-02-19 12:11:27.981923	65	t
310	87	52	437	79	2016-02-19 12:11:38.970464	437	\N	2016-02-19 12:11:38.970464	2016-02-19 12:11:38.970464	65	t
311	86	52	355	48	2016-02-19 12:11:49.272434	355	\N	2016-02-19 12:11:49.272434	2016-02-19 12:11:49.272434	65	t
312	88	52	355	48	2016-02-19 12:11:51.366337	355	\N	2016-02-19 12:11:51.366337	2016-02-19 12:11:51.366337	65	t
313	87	52	355	48	2016-02-19 12:11:53.03897	355	\N	2016-02-19 12:11:53.03897	2016-02-19 12:11:53.03897	65	t
314	86	45	11	50	2016-02-19 12:12:10.926372	11	\N	2016-02-19 12:12:10.926372	2016-02-19 12:12:10.926372	65	t
315	87	45	11	50	2016-02-19 12:12:19.277847	11	\N	2016-02-19 12:12:19.277847	2016-02-19 12:12:19.277847	65	t
316	88	45	11	50	2016-02-19 12:12:31.298651	11	\N	2016-02-19 12:12:31.298651	2016-02-19 12:12:31.298651	65	t
317	89	53	437	47	2016-02-21 23:41:11.355745	437	\N	2016-02-21 23:41:11.355745	2016-02-21 23:41:11.355745	65	t
318	90	53	437	47	2016-02-21 23:50:34.171478	437	\N	2016-02-21 23:50:34.171478	2016-02-21 23:50:34.171478	65	t
\.


--
-- Name: estatus_evaluacion_id_estatus_evaluacion_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('estatus_evaluacion_id_estatus_evaluacion_seq', 318, true);


--
-- Data for Name: evaluacion; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY evaluacion (id_evaluacion, fk_evaluador, fk_evaluado, total_b, total_c, total_final, esta_conforme, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, obj_funcional, fk_rango_act) FROM stdin;
84	84	84	\N	\N	\N	\N	19	2016-02-18 09:30:13.681091	2016-02-18 09:30:13.681091	437	\N	t	\N	\N
85	85	85	\N	\N	\N	\N	19	2016-02-19 10:08:19.650555	2016-02-19 10:08:19.650555	437	\N	t	\N	\N
86	86	86	\N	\N	\N	\N	19	2016-02-19 10:08:52.330895	2016-02-19 10:08:52.330895	437	\N	t	\N	\N
87	87	87	\N	\N	\N	\N	19	2016-02-19 10:09:24.380206	2016-02-19 10:09:24.380206	437	\N	t	\N	\N
88	88	88	\N	\N	\N	\N	19	2016-02-19 10:10:48.861989	2016-02-19 10:10:48.861989	437	\N	t	\N	\N
89	89	89	\N	\N	\N	\N	19	2016-02-21 23:41:11.322618	2016-02-21 23:41:11.322618	437	\N	t	\N	\N
90	90	90	\N	\N	\N	\N	19	2016-02-21 23:50:34.137648	2016-02-21 23:50:34.137648	437	\N	t	\N	\N
\.


--
-- Name: evaluacion_id_evaluacion_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('evaluacion_id_evaluacion_seq', 90, true);


--
-- Data for Name: evaluador; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY evaluador (id_evaluador, cod_nomina, cargo, grado, cod_clase, unidad_admtiva, fk_persona, fk_estatus, fk_supervisor, created_date, modified_date, created_by, modified_by, es_activo, fk_tipo_entidad, fk_dependencia, dependencia_cruge) FROM stdin;
84	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-18 09:30:13.672745	2016-02-18 09:30:13.672745	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
85	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-19 10:08:19.633635	2016-02-19 10:08:19.633635	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
86	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-19 10:08:52.322556	2016-02-19 10:08:52.322556	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
87	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-19 10:09:24.372031	2016-02-19 10:09:24.372031	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
88	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-19 10:10:48.853678	2016-02-19 10:10:48.853678	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
89	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-21 23:41:11.314358	2016-02-21 23:41:11.314358	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
90	3136	COORDINADOR (A) DE DESARROLLO	0	0	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	4528	22	3	2016-02-21 23:50:34.128717	2016-02-21 23:50:34.128717	437	\N	t	\N	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- Name: evaluador_id_evaluador_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('evaluador_id_evaluador_seq', 90, true);


--
-- Data for Name: evaluados; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY evaluados (id_evaluado, cargo, grado, cod_nomina, fecha_ingreso, tiempo_puesto, ubicacion_admtiva, estado, periodo_desde, periodo_hasta, n_veces, cod_clase, fk_persona, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, fk_tipo_entidad, fk_dependencia, fk_periodo) FROM stdin;
84	PROGRAMADOR	\N	3361	\N	\N	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	\N	\N	\N	\N	\N	4612	25	2016-02-18 09:30:13.651527	2016-02-18 09:30:13.651527	437	\N	t	53	1	81
85	ANALISTA	\N	165	\N	\N	DESPACHO DE LA VICEMINISTRA PARA PROTECCIÓN DE LOS DERECHOS DE LA MUJER	\N	\N	\N	\N	\N	4191	25	2016-02-19 10:08:19.611451	2016-02-19 10:08:19.611451	437	\N	t	53	1	81
86	PROGRAMADOR	\N	3366	\N	\N	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	\N	\N	\N	\N	\N	4611	25	2016-02-19 10:08:52.307385	2016-02-19 10:08:52.307385	437	\N	t	53	1	81
87	ANALISTA DE SISTEMAS 	\N	655	\N	\N	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	\N	\N	\N	\N	\N	1401	25	2016-02-19 10:09:24.354417	2016-02-19 10:09:24.354417	437	\N	t	53	1	81
88	ANALISTA DE SISTEMAS 	\N	2363	\N	\N	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	\N	\N	\N	\N	\N	3496	25	2016-02-19 10:10:48.827616	2016-02-19 10:10:48.827616	437	\N	t	53	1	81
89	ASESOR (A)	\N	820	\N	\N	OFICINA DE GESTIÓN COMUNICACIONAL	\N	\N	\N	\N	\N	4012	25	2016-02-21 23:41:11.292698	2016-02-21 23:41:11.292698	437	\N	t	53	1	81
90	ASESOR (A)	\N	820	\N	\N	OFICINA DE GESTIÓN COMUNICACIONAL	\N	\N	\N	\N	\N	4012	25	2016-02-21 23:50:34.107487	2016-02-21 23:50:34.107487	437	\N	t	53	1	81
\.


--
-- Name: evaluados_id_evaluado_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('evaluados_id_evaluado_seq', 90, true);


--
-- Data for Name: maestro; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY maestro (id_maestro, descripcion, padre, hijo, created_date, modified_date, created_by, modified_by, es_activo, descripcion2) FROM stdin;
1	NACIONALIDAD	0	2	2015-04-13 10:55:08.165559	2015-04-13 10:55:08.165559	1	\N	t	\N
2	V	1	0	2015-04-13 10:55:08.165559	2015-04-13 10:55:08.165559	1	\N	t	\N
3	E	1	0	2015-04-13 10:55:08.165559	2015-04-13 10:55:08.165559	1	\N	t	\N
4	SEXO	0	2	2015-04-13 13:25:32.955602	2015-04-13 13:25:32.955602	1	\N	t	\N
5	F	4	0	2015-04-13 13:25:32.955602	2015-04-13 13:25:32.955602	1	\N	t	\N
6	M	4	0	2015-04-13 13:25:32.955602	2015-04-13 13:25:32.955602	1	\N	t	\N
7	TIPO ENTIDAD	0	2	2015-08-05 16:58:39.846121	2015-08-05 16:58:39.846121	1	\N	t	\N
8	EVALUADO	7	0	2015-08-05 16:58:52.41337	2015-08-05 16:58:52.41337	1	\N	t	\N
9	EVALUADOR	7	0	2015-08-05 16:59:04.869996	2015-08-05 16:59:04.869996	1	\N	t	\N
11	OBRERO	10	0	2015-08-05 16:59:42.149169	2015-08-05 16:59:42.149169	1	\N	t	\N
12	PROFESIONAL	10	0	2015-08-05 16:59:53.133225	2015-08-05 16:59:53.133225	1	\N	t	\N
13	ADMINISTRATIVO Y DE APOYO	10	0	2015-08-05 17:00:15.333116	2015-08-05 17:00:15.333116	1	\N	t	\N
14	SUPERVISORIO	10	0	2015-08-05 17:00:35.789045	2015-08-05 17:00:35.789045	1	\N	t	\N
10	TIPO CLASE	0	4	2015-08-05 16:59:24.374147	2015-08-05 16:59:24.374147	1	\N	t	\N
15	ESTATUS COMENTARIOS	0	2	2015-08-05 17:00:59.67686	2015-08-05 17:00:59.67686	1	\N	t	\N
16	ACTIVO	15	0	2015-08-05 17:01:23.700786	2015-08-05 17:01:23.700786	1	\N	t	\N
17	INACTIVO	15	0	2015-08-05 17:02:05.501447	2015-08-05 17:02:05.501447	1	\N	t	\N
18	ESTATUS EVALUACION	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
19	ACTIVO	18	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
20	INACTIVO	18	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
21	ESTATUS EVALUADOR	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
22	ACTIVO	21	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
23	INACTIVO	21	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
24	ESTATUS EVALUADOS	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
25	ACTIVO	24	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
26	INACTIVO	24	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
27	ESTATUS PERSONA	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
28	ACTIVO	27	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
29	INACTIVO	27	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
30	ESTATUS PREGUNTAS	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
31	ACTIVO	30	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
32	INACTIVO	30	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
33	ESTATUS PREGUNTAS COLECTIVAS	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
34	ACTIVO	33	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
35	INACTIVO	33	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
36	ESTATUS PREGUNTAS INDIVIDUALES	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
37	ACTIVO	36	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
38	INACTIVO	36	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
39	ESTATUS PREGUNTAS OBREROS	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
40	ACTIVO	39	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
41	INACTIVO	39	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
42	ESTATUS SUPERVISOR	0	2	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
43	ACTIVO	42	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
44	INACTIVO	42	0	2015-08-05 17:13:17.972292	2015-08-05 17:13:17.972292	1	\N	t	\N
45	RECURSOS HUMANOS	7	0	2015-08-14 15:40:09.309887	2015-08-14 15:40:09.309887	1	\N	t	\N
47	NUEVO	46	0	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
48	ENVIADO	46	0	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
49	APROBADO	46	0	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
50	RECHAZADO	46	0	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
51	FINALIZADO	46	0	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
67	DESPACHO	7	0	2015-09-16 14:03:36.696777	2015-09-16 14:03:36.696777	1	\N	t	\N
52	DIRECCION	7	0	2015-08-25 14:56:34.341367	2015-08-25 14:56:34.341367	1	\N	t	\N
53	COORDINACION	7	0	2015-08-25 14:56:49.940711	2015-08-25 14:56:49.940711	1	\N	t	\N
54	ESTATUS CARGO	0	2	2015-08-31 16:49:51.072219	2015-08-31 16:49:51.072219	1	\N	t	\N
55	ACTIVO	54	0	2015-08-31 16:50:09.456231	2015-08-31 16:50:09.456231	1	\N	t	\N
56	INACTIVO	54	0	2015-08-31 16:50:22.584011	2015-08-31 16:50:22.584011	1	\N	t	\N
57	ESTATUS COORDINACION	0	2	2015-08-31 16:50:40.168049	2015-08-31 16:50:40.168049	1	\N	t	\N
58	ACTIVO	57	0	2015-08-31 16:50:51.752027	2015-08-31 16:50:51.752027	1	\N	t	\N
59	INACTIVO	57	0	2015-08-31 16:51:04.280118	2015-08-31 16:51:04.280118	1	\N	t	\N
61	ESTATUS DIRECCION	0	2	2015-08-31 16:51:25.183863	2015-08-31 16:51:25.183863	1	\N	t	\N
62	ACTIVO	61	0	2015-08-31 16:51:39.511675	2015-08-31 16:51:39.511675	1	\N	t	\N
63	INACTIVO	61	0	2015-08-31 16:51:50.311511	2015-08-31 16:51:50.311511	1	\N	t	\N
46	ESTATUS DE LA  EVALUACION	0	5	2015-08-25 10:52:36.362558	2015-08-25 10:52:36.362558	1	\N	t	\N
69	ESTATUS DESPACHO	0	2	2015-09-17 15:15:52.970502	2015-09-17 15:15:52.970502	1	\N	t	\N
70	ACTIVO	69	0	2015-09-17 15:16:09.033625	2015-09-17 15:16:09.033625	1	\N	t	\N
65	ACTIVO	64	0	2015-09-07 15:58:10.60462	2015-09-07 15:58:10.60462	1	\N	t	\N
66	INACTIVO	64	0	2015-09-07 15:58:20.98869	2015-09-07 15:58:20.98869	1	\N	t	\N
68	DIRECCIÓN DE LÍNEA	7	0	2015-09-16 14:03:54.704388	2015-09-16 14:03:54.704388	1	\N	t	\N
71	INACTIVO	69	0	2015-09-17 15:16:22.562271	2015-09-17 15:16:22.562271	1	\N	t	\N
72	ESTATUS DIRECCIÓN DE LÍNEA	0	2	2015-09-17 15:16:50.51348	2015-09-17 15:16:50.51348	1	\N	t	\N
73	ACTIVO	72	0	2015-09-17 15:17:05.185493	2015-09-17 15:17:05.185493	1	\N	t	\N
74	INACTIVO	72	0	2015-09-17 15:17:26.778083	2015-09-17 15:17:26.778083	1	\N	t	\N
64	ESTATUS TABLA_ESTATUS_EVALUACION	0	2	2015-09-07 15:57:57.980652	2015-09-07 15:57:57.980652	1	\N	t	\N
75	ESTATUS PERSONA_CARGO	0	2	2015-10-01 16:34:31.800084	2015-10-01 16:34:31.800084	1	\N	t	\N
77	ACTIVO	75	0	2015-10-01 16:34:51.207957	2015-10-01 16:34:51.207957	1	\N	t	\N
78	INACTIVO	75	0	2015-10-01 16:35:01.048013	2015-10-01 16:35:01.048013	1	\N	t	\N
79	REVISADO	46	0	2015-10-06 15:24:22.026534	2015-10-06 15:24:22.026534	1	\N	t	\N
80	PERIODO	0	2	2015-10-08 16:36:31.334487	2015-10-08 16:36:31.334487	1	\N	t	\N
81	1ER SEMESTRE	80	0	2015-10-08 16:36:46.270403	2015-10-08 16:36:46.270403	1	\N	t	\N
82	2DO SEMESTRE	80	0	2015-10-08 16:37:00.086344	2015-10-08 16:37:00.086344	1	\N	t	\N
83	RANGO	0	5	2015-10-19 12:22:33.873397	2015-10-19 12:22:33.873397	1	\N	t	\N
84	1	83	0	2015-10-19 12:23:15.839869	2015-10-19 12:23:15.839869	1	\N	t	Muy por debajo de lo esperado
85	2	83	0	2015-10-19 12:23:15.839869	2015-10-19 12:23:15.839869	1	\N	t	Por debajo de lo esperado
86	3	83	0	2015-10-19 12:23:15.839869	2015-10-19 12:23:15.839869	1	\N	t	Dentro de lo esperado
87	4	83	0	2015-10-19 12:23:15.839869	2015-10-19 12:23:15.839869	1	\N	t	Sobre lo esperado
88	5	83	0	2015-10-19 12:23:15.839869	2015-10-19 12:23:15.839869	1	\N	t	Excepcional
90	1ERA REVISIÓN	89	0	2015-10-27 15:44:26.458993	2015-10-27 15:44:26.458993	1	\N	t	\N
91	2DA REVISIÓN	89	0	2015-10-27 15:44:26.458993	2015-10-27 15:44:26.458993	1	\N	t	\N
92	3ERA REVISIÓN	89	0	2015-10-27 15:44:26.458993	2015-10-27 15:44:26.458993	1	\N	t	\N
94	ACTIVO	93	0	2015-10-27 16:22:15.571914	2015-10-27 16:22:15.571914	1	\N	t	\N
89	REVISIONES	0	3	2015-10-27 15:44:26.458993	2015-10-27 15:44:26.458993	1	\N	t	\N
93	ESTATUS REVISION	0	2	2015-10-27 16:22:15.571914	2015-10-27 16:22:15.571914	1	\N	t	\N
95	INACTIVO	93	0	2015-10-27 16:22:15.571914	2015-10-27 16:22:15.571914	1	\N	t	\N
96	RANGO DE ACTUACIÓN (PROFESIONALES)	0	5	2015-11-03 09:33:24.050674	2015-11-03 09:33:24.050674	1	\N	t	\N
97	Muy por debajo de lo esperado	96	0	2015-11-03 09:38:19.094424	2015-11-03 09:38:19.094424	1	\N	t	100-179
98	Por debajo de lo esperado	96	0	2015-11-03 09:38:19.094424	2015-11-03 09:38:19.094424	1	\N	t	180-259
99	Dentro de lo esperado	96	0	2015-11-03 09:38:19.094424	2015-11-03 09:38:19.094424	1	\N	t	260-339
100	Sobre lo esperado	96	0	2015-11-03 09:38:19.094424	2015-11-03 09:38:19.094424	1	\N	t	340-419
101	Excepcional	96	0	2015-11-03 09:38:19.094424	2015-11-03 09:38:19.094424	1	\N	t	420-500
102	RANGOS DE ACTUACIÓN (TRABAJADORES)	0	5	2015-11-03 09:44:59.194585	2015-11-03 09:44:59.194585	1	\N	t	\N
103	DEFICIENTE	102	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	20-36
104	REGULAR	102	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	36,5-52,5
105	BUENO	102	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	53-69
106	MUY BUENO	102	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	69,5-85,5
107	EXCELENTE	102	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	86-100
108	INCOMPLETO	46	0	2015-11-03 09:53:22.404724	2015-11-03 09:53:22.404724	1	\N	t	\N
\.


--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 1, false);


--
-- Data for Name: preguntas; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY preguntas (id_pregunta, pregunta, fk_tipo_clase, pregunta_padre, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, peso_fijo, orden) FROM stdin;
1	Mide la capacidad de conocer y comprender la estructura de la organización y orientar su actuación profesional de acuerdo con los valores, principios, prioridades y objetivos de la misma. \n\t     Atiende más a los intereses organizacionales que a los personales	13	CONCIENCIA Y COMPROMISO ORGANIZACIONAL	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
2	Mide el compromiso con el aprendizaje continuo, entendiendo los cambios que se producen en el entorno organizacional, que aseguren su evolución personal y profesional	13	AUTODESARROLLO	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
3	Actuar con profesionalidad y mostrar conductas coherentes con la ética, valores morales, buenas costumbres y prácticas profesionales respetando las políticas organizacionales del servicio público	13	HABILIDAD PARA TRATAR EN FORMA CORTES Y EFECTIVA CON FUNCIONARIOS Y PUBLICO	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
4	Mide la habilidad para recibir, comprender y transmitir en forma oral y escrita ideas e información de manera que facilite la rápida comprensión, logrando una actitud positiva en cualquier situación de trabajo	13	COMUNICACIÓN	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
5	Actuar para construir y mantener relaciones o roles cordiales de contactos internas o externas a la organización que son o pueden ser algún día valiosas para conseguir los objetivos organizacionales	13	RELACIONES INTERPERSONALES	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
6	Mide el grado en que el empleado cumple con las políticas, normas y procedimientos establecidos por la organización en cuanto a: apariencia personal, puntualidad, asistencia y otras normativas	13	ADECUACIÓN A LAS NORMAS DE LA ORGANIZACIÓN	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
8	Capacidad de encaminar todos los actos al logro de los objetivos comunes, actuando con velocidad y sentido de urgencia para satisfacer las necesidades de los ciudadanos y/o mejorar las organizaciones	13	MOTIVACION AL LOGRO	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
9	Mide la capacidad de conocer y comprender la estructura de la organización y orientar su actuación profesional de acuerdo con los valores, principios, prioridades y objetivos de la misma. \n\t     Atiende más a los intereses organizacionales que a los personales	14	CONCIENCIA Y COMPROMISO ORGANIZACIONAL	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
10	Mide el compromiso con el aprendizaje continuo, entendiendo los cambios que se producen en el entorno organizacional, que aseguren su evolución personal y profesional	14	AUTODESARROLLO	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
12	Mide la disposición para emprender acciones, crear oportunidades y mejorar resultados sin la necesidad de un requerimiento externo	14	CREATIVIDAD E INICIATIVA (Proactividad)	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
13	Asumir el rol de líder de un grupo o equipo de trabajo, utilizando su autoridad con justicia y promoviendo la efectividad y motivación del equipo. Implica el deseo de guiar a otros que no se muestra como una \n\t     posición de autoridad	14	LIDERAZGO DE EQUIPOS	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
14	Mide la capacidad de responder oportunamente ante situaciones previstas o imprevistas, decidiendo en forma rápida, efectiva y oportuna el mejor plan de acción, asumiendo las responsabilidades y riesgos	14	TOMA DE DECISIONES Y SOLUCIÓN DE PROBLEMAS	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
15	Capacidad para formular y organizar planes, proyectos y programas de trabajo, considerando los objetivos, prioridades, etapas y recursos disponibles	14	PLANIFICACIÓN	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
16	Capacidad para distinguir y asignar en forma efectiva lo que debe hacer personalmente y lo que deben hacer sus subordinados	14	DELEGACIÓN	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
17	Mide la capacidad de conocer y comprender la estructura de la organización y orientar su actuación profesional de acuerdo con los valores, principios, prioridades y objetivos de la misma. \n\t     Atiende más a los intereses organizacionales que a los personales	12	CONCIENCIA Y COMPROMISO ORGANIZACIONAL	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
18	Mide el compromiso con el aprendizaje continuo, entendiendo los cambios que se producen en el entorno organizacional, que aseguren su evolución personal y profesional	12	AUTODESARROLLO	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
19	Capacidad para entender una situación, desglosándola en partes identificando las relaciones causa-efecto	12	PENSAMIENTO ANALÍTICO	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
20	Mide la capacidad de escuchar, hacer preguntas, expresar conceptos e ideas en forma efectiva. Ello implica saber cuándo y a quién preguntar para llevar adelante un propósito, saber escuchar al otro y comprender la dinámica\n\t     de grupos. Incluye la capacidad de comunicación por escrito con conclusión y claridad	12	COMUNICACIÓN	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
22	Es el propósito genuino por trabajar en colaboración con los demás, ser parte del equipo, trabajar juntos, como opuesto a trabajar separadamente y/o en una aptitud individualista	12	COOPERACIÓN Y TRABAJO EN EQUIPO	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
24	Destrezas y habilidades para recibir instrucciones verbales y escritas y emprender líneas de acción a los fines del logro de los objetivos del organismo	12	CAPACIDAD PARA EJECUTAR POLÍTICAS	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
26	Ejecuta las tareas asignadas con exactitud, claridad y cuidado, evitando errores y omisiones	11	CALIDAD DEL TRABAJO	31	2015-08-19 16:15:58.808069	2015-08-19 16:15:58.808069	1	\N	t	7.5	A
23	Capacidad para modificar la propia conducta a fin de alcanzar determinados objetivos cuando surgen dificultades, nuevos datos o cambios en el entorno. Capacidad para enfrentarse con flexibilidad y versatilidad a situaciones\n\t     nuevas y para aceptar los cambios positiva y constructivamente	12	FLEXIBILIDAD Y ADAPTABILIDAD	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
7	Se refiere a la búsqueda, obtención y uso de la información relacionada a problemas, situaciones u oportunidades en el trabajo. Considera diferentes opiniones e informaciones, investiga puntos de vista, hechos o experiencias\n\t     análogas antes de tomar una decisión	13	BÚSQUEDA DE INFORMACIÓN	31	2015-08-19 12:24:51.885971	2015-08-19 12:24:51.885971	1	\N	t	\N	\N
11	Mide la capacidad de escuchar, hacer preguntas, expresar conceptos e ideas en forma efectiva. Ello implica saber cuándo y a quién preguntar para llevar adelante un propósito, saber escuchar al otro y comprender \n\t     la dinámica de grupos. Incluye la capacidad de comunicación por escrito con conclusión y claridad	14	COMUNICACIÓN	31	2015-08-19 14:39:03.641593	2015-08-19 14:39:03.641593	1	\N	t	\N	\N
28	Siempre ejecuta su trabajo con exactitud, claridad y cuidado logrando frecuentemente resultados por encima de lo esperado	11	CALIDAD DEL TRABAJO	31	2015-08-19 16:15:58.808069	2015-08-19 16:15:58.808069	1	\N	t	10	A
27	El trabajo ejecutado se ajusta parcialmente a los resultados esperados, comete errores y omisiones que le obliga a hacer correcciones	11	CALIDAD DEL TRABAJO	31	2015-08-19 16:15:58.808069	2015-08-19 16:15:58.808069	1	\N	t	5	A
29	Ejecuta los trabajos asignados sin errores ni omisiones, supera los parámetros logrando resultados por encima de lo esperado	11	CALIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	12.5	A
30	Frecuentemente presenta problemas para cumplir con el volumen asignado del trabajo	11	CANTIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	5	B
31	Realiza su trabajo en forma muy lenta, lo que impide cumplir con el volumen asignado	11	CANTIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	2.5	B
32	Realiza su trabajo con rapidez, alcanzando siempre mayor producción de lo que le es asignado	11	CANTIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	12.5	B
33	Cumple con el volumen exigido por el puesto de trabajo y a menudo sobrepasa lo exigido	11	CANTIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	10	B
34	Cumple con el volumen exigido por el puesto de trabajo	11	CANTIDAD DEL TRABAJO	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	7.5	B
35	Cumple con los reglamentos y procedimientos establecidos por el organismo	11	CUMPLIMIENTO DE NORMAS	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	7.5	C
36	En muchas ocasiones incumple con los reglamentos y procedimientos establecidos	11	CUMPLIMIENTO DE NORMAS	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	5	C
37	No cumple con los reglamentos y procedimientos establecidos por el organismo	11	CUMPLIMIENTO DE NORMAS	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	2.5	C
38	Cumple siempre con los reglamentos y procedimientos establecidos, estimula a los compañeros a acatarlos y aporta ideas y soluciones	11	CUMPLIMIENTO DE NORMAS	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	12.5	C
39	Cumple con los reglamentos y procedimientos establecidos y estimula a los compañeros a acatar la normativa	11	CUMPLIMIENTO DE NORMAS	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	10	C
40	En muchas ocasiones incumple con las normas y procedimientos de seguridad establecidas	11	HÁBITOS DE SEGURIDAD	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	5	D
41	No cumple con las normas y procedimientos de seguridad establecidos por el organismo	11	HÁBITOS DE SEGURIDAD	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	2.5	D
42	Cumple con las normas y procedimientos establecidos, constituye un ejemplo para sus compañeros y aporta ideas para evitar accidentes	11	HÁBITOS DE SEGURIDAD	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	12.5	D
43	Cumple con las normas y procedimientos establecidos y constituye un ejemplo para sus compañeros	11	HÁBITOS DE SEGURIDAD	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	10	D
44	Cumple con las normas y procedimientos de seguridad establecidos por el organismo	11	HÁBITOS DE SEGURIDAD	31	2015-08-19 16:48:40.841628	2015-08-19 16:48:40.841628	1	\N	t	7.5	D
45	Siempre manifiesta esmero y dedicación en la ejecución de las tareas asignadas y en algunas oportunidades sugiere mejoras en el trabajo	11	INTERÉS POR EL TRABAJO	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	10	E
46	Manifiesta esmero y dedicación en la ejecución de las tareas asignadas	11	INTERÉS POR EL TRABAJO	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	7.5	E
47	Sólo ocasionalmente manifiesta interés por el trabajo	11	INTERÉS POR EL TRABAJO	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	5	E
48	Nunca manifiesta interés por el trabajo	11	INTERÉS POR EL TRABAJO	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	2.5	E
49	Siempre manifiesta esmero y dedicación en la ejecución de las tareas y logra mejorar su trabajo	11	INTERÉS POR EL TRABAJO	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	12.5	E
50	Nunca esta dispuesto a colaborar y a menudo es hostil con sus compañeros de trabajo y su supervisor	11	COOPERACIÓN	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	2.5	F
51	Siempre trabaja en armonía y estimula la colaboración entre los otros compañeros	11	COOPERACIÓN	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	12.5	F
52	Siempre trabaja en armonía con otros y presta colaboración en forma espontánea	11	COOPERACIÓN	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	10	F
53	Trabaja en armonía con otros y presta colaboración cuando es solicitada	11	COOPERACIÓN	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	7.5	F
54	No se muestra dispuesto a colaborar, salvo en situaciones de mucha presión, presentando en ocasiones conflictos con sus compañeros	11	COOPERACIÓN	31	2015-08-20 13:17:09.594586	2015-08-20 13:17:09.594586	1	\N	t	5	F
55	No es cuidadoso en el manejo y mantenimiento de los equipos, herramientas y maquinarias asignadas	11	MANEJO DE BIENES Y EQUIPOS	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	2.5	G
56	Siempre es cuidadoso en el manejo de los equipos, herramientas y maquinarias asignado y realiza el mantenimiento en forma oportuna	11	MANEJO DE BIENES Y EQUIPOS	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	10	G
57	Siempre es cuidadoso en el manejo de los equipos, herramientas y maquinarias, nunca incurre en fallas debido a que realiza adecuadamente tanto el mantenimiento preventivo como correctivo	11	MANEJO DE BIENES Y EQUIPOS	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	12.5	G
58	En ocasiones es descuidado en el manejo y mantenimiento de los equipos, herramientas y maquinarias asignadas	11	MANEJO DE BIENES Y EQUIPOS	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	5	G
60	Atiende al público en forma cortés, diligente y satisfactoria, de acuerdo a la exigencia del puesto de trabajo	11	ATENCIÓN AL PÚBLICO	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	7.5	H
61	Ocasionalmente se dirige al público de manera inadecuada. En algunas oportunidades su conducta genera demoras injustificadas en la prestación del servicio	11	ATENCIÓN AL PÚBLICO	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	5	H
62	Es descortés y negligente. Su comportamiento genera demoras injustificadas y quejas reiteradas	11	ATENCIÓN AL PÚBLICO	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	2.5	H
63	Atiende al público en forma cortés, diligente, suministrando respuestas oportunas y satisfactorias. Ocasionalmente facilita la solución de problemas	11	ATENCIÓN AL PÚBLICO	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	10	H
64	Siempre atiende al público en forma cortés, diligente, suministrando respuestas oportunas y satisfactorias. Facilita la solución de problemas mediante la orientación y suministro de información adecuada	11	ATENCIÓN AL PÚBLICO	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	12.5	H
25	Constantemente comete errores y omisiones a pesar de las reiteradas correcciones, no alcanza los resultados esperados	11	CALIDAD DEL TRABAJO	31	2015-08-19 16:15:58.808069	2015-08-19 16:15:58.808069	1	\N	t	2.5	A
59	Es cuidadoso en el manejo de los equipos, herramientas y maquinarias asignadas. Difícilmente incurre en fallas que puedan causar daños o problemas significativos	11	MANEJO DE BIENES Y EQUIPOS	31	2015-10-09 09:48:33.981067	2015-10-09 09:48:33.981067	1	\N	t	7.5	G
21	Se refiere a la búsqueda, obtención y uso de la información relacionada a problemas, situaciones u oportunidades en el trabajo. Considera diferentes opiniones e informaciones, investiga puntos de vista, hechos o experiencias\n\t     análogas antes de tomar una decisión	12	BÚSQUEDA DE INFORMACIÓN	31	2015-08-19 15:10:57.881707	2015-08-19 15:10:57.881707	1	\N	t	\N	\N
\.


--
-- Data for Name: preguntas_colectivas; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY preguntas_colectivas (id_preguntas_colect, fk_pregunta, fk_tipo_clase, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, orden) FROM stdin;
\.


--
-- Name: preguntas_colectivas_id_preguntas_colect_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_colectivas_id_preguntas_colect_seq', 0, true);


--
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_id_pregunta_seq', 1, false);


--
-- Data for Name: preguntas_individuales; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY preguntas_individuales (id_preguntas_ind, objetivo, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo) FROM stdin;
366	Obj 1	15	1	1	84	37	2016-02-18 09:30:20.559136	2016-02-18 09:30:20.559136	437	437	t
367	Obj 2	15	1	1	84	37	2016-02-18 09:30:25.743796	2016-02-18 09:30:25.743796	437	437	t
368	Obj 3	20	1	1	84	37	2016-02-18 09:30:30.694746	2016-02-18 09:30:30.694746	437	437	t
369	Obj 1	15	1	1	85	37	2016-02-19 10:08:24.293528	2016-02-19 10:08:24.293528	437	437	t
370	Obj 2	15	1	1	85	37	2016-02-19 10:08:29.176155	2016-02-19 10:08:29.176155	437	437	t
371	Obj 3	20	1	1	85	37	2016-02-19 10:08:36.017566	2016-02-19 10:08:36.017566	437	437	t
372	Obj 1	15	1	1	86	37	2016-02-19 10:08:58.358132	2016-02-19 10:08:58.358132	437	437	t
373	Obj 2	15	1	1	86	37	2016-02-19 10:09:04.65042	2016-02-19 10:09:04.65042	437	437	t
374	Obj 3	20	1	1	86	37	2016-02-19 10:09:09.916554	2016-02-19 10:09:09.916554	437	437	t
375	Obj 1	15	1	1	87	37	2016-02-19 10:09:31.72905	2016-02-19 10:09:31.72905	437	437	t
376	Obj 2	15	1	1	87	37	2016-02-19 10:09:38.178312	2016-02-19 10:09:38.178312	437	437	t
377	Obj 3	20	1	1	87	37	2016-02-19 10:09:47.958576	2016-02-19 10:09:47.958576	437	437	t
378	Obj 1	10	1	1	88	37	2016-02-19 10:10:53.974556	2016-02-19 10:10:53.974556	437	437	t
379	Obj 2	10	1	1	88	37	2016-02-19 10:10:59.474661	2016-02-19 10:10:59.474661	437	437	t
380	Obj 3	10	1	1	88	37	2016-02-19 10:11:04.951629	2016-02-19 10:11:04.951629	437	437	t
381	Obj 4	10	1	1	88	37	2016-02-19 10:11:09.663705	2016-02-19 10:11:09.663705	437	437	t
382	Obj 5	10	1	1	88	37	2016-02-19 10:11:15.146085	2016-02-19 10:11:15.146085	437	437	t
383	lol	23	1	1	90	37	2016-02-22 00:01:27.678045	2016-02-22 00:01:27.678045	437	437	t
\.


--
-- Name: preguntas_individuales_id_preguntas_ind_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_individuales_id_preguntas_ind_seq', 383, true);


--
-- Data for Name: preguntas_obrero; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY preguntas_obrero (id_preguntas_obr, puntaje, fk_pregunta, fk_evaluacion, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo) FROM stdin;
\.


--
-- Name: preguntas_obrero_id_preguntas_obr_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_obrero_id_preguntas_obr_seq', 0, true);


--
-- Data for Name: revision; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY revision (id_revision, fk_revision, fk_evaluador, fk_evaluacion, fecha_revision, comentario, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo) FROM stdin;
\.


--
-- Name: revision_id_revision_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('revision_id_revision_seq', 6, true);


--
-- Data for Name: supervisor; Type: TABLE DATA; Schema: evaluacion; Owner: postgres
--

COPY supervisor (id_supervisor, fk_persona, cargo, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo) FROM stdin;
3	4528	prueba	10	2015-10-20 10:30:50.01799	2015-10-20 10:30:50.01799	1	\N	t
\.


--
-- Name: supervisor_id_supervisor_seq; Type: SEQUENCE SET; Schema: evaluacion; Owner: postgres
--

SELECT pg_catalog.setval('supervisor_id_supervisor_seq', 1, false);


SET search_path = poa, pg_catalog;

--
-- Data for Name: acciones; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY acciones (id_accion, nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, meta, bien_servicio) FROM stdin;
1	ttttt	37	20	47	7	2	2016-03-18 15:07:50.31494	2	2016-03-18 15:07:50.31494	12	t	tttt	ttt
2	fff	36	20	47	8	437	2016-03-18 15:08:55.29337	437	2016-03-18 15:08:55.29337	12	t	fff	fff
3	oooo	37	50	47	8	437	2016-03-18 15:12:03.584809	437	2016-03-18 15:12:03.584809	12	t	oooo	ooooo
4	oooo	37	50	47	8	437	2016-03-18 15:13:14.691363	437	2016-03-18 15:13:14.691363	12	t	oooo	ooooo
5	ddddd	36	20	47	9	437	2016-03-18 15:39:41.023316	437	2016-03-18 15:39:41.023316	12	t	dddd	ddd
6	Accion 1	36	20	47	10	437	2016-03-19 19:44:20.91659	437	2016-03-19 19:44:20.91659	12	t	Meta 1	Bien o Servicio  1
7	Acción 01	36	120	47	11	437	2016-03-19 21:23:35.5094	437	2016-03-19 21:23:35.5094	12	t	Meta 01	Bien o Servicio 01
8	Accion	37	210	47	12	437	2016-03-19 22:53:24.792985	437	2016-03-19 22:53:24.792985	12	t	Meta	Bien o Sevicio
9	Accion 01	36	20	47	13	437	2016-03-20 01:10:11.071356	437	2016-03-20 01:10:11.071356	12	t	Meta	Bien
10	Accion 02	44	200	47	13	437	2016-03-20 01:11:31.14553	437	2016-03-20 01:11:31.14553	12	t	Meta	Bien o Servicio
11	Accion	36	120	47	14	2	2016-03-20 01:30:14.237993	2	2016-03-20 01:30:14.237993	12	t	Meta	Bien o Servicio
12	Accion	43	250	47	15	437	2016-03-20 02:11:34.351637	437	2016-03-20 02:11:34.351637	12	t	Meta	Bien o Servicio
13	Accion 03	36	20	47	13	437	2016-03-20 02:31:44.018164	437	2016-03-20 02:31:44.018164	12	t	Meta	Bien o Servicio
14	Accion 04	42	10	47	13	437	2016-03-20 02:51:41.566653	437	2016-03-20 02:51:41.566653	12	t	Meta	Bien o Servicio
\.


--
-- Name: acciones_id_accion_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('acciones_id_accion_seq', 14, true);


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY actividades (id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo) FROM stdin;
1	Actividad 01.1	36	120	7	437	2016-03-19 21:24:03.304421	437	2016-03-19 21:24:03.304421	15	t
2	Actividad 01.2	36	150	7	437	2016-03-19 21:24:38.392255	437	2016-03-19 21:24:38.392255	15	t
3	Actividad 01.3	36	200	7	437	2016-03-19 21:25:33.261154	437	2016-03-19 21:25:33.261154	15	t
4	Actividad 01.4	36	200	7	437	2016-03-19 21:26:38.817499	437	2016-03-19 21:26:38.817499	15	t
5	Actividad 01.5	36	20	7	437	2016-03-19 21:28:34.462618	437	2016-03-19 21:28:34.462618	15	t
6	ggggg	36	12	7	437	2016-03-19 21:29:59.546702	437	2016-03-19 21:29:59.546702	15	t
7	ggggg	36	12	7	437	2016-03-19 21:31:09.011445	437	2016-03-19 21:31:09.011445	15	t
8	45	36	20	7	437	2016-03-19 21:31:38.631532	437	2016-03-19 21:31:38.631532	15	t
9	20	36	20	7	437	2016-03-19 21:32:12.769931	437	2016-03-19 21:32:12.769931	15	t
10	Actividad 01.10	36	200	7	437	2016-03-19 21:33:46.739225	437	2016-03-19 21:33:46.739225	15	t
11	Actividad 01.11	36	20	7	437	2016-03-19 21:36:51.912589	437	2016-03-19 21:36:51.912589	15	t
12	Actividad 01.12	36	22	7	437	2016-03-19 21:37:34.174822	437	2016-03-19 21:37:34.174822	15	t
13	Actividad	44	100	10	437	2016-03-20 01:15:02.556535	437	2016-03-20 01:15:02.556535	15	t
14	Actividad 1.1	43	200	12	437	2016-03-20 02:12:18.002865	437	2016-03-20 02:12:18.002865	15	t
15	Actividad 1.2	43	50	12	437	2016-03-20 02:12:54.809394	437	2016-03-20 02:12:54.809394	15	t
16	Actividad 03.1	36	10	13	437	2016-03-20 02:32:16.100308	437	2016-03-20 02:32:16.100308	15	t
17	Actividad 03.2	36	10	13	437	2016-03-20 02:50:37.595264	437	2016-03-20 02:50:37.595264	15	t
18	Actividad 04.1	42	1	14	437	2016-03-20 02:52:23.339193	437	2016-03-20 02:52:23.339193	15	t
19	Actividad 04.2	42	9	14	437	2016-03-20 02:52:44.1205	437	2016-03-20 02:52:44.1205	15	t
\.


--
-- Name: actividades_id_actividades_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('actividades_id_actividades_seq', 19, true);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: poa; Owner: postgres
--

COPY comentarios (id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_poa, fk_tipo_entidad) FROM stdin;
1		355	2016-03-20 02:15:46.504754	\N	2016-03-20 02:15:46.504754	18	t	15	9
2		462	2016-03-20 02:16:16.662786	\N	2016-03-20 02:16:16.662786	18	t	15	10
3		355	2016-03-20 02:54:08.654814	\N	2016-03-20 02:54:08.654814	18	t	13	9
4		462	2016-03-20 02:55:09.039448	\N	2016-03-20 02:55:09.039448	18	t	13	10
\.


--
-- Name: comentarios_id_comentarios_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('comentarios_id_comentarios_seq', 4, true);


--
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
10	50	10	437	2016-03-19 19:43:34.611074	\N	2016-03-19 19:43:34.611074	21	t	8
11	50	11	437	2016-03-19 21:23:01.354726	\N	2016-03-19 21:23:01.354726	21	t	8
12	50	12	437	2016-03-19 22:52:49.074819	\N	2016-03-19 22:52:49.074819	21	t	8
13	50	13	437	2016-03-20 00:59:00.498748	\N	2016-03-20 00:59:00.498748	21	t	8
14	50	14	437	2016-03-20 01:22:55.265041	\N	2016-03-20 01:22:55.265041	21	t	8
15	50	15	437	2016-03-20 02:10:51.551442	\N	2016-03-20 02:10:51.551442	21	t	8
16	51	15	437	2016-03-20 02:13:46.680319	\N	2016-03-20 02:13:46.680319	21	t	8
17	51	14	437	2016-03-20 02:14:17.398315	\N	2016-03-20 02:14:17.398315	21	t	8
18	54	15	355	2016-03-20 02:15:46.482519	\N	2016-03-20 02:15:46.482519	21	t	9
19	52	15	462	2016-03-20 02:16:16.63992	\N	2016-03-20 02:16:16.63992	21	t	10
20	51	13	437	2016-03-20 02:53:09.273587	\N	2016-03-20 02:53:09.273587	21	t	8
21	54	13	355	2016-03-20 02:54:08.63561	\N	2016-03-20 02:54:08.63561	21	t	9
22	52	13	462	2016-03-20 02:55:08.942086	\N	2016-03-20 02:55:08.942086	21	t	10
\.


--
-- Name: estatus_poa_id_estatus_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('estatus_poa_id_estatus_poa_seq', 22, true);


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
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 74, true);


--
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
10	Nombre Proyecto	71	\N	\N	Objetivo Genral	\N		\N	\N	437	2016-03-19 19:43:34.548828	\N	2016-03-19 19:43:34.548828	24	t
11	Accion Centralizada	71	\N	\N	Objetivo General	\N		\N	\N	437	2016-03-19 21:23:01.292203	\N	2016-03-19 21:23:01.292203	24	t
12	Accion Centralizada	71	\N	\N	Objetivo	\N	lolo	\N	\N	437	2016-03-19 22:52:48.946979	\N	2016-03-19 22:52:48.946979	24	t
13	Accion Centralizada	71	\N	\N	Objetivo General	\N	Descripcion	\N	\N	437	2016-03-20 00:59:00.406798	\N	2016-03-20 00:59:00.406798	24	t
14	Accion Centralizada	71	\N	\N	Objetivo	\N		\N	\N	437	2016-03-20 01:22:55.210523	\N	2016-03-20 01:22:55.210523	24	t
15	Proyecto	70	Objetivo Historico	Objetivo Estrategico	Objetivo General	Institucional		2017-01-01 00:00:00	2017-12-29 00:00:00	437	2016-03-20 02:10:51.478807	\N	2016-03-20 02:10:51.478807	24	t
\.


--
-- Name: poa_id_poa_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('poa_id_poa_seq', 15, true);


--
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
25	57	437	2016-03-19 19:44:20.941536	\N	2016-03-19 19:44:20.941536	27	t	\N	1	73	6
26	58	437	2016-03-19 19:44:20.958874	\N	2016-03-19 19:44:20.958874	27	t	\N	1	73	6
27	59	437	2016-03-19 19:44:20.976584	\N	2016-03-19 19:44:20.976584	27	t	\N	1	73	6
28	60	437	2016-03-19 19:44:20.992399	\N	2016-03-19 19:44:20.992399	27	t	\N	2	73	6
29	61	437	2016-03-19 19:44:21.008718	\N	2016-03-19 19:44:21.008718	27	t	\N	2	73	6
30	62	437	2016-03-19 19:44:21.025849	\N	2016-03-19 19:44:21.025849	27	t	\N	2	73	6
31	63	437	2016-03-19 19:44:21.042456	\N	2016-03-19 19:44:21.042456	27	t	\N	3	73	6
32	64	437	2016-03-19 19:44:21.058854	\N	2016-03-19 19:44:21.058854	27	t	\N	3	73	6
33	65	437	2016-03-19 19:44:21.075941	\N	2016-03-19 19:44:21.075941	27	t	\N	3	73	6
34	66	437	2016-03-19 19:44:21.093317	\N	2016-03-19 19:44:21.093317	27	t	\N	4	73	6
35	67	437	2016-03-19 19:44:21.108864	\N	2016-03-19 19:44:21.108864	27	t	\N	4	73	6
36	68	437	2016-03-19 19:44:21.125576	\N	2016-03-19 19:44:21.125576	27	t	\N	4	73	6
37	57	437	2016-03-19 21:23:35.534509	\N	2016-03-19 21:23:35.534509	27	t	\N	10	73	7
38	58	437	2016-03-19 21:23:35.551411	\N	2016-03-19 21:23:35.551411	27	t	\N	10	73	7
39	59	437	2016-03-19 21:23:35.569364	\N	2016-03-19 21:23:35.569364	27	t	\N	10	73	7
40	60	437	2016-03-19 21:23:35.585268	\N	2016-03-19 21:23:35.585268	27	t	\N	10	73	7
41	61	437	2016-03-19 21:23:35.602585	\N	2016-03-19 21:23:35.602585	27	t	\N	10	73	7
42	62	437	2016-03-19 21:23:35.617006	\N	2016-03-19 21:23:35.617006	27	t	\N	10	73	7
43	63	437	2016-03-19 21:23:35.62582	\N	2016-03-19 21:23:35.62582	27	t	\N	10	73	7
44	64	437	2016-03-19 21:23:35.635934	\N	2016-03-19 21:23:35.635934	27	t	\N	10	73	7
45	65	437	2016-03-19 21:23:35.651535	\N	2016-03-19 21:23:35.651535	27	t	\N	10	73	7
46	66	437	2016-03-19 21:23:35.66767	\N	2016-03-19 21:23:35.66767	27	t	\N	10	73	7
47	67	437	2016-03-19 21:23:35.683217	\N	2016-03-19 21:23:35.683217	27	t	\N	10	73	7
48	68	437	2016-03-19 21:23:35.692525	\N	2016-03-19 21:23:35.692525	27	t	\N	10	73	7
49	61	437	2016-03-19 21:33:47.097634	\N	2016-03-19 21:33:47.097634	27	t	\N	12	74	10
50	58	437	2016-03-19 21:33:47.141422	\N	2016-03-19 21:33:47.141422	27	t	\N	12	74	10
51	57	437	2016-03-19 21:33:47.20396	\N	2016-03-19 21:33:47.20396	27	t	\N	12	74	10
52	59	437	2016-03-19 21:33:47.263961	\N	2016-03-19 21:33:47.263961	27	t	\N	12	74	10
53	62	437	2016-03-19 21:33:47.347896	\N	2016-03-19 21:33:47.347896	27	t	\N	12	74	10
54	60	437	2016-03-19 21:33:47.41729	\N	2016-03-19 21:33:47.41729	27	t	\N	12	74	10
55	63	437	2016-03-19 21:33:47.527621	\N	2016-03-19 21:33:47.527621	27	t	\N	12	74	10
56	65	437	2016-03-19 21:33:47.578579	\N	2016-03-19 21:33:47.578579	27	t	\N	12	74	10
57	64	437	2016-03-19 21:33:47.632679	\N	2016-03-19 21:33:47.632679	27	t	\N	12	74	10
58	66	437	2016-03-19 21:33:47.683653	\N	2016-03-19 21:33:47.683653	27	t	\N	10	74	10
59	68	437	2016-03-19 21:33:47.731223	\N	2016-03-19 21:33:47.731223	27	t	\N	10	74	10
60	67	437	2016-03-19 21:33:47.767854	\N	2016-03-19 21:33:47.767854	27	t	\N	10	74	10
61	57	437	2016-03-19 21:36:52.251885	\N	2016-03-19 21:36:52.251885	27	t	\N	1	74	11
62	59	437	2016-03-19 21:36:52.30644	\N	2016-03-19 21:36:52.30644	27	t	\N	1	74	11
63	58	437	2016-03-19 21:36:52.352727	\N	2016-03-19 21:36:52.352727	27	t	\N	1	74	11
64	60	437	2016-03-19 21:36:52.419386	\N	2016-03-19 21:36:52.419386	27	t	\N	1	74	11
65	63	437	2016-03-19 21:36:52.491935	\N	2016-03-19 21:36:52.491935	27	t	\N	1	74	11
66	61	437	2016-03-19 21:36:52.566863	\N	2016-03-19 21:36:52.566863	27	t	\N	1	74	11
67	64	437	2016-03-19 21:36:52.639803	\N	2016-03-19 21:36:52.639803	27	t	\N	1	74	11
68	62	437	2016-03-19 21:36:52.722373	\N	2016-03-19 21:36:52.722373	27	t	\N	1	74	11
69	65	437	2016-03-19 21:36:52.771581	\N	2016-03-19 21:36:52.771581	27	t	\N	1	74	11
70	66	437	2016-03-19 21:36:52.826707	\N	2016-03-19 21:36:52.826707	27	t	\N	1	74	11
71	67	437	2016-03-19 21:36:52.870312	\N	2016-03-19 21:36:52.870312	27	t	\N	1	74	11
72	68	437	2016-03-19 21:36:52.914292	\N	2016-03-19 21:36:52.914292	27	t	\N	9	74	11
73	57	437	2016-03-19 21:37:34.375568	\N	2016-03-19 21:37:34.375568	27	t	\N	8	74	12
74	58	437	2016-03-19 21:37:34.447946	\N	2016-03-19 21:37:34.447946	27	t	\N	1	74	12
75	59	437	2016-03-19 21:37:34.614151	\N	2016-03-19 21:37:34.614151	27	t	\N	1	74	12
76	60	437	2016-03-19 21:37:34.684611	\N	2016-03-19 21:37:34.684611	27	t	\N	1	74	12
77	61	437	2016-03-19 21:37:34.751365	\N	2016-03-19 21:37:34.751365	27	t	\N	1	74	12
78	62	437	2016-03-19 21:37:34.854688	\N	2016-03-19 21:37:34.854688	27	t	\N	1	74	12
79	64	437	2016-03-19 21:37:34.953418	\N	2016-03-19 21:37:34.953418	27	t	\N	1	74	12
80	63	437	2016-03-19 21:37:35.027492	\N	2016-03-19 21:37:35.027492	27	t	\N	1	74	12
81	65	437	2016-03-19 21:37:35.079889	\N	2016-03-19 21:37:35.079889	27	t	\N	1	74	12
82	66	437	2016-03-19 21:37:35.137689	\N	2016-03-19 21:37:35.137689	27	t	\N	1	74	12
83	67	437	2016-03-19 21:37:35.180593	\N	2016-03-19 21:37:35.180593	27	t	\N	1	74	12
84	68	437	2016-03-19 21:37:35.237989	\N	2016-03-19 21:37:35.237989	27	t	\N	4	74	12
85	57	437	2016-03-19 22:53:24.815833	\N	2016-03-19 22:53:24.815833	27	t	\N	2	73	8
86	58	437	2016-03-19 22:53:24.829363	\N	2016-03-19 22:53:24.829363	27	t	\N	2	73	8
87	59	437	2016-03-19 22:53:24.846008	\N	2016-03-19 22:53:24.846008	27	t	\N	2	73	8
88	60	437	2016-03-19 22:53:24.864208	\N	2016-03-19 22:53:24.864208	27	t	\N	5	73	8
89	61	437	2016-03-19 22:53:24.878795	\N	2016-03-19 22:53:24.878795	27	t	\N	5	73	8
90	62	437	2016-03-19 22:53:24.89487	\N	2016-03-19 22:53:24.89487	27	t	\N	5	73	8
91	63	437	2016-03-19 22:53:24.905628	\N	2016-03-19 22:53:24.905628	27	t	\N	6	73	8
92	64	437	2016-03-19 22:53:24.920372	\N	2016-03-19 22:53:24.920372	27	t	\N	6	73	8
93	65	437	2016-03-19 22:53:24.92806	\N	2016-03-19 22:53:24.92806	27	t	\N	6	73	8
94	66	437	2016-03-19 22:53:24.937353	\N	2016-03-19 22:53:24.937353	27	t	\N	7	73	8
95	67	437	2016-03-19 22:53:24.954227	\N	2016-03-19 22:53:24.954227	27	t	\N	7	73	8
96	68	437	2016-03-19 22:53:24.970405	\N	2016-03-19 22:53:24.970405	27	t	\N	7	73	8
97	57	437	2016-03-20 01:11:31.171592	\N	2016-03-20 01:11:31.171592	27	t	\N	10	73	10
98	58	437	2016-03-20 01:11:31.220646	\N	2016-03-20 01:11:31.220646	27	t	\N	10	73	10
99	59	437	2016-03-20 01:11:31.237314	\N	2016-03-20 01:11:31.237314	27	t	\N	20	73	10
100	60	437	2016-03-20 01:11:31.255304	\N	2016-03-20 01:11:31.255304	27	t	\N	10	73	10
101	61	437	2016-03-20 01:11:31.27229	\N	2016-03-20 01:11:31.27229	27	t	\N	20	73	10
102	62	437	2016-03-20 01:11:31.287506	\N	2016-03-20 01:11:31.287506	27	t	\N	20	73	10
103	63	437	2016-03-20 01:11:31.304005	\N	2016-03-20 01:11:31.304005	27	t	\N	10	73	10
104	64	437	2016-03-20 01:11:31.322105	\N	2016-03-20 01:11:31.322105	27	t	\N	20	73	10
105	65	437	2016-03-20 01:11:31.337404	\N	2016-03-20 01:11:31.337404	27	t	\N	10	73	10
106	66	437	2016-03-20 01:11:31.354759	\N	2016-03-20 01:11:31.354759	27	t	\N	22	73	10
107	67	437	2016-03-20 01:11:31.37013	\N	2016-03-20 01:11:31.37013	27	t	\N	10	73	10
108	68	437	2016-03-20 01:11:31.378559	\N	2016-03-20 01:11:31.378559	27	t	\N	10	73	10
109	61	437	2016-03-20 01:15:02.80784	\N	2016-03-20 01:15:02.80784	27	t	\N	7	74	13
110	60	437	2016-03-20 01:15:02.969813	\N	2016-03-20 01:15:02.969813	27	t	\N	6	74	13
111	62	437	2016-03-20 01:15:03.017548	\N	2016-03-20 01:15:03.017548	27	t	\N	8	74	13
112	59	437	2016-03-20 01:15:03.077338	\N	2016-03-20 01:15:03.077338	27	t	\N	5	74	13
113	58	437	2016-03-20 01:15:03.143571	\N	2016-03-20 01:15:03.143571	27	t	\N	4	74	13
114	57	437	2016-03-20 01:15:03.225716	\N	2016-03-20 01:15:03.225716	27	t	\N	2	74	13
115	64	437	2016-03-20 01:15:03.306677	\N	2016-03-20 01:15:03.306677	27	t	\N	20	74	13
116	63	437	2016-03-20 01:15:03.371771	\N	2016-03-20 01:15:03.371771	27	t	\N	9	74	13
117	67	437	2016-03-20 01:15:03.418225	\N	2016-03-20 01:15:03.418225	27	t	\N	33	74	13
118	65	437	2016-03-20 01:15:03.458395	\N	2016-03-20 01:15:03.458395	27	t	\N	20	74	13
119	68	437	2016-03-20 01:15:03.498966	\N	2016-03-20 01:15:03.498966	27	t	\N	20	74	13
120	66	437	2016-03-20 01:15:03.533225	\N	2016-03-20 01:15:03.533225	27	t	\N	30	74	13
121	57	2	2016-03-20 01:30:14.254265	\N	2016-03-20 01:30:14.254265	27	t	\N	10	73	11
122	58	2	2016-03-20 01:30:14.270526	\N	2016-03-20 01:30:14.270526	27	t	\N	10	73	11
123	59	2	2016-03-20 01:30:14.287205	\N	2016-03-20 01:30:14.287205	27	t	\N	10	73	11
124	60	2	2016-03-20 01:30:14.304437	\N	2016-03-20 01:30:14.304437	27	t	\N	10	73	11
125	61	2	2016-03-20 01:30:14.320681	\N	2016-03-20 01:30:14.320681	27	t	\N	10	73	11
126	62	2	2016-03-20 01:30:14.337281	\N	2016-03-20 01:30:14.337281	27	t	\N	10	73	11
127	63	2	2016-03-20 01:30:14.354434	\N	2016-03-20 01:30:14.354434	27	t	\N	10	73	11
128	64	2	2016-03-20 01:30:14.370574	\N	2016-03-20 01:30:14.370574	27	t	\N	10	73	11
129	65	2	2016-03-20 01:30:14.387225	\N	2016-03-20 01:30:14.387225	27	t	\N	10	73	11
130	66	2	2016-03-20 01:30:14.404469	\N	2016-03-20 01:30:14.404469	27	t	\N	10	73	11
131	67	2	2016-03-20 01:30:14.432496	\N	2016-03-20 01:30:14.432496	27	t	\N	10	73	11
132	68	2	2016-03-20 01:30:14.461793	\N	2016-03-20 01:30:14.461793	27	t	\N	10	73	11
133	57	437	2016-03-20 02:11:34.381659	\N	2016-03-20 02:11:34.381659	27	t	\N	12	73	12
134	58	437	2016-03-20 02:11:34.397852	\N	2016-03-20 02:11:34.397852	27	t	\N	10	73	12
135	59	437	2016-03-20 02:11:34.414388	\N	2016-03-20 02:11:34.414388	27	t	\N	8	73	12
136	60	437	2016-03-20 02:11:34.431172	\N	2016-03-20 02:11:34.431172	27	t	\N	12	73	12
137	61	437	2016-03-20 02:11:34.447831	\N	2016-03-20 02:11:34.447831	27	t	\N	8	73	12
138	62	437	2016-03-20 02:11:34.464407	\N	2016-03-20 02:11:34.464407	27	t	\N	10	73	12
139	63	437	2016-03-20 02:11:34.481276	\N	2016-03-20 02:11:34.481276	27	t	\N	10	73	12
140	64	437	2016-03-20 02:11:34.497998	\N	2016-03-20 02:11:34.497998	27	t	\N	10	73	12
141	65	437	2016-03-20 02:11:34.51453	\N	2016-03-20 02:11:34.51453	27	t	\N	10	73	12
142	66	437	2016-03-20 02:11:34.53132	\N	2016-03-20 02:11:34.53132	27	t	\N	10	73	12
143	67	437	2016-03-20 02:11:34.547993	\N	2016-03-20 02:11:34.547993	27	t	\N	10	73	12
144	68	437	2016-03-20 02:11:34.564576	\N	2016-03-20 02:11:34.564576	27	t	\N	200	73	12
145	57	437	2016-03-20 02:12:18.365393	\N	2016-03-20 02:12:18.365393	27	t	\N	10	74	14
146	62	437	2016-03-20 02:12:18.423412	\N	2016-03-20 02:12:18.423412	27	t	\N	10	74	14
147	61	437	2016-03-20 02:12:18.493559	\N	2016-03-20 02:12:18.493559	27	t	\N	10	74	14
148	59	437	2016-03-20 02:12:18.589291	\N	2016-03-20 02:12:18.589291	27	t	\N	10	74	14
149	58	437	2016-03-20 02:12:18.666924	\N	2016-03-20 02:12:18.666924	27	t	\N	10	74	14
150	60	437	2016-03-20 02:12:18.779905	\N	2016-03-20 02:12:18.779905	27	t	\N	10	74	14
151	63	437	2016-03-20 02:12:18.883552	\N	2016-03-20 02:12:18.883552	27	t	\N	10	74	14
152	64	437	2016-03-20 02:12:18.951001	\N	2016-03-20 02:12:18.951001	27	t	\N	10	74	14
153	65	437	2016-03-20 02:12:18.996599	\N	2016-03-20 02:12:18.996599	27	t	\N	10	74	14
154	66	437	2016-03-20 02:12:19.032679	\N	2016-03-20 02:12:19.032679	27	t	\N	10	74	14
155	67	437	2016-03-20 02:12:19.079062	\N	2016-03-20 02:12:19.079062	27	t	\N	10	74	14
156	68	437	2016-03-20 02:12:19.122802	\N	2016-03-20 02:12:19.122802	27	t	\N	90	74	14
157	59	437	2016-03-20 02:12:55.10391	\N	2016-03-20 02:12:55.10391	27	t	\N	5	74	15
158	57	437	2016-03-20 02:12:55.177182	\N	2016-03-20 02:12:55.177182	27	t	\N	5	74	15
159	58	437	2016-03-20 02:12:55.231906	\N	2016-03-20 02:12:55.231906	27	t	\N	5	74	15
160	61	437	2016-03-20 02:12:55.300124	\N	2016-03-20 02:12:55.300124	27	t	\N	5	74	15
161	62	437	2016-03-20 02:12:55.36628	\N	2016-03-20 02:12:55.36628	27	t	\N	5	74	15
162	60	437	2016-03-20 02:12:55.472212	\N	2016-03-20 02:12:55.472212	27	t	\N	5	74	15
163	63	437	2016-03-20 02:12:55.542173	\N	2016-03-20 02:12:55.542173	27	t	\N	5	74	15
164	64	437	2016-03-20 02:12:55.615913	\N	2016-03-20 02:12:55.615913	27	t	\N	5	74	15
165	65	437	2016-03-20 02:12:55.666135	\N	2016-03-20 02:12:55.666135	27	t	\N	5	74	15
166	66	437	2016-03-20 02:12:55.719793	\N	2016-03-20 02:12:55.719793	27	t	\N	2	74	15
167	67	437	2016-03-20 02:12:55.766644	\N	2016-03-20 02:12:55.766644	27	t	\N	1	74	15
168	68	437	2016-03-20 02:12:55.816192	\N	2016-03-20 02:12:55.816192	27	t	\N	2	74	15
169	57	437	2016-03-20 02:31:44.036845	\N	2016-03-20 02:31:44.036845	27	t	\N	1	73	13
170	58	437	2016-03-20 02:31:44.055801	\N	2016-03-20 02:31:44.055801	27	t	\N	1	73	13
171	59	437	2016-03-20 02:31:44.069207	\N	2016-03-20 02:31:44.069207	27	t	\N	1	73	13
172	60	437	2016-03-20 02:31:44.077766	\N	2016-03-20 02:31:44.077766	27	t	\N	1	73	13
173	61	437	2016-03-20 02:31:44.086894	\N	2016-03-20 02:31:44.086894	27	t	\N	2	73	13
174	62	437	2016-03-20 02:31:44.104919	\N	2016-03-20 02:31:44.104919	27	t	\N	2	73	13
175	63	437	2016-03-20 02:31:44.120352	\N	2016-03-20 02:31:44.120352	27	t	\N	1	73	13
176	64	437	2016-03-20 02:31:44.136934	\N	2016-03-20 02:31:44.136934	27	t	\N	1	73	13
177	65	437	2016-03-20 02:31:44.145357	\N	2016-03-20 02:31:44.145357	27	t	\N	1	73	13
178	66	437	2016-03-20 02:31:44.162173	\N	2016-03-20 02:31:44.162173	27	t	\N	2	73	13
179	67	437	2016-03-20 02:31:44.177537	\N	2016-03-20 02:31:44.177537	27	t	\N	2	73	13
180	68	437	2016-03-20 02:31:44.186843	\N	2016-03-20 02:31:44.186843	27	t	\N	4	73	13
181	57	437	2016-03-20 02:32:16.286708	\N	2016-03-20 02:32:16.286708	27	t	\N	1	74	16
182	58	437	2016-03-20 02:32:16.381977	\N	2016-03-20 02:32:16.381977	27	t	\N	1	74	16
183	59	437	2016-03-20 02:32:16.550848	\N	2016-03-20 02:32:16.550848	27	t	\N	1	74	16
184	60	437	2016-03-20 02:32:16.65754	\N	2016-03-20 02:32:16.65754	27	t	\N	0	74	16
185	62	437	2016-03-20 02:32:16.723917	\N	2016-03-20 02:32:16.723917	27	t	\N	1	74	16
186	61	437	2016-03-20 02:32:16.789097	\N	2016-03-20 02:32:16.789097	27	t	\N	1	74	16
187	63	437	2016-03-20 02:32:16.867497	\N	2016-03-20 02:32:16.867497	27	t	\N	1	74	16
188	64	437	2016-03-20 02:32:16.939969	\N	2016-03-20 02:32:16.939969	27	t	\N	1	74	16
189	66	437	2016-03-20 02:32:16.991909	\N	2016-03-20 02:32:16.991909	27	t	\N	1	74	16
190	65	437	2016-03-20 02:32:17.054773	\N	2016-03-20 02:32:17.054773	27	t	\N	0	74	16
191	67	437	2016-03-20 02:32:17.110879	\N	2016-03-20 02:32:17.110879	27	t	\N	1	74	16
192	68	437	2016-03-20 02:32:17.164686	\N	2016-03-20 02:32:17.164686	27	t	\N	1	74	16
193	58	437	2016-03-20 02:50:37.791069	\N	2016-03-20 02:50:37.791069	27	t	\N	1	74	17
194	57	437	2016-03-20 02:50:37.843378	\N	2016-03-20 02:50:37.843378	27	t	\N	1	74	17
195	59	437	2016-03-20 02:50:37.966605	\N	2016-03-20 02:50:37.966605	27	t	\N	0	74	17
196	60	437	2016-03-20 02:50:38.099281	\N	2016-03-20 02:50:38.099281	27	t	\N	1	74	17
197	63	437	2016-03-20 02:50:38.167449	\N	2016-03-20 02:50:38.167449	27	t	\N	1	74	17
198	61	437	2016-03-20 02:50:38.231821	\N	2016-03-20 02:50:38.231821	27	t	\N	1	74	17
199	62	437	2016-03-20 02:50:38.293449	\N	2016-03-20 02:50:38.293449	27	t	\N	1	74	17
200	64	437	2016-03-20 02:50:38.360448	\N	2016-03-20 02:50:38.360448	27	t	\N	1	74	17
201	65	437	2016-03-20 02:50:38.435612	\N	2016-03-20 02:50:38.435612	27	t	\N	1	74	17
202	66	437	2016-03-20 02:50:38.483646	\N	2016-03-20 02:50:38.483646	27	t	\N	1	74	17
203	68	437	2016-03-20 02:50:38.535163	\N	2016-03-20 02:50:38.535163	27	t	\N	1	74	17
204	67	437	2016-03-20 02:50:38.582867	\N	2016-03-20 02:50:38.582867	27	t	\N	0	74	17
205	57	437	2016-03-20 02:51:41.584153	\N	2016-03-20 02:51:41.584153	27	t	\N	1	73	14
206	58	437	2016-03-20 02:51:41.593124	\N	2016-03-20 02:51:41.593124	27	t	\N	1	73	14
207	59	437	2016-03-20 02:51:41.610017	\N	2016-03-20 02:51:41.610017	27	t	\N	0	73	14
208	60	437	2016-03-20 02:51:41.626689	\N	2016-03-20 02:51:41.626689	27	t	\N	0	73	14
209	61	437	2016-03-20 02:51:41.643215	\N	2016-03-20 02:51:41.643215	27	t	\N	0	73	14
210	62	437	2016-03-20 02:51:41.659997	\N	2016-03-20 02:51:41.659997	27	t	\N	0	73	14
211	63	437	2016-03-20 02:51:41.676829	\N	2016-03-20 02:51:41.676829	27	t	\N	5	73	14
212	64	437	2016-03-20 02:51:41.693263	\N	2016-03-20 02:51:41.693263	27	t	\N	1	73	14
213	65	437	2016-03-20 02:51:41.703883	\N	2016-03-20 02:51:41.703883	27	t	\N	0	73	14
214	66	437	2016-03-20 02:51:41.718814	\N	2016-03-20 02:51:41.718814	27	t	\N	0	73	14
215	67	437	2016-03-20 02:51:41.733759	\N	2016-03-20 02:51:41.733759	27	t	\N	1	73	14
216	68	437	2016-03-20 02:51:41.74213	\N	2016-03-20 02:51:41.74213	27	t	\N	1	73	14
217	59	437	2016-03-20 02:52:23.647922	\N	2016-03-20 02:52:23.647922	27	t	\N	0	74	18
218	57	437	2016-03-20 02:52:23.729303	\N	2016-03-20 02:52:23.729303	27	t	\N	0	74	18
219	60	437	2016-03-20 02:52:23.821712	\N	2016-03-20 02:52:23.821712	27	t	\N	0	74	18
220	62	437	2016-03-20 02:52:23.899904	\N	2016-03-20 02:52:23.899904	27	t	\N	0	74	18
221	58	437	2016-03-20 02:52:23.958837	\N	2016-03-20 02:52:23.958837	27	t	\N	0	74	18
222	61	437	2016-03-20 02:52:24.035768	\N	2016-03-20 02:52:24.035768	27	t	\N	1	74	18
223	63	437	2016-03-20 02:52:24.094984	\N	2016-03-20 02:52:24.094984	27	t	\N	0	74	18
224	64	437	2016-03-20 02:52:24.160342	\N	2016-03-20 02:52:24.160342	27	t	\N	0	74	18
225	65	437	2016-03-20 02:52:24.208821	\N	2016-03-20 02:52:24.208821	27	t	\N	0	74	18
226	66	437	2016-03-20 02:52:24.25381	\N	2016-03-20 02:52:24.25381	27	t	\N	0	74	18
227	67	437	2016-03-20 02:52:24.299783	\N	2016-03-20 02:52:24.299783	27	t	\N	0	74	18
228	68	437	2016-03-20 02:52:24.338909	\N	2016-03-20 02:52:24.338909	27	t	\N	0	74	18
229	57	437	2016-03-20 02:52:44.413574	\N	2016-03-20 02:52:44.413574	27	t	\N	1	74	19
230	59	437	2016-03-20 02:52:44.486812	\N	2016-03-20 02:52:44.486812	27	t	\N	1	74	19
231	58	437	2016-03-20 02:52:44.562428	\N	2016-03-20 02:52:44.562428	27	t	\N	1	74	19
232	61	437	2016-03-20 02:52:44.629576	\N	2016-03-20 02:52:44.629576	27	t	\N	1	74	19
233	62	437	2016-03-20 02:52:44.707926	\N	2016-03-20 02:52:44.707926	27	t	\N	1	74	19
234	60	437	2016-03-20 02:52:44.810488	\N	2016-03-20 02:52:44.810488	27	t	\N	1	74	19
235	63	437	2016-03-20 02:52:44.891045	\N	2016-03-20 02:52:44.891045	27	t	\N	1	74	19
236	64	437	2016-03-20 02:52:44.968869	\N	2016-03-20 02:52:44.968869	27	t	\N	1	74	19
237	66	437	2016-03-20 02:52:45.034467	\N	2016-03-20 02:52:45.034467	27	t	\N	0	74	19
238	65	437	2016-03-20 02:52:45.074841	\N	2016-03-20 02:52:45.074841	27	t	\N	1	74	19
239	67	437	2016-03-20 02:52:45.116961	\N	2016-03-20 02:52:45.116961	27	t	\N	0	74	19
240	68	437	2016-03-20 02:52:45.160681	\N	2016-03-20 02:52:45.160681	27	t	\N	0	74	19
\.


--
-- Name: rendimiento_id_rendimiento_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('rendimiento_id_rendimiento_seq', 240, true);


--
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
10	437	355	10	437	\N	2016-03-19 19:43:34.585239	2016-03-19 19:43:34.585239	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
11	437	355	11	437	\N	2016-03-19 21:23:01.330246	2016-03-19 21:23:01.330246	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
12	437	355	12	437	\N	2016-03-19 22:52:49.038537	2016-03-19 22:52:49.038537	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
13	437	355	13	437	\N	2016-03-20 00:59:00.454094	2016-03-20 00:59:00.454094	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
14	437	355	14	437	\N	2016-03-20 01:22:55.241777	2016-03-20 01:22:55.241777	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
15	437	355	15	437	\N	2016-03-20 02:10:51.527927	2016-03-20 02:10:51.527927	t	30	40	OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN
\.


--
-- Name: responsable_id_responsable_seq; Type: SEQUENCE SET; Schema: poa; Owner: postgres
--

SELECT pg_catalog.setval('responsable_id_responsable_seq', 15, true);


SET search_path = public, pg_catalog;

--
-- Data for Name: cruge_authassignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_authassignment (userid, bizrule, data, itemname) FROM stdin;
4	\N	N;	usuario_general
12	\N	N;	usuario_general
13	\N	N;	usuario_general
14	\N	N;	usuario_general
15	\N	N;	usuario_general
16	\N	N;	usuario_general
17	\N	N;	usuario_general
18	\N	N;	usuario_general
19	\N	N;	usuario_general
20	\N	N;	usuario_general
25	\N	N;	usuario_general
26	\N	N;	usuario_general
27	\N	N;	usuario_general
28	\N	N;	usuario_general
30	\N	N;	usuario_general
33	\N	N;	usuario_general
34	\N	N;	usuario_general
35	\N	N;	usuario_general
36	\N	N;	usuario_general
38	\N	N;	usuario_general
39	\N	N;	usuario_general
40	\N	N;	usuario_general
42	\N	N;	usuario_general
43	\N	N;	usuario_general
45	\N	N;	usuario_general
46	\N	N;	usuario_general
47	\N	N;	usuario_general
49	\N	N;	usuario_general
50	\N	N;	usuario_general
51	\N	N;	usuario_general
52	\N	N;	usuario_general
53	\N	N;	usuario_general
54	\N	N;	usuario_general
55	\N	N;	usuario_general
56	\N	N;	usuario_general
57	\N	N;	usuario_general
58	\N	N;	usuario_general
59	\N	N;	usuario_general
60	\N	N;	usuario_general
61	\N	N;	usuario_general
62	\N	N;	usuario_general
63	\N	N;	usuario_general
64	\N	N;	usuario_general
65	\N	N;	usuario_general
66	\N	N;	usuario_general
67	\N	N;	usuario_general
69	\N	N;	usuario_general
70	\N	N;	usuario_general
71	\N	N;	usuario_general
72	\N	N;	usuario_general
73	\N	N;	usuario_general
74	\N	N;	usuario_general
75	\N	N;	usuario_general
76	\N	N;	usuario_general
77	\N	N;	usuario_general
79	\N	N;	usuario_general
80	\N	N;	usuario_general
81	\N	N;	usuario_general
82	\N	N;	usuario_general
83	\N	N;	usuario_general
84	\N	N;	usuario_general
85	\N	N;	usuario_general
86	\N	N;	usuario_general
88	\N	N;	usuario_general
89	\N	N;	usuario_general
90	\N	N;	usuario_general
91	\N	N;	usuario_general
92	\N	N;	usuario_general
93	\N	N;	usuario_general
94	\N	N;	usuario_general
95	\N	N;	usuario_general
96	\N	N;	usuario_general
97	\N	N;	usuario_general
98	\N	N;	usuario_general
99	\N	N;	usuario_general
100	\N	N;	usuario_general
101	\N	N;	usuario_general
102	\N	N;	usuario_general
103	\N	N;	usuario_general
104	\N	N;	usuario_general
105	\N	N;	usuario_general
106	\N	N;	usuario_general
107	\N	N;	usuario_general
108	\N	N;	usuario_general
109	\N	N;	usuario_general
110	\N	N;	usuario_general
111	\N	N;	usuario_general
112	\N	N;	usuario_general
113	\N	N;	usuario_general
114	\N	N;	usuario_general
115	\N	N;	usuario_general
116	\N	N;	usuario_general
117	\N	N;	usuario_general
118	\N	N;	usuario_general
119	\N	N;	usuario_general
120	\N	N;	usuario_general
121	\N	N;	usuario_general
122	\N	N;	usuario_general
123	\N	N;	usuario_general
124	\N	N;	usuario_general
125	\N	N;	usuario_general
126	\N	N;	usuario_general
127	\N	N;	usuario_general
128	\N	N;	usuario_general
129	\N	N;	usuario_general
130	\N	N;	usuario_general
131	\N	N;	usuario_general
132	\N	N;	usuario_general
133	\N	N;	usuario_general
134	\N	N;	usuario_general
135	\N	N;	usuario_general
137	\N	N;	usuario_general
138	\N	N;	usuario_general
139	\N	N;	usuario_general
140	\N	N;	usuario_general
141	\N	N;	usuario_general
142	\N	N;	usuario_general
143	\N	N;	usuario_general
144	\N	N;	usuario_general
145	\N	N;	usuario_general
146	\N	N;	usuario_general
147	\N	N;	usuario_general
148	\N	N;	usuario_general
149	\N	N;	usuario_general
150	\N	N;	usuario_general
151	\N	N;	usuario_general
152	\N	N;	usuario_general
153	\N	N;	usuario_general
154	\N	N;	usuario_general
155	\N	N;	usuario_general
156	\N	N;	usuario_general
157	\N	N;	usuario_general
158	\N	N;	usuario_general
159	\N	N;	usuario_general
160	\N	N;	usuario_general
161	\N	N;	usuario_general
163	\N	N;	usuario_general
164	\N	N;	usuario_general
165	\N	N;	usuario_general
166	\N	N;	usuario_general
167	\N	N;	usuario_general
168	\N	N;	usuario_general
169	\N	N;	usuario_general
170	\N	N;	usuario_general
171	\N	N;	usuario_general
172	\N	N;	usuario_general
173	\N	N;	usuario_general
174	\N	N;	usuario_general
175	\N	N;	usuario_general
176	\N	N;	usuario_general
177	\N	N;	usuario_general
179	\N	N;	usuario_general
180	\N	N;	usuario_general
181	\N	N;	usuario_general
182	\N	N;	usuario_general
183	\N	N;	usuario_general
184	\N	N;	usuario_general
185	\N	N;	usuario_general
186	\N	N;	usuario_general
187	\N	N;	usuario_general
188	\N	N;	usuario_general
189	\N	N;	usuario_general
190	\N	N;	usuario_general
191	\N	N;	usuario_general
192	\N	N;	usuario_general
193	\N	N;	usuario_general
194	\N	N;	usuario_general
195	\N	N;	usuario_general
196	\N	N;	usuario_general
197	\N	N;	usuario_general
198	\N	N;	usuario_general
199	\N	N;	usuario_general
200	\N	N;	usuario_general
201	\N	N;	usuario_general
202	\N	N;	usuario_general
203	\N	N;	usuario_general
204	\N	N;	usuario_general
205	\N	N;	usuario_general
206	\N	N;	usuario_general
207	\N	N;	usuario_general
208	\N	N;	usuario_general
209	\N	N;	usuario_general
210	\N	N;	usuario_general
211	\N	N;	usuario_general
212	\N	N;	usuario_general
213	\N	N;	usuario_general
214	\N	N;	usuario_general
215	\N	N;	usuario_general
216	\N	N;	usuario_general
217	\N	N;	usuario_general
218	\N	N;	usuario_general
219	\N	N;	usuario_general
220	\N	N;	usuario_general
221	\N	N;	usuario_general
222	\N	N;	usuario_general
223	\N	N;	usuario_general
224	\N	N;	usuario_general
225	\N	N;	usuario_general
226	\N	N;	usuario_general
227	\N	N;	usuario_general
228	\N	N;	usuario_general
229	\N	N;	usuario_general
230	\N	N;	usuario_general
231	\N	N;	usuario_general
232	\N	N;	usuario_general
233	\N	N;	usuario_general
234	\N	N;	usuario_general
235	\N	N;	usuario_general
236	\N	N;	usuario_general
238	\N	N;	usuario_general
239	\N	N;	usuario_general
240	\N	N;	usuario_general
241	\N	N;	usuario_general
242	\N	N;	usuario_general
243	\N	N;	usuario_general
244	\N	N;	usuario_general
245	\N	N;	usuario_general
246	\N	N;	usuario_general
247	\N	N;	usuario_general
248	\N	N;	usuario_general
249	\N	N;	usuario_general
250	\N	N;	usuario_general
251	\N	N;	usuario_general
252	\N	N;	usuario_general
253	\N	N;	usuario_general
254	\N	N;	usuario_general
255	\N	N;	usuario_general
256	\N	N;	usuario_general
257	\N	N;	usuario_general
258	\N	N;	usuario_general
259	\N	N;	usuario_general
260	\N	N;	usuario_general
261	\N	N;	usuario_general
262	\N	N;	usuario_general
263	\N	N;	usuario_general
264	\N	N;	usuario_general
265	\N	N;	usuario_general
266	\N	N;	usuario_general
267	\N	N;	usuario_general
268	\N	N;	usuario_general
269	\N	N;	usuario_general
270	\N	N;	usuario_general
271	\N	N;	usuario_general
272	\N	N;	usuario_general
273	\N	N;	usuario_general
274	\N	N;	usuario_general
276	\N	N;	usuario_general
277	\N	N;	usuario_general
278	\N	N;	usuario_general
279	\N	N;	usuario_general
280	\N	N;	usuario_general
281	\N	N;	usuario_general
282	\N	N;	usuario_general
283	\N	N;	usuario_general
284	\N	N;	usuario_general
285	\N	N;	usuario_general
286	\N	N;	usuario_general
287	\N	N;	usuario_general
288	\N	N;	usuario_general
289	\N	N;	usuario_general
290	\N	N;	usuario_general
291	\N	N;	usuario_general
292	\N	N;	usuario_general
293	\N	N;	usuario_general
294	\N	N;	usuario_general
295	\N	N;	usuario_general
296	\N	N;	usuario_general
297	\N	N;	usuario_general
298	\N	N;	usuario_general
299	\N	N;	usuario_general
300	\N	N;	usuario_general
301	\N	N;	usuario_general
302	\N	N;	usuario_general
303	\N	N;	usuario_general
304	\N	N;	usuario_general
305	\N	N;	usuario_general
306	\N	N;	usuario_general
307	\N	N;	usuario_general
308	\N	N;	usuario_general
309	\N	N;	usuario_general
310	\N	N;	usuario_general
311	\N	N;	usuario_general
312	\N	N;	usuario_general
313	\N	N;	usuario_general
314	\N	N;	usuario_general
315	\N	N;	usuario_general
316	\N	N;	usuario_general
317	\N	N;	usuario_general
318	\N	N;	usuario_general
319	\N	N;	usuario_general
320	\N	N;	usuario_general
321	\N	N;	usuario_general
322	\N	N;	usuario_general
323	\N	N;	usuario_general
324	\N	N;	usuario_general
325	\N	N;	usuario_general
326	\N	N;	usuario_general
327	\N	N;	usuario_general
328	\N	N;	usuario_general
329	\N	N;	usuario_general
330	\N	N;	usuario_general
331	\N	N;	usuario_general
332	\N	N;	usuario_general
333	\N	N;	usuario_general
334	\N	N;	usuario_general
335	\N	N;	usuario_general
336	\N	N;	usuario_general
337	\N	N;	usuario_general
338	\N	N;	usuario_general
339	\N	N;	usuario_general
340	\N	N;	usuario_general
341	\N	N;	usuario_general
342	\N	N;	usuario_general
343	\N	N;	usuario_general
344	\N	N;	usuario_general
345	\N	N;	usuario_general
346	\N	N;	usuario_general
347	\N	N;	usuario_general
348	\N	N;	usuario_general
349	\N	N;	usuario_general
350	\N	N;	usuario_general
351	\N	N;	usuario_general
352	\N	N;	usuario_general
353	\N	N;	usuario_general
354	\N	N;	usuario_general
356	\N	N;	usuario_general
357	\N	N;	usuario_general
358	\N	N;	usuario_general
359	\N	N;	usuario_general
360	\N	N;	usuario_general
361	\N	N;	usuario_general
362	\N	N;	usuario_general
363	\N	N;	usuario_general
364	\N	N;	usuario_general
365	\N	N;	usuario_general
366	\N	N;	usuario_general
367	\N	N;	usuario_general
368	\N	N;	usuario_general
369	\N	N;	usuario_general
370	\N	N;	usuario_general
371	\N	N;	usuario_general
372	\N	N;	usuario_general
373	\N	N;	usuario_general
374	\N	N;	usuario_general
375	\N	N;	usuario_general
376	\N	N;	usuario_general
377	\N	N;	usuario_general
378	\N	N;	usuario_general
379	\N	N;	usuario_general
380	\N	N;	usuario_general
381	\N	N;	usuario_general
383	\N	N;	usuario_general
385	\N	N;	usuario_general
386	\N	N;	usuario_general
387	\N	N;	usuario_general
388	\N	N;	usuario_general
389	\N	N;	usuario_general
390	\N	N;	usuario_general
391	\N	N;	usuario_general
392	\N	N;	usuario_general
393	\N	N;	usuario_general
394	\N	N;	usuario_general
395	\N	N;	usuario_general
396	\N	N;	usuario_general
397	\N	N;	usuario_general
398	\N	N;	usuario_general
399	\N	N;	usuario_general
400	\N	N;	usuario_general
401	\N	N;	usuario_general
402	\N	N;	usuario_general
403	\N	N;	usuario_general
404	\N	N;	usuario_general
405	\N	N;	usuario_general
406	\N	N;	usuario_general
407	\N	N;	usuario_general
408	\N	N;	usuario_general
409	\N	N;	usuario_general
410	\N	N;	usuario_general
411	\N	N;	usuario_general
412	\N	N;	usuario_general
413	\N	N;	usuario_general
414	\N	N;	usuario_general
415	\N	N;	usuario_general
416	\N	N;	usuario_general
417	\N	N;	usuario_general
418	\N	N;	usuario_general
419	\N	N;	usuario_general
420	\N	N;	usuario_general
421	\N	N;	usuario_general
422	\N	N;	usuario_general
423	\N	N;	usuario_general
424	\N	N;	usuario_general
425	\N	N;	usuario_general
426	\N	N;	usuario_general
427	\N	N;	usuario_general
428	\N	N;	usuario_general
429	\N	N;	usuario_general
430	\N	N;	usuario_general
432	\N	N;	usuario_general
433	\N	N;	usuario_general
434	\N	N;	usuario_general
435	\N	N;	usuario_general
436	\N	N;	usuario_general
355	\N	N;	registro_mrl
438	\N	N;	usuario_general
23	\N	N;	administrador_mrl
431	\N	N;	administrador_mrl
54	\N	N;	registro_mrl
22	\N	N;	registro_mrl
9	\N	N;	registro_mrl
397	\N	N;	registro_mrl
401	\N	N;	registro_mrl
143	\N	N;	registro_mrl
275	\N	N;	registro_mrl
400	\N	N;	registro_mrl
431	\N	N;	registro_mrl
23	\N	N;	registro_mrl
23	\N	N;	rrhh_mrl_verificacion
24	\N	N;	registro_mrl
68	\N	N;	registro_mrl
440	\N	N;	registro_mrl
440	\N	N;	usuario_general
114	\N	N;	registro_mrl
155	\N	N;	registro_mrl
263	\N	N;	registro_mrl
183	\N	N;	registro_mrl
246	\N	N;	registro_mrl
204	\N	N;	registro_mrl
230	\N	N;	registro_mrl
390	\N	N;	registro_mrl
394	\N	N;	registro_mrl
404	\N	N;	registro_mrl
405	\N	N;	registro_mrl
41	\N	N;	registro_mrl
376	\N	N;	registro_mrl
442	\N	N;	registro_mrl
443	\N	N;	registro_mrl
225	\N	N;	registro_mrl
280	\N	N;	registro_mrl
299	\N	N;	registro_mrl
444	\N	N;	registro_mrl
213	\N	N;	registro_mrl
265	\N	N;	registro_mrl
445	\N	N;	registro_mrl
245	\N	N;	registro_mrl
414	\N	N;	registro_mrl
358	\N	N;	registro_mrl
360	\N	N;	registro_mrl
349	\N	N;	registro_mrl
447	\N	N;	registro_mrl
233	\N	N;	registro_mrl
330	\N	N;	registro_mrl
234	\N	N;	registro_mrl
363	\N	N;	registro_mrl
235	\N	N;	registro_mrl
352	\N	N;	registro_mrl
324	\N	N;	registro_mrl
449	\N	N;	registro_mrl
450	\N	N;	registro_mrl
451	\N	N;	registro_mrl
452	\N	N;	registro_mrl
453	\N	N;	registro_mrl
455	\N	N;	registro_mrl
456	\N	N;	registro_mrl
457	\N	N;	usuario_general
458	\N	N;	registro_mrl
32	\N	N;	usuario_general
460	\N	N;	usuario_general
463	\N	N;	usuario_general
464	\N	N;	usuario_general
11	\N	N;	rrhh_mrl_verificacion
11	\N	N;	administrador_mrl
23	\N	N;	administrador_tecnologia
437	\N	N;	administrador_tecnologia
437	\N	N;	usuario_general
437	\N	N;	registro_mrl
437	\N	N;	rrhh_mrl_verificacion
467	\N	N;	administrador_mrl
467	\N	N;	rrhh_mrl_verificacion
468	\N	N;	registro_mrl
11	\N	N;	usuario_general
11	\N	N;	registro_mrl
11	\N	N;	super_administrador
11	\N	N;	administrador_sistema
11	\N	N;	administrador_actualizacion
11	\N	N;	administrador_tecnologia
21	\N	N;	registro_mrl
29	\N	N;	registro_mrl
31	\N	N;	registro_mrl
44	\N	N;	registro_mrl
48	\N	N;	usuario_general
37	\N	N;	registro_mrl
162	\N	N;	registro_mrl
384	\N	N;	registro_mrl
446	\N	N;	registro_mrl
87	\N	N;	registro_mrl
382	\N	N;	registro_mrl
469	\N	N;	registro_mrl
454	\N	N;	registro_mrl
439	\N	N;	registro_mrl
471	\N	N;	usuario_general
136	\N	N;	registro_mrl
437	\N	N;	administrador_mrl
178	\N	N;	usuario_general
470	\N	N;	registro_mrl
1	\N	N;	administrador_tecnologia
462	\N	N;	administrador_tecnologia
437	\N	N;	registro_poa
355	\N	N;	administrador_poa
462	\N	N;	evaluador_poa
\.


--
-- Data for Name: cruge_authitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_authitem (name, type, description, bizrule, data) FROM stdin;
action_ui_usermanagementadmin	0		\N	N;
admin	0		\N	N;
action_ui_usermanagementupdate	0		\N	N;
administrador	0		\N	N;
action_ui_rbaclistroles	0		\N	N;
controller_ciudad	0		\N	N;
action_ciudad_view	0		\N	N;
action_ciudad_create	0		\N	N;
action_ciudad_update	0		\N	N;
action_ciudad_delete	0		\N	N;
action_ciudad_index	0		\N	N;
action_ciudad_admin	0		\N	N;
controller_datosrequisicion	0		\N	N;
action_datosrequisicion_view	0		\N	N;
action_datosrequisicion_create	0		\N	N;
action_datosrequisicion_update	0		\N	N;
action_datosrequisicion_delete	0		\N	N;
action_datosrequisicion_index	0		\N	N;
action_datosrequisicion_admin	0		\N	N;
controller_educacion	0		\N	N;
action_educacion_view	0		\N	N;
action_educacion_create	0		\N	N;
action_educacion_update	0		\N	N;
action_educacion_delete	0		\N	N;
action_educacion_index	0		\N	N;
action_educacion_admin	0		\N	N;
controller_familiar	0		\N	N;
action_familiar_view	0		\N	N;
action_familiar_create	0		\N	N;
action_familiar_update	0		\N	N;
action_familiar_delete	0		\N	N;
action_familiar_index	0		\N	N;
action_familiar_admin	0		\N	N;
controller_pais	0		\N	N;
action_pais_view	0		\N	N;
action_pais_create	0		\N	N;
action_pais_update	0		\N	N;
action_pais_delete	0		\N	N;
action_pais_index	0		\N	N;
action_pais_admin	0		\N	N;
controller_parroquia	0		\N	N;
action_parroquia_view	0		\N	N;
action_parroquia_create	0		\N	N;
action_parroquia_update	0		\N	N;
action_parroquia_delete	0		\N	N;
action_parroquia_index	0		\N	N;
action_parroquia_admin	0		\N	N;
controller_personal	0		\N	N;
action_personal_view	0		\N	N;
action_personal_create	0		\N	N;
action_personal_update	0		\N	N;
action_personal_delete	0		\N	N;
action_personal_index	0		\N	N;
action_personal_admin	0		\N	N;
controller_puebloindigena	0		\N	N;
action_puebloindigena_view	0		\N	N;
action_puebloindigena_create	0		\N	N;
action_puebloindigena_update	0		\N	N;
action_puebloindigena_delete	0		\N	N;
action_puebloindigena_index	0		\N	N;
action_puebloindigena_admin	0		\N	N;
controller_site	0		\N	N;
action_site_index	0		\N	N;
action_site_error	0		\N	N;
action_site_contact	0		\N	N;
action_site_login	0		\N	N;
action_site_logout	0		\N	N;
controller_validacionjs	0		\N	N;
action_validacionjs_buscarsaime	0		\N	N;
action_validacionjs_buscartitulo	0		\N	N;
action_validacionjs_buscarestados	0		\N	N;
action_validacionjs_buscarciudad	0		\N	N;
action_validacionjs_buscarrrhh	0		\N	N;
action_validacionjs_guardarfamiliar	0		\N	N;
action_validacionjs_actualizarfamiliar	0		\N	N;
action_validacionjs_guardarpersonal1	0		\N	N;
action_validacionjs_buscarindigena	0		\N	N;
action_validacionjs_buscarestados2	0		\N	N;
action_validacionjs_buscarciudad2	0		\N	N;
action_validacionjs_guardarpersonales	0		\N	N;
action_validacionjs_buscarmunicipiosrequisicion	0		\N	N;
action_validacionjs_buscarparroquiasrequisicion	0		\N	N;
action_ui_rbacauthitemcreate	0		\N	N;
usuario_general	2			N;
action_ui_rbacusersassignments	0		\N	N;
action_ui_usermanagementdelete	0		\N	N;
action_ui_usermanagementcreate	0		\N	N;
action_ui_sessionadmin	0		\N	N;
super_administrador	2			N;
action_familiar_Create	0		\N	N;
action_familiar_finalizar	0		\N	N;
action_site_registrofinal	0		\N	N;
action_validacionjs_buscarestadosres	0		\N	N;
action_validacionjs_buscarciudadres	0		\N	N;
action_validacionjs_buscapersona	0		\N	N;
action_validacionjs_search	0		\N	N;
action_ui_rbacauthitemchilditems	0		\N	N;
action_ui_rbacajaxsetchilditem	0		\N	N;
action_educacion_Create	0		\N	N;
action_ui_rbacauthitemupdate	0		\N	N;
controller_vswusuariosactualizados	0		\N	N;
action_vswusuariosactualizados_view	0		\N	N;
action_vswusuariosactualizados_create	0		\N	N;
action_vswusuariosactualizados_update	0		\N	N;
action_vswusuariosactualizados_delete	0		\N	N;
action_vswusuariosactualizados_index	0		\N	N;
action_vswusuariosactualizados_admin	0		\N	N;
action_personal_Create	0		\N	N;
controller_persona	0		\N	N;
action_persona_view	0		\N	N;
action_persona_create	0		\N	N;
action_persona_update	0		\N	N;
action_persona_delete	0		\N	N;
action_persona_index	0		\N	N;
action_persona_admin	0		\N	N;
action_vswusuariosactualizados_historico	0		\N	N;
action_personal_createActualizar	0		\N	N;
action_personal_createactualizar	0		\N	N;
action_educacion_createactualizarestudio	0		\N	N;
action_educacion_createActualizarEstudio	0		\N	N;
action_familiar_createactualizarfamilia	0		\N	N;
action_familiar_createActualizarFamilia	0		\N	N;
controller_evaluacion	0		\N	N;
action_evaluacion_view	0		\N	N;
action_evaluacion_create	0		\N	N;
action_evaluacion_update	0		\N	N;
action_evaluacion_delete	0		\N	N;
action_evaluacion_index	0		\N	N;
action_evaluacion_admin	0		\N	N;
controller_pedido	0		\N	N;
action_pedido_view	0		\N	N;
action_pedido_create	0		\N	N;
action_pedido_update	0		\N	N;
action_pedido_delete	0		\N	N;
action_pedido_index	0		\N	N;
action_pedido_admin	0		\N	N;
controller_pedidoespecial	0		\N	N;
action_pedidoespecial_view	0		\N	N;
action_pedidoespecial_create	0		\N	N;
action_pedidoespecial_update	0		\N	N;
action_pedidoespecial_delete	0		\N	N;
action_pedidoespecial_index	0		\N	N;
action_pedidoespecial_admin	0		\N	N;
action_validacionjs_guardardatosrequisicion	0		\N	N;
action_validacionjs_guardarobjetivo	0		\N	N;
administrador_sistema	2			N;
action_ui_rbacajaxassignment	0		\N	N;
action_evaluacion_odi	0		\N	N;
action_validacionjs_buscarsupervisor	0		\N	N;
action_validacionjs_buscarsupervisado	0		\N	N;
administrador_tecnologia	2	administrador_tecnologia		N;
action_evaluacion_objetivosincompleto	0		\N	N;
action_evaluacion_enviarodi	0		\N	N;
action_evaluacion_revisado	0		\N	N;
action_evaluacion_recursoshumanos	0		\N	N;
action_evaluacion_dir	0		\N	N;
action_evaluacion_updaterrhh	0		\N	N;
action_evaluacion_rrhheditar	0		\N	N;
action_evaluacion_direditar	0		\N	N;
action_evaluacion_updateobjetivos	0		\N	N;
action_evaluacion_certificado	0		\N	N;
action_validacionjs_buscarlistar	0		\N	N;
action_validacionjs_dibujarobjetivo	0		\N	N;
action_validacionjs_eliminarobjetivo	0		\N	N;
controller_vswlistarpersonas	0		\N	N;
action_vswlistarpersonas_view	0		\N	N;
action_vswlistarpersonas_create	0		\N	N;
action_vswlistarpersonas_update	0		\N	N;
action_vswlistarpersonas_delete	0		\N	N;
action_vswlistarpersonas_index	0		\N	N;
action_vswlistarpersonas_enviarodi	0		\N	N;
action_vswlistarpersonas_admin	0		\N	N;
action_vswlistarpersonas_recursoshumanos	0		\N	N;
controller_vswpdfevaluacion	0		\N	N;
action_vswpdfevaluacion_index	0		\N	N;
action_vswpdfevaluacion_create	0		\N	N;
action_vswpdfevaluacion_update	0		\N	N;
action_vswpdfevaluacion_updateobjetivo	0		\N	N;
action_vswpdfevaluacion_admin	0		\N	N;
administrador_mrl	2	administrador_mrl		N;
registro_mrl	2	registro_mrl		N;
rrhh_mrl_verificacion	2	rrhh_mrl_verificacion		N;
action_ui_fieldsadminlist	0		\N	N;
administrador_actualizacion	2			N;
action_ui_rbacajaxgetassignmentbizrule	0		\N	N;
action_ui_rbacajaxsetassignmentbizrule	0		\N	N;
action_ui_rbaclistops	0		\N	N;
action_ui_rbaclisttasks	0		\N	N;
action_ui_editprofile	0		\N	N;
action_graficas_graficarecepcion	0		\N	N;
action_ui_UserManagementUpdate_1	0		\N	N;
action_evaluacion_objetivosobrerosincompleto	0		\N	N;
action_evaluacion_eliminareva	0		\N	N;
action_evaluacion_eliminarevaluacion	0		\N	N;
action_evaluacion_pdfevaluacion	0		\N	N;
action_evaluacion_pdfobrero	0		\N	N;
action_evaluacion_create_revi	0		\N	N;
action_evaluacion_rrhh_cierre	0		\N	N;
action_evaluacion_renovarevaluacion	0		\N	N;
controller_graficas	0		\N	N;
action_graficas_graficanacionalidad	0		\N	N;
action_graficas_graficasolicitud	0		\N	N;
action_graficas_graficatiposolicitud	0		\N	N;
action_graficas_graficabeneficiarioestado	0		\N	N;
action_graficas_graficatipoayuda	0		\N	N;
action_graficas_graficaanalista	0		\N	N;
action_graficas_graficaestatus	0		\N	N;
action_graficas_graficanacionalidad1	0		\N	N;
action_graficas_graficaanual	0		\N	N;
action_graficas_graficagestion	0		\N	N;
action_validacionjs_editarobjetivos	0		\N	N;
action_validacionjs_editarevaluacion	0		\N	N;
controller_vswpdfreporte	0		\N	N;
action_vswpdfreporte_view	0		\N	N;
action_vswpdfreporte_reporte	0		\N	N;
action_vswpdfreporte_certificado	0		\N	N;
action_vswpdfreporte_exel	0		\N	N;
action_vswpdfreporte_create	0		\N	N;
action_vswpdfreporte_update	0		\N	N;
action_vswpdfreporte_delete	0		\N	N;
action_vswpdfreporte_index	0		\N	N;
action_vswpdfreporte_admin	0		\N	N;
action_evaluacion_createobrero	0		\N	N;
action_ui_fieldsadmincreate	0		\N	N;
action_graficas_graficaodis	0		\N	N;
controller_vswreportefinal	0		\N	N;
action_vswreportefinal_view	0		\N	N;
action_vswreportefinal_reporte	0		\N	N;
action_vswreportefinal_certificado	0		\N	N;
action_vswreportefinal_exel	0		\N	N;
action_vswreportefinal_update	0		\N	N;
action_vswreportefinal_delete	0		\N	N;
action_vswreportefinal_index	0		\N	N;
action_vswreportefinal_admin	0		\N	N;
action_ui_fieldsadminupdate	0		\N	N;
registro_poa	0		\N	N;
administrador_poa	0		\N	N;
evaluador_poa	0		\N	N;
action_evaluacion_reporte_rechazados	0		\N	N;
controller_poa	0		\N	N;
action_poa_view	0		\N	N;
action_poa_view_accion	0		\N	N;
action_poa_view_evaluar	0		\N	N;
action_poa_create	0		\N	N;
action_poa_create_accion	0		\N	N;
action_poa_create_actividad	0		\N	N;
action_poa_update	0		\N	N;
action_poa_delete	0		\N	N;
action_poa_index	0		\N	N;
action_poa_admin	0		\N	N;
action_validacionjs_dibujaractividad	0		\N	N;
action_validacionjs_eliminaractividad	0		\N	N;
\.


--
-- Data for Name: cruge_authitemchild; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_authitemchild (parent, child) FROM stdin;
usuario_general	action_familiar_view
usuario_general	action_familiar_create
usuario_general	action_familiar_delete
usuario_general	action_familiar_update
usuario_general	action_familiar_admin
usuario_general	action_familiar_Create
usuario_general	action_familiar_finalizar
usuario_general	action_familiar_index
usuario_general	action_educacion_view
usuario_general	action_educacion_create
usuario_general	action_educacion_index
usuario_general	action_educacion_delete
usuario_general	action_educacion_update
usuario_general	action_educacion_admin
usuario_general	action_personal_create
usuario_general	action_personal_update
usuario_general	action_personal_delete
usuario_general	action_personal_index
usuario_general	action_personal_admin
usuario_general	controller_familiar
usuario_general	controller_educacion
usuario_general	controller_personal
usuario_general	controller_site
usuario_general	action_site_index
usuario_general	action_site_login
usuario_general	action_site_logout
usuario_general	action_site_registrofinal
usuario_general	action_site_contact
usuario_general	action_site_error
usuario_general	action_educacion_Create
usuario_general	action_vswusuariosactualizados_view
usuario_general	action_vswusuariosactualizados_create
usuario_general	action_vswusuariosactualizados_update
usuario_general	action_vswusuariosactualizados_delete
usuario_general	action_vswusuariosactualizados_index
usuario_general	action_vswusuariosactualizados_admin
usuario_general	controller_vswusuariosactualizados
usuario_general	action_personal_createActualizar
usuario_general	action_personal_createactualizar
usuario_general	action_educacion_createactualizarestudio
usuario_general	action_personal_Create
usuario_general	action_educacion_createActualizarEstudio
usuario_general	action_familiar_createactualizarfamilia
usuario_general	action_familiar_createActualizarFamilia
usuario_general	action_personal_view
administrador_sistema	action_vswusuariosactualizados_historico
administrador_sistema	action_vswusuariosactualizados_admin
administrador_sistema	action_ui_usermanagementadmin
administrador_sistema	action_ui_usermanagementupdate
administrador_sistema	action_ui_rbaclistroles
administrador_sistema	action_ui_rbacauthitemcreate
administrador_sistema	action_ui_rbacusersassignments
administrador_sistema	action_ui_usermanagementdelete
administrador_sistema	action_ui_usermanagementcreate
administrador_sistema	action_ui_sessionadmin
administrador_sistema	action_ui_rbacauthitemchilditems
administrador_sistema	action_ui_rbacajaxsetchilditem
administrador_sistema	action_ui_rbacauthitemupdate
administrador_sistema	action_ui_rbacajaxassignment
administrador_tecnologia	administrador
administrador_tecnologia	controller_persona
administrador_tecnologia	action_persona_view
administrador_tecnologia	action_persona_create
administrador_tecnologia	action_persona_update
administrador_tecnologia	action_persona_delete
administrador_tecnologia	action_persona_index
administrador_tecnologia	action_persona_admin
administrador_tecnologia	controller_ciudad
administrador_tecnologia	controller_educacion
administrador_tecnologia	controller_familiar
administrador_tecnologia	controller_pais
administrador_tecnologia	controller_parroquia
administrador_tecnologia	controller_personal
administrador_tecnologia	controller_puebloindigena
administrador_tecnologia	controller_validacionjs
administrador_tecnologia	controller_vswusuariosactualizados
administrador_tecnologia	controller_evaluacion
administrador_tecnologia	action_ciudad_admin
administrador_tecnologia	action_ciudad_index
administrador_tecnologia	action_ciudad_delete
administrador_tecnologia	action_ciudad_update
administrador_tecnologia	action_ciudad_create
administrador_tecnologia	action_ciudad_view
administrador_tecnologia	action_educacion_view
administrador_tecnologia	action_educacion_create
administrador_tecnologia	action_educacion_update
administrador_tecnologia	action_educacion_delete
administrador_tecnologia	action_educacion_index
administrador_tecnologia	action_educacion_admin
administrador_tecnologia	action_educacion_Create
administrador_tecnologia	action_educacion_createactualizarestudio
administrador_tecnologia	action_educacion_createActualizarEstudio
administrador_tecnologia	action_evaluacion_odi
administrador_tecnologia	action_evaluacion_admin
administrador_tecnologia	action_evaluacion_index
administrador_tecnologia	action_evaluacion_delete
administrador_tecnologia	action_evaluacion_update
administrador_tecnologia	action_evaluacion_create
administrador_tecnologia	action_evaluacion_view
administrador_tecnologia	action_familiar_createactualizarfamilia
administrador_tecnologia	action_familiar_finalizar
administrador_tecnologia	action_familiar_Create
administrador_tecnologia	action_familiar_admin
administrador_tecnologia	action_familiar_index
administrador_tecnologia	action_familiar_delete
administrador_tecnologia	action_familiar_update
administrador_tecnologia	action_familiar_create
administrador_tecnologia	action_familiar_view
administrador_tecnologia	action_pais_admin
administrador_tecnologia	action_pais_index
administrador_tecnologia	action_pais_delete
administrador_tecnologia	action_pais_update
administrador_tecnologia	action_pais_create
administrador_tecnologia	action_pais_view
administrador_tecnologia	action_personal_createactualizar
administrador_tecnologia	action_personal_createActualizar
administrador_tecnologia	action_personal_Create
administrador_tecnologia	action_personal_admin
administrador_tecnologia	action_personal_index
administrador_tecnologia	action_personal_delete
administrador_tecnologia	action_personal_update
administrador_tecnologia	action_personal_create
administrador_tecnologia	action_personal_view
administrador_tecnologia	action_parroquia_view
administrador_tecnologia	action_parroquia_create
administrador_tecnologia	action_parroquia_update
administrador_tecnologia	action_parroquia_delete
administrador_tecnologia	action_parroquia_index
administrador_tecnologia	action_parroquia_admin
administrador_tecnologia	action_validacionjs_buscarrrhh
administrador_tecnologia	action_validacionjs_guardarobjetivo
administrador_tecnologia	action_validacionjs_buscarsupervisor
administrador_tecnologia	action_validacionjs_buscarsupervisado
administrador_tecnologia	action_ui_usermanagementadmin
administrador_tecnologia	action_ui_usermanagementcreate
administrador_mrl	controller_evaluacion
administrador_mrl	action_evaluacion_odi
administrador_mrl	action_evaluacion_recursoshumanos
administrador_mrl	action_evaluacion_updaterrhh
administrador_mrl	action_evaluacion_rrhheditar
administrador_mrl	action_site_index
administrador_mrl	action_ui_usermanagementadmin
administrador_mrl	action_ui_usermanagementupdate
administrador_mrl	action_ui_rbacusersassignments
administrador_mrl	action_ui_usermanagementcreate
registro_mrl	admin
registro_mrl	controller_validacionjs
registro_mrl	controller_evaluacion
registro_mrl	controller_vswlistarpersonas
registro_mrl	controller_vswpdfevaluacion
registro_mrl	action_evaluacion_create
registro_mrl	action_evaluacion_admin
registro_mrl	action_evaluacion_odi
registro_mrl	action_evaluacion_enviarodi
registro_mrl	action_evaluacion_revisado
registro_mrl	action_evaluacion_dir
registro_mrl	action_evaluacion_direditar
registro_mrl	action_evaluacion_updateobjetivos
registro_mrl	action_evaluacion_certificado
registro_mrl	action_site_index
registro_mrl	action_validacionjs_guardarobjetivo
registro_mrl	action_validacionjs_buscarsupervisor
registro_mrl	action_validacionjs_buscarsupervisado
registro_mrl	action_validacionjs_buscarlistar
registro_mrl	action_validacionjs_dibujarobjetivo
registro_mrl	action_validacionjs_eliminarobjetivo
rrhh_mrl_verificacion	controller_evaluacion
rrhh_mrl_verificacion	action_evaluacion_recursoshumanos
rrhh_mrl_verificacion	action_evaluacion_updaterrhh
rrhh_mrl_verificacion	action_evaluacion_rrhheditar
administrador_actualizacion	super_administrador
administrador_actualizacion	action_ui_usermanagementadmin
administrador_actualizacion	action_ui_usermanagementupdate
administrador_actualizacion	action_ui_rbacusersassignments
administrador_actualizacion	action_ui_usermanagementcreate
administrador_tecnologia	action_ui_usermanagementupdate
usuario_general	action_ui_UserManagementUpdate_1
administrador_mrl	action_ui_rbaclistroles
administrador_mrl	action_ui_rbacauthitemcreate
administrador_mrl	action_ui_usermanagementdelete
administrador_mrl	action_ui_sessionadmin
administrador_mrl	action_ui_rbacauthitemchilditems
administrador_mrl	action_ui_rbacajaxsetchilditem
administrador_mrl	action_ui_rbacauthitemupdate
administrador_mrl	action_ui_rbacajaxassignment
administrador_mrl	action_ui_fieldsadminlist
administrador_mrl	action_ui_rbacajaxgetassignmentbizrule
administrador_mrl	action_ui_rbacajaxsetassignmentbizrule
administrador_mrl	action_ui_rbaclistops
administrador_mrl	action_ui_rbaclisttasks
administrador_mrl	action_ui_editprofile
administrador_mrl	action_ui_UserManagementUpdate_1
rrhh_mrl_verificacion	action_ui_usermanagementadmin
rrhh_mrl_verificacion	action_ui_usermanagementupdate
rrhh_mrl_verificacion	action_ui_rbaclistroles
rrhh_mrl_verificacion	action_ui_rbacauthitemcreate
rrhh_mrl_verificacion	action_ui_rbacusersassignments
rrhh_mrl_verificacion	action_ui_usermanagementdelete
rrhh_mrl_verificacion	action_ui_usermanagementcreate
rrhh_mrl_verificacion	action_ui_sessionadmin
rrhh_mrl_verificacion	action_ui_rbacauthitemchilditems
rrhh_mrl_verificacion	action_ui_rbacajaxsetchilditem
rrhh_mrl_verificacion	action_ui_rbacauthitemupdate
rrhh_mrl_verificacion	action_ui_rbacajaxassignment
rrhh_mrl_verificacion	action_ui_fieldsadminlist
rrhh_mrl_verificacion	action_ui_rbacajaxgetassignmentbizrule
rrhh_mrl_verificacion	action_ui_rbacajaxsetassignmentbizrule
rrhh_mrl_verificacion	action_ui_rbaclistops
rrhh_mrl_verificacion	action_ui_rbaclisttasks
rrhh_mrl_verificacion	action_ui_editprofile
rrhh_mrl_verificacion	action_ui_UserManagementUpdate_1
administrador_tecnologia	action_ui_rbacusersassignments
administrador_tecnologia	action_ui_rbacajaxassignment
administrador_actualizacion	action_ui_rbacajaxassignment
rrhh_mrl_verificacion	action_graficas_graficarecepcion
rrhh_mrl_verificacion	action_graficas_graficaodis
rrhh_mrl_verificacion	action_graficas_graficanacionalidad
\.


--
-- Data for Name: cruge_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_field (idfield, fieldname, longname, "position", required, fieldtype, fieldsize, maxlength, showinreports, useregexp, useregexpmsg, predetvalue) FROM stdin;
1	dependencia	Oficina	2	1	3	100	100	1			11,DESPACHO DE LA MINISTRA\r\n14,OFICINA ESTRATÉGICA DE SEGUIMIENTO Y EVALUACIÓN DE POLÍTICAS PÚBLICAS\r\n16,DIRECCION GENERAL DEL DESPACHO\r\n17,DESPACHO DE LA VICEMINISTRA  DEL DESARROLLO PRODUCTIVO DE LA MUJER\r\n18,DESPACHO DE LA VICEMINISTRA PARA PROTECCIÓN DE LOS DERECHOS DE LA MUJER\r\n20,DESPACHO DE LA VICEMINISTRA DE IGUALDAD DE GÉNERO Y NO DISCRIMINACIÓN\r\n34,AUDITORIA INTERNA\r\n35,OFICINA DE GESTIÓN COMUNICACIONAL\r\n36,OFICINA DE INTEGRACIÓN Y ASUNTOS INTERNACIONALES\r\n37,OFICINA DE GESTION ADMINISTRATIVA\r\n38,OFICINA DE GESTIÓN HUMANA\r\n39,CONSULTORIA JURIDICA\r\n40,OFICINAS DE TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN\r\n41,OFICINA DE ATENCION A LA CIUDADANIA\r\n42,OFICINA DE PLANIFICACION Y PRESUPUESTO\r\n153,DELTA AMACURO\r\n154,ARAGUA\r\n155,AMAZONAS\r\n156,ANZOATEGUI\r\n157,APURE\r\n158,BARINAS\r\n159,BOLIVAR\r\n160,CARABOBO\r\n161,COJEDES\r\n162,DISTRITO CAPITAL\r\n163,FALCON\r\n165,LARA\r\n166,MERIDA\r\n167,MIRANDA\r\n168,MONAGAS\r\n169,NUEVA ESPARTA\r\n170,PORTUGUESA\r\n171,SUCRE\r\n172,TACHIRA\r\n173,TRUJILLO\r\n174,VARGAS\r\n175,YARACUY\r\n176,ZULIA\r\n177,HOGARES DEL PATRIA
0	cargo	Cargo	1	1	3	20	45	1			1, MINISTRA\n2, VICEMINISTRA\n3, DIRECTOR(A) DE LÍNEA\n4, DIRECTOR(A) ESTADAL\n5, DIRECTOR(A)\n6, COORDINADOR(A)\n7, ANALISTA
\.


--
-- Name: cruge_field_idfield_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cruge_field_idfield_seq', 3, true);


--
-- Data for Name: cruge_fieldvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_fieldvalue (idfieldvalue, iduser, idfield, value) FROM stdin;
3	437	0	6
4	437	1	40
5	355	0	5
6	355	1	40
7	11	0	6
8	11	1	40
1	462	0	6
2	462	1	40
\.


--
-- Name: cruge_fieldvalue_idfieldvalue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cruge_fieldvalue_idfieldvalue_seq', 8, true);


--
-- Data for Name: cruge_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_session (idsession, iduser, created, expire, status, ipaddress, usagecount, lastusage, logoutdate, ipaddressout) FROM stdin;
1	1	1426103047	1426104847	0	127.0.0.1	1	1426103047	1426103051	127.0.0.1
2	1	1426103191	1426104991	0	127.0.0.1	1	1426103191	1426103355	127.0.0.1
3	1	1426105953	1426107753	0	127.0.0.1	1	1426105953	1426106684	127.0.0.1
4	1	1426106769	1426108569	0	127.0.0.1	1	1426106769	1426107115	127.0.0.1
5	1	1426107120	1426108920	0	127.0.0.1	1	1426107120	1426107263	127.0.0.1
6	1	1426107276	1426109076	0	127.0.0.1	1	1426107276	1426107393	127.0.0.1
7	1	1426191684	1426193484	0	127.0.0.1	1	1426191684	1426191690	127.0.0.1
8	1	1426192545	1426194345	0	127.0.0.1	1	1426192545	1426192642	127.0.0.1
9	1	1426193573	1426195373	0	127.0.0.1	1	1426193573	1426193643	127.0.0.1
10	1	1426193995	1426195795	0	127.0.0.1	1	1426193995	1426194054	127.0.0.1
11	4	1426194065	1426195865	0	127.0.0.1	1	1426194065	1426194565	127.0.0.1
12	1	1426196815	1426198615	0	127.0.0.1	1	1426196815	1426196834	127.0.0.1
13	5	1426196859	1426198659	0	127.0.0.1	1	1426196859	1426196952	127.0.0.1
14	1	1426196963	1426198763	0	127.0.0.1	1	1426196963	1426196974	127.0.0.1
15	1	1426197075	1426198875	0	127.0.0.1	1	1426197075	1426197123	127.0.0.1
16	1	1426197176	1426198976	0	127.0.0.1	1	1426197176	1426197329	127.0.0.1
17	1	1426197370	1426199170	0	127.0.0.1	1	1426197370	1426197394	127.0.0.1
18	1	1426197557	1426199357	0	127.0.0.1	1	1426197557	1426197566	127.0.0.1
19	9	1426197582	1426199382	0	127.0.0.1	1	1426197582	1426197602	127.0.0.1
20	1	1426197608	1426199408	0	127.0.0.1	1	1426197608	1426197610	127.0.0.1
21	9	1426197621	1426199421	0	127.0.0.1	1	1426197621	1426197638	127.0.0.1
22	1	1426197646	1426199446	0	127.0.0.1	1	1426197646	1426197705	127.0.0.1
23	9	1426264655	1426266455	0	127.0.0.1	1	1426264655	1426264659	127.0.0.1
24	9	1426272509	1426274309	0	127.0.0.1	1	1426272509	1426272564	127.0.0.1
25	1	1426272570	1426274370	0	127.0.0.1	1	1426272570	1426272950	127.0.0.1
26	9	1426272958	1426274758	0	127.0.0.1	1	1426272958	1426272984	127.0.0.1
27	9	1426273015	1426274815	0	127.0.0.1	1	1426273015	1426273103	127.0.0.1
28	9	1426273114	1426274914	0	127.0.0.1	1	1426273114	1426273116	127.0.0.1
29	1	1426273121	1426274921	0	127.0.0.1	1	1426273121	1426273195	127.0.0.1
30	9	1426273201	1426275001	0	127.0.0.1	1	1426273201	1426273203	127.0.0.1
31	10	1426273723	1426275523	1	::1	1	1426273723	\N	\N
32	11	1426278589	1426280389	1	::1	1	1426278589	\N	\N
34	1	1426280756	1426282556	1	::1	1	1426280756	\N	\N
35	11	1426283536	1426285336	1	::1	1	1426283536	\N	\N
62	12	1426539885	1426541685	0	::1	1	1426539885	1426540034	::1
36	9	1426286367	1426288167	0	127.0.0.1	3	1426286874	1426286877	127.0.0.1
37	11	1426288862	1426290662	0	::1	1	1426288862	1426289587	::1
52	1	1426533617	1426535417	0	::1	2	1426534026	\N	\N
65	9	1426540856	1426542656	1	127.0.0.1	1	1426540856	\N	\N
33	1	1426278736	1426280536	0	::1	1	1426278736	\N	\N
50	1	1426532550	1426534350	0	::1	3	1426533517	1426533801	127.0.0.1
44	1	1426520413	1426522213	0	127.0.0.1	2	1426521398	\N	\N
45	1	1426522534	1426524334	1	::1	2	1426523144	\N	\N
51	9	1426533810	1426535610	0	127.0.0.1	1	1426533810	1426534276	127.0.0.1
54	9	1426534283	1426536083	0	127.0.0.1	1	1426534283	1426534921	127.0.0.1
67	1	1426544096	1426545896	1	::1	1	1426544096	\N	\N
70	11	1426597980	1426599780	1	::1	1	1426597980	\N	\N
41	1	1426514950	1426516750	0	172.16.2.233	1	1426514950	\N	\N
42	1	1426517297	1426519097	1	172.16.2.233	1	1426517297	\N	\N
66	12	1426542063	1426543863	0	::1	1	1426542063	\N	\N
55	9	1426534933	1426536733	0	127.0.0.1	1	1426534933	\N	\N
46	11	1426522402	1426524202	0	::1	1	1426522402	\N	\N
47	11	1426524219	1426526019	1	::1	1	1426524219	\N	\N
49	11	1426531865	1426533665	0	::1	1	1426531865	\N	\N
48	1	1426530368	1426532168	0	::1	2	1426531943	\N	\N
38	11	1426289605	1426291405	0	::1	1	1426289605	\N	\N
39	11	1426512268	1426514068	1	::1	1	1426512268	\N	\N
40	12	1426514089	1426515889	1	::1	1	1426514089	\N	\N
68	12	1426544215	1426546015	1	::1	1	1426544215	\N	\N
43	11	1426519461	1426521261	0	::1	1	1426519461	\N	\N
53	11	1426533717	1426535517	0	::1	1	1426533717	\N	\N
58	11	1426537690	1426539490	1	::1	1	1426537690	\N	\N
56	1	1426536426	1426538226	0	::1	3	1426536689	\N	\N
60	9	1426538931	1426540731	0	127.0.0.1	1	1426538931	\N	\N
57	9	1426536793	1426538593	0	127.0.0.1	1	1426536793	\N	\N
61	12	1426539499	1426541299	0	::1	1	1426539499	1426539861	::1
59	1	1426538428	1426540228	0	::1	3	1426539449	\N	\N
64	1	1426540589	1426542389	1	::1	1	1426540589	\N	\N
71	1	1426600413	1426602213	0	::1	1	1426600413	\N	\N
63	12	1426540059	1426541859	0	::1	1	1426540059	\N	\N
72	12	1426600496	1426602296	0	::1	1	1426600496	\N	\N
69	11	1426595613	1426597413	0	::1	1	1426595613	\N	\N
76	1	1426604688	1426606488	1	::1	1	1426604688	\N	\N
73	1	1426602304	1426604104	0	::1	1	1426602304	\N	\N
74	12	1426602381	1426604181	0	::1	1	1426602381	\N	\N
78	9	1426606407	1426608207	1	127.0.0.1	1	1426606407	\N	\N
75	9	1426603096	1426604896	0	127.0.0.1	1	1426603096	\N	\N
77	12	1426604935	1426606735	0	::1	1	1426604935	\N	\N
79	11	1426606520	1426608320	0	::1	1	1426606520	\N	\N
83	12	1426609188	1426610988	1	::1	1	1426609188	\N	\N
80	12	1426607329	1426609129	0	::1	1	1426607329	\N	\N
82	11	1426608391	1426610191	0	::1	1	1426608391	\N	\N
92	11	1426615192	1426616992	0	::1	1	1426615192	\N	\N
90	1	1426613962	1426615762	0	127.0.0.1	2	1426598411	1426598499	127.0.0.1
97	1	1426617809	1426619609	0	::1	1	1426617809	1426617821	::1
109	1	1426623469	1426625269	0	127.0.0.1	3	1426608730	1426608752	127.0.0.1
115	1	1426626162	1426627962	1	::1	1	1426626162	\N	\N
81	1	1426607523	1426609323	0	::1	1	1426607523	\N	\N
84	1	1426609998	1426611798	1	::1	1	1426609998	\N	\N
87	13	1426610517	1426612317	1	::1	1	1426610517	\N	\N
114	11	1426626072	1426627872	0	::1	1	1426626072	1426626277	::1
111	9	1426626110	1426627910	0	127.0.0.1	1	1426626110	1426626814	127.0.0.1
117	9	1426626821	1426628621	1	127.0.0.1	1	1426626821	\N	\N
138	4	1426711220	1426713020	0	127.0.0.1	1	1426711220	\N	\N
128	13	1426697140	1426698940	1	::1	1	1426697140	\N	\N
104	11	1426620423	1426622223	0	::1	1	1426620423	\N	\N
93	9	1426615950	1426617750	0	127.0.0.1	1	1426615950	\N	\N
85	9	1426610495	1426612295	0	127.0.0.1	1	1426610495	\N	\N
88	9	1426612392	1426614192	1	127.0.0.1	1	1426612392	\N	\N
96	11	1426617136	1426618936	0	::1	2	1426617919	1426618379	::1
131	11	1426701611	1426703411	0	::1	1	1426701611	\N	\N
100	1	1426602257	1426604057	0	127.0.0.1	1	1426602257	\N	\N
86	11	1426610392	1426612192	0	::1	1	1426610392	\N	\N
102	13	1426620129	1426621929	0	::1	1	1426620129	1426621305	::1
95	1	1426600413	1426602213	0	127.0.0.1	1	1426600413	\N	\N
135	11	1426707568	1426709368	0	::1	1	1426707568	\N	\N
108	11	1426622300	1426624100	0	::1	1	1426622300	\N	\N
116	11	1426626281	1426628081	0	::1	1	1426626281	\N	\N
105	1	1426605297	1426607097	1	127.0.0.1	1	1426605297	\N	\N
106	1	1426621583	1426623383	0	::1	2	1426622281	\N	\N
118	11	1426628185	1426629985	1	::1	1	1426628185	\N	\N
89	11	1426613190	1426614990	0	::1	1	1426613190	\N	\N
119	9	1426629192	1426630992	1	::1	1	1426629192	\N	\N
120	11	1426682552	1426684352	1	::1	1	1426682552	\N	\N
110	11	1426624112	1426625912	1	127.0.0.1	2	1426608801	\N	\N
121	9	1426690524	1426692324	0	127.0.0.1	1	1426690524	1426692082	127.0.0.1
94	12	1426615776	1426617576	1	::1	1	1426615776	\N	\N
122	11	1426691636	1426693436	1	::1	2	1426692256	\N	\N
124	12	1426692383	1426694183	1	::1	1	1426692383	\N	\N
137	13	1426709951	1426711751	1	::1	1	1426709951	\N	\N
98	9	1426617838	1426619638	0	127.0.0.1	2	1426618291	\N	\N
153	11	1426782760	1426784560	0	172.16.20.19	2	1426782783	\N	\N
91	1	1426598509	1426600309	0	127.0.0.1	1	1426598509	\N	\N
132	11	1426703672	1426705472	0	::1	1	1426703672	\N	\N
103	1	1426620409	1426622209	0	::1	4	1426621312	1426605260	127.0.0.1
112	1	1426625727	1426627527	0	::1	1	1426625727	1426625749	::1
113	13	1426625778	1426627578	1	::1	1	1426625778	\N	\N
99	11	1426618392	1426620192	0	::1	1	1426618392	\N	\N
134	9	1426706923	1426708723	0	::1	1	1426706923	1426706972	::1
123	9	1426692093	1426693893	0	127.0.0.1	1	1426692093	\N	\N
101	9	1426620467	1426622267	0	127.0.0.1	3	1426605279	1426605289	127.0.0.1
107	9	1426622014	1426623814	1	::1	1	1426622014	\N	\N
126	11	1426695563	1426697363	1	::1	1	1426695563	\N	\N
127	12	1426695842	1426697642	1	::1	1	1426695842	\N	\N
146	11	1426778355	1426780155	0	::1	1	1426778355	\N	\N
148	12	1426780361	1426782161	0	::1	1	1426780361	1426781738	::1
140	4	1426713055	1426714855	0	127.0.0.1	1	1426713055	\N	\N
125	9	1426693917	1426695717	0	127.0.0.1	1	1426693917	\N	\N
129	9	1426697790	1426699590	0	127.0.0.1	1	1426697790	1426697808	127.0.0.1
130	9	1426697854	1426699654	0	127.0.0.1	1	1426697854	1426697860	127.0.0.1
141	4	1426715061	1426716861	0	127.0.0.1	1	1426715061	1426715978	127.0.0.1
142	11	1426767428	1426769228	1	::1	1	1426767428	\N	\N
136	11	1426709463	1426711263	0	::1	1	1426709463	\N	\N
139	11	1426711433	1426713233	1	::1	1	1426711433	\N	\N
133	11	1426705730	1426707530	0	::1	2	1426707015	\N	\N
150	12	1426781753	1426783553	0	::1	1	1426781753	1426782014	::1
147	12	1426778350	1426780150	0	::1	1	1426778350	\N	\N
149	11	1426780922	1426782722	0	::1	1	1426780922	\N	\N
152	10	1426782231	1426784031	0	172.16.20.19	1	1426782231	1426782771	172.16.20.19
143	12	1426772718	1426774518	0	::1	1	1426772718	\N	\N
145	11	1426776470	1426778270	0	::1	1	1426776470	\N	\N
144	12	1426776399	1426778199	0	::1	1	1426776399	\N	\N
151	12	1426782055	1426783855	0	::1	1	1426782055	1426783563	::1
154	13	1426783187	1426784987	0	::1	1	1426783187	\N	\N
155	12	1426783590	1426785390	0	::1	1	1426783590	\N	\N
158	13	1426785523	1426787323	0	::1	1	1426785523	\N	\N
156	11	1426784893	1426786693	0	::1	1	1426784893	\N	\N
160	13	1426787633	1426789433	1	::1	1	1426787633	\N	\N
157	12	1426785511	1426787311	0	::1	1	1426785511	\N	\N
161	12	1426788449	1426790249	1	::1	2	1426788578	\N	\N
159	11	1426786770	1426788570	0	::1	2	1426787344	\N	\N
162	11	1426789164	1426790964	0	::1	1	1426789164	1426789741	::1
163	11	1426789744	1426791544	1	::1	1	1426789744	\N	\N
164	12	1426857859	1426859659	0	::1	1	1426857859	\N	\N
165	12	1426859819	1426861619	0	::1	1	1426859819	\N	\N
166	12	1426862253	1426864053	1	::1	1	1426862253	\N	\N
168	13	1426872102	1426873902	1	::1	1	1426872102	\N	\N
169	12	1426872599	1426874399	1	::1	1	1426872599	\N	\N
170	9	1426873514	1426875314	1	127.0.0.1	1	1426873514	\N	\N
195	9	1427141301	1427143101	0	127.0.0.1	1	1427141301	\N	\N
177	9	1426881130	1426882930	0	127.0.0.1	2	1426881838	\N	\N
214	9	1427230722	1427232522	0	127.0.0.1	1	1427230722	\N	\N
167	1	1426855857	1426857657	0	127.0.0.1	1	1426855857	\N	\N
206	11	1427221123	1427222923	0	::1	2	1427221448	\N	\N
208	11	1427223129	1427224929	1	::1	1	1427223129	\N	\N
215	9	1427233084	1427234884	1	::1	2	1427233057	\N	\N
178	9	1426883040	1426884840	0	127.0.0.1	1	1426883040	\N	\N
179	9	1426885211	1426887011	1	127.0.0.1	1	1426885211	\N	\N
180	1	1426868745	1426870545	1	127.0.0.1	1	1426868745	\N	\N
181	13	1427119284	1427121084	1	::1	1	1427119284	\N	\N
182	9	1427119725	1427121525	1	127.0.0.1	1	1427119725	\N	\N
183	12	1427119581	1427121381	0	::1	1	1427119581	1427120157	::1
184	12	1427120193	1427121993	1	::1	1	1427120193	\N	\N
185	9	1427125347	1427127147	1	::1	2	1427126859	\N	\N
186	9	1427128817	1427130617	1	127.0.0.1	1	1427128817	\N	\N
216	12	1427292764	1427294564	1	::1	1	1427292764	\N	\N
196	9	1427144146	1427145946	0	127.0.0.1	1	1427144146	\N	\N
197	9	1427146263	1427148063	1	127.0.0.1	1	1427146263	\N	\N
171	1	1426858093	1426859893	0	127.0.0.1	1	1426858093	\N	\N
198	11	1427199382	1427201182	1	::1	1	1427199382	\N	\N
210	1	1427208542	1427210342	0	127.0.0.1	1	1427208542	\N	\N
212	1	1427211350	1427213150	1	127.0.0.1	1	1427211350	\N	\N
217	9	1427293035	1427294835	1	127.0.0.1	1	1427293035	\N	\N
187	12	1427129081	1427130881	0	::1	1	1427129081	\N	\N
188	12	1427130915	1427132715	1	::1	1	1427130915	\N	\N
172	1	1426859912	1426861712	0	127.0.0.1	1	1426859912	\N	\N
218	9	1427297143	1427298943	1	127.0.0.1	1	1427297143	\N	\N
219	9	1427299989	1427301789	1	127.0.0.1	1	1427299989	\N	\N
220	12	1427379493	1427381293	1	::1	2	1427379946	\N	\N
199	12	1427207828	1427209628	0	::1	1	1427207828	\N	\N
200	12	1427209771	1427211571	1	::1	1	1427209771	\N	\N
173	9	1426877265	1426879065	0	127.0.0.1	1	1426877265	\N	\N
201	13	1427211894	1427213694	1	172.16.20.21	1	1427211894	\N	\N
189	9	1427132968	1427134768	0	127.0.0.1	1	1427132968	\N	\N
246	9	1427747695	1427749495	0	127.0.0.1	1	1427747695	1427748896	127.0.0.1
243	12	1427744527	1427746327	0	::1	1	1427744527	\N	\N
207	1	1427206317	1427208117	0	127.0.0.1	1	1427206317	\N	\N
174	1	1426861835	1426863635	0	127.0.0.1	1	1426861835	\N	\N
176	1	1426863789	1426865589	1	127.0.0.1	1	1426863789	\N	\N
228	1	1427382014	1427383814	0	127.0.0.1	1	1427382014	\N	\N
225	1	1427378117	1427379917	0	127.0.0.1	1	1427378117	\N	\N
202	9	1427213419	1427215219	0	127.0.0.1	1	1427213419	\N	\N
190	9	1427135268	1427137068	0	127.0.0.1	2	1427135652	1427136000	::1
203	9	1427215321	1427217121	1	127.0.0.1	1	1427215321	\N	\N
191	9	1427136005	1427137805	0	127.0.0.1	2	1427136327	1427137010	127.0.0.1
175	9	1426879255	1426881055	0	127.0.0.1	1	1426879255	\N	\N
192	9	1427137016	1427138816	1	127.0.0.1	1	1427137016	\N	\N
193	13	1427138656	1427140456	0	172.16.1.241	1	1427138656	1427139319	172.16.1.241
194	13	1427139327	1427141127	0	172.16.1.241	1	1427139327	1427140635	172.16.1.241
205	9	1427220793	1427222593	1	127.0.0.1	1	1427220793	\N	\N
211	9	1427226317	1427228117	0	127.0.0.1	1	1427226317	\N	\N
227	12	1427398233	1427400033	1	::1	1	1427398233	\N	\N
209	9	1427224421	1427226221	0	127.0.0.1	1	1427224421	\N	\N
230	1	1427386222	1427388022	0	127.0.0.1	2	1427386223	\N	\N
221	12	1427383604	1427385404	0	::1	2	1427383889	\N	\N
222	12	1427386120	1427387920	1	::1	1	1427386120	\N	\N
223	12	1427390951	1427392751	1	::1	1	1427390951	\N	\N
204	1	1427203949	1427205749	0	127.0.0.1	1	1427203949	\N	\N
232	1	1427388075	1427389875	1	127.0.0.1	1	1427388075	\N	\N
213	9	1427228686	1427230486	0	127.0.0.1	1	1427228686	\N	\N
233	1	1427389912	1427391712	1	127.0.0.1	1	1427389912	\N	\N
240	12	1427737800	1427739600	0	::1	1	1427737800	\N	\N
238	12	1427728193	1427729993	0	::1	1	1427728193	\N	\N
229	1	1427384301	1427386101	0	127.0.0.1	1	1427384301	\N	\N
226	1	1427380187	1427381987	0	127.0.0.1	1	1427380187	\N	\N
224	1	1427375875	1427377675	0	127.0.0.1	1	1427375875	\N	\N
239	12	1427730102	1427731902	1	::1	1	1427730102	\N	\N
231	12	1427404053	1427405853	1	::1	1	1427404053	\N	\N
237	12	1427726300	1427728100	0	::1	1	1427726300	\N	\N
241	12	1427739927	1427741727	0	::1	1	1427739927	\N	\N
234	12	1427463697	1427465497	0	::1	1	1427463697	\N	\N
235	12	1427465744	1427467544	1	::1	1	1427465744	\N	\N
236	12	1427723296	1427725096	0	::1	2	1427723459	\N	\N
242	12	1427741881	1427743681	1	::1	1	1427741881	\N	\N
244	9	1427744759	1427746559	1	127.0.0.1	1	1427744759	\N	\N
245	12	1427746464	1427748264	0	::1	1	1427746464	\N	\N
247	12	1427748306	1427750106	0	::1	1	1427748306	\N	\N
249	12	1427750262	1427752062	0	::1	2	1427750554	\N	\N
248	9	1427748907	1427750707	0	127.0.0.1	1	1427748907	\N	\N
250	9	1427750794	1427752594	0	127.0.0.1	1	1427750794	\N	\N
251	9	1427752907	1427754707	0	127.0.0.1	1	1427752907	1427753972	127.0.0.1
252	9	1427809487	1427811287	1	127.0.0.1	1	1427809487	\N	\N
253	12	1427809260	1427811060	1	::1	1	1427809260	\N	\N
254	12	1427813015	1427814815	1	::1	1	1427813015	\N	\N
255	9	1427818162	1427819962	1	127.0.0.1	1	1427818162	\N	\N
256	12	1427819714	1427821514	1	::1	3	1427820676	\N	\N
258	9	1427826764	1427828564	1	127.0.0.1	1	1427826764	\N	\N
331	9	1428682677	1428684477	1	::1	1	1428682677	\N	\N
317	11	1428589596	1428591396	0	::1	2	1428590518	\N	\N
320	1	1428592231	1428594031	1	::1	1	1428592231	\N	\N
301	12	1428518015	1428519815	0	::1	3	1428518346	\N	\N
306	9	1428522055	1428523855	1	::1	1	1428522055	\N	\N
294	9	1428508632	1428510432	0	::1	1	1428508632	\N	\N
269	15	1428417928	1428419728	0	172.16.20.23	1	1428417928	\N	\N
272	16	1428420575	1428422375	1	172.16.2.102	1	1428420575	\N	\N
273	17	1428420975	1428422775	1	172.16.20.16	1	1428420975	\N	\N
257	12	1427826202	1427828002	0	::1	1	1427826202	\N	\N
259	12	1427828674	1427830474	0	::1	1	1427828674	1427829156	::1
261	1	1427837411	1427839211	0	::1	1	1427837411	1427837633	::1
260	12	1427837393	1427839193	1	::1	2	1427837644	\N	\N
263	1	1427897478	1427899278	1	::1	1	1427897478	\N	\N
274	18	1428421189	1428422989	1	172.16.20.11	1	1428421189	\N	\N
275	19	1428421770	1428423570	1	172.16.27.10	1	1428421770	\N	\N
276	11	1428424102	1428425902	1	172.16.20.25	1	1428424102	\N	\N
295	9	1428510519	1428512319	1	::1	1	1428510519	\N	\N
271	1	1428419908	1428421708	0	127.0.0.1	2	1428409137	1428411590	127.0.0.1
296	12	1428511501	1428513301	0	::1	1	1428511501	1428511815	::1
297	1	1428499762	1428501562	1	127.0.0.1	1	1428499762	\N	\N
300	13	1428501491	1428503291	1	172.16.20.21	1	1428501491	\N	\N
299	12	1428517721	1428519521	0	::1	1	1428517721	1428518003	::1
326	1	1428673154	1428674954	0	::1	1	1428673154	\N	\N
264	11	1427897616	1427899416	1	::1	1	1427897616	\N	\N
277	1	1428411769	1428413569	0	127.0.0.1	2	1428411961	\N	\N
279	1	1428413914	1428415714	1	127.0.0.1	1	1428413914	\N	\N
278	12	1428430280	1428432080	0	::1	2	1428431021	1428431048	::1
280	12	1428431062	1428432862	0	::1	1	1428431062	1428431065	::1
323	9	1428594944	1428596744	0	::1	2	1428595006	\N	\N
281	1	1428431090	1428432890	0	::1	2	1428431225	1428431338	::1
282	12	1428431348	1428433148	0	::1	1	1428431348	1428432767	::1
309	12	1428525994	1428527794	0	::1	1	1428525994	\N	\N
311	12	1428528371	1428530171	1	::1	1	1428528371	\N	\N
312	9	1428530461	1428532261	1	172.16.20.13	2	1428530407	\N	\N
313	14	1428530843	1428532643	0	172.16.0.2	1	1428530843	1428530955	172.16.0.2
314	12	1428585986	1428587786	1	::1	1	1428585986	\N	\N
298	9	1428516654	1428518454	0	::1	1	1428516654	\N	\N
283	1	1428432784	1428434584	0	::1	1	1428432784	\N	\N
284	1	1428434649	1428436449	0	::1	1	1428434649	1428435358	::1
262	12	1427895280	1427897080	0	::1	1	1427895280	\N	\N
265	12	1427898211	1427900011	1	::1	1	1427898211	\N	\N
266	14	1428415266	1428417066	0	172.16.20.24	1	1428415266	1428416379	172.16.20.24
267	14	1428416440	1428418240	0	172.16.20.24	1	1428416440	1428416479	172.16.20.24
268	14	1428416485	1428418285	1	172.16.20.24	1	1428416485	\N	\N
270	12	1428419750	1428421550	0	172.16.0.2	1	1428419750	1428419883	172.16.0.2
302	9	1428518714	1428520514	1	::1	1	1428518714	\N	\N
285	12	1428435509	1428437309	0	::1	1	1428435509	\N	\N
287	12	1428437514	1428439314	0	::1	1	1428437514	1428437568	::1
315	9	1428587961	1428589761	1	::1	1	1428587961	\N	\N
288	12	1428438898	1428440698	0	172.16.0.2	1	1428438898	1428438953	172.16.0.2
286	1	1428437307	1428439107	1	127.0.0.1	4	1428422524	\N	\N
307	12	1428524083	1428525883	0	::1	1	1428524083	\N	\N
289	1	1428439598	1428441398	1	127.0.0.1	3	1428428790	\N	\N
290	12	1428445057	1428446857	1	172.16.20.21	2	1428428841	\N	\N
291	1	1428501141	1428502941	0	::1	2	1428501918	\N	\N
324	9	1428596751	1428598551	1	::1	1	1428596751	\N	\N
316	1	1428589478	1428591278	1	::1	3	1428589542	\N	\N
303	1	1428502629	1428504429	0	127.0.0.1	1	1428502629	\N	\N
304	1	1428504742	1428506542	1	127.0.0.1	1	1428504742	\N	\N
318	9	1428590583	1428592383	1	::1	1	1428590583	\N	\N
321	9	1428593124	1428594924	0	::1	1	1428593124	\N	\N
292	12	1428504918	1428506718	0	::1	2	1428506075	\N	\N
293	12	1428508037	1428509837	1	::1	1	1428508037	\N	\N
305	12	1428521860	1428523660	0	::1	1	1428521860	\N	\N
325	9	1428601942	1428603742	1	::1	2	1428601943	\N	\N
308	1	1428507755	1428509555	0	127.0.0.1	1	1428507755	\N	\N
310	1	1428510598	1428512398	1	127.0.0.1	1	1428510598	\N	\N
322	11	1428594414	1428596214	1	::1	2	1428595494	\N	\N
327	11	1428675695	1428677495	1	::1	1	1428675695	\N	\N
319	11	1428592216	1428594016	0	::1	3	1428593208	\N	\N
328	11	1428677772	1428679572	0	::1	1	1428677772	\N	\N
334	1	1428672959	1428674759	1	127.0.0.1	1	1428672959	\N	\N
329	11	1428680166	1428681966	0	::1	1	1428680166	\N	\N
333	12	1428689185	1428690985	0	::1	1	1428689185	\N	\N
330	11	1428682540	1428684340	1	::1	1	1428682540	\N	\N
335	9	1428690827	1428692627	0	::1	1	1428690827	\N	\N
337	9	1428692714	1428694514	1	::1	1	1428692714	\N	\N
332	11	1428688874	1428690674	0	::1	1	1428688874	\N	\N
336	12	1428691005	1428692805	0	::1	1	1428691005	\N	\N
338	1	1428692674	1428694474	1	127.0.0.1	2	1428677845	\N	\N
339	11	1428692730	1428694530	0	::1	1	1428692730	\N	\N
341	11	1428694555	1428696355	1	::1	1	1428694555	\N	\N
340	12	1428693012	1428694812	0	::1	1	1428693012	\N	\N
342	12	1428695568	1428697368	0	::1	1	1428695568	\N	\N
343	12	1428697489	1428699289	0	::1	1	1428697489	\N	\N
344	9	1428699426	1428701226	0	::1	1	1428699426	\N	\N
345	12	1428699590	1428701390	0	::1	1	1428699590	1428699913	::1
346	1	1428699925	1428701725	1	::1	1	1428699925	\N	\N
353	11	1428934928	1428936728	0	::1	2	1428936275	\N	\N
378	9	1429036047	1429037847	0	172.16.0.2	1	1429036047	1429036060	172.16.0.2
383	12	1429039587	1429041387	0	::1	1	1429039587	1429039989	::1
347	12	1428699987	1428701787	0	::1	1	1428699987	\N	\N
349	12	1428701825	1428703625	1	::1	1	1428701825	\N	\N
385	1	1429040005	1429041805	0	::1	1	1429040005	1429040195	::1
386	1	1429040220	1429042020	0	::1	1	1429040220	1429040371	::1
387	4	1429040430	1429042230	0	::1	1	1429040430	1429040513	::1
348	9	1428701581	1428703381	0	::1	1	1428701581	\N	\N
357	9	1428937625	1428939425	0	::1	1	1428937625	\N	\N
368	12	1429021026	1429022826	0	::1	1	1429021026	\N	\N
370	12	1429023700	1429025500	1	::1	1	1429023700	\N	\N
414	1	1429122769	1429124569	0	::1	1	1429122769	1429122788	::1
350	9	1428703739	1428705539	0	::1	1	1428703739	\N	\N
351	9	1428706413	1428708213	1	::1	1	1428706413	\N	\N
415	12	1429122809	1429124609	0	::1	1	1429122809	1429123755	::1
359	11	1428938283	1428940083	0	::1	1	1428938283	\N	\N
361	11	1428940345	1428942145	1	::1	1	1428940345	\N	\N
362	12	1428940371	1428942171	1	::1	1	1428940371	\N	\N
408	11	1429120810	1429122610	1	::1	1	1429120810	\N	\N
397	11	1429110045	1429111845	0	::1	1	1429110045	\N	\N
404	11	1429115024	1429116824	1	::1	1	1429115024	\N	\N
352	9	1428932821	1428934621	0	::1	1	1428932821	\N	\N
369	11	1429023165	1429024965	0	::1	1	1429023165	\N	\N
372	11	1429025369	1429027169	1	::1	1	1429025369	\N	\N
402	12	1429114173	1429115973	0	::1	1	1429114173	\N	\N
376	12	1429034705	1429036505	0	::1	1	1429034705	\N	\N
405	12	1429116119	1429117919	0	::1	1	1429116119	1429116611	::1
393	11	1429106189	1429107989	0	::1	1	1429106189	\N	\N
360	9	1428939448	1428941248	0	::1	1	1428939448	\N	\N
363	9	1428941326	1428943126	1	::1	1	1428941326	\N	\N
406	4	1429116637	1429118437	0	::1	1	1429116637	1429116663	::1
416	1	1429123768	1429125568	0	::1	1	1429123768	1429123834	::1
377	11	1429035854	1429037654	0	::1	1	1429035854	\N	\N
379	12	1429037236	1429039036	0	::1	1	1429037236	1429038711	::1
364	9	1428947053	1428948853	0	::1	1	1428947053	\N	\N
355	12	1428935125	1428936925	0	::1	1	1428935125	\N	\N
365	9	1428949998	1428951798	1	::1	1	1428949998	\N	\N
366	9	1429019590	1429021390	1	::1	1	1429019590	\N	\N
381	12	1429038740	1429040540	0	::1	1	1429038740	1429038773	::1
382	1	1429038806	1429040606	0	::1	1	1429038806	1429039403	::1
354	9	1428935188	1428936988	0	::1	1	1428935188	\N	\N
356	12	1428937204	1428939004	0	::1	1	1428937204	1428937655	::1
358	12	1428937668	1428939468	1	::1	1	1428937668	\N	\N
394	12	1429106688	1429108488	0	::1	1	1429106688	\N	\N
373	11	1429028883	1429030683	1	::1	1	1429028883	\N	\N
371	9	1429024382	1429026182	0	::1	1	1429024382	\N	\N
367	11	1429020453	1429022253	0	::1	1	1429020453	\N	\N
374	9	1429029440	1429031240	1	::1	2	1429029380	\N	\N
396	12	1429108654	1429110454	1	::1	1	1429108654	\N	\N
417	12	1429123844	1429125644	0	::1	1	1429123844	1429123990	::1
389	12	1429042390	1429044190	0	::1	1	1429042390	\N	\N
391	12	1429044431	1429046231	1	::1	1	1429044431	\N	\N
388	12	1429040533	1429042333	0	::1	2	1429040976	\N	\N
375	11	1429033924	1429035724	0	::1	1	1429033924	\N	\N
407	12	1429116684	1429118484	0	::1	1	1429116684	\N	\N
380	11	1429037760	1429039560	0	::1	1	1429037760	\N	\N
409	12	1429121065	1429122865	0	::1	1	1429121065	1429121089	::1
410	1	1429121100	1429122900	0	::1	1	1429121100	1429121240	::1
395	11	1429108226	1429110026	0	::1	1	1429108226	\N	\N
384	11	1429039929	1429041729	0	::1	1	1429039929	\N	\N
390	11	1429043636	1429045436	1	::1	1	1429043636	\N	\N
398	9	1429110875	1429112675	1	::1	1	1429110875	\N	\N
399	12	1429111786	1429113586	0	::1	1	1429111786	1429111864	::1
400	1	1429111877	1429113677	0	::1	1	1429111877	1429112083	::1
392	11	1429104090	1429105890	0	::1	1	1429104090	\N	\N
401	12	1429112098	1429113898	0	::1	1	1429112098	\N	\N
403	9	1429114809	1429116609	1	::1	1	1429114809	\N	\N
411	12	1429121260	1429123060	0	::1	1	1429121260	1429121412	::1
412	1	1429121423	1429123223	0	::1	1	1429121423	1429121479	::1
413	12	1429121493	1429123293	0	::1	1	1429121493	1429122758	::1
418	1	1429123999	1429125799	0	::1	1	1429123999	1429124047	::1
419	12	1429124073	1429125873	0	::1	1	1429124073	1429124197	::1
420	1	1429124207	1429126007	0	::1	1	1429124207	1429124253	::1
421	12	1429124267	1429126067	0	::1	1	1429124267	1429124857	::1
424	12	1429128808	1429130608	0	::1	1	1429128808	1429130196	::1
423	12	1429126973	1429128773	0	::1	5	1429128532	\N	\N
422	12	1429124869	1429126669	0	::1	2	1429126383	\N	\N
425	11	1429201825	1429203625	1	::1	1	1429201825	\N	\N
426	11	1429278709	1429280509	1	::1	1	1429278709	\N	\N
427	11	1429282451	1429284251	1	::1	1	1429282451	\N	\N
428	1	1429283556	1429285356	1	::1	1	1429283556	\N	\N
430	1	1429288092	1429289892	1	172.16.20.21	2	1429288097	\N	\N
429	11	1429285202	1429287002	0	::1	4	1429286782	\N	\N
432	9	1429289863	1429291663	1	::1	1	1429289863	\N	\N
431	11	1429288178	1429289978	0	::1	2	1429288300	\N	\N
434	11	1429293848	1429295648	0	::1	3	1429294774	\N	\N
433	11	1429291900	1429293700	0	::1	3	1429293122	\N	\N
459	10	1429642044	1429643844	0	172.16.20.19	2	1429642122	1429642454	172.16.20.19
435	11	1429295998	1429297798	0	::1	1	1429295998	\N	\N
437	11	1429298658	1429300458	0	::1	1	1429298658	\N	\N
438	11	1429301308	1429303108	1	::1	1	1429301308	\N	\N
460	10	1429642635	1429644435	1	172.16.20.19	1	1429642635	\N	\N
473	1	1429732714	1429734514	1	127.0.0.1	2	1429732783	\N	\N
436	1	1429298098	1429299898	0	::1	1	1429298098	\N	\N
439	1	1429308575	1429310375	1	::1	1	1429308575	\N	\N
440	11	1429542801	1429544601	0	::1	1	1429542801	\N	\N
458	12	1429640774	1429642574	0	::1	1	1429640774	\N	\N
441	11	1429545011	1429546811	0	::1	2	1429546676	\N	\N
482	1	1429797165	1429798965	0	127.0.0.1	2	1429798282	\N	\N
442	11	1429546947	1429548747	0	::1	2	1429547726	\N	\N
443	11	1429549271	1429551071	1	::1	1	1429549271	\N	\N
444	11	1429553784	1429555584	0	::1	1	1429553784	\N	\N
445	11	1429556024	1429557824	1	::1	1	1429556024	\N	\N
446	20	1429623384	1429625184	1	172.16.1.4	1	1429623384	\N	\N
447	11	1429624543	1429626343	1	::1	1	1429624543	\N	\N
449	10	1429627373	1429629173	1	172.16.20.19	1	1429627373	\N	\N
454	1	1429637814	1429639614	1	127.0.0.1	8	1429628838	\N	\N
461	12	1429643998	1429645798	0	::1	1	1429643998	\N	\N
463	20	1429646107	1429647907	1	172.16.1.4	1	1429646107	\N	\N
475	11	1429734798	1429736598	0	::1	2	1429735601	\N	\N
477	13	1429745670	1429747470	1	172.16.20.21	1	1429745670	\N	\N
476	1	1429745594	1429747394	0	172.16.20.13	2	1429745715	1429745754	172.16.20.13
478	11	1429794464	1429796264	1	::1	1	1429794464	\N	\N
479	13	1429801086	1429802886	1	172.16.20.21	1	1429801086	\N	\N
483	1	1429799042	1429800842	1	127.0.0.1	3	1429799672	\N	\N
508	1	1430909983	1430911783	1	127.0.0.1	1	1430909983	\N	\N
485	9	1429816798	1429818598	1	::1	1	1429816798	\N	\N
502	1	1430395974	1430397774	0	127.0.0.1	1	1430395974	\N	\N
487	1	1429882724	1429884524	0	127.0.0.1	2	1429883795	\N	\N
453	12	1429636889	1429638689	0	::1	2	1429638499	\N	\N
489	1	1429884685	1429886485	1	127.0.0.1	1	1429884685	\N	\N
490	1	1429901412	1429903212	1	172.16.20.20	1	1429901412	\N	\N
480	1	1429793125	1429794925	0	127.0.0.1	4	1429794811	\N	\N
491	9	1429902952	1429904752	1	::1	1	1429902952	\N	\N
462	12	1429646038	1429647838	0	::1	1	1429646038	\N	\N
492	12	1429915060	1429916860	1	::1	2	1429916213	\N	\N
493	12	1429920187	1429921987	1	::1	1	1429920187	\N	\N
503	1	1430398177	1430399977	1	127.0.0.1	1	1430398177	\N	\N
457	12	1429624351	1429626151	1	127.0.0.1	1	1429624351	\N	\N
464	11	1429713290	1429715090	0	::1	1	1429713290	\N	\N
465	11	1429715437	1429717237	1	::1	1	1429715437	\N	\N
494	12	1430152472	1430154272	0	::1	1	1430152472	\N	\N
466	9	1429715790	1429717590	0	::1	2	1429717020	\N	\N
448	12	1429627028	1429628828	0	::1	3	1429628724	\N	\N
450	12	1429628885	1429630685	1	::1	1	1429628885	\N	\N
451	11	1429629401	1429631201	1	::1	2	1429629401	\N	\N
455	10	1429638144	1429639944	1	172.16.20.19	1	1429638144	\N	\N
467	11	1429717866	1429719666	1	::1	1	1429717866	\N	\N
469	12	1429719890	1429721690	1	127.0.0.1	1	1429719890	\N	\N
452	1	1429620227	1429622027	0	127.0.0.1	1	1429620227	\N	\N
481	1	1429795259	1429797059	0	127.0.0.1	3	1429795730	\N	\N
471	9	1429727819	1429729619	1	::1	1	1429727819	\N	\N
468	1	1429719859	1429721659	1	127.0.0.1	3	1429712696	\N	\N
470	11	1429727618	1429729418	0	::1	2	1429728219	\N	\N
472	11	1429730471	1429732271	1	::1	1	1429730471	\N	\N
456	12	1429638843	1429640643	0	172.16.20.22	5	1429640568	\N	\N
495	12	1430174810	1430176610	1	::1	2	1430175672	\N	\N
496	20	1430225682	1430227482	1	172.16.1.4	1	1430225682	\N	\N
474	12	1429732741	1429734541	0	127.0.0.1	1	1429732741	1429732778	127.0.0.1
484	1	1429816208	1429818008	0	127.0.0.1	3	1429802223	\N	\N
497	11	1430258627	1430260427	0	::1	1	1430258627	1430258745	::1
486	1	1429819058	1429820858	1	127.0.0.1	4	1429807274	\N	\N
488	9	1429899832	1429901632	1	::1	1	1429899832	\N	\N
504	12	1430771826	1430773626	1	::1	2	1430772113	\N	\N
498	11	1430258747	1430260547	0	::1	1	1430258747	\N	\N
499	11	1430261140	1430262940	1	::1	1	1430261140	\N	\N
500	11	1430401306	1430403106	1	::1	1	1430401306	\N	\N
505	1	1430903896	1430905696	0	127.0.0.1	2	1430904857	\N	\N
501	11	1430405126	1430406926	0	::1	1	1430405126	\N	\N
506	1	1430906075	1430907875	0	127.0.0.1	3	1430907668	\N	\N
510	1	1430928678	1430930478	0	127.0.0.1	1	1430928678	\N	\N
512	1	1431089372	1431091172	0	127.0.0.1	2	1431090450	\N	\N
507	1	1430908132	1430909932	0	127.0.0.1	1	1430908132	\N	\N
509	1	1430926680	1430928480	0	127.0.0.1	10	1430928355	\N	\N
511	1	1430946975	1430948775	1	127.0.0.1	8	1430934758	\N	\N
513	1	1431091324	1431093124	0	127.0.0.1	3	1431092456	\N	\N
514	1	1431093375	1431095175	0	127.0.0.1	2	1431094956	\N	\N
515	1	1431095185	1431096985	0	127.0.0.1	2	1431095585	\N	\N
516	1	1431097193	1431098993	0	127.0.0.1	2	1431097679	\N	\N
517	1	1431099030	1431100830	0	127.0.0.1	1	1431099030	\N	\N
519	1	1431102785	1431104585	1	127.0.0.1	1	1431102785	\N	\N
518	1	1431100886	1431102686	0	127.0.0.1	2	1431101610	\N	\N
520	12	1431357168	1431358968	0	172.16.20.13	1	1431357168	1431357390	172.16.20.13
521	4	1431357408	1431359208	0	172.16.20.13	1	1431357408	1431357737	172.16.20.13
522	4	1431357774	1431359574	1	172.16.20.13	1	1431357774	\N	\N
533	1	1431616551	1431618351	0	127.0.0.1	1	1431616551	\N	\N
524	12	1431359501	1431361301	0	127.0.0.1	1	1431359501	1431359518	127.0.0.1
563	20	1433342510	1433344310	0	172.16.20.21	1	1433342510	1433342519	172.16.20.21
523	12	1431358396	1431360196	0	127.0.0.1	2	1431359414	1431359475	127.0.0.1
583	1	1433861604	1433863404	0	127.0.0.1	4	1433862584	1433862619	127.0.0.1
526	4	1431359803	1431361603	1	172.16.20.13	1	1431359803	\N	\N
564	20	1433342555	1433344355	1	172.16.31.44	3	1433343949	\N	\N
565	20	1433347398	1433349198	1	172.16.31.44	1	1433347398	\N	\N
547	1	1432118888	1432120688	0	127.0.0.1	2	1432120641	\N	\N
534	1	1431618446	1431620246	0	127.0.0.1	3	1431620204	\N	\N
566	12	1433355391	1433357191	0	172.16.20.22	2	1433355865	1433355966	172.16.20.22
548	1	1432120835	1432122635	0	127.0.0.1	2	1432122078	\N	\N
588	11	1433863607	1433865407	0	127.0.0.1	1	1433863607	1433863664	127.0.0.1
535	1	1431620265	1431622065	0	127.0.0.1	1	1431620265	\N	\N
536	1	1431622109	1431623909	1	127.0.0.1	2	1431623010	\N	\N
537	1	1431703506	1431705306	1	127.0.0.1	1	1431703506	\N	\N
549	1	1432123533	1432125333	0	127.0.0.1	2	1432123949	\N	\N
538	12	1432046388	1432048188	0	172.16.20.17	2	1432046458	1432046825	172.16.20.17
539	12	1432046833	1432048633	0	172.16.20.17	1	1432046833	1432047042	172.16.20.17
525	12	1431359697	1431361497	0	172.16.20.13	2	1431359707	1431359792	172.16.20.13
550	1	1432125516	1432127316	1	127.0.0.1	1	1432125516	\N	\N
573	12	1433514821	1433516621	0	::1	1	1433514821	1433514965	::1
567	11	1433356289	1433358089	0	::1	1	1433356289	\N	\N
527	12	1431359921	1431361721	0	172.16.20.13	6	1431361441	\N	\N
540	1	1432042223	1432044023	0	127.0.0.1	3	1432043859	\N	\N
528	1	1431511150	1431512950	0	127.0.0.1	2	1431512457	\N	\N
568	11	1433358802	1433360602	0	::1	1	1433358802	\N	\N
541	1	1432044072	1432045872	1	127.0.0.1	3	1432045280	\N	\N
542	11	1432061899	1432063699	1	172.16.20.20	1	1432061899	\N	\N
529	1	1431513292	1431515092	0	127.0.0.1	3	1431514776	\N	\N
530	1	1431531484	1431533284	1	127.0.0.1	2	1431515328	\N	\N
569	12	1433435416	1433437216	1	::1	1	1433435416	\N	\N
570	21	1433444005	1433445805	1	172.16.31.15	1	1433444005	\N	\N
543	1	1432046371	1432048171	0	127.0.0.1	1	1432046371	\N	\N
544	1	1432065082	1432066882	1	127.0.0.1	2	1432049261	\N	\N
551	1	1432129862	1432131662	0	127.0.0.1	2	1432131183	\N	\N
545	1	1432115042	1432116842	0	127.0.0.1	2	1432116135	\N	\N
531	1	1431612844	1431614644	0	127.0.0.1	4	1431614374	\N	\N
532	1	1431614722	1431616522	0	127.0.0.1	1	1431614722	\N	\N
546	1	1432116843	1432118643	0	127.0.0.1	1	1432116843	\N	\N
571	12	1433448386	1433450186	1	::1	1	1433448386	\N	\N
572	11	1433511933	1433513733	1	172.16.20.22	1	1433511933	\N	\N
575	12	1433515663	1433517463	0	::1	2	1433516347	1433516523	::1
590	1	1433864372	1433866172	0	127.0.0.1	3	1433864784	\N	\N
552	1	1432131779	1432133579	0	127.0.0.1	2	1432133353	\N	\N
553	1	1432133646	1432135446	1	127.0.0.1	2	1432134374	\N	\N
554	1	1432222093	1432223893	1	::1	1	1432222093	\N	\N
555	4	1432300688	1432302488	0	172.16.20.22	1	1432300688	1432300747	172.16.20.22
556	1	1432307515	1432309315	1	127.0.0.1	1	1432307515	\N	\N
557	1	1432312807	1432314607	1	127.0.0.1	2	1432313770	\N	\N
591	1	1433866180	1433867980	1	127.0.0.1	1	1433866180	\N	\N
558	12	1432837888	1432839688	1	172.16.20.22	1	1432837888	\N	\N
559	1	1433273671	1433275471	0	172.16.20.21	1	1433273671	1433273691	172.16.20.21
561	1	1433273792	1433275592	0	172.16.20.21	1	1433273792	1433273854	172.16.20.21
592	11	1433946457	1433948257	1	::1	1	1433946457	\N	\N
560	12	1433273747	1433275547	0	172.16.20.21	2	1433273866	1433274370	172.16.20.21
562	4	1433274445	1433276245	0	172.16.20.21	1	1433274445	1433274454	172.16.20.21
585	1	1433862903	1433864703	0	127.0.0.1	1	1433862903	1433862969	127.0.0.1
574	11	1433514994	1433516794	0	::1	2	1433516539	\N	\N
576	11	1433517087	1433518887	1	::1	1	1433517087	\N	\N
577	11	1433519997	1433521797	1	::1	1	1433519997	\N	\N
578	12	1433520195	1433521995	1	::1	1	1433520195	\N	\N
579	1	1433865818	1433867618	0	::1	1	1433865818	1433865839	::1
581	1	1433866536	1433868336	0	::1	1	1433866536	1433866550	::1
580	11	1433866020	1433867820	1	::1	2	1433866570	\N	\N
582	1	1433878109	1433879909	0	::1	1	1433878109	1433878115	::1
584	11	1433878216	1433880016	0	127.0.0.1	2	1433862635	1433862898	127.0.0.1
586	11	1433863046	1433864846	0	127.0.0.1	1	1433863046	1433863109	127.0.0.1
589	11	1433880467	1433882267	1	::1	1	1433880467	\N	\N
593	12	1433953124	1433954924	0	172.16.20.13	1	1433953124	1433953380	172.16.20.13
587	1	1433863115	1433864915	0	127.0.0.1	3	1433864240	1433864258	127.0.0.1
594	11	1434378110	1434379910	1	172.16.20.25	1	1434378110	\N	\N
595	12	1434482567	1434484367	0	::1	1	1434482567	\N	\N
596	12	1434484973	1434486773	0	::1	1	1434484973	1434485334	::1
597	12	1434485344	1434487144	0	::1	1	1434485344	\N	\N
598	12	1434487322	1434489122	1	::1	1	1434487322	\N	\N
599	20	1434549911	1434551711	1	172.16.2.166	1	1434549911	\N	\N
600	1	1434633186	1434634986	0	127.0.0.1	3	1434634165	\N	\N
601	1	1434635047	1434636847	0	127.0.0.1	2	1434636055	\N	\N
603	12	1434654187	1434655987	0	172.16.20.17	1	1434654187	1434654448	172.16.20.17
604	12	1434654625	1434656425	0	172.16.20.17	1	1434654625	1434654934	172.16.20.17
605	12	1434655519	1434657319	1	172.16.20.19	2	1434656344	\N	\N
602	1	1434636917	1434638717	0	127.0.0.1	1	1434636917	\N	\N
607	11	1434656727	1434658527	1	::1	1	1434656727	\N	\N
608	12	1434657445	1434659245	0	172.16.20.16	1	1434657445	1434657460	172.16.20.16
606	1	1434639368	1434641168	0	127.0.0.1	3	1434640982	\N	\N
609	12	1434657476	1434659276	0	172.16.20.16	1	1434657476	1434658369	172.16.20.16
611	12	1434658381	1434660181	0	172.16.20.16	1	1434658381	1434658540	172.16.20.16
612	14	1434658631	1434660431	0	172.16.20.16	1	1434658631	1434659213	172.16.20.16
610	1	1434641279	1434643079	0	127.0.0.1	2	1434642152	\N	\N
613	1	1434643479	1434645279	1	127.0.0.1	1	1434643479	\N	\N
614	12	1434660863	1434662663	1	172.16.20.19	1	1434660863	\N	\N
615	12	1434740028	1434741828	1	::1	3	1434740992	\N	\N
616	12	1434741850	1434743650	1	::1	2	1434742210	\N	\N
617	12	1434747730	1434749530	0	::1	4	1434748603	1434748664	::1
618	12	1434748680	1434750480	0	::1	1	1434748680	1434748704	::1
619	12	1434748852	1434750652	0	::1	1	1434748852	1434748899	::1
620	12	1434987858	1434989658	1	172.16.20.13	1	1434987858	\N	\N
621	1	1435004847	1435006647	0	172.16.20.21	1	1435004847	1435004992	172.16.20.21
622	12	1435004890	1435006690	0	127.0.0.1	1	1435004890	1435005262	127.0.0.1
623	1	1435005272	1435007072	1	127.0.0.1	1	1435005272	\N	\N
624	10	1435071057	1435072857	1	172.16.20.19	1	1435071057	\N	\N
625	12	1435071666	1435073466	1	::1	1	1435071666	\N	\N
626	4	1435700665	1435702465	0	172.16.20.13	1	1435700665	1435700669	172.16.20.13
627	1	1435700676	1435702476	0	172.16.20.13	1	1435700676	1435700806	172.16.20.13
628	1	1435700826	1435702626	0	172.16.20.13	1	1435700826	1435700829	172.16.20.13
629	12	1435700846	1435702646	0	172.16.20.13	1	1435700846	1435700913	172.16.20.13
630	1	1435778465	1435780265	0	172.16.20.11	1	1435778465	1435778477	172.16.20.11
631	4	1435778484	1435780284	0	172.16.20.11	1	1435778484	1435778497	172.16.20.11
632	14	1435852010	1435853810	1	172.16.23.11	1	1435852010	\N	\N
634	15	1435852025	1435853825	1	172.16.20.23	1	1435852025	\N	\N
635	22	1435852087	1435853887	1	172.16.20.12	1	1435852087	\N	\N
633	19	1435852019	1435853819	0	172.16.20.14	1	1435852019	1435852984	172.16.20.14
636	11	1435852773	1435854573	1	172.16.20.25	2	1435853185	\N	\N
637	4	1436369600	1436371400	0	172.16.20.13	1	1436369600	1436369610	172.16.20.13
638	1	1436371272	1436373072	0	172.16.0.2	1	1436371272	1436371607	172.16.0.2
639	4	1436371615	1436373415	0	172.16.0.2	1	1436371615	1436371622	172.16.0.2
640	12	1436371632	1436373432	0	172.16.0.2	1	1436371632	1436371634	172.16.0.2
641	1	1436371731	1436373531	0	172.16.0.2	1	1436371731	1436371988	172.16.0.2
642	12	1436804548	1436806348	0	172.16.20.28	1	1436804548	1436804555	172.16.20.28
643	11	1436897039	1436898839	1	172.16.20.17	1	1436897039	\N	\N
644	4	1436899446	1436901246	0	172.16.20.13	1	1436899446	1436899468	172.16.20.13
645	1	1436899488	1436901288	0	172.16.20.13	1	1436899488	1436899575	172.16.20.13
646	4	1436900145	1436901945	0	172.16.20.13	2	1436901373	1436901533	172.16.20.13
647	1	1436901548	1436903348	0	172.16.20.13	1	1436901548	1436901828	172.16.20.13
648	23	1436905311	1436907111	0	172.16.31.24	1	1436905311	1436905480	172.16.31.24
649	4	1436905597	1436907397	0	172.16.31.24	1	1436905597	1436906964	172.16.31.24
666	4	1437149957	1437151757	0	172.16.20.13	1	1437149957	1437149961	172.16.20.13
665	31	1437149595	1437151395	0	172.16.0.2	1	1437149595	1437150290	172.16.0.2
667	1	1437149989	1437151789	0	172.16.20.13	1	1437149989	1437150297	172.16.20.13
668	4	1437150309	1437152109	0	172.16.20.13	1	1437150309	1437150314	172.16.20.13
669	31	1437150316	1437152116	0	172.16.0.2	1	1437150316	1437150355	172.16.0.2
670	29	1437397302	1437399102	1	172.16.13.15	1	1437397302	\N	\N
671	33	1437402196	1437403996	1	172.16.2.196	1	1437402196	\N	\N
673	33	1437405110	1437406910	1	172.16.2.196	1	1437405110	\N	\N
672	31	1437404694	1437406494	0	172.16.0.2	1	1437404694	1437405999	172.16.0.2
674	31	1437406015	1437407815	0	172.16.0.2	1	1437406015	1437406137	172.16.0.2
675	31	1437406153	1437407953	1	172.16.0.2	1	1437406153	\N	\N
656	25	1437051141	1437052941	0	172.16.31.22	2	1437052078	\N	\N
650	24	1436908347	1436910147	0	172.16.31.15	2	1436908987	\N	\N
651	11	1436966751	1436968551	0	172.16.31.11	1	1436966751	1436966780	172.16.31.11
652	25	1436966819	1436968619	0	172.16.31.11	1	1436966819	1436966940	172.16.31.11
653	26	1436967143	1436968943	0	172.16.20.25	1	1436967143	1436967152	172.16.20.25
654	26	1436967284	1436969084	0	172.16.31.11	1	1436967284	1436967358	172.16.31.11
655	26	1436967380	1436969180	1	172.16.31.11	1	1436967380	\N	\N
658	25	1437054741	1437056541	1	172.16.31.22	1	1437054741	\N	\N
657	27	1437053390	1437055190	1	172.16.31.22	2	1437054780	\N	\N
659	28	1437054965	1437056765	0	172.16.31.22	1	1437054965	1437055072	172.16.31.22
660	25	1437056597	1437058397	1	172.16.31.22	1	1437056597	\N	\N
661	29	1437145095	1437146895	0	172.16.13.13	1	1437145095	1437145188	172.16.13.13
664	32	1437146988	1437148788	1	172.16.13.13	1	1437146988	\N	\N
662	30	1437146622	1437148422	0	172.16.2.137	1	1437146622	1437147105	172.16.2.137
676	4	1437425183	1437426983	0	172.16.20.21	1	1437425183	1437425254	172.16.20.21
677	9	1437425299	1437427099	0	172.16.20.21	1	1437425299	1437425340	172.16.20.21
679	32	1437485642	1437487442	1	172.16.13.13	1	1437485642	\N	\N
678	30	1437485115	1437486915	1	172.16.2.137	2	1437485883	\N	\N
680	23	1437492543	1437494343	0	172.16.31.24	1	1437492543	1437492632	172.16.31.24
681	31	1437492715	1437494515	0	172.16.0.2	1	1437492715	1437492891	172.16.0.2
682	32	1437492719	1437494519	0	172.16.13.13	1	1437492719	1437492969	172.16.13.13
663	31	1437146898	1437148698	0	172.16.0.2	1	1437146898	\N	\N
683	31	1437496956	1437498756	0	172.16.13.13	1	1437496956	1437496983	172.16.13.13
693	42	1437595488	1437597288	1	172.16.2.196	1	1437595488	\N	\N
684	34	1437501919	1437503719	0	172.16.0.2	2	1437502775	1437503146	172.16.0.2
685	21	1437507501	1437509301	0	172.16.31.44	1	1437507501	1437507771	172.16.31.44
686	35	1437578869	1437580669	1	172.16.0.2	1	1437578869	\N	\N
687	36	1437579426	1437581226	0	172.16.1.8	1	1437579426	1437579618	172.16.1.8
688	37	1437580016	1437581816	1	172.16.2.91	1	1437580016	\N	\N
690	39	1437580805	1437582605	1	172.16.1.98	1	1437580805	\N	\N
691	40	1437580823	1437582623	1	172.16.1.61	1	1437580823	\N	\N
689	38	1437580410	1437582210	0	172.16.0.2	1	1437580410	1437581810	172.16.0.2
692	41	1437593201	1437595001	1	172.16.13.14	1	1437593201	\N	\N
694	43	1437658688	1437660488	0	172.16.2.63	1	1437658688	1437659825	172.16.2.63
695	44	1437661000	1437662800	0	172.16.13.11	1	1437661000	\N	\N
696	44	1437663614	1437665414	0	172.16.13.11	1	1437663614	\N	\N
697	44	1437666575	1437668375	0	172.16.13.11	1	1437666575	1437666885	172.16.13.11
698	44	1437666945	1437668745	1	172.16.13.11	1	1437666945	\N	\N
699	44	1437675989	1437677789	1	172.16.13.11	1	1437675989	\N	\N
700	9	1437678580	1437680380	1	172.16.20.21	1	1437678580	\N	\N
702	40	1438007157	1438008957	1	172.16.1.61	1	1438007157	\N	\N
701	45	1438003977	1438005777	0	172.16.0.2	1	1438003977	\N	\N
704	47	1438089185	1438090985	1	172.16.1.216	1	1438089185	\N	\N
748	70	1438178845	1438180645	1	172.16.1.94	1	1438178845	\N	\N
718	36	1438095533	1438097333	0	172.16.15.11	2	1438096134	\N	\N
771	64	1438192742	1438194542	1	172.16.18.12	1	1438192742	\N	\N
720	55	1438095895	1438097695	0	172.16.0.2	1	1438095895	\N	\N
757	56	1438182848	1438184648	0	172.16.2.191	1	1438182848	1438183507	172.16.2.191
759	74	1438183538	1438185338	1	172.16.2.191	1	1438183538	\N	\N
760	59	1438183870	1438185670	1	172.16.18.10	1	1438183870	\N	\N
722	36	1438097539	1438099339	1	172.16.15.11	5	1438098116	\N	\N
724	9	1438099140	1438100940	0	172.16.20.17	1	1438099140	1438099159	172.16.20.17
755	72	1438181522	1438183322	0	172.16.17.10	1	1438181522	\N	\N
717	54	1438093305	1438095105	0	172.16.1.8	2	1438095033	\N	\N
719	54	1438095680	1438097480	1	172.16.1.8	1	1438095680	\N	\N
723	49	1438098642	1438100442	0	172.16.20.17	2	1438099223	1438099248	172.16.20.17
703	46	1438088088	1438089888	0	172.16.2.29	2	1438089558	\N	\N
707	46	1438090073	1438091873	1	172.16.2.29	1	1438090073	\N	\N
721	48	1438096191	1438097991	1	172.16.2.156	1	1438096191	\N	\N
709	51	1438090709	1438092509	0	172.16.1.229	1	1438090709	1438091498	172.16.1.229
708	50	1438090617	1438092417	1	172.16.1.115	3	1438091512	\N	\N
710	51	1438091516	1438093316	0	172.16.1.229	1	1438091516	1438091526	172.16.1.229
725	4	1438099275	1438101075	0	172.16.20.17	1	1438099275	1438099493	172.16.20.17
726	49	1438099440	1438101240	0	172.16.20.19	1	1438099440	1438099509	172.16.20.19
727	4	1438099508	1438101308	0	172.16.20.13	1	1438099508	1438100090	172.16.20.13
728	4	1438100102	1438101902	1	172.16.20.13	1	1438100102	\N	\N
729	48	1438103770	1438105570	1	172.16.2.156	1	1438103770	\N	\N
730	49	1438105755	1438107555	0	172.16.14.51	1	1438105755	1438105870	172.16.14.51
731	56	1438111183	1438112983	1	172.16.28.12	1	1438111183	\N	\N
733	14	1438175388	1438177188	0	172.16.23.11	1	1438175388	1438175411	172.16.23.11
734	58	1438175795	1438177595	0	172.16.20.27	1	1438175795	1438175917	172.16.20.27
732	57	1438175320	1438177120	0	172.16.1.229	1	1438175320	1438176507	172.16.1.229
738	62	1438176638	1438178438	1	172.16.1.229	1	1438176638	\N	\N
737	61	1438176215	1438178015	0	172.16.30.14	1	1438176215	1438177134	172.16.30.14
741	61	1438177151	1438178951	0	172.16.30.14	1	1438177151	1438177161	172.16.30.14
743	65	1438177410	1438179210	1	172.16.1.123	1	1438177410	\N	\N
744	66	1438177438	1438179238	1	172.16.17.16	1	1438177438	\N	\N
705	48	1438089396	1438091196	0	172.16.2.156	1	1438089396	\N	\N
712	48	1438091947	1438093747	1	172.16.2.156	1	1438091947	\N	\N
711	52	1438091583	1438093383	0	172.16.1.229	1	1438091583	1438092184	172.16.1.229
713	45	1438092065	1438093865	0	172.16.0.2	1	1438092065	1438092220	172.16.0.2
742	64	1438177197	1438178997	0	172.16.18.12	1	1438177197	\N	\N
706	49	1438089521	1438091321	0	172.16.14.51	1	1438089521	\N	\N
715	10	1438092495	1438094295	1	172.16.20.19	1	1438092495	\N	\N
716	53	1438092933	1438094733	1	172.16.1.229	1	1438092933	\N	\N
749	64	1438179153	1438180953	1	172.16.18.12	1	1438179153	\N	\N
714	36	1438092249	1438094049	0	172.16.15.11	1	1438092249	\N	\N
762	68	1438184001	1438185801	1	172.16.20.19	1	1438184001	\N	\N
740	63	1438177147	1438178947	0	172.16.18.13	2	1438178000	\N	\N
764	75	1438184194	1438185994	1	172.16.1.198	1	1438184194	\N	\N
751	71	1438180001	1438181801	1	172.16.30.12	1	1438180001	\N	\N
745	67	1438178441	1438180241	0	172.16.17.13	1	1438178441	1438180128	172.16.17.13
736	60	1438176003	1438177803	0	172.16.18.11	1	1438176003	\N	\N
735	59	1438175885	1438177685	0	172.16.18.10	1	1438175885	\N	\N
752	67	1438180165	1438181965	0	172.16.17.13	1	1438180165	1438180301	172.16.17.13
746	68	1438178716	1438180516	1	172.16.2.46	3	1438180450	\N	\N
770	78	1438192431	1438194231	0	172.16.19.16	1	1438192431	1438192906	172.16.19.16
747	69	1438178777	1438180577	0	172.16.1.110	1	1438178777	\N	\N
753	60	1438180276	1438182076	0	172.16.18.11	1	1438180276	1438181302	172.16.18.11
739	45	1438176923	1438178723	0	172.16.0.2	1	1438176923	\N	\N
750	45	1438179449	1438181249	1	172.16.0.2	1	1438179449	\N	\N
756	73	1438181889	1438183689	0	172.16.20.19	1	1438181889	1438181901	172.16.20.19
761	72	1438183926	1438185726	0	172.16.17.10	2	1438184480	1438184606	172.16.17.10
754	68	1438180669	1438182469	0	172.16.20.19	2	1438182149	1438182370	172.16.20.19
758	64	1438183010	1438184810	1	172.16.18.12	1	1438183010	\N	\N
763	71	1438184015	1438185815	1	172.16.30.12	2	1438185175	\N	\N
772	79	1438193426	1438195226	1	172.16.19.13	1	1438193426	\N	\N
765	76	1438185340	1438187140	1	172.16.17.10	1	1438185340	\N	\N
766	77	1438187174	1438188974	1	172.16.18.10	1	1438187174	\N	\N
767	64	1438188701	1438190501	1	172.16.18.12	1	1438188701	\N	\N
768	68	1438192090	1438193890	0	172.16.20.19	1	1438192090	1438192102	172.16.20.19
769	4	1438192161	1438193961	0	172.16.20.19	1	1438192161	1438192652	172.16.20.19
774	80	1438196752	1438198552	1	172.16.19.11	1	1438196752	\N	\N
773	68	1438195756	1438197556	0	172.16.19.17	1	1438195756	\N	\N
775	68	1438197635	1438199435	0	172.16.20.19	2	1438197913	1438198021	172.16.20.19
777	81	1438201490	1438203290	1	172.16.1.229	1	1438201490	\N	\N
776	64	1438200385	1438202185	1	172.16.18.12	1	1438200385	\N	\N
778	82	1438258566	1438260366	1	172.16.1.229	1	1438258566	\N	\N
779	68	1438261354	1438263154	1	172.16.19.17	1	1438261354	\N	\N
781	70	1438261843	1438263643	1	172.16.1.94	1	1438261843	\N	\N
780	83	1438261360	1438263160	0	172.16.19.10	1	1438261360	1438262509	172.16.19.10
782	82	1438264795	1438266595	1	172.16.28.50	1	1438264795	\N	\N
783	84	1438267088	1438268888	1	172.16.14.21	2	1438268063	\N	\N
784	85	1438267119	1438268919	0	172.16.20.17	1	1438267119	1438268674	172.16.20.17
786	87	1438270450	1438272250	1	172.16.19.15	1	1438270450	\N	\N
788	89	1438271529	1438273329	1	172.16.19.14	1	1438271529	\N	\N
789	68	1438271888	1438273688	0	172.16.20.19	1	1438271888	1438271953	172.16.20.19
787	88	1438271439	1438273239	0	172.16.14.19	1	1438271439	1438272242	172.16.14.19
797	94	1438278508	1438280308	0	172.16.1.94	1	1438278508	\N	\N
802	79	1438280189	1438281989	0	172.16.19.13	1	1438280189	1438280634	172.16.19.13
799	96	1438279938	1438281738	0	172.16.20.17	1	1438279938	1438280749	172.16.20.17
803	80	1438280752	1438282552	1	172.16.19.13	1	1438280752	\N	\N
804	98	1438280836	1438282636	0	172.16.20.17	1	1438280836	1438281364	172.16.20.17
805	99	1438282526	1438284326	0	172.16.20.17	1	1438282526	1438282787	172.16.20.17
806	70	1438283114	1438284914	1	172.16.1.94	3	1438283575	\N	\N
814	75	1438346760	1438348560	0	172.16.1.198	2	1438348484	\N	\N
815	104	1438350299	1438352099	0	172.16.14.11	1	1438350299	1438351174	172.16.14.11
834	107	1438372348	1438374148	0	172.16.2.245	1	1438372348	1438372953	172.16.2.245
836	23	1438372891	1438374691	0	172.16.31.24	1	1438372891	1438372986	172.16.31.24
817	23	1438352846	1438354646	0	172.16.31.24	1	1438352846	1438353001	172.16.31.24
785	86	1438270423	1438272223	0	172.16.14.20	3	1438271681	\N	\N
790	86	1438272658	1438274458	1	172.16.14.20	1	1438272658	\N	\N
791	68	1438272905	1438274705	1	172.16.19.17	1	1438272905	\N	\N
792	90	1438273127	1438274927	1	172.16.1.94	2	1438273985	\N	\N
794	91	1438277682	1438279482	1	172.16.14.21	1	1438277682	\N	\N
816	105	1438350687	1438352487	0	172.16.2.245	1	1438350687	\N	\N
818	105	1438353006	1438354806	0	172.16.2.245	1	1438353006	1438353433	172.16.2.245
819	106	1438353618	1438355418	1	172.16.1.94	1	1438353618	\N	\N
821	108	1438354353	1438356153	1	172.16.28.50	1	1438354353	\N	\N
820	107	1438353798	1438355598	1	172.16.2.245	2	1438354528	\N	\N
823	109	1438365767	1438367567	0	172.16.14.11	1	1438365767	1438366769	172.16.14.11
850	119	1438384588	1438386388	0	192.168.0.7	1	1438384588	1438385134	192.168.0.7
824	107	1438367857	1438369657	0	172.16.2.245	3	1438369524	\N	\N
847	120	1438380861	1438382661	0	172.16.1.107	2	1438380903	1438380947	172.16.1.107
822	107	1438365095	1438366895	0	172.16.2.245	1	1438365095	\N	\N
825	95	1438369047	1438370847	1	172.16.1.94	1	1438369047	\N	\N
826	63	1438369252	1438371052	1	172.16.18.12	1	1438369252	\N	\N
848	120	1438380957	1438382757	0	172.16.1.107	1	1438380957	1438380970	172.16.1.107
830	112	1438370840	1438372640	1	192.168.0.7	1	1438370840	\N	\N
831	65	1438371207	1438373007	1	172.16.1.123	1	1438371207	\N	\N
807	100	1438284489	1438286289	0	172.16.1.94	2	1438285727	\N	\N
793	70	1438275966	1438277766	0	172.16.1.94	1	1438275966	\N	\N
796	93	1438278367	1438280167	0	172.16.14.17	1	1438278367	1438278551	172.16.14.17
798	95	1438279205	1438281005	1	172.16.2.151	1	1438279205	\N	\N
808	100	1438286872	1438288672	1	172.16.1.94	1	1438286872	\N	\N
800	97	1438279952	1438281752	1	172.16.19.10	1	1438279952	\N	\N
809	101	1438286882	1438288682	0	172.16.20.17	1	1438286882	1438287553	172.16.20.17
795	92	1438278043	1438279843	0	172.16.1.204	2	1438279668	\N	\N
801	92	1438280139	1438281939	0	172.16.1.204	1	1438280139	1438280171	172.16.1.204
810	68	1438288389	1438290189	0	172.16.19.13	1	1438288389	1438288606	172.16.19.13
811	60	1438345428	1438347228	0	172.16.18.11	1	1438345428	1438345534	172.16.18.11
813	103	1438346628	1438348428	1	172.16.2.98	1	1438346628	\N	\N
812	102	1438345973	1438347773	0	172.16.28.50	1	1438345973	1438346802	172.16.28.50
835	115	1438372685	1438374485	0	172.16.1.94	1	1438372685	\N	\N
840	115	1438374555	1438376355	0	172.16.1.94	1	1438374555	1438374565	172.16.1.94
841	115	1438374588	1438376388	1	172.16.1.94	1	1438374588	\N	\N
839	116	1438374546	1438376346	1	172.16.14.11	2	1438375165	\N	\N
838	114	1438374331	1438376131	0	172.16.1.20	1	1438374331	1438375230	172.16.1.20
842	114	1438375255	1438377055	1	172.16.1.20	1	1438375255	\N	\N
828	107	1438369963	1438371763	0	172.16.2.245	3	1438370501	\N	\N
832	113	1438371506	1438373306	0	172.16.28.50	4	1438373164	\N	\N
833	114	1438371646	1438373446	0	172.16.1.20	1	1438371646	\N	\N
837	114	1438373630	1438375430	0	172.16.1.20	1	1438373630	1438374237	172.16.1.20
843	117	1438376040	1438377840	0	172.16.30.14	1	1438376040	1438376977	172.16.30.14
829	111	1438370227	1438372027	0	172.16.28.50	2	1438371859	\N	\N
827	110	1438369874	1438371674	0	172.16.1.94	2	1438370837	\N	\N
845	119	1438377606	1438379406	1	192.168.0.7	1	1438377606	\N	\N
844	118	1438377003	1438378803	1	172.16.30.14	2	1438378069	\N	\N
846	120	1438379302	1438381102	0	172.16.1.107	1	1438379302	1438380831	172.16.1.107
851	121	1438386810	1438388610	0	172.16.2.245	1	1438386810	1438386854	172.16.2.245
849	120	1438380987	1438382787	0	172.16.1.107	1	1438380987	1438381446	172.16.1.107
852	122	1438386865	1438388665	1	192.168.0.7	1	1438386865	\N	\N
853	123	1438388511	1438390311	0	172.16.1.131	1	1438388511	1438389934	172.16.1.131
855	122	1438392728	1438394528	0	192.168.0.7	1	1438392728	1438392775	192.168.0.7
854	121	1438392178	1438393978	0	172.16.2.245	1	1438392178	1438393406	172.16.2.245
856	124	1438603015	1438604815	1	172.16.2.247	1	1438603015	\N	\N
857	125	1438603034	1438604834	1	172.16.2.127	1	1438603034	\N	\N
858	126	1438604481	1438606281	1	172.16.2.247	1	1438604481	\N	\N
889	138	1438787187	1438788987	1	172.16.12.22	1	1438787187	\N	\N
888	137	1438786918	1438788718	0	172.16.31.30	1	1438786918	1438787230	172.16.31.30
890	139	1438787405	1438789205	1	172.16.2.21	1	1438787405	\N	\N
859	110	1438607290	1438609090	0	172.16.1.94	1	1438607290	\N	\N
860	94	1438613919	1438615719	1	172.16.1.94	1	1438613919	\N	\N
861	127	1438616126	1438617926	0	172.16.2.163	1	1438616126	1438616302	172.16.2.163
862	127	1438616781	1438618581	1	172.16.2.163	1	1438616781	\N	\N
863	122	1438617482	1438619282	1	192.168.0.7	1	1438617482	\N	\N
864	1	1438622063	1438623863	0	172.16.20.21	1	1438622063	1438622082	172.16.20.21
865	10	1438629638	1438631438	0	172.16.20.19	1	1438629638	1438630017	172.16.20.19
868	129	1438631521	1438633321	1	192.168.0.7	1	1438631521	\N	\N
866	10	1438631409	1438633209	0	172.16.20.19	1	1438631409	1438632069	172.16.20.19
869	130	1438632779	1438634579	1	172.16.1.204	1	1438632779	\N	\N
867	128	1438631426	1438633226	0	192.168.0.7	1	1438631426	\N	\N
870	128	1438633246	1438635046	1	192.168.0.7	1	1438633246	\N	\N
871	131	1438635224	1438637024	1	172.16.2.51	1	1438635224	\N	\N
893	142	1438788112	1438789912	1	172.16.29.12	1	1438788112	\N	\N
894	143	1438788178	1438789978	1	172.16.0.2	1	1438788178	\N	\N
895	144	1438788198	1438789998	1	172.16.12.24	1	1438788198	\N	\N
892	141	1438788096	1438789896	1	172.16.2.25	2	1438788368	\N	\N
872	128	1438646500	1438648300	0	192.168.0.7	1	1438646500	\N	\N
873	128	1438650906	1438652706	0	192.168.0.7	1	1438650906	1438650954	192.168.0.7
874	132	1438692911	1438694711	1	172.16.2.245	1	1438692911	\N	\N
875	23	1438700418	1438702218	0	172.16.31.24	1	1438700418	1438700744	172.16.31.24
876	23	1438700876	1438702676	1	172.16.31.24	1	1438700876	\N	\N
877	115	1438709732	1438711532	1	172.16.1.94	1	1438709732	\N	\N
897	146	1438788293	1438790093	0	172.16.12.12	1	1438788293	1438789060	172.16.12.12
878	128	1438738800	1438740600	0	192.168.0.7	2	1438740533	\N	\N
899	22	1438788480	1438790280	0	172.16.20.12	1	1438788480	1438789133	172.16.20.12
891	140	1438788001	1438789801	0	172.16.29.14	1	1438788001	1438789185	172.16.29.14
921	11	1438797940	1438799740	1	172.16.20.25	1	1438797940	\N	\N
879	128	1438741228	1438743028	0	192.168.0.7	4	1438741606	1438741757	192.168.0.7
880	128	1438741781	1438743581	0	192.168.0.7	1	1438741781	1438741784	192.168.0.7
881	133	1438774555	1438776355	0	172.16.14.91	1	1438774555	1438774802	172.16.14.91
882	129	1438774820	1438776620	0	172.16.14.91	1	1438774820	1438775669	172.16.14.91
904	151	1438789759	1438791559	1	172.16.12.16	1	1438789759	\N	\N
902	150	1438789112	1438790912	1	172.16.1.208	2	1438789783	\N	\N
925	128	1438799682	1438801482	1	172.16.31.24	1	1438799682	\N	\N
896	145	1438788245	1438790045	0	172.16.2.104	1	1438788245	\N	\N
905	62	1438790266	1438792066	1	172.16.2.104	1	1438790266	\N	\N
922	115	1438798458	1438800258	0	172.16.1.204	1	1438798458	\N	\N
927	70	1438800265	1438802065	1	172.16.1.204	1	1438800265	\N	\N
929	100	1438800439	1438802239	1	172.16.1.204	1	1438800439	\N	\N
914	147	1438792665	1438794465	0	172.16.12.21	1	1438792665	\N	\N
903	139	1438789643	1438791443	1	172.16.2.21	2	1438790458	\N	\N
898	147	1438788323	1438790123	0	172.16.12.21	1	1438788323	\N	\N
906	147	1438790459	1438792259	0	172.16.12.21	2	1438790868	\N	\N
883	133	1438775687	1438777487	0	172.16.14.91	1	1438775687	\N	\N
884	134	1438779120	1438780920	1	172.16.20.17	1	1438779120	\N	\N
885	95	1438781359	1438783159	1	172.16.1.204	1	1438781359	\N	\N
886	135	1438782593	1438784393	1	172.16.1.204	1	1438782593	\N	\N
887	136	1438786159	1438787959	1	172.16.29.18	2	1438786686	\N	\N
908	153	1438790698	1438792498	1	172.16.29.14	1	1438790698	\N	\N
901	149	1438788595	1438790395	0	172.16.12.28	1	1438788595	\N	\N
909	149	1438790721	1438792521	1	172.16.12.28	1	1438790721	\N	\N
915	147	1438794928	1438796728	0	172.16.12.21	1	1438794928	1438795303	172.16.12.21
900	148	1438788549	1438790349	0	172.16.12.23	2	1438789610	\N	\N
910	148	1438790806	1438792606	0	172.16.12.23	1	1438790806	1438790904	172.16.12.23
907	152	1438790557	1438792357	0	172.16.31.32	1	1438790557	1438791360	172.16.31.32
911	154	1438790877	1438792677	0	172.16.0.2	1	1438790877	1438791470	172.16.0.2
912	155	1438792082	1438793882	1	172.16.0.2	1	1438792082	\N	\N
913	156	1438792153	1438793953	1	172.16.12.24	1	1438792153	\N	\N
916	157	1438795252	1438797052	0	172.16.12.34	2	1438795765	1438796834	172.16.12.34
920	160	1438797475	1438799275	1	172.16.12.28	1	1438797475	\N	\N
919	159	1438797234	1438799034	0	172.16.14.24	1	1438797234	1438797690	172.16.14.24
918	137	1438796896	1438798696	1	172.16.31.30	2	1438797767	\N	\N
917	158	1438796347	1438798147	0	172.16.1.204	1	1438796347	\N	\N
923	138	1438799315	1438801115	1	172.16.12.22	1	1438799315	\N	\N
924	23	1438799516	1438801316	0	172.16.31.24	1	1438799516	1438799639	172.16.31.24
926	161	1438800044	1438801844	0	172.16.1.60	1	1438800044	1438800854	172.16.1.60
928	160	1438800323	1438802123	1	172.16.12.28	2	1438801020	\N	\N
933	94	1438801318	1438803118	1	172.16.1.204	1	1438801318	\N	\N
932	45	1438801103	1438802903	0	172.16.0.2	1	1438801103	1438801484	172.16.0.2
931	163	1438800925	1438802725	0	172.16.12.14	1	1438800925	1438801616	172.16.12.14
934	164	1438801479	1438803279	0	172.16.1.94	1	1438801479	1438801823	172.16.1.94
930	162	1438800771	1438802571	0	172.16.1.166	1	1438800771	1438801965	172.16.1.166
935	162	1438802099	1438803899	0	172.16.1.166	1	1438802099	1438802120	172.16.1.166
936	130	1438802192	1438803992	1	172.16.1.204	1	1438802192	\N	\N
937	165	1438803275	1438805075	1	172.16.1.204	1	1438803275	\N	\N
939	152	1438804056	1438805856	1	172.16.31.32	1	1438804056	\N	\N
940	166	1438804083	1438805883	1	172.16.0.2	1	1438804083	\N	\N
938	155	1438803900	1438805700	0	172.16.0.2	1	1438803900	1438804627	172.16.0.2
941	167	1438805037	1438806837	0	172.16.29.19	1	1438805037	1438806802	172.16.29.19
942	167	1438806818	1438808618	0	172.16.29.19	1	1438806818	1438806883	172.16.29.19
943	110	1438865873	1438867673	1	172.16.1.204	1	1438865873	\N	\N
944	168	1438866062	1438867862	1	172.16.2.143	1	1438866062	\N	\N
952	172	1438882785	1438884585	0	172.16.14.93	1	1438882785	\N	\N
980	136	1438953749	1438955549	0	172.16.29.18	1	1438953749	\N	\N
981	136	1438955660	1438957460	1	172.16.29.18	1	1438955660	\N	\N
945	169	1438874227	1438876027	0	172.16.12.16	2	1438874787	\N	\N
982	138	1438957143	1438958943	1	172.16.12.22	1	1438957143	\N	\N
946	169	1438876401	1438878201	1	172.16.12.16	3	1438877472	\N	\N
956	173	1438884179	1438885979	0	172.16.12.15	2	1438885277	1438885839	172.16.12.15
947	170	1438876423	1438878223	0	192.168.0.7	2	1438877712	1438877720	192.168.0.7
948	170	1438877731	1438879531	1	192.168.0.7	1	1438877731	\N	\N
957	174	1438884182	1438885982	0	172.16.12.23	2	1438885934	1438885961	172.16.12.23
959	157	1438884983	1438886783	0	172.16.12.34	1	1438884983	1438885962	172.16.12.34
963	174	1438885976	1438887776	0	172.16.12.23	1	1438885976	1438886008	172.16.12.23
964	174	1438886043	1438887843	1	172.16.12.23	1	1438886043	\N	\N
962	172	1438885181	1438886981	0	172.16.14.93	1	1438885181	1438886151	172.16.14.93
958	151	1438884421	1438886221	0	172.16.12.16	2	1438885743	1438886166	172.16.12.16
960	175	1438884996	1438886796	0	172.16.2.217	1	1438884996	1438886714	172.16.2.217
950	125	1438882508	1438884308	0	172.16.14.94	1	1438882508	1438882532	172.16.14.94
965	126	1438886830	1438888630	0	172.16.14.93	1	1438886830	1438886957	172.16.14.93
983	157	1438957194	1438958994	0	172.16.12.34	1	1438957194	1438957211	172.16.12.34
985	178	1438957839	1438959639	1	172.16.23.10	1	1438957839	\N	\N
984	177	1438957757	1438959557	0	172.16.23.10	1	1438957757	1438958421	172.16.23.10
988	168	1438958910	1438960710	1	172.16.2.143	1	1438958910	\N	\N
987	163	1438958621	1438960421	0	172.16.12.14	1	1438958621	1438958982	172.16.12.14
986	179	1438958451	1438960251	0	172.16.23.10	1	1438958451	1438959511	172.16.23.10
989	138	1438960306	1438962106	1	172.16.12.22	1	1438960306	\N	\N
990	177	1438960315	1438962115	1	172.16.23.10	1	1438960315	\N	\N
961	152	1438885134	1438886934	0	172.16.31.32	2	1438885834	\N	\N
966	152	1438887053	1438888853	0	172.16.31.32	1	1438887053	1438887128	172.16.31.32
967	152	1438887155	1438888955	1	172.16.31.32	1	1438887155	\N	\N
968	165	1438887624	1438889424	1	172.16.1.204	1	1438887624	\N	\N
949	171	1438880428	1438882228	0	172.16.14.92	1	1438880428	\N	\N
951	171	1438882603	1438884403	0	172.16.14.92	1	1438882603	1438882813	172.16.14.92
954	170	1438883205	1438885005	1	192.168.0.7	1	1438883205	\N	\N
955	169	1438883883	1438885683	1	172.16.12.16	1	1438883883	\N	\N
953	131	1438882794	1438884594	1	172.16.14.94	2	1438884311	\N	\N
969	26	1438888157	1438889957	0	172.16.31.11	1	1438888157	1438888920	172.16.31.11
971	23	1438888888	1438890688	0	172.16.31.24	1	1438888888	1438889104	172.16.31.24
970	20	1438888410	1438890210	0	172.16.31.42	1	1438888410	1438889372	172.16.31.42
972	148	1438889490	1438891290	0	172.16.12.23	2	1438889968	1438889976	172.16.12.23
973	160	1438889530	1438891330	0	172.16.12.28	1	1438889530	1438889983	172.16.12.28
974	150	1438889985	1438891785	1	172.16.1.208	1	1438889985	\N	\N
975	160	1438890038	1438891838	1	172.16.12.28	1	1438890038	\N	\N
991	163	1438960454	1438962254	0	172.16.12.14	1	1438960454	1438960550	172.16.12.14
976	176	1438890066	1438891866	1	172.16.12.13	2	1438890663	\N	\N
978	163	1438895778	1438897578	1	172.16.12.14	1	1438895778	\N	\N
977	146	1438895450	1438897250	0	172.16.12.12	1	1438895450	1438896277	172.16.12.12
979	163	1438952409	1438954209	0	172.16.12.14	1	1438952409	1438952524	172.16.12.14
992	180	1438960852	1438962652	1	172.16.23.10	1	1438960852	\N	\N
993	112	1438963918	1438965718	1	172.16.1.123	1	1438963918	\N	\N
994	181	1438971412	1438973212	0	172.16.31.42	1	1438971412	1438971461	172.16.31.42
996	182	1438972140	1438973940	1	172.16.31.41	1	1438972140	\N	\N
995	181	1438972036	1438973836	0	172.16.31.42	1	1438972036	1438972992	172.16.31.42
998	27	1438973135	1438974935	0	172.16.0.2	1	1438973135	1438973196	172.16.0.2
999	27	1438973204	1438975004	1	172.16.0.2	1	1438973204	\N	\N
1001	21	1438976491	1438978291	1	172.16.20.17	2	1438976898	\N	\N
1002	9	1438977177	1438978977	0	172.16.20.17	1	1438977177	1438978196	172.16.20.17
1003	21	1438979509	1438981309	1	172.16.31.44	1	1438979509	\N	\N
1004	183	1438981503	1438983303	1	192.168.0.7	1	1438981503	\N	\N
1005	184	1439210120	1439211920	1	192.168.0.7	1	1439210120	\N	\N
1006	164	1439217594	1439219394	1	172.16.1.94	1	1439217594	\N	\N
997	21	1438972565	1438974365	0	172.16.31.44	1	1438972565	\N	\N
1007	160	1439220465	1439222265	1	172.16.28.50	1	1439220465	\N	\N
1000	21	1438974773	1438976573	0	172.16.31.24	3	1438975116	1438975232	172.16.31.24
1008	185	1439221690	1439223490	0	172.16.22.32	1	1439221690	1439222245	172.16.22.32
1010	187	1439222322	1439224122	1	172.16.17.14	1	1439222322	\N	\N
1011	188	1439222416	1439224216	0	172.16.17.12	2	1439223607	\N	\N
1009	186	1439222220	1439224020	0	172.16.17.15	1	1439222220	1439223812	172.16.17.15
1012	188	1439224571	1439226371	1	172.16.17.12	1	1439224571	\N	\N
1013	186	1439224621	1439226421	0	172.16.17.15	1	1439224621	1439224632	172.16.17.15
1014	186	1439224644	1439226444	0	172.16.17.15	1	1439224644	1439224674	172.16.17.15
1015	186	1439224686	1439226486	0	172.16.17.15	1	1439224686	1439224839	172.16.17.15
1017	190	1439229767	1439231567	1	172.16.31.22	2	1439229841	\N	\N
1016	189	1439228128	1439229928	0	172.16.22.13	1	1439228128	\N	\N
1019	66	1439230825	1439232625	1	172.16.17.16	1	1439230825	\N	\N
1088	90	1439405286	1439407086	1	172.16.30.62	1	1439405286	\N	\N
1018	189	1439230204	1439232004	0	172.16.22.13	3	1439231381	1439231763	172.16.22.13
1020	191	1439236918	1439238718	1	172.16.22.16	1	1439236918	\N	\N
1021	192	1439240092	1439241892	1	172.16.22.33	1	1439240092	\N	\N
1022	159	1439252320	1439254120	1	172.16.14.24	1	1439252320	\N	\N
1023	193	1439300925	1439302725	1	172.16.17.10	1	1439300925	\N	\N
1025	134	1439301265	1439303065	0	172.16.20.19	1	1439301265	1439301569	172.16.20.19
1027	25	1439301766	1439303566	1	172.16.31.22	1	1439301766	\N	\N
1024	66	1439301262	1439303062	1	172.16.17.16	2	1439301990	\N	\N
1028	23	1439301929	1439303729	0	172.16.31.24	1	1439301929	1439302346	172.16.31.24
1031	197	1439302523	1439304323	1	172.16.22.13	1	1439302523	\N	\N
1026	194	1439301393	1439303193	0	172.16.2.135	1	1439301393	\N	\N
1078	212	1439400859	1439402659	0	192.168.0.7	1	1439400859	\N	\N
1029	195	1439302023	1439303823	0	172.16.0.2	2	1439303180	1439303425	172.16.0.2
1034	198	1439303769	1439305569	0	172.16.20.19	1	1439303769	1439303824	172.16.20.19
1067	208	1439394845	1439396645	0	192.168.0.7	1	1439394845	\N	\N
1033	195	1439303440	1439305240	0	172.16.20.19	2	1439303923	1439303948	172.16.20.19
1032	194	1439303217	1439305017	0	172.16.2.135	1	1439303217	1439303961	172.16.2.135
1036	23	1439304043	1439305843	0	172.16.31.24	1	1439304043	1439304115	172.16.31.24
1038	9	1439304139	1439305939	0	172.16.20.17	1	1439304139	1439304144	172.16.20.17
1073	208	1439396990	1439398790	1	192.168.0.7	1	1439396990	\N	\N
1030	196	1439302166	1439303966	0	172.16.0.2	2	1439303363	\N	\N
1039	196	1439304451	1439306251	1	172.16.0.2	1	1439304451	\N	\N
1035	194	1439303975	1439305775	0	172.16.2.135	1	1439303975	1439304453	172.16.2.135
1037	195	1439304060	1439305860	0	172.16.20.19	1	1439304060	1439304522	172.16.20.19
1040	189	1439304508	1439306308	0	172.16.22.15	1	1439304508	1439304560	172.16.22.15
1041	198	1439304710	1439306510	1	172.16.22.12	1	1439304710	\N	\N
1042	23	1439304762	1439306562	0	172.16.31.24	1	1439304762	1439304765	172.16.31.24
1043	23	1439304776	1439306576	0	172.16.31.24	1	1439304776	1439304838	172.16.31.24
1044	191	1439304901	1439306701	0	172.16.20.19	1	1439304901	1439304930	172.16.20.19
1046	191	1439305676	1439307476	0	172.16.22.16	1	1439305676	1439305697	172.16.22.16
1075	184	1439398220	1439400020	1	192.168.0.7	1	1439398220	\N	\N
1045	189	1439304909	1439306709	1	172.16.22.15	3	1439305802	\N	\N
1048	178	1439306274	1439308074	0	172.16.23.10	1	1439306274	1439306326	172.16.23.10
1062	203	1439386816	1439388616	0	172.16.11.15	1	1439386816	\N	\N
1047	191	1439305716	1439307516	0	172.16.22.16	2	1439307311	1439307321	172.16.22.16
1049	23	1439307360	1439309160	0	172.16.31.24	1	1439307360	1439307574	172.16.31.24
1050	191	1439307641	1439309441	1	172.16.22.16	1	1439307641	\N	\N
1051	189	1439307742	1439309542	1	172.16.22.10	1	1439307742	\N	\N
1052	185	1439308767	1439310567	1	172.16.22.32	1	1439308767	\N	\N
1054	200	1439317696	1439319496	0	172.16.22.20	1	1439317696	\N	\N
1053	199	1439316371	1439318171	0	172.16.22.23	3	1439316907	\N	\N
1055	199	1439318790	1439320590	0	172.16.22.23	1	1439318790	1439319296	172.16.22.23
1056	201	1439380383	1439382183	0	172.16.11.19	1	1439380383	1439381465	172.16.11.19
1057	201	1439381483	1439383283	1	172.16.11.19	1	1439381483	\N	\N
1063	204	1439389316	1439391116	0	172.16.10.17	1	1439389316	1439389732	172.16.10.17
1058	201	1439385372	1439387172	0	172.16.11.19	2	1439385395	1439385403	172.16.11.19
1060	23	1439385649	1439387449	0	172.16.31.24	1	1439385649	1439385724	172.16.31.24
1061	202	1439385776	1439387576	1	172.16.11.20	1	1439385776	\N	\N
1059	201	1439385415	1439387215	0	172.16.11.19	2	1439385988	1439386703	172.16.11.19
1064	205	1439392810	1439394610	0	172.16.0.2	1	1439392810	1439393579	172.16.0.2
1066	207	1439393698	1439395498	1	172.16.22.30	1	1439393698	\N	\N
1068	209	1439394910	1439396710	0	192.168.0.7	1	1439394910	1439395313	192.168.0.7
1070	209	1439395327	1439397127	1	192.168.0.7	1	1439395327	\N	\N
1071	211	1439395658	1439397458	1	172.16.11.16	1	1439395658	\N	\N
1069	210	1439395128	1439396928	1	172.16.11.23	2	1439396165	\N	\N
1065	206	1439393332	1439395132	0	172.16.22.31	1	1439393332	\N	\N
1072	206	1439396302	1439398102	1	172.16.22.31	1	1439396302	\N	\N
1076	213	1439399628	1439401428	0	192.168.0.7	1	1439399628	1439400219	192.168.0.7
1077	67	1439400241	1439402041	0	172.16.17.13	1	1439400241	1439400787	172.16.17.13
1074	212	1439397942	1439399742	0	192.168.0.7	1	1439397942	\N	\N
1083	212	1439403328	1439405128	1	192.168.0.7	1	1439403328	\N	\N
1079	214	1439401161	1439402961	0	192.168.0.7	1	1439401161	1439401810	192.168.0.7
1080	184	1439401846	1439403646	0	192.168.0.7	1	1439401846	1439402167	192.168.0.7
1081	215	1439402536	1439404336	1	172.16.22.18	1	1439402536	\N	\N
1089	207	1439405345	1439407145	1	172.16.22.30	1	1439405345	\N	\N
1082	216	1439403023	1439404823	0	192.168.0.7	1	1439403023	1439403940	192.168.0.7
1084	216	1439404104	1439405904	0	192.168.0.7	1	1439404104	1439404122	192.168.0.7
1085	217	1439404379	1439406179	1	192.168.0.7	1	1439404379	\N	\N
1086	218	1439404523	1439406323	1	172.16.11.18	1	1439404523	\N	\N
1087	219	1439404904	1439406704	0	192.168.0.7	1	1439404904	1439406613	192.168.0.7
1090	220	1439406675	1439408475	0	192.168.0.7	1	1439406675	1439407508	192.168.0.7
1092	219	1439407563	1439409363	0	192.168.0.7	1	1439407563	1439407575	192.168.0.7
1091	221	1439407539	1439409339	0	172.16.11.11	1	1439407539	1439408445	172.16.11.11
1094	223	1439408574	1439410374	0	192.168.0.7	1	1439408574	1439408680	192.168.0.7
1096	225	1439408836	1439410636	1	172.16.11.17	1	1439408836	\N	\N
1093	222	1439407753	1439409553	0	192.168.0.7	1	1439407753	\N	\N
1097	226	1439409146	1439410946	0	192.168.0.7	1	1439409146	\N	\N
1095	224	1439408595	1439410395	0	172.16.11.27	1	1439408595	1439410086	172.16.11.27
1098	227	1439410451	1439412251	0	172.16.20.19	1	1439410451	1439410464	172.16.20.19
1101	23	1439411115	1439412915	0	172.16.31.24	1	1439411115	1439411968	172.16.31.24
1124	244	1439472586	1439474386	0	192.168.0.7	1	1439472586	\N	\N
1133	245	1439475155	1439476955	1	192.168.0.7	2	1439475562	\N	\N
1138	220	1439476161	1439477961	0	192.168.0.7	1	1439476161	1439476968	192.168.0.7
1135	252	1439475952	1439477752	0	192.168.0.7	1	1439475952	1439477162	192.168.0.7
1112	235	1439430301	1439432101	0	192.168.0.7	1	1439430301	\N	\N
1120	240	1439471330	1439473130	0	192.168.0.7	1	1439471330	\N	\N
1127	239	1439473507	1439475307	1	172.16.10.22	1	1439473507	\N	\N
1115	236	1439437788	1439439588	0	192.168.0.7	2	1439438518	\N	\N
1116	236	1439440547	1439442347	1	192.168.0.7	1	1439440547	\N	\N
1117	237	1439464298	1439466098	0	172.16.10.10	1	1439464298	1439465113	172.16.10.10
1118	238	1439470543	1439472343	1	192.168.0.7	1	1439470543	\N	\N
1107	233	1439423112	1439424912	0	192.168.0.7	1	1439423112	\N	\N
1109	233	1439425471	1439427271	0	192.168.0.7	2	1439425750	1439426887	192.168.0.7
1110	233	1439426919	1439428719	1	192.168.0.7	1	1439426919	\N	\N
1123	243	1439472081	1439473881	0	192.168.0.7	1	1439472081	1439472144	192.168.0.7
1119	239	1439471273	1439473073	1	172.16.10.22	2	1439472250	\N	\N
1121	241	1439471640	1439473440	0	192.168.0.7	1	1439471640	1439472670	192.168.0.7
1125	245	1439472685	1439474485	1	192.168.0.7	1	1439472685	\N	\N
1140	255	1439477283	1439479083	1	192.168.0.7	1	1439477283	\N	\N
1156	262	1439482568	1439484368	1	192.168.0.7	1	1439482568	\N	\N
1130	248	1439474175	1439475975	0	192.168.0.7	1	1439474175	1439475843	192.168.0.7
1099	228	1439410687	1439412487	0	192.168.0.7	1	1439410687	\N	\N
1102	228	1439413635	1439415435	0	192.168.0.7	1	1439413635	1439413717	192.168.0.7
1134	251	1439475561	1439477361	0	192.168.0.7	1	1439475561	\N	\N
1136	253	1439476032	1439477832	0	192.168.0.7	1	1439476032	1439477777	192.168.0.7
1104	231	1439415114	1439416914	1	192.168.0.7	1	1439415114	\N	\N
1126	240	1439473284	1439475084	0	192.168.0.7	1	1439473284	1439473644	192.168.0.7
1100	229	1439410701	1439412501	0	172.16.11.24	1	1439410701	\N	\N
1142	256	1439478178	1439479978	1	192.168.0.7	1	1439478178	\N	\N
1143	257	1439478461	1439480261	1	192.168.0.7	1	1439478461	\N	\N
1139	254	1439477174	1439478974	0	192.168.0.7	1	1439477174	\N	\N
1111	234	1439429584	1439431384	0	192.168.0.7	1	1439429584	\N	\N
1128	246	1439473797	1439475597	1	172.16.31.24	1	1439473797	\N	\N
1113	234	1439432370	1439434170	0	192.168.0.7	2	1439432947	\N	\N
1103	230	1439414857	1439416657	0	172.16.11.21	2	1439416076	\N	\N
1105	232	1439418846	1439420646	1	192.168.0.7	1	1439418846	\N	\N
1106	229	1439419073	1439420873	0	172.16.11.24	1	1439419073	1439419123	172.16.11.24
1108	231	1439423354	1439425154	1	192.168.0.7	1	1439423354	\N	\N
1114	234	1439434232	1439436032	0	192.168.0.7	1	1439434232	1439434246	192.168.0.7
1122	242	1439471731	1439473531	0	172.16.10.13	2	1439472763	\N	\N
1141	223	1439478134	1439479934	0	192.168.0.7	1	1439478134	1439479523	192.168.0.7
1146	223	1439479548	1439481348	0	192.168.0.7	1	1439479548	1439479591	192.168.0.7
1147	223	1439479612	1439481412	0	192.168.0.7	1	1439479612	1439479817	192.168.0.7
1144	254	1439479117	1439480917	0	192.168.0.7	1	1439479117	1439480345	192.168.0.7
1150	254	1439480369	1439482169	1	192.168.0.7	1	1439480369	\N	\N
1165	23	1439486376	1439488176	1	172.16.31.24	1	1439486376	\N	\N
1151	255	1439480499	1439482299	1	192.168.0.7	1	1439480499	\N	\N
1152	260	1439480571	1439482371	1	192.168.0.7	1	1439480571	\N	\N
1149	259	1439480254	1439482054	0	192.168.0.7	2	1439481698	\N	\N
1148	223	1439479834	1439481634	0	192.168.0.7	3	1439481072	\N	\N
1145	258	1439479188	1439480988	0	192.168.0.7	1	1439479188	\N	\N
1129	247	1439473867	1439475667	0	192.168.0.7	1	1439473867	\N	\N
1132	250	1439474836	1439476636	1	192.168.0.7	1	1439474836	\N	\N
1131	249	1439474330	1439476130	0	192.168.0.7	1	1439474330	1439475462	192.168.0.7
1137	247	1439476059	1439477859	1	192.168.0.7	1	1439476059	\N	\N
1157	259	1439482780	1439484580	1	192.168.0.7	2	1439482851	\N	\N
1158	223	1439482813	1439484613	0	192.168.0.7	1	1439482813	1439482856	192.168.0.7
1167	268	1439486479	1439488279	1	192.168.0.7	1	1439486479	\N	\N
1160	263	1439483002	1439484802	1	192.168.0.7	1	1439483002	\N	\N
1168	256	1439486526	1439488326	1	192.168.0.7	1	1439486526	\N	\N
1159	253	1439482932	1439484732	0	192.168.0.7	1	1439482932	1439483048	192.168.0.7
1154	258	1439481338	1439483138	0	192.168.0.7	2	1439482919	1439483071	192.168.0.7
1161	264	1439483127	1439484927	1	192.168.0.7	1	1439483127	\N	\N
1169	269	1439486710	1439488510	1	192.168.0.7	1	1439486710	\N	\N
1155	261	1439482456	1439484256	0	172.16.11.24	1	1439482456	\N	\N
1162	261	1439484743	1439486543	1	172.16.11.24	1	1439484743	\N	\N
1153	256	1439480667	1439482467	0	192.168.0.7	2	1439480728	\N	\N
1164	266	1439485921	1439487721	1	192.168.0.7	3	1439486691	\N	\N
1163	265	1439485541	1439487341	0	192.168.0.7	1	1439485541	1439486928	192.168.0.7
1170	270	1439487116	1439488916	0	192.168.0.7	2	1439488196	1439488422	192.168.0.7
1172	217	1439488494	1439490294	1	192.168.0.7	1	1439488494	\N	\N
1166	267	1439486479	1439488279	0	192.168.0.7	1	1439486479	\N	\N
1171	271	1439488487	1439490287	0	192.168.0.7	2	1439488953	1439489475	192.168.0.7
1173	267	1439488796	1439490596	0	192.168.0.7	1	1439488796	1439489556	192.168.0.7
1175	192	1439489808	1439491608	1	172.16.22.23	1	1439489808	\N	\N
1174	272	1439489506	1439491306	0	192.168.0.7	1	1439489506	1439489942	192.168.0.7
1176	273	1439489996	1439491796	1	192.168.0.7	1	1439489996	\N	\N
1180	275	1439491445	1439493245	1	172.16.31.38	1	1439491445	\N	\N
1177	264	1439490637	1439492437	0	192.168.0.7	1	1439490637	1439491486	192.168.0.7
1181	276	1439492220	1439494020	1	192.168.0.7	1	1439492220	\N	\N
1179	255	1439491417	1439493217	1	192.168.0.7	2	1439492311	\N	\N
1203	284	1439507952	1439509752	0	192.168.0.7	1	1439507952	1439507976	192.168.0.7
1202	285	1439507811	1439509611	0	192.168.0.7	1	1439507811	1439508103	192.168.0.7
1205	287	1439509746	1439511546	1	192.168.0.7	1	1439509746	\N	\N
1204	273	1439509696	1439511496	0	192.168.0.7	1	1439509696	1439510364	192.168.0.7
1207	288	1439511180	1439512980	1	192.168.0.7	1	1439511180	\N	\N
1206	268	1439510504	1439512304	1	192.168.0.7	2	1439511439	\N	\N
1209	290	1439512052	1439513852	1	192.168.0.7	1	1439512052	\N	\N
1210	262	1439512968	1439514768	1	192.168.0.7	1	1439512968	\N	\N
1201	286	1439507216	1439509016	0	192.168.0.7	1	1439507216	\N	\N
1211	291	1439512999	1439514799	1	192.168.0.7	1	1439512999	\N	\N
1219	250	1439516967	1439518767	1	192.168.0.7	1	1439516967	\N	\N
1222	295	1439519614	1439521414	1	192.168.0.7	1	1439519614	\N	\N
1237	217	1439560260	1439562060	0	192.168.0.7	1	1439560260	1439561798	192.168.0.7
1227	268	1439549676	1439551476	0	192.168.0.7	3	1439550100	1439550212	192.168.0.7
1178	274	1439491005	1439492805	0	172.16.22.33	2	1439492788	\N	\N
1184	274	1439492908	1439494708	1	172.16.22.33	1	1439492908	\N	\N
1183	239	1439492899	1439494699	0	172.16.10.22	1	1439492899	1439493156	172.16.10.22
1186	239	1439493168	1439494968	0	172.16.10.22	1	1439493168	1439493173	172.16.10.22
1182	277	1439492406	1439494206	0	192.168.0.7	2	1439492517	1439493196	192.168.0.7
1187	277	1439493230	1439495030	0	192.168.0.7	1	1439493230	1439493572	192.168.0.7
1188	255	1439493626	1439495426	1	192.168.0.7	1	1439493626	\N	\N
1185	278	1439493037	1439494837	0	192.168.0.7	1	1439493037	1439494559	192.168.0.7
1190	280	1439495087	1439496887	1	192.168.0.7	1	1439495087	\N	\N
1228	268	1439550228	1439552028	0	192.168.0.7	1	1439550228	1439550260	192.168.0.7
1191	281	1439496393	1439498193	1	172.16.10.13	1	1439496393	\N	\N
1189	279	1439494949	1439496749	0	192.168.0.7	2	1439495401	1439496696	192.168.0.7
1229	297	1439557464	1439559264	1	192.168.0.7	1	1439557464	\N	\N
1192	250	1439498414	1439500214	1	192.168.0.7	3	1439499076	\N	\N
1193	282	1439498941	1439500741	0	192.168.0.7	1	1439498941	1439499117	192.168.0.7
1194	266	1439500070	1439501870	1	192.168.0.7	1	1439500070	\N	\N
1197	285	1439504855	1439506655	1	192.168.0.7	1	1439504855	\N	\N
1231	290	1439557966	1439559766	1	192.168.0.7	1	1439557966	\N	\N
1232	295	1439558272	1439560072	1	192.168.0.7	1	1439558272	\N	\N
1233	299	1439558830	1439560630	0	172.16.0.2	1	1439558830	1439558854	172.16.0.2
1234	242	1439559106	1439560906	1	172.16.10.13	1	1439559106	\N	\N
1230	298	1439557854	1439559654	1	192.168.0.7	2	1439559373	\N	\N
1236	297	1439560100	1439561900	0	172.16.20.19	1	1439560100	1439560109	172.16.20.19
1208	289	1439511917	1439513717	0	192.168.0.7	1	1439511917	\N	\N
1195	283	1439503345	1439505145	0	192.168.0.7	1	1439503345	\N	\N
1198	283	1439505279	1439507079	0	192.168.0.7	1	1439505279	1439505331	192.168.0.7
1214	286	1439514924	1439516724	1	192.168.0.7	1	1439514924	\N	\N
1196	284	1439504459	1439506259	0	192.168.0.7	1	1439504459	\N	\N
1215	291	1439515110	1439516910	1	192.168.0.7	1	1439515110	\N	\N
1200	284	1439507030	1439508830	0	192.168.0.7	1	1439507030	1439507911	192.168.0.7
1212	292	1439514475	1439516275	0	192.168.0.7	1	1439514475	1439515917	192.168.0.7
1217	292	1439515957	1439517757	1	192.168.0.7	1	1439515957	\N	\N
1241	299	1439560662	1439562462	1	192.168.0.7	1	1439560662	\N	\N
1245	304	1439561822	1439563622	0	192.168.0.7	1	1439561822	1439562366	192.168.0.7
1242	208	1439561553	1439563353	1	192.168.0.7	1	1439561553	\N	\N
1221	294	1439518213	1439520013	0	192.168.0.7	2	1439519374	\N	\N
1223	294	1439520403	1439522203	0	192.168.0.7	1	1439520403	1439520455	192.168.0.7
1224	296	1439521343	1439523143	1	192.168.0.7	1	1439521343	\N	\N
1225	290	1439546353	1439548153	1	192.168.0.7	1	1439546353	\N	\N
1226	290	1439549556	1439551356	1	192.168.0.7	1	1439549556	\N	\N
1216	262	1439515695	1439517495	0	192.168.0.7	2	1439517133	\N	\N
1199	273	1439507004	1439508804	0	192.168.0.7	2	1439507626	\N	\N
1220	262	1439517643	1439519443	1	192.168.0.7	1	1439517643	\N	\N
1213	293	1439514574	1439516374	0	192.168.0.7	1	1439514574	\N	\N
1218	293	1439516442	1439518242	1	192.168.0.7	1	1439516442	\N	\N
1238	301	1439560304	1439562104	0	192.168.0.7	1	1439560304	1439561773	192.168.0.7
1243	303	1439561785	1439563585	1	192.168.0.7	1	1439561785	\N	\N
1244	217	1439561822	1439563622	0	192.168.0.7	1	1439561822	1439561834	192.168.0.7
1247	301	1439562386	1439564186	0	192.168.0.7	1	1439562386	1439562407	192.168.0.7
1248	301	1439562443	1439564243	0	192.168.0.7	1	1439562443	1439562453	192.168.0.7
1235	300	1439559840	1439561640	0	192.168.0.7	2	1439560849	\N	\N
1240	297	1439560523	1439562323	0	192.168.0.7	2	1439560814	\N	\N
1249	297	1439562475	1439564275	0	192.168.0.7	1	1439562475	1439562692	192.168.0.7
1250	305	1439562887	1439564687	1	192.168.0.7	1	1439562887	\N	\N
1239	302	1439560463	1439562263	0	192.168.0.7	1	1439560463	\N	\N
1252	302	1439563101	1439564901	1	192.168.0.7	1	1439563101	\N	\N
1254	307	1439563605	1439565405	1	192.168.0.7	1	1439563605	\N	\N
1251	306	1439562927	1439564727	0	192.168.0.7	1	1439562927	1439563885	192.168.0.7
1256	306	1439563928	1439565728	0	192.168.0.7	1	1439563928	1439563983	192.168.0.7
1246	300	1439562162	1439563962	0	192.168.0.7	2	1439563949	\N	\N
1257	309	1439564019	1439565819	0	192.168.0.7	2	1439565701	\N	\N
1253	295	1439563511	1439565311	0	192.168.0.7	1	1439563511	1439564839	192.168.0.7
1260	295	1439564844	1439566644	0	192.168.0.7	1	1439564844	1439564849	192.168.0.7
1261	310	1439564924	1439566724	1	192.168.0.7	1	1439564924	\N	\N
1259	306	1439564036	1439565836	0	192.168.0.7	2	1439564054	1439565284	192.168.0.7
1258	300	1439564032	1439565832	0	192.168.0.7	2	1439565011	1439565586	192.168.0.7
1264	23	1439566059	1439567859	0	172.16.31.24	1	1439566059	1439566143	172.16.31.24
1276	243	1439568251	1439570051	0	192.168.0.7	1	1439568251	1439568262	192.168.0.7
1277	243	1439568291	1439570091	0	192.168.0.7	1	1439568291	1439568312	192.168.0.7
1278	316	1439568359	1439570159	1	192.168.0.7	1	1439568359	\N	\N
1275	310	1439567484	1439569284	0	192.168.0.7	1	1439567484	1439568514	192.168.0.7
1281	318	1439568610	1439570410	1	192.168.0.7	1	1439568610	\N	\N
1263	312	1439565338	1439567138	0	192.168.0.7	1	1439565338	1439566349	192.168.0.7
1303	327	1439575280	1439577080	1	192.168.0.7	1	1439575280	\N	\N
1304	324	1439575322	1439577122	1	192.168.0.7	1	1439575322	\N	\N
1282	315	1439568894	1439570694	0	192.168.0.7	1	1439568894	1439569674	192.168.0.7
1283	308	1439569698	1439571498	0	192.168.0.7	1	1439569698	1439569781	192.168.0.7
1284	319	1439570168	1439571968	1	192.168.0.7	1	1439570168	\N	\N
1285	320	1439570183	1439571983	1	192.168.0.7	1	1439570183	\N	\N
1267	256	1439566329	1439568129	0	192.168.0.7	1	1439566329	1439566547	192.168.0.7
1269	313	1439566616	1439568416	1	192.168.0.7	1	1439566616	\N	\N
1270	314	1439566771	1439568571	1	172.16.31.34	1	1439566771	\N	\N
1305	316	1439576077	1439577877	1	192.168.0.7	2	1439576134	\N	\N
1255	308	1439563769	1439565569	0	192.168.0.7	1	1439563769	\N	\N
1271	315	1439566985	1439568785	1	192.168.0.7	1	1439566985	\N	\N
1307	299	1439576374	1439578174	1	192.168.0.7	1	1439576374	\N	\N
1302	325	1439575226	1439577026	0	192.168.0.7	1	1439575226	1439576430	192.168.0.7
1308	328	1439576482	1439578282	1	192.168.0.7	1	1439576482	\N	\N
1280	296	1439568514	1439570314	0	192.168.0.7	1	1439568514	\N	\N
1287	321	1439570388	1439572188	1	192.168.0.7	1	1439570388	\N	\N
1311	330	1439576992	1439578792	1	192.168.0.7	1	1439576992	\N	\N
1309	305	1439576651	1439578451	0	192.168.0.7	2	1439577348	\N	\N
1310	329	1439576782	1439578582	0	192.168.0.7	2	1439577252	1439577465	192.168.0.7
1312	329	1439577484	1439579284	1	192.168.0.7	1	1439577484	\N	\N
1318	305	1439579464	1439581264	0	192.168.0.7	1	1439579464	1439580448	192.168.0.7
1319	305	1439580527	1439582327	0	192.168.0.7	1	1439580527	1439580616	192.168.0.7
1286	232	1439570264	1439572064	0	192.168.0.7	1	1439570264	\N	\N
1293	232	1439572264	1439574064	1	192.168.0.7	1	1439572264	\N	\N
1294	290	1439572572	1439574372	0	192.168.0.7	1	1439572572	1439573021	192.168.0.7
1295	290	1439573040	1439574840	1	192.168.0.7	1	1439573040	\N	\N
1296	319	1439573249	1439575049	1	192.168.0.7	1	1439573249	\N	\N
1298	326	1439573410	1439575210	1	192.168.0.7	1	1439573410	\N	\N
1299	322	1439573567	1439575367	0	192.168.0.7	1	1439573567	1439574548	192.168.0.7
1262	311	1439565233	1439567033	0	192.168.0.7	1	1439565233	\N	\N
1272	311	1439567100	1439568900	1	192.168.0.7	1	1439567100	\N	\N
1279	317	1439568472	1439570272	0	192.168.0.7	5	1439569404	\N	\N
1289	317	1439570837	1439572637	1	192.168.0.7	1	1439570837	\N	\N
1273	23	1439567366	1439569166	0	172.16.31.24	1	1439567366	1439567384	172.16.31.24
1266	11	1439566285	1439568085	0	172.16.20.25	2	1439567256	1439567408	172.16.20.25
1274	11	1439567415	1439569215	1	172.16.20.25	1	1439567415	\N	\N
1265	309	1439566139	1439567939	0	192.168.0.7	1	1439566139	1439567460	192.168.0.7
1268	243	1439566439	1439568239	0	192.168.0.7	1	1439566439	1439567995	192.168.0.7
1288	322	1439570736	1439572536	1	192.168.0.7	2	1439571055	\N	\N
1290	257	1439571195	1439572995	0	192.168.0.7	1	1439571195	1439571214	192.168.0.7
1300	299	1439574502	1439576302	0	192.168.0.7	1	1439574502	1439575032	192.168.0.7
1291	323	1439571301	1439573101	1	192.168.0.7	1	1439571301	\N	\N
1292	324	1439572013	1439573813	1	192.168.0.7	1	1439572013	\N	\N
1301	299	1439575090	1439576890	0	192.168.0.7	1	1439575090	1439575173	192.168.0.7
1306	307	1439576345	1439578145	0	192.168.0.7	1	1439576345	\N	\N
1327	280	1439582304	1439584104	1	192.168.0.7	1	1439582304	\N	\N
1314	331	1439578274	1439580074	1	192.168.0.7	1	1439578274	\N	\N
1313	307	1439578200	1439580000	0	192.168.0.7	2	1439578205	1439578656	192.168.0.7
1326	23	1439582287	1439584087	0	172.16.31.24	1	1439582287	1439582503	172.16.31.24
1297	325	1439573381	1439575181	0	192.168.0.7	2	1439574698	\N	\N
1320	335	1439580833	1439582633	1	192.168.0.7	1	1439580833	\N	\N
1316	333	1439578886	1439580686	1	192.168.0.7	1	1439578886	\N	\N
1317	334	1439579062	1439580862	1	192.168.0.7	1	1439579062	\N	\N
1325	336	1439582285	1439584085	1	192.168.0.7	1	1439582285	\N	\N
1324	319	1439582259	1439584059	0	192.168.0.7	1	1439582259	\N	\N
1315	332	1439578533	1439580333	0	192.168.0.7	1	1439578533	\N	\N
1328	332	1439582794	1439584594	0	192.168.0.7	1	1439582794	1439583116	192.168.0.7
1331	331	1439583711	1439585511	1	192.168.0.7	1	1439583711	\N	\N
1332	282	1439583741	1439585541	1	192.168.0.7	1	1439583741	\N	\N
1321	334	1439581312	1439583112	0	192.168.0.7	2	1439581920	\N	\N
1322	333	1439581985	1439583785	0	192.168.0.7	1	1439581985	\N	\N
1336	333	1439583908	1439585708	1	192.168.0.7	1	1439583908	\N	\N
1330	324	1439583579	1439585379	1	192.168.0.7	2	1439584882	\N	\N
1323	323	1439582063	1439583863	0	192.168.0.7	1	1439582063	\N	\N
1333	338	1439583742	1439585542	1	192.168.0.7	2	1439585041	\N	\N
1335	340	1439583872	1439585672	0	192.168.0.7	1	1439583872	\N	\N
1337	319	1439584243	1439586043	0	192.168.0.7	1	1439584243	1439584293	192.168.0.7
1338	319	1439584311	1439586111	0	192.168.0.7	1	1439584311	1439584429	192.168.0.7
1341	319	1439584442	1439586242	0	192.168.0.7	1	1439584442	1439584477	192.168.0.7
1395	326	1439771490	1439773290	1	192.168.0.7	1	1439771490	\N	\N
1334	339	1439583864	1439585664	0	192.168.0.7	1	1439583864	1439584696	192.168.0.7
1396	353	1439775920	1439777720	1	192.168.0.7	1	1439775920	\N	\N
1345	280	1439584844	1439586644	1	192.168.0.7	1	1439584844	\N	\N
1342	330	1439584623	1439586423	1	192.168.0.7	3	1439584869	\N	\N
1339	323	1439584316	1439586116	0	192.168.0.7	1	1439584316	1439585116	192.168.0.7
1397	355	1439776758	1439778558	0	192.168.0.7	2	1439777569	\N	\N
1369	346	1439596240	1439598040	0	192.168.0.7	3	1439597162	\N	\N
1370	303	1439596856	1439598656	0	192.168.0.7	1	1439596856	\N	\N
1373	303	1439600100	1439601900	1	192.168.0.7	1	1439600100	\N	\N
1344	302	1439584727	1439586527	0	192.168.0.7	1	1439584727	\N	\N
1349	302	1439586626	1439588426	1	192.168.0.7	1	1439586626	\N	\N
1351	282	1439587622	1439589422	1	192.168.0.7	1	1439587622	\N	\N
1350	330	1439587199	1439588999	0	192.168.0.7	1	1439587199	1439587649	192.168.0.7
1352	330	1439587723	1439589523	0	192.168.0.7	1	1439587723	1439587738	192.168.0.7
1354	343	1439588021	1439589821	1	192.168.0.7	1	1439588021	\N	\N
1353	340	1439587971	1439589771	0	192.168.0.7	1	1439587971	1439588045	192.168.0.7
1355	342	1439588600	1439590400	1	192.168.0.7	1	1439588600	\N	\N
1356	282	1439589492	1439591292	0	192.168.0.7	1	1439589492	1439589727	192.168.0.7
1358	343	1439590299	1439592099	1	192.168.0.7	1	1439590299	\N	\N
1357	320	1439589849	1439591649	0	192.168.0.7	1	1439589849	1439590522	192.168.0.7
1360	226	1439590905	1439592705	1	192.168.0.7	1	1439590905	\N	\N
1359	342	1439590725	1439592525	0	192.168.0.7	1	1439590725	1439591022	192.168.0.7
1361	342	1439591036	1439592836	0	192.168.0.7	1	1439591036	1439591048	192.168.0.7
1329	337	1439583265	1439585065	0	192.168.0.7	1	1439583265	\N	\N
1346	337	1439585386	1439587186	0	192.168.0.7	1	1439585386	1439585657	192.168.0.7
1347	341	1439585819	1439587619	1	192.168.0.7	1	1439585819	\N	\N
1343	339	1439584720	1439586520	0	192.168.0.7	3	1439585877	1439585974	192.168.0.7
1348	342	1439586103	1439587903	1	192.168.0.7	1	1439586103	\N	\N
1364	343	1439593993	1439595793	1	192.168.0.7	1	1439593993	\N	\N
1372	347	1439599549	1439601349	0	192.168.0.7	1	1439599549	1439600191	192.168.0.7
1374	348	1439602564	1439604364	0	192.168.0.7	1	1439602564	1439603706	192.168.0.7
1375	349	1439603800	1439605600	1	192.168.0.7	1	1439603800	\N	\N
1340	334	1439584328	1439586128	0	192.168.0.7	2	1439585069	\N	\N
1391	354	1439762975	1439764775	0	192.168.0.7	2	1439764327	\N	\N
1377	349	1439605626	1439607426	0	192.168.0.7	2	1439605915	1439605930	192.168.0.7
1376	226	1439605428	1439607228	0	192.168.0.7	1	1439605428	1439606628	192.168.0.7
1378	226	1439606694	1439608494	0	192.168.0.7	1	1439606694	1439606726	192.168.0.7
1379	226	1439606786	1439608586	0	192.168.0.7	1	1439606786	1439606820	192.168.0.7
1380	226	1439607001	1439608801	0	192.168.0.7	1	1439607001	1439607060	192.168.0.7
1382	351	1439609167	1439610967	1	192.168.0.7	1	1439609167	\N	\N
1381	350	1439608174	1439609974	0	192.168.0.7	1	1439608174	\N	\N
1362	344	1439593280	1439595080	0	192.168.0.7	1	1439593280	\N	\N
1366	344	1439595333	1439597133	1	192.168.0.7	1	1439595333	\N	\N
1367	326	1439595871	1439597671	1	192.168.0.7	1	1439595871	\N	\N
1363	345	1439593605	1439595405	0	192.168.0.7	1	1439593605	\N	\N
1368	345	1439595951	1439597751	1	192.168.0.7	1	1439595951	\N	\N
1384	350	1439610559	1439612359	1	192.168.0.7	2	1439610779	\N	\N
1365	303	1439594855	1439596655	0	192.168.0.7	1	1439594855	\N	\N
1371	347	1439596904	1439598704	1	192.168.0.7	1	1439596904	\N	\N
1385	353	1439612298	1439614098	1	192.168.0.7	1	1439612298	\N	\N
1386	267	1439656126	1439657926	1	192.168.0.7	1	1439656126	\N	\N
1387	292	1439666739	1439668539	0	192.168.0.7	1	1439666739	1439667226	192.168.0.7
1388	316	1439676692	1439678492	1	192.168.0.7	1	1439676692	\N	\N
1383	352	1439610453	1439612253	1	192.168.0.7	1	1439610453	\N	\N
1389	326	1439694660	1439696460	0	192.168.0.7	1	1439694660	\N	\N
1390	326	1439696721	1439698521	1	192.168.0.7	1	1439696721	\N	\N
1399	355	1439780648	1439782448	0	192.168.0.7	1	1439780648	1439780680	192.168.0.7
1398	353	1439779276	1439781076	0	192.168.0.7	1	1439779276	1439780935	192.168.0.7
1400	353	1439780990	1439782790	1	192.168.0.7	1	1439780990	\N	\N
1393	326	1439766988	1439768788	1	192.168.0.7	2	1439767087	\N	\N
1392	354	1439764956	1439766756	0	192.168.0.7	2	1439766024	\N	\N
1402	208	1439816976	1439818776	0	172.16.31.22	1	1439816976	1439817775	172.16.31.22
1394	354	1439768085	1439769885	1	192.168.0.7	2	1439768277	\N	\N
1408	358	1439821256	1439823056	0	192.168.0.7	1	1439821256	1439822456	192.168.0.7
1403	299	1439818161	1439819961	0	192.168.0.7	2	1439818162	1439818218	192.168.0.7
1401	356	1439816867	1439818667	0	192.168.0.7	2	1439817746	1439818300	192.168.0.7
1404	58	1439819840	1439821640	1	172.16.20.27	1	1439819840	\N	\N
1405	11	1439819945	1439821745	1	172.16.20.25	2	1439820602	\N	\N
1407	16	1439820864	1439822664	1	172.16.20.15	1	1439820864	\N	\N
1409	359	1439821817	1439823617	0	172.16.0.2	3	1439823449	\N	\N
1475	383	1440025583	1440027383	1	192.168.0.7	1	1440025583	\N	\N
1419	343	1439832999	1439834799	0	192.168.0.7	2	1439834360	\N	\N
1421	343	1439836196	1439837996	1	192.168.0.7	1	1439836196	\N	\N
1422	361	1439836968	1439838768	1	192.168.0.7	1	1439836968	\N	\N
1424	19	1439837828	1439839628	0	172.16.20.14	1	1439837828	1439837847	172.16.20.14
1439	366	1439906100	1439907900	0	192.168.0.7	1	1439906100	\N	\N
1443	366	1439908335	1439910135	1	192.168.0.7	1	1439908335	\N	\N
1442	367	1439907910	1439909710	0	172.16.17.15	1	1439907910	1439908938	172.16.17.15
1423	338	1439837249	1439839049	0	192.168.0.7	2	1439839013	\N	\N
1426	338	1439839949	1439841749	0	192.168.0.7	1	1439839949	1439840104	192.168.0.7
1427	338	1439840344	1439842144	0	192.168.0.7	1	1439840344	1439840349	192.168.0.7
1429	23	1439840415	1439842215	0	172.16.31.24	1	1439840415	1439840467	172.16.31.24
1441	365	1439907677	1439909477	0	192.168.0.7	1	1439907677	1439909155	192.168.0.7
1428	363	1439840394	1439842194	1	192.168.0.7	3	1439840613	\N	\N
1425	362	1439839822	1439841622	0	192.168.0.7	1	1439839822	1439840687	192.168.0.7
1430	338	1439841490	1439843290	0	192.168.0.7	1	1439841490	1439841496	192.168.0.7
1431	338	1439841504	1439843304	0	192.168.0.7	1	1439841504	1439841703	192.168.0.7
1432	26	1439843326	1439845126	1	172.16.31.11	1	1439843326	\N	\N
1444	332	1439909316	1439911116	0	192.168.0.7	1	1439909316	1439909367	192.168.0.7
1433	364	1439843453	1439845253	0	192.168.0.7	1	1439843453	\N	\N
1434	364	1439847038	1439848838	1	192.168.0.7	1	1439847038	\N	\N
1435	355	1439848178	1439849978	0	172.16.20.18	1	1439848178	1439848709	172.16.20.18
1436	353	1439862139	1439863939	1	192.168.0.7	1	1439862139	\N	\N
1440	17	1439906223	1439908023	0	172.16.20.15	1	1439906223	1439906801	172.16.20.15
1438	363	1439905804	1439907604	1	192.168.0.7	2	1439906931	\N	\N
1445	355	1439909525	1439911325	1	172.16.20.18	1	1439909525	\N	\N
1446	368	1439914841	1439916641	1	192.168.0.7	1	1439914841	\N	\N
1447	369	1439915228	1439917028	1	192.168.0.7	1	1439915228	\N	\N
1448	370	1439917466	1439919266	1	172.16.17.13	1	1439917466	\N	\N
1449	371	1439924830	1439926630	0	192.168.0.7	1	1439924830	1439925991	192.168.0.7
1406	357	1439820176	1439821976	0	192.168.0.7	2	1439820179	\N	\N
1410	357	1439823573	1439825373	1	192.168.0.7	1	1439823573	\N	\N
1450	363	1439926003	1439927803	0	192.168.0.7	1	1439926003	1439926168	192.168.0.7
1411	359	1439824732	1439826532	0	172.16.31.22	2	1439824828	1439824897	172.16.31.22
1413	23	1439825143	1439826943	0	172.16.31.24	1	1439825143	1439825685	172.16.31.24
1412	359	1439824907	1439826707	0	172.16.23.13	2	1439825601	1439826001	172.16.23.13
1451	363	1439926184	1439927984	0	192.168.0.7	1	1439926184	1439926213	192.168.0.7
1414	359	1439826030	1439827830	0	172.16.23.13	2	1439826070	1439826179	172.16.23.13
1415	359	1439826201	1439828001	0	172.16.23.13	1	1439826201	1439826228	172.16.23.13
1416	359	1439826425	1439828225	1	172.16.23.13	1	1439826425	\N	\N
1417	360	1439827816	1439829616	1	192.168.0.7	1	1439827816	\N	\N
1418	353	1439832515	1439834315	1	192.168.0.7	1	1439832515	\N	\N
1420	23	1439833883	1439835683	0	172.16.31.24	1	1439833883	1439834012	172.16.31.24
1476	384	1440075995	1440077795	0	172.16.16.12	1	1440075995	1440077276	172.16.16.12
1477	4	1440082089	1440083889	0	172.16.20.19	1	1440082089	1440082218	172.16.20.19
1464	379	1440008544	1440010344	0	192.168.0.7	2	1440009835	\N	\N
1465	379	1440010475	1440012275	1	192.168.0.7	2	1440012139	\N	\N
1454	373	1439983538	1439985338	0	192.168.0.7	2	1439984067	\N	\N
1455	373	1439985611	1439987411	1	192.168.0.7	1	1439985611	\N	\N
1456	374	1439986941	1439988741	1	192.168.0.7	1	1439986941	\N	\N
1457	375	1440001621	1440003421	1	172.16.31.12	1	1440001621	\N	\N
1437	365	1439905664	1439907464	0	192.168.0.7	1	1439905664	\N	\N
1459	377	1440001981	1440003781	1	172.16.31.13	1	1440001981	\N	\N
1461	28	1440007415	1440009215	0	172.16.31.14	1	1440007415	1440007524	172.16.31.14
1462	28	1440007964	1440009764	1	172.16.31.14	1	1440007964	\N	\N
1466	181	1440013072	1440014872	1	172.16.31.43	1	1440013072	\N	\N
1452	372	1439943744	1439945544	0	192.168.0.7	2	1439944806	\N	\N
1453	372	1439945713	1439947513	1	192.168.0.7	1	1439945713	\N	\N
1463	378	1440008371	1440010171	1	172.16.0.2	1	1440008371	\N	\N
1460	368	1440007320	1440009120	0	192.168.0.7	2	1440008201	1440008517	192.168.0.7
1467	379	1440013800	1440015600	0	192.168.0.7	2	1440014362	1440014389	192.168.0.7
1468	375	1440014470	1440016270	1	172.16.31.12	1	1440014470	\N	\N
1469	380	1440014491	1440016291	0	192.168.0.7	1	1440014491	1440015318	192.168.0.7
1471	382	1440016357	1440018157	0	172.16.31.10	2	1440018091	\N	\N
1470	381	1440016156	1440017956	1	192.168.0.7	1	1440016156	\N	\N
1472	382	1440018462	1440020262	1	172.16.31.10	1	1440018462	\N	\N
1473	58	1440020947	1440022747	0	172.16.0.2	1	1440020947	1440020957	172.16.0.2
1474	58	1440020966	1440022766	1	172.16.0.2	1	1440020966	\N	\N
1479	373	1440083467	1440085267	0	192.168.0.7	1	1440083467	1440083497	192.168.0.7
1478	365	1440082269	1440084069	0	172.16.20.19	2	1440083625	1440083651	172.16.20.19
1480	4	1440083739	1440085539	0	172.16.20.19	1	1440083739	1440083760	172.16.20.19
1481	365	1440083773	1440085573	0	172.16.20.19	1	1440083773	1440083815	172.16.20.19
1482	383	1440111043	1440112843	1	192.168.0.7	2	1440112527	\N	\N
1483	385	1440112957	1440114757	1	172.16.16.12	1	1440112957	\N	\N
1484	386	1440173218	1440175018	0	192.168.0.7	2	1440174441	\N	\N
1485	386	1440175632	1440177432	1	192.168.0.7	1	1440175632	\N	\N
1486	66	1440182690	1440184490	1	172.16.17.16	1	1440182690	\N	\N
1487	387	1440184477	1440186277	1	192.168.0.7	1	1440184477	\N	\N
1458	376	1440001854	1440003654	0	172.16.0.2	1	1440001854	\N	\N
1488	387	1440186698	1440188498	1	192.168.0.7	2	1440187530	\N	\N
1489	24	1440187341	1440189141	0	172.16.31.15	1	1440187341	1440187549	172.16.31.15
1490	24	1440187568	1440189368	0	172.16.31.15	1	1440187568	1440187591	172.16.31.15
1491	24	1440187604	1440189404	1	172.16.31.15	1	1440187604	\N	\N
1522	402	1441120787	1441122587	0	192.168.0.7	1	1441120787	1441121921	192.168.0.7
1540	407	1441376748	1441378548	1	192.168.0.7	1	1441376748	\N	\N
1507	392	1441037192	1441038992	0	172.16.31.41	1	1441037192	\N	\N
1523	37	1441121167	1441122967	0	172.16.30.30	2	1441121918	1441122615	172.16.30.30
1541	407	1441378596	1441380396	0	192.168.0.7	1	1441378596	1441379161	192.168.0.7
1526	37	1441122632	1441124432	0	172.16.30.30	1	1441122632	1441122687	172.16.30.30
1509	394	1441037945	1441039745	0	172.16.11.28	2	1441038958	\N	\N
1510	394	1441040041	1441041841	0	172.16.11.28	1	1441040041	1441040103	172.16.11.28
1511	395	1441051220	1441053020	0	172.16.28.13	1	1441051220	1441051965	172.16.28.13
1512	396	1441112858	1441114658	1	172.16.31.31	1	1441112858	\N	\N
1542	407	1441379186	1441380986	0	192.168.0.7	1	1441379186	1441379196	192.168.0.7
1521	40	1441120130	1441121930	0	172.16.30.36	4	1441121704	\N	\N
1527	40	1441123228	1441125028	1	172.16.30.36	1	1441123228	\N	\N
1525	389	1441122494	1441124294	0	192.168.0.7	1	1441122494	1441123417	192.168.0.7
1524	403	1441122029	1441123829	0	192.168.0.7	2	1441122684	1441123800	192.168.0.7
1528	122	1441123850	1441125650	0	192.168.0.7	1	1441123850	1441124521	192.168.0.7
1529	215	1441130847	1441132647	0	172.16.22.34	2	1441131190	1441132105	172.16.22.34
1492	387	1440189275	1440191075	0	192.168.0.7	3	1440190324	\N	\N
1513	397	1441113189	1441114989	0	172.16.30.34	1	1441113189	\N	\N
1493	387	1440192453	1440194253	1	192.168.0.7	3	1440193806	\N	\N
1494	386	1440418077	1440419877	1	192.168.0.7	1	1440418077	\N	\N
1495	386	1440426570	1440428370	1	192.168.0.7	1	1440426570	\N	\N
1496	388	1440529515	1440531315	0	172.16.11.14	1	1440529515	1440530877	172.16.11.14
1497	388	1440530906	1440532706	1	172.16.11.14	1	1440530906	\N	\N
1498	161	1440531841	1440533641	0	172.16.31.35	1	1440531841	1440532874	172.16.31.35
1499	389	1440555694	1440557494	1	192.168.0.7	1	1440555694	\N	\N
1500	58	1440612647	1440614447	1	172.16.20.27	1	1440612647	\N	\N
1501	58	1440617517	1440619317	1	172.16.20.27	1	1440617517	\N	\N
1502	255	1440688283	1440690083	1	192.168.0.7	2	1440688328	\N	\N
1503	161	1440769515	1440771315	0	172.16.31.35	1	1440769515	1440770249	172.16.31.35
1504	161	1440770269	1440772069	0	172.16.31.35	1	1440770269	1440770278	172.16.31.35
1505	390	1440880794	1440882594	1	172.16.11.22	1	1440880794	\N	\N
1506	391	1440881047	1440882847	1	172.16.11.13	1	1440881047	\N	\N
1508	393	1441037313	1441039113	0	172.16.11.28	1	1441037313	1441037901	172.16.11.28
1514	397	1441115105	1441116905	0	172.16.30.34	1	1441115105	1441115817	172.16.30.34
1515	397	1441115821	1441117621	0	172.16.30.34	1	1441115821	1441115827	172.16.30.34
1516	397	1441115831	1441117631	1	172.16.30.34	1	1441115831	\N	\N
1517	398	1441116031	1441117831	1	172.16.0.2	1	1441116031	\N	\N
1530	206	1441207506	1441209306	1	172.16.22.31	1	1441207506	\N	\N
1531	389	1441209666	1441211466	0	192.168.0.7	1	1441209666	1441209676	192.168.0.7
1543	164	1441630934	1441632734	1	172.16.30.62	2	1441631031	\N	\N
1544	408	1441637567	1441639367	1	172.16.30.62	1	1441637567	\N	\N
1518	399	1441117034	1441118834	0	172.16.30.30	1	1441117034	\N	\N
1546	139	1441639088	1441640888	0	172.16.31.39	1	1441639088	1441639806	172.16.31.39
1519	400	1441118760	1441120560	0	172.16.22.19	2	1441119726	1441119901	172.16.22.19
1520	401	1441119143	1441120943	0	172.16.30.33	1	1441119143	1441120143	172.16.30.33
1547	139	1441639850	1441641650	1	172.16.31.39	1	1441639850	\N	\N
1548	410	1441641207	1441643007	0	172.16.22.33	1	1441641207	\N	\N
1545	409	1441637979	1441639779	0	172.16.22.33	1	1441637979	\N	\N
1532	404	1441213901	1441215701	0	172.16.14.53	1	1441213901	\N	\N
1533	404	1441216288	1441218088	0	172.16.14.53	1	1441216288	1441216336	172.16.14.53
1534	404	1441216354	1441218154	0	172.16.14.53	1	1441216354	1441216364	172.16.14.53
1535	403	1441217049	1441218849	0	192.168.0.7	1	1441217049	1441217058	192.168.0.7
1536	164	1441217120	1441218920	0	172.16.30.62	1	1441217120	1441217695	172.16.30.62
1537	405	1441293830	1441295630	1	172.16.0.2	1	1441293830	\N	\N
1549	106	1441649135	1441650935	1	172.16.30.62	1	1441649135	\N	\N
1538	406	1441295567	1441297367	0	192.168.0.7	2	1441296432	1441297207	192.168.0.7
1539	389	1441298573	1441300373	0	192.168.0.7	1	1441298573	1441298606	192.168.0.7
1550	411	1441738632	1441740432	1	172.16.30.62	2	1441739374	\N	\N
1557	21	1442586124	1442587924	0	172.16.31.44	1	1442586124	1442586133	172.16.31.44
1551	412	1441896629	1441898429	0	192.168.0.7	1	1441896629	\N	\N
1552	412	1441899295	1441901095	1	192.168.0.7	1	1441899295	\N	\N
1553	376	1442236304	1442238104	1	172.16.0.2	1	1442236304	\N	\N
1554	385	1442237416	1442239216	1	172.16.0.2	1	1442237416	\N	\N
1555	23	1442583677	1442585477	1	172.16.31.24	1	1442583677	\N	\N
1556	21	1442585919	1442587719	0	172.16.31.44	1	1442585919	1442586098	172.16.31.44
1558	413	1442590968	1442592768	0	172.16.16.14	1	1442590968	\N	\N
1559	413	1442592848	1442594648	0	172.16.16.14	1	1442592848	\N	\N
1560	413	1442595592	1442597392	1	172.16.16.14	1	1442595592	\N	\N
1561	413	1442599234	1442601034	1	172.16.16.14	1	1442599234	\N	\N
1562	23	1442601353	1442603153	1	172.16.31.24	1	1442601353	\N	\N
1563	413	1442610601	1442612401	1	172.16.16.14	1	1442610601	\N	\N
1564	161	1442840593	1442842393	0	172.16.31.35	1	1442840593	1442840665	172.16.31.35
1565	161	1442840681	1442842481	0	172.16.31.35	1	1442840681	1442840735	172.16.31.35
1566	161	1442841024	1442842824	0	172.16.31.35	1	1442841024	1442841197	172.16.31.35
1567	164	1442841950	1442843750	1	172.16.30.62	1	1442841950	\N	\N
1568	23	1442859173	1442860973	0	172.16.31.24	1	1442859173	1442859410	172.16.31.24
1569	392	1442862936	1442864736	0	172.16.31.41	2	1442863035	1442863065	172.16.31.41
1570	392	1442863096	1442864896	0	172.16.31.41	1	1442863096	1442863187	172.16.31.41
1571	392	1442863204	1442865004	1	172.16.31.41	1	1442863204	\N	\N
1572	11	1443540379	1443542179	0	172.16.23.11	1	1443540379	1443540382	172.16.23.11
1573	9	1443541078	1443542878	0	172.16.23.11	1	1443541078	1443541082	172.16.23.11
1574	1	1443541373	1443543173	0	172.16.23.11	1	1443541373	1443541687	172.16.23.11
1575	383	1443542011	1443543811	1	172.16.31.46	1	1443542011	\N	\N
1576	1	1443542290	1443544090	0	172.16.23.11	1	1443542290	1443542463	172.16.23.11
1577	414	1443557173	1443558973	1	192.168.0.7	1	1443557173	\N	\N
1578	414	1443559846	1443561646	0	192.168.0.7	1	1443559846	1443561573	192.168.0.7
1579	23	1443630059	1443631859	1	172.16.31.24	1	1443630059	\N	\N
1580	415	1443633458	1443635258	0	172.16.20.31	1	1443633458	1443634433	172.16.20.31
1581	10	1443634478	1443636278	0	172.16.20.19	1	1443634478	1443634484	172.16.20.19
1582	9	1443634499	1443636299	0	172.16.20.19	1	1443634499	1443634503	172.16.20.19
1583	383	1443657798	1443659598	1	192.168.0.7	1	1443657798	\N	\N
1584	9	1443662736	1443664536	0	192.168.0.7	1	1443662736	1443662782	192.168.0.7
1585	181	1443707851	1443709651	1	172.16.31.42	1	1443707851	\N	\N
1586	9	1443708282	1443710082	1	::1	1	1443708282	\N	\N
1587	9	1443710776	1443712576	0	::1	1	1443710776	1443710788	::1
1588	9	1443710840	1443712640	0	::1	1	1443710840	1443710844	::1
1589	416	1443711196	1443712996	1	172.16.16.13	1	1443711196	\N	\N
1590	383	1443796808	1443798608	1	192.168.0.7	2	1443797527	\N	\N
1591	23	1444155875	1444157675	0	172.16.23.11	1	1444155875	1444156053	172.16.23.11
1592	10	1444156068	1444157868	1	172.16.23.11	1	1444156068	\N	\N
1593	23	1444157523	1444159323	1	172.16.23.11	1	1444157523	\N	\N
1615	425	1444850576	1444852376	0	172.16.14.92	2	1444850832	1444851890	172.16.14.92
1617	425	1444851904	1444853704	1	172.16.14.92	1	1444851904	\N	\N
1597	203	1444331578	1444333378	1	172.16.11.15	1	1444331578	\N	\N
1596	23	1444331522	1444333322	0	172.16.31.24	3	1444331536	1444331783	172.16.31.24
1598	418	1444416448	1444418248	1	172.16.29.19	1	1444416448	\N	\N
1600	385	1444749846	1444751646	1	172.16.16.12	1	1444749846	\N	\N
1601	413	1444749891	1444751691	1	172.16.16.14	1	1444749891	\N	\N
1599	416	1444749813	1444751613	0	172.16.0.2	1	1444749813	1444750567	172.16.0.2
1602	419	1444752104	1444753904	1	172.16.14.92	1	1444752104	\N	\N
1603	205	1444752365	1444754165	1	172.16.0.2	1	1444752365	\N	\N
1604	420	1444752584	1444754384	1	172.16.0.2	1	1444752584	\N	\N
1606	164	1444752885	1444754685	0	172.16.30.61	1	1444752885	1444752901	172.16.30.61
1618	427	1444855163	1444856963	1	172.16.14.90	1	1444855163	\N	\N
1619	428	1444929097	1444930897	1	172.16.14.24	1	1444929097	\N	\N
1620	1	1444934011	1444935811	0	172.16.20.19	2	1444934832	1444935208	172.16.20.19
1621	1	1444936171	1444937971	0	172.16.20.19	1	1444936171	1444936301	172.16.20.19
1622	1	1444936310	1444938110	0	172.16.20.19	1	1444936310	1444936317	172.16.20.19
1623	1	1444938229	1444940029	1	172.16.20.19	1	1444938229	\N	\N
1624	11	1444998929	1445000729	0	172.16.20.25	1	1444998929	1444998939	172.16.20.25
1605	421	1444752809	1444754609	0	172.16.14.24	1	1444752809	\N	\N
1607	421	1444755127	1444756927	1	172.16.14.24	1	1444755127	\N	\N
1625	406	1445006977	1445008777	0	192.168.0.7	1	1445006977	1445007001	192.168.0.7
1608	111	1444757429	1444759229	0	172.16.28.51	1	1444757429	\N	\N
1626	408	1445023345	1445025145	0	172.16.30.62	1	1445023345	1445023381	172.16.30.62
1609	419	1444757505	1444759305	0	172.16.14.92	1	1444757505	\N	\N
1610	422	1444759666	1444761466	0	172.16.28.51	1	1444759666	1444760282	172.16.28.51
1612	423	1444760777	1444762577	1	172.16.30.62	1	1444760777	\N	\N
1611	419	1444760045	1444761845	1	172.16.14.92	2	1444761074	\N	\N
1613	159	1444761909	1444763709	0	172.16.14.24	1	1444761909	1444761938	172.16.14.24
1614	424	1444762942	1444764742	1	172.16.12.22	1	1444762942	\N	\N
1594	417	1444246079	1444247879	0	172.16.13.22	1	1444246079	\N	\N
1595	417	1444248088	1444249888	0	172.16.13.22	1	1444248088	1444248144	172.16.13.22
1627	408	1445023537	1445025337	0	172.16.30.62	1	1445023537	1445023617	172.16.30.62
1631	412	1445171810	1445173610	0	192.168.0.7	1	1445171810	1445171821	192.168.0.7
1616	426	1444850824	1444852624	1	172.16.28.51	2	1444851727	\N	\N
1628	408	1445023721	1445025521	1	172.16.30.62	1	1445023721	\N	\N
1629	58	1445028006	1445029806	1	172.16.20.27	1	1445028006	\N	\N
1630	429	1445093682	1445095482	0	192.168.0.7	1	1445093682	\N	\N
1633	431	1445354219	1445356019	1	172.16.31.21	1	1445354219	\N	\N
1638	433	1445444000	1445445800	0	172.16.14.24	1	1445444000	1445444042	172.16.14.24
1632	430	1445354086	1445355886	0	172.16.30.62	1	1445354086	\N	\N
1634	432	1445356635	1445358435	1	172.16.30.62	1	1445356635	\N	\N
1635	411	1445367229	1445369029	0	172.16.30.62	1	1445367229	1445367254	172.16.30.62
1636	135	1445369132	1445370932	1	172.16.30.62	1	1445369132	\N	\N
1637	433	1445442469	1445444269	0	172.16.14.24	2	1445443951	1445443981	172.16.14.24
1639	434	1445458517	1445460317	1	172.16.14.13	1	1445458517	\N	\N
1640	424	1445606706	1445608506	1	172.16.12.27	2	1445607078	\N	\N
1641	435	1445865294	1445867094	0	192.168.0.7	1	1445865294	1445866903	192.168.0.7
1642	435	1445866931	1445868731	0	192.168.0.7	1	1445866931	1445867481	192.168.0.7
1643	435	1445867524	1445869324	0	192.168.0.7	1	1445867524	1445867531	192.168.0.7
1644	423	1445869351	1445871151	1	172.16.30.62	1	1445869351	\N	\N
1645	75	1446043370	1446045170	1	172.16.30.13	1	1446043370	\N	\N
1646	87	1446043506	1446045306	1	172.16.30.10	1	1446043506	\N	\N
1647	23	1446062729	1446064529	0	172.16.31.24	1	1446062729	1446062786	172.16.31.24
1648	436	1446140825	1446142625	0	172.16.10.50	1	1446140825	1446142026	172.16.10.50
1649	1	1446235747	1446237547	0	172.16.23.11	1	1446235747	1446236241	172.16.23.11
1650	1	1446241023	1446242823	0	172.16.23.11	1	1446241023	1446241162	172.16.23.11
1651	9	1446241180	1446242980	1	172.16.23.11	1	1446241180	\N	\N
1652	434	1446487493	1446489293	1	172.16.30.62	1	1446487493	\N	\N
1653	1	1446568547	1446570347	1	172.16.23.11	2	1446569346	\N	\N
1654	135	1446570086	1446571886	1	172.16.30.62	1	1446570086	\N	\N
1655	1	1446581615	1446583415	0	172.16.20.19	1	1446581615	1446581956	172.16.20.19
1678	437	1446650960	1446652760	0	172.16.20.28	2	1446652608	\N	\N
1711	355	1446747530	1446749330	0	172.16.20.25	1	1446747530	1446747545	172.16.20.25
1679	437	1446653464	1446655264	0	172.16.20.28	2	1446654098	1446654122	172.16.20.28
1681	437	1446654132	1446655932	0	172.16.20.28	1	1446654132	1446654625	172.16.20.28
1682	437	1446654630	1446656430	0	172.16.20.28	1	1446654630	1446654668	172.16.20.28
1657	1	1446587492	1446589292	0	172.16.20.19	1	1446587492	1446587739	172.16.20.19
1680	355	1446654104	1446655904	1	172.16.20.25	2	1446655505	\N	\N
1658	1	1446587756	1446589556	0	172.16.20.19	2	1446588329	1446588380	172.16.20.19
1659	10	1446588389	1446590189	0	172.16.20.19	1	1446588389	1446588441	172.16.20.19
1660	1	1446588481	1446590281	0	172.16.20.19	1	1446588481	1446588545	172.16.20.19
1661	437	1446588557	1446590357	0	172.16.20.19	1	1446588557	1446588647	172.16.20.19
1683	437	1446654677	1446656477	0	172.16.20.21	2	1446654778	\N	\N
1670	355	1446645391	1446647191	1	172.16.20.25	4	1446646425	\N	\N
1673	1	1446646444	1446648244	1	172.16.20.19	1	1446646444	\N	\N
1656	1	1446585673	1446587473	0	172.16.20.25	3	1446587437	\N	\N
1684	437	1446657669	1446659469	1	172.16.20.25	2	1446658576	\N	\N
1685	438	1446660594	1446662394	1	172.16.14.92	1	1446660594	\N	\N
1663	355	1446588736	1446590536	0	172.16.20.25	2	1446588870	1446588907	172.16.20.25
1686	437	1446668588	1446670388	1	172.16.20.21	3	1446668659	\N	\N
1687	355	1446668767	1446670567	0	172.16.20.21	1	1446668767	1446668820	172.16.20.21
1672	437	1446646325	1446648125	0	172.16.20.28	4	1446647753	\N	\N
1688	355	1446668828	1446670628	0	172.16.20.21	1	1446668828	1446668835	172.16.20.21
1675	437	1446648370	1446650170	0	172.16.20.28	1	1446648370	1446648432	172.16.20.28
1662	437	1446588656	1446590456	0	172.16.20.25	3	1446588757	1446588840	172.16.20.25
1666	10	1446589175	1446590975	1	172.16.20.19	1	1446589175	\N	\N
1664	437	1446588974	1446590774	1	172.16.20.28	2	1446590107	\N	\N
1667	1	1446590133	1446591933	1	172.16.20.19	1	1446590133	\N	\N
1665	355	1446588975	1446590775	0	172.16.20.25	2	1446590112	1446590157	172.16.20.25
1668	355	1446590166	1446591966	1	172.16.20.25	1	1446590166	\N	\N
1674	355	1446647783	1446649583	1	172.16.20.25	3	1446648498	\N	\N
1671	10	1446645399	1446647199	1	172.16.20.19	2	1446645951	\N	\N
1689	10	1446668845	1446670645	0	172.16.20.21	1	1446668845	1446668869	172.16.20.21
1712	437	1446747803	1446749603	0	172.16.20.21	1	1446747803	1446748557	172.16.20.21
1676	437	1446648443	1446650243	0	172.16.20.28	2	1446648558	1446648950	172.16.20.28
1710	1	1446747434	1446749234	0	172.16.20.19	2	1446748203	1446748699	172.16.20.19
1669	437	1446645387	1446647187	0	172.16.20.21	2	1446646087	1446646153	172.16.20.28
1703	355	1446738635	1446740435	0	::1	4	1446739143	1446739745	172.16.20.28
1694	437	1446680879	1446682679	0	172.16.20.21	3	1446682480	\N	\N
1695	437	1446682772	1446684572	1	172.16.20.21	1	1446682772	\N	\N
1690	355	1446668880	1446670680	0	172.16.20.21	1	1446668880	\N	\N
1677	437	1446648954	1446650754	0	172.16.20.28	1	1446648954	\N	\N
1691	437	1446671349	1446673149	1	172.16.20.21	1	1446671349	\N	\N
1696	437	1446691882	1446693682	0	192.168.0.7	1	1446691882	1446693587	192.168.0.7
1697	355	1446693602	1446695402	0	192.168.0.7	1	1446693602	1446693619	192.168.0.7
1692	437	1446673979	1446675779	0	172.16.20.21	2	1446674057	\N	\N
1693	437	1446677227	1446679027	0	172.16.20.21	1	1446677227	\N	\N
1704	437	1446739417	1446741217	0	::1	2	1446739034	1446739591	172.16.20.28
1708	133	1446746735	1446748535	0	172.16.14.92	1	1446746735	1446747023	172.16.14.92
1700	437	1446736428	1446738228	0	172.16.20.21	5	1446737454	1446737472	172.16.20.28
1698	437	1446693631	1446695431	0	192.168.0.7	1	1446693631	\N	\N
1699	437	1446695672	1446697472	1	192.168.0.7	2	1446696595	\N	\N
1701	355	1446736528	1446738328	0	172.16.20.25	2	1446737139	1446737475	172.16.20.25
1705	437	1446739109	1446740909	0	::1	1	1446739109	1446739130	::1
1706	437	1446739750	1446741550	0	172.16.20.28	1	1446739750	1446739755	172.16.20.28
1702	437	1446737195	1446738995	0	::1	3	1446738440	\N	\N
1707	437	1446739762	1446741562	1	172.16.20.28	1	1446739762	\N	\N
1709	355	1446747365	1446749165	0	172.16.20.25	1	1446747365	1446747476	172.16.20.25
1713	23	1446748918	1446750718	0	172.16.20.25	1	1446748918	1446748954	172.16.20.25
1714	21	1446748967	1446750767	0	172.16.20.25	1	1446748967	1446748981	172.16.20.25
1715	24	1446749003	1446750803	0	172.16.20.25	1	1446749003	1446749021	172.16.20.25
1717	437	1446749089	1446750889	0	172.16.20.19	1	1446749089	1446749192	172.16.20.19
1716	431	1446749034	1446750834	0	172.16.20.25	1	1446749034	1446749211	172.16.20.25
1719	21	1446749363	1446751163	0	172.16.20.19	1	1446749363	1446749371	172.16.20.19
1720	1	1446749379	1446751179	0	172.16.20.19	1	1446749379	1446749428	172.16.20.19
1721	437	1446749436	1446751236	0	172.16.20.19	1	1446749436	1446749476	172.16.20.19
1722	431	1446749503	1446751303	0	172.16.20.19	1	1446749503	1446749525	172.16.20.19
1718	21	1446749202	1446751002	0	172.16.20.25	2	1446749226	1446749347	172.16.20.19
1723	1	1446749537	1446751337	0	172.16.20.19	1	1446749537	1446750015	172.16.20.19
1724	431	1446749569	1446751369	0	172.16.20.25	1	1446749569	1446749682	172.16.20.25
1725	431	1446749702	1446751502	0	172.16.20.25	2	1446749804	1446749815	172.16.20.25
1726	431	1446749829	1446751629	0	172.16.20.25	1	1446749829	1446749873	172.16.20.25
1727	431	1446749886	1446751686	0	172.16.20.25	1	1446749886	1446749907	172.16.20.25
1728	431	1446749914	1446751714	1	172.16.20.25	1	1446749914	\N	\N
1729	437	1446750030	1446751830	0	172.16.20.19	1	1446750030	1446750054	172.16.20.19
1731	11	1446750434	1446752234	0	172.16.20.25	1	1446750434	1446750471	172.16.20.25
1732	437	1446750578	1446752378	1	172.16.20.28	1	1446750578	\N	\N
1730	1	1446750140	1446751940	1	172.16.20.19	2	1446751570	\N	\N
1733	355	1446826789	1446828589	0	172.16.20.25	1	1446826789	1446827227	172.16.20.25
1734	1	1446827241	1446829041	1	172.16.20.25	1	1446827241	\N	\N
1735	1	1446833592	1446835392	1	172.16.20.25	1	1446833592	\N	\N
1737	23	1446836136	1446837936	1	172.16.20.21	1	1446836136	\N	\N
1736	1	1446835463	1446837263	1	172.16.20.21	2	1446836172	\N	\N
1738	23	1446843557	1446845357	0	172.16.20.21	1	1446843557	1446843565	172.16.20.21
1741	437	1446846013	1446847813	0	172.16.20.21	1	1446846013	1446846202	172.16.20.21
1761	11	1447096942	1447098742	0	172.16.20.25	1	1447096942	1447096982	172.16.20.25
1739	23	1446844950	1446846750	0	172.16.20.21	2	1446846225	1446846300	172.16.20.21
1742	23	1446846333	1446848133	0	172.16.20.21	1	1446846333	1446846467	172.16.20.21
1764	68	1447097107	1447098907	1	172.16.19.17	1	1447097107	\N	\N
1740	1	1446845959	1446847759	0	172.16.20.21	1	1446845959	1446846970	172.16.20.21
1743	23	1446846478	1446848278	0	172.16.31.24	2	1446846722	1446846881	172.16.31.24
1744	1	1447076870	1447078670	1	172.16.20.21	1	1447076870	\N	\N
1745	23	1447079581	1447081381	0	172.16.20.21	1	1447079581	1447079658	172.16.20.21
1746	23	1447084518	1447086318	0	172.16.31.24	1	1447084518	1447084653	172.16.31.24
1747	11	1447084725	1447086525	0	172.16.31.24	1	1447084725	1447084736	172.16.31.24
1748	23	1447084750	1447086550	0	172.16.31.24	1	1447084750	1447085009	172.16.31.24
1749	11	1447085015	1447086815	0	172.16.31.24	1	1447085015	1447085023	172.16.31.24
1750	23	1447085033	1447086833	0	172.16.31.24	1	1447085033	1447085081	172.16.31.24
1751	11	1447085087	1447086887	0	172.16.31.24	1	1447085087	1447085240	172.16.31.24
1752	11	1447085248	1447087048	0	172.16.31.24	1	1447085248	1447085443	172.16.31.24
1753	11	1447085450	1447087250	0	172.16.31.24	1	1447085450	1447086322	172.16.31.24
1754	11	1447086405	1447088205	0	172.16.31.24	1	1447086405	1447086443	172.16.31.24
1755	23	1447086467	1447088267	0	172.16.31.24	1	1447086467	1447086608	172.16.31.24
1756	11	1447086618	1447088418	0	172.16.31.24	1	1447086618	1447087449	172.16.31.24
1757	1	1447095324	1447097124	0	172.16.20.25	1	1447095324	1447095344	172.16.20.25
1758	1	1447095372	1447097172	0	172.16.20.25	1	1447095372	1447095401	172.16.20.25
1760	11	1447096811	1447098611	0	172.16.20.25	1	1447096811	1447096912	172.16.20.25
1765	1	1447097737	1447099537	0	172.16.20.25	1	1447097737	1447097756	172.16.20.25
1759	1	1447095670	1447097470	0	172.16.20.25	2	1447096918	1447096939	172.16.20.25
1781	11	1447161444	1447163244	1	172.16.20.25	1	1447161444	\N	\N
1788	11	1447181306	1447183106	1	172.16.31.24	1	1447181306	\N	\N
1780	87	1447161251	1447163051	0	172.16.20.25	2	1447162747	1447162760	172.16.20.25
1766	11	1447097920	1447099720	0	172.16.0.2	1	1447097920	\N	\N
1768	114	1447100071	1447101871	0	172.16.18.16	1	1447100071	1447100267	172.16.18.16
1762	11	1447096990	1447098790	0	172.16.20.25	3	1447097761	1447097772	172.16.20.25
1769	437	1447100256	1447102056	0	172.16.20.21	1	1447100256	1447100457	172.16.20.21
1763	114	1447097079	1447098879	0	172.16.18.16	2	1447098316	\N	\N
1767	114	1447098994	1447100794	0	172.16.18.16	1	1447098994	1447099059	172.16.18.16
1770	1	1447100503	1447102303	0	172.16.20.21	1	1447100503	1447100553	172.16.20.21
1771	23	1447100564	1447102364	0	172.16.20.21	1	1447100564	1447100581	172.16.20.21
1772	23	1447100611	1447102411	0	172.16.31.24	1	1447100611	1447100853	172.16.31.24
1774	397	1447102185	1447103985	0	172.16.31.24	1	1447102185	1447102220	172.16.31.24
1775	401	1447102261	1447104061	1	172.16.30.33	1	1447102261	\N	\N
1783	68	1447163027	1447164827	1	172.16.19.17	1	1447163027	\N	\N
1776	37	1447102408	1447104208	1	172.16.30.33	1	1447102408	\N	\N
1773	23	1447102165	1447103965	0	172.16.31.24	2	1447102367	1447102478	172.16.31.24
1777	11	1447102506	1447104306	0	172.16.31.24	1	1447102506	1447103018	172.16.31.24
1778	397	1447103544	1447105344	1	172.16.30.34	1	1447103544	\N	\N
1779	437	1447103635	1447105435	0	172.16.20.21	1	1447103635	1447103698	172.16.20.21
1784	440	1447163535	1447165335	0	172.16.28.50	1	1447163535	1447163970	172.16.28.50
1782	87	1447162854	1447164654	0	172.16.30.10	1	1447162854	1447164187	172.16.30.10
1785	41	1447166787	1447168587	1	172.16.13.14	1	1447166787	\N	\N
1786	41	1447177745	1447179545	0	172.16.13.14	1	1447177745	1447177766	172.16.13.14
1787	437	1447181076	1447182876	0	172.16.20.28	1	1447181076	1447181078	172.16.20.28
1789	275	1447181865	1447183665	1	172.16.31.38	1	1447181865	\N	\N
1790	401	1447182000	1447183800	1	172.16.0.2	1	1447182000	\N	\N
1791	11	1447184355	1447186155	1	172.16.31.24	1	1447184355	\N	\N
1792	401	1447184649	1447186449	1	172.16.0.2	1	1447184649	\N	\N
1793	37	1447184723	1447186523	0	172.16.30.37	1	1447184723	1447184767	172.16.30.37
1795	397	1447187669	1447189469	1	172.16.30.34	1	1447187669	\N	\N
1794	275	1447186671	1447188471	0	172.16.31.38	2	1447187709	1447187755	172.16.31.38
1796	143	1447187780	1447189580	0	172.16.31.38	1	1447187780	1447187847	172.16.31.38
1797	275	1447187866	1447189666	1	172.16.31.38	1	1447187866	\N	\N
1798	449	1447188640	1447190440	0	172.16.13.16	1	1447188640	1447188721	172.16.13.16
1799	41	1447188787	1447190587	0	172.16.13.14	1	1447188787	1447188811	172.16.13.14
1800	11	1447189958	1447191758	0	172.16.20.25	1	1447189958	1447189978	172.16.20.25
1801	9	1447190010	1447191810	0	172.16.20.25	1	1447190010	1447190112	172.16.20.25
1802	22	1447190120	1447191920	1	172.16.20.25	1	1447190120	\N	\N
1803	9	1447220093	1447221893	0	192.168.0.7	1	1447220093	1447220140	192.168.0.7
1804	41	1447249647	1447251447	0	172.16.13.14	1	1447249647	1447250120	172.16.13.14
1805	54	1447250810	1447252610	0	172.16.31.24	1	1447250810	1447250823	172.16.31.24
1806	54	1447250869	1447252669	1	172.16.13.20	1	1447250869	\N	\N
1807	355	1447251273	1447253073	0	172.16.20.10	1	1447251273	1447251287	172.16.20.10
1808	11	1447265420	1447267220	1	172.16.20.25	1	1447265420	\N	\N
1809	225	1447274637	1447276437	0	172.16.11.17	1	1447274637	1447274798	172.16.11.17
1810	390	1447274819	1447276619	0	172.16.11.17	1	1447274819	1447274864	172.16.11.17
1811	440	1447275069	1447276869	0	172.16.14.28	1	1447275069	1447275336	172.16.14.28
1812	37	1447279797	1447281597	1	172.16.30.37	1	1447279797	\N	\N
1813	397	1447331093	1447332893	0	172.16.30.34	1	1447331093	1447331115	172.16.30.34
1814	401	1447331151	1447332951	1	172.16.30.34	1	1447331151	\N	\N
1815	401	1447344504	1447346304	1	172.16.0.2	1	1447344504	\N	\N
1816	143	1447350124	1447351924	1	172.16.31.33	1	1447350124	\N	\N
1817	397	1447350986	1447352786	0	172.16.30.34	1	1447350986	1447351014	172.16.30.34
1819	87	1447354843	1447356643	0	172.16.20.19	1	1447354843	1447354860	172.16.20.19
1820	37	1447355446	1447357246	0	172.16.20.19	1	1447355446	1447355656	172.16.20.19
1859	87	1447425130	1447426930	1	172.16.20.25	1	1447425130	\N	\N
1841	449	1447364399	1447366199	0	172.16.13.16	2	1447365553	1447365735	172.16.13.16
1830	397	1447358741	1447360541	0	172.16.20.19	1	1447358741	1447358756	172.16.20.19
1831	11	1447358811	1447360611	0	172.16.20.19	1	1447358811	1447358828	172.16.20.19
1832	11	1447358843	1447360643	0	172.16.20.19	1	1447358843	1447358854	172.16.20.19
1821	41	1447355537	1447357337	0	172.16.13.14	1	1447355537	1447356375	172.16.13.14
1822	397	1447355666	1447357466	0	172.16.20.19	2	1447356256	1447356411	172.16.20.19
1827	275	1447357390	1447359190	0	172.16.20.19	3	1447358649	1447358699	172.16.20.19
1823	11	1447356536	1447358336	0	172.16.20.19	1	1447356536	1447356591	172.16.20.19
1824	68	1447356595	1447358395	0	172.16.19.17	1	1447356595	1447356610	172.16.19.17
1842	449	1447365863	1447367663	0	172.16.20.19	1	1447365863	1447365998	172.16.20.19
1843	41	1447366005	1447367805	0	172.16.20.19	1	1447366005	1447366240	172.16.20.19
1844	449	1447366253	1447368053	0	172.16.20.19	1	1447366253	1447366502	172.16.20.19
1845	41	1447366511	1447368311	0	172.16.20.19	1	1447366511	1447366612	172.16.20.19
1833	275	1447358943	1447360743	0	172.16.31.38	2	1447359260	1447359451	172.16.20.19
1834	397	1447359490	1447361290	0	172.16.20.19	1	1447359490	\N	\N
1826	41	1447356994	1447358794	0	172.16.31.24	1	1447356994	1447357018	172.16.31.24
1835	143	1447362254	1447364054	0	172.16.20.19	2	1447362718	1447363093	172.16.20.19
1818	275	1447354019	1447355819	0	172.16.31.38	2	1447355749	\N	\N
1846	449	1447366624	1447368424	0	172.16.20.19	1	1447366624	1447366644	172.16.20.19
1828	68	1447358038	1447359838	0	172.16.20.19	1	1447358038	1447358232	172.16.20.19
1825	397	1447356631	1447358431	0	172.16.20.19	2	1447358244	1447358270	172.16.20.19
1829	143	1447358279	1447360079	0	172.16.20.19	1	1447358279	1447358640	172.16.20.19
1836	449	1447363114	1447364914	0	172.16.20.19	1	1447363114	1447363239	172.16.20.19
1837	155	1447363246	1447365046	0	172.16.20.19	1	1447363246	1447363503	172.16.20.19
1838	41	1447363514	1447365314	0	172.16.20.19	1	1447363514	1447363777	172.16.20.19
1839	449	1447363790	1447365590	0	172.16.20.19	1	1447363790	1447363800	172.16.20.19
1840	41	1447363824	1447365624	0	172.16.20.19	1	1447363824	1447364382	172.16.20.19
1847	449	1447366672	1447368472	0	172.16.20.19	1	1447366672	1447366700	172.16.20.19
1848	41	1447366708	1447368508	0	172.16.20.19	1	1447366708	1447366881	172.16.20.19
1849	449	1447366889	1447368689	1	172.16.20.19	1	1447366889	\N	\N
1850	41	1447420966	1447422766	0	172.16.13.14	3	1447422695	\N	\N
1857	143	1447423404	1447425204	0	172.16.31.33	2	1447424790	1447425181	172.16.31.33
1852	11	1447422527	1447424327	0	172.16.20.25	1	1447422527	1447422570	172.16.20.25
1853	87	1447422588	1447424388	0	172.16.20.25	1	1447422588	1447422593	172.16.20.25
1854	68	1447422672	1447424472	1	172.16.19.17	1	1447422672	\N	\N
1855	87	1447423188	1447424988	1	172.16.30.10	1	1447423188	\N	\N
1864	11	1447428154	1447429954	0	172.16.31.24	1	1447428154	1447428183	172.16.31.24
1851	449	1447421534	1447423334	0	172.16.13.16	2	1447422403	\N	\N
1858	449	1447424272	1447426072	0	172.16.13.16	1	1447424272	1447424630	172.16.13.16
1856	41	1447423275	1447425075	0	172.16.13.14	1	1447423275	\N	\N
1865	23	1447428194	1447429994	0	172.16.31.24	1	1447428194	1447428235	172.16.31.24
1861	11	1447425751	1447427551	0	172.16.31.24	1	1447425751	1447426057	172.16.31.24
1862	437	1447426171	1447427971	1	172.16.20.28	1	1447426171	\N	\N
1863	41	1447427403	1447429203	0	172.16.13.14	1	1447427403	1447428501	172.16.13.14
1860	41	1447425292	1447427092	0	172.16.13.14	1	1447425292	\N	\N
1868	404	1447429094	1447430894	1	192.168.0.7	1	1447429094	\N	\N
1867	41	1447428792	1447430592	0	172.16.13.14	1	1447428792	1447429515	172.16.13.14
1869	41	1447430694	1447432494	1	172.16.13.14	1	1447430694	\N	\N
1866	449	1447428693	1447430493	0	172.16.13.16	1	1447428693	\N	\N
1870	449	1447431029	1447432829	0	172.16.13.16	1	1447431029	1447431124	172.16.13.16
1871	397	1447431511	1447433311	0	172.16.30.34	1	1447431511	1447431558	172.16.30.34
1872	37	1447431584	1447433384	0	172.16.30.34	1	1447431584	1447431601	172.16.30.34
1873	397	1447431623	1447433423	0	172.16.30.34	1	1447431623	1447431649	172.16.30.34
1874	401	1447431663	1447433463	0	172.16.30.34	1	1447431663	1447431681	172.16.30.34
1875	397	1447431702	1447433502	0	172.16.30.34	1	1447431702	1447431729	172.16.30.34
1876	37	1447431742	1447433542	0	172.16.30.34	1	1447431742	1447431800	172.16.30.34
1877	397	1447431808	1447433608	1	172.16.30.34	1	1447431808	\N	\N
1878	37	1447431905	1447433705	1	172.16.30.37	1	1447431905	\N	\N
1879	404	1447432654	1447434454	0	172.16.14.53	1	1447432654	1447432679	172.16.14.53
1903	435	1447599197	1447600997	0	192.168.0.7	1	1447599197	1447599223	192.168.0.7
1880	41	1447432961	1447434761	0	172.16.20.19	2	1447433741	1447433857	172.16.20.19
1881	41	1447435641	1447437441	0	172.16.20.19	1	1447435641	1447436365	172.16.20.19
1882	437	1447436415	1447438215	0	172.16.20.19	1	1447436415	1447436445	172.16.20.19
1883	11	1447436461	1447438261	0	172.16.20.19	1	1447436461	1447436486	172.16.20.19
1884	437	1447436498	1447438298	0	172.16.20.19	1	1447436498	1447436562	172.16.20.19
1904	435	1447599235	1447601035	0	192.168.0.7	1	1447599235	1447599259	192.168.0.7
1905	457	1447610487	1447612287	0	192.168.0.7	1	1447610487	1447610562	192.168.0.7
1906	9	1447623025	1447624825	0	192.168.0.7	1	1447623025	1447623054	192.168.0.7
1885	41	1447436575	1447438375	0	172.16.13.14	3	1447437899	\N	\N
1907	404	1447678087	1447679887	0	172.16.14.53	1	1447678087	1447678227	172.16.14.53
1886	41	1447440060	1447441860	0	172.16.13.14	1	1447440060	\N	\N
1908	41	1447682032	1447683832	0	172.16.13.15	1	1447682032	1447682062	172.16.13.15
1888	401	1447441040	1447442840	0	172.16.0.2	2	1447442490	1447442751	172.16.0.2
1891	401	1447442761	1447444561	0	172.16.0.2	1	1447442761	1447442772	172.16.0.2
1892	68	1447442928	1447444728	1	172.16.19.17	1	1447442928	\N	\N
1887	404	1447440502	1447442302	0	172.16.20.19	2	1447441150	\N	\N
1893	11	1447443240	1447445040	0	172.16.20.19	1	1447443240	1447443412	172.16.20.19
1890	41	1447442426	1447444226	0	172.16.13.14	1	1447442426	1447443967	172.16.13.14
1889	449	1447442286	1447444086	0	172.16.13.16	1	1447442286	\N	\N
1895	449	1447444910	1447446710	0	172.16.13.16	1	1447444910	1447444940	172.16.13.16
1894	11	1447444106	1447445906	1	172.16.20.19	3	1447444964	\N	\N
1896	437	1447445745	1447447545	1	172.16.20.19	1	1447445745	\N	\N
1909	41	1447685075	1447686875	0	172.16.13.15	1	1447685075	1447685115	172.16.13.15
1898	11	1447447769	1447449569	0	172.16.31.24	1	1447447769	1447447856	172.16.31.24
1899	37	1447448611	1447450411	1	172.16.30.37	1	1447448611	\N	\N
1911	11	1447685768	1447687568	1	172.16.20.25	1	1447685768	\N	\N
1935	439	1447773181	1447774981	0	172.16.10.16	1	1447773181	1447773189	172.16.10.16
1936	439	1447775414	1447777214	1	172.16.10.16	1	1447775414	\N	\N
1912	41	1447686720	1447688520	0	172.16.20.21	1	1447686720	1447687276	172.16.20.21
1917	68	1447687944	1447689744	0	172.16.19.17	1	1447687944	\N	\N
1920	68	1447689842	1447691642	0	172.16.19.17	1	1447689842	1447690446	172.16.19.17
1900	397	1447449637	1447451437	0	172.16.30.34	1	1447449637	1447450074	172.16.30.34
1897	225	1447446736	1447448536	0	172.16.11.17	3	1447448439	\N	\N
1914	41	1447687290	1447689090	0	172.16.20.21	1	1447687290	1447687542	172.16.20.21
1901	225	1447450567	1447452367	0	172.16.20.18	2	1447451052	1447451265	172.16.20.18
1902	435	1447598952	1447600752	0	192.168.0.7	1	1447598952	1447599181	192.168.0.7
1919	41	1447689540	1447691340	0	172.16.13.15	1	1447689540	1447690840	172.16.13.15
1918	449	1447688975	1447690775	0	172.16.13.16	1	1447688975	\N	\N
1913	397	1447686751	1447688551	0	172.16.30.34	1	1447686751	1447687551	172.16.30.34
1915	225	1447687581	1447689381	0	172.16.20.21	1	1447687581	1447687857	172.16.20.21
1910	68	1447685248	1447687048	0	172.16.19.17	1	1447685248	\N	\N
1921	449	1447691027	1447692827	1	172.16.13.16	1	1447691027	\N	\N
1916	41	1447687593	1447689393	0	172.16.13.15	2	1447688817	1447688976	172.16.13.15
1937	439	1447784427	1447786227	1	172.16.10.16	1	1447784427	\N	\N
1927	275	1447703681	1447705481	0	172.16.31.38	2	1447704443	\N	\N
1922	41	1447695106	1447696906	0	172.16.13.15	1	1447695106	1447695278	172.16.13.15
1928	275	1447706123	1447707923	1	172.16.31.38	2	1447707174	\N	\N
1924	41	1447695440	1447697240	0	172.16.13.15	1	1447695440	1447695722	172.16.13.15
1923	449	1447695161	1447696961	0	172.16.13.16	1	1447695161	1447695929	172.16.13.16
1925	41	1447695948	1447697748	0	172.16.13.16	1	1447695948	1447696942	172.16.13.16
1926	449	1447696993	1447698793	0	172.16.13.16	1	1447696993	1447697435	172.16.13.16
1929	397	1447710783	1447712583	1	172.16.30.34	1	1447710783	\N	\N
1930	41	1447764378	1447766178	0	172.16.13.15	1	1447764378	1447764394	172.16.13.15
1931	439	1447770211	1447772011	0	172.16.10.16	1	1447770211	1447770370	172.16.10.16
1933	439	1447771956	1447773756	0	172.16.10.16	1	1447771956	1447771964	172.16.10.16
1932	275	1447770846	1447772646	0	172.16.31.38	1	1447770846	\N	\N
2096	355	1453652642	1453654442	1	192.168.0.7	2	1453653234	\N	\N
1934	275	1447772777	1447774577	0	172.16.31.38	1	1447772777	1447773119	172.16.31.38
1938	11	1447785053	1447786853	0	172.16.31.24	1	1447785053	1447785145	172.16.31.24
1939	439	1447788996	1447790796	1	172.16.10.16	1	1447788996	\N	\N
1940	1	1447790641	1447792441	0	172.16.20.21	1	1447790641	1447790706	172.16.20.21
1941	9	1447790721	1447792521	0	172.16.20.21	1	1447790721	1447790746	172.16.20.21
1942	1	1447790825	1447792625	0	172.16.20.21	1	1447790825	1447790877	172.16.20.21
1943	22	1447790908	1447792708	0	172.16.20.21	1	1447790908	1447790955	172.16.20.21
1944	1	1447791457	1447793257	0	172.16.20.21	1	1447791457	1447791497	172.16.20.21
1945	1	1447791513	1447793313	0	172.16.20.21	1	1447791513	1447791536	172.16.20.21
1946	32	1447791552	1447793352	0	172.16.20.21	1	1447791552	1447791569	172.16.20.21
1947	1	1447791603	1447793403	0	172.16.20.21	1	1447791603	1447791644	172.16.20.21
1948	32	1447791661	1447793461	0	172.16.20.21	1	1447791661	1447791669	172.16.20.21
1949	41	1447791763	1447793563	0	172.16.20.21	1	1447791763	1447791778	172.16.20.21
1950	41	1447855097	1447856897	0	172.16.13.14	1	1447855097	1447855289	172.16.13.14
1951	155	1447860191	1447861991	0	172.16.31.24	1	1447860191	1447860581	172.16.31.24
1952	275	1447871521	1447873321	0	172.16.31.38	1	1447871521	1447871545	172.16.31.38
1953	23	1447876618	1447878418	0	172.16.20.25	1	1447876618	1447876642	172.16.20.25
1954	11	1447876649	1447878449	0	172.16.20.25	1	1447876649	1447876679	172.16.20.25
1955	437	1447879768	1447881568	1	172.16.20.20	1	1447879768	\N	\N
1956	439	1447940239	1447942039	1	172.16.10.16	1	1447940239	\N	\N
1957	397	1447967890	1447969690	1	172.16.30.34	1	1447967890	\N	\N
1958	225	1448286469	1448288269	0	172.16.11.17	1	1448286469	1448286960	172.16.11.17
1959	225	1448287131	1448288931	0	172.16.11.17	1	1448287131	1448287788	172.16.11.17
1991	463	1449067074	1449068874	0	172.16.20.29	1	1449067074	1449068146	172.16.20.29
1960	458	1448288090	1448289890	0	172.16.11.28	2	1448288621	1448288802	172.16.11.28
1962	230	1448288872	1448290672	0	172.16.11.17	1	1448288872	1448288897	172.16.11.17
1963	230	1448288924	1448290724	0	172.16.11.17	1	1448288924	1448288963	172.16.11.17
1964	225	1448288983	1448290783	0	172.16.11.17	1	1448288983	1448289025	172.16.11.17
1965	384	1448289741	1448291541	1	172.16.0.2	1	1448289741	\N	\N
1990	461	1449067016	1449068816	0	172.16.20.20	2	1449067604	1449068805	172.16.20.20
1976	459	1449063376	1449065176	0	172.16.0.2	2	1449065137	\N	\N
1987	462	1449065676	1449067476	0	172.16.0.2	1	1449065676	1449066035	172.16.0.2
1961	458	1448288805	1448290605	0	172.16.11.28	2	1448290039	\N	\N
1966	458	1448291346	1448293146	1	172.16.11.28	2	1448292006	\N	\N
1967	437	1448293299	1448295099	1	172.16.20.20	1	1448293299	\N	\N
1968	437	1448299427	1448301227	0	172.16.20.21	1	1448299427	1448299436	172.16.20.21
1969	1	1448299452	1448301252	1	172.16.20.21	2	1448300059	\N	\N
1970	1	1448302651	1448304451	1	172.16.20.21	1	1448302651	\N	\N
1971	1	1448399239	1448401039	0	172.16.20.21	2	1448400735	\N	\N
1972	1	1448401892	1448403692	0	172.16.20.21	2	1448403119	\N	\N
1989	461	1449066464	1449068264	0	172.16.20.20	1	1449066464	1449067004	172.16.20.20
1973	1	1448405364	1448407164	0	172.16.20.21	2	1448406225	1448406466	172.16.20.21
1974	114	1448554554	1448556354	0	172.16.18.16	1	1448554554	1448554598	172.16.18.16
1975	68	1448555050	1448556850	0	172.16.18.16	1	1448555050	1448555082	172.16.18.16
1977	460	1449063532	1449065332	1	172.16.20.28	1	1449063532	\N	\N
1978	461	1449063559	1449065359	0	172.16.20.20	1	1449063559	1449063564	172.16.20.20
1979	9	1449063573	1449065373	0	172.16.20.21	1	1449063573	1449063580	172.16.20.21
1980	1	1449063660	1449065460	0	172.16.20.21	1	1449063660	1449063773	172.16.20.21
1981	9	1449063787	1449065587	0	172.16.20.21	1	1449063787	1449063881	172.16.20.21
1983	9	1449064606	1449066406	0	172.16.20.21	1	1449064606	1449064750	172.16.20.21
1982	1	1449063888	1449065688	0	172.16.20.21	2	1449064758	1449064969	172.16.20.21
1985	461	1449064994	1449066794	0	172.16.20.20	1	1449064994	1449065007	172.16.20.20
1984	9	1449064979	1449066779	0	172.16.20.21	1	1449064979	1449065492	172.16.20.21
1992	415	1449067324	1449069124	1	172.16.20.31	1	1449067324	\N	\N
1986	1	1449065513	1449067313	0	172.16.20.21	1	1449065513	\N	\N
1993	9	1449067335	1449069135	0	172.16.20.21	1	1449067335	1449067341	172.16.20.21
1994	1	1449067398	1449069198	1	172.16.20.21	1	1449067398	\N	\N
1995	15	1449067805	1449069605	0	172.16.20.23	1	1449067805	1449067835	172.16.20.23
2008	462	1449886837	1449888637	0	192.168.0.7	1	1449886837	1449887564	192.168.0.7
2009	462	1450104416	1450106216	0	172.16.20.13	2	1450104938	1450104941	172.16.20.13
2010	462	1450104982	1450106782	1	172.16.20.13	1	1450104982	\N	\N
2011	1	1450713936	1450715736	1	172.16.20.28	1	1450713936	\N	\N
2012	9	1452094241	1452096041	0	172.16.20.10	1	1452094241	1452094260	172.16.20.10
2013	23	1452194828	1452196628	0	172.16.31.24	1	1452194828	1452195227	172.16.31.24
2014	23	1452195239	1452197039	0	172.16.31.24	1	1452195239	1452195913	172.16.31.24
2015	9	1452267325	1452269125	0	172.16.20.10	1	1452267325	1452267335	172.16.20.10
2016	1	1452277526	1452279326	1	172.16.20.21	1	1452277526	\N	\N
2017	1	1452607744	1452609544	0	172.16.20.21	1	1452607744	1452607800	172.16.20.21
2018	437	1452607830	1452609630	0	172.16.20.21	1	1452607830	1452607937	172.16.20.21
2019	437	1452629183	1452630983	1	172.16.20.21	1	1452629183	\N	\N
2020	464	1452708463	1452710263	1	172.16.31.23	2	1452708805	\N	\N
2021	11	1452878670	1452880470	0	::1	1	1452878670	1452878699	::1
2022	1	1452880536	1452882336	0	172.16.20.25	1	1452880536	1452880621	172.16.20.25
2023	11	1452880882	1452882682	0	172.16.20.25	1	1452880882	1452880892	172.16.20.25
2024	1	1452880906	1452882706	0	172.16.20.25	1	1452880906	1452880937	172.16.20.25
2025	11	1452880944	1452882744	0	172.16.20.25	1	1452880944	1452880953	172.16.20.25
1988	462	1449066043	1449067843	0	172.16.0.2	3	1449067002	\N	\N
1997	16	1449068157	1449069957	0	172.16.20.23	1	1449068157	1449068402	172.16.20.23
1998	461	1449068822	1449070622	0	172.16.20.20	1	1449068822	1449068826	172.16.20.20
1999	17	1449068969	1449070769	0	172.16.20.23	1	1449068969	1449068980	172.16.20.23
1996	462	1449068011	1449069811	0	172.16.0.2	1	1449068011	1449068984	172.16.0.2
2000	460	1449069627	1449071427	0	172.16.23.11	1	1449069627	1449070432	172.16.23.11
2001	178	1449078036	1449079836	0	172.16.0.2	1	1449078036	1449078076	172.16.0.2
2026	1	1452880977	1452882777	0	172.16.20.25	1	1452880977	1452880981	172.16.20.25
2002	178	1449078092	1449079892	0	172.16.20.20	2	1449078146	1449078149	172.16.0.2
2003	462	1449342642	1449344442	0	192.168.0.7	1	1449342642	1449342667	192.168.0.7
2004	437	1449601114	1449602914	0	172.16.20.21	1	1449601114	1449601172	172.16.20.21
2005	1	1449601215	1449603015	0	172.16.20.21	1	1449601215	1449601243	172.16.20.21
2006	437	1449601258	1449603058	1	172.16.20.21	1	1449601258	\N	\N
2007	11	1449870238	1449872038	1	172.16.20.25	1	1449870238	\N	\N
2031	1	1452885243	1452887043	0	172.16.20.25	2	1452886555	\N	\N
2032	1	1452887508	1452889308	0	172.16.20.25	1	1452887508	\N	\N
2033	1	1452889614	1452891414	0	172.16.20.25	2	1452891136	\N	\N
2034	237	1453122698	1453124498	1	172.16.10.10	1	1453122698	\N	\N
2035	11	1453400484	1453402284	0	172.16.20.19	1	1453400484	1453400587	172.16.20.19
2036	1	1453400754	1453402554	0	172.16.20.19	2	1453400765	1453401089	172.16.20.19
2037	23	1453401103	1453402903	0	172.16.20.19	1	1453401103	1453401229	172.16.20.19
2027	1	1452880991	1452882791	0	172.16.20.25	4	1452882472	\N	\N
2028	1	1452882911	1452884711	0	172.16.20.25	1	1452882911	1452883369	172.16.20.25
2029	237	1452883377	1452885177	0	172.16.20.25	1	1452883377	1452883386	172.16.20.25
2030	1	1452883399	1452885199	0	172.16.20.25	1	1452883399	\N	\N
2038	1	1453401241	1453403041	0	172.16.20.19	1	1453401241	1453401265	172.16.20.19
2039	237	1453489190	1453490990	1	172.16.10.10	1	1453489190	\N	\N
2040	1	1453489427	1453491227	0	::1	1	1453489427	1453489568	::1
2041	437	1453489571	1453491371	0	::1	1	1453489571	1453489573	::1
2043	355	1453489579	1453491379	0	::1	1	1453489579	1453489582	::1
2044	11	1453489588	1453491388	0	::1	1	1453489588	1453489615	::1
2045	1	1453489634	1453491434	0	::1	1	1453489634	1453489661	::1
2046	11	1453489667	1453491467	0	::1	1	1453489667	1453489678	::1
2042	437	1453489451	1453491251	0	::1	2	1453490141	1453490170	::1
2084	437	1453511663	1453513463	1	192.168.0.7	1	1453511663	\N	\N
2078	437	1453501586	1453503386	0	172.16.20.25	3	1453502414	1453502646	::1
2076	437	1453501531	1453503331	0	172.16.20.20	1	1453501531	1453501540	172.16.20.20
2054	437	1453493596	1453495396	0	::1	2	1453494164	1453494222	::1
2060	437	1453494490	1453496290	0	::1	1	1453494490	1453494772	::1
2049	355	1453491956	1453493756	0	::1	1	1453491956	1453491970	::1
2050	11	1453491977	1453493777	0	::1	1	1453491977	1453492112	::1
2051	355	1453492116	1453493916	0	::1	1	1453492116	1453492289	::1
2052	11	1453492294	1453494094	0	::1	1	1453492294	1453492659	::1
2047	437	1453490560	1453492360	0	::1	4	1453491561	1453491578	::1
2048	437	1453491696	1453493496	0	::1	2	1453492170	1453493133	::1
2062	178	1453494780	1453496580	0	::1	1	1453494780	1453494891	::1
2055	1	1453493817	1453495617	0	::1	1	1453493817	1453493848	::1
2070	461	1453497882	1453499682	0	::1	1	1453497882	\N	\N
2053	1	1453493250	1453495050	0	::1	3	1453493684	1453493756	::1
2056	461	1453493857	1453495657	0	::1	1	1453493857	1453494045	::1
2057	1	1453494069	1453495869	0	::1	1	1453494069	1453494088	::1
2058	461	1453494105	1453495905	0	::1	1	1453494105	1453494125	::1
2059	1	1453494134	1453495934	0	::1	1	1453494134	1453494156	::1
2071	461	1453499807	1453501607	0	::1	1	1453499807	1453500132	::1
2072	1	1453500146	1453501946	0	::1	1	1453500146	1453500177	::1
2061	1	1453494475	1453496275	0	::1	2	1453496107	\N	\N
2063	437	1453496282	1453498082	0	::1	1	1453496282	1453496476	::1
2065	178	1453496485	1453498285	0	::1	1	1453496485	1453496495	::1
2074	461	1453500193	1453501993	1	::1	2	1453501255	\N	\N
2064	1	1453496334	1453498134	0	::1	2	1453496929	1453497318	::1
2067	461	1453497328	1453499128	0	::1	1	1453497328	1453497384	::1
2066	437	1453497212	1453499012	0	::1	2	1453497412	1453497531	::1
2069	437	1453497743	1453499543	1	::1	1	1453497743	\N	\N
2068	1	1453497545	1453499345	0	::1	1	1453497545	1453497872	::1
2077	355	1453501568	1453503368	0	172.16.20.28	2	1453502146	\N	\N
2085	437	1453523012	1453524812	0	192.168.0.7	1	1453523012	1453523050	192.168.0.7
2079	11	1453501600	1453503400	0	172.16.20.13	3	1453502247	1453502401	172.16.20.25
2073	437	1453500183	1453501983	0	172.16.20.28	4	1453501518	1453501529	172.16.20.28
2075	11	1453501509	1453503309	0	172.16.20.13	2	1453501578	1453501590	172.16.20.13
2080	437	1453502796	1453504596	0	172.16.20.13	4	1453502830	1453502838	172.16.0.2
2086	11	1453523069	1453524869	0	192.168.0.7	1	1453523069	1453523075	192.168.0.7
2082	11	1453503073	1453504873	1	172.16.20.13	1	1453503073	\N	\N
2081	437	1453502890	1453504690	0	::1	5	1453503690	1453503829	172.16.20.17
2083	437	1453511258	1453513058	0	192.168.0.7	1	1453511258	1453511649	192.168.0.7
2087	437	1453523094	1453524894	0	192.168.0.7	1	1453523094	1453523389	192.168.0.7
2089	437	1453523513	1453525313	0	192.168.0.7	1	1453523513	1453523775	192.168.0.7
2090	437	1453523920	1453525720	0	192.168.0.7	1	1453523920	1453524537	192.168.0.7
2088	355	1453523207	1453525007	0	192.168.0.7	2	1453523879	1453524647	192.168.0.7
2092	11	1453557092	1453558892	0	192.168.0.7	1	1453557092	1453557215	192.168.0.7
2091	355	1453557072	1453558872	0	192.168.0.7	1	1453557072	1453557786	192.168.0.7
2093	437	1453575925	1453577725	0	192.168.0.7	1	1453575925	1453575989	192.168.0.7
2094	437	1453600657	1453602457	0	192.168.0.7	2	1453601818	1453602132	192.168.0.7
2097	11	1453653299	1453655099	1	192.168.0.7	1	1453653299	\N	\N
2095	437	1453652574	1453654374	0	192.168.0.7	1	1453652574	\N	\N
2098	437	1453654441	1453656241	1	192.168.0.7	1	1453654441	\N	\N
2145	23	1453733378	1453735178	1	::1	1	1453733378	\N	\N
2144	1	1453733129	1453734929	0	::1	1	1453733129	1453733154	::1
2115	355	1453728912	1453730712	0	::1	1	1453728912	1453729317	::1
2162	178	1453740758	1453742558	0	172.16.20.17	1	1453740758	1453740766	172.16.20.17
2126	355	1453731246	1453733046	0	::1	3	1453731754	1453731693	172.16.20.25
2117	461	1453729202	1453731002	0	::1	1	1453729202	\N	\N
2131	355	1453731810	1453733610	1	::1	2	1453731747	\N	\N
2128	437	1453731391	1453733191	0	::1	2	1453731731	1453731831	::1
2114	437	1453728541	1453730341	0	172.16.20.17	2	1453728990	1453728997	172.16.20.17
2102	11	1453727654	1453729454	0	172.16.20.25	1	1453727654	1453727744	172.16.20.25
2104	1	1453727759	1453729559	0	172.16.20.25	1	1453727759	1453727831	172.16.20.25
2105	237	1453727836	1453729636	0	172.16.20.25	1	1453727836	1453727840	172.16.20.25
2103	355	1453727712	1453729512	0	172.16.20.25	1	1453727712	1453727892	172.16.20.25
2133	1	1453731843	1453733643	0	::1	1	1453731843	1453731875	::1
2125	461	1453731011	1453732811	0	::1	1	1453731011	1453731267	::1
2124	11	1453730514	1453732314	0	::1	3	1453731294	1453731436	::1
2113	355	1453728393	1453730193	0	::1	1	1453728393	1453728901	::1
2156	1	1453739347	1453741147	0	::1	1	1453739347	1453739407	::1
2151	437	1453738659	1453740459	0	::1	1	1453738659	1453738733	::1
2127	1	1453731317	1453733117	0	::1	2	1453731467	1453731482	::1
2110	237	1453728227	1453730027	0	172.16.20.25	2	1453728373	1453729152	172.16.20.25
2116	23	1453729201	1453731001	1	172.16.20.25	1	1453729201	\N	\N
2107	237	1453727897	1453729697	0	172.16.10.10	2	1453728206	1453728055	172.16.20.25
2100	11	1453727195	1453728995	0	172.16.0.2	2	1453727274	1453727802	::1
2134	437	1453731881	1453733681	0	::1	2	1453732629	1453732664	::1
2136	1	1453732685	1453734485	0	::1	1	1453732685	1453732715	::1
2118	11	1453729276	1453731076	0	::1	2	1453729325	1453729382	::1
2109	355	1453728059	1453729859	0	::1	3	1453728198	1453728316	172.16.20.25
2108	11	1453728052	1453729852	0	172.16.20.25	1	1453728052	1453728361	172.16.20.25
2129	178	1453731505	1453733305	0	::1	1	1453731505	1453731597	::1
2101	355	1453727235	1453729035	0	172.16.20.13	4	1453727415	1453727859	::1
2099	437	1453726944	1453728744	0	::1	13	1453728375	1453728386	::1
2112	11	1453728391	1453730191	0	172.16.20.17	4	1453729029	1453729069	172.16.20.17
2106	1	1453727854	1453729654	0	::1	2	1453727893	1453728046	172.16.20.25
2119	1	1453729340	1453731140	1	172.16.20.25	2	1453730393	\N	\N
2149	437	1453736622	1453738422	0	::1	2	1453736450	1453736467	::1
2130	23	1453731619	1453733419	0	172.16.20.25	2	1453731592	1453731637	::1
2123	437	1453730076	1453731876	0	::1	5	1453731276	1453731306	::1
2146	437	1453733160	1453734960	0	::1	5	1453734579	\N	\N
2121	355	1453729389	1453731189	0	172.16.20.25	4	1453730842	\N	\N
2137	437	1453732720	1453734520	0	::1	2	1453733026	1453733031	::1
2120	437	1453729355	1453731155	0	::1	3	1453730078	1453730098	::1
2132	23	1453731711	1453733511	0	::1	2	1453733050	1453733103	::1
2122	11	1453730057	1453731857	0	172.16.20.21	3	1453730288	1453730363	172.16.20.25
2152	1	1453738791	1453740591	0	::1	1	1453738791	1453738859	::1
2111	1	1453728337	1453730137	0	::1	3	1453728851	1453729190	::1
2135	11	1453732087	1453733887	0	::1	2	1453733109	1453733137	::1
2138	437	1453733139	1453734939	0	::1	1	1453733139	1453733153	::1
2139	1	1453733174	1453734974	0	::1	1	1453733174	1453733198	::1
2140	437	1453733201	1453735001	0	::1	1	1453733201	1453733246	::1
2141	1	1453733261	1453735061	0	::1	1	1453733261	1453733299	::1
2143	178	1453733205	1453735005	1	::1	1	1453733205	\N	\N
2153	461	1453738868	1453740668	0	::1	1	1453738868	1453738906	::1
2142	437	1453733302	1453735102	0	::1	2	1453733103	1453733109	::1
2147	437	1453735086	1453736886	0	::1	3	1453736407	1453736431	::1
2148	355	1453736435	1453738235	0	::1	1	1453736435	1453736445	::1
2163	437	1453741440	1453743240	0	172.16.20.21	2	1453741762	1453741837	172.16.20.21
2164	1	1453741856	1453743656	1	172.16.20.21	1	1453741856	\N	\N
2161	461	1453739984	1453741784	1	::1	1	1453739984	\N	\N
2154	437	1453738913	1453740713	0	::1	1	1453738913	1453739240	::1
2157	461	1453739416	1453741216	0	::1	1	1453739416	1453739604	::1
2155	461	1453739248	1453741048	0	::1	1	1453739248	1453739324	::1
2158	1	1453739622	1453741422	0	::1	1	1453739622	1453739636	::1
2160	461	1453739643	1453741443	0	::1	1	1453739643	1453739657	::1
2165	355	1453743529	1453745329	0	172.16.20.17	1	1453743529	1453743933	172.16.20.17
2167	437	1453743654	1453745454	0	172.16.20.28	1	1453743654	1453743935	172.16.20.28
2159	437	1453739698	1453741498	0	172.16.20.17	2	1453740741	1453740748	172.16.20.17
2168	178	1453743942	1453745742	0	172.16.20.17	1	1453743942	1453743987	172.16.20.17
2150	437	1453736472	1453738272	0	::1	6	1453737808	\N	\N
2169	460	1453743948	1453745748	0	172.16.20.28	1	1453743948	1453744005	172.16.20.28
2170	460	1453744044	1453745844	0	172.16.20.28	1	1453744044	1453744143	172.16.20.28
2171	1	1453744174	1453745974	0	172.16.20.28	1	1453744174	1453744247	172.16.20.28
2172	178	1453744264	1453746064	0	172.16.20.17	1	1453744264	1453744317	172.16.20.17
2173	355	1453744325	1453746125	0	172.16.20.17	1	1453744325	1453744374	172.16.20.17
2166	237	1453743727	1453745527	1	172.16.10.10	3	1453744801	\N	\N
2175	404	1453747532	1453749332	0	172.16.14.53	1	1453747532	1453748451	172.16.14.53
2176	437	1453747704	1453749504	0	172.16.20.21	1	1453747704	1453747802	172.16.20.21
2174	237	1453747407	1453749207	0	172.16.20.25	5	1453748508	1453748532	172.16.20.25
2177	1	1453747819	1453749619	0	172.16.20.21	1	1453747819	1453747865	172.16.20.21
2180	1	1453748450	1453750250	0	172.16.20.25	1	1453748450	1453748502	172.16.20.25
2178	11	1453747840	1453749640	0	172.16.20.25	2	1453748539	1453748551	172.16.20.25
2182	237	1453748608	1453750408	0	172.16.20.25	1	1453748608	1453748672	172.16.20.25
2196	237	1453749874	1453751674	0	172.16.20.25	1	1453749874	1453749902	172.16.20.25
2197	237	1453749911	1453751711	0	172.16.20.25	1	1453749911	1453749967	172.16.20.25
2179	437	1453748070	1453749870	0	172.16.20.21	2	1453749003	1453749151	172.16.20.21
2198	237	1453749974	1453751774	0	172.16.20.25	1	1453749974	1453750143	172.16.20.25
2184	237	1453749239	1453751039	0	172.16.20.25	1	1453749239	1453749273	172.16.20.25
2185	237	1453749281	1453751081	0	172.16.20.25	1	1453749281	1453749310	172.16.20.25
2187	237	1453749541	1453751341	0	::1	1	1453749541	1453749547	::1
2188	355	1453749565	1453751365	0	::1	1	1453749565	1453749569	::1
2186	1	1453749383	1453751183	0	172.16.20.21	1	1453749383	1453749444	172.16.20.21
2199	78	1453750168	1453751968	0	172.16.18.12	1	1453750168	1453750213	172.16.18.12
2217	21	1453815423	1453817223	0	172.16.20.25	2	1453815547	1453815558	172.16.20.25
2183	237	1453748678	1453750478	0	172.16.20.25	4	1453749084	1453749227	172.16.20.25
2200	467	1453750197	1453751997	0	172.16.10.10	2	1453750269	1453750601	172.16.10.10
2219	469	1453815561	1453817361	0	172.16.19.16	1	1453815561	1453815617	172.16.19.16
2192	1	1453749611	1453751411	0	172.16.10.10	2	1453750613	1453750707	172.16.10.10
2201	467	1453750718	1453752518	0	172.16.10.10	1	1453750718	1453750950	172.16.10.10
2189	237	1453749457	1453751257	0	172.16.20.21	2	1453749506	1453749515	172.16.20.21
2202	467	1453750974	1453752774	1	172.16.10.10	1	1453750974	\N	\N
2220	355	1453815573	1453817373	0	172.16.20.25	1	1453815573	1453815648	172.16.20.25
2203	178	1453764334	1453766134	0	192.168.0.7	1	1453764334	1453764386	192.168.0.7
2204	467	1453804561	1453806361	0	172.16.10.10	1	1453804561	1453804587	172.16.10.10
2206	11	1453814026	1453815826	0	172.16.20.25	2	1453814739	1453814780	172.16.20.25
2205	467	1453814014	1453815814	1	172.16.20.28	2	1453814834	\N	\N
2207	11	1453814976	1453816776	0	172.16.20.25	1	1453814976	1453815032	172.16.20.25
2208	21	1453815063	1453816863	0	172.16.20.25	1	1453815063	1453815070	172.16.20.25
2209	11	1453815077	1453816877	0	172.16.20.25	1	1453815077	1453815111	172.16.20.25
2191	1	1453749560	1453751360	0	172.16.20.25	2	1453749562	1453749583	172.16.20.21
2190	11	1453749684	1453751484	0	172.16.20.25	2	1453749531	1453749550	172.16.20.25
2210	11	1453815119	1453816919	0	172.16.20.25	1	1453815119	1453815149	172.16.20.25
2181	1	1453748562	1453750362	0	172.16.20.21	2	1453749183	1453749301	172.16.20.21
2213	21	1453815202	1453817002	0	172.16.31.44	2	1453815212	1453815232	172.16.20.25
2194	437	1453749673	1453751473	1	172.16.20.21	1	1453749673	\N	\N
2193	237	1453749791	1453751591	0	172.16.20.25	2	1453749652	1453749823	172.16.20.25
2195	237	1453749832	1453751632	0	172.16.20.25	1	1453749832	1453749868	172.16.20.25
2214	11	1453815241	1453817041	0	172.16.20.25	1	1453815241	1453815259	172.16.20.25
2223	469	1453815698	1453817498	0	172.16.19.16	1	1453815698	1453815727	172.16.19.16
2216	11	1453815281	1453817081	0	172.16.20.25	1	1453815281	1453815413	172.16.20.25
2215	21	1453815254	1453817054	0	172.16.20.25	2	1453815390	1453815399	172.16.31.44
2212	11	1453815177	1453816977	0	172.16.20.25	1	1453815177	1453815196	172.16.20.25
2211	21	1453815120	1453816920	0	172.16.20.25	2	1453815158	1453815165	172.16.20.25
2224	469	1453816050	1453817850	0	172.16.20.19	1	1453816050	1453816228	172.16.20.19
2218	11	1453815438	1453817238	0	172.16.20.25	1	1453815438	1453815506	172.16.20.25
2222	21	1453815663	1453817463	0	172.16.20.25	2	1453816540	1453816756	172.16.20.25
2225	23	1453816321	1453818121	0	172.16.20.19	1	1453816321	1453816340	172.16.20.19
2226	23	1453816346	1453818146	0	172.16.20.19	1	1453816346	1453816382	172.16.20.19
2227	11	1453816393	1453818193	0	172.16.20.19	1	1453816393	1453816400	172.16.20.19
2228	1	1453816410	1453818210	0	172.16.20.19	1	1453816410	1453816429	172.16.20.19
2233	21	1453816764	1453818564	0	172.16.20.25	1	1453816764	1453816851	172.16.20.25
2229	11	1453816436	1453818236	0	172.16.20.19	1	1453816436	1453816466	172.16.20.19
2230	1	1453816478	1453818278	0	172.16.20.19	1	1453816478	1453816493	172.16.20.19
2221	11	1453815605	1453817405	0	172.16.20.19	2	1453816248	1453816285	172.16.20.19
2235	21	1453816933	1453818733	0	172.16.20.19	2	1453816953	1453816958	172.16.20.19
2234	355	1453816856	1453818656	0	172.16.20.25	1	1453816856	1453816925	172.16.20.25
2236	21	1453816999	1453818799	1	172.16.20.25	1	1453816999	\N	\N
2237	437	1453817304	1453819104	0	172.16.20.19	1	1453817304	1453817505	172.16.20.19
2239	11	1453817604	1453819404	0	172.16.20.19	1	1453817604	1453817738	172.16.20.19
2232	11	1453816696	1453818496	0	172.16.20.19	2	1453817517	1453817540	172.16.20.19
2231	11	1453816500	1453818300	0	172.16.20.25	2	1453816691	1453816691	172.16.20.19
2238	469	1453817557	1453819357	0	172.16.20.19	1	1453817557	1453817597	172.16.20.19
2241	469	1453817980	1453819780	1	172.16.19.16	1	1453817980	\N	\N
2243	143	1453818425	1453820225	1	172.16.31.38	1	1453818425	\N	\N
2244	453	1453818486	1453820286	1	172.16.12.32	1	1453818486	\N	\N
2242	11	1453818422	1453820222	0	172.16.20.19	2	1453819710	1453819950	172.16.20.19
2246	9	1453819958	1453821758	0	172.16.20.19	1	1453819958	1453819964	172.16.20.19
2240	467	1453817747	1453819547	0	172.16.10.10	2	1453818422	\N	\N
2245	68	1453818643	1453820443	0	172.16.19.17	1	1453818643	\N	\N
2247	11	1453819995	1453821795	0	172.16.20.19	1	1453819995	1453820927	172.16.20.19
2250	21	1453820937	1453822737	0	172.16.20.19	1	1453820937	1453821182	172.16.20.19
2251	22	1453821190	1453822990	0	172.16.20.19	1	1453821190	1453821234	172.16.20.19
2249	68	1453820893	1453822693	0	172.16.19.17	2	1453821357	\N	\N
2252	11	1453821241	1453823041	0	172.16.20.19	1	1453821241	1453821326	172.16.20.19
2253	24	1453821334	1453823134	0	172.16.20.19	1	1453821334	1453821506	172.16.20.19
2254	11	1453821516	1453823316	0	172.16.20.19	1	1453821516	1453821558	172.16.20.19
2255	24	1453821567	1453823367	0	172.16.20.19	1	1453821567	1453821661	172.16.20.19
2256	11	1453821669	1453823469	0	172.16.20.19	1	1453821669	1453822061	172.16.20.19
2257	11	1453822091	1453823891	0	172.16.20.19	1	1453822091	1453822108	172.16.20.19
2258	29	1453822116	1453823916	0	172.16.20.19	1	1453822116	1453822257	172.16.20.19
2285	469	1453827929	1453829729	0	172.16.20.19	1	1453827929	1453828005	172.16.20.19
2259	11	1453822264	1453824064	0	172.16.20.19	1	1453822264	1453822514	172.16.20.19
2260	31	1453822525	1453824325	0	172.16.20.19	1	1453822525	1453822559	172.16.20.19
2263	32	1453823162	1453824962	0	172.16.20.19	1	1453823162	1453823166	172.16.20.19
2286	11	1453828012	1453829812	0	172.16.20.19	1	1453828012	1453828039	172.16.20.19
2248	467	1453820312	1453822112	0	172.16.10.10	2	1453821227	\N	\N
2264	467	1453823437	1453825237	1	172.16.10.10	1	1453823437	\N	\N
2287	11	1453828068	1453829868	0	172.16.20.19	1	1453828068	1453828084	172.16.20.19
2261	11	1453822566	1453824366	0	172.16.20.19	2	1453823256	\N	\N
2262	68	1453822912	1453824712	0	172.16.19.17	1	1453822912	1453824565	172.16.19.17
2267	183	1453824623	1453826423	1	172.16.20.20	1	1453824623	\N	\N
2265	11	1453824382	1453826182	0	172.16.20.17	2	1453824392	1453824647	172.16.20.19
2288	454	1453828095	1453829895	0	172.16.20.19	1	1453828095	1453828101	172.16.20.19
2289	11	1453828111	1453829911	0	172.16.20.19	1	1453828111	1453828154	172.16.20.19
2269	440	1453825350	1453827150	0	172.16.28.51	1	1453825350	1453825577	172.16.28.51
2270	440	1453825590	1453827390	0	172.16.28.51	1	1453825590	1453825766	172.16.28.51
2271	204	1453825836	1453827636	1	172.16.20.20	1	1453825836	\N	\N
2268	68	1453825050	1453826850	1	172.16.31.24	2	1453826129	\N	\N
2272	41	1453826439	1453828239	1	172.16.13.14	1	1453826439	\N	\N
2266	468	1453824507	1453826307	0	172.16.20.19	2	1453824653	1453824914	172.16.14.22
2273	11	1453827352	1453829152	0	172.16.20.19	1	1453827352	1453827372	172.16.20.19
2274	11	1453827379	1453829179	0	172.16.20.19	1	1453827379	1453827392	172.16.20.19
2275	37	1453827407	1453829207	0	172.16.20.19	1	1453827407	1453827414	172.16.20.19
2276	11	1453827423	1453829223	0	172.16.20.19	1	1453827423	1453827480	172.16.20.19
2277	384	1453827494	1453829294	0	172.16.20.19	1	1453827494	1453827501	172.16.20.19
2278	11	1453827557	1453829357	0	172.16.20.19	1	1453827557	1453827592	172.16.20.19
2279	446	1453827603	1453829403	0	172.16.20.19	1	1453827603	1453827616	172.16.20.19
2280	11	1453827623	1453829423	0	172.16.20.19	1	1453827623	1453827648	172.16.20.19
2281	87	1453827657	1453829457	0	172.16.20.19	1	1453827657	1453827797	172.16.20.19
2282	11	1453827805	1453829605	0	172.16.20.19	1	1453827805	1453827847	172.16.20.19
2283	382	1453827856	1453829656	0	172.16.20.19	1	1453827856	1453827877	172.16.20.19
2284	11	1453827884	1453829684	0	172.16.20.19	1	1453827884	1453827921	172.16.20.19
2290	439	1453828165	1453829965	0	172.16.20.19	1	1453828165	1453828171	172.16.20.19
2292	467	1453830269	1453832069	1	172.16.10.10	1	1453830269	\N	\N
2293	469	1453830602	1453832402	0	172.16.19.16	1	1453830602	1453830646	172.16.19.16
2294	469	1453830675	1453832475	0	172.16.19.16	1	1453830675	1453830680	172.16.19.16
2291	11	1453828178	1453829978	0	172.16.20.19	1	1453828178	\N	\N
2295	468	1453831513	1453833313	0	172.16.20.19	1	1453831513	1453831529	172.16.20.19
2297	41	1453831567	1453833367	1	172.16.13.14	1	1453831567	\N	\N
2296	11	1453831537	1453833337	0	172.16.20.19	1	1453831537	1453831597	172.16.20.19
2298	11	1453831624	1453833424	0	172.16.20.19	1	1453831624	1453831659	172.16.20.19
2299	68	1453831669	1453833469	0	172.16.20.19	1	1453831669	1453831757	172.16.20.19
2300	37	1453831766	1453833566	0	172.16.20.19	1	1453831766	1453831768	172.16.20.19
2301	11	1453831775	1453833575	0	172.16.20.19	1	1453831775	1453831791	172.16.20.19
2302	37	1453831797	1453833597	0	172.16.20.19	1	1453831797	1453831814	172.16.20.19
2303	11	1453831821	1453833621	0	172.16.20.19	1	1453831821	1453831978	172.16.20.19
2304	162	1453831983	1453833783	0	172.16.20.19	1	1453831983	1453832002	172.16.20.19
2305	11	1453832010	1453833810	0	172.16.20.19	1	1453832010	1453832032	172.16.20.19
2306	384	1453832039	1453833839	0	172.16.20.19	1	1453832039	1453832061	172.16.20.19
2307	11	1453832069	1453833869	0	172.16.20.19	1	1453832069	1453832086	172.16.20.19
2308	446	1453832095	1453833895	0	172.16.20.19	1	1453832095	1453832110	172.16.20.19
2309	11	1453832118	1453833918	0	172.16.20.19	1	1453832118	1453832133	172.16.20.19
2310	23	1453832121	1453833921	0	172.16.31.24	1	1453832121	1453832150	172.16.31.24
2311	87	1453832139	1453833939	0	172.16.20.19	1	1453832139	1453832178	172.16.20.19
2312	11	1453832185	1453833985	0	172.16.20.19	1	1453832185	1453832223	172.16.20.19
2314	382	1453832229	1453834029	0	172.16.20.19	1	1453832229	1453832235	172.16.20.19
2313	23	1453832208	1453834008	0	172.16.31.24	1	1453832208	1453832265	172.16.31.24
2315	11	1453832257	1453834057	0	172.16.20.19	1	1453832257	1453832275	172.16.20.19
2316	469	1453832281	1453834081	0	172.16.20.19	1	1453832281	1453832339	172.16.20.19
2317	11	1453832347	1453834147	0	172.16.20.19	1	1453832347	1453832364	172.16.20.19
2318	454	1453832371	1453834171	0	172.16.20.19	1	1453832371	1453832378	172.16.20.19
2319	11	1453832398	1453834198	0	172.16.20.19	1	1453832398	1453832420	172.16.20.19
2320	439	1453832427	1453834227	0	172.16.20.19	1	1453832427	1453832450	172.16.20.19
2321	11	1453832458	1453834258	0	172.16.20.19	1	1453832458	1453832559	172.16.20.19
2322	68	1453832577	1453834377	0	172.16.20.19	1	1453832577	1453832599	172.16.20.19
2323	87	1453832611	1453834411	1	172.16.20.19	1	1453832611	\N	\N
2326	468	1453833938	1453835738	1	172.16.20.19	1	1453833938	\N	\N
2327	470	1453834121	1453835921	0	172.16.30.60	1	1453834121	1453834493	172.16.30.60
2340	275	1453837378	1453839178	0	172.16.20.20	1	1453837378	1453837380	172.16.20.20
2342	280	1453837469	1453839269	1	172.16.20.20	1	1453837469	\N	\N
2343	467	1453837488	1453839288	0	172.16.10.10	1	1453837488	1453837665	172.16.10.10
2344	21	1453837698	1453839498	0	172.16.31.44	1	1453837698	1453838145	172.16.31.44
2345	68	1453839348	1453841148	0	172.16.20.25	1	1453839348	1453839359	172.16.20.25
2328	469	1453834454	1453836254	0	172.16.30.60	2	1453834510	1453834542	172.16.30.60
2329	470	1453834546	1453836346	0	172.16.30.60	1	1453834546	1453834551	172.16.30.60
2346	468	1453839374	1453841174	0	172.16.20.25	1	1453839374	1453839576	172.16.20.25
2348	11	1453839857	1453841657	0	172.16.20.25	1	1453839857	1453839911	172.16.20.25
2341	11	1453837416	1453839216	0	172.16.20.17	1	1453837416	\N	\N
2350	355	1453839957	1453841757	0	172.16.20.17	1	1453839957	1453839968	172.16.20.17
2351	437	1453839989	1453841789	0	172.16.20.17	1	1453839989	1453840001	172.16.20.17
2352	437	1453840012	1453841812	0	172.16.20.17	1	1453840012	1453840030	172.16.20.17
2349	467	1453839918	1453841718	0	172.16.20.25	1	1453839918	1453840032	172.16.20.25
2353	355	1453840053	1453841853	1	172.16.20.17	1	1453840053	\N	\N
2354	68	1453840112	1453841912	0	172.16.20.25	1	1453840112	1453840215	172.16.20.25
2355	468	1453840226	1453842026	0	172.16.20.25	1	1453840226	1453840311	172.16.20.25
2356	467	1453840324	1453842124	0	172.16.20.25	1	1453840324	1453840400	172.16.20.25
2358	468	1453840679	1453842479	1	172.16.14.22	1	1453840679	\N	\N
2357	11	1453840411	1453842211	0	172.16.20.25	1	1453840411	1453840990	172.16.20.25
2359	440	1453841012	1453842812	0	172.16.20.25	1	1453841012	1453841033	172.16.20.25
2360	68	1453841049	1453842849	1	172.16.20.25	1	1453841049	\N	\N
2347	41	1453839803	1453841603	0	172.16.13.14	1	1453839803	1453841175	172.16.13.14
2330	469	1453834561	1453836361	0	172.16.30.60	1	1453834561	1453834591	172.16.30.60
2361	11	1453843278	1453845078	0	172.16.20.19	1	1453843278	1453843317	172.16.20.19
2325	114	1453833517	1453835317	0	172.16.18.10	3	1453834947	1453834970	172.16.18.10
2324	21	1453832843	1453834643	0	172.16.31.44	1	1453832843	\N	\N
2331	11	1453835004	1453836804	0	172.16.20.20	1	1453835004	1453835572	172.16.20.20
2332	225	1453835658	1453837458	0	172.16.20.20	1	1453835658	1453835841	172.16.20.20
2333	230	1453835851	1453837651	0	172.16.20.20	1	1453835851	1453835879	172.16.20.20
2334	471	1453835867	1453837667	0	172.16.11.20	1	1453835867	1453835954	172.16.11.20
2335	233	1453836440	1453838240	0	172.16.20.20	1	1453836440	1453836462	172.16.20.20
2336	234	1453836473	1453838273	0	172.16.20.20	1	1453836473	1453836483	172.16.20.20
2337	235	1453836559	1453838359	0	172.16.20.20	1	1453836559	1453836693	172.16.20.20
2338	245	1453836802	1453838602	0	172.16.20.20	1	1453836802	1453836819	172.16.20.20
2339	265	1453837205	1453839005	0	172.16.20.20	1	1453837205	1453837207	172.16.20.20
2363	87	1453843347	1453845147	0	172.16.20.19	1	1453843347	1453843363	172.16.20.19
2364	11	1453843465	1453845265	0	172.16.20.19	1	1453843465	1453843489	172.16.20.19
2370	9	1453844180	1453845980	0	172.16.20.21	1	1453844180	1453844240	172.16.20.21
2362	9	1453843317	1453845117	0	172.16.20.21	2	1453843753	1453843821	172.16.20.21
2365	11	1453843535	1453845335	0	172.16.20.19	1	1453843535	1453843930	172.16.20.19
2366	68	1453843938	1453845738	0	172.16.20.19	1	1453843938	1453843971	172.16.20.19
2367	469	1453843985	1453845785	0	172.16.20.19	1	1453843985	1453844057	172.16.20.19
2368	87	1453844073	1453845873	0	172.16.20.19	1	1453844073	1453844081	172.16.20.19
2371	9	1453844254	1453846054	0	172.16.20.21	1	1453844254	1453844309	172.16.20.21
2372	437	1453844283	1453846083	0	172.16.20.19	1	1453844283	1453844310	172.16.20.19
2373	355	1453844347	1453846147	0	172.16.20.19	1	1453844347	1453844388	172.16.20.19
2374	437	1453844399	1453846199	0	172.16.20.19	1	1453844399	1453844410	172.16.20.19
2375	467	1453844430	1453846230	0	172.16.20.19	1	1453844430	1453844443	172.16.20.19
2377	9	1453844468	1453846268	1	172.16.20.21	1	1453844468	\N	\N
2376	355	1453844455	1453846255	0	172.16.20.19	1	1453844455	1453844677	172.16.20.19
2378	437	1453844704	1453846504	0	172.16.20.19	1	1453844704	1453844795	172.16.20.19
2379	355	1453844816	1453846616	1	172.16.20.19	1	1453844816	\N	\N
2380	437	1453844849	1453846649	0	172.16.0.2	1	1453844849	1453844923	172.16.0.2
2382	462	1453860043	1453861843	0	192.168.0.7	1	1453860043	1453860051	192.168.0.7
2369	468	1453844122	1453845922	0	172.16.20.19	2	1453845506	1453845651	172.16.20.19
2381	468	1453845675	1453847475	1	172.16.20.19	1	1453845675	\N	\N
2383	437	1453860062	1453861862	0	192.168.0.7	1	1453860062	1453860103	192.168.0.7
2384	355	1453860114	1453861914	0	192.168.0.7	1	1453860114	1453860167	192.168.0.7
2385	467	1453891252	1453893052	1	172.16.10.10	1	1453891252	\N	\N
2386	467	1453896749	1453898549	1	172.16.10.10	1	1453896749	\N	\N
2387	467	1453900327	1453902127	0	172.16.10.10	1	1453900327	1453900408	172.16.10.10
2389	1	1453902123	1453903923	0	172.16.20.20	1	1453902123	1453902158	172.16.20.20
2390	437	1453902178	1453903978	0	172.16.20.20	1	1453902178	1453902197	172.16.20.20
2391	1	1453902209	1453904009	0	172.16.20.20	1	1453902209	1453902227	172.16.20.20
2392	437	1453902234	1453904034	0	172.16.20.20	1	1453902234	1453902255	172.16.20.20
2393	461	1453902263	1453904063	0	172.16.20.20	1	1453902263	1453902315	172.16.20.20
2394	468	1453902808	1453904608	0	172.16.20.19	1	1453902808	1453902953	172.16.20.19
2396	437	1453903353	1453905153	0	172.16.20.20	2	1453903355	1453903362	172.16.20.20
2397	437	1453903375	1453905175	0	172.16.20.20	1	1453903375	1453903379	172.16.20.20
2398	11	1453903388	1453905188	0	172.16.20.20	1	1453903388	1453903394	172.16.20.20
2395	355	1453903132	1453904932	0	172.16.20.19	4	1453903395	1453903427	172.16.20.17
2388	467	1453900424	1453902224	0	172.16.10.10	3	1453901900	\N	\N
2400	437	1453903450	1453905250	0	172.16.20.19	1	1453903450	1453903474	172.16.20.19
2401	355	1453903454	1453905254	0	172.16.20.17	1	1453903454	1453903489	172.16.20.17
2402	9	1453903524	1453905324	0	172.16.20.19	1	1453903524	1453903564	172.16.20.19
2403	355	1453903574	1453905374	1	172.16.20.19	1	1453903574	\N	\N
2436	437	1454004920	1454006720	1	172.16.20.20	1	1454004920	\N	\N
2404	178	1453903943	1453905743	0	172.16.20.17	1	1453903943	1453903956	172.16.20.17
2399	467	1453903447	1453905247	0	172.16.10.10	2	1453903906	1453904224	172.16.10.10
2452	11	1454009274	1454011074	0	172.16.20.19	1	1454009274	1454009302	172.16.20.19
2405	468	1453903988	1453905788	0	172.16.20.17	2	1453904319	1453904620	172.16.20.17
2435	453	1454004606	1454006406	0	172.16.12.10	1	1454004606	\N	\N
2407	178	1453904724	1453906524	0	172.16.20.17	1	1453904724	1453904726	172.16.20.17
2406	11	1453904511	1453906311	0	172.16.20.17	2	1453904677	1453904716	172.16.20.17
2408	11	1453904803	1453906603	0	172.16.20.19	1	1453904803	1453904820	172.16.20.19
2409	22	1453904993	1453906793	1	192.168.0.7	1	1453904993	\N	\N
2411	11	1453905317	1453907117	1	172.16.20.19	1	1453905317	\N	\N
2434	467	1454003828	1454005628	0	172.16.10.10	2	1454004463	\N	\N
2410	467	1453905169	1453906969	0	172.16.10.10	2	1453906956	\N	\N
2412	467	1453907680	1453909480	0	172.16.10.10	2	1453908769	\N	\N
2440	178	1454006882	1454008682	0	172.16.20.17	1	1454006882	1454006890	172.16.20.17
2413	467	1453909743	1453911543	0	172.16.10.10	2	1453910385	\N	\N
2414	467	1453911546	1453913346	1	172.16.10.10	1	1453911546	\N	\N
2415	470	1453916239	1453918039	1	172.16.30.60	1	1453916239	\N	\N
2416	468	1453916335	1453918135	1	172.16.14.22	2	1453916550	\N	\N
2417	162	1453918583	1453920383	1	172.16.31.37	1	1453918583	\N	\N
2418	467	1453918960	1453920760	1	172.16.10.10	1	1453918960	\N	\N
2419	68	1453918981	1453920781	1	172.16.19.17	1	1453918981	\N	\N
2420	11	1453919600	1453921400	1	172.16.20.25	1	1453919600	\N	\N
2421	437	1453919776	1453921576	1	::1	1	1453919776	\N	\N
2423	162	1453925120	1453926920	1	172.16.31.38	1	1453925120	\N	\N
2422	467	1453923171	1453924971	0	172.16.10.10	1	1453923171	\N	\N
2424	467	1453925211	1453927011	1	172.16.10.10	2	1453926227	\N	\N
2425	467	1453978999	1453980799	1	172.16.10.10	1	1453978999	\N	\N
2426	467	1453985645	1453987445	1	172.16.10.10	1	1453985645	\N	\N
2427	143	1453986195	1453987995	0	172.16.31.38	2	1453987061	1453987316	172.16.31.38
2428	143	1453987329	1453989129	0	172.16.31.38	1	1453987329	1453987419	172.16.31.38
2430	471	1453987897	1453989697	1	172.16.11.20	1	1453987897	\N	\N
2429	143	1453987429	1453989229	0	172.16.31.38	1	1453987429	1453987952	172.16.31.38
2431	275	1453995061	1453996861	1	192.168.0.7	1	1453995061	\N	\N
2432	453	1453997251	1453999051	1	172.16.12.32	1	1453997251	\N	\N
2433	41	1453997316	1453999116	1	172.16.13.14	2	1453997991	\N	\N
2439	467	1454006836	1454008636	0	172.16.10.10	2	1454008278	\N	\N
2441	468	1454007154	1454008954	0	172.16.20.13	1	1454007154	1454007286	172.16.20.13
2442	468	1454007295	1454009095	0	172.16.20.13	1	1454007295	1454007319	172.16.20.13
2443	468	1454007328	1454009128	1	172.16.20.20	1	1454007328	\N	\N
2437	397	1454005728	1454007528	0	172.16.30.34	1	1454005728	\N	\N
2449	275	1454009045	1454010845	0	172.16.31.38	1	1454009045	1454009153	172.16.31.38
2445	470	1454008273	1454010073	0	172.16.30.60	1	1454008273	1454008286	172.16.30.60
2446	11	1454008296	1454010096	0	172.16.30.60	1	1454008296	1454008316	172.16.30.60
2454	470	1454009317	1454011117	0	172.16.20.19	1	1454009317	1454009324	172.16.20.19
2455	68	1454009376	1454011176	0	172.16.19.17	1	1454009376	1454009392	172.16.19.17
2438	162	1454006580	1454008380	0	172.16.31.37	4	1454007402	\N	\N
2447	470	1454008319	1454010119	0	172.16.20.19	2	1454008879	1454008894	172.16.20.19
2444	397	1454007759	1454009559	0	172.16.30.34	1	1454007759	\N	\N
2457	397	1454009590	1454011390	0	172.16.30.34	1	1454009590	1454009637	172.16.30.34
2448	11	1454008907	1454010707	0	172.16.31.38	2	1454009010	1454009035	172.16.31.38
2451	404	1454009267	1454011067	0	172.16.14.53	1	1454009267	1454009297	172.16.14.53
2462	275	1454010655	1454012455	0	172.16.31.37	1	1454010655	1454010717	172.16.31.37
2458	401	1454009805	1454011605	0	172.16.0.2	1	1454009805	1454010276	172.16.0.2
2460	397	1454010244	1454012044	0	172.16.30.34	1	1454010244	1454010321	172.16.30.34
2467	397	1454011663	1454013463	0	172.16.30.34	1	1454011663	\N	\N
2456	162	1454009483	1454011283	0	172.16.31.37	1	1454009483	1454010519	172.16.31.37
2461	162	1454010530	1454012330	0	172.16.31.37	1	1454010530	1454010638	172.16.31.37
2463	162	1454010733	1454012533	1	172.16.31.37	1	1454010733	\N	\N
2450	467	1454009113	1454010913	0	172.16.10.10	3	1454010479	\N	\N
2453	404	1454009315	1454011115	0	172.16.14.53	3	1454010477	\N	\N
2466	404	1454011191	1454012991	0	172.16.14.53	2	1454011609	\N	\N
2468	143	1454012588	1454014388	0	172.16.31.38	1	1454012588	1454013095	172.16.31.38
2464	275	1454011040	1454012840	0	192.168.0.7	2	1454012066	1454012321	192.168.0.7
2459	37	1454010063	1454011863	0	172.16.30.37	2	1454011159	\N	\N
2511	470	1454089194	1454090994	0	172.16.30.60	2	1454089740	\N	\N
2474	453	1454014277	1454016077	0	172.16.12.10	1	1454014277	\N	\N
2497	437	1454078419	1454080219	0	172.16.20.20	2	1454079987	\N	\N
2476	453	1454016119	1454017919	0	172.16.12.10	2	1454016936	1454017332	172.16.12.10
2477	437	1454018629	1454020429	0	172.16.20.19	1	1454018629	1454018706	172.16.20.19
2478	355	1454018734	1454020534	0	172.16.20.19	1	1454018734	1454018911	172.16.20.19
2479	11	1454018936	1454020736	0	172.16.20.19	1	1454018936	1454019230	172.16.20.19
2480	440	1454019753	1454021553	0	172.16.28.51	1	1454019753	1454021385	172.16.28.51
2500	355	1454080381	1454082181	0	172.16.20.29	1	1454080381	1454080444	172.16.20.29
2518	470	1454091489	1454093289	1	172.16.30.60	1	1454091489	\N	\N
2501	467	1454081161	1454082961	0	172.16.10.10	1	1454081161	\N	\N
2505	183	1454083346	1454085146	0	192.168.0.7	1	1454083346	1454084868	192.168.0.7
2504	470	1454082390	1454084190	0	172.16.30.60	1	1454082390	\N	\N
2509	470	1454084907	1454086707	1	172.16.30.60	1	1454084907	\N	\N
2481	22	1454039313	1454041113	0	192.168.0.7	3	1454040933	\N	\N
2482	22	1454041600	1454043400	0	192.168.0.7	1	1454041600	1454042639	192.168.0.7
2483	467	1454065267	1454067067	1	172.16.10.10	1	1454065267	\N	\N
2484	22	1454067752	1454069552	0	192.168.0.7	1	1454067752	1454067790	192.168.0.7
2485	22	1454067816	1454069616	1	192.168.0.7	1	1454067816	\N	\N
2486	467	1454070326	1454072126	1	172.16.10.10	1	1454070326	\N	\N
2488	404	1454072485	1454074285	1	172.16.14.53	1	1454072485	\N	\N
2489	183	1454072638	1454074438	1	192.168.0.7	1	1454072638	\N	\N
2487	468	1454072106	1454073906	0	172.16.14.22	1	1454072106	\N	\N
2490	468	1454074010	1454075810	1	172.16.14.22	1	1454074010	\N	\N
2491	143	1454075329	1454077129	1	172.16.31.38	1	1454075329	\N	\N
2492	54	1454076285	1454078085	0	172.16.13.19	2	1454076808	1454076836	172.16.13.19
2508	467	1454083688	1454085488	0	172.16.10.10	1	1454083688	1454085325	172.16.10.10
2493	87	1454076338	1454078138	0	172.16.30.10	2	1454077260	1454077578	172.16.30.10
2496	87	1454077588	1454079388	0	172.16.30.10	1	1454077588	1454077598	172.16.30.10
2494	11	1454076660	1454078460	1	172.16.20.25	2	1454077834	\N	\N
2520	37	1454092782	1454094582	1	172.16.30.37	1	1454092782	\N	\N
2507	68	1454083502	1454085302	0	172.16.19.17	2	1454085262	\N	\N
2510	470	1454089171	1454090971	0	172.16.30.60	1	1454089171	1454089178	172.16.30.60
2465	467	1454011068	1454012868	0	172.16.10.10	4	1454012527	\N	\N
2470	37	1454013236	1454015036	1	172.16.30.37	1	1454013236	\N	\N
2471	397	1454013575	1454015375	0	172.16.30.34	1	1454013575	1454013686	172.16.30.34
2512	355	1454089344	1454091144	1	172.16.20.25	1	1454089344	\N	\N
2472	440	1454013865	1454015665	0	172.16.28.51	1	1454013865	1454014087	172.16.28.51
2473	440	1454014143	1454015943	0	172.16.28.51	1	1454014143	1454014380	172.16.28.51
2513	453	1454089617	1454091417	0	172.16.12.10	1	1454089617	1454089836	172.16.12.10
2495	468	1454077102	1454078902	0	172.16.28.16	1	1454077102	\N	\N
2514	442	1454090444	1454092244	0	172.16.20.19	1	1454090444	1454090502	172.16.20.19
2499	437	1454080317	1454082117	0	172.16.20.20	1	1454080317	1454081612	172.16.20.20
2469	467	1454013070	1454014870	0	172.16.10.10	2	1454014048	\N	\N
2475	467	1454015106	1454016906	0	172.16.10.10	1	1454015106	1454015214	172.16.10.10
2498	468	1454079060	1454080860	0	172.16.28.16	1	1454079060	\N	\N
2503	355	1454081621	1454083421	0	172.16.20.20	1	1454081621	1454081626	172.16.20.20
2515	443	1454090530	1454092330	0	172.16.20.19	1	1454090530	1454090550	172.16.20.19
2516	11	1454090751	1454092551	1	172.16.20.19	1	1454090751	\N	\N
2517	468	1454091163	1454092963	0	172.16.18.20	1	1454091163	1454091373	172.16.18.20
2521	183	1454093299	1454095099	1	192.168.0.7	1	1454093299	\N	\N
2522	468	1454094121	1454095921	1	172.16.28.16	1	1454094121	\N	\N
2523	355	1454094383	1454096183	1	172.16.20.25	1	1454094383	\N	\N
2502	468	1454081617	1454083417	0	172.16.28.16	2	1454082416	\N	\N
2506	468	1454083442	1454085242	0	172.16.28.16	1	1454083442	1454083490	172.16.28.16
2528	467	1454099973	1454101773	0	172.16.10.10	1	1454099973	\N	\N
2519	467	1454092632	1454094432	0	172.16.10.10	3	1454094410	\N	\N
2530	11	1454101742	1454103542	0	172.16.20.25	1	1454101742	1454101948	172.16.20.25
2525	397	1454094527	1454096327	0	172.16.30.37	1	1454094527	1454095125	172.16.30.37
2526	37	1454095137	1454096937	1	172.16.30.37	1	1454095137	\N	\N
2529	114	1454100622	1454102422	0	172.16.18.10	1	1454100622	1454101994	172.16.18.10
2524	467	1454094469	1454096269	0	172.16.10.10	1	1454094469	\N	\N
2632	462	1455223420	1455225220	0	::1	1	1455223420	1455223463	::1
2536	437	1454335530	1454337330	0	172.16.20.21	2	1454336171	1454336464	172.16.20.21
2533	467	1454106145	1454107945	0	172.16.10.10	2	1454107645	1454107706	172.16.10.10
2531	467	1454101861	1454103661	0	172.16.10.10	1	1454101861	\N	\N
2534	11	1454264484	1454266284	0	192.168.0.7	1	1454264484	1454264682	192.168.0.7
2535	467	1454329887	1454331687	1	172.16.10.10	1	1454329887	\N	\N
2532	467	1454104225	1454106025	0	172.16.10.10	2	1454105630	\N	\N
2537	355	1454337701	1454339501	1	172.16.20.21	1	1454337701	\N	\N
2538	11	1454337777	1454339577	1	172.16.20.25	1	1454337777	\N	\N
2539	230	1454337779	1454339579	1	172.16.11.21	1	1454337779	\N	\N
2541	22	1454339371	1454341171	1	192.168.0.7	1	1454339371	\N	\N
2540	68	1454337990	1454339790	0	172.16.19.17	2	1454339326	\N	\N
2544	37	1454340660	1454342460	0	172.16.30.37	1	1454340660	1454341298	172.16.30.37
2543	397	1454340603	1454342403	0	172.16.30.37	1	1454340603	1454340645	172.16.30.37
2545	401	1454340815	1454342615	1	172.16.0.2	1	1454340815	\N	\N
2546	397	1454341311	1454343111	1	172.16.30.37	1	1454341311	\N	\N
2542	68	1454339866	1454341666	0	172.16.19.17	3	1454340791	\N	\N
2548	437	1454343414	1454345214	0	172.16.20.13	1	1454343414	1454343425	172.16.20.13
2598	275	1454512870	1454514670	0	192.168.0.7	1	1454512870	1454512982	192.168.0.7
2549	355	1454343433	1454345233	0	172.16.20.13	1	1454343433	1454343737	172.16.20.13
2600	449	1454513083	1454514883	0	172.16.13.16	1	1454513083	1454513573	172.16.13.16
2602	355	1454513613	1454515413	0	172.16.20.25	1	1454513613	1454513695	172.16.20.25
2547	68	1454341887	1454343687	0	172.16.19.17	3	1454343429	\N	\N
2550	68	1454343780	1454345580	1	172.16.19.17	1	1454343780	\N	\N
2582	467	1454437759	1454439559	0	172.16.10.10	2	1454438434	\N	\N
2583	162	1454439738	1454441538	1	172.16.31.37	1	1454439738	\N	\N
2584	143	1454439809	1454441609	1	172.16.31.38	1	1454439809	\N	\N
2585	275	1454440138	1454441938	0	192.168.0.7	1	1454440138	1454440511	192.168.0.7
2586	467	1454442221	1454444021	1	172.16.10.10	1	1454442221	\N	\N
2552	437	1454348284	1454350084	0	172.16.20.25	4	1454348750	1454348755	172.16.20.13
2553	437	1454348769	1454350569	1	172.16.20.25	1	1454348769	\N	\N
2555	405	1454348854	1454350654	0	172.16.20.13	1	1454348854	1454348861	172.16.20.13
2556	405	1454349015	1454350815	0	172.16.20.13	1	1454349015	1454349022	172.16.20.13
2551	467	1454347179	1454348979	0	172.16.10.10	2	1454347572	\N	\N
2557	467	1454349539	1454351339	1	172.16.10.10	1	1454349539	\N	\N
2559	11	1454350214	1454352014	0	172.16.10.10	1	1454350214	1454350259	172.16.10.10
2558	405	1454349929	1454351729	0	172.16.20.25	1	1454349929	1454350439	172.16.20.25
2560	397	1454350639	1454352439	0	172.16.16.12	1	1454350639	1454350978	172.16.16.12
2562	467	1454351437	1454353237	1	172.16.10.10	1	1454351437	\N	\N
2561	68	1454351385	1454353185	0	172.16.19.17	1	1454351385	1454351529	172.16.19.17
2554	1	1454348851	1454350651	0	172.16.20.21	1	1454348851	\N	\N
2563	437	1454351919	1454353719	0	172.16.20.21	1	1454351919	1454351924	172.16.20.21
2564	355	1454351939	1454353739	0	172.16.20.21	1	1454351939	1454352136	172.16.20.21
2565	11	1454352507	1454354307	1	172.16.20.25	1	1454352507	\N	\N
2566	404	1454353949	1454355749	0	172.16.14.53	1	1454353949	1454354955	172.16.14.53
2567	162	1454355636	1454357436	1	172.16.31.37	1	1454355636	\N	\N
2587	1	1454508402	1454510202	0	172.16.20.25	1	1454508402	1454508407	172.16.20.25
2568	143	1454355640	1454357440	0	172.16.31.38	2	1454356643	1454356677	172.16.31.38
2569	275	1454356719	1454358519	0	172.16.31.38	1	1454356719	1454356819	172.16.31.38
2570	143	1454356845	1454358645	0	172.16.31.38	1	1454356845	1454357375	172.16.31.38
2571	143	1454357387	1454359187	0	172.16.31.38	1	1454357387	1454357586	172.16.31.38
2572	467	1454357649	1454359449	1	172.16.10.10	1	1454357649	\N	\N
2573	143	1454358246	1454360046	0	172.16.20.19	1	1454358246	1454358271	172.16.20.19
2574	143	1454358571	1454360371	0	172.16.31.38	1	1454358571	1454358600	172.16.31.38
2575	275	1454362148	1454363948	1	192.168.0.7	1	1454362148	\N	\N
2576	355	1454364461	1454366261	0	192.168.0.7	1	1454364461	1454364895	192.168.0.7
2577	11	1454418635	1454420435	0	172.16.20.25	1	1454418635	1454418647	172.16.20.25
2578	11	1454418659	1454420459	1	172.16.20.25	1	1454418659	\N	\N
2579	437	1454418955	1454420755	1	172.16.20.21	1	1454418955	\N	\N
2580	162	1454434787	1454436587	0	172.16.31.37	1	1454434787	1454434873	172.16.31.37
2581	68	1454435669	1454437469	1	172.16.19.17	1	1454435669	\N	\N
2588	68	1454511100	1454512900	0	172.16.19.17	1	1454511100	1454511112	172.16.19.17
2589	11	1454511161	1454512961	0	172.16.20.25	1	1454511161	1454511231	172.16.20.25
2591	437	1454511347	1454513147	0	172.16.20.19	1	1454511347	1454511406	172.16.20.19
2592	401	1454511521	1454513321	1	172.16.0.2	1	1454511521	\N	\N
2603	449	1454514465	1454516265	0	172.16.13.16	1	1454514465	1454514496	172.16.13.16
2590	11	1454511278	1454513078	0	172.16.20.25	2	1454511767	1454511770	172.16.20.25
2593	437	1454511788	1454513588	0	172.16.20.25	1	1454511788	1454511826	172.16.20.25
2594	355	1454511832	1454513632	0	172.16.20.25	1	1454511832	1454511851	172.16.20.25
2595	437	1454511859	1454513659	0	172.16.20.25	1	1454511859	1454511923	172.16.20.25
2596	437	1454511924	1454513724	0	172.16.20.19	1	1454511924	1454511947	172.16.20.19
2597	404	1454512116	1454513916	0	172.16.14.53	1	1454512116	1454512575	172.16.14.53
2599	11	1454512972	1454514772	1	172.16.20.25	1	1454512972	\N	\N
2605	449	1454515596	1454517396	0	172.16.13.16	1	1454515596	1454515628	172.16.13.16
2606	449	1454516148	1454517948	0	172.16.20.25	1	1454516148	1454516156	172.16.20.25
2607	41	1454516172	1454517972	1	172.16.20.25	1	1454516172	\N	\N
2608	449	1454516243	1454518043	1	172.16.20.25	1	1454516243	\N	\N
2601	41	1454513277	1454515077	0	172.16.13.14	2	1454513992	\N	\N
2604	41	1454515240	1454517040	0	172.16.13.14	1	1454515240	1454515574	172.16.13.14
2631	462	1455223197	1455224997	0	::1	1	1455223197	1455223415	::1
2527	467	1454097745	1454099545	0	172.16.10.10	1	1454097745	\N	\N
2609	437	1454531066	1454532866	0	::1	1	1454531066	1454531092	::1
2610	355	1454531101	1454532901	1	::1	1	1454531101	\N	\N
2613	11	1454679256	1454681056	1	127.0.0.1	1	1454679256	\N	\N
2611	437	1454679007	1454680807	1	::1	2	1454679724	\N	\N
2612	355	1454679237	1454681037	1	127.0.0.1	3	1454680373	\N	\N
2614	22	1454680396	1454682196	1	::1	1	1454680396	\N	\N
2615	437	1454684720	1454686520	1	::1	1	1454684720	\N	\N
2616	355	1454684725	1454686525	1	::1	1	1454684725	\N	\N
2617	22	1454685258	1454687058	1	127.0.0.1	1	1454685258	\N	\N
2619	355	1454689026	1454690826	1	::1	1	1454689026	\N	\N
2620	22	1454689060	1454690860	1	127.0.0.1	1	1454689060	\N	\N
2633	462	1455223468	1455225268	0	::1	1	1455223468	1455223958	::1
2618	437	1454688531	1454690331	0	::1	3	1454689826	1454689867	::1
2621	437	1454694905	1454696705	1	::1	2	1454695821	\N	\N
2623	355	1454709526	1454711326	1	::1	1	1454709526	\N	\N
2622	437	1454709256	1454711056	1	::1	2	1454709876	\N	\N
2624	11	1454709897	1454711697	1	127.0.0.1	1	1454709897	\N	\N
2625	437	1455112413	1455114213	1	::1	1	1455112413	\N	\N
2626	462	1455220318	1455222118	0	::1	1	1455220318	1455220321	::1
2634	11	1455224000	1455225800	1	::1	1	1455224000	\N	\N
2643	462	1455231487	1455233287	0	::1	1	1455231487	1455231634	::1
2628	437	1455220591	1455222391	0	::1	3	1455222160	1455222173	::1
2650	355	1455639474	1455641274	0	::1	1	1455639474	1455639481	::1
2630	1	1455222374	1455224174	0	::1	4	1455224083	\N	\N
2636	1	1455224923	1455226723	0	::1	1	1455224923	1455225240	::1
2627	1	1455220551	1455222351	0	::1	2	1455222183	\N	\N
2642	1	1455230567	1455232367	0	::1	3	1455231705	1455232040	::1
2629	462	1455222324	1455224124	0	::1	2	1455222930	1455223191	::1
2637	1	1455225246	1455227046	0	::1	4	1455226396	\N	\N
2638	462	1455226431	1455228231	0	::1	1	1455226431	\N	\N
2635	462	1455224912	1455226712	0	::1	2	1455225630	1455226425	::1
2644	437	1455285191	1455286991	1	::1	1	1455285191	\N	\N
2646	11	1455301401	1455303201	1	127.0.0.1	1	1455301401	\N	\N
2645	355	1455301112	1455302912	1	::1	2	1455302006	\N	\N
2640	462	1455228578	1455230378	0	::1	2	1455229139	1455230110	::1
2639	1	1455228296	1455230096	0	::1	1	1455228296	\N	\N
2647	437	1455302018	1455303818	1	::1	1	1455302018	\N	\N
2641	462	1455230124	1455231924	0	::1	2	1455231133	1455231478	::1
2648	1	1455303294	1455305094	1	::1	1	1455303294	\N	\N
2649	437	1455639461	1455641261	0	::1	1	1455639461	1455639468	::1
2651	1	1455639488	1455641288	1	::1	2	1455639863	\N	\N
2652	1	1455646108	1455647908	0	::1	2	1455646701	1455647815	::1
2653	437	1455647821	1455649621	1	::1	2	1455648419	\N	\N
2654	437	1455652986	1455654786	0	::1	2	1455653818	1455654335	::1
2655	11	1455654342	1455656142	0	::1	1	1455654342	1455654349	::1
2656	355	1455654355	1455656155	0	::1	1	1455654355	1455654442	::1
2657	11	1455654462	1455656262	1	::1	1	1455654462	\N	\N
2658	355	1455654547	1455656347	0	::1	1	1455654547	1455654563	::1
2659	437	1455654567	1455656367	0	::1	1	1455654567	1455654604	::1
2660	1	1455715763	1455717563	1	::1	2	1455716352	\N	\N
2661	1	1455719298	1455721098	1	::1	1	1455719298	\N	\N
2662	437	1455721297	1455723097	0	::1	2	1455721802	1455722513	::1
2663	1	1455722518	1455724318	0	::1	1	1455722518	1455722535	::1
2665	437	1455801082	1455802882	1	::1	1	1455801082	\N	\N
2666	437	1455803632	1455805432	1	::1	2	1455804049	\N	\N
2668	1	1455823976	1455825776	1	::1	1	1455823976	\N	\N
2689	355	1455895536	1455897336	1	::1	1	1455895536	\N	\N
2667	437	1455823839	1455825639	0	::1	3	1455825364	1455825371	::1
2669	355	1455825376	1455827176	1	::1	1	1455825376	\N	\N
2670	437	1455825507	1455827307	0	::1	1	1455825507	1455825511	::1
2671	11	1455825517	1455827317	1	::1	1	1455825517	\N	\N
2687	11	1455895032	1455896832	0	127.0.0.1	2	1455896411	\N	\N
2697	11	1455904909	1455906709	0	::1	1	1455904909	\N	\N
2672	355	1455888316	1455890116	0	::1	1	1455888316	\N	\N
2673	437	1455890531	1455892331	0	::1	1	1455890531	1455890540	::1
2674	11	1455890545	1455892345	0	::1	1	1455890545	1455890564	::1
2675	1	1455890569	1455892369	0	::1	1	1455890569	1455890830	::1
2698	437	1455907855	1455909655	0	::1	1	1455907855	1455908414	::1
2699	437	1455908421	1455910221	1	::1	1	1455908421	\N	\N
2676	11	1455890836	1455892636	0	::1	1	1455890836	\N	\N
2677	11	1455892729	1455894529	0	::1	1	1455892729	1455892753	::1
2678	1	1455892757	1455894557	0	::1	1	1455892757	1455892853	::1
2679	437	1455892859	1455894659	0	::1	1	1455892859	1455893057	::1
2690	11	1455896882	1455898682	0	127.0.0.1	2	1455897917	\N	\N
2692	355	1455900074	1455901874	1	::1	1	1455900074	\N	\N
2681	11	1455893113	1455894913	0	::1	2	1455893146	1455893149	::1
2691	11	1455898690	1455900490	0	127.0.0.1	2	1455899968	\N	\N
2694	11	1455900599	1455902399	0	127.0.0.1	2	1455901231	\N	\N
2680	355	1455893061	1455894861	0	::1	2	1455893169	1455893173	::1
2685	1	1455893661	1455895461	0	127.0.0.1	1	1455893661	1455893879	127.0.0.1
2686	1	1455893909	1455895709	0	127.0.0.1	1	1455893909	1455894056	127.0.0.1
2695	11	1455902405	1455904205	0	127.0.0.1	1	1455902405	1455902448	127.0.0.1
2693	437	1455900084	1455901884	0	::1	1	1455900084	\N	\N
2682	11	1455893160	1455894960	0	127.0.0.1	2	1455894067	\N	\N
2683	437	1455893179	1455894979	0	::1	2	1455894793	\N	\N
2688	437	1455895045	1455896845	1	::1	1	1455895045	\N	\N
2684	355	1455893195	1455894995	0	::1	1	1455893195	\N	\N
2696	11	1455902470	1455904270	0	::1	5	1455903081	\N	\N
2702	437	1456114067	1456115867	0	127.0.0.1	1	1456114067	\N	\N
2664	437	1455722540	1455724340	0	::1	1	1455722540	\N	\N
2700	437	1456105275	1456107075	0	127.0.0.1	1	1456105275	1456105291	127.0.0.1
2701	1	1456105303	1456107103	0	127.0.0.1	1	1456105303	\N	\N
2703	462	1456116974	1456118774	0	127.0.0.1	1	1456116974	1456117016	127.0.0.1
2704	1	1456117027	1456118827	0	127.0.0.1	1	1456117027	1456117069	127.0.0.1
2705	462	1456117076	1456118876	0	127.0.0.1	2	1456118293	\N	\N
2706	462	1456119048	1456120848	0	127.0.0.1	2	1456120015	\N	\N
2707	462	1456122408	1456124208	0	127.0.0.1	1	1456122408	\N	\N
2708	462	1456124235	1456126035	0	127.0.0.1	1	1456124235	\N	\N
2709	462	1456126424	1456128224	0	127.0.0.1	3	1456127313	\N	\N
2710	462	1456128425	1456130225	1	127.0.0.1	1	1456128425	\N	\N
2711	462	1456131922	1456133722	0	127.0.0.1	1	1456131922	\N	\N
2712	462	1456134072	1456135872	0	127.0.0.1	1	1456134072	\N	\N
2713	462	1456696527	1456698327	1	127.0.0.1	1	1456696527	\N	\N
2714	437	1457599609	1457601409	0	127.0.0.1	2	1457600438	\N	\N
2715	462	1457601897	1457603697	1	127.0.0.1	1	1457601897	\N	\N
2716	437	1457602803	1457604603	1	127.0.0.1	1	1457602803	\N	\N
2717	462	1457603801	1457605601	1	127.0.0.1	1	1457603801	\N	\N
2733	437	1458444148	1458445948	0	127.0.0.1	1	1458444148	\N	\N
2718	437	1457663691	1457665491	0	127.0.0.1	2	1457664288	\N	\N
2719	462	1457666691	1457668491	0	127.0.0.1	1	1457666691	\N	\N
2720	462	1457668556	1457670356	0	127.0.0.1	1	1457668556	\N	\N
2721	462	1457670624	1457672424	0	127.0.0.1	1	1457670624	\N	\N
2722	462	1457672529	1457674329	1	127.0.0.1	1	1457672529	\N	\N
2723	462	1457678307	1457680107	0	127.0.0.1	2	1457679363	\N	\N
2724	462	1457680761	1457682561	0	127.0.0.1	2	1457682031	\N	\N
2725	462	1457684196	1457685996	0	127.0.0.1	1	1457684196	\N	\N
2734	437	1458451693	1458453493	0	127.0.0.1	2	1458453157	\N	\N
2726	462	1457686629	1457688429	0	127.0.0.1	2	1457688355	\N	\N
2727	462	1457688940	1457690740	0	127.0.0.1	1	1457688940	\N	\N
2735	437	1458453621	1458455421	0	127.0.0.1	3	1458454516	\N	\N
2736	437	1458455741	1458457541	0	127.0.0.1	1	1458455741	1458455866	127.0.0.1
2728	462	1457691588	1457693388	0	127.0.0.1	3	1457692838	\N	\N
2729	437	1458432290	1458434090	0	127.0.0.1	1	1458432290	1458432390	127.0.0.1
2730	1	1458432398	1458434198	0	127.0.0.1	1	1458432398	1458432767	127.0.0.1
2731	437	1458432773	1458434573	1	127.0.0.1	1	1458432773	\N	\N
2732	437	1458438755	1458440555	1	127.0.0.1	1	1458438755	\N	\N
2737	437	1458455871	1458457671	0	127.0.0.1	1	1458455871	1458456312	127.0.0.1
2738	355	1458456324	1458458124	0	127.0.0.1	1	1458456324	1458456354	127.0.0.1
2739	462	1458456363	1458458163	0	127.0.0.1	1	1458456363	1458456380	127.0.0.1
2740	437	1458456386	1458458186	0	127.0.0.1	3	1458457716	\N	\N
2741	437	1458458329	1458460129	0	127.0.0.1	1	1458458329	1458458602	127.0.0.1
2742	355	1458458612	1458460412	0	127.0.0.1	1	1458458612	1458458654	127.0.0.1
2743	462	1458458660	1458460460	0	127.0.0.1	1	1458458660	1458458721	127.0.0.1
2744	437	1458458727	1458460527	1	127.0.0.1	1	1458458727	\N	\N
\.


--
-- Name: cruge_session_idsession_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cruge_session_idsession_seq', 2744, true);


--
-- Data for Name: cruge_system; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_system (idsystem, name, largename, sessionmaxdurationmins, sessionmaxsameipconnections, sessionreusesessions, sessionmaxsessionsperday, sessionmaxsessionsperuser, systemnonewsessions, systemdown, registerusingcaptcha, registerusingterms, terms, registerusingactivation, defaultroleforregistration, registerusingtermslabel, registrationonlogin) FROM stdin;
1	default	\N	30	10	1	-1	-1	0	0	0	0		0			1
\.


--
-- Name: cruge_system_idsystem_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cruge_system_idsystem_seq', 1, false);


--
-- Data for Name: cruge_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cruge_user (iduser, regdate, actdate, logondate, username, email, password, authkey, state, totalsessioncounter, currentsessioncounter, id_persona) FROM stdin;
2	\N	\N	\N	invitado	invitado	nopassword	\N	1	0	0	\N
18	1428421189	1428421189	1428421189	16027739	16027739@minmujer.gob.ve	f13b33470e6730a7300db5b906d8fdcb	\N	1	0	0	\N
13	1426610514	1426610514	1429801086	17588499	17588499@minmujer.gob.ve	4e4b8e1ae8eab53f1edfdaaf0d9dfd52	\N	1	0	0	\N
34	1437501919	1437501919	1437502775	16029322	16029322@minmujer.gob.ve	e96c63dcaf3a2464f64ac8d6dfe135ea	\N	1	0	0	\N
35	1437578869	1437578869	1437578869	19966524	19966524@minmujer.gob.ve	59bd2157795e2271c2a0f838024679e1	\N	1	0	0	\N
12	1426514089	1426514089	1436804548	19527324	19527324@minmujer.gob.ve	3fa0035bc20dab1adf74e428e6827e32	\N	1	0	0	\N
451	1447182103	\N	\N	16581185	rmadriz@minmujer.gob.ve	67e5ae8f3baa711f7e9f4cea407c4d3e	de9555ce008d91678ed2fe38fe77b6ad	2	0	0	2181
57	1438175320	1438175320	1438175320	10116219	10116219@minmujer.gob.ve	464494c508664753654c8904d5099bd0	\N	1	0	0	1050
4	1426193656	1426193656	1440083739	84387171	84387171@gmai.com	bfeaa1d8875ab97df989088273f502a9	\N	1	0	0	\N
458	1447785132	\N	1448292006	9482100	icarrabbia@minmujer.gob.ve	8b0e1741c32afc192757e9d66b1dfa0c	71cf3bddc54221f81fae17c25e67badd	1	0	0	4221
438	1446660593	1446660593	1446660594	16286932	16286932@minmujer.gob.ve	55a69bbbe459e7313d9b9ebdee7dbbf7	\N	1	0	0	2141
452	1447182171	\N	\N	11409862	jblanco@minmujer.gob.ve	c76ed13e7bb313d7305b5dede1209159	8cd89ffe47f8b8a65cc4d88e03787c3c	2	0	0	3757
86	1438270422	1438270422	1438272658	4819761	4819761@minmujer.gob.ve	294ed910821e6644abc21e26177f366a	\N	1	0	0	1218
93	1438278366	1438278366	1438278367	15586583	15586583@minmujer.gob.ve	7c2de0e190c7ffee83fb71751882d591	\N	1	0	0	2541
84	1438267088	1438267088	1438268063	15801033	15801033@minmujer.gob.ve	d26b5f79284859549591ae4deb939c42	\N	1	0	0	3589
444	1447098737	\N	\N	14779314	amoreno@minmujer.gob.ve	97f3c33c08143676cc6e7063c9c1be79	d2ae6d31c201487dd6112a1b97ce1146	1	0	0	2213
140	1438788001	1438788001	1438788001	15115104	15115104@minmujer.gob.ve	f9a1c8be669f63acdcaf1c916bc808d9	\N	1	0	0	\N
142	1438788112	1438788112	1438788112	12301887	12301887@minmujer.gob.ve	a9d8311f4e8f5911d524335e656ed77b	\N	1	0	0	\N
131	1438635223	1438635223	1438884311	16359593	16359593@minmujer.gob.ve	65a821e1564f80f493393723213599c1	\N	1	0	0	1191
445	1447099106	\N	\N	9867241	fgranadillo@minmujer.gob.ve	be7c72377ab3180f31d1cf35a3693db0	23fc24a4ba64750f4355efa7089b5dd3	1	0	0	4591
173	1438884179	1438884179	1438885277	19672320	19672320@minmujer.gob.ve	bfab19ef404c02a8f3e489a6eb17f549	\N	1	0	0	\N
167	1438805037	1438805037	1438806818	6243278	6243278@minmujer.gob.ve	9b282b703089c6f65d3272445702b8d9	\N	1	0	0	\N
165	1438803274	1438803274	1438887624	6309927	6309927@minmujer.gob.ve	6fe05a460a046c8f78ee83e25a922072	\N	1	0	0	657
212	1439397942	1439397942	1439403328	84571087	84571087@minmujer.gob.ve	75d01a7dc8b8a4afe16b7ded0fa2571f	\N	1	0	0	\N
229	1439410700	1439410700	1439419073	6440154	6440154@minmujer.gob.ve	657eabfd4116a698da1e08073d22627a	\N	1	0	0	4322
455	1447185127	\N	\N	17255775	sbarrada@minmujer.gob.ve	13a426dd8e5fc28c9d21301bab596027	ff8ccaf0f4e7e43747361512957c9549	1	0	0	4231
256	1439478178	1439478178	1439566329	15662117	15662117@minmujer.gob.ve	e64bea2405096ba6286e264c464230bb	\N	1	0	0	3987
360	1439827815	1439827815	1439827816	5826610	5826610@minmujer.gob.ve	d479025f6b7d6b84f129947f45d757dd	\N	1	0	0	864
300	1439559839	1439559839	1439565011	8546491	8546491@minmujer.gob.ve	5096529063b4bbeb43bfa3613dcecb16	\N	1	0	0	795
456	1447185511	\N	\N	14897943	jlopez@minmujer.gob.ve	4f8bc3e85ab0ef35d8fa4bb2e255da2b	c243af8c7c39b0980946bed29c6d4c92	1	0	0	2653
463	1449067074	1449067074	1449067074	16922608	16922608@minmujer.gob.ve	652d1e3e5c96059a15149f1cf5f521c4	\N	1	0	0	4601
10	1426273722	1426273722	1446668845	84387171	18141986@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	3496
461	1449063558	1449063558	1453902263	21092594	21092594@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	4611
454	1447184998	\N	1453832371	18535027	imaza@minmujer.gob.ve	f20e44b6b66f5e4579b580c1bcd4dda4	bac412da35a36699863288596dee968b	1	0	0	976
460	1449063532	1449063532	1453744044	18712298	jrondon@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	4543
443	1447098236	\N	1454090530	8246451	egarcia@minmujer.gob.ve	5598c6a8a965b17372e5272a1daa3fff	fa6b1c1fa84b78d0ce2f1cf7336e5f75	1	0	0	3312
457	1447610486	1447610486	1447610487	17287091	17287091@minmujer.gob.ve	4d9bf7794d3c890998c2e7d4505c7f30	\N	1	0	0	2882
397	1441113189	1441113189	1454350639	16202211	16202211@minmujer.gob.ve	203e9505a6485d03fe4d6c4c90f339bb	\N	1	0	0	3822
464	1452708463	1452708463	1452708805	4114842	4114842@minmujer.gob.ve	fab22a55359c40572cee9d4c9b536dd3	\N	1	0	0	969
439	1446845539	\N	1453832427	23169533	mblanco@minmujer.gob.ve	57dfe1bf4403b3a3c9d506ca3a0ccf2a	4162f407df6009ba85b48d2f529c1e6e	1	0	0	3182
68	1438178716	1438178716	1454511100	18134504	18134504@minmujer.gob.ve	0f36c96775a2158035d713c328bf2ff1	\N	1	0	0	2649
280	1439495087	1439495087	1453837469	10986121	jhernandez@minmujer.gob.ve	db47aa1861524e2ac70a733e2563b485	\N	1	0	0	754
21	1433444003	1433444003	1453837698	6301603	mmarcano@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	2643
143	1438788175	1438788175	1454439809	14484858	14484858@minmujer.gob.ve	28e374ef74289f533ecbb2aad7757185	\N	1	0	0	1140
453	1447184595	\N	1454089617	13217158	eparedes@minmujer.gob.ve	697394f6deac276404286613fab9615d	c6a15c16e83b7ff484a711d7dc86d8b4	1	0	0	3834
313	1439566616	1439566616	1439566616	4293089	4293089@minmujer.gob.ve	24be6f78c63350e8281a8fdcfdcc0f64	\N	1	0	0	3794
447	1447102585	\N	\N	14284469	yguevara@minmujer.gob.ve	9990ef573a759fa23f1ae2b3227a6c00	6a88da8ac8ed3f0d98f319c0ba694905	1	0	0	4037
359	1439821817	1439821817	1439826425	19556263	19556263@minmujer.gob.ve	be90e4b5bc39836cf641b78c490c8143	\N	1	0	0	4277
441	1447086593	\N	\N	lenin	lrumboss@minmujer.gob.ve	5247399889c1baf78534d1218c27abbd	721b47376e4d2720b20b7b4312c36fc8	2	0	0	4545
128	1438631426	1438631426	1438799682	14542923	14542923@minmujer.gob.ve	411a7fcd5e904fd188578b329ec93fd8	\N	1	0	0	4105
448	1447102725	\N	\N	20326830	rrodriguez@minmujer.gob.ve	1622f4da2ae803f6fa899521852ef212	940456b98279f60dd23c5329a8d97c6a	1	0	0	4035
417	1444246076	1444246076	1444248088	19310995	19310995@minmujer.gob.ve	13925eb0d255d1374d26d86c38b343d1	\N	1	0	0	1961
133	1438774554	1438774554	1446746735	15709348	15709348@minmujer.gob.ve	cd1822b1bb458699ec9004ef3bdc3796	\N	1	0	0	3413
430	1445354085	1445354085	1445354086	16021063	16021063@minmujer.gob.ve	d0a204d9e9dbf8f19691593eeb5a4cc3	\N	1	0	0	1135
436	1446140825	1446140825	1446140825	19218536	19218536@minmujer.gob.ve	501815893cc5edef6190be4157229f3f	\N	1	0	0	3970
19	1428421769	1428421769	1439837828	18221250	18221250@minmujer.gob.ve	8792e982ee81a317e925b05e6f586498	\N	1	0	0	3497
431	1445354219	1445354219	1446749914	19396922	cyepez@minmujer.gob.ve	c31b418da7a9b0893ccbafb9783eacbb	\N	1	0	0	4541
429	1445093681	1445093681	1445093682	15794592	15794592@minmujer.gob.ve	3d46ab78039c623a0e09c7d3927b1e50	\N	1	0	0	3414
432	1445356634	1445356634	1445356635	20364964	20364964@minmujer.gob.ve	d1070651fdc3b56f577d82fb2f0ffcc6	\N	1	0	0	4560
415	1443633458	1443633458	1449067324	20328536	20328536@minmujer.gob.ve	c9288cceb061e57f2952f85a8de3f7f9	\N	1	0	0	4542
104	1438350299	1438350299	1438350299	21471176	21471176@minmujer.gob.ve	b4ed346116287ba8905dbc5e6083c0d4	\N	1	0	0	3753
91	1438277682	1438277682	1438277682	24905025	24905025@minmujer.gob.ve	e7511edf96ff5634b662a72f83f04969	\N	1	0	0	3758
88	1438271439	1438271439	1438271439	17312737	17312737@minmujer.gob.ve	9aa843a3471792b9bdc00ee199fd2322	\N	1	0	0	532
376	1440001853	1440001853	1442236304	7996794	7996794@minmujer.gob.ve	8bb4ab40b67a18281d8038af3f93df96	\N	1	0	0	1045
419	1444752104	1444752104	1444761074	12400945	12400945@minmujer.gob.ve	045d4171c8da29a02db9f17c0bd82b3f	\N	1	0	0	540
433	1445442469	1445442469	1445444000	14020336	14020336@minmujer.gob.ve	6c3074dc95f285fdd66825b943ed54a6	\N	1	0	0	4438
159	1438797234	1438797234	1444761909	16598510	16598510@minmujer.gob.ve	6f2313bdaf89ac715877ba7f53d500e1	\N	1	0	0	2693
434	1445458516	1445458516	1446487493	9097112	9097112@minmujer.gob.ve	544b9ceb9e078445f8aa033fe232bf3c	\N	1	0	0	4559
53	1438092933	1438092933	1438092933	17060122	17060122@minmujer.gob.ve	3bd1b279240d4b89609bf22d015f95e7	\N	1	0	0	2828
126	1438604480	1438604480	1438886830	7949642	7949642@minmujer.gob.ve	ad0ffdf3b9405da3d2496ec15a343787	\N	1	0	0	2941
428	1444929096	1444929096	1444929097	16555360	16555360@minmujer.gob.ve	57e688f7de69ce5e01cc50d5ca857122	\N	1	0	0	3254
435	1445865294	1445865294	1447599235	23651187	23651187@minmujer.gob.ve	0b8f659c01b6d4d22a8d4b0e7603eec1	\N	1	0	0	4172
171	1438880428	1438880428	1438882603	22031275	22031275@minmujer.gob.ve	afb795eac0ed63748984f2cde2928708	\N	1	0	0	3417
154	1438790877	1438790877	1438790877	13952656	13952656@minmujer.gob.ve	1cfcaddd77ec321fdf05f7c46235c2e5	\N	1	0	0	3654
129	1438631520	1438631520	1438774820	13162546	13162546@minmujer.gob.ve	5813bf4fdc807771b076b0bcb2046f66	\N	1	0	0	3837
15	1428417928	1428417928	1449067805	16923537	16923537@minmujer.gob.ve	8b5888cd12de1d8dc221de276c609e1d	\N	1	0	0	3916
421	1444752809	1444752809	1444755127	18602299	18602299@minmujer.gob.ve	e4b044ba404bdaecb31a63681b10dece	\N	1	0	0	4332
107	1438353798	1438353798	1438372348	12293241	12293241@minmujer.gob.ve	366e98a602fc689b9ae8e7ab9156d6d6	\N	1	0	0	535
16	1428420575	1428420575	1449068157	19088826	19088826@minmujer.gob.ve	642d375ac5dc5e06793366a9f235b845	\N	1	0	0	1406
413	1442590967	1442590967	1444749891	10310459	10310459@minmujer.gob.ve	f5da56350cdfde94d683bac87f76dd85	\N	1	0	0	1710
67	1438178439	1438178439	1439400241	17531237	17531237@minmujer.gob.ve	bf48e60f897c8960fc0fe17f3b3ad69d	\N	1	0	0	2322
385	1440112957	1440112957	1444749846	6869878	6869878@minmujer.gob.ve	953517bd02071271b4adc34bac8e7c0c	\N	1	0	0	1105
416	1443711195	1443711195	1444749813	16226942	16226942@minmujer.gob.ve	167a51cfdac336c493395953b86efc07	\N	1	0	0	2342
418	1444416447	1444416447	1444416448	17489509	17489509@minmujer.gob.ve	114346fddace5eaf4db0e5f7dc307832	\N	1	0	0	2364
14	1428415265	1428415265	1438175388	13691869	13691869@minmujer.gob.ve	37da9b1a1c7f13cf45e3559312c3df1a	\N	1	0	0	606
58	1438175795	1438175795	1445028006	6563623	6563623@minmujer.gob.ve	2ffc3d84814c737604cd11dd41529da6	\N	1	0	0	643
43	1437658688	1437658688	1437658688	18817386	18817386@minmujer.gob.ve	2ec471f558f99ab78751c8d47daeae86	\N	1	0	0	2702
449	1447181640	\N	1454516243	15328255	jramirez@minmujer.gob.ve	2420577adc94efbaf2dbf4199d9cf3fc	5f0b642f8fafaccf37ff2943359ec325	1	0	0	4531
440	1447086298	\N	1454019753	14072097	lrumbos@minmujer.gob.ve	5247399889c1baf78534d1218c27abbd	6ef27cc0ef1bdf42f5ac124e3e98e3b4	1	0	0	4545
384	1440075995	1440075995	1453832039	12296640	12296640@minmujer.gob.ve	c6c7250909a9933eccd7d29d9877b093	\N	1	0	0	2825
37	1437580015	1437580015	1454340660	6494428	6494428@minmujer.gob.ve	feecf09b8b0d4251fb5f8b91fcfa5628	\N	1	0	0	971
230	1439414857	1439414857	1454337779	6522001	6522001@minmujer.gob.ve	5cf3638a7b9ce6e1ca4de51bfea16d1e	\N	1	0	0	4025
9	1426197581	1426197581	1453903524	17482882	ggrimam@minmujer.gob.ve	d278212eee10f20d8d1b032cc5f971c2	\N	1	0	0	649
412	1441896629	1441896629	1445171810	15421164	15421164@minmujer.gob.ve	d956cbe97dd9c9adc77100f85a3357a2	\N	1	0	0	2143
121	1438386805	1438386805	1438392178	4165871	4165871@minmujer.gob.ve	e5f002b133d964df56747130183faa60	\N	1	0	0	3251
132	1438692911	1438692911	1438692911	18714484	18714484@minmujer.gob.ve	8f4161c5743867a1ab61b44d916ea409	\N	1	0	0	3412
17	1428420973	1428420973	1449068969	17269452	17269452@minmujer.gob.ve	47ffc128baafd4b1e7738ffd739acbd8	\N	1	0	0	646
77	1438187174	1438187174	1438187174	7924064	7924064@minmujer.gob.ve	06400ae1265bee1721e6104e365c3130	\N	1	0	0	3804
62	1438176637	1438176637	1438790266	11692434	11692434@minmujer.gob.ve	cf4e177357433b5ff2ef8f2127de1baa	\N	1	0	0	3810
427	1444855162	1444855162	1444855163	19958771	19958771@minmujer.gob.ve	8301a95661d0ba4ca1f1eda1a4581f52	\N	1	0	0	3981
425	1444850576	1444850576	1444851904	12501659	12501659@minmujer.gob.ve	0028dd24dd9ddc2232aef8dc4cf26715	\N	1	0	0	4112
172	1438882784	1438882784	1438885181	12298093	12298093@minmujer.gob.ve	f940093d90f85d3003fa63e04abca41d	\N	1	0	0	4192
407	1441376748	1441376748	1441379186	19037937	19037937@minmujer.gob.ve	56deaf82a743146f027849c3f7985db7	\N	1	0	0	4305
145	1438788244	1438788244	1438788245	11412777	11412777@minmujer.gob.ve	84d1a461ad46f57b0d89ca1deb6f1977	\N	1	0	0	4355
105	1438350686	1438350686	1438353006	16856306	16856306@minmujer.gob.ve	88967f19c9190e09a4fb7e227827906c	\N	1	0	0	4433
120	1438379302	1438379302	1438380987	20490759	20490759@minmujer.gob.ve	641d8229c04de29346e2c541389fa7b2	\N	1	0	0	4436
48	1438089396	1438089396	1438103770	21538483	21538483@minmujer.gob.ve	d07326bc0e7388b7e98c14ced743fe0d	\N	1	0	0	625
42	1437595488	1437595488	1437595488	6730736	6730736@minmujer.gob.ve	e877b22a4f6e4320bfebce1c36b514c2	\N	1	0	0	568
30	1437146621	1437146621	1437485883	14286904	14286904@minmujer.gob.ve	9082298bec29f292a7ebf7ca5e3eb567	\N	1	0	0	4338
33	1437402196	1437402196	1437405110	12834103	12834103@minmujer.gob.ve	7ad5b3ba04d50467946a8d45672d3f2e	\N	1	0	0	4293
124	1438603015	1438603015	1438603015	10549635	10549635@minmujer.gob.ve	ce3fa372fdadee43069c4e203d3714b0	\N	1	0	0	1120
125	1438603033	1438603033	1438882508	13077001	13077001@minmujer.gob.ve	d0d03a13c40c85f12286988d4bf03271	\N	1	0	0	1138
122	1438386865	1438386865	1441123850	10909146	10909146@minmujer.gob.ve	738d247745dc19cdbfb05921fff08c8c	\N	1	0	0	1387
424	1444762942	1444762942	1445607078	14678029	14678029@minmujer.gob.ve	9bb8bedfbff22f7f8bf59fb9a9f1b5a3	\N	1	0	0	1776
49	1438089521	1438089521	1438105755	17632764	17632764@minmujer.gob.ve	b7da1317ec185e678fcbd399b294f7f9	\N	1	0	0	3163
45	1438003977	1438003977	1438801103	5431764	5431764@minmujer.gob.ve	137702fb8d3ecbf3421af497805b9855	\N	1	0	0	4431
40	1437580823	1437580823	1441123228	17300757	17300757@minmujer.gob.ve	9a5ddff7cd2db09390f367dbb900d002	\N	1	0	0	3801
263	1439483002	1439483002	1439483002	18505460	18505460@minmujer.gob.ve	9f50a28f6e791efbfbd312cf39efa682	\N	2	0	0	3471
399	1441117034	1441117034	1441117034	23632589	23632589@minmujer.gob.ve	302998398061eb816ae7d1a250d24833	\N	1	0	0	4333
46	1438088088	1438088088	1438090073	10814466	10814466@minmujer.gob.ve	4f5fd62e3d4155685d3e92bf18837ee1	\N	1	0	0	1392
39	1437580804	1437580804	1437580805	19395748	19395748@minmujer.gob.ve	22271f0c3f3fdc4d8b5605553219e6dd	\N	1	0	0	2549
38	1437580409	1437580409	1437580410	19397555	19397555@minmujer.gob.ve	ae6ad0c786483116ac57afa4b4e4e490	\N	1	0	0	3580
127	1438616124	1438616124	1438616781	17303047	17303047@minmujer.gob.ve	a90d23287b577e19709c994342c08b7b	\N	1	0	0	2245
214	1439401161	1439401161	1439401161	16428885	16428885@minmujer.gob.ve	5289b349338ddfae47c3f1457907ada1	\N	1	0	0	1721
381	1440016155	1440016155	1440016156	17475756	17475756@minmujer.gob.ve	4c7f5457921df1e0eea6835640bae777	\N	1	0	0	3825
209	1439394909	1439394909	1439395327	20363740	20363740@minmujer.gob.ve	77acfa73d992608ded6a19975557a781	\N	1	0	0	3823
231	1439415114	1439415114	1439423354	17522877	17522877@minmujer.gob.ve	69409e464023a494017b4dee16f04fd0	\N	1	0	0	3826
184	1439210120	1439210120	1439401846	18365403	18365403@minmujer.gob.ve	ae7eba3e28cf741b2b7ee6b61bf518e4	\N	1	0	0	2525
239	1439471272	1439471272	1439493168	16084008	16084008@minmujer.gob.ve	0261e64535a06835174e63220dc8b9b8	\N	1	0	0	1473
208	1439394844	1439394844	1439816976	10543829	10543829@minmujer.gob.ve	db876ce1433fb21b78899812894c6e81	\N	1	0	0	694
378	1440008370	1440008370	1440008371	15039286	15039286@minmujer.gob.ve	5b799a6e7c9e1406269ffc33fb4ea70c	\N	1	0	0	4090
406	1441295567	1441295567	1445006977	5529730	5529730@minmujer.gob.ve	110b49874bab204e570bb97dfaa85d71	\N	1	0	0	3805
403	1441122029	1441122029	1441217049	13161160	13161160@minmujer.gob.ve	380fdbc9b7d0cd06808b7e86ff1d881b	\N	1	0	0	3868
402	1441120786	1441120786	1441120787	13576356	13576356@minmujer.gob.ve	32f09fa38a2917c715ca0019e1fd3acb	\N	1	0	0	3492
389	1440555694	1440555694	1441298573	18270042	18270042@minmujer.gob.ve	fab55811525be3d6e53a950bf168117b	\N	1	0	0	4273
242	1439471728	1439471728	1439559106	17174531	17174531@minmujer.gob.ve	ad43536437610dec09751c16f2fac12b	\N	1	0	0	2543
394	1441037945	1441037945	1441040041	5117027	5117027@minmujer.gob.ve	8e9b4ef798d7df24c53beba8fb45c4e5	\N	2	0	0	3821
31	1437146897	1437146897	1453822525	6122334	6122334@minmujer.gob.ve	162bc46168bd6730edcedb39e83bf50a	\N	1	0	0	1654
32	1437146987	1437146987	1453823162	19658562	19658562@minmujer.gob.ve	4edffe652d94c119b12e9e977d4efef2	\N	1	0	0	3662
44	1437661000	1437661000	1437675989	17610072	17610072@minmujer.gob.ve	6fb489e091d3d70df397948734ed507e	\N	1	0	0	1588
183	1438981503	1438981503	1454093299	18189700	gmorales@minmujer.gob.ve	01cac7fc81c0f3628ad91a1694708e96	\N	1	0	0	3756
204	1439389316	1439389316	1453825836	19557132	19557132@minmujer.gob.ve	171a4182494ada55d75444baf6866175	\N	1	0	0	4137
393	1441037313	1441037313	1441037313	18816822	18816822@minmujer.gob.ve	aabd72143eb32ef977388e776eb5dc2c	\N	1	0	0	3994
69	1438178777	1438178777	1438178777	10485518	10485518@minmujer.gob.ve	704d1464904f1272347a965ce099eb2e	\N	1	0	0	3584
224	1439408595	1439408595	1439408595	12761695	12761695@minmujer.gob.ve	1a53ab5347da786acbf07b0d9948e042	\N	1	0	0	1733
261	1439482456	1439482456	1439484743	12318666	12318666@minmujer.gob.ve	57bf20fa817e8dff9343429da0b56150	\N	1	0	0	3992
391	1440881047	1440881047	1440881047	10507750	10507750@minmujer.gob.ve	b22d7be224c449ee20f9991471483206	\N	1	0	0	3982
202	1439385776	1439385776	1439385776	12357101	12357101@minmujer.gob.ve	6ecbd1e5a485f9603db5d9e3670d7754	\N	1	0	0	3643
211	1439395658	1439395658	1439395658	19627576	19627576@minmujer.gob.ve	df159854d4c40fbdeca2c2e22a5c9444	\N	1	0	0	3892
218	1439404523	1439404523	1439404523	6846578	6846578@minmujer.gob.ve	87930e9b94d970cd8ccc6af561883ec4	\N	1	0	0	675
203	1439386816	1439386816	1444331578	12172332	12172332@minmujer.gob.ve	6b12e45b9bc7d350b6ac8833565418da	\N	1	0	0	2211
201	1439380383	1439380383	1439385988	13550175	13550175@minmujer.gob.ve	1799e7f643f68d99a8e9b41d42c9f287	\N	1	0	0	2238
210	1439395127	1439395127	1439396165	14016089	14016089@minmujer.gob.ve	50bd837df81eb27f6331a8c81c05e7e3	\N	1	0	0	4254
221	1439407539	1439407539	1439407539	20560601	20560601@minmujer.gob.ve	95d2db28b8f7f8e3296c2563822faebe	\N	1	0	0	4256
388	1440529514	1440529514	1440530906	84400826	84400826@minmujer.gob.ve	0dfd5491166e3a69aa5b3bbe2e3ce3fd	\N	1	0	0	2363
227	1439410450	1439410450	1439410451	1566140	1566140@minmujer.gob.ve	5cbe6a1eea28e70c2929c306e57b36ac	\N	1	0	0	707
322	1439570735	1439570735	1439573567	16977072	16977072@minmujer.gob.ve	07d02887acae7ac8643c624644e2542d	\N	1	0	0	735
331	1439578274	1439578274	1439583711	6687235	6687235@minmujer.gob.ve	a9b8610a500e105fde57de90df62d597	\N	1	0	0	725
287	1439509745	1439509745	1439509746	10133106	10133106@minmujer.gob.ve	c913d0758517d226ddad490f1fcabdea	\N	1	0	0	726
258	1439479187	1439479187	1439482919	12584454	12584454@minmujer.gob.ve	4df1b07ada9b5e06999972211e87477d	\N	1	0	0	723
294	1439518213	1439518213	1439520403	16527180	16527180@minmujer.gob.ve	8ffa390c392f7467b29ccdc4a7aab5f2	\N	1	0	0	734
268	1439486479	1439486479	1439550228	14218419	14218419@minmujer.gob.ve	67ddcbde2173db1db1e1f59210274872	\N	1	0	0	729
298	1439557854	1439557854	1439559373	14947619	14947619@minmujer.gob.ve	806054982a5cb84195116f8265569733	\N	1	0	0	727
264	1439483127	1439483127	1439490637	17851852	17851852@minmujer.gob.ve	f076a9319e4a8159ae0420525e9c2eeb	\N	1	0	0	3187
320	1439570183	1439570183	1439589849	21294691	21294691@minmujer.gob.ve	f9512dcbf35928e2ae670db1d4510aec	\N	1	0	0	4123
373	1439983538	1439983538	1440083467	18691736	18691736@minmujer.gob.ve	5c66d08a8a4286ab093bab067ee3a505	\N	1	0	0	744
250	1439474835	1439474835	1439516967	15967077	15967077@minmujer.gob.ve	c5764d463fe539d9ff2d82b29394f968	\N	1	0	0	750
333	1439578886	1439578886	1439583908	10873783	10873783@minmujer.gob.ve	855d84b3eab0d02ce37fbcfb23cfb1c0	\N	1	0	0	758
223	1439408573	1439408573	1439482813	9831366	9831366@minmujer.gob.ve	cb1bd10c79edf7650469c066256954fb	\N	1	0	0	752
253	1439476032	1439476032	1439482932	16638344	16638344@minmujer.gob.ve	ed21048d47c6124ef51a36aa88e388a8	\N	1	0	0	751
257	1439478460	1439478460	1439571195	13959492	13959492@minmujer.gob.ve	e22d0d47cdb282ec9f2e2da74fe4beb9	\N	1	0	0	757
232	1439418845	1439418845	1439572264	8149047	8149047@minmujer.gob.ve	68ee8a8c425ce07a3b4e5abed49ebd79	\N	1	0	0	756
248	1439474175	1439474175	1439474175	16189030	16189030@minmujer.gob.ve	9220cf9fedadb0f815ce43325f4c3694	\N	1	0	0	759
295	1439519614	1439519614	1439564844	22114235	22114235@minmujer.gob.ve	d0b043e5f9965003025eb863e6ca925f	\N	1	0	0	4121
323	1439571301	1439571301	1439584316	14171672	14171672@minmujer.gob.ve	ee62835f7951bacfd4520e94f027e579	\N	1	0	0	4271
286	1439507215	1439507215	1439514924	7398725	7398725@minmujer.gob.ve	7fcce0a657b96a922070be693ff9bb6c	\N	1	0	0	753
347	1439596904	1439596904	1439599549	11604715	11604715@minmujer.gob.ve	d739a14979a5e561ea5ecfd55335ad10	\N	1	0	0	1941
319	1439570168	1439570168	1439584442	10573930	10573930@minmujer.gob.ve	c56bf6470e06fbbd0e000ff800168353	\N	1	0	0	761
297	1439557463	1439557463	1439562475	18265042	18265042@minmujer.gob.ve	a4d74cd60698b60de589d7f1c920947c	\N	1	0	0	983
343	1439588021	1439588021	1439836196	12560701	12560701@minmujer.gob.ve	f902eaf648244c0dda1ade88549ebd08	\N	1	0	0	768
364	1439843452	1439843452	1439847038	13646540	13646540@minmujer.gob.ve	76876a98ca1efb90282c1d1f17b14817	\N	1	0	0	767
290	1439512052	1439512052	1439573040	9912371	9912371@minmujer.gob.ve	3f168d2a31a115d180c6e614e4762ff3	\N	1	0	0	766
321	1439570388	1439570388	1439570388	21110480	21110480@minmujer.gob.ve	815dd4ab4559748a924728c287031271	\N	1	0	0	4127
226	1439409146	1439409146	1439607001	15991074	15991074@minmujer.gob.ve	a0f01deb8e621ea65f2aa0df11edab51	\N	1	0	0	2011
216	1439403023	1439403023	1439404104	17575206	17575206@minmujer.gob.ve	37fea3baaa6c2dd3e60996b78cb8df2b	\N	1	0	0	774
279	1439494948	1439494948	1439495401	7663433	7663433@minmujer.gob.ve	f4b0c58f0e097980559c8dafc7a33a6a	\N	1	0	0	1220
222	1439407750	1439407750	1439407753	4421643	4421643@minmujer.gob.ve	b6f4be6b9b81b2b2136391687fada037	\N	1	0	0	1100
228	1439410686	1439410686	1439413635	14573918	14573918@minmujer.gob.ve	b9f0c7789116d6e993f5665a8905aa1e	\N	1	0	0	2703
340	1439583872	1439583872	1439587971	4457109	4457109@minmujer.gob.ve	c7285f667bf3951181859684940a5bc4	\N	1	0	0	780
213	1439399628	1439399628	1439399628	15995584	meizaguirre@minmujer.gob.ve	a73e208a9cbad4465d57c33188bafd26	\N	2	0	0	4321
225	1439408831	1439408831	1453835658	6339859	illamozas@minmujer.gob.ve	adf40e4b35e0a344fc5bf46493f5d49c	\N	1	0	0	1741
405	1441293829	1441293829	1454349929	16671974	16671974@minmujer.gob.ve	66c650725564844d8e9436bd8cc1a870	\N	1	0	0	4482
401	1441119142	1441119142	1454511521	18967075	18967075@minmujer.gob.ve	6de34a7724e4b9da4cc324965e6fe9f0	\N	1	0	0	3184
390	1440880794	1440880794	1447274819	7660782	7660782@minmujer.gob.ve	9cfd3bc599d00fa5393a822aa112affa	\N	1	0	0	3893
299	1439558830	1439558830	1439818162	8866032	blevel@minmujer.gob.ve	660035118cbc81304a95c56119f42e88	\N	1	0	0	4181
335	1439580833	1439580833	1439580833	7078552	7078552@minmujer.gob.ve	69710f296ff1371275c847855b9fffd8	\N	1	0	0	3240
339	1439583864	1439583864	1439585877	10986834	10986834@minmujer.gob.ve	0f80ccaafcb568f2e2a714edd7f0da9d	\N	1	0	0	3985
272	1439489506	1439489506	1439489506	11961813	11961813@minmujer.gob.ve	cef6d9734da2c11ec519c24696e4ee96	\N	1	0	0	783
283	1439503345	1439503345	1439505279	14900791	14900791@minmujer.gob.ve	7c19701e66ac14394c02458bfc5efc9b	\N	1	0	0	786
267	1439486479	1439486479	1439656126	17328621	17328621@minmujer.gob.ve	cd5fbc59865e9af4a45273397db4c835	\N	1	0	0	1058
270	1439487116	1439487116	1439488196	9530623	9530623@minmujer.gob.ve	9f956a63a5053b932961da575f94f035	\N	1	0	0	782
271	1439488486	1439488486	1439488953	15071007	15071007@minmujer.gob.ve	f328ab82521e2141fea7a911c0ba2b4f	\N	1	0	0	896
273	1439489994	1439489994	1439509696	18502076	18502076@minmujer.gob.ve	4e680e460ccee706272f2e7ddc974adb	\N	1	0	0	4124
354	1439762975	1439762975	1439768277	15790845	15790845@minmujer.gob.ve	bfdbc40c0db2689f334c63fd8441a3d4	\N	1	0	0	793
282	1439498941	1439498941	1439589492	18659094	18659094@minmujer.gob.ve	100e7843850b82e5523bc88960f6b673	\N	1	0	0	799
310	1439564924	1439564924	1439567484	16375889	16375889@minmujer.gob.ve	8de7a6e19a734a808035d20bd1655cc5	\N	1	0	0	791
336	1439582285	1439582285	1439582285	14488427	14488427@minmujer.gob.ve	82594fc0cf76db817bebc070481e606a	\N	1	0	0	798
318	1439568610	1439568610	1439568610	11211413	11211413@minmujer.gob.ve	d6f6c883f237e2e2f2f418b0fa686134	\N	1	0	0	796
309	1439564018	1439564018	1439566139	4514847	4514847@minmujer.gob.ve	4f3711ba339f2543f371b07f114a6510	\N	1	0	0	800
356	1439816865	1439816865	1439817746	16216034	16216034@minmujer.gob.ve	5d00b894d2e2274d5112a2fcf153427e	\N	1	0	0	794
188	1439222411	1439222411	1439224571	6215746	6215746@minmujer.gob.ve	ef75e6a551036b0f288ac67934ab652c	\N	1	0	0	1047
187	1439222322	1439222322	1439222322	5003988	5003988@minmujer.gob.ve	71d1fca48041bc9bc13439d76550c263	\N	1	0	0	804
370	1439917466	1439917466	1439917466	15169652	15169652@minmujer.gob.ve	d2957e73718615658a5bf6126761ec39	\N	1	0	0	812
193	1439300925	1439300925	1439300925	11442568	11442568@minmujer.gob.ve	0bc4a60b19d42e4ba967c70b161e1aa9	\N	1	0	0	813
186	1439222219	1439222219	1439224686	12910695	12910695@minmujer.gob.ve	807f195307dc092a426eda79b4da398f	\N	1	0	0	805
66	1438177438	1438177438	1440182690	9887684	9887684@minmujer.gob.ve	042a8d149bbefe89e7f8c14478052e2d	\N	1	0	0	3445
76	1438185338	1438185338	1438185340	16677654	16677654@minmujer.gob.ve	f8bf580d311c4451f518af7946244398	\N	1	0	0	3561
367	1439907909	1439907909	1439907910	16284379	16284379@minmujer.gob.ve	9e59824c8bc9bf67ee183a4ebd6cfd4d	\N	1	0	0	660
72	1438181522	1438181522	1438184480	13457921	13457921@minmujer.gob.ve	8f07cc08445af2a9526377adfc5cd9b3	\N	1	0	0	3798
241	1439471640	1439471640	1439471640	13027186	13027186@minmujer.gob.ve	2c02b789648dcbd10ff10d275fae5a69	\N	1	0	0	824
217	1439404379	1439404379	1439561822	11477942	11477942@minmujer.gob.ve	5808245c17883dab58e4055179110ae2	\N	1	0	0	823
305	1439562883	1439562883	1439580527	15655694	15655694@minmujer.gob.ve	41d47601a500d108853af2688e6374df	\N	1	0	0	816
219	1439404904	1439404904	1439407563	14396704	14396704@minmujer.gob.ve	bd6c3217e218faa8b12ce60e91042615	\N	1	0	0	826
247	1439473866	1439473866	1439476059	18047463	18047463@minmujer.gob.ve	b55ed11d3993ca644395be3cb8a34ff7	\N	1	0	0	817
240	1439471330	1439471330	1439473284	6066131	6066131@minmujer.gob.ve	e5750cd5f6f9370e402a994d3aee833b	\N	1	0	0	687
252	1439475952	1439475952	1439475952	15096501	15096501@minmujer.gob.ve	57e9256184ca7d03a280c6c269f30c38	\N	1	0	0	819
249	1439474329	1439474329	1439474330	20568919	20568919@minmujer.gob.ve	98dca029b4b8c0a769519e95d7b632f1	\N	1	0	0	4122
361	1439836968	1439836968	1439836968	5751354	5751354@minmujer.gob.ve	86e198345ff9cdabded921b319ee8cb0	\N	1	0	0	4425
325	1439573381	1439573381	1439575226	14168678	14168678@minmujer.gob.ve	e863dd7a3a025e1f5bd86a584cf9fd86	\N	1	0	0	818
220	1439406674	1439406674	1439476161	10868752	10868752@minmujer.gob.ve	365805eacb2f2169f7fb98295633b4b8	\N	1	0	0	820
244	1439472586	1439472586	1439472586	16363893	16363893@minmujer.gob.ve	890c0fcabfdbac15b88b5fafd1965c27	\N	1	0	0	833
251	1439475561	1439475561	1439475561	13576173	13576173@minmujer.gob.ve	19f0c7730e786aa4831b3c23e049ef55	\N	1	0	0	834
266	1439485921	1439485921	1439500070	17849494	17849494@minmujer.gob.ve	35cba4b5659e81aeda988043b277b08f	\N	1	0	0	836
276	1439492220	1439492220	1439492220	19222380	19222380@minmujer.gob.ve	336f42e5f531cf128bfe1102653c53ba	\N	1	0	0	4125
278	1439493036	1439493036	1439493037	3965875	3965875@minmujer.gob.ve	89f1412a87318a16e05b2e07661a09d6	\N	1	0	0	838
236	1439437788	1439437788	1439440547	13795805	13795805@minmujer.gob.ve	219d0a2c359b2b051a23d6dc7f3086e7	\N	1	0	0	3338
372	1439943743	1439943743	1439945713	2608844	2608844@minmujer.gob.ve	69feaf3d1a1e2f4f067d9bc40902756b	\N	1	0	0	842
383	1440025583	1440025583	1443797527	11427115	11427115@minmujer.gob.ve	dc3c1e6b0492a94be49b0a4e84b7b6f2	\N	1	0	0	844
288	1439511179	1439511179	1439511180	16090183	16090183@minmujer.gob.ve	f735fd0a32e77021ef68547b1b7efbdf	\N	1	0	0	3332
269	1439486710	1439486710	1439486710	16139319	16139319@minmujer.gob.ve	8f29681c937ba9a13442ac3204ac31ee	\N	1	0	0	2618
238	1439470543	1439470543	1439470543	16420163	16420163@minmujer.gob.ve	d91b2b37102abdea197d15895a0e60f6	\N	1	0	0	930
414	1443557173	1443557173	1443559846	4069852	4069852@minmujer.gob.ve	484759a55ee7f853895020d131c3d309	\N	1	0	0	841
358	1439821255	1439821255	1439821256	17859156	17859156@minmujer.gob.ve	83e3119ea51a8073415cd3a03914eaf0	\N	1	0	0	2699
265	1439485541	1439485541	1453837205	14413474	14413474@minmujer.gob.ve	867f8f130dec1f217082befd732fe8f2	\N	1	0	0	789
349	1439603800	1439603800	1439605915	11407120	11407120@minmujer.gob.ve	9e004105e43b2925470192184d3f8488	\N	1	0	0	3931
304	1439561822	1439561822	1439561822	19395216	19395216@minmujer.gob.ve	77da9535e535804490c03b533e218d0e	\N	1	0	0	868
301	1439560304	1439560304	1439562443	6841972	6841972@minmujer.gob.ve	4e1e868846265b787468f9d94ee34ba0	\N	1	0	0	869
73	1438181888	1438181888	1438181889	12417541	12417541@minmujer.gob.ve	5760bd81c3f7a26e9ad5e5056dad4253	\N	1	0	0	865
291	1439512999	1439512999	1439515110	13600903	13600903@minmujer.gob.ve	da4a422201ef9fc89032900b711ee17a	\N	1	0	0	653
327	1439575279	1439575279	1439575280	12157970	12157970@minmujer.gob.ve	ae38139202b5a9f32bee29d903517930	\N	1	0	0	871
348	1439602564	1439602564	1439602564	4681302	4681302@minmujer.gob.ve	6ccbca5880ec5f3e335637d021508a48	\N	1	0	0	4423
357	1439820176	1439820176	1439823573	8675722	8675722@minmujer.gob.ve	e08bfc4b9a6c963f9c3314b09819811e	\N	1	0	0	861
254	1439477173	1439477173	1439480369	11210221	11210221@minmujer.gob.ve	2a8dd14fe2678423f4c9673320dc8ef8	\N	1	0	0	872
329	1439576782	1439576782	1439577484	13771837	13771837@minmujer.gob.ve	3ff0dbb7c374184f79bf1646d900588b	\N	1	0	0	2001
328	1439576482	1439576482	1439576482	4027436	4027436@minmujer.gob.ve	0853a27d7af500c06d3b9f032e67d96c	\N	1	0	0	873
285	1439504855	1439504855	1439507811	19447281	19447281@minmujer.gob.ve	145324492e2875dd33679c825ecaa715	\N	1	0	0	4134
259	1439480254	1439480254	1439482851	13475305	13475305@minmujer.gob.ve	2dd1483a62eb48b78986afcc7d80537f	\N	1	0	0	4296
260	1439480570	1439480570	1439480571	18173099	18173099@minmujer.gob.ve	34d2099c1bddb8b046052ff27495dd75	\N	1	0	0	876
344	1439593277	1439593277	1439595333	17362506	17362506@minmujer.gob.ve	edf477cce9a9df0b5081fee2c1964a62	\N	1	0	0	900
293	1439514573	1439514573	1439516442	17136045	17136045@minmujer.gob.ve	227866cf88a6df074b1d80aea39eee81	\N	1	0	0	662
303	1439561785	1439561785	1439600100	16964821	16964821@minmujer.gob.ve	af73949cd895b947c705d0783cfaca91	\N	1	0	0	898
284	1439504458	1439504458	1439507952	17617924	17617924@minmujer.gob.ve	bf8298724aaccc8d2aca1196e22d1997	\N	1	0	0	4335
362	1439839821	1439839821	1439839822	12647354	12647354@minmujer.gob.ve	b814bb6fce5c676234f0bb9f44f7b45b	\N	1	0	0	4022
289	1439511917	1439511917	1439511917	17261053	17261053@minmujer.gob.ve	d20e3b9d881c891186ba8584cac10bda	\N	1	0	0	1149
296	1439521343	1439521343	1439568515	16567863	16567863@minmujer.gob.ve	fc30e58bb9e65095a872f75465612c8a	\N	1	0	0	901
292	1439514475	1439514475	1439666739	20574165	20574165@minmujer.gob.ve	b7eb4420731f746f4693f39f0c7d7d15	\N	1	0	0	4131
243	1439472081	1439472081	1439568291	6959283	6959283@minmujer.gob.ve	6dcd644a87450339062a42e08a6138ce	\N	1	0	0	906
306	1439562927	1439562927	1439564054	9279452	9279452@minmujer.gob.ve	abaf0aa135a9623eef17b57940819439	\N	1	0	0	910
317	1439568472	1439568472	1439570837	8652830	8652830@minmujer.gob.ve	2e340af1b7ce87885d42d6e9622d799c	\N	1	0	0	909
315	1439566985	1439566985	1439568894	14173701	14173701@minmujer.gob.ve	2329721f074c5fea58ca3a376ba69f86	\N	1	0	0	914
308	1439563768	1439563768	1439569698	11442055	11442055@minmujer.gob.ve	240cf1f29e69fddb0ffb5cb9cdd362db	\N	1	0	0	913
312	1439565337	1439565337	1439565338	3870524	3870524@minmujer.gob.ve	a8d4df5e4e4d29470742b75740e87aea	\N	1	0	0	911
338	1439583742	1439583742	1439841504	17482282	17482282@minmujer.gob.ve	f90d067aaebe868c48380c16e484635c	\N	1	0	0	920
374	1439986940	1439986940	1439986941	16233389	16233389@minmujer.gob.ve	ef0557ff0fe1dab38a6cb37ca798dbd4	\N	1	0	0	923
369	1439915227	1439915227	1439915228	16333165	16333165@minmujer.gob.ve	28b3ae2ab328eb0df3167ae6ec7c1778	\N	1	0	0	924
366	1439906100	1439906100	1439908335	22683521	22683521@minmujer.gob.ve	275212daf143e9b975f7d406b782bb0f	\N	1	0	0	4260
371	1439924829	1439924829	1439924830	22673231	22673231@minmujer.gob.ve	542883631dfc7d0ccdfa6d446f97b43c	\N	1	0	0	926
380	1440014491	1440014491	1440014491	13302647	13302647@minmujer.gob.ve	7154f3eeaa13bb341180239c54043091	\N	1	0	0	927
379	1440008543	1440008543	1440014363	23513120	23513120@minmujer.gob.ve	acfdd3409752f6fe7391fb080350b165	\N	1	0	0	918
311	1439565232	1439565232	1439567100	15622715	15622715@minmujer.gob.ve	16dd1b283be6650c1ad0f74fc72bc757	\N	1	0	0	928
316	1439568359	1439568359	1439676692	23596879	23596879@minmujer.gob.ve	3f5a8876294dce045046a557c861384a	\N	1	0	0	3264
255	1439477283	1439477283	1440688328	9166700	9166700@minmujer.gob.ve	9b0d3f7b451d38fdcd023a98507cb5d8	\N	1	0	0	940
277	1439492405	1439492405	1439493230	13377235	13377235@minmujer.gob.ve	21e8512702c55d737c3822d2ffc50245	\N	1	0	0	938
262	1439482567	1439482567	1439517643	11946163	11946163@minmujer.gob.ve	65eed8b065491a597b72747b2055415d	\N	1	0	0	941
386	1440173218	1440173218	1440426570	10811018	10811018@minmujer.gob.ve	6b975035cc2fcdd9feac75107d3d9dd7	\N	1	0	0	922
326	1439573410	1439573410	1439771490	24565409	24565409@minmujer.gob.ve	e2ae6611a653e7677c37d5525eb6ad0e	\N	1	0	0	4135
346	1439596240	1439596240	1439597162	12377748	12377748@minmujer.gob.ve	085346fed5b971f347720030efbbe218	\N	1	0	0	936
351	1439609167	1439609167	1439609167	11318947	11318947@minmujer.gob.ve	a98812cbf5ea923e8ae45d914bd25a9b	\N	1	0	0	3271
365	1439905664	1439905664	1440083773	16111658	16111658@minmujer.gob.ve	7980917fc54788a079db424475c9d434	\N	1	0	0	948
345	1439593605	1439593605	1439595951	19062654	19062654@minmujer.gob.ve	f94bdc97cb72a69e23612ac78d3f56bc	\N	1	0	0	4422
334	1439579061	1439579061	1439585069	14998128	14998128@minmujer.gob.ve	0b2def746a8ccad6e124a7c9712719e4	\N	1	0	0	955
330	1439576991	1439576991	1439587723	11619263	11619263@minmujer.gob.ve	736f41d1b1fb69af194b4306f686972d	\N	1	0	0	877
363	1439840394	1439840394	1439926184	17877777	17877777@minmujer.gob.ve	675fc9120f59cbf840a70c0f56c051d6	\N	1	0	0	830
234	1439429584	1439429584	1453836473	17549714	17549714@minmujer.gob.ve	4e40cbbdf431a0671d6dee359ef82598	\N	1	0	0	899
337	1439583265	1439583265	1439585386	10374860	10374860@minmujer.gob.ve	f6d29d2002006a5c99b72e1d2997d5ed	\N	1	0	0	946
307	1439563604	1439563604	1439578205	16482127	16482127@minmujer.gob.ve	975719479915a1f7f9641ed8e5d61c5e	\N	1	0	0	944
387	1440184477	1440184477	1440193806	4971690	4971690@minmujer.gob.ve	e1b356a924c83eece11cd8c96bf5e248	\N	1	0	0	950
353	1439612298	1439612298	1439862139	7308298	7308298@minmujer.gob.ve	1ffc06efb807d9104e072b1a5b5cd715	\N	1	0	0	951
332	1439578532	1439578532	1439909316	15484003	15484003@minmujer.gob.ve	43092ab9526f6a38577df94ef31b3b39	\N	1	0	0	952
342	1439586103	1439586103	1439591036	23751794	23751794@minmujer.gob.ve	8a4257a661dccb69d6e656a7506d678c	\N	1	0	0	4141
341	1439585818	1439585818	1439585819	16782889	16782889@minmujer.gob.ve	70e9aa66ec4907192dc074d649758234	\N	1	0	0	959
302	1439560461	1439560461	1439586626	9717449	9717449@minmujer.gob.ve	1a9b5f9b5775c21cfcb2e8208ad1e12b	\N	1	0	0	958
174	1438884181	1438884181	1438886043	17022373	17022373@minmujer.gob.ve	c0557e3e782a6772aa26f0c98efb183e	\N	1	0	0	4252
169	1438874226	1438874226	1438883883	17286519	17286519@minmujer.gob.ve	4360197c539d5f41172c9a2a9d11aacf	\N	1	0	0	2811
163	1438800924	1438800924	1438960454	26343805	26343805@minmujer.gob.ve	c037c1aec4154dd2f7ce8b82cc36eb38	\N	1	0	0	2506
149	1438788595	1438788595	1438790721	18328563	18328563@minmujer.gob.ve	8a6e3c779a039007fbb1a4f30bb2a9c7	\N	1	0	0	3905
148	1438788549	1438788549	1438889968	16473032	16473032@minmujer.gob.ve	47cc208700adc3a5793d5302ceddda24	\N	1	0	0	2504
150	1438789112	1438789112	1438889985	10554974	10554974@minmujer.gob.ve	0131c33d3eabc13c8303a137386015df	\N	1	0	0	2795
176	1438890065	1438890065	1438890663	22029283	22029283@minmujer.gob.ve	0e6960a0f69a6802d0c6763e3a191530	\N	1	0	0	2808
151	1438789759	1438789759	1438885743	4945505	4945505@minmujer.gob.ve	f8ddb2f7e2a29601da30a3125c46e12d	\N	1	0	0	2511
157	1438795252	1438795252	1438957194	12783906	12783906@minmujer.gob.ve	55676391b653ebf2c82a0c14247cd80e	\N	1	0	0	4253
138	1438787186	1438787186	1438960306	20026106	20026106@minmujer.gob.ve	8b6926b73cdee8f46e979c946540714e	\N	1	0	0	4000
146	1438788292	1438788292	1438895450	20558438	20558438@minmujer.gob.ve	3f3807909e63c25b89833b3c14008085	\N	1	0	0	2806
170	1438876423	1438876423	1438883205	18034091	18034091@minmujer.gob.ve	7df2f4ea82a4611bd2378f13a02e9c9b	\N	1	0	0	659
147	1438788323	1438788323	1438794928	12687695	12687695@minmujer.gob.ve	efc56a4072070e11e58e8c253022f3a5	\N	1	0	0	2505
144	1438788198	1438788198	1438788198	17720189	17720189@minmujer.gob.ve	2bc605fa1823ab783f207c1a72a13841	\N	1	0	0	4440
156	1438792152	1438792152	1438792153	18111056	18111056@minmujer.gob.ve	afa14768f050540183b57202068ac5ee	\N	1	0	0	4437
200	1439317696	1439317696	1439317697	10345883	10345883@minmujer.gob.ve	71d2255dffc02b85d16f1c12bfb7c80e	\N	1	0	0	544
191	1439236917	1439236917	1439307641	15251628	15251628@minmujer.gob.ve	dc97fbcb84b46aa1e3186902957ddcb8	\N	1	0	0	1504
185	1439221690	1439221690	1439308767	11064084	11064084@minmujer.gob.ve	2c8a89d8c3264201aefeb1b173a2b1cc	\N	1	0	0	1471
189	1439228128	1439228128	1439307742	13125089	13125089@minmujer.gob.ve	ddb4e889af879e1c54d454d002b11c8b	\N	1	0	0	573
274	1439491003	1439491003	1439492908	14757395	14757395@minmujer.gob.ve	21a140e11aa05ee90f54ae254ce1051b	\N	1	0	0	3962
199	1439316371	1439316371	1439318790	12916103	12916103@minmujer.gob.ve	2fe50eddb133bc6719c635f7d54b6fdd	\N	1	0	0	574
409	1441637978	1441637978	1441637979	17044880	17044880@minmujer.gob.ve	3ffd5745e0493c3a4d5f692a9586251e	\N	1	0	0	2531
205	1439392810	1439392810	1444752365	22030406	22030406@minmujer.gob.ve	7283ff16398ff2e5e10d0abd256cbf0f	\N	1	0	0	2072
206	1439393331	1439393331	1441207506	14287885	14287885@minmujer.gob.ve	152d3a5913c7cadb641a3a1d5bdad0b7	\N	1	0	0	2163
198	1439303768	1439303768	1439304711	19582354	19582354@minmujer.gob.ve	8697429f8db4167a7d47433cebea5f66	\N	1	0	0	3588
207	1439393697	1439393697	1439405345	22904410	22904410@minmujer.gob.ve	66b1f7d95cb1acb3a8ec728b274a2d7b	\N	1	0	0	3656
398	1441116031	1441116031	1441116031	18604092	18604092@minmujer.gob.ve	8a009e0b803039affd9e07bfab09aae5	\N	1	0	0	2201
197	1439302523	1439302523	1439302523	18530361	18530361@minmujer.gob.ve	b58c7ae291ca0afd6019e23e54a818c6	\N	1	0	0	3494
192	1439240092	1439240092	1439489808	12390896	12390896@minmujer.gob.ve	8acf5949a62c3f8bdc655f0df815a3a4	\N	1	0	0	2351
195	1439302023	1439302023	1439304060	15024047	15024047@minmujer.gob.ve	52c537b3b3b6dbad849a8aac4d4802bf	\N	1	0	0	3796
410	1441641207	1441641207	1441641207	13352807	13352807@minmujer.gob.ve	7acff6ebb19a9591015de76f7709eccf	\N	1	0	0	3961
196	1439302166	1439302166	1439304451	15615632	15615632@minmujer.gob.ve	d3438b9137822ee21032cf1513c3bc4b	\N	1	0	0	3655
215	1439402535	1439402535	1441131190	10543837	10543837@minmujer.gob.ve	8c8cb9473f3829fcc145af936b7f12c5	\N	1	0	0	692
137	1438786918	1438786918	1438797767	21759418	21759418@minmujer.gob.ve	e899a8cec6eb36ec936c6e3a1ae263f4	\N	1	0	0	2269
152	1438790557	1438790557	1438887155	17584841	17584841@minmujer.gob.ve	4e9df177b5568e29a63e4be3c12495bd	\N	1	0	0	3411
139	1438787405	1438787405	1441639850	7924967	7924967@minmujer.gob.ve	17b69299a850c08a81f1850576579827	\N	1	0	0	616
314	1439566771	1439566771	1439566771	11820551	11820551@minmujer.gob.ve	5788fbdf29843a47cb122c5b3a6afe76	\N	1	0	0	617
161	1438800044	1438800044	1442841024	18935390	18935390@minmujer.gob.ve	a58d6e638438c76fbc562fee4eb1424a	\N	1	0	0	3854
396	1441112858	1441112858	1441112858	20913335	20913335@minmujer.gob.ve	4d66e66a0aea46199a07a2818e9928f9	\N	1	0	0	3853
400	1441118760	1441118760	1441119726	19555250	19555250@minmujer.gob.ve	e5aef30dc913eac82661523a9c10b53a	\N	1	0	0	4526
352	1439610452	1439610452	1439610453	11424523	11424523@minmujer.gob.ve	969d61fa5184d91d62e147033d6732a8	\N	1	0	0	3928
392	1441037192	1441037192	1442863204	6252529	6252529@minmujer.gob.ve	7ec95a6e3e5a1dedfc4df4ed1383846a	\N	1	0	0	658
275	1439491444	1439491444	1454512870	12642994	12642994@minmujer.gob.ve	22f5903d9c6c970dc4b81eff9d960153	\N	1	0	0	1187
194	1439301393	1439301393	1439303975	13067730	13067730@minmujer.gob.ve	20b310c0dda44ed7484c9099dd7100b7	\N	1	0	0	3449
94	1438278508	1438278508	1438801318	6532915	6532915@minmujer.gob.ve	355cfb524fbfa286ed47d73f3961b98f	\N	1	0	0	4303
423	1444760777	1444760777	1445869351	6224189	6224189@minmujer.gob.ve	c665b8e98acc9e422eb5ba424d0fa8ab	\N	1	0	0	1576
117	1438376038	1438376038	1438376040	10000079	10000079@minmujer.gob.ve	7ef6f03c11c580d6aa08a04afe7aceab	\N	1	0	0	2648
82	1438258566	1438258566	1438264795	6848221	6848221@minmujer.gob.ve	4be11e0024adb7dd564c12fe50e62989	\N	1	0	0	3245
74	1438183538	1438183538	1438183538	20309915	20309915@minmujer.gob.ve	b8363243a17b456a1c1e862388cc84c0	\N	1	0	0	2235
134	1438779120	1438779120	1439301265	13520015	13520015@minmujer.gob.ve	7c0f3e5250eebdca3ea28806eaee910f	\N	1	0	0	3652
158	1438796346	1438796346	1438796347	12731618	12731618@minmujer.gob.ve	b5e2740c8fb24af80dd68b754a084df3	\N	1	0	0	3659
81	1438201490	1438201490	1438201490	16682452	16682452@minmujer.gob.ve	2379df1c1515a3c1bcb8b0a0c22775e3	\N	1	0	0	3885
411	1441738631	1441738631	1445367229	13310455	13310455@minmujer.gob.ve	052fd00191e8684a0ffbdefd9bc07264	\N	1	0	0	3864
92	1438278043	1438278043	1438280139	16857611	16857611@minmujer.gob.ve	014dcae0efbfd3ae379ed7af3bd21bcb	\N	1	0	0	2267
79	1438193426	1438193426	1438280189	16876397	16876397@minmujer.gob.ve	61538fe04e1b301f330a8a686335f212	\N	1	0	0	1573
65	1438177410	1438177410	1438371207	13583871	13583871@minmujer.gob.ve	9c47bc412a6637e096f21d8a9e8a6f90	\N	1	0	0	2232
123	1438388511	1438388511	1438388511	9413103	9413103@minmujer.gob.ve	ba14249059fb285f8cac4be710865f48	\N	1	0	0	3441
100	1438284484	1438284484	1438800439	6158658	6158658@minmujer.gob.ve	bce0a2f2085423c3695b172ae65c4afd	\N	1	0	0	594
112	1438370837	1438370837	1438963918	14286010	14286010@minmujer.gob.ve	4535479bd58fd99dda3fef5749289926	\N	1	0	0	3004
164	1438801479	1438801479	1444752885	18134266	18134266@minmujer.gob.ve	633cf3500515580be777b13fc6d32887	\N	1	0	0	609
408	1441637566	1441637566	1445023721	4425458	4425458@minmujer.gob.ve	af5259cbdd630a7965736db608280f73	\N	1	0	0	604
98	1438280835	1438280835	1438280836	10806120	10806120@minmujer.gob.ve	672e11d1fe2d51a4a69f8d191a7e669b	\N	1	0	0	1137
64	1438177197	1438177197	1438200385	18601305	18601305@minmujer.gob.ve	fc868cc11850ccddf80ca2cec28aa638	\N	1	0	0	3572
90	1438273121	1438273121	1439405286	14447974	14447974@minmujer.gob.ve	eac2c1fb09af927729205bb953655a15	\N	1	0	0	2247
111	1438370227	1438370227	1444757429	10518516	10518516@minmujer.gob.ve	c847fdb33f6c186f3f735d9f789de3de	\N	1	0	0	526
52	1438091582	1438091582	1438091583	14274536	14274536@minmujer.gob.ve	cd032fe16365bd3a8732506cc679c1fd	\N	1	0	0	4032
36	1437579426	1437579426	1438098116	18749418	18749418@minmujer.gob.ve	de01dc4bdb54bd69855f2b1d3afa94cf	\N	1	0	0	654
50	1438090616	1438090616	1438091512	17390008	17390008@minmujer.gob.ve	10adff799a0ae63eecff7020c6721b7f	\N	1	0	0	665
106	1438353617	1438353617	1441649135	6334930	6334930@minmujer.gob.ve	a4d31266f76ba02f192038d4c0aae78d	\N	1	0	0	3481
395	1441051220	1441051220	1441051220	18022820	18022820@minmujer.gob.ve	48658417d7f20e87be9501b76eccce56	\N	1	0	0	2807
83	1438261360	1438261360	1438261360	14679694	14679694@minmujer.gob.ve	d87a3fefc637a520d31fd4f15080a8ee	\N	1	0	0	1133
130	1438632778	1438632778	1438802192	6975603	6975603@minmujer.gob.ve	d3e839dfd412e4f8affe37665a4b530a	\N	1	0	0	4298
103	1438346628	1438346628	1438346628	9954857	9954857@minmujer.gob.ve	51fa94a75f6e1f9da6d3e780f4952a1c	\N	1	0	0	590
97	1438279951	1438279951	1438279952	15616860	15616860@minmujer.gob.ve	82f00b68907f0f1555f6ef72988ac747	\N	1	0	0	3657
75	1438184193	1438184193	1446043370	16021904	16021904@minmujer.gob.ve	48bb277fca87594c310ecf661481d938	\N	1	0	0	1587
160	1438797475	1438797475	1439220465	18577360	18577360@minmujer.gob.ve	3644b69d3153f9b11da5302a642a97a3	\N	1	0	0	4324
102	1438345973	1438345973	1438345973	12562149	12562149@minmujer.gob.ve	ff25de6e5c0e0d36106e5202c92299af	\N	1	0	0	4325
56	1438111183	1438111183	1438182848	23641335	23641335@minmujer.gob.ve	2294246409628d2c0ef8a86a6dd1be5e	\N	1	0	0	3444
80	1438196752	1438196752	1438280752	23634229	23634229@minmujer.gob.ve	dc9a4352882c5e50a0f5bd899e69cae7	\N	1	0	0	3984
63	1438177147	1438177147	1438369252	13140911	13140911@minmujer.gob.ve	4f0c168d3854daa4fa9361e680fffa6a	\N	1	0	0	3993
70	1438178845	1438178845	1438800265	13650699	13650699@minmujer.gob.ve	63cc98ed634be08d47fd9a3c5f3b61e7	\N	1	0	0	2512
96	1438279938	1438279938	1438279938	6230694	6230694@minmujer.gob.ve	7e1102e42320cc14491d66575f8f18b8	\N	1	0	0	1571
116	1438374545	1438374545	1438375165	10792937	10792937@minmujer.gob.ve	75e1db2864cc854957ac37087e13a09c	\N	1	0	0	3797
115	1438372684	1438372684	1438798458	10820273	10820273@minmujer.gob.ve	a374bae8edc01f36c5366ac4e5a537a2	\N	1	0	0	4315
60	1438176002	1438176002	1438345428	18040117	18040117@minmujer.gob.ve	705f7c46712edbd8008ae7f69642f87d	\N	1	0	0	4314
89	1438271529	1438271529	1438271529	11991324	11991324@minmujer.gob.ve	34eabf35a8cc63afde15373b88f6d25e	\N	1	0	0	1186
59	1438175884	1438175884	1438183870	16676119	16676119@minmujer.gob.ve	dfe712c08095a1ececc6c202c6b4cea3	\N	1	0	0	3252
95	1438279205	1438279205	1438781359	21706542	21706542@minmujer.gob.ve	2295c557ae267013157417fc3c886df5	\N	1	0	0	2803
135	1438782593	1438782593	1446570086	13374734	13374734@minmujer.gob.ve	3be803cd25b0c79d8300fd48dc40af08	\N	1	0	0	3261
99	1438282526	1438282526	1438282526	16473732	16473732@minmujer.gob.ve	7918a11c648771536ccc9dd2ad82cfc3	\N	1	0	0	2517
119	1438377605	1438377605	1438384588	6289494	6289494@minmujer.gob.ve	0e42c7e42530001493f809db14557969	\N	1	0	0	603
426	1444850824	1444850824	1444851727	6388696	6388696@minmujer.gob.ve	eb9cfc8ba8399ee67a36d3346b1dcf29	\N	1	0	0	4166
85	1438267118	1438267118	1438267119	6894760	6894760@minmujer.gob.ve	0fec441fb537069a37820f6a75b99057	\N	1	0	0	1183
114	1438371646	1438371646	1454100622	6288565	6288565@minmujer.gob.ve	fa4f5283a6be0e630434ef7925f2afbe	\N	1	0	0	4500
71	1438180001	1438180001	1438185175	6661126	6661126@minmujer.gob.ve	41bbdee57de032efabeebcc50fe57470	\N	1	0	0	595
118	1438377003	1438377003	1438378069	12866915	12866915@minmujer.gob.ve	0b506b71088d7a02bb2adbf30019290d	\N	1	0	0	2781
47	1438089185	1438089185	1438089185	16618915	16618915@minmujer.gob.ve	f70999467cbfb04662bb12bec3a28da2	\N	1	0	0	3873
61	1438176215	1438176215	1438177151	18041721	18041721@minmujer.gob.ve	c54e5ec3abf953edcae38ba3d0459fef	\N	1	0	0	1134
422	1444759666	1444759666	1444759666	19314040	19314040@minmujer.gob.ve	0c72afb63bd0c6089fc5b60bd096103e	\N	1	0	0	2254
101	1438286882	1438286882	1438286882	9848064	9848064@minmujer.gob.ve	e3dc2be6143edf9d9a1c34f3f8cdb88b	\N	1	0	0	2266
113	1438371505	1438371505	1438373164	15099451	15099451@minmujer.gob.ve	649cee4b85ea83994d0e4fc9c59e571b	\N	1	0	0	3903
108	1438354352	1438354352	1438354353	19510796	19510796@minmujer.gob.ve	54a48d478c1d087bb6c57ab9f83922b4	\N	1	0	0	4223
110	1438369873	1438369873	1438865873	13687990	13687990@minmujer.gob.ve	e6a0b5eb83dc0547ef304732701e894f	\N	1	0	0	3581
51	1438090709	1438090709	1438091516	10116310	10116310@minmujer.gob.ve	c554656ad1fe5a4a05ce41de89e8a04a	\N	1	0	0	4257
109	1438365767	1438365767	1438365767	10010493	10010493@minmujer.gob.ve	807a9077e9a546b3a90ddfa01c6ea8d1	\N	1	0	0	1658
182	1438972140	1438972140	1438972140	11488607	11488607@minmujer.gob.ve	2d78f79dfee0103585a1c9ecfa0207f8	\N	1	0	0	2820
168	1438866062	1438866062	1438958910	6482817	6482817@minmujer.gob.ve	010ec4fbc3b0df3685ea64c46e353748	\N	1	0	0	4525
28	1437054964	1437054964	1440007964	14059784	14059784@minmujer.gob.ve	95547c9b6af644523bbb784b5c8464f2	\N	1	0	0	3802
190	1439229767	1439229767	1439229841	19199072	19199072@minmujer.gob.ve	cdf181dde6a516d5c41fef03a5de65c2	\N	1	0	0	2652
175	1438884995	1438884995	1438884996	19388496	19388496@minmujer.gob.ve	073d19949d48279a5d256fc3a01f77fd	\N	1	0	0	3461
26	1436967143	1436967143	1439843326	20130623	20130623@minmujer.gob.ve	62db99af5057870058a6cbdc94ab8b54	\N	1	0	0	2268
375	1440001621	1440001621	1440014470	12910804	12910804@minmujer.gob.ve	4b8400913e4d0664bab4e221969fdfc9	\N	1	0	0	3855
27	1437053390	1437053390	1438973204	22026847	22026847@minmujer.gob.ve	e8685d0020a412c8e528d7a5d70838fa	\N	1	0	0	2522
377	1440001981	1440001981	1440001981	20365107	20365107@minmujer.gob.ve	48bb277fca87594c310ecf661481d938	\N	1	0	0	2791
181	1438971412	1438971412	1443707851	23709495	23709495@minmujer.gob.ve	ae75b895689d74f9c5a1baae54ff8a4a	\N	1	0	0	3831
20	1429623384	1429623384	1438888410	23529925	23529925@minmujer.gob.ve	af4ac2f138efb9acc241866a9e00aa35	\N	1	0	0	4038
25	1436966819	1436966819	1439301766	16719809	16719809@minmujer.gob.ve	9b9e1a343ae70483d5160383aec75ce1	\N	1	0	0	3446
177	1438957757	1438957757	1438960315	17857000	17857000@minmujer.gob.ve	18a8c13b5ee2d281060c29ed3aa18029	\N	1	0	0	4432
166	1438804083	1438804083	1438804083	11900959	11900959@minmujer.gob.ve	fb687f78d36103f064372a9bc94160c4	\N	1	0	0	2763
153	1438790697	1438790697	1438790698	11669766	11669766@minmujer.gob.ve	411133172e2a86fe1215e8be8f112718	\N	1	0	0	4155
180	1438960851	1438960851	1438960852	24147464	24147464@minmujer.gob.ve	67b8699519869dd3ecfd4c3ef8b39fc9	\N	1	0	0	4165
179	1438958451	1438958451	1438958451	15369566	15369566@minmujer.gob.ve	75be7425676cd8a82a80fbf04118b5bf	\N	1	0	0	4351
141	1438788095	1438788095	1438788368	20329509	20329509@minmujer.gob.ve	cb9279c8d00e8a489f4f40ce1bf34547	\N	1	0	0	4156
368	1439914841	1439914841	1440008201	16541839	16541839@minmujer.gob.ve	70a4350db676d5cbc580edc7dda98740	\N	1	0	0	919
281	1439496392	1439496392	1439496393	12432595	12432595@minmujer.gob.ve	0a985bc81791e97f0a78ab33a58ba790	\N	1	0	0	1219
420	1444752584	1444752584	1444752584	20781961	20781961@minmujer.gob.ve	937f55c4e0898dcf2fe52e7f293dbbb3	\N	1	0	0	4557
55	1438095891	1438095891	1438095895	18091920	18091920@minmujer.gob.ve	31cca568727a967df12f0417cb12f980	\N	1	0	0	3693
350	1439608174	1439608174	1439610779	15866812	15866812@minmujer.gob.ve	e45b2ac6dcd00d359acc231dd2d02759	\N	1	0	0	902
155	1438792081	1438792081	1447860191	14050109	14050109@minmujer.gob.ve	54afd81ff4a759b06039df7dca02eefe	\N	1	0	0	4157
324	1439572013	1439572013	1439584882	16353541	16353541@minmujer.gob.ve	23d9655186fad465602cd0d427a093e4	\N	1	0	0	3333
136	1438786159	1438786159	1438955660	17392780	17392780@minmujer.gob.ve	88fb7b1d4f8c2cce205282bfc6ad4bfe	\N	1	0	0	4513
450	1447182035	\N	\N	4115975	sarratia@minmujer.gob.ve	1da02ff59714028bd15a3faa7a7b0be0	0fe0225b97113fa8bb37aec2740c018b	1	0	0	4533
246	1439473797	1439473797	1439473797	5178945	5178945@minmujer.gob.ve	5cd57ae33383d7f16da4ff9a1bafb6da	\N	2	0	0	3573
442	1447098131	\N	1454090444	10024864	hrodriguez@minmujer.gob.ve	e5de3eba33c6b18babc26bec428ff8fc	1bdec453896edb42bd28926d2829ae5f	1	0	0	2822
404	1441213900	1441213900	1454512116	7375562	hmachado@minmujer.gob.ve	fa885cb38e090a1a54446fca858a3d97	\N	1	0	0	4527
466	1453749088	\N	\N	10910946	wrumbos@minmujer.gob.ve	7f5ac64ae1b91c5d20bdb0c93a7964ff	faa1971c75a09ac87f1b255201e4ec70	1	0	0	\N
465	1453748338	\N	\N	4952287	mguerra@minmujer.gob.ve	7f4fda343e221776571d271e1f04a3bf	b6f9c55e9751c4fa4adf13da9c4bd640	1	0	0	4471
24	1436908346	1436908346	1453821567	6189428	ahenriquez@minmujer.gob.ve	b4a43c067ba9d945ac27ece881c8c6a1	\N	1	0	0	4472
54	1438093305	1438093305	1454076808	16671539	16671539@minmujer.gob.ve	358a2d31b86d900bd629d99a5e5a92d0	\N	1	0	0	651
178	1438957839	1438957839	1454006882	20301688	asandoval@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	4191
467	1453750126	\N	1454442221	11064318	lgomezl@minmujer.gob.ve	35daa06ca35d913f6f85624ee9cd6abf	b6c8676adec63b5f3214fc20539c5f5f	1	0	0	696
162	1438800771	1438800771	1454439738	10629699	10629699@minmujer.gob.ve	0c3ab41d8485bca40f24bf3e9b95e10a	\N	1	0	0	1189
87	1438270449	1438270449	1454077588	15541016	15541016@minmujer.gob.ve	739e2999be52a0192f83bffcad8e16d7	\N	1	0	0	588
29	1437145095	1437145095	1453822116	13563857	13563857@minmujer.gob.ve	8a88da2d1c8ccf69c6ad74eb51988f24	\N	1	0	0	1127
471	1453835864	1453835864	1453987897	12912432	12912432@minmujer.gob.ve	fba96c3477dc4835dcd5b789aed8a9be	\N	1	0	0	\N
23	1436905310	1436905310	1453832208	14073418	arodriguez@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	2889
446	1447099254	\N	1453832095	12779178	lpuentes@minmujer.gob.ve	9c6ddd30eae07a700ce8dcc5ec02cc2d	cf7750e05b0380306646d7af9c18d216	1	0	0	854
382	1440016356	1440016356	1453832229	17158970	17158970@minmujer.gob.ve	f66cdcd62ab83cb33cdbf0b400714087	\N	1	0	0	1493
41	1437593201	1437593201	1454516172	5525794	5525794@minmujer.gob.ve	1a8e8945bf3ae3185a9feabe1fb91406	\N	1	0	0	1229
469	1453750802	\N	1453843985	17426252	jvillarreal@minmujer.gob.ve	bbfff0205591f2ef43bcb789cdd05a40	3008d14dcc4292b362a1b8d3d1c2d136	1	0	0	3484
470	1453750892	\N	1454091489	6478060	jorodriguez@minmujer.gob.ve	c731b413ba5ad26ad54c492dd9bf0a64	9327230603cb2e90b914fe676f73e96b	1	0	0	4642
468	1453750519	\N	1454094121	16101603	jfuenmayor@minmujer.gob.ve	042152452a4794754e34f487477d9be9	52d72acad03a449089cadafa0e6546ec	1	0	0	4616
233	1439423112	1439423112	1453836440	6958153	6958153@minmujer.gob.ve	8e2e64d7a9a92182ba0b81055d73fbe7	\N	1	0	0	912
235	1439430300	1439430300	1453836559	17866061	17866061@minmujer.gob.ve	49646ab6e4eec5c43b35159ec34c4c98	\N	1	0	0	4532
245	1439472685	1439472685	1453836802	7496753	7496753@minmujer.gob.ve	1a9a36bc4d03156e512fcb28e1539347	\N	1	0	0	821
22	1435852087	1435852087	1454689060	18528414	hviloria@minmujer.gob.ve	99a3df6c3d63f083f705b3af0fbaf678	\N	1	0	0	647
11	1426278589	1426278589	1455904909	16249561	nespinoza@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	1401
1	\N	\N	1458432398	admin	admin@tucorreo.com	cce868a097d54c64229f71de9a6ca147	\N	1	0	0	\N
355	1439776758	1439776758	1458458612	15911540	15911540@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	4103
462	1449065675	1449065675	1458458660	21281617	cvelasquez@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	\N	1	0	0	4612
437	1446588539	\N	1458458727	12880477	yalmenar@minmujer.gob.ve	e10adc3949ba59abbe56e057f20f883e	fd3c8c4cf412a4551b62bec304db4cd6	1	0	0	4528
\.


--
-- Name: cruge_user_iduser_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cruge_user_iduser_seq', 471, true);


--
-- Data for Name: maestro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY maestro (id_maestro, descripcion, padre, hijo, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date, descripcion2) FROM stdin;
36	4.02.01.03.00 Productos agrícolas y pecuarios	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
37	4.02.01.04.00 Productos de la caza y pesca	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
38	4.02.01.99.00 Otros productos alimenticios y agropecuarios	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
39	4.02.02.00.00 Productos de minas, canteras y yacimientos	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
40	4.02.02.01.00 Carbón mineral	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
41	4.02.02.02.00 Petróleo crudo y gas natural	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
42	4.02.02.03.00 Mineral de hierro	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
43	4.02.02.04.00 Mineral no ferroso	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
44	4.02.02.05.00 Piedra, arcilla, arena y tierra	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
49	4.02.03.01.00 Textiles	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
50	4.02.03.02.00 Prendas de vestir	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
51	4.02.03.03.00 Calzados	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
52	4.02.03.99.00 Otros productos textiles y vestuarios	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
53	4.02.04.00.00 Productos de cuero y caucho	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
54	4.02.04.01.00 Cueros y pieles	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
55	4.02.04.02.00 Productos de cuero y sucedáneos del cuero	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
57	4.02.04.99.00 Otros productos de cuero y caucho	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
58	4.02.05.00.00 Productos de papel, cartón e impresos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
59	4.02.05.01.00 Pulpa de madera, papel y cartón	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
60	4.02.05.02.00 Envases y cajas de papel y cartón	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
61	4.02.05.03.00 Productos de papel y cartón para oficina	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
62	4.02.05.04.00 Libros, revistas y periódicos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
63	4.02.05.05.00 Material de enseñanza	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
64	4.02.05.06.00 Productos de papel y cartón para computación	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
65	4.02.05.07.00 Productos de papel y cartón para la imprenta y reproducción	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
66	4.02.05.99.00 Otros productos de pulpa, papel y cartón	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
67	4.02.06.00.00 Productos químicos y derivados	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
68	4.02.06.01.00 Sustancias químicas y de uso industrial	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
69	4.02.06.02.00 Abonos, plaguicidas y otros	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
70	4.02.06.03.00 Tintas, pinturas y colorantes	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
71	4.02.06.04.00 Productos farmacéuticos y medicamentos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
72	4.02.06.05.00 Productos de tocador	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
73	4.02.06.06.00 Combustibles y lubricantes	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
74	4.02.06.07.00 Productos diversos derivados del petróleo y del carbón	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
75	4.02.06.08.00 Productos plásticos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
76	4.02.06.09.00 Mezclas explosivas	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
77	4.02.06.99.00 Otros productos de la industria química y conexos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
78	4.02.07.00.00 Productos minerales no metálicos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
79	4.02.07.01.00 Productos de barro, loza y porcelana	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
80	4.02.07.02.00 Vidrios y productos de vidrio	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
81	4.02.07.03.00 Productos de arcilla para construcción	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
82	4.02.07.04.00 Cemento, cal y yeso	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
83	4.02.07.99.00 Otros productos minerales no metálicos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
84	4.02.08.00.00 Productos metálicos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
85	4.02.08.01.00 Productos primarios de hierro y acero	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
86	4.02.08.02.00 Productos de metales no ferrosos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
87	4.02.08.03.00 Herramientas menores, cuchillería y artículos generales de ferretería	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
88	4.02.08.04.00 Productos metálicos estructurales	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
89	4.02.08.05.00 Materiales de orden público, seguridad y defensa	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
90	4.02.08.07.00 Material de señalamiento	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
91	4.02.08.08.00 Material de educación	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
92	4.02.08.09.00 Repuestos y accesorios para equipos de transporte	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
93	4.02.08.10.00 Repuestos y accesorios para otros equipos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
94	4.02.08.99.00 Otros productos metálicos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
95	4.02.09.00.00 Productos de madera	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
96	4.02.09.01.00 Productos primarios de madera	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
97	4.02.09.02.00 Muebles y accesorios de madera para edificaciones	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
98	4.02.09.99.00 Otros productos de madera	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
99	4.02.10.00.00 Productos varios y útiles diversos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
100	4.02.10.01.00 Artículos de deporte, recreación y juguetes	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
101	4.02.10.02.00 Materiales y útiles de limpieza y aseo	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
102	4.02.10.03.00 Utensilios de cocina y comedor	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
7	00102 OFICINA DE GESTIÓN ADMINISTRATIVA	5	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
5	UNIDADES EJECUTORAS	0	5	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
45	4.02.02.06.00 Mineral para la fabricación de productos químicos	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
46	4.02.02.07.00 Sal para uso industrial	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
47	4.02.02.99.00 Otros productos de minas, canteras y yacimientos	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
48	4.02.03.00.00 Textiles y vestuarios	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
56	4.02.04.03.00 Cauchos y tripas para vehículos	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
33	4.02.01.00.00 Productos alimenticios y agropecuarios	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
34	4.02.01.01.00 Alimentos y bebidas para personas	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
35	4.02.01.02.00 Alimentos para animales	32	0	t	\N	1	2015-03-06 12:01:42.087782	\N	2015-03-06 12:01:42.087782	\N
103	4.02.10.04.00 Útiles menores médico - quirúrgicos de laboratorio, dentales y de veterinaria	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
104	4.02.10.05.00 Útiles de escritorio, oficina y materiales de instrucción	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
122	4.03.00.00.00 SERVICIOS NO PERSONALES	0	96	t	\N	1	2015-03-06 16:56:15.152495	\N	2015-03-06 16:56:15.152495	\N
123	4.03.01.00.00 Alquileres de inmuebles	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
124	4.03.01.01.00 Alquileres de edificios y locales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
125	4.03.01.02.00 Alquileres de instalaciones culturales y recreativas	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
126	4.03.01.03.00 Alquileres de tierras y terrenos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
127	4.03.02.00.00 Alquileres de maquinaria y equipos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
128	4.03.02.01.00 Alquileres de maquinaria y demás equipos de construcción,campo, industria y taller	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
129	4.03.02.02.00 Alquileres de equipos de transporte, tracción y elevación	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
130	4.03.02.03.00 Alquileres de equipos de comunicaciones y de señalamiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
131	4.03.02.04.00 Alquileres de equipos médico - quirúrgicos, dentales y de veterinaria	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
132	4.03.02.05.00 Alquileres de equipos científicos, religiosos, de enseñanza y recreación	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
133	4.03.02.06.00 Alquileres de máquinas, muebles y demás equipos de oficina y alojamiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
134	4.03.02.99.00 Alquileres de otras maquinaria y equipos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
135	4.03.03.00.00 Derechos sobre bienes intangibles	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
136	4.03.03.01.00 Marcas de fábrica y patentes de invención	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
137	4.03.03.02.00 Derechos de autor	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
138	4.03.03.03.00 Paquetes y programas de computación	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
139	4.03.03.04.00 Concesión de bienes y servicios	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
140	4.03.04.00.00 Servicios básicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
141	4.03.04.01.00 Electricidad	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
142	4.03.04.02.00 Gas	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
143	4.03.04.03.00 Agua	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
144	4.03.04.04.00 Teléfonos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
145	4.03.04.05.00 Servicio de comunicaciones	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
146	4.03.04.06.00 Servicio de aseo urbano y domiciliario	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
147	4.03.04.07.00 Servicio de condominio	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
148	4.03.05.00.00 Servicio de administración, vigilancia y mantenimiento de los servicios básicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
149	4.03.05.01.00 Servicio de administración, vigilancia y mantenimiento del servicio de electricidad	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
150	4.03.05.02.00 Servicio de administración, vigilancia y mantenimiento del servicio de gas	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
151	4.03.05.03.00 Servicio de administración, vigilancia y mantenimiento del servicio de agua	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
152	4.03.05.04.00 Servicio de administración, vigilancia y mantenimiento del servicio de teléfonos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
153	4.03.05.05.00 Servicio de administración, vigilancia y mantenimiento del servicio de comunicaciones	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
154	4.03.05.06.00 Servicio de administración, vigilancia y mantenimiento del servicio de aseo urbano y domiciliario	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
155	4.03.06.00.00 Servicios de transporte y almacenaje	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
11	NACIONALIDAD	0	2	t	\N	1	2015-03-06 11:08:09.370747	\N	2015-03-06 11:08:09.370747	\N
12	V	11	0	t	\N	1	2015-03-06 11:08:24.499217	\N	2015-03-06 11:08:24.499217	\N
13	E	11	0	t	\N	1	2015-03-06 11:08:42.895278	\N	2015-03-06 11:08:42.895278	\N
14	FUENTE DE FINANCIAMIENTO	0	2	t	\N	1	2015-03-06 11:21:09.995038	\N	2015-03-06 11:21:09.995038	\N
15	1	14	0	t	\N	1	2015-03-06 11:21:29.075401	\N	2015-03-06 11:21:29.075401	\N
16	7	14	0	t	\N	1	2015-03-06 11:21:38.571717	\N	2015-03-06 11:21:38.571717	\N
19	GRAMO	17	0	t	\N	1	2015-03-06 11:30:42.295028	\N	2015-03-06 11:30:42.295028	\N
20	PIEZA	17	0	t	\N	1	2015-03-06 11:30:54.655343	\N	2015-03-06 11:30:54.655343	\N
21	GALON	17	0	t	\N	1	2015-03-06 11:31:06.431501	\N	2015-03-06 11:31:06.431501	\N
22	UNIDAD	17	0	t	\N	1	2015-03-06 11:31:15.967728	\N	2015-03-06 11:31:15.967728	\N
23	METRO	17	0	t	\N	1	2015-03-06 11:31:24.087887	\N	2015-03-06 11:31:24.087887	\N
24	LITRO	17	0	t	\N	1	2015-03-06 11:31:35.688112	\N	2015-03-06 11:31:35.688112	\N
18	KILOGRAMO	17	0	t	\N	1	2015-03-06 11:30:29.934713	\N	2015-03-06 11:30:29.934713	\N
25	PULGADA	17	0	t	\N	1	2015-03-06 11:32:28.71324	\N	2015-03-06 11:32:28.71324	\N
26	ONZA	17	0	t	\N	1	2015-03-06 11:33:49.179016	\N	2015-03-06 11:33:49.179016	\N
28	M2	17	0	t	\N	1	2015-03-06 11:35:00.940404	\N	2015-03-06 11:35:00.940404	\N
29	M3	17	0	t	\N	1	2015-03-06 11:35:32.127877	\N	2015-03-06 11:35:32.127877	\N
27	CM3	17	0	t	\N	1	2015-03-06 11:34:20.88351	\N	2015-03-06 11:34:20.88351	\N
30	ML	17	0	t	\N	1	2015-03-06 11:36:00.237595	\N	2015-03-06 11:36:00.237595	\N
31	SACO	17	0	t	\N	1	2015-03-06 11:36:52.974308	\N	2015-03-06 11:36:52.974308	\N
1	TIPO DE REQUISICION	0	3	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
156	4.03.06.01.00 Fletes y embalajes	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
9	00104 DESPACHO DE LA VICEMINISTRA DE DESARROLLO PRODUCTIVO DE LA MUJER	5	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
157	4.03.06.02.00 Almacenaje	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
158	4.03.06.03.00 Estacionamiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
159	4.03.06.04.00 Peaje	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
160	4.03.06.05.00 Servicios de protección en traslado de fondos y de mensajería	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
161	4.03.07.00.00 Servicios de información, impresión y relaciones públicas	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
162	4.03.07.01.00 Publicidad y propaganda	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
163	4.03.07.02.00 Imprenta y reproducción	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
164	4.03.07.03.00 Relaciones sociales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
165	4.03.07.04.00 Avisos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
166	4.03.08.00.00 Primas y otros gastos de seguros y comisiones bancarias	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
167	4.03.08.01.00 Primas y gastos de seguros	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
168	4.03.08.02.00 Comisiones y gastos bancarios	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
169	4.03.08.03.00 Comisiones y gastos de adquisición de seguros	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
170	4.03.09.00.00 Viáticos y pasajes	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
171	4.03.09.01.00 Viáticos y pasajes dentro del país	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
172	4.03.09.02.00 Viáticos y pasajes fuera del país	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
173	4.03.09.03.00 Asignación por kilómetros recorridos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
174	4.03.10.00.00 Servicios profesionales y técnicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
175	4.03.10.01.00 Servicios jurídicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
176	4.03.10.02.00 Servicios de contabilidad y auditoría	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
177	4.03.10.03.00 Servicios de procesamiento de datos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
178	4.03.10.04.00 Servicios de ingeniería y arquitectónicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
179	4.03.10.05.00 Servicios médicos, odontológicos y otros servicios de sanidad	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
180	4.03.10.06.00 Servicios de veterinaria	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
181	4.03.10.07.00 Servicios de capacitación y adiestramiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
182	4.03.10.08.00 Servicios presupuestarios	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
183	4.03.10.09.00 Servicios de lavandería y tintorería	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
184	4.03.10.10.00 Servicios de vigilancia	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
185	4.03.10.11.00 Servicios para la elaboración y suministro de comida	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
186	4.03.10.99.00 Otros servicios profesionales y técnicos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
187	4.03.11.00.00 Conservación y reparaciones menores de maquinaria y equipos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
188	4.03.11.01.00 Conservación y reparaciones menores de maquinaria y demás equipos de construcción, campo, industria y taller	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
189	4.03.11.02.00 Conservación y reparaciones menores de equipos de transporte, tracción y elevación	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
190	4.03.11.03.00 Conservación y reparaciones menores de equipos de comunicaciones y de señalamiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
191	4.03.11.04.00 Conservación y reparaciones menores de equipos médico-quirúrgicos, dentales y de veterinaria	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
192	4.03.11.05.00 Conservación y reparaciones menores de equipos científicos, religiosos, de enseñanza y recreación	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
193	4.03.11.06.00 Conservación y reparaciones menores de equipos y armamentos de orden público, seguridad y defensa nacional	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
2	BIENES MUEBLES	1	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
3	MATERIALES Y SUMINISTROS	1	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
4	SERVICIOS	1	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
32	4.02.00.00.00 MATERIALES, SUMINISTROS Y MERCANCÍAS	0	89	t	\N	1	2015-03-06 11:56:20.257667	\N	2015-03-06 11:56:20.257667	\N
194	4.03.11.07.00 Conservación y reparaciones menores de máquinas, muebles y demás equipos de oficina y alojamiento	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
195	4.03.11.99.00 Conservación y reparaciones menores de otras maquinaria y equipos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
196	4.03.12.00.00 Conservación y reparaciones menores de obras	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
197	4.03.12.01.00 Conservación y reparaciones menores de obras en bienes del dominio privado	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
198	4.03.12.02.00 Conservación y reparaciones menores de obras en bienes del dominio público	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
199	4.03.13.00.00 Servicios de construcciones temporales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
200	4.03.13.01.00 Servicios de construcciones temporales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
201	4.03.14.00.00 Servicios de construcción de edificaciones para la venta	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
202	4.03.14.01.00 Servicios de construcción de edificaciones para la venta	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
203	4.03.15.00.00 Servicios fiscales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
204	4.03.15.01.00 Derechos de importación y servicios aduaneros	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
205	4.03.15.02.00 Tasas y otros derechos obligatorios	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
206	4.03.15.03.00 Asignación a agentes de especies fiscales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
207	4.03.15.99.00 Otros servicios fiscales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
208	4.03.16.00.00 Servicios de diversión, esparcimiento y culturales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
209	4.03.16.01.00 Servicios de diversión, esparcimiento y culturales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
210	4.03.17.00.00 Servicios de gestión administrativa organismos de asistencia técnica	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
211	4.03.17.01.00 Servicios de gestión administrativa prestados por organismos de asistencia técnica	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
212	4.03.18.00.00 Impuestos indirectos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
105	4.02.10.06.00 Condecoraciones, ofrendas y similares	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
106	4.02.10.07.00 Productos de seguridad en el trabajo	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
107	4.02.10.08.00 Materiales para equipos de computación	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
108	4.02.10.09.00 Especies timbradas y valores	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
109	4.02.10.10.00 Útiles religiosos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
110	4.02.10.11.00 Materiales eléctricos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
111	4.02.10.12.00 Materiales para instalaciones sanitarias	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
112	4.02.10.13.00 Materiales fotográficos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
113	4.02.10.99.00 Otros productos y útiles diversos	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
114	4.02.11.00.00 Bienes para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
115	4.02.11.01.00 Productos y artículos para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
116	4.02.11.02.00 Maquinarias y equipos para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
117	4.02.11.03.00 Inmuebles para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
118	4.02.11.04.00 Tierras y terrenos para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
119	4.02.11.99.00 Otros bienes para la venta	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
120	4.02.99.00.00 Otros materiales y suministros	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
121	4.02.99.01.00 Otros materiales y suministros	32	0	t	\N	1	2015-03-06 12:21:55.057843	\N	2015-03-06 12:21:55.057843	\N
213	4.03.18.01.00 Impuesto al valor agregado	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
214	4.03.18.99.00 Otros impuestos indirectos	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
215	4.03.19.00.00 Comisiones por servicios para cumplir con los beneficios sociales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
216	4.03.19.01.00 Comisiones por servicios para cumplir con los beneficios sociales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
217	4.03.99.00.00 Otros servicios no personales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
218	4.03.99.01.00 Otros servicios no personales	122	0	t	\N	1	2015-03-06 16:56:31.648259	\N	2015-03-06 16:56:31.648259	\N
17	UNIDAD DE MEDIDAD	0	17	t	\N	1	2015-03-06 11:30:08.838399	\N	2015-03-06 11:30:08.838399	\N
219	4.04.00.00.00 ACTIVOS REALES	0	112	t	\N	1	2015-03-17 10:14:45.985267	\N	2015-03-17 10:14:45.985267	\N
220	4.04.01.00.00 Repuestos y reparaciones mayores	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
221	4.04.01.01.00 Repuestos mayores	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
222	4.04.01.01.01 Repuestos mayores para maquinaria y demás equipos deconstrucción, campo, industria y taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
223	4.04.01.01.02 Repuestos mayores para equipos de transporte, tracción yelevación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
224	4.04.01.01.03 Repuestos mayores para equipos de comunicaciones y deseñalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
225	4.04.01.01.04 Repuestos mayores para equipos médico-quirúrgicos, dentalesy de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
226	4.04.01.01.05 Repuestos mayores para equipos científicos, religiosos, deenseñanza y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
227	4.04.01.01.06 Repuestos mayores para equipos y armamentos de ordenpúblico, seguridad y defensa	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
228	4.04.01.01.07 Repuestos mayores para máquinas, muebles y demás equiposde oficina y alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
229	4.04.01.01.99 Repuestos mayores para otras maquinaria y equipos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
230	4.04.01.02.00 Reparaciones mayores de maquinaria y equipos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
231	4.04.01.02.01 Reparaciones mayores de maquinaria y demás equipos deconstrucción, campo, industria y taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
232	4.04.01.02.02 Reparaciones mayores de equipos de transporte, tracción yelevación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
233	4.04.01.02.03 Reparaciones mayores de equipos de comunicaciones y deseñalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
234	4.04.01.02.04 Reparaciones mayores de equipos médico - quirúrgicos,dentales y de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
235	4.04.01.02.05 Reparaciones mayores de equipos científicos, religiosos, deenseñanza y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
236	4.04.01.02.06 Reparaciones mayores de equipos y armamentos de ordenpúblico, seguridad y defensa nacional	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
237	4.04.01.02.07 Reparaciones mayores de máquinas, muebles y demásequipos de oficina y alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
238	4.04.01.02.99 Reparaciones mayores de otras maquinaria y equipos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
239	4.04.02.00.00 Conservación, ampliaciones y mejoras mayores de obras	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
240	4.04.02.01.00 Conservación, ampliaciones y mejoras mayores de obras enbienes del dominio privado	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
241	4.04.02.02.00 Conservación, ampliaciones y mejoras mayores de obras enbienes del dominio público	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
242	4.04.03.00.00 Maquinaria y demás equipos de construcción, campo,industria y taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
243	4.04.03.01.00 Maquinaria y demás equipos de construcción y mantenimiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
244	4.04.03.02.00 Maquinaria y equipos para mantenimiento de automotores	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
245	4.04.03.03.00 Maquinaria y equipos agrícolas y pecuarios	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
246	4.04.03.04.00 Maquinaria y equipos de artes gráficas y reproducción	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
247	4.04.03.05.00 Maquinaria y equipos industriales y de taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
248	4.04.03.06.00 Maquinaria y equipos de energía	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
249	4.04.03.07.00 Maquinaria y equipos de riego y acueductos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
250	4.04.03.08.00 Equipos de almacén	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
312	4.04.14.00.00 Contratación de inspección de obras	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
251	4.04.03.99.00 Otra maquinaria y demás equipos de construcción, campo,industria y taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
252	4.04.04.00.00 Equipos de transporte, tracción y elevación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
253	4.04.04.01.00 Vehículos automotores terrestres	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
254	4.04.04.02.00 Equipos ferroviarios y de cables aéreos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
255	4.04.04.03.00 Equipos marítimos de transporte	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
256	4.04.04.04.00 Equipos aéreos de transporte	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
257	4.04.04.05.00 Vehículos de tracción no motorizados	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
258	4.04.04.06.00 Equipos auxiliares de transporte	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
259	4.04.04.99.00 Otros equipos de transporte, tracción y elevación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
260	4.04.05.00.00 Equipos de comunicaciones y de señalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
261	4.04.05.01.00 Equipos de telecomunicaciones	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
262	4.04.05.02.00 Equipos de señalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
263	4.04.05.03.00 Equipos de control de tráfico aéreo	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
264	4.04.05.04.00 Equipos de correo	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
265	4.04.05.99.00 Otros equipos de comunicaciones y de señalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
266	4.04.06.00.00 Equipos médico - quirúrgicos, dentales y de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
267	4.04.06.01.00 Equipos médico - quirúrgicos, dentales y de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
268	4.04.06.99.00 Otros equipos médico - quirúrgicos, dentales y de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
269	4.04.07.00.00 Equipos científicos, religiosos, de enseñanza y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
270	4.04.07.01.00 Equipos científicos y de laboratorio	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
271	4.04.07.02.00 Equipos de enseñanza, deporte y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
272	4.04.07.03.00 Obras de arte	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
273	4.04.07.04.00 Libros, revistas y otros instrumentos de enseñanzas	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
274	4.04.07.05.00 Equipos religiosos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
275	4.04.07.06.00 Instrumentos musicales y equipos de audio	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
276	4.04.07.99.00 Otros equipos científicos, religiosos, de enseñanza y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
277	4.04.08.00.00 Equipos y armamentos de orden público, seguridad y defensa	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
278	4.04.08.01.00 Equipos y armamentos de orden público, seguridad y defensa nacional	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
279	4.04.08.02.00 Equipos y armamentos de seguridad para la custodia y resguardo personal	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
280	4.04.08.99.00 Otros equipos y armamentos de orden público, seguridad y defensa	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
281	4.04.09.00.00 Máquinas, muebles y demás equipos de oficina y alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
282	4.04.09.01.00 Mobiliario y equipos de oficina	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
283	4.04.09.02.00 Equipos de computación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
284	4.04.09.03.00 Mobiliario y equipos de alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
285	4.04.09.99.00 Otras máquinas, muebles y demás equipos de oficina y alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
286	4.04.10.00.00 Semovientes	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
287	4.04.10.01.00 Semovientes	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
288	4.04.11.00.00 Inmuebles, maquinaria y equipos usados	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
289	4.04.11.01.00 Adquisición de tierras y terrenos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
290	4.04.11.02.00 Adquisición de edificios e instalaciones	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
291	4.04.11.03.00 Expropiación de tierras y terrenos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
292	4.04.11.04.00 Expropiación de edificios e instalaciones	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
293	4.04.11.05.00 Adquisición de maquinaria y equipos usados	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
294	4.04.11.05.01 Maquinaria y demás equipos de construcción, campo, industria y taller	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
295	4.04.11.05.02 Equipos de transporte, tracción y elevación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
296	4.04.11.05.03 Equipos de comunicaciones y de señalamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
297	4.04.11.05.04 Equipos médico - quirúrgicos, dentales y de veterinaria	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
298	4.04.11.05.05 Equipos científicos, religiosos, de enseñanza y recreación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
299	4.04.11.05.06 Equipos para seguridad pública	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
300	4.04.11.05.07 Máquinas, muebles y demás equipos de oficina y alojamiento	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
301	4.04.11.05.99 Otras maquinaria y equipos usados	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
302	4.04.12.00.00 Activos intangibles	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
303	4.04.12.01.00 Marcas de fábrica y patentes de invención	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
304	4.04.12.02.00 Derechos de autor	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
305	4.04.12.03.00 Gastos de organización	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
306	4.04.12.04.00 Paquetes y programas de computación	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
307	4.04.12.05.00 Estudios y proyectos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
308	4.04.12.99.00 Otros activos intangibles	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
309	4.04.13.00.00 Estudios y proyectos para inversión en activos fijos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
310	4.04.13.01.00 Estudios y proyectos aplicables a bienes del dominio privado	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
311	4.04.13.02.00 Estudios y proyectos aplicables a bienes del dominio público	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
525	ESTATUS DATOS REQUISICION	0	2	t	\N	1	2015-03-18 15:04:30.810929	\N	2015-03-18 15:04:30.810929	\N
313	4.04.14.01.00 Contratación de inspección de obras de bienes del dominioprivado	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
314	4.04.14.02.00 Contratación de inspección de obras de bienes del dominiopúblico	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
315	4.04.15.00.00 Construcciones del dominio privado	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
316	4.04.15.01.00 Construcciones de edificaciones médico-asistenciales	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
623	ESPIRAL NEGRO 9MM	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
317	4.04.15.02.00 Construcciones de edificaciones militares y de seguridad	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
318	4.04.15.03.00 Construcciones de edificaciones educativas, religiosas yrecreativas	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
319	4.04.15.04.00 Construcciones de edificaciones culturales y deportivas	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
320	4.04.15.05.00 Construcciones de edificaciones para oficina	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
321	4.04.15.06.00 Construcciones de edificaciones industriales	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
322	4.04.15.07.00 Construcciones de edificaciones habitacionales	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
323	4.04.15.99.00 Otras construcciones del dominio privado	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
324	4.04.16.00.00 Construcciones del dominio público	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
325	4.04.16.01.00 Construcción de vialidad	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
326	4.04.16.02.00 Construcción de plazas, parques y similares	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
327	4.04.16.03.00 Construcciones de instalaciones hidráulicas	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
328	4.04.16.04.00 Construcciones de puertos y aeropuertos	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
329	4.04.16.99.00 Otras construcciones del dominio público	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
330	4.04.99.00.00 Otros activos reales	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
331	4.04.99.01.00 Otros activos reales	219	0	t	\N	1	2015-03-17 10:17:04.542581	\N	2015-03-17 10:17:04.542581	\N
332	4.07.00.00.00 TRANSFERENCIAS Y DONACIONES	0	192	t	\N	1	2015-03-18 12:06:28.555299	\N	2015-03-18 12:06:28.555299	\N
333	4.07.01.00.00 Transferencias y donaciones corrientes internas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
334	4.07.01.01.00 Transferencias corrientes internas al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
335	4.07.01.01.01 Pensiones del personal empleado, obrero y militar	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
336	4.07.01.01.02 Jubilaciones del personal empleado, obrero y militar	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
337	4.07.01.01.03 Becas escolares	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
338	4.07.01.01.04 Becas universitarias en el país	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
339	4.07.01.01.05 Becas de perfeccionamiento profesional en el país	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
340	4.07.01.01.06 Becas para estudios en el extranjero	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
341	4.07.01.01.07 Otras becas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
342	4.07.01.01.08 Previsión por accidentes de trabajo	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
343	4.07.01.01.09 Aguinaldos al personal empleado, obrero y militar pensionado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
344	4.07.01.01.10 Aportes a caja de ahorro del personal empleado, obrero ymilitar pensionado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
345	4.07.01.01.11 Aportes a los servicios de salud, accidentes personales ygastos funerarios del personal empleado, obrero y militarpensionado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
346	4.07.01.01.12 Otras subvenciones socio - económicasdelpersonalempleado, obrero y militar pensionado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
347	4.07.01.01.13 Aguinaldos al personal empleado, obrero y militar jubilado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
348	4.07.01.01.14 Aportes a caja de ahorro del personal empleado, obrero ymilitar jubilado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
349	4.07.01.01.15 Aportes a los servicios de salud, accidentes personales ygastos funerarios del personal empleado, obrero y militarjubilado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
350	4.07.01.01.16 Otras subvenciones socio – económicas del personal empleado, obrero y militar jubilado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
351	4.07.01.01.30 Incapacidad temporal sin hospitalización	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
352	4.07.01.01.31 Incapacidad temporal con hospitalización	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
353	4.07.01.01.32 Reposo por maternidad	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
354	4.07.01.01.33 Indemnización por paro forzoso	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
355	4.07.01.01.34 Otros tipos de incapacidad temporal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
356	4.07.01.01.35 Indemnización por comisión por pensiones	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
357	4.07.01.01.36 Indemnización por comisión por cesantía	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
358	4.07.01.01.37 Incapacidad parcial	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
359	4.07.01.01.38 Invalidez	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
360	4.07.01.01.39 Pensiones por vejez, viudez y orfandad	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
361	4.07.01.01.40 Indemnización por cesantía	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
362	4.07.01.01.41 Otras pensiones y demás prestaciones en dinero	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
363	4.07.01.01.42 Incapacidad parcial por accidente común	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
364	4.07.01.01.43 Incapacidad parcial por enfermedades profesionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
365	4.07.01.01.44 Incapacidad parcial por accidente de trabajo	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
366	4.07.01.01.45 Indemnización única por invalidez	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
367	4.07.01.01.46 Indemnización única por vejez	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
368	4.07.01.01.47 Sobrevivientes por enfermedad común	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
369	4.07.01.01.48 Sobrevivientes por accidente común	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
370	4.07.01.01.49 Sobrevivientes por enfermedades profesionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
371	4.07.01.01.50 Sobrevivientes por accidentes de trabajo	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
372	4.07.01.01.51 Indemnizaciones por conmutación de renta	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
373	4.07.01.01.52 Indemnizaciones por conmutación de pensiones	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
374	4.07.01.01.53 Indemnizaciones por comisión de renta	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
375	4.07.01.01.54 Asignación por nupcias	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
376	4.07.01.01.55 Asignación por funeraria	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
377	4.07.01.01.56 Otras asignaciones	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
378	4.07.01.01.70 Subsidios educacionales al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
379	4.07.01.01.71 Subsidios a universidades privadas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
380	4.07.01.01.72 Subsidios culturales al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
381	4.07.01.01.73 Subsidios a instituciones benéficas privadas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
382	4.07.01.01.74 Subsidios a centros de empleados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
383	4.07.01.01.75 Subsidios a organismos laborales y gremiales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
384	4.07.01.01.76 Subsidios a entidades religiosas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
385	4.07.01.01.77 Subsidios a entidades deportivas y recreativas de carácterprivado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
386	4.07.01.01.78 Subsidios científicos al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
387	4.07.01.01.79 Subsidios a cooperativas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
388	4.07.01.01.80 Subsidios a empresas privadas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
389	4.07.01.01.99 Otras transferencias corrientes internas al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
390	4.07.01.02.00 Donaciones corrientes internas al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
391	4.07.01.02.01 Donaciones corrientes a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
392	4.07.01.02.02 Donaciones corrientes a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
393	4.07.01.03.00 Transferencias corrientes internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
733	TONER 531 A (HP CP2025)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
394	4.07.01.03.01 Transferencias corrientes a la República	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
395	4.07.01.03.02 Transferencias corrientes a entes descentralizados sin finesempresariales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
396	4.07.01.03.03 Transferencias corrientes a entes descentralizados sin finesempresariales para atender beneficios de la seguridad social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
397	4.07.01.03.04 Transferencias corrientes a instituciones de protección social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
398	4.07.01.03.05 Transferencias corrientes a instituciones de protección socialpara atender beneficios de la seguridad social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
399	4.07.01.03.06 Transferencias corrientes a entes descentralizados con finesempresariales petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
400	4.07.01.03.07 Transferencias corrientes a entes descentralizados con finesempresariales no petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
401	4.07.01.03.08 Transferencias corrientes a entes descentralizados financierosbancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
402	4.07.01.03.09 Transferencias corrientes a entes descentralizados financierosno bancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
403	4.07.01.03.10 Transferencias corrientes al Poder Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
404	4.07.01.03.11 Transferencias corrientes al Poder Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
405	4.07.01.03.13 Subsidios otorgados por normas externas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
406	4.07.01.03.14 Incentivos otorgados por normas externas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
407	4.07.01.03.15 Subsidios otorgados por precios políticos	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
408	4.07.01.03.16 Subsidios de costos sociales por normas externas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
409	4.07.01.03.99 Otras transferencias corrientes internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
410	4.07.01.04.00 Donaciones corrientes internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
411	4.07.01.04.01 Donaciones corrientes a la República	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
412	4.07.01.04.02 Donaciones corrientes a entes descentralizados sin finesempresariales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
413	4.07.01.04.03 Donaciones corrientes a instituciones de protección social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
414	4.07.01.04.04 Donaciones corrientes a entes descentralizados con finesempresariales petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
415	4.07.01.04.05 Donaciones corrientes a entes descentralizados con finesempresariales no petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
416	4.07.01.04.06 Donaciones corrientes a entes descentralizados financierosbancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
417	4.07.01.04.07 Donaciones corrientes a entes descentralizados financieros nobancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
418	4.07.01.04.08 Donaciones corrientes al Poder Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
419	4.07.01.04.09 Donaciones corrientes al Poder Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
420	4.07.01.05.00 Pensiones de altos funcionarios y altas funcionarias del poderpúblico y de elección popular, del personal de alto nivel y dedirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
421	4.07.01.05.01 Pensiones de altos funcionarios y altas funcionarias del poderpúblico y de elección popular	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
422	4.07.01.05.02 Pensiones del personal de alto nivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
423	4.07.01.05.06 Aguinaldos de altos funcionarios y altas funcionarias delpoder público y de elección popular pensionados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
424	4.07.01.05.07 Aguinaldos del personal pensionado de alto nivel y dedirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
425	4.07.01.05.11 Aportes a caja de ahorro de altos funcionarios y altasfuncionarias del poder público y de elección popularpensionados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
426	4.07.01.05.12 Aportes a caja de ahorro del personal pensionado de altonivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
526	ACTIVO	525	0	t	\N	1	2015-03-18 15:05:38.108304	\N	2015-03-18 15:05:38.108304	\N
527	INACTIVO	525	0	t	\N	1	2015-03-18 15:05:38.108304	\N	2015-03-18 15:05:38.108304	\N
427	4.07.01.05.16 Aportes a los servicios de salud, accidentes personales ygastos funerarios de altos funcionarios y altas funcionariasdel poder público y de elección popular pensionados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
428	4.07.01.05.17 Aportes a los servicios de salud, accidentes personales ygastos funerarios del personal pensionado de alto nivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
480	4.07.03.04.08 Donaciones de capital al Poder Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
429	4.07.01.05.98 Otras subvenciones de altos funcionarios y altas funcionariasdel poder público y de elección popular pensionados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
430	4.07.01.05.99 Otras subvenciones del personal pensionado de alto nivel yde dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
431	4.07.01.06.00 Jubilaciones de altos funcionarios y altas funcionarias del poder público y de elección popular, del personal de alto nively de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
432	4.07.01.06.01 Jubilaciones de altos funcionarios y altas funcionarias delpoder público y de elección popular	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
433	4.07.01.06.02 Jubilaciones del personal de alto nivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
434	4.07.01.06.06 Aguinaldos de altos funcionarios y altas funcionarias delpoder público y de elección popular jubilados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
435	4.07.01.06.07 Aguinaldos del personal jubilado de alto nivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
436	4.07.01.06.11 Aportes a caja de ahorro de altos funcionarios y altasfuncionarias del poder público y de elección popular jubilados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
437	4.07.01.06.12 Aportes a caja de ahorro del personal jubilado de alto nivel yde dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
438	4.07.01.06.16 Aportes a los servicios de salud, accidentes personales ygastos funerarios de altos funcionarios y altas funcionariasdel poder público y de elección popular jubilados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
439	4.07.01.06.17 Aportes a los servicios de salud, accidentes personales ygastos funerarios del personal jubilado de alto nivel y dedirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
440	4.07.01.06.98 Otras subvenciones de altos funcionarios y altas funcionariasdel poder público y de elección popular jubilados	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
441	4.07.01.06.99 Otras subvenciones del personal jubilado de alto nivel y de dirección	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
442	4.07.02.00.00 Transferencias y donaciones corrientes al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
443	4.07.02.01.00 Transferencias corrientes al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
444	4.07.02.01.01 Becas de capacitación e investigación en el exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
445	4.07.02.01.02 Transferencias corrientes a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
446	4.07.02.01.03 Transferencias corrientes a gobiernos extranjeros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
447	4.07.02.01.04 Transferencias corrientes a organismos internacionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
448	4.07.02.02.00 Donaciones corrientes al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
449	4.07.02.02.01 Donaciones corrientes a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
450	4.07.02.02.02 Donaciones corrientes a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
451	4.07.02.02.03 Donaciones corrientes a gobiernos extranjeros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
452	4.07.02.02.04 Donaciones corrientes a organismos internacionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
453	4.07.03.00.00 Transferencias y donaciones de capital internas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
454	4.07.03.01.00 Transferencias de capital internas al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
455	4.07.03.01.01 Transferencias de capital a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
456	4.07.03.01.02 Transferencias de capital a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
457	4.07.03.01.03 Transferencias de capital a empresas privadas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
458	4.07.03.02.00 Donaciones de capital internas al sector privado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
459	4.07.03.02.01 Donaciones de capital a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
460	4.07.03.02.02 Donaciones de capital a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
461	4.07.03.03.00 Transferencias de capital internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
462	4.07.03.03.01 Transferencias de capital a la República	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
463	4.07.03.03.02 Transferencias de capital a entes descentralizados sin fines empresariales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
464	4.07.03.03.03 Transferencias de capital a instituciones de protección social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
465	4.07.03.03.04 Transferencias de capital a entes descentralizados con finesempresariales petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
466	4.07.03.03.05 Transferencias de capital a entes descentralizados con fines empresariales no petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
467	4.07.03.03.06 Transferencias de capital a entes descentralizados financierosbancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
468	4.07.03.03.07 Transferencias de capital a entes descentralizados financierosno bancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
469	4.07.03.03.08 Transferencias de capital al Poder Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
470	4.07.03.03.09 Transferencias de capital al Poder Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
471	4.07.03.03.99 Otras transferencias de capital internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
472	4.07.03.04.00 Donaciones de capital internas al sector público	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
473	4.07.03.04.01 Donaciones de capital a la República	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
474	4.07.03.04.02 Donaciones de capital a entes descentralizados sin finesempresariales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
475	4.07.03.04.03 Donaciones de capital a instituciones de protección social	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
476	4.07.03.04.04 Donaciones de capital a entes descentralizados con finesempresariales petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
528	ESTATUS IMPUTACION AC	0	2	t	\N	1	2015-03-18 15:06:50.188599	\N	2015-03-18 15:06:50.188599	\N
477	4.07.03.04.05 Donaciones de capital a entes descentralizados con fines empresariales no petroleros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
478	4.07.03.04.06 Donaciones de capital a entes descentralizados financierosbancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
479	4.07.03.04.07 Donaciones de capital a entes descentralizados financieros nobancarios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
481	4.07.03.04.09 Donaciones de capital al Poder Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
482	4.07.04.00.00 Transferencias y donaciones de capital al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
483	4.07.04.01.00 Transferencias de capital al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
484	4.07.04.01.01 Transferencias de capital a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
485	4.07.04.01.02 Transferencias de capital a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
486	4.07.04.01.03 Transferencias de capital a gobiernos extranjeros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
487	4.07.04.01.04 Transferencias de capital a organismos internacionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
488	4.07.04.02.00 Donaciones de capital al exterior	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
489	4.07.04.02.01 Donaciones de capital a personas	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
490	4.07.04.02.02 Donaciones de capital a instituciones sin fines de lucro	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
491	4.07.04.02.03 Donaciones de capital a gobiernos extranjeros	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
492	4.07.04.02.04 Donaciones de capital a organismos internacionales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
493	4.07.05.00.00 Situado	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
494	4.07.05.01.00 Situado Constitucional	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
495	4.07.05.01.01 Situado Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
496	4.07.05.01.02 Situado Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
497	4.07.05.02.00 Situado Estadal a Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
498	4.07.06.00.00 Subsidio de Régimen Especial	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
499	4.07.06.01.00 Subsidio de Régimen Especial	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
500	4.07.07.00.00 Subsidio de capitalidad	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
501	4.07.07.01.00 Subsidio de capitalidad	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
734	TONER 532 A (HP CP2025)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
502	4.07.08.00.00 Asignaciones Económicas Especiales (LAEE)	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
503	4.07.08.01.00 Asignaciones Económicas Especiales (LAEE) Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
504	4.07.08.02.00 Asignaciones Económicas Especiales (LAEE) Estadal aMunicipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
505	4.07.08.03.00 Asignaciones Económicas Especiales (LAEE) Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
506	4.07.08.04.00 Asignaciones Económicas Especiales (LAEE) Fondo Nacionalde los Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
507	4.07.08.05.00 Asignaciones Económicas Especiales (LAEE) ApoyoFortalecimiento Institucional	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
508	4.07.09.00.00 Aportes al Poder Estadal y al Poder Municipal portransferencia de servicios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
509	4.07.09.01.00 Aportes al Poder Estadal por transferencia de servicios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
510	4.07.09.02.00 Aportes al Poder Municipal por transferencia de servicios	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
511	4.07.10.00.00 Fondo Intergubernamental para la Descentralización (FIDES)	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
512	4.07.10.01.00 Fondo Intergubernamental para la Descentralización (FIDES)	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
513	4.07.11.00.00 Fondo de Compensación Interterritorial	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
514	4.07.11.01.00 Fondo de Compensación Interterritorial Estadal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
515	4.07.11.02.00 Fondo de Compensación Interterritorial Municipal	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
516	4.07.11.03.00 Fondo de Compensación Interterritorial Poder Popular	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
517	4.07.11.04.00 Fondo de Compensación Interterritorial Fortalecimiento Institucional	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
518	4.07.12.00.00 Transferencias y donaciones a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
519	4.07.12.01.00 Transferencias y donaciones corrientes a Consejo Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
520	4.07.12.01.01 Transferencias corrientes a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
521	4.07.12.01.02 Donaciones corrientes a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
522	4.07.12.02.00 Transferencias y donaciones de capital a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
523	4.07.12.02.01 Transferencias de capital a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
524	4.07.12.02.02 Donaciones de capital a Consejos Comunales	332	0	t	\N	1	2015-03-18 12:06:50.619013	\N	2015-03-18 12:06:50.619013	\N
529	ACTIVO	528	0	t	\N	1	2015-03-18 15:06:50.188599	\N	2015-03-18 15:06:50.188599	\N
530	INACTIVO	528	0	t	\N	1	2015-03-18 15:06:50.188599	\N	2015-03-18 15:06:50.188599	\N
531	ESTATUS IMPUTACION UE	0	2	t	\N	1	2015-03-18 15:07:14.054664	\N	2015-03-18 15:07:14.054664	\N
532	ACTIVO	531	0	t	\N	1	2015-03-18 15:07:14.054664	\N	2015-03-18 15:07:14.054664	\N
533	INACTIVO	531	0	t	\N	1	2015-03-18 15:07:14.054664	\N	2015-03-18 15:07:14.054664	\N
534	ESTATUS LUGAR ENTREGA	0	2	t	\N	1	2015-03-18 15:07:33.576342	\N	2015-03-18 15:07:33.576342	\N
535	ACTIVO	534	0	t	\N	1	2015-03-18 15:07:33.576342	\N	2015-03-18 15:07:33.576342	\N
536	INACTIVO	534	0	t	\N	1	2015-03-18 15:07:33.576342	\N	2015-03-18 15:07:33.576342	\N
537	ESTATUS NUMERO REQUISICION	0	2	t	\N	1	2015-03-18 15:08:04.967167	\N	2015-03-18 15:08:04.967167	\N
538	ACTIVO	537	0	t	\N	1	2015-03-18 15:08:04.967167	\N	2015-03-18 15:08:04.967167	\N
539	INACTIVO	537	0	t	\N	1	2015-03-18 15:08:04.967167	\N	2015-03-18 15:08:04.967167	\N
540	ESTATUS OBSERVACION	0	2	t	\N	1	2015-03-18 15:08:25.359846	\N	2015-03-18 15:08:25.359846	\N
541	ACTIVO	540	0	t	\N	1	2015-03-18 15:08:25.359846	\N	2015-03-18 15:08:25.359846	\N
542	INACTIVO	540	0	t	\N	1	2015-03-18 15:08:25.359846	\N	2015-03-18 15:08:25.359846	\N
6	00101 DESPACHO DE LA MINISTRA	5	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
8	00103 OFICINA DE TECNOLOGÍA Y SISTEMAS DE INFORMACIÓN	5	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
10	00105 DESPACHO DE LA VICEMINISTRA PARA LA PROTECCIÓN DE LOS DERECHOS DE LA MUJER	5	0	t	\N	1	2015-02-24 17:01:26.309629	\N	2015-02-24 17:01:26.309629	\N
543	00107 DESPACHO DE LA VICEMINISTRA DE LA IGUALDAD DE GÉNERO Y NO DISCRIMINACIÓN	5	0	t	\N	1	2015-04-08 15:52:33.22147	\N	2015-04-08 15:52:33.22147	\N
544	PRODUCTOS	0	239	t	\N	1	2015-04-08 16:04:44.037359	\N	2015-04-08 16:04:44.037359	\N
545	ABRILLANTADOR DE PISOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
546	AGUA (24 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
547	ALMOHADILLA DACTILAR	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
548	ALMOHADILLA PARA SELLO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
549	AMBIENTADOR	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
550	AVISO DE PRECAUCIÓN	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
551	AZÚCAR	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	KILO
552	BANDEJA DE MALLA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
553	BANDEJAS DE DOS NIVELES	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
554	BANDEJAS DE TRES NIVELES	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
555	BANDEJAS DE UN NIVEL	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
556	BASE PARA BANDEJA DE MALLA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
557	BLOCK DE NOTAS HOJAS BLANCAS (36 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
558	BLOCK DE RAYAS (40 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
559	BOLÍGRAFO AZUL (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
560	BOLÍGRAFO NEGRO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
561	BOLÍGRAFO ROJO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
562	BOLSA DE PAPELERA (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
563	BOLSA NEGRA 30 Kgs (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
564	BOLSA NEGRA GRANDE (50 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
565	BORRADOR DE PIZARRA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
566	BORRADOR NATA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
567	BRASSO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
568	CAFÉ (PAQUETE: 500 grs.)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	KILO
569	CAJA ARCHICOMODA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
570	CAJA CHICA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
571	CALCULADORA DE ESCRITORIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
572	CARPETA DE EXPEDIENTES (75 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
573	CARPETA MANILA CARTA (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
574	CARPETA MANILA OFICIO (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
575	CARPETA MARRÓN CARTA (25 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
576	CARPETA MARRÓN OFICIO (25 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
577	CARPETA CARTA COLOR AMARILLO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
578	CARPETA CARTA COLOR AZUL	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
579	CARPETA CARTA COLOR ROJO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
580	CARPETA OSLO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
581	CARPETA PLÁSTICA BLANCA 1"	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
582	CARPETA PLÁSTICA BLANCA ½"	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
583	CARPETA PLÁSTICA BLANCA 2"	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
584	CARPETA PLÁSTICA BLANCA 3"	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
585	CARPETAS COLGANTES  (CAJA: 75 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
586	CARTELERA DE CORCHO GRANDE	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
587	CARTELERA DE CORCHO MEDIANA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
588	CARTELERA DE CORCHO PEQUEÑA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
589	CARTULINA OPALINA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
590	CARTUCHO HP 920 XL AMARILLO (HP 6500)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
591	CARTUCHO HP 920 XL CIAN (HP 6500)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
592	CARTUCHO HP 920 XL MAGNETA (HP 6500)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
593	CARTUCHO HP 920 XL NEGRO (HP 6500)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
594	CD (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
595	CEPILLO DE BARRER	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
596	CEPILLO PARA POCETA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
597	CERA NEUTRA LÍQUIDA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
598	CERA NEUTRA LÍQUIDA 900ML	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
599	CHINCHES (CAJA: 100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
600	CHUPONES DE BAÑO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
601	CINTA ADHESIVA 25 MTS CELOVEN	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
602	CINTA ADHESIVA 50 MTS CELOVEN	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
603	CLIPS N° 1 (CAJA: 100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
604	CLORO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
605	COLETO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
606	CUADERNO PEQUEÑO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
607	CUENTA FÁCIL	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
608	DESINFECTANTE LÍQUIDO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
609	DETERGENTE EN POLVO 2.5 Kgs.	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
610	DETERGENTE EN POLVO 2.7 Kgs.	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
611	DETERGENTE EN POLVO 20 Kgs.	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
612	DETERGENTE EN POLVO 9 Kgs.	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
613	DIRECTORIO TELEFÓNICO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
614	DISPENSADOR DE CINTA ADHESIVA GRANDE	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
615	DISPENSADOR DE CINTA ADHESIVA PEQUEÑA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
616	DVD (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
617	ENCUADERNADORA DE ESPIRAL	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
618	ENGRAPADORA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
619	ESPIRAL NEGRO 12MM	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
620	ESPIRAL NEGRO 25MM	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
621	ESPIRAL NEGRO 43MM	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
622	ESPIRAL NEGRO 50MM	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
624	ESPONJA DOBLE USO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
625	FILTRO DE CAFETERA (50 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
626	FUNDA PROTECTORA MULTITALADRO  (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
627	GANCHOS DE CARPETAS (50 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
628	GRAPAS CORRUGADAS (CAJA: 5000 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
629	GRAPAS INDUSTRIALES (CAJA: 1000 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
630	GRAPAS LISAS (CAJA: 5000 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
631	GUANTES PLÁSTICOS (PARES)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
632	GUILLOTINA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
633	HARAGÁN	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
634	HARAGÁN LIMPIADOR DE VIDRIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
635	HOJAS CARTA (500 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	RESMA
636	HOJAS DOBLE CARTA (500 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	RESMA
637	HOJAS OFICIO (500 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	RESMA
638	JABÓN LÍQUIDO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
639	LAMPAZO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
640	LÁPIZ DE GRAFITO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
641	LAVAPLATOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
642	LIBRETA DE UNA LÍNEA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
643	LIBRO DE ACTA DE 200 FOLIOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
644	LIBRO DE ACTA DE 500 FOLIOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
645	LIGA DE GOMA (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
646	LIGA DE GOMA ROJA (60 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
647	LIMPIA VIDRIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
648	LIMPIADOR DE PARQUET	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
649	LIMPIADOR DE POCETA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	GALÓN
650	MARCADOR DE ACETATO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
651	MARCADOR GRUESO AZUL (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
652	MARCADOR GRUESO NEGRO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
653	MARCADOR GRUESO ROJO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
654	MARCADOR GRUESO VERDE (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
735	TONER 533 A (HP CP2025)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
655	MARCADOR PARA PIZARRA ACRÍLICA AZUL (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
656	MARCADOR PARA PIZARRA ACRÍLICA NEGRO  (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
657	MARCADOR PARA PIZARRA ACRÍLICA ROJO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
658	MARCADOR PARA PIZARRA ACRÍLICA VERDE (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
659	MARCADOR PUNTA FINA AZUL (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
660	MARCADOR PUNTA FINA NEGRO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
661	MARCADOR PUNTA FINA ROJO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
662	MOPA C/PALO DE ESCOBA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
663	NOTAS ADHESIVAS DE COLORES (POST IT) (250 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
664	NOTAS ADHESIVAS DE FIRMAS (POST IT) (50 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
665	NOTAS ADHESIVAS GRANDE (POST IT) (100 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
666	NOTAS ADHESIVAS MEDIANO (POST IT) (100 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
667	NOTAS ADHESIVAS PEQUEÑA (POST IT) (100 HOJAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
668	PALA PARA BASURA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
669	PAÑO AMARILLO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
670	PAÑO BLANCO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
671	PAÑO MULTIUSOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
672	PAPEL BOND (PLIEGO)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
673	PAPEL HIGIÉNICO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
674	PAPELERA DE MALLA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
675	PEGA BLANCA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
676	PEGA DE BARRA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
677	PERFORADOR DE DOS HUECOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
678	PERFORADOR DE TRES HUECOS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
679	PIZARRA ACRÍLICA MEDIANA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
680	PORTA CLIPS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
681	PORTA LÁPIZ	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
682	PRIDE	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
683	REGLA DE 30 CMS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
684	RESALTADOR AMARILLO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
685	RESALTADOR AZUL (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
686	RESALTADOR ROSADO (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
687	RESALTADOR VERDE (CAJA: 12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
688	SACA GRAPAS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
689	SACAPUNTAS DE MANO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
690	SACAPUNTAS ELÉCTRICO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
691	SELLOS DE FECHA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
692	SEPARADORES BLANCO (5 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
693	SEPARADORES DE COLORES (5 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
694	SERVILLETA DE MANO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
695	SERVILLETA DE MESA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
696	SOBRE BLANCO CARTA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
697	SOBRE BLANCO CON VENTANA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
698	SOBRE BLANCO EXTRAOFICIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
699	SOBRE BLANCO OFICIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
700	SOBRE BLANCO SIN VENTANA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
701	SOBRE MANILA CARTA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
702	SOBRE MANILA EXTRAOFICIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
703	SOBRE MANILA OFICIO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
704	SUJETADORES MARIPOSA N° 2	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
705	SUJETADORES MARIPOSA N° 3 (12 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
706	SUJETADORES MARIPOSA N° 3 (50 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
707	TACOS DE NOTAS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
708	TÉ (20 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	CAJA
709	TIJERAS	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
710	TINTA ROLLON AZUL	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
711	TINTA ROLLON NEGRO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
712	TIPP - EX DE BROCHA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
713	TIPP - EX DE LÁPIZ	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
714	TIRRO BLANCO	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
715	TIRRO DE EMBALAJE MARRÓN	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
716	TIRRO DE EMBALAJE TRANSPARENTE	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
717	TOBO PARA LIMPIEZA	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
718	TONER 006R01463 (XEROX 7125)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
719	TONER 006R01464 (XEROX 7125)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
720	TONER 006R01517 (XEROX 7125)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
721	TONER 006R01518 (XEROX 7125)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
722	TONER 106R01413 (XEROX 5230)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
723	TONER 260 A (HP CP4525)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
724	TONER 261 A (HP CP4525)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
725	TONER 262 A (HP CP4525)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
726	TONER 263 A (HP CP4525)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
727	TONER 285 A (HP P1102 o M1212)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
728	TONER 320 A (CM1415)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
729	TONER 321 A (CM1415)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
730	TONER 322 A (CM1415)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
731	TONER 323 A (CM1415)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
732	TONER 530 A (HP CP2025)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
736	TONER 540 A (HP CM1312)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
737	TONER 541 A (HP CM1312)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
738	TONER 542 A (HP CM1312)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
739	TONER 543 A (HP CM1312)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
740	TONER 7551A  (HP M3027)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
741	TONER 9730 A (HP 5550)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
742	TONER 9731 A (HP 5550)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
743	TONER 9732 A (HP 5550)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
744	TONER 9733 A (HP 5550)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
745	TONER GPR 22 (CANON 1019j)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
746	TONER GPR 28 NEGRO (CANON 1030)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
747	TONER Q6470 A (HP 3600 N)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
748	TONER Q6471 A (HP 3600 N)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
749	TONER Q6472 A (HP 3600 N)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
750	TONER Q6473 A (HP 3600 N)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PIEZA
751	VASOS DESECHABLES N° 27, Pequeño (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
752	VASOS DESECHABLES N° 5, Mediano (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
753	VASOS DESECHABLES N° 7, Grande (100 PIEZAS)	544	0	t	\N	1	2015-04-08 16:53:10.368465	\N	2015-04-08 16:53:10.368465	PAQUETE
\.


--
-- Name: maestro_id_maestro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('maestro_id_maestro_seq', 753, true);


SET search_path = requisicion, pg_catalog;

--
-- Data for Name: datos_requisicion; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY datos_requisicion (id_datos_requisicion, fk_tipo_requisicion, anio_requisicion, fk_unidad_ejecutora, ubicacion_geografica, fk_parroquia, ciudad, fk_fuente_financia, es_anulacion, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date) FROM stdin;
\.


--
-- Name: datos_requisicion_id_datos_requisicion_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('datos_requisicion_id_datos_requisicion_seq', 1, false);


--
-- Data for Name: imputacion_presupuestaria_ac; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY imputacion_presupuestaria_ac (id_imp_presupuestaria_ac, fk_datos_requisicion, fk_accion_centralizada, fk_clasificacion_presupuestaria, descripcion, fk_unidad_medida, cantidad, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date) FROM stdin;
\.


--
-- Name: imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('imputacion_presupuestaria_ac_id_imp_presupuestaria_ac_seq', 1, false);


--
-- Data for Name: imputacion_presupuestaria_ue; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY imputacion_presupuestaria_ue (id_imputacion_presupuestaria, fk_datos_requisicion, fk_unidad_ejecutora, fk_proyecto, fk_accion_especifica, fk_clasificacion_presupuestaria, descripcion, fk_unidad_medida, cantidad, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date) FROM stdin;
\.


--
-- Name: imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('imputacion_presupuestaria_ue_id_imputacion_presupuestaria_seq', 1, false);


--
-- Data for Name: lugar_entrega; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY lugar_entrega (id_lugar_entrega, fk_datos_requisicion, dependencia, direccion, es_almacen, fecha_estimada_requerida, es_activo, created_by, created_date, modified_by, modified_date, fk_estatus) FROM stdin;
\.


--
-- Name: lugar_entrega_id_lugar_entrega_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('lugar_entrega_id_lugar_entrega_seq', 1, false);


--
-- Data for Name: numero_requisicion_unidad; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY numero_requisicion_unidad (id_n_requisicion, fk_datos_requisicion, numero, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date) FROM stdin;
\.


--
-- Name: numero_requisicion_unidad_id_n_requisicion_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('numero_requisicion_unidad_id_n_requisicion_seq', 1, false);


--
-- Data for Name: observacion; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY observacion (id_observacion, id_entidad, fk_entidad, observacion, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date) FROM stdin;
\.


--
-- Name: observacion_id_observacion_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('observacion_id_observacion_seq', 1, false);


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY pedido (id_pedido, fk_descripcion, cantidad, fk_datos_requisicion, unid_medida, created_by, modified_by, created_date, modified_date, fk_estatus, es_activo) FROM stdin;
\.


--
-- Data for Name: pedido_especial; Type: TABLE DATA; Schema: requisicion; Owner: postgres
--

COPY pedido_especial (id_ped_especial, descripcion, cantidad, fk_datos_requisicion, unid_medida, created_by, modified_by, created_date, modified_date, fk_estatus, es_activo) FROM stdin;
\.


--
-- Name: pedido_especial_id_ped_especial_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('pedido_especial_id_ped_especial_seq', 1, false);


--
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: requisicion; Owner: postgres
--

SELECT pg_catalog.setval('pedido_id_pedido_seq', 1, false);


SET search_path = actualizar, pg_catalog;

--
-- Name: id_historico; Type: CONSTRAINT; Schema: actualizar; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historico
    ADD CONSTRAINT id_historico PRIMARY KEY (id_historico);


--
-- Name: id_personal_traza; Type: CONSTRAINT; Schema: actualizar; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traza
    ADD CONSTRAINT id_personal_traza UNIQUE (id_personal);


--
-- Name: id_traza; Type: CONSTRAINT; Schema: actualizar; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traza
    ADD CONSTRAINT id_traza PRIMARY KEY (id_traza);


SET search_path = evaluacion, pg_catalog;

--
-- Name: id_comentario; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT id_comentario PRIMARY KEY (id_comentario);


--
-- Name: id_estatus_eval; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT id_estatus_eval PRIMARY KEY (id_estatus_evaluacion);


--
-- Name: id_evaluacion; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evaluacion
    ADD CONSTRAINT id_evaluacion PRIMARY KEY (id_evaluacion);


--
-- Name: id_evaluado; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evaluados
    ADD CONSTRAINT id_evaluado PRIMARY KEY (id_evaluado);


--
-- Name: id_evaluador; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evaluador
    ADD CONSTRAINT id_evaluador PRIMARY KEY (id_evaluador);


--
-- Name: id_maestro; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY maestro
    ADD CONSTRAINT id_maestro PRIMARY KEY (id_maestro);


--
-- Name: id_pregunta; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas
    ADD CONSTRAINT id_pregunta PRIMARY KEY (id_pregunta);


--
-- Name: id_pregunta_ind; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas_individuales
    ADD CONSTRAINT id_pregunta_ind PRIMARY KEY (id_preguntas_ind);


--
-- Name: id_pregunta_obr; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas_obrero
    ADD CONSTRAINT id_pregunta_obr PRIMARY KEY (id_preguntas_obr);


--
-- Name: id_preguntas_colect; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT id_preguntas_colect PRIMARY KEY (id_preguntas_colect);


--
-- Name: id_revision; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT id_revision PRIMARY KEY (id_revision);


--
-- Name: id_supervisor; Type: CONSTRAINT; Schema: evaluacion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY supervisor
    ADD CONSTRAINT id_supervisor PRIMARY KEY (id_supervisor);


SET search_path = poa, pg_catalog;

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


SET search_path = public, pg_catalog;

--
-- Name: cruge_authassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_authassignment
    ADD CONSTRAINT cruge_authassignment_pkey PRIMARY KEY (userid, itemname);


--
-- Name: cruge_authitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_authitem
    ADD CONSTRAINT cruge_authitem_pkey PRIMARY KEY (name);


--
-- Name: cruge_authitemchild_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_authitemchild
    ADD CONSTRAINT cruge_authitemchild_pkey PRIMARY KEY (parent, child);


--
-- Name: cruge_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_field
    ADD CONSTRAINT cruge_field_pkey PRIMARY KEY (idfield);


--
-- Name: cruge_fieldvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_fieldvalue
    ADD CONSTRAINT cruge_fieldvalue_pkey PRIMARY KEY (idfieldvalue);


--
-- Name: cruge_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_session
    ADD CONSTRAINT cruge_session_pkey PRIMARY KEY (idsession);


--
-- Name: cruge_system_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_system
    ADD CONSTRAINT cruge_system_pkey PRIMARY KEY (idsystem);


--
-- Name: cruge_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cruge_user
    ADD CONSTRAINT cruge_user_pkey PRIMARY KEY (iduser);


--
-- Name: maestro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY maestro
    ADD CONSTRAINT maestro_pkey PRIMARY KEY (id_maestro);


SET search_path = requisicion, pg_catalog;

--
-- Name: datos_requisicion_pkey; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY datos_requisicion
    ADD CONSTRAINT datos_requisicion_pkey PRIMARY KEY (id_datos_requisicion);


--
-- Name: id_imp_presupuestaria_ac; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT id_imp_presupuestaria_ac PRIMARY KEY (id_imp_presupuestaria_ac);


--
-- Name: id_ped_especial; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pedido_especial
    ADD CONSTRAINT id_ped_especial PRIMARY KEY (id_ped_especial);


--
-- Name: id_pedido; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT id_pedido PRIMARY KEY (id_pedido);


--
-- Name: imputacion_presupuestaria_ue_pkey; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT imputacion_presupuestaria_ue_pkey PRIMARY KEY (id_imputacion_presupuestaria);


--
-- Name: lugar_entrega_pkey; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lugar_entrega
    ADD CONSTRAINT lugar_entrega_pkey PRIMARY KEY (id_lugar_entrega);


--
-- Name: numero_requisicion_unidad_pkey; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY numero_requisicion_unidad
    ADD CONSTRAINT numero_requisicion_unidad_pkey PRIMARY KEY (id_n_requisicion);


--
-- Name: observacion_pkey; Type: CONSTRAINT; Schema: requisicion; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observacion
    ADD CONSTRAINT observacion_pkey PRIMARY KEY (id_observacion);


SET search_path = evaluacion, pg_catalog;

--
-- Name: _RETURN; Type: RULE; Schema: evaluacion; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO vsw_pdf_eval_final DO INSTEAD  SELECT perso.id_persona AS id_persona_evaluado,
    evados.fk_periodo,
    peri.descripcion AS periodo_evaluacion,
    ( SELECT count(eva2.id_evaluacion) AS veces_evaluado
           FROM evaluacion eva2
          WHERE (eva2.fk_evaluador = evados.id_evaluado)) AS n_veces,
    perso.apellidos AS apellidos_evaluado,
    perso.nombres AS nombres_evaluado,
    perso.cedula AS cedula_evaluado,
    vevaldo.codigo_nomina AS cod_nomina_evaluado,
    caredos.fk_cargo AS fk_cargo_evaluado,
    caredos.descripcion_cargo AS cargo_evaluado,
    vevaldo.grado AS grado_evaluado,
        CASE
            WHEN (caredos.fk_cargo = ANY (ARRAY[1, 2, 3, 4])) THEN (14)::text
            WHEN (caredos.fk_cargo = 5) THEN (13)::text
            WHEN (caredos.fk_cargo = 6) THEN (12)::text
            WHEN (caredos.fk_cargo = 7) THEN (11)::text
            ELSE NULL::text
        END AS fk_tipo_clase,
    vevaldo.dependencia AS oficina_evaluado,
    vevaldor.telef_oficina AS telefono_evaluado,
    eva.id_evaluacion,
    per.id_persona AS id_persona_evaluador,
    per.apellidos AS apellidos_evaluador,
    per.nombres AS nombres_evaluador,
    per.cedula AS cedula_evaluador,
    vevaldor.codigo_nomina AS cod_nomina_evaluador,
    caredor.fk_cargo AS fk_cargo_evaluador,
    caredor.descripcion_cargo AS cargo_evaluador,
    vevaldor.grado AS grado_evaluador,
    vevaldor.dependencia AS oficina_evaluador,
    vevaldor.telef_oficina AS telefono_evaluador,
    per2.apellidos AS apellidos_supervisor,
    per2.nombres AS nombres_supervisor,
    per2.cedula AS cedula_supervisor,
    per2.descripcion_cargo AS cargo_supervisor,
    eva.total_b,
    eva.total_c,
    eva.total_final,
    com.id_comentario,
    com.comentario,
    to_char(eva.created_date, 'DD-MM-YYYY'::text) AS fecha_evaluacion,
        CASE
            WHEN (eva.esta_conforme = true) THEN 'SI'::text
            WHEN (eva.esta_conforme = false) THEN 'NO'::text
            ELSE NULL::text
        END AS esta_conforme,
    eva.fk_rango_act,
    rang.descripcion AS rango_actuacion,
    evador.dependencia_cruge AS dep_evaluador_cruge
   FROM (((((((((((((((evaluados evados
     RIGHT JOIN evaluacion eva ON ((evados.id_evaluado = eva.fk_evaluado)))
     RIGHT JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     RIGHT JOIN vsw_evaluacion perso ON (((perso.id_persona = evados.fk_persona) AND (eva.created_date = ( SELECT max(eva2.created_date) AS max
           FROM ((evaluacion eva2
             JOIN evaluados evado2 ON ((evado2.id_evaluado = eva2.fk_evaluado)))
             JOIN vsw_evaluacion pers2 ON ((pers2.id_persona = evado2.fk_persona)))
          WHERE (pers2.id_persona = perso.id_persona)
          GROUP BY pers2.id_persona)))))
     LEFT JOIN vsw_evaluacion per ON ((per.id_persona = evador.fk_persona)))
     RIGHT JOIN vsw_evaluacion vevaldo ON ((vevaldo.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion vevaldor ON ((vevaldor.id_persona = per.id_persona)))
     LEFT JOIN vsw_evaluacion caredos ON ((caredos.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion caredor ON ((caredor.id_persona = per.id_persona)))
     LEFT JOIN preguntas_individuales preg ON ((preg.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN maestro peri ON ((peri.id_maestro = evados.fk_periodo)))
     LEFT JOIN supervisor sup ON ((sup.id_supervisor = evador.fk_supervisor)))
     LEFT JOIN vsw_evaluacion per2 ON ((per2.id_persona = sup.fk_persona)))
     LEFT JOIN vsw_evaluacion carsup ON ((carsup.id_persona = per2.id_persona)))
     LEFT JOIN comentarios com ON (((com.fk_evaluacion = eva.id_evaluacion) AND (com.created_date = ( SELECT max(com2.created_date) AS max
           FROM comentarios com2)))))
     LEFT JOIN maestro rang ON ((rang.id_maestro = eva.fk_rango_act)))
  GROUP BY perso.id_persona, evados.fk_periodo, peri.descripcion, perso.apellidos, perso.nombres, perso.cedula, vevaldo.codigo_nomina, caredos.fk_cargo, caredos.descripcion_cargo, vevaldo.grado, vevaldo.dependencia, vevaldor.telef_oficina, eva.id_evaluacion, per.id_persona, per.apellidos, per.nombres, per.cedula, vevaldor.codigo_nomina, caredor.fk_cargo, caredor.descripcion_cargo, vevaldor.dependencia, evador.dependencia_cruge, per2.apellidos, per2.nombres, per2.cedula, per2.descripcion_cargo, vevaldor.grado, eva.total_b, eva.total_c, eva.total_final, com.id_comentario, com.comentario, evados.id_evaluado, rang.descripcion
  ORDER BY eva.id_evaluacion;


--
-- Name: _RETURN; Type: RULE; Schema: evaluacion; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO vsw_listar_personas DO INSTEAD  SELECT perso.id_persona AS id_persona_evaluado,
    perso.apellidos AS apellidos_evaluado,
    perso.nombres AS nombres_evaluado,
    perso.nacionalidad AS nacionalidad_evaluado,
    perso.cedula AS cedula_evaluado,
    perso.sexo AS sexo_evaluado,
    vevaldo.codigo_nomina AS cod_nomina_evaluado,
    caredos.fk_cargo AS fk_cargo_evaluado,
    caredos.descripcion_cargo AS cargo_evaluado,
    eva.created_date AS fecha_creacion_evaluacion,
        CASE
            WHEN (caredos.fk_cargo = 1) THEN (14)::text
            WHEN (caredos.fk_cargo = 2) THEN (13)::text
            WHEN (caredos.fk_cargo = 3) THEN (11)::text
            WHEN (caredos.fk_cargo = 4) THEN (12)::text
            ELSE NULL::text
        END AS fk_tipo_clase,
    vevaldo.cod_dependencia AS cod_oficina_evaluado,
    vevaldo.dependencia AS oficina_evaluado,
    vevaldo.telef_oficina AS telefono_evaluado,
    per.id_persona,
    eva.id_evaluacion,
    evados.fk_periodo,
    peri.descripcion AS periodo_evaluacion,
    per.apellidos,
    per.nombres,
    per.nacionalidad,
    per.cedula,
    per.sexo,
    vevaldor.codigo_nomina,
    caredor.fk_cargo,
    caredor.descripcion_cargo,
    vevaldor.cod_dependencia,
    vevaldor.dependencia,
    vevaldor.telef_oficina,
    eva.obj_funcional,
    est.fk_estatus_evaluacion,
    ms.descripcion AS estatus,
    com.id_comentario,
    com.comentario,
        CASE
            WHEN (preg.fk_evaluacion = eva.id_evaluacion) THEN 'TRUE'::text
            ELSE 'FALSE'::text
        END AS tiene_objetivos,
    count(preg.fk_evaluacion) AS cant_objetivos,
    sum(preg.peso) AS peso_total,
    evador.fk_dependencia AS cod_dependencia_evaluador_gruge,
    evador.dependencia_cruge AS dep_evaluador_cruge
   FROM (((((((((((((evaluados evados
     RIGHT JOIN evaluacion eva ON (((evados.id_evaluado = eva.fk_evaluado) AND (evados.es_activo = true))))
     RIGHT JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     JOIN vsw_evaluacion perso ON (((perso.id_persona = evados.fk_persona) AND (eva.created_date = ( SELECT max(eva2.created_date) AS max
           FROM ((evaluacion eva2
             JOIN evaluados evado2 ON ((evado2.id_evaluado = eva2.fk_evaluado)))
             JOIN vsw_evaluacion pers2 ON ((pers2.id_persona = evado2.fk_persona)))
          WHERE (pers2.id_persona = perso.id_persona)
          GROUP BY pers2.id_persona)))))
     LEFT JOIN vsw_evaluacion per ON ((per.id_persona = evador.fk_persona)))
     LEFT JOIN estatus_evaluacion est ON (((est.fk_evaluacion = eva.id_evaluacion) AND (est.fecha_estatus = ( SELECT max(est2.fecha_estatus) AS max
           FROM estatus_evaluacion est2
          WHERE (est2.fk_evaluacion = est.fk_evaluacion)
          GROUP BY est.fk_evaluacion)))))
     LEFT JOIN vsw_evaluacion vevaldo ON ((vevaldo.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion vevaldor ON ((vevaldor.id_persona = per.id_persona)))
     LEFT JOIN maestro ms ON ((ms.id_maestro = est.fk_estatus_evaluacion)))
     LEFT JOIN comentarios com ON (((com.fk_evaluacion = eva.id_evaluacion) AND (com.created_date = ( SELECT max(com2.created_date) AS max
           FROM comentarios com2)))))
     LEFT JOIN vsw_evaluacion caredos ON ((caredos.id_persona = perso.id_persona)))
     LEFT JOIN vsw_evaluacion caredor ON ((caredor.id_persona = per.id_persona)))
     LEFT JOIN preguntas_individuales preg ON ((preg.fk_evaluacion = eva.id_evaluacion)))
     LEFT JOIN maestro peri ON ((peri.id_maestro = evados.fk_periodo)))
  GROUP BY perso.id_persona, perso.apellidos, perso.nombres, perso.nacionalidad, perso.cedula, perso.sexo, vevaldo.codigo_nomina, caredos.fk_cargo, vevaldo.cod_dependencia, caredos.descripcion_cargo, vevaldo.telef_oficina, per.id_persona, eva.id_evaluacion, evados.fk_periodo, peri.descripcion, per.apellidos, per.nombres, per.nacionalidad, per.cedula, per.sexo, vevaldor.codigo_nomina, evador.fk_dependencia, evador.dependencia_cruge, caredor.fk_cargo, caredor.descripcion_cargo, vevaldor.telef_oficina, eva.obj_funcional, est.fk_estatus_evaluacion, ms.descripcion, com.id_comentario, com.comentario, vevaldor.cod_dependencia, vevaldor.dependencia, vevaldo.dependencia, preg.fk_evaluacion
  ORDER BY eva.id_evaluacion;


--
-- Name: _RETURN; Type: RULE; Schema: evaluacion; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO vsw_admin DO INSTEAD  SELECT p.id_persona AS id_persona_evaluado,
    p.nacionalidad,
    p.cedula,
    p.apellidos,
    p.nombres,
    p.descripcion_cargo,
    p.estatus AS activo,
    p.cod_dependencia AS cod_dependencia_evaluado,
    p.dependencia,
    p.tipo_cargo,
    p.fk_tipo_clase,
    eva.id_evaluacion,
    eva.created_date AS fecha_creacion_evaluacion,
    evador.fk_persona AS id_persona,
    vevaldor.cod_dependencia_evaluador,
    vevaldor.dep_evaluador,
    est.fk_estatus_evaluacion,
    ms.descripcion AS estatus,
        CASE
            WHEN (preg.fk_evaluacion = eva.id_evaluacion) THEN 'TRUE'::text
            ELSE 'FALSE'::text
        END AS tiene_objetivos,
    evador.fk_dependencia AS cod_dependencia_evaluador_gruge,
    evador.dependencia_cruge AS dep_evaluador_cruge
   FROM (((((((vsw_evaluacion p
     RIGHT JOIN evaluados evados ON ((evados.fk_persona = p.id_persona)))
     RIGHT JOIN evaluacion eva ON (((evados.id_evaluado = eva.fk_evaluado) AND (evados.es_activo = true))))
     RIGHT JOIN evaluador evador ON ((evador.id_evaluador = eva.fk_evaluador)))
     LEFT JOIN vsw_certificado vevaldor ON ((vevaldor.id_evaluacion = eva.id_evaluacion)))
     LEFT JOIN estatus_evaluacion est ON (((est.fk_evaluacion = eva.id_evaluacion) AND (est.fecha_estatus = ( SELECT max(est2.fecha_estatus) AS max
           FROM estatus_evaluacion est2
          WHERE (est2.fk_evaluacion = est.fk_evaluacion)
          GROUP BY est.fk_evaluacion)))))
     LEFT JOIN maestro ms ON ((ms.id_maestro = est.fk_estatus_evaluacion)))
     LEFT JOIN preguntas_individuales preg ON ((preg.fk_evaluacion = eva.id_evaluacion)))
  WHERE ((p.estatus)::text = 'A'::text)
  GROUP BY p.id_persona, p.nacionalidad, p.cedula, p.apellidos, p.nombres, p.descripcion_cargo, p.estatus, p.cod_dependencia, p.dependencia, p.tipo_cargo, p.fk_tipo_clase, eva.id_evaluacion, evador.fk_persona, est.fk_estatus_evaluacion, ms.descripcion, vevaldor.cod_dependencia_evaluador, vevaldor.dep_evaluador, evador.fk_dependencia, evador.dependencia_cruge, preg.fk_evaluacion;


--
-- Name: fk_entidad_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT fk_entidad_evaluacion FOREIGN KEY (fk_entidad) REFERENCES public.cruge_user(iduser);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY supervisor
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluador
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluados
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluacion
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_individuales
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_obrero
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES maestro(id_maestro);


--
-- Name: fk_estatus_eval; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT fk_estatus_eval FOREIGN KEY (fk_estatus_evaluacion) REFERENCES maestro(id_maestro);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_individuales
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_obrero
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluacion; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_evaluacion FOREIGN KEY (fk_evaluacion) REFERENCES evaluacion(id_evaluacion);


--
-- Name: fk_evaluador; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluacion
    ADD CONSTRAINT fk_evaluador FOREIGN KEY (fk_evaluador) REFERENCES evaluador(id_evaluador);


--
-- Name: fk_evaluador; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_evaluador FOREIGN KEY (fk_evaluador) REFERENCES evaluador(id_evaluador);


--
-- Name: fk_evaluados; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluacion
    ADD CONSTRAINT fk_evaluados FOREIGN KEY (fk_evaluado) REFERENCES evaluados(id_evaluado);


--
-- Name: fk_periodo; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluados
    ADD CONSTRAINT fk_periodo FOREIGN KEY (fk_periodo) REFERENCES maestro(id_maestro);


--
-- Name: fk_pregunta; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT fk_pregunta FOREIGN KEY (fk_pregunta) REFERENCES preguntas(id_pregunta);


--
-- Name: fk_pregunta; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_obrero
    ADD CONSTRAINT fk_pregunta FOREIGN KEY (fk_pregunta) REFERENCES preguntas(id_pregunta);


--
-- Name: fk_rango; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT fk_rango FOREIGN KEY (fk_rango) REFERENCES maestro(id_maestro);


--
-- Name: fk_rango; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_individuales
    ADD CONSTRAINT fk_rango FOREIGN KEY (fk_rango) REFERENCES maestro(id_maestro);


--
-- Name: fk_rango_act; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluacion
    ADD CONSTRAINT fk_rango_act FOREIGN KEY (fk_rango_act) REFERENCES maestro(id_maestro);


--
-- Name: fk_revision; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_revision FOREIGN KEY (fk_revision) REFERENCES maestro(id_maestro);


--
-- Name: fk_supervisor; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY evaluador
    ADD CONSTRAINT fk_supervisor FOREIGN KEY (fk_supervisor) REFERENCES supervisor(id_supervisor);


--
-- Name: fk_tipo_clase; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas
    ADD CONSTRAINT fk_tipo_clase FOREIGN KEY (fk_tipo_clase) REFERENCES maestro(id_maestro);


--
-- Name: fk_tipo_clase; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY preguntas_colectivas
    ADD CONSTRAINT fk_tipo_clase FOREIGN KEY (fk_tipo_clase) REFERENCES maestro(id_maestro);


--
-- Name: fk_tipo_entidad; Type: FK CONSTRAINT; Schema: evaluacion; Owner: postgres
--

ALTER TABLE ONLY estatus_evaluacion
    ADD CONSTRAINT fk_tipo_entidad FOREIGN KEY (fk_tipo_entidad) REFERENCES maestro(id_maestro);


SET search_path = poa, pg_catalog;

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


SET search_path = public, pg_catalog;

--
-- Name: crugeauthitemchild_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_authitemchild
    ADD CONSTRAINT crugeauthitemchild_ibfk_1 FOREIGN KEY (parent) REFERENCES cruge_authitem(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: crugeauthitemchild_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_authitemchild
    ADD CONSTRAINT crugeauthitemchild_ibfk_2 FOREIGN KEY (child) REFERENCES cruge_authitem(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cruge_authassignment_cruge_authitem1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_authassignment
    ADD CONSTRAINT fk_cruge_authassignment_cruge_authitem1 FOREIGN KEY (itemname) REFERENCES cruge_authitem(name);


--
-- Name: fk_cruge_authassignment_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_authassignment
    ADD CONSTRAINT fk_cruge_authassignment_user FOREIGN KEY (userid) REFERENCES cruge_user(iduser) ON DELETE CASCADE;


--
-- Name: fk_cruge_fieldvalue_cruge_field1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_fieldvalue
    ADD CONSTRAINT fk_cruge_fieldvalue_cruge_field1 FOREIGN KEY (idfield) REFERENCES cruge_field(idfield) ON DELETE CASCADE;


--
-- Name: fk_cruge_fieldvalue_cruge_user1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cruge_fieldvalue
    ADD CONSTRAINT fk_cruge_fieldvalue_cruge_user1 FOREIGN KEY (iduser) REFERENCES cruge_user(iduser) ON DELETE CASCADE;


SET search_path = requisicion, pg_catalog;

--
-- Name: fk_accion_centralizada; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT fk_accion_centralizada FOREIGN KEY (fk_accion_centralizada) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_accion_especifica; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_accion_especifica FOREIGN KEY (fk_accion_especifica) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_clasificacion_presupuestaria; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_clasificacion_presupuestaria FOREIGN KEY (fk_clasificacion_presupuestaria) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_clasificacion_presupuestaria; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT fk_clasificacion_presupuestaria FOREIGN KEY (fk_clasificacion_presupuestaria) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY numero_requisicion_unidad
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido_especial
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY lugar_entrega
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_datos_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT fk_datos_requisicion FOREIGN KEY (fk_datos_requisicion) REFERENCES datos_requisicion(id_datos_requisicion);


--
-- Name: fk_descripcion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT fk_descripcion FOREIGN KEY (fk_descripcion) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY numero_requisicion_unidad
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY observacion
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY datos_requisicion
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido_especial
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY lugar_entrega
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_estatus; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_fuente_financia; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY datos_requisicion
    ADD CONSTRAINT fk_fuente_financia FOREIGN KEY (fk_fuente_financia) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_proyecto; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (fk_proyecto) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_tipo_requisicion; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY datos_requisicion
    ADD CONSTRAINT fk_tipo_requisicion FOREIGN KEY (fk_tipo_requisicion) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_unidad_ejecutora; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_unidad_ejecutora FOREIGN KEY (fk_unidad_ejecutora) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_unidad_ejecutora; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY datos_requisicion
    ADD CONSTRAINT fk_unidad_ejecutora FOREIGN KEY (fk_unidad_ejecutora) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ue
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES public.maestro(id_maestro);


--
-- Name: fk_unidad_medida; Type: FK CONSTRAINT; Schema: requisicion; Owner: postgres
--

ALTER TABLE ONLY imputacion_presupuestaria_ac
    ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (fk_unidad_medida) REFERENCES public.maestro(id_maestro);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = actualizar, pg_catalog;

--
-- Name: historico; Type: ACL; Schema: actualizar; Owner: postgres
--

REVOKE ALL ON TABLE historico FROM PUBLIC;
REVOKE ALL ON TABLE historico FROM postgres;
GRANT ALL ON TABLE historico TO postgres;


--
-- Name: historico_id_historico_seq; Type: ACL; Schema: actualizar; Owner: postgres
--

REVOKE ALL ON SEQUENCE historico_id_historico_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE historico_id_historico_seq FROM postgres;
GRANT ALL ON SEQUENCE historico_id_historico_seq TO postgres;


--
-- Name: traza; Type: ACL; Schema: actualizar; Owner: postgres
--

REVOKE ALL ON TABLE traza FROM PUBLIC;
REVOKE ALL ON TABLE traza FROM postgres;
GRANT ALL ON TABLE traza TO postgres;


--
-- Name: traza_id_traza_seq; Type: ACL; Schema: actualizar; Owner: postgres
--

REVOKE ALL ON SEQUENCE traza_id_traza_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE traza_id_traza_seq FROM postgres;
GRANT ALL ON SEQUENCE traza_id_traza_seq TO postgres;


--
-- Name: vsw_usuarios_actualizados; Type: ACL; Schema: actualizar; Owner: postgres
--

REVOKE ALL ON TABLE vsw_usuarios_actualizados FROM PUBLIC;
REVOKE ALL ON TABLE vsw_usuarios_actualizados FROM postgres;
GRANT ALL ON TABLE vsw_usuarios_actualizados TO postgres;


--
-- PostgreSQL database dump complete
--

