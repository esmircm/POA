<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$this->breadcrumbs = array(
    'Familiars' => array('index'),
    $model->id_familiar => array('view', 'id' => $model->id_familiar),
    'Update',
);

//$this->menu = array(
//    array('label' => 'List Familiar', 'url' => array('index')),
//    array('label' => 'Create Familiar', 'url' => array('create')),
//    array('label' => 'View Familiar', 'url' => array('view', 'id' => $model->id_familiar)),
//    array('label' => 'Manage Familiar', 'url' => array('admin')),
//);
?>

<h1>Actualización del Familiar <?php
    echo $model->id_familiar;
    ?></h1>

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

<div class="row">
    <div class="col-md-12">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos Personales',
            'context' => 'danger',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_form_update', array('model' => $model, 'educacion' => $educacion, 'nacionalidad' =>$nacionalidad,'cedula' =>$cedula,'form' => $form), TRUE),
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
            'content' => $this->renderPartial('_educacion', array('model' => $model, 'educacion' => $educacion,'nacionalidad' =>$nacionalidad, 'cedula' =>$cedula,'form' => $form), TRUE),
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
            'content' => $this->renderPartial('_salud', array('model' => $model, 'educacion' => $educacion,'nacionalidad' =>$nacionalidad, 'cedula' =>$cedula, 'form' => $form), TRUE),
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
            'content' => $this->renderPartial('_prenda', array('model' => $model, 'educacion' => $educacion,'nacionalidad' =>$nacionalidad, 'cedula' =>$cedula, 'form' => $form), TRUE),
                )
        );
        ?>

    </div>
</div>
<div class="row">
    <div class="col-md-1" >

        <?php
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'button',
            'icon'=>'glyphicon glyphicon-floppy-saved',
            'context' => 'primary',
            'label' => 'Actualizar',

            'htmlOptions' => array(
                'onClick' => 'ActualizarFamiliar('
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
         <!--<div class="col-md-1">-->
            <?php
            
//            $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'button',
//                'icon'=>'glyphicon glyphicon-arrow-left',
//                'context' => 'danger',
//                'label' => 'Regresar',
//                'htmlOptions' => array(
//                    'onclick' => 'document.location.href ="'  . $this->createUrl('familiar/create') .'"',
//                )
//            ));
            ?>
        <!--</div>-->
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
            'content' => $this->renderPartial('_listardatos', array('model' => $model, 'educacion' => $educacion,'form' => $form), TRUE),
                )
        );
        ?>
    </div>
</div>
<?php $this->endWidget(); ?>