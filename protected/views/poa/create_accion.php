<?php
$this->breadcrumbs=array(
	'Poas'=>array('index'),
	'Create_Accion',
);

$Validaciones = Yii::app()->getClientScript()->registerScriptFile(Yii::app()->baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile(Yii::app()->baseUrl . '/js/js_jquery.numeric.js');

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
<div class="span-20 poa_content" style="box-shadow: none">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $poa->tipo_poa; ?></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $form->textAreaGroup($poa, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; color: #000; font-size: 20px;', 'readOnly' => true)), 'label' => false));
    ?>
    </div>
</div>

<h3 class="text-danger text-center"></br>Formulación de <?php echo $poa->tipo_poa; ?></h3>
<div class="span-20" >
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Acción',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
        'content' => $this->renderPartial('_accion', array('accion' => $accion, 'programacion' => $programacion, 'id_poa' => $id_poa, 'form' => $form), TRUE),
        'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),
            )
    );
    ?>
</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Lista de Acciones',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
        'content' => $this->renderPartial('_lista_acciones', array('accion' => $accion, 'id_poa' => $id_poa, 'lista_accion' => $lista_accion, 'tipo' => $tipo, 'form' => $form), TRUE),
        'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),
            )
    );
    ?>
</div>

<div class="pull-right">
<?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'link',
        'size' => 'large',
        'context' => 'primary',
        'url' => Yii::app()->createUrl("poa/view", array('id_poa' => $id_poa)),
        'label' => $poa->isNewRecord ? 'Save' : 'Finalizar',
    ));
?>
</div>

<?php $this->endWidget(); 



