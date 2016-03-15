<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
Yii::app()->clientScript->registerScript('_form', "
    $(document).ready(function(){
        $('.numero').numeric();
        $('#Personal_cedula').numeric();         

    });
");
?>
<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>


<?php echo $form->hiddenField($consultaPersona, 'id_evaluacion'); ?>
<div class="row">
    <div class='col-md-2'>
            <?php
        $criteria = new CDbCriteria;
        $criteria->addCondition('padre = 46 and id_maestro in(48,50)');
        echo $form->dropDownListGroup($EstatusEvaluacion, 'fk_estatus_evaluacion', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroEvaluacion::model()->findAll($criteria), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE', 'onchange' => "Limpiar()" ), ))); 
 ?>
    </div>
    <div class="col-md-6">
         <?php
        echo $form->textAreaGroup(
                $Comentarios, 'comentario', array(
            'wrapperHtmlOptions' => array(
                'class' => 'col-sm-12 limpiar',
            ),
            'widgetOptions' => array(
                'htmlOptions' => array('rows' => 1,
                    'title' => 'Por favor, indicar el objetivo que se va a corregir',
                    'data-toggle' => 'tooltip', 'data-placement' => 'botton',
                    ),)));
        ?>
    </div>
</div> 

