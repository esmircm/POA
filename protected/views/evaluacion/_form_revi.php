<?php
$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'revision-form',
    'enableAjaxValidation' => false,
        ));


//$idrevision = Revision::model()->findByAttributes(array('id_revision'));
//echo '<pre>'; var_dump($row);die;
$baseUrl = Yii::app()->baseUrl; 
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');

?>
<h3 class="text-danger text-center"> Revisión <br> <?php echo $consultaPersona->nombres_evaluado . ' ' . $consultaPersona->apellidos_evaluado; ?></h3> 
<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<div class="col-md-3">
    <?php
   
    echo $form->datePickerGroup($model, 'fecha_revision', array('widgetOptions' =>
        array(
            'options' => array(
                'language' => 'es',
                'format' => 'dd/mm/yyyy',
                'startView' => 0,
                'minViewMode' => 0,
                'todayBtn' => 'linked',
                'weekStart' => 0,
                'startDate' => $fecha_revisioncon,
                        'endDate'=>'now()',
                'autoclose' => true,
            ),
            'htmlOptions' => array(
                'class' => 'span5 limpiar',
                'readonly' => true,
                'required'=> true,
            ),
        ),
        'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
              )
    );
    ?>
</div> 
<div class="row">

    <div class="col-md-4">
<?php
echo $form->textAreaGroup(
        $model, 'comentario', array(
    'wrapperHtmlOptions' => array(
        'class' => 'col-sm-12 limpiar',
    ),
    'widgetOptions' => array(
        'htmlOptions' => array('rows' => 1,
            'title' => 'Por favor, dejar su comentario',
            'data-toggle' => 'tooltip', 'data-placement' => 'botton',
        ),)));
?>
    </div>

    <div hidden>
        <?php echo $form->textFieldGroup($periodo, 'id_maestro', array('type' => "hidden")); ?>
    </div>
    <div class="row"> 
        <div class='col-md-2'>

<?php
if (date("n") <= 06) {
    $condicion = '81';
} else {
    $condicion = '82';
}

echo $form->textFieldGroup($periodo, 'descripcion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true))));
?>

        </div>

        <div class='col-md-3'>
            <?php //  echo $form->textFieldGroup($model, 'id_revision', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar' )))); ?>
        </div> 

        <div class='col-md-2'>
            <?php
            //echo $form->textFieldGroup($model, 'fk_revision', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric', 'maxlength' => 2))));
            ?>
        </div> 


        <div class="pull-right">
<?php
//$this->widget('booster.widgets.TbButton', array(
//    'buttonType' => 'submit',
//    'icon' => 'glyphicon glyphicon-floppy-saved',
//    'size' => 'large',
//    'id' => 'guardar',
//    'context' => 'primary',
//    'label' => $model->isNewRecord ? 'Guardar' : 'Save',
//    
//));


   $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'danger',
                'size' => 'large',
                'label' => 'Guardar',
                'htmlOptions' => array(
                  //  'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/admin') . '"',
                    'onclick' => 'ValidacionFecha()',
                )
            ));

?>
        </div>
            <?php $this->endWidget(); ?>
