<?php
// $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
//	'id'=>'familiar-form',
//	'enableAjaxValidation'=>false,
//));

Yii::app()->clientScript->registerScript('', "
     $(document).ready(function(){
        $('#Familiar_cedula_familiar').val('" . $model->cedula_familiar . "');
        $('#Familiar_primer_nombre').val('" . $model->primer_nombre . "');
        $('#Familiar_segundo_nombre').val('" . $model->segundo_nombre . "');
        $('#Familiar_primer_apellido').val('" . $model->primer_apellido . "');
        $('#Familiar_segundo_apellido').val('" . $model->segundo_apellido . "');
        $('#Familiar_estado_civil').val('" . $model->estado_civil . "');
        $('#Familiar_sexo').val('" . $model->sexo . "');
        $('#Familiar_fecha_nacimiento').val('" . $model->fecha_nacimiento . "');
        $('#Familiar_parentesco').val('" . $model->parentesco . "');
        $('#Familiar_grupo_sanguineo').val('" . $model->grupo_sanguineo . "');
            
     
 });
 ");
//var_dump($model);
//exit;
?>

    <?php echo $form->hiddenField($model, 'id_familiar', array('type' => "hidden", 'value' => $_GET['id'], )); ?>
<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<div class="row">

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'cedula_familiar', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readonly' => true, 'maxlength' => 100)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'primer_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readonly' => true, 'maxlength' => 100)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'segundo_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readonly' => true, 'maxlength' => 100)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'primer_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readonly' => true, 'maxlength' => 100)))); ?>
    </div>

    <div class='col-md-2'>
        <?php echo $form->textFieldGroup($model, 'segundo_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readonly' => true, 'maxlength' => 100)))); ?>
    </div>
</div>

<div class="row"> 

    <div class="col-md-2">
        <label>Estado Civil<span class="required">*</span></label>
        <select id="Familiar_estado_civil" class="form-control" name="Familiar[estado_civil]" placeholder="estado_civil" >
            <option value="">SELECCIONE</option>
            <option value = "S">SOLTERO(A)</option>
            <option value = "C">CASADO(A)</option>
            <option value = "D">DIVORCIADO(A)</option>
            <option value = "V">VIUDO(A)</option>
            <option value = "U">UNIDO(A)</option>
        </select>
        <?php
//        $criteria = new CDbCriteria;
//        echo $form->dropDownListGroup($model, 'estado_civil', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
//            'widgetOptions' => array(
//                'data' => CHtml::listData(Familiar::model()->findAll($criteria), 'estado_civil', 'estado_civil'),
//                'htmlOptions' => array(
//                    'class' => 'span5 limpiar',
//                    'empty' => 'SELECCIONE',
//                ),
//            )
//                )
//        );
        ?>

    </div>
    <div class="col-md-2">
        <label>Sexo<span class="required">*</span></label>
        <select id="Familiar_sexo" class="form-control" name="Familiar[sexo]" placeholder="sexo" DISABLED="DISABLED">
            <option value="">SELECCIONE</option>
            <option value="M">MASCULINO</option>
            <option value="F">FEMENINO</option>
        </select>

    </div>


    <div class='col-md-2'>
        <?php
        echo $form->datePickerGroup($model, 'fecha_nacimiento', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'startView' => 0,
                    'minViewMode' => 0,
                    'todayBtn' => 'linked',
                    'weekStart' => 0,
                    'autoclose' => true,
                ),
                'htmlOptions' => array(
                    'class' => 'span5',
                    'DISABLED' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                )
        );
        ?>
    </div>

    <div class="col-md-2">
        <label>parentesco<span class="required">*</span></label>
        <select id="Familiar_parentesco" class="form-control" name="Familiar[parentesco]" placeholder="parentesco" DISABLED="DISABLED">
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
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'mismo_organismo', 'span5 limpiar',
            )
                )
        );
        ?>        
    </div>
</div>

<?php // $this->endWidget();   ?>
