<?php
$this->breadcrumbs=array(
	'Educacions'=>array('index'),
	$model->id_educacion,
);

$this->menu=array(
array('label'=>'List Educacion','url'=>array('index')),
array('label'=>'Create Educacion','url'=>array('create')),
array('label'=>'Update Educacion','url'=>array('update','id'=>$model->id_educacion)),
array('label'=>'Delete Educacion','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id_educacion),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Educacion','url'=>array('admin')),
);
?>

<h1>View Educacion #<?php echo $model->id_educacion; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id_educacion',
		'anio_fin',
		'anio_inicio',
		'anios_experiencia',
		'becado',
		'id_carrera',
		'id_titulo',
		'estatus',
		'sector',
		'meses_experiencia',
		'id_nivel_educativo',
		'id_ciudad',
		'organizacion_becaria',
		'id_personal',
		'registro_titulo',
		'fecha_registro',
		'reembolso',
		'observaciones',
		'nombre_entidad',
		'nombre_postgrado',
		'id_sitp',
		'tiempo_sitp',
		'escala',
		'calificacion',
		'mencion',
),
)); ?>
