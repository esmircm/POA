<?php

class GraficasestatusController extends Controller {
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

    public function actionEstatus() {  
//echo "hola"; exit();

        
/*este es la consulta sql*/           

                $sql = " SELECT esol.fk_estatus, ms.descripcion,
            COALESCE (SUM(CASE WHEN esol.fk_solicitud = sol.id_solicitud THEN 1 END),0) as cant_solicitudes
            FROM solicitud sol
            JOIN estatus_solicitud esol ON esol.fk_solicitud = sol.id_solicitud
            JOIN maestro ms ON ms.id_maestro = esol.fk_estatus
            WHERE esol.created_date = (( SELECT max(esol_1.created_date) AS max
            FROM estatus_solicitud esol_1
            JOIN solicitud sol1 ON sol1.id_solicitud = esol_1.fk_solicitud
            WHERE sol1.id_solicitud = sol.id_solicitud))
            GROUP BY esol.fk_estatus, ms.descripcion
            ORDER BY esol.fk_estatus"; 

/*este es la conec con la base de datos confic main*/

            $connection = Yii::app()->db;
            $command = $connection->createCommand($sql);
            $row = $command->queryAll(); // echo '<pre>'; var_dump($row); exit();

/*este es la definicion de las variables a usar en la grafica*/


            $datos_leyenda = array();
            $dato = array();
            $datos1 = array();
            

/*este es el bucle para traer la data*/

            foreach ($row as $fila) {
           
              array_push($datos_leyenda, $fila['descripcion']);
              array_push($dato, array($fila['descripcion'],(int)$fila['cant_solicitudes']));
              array_push($datos1, (int)$fila['cant_solicitudes']);
              
             // array_push($total, $fila['total']);
              
          }

           // echo '<pre>'; var_dump($datos); exit();

           $total_final = array_sum($datos1);  
          
           $this->render('/graficas/grafica_estatus', array(

                                'leyenda' => $datos_leyenda, 
                                'total' => $dato,
                                'datos'  => $total_final,

            ));
 
        }
}


