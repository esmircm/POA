<?php
$this->breadcrumbs = array(
    'Poa' => array('admin'),
    'Create_Medida',
);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'unidad_medida-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
?>
<script type="text/javascript">
    $(document).ready(function() {

        if($('#respuesta_createMedida').val()==1){
           bootbox.alert('Se guardó satisfactoriamente la Unidad de Medida.');
        } 
        if($('#respuesta_createMedida').val()==2){
            bootbox.alert('La Unidad de Medida ya se encuentra registrada, por favor, verifique.');
        } 
        if($('#respuesta_createMedida').val()==3){
            bootbox.alert('La Unidad de Medida se eliminado satisfactoriamente.');
        } 
       
   })
</script>
<input type="hidden" id="respuesta_createMedida" value="<?php if(isset($respuesta)) { echo $respuesta; } ?>">

<div class="span-20 text-center">
    <h1 style="border-bottom: 1px solid #dddddd; margin-bottom: 20px;">SISTEMA DE GESTIÓN DE ACCIÓN CENTRALIZADA Y PLANES OPERATIVOS ANUALES</h1>
    <h2 style="margin-bottom: 20px; font-size: 26px;">CREAR UNIDAD DE MEDIDA</h2>
</div>
<div class="span-20 poa_content" style="width: 100%; box-shadow: none;">
    <div class="col-md-6">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Crear Unidad de Medida',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
            'content' => $this->renderPartial('_create_medida', array('form' => $form, 'maestro' => $maestro), TRUE),
            'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),

                )
        );
        ?>
    </div>

    <div class="col-md-6">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Unidades de Medida Existentes',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
            'content' => $this->renderPartial('_view_medida', array('form' => $form, 'maestro' => $maestro), TRUE),
            'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),

                )
        );
        ?>
    </div>
</div>

<?php $this->endWidget(); ?>

