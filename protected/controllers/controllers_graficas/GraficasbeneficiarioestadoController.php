<?php

class GraficasbeneficiarioestadoController extends Controller {
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
            $sql = " select sec.cod_estado, sec.estado,
                    coalesce(sum(case when sol.fk_beneficiario = ben.id_beneficiario then 1 end),0)as cant_beneficiarios
                    from vsw_sector sec
                    left join beneficiario ben on ben.fk_parroquia = sec.cod_parroquia
                    left join solicitud sol on sol.fk_beneficiario = ben.id_beneficiario
                    left join persona per on per.id_persona = ben.fk_persona
                    group by sec.cod_estado, sec.estado
                    order by sec.estado";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            //$html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
            //               <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Estado</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';

            foreach ($row as $fila) {
                //$html_status.= '<tr><td><a href="grafica_beneficiario/cod_estado/'.$fila['cod_estado'].'/opc/2">'.$fila['estado'].'</a></td><td style="text-align: center;">'.$fila['cant_beneficiarios'].'</td></tr>';
                array_push($datos, array('' . $fila['cant_beneficiarios'] . ' ', $fila['cant_beneficiarios']));
                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficabeneficiarioestado', array('cod_estado' => $fila['cod_estado'], 'opc' => 2)) . '">' . $fila['estado'] . '</a>'));
                array_push($total, $fila['cant_beneficiarios']);
            }
            $total_final = array_sum($total);
// 
            ///$html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>'.$total_final.'</b></td></tr>';
            //$html_status.= '</table>';

            $this->render('/graficas/grafica_beneficiario_estado', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'alto' => (count($row) * 25),
                'datos_leyenda' => $datos_leyenda,
                'titulo' => 'Cantidad de Beneficiario',
                'subtitulo' => 'Venezuela ',
                'titulo_grafica' => 'Beneficiarios '
            ));
        } else if ($_REQUEST['opc'] == 2) {
            //BUSQUEDA POR MUNICIPIO    
            $sql = "select sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio,
            coalesce(sum(case when sol.fk_beneficiario = ben.id_beneficiario then 1 end),0)as cant_beneficiarios
            from vsw_sector sec
            left join beneficiario ben on ben.fk_parroquia = sec.cod_parroquia
            left join solicitud sol on sol.fk_beneficiario = ben.id_beneficiario
            left join persona per on per.id_persona = ben.fk_persona
            where sec.cod_estado=" . $_GET['cod_estado'] . " -- Codigo del Estado
            group by sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio
            order by sec.estado";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            $html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
                            <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Municipio</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';
            foreach ($row as $fila) {
                $html_status.= '<tr><td><a href="graficabeneficiarioestado/cod_municipio/' . $fila['cod_municipio'] . '/opc/2">' . $fila['municipio'] . '</a></td><td style="text-align: center;">' . $fila['cant_beneficiarios'] . '</td></tr>';
                array_push($datos, array('' . $fila['cant_beneficiarios'] . ' ', $fila['cant_beneficiarios']));
                // array_push($datos_leyenda, array('<a href="' .$this->createUrl('ConsejosComunalesRegistrado',array('cod_anual'=>$fila['periodo'])).'/opc/2">'.'</a>', $fila['periodo'] ));

                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficabeneficiarioestado', array('cod_estado' => $fila['cod_estado'], 'cod_municipio' => $fila['cod_municipio'], 'opc' => 3)) . '">' . $fila['municipio'] . '</a>'));
                array_push($total, $fila['cant_beneficiarios']);
            }
            $total_final = array_sum($total);
            $html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>' . $total_final . '</b></td></tr>';
            $html_status.= '</table>';

            $this->render('/graficas/grafica_beneficiario_estado', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'html_status' => $html_status,
                // 'alto' => count($row) > 7 ? (count($row) * 30) : 250,
                'datos_leyenda' => $datos_leyenda,
                // 'EstadoId' => $row[0]['cod_municipio'],
                'titulo' => 'Cantidad de Beneficiario',
                'subtitulo' => 'Estado ' . $row[0]['estado'],
                'titulo_grafica' => 'Beneficiarios '
            ));
        } else if ($_REQUEST['opc'] == 3) {
            //BUSQUEDA POR MUNICIPIO    
            $sql = "select sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio, sec.cod_parroquia, sec.parroquia,
                coalesce(sum(case when sol.fk_beneficiario = ben.id_beneficiario then 1 end),0)as cant_beneficiarios
                from vsw_sector sec
                left join beneficiario ben on ben.fk_parroquia = sec.cod_parroquia
                left join solicitud sol on sol.fk_beneficiario = ben.id_beneficiario
                left join persona per on per.id_persona = ben.fk_persona
                where sec.cod_municipio=" . $_GET['cod_municipio'] . " -- Codigo del Municipio
                group by sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio, sec.cod_parroquia, sec.parroquia
                order by sec.parroquia";

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll();

            $datos = array();
            $datos_leyenda = array();
            $total = array();

            $html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
                            <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Municipio</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';
            foreach ($row as $fila) {
                $html_status.= '<tr><td><a href="graficabeneficiarioestado/cod_parroquia/' . $fila['cod_parroquia'] . '/opc/2">' . $fila['parroquia'] . '</a></td><td style="text-align: center;">' . $fila['cant_beneficiarios'] . '</td></tr>';
                array_push($datos, array('' . $fila['cant_beneficiarios'] . ' ', $fila['cant_beneficiarios']));
                // array_push($datos_leyenda, array('<a href="' .$this->createUrl('ConsejosComunalesRegistrado',array('cod_anual'=>$fila['periodo'])).'/opc/2">'.'</a>', $fila['periodo'] ));
                array_push($datos_leyenda, array('<td="' . $this->createUrl('graficabeneficiarioestado', array('cod_estado' => $fila['cod_estado'], 'cod_parroquia' => $fila['cod_parroquia'], 'opc' => 3)) . '">' . $fila['parroquia'] . '</td>'));
                array_push($total, $fila['cant_beneficiarios']);
            }
            $total_final = array_sum($total);
            $html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>' . $total_final . '</b></td></tr>';
            $html_status.= '</table>';

            $this->render('/graficas/grafica_beneficiario_estado', array(
                'total_final' => $total_final,
                'datos' => $datos,
                'html_status' => $html_status,
                // 'alto' => count($row) > 7 ? (count($row) * 30) : 250,
                'datos_leyenda' => $datos_leyenda,
                // 'EstadoId' => $row[0]['cod_parroquia'],
                'titulo' => 'Cantidad de Beneficiario',
                'subtitulo' => 'Estado ' . $row[0]['estado'] . ' - Municipio ' . $row[0]['municipio'],
                'titulo_grafica' => 'Beneficiarios '
            ));





//            
//        } else if ($_REQUEST['opc'] == 3) {
//            //BUSQUEDA POR MUNICIPIO    
////            var_dump($_GET['cod_municipio']);Exit;
//            $sql = "  select sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio, sec.cod_parroquia, sec.parroquia,
//                    coalesce(sum(case when ben.fk_sector = sec.cod_sector then 1 end),0)as cant_beneficiarios
//                    from vsw_sector sec
//                    left join beneficiario ben on ben.fk_sector = sec.cod_sector
//                    where sec.cod_municipio=" . $_GET['cod_municipio'] . " -- Codigo del Municipio
//                    group by sec.cod_estado, sec.estado, sec.cod_municipio, sec.municipio, sec.cod_parroquia, sec.parroquia
//                    order by sec.parroquia  ";
//
//            $connection = Yii::app()->db;
//            $command = $connection->createCommand($sql);
//            $row = $command->queryAll();
//
//            $datos = array();
//            $datos_leyenda = array();
//            $total = array();
//
//            $html_status = '<table border="1" style=" width: 100%;font-size:14px;background-color:#F9F9F9;text-align:center;border-bottom:1px solid #AAAAAA;border-collapse:collapse;margin: 1em 1em 1em 0;">
//                            <tr style ="border-bottom:1px solid #AAAAAA; text-align:center "><td style="text-align:center"><b>Parroquias</b></td><td style="text-align:center"><b>Unidad Ejecutiva</b></td></tr>';
//            foreach ($row as $fila) {
//
//                $html_status.= '<tr><td><a href="graficabeneficiarioestado/cod_parroquia/' . $fila['cod_parroquia'] . '/opc/3">' . $fila['municipio'] . '</a></td><td style="text-align: center;">' . $fila['cant_beneficiarios'] . '</td></tr>';
//                array_push($datos, array('' . $fila['cant_beneficiarios'] . ' ', $fila['cant_beneficiarios']));
//                // array_push($datos_leyenda, array('<a href="' .$this->createUrl('ConsejosComunalesRegistrado',array('cod_anual'=>$fila['periodo'])).'/opc/2">'.'</a>', $fila['periodo'] ));
//
//                array_push($datos_leyenda, array('<a href="' . $this->createUrl('graficabeneficiarioestado', array('cod_estado' => $fila['cod_estado'], 'cod_parroquia' => $fila['cod_parroquia'], 'opc' => 3)) . '">' . $fila['municipio'] . '</a>'));
//                //   array_push($total, $fila['cant_beneficiarios']);
//            }
//            $total_final = array_sum($total);
//            $html_status.= '<tr><td><b>Total</b></td><td style="text-align: center;"><b>' . $total_final . '</b></td></tr>';
//            $html_status.= '</table>';
//
        }
    }

}
