<h3 class="text-danger text-center">Responsables de la Unidad Apoyo</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<h2 style="text-align: center; font-size: 20px;">DIRECTOR(A) DE LA <?php echo $model->dependencia; ?></h2>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'nombres',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'apellidos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-2'>
	<?php echo $form->textFieldGroup($model,'nacionalidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
        </div>
        <div class='col-md-4'>
	<?php echo $form->textFieldGroup($model,'cedula',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
    
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'descripcion_cargo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
    
        </div>
    </div>

    <h2 style="text-align: center; font-size: 20px;">RESPONSABLE DEL REGISTRO DEL PROYECTO</h2>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'nombres_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'apellidos_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-2'>
	<?php echo $form->textFieldGroup($model,'nacionalidad_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
        </div>
        <div class='col-md-4'>
	<?php echo $form->textFieldGroup($model,'cedula_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none;')))); ?>
    
        </div>
        <div class='col-md-6'>
	<?php echo $form->textFieldGroup($model,'cargo_responsable',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'maxlength'=>50, 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none')))); ?>
    
        </div>
    </div>

