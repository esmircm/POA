<?php
/* @var $this PersonalController */
/* @var $model Personal */
/* @var $form CActiveForm alert ('ver'); */
?>
<?php
//if (!empty($model->id_ciudad_residencia)) {
//    $id_Estado_residencia = Ciudad::model()->findByPk($model->id_ciudad_residencia)->id_estado; // consulta en la tabla ciudad el id_ciudad y id_estado 
//    $id_pais_residencia = Estado::model()->findByPk($id_Estado_residencia)->id_pais; // consulta en la tabla estado el id_estado y id_pais  
//} else {
//    $id_pais_residencia = '';
//    $id_Estado_residencia = '';
//    $ciudad = '';
//}
//         IdPais1 = '" . $id_pais_residencia . "'; 
//         IdEstado1 = '" . $id_Estado_residencia . "'; 
//         IdCiudad1 = '" . $model->id_ciudad_residencia . "'; 
//    $(document).ready(function(){
//
//
//         $('#Pais_id_pais1').val(IdPais1);
//
//         $.get('" . CController::createUrl('ValidacionJs/BuscarEstadosRes') . "', {id_pais1: IdPais1 }, function(data){
//             $('#Estado_id_estado1').html(data);
//             $('#Estado_id_estado1').val(IdEstado1);
//
//         });
//         $.get('" . CController::createUrl('ValidacionJs/BuscarCiudadRes') . "', {id_estado1: IdEstado1 }, function(data){
//             $('#Personal_id_ciudad_residencia').html(data);
//             $('#Personal_id_ciudad_residencia').val(IdCiudad1);
//
//         });
//     });
?>
<script type="text/javascript">
    function validateEmail(sEmail) {
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (filter.test(sEmail)) {
            return true;
        }else {
            return false;
        }
    }
</script>
<?php Yii::app()->clientScript->registerScript('datosRecidencia', "
    
          
    $('#Pais_id_pais1').change(function(){
        if($(this).val() != 1){
            html2 = '<option value=\"\">SELECCIONE</option>';
            $('#Ciudad_id_ciudad_residencia').html(html2);
            $('#divEstado1').hide();
            $('#divCity1').hide();
            
            $('#Ciudad_id_ciudad_residencia').val('falce');
        }else{
            $('#divEstado1').show();
            $('#divCity1').show();
        }

   });
    $('#Pais_id_pais').change(function(){
        if($(this).val() != 1){
            html2 = '<option value=\"\">SELECCIONE</option>';
            $('#Ciudad_id_ciudad_nacimiento').html(html2);
        }

   });
 
    $('#Personal_email').focusout(function() {
        var Email = $.trim($('#Personal_email').val());
        if (Email== '') {
            $('#Personal_email').val('');
        }
        if (validateEmail(Email)) {
            $('#Personal_email').val(Email);
        }else {
            $('#Personal_email').val('');
        }
    });
"); ?>
<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>
<div class="row">  
    <div class="col-md-3">
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'nombre DESC';
        echo $form->dropDownListGroup($pais, 'id_pais1', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
            'widgetOptions' => array(
                'data' => CHtml::listData(Pais::model()->findAll($criteria), 'id_pais', 'nombre'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarEstadosRes'),
                        'update' => '#' . CHtml::activeId($estado, 'id_estado1'),
                    ),
                ),
            )
                )
        );
        ?>
    </div>
    <div id='divEstado1' class="col-md-3" style="display: none">
        <?php
        echo $form->dropDownListGroup($estado, 'id_estado1', array('wrapperHtmlOptions' => array('class' => 'col-sm-12',),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarCiudadRes'),
                        'update' => '#' . CHtml::activeId($model, 'id_ciudad_residencia'),
                    ),
                    'empty' => 'SELECCIONE',
                ),
            )
                )
        );
        ?>
    </div>
    <div class="col-md-3" id='divCity1' style="display: none">
        <?php
        echo $form->dropDownListGroup($model, 'id_ciudad_residencia', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar',),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',),)));
        ?>  
    </div>
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'direccion_residencia', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar'))));
        ?>
    </div> 
</div>

<div class="row"> 

    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'zona_postal_residencia', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => "4"))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'telefono_residencia', array('widgetOptions' => array('htmlOptions' => array('placeholder' => 'Ejemplo: 0999999999'))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'telefono_celular', array('widgetOptions' => array('htmlOptions' => array('placeholder' => 'Ejemplo: 0999999999'))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'telefono_oficina', array('widgetOptions' => array('htmlOptions' => array('placeholder' => 'Ejemplo: 0999999999'))));
        ?>
    </div> 
</div> 

<div class="row">  
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'email', array('widgetOptions' => array('htmlOptions' => array('placeholder' => 'cuenta@dominio.com'))));
        ?>
    </div> 
    <div class='col-md-3'>
        <?php
        echo $form->textFieldGroup($model, 'anios_servicio_apn', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2 limpiar', 'maxlength' => "2"))));
        ?>
    </div> 
</div> 
