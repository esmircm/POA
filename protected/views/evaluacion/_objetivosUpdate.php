<?php

$sql = " SELECT id_evaluacion, id_preguntas_ind, objetivo, peso FROM evaluacion.vsw_pdf_objetivos
WHERE id_evaluacion = " . $consultaPersona->id_evaluacion;

$consultaPersona = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $_GET['id']));
$rawData = Yii::app()->db->createCommand($sql);

$consulta = new CSqlDataProvider($rawData, array(
    'keyField' => 'id_evaluacion',
        ));

$this->widget('booster.widgets.TbExtendedGridView', array(
    'id' => 'vsw-pdf-objetivos-grid',
    'type' => 'striped bordered',
    'dataProvider' => $consulta,
    'columns' => array(

        array(
            'header' => 'Objetivo',
            'name' => 'objetivo',
            'footer'=>'Total Peso',
            'footerHtmlOptions'=>array('style'=>'font-weight:700;')
        ),

        array(
            'header' => 'Peso',
            'name' => 'peso',
            'class'=>'booster.widgets.TbTotalSumColumn',
            'footerHtmlOptions'=>array('id'=>'footer_suma_total', 'style'=>'font-weight:700;')
        ),
        
        array(
            'class' => 'booster.widgets.TbButtonColumn',
            'header' => 'Acciones',
            'htmlOptions' => array('width' => '85', 'style' => 'text-align: center;'),
            'template' => '{editar}',
            'buttons' => array(
//                'ver' => array(
//                    'label' => 'Ver',
//                    'icon' => 'eye-open',
//                    'size' => 'medium',
//                    'url' => 'Yii::app()->createUrl("vswPdfEvaluacion/admin", array("id"=> $data["id_evaluacion"]))',
//                    'options' => array("target" => "_blank"),
//                ),
                
                'editar' => array(
                    'label' => 'Editar',
                    'icon' => 'pencil',
                    'size' => 'medium',
                    'url' => 'Yii::app()->createUrl("evaluacion/UpdateObjetivos", array("id"=> $data["id_preguntas_ind"]))',
                ),
                
                
                
            ),
        ),
        
        
    ),
));
?>
