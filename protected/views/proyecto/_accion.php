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
                echo $form->hiddenField($accion, 'fk_proyecto', array('value' =>$id_proyecto ));
        ?>
    </div> 
    </div>
</div> 
<div style="width: 10%; display: inline-block; float: right">
    <div style="width: 100%; height: 100%; cursor: pointer; text-align: center">
        <div onclick="GuardarAccion()" style="width: 100%; height: 100%; background-color: #2282cd; color: #FFF; text-align: center; font-size: 80px; border-radius: 5px;"><span class="glyphicon glyphicon-play" style="margin-top: 25%; margin-bottom: 25%;"></span></div>
            

    </div>
</div>
