<h3 class="text-danger text-center">Proyecto Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
   
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php echo $form->textAreaGroup($model,'nombre_proyecto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textAreaGroup($model,'objetivo_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>    
        </div>
    </div>
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
        <?php
	echo $form->textFieldGroup($model,'fecha_inicio',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); 
        ?>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-12' style="text-align: center">
	<?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
        </div>
    </div>
