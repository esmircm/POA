<?php
/* @var $this PersonalController */
/* @var $model Personal */
/* @var $form CActiveForm alert ('ver'); */
?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>
<?php echo $form->hiddenField($model, 'id_personal', array('type' => "hidden")); ?>

<div class="row">

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'cedula', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric', 'readonly' => true))));
        ?>

    </div> 

</div>

<div class="row">  
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'primer_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'readonly' => true))));
        ?>
    </div> 

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'segundo_nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'primer_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'readonly' => true))));
        ?>
    </div> 

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'segundo_apellido', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
</div> 

<div class="row">  

    <div class="col-md-3">
        <label>Sexo<span></span></label>
        <select id="Personal_sexo" class="form-control" name="Personal[sexo]" placeholder="sexo" readonly="readonly" >
            <option value="">SELECCIONE</option>
            <option value="M">MASCULINO</option>
            <option value="F">FEMENINO</option>
        </select>
    </div>

    <div class="col-md-3">
        <?php
        echo $form->datePickerGroup($model, 'fecha_nacimiento', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'dd/mm/yyyy',
                    'startView' => 0,
                    'minViewMode' => 0,
                    'todayBtn' => 'linked',
                    'weekStart' => 0,
                    'autoclose' => true,
                ),
                'htmlOptions' => array(
                    'class' => 'span5',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                //'beforeShowDay' => 'DisableDays',
                )
        );
        ?>
    </div> 

    <div class="col-md-3">
        <label>Nacionalidad<span></span></label>
        <select id="Personal_nacionalidad" class="form-control" name="Personal[nacionalidad]" placeholder="nacionalidad" readonly="readonly">
            <option value="">SELECCIONE</option>
            <option value="E">EXTRANJERO</option>
            <option value="V">VENEZOLANO</option>
        </select>
    </div>

    <div class="col-md-3">
        <label class="control-label required" >Estado Civil<span class="required">*</span></label>
        <select id="estado_civil" class="form-control" name="Personal[estado_civil]" placeholder="estado_civil">
            <option value="">SELECCIONE</option>
            <option value="S">SOLTERO(A)</option>  
            <option value="C">CASADO(A)</option>            
            <option value="U">CONCUBINO (A)</option>
            <option value="D">DIVORCIADO(A)</option> 
            <option value="V">VIUDO(A)</option> 
        </select>
    </div>

</div>

<div class="row"> 

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'numero_sso', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'maxlength' => "9",))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'numero_rif', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'placeholder' => 'V-12345678-9', 'maxlength' => "12",))));
        ?>

    </div>  

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'numero_libreta_militar', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'placeholder' => '000-00-00-00', 'maxlength' => "12",))));
        ?>
    </div> 


    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'peso', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'maxlength' => "3",))));
        ?>
    </div> 

</div> 

<div class="row"> 

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'estatura', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'maxlength' => "4",))));
        ?>
    </div> 

    <div class="col-md-3">
        <label class="control-label required" >Diestralidad<span class="required">*</span></label>
        <select id="diestralidad" class="form-control" name="Personal[diestralidad]" placeholder="diestralidad">
            <option value="">SELECCIONE</option>
            <option value="D">DERECHO(A)</option>
            <option value="Z">ZURDO(A)</option>
            <option value="A">AMBIDIESTRO</option>            

        </select>
    </div>

    <div class="col-md-3">
        <label class="control-label required" >Grupo Sanguineo<span class="required">*</span></label>
        <select id="grupo_sanguineo" class="form-control" name="Personal[grupo_sanguineo]" placeholder="grupo_sanguineo">
            <option value="">SELECCIONE</option>
            <option value="A+">A+</option>
            <option value="B+">B+</option>
            <option value="O+">O+</option>
            <option value="A-">A-</option>
            <option value="B-">B-</option>
            <option value="O-">O-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option> 
            
        </select>
    </div>
    <div class="col-md-3">
        <?php
        echo $form->dropDownListGroup($puebloindigena, 'cod_pueblo_indigena', array('wrapperHtmlOptions' => array('class' => 'col-sm-4 limpiar'),
            'widgetOptions' => array(
                'data' => Puebloindigena::FindBuscarPuebloindigenaByPadreSelect('descripcion DESC'),
                'htmlOptions' => array('empty' => 'SELECCIONE'),
            )
                )
        );
        ?>
    </div>
</div> 
<div class="row"> 
    <div class="col-md-3" >
        <?php echo CHtml::activeLabel($model, 'madre_padre'); ?><span class="required">*</span></label><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => CHtml::activeId($model, 'madre_padre'),
            'attribute' => 'madre_padre',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'madre_padre',
            )
                )
        );
        ?>        
    </div>
    <div class="col-md-3" >
        <?php echo CHtml::activeLabel($model, 'discapacidad'); ?><span class="required">*</span></label><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => CHtml::activeId($model, 'discapacidad'),
            'attribute' => 'discapacidad',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'discapacidad',
                'onChange' => 'Discapacidad()'
            )
                )
        );
        ?>        
    </div>
    <div class='col-md-3 datoDiscapacidad'  style="display: none">
        <label>Tipo Discapacidad<span></span></label>
        <select id="tipodiscapacidad" class="form-control" name="Personal[tipodiscapacidad]" placeholder="Tipodiscapacidad">
            <option value="">SELECCIONE</option>
            <option value="S">SENSORIAL</option>
            <option value="M">MOTRICES</option>
            <option value="I">INTELECTUAL</option>
        </select>
    </div>
</div> 



