<div style="width: 85%; display: inline-block; float: left">
    <div class="row">
    <div class='col-md-5'>
        <?php
        echo $form->textAreaGroup($actividad, 'actividad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar','maxlength'=>800))));
        ?>
    </div> 

    <div class='col-md-3'>
        <?php
        echo $form->dropDownListGroup($actividad, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAllByAttributes(array('padre' => 35, 'es_activo' => TRUE)), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'class' => 'limpiar',
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
        ?>
    </div> 
    
    <div class='col-md-3'>
        <?php
                echo $form->textFieldGroup($actividad, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'readOnly' => true))));
                echo $form->hiddenField($actividad, 'fk_accion', array('value' =>$id_accion ));
        ?>
    </div> 
    </div>
</div> 
<div style="width: 10%; display: inline-block; float: right">
    <div style="width: 100%; height: 100%; text-align: center">

        <div data-toggle="tooltip" title="" rows="1" data-original-title="Agregar Actividad" onclick="GuardarActividad()" class="ValidationButton"><span id="button_save_actividad" class="glyphicon-plus" style="margin-top: 15%; margin-bottom: 15%;"></span></div>
        <div class="button_cancel pull-12" style="margin-top: 5px; display: none;">
        <?php
            $this->widget('booster.widgets.TbButton', array(
                'buttonType' => 'button',
                'size' => 'large',
                'context' => 'danger',
                'label' => $actividad->isNewRecord ? 'Cancelar' : 'Save',
                'htmlOptions' => array(
                  'onclick' => 'cancelar_update()',  
                ),
            ));
        ?>
        </div>


    </div>
</div>
<div style="background-color: #6fa4cd; width: 100%; display: block; float: left; margin-top: 20px; color: #FFF; text-align: center; border-radius: 5px;">
    <h2 style="border-bottom: 1px solid #FFF; width: 90%; margin: 0 auto; margin-bottom: 20px; margin-top: 10px;">Programación de la Actividad</h2>
        <?php
            $meses = MaestroPoa::model()->findAllByAttributes(array('padre' => 56));
            foreach ($meses as $data){
        ?>
            <div class="col-md-1">
                <?php
                echo $form->textFieldGroup($programacion, 'cantidad_programada', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric suma_cantidad', 'name' => 'Rendimiento[' . $data->id_maestro . ']', 'style' => 'background-color: transparent; border: solid 1px #FFF; box-shadow: none; color: #FFF; text-align: center;', 'placeholder' => $data->descripcion)), 'label' => $data->descripcion));
                ?>
            </div>
        <?php
            }
        ?>
</div>
<input type="hidden" name="update_actividad" id="update_actividad" class="limpiar" value="">

    




