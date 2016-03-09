
<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<div class="row">

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric'))));
        ?>

    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'primer_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'segundo_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'primer_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($personal, 'segundo_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 

    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($cargo, 'descripcion_cargo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
   
</div> 



