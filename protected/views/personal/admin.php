<?php
/* @var $this PersonalController */
/* @var $model Personal */

$this->breadcrumbs=array(
	'Personals'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Personal', 'url'=>array('index')),
	array('label'=>'Create Personal', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#personal-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Personals</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'personal-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id_personal',
		'anios_servicio_apn',
		'cedula',
		'cedula_conyugue',
		'id_ciudad_nacimiento',
		'id_ciudad_residencia',
		/*
		'diestralidad',
		'direccion_residencia',
		'doble_nacionalidad',
		'email',
		'id_establecimiento_salud',
		'estado_civil',
		'estatura',
		'fecha_nacimiento',
		'fecha_nacionalizacion',
		'gaceta_nacionalizacion',
		'grado_licencia',
		'grupo_sanguineo',
		'maneja',
		'marca_vehiculo',
		'mismo_organismo_conyugue',
		'modelo_vehiculo',
		'nacionalidad',
		'nacionalizado',
		'nivel_educativo',
		'nombre_conyugue',
		'numero_libreta_militar',
		'numero_rif',
		'numero_sso',
		'otra_normativa_nac',
		'id_pais_nacionalidad',
		'id_parroquia',
		'peso',
		'placa_vehiculo',
		'primer_apellido',
		'primer_nombre',
		'reingresable',
		'sector_trabajo_conyugue',
		'segundo_apellido',
		'segundo_nombre',
		'sexo',
		'telefono_celular',
		'telefono_oficina',
		'telefono_residencia',
		'tenencia_vivienda',
		'tiene_hijos',
		'tiene_vehiculo',
		'tipo_vivienda',
		'zona_postal_residencia',
		'id_sitp',
		'tiempo_sitp',
		'password',
		'madre_padre',
		'fecha_fallecimiento',
		'dias_servicio_apn',
		'meses_servicio_apn',
		'deuda_regimen_derogado',
		'credencial',
		'puebloindigena',
		'discapacidad',
		'tipodiscapacidad',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
