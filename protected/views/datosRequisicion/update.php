<?php
$this->breadcrumbs=array(
	'Datos Requisicions'=>array('index'),
	$model->id_datos_requisicion=>array('view','id'=>$model->id_datos_requisicion),
	'Update',
);

	$this->menu=array(
	array('label'=>'List DatosRequisicion','url'=>array('index')),
	array('label'=>'Create DatosRequisicion','url'=>array('create')),
	array('label'=>'View DatosRequisicion','url'=>array('view','id'=>$model->id_datos_requisicion)),
	array('label'=>'Manage DatosRequisicion','url'=>array('admin')),
	);
	?>

	<h1>Update DatosRequisicion <?php echo $model->id_datos_requisicion; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>