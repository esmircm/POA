<?php
$this->breadcrumbs=array(
	'Vsw Pdf Objetivoses'=>array('index'),
	'Manage',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('vsw-pdf-objetivos-grid', {
data: $(this).serialize()
});
return false;
});
");
?>


<div class="search-form" style="display:none">
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'vsw-pdf-objetivos-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id_evaluacion',
		'objetivo',
		'peso',
		'comentario',
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
