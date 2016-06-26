<?php

class GraficasAccionesProyectoController extends Controller {
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
//echo "hola"; exit();

        /* este es la consulta sql */
        if (!isset($_REQUEST['opc'])) {
            $maestro = new MaestroPoa;
            $maestro2 = new MaestroPoa;
            $sql = array();
            $poa = VswPoa::model()->findByAttributes(array('id_poa' => $id_poa));
            $acciones = VswAcciones::model()->findAllByAttributes(array('fk_poa' => $id_poa));
            
            if(isset($_POST['MaestroPoa'])){
                if($_POST['MaestroPoa']['id_maestro']==80){
                    if($_POST["MaestroPoa2_id_maestro"] == 81){
                        $condicion = " AND ren.fk_meses in (57, 58, 59, 60, 61, 62) ";
                    }
                    if($_POST["MaestroPoa2_id_maestro"] == 82){
                        $condicion = " AND ren.fk_meses in (63, 64, 65, 66, 67, 68) ";
                    }
                }
                if($_POST['MaestroPoa']['id_maestro']==75){
                    if($_POST["MaestroPoa2_id_maestro"] == 76){
                        $condicion = " AND ren.fk_meses in (57, 58, 59) ";
                    }
                    if($_POST["MaestroPoa2_id_maestro"] == 77){
                        $condicion = " AND ren.fk_meses in (60, 61, 62) ";
                    }
                    if($_POST["MaestroPoa2_id_maestro"] == 78){
                        $condicion = " AND ren.fk_meses in (63, 64, 65) ";
                    }
                    if($_POST["MaestroPoa2_id_maestro"] == 79){
                        $condicion = " AND ren.fk_meses in (66, 67, 68) ";
                    }
                }
                if($_POST['MaestroPoa']['id_maestro']==56){
                    $condicion = " AND ren.fk_meses = " . $_POST["MaestroPoa2_id_maestro"] . " ";
                }
                $o=1;
                foreach ($acciones as $data_accion){
                        $sql[$data_accion->id_accion] = '';

                        $sql[$data_accion->id_accion] .= "SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". PROGRAMADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_programada) is null THEN 0 ELSE SUM(ren.cantidad_programada) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa RIGHT JOIN poa.rendimiento ren ON acc.id_accion = ren.id_entidad WHERE acc.id_accion = " . $data_accion->id_accion . " AND ren.fk_tipo_entidad = 73 GROUP BY poa.id_poa, acc.fk_poa UNION SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CUMPLIDA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_cumplida) is null THEN 0 ELSE SUM(ren.cantidad_cumplida) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa RIGHT JOIN poa.rendimiento ren ON acc.id_accion = ren.id_entidad WHERE acc.id_accion = " . $data_accion->id_accion . " AND ren.fk_tipo_entidad = 73 " . $condicion . " GROUP BY poa.id_poa, acc.fk_poa ";


                        $sql[$data_accion->id_accion] .= " ORDER BY descripcion";




                    $connection[$data_accion->id_accion] = Yii::app()->db;
                    $command[$data_accion->id_accion] = $connection[$data_accion->id_accion]->createCommand($sql[$data_accion->id_accion]);
                    $row[$data_accion->id_accion] = $command[$data_accion->id_accion]->queryAll();
                    $o++;
                }
                $html = "";
                $trim_condicion = str_replace('ren.', '', $condicion);
                $count = count($acciones);
                $i = 1;
                foreach ($acciones as $graficas) {
                
                    $html .='<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
                        <td style="text-align: left">' . $i . '.-' . $graficas['nombre_accion'] . '</td>
                        <td style="text-align: center">' . $graficas['unidad_medida'] . '</td>
                        <td style="text-align: center">' . $graficas['cantidad'] . '</td>
                        <td style="text-align: center">' . Acciones::model()->suma_rendimiento($graficas['id_accion'], $trim_condicion) . '</td>
                        <td style="text-align: center">' . number_format(((Acciones::model()->suma_rendimiento($graficas['id_accion'], $trim_condicion) * 100)/$graficas['cantidad']), 2) . "%" . '</td>
                    </tr>';

                $i++;
                }       
            } else {
                $o=1;
                foreach ($acciones as $data_accion){
                        $sql[$data_accion->id_accion] = '';

                        $sql[$data_accion->id_accion] .= "SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". PROGRAMADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_programada) is null THEN 0 ELSE SUM(ren.cantidad_programada) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa RIGHT JOIN poa.rendimiento ren ON acc.id_accion = ren.id_entidad WHERE acc.id_accion = " . $data_accion->id_accion . " AND ren.fk_tipo_entidad = 73 GROUP BY poa.id_poa, acc.fk_poa UNION SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CUMPLIDA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_cumplida) is null THEN 0 ELSE SUM(ren.cantidad_cumplida) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa RIGHT JOIN poa.rendimiento ren ON acc.id_accion = ren.id_entidad WHERE acc.id_accion = " . $data_accion->id_accion . " AND ren.fk_tipo_entidad = 73 GROUP BY poa.id_poa, acc.fk_poa ";


                        $sql[$data_accion->id_accion] .= " ORDER BY descripcion";




                    $connection[$data_accion->id_accion] = Yii::app()->db;
                    $command[$data_accion->id_accion] = $connection[$data_accion->id_accion]->createCommand($sql[$data_accion->id_accion]);
                    $row[$data_accion->id_accion] = $command[$data_accion->id_accion]->queryAll();
                    $o++;
                }
                $html = "";
                $count = count($acciones);
                $i = 1;
                foreach ($acciones as $graficas) {
                
                    $html .='<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
                        <td style="text-align: left">' . $i . '.-' . $graficas['nombre_accion'] . '</td>
                        <td style="text-align: center">' . $graficas['unidad_medida'] . '</td>
                        <td style="text-align: center">' . $graficas['cantidad'] . '</td>
                        <td style="text-align: center">' . Acciones::model()->suma_rendimiento($graficas['id_accion'], "") . '</td>
                        <td style="text-align: center">' . number_format(((Acciones::model()->suma_rendimiento($graficas['id_accion'], "") * 100)/$graficas['cantidad']), 2) . "%" . '</td>
                    </tr>';

                $i++;
                }       
            }
//                echo "<pre>";var_dump($sql);die;
            

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
            $this->render('/graficas/grafica_proyecto', array(
                'id_poa' => $id_poa,
                'tipo' => $tipo,
                'poa' => $poa,
                'acciones' => $acciones,
                'datos_leyenda' => $datos_leyenda,
                'total' => $dato,
                'html' => $html,
                'maestro' => $maestro,
                'maestro2' => $maestro2,
            ));
                

        }
    }

}
