<?php
$this->breadcrumbs=array(
	'Familiars'=>array('index'),
	$model->id_familiar,
);

$this->menu=array(
array('label'=>'List Familiar','url'=>array('index')),
array('label'=>'Create Familiar','url'=>array('create')),
array('label'=>'Update Familiar','url'=>array('update','id'=>$model->id_familiar)),
array('label'=>'Delete Familiar','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id_familiar),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Familiar','url'=>array('admin')),
);
?>

<h1>View Familiar #<?php echo $model->id_familiar; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id_familiar',
		'alergias',
		'alergico',
		'cedula_familiar',
		'estado_civil',
		'fecha_nacimiento',
		'goza_beca',
		'goza_prima_por_hijo',
		'goza_seguro',
		'goza_utiles',
		'grado',
		'grupo_sanguineo',
		'mismo_organismo',
		'nino_excepcional',
		'nivel_educativo',
		'parentesco',
		'sexo',
		'talla_franela',
		'talla_gorra',
		'talla_pantalon',
		'id_personal',
		'primer_nombre',
		'segundo_nombre',
		'primer_apellido',
		'segundo_apellido',
		'promedio_nota',
		'id_sitp',
		'tiempo_sitp',
),
)); ?>
