
<center><h1>Listado de Supervisados</h1></center>

<?php

$this->widget('booster.widgets.TbGridView', array(
    'id' => 'vsw-listar-personas-grid',
    'type' => 'striped bordered condensed',
    'responsiveTable' => true,
    'dataProvider' => $model->search(),
    'filter' => $model,
    'columns' => array(
        'id_persona' => array(
            'name' => 'id_persona',
            'value' => '$data->id_persona',
        ),
        'nacionalidad' => array(
            'name' => 'nacionalidad',
            'value' => '$data->nacionalidad',
        ),
        'cedula' => array(
            'name' => 'cedula',
            'value' => '$data->cedula',
        ),
        'nombres' => array(
            'name' => 'nombres',
            'value' => '$data->nombres',
        ),
        'apellidos' => array(
            'name' => 'apellidos',
            'value' => '$data->apellidos',
        ),
        'cargo' => array(
            'name' => 'cargo',
            'value' => '$data->cargo',
        ),
        'estatus' => array(
            'name' => 'estatus',
            'value' => '$data->estatus',
        ),
        array(
            'name' => 'fecha_evaluacion',
            'value' => 'Yii::app()->dateFormatter->format("d/M/y", strtotime($data->fecha_evaluacion))',
            'header' => 'Fecha de la Evaluación ',
        ),
        'id_evaluacion' => array(
            'name' => 'id_evaluacion',
            'value' => '$data->id_evaluacion',
        ),
        array(
            'class' => 'booster.widgets.TbButtonColumn',
            'header' => 'Acciones',
            'htmlOptions' => array('width' => '85', 'style' => 'text-align: center;'),
            'template' => '{registrar}{exportarCertificado}{editar}{ver}',
            'buttons' => array(
                'registrar' => array(
                    'label' => 'Registrar',
                    'icon' => 'glyphicon glyphicon-hdd',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/odi", array("id"=>$data->id_persona))',
                     //'visible' => '(Yii::app()->user->checkAccess("action_asignacionpromotor_buscapromotorasignadoporcodorg")) ? true : false;',
                    'visible' => '($data->id_evaluacion=="") ? true : false;',
                ),
                'ver' => array(
                    'label' => 'Ver',
                    'icon' => 'eye-open',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("VswPdfEvaluacion/create/", array("id"=>$data->id_evaluacion))',
                       'visible' => '($data->fk_estatus_evaluacion=="49") ? true : false;',
                    
                ),
                'exportarCertificado' => array(
                    'label' => 'Exportar Certificado',
                    'icon' => 'glyphicon glyphicon-file',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/certificado/", array("id"=>$data->id_evaluacion))',
                    'options' => array("target" => "_blank"),
                    'visible' => '($data->fk_estatus_evaluacion=="49") ? true : false;',
                ),
                'editar' => array(
                    'label' => 'Editar',
                    'icon' => 'pencil',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("vswPdfEvaluacion/update", array("id"=> $data["id_evaluacion"]))',
                    'visible' => '($data->fk_estatus_evaluacion=="50") ? true : false;',
                // 'options' => array("target" => "_blank"),
                ),
            ),
        ),
    ),
));
