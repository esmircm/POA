
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

   
         <?php echo $form->hiddenField($vista, 'id_persona_evaluado'); ?>
         
    
<div class="row">
    
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($vista, 'nacionalidad_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-2'>
        <?php
               echo $form->textFieldGroup($vista, 'cedula_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readOnly' => true,
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
        echo $form->textFieldGroup($vista, 'nombres_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 


    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($vista, 'apellidos_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 

</div> 

<div class="row">

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'cod_nomina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>

    </div> 

    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'cargo_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <?php
        echo $form->textFieldGroup($vista, 'oficina_evaluado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
    <div class='col-md-4'>
        <b>Tipo de Evaluación</b><br style="margin-bottom: 10px">
        <select name="VswListar_tipoclase" id="VswListar_tipoclase" required>
            <option value="">SELECCIONAR</option>  
            <option value="13">NIVEL ADMINISTRATIVO Y DE APOYO</option>  
            <option value="12">NIVEL PROFESIONAL</option>  
            <option value="14">NIVEL SUPERVISORIO</option> 
        </select>
        <?php
//        echo $form->dropDownList($vista, 'fk_tipo_clase', 
//                array(''=>'SELECCIONAR', '12'=>'ASISTENTE', '13'=>'ANALISTA'), 
//                array('options' => array(''=>array('selected'=>true, 'disabled'=>true)))
//             
//            ); ?>
    </div>
</div> 