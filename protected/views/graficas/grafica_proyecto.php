<?php
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');

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
<div style="width: 90%; margin: 0 auto; text-align: center; background-color: rgba(94, 152, 201, 1); border-radius: none; color: #FFF; font-size: 16px; overflow: hidden; position: relative">

    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $poa->tipo_poa; ?></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $form->textAreaGroup($poa, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; color: #FFF; font-size: 20px; margin-top: 50px;', 'readOnly' => true)), 'label' => false));
    ?>
    </div>
</div>

<?php $this->endWidget();  ?>

<div style="width: 90%; margin: 0 auto; text-align: center; font-size: 16px; border-bottom: 1px solid #000;">
    <span style="margin-top: 20px; margin-bottom: 5px; display: inline-block; width: 100%;"><?php echo $poa->obj_general ?>  </span> 
</div>
<div style="width: 90%; margin: 0 auto; text-align: center; font-size: 16px; margin-bottom: 20px; border-bottom: 1px solid #000;">
    <span style="margin-top: 20px; margin-bottom: 5px; display: inline-block; width: 100%;"><?php echo $poa->dependencia_responsable ?>  </span> 
</div>
<table style="width: 90%; border-collapse: collapse; text-align: center; margin: 0 auto; margin-bottom: 50px;">
    <tr style="border-bottom: 1px solid rgba(152, 152, 152, 1); background-color: rgba(133, 133, 133, 1); color: #FFF;">
        <td style="text-align: center">Acción Específica</td>
        <td style="text-align: center">Unidad de Medida</td>
        <td style="text-align: center">Total Anual</td>
        <td style="text-align: center">Ejecutado hasta la Fecha</td>
        <td style="text-align: center">% de Ejecución</td>
    </tr>
<?php
$count = count($acciones);
$i = 1;
foreach ($acciones as $graficas) {
?>

    <?php
    
    echo $this->renderPartial('_proyecto_rendimiento', array('acciones' => $graficas, 'i' => $i), TRUE);
    
    ?>

<?php
$i++;
}
?>
</table>
<div class="poa_content"> 
    
<?php 
//         var_dump(count($acciones));die;
     foreach ($acciones as $graficas) {
         ?>
<div style="display: block; width: 100%; margin: 0 auto;">
    
    
    <?php
    
    echo $this->renderPartial('_grafica_proyecto', array('datos_leyenda' => $datos_leyenda[$graficas->id_accion], 'total' => $total[$graficas->id_accion], 'graficas' => $graficas), TRUE);
    
    ?>
    <div class='fromulario_gradica_cc' style="">
        <div id="<?php echo $graficas->nombre_accion; ?>" style="min-width: 60%; height: auto; margin: 0 auto; " class='ColumLeft1'>
            <center> Espere Se Esta Cargando La Información..!</center>
        </div>
        <div style="clear:both; margin-bottom: 3%"></div>
    </div>
    
</div>
<?php

     }
?>
</div>





