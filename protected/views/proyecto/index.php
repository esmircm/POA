<?php
$this->breadcrumbs=array(
	'Proyectos',
);

$s = 0;
if($cruge_cargo->value == 1 || $cruge_cargo->value == 2 || $cruge_cargo->value == 4 || $cruge_cargo->value == 5){
    $s = 1;
}
?>

<div class="span-proyecto">
    <h1 style="border-bottom: 1px solid #dddddd; margin-bottom: 20px;">SISTEMA DE GESTIÓN DE ACCIÓN CENTRALIZADA Y PLANES OPERATIVOS ANUALES</h1>
    <h1 style="margin-bottom: 20px; font-size: 26px;"><?php echo $dependencia->dependencia; ?></h1>
    <div class="button-proyecto" id="button-proyecto" onclick="window.location='<?php echo Yii::app()->createUrl("proyecto/create"); ?>';">
        <div class="button-img" style="background-image: url('<?php echo Yii::app()->request->baseUrl;?>/img/button2.jpg');">
        </div>
        <div style="display: block;">
            <h6>Crear Proyecto Operativo Anual</h6>
            <h1><?php echo date('Y') + 1;?></h1>
        </div>
    </div>

<?php
    $this->widget('booster.widgets.TbGridView', array(
        'id' => 'vsw-listar-personas-grid',
        'type' => 'striped bordered condensed',
        'responsiveTable' => true,
        'filter' => $admin,
        'dataProvider' => $admin->search_admin($cruge_dependencia->value),
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
                'template' => '{continuar}{ver}{editar}',
                'buttons' => array(
                    'continuar' => array(
                        'label' => 'Continuar Proyecto',
                        'icon' => 'play',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("proyecto/create_accion", array("id_proyecto"=>$data->id_proyecto))',
                        'visible' => '($data->fk_estatus_proyecto == "50") ? true : false;',
                    ),
                    'ver' => array(
                        'label' => 'Ver Plan Operativo Anual',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("proyecto/view_evaluar", array("id_proyecto"=>$data->id_proyecto))',
                        'visible' => '($data->fk_estatus_proyecto == "51" && ' . $s . ' == 1) ? true : false;',
                    ),
                    'editar' => array(
                        'label' => 'Editar Plan Operativo Anual',
                        'icon' => 'pencil',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("proyecto/update", array("id_proyecto"=>$data->id_proyecto))',
                        'visible' => '($data->fk_estatus_proyecto == "55") ? true : false;',
                    ),
                ),
            ),
        ),
    ));
?>
</div>