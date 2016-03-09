<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	$model->id_proyecto,
);

$this->menu=array(
array('label'=>'List Proyecto','url'=>array('index')),
array('label'=>'Create Proyecto','url'=>array('create')),
array('label'=>'Update Proyecto','url'=>array('update','id'=>$model->id_proyecto)),
array('label'=>'Delete Proyecto','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id_proyecto),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Proyecto','url'=>array('admin')),
);
?>

<h1>View Proyecto #<?php echo $model->id_proyecto; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id_proyecto',
		'nombre_proyecto',
		'objetivo_general',
		'descripcion',
		'fecha_inicio',
		'fk_unidad',
		'created_by',
		'created_date',
		'modified_by',
		'modified_date',
		'fk_status',
		'es_activo',
),
)); ?>
