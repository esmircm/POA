<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('id_pais')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_pais),array('view','id'=>$data->id_pais)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('abreviatura')); ?>:</b>
	<?php echo CHtml::encode($data->abreviatura); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cod_pais')); ?>:</b>
	<?php echo CHtml::encode($data->cod_pais); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('moneda')); ?>:</b>
	<?php echo CHtml::encode($data->moneda); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('moneda_sing')); ?>:</b>
	<?php echo CHtml::encode($data->moneda_sing); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('moneda_plur')); ?>:</b>
	<?php echo CHtml::encode($data->moneda_plur); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('simbolo')); ?>:</b>
	<?php echo CHtml::encode($data->simbolo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fraccion')); ?>:</b>
	<?php echo CHtml::encode($data->fraccion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_region_continente')); ?>:</b>
	<?php echo CHtml::encode($data->id_region_continente); ?>
	<br />

	*/ ?>

</div>