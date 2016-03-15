<?php
$this->breadcrumbs=array(
	'Proyectos',
);

?>

<div class="span-proyecto">
<h1 style="border-bottom: 1px solid #dddddd; margin-bottom: 20px;">SISTEMA DE GESTIÓN DE ACCIÓN CENTRALIZADA Y PLANES OPERATIVOS ANUALES</h1>
<h1 style="margin-bottom: 20px; font-size: 26px;">LISTADO DE PLANES OPERATIVOS ANUALES</h1>
<?php
    $this->widget('booster.widgets.TbGridView', array(
        'id' => 'vsw-listar-personas-grid',
        'type' => 'striped bordered condensed',
        'responsiveTable' => true,
        'filter' => $admin,
        'dataProvider' => $admin->search_planificacion(54),
        'columns' => array(
            'nombre_proyecto' => array(
                'name' => 'nombre_proyecto',
                'header' => 'Proyecto',
                'value' => '$data->nombre_proyecto',
            ),
            'dependencia_cruge' => array(
                'name' => 'dependencia_cruge',
                'header' => 'Oficina',
                'value' => '$data->dependencia_cruge',
            ),
            'descripcion' => array(
                'name' => 'descripcion',
                'header' => 'Estatus del Proyecto',
                'value' => '$data->descripcion',
            ),
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'Acciones',
                'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                'template' => '{ver}',
                'buttons' => array(
                    
                    'ver' => array(
                        'label' => 'Ver Plan Operativo Anual',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("proyecto/view_evaluar", array("id_proyecto"=>$data->id_proyecto))',
                        'visible' => '($data->fk_estatus_proyecto == "54") ? true : false;',
                    ),
                ),
            ),
        ),
    ));
?>
</div>