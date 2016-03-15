<?php

class ProyectoController extends Controller
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
'actions'=>array('index' ,'view', 'admin', 'Create_Accion', 'Create_Actividad', 'Create_Proyecto', 'View_Accion', 'View_Evaluar'),
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
public function actionView($id_proyecto)
{
//    var_dump($id_proyecto);die;
    $model = VswProyecto2::model()->findByAttributes(array('id_proyecto' => $id_proyecto));
    $accion = new Acciones;
    
    if(isset($_POST['VswProyecto2'])){
        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        
        $estatus_proyecto = new EstatusProyecto;
        $estatus_proyecto->fk_estatus_proyecto = 51;
        $estatus_proyecto->fk_proyecto = $id_proyecto;
        $estatus_proyecto->fk_status = 21;
        $estatus_proyecto->created_date = 'now()';
        $estatus_proyecto->created_by = Yii::app()->user->id;
        $estatus_proyecto->modified_date = 'now()';
        if ($fieldvalue->value == 7 || $fieldvalue->value == 6 || $fieldvalue->value == 3) {
            $entidad = 8;
        } else {
            $entidad = 9;
        }
        $estatus_proyecto->fk_tipo_entidad = $entidad;
        if ($estatus_proyecto->save()) {
            $this->redirect(array('index'));
        } else {
            echo "<pre>";
            var_dump($estatus_proyecto->Errors);
            exit;
        }
    }
    
    $this->render('view',array(
        'model'=>$model,
        'id_proyecto' => $id_proyecto,
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

public function actionView_Evaluar($id_proyecto) {
        $model = VswProyecto2::model()->findByAttributes(array('id_proyecto' => $id_proyecto));
        $accion = new Acciones;
        $comentarios = new Comentarios;
        $estatus_proyecto = new EstatusProyecto;

        $sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        $idUser = $row[0]["iduser"];
        $idP = $row[0]["id_persona"];
        $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));

        if (isset($_POST['EstatusProyecto']) && isset($_POST['Comentarios'])) {
            $estatus_proyecto = new EstatusProyecto;
            $estatus_proyecto->fk_estatus_proyecto = $_POST['EstatusProyecto']['fk_estatus_proyecto'];
            $estatus_proyecto->fk_proyecto = $id_proyecto;
            $estatus_proyecto->fk_status = 21;
            $estatus_proyecto->created_date = 'now()';
            $estatus_proyecto->created_by = Yii::app()->user->id;
            $estatus_proyecto->modified_date = 'now()';
            if ($fieldvalue->value == 5 || $fieldvalue->value == 4 || $fieldvalue->value == 2) {
                $entidad = 9;
            } else {
                $entidad = 10;
            }
            $estatus_proyecto->fk_tipo_entidad = $entidad;
            if ($estatus_proyecto->save()) {
                $comentarios = new Comentarios;
                $comentarios->comentarios = $_POST['Comentarios']['comentarios'];
                $comentarios->fk_proyecto = $id_proyecto;
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
                var_dump($estatus_proyecto->Errors);
                exit;
            }
        }

        $this->render('view_evaluar', array(
            'model' => $model,
            'id_proyecto' => $id_proyecto,
            'accion' => $accion,
            'comentarios' => $comentarios,
            'estatus_proyecto' => $estatus_proyecto,
        ));
    }

    /**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionCreate() {
        $model= new VswPersonal;
        $proyecto = new Proyecto;
        
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
        $cruge_director = CrugeFieldValue::model()->findBySql("SELECT iduser FROM cruge_fieldvalue WHERE value = '" . 5 . "' OR value = '" . $cruge_dependencia->value . "' GROUP BY iduser having count(iduser) >= 2");
//        var_dump($cruge_director->iduser);die;
        $sql_director = "select iduser, id_persona from cruge_user where iduser =" . $cruge_director->iduser;
        $connection_director = Yii::app()->db;
        $command_director = $connection_director->createCommand($sql_director);
        $row_director = $command_director->queryAll();
        $idUser_director = $row_director[0]["iduser"];
        $idP_director = $row_director[0]["id_persona"];
        
        $model_dir = new VswPersonal;
        $responsable_dir = VswPersonal::model()->findByAttributes(array('id_persona' => $idP_director));
        $model_dir->dependencia = $responsable_dir['dependencia'];
        $model_dir->nombres = $responsable_dir['nombres'];
        $model_dir->apellidos = $responsable_dir['apellidos'];
        $model_dir->nacionalidad = $responsable_dir['nacionalidad'];
        $model_dir->cedula = $responsable_dir['cedula'];
        $model_dir->descripcion_cargo = $responsable_dir['descripcion_cargo'];

// Uncomment the following line if AJAX validation is needed
// $this->performAjaxValidation($model);

        if (isset($_POST['VswPersonal']) && isset($_POST['Proyecto'])) {
//            var_dump($_POST);die;
            $proyecto = new Proyecto;
            $proyecto->nombre_proyecto = $_POST['Proyecto']['nombre_proyecto'];
            $proyecto->objetivo_general = $_POST['Proyecto']['objetivo_general'];
            $proyecto->fecha_inicio = $_POST['Proyecto']['fecha_inicio'];
            $proyecto->descripcion = $_POST['Proyecto']['descripcion'];
            $proyecto->created_by = Yii::app()->user->id;
            $proyecto->fk_status = 24;
            $proyecto->created_date = 'now()';
            $proyecto->modified_date = 'now()';
            if($proyecto->save()){
                $id_Proyecto = $proyecto->id_proyecto;
                $responsable = new Responsable;
                $responsable->fk_dir_responsable = $idUser_director;
                $responsable->fk_persona_registro = $idUser;
                $responsable->fk_proyecto = $id_Proyecto;
                $responsable->created_by = Yii::app()->user->id;
                $responsable->fk_estatus = 30; 
                $responsable->created_date = 'now()';
                $responsable->modified_date = 'now()';
                $responsable->cod_dependencia_cruge = $cruge_dependencia->value;
                $responsable->dependencia_cruge = $arOpt[$cruge_dependencia->value];
                if($responsable->save()){
                    $fieldvalue = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        
                    $estatus_proyecto = new EstatusProyecto;
                    $estatus_proyecto->fk_estatus_proyecto = 50;
                    $estatus_proyecto->fk_proyecto = $id_Proyecto;
                    $estatus_proyecto->fk_status = 21;
                    $estatus_proyecto->created_date = 'now()';
                    $estatus_proyecto->created_by = Yii::app()->user->id;
                    $estatus_proyecto->modified_date = 'now()';
                    if ($fieldvalue->value == 7 || $fieldvalue->value == 6 || $fieldvalue->value == 3) {
                        $entidad = 8;
                    } else {
                        $entidad = 9;
                    }
                    $estatus_proyecto->fk_tipo_entidad = $entidad;
                    if ($estatus_proyecto->save()) {
//                      $proyecto = new Proyecto;
                        $this->redirect(array('create_accion', 'id_proyecto' => $id_Proyecto));
                    } else {
                        echo "<pre>";
                        var_dump($estatus_proyecto->Errors);
                        exit;
                    }
                } else {
                    echo "<pre>Responsable";
                    var_dump($responsable->Errors);
                    exit;
                }
            } else {
                
                echo "<pre>Proyecto";
                var_dump($proyecto->Errors);
                exit;
                    
            }
        }

        $this->render('create', array(
            'model' => $model,
            'model_dir' => $model_dir,
            'proyecto' => $proyecto,
        ));
    }
    
    public function actionCreate_Accion($id_proyecto) {
                
        $accion = new Acciones;
        $proyecto = VswProyecto::model()->findByAttributes(array('id_proyecto' => $id_proyecto));
        
        $lista_accion = VswAcciones::model()->findAllByAttributes(array('fk_proyecto' => $id_proyecto));
//        var_dump($_POST);die;
        if(isset($_POST['Acciones'])){
            $accion->nombre_accion = $_POST['Acciones']['nombre_accion'];
            $accion->meta = $_POST['Acciones']['meta'];
            $accion->bien_servicio = $_POST['Acciones']['bien_servicio'];
            $accion->fk_unidad_medida = $_POST['Acciones']['fk_unidad_medida'];
            $accion->fk_ambito = $_POST['Acciones']['fk_ambito'];
            $accion->fk_proyecto = $_POST['Acciones']['fk_proyecto'];
            $accion->cantidad = $_POST['Acciones']['cantidad'];
            $accion->fk_status = 12;
            $accion->created_date = 'now()';
            $accion->created_by = Yii::app()->user->id;
            $accion->modified_date = 'now()';
            $accion->modified_by = Yii::app()->user->id;

            if ($accion->save()) {
                $this->redirect(array('create_actividad', 'id_proyecto' => $_POST['Acciones']['fk_proyecto'], 'id_accion' => $accion->id_accion));
            }else{
                echo "<pre>Accion";
                var_dump($accion->Errors);
                exit;  
            }
        }
        
        if(isset($_POST['VswAdmin'])){
            
        }
        
        $this->render('create_accion', array(
            'accion' => $accion,
            'id_proyecto' => $id_proyecto,
            'lista_accion' => $lista_accion,
            'proyecto' => $proyecto,
        ));
    }
    
    public function actionCreate_Actividad($id_proyecto, $id_accion) {
        $actividad = new Actividades;
        $lista_actividad = VswActividades::model()->findAllByAttributes(array('fk_accion' => $id_accion));
        $proyecto = VswProyecto::model()->findByAttributes(array('id_proyecto' => $id_proyecto));
        $accion = VswAcciones::model()->findByAttributes(array('id_accion' => $id_accion));
        
        $this->render('create_actividad', array(
            'actividad' => $actividad,
            'id_accion' => $id_accion,
            'id_proyecto' => $id_proyecto,
            'lista_actividad' => $lista_actividad,
            'proyecto' => $proyecto,
            'accion' => $accion
        ));
    }

    /**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
public function actionUpdate($id_proyecto){
$model = VswProyecto2::model()->findByAttributes(array('id_proyecto' => $id_proyecto));

if(isset($_POST['VswProyecto2'])){
    $proyecto = Proyecto::model()->findByPk($id_proyecto);
    $proyecto->nombre_proyecto = $_POST['VswProyecto2']['nombre_proyecto'];
    $proyecto->objetivo_general = $_POST['VswProyecto2']['objetivo_general'];
    $proyecto->fecha_inicio = $_POST['VswProyecto2']['fecha_inicio'];
    $proyecto->descripcion = $_POST['VswProyecto2']['descripcion'];
    $proyecto->created_by = Yii::app()->user->id;
    $proyecto->fk_status = 24;
    $proyecto->created_date = 'now()';
    $proyecto->modified_date = 'now()';
    if($proyecto->save()){
       $this->redirect(array('create_accion', 'id_proyecto' => $id_proyecto)); 
    } else {
        echo "<pre>Proyecto";
        var_dump($proyecto->Errors);
        exit;
    }
}

$this->render('update',array(
'model'=>$model,
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

/**
* Lists all models.
*/
public function actionIndex()
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
    $this->render('index',array(
        'admin'=>$admin,
        'dependencia' => $dependencia,
        'cruge_dependencia' => $cruge_dependencia,
        'cruge_cargo' => $cruge_cargo,
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

/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=Proyecto::model()->findByPk($id);
if($model===null)
throw new CHttpException(404,'The requested page does not exist.');
return $model;
}

/**
* Performs the AJAX validation.
* @param CModel the model to be validated
*/
protected function performAjaxValidation($model)
{
if(isset($_POST['ajax']) && $_POST['ajax']==='proyecto-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
