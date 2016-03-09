<?php
//$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
//    'action' => Yii::app()->createUrl($this->route),
//    'method' => 'get',
//        ));
$baseUrl = Yii::app()->baseUrl; 
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');


$form = $this->beginWidget('booster.widgets.TbActiveForm', array( 
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',	
	'id' => 'objetivosUpdate-form', 
	'enableAjaxValidation' => false, 
	'enableClientValidation' => true,
	'clientOptions' => array( 
	'validateOnSubmit' => true, 
	'validateOnChange' => true, 
	'validateOnType' => true, 
	), 
));


?>


 <?php echo $form->hiddenField($model, 'id_preguntas_ind'); ?>
 <?php echo $form->hiddenField($model, 'id_evaluacion'); ?>
<input type="hidden" id="redireccion_js" value="<?php echo Yii::app()->baseUrl; ?>/evaluacion/admin">
<div class="row">
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'objetivo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'
        ))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'peso', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', )))); ?>
    </div> 
</div> 


<div class="well">
    <div class="row">

        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'reset',
                'context' => 'success',
                'size' => 'large',
                'label' => 'Limpiar',
                'htmlOptions' => array(
//                'onclick' => 'telfCheck(this.id,codigo);',
                ),
            ));
            ?>
        </div>
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'danger',
                'size' => 'large',
                'label' => 'Guardar',
                'htmlOptions' => array(
//                    'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/admin') . '"',
                    'onclick' => 'ValidacionPeso()',
                )
            ));
            
//              $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'button',
//                'context' => 'danger',
//                'size' => 'large',
//                'label' => 'Guardar',
//                'htmlOptions' => array(
//                    'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/update/') . '"',
//                )
//            ));
            
//            $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'submit',
//                'size' => 'large',
//                'id' => 'guardar',
//                'context' => 'primary',
//                'label' => 'Guardar',
//            ));
            ?>
        </div>
    </div>
</div>
<?php $this->endWidget(); ?>
