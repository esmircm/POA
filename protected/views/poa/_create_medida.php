<?php
        echo $form->textFieldGroup($maestro, 'descripcion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'placeholder' => 'Escriba aqui la Unidad de Medida', 'id' => 'descripcion_create'))));
        
?>

<h4 class="text-info text-left" style="font-size: 14px; width: 80%;">Verifique en el Panel Derecho que la Unidad de Medida no haya sido creada aún.</h4>

<div class="pull-right">
<?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'size' => 'large',
        'context' => 'primary',
        'label' => $maestro->isNewRecord ? 'Guardar' : 'Save',
    ));
?>
</div>