<?php
// $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
//	'id'=>'familiar-form',
//	'enableAjaxValidation'=>false,
//)); 
?>



<div class="row">

    <div class="col-md-2">
        <label>Nivel Educativo<span></span></label>
        <select id="Familiar_nivel_educativo" class="form-control" name="Familiar[nivel_educativo]" placeholder="nivel_educativo" >
            <option value="">SELECCIONE</option>
            <option value = "P">PRESCOLAR</option>
            <option value = "B">BASICA</option>
            <option value = "I">PRIMARIA</option>
            <option value = "D">DIVERSIFICADO</option>
            <option value = "H">BACHILLERATO</option>
            <option value = "T">TECNICO MEDIO</option>
            <option value = "S">TECNICO SUPERIOR</option>
            <option value = "U">UNIVERSITARIO</option>
            <option value = "E">ESPECIALIZACIÓN</option>
            <option value = "M">MAESTRIA</option>
            <option value = "C">DOCTORADO</option>
            <option value = "R">POSTDOCTORADO</option>
            <option value = "G">POSTGRADO</option>
            <option value = "L">DIPLOMADO</option>
            <option value = "N">NINGUNOS</option>
        </select>
                <?php ?>
      </div>

    <div class='col-md-2 datoNivel'>
        <?php echo $form->textFieldGroup($model, 'grado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar','onChange' => 'Nivel()', 'maxlength' => 2)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'promedio_nota', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 2)))); ?>
    </div>
    
    <div class="col-md-2" >
        <?php echo CHtml::activeLabel($model, 'goza_utiles'); ?><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'goza_utiles',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'goza_utiles','span5 limpiar',

            )
                )
        );
        ?>        
    </div>

</div>

<?php // $this->endWidget(); ?>
