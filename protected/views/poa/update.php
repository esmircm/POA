<?php

$this->breadcrumbs=array(
	'Poas'=>array('index'),
	'Update',
);

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
            echo $this->renderPartial('_responsable_update', array('model' => $model, 'form' => $form), TRUE);
            ?>
    </div>
</div>

<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; margin-left: -50px; bottom: -5%;">
        <span class="glyphicon glyphicon-briefcase" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
            <?php
            echo $this->renderPartial('_poa_update', array('model' => $model, 'form' => $form), TRUE);
            ?>
    </div>
</div>
<div class="pull-right">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'icon' => 'glyphicon glyphicon-chevron-right',
        'context' => 'primary',
        'size' => 'large',
        'label' => $model->isNewRecord ? 'Save' : 'Siguiente',
    ));
    ?>
</div>
<?php 
 $this->endWidget();
?>