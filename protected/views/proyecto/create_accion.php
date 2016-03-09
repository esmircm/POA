<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	'Create_Accion',
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
<h3 class="text-danger text-center"></br>Formulación de las Acciones del Proyecto</h3>
<div class="span-20" >
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Acción',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_accion', array('accion' => $accion, 'id_proyecto' => $id_proyecto, 'form' => $form), TRUE),
            )
    );
    ?>
</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Lista de Acciones',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_lista_acciones', array('accion' => $accion, 'id_proyecto' => $id_proyecto, 'lista_accion' => $lista_accion, 'form' => $form), TRUE),
            )
    );
    ?>
</div>
<?php $this->endWidget(); ?>