<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'Rechazados_form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));

echo CHtml::hiddenField('exel', 'no', array('type' => "hidden", 'readonly' => "true"));
echo CHtml::hiddenField('pdf', 'no', array('type' => "hidden", 'readonly' => "true"));
?>
<div style="background-color: #dddddd;  border-radius: 10px; width: 100%; height: 50px; text-align: center; position: relative"><div style="width: 100%; font-size: 20px; margin: 0 auto; margin-top: 10px; position: absolute; color: #747474;">Reporte de Metas de Rendimiento Laboral Rechazadas</div></div>
<div style="margin: 0 auto; width: 75%; border-right: solid 1px #ededed; display: inline;">
<table style="border: solid 1px #dddddd; margin: 0 auto; width: 95%; margin-top: 20px;">
    <tr style="font-weight: 700; color: #428bca; border: solid 1px #dddddd">
        <td style="width: 40px;">
            N°
        </td>
        <td>
            Evaluador
        </td>
        <td>
            Oficina del Evaluador
        </td>
        <td>
            Evaluado
        </td>
        <td>
            N° de Rechazos
        </td>
    </tr>
<?php
$html = '';
$numero = 1;
foreach($row as $tuplas){
    $html .= '<tr style="border: solid 1px #dddddd">';
    $html .= '<td style="text-align: center; font-weight: 700;">' . $numero . '</td>';
    $html .= '<td>' . $tuplas['evaluador'] . '</td>';
    $html .= '<td>' . $tuplas['oficina'] . '</td>';
    $html .= '<td>' . $tuplas['evaluado'] . '</td>';
    $html .= '<td style="text-align: center">' . $tuplas['rechazos'] . '</td>';
    $html .= '</tr>';
    
    $numero++;
}
echo $html;
?>
</table>
</div>
<div style="margin: 0 auto; display: inline; width: 20%;">
    <center>
    <?php
                $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'primary',
                'icon' => 'glyphicon glyphicon-file',
                'size' => 'large',
                'label' => 'Exportar PDF',
                'htmlOptions' => array(
                    'name' => 'btnPDF',
                    'id' => 'btnPDF',
                    'style' => 'width: 30%;',
                    "onclick" => "ExportarReportes('PDF');"
                )
            ));
            ?>
        
            <?php
             
             
//           $this->widget('booster.widgets.TbButton', array(
//                'buttonType' => 'button',
//                'context' => 'danger',
//                'icon' => 'glyphicon glyphicon-cloud-download',
//                'size' => 'large',
//                'label' => 'Exportar Hoja Cálculo',
//                'htmlOptions' => array(
//                    'name' => 'btnCAL',
//                    'id' => 'btnCAL',
//                    'style' => 'width: 70%; margin-top: 10px;',
//                    "onclick" => "ExportarReportes('CAL');"
//                )
//            ));
            ?>
    </center>
</div>
<?php 
$this->endWidget();
?>


