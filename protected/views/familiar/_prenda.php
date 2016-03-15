<?php
// $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
//	'id'=>'familiar-form',
//	'enableAjaxValidation'=>false,
//)); 
?>

<div class="row"> 
    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'talla_franela', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 2)))); ?>
    </div>
    
     <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'talla_pantalon', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 2)))); ?>
    </div>
    
     <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'talla_gorra', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 2)))); ?>
    </div>
</div>



<?php // $this->endWidget(); ?>
