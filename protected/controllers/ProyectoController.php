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
'actions'=>array('index' ,'view', 'admin', 'Create_Accion', 'Create_Actividad'),
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
public function actionView($id)
{
$this->render('view',array(
'model'=>$this->loadModel($id),
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
        
        $cruge = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
        if($cruge->value == 7){
            $fk_tipo_entidad = 8;
        } else {
            $fk_tipo_entidad = 9;
        }
                     
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
                if($responsable->save()){
//                    $proyecto = new Proyecto;
                    $this->redirect(array('create_accion', 'id_proyecto' => $id_Proyecto));
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
//        var_dump($id_proyecto);die;
        $accion = new Acciones;

        $lista_accion = VswAcciones::model()->findAllByAttributes(array('fk_proyecto' => $id_proyecto));
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
        
        $this->render('create_accion', array(
            'accion' => $accion,
            'id_proyecto' => $id_proyecto,
            'lista_accion' => $lista_accion,
        ));
    }
    
    public function actionCreate_Actividad($id_proyecto, $id_accion) {
        $actividad = new Actividades;

            
        $this->render('create_actividad', array(
            'actividad' => $actividad,
            'id_accion' => $id_accion,
            'id_proyecto' => $id_proyecto
        ));
    }

    /**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
public function actionUpdate($id)
{
$model=$this->loadModel($id);

// Uncomment the following line if AJAX validation is needed
// $this->performAjaxValidation($model);

if(isset($_POST['Proyecto']))
{
$model->attributes=$_POST['Proyecto'];
if($model->save())
$this->redirect(array('view','id'=>$model->id_proyecto));
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
$dataProvider=new CActiveDataProvider('Proyecto');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
$model=new Proyecto('search');
$model->unsetAttributes();  // clear any default values
if(isset($_GET['Proyecto']))
$model->attributes=$_GET['Proyecto'];

$this->render('admin',array(
'model'=>$model,
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
