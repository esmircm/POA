<?php 
 
?>

<h3 class="text-danger text-center">Responsable de la Unidad Apoyo</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model); ?>
    <div hidden>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textFieldGroup($model,'dependencia_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'style' => 'text-align:center;', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'nombres_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'apellidos_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-2'>
	<?php echo $form->textFieldGroup($model,'nacionalidad_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-4'>
	<?php echo $form->textFieldGroup($model,'cedula_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
    
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'dependencia_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>

        
        



<?php ?>
