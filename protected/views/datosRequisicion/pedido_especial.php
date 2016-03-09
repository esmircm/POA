
<p class="help-block">Fields with <span class="required">*</span> are required.</p>

<?php // echo $form->errorSummary($model); ?>

<div class="row">


    <div class='col-md-8'> 

        <?php echo $form->textFieldGroup($pedido_especial, 'descripcion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'maxlength' => 100)))); ?>

    </div>



    <div class='col-md-2'> 

        <?php echo $form->textFieldGroup($pedido_especial, 'unid_medida', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>

    </div>

    <div class='col-md-2'> 


        <?php echo $form->textFieldGroup($pedido_especial, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>


    </div>


</div>





<?php // echo $form->textFieldGroup($model,'fk_datos_requisicion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>



<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<?php // echo $form->checkBoxGroup($model,'es_activo'); ?>



<?php // $this->endWidget(); ?>
