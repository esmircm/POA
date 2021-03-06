<?php

class PoaController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
public $layout='//layouts/column2';

/**
* @return array action filters
*/
public function filters()
{
return array(
'accessControl', // perform access control for CRUD operations
);
}

/**
* Specifies the access control rules.
* This method is used by the 'accessControl' filter.
* @return array access control rules
*/
public function accessRules()
{
return array(
array('allow',  // allow all users to perform 'index' and 'view' actions
'actions'=>array('index' ,'view', 'admin', 'Create_Accion', 'Create_Actividad', 'Create_Poa', 'View_Accion', 'View_Evaluar', 'Rendimiento', 'RendimientoUpdate', 'ActualizarCantidadCumplida', 'PDFpoa', 'PDFaccion', 'Create_Medida', 'DeleteMedida', 'vista_reporte'),
'users'=>array('*'),
),
array('allow', // allow authenticated user to perform 'create' and 'update' actions
'actions'=>array('create','update'),
'users'=>array('@'),
),
array('allow', // allow admin user to perform 'admin' and 'delete' actions
'actions'=>array('admin','delete'),
'users'=>array('admin'),
),
array('deny',  // deny all users
'users'=>array('*'),
),
);
}

/**
* Displays a particular model.
* @param integer $id the ID of the model to be displayed
*/
public function actionView($id_poa)
{
//    var_dump($id_poa);die;
    $model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
    $accion = new Acciones;
    
    if(isset($_POST['VswPoa'])){
        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        
        $estatus_poa = new EstatusPoa;
        $estatus_poa->fk_estatus_poa = 51;
        $estatus_poa->fk_poa = $id_poa;
        $estatus_poa->fk_status = 21;
        $estatus_poa->created_date = 'now()';
        $estatus_poa->created_by = Yii::app()->user->id;
        $estatus_poa->modified_date = 'now()';
        if ($fieldvalue->value == 7 || $fieldvalue->value == 6 || $fieldvalue->value == 3) {
            $entidad = 8;
        } else {
            $entidad = 9;
        }
        $estatus_poa->fk_tipo_entidad = $entidad;
        if ($estatus_poa->save()) {
            $this->redirect(array('index'));
        } else {
            echo "<pre>";
            var_dump($estatus_poa->Errors);
            exit;
        }
    }
    
    $this->render('view',array(
        'model'=>$model,
        'id_poa' => $id_poa,
        'accion' => $accion,
    ));
}

public function actionView_Accion(){
    $actividad = new VswActividades('search');
//    var_dump(Yii::app()->getRequest()->getParam('id'));die;
     $this->renderPartial('_view_accion', array(
        'id_accion' => Yii::app()->getRequest()->getParam('id'),
        'gridDataProvider' => $actividad,
//        'gridColumns' => $this->getGridColumns()
    ));
}

public function actionView_Evaluar($id_poa) {
        $model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $accion = new Acciones;
        $comentarios = new Comentarios;
        $estatus_poa = new EstatusPoa;

        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $idP = $row[0]["id_persona"];
        $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));

        if (isset($_POST['EstatusPoa']) && isset($_POST['Comentarios'])) {
            $estatus_poa = new EstatusPoa;
            $estatus_poa->fk_estatus_poa = $_POST['EstatusPoa']['fk_estatus_poa'];
            $estatus_poa->fk_poa = $id_poa;
            $estatus_poa->fk_status = 21;
            $estatus_poa->created_date = 'now()';
            $estatus_poa->created_by = Yii::app()->user->id;
            $estatus_poa->modified_date = 'now()';
            if ($fieldvalue->value == 5 || $fieldvalue->value == 4 || $fieldvalue->value == 2) {
                $entidad = 9;
            } else {
                $entidad = 10;
            }
            $estatus_poa->fk_tipo_entidad = $entidad;
            if ($estatus_poa->save()) {
                $comentarios = new Comentarios;
                $comentarios->comentarios = $_POST['Comentarios']['comentarios'];
                $comentarios->fk_poa = $id_poa;
                $comentarios->fk_status = 18;
                $comentarios->created_date = 'now()';
                $comentarios->created_by = Yii::app()->user->id;
                $comentarios->modified_date = 'now()';
                $comentarios->fk_tipo_entidad = $entidad;
                if($comentarios->save()){
                    if(Yii::app()->user->checkAccess('administrador_poa')){
                        $this->redirect(array('index'));
                    }
                    if(Yii::app()->user->checkAccess('evaluador_poa')){
                        $this->redirect(array('admin'));
                    }
                } else {
                    echo "<pre>Comentarios";
                    var_dump($comentarios->Errors);
                    exit;
                }
            } else {
                echo "<pre>";
                var_dump($estatus_poa->Errors);
                exit;
            }
        }

        $this->render('view_evaluar', array(
            'model' => $model,
            'id_poa' => $id_poa,
            'accion' => $accion,
            'comentarios' => $comentarios,
            'estatus_poa' => $estatus_poa,
        ));
    }

public function actionView_Programacion($fk_poa) {
        $model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $accion = VswAcciones::model()->findByPk($fk_poa);
        $view_programa = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $fk_poa));

        $this->render('view_programacion', array(
            'model' => $model,
            'accion' => $accion,
            'view_programa' => $view_programa,
        ));
    }

    /**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionCreate($tipo) {
        $model= new VswPersonal;
        $poa = new Poa;
        $maestro = new MaestroPoa;
        
        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $idP = $row[0]["id_persona"];
        
        //Consulta de la Dependencia segun el Cruge
        $field = CrugeField::model()->findByAttributes(array('idfield' => 1));
        $arOpt = CrugeUtil::explodeOptions($field->predetvalue);
                     
        $responsable = VswPersonal::model()->findByAttributes(array('id_persona' => $idP));
        $model->dependencia = $responsable['dependencia'];
        $model->nombres = $responsable['nombres'];
        $model->apellidos = $responsable['apellidos'];
        $model->nacionalidad = $responsable['nacionalidad'];
        $model->cedula = $responsable['cedula'];
        $model->descripcion_cargo = $responsable['descripcion_cargo'];
        
        $cruge_dependencia = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 1));
        $criteria=new CDbCriteria;
        $criteria->select='MIN(cargo) AS cargo';
        $criteria->condition = 'dependencia = :dependencia';
        $criteria->params = array(':dependencia' => $cruge_dependencia->value);
        $crugefield_director = VswCrugeFieldvalues::model()->find($criteria);
//        var_dump($crugefield_director->cargo);die;
        $idUser_director = VswCrugeFieldvalues::model()->findByAttributes(array('cargo' => $crugefield_director->cargo, 'dependencia' => $cruge_dependencia->value));
        $cruge_director = CrugeStoredUser::model()->findByPk($idUser_director->iduser);
//        $cruge_director = CrugeFieldValue::model()->findBySql("SELECT iduser FROM cruge_fieldvalue WHERE value = '" . 5 . "' OR value = '" . $cruge_dependencia->value . "' GROUP BY iduser having count(iduser) >= 2");

//        $sql_director = "select iduser, id_persona from cruge_user where iduser =" . $cruge_director->iduser;
//        $connection_director = Yii::app()->db;
//        $command_director = $connection_director->createCommand($sql_director);
//        $row_director = $command_director->queryAll();
//        $idUser_director = $row_director[0]["iduser"];
//        $idP_director = $row_director[0]["id_persona"];
        
        $model_dir = new VswPersonal;
        $responsable_dir = VswPersonal::model()->findByAttributes(array('id_persona' => $cruge_director->id_persona));
        $model_dir->dependencia = $responsable_dir['dependencia'];
        $model_dir->nombres = $responsable_dir['nombres'];
        $model_dir->apellidos = $responsable_dir['apellidos'];
        $model_dir->nacionalidad = $responsable_dir['nacionalidad'];
        $model_dir->cedula = $responsable_dir['cedula'];
        $model_dir->descripcion_cargo = $responsable_dir['descripcion_cargo'];

        if ($tipo == 70) {
            $tipo_poa = MaestroPoa::model()->findByPk(70);
        } else {
            $tipo_poa = MaestroPoa::model()->findByPk(71);
        }
        
        $criteria=new CDbCriteria;
        $criteria->order='id_poa DESC';
        $verificacion_acc = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 71), $criteria);
        if($verificacion_acc) {
            $anio_acc = $verificacion_acc->anio + 1; 
        } else {
            $anio_acc = date('Y');
        }
        
        $verificacion_pro = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 70), $criteria);
        if($verificacion_pro){
            $anio_pro = $verificacion_pro->anio + 1; 
        } else {
             $anio_pro = date('Y');
        }

        if (isset($_POST['VswPersonal']) && isset($_POST['Poa'])) {
//            var_dump($_POST);die;
            $poa = new Poa;
            $poa->nombre = $_POST['Poa']['nombre'];
            $poa->descripcion = $_POST['Poa']['descripcion'];
            $poa->created_by = Yii::app()->user->id;
            $poa->fk_status = 24;
            $poa->created_date = 'now()';
            $poa->modified_date = 'now()';
            if($tipo == 70){
                $tipo_poa = 70;
                $poa->fecha_inicio = $_POST['Poa']['fecha_inicio'];
                $poa->fecha_final = $_POST['Poa']['fecha_final'];
                $poa->fk_historico = $_POST['Poa']['fk_historico'];
                $poa->fk_nacional = $_POST['Poa']['fk_nacional'];
                $poa->fk_estrategico = $_POST['Poa']['fk_estrategico'];
                $poa->fk_general = $_POST['Poa']['fk_general'];
                $poa->fk_estrategico_mr = $_POST['Poa']['fk_estrategico_mr'];
                $poa->fk_institucional = $_POST['Poa']['fk_institucional'];
                $poa->fk_unidad_medida = $_POST['Poa']['fk_unidad_medida'];
                $poa->cantidad = $_POST['Poa']['cantidad'];
            }else{
                $tipo_poa = 71;
                $poa->fecha_inicio = $anio_acc . '-01-01';
                $poa->fecha_final = $anio_acc . '-12-31';
            }
            $poa->fk_tipo_poa = $tipo_poa;
                
            if($poa->save()){
                $id_Poa = $poa->id_poa;
                $responsable = new Responsable;
                $responsable->fk_dir_responsable = $idUser_director->iduser;
                $responsable->fk_persona_registro = $idUser;
                $responsable->fk_poa = $id_Poa;
                $responsable->created_by = Yii::app()->user->id;
                $responsable->fk_estatus = 30; 
                $responsable->created_date = 'now()';
                $responsable->modified_date = 'now()';
                $responsable->cod_dependencia_cruge = $cruge_dependencia->value;
                $responsable->dependencia_cruge = $arOpt[$cruge_dependencia->value];
                if($responsable->save()){
                    $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        
                    $estatus_poa = new EstatusPoa;
                    $estatus_poa->fk_estatus_poa = 50;
                    $estatus_poa->fk_poa = $id_Poa;
                    $estatus_poa->fk_status = 21;
                    $estatus_poa->created_date = 'now()';
                    $estatus_poa->created_by = Yii::app()->user->id;
                    $estatus_poa->modified_date = 'now()';
                    if ($fieldvalue->value == 7 || $fieldvalue->value == 6 || $fieldvalue->value == 3) {
                        $entidad = 8;
                    } else {
                        $entidad = 9;
                    }
                    $estatus_poa->fk_tipo_entidad = $entidad;
                    if ($estatus_poa->save()) {
//                      $poa = new Poa;
                        $this->redirect(array('create_accion', 'id_poa' => $id_Poa, 'tipo' => $tipo));
                    } else {
                        echo "<pre>";
                        var_dump($estatus_poa->Errors);
                        exit;
                    }
                } else {
                    echo "<pre>Responsable";
                    var_dump($responsable->Errors);
                    exit;
                }
            } else {
                
                echo "<pre>Poa";
                var_dump($poa->Errors);
                exit;
                    
            }
        }

        $this->render('create', array(
            'model' => $model,
            'model_dir' => $model_dir,
            'poa' => $poa,
            'tipo_poa' => $tipo_poa,
            'anio_pro' => $anio_pro,
            'maestro' => $maestro,
   
        ));
    }
    
    public function actionCreate_Accion($id_poa, $tipo) {
                
        $accion = new Acciones;
        $poa = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $programacion = new Rendimiento;
        
        $lista_accion = VswAcciones::model()->findAllByAttributes(array('fk_poa' => $id_poa));

        if($tipo == 70){
            $tipo_poa = MaestroPoa::model()->findByPk(70);
        } else {
            $tipo_poa = MaestroPoa::model()->findByPk(71);
        }
//        var_dump($_POST);die;
        if(isset($_POST['Acciones']) && isset($_POST['Rendimiento']) && empty($_POST['update_accion'])){
//            var_dump($_POST['Rendimiento']);die;
            $accion->nombre_accion = $_POST['Acciones']['nombre_accion'];
            $accion->bien_servicio = $_POST['Acciones']['bien_servicio'];
            $accion->fk_unidad_medida = $_POST['Acciones']['fk_unidad_medida'];
            $accion->fk_ambito = $_POST['Acciones']['fk_ambito'];
            $accion->fk_poa = $_POST['Acciones']['fk_poa'];
            $accion->cantidad = $_POST['Acciones']['cantidad'];
            $accion->fk_status = 12;
            $accion->created_date = 'now()';
            $accion->created_by = Yii::app()->user->id;
            $accion->modified_date = 'now()';
//            $accion->modified_by = Yii::app()->user->id;

            if ($accion->save()) {
                
                    $o = 0;
                    $i = 57; //Enero en Maestro
                    foreach($_POST['Rendimiento'] as $data){
                        $programacion = new Rendimiento;
                        $programacion->fk_meses = $i;
                        if(empty($data)){
                            $programacion->cantidad_programada = 0;
                        }else{
                            $programacion->cantidad_programada = $data;
                        }
                        $programacion->fk_tipo_entidad = 73;
                        $programacion->id_entidad = $accion->id_accion;
                        $programacion->fk_status = 27;
                        $programacion->created_by = Yii::app()->user->id;
                        $programacion->created_date = 'now()';
                        $programacion->modified_date = 'now()';
                        if($programacion->save()){
                            $o++;
                        } else {
                            echo "<pre>Programacion";
                            var_dump($programacion->Errors);
                            exit;
                        }
                        $i++;
                        
                    }
                    if($o == count($_POST['Rendimiento'])){
                        $this->redirect(array('create_actividad', 'id_poa' => $_POST['Acciones']['fk_poa'], 'id_accion' => $accion->id_accion, 'tipo' => $tipo));
                    }
                
            }else{
                echo "<pre>Accion";
                var_dump($accion->Errors);
                exit;  
            }
        }
        
        if(isset($_POST['Acciones']) && isset($_POST['Rendimiento']) && !empty($_POST['update_accion'])){
            $accion = Acciones::model()->findByPk($_POST['update_accion']);
            $accion->nombre_accion = $_POST['Acciones']['nombre_accion'];
            $accion->bien_servicio = $_POST['Acciones']['bien_servicio'];
            $accion->fk_unidad_medida = $_POST['Acciones']['fk_unidad_medida'];
            $accion->fk_ambito = $_POST['Acciones']['fk_ambito'];
            $accion->cantidad = $_POST['Acciones']['cantidad'];
            $accion->modified_date = 'now()';
            $accion->modified_by = Yii::app()->user->id;

            if ($accion->save()) {
                
                    $o = 0;
                    $i = 57; //Enero en Maestro
                    foreach($_POST['Rendimiento'] as $data){
                        $programacion = Rendimiento::model()->findByAttributes(array('id_entidad' => $_POST['update_accion'], 'fk_tipo_entidad' => 73, 'fk_meses' => $i, 'es_activo' => TRUE));
                        if(empty($data)){
                            $programacion->cantidad_programada = 0;
                        }else{
                            $programacion->cantidad_programada = $data;
                        }
                        $programacion->modified_date = 'now()';
                        $programacion->modified_by = Yii::app()->user->id;
                        if($programacion->save()){
                            $o++;
                        } else {
                            echo "<pre>Programacion";
                            var_dump($programacion->Errors);
                            exit;
                        }
                        $i++;
                        
                    }
                    if($o == count($_POST['Rendimiento'])){
                        $this->redirect(array('create_accion', 'id_poa' => $_POST['Acciones']['fk_poa'], 'tipo' => $tipo));

                    }
                
            }else{
                echo "<pre>Accion";
                var_dump($accion->Errors);
                exit;  
            }
        }

        
        $this->render('create_accion', array(
            'accion' => $accion,
            'id_poa' => $id_poa,
            'lista_accion' => $lista_accion,
            'poa' => $poa,
            'tipo_poa' => $tipo_poa, 
            'tipo' => $tipo,
            'programacion' => $programacion,
        ));
    }
    
    public function actionCreate_Actividad($id_poa, $id_accion, $tipo) {
        $actividad = new Actividades;
        $lista_actividad = VswActividades::model()->findAllByAttributes(array('fk_accion' => $id_accion));
        $poa = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $accion = VswAcciones::model()->findByAttributes(array('id_accion' => $id_accion));
        $programacion = new Rendimiento;
        
        $criteria=new CDbCriteria;
        $criteria->order='fk_meses';
        $programacion_accion = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $id_accion, 'fk_tipo_entidad' => 73), $criteria);

        
        $this->render('create_actividad', array(
            'actividad' => $actividad,
            'id_accion' => $id_accion,
            'id_poa' => $id_poa,
            'lista_actividad' => $lista_actividad,
            'poa' => $poa,
            'accion' => $accion,
            'tipo' => $tipo,
            'programacion' => $programacion,
            'programacion_accion' => $programacion_accion,
        ));
    }

    /**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
public function actionUpdate($id_poa, $tipo) {
        $model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $maestro = new MaestroPoa;

        if (isset($_POST['VswPoa'])) {
            $poa = Poa::model()->findByPk($id_poa);
            $poa->nombre = $_POST['VswPoa']['nombre'];
            $poa->modified_by = Yii::app()->user->id;
            $poa->fk_status = 24;
            $poa->modified_date = 'now()';
            $poa->descripcion = $_POST['VswPoa']['descripcion'];
            if ($tipo == 70) {
                $poa->fecha_inicio = $_POST['VswPoa']['fecha_inicio'];
                $poa->fecha_final = $_POST['VswPoa']['fecha_final'];
                $poa->fk_historico = $_POST['VswPoa']['fk_historico'];
                $poa->fk_nacional = $_POST['VswPoa']['fk_nacional'];
                $poa->fk_estrategico = $_POST['VswPoa']['fk_estrategico'];
                $poa->fk_general = $_POST['VswPoa']['fk_general'];
                $poa->fk_estrategico_mr = $_POST['VswPoa']['fk_estrategico_mr'];
                $poa->fk_institucional = $_POST['VswPoa']['fk_institucional'];
                $poa->fk_unidad_medida = $_POST['VswPoa']['fk_unidad_medida'];
                $poa->cantidad = $_POST['VswPoa']['cantidad'];
            } else {
                $poa->fecha_inicio = $model->anio . '-01-01';
                $poa->fecha_final = $model->anio . '-12-31';
            }

            if ($poa->save()) {
                $this->redirect(array('create_accion', 'id_poa' => $id_poa, 'tipo' => $tipo));
            } else {
                echo "<pre>Poa";
                var_dump($poa->Errors);
                exit;
            }
        }

        $this->render('update', array(
            'model' => $model,
            'maestro' => $maestro,
        ));
    }

    /**
* Deletes a particular model.
* If deletion is successful, the browser will be redirected to the 'admin' page.
* @param integer $id the ID of the model to be deleted
*/
public function actionDelete($id)
{
if(Yii::app()->request->isPostRequest)
{
// we only allow deletion via POST request
$this->loadModel($id)->delete();

// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
if(!isset($_GET['ajax']))
$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
}
else
throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
}

public function actionDeleteMedida($id_maestro) {
        $maestro = new MaestroPoa('search');

        //Función que imprime la Busqueda del jQuery
        if (isset($_GET['MaestroPoa'])) {
            $maestro->attributes = $_GET['MaestroPoa'];
        }

        $maestroPoa = MaestroPoa::model()->findByPk($id_maestro);
        $maestroPoa->es_activo = FALSE;
        $maestroPoa->modified_by = Yii::app()->user->id;
        $maestroPoa->modified_date = 'now()';
        if ($maestroPoa->save()) {
            $this->redirect(array('create_medida'));
        } else {
            echo "<pre>Maestro";
            var_dump($maestroPoa->Errors);
            exit;
        }
    }

    /**
* Lists all models.
*/
public function actionIndex() {
        $admin = new VswAdmin('search');
        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $idPersona = $row[0]["id_persona"];
        $cruge_dependencia = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 1));
        $cruge_cargo = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        $field = CrugeField::model()->findByAttributes(array('idfield' => 1));
        $arOpt = CrugeUtil::explodeOptions($field->predetvalue);
        $dependencia = $arOpt[$cruge_dependencia->value];
        
        $criteria=new CDbCriteria;
        $criteria->order='id_poa DESC';

        $verificacion_acc = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 71), $criteria);
        if($verificacion_acc) {
            $anio_acc = array($verificacion_acc->anio, $verificacion_acc->anio + 1); 
        } else {
            $anio_acc = array(date('Y'), date('Y'));
        }
        
        $verificacion_pro = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 70), $criteria);
        if($verificacion_pro){
            $anio_pro = array($verificacion_pro->anio, $verificacion_pro->anio + 1); 
        } else {
             $anio_pro = array(date('Y'), date('Y'));
        }
        
        if ($cruge_dependencia->value >= 17 && $cruge_dependencia->value <= 20) {
            $tipo_poa = MaestroPoa::model()->findByPk(70);
        } else {
            $tipo_poa = MaestroPoa::model()->findByPk(71);
        }

        $this->render('index', array(
            'admin' => $admin,
            'dependencia' => $dependencia,
            'cruge_dependencia' => $cruge_dependencia,
            'cruge_cargo' => $cruge_cargo,
            'tipo_poa' => $tipo_poa,
            'anio_acc' => $anio_acc,
            'anio_pro' => $anio_pro,
        ));
    }

    /**
* Manages all models.
*/
public function actionAdmin()
{
$admin = new VswAdmin('search');
    $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
    $connection = Yii::app()->db;
    $command = $connection->createCommand($sql);
    $row = $command->queryAll();
    $idUser = $row[0]["iduser"];
    $idPersona = $row[0]["id_persona"];
    $dependencia = VswPersonal::model()->findByAttributes(array('id_persona' => $idPersona));
    $cruge_dependencia = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 1));
    $cruge_cargo = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));

//    $admin=new CActiveDataProvider('VswAdmin');
    $this->render('admin',array(
        'admin'=>$admin,
        'dependencia' => $dependencia,
        'cruge_dependencia' => $cruge_dependencia,
        'cruge_cargo' => $cruge_cargo,
    ));
}

public function actionCreate_Medida(){
    $maestro = new MaestroPoa('search');
    
    //Función que imprime la Busqueda del jQuery
    if (isset($_GET['MaestroPoa'])) {
        $maestro->attributes = $_GET['MaestroPoa'];
    }
    
    if(isset($_POST['MaestroPoa'])){
        $descripcion = mb_strtoupper($_POST['MaestroPoa']['descripcion']);
        $descripcion = trim($descripcion);
        
        $verificar = MaestroPoa::model()->findAllBySql("SELECT * FROM poa.maestro WHERE descripcion = '" . $descripcion . "' AND es_activo = TRUE");
        if($verificar){
            //Validación si existe ya la Unidad de Medida
            $this->render('create_medida',array(
                'respuesta' => 2,
                'maestro'=>$maestro,
            ));
        }else{
            //Si no existe se realiza el Guardado
            $maestroPoa = new MaestroPoa;
            $maestroPoa->descripcion = $descripcion;
            $maestroPoa->padre = 35;
            $maestroPoa->hijo = 0;
            $maestroPoa->created_by = Yii::app()->user->id;
            $maestroPoa->created_date = 'now()';
            $maestroPoa->modified_date = 'now()';
            if($maestroPoa->save()){
                $this->render('create_medida',array(
                    'respuesta' => 1,
                    'maestro'=>$maestro,
                ));
            } else {
                echo "<pre>Maestro";
                var_dump($maestroPoa->Errors);
                exit;
            }
        }
    }
    
    $this->render('create_medida',array(
        'maestro'=>$maestro,
    ));
}

/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=Poa::model()->findByPk($id);
if($model===null)
throw new CHttpException(404,'The requested page does not exist.');
return $model;
}

public function actionPDFpoa($id_poa) {

 
        $vswpdfproyecto = VswPdfProyecto::model()->findByAttributes(array('id_poa' => $id_poa));
        $vswaccion = VswAcciones::model()->findAllByAttributes(array('fk_poa' => $id_poa));
        $vswactividades = VswActividades::model()->findByAttributes(array('fk_poa' => $id_poa));
        $criteria=new CDbCriteria;
        $criteria->order='id_maestro';
        $maestro = MaestroPoa::model()->findAllByAttributes(array('padre' => 56), $criteria);

        $this->render('generarpdf', array('vswpdfproyecto' => $vswpdfproyecto, 'vswaccion' => $vswaccion, 'maestro' => $maestro)); 

        
    }
    
    
public function actionPDFaccion($id_poa) {

 
        $vswpdfproyecto = VswPdfProyecto::model()->findByAttributes(array('id_poa' => $id_poa));
        $vswaccion = VswAcciones::model()->findAllByAttributes(array('fk_poa' => $id_poa));
        $vswactividades = VswActividades::model()->findByAttributes(array('fk_poa' => $id_poa));
        $criteria=new CDbCriteria;
        $criteria->order='id_maestro';
        $maestro = MaestroPoa::model()->findAllByAttributes(array('padre' => 56), $criteria);

        $this->render('pdfaccion', array('vswpdfproyecto' => $vswpdfproyecto, 'vswaccion' => $vswaccion, 'maestro' => $maestro)); 

        
    }
/**
* Performs the AJAX validation.
* @param CModel the model to be validated
*/
protected function performAjaxValidation($model)
{
if(isset($_POST['ajax']) && $_POST['ajax']==='poa-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}

public function actionRendimiento($id_poa) {
        $model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        $acciones = new Acciones;
       
        if (isset($_POST['Cumplido']) && isset($_POST['Accion'])) {
//            var_dump($_POST);die;
            $o = 0;
            $i = 57; //Enero en Maestro
            foreach ($_POST['Cumplido'] as $data) {
                $programacion = Rendimiento::model()->findByAttributes(array('id_entidad' => $_POST['Accion'], 'fk_tipo_entidad' => 73, 'fk_meses' => $i, 'es_activo' => TRUE));
                $programacion->cantidad_cumplida = $data;
                $programacion->modified_date = 'now()';
                $programacion->modified_by = Yii::app()->user->id;
                if ($programacion->save()) {
                    $o++;
                } else {
                    echo "<pre>Programacion";
                    var_dump($programacion->Errors);
                    exit;
                }
                $i++;
            }
            
            if($o == count($_POST['Cumplido'])){
                $this->redirect(array('Rendimiento', 'id_poa' => $id_poa, 'id_accion' => $_POST['Accion'], 'ver_actividad' => 1));
            }
        }
        
        if (isset($_POST['Cumplido']) && isset($_POST['Actividad'])) {
//            var_dump($_POST);die;
            $o = 0;
            $i = 57; //Enero en Maestro
            foreach ($_POST['Cumplido'] as $data) {
                $programacion = Rendimiento::model()->findByAttributes(array('id_entidad' => $_POST['Actividad'], 'fk_tipo_entidad' => 74, 'fk_meses' => $i, 'es_activo' => TRUE));
                $programacion->cantidad_cumplida = $data;
                $programacion->modified_date = 'now()';
                $programacion->modified_by = Yii::app()->user->id;
                if ($programacion->save()) {
                    $o++;
                } else {
                    echo "<pre>Programacion";
                    var_dump($programacion->Errors);
                    exit;
                }
                $i++;
            }
            
            if($o == count($_POST['Cumplido'])){
                $this->redirect(array('Rendimiento', 'id_poa' => $id_poa, 'id_accion' => $_GET['id_accion'], 'ver_actividad' => 1));
            }
            
        }
        
        if (isset($_GET['rendimiento_accion'])) {
            $rendimiento = new Rendimiento;
            $accion = VswAcciones::model()->findByAttributes(array('id_accion' => $_GET['id_accion']));
            $criteria=new CDbCriteria;
            $criteria->order='fk_meses';
            $rendimiento_entidad = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $_GET['id_accion'], 'fk_tipo_entidad' => 73, 'es_activo' => TRUE), $criteria);
            
//            var_dump($accion);die;
            $this->render('rendimiento_create', array(
                'model' => $model,
                'id_poa' => $id_poa,
                'acciones' => $acciones,
                'entidad' => $accion,
                'rendimiento' => $rendimiento,
                'rendimiento_entidad' => $rendimiento_entidad,
            ));
        }
        
        if (isset($_GET['ver_actividad'])) {
            $actividades = new VswActividades;
            
            if(isset($_GET['id_actividad'])){
                $rendimiento = new Rendimiento;
                $actividad = VswActividades::model()->findByAttributes(array('id_actividades' => $_GET['id_actividad']));
                $criteria=new CDbCriteria;
                $criteria->order='fk_meses';
                $rendimiento_entidad = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $_GET['id_actividad'], 'fk_tipo_entidad' => 74, 'es_activo' => TRUE), $criteria);

//                var_dump($_GET['id_poa']);die;
                $this->render('rendimiento_create', array(
                    'model' => $model,
                    'id_poa' => $id_poa,
                    'acciones' => $acciones,
                    'actividades' => $actividades,
                    'entidad' => $actividad,
                    'rendimiento' => $rendimiento,
                    'rendimiento_entidad' => $rendimiento_entidad,
                ));
            }
            
            $this->render('rendimiento_create', array(
                'model' => $model,
                'id_poa' => $id_poa,
                'acciones' => $acciones,
                'actividades' => $actividades,
            ));
        }
        

        $this->render('rendimiento_create', array(
            'model' => $model,
            'id_poa' => $id_poa,
            'acciones' => $acciones,
           
        ));
    }
    
       
    public function actionActualizarCantidadCumplida() { {
            Yii :: import('booster.components.TbEditableSaver');
            $es = new TbEditableSaver('Rendimiento');

//            var_dump($es->beforeUpdate);die;
//Con onBeforeUpdate agrego los atrubitos adicionales que quiero actualizar
          
            $es->onBeforeUpdate = function ($event) {
                
                    
      
//       $can_programada = $event->sender->model->cantidad_programada;
       
//       $can_cumplida= $event->sender->model->cantidad_cumplida;

       
      
                        $event->sender->setAttribute('modified_date', date('Y-m-d H:i:s'));
                        $event->sender->setAttribute('modified_by', Yii::app()->user->id);
//                        $event->sender->setAttribute('cantidad_cumplida', $can_cumplida);
//                        $event->update();
//                return $can_programada; 

                    };
                    
                    
//                    echo onBeforeUpdate($event);

            $es->update();
        }
    }
    
    public function actionGenerarPDF ($id_poa) {
//        $poa 
        
    }
    
    public function actionvista_reporte($id_poa) {
        //$model = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
        //$accion = new Acciones;
		$model = new MaestroPoa;
		$this->render('reporte_rendimiento', array(
            'model' => $model,
            'id_poa' => $id_poa,
            //'accion' => $accion,
           
        ));
    }
}
