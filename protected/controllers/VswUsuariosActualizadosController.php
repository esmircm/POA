<?php

class VswUsuariosActualizadosController extends Controller {

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
            'postOnly + delete', // we only allow deletion via POST request
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
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'update', 'historico'),
                'users' => array('@'),
            ),
            array('allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('@'),
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
//	public function actionView($id)
//	{
//		$this->render('view',array(
//			'model'=>$this->loadModel($id),
//		));
//	}

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
//	public function actionCreate()
//	{
//		$model=new VswUsuariosActualizados;
//
//		// Uncomment the following line if AJAX validation is needed
//		// $this->performAjaxValidation($model);
//
//		if(isset($_POST['VswUsuariosActualizados']))
//		{
//			$model->attributes=$_POST['VswUsuariosActualizados'];
//			if($model->save())
//				$this->redirect(array('view','id'=>$model->id_personal));
//		}
//
//		$this->render('create',array(
//			'model'=>$model,
//		));
//	}

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
//        
    public function actionHistorico() {
        $id = $_GET['id'];
        $caso = $_GET['caso'];
        $update = Historico::model()->findByAttributes(array('id_personal' => $id));

        switch ($caso) {
            case 1:
                $update->se_activa_1 = true;
                break;
            case 2:
                $update->se_activa_2 = true;
                break;
            case 3:
                $update->se_activa_3 = true;
                break;
        }

        if ($update->save()) {
            $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
        }
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new VswUsuariosActualizados('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['VswUsuariosActualizados']))
            $model->attributes = $_GET['VswUsuariosActualizados'];
        $this->render('admin', array('model' => $model));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer $id the ID of the model to be loaded
     * @return VswUsuariosActualizados the loaded model
     * @throws CHttpException
     */
    public function loadModel($id) {
        $model = VswUsuariosActualizados::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param VswUsuariosActualizados $model the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'vsw-usuarios-actualizados-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
