
<p class="help-block">Los campos marcados con <span class="required">*</span> son requeridos.</p>

<?php //echo $form->errorSummary($model); ?>

	<?php // echo $form->textFieldGroup($model,'fk_datos_requisicion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>


<div class="row">
    
   <div class="col-md-4">
    
    <?php
        echo $form->datepickerGroup(
                $lugar, 'fecha_estimada_requerida', array(
            'widgetOptions' => array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'dd/mm/yyyy',
                    'startDate' => '-d',
                    'weekStart' => 5,
                    'viewMode' => 2,
                    'minViewMode' => 0,
                    'wrapperHtmlOptions' => array(
                        'class' => 'col-sm-1',
                    ),
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>'
                )
        );
        ?>

        </div>
       
    <div class="col-md-4">
        <?php echo $form->textFieldGroup($lugar,'dependencia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>100)))); ?>
    </div>

    <div class="col-md-4">
        <?php echo $form->textFieldGroup($lugar,'direccion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>150)))); ?>
    </div>

    

</div>



	

	

	<?php // echo $form->checkBoxGroup($model,'es_almacen'); ?>

	

	<?php // echo $form->checkBoxGroup($model,'es_activo'); ?>

	<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>




