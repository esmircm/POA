<h3 class="text-danger text-center"><?php echo $tipo_poa->descripcion ?> </h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<?php echo $form->errorSummary($poa); ?>
    
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($poa,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)), 'label' => $tipo_poa->descripcion)); ?>
        </div>
    </div>
    
    <?php
        if($tipo_poa->id_maestro == 70){
    ?>
    <div class='row'>
        <div class='col-md-6'>
        <?php
//        $fecha = '01-01-' . date('Y');
        echo $form->datePickerGroup($poa, 'fecha_inicio', array('widgetOptions' =>
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
        ?>
        </div>
        
        <div class='col-md-6'>
        <?php
//        $fecha = '01-01-' . date('Y');
        echo $form->datePickerGroup($poa, 'fecha_final', array('widgetOptions' =>
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
        ?>
        </div>
    </div>
    <?php
        }
    ?>
    <div class='row'>
        <div class='col-md-12'>
	<?php echo $form->textAreaGroup($poa,'obj_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>500)))); ?>    
        </div>
    </div>
    <?php
    if($tipo_poa->id_maestro == 70){
    ?>
    <div class='row'>
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($poa,'obj_historico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
        
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($poa,'obj_estrategico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
    </div>

    <div class='row'>
        <div class='col-md-12'>
        <?php 
        echo $form->textAreaGroup($poa,'obj_institucional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
        ?>
        </div>
    </div>
    <?php
    }
    ?>
    <div class='row'>
        <div class='col-md-12'>
	<?php echo $form->textAreaGroup($poa,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
        </div>
    </div>
    <p class="help-block">Los campos con <span class="required">*</span> son requeridos.</p>
<?php  ?>