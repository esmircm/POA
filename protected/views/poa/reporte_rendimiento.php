<h1>GENERAR REPORTE DE RENDIMIENTO</h1>


<?php
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

 echo $form->dropDownListGroup($model, 'descripcion', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '56')), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'class' => 'limpiar',
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
?>

<?php $this->endWidget(); ?>