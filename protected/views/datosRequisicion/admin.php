<?php
$this->breadcrumbs=array(
	'Datos Requisicions'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List DatosRequisicion','url'=>array('index')),
array('label'=>'Create DatosRequisicion','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('datos-requisicion-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Datos Requisicions</h1>

<p>
	You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
	or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" style="display:none">
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'datos-requisicion-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id_datos_requisicion',
		'fk_tipo_requisicion',
		'anio_requisicion',
		'fk_unidad_ejecutora',
		'ubicacion_geografica',
		'fk_parroquia',
		
		'ciudad',
		'fk_fuente_financia',
/*
		'es_anulacion',
		'es_activo',
		'fk_estatus',
		'created_by',
		'created_date',
		'modified_by',
		'modified_date',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
