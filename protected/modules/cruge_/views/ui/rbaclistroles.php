<h1><?php echo ucwords(CrugeTranslator::t("roles"));?></h1>

<?php 

    $this->widget('booster.widgets.TbTabs', array(
        'type' => 'tabs',
        'tabs' => array(
            array('label' => 'Administrar Roles', 'url' => 'rbaclistroles', 'active' => TRUE),
            array('label' => 'Tareas', 'url' => 'rbaclisttasks'),
            array('label' => 'Operaciones', 'url' => 'rbaclistops'),
            array('label' => 'Asignar Roles a Usuarios', 'url' => 'rbacusersassignments'),
                  ))
    );?>

<div class='auth-item-create-button'>
<?php echo CHtml::link(CrugeTranslator::t("Crear Nuevo Rol")
	,Yii::app()->user->ui->getRbacAuthItemCreateUrl(CAuthItem::TYPE_ROLE));?>
</div>

<?php $this->renderPartial('_listauthitems',array('dataProvider'=>$dataProvider),false);?>