<?php
$this->breadcrumbs=array(
	'Educacions'=>array('index'),
	$model->id_educacion=>array('view','id'=>$model->id_educacion),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Educacion','url'=>array('index')),
	array('label'=>'Create Educacion','url'=>array('create')),
	array('label'=>'View Educacion','url'=>array('view','id'=>$model->id_educacion)),
	array('label'=>'Manage Educacion','url'=>array('admin')),
	);
	?>

	<h1>Update Educacion <?php echo $model->id_educacion; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>