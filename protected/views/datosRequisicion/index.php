<?php
$this->breadcrumbs=array(
	'Datos Requisicions',
);

$this->menu=array(
array('label'=>'Create DatosRequisicion','url'=>array('create')),
array('label'=>'Manage DatosRequisicion','url'=>array('admin')),
);
?>

<h1>Datos Requisicions</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
