
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

   
         <?php echo $form->hiddenField($consultaPersona, 'id_persona'); ?>
    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'nacionalidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($consultaPersona, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5',
                    'maxlength' => 8, 'readOnly' => true
//                    'onblur' => "buscarPersonaSupervisor($(this).val()"
                   . ")",  
                )
            )
                )
        );
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'nombres', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'apellidos', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'codigo_nomina', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>

    </div> 

<!--    <div class='col-md-4'>
        <?php
//        echo $form->textFieldGroup($consultaPersona, 'descripcion_cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> -->
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($consultaPersona, 'dependencia', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
       // echo $form->textFieldGroup($consultaPersona, 'obj_funcional', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true))));
        ?>
    </div> 
</div> 
