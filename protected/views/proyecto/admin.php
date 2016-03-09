<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List Proyecto','url'=>array('index')),
array('label'=>'Create Proyecto','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('proyecto-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Proyectos</h1>

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
'id'=>'proyecto-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id_proyecto',
		'nombre_proyecto',
		'objetivo_general',
		'descripcion',
		'fecha_inicio',
		'fk_unidad',
		/*
		'created_by',
		'created_date',
		'modified_by',
		'modified_date',
		'fk_status',
		'es_activo',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
