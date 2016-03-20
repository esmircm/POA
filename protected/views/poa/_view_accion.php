<?php

$this->widget('booster.widgets.TbExtendedGridView', array(
    'type'=>'striped bordered',
    'dataProvider' => $gridDataProvider->searchActividad($id_accion),
    'template' => "{items}",
    'columns' => array(
        'actividad' => array(
            'name' => 'actividad',
            'header' => 'Actividad',
            'value' => '$data->actividad',
        ),
        'unidad_medida' => array(
            'name' => 'unidad_medida',
            'header' => 'Unidad de Medida',
            'value' => '$data->unidad_medida',
        ),
        'cantidad' => array(
            'name' => 'cantidad',
            'header' => 'Cantidad',
            'value' => '$data->cantidad',
        ),
    ),
));

?>

