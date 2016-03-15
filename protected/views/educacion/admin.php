<?php
$this->breadcrumbs=array(
	'Educacions'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List Educacion','url'=>array('index')),
array('label'=>'Create Educacion','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('educacion-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Educacions</h1>

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
'id'=>'educacion-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id_educacion',
		'anio_fin',
		'anio_inicio',
		'anios_experiencia',
		'becado',
		'id_carrera',
		/*
		'id_titulo',
		'estatus',
		'sector',
		'meses_experiencia',
		'id_nivel_educativo',
		'id_ciudad',
		'organizacion_becaria',
		'id_personal',
		'registro_titulo',
		'fecha_registro',
		'reembolso',
		'observaciones',
		'nombre_entidad',
		'nombre_postgrado',
		'id_sitp',
		'tiempo_sitp',
		'escala',
		'calificacion',
		'mencion',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
