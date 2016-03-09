
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

   
         <?php echo $form->hiddenField($consultaPersona, 'id_persona_evaluado'); ?>
    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'nacionalidad_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($consultaPersona, 'cedula_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readOnly' => true,
                    'maxlength' => 8,
//                    'onblur' => "buscarPersonaSupervisado($(this).val())",  
                )
            )
                )
        );
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'nombres_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'apellidos_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'cod_nomina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>

    </div> 

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'cargo_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'oficina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
</div> 
