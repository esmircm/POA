<p class="help-block">Fields with <span class="required">*</span> are required.</p>

<?php //echo $form->errorSummary($model); ?>

<?php // echo $form->textFieldGroup($model,'fk_datos_requisicion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>



<div class="row">

<!--    <div class='solii'  style="display: none">-->
    
<!--    <div class="col-md-1">

        <?php // echo $form->textFieldGroup($impu_ac, 'fk_accion_centralizada', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
    </div>
        
    </div>    

    <div class="col-md-1">

        <?php // echo $form->textFieldGroup($impu_ue, 'fk_unidad_ejecutora', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
    </div>

    <div class="col-md-1">
        <?php // echo $form->textFieldGroup($impu_ue, 'fk_proyecto', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
    </div>

    <div class="col-md-1">
        <?php // echo $form->textFieldGroup($impu_ue, 'fk_accion_especifica', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
    </div>-->
    
<!--    <div class="col-md-3">
        <?php // echo $form->textFieldGroup($impu_ac, 'fk_clasificacion_presupuestaria', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>


        <?php // echo $form->labelEx($impu_ac, 'fk_clasificacion_presupuestaria'); ?>
        <?php
//        $this->widget(
//                'booster.widgets.TbSelect2', array(
//            'name' => CHtml::activeId($impu_ac, 'fk_clasificacion_presupuestaria'),
//            'attribute' => 'fk_clasificacion_presupuestaria',
//            'data' => array ('MATERIALES, SUMINISTROS Y MERCANCÍAS' => Maestro::FindMaestrosByPadreSelect(32), 'SERVICIOS NO PERSONALES' => Maestro::FindMaestrosByPadreSelect(122), 'ACTIVOS REALES' => Maestro::FindMaestrosByPadreSelect(219), 'TRANSFERENCIAS Y DONACIONES' => Maestro::FindMaestrosByPadreSelect(332),),
//            'htmlOptions' => array(
//                'style' => 'width: 100%',
//                'placeholder' => 'Seleccione clasificación presupuestaria',
//                'multiple' => false,
//                'id' => CHtml::activeId($impu_ac, 'fk_clasificacion_presupuestaria'),
//            ),
//                )
//        );
        ?>
        
        
    </div>-->


    <div class="col-md-3">
        <?php echo $form->textFieldGroup($impu_ac, 'descripcion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'maxlength' => 150)))); ?>
    </div>

    <div class="col-md-1">
        
        
        
        <?php
        echo $form->dropDownListGroup($impu_ac, 'fk_unidad_medida',
//                array('wrapperHtmlOptions' => array
//                    ('class' => 'col-sm-4 limpiar'),
                array('widgetOptions' => array(
                'data' => Maestro::FindMaestrosByPadreSelect(17),
                
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                    'onChange' => 'Unidad()',
                ),
            ),
                )
        );
        ?>
        
    </div>

    <div class="col-md-1">
        <?php echo $form->textFieldGroup($impu_ac, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
    </div>
    </div>















<?php // echo $form->checkBoxGroup($model,'es_activo'); ?>

<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>




