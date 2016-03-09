<?php
/* @var $this PersonalController */
/* @var $model Personal */
/* @var $form CActiveForm alert ('ver'); */
?>

<?php
//if (!empty($model->id_ciudad_nacimiento)) {
//    $id_Estado_nacimiento = Ciudad::model()->findByPk($model->id_ciudad_nacimiento)->id_estado; // consulta en la tabla ciudad el id_ciudad y id_estado 
//    $id_pais_nacimiento = Estado::model()->findByPk($id_Estado_nacimiento)->id_pais; // consulta en la tabla estado el id_estado y id_pais  
//} else {
//    $id_pais_nacimiento = '';
//    $id_Estado_nacimiento = '';
//    $ciudad = '';
//}
//         IdPais = '" . $id_pais_nacimiento . "'; 
//         IdEstado = '" . $id_Estado_nacimiento . "'; 
//         IdCiudad = '" . $model->id_ciudad_nacimiento . "'; 
//    $(document).ready(function(){
//         $('#Pais_id_pais').val(IdPais);
//
//         $.get('" . CController::createUrl('ValidacionJs/BuscarEstados') . "', {id_pais: IdPais }, function(data){
//             $('#Estado_id_estado').html(data);
//             $('#Estado_id_estado').val(IdEstado);
//
//         });
//         $.get('" . CController::createUrl('ValidacionJs/BuscarCiudad') . "', {id_estado: IdEstado }, function(data){
//             $('#Personal_id_ciudad_nacimiento').html(data);
//             $('#Personal_id_ciudad_nacimiento').val(IdCiudad);
//
//         });
//
//    });
          
?>
<?php Yii::app()->clientScript->registerScript('personal', "

    $('#Pais_id_pais').change(function(){
        if($(this).val() != 1){
            $('#divEstado').hide();
            $('#divCity').hide();
         $('#Ciudad_id_ciudad_nacimiento').val('falce');
        }else{
            $('#divEstado').show();
            $('#divCity').show();
        }

   });

"); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<div class="row">  


    <div class="col-md-3">
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'nombre DESC';
        echo $form->dropDownListGroup($pais, 'id_pais', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
            'widgetOptions' => array(
                'data' => CHtml::listData(Pais::model()->findAll($criteria), 'id_pais', 'nombre'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarEstados'),
                        'update' => '#' . CHtml::activeId($estado, 'id_estado'),
                    ),
                ),
            )
                )
        );
        ?>
    </div>
    <div id='divEstado' class="col-md-3" style="display: none">
        <?php
        echo $form->dropDownListGroup($estado, 'id_estado', array('wrapperHtmlOptions' => array('class' => 'col-sm-12',),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarCiudad'),
                        'update' => '#' . CHtml::activeId($model, 'id_ciudad_nacimiento'),
                    ),
                    'empty' => 'SELECCIONE',
                ),
            )
                )
        );
        ?>
    </div>
    <div class="col-md-3" id='divCity'style="display: none">
        <?php
        echo $form->dropDownListGroup($model, 'id_ciudad_nacimiento', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar'),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',),)));
        ?>  
    </div>

</div>