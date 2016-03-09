<?php

class GraficastipoayudaController extends Controller {
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
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    public function actionIndex() {
        if (!isset($_REQUEST['opc'])) {
            //BUSQUEDA POR ESTADO
            $sql = " SELECT sol.fk_tipo_solicitud, ms.descripcion, count(sol.id_solicitud)
                    FROM solicitud sol JOIN maestro ms ON ms.id_maestro = sol.fk_tipo_solicitud
                    GROUP BY sol.fk_tipo_solicitud, ms.descripcion ";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();
            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                if ($fila['fk_tipo_solicitud'] == 72 || $fila['fk_tipo_solicitud'] == 73) {
                    array_push($datos, array('<a href="' . $this->createUrl('graficatipoayuda', array('fk_tipo_solicitud' => $fila['fk_tipo_solicitud'], 'opc' => 2)) . '">' . $fila['descripcion'] . ': ' . $fila['count'] . '</a>', (int) $fila['count']));
                } else {
                    array_push($datos, array($fila['descripcion'] . ': ' . $fila['count'], (int) $fila['count']));
                }
                array_push($total, $fila['count']);
            }
            $total_final = array_sum($total);

            $this->render('/graficas/grafica_tipo_ayuda', array(
                'total_final' => $total_final,
                'datos' => $datos,
                // 'html_status' => $html_status,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => ''.'Total de solicitudes: '.$total_final,
                'titulo_grafica' => 'Cantidad de Solicitudes por tipo de Ayuda'
            ));
        } else if ($_REQUEST['opc'] == 2) {
            //BUSQUEDA POR MUNICIPIO   
            if ($_GET['fk_tipo_solicitud'] == 73) { // tipo de ayuda tecnica
                $sql = "    SELECT sol.fk_tipo_solicitud, ma.descripcion, sol.fk_tipo_ayuda_tecnica, ms.descripcion, count(sol.id_solicitud)
                FROM solicitud sol JOIN maestro ms ON ms.id_maestro = sol.fk_tipo_ayuda_tecnica
                JOIN maestro ma ON ma.id_maestro = sol.fk_tipo_solicitud
                WHERE fk_tipo_solicitud =" . $_GET['fk_tipo_solicitud'] . " -- fk_tipo_solicitud para ayudas técnicas
                GROUP BY sol.fk_tipo_solicitud, sol.fk_tipo_ayuda_tecnica, ms.descripcion, ma.descripcion";

                $connection = Yii::app()->db;
                $command = $connection->createCommand($sql);
                $row = $command->queryAll();
                $datos = array();
                $datos_leyenda = array();
                $total = array();

                $html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
                            <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Municipio</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';
                foreach ($row as $fila) {
                    $html_status.= '<tr><td><a href="graficatipoayuda/fk_tipo_ayuda_tecnica/' . $fila['fk_tipo_ayuda_tecnica'] . '/opc/2">' . $fila['descripcion'] . '</a></td><td style="text-align: center;">' . $fila['count'] . '</td></tr>';
                    array_push($datos, array('' . $fila['count'] . ' ', $fila['count']));

                    array_push($datos_leyenda, array($fila['descripcion']));
                    array_push($total, $fila['count']);
                }
                $total_final = array_sum($total);
                $html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>' . $total_final . '</b></td></tr>';
                $html_status.= '</table>';

                $this->render('/graficas/grafica_tipo_ayuda', array(
                    'total_final' => $total_final,
                    'datos' => $datos,
                    'html_status' => $html_status,
                    'datos_leyenda' => $datos_leyenda,
                    'titulo' => ' Tipos de ayuda',
                    'subtitulo' => '',
                    'titulo_grafica' => 'Cantidad de Solicitudes Por tipo de Ayuda  '
                ));
            } else { // es tipo de ayuda economica
                $sql = "   SELECT sol.fk_tipo_ayuda_economica, ms.descripcion,
                  COUNT(sol.id_solicitud) as solicitudes
                  FROM solicitud sol
                  JOIN maestro ms ON ms.id_maestro = sol.fk_tipo_ayuda_economica
                  WHERE fk_tipo_solicitud =" . $_GET['fk_tipo_solicitud'] . " -- fk_tipo_solicitud para ayudas económicas
                  GROUP BY sol.fk_tipo_ayuda_economica, ms.descripcion";

                $row = Yii::app()->db->createCommand($sql)->queryAll();
                $datos = array();
                $datos_leyenda = array();
                $total = array();

                $html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
                            <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Municipio</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';
                foreach ($row as $fila) {
                    $html_status.= '<tr><td><a href="graficatipoayuda/fk_tipo_ayuda_economica/' . $fila['fk_tipo_ayuda_economica'] . '/opc/2">' . $fila['descripcion'] . '</a></td><td style="text-align: center;">' . $fila['solicitudes'] . '</td></tr>';
                    array_push($datos, array('' . $fila['solicitudes'] . ' ', $fila['solicitudes']));

                    array_push($datos_leyenda, array($fila['descripcion']));
                    array_push($total, $fila['solicitudes']);
                }
                $total_final = array_sum($total);
                $html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>' . $total_final . '</b></td></tr>';
                $html_status.= '</table>';

                $this->render('/graficas/grafica_tipo_ayuda', array(
                    'total_final' => $total_final,
                    'datos' => $datos,
                    'html_status' => $html_status,
                    'datos_leyenda' => $datos_leyenda,
                    'titulo' => 'Tipos de ayuda',
                    'titulo_grafica' => 'Cantidad de Solicitudes Por tipo de Ayuda',
                     'subtitulo' => '',
                ));
            }
        }
    }

}
