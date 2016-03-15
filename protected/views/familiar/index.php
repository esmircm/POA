<?php
$this->breadcrumbs=array(
	'Familiars',
);

$this->menu=array(
array('label'=>'Create Familiar','url'=>array('create')),
array('label'=>'Manage Familiar','url'=>array('admin')),
);
?>

<h1>Familiars</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
