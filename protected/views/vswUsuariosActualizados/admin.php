

<center><h1>Listado de Usuarios Actualizados</h1></center>

<?php

function Consultar($id, $caso) {
    $caso = 'se_activa_'.$caso;
    $resultado = Historico::model()->findByAttributes(array('id_personal'=>$id, $caso =>FALSE));
    if (empty($resultado)) {
        return false;
    } else {
        return true;
    }
}
?>

<?php
$this->widget('booster.widgets.TbGridView', array(
    'id' => 'vsw-usuarios-actualizados-grid',
    'type' => 'striped bordered condensed',
    'responsiveTable' => true,
    'dataProvider' => $model->search(),
    'filter' => $model,
    'columns' => array(
        'id_personal' => array(
            'name' => 'id_personal',
            'value' => '$data->id_personal',
        ),
        'cedula' => array(
            'header' => 'Cédula',
            'name' => 'cedula',
            'value' => '$data->cedula',
        ),
        'primer_nombre' => array(
            'header' => 'Nombre',
            'name' => 'primer_nombre',
            'value' => '$data->primer_nombre',
        ),
        'primer_apellido' => array(
            'header' => 'Apellido',
            'name' => 'primer_apellido',
            'value' => '$data->primer_apellido',
        ),
        'porcentaje' => array(
            'header' => 'Porcentaje',
            'name' => 'porcentaje',
            'value' => '$data->porcentaje',
        ),
        'fecha' => array(
            'header' => 'Fecha de Registro',
            'name' => 'fecha',
            'value' => '$data->fecha',
//            'asc' => 'fecha',
        ),
        array(
            'class' => 'booster.widgets.TbButtonColumn',
            'header' => 'Acciones',
            'htmlOptions' => array('width' => '85', 'style' => 'text-align: center;'),
            'template' => '{personal}{educacion}{familiar}',
            'buttons' => array(
                'personal' => array(
                    'label' => 'Persona',
                    'icon' => 'edit',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("/VswUsuariosActualizados/Historico", array("id"=>$data->id_personal, "caso"=>1))',
                    'click'=>'function(){if(confirm("¿Esta seguro de que desea Activar la actualización nuevamente?")== true){$(this).attr("href")}else{return false;};}',
                    'visible'=>'Consultar($data->id_personal,1 )'
                ),
                'educacion' => array(
                    'label' => 'Educación',
                    'icon' => 'edit',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("/VswUsuariosActualizados/Historico", array("id"=>$data->id_personal, "caso"=>2))',
                    'click'=>'function(){if(confirm("¿Esta seguro de que desea Activar la actualización nuevamente?")== true){$(this).attr("href")}else{return false;};}',
                    'visible'=>'Consultar($data->id_personal,2 )'
                ),
                'familiar' => array(
                    'label' => 'Familiar',
                    'icon' => 'edit',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("/VswUsuariosActualizados/Historico", array("id"=>$data->id_personal, "caso"=>3))',
                    'click'=>'function(){if(confirm("¿Esta seguro de que desea Activar la actualización nuevamente?")== true){$(this).attr("href")}else{return false;};}',
                    'visible'=>'Consultar($data->id_personal,3 )'
                ),
            ),
        ),
    ),
));
?>

