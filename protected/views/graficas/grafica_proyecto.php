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
<script type="text/javascript">
    $(document).ready(function() {

        var altura = $('.left-panel').offset().top;
        $(window).on('scroll', function(){
            if ( $(window).scrollTop() > altura - 120 ){
            $('.left-panel').addClass('left-panel-fixed');
            } else {
            $('.left-panel').removeClass('left-panel-fixed');
            }
        });
    })

</script>
    <div class="left-panel">
        <div class="button-panel">
            
        </div>
        <div class="button-panel-close">
            
        </div>
        <div class="info-panel">
            <h1>Graficación Avanzada</h1>
            <div class="col-md-12">
            <?php
            
            echo $form->dropDownListGroup($maestro, 'id_maestro', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',), 'label' => 'Tipos de Periodos de Ejecución',
                'widgetOptions' => array(
                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 83)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarTiempoMedida'),
                            'update' => '#MaestroPoa2_id_maestro',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );
            ?>
            </div>
            <div class="col-md-12" >
                <?php
                echo $form->dropDownListGroup($maestro2, 'id_maestro', array('wrapperHtmlOptions' => array('class' => 'col-sm-12'), 'label' => 'Periodos de Ejecución',
                    'widgetOptions' => array(
                        'htmlOptions' => array(
                            'id' => 'MaestroPoa2_id_maestro',
                            'name' => 'MaestroPoa2_id_maestro',
                            'empty' => 'SELECCIONE',
                            'required' => true,
                        ),
                    )
                        )
                );
                ?>
            </div>
            <div class="col-md-12" style="margin: 0 auto; text-align: center; margin-bottom: 20px;">
                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'size' => 'large',
                    'context' => 'primary',
                    'label' => $maestro->isNewRecord ? 'Graficar' : 'Save',
                ));
                ?>
            </div>
            <?php
            if(isset($_POST['MaestroPoa'])){
                ?>
                <div class="col-md-12" style="margin: 0 auto; text-align: center; margin-bottom: 20px;">
                <?php
                    $this->widget('booster.widgets.TbButton', array(
                        'buttonType' => 'link',
                        'size' => 'large',
                        'context' => 'success',
                        'url' => Yii::app()->createUrl("graficas/GraficaAccionesProyecto", array("id_poa"=>$id_poa, "tipo"=>$tipo)),
                        'label' => $maestro->isNewRecord ? 'Ver Gráfica General' : 'Save',
                    ));
                ?>
                </div>
                <?php
            }
            ?>
        </div>
       
    </div>
<div class='animatedParent' data-sequence='500' >
<div style="width: 90%; margin: 0 auto; text-align: center; background-color: rgba(94, 152, 201, 1); border-radius: none; color: #FFF; font-size: 16px; overflow: hidden; position: relative">

    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <div class="animated bounceInUp" data-id='1'> 
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $poa->tipo_poa; ?></span>
    </div>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $form->textAreaGroup($poa, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; color: #FFF; font-size: 20px; margin-top: 50px;', 'readOnly' => true)), 'label' => false));
    ?>
    </div>
</div>
</div>

<?php $this->endWidget();  ?>

<div style="width: 90%; margin: 0 auto; text-align: center; font-size: 16px; border-bottom: 1px solid #000;">
    <span style="margin-top: 20px; margin-bottom: 5px; display: inline-block; width: 100%;"><?php echo $poa->obj_general ?>  </span> 
</div>
<div style="width: 90%; margin: 0 auto; text-align: center; font-size: 16px; margin-bottom: 20px; border-bottom: 1px solid #000;">
    <span style="margin-top: 20px; margin-bottom: 5px; display: inline-block; width: 100%;"><?php echo $poa->dependencia_responsable ?>  </span> 
</div>


    <?php
    
    echo $this->renderPartial('_proyecto_rendimiento', array('html' => $html), TRUE);
    
    ?>


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





