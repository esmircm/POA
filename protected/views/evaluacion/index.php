<?php
$this->breadcrumbs=array(
	'Personas',
);

$this->menu=array(
array('label'=>'Create Persona','url'=>array('create')),
array('label'=>'Manage Persona','url'=>array('admin')),
);
?>

<h1>Personas</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
