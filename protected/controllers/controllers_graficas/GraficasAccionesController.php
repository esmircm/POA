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

            if(isset($_POST['MaestroPoa'])){
                
//                var_dump($_POST["MaestroPoa"]);die;
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
                foreach ($acciones as $data_accion){
                    $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $data_accion->id_accion));

                    $o = 1;
                    $sql[$data_accion->id_accion] = "";
                    foreach ($actividades as $data_actividad) {

                        $sql[$data_accion->id_accion] .= "SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CANTIDAD PROGRAMADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_programada) is null THEN 0 ELSE SUM(ren.cantidad_programada) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 GROUP BY poa.id_poa, acc.fk_poa UNION SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". CANTIDAD CUMPLIDA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_cumplida) is null THEN 0 ELSE SUM(ren.cantidad_cumplida) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 ". $condicion;
                     
                        $sql[$data_accion->id_accion] .= "GROUP BY poa.id_poa, acc.fk_poa ";

                        if ($o != count($actividades)) {
                            $sql[$data_accion->id_accion] .= " UNION ";
                        }

                        if ($o == count($actividades)) {
                            $sql[$data_accion->id_accion] .= " ORDER BY descripcion";
                        }

                        $o++;
                    }
//                    var_dump($sql[$data_accion->id_accion]);die;
                    $connection[$data_accion->id_accion] = Yii::app()->db;
                    $command[$data_accion->id_accion] = $connection[$data_accion->id_accion]->createCommand($sql[$data_accion->id_accion]);
                    $row[$data_accion->id_accion] = $command[$data_accion->id_accion]->queryAll();
                }
                
                $i = 1;
                $html = "";
                $html .='<table style="width: 100%; border-collapse: collapse; text-align: center;">';
                $descripcion = MaestroPoa::model()->findByAttributes(array('id_maestro' => $_POST['MaestroPoa2_id_maestro']));
                foreach ($acciones as $data_accion){
                    $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $data_accion->id_accion));
                    $html .='<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1); background-color: rgba(133, 133, 133, 1); color: #FFF;">
                                <td style="text-align: left">Acción ' . $i . ': ' . $data_accion->nombre_accion . '</td>
                                <td style="text-align: center">N°</td>
                                <td style="text-align: center">Unidad de Medida</td>
                                <td style="text-align: center">Total Anual</td>
                                <td style="text-align: center">Ejecutado para ' . $descripcion->descripcion . '</td>
                                <td style="text-align: center">% de Ejecución</td>
                            </tr>';
                    $o = 1;
                    $trim_condicion = str_replace('ren.', '', $condicion);
                    foreach ($actividades as $data) {
                        $html .= '<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
                                    <td style="text-align: left">Actividad' . $o . ': ' . $data['actividad'] . '</td>
                                    <td style="text-align: center">' . $o . '</td>
                                    <td style="text-align: center">' . $data['unidad_medida'] . '</td>
                                    <td style="text-align: center">' . $data['cantidad'] . '</td>
                                    <td style="text-align: center">' . Actividades::model()->suma_rendimiento($data['id_actividades'], $trim_condicion) . '</td>
                                    <td style="text-align: center">' . ((Actividades::model()->suma_rendimiento($data['id_actividades'], $trim_condicion) * 100)/$data['cantidad']) . "%" . '</td>
                                </tr>';
                        $o++;
                    }
                    $i++;
                }
                $html .='</table>';
                
            }else{
            
                foreach ($acciones as $data_accion){
                    $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $data_accion->id_accion));
    //                echo"<pre>";var_dump($actividades);die;
    //                $grafica_acciones = array();
    //                if()

                    $o = 1;
                    $sql[$data_accion->id_accion] = "";
                    foreach ($actividades as $data_actividad) {

                        $sql[$data_accion->id_accion] .= "SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". PROGRAMADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_programada) is null THEN 0 ELSE SUM(ren.cantidad_programada) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 GROUP BY poa.id_poa, acc.fk_poa UNION SELECT CASE WHEN poa.id_poa = acc.fk_poa THEN ('" . $o . ". EJECUTADA')::text END AS descripcion, CASE WHEN SUM(ren.cantidad_cumplida) is null THEN 0 ELSE SUM(ren.cantidad_cumplida) END AS cantidad FROM poa.poa poa LEFT JOIN poa.acciones acc ON poa.id_poa = acc.fk_poa LEFT JOIN poa.actividades act ON acc.id_accion = act.fk_accion RIGHT JOIN poa.rendimiento ren ON act.id_actividades = ren.id_entidad WHERE act.id_actividades = " . $data_actividad->id_actividades . " AND ren.fk_tipo_entidad = 74 GROUP BY poa.id_poa, acc.fk_poa ";

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
                
                $i = 1;
                $html = "";
                $html .='<table style="width: 100%; border-collapse: collapse; text-align: center;">';
                foreach ($acciones as $data_accion){
                    $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $data_accion->id_accion));
                    $html .='<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1); background-color: rgba(133, 133, 133, 1); color: #FFF;">
                                <td style="text-align: left">Acción ' . $i . ': ' . $data_accion->nombre_accion . '</td>
                                <td style="text-align: center">N°</td>
                                <td style="text-align: center">Unidad de Medida</td>
                                <td style="text-align: center">Total Anual</td>
                                <td style="text-align: center">Ejecutado hasta la Fecha</td>
                                <td style="text-align: center">% de Ejecución</td>
                            </tr>';
                    $o = 1;
                    foreach ($actividades as $data) {
                        $html .= '<tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
                                    <td style="text-align: left">Actividad' . $o . ': ' . $data['actividad'] . '</td>
                                    <td style="text-align: center">' . $o . '</td>
                                    <td style="text-align: center">' . $data['unidad_medida'] . '</td>
                                    <td style="text-align: center">' . $data['cantidad'] . '</td>
                                    <td style="text-align: center">' . Actividades::model()->suma_rendimiento($data['id_actividades'], "") . '</td>
                                    <td style="text-align: center">' . ((Actividades::model()->suma_rendimiento($data['id_actividades'], "") * 100)/$data['cantidad']) . "%" . '</td>
                                </tr>';
                        $o++;
                    }
                    $i++;
                }
                
                $html .='</table>';

            }
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
