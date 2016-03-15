<?php
$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'solicitud-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
?>


<h3 class="text-center">Último Nivel Educativo Cursado</h3>

<?php
$traza = Traza::getTraza(1);
$this->widget(
        'booster.widgets.TbProgress', array(
    'context' => 'success', // 'info', 'success' or 'danger'
    'percent' => $traza['valor'], // the progress
    'striped' => true,
    'content' => $traza['porcentaje'],
        )
);
$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Estudio',
    'context' => 'primary',
    'headerIcon' => 'glyphicon glyphicon-list-alt',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
    'htmlOptions' => '',
    'content' => $this->renderPartial('_form', array('form' => $form, 'model' => $model, 'estado' => $estado, 'pais' => $pais, 'ciudad' => $ciudad), true),)
);
?>

<?php
$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Ubicación Geografica de Estudio',
    'context' => 'primary',
    'headerIcon' => 'glyphicon glyphicon-list-alt',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
    'htmlOptions' => '',
    'content' => $this->renderPartial('_ubicacionGeograficaEstudio', array('form' => $form, 'model' => $model, 'estado' => $estado, 'pais' => $pais, 'ciudad' => $ciudad), true),)
);
?>
<div class="well">
    <div class="row">

        <!--<div class="pull-right">-->
            <?php
//            $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'button',
//                'context' => 'danger',
//                'size' => 'large',
//                'label' => 'Cancerlar',
//                'htmlOptions' => array(
//                    'onclick' => 'document.location.href ="' . Yii::app()->baseUrl . '"',
//                )
//            ));
            ?>
        <!--</div>-->
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'submit',
                'icon' => 'glyphicon glyphicon-floppy-saved',
                'size' => 'large',
                'id' => 'guardar',
                'context' => 'primary',
                'label' => $model->isNewRecord ? 'Siguiente' : 'Siguiente',
            ));
            ?>
        </div>
    </div>
</div>
<?php $this->endWidget(); ?>

