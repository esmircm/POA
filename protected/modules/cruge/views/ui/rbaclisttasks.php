<h1><?php echo ucwords(CrugeTranslator::t("tareas"));?></h1>
<?php 

    $this->widget('booster.widgets.TbTabs', array(
        'type' => 'tabs',
        'tabs' => array(
            array('label' => 'Administrar Roles', 'url' => 'rbaclistroles'),
            array('label' => 'Tareas', 'url' => 'rbaclisttasks', 'active' => TRUE),
            array('label' => 'Operaciones', 'url' => 'rbaclistops'),
            array('label' => 'Asignar Roles a Usuarios', 'url' => 'rbacusersassignments'),
                  ))
    );?>


<div class='auth-item-create-button'>
<?php echo CHtml::link(CrugeTranslator::t("Crear Nueva Tarea")
	,Yii::app()->user->ui->getRbacAuthItemCreateUrl(CAuthItem::TYPE_TASK));?>
</div>

<?php $this->renderPartial('_listauthitems',array('dataProvider'=>$dataProvider),false);?>
