<div style="width: 85%; display: inline-block; float: left">
    <div class="row">
    <div class='col-md-5'>
        <?php
        echo $form->textAreaGroup($accion, 'nombre_accion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
    </div> 

    <div class='col-md-4'>
        <?php
                echo $form->textAreaGroup($accion, 'meta', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
    </div> 
    
    <div class='col-md-3'>
        <?php
                echo $form->textAreaGroup($accion, 'bien_servicio', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
    </div> 
    </div>
    <div class="row">
    <div class='col-md-4'>
        <?php
        echo $form->dropDownListGroup($accion, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '35')), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
        ?>
    </div> 
    
    <div class='col-md-4'>
        <?php
        echo $form->dropDownListGroup($accion, 'fk_ambito', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '46')), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                ),
            )
        ));
        ?>
    </div> 
    
    <div class='col-md-4'>
        <?php
                echo $form->textFieldGroup($accion, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
                echo $form->hiddenField($accion, 'fk_poa', array('value' =>$id_poa ));
        ?>
    </div> 
    </div>
    
</div> 
<div style="width: 10%; display: inline-block; float: right">
    <div style="width: 100%; height: 100%; text-align: center">
        <div onclick="GuardarAccion()" class="ValidationButton"><span class="glyphicon glyphicon-play" style="margin-top: 25%; margin-bottom: 25%;"></span></div>
            

    </div>
</div>
<div style="background-color: #6fa4cd; width: 100%; display: block; float: left; margin-top: 20px; color: #FFF; text-align: center; border-radius: 5px;">
    <h2 style="border-bottom: 1px solid #FFF; width: 90%; margin: 0 auto; margin-bottom: 20px; margin-top: 10px;">Programación de la Acción</h2>
        <?php
            $meses = MaestroPoa::model()->findAllByAttributes(array('padre' => 56));
            foreach ($meses as $data){
        ?>
            <div class="col-md-1">
                <?php
                echo $form->textFieldGroup($programacion, 'cantidad_programada', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar numeric', 'name' => 'Rendimiento[' . $data->id_maestro . ']', 'style' => 'background-color: transparent; border: solid 1px #FFF; box-shadow: none;  color: #FFF; text-align: center;', 'placeholder' => $data->descripcion)), 'label' => $data->descripcion));
                ?>
            </div>
        <?php
            }
        ?>
</div>
