<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$Validaciones2 = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacionBusquedaAvanzada.js');
$dataTable = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/jquery.dataTables.min.js');
$dataTable2 = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/dataTables.bootstrap.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'vsw-pdf-reporte-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));

Yii::app()->clientScript->registerScript('guardar solicitud', "
    $(document).ready(function() {
        $('#example').dataTable();
    });
");
?>

<?php
$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Generar Consulta',
    'context' => 'primary',
    'headerIcon' => 'glyphicon glyphicon-list-alt',
    'htmlOptions' => '',
    'content' => $this->renderPartial('_reporte', array('model' => $model, 'form' => $form), true),)
);
?>


<div class="well">
    <div class="row">
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'info',
                'icon' => 'glyphicon glyphicon-list',
                'size' => 'large',
                'label' => 'PDF',
                'id' => 'BtnMostrar',
                'htmlOptions' => array(
                    'onclick' => 'document.location.href ="' . $this->createUrl('/VswPdfReporte/certificado') . '"',
                )
            ));
            ?>
        </div>
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'context' => 'success',
                'icon' => 'glyphicon glyphicon-cloud-download',
                'size' => 'large',
                'label' => 'CALC',
                'htmlOptions' => array(
                    'onclick' => 'document.location.href ="' . $this->createUrl('/VswPdfReporte/exel') . '"',
                )
            ));
            ?>
        </div>
    </div>
</div>
<div id='tableMostrar'></div>
<?php $this->endWidget(); ?>