<?php
$this->breadcrumbs=array(
	'Proyectos'=>array('index'),
	'Create_Accion',
);

//$this->menu=array(
//array('label'=>'List Proyecto','url'=>array('index')),
//array('label'=>'Manage Proyecto','url'=>array('admin')),
//);
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
    
    <div style="position: absolute; z-index: 1; bottom: -200%;">
        <span style="font-size: 200px; opacity: 0.2;">Proyecto</span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $proyecto->proyecto;
    ?>
    </div>
</div>

<h3 class="text-danger text-center"></br>Formulación de las Acciones del Proyecto</h3>
<div class="span-20" >
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Acción',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
        'content' => $this->renderPartial('_accion', array('accion' => $accion, 'id_proyecto' => $id_proyecto, 'form' => $form), TRUE),
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
        'content' => $this->renderPartial('_lista_acciones', array('accion' => $accion, 'id_proyecto' => $id_proyecto, 'lista_accion' => $lista_accion, 'form' => $form), TRUE),
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
        'url' => Yii::app()->createUrl("proyecto/view", array('id_proyecto' => $id_proyecto)),
        'label' => $proyecto->isNewRecord ? 'Save' : 'Finalizar',
    ));
?>
</div>

<?php $this->endWidget(); 



