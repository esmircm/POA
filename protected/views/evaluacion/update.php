<?php
$this->breadcrumbs = array(
    'Personas' => array('index'),
    'Create',
);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
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
<input type="hidden" id="redireccion_js" value="<?php echo Yii::app()->baseUrl; ?>/evaluacion/admin">
<center><h3 class="text-danger text-center">Ministerio del Poder Popular para la Mujer y la Iguadad de Género</h3></center>
<center><h3 class="text-danger text-center">Sistema de Calificación Laboral (SIMCLA)</h3></center>
<center><h3 class="text-danger text-center">Detalle del Supervisado</h3></center>

<div class="span-5">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Datos del Evaluador(a) / Supervisor(a):',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_evaluado', array('form' => $form, 'consultaPersona' => $consultaPersona), TRUE),
            )
    );
    ?>
</div>
<div class="span-5">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Objetivos:',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_objetivosUpdate', array('form' => $form, 'consultaPersona' => $consultaPersona), TRUE),
            )
    );
    ?>
</div>

<div class="span-5">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Comentarios:',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_comentarioUsuario', array('form' => $form, 'Comentarios' => $Comentarios, 'consultaPersona' => $consultaPersona), TRUE),
            )
    );
    ?>
</div>


<div class="well">
    <div class="row">
<div class="pull-right">
        <?php
//        $this->widget('booster.widgets.TbButton', array(
//            'buttonType' => 'submit',
//            'icon' => 'glyphicon glyphicon-floppy-saved',
//            'size' => 'large',
//            'id' => 'guardar',
//            'context' => 'primary',
//            'label' => $model->isNewRecord ? 'Guardar' : 'Save',
//        ));
        ?>
    </div>
        <div class="pull-right">
            <form method="POST">
            <input type="hidden" value="1" name="pesoguardar">
            <?php
            
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'danger',
                'size' => 'large',
                'label' => 'Guardar',
                'htmlOptions' => array(
                  //  'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/admin') . '"',
                    'onclick' => 'EditarObjetivo()',
                )
            ));
            ?>
            </form>
        </div>
        
        
    </div>
</div>
<?php $this->endWidget(); ?>
