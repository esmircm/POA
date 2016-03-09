<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('id_datos_requisicion')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_datos_requisicion),array('view','id'=>$data->id_datos_requisicion)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_tipo_requisicion')); ?>:</b>
	<?php echo CHtml::encode($data->fk_tipo_requisicion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('anio_requisicion')); ?>:</b>
	<?php echo CHtml::encode($data->anio_requisicion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_unidad_ejecutora')); ?>:</b>
	<?php echo CHtml::encode($data->fk_unidad_ejecutora); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ubicacion_geografica')); ?>:</b>
	<?php echo CHtml::encode($data->ubicacion_geografica); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_parroquia')); ?>:</b>
	<?php echo CHtml::encode($data->fk_parroquia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ciudad')); ?>:</b>
	<?php echo CHtml::encode($data->ciudad); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_fuente_financia')); ?>:</b>
	<?php echo CHtml::encode($data->fk_fuente_financia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('es_anulacion')); ?>:</b>
	<?php echo CHtml::encode($data->es_anulacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('es_activo')); ?>:</b>
	<?php echo CHtml::encode($data->es_activo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fk_estatus')); ?>:</b>
	<?php echo CHtml::encode($data->fk_estatus); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('created_by')); ?>:</b>
	<?php echo CHtml::encode($data->created_by); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('created_date')); ?>:</b>
	<?php echo CHtml::encode($data->created_date); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modified_by')); ?>:</b>
	<?php echo CHtml::encode($data->modified_by); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modified_date')); ?>:</b>
	<?php echo CHtml::encode($data->modified_date); ?>
	<br />

	*/ ?>

</div>