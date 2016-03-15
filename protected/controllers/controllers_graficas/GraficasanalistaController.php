<?php

class GraficasanalistaController extends Controller {
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


            $sql = " SELECT est.id_maestro, est.descripcion AS usuario_asignado,
    COALESCE ((SELECT count(id_evaluacion)
           FROM evaluacion.evaluacion eva
           JOIN evaluacion.estatus_evaluacion esteval ON esteval.fk_evaluacion = eva.id_evaluacion
           WHERE esteval.fk_estatus_evaluacion = est.id_maestro
           AND esteval.fecha_estatus = ((SELECT max(est2.fecha_estatus) AS max
                          FROM evaluacion.estatus_evaluacion est2 WHERE est2.fk_evaluacion = esteval.fk_evaluacion
                          GROUP BY esteval.fk_evaluacion))),0) AS cant_casos
FROM evaluacion.maestro est
WHERE est.padre = 46     ";

            /* este es la conec con la base de datos confic main */

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

            /* este es la definicion de las variables a usar en la grafica */


            $datos_leyenda = array();
            $dato = array();

            /* este es el bucle para traer la data */

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficaanalista', array('fk_usuario_asiganado' => $fila['fk_usuario_asiganado'], 'opc' => 2)) . '">' . $fila['usuario_asignado'] . '</a>'));
                array_push($dato, (int) $fila['cant_casos']);
                // array_push($total, $fila['total']);
            }

            // echo '<pre>'; var_dump($datos); exit();

            $total_final = array_sum($dato);
            $this->render('/graficas/grafica_analista', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo'=>'Cantidad de Solicitudes por Analistas',
                'subtitulo'=>'General'
            ));
        } else if ($_REQUEST['opc'] == 2 ) {
    
            $sql = "  select crug.iduser, crug.username, est.descripcion as estatus, 
    COALESCE (SUM(CASE WHEN usl.fk_solicitud = sol.id_solicitud THEN 1 END),0) as cant_solicitudes
    from solicitud sol
    join usuario_solicitud usl on usl.fk_solicitud = sol.id_solicitud
    join cruge_user crug ON crug.iduser = usl.fk_usuario_asiganado
    join estatus_solicitud esl on esl.fk_solicitud = sol.id_solicitud
    join maestro est on est.id_maestro = esl.fk_status_solicitud
    where crug.iduser = ".$_GET['fk_usuario_asiganado']." ---------  fk_usuario_asiganado
    AND usl.created_date = (( SELECT max(esol.created_date) AS max
                FROM usuario_solicitud esol
                JOIN solicitud sol1 ON sol.id_solicitud = esol.fk_solicitud
                WHERE sol1.id_solicitud = sol.id_solicitud))
    AND esl.created_date = (( SELECT max(esol.created_date) AS max
                FROM estatus_solicitud esol
                JOIN solicitud sol1 ON sol.id_solicitud = esol.fk_solicitud
                WHERE sol1.id_solicitud = sol.id_solicitud))
group by   crug.iduser, crug.username, est.descripcion  ";

            /* este es la conec con la base de datos confic main */

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

            /* este es la definicion de las variables a usar en la grafica */

            $datos_leyenda = array();
            $dato = array();
            
            /* este es el bucle para traer la data */

            foreach ($row as $fila) {
                array_push($datos_leyenda, $fila['estatus']);
                array_push($dato, (int) $fila['cant_solicitudes']);
                // array_push($total, $fila['total']);
            }

            // echo '<pre>'; var_dump($datos); exit();

            $total_final = array_sum($dato);
            $this->render('/graficas/grafica_analista', array(
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'datos' => $total_final,
                'titulo'=>'Estatus de las Solicitudes',
                'subtitulo'=>'Asignadas al Analista '.strtoupper($row[0]['username']),
            ));
        }
    }

}
