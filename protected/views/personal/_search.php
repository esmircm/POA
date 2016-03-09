<?php
/* @var $this PersonalController */
/* @var $model Personal */
/* @var $form CActiveForm */
?>

<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'id_personal'); ?>
		<?php echo $form->textField($model,'id_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'anios_servicio_apn'); ?>
		<?php echo $form->textField($model,'anios_servicio_apn'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'cedula'); ?>
		<?php echo $form->textField($model,'cedula'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'cedula_conyugue'); ?>
		<?php echo $form->textField($model,'cedula_conyugue'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_ciudad_nacimiento'); ?>
		<?php echo $form->textField($model,'id_ciudad_nacimiento'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_ciudad_residencia'); ?>
		<?php echo $form->textField($model,'id_ciudad_residencia'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'diestralidad'); ?>
		<?php echo $form->textField($model,'diestralidad',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'direccion_residencia'); ?>
		<?php echo $form->textField($model,'direccion_residencia',array('size'=>60,'maxlength'=>100)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'doble_nacionalidad'); ?>
		<?php echo $form->textField($model,'doble_nacionalidad',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>60,'maxlength'=>60)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_establecimiento_salud'); ?>
		<?php echo $form->textField($model,'id_establecimiento_salud'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'estado_civil'); ?>
		<?php echo $form->textField($model,'estado_civil',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'estatura'); ?>
		<?php echo $form->textField($model,'estatura'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'fecha_nacimiento'); ?>
		<?php echo $form->textField($model,'fecha_nacimiento'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'fecha_nacionalizacion'); ?>
		<?php echo $form->textField($model,'fecha_nacionalizacion'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'gaceta_nacionalizacion'); ?>
		<?php echo $form->textField($model,'gaceta_nacionalizacion',array('size'=>10,'maxlength'=>10)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'grado_licencia'); ?>
		<?php echo $form->textField($model,'grado_licencia'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'grupo_sanguineo'); ?>
		<?php echo $form->textField($model,'grupo_sanguineo',array('size'=>3,'maxlength'=>3)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'maneja'); ?>
		<?php echo $form->textField($model,'maneja',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'marca_vehiculo'); ?>
		<?php echo $form->textField($model,'marca_vehiculo',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'mismo_organismo_conyugue'); ?>
		<?php echo $form->textField($model,'mismo_organismo_conyugue',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'modelo_vehiculo'); ?>
		<?php echo $form->textField($model,'modelo_vehiculo',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'nacionalidad'); ?>
		<?php echo $form->textField($model,'nacionalidad',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'nacionalizado'); ?>
		<?php echo $form->textField($model,'nacionalizado',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'nivel_educativo'); ?>
		<?php echo $form->textField($model,'nivel_educativo',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'nombre_conyugue'); ?>
		<?php echo $form->textField($model,'nombre_conyugue',array('size'=>50,'maxlength'=>50)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'numero_libreta_militar'); ?>
		<?php echo $form->textField($model,'numero_libreta_militar',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'numero_rif'); ?>
		<?php echo $form->textField($model,'numero_rif',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'numero_sso'); ?>
		<?php echo $form->textField($model,'numero_sso',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'otra_normativa_nac'); ?>
		<?php echo $form->textField($model,'otra_normativa_nac',array('size'=>40,'maxlength'=>40)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_pais_nacionalidad'); ?>
		<?php echo $form->textField($model,'id_pais_nacionalidad'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_parroquia'); ?>
		<?php echo $form->textField($model,'id_parroquia'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'peso'); ?>
		<?php echo $form->textField($model,'peso'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'placa_vehiculo'); ?>
		<?php echo $form->textField($model,'placa_vehiculo',array('size'=>10,'maxlength'=>10)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'primer_apellido'); ?>
		<?php echo $form->textField($model,'primer_apellido',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'primer_nombre'); ?>
		<?php echo $form->textField($model,'primer_nombre',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'reingresable'); ?>
		<?php echo $form->textField($model,'reingresable',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'sector_trabajo_conyugue'); ?>
		<?php echo $form->textField($model,'sector_trabajo_conyugue',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'segundo_apellido'); ?>
		<?php echo $form->textField($model,'segundo_apellido',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'segundo_nombre'); ?>
		<?php echo $form->textField($model,'segundo_nombre',array('size'=>20,'maxlength'=>20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'sexo'); ?>
		<?php echo $form->textField($model,'sexo',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'telefono_celular'); ?>
		<?php echo $form->textField($model,'telefono_celular',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'telefono_oficina'); ?>
		<?php echo $form->textField($model,'telefono_oficina',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'telefono_residencia'); ?>
		<?php echo $form->textField($model,'telefono_residencia',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tenencia_vivienda'); ?>
		<?php echo $form->textField($model,'tenencia_vivienda',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tiene_hijos'); ?>
		<?php echo $form->textField($model,'tiene_hijos',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tiene_vehiculo'); ?>
		<?php echo $form->textField($model,'tiene_vehiculo',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tipo_vivienda'); ?>
		<?php echo $form->textField($model,'tipo_vivienda',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'zona_postal_residencia'); ?>
		<?php echo $form->textField($model,'zona_postal_residencia',array('size'=>6,'maxlength'=>6)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'id_sitp'); ?>
		<?php echo $form->textField($model,'id_sitp'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tiempo_sitp'); ?>
		<?php echo $form->textField($model,'tiempo_sitp'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'madre_padre'); ?>
		<?php echo $form->textField($model,'madre_padre',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'fecha_fallecimiento'); ?>
		<?php echo $form->textField($model,'fecha_fallecimiento'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'dias_servicio_apn'); ?>
		<?php echo $form->textField($model,'dias_servicio_apn'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'meses_servicio_apn'); ?>
		<?php echo $form->textField($model,'meses_servicio_apn'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'deuda_regimen_derogado'); ?>
		<?php echo $form->textField($model,'deuda_regimen_derogado',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'credencial'); ?>
		<?php echo $form->textField($model,'credencial',array('size'=>15,'maxlength'=>15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'puebloindigena'); ?>
		<?php echo $form->textField($model,'puebloindigena',array('size'=>6,'maxlength'=>6)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'discapacidad'); ?>
		<?php echo $form->textField($model,'discapacidad',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tipodiscapacidad'); ?>
		<?php echo $form->textField($model,'tipodiscapacidad',array('size'=>1,'maxlength'=>1)); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->