
<?php
$baseUrl = Yii::app()->baseUrl;
//$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//array('id_familiar' => $_GET['id']), array('order' => 'id_familiar'));
//
Yii::app()->clientScript->registerScript('familiar', " 
        
    $(document).ready(function(){
        $('#Familiar_cedula_familiar').val('');
    });
    
    $('#Terminar').click(function(){
        if (confirm('¿Está seguro que desa terminar la actualización?') == true) {//pido una confirmación
            $(location).attr('href', '" . $this->createUrl('finalizar') . "');
        }
    });
  
");
?>


<?php
$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'familiar-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
?>

<h1 class="text-center">Grupo Familiar de <?= $personal->primer_nombre . ' ' . $personal->primer_apellido ?></h1>
<?php
$traza = Traza::getTraza(2);
$this->widget(
        'booster.widgets.TbProgress', array(
    'context' => 'success', // 'info', 'success' or 'danger'
    'percent' => $traza['valor'], // the progress
    'striped' => true,
    'content' => $traza['porcentaje'],
        )
);
?>
<div class="row">
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos Personales',
            'context' => 'danger',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_form', array('model' => $model, 'educacion' => $educacion, 'nacionalidad' => $nacionalidad, 'cedula' => $cedula, 'form' => $form), TRUE),
                )
        );
        ?>
    </div>
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Educación',
            'context' => 'danger',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_educacion', array('model' => $model, 'educacion' => $educacion, 'form' => $form), TRUE),
                )
        );
        ?>
    </div>
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Salud',
            'context' => 'danger',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_salud', array('model' => $model, 'educacion' => $educacion, 'form' => $form), TRUE),
                )
        );
        ?>
    </div>
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Prenda',
            'context' => 'primary',
            'headerIcon' => 'glyphicon glyphicon-list-alt',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_prenda', array('model' => $model, 'educacion' => $educacion, 'form' => $form), TRUE),
                )
        );
        ?>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <?php
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'button',
            'context' => 'primary',
            'label' => 'Registrar Familiar',
            'icon' => 'glyphicon glyphicon-floppy-saved',
            'htmlOptions' => array(
                'onClick' => 'GuardarFamiliar('
                . '$("#Familiar_cedula_familiar").val(),'
                . '$("#Familiar_primer_nombre").val(),'
                . '$("#Familiar_segundo_nombre").val(),'
                . '$("#Familiar_primer_apellido").val(),'
                . '$("#Familiar_segundo_apellido").val(),'
                . '$("#Familiar_estado_civil").val(),'
                . '$("#Familiar_sexo").val(),'
                . '$("#Familiar_fecha_nacimiento").val(),'
                . '$("#Familiar_parentesco").val(),'
                . '$("#mismo_organismo").is(":checked"),'
                . '$("#Familiar_nivel_educativo").val(),'
                . '$("#Familiar_grado").val(),'
                . '$("#Familiar_promedio_nota").val(),'
                . '$("#goza_utiles").is(":checked"),'
                . '$("#Familiar_grupo_sanguineo").val(),'
                . '$("#nino_excepcional").is(":checked"),'
                . '$("#alergico").is(":checked"),'
                . '$("#Familiar_alergias").val(),'
                . '$("#Familiar_talla_franela").val(),'
                . '$("#Familiar_talla_pantalon").val(),'
                . '$("#Familiar_talla_gorra").val())'
            )
        ));
        ?>
    </div>
</div>
<br>
<div class="row">
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Familiares',
            'context' => 'primary',
            'headerIcon' => 'glyphicon glyphicon-list-alt',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_listardatos', array('model' => $model, 'educacion' => $educacion, 'form' => $form), TRUE),
                )
        );
        ?>
    </div>
</div>
<div class="row">
    <div class="col-md-12 text-right">
        <?php
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'button',
            'context' => 'success',
            'id' => 'Terminar',
            'label' => 'Terminar el Proceso de Actualización',
            'icon' => 'ok',
        ));
        ?>
    </div>
</div>
<?php $this->endWidget(); ?>