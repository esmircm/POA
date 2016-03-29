<?php

class ValidacionJsController extends Controller {
    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
//public $layout='//layouts/column2';



    /**
     * @return array action filters
     */
//    public function filters() {
//        return array(array('CrugeAccessControlFilter'));
//    }

    /**
     * ACCION QUE BUSCA POR CEDULA EN EL SAIME
     * 
     */
    public function actionbuscarSaime() {
        $Cedula = (int) $_POST['cedula'];
        $nacionalidad = $_POST['nacionalidad'];

        $SQL3 = "SELECT * FROM buscar_diex('" . $nacionalidad . "'," . $Cedula . ")";
        $data = Yii::app()->db4->createCommand($SQL3)->queryRow();

        if ($data) {
            $date = date_create($data['dtmnacimiento']);
            $data = array(
                'intcedula' => $data['intcedula'],
                'strgenero' => $data['strgenero'],
                'strnombre_primer' => $data['strnombre_primer'],
                'strnombre_segundo' => $data['strnombre_segundo'],
                'strapellido_primer' => $data['strapellido_primer'],
                'strapellido_segundo' => $data['strapellido_segundo'],
                'dtmnacimiento' => date_format($date, 'd/m/Y')
            );
//            var_dump($data);exit;
            echo json_encode($data);
        } else {
            echo json_encode(1);
        }
    }

    /**
     * FUNCION QUE PERMITE BUSCAR EL TITULO POR ID DE NIVEL EDUCATIVO
     */
    public function actionBuscarTitulo() {

        $Id = (isset($_POST['Educacion']['id_nivel_educativo']) ? $_POST['Educacion']['id_nivel_educativo'] : $_GET['id_nivel_educativo']);
        $Selected = isset($_GET['titulo']) ? $_GET['titulo'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_nivel_educativo = :id_nivel_educativo');
            $criteria->params = array(':id_nivel_educativo' => $Id);
            $criteria->order = 't.descripcion ASC';

            $data = CHtml::listData(Titulo::model()->findAll($criteria), 'id_titulo', 'descripcion');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODOS LOS ESTADOS POR EL ID DEL PAIS 
     */
    public function actionBuscarEstados() {

        $Id = (isset($_POST['Pais']['id_pais']) ? $_POST['Pais']['id_pais'] : $_GET['id_pais']);
        $Selected = isset($_GET['estado']) ? $_GET['estado'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_pais = :id_pais');
            $criteria->params = array(':id_pais' => $Id);
            $criteria->order = 't.nombre ASC';

            $data = CHtml::listData(Estado::model()->findAll($criteria), 'id_estado', 'nombre');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODAS LA CIUDADES POR EL ID DEL ESTADO 
     */
    public function actionBuscarCiudad() {
        $Id = (isset($_POST['Estado']['id_estado']) ? $_POST['Estado']['id_estado'] : $_GET['id_estado']);
        $Selected = isset($_GET['id_ciudad']) ? $_GET['id_ciudad'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_estado = :id_estado');
            $criteria->params = array(':id_estado' => $Id);
            $criteria->order = 't.nombre ASC';
            $data = CHtml::listData(Ciudad::model()->findAll('id_estado=:id_estado', array(':id_estado' => $Id)), 'id_ciudad', 'nombre');

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODOS LOS ESTADOS POR EL ID DEL PAIS 
     */
    public function actionBuscarEstadosRes() {

        $Id = (isset($_POST['Pais']['id_pais1']) ? $_POST['Pais']['id_pais1'] : $_GET['id_pais1']);

        $Selected = isset($_GET['estado1']) ? $_GET['estado1'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_pais = :id_pais1');
            $criteria->params = array(':id_pais1' => $Id);
            $criteria->order = 't.nombre ASC';

            $data = CHtml::listData(Estado::model()->findAll($criteria), 'id_estado', 'nombre');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODAS LA CIUDADES POR EL ID DEL ESTADO 
     */
    public function actionBuscarCiudadRes() {
        $Id = (isset($_POST['Estado']['id_estado1']) ? $_POST['Estado']['id_estado1'] : $_GET['id_estado1']);

        $Selected = isset($_GET['id_ciudad']) ? $_GET['id_ciudad'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_estado = :id_estado1');
            $criteria->params = array(':id_estado1' => $Id);
            $criteria->order = 't.nombre ASC';
            $data = CHtml::listData(Ciudad::model()->findAll('id_estado=:id_estado', array(':id_estado' => $Id)), 'id_ciudad', 'nombre');

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    public function actionbuscarListar() {
        $Cedula = (int) $_POST['cedula'];
//        var_dump($Cedula);die;

        $SQL5 = VswEvaluacion::model()->findByAttributes(array('cedula' => $Cedula));
//        $SQL3 = Cargo::model()->findByAttributes(array('cod_cargo' => $SQL3->cod_cargo ));
//        $SQL3 = Dependencia::model()->findByAttributes(array('$nombre' => $SQL3->nombre));
//        var_dump($SQL5);die;
        if ($SQL5) {

            $data = array(
                'cedula' => $Cedula,
                'nacionalidad_evaluado' => $SQL5->nacionalidad,
                'nombres_evaluado' => $SQL5->nombres,
                'apellidos_evaluado' => $SQL5->apellidos,
                'cargo_evaluado' => $SQL5->descripcion_cargo,
                'oficina_evaluado' => $SQL5->dependencia,
                'id_persona_evaluado' => $SQL5->id_persona,
            );
            echo json_encode($data);
        } else {
            echo json_encode(0);
        }
    }

    /**
     * ACCION QUE BUSCA POR CEDULA EN SIGEFIRRHH
     */
    public function actionbuscarSupervisor() {
        $Cedula = (int) $_POST['cedula'];
//        var_dump($Cedula);die;

        $SQL3 = VswEvaluacion::model()->findByAttributes(array('cedula' => $Cedula));
//        $SQL3 = Cargo::model()->findByAttributes(array('cod_cargo' => $SQL3->cod_cargo ));
//        $SQL3 = Dependencia::model()->findByAttributes(array('$nombre' => $SQL3->nombre));
        if ($SQL3) {

            $data = array(
                'cedula' => $Cedula,
                'nacionalidad' => $SQL3->nacionalidad,
                'nombres' => $SQL3->nombres,
                'apellidos' => $SQL3->apellidos,
                'codnomina' => $SQL3->codigo_nomina,
                'descargo' => $SQL3->descripcion_cargo,
                'depnombre' => $SQL3->dependencia,
                'id_persona' => $SQL3->id_persona,
            );
            echo json_encode($data);
        } else {
            echo json_encode(1);
        }
    }

    public function actionbuscarSupervisado() {
        $cedula = (int) $_POST['cedula'];

//        if (7 <= 6) {
        if (date('n') <= 6) {
            $fecha_inicio = "01-01-" . date('Y') . " 00:00:00";
            $fecha_final = "30-06-" . date('Y') . " 23:59:59";
        }
//        if (7 >= 7) {
        if (date('n') >= 7) {
            $fecha_inicio = "01-07-" . date('Y') . " 00:00:00";
            $fecha_final = "31-12-" . date('Y') . " 23:59:59";
        }
        
        $ver = VswListarPersonas::model()->find("cedula_evaluado = " . $cedula . " AND fecha_creacion_evaluacion BETWEEN '" . $fecha_inicio . "' AND '" . $fecha_final . "'");
//        var_dump(date('m'));
        
        $Evaluacion = VswEvaluacion::model()->findByAttributes(array('cedula' => $cedula));
        
        if ($Evaluacion) {
            $to_char = $Evaluacion['to_char'];
            $fecha_ingreso = explode("-", $to_char);
            $fecha = date_create($fecha_ingreso[2] . "-" . $fecha_ingreso[1] . "-" . $fecha_ingreso[0]);
//            $fecha = date_create("2016-03-10");

            if (date('n') <= 6) {
                $fecha_tope = date_create(date('Y') . "-06-30");
                $validacion_fecha = date_diff($fecha_tope, $fecha);
            }
            if (date('n') >= 7) {
                $fecha_tope = date_create(date('Y') . "-12-30");
                $validacion_fecha = date_diff($fecha_tope, $fecha);
            }
            $validacion_dias = $validacion_fecha->format('%a');
            
            if ($validacion_dias <= 120) {
                $validacion_evaluacion = 3;
            }
            
        }
        if ($Evaluacion) {
            if ($Evaluacion['fk_tipo_clase'] == '') {
                if ($Evaluacion['tipo_cargo'] == 4) {
                    $fk_tipo_clase = 11;
                } else {
                    if ($Evaluacion['grado'] == 9 || $Evaluacion['grado'] == 99) {
                        $fk_tipo_clase = 14;
                    } else {
                        $fk_tipo_clase = 13;
                    }
                }
            } else {
                $fk_tipo_clase = $Evaluacion->fk_tipo_clase;
            }
        }

        ///////////////////////////////////////////////////////////////////////
        //////////////Codigo de los 120 IMPORTANTE/////////////////////////////
        ///////////////////////////////////////////////////////////////////////
  
        if ($Evaluacion){
            //Condicion para los Obreros despues de los 120 días//

            if ($fk_tipo_clase == 11) {
                
                if (date('n') <= 6) {
                    $fecha_inicio = date_create(date('Y') . "-01-01");
//                    $fecha_actual = date_create('2016-06-20');
                    $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

                    $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
                    $dias_diferencia = $validacion_fecha->format('%a');
//                    var_dump($dias_diferencia);
                    if ($dias_diferencia <= 120) {

//                    var_dump($dias_diferencia);
                        $validacion_evaluacion = 1;
                    }
                }
                
                if (date('n') >= 7) {
                    $fecha_inicio = date_create(date('Y') . "-07-01");
                    $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

                    $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
                    $dias_diferencia = $validacion_fecha->format('%a');

                    if ($dias_diferencia <= 120) {

//                        var_dump($dias_diferencia);
                        $validacion_evaluacion = 1;
                    }
                }

            }

            ///Condicion para los Profesionales, Supervisores y Apoyo que esten fuera de los 120 dias reglamentarios///
            if ($fk_tipo_clase != 11) {
                if (date('n') <= 6) {
                    $fecha_inicio = date_create(date('Y') . "-01-01");
//                    $fecha_actual = date_create('2016-06-20');
                    $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

                    $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
                    $dias_diferencia = $validacion_fecha->format('%a');
                    if ($dias_diferencia > 120) {
                        $validacion_evaluacion = 2;
                    }
                }
                
                if (date('n') >= 7) {
                    $fecha_inicio = date_create(date('Y') . "-07-01");
                    $fecha_actual = date_create(date('Y') . '-' . date('m') . '-' . date('d'));

                    $validacion_fecha = date_diff($fecha_actual, $fecha_inicio);
                    $dias_diferencia = $validacion_fecha->format('%a');

                    if ($dias_diferencia > 120) {
                        $validacion_evaluacion = 2;
                    }
                }
            }
        }
        
        
        ///////////////////////////////////////////////////////////////
        //////////////----FINAL DE LOS 120 DIAS----////////////////////
        ///////////////////////////////////////////////////////////////
       
            
          ///---------------Codigo donde se evalua si el Personal tiene más de 120 laborando-----------///  
//        if ($Evaluacion) {
//            $to_char = $Evaluacion['to_char'];
//            $fecha_ingreso = explode("-", $to_char);
//            $fecha = date_create($fecha_ingreso[2] . "-" . $fecha_ingreso[1] . "-" . $fecha_ingreso[0]);
//            $fecha_tope = date_create(date('Y') . '-' . date('m') . '-' . date('d'));
//
//
//            $validacion_fecha = date_diff($fecha_tope, $fecha);
//            $dias_diferencia = $validacion_fecha->format('%a');
////                var_dump($dias_diferencia);die;
//            if ($dias_diferencia <= 120) {
//                $validacion_dias = "No cumple con la Evaluación";
//            }
//        }


        if ($Evaluacion) {
            /////////////////////////////////////////////
            //Envio del Mensaje a .js para los 120 días//
            /////////////////////////////////////////////
            
            if (isset($validacion_evaluacion)) {
                if($validacion_evaluacion==1){
                    $data = array(
                        'respuesta' => 3,
                    );
                    echo json_encode($data);
                }
                if($validacion_evaluacion==2){
                    $data = array(
                        'respuesta' => 4,
                    );
                    echo json_encode($data);
                }
                if($validacion_evaluacion==3){
                    $data = array(
                        'respuesta' => 5,
                    );
                    echo json_encode($data);
                }
            } else {
                if ($ver) {
                    $data = array(
                        'nombres_evaluador' => $ver->nombres,
                        'apellidos_evaluador' => $ver->apellidos,
                        'direccion' => $ver->dependencia,
                        'respuesta' => 1,
                    );
                    echo json_encode($data);
                } else {
                    
                    
                    
                    $data = array(
                        'cedula' => $Evaluacion->cedula,
                        'fk_tipo_clase' => $fk_tipo_clase,
                        'id_persona' => $Evaluacion->id_persona,
                        'nacionalidad' => $Evaluacion->nacionalidad,
                        'nombres' => $Evaluacion->nombres,
                        'apellidos' => $Evaluacion->apellidos,
                        'codigo_nomina' => $Evaluacion->codigo_nomina,
                        'descripcion_cargo' => $Evaluacion->descripcion_cargo,
                        'dependencia' => $Evaluacion->dependencia,
                    );
                    echo json_encode($data);
                    
                }
            }
        } else {
            $data = array(
                'respuesta' => 2,
            );
            echo json_encode($data);
        }
    }

    public function actionGuardarFamiliar() {
        $familiar = new Familiar;
//        $educacion = new Niveleducativo;
        $SQL3 = Familiar::model()->findAllBySql('SELECT id_familiar FROM familiar order by id_familiar desc limit 1');


        $familiar->id_familiar = empty($SQL3) ? 1 : $SQL3[0]->id_familiar + 1;

        $familiar->fecha_nacimiento = Generico::formatoFecha($_POST['fechaNacimiento']); //cambia el formato de la fecha dd/mm/yyyy



        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $personal = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $model = Familiar::model()->findByAttributes(array('id_personal' => $personal->id_personal));
        switch ($_POST['grupoSanguineo']) {
            case 'O':
                $grupo_sanguineo = 'O+';
                break;
            case 'AB':
                $grupo_sanguineo = 'AB+';
                break;
            case 'B':
                $grupo_sanguineo = 'B+';
                break;
            case 'A':
                $grupo_sanguineo = 'A+';
                break;
            default;
                $grupo_sanguineo = NULL;
                break;
        }
        $familiar->id_personal = $personal->id_personal;
        $familiar->cedula_familiar = $_POST['cedulaFamiliar'];
        $familiar->primer_nombre = strtoupper($_POST['primerNombre']);
        $familiar->segundo_nombre = strtoupper($_POST['segundoNombre']);
        $familiar->primer_apellido = strtoupper($_POST['primerApellido']);
        $familiar->segundo_apellido = strtoupper($_POST['segundoApellido']);
        $familiar->estado_civil = $_POST['estadoCivil'];
        $familiar->sexo = $_POST['sexo'];

//        $familiar->fecha_nacimiento = $_POST['fechaNacimiento'];
        $familiar->fecha_nacimiento = Generico::formatoFecha($_POST['fechaNacimiento']);
        $familiar->parentesco = $_POST['parentesco'];
        $familiar->mismo_organismo = $_POST['mismoOrganismo'];
        $familiar->nivel_educativo = $_POST['nivelEducativo'];
        $familiar->grado = $_POST['grado'];
        $familiar->promedio_nota = $_POST['promedioNota'];
        $familiar->goza_utiles = $_POST['gozaUtiles'];
        $familiar->grupo_sanguineo = !empty($grupo_sanguineo) ? $grupo_sanguineo : $_POST['grupoSanguineo'];
        $familiar->nino_excepcional = $_POST['ninoExcepcional'];
        $familiar->alergico = $_POST['alergico'];
        $familiar->alergias = $_POST['alergias'];
        $familiar->talla_franela = $_POST['tallaFranela'];
        $familiar->talla_pantalon = $_POST['tallaPantalon'];
        $familiar->talla_gorra = $_POST['tallaGorra'];
//        echo '<pre>';var_dump($familiar->grupo_sanguineo);exit;

        if ($familiar->save()) {
            echo json_encode(1);
        } else {
            echo json_encode(2);
            //echo '<pre>';var_dump($familiar->Errors);die;
        }
    }

    public function actionBuscaPersona() {
        $Cedula = (int) $_POST['cedulaFamiliar'];
        $nacionalidad = $_POST['nacionalidadFamiliar'];
        $nombre = $_POST['nombreFamiliar'];
        $apellido = $_POST['apellidoFamiliar'];
        $SQL3 = "SELECT * FROM buscar_diex('" . $nacionalidad . "'," . $Cedula . ")";
        $data = Yii::app()->db4->createCommand($SQL3)->queryRow();
        $data = (object) $data;
        if (!empty($data->intcedula)) {
            $cedula = Yii::app()->getSession()->get('CedulaUser');
            $personal = Personal::model()->findByAttributes(array('cedula' => $cedula));
            $cedulapersonal = (int) $personal->cedula;

            if ($cedulapersonal != $Cedula) {

                $buscarFamiliar = Familiar::model()->findByAttributes(array('id_personal' => $personal->id_personal, 'cedula_familiar' => $Cedula));
                if (!empty($buscarFamiliar)) {

                    echo json_encode(2);
                } else {
                    $data->dtmnacimiento = date('d/m/Y', strtotime($data->dtmnacimiento));
                    echo json_encode($data);
                }
            } else {
                echo json_encode(2);
            }
        } else {
            $cedula = Yii::app()->getSession()->get('CedulaUser');
            $personal = Personal::model()->findByAttributes(array('cedula' => $cedula));
            $buscarFamiliarHijo = Familiar::model()->findByAttributes(array('id_personal' => $personal->id_personal, 'primer_nombre' => $nombre, 'primer_apellido' => $apellido));
//            var_dump($buscarFamiliarHijo);die;
            if (!empty($buscarFamiliarHijo)) {
                echo json_encode(2);
            }
        }
    }

    public function actionActualizarFamiliar() {
        $familiar = Familiar::model()->findByPk($_POST['id']);
        //var_dump($familiar);die;
        $educacion = new Niveleducativo;

        switch ($_POST['grupoSanguineo']) {
            case 'O':
                $grupo_sanguineo = 'O+';
                break;
            case 'AB':
                $grupo_sanguineo = 'AB+';
                break;
            case 'B':
                $grupo_sanguineo = 'B+';
                break;
            case 'A':
                $grupo_sanguineo = 'A+';
                break;
            default;
                $grupo_sanguineo = NULL;
                break;
        }

        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $personal = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $familiar->id_personal = $personal->id_personal;
        $familiar->estado_civil = $_POST['estadoCivil'];
        $familiar->mismo_organismo = $_POST['mismoOrganismo'];
        $familiar->nivel_educativo = $_POST['nivelEducativo'];
        $familiar->grado = $_POST['grado'];
        $familiar->promedio_nota = $_POST['promedioNota'];
        $familiar->goza_utiles = $_POST['gozaUtiles'];
        $familiar->grupo_sanguineo = !empty($grupo_sanguineo) ? $grupo_sanguineo : $_POST['grupoSanguineo'];
        $familiar->nino_excepcional = $_POST['ninoExcepcional'];
        $familiar->alergico = $_POST['alergico'];
        $familiar->alergias = $_POST['alergias'];
        $familiar->talla_franela = $_POST['tallaFranela'];
        $familiar->talla_pantalon = $_POST['tallaPantalon'];
        $familiar->talla_gorra = $_POST['tallaGorra'];
        if ($familiar->save()) {
//        var_dump($familiar);
//        exit;
            echo json_encode(1);
        } else {
            echo json_encode(2);
            echo '<pre>';
            var_dump($familiar->Errors);
            die;
        }
    }

    public function actionGuardarPersonal1() {
        $personal = new Personal;
        var_dump($_POST);
        exit;
        $personal->madre_padre = $_POST['madre_padre'];
        if ($personal->save()) {
            $personal->discapacidad = $_POST['discapacidad'];
            if ($personal->save()) {

                exit;
                echo json_encode(1);
            } else {
                
            }
        }
    }

    public function actionBuscarIndigena() {

        $Id = (isset($_POST['puebloindigena']['id_pueblo_indigena']) ? $_POST['puebloindigena']['id_pueblo_indigena'] : $_GET['id_pueblo_indigena']);
        $Selected = isset($_GET['id_pueblo_indigena']) ? $_GET['id_pueblo_indigena'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_pueblo_indigena = :id_pueblo_indigena');
            $criteria->params = array(':id_nivel_educativo' => $Id);
            $criteria->order = 't.descripcion ASC';

            $data = CHtml::listData(Puebloindigena::model()->findAll($criteria), 'id_pueblo_indigena', 'descripcion');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODOS LOS ESTADOS POR EL ID DEL PAIS 
     */
    public function actionBuscarEstados2() {

        $Id = (isset($_POST['Pais']['id_pais']) ? $_POST['Pais']['id_pais'] : $_GET['id_pais']);
        $Selected = isset($_GET['estado']) ? $_GET['estado'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_pais = :id_pais');
            $criteria->params = array(':id_pais' => $Id);
            $criteria->order = 't.nombre ASC';

            $data = CHtml::listData(Estado::model()->findAll($criteria), 'id_estado', 'nombre');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION QUE MUESTRA TODAS LA CIUDADES POR EL ID DEL ESTADO 
     */
    public function actionBuscarCiudad2() {
        $Id = (isset($_POST['Estado']['id_estado']) ? $_POST['Estado']['id_estado'] : $_GET['id_estado']);
        $Selected = isset($_GET['id_ciudad']) ? $_GET['id_ciudad'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.id_estado = :id_estado');
            $criteria->params = array(':id_estado' => $Id);
            $criteria->order = 't.nombre ASC';
            $data = CHtml::listData(Ciudad::model()->findAll('id_estado=:id_estado', array(':id_estado' => $Id)), 'id_ciudad', 'nombre');

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    public function actionGuardarPersonales() {
        $personales = new Familiar;
        $personales->cedula_familiar = $_POST['cedulaFamiliar'];
        $personales->primer_nombre = $_POST['primerNombre'];
        $personales->segundo_nombre = $_POST['segundoNombre'];
        $personales->primer_apellido = $_POST['primerApellido'];
        $personales->segundo_apellido = $_POST['segundoApellido'];
        $personales->fecha_nacimiento = $_POST['fechaNacimiento'];
        $personales->estado_civil = $_POST['estadoCivil'];
        $personales->alergias = $_POST['alergias'];
        $personales->alergico = $_POST['alergico'];
        $personales->goza_utiles = $_POST['gozaUtiles'];
        $personales->grado = $_POST['grado'];
        $personales->grupo_sanguineo = $_POST['grupoSanguineo'];
        $personales->mismo_organismo = $_POST['mismoOrganismo'];
        $personales->nino_excepcional = $_POST['ninoExcepcional'];
        $personales->nivel_educativo = $_POST['nivelEducativo'];
        $personales->parentesco = $_POST['parentesco'];
        $personales->sexo = $_POST['sexo'];
        $personales->talla_franela = $_POST['tallaFranela'];
        $personales->talla_gorra = $_POST['tallaGorra'];
        $personales->talla_pantalon = $_POST['tallaPantalon'];
        $personales->promedio_nota = $_POST['promedioNota'];
        if ($personales->save()) {
            echo json_encode(1);
        } else {
            echo json_encode(2);
            echo '<pre>';
            var_dump($familiar->Errors);
            die;
        }
    }

    /**
     * FUNCION DE MUNICIPIO REQUISICION 
     */
    public function actionBuscarMunicipiosRequisicion() {
        $Id = (isset($_POST['Tblestado']['clvcodigo']) ? $_POST['Tblestado']['clvcodigo'] : $_GET['clvcodigo']);
        $Selected = isset($_GET['municipio']) ? $_GET['municipio'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.clvestado = :clvestado');
            $criteria->params = array(':clvestado' => $Id);
            $criteria->order = 't.strdescripcion ASC';

            $data = CHtml::listData(Tblmunicipio::model()->findAll($criteria), 'clvcodigo', 'strdescripcion');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            var_dump($_POST);
            exit;
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    /**
     * FUNCION DE PARROQUIA REQUISICION 
     */
    public function actionBuscarParroquiasRequisicion() {
        $Id = (isset($_POST['Tblmunicipio']['clvcodigo']) ? $_POST['Tblmunicipio']['clvcodigo'] : $_GET['municipio']);
        $Selected = isset($_GET['parroquia']) ? $_GET['parroquia'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.clvmunicipio = :clvmunicipio');
            $criteria->params = array(':clvmunicipio' => $Id);
            $criteria->order = 't.parroquia ASC';
            $data = CHtml::listData(Tblparroquia::model()->findAll('clvmunicipio=:clvmunicipio', array(':clvmunicipio' => $Id)), 'clvcodigo', 'strdescripcion');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

    public function actionSearch($name, $email) {
        $model = DynamicModel::validateData(compact('name', 'email'), [
                    [['name', 'email'], 'string', 'max' => 128],
                    ['email', 'email'],
        ]);

        if ($model->hasErrors()) {
            // validation fails
        } else {
            // validation succeeds
        }
    }

    public function actionGuardarDatosRequisicion() {


        $model = new DatosRequisicion;

        $model->fk_tipo_requisicion = $_POST['tipo_requisicion'];
        $model->anio_requisicion = $_POST['anio'];
        $model->fk_unidad_ejecutora = $_POST['unidad'];
        $model->ubicacion_geografica = $_POST['ubicacion'];
        $model->fk_parroquia = $_POST['parroquia'];
        $model->ciudad = $_POST['ciudad'];
        $model->fk_estatus = 1;
        $model->created_by = Yii::app()->user->id;
        ;
        $model->created_date = 'now()';
        $model->modified_date = 'now()';
        if ($model->save()) {
            echo json_encode(1);
        } else {
            echo json_encode(2);
            echo '<pre>';
            var_dump($model->Errors);
            die;
        }
    }

    ////////////////////////////////////////////////////////////////
    /////////////////     EVALUACION       /////////////////////////
    ////////////////////////////////////////////////////////////////
    public function actionDibujarObjetivo() {
//        echo 'sdfhghsdg'; die;
        $baseUrl = Yii::app()->baseUrl;
        $preind = new PreguntasIndividuales;


        $preind->fk_evaluacion = $_POST['idEvaluacion'];
        $preind->objetivo = $_POST['objetivo'];
        $preind->peso = (int) $_POST['peso'];
        $preind->fk_rango = 1;
        $preind->subtotal_peso = 1;
        $preind->es_activo = true;
        $preind->fk_estatus = 37; //estats del registro padre 36 de la tabla maestro
        $preind->created_date = 'now()';
        $preind->created_by = Yii::app()->user->id;
        $preind->modified_date = 'now()';
        $preind->modified_by = Yii::app()->user->id;

//        var_dump ($preind);die;
        if ($preind->save()) {
            $id_preguntas_ind = $preind->id_preguntas_ind;
//               $this->loadModel($id)->delete();
            $html = '<tr>';

            $html .= ' <td style="text-align: center">' . $_POST['objetivo'] . '</td>';
            $html .= ' <td style="text-align: center">' . $_POST['peso'] . '</td>';
            $html .= '<td style="text-align: center"><img src="' . $baseUrl . '/img/bmenoo.png" onclick="eliminar_obj(this,' . $id_preguntas_ind . ',' . $_POST['peso'] . ')" /></td></tr>';
        } else {
//         $tabla = array('html' => $html);
            echo '<pre>';
            var_dump($preind->Errors);
            die;
        }
        $tabla = array('html' => $html);
        echo json_encode($tabla);
    }

    public function actionEliminarObjetivo() {
//        var_dump ($_POST);die;
        $preind = new PreguntasIndividuales;

        $sql = "DELETE FROM evaluacion.preguntas_individuales WHERE id_preguntas_ind=" . $_POST['id'];
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

    public function actionEditarObjetivos() {
        $preind = PreguntasIndividuales::model()->findByPk($_POST['id_peso']);
        $preind->fk_rango = $_POST['rango'];
        $preind->subtotal_peso = $_POST['subPeso'];
        if ($preind->save()) {
            echo json_encode(1);
        } else {
            echo json_encode(2);
        }
//        var_dump($_POST['rango']);
//        var_dump($_POST['subPeso']);
    }

    public function actionEditarEvaluacion() {
//         var_dump($_POST['id_evaluacion']);


        $eva = Evaluacion::model()->findByPk($_POST['id_evaluacion']);
        $eva->total_b = $_POST['total_subpeso'];
        if ($eva->save()) {
            echo json_encode(1);
        } else {
            echo json_encode(2);
        }
    }
    
    ////////////////////////////////////////////////////////////////
    /////////////////     PROYECTOS       /////////////////////////
    ////////////////////////////////////////////////////////////////
    
    public function actionDibujarActividad() {
        $actividad = new Actividades;

//        var_dump($_POST);die;
        $actividad->actividad = $_POST['actividad'];
        $actividad->fk_unidad_medida = $_POST['fk_unidad_medida'];
        $actividad->cantidad = $_POST['cantidad'];
        $actividad->fk_accion = $_POST['fk_accion'];
        $actividad->fk_status = 15;
        $actividad->created_date = 'now()';
        $actividad->created_by = Yii::app()->user->id;
        $actividad->modified_date = 'now()';
        $actividad->modified_by = Yii::app()->user->id;

        if ($actividad->save()) {
            $id_actividad = $actividad->id_actividades;
            $unidad_medida = MaestroPoa::model()->findByPk($_POST['fk_unidad_medida']);
            $html = '<tr>';
            $html .= '<td style="text-align: center">' . $_POST['actividad'] . '</td>';
            $html .= '<td style="text-align: center">' . $unidad_medida->descripcion . '</td>';
            $html .= '<td style="text-align: center">' . $_POST['cantidad'] . '</td>';
            $html .= '<td style="text-align: center"><span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-trash" onclick="eliminar_actividad(this,' . $id_actividad . ')" /></span></td></tr>';
        } else {

            echo '<pre>';
            var_dump($actividad->Errors);
            die;
            
        }
        
        $tabla = array('html' => $html, 'id_actividad' => $id_actividad);
        echo json_encode($tabla);
    }

    public function actionEliminarActividad() {

        $programacion = Rendimiento::model()->deleteAllByAttributes(array('id_entidad' => $_POST['id_actividad'], 'fk_tipo_entidad' => 74));
        if($programacion){
            $actividad = Actividades::model()->findByPk($_POST['id_actividad']);
            if ($actividad->delete()) {
                echo json_encode(1);
            } else {
                echo '<pre>Actividad';
                var_dump($actividad->Errors);
                die;
                echo json_encode(2);
            }
        } else {
            $actividad = Actividades::model()->findByPk($_POST['id_actividad']);
            if ($actividad->delete()) {
                echo json_encode(1);
            } else {
                echo '<pre>Actividad';
                var_dump($actividad->Errors);
                die;
                echo json_encode(2);
            }
        }
    }
    
    public function actionEliminarAccion() {
        $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $_POST['id_accion']));
//        var_dump($actividades);die;
        if($actividades){
            $i=0;
            foreach($actividades as $data){
                $programacion_act = Rendimiento::model()->deleteAllByAttributes(array('id_entidad' => $data['id_actividades'], 'fk_tipo_entidad' => 74));
                if($programacion_act){
                    $actividad = Actividades::model()->findByPk($data['id_actividades']);
                    if ($actividad->delete()) {
                        $i++;
                    } else {
                        echo '<pre>Actividad';
                        var_dump($actividad->Errors);
                        die;
                    }
                    
                } else {
                    $actividad = Actividades::model()->findByPk($data['id_actividades']);
                    if ($actividad->delete()) {
                        $i++;
                    } else {
                        echo '<pre>Actividad';
                        var_dump($actividad->Errors);
                        die;
                    }
                }
            }

            if($i == count($actividades)){
                $programacion_acc = Rendimiento::model()->deleteAllByAttributes(array('id_entidad' => $_POST['id_accion'], 'fk_tipo_entidad' => 73));
                if($programacion_acc){
                    $accion = Acciones::model()->findByPk($_POST['id_accion']);
                    if ($accion->delete()) {
                        echo json_encode(1);
                    } else {
                        echo '<pre>Accion';
                        var_dump($accion->Errors);
                        die;
                    }
                } else {
                    $accion = Acciones::model()->findByPk($_POST['id_accion']);
                    if ($accion->delete()) {
                        echo json_encode(1);
                    } else {
                        echo '<pre>Accion';
                        var_dump($accion->Errors);
                        die;
                    }
                }
            } else {
                echo json_encode(2);
            }
        }else{
            $programacion_acc = Rendimiento::model()->deleteAllByAttributes(array('id_entidad' => $_POST['id_accion'], 'fk_tipo_entidad' => 73));
            if ($programacion_acc) {
                $accion = Acciones::model()->findByPk($_POST['id_accion']);
                if ($accion->delete()) {
                    echo json_encode(1);
                } else {
                    echo '<pre>Accion';
                    var_dump($accion->Errors);
                    die;
                }
            } else {
                $accion = Acciones::model()->findByPk($_POST['id_accion']);
                if ($accion->delete()) {
                    echo json_encode(1);
                } else {
                    echo '<pre>Accion';
                    var_dump($accion->Errors);
                    die;
                }
            }
        }
//        if($programacion){
//            $actividad = Actividades::model()->findByPk($_POST['id_actividad']);
//            if ($actividad->delete()) {
//                echo json_encode(1);
//            } else {
//                echo '<pre>Actividad';
//                var_dump($actividad->Errors);
//                die;
//                echo json_encode(2);
//            }
//        }else {
//            echo json_encode(2);
//        }
    }

    public function actionGuardarProgramadoActividad() {
        $programacion = new Rendimiento;
        $programacion->fk_meses = $_POST['fk_mes'];
        $programacion->cantidad_programada = $_POST['programacion'];
        $programacion->fk_tipo_entidad = 74;
        $programacion->id_entidad = $_POST['id_actividad'];
        $programacion->fk_status = 27;
        $programacion->created_by = Yii::app()->user->id;
        $programacion->created_date = 'now()';
        $programacion->modified_date = 'now()';
        if($programacion->save()){
            echo json_encode(1);
        } else {
            echo '<pre>';
            var_dump($programacion->Errors);
            die;
            echo json_encode(2);
        }
    }
    
    public function actionBuscarTiempoMedida() {
//        var_dump('$_POST');die;
        $Id = (isset($_POST['MaestroPoa']['id_maestro']) ? $_POST['MaestroPoa']['id_maestro'] : $_GET['MaestroPoa']['id_maestro']);

        $Selected = isset($_GET['id_maestro']) ? $_GET['id_maestro'] : '';
        if (!empty($Id)) {
            $criteria = new CDbCriteria;
            $criteria->addCondition('t.padre = :padre');
            $criteria->params = array(':padre' => $Id);
            $criteria->order = 't.id_maestro ASC';

            $data = CHtml::listData(MaestroPoa::model()->findAll($criteria), 'id_maestro', 'descripcion');
            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
            foreach ($data as $id => $value) {
                if ($Selected == $id) {
                    echo CHtml::tag('option', array('value' => $id, 'selected' => true), CHtml::encode($value), true);
                } else {
                    echo CHtml::tag('option', array('value' => $id), CHtml::encode($value), true);
                }
            }
        } else {

            echo CHtml::tag('option', array('value' => ''), CHtml::encode('SELECCIONE'), true);
        }
    }

}
