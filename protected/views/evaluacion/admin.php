<?php $cedula = Yii::app()->getSession()->get('CedulaUser'); ?>
<?php

$sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
$connection = Yii::app()->db;
$command = $connection->createCommand($sql);
$row = $command->queryAll();
$idUser = $row[0]["iduser"];
$idPersona = $row[0]["id_persona"];

$fieldvalue_cargo = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 0));
$fieldvalue_dependencia = CrugeFieldValue::model()->findByAttributes(array('iduser' => $idUser, 'idfield' => 1));
$field = CrugeField::model()->findByAttributes(array('idfield' => 1));
$arOpt = CrugeUtil::explodeOptions($field->predetvalue);

$cargo = VswEvaluacion::model()->findByAttributes(array('id_persona' => $idPersona));

if ($idPersona == ''|| $idPersona == 0) {
  $this->redirect(array('/cruge/ui/login'));
} else {

    $sw = 0;
    $id_persona='';
    $condicion='';
    $condicion2='';
    $titulo = "";

    if(empty($fieldvalue_cargo->value)){
        //Mensaje para aquellos que no tienen Cargo en el Cruge
        echo 'Esta persona no posee Cargo '; die;
    }else{
        
    }
    
    if($fieldvalue_cargo->value==3 || $fieldvalue_cargo->value==6){
        $condicion =   $idPersona;
        $titulo .= $arOpt[$fieldvalue_dependencia->value] . '</br>' . $cargo['descripcion_cargo'] . '</br>';
    }
    else {
        $condicion2 =  $fieldvalue_dependencia->value;
        $titulo .= $arOpt[$fieldvalue_dependencia->value];
        $sw = $sw + 1;
    }

//        if (7 <= 6) {
        if (date('n') <= 6) {
            $fecha_ini = "01-01-" . date('Y') . " 00:00:00";
            $fecha_fin = "30-06-" . date('Y') . " 23:59:59";
        }
//        if (7 >= 7) {
        if (date('n') >= 7) {
            $fecha_ini = "01-07-" . date('Y') . " 00:00:00";
            $fecha_fin = "31-12-" . date('Y') . " 23:59:59";
        }

    ?>

    <center><h1 style="margin-bottom: 40px;">
            LISTADO DE SUPERVISADOS(A)</br> 
    <?php echo $titulo ?></h1></center>
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Metas de Rendimiento Laboral',
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
          'dataProvider' =>$model -> searchlistarAdmin( $condicion, $condicion2, $fecha_ini, $fecha_fin ),
//        'dataProvider' => new CActiveDataProvider('VswListarPersonas', array(
//            'criteria' => array(
//                'condition' => $condicion,
//            ),
//            'pagination' => false,
//                )),
        'columns' => array(
            'dependencia' => array(
                'name' => 'dependencia',
                'header' => 'Oficina',
                'value' => '$data->dependencia',
            ),
            'nacionalidad' => array(
                'name' => 'nacionalidad',
                'header' => 'Nacionalidad',
                'value' => '$data->nacionalidad',
                'htmlOptions' => array('width' => '50'),
            ),
            'cedula' => array(
                'name' => 'cedula',
                'header' => 'Cédula',
                'value' => '$data->cedula',
            ),
            'nombres' => array(
                'name' => 'nombres',
                'header' => 'Nombres',
                'value' => '$data->nombres',
            ),
            'apellidos' => array(
                'name' => 'apellidos',
                'header' => 'Apellidos',
                'value' => '$data->apellidos',
            ),
            'descripcion_cargo' => array(
                'name' => 'descripcion_cargo',
                'header' => 'Cargo',
                'value' => '$data->descripcion_cargo',
            ),
            'estatus' => array(
                'name' => 'estatus',
                'header' => 'Estatus',
                'value' => '$data->estatus',
              //  'filter'=> CHtml::listData(VswListarPersonas::model()->findAll(array('order'=>'estatus')), 'fk_estatus_evaluacion', 'estatus'),
            
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
                'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                'template' => '{editar}{ver}{exportarCertificado}{enviar}{editarobj}{evaluacion}{continuar_obrero}{pdfevaluacion}{pdfobrero}{registroFechaCertificado}{registroFechaCertificado_Recordatorio}',
                'buttons' => array(
                    'ver' => array(
                        'label' => 'Ver',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/direditar", array("id"=>$data->id_evaluacion))',
//                    'visible' => '( $data->cant_objetivos >= "3" ' . '&& $data->fk_cargo !=' . $cargo['fk_cargo'] . ' && $data->fk_estatus_evaluacion=="47") ? true : false;',
//                        'visible' => '( $data->cant_objetivos >= "3" ' . '&& ' . $sw . '==1' . ' && ($data->fk_estatus_evaluacion=="47" || $data->fk_estatus_evaluacion=="79")) ? true : false;',
                        'visible' => '(((PreguntasIndividuales::model()->cantidad_objetivos($data->id_evaluacion))>="3" && (PreguntasIndividuales::model()->suma_peso($data->id_evaluacion)) == "50") && ' . $sw . '==1' . ' && ($data->fk_estatus_evaluacion=="47" || $data->fk_estatus_evaluacion=="79")) ? true : false;',
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
//                        'visible' => '(($data->peso_total < "50" || $data->cant_objetivos < "3") && ($data->fk_estatus_evaluacion=="47") && ($data->fk_tipo_clase!="11")  && ($data->id_persona ==' . $idPersona . ')) ? true : false;',
                        'visible' => '(((PreguntasIndividuales::model()->suma_peso($data->id_evaluacion)) < "50" || (PreguntasIndividuales::model()->cantidad_objetivos($data->id_evaluacion)) < "3") && ($data->fk_estatus_evaluacion=="47") && ($data->fk_tipo_clase!="11")  && ($data->id_persona ==' . $idPersona . ')) ? true : false;',
//                    'visible' => '($data->cant_objetivos < "3" && $data->fk_estatus_evaluacion=="47") ? true : false;',
//                    'visible' => '( $data->fk_estatus_evaluacion!="47") ? true : false;',
                    ),
//                    'verRevisado' => array(
//                        'label' => 'Ver Revisado',
//                        'icon' => 'eye-open',
//                        'size' => 'medium',
//                        'url' => 'Yii::app()->createUrl("evaluacion/direditar", array("id"=>$data->id_evaluacion))',
//                        ///Visible para cuando esté en Aprobado la Evaluación///
////                        'visible' => '($data->fk_estatus_evaluacion=="79" && $data->fk_cargo !=' . $cargo['fk_cargo'] . ') ? true : false;',
//                        'visible' => '($data->fk_estatus_evaluacion=="79") ? true : false;',
//                    ),
                    'exportarCertificado' => array(
                        'label' => 'Exportar Certificado',
                        'icon' => 'glyphicon glyphicon-file',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/certificado/", array("id"=>$data->id_evaluacion))',
                        'options' => array("target" => "_blank"),
                        'visible' => '(($data->fk_estatus_evaluacion=="49")||($data->fk_estatus_evaluacion=="51") && $data->fk_tipo_clase!="11") ? true : false;',

                    ),
                    'enviar' => array(
                        'label' => 'Enviar',
                        'icon' => 'glyphicon glyphicon-log-out',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/enviarodi", array("id"=> $data["id_evaluacion"]))',
//                        'visible' => '($data->cant_objetivos >= "3" && ($data->fk_estatus_evaluacion=="47" || $data->fk_estatus_evaluacion=="79") && ' . $sw . '==1) ? true : false;',
                        'visible' => '(((PreguntasIndividuales::model()->cantidad_objetivos($data->id_evaluacion))>="3" && (PreguntasIndividuales::model()->suma_peso($data->id_evaluacion)) == "50") && ($data->fk_estatus_evaluacion=="47" || $data->fk_estatus_evaluacion=="79") && ' . $sw . '==1) ? true : false;',
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
                    'evaluacion' => array(
                        'label' => 'Crear Evaluación',
                        'icon' => 'glyphicon glyphicon-sort-by-attributes',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/create", array("id"=> $data["id_persona_evaluado"], "idP"=>' . $idPersona . '))',
                        'visible' => '($data->fk_estatus_evaluacion=="49" && ' . $validacion_evaluacion . ' == 1 && $data->id_persona ==' . $idPersona . ') ? true : false;',
//                        'visible' => '($data->fk_estatus_evaluacion=="49" && $data->id_persona ==' . $idPersona . ') ? true : false;',
                    ),
                    //-----Continuar Evaluacion Obreros-----//
                    'continuar_obrero' => array(
                        'label' => 'Continuar Evaluación',
                        'icon' => 'glyphicon glyphicon-sort-by-attributes',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("evaluacion/ObjetivosObrerosIncompleto", array("id"=>$data->id_evaluacion, "fk_tipo_clase"=>$data->fk_tipo_clase))',
                        'visible' => '($data->fk_estatus_evaluacion=="47" && $data->fk_tipo_clase=="11" && $data->id_persona ==' . $idPersona . ') ? true : false;',
                    ),
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
                        'visible' => '((($data->fk_estatus_evaluacion=="49")||($data->fk_estatus_evaluacion=="51")) && $data->id_persona ==' . $idPersona . ' && $data->fk_tipo_clase !="11" && (Revision::model()->validacion_revisiones1($data->id_evaluacion) == "0") ) ? true : false;',
                    ),
                    'registroFechaCertificado_Recordatorio' => array(
                        'label' => 'Fecha Certificado',
                        'icon' => 'calendar',
                        'size' => 'medium',
                        'options'=>array('style'=>'color:#e31313;',),
                        'url' => 'Yii::app()->createUrl("evaluacion/create_revi/", array("id"=>$data->id_evaluacion))',
                        'visible' => '((($data->fk_estatus_evaluacion=="49")||($data->fk_estatus_evaluacion=="51")) && $data->id_persona ==' . $idPersona . ' && $data->fk_tipo_clase !="11" && (Revision::model()->validacion_revisiones2($data->id_evaluacion) == "1") ) ? true : false;',
                    ),
                ),
            ),
        ),
    ));
    

}


