<?php
$this->breadcrumbs = array(
    'Personas' => array('index'),
    'Create',
);

//$sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
//$connection = Yii::app()->db;
//$command = $connection->createCommand($sql);
//$row = $command->queryAll();
//$idUser = $row[0]["iduser"];
//$idP = $row[0]["id_persona"];
//
//$this->menu=array(
//array('label'=>'List Persona','url'=>array('index')),
//array('label'=>'Manage Persona','url'=>array('admin')),
//);
//

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion1.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion_evaluacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

Yii::app()->clientScript->registerScript('odi', "
//$(document).ready(function() {u
//        $('input:submit').click(function() { return false; });
//}
");


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

</script>  
<input type="hidden" id="redireccion_js" value="<?php echo Yii::app()->baseUrl; ?>/evaluacion/admin">

<?php
if (isset($id_evaluacion)) {
    
} else {
    ?>
    <h3 class="text-danger text-center">Planilla de Formulación MRL</h3>
    <div id="datospersona">
        <div class="span-20">
            <?php
            $this->widget(
                    'booster.widgets.TbPanel', array(
                'title' => 'Periodo á Evaluar',
                'context' => 'primary',
                'headerIcon' => 'user',
                'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                'content' => $this->renderPartial('_periodo', array('form' => $form, 'evaluados' => $evaluados, 'periodo' => $periodo), TRUE),
                    )
            );
            ?>
        </div>
        <div class="span-20">
            <?php
            $this->widget(
                    'booster.widgets.TbPanel', array(
                'title' => 'Datos del Evaluador(a) / Supervisor(a)',
                'context' => 'primary',
                'headerIcon' => 'user',
                'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                'content' => $this->renderPartial('_odi_supervisor', array('evaluador' => $evaluador, 'vista' => $vista, 'supeva' => $supeva, 'model' => $model, 'evaluacion' => $evaluacion, 'evaluador' => $evaluador, 'form' => $form), TRUE),
                    )
            );

            $this->widget(
                    'booster.widgets.TbPanel', array(
                'title' => 'Datos del Supervisado(a)',
                'context' => 'primary',
                'headerIcon' => 'user',
                'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                'content' => $this->renderPartial('_odi_supervisado', array('vista' => $vista, 'model' => $model, 'form' => $form), TRUE),
                    )
            );
            ?>
        </div>
        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'submit',
                'icon' => 'glyphicon glyphicon glyphicon-arrow-right',
                'size' => 'large',
                'id' => 'guardar',
                'context' => 'primary',
                'label' => $model->isNewRecord ? 'Siguiente' : 'Save',
            ));
            ?>
        </div>
    </div>
<?php } ?>

<?php
if (isset($fk_tipo_clase)) {
    if ($fk_tipo_clase == 11) {
        if (isset($evaluacion_vista)) {
            ?>

            <div class="span-20">
                <?php
                //        var_dump($fk_tipo_clase);die;


                $this->widget(
                        'booster.widgets.TbPanel', array(
                    'title' => 'Factores Evaluados',
                    'context' => 'primary',
                    'headerIcon' => 'glyphicon glyphicon-lis',
                    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                    'content' => $this->renderPartial('_objetivos_obrero', array('form' => $form, 'preobre' => $preobre, 'pre_status' => $pre_status, 'fk_tipo_clase' => $fk_tipo_clase, 'evaluacion_vista' => $evaluacion_vista), TRUE),
                        )
                );
                ?>
            </div>
            <div class="span-20">
                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'context' => 'primary',
                    'htmlOptions' => array('style' => 'display: block; margin: auto;'),
                    'label' => $model->isNewRecord ? 'Guardar' : 'Save',
                ));
                ?>
            </div>
            <?php
        }
    } else {
        if (isset($id_evaluacion)) {
            ?>
            <h3 class="text-danger text-center"></br>Establecimiento y Seguimiento de las Metas de Rendimiento Laboral(MRL) <br><?php echo $consulta->nombres_evaluado . ' ' . $consulta->apellidos_evaluado; ?></h3>
            <div class="span-20">
                <?php
                $this->widget(
                        'booster.widgets.TbPanel', array(
                    'title' => 'Objetivos',
                    'context' => 'primary',
                    'headerIcon' => 'user',
                    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                    'content' => $this->renderPartial('_objetivos_odi', array('preind' => $preind, 'form' => $form, 'evaluacion' => $evaluacion), TRUE),
                        )
                );
                ?>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <?php
                    $this->widget(
                            'booster.widgets.TbPanel', array(
                        'title' => 'Lista de Objetivos',
                        'context' => 'primary',
                        'headerIcon' => 'glyphicon glyphicon-list-alt',
                        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
                        'content' => $this->renderPartial('_objetivos_odi_nuevo', array('preind' => $preind, 'form' => $form, 'evaluacion' => $evaluacion, 'vista' => $vista), TRUE),
                            )
                    );
                    ?>
                </div> 
                <div class="pull-right">
                    <?php
                    $this->widget('booster.widgets.TbButton', array(
                        'buttonType' => 'button',
                        'context' => 'danger',
                        'size' => 'large',
                        'label' => 'Guardar',
                        'htmlOptions' => array(
                            //                    'onclick' => 'document.location.href ="' . $this->createUrl('/evaluacion/admin') . '"',
                            'onclick' => 'ValidacionObjetivos()',
                        )
                    ));
                    ?>
                </div>
            </div>
            <?php
        }
    }
}

if (isset($rango_act)) {
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Resumen de la Evaluación',
        'context' => 'primary',
        'headerIcon' => 'glyphicon glyphicon-align-justify',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_obreros_calificacion', array('form' => $form, 'rango_act' => $rango_act, 'total_puntuacion' => $total_puntuacion, 'model' => $model), TRUE),
            )
    );
    ?>
    </div>
    <div style="text-align: center">
        <?php
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'submit',
            'icon' => 'glyphicon glyphicon-floppy-disk',
            'size' => 'large',
            'context' => 'danger',
            'label' => $model->isNewRecord ? 'Guardar' : 'Save',
        ));
        ?>
    </div>
    <?php
}
?>

<?php $this->endWidget(); ?>
