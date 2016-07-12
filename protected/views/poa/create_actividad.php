<?php
$this->breadcrumbs = array(
    'Poas' => array('index'),
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
<div class='animatedParent' data-sequence='500' >
<div class="span-20 poa_content" style="box-shadow: none; border-bottom: solid 1px;">
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
    
    <div class="animated rollIn" data-id='1'> 
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $poa->tipo_poa; ?></span>
    </div>
    <!--</div>-->
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
        <?php
        echo $form->textAreaGroup($poa, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; color: #000; font-size: 20px;', 'readOnly' => true)), 'label' => false));
        ?>
    </div>
</div>
</div>
<!--<div class="animated pulse" data-id='2'>--> 
    <div class='col-md-12'>
        <div class="panel panel-default">
            <div class="panel-body">
                <!--<blockquote>-->
                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">
                    <!--<div class='animatedParent' data-sequence='500' >-->
                    <!--<div class="animated pulse" data-id='2'>--> 
                    <div class='col-md-4'>
                        Nombre Acción: <b> <?php echo $accion->nombre_accion; ?> </b>
                    </div>            
                    <!--</div>-->            
                    
                    <!--<div class="animated pulse" data-id='3'>--> 
                    <div class='col-md-4'>
                        Unidad de Medida:<b> <?php echo $accion->unidad_medida; ?> </b>
                    </div> 
                    <!--</div>--> 
                    
<!--                    <div class="animated pulse" data-id='4'> -->
                    <div class='col-md-4'>
                        Cantidad:<b> <?php echo $accion->cantidad; ?> </b>
                    </div> 
                    <!--</div>--> 
                    <!--</div>--> 

                </blockquote>
            </div>
        </div>
    </div>
   

<div class='col-md-12'>
    <div class="panel panel-default responsive">
        <div class="panel-body responsive">

            <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">

                        <center><label for="programacion">Programación</label></center>
                            <div  class="table-responsive">

                            <table  class="animatedParent table table-striped table-bordered dt-responsive nowrap" width="100%" cellspacing="0" data-sequence='500'>
                            <tr>
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
                                    <td class="animated pulse" data-id='4' style="text-align: center"><b>
                                    <?php
                                    echo $data->cantidad_programada;
                                    ?>
                                    </b>            
                                    </td>
                                        <?php
                                    }
                                    ?>
                            </tr>
                        </table>
                </div>

            </blockquote>
        </div>
    </div>
</div>
<!--</div>-->
<!--</div>-->



<h3 class="text-danger text-center"></br>Formulación de las Actividades para la Acción</h3>
<div class='animatedParent expose' data-sequence='500' >
    <div class="animated bounceInRight" data-id='1'> 
        <div class="span-20 expose" >
<?php
$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Actividad',
    'context' => 'primary',
    'headerIcon' => 'user',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
    'content' => $this->renderPartial('_actividad', array('actividad' => $actividad, 'id_accion' => $id_accion, 'programacion' => $programacion, 'form' => $form), TRUE),
    'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),
        )
);
?>
        </div>
    </div>
</div>

<div class="span-20">
<?php
$this->widget(
        'booster.widgets.TbPanel', array(
    'title' => 'Lista de Actividades',
    'context' => 'primary',
    'headerIcon' => 'user',
    'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1; color: #000000; border-bottom: none; border-radius: 0px;'),
    'content' => $this->renderPartial('_lista_actividades', array('actividad' => $actividad, 'id_accion' => $id_accion, 'lista_actividad' => $lista_actividad, 'form' => $form), TRUE),
    'htmlOptions' => array('style' => 'box-shadow: 5px 5px 10px 2px rgba(0,0,0,0.5); border-radius: 0px; border: none;'),
        )
);
?>
</div>
<div class='animatedParent' data-sequence='500' >
    <div class="animated bounceInRight" data-id='1'> 
        <div class="pull-left">
<?php
$this->widget('booster.widgets.TbButton', array(
    'buttonType' => 'link',
    'icon' => 'glyphicon glyphicon-chevron-left',
    'size' => 'large',
    'context' => 'danger',
    'url' => Yii::app()->createUrl("poa/create_accion", array('id_poa' => $id_poa, 'tipo' => $tipo)),
    'label' => $actividad->isNewRecord ? 'Agregar Acción' : 'Save',
));
?>
        </div>
    </div>
</div>
<div id="overlay"></div>

<?php $this->endWidget(); ?>