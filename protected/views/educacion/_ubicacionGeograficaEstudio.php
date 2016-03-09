<?php // echo $form->errorSummary($model); ?>
<?php
//if (!empty($model->id_ciudad)) {
//    $id_Estado = Ciudad::model()->findByPk($model->id_ciudad)->id_estado; // consulta en la tabla ciudad el id_ciudad y id_estado 
//    $id_pais = Estado::model()->findByPk($id_Estado)->id_pais; // consulta en la tabla estado el id_estado y id_pais  
//} else {
//    $id_pais = '';
//    $id_Estado = '';
//}
?>
<?php Yii::app()->clientScript->registerScript('ubicacion', "
       $(document).ready(function(){
            $('#Educacion_estatus').val('');
            $('#Educacion_registro_titulo').val('');
            IdEducacion = '" . $model->id_nivel_educativo . "';
            Estatus = '" . $model->estatus . "';               
            //$('#Educacion_estatus').val(Estatus);
            //Sector = '" . $model->sector . "'; 
            //$('#Educacion_sector').val(Sector);
            Carrera = '" . $model->id_carrera . "'; 
            $('#Educacion_id_carrera').val(Carrera);
            registro = '" . $model->registro_titulo . "'; 
            titulo= '" . $model->id_titulo . "'; 
            IdCiudad= '" . $model->id_ciudad . "'; 
            //$('#Educacion_registro_titulo').val(registro);
                
            if(IdCiudad == ''){
                $('#divEstado').hide();
                $('#divCity').hide();
                $('#Educacion_id_ciudad').val('');
            }
                 
            $.get( '" . CController::createUrl('ValidacionJs/BuscarTitulo') . "', { id_nivel_educativo: IdEducacion } ).done(function( data ) {
                $('#Educacion_id_titulo').html(data);
                $('#Educacion_id_titulo').val(titulo);
            });
                
      
    
         });
         
             
        $('#Pais_id_pais').change(function(){
            if($(this).val() != 1){
                $('#divEstado').hide();
                $('#divCity').hide();
                $('#Educacion_id_ciudad').val('');
            }else{
                $('#divEstado').show();
                $('#divCity').show();
            }
       });
"); ?>

<div class="row">
    <div class="col-md-4">
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'nombre DESC';
        echo $form->dropDownListGroup($pais, 'id_pais', array('wrapperHtmlOptions' => array('class' => 'col-sm-4 limpiar',),
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
    <div id='divEstado' class="col-md-4">
        <?php
        echo $form->dropDownListGroup($estado, 'id_estado', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar',),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarCiudad'),
                        'update' => '#' . CHtml::activeId($model, 'id_ciudad'),
                    ),
                    'empty' => 'SELECCIONE',
                ),
            )
                )
        );
        ?>
    </div>
    <div class="col-md-4" id='divCity'>
        <?php
        echo $form->dropDownListGroup($model, 'id_ciudad', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar',),
            'widgetOptions' => array(
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                ),
            )
                )
        );
        ?>

    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <label>Sector<span class="required">*</span></label>
        <select id="Educacion_sector" class="form-control limpiar" name="Educacion[sector]" placeholder="Sector">
            <option value="">SELECCIONE</option>
            <option value="P">PRIVADO</option>
            <option value="U">PÚBLICO</option>
            <option value="E">EXTERIOR</option>
        </select>
    </div>
</div>
<div class="row">
    <div class="col-md-12">

        <?php
        echo $form->textAreaGroup(
                $model, 'observaciones', array(
            'wrapperHtmlOptions' => array(
                'class' => 'col-sm-12 limpiar',
            ),
            'widgetOptions' => array(
                'htmlOptions' => array('rows' => 1),
            )
                )
        );
        ?>

    </div>

</div>



