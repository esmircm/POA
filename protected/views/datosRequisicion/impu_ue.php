

<p class="help-block">Fields with <span class="required">*</span> are required.</p>

<?php //echo $form->errorSummary($model); ?>

	<?php // echo $form->textFieldGroup($model,'fk_datos_requisicion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<div class="row">
    
   <div class="col-md-2">
    
    <?php echo $form->textFieldGroup($impu_ue,'fk_unidad_ejecutora',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
        </div>
       
    <div class="col-md-2">
        <?php echo $form->textFieldGroup($impu_ue,'fk_proyecto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>

    <div class="col-md-2">
        <?php echo $form->textFieldGroup($impu_ue,'fk_accion_especifica',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>
    
    <div class="col-md-3">
        <?php echo $form->textFieldGroup($impu_ue,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>
    
    <div class="col-md-2">
        <?php echo $form->textFieldGroup($impu_ue,'fk_unidad_medida',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>
    
    <div class="col-md-1">
        <?php echo $form->textFieldGroup($impu_ue,'cantidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>

    

</div>

	

	

	

	<?php // echo $form->textFieldGroup($impu_ue,'fk_clasificacion_presupuestaria',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	

	

	

	<?php // echo $form->checkBoxGroup($model,'es_activo'); ?>

	<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>



