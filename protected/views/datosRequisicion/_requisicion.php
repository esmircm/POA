<?php
Yii::app()->clientScript->registerScript('solicitud', "
    $(document).ready(function(){
        $('#Tblestado_clvcodigo').change(function () {
            html2 = '<option value=\"\>SELECCIONE</option>';
            $('#Tblmunicipio_clvcodigo').html(html2);
            $('#DatosRequisicion_fk_parroquia').html(html2);

        });
    });
");
?>
<script type="text/javascript">
    function Unidad() {
        if ($('.unidad').is(":checked")) {
            $('.solii').hide('fade');
//            $('.anula').hide('fade');
        } else {
            $('.solii').show('fade');
//            $('.anula').show('fade');
        }
    }
</script>

<?php //echo $form->errorSummary($model); ?>

<center><legend><h4><b>ORGANISMO 58 MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GENERO</b></h4></legend></center><br>  

<p class="help-block">Los campos marcados con <span class="required">*</span> son requeridos.</p>



<div class="row">
    <div class='col-md-4'> 
        <?php
//        echo $form->dropDownListGroup($model, 'fk_tipo_requisicion', array('wrapperHtmlOptions' => array('class' => 'col-sm-4 limpiar'),
//            'widgetOptions' => array(
//                'data' => Maestro::FindMaestrosByPadreSelect(1),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE', 'onchange' => "Limpiar()"
//                ),
//            )
//                )
//        );
        ?>

    </div>

    <div class='col-md-4'> 


        <?php
//        echo $form->dropDownListGroup($model, 'fk_unidad_ejecutora',
////                array('wrapperHtmlOptions' => array
////                    ('class' => 'col-sm-4 limpiar'),
//                array('widgetOptions' => array(
//                'data' => Maestro::FindMaestrosByPadreSelect(5),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE',
//                    'onChange' => 'Unidad()',
//                ),
//            ),
//                )
//        );
        ?>

    </div>




    <div class='col-md-4'>


        <?php
//        echo $form->datepickerGroup(
//                $model, 'anio_requisicion', array(
//            'widgetOptions' => array(
//                'options' => array(
//                    'language' => 'es',
//                    'format' => 'yyyy',
//                    'startDate' => '-y',
//                    'weekStart' => 5,
//                    'viewMode' => 2,
//                    'minViewMode' => 2,
//                    'wrapperHtmlOptions' => array(
//                        'class' => 'datepicker',
//                    ),
//                ),
//            ),
//            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>'
//                )
//        );
        ?>

    </div>

</div>





<div class="row">

    <div class="col-md-4">
        <?php
//        $criteria = new CDbCriteria;
//        $criteria->order = 'strdescripcion ASC';
//        echo $form->dropDownListGroup($estado, 'clvcodigo', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
//            'widgetOptions' => array(
//                'data' => CHtml::listData(Tblestado::model()->findAll($criteria), 'clvcodigo', 'strdescripcion'),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE',
//                    'ajax' => array(
//                        'type' => 'POST',
//                        'url' => CController::createUrl('ValidacionJs/BuscarMunicipiosRequisicion'),
//                        'update' => '#' . CHtml::activeId($municipio, 'clvcodigo'),
//                    ),
//                ),
//            )
//                )
//        );
        ?>
    </div>

    <div class="col-md-4">
        <?php
//        echo $form->dropDownListGroup($municipio, 'clvcodigo', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 ',),
//            'widgetOptions' => array(
//                'htmlOptions' => array(
//                    'ajax' => array(
//                        'type' => 'POST',
//                        'url' => CController::createUrl('ValidacionJs/BuscarParroquiasRequisicion'),
//                        'update' => '#' . CHtml::activeId($model, 'fk_parroquia'),
//                    ),
//                    'empty' => 'SELECCIONE',
//                ),
//            )
//                )
//        );
        ?>
    </div>

    <div class="col-md-4">
        <?php
//        echo $form->dropDownListGroup($model, 'fk_parroquia', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar',),
//            'widgetOptions' => array(
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE',
//                ),
//            )
//                )
//        );
        ?>
    </div>

</div>


<div class="row">

    <div class='col-md-4'>
        <?php // echo $form->textFieldGroup($model, 'ubicacion_geografica', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5'))));  ?>

    </div>



    <div class='col-md-4'>
        <?php // echo $form->textFieldGroup($model, 'ciudad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5'))));  ?>

    </div>



    <!--    <div class='col-md-4'> 
    
    <?php
//        echo $form->dropDownListGroup(
//                $model, 'fk_fuente_financia', array(
//            'wrapperHtmlOptions' => array(
//                'class' => 'col-sm-5',
//            ),
//            'widgetOptions' => array(
//                'data' => Maestro::FindMaestrosByPadreSelect(14),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE'),
//            )
//                )
//        );
    ?>
    
    
    
    
        </div>   -->


</div> 

<div class="row">
    <div class="col-md-3" > 
        <?php
//        $this->widget('booster.widgets.TbButton', array(
//            'buttonType' => 'button',
//            'id' => 'SaveDatosRequisicion',
//            'context' => 'success',
////                'size' => 'large',
//            'label' => 'Guardar',
//            'icon' => 'icon-circle',
//            'htmlOptions' => array(
//                'onClick' => 'GuardarDatosRequisicion('
//                . '$("#DatosRequisicion_fk_tipo_requisicion").val(),'
//                . '$("#DatosRequisicion_fk_unidad_ejecutora").val(),'
//                . '$("#DatosRequisicion_anio_requisicion").val(),'
////                . '$("#Tblestado_clvcodigo").val(),'
////                . '$("#Tblmunicipio_clvcodigo").val(),'
//                . '$("#DatosRequisicion_ubicacion_geografica").val(), '
//                . '$("#DatosRequisicion_fk_parroquia").val(),'
//                . '$("#DatosRequisicion_ciudad").val()) '
//            )
//        ));
        ?>
    </div>
</div>
