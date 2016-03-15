<h3 class="text-danger text-center">Proyecto Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model); ?>
    
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($model,'nombre_proyecto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)))); ?>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-12'>
	<?php echo $form->textAreaGroup($model,'objetivo_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)))); ?>    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
        <?php
//        $fecha = '01-01-' . date('Y');
        echo $form->datePickerGroup($model, 'fecha_inicio', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy-mm-dd',
                    'startView' => 0,
                    'minViewMode' => 0,
                    'autoclose' => true,
//                    'startDate' => $fecha,
                ),
                'htmlOptions' => array(
                    'class' => 'span5 limpiar',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                )
        );
//	echo $form->textFieldGroup($proyecto,'fecha_inicio',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); 
        ?>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
	<?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
        </div>
    </div>
    <p class="help-block">Los campos con <span class="required">*</span> son requeridos.</p>
<?php  ?>