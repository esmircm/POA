<?php

class GraficasinformegestionController extends Controller {
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

    public function actionGestion() {
        if (!isset($_REQUEST['opc'])) {

            $sql = " SELECT *
                      FROM  fn_grafica_anhio_solicitud()";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficagestion', array('anual' => $fila['anio'], 'opc' => 2)) . '">' . $fila['anio'] . '</a>'));
                array_push($datos, (int) $fila['cantidad']);
            }
            $total_final = array_sum($datos);

            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'tipo' => 'bar',
                'reversed' => false,
                'colores' => array('#FF00FF', '#3CB371', '#CD853F ', '#4682B4 ', '#4169E1 ', '#708090 ', '#FF6347 ', '#FF8C00 ', '#6A5ACD ', '#32CD32 ', '#00FF00', '#CD5C5C', '#9932CC', '#8A2BE2 ', '#FF1493', '#B8860B', '#D2691E', '#008B8B ', '#696969', '#6B8E23', '#2E8B57,', '#008080'),
                'subtitulo' => 'anual',
                'titulo_grafica' => 'Cantidad de Solicitudes por tipo de Ayuda'
            ));
        } else if ($_REQUEST['opc'] == 2) {

            $sql = " select mes.descripcion as meses, mes.descripcion2 as mesnum,
           COALESCE ((SELECT count(sol.id_solicitud) as cantidad
           FROM solicitud sol
           WHERE extract(YEAR FROM sol.created_date)= " . $_REQUEST['anual'] . "
           AND extract(MONTH FROM sol.created_date)= mes.descripcion2
           GROUP BY extract(MONTH FROM sol.created_date)),0) as cantidad
           from maestro mes
           where mes.padre=161
           order by id_maestro";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficagestion', array('meses' => $fila['mesnum'], 'anio' => $_REQUEST['anual'], 'opc' => 3)) . '">' . $fila['meses'] . '</a>'));

                array_push($datos, (int) $fila['cantidad']);
            }

            $total_final = array_sum($datos);
            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'tipo' => 'line',
                'reversed' => false,
                'colores' => array(' #F4A460', '#FFD700 ', '#00FA9A', '#BDB76B', '#6495ED', '#FF69B4', '#E9967A', '#00CED1', '#00FF7F', '#F08080', '#BC8F8F', '#FA8072'),
                'subtitulo' => 'año ' . $_REQUEST['anual'],
                'titulo_grafica' => 'Cantidad de Solicitudes por tipo de Ayuda'
            ));
        } else if ($_REQUEST['opc'] == 3) {

            $sql = "SELECT ms.id_maestro as mecanismo, ms.descripcion as recepcion,
                    COALESCE ((SELECT count(sol.id_solicitud)
                    FROM solicitud sol WHERE ms.id_maestro = sol.fk_mecanismo_recepcion
                    AND extract(YEAR FROM sol.created_date)= " . $_REQUEST['anio'] . "
                    AND extract(MONTH FROM sol.created_date)= " . $_REQUEST['meses'] . "
                    GROUP BY sol.fk_mecanismo_recepcion, ms.descripcion
                    ORDER BY sol.fk_mecanismo_recepcion),0) as solicitudes  
                    FROM maestro ms WHERE ms.padre= 65
                    GROUP BY ms.descripcion, solicitudes, ms.id_maestro
                    ORDER BY ms.descripcion";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficagestion', array('recepcion' => $fila['mecanismo'], 'meses' => $_REQUEST['meses'], 'anio' => $_REQUEST['anio'], 'opc' => 4)) . '">' . $fila['recepcion'] . '</a>'));

                array_push($datos, (int) $fila['solicitudes']);
            }

            $total_final = array_sum($datos);
            $mes = Maestro::model()->findByAttributes(array('descripcion2' => $_REQUEST['meses']));
            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'tipo' => 'column',
                'reversed' => false,
                'colores' => array('#FAF0E6', '#8FBC8F', '#00BFFF', '#DA70D6', '#FAFAD2 ', '#FFFACD', '#F5F5DC', '#E6E6FA', '#FFEFD5', '#FFE4E1', '#FAEBD7', '#FFEBCD', '#FFE4C4', '#AFEEEE', '#FFE4B5', '#DCDCDC', '#FFDAB9', '#FFDEAD', '#EEE8AA', '#F5DEB3', '#B0E0E6', '#7FFFD4', '#D3D3D3', '#FFC0CB'),
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => $_REQUEST['anio'] . ' / ' . $mes->descripcion,
                'titulo_grafica' => 'Cantidad de Recepción por Meses'
            ));
        } else if ($_REQUEST['opc'] == 4) {

            $sql = "select est.cod_estado as estado, est.estado as descripcion,
    coalesce ((select count(sol.id_solicitud) 
    from solicitud sol
    join beneficiario ben on ben.id_beneficiario = sol.fk_beneficiario
    join vsw_sector sec1 on sec1.cod_parroquia = ben.fk_parroquia
    join maestro ms on ms.id_maestro = sol.fk_mecanismo_recepcion
    where extract(year from sol.created_date) = " . $_REQUEST['anio'] . "
    and extract(month from sol.created_date) =" . $_REQUEST['meses'] . "
    and sol.fk_mecanismo_recepcion = " . $_REQUEST['recepcion'] . "
    and sec1.cod_estado = est.cod_estado
    and sol.es_activo
    group by sec1.cod_estado),0) as cantidad
from vsw_sector est
group by est.estado, est.cod_estado
order by est.estado";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficagestion', array('recepcion' => $_REQUEST['recepcion'], 'estado' => $fila['estado'], 'meses' => $_REQUEST['meses'], 'anio' => $_REQUEST['anio'], 'opc' => 5)) . '">' . $fila['descripcion'] . '</a>'));
                array_push($datos, (int) $fila['cantidad']);
            }

            $total_final = array_sum($datos);
            $mes = Maestro::model()->findByAttributes(array('descripcion2' => $_REQUEST['meses']));
            $nomrecepcion = Maestro::model()->findByPk($_REQUEST['recepcion']);
            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'tipo' => 'bar',
                'reversed' => true,
                'colores' => array('#ADD8E6', '#D8BFD8', '#FFB6C1', '#87CEFA', '#98FB98', '#CCCCCC', '#90EE90', '#EE82EE', '#FFFF00', '#40E0D0', '#DEB887', '#ADFF2F', '#D2B48C', '#48D1CC'),
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => $_REQUEST['anio'] . ' / ' . $mes->descripcion . ' / ' . $nomrecepcion->descripcion,
                'titulo_grafica' => 'Recepción por Estado'
            ));
        } else if ($_REQUEST['opc'] == 5) {

            $sql = " SELECT ms.id_maestro as tipo_solicitud, ms.descripcion as descripcion,
       COALESCE ((SELECT count(sol.id_solicitud)
     FROM solicitud sol
    JOIN beneficiario ben on ben.id_beneficiario = sol.fk_beneficiario
     JOIN vsw_sector sec on sec.cod_parroquia = ben.fk_parroquia
       WHERE ms.id_maestro = sol.fk_tipo_solicitud
       AND extract(YEAR FROM sol.created_date)= " . $_REQUEST['anio'] . "
       AND extract(MONTH FROM sol.created_date)=" . $_REQUEST['meses'] . "
       AND sec.cod_estado = " . $_REQUEST['estado'] . "
       AND sol.fk_mecanismo_recepcion = " . $_REQUEST['recepcion'] . "
       GROUP BY sol.fk_tipo_solicitud, ms.descripcion
      ORDER BY sol.fk_tipo_solicitud),0) as solicitudes
   FROM maestro ms
   WHERE ms.padre= 71
   GROUP BY ms.descripcion, solicitudes, ms.id_maestro
    ORDER BY tipo_solicitud";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficagestion', array('solicitud' => $fila['tipo_solicitud'], 'recepcion' => $_REQUEST['recepcion'], 'estado' => $_REQUEST['estado'], 'meses' => $_REQUEST['meses'], 'anio' => $_REQUEST['anio'], 'opc' => 6)) . '">' . $fila['descripcion'] . '</a>'));
                array_push($datos, (int) $fila['solicitudes']);
            }

            $total_final = array_sum($datos);
            $mes = Maestro::model()->findByAttributes(array('descripcion2' => $_REQUEST['meses']));
            $nomrecepcion = Maestro::model()->findByPk($_REQUEST['recepcion']);
            $estado = Tblestado::model()->findByPk($_REQUEST['estado']);

            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'tipo' => 'column',
                'reversed' => false,
                'colores' => array('#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4', '#FFA07A', '#66CDAA ', '#A9A9A9'),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => $_REQUEST['anio'] . ' / ' . $mes->descripcion . ' / ' . $nomrecepcion->descripcion . ' / ' . $estado->strdescripcion,
                'titulo_grafica' => 'Recepción por Estado'
            ));
        } else if ($_REQUEST['opc'] == 6) {

            $sql = "SELECT ms.descripcion as descripcion,
	COALESCE ((
		SELECT count(per.id_persona)
		FROM persona per
		JOIN beneficiario ben on ben.fk_persona = per.id_persona
		JOIN solicitud sol ON sol.fk_beneficiario = ben.id_beneficiario
		JOIN vsw_sector sec on sec.cod_parroquia = ben.fk_parroquia 
		WHERE EXTRACT(YEAR FROM sol.created_date) = " . $_REQUEST['anio'] . "
		AND EXTRACT(MONTH FROM sol.created_date) = " . $_REQUEST['meses'] . "
		AND sec.cod_estado = " . $_REQUEST['estado'] . " 
		AND sol.fk_tipo_solicitud = " . $_REQUEST['solicitud'] . "
		AND sol.fk_mecanismo_recepcion =  " . $_REQUEST['recepcion'] . "
		AND per.fk_sexo = ms.id_maestro),0) AS cantidad
                FROM maestro ms
                WHERE ms.padre= 61 
                GROUP BY descripcion, ms.id_maestro";
//            print_r($sql);exit;
            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            foreach ($row as $fila) {
                array_push($datos_leyenda, array($fila['descripcion']));

                array_push($datos, array($fila['descripcion'] . ': ' . $fila['cantidad'], (int) $fila['cantidad']));
            }


            $total_final = array_sum($datos);
            $mes = Maestro::model()->findByAttributes(array('descripcion2' => $_REQUEST['meses']));
            $nomrecepcion = Maestro::model()->findByPk($_REQUEST['recepcion']);
            $estado = Tblestado::model()->findByPk($_REQUEST['estado']);
            $genero = Maestro::model()->findByPk($_REQUEST['solicitud']);

            $this->render('/graficas/grafica_informe_gestion', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'tipo' => 'pie',
                'reversed' => false,
                'colores' => array('#5138e8', '#c610c8'),
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'subtitulo' => $_REQUEST['anio'] . ' / ' . $mes->descripcion . ' / ' . $nomrecepcion->descripcion . ' / ' . $estado->strdescripcion . ' / ' . $genero->descripcion,
                'titulo_grafica' => 'Ayuda por Genero'
            ));
        }
    }

}
