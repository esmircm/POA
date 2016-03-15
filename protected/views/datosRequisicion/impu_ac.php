

<p class="help-block">Fields with <span class="required">*</span> are required.</p>

<?php //echo $form->errorSummary($model); ?>

	<?php // echo $form->textFieldGroup($model,'fk_datos_requisicion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<div class="row">
    
   <div class="col-md-2">
    
    <?php echo $form->textFieldGroup($impu_ac,'fk_accion_centralizada',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
        </div>
       
<!--    <div class="col-md-2">
        //<?php echo $form->textFieldGroup($impu_ac,'fk_clasificacion_presupuestaria',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>-->

    <div class="col-md-6">
        <?php echo $form->textFieldGroup($impu_ac,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>150)))); ?>
    </div>
    
    <div class="col-md-2">
        <?php echo $form->textFieldGroup($impu_ac,'fk_unidad_medida',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>

    <div class="col-md-2">
        <?php echo $form->textFieldGroup($impu_ac,'cantidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    </div>

    

</div>



	

	

	

	

	

	<?php // echo $form->checkBoxGroup($model,'es_activo'); ?>

	<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>




