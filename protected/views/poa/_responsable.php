<?php 
 
?>

<h3 class="text-danger text-center">Responsable del Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model); ?>
    <div hidden>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textFieldGroup($model,'dependencia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'style' => 'text-align:center;', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'nombres',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'apellidos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-2'>
	<?php echo $form->textFieldGroup($model,'nacionalidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-4'>
	<?php echo $form->textFieldGroup($model,'cedula',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
    
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'descripcion_cargo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>

        
        
<h3 class="text-danger text-center">Supervisor del Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model_dir); ?>
    <div hidden>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textFieldGroup($model_dir,'dependencia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'style' => 'text-align:center;', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model_dir,'nombres',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model_dir,'apellidos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-2'>
	<?php echo $form->textFieldGroup($model_dir,'nacionalidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
        </div>
        <div class='col-md-4'>
	<?php echo $form->textFieldGroup($model_dir,'cedula',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true)))); ?>
    
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model_dir,'descripcion_cargo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'maxlength'=>50, 'readOnly' => true)))); ?>
    
        </div>
    </div>


<?php ?>