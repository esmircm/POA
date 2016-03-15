<?php

class EvaluacionController extends Controller {

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column2';

    /**
     * @return array action filters
     */
    public function filters() {
        return array(
            'accessControl', // perform access control for CRUD operations
        );
    }

    /**
     * Specifies the access control rules.
     * This method is used by the 'accessControl' filter.
     * @return array access control rules
     */
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'admin', 'view', 'update', 'delete', 'certificado', 'ObjetivosIncompleto', 'ObjetivosObrerosIncompleto', 'objetivos', 'enviarodi', 'revisado', 'create_revi', 'rrhheditar', 'direditar', 'dir', 'recursoshumanos', 'updateobjetivos', 'PDFobrero', 'PDFevaluacion', 'EliminarEva', 'rrhh_cierre', 'RenovarEvaluacion', 'Reporte_Rechazados'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'admin', 'odi', 'update', 'delete', 'certificado', 'objetivos', 'ObjetivosIncompleto', 'ObjetivosObrerosIncompleto', 'enviarodi', 'revisado', 'create_revi', 'rrhheditar', 'direditar', 'dir', 'recursoshumanos', 'updateobjetivos', 'PDFobrero', 'PDFevaluacion', 'EliminarEva', 'rrhh_cierre', 'RenovarEvaluacion', 'Reporte_Rechazados'),
                'users' => array('*'),
            ),
            array('allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('admin'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    /**
     * Displays a particular model.
     * @param integer $id the ID of the model to be displayed
     */
    public function actionView($id) {
        $this->render('view', array(
            'model' => $this->loadModel($id),
        ));
    }

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
    public function actionCreate($id, $idP) {
//        echo '1';die;
//var_dump($id, $idP);die;
//         var_dump($_POST);die;

        $model = new Evaluacion;
        $evaluados = new Evaluados;
        $trabajador = new Trabajador;
        $cargo = new Cargo;
        $dependencia = new Dependencia;
        $preind = new PreguntasIndividuales;
        $evaluacion = new Evaluacion;
        $evaluador = new Evaluador;
//        echo '<pre>';var_dump($_POST);
//        die;

        $vista = new VswListarPersonas;
        $ver = VswListarPersonas::model()->findByAttributes(array('id_persona_evaluado' => $id));
        if (isset($ver)) {
            $vista->id_persona_evaluado = $ver['id_persona_evaluado'];
            $vista->nacionalidad_evaluado = $ver['nacionalidad_evaluado'];
            $vista->cedula_evaluado = $ver ['cedula_evaluado'];
            $vista->nombres_evaluado = $ver ['nombres_evaluado'];
            $vista->apellidos_evaluado = $ver ['apellidos_evaluado'];
            $vista->cod_nomina_evaluado = $ver ['cod_nomina_evaluado'];
            $vista->cargo_evaluado = $ver ['cargo_evaluado'];
            $vista->oficina_evaluado = $ver ['oficina_evaluado'];
            $vista->periodo_evaluacion = $ver ['periodo_evaluacion'];
            $id_evaluacion = $ver['id_evaluacion'];
            $fk_tipo_clase = $ver['fk_tipo_clase'];
//        echo '<pre>'; var_dump($vista);die;
        }
        $supeva = new VswEvaluacion;
        $sup = VswEvaluacion::model()->findByAttributes(array('id_persona' => $idP));
        if (isset($sup)) {
            $supeva->id_persona = $sup['id_persona'];
            $supeva->nacionalidad = $sup['nacionalidad'];
            $supeva->cedula = $sup ['cedula'];
            $supeva->nombres = $sup ['nombres'];
            $supeva->apellidos = $sup ['apellidos'];
            $supeva->codigo_nomina = $sup ['codigo_nomina'];
            $supeva->descripcion_cargo = $sup ['descripcion_cargo'];
            $supeva->dependencia = $sup ['dependencia'];
        }
        if (isset($_POST['VswListar_tipoclase'])) {
            $fk_tipo_clase = $_POST['VswListar_tipoclase'];
        }
        $preobre = new Preguntas;
        $pre_status = Preguntas::model()->findAllByAttributes(array('fk_tipo_clase' => $fk_tipo_clase));
//        var_dump($id_evaluacion);die;
        ///Validación en caso de que haya hecho alguna de las Secciones de la Fase II
        
        $verificacion = Evaluacion::model()->findByAttributes(array('id_evaluacion' => $id_evaluacion));
        
        $script = 0;
        ///Validación para la sección B
        if (($verificacion['total_b']!="")&&($verificacion['total_c']=="")){
            $script = 1;
        }

        if (isset($_POST['evaluacion_vista'])) {
            $evaluacion_vista = 1;
            $this->render('create', array(
                'model' => $model,
                'evaluados' => $evaluados,
                'trabajador' => $trabajador,
                'cargo' => $cargo,
                'dependencia' => $dependencia,
                'preind' => $preind,
                'vista' => $vista,
                'evaluador' => $evaluador,
                'evaluacion' => $evaluacion,
                'supeva' => $supeva,
                'id_evaluacion' => $id_evaluacion,
                'fk_tipo_clase' => $fk_tipo_clase,
                'preobre' => $preobre,
                'pre_status' => $pre_status,
                'evaluacion_vista' => $evaluacion_vista,
                'id_persona_evaluado' => $id,
                'script' => $script,
            ));
        }

        if (isset($_POST['total_peso_calc'])) {
            if ($_POST['total_peso_calc'] == 50) {
                $filas = $_POST['preguntas_filas'];
                $i = 0;

                while ($i < $filas) {
                    $preguntas_colectivas = new PreguntasColectivas();

                    $preguntas_colectivas->fk_pregunta = $_POST['id_' . $i];
                    $preguntas_colectivas->fk_tipo_clase = $_POST['fk_tipo_clase'];
                    $preguntas_colectivas->peso = $_POST['peso_compe_' . $i];
                    $preguntas_colectivas->fk_rango = $_POST['rango_' . $i];
                    $preguntas_colectivas->subtotal_peso = $_POST['subPeso_' . $i];
                    $preguntas_colectivas->fk_evaluacion = $_POST['id_evaluacion'];
                    $preguntas_colectivas->fk_estatus = 34;
                    $preguntas_colectivas->created_date = 'now()';
                    $preguntas_colectivas->modified_date = 'now()';
                    $preguntas_colectivas->created_by = Yii::app()->user->id;
                    $preguntas_colectivas->es_activo = true;
                    if ($preguntas_colectivas->save()) {
                        
                    } else {
                        echo "<pre>Preguntas";
                        var_dump($preguntas_colectivas->Errors);
                        exit;
                    }

                    $i++;
                }
                $eva = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
                $eva->total_c = $_POST['total_calc_compe'];
                if ($eva->save()) {
                    $cali = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
                    $this->render('create', array(
                        'model' => $model,
                        'evaluacion' => $evaluacion,
                        'id_evaluacion' => $_POST['id_evaluacion'],
                        'fk_tipo_clase' => $fk_tipo_clase,
                        'cali' => $cali,
                        'competencia_vista' => $calificacion_vista = 1,
                    ));
                }
            }
        }
        ///Validación para la sección C
         if (isset($_POST['total_final'])) {
         }else{
            if (($verificacion['total_b']!="") && ($verificacion['total_c']!="") && ($verificacion['total_final']=="")){
                $cali = Evaluacion::model()->findByPk($ver['id_evaluacion']);
                $this->render('create', array(
                    'model' => $model,
                    'evaluacion' => $evaluacion,
                    'id_evaluacion' => $ver['id_evaluacion'],
                    'fk_tipo_clase' => $fk_tipo_clase,
                    'cali' => $cali,
                    'competencia_vista' => $calificacion_vista = 1,
                ));
            }
         }
        ///Guarda Final y cambio de Estatus
         
        if (isset($_POST['total_final'])) {
            if ($_POST['comentario_evaluador'] == "") {
                $_POST['comentario_evaluador'] = "No tiene comentario.";
            }
//            var_dump($_POST['id_evaluacion'], $_POST['total_final']);die;
            if ($_POST['total_final'] <= 179) {
                $rango = 97;
            } elseif (($_POST['total_final'] >= 180) && ($_POST['total_final'] <= 259)) {
                $rango = 98;
            } elseif (($_POST['total_final'] >= 260) && ($_POST['total_final'] <= 339)) {
                $rango = 99;
            } elseif (($_POST['total_final'] >= 340) && ($_POST['total_final'] <= 419)) {
                $rango = 100;
            } elseif (($_POST['total_final'] >= 420) && ($_POST['total_final'] <= 500)) {
                $rango = 101;
            }
            $eva = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
            $eva->total_final = $_POST['total_final'];
            $eva->fk_rango_act = $rango;
            if ($eva->save()) {
                $comen = new Comentarios;
//                $comen->fk_direccion = $ver['fk_dir_evaluado'];
//               $comen->fk_direccion = 1;

                $comen->fk_evaluacion = $_POST['id_evaluacion'];
                $comen->comentario = $_POST['comentario_evaluador'];
                $comen->fk_estatus = 16;
                $comen->created_date = 'now()';
                $comen->modified_date = 'now()';
                $comen->created_by = Yii::app()->user->id;
                $comen->es_activo = true;
                if ($comen->save()) {
                    $EstatusEvaluacion = new EstatusEvaluacion;
                    $EstatusEvaluacion->fk_estatus_evaluacion = 51;
                    $EstatusEvaluacion->fk_estatus = 65;
                    $EstatusEvaluacion->fk_evaluacion = $_POST['id_evaluacion'];
                    $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
                    $EstatusEvaluacion->fk_tipo_entidad = 45;    // Cableado 
                    $EstatusEvaluacion->fecha_estatus = 'now()';
                    $EstatusEvaluacion->created_by = Yii::app()->user->id;
                    $EstatusEvaluacion->created_date = 'now()';
                    $EstatusEvaluacion->modified_date = 'now()';
                    $EstatusEvaluacion->es_activo = true;
                    if ($EstatusEvaluacion->save()) {
                        $this->redirect(array('admin'));
                    } else {
                        echo "<pre>EstatusEvaluacion";
                        var_dump($EstatusEvaluacion->Errors);
                        exit;
                    }
                } else {
                    echo "<pre>Preguntas";
                    var_dump($comen->Errors);
                    exit;
                }
            } else {
                echo "<pre>Preguntas";
                var_dump($eva->Errors);
                exit;
            }
        }

//        }

        $this->render('create', array(
            'model' => $model,
            'evaluados' => $evaluados,
            'trabajador' => $trabajador,
            'cargo' => $cargo,
            'dependencia' => $dependencia,
            'preind' => $preind,
            'vista' => $vista,
            'evaluador' => $evaluador,
            'evaluacion' => $evaluacion,
            'supeva' => $supeva,
            'id_evaluacion' => $id_evaluacion,
            'fk_tipo_clase' => $fk_tipo_clase,
            'preobre' => $preobre,
            'pre_status' => $pre_status,
        ));
    }

    public function actionOdi() {


        $model = new Evaluacion;
        $evaluados = new Evaluados;
        $personal = new Personal;
        $trabajador = new Trabajador;
        $cargo = new Cargo;
        $dependencia = new Dependencia;
        $preind = new PreguntasIndividuales;
        $evaluacion = new Evaluacion;
        $evaluador = new Evaluador;
        $maestro = new MaestroEvaluacion;

        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $idP = $row[0]["id_persona"];

        if (date("n") <= 06) {
            $condicion = '81';
        } else {
            $condicion = '82';
        }
        $periodo = MaestroEvaluacion::model()->findByAttributes(array('id_maestro' => $condicion));
//        
        $vista = new VswListarPersonas;

        if (isset($ver)) {
            
        }
        $supeva = new VswEvaluacion;
        
        $sup = VswEvaluacion::model()->findByAttributes(array('id_persona' => $idP));
        if (isset($sup)) {
            //Consulta del Cargo y Dependencia segun el Cruge
            $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 1));
            $field = CrugeField::model()->findByAttributes(array('idfield' => 1));
            $arOpt = CrugeUtil::explodeOptions($field->predetvalue);
            
            
            $supeva->id_persona = $sup['id_persona'];
            $supeva->nacionalidad = $sup['nacionalidad'];
            $supeva->cedula = $sup ['cedula'];
            $supeva->nombres = $sup ['nombres'];
            $supeva->apellidos = $sup ['apellidos'];
            $supeva->codigo_nomina = $sup ['codigo_nomina'];
            $supeva->descripcion_cargo = $sup ['descripcion_cargo'];
            $supeva->dependencia = $sup ['dependencia'];
            $evaluador->fk_dependencia = $fieldvalue->value;
            $evaluador->dependencia_cruge = $arOpt[$fieldvalue->value];
        }


        if (isset($_POST['VswEvaluacion']['cedula']) && isset($_POST['VswListarPersonas']['cedula_evaluado'])) {
            $id_evaluacion = '';
            $id_evaluador = '';
            $id_evaluado = '';
            $nacionalidad = '';
            $nacionalidad_supervisado = '';

            //ESTE ES EL SUPERVISADO
            $evaluados = new Evaluados;

            $evaluados->cargo = $_POST['VswListarPersonas']['cargo_evaluado'];
            $evaluados->cod_nomina = $_POST['VswListarPersonas']['cod_nomina_evaluado'];
            $evaluados->ubicacion_admtiva = $_POST['VswListarPersonas']['oficina_evaluado'];
            $evaluados->fk_persona = $_POST['VswListarPersonas']['id_persona_evaluado'];
            $evaluados->fk_periodo = $_POST['MaestroEvaluacion']['id_maestro'];
            $evaluados->fk_estatus = 25;
//            $evaluados->fk_sexo = 6;
            $evaluados->fk_dependencia = 1;
            $evaluados->fk_tipo_entidad = 53;
            $evaluados->created_date = 'now()';
            $evaluados->modified_date = 'now()';
            $evaluados->created_by = Yii::app()->user->id;
            $evaluados->es_activo = true;
            $fk_tipo_clase = $_POST['VswListarPersonas']['fk_tipo_clase'];
            if ($evaluados->save()) {


                $id_evaluados = $evaluados->id_evaluado;




                //ESTE ES EL SUPERVISOR
                $evaluador = new Evaluador;

//               var_dump($_POST);die;
                $evaluador->cargo = $_POST['VswEvaluacion']['descripcion_cargo'];
                $evaluador->cod_nomina = $_POST['VswEvaluacion']['codigo_nomina'];
                $evaluador->unidad_admtiva = $_POST['VswEvaluacion']['dependencia'];
                $evaluador->fk_persona = $_POST['VswEvaluacion']['id_persona'];
                $evaluador->fk_estatus = 22;
                $evaluador->grado = 0; //ojo
                $evaluador->cod_clase = 0; //ojo
                $evaluador->fk_supervisor = 3; //ojo
                $evaluador->created_date = 'now()';
                $evaluador->modified_date = 'now()';
                $evaluador->created_by = Yii::app()->user->id;
                $evaluador->es_activo = true;
                $evaluador->fk_dependencia = $_POST['Evaluador']['fk_dependencia'];
                $evaluador->dependencia_cruge = $_POST['Evaluador']['dependencia_cruge'];
                if ($evaluador->save()) {
                    $id_evaluador = $evaluador->id_evaluador;
                } else {

                    echo "<pre>evaluador";
                    var_dump($evaluador->Errors);
                    exit;
                }


                //  var_dump($id_evaluador);die;
                if (($id_evaluados != '') && ($id_evaluador != '')) {
                    $evaluacion = new Evaluacion;
                    $evaluacion->fk_evaluado = $id_evaluados;
                    $evaluacion->fk_evaluador = $id_evaluador;
//                    $evaluacion->obj_funcional = $_POST['Evaluacion']['obj_funcional'];
                    $evaluacion->fk_estatus = 19;
                    $evaluacion->created_date = 'now()';
                    $evaluacion->modified_date = 'now()';
                    $evaluacion->created_by = Yii::app()->user->id;
                    $evaluacion->es_activo = true;
                    if ($evaluacion->save()) {
                        $id_evaluacion = $evaluacion->id_evaluacion;
                        $evaluacion_vista = $evaluacion->id_evaluacion;
                    }
                }
                if (isset($id_evaluacion)) {
                    $EstatusEvaluacion = new EstatusEvaluacion;

                    $EstatusEvaluacion->fk_estatus_evaluacion = 47;
                    $EstatusEvaluacion->fk_estatus = 65;
                    $EstatusEvaluacion->fk_evaluacion = $id_evaluacion;
                    $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
                    $EstatusEvaluacion->fk_tipo_entidad = 53;    // Cableado 
                    $EstatusEvaluacion->fecha_estatus = 'now()';
                    $EstatusEvaluacion->created_by = Yii::app()->user->id;
                    $EstatusEvaluacion->created_date = 'now()';
                    $EstatusEvaluacion->modified_date = 'now()';
                    $EstatusEvaluacion->es_activo = true;
                    if ($EstatusEvaluacion->save()) {
                        
                    } else {
                        echo "<pre>EstatusEvaluacion";
                        var_dump($EstatusEvaluacion->Errors);
                        exit;
                    }
                }
            } else {
                echo "<pre>evaluados";
                var_dump($evaluados->Errors);
                exit;
            }

            $consulta = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $id_evaluacion));


            $preobre = new Preguntas;
            $pre_status = Preguntas::model()->findAllByAttributes(array('fk_tipo_clase' => $fk_tipo_clase));

            if (($id_evaluacion != '')) {

//                    var_dump($id_evaluacion);die;


                $this->render('odi', array(
                    'model' => $model,
                    'evaluados' => $evaluados,
                    'evaluador' => $evaluador,
                    'evaluacion' => $evaluacion,
                    'personal' => $personal,
                    'trabajador' => $trabajador,
                    'cargo' => $cargo,
                    'dependencia' => $dependencia,
                    'vista' => $vista,
                    'id_evaluacion' => $id_evaluacion,
                    'preind' => $preind,
                    'supeva' => $supeva,
                    'periodo' => $periodo,
                    'evaluacion_vista' => $evaluacion_vista,
                    'fk_tipo_clase' => $fk_tipo_clase,
                    'preobre' => $preobre,
                    'pre_status' => $pre_status,
                    'consulta' => $consulta,
                ));
            }
        }
        if (isset($_POST['total_puntuacion'])) {
//            var_dump($_POST);die;

            $filas_obre = $_POST['preguntas_obrero_filas'];
            $i = 0;
            while ($i < $filas_obre) {
                $preguntas_obrero = new PreguntasObrero;

                $preguntas_obrero->puntaje = $_POST['pre_obre_' . $i];
                $preguntas_obrero->fk_pregunta = $_POST['id_pre_obre_' . $i];
                $preguntas_obrero->fk_evaluacion = $_POST['id_evaluacion'];
                $preguntas_obrero->fk_estatus = 40;
                $preguntas_obrero->created_date = 'now()';
                $preguntas_obrero->modified_date = 'now()';
                $preguntas_obrero->created_by = Yii::app()->user->id;
                $preguntas_obrero->es_activo = true;
                $preguntas_obrero->save();


                $i++;
            }
            if ($_POST['total_puntuacion'] <= 36) {
                $rango = 103;
            } elseif (($_POST['total_puntuacion'] >= 36.5) && ($_POST['total_puntuacion'] <= 52.5)) {
                $rango = 104;
            } elseif (($_POST['total_puntuacion'] >= 53) && ($_POST['total_puntuacion'] <= 69)) {
                $rango = 105;
            } elseif (($_POST['total_puntuacion'] >= 69.5) && ($_POST['total_puntuacion'] <= 85.5)) {
                $rango = 106;
            } elseif (($_POST['total_puntuacion'] >= 86) && ($_POST['total_puntuacion'] <= 100)) {
                $rango = 107;
            }
            $EstatusEvaluacion = new EstatusEvaluacion;
            $EstatusEvaluacion->fk_estatus_evaluacion = 51;
            $EstatusEvaluacion->fk_estatus = 65;
            $EstatusEvaluacion->fk_evaluacion = $_POST['id_evaluacion'];
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 53;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                $eva = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
                $eva->total_c = $_POST['total_puntuacion'];
                $eva->total_final = $_POST['total_puntuacion'];
                $eva->fk_rango_act = $rango;
                if ($eva->save()) {
//                    $this->redirect(array('admin'));
                    $rango_act = MaestroEvaluacion::model()->findByAttributes(array('id_maestro' => $rango));
                    $fk_tipo_clase = 11;
                    $this->render('odi', array(
                        'model' => $model,
                        'rango_act' => $rango_act,
                        'total_puntuacion' => $_POST['total_puntuacion'],
                        'rango' => $rango,
//                        'evaluacion_vista' => $evaluacion_vista,
                        'fk_tipo_clase' => $fk_tipo_clase,
                        'id_evaluacion' => $id_evaluacion = 11,
                    ));
                } else {
                    echo "<pre>";
                    var_dump($eva->Errors);
                    exit;
                }
            } else {
                echo "<pre>";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }
        }

        if (isset($_POST['finalizar_obrero'])) {
            $this->redirect(array('admin'));
        }
//        }
        $this->render('odi', array(
            'model' => $model,
            'evaluados' => $evaluados,
            'evaluador' => $evaluador,
            'evaluacion' => $evaluacion,
            'personal' => $personal,
            'trabajador' => $trabajador,
            'cargo' => $cargo,
            'dependencia' => $dependencia,
            'vista' => $vista,
            'preind' => $preind,
            'supeva' => $supeva,
            'periodo' => $periodo,
        ));
    }

    public function actionObjetivosIncompleto() {
//         var_dump($_GET['id']);die;
        $preind = new PreguntasIndividuales;
        $evaluacion = new Evaluacion;
        $vista = new VswListarPersonas;
        $id_evaluacion = $_GET['id'];
        $consulta = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));




//    $model = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
//    var_dump($model);die;
//    if (($id_evaluacion != '')) {

        $this->render('objetivos_incompletos', array(
            'id_evaluacion' => $id_evaluacion, 'preind' => $preind, 'evaluacion' => $evaluacion, 'vista' => $vista, 'consulta' => $consulta,
        ));
//        }
    }

    public function actionObjetivosObrerosIncompleto() {
//         var_dump($_GET['id']);die;
        $model = new Evaluacion;
        $preind = new PreguntasIndividuales;
        $evaluacion = new Evaluacion;
        $vista = new VswListarPersonas;
        $evaluacion_vista = $_GET['id'];
        $fk_tipo_clase = $_GET['fk_tipo_clase'];
//        $model = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
//                    var_dump($model);die;
//        if (($id_evaluacion != '')) {

        $preobre = new Preguntas;
        $pre_status = Preguntas::model()->findAllByAttributes(array('fk_tipo_clase' => $fk_tipo_clase));

        if (isset($_POST['total_puntuacion'])) {
//            var_dump($_POST);die;

            $filas_obre = $_POST['preguntas_obrero_filas'];
            $i = 0;
            while ($i < $filas_obre) {
                $preguntas_obrero = new PreguntasObrero;

                $preguntas_obrero->puntaje = $_POST['pre_obre_' . $i];
                $preguntas_obrero->fk_pregunta = $_POST['id_pre_obre_' . $i];
                $preguntas_obrero->fk_evaluacion = $_POST['id_evaluacion'];
                $preguntas_obrero->fk_estatus = 40;
                $preguntas_obrero->created_date = 'now()';
                $preguntas_obrero->modified_date = 'now()';
                $preguntas_obrero->created_by = Yii::app()->user->id;
                $preguntas_obrero->es_activo = true;
                $preguntas_obrero->save();


                $i++;
            }
            if ($_POST['total_puntuacion'] <= 36) {
                $rango = 103;
            } elseif (($_POST['total_puntuacion'] >= 36.5) && ($_POST['total_puntuacion'] <= 52.5)) {
                $rango = 104;
            } elseif (($_POST['total_puntuacion'] >= 53) && ($_POST['total_puntuacion'] <= 69)) {
                $rango = 105;
            } elseif (($_POST['total_puntuacion'] >= 69.5) && ($_POST['total_puntuacion'] <= 85.5)) {
                $rango = 106;
            } elseif (($_POST['total_puntuacion'] >= 86) && ($_POST['total_puntuacion'] <= 100)) {
                $rango = 107;
            }

            $EstatusEvaluacion = new EstatusEvaluacion;
            $EstatusEvaluacion->fk_estatus_evaluacion = 51;
            $EstatusEvaluacion->fk_estatus = 65;
            $EstatusEvaluacion->fk_evaluacion = $_POST['id_evaluacion'];
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 52;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                $eva = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
                $eva->total_c = $_POST['total_puntuacion'];
                $eva->total_final = $_POST['total_puntuacion'];
                $eva->fk_rango_act = $rango;
                if ($eva->save()) {
                    $rango_act = MaestroEvaluacion::model()->findByAttributes(array('id_maestro' => $rango));
                    $this->render('objetivos_obreros_incompletos', array(
                        'model' => $model,
                        'rango_act' => $rango_act,
                        'total_puntuacion' => $_POST['total_puntuacion'],
                        'rango' => $rango,
                        'evaluacion_vista' => $evaluacion_vista,
                    ));
                } else {
                    echo "<pre>";
                    var_dump($eva->Errors);
                    exit;
                }
            } else {
                echo "<pre>";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }
        }

        if (isset($_POST['finalizar_obrero'])) {
            $this->redirect(array('admin'));
        }

        $this->render('objetivos_obreros_incompletos', array(
            'model' => $model,
            'preind' => $preind,
            'evaluacion' => $evaluacion,
            'vista' => $vista,
            'evaluacion_vista' => $evaluacion_vista,
            'fk_tipo_clase' => $fk_tipo_clase,
            'preobre' => $preobre,
            'pre_status' => $pre_status,
        ));
    }

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate() {

        $vista = new VswPdfEvaluacion;
        $Comentarios = new Comentarios;
        $EstatusEvaluacion = new EstatusEvaluacion;
        $consultaPersona = VswPdfEvaluacion::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));

         if (isset($_POST['pesoguardar'])) {
             echo "<pre>";
//                        var_dump($_POST);
                $id_evaluacion = $_GET['id'];
                if (isset($id_evaluacion)) {
                    $EstatusEvaluacion = new EstatusEvaluacion;
                    $EstatusEvaluacion->fk_estatus_evaluacion = 79;
                    $EstatusEvaluacion->fk_estatus = 65;
                    $EstatusEvaluacion->fk_evaluacion = $id_evaluacion;
                    $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
                    $EstatusEvaluacion->fk_tipo_entidad = 52;    // Cableado 
                    $EstatusEvaluacion->fecha_estatus = 'now()';
                    $EstatusEvaluacion->created_by = Yii::app()->user->id;
                    $EstatusEvaluacion->created_date = 'now()';
                    $EstatusEvaluacion->modified_date = 'now()';
                    $EstatusEvaluacion->es_activo = true;
                    if ($EstatusEvaluacion->save()) {

                        $this->redirect(array('admin'));
                    } else {
                        echo "<pre>EstatusEvaluacion";
                        var_dump($EstatusEvaluacion->Errors);
                        exit;
                    }
                }
            
        }
        
        $model = new VswPdfEvaluacion('search');
      // var_dump($model); die;
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['VswPdfEvaluacion']))
            $model->attributes = $_GET['VswPdfEvaluacion'];

        $this->render('update', array(
            'model' => $model, 'consultaPersona' => $consultaPersona, 'Comentarios' => $Comentarios, 'EstatusEvaluacion' => $EstatusEvaluacion,
        ));
    }

//    public function actionUpdate() {
//
//      var_dump($_GET); die;
//       
//        $vista = new VswListarPersonas;
//        $Comentarios = new Comentarios;
//        $EstatusEvaluacion = new EstatusEvaluacion;
//        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
//
//        $model = new VswPdfEvaluacion('search');
//        $model->unsetAttributes();  // clear any default values
//        if (isset($_GET['VswPdfEvaluacion']))
//            $model->attributes = $_GET['VswPdfEvaluacion'];
//  $this->redirect(array('admin'));
//        $this->render('update', array(
//            'model' => $model, 'consultaPersona' => $consultaPersona, 'Comentarios' => $Comentarios, 'EstatusEvaluacion' => $EstatusEvaluacion,
//        ));
//    }
    /**
     * Deletes a particular model.
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param integer $id the ID of the model to be deleted
     */
    public function actionDelete($id) {
        if (Yii::app()->request->isPostRequest) {
// we only allow deletion via POST request
            $this->loadModel($id)->delete();

// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
            if (!isset($_GET['ajax']))
                $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
        } else
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
    }

    /**
     * Lists all models.
     */
    public function actionEliminarEva($id) {
        $model = new EstatusEvaluacion;
        $supeva = new VswEvaluacion;
        $vista = new VswListarPersonas;

//        $sup = VswEvaluacion::model()->findByAttributes(array('id_evaluacion' => $id));
        $VswListarPersonas = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $id));
        if (isset($VswListarPersonas)) {
            $supeva->id_persona = $VswListarPersonas['id_persona_evaluado'];
            $supeva->nacionalidad = $VswListarPersonas['nacionalidad'];
            $supeva->cedula = $VswListarPersonas ['cedula'];
            $supeva->nombres = $VswListarPersonas ['nombres'];
            $supeva->apellidos = $VswListarPersonas ['apellidos'];
            $supeva->codigo_nomina = $VswListarPersonas ['codigo_nomina'];
            $supeva->descripcion_cargo = $VswListarPersonas ['descripcion_cargo'];
            $supeva->dependencia = $VswListarPersonas ['dependencia'];

            $vista->id_persona_evaluado = $VswListarPersonas['id_persona_evaluado'];
            $vista->nacionalidad_evaluado = $VswListarPersonas['nacionalidad_evaluado'];
            $vista->cedula_evaluado = $VswListarPersonas ['cedula_evaluado'];
            $vista->nombres_evaluado = $VswListarPersonas ['nombres_evaluado'];
            $vista->apellidos_evaluado = $VswListarPersonas ['apellidos_evaluado'];
            $vista->cod_nomina_evaluado = $VswListarPersonas ['cod_nomina_evaluado'];
            $vista->cargo_evaluado = $VswListarPersonas ['cargo_evaluado'];
            $vista->oficina_evaluado = $VswListarPersonas ['oficina_evaluado'];
        }

        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
//        var_dump($_POST);die;

        if (isset($_POST['Eliminar_Evaluacion'])) {


            $sql0 = "Select * from evaluacion.evaluacion WHERE id_evaluacion =" . $_GET['id'] . ";";
            $connection0 = Yii::app()->db;
            $command0 = $connection0->createCommand($sql0);
            $row0 = $command0->queryAll();

            $evaluado = $row0[0]['fk_evaluado'];
            $evaluador = $row0[0]['fk_evaluador'];

            $sql = "UPDATE evaluacion.estatus_evaluacion SET es_activo=FALSE WHERE fk_evaluacion =" . $_GET['id'] . ";";
            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $sql1 = "UPDATE evaluacion.preguntas_individuales SET es_activo=FALSE WHERE fk_evaluacion =" . $_GET['id'] . ";";
            $connection1 = Yii::app()->db;
            $command1 = $connection1->createCommand($sql1);
            $row1 = $command1->queryAll();

            $sql2 = "UPDATE evaluacion.comentarios SET es_activo=FALSE WHERE fk_evaluacion =" . $_GET['id'] . ";";
            $connection2 = Yii::app()->db;
            $command2 = $connection2->createCommand($sql2);
            $row2 = $command2->queryAll();

            $sql3 = "UPDATE evaluacion.evaluacion SET es_activo=FALSE WHERE id_evaluacion =" . $_GET['id'] . ";";
            $connection3 = Yii::app()->db;
            $command3 = $connection3->createCommand($sql3);
            $row3 = $command3->queryAll();

            $sql4 = " UPDATE evaluacion.evaluador SET es_activo=FALSE WHERE id_evaluador =" . $evaluador . ";";
            $connection4 = Yii::app()->db;
            $command4 = $connection4->createCommand($sql4);
            $row4 = $command4->queryAll();

            $sql5 = " UPDATE evaluacion.evaluados SET es_activo=FALSE WHERE id_evaluado =" . $evaluado . ";";
            $connection5 = Yii::app()->db;
            $command5 = $connection5->createCommand($sql5);
            $row5 = $command5->queryAll();


            $this->redirect(array('recursoshumanos'));
        }

        $this->render('eliminareva', array(
            'model' => $model,
            'supeva' => $supeva,
            'vista' => $vista,
            'VswListarPersonas' => $VswListarPersonas,
            'consultaPersona' => $consultaPersona,
        ));

        //Accion Eliminar
    }

    /**
     * Lists all models.
     */
    public function actionEliminarEvaluacion() {
//        var_dump ($_POST);die;

        $sql = "DELETE FROM evaluacion.vsw_evaluacion WHERE id_personas=" . $_POST['id'];
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();

        if ($row) {

            echo json_encode(1);
        } else {
            echo json_encode(2);
//         $tabla = array('html' => $html);
        }
    }

    public function actionIndex() {
        $dataProvider = new CActiveDataProvider('Persona');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    public function actionEnviarodi() {
        if (isset($_GET['id'])) {

            //  var_dump($_GET); echo 'enviarodi'; die;
            //$model= new VswPdfObjetivos;   
            $modelSave = EstatusEvaluacion::model()->findByPk($_GET['id']);
            $EstatusEvaluacion = new EstatusEvaluacion;
            $id_evaluacion = $_GET['id'];
            $EstatusEvaluacion->fk_estatus_evaluacion = 48;
            $EstatusEvaluacion->fk_estatus = 65;
            $EstatusEvaluacion->fk_evaluacion = $id_evaluacion;
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 52;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                
            } else {
                echo "<pre>evaluados";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }


            $this->redirect(array('admin'));
        }




        $dataProvider = new CActiveDataProvider('VswListarPersonas');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    public function actionRevisado() {
        if (isset($_GET['id'])) {

            // var_dump($_GET); echo 'enviarodi'; die;
            //$model= new VswPdfObjetivos;   
            $modelSave = EstatusEvaluacion::model()->findByPk($_GET['id']);
            $EstatusEvaluacion = new EstatusEvaluacion;
            $id_evaluacion = $_GET['id'];
            $EstatusEvaluacion->fk_estatus_evaluacion = 79;
            $EstatusEvaluacion->fk_estatus = 65;
            $EstatusEvaluacion->fk_evaluacion = $id_evaluacion;
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 52;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                
            } else {
                echo "<pre>evaluados";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }


            $this->redirect(array('admin'));
        }




//        $dataProvider = new CActiveDataProvider('VswListarPersonas');
//        $this->render('index', array(
//            'dataProvider' => $dataProvider,
//        ));
    }

    /**
     * Manages all models.
     */
//    public function actionAdmin() {
//        $model = new Persona('search');
//        $model->unsetAttributes();  // clear any default values
//        if (isset($_GET['Persona']))
//            $model->attributes = $_GET['Persona'];
//
//        $this->render('admin', array(
//            'model' => $model,
//        ));
//    }

    public function actionAdmin() {
        $model = new VswAdmin('search');
        $model->unsetAttributes();  // clear any default values

        if (isset($_GET['VswAdmin']))
            $model->attributes = $_GET['VswAdmin'];

        //$this->redirect(array("id_evaluacion","id"=>$model->getPrimaryKey()));
       
        
///------- Condicion que valida los 120 dias desde el inicio del periodo para mostrar Fase II--------///

        $validacion_evaluacion = 0;
        if (date('n') <= 6) {
            $fecha_inicio = date_create(date('Y') . "-01-01");
            $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));
//            var_dump($fecha_actual);die;
            $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
//            var_dump($validacion_fecha);die;
            $dias_diferencia = $validacion_fecha->format('%a');
//            var_dump($dias_diferencia);die;
            if ($dias_diferencia <= 120) {
                
            } else {
                $validacion_evaluacion = 1;
            }
        }
        if (date('n') >= 7) {
            $fecha_inicio = date_create(date('Y') . "-07-01");
            $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

            $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
            $dias_diferencia = $validacion_fecha->format('%a');

            if ($dias_diferencia <= 120) {
                
            } else {
                $validacion_evaluacion = 1;
            }
        }

///------------END----------///

        $this->render('admin', array(
            'model' => $model,
            'validacion_evaluacion' => $validacion_evaluacion,
        ));
    }

    public function actionRecursoshumanos() {
        // var_dump ($_POST);die;

        $model = new VswListarPersonas('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['VswListarPersonas']))
            $model->attributes = $_GET['VswListarPersonas'];

        //$this->redirect(array("id_evaluacion","id"=>$model->getPrimaryKey()));


        $this->render('recursoshumanos', array(
            'model' => $model,
        ));
    }

    public function actionDir() {
        // var_dump ($_POST);die;

        $model = new VswAdmin('search');
        $model->unsetAttributes();  // clear any default values

        if (isset($_GET['VswAdmin']))
            $model->attributes = $_GET['VswAdmin'];

        ///------- Condicion que valida los 120 dias desde el inicio del periodo para mostrar Fase II--------///

        $validacion_evaluacion = 0;
        if (date('n') <= 6) {
            $fecha_inicio = date_create(date('Y') . "-01-01");
            $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));
//            var_dump($fecha_actual);die;
            $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
//            var_dump($validacion_fecha);die;
            $dias_diferencia = $validacion_fecha->format('%a');
//            var_dump($dias_diferencia);die;
            if ($dias_diferencia <= 120) {
                
            } else {
                $validacion_evaluacion = 1;
            }
        }
        if (date('n') >= 7) {
            $fecha_inicio = date_create(date('Y') . "-07-01");
            $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

            $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
            $dias_diferencia = $validacion_fecha->format('%a');

            if ($dias_diferencia <= 120) {
                
            } else {
                $validacion_evaluacion = 1;
            }
        }

        ///------------END----------///

        $this->render('admin', array(
            'model' => $model,
            'validacion_evaluacion' => $validacion_evaluacion,
        ));
    }

    public function actionUpdaterrhh() {

        $vista = new VswListarPersonas;
        $Comentarios = new Comentarios;
        $EstatusEvaluacion = new EstatusEvaluacion;
        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));

        $model = new VswListarPersonas('search');
//       var_dump($model); die;
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['VswListarPersonas']))
            $model->attributes = $_GET['VswListarPersonas'];

        $this->render('update', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer the ID of the model to be loaded
     */
    public function loadModel($id) {
        $model = Persona::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param CModel the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'persona-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

    public function actionRRHHeditar() {
        $model = new VswPdfObjetivos;
        $vista = new VswListarPersonas;
        $Comentarios = new Comentarios;
        $EstatusEvaluacion = new EstatusEvaluacion;
        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
        $id_evaluacion = $_GET['id'];
        if (isset($_POST['EstatusEvaluacion']['fk_estatus_evaluacion'])) {
//             var_dump($_POST);die;
            $EstatusEvaluacion->fk_estatus_evaluacion = $_POST['EstatusEvaluacion']['fk_estatus_evaluacion'];
            $EstatusEvaluacion->fk_estatus = 65;
            // $EstatusEvaluacion->fk_evaluacion = 92;
            $EstatusEvaluacion->fk_evaluacion = $_POST['VswListarPersonas']['id_evaluacion'];
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 45;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                
            } else {
                echo "<pre>Comentarios";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }
            $Comentarios->comentario = $_POST['Comentarios']['comentario'];
            //   $Comentarios->fk_tipo_entidad = 1;
            $Comentarios->fk_estatus = 16;
            //   $Comentarios->fk_entidad = 2;
            // $Comentarios->fk_direccion = 1;  // cABLEADO
            $Comentarios->fk_evaluacion = $_POST['VswListarPersonas']['id_evaluacion'];
            $Comentarios->created_date = 'now()';
            $Comentarios->modified_date = 'now()';
            $Comentarios->created_by = Yii::app()->user->id;
            $Comentarios->es_activo = true;
            if ($Comentarios->save()) {
                
            }
            $this->redirect(array('evaluacion/recursoshumanos'));
        } else {

            $this->render('rrhheditar', array(
                'consultaPersona' => $consultaPersona, 'Comentarios' => $Comentarios, 'EstatusEvaluacion' => $EstatusEvaluacion, 'model' => $model, 'id_evaluacion' => $id_evaluacion,
            ));
        }
    }

    public function actionDireditar() {

        $model = new VswPdfObjetivos;
        $vista = new VswListarPersonas;
        $Comentarios = new Comentarios;
        $EstatusEvaluacion = new EstatusEvaluacion;
        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
        $id_evaluacion = $_GET['id'];
        if (isset($_POST['EstatusEvaluacion']['fk_estatus_evaluacion'])) {
//             var_dump($_POST);die;
            $EstatusEvaluacion->fk_estatus_evaluacion = $_POST['EstatusEvaluacion']['fk_estatus_evaluacion'];
            $EstatusEvaluacion->fk_estatus = 65;
            // $EstatusEvaluacion->fk_evaluacion = 92;
            $EstatusEvaluacion->fk_evaluacion = $_POST['VswListarPersonas']['id_evaluacion'];
            $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
            $EstatusEvaluacion->fk_tipo_entidad = 52;    // Cableado 
            $EstatusEvaluacion->fecha_estatus = 'now()';
            $EstatusEvaluacion->created_by = Yii::app()->user->id;
            $EstatusEvaluacion->created_date = 'now()';
            $EstatusEvaluacion->modified_date = 'now()';
            $EstatusEvaluacion->es_activo = true;
            if ($EstatusEvaluacion->save()) {
                
            } else {
                echo "<pre>Comentarios";
                var_dump($EstatusEvaluacion->Errors);
                exit;
            }
            $Comentarios->comentario = $_POST['Comentarios']['comentario'];
            //   $Comentarios->fk_tipo_entidad = 1;
            $Comentarios->fk_estatus = 16;
            //   $Comentarios->fk_entidad = 2;
            //           $Comentarios->fk_direccion = 1;  // cABLEADO
            $Comentarios->fk_evaluacion = $_POST['VswListarPersonas']['id_evaluacion'];
            $Comentarios->created_date = 'now()';
            $Comentarios->modified_date = 'now()';
            $Comentarios->created_by = Yii::app()->user->id;
            $Comentarios->es_activo = true;
            if ($Comentarios->save()) {
                
            }
            $this->redirect(array('evaluacion/dir'));
        } else {

            $this->render('direditar', array(
                'consultaPersona' => $consultaPersona, 'Comentarios' => $Comentarios, 'EstatusEvaluacion' => $EstatusEvaluacion, 'model' => $model, 'id_evaluacion' => $id_evaluacion,
            ));
        }
    }

    public function actionUpdateObjetivos() {


    //       var_dump($_GET);die;
        if (isset($_GET['id'])) {
            $model = VswPdfObjetivos::model()->findByAttributes(array('id_preguntas_ind' => $_GET['id']));
//        var_dump($model); echo '<pre>'; die;
            $model->attributes = $_GET['id'];
            $this->render('_objetivosUsuario', array(
                'model' => $model,
            ));
        }
        //var_dump($_GET); echo 'admin'; die;
        if (isset($_GET['VswPdfObjetivos'])) {

            //$model= new VswPdfObjetivos;   
            $modelSave = PreguntasIndividuales::model()->findByPk($_GET['VswPdfObjetivos']['id_preguntas_ind']);
            $modelSave->attributes = $_GET['VswPdfObjetivos'];
            $modelSave->id_preguntas_ind = $_GET['VswPdfObjetivos']['id_preguntas_ind'];

            if ($modelSave->update()) {
                
                $this->redirect(array('update', 'id' => $_GET['VswPdfObjetivos']['id_evaluacion']));
                
//                $id_evaluacion = $modelSave->fk_evaluacion;
//                if (isset($id_evaluacion)) {
//                    $EstatusEvaluacion = new EstatusEvaluacion;
//                    $EstatusEvaluacion->fk_estatus_evaluacion = 79;
//                    $EstatusEvaluacion->fk_estatus = 65;
//                    $EstatusEvaluacion->fk_evaluacion = $id_evaluacion;
//                    $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
//                    $EstatusEvaluacion->fk_tipo_entidad = 45;    // Cableado 
//                    $EstatusEvaluacion->fecha_estatus = 'now()';
//                    $EstatusEvaluacion->created_by = Yii::app()->user->id;
//                    $EstatusEvaluacion->created_date = 'now()';
//                    $EstatusEvaluacion->modified_date = 'now()';
//                    $EstatusEvaluacion->es_activo = true;
//                    if ($EstatusEvaluacion->save()) {
//
//                        //   var_dump($EstatusEvaluacion);die;
//                    } else {
//                        echo "<pre>EstatusEvaluacion";
//                        var_dump($EstatusEvaluacion->Errors);
//                        exit;
//                    }
//                }
            } else {

                echo "<pre>reerer";
                var_dump($modelSave->Errors);
                exit;
            }



            $this->redirect(array('update', 'id' => $_GET['VswPdfObjetivos']['id_evaluacion']));


//        $this->render('update', array(
//            'model' => $model,
//        ));
        }
     
        //   var_dump($_GET); echo 'admin'; die;
    }

    /**
     * FUNCIÓN QUE HACE EL RENDER PARA GENERAR LOS CERTIFICADOS DE LAS SOLICITUDES
     * RECIBI COMO PARAMETRO EL ID DE LA SOLICITUD
     */
    public function actionCertificado($id) {

        //DATOS DE LA PERSONA SUPERVISADA
        // var_dump($id);die;

        $vswpdf = VswPdfEvaluacion::model()->findByAttributes(array('id_evaluacion' => $id));
        $objetivo = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $id));
        $this->render('certificado', array('vswpdf' => $vswpdf, 'objetivo' => $objetivo,
        ));
    }

    public function actionPDFevaluacion($id) {

        //DATOS DE LA PERSONA SUPERVISADA
        // var_dump($id);die;

        $vswpdfinal = VswPdfEvalFinal::model()->findByAttributes(array('id_persona_evaluado' => $id));
        $objetivo = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $id));


        $this->render('pdfevaluacion', array('vswpdfinal' => $vswpdfinal, 'objetivo' => $objetivo,
        ));
    }

    public function actionPDFobrero($id) {

        //DATOS DE LA PERSONA SUPERVISADA
        // var_dump($id);die;

        $vswpdfobrero = VswPdfEvalFinal::model()->findByAttributes(array('id_persona_evaluado' => $id));
        $objetivo = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $id));


        $this->render('pdfobrero', array('vswpdfobrero' => $vswpdfobrero, 'objetivo' => $objetivo,
        ));
    }

   public function actionCreate_revi() {
//        var_dump ($_GET); die;

        $model = new Revision;
        $Comentrevs = new Comentarios;
        $evaluador = new Evaluador;
        $maestro = new MaestroEvaluacion;

        if (date("n") <= 06) {
            $condicion = '81'; // PRIMER PERIDO
        } else {
            $condicion = '82'; // SEGUNDO PERIODO
        }
        $periodo = MaestroEvaluacion::model()->findByAttributes(array('id_maestro' => $condicion));

        $consultaPersona = VswListarPersonas::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));

        if (isset($_GET['id'])) {
            
        $consulta_revision = Revision::model()->findByAttributes(array('fk_evaluacion' => $_GET['id']));
        $consulta_revision2 = Revision::model()->findAllByAttributes(array('fk_evaluacion' => $_GET['id']));
        $contador = count($consulta_revision2);
//        var_dump($contador);die;
        $fecha_revisioncon1 = $consulta_revision["fecha_revision"];
        
        if ($fecha_revisioncon1== NULL || $fecha_revisioncon1 == ''){
            
            if (date("n") <= 06) {
            $fecha_revisioncon = '01/01/'.date("Y"); // PRIMER PERIDO
            } else {
                $fecha_revisioncon = '01/07/'.date("Y");  // SEGUNDO PERIODO
            }
            
        }  else {
            $fecha_revisioncon2 = $consulta_revision2[$contador-1]['fecha_revision'];
            $fecha_revisioncon=date("d-m-Y",strtotime("$fecha_revisioncon2+ 1 days"));
        }
          
// echo '<pre>';  var_dump ($consulta_revision2[$contador-1]['fecha_revision']); die;
       if (isset($_POST['Revision'])) {
                $model->fk_revision =$_POST['MaestroEvaluacion']['id_maestro'];
                
                // $model->fk_evaluador= $consultaPersona->id_persona;
                $model->fk_evaluacion = $_GET['id'];
                //  var_dump ($_POST); die;
                $model->fecha_revision = Generico::formatoFecha($_POST['Revision']['fecha_revision']);
                $model->comentario = $_POST['Revision']['comentario'];
                $model->fk_estatus = 93; // maestro
                $model->created_date = 'now()';
                $model->modified_date = 'now()';
                $model->created_by = Yii::app()->user->id;
                $model->es_activo = true;

                if ($model->save()) {
                    $this->redirect(array('admin'));
                } else {
                    echo "<pre>evaluados";
                    var_dump($model->Errors);
                    exit;
                }
            } else {

                $this->render('_form_revi', array('consultaPersona'=>$consultaPersona, 'fecha_revisioncon'=> $fecha_revisioncon,
                  'periodo' => $periodo,  'model' => $model, 'Comentrevs' => $Comentrevs));
            }
        }
    }
    
    public function actionRrhh_cierre() {
        $model = new VswListarPersonas('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['VswListarPersonas']))
            $model->attributes = $_GET['VswListarPersonas'];

        //$this->redirect(array("id_evaluacion","id"=>$model->getPrimaryKey()));
        
        $estatus_nuevo = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '47'));
        $estatus_enviado = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '48'));
        $estatus_aprobado = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '49'));
        $estatus_rechazado = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '50'));
        $estatus_revisado = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '79'));
        $estatus_finalizado = VswListarPersonas::model()->findAllByAttributes(array('fk_estatus_evaluacion' => '51'));
        
        if (date('n') <= 6) {
            $fecha_inicio = "01-01-" . date('Y') . " 00:00:00";
            $fecha_final = "30-06-" . date('Y') . " 23:59:59";
        }
        if (date('n') >= 7) {
            $fecha_inicio = "01-07-" . date('Y') . " 00:00:00";
            $fecha_final = "31-12-" . date('Y') . " 23:59:59";
        }
        
        $cambio_estatus = VswListarPersonas::model()->findAll("(fk_estatus_evaluacion = 47 OR fk_estatus_evaluacion = 48 OR fk_estatus_evaluacion = 49 OR fk_estatus_evaluacion = 50 OR fk_estatus_evaluacion = 79) AND fecha_creacion_evaluacion BETWEEN '" . $fecha_inicio . "' AND '" . $fecha_final . "'");
//        var_dump($cambio_estatus);die;
        
        if(isset($_POST['respuesta'])){
            $filas = count($cambio_estatus);
            $i = 0;
            $verifica = 0;
            while($i<$filas){
                $EstatusEvaluacion = new EstatusEvaluacion;
                $EstatusEvaluacion->fk_estatus_evaluacion = 108;
                $EstatusEvaluacion->fk_estatus = 65;
                $EstatusEvaluacion->fk_evaluacion = $cambio_estatus[$i]['id_evaluacion'];
                $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
                $EstatusEvaluacion->fk_tipo_entidad = 45;    // Cableado 
                $EstatusEvaluacion->fecha_estatus = 'now()';
                $EstatusEvaluacion->created_by = Yii::app()->user->id;
                $EstatusEvaluacion->created_date = 'now()';
                $EstatusEvaluacion->modified_date = 'now()';
                $EstatusEvaluacion->es_activo = true;
                    if ($EstatusEvaluacion->save()) {
                        $verifica++;
                    } else {
                        echo "<pre>EstatusEvaluacion";
                        var_dump($EstatusEvaluacion->Errors);
                        exit;
                    }
                $i++;
            }
            if($verifica==$filas){
                $this->redirect(array('recursoshumanos'));
            }
        }
        
        $this->render('rrhh_cierre', array(
            'model' => $model,
            'estatus_nuevo' => $estatus_nuevo,
            'estatus_enviado' => $estatus_enviado,
            'estatus_aprobado' => $estatus_aprobado,
            'estatus_rechazado'=> $estatus_rechazado,
            'estatus_revisado' => $estatus_revisado,
            'estatus_finalizado' => $estatus_finalizado,
        ));
    }
    
    public function actionRenovarEvaluacion($id) {
        $EstatusEvaluacion = new EstatusEvaluacion;
        
        $CambioEstatus = EstatusEvaluacion::model()->findAllBySql('SELECT * FROM evaluacion.estatus_evaluacion WHERE fk_evaluacion = ' . $id . ' ORDER BY id_estatus_evaluacion DESC LIMIT 2');
        
        
        $EstatusEvaluacion = new EstatusEvaluacion;
        $EstatusEvaluacion->fk_estatus_evaluacion = $CambioEstatus[1]['fk_estatus_evaluacion'];
        $EstatusEvaluacion->fk_estatus = 65;
        $EstatusEvaluacion->fk_evaluacion = $id;
        $EstatusEvaluacion->fk_entidad = Yii::app()->user->id;
        $EstatusEvaluacion->fk_tipo_entidad = 45;    // Cableado 
        $EstatusEvaluacion->fecha_estatus = 'now()';
        $EstatusEvaluacion->created_by = Yii::app()->user->id;
        $EstatusEvaluacion->created_date = 'now()';
        $EstatusEvaluacion->modified_date = 'now()';
        $EstatusEvaluacion->es_activo = true;
        if ($EstatusEvaluacion->save()) {
            $this->redirect(array('recursoshumanos'));    
        } else {
            echo "<pre>EstatusEvaluacion";
            var_dump($EstatusEvaluacion->Errors);
            
            exit;
        }
    }
    
    public function actionReporte_Rechazados() {
        $sql = "select eval.fk_evaluacion as n_evaluacion, eva.apellidos || ' ' || eva.nombres as evaluador, eva.dependencia as oficina, eva.apellidos_evaluado || ' ' || eva.nombres_evaluado as evaluado, 
                count(eval.fk_evaluacion) as rechazos
                from evaluacion.estatus_evaluacion eval
                JOIN evaluacion.vsw_listar_personas eva ON eva.id_evaluacion = eval.fk_evaluacion 
                where eval.fk_estatus_evaluacion = 50 and eval.fk_entidad = ". 11 //467
                . "group by eval.fk_evaluacion, eva.apellidos, eva.nombres, eva.dependencia, eva.apellidos_evaluado, eva.nombres_evaluado
                having count(eval.fk_evaluacion) >=3
                order by eval.fk_evaluacion";
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
//        var_dump($row);die;
        
        if(isset($_POST['pdf']) || isset($_POST['exel'])){
        if ($_POST['pdf'] == 'si') {
            
                $this->render('pdf_rechazados', array('row' => $row));
                Yii::app()->end();
           
        }
        if ($_POST['exel'] == 'si') {
            $celdas = array("A", "B", "C", "D", "E");
//                    $objPHPExcel = new PHPExcel();
            $objPHPExcel = XPHPExcel::createPHPExcel();
            //PROPIEDADES DEL DOCUMENTO CAL
            $objPHPExcel->
                    getProperties()
                    ->setCreator("minmujer")
                    ->setLastModifiedBy("minmujer.gob.ve")
                    ->setTitle("Exportar")
                    ->setSubject("Minmujer")
                    ->setDescription("minmujer")
                    ->setKeywords("minmujer")
                    ->setCategory("reporte");

            $tituloStyle1 = new PHPExcel_Style();
            $tituloStyle1->applyFromArray(
                    array(
                        'font' => array(
                            'bold' => true,
                        ),
                        'alignment' => array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                        ),
            ));
            $tituloStyle2 = new PHPExcel_Style();
            $tituloStyle2->applyFromArray(
                    array(
                        'font' => array(
                            'bold' => true,
//                                    'color' => array('rgb' => '3A87AD')
                        ),
                        'alignment' => array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_LEFT
                        ),
            ));
            $sharedStyle1 = new PHPExcel_Style();
            $sharedStyle1->applyFromArray(
                    array('fill' => array(
                            'type' => PHPExcel_Style_Fill::FILL_SOLID,
                            'color' => array('rgb' => '00BFFF')
                        ),
                        'font' => array(
                            'bold' => true,
                        ),
                        'alignment' => array(
                            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                        ),
                        'borders' => array(
                            'allborders' => array(
                                'style' => PHPExcel_Style_Border::BORDER_THIN,
                            ),
                        )
            ));
//
//                    //AUTO REDIMENCION DE LAS COLUMNAS
            $objPHPExcel->getActiveSheet()->mergeCells('A1:E1'); //union de colunmas
            $k = 0;

                    foreach ($row as $camposTitulo) {


                        $letra = $celdas[$k];
                        $camposTitulo = str_replace("descripcion_dir1", "AVENIDA/CALLE/CARRETERA", $camposTitulo);
                        $camposTitulo = str_replace("descripcion_dir2", "BARRIO/CASERIO/SECTOR/VEREDA", $camposTitulo);
                        $camposTitulo = str_replace("descripcion_vivienda", "CASA/EDIFICIO/QUINTA/RANCHO", $camposTitulo);
                        $tituloFormat = strtoupper(str_replace("_", " ", $camposTitulo));
                        $objPHPExcel->setActiveSheetIndex(0)
                                ->setCellValue("" . $letra . "10", "" . strtoupper(str_replace("FORMATO", " ", $tituloFormat)) . "");
                        $k++;
                    }

                    $c = 11;
                    $siturCC = '';
                    $z = 0;

                    for ($j = 0; $j < count($row); $j++) {
                        $m = 0;
                        
                        foreach ($row as $camposTituloDato) {
                            $letra = $celdas[$m];
                            $camposf = trim($camposTituloDato);

                            $objPHPExcel->setActiveSheetIndex(0)
                                    ->SetCellValue("$letra" . "$c", $consulta[$j][$camposf]);
                            $objPHPExcel->getActiveSheet()->getColumnDimension($letra)->setAutoSize(true);

                            $m++;
                        }
                        $c++;
                        $z++;
                    }

            $objPHPExcel->getActiveSheet()->SetCellValue("A3", 'Registro Una Mujer');
            $objPHPExcel->getActiveSheet()->mergeCells('A3:F3');
            $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A3:F3");
            $objPHPExcel->getActiveSheet()->SetCellValue("A4", 'Listado Detallado ' . $titulo2);
            $objPHPExcel->getActiveSheet()->mergeCells('A4:F4');
            $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A4:F4");
//                    $objPHPExcel->getActiveSheet()->SetCellValue("A6", 'Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"');
            $objPHPExcel->getActiveSheet()->mergeCells('A6:F6');
            $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A6:F6");
//                    $objPHPExcel->getActiveSheet()->SetCellValue("A9", $z . ' Registros encontrados');
            $objPHPExcel->getActiveSheet()->mergeCells('A9:F9');
            $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle2, "A9:F9");
            $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A10:F10");
            $objPHPExcel->getActiveSheet()->setSharedStyle($sharedStyle1, "A10:" . $letra . "10");

            $objPHPExcel->getActiveSheet()->getRowDimension('1A')->setRowHeight(50);
            $objPHPExcel->getActiveSheet()->getRowDimension('4A')->setRowHeight(50);
            $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);

//                    aqui se llama a la imagen
//                    $objDrawing = new PHPExcel_Worksheet_Drawing();
//                    $objDrawing->setName('PHPExcel logo');
//                    $objDrawing->setDescription('PHPExcel logo');
////                    $objDrawing->setPath('./images/cintillo_200_admirable.jpg');       // filesystem reference for the image file
//                    $objDrawing->setWidth(400);                 // sets the image height to 36px (overriding the actual image height); 
//                    $objDrawing->setCoordinates('A1');    // pins the top-left corner of the image to cell D24
//                    $objDrawing->setWorksheet($objPHPExcel->getActiveSheet());

            $objDrawingPType = new PHPExcel_Worksheet_Drawing();
            $objDrawingPType->setWorksheet($objPHPExcel->setActiveSheetIndex(0));
            $objDrawingPType->setName("Pareto By Type");
            $objDrawingPType->setPath(Yii::app()->basePath . DIRECTORY_SEPARATOR . "../img/banner1.png");

            $objDrawingPType->setHeight(25);
//        $objDrawingPType->setWidth(100);
//
            $objDrawingPType->setCoordinates('A1');
//        $objDrawingPType->setOffsetX(10);
//        $objDrawingPType->setOffsetY(5);

            $objPHPExcel->getActiveSheet()->setTitle($titulo); //pagina en la hoja de calculo
            $objPHPExcel->setActiveSheetIndex(0);
            ob_end_clean();
            ob_start();

            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="ReporteUnaMujer.xls"');
            header('Cache-Control: max-age=0');
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $objWriter->save('php://output');
        }
        }

        $this->render('reporte_rechazados', array(
            'row' => $row,
        ));
        
        
    }

}
