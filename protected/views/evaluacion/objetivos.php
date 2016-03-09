<?php
$this->breadcrumbs=array(
	'Personas'=>array('index'),
	'Create',
);
//
//$this->menu=array(
//array('label'=>'List Persona','url'=>array('index')),
//array('label'=>'Manage Persona','url'=>array('admin')),
//);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion1.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion_evaluacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

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

   
    <h3 class="text-danger text-center"><?php // echo $id_evaluacion; ?>Establecimiento y Seguimiento de las Metas de Rendimiento Laboral(MRL)</h3>
    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Objetivos',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_objetivos_odi', array('preind' => $preind, 'form' => $form, 'evaluacion' => $evaluacion), TRUE),
                )
        );
        ?>
    </div>
   
</div>
<div class="row">
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Objetivos',
            'context' => 'primary',
            'headerIcon' => 'glyphicon glyphicon-list-alt',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_objetivos_odi_nuevo', array('preind' => $preind, 'form' => $form, 'evaluacion' => $evaluacion, 'vista' => $vista), TRUE),
                )
        );
        ?>
    </div> 
    <div class="pull-right">
        <?php
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'submit',
            'icon' => 'glyphicon glyphicon-floppy-saved',
            'size' => 'large',
            'id' => 'guardar',
            'context' => 'primary',
            'label' => $model->isNewRecord ? 'Guardar' : 'Save',
        ));
        ?>
    </div>
</div>
<?php // } ?>

<?php // if (isset($id_evaluacion)){?>

<?php // }?>

<?php $this->endWidget(); ?>
