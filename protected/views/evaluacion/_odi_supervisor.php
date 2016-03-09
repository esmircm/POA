
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

   
         <?php echo $form->hiddenField($supeva, 'id_persona'); ?>
    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($supeva, 'nacionalidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($supeva, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readOnly' => true,
                    'maxlength' => 8,
//                    'onblur' => "buscarPersonaSupervisor($(this).val())", 
                   'id' => 'cedula_spervisor',
                )
            )
                )
        );
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($supeva, 'nombres', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($supeva, 'apellidos', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($supeva, 'codigo_nomina', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>

    </div> 

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($supeva, 'descripcion_cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($supeva, 'dependencia', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
       // echo $form->textFieldGroup($evaluacion, 'obj_funcional', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2'))));
        ?>
    </div> 
</div> 
<!--Campos del Evaluador del Cruge-->
<div class="row">
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($evaluador, 'fk_dependencia', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($evaluador, 'dependencia_cruge', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
</div>
