<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	'Create',
);

//$this->menu=array(
//array('label'=>'List Proyecto','url'=>array('index')),
//array('label'=>'Manage Proyecto','url'=>array('admin')),
//);

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'personal-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
));
?>
<h3 class="text-danger text-center" style="margin-bottom: 20px;">FORMULACIÓN DEL PROYECTO OPERATIVO ANUAL<br><?php echo $model->dependencia; ?></h3>

<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; margin-left: -50px; bottom: -5%;">
        <span class="glyphicon glyphicon-user" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
        
            <?php
            echo $this->renderPartial('_responsable', array('model' => $model, 'form' => $form, 'model_dir' => $model_dir), TRUE);
            ?>
    </div>
</div>

<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; margin-left: -50px; bottom: -5%;">
        <span class="glyphicon glyphicon-briefcase" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
            <?php
            echo $this->renderPartial('_proyecto', array('proyecto' => $proyecto, 'form' => $form), TRUE);
       
            ?>
    </div>
</div>
<div class="pull-right">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'context' => 'primary',
        'label' => $proyecto->isNewRecord ? 'Siguiente' : 'Save',
    ));
    ?>
</div>
<?php 
 $this->endWidget();
?>