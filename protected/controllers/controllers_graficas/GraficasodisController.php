<?php

class GraficasodisController extends Controller {
    //public $layout = '//layouts/admintui';

    /**
     * @return array action filters
     */
    public function filters() {
        return array(
            'accessControl', // perform access control for CRUD operations
            'postOnly + delete', // we only allow deletion via POST request
        );
    }

    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('*'),
                'users' => array('*'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    public function actionIndex() {
//echo "hola"; exit();

        /* este es la consulta sql */
        if (!isset($_REQUEST['opc'])) {


            $sql = "SELECT dependencia, count(id_evaluacion) AS valor
		      FROM evaluacion.vsw_admin
		      GROUP BY dependencia
		      order by dependencia";

            /* este es la conec con la base de datos confic main */

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();
            
// echo '<pre>'; var_dump($row); exit();

            /* este es la definicion de las variables a usar en la grafica */


            $datos_leyenda = array();
            $dato = array();

           //  echo '<pre>'; var_dump($datos_leyenda,$dato); exit();

            /* este es el bucle para traer la data */

            foreach ($row as $fila) {
                
          //      var_dump($fila); exit();
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficarecepcion', array('valor' => $fila['valor'], 'opc' => 2, 'dependencia' => $fila['dependencia'])) . '">' . $fila['dependencia'] . '</a>'));
                array_push($dato, (int) $fila['valor']);
            }

            // echo '<pre>'; var_dump($datos); exit();

            $total_final = array_sum($dato);
            $this->render('/graficas/grafica_odi', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo' => 'Indicadores por Odis',
                'subtitulo' => 'General'
            ));
        } else if ($_REQUEST['opc'] == 2) {
//
//            echo '<pre>';
//            var_dump($_REQUEST);
//            exit();


            $sql = " SELECT dependencia, count(id_evaluacion) 
		      FROM evaluacion.vsw_admin
		      GROUP BY dependencia
		      order by dependencia";

            /* este es la conec con la base de datos confic main */

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

            /* este es la definicion de las variables a usar en la grafica */


            $datos_leyenda = array();
            $dato = array();

            /* este es el bucle para traer la data */

            foreach ($row as $fila) {
                array_push($datos_leyenda, $fila['unidad_admtiva']);
                array_push($dato, (int) $fila['valor']);
                // array_push($total, $fila['total']);
            }

            // echo '<pre>'; var_dump($datos); exit();

            $total_final = array_sum($dato);
            $this->render('/graficas/grafica_odis', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo' => 'Indicador Cantidad De Odis Cargadas',
                'subtitulo' => $_GET['descripcion'],
            ));
        }
    }

}
