<div style="width: 85%; display: inline-block; float: left">
    <div class="row">
    <div class='col-md-5'>
        <?php
        echo $form->textAreaGroup($actividad, 'actividad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
        ?>
    </div> 

    <div class='col-md-3'>
        <?php
        echo $form->dropDownListGroup($actividad, 'fk_unidad_medida', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
            'widgetOptions' => array(
                'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '35')), 'id_maestro', 'descripcion'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE'
                ),
            )
        ));
        ?>
    </div> 
    
    <div class='col-md-3'>
        <?php
                echo $form->textFieldGroup($actividad, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar'))));
                echo $form->hiddenField($actividad, 'fk_accion', array('value' =>$id_accion ));
        ?>
    </div> 
    </div>
</div> 
<div style="width: 10%; display: inline-block; float: right">
    <div style="width: 100%; height: 100%; cursor: pointer; text-align: center">
        <div onclick="GuardarActividad()" style="width: 100%; height: 100%; background-color: #2282cd; color: #FFF; text-align: center; font-size: 80px; border-radius: 5px;"><span class="glyphicon-plus"></span></div>
            

    </div>
</div>
    




