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
        'content' => $this->renderPartial('_lista_actividades', array('actividad' => $actividad, 'id_accion' => $id_accion, 'form' => $form), TRUE),
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
<div class="pull-right">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'link',
        'size' => 'large',
        'context' => 'primary',
        'url' => Yii::app()->createUrl("proyecto/view", array('id_proyecto' => $id_proyecto)),
        'label' => $actividad->isNewRecord ? 'Finalizar' : 'Save',
    ));
?>
</div>
<?php $this->endWidget(); ?>