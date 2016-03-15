<?php 
$this->breadcrumbs=array(
	'Personas'=>array('index'),
	'Create',
);

//$sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
//$connection = Yii::app()->db;
//$command = $connection->createCommand($sql);
//$row = $command->queryAll();
//$idUser = $row[0]["iduser"];
//$idP = $row[0]["id_persona"];

//
//$this->menu=array(
//array('label'=>'List Persona','url'=>array('index')),
//array('label'=>'Manage Persona','url'=>array('admin')),
//);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion1.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion_evaluacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

Yii::app()->clientScript->registerScript('odi', "
//$(document).ready(function() {u
//        $('input:submit').click(function() { return false; });
//}
");

  
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

<div class="span-20">
<?php
//Calificacion Final Obreros
if(isset($rango_act)) {
    $this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Resumen de la Evaluación',
    'context' => 'primary',
    'headerIcon' => 'glyphicon glyphicon-align-justify',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
    'content' => $this->renderPartial('_obreros_calificacion', array('form' => $form, 'rango_act' => $rango_act, 'total_puntuacion' => $total_puntuacion, 'evaluacion_vista' => $evaluacion_vista, 'model' => $model), TRUE),
        )
    );
?>
</div>
<div style="text-align: center">
<?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'icon' => 'glyphicon glyphicon-floppy-disk',
        'size' => 'large',
        'context' => 'danger',
        'label' => $model->isNewRecord ? 'Guardar' : 'Save',
    ));
    ?>
</div>
<?php 
}
else {
    
?>

<div class="span-20">
<?php
//        var_dump($fk_tipo_clase);die;
//Objetivos Obreros


$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Factores Evaluados',
    'context' => 'primary',
    'headerIcon' => 'glyphicon glyphicon-lis',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
    'content' => $this->renderPartial('_objetivos_obrero', array('form' => $form, 'preobre' => $preobre, 'pre_status' => $pre_status, 'fk_tipo_clase' => $fk_tipo_clase, 'evaluacion_vista' => $evaluacion_vista), TRUE),
        )
);
?>
</div>
<div class="span-20">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'context' => 'primary',
        'htmlOptions' => array('style' => 'display: block; margin: auto;'),
        'label' => $model->isNewRecord ? 'Guardar' : 'Save',
    ));
    ?>
</div>
<?php 
}
?>
<?php $this->endWidget(); ?>
