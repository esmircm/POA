
<center><h1>Listado de Supervisados Dirección</h1></center>

<?php

$this->widget('booster.widgets.TbGridView', array(
    'id' => 'vsw-listar-personas-grid',
    'type' => 'striped bordered condensed',
    'responsiveTable' => true,
    'dataProvider' => new CActiveDataProvider('VswListarPersonas', array(
        'criteria' => array(
            'condition' => 'fk_estatus_evaluacion=48', 
        ),
        'pagination' => false,
            )),
    'columns' => array(
//        'id_persona' => array(
//            'name' => 'id_persona',
//            'value' => '$data->id_persona',
//        ),
        'nacionalidad' => array(
            'name' => 'nacionalidad',
            'value' => '$data->nacionalidad_evaluado',
        ),
        'cedula' => array(
            'name' => 'cedula',
            'value' => '$data->cedula_evaluado',
        ),
        'nombres' => array(
            'name' => 'nombres',
            'value' => '$data->nombres_evaluado',
        ),
        'apellidos' => array(
            'name' => 'apellidos',
            'value' => '$data->apellidos_evaluado',
        ),
//        'cargo' => array(
//            'name' => 'cargo',
//            'value' => '$data->cargo_evaluado',
//        ),
        'estatus' => array(
            'name' => 'estatus',
            'value' => '$data->estatus',
        ),
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
            'template' => '{verificarMRL}',
//            . '{exportarCertificado}{ver}{enviar}',
            'buttons' => array(
//                'registrar' => array(
//                    'label' => 'Registrar',
//                    'icon' => 'glyphicon glyphicon-hdd',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("evaluacion/odi", array("id"=>$data->id_persona_evaluado))',
//                    'visible' => '($data->id_evaluacion=="") ? true : false;',
//                ),
//                'ver' => array(
//                    'label' => 'Ver',
//                    'icon' => 'eye-open',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("VswPdfEvaluacion/update/", array("id"=>$data->id_evaluacion))',
//                       'visible' => '($data->fk_estatus_evaluacion=="49") ? true : false;',
//                ),
                'verificarMRL' => array(
                    'label' => 'Verificar MRL',
                    'icon' => 'pencil',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/rrhheditar", array("id"=> $data["id_evaluacion"]))',
                    'visible' => '($data->fk_estatus_evaluacion=="48") ? true : false;',
                ),
//                'exportarCertificado' => array(
//                    'label' => 'Exportar Certificado',
//                    'icon' => 'glyphicon glyphicon-file',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("evaluacion/certificado/", array("id"=>$data->id_evaluacion))',
//                    'options' => array("target" => "_blank"),
//                    'visible' => '($data->fk_estatus_evaluacion=="49") ? true : false;',
//                ),
//                'enviar' => array(
//                    'label' => 'Enviar',
//                    'icon' => 'glyphicon glyphicon-log-out',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("vswListarPersonas/enviarodi", array("id"=> $data["id_evaluacion"]))',
//                    'visible' => '($data->fk_estatus_evaluacion=="47") ? true : false;',
//                // 'options' => array("target" => "_blank"),
//                ),                
                
            ),
        ),
    ),
));
