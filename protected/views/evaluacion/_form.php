
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

<div class="row">

    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($personal, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar',
                    'maxlength' => 8,
                    'onblur' => "buscarTrabajadorActivoSigef($(this).val())",  
                )
            )
                )
        );
        ?>

    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'primer_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar',
            'onblur' => "buscarPersonaRrhh($('#Personal_primer_nombre').children(':selected').text(),$(this).val())"))));
        ?>
    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'segundo_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'primer_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'segundo_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
</div> 

<div class="row">

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($trabajador, 'codigo_nomina', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric'))));
        ?>

    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($cargo, 'descripcion_cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($cargo, 'grado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($cargo, 'descripcion_cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($dependencia, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
</div> 



