<div class="form">
<h1><?php echo ucwords(CrugeTranslator::t("campos personalizados"));?></h1>
<?php 

    $this->widget('booster.widgets.TbTabs', array(
        'type' => 'tabs',
        'tabs' => array(
            array('label' => 'Campos', 'url' => 'fieldsadminlist', 'active' => TRUE),
            array('label' => 'Crear Nuevo campo', 'url' => 'fieldsadmincreate'),
                  ))
    );?>




<?php 
$cols = array();
// presenta los campos de ICrugeField
foreach(Yii::app()->user->um->getSortFieldNamesForICrugeField() as $key=>$fieldName){
	$value=null;
	if($fieldName == 'required')
		$value = '$data->getRequiredName()';
	$cols[] = array('name'=>$fieldName,'value'=>$value);
}
$cols[] = array(
	'class'=>'CButtonColumn',
	'template' => '{update} {delete}',
	'deleteConfirmation'=>CrugeTranslator::t("Esta seguro de eliminar este campo ?"),
	'buttons' => array(
			'update'=>array(
				'label'=>CrugeTranslator::t("editar campo"),
				'url'=>'array("fieldsadminupdate","id"=>$data->getPrimaryKey())'
			),
			'delete'=>array(
				'label'=>CrugeTranslator::t("eliminar campo"),
				'url'=>'array("fieldsadmindelete","id"=>$data->getPrimaryKey())'
			),
		),	
);
$this->widget(Yii::app()->user->ui->CGridViewClass, array(
    'dataProvider'=>$dataProvider,
    'columns'=>$cols,
	'filter'=>$model,
));
?>
</div>