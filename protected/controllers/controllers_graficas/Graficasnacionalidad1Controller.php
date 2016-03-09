<?php

class Graficasnacionalidad1Controller extends Controller {
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

    public function actionNacionalidad1() {
//echo "hola"; exit();

        /* este es la consulta sql */

        $sql = "SELECT (CASE WHEN nac.descripcion = 'V' THEN 'VENEZOLANO'
                WHEN nac.descripcion = 'E' THEN 'EXTRANJERO' END) as Nacionalidad,
                count(per.id_persona) as total
                FROM persona per
                JOIN maestro nac on nac.id_maestro = per.fk_nacionalidad
                where per.es_activo and per.fk_estatus=22
                GROUP BY nac.descripcion ";

        /* este es la conec con la base de datos confic main */
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

        /* este es la definicion de las variables a usar en la grafica */
        $datos_leyenda = array();
        $dato = array();
        $dato1 = array();

        /* este es el bucle para traer la data */
        foreach ($row as $fila) {
            array_push($dato, array($fila['nacionalidad'] . ': ' . $fila['total'], (int) $fila['total']));
            array_push($dato1, (int) $fila['total']);
        }

        $total_final = array_sum($dato1);

        $this->render('/graficas/grafica_nacionalidad1', array(
            'leyenda' => $datos_leyenda,
            'total' => $dato,
            'datos' => $total_final,
            'subtitulo' => '' . 'Total de Beneficiarios: ' . $total_final,
        ));
    }

}
