<?php

class GraficasnacionalidadController extends Controller {
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

    public function actionNacionalidad() {
        //echo "hola"; exit();
        /* este es la consulta sql */

        $sql = "select eval.fk_evaluacion as n_evaluacion, eva.apellidos || ' ' 
       || eva.nombres as evaluador, eva.dependencia as oficina, eva.apellidos_evaluado || ' ' || eva.nombres_evaluado as evaluado, 
count(eval.fk_evaluacion) as rechazos
from evaluacion.estatus_evaluacion eval
JOIN evaluacion.vsw_listar_personas eva ON eva.id_evaluacion = eval.fk_evaluacion 
where eval.fk_estatus_evaluacion = 50 and eval.fk_entidad = 467
group by eval.fk_evaluacion, eva.apellidos, eva.nombres, eva.dependencia, eva.apellidos_evaluado, eva.nombres_evaluado
having count(eval.fk_evaluacion) >=3
order by eval.fk_evaluacion";

        /* este es la conec con la base de datos confic main */
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();
        echo '<pre>'; var_dump($row); exit();

        /* este es la definicion de las variables a usar en la grafica */
        $datos_leyenda = array();
        $dato = array();
        $dato1 = array();

        /* este es el bucle para traer la data */
        foreach ($row as $fila) {
            array_push($datos_leyenda, $fila['evaluado']);
            array_push($dato, array($fila['oficina']));
            array_push($dato1, (int) $fila['rechazos']);
        }

        // echo '<pre>'; var_dump($datos); exit();

        $total_final = array_sum($dato1);

        $this->render('/graficas/grafica_nacionalidad', array(
            'leyenda' => $datos_leyenda,
            'total' => $dato,
            'datos' => $total_final,
            'subtitulo' => '' . 'Total de Rechazados Por RRHH: ' . $total_final,
        ));
    }

}
