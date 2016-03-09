<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('id_proyecto')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_proyecto),array('view','id'=>$data->id_proyecto)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre_proyecto')); ?>:</b>
	<?php echo CHtml::encode($data->nombre_proyecto); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('objetivo_general')); ?>:</b>
	<?php echo CHtml::encode($data->objetivo_general); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('descripcion')); ?>:</b>
	<?php echo CHtml::encode($data->descripcion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_inicio')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_inicio); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_unidad')); ?>:</b>
	<?php echo CHtml::encode($data->fk_unidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('created_by')); ?>:</b>
	<?php echo CHtml::encode($data->created_by); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('created_date')); ?>:</b>
	<?php echo CHtml::encode($data->created_date); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modified_by')); ?>:</b>
	<?php echo CHtml::encode($data->modified_by); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modified_date')); ?>:</b>
	<?php echo CHtml::encode($data->modified_date); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_status')); ?>:</b>
	<?php echo CHtml::encode($data->fk_status); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('es_activo')); ?>:</b>
	<?php echo CHtml::encode($data->es_activo); ?>
	<br />

	*/ ?>

</div>