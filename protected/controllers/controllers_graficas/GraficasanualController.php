<?php

class GraficasanualController extends Controller {
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

    public function actionAnual() {
        if (!isset($_REQUEST['opc'])) {
            //BUSQUEDA POR ESTADO
            $sql = " SELECT * FROM  fn_grafica_anhio_solicitud()";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();
//            var_dump($row);
//            exit();
            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficaanual', array('anual' => $fila['anio'], 'opc' => 2)) . '">' . $fila['anio'] . '</a>'));
                array_push($datos, (int) $fila['cantidad']);
            }
            $total_final = array_sum($datos);

            $this->render('/graficas/grafica_anual', array(
                'total_final' => $total_final,
                'datos' => $datos,
                // 'html_status' => $html_status,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => 'anual',
                'titulo_grafica' => 'Cantidad de Solicitudes por tipo de Ayuda'
            ));
        } else if ($_REQUEST['opc'] == 2) {
            //BUSQUEDA POR MUNICIPIO   
            $sql = " SELECT ma.descripcion2 as cod_mes, ma.descripcion AS meses,
                    COALESCE ((SELECT count(sol.id_solicitud)
                    FROM solicitud sol
                    WHERE extract(YEAR FROM sol.created_date)= " . $_REQUEST['anual'] . " AND extract(MONTH FROM sol.created_date)=ma.descripcion2::int
                    GROUP BY extract(MONTH FROM sol.created_date)
                    ORDER BY extract(MONTH FROM sol.created_date)),0)AS cantidad
                    FROM maestro ma
                    WHERE ma.padre = 161
                    ORDER BY cod_mes, meses ASC";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();
            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficaanual', array('anual' => $_REQUEST['anual'], 'meses' => $fila['cod_mes'],'opc' => 3 )) . '">' . $fila['meses'] . '</a>'));

//                array_push($datos_leyenda, $fila['meses']);
                array_push($datos, (int) $fila['cantidad']);
            }
            $total_final = array_sum($datos);
            $this->render('/graficas/grafica_anual', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => 'Año' . $_REQUEST['anual'],
                'titulo_grafica' => 'Cantidad de Solicitudes por Tipo de Ayuda'
            ));
        } else if ($_REQUEST['opc'] == 3) {

            $datos = array();
            $datos_leyenda = array();
            $total = array();
            $sql = " SELECT esol.fk_estatus, ms.descripcion as estatus,
                        COALESCE (SUM(CASE WHEN esol.fk_solicitud = sol.id_solicitud THEN 1 END),0) as cant_solicitudes
                        FROM solicitud sol
                        JOIN estatus_solicitud esol ON esol.fk_solicitud = sol.id_solicitud
                        JOIN maestro ms ON ms.id_maestro = esol.fk_estatus
                        WHERE esol.created_date = (( SELECT max (esol_1.created_date) as max
                        FROM estatus_solicitud esol_1
                        JOIN solicitud sol1 ON sol1.id_solicitud = esol_1.fk_solicitud
                        WHERE sol1.id_solicitud = sol.id_solicitud))
                        AND extract(YEAR FROM sol.created_date)= " . $_REQUEST['anual'] . " 
                        AND extract(MONTH FROM sol.created_date)=" . $_REQUEST['meses'] . " 
                        GROUP BY esol.fk_estatus, ms.descripcion
                        ORDER BY esol.fk_estatus";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();
            foreach ($row as $fila) {
                array_push($datos_leyenda, $fila['estatus']);
                array_push($datos, (int) $fila['cant_solicitudes']);
            }
            $total_final = array_sum($datos);
        $this->render('/graficas/grafica_anual', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => 'Mes  ' . $_REQUEST['meses'].'- Año '. $_REQUEST['anual'],
                'titulo_grafica' => 'Cantidad de Solicitudes por Estatus'
            ));
            
            
            }
    }

}
