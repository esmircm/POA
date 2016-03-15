<?php

class GraficasController extends Controller {
    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
//    public $layout = '//layouts/column2';
    //  public $layout = '//layouts/admintui';

    /**
     * @return array action filters
     */
    /* public function filters() {
      return array(
      'accessControl', // perform access control for CRUD operations
      );
      } */

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
//                'actions' => array('*'),
//                'users' => array('*'),
//            ),
//        );
//    }

    /**
     * Grafica de prueba 
     */

      public function actionGraficanacionalidad() {
          GraficasnacionalidadController::actionNacionalidad();
      }


      public function actionGraficarecepcion() {
        GraficasrecepcionController::actionIndex();
      }
      
  
      public function actionGraficaodis() {
        GraficasodisController::actionIndex();
      }
    
    
    
    
    

}
