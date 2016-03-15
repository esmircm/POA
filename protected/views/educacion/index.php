<?php
$this->breadcrumbs=array(
	'Educacions',
);

$this->menu=array(
array('label'=>'Create Educacion','url'=>array('create')),
array('label'=>'Manage Educacion','url'=>array('admin')),
);
?>

<h1>Educacions</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
