<?php

class EducacionController extends Controller {

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
                'actions' => array('create', 'update', 'buscarTitulo', 'createActualizarEstudio'),
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

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
    public function actionCreate() {

        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $ConsultaIdPersona = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $idPersonal = $ConsultaIdPersona->id_personal;

        $idUser = Yii::app()->user->id;

        $traza = Traza::VerificarTraza($idPersonal, $idUser); // verifica el guardado de la traza
        if ($traza != 1) {

            Generico::renderTraza(); //renderiza a la traza
        }

        $pais = new Pais;
        $estado = new Estado;
        $ciudad = new Ciudad;

        //busqueda del id de la persona por cedula
        $model = Educacion::model()->findByAttributes(array('id_personal' => $ConsultaIdPersona->id_personal));

        if (empty($model)) {
            $model = new Educacion;
            $model->anio_fin = ($model->anio_fin == 0) ? '' : $model->anio_fin; // 
            $model->anio_inicio = ($model->anio_inicio == 0) ? '' : $model->anio_inicio;
            $model->fecha_registro = empty($model->fecha_registro) ? '' : date('d/m/Y', strtotime($model->fecha_registro));
        } else {
            $model->anio_fin = ($model->anio_fin == 0) ? '' : $model->anio_fin; // 
            $model->anio_inicio = ($model->anio_inicio == 0) ? '' : $model->anio_inicio;
            $model->fecha_registro = date('d/m/Y', strtotime($model->fecha_registro));
        }


        if (isset($_POST['Educacion']['id_nivel_educativo']) && isset($_POST['Educacion']['anio_inicio']) && isset($_POST['Educacion']['estatus'])) {
//            $insertId = Educacion::model()->find(array('order' => 'id_educacion DESC'));
            
            
            $sql="SELECT id_educacion FROM educacion  ORDER BY id_educacion DESC LIMIT 1";
            $consulta = Yii::app()->db2->createCommand($sql)->queryAll();
            
            $model->id_educacion = empty($consulta) ? 1 : $consulta[0]['id_educacion'] + 1;
            $model->attributes = $_POST['Educacion'];
            $model->id_carrera = $_POST['Educacion_id_carrera'];
            $model->id_titulo= $_POST['Educacion_id_titulo'];
            $model->registro_titulo = !empty($_POST['Educacion']['registro_titulo']) ? 'S' : 'N';
            $model->id_personal = $idPersonal;
            $model->fecha_registro = !empty($model->fecha_registro) ? Generico::formatoFecha($model->fecha_registro) : '1969-01-01'; //cambia el formato de la fecha dd/mm/yyyy
//            echo '<pre>';var_dump($model);die;
            if ($model->save()) {
                $idtraza = Traza::ObtenerIdTraza($idPersonal, $idUser); // pemite la busqueda de la id de la traza 
                $guardartraza = Traza::actionInsertUpdateTraza(2, $idPersonal, $idUser, 2, $idtraza); // permite insertar y actualizar la traza segun el caso 
                $this->redirect(array('/familiar/create'));
            }
        }

        $this->render('create', array(
            'model' => $model, 'pais' => $pais, 'estado' => $estado, 'ciudad' => $ciudad
        ));
    }
    
    
    //funcion actualizar una vez que se active la accion en la vista de la actualizacion
    
      public function actionCreateActualizarEstudio() {

        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $ConsultaIdPersona = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $idPersonal = $ConsultaIdPersona->id_personal;
        $idUser = Yii::app()->user->id;

        $pais = new Pais;
        $estado = new Estado;
        $ciudad = new Ciudad;

        //busqueda del id de la persona por cedula
        $model = Educacion::model()->findByAttributes(array('id_personal' => $ConsultaIdPersona->id_personal));

        if (empty($model)) {
            $model = new Educacion;
            $model->anio_fin = ($model->anio_fin == 0) ? '' : $model->anio_fin; // 
            $model->anio_inicio = ($model->anio_inicio == 0) ? '' : $model->anio_inicio;
            $model->fecha_registro = empty($model->fecha_registro) ? '' : date('d/m/Y', strtotime($model->fecha_registro));
        } else {
            $model->anio_fin = ($model->anio_fin == 0) ? '' : $model->anio_fin; // 
            $model->anio_inicio = ($model->anio_inicio == 0) ? '' : $model->anio_inicio;
            $model->fecha_registro = date('d/m/Y', strtotime($model->fecha_registro));
        }


        if (isset($_POST['Educacion']['id_nivel_educativo']) && isset($_POST['Educacion']['anio_inicio']) && isset($_POST['Educacion']['estatus'])) {
            $insertId = Educacion::model()->find(array('order' => 'id_educacion DESC'));
            $model->id_educacion = isset($model->id_educacion) ? $model->id_educacion : $insertId->id_educacion + 1;
            $model->attributes = $_POST['Educacion'];
            $model->id_carrera = $_POST['Educacion_id_carrera'];
            $model->id_titulo= $_POST['Educacion_id_titulo'];
            $model->registro_titulo = !empty($_POST['Educacion']['registro_titulo']) ? 'S' : 'N';
            $model->id_personal = $idPersonal;
            $model->fecha_registro = !empty($model->fecha_registro) ? Generico::formatoFecha($model->fecha_registro) : '1969-01-01'; //cambia el formato de la fecha dd/mm/yyyy

            if ($model->save()) {
                $historico = Historico::model()->findByAttributes(array('id_usuario' => $idUser));
                $update = Historico::model()->updateByPk($historico->id_historico, array('se_activa_2' => 0));
                $this->redirect(array('site/registrofinal'));  
            }
        }

        $this->render('createActualizarEstudio', array(
            'model' => $model, 'pais' => $pais, 'estado' => $estado, 'ciudad' => $ciudad
        ));
    }


    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate($id) {
        $model = $this->loadModel($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['Educacion'])) {
            $model->attributes = $_POST['Educacion'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id_educacion));
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
        $dataProvider = new CActiveDataProvider('Educacion');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new Educacion('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['Educacion']))
            $model->attributes = $_GET['Educacion'];

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer $id the ID of the model to be loaded
     * @return Educacion the loaded model
     * @throws CHttpException
     */
    public function loadModel($id) {
        $model = Educacion::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param Educacion $model the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'educacion-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
