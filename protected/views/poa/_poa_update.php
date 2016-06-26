<h3 class="text-danger text-center">Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model); ?>
    
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800)))); ?>
        </div>
    </div>

    <?php
        if($_GET['tipo'] == 70){
    ?>
    <div class='row'>
        <div class='col-md-6'>
        <?php
//        var_dump($anio_pro);die;
        echo $form->datePickerGroup($model, 'fecha_inicio', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy-mm-dd',
                    'startView' => 0,
                    'minViewMode' => 0,
                    'autoclose' => true,
                    'startDate' => $model->anio . '-01-01',
                    'endDate' => $model->anio . '-12-31',
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
        
        <div class='col-md-6'>
        <?php
//        $fecha = '01-01-' . date('Y');
        echo $form->datePickerGroup($model, 'fecha_final', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy-mm-dd',
                    'startView' => 0,
                    'minViewMode' => 0,
                    'autoclose' => true,
                    'startDate' => $model->anio . '-01-01',
                    'endDate' => $model->anio . '-12-31',
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
<div class="span-12">
    <h4 style="text-align: center; border-bottom: solid 1px ;">Plan de la Patria 2013-2019</h4>
    <div class='row'>
        <div class='col-md-4'>
            
	<?php 
        $criteria = new CDbCriteria;
        $criteria->order = 'id_maestro ASC';
        echo $form->dropDownListGroup($model, 'fk_historico', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86), $criteria), 'id_maestro', 'descripcion2'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarHistorico'),
                            'success'=>'function(datos){
                                $("#VswPoa_fk_nacional").html(datos["html1"]);
                                $("#VswPoa_fk_historico_descripcion").val(datos["html2"]);
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
        <div class="col-md-8">
            <textarea class="form-control" id="VswPoa_fk_historico_descripcion" readonly><?php echo $model->obj_historico; ?></textarea>
        </div>
    </div>
   
    <div class='row'>
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($model, 'fk_nacional', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarNacional'),
//                            'update' => '#Poa_fk_estrategico',
                            'success'=>'function(datos){
                                $("#VswPoa_fk_estrategico").html(datos["html1"]);
                                $("#VswPoa_fk_nacional_descripcion").val(datos["html2"]);
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
            <textarea class="form-control" id="VswPoa_fk_nacional_descripcion" readonly><?php echo $model->obj_nacional; ?></textarea>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($model, 'fk_estrategico', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarEstrategico'),
//                            'update' => '#Poa_fk_general',
                            'success'=>'function(datos){
                                $("#VswPoa_fk_general").html(datos["html1"]);
                                $("#VswPoa_fk_estrategico_descripcion").val(datos["html2"]);
                            }',   
                            'dataType' => 'json',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );        ?>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" id="VswPoa_fk_estrategico_descripcion" readonly><?php echo $model->obj_estrategico; ?></textarea>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-4'>
        <?php 
            echo $form->dropDownListGroup($model, 'fk_general', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarGeneral'),
                            'update' => '#VswPoa_fk_general_descripcion',
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
            <textarea class="form-control" id="VswPoa_fk_general_descripcion" readonly><?php echo $model->obj_general; ?></textarea>
        </div>
    </div>
</div>
<div class="span-12" style="">
    <h4 style="text-align: center; color: rgba(255,115,150,1); border-bottom: solid 1px rgba(255,115,150,1);">Plan para la Igualdad y Equidad de Género "Mamá Rosa"</h4>
    <div class='row'>
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
                            'update' => '#VswPoa_fk_estrategico_mr',
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
    <div class="row">
        <div class="col-md-4">
            <?php
            echo $form->dropDownListGroup($model, 'fk_estrategico_mr', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarEstrategicoMr'),
                            'success'=>'function(datos){
                                $("#VswPoa_fk_institucional").html(datos["html1"]);
                                $("#VswPoa_fk_estrategico_mr_descripcion").val(datos["html2"]);
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
            <textarea class="form-control" id="VswPoa_fk_estrategico_mr_descripcion" readonly></textarea>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <?php
            echo $form->dropDownListGroup($model, 'fk_institucional', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
                'widgetOptions' => array(
//                    'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 86)), 'id_maestro', 'descripcion'),
                    'htmlOptions' => array(
                        'empty' => 'SELECCIONE',
                        'ajax' => array(
                            'type' => 'POST',
                            'url' => CController::createUrl('ValidacionJs/BuscarInstitucional'),
                            'update' => '#VswPoa_fk_institucional_descripcion',
                        ),
                        'required' => true,
                    ),
                )
                    )
            );
            ?>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" id="VswPoa_fk_institucional_descripcion" readonly><?php echo $model->obj_institucional; ?></textarea>
        </div>
    </div>
</div>
    <div class='row'>
        <div class='col-md-6'>
        <?php 
        echo $form->dropDownListGroup($model, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 35, 'es_activo' => TRUE)), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
        ?>
        </div>
        
        <div class='col-md-6'>
        <?php 
        echo $form->textFieldGroup($model, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
        </div>
    </div>
    <?php
    }
    ?>
    <div class='row'>
        <div class='col-md-12'>
            <label><?php if($_GET['tipo'] == 70){ echo 'Descripción del Proyecto'; } else { echo 'Objetivo'; }?></label>
	<?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>800)), 'label' => FALSE)); ?>
        </div>
    </div>
    <p class="help-block">Los campos con <span class="required">*</span> son requeridos.</p>
<?php  ?>