
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
<div hidden>
         <?php echo $form->textFieldGroup($vista, 'id_persona_evaluado', array('widgetOptions' => array('htmlOptions' => array ('class' => 'limpiarcedula', 'id' => 'vista_id_persona', 'readonly' => true)))); ?>
         
         <?php echo $form->textFieldGroup($vista, 'fk_tipo_clase', array('widgetOptions' => array('htmlOptions' => array ('class' => 'limpiarcedula', 'id' => 'vista_fk_tipo_clase', 'readonly' => true)))); ?>
</div>
    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($vista, 'nacionalidad_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'id' => 'vista_nacionalidad', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($vista, 'cedula_evaluado', array('widgetOptions' => array('htmlOptions' => 
                array('class' => 'span5 numeric limpiarcedula',
                    'maxlength' => 8,
                    'onblur' => "buscarSupervisado()",  
                    'onclick' => "LimpiarDatos('limpiarcedula')",
                    'id' => 'vista_busqueda',
                    'required' => true,
                    
                )
            )
                )
        );
        ?>
    </div> 
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($vista, 'nombres_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'readOnly' => true, 'id' => 'vista_nombre',)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($vista, 'apellidos_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'readOnly' => true, 'id' => 'vista_apellidos',)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'cod_nomina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'readOnly' => true, 'id' => 'vista_codigo_nomina',)))); ?>

    </div> 

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'cargo_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'readOnly' => true, 'id' => 'vista_descripcion_cargo',)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'oficina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiarcedula', 'readOnly' => true, 'id' => 'vista_dependencia',)))); ?>
    </div> 
</div> 
