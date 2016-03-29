<?php
$this->breadcrumbs=array(
	'Poas',
);

$s = 0;
if($cruge_cargo->value == 1 || $cruge_cargo->value == 2 || $cruge_cargo->value == 4 || $cruge_cargo->value == 5){
    $s = 1;
}
?>

<div class="span-proyecto">
    <h1 style="border-bottom: 1px solid #dddddd; margin-bottom: 20px;">SISTEMA DE GESTIÓN DE PROYECTOS Y ACCIÓN CENTRALIZADA</h1>
    <h1 style="margin-bottom: 20px; font-size: 26px;"><?php echo $dependencia; ?></h1>
    
    <div class="button-proyecto" id="button-proyecto" onclick="window.location='<?php echo Yii::app()->createUrl("poa/create/tipo/70"); ?>';">
        <div class="button-img" style="background-image: url('<?php echo Yii::app()->request->baseUrl;?>/img/button3.jpg');">
        </div>
        <div style="display: block;">
            <h6>CREAR PROYECTO</h6>
            <h1><?php echo $anio_pro;?></h1>
        </div>
    </div>
    
    
    <div class="button-proyecto" id="button-proyecto" onclick="window.location='<?php echo Yii::app()->createUrl("poa/create/tipo/71"); ?>';">
        <div class="button-img" style="background-image: url('<?php echo Yii::app()->request->baseUrl;?>/img/button2.jpg');">
        </div>
        <div style="display: block;">
            <h6>CREAR ACCIÓN CENTRALIZADA</h6>
            <h1><?php echo $anio_acc;?></h1>
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
            'nombre' => array(
                'name' => 'nombre',
                'header' => 'PLAN OPERATIVO ANUAL',
                'value' => '$data->nombre',
            ),
           'tipo_poa' => array(
                'name' => 'tipo_poa',
                'header' => 'TIPO POA',
                'value' => '$data->tipo_poa',
            ),
            'dependencia_cruge' => array(
                'name' => 'dependencia_cruge',
                'header' => 'OFICINA',
                'value' => '$data->dependencia_cruge',
            ),
            'descripcion' => array(
                'name' => 'descripcion',
                'header' => 'ESTATUS POA',
                'value' => '$data->descripcion',
            ),
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'ACCIONES',
                'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                'template' => '{continuar}{ver}{editar}{rendimiento}',
                'buttons' => array(
                    'continuar' => array(
                        'label' => 'Continuar POA',
                        'icon' => 'play',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/create_accion", array("id_poa"=>$data->id_poa, "tipo"=>$data->fk_tipo_poa))',
                        'visible' => '($data->fk_estatus_poa == "50") ? true : false;',
                    ),
                    'ver' => array(
                        'label' => 'Ver Plan Operativo Anual',
                        'icon' => 'eye-open',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/view_evaluar", array("id_poa"=>$data->id_poa))',
                        'visible' => '($data->fk_estatus_poa == "51" && ' . $s . ' == 1) ? true : false;',
                    ),
                    'editar' => array(
                        'label' => 'Editar Plan Operativo Anual',
                        'icon' => 'pencil',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/update", array("id_poa"=>$data->id_poa))',
                        'visible' => '($data->fk_estatus_poa == "55") ? true : false;',
                    ),
		    'rendimiento' => array(
                        'label' => 'Rendimiento',
                        'icon' => 'pencil',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("poa/rendimiento", array("id_poa"=>$data->id_poa))',
                        'visible' => '($data->fk_estatus_poa == "52") ? true : false;',
                    ),
                    'reportes' => array(
                        'label' => 'Generar PDF',
                        'icon' => 'file',
                        'size'=> 'medium',
                        
                        
                        
                    )
                ),
            ),
        ),
    ));
?>
</div>
