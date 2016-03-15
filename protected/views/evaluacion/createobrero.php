<?php
$this->breadcrumbs = array(
    'Personas' => array('index'),
    'Createobrero',
);
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
<?php
    if(isset($evaluacion_vista)) { } else {
?>
<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Periodo Evaluado',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_periodo', array('form' => $form, 'evaluados' => $evaluados), TRUE),
            )
    );
    ?>
    </div>
    
    <h3 class="text-danger text-center">Sección "A": Datos de Identificación</h3>
    <div class="span-20">
    <?php

    $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Evaluador(a) / Supervisor(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisor', array('evaluador' => $evaluador, 'vista' => $vista, 'supeva' => $supeva, 'model' => $model, 'evaluacion' => $evaluacion, 'form' => $form), TRUE),
                )
        );

        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Supervisado(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisado', array('vista' => $vista, 'model' => $model, 'form' => $form), TRUE),
                )
        );
    
        ?>
</div>
<div class="pull-right">
    
        <?php
       
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'submit',
            'icon' => 'glyphicon glyphicon glyphicon-arrow-right',
            'size' => 'large',
            'id' => 'guardar',
            'context' => 'primary',
            'label' => $model->isNewRecord ? 'Siguiente' : 'Save',
        ));
        
        ?>
    
</div>
    <?php }
    if(isset($evaluacion_vista)){
    ?>
    
<div class="span-20">
    <?php
//        var_dump($fk_tipo_clase);die;
    
    
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
    <?php } ?>
<?php $this->endWidget(); ?>
