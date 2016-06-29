<?php

$this->widget('booster.widgets.TbGridView', array(
        'id' => 'maestro_medidas-grid',
        'type' => 'striped bordered condensed',
        'responsiveTable' => true,
        'enablePagination' => true,
        'ajaxUpdate'=> true,   
        'dataProvider' => $maestro->search_medida(),
//        'filter' => $maestro,
        'columns' => array(
            'descripcion' => array(
                'name' => 'descripcion',
                'header' => 'Unidad de Medida',
                'value' => '$data->descripcion',
            ),
            
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'Acciones',
                'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                'template' => '{editar}{eliminar}',
                'buttons' => array(
                    
                    'editar' => array(
                        'label' => 'Editar Unidad de Medida',
                        'icon' => 'pencil',
                        'size' => 'medium',
//                        'url' => 'Yii::app()->createUrl("poa/view_evaluar", array("id_poa"=>$data->id_poa))',
                    ),
                    
                    'eliminar' => array(
                        'label' => 'Eliminar Unidad de Medida',
                        'icon' => 'trash',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/DeleteMedida", array("id_maestro"=>$data->id_maestro))',
                    ),
                    
                ),
            ),
        ),
    ));

?>

