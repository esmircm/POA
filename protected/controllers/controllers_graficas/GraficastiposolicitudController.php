<?php

class GraficastiposolicitudController extends Controller {
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

    public function actionTiposolicitud() {
//echo "hola"; exit();

        /* este es la consulta sql */

        $sql = " SELECT tat.descripcion AS tipo_ayuda_tecnica, count (*)
   FROM solicitud sol
   JOIN beneficiario ben ON ben.id_beneficiario = sol.fk_beneficiario AND ben.es_activo AND ben.fk_estatus = 5
   JOIN persona per ON per.id_persona = ben.fk_persona AND per.es_activo AND per.fk_estatus = 22
   JOIN estatus_solicitud esol ON esol.fk_solicitud = sol.id_solicitud AND esol.es_activo AND esol.fk_estatus = 11
   JOIN maestro stsol ON stsol.id_maestro = esol.fk_status_solicitud
   JOIN maestro nac ON nac.id_maestro = per.fk_nacionalidad
   JOIN maestro tip ON tip.id_maestro = sol.fk_tipo_solicitud
   LEFT JOIN maestro tat ON tat.id_maestro = sol.fk_tipo_ayuda_tecnica
   LEFT JOIN maestro mr ON mr.id_maestro = sol.fk_mecanismo_recepcion
   LEFT JOIN maestro rm ON rm.id_maestro = sol.fk_recepcion_ministerial
  WHERE sol.es_activo AND sol.fk_estatus = 25
 group by tat.descripcion ";

        /* este es la conec con la base de datos confic main */

        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

        /* este es la definicion de las variables a usar en la grafica */


        $datos_leyenda = array();
        $dato = array();

        /* este es el bucle para traer la data */

        foreach ($row as $fila) {

            array_push($datos_leyenda, $fila['tipo_ayuda_tecnica']);
            array_push($dato, array($fila['tipo_ayuda_tecnica'], (int) $fila['count']));
            // array_push($total, $fila['total']);
        }

        // echo '<pre>'; var_dump($datos); exit();

        $total_final = array_sum($dato);

        $this->render('/graficas/grafica_tiposolicitud', array(
            'leyenda' => $datos_leyenda,
            'total' => $dato,
            'datos' => $total_final,
        ));
    }

}
