<h3 class="text-danger text-center">Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
   
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
        </div>
    </div>
    <?php
        if($model->fk_tipo_poa == 70){
    ?>
    <div class='row'>
        <div class='col-md-6' style="text-align: center">
        <?php
	echo $form->textFieldGroup($model,'fecha_inicio',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); 
        ?>
        </div>
        <div class='col-md-6' style="text-align: center">
        <?php
	echo $form->textFieldGroup($model,'fecha_final',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); 
        ?>
        </div>
    </div>
    <?php
        }
    ?>
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textAreaGroup($model,'obj_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>    
        </div>
    </div>
    <?php
    if($model->fk_tipo_poa == 70){
    ?>
    <div class='row'>
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($model,'obj_historico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));
        ?>
        </div>
        
        <div class='col-md-6'>
        <?php 
        echo $form->textAreaGroup($model,'obj_estrategico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); 
        ?>
        </div>
    </div>

    <div class='row'>
        <div class='col-md-12'>
        <?php 
        echo $form->textAreaGroup($model,'obj_institucional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));
        ?>
        </div>
    </div>
    <?php
    }
    ?>
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
        </div>
    </div>
