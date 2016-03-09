<?php $cedula = Yii::app()->getSession()->get('CedulaUser'); ?>
<?php
//$sql2= "select * from evaluacion.vsw_listar_personas";

$sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
$connection = Yii::app()->db;
$command = $connection->createCommand($sql);
$row = $command->queryAll();
$idUser = $row[0]["iduser"];
$idPersona = $row[0]["id_persona"];

$cargo = VswEvaluacion::model()->findByAttributes(array('id_persona' => $idPersona));


if ($idPersona == ''|| $idPersona == 0) {
    echo 'Comuniquese Con el Administrador del sistema';
    die();
} else {

//$cargo = VswCargos::model()->findByAttributes(array('id_persona' => $idPersona));
//
//$Comparar_cargo = VswCargos::model()->findByAttributes(array('id_persona' => $idPersona));
//        var_dump($idPersona);
//        die();
//$idPersona2 = Yii::app()->getSession()->get('idPersona');
//$idUser = Yii::app()->user->id;
//$datousuario = Persona::model()->findByAttributes(array('id_persona' => $idPersona)); //dios
//$cargo = VswCargos::model()->findByAttributes(array('id_persona' => $idPersona));
//$condicion = ' fk_cargo_evaluado > ' . $cargo['fk_cargo'] . ' and ';

    $sw = 0;

    $titulo = "";
//var_dump($cargo); die;

    $evaluar_cargo = stripos($cargo['descripcion_cargo'], 'COORDINADOR');
    if ($evaluar_cargo !== false) {
        $condicion = ' id_persona = ' . $idPersona . ' and id_persona is not null and ';
        $titulo .= $cargo['dependencia'] . '</br>' . $cargo['descripcion_cargo'] . '</br>';
        $condicion = trim($condicion, 'and ');
//    $sw = $sw + 1;
    } else {
        $condicion = " dependencia = '" . $cargo['dependencia'] . "'";
        $titulo .= $cargo['dependencia'];
        $sw = $sw + 1;
    }

//if ($cargo['fk_coordinacion'] != '35') {
//    $condicion .= ' fk_coord_evaluado = ' . $cargo['fk_coordinacion'] . ' and ';
//
//    $sw = $sw + 1;
//    $titulo .= $cargo['coordinacion'].'</br>' ;
////    echo 'coo'.$sw;
//}
//if ($cargo['fk_direccion'] != '17') {
//    $condicion .= ' fk_dir_evaluado = ' . $cargo['fk_direccion'] . ' and ';
//     $sw = $sw + 1;
//     $titulo .= $cargo['direccion'].'</br>' ;
////      echo 'dir'.$sw;
//
//}
//if ($cargo['fk_dir_linea'] != '34') {
//    $condicion .= ' fk_dirlin_evaluado = ' . $cargo['fk_dir_linea'] . ' and ';
//
//     $sw = $sw + 1;
//     $titulo .= $cargo['direccion_linea'].'</br>' ;
////      echo 'dirl'.$sw;
//}
//if ($cargo['fk_despacho'] != '5') {
//    $condicion .= ' fk_despacho_evaluado = ' . $cargo['fk_despacho'] . ' and ';
//     $sw = $sw + 1;
//$titulo .= $cargo['despacho'].'</br>' ;
////      echo 'des'.$sw;
//
//}
//$condicion = trim($condicion, 'and ');
//var_dump($condicion); die;
    ?>

    <center><h1 style="margin-bottom: 40px;">
            LISTADO DE SUPERVISADOS(A)</br> 
    <?php echo $titulo ?></h1></center>
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Crear Evaluación',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_admin_evaluado', array('model' => $model), TRUE),
            )
    );

    $this->widget('booster.widgets.TbGridView', array(
        'id' => 'vsw-listar-personas-grid',
        'type' => 'striped bordered condensed',
        'responsiveTable' => true,
//    'dataProvider' => $sql2->search(),
//    'filter' => $sql2,
        //'dataProvider' => $sql2->search(),
        'filter' => $model,
        'dataProvider' => new CActiveDataProvider('VswListarPersonas', array(
            'criteria' => array(
                'condition' => $condicion,
            ),
            'pagination' => false,
                )),
        'columns' => array(
            'oficina_evaluado' => array(
                'name' => 'oficina_evaluado',
                'header' => 'Oficina',
                'value' => '$data->oficina_evaluado',
            ),
//         'direccion_evaluado' => array(
//            'name' => 'Dirección',
//            'value' => '$data->direccion_evaluado',
//        ),
//         'direccion_linea_evaluado' => array(
//            'name' => 'Dirección línea',
//            'value' => '$data->direccion_linea_evaluado',
//        ),
//           'coordinacion_evaluado' => array(
//            'name' => 'Coordinación',
//            'value' => '$data->coordinacion_evaluado',
//        ),
            'nacionalidad' => array(
                'name' => 'nacionalidad_evaluado',
                'header' => 'Nacionalidad',
                'value' => '$data->nacionalidad_evaluado',
            ),
            'cedula' => array(
                'name' => 'cedula_evaluado',
                'header' => 'Cédula',
                'value' => '$data->cedula_evaluado',
            ),
            'nombres' => array(
                'name' => 'nombres_evaluado',
                'header' => 'Nombres',
                'value' => '$data->nombres_evaluado',
            ),
            'apellidos' => array(
                'name' => 'apellidos_evaluado',
                'header' => 'Apellidos',
                'value' => '$data->apellidos_evaluado',
            ),
            'cargo' => array(
                'name' => 'cargo_evaluado',
                'header' => 'Cargo',
                'value' => '$data->cargo_evaluado',
            ),
            'estatus' => array(
                'name' => 'estatus',
                'header' => 'Estatus',
                'value' => '$data->estatus',
            ),
//        'fk_estatus_evaluacion' => array(
//            'header' => 'Estatus Evaluación',
//            'name' => 'fk_estatus_evaluacion',
//            'value' => '$data->estatus',
//            'filter' => Maestro::FindMaestrosByPadreSelect(46),
//        ),
//          'estatus' => array(
//            'name' => 'estatus',
//            'value' => '$data->estatus',
//        ),
//        array(
//            'name' => 'fecha_evaluacion',
//            'value' => 'Yii::app()->dateFormatter->format("d/M/y", strtotime($data->fecha_evaluacion))',
//            'header' => 'Fecha de la Evaluación ',
//        ),
//        'id_evaluacion' => array(
//            'name' => 'id_evaluacion',
//            'value' => '$data->id_evaluacion',
//        ),
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'Acciones',
                'htmlOptions' => array('width' => '85', 'style' => 'text-align: center;'),
                'template' => '{crearMRL}{editar}{ver}{verRevisado}{exportarCertificado}{enviar}{editarobj}{rango}{pdfevaluacion}{pdfobrero}{registroFechaCertificado}{Eliminar}',
                'buttons' => array(
                    'crearMRL' => array(
                        'label' => 'Crear MRL',
                        'icon' => 'glyphicon glyphicon-hdd',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/odi")',
                        'visible' => '($data->id_evaluacion=="" && $data->fk_tipo_clase!="12") ? true : false;',
                    ),
                    'ver' => array(
                        'label' => 'Ver',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/direditar", array("id"=>$data->id_evaluacion))',
//                    'visible' => '( $data->cant_objetivos >= "3" ' . '&& $data->fk_cargo !=' . $cargo['fk_cargo'] . ' && $data->fk_estatus_evaluacion=="47") ? true : false;',
                        'visible' => '( $data->cant_objetivos >= "3" ' . '&& ' . $sw . '==1' . ' && $data->fk_estatus_evaluacion=="47") ? true : false;',
                    ),
// Aqui edito los objetivos rechasados
                    'editar' => array(
                        'label' => 'Editar',
                        'icon' => 'pencil',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/update", array("id"=> $data["id_evaluacion"]))',
                        'visible' => '($data->fk_estatus_evaluacion=="50" && $data->id_persona ==' . $idPersona . ') ? true : false;',
                    ),
// Aqui edito los objetibos imcompletos en cuanto a cantidad de obj y peso
                    'editarobj' => array(
                        'label' => 'Editar',
                        'icon' => 'pencil',
                        'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("evaluacion/odi", array("id"=>$data->id_persona_evaluado, "idP"=>'.$idPersona.', "idE"=> $data["id_evaluacion"]))',
                        'url' => 'Yii::app()->createUrl("evaluacion/objetivosIncompleto", array("id"=>$data->id_evaluacion))',
                        'visible' => '(($data->peso_total < "50" || $data->cant_objetivos < "3") && ($data->fk_estatus_evaluacion=="47") && ($data->fk_tipo_clase!="11") && ($data->id_persona ==' . $idPersona . ')) ? true : false;',
//                    'visible' => '($data->cant_objetivos < "3" && $data->fk_estatus_evaluacion=="47") ? true : false;',
//                    'visible' => '( $data->fk_estatus_evaluacion!="47") ? true : false;',
                    ),
                    'verRevisado' => array(
                        'label' => 'Ver Revisado',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/direditar", array("id"=>$data->id_evaluacion))',
                        'visible' => '($data->fk_estatus_evaluacion=="79" && $data->fk_cargo !=' . $cargo['fk_cargo'] . ') ? true : false;',
                    ),
                    'exportarCertificado' => array(
                        'label' => 'Exportar Certificado',
                        'icon' => 'glyphicon glyphicon-file',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/certificado/", array("id"=>$data->id_evaluacion))',
                        'options' => array("target" => "_blank"),
                        'visible' => '(($data->fk_estatus_evaluacion=="49")||($data->fk_estatus_evaluacion=="51") && $data->fk_tipo_clase!="11" && $data->fk_cargo ==' . $cargo['fk_cargo'] . ') ? true : false;',

                    ),
                    'enviar' => array(
                        'label' => 'Enviar',
                        'icon' => 'glyphicon glyphicon-log-out',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/enviarodi", array("id"=> $data["id_evaluacion"]))',
                        'visible' => '($data->cant_objetivos >= "3" && $data->fk_estatus_evaluacion=="47" && ' . $sw . '==1) ? true : false;',
                    // 'options' => array("target" => "_blank"),
                    ),
//                'enviarRevisado' => array(
//                    'label' => 'Enviar Revisado MRL',
//                    'icon' => 'glyphicon glyphicon-log-out',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("evaluacion/enviarodi", array("id"=> $data["id_evaluacion"]))',
//                    'visible' => '($data->fk_estatus_evaluacion=="79") ? true : false;',
//                // 'options' => array("target" => "_blank"),
//                ),
                    //Accion para la Fase II: Crear Evaluacion
                    'rango' => array(
                        'label' => 'Crear Evaluación',
                        'icon' => 'glyphicon glyphicon-sort-by-attributes',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/create", array("id"=> $data["id_persona_evaluado"], "idP"=>' . $idPersona . '))',
                        'visible' => '(($data->fk_estatus_evaluacion=="49") && ($data->id_persona ==' . $idPersona .')) ? true : false;', //por asignar condicion
                    ),
//                
//                'evaluacion' => array(
//                    'label' => 'Crear Evaluación',
//                    'icon' => 'glyphicon glyphicon-hdd',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("evaluacion/createobrero", array("id"=> $data["id_persona_evaluado"], "idP"=>'.$idPersona.'))',
//                    'visible' => '($data->id_evaluacion=="" && $data->fk_tipo_clase!="11") ? true : false;', //por asignar condicion
//                ),   
                    'pdfevaluacion' => array(
                        'label' => 'Exportar Evaluación',
                        'icon' => 'glyphicon glyphicon-file',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/PDFevaluacion/", array("id"=>$data->id_persona_evaluado))',
                        'options' => array("target" => "_blank"),
                        'visible' => '($data->fk_estatus_evaluacion=="51" && $data->fk_tipo_clase!="11") ? true : false;',
                    ),
                    'pdfobrero' => array(
                        'label' => 'Evaluación Obrero',
                        'icon' => 'glyphicon glyphicon-file',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/pdfobrero/", array("id"=>$data->id_persona_evaluado))',
                        'options' => array("target" => "_blank"),
                        'visible' => '($data->fk_tipo_clase =="11" && $data->fk_estatus_evaluacion =="51") ? true : false;',
                    ),
                    'registroFechaCertificado' => array(
                        'label' => 'Fecha Certificado',
                        'icon' => 'calendar',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/create_revi/", array("id"=>$data->id_evaluacion))',
                        'options' => array("target" => "_blank"),
                        'visible' => '(($data->fk_estatus_evaluacion=="49")||($data->fk_estatus_evaluacion=="51") && $data->fk_cargo ==' . $cargo['fk_cargo'] . ') ? true : false;',
                    ),
                    'Eliminar' => array(
                    'label' => 'Eliminar Evaluacion',
                    'icon' => 'glyphicon glyphicon-remove',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/eliminareva/", array("id"=>$data->id_evaluacion))',            
                    ),

                ),
            ),
        ),
    ));
    
    /////lol
}

//}
