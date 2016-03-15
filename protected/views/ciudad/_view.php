<?php
/* @var $this CiudadController */
/* @var $data Ciudad */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_ciudad')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_ciudad), array('view', 'id'=>$data->id_ciudad)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('abreviatura')); ?>:</b>
	<?php echo CHtml::encode($data->abreviatura); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cod_ciudad')); ?>:</b>
	<?php echo CHtml::encode($data->cod_ciudad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_estado')); ?>:</b>
	<?php echo CHtml::encode($data->id_estado); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('multiplicador')); ?>:</b>
	<?php echo CHtml::encode($data->multiplicador); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fluctuacion')); ?>:</b>
	<?php echo CHtml::encode($data->fluctuacion); ?>
	<br />


</div>