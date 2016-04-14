<?php
$this->breadcrumbs=array(
	'Poas'=>array('index'),
	'Create_Actividad',
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
<input type="hidden" id="id_actividad" value="">
<div class="span-20 poa_content" style="box-shadow: none; border-bottom: solid 1px;">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $poa->tipo_poa; ?></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $form->textAreaGroup($poa, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; color: #000; font-size: 20px;', 'readOnly' => true)), 'label' => false));
    ?>
    </div>
</div>
<div class="span-20 poa_content" style="box-shadow: none; border-bottom: solid 1px;">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <span style="font-size: 200px; opacity: 0.2;">Acción</span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; margin-top: 50px;">
        <div class="row">
        <?php
        echo $form->textFieldGroup($accion, 'nombre_accion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
        ?>
        </div>
        <div class="row">
            <div class="col-md-6">
            <?php
            echo $form->textFieldGroup($accion, 'unidad_medida', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
            ?>
            </div>
            <div class="col-md-6">
            <?php
            echo $form->textFieldGroup($accion, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
            ?>
            </div>
        </div>
        <center><label for="programacion">Programación</label></center>
        <table style="width: 100%; border-bottom: 1px solid; margin-bottom: 20px;" id="programacion">
            <tr style="font-weight: 700; text-align: center">
    <?php
        foreach ($programacion_accion as $data) {
            ?>
                <td style="text-align: center">
                    <?php
                    echo $data->fkMeses->descripcion;
                    ?>
                </td>
            <?php
        }
    ?>
            </tr>
            <tr >
    <?php
        foreach ($programacion_accion as $data) {
            ?>
             <td style="text-align: center">
                    <?php
                    echo $data->cantidad_programada;
                    ?>
            </td>
            <?php
        }
    ?>
            </tr>
        </table>
    </div>
</div>

   
<h3 class="text-danger text-center"></br>Formulación de las Actividades para la Acción</h3>
<div class="span-20 expose" >
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Actividad',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_actividad', array('actividad' => $actividad, 'id_accion' => $id_accion, 'programacion' => $programacion, 'form' => $form), TRUE),
            )
    );
    ?>
</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Lista de Actividades',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_lista_actividades', array('actividad' => $actividad, 'id_accion' => $id_accion, 'lista_actividad' => $lista_actividad, 'form' => $form), TRUE),
            )
    );
    ?>
</div>
<div class="pull-left">
    <?php
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'link',
        'icon' => 'glyphicon glyphicon-chevron-left',
        'size' => 'large',
        'context' => 'primary',
        'url' => Yii::app()->createUrl("poa/create_accion", array('id_poa' => $id_poa, 'tipo' => $tipo)),
        'label' => $actividad->isNewRecord ? 'Agregar Acción' : 'Save',
    ));
?>
</div>
<div id="overlay"></div>

<?php $this->endWidget(); ?>