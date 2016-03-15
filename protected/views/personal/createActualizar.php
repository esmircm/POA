<?php
/* @var $this PersonalController */
/* @var $model Personal */

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
$mascara = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/jquery.mask.min.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'personal-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
//echo '<pre>';var_dump($model->peso);die;
Yii::app()->clientScript->registerScript('Guardar Actualización', "

    $(document).ready(function(){
        if('" . $model->peso . "' != ''){
            $('#Personal_peso').val('" . $model->peso . "');
        }else{
            $('#Personal_peso').val('');
        }
        if('" . $model->estatura . "' != ''){
            $('#Personal_estatura').val('" . $model->estatura . "');
        }else{
            $('#Personal_estatura').val('');
        }
        $('#estado_civil').val('" . $model->estado_civil . "');
        $('#Personal_sexo').val('" . $model->sexo . "');
        $('#Personal_nacionalidad').val('" . $model->nacionalidad . "');
        $('#Puebloindigena_cod_pueblo_indigena').val('" . $model->puebloindigena . "');
        $('#discapacidad').val('" . $model->discapacidad . "');
        $('#tipodiscapacidad').val('" . $model->tipodiscapacidad . "');
        $('#diestralidad').val('" . $model->diestralidad . "');
        $('#s2id_Personal_email').val('" . $model->email . "');
        $('#tipo_vivienda').val('" . $model->tipo_vivienda . "');
        $('#tenencia_vivienda').val('" . $model->tenencia_vivienda . "');
        $('#maneja').val('" . $model->maneja . "');
        $('#grado_licencia').val('" . $model->grado_licencia . "');
        $('#Personal_numero_rif').mask('A-BBBBBBBB-9', {translation: { 'A': {pattern: /[VEve]/}, 'B':{pattern: /[0-9]/}}, clearIfNotMatch: true});
        $('#Personal_numero_libreta_militar').mask('AAA-BB-CC-DD', {translation: { 'A': {pattern: /[0-9]/}, 'B':{pattern: /[0-9]/}, 'C':{pattern: /[0-9]/}, 'D':{pattern: /[0-9]/}}, clearIfNotMatch: true});
  
        $('#Personal_telefono_residencia').mask('ABC99999999', {translation: { 'A': {pattern: /[0]/}, 'B':{pattern: /[42]/}, 'C':{pattern: /[1-9]/}}, clearIfNotMatch: true});
        $('#Personal_telefono_celular').mask('ABC99999999', {translation: { 'A': {pattern: /[0]/}, 'B':{pattern: /[42]/}, 'C':{pattern: /[1-9]/}}, clearIfNotMatch: true});
        $('#Personal_telefono_oficina').mask('ABC99999999', {translation: { 'A': {pattern: /[0]/}, 'B':{pattern: /[42]/}, 'C':{pattern: /[1-9]/}}, clearIfNotMatch: true});
    });
    
    $('#ValidarForm').click(function(){
       

        
        var usuario  = '" . Yii::app()->user->id . "';
            
       
        if($('#Personal_peso').val()==''){
            bootbox.alert('Por favor indique su peso.');
            return false;
        }
        if($('#Personal_estatura').val()==''){
            bootbox.alert('Por favor indique su estatura.');
            return false;
        }


        if($('#diestralidad').val()==''){
            bootbox.alert('Por favor indique la Diestralidad.');
            return false;
            
        }
        if($('#grupo_sanguineo').val()==''){
            bootbox.alert('Por favor indique el Grupo Sanguineo.');
            return false;

        }
        if ($('#Personal_discapacidad').is(':checked')) {
            if($('#tipodiscapacidad').val()==''){
                bootbox.alert('Por favor indique el tipo de discapacidad.');
                return false;
            }
        }
        if($('#Pais_id_pais').val()==1){
            if($('#Ciudad_id_ciudad_nacimiento').val()==''){
                bootbox.alert('Por favor seleccione la ciudad de nacimiento.');
                return false;
            }

        }
        if($('#Pais_id_pais1').val()==1){
            if($('#Ciudad_id_ciudad_residencia').val()==''){
                bootbox.alert('Por favor seleccione la ciudad de residencia.');
                return false;
            }
        }
        if($('#Personal_direccion_residencia').val()==''){
            bootbox.alert('Por favor ingrese la dirección de residencia.');
            return false;
        }
        if($('#Personal_zona_postal_residencia').val()==''){
            bootbox.alert('Por favor ingrese la zona postal de la residencia.');
            return false;
        }
        if($('#Personal_telefono_celular').val()==''){
            bootbox.alert('Por favor ingrese un número celular.');
            return false;
        }
        if($('#tipo_vivienda').val()=='0'){
            bootbox.alert('Por favor debe agregar Tipo de Vivienda');
            return false;
        }
        if($('#tipo_vivienda').val()=='N'){
            if($('#tenencia_vivienda').val()==''){
                bootbox.alert('Por favor seleccione la tenencia de la vivienda.');
                return false;
            }
        }
        if ($('#Personal_maneja').is(':checked')) {
            if($('#Personal_grado_licencia').val()==''){
                bootbox.alert('Por favor seleccione le grado de licencia.');
                return false;
            }
        }
        
        if ($('#Personal_tiene_vehiculo').is(':checked')) {
            if($('#Personal_marca_vehiculo').val()==''){
                bootbox.alert('Por favor indique la marca del vehiculo.');
                return false;
            }
            if($('#Personal_modelo_vehiculo').val()==''){
                bootbox.alert('Por favor indique el modelo del vehiculo.');
                return false;
            }
            if($('#Personal_placa_vehiculo').val()==''){
                bootbox.alert('Por favor indique la placa del vehiculo.');
                return false;
            }
        }

          if (confirm('¿Está seguro que desea continuar con la actualización?') == false) {//pido una confirmación
               return false;
        }
});
    

");
?>

<h3 class=" text-center">Actualización de Datos del Personal</h3>
<div class="span-20">
    <?php
//    $traza = Traza::getTraza(0);
//    $this->widget(
//            'booster.widgets.TbProgress', array(
//        'context' => 'success', // 'info', 'success' or 'danger'
//        'percent' => $traza['valor'], // the progresss
//        'striped' => true,
//        'content' => $traza['porcentaje'],
//            )
//    );
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Datos Personales',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_form', array('model' => $model, 'form' => $form, 'puebloindigena' => $puebloindigena), TRUE),
            )
    );
    ?>
</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Datos de Nacimiento',
        'context' => 'primary',
        'headerIcon' => 'list',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_datosNacimiento', array('model' => $model, 'form' => $form, 'pais' => $pais, 'estado' => $estado), TRUE),
            )
    );
    ?>

</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Datos de Residencia',
        'context' => 'primary',
        'headerIcon' => 'list',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_datosRecidencia', array('model' => $model, 'form' => $form, 'pais' => $pais, 'estado' => $estado), TRUE),
            )
    );
    ?>

</div>

<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Datos Condición de la Vivienda y Vehículo',
        'context' => 'primary',
        'headerIcon' => 'pencil',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_datosCondicion', array('model' => $model, 'form' => $form), TRUE),
            )
    );
    ?>

</div>

<div class="well">
    <div class="row">



        <div class="pull-right">
            <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'submit',
                'icon' => 'glyphicon glyphicon-floppy-saved',
                'context' => 'primary',
                'size' => 'large',
                'label' => 'Finalizar Actualización',
                'id' => 'ValidarForm',
            ));
            ?>
        </div>
    </div>
</div>

<?php $this->endWidget(); ?>
