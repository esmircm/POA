<?php
$this->breadcrumbs=array(
	'Datos Requisicions'=>array('index'),
	$model->id_datos_requisicion,
);

$this->menu=array(
array('label'=>'List DatosRequisicion','url'=>array('index')),
array('label'=>'Create DatosRequisicion','url'=>array('create')),
array('label'=>'Update DatosRequisicion','url'=>array('update','id'=>$model->id_datos_requisicion)),
array('label'=>'Delete DatosRequisicion','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id_datos_requisicion),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage DatosRequisicion','url'=>array('admin')),
);
?>

<h1>View DatosRequisicion #<?php echo $model->id_datos_requisicion; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id_datos_requisicion',
		'fk_tipo_requisicion',
		'anio_requisicion',
		'fk_unidad_ejecutora',
		'ubicacion_geografica',
		'fk_parroquia',
		'ciudad',
		'fk_fuente_financia',
		'es_anulacion',
		'es_activo',
		'fk_estatus',
		'created_by',
		'created_date',
		'modified_by',
		'modified_date',
),
)); ?>
