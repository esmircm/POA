<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	$model->id_proyecto,
);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'personal-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
));

?>
<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; margin-left: -50px; bottom: -5%;">
        <span class="glyphicon glyphicon-user" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
        
            <?php
            echo $this->renderPartial('_view_responsable', array('model' => $model, 'form' => $form), TRUE);
            ?>
    </div>
</div>

<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; margin-left: -50px; bottom: -5%;">
        <span class="glyphicon glyphicon-briefcase" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
            <?php
            echo $this->renderPartial('_view_proyecto', array('model' => $model, 'form' => $form), TRUE);
       
            ?>
    </div>
</div>
<div class="span-20 poa_content">
    <h2 style="text-align: center; font-size: 20px;">LISTADO DE ACCIONES Y ACTIVIDADES</h2>
    <div class="col-lg-12">

<?php

$this->widget('booster.widgets.TbExtendedGridView', array(
    'type'=>'striped bordered',
    'htmlOptions' => array('style' => 'margin-bottom: 40px;;'),
    'dataProvider' => $accion->searchAccion($id_proyecto),
    'template' => "{items}",
    'columns' => array_merge(array(
        
        array(
            'class'=>'booster.widgets.TbRelationalColumn',
            'name' => 'nombre_accion',
            'header' => 'Acción',
            'url' => $this->createUrl('proyecto/view_accion'),
            'value'=> '$data->nombre_accion',
        ),
        
        'bien_servicio' => array (
            'name' => 'bien_servicio',
            'header' => 'Bien o Servicio',
            'value' => '$data->bien_servicio'
        ),
        
        'fk_unidad_medida' => array (
            'name' => 'fk_unidad_medida',
            'header' => 'Unidad de Medida',
            'value' => '$data->search_unidad_medida($data->id_accion)'
        ),
        
        'cantidad' => array (
            'name' => 'cantidad',
            'header' => 'Cantidad',
            'value' => '$data->cantidad'
        )
        
    )),
));

?>
    </div>
</div>

<div class="span-20" style="margin: 0 auto; width: 90%; max-width: 2000px;">
    <?php
    
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Comentarios',
        'context' => 'primary',
        'headerIcon' => 'glyphicon glyphicon-comment',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
        'content' => $this->renderPartial('_comentarios', array('id_proyecto' => $id_proyecto, 'estatus_proyecto' => $estatus_proyecto, 'comentarios' => $comentarios, 'form' => $form), TRUE),
        'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),
            )
    );
    
    ?>
</div>

<div class="pull-right">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'icon' => 'glyphicon glyphicon-floppy-save',
        'size' => 'large',
        'context' => 'primary',
        'label' => $estatus_proyecto->isNewRecord ? 'Guardar' : 'Save',
    ));
    ?>
</div>
<?php $this->endWidget(); ?>

