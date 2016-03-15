<?php

class GraficasrecepcionController extends Controller {
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


            $sql = " SELECT est.id_maestro, est.descripcion AS descripcion,
    COALESCE ((SELECT count(id_evaluacion)
           FROM evaluacion.evaluacion eva
           JOIN evaluacion.estatus_evaluacion esteval ON esteval.fk_evaluacion = eva.id_evaluacion
           WHERE esteval.fk_estatus_evaluacion = est.id_maestro
           AND esteval.es_activo    
           AND esteval.fecha_estatus = ((SELECT max(est2.fecha_estatus) AS max
                          FROM evaluacion.estatus_evaluacion est2 WHERE est2.fk_evaluacion = esteval.fk_evaluacion
                          GROUP BY esteval.fk_evaluacion))),0) AS solicitudes
FROM evaluacion.maestro est
WHERE est.padre = 46 ";

            /* este es la conec con la base de datos confic main */

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

            /* este es la definicion de las variables a usar en la grafica */


            $datos_leyenda = array();
            $dato = array();


            /* este es el bucle para traer la data */

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficarecepcion', array('id_maestro' => $fila['id_maestro'], 'opc' => 2, 'descripcion' => $fila['descripcion'])) . '">' . $fila['descripcion'] . '</a>'));
                array_push($dato, (int) $fila['solicitudes']);
            }

            // echo '<pre>'; var_dump($datos); exit();

            $total_final = array_sum($dato);
            $this->render('/graficas/grafica_recepcion', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo' => 'Indicadores por Estatus',
                'subtitulo' => 'General'
            ));
        } else if ($_REQUEST['opc'] == 2) {

//            echo '<pre>';
//            var_dump($_REQUEST);
//            exit();


            $sql = " SELECT evador.unidad_admtiva, count(eval.id_evaluacion)AS valor
FROM evaluacion.evaluacion eval
JOIN evaluacion.evaluador evador ON evador.id_evaluador = eval.fk_evaluador
JOIN evaluacion.evaluados evados ON evados.id_evaluado = eval.fk_evaluado
JOIN evaluacion.estatus_evaluacion est ON est.fk_evaluacion = eval.id_evaluacion
JOIN evaluacion.maestro ms ON ms.id_maestro = est.fk_estatus_evaluacion
WHERE est.fk_estatus_evaluacion = " . $_GET['id_maestro'] . "
AND est.es_activo    
AND est.fecha_estatus = (( SELECT max(est2.fecha_estatus) AS max
           FROM evaluacion.estatus_evaluacion est2
          WHERE est2.fk_evaluacion = est.fk_evaluacion
          GROUP BY est.fk_evaluacion))
GROUP BY evador.unidad_admtiva

";

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
            $this->render('/graficas/grafica_recepcion', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo' => 'Indicador de Estatus por Oficina',
                'subtitulo' => $_GET['descripcion'],
            ));
        }
    }

}
