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

<h3 class="text-danger text-center">Planilla de Formulación MRL</h3>
<div class="row">
    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Periodo á Evaluar',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_periodo_rrhh', array('form' => $form, 'consultaPersona' => $consultaPersona), TRUE),
                )
        );
        ?>
    </div>
    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Evaluador(a) / Supervisor(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisor_rrhh', array('form' => $form, 'consultaPersona' => $consultaPersona), TRUE),
                )
        );

        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Supervisado(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisado_rrhh', array('form' => $form,'consultaPersona' => $consultaPersona), TRUE),
                )
        );
        ?>
    </div>
     

    <h3 class="text-danger text-center">Establecimiento y Seguimiento de las Metas de Rendimiento Laboral(MRL)</h3>
    <div class="span-20">
        <?php
//        $this->widget(
//                'booster.widgets.TbPanel', array(
//            'title' => 'Objetivos',
//            'context' => 'primary',
//            'headerIcon' => 'user',
//            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
//            'content' => $this->renderPartial('_objetivos_odi_rrhh', array('preind' => $preind, 'form' => $form, 'evaluacion' => $evaluacion, 'consultaPersona' => $consultaPersona), TRUE),
//                )
//        );
        ?>
    </div>
   

    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Objetivos',
            'context' => 'primary',
            'headerIcon' => 'glyphicon glyphicon-list-alt',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_objetivos_odi_nuevo_rrhh', array('form' => $form,'consultaPersona' => $consultaPersona,'model'=> $model,'id_evaluacion'=> $id_evaluacion), TRUE),
                )
        );
        ?>
    </div> 
    <div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Comentarios:',
        'context' => 'primary',
        'headerIcon' => 'list',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_comentario', array('form' => $form, 'Comentarios' => $Comentarios, 'consultaPersona' => $consultaPersona, 'EstatusEvaluacion' => $EstatusEvaluacion), TRUE),
            )
    );
    ?>
</div>
    </div> 


    <div class="row">

         <div class="pull-right">
            <?php
//            $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'button',
//                'context' => 'danger',
//                'size' => 'large',
//                'label' => 'Guardar',
//                'htmlOptions' => array(
//                    'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/recursoshumanos') . '"',
//                )
//            ));
            ?>
        </div>
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'reset',
                'context' => 'success',
                'icon' => 'glyphicon glyphicon-trash',
                'size' => 'large',
                'label' => 'Limpiar',
                'htmlOptions' => array(

                ),
            ));
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
                'label' => $EstatusEvaluacion->isNewRecord ? 'Guardar' : 'Save',
            ));
            ?>
        </div>
    </div>




<?php $this->endWidget(); ?>
