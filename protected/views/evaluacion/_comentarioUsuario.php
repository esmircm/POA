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
    <div class="col-md-9">
        <?php
        echo $form->textAreaGroup(
                $consultaPersona, 'comentario', array(
            'wrapperHtmlOptions' => array(
                'class' => 'col-sm-12 limpiar',
            ),
            'widgetOptions' => array(
                'htmlOptions' => array('class' => 'span2', 'readOnly' => true),)));
        ?>
    </div>
    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($consultaPersona, 'estatus', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true)))); ?>
    </div> 
</div> 

