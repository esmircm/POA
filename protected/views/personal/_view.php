<?php
/* @var $this PersonalController */
/* @var $data Personal */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_personal')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id_personal), array('view', 'id'=>$data->id_personal)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('anios_servicio_apn')); ?>:</b>
	<?php echo CHtml::encode($data->anios_servicio_apn); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cedula')); ?>:</b>
	<?php echo CHtml::encode($data->cedula); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cedula_conyugue')); ?>:</b>
	<?php echo CHtml::encode($data->cedula_conyugue); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_ciudad_nacimiento')); ?>:</b>
	<?php echo CHtml::encode($data->id_ciudad_nacimiento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_ciudad_residencia')); ?>:</b>
	<?php echo CHtml::encode($data->id_ciudad_residencia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('diestralidad')); ?>:</b>
	<?php echo CHtml::encode($data->diestralidad); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('direccion_residencia')); ?>:</b>
	<?php echo CHtml::encode($data->direccion_residencia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('doble_nacionalidad')); ?>:</b>
	<?php echo CHtml::encode($data->doble_nacionalidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('email')); ?>:</b>
	<?php echo CHtml::encode($data->email); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_establecimiento_salud')); ?>:</b>
	<?php echo CHtml::encode($data->id_establecimiento_salud); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado_civil')); ?>:</b>
	<?php echo CHtml::encode($data->estado_civil); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estatura')); ?>:</b>
	<?php echo CHtml::encode($data->estatura); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_nacimiento')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_nacimiento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_nacionalizacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_nacionalizacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('gaceta_nacionalizacion')); ?>:</b>
	<?php echo CHtml::encode($data->gaceta_nacionalizacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('grado_licencia')); ?>:</b>
	<?php echo CHtml::encode($data->grado_licencia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('grupo_sanguineo')); ?>:</b>
	<?php echo CHtml::encode($data->grupo_sanguineo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('maneja')); ?>:</b>
	<?php echo CHtml::encode($data->maneja); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('marca_vehiculo')); ?>:</b>
	<?php echo CHtml::encode($data->marca_vehiculo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('mismo_organismo_conyugue')); ?>:</b>
	<?php echo CHtml::encode($data->mismo_organismo_conyugue); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modelo_vehiculo')); ?>:</b>
	<?php echo CHtml::encode($data->modelo_vehiculo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nacionalidad')); ?>:</b>
	<?php echo CHtml::encode($data->nacionalidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nacionalizado')); ?>:</b>
	<?php echo CHtml::encode($data->nacionalizado); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nivel_educativo')); ?>:</b>
	<?php echo CHtml::encode($data->nivel_educativo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre_conyugue')); ?>:</b>
	<?php echo CHtml::encode($data->nombre_conyugue); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('numero_libreta_militar')); ?>:</b>
	<?php echo CHtml::encode($data->numero_libreta_militar); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('numero_rif')); ?>:</b>
	<?php echo CHtml::encode($data->numero_rif); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('numero_sso')); ?>:</b>
	<?php echo CHtml::encode($data->numero_sso); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('otra_normativa_nac')); ?>:</b>
	<?php echo CHtml::encode($data->otra_normativa_nac); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_pais_nacionalidad')); ?>:</b>
	<?php echo CHtml::encode($data->id_pais_nacionalidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_parroquia')); ?>:</b>
	<?php echo CHtml::encode($data->id_parroquia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('peso')); ?>:</b>
	<?php echo CHtml::encode($data->peso); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('placa_vehiculo')); ?>:</b>
	<?php echo CHtml::encode($data->placa_vehiculo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('primer_apellido')); ?>:</b>
	<?php echo CHtml::encode($data->primer_apellido); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('primer_nombre')); ?>:</b>
	<?php echo CHtml::encode($data->primer_nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('reingresable')); ?>:</b>
	<?php echo CHtml::encode($data->reingresable); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('sector_trabajo_conyugue')); ?>:</b>
	<?php echo CHtml::encode($data->sector_trabajo_conyugue); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('segundo_apellido')); ?>:</b>
	<?php echo CHtml::encode($data->segundo_apellido); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('segundo_nombre')); ?>:</b>
	<?php echo CHtml::encode($data->segundo_nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('sexo')); ?>:</b>
	<?php echo CHtml::encode($data->sexo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('telefono_celular')); ?>:</b>
	<?php echo CHtml::encode($data->telefono_celular); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('telefono_oficina')); ?>:</b>
	<?php echo CHtml::encode($data->telefono_oficina); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('telefono_residencia')); ?>:</b>
	<?php echo CHtml::encode($data->telefono_residencia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tenencia_vivienda')); ?>:</b>
	<?php echo CHtml::encode($data->tenencia_vivienda); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tiene_hijos')); ?>:</b>
	<?php echo CHtml::encode($data->tiene_hijos); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tiene_vehiculo')); ?>:</b>
	<?php echo CHtml::encode($data->tiene_vehiculo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tipo_vivienda')); ?>:</b>
	<?php echo CHtml::encode($data->tipo_vivienda); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('zona_postal_residencia')); ?>:</b>
	<?php echo CHtml::encode($data->zona_postal_residencia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('id_sitp')); ?>:</b>
	<?php echo CHtml::encode($data->id_sitp); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tiempo_sitp')); ?>:</b>
	<?php echo CHtml::encode($data->tiempo_sitp); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('password')); ?>:</b>
	<?php echo CHtml::encode($data->password); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('madre_padre')); ?>:</b>
	<?php echo CHtml::encode($data->madre_padre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_fallecimiento')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_fallecimiento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('dias_servicio_apn')); ?>:</b>
	<?php echo CHtml::encode($data->dias_servicio_apn); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('meses_servicio_apn')); ?>:</b>
	<?php echo CHtml::encode($data->meses_servicio_apn); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('deuda_regimen_derogado')); ?>:</b>
	<?php echo CHtml::encode($data->deuda_regimen_derogado); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('credencial')); ?>:</b>
	<?php echo CHtml::encode($data->credencial); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('puebloindigena')); ?>:</b>
	<?php echo CHtml::encode($data->puebloindigena); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('discapacidad')); ?>:</b>
	<?php echo CHtml::encode($data->discapacidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tipodiscapacidad')); ?>:</b>
	<?php echo CHtml::encode($data->tipodiscapacidad); ?>
	<br />

	*/ ?>

</div>