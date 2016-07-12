<h3 class="text-danger text-center"><?php echo $tipo_poa->descripcion ?> </h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($poa); ?>
    
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
            <!--<div class='animatedParent' data-sequence='500' >-->
    <!--<div class="animated growIn slower" data-id='1'>-->
    <div class="aparecer">
        <?php echo $form->textAreaGroup($poa,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800)), 'label' => $tipo_poa->descripcion)); ?>
        <!--</div>-->
        </div>
        </div>
    </div>
    
    <?php
        if($tipo_poa->id_maestro == 70){
    ?>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-6'>
        <?php
//        var_dump($anio_pro);die;
        echo $form->datePickerGroup($poa, 'fecha_inicio', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy-mm-dd',
                    'startView' => 1,
                    'minViewMode' => 0,
                    'autoclose' => true,
                    'startDate' => $anio_pro . '-01-01',
                    'endDate' => $anio_pro . '-12-31',
                ),
                'htmlOptions' => array(
                    'class' => 'span5 limpiar',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                )
        );
        ?>
        </div>
        </div>
        <div class="aparecer">
        <div class='col-md-6'>
        <?php
//        $fecha = '01-01-' . date('Y');
        echo $form->datePickerGroup($poa, 'fecha_final', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy-mm-dd',
                    'startView' => 1,
                    'minViewMode' => 0,
                    'autoclose' => true,
                    'startDate' => $anio_pro . '-01-01',
                    'endDate' => $anio_pro . '-12-31',
                ),
                'htmlOptions' => array(
                    'class' => 'span5 limpiar',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                )
        );
        ?>
        </div>
        </div>
    </div>
<div class="span-12">
    <h4 style="text-align: center; border-bottom: solid 1px ;">Plan de la Patria 2013-2019</h4>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-4'>
            
	<?php 
        $criteria = new CDbCriteria;
        $criteria->order = 'id_maestro ASC';
        echo $form->dropDownListGroup($poa, 'fk_historico', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86), $criteria), 'id_maestro', 'descripcion2'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarHistorico'),
                            'success'=>'function(datos){
                                $("#Poa_fk_nacional").html(datos["html1"]);
                                $("#Poa_fk_historico_descripcion").val(datos["html2"]);
                            }',   
                            'dataType' => 'json',
//                            'update' => '#Poa_fk_nacional',
//                            'type' => 'POST',
//                            'url' => CController::createUrl('ValidacionJs/BuscarNacional'),
//                            'update' => '#lol',
                        ),
                        
                        
                        'required' => true,
                    ),
                )
                    )
            );
//        echo $form->textAreaGroup($poa,'obj_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800))));
        ?>    
        </div>
        </div>
        <div class="aparecer">
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_historico_descripcion" readonly></textarea>
        </div>
    </div>
    </div>
   
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($poa, 'fk_nacional', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarNacional'),
//                            'update' => '#Poa_fk_estrategico',
                            'success'=>'function(datos){
                                $("#Poa_fk_estrategico").html(datos["html1"]);
                                $("#Poa_fk_nacional_descripcion").val(datos["html2"]);
                            }',   
                            'dataType' => 'json',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );
        ?>
        </div>
        </div>
        <div class="aparecer">
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_nacional_descripcion" readonly></textarea>
        </div>
        </div>
    </div>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($poa, 'fk_estrategico', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarEstrategico'),
//                            'update' => '#Poa_fk_general',
                            'success'=>'function(datos){
                                $("#Poa_fk_general").html(datos["html1"]);
                                $("#Poa_fk_estrategico_descripcion").val(datos["html2"]);
                            }',   
                            'dataType' => 'json',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );        ?>
        </div>
        </div>
        <div class="aparecer">
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_estrategico_descripcion" readonly></textarea>
        </div>
    </div>
    </div>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($poa, 'fk_general', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarGeneral'),
                            'update' => '#Poa_fk_general_descripcion',
//                            'success'=>'function(datos){
//                                $("#Poa_fk_estrategico_descripcion").val(datos["html2"]);
//                            }',   
//                            'dataType' => 'json',
                        ),
                    ),
                )
                    )
            );        ?>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_general_descripcion" readonly></textarea>
        </div>
        </div>
    </div>
</div>
<div class="span-12" style="">
    <h4 style="text-align: center; color: rgba(255,115,150,1); border-bottom: solid 1px rgba(255,115,150,1);">Plan para la Igualdad y Equidad de Género "Mamá Rosa"</h4>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-12'>
        <?php 
            echo $form->dropDownListGroup($maestro, 'id_maestro', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 922), $criteria), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarMamaRosa'),
                            'update' => '#Poa_fk_estrategico_mr',
                        ),
                        
                        
                        'required' => true,
                    ),
                ),
                'label' => 'Objetivo',
                    )
            );
//        echo $form->textAreaGroup($poa,'obj_institucional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800))));
        ?>
        </div>
        </div>
    </div>
    <div class="row">
        <div class="aparecer">
        <div class="col-md-4">
            <?php
            echo $form->dropDownListGroup($poa, 'fk_estrategico_mr', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarEstrategicoMr'),
                            'success'=>'function(datos){
                                $("#Poa_fk_institucional").html(datos["html1"]);
                                $("#Poa_fk_estrategico_mr_descripcion").val(datos["html2"]);
                            }',   
                            'dataType' => 'json',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );
            ?>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_estrategico_mr_descripcion" readonly></textarea>
        </div>
        </div>
            
    </div>
    <div class="row">
        <div class="aparecer">
        <div class="col-md-4">
            <?php
            echo $form->dropDownListGroup($poa, 'fk_institucional', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarInstitucional'),
                            'update' => '#Poa_fk_institucional_descripcion',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );
            ?>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" id="Poa_fk_institucional_descripcion" readonly></textarea>
        </div>
        </div>
    </div>
</div>
    <div class='row'>
        <div class="aparecer">
        <div class='col-md-6'>
        <?php 
        echo $form->dropDownListGroup($poa, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 35, 'es_activo' => TRUE)), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
        ?>
        </div>
        </div>
        <div class="aparecer">
        <div class='col-md-6'>
        <?php 
        echo $form->textFieldGroup($poa, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
        </div>
    </div>
    </div>
    <?php
    }
    ?>
    <div class='row'>
        <div class="aparecer"data-move-y="200px" data-move-x="-100px">
        <div class='col-md-12'>
             <label><?php if($tipo_poa->id_maestro == 70){ echo 'Descripción del Proyecto'; } else { echo 'Objetivo'; }?></label>
	<?php echo $form->textAreaGroup($poa,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800)), 'label' => FALSE)); ?>
        </div>
    </div>
    </div>
    <p class="help-block">Los campos con <span class="required">*</span> son requeridos.</p>
<?php  ?>