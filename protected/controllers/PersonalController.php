<?php

class PersonalController extends Controller {

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column2';

    /**
     * @return array action filters
     */
//    public function filters() {
//        return array(
//            'accessControl', // perform access control for CRUD operations
//            'postOnly + delete', // we only allow deletion via POST request
//        );
//    }

    public function filters() {
        return array(array('CrugeAccessControlFilter'));
    }

    /**
     * Specifies the access control rules.
     * This method is used by the 'accessControl' filter.
     * @return array access control rules
     */
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'update', 'createActualizar'),
                'users' => array('@'),
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

    public function actionCreate() {

        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $ConsultaIdPersona = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $idPersonal = $ConsultaIdPersona->id_personal;
        $idUser = Yii::app()->user->id;

        $traza = Traza::VerificarTraza($idPersonal, $idUser); // verifica el guardado de la traza
        if ($traza != 0) {
            Generico::renderTraza(); //renderiza a la traza
        }

        $pais = new Pais;
        $estado = new Estado;
        //$ciudad = new Ciudad;
        $puebloindigena = new Puebloindigena;

        //busqueda del id de la persona por cedula
        $model = Personal::model()->findByAttributes(array('id_personal' => $ConsultaIdPersona->id_personal));

        if (empty($model)) {
            $model = new Personal;
            $model->fecha_nacimiento = empty($model->fecha_nacimiento) ? '' : date('d/m/Y', strtotime($model->fecha_nacimiento));
        } else {
            $model->fecha_nacimiento = date('d/m/Y', strtotime($model->fecha_nacimiento));
        }
        if (isset($_POST['Personal'])) {
            $model->attributes = $_POST['Personal'];
            $model->puebloindigena = $_POST ['Puebloindigena']['cod_pueblo_indigena'];
            $model->madre_padre = isset($_POST['Personal_madre_padre']) ? 'S' : 'N';
            $model->discapacidad = isset($_POST['Personal_discapacidad']) ? 'S' : 'N';
            $model->tiene_vehiculo = isset($_POST['Personal_tiene_vehiculo']) ? 'S' : 'N';
            $model->maneja = isset($_POST['Personal_maneja']) ? 'S' : 'N';
            $model->fecha_nacimiento = Generico::formatoFecha($_POST['Personal']['fecha_nacimiento']);
            
            if ($model->save()) {
                $guardartraza = Traza::actionInsertUpdateTraza(1, $idPersonal, $idUser, 1); // permite insertar y actualizar la traza segun el caso
                $this->redirect(array('educacion/create'));
            }
        }
        $this->render('create', array(
            'model' => $model, 'pais' => $pais, 'estado' => $estado, 'puebloindigena' => $puebloindigena,
        ));
    }

    
    
    //funcion Actualizar una ves que se activa la accion en la vista actualizar
    
    public function actionCreateActualizar() {

        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $ConsultaIdPersona = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $idPersonal = $ConsultaIdPersona->id_personal;
        $idUser = Yii::app()->user->id;


        $pais = new Pais;
        $estado = new Estado;
        //$ciudad = new Ciudad;
        $puebloindigena = new Puebloindigena;

        //busqueda del id de la persona por cedula
        $model = Personal::model()->findByAttributes(array('id_personal' => $ConsultaIdPersona->id_personal));

        if (empty($model)) {
            $model = new Personal;
            $model->fecha_nacimiento = empty($model->fecha_nacimiento) ? '' : date('d/m/Y', strtotime($model->fecha_nacimiento));
        } else {
            $model->fecha_nacimiento = date('d/m/Y', strtotime($model->fecha_nacimiento));
        }
        if (isset($_POST['Personal'])) {
            $model->attributes = $_POST['Personal'];
            $model->puebloindigena = $_POST ['Puebloindigena']['cod_pueblo_indigena'];
            $model->madre_padre = isset($_POST['Personal_madre_padre']) ? 'S' : 'N';
            $model->discapacidad = isset($_POST['Personal_discapacidad']) ? 'S' : 'N';
            $model->tiene_vehiculo = isset($_POST['Personal_tiene_vehiculo']) ? 'S' : 'N';
            $model->maneja = isset($_POST['Personal_maneja']) ? 'S' : 'N';
            $model->fecha_nacimiento = Generico::formatoFecha($_POST['Personal']['fecha_nacimiento']);

            if ($model->save()) {
                $historico = Historico::model()->findByAttributes(array('id_usuario' => $idUser));
                $update = Historico::model()->updateByPk($historico->id_historico, array('se_activa_1' => 0));
                $this->redirect(array('site/registrofinal'));
            }
        }
        $this->render('createActualizar', array(
            'model' => $model, 'pais' => $pais, 'estado' => $estado, 'puebloindigena' => $puebloindigena,
        ));
    }

    /*
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */

    public function actionUpdate($id) {

        $model = $this->loadModel($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['Personal'])) {
            $model->attributes = $_POST['Personal'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id_personal));
        }

        $this->render('update', array(
            'model' => $model,
        ));
    }

    /**
     * Deletes a particular model.
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param integer $id the ID of the model to be deleted
     */
    public function actionDelete($id) {
        $this->loadModel($id)->delete();

        // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
        if (!isset($_GET['ajax']))
            $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
    }

    /**
     * Lists all models.
     */
    public function actionIndex() {
        $dataProvider = new CActiveDataProvider('Personal');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new Personal('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['Personal']))
            $model->attributes = $_GET['Personal'];

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer $id the ID of the model to be loaded
     * @return Personal the loaded model
     * @throws CHttpException
     */
    public function loadModel($id) {
        $model = Personal::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param Personal $model the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'personal-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
