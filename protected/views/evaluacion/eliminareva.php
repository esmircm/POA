<?php
$this->breadcrumbs = array(
    'Personas' => array('index'),
    'EliminarEva',
   
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
    'id' => 'eliminareva-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));

?>
        <?php
        $this->widget(
            'booster.widgets.TbPanel', array(
            'title' => 'Datos del Evaluador(a) / Supervisor(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisor', array('supeva' => $supeva, 'form' => $form), TRUE),
                )
        );

        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Supervisado(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisado_rrhh', array('form' => $form, 'consultaPersona' => $consultaPersona), TRUE),
                )
        );
        ?>

<form method="POST" style="display: inline-block">
    <input type="hidden" value="1" name="Eliminar Evaluacion">
<?php
//$this->widget('booster.widgets.TbButton', array(
//        'buttonType' => 'buttons',
//        'size' => 'large',
//        'context' => 'primary',
//        'onclick' => 'eliminareva()',
//        'label' => $model->isNewRecord ? 'Eliminar' : 'Save',
//        )); 
              $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'danger',
                'size' => 'large',
                'label' => 'Eliminar',
                'htmlOptions' => array(
                    'onclick' => 'eliminareva()',
//'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/update/id/'.$idevaluacion) . '"',
                )
            ));

?>

    <input type="hidden" value="2" name="Volver Atras">
<?php    
$this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'buttons',
        'size' => 'large',
        'context' => 'primary',
        'label' => 'Cancelar' ,
     'htmlOptions' => array(
     'onclick' => 'document.location.href ="' . $this->createUrl('admin') . '"',
       ),
    
    ));

//lol
?>
</form>
<?php $this->endWidget(); ?>

