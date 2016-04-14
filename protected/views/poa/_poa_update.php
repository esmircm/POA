<h3 class="text-danger text-center">Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($model); ?>
    
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)))); ?>
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
    <?php
        }
    ?>
    <div class='row'>
        <div class='col-md-12'>
	<?php echo $form->textAreaGroup($model,'obj_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)))); ?>    
        </div>
    </div>
    <?php
    if($_GET['tipo'] == 70){
    ?>
    <div class='row'>
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($model,'obj_historico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
        
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($model,'obj_estrategico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
    </div>

    <div class='row'>
        <div class='col-md-12'>
        <?php 
        echo $form->textAreaGroup($model,'obj_institucional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-6'>
        <?php 
        echo $form->dropDownListGroup($model, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '35')), 'id_maestro', 'descripcion'),
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
    <div class='row'>
        <div class='col-md-12'>
	<?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
        </div>
    </div>
    <?php
    }
    ?>
    <p class="help-block">Los campos con <span class="required">*</span> son requeridos.</p>
<?php  ?>