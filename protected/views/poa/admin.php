<?php
$this->breadcrumbs=array(
	'Poa',
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
        'dataProvider' => $admin->search_planificacion(54, 52),
        'columns' => array(
            'nombre' => array(
                'name' => 'nombre',
                'header' => 'Plan Operativo Anual',
                'value' => '$data->nombre',
            ),
            'tipo_poa' => array(
                'name' => 'tipo_poa',
                'header' => 'TIPO POA',
                'value' => '$data->tipo_poa',
            ),
            'dependencia_cruge' => array(
                'name' => 'dependencia_cruge',
                'header' => 'Oficina',
                'value' => '$data->dependencia_cruge',
            ),
            'descripcion' => array(
                'name' => 'descripcion',
                'header' => 'Estatus del POA',
                'value' => '$data->descripcion',
            ),
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'Acciones',
                'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                'template' => '{ver}{graficar}{graficar_proyecto}',
                'buttons' => array(
                    
                    'ver' => array(
                        'label' => 'Ver Plan Operativo Anual',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/view_evaluar", array("id_poa"=>$data->id_poa))',
                        'visible' => '($data->fk_estatus_poa == "54") ? true : false;',
                    ),
                    
                    'graficar' => array(
                        'label' => 'Ver Rendimiento POA',
                        'icon' => 'glyphicon glyphicon-stats',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("graficas/GraficaAcciones", array("id_poa"=>$data->id_poa, "tipo"=>$data->fk_tipo_poa))',
                        'visible' => '(($data->fk_estatus_poa == "52") && ($data->fk_tipo_poa == "71")) ? true : false;',
                    ),
                    
                    'graficar_proyecto' => array(
                        'label' => 'Ver Rendimiento POA',
                        'icon' => 'glyphicon glyphicon-stats',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("graficas/GraficaAccionesProyecto", array("id_poa"=>$data->id_poa, "tipo"=>$data->fk_tipo_poa))',
                        'visible' => '(($data->fk_estatus_poa == "52") && ($data->fk_tipo_poa == "70")) ? true : false;',
                    )
                ),
            ),
        ),
    ));
?>
</div>