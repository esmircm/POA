<?php

class FamiliarController extends Controller {
    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */

    /**
     * @return array action filters
     */
//    public function filters() {
//        return array(
//            'accessControl', // perform access control for CRUD operations
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
//    public function accessRules() {
//        return array(
//            array('allow', // allow all users to perform 'index' and 'view' actions
//                'actions' => array('index', 'view'),
//                'users' => array('*'),
//            ),
//            array('allow', // allow authenticated user to perform 'create' and 'update' actions
//                'actions' => array('create', 'update', 'finalizar', 'createActualizarFamilia'),
//                'users' => array('@'),
//            ),
//            array('allow', // allow admin user to perform 'admin' and 'delete' actions
//                'actions' => array('admin', 'delete'),
//                'users' => array('admin'),
//            ),
//            array('deny', // deny all users
//                'users' => array('*'),
//            ),
//        );
//    }

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
        $model = new Familiar;
        $educacion = new Niveleducativo;
        $nacionalidad = new Maestro;
        $cedula = new Tbldiex;

        $Seccion = Yii::app()->getSession()->get('CedulaUser');
        $idPersonal = Personal::model()->findByAttributes(array('cedula' => $Seccion,));

        $idUser = Yii::app()->user->id;

        $traza = Traza::VerificarTraza($idPersonal->id_personal, $idUser); // verifica el guardado de la traza
        if ($traza != 2) {
            Generico::renderTraza(); //renderiza a la traza
        }
        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);
//        if (empty($personal)) {
//            $personal->id_personal;
//        }
        if (isset($_POST['Familiar'])) {
            $model->attributes = $_POST['Familiar'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id_familiar));
        }

        $this->render('create', array(
            'model' => $model, 'educacion' => $educacion, 'nacionalidad' => $nacionalidad, 'cedula' => $cedula, 'personal' => $idPersonal
        ));
    }

    public function actionCreateActualizarFamilia() {
        $model = new Familiar;
        $educacion = new Niveleducativo;
        $nacionalidad = new Maestro;
        $cedula = new Tbldiex;

        $Seccion = Yii::app()->getSession()->get('CedulaUser');
        $idPersonal = Personal::model()->findByAttributes(array('cedula' => $Seccion,));

        $idUser = Yii::app()->user->id;
        $historico = Historico::model()->findByAttributes(array('id_usuario' => $idUser));
        $update = Historico::model()->updateByPk($historico->id_historico, array('se_activa_3' => 0));


        if (isset($_POST['Familiar'])) {
            $model->attributes = $_POST['Familiar'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id_familiar));
        }

        $this->render('createActualizarFamilia', array(
            'model' => $model, 'educacion' => $educacion, 'nacionalidad' => $nacionalidad, 'cedula' => $cedula, 'personal' => $idPersonal
        ));
    }

    
    public function actionFinalizar() {
        $idUser = Yii::app()->user->id;
        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $ConsultaIdPersona = Personal::model()->findByAttributes(array('cedula' => $cedula));
        $idPersonal = $ConsultaIdPersona->id_personal;
        $idtraza = Traza::ObtenerIdTraza($idPersonal, $idUser); // pemite la busqueda de la id de la traza 

        $guardartraza = Traza::actionInsertUpdateTraza(2, $idPersonal, $idUser, 3, $idtraza); // permite insertar y actualizar la traza segun el caso 
        if ($guardartraza) {
            $SQL3 = "SELECT fn_eliminar_traza(" . $idUser . ", " . $idPersonal . ")";
            $data = Yii::app()->db->createCommand($SQL3)->queryRow();
            if ($data['fn_eliminar_traza'] == 1) {
                $this->redirect(array('/site/registrofinal'));
            }
        }
    }

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate($id) {
        $model = $this->loadModel($id);
        $educacion = new Educacion;
        $nacionalidad = new Maestro;
        $cedula = new Tbldiex;
        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['Familiar'])) {
            $model->attributes = $_POST['Familiar'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id_familiar));
        }

        $this->render('update', array(
            'model' => $model, 'educacion' => $educacion, 'nacionalidad' => $nacionalidad, 'cedula' => $cedula,
        ));
    }

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
    public function actionIndex() {
        $dataProvider = new CActiveDataProvider('Familiar');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new Familiar('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['Familiar']))
            $model->attributes = $_GET['Familiar'];

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer the ID of the model to be loaded
     */
    public function loadModel($id) {
        $model = Familiar::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param CModel the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'familiar-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
