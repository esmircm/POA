<center>
<?php
$this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'link',
        'icon' => 'glyphicon glyphicon-hdd',
        'size' => 'large',
        'context' => 'danger',
        'url' => Yii::app()->createUrl("evaluacion/odi"),
        'label' => $model->isNewRecord ? 'Agregar MRL' : 'Save',
    ));
?>
</center>

<center><br><font style = "font-size:13px; font-weight:bold;">
<?php 
    $mensaje= "PARA ELIMINAR UNA EVALUACIÓN ERRÓNEA, DEBE DIRIGIRSE AL ÁREA TÉCNICA O COMUNICARSE MEDIANTE LA EXTENSIÓN 636.";
    echo $mensaje;
    ?>
</center></font>

