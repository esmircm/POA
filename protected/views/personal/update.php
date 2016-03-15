<?php
/* @var $this PersonalController */
/* @var $model Personal */

$this->breadcrumbs=array(
	'Personals'=>array('index'),
	$model->id_personal=>array('view','id'=>$model->id_personal),
	'Update',
);

$this->menu=array(
	array('label'=>'List Personal', 'url'=>array('index')),
	array('label'=>'Create Personal', 'url'=>array('create')),
	array('label'=>'View Personal', 'url'=>array('view', 'id'=>$model->id_personal)),
	array('label'=>'Manage Personal', 'url'=>array('admin')),
);
?>

<h1>Update Personal <?php echo $model->id_personal; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>