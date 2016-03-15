<?php
/* @var $this ParroquiaController */
/* @var $model Parroquia */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'parroquia-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'id_parroquia'); ?>
		<?php echo $form->textField($model,'id_parroquia'); ?>
		<?php echo $form->error($model,'id_parroquia'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'abreviatura'); ?>
		<?php echo $form->textField($model,'abreviatura',array('size'=>3,'maxlength'=>3)); ?>
		<?php echo $form->error($model,'abreviatura'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'cod_parroquia'); ?>
		<?php echo $form->textField($model,'cod_parroquia',array('size'=>2,'maxlength'=>2)); ?>
		<?php echo $form->error($model,'cod_parroquia'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'id_municipio'); ?>
		<?php echo $form->textField($model,'id_municipio'); ?>
		<?php echo $form->error($model,'id_municipio'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'nombre'); ?>
		<?php echo $form->textField($model,'nombre',array('size'=>40,'maxlength'=>40)); ?>
		<?php echo $form->error($model,'nombre'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->