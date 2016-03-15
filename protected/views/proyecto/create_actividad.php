<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	'Create_Actividad',
);

//$this->menu=array(
//array('label'=>'List Proyecto','url'=>array('index')),
//array('label'=>'Manage Proyecto','url'=>array('admin')),
//);
$Validaciones = Yii::app()->getClientScript()->registerScriptFile(Yii::app()->baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile(Yii::app()->baseUrl . '/js/js_jquery.numeric.js');

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
<div class="span-20 poa_content" style="box-shadow: none; border-bottom: solid 1px;">
    
    <div style="position: absolute; z-index: 1; bottom: -200%;">
        <span style="font-size: 200px; opacity: 0.2;">Proyecto</span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $proyecto->proyecto;
    ?>
    </div>
</div>
<div class="span-20 poa_content" style="box-shadow: none; border-bottom: solid 1px;">
    
    <div style="position: absolute; z-index: 1; bottom: -40%;">
        <span style="font-size: 200px; opacity: 0.2;">Acción</span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; margin-top: 50px;">
    <?php
        echo $form->textFieldGroup($accion, 'nombre_accion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
        echo $form->textFieldGroup($accion, 'unidad_medida', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
        echo $form->textFieldGroup($accion, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
    ?>
    </div>
</div>
<h3 class="text-danger text-center"></br>Formulación de las Actividades para la Acción</h3>
<div class="span-20" >
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Actividad',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_actividad', array('actividad' => $actividad, 'id_accion' => $id_accion, 'form' => $form), TRUE),
            )
    );
    ?>
</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Lista de Actividades',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_lista_actividades', array('actividad' => $actividad, 'id_accion' => $id_accion, 'lista_actividad' => $lista_actividad, 'form' => $form), TRUE),
            )
    );
    ?>
</div>
<div class="pull-left">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'link',
        'icon' => 'glyphicon glyphicon-chevron-left',
        'size' => 'large',
        'context' => 'primary',
        'url' => Yii::app()->createUrl("proyecto/create_accion", array('id_proyecto' => $id_proyecto)),
        'label' => $actividad->isNewRecord ? 'Agregar Acción' : 'Save',
    ));
?>
</div>

<?php $this->endWidget(); ?>