
<center><h1>Listado de Supervisados Talento Humano</h1></center>

<?php
if (date('n') <= 6) {
    $fecha_ini = "01-01-" . date('Y') . " 00:00:00";
    $fecha_fin = "30-06-" . date('Y') . " 23:59:59";
}
//        if (7 >= 7) {
if (date('n') >= 7) {
    $fecha_ini = "01-07-" . date('Y') . " 00:00:00";
    $fecha_fin = "31-12-" . date('Y') . " 23:59:59";
}

$this->widget('booster.widgets.TbGridView', array(
    'id' => 'vsw-listar-personas-grid',
    'type' => 'striped bordered condensed',
    'responsiveTable' => true,
    'dataProvider' => $model->searchlistar(48, 108, $fecha_ini, $fecha_fin),
//    'dataProvider' => new CActiveDataProvider('VswListarPersonas', array(
//        'criteria' => array(
//            'condition' => 'fk_estatus_evaluacion=48',
//        ),
//        'pagination' => false,
//            )),
    'filter' => $model,
    'columns' => array(
//  
        'oficina_evaluado' => array(
            'name' => 'oficina_evaluado',
            'header' => 'Oficina',
            'value' => '$data->oficina_evaluado',
        ),
        'nacionalidad' => array(
            'header' => 'Nacionalidad',
            'name' => 'nacionalidad_evaluado',
            'value' => '$data->nacionalidad_evaluado',
            'htmlOptions' => array('width' => '50'),
        ),
        'cedula' => array(
            'header' => 'Cédula',
            'name' => 'cedula_evaluado',
            'value' => '$data->cedula_evaluado',
        ),
        'nombres' => array(
            'header' => 'Nombres',
            'name' => 'nombres_evaluado',
            'value' => '$data->nombres_evaluado',
        ),
        'apellidos' => array(
            'header' => 'Apellidos',
            'name' => 'apellidos_evaluado',
            'value' => '$data->apellidos_evaluado',
        ),
//        'cargo' => array(
//            'name' => 'cargo',
//            'value' => '$data->cargo_evaluado',
//        ),
        'estatus' => array(
            'header' => 'Estatus',
            'name' => 'estatus',
            'value' => '($data->estatus =="ENVIADO" )? "RECIBIDO" : "INCOMPLETO";',
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
            'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
            'template' => '{verificarMRL}{renovarEvaluacion}{Eliminar}',
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
                
                'renovarEvaluacion' =>array(
                    'label' => 'Renovar MRL',
                    'icon' => 'glyphicon glyphicon-refresh',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/RenovarEvaluacion/", array("id"=>$data->id_evaluacion))', 
                    'visible' => '($data->fk_estatus_evaluacion=="108") ? true : false;',
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
