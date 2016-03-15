<?php
$this->breadcrumbs=array(
	'Familiars'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List Familiar','url'=>array('index')),
array('label'=>'Create Familiar','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('familiar-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Familiars</h1>

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
'id'=>'familiar-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id_familiar',
		'alergias',
		'alergico',
		'cedula_familiar',
		'estado_civil',
		'fecha_nacimiento',
		/*
		'goza_beca',
		'goza_prima_por_hijo',
		'goza_seguro',
		'goza_utiles',
		'grado',
		'grupo_sanguineo',
		'mismo_organismo',
		'nino_excepcional',
		'nivel_educativo',
		'parentesco',
		'sexo',
		'talla_franela',
		'talla_gorra',
		'talla_pantalon',
		'id_personal',
		'primer_nombre',
		'segundo_nombre',
		'primer_apellido',
		'segundo_apellido',
		'promedio_nota',
		'id_sitp',
		'tiempo_sitp',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
