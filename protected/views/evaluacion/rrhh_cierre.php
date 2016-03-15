<?php
$finalizado = count($estatus_finalizado);
$aprobado = count($estatus_aprobado);
$nuevo = count($estatus_nuevo);
$enviado = count($estatus_enviado);
$rechazado = count($estatus_rechazado);
$revisado = count($estatus_revisado);
?>
<form method="POST">
    <div class="span-20">
        <center>
            <input type="hidden" name="respuesta" value="1">
            <span style="font-size: 40px; font-weight: 700; display: block; margin: 0 auto; margin-bottom: 20px;">¿Está seguro que desea Cerrar el 
                <?php
                if (date('n') <= 6) {
                    echo "Primer Semestre del Año Actual?";
                }
                if (date('n') >= 7) {
                    echo "Segundo Semestre del Año Actual?";
                }
                ?>
            </span>
        </center>
        <span class="abstract">
            <?php if($nuevo==0){} else { ?><?php echo $nuevo; ?> Meta<?php if($nuevo>1){ ?>s<?php } ?> de Rendimiento Laboral está<?php if($nuevo>1){ ?>n<?php } ?> actualmente con el Estatus Nuevo.<br><?php } ?>
            <?php if($enviado==0){} else { ?><?php echo $enviado; ?> Meta<?php if($enviado>1){ ?>s<?php } ?> de Rendimiento Laboral se encuentra<?php if($enviado>1){ ?>n<?php } ?> Enviada<?php if($enviado>1){ ?>s<?php } ?>.<br><?php } ?>
            <?php if($aprobado==0){} else { ?><?php echo $aprobado; ?> Meta<?php if($aprobado>1){ ?>s<?php } ?> de Rendimiento Laboral fue<?php if($aprobado>1){ ?>ron<?php } ?> aprobada<?php if($aprobado>1){ ?>s<?php } ?> pero no ha<?php if($aprobado>1){ ?>n<?php } ?> sido Evaluada<?php if($aprobado>1){ ?>s<?php } ?>.<br><?php } ?>
            <?php if($rechazado==0){} else { ?><?php echo $rechazado; ?> MRL está<?php if($rechazado>1){ ?>n<?php } ?> rechazada<?php if($rechazado>1){ ?>s<?php } ?>.<br><?php } ?>
            <?php if($revisado==0){} else { ?><?php echo $revisado; ?> MRL está<?php if($revisado>1){ ?>n<?php } ?> revisada<?php if($revisado>1){ ?>s<?php } ?> pero no ha<?php if($revisado>1){ ?>n<?php } ?> sido Enviada<?php if($revisado>1){ ?>s<?php } ?> a la Unidad de Recursos Humanos.<br><?php } ?>
            <br> Por lo cual al <b>Cerrar el Semestre</b> cada una de estas Metas de Rendimiento Laboral o Evaluaciones quedarán <b>Incompletas</b>.<br>
        </span>
        
    </div>
    <div style="display: block; text-align: center; width: 90%; margin: 0 auto; margin-top: 40px;">
        <div style="display: inline-block; margin: 0 auto;">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'submit',
                'icon' => 'glyphicon glyphicon-share',
                'size' => 'large',
                'context' => 'danger',
                'label' => $model->isNewRecord ? 'Cerrar Semestre' : 'Save',
            ));
            ?>
        </div>
        <div style="display: inline-block; margin: 0 auto;">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'link',
                'size' => 'large',
                'context' => 'primary',
                'url' => Yii::app()->createUrl("evaluacion/recursoshumanos"),
                'label' => $model->isNewRecord ? 'Cancelar ' : 'Save',
            ));
            ?>
        </div>
    </div>
</form>
<?php
?>


