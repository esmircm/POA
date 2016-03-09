
<?php Yii::app()->clientScript->registerScript('educacion', "
    $(document).ready(function(){
        $('#Educacion_id_nivel_educativo option[value=9]').remove();
        $('#Educacion_id_nivel_educativo').val('');
    });

    $('#guardar').click(function(){


        if($('#Educacion_estatus').val() == ''){
            bootbox.alert('Por favor indique el estatus de su nivel academico');
            return false;
        }
        if($('#Educacion_estatus').val() == 'F'){
            if($('#Educacion_anio_fin').val() == ''){
                bootbox.alert('Por favor inidique el año de culminación');
                return false;
            }
//            if($('#Educacion_id_titulo').val() == ''){
//                bootbox.alert('Por favor inidique el titulo obtenido');
//                return false;
//            }
        }
        if($('#Educacion_sector').val() == ''){
            bootbox.alert('Por favor debe seleccionar el sector');
            return false;
        }
        

     if (confirm('¿Está seguro que desea continuar con la actualización?') == false) {//pido una confirmación
               return false;
        }

    });

    $('#Educacion_id_nivel_educativo').change(function(){
        $('#Educacion_estatus').val('');
        $('#Educacion_anio_inicio').val('');
        $('#Educacion_anio_fin').val('');
        $('#Educacion_id_carrera').select2('val', '');
        $('#Educacion_id_titulo').select2('val', '');
        $('#Educacion_registro_titulo').val('');
        $('#Educacion_fecha_registro').val('1969/01/01');
        $('#Educacion_nombre_entidad').val('');
        $('#Educacion_nombre_postgrado').val('');
        $('#Educacion_escala').val('');
        $('#Educacion_calificacion').val('');
        $('#Educacion_mencion').val('');

        $('#divAnoFin').hide();
        $('#divCarrera').hide();
        $('#divTitulo').hide();
        $('#divRegistro').hide();
        $('#divFechaRegistro').hide();

        if($(this).val() == '7'){
            $('#divPostgrado').show();
        }else{
            $('#divPostgrado').hide();
        }
    });

    $('#Educacion_estatus').change(function(){
        var NivelEdicativo = $('#Educacion_id_nivel_educativo').val();
        $('#Educacion_anio_inicio').val('');
        $('#Educacion_anio_fin').val('');
        $('#Educacion_id_carrera').select2('val', '');
        $('#Educacion_id_titulo').select2('val', '');
        $('#Educacion_registro_titulo').val('');
        $('#Educacion_fecha_registro').val('');
        $('#Educacion_nombre_entidad').val('');
        $('#Educacion_nombre_postgrado').val('');
        $('#Educacion_escala').val('');
        $('#Educacion_calificacion').val('');
        $('#Educacion_mencion').val('');
        
        if(NivelEdicativo == ''){
            bootbox.alert('Por favor seleccione el Nivel Educativo');
            return false;
        }else if( (NivelEdicativo == 5) || (NivelEdicativo == 6) ){
            $('#divCarrera').show();
            $('#divTitulo').show();
        }else if( (NivelEdicativo == 11) || (NivelEdicativo == 3) || (NivelEdicativo == 4) ){
            $('#divTitulo').show();
            $('#divFechaRegistro').hide();
        }else{
            $('#divTitulo').hide();
            $('#divCarrera').hide();
        }

        if($(this).val() == 'F' ){
            if( (NivelEdicativo == 2) || ( NivelEdicativo == 1 ) || ( NivelEdicativo == 10  ) || (NivelEdicativo == 11) || (NivelEdicativo == 3) || (NivelEdicativo == 4) ){
                $('#divRegistro').hide();
            }else{
                $('#divRegistro').show();
            }
                $('#divAnoFin').show();
        } else{
            $('#divAnoFin').hide();
            $('#divRegistro').hide();
        }      
    });

    $('#Educacion_registro_titulo').change(function(){
        if ($(this).val() == 'S'){
            $('#divFechaRegistro').show();
            $('#Educacion_fecha_registro').val('');
        }else{
            $('#divFechaRegistro').hide();
            $('#Educacion_fecha_registro').val('1969/01/01');
        }   
    });

"); ?>

<div class="row">


    <div class="col-md-4 ">
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'id_nivel_educativo ASC';
        echo $form->dropDownListGroup($model, 'id_nivel_educativo', array('wrapperHtmlOptions' => array('class' => 'col-sm-4 limpiar',),
            'widgetOptions' => array(
                'data' => CHtml::listData(Niveleducativo::model()->findAll($criteria), 'id_nivel_educativo', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                    'ajax' => array(
                        'type' => 'POST',
                        'url' => CController::createUrl('ValidacionJs/BuscarTitulo'),
                        'update' => '#' . CHtml::activeId($model, 'id_titulo'),
                    ),
                ),
            )
                )
        );
        ?>

    </div>

    
    
    <div class="col-md-4">
        <label>Estatus<span class="required">*</span></label>
        <select id="Educacion_estatus" class="form-control limpiar" name="Educacion[estatus]" placeholder="Estatus">
            <option value="">SELECCIONE</option>
            <option value="F">FINALIZO</option>
            <option value="N">NO TERMINO</option>
            <option value="E">ESTUDIANDO</option>
        </select>
    </div>

    <div class="col-md-4">
        <?php
        echo $form->datePickerGroup($model, 'anio_inicio', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy',
                    'startView' => 1,
                    'minViewMode' => 2,
                    'autoclose' => true,
                ),
                'htmlOptions' => array(
                    'class' => 'span5 limpiar',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
                )
        );
        ?>
    </div>


</div>
<div class="row">
    <div class="col-md-4" id="divAnoFin" style="display: none">
        <?php
        echo $form->datePickerGroup($model, 'anio_fin', array('widgetOptions' =>
            array(
                'options' => array(
                    'language' => 'es',
                    'format' => 'yyyy',
                    'startView' => 1,
                    'minViewMode' => 2,
                    'autoclose' => true,
                ),
                'htmlOptions' => array(
                    'class' => 'span5 limpiar',
                    'readonly' => true,
                ),
            ),
            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
            'beforeShowDay' => 'DisableDays',
                )
        );
        ?>

    </div>



    <div class="col-md-4" id="divCarrera" style="display: none">
        <?php echo $form->labelEx($model, 'id_carrera'); ?>
        <?php
        $this->widget(
                'booster.widgets.TbSelect2', array(
            'name' => CHtml::activeId($model, 'id_carrera'),
            'attribute' => 'id_carrera',
            'data' => Carrera::FindBuscarCarreraByPadreSelect('nombre DESC'),
            'htmlOptions' => array(
                'style' => 'width: 100%',
                'placeholder' => 'Seleccione la carrera',
                'multiple' => false,
                'id' => CHtml::activeId($model, 'id_carrera'),
            ),
                )
        );
        ?>
    </div>


    <div class="col-md-4" id="divTitulo" style="display: none">
        <?php echo $form->labelEx($model, 'id_titulo'); ?>
        <?php
        $this->widget(
                'booster.widgets.TbSelect2', array(
            'name' => CHtml::activeId($model, 'id_titulo'),
            'attribute' => 'id_carrera',
            //'data' => Carrera::FindBuscarCarreraByPadreSelect('nombre DESC'),
            'htmlOptions' => array(
                'style' => 'width: 100%',
                'placeholder' => 'Seleccione la carrera',
                'multiple' => false,
                'id' => CHtml::activeId($model, 'id_titulo'),
            ),
                )
        );
        ?>

    </div>
</div>

<div class="row">

    <div class="col-md-4" id="divRegistro" style="display: none">
        <label>Registró Titulo<span></span></label>
        <select id="Educacion_registro_titulo" class="form-control limpiar" name="Educacion[registro_titulo]" placeholder="Registró Titulo">
            <option value="">SELECCIONE</option>
            <option value="S">SI</option>
            <option value="N">NO</option>

        </select>
    </div>

    <div class="col-md-4" id="divFechaRegistro" style="display: none">

        <?php
        echo $form->datePickerGroup($model, 'fecha_registro', array('widgetOptions' =>
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

        <?php // echo $form->datePickerGroup($model, 'fecha_registro', array('widgetOptions' => array('options' => array(), 'htmlOptions' => array('class' => 'span5')), 'prepend' => '<i class="glyphicon glyphicon-calendar"></i>', 'append' => ''));  ?>
    </div>

    <div class="col-md-4" id="divEntidad">
        <?php echo $form->textFieldGroup($model, 'nombre_entidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span6 limpiar', )))); ?>
    </div>
</div>

<div class="row">
    <div class="col-md-4" id="divPostgrado" style="display: none">
        <?php echo $form->textFieldGroup($model, 'nombre_postgrado', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 90)))); ?>
    </div>

    <div class="col-md-2" id="divEscala" style="display: block">
        <?php echo $form->textFieldGroup($model, 'escala', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 3)))); ?>
    </div>

    <div class="col-md-2" id="divCalificacion">
        <?php echo $form->textFieldGroup($model, 'calificacion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5  limpiar', 'maxlength' => 3)))); ?>
    </div>


    <div class="col-md-4" id="divMencion">
        <?php echo $form->textFieldGroup($model, 'mencion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 25)))); ?>
    </div>
</div>



