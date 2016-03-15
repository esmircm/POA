<?php
$this->breadcrumbs=array(
	'Revisions'=>array('index'),
	'Create',
);

//$this->menu=array(
//array('label'=>'List Revision','url'=>array('index')),
//array('label'=>'Manage Revision','url'=>array('admin')),
//);
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

 <h3 class="text-danger text-center"><?php // echo $id_evaluacion; ?>Registro de Fecha de Revisión</h3>

<?php echo $this->renderPartial('_form_revi', array('model'=>$model)); ?>