<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
Yii::app()->clientScript->registerScript('solicitud', "
    $(document).ready(function(){

        $('.numero').numeric();
        $('#Familiar_cedula_familiar').numeric();
         
         
    });
    ");
?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>
<div class="row">
    <div class='col-md-2'>
        <?php
        echo $form->dropDownListGroup($nacionalidad, 'descripcion', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(Maestro::model()->findAll('padre=:padre', array(':padre' => '11')), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE', 'onchange' => "Limpiar()"
                ),
            )
                )
        );
        ?>
    </div>
    <div class='col-md-2'>
        <?php
        echo $form->textFieldGroup($model, 'cedula_familiar', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar',
                    'onblur' => "BuscaPersona($('#Maestro_descripcion').children(':selected').text(), $('#Familiar_cedula_familiar').val())",
                )
            )
                )
        );
        ?>
    </div>
    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'primer_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100,

            )
             
            ))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'segundo_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'primer_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100,
             'onblur' => "BuscaPersona($('#Maestro_descripcion').children(':selected').text(), $('#Familiar_primer_nombre').val(),$('#Familiar_primer_apellido').val())",
            )))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'segundo_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100)))); ?>
    </div>
</div>

<div class="row"> 

    <div class="col-md-2">
        <label>Estado Civil<span class="required ">*</span></label>
        <select id="Familiar_estado_civil" class="form-control limpiar" name="Familiar[estado_civil]" placeholder="estado_civil" >
            <option value="">SELECCIONE</option>
            <option value = "S">SOLTERO(A)</option>
            <option value = "C">CASADO(A)</option>
            <option value = "D">DIVORCIADO(A)</option>
            <option value = "V">VIUDO(A)</option>
            <option value = "U">UNIDO(A)</option>
        </select>
    </div>
    <div class="col-md-2">
        <label>Sexo<span class="required">*</span></label>
        <select id="Familiar_sexo" class="form-control limpiar" name="Familiar[sexo]" placeholder="sexo" >
            <option value="">SELECCIONE</option>
            <option value="M">MASCULINO</option>
            <option value="F">FEMENINO</option>
        </select>


    </div>


    <div class='col-md-2'>
        <?php
        echo $form->datePickerGroup(
                $model, 'fecha_nacimiento', array(
            'widgetOptions' => array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'dd/mm/yyyy',
                ),
            ),
            'wrapperHtmlOptions' => array(
                'class' => 'span5 limpiar',
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>'
                )
        );
        ?>
    </div>

    <div class="col-md-2">
        <label>parentesco<span class="required">*</span></label>

        <select id="Familiar_parentesco" class="form-control limpiar" name="Familiar[parentesco]" placeholder="parentesco" onchange='Parentesco($(this).val())'>
            <option value="">SELECCIONE</option>
            <option value = "C">CONYUGE</option>
            <option value = "M">MADRE</option>
            <option value = "P">PADRE</option>
            <option value = "H">HIJO(A)</option>
            <option value = "E">HERMANO(A)</option>
            <option value = "S">SUEGRO(A)</option>
            <option value = "A">ABUELO(A)</option>
            <option value = "B">SOBRINO(A)</option>
            <option value = "I">TIO(A)</option>
            <option value = "U">TUTELADOR(A)</option>
        </select>

    </div>
    <div class="col-md-2" >
        <?php echo CHtml::activeLabel($model, 'mismo_organismo'); ?><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'mismo_organismo',
//                   'id'=>'',s
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'mismo_organismo', 'span5 limpiar',
                'onChange' => 'Organismo()'
            )
                )
        );
        ?>        
    </div>
</div>
