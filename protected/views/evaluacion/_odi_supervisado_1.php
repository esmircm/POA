

<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
Yii::app()->clientScript->registerScript('_form', "
    $(document).ready(function(){
        $('.numero').numeric();
        $('#Personal_cedula').numeric();         

    });
");
?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

   
        <?php //  echo $form->hiddenField($ver, 'id_persona'); ?>

    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($ver, 'nacionalidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
                    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($ver, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($ver, 'nombres', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($ver, 'apellidos', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($ver, 'cod_nomina', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>

    </div> 

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($ver, 'cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($ver, 'direccion_general', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
</div> 


