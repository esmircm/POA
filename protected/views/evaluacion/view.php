<?php
$this->breadcrumbs=array(
	'Personas'=>array('index'),
	$model->id_persona,
);

$this->menu=array(
array('label'=>'List Persona','url'=>array('index')),
array('label'=>'Create Persona','url'=>array('create')),
array('label'=>'Update Persona','url'=>array('update','id'=>$model->id_persona)),
array('label'=>'Delete Persona','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id_persona),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Persona','url'=>array('admin')),
);
?>

<h1>View Persona #<?php echo $model->id_persona; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id_persona',
		'cedula',
		'apellido',
		'nombres',
		'fecha_nacimiento',
		'sexo',
		'fk_nacionalidad',
		'fk_estatus',
		'created_date',
		'modified_date',
		'created_by',
		'modified_by',
		'es_activo',
),
)); ?>
