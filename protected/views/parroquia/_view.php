<?php
/* @var $this ParroquiaController */
/* @var $data Parroquia */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_parroquia')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_parroquia), array('view', 'id'=>$data->id_parroquia)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('abreviatura')); ?>:</b>
	<?php echo CHtml::encode($data->abreviatura); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cod_parroquia')); ?>:</b>
	<?php echo CHtml::encode($data->cod_parroquia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_municipio')); ?>:</b>
	<?php echo CHtml::encode($data->id_municipio); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />


</div>