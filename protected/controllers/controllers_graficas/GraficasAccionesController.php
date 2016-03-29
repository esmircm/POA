<?php

class GraficasAccionesController extends Controller {
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

    public function actionIndex($id_poa, $tipo) {
        

        if (!isset($_REQUEST['opc'])) {

            $maestro = new MaestroPoa;
            $maestro2 = new MaestroPoa;
            $poa = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
            $acciones = VswAcciones::model()->findAllByAttributes(array('fk_poa' => $id_poa));
//            $i=0;
            foreach ($acciones as $data_accion){
                $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $data_accion->id_accion));
//                echo"<pre>";var_dump($actividades);die;
//                $grafica_acciones = array();
//                if()
                
                $o = 1;
                $sql[$data_accion->id_accion] = "";
                foreach ($actividades as $data_actividad) {
                    
                    $sql[$data_accion->id_accion] .= "SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CANTIDAD PROGRAMADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_programada) is null THEN 0 ELSE SUM(ren.cantidad_programada) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 GROUP BY poa.id_poa, acc.fk_poa UNION SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CANTIDAD CUMPLIDA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_cumplida) is null THEN 0 ELSE SUM(ren.cantidad_cumplida) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 GROUP BY poa.id_poa, acc.fk_poa ";

                    if ($o != count($actividades)) {
                        $sql[$data_accion->id_accion] .= " UNION ";
                    }

                    if ($o == count($actividades)) {
                        $sql[$data_accion->id_accion] .= " ORDER BY descripcion";
                    }

                    $o++;
                }
                $connection[$data_accion->id_accion] = Yii::app()->db;
                $command[$data_accion->id_accion] = $connection[$data_accion->id_accion]->createCommand($sql[$data_accion->id_accion]);
                $row[$data_accion->id_accion] = $command[$data_accion->id_accion]->queryAll();
            }
//                        echo "<pre>";var_dump($row);die;
            

//                var_dump($row);die;
            foreach ($acciones as $data_accion) {
//                var_dump($data_accion);die;
                $datos_leyenda[$data_accion->id_accion] = array();
                $dato[$data_accion->id_accion] = array();
                $i = 0;
                foreach($row[$data_accion->id_accion] as $fila){
//                    echo "<pre>";var_dump($fila);die;
                    array_push($datos_leyenda[$data_accion->id_accion], $fila['descripcion']);
                    array_push($dato[$data_accion->id_accion], (int) $fila['cantidad']);
                
                    $i++;
                }
            }
//            echo "<pre>";var_dump($datos_leyenda);die;
            $this->render('/graficas/grafica_poa', array(
                'poa' => $poa,
                'acciones' => $acciones,
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'maestro' => $maestro,
                'maestro2' => $maestro2,
            ));
                

        }
    }

}
