<?php
/* @var $this PersonalController */
/* @var $model Personal */
/* @var $form CActiveForm alert ('ver'); */
?>

<?php
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
Yii::app()->clientScript->registerScript('Personal', "
    $(document).ready(function(){
        $('.numero').numeric();
        $('#Personal_grado_licencia').numeric();         
        $('#Personal_peso').numeric(); 
        $('#Personal_zona_postal_residencia').numeric();
        $('#Personal_anios_servicio_apn').numeric();
        $('#s2id_autogen2').numeric();
        $('#s2id_autogen1').numeric();
        $('#s2id_autogen3').numeric();
        $('#Personal_numero_sso').numeric();
        $('#Personal_estatura').numeric();
        $('#Personal_numero_libreta_militar').numeric();
        $('#grado_licencia').val('');
    });
");
?>


<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<div class="row">  

    <div class="col-md-3">
        <label class="control-label required" >Tipo Vivienda<span class="required">*</span></label>
        <select id="tipo_vivienda" class="form-control" name="Personal[tipo_vivienda]" placeholder="tipo_vivienda"required="required">
            <option value="0">SELECCIONE</option>
            <option value="C">CASA</option>
            <option value="A">APARTAMENTO</option>
            <option value="B">HABITACIÓN</option>
            <option value="H">HOTEL</option>
<!--            <option value="N">NO APLICA</option>-->
        </select>
    </div>

    <div class="col-md-3">
        <label class="control-label required" >Tenencia de Vivienda<span class="required">*</span></label>
        <select id="tenencia_vivienda" class="form-control" name="Personal[tenencia_vivienda]" placeholder="tenencia_vivienda"required="required">
            <option value="">SELECCIONE</option>
            <option value="A">ALQUILADA</option>
            <option value="P">PROPIA</option>
            <option value="H">PAGANDO</option>
            <option value="F">FAMILIAR</option>
<!--            <option value="N">NO APLICA</option>-->
        </select>
    </div>

    <div class="col-md-3" >
        <?php echo CHtml::activeLabel($model, 'maneja'); ?><span class="required">*</span></label><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => CHtml::activeId($model, 'maneja'),
            'attribute' => 'maneja',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'maneja',
                'onChange' => 'Maneja()'
            )
                )
        );
        ?>        
    </div>


    <div class='col-md-3 datoManeja'  style="display: none">
        <?php
        echo $form->dropDownListGroup(
                $model, 'grado_licencia', array(
            'wrapperHtmlOptions' => array(
                'class' => 'col-sm-5',
            ),
            'widgetOptions' => array(
                'data' => array('' => 'SELECCIONE', '1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5'),
                'htmlOptions' => array('grado_licencia' => true),
            )
                )
        );
        ?>
    </div>
</div>    

<div class="row">
    <div class="col-md-3" >
        <?php echo CHtml::activeLabel($model, 'tiene_vehiculo'); ?><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => CHtml::activeId($model, 'tiene_vehiculo'),
            'attribute' => 'tiene_vehiculo',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'tiene_vehiculo',
                'onChange' => 'Vehiculo()'
            )
                )
        );
        ?>        
    </div>

    <div class='col-md-3 datoVehiculo'  style="display: none">
        <?php
        echo $form->textFieldGroup($model, 'marca_vehiculo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar',))));
        ?>
    </div>

    <div class='col-md-3 datoVehiculo'  style="display: none">
        <?php
        echo $form->textFieldGroup($model, 'modelo_vehiculo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar',))));
        ?>
    </div>

    <div class='col-md-3 datoVehiculo'  style="display: none">
        <?php
        echo $form->textFieldGroup($model, 'placa_vehiculo', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'maxlength' => "7",))));
        ?>
    </div>

</div> 










